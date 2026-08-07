# Biology Ch8: The Immune System . Verification Report

**Batch 1 of 4: 22 questions (innate immunity).**
Chapter target is **90 questions**, not the usual 100. Reference text:
`reference-textbooks/biology/openstax-anatomy-physiology-2e.txt` (cited as AP:line).
Scope authority: `reference-textbooks/aamc/aamc-content-outline-2026.txt`.
All questions: Foundation 3B . content category "Organ Systems" . discipline biology.

## Why 90 and not 100

The AAMC outline names only twelve immune items (innate vs adaptive; T lymphocytes; B lymphocytes;
macrophages; phagocytes; bone marrow, spleen, thymus, lymph nodes; antigen and antibody; antigen
presentation; clonal selection; antigen-antibody recognition; antibody structure; self vs nonself and
autoimmune disease; MHC) plus five lymphatic bullets. Large parts of the commercial chapter are
already owned by other chapters of this bank, so padding to 100 would have forced either off-outline
content or duplication.

## Scope convention (founder decision)

Entities the outline does **not** name are described **functionally** and are never required as
recalled vocabulary. Not named anywhere in the outline: complement, interferon, natural killer cells,
dendritic cells, neutrophils, eosinophils, basophils, mast cells, plasma cells, CD4, CD8, helper /
cytotoxic / regulatory T cells, immunoglobulin isotypes, opsonisation, agglutination, memory cells,
allergy, vaccination, GALT, tonsils, adenoids, leukocyte.

Batch 1 therefore writes, for example, "a plasma fraction whose channel-forming proteins assemble
slowly on any foreign surface" rather than naming complement, and "a signal released by an infected
cell that renders nearby cells resistant to many viruses" rather than naming interferon. The
discriminator in every item is an outline-named principle. Students meet the standard vocabulary in
the Ch8 flashcard deck, which is not scope-bound in the same way.

## Chapter boundaries enforced (automated scan: zero hits)

| Territory | Owner |
|---|---|
| lysozyme, defensins, mucus and cilia, secretory antibody at mucosa, alveolar macrophages, nasal hairs | Bio Ch6 Respiratory |
| thoracic duct, chylomicrons, lacteals, subclavian return, lymph-volume arithmetic, oedema, diapedesis, granulocyte morphology, differential counts, spleen as red-cell filter, red-cell agglutination, titre tables | Bio Ch7 Cardiovascular |
| antibody domain architecture, opsonisation, agglutination as protein topics | Biochem Ch3 |
| phagolysosome chemistry, viral structure, gram envelope | Bio Ch1 |
| placental transfer of maternal antibody | Bio Ch3 Embryology |
| thymus framed as an endocrine organ | Bio Ch5 Endocrine |
| multiple sclerosis, type 1 diabetes | Bio Ch4 / Ch5 |

## Batch 1 summary

| Metric | Result | Target |
|---|---|---|
| Difficulty | easy 6 . hard 5 . medium 11 | 27/40/33 |
| Answer letter | A 8 . B 5 . C 5 . D 4 | ~25% each |
| Cognitive skill | S2 16 . S3 2 . S4 4 | mixed |
| Confidence | conf4 1 . conf5 21 | only 4-5 ship |
| Topic axis | easy 7 . hard 1 . medium 14 | . |
| Structural axis | easy 6 . hard 5 . medium 11 | . |
| Distractor categories | adjacent_fact 10 . misconception 22 . partial_truth 12 . process_step_confusion 12 . reversed_relationship 9 . scale_unit_error 1 | none >40% |
| Roman numeral | 1 (5%) | 10-15% |
| Em/en dashes | 0 | 0 |

**Deficits carried into batches 2-4:** answer letter A at 36% and D at 18%, hard tier at 23% against
a 33% target, Roman numeral at 5%, and no skill 1 items. Later batches are given explicit target
**counts** per letter rather than a direction, after a Ch7 batch overshot twice when told simply to
"bias toward D".

**Unit plan for the chapter (90 questions):** barriers 5 . plasma cascade and antiviral signalling 8 .
innate cells and inflammation 9 . MHC 12 . T lymphocytes 12 . B lymphocytes and antibody 13 .
immunological memory 9 . lymphoid tissue 12 . hypersensitivity and tolerance 10.
Batches: 22 / 24 / 22 / 22.

**Adversarial audit:** every question was re-examined by an independent pass that re-greped each
citation against the source file.

---

## Q1 . Skin as a Physical Barrier

**Stem.** An investigator applies a suspension of a harmless soil bacterium to a volunteer's intact forearm skin and to an adjacent patch where the outermost dead cell layer has been scraped away. Viable bacterial counts in the underlying tissue rise only at the scraped patch. The outcome at the intact patch is most likely explained by which of the following?

- **A.** The layer acts against the applied cells only after a previous encounter with that species.
- **B.** The layer acts against the applied cells more effectively with each successive application.
- **C.** The layer acts against the applied cells without regard to previous encounters.  <- **KEY**
- **D.** The layer acts against the applied cells by way of phagocytes in the tissue below.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): The layer acts against the applied cells without regard to previous encounters.**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:30762-30763 'The topmost layer of skin, the epidermis, consists of cells that are packed with keratin. These dead cells remain as a tightly connected, dense layer of protein-filled cell husks on the surface of the skin.' (verified) | MICRO:30647-30650 'These defenses are described as nonspecific because they do not target any specific pathogen; rather, they defend against a wide range of potential pathogens. They are called innate because they are built-in mechanisms of the human organism. Unlike the specific adaptive defenses, they are not acquired over time and they have no memory (they do not improve after repeated exposures to specific pathogens).' (verified; the source prints the word memory inside quotation marks) | MICRO:30770-30771 'Infections can occur when the skin barrier is compromised or broken. A wound can serve as a point of entry for opportunistic pathogens' (verified) | MICRO:30723-30724 'Physical defenses provide the body's most basic form of nonspecific defense. They include physical barriers to microbes, such as the skin and mucous membranes' (verified) | MICRO:32860-32861 'Macrophages and dendritic cells are phagocytes that ingest and kill pathogens that penetrate the first-line barriers (i.e., skin and mucous membranes).' (verified)

**Distractors**

- **(A)** `misconception` . _specificity transplanted onto a structural barrier_: A layer of keratinized dead cell husks has no receptors and cannot compare an organism with anything met earlier, so its action cannot be conditional on a prior encounter; that conditionality belongs to the lymphocyte-based arm.
  - Citation: MICRO:30647-30648 'These defenses are described as nonspecific because they do not target any specific pathogen; rather, they defend against a wide range of potential pathogens.' (verified)
- **(B)** `misconception` . _memory attributed to a built-in defense_: Built-in defenses are not acquired over time and do not improve after repeated exposures, so a structural covering cannot become progressively better at handling one species.
  - Citation: MICRO:30649-30650 'Unlike the specific adaptive defenses, they are not acquired over time and they have no memory (they do not improve after repeated exposures to specific pathogens).' (verified; the source prints the word memory inside quotation marks)
- **(D)** `process_step_confusion` . _post-entry clearance offered as the mechanism of surface exclusion_: Phagocytes ingest organisms that have already penetrated the first-line barriers, so they act after entry; the scraped patch overlay the same tissue and the same available phagocytes yet showed rising counts, so tissue-level cells cannot explain the difference between the sites.
  - Citation: MICRO:32860-32861 'Macrophages and dendritic cells are phagocytes that ingest and kill pathogens that penetrate the first-line barriers (i.e., skin and mucous membranes).' (verified)

**Readback check.** Content words of the key: layer, acts against, applied cells, without regard, previous encounters. The stem contains 'layer' and 'applied', which appear identically in all four options and are shared referents. The discriminating phrase 'without regard to previous encounters' appears nowhere in the stem, and the stem never states that this is a first exposure or that the defense is nonspecific. No definition-to-name, no restated premise, no self-justifying key. CHANGED IN AUDIT: (1) Option D was 'It excludes the applied cells by delivering them to lymphocytes residing beneath it', which was logically self-defeating (delivering cells inward cannot be a means of exclusion) and so was eliminable without topic knowledge; it also invited elimination by the bare specificity heuristic. It is replaced by a phagocyte-based process-step confusion that is textbook-supported and requires knowing that phagocytes act after penetration of the first-line barriers. (2) The original explanation asserted 'exclusion occurred on the very first application' and 'an organism the volunteer has never met', but the stem never establishes the volunteer's prior-exposure status; that unsupported clause is removed and the reasoning now runs from the structural basis of the layer and from the textbook statement that innate defenses do not target specific pathogens. (3) The original explanation's claim that 'Skin does contain resident lymphocytes and antigen-sampling cells' was supported by none of the cited lines and is deleted. (4) Options re-parallelized so the key is the shortest rather than tied for longest. (5) Citation MICRO:30648-30650 corrected to 30647-30650 (the sentence begins on line 30647); citation MICRO:30727-30729 was misnumbered and pointed at the microbiome paragraph rather than the Physical Barriers paragraph, and is replaced by the verified MICRO:32860-32861; MICRO:30770 extended to 30770-30771, where the quoted sentence actually ends.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the outer keratinized layer stops the applied cells on structural grounds that cannot vary with what the volunteer has met before. The topmost layer of the epidermis is a tightly connected, dense sheet of dead, keratin-filled cell husks, and a sheet of dead cells carries no receptors and therefore no capacity to distinguish one organism from another. Defenses built into the tissue in this way do not target any specific organism; they act against a wide range of them. Removing that sheet by scraping was the only variable that differed between the two patches, and removing it was sufficient to let viable counts rise in the tissue below. The exclusion measured at the intact patch is therefore a mechanical outcome rather than a recognition-dependent one. (Choice A) This makes surface exclusion conditional on a prior encounter, which imports the behavior of the lymphocyte-based arm into a structure that has no recognition machinery. A layer of dead keratin-filled husks cannot sample an organism or compare it with anything met earlier. Defenses of this kind are described as nonspecific precisely because they do not target any particular organism. (Choice B) This assigns progressive improvement to a structure. Built-in defenses are not acquired over time and do not improve after repeated exposures, so a sheet of dead cells cannot become better at handling one organism. The single application described also provides no repeated measurements from which such a trend could be read. (Choice C) The layer denies entry by physical construction, so its performance does not depend on what the volunteer has met before. Scraping it away removed the only variable that differed between the patches, which is why counts rose there and not at the intact site. (Choice D) Phagocytes ingest and kill organisms that have already penetrated the first-line barriers, so their action is a step that follows entry rather than a means of preventing it. The scraped patch sat over the same tissue and therefore the same available phagocytes, yet counts rose there, so cells in the tissue below cannot be what distinguished the two sites. Attributing the intact-patch result to them confuses clearance after entry with exclusion at the surface. This is a Scientific Reasoning and Problem Solving question because you must infer, from the difference between an intact and a scraped skin surface, which category of defense produced the outcome.

---

## Q2 . Gastric Acid as a Chemical Barrier

**Stem.** A volunteer takes a medication that raises the pH of stomach fluid from about \( 2 \) to about \( 6 \). In a standardized challenge with an acid-sensitive bacterial species, the number of viable cells recovered from the small intestine rises roughly one hundredfold. Which additional outcome is most likely while the volunteer continues taking the medication?

- **A.** Recovery of a second, unrelated acid-sensitive species also rises.  <- **KEY**
- **B.** Recovery rises only for acid-sensitive species the volunteer previously ingested.
- **C.** Recovery of the acid-sensitive species falls to baseline within hours as specific antibody appears.
- **D.** Recovery of the acid-sensitive species falls to baseline over repeated challenges.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (A): Recovery of a second, unrelated acid-sensitive species also rises.**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:31005 'In the stomach, highly acidic gastric fluid kills most microbes.' (verified) | MICRO:44053-44055 'The stomach is an extremely acidic environment (pH 1.5 to 3.5) due to the gastric juices that break down food and kill many ingested microbes; this helps prevent infection from pathogens.' (verified; the printed pH range uses an en dash in the source and is normalized here to the word 'to') | MICRO:31007-31008 'Together, these mediators are able to eliminate most pathogens that manage to survive the acidic environment of the stomach.' (verified) | MICRO:32498-32500 'Adaptive immunity is defined by two important characteristics: specificity and memory. Specificity refers to the adaptive immune system's ability to target specific pathogens, and memory refers to its ability to quickly respond to pathogens to which it has previously been exposed.' (verified) | MICRO:33504-33505 'The initial stage of the primary response is a lag period, or latent period, of approximately 10 days, during which no antibody can be detected in serum.' (verified)

**Distractors**

- **(B)** `misconception` . _specificity imposed on a chemical barrier_: Gastric acidity kills on chemical grounds and cannot restrict its effect to organisms the volunteer has swallowed before; that conditional behavior is the defining property of the specific arm.
  - Citation: MICRO:32498-32500 'Adaptive immunity is defined by two important characteristics: specificity and memory. Specificity refers to the adaptive immune system's ability to target specific pathogens, and memory refers to its ability to quickly respond to pathogens to which it has previously been exposed.' (verified)
- **(C)** `scale_unit_error` . _adaptive timeline compressed from days to hours_: Specific antibody is undetectable in serum for roughly ten days after a first encounter, so none could act within hours, and antibody would not restore gastric acidity in any case.
  - Citation: MICRO:33504-33505 'The initial stage of the primary response is a lag period, or latent period, of approximately 10 days, during which no antibody can be detected in serum.' (verified)
- **(D)** `misconception` . _memory attributed to a chemical barrier_: A chemical barrier does not improve with repeated challenge, and the medication continues to hold the pH near \( 6 \), so nothing in the scenario would drive recovery back toward baseline.
  - Citation: MICRO:30649-30650 'Unlike the specific adaptive defenses, they are not acquired over time and they have no memory (they do not improve after repeated exposures to specific pathogens).' (verified; the source prints the word memory inside quotation marks)

**Readback check.** Content words of the key: recovery, second, unrelated, acid-sensitive, species, also rises. The stem contains 'recovered', 'viable cells', 'acid-sensitive' and 'species'. 'Acid-sensitive' is now written into all four options, so it is a shared referent rather than a distinctive marker of the key. The discriminating words 'second' and 'unrelated' appear nowhere in the stem, and the stem never says the barrier is nonspecific or that it acts broadly. No definition-to-name, no restated premise. CHANGED IN AUDIT: (1) The original key read 'Cells of an unrelated ingested species are also recovered in greater numbers', which was over-broad and therefore not unambiguously correct: an unrelated species that is acid-resistant would not rise at all, so a strong student could defensibly reject the key. The acid-sensitivity qualifier is now stated. (2) To keep that qualifier from becoming a stem echo pointing at the key, 'acid-sensitive' was written into all four options, and the options were re-parallelized under a common 'Recovery ...' frame. (3) The key is now the shortest option; previously the qualifier would have made it the longest, violating the key-length rule. (4) Citation MICRO:44054 corrected to 44053-44055 (the sentence begins on line 44053).

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the defense the medication removed acts on a chemical property shared by many ingested organisms rather than on features unique to one species. Highly acidic gastric fluid kills most ingested microbes, and that killing depends on the hydrogen ion concentration of the fluid rather than on any recognition of the organism. Raising the pH from about \( 2 \) to about \( 6 \) lowers the hydrogen ion concentration roughly ten thousandfold, so any swallowed organism with the same acid sensitivity gains the same reprieve. A second, structurally unrelated organism of that kind should therefore also be recovered in greater numbers. Defenses of the specific arm behave in the opposite way, because they are directed at one organism and leave others untouched. (Choice A) The barrier that was weakened is chemical and undiscriminating, so the benefit extends to any swallowed organism with the same acid sensitivity, including one structurally unrelated to the challenge species. Nothing about raising the pH restricts the effect to the organism used in the challenge. (Choice B) This restricts the effect to organisms swallowed before, which is the behavior of the specific arm rather than of gastric fluid. Adaptive immunity is defined by specificity and memory, and gastric acidity has neither property. An organism swallowed for the first time benefits from the raised pH exactly as a familiar one does. (Choice C) Specific antibody is not detectable in serum until roughly \( 10 \) days after a first encounter, so no such antibody could act within hours. Even if antibody were present, it would not restore the acidity of gastric fluid, which is the variable the medication changed. The timescale in this option is off by orders of magnitude. (Choice D) A chemical barrier does not strengthen with repetition, so recovery would not decline challenge by challenge while the medication continues to hold the pH near \( 6 \). Improvement on re-exposure is a property of the specific arm. The manipulated variable here is gastric acidity, which repeated challenges do not restore. This is a Scientific Reasoning and Problem Solving question because you must predict how loss of an undiscriminating chemical barrier affects a second, unrelated ingested organism.

---

## Q3 . Colonization Resistance by Resident Flora

**Stem.** A broad-spectrum antimicrobial course reduces the resident bacterial population of a volunteer's large intestine by roughly \( 99\% \). Over the following week, a drug-resistant species that had been present at low numbers becomes the dominant organism, and no antibody specific for that species is detectable before or after treatment. Which of the following most likely explains its expansion?

- **A.** The antimicrobial directly stimulated division of the resistant species.
- **B.** The depleted residents had been presenting antigen to lymphocytes.
- **C.** The depleted residents had sustained a memory response against the species.
- **D.** The depleted residents had occupied binding sites and consumed nutrients.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (D): The depleted residents had occupied binding sites and consumed nutrients.**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:30910-30912 'In various regions of the body, resident microbiota serve as an important first-line defense against invading pathogens. Through their occupation of cellular binding sites and competition for available nutrients, the resident microbiota prevent the critical early steps of pathogen attachment and proliferation required for the establishment of an infection.' (verified) | MICRO:30925-30927 'Treatment with antibiotics can significantly deplete the normal microbiota of the gastrointestinal tract, providing an advantage for pathogenic bacteria to colonize and cause diarrheal infection.' (verified) | MICRO:30725-30727 'In addition, the microbiome provides a measure of physical protection against disease, as microbes of the normal microbiota compete with pathogens for nutrients and cellular binding sites necessary to cause infection.' (verified) | MICRO:32498-32499 'Adaptive immunity is defined by two important characteristics: specificity and memory.' (verified) | MICRO:33504-33505 'The initial stage of the primary response is a lag period, or latent period, of approximately 10 days, during which no antibody can be detected in serum.' (verified)

**Distractors**

- **(A)** `reversed_relationship` . _drug recast as a growth stimulus rather than as a remover of competitors_: An antimicrobial agent suppresses susceptible cells; resistance means the species is unaffected by it, not driven to divide by it, so the expansion must come from release of competition rather than from any positive drug effect.
  - Citation: MICRO:30925-30927 'Treatment with antibiotics can significantly deplete the normal microbiota of the gastrointestinal tract, providing an advantage for pathogenic bacteria to colonize and cause diarrheal infection.' (verified)
- **(B)** `process_step_confusion` . _antigen handling substituted for ecological competition_: Resident bacteria in the lumen are not the host cells that display antigen to lymphocytes, and the stem states that no specific antibody against the expanding species exists at any time point, so the specific arm was never involved.
  - Citation: MICRO:30911-30912 'Through their occupation of cellular binding sites and competition for available nutrients, the resident microbiota prevent the critical early steps of pathogen attachment and proliferation' (verified)
- **(C)** `misconception` . _a specific memory response invented where the data exclude one_: No specific antibody against the expanding species is detectable either before or after treatment, so there was no established specific response for the residents to sustain or for their loss to end.
  - Citation: MICRO:32498-32499 'Adaptive immunity is defined by two important characteristics: specificity and memory.' (verified)

**Readback check.** Content words of the key: depleted, residents, occupied, binding sites, consumed, nutrients. The stem contains 'resident bacterial population', and 'residents' appears identically in Choices B, C and D, so it is a shared referent. The discriminating words 'binding sites', 'occupied', 'consumed' and 'nutrients' appear nowhere in the stem, which supplies only measurements and never the competitive mechanism. No definition-to-name, no only-real-option, and the key is not self-justifying. CHANGED IN AUDIT: (1) The original key, 'Loss of the residents freed attachment sites and nutrients the resistant species can use', was the LONGEST option, violating the key-length rule; all four options are rewritten under a parallel frame and the key is now among the shortest. (2) The original Choice A, 'The antimicrobial promoted growth of the resistant species while killing the residents', was partly defensible as a coarse restatement of the key, since removing competitors is one way a drug can be said to promote growth; it is replaced by an unambiguous direct-stimulation claim that does not overlap the key. (3) The original explanation for Choice B claimed that loss of antigen display 'would not by itself allow a species to expand a hundredfold', but no hundredfold figure appears anywhere in the stem; that fabricated number is removed. (4) Options 1 and 4 previously shared the opening 'Loss of the residents' with only two others, leaving Choice A structurally isolated; all four now follow one frame.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the resident population had been holding the resistant species down by occupying the surfaces it needs and consuming the nutrients it requires. Resident organisms act as a first-line defense through their occupation of cellular binding sites and their competition for available nutrients, which blocks the early attachment and proliferation steps a newcomer must complete in order to establish itself. Removing \( 99\% \) of that population releases both the surface real estate and the nutrient supply, and the resistant species is by definition still present and still viable. The stated absence of specific antibody at every time point rules out any explanation routed through the specific arm. What changed was the competitive environment, not the state of any lymphocyte population. (Choice A) An antimicrobial agent inhibits or kills susceptible cells, and being unaffected by such an agent is not the same as being driven to divide by it. Nothing in the scenario supplies a growth signal to the resistant species. Its expansion followed the removal of its competitors rather than any positive action of the drug upon it. (Choice B) Resident bacteria in the intestinal lumen are not the host cells that display antigen to lymphocytes, so depleting them does not remove antigen presentation. The scenario also states that no antibody specific for the expanding species is detectable at any point, so the specific arm was never engaged against it. This substitutes an antigen-handling step for an ecological one. (Choice C) There is no specific response against this species to lose, because no specific antibody is detectable before or after treatment. Resident organisms compete with newcomers for binding sites and nutrients rather than maintaining a programmed response against them. The suppression that was lifted was competitive rather than lymphocyte-based. (Choice D) With the competing population reduced by \( 99\% \), binding sites and nutrients that had been unavailable become accessible, permitting the attachment and proliferation steps that were previously blocked. This mechanism requires no prior encounter and no specific antibody, which matches every measurement given. This is a Scientific Reasoning and Problem Solving question because you must use the absence of a specific antibody response to select the mechanism that accounts for a resistant organism overgrowing a depleted resident population.

---

## Q4 . Defence Timeline After a Breach

**Stem.** Two volunteers receive identical small puncture wounds that introduce the same bacterial species, which neither has encountered before, and volunteer 2 has no functional lymphocytes. In volunteer 1, phagocytes accumulate at the wound within \( 6 \) hours and serum antibody specific for that species appears at about day \( 10 \). Compared with volunteer 1, volunteer 2 most likely shows which pattern?

- **A.** No phagocyte accumulation at \( 6 \) hours and no specific antibody at day \( 10 \).
- **B.** Phagocyte accumulation at \( 6 \) hours and no specific antibody at day \( 10 \).  <- **KEY**
- **C.** Phagocyte accumulation near day \( 10 \) and specific antibody at day \( 10 \).
- **D.** Phagocyte accumulation at \( 6 \) hours and specific antibody before day \( 10 \).

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): Phagocyte accumulation at \( 6 \) hours and no specific antibody at day \( 10 \).**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:30770-30771 'Infections can occur when the skin barrier is compromised or broken. A wound can serve as a point of entry for opportunistic pathogens' (verified) | MICRO:30655-30656 'Broadly speaking, nonspecific innate defenses provide an immediate (or very rapid) response against potential pathogens.' (verified; the draft's line reference 30659-30660 was wrong) | MICRO:31692-31693 'phagocytes provide a strong, swift, and effective defense against a broad range of microbes, making them a critical component of innate nonspecific immunity' (verified) | MICRO:32515-32516 'B cells mature in the bone marrow and are responsible for the production of glycoproteins called antibodies, or immunoglobulins.' (verified) | MICRO:33504-33505 'The initial stage of the primary response is a lag period, or latent period, of approximately 10 days, during which no antibody can be detected in serum.' (verified)

**Distractors**

- **(A)** `misconception` . _the rapid arm treated as lymphocyte-dependent_: Phagocyte recruitment to a breached surface belongs to innate nonspecific immunity and does not require lymphocytes, so it should still occur at \( 6 \) hours in volunteer 2.
  - Citation: MICRO:31692-31693 'phagocytes provide a strong, swift, and effective defense against a broad range of microbes, making them a critical component of innate nonspecific immunity' (verified)
- **(C)** `process_step_confusion` . _the two arms forced onto a single timeline_: It delays the lymphocyte-independent phagocyte response to the timing of the specific response and simultaneously grants specific antibody to a volunteer with no functional lymphocytes, contradicting both the independence of the arms and the stated defect.
  - Citation: MICRO:32515-32516 'B cells mature in the bone marrow and are responsible for the production of glycoproteins called antibodies, or immunoglobulins.' (verified)
- **(D)** `reversed_relationship` . _removing lymphocytes made to accelerate the specific response_: A first encounter carries a lag of roughly ten days even with intact lymphocytes, and removing them cannot make specific antibody appear sooner; it should not appear at all.
  - Citation: MICRO:33504-33505 'The initial stage of the primary response is a lag period, or latent period, of approximately 10 days, during which no antibody can be detected in serum.' (verified)

**Readback check.** Content words of the key: phagocyte accumulation, \( 6 \) hours, specific antibody, day \( 10 \). Every one of these terms and numbers appears in the stem, but all four options are permutations of that identical vocabulary, so they function as shared referents equally necessary to all four rather than as a distinctive echo of the key. The discriminator is the combination (rapid arm preserved, specific arm absent), and the stem never states which arm depends on lymphocytes. No definition-to-name, no restated premise, and the key is not the only scientifically coherent option. CHANGED IN AUDIT: (1) The citation for 'Broadly speaking, nonspecific innate defenses provide an immediate (or very rapid) response against potential pathogens' was given as MICRO:30659-30660; the sentence actually sits at MICRO:30655-30656, so it was a misnumbered citation and is corrected. (2) The explanation's claim that phagocyte recruitment is lymphocyte-independent rested on a rapidity quotation alone; a direct citation, MICRO:31692-31693, establishing phagocytes as a critical component of innate nonspecific immunity, is added and the main reasoning is reworded to lean on it. Otherwise unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because phagocyte recruitment to a breached surface proceeds without lymphocytes, whereas the appearance of specific antibody does not. A puncture through the skin creates a point of entry, and phagocytes provide a swift, effective defense against a broad range of microbes as a critical component of innate nonspecific immunity, so their accumulation does not wait on any lymphocyte. Antibody directed at one particular species is produced by B lymphocytes, and the first specific antibody is not measurable in serum until roughly \( 10 \) days after a first encounter. A volunteer lacking functional lymphocytes therefore keeps the hours-scale phagocyte response but cannot generate the day-scale specific one. Sorting the two measurements by their cellular requirement is what the comparison asks for. (Choice A) Losing phagocyte accumulation as well would require a defect in the rapid arm, which the scenario does not specify. Phagocytes are recruited to a breached surface independently of lymphocytes, so their arrival at \( 6 \) hours should be preserved in volunteer 2. Only the lymphocyte-dependent output is expected to fail. (Choice B) The hours-scale phagocyte response is intact because it does not require lymphocytes, while specific antibody cannot appear because the cells that produce it are absent. This is exactly the dissociation the two-volunteer comparison is built to reveal. (Choice C) Delaying phagocyte arrival to day \( 10 \) ties the rapid arm to the timing of the specific arm, but the rapid arm is the faster one precisely because it needs no prior encounter and no lymphocyte. This option also grants specific antibody to a volunteer with no functional lymphocytes, contradicting the stated defect. Both halves of the pattern are inconsistent with the scenario. (Choice D) Antibody appearing earlier than day \( 10 \) would mean a faster specific response, which is the opposite of what removing lymphocytes produces. A first encounter carries a lag of roughly \( 10 \) days even when lymphocytes are fully functional. Volunteer 2 should show no specific antibody at all. This is a Scientific Reasoning and Problem Solving question because you must separate which measured outcome after a barrier breach depends on lymphocytes and which does not.

---

## Q5 . Layered Surface Defences and Response Timing

**Stem.** A standardized suspension of a bacterial species is applied to three skin sites on one volunteer: intact skin, abraded skin, and abraded skin from which resident surface organisms were first removed by a treatment that leaves host cells intact. Viable counts in the underlying tissue at \( 4 \) hours are lowest at the intact site, intermediate at the abraded site, and highest at the abraded and cleared site, while serum antibody specific for the applied species is first detected on day \( 11 \). Which conclusion do these results best support?

- **A.** Two separate defenses limited entry at \( 4 \) hours, and neither required the response detected on day \( 11 \).  <- **KEY**
- **B.** Two separate defenses limited entry at \( 4 \) hours, and both were strengthened by the response detected on day \( 11 \).
- **C.** Two separate defenses limited entry at \( 4 \) hours, and both acted by engaging lymphocytes at the site.
- **D.** One defense limited entry at \( 4 \) hours, and its strength was set by the response detected on day \( 11 \).

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 120 s |
| Confidence | 5 |
| Hard-tier gate | Meets three of the four conditions. (1) CONCEPT CHAINING: the student must combine the barrier function of the outer skin layer, the exclusion effect of resident surface organisms, and the timescale separating the two arms of defense before the options can be sorted. (2) DATA-TO-MECHANISM: the three-site count gradient must be converted into a claim about how many removable defenses exist, using the fact that each pairwise comparison isolates exactly one manipulated variable. (3) TRUE PARTIAL-TRUTH TRAP: Choice B gets the number of defenses exactly right and states a relationship that is genuinely true over longer timescales, failing only on the timing the data impose. Condition (4) 510-TEMPTING DISTRACTOR is also satisfied by Choice B, though it is not counted separately from (3) since it rests on the same option; conditions (1) and (2) alone clear the gate. |

**Correct answer (A): Two separate defenses limited entry at \( 4 \) hours, and neither required the response detected on day \( 11 \).**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:30762-30764 'The topmost layer of skin, the epidermis, consists of cells that are packed with keratin. These dead cells remain as a tightly connected, dense layer of protein-filled cell husks on the surface of the skin.' (verified; the following sentence at line 30764 adds that the keratin makes the surface mechanically tough and resistant to degradation by bacterial enzymes) | MICRO:30770-30771 'Infections can occur when the skin barrier is compromised or broken. A wound can serve as a point of entry for opportunistic pathogens' (verified) | MICRO:30910-30912 'In various regions of the body, resident microbiota serve as an important first-line defense against invading pathogens. Through their occupation of cellular binding sites and competition for available nutrients, the resident microbiota prevent the critical early steps of pathogen attachment and proliferation required for the establishment of an infection.' (verified) | MICRO:30920 'microbiota and potential pathogens on the skin, in the upper respiratory tract, and in the gastrointestinal tract' (verified; establishes that resident organisms compete with newcomers on the skin specifically) | MICRO:30655-30656 'Broadly speaking, nonspecific innate defenses provide an immediate (or very rapid) response against potential pathogens.' (verified; the draft's line reference 30659-30660 was wrong) | MICRO:33504-33505 'The initial stage of the primary response is a lag period, or latent period, of approximately 10 days, during which no antibody can be detected in serum.' (verified)

**Distractors**

- **(B)** `partial_truth` . _correct count of defenses, impossible timing_: It correctly reads two removable defenses from the gradient, but the counts were taken at \( 4 \) hours and specific antibody was not detected until day \( 11 \), so a response that did not yet exist cannot have strengthened what was measured.
  - Citation: MICRO:33504-33505 'The initial stage of the primary response is a lag period, or latent period, of approximately 10 days, during which no antibody can be detected in serum.' (verified)
- **(C)** `process_step_confusion` . _surface exclusion recast as lymphocyte recruitment_: A keratinized dead-cell layer excludes by physical construction and resident organisms exclude by occupying binding sites and competing for nutrients; neither works by bringing lymphocytes to the site, and lymphocyte engagement is a step that follows entry.
  - Citation: MICRO:30911-30912 'Through their occupation of cellular binding sites and competition for available nutrients, the resident microbiota prevent the critical early steps of pathogen attachment and proliferation' (verified)
- **(D)** `reversed_relationship` . _a later response made to set an earlier outcome_: Three distinct count levels arising from two independent manipulations cannot come from a single defense, and attributing the \( 4 \) hour result to a response first detected on day \( 11 \) inverts the order of events.
  - Citation: MICRO:30762-30763 'The topmost layer of skin, the epidermis, consists of cells that are packed with keratin. These dead cells remain as a tightly connected, dense layer of protein-filled cell husks on the surface of the skin.' (verified)

**Readback check.** Content words of the key: two, separate defenses, limited entry, \( 4 \) hours, neither required, response, detected, day \( 11 \). The stem contains '\( 4 \) hours' and 'day \( 11 \)', which appear identically across the options and are necessary to state any conclusion about the data. The discriminating phrase 'neither required the response' appears nowhere in the stem, and the stem never states how many defenses exist, never uses the words nonspecific, innate, specific or adaptive, and never asserts independence between the arms. No definition-to-name, no restated premise, no self-justifying key, and Choices B, C and D each describe real immunological relationships. CHANGED IN AUDIT: (1) The citation for 'Broadly speaking, nonspecific innate defenses provide an immediate (or very rapid) response against potential pathogens' was given as MICRO:30659-30660; it actually sits at MICRO:30655-30656 and is corrected. (2) The citation for the skin quotation is trimmed to MICRO:30762-30764 with the verified text, and MICRO:30770 is extended to 30770-30771 where the quoted sentence ends. (3) The hard_gate_conditions field previously counted conditions (3) and (4) as two independent qualifications when both rest on Choice B; the field now says so explicitly and rests the hard label on conditions (1) and (2), which are independent. (4) Choice B's explanation block previously asserted that 'surface defenses and the specific arm cooperate over longer periods' as though it were a cited fact; it is reworded as the general statement it is. Stem, options and key unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the three-site gradient identifies two independently removable defenses, and both were already operating a week before any specific antibody existed. Comparing the intact site with the abraded site isolates the contribution of the outer keratinized dead-cell layer, since that is the only variable removed between them. Comparing the abraded site with the abraded and cleared site isolates a second contribution, the resident surface organisms, which limit entry by occupying binding sites and competing for the nutrients a newcomer would otherwise use. Both effects were measured at \( 4 \) hours, whereas specific antibody was not detected until day \( 11 \), so neither effect could have been produced or supported by that later response. A defense that first becomes measurable on day \( 11 \) cannot account for a difference observed on the first day. (Choice A) The gradient across the three sites requires two removable contributors, and the \( 4 \) hour time point precedes the appearance of specific antibody by more than a week, so both contributors acted without it. This is the only reading consistent with both the spatial and the temporal data. (Choice B) The count of defenses is correct, and the two arms of defense do operate together over longer periods, which makes this tempting. However, the counts were taken at \( 4 \) hours, when no specific antibody was present, so the day \( 11 \) response cannot have strengthened anything that was measured. The experiment also provides no counts after day \( 11 \) with which such reinforcement could be tested. (Choice C) The count of defenses is again correct, but neither a sheet of dead keratinized cells nor a resident bacterial population works by recruiting lymphocytes to the site. Both act before any recognition occurs, by denying physical access and by consuming the resources a newcomer requires. Engaging lymphocytes is a step that follows entry rather than a means of preventing it. (Choice D) A single defense cannot generate three distinct count levels from three conditions that differ by two independent manipulations. This option also ties the \( 4 \) hour result to a response first detected on day \( 11 \), reversing the order of events. Both the number of defenses and the causal direction are inconsistent with the data. This is a Data-based and Statistical Reasoning question because you must read a three-condition gradient of viable counts together with a single time point for specific antibody and determine how many defenses acted and whether any depended on the later response.

---

## Q6 . Directing a Plasma Protein Cascade to One Surface

**Stem.** A plasma fraction whose channel-forming proteins assemble slowly on any foreign surface is added to a mixed suspension of two structurally unrelated particles, P and Q. The suspension also contains a purified binding protein produced by lymphocytes of an animal previously exposed to P, and assembly is far faster wherever that binding protein has attached. After \(30\) min, channels most likely appear:

- **A.** mainly on P, because the binding protein attaches only to surfaces bearing P.  <- **KEY**
- **B.** mainly on Q, because the binding protein shields P surfaces from the cascade.
- **C.** equally on P and Q, because the binding protein attaches to any foreign surface.
- **D.** mainly on P, because the binding protein suppresses assembly on unrelated surfaces.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (A): mainly on P, because the binding protein attaches only to surfaces bearing P.**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:31179-31181 "The classical pathway provides a more efficient mechanism of activating the complement cascade, but it depends upon the production of antibodies by the specific adaptive immune defenses. To initiate the classical pathway, a specific antibody must first bind to the pathogen to form an antibody-antigen complex." | MICRO:31174-31177 "The alternative pathway is initiated by the spontaneous activation of the complement protein C3... if invading microbes are present, C3b attaches to the surface of these microbes." | MICRO:36276-36277 "unique patterns of amino acids that can only bind to target antigens with a molecular sequence that provides complementary charges and noncovalent bonds." | BIO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-biology-2e.txt:55535-55536 "Complement proteins bind to the surfaces of microorganisms and are particularly attracted to pathogens that are already bound by antibodies." | AAMC outline lines 1880 and 1883 "Concept of antigen and antibody" and "Antigen-antibody recognition"

**Distractors**

- **(B)** `reversed_relationship` . _attachment read as protective rather than promoting_: The stem states that assembly is faster wherever the binding protein has attached, so attachment promotes channel formation on P; Q, which the protein does not occupy, is the surface left with only the slow route.
  - Citation: MICRO:31179-31181 "The classical pathway provides a more efficient mechanism of activating the complement cascade, but it depends upon the production of antibodies by the specific adaptive immune defenses. To initiate the classical pathway, a specific antibody must first bind to the pathogen to form an antibody-antigen complex."
- **(C)** `misconception` . _lymphocyte-derived binding protein treated as broadly reactive_: A binding protein produced after exposure to one particle binds only surfaces whose features complement its binding site, so a structurally unrelated particle is not bound and gains no acceleration.
  - Citation: MICRO:36276-36277 "unique patterns of amino acids that can only bind to target antigens with a molecular sequence that provides complementary charges and noncovalent bonds."
- **(D)** `partial_truth` . _right distribution, wrong mechanism_: The predicted outcome is correct, but the binding protein cannot suppress assembly on a surface it never occupies; Q retains the slow route given in the stem, so the difference comes from acceleration on P.
  - Citation: MICRO:31174-31177 "The alternative pathway is initiated by the spontaneous activation of the complement protein C3... However, if invading microbes are present, C3b attaches to the surface of these microbes. Once attached, C3b will recruit other complement proteins in a cascade."

**Readback check.** Keyed option A content words: mainly, P, binding protein, attaches, surfaces bearing P. The stem contains binding protein, attached, surface, P and Q, all shared referents that every option must invoke; the premise that attachment accelerates assembly is equally necessary to A, B, C and D. The distinctive content of the key, that attachment is restricted to surfaces bearing P, appears nowhere in the stem, which never states what the binding protein recognizes. AUDIT NOTE: this question was REBUILT. The draft item at this slot (osmotic lysis of wall-less cells through a pore) had a hybrid-scope failure, because its discriminator was the direction of net water movement, a membrane-transport principle that is not one of the six in-scope immunology discriminators; an examinee with no immunology at all could key it. It also formed one of three near-duplicate osmosis items in an eight-item batch. The rebuilt item keeps the pore cascade as GIVEN context and moves the discriminator onto antigen-antibody recognition. Its parallelism defect is also gone: the draft mixed solvent and solute across options.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because a binding protein made by lymphocytes of an animal exposed to P occupies P surfaces and not those of a structurally unrelated particle, so the accelerated route to channel assembly operates on P alone. The stem supplies two routes to assembly: a slow one that proceeds on any foreign surface, and a fast one that operates wherever the binding protein has attached. Where that protein attaches is fixed by its own binding site, whose shape and charge complement the surface features of the particle the donor animal met. Because P and Q share no structural features, the protein is present on P and absent from Q, so the fast route is confined to P. Q is left with only the slow route and carries far fewer channels at \(30\) min. (Choice A) Correct. The binding protein occupies P surfaces and not the surfaces of a structurally unrelated particle, so only P carries the accelerating attachment. Channels therefore accumulate on P while Q is limited to the slower route. (Choice B) Attachment of a binding protein can in other settings block a step on the surface it covers, which makes shielding a plausible-sounding role. The stem states, however, that assembly is faster wherever this protein has attached, so its presence promotes channel formation on P rather than protecting it. Q is the surface the protein does not occupy, and it is the one left with the slow route. (Choice C) A binding protein produced after exposure to one particle does not attach to every foreign surface, because its binding site accommodates only features that complement it. Structurally unrelated surfaces are not bound, so no acceleration occurs on Q. Equal channel numbers would require an attachment step with no selectivity at all. (Choice D) This choice reaches the right distribution by the wrong route. The binding protein cannot act on a surface it never touches, so it does not suppress assembly on Q, which retains the slow route described in the stem. The difference between the two particles arises from acceleration on P rather than from suppression elsewhere. This is a Scientific Reasoning and Problem Solving question because you must predict where an accelerating attachment occurs from the binding selectivity of a lymphocyte-derived protein.

---

## Q7 . Rigid Cell Walls and Pore-Mediated Lysis

**Stem.** Two cell types are suspended separately in the same dilute buffer and treated with the same pore-forming plasma proteins, and a fluorescent tracer confirms that channels open in both cell types within \(2\) min. Type 1 has only a plasma membrane, while type 2 has a thick rigid wall outside its membrane. The type 1 suspension clears within \(10\) min as cell contents are released, whereas the type 2 suspension stays turbid for hours, a difference most likely arising because the wall:

- **A.** prevents the pore-forming proteins from reaching the plasma membrane.
- **B.** abolishes the solute concentration difference across the plasma membrane.
- **C.** transports the entering solvent back out across the plasma membrane.
- **D.** resists the volume increase that would otherwise rupture the cell.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | (2) DATA-TO-MECHANISM: the tracer result and the turbidity time course must be converted into a mechanistic claim about volume rather than access. (3) TRUE PARTIAL-TRUTH TRAP: choice A states a mechanism the source text affirms for thick-walled cells, which this particular experiment specifically excludes. (4) 510-TEMPTING DISTRACTOR: an examinee who memorized that thick walls block the assembling complex selects A without checking it against the tracer datum. Three conditions met, so the hard label stands on re-tiering. |

**Correct answer (D): resists the volume increase that would otherwise rupture the cell.**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:4416-4418 "are more prone to lysis in hypotonic environments. The presence of a cell wall allows the cell to maintain its shape and integrity for a longer time before lysing." | MICRO:4431 "In a hypotonic medium (right), the cell wall prevents the cell membrane from expanding to the point of bursting, although lysis will eventually occur if too much water is absorbed." | MICRO:31218-31219 "These pores allow water, ions, and other molecules to move freely in and out of the targeted cells, eventually leading to cell lysis and death of the pathogen." | MICRO:31220-31221 "However, the MAC is only effective against gram-negative bacteria; it cannot penetrate the thick layer of peptidoglycan associated with cell walls of gram-positive bacteria."

**Distractors**

- **(A)** `partial_truth` . _textbook-true mechanism excluded by the data_: A thick wall can exclude a large assembling complex in general, but the fluorescent tracer shows channels did open in the walled cells here, so access cannot explain this result.
  - Citation: MICRO:31220-31221 "However, the MAC is only effective against gram-negative bacteria; it cannot penetrate the thick layer of peptidoglycan associated with cell walls of gram-positive bacteria."
- **(B)** `misconception` . _wall confused with a semipermeable barrier_: The wall is porous to small solutes and does not lie between the cytoplasm and the buffer as an osmotic barrier, so the concentration difference across the plasma membrane is unchanged.
  - Citation: MICRO:4402-4403 "The degree to which a particular cell is able to withstand changes in osmotic pressure is called tonicity. Cells that have a cell wall are better able to withstand subtle changes in osmotic pressure and maintain their shape."
- **(C)** `process_step_confusion` . _membrane transport function assigned to the wall_: Cell walls have no transport proteins and perform no pumping; transport is a plasma membrane function, and no pump could keep pace with solvent entering through open channels.
  - Citation: MICRO:4386-4387 "cell wall is a structure found in most prokaryotes and some eukaryotes; it envelopes the cell membrane, protecting the cell from changes in osmotic pressure."

**Readback check.** Keyed option D content words: resists, volume increase, rupture. The stem contains wall, cells, channels, suspension and turbid, all shared referents appearing across the options. The stem never contains rupture, burst, volume, expansion, mechanical or swelling; it supplies only the tracer datum and the turbidity time course. AUDIT NOTE: changed. The draft lead-in ended with a variant of the banned 'which statement' construction and the option set repeated 'The wall' in every choice while making the key the longest option. The lead-in is now a completion stem and the options are verb-initial and parallel, with the key no longer longest.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the wall is a rigid layer outside the membrane that physically limits how far the cell can expand, so the volume gain needed for rupture never occurs. Both suspensions received the same protein preparation and a tracer confirmed open channels in both, so any account that turns on the walled cells never acquiring channels is excluded by the data. With channels open, both cell types face the same inward drive because both sit in the same dilute buffer. What differs is the fate of that drive: the bare membrane of type 1 stretches until it fails, releasing contents and clearing the suspension, while type 2 pushes its membrane against a rigid layer that will not yield. Persistent turbidity means the type 2 cells are still intact particles scattering light. (Choice A) A thick layer outside the membrane can in other settings keep a large assembling complex from reaching the membrane, and that is a genuine mechanism of resistance for such cells. In this experiment, however, a fluorescent tracer shows that channels open in the walled cells within \(2\) min. The data therefore exclude an access-based explanation for this particular result. (Choice B) A wall is a passive structural layer that is porous to small solutes, so it does not sit between the cytoplasm and the buffer as an osmotic barrier. The concentration difference across the plasma membrane is essentially the same for both cell types. The wall changes the mechanical outcome of that difference, not the difference itself. (Choice C) Walls contain no pumps and do no transport work, which is carried out by proteins in the plasma membrane. Even a cell that did export material would be outpaced by solvent entering through wide open channels. Attributing transport to the wall misassigns a membrane function. (Choice D) Correct. The rigid wall resists the expansion that solvent entry would otherwise produce, so the membrane cannot stretch to the point of failure. The cells stay intact and the suspension stays turbid even though channels are open. This is a Scientific Reasoning and Problem Solving question because you must use the tracer and turbidity results to reject an access-based explanation and identify the mechanical limit on cell swelling.

---

## Q8 . Testing Whether a Plasma Defense Is Tailored to Its Target

**Stem.** An investigator proposes that the channel-forming activity of plasma is present before any encounter with a target and is not tailored to a particular target. Plasma can be drawn from animals of any exposure history, two structurally unrelated particles P and Q are available, and destruction of particles can be measured. Which comparison would most directly test that proposal?

- **A.** Plasma from unexposed and from P-exposed animals, each assayed against P and Q.  <- **KEY**
- **B.** Plasma from P-exposed animals, assayed against P before and after that exposure.
- **C.** Plasma from unexposed animals, assayed against P across a range of plasma dilutions.
- **D.** Plasma from P-exposed animals and from Q-exposed animals, each assayed against the particle it met.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 4 |

**Correct answer (A): Plasma from unexposed and from P-exposed animals, each assayed against P and Q.**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:30647-30650 "These defenses are described as nonspecific because they do not target any specific pathogen; rather, they defend against a wide range of potential pathogens. They are called innate because they are built-in mechanisms of the human organism. Unlike the specific adaptive defenses, they are not acquired over time and they have no 'memory' (they do not improve after repeated exposures to specific pathogens)." | MICRO:31165-31168 "Complement proteins are considered part of innate nonspecific immunity because they are always present in the blood and tissue fluids, allowing them to be activated quickly. Also, when activated through the alternative pathway... complement proteins target pathogens in a nonspecific manner." | MICRO:31179-31181 "The classical pathway... depends upon the production of antibodies by the specific adaptive immune defenses." | AAMC outline lines 1862-1863 "Innate (nonspecific) vs. adaptive (specific) immunity"

**Distractors**

- **(B)** `partial_truth` . _tests one half of a two-part claim_: A before-and-after comparison against a single particle can reveal whether exposure changes the activity, but with only one target in the design there is no mismatched condition, so tuning cannot be detected.
  - Citation: MICRO:31179-31181 "The classical pathway provides a more efficient mechanism of activating the complement cascade, but it depends upon the production of antibodies by the specific adaptive immune defenses."
- **(C)** `adjacent_fact` . _quantity measured instead of the proposed variables_: A dilution series characterizes how much activity is present and how the assay scales with it, but it varies neither exposure history nor target identity, the two variables the proposal concerns.
  - Citation: MICRO:31165-31166 "Complement proteins are considered part of innate nonspecific immunity because they are always present in the blood and tissue fluids, allowing them to be activated quickly."
- **(D)** `misconception` . _matched-only design mistaken for a specificity test_: Testing each plasma only against the particle its donor met eliminates the mismatched condition, so matched and mismatched performance are never compared and tuning cannot be detected.
  - Citation: MICRO:30647-30648 "These defenses are described as nonspecific because they do not target any specific pathogen; rather, they defend against a wide range of potential pathogens."

**Readback check.** Keyed option A content words: unexposed, P-exposed, assayed, P and Q. The stem contains P, Q, plasma and exposure history, all shared referents that every option uses; a design item must state the hypothesis, and the hypothesis is all the stem states. The factorial arrangement that constitutes the key, crossing two histories with two targets, appears nowhere in the stem, so the control logic is generated by the examinee. AUDIT NOTE: this question was REBUILT. The draft item at this slot asked which comparison isolates an osmotic gradient, a design question whose discriminator was solute permeability rather than any of the six in-scope immunology discriminators; it also duplicated the pore-lysis situation used twice elsewhere in the batch. Two of its three distractor citations were also misnumbered by one to three lines. The rebuilt item keeps the design-reasoning skill and moves the discriminator onto innate versus adaptive logic.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because it varies exposure history and target identity at the same time, which is the only arrangement that puts both halves of the proposal at risk. The proposal makes two claims: that the activity is there before any encounter, and that it is not tuned to the target it acts on. Testing the first requires plasma from animals with no history of either particle, and testing the second requires assaying each plasma against a target it has never met alongside one it has. The four combinations that result allow a mismatched condition to be compared directly against a matched one. If destruction is equal across all four, both claims survive; if the matched combination is faster, the activity is tuned after all. (Choice A) Correct. Crossing two exposure histories with two targets produces both matched and mismatched conditions and includes plasma from animals with no history at all. That is the minimum arrangement in which either half of the proposal could fail. (Choice B) Comparing one animal group against a single particle before and after exposure does address whether the activity depends on encounter. With only one target in the design, however, there is no mismatched condition, so tuning to a target cannot be detected. The comparison tests half the proposal and leaves the other half untouched. (Choice C) A dilution series measures how much activity a sample contains and establishes that the assay responds to concentration. It varies neither exposure history nor target identity, which are the two variables the proposal is about. A clean dose response would leave the proposal exactly where it started. (Choice D) Assaying each plasma only against the particle its donor met looks like a controlled pairing but removes the informative condition. Because no plasma is ever tested against a target it has not encountered, matched and mismatched performance can never be compared. Any difference between the two groups would be attributable to the particles rather than to tuning. This is a Reasoning about the Design and Execution of Research question because you must select the arrangement that crosses exposure history with target identity so that both halves of the proposal can fail.

---

## Q9 . Self Versus Nonself Discrimination in Plasma

**Stem.** Host cells display surface regulatory molecules that strip an assembling plasma-protein channel complex off the membrane before it is complete, whereas foreign particles display none. A host cell line is engineered so that it no longer makes these regulatory molecules and is then placed in fresh plasma. The line is destroyed at the same rate as an unrelated foreign particle, a result best supporting the account that:

- **A.** foreign structural features initiate the assembly, and the regulatory molecules only slow one already begun.
- **B.** assembly begins on any surface alike, and the regulatory molecules alone determine which cells survive.  <- **KEY**
- **C.** a previous encounter tunes the plasma proteins to one surface, and the regulatory molecules refine that tuning.
- **D.** a local rise in plasma protein concentration near foreign material initiates the assembly, and the regulatory molecules blunt it.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): assembly begins on any surface alike, and the regulatory molecules alone determine which cells survive.**

Citations: BIO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-biology-2e.txt:55553-55554 "Endogenous regulatory proteins prevent the complement complex from binding to host cells. Pathogens lacking these regulatory proteins are lysed." | BIO:55532-55533 "Cells of the liver and macrophages synthesize complement proteins continuously; these proteins are abundant in the blood serum and are capable of responding immediately to infecting microorganisms." | MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:31165-31168 "Complement proteins are considered part of innate nonspecific immunity because they are always present in the blood and tissue fluids, allowing them to be activated quickly. Also, when activated through the alternative pathway... complement proteins target pathogens in a nonspecific manner." | AAMC outline line 1885 "Recognition of self vs. nonself, autoimmune"

**Distractors**

- **(A)** `partial_truth` . _foreignness detection with the marker demoted to a modifier_: If foreign structural features initiated the assembly, a host cell carrying none of them should not become a target simply by losing one surface molecule, yet it is destroyed at the foreign-particle rate.
  - Citation: BIO:55553-55554 "Endogenous regulatory proteins prevent the complement complex from binding to host cells. Pathogens lacking these regulatory proteins are lysed."
- **(C)** `misconception` . _memory imported into an always-present defense_: These plasma proteins circulate constantly and act on a first encounter without being tuned by earlier exposure, and the engineered host line had never been a target before.
  - Citation: MICRO:31165-31166 "Complement proteins are considered part of innate nonspecific immunity because they are always present in the blood and tissue fluids, allowing them to be activated quickly."
- **(D)** `adjacent_fact` . _abundance mistaken for selectivity_: Concentration is set by continuous synthesis rather than by proximity to foreign material, and no concentration effect could explain a host cell becoming vulnerable purely by losing a surface molecule.
  - Citation: BIO:55532-55533 "Cells of the liver and macrophages synthesize complement proteins continuously; these proteins are abundant in the blood serum and are capable of responding immediately to infecting microorganisms."

**Readback check.** Keyed option B content words: assembly begins, any surface alike, alone determine, survive. The stem contains regulatory molecules, host cell, plasma proteins, assembling and foreign particle, all shared referents that every option must invoke; surface appears in the stem and in options B and C alike. The stem never contains survive, alike, marker or sparing, and it reports only the experimental outcome without stating why it occurred. AUDIT NOTE: changed. The draft key read 'the presence of a protective molecule, not on any feature intrinsic to the target', which is self-undermining, since a molecule displayed by the target is itself a feature of the target; a careful examinee could reject the key on its own wording. The option set is now parallel two-clause statements contrasting what starts the assembly with what stops it, and the key is no longer vulnerable to that objection. The AAMC citation was also wrong and has been corrected.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a host cell stripped of the regulatory molecules is destroyed just like an unrelated foreign particle, which shows that survival tracks the display of those molecules rather than any reading of the target as belonging to the body. These plasma proteins begin assembling on essentially any surface they contact, including the body's own. What keeps host cells intact is an actively displayed molecule that dismantles the assembling complex before it is finished. Removing that molecule converts a host cell into a target at the rate seen for a foreign particle, so the discrimination is implemented as the display of a protective marker rather than as detection of foreignness. This is a general design principle in self versus nonself discrimination: the safe state is the marked state, and losing the mark is sufficient to be treated as nonself. (Choice A) If these proteins genuinely read foreign structural features, then removing a regulatory molecule from a host cell should not by itself make that cell a target. The engineered line carries no foreign features and is destroyed anyway. The regulatory molecules are therefore doing the discriminating rather than adjusting the pace of something already under way. (Choice B) Correct. Survival tracks the presence of the regulatory molecules and nothing else, since a host cell that loses them is destroyed at the rate observed for an unrelated foreign particle. Discrimination is therefore based on a displayed marker rather than on any property that distinguishes the target itself. (Choice C) These plasma proteins circulate continuously and act on a first encounter, so no earlier exposure is required and none is recorded. Tuning to a particular surface after exposure describes the specific arm of immunity rather than this one. The engineered host cell line had also never been a target before. (Choice D) The concentration of these proteins is set by continuous production and does not surge selectively around foreign material. Even a local rise would not explain why a host cell becomes vulnerable purely by losing one surface molecule. The determining variable in the experiment is that molecule, not the protein concentration. This is a Scientific Reasoning and Problem Solving question because you must infer from an engineered loss of function how a nonspecific plasma defense separates the body's own cells from everything else.

---

## Q10 . Direction of an Innate Antiviral Signal

**Stem.** In a region of tissue where an intracellular agent is replicating, an altered host cell secretes a small soluble protein and then dies. The protein does not reverse the alteration in the cell that produced it, yet over the following hours the appearance of new alterations in that tissue slows. The protein most likely produces this effect by:

- **A.** reversing the alteration in cells that already contain the agent.
- **B.** binding the agent in the extracellular fluid so that it cannot enter cells.
- **C.** inducing a resistant state in nearby cells that are not yet altered.  <- **KEY**
- **D.** entering the circulation to protect cells in tissues far from this site.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): inducing a resistant state in nearby cells that are not yet altered.**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:31273-31274 "Although interferons do not cure the cell releasing them or other infected cells, which will soon die, their release may prevent additional cells from becoming infected, thus stemming the infection." | MICRO:31255-31257 "Type I interferons (interferon-alpha and interferon-beta) are produced and released by cells infected with virus. These interferons stimulate nearby cells to stop production of mRNA, destroy RNA already produced, and reduce protein synthesis." | MICRO:31233-31235 "paracrine function involves the release of cytokines from one cell to other nearby cells... endocrine function occurs when cells release cytokines into the bloodstream to be carried to target cells much farther away." | BIO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-biology-2e.txt:55421-55422 "A second class of early-acting cytokines is interferons, which are released by infected cells as a warning to nearby uninfected cells."

**Distractors**

- **(A)** `misconception` . _signal as a cure for cells already affected_: The protein fails to reverse the alteration in its own source cell, and a signal able to repair altered cells would have rescued that cell first, so repair of other altered cells is not supported.
  - Citation: MICRO:31273-31274 "Although interferons do not cure the cell releasing them or other infected cells, which will soon die, their release may prevent additional cells from becoming infected, thus stemming the infection."
- **(B)** `adjacent_fact` . _extracellular neutralization borrowed from the specific arm_: Neutralizing an agent in extracellular fluid describes a specific binding protein made by lymphocytes rather than a short-lived signal released by a dying host cell.
  - Citation: MICRO:32718-32719 "Neutralization involves the binding of certain antibodies (IgG, IgM, or IgA) to epitopes on the surface of pathogens or toxins, preventing their attachment to cells."
- **(D)** `process_step_confusion` . _long-range signalling substituted for local signalling_: Distant action is a real signaling mode but would not account for a fall in new alterations at the very site where the agent is spreading, since the cells at risk are the adjacent ones.
  - Citation: MICRO:31233-31235 "paracrine function involves the release of cytokines from one cell to other nearby cells, stimulating some response from the recipient cells. Last, endocrine function occurs when cells release cytokines into the bloodstream to be carried to target cells much farther away."

**Readback check.** Keyed option C content words: inducing, resistant state, nearby, not yet altered. The stem contains altered, cell, agent and protein; altered and agent are shared referents, and reverse appears in the stem but also in choice A, so it is not distinctive to the key. Resistant, nearby and induce appear nowhere in the stem, which reports only that the source cell dies and that new alterations slow without naming the target population. AUDIT NOTE: stem and options unchanged; three citations corrected. The quotation attributed to MICRO:31273 runs onto 31274, the paracrine quotation begins on 31233 rather than 31232, and the citation supporting choice B pointed at a line about interferon warning neighbouring cells, which does not support the claim that neutralization is antibody work; it has been replaced with the neutralization passage.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because a signal that cannot help the cell that made it can only reduce new alterations by preparing cells that have not yet been reached. The secreting cell dies, so the slowing of new alterations must come from a change in some other population. The population positioned to matter is the still normal tissue immediately around the dying cell, which lies in the path of the spreading agent. A protein that induces a resistant state in those cells before the agent arrives lowers the number that can be altered, which is exactly the pattern described. The defense is therefore preemptive and directed outward rather than restorative and directed inward. (Choice A) The stem states that the alteration in the producing cell is not reversed, and there is no reason to expect the same protein to reverse it in other cells. A signal capable of repairing altered cells would have rescued its own source first. The death of the producing cell argues against this route. (Choice B) Binding and neutralizing an agent in extracellular fluid is a real defensive strategy, but it is the work of specific binding proteins made by lymphocytes. A short-lived signal released by a dying host cell is better suited to changing the state of nearby cells. Neutralization would also not require the signal to originate from an altered cell at all. (Choice C) Correct. The protein acts on neighboring cells that are still normal and raises their resistance before the agent reaches them. Fewer of those cells can then be altered, which is why the rate of new alterations falls even though the source cell dies. (Choice D) Some signaling molecules do enter the circulation and act at a distance, so this is a real mode of action. It would not, however, explain a fall in new alterations at the site where the agent is actually spreading. Local protection of the cells immediately at risk is the more direct account. This is a Scientific Reasoning and Problem Solving question because you must determine which population a secreted signal must act on for the observed local slowing to occur.

---

## Q11 . Properties of a Broad Antiviral Signal

**Stem.** An altered host cell releases a soluble protein that acts on nearby normal cells and lowers the rate at which those cells are subsequently altered. This activity is measurable in animals that have had no previous encounter with the agent. Which of the following would be expected of this protein?

I. Recipient cells also resist a second, structurally unrelated intracellular agent.
II. Recipient cells become protected within hours, sooner than a defense requiring proliferation of a matched lymphocyte population could act.
III. A second encounter with the same agent leaves recipient cells far more strongly protected than the first encounter did.

- **A.** I only
- **B.** III only
- **C.** II and III only
- **D.** I and II only  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 100 s |
| Confidence | 5 |

**Correct answer (D): I and II only**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:30647-30650 "These defenses are described as nonspecific because they do not target any specific pathogen; rather, they defend against a wide range of potential pathogens. They are called innate because they are built-in mechanisms of the human organism. Unlike the specific adaptive defenses, they are not acquired over time and they have no 'memory' (they do not improve after repeated exposures to specific pathogens)." | MICRO:30655-30656 "Broadly speaking, nonspecific innate defenses provide an immediate (or very rapid) response against potential pathogens." | BIO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-biology-2e.txt:55427-55430 "In response to interferons, uninfected cells alter their gene expression, which increases the cells' resistance to infection... Thus, by reducing protein synthesis, a cell becomes resistant to viral infection." | AAMC outline lines 1862-1863 "Innate (nonspecific) vs. adaptive (specific) immunity"

**Distractors**

- **(A)** `partial_truth` . _correct item, incomplete set_: Item I is expected, but omitting item II discards the speed advantage that follows directly from a defense needing no selection and expansion step.
  - Citation: MICRO:30655-30656 "Broadly speaking, nonspecific innate defenses provide an immediate (or very rapid) response against potential pathogens."
- **(B)** `misconception` . _memory attributed to a built-in defense_: Improvement on a second encounter is the signature of the arm assembled after exposure; this activity is present in animals that never met the agent and does not strengthen with repetition.
  - Citation: MICRO:30649-30650 "Unlike the specific adaptive defenses, they are not acquired over time and they have no 'memory' (they do not improve after repeated exposures to specific pathogens)."
- **(C)** `partial_truth` . _true item paired with a false one_: Item II is correct but item III is not, since a defense that operates without prior exposure does not become stronger on a repeat encounter.
  - Citation: MICRO:30647-30648 "These defenses are described as nonspecific because they do not target any specific pathogen; rather, they defend against a wide range of potential pathogens."

**Readback check.** Keyed option D is the combination I and II only, whose content lives in the numbered items. Item I content words: structurally unrelated, resist. Item II content words: within hours, proliferation, matched lymphocyte population. Neither unrelated, hours, proliferation nor lymphocyte appears in the stem, which states only that the protein acts on nearby normal cells and that the activity exists without prior encounter; it never asserts breadth, speed or the absence of memory. AUDIT NOTE: stem, items and options unchanged; two citations corrected. The line reference for the immediacy quotation was wrong by three lines, since lines 30652-30653 are a running page header and the sentence begins at 30655, and the AAMC outline reference spans two lines rather than one. The source prints the word memory inside typographic quotation marks, rendered here with plain single quotes to keep the dash and punctuation rules satisfied.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because items I and II follow from a defense that is present without prior exposure and acts on the recipient cell's own machinery, while item III describes an improvement with repeated exposure that this kind of defense does not show. The activity is measurable in animals with no history of the agent, which places it among the built-in defenses rather than the ones assembled after exposure. Defenses of that kind are not tailored to a single target, so a resistant state induced in a recipient cell is expected to work against an unrelated agent as well, which supports item I. They also act on a timescale of hours because nothing has to be selected and expanded first, whereas a defense built from a matched lymphocyte population needs days of proliferation, which supports item II. Built-in defenses do not improve on repeated encounter, which is precisely what item III asserts, so item III fails. (Choice A) Item I is indeed expected, since a resistant state built into the recipient cell is not tailored to one agent. Restricting the answer to item I alone discards the timing comparison in item II. Speed is one of the defining features of a defense that requires no prior exposure. (Choice B) Item III describes a stronger response on a second encounter, which is the signature of the arm of immunity that is assembled after exposure and retained. The activity here is present in animals that have never met the agent and does not depend on that history. Selecting item III alone also discards two items that do follow. (Choice C) Item II is correct, because a defense needing no prior selection step acts far sooner than one that must expand a matched population of cells. Item III is not, since improvement across repeated encounters belongs to the specific arm. Pairing a correct item with an incorrect one makes this combination wrong. (Choice D) Correct. Item I follows from the absence of tailoring to a single agent, and item II follows from the absence of any selection and proliferation step. Item III is excluded because a defense that operates without prior exposure does not strengthen with repetition. This is a Scientific Reasoning and Problem Solving question because you must decide which properties follow from a defense that operates without prior exposure and which belong to the specific arm instead.

---

## Q12 . Constitutive Plasma Defenses Versus Induced Specificity

**Stem.** An animal is challenged with foreign particle P on day \(0\) and again on day \(30\). Plasma is assayed for activity X, a set of channel-forming proteins present in plasma from birth, and for activity Y, a P-binding protein produced by lymphocytes.

| Day | X (\(\%\) of day \(0\)) | Y (arbitrary units) |
| --- | --- | --- |
| 0 | 100 | 0 |
| 5 | 103 | 14 |
| 30 | 98 | 9 |
| 35 | 101 | 165 |

The animal meets structurally unrelated particle Q for the first time on day \(60\), and the most likely finding on day \(62\) is that:

- **A.** Q is damaged promptly by X, while Y directed at Q is still near \(0\).  <- **KEY**
- **B.** Q is damaged promptly by Y, while X is still near \(100\%\).
- **C.** Q is not damaged until X climbs well above \(100\%\), which takes several days.
- **D.** Q is damaged promptly by X, which by day \(60\) has climbed well above \(100\%\) after the earlier challenges.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 120 s |
| Confidence | 5 |
| Hard-tier gate | (1) CONCEPT CHAINING: the flat X and rising Y pattern must first be mapped onto constitutive versus induced defenses, and that mapping must then be applied to a new particle at a new time point. (2) DATA-TO-MECHANISM: the numeric time course is the only source of the constitutive versus induced distinction, since the stem never states it. (4) 510-TEMPTING DISTRACTOR: choice D gets the outcome right and the reason wrong and survives unless the examinee checks the day \(30\) and day \(35\) values for X. Three conditions met, so the hard label stands on re-tiering. |

**Correct answer (A): Q is damaged promptly by X, while Y directed at Q is still near \(0\).**

Citations: MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:31165-31168 "Complement proteins are considered part of innate nonspecific immunity because they are always present in the blood and tissue fluids, allowing them to be activated quickly. Also, when activated through the alternative pathway... complement proteins target pathogens in a nonspecific manner." | MICRO:30649-30650 "Unlike the specific adaptive defenses, they are not acquired over time and they have no 'memory' (they do not improve after repeated exposures to specific pathogens)." | MICRO:32467-32469 "Higher animals, such as humans, also possess an adaptive immune defense, which is highly specific for individual microbial pathogens. This specific adaptive immunity is acquired through active infection or vaccination." | BIO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-biology-2e.txt:55532-55533 "Cells of the liver and macrophages synthesize complement proteins continuously; these proteins are abundant in the blood serum and are capable of responding immediately to infecting microorganisms."

**Distractors**

- **(B)** `reversed_relationship` . _roles of the two activities swapped_: Y is the induced, target-directed activity, so none exists against Q on day \(62\); X is the activity already circulating at a constant level and therefore the one able to act first.
  - Citation: MICRO:31161-31164 "The complement system is a group of plasma protein mediators that can act as an innate nonspecific defense... These precursor proteins become activated when stimulated or triggered by a variety of factors, including the presence of microorganisms."
- **(C)** `misconception` . _constitutive activity treated as inducible_: The table shows X remaining between \(98\%\) and \(103\%\) after two separate challenges, so it does not need to be built up before acting and prompt damage requires no rise.
  - Citation: MICRO:31165-31166 "Complement proteins are considered part of innate nonspecific immunity because they are always present in the blood and tissue fluids, allowing them to be activated quickly."
- **(D)** `partial_truth` . _right outcome, data-contradicted reason_: Prompt damage by X is correct, but X is \(98\%\) on day \(30\) and \(101\%\) on day \(35\), so it never accumulated from the earlier challenges and effectiveness here does not depend on any increase.
  - Citation: MICRO:30649-30650 "Unlike the specific adaptive defenses, they are not acquired over time and they have no 'memory' (they do not improve after repeated exposures to specific pathogens)."

**Readback check.** Keyed option A content words: damaged promptly, X, Y directed at Q, near \(0\). The stem contains X, Y, P, Q, plasma and day labels, all shared referents required by every option, plus the table numbers, which are data to reason from rather than a conclusion. The stem never contains promptly, nonspecific, constitutive or specific, and never states what will happen on day \(62\). AUDIT NOTE: stem, table and options unchanged; three citations corrected. The distractor B citation quoted a sentence beginning on line 31164, one line past the cited range; the distractor C range overshot by one line; and the adaptive-immunity quotation in the citation field begins on 32467, not 32468. The BIO complement quotation ends on 55533 rather than 55534. Verified that the key is shorter than choice D, so the longest-option cue is absent.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because activity X sits at roughly \(100\%\) of its starting value throughout, including after two challenges, so it is available at once against a target the animal has never met, while activity Y is built only against the particle that induced it. Across the whole table X varies between \(98\%\) and \(103\%\), which is measurement scatter rather than a response, and it rises after neither the first challenge nor the second. Y behaves in the opposite way, appearing modestly after the first challenge and reaching \(165\) units after the second, the pattern of a defense that is assembled against one particular target and then strengthened. When particle Q appears on day \(60\), the animal has no Y directed at Q, because Y is specific to whatever induced it, so any prompt damage to Q must come from the always-present X. Two days is also far too short for a targeted binding protein against Q to reach a meaningful level. (Choice A) Correct. X is present at its usual level and is not tailored to any single target, so it can act on Q immediately. Y directed at Q has not been induced, and day \(62\) is too early for it to have risen. (Choice B) This reverses the roles the table assigns to the two activities. Y is the activity that appears only after a challenge and is directed at the particle that caused it, so no Y against Q exists on day \(62\). X is the activity that is already circulating and can act first. (Choice C) The table shows X holding near \(100\%\) even after two challenges, so there is no evidence that it must be induced before it can act. Treating X as something that has to be built up imports the behavior of Y. Prompt damage to Q does not require any rise in X. (Choice D) The prediction of prompt damage by X is right, but the stated reason contradicts the data. X reads \(98\%\) on day \(30\) and \(101\%\) on day \(35\), showing no accumulation from the earlier challenges. A defense that is effective without changing in amount is not the same as one that has been boosted. This is a Data-based and Statistical Reasoning question because you must read two plasma activity time courses, distinguish scatter from a real change, and extend the pattern to a target the animal has not encountered.

---

## Q13 . Basis of the Induced Resistant State

**Stem.** Normal cells treated with a soluble protein released by altered cells show a \(70\%\) fall in total protein synthesis within \(6\) h. When these treated cells are then exposed separately to two structurally unrelated intracellular agents, both agents replicate poorly in them. No lymphocytes are present in the cultures, and the protection observed is best explained as arising from:

- **A.** loss of a host resource needed by the first agent only, with the second agent blocked at the cell surface.
- **B.** loss of a host resource that both agents must use, rather than an attack on either agent.  <- **KEY**
- **C.** direct chemical attack on both agents once they have entered the treated cells.
- **D.** display of agent fragments on the treated cell surface for recognition by other cells.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): loss of a host resource that both agents must use, rather than an attack on either agent.**

Citations: BIO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-biology-2e.txt:55427-55430 "In response to interferons, uninfected cells alter their gene expression, which increases the cells' resistance to infection. One effect of interferon-induced gene expression is a sharply reduced cellular protein synthesis. Virally infected cells produce more viruses by synthesizing large quantities of viral proteins. Thus, by reducing protein synthesis, a cell becomes resistant to viral infection." | MICRO /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-microbiology.txt:31256-31258 "These interferons stimulate nearby cells to stop production of mRNA, destroy RNA already produced, and reduce protein synthesis. These cellular changes inhibit viral replication and production of mature virus, slowing the spread of the virus." | MICRO:30647-30648 "These defenses are described as nonspecific because they do not target any specific pathogen; rather, they defend against a wide range of potential pathogens." | MICRO:32853-32855 "All nucleated cells in the body have mechanisms for processing and presenting antigens in association with MHC molecules. This signals the immune system, indicating whether the cell is normal and healthy or infected with an intracellular pathogen."

**Distractors**

- **(A)** `partial_truth` . _two mechanisms invented for one broad effect_: Both structurally unrelated agents replicate poorly in the same treated cells, so a single shared host change accounts for the data and no separate agent-specific surface block is needed.
  - Citation: BIO:55427-55428 "In response to interferons, uninfected cells alter their gene expression, which increases the cells' resistance to infection. One effect of interferon-induced gene expression is a sharply reduced cellular protein synthesis."
- **(C)** `misconception` . _host-directed change read as agent-directed attack_: The measured change is in the treated cell's own synthesis rather than in any activity aimed at an agent, and a single targeted attack acting equally on two unrelated agents is not supported.
  - Citation: MICRO:31256-31258 "These interferons stimulate nearby cells to stop production of mRNA, destroy RNA already produced, and reduce protein synthesis. These cellular changes inhibit viral replication."
- **(D)** `adjacent_fact` . _real defense that cannot operate in this culture_: Surface display of processed fragments works by signaling other cells that a cell is abnormal, and no cells able to receive that signal are present, so it cannot explain reduced replication measured inside the treated cells.
  - Citation: MICRO:32853-32855 "All nucleated cells in the body have mechanisms for processing and presenting antigens in association with MHC molecules. This signals the immune system, indicating whether the cell is normal and healthy or infected with an intracellular pathogen."

**Readback check.** Keyed option B content words: loss, host resource, both agents must use, attack. The stem contains agents and treated cells as shared referents, and the phrase both agents appears in choice C as well, so it is not distinctive to the key. Host resource, must use and attack appear nowhere in the stem, which reports only a percentage fall in total protein synthesis and the replication outcome; the bridging idea, that reduced host biosynthesis is a resource both agents depend on, is supplied by the examinee. Residual risk noted and accepted: the stem gives the datum that protein synthesis falls, so the key sits closer to that datum than in the other items, but the inference to shared dependence and to breadth is not stated. AUDIT NOTE: changed. The explanation block for choice D asserted that surface display of fragments is a consequence of this kind of signaling, a claim the cited line does not support; it now rests on the requirement for a responding cell, which the source does state, and the citation has been replaced. The choice A citation range was also trimmed to the lines actually containing the quoted sentences.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a broad fall in the treated cell's own protein synthesis removes machinery that any intracellular agent must borrow, which explains why two agents with nothing structural in common both replicate poorly. The treated cells are not attacking anything; what changed is a general property of the host cell. Intracellular agents cannot make their own proteins and must use the host cell's synthetic machinery, so a cell running at a fraction of its normal output is a poor place for any of them to replicate. Because the resource withdrawn is shared by unrelated agents, the protection is broad rather than targeted, which is the hallmark of a defense that requires no prior exposure. The cost of that strategy is that the treated cell also gives up much of its own biosynthesis. (Choice A) Protection here is not agent specific, since two structurally unrelated agents replicate poorly in the same treated cells. Invoking one mechanism for one agent and a separate surface block for the other is unnecessary and unsupported by the data. A single shared explanation accounts for both results. (Choice B) Correct. The treated cell loses much of the biosynthetic capacity that any intracellular agent must use, so replication of unrelated agents falls for the same underlying reason. Nothing in the data requires the treated cell to attack either agent directly. (Choice C) A direct chemical attack would have to recognize something about the agent, and it is unlikely that one activity would attack two unrelated agents equally well. The measured change is in the host cell's own synthesis rather than in any agent-directed activity. The breadth of the effect points away from targeted attack. (Choice D) Display of fragments on a cell surface is a real event in host defense, but it works by signaling to other cells that something is wrong inside, and no cells able to receive that signal are present in these cultures. The observed effect is reduced replication inside the treated cells themselves. Surface display would not lower replication in a culture that contains nothing able to respond to it. This is a Scientific Reasoning and Problem Solving question because you must connect a broad reduction in host biosynthesis to protection against agents that share no structural features.

---

## Q14 . Chemotaxis and Gradient Sensing

**Stem.** Phagocytes are placed in the central well of a migration chamber that has one side well at each end. With no attractant anywhere few cells leave the center, while attractant in the left side well alone draws many cells into that well; the assay is then repeated with the same amount of attractant also added to the central well.

In this third condition, phagocyte accumulation in the left side well will most likely be:

- **A.** above the second condition value, because more attractant is present overall.
- **B.** above the second condition value, because attractant contact begins sooner.
- **C.** near the first condition value, because no spatial cue remains.  <- **KEY**
- **D.** near zero, because raised attractant levels repel phagocytes.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): near the first condition value, because no spatial cue remains.**

Citations: openstax-anatomy-physiology-2e.txt:42773-42774: 'A chemokine is a soluble chemical mediator similar to cytokines except that its function is to attract cells (chemotaxis) from longer distances.' openstax-anatomy-physiology-2e.txt:42777-42778: 'Visit this website ... to learn about phagocyte chemotaxis. Phagocyte chemotaxis is the movement of phagocytes according to the secretion of chemical messengers in the form of interleukins and other chemokines.' openstax-anatomy-physiology-2e.txt:34378-34381: 'sometimes moving toward the direction in which they are drawn by chemical signals. This attracting of leukocytes occurs because of positive chemotaxis (literally 'movement in response to chemicals'), a phenomenon in which injured or infected cells and nearby leukocytes emit the equivalent of a chemical '911' call, attracting more leukocytes to the site.' openstax-anatomy-physiology-2e.txt:42681-42682: 'A macrophage is an irregularly shaped phagocyte that is amoeboid in nature and is the most versatile of the phagocytes in the body. Macrophages move through tissues and squeeze through capillary walls using pseudopodia.' openstax-microbiology.txt:52476-52477 (glossary): 'chemotaxis directional movement of a cell in response to a chemical attractant'. All five verified verbatim at the stated lines.

**Distractors**

- **(A)** `misconception` . _more-is-more_: Equates the total quantity of attractant with the strength of the directional signal. Adding attractant to the starting well increases the amount present while abolishing the difference between compartments, and only the difference produces net accumulation.
  - Citation: openstax-anatomy-physiology-2e.txt:34378-34381
- **(B)** `process_step_confusion` . _wrong-controlling-variable_: Substitutes the timing of first receptor contact for the variable that actually sets direction. Cells sensing attractant equally on all sides extend pseudopodia in every direction and scatter rather than accumulating in one well.
  - Citation: openstax-anatomy-physiology-2e.txt:42681-42682
- **(D)** `reversed_relationship` . _attractant-becomes-repellent_: Converts loss of a directional cue into active repulsion. Receptor saturation blunts responsiveness but does not reverse the sign of movement, so counts should approach baseline rather than drop below it.
  - Citation: openstax-anatomy-physiology-2e.txt:42777-42778

**Readback check.** Content words of key C: near, first condition value, no spatial cue, remains. Stem contains: central well, side well, attractant, accumulation, phagocytes, condition. Shared referents (attractant, well, condition labels) are equally necessary to all four options. The discriminating words 'spatial cue' appear nowhere in the stem, and the stem states only the amounts placed, never that a cue is absent. No definition-to-name, no stem echo, no restated premise. AUDIT CHANGES: (1) WRONG-SOURCE CITATION REMOVED. The draft supported phagocyte gradient sensing with openstax-microbiology.txt:4991-4993, which is the Figure 3.34 caption in Chapter 3 on prokaryote flagellar motility. The quoted text is genuine but describes bacterial run-and-tumble swimming, not leukocyte migration. Replaced with anatomy-physiology citations on phagocyte chemotaxis and amoeboid movement. (2) FACTUAL ERROR IN EXPLANATION FIXED. The draft's main reasoning and Choice B block imported bacterial run-and-tumble language ('Runs are lengthened only when that comparison favors one direction', 'extend runs in every direction') into a phagocyte question. Phagocytes crawl by pseudopodial extension and read a spatial gradient across the cell body; they do not run and tumble. Rewritten in amoeboid terms. (3) KEY WAS THE LONGEST OPTION. Draft key C ran 14 words against 12, 12 and 11 for the distractors. All four options rewritten to comparable length; key C is now 10 words and Choice A at 11 is the longest. (4) Stem compressed to two setup sentences plus the question line.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because directed migration is driven by a spatial difference in attractant level across the cell, so flooding the starting well erases that difference and accumulation falls back toward the no-attractant baseline. A phagocyte travels by extending pseudopodia in an amoeboid fashion, and it steers by comparing how much attractant reaches one side of itself with how much reaches the other. Net movement toward a source continues only while that comparison favors one direction. When attractant sits at the same level in the starting compartment and in the destination compartment, every direction looks alike to the cell, so pseudopod extension is equally likely on all sides and travel becomes undirected. Accumulation in the left well therefore collapses toward the value obtained when no attractant was present at all.
>
> (Choice A) Total exposure to attractant is indeed greater in the third condition, but total exposure is not what steers a cell. Adding attractant to the starting well raises the amount present while abolishing the difference between compartments, and it is that difference which produces net accumulation.
>
> (Choice B) Contact with attractant does begin sooner when the chemical is already in the starting well, but the timing of first receptor occupancy does not establish a direction. A cell occupied equally on all sides extends pseudopodia in every direction and ends up scattered rather than concentrated in one well.
>
> (Choice C) With attractant at the same level in the starting well and in the left well, no spatial difference remains for the cell to read, so migration is undirected. Accumulation in the left well should therefore approach the count obtained in the first condition, in which no attractant was present anywhere.
>
> (Choice D) Uniformly high attractant levels can saturate surface receptors and blunt responsiveness, but saturation removes direction rather than reversing it. Nothing in this setup would actively drive cells out of the left well, so counts should settle near baseline rather than below it.
>
> This is a Scientific Reasoning and Problem Solving question because you must predict how phagocyte accumulation changes when an attractant is made uniform rather than localized.

---

## Q15 . Phagocyte Size Limits and External Attack

**Stem.** A parasitic worm many hundreds of times larger than a leukocyte lodges in connective tissue. Innate leukocytes that store membrane-damaging proteins in internal vesicles bind tightly to the worm.

These bound leukocytes most likely damage the worm by:

- **A.** discharging their stored proteins directly onto the target.  <- **KEY**
- **B.** enclosing the worm in a vesicle and digesting it internally.
- **C.** removing small pieces of the worm by repeated endocytosis.
- **D.** discharging their stored proteins into tissue fluid at a distance.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (A): discharging their stored proteins directly onto the target.**

Citations: openstax-microbiology.txt:31796-31797: 'To engulf the pathogen, the phagocyte forms a pseudopod that wraps around the pathogen and then pinches it off into a membrane vesicle called a phagosome.' openstax-microbiology.txt:31810-31812: 'Some phagocytes even contain an internal storehouse of microbicidal defensin proteins (e.g., neutrophil granules). These destructive forces can be released into the area around the cell to degrade microbes externally.' openstax-microbiology.txt:31510-31513: 'The granules of eosinophils, which readily absorb the acidic reddish dye eosin, contain histamine, degradative enzymes, and a compound known as major basic protein (MBP) ... MBP binds to the surface carbohydrates of parasites, and this binding is associated with disruption of the cell membrane and membrane permeability.' openstax-biology-2e.txt:55451-55453: 'An eosinophil is a leukocyte that works with other eosinophils to surround a parasite; it is involved in the allergic response and in protection against helminthes (parasitic worms).' All four verified verbatim at the stated lines.

**Distractors**

- **(B)** `misconception` . _default-to-phagocytosis_: Applies the standard ingestion pathway to an object far larger than the cell itself. The plasma membrane cannot wrap a target hundreds of times the leukocyte's diameter into a vesicle.
  - Citation: openstax-microbiology.txt:31796-31797
- **(C)** `partial_truth` . _real-process-wrong-scale_: Endocytosis of surface fragments is a real cellular activity but removes trivial amounts of material and could not injure a large organism on any relevant timescale. It also fails to account for the cell's stored membrane-damaging proteins.
  - Citation: openstax-microbiology.txt:31793-31797
- **(D)** `process_step_confusion` . _right-mechanism-wrong-geometry_: Extracellular release is the correct mechanism, but broadcasting it into bulk tissue fluid would dilute the proteins and injure host tissue. Tight adhesion is what focuses the discharge on the target surface.
  - Citation: openstax-microbiology.txt:31810-31812

**Readback check.** Content words of key A: discharging, stored proteins, directly onto, target. 'Stored proteins' also appears in distractor D, so it is a shared referent, and the stem's phrase is 'membrane-damaging proteins in internal vesicles'. The discriminating element is 'directly onto' versus internalization or distant release, and neither 'directly onto', 'internally', nor 'at a distance' appears in the stem. The stem states the size relationship and the adhesion as data, never the conclusion that engulfment is unavailable. No definition-to-name, no stem echo of the discriminator, no self-justifying key. Option lengths 8/10/9/10 words, so the key is the shortest and cannot be picked on length. AUDIT CHANGES: one overreach corrected. The draft explanation asserted that phagocytosis 'sets a hard upper limit on target size at roughly the dimensions of the phagocyte itself', a numeric limit the source does not state; rephrased as a limit to objects small enough to fit inside the cell, which is what openstax-microbiology.txt:31796-31797 supports. Boundary re-checked: the defensin citation is used only to support extracellular release of stored proteins, and defensins as a barrier molecule (Bio Ch6 territory) are never named in the stem, options or discriminator. All citations verified verbatim; otherwise unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because a target that cannot fit inside a vesicle cannot be handled by ingestion, so the cell must release its destructive contents outward onto the surface it is touching. Phagocytosis works by wrapping a pseudopod around an object and pinching it off into an internal vesicle, so the targets it can handle are limited to objects small enough to fit inside the cell. Some innate leukocytes carry an internal store of membrane-damaging proteins that can be released into the area around the cell to degrade targets externally. Tight adhesion to the worm is what makes this route useful, because it concentrates the discharge at the point of contact instead of dispersing it. The result is damage to the worm's surface membrane with no ingestion step at all.
>
> (Choice A) Ingestion is not available for an object hundreds of times the size of the cell, so the stored proteins must be delivered outward. Adhesion places the cell against the surface it is attacking, so the released proteins act where they are concentrated rather than being diluted.
>
> (Choice B) Enclosing the worm in a vesicle would require the leukocyte's plasma membrane to surround an object far larger than the entire cell. Internal digestion is the normal route for bacterial-sized particles and cellular debris, not for a multicellular organism.
>
> (Choice C) Nibbling small pieces of surface by repeated endocytosis removes only trace amounts of membrane and cytoplasm and would be far too slow to injure a large organism. It also leaves unexplained why the cell maintains a store of membrane-damaging proteins in the first place.
>
> (Choice D) Releasing the stored proteins into bulk tissue fluid would dilute them below useful concentrations and would expose neighboring host cells to damage. Tight binding exists precisely so that the discharge is aimed at the adjacent surface rather than broadcast.
>
> This is a Scientific Reasoning and Problem Solving question because you must predict how an innate leukocyte attacks a target too large to be enclosed in a vesicle.

---

## Q16 . Resident Macrophages as the Source of Recruitment Signals

**Stem.** A sterile irritant is placed in the dermis of two animals. In one animal the macrophages that normally reside in that patch of dermis have been depleted beforehand, while its circulating leukocytes and their gradient-sensing machinery remain intact.

Six hours later, the depleted site most likely shows:

- **A.** a larger influx of circulating leukocytes, because fewer resident cells compete for the irritant.
- **B.** an unchanged influx of circulating leukocytes, because they detect the irritant from inside the vessel.
- **C.** an unchanged influx of circulating leukocytes, because the irritant itself diffuses out as the attractant.
- **D.** a smaller influx of circulating leukocytes, because fewer local signals are produced.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic easy / structural medium) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (D): a smaller influx of circulating leukocytes, because fewer local signals are produced.**

Citations: openstax-microbiology.txt:31697-31703: 'Some phagocytes are leukocytes (WBCs) that normally circulate in the bloodstream. To reach pathogens located in infected tissue, leukocytes must pass through the walls of small capillary blood vessels within tissues. This process ... is initiated by complement factor C5a, as well as cytokines released into the immediate vicinity by resident macrophages and tissue cells responding to the presence of the infectious agent ... many of these cytokines are proinflammatory and chemotactic, and they bind to cells of small capillary blood vessels'. openstax-microbiology.txt:31723-31728 (Figure 17.19 caption): 'Damaged cells and macrophages that have ingested pathogens release cytokines that are proinflammatory and chemotactic for leukocytes ... Leukocytes exit the blood vessel and follow the chemoattractant signal of cytokines and C5a to the site of infection.' openstax-microbiology.txt:31773-31775: 'PRRs on macrophages also respond to chemical distress signals from damaged or stressed cells. This allows macrophages to extend their responses beyond protection from infectious diseases to a broader role in the inflammatory response initiated from injuries'. openstax-anatomy-physiology-2e.txt:42693-42694: 'Whereas macrophages act like sentries, always on guard against infection, neutrophils can be thought of as military reinforcements that are called into a battle'. All four verified verbatim at the stated lines.

**Distractors**

- **(A)** `reversed_relationship` . _resident-cells-inhibit_: Casts resident macrophages as competitors that suppress recruitment rather than as the source of the recruiting signal. Their loss reduces mediator output, so the influx falls rather than rises.
  - Citation: openstax-microbiology.txt:31699-31701
- **(B)** `misconception` . _surveillance-from-the-lumen_: Assumes circulating cells sense tissue events directly from inside the vessel. Recruitment requires mediators generated in the tissue that then act on the endothelium of the nearby capillary.
  - Citation: openstax-microbiology.txt:31699-31703
- **(C)** `process_step_confusion` . _stimulus-mistaken-for-attractant_: Confuses the triggering object with the chemotactic signal. The molecules that guide leukocytes are host-derived cytokines and mediators released in response to the irritant, not the irritant itself.
  - Citation: openstax-microbiology.txt:31723-31728

**Readback check.** Content words of key D: smaller, influx, circulating leukocytes, fewer local signals, produced. 'Circulating leukocytes' appears in all four options and is the shared referent required by every one of them. 'Signals' does not appear in the stem; the stem says 'gradient-sensing machinery', which describes the responder, not the source. The stem supplies the manipulation and the intactness of the responders as data, never the conclusion that signal production is reduced. Key D at 13 words is the shortest option. AUDIT CHANGES: one internal inconsistency fixed. The draft explanation referred to 'the drug-free blood cells in this experiment', but this question involves no drug at all; the manipulation is macrophage depletion by unspecified means, and the stray 'drug-free' was carried over from a different item. Changed to 'the circulating cells in this experiment'. Boundary re-checked: the supporting passage sits under the heading 'Extravasation (Diapedesis) of Leukocytes', and diapedesis is owned by Bio Ch7, but nothing in the stem, options or discriminator tests rolling adhesion or transendothelial migration; the tested principle is the sentinel role of resident macrophages. All citations verified verbatim at the stated lines.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the recruitment of blood-borne cells into a tissue is initiated by chemical mediators released by the macrophages already living in that tissue, so removing those cells removes most of the summoning signal. Tissue-resident macrophages act as sentries: they detect distress signals from damaged or stressed cells and respond by secreting proinflammatory and chemotactic mediators into the surrounding tissue. Those mediators act on the nearby capillary endothelium and establish the chemical cue that circulating leukocytes follow. Because the circulating cells in this experiment retain a fully functional gradient-sensing apparatus, the limiting factor is the signal rather than the responder. With fewer sentries present, less signal is generated and the six-hour influx is correspondingly blunted.
>
> (Choice A) Competition for a single inert irritant is not what governs the size of a leukocyte influx, and resident cells do not suppress recruitment. Removing the local sentries removes the source of the mediators that draw cells in, so the influx should fall rather than rise.
>
> (Choice B) Circulating leukocytes do not survey the tissue outside the vessel from within the lumen. They respond to mediators that have been generated in the tissue and have reached the vessel wall, which is why local sentry cells are required.
>
> (Choice C) A sterile mineral or chemical irritant is not itself the attractant that guides leukocytes to a site. The attracting molecules are host-derived mediators released by resident cells and by damaged tissue in response to the irritant.
>
> (Choice D) Resident macrophages are the principal early source of the chemotactic mediators that summon blood leukocytes into a tissue. Depleting them leaves the responders intact but starves them of the signal, producing a smaller influx at six hours.
>
> This is a Scientific Reasoning and Problem Solving question because you must trace which step of a recruitment sequence is disabled when the tissue-resident sentries are removed.

---

## Q17 . Interpreting a Phagocyte Migration Assay

**Stem.** Phagocytes are placed in the upper compartment of a two-chamber device separated by a porous filter. A chemical attractant is added to each compartment at the levels shown, and cells reaching the lower compartment are counted after \(90\) minutes.

| Upper compartment \(\left(\text{nM}\right)\) | Lower compartment \(\left(\text{nM}\right)\) | Cells crossing |
| --- | --- | --- |
| \(0\) | \(0\) | \(14\) |
| \(0\) | \(10\) | \(148\) |
| \(0\) | \(100\) | \(305\) |
| \(100\) | \(100\) | \(22\) |
| \(100\) | \(10\) | \(16\) |

Which conclusion is best supported by these counts?

- **A.** Crossing rises with the amount of attractant in the lower compartment.
- **B.** Crossing depends on the difference between compartments rather than the amount.  <- **KEY**
- **C.** Attractant above \(10\ \text{nM}\) becomes toxic and suppresses crossing.
- **D.** Cells cross toward whichever compartment holds the smaller amount.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 100 s |
| Confidence | 5 |

**Correct answer (B): Crossing depends on the difference between compartments rather than the amount.**

Citations: openstax-microbiology.txt:52476-52477 (glossary): 'chemotaxis directional movement of a cell in response to a chemical attractant'. openstax-anatomy-physiology-2e.txt:42773-42774: 'A chemokine is a soluble chemical mediator similar to cytokines except that its function is to attract cells (chemotaxis) from longer distances.' openstax-anatomy-physiology-2e.txt:42777-42778: 'Visit this website ... to learn about phagocyte chemotaxis. Phagocyte chemotaxis is the movement of phagocytes according to the secretion of chemical messengers in the form of interleukins and other chemokines.' openstax-anatomy-physiology-2e.txt:34378-34381: 'sometimes moving toward the direction in which they are drawn by chemical signals. This attracting of leukocytes occurs because of positive chemotaxis'. All four verified verbatim at the stated lines.

**Distractors**

- **(A)** `partial_truth` . _true-for-a-subset_: Correctly describes rows one through three but is contradicted by row four, where the lower compartment holds \(100\ \text{nM}\) and only \(22\) cells cross. Absolute lower-compartment content cannot be the controlling variable.
  - Citation: openstax-anatomy-physiology-2e.txt:42773-42774
- **(C)** `misconception` . _invoke-toxicity_: Row three uses \(100\ \text{nM}\) in the lower compartment and produces the highest count in the table, so that level is not suppressive. The low counts occur only when the upper compartment is also loaded.
  - Citation: openstax-anatomy-physiology-2e.txt:42777-42778
- **(D)** `reversed_relationship` . _inverted-gradient-direction_: Row five offers a route from \(100\ \text{nM}\) toward \(10\ \text{nM}\) and yields only \(16\) crossings, indistinguishable from the no-attractant control. Cells do not migrate down the concentration difference.
  - Citation: openstax-microbiology.txt:52476-52477

**Readback check.** Content words of key B: crossing, depends, difference, between compartments, rather than, amount. The stem supplies concentrations and counts, which is data to reason from, not the conclusion. The word 'difference' never appears in the stem or table, and 'compartment' plus 'crossing' are table headers shared by all four options. No definition-to-name, no stem echo of the discriminator, no only-real-option (every distractor is a defensible reading of a subset of rows). Option lengths 11/11/9/9 words, so key B ties Choice A rather than standing out as longest. Arithmetic re-verified against the table: rows three and four both read \(100\ \text{nM}\) below (305 vs 22); rows two and five both read \(10\ \text{nM}\) below (148 vs 16); baseline is 14. Every number cited in the explanation matches the table. AUDIT CHANGES: WRONG-SOURCE CITATIONS REPLACED. The draft cited openstax-microbiology.txt:4991-4993 in the citations field and in the rationales for distractors A, C and D. That passage is the Figure 3.34 caption from Chapter 3 on prokaryote flagellar motility and describes bacterial run-and-tumble swimming, not phagocyte migration. All four references swapped for anatomy-physiology passages on phagocyte chemotaxis and chemokines. Stem, table, options and key unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because the two rows that share the same lower-compartment value give opposite results depending on what is in the upper compartment, which isolates the difference between compartments as the controlling variable. Rows three and four both have \(100\ \text{nM}\) below, yet crossing is \(305\) when the upper compartment is empty and only \(22\) when the upper compartment matches it. Rows two and five both have \(10\ \text{nM}\) below, and crossing is \(148\) with an empty upper compartment but \(16\) when the upper compartment is higher. In every condition where the two compartments are equal or the upper value exceeds the lower value, counts fall to the level of the no-attractant control. Directed migration is therefore produced by an imbalance across the filter, not by the quantity of attractant a cell encounters.
>
> (Choice A) This holds within the first three rows but fails at row four, where the lower compartment still contains \(100\ \text{nM}\) and crossing collapses to \(22\). A conclusion that a single row contradicts cannot be the best supported one.
>
> (Choice B) Pairs of rows matched for lower-compartment content differ by more than tenfold in crossing depending on the upper-compartment content. That comparison shows the imbalance across the filter, not the absolute amount, drives migration.
>
> (Choice C) Row three has \(100\ \text{nM}\) in the lower compartment and yields the highest count in the entire table at \(305\). Toxicity at that level would have to suppress crossing in row three as well, so the data rule this out.
>
> (Choice D) Row five places \(100\ \text{nM}\) above and \(10\ \text{nM}\) below, so cells offered a route toward the smaller amount would cross in large numbers. Only \(16\) cells cross, which is baseline, so movement is not directed toward lower amounts.
>
> This is a Data-based and Statistical Reasoning question because you must compare paired conditions in a migration table to identify which variable controls directed movement.

---

## Q18 . Distinguishing Resident from Recruited Phagocytes

**Stem.** A researcher asks whether the phagocytes that have engulfed an inert particle \(30\) minutes after it is placed in skin were already in the skin or arrived from the blood. A fluorescent label can be injected intravenously and is taken up only by cells that are inside blood vessels at the time of injection.

Which design would best answer this question?

- **A.** Inject the label before placing the particle, then score labeling among particle-containing skin phagocytes.  <- **KEY**
- **B.** Inject the label \(30\) minutes after placing the particle, then score labeling among particle-containing skin phagocytes.
- **C.** Count particle-containing skin phagocytes immediately before and \(30\) minutes after placing the particle.
- **D.** Count labeled leukocytes in the blood immediately before and \(30\) minutes after placing the particle.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (A): Inject the label before placing the particle, then score labeling among particle-containing skin phagocytes.**

Citations: openstax-microbiology.txt:31632-31635: 'When monocytes leave the bloodstream and enter a specific body tissue, they differentiate into tissue-specific phagocytes called macrophages and dendritic cells ... Macrophages and dendritic cells can reside in body tissues for significant lengths of time.' openstax-microbiology.txt:31717-31718: 'The first to arrive typically are neutrophils, often within hours of a bacterial infection. By contract, monocytes may take several days to leave the bloodstream and differentiate into macrophages.' openstax-anatomy-physiology-2e.txt:42682-42685: 'Macrophages move through tissues and squeeze through capillary walls using pseudopodia ... Macrophages exist in many tissues of the body, either freely roaming through connective tissues or fixed to reticular fibers within specific tissues such as lymph nodes.' openstax-microbiology.txt:31422-31425: 'All of the formed elements of blood are derived from multipotent hematopoietic stem cells (HSCs) in the bone marrow.' All four verified verbatim at the stated lines.

**Distractors**

- **(B)** `process_step_confusion` . _marker-applied-after-the-event_: Applying the origin marker after the migration window has already elapsed leaves emigrated cells unlabeled, so blood-derived and resident phagocytes become indistinguishable. The design collects the marker at the only time it carries no information.
  - Citation: openstax-microbiology.txt:31717-31718
- **(C)** `adjacent_fact` . _measures-quantity-not-origin_: Counts of particle-containing cells change for many reasons, including local movement of resident cells toward the particle. The design measures abundance when the question is about provenance.
  - Citation: openstax-anatomy-physiology-2e.txt:42682-42685
- **(D)** `adjacent_fact` . _wrong-compartment-readout_: Sampling the blood compartment cannot attribute any individual skin phagocyte to a blood origin and is confounded by marrow release and vessel tone. It is an indirect proxy for the variable the question specifies.
  - Citation: openstax-microbiology.txt:31422-31425

**Readback check.** Content words of key A: inject, label, before, placing the particle, score labeling, particle-containing skin phagocytes. Every one of those referents except 'before' is shared with Choice B, which is identical apart from the timing word, so the discriminator is 'before' versus '\(30\) minutes after'. Neither ordering appears in the stem; the stem supplies only the label's property and the biological question. No definition-to-name, no stem echo of the discriminator, no self-justifying key. Key A at 14 words is shorter than Choice B at 16 and Choice D at 15. AUDIT: unchanged apart from one word of style ('plagues' softened to 'affects' in the explanation). All four citations were re-greped and verified verbatim at the stated lines. Key correctness re-checked: the item asks which DESIGN answers the question, so the biological plausibility of blood-derived phagocytes arriving within \(30\) minutes does not bear on whether Choice A is the correct design, and Choice A remains unambiguously the only schedule that tags the blood pool while the two populations are still separate.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because labeling the blood pool before the challenge marks every cell that could later emigrate, so label status in a particle-containing skin phagocyte reports directly on that cell's origin. The question is one of provenance rather than of number, so the design must tag one candidate population at a moment when the two populations are still separated. Injecting the label first marks only cells inside vessels; any skin phagocyte found \(30\) minutes later carrying both the label and the particle must have crossed out of the circulation, and any unlabeled particle-containing cell must have been resident. This is a single-animal readout that does not depend on comparing totals across time, so it is insensitive to the sampling noise that affects counting approaches.
>
> (Choice A) Pre-labeling establishes an origin marker at a time when blood cells and skin cells are still distinct populations. Scoring label and particle together in the same cell therefore assigns each engulfing phagocyte to a source without further assumption.
>
> (Choice B) Labeling after the particle has been in place for \(30\) minutes marks the blood pool only from that moment onward. Cells that had already emigrated during those \(30\) minutes would carry no label and would be indistinguishable from cells that were resident all along, so the design cannot separate the two possibilities.
>
> (Choice C) A change in the number of particle-containing skin phagocytes says nothing about where those cells came from, because resident cells can also migrate within the tissue toward the particle. The measure is silent on the actual variable of interest.
>
> (Choice D) A change in circulating leukocyte number is an indirect readout that is easily confounded by marrow release, vessel tone, and margination. It never links any individual particle-containing skin phagocyte to a blood origin.
>
> This is a Reasoning about the Design and Execution of Research question because you must choose the labeling schedule that separates cells already present in a tissue from cells that emigrated from the circulation.

---

## Q19 . Vascular Change and Delivery of Plasma Components

**Stem.** An animal is given a drug that blocks histamine receptors on blood vessel walls, and a sterile splinter is then placed under its skin. One hour later the site shows much less swelling than the same site in an untreated animal.

Which additional finding at the treated site is most likely?

- **A.** Reduced internalization of debris by phagocytes already stationed in that tissue.
- **B.** Increased blood flow through the vessels that supply the site.
- **C.** Reduced accumulation of blood-derived proteins in the tissue around the splinter.  <- **KEY**
- **D.** Reduced numbers of phagocytes circulating in the blood entering the site.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (C): Reduced accumulation of blood-derived proteins in the tissue around the splinter.**

Citations: openstax-anatomy-physiology-2e.txt:42865-42868: 'Histamine increases the diameter of local blood vessels (vasodilation), causing an increase in blood flow. Histamine also increases the permeability of local capillaries, causing plasma to leak out and form interstitial fluid. This causes the swelling associated with inflammation.' openstax-anatomy-physiology-2e.txt:42890-42891: 'Not only are the pathogens killed and debris removed, but the increase in vascular permeability encourages the entry of clotting factors, the first step towards wound repair.' openstax-microbiology.txt:31909-31913: 'Vasoconstriction is followed by vasodilation and increased vascular permeability, as a direct result of the release of histamine from resident mast cells. Increased blood flow and vascular permeability can dilute toxins and bacterial products at the site of injury or infection. They also contribute to the five observable signs associated with the inflammatory response: erythema (redness), edema (swelling), heat, pain, and altered function.' openstax-microbiology.txt:31929-31931 (Figure 17.23 caption): 'Histamine increases blood flow to the wound site, and increased vascular permeability allows fluid, proteins, phagocytes, and other immune cells to enter infected tissue.' All four verified verbatim at the stated lines.

**Distractors**

- **(A)** `misconception` . _vascular-block-read-as-cell-block_: Attributes a defect to the phagocytes themselves when the drug target is on vessel walls. Resident phagocytes retain full recognition and engulfment capacity because their receptors are unaffected.
  - Citation: openstax-anatomy-physiology-2e.txt:42874-42876
- **(B)** `reversed_relationship` . _flow-increases-when-dilation-blocked_: Inverts the effect of blocking a vasodilator signal. Without the dilating action, local vessel caliber and flow fall relative to an inflamed control, which is why the site also loses heat and redness.
  - Citation: openstax-anatomy-physiology-2e.txt:42874-42876
- **(D)** `adjacent_fact` . _wrong-compartment-for-the-effect_: Confuses the size of the circulating pool with delivery into one tissue site. Marrow production and release set the blood count, and this drug alters neither.
  - Citation: openstax-microbiology.txt:31422-31425

**Readback check.** Content words of key C: reduced, accumulation, blood-derived proteins, tissue, around the splinter. The stem contains 'histamine receptors', 'blood vessel walls', 'splinter', and 'swelling'. 'Splinter' is the shared site referent used by the stem and required by any option naming the location. 'Blood-derived proteins' and 'accumulation' appear nowhere in the stem, and the stem states only that swelling is reduced, never that protein delivery is reduced, so the causal link must be supplied by the test taker. No definition-to-name, no stem echo of the discriminator, no restated premise. Option lengths 11/10/11/11, so key C does not stand out. AUDIT CHANGES: (1) PHYSIOLOGICAL TIMING CORRECTED. The draft observed the site 'Twenty-four hours later', but histamine drives the immediate and early phase of acute inflammation, and by twenty-four hours a receptor blocker would be a poor explanation for reduced swelling in a sterile foreign-body response. Changed to 'One hour later', which places the observation in the window the cited passages actually describe. (2) MISLABELLED DISTRACTOR CATEGORY FIXED. Choice D was tagged 'scale_unit_error', but it involves no scale, magnitude or unit mistake; it confuses the circulating pool with delivery into one tissue site. Recategorized as 'adjacent_fact'. Boundary re-checked: the item reasons about inflammatory permeability and plasma protein delivery as an immune-defense route and performs no Starling-force or oedema arithmetic, so it stays clear of Bio Ch7 territory. All four citations verified verbatim at the stated lines.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the same vascular change that produces visible swelling is the change that lets plasma proteins escape into the tissue, so blocking it must reduce both together. Histamine acting on local vessels widens them and increases the permeability of their walls, which allows plasma to leak into the interstitial space. That leakage is not merely a cosmetic side effect of inflammation: it is the route by which blood-derived defensive and repair molecules, including clotting factors, gain access to a damaged site. A drug that blocks the receptors mediating this change therefore reduces the swelling and the delivery of blood-borne protein by a single common mechanism. The tissue's own resident cells are untouched by a drug directed at vascular receptors.
>
> (Choice A) The drug acts on receptors expressed by vessel walls, not on the binding and engulfment machinery of a phagocyte. Cells already stationed in the tissue continue to recognize and internalize debris at their usual rate.
>
> (Choice B) Loss of the vasodilating signal reduces the caliber of local vessels relative to an inflamed control, so local flow falls rather than rises. This is why a blocked site also loses the warmth and redness of the untreated site.
>
> (Choice C) Increased permeability of local vessels is what allows plasma and its dissolved proteins to enter the interstitium, and it is also what produces the swelling. Blocking the receptors that drive that permeability change reduces the interstitial protein load along with the swelling.
>
> (Choice D) The number of phagocytes circulating in blood is set by production in marrow and release into the circulation, neither of which this drug alters. Fewer cells may end up in the tissue, but the blood pool itself is not depleted.
>
> This is a Scientific Reasoning and Problem Solving question because you must infer what else is lost when the vascular permeability change underlying inflammatory swelling is blocked.

---

## Q20 . Resident Versus Recruited Populations Over Time

**Stem.** A microbial extract is placed in the dermis of two animals; the second animal first receives a drug that prevents leukocytes from responding to chemical gradients. Cell P normally resides in dermis and cell Q normally circulates in blood, and counts of each per microscope field at the site are shown.

| Time after placement | P, untreated | Q, untreated | P, drug | Q, drug |
| --- | --- | --- | --- | --- |
| \(0.5\ \text{h}\) | \(41\) | \(2\) | \(40\) | \(2\) |
| \(6\ \text{h}\) | \(47\) | \(205\) | \(45\) | \(8\) |

Which conclusion about the cell Q population present at \(6\ \text{h}\) is best supported by these counts?

- **A.** It arose from division of the cell Q already at the site at \(0.5\ \text{h}\).
- **B.** It arose from conversion of resident cell P into cell Q.
- **C.** It arrived from the blood along a signal generated at the site.  <- **KEY**
- **D.** It arrived from the blood after bone marrow raised its output.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 125 s |
| Confidence | 5 |
| Hard-tier gate | Meets three conditions. (1) CONCEPT CHAINING: the test taker must combine the resident-versus-recruited distinction, the requirement that recruitment follows a signal generated in the challenged tissue, and the logic of reading a pharmacological control before any conclusion is possible. (2) DATA-TO-MECHANISM: nothing in the stem states where the late population comes from; the origin must be extracted from a four-column, two-timepoint table by making within-row and across-treatment comparisons. (4) 510-TEMPTING DISTRACTOR: Choice A, local proliferation of the few cells present at half an hour, is the standard alternative explanation for a rising count and is defeated only by noticing that both animals start from the same \(2\) cells. |

**Correct answer (C): It arrived from the blood along a signal generated at the site.**

Citations: openstax-microbiology.txt:31697-31703: 'Some phagocytes are leukocytes (WBCs) that normally circulate in the bloodstream. To reach pathogens located in infected tissue, leukocytes must pass through the walls of small capillary blood vessels within tissues. This process ... is initiated by complement factor C5a, as well as cytokines released into the immediate vicinity by resident macrophages and tissue cells ... many of these cytokines are proinflammatory and chemotactic'. openstax-microbiology.txt:31717-31718: 'The first to arrive typically are neutrophils, often within hours of a bacterial infection. By contract, monocytes may take several days to leave the bloodstream and differentiate into macrophages.' openstax-microbiology.txt:31632-31635: 'When monocytes leave the bloodstream and enter a specific body tissue, they differentiate into tissue-specific phagocytes called macrophages and dendritic cells ... Macrophages and dendritic cells can reside in body tissues for significant lengths of time.' openstax-microbiology.txt:31723-31728 (Figure 17.19 caption): 'Leukocytes exit the blood vessel and follow the chemoattractant signal of cytokines and C5a to the site of infection.' openstax-microbiology.txt:31422-31425: 'All of the formed elements of blood are derived from multipotent hematopoietic stem cells (HSCs) in the bone marrow.' All five verified verbatim at the stated lines.

**Distractors**

- **(A)** `misconception` . _local-proliferation-explains-the-rise_: Both animals begin with the same two Q cells at the site, so division would produce comparable six-hour counts in both, which it does not. Expansion from two to \(205\) in \(5.5\ \text{h}\) also exceeds any plausible leukocyte division rate.
  - Citation: openstax-microbiology.txt:31717-31718
- **(B)** `adjacent_fact` . _conversion-in-the-wrong-direction_: The real differentiation step runs the other way, with blood-borne cells entering tissue and maturing into resident phagocytes, not resident cells converting into circulating ones. The data also show P rising rather than being consumed as Q climbs.
  - Citation: openstax-microbiology.txt:31632-31635
- **(D)** `process_step_confusion` . _blame-the-wrong-step_: Relocates the explanation from gradient-directed arrival to marrow production, which counts at a tissue site cannot address and which would not by itself move cells across a vessel wall. The stem specifies that the drug acts on gradient responses.
  - Citation: openstax-microbiology.txt:31422-31425

**Readback check.** Content words of key C: arrived, blood, along a signal, generated, at the site. 'Arrived from the blood' is shared verbatim with Choice D, so it is a shared referent rather than a discriminator, and the stem's 'normally circulates in blood' is the population definition that Choices A, B and D all require. The word 'signal' appears nowhere in the stem, which says only that the drug prevents responding to chemical gradients; that the site generates a cue is a conclusion the test taker must derive from the treated-versus-untreated divergence. No definition-to-name, no stem echo of the discriminator, no restated premise. Option lengths 15/10/12/11, so key C is not the longest. Table arithmetic re-verified: P rises 41 to 47 and 40 to 45; Q rises 2 to 205 untreated and 2 to 8 treated; every figure quoted in the explanation matches. AUDIT CHANGES: PARALLELISM DEFECT REBUILT. In the draft, Choices A, B and C were mechanistic claims naming the drug or a cell ('The drug blocks...', 'The drug halts...', 'The cell Q ... arises from division') while the keyed Choice D was a two-clause semicolon conclusion naming no cell and no drug ('Early defense rests on cells already in the tissue; the later rise requires guided movement'). The key was the only summary-shaped option and the only structural outlier, which is a test-wiseness giveaway answerable without topic knowledge. All four options were rebuilt as parallel single-clause claims about the origin of the six-hour cell Q population, the key moved to C, and the explanation, distractor rationales and citations were re-derived. The hard tier was re-tested against the new options and still clears three gate conditions.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the six-hour population appears only when gradient following is intact, which places its origin in the circulation and identifies a locally generated signal as the thing the cells are following. At \(0.5\ \text{h}\) the two animals are indistinguishable, with roughly \(40\) P cells and \(2\) Q cells each, so the earliest cells at the site are the ones that already lived there. By \(6\ \text{h}\) the untreated site holds \(205\) Q cells against \(8\) in the treated site, a difference of more than twentyfold, while P is essentially unchanged in both animals. The only variable separating the animals is the ability to respond to a gradient, so the late Q population must have traveled to the site along a cue generated there rather than having arisen in place. This is the two-phase structure of an innate response: an immediate contribution from stationed cells followed by a much larger recruited wave.
>
> (Choice A) Both animals begin with the same \(2\) Q cells at the site, so local division would be expected to yield comparable six-hour counts in both, which it does not. Expansion from \(2\) to \(205\) in \(5.5\ \text{h}\) would also demand a division rate far beyond what leukocytes achieve.
>
> (Choice B) Cell P is not consumed in either animal, rising from \(41\) to \(47\) untreated and from \(40\) to \(45\) treated. Conversion of P into Q would draw the P count down as Q climbed, and no such drawdown appears in either column.
>
> (Choice C) Equal half-hour counts identify the tissue-dwelling cell as the early responder, and the divergence at six hours shows that the late influx requires an intact gradient response. Cells that must follow a gradient in order to arrive are arriving from somewhere else, and the signal they follow is generated at the challenged site.
>
> (Choice D) Marrow output cannot be read from counts taken at a tissue site, and raising production alone would not move cells across a vessel wall into the dermis. The drug is specified to act on gradient responses rather than on production.
>
> This is a Data-based and Statistical Reasoning question because you must compare two cell populations across two time points and two treatments to determine where the late influx originates.

---

## Q21 . Antigen Transport to a Lymphoid Organ

**Stem.** A large protein antigen that remains largely trapped in skin is taken up by skin sentinel phagocytes, which degrade it and display peptide fragments on their surface. In one animal these cells display fragments normally but cannot respond to the chemical cue that draws them into lymphatic vessels.

Compared with a normal animal, this animal most likely shows:

- **A.** expansion of antigen-specific lymphocytes in bone marrow, where such cells are produced.
- **B.** little expansion of antigen-specific lymphocytes in the draining lymph node.  <- **KEY**
- **C.** normal expansion of antigen-specific lymphocytes, since they patrol peripheral tissue directly.
- **D.** normal expansion of antigen-specific lymphocytes, since node-resident phagocytes display the fragments.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 120 s |
| Confidence | 5 |
| Hard-tier gate | Meets three conditions. (1) CONCEPT CHAINING: the chain runs from antigen capture in a peripheral tissue, to trafficking into lymphatics, to display in a lymphoid organ, to selection and expansion of a matching clone, and the test taker must locate which link the lesion breaks. (3) TRUE PARTIAL-TRUTH TRAP: Choice D states something entirely correct in isolation, that lymph nodes contain their own antigen-presenting phagocytes, and fails only because those cells cannot display material that was never delivered. (4) 510-TEMPTING DISTRACTOR: Choice C encodes the widespread belief that lymphocytes survey peripheral tissue directly, which would make the trafficking step dispensable. |

**Correct answer (B): little expansion of antigen-specific lymphocytes in the draining lymph node.**

Citations: openstax-anatomy-physiology-2e.txt:42892-42893: 'Inflammation also facilitates the transport of antigen to lymph nodes by dendritic cells for the development of the adaptive immune response.' openstax-microbiology.txt:46420-46431: 'The primary lymphoid tissue includes bone marrow and the thymus. Bone marrow contains the hematopoietic stem cells (HSC) that differentiate and mature into the various types of blood cells and lymphocytes ... The secondary lymphoid tissues include the spleen, lymph nodes ... Lymph nodes are bean-shaped organs situated throughout the body. These structures contain areas called germinal centers that are rich in B and T lymphocytes. The lymph nodes also contain macrophages and dendritic cells for antigen presentation.' openstax-microbiology.txt:32882-32884: 'once the most antigenic, immunodominant epitopes have been processed, they associate within the antigen-binding cleft of MHC II molecules and are translocated to the cell surface of the dendritic cell for presentation to T cells.' openstax-microbiology.txt:31638-31639: 'Dendritic cells are important sentinels residing in the skin and mucous membranes, which are portals of entry for many pathogens.' openstax-microbiology.txt:31823-31827: 'Macrophages and dendritic cells are also antigen-presenting cells involved in the specific adaptive immune response. These cells further process the remains of the degraded pathogen and present key antigens (specific pathogen proteins) on their cellular surface.' All five verified verbatim at the stated lines.

**Distractors**

- **(A)** `adjacent_fact` . _primary-for-secondary-lymphoid-organ_: Bone marrow is a primary lymphoid tissue where lymphocytes are produced, and production is antigen independent. Selection and expansion of a matching clone occur in secondary lymphoid tissue where displayed antigen and recirculating lymphocytes meet.
  - Citation: openstax-microbiology.txt:46420-46423
- **(C)** `misconception` . _lymphocytes-survey-tissue-directly_: Treats peripheral tissue as the screening compartment, which would make antigen transport unnecessary. The unselected lymphocyte pool recirculates through lymphoid organs, and the rare matching clone is very unlikely to be present in that skin patch.
  - Citation: openstax-microbiology.txt:46427-46431
- **(D)** `partial_truth` . _true-cells-no-cargo_: Correctly notes that lymph nodes contain their own presenting phagocytes, but those cells can only display antigen that has been delivered to the node. With the antigen trapped in skin and its carrier immobilized, nothing arrives for them to present.
  - Citation: openstax-microbiology.txt:46427-46429

**Readback check.** Content words of key B: little expansion, antigen-specific lymphocytes, draining lymph node. 'Antigen-specific lymphocytes' appears in all four options and is the shared referent every option requires. The stem contains 'antigen', 'skin', 'peptide fragments', 'sentinel phagocytes', and 'lymphatic vessels'; it never contains 'lymph node', 'expansion', or 'selection'. The stem supplies the lesion (cannot respond to the cue that draws the cell into lymphatics) as data, not the conclusion that node-based selection fails. No definition-to-name, no stem echo of the discriminator, no only-real-option, no self-justifying key. Key B at 10 words is the shortest of the four. AUDIT: unchanged. The key was re-tested against the obvious objection that free antigen can drain to a node on its own, and the stem forecloses it by specifying a large protein antigen that 'remains largely trapped in skin', which is also what Choice D's rationale turns on. Boundary re-checked: the thymus is never mentioned, so Bio Ch5 territory is untouched, and antibody architecture and isotypes never appear, so Biochem Ch3 and Bio Ch3 are untouched. All five citations re-greped and verified verbatim at the stated lines.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because displayed antigen must physically reach the lymphoid organ where circulating lymphocytes are screened, and blocking the carrier's exit from the skin severs that delivery step. Selection of a lymphocyte clone is a numbers problem: only a vanishingly small fraction of lymphocytes carries a receptor matching any given antigen, so the immune system solves it by funneling both the displayed antigen and the recirculating lymphocyte pool into the same small structures. Lymph nodes and spleen are exactly those structures, and they contain the phagocytes that perform presentation as well as germinal centers rich in B and T lymphocytes. In this animal the display step works and the antigen is processed correctly, but the cell holding the display stays in the skin. With the display and the responder pool never brought together, few matching lymphocytes are selected and expanded in the draining node.
>
> (Choice A) Bone marrow is the site where these cells are produced, but production is independent of any particular antigen. Selection of a matching clone and its expansion occur where displayed antigen and recirculating lymphocytes meet, which is a secondary lymphoid organ rather than marrow.
>
> (Choice B) The trapped antigen cannot reach the node on its own, and the cell carrying its display cannot leave the skin. Because clonal selection requires the displayed fragment and the rare matching lymphocyte to encounter one another in a lymphoid organ, expansion in the draining node is markedly reduced.
>
> (Choice C) Peripheral tissue is patrolled by innate cells and by lymphocytes that have already been activated, not by the unselected pool that must be screened first. The single lymphocyte in the pool that matches this antigen is very unlikely to be sitting in that patch of skin.
>
> (Choice D) Lymph nodes do contain their own phagocytes capable of presenting antigen, but those cells can only display material that has been delivered to them. Since the antigen stays in the skin and its carrier cannot travel, the node's own presenting cells have nothing to show.
>
> This is a Scientific Reasoning and Problem Solving question because you must trace how blocking the movement of an antigen-bearing cell out of a peripheral tissue affects lymphocyte selection in a lymphoid organ.

---

## Q22 . Innate Triggering by Damage Versus Non-Self

**Stem.** A sterile glass sliver carrying no microbial molecules is placed in the tissue of an animal. Redness, swelling and phagocyte accumulation develop with the same timing and magnitude as at a second site given a heat-treated microbial preparation.

Which explanation best accounts for the response to the sliver?

- **A.** Contents spilled from injured host cells engage the same receptors and mediators.  <- **KEY**
- **B.** Receptors that detect conserved microbial patterns bind the mineral surface of the sliver.
- **C.** Lymphocytes carrying receptors matched to the sliver drive the early cellular influx.
- **D.** Antibody raised against the sliver over the same interval directs the arriving cells.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 100 s |
| Confidence | 5 |

**Correct answer (A): Contents spilled from injured host cells engage the same receptors and mediators.**

Citations: openstax-microbiology.txt:31773-31775: 'PRRs on macrophages also respond to chemical distress signals from damaged or stressed cells. This allows macrophages to extend their responses beyond protection from infectious diseases to a broader role in the inflammatory response initiated from injuries or other diseases.' openstax-anatomy-physiology-2e.txt:42834-42836: 'It is important to note that inflammation does not have to be initiated by an infection, but can also be caused by tissue injuries. The release of damaged cellular contents into the site of injury is enough to stimulate the response, even in the absence of breaks in physical barriers that would allow pathogens to enter (by hitting your thumb with a hammer, for example).' openstax-microbiology.txt:31899-31903: 'The inflammatory response, or inflammation, is triggered by a cascade of chemical mediators and cellular responses that may occur when cells are damaged and stressed or when pathogens successfully breach the physical barriers of the innate immune system.' openstax-microbiology.txt:31752-31758: 'Common PAMPs include the following: peptidoglycan, found in bacterial cell walls; flagellin, a protein found in bacterial flagella; lipopolysaccharide (LPS) from the outer membrane of gram-negative bacteria; lipopeptides, molecules expressed by most bacteria; and nucleic acids such as viral DNA or RNA.' openstax-microbiology.txt:32877-32878: 'Proteases (protein-degrading) are especially important in antigen processing because only protein antigen epitopes are presented to T cells by MHC II'. All five verified verbatim at the stated lines.

**Distractors**

- **(B)** `misconception` . _innate-equals-microbial-detection_: The sliver is stated to carry no microbial molecules, so pattern receptors have no ligand on it. Treating microbial pattern detection as the only innate trigger would predict no response to a sterile object at all.
  - Citation: openstax-microbiology.txt:31752-31758
- **(C)** `adjacent_fact` . _adaptive-cell-on-an-innate-timescale_: Lymphocytes reach inflamed tissue only after antigen has been processed, displayed and matched to a rare clone, which takes days. A mineral fragment also supplies no protein epitopes, so no sliver-specific clone exists to be recruited at any timepoint.
  - Citation: openstax-microbiology.txt:31823-31827
- **(D)** `process_step_confusion` . _adaptive-product-on-an-innate-timescale_: Antibody production requires protein epitopes and develops over days, whereas a mineral fragment supplies no protein and the response here is immediate. It assigns an adaptive effector to a step that occurs before any adaptive response could exist.
  - Citation: openstax-microbiology.txt:32877-32878

**Readback check.** Content words of key A: contents spilled, injured host cells, engage, same receptors, mediators. The stem contains 'sterile glass sliver', 'no microbial molecules', 'redness, swelling and phagocyte accumulation', and 'heat-treated microbial preparation'. It never uses 'injured', 'damaged', 'spilled', 'receptors', or 'mediators'. The stem supplies the equivalence of the two responses as data to reason from, not the conclusion that damage signals are the trigger. No definition-to-name, no stem echo of the discriminator, no restated premise. Option lengths 12/13/12/13, so key A is not the longest. AUDIT CHANGES: (1) HARD GATE FAILED AND RE-TIERED. See hard_gate_conditions; the item was labeled hard on four claimed conditions, only one of which survives scrutiny, so difficulty and structural_axis were lowered to medium and estimated time reduced from 115 to 100 seconds. (2) FACTUALLY WRONG EXPLANATION CLAUSE CORRECTED. The draft's Choice C block read that matched lymphocytes 'do accumulate at inflamed sites, but they are present in tiny numbers at the outset and require antigen to be processed and displayed before they expand', which implies that an adaptive response to sterile glass would eventually develop. A mineral fragment presents no protein epitopes, so there is no sliver-specific clone at any timepoint; the block and the Choice C distractor rationale were rewritten to say so. (3) The Choice C distractor was recategorized from 'partial_truth' to 'adjacent_fact', since the claim is not true at a later timescale and therefore was never a partial truth. All five citations verified verbatim at the stated lines.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because innate sensing is triggered by signals from damaged host cells as well as by non-self molecules, so a sterile object that injures tissue produces the same downstream response. Innate recognition operates through receptors on phagocytes, and those receptors respond both to conserved molecular patterns shared by microbes and to distress signals released by damaged or stressed host cells. Either input activates the same phagocyte program and the same release of mediators that dilate vessels, raise permeability, and recruit further cells. This is why an injury with no microbial component at all, such as a crush injury or an embedded fragment, produces redness, swelling, heat, and pain on the same schedule as a microbial challenge. The identical timing and magnitude at the two sites is exactly what a shared downstream pathway predicts.
>
> (Choice A) Molecules released when host cells are torn open act on innate receptors and set off the same mediator cascade that microbial molecules do. Because the two inputs converge on one output, a sterile injury and a microbial preparation can generate responses of matched size and speed.
>
> (Choice B) The sliver is stated to carry no microbial molecules, so receptors that recognize conserved microbial structures have nothing to bind on it. If pattern recognition were the only available trigger, a sterile object would provoke no response at all, which contradicts the observation.
>
> (Choice C) Lymphocytes do accumulate at sites of inflammation, but they act only after antigen has been processed, displayed, and matched to a rare clone, which takes days rather than the interval described here. A mineral fragment also presents no protein epitopes for such a receptor to match, so no sliver-specific lymphocyte population exists to drive the influx.
>
> (Choice D) Antibody directed at a newly encountered material develops over a period of days, and it is raised against protein epitopes, which a mineral fragment does not supply. The response described here unfolds on the timescale of the innate reaction, far too quickly for antibody to be organizing it.
>
> This is a Scientific Reasoning and Problem Solving question because you must explain why a sterile object provokes an innate response equal to that provoked by microbial material.

---



---

# BATCH 2 of 4 (24 questions): MHC and T lymphocytes

Units: the major histocompatibility complex and antigen presentation (12) . T lymphocytes and
cell-mediated immunity (12).

**The bank had zero questions touching MHC before this batch**, despite MHC being named explicitly in
the AAMC content outline. This was the largest single coverage gap in the chapter.

## Batch 2 summary

| Metric | Batch 2 | Combined (46) | Target |
|---|---|---|---|
| Difficulty | easy 6 . hard 9 . medium 9 | easy 12 . hard 14 . medium 20 | 27/40/33 |
| Answer letter | A 5 . B 6 . C 6 . D 7 | A 13 . B 11 . C 11 . D 11 | ~25% each |
| Cognitive skill | S1 4 . S2 12 . S3 4 . S4 4 | S1 4 . S2 28 . S3 6 . S4 8 | mixed |
| Confidence | conf4 6 . conf5 18 | conf4 7 . conf5 39 | only 4-5 ship |
| Roman numeral | 4 (17%) | 5 (11%) | 10-15% |
| Distractor categories | adjacent_fact 11 . misconception 22 . partial_truth 17 . process_step_confusion 7 . reversed_relationship 12 . scale_unit_error 3 | | none dominant |
| Em/en dashes | 0 | 0 | 0 |

**Deficits from batch 1, now cleared.** Batch 1 ran answer letter A at 36 percent and D at 18 percent,
was easy-heavy, had no skill 1 items and only one Roman numeral question. Batch 2 was given explicit
target **counts** per letter rather than a direction, after a Ch7 batch overshot twice when told simply
to "bias toward D". The counts landed exactly: A 5, B 6, C 6, D 7; easy 6, medium 9, hard 9; Roman
numeral 4; skills 4 / 12 / 4 / 4. Combined letters are now 28 / 24 / 24 / 24.

**Carried into batches 3 and 4:** skill 1 is still light at 9 percent combined, and the hard tier sits
at 30 percent against a 33 percent target.

**Two build failures worth recording.**

1. *Drafter size ceiling.* The first attempt used two writers producing 12 questions each. A workflow
   subagent is killed after 180 seconds without a tool-call checkpoint, and a finished question is
   roughly 8 KB of JSON, so a 12-question emission is about 100 KB in one unbroken generation. Both
   writers stalled on all six retry attempts and the batch returned nothing after four hours. Every
   successful batch in this bank has used drafters of 3 to 4 questions. Batch 2 was rebuilt as six
   4-question slices with per-slice quotas summing to the batch target, and completed in ten minutes.

2. *Wrong distractor enum.* The rewritten batch 2 spec invented six distractor category names
   (correct_but_irrelevant, plausible_misconception, and so on) that are not the six the database
   accepts. `question_distractor_metadata.distractor_category` carries a CHECK constraint admitting
   only: misconception, adjacent_fact, partial_truth, reversed_relationship, process_step_confusion,
   scale_unit_error. All 72 distractor rows would have been rejected on insert. Caught by reading the
   live SQL editor output from batch 1, fixed in both the drafter and auditor prompts, and now
   asserted in code before any SQL is written.

**Scope convention verified by automated scan:** zero occurrences of CD4, CD8, helper T, cytotoxic T,
regulatory T, suppressor T, dendritic, natural killer, NK cell, complement, interferon, plasma cell,
memory cell, any immunoglobulin isotype, immunoglobulin, opsonisation, agglutination, T-cell receptor,
TCR, class I, class II, MHC-I, MHC-II, positive selection, negative selection, cytokine, interleukin,
costimulation, perforin, granzyme.

**Chapter boundaries:** automated scan for the seven forbidden territories returned zero hits. No
subtopic is duplicated within batch 2 or against batch 1, and no key is a near-duplicate of a batch 1 key.

**Adversarial audit:** all 24 re-examined by an independent pass per slice that re-greped every
citation against OpenStax Anatomy and Physiology 2e and OpenStax Microbiology.

---

## B2-Q1 . Detecting an Entirely Intracellular Infection

**Stem.** A virus completes its entire replication cycle within a liver cell. Nothing recognisable from the invader is ever exposed on the outer face of that cell's membrane, and circulating antibody cannot cross that membrane to reach what lies inside. Nevertheless a patrolling lymphocyte of the lineage that kills its target directly singles this cell out for destruction.

What property of the liver cell makes this identification possible?

- **A.** The virus inserts whole copies of its own coat proteins into the outer membrane, where they project outward as intact foreign structures rather than as processed pieces.
- **B.** The patrolling cell mounts samples of its own interior in its major histocompatibility complex grooves and the liver cell inspects them, so the inspection runs from the immune cell toward the target.
- **C.** The liver cell routinely digests a sample of the proteins built in its own interior and mounts the resulting short pieces in a groove on its major histocompatibility complex molecules.  <- **KEY**
- **D.** The infected cell secretes a diffusible signal that slows viral replication in neighbouring cells, and the patrolling cell homes to the source of that signal.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (C): The liver cell routinely digests a sample of the proteins built in its own interior and mounts the resulting short pieces in a groove on its major histocompatibility complex molecules.**

Citations: AP:43614 (antibodies are not able to penetrate the plasma membrane of the cell, so pathogens already inside a cell are beyond the reach of dissolved defences); MICRO:32904 (in a healthy cell, proteins normally found in the cytoplasm are degraded by enzyme complexes and processed into self fragments); MICRO:32906 (those fragments bind within the antigen binding cleft of the display molecule and are then presented on the cell surface); MICRO:32908 (if a cell becomes infected with an intracellular pathogen, protein antigens specific to that pathogen are processed and bound for presentation the same way); AP:43004 (it is the combination of the display molecule and the fragment of the original peptide that is physically recognised)

**Distractors**

- **(A)** `misconception` . _whole antigen on the surface_: Rests on the common belief that a lymphocyte must meet an intact foreign structure on the cell exterior. The stem excludes this, and processed short pieces rather than whole proteins are what occupy the display groove.
  - Citation: MICRO:32904
- **(B)** `reversed_relationship` . _inverted display and inspection roles_: Reverses which cell displays and which reads. The suspect cell exhibits its own internal products and the patrolling cell reads them, not the other way round.
  - Citation: MICRO:32906
- **(D)** `partial_truth` . _diffusible antiviral signal as a locator_: Infected cells really do release a diffusible signal that slows viral replication, but such a signal covers a whole field of cells and cannot identify the single cell that harbours the invader, so it cannot account for targeted killing.
  - Citation: AP:43620

**Readback check.** Content words of six or more letters in key C: routinely, digests, sample, proteins, interior, mounts, resulting, pieces, groove, major, histocompatibility, complex, molecules. Stem six-plus words: completes, entire, replication, within, Nothing, recognisable, invader, exposed, membrane, circulating, antibody, cannot, inside, Nevertheless, patrolling, lymphocyte, lineage, target, directly, singles, destruction, property, identification, possible. Zero overlap, so the key cannot be produced by lifting a phrase from the stem. The display molecule is also named in distractor B as well as in the key, so the technical term cannot be used as a shortcut, and the student must supply the idea of internal sampling and outward mounting, which the stem never mentions.

**Explanation (as shipped).**

> This question belongs to the Organ Systems content category and tests antigen presentation, specifically how an infection sealed inside a cell is made legible to a patrolling killer lymphocyte. The answer is C because a nucleated cell constantly samples the proteins it builds in its own interior, cuts them into short pieces, and seats those pieces in a groove on its major histocompatibility complex molecules, so an event confined to the cytosol acquires an outward readout. Antibody is a soluble blood protein and cannot cross an intact membrane, which means surveillance by dissolved proteins stops at the outer leaflet and can say nothing about what a living cell contains. The solution the body uses is to make each cell report on itself: whatever the cell is synthesising, including anything a virus compels it to synthesise, enters the sampling stream automatically. The patrolling cell therefore never sees the virus at all. What it sees is a short sequence that does not belong to the catalogue of the body's own products, held in the display groove, and recognition is of that combined unit rather than of the pathogen itself. (Choice A) Some enveloped viruses do insert glycoproteins into the host membrane, but the stem specifies that nothing recognisable from the invader is exposed there, and a surveillance system that required intact foreign structures on the outside would miss every pathogen that keeps its products internal. (Choice B) This inverts the direction of inspection. The cell under suspicion is the one that must exhibit samples of its contents, and the patrolling cell is the reader of that exhibit. A lymphocyte showing its own pieces would report on the lymphocyte and would say nothing about the liver cell it is inspecting. (Choice D) Infected cells do release soluble signals that slow viral replication in the surrounding tissue, and that is a genuine antiviral defence, but a diffusible signal spreads across a field of cells and cannot mark out which individual cell is harbouring the invader. It also acts on the cells that receive it rather than condemning the cell that sent it. This is a Scientific Reasoning and Problem Solving question because the student must reason from the physical inaccessibility of a cell's interior to the only surveillance strategy that could possibly work, instead of recalling a labelled pathway.

---

## B2-Q2 . Universal Distribution of the Display Molecule

**Stem.** The major histocompatibility complex molecules that report on a cell's internal contents are made by essentially every nucleated cell of the body, while a second reporting device is restricted to the few cell types that ingest foreign material. Mature red blood cells carry neither. What accounts for the near universal distribution of the first device?

- **A.** Intracellular parasites can take up residence in almost any tissue, so a cell type that could not advertise what it harbours would become a hiding place no killing lymphocyte could see.  <- **KEY**
- **B.** Every nucleated cell must be able to engulf material from outside itself, and reporting on that engulfed material is an obligatory downstream step of the uptake.
- **C.** Mature red blood cells extrude their nucleus during development and can therefore no longer transcribe the genes that encode these molecules.
- **D.** A cell installs these molecules only after a patrolling lymphocyte has already flagged it as abnormal, so the display follows the inspection.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (A): Intracellular parasites can take up residence in almost any tissue, so a cell type that could not advertise what it harbours would become a hiding place no killing lymphocyte could see.**

Citations: MICRO:32812 (the complex is a collection of genes coding for molecules found on the surface of all nucleated cells of the body); MICRO:32814 (mature red blood cells, which lack a nucleus, are the only cells that do not express these molecules); MICRO:32819 (the second class of these molecules is found only on the small set of cells that take up foreign material); AP:43042 (viruses infect nearly every tissue of the body, so all these tissues must necessarily be able to express the display molecule or no lymphocyte response can be made)

**Distractors**

- **(B)** `misconception` . _conflating the two reporting systems_: Assigns the ingesting cell's job to every cell in the body. Reporting on internally made products involves no uptake of outside material, and the device tied to ingestion is the restricted one.
  - Citation: MICRO:32819
- **(C)** `adjacent_fact` . _true fact about the exception_: A true statement about why the one exception lacks the device. It explains the red blood cell and leaves the actual question, why nucleated cells nearly all have it, untouched.
  - Citation: MICRO:32814
- **(D)** `reversed_relationship` . _display induced by recognition_: Puts the display after the recognition it makes possible. Continuous presence is what allows a surveying cell to judge the state of a target in the first place.
  - Citation: MICRO:32903

**Readback check.** Content words of six or more letters in key A: Intracellular, parasites, residence, almost, tissue, advertise, harbours, become, hiding, killing, lymphocyte. Stem six-plus words: major, histocompatibility, complex, molecules, report, internal, contents, essentially, nucleated, second, reporting, device, restricted, types, ingest, foreign, material, Mature, blood, neither, accounts, universal, distribution. Zero overlap. The four choices are also within about ten words of one another in length, so the key cannot be picked out by bulk. The stem supplies the distribution but never the reason, so answering requires importing the tissue range of intracellular pathogens.

**Explanation (as shipped).**

> This question belongs to the Organ Systems content category and tests antigen presentation, in particular why one reporting system is spread across almost the whole body while a second is confined to a handful of cell types. The answer is A because the intracellular pathogens this system exists to expose are not restricted to any one tissue, so any cell type that could not advertise what it harbours would be a place where such a pathogen could multiply unseen. Viruses and other obligate intracellular organisms take up residence in nerve, muscle, liver, gut and skin alike. The lymphocyte lineage that kills targets directly can act only where an advertisement is available, so the coverage of the system has to match the reach of the threat; a gap in coverage would be a gap in defence rather than a saving. The second device has a different job. It hands out material the cell has taken in from outside, so only cells that professionally ingest such material need it, and its distribution is correspondingly narrow. Mature red blood cells are the exception that confirms the logic, since without a nucleus they lack both the genes and the ordinary protein synthesis machinery needed to build a display molecule at all. (Choice B) Engulfing material from outside is the specialty of a small set of phagocytic cells, and it is precisely those cells that carry the second device. Advertising internally made products requires no ingestion step whatever, so engulfment cannot be the reason the first device is everywhere. (Choice C) It is true that a maturing red blood cell extrudes its nucleus and loses the ability to transcribe these genes, and that correctly explains why red cells are bare. It is a statement about the one exception and says nothing about why every cell that does retain a nucleus carries the device. (Choice D) The device is present continuously rather than installed on demand. If it appeared only after a cell had already been flagged as abnormal, there would be no information available for the flagging step itself, which makes the proposal circular. This is a Knowledge of Scientific Concepts and Principles question because the student must connect the known tissue range of intracellular pathogens to the distribution a surveillance molecule needs in order to expose them.

---

## B2-Q3 . Baseline Self Fragment Display in Healthy Cells

**Stem.** A tissue sample is taken from a person with no infection anywhere in the body. Every nucleated cell in the sample displays its usual surface density of major histocompatibility complex molecules, and essentially all of their binding grooves are occupied rather than empty. Which of the following can be concluded about this occupancy?

I. The pieces filling the grooves are products of the cell's ordinary internal protein turnover.
II. Maintaining occupancy in the absence of any pathogen is superfluous, since there is nothing foreign to report.
III. The steady baseline this occupancy creates is what allows an unfamiliar fragment appearing later to be judged as nonself.

- **A.** I only
- **B.** III only
- **C.** I, II, and III
- **D.** I and III only  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (D): I and III only**

Citations: MICRO:32904 (in a healthy cell, proteins normally found in the cytoplasm are degraded by enzyme complexes and processed into self fragments); MICRO:32906 (those self fragments bind within the antigen binding cleft and are then presented on the cell surface); MICRO:32903 (the display molecules, found on all normal healthy nucleated cells, signal that the cell is a normal self cell); MICRO:31582 (the molecular markers that make up the complex are expressed by healthy cells as an indication of self)

**Distractors**

- **(A)** `partial_truth` . _true but incomplete set_: Statement I is true, so the choice is correct as far as it goes, but dropping statement III leaves the continuous display unexplained and treats a functional requirement as a by-product.
  - Citation: MICRO:32904
- **(B)** `partial_truth` . _true but incomplete set_: Statement III is true, but rejecting statement I removes the only available source for the fragments in a person with no infection.
  - Citation: MICRO:32904
- **(C)** `misconception` . _resting defence as wasted effort_: Includes statement II, the false belief that display without infection is wasted. The familiar resting output is precisely the reference against which an unfamiliar fragment is later judged, so it is never idle.
  - Citation: MICRO:31582

**Readback check.** The key option text is 'I and III only' and contains no content words of six or more letters, so no stem word can appear in it. Checking the numbered statements instead: statement I contributes products, ordinary, internal, protein, turnover and statement III contributes steady, baseline, occupancy, creates, allows, unfamiliar, fragment, appearing, judged, nonself. The stem prose contributes tissue, sample, person, infection, anywhere, nucleated, displays, surface, density, major, histocompatibility, complex, molecules, essentially, binding, grooves, occupied, rather. Occupancy appears in the stem as 'occupied' and again in statement III, but statement III alone is not the answer, and the discrimination rests on the origin of the fragments and on the function of the baseline, neither of which the stem states.

**Explanation (as shipped).**

> This question belongs to the Organ Systems content category and tests self versus nonself recognition as it operates in the resting, uninfected state. The answer is D because statements I and III are both supported while statement II rests on a false premise about what the resting display is for. In a healthy cell, enzyme complexes in the cytoplasm continually chew up ordinary cellular proteins, and the short pieces produced by that routine turnover are the material that fills the binding grooves, so in a person with no infection the occupants must be of the body's own making, which is what statement I asserts. That continuous traffic is not idle machinery waiting for an emergency. It is the reference standard, because a surveying cell can call a fragment foreign only by contrast with the ordinary pattern it has learned, and that is what statement III asserts. Statement II therefore fails on its own logic: an unfamiliar fragment would carry no meaning at all if there were no familiar output to compare it against, so display in the absence of infection is the very thing that makes later detection possible. (Choice A) Statement I is correct, but stopping there treats the baseline as an incidental by-product of protein turnover with no function. The reason the body pays the continuous metabolic cost of display is the one given in statement III, so omitting it misses the point of the observation. (Choice B) Statement III is correct, but rejecting statement I leaves the grooves filled by nothing in particular. In a person with no infection there is no foreign source available, so the occupants have to come from the cell's own protein economy. (Choice C) This adds statement II, the intuitive but mistaken idea that a defence with nothing to report is wasted effort. Without a familiar baseline there would be no standard against which an unfamiliar fragment could ever be judged, so the resting output is doing work at all times. This is a Scientific Reasoning and Problem Solving question because the student must evaluate three claims about a baseline observation and decide which of them the uninfected condition actually licenses.

---

## B2-Q4 . Consequences of Suppressed Surface Display

**Stem.** A certain virus encodes a protein that lowers the number of reporting molecules a host cell places on its surface. Three cultures of identical nucleated cells were prepared: uninfected, infected with a mutant virus that lacks that protein, and infected with the wild type. Each culture was then exposed separately to two lymphocyte preparations. Set 1 came from an animal previously exposed to this virus and was expanded from a single responding clone; set 2 came from an animal never exposed to any virus. Cell numbers were equal in every well.

| Culture | Reporting molecules per cell (thousands) | Killed by set 1 (%) | Killed by set 2 (%) |
| --- | --- | --- | --- |
| Uninfected | 60 | 2 | 3 |
| Mutant virus | 55 | 68 | 6 |
| Wild-type virus | 5 | 5 | 61 |

The results most strongly support which account of what each set demands of a cell before killing it?

- **A.** Set 2 recognises the same viral fragment as set 1 but with slower kinetics, which is why it prevails only in the wild-type culture.
- **B.** Set 1 acts only on a target that is exhibiting a foreign piece on its outer face, whereas set 2 acts on a target whose outward exhibit has dwindled, so the wild type simply exchanges one attacker for another.  <- **KEY**
- **C.** Set 1 is switched on by the disappearance of the reporting molecules and set 2 by their abundance.
- **D.** The wild-type protein blocks the breakdown of viral products in the cytosol, so the reporting molecules stay at their usual density but carry only ordinary self pieces.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a) it combines antigen presentation with clonal selection, since the student must use the naive origin of set 2 to exclude specificity as an explanation. Meets (b) it requires a directional inference across three rows and two columns rather than a lookup. Meets (c) choices A and D are both defensible until the reader applies the naive-animal detail and the reporting molecule column respectively. Meets (d) it supplies killing outcomes and asks the student to infer the recognition requirement that produced them. |

**Correct answer (B): Set 1 acts only on a target that is exhibiting a foreign piece on its outer face, whereas set 2 acts on a target whose outward exhibit has dwindled, so the wild type simply exchanges one attacker for another.**

Citations: AP:43614 (many cells respond to viral infection by lowering their expression of the display molecule); AP:43616 (without that display the lymphocyte lineage that kills targets directly has no activity, which is to the advantage of the virus); MICRO:31586 (when the display markers are diminished or absent, the nonspecific killer population interprets this as an abnormality and is activated); MICRO:32910 (presentation of pathogen specific fragments on the display molecule signals that the infected cell must be targeted for destruction); AP:43617 (the two killer populations have complementary activities against virally infected cells)

**Distractors**

- **(A)** `misconception` . _nonspecific killer treated as specific_: Treats the naive population as though it were clonally selected for the same fragment. An animal never exposed to the virus has no expanded clone against it, and set 2 leaves the mutant culture at background rather than killing it late.
  - Citation: MICRO:31578
- **(C)** `reversed_relationship` . _inverted activation signals_: Swaps the two triggers. The data show set 1 failing when the reporting molecules collapse and set 2 failing when they are plentiful, which is the reverse of what is stated.
  - Citation: MICRO:31586
- **(D)** `process_step_confusion` . _wrong step of the presentation pathway_: Places the viral interference at protein breakdown instead of at surface display, and predicts a normal reporting molecule count. The measured value in the wild-type culture is 5 thousand against 60 thousand in uninfected cells, so the prediction fails.
  - Citation: MICRO:32904

**Readback check.** Content words of six or more letters in key B: exhibiting, foreign, target, whereas, outward, exhibit, dwindled, simply, exchanges, another, attacker. Stem and table six-plus words: certain, encodes, protein, lowers, number, reporting, molecules, surface, cultures, identical, nucleated, prepared, uninfected, infected, mutant, lacks, wild-type, exposed, separately, lymphocyte, preparations, previously, animal, expanded, single, responding, clone, numbers, equal, every, results, strongly, support, account, demands, before, killing, Culture, Killed, thousands. Zero overlap, and the key deliberately avoids the stem's own words 'reporting', 'molecules' and 'surface' that appear in distractors C and D. The key is also not a table value: no cell of the table states a requirement, so the student must infer the requirement from the pattern across rows.

**Explanation (as shipped).**

> This question belongs to the Organ Systems content category and tests antigen presentation together with the consequence of losing it. The answer is B because the two infected cultures carry the same viral antigens and differ only in one viral protein, so the collapse of set 1 killing from 68 percent to 5 percent cannot be a difference in binding specificity and must track the fall in reporting molecules from 55 thousand to 5 thousand per cell. Set 1 was expanded from a single responding clone in an animal that had met this virus, which is the signature of a population selected for one binding partner, and its output falls to background precisely where the surface report vanishes. Set 2 came from an animal that had never met any virus, so no clone in it could have been selected against this pathogen, yet it kills the low display culture at 61 percent while leaving both high display cultures near the 2 to 6 percent background. The trigger for set 2 is therefore the shortfall itself rather than any particular fragment. The virus does gain something by suppressing the display, since it blinds the selected killer, but it pays for that gain by revealing the cell to a population that reads absence. (Choice A) If set 2 read the same fragment as set 1, it would have to kill the mutant culture as well, merely later; instead it stays at 6 percent there, and an animal never exposed to the virus has no expanded clone for it. (Choice C) This reverses both assignments. Set 1 is the population that fails when the report disappears, and set 2 is the one that fails when the report is abundant, which is the opposite of what the choice states. (Choice D) This proposes an interference at the degradation step rather than at the display step, and it predicts that the reporting molecule count would remain near the uninfected value. The measured 5 thousand per cell in the wild-type culture rules it out directly. This is a Data-based and Statistical Reasoning question because the student must compare killing percentages across matched cultures and attribute the difference to the one measured variable that changes between them.

---

## B2-Q5 . Two Fragment Sources, Two Carriers

**Stem.** A scavenging cell engulfs a bacterium and breaks it apart, while a nearby skin cell is invaded by a virus that is now copying itself in the cytosol. Both cells end up carrying short peptides on their outer face, yet the immune system must treat the two cells very differently. Why must peptides of these two origins be held by different surface carriers?

- **A.** Fragments of the cell's own normal proteins are never put on view, so a second carrier is needed for the self peptides that escape breakdown.
- **B.** The cell that took in foreign matter is the more dangerous of the two, so the split allows that cell rather than the invaded one to be eliminated.
- **C.** A cell reporting on debris it had taken up would look identical to one whose own synthetic machinery had been subverted, and would be killed alongside it.  <- **KEY**
- **D.** Two carriers can hold a wider assortment of peptide shapes than one, so the split mainly widens the range of pathogens that can be detected.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural two_step) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (C): A cell reporting on debris it had taken up would look identical to one whose own synthetic machinery had been subverted, and would be killed alongside it.**

Citations: MICRO:32812; MICRO:32818; MICRO:32903; AP:42997

**Distractors**

- **(A)** `misconception` . _self peptides are never displayed_: Students often believe only foreign peptides are displayed. In fact healthy cells continuously present fragments of their own ordinary proteins, and that constant self display is what identifies them as unaltered.
  - Citation: MICRO:32906
- **(B)** `reversed_relationship` . _wrong cell targeted for destruction_: The right variables in the wrong direction. The cell whose interior has been taken over is the one that must be destroyed; the scavenging cell that ingested and destroyed the microbe is healthy and is the cell that recruits help.
  - Citation: MICRO:32910
- **(D)** `partial_truth` . _repertoire breadth substituted for compartment segregation_: Extra carriers do widen the repertoire of peptide shapes that can be held, but breadth alone would not require the two carriers to be loaded from different compartments or to engage different lymphocyte populations.
  - Citation: AP:43003

**Readback check.** Content words of six or more letters in key C: reporting, debris, identical, synthetic, machinery, subverted, killed, alongside. Stem words of six or more letters: scavenging, engulfs, bacterium, breaks, nearby, invaded, copying, itself, cytosol, carrying, peptides, immune, system, differently, origins, surface, carriers. No overlap, so no stem echo. The key is not a restatement of any stem sentence; it requires inferring that a shared carrier would make a healthy reporting cell look like a subverted one. All four choices are within three words of the same length, so length gives no cue.

**Explanation (as shipped).**

> This Organ Systems item tests antigen presentation, specifically why the source of a displayed peptide has to be encoded in the carrier that holds it. The answer is C because a single carrier would erase the one piece of information a responding lymphocyte needs before it acts: whether the cell putting the peptide on view is itself compromised or is only acting as a messenger. Every cell with a nucleus continuously samples the proteins it is making, chops a fraction of them up, and places the pieces on its outer face, so a viral peptide appearing there is direct evidence that virus is being assembled in that very cell, and the correct outcome is elimination of the cell. The scavenging cell in this stem is perfectly healthy. What it shows is evidence about its surroundings, not about itself, and the correct outcome is a call for reinforcement rather than its own death. Since the two situations demand opposite fates for the cell doing the showing, the carrier has to differ so that the lymphocyte arriving at the surface knows which fate applies before it commits.
>
> (Choice A) Normal cells do put fragments of their own ordinary proteins on view, and they do so constantly. That steady display of self is exactly what marks a cell as unaltered, so the premise of this choice is false.
>
> (Choice B) This reverses the danger. A cell that has swallowed and destroyed a microbe has done its job, whereas a cell that is manufacturing viral protein is the one that must be removed. Eliminating the scavenging cell would destroy the very cells that organise the response.
>
> (Choice D) Broadening the range of shapes that can be held is a genuine benefit of having more than one carrier, but it does not explain why the two carriers are loaded from different internal compartments or why they engage different lymphocyte populations. A system built only for breadth could have used two carriers of the same kind, loaded from the same source.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to reason from the opposite outcomes the two cells require back to the structural feature that keeps those outcomes distinguishable.

---

## B2-Q6 . Restricting the Ingested-Material Display

**Stem.** In a laboratory strain of mouse, a mutation puts the second display molecule, the one normally restricted to a small set of cells that take in and break down foreign material, onto every nucleated cell in the body. Each cell can now load that molecule with peptides drawn from the fluid around it. Which consequence would this change be expected to produce?

- **A.** Cells harbouring a virus in their cytosol would stop being recognised, because the newly added molecule would crowd out the display that all nucleated cells already carry.
- **B.** Ordinary self proteins, harmlessly sampled, would be presented to the lymphocyte population that grants other cells permission to act, so attacks would be mounted on healthy structures.  <- **KEY**
- **C.** The rate at which bacteria are engulfed and destroyed would rise across the body, since far more cells could now take up and break down microbes.
- **D.** Peptides drawn from the surrounding fluid would be routed to the lymphocyte population that kills on contact, so cells everywhere would be lost to immediate direct attack.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (B): Ordinary self proteins, harmlessly sampled, would be presented to the lymphocyte population that grants other cells permission to act, so attacks would be mounted on healthy structures.**

Citations: MICRO:32819; MICRO:32869; MICRO:33043; AP:42939

**Distractors**

- **(A)** `misconception` . _surface competition between the two displays_: Assumes the two displays compete for surface space. They are loaded from separate internal supplies and coexist on the same cell, so presentation of internally made viral protein would be unaffected.
  - Citation: MICRO:32909
- **(C)** `adjacent_fact` . _phagocytosis capacity conflated with display capacity_: True that phagocytes engulf and destroy microbes, but engulfment requires cytoskeletal machinery and ingestion receptors, not a display molecule. The statement is irrelevant to what the mutation supplies.
  - Citation: MICRO:32860
- **(D)** `process_step_confusion` . _lymphocyte populations swapped between the two displays_: Correct process, wrong lymphocyte population matched to the display. Fragments taken in from the surroundings engage the permission-granting lymphocytes; the contact-killing lymphocytes inspect the display loaded from proteins made inside the cell.
  - Citation: MICRO:33044

**Readback check.** Content words of six or more letters in key B: Ordinary, proteins, harmlessly, sampled, presented, lymphocyte, population, grants, permission, attacks, mounted, healthy, structures. Stem words of six or more letters: laboratory, strain, mutation, second, display, molecule, normally, restricted, foreign, material, nucleated, peptides, around, consequence, change, expected, produce. No overlap, so no stem echo. The stem never states which lymphocyte population the described molecule engages, so the key cannot be recovered by rewording the stem.

**Explanation (as shipped).**

> This Organ Systems item tests antigen presentation together with self versus nonself recognition, using a thought experiment that removes the normal limit on which cells may show ingested matter. The answer is B because putting that molecule on every cell would turn the whole body into a source of requests for help, including the vast majority of cells that never encounter anything dangerous. The lymphocyte population engaged by that particular display does not kill its target; it grants other cells permission to proceed, which is precisely why the display is confined to a small set of cells that load it only after taking in and dismantling something. Cells bathed in extracellular fluid would take up serum proteins, shed membrane, and the remains of neighbours that died of ordinary wear, and every one of those peptides would then be offered as though it were evidence of an intruder. The mechanisms that remove self reactive lymphocytes as they mature are not completely effective, so some lymphocytes able to bind self peptides always persist. Offering self material in this permissive setting invites exactly the mistaken activation that the restriction exists to prevent, which is the pattern underlying autoimmune disease.
>
> (Choice A) Surface real estate is not limiting in this way, and the display carried by all nucleated cells is loaded from a separate internal supply of chopped up cytosolic protein. Recognition of cells harbouring an intracellular parasite would continue unchanged.
>
> (Choice C) Carrying a display molecule does not confer the ability to engulf anything. Ingestion depends on the cytoskeletal machinery and surface receptors of a phagocyte, none of which this mutation supplies, so engulfment rates across the body would not change.
>
> (Choice D) This assigns the wrong lymphocyte population to the display in question. The lymphocytes that kill on contact inspect the display loaded from proteins made inside the cell; the molecule described in the stem engages the lymphocytes that issue permission signals, so the harm would arrive by way of misdirected licensing rather than by immediate contact killing.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the systemic consequence of lifting a restriction on which cells are permitted to carry out one step of antigen presentation.

---

## B2-Q7 . Reading Fragment Origin from an Assay

**Stem.** Four cultured preparations were matched for the total amount of one bacterial antigen present, then mixed with lymphocytes from a donor previously exposed to that bacterium. Preparations 1 and 3 used a skin cell line; preparations 2 and 4 used macrophages. In 1 and 2 the antigen was built inside the cell from an engineered gene; in 3 and 4 the whole antigen was placed in the culture and had to be brought in.

| Preparation | Cell type | How the antigen arose | Direct lysis of matched targets (% of maximum) | Soluble permission signal (units) |
|---|---|---|---|---|
| 1 | skin cell line | built inside | 84 | 3 |
| 2 | macrophage | built inside | 79 | 5 |
| 3 | skin cell line | placed in culture | 6 | 4 |
| 4 | macrophage | placed in culture | 5 | 72 |

Which conclusion do the four sets of readings together support?

- **A.** Only one of the two cell types can put externally acquired fragments on view, so the response to swallowed matter depends on which cell handled it rather than on how much was supplied.  <- **KEY**
- **B.** Preparation 3 received too little antigen to fill enough binding sites, so the gap between 3 and 4 reflects quantity rather than cell type.
- **C.** The skin cell line cannot degrade protein that it has taken in, so nothing at all reaches its outer face.
- **D.** Antigen built inside a cell drives the soluble permission signal, whereas antigen brought in from outside drives direct lysis.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a): combines fragment origin with the restriction of the second display to one cell type. Meets (c): choices B and C remain defensible until the matched-amount statement and the row 1 lysis value are applied. Meets (d): the student is given the outcome pattern and must infer the underlying cause. |

**Correct answer (A): Only one of the two cell types can put externally acquired fragments on view, so the response to swallowed matter depends on which cell handled it rather than on how much was supplied.**

Citations: MICRO:32818; MICRO:32869; MICRO:32903; MICRO:33044

**Distractors**

- **(B)** `scale_unit_error` . _amount limitation invoked against a controlled amount_: Right style of reasoning at the wrong magnitude. The stem fixes the total amount of antigen across all four preparations, and preparations 3 and 4 were supplied identically, so quantity cannot generate the gap between them.
  - Citation: MICRO:32869
- **(C)** `partial_truth` . _one blocked route generalised to all display_: Correct that the skin line shows nothing from externally supplied antigen, but wrong that nothing reaches its surface at all. Preparation 1 shows it degrades and displays internally made protein efficiently.
  - Citation: MICRO:32904
- **(D)** `reversed_relationship` . _origin and readout swapped_: The correct variables related in the wrong direction. Internally built antigen was followed by high lysis and no permission signal above background, and externally supplied antigen in macrophages by the opposite pattern.
  - Citation: MICRO:33044

**Readback check.** Content words of six or more letters in key A: externally, acquired, fragments, response, swallowed, matter, depends, handled, rather, supplied. Stem words of six or more letters: cultured, preparations, matched, amount, bacterial, antigen, lymphocytes, previously, exposed, donor, bacterium, macrophages, engineered, placed, culture, brought, Preparation, Direct, targets, maximum, Soluble, permission, signal, units, conclusion, readings, together, support, inside. No overlap, so no stem echo. The key is not a value read off the table; it requires combining rows 3 and 4 with the matched-amount statement and with row 1 to exclude the alternative explanations.

**Explanation (as shipped).**

> This Organ Systems item tests antigen presentation as read from experimental data, specifically what decides whether material taken in from outside can be shown at all. The answer is A because the two preparations that received the whole antigen in the culture differ only in the cell used, and only the macrophage produced a permission signal above background. The three other preparations sit at 3, 4 and 5 units, so 72 units in preparation 4 is the single readout that rises at all, and the only variable that changed between the third and fourth rows is cell type. The first two rows then rule out the idea that the skin line is simply inert, because when the same antigen was built inside it the lysis readout reached 84 percent of maximum. Taken together, the readings say that material generated within any nucleated cell can be shown by that cell, whereas material brought in from the surroundings can be shown only by the restricted set of cells, and it is that restriction, not the antigen and not the amount, that settles which lymphocyte population is engaged.
>
> (Choice B) The stem states that the total amount of antigen was matched across preparations, so a shortfall cannot be the explanation. Preparations 3 and 4 also received their antigen by the same route and in the same amount, yet only one of them gave any signal, so the difference tracks the cell used rather than the quantity supplied.
>
> (Choice C) The skin line plainly does break protein down and display the products, since preparation 1 produced a strong lysis readout. What it lacks is the route that carries externally derived pieces to the surface, not the ability to degrade protein at all, so the claim overreaches.
>
> (Choice D) This states the relationship backwards. Antigen built inside the cell was followed by high lysis in preparations 1 and 2 with no permission signal above background, while antigen taken in by macrophages produced 72 units of permission signal with lysis no higher than background.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to hold the supplied amount constant across four readings, isolate the one variable that changed between the informative rows, and state what the resulting pattern can and cannot support.

---

## B2-Q8 . Control Arm for a Display-Blocking Reagent

**Stem.** Macrophages are cultured with intact antigen X, then mixed with lymphocytes from a donor previously exposed to that antigen, and the soluble permission signal is measured. In one arm, a reagent that sits tightly over the surface structure these cells carry in addition to the one present on every nucleated cell is added first; the reagent does not reduce viability. Signal in that arm falls to background, while direct killing of separately infected targets by the same lymphocyte population is unaffected. The investigator concludes that the covered structure is the one that puts swallowed material on view. Which further arm would most strengthen that conclusion?

- **A.** Showing that the reagent also stops the cells from taking antigen X in, since a structure that displays swallowed material must be the same one that carries it inward.
- **B.** Repeating the arm with cells whose internal digestive compartments have been prevented from fusing, to confirm that degradation precedes display.
- **C.** Repeating the untreated arm with lymphocytes from a donor never exposed to that antigen, to show that the signal requires prior encounter.
- **D.** Repeating the treated arm with short peptides already cut from X, which bypass uptake and processing and should still give nothing if the binding groove itself has been masked.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a): combines the processing pathway for ingested antigen with the restriction of the second display to ingesting cells. Meets (c): choices B and C are genuine controls and stay defensible until the student asks which of two candidate blocking sites the arm distinguishes. Meets (d): the outcome is supplied and the student must infer which cause it does and does not establish. |

**Correct answer (D): Repeating the treated arm with short peptides already cut from X, which bypass uptake and processing and should still give nothing if the binding groove itself has been masked.**

Citations: MICRO:32869; MICRO:32883; MICRO:32830; AP:42997

**Distractors**

- **(A)** `misconception` . _display molecule conflated with uptake receptor_: Treats the display structure as the ingestion receptor. Uptake is carried out by separate surface receptors and the cytoskeleton, so this result would undermine, not support, the claim about which step was blocked.
  - Citation: MICRO:32860
- **(B)** `process_step_confusion` . _degradation step tested instead of the display step_: Names the wrong stage. Blocking compartment fusion tests whether degradation must precede display, an accepted point, and that arm would fail for reasons unrelated to where the reagent is bound.
  - Citation: MICRO:32876
- **(C)** `adjacent_fact` . _specificity control offered for a localisation claim_: A true and useful control for a different claim, namely that the responding lymphocytes are antigen specific. It cannot distinguish a covered display cleft from interrupted ingestion, which is the question at issue.
  - Citation: MICRO:32508

**Readback check.** Content words of six or more letters in key D: Repeating, treated, peptides, already, bypass, uptake, processing, should, nothing, binding, groove, itself, masked. Stem words of six or more letters: Macrophages, cultured, intact, antigen, lymphocytes, previously, exposed, donor, soluble, permission, signal, measured, reagent, tightly, surface, structure, addition, present, nucleated, viability, background, direct, killing, separately, infected, targets, lymphocyte, population, unaffected, investigator, concludes, covered, swallowed, material, further, strengthen, conclusion. No overlap, so no stem echo. The stem never mentions pre-cut peptides or the alternative upstream explanation, so the key requires generating the competing hypothesis before choosing the arm that separates it.

**Explanation (as shipped).**

> This Organ Systems item tests the design of an antigen presentation experiment, specifically the control needed before one can say what a blocking reagent actually interfered with. The answer is D because the observed loss of signal has two live explanations and this arm separates them. The reagent may be lying across the cleft where ingested pieces are held, which is what the investigator claims, or it may simply be preventing the cells from taking antigen X in or from moving it through the internal compartments where it is cut up. Short peptides that have already been cut need neither of those steps, since they can settle directly into an exposed cleft on the outer face. If the arm given pre-cut peptides still yields background, the ingestion route cannot be the explanation and the cleft itself must be covered. If instead the pre-cut peptides restore the signal, the reagent was acting upstream and the original conclusion fails, which is exactly what makes this a discriminating arm rather than a confirming one.
>
> (Choice A) This would weaken rather than strengthen the conclusion, and it rests on a false premise: the structure that holds a fragment on the surface is not the receptor that draws material into the cell. Demonstrating that ingestion had also stopped would leave the investigator unable to say which step the reagent affected.
>
> (Choice B) Preventing internal digestive compartments from fusing tests whether degradation must precede display, a point already accepted and not in dispute here. That arm would fail for reasons wholly unrelated to the reagent, so it says nothing about where the reagent acts.
>
> (Choice C) Lymphocytes from a donor with no prior exposure address the specificity of the responding population, which is a legitimate control for a different claim. Specificity was never in doubt in this experiment, and the arm cannot distinguish a covered cleft from interrupted ingestion.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to select the arm that separates two competing explanations for the same loss of measured output.

---

## B2-Q9 . Population Value of MHC Allele Diversity

**Stem.** Human MHC loci carry hundreds of alleles each, and the protein made from one allele binds a set of short peptides that the protein made from another allele cannot hold. Two unrelated people therefore almost never carry matching sets, which is why organ donation is so often blocked. What advantage does this arrangement give the human population, despite the cost to transplant surgery?

- **A.** A person carrying two unlike alleles at one locus makes a single combined protein that holds peptides neither version could hold alone.
- **B.** The variety lets a person switch on previously silent alleles as unfamiliar infections appear during the course of life.
- **C.** Lymphocyte binding sites are generated in enormous variety before any antigen is met, so some cell can bind almost any invader.
- **D.** A microbe that slips past surveillance in one individual is still caught in many others, so no single pathogen can defeat the whole species.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (D): A microbe that slips past surveillance in one individual is still caught in many others, so no single pathogen can defeat the whole species.**

Citations: AP:43933 (MHC polygeny refers to multiple MHC proteins on cells and MHC polymorphism to multiple alleles at each locus, so many alleles exist in the human population); AP:43003 (MHC molecules are capable of presenting a variety of antigens depending on the amino acid sequence in their peptide-binding clefts); AP:43836 (stated for autoimmunity, that if a person's MHC molecules cannot present a given antigen, the response to that antigen cannot occur); MICRO:35547 (highly polymorphic loci each with many alleles segregating in a population, the two alleles at each locus expressed codominantly)

**Distractors**

- **(A)** `misconception` . _hybrid-molecule fallacy_: Alleles at an MHC locus are codominantly expressed as two distinct proteins; they do not combine into a single hybrid molecule with a novel binding pocket.
  - Citation: MICRO:35547
- **(B)** `misconception` . _inducible alleles within a lifetime_: Treats inherited alleles as inducible: allele content is fixed at fertilization and expressed constitutively, and the benefit of diversity is realized across a population over generations rather than by switching alleles on within one lifetime.
  - Citation: AP:43933
- **(C)** `adjacent_fact` . _correct fact, wrong source of diversity_: A true statement about the pre-existing diversity of lymphocyte binding sites, which arises independently of MHC allele number and therefore does not answer why the MHC loci are polymorphic.
  - Citation: AP:43136

**Readback check.** Content words of six or more letters in key D: microbe, surveillance, individual, caught, others, single, pathogen, defeat, species. Stem and lead-in words of six or more letters: Human, hundreds, alleles, protein, allele, peptides, another, cannot, unrelated, people, therefore, almost, matching, organ, donation, blocked, advantage, arrangement, population, despite, transplant, surgery. No overlap, so no stem echo. The key is not the longest option and is not stated in the stem: the stem gives the genetic fact and the surgical cost, and the student must infer the population-level consequence for pathogen coverage.

**Explanation (as shipped).**

> This Organ Systems item examines the major histocompatibility complex and the reason its extreme allelic diversity is maintained. The answer is D because a wide spread of alleles guarantees that whatever short peptides a novel microbe generates, some members of the species will own a molecule capable of gripping those peptides and showing them to lymphocytes. Presentation is a matching problem: each MHC protein carries a binding pocket with its own chemical preferences, so a given peptide is held well by some versions and poorly by others. If everyone carried an identical version, a microbe whose peptides happened to fit that version badly would go undisplayed in every host, and the adaptive response, which cannot begin until a fragment is shown to a lymphocyte, would fail across the board. Diversity spreads that risk across many hosts, so selection preserves the pool even when particular hosts die. The cost falls on transplant medicine, where the same variability makes it improbable that any two unrelated people carry the same set.
>
> (Choice A) Alleles at a given locus are expressed codominantly, so a heterozygote makes two separate proteins, one specified by each allele. The chains do not fuse into a novel hybrid pocket with a new specificity; the benefit of heterozygosity is simply owning two pockets rather than one, which is a different claim from the one made here.
>
> (Choice B) Which alleles a person carries is fixed at fertilization, and those alleles are expressed constitutively rather than held in reserve and switched on to suit the infection of the moment. The benefit under discussion accrues across many hosts over evolutionary time, not within a single lifetime.
>
> (Choice C) Lymphocyte binding sites are indeed generated in enormous variety before any antigen is encountered, and that diversity is what makes clonal selection workable. It is a true statement about a separate source of variation, produced independently of which MHC alleles a person inherited, so it does not explain why the MHC loci themselves are so variable between people.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall that an adaptive response cannot begin until a peptide is held and displayed, and then apply that requirement to a whole population rather than to one host.

---

## B2-Q10 . Nonself Recognition of Grafted Tissue

**Stem.** A man receives a kidney from an unrelated donor. Nothing can be cultured from the organ or from his blood, yet two weeks later a biopsy shows it crowded with his own lymphocytes and the tissue is failing. Which feature of the transplanted cells accounts for the attack?

- **A.** The graft cells have lost the surface markers that healthy cells normally show, so they read as damaged.
- **B.** Their peptide-holding surface proteins are encoded by alleles that his own genome lacks, so the proteins are themselves read as nonself.  <- **KEY**
- **C.** The graft carries proteins he has never met before, and any unfamiliar protein provokes an attack no matter how it is encountered.
- **D.** The surgery itself injures the graft, and the debris released recruits the fast, nonspecific arm of defence.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (B): Their peptide-holding surface proteins are encoded by alleles that his own genome lacks, so the proteins are themselves read as nonself.**

Citations: MICRO:35525 (rejection occurs when the recipient's immune system recognizes the donor tissue as foreign, or non-self, triggering an immune response); MICRO:35528 (the histocompatibility molecules expressed in tissue transplanted from a genetically different individual may be recognized as non-self); AP:43935 (when a donor organ expresses MHC molecules different from the recipient's, the recipient mounts a destructive response and rejects the organ); AP:43005 (it is the combination of the MHC molecule and the fragment of the original peptide that is physically recognized by the responding lymphocyte)

**Distractors**

- **(A)** `reversed_relationship` . _absence rather than mismatch_: Reverses the trigger for rejection: graft cells display their molecules abundantly, and it is the unfamiliar version present, not a missing marker, that provokes the specific response.
  - Citation: MICRO:35528
- **(C)** `partial_truth` . _free protein seen directly_: Correct that donor proteins are unfamiliar, but it drops the requirement that a fragment be processed and held in a surface display molecule, which is the step that makes the mismatched display molecule the principal target.
  - Citation: AP:43005
- **(D)** `adjacent_fact` . _innate injury response substituted for adaptive rejection_: True that surgical injury recruits the rapid nonspecific arm, but that response is not donor-specific and cannot account for a progressive lymphocyte infiltrate destroying the graft over weeks.
  - Citation: AP:43936

**Readback check.** Content words of six or more letters in key B: peptide, holding, surface, proteins, encoded, alleles, genome, themselves, nonself. Stem and lead-in words of six or more letters: receives, kidney, unrelated, donor, Nothing, cultured, organ, blood, biopsy, crowded, lymphocytes, tissue, failing, feature, transplanted, accounts, attack. No overlap, so no stem echo. The key is not the longest option. The stem never states that display molecules are polymorphic or that they are the target; the student must supply that step.

**Explanation (as shipped).**

> This Organ Systems item examines self versus nonself discrimination as it applies to grafted tissue. The answer is B because the peptide-holding surface proteins of the graft are themselves products of alleles absent from the recipient, so the display apparatus, not merely the fragment it carries, is what reads as nonself. Students often assume an immune attack requires an invader, but the adaptive system does not test for pathogenicity; it tests for combined shapes that the maturing lymphocyte pool was never taught to ignore. A lymphocyte scans the composite formed by a display protein together with whatever fragment sits in its cleft, so a donor whose display proteins differ in the residues lining that cleft presents an enormous number of unfamiliar composites at once. This is true even though every fragment on show comes from an entirely ordinary housekeeping protein of the graft. The result is a fast, specific, and clinically useless adaptive response, and because these display molecules are the principal cause of graft rejection, they are named for tissue compatibility in the first place.
>
> (Choice A) This inverts the trigger. Rejection follows the presence of unfamiliar display molecules, not their absence. Loss of surface display is a real signal that marks a cell as abnormal in other settings, but graft cells display abundantly; that display is simply the wrong version for this recipient.
>
> (Choice C) This is correct as far as it goes and then fails on a decisive point. Unfamiliar donor proteins do exist, but a lymphocyte of this lineage cannot see an intact protein floating free; it responds only to a processed fragment held in a display molecule on a cell surface. Dropping that requirement removes the very step that makes mismatched display molecules the dominant target.
>
> (Choice D) Surgical injury genuinely does recruit the rapid, nonspecific arm of defence, and some inflammation follows any operation. That mechanism is not tailored to a particular donor, however, and it would not produce a graft packed with lymphocytes that progressively destroy the tissue over weeks, so it is a true statement about a different process.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to explain a specific adaptive response in a sterile patient by identifying what, in the absence of any pathogen, the responding cells could have recognized as nonself.

---

## B2-Q11 . Designing a Donor Compatibility Culture

**Stem.** A transplant laboratory screens candidate donors for a patient who needs a kidney. For each candidate, white cells drawn from the patient are cultured together with white cells drawn from that candidate for five days, and the total amount of newly made DNA in the well is measured at the end. Vigorous new DNA synthesis is scored as a strong reaction against the candidate, and candidates yielding the least synthesis are ranked as most suitable. Which of the following must the protocol include for that ranking to be valid?

I. A step that stops the candidate's cells from dividing, so that the DNA measured can be assigned to one side of the mixture.
II. A well holding the patient's cells with no second party added, to establish how much division occurs anyway.
III. A well holding cells from one of the patient's siblings in every run, so that candidates can be scored against a known match.

- **A.** I only
- **B.** II only
- **C.** I, II, and III
- **D.** I and II only  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a): combines assay control logic with the genetics of inheritance at these loci. Meets (c): options A and B both remain defensible until the student decides which of attribution and baseline is dispensable, and neither is. Meets (b): item III requires a directional judgement about sibling matching probability rather than a lookup. |

**Correct answer (D): I and II only**

Citations: AP:43998 (a successful transplant requires a match at several of these molecules, with more matches associated with greater success); AP:43999 (family members, sharing a similar genetic background, are much more likely to share these molecules than unrelated individuals); MICRO:35547 (with several highly polymorphic loci each carrying many alleles, the odds are extremely low that a randomly chosen donor matches a recipient's six-allele genotype, the two alleles at each locus being codominantly expressed); MICRO:35549 (a parent or sibling may be the best donor because a genetic match is much more likely, which is a likelihood and not a certainty)

**Distractors**

- **(A)** `partial_truth` . _one necessary element recognized, one dropped_: Identifies the attribution problem correctly but omits the unstimulated baseline, leaving the laboratory unable to distinguish a low response from a culture with little proliferation to begin with.
  - Citation: AP:43998
- **(B)** `partial_truth` . _control kept, manipulation dropped_: Keeps the baseline but drops the blocking step, so every reading reflects a two-way exchange and cannot be attributed to the patient's response to the candidate.
  - Citation: MICRO:35547
- **(C)** `adjacent_fact` . _true tendency treated as a fixed standard_: Adds a comparator that is not required: siblings are more likely to match than unrelated people but share both inherited sets only about a quarter of the time, so a sibling is not a known match and cannot anchor a ranking.
  - Citation: MICRO:35549

**Readback check.** The key is the option string 'I and II only', which contains no content word of six or more letters, so stem echo is impossible for the key text itself, and the four options are of near-identical length. Checking the numeral statements against the setup: the setup states only that cells are cultured together, that DNA synthesis is measured, and how the ranking is made. It never mentions blocking division, never mentions an unmixed control, and never states whether siblings match reliably. Each numeral therefore requires an inference the setup does not supply.

**Explanation (as shipped).**

> This Organ Systems item examines the design of an assay that reads compatibility from the proliferation of lymphocytes placed together. The answer is D because the readout is only interpretable if the dividing cells can be attributed to one party and if the division seen without any second party is known. Item I is required: if both populations remain able to divide, each side responds to the other and the pooled DNA signal cannot be assigned to the patient's response, which is the quantity that predicts what will happen to a graft in that patient. Item II is required because lymphocytes in culture divide to some degree regardless of stimulus, and without that floor there is no way to say that a low reading reflects compatibility rather than a poorly performing culture. Item III fails on a specific genetic point: a sibling is not a known match. Each person inherits one set of these linked loci from each parent, so two siblings have roughly a one in four chance of receiving the same pair, which is far better than the odds for an unrelated donor but nowhere near certainty, and a sibling therefore cannot serve as a fixed reference point.
>
> (Choice A) Correct as far as it goes. Blocking division on one side does make the signal attributable, but with no unstimulated well the laboratory has no baseline, so it cannot tell a genuinely low response from a culture in which little was going to happen in any case.
>
> (Choice B) Also incomplete, and in the more damaging direction. A baseline well without the essential blocking step leaves every experimental value derived from a two-way exchange, so a large reading might reflect the candidate reacting to the patient rather than the reverse.
>
> (Choice C) This adds a requirement that is not one. Including a sibling would be informative only if siblings matched reliably, which they do not, so building the ranking on that comparator would introduce error rather than control it.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to decide which manipulation and which control a mixed culture must contain before its output can be read as a measure of donor mismatch.

---

## B2-Q12 . Tolerance to Self Peptides in MHC

**Stem.** At any moment most of the peptides sitting in a cell's MHC molecules are pieces of that cell's own everyday proteins, and healthy tissue is left alone. In one woman, the lining of several joints is being steadily destroyed by lymphocytes that bind a normal, unmodified joint protein held in MHC on the cells there. Which requirement of the healthy system has broken down in her?

- **A.** MHC molecules on her joint cells should hold only material brought in from outside those cells, and hers are holding pieces made within them.
- **B.** Healthy cells normally keep their own peptides out of MHC entirely, and hers have begun loading them.
- **C.** During maturation, any clone able to lock onto an unaltered body component is culled, and one such clone escaped.  <- **KEY**
- **D.** Her lymphocytes are being activated at the site of injury rather than first encountering the antigen in a lymphoid organ, so a stage has been skipped.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | Meets (a): combines antigen presentation with self versus nonself tolerance, two separately taught ideas. Meets (d): inverts the usual direction by giving the destructive outcome and requiring the student to infer which safeguard failed. Meets (c): choices B and C both look plausible until the student decides whether self fragments are displayed at all. |

**Correct answer (C): During maturation, any clone able to lock onto an unaltered body component is culled, and one such clone escaped.**

Citations: AP:43106 (self-antigens are brought into the maturing site from other parts of the body, and the lymphocytes that bind them are killed by apoptosis); AP:43109 (the only cells left are those that bind the body's own MHC molecules when a foreign antigen is presented in the cleft, preventing an attack on one's own tissues); MICRO:32981 (this editing prevents self-reacting cells from reaching the bloodstream and potentially causing autoimmune disease); AP:43005 (the recognized unit is the combination of the MHC molecule and the peptide fragment)

**Distractors**

- **(A)** `reversed_relationship` . _inside versus outside sampling reversed_: Reverses which material the display on nucleated cells samples: showing fragments of proteins made inside the cell is its normal function, not a fault.
  - Citation: AP:43005
- **(B)** `misconception` . _self peptides never presented_: Asserts the widely held but false belief that self peptides are excluded from display, when in an uninfected person most occupied clefts hold self material.
  - Citation: AP:43109
- **(D)** `process_step_confusion` . _activation site substituted for repertoire editing_: Names the wrong stage: where a clone is activated is an ordinary sequential feature of a response and does not generate specificity for a body constituent, whereas the defect lies in which clones survived maturation.
  - Citation: MICRO:32981

**Readback check.** Content words of six or more letters in key C: During, maturation, unaltered, component, culled, escaped. Stem and lead-in words of six or more letters: moment, peptides, molecules, pieces, everyday, proteins, healthy, tissue, lining, several, joints, steadily, destroyed, lymphocytes, normal, unmodified, protein, requirement, system, broken. No overlap, so no stem echo, and the key is the second shortest option rather than the longest. The stem supplies the outcome and the fact that self fragments are routinely displayed; it never states that the responding population is edited, which is the inference required.

**Explanation (as shipped).**

> This Organ Systems item examines self versus nonself recognition and the origin of autoimmune disease. The answer is C because tolerance is not achieved by hiding the body's own fragments from display but by editing the responding population so that no surviving clone binds strongly to a fragment of the body itself. Display is indiscriminate: a cell chops up whatever proteins it contains and shows the pieces, so in an uninfected person almost everything on show is self. Safety therefore has to be built into the other half of the interaction. As lymphocytes of this lineage mature, those whose binding sites engage a body-derived fragment held in the body's own display molecule are removed by programmed cell death, leaving a repertoire that reacts only when something unfamiliar occupies the cleft. When a clone with self-directed specificity survives that editing and later meets its target, the machinery works exactly as designed and destroys healthy tissue, which is what autoimmune disease is. Working backwards from the outcome described, the display side is functioning normally and the failure must lie in the editing of the repertoire.
>
> (Choice A) This reverses the sampling rule. The display found on essentially every nucleated cell exists precisely to show fragments of proteins made inside that cell, which is how an infected cell advertises what it is manufacturing. Showing internally made pieces is normal function, not pathology.
>
> (Choice B) This states the common but incorrect belief that self peptides are excluded from display. In an uninfected person the great majority of occupied clefts hold self material, and this is exactly why tolerance has to be enforced on the responding cells instead.
>
> (Choice D) This names the wrong stage of the response. Encounter with antigen in a lymphoid organ and subsequent action in the tissue are ordinary sequential steps of a normal adaptive response, and an unusual order of events would not by itself create specificity for a body constituent. The defect here concerns which clones exist at all, not where they were switched on.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to start from a destructive clinical outcome and infer which of two separable safeguards, indiscriminate display or edited repertoire, must have failed.

---

## B2-Q13 . Display Requirement for T Lymphocyte Recognition

**Stem.** A soluble binding protein in blood grips an intact bacterial toxin as it drifts through the interstitium and blocks it there. A T lymphocyte with the same binding specificity ignores that free toxin completely, and engages only after a body cell has chopped the toxin up and set the pieces in its own surface display. What does this stricter rule buy the body?

- **A.** The binding site can then grip a far broader chemical range than a soluble binder ever could, including whole folded shapes.
- **B.** It ensures the toxin is neutralised before it reaches the tissue it would injure.
- **C.** It assigns the lymphocyte to threats that are still outside cells and leaves the soluble binder to handle threats already sitting inside them.
- **D.** Reactivity becomes conditional on a cell having taken up or manufactured the offending material, so the ensuing action is aimed at one identified cell rather than at the fluid around it.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (D): Reactivity becomes conditional on a cell having taken up or manufactured the offending material, so the ensuing action is aimed at one identified cell rather than at the fluid around it.**

Citations: AP:42993-42994 (T lymphocytes do not recognise free-floating or cell-bound native antigen; they recognise antigen only on the surface of presenting cells); AP:42995-42997 (internalisation and enzymatic cleavage into smaller pieces precede display of fragments with the presenting protein); AP:43283-43284 (B lymphocytes, by contrast, bind native unprocessed antigen and require no presenting molecule); MICRO:32853-32855 (all nucleated cells process and present, signalling whether the cell is normal or infected)

**Distractors**

- **(A)** `misconception` . _presentation broadens rather than narrows the recognisable chemistry_: Display restricts recognition to short processed fragments seated in a binding groove; native folded surfaces, sugars and lipids are what a free binder can hold and a presented fragment cannot be.
  - Citation: AP:42995-42997; AP:43019
- **(B)** `adjacent_fact` . _true of the soluble binder, irrelevant to the lymphocyte rule_: Neutralising a toxin in transit is a real function, but it belongs to the free binder described in the stem and says nothing about why a lymphocyte declines an antigen it could bind.
  - Citation: AP:43283-43284
- **(C)** `reversed_relationship` . _inside and outside assignments swapped_: The direction is inverted: the display rule is what aims the lymphocyte at material a cell has taken in or made, while circulating binders act on antigen still free in fluids.
  - Citation: AP:42993-42994; AP:43283-43284

**Readback check.** Key content words of six or more letters: Reactivity, becomes, conditional, having, manufactured, offending, material, ensuing, action, identified, rather, around. Stem content words of six or more letters: soluble, binding, protein, intact, bacterial, drifts, through, interstitium, blocks, lymphocyte, specificity, ignores, completely, engages, chopped, pieces, surface, display, stricter. No overlap. The key states a consequence not present in the stem, so no banned readback pattern applies.

**Explanation (as shipped).**

> This Organ Systems item tests antigen presentation as the precondition for adaptive cellular recognition. The answer is D because making the trigger a processed fragment held in a cell's own display converts recognition into a statement about one particular cell rather than about the extracellular pool, so whatever the lymphocyte does next lands on that cell. A free binder and a T lymphocyte are built for different jobs. The free binder must find its quarry anywhere in solution, so it grips whole native shapes wherever they happen to drift, and its useful output is simply to coat or block. The lymphocyte's output is always directed at a cell: either it destroys one that is building something foreign, or it authorises one that has swallowed something foreign to escalate. A trigger that fires only once a cell has processed and posted material therefore functions as an address, naming which cell needs the attention. There is a second payoff: the fragments on show are drawn from the inside of that cell, the one compartment a free binder can never sample, so an organism that hides indoors is still reported to the outside world.
>
> (Choice A) The rule narrows the chemical range rather than widening it. Only short processed pieces fit the groove of the presenting protein, whereas a binder working in solution can engage intact envelopes, sugars and folded conformations that would not survive processing at all.
>
> (Choice B) Stopping the toxin before it reaches its tissue is the contribution of the free binder described in the stem, not the payoff of the cell bound rule. It answers a different question, and it does not explain why a lymphocyte should refuse a molecule it is perfectly capable of gripping.
>
> (Choice C) This reverses the division of labour. The cell bound rule is precisely what points the lymphocyte at material a cell has already internalised or synthesised, while binders circulating in body fluids are the arm that works on what is still loose outside cells.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to state what the presentation requirement accomplishes for an effector whose output must be delivered to a single cell.

---

## B2-Q14 . Loss of the Signal Releasing T Lymphocyte Population

**Stem.** A child inherits a defect that leaves the T lymphocyte population which releases soluble licensing signals absent from blood and lymph nodes. The population that destroys a displaying target by direct contact is present at normal frequency, and macrophages, other phagocytes and B lymphocytes are all normal in number. Which of the following would be expected to fall below normal in this child?

I. Antibody output against a protein antigen met for the first time
II. Accumulation of phagocytes at a splinter wound over the first few hours
III. Destruction of bacteria that macrophages have already engulfed

- **A.** I only
- **B.** I and II only
- **C.** I and III only  <- **KEY**
- **D.** I, II and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (C): I and III only**

Citations: AP:43049-43051 (macrophages and B lymphocytes are among the cells bearing the second display and are the presenters that interact with this T lymphocyte population); AP:43477-43481 (the B lymphocyte binds native antigen, internalises and displays it, and is completed only by soluble T lymphocyte output); MICRO:33132-33133 (this population is activated only through the display restricted to ingesting cells); MICRO:33047-33049 (this population orchestrates antibody and cellular immunity and enhances the pathogen killing functions of macrophages)

**Distractors**

- **(A)** `partial_truth` . _correct on antibody help, blind to macrophage upgrading_: Antibody output does fall, but the same soluble output is also what raises a macrophage's ability to destroy organisms it has already engulfed, so the list is incomplete in a way that changes the answer.
  - Citation: MICRO:33047-33049
- **(B)** `process_step_confusion` . _an early innate step credited to a later adaptive stage_: Phagocyte accumulation at a wound in the first hours is an innate step that precedes adaptive involvement; substituting it for the macrophage killing item misplaces the stage at which the missing population acts.
  - Citation: MICRO:33132-33133
- **(D)** `misconception` . _every inflammatory event treated as adaptively licensed_: It assumes all defensive activity needs adaptive permission; early recruitment to a wound runs on locally released innate mediators and is unaffected by the missing population.
  - Citation: MICRO:33047-33049

**Readback check.** Key text is 'I and III only', containing no content words of six or more letters, so no stem echo is possible. The roman numeral items are not restatements of any stem fact: the stem names only which population is missing, and the student must derive which downstream events depend on it.

**Explanation (as shipped).**

> This Organ Systems item tests the division of labour between the two T lymphocyte populations and the boundary between innate and adaptive control. The answer is C because the absent population is the source of the soluble permissions that a B lymphocyte needs before it will produce antibody against a protein antigen and that a macrophage needs before it raises its internal killing power, while the gathering of phagocytes at fresh damage is driven by innate mediators released at the injury itself. Item I is therefore reduced: an antibody response to a protein antigen is a two cell event, in which the B lymphocyte binds antigen, ingests it, displays fragments in the second kind of display molecule, and only then receives the soluble go ahead. With that go ahead missing, the B lymphocyte stalls even though it is present and specific. Item III is also reduced, because a macrophage that has engulfed a resistant organism frequently cannot finish it off unaided; the soluble signal is what upgrades its internal machinery. Item II is intact, since recruitment within hours of a splinter is set in motion by mediators from damaged tissue and resident phagocytes, none of which depend on adaptive licensing.
>
> (Choice A) This captures the antibody defect but stops short. It treats the missing population as an assistant to B lymphocytes only, when its other documented client is the macrophage, whose killing of already engulfed organisms is raised by the same soluble output.
>
> (Choice B) This swaps the affected macrophage function for an innate one. Arrival of phagocytes at a fresh wound within hours precedes any adaptive involvement and proceeds in people who lack adaptive lymphocytes entirely.
>
> (Choice D) This extends adaptive dependence to an event that is under local innate control. Early recruitment is triggered at the injury itself, so it does not belong in the list with the two adaptive dependent items.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to take a single missing cell population and sort three downstream events by whether each one requires adaptive licensing.

---

## B2-Q15 . Pairing Display Type to Effector Function

**Stem.** Airway lining cells can support the growth of a virus but never engulf outside debris; they carry only the display found on every nucleated cell. In an engineered mouse, that display is deleted from the airway lining alone. Macrophages keep both of their displays and still deliver fragments of the virus to the draining lymph node. Over the following week the mouse builds both T lymphocyte populations at the usual frequency and with the correct specificity. What follows in the infected airway?

- **A.** Contact killing fails at the site of copying, because the effector has no readable account of what is being built inside those cells, even though priming in the node succeeded.  <- **KEY**
- **B.** The lining cells are destroyed anyway, since a body cell that has lost that display is itself read as abnormal and struck down by the same contact dependent lymphocyte.
- **C.** Antibody output against the virus collapses, because the soluble authorisations that drive it are released only once the universal display has been engaged.
- **D.** Killing proceeds on schedule, because the lymphocyte reads whole viral proteins sitting in the plasma membrane of the affected cell and does not need any display.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | Meets (a): it requires joining antigen presentation to the division of labour between the two populations and to the two stages of a response. Meets (c): choices B and D are both defensible until the specific rule that this effector must physically engage a fragment held in a display is applied. Meets (d): the stem supplies an engineered outcome and asks the student to work backwards to locate which stage of the sequence broke. |

**Correct answer (A): Contact killing fails at the site of copying, because the effector has no readable account of what is being built inside those cells, even though priming in the node succeeded.**

Citations: MICRO:32817-32821 (one display sits on all nucleated cells and presents to the effectors of cellular immunity; the other is confined to ingesting cells and serves initial activation); MICRO:32903-32906 (the universal display is how a nucleated cell reports its internal contents and signals that it is normal); MICRO:33044-33045 (the contact killing population recognises antigen only in the universal display, on presenting cells or on infected nucleated cells); AP:43049-43051 (only immune cells that ingest carry the second display); AP:43614-43617 (many cells lower the universal display during viral infection, which removes the contact killer's activity, while a separate lineage recognises display negative cells)

**Distractors**

- **(B)** `adjacent_fact` . _missing display alarm attributed to the wrong lineage_: Treating loss of the display as an alarm is genuine behaviour of a different sentinel cell type; the contact dependent T lymphocyte requires the display to be present in order to engage anything at all.
  - Citation: AP:43614-43617
- **(C)** `reversed_relationship` . _the two displays swapped between the two populations_: Soluble authorisations are released by the population reading the display restricted to ingesting cells, and those cells are unaltered here, so antibody output is not the function that fails.
  - Citation: MICRO:33132-33133
- **(D)** `misconception` . _T lymphocyte pictured recognising native surface protein_: A T lymphocyte cannot engage intact protein in a target membrane; it binds only a processed fragment seated in a display molecule, which is the very thing the engineered cells lack.
  - Citation: AP:42993-42994

**Readback check.** Key content words of six or more letters: Contact, killing, copying, because, effector, readable, account, inside, though, priming, succeeded. Stem content words of six or more letters: Airway, lining, support, growth, engulf, outside, debris, display, nucleated, engineered, deleted, Macrophages, displays, deliver, fragments, draining, populations, frequency, correct, specificity, infected. No overlap. The stem supplies an engineered condition and the key states an inferred outcome, so no banned readback pattern applies.

**Explanation (as shipped).**

> This Organ Systems item tests why each T lymphocyte population is paired with a different display molecule, and what that pairing accomplishes. The answer is A because the two displays serve two separate stages: the one restricted to ingesting cells starts the response in lymphoid tissue, while the one carried by every nucleated cell is how an ordinary body cell reports its internal contents to the population that kills by touch. Deleting the second display from the airway removes the report without touching the start. Macrophages still ferry antigen to the node, so both populations are raised on schedule, exactly as the stem states. But when the trained contact killer reaches the airway it finds cells that present nothing at all, and since its whole engagement rule is to bind a fragment seated in that display, it cannot tell an infected lining cell from a healthy one. The virus therefore continues to be made in a compartment that has gone dark to this effector. This is the reason the pairing exists: every nucleated cell must be readable, or an intracellular resident could simply pick a tissue that does not ingest anything and never be reported. Some viruses exploit precisely this by lowering that display on the cells they occupy.
>
> (Choice B) Being struck down for having lost the display is a real defence, but it belongs to a different sentinel lineage that treats absence of the display as the alarm. The contact dependent T lymphocyte works the opposite way: it must physically engage a fragment held in a display, so a bare cell is invisible to it.
>
> (Choice C) The direction is inverted. Soluble authorisations come from the population that reads the display restricted to ingesting cells, and macrophages retain both displays in this animal, so antibody responses have the input they need.
>
> (Choice D) A lymphocyte that read intact viral proteins in the membrane would need no presentation at all, which is the recognition style of a soluble binder rather than of a T lymphocyte. Presentation of a processed fragment is the only way this effector engages a target.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to take an engineered deletion and infer which stage of the response, initiation or execution, is the one that fails.

---

## B2-Q16 . Interpreting a Matched Display Killing Assay

**Stem.** Lymphocytes that kill by touching their quarry were taken from a mouse of display variant m that had recovered from virus P. Portions of the same preparation were mixed with four sets of cells, and the percentage of each set destroyed was recorded over six hours. All sets were plated at equal density.

| Cell set | Display variant | Carrying | 2 h | 4 h | 6 h |
| --- | --- | --- | --- | --- | --- |
| W | m | virus P | 12 | 41 | 68 |
| X | n | virus P | 2 | 3 | 4 |
| Y | m | none | 1 | 3 | 3 |
| Z | m | virus Q | 2 | 4 | 5 |

What do the four time courses together establish?

- **A.** The killers act on the virus itself, and set X escaped because it was carrying fewer viral particles than set W.
- **B.** Attack requires both a piece of the infecting agent and a matched version of the presenting molecule; either one on its own leaves the cell intact.  <- **KEY**
- **C.** Sharing the display variant is what licenses attack, since the one set that resisted throughout was the set carrying the other variant.
- **D.** The variant difference only slows the process, so set X would reach set W's level if the six hours were extended.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 105 s |
| Confidence | 5 |

**Correct answer (B): Attack requires both a piece of the infecting agent and a matched version of the presenting molecule; either one on its own leaves the cell intact.**

Citations: MICRO:33044-33045 (the contact killing population engages antigen only when it is presented in the universal display, including on nucleated cells infected with an intracellular pathogen); MICRO:32903-32906 (the universal display reports the internal contents of a nucleated cell); AP:43173-43176 (the lymphocyte is held to its target in two ways, by direct binding to the presenting molecule itself and by its receptor binding the antigen fragment); AP:43019-43021 (the presenting molecules bring processed antigen to the surface and present it together with the receptor's target)

**Distractors**

- **(A)** `misconception` . _killer pictured as binding free virus, plus invented load difference_: The design holds the agent constant between sets W and X, so a difference in viral load is unmeasured and unsupported, and direct recognition of the agent would not explain why sets Y and Z survived.
  - Citation: AP:43019-43021
- **(C)** `partial_truth` . _variant treated as sufficient rather than necessary_: Variant sharing is necessary but not sufficient: sets Y and Z share variant m with set W and remain at background, which the claim cannot accommodate.
  - Citation: MICRO:33044-33045
- **(D)** `scale_unit_error` . _a categorical block reinterpreted as a slower rate on a longer timescale_: Set X shows a flat 2 to 4 percent drift while set W accelerates past 41 percent by four hours; extrapolating a flat line to a rising one misreads a categorical block as a difference in timescale.
  - Citation: MICRO:33044-33045

**Readback check.** Key content words of six or more letters: Attack, requires, infecting, matched, version, presenting, molecule, intact. Stem and table content words of six or more letters: Lymphocytes, touching, quarry, display, variant, recovered, Portions, preparation, percentage, destroyed, recorded, plated, density, Carrying, courses, together, establish. No overlap. The key is not a value read from the table; it is the conclusion of two controlled comparisons across four rows.

**Explanation (as shipped).**

> This Organ Systems item tests antigen presentation and binding specificity through a killing time course. The answer is B because the four sets form a two by two design, and only the set that shares both features with the source animal is destroyed. Set W shares the variant and carries the agent the source animal had met, and it climbs from 12 to 68 percent. Set X carries the same agent but the other variant, and stays at background. Set Y shares the variant but carries nothing, and stays at background. Set Z shares the variant and carries a different agent, and stays at background. Comparing W with X isolates the variant while holding the agent constant; comparing W with Y and Z isolates the agent while holding the variant constant. Each comparison collapses the response, so neither feature is sufficient by itself and both are necessary together. That is the signature of an effector that binds a processed fragment seated in a particular presenting protein, so the fragment alone and the protein alone are both invisible to it.
>
> (Choice A) Nothing in the design allows a claim about how much agent each set carries; sets W and X were prepared with the same agent, and the only stated difference between them is the variant. Invoking an unmeasured difference in load also fails to explain why sets Y and Z, which share the variant, were spared.
>
> (Choice C) The variant clearly matters, but the claim that it is sufficient is refuted within the same table. Sets Y and Z carry the identical variant to set W and remain at three and five percent, so variant sharing without the right fragment produces nothing.
>
> (Choice D) The trend argues against a slower version of the same process. Set W is already at 41 percent by four hours and accelerating, while set X moves from 2 to 4 percent across the whole run, a flat background drift rather than a delayed rise.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to compare four matched time courses and decide which combination of variables is necessary for the outcome.

---

## B2-Q17 . Two Screens During Lymphocyte Maturation

**Stem.** In one mouse strain, developing lymphocytes inside the site where they are screened meet the animal's own display molecules normally, but peptide fragments belonging to distant tissues are never carried into that site. Cells finish screening and leave for the bloodstream in normal or slightly greater numbers than usual. What outcome is most probable in these animals?

- **A.** Cells exiting the site cannot engage the display molecule on any body cell, so this arm of defence never operates.
- **B.** A first meeting with a pathogen proceeds normally, but no accelerated reaction follows a repeat meeting.
- **C.** Cells entering circulation are prone to causing autoimmune destruction of otherwise unharmed body structures.  <- **KEY**
- **D.** Every self-reactive cell that reaches the blood is destroyed on its first contact with a body cell, so tissue damage cannot occur.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (C): Cells entering circulation are prone to causing autoimmune destruction of otherwise unharmed body structures.**

Citations: AP:43087; AP:43106; AP:43108; AP:43111; MICRO:32982; MICRO:32986

**Distractors**

- **(A)** `process_step_confusion` . _wrong stage of a two-stage process_: Names the outcome of the other screen, the one still functioning here; the stem specifies normal display molecules and normal or slightly raised graduation numbers.
  - Citation: AP:43087
- **(B)** `adjacent_fact` . _true statement about a different immune property_: Describes loss of an accelerated repeat response, a true phenomenon in other settings but unrelated to withholding tissue peptides during screening.
  - Citation: AP:42928
- **(D)** `partial_truth` . _real safeguard stated as an absolute_: A peripheral backup exists but is not absolute and requires specific conditions; asserting that damage cannot occur overstates it and reverses the predicted outcome.
  - Citation: MICRO:32986

**Readback check.** Key C content words of six or more letters: entering, circulation, causing, autoimmune, destruction, otherwise, unharmed, structures. Stem content words of six or more letters: strain, developing, lymphocytes, inside, screened, animal, display, molecules, normally, peptide, fragments, belonging, distant, tissues, carried, finish, screening, bloodstream, normal, slightly, greater, numbers, outcome, probable, animals. No word appears in both lists. No distinctive term is shared between stem and key, and the key names a consequence that must be inferred from removing one screen.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests self versus nonself recognition, specifically what a developing lymphocyte must prove during maturation before it is licensed to circulate. The answer is C because a cell whose binding site happens to fit a tissue that was never sampled at the screening site was never given an opportunity to fail the tolerance test against that tissue, so it survives and leaves armed against the animal itself. Maturation poses two logically separate questions. The first asks whether the young cell can engage the organism's own display molecules at all; since every antigen this lineage will ever see must be handed to it on such a display, a cell that cannot dock there is useless and is eliminated. The second asks whether the cell reacts strongly to fragments of the organism's own proteins; a cell that does react is dangerous and is likewise eliminated. In the strain described, the first question is still posed and answered, because the display molecules are present and cells graduate in at least their usual numbers. The second question, however, is posed only about the proteins that happen to be available at that location. Specificities directed at tissues whose peptides never arrive are never challenged, so they slip through a screen that only appears to have run, and the modest excess of graduates is itself the signature of deletions that failed to happen. The predicted result is not global immune failure but a targeted attack on the very tissues that went unrepresented. (Choice A) Inability to dock onto the display molecule is the failure mode of the screen that is still intact here, and that failure would sharply reduce the number of graduating cells rather than leave it normal or slightly raised, which the stem rules out. (Choice B) A weakened reaction on second exposure concerns whether a long-lived responder population is laid down after a first encounter, a separate matter that this manipulation does not touch. (Choice D) A backup does exist once cells reach the periphery, but it is neither absolute nor automatic: it depends on a self-reactive cell meeting its target under conditions that withhold the extra licensing input, and plenty of self-reactive cells escape it. The stated certainty that damage cannot occur is what makes this choice fail. This is a Scientific Reasoning and Problem Solving question because it asks the student to disable one of two developmental screens and predict the specific, tissue-restricted failure of self versus nonself recognition that follows.

---

## B2-Q18 . Prebuilt Repertoire and First Response Lag

**Stem.** A person encounters a bacterial protein for the first time. Defence aimed precisely at that protein becomes measurable only after several days, even though cells able to bind the protein were already stocked in the body at the moment of exposure. What accounts for the lag?

- **A.** Any one binding shape is carried by only a handful of cells, and many rounds of division are needed until that clone is numerous enough to act.  <- **KEY**
- **B.** The fit to that protein is manufactured only after the protein arrives, and shaping a new receptor takes days.
- **C.** The protein must first be ferried to a filtering lymphoid organ, and that journey occupies most of the interval.
- **D.** The interval corresponds to the time a single responding cell needs to complete one round of copying itself.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (A): Any one binding shape is carried by only a handful of cells, and many rounds of division are needed until that clone is numerous enough to act.**

Citations: AP:43127; AP:43138; AP:43140; AP:43142; AP:43401; AP:42924

**Distractors**

- **(B)** `misconception` . _instructional rather than selective model_: Asserts that specificity is built after antigen arrives, the instructional model clonal selection displaced, and it contradicts the stem's statement that fitting cells were already present.
  - Citation: AP:43127
- **(C)** `partial_truth` . _real step that is too small to explain the effect_: Antigen transport to a lymphoid organ genuinely occurs but occupies hours, so it cannot account for a delay of several days, which the text attributes to clonal expansion, or for the loss of that delay on re-exposure.
  - Citation: AP:43401
- **(D)** `scale_unit_error` . _right mechanism, wrong timescale_: Correctly identifies proliferation as the cause but assigns days to a single division cycle, which in fact takes hours; the observed lag reflects many cycles.
  - Citation: AP:43401

**Readback check.** Key A content words of six or more letters: binding, carried, handful, division, needed, numerous, enough. Stem content words of six or more letters: encounters, bacterial, protein, Defence, precisely, measurable, several, though, already, stocked, moment, exposure, accounts. No word appears in both lists. The stem supplies only that fitting cells pre-exist; the key requires inferring their scarcity and the consequent need for expansion.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests clonal selection, in particular what a repertoire assembled in advance predicts about the timing of a first response. The answer is A because the only way to hold enough distinct receptor shapes to cover an unpredictable world is to keep each individual shape at extremely low abundance, and that low starting abundance is precisely what forces a delay while the matching cells multiply. The body cannot know in advance which shapes it will need, so it generates an enormous library of them ahead of any encounter, on the order of a hundred billion different specificities. That library must fit inside a finite pool of circulating cells, so arithmetic alone dictates that each single specificity is represented by only a tiny fraction of the pool. When an antigen finally appears it does not instruct a cell to construct a fit; it simply picks out the rare cells that already fit and drives them to proliferate. Repeated doublings over several days are required before that rare founding population becomes large enough to produce a measurable effect. The same logic explains why a later encounter with the identical antigen is fast: the matching population has already been expanded and no longer starts from scarcity. (Choice B) This is the custom-built-on-demand model that clonal selection replaced. The stem states that cells able to bind were already stocked, so no construction step remains to be carried out. (Choice C) Delivery of antigen to a filtering lymphoid organ is real and does consume time, but that transit is measured in hours rather than days, and it cannot explain why the delay largely disappears on re-exposure to the same antigen. (Choice D) This identifies expansion as the cause but places it at the wrong magnitude of time. A responding lymphocyte completes a cycle in hours, not days, which is why the delay reflects many successive cycles rather than one. This is a Scientific Reasoning and Problem Solving question because it asks the student to reason from the size of a pre-existing repertoire to the scarcity of any one specificity and then to the timing of a first response.

---

## B2-Q19 . Testing Necessity of a Licensing Contact

**Stem.** A researcher asks whether engagement of a displayed fragment is on its own enough to drive a resting lymphocyte into division. Lymphocytes cultured with cell line P, which carries the fragment and a full set of surface proteins, divide vigorously. The same lymphocytes cultured with line Q, identical to P except that it lacks one surface protein, do not divide at all. A colleague objects that line Q may simply be placing fewer fragments on its outer face. Which further condition would settle the objection?

- **A.** Repeat the run with line P across a series of fragment densities to show that division tracks how much is on offer.
- **B.** Repeat the pairing with line Q while supplying a soluble molecule that stands in for the absent membrane component.  <- **KEY**
- **C.** Add a well containing only the resting cells, with neither line present.
- **D.** Draw the resting cells from an animal that has never met the fragment previously.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 95 s |
| Confidence | 4 |

**Correct answer (B): Repeat the pairing with line Q while supplying a soluble molecule that stands in for the absent membrane component.**

Citations: MICRO:32988; MICRO:33214; AP:43122; AP:43127

**Distractors**

- **(A)** `adjacent_fact` . _informative experiment that misses the confound_: A dose series on the intact line characterises the normal graded response to presented antigen but never tests the altered line, so the alternative explanation for its failure survives untouched.
  - Citation: AP:43122
- **(C)** `partial_truth` . _necessary control that is not the discriminating one_: A cells-only baseline is genuinely required for the assay but predicts the same result under both hypotheses, so it cannot discriminate between them.
  - Citation: MICRO:32988
- **(D)** `misconception` . _exposure creates specificity_: Assumes prior exposure shapes binding specificity; specificity is fixed before antigen is ever met, so this manipulation is inert with respect to the objection.
  - Citation: AP:43127

**Readback check.** Key B content words of six or more letters: Repeat, pairing, supplying, soluble, molecule, stands, absent, membrane, component. Stem content words of six or more letters: researcher, engagement, displayed, fragment, enough, resting, lymphocyte, division, Lymphocytes, cultured, carries, surface, proteins, divide, vigorously, identical, except, protein, colleague, objects, simply, placing, fragments, outer, further, condition, settle, objection. No word appears in both lists. The key cannot be produced by matching a term from the stem; it requires recognising rescue logic.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests reasoning about experimental design, applied to the claim that antigen recognition alone is insufficient to activate a lymphocyte. The answer is B because a rescue condition is the only listed manipulation that separates the two competing explanations for line Q's failure. The colleague's objection is a confound: line Q differs from line P in the intended way, but it might also differ in an unintended way, namely how densely it decorates its outer face with fragment. If the loss of division were caused by too little fragment, then restoring the missing surface component in trans, without touching fragment density, would leave the cultures still quiescent. If instead the loss were caused by absence of a second, licensing engagement, then restoring that engagement while fragment density remains exactly as it was should bring division back. A single result therefore discriminates between the hypotheses, which is what a control must do. Note also that the rescue reagent is deliberately chosen so that it cannot itself alter presentation, keeping the comparison to one variable. (Choice A) A dose series on line P establishes that the response is graded with the amount presented, which is useful background but says nothing about line Q, and it therefore leaves the confound exactly where it was. (Choice C) A cells-only well is a necessary baseline for defining spontaneous division, and its absence would weaken the study, but it cannot distinguish sparse fragment on line Q from a missing licensing contact, since both hypotheses predict the same near-zero baseline. (Choice D) Prior exposure is irrelevant, because a lymphocyte's binding specificity is fixed before it ever meets its antigen; naive cells are in fact the standard starting material for such an assay, so this changes nothing about the confound. This is a Reasoning about the Design and Execution of Research question because it asks the student to identify the rescue condition that distinguishes a deliberate manipulation from an unintended difference between two cell lines.

---

## B2-Q20 . Dose Response With Licensing Withheld

**Stem.** Resting lymphocytes were cultured with partner cells carrying a fragment on their outer face. In one set the partner cells also made a second engagement with the lymphocyte; in the other set that second engagement was interrupted by a reagent shown not to interfere with fragment binding. The table gives the percentage of lymphocytes entering division after three days.

| Fragment dose (arb. units) | Second engagement intact (%) | Second engagement interrupted (%) |
| --- | --- | --- |
| 0 | 1 | 1 |
| 1 | 12 | 1 |
| 10 | 38 | 2 |
| 100 | 61 | 2 |
| 1000 | 62 | 2 |

What do these results establish about the second engagement?

- **A.** The fragment supplies the permissive input and the second engagement supplies the specificity, since specificity disappears once that engagement is interrupted.
- **B.** The second engagement lifts the ceiling of the response but leaves the dose needed for a half maximal response unchanged.
- **C.** The second engagement is sufficient by itself, since cells enter division when it is present even with no fragment added.
- **D.** The confirming input operates as an all or none permission step, because raising the amount on offer cannot compensate for its loss.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | Meets (b) because it requires a directional inference across a thousandfold dose range rather than a lookup, and meets (c) because choices B and D both fit a casual reading until the flatness of the interrupted column and the zero-dose row are applied. It also meets (a) by combining dose response logic with the tolerance safeguard rationale. |

**Correct answer (D): The confirming input operates as an all or none permission step, because raising the amount on offer cannot compensate for its loss.**

Citations: MICRO:32988; MICRO:33214; AP:43127; MICRO:32986

**Distractors**

- **(A)** `reversed_relationship` . _roles of two signals exchanged_: Swaps which input carries specificity and which grants permission; the graded dependence on fragment dose shows the fragment carries the specific information.
  - Citation: AP:43127
- **(B)** `partial_truth` . _efficacy shift applied to a null curve_: Correct that the maximum is higher when the engagement is intact, but a flat background line has no definable half maximal dose, so the described potency comparison misreads the data.
  - Citation: MICRO:32988
- **(C)** `misconception` . _licensing signal treated as self-sufficient_: Contradicted by the zero-dose row, where division sits at background even with the engagement intact, showing that co-recognition of fragment and the second input is required rather than the second input alone.
  - Citation: MICRO:33214

**Readback check.** Key D content words of six or more letters: confirming, operates, permission, raising, amount, cannot, compensate. Stem and table content words of six or more letters: Resting, lymphocytes, cultured, partner, carrying, fragment, outer, second, engagement, lymphocyte, interrupted, reagent, interfere, binding, percentage, entering, division, Fragment, intact, results, establish. No word appears in both lists. The key is not a value read off the table; it requires comparing the shape of two columns across a thousandfold dose range.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests data-based reasoning about the requirement for a second, licensing input beyond antigen recognition alone. The answer is D because the interrupted column stays flat at background across a thousandfold range of fragment, which is the signature of a gate rather than of an amplifier. Compare the two columns as functions of dose. With the second engagement intact, the response is clearly graded: it climbs from 1 to 12 to 38 to 61 percent and then plateaus, exactly what a saturating recognition process looks like. With that engagement interrupted, the response never leaves background no matter how much fragment is offered, so the two conditions are not two points on one curve. If the second engagement merely added to or multiplied the recognition signal, enough fragment should eventually substitute for it, and the interrupted curve would simply be shifted or scaled. It is not. The functional reading is that recognition without confirmation yields inaction by design, which is precisely the safeguard the body needs: a lymphocyte that meets its target in the absence of corroborating evidence of danger must do nothing, or every encounter with a self fragment would become an attack. (Choice A) This reverses the roles of the two inputs. The dose response in the intact column is driven by fragment, showing that the fragment carries the specific information; the second engagement is uniform across doses and therefore cannot be what confers specificity. (Choice B) A pure ceiling effect would still permit a graded rise in the interrupted column at some dose, and it presumes a half maximal value that cannot be defined for a flat line at background. (Choice C) The zero-dose row settles this directly: with the second engagement intact but no fragment present, division sits at 1 percent, identical to background, so the engagement alone drives nothing. This is a Data-based and Statistical Reasoning question because it asks the student to compare the shapes of two dose response columns across a thousandfold range and infer that one input gates the other rather than adding to it.

---

## B2-Q21 . Collapse of Both Adaptive Arms Together

**Stem.** A virus slowly destroys the lymphocyte subset that neither kills target cells on contact nor secretes soluble binding proteins, and whose only output is the signal that permits other cells to act. After several years almost none of that subset remains in an infected patient. Consider three defensive activities:

I. Destruction of the patient's own virus-infected cells by the lymphocyte lineage that kills on contact
II. Generation of antigen-specific soluble binding proteins against a newly encountered protein
III. Engulfment and digestion of bacteria by phagocytes arriving at a fresh wound

Which activities are expected to be substantially impaired?

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
| Estimated time | 95 s |
| Confidence | 5 |
| Hard-tier gate | Meets (a): combines the innate versus adaptive distinction with the dependence of two separate adaptive effector arms on one licensing population. Meets (c): choices A and B are each defensible until the student applies the fact that the same permission step gates both killing and secretion. Meets (d): given the outcome of the deficiency, the student must infer backwards which defences fall rather than reading off a stated mechanism. |

**Correct answer (C): I and II only**

Citations: MICRO:33048, MICRO:33074, MICRO:31751, MICRO:31762, AP:43712, AP:43725

**Distractors**

- **(A)** `partial_truth` . _one-arm-only_: Correctly identifies that contact killing fails, but omits the humoral arm, which depends on the same licensing step and also collapses.
  - Citation: MICRO:33048
- **(B)** `partial_truth` . _one-arm-only_: Correctly identifies that the response producing soluble binding proteins fails, but treats the lost subset as relevant only to that arm; direct killing of infected cells is licensed by the same subset.
  - Citation: AP:43725
- **(D)** `misconception` . _total-collapse_: Assumes that losing one lymphocyte subset abolishes host defence generally; innate phagocytic clearance is constitutive, driven by receptors for conserved microbial structures, and requires no adaptive permission.
  - Citation: MICRO:31762

**Readback check.** Key text is 'I and II only'. It contains no content word of six or more letters, so no stem echo is possible. The reasoning that selects it (both adaptive arms are licensed, innate phagocytosis is not) is nowhere stated in the stem; the stem supplies only the functional description of the missing subset and the three candidate activities.

**Explanation (as shipped).**

> Organ Systems: this item probes the boundary between innate defences and the two adaptive arms, and the dependence of both adaptive arms on a single lymphocyte population. The answer is C because the destroyed subset licenses both the contact-killing lineage and the lineage that secretes antigen-specific soluble binding proteins, whereas engulfment at a fresh wound is an innate function that no lymphocyte controls.
>
> The subset described does no effector work of its own. Its product is permission: it inspects fragments displayed by cells that have taken up foreign material, and when the fit is right it releases signals allowing a second cell to divide and mature. Item I therefore fails, because the contact-killing lineage expands to useful numbers only after receiving that permission, so cells harbouring virus accumulate. Item II fails for the same structural reason: the cell that secretes soluble binding proteins against a protein must first display fragments of that protein and be inspected before it will proliferate. Item III does not fail, because a phagocyte arriving at a wound recognises broad molecular patterns shared by many groups of microbes, has no clonal specificity, and needs no lymphocyte permission to ingest and digest what it finds.
>
> (Choice A) I only captures the cellular arm but stops there. It reflects a reading in which the lost subset supports only killing, whereas the reaction to a protein antigen depends on the very same permission step and fails alongside it.
>
> (Choice B) II only captures the humoral arm alone, a common assumption because the licensing cell is usually introduced in the setting of antibody production. Direct killing of infected cells is licensed by that same subset and is lost as well.
>
> (Choice D) I, II, and III treats the loss as total. Innate clearance is constitutive: phagocytes are produced in bone marrow, circulate continuously, and carry receptors for conserved microbial surface structures, so they act without any adaptive instruction. That is why a patient stripped of this subset still walls off ordinary wound bacteria while succumbing to organisms whose control requires adaptive specificity.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to sort three defensive activities by whether each one depends on adaptive licensing or runs on innate machinery that operates independently of any lymphocyte.

---

## B2-Q22 . Protein Versus Polysaccharide Antigen Dependence

**Stem.** A child lacks the lymphocyte subset that neither kills on contact nor secretes soluble binding proteins, and whose only output is the permission signal other cells require. After immunisation she generates a normal quantity of specific soluble binding protein against a bacterial capsular polysaccharide, but almost none against a purified protein toxin. Which feature of the two immunogens accounts for the difference?

- **A.** Both immunogens require the same inspection step, but the toxin was given at a dose too low to trigger it.
- **B.** Only one of the two must first be broken into fragments and displayed for inspection by the missing cells before the responding cell is allowed to proliferate.  <- **KEY**
- **C.** The missing cells are themselves the source of circulating binding proteins, so any reaction that depends on them collapses.
- **D.** The repeating, evenly spaced units of the polysaccharide keep its receptors from clustering, so no activating signal is delivered.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (B): Only one of the two must first be broken into fragments and displayed for inspection by the missing cells before the responding cell is allowed to proliferate.**

Citations: MICRO:33404, MICRO:33423, MICRO:33429, MICRO:33434, MICRO:33461

**Distractors**

- **(A)** `misconception` . _dose-explains-it_: Asserts that every antigen class needs the same inspection step and then blames a shortfall of antigen; the polysaccharide route has no such step, and the defect is categorical rather than a matter of magnitude.
  - Citation: MICRO:33423
- **(C)** `misconception` . _wrong-producer_: Treats the missing subset as the producer of the circulating binding proteins; the secreting cells are descendants of the responding lymphocyte, and if the missing subset made them the polysaccharide reaction would also have failed, which it did not.
  - Citation: MICRO:33434
- **(D)** `reversed_relationship` . _inverted-effect_: Reverses the effect of repeating structure: evenly spaced repeating units promote receptor cross-linking, which is why the polysaccharide reaction proceeds without help.
  - Citation: MICRO:33429

**Readback check.** Key content words of six or more letters: broken, fragments, displayed, inspection, missing, responding, allowed, proliferate. Stem content words of six or more letters: lymphocyte, subset, neither, contact, secretes, soluble, binding, proteins, permission, signal, require, immunisation, generates, normal, quantity, specific, against, bacterial, capsular, polysaccharide, almost, purified, protein, toxin, feature, immunogens, accounts, difference. No overlap. The stem never mentions internalisation, fragmentation, or display, so the key cannot be produced by restating the stem.

**Explanation (as shipped).**

> Organ Systems: this item tests why the molecular class of an antigen determines whether the humoral reaction needs a second lymphocyte to authorise it. The answer is B because a protein immunogen must be internalised, degraded, and returned to the surface of the responding cell for inspection, while a polysaccharide bypasses that requirement entirely.
>
> The cell that secretes soluble binding proteins carries surface receptors of a single specificity, the outcome of clonal selection. A capsular polysaccharide is built from many identical units at regular spacing, so one molecule engages many receptors at once and delivers a strong direct signal; no third party is needed. A protein antigen presents each of its determinants only once or twice, so receptor engagement alone is too weak to commit the cell. The responding cell therefore swallows the protein, degrades it, and returns fragments to its own surface on a display molecule encoded in the major histocompatibility complex. The inspecting subset reads that display, confirms the fragment is nonself, and only then issues the signals that permit division and maturation. Remove the inspecting subset and the polysaccharide route is untouched while the protein route stops, which is exactly the pattern seen in this child.
>
> (Choice A) Dose is not the variable at issue, and the first clause is false: the two immunogens do not share a common requirement. No quantity of extra toxin restores the reaction in someone lacking the inspecting cells, because what is missing is an authorising signal rather than an amount of antigen.
>
> (Choice C) If the missing cells manufactured the circulating binding proteins themselves, no humoral reaction of any kind would survive their loss. The child mounts a full reaction to the polysaccharide, which rules this out and places the deficit in authorisation rather than in production; the secreted proteins come from the mature descendants of the responding lymphocyte itself.
>
> (Choice D) The repeating architecture of a polysaccharide promotes receptor clustering rather than preventing it, and that clustering is precisely why the polysaccharide reaction survives. This choice states the correct relationship in the wrong direction.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which structural class of antigen requires inspection before the responding cell may proliferate and to apply that rule to a stated cellular deficiency.

---

## B2-Q23 . Adoptive Transfer and Causal Necessity

**Stem.** Mice bred without any lymphocytes make no soluble binding proteins against an injected protein and cannot clear a virus from their own tissues. Investigators put purified cells into each of three groups before immunisation: group 1 gets only the lineage that manufactures soluble binding proteins, group 2 gets only the subset that issues permission signals, and group 3 gets both. Groups 1 and 2 yield nothing detectable, while group 3 yields a full amount. Before this experiment, the only evidence linking the permission-issuing subset to the outcome was that its abundance in intact mice tracked the amount of soluble binding protein in serum. What does the group 3 result establish that the earlier evidence could not?

- **A.** That the transferred permission-issuing cells are the direct source of the secreted binding proteins, since output appears only when they are present.
- **B.** That both cell types read the same determinant on the immunogen, since neither works by itself.
- **C.** That nothing beyond the two transferred cell types is needed, since putting them back restored the full reaction.
- **D.** That this cell type is genuinely necessary, because its addition is the only difference between the group that failed and the group that succeeded.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a): combines the immunological requirement for two cooperating cell types with the logic of a controlled add-back manipulation. Meets (c): choices A and C are each defensible until the student applies the distinction between necessity and authorship, and between necessity and sufficiency. Meets (d): the student is given the outcome and must infer which causal claim the design will bear, rather than predicting an outcome from a mechanism. |

**Correct answer (D): That this cell type is genuinely necessary, because its addition is the only difference between the group that failed and the group that succeeded.**

Citations: MICRO:33048, MICRO:33404, MICRO:33461, MICRO:33490

**Distractors**

- **(A)** `misconception` . _necessity-as-authorship_: Confuses being necessary with being the producer; group 1 already contained the secreting lineage and still failed, so the design cannot identify the source of the secreted product.
  - Citation: MICRO:33434
- **(B)** `adjacent_fact` . _untested-true-claim_: Shared determinant recognition is a real feature of this cooperation but was not tested here; the experiment varied only which cells were present, using a single immunogen.
  - Citation: MICRO:33461
- **(C)** `partial_truth` . _necessity-as-sufficiency_: Overreads reconstitution as sufficiency; the recipients retained all their non-lymphocyte cells, including the phagocytic cells that capture and display antigen, so the two transferred types were shown to be required, not sufficient.
  - Citation: MICRO:33490

**Readback check.** Key content words of six or more letters: genuinely, necessary, because, addition, difference, between, failed, succeeded. Stem content words of six or more letters include lymphocytes, soluble, binding, proteins, injected, protein, cannot, tissues, Investigators, purified, groups, immunisation, lineage, manufactures, subset, issues, permission, signals, nothing, detectable, experiment, evidence, linking, abundance, intact, tracked, amount, serum, establish, earlier. No overlap with the key. The stem reports the results but never states what kind of inference they license, so the key requires a design judgement rather than a restatement.

**Explanation (as shipped).**

> Organ Systems and the logic of experimental design: this item asks what an add-back transfer establishes that an observational correlation cannot. The answer is D because transfer converts the presence of a cell type into a variable the investigator sets, so recovery of function when that cell type is added back identifies it as necessary rather than merely co-varying with function.
>
> The earlier evidence was observational. In intact mice, the abundance of the permission-issuing subset and the amount of circulating binding protein rise and fall with the same underlying stimuli, so the two can track each other without either causing the other. The transfer design removes that ambiguity. Recipients begin with no lymphocytes at all, which sets a common baseline; the investigators then change exactly one thing between group 1 and group 3, namely whether the permission-issuing cells are put back. Group 1 stays silent and group 3 responds. Because nothing else differs between those two groups, the difference in result must be attributed to what was added, and the silence of group 1 shows that the secreting lineage cannot supply for itself whatever the second cell type provides.
>
> (Choice A) Necessity is not the same as authorship. Group 1 already contains the lineage that actually secretes the binding proteins and still yields nothing, which shows only that this lineage needs a partner. The design says nothing about which cell releases the secreted product.
>
> (Choice B) Whether the two cell types read the same determinant is a separate question that would require immunogens carrying two distinguishable parts, tested in combination. This experiment varied only presence and absence of cells with one immunogen, so specificity matching was never probed.
>
> (Choice C) Reconstitution occurred in an animal that still possesses all of its non-lymphocyte cells, including the phagocytic cells that first capture foreign material and display it. The result therefore shows the two transferred cell types are required, not that they are sufficient on their own.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to state which inference an add-back manipulation supports that an observed correlation in intact animals does not.

---

## B2-Q24 . Subset Depletion and Arm Specific Readout

**Stem.** Mice receive a purified binding reagent aimed at a surface marker unique to the lymphocyte lineage that destroys its targets by direct contact, and that lineage is cleared from the body. These mice then handle an injected bacterial toxin as well as sham-treated littermates do, generating a normal quantity of specific soluble binding protein against it. The same mice cannot eliminate cells of their own tissues that a virus has entered. The split in outcomes is explained by which property of the removed lineage?

- **A.** It engages a cell only when that cell displays, on its own membrane, pieces of material assembled inside it.  <- **KEY**
- **B.** It can engage only material that stays dissolved in body fluids, so anything sheltered within a cell escapes it.
- **C.** It is the source of the specific soluble binding proteins, so its removal should have blunted the reaction to the injected toxin as well.
- **D.** It comes into play only after the fast, broadly acting defences have failed, and the toxin had already been handled before that stage.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): It engages a cell only when that cell displays, on its own membrane, pieces of material assembled inside it.**

Citations: MICRO:32818, MICRO:32903, MICRO:33042, MICRO:33074, MICRO:33434, MICRO:36400

**Distractors**

- **(B)** `reversed_relationship` . _swapped-arms_: Assigns to the depleted lineage the target range of the arm that was preserved; dissolved extracellular material is handled by the secreted binding proteins, not by the contact-killing lineage.
  - Citation: MICRO:33074
- **(C)** `misconception` . _wrong-producer_: Treats the contact-killing lineage as the producer of the secreted binding proteins, which the intact response to the injected toxin directly excludes; those proteins come from the mature descendants of a different lineage.
  - Citation: MICRO:33434
- **(D)** `process_step_confusion` . _wrong-stage_: Places the removed lineage at the wrong stage, as a backup activated by failure of the early broad defences, when the depletion result speaks to what it recognises rather than to its position in the sequence.
  - Citation: MICRO:33042

**Readback check.** Key content words of six or more letters: engages, displays, membrane, pieces, material, assembled, inside. Stem content words of six or more letters: receive, purified, binding, reagent, surface, marker, unique, lymphocyte, lineage, destroys, targets, direct, contact, cleared, injected, bacterial, treated, littermates, generating, normal, quantity, specific, soluble, protein, against, cannot, eliminate, tissues, entered, outcomes, explained, property, removed. No overlap. The stem gives only the two outcomes; the key names an unstated recognition requirement that must be inferred from the contrast between a target inside a host cell and one circulating outside cells.

**Explanation (as shipped).**

> Organ Systems: this item uses a targeted depletion to isolate which arm of defence one lymphocyte lineage actually carries. The answer is A because the removed lineage acts on cells that show fragments of proteins built within themselves, a display carried by every nucleated cell, and a toxin circulating in body fluids is not such a cell.
>
> A reagent that binds a marker unique to one cell type and clears it from the animal is a subtraction experiment: whatever collapses afterwards is work the subtracted cells were doing. Here the humoral arm is intact, so the removed lineage is neither the maker of the secreted binding proteins nor required by the cell that makes them. What collapses is clearance of the animal's own cells that a virus has entered. Those cells are identifiable only because every nucleated cell continuously samples the proteins it is synthesising and places fragments of them on a surface molecule encoded in the major histocompatibility complex. A cell building viral proteins therefore advertises its state, and the depleted lineage is the one that reads that advertisement and destroys the cell. The injected toxin is dealt with by secreted binding proteins acting on material outside cells, a route that never involves the depleted lineage, so that outcome is untouched.
>
> (Choice B) This inverts the relationship. Material dissolved in body fluids is precisely what the secreted binding proteins deal with, and that arm was preserved. The depleted lineage is the one restricted to targets it can touch and inspect at close range.
>
> (Choice C) If this lineage produced the specific soluble binding proteins, its removal would have flattened the reaction to the injected toxin. That reaction was normal, which excludes this explanation and cleanly separates the two adaptive arms; the secreted proteins come from the mature descendants of a different lymphocyte lineage.
>
> (Choice D) The removed lineage is not a late fallback triggered by failure of the fast, broadly acting defences. It is deployed against cells carrying an infection inside them as part of the adaptive phase regardless of how the early response fared, and the depletion result speaks to what it recognises rather than to when it acts.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to infer, from which defence survived a targeted depletion and which did not, what kind of target the removed cells must be able to recognise.

---



---

# BATCH 3 of 4 (22 questions): B lymphocytes, antibody and memory

Units: B lymphocytes and antigen-antibody recognition (13) . immunological memory (9).

## Batch 3 summary

| Metric | Batch 3 | Combined (68) | Target |
|---|---|---|---|
| Difficulty | easy 6 . hard 8 . medium 8 | easy 18 . hard 22 . medium 28 | 27/40/33 |
| Answer letter | A 5 . B 6 . C 6 . D 5 | A 18 . B 17 . C 17 . D 16 | ~25% each |
| Cognitive skill | S1 5 . S2 9 . S3 3 . S4 5 | S1 9 . S2 37 . S3 9 . S4 13 | mixed |
| Confidence | conf4 6 . conf5 16 | conf4 13 . conf5 55 | only 4-5 ship |
| Roman numeral | 4 (18%) | 9 (13%) | 10-15% |
| Distractor categories | adjacent_fact 8 . misconception 20 . partial_truth 14 . process_step_confusion 14 . reversed_relationship 7 . scale_unit_error 3 | | none dominant |
| Em/en dashes | 0 | 0 | 0 |

**Quotas hit exactly:** A 5, B 6, C 6, D 5; easy 6, medium 8, hard 8; Roman numeral 4; skills 5 / 9 / 3 / 5.
Combined across 68 questions the chapter now runs answer letters 26 / 25 / 25 / 24, difficulty
26 / 41 / 32 against a 27 / 40 / 33 target, Roman numeral 13 percent, and data-driven items 19 percent.
Skill 1, which batch 1 lacked entirely, is now 13 percent.

**Quota arithmetic is machine-checked.** Per-slice targets are summed and compared against the batch
target before the workflow launches. On this batch the check caught an allocation error of my own: one
slice had been assigned a B answer where the plan called for D, which would have shipped the chapter at
B 7 and D 4 instead of 6 and 5. Hand-allocating quotas across seven slices is exactly the kind of
arithmetic that should not be trusted to inspection.

**Boundary note on antibody structure.** The AAMC outline lists "structure of the antibody molecule"
under Biology, but antibody domain architecture (Fab, Fc, hypervariable and constant domains) is
already owned by Biochem Ch3, as are opsonisation and agglutination. This batch therefore tests
antigen-antibody RECOGNITION and its consequences: which targets each adaptive lineage can reach,
selection versus instruction, epitope-level binding, cross-reactivity, and the difference between
binding strength and binding specificity. Drafters were told explicitly not to write Fab, Fc,
hypervariable or constant domain, and the scan confirms none appear.

**One scope scan hit, investigated and cleared.** B3-Q9 matched the forbidden term "complement", but
the match was on the word "complementary" used in its ordinary sense, describing two surfaces that fit
each other. That is correct usage and unrelated to the complement protein system, which remains absent
from the chapter. The scanner pattern was tightened to a word-boundary match rather than the question
being changed.

**Scope convention verified by automated scan:** zero occurrences of CD4, CD8, helper T, cytotoxic T,
regulatory T, suppressor T, dendritic, natural killer, NK cell, complement, interferon, plasma cell,
memory cell, any immunoglobulin isotype, immunoglobulin, opsonisation, agglutination, T-cell receptor,
TCR, class I, class II, MHC-I, MHC-II, positive selection, negative selection, cytokine, interleukin,
costimulation, perforin, granzyme. The persisting population that underlies memory is described
functionally throughout rather than named.

**Chapter boundaries:** zero hits across the seven forbidden territories. No subtopic is duplicated
within batch 3 or against batches 1 and 2, and no key is a near-duplicate of an earlier key.

**Adversarial audit:** all 22 re-examined by an independent pass per slice that re-greped every
citation against OpenStax Anatomy and Physiology 2e and OpenStax Microbiology.

---

## B2-Q1 . Defence Against an Extracellular Bacterial Product

**Stem.** A vaccine is being developed against a bacterial product that is released by the organism, causes its damage entirely in the fluid between cells, and never enters the cells it injures. Protection against this product depends most directly on which property of the adaptive response?

- **A.** Cutting the material into pieces small enough to sit in a surface carrier on a host cell
- **B.** Killing host cells that harbour the material inside them
- **C.** Producing a soluble binder that grips the molecule in its native folded shape and blocks its contact with target cells  <- **KEY**
- **D.** Raising the number of cells that display pieces of the material on their outer surface

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (C): Producing a soluble binder that grips the molecule in its native folded shape and blocks its contact with target cells**

Citations: MICRO:32718; MICRO:32870; MICRO:33397; AP:43283

**Distractors**

- **(A)** `process_step_confusion` . _recognition route of the other adaptive lineage offered as the protective mechanism_: Holding fragments in a surface carrier is a real recognition route, but it is used by the other adaptive lineage and yields surface-inspecting cells, not a soluble molecule that can bind a free product in the fluid.
  - Citation: MICRO:33397
- **(B)** `misconception` . _treating cell killing as a defence against free molecules_: Destroying host cells addresses material sequestered inside cells; the stem states this product never enters the cells it injures, so cell killing removes nothing from the fluid.
  - Citation: AP:43283
- **(D)** `adjacent_fact` . _true event during a response, irrelevant to interception_: More fragment display does recruit lymphocytes, but display never physically blocks the free molecule from reaching its target cell.
  - Citation: MICRO:32870

**Readback check.** Content words of six or more letters in the key: Producing, soluble, binder, molecule, native, folded, blocks, contact, target. Stem words of six or more letters: vaccine, developed, against, bacterial, product, released, organism, causes, damage, entirely, between, enters, injures, Protection, depends, directly, property, adaptive, response. No overlap, so no stem echo. The key cannot be reached by matching vocabulary; the student must know that the lineage reading native structure is the one whose product circulates as a free binder.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests antigen-antibody recognition applied to a target that acts only outside cells. The answer is C because the adaptive lineage that reads a structure in the folded conformation it already carries can later release large amounts of a soluble version of that same gripping surface into the very compartment where the product does its damage, and a product that has been coated cannot dock onto the cell it was built to attack. Blocking the docking step is sufficient on its own, since a bacterial product that never contacts its target cell causes no injury even though it remains chemically intact. This is precisely why immunisation against secreted bacterial products works: the protective element ends up as a soluble binder circulating in the same fluid as its target, rather than a cell that must hunt something down. Recognition of the free, folded species is therefore the property on which protection rests.
>
> (Choice A) Fragmenting material into pieces small enough to occupy a surface carrier is a genuine recognition route, but it is the route used by the other adaptive lineage, and it yields cells that inspect surfaces rather than a soluble molecule able to meet a free product dissolved in the fluid. It therefore cannot be what protection against this target depends on.
>
> (Choice B) Killing host cells is a defence against material sequestered inside cells. The stem specifies that this product never enters the cells it injures, so destroying host tissue would add damage without removing the harmful species from the fluid around those cells.
>
> (Choice D) Increasing how many cells put pieces of the material on show does occur during a real response and does recruit more lymphocytes, but display by itself intercepts nothing in the fluid. The harmful species reaches its target cell just as quickly whether or not fragments of it are on view elsewhere.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which arm of the adaptive response acts on material in its native, free state and to apply that fact to a purely extracellular target.

---

## B2-Q2 . Targets a Naive B Receptor Can Reach

**Stem.** Resting B lymphocytes from a donor who has met none of these organisms are distributed into wells. Each well receives one item from the list below, and no cell of any other type is added to any well. Engagement of the surface binding units on the B lymphocytes is then measured.

I. A folded toxin dissolved in the medium
II. The sugar coat on the outside of a whole, undamaged bacterium
III. Cells infected with a virus whose protein is never exposed on the cell surface and never leaves the cell

Engagement is expected with which item or items?

- **A.** I and II only  <- **KEY**
- **B.** I only
- **C.** II only
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): I and II only**

Citations: MICRO:33395; MICRO:33397; MICRO:33399; AP:43283

**Distractors**

- **(B)** `partial_truth` . _correct on the dissolved case, wrongly excludes the intact surface_: Item I is indeed engaged, but the reasoning wrongly assumes a structure attached to a whole organism must be processed first; an outward facing coat is directly accessible.
  - Citation: MICRO:33397
- **(C)** `misconception` . _belief that a particle or cell surface is required_: This holds that the binding unit needs something solid to press against, but free, dissolved material of the right shape is engaged directly.
  - Citation: AP:43283
- **(D)** `process_step_confusion` . _internal protein treated as if it were surface accessible_: A protein that is never exposed on the infected cell and never leaves it offers no surface for a binding unit to contact; it can only reach a lymphocyte as fragments held out on a carrier, which serves the other adaptive lineage.
  - Citation: MICRO:33397

**Readback check.** The key is 'I and II only' and contains no content words at all, so a stem echo is impossible. The student must evaluate each Roman item against the accessibility rule; no phrase in the stem states which items qualify, and the stem deliberately gives the chemical class of item II as a sugar so that a student who wrongly believes only proteins are read will exclude it.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests antigen-antibody recognition, specifically the range of targets a resting B lymphocyte can engage on its own. The answer is A because items I and II both leave their binding surface facing the medium, while item III keeps its binding surface locked inside a cell where no surface unit on a lymphocyte can reach it. A dissolved toxin is already in the conformation it will hold when it meets its target, so the shape a B lymphocyte must read is present the moment the toxin is added to the well. The sugar coat of an undamaged bacterium is likewise on the outside and bathed by the medium, and this lineage reads a coat built of sugars as readily as it reads a protein surface, because the fit of the binding site to a three dimensional shape, not the chemical class of the material, is what governs engagement. Item III fails for a structural reason rather than a chemical one: a protein that never appears on the outside of the infected cell and never leaves it presents no exposed surface for a binding unit to contact, and the only route by which such a protein reaches a lymphocyte at all is as short pieces held out on a carrier, which serves the other adaptive lineage rather than the units being measured here.
>
> (Choice B) Restricting engagement to I treats dissolved material as the only accessible form and assumes that a structure attached to a living organism must first be stripped off and handled. Nothing about being anchored to a bacterium hides an outward facing coat from the medium around it.
>
> (Choice C) Restricting engagement to II makes the opposite assumption, that the binding unit needs a particle or cell surface to press against. A free molecule of the right shape engages perfectly well, which is exactly why a soluble product of this response can later act on free targets in the blood.
>
> (Choice D) Including III ignores where the viral protein actually sits. It is never on the outside of the infected cell and never enters the medium, so nothing about it is available for a surface binding unit to contact.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to take one recognition rule and apply it across three physically different presentations of a target to decide which are reachable.

---

## B2-Q3 . Why Surface and Output Specificity Must Match

**Stem.** An engineered mouse line carries a defect in which the gene segments that build a lymphocyte's gripping site are shuffled a second time after that cell has been picked out by a bacterium and has begun to divide. Each descendant therefore puts out soluble units whose gripping surface is set at random. The number of soluble units made per descendant, and the number of descendants produced, are both normal. Compared with a wild type mouse, what happens to the response against that bacterium?

- **A.** Binding of the bacterium is unaffected, because the cell was already picked out correctly before it began to divide
- **B.** Binding of the bacterium improves, because the descendants now cover a wider range of shapes between them
- **C.** The first exposure proceeds normally and the loss shows up only on a later exposure to the same bacterium
- **D.** The share of released units able to grip the invader falls to roughly the chance frequency of any single binding shape  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a): combines clonal selection with the specificity of the released binding units, two separate outline concepts. Meets (b): requires a directional and quantitative inference that total output holds constant while the useful fraction falls to chance frequency. Meets (c): choices A and B both stay defensible until the student applies the specific fact that selection operated only on the parent's surface unit. |

**Correct answer (D): The share of released units able to grip the invader falls to roughly the chance frequency of any single binding shape**

Citations: AP:43385; AP:43387; MICRO:33386; MICRO:33393; MICRO:33436

**Distractors**

- **(A)** `misconception` . _selection alone treated as sufficient_: Choosing the right parent cell does not transfer the chosen shape to anything the offspring later release; the transfer step is precisely what the lesion removes.
  - Citation: AP:43387
- **(B)** `reversed_relationship` . _diversity read as gain rather than dilution_: Spreading a fixed output across many shapes lowers, not raises, the quantity directed at the single shape that fits the organism.
  - Citation: AP:43385
- **(C)** `process_step_confusion` . _defect assigned to the wrong encounter_: The reshuffling happens as soon as the chosen cell divides, so the very first wave of released material is already mismatched.
  - Citation: MICRO:33436

**Readback check.** Content words of six or more letters in the key: released, invader, roughly, chance, frequency, single, binding. Stem words of six or more letters: engineered, carries, defect, segments, lymphocyte, gripping, shuffled, second, picked, bacterium, begun, divide, descendant, therefore, soluble, surface, random, number, descendants, produced, normal, Compared, happens, response, against. No overlap. The key deliberately avoids restating the stem's given that per-cell output is normal, so it cannot be selected by matching that clause, and it says invader where the stem says bacterium.

**Explanation (as shipped).**

> This question belongs to Organ Systems and tests clonal selection together with the specificity of what a selected lymphocyte's offspring release. The answer is D because selection acts on the surface gripping unit of the parent cell, and the benefit of that selection survives only if the offspring carry the same gripping surface forward when they switch to pouring material into the fluid. The described defect leaves every quantitative feature of the response intact: the correct parent is chosen, it divides the usual number of times, and each offspring releases the usual quantity of soluble material. What is destroyed is the link between the choice and the product. Shuffling the gripping surface again after the parent has been chosen means the soluble output samples the entire repertoire once more, so the proportion of it that fits the organism falls back to the frequency of any one shape among all possible shapes, which is vanishingly small. The broader lesson is that matching between the surface unit and the released unit is not a redundancy but the mechanism that converts one correct recognition event into a large quantity of useful product.
>
> (Choice A) This treats correct selection of the parent as sufficient on its own. Selection identifies which cell to amplify; it does not stamp the chosen shape onto anything the offspring later manufacture, and the stamping step is exactly what this mouse line has lost.
>
> (Choice B) Wider shape coverage sounds like a gain but is a loss in this setting. Spreading a fixed total output across millions of different shapes lowers the quantity aimed at the one shape that matters, so broadening the range moves the useful concentration in the wrong direction.
>
> (Choice C) Placing the deficit on a later exposure misassigns the stage at which the defect operates. The reshuffling occurs as soon as the chosen cell divides, so the very first wave of released material is already off target, and a repeat encounter would fail in the same way for the same reason.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to predict, from a described genetic lesion, how the quality of a response changes while every quantitative feature of it stays fixed.

---

## B2-Q4 . Reading a Native Versus Fragment Binding Table

**Stem.** Surface binding units were purified from two lymphocyte lineages, P and Q, taken from a donor immune to one bacterium. Each preparation below was offered to both, and binding was recorded in arbitrary units, with values under 15 counted as background.

| Material offered | Lineage P (AU) | Lineage Q (AU) |
| --- | --- | --- |
| Whole folded toxin, free in the fluid | 480 | 4 |
| Short cut pieces of that toxin, free in the fluid | 12 | 6 |
| Short cut pieces held out by a carrier on a cell surface | 9 | 455 |
| Sugar coat of the whole bacterium | 390 | 3 |

The bacterium is then altered by genetic engineering so that it makes no sugar coat. The altered organism, together with the toxin it still produces, is placed in a fluid containing the purified binding units from both lineages and no host cells of any kind. Which outcome does the table support?

- **A.** Neither set of units engages anything in the fluid, because the only structure available in its natural state has been removed
- **B.** The lineage P units engage the toxin, since they grip a molecule in its native three dimensional state with no third cell needed  <- **KEY**
- **C.** The lineage Q units engage the toxin, because their score against loose cut pieces of it shows a real, if weak, interaction
- **D.** The lineage P units engage the toxin only once its cut pieces are held out on a carrier

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 110 s |
| Confidence | 5 |

**Correct answer (B): The lineage P units engage the toxin, since they grip a molecule in its native three dimensional state with no third cell needed**

Citations: MICRO:33395; MICRO:33397; MICRO:33399; AP:43283

**Distractors**

- **(A)** `misconception` . _assumes only one accessible native structure existed_: The first table row shows a second structure available in whole conformation, the toxin, which the altered organism still releases and which lineage P binds at 480.
  - Citation: MICRO:33397
- **(C)** `scale_unit_error` . _background level read as a real signal_: The 6 arbitrary units for lineage Q against loose pieces falls under the stated background threshold of 15, so it reports no binding at all.
  - Citation: MICRO:33395
- **(D)** `process_step_confusion` . _fragmentation and display step inserted into the wrong lineage_: Lineage P scores only 9 against carrier held pieces, below the background threshold, showing that route is unused, while its 480 against the whole toxin shows the direct route suffices.
  - Citation: AP:43283

**Readback check.** Content words of six or more letters in the key: lineage, engage, molecule, native, dimensional, needed. Of these only lineage appears in the stem, and it appears purely as a neutral column label that is also used in choices A, C, and D, so it carries no answer information. The discriminating words engage, molecule, native, dimensional and needed are absent from the stem. The key cannot be read off any single table cell because it concerns a condition not shown in the table, and every choice is refuted or supported only by comparing a table value against the stated threshold.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests antigen-antibody recognition read from measured binding data. The answer is B because the lineage P units score far above background against material offered in its whole, natural conformation, 480 for the dissolved toxin and 390 for the coat sugar, and they need no accessory cell present to do so. The lineage Q units show the mirror image profile: 4 and 3 against whole structures, 6 against loose cut pieces, and 455 only when those pieces are held out by a carrier on a cell. That pattern identifies the presence of a carrier bearing cell, rather than the chemical nature of the material, as the requirement for lineage Q. In the described fluid there is no cell at all to hold pieces out, so lineage Q has no condition it can score above background on. Removing the sugar coat costs lineage P one of its two targets but leaves the other intact, because the toxin is still manufactured and is still whole and free in the fluid.
>
> (Choice A) This assumes the coat was the only structure available in natural conformation. The first row of the table shows a second such structure, the whole toxin, and the altered organism still releases it into the fluid, where it scores 480.
>
> (Choice C) This reads 6 arbitrary units as genuine binding. The threshold given is 15, so the value for lineage Q against loose cut pieces reports no interaction at all, and treating it as a real signal is an error of magnitude rather than of mechanism.
>
> (Choice D) This inserts a fragmentation and display step that lineage P does not use. The value of 9 recorded for lineage P against carrier held pieces sits below background, showing that route contributes nothing for this lineage, while the value of 480 shows the direct route already works.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to compare four measured conditions against a stated background threshold and extend the resulting pattern to a new experimental condition not shown in the table.

---

## B2-Q5 . Origin of B Lineage Binding Diversity

**Stem.** A volunteer receives an injection of a laboratory compound that has never existed in nature and that no organism has ever synthesised. Two weeks later the volunteer's serum holds an antibody that recognises that compound and nothing else. Which feature of B lymphocytes makes this result possible?

- **A.** Each cell finishes maturation carrying a single randomly assembled binding specificity, so the collection of such cells spans millions of distinct shapes before any encounter.  <- **KEY**
- **B.** A single B cell displays roughly one hundred thousand surface receptors, and those receptors differ from one another in shape.
- **C.** Phagocytes ingest unfamiliar material and display fragments of it on their surface for inspection.
- **D.** New receptor specificities are generated in bone marrow only once an unfamiliar target has been detected.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (A): Each cell finishes maturation carrying a single randomly assembled binding specificity, so the collection of such cells spans millions of distinct shapes before any encounter.**

Citations: MICRO:33388, MICRO:33389, MICRO:33392, MICRO:33393, MICRO:33353, MICRO:33356, AP:43287, AP:43288

**Distractors**

- **(B)** `scale_unit_error` . _variation placed inside one cell instead of across the cell population_: Correct that a B cell bears about a hundred thousand receptors, but all of them share one specificity. The diversity resides across the population of cells, not within an individual cell, so the reasoning is applied at the wrong level of organisation.
  - Citation: MICRO:33385, MICRO:33386
- **(C)** `adjacent_fact` . _true statement about a neighbouring process that does not answer the question asked_: True of phagocytes and antigen presentation, but it addresses how a target is shown to lymphocytes rather than why a lymphocyte already carries a site that fits a molecule no organism has ever made.
  - Citation: AP:42995, AP:42996
- **(D)** `reversed_relationship` . _repertoire built on demand rather than in advance_: Puts generation of specificities after detection of the target. The rearrangement that creates binding sites occurs during development, before any contact, which is the only arrangement that can explain a response to a synthetic compound.
  - Citation: AP:43287, AP:43288, MICRO:33388

**Readback check.** Content words of six or more letters in key A: finishes, maturation, carrying, single, randomly, assembled, binding, specificity, collection, millions, distinct, shapes, before, encounter. Stem contains: volunteer, receives, injection, laboratory, compound, existed, nature, organism, synthesised, later, serum, antibody, recognises, nothing, feature, lymphocytes, result, possible. No six-letter-or-longer word is shared between key and stem, and the key cannot be produced by restating any stem sentence: the stem reports only an outcome, the key supplies the mechanism.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests clonal selection at its starting point: where the library of binding specificities in the B lymphocyte lineage comes from. The answer is A because every B cell completes its development in bone marrow with one randomly assembled recognition site, and the sum of all such cells therefore covers an enormous range of shapes before the immune system has met anything at all. The gene segments coding for the variable part of the receptor exist in many alternative versions, and each developing cell joins one combination of them at random. Because the joining is random rather than directed, the resulting library is not built to match any particular target: it simply covers a vast sample of possible shapes. A molecule that has never existed can still find a partner in that library, precisely because the library was never tailored to the natural world in the first place. Each individual specificity is consequently rare, which is why a first response needs time for the matching cells to be found and multiplied.
>
> (Choice B) A single B cell does display on the order of a hundred thousand surface receptors, but every one of them carries the same specificity. Diversity in this system lives across the whole set of cells, not within one cell, so this choice places the variation at the wrong level of organisation.
>
> (Choice C) Ingestion of foreign material and display of its fragments is a real and important step, but it explains how a target is shown to lymphocytes, not why a lymphocyte with a fitting site exists in the first place.
>
> (Choice D) This reverses the order of events. The set of specificities is generated in advance of any contact, which is exactly what allows a response to a compound no organism has ever produced. Marrow does not custom order specificities on demand, and a system that waited for a target before building a binder would have no way to build the right one.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to identify the defining property of the B lymphocyte repertoire, a randomly generated set of specificities fixed during development, that makes a response to a never before existing target possible.

---

## B2-Q6 . Selection Versus Instruction by Antigen

**Stem.** A volunteer is given an unfamiliar compound for the first time. Blood drawn one week beforehand already contained about three thousand cells per litre whose membrane protein grips that compound. The antibody recovered from serum two weeks afterwards has the same amino acid sequence as that membrane protein, and the count of gripping cells has risen roughly two hundred fold. What does this pattern indicate about the role of the compound?

- **A.** It is broken into fragments inside a cell first, and those fragments are then built into the recognition site of that same cell.
- **B.** It acts as a filter rather than a mould: it selects the few cells carrying a matching site fixed at maturation and drives them to divide.  <- **KEY**
- **C.** It serves as a template around which a flexible binding region folds, which is why the recovered protein fits it so exactly.
- **D.** Cells with the matching site are generated in response to its arrival, and their surface protein is later copied into a soluble form.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | Meets (a) it requires combining two separate concepts, the pre-exposure presence of the specificity and the sequence identity of surface and secreted binder. Meets (c) choices C and D are both defensible until the sequence identity between the secreted antibody and a protein already present a week earlier is applied. Meets (d) it inverts the usual direction, supplying an outcome and asking the student to infer the mechanism of antigen action that produced it. |

**Correct answer (B): It acts as a filter rather than a mould: it selects the few cells carrying a matching site fixed at maturation and drives them to divide.**

Citations: AP:43384, AP:43385, AP:43386, AP:43387, MICRO:33434, MICRO:33435, MICRO:33436

**Distractors**

- **(A)** `process_step_confusion` . _real pathway with processing and display stages interchanged_: Ingestion and fragmentation are real steps, but fragments end up displayed on the cell surface, not incorporated into the recognition site. Two stages of a genuine process are swapped, and no such route could yield a binder whose sequence predates the compound.
  - Citation: AP:42995, AP:42996
- **(C)** `misconception` . _antigen as instructive mould for the binding site_: This is the discredited template view. A site moulded on the compound would be settled only after exposure, yet the recovered antibody has the same sequence as a protein cells were already carrying a week before the compound was given.
  - Citation: AP:43386, AP:43387
- **(D)** `reversed_relationship` . _matching cells created by the antigen rather than found by it_: Reverses the order of cause and effect. The fitting cells were counted before exposure, so their generation cannot be a response to the compound, even though the second clause about a soluble copy of the surface protein is accurate.
  - Citation: AP:43385, AP:43287

**Readback check.** Content words of six or more letters in key B: filter, rather, selects, carrying, matching, maturation, drives, divide. Stem contains: volunteer, unfamiliar, compound, beforehand, already, contained, thousand, litre, membrane, protein, grips, antibody, recovered, serum, afterwards, amino, sequence, gripping, risen, roughly, hundred, pattern, indicate. No six-letter-or-longer word is shared. The stem never uses the words selection, filter, or divide, and the key is a mechanism inferred from two separate observations rather than a restatement of either.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests the distinction between selection and instruction, which is the conceptual core of clonal selection in the B lineage. The answer is B because the fitting cells were countable in blood a week before anything was given, and the secreted binder turned out to carry the same sequence as the surface protein those cells were already displaying, so the arriving material sorted and amplified a set that was fixed in advance instead of shaping a binder to order. Two observations must be combined to reach this. First, the specificity existed beforehand, so it cannot have been created by the meeting. Second, the secreted product reproduces, residue for residue, the site those cells were displaying at the outset, so the meeting did not even modify the site: it left the site exactly as it was and caused the cells bearing it to proliferate, which is what the two hundred fold rise in their number records. The reasoning runs backwards from an outcome, and only a filtering mechanism fits that outcome. Because each specificity begins rare, the size of the eventual response depends largely on how far the chosen minority can expand.
>
> (Choice A) Uptake and breakdown of foreign material genuinely happens and matters for how lymphocytes are engaged, but the resulting fragments are displayed on the cell surface, not stitched into the recognition site. This choice keeps a real process and swaps two of its stages, and it also cannot produce a binder whose sequence was already fixed before the compound arrived.
>
> (Choice C) This is the template idea that students most commonly hold, and it is the exact hypothesis these observations exclude. A binding region moulded around the compound would have a shape settled only after exposure, yet the recovered protein matches, residue for residue, one that cells were already carrying a week earlier. Until that identity of sequence is applied, this choice looks as defensible as the key.
>
> (Choice D) The second half is right, since the soluble product does reproduce the surface specificity. The first half runs the causal arrow the wrong way: the fitting cells were present a week early, so they were found rather than made.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to reason from an observed outcome, sequence identity between a pre-existing surface protein and a later secreted antibody, back to the only mechanism of antigen action consistent with it.

---

## B2-Q7 . Reading Expansion of a Rare Clone

**Stem.** A rabbit is injected once with target P and never with target Q. On three days, blood is stained with labelled P and labelled Q so that cells whose surface protein grips each one can be counted, and the total lymphocyte concentration is recorded at the same time. The animal goes on to make a strong antibody response to P and none to Q.

| Day | Total lymphocytes (per microlitre) | Cells gripping P (per microlitre) | Cells gripping Q (per microlitre) |
| --- | --- | --- | --- |
| 0 | 2000 | 16 | 12 |
| 4 | 2139 | 155 | 12 |
| 8 | 2409 | 425 | 12 |

Which conclusion do these counts support?

- **A.** Cells that grip P proliferated, and part of the increase came from cells that formerly gripped nothing being switched over.
- **B.** Exposure to P taught cells that formerly gripped nothing to build a P-shaped site, which is why their number climbed.
- **C.** Cells reactive to P were present at low frequency from the outset and then multiplied, since cells reactive to neither one remained at a constant number.  <- **KEY**
- **D.** Each cell that grips P raised the quantity of P-gripping proteins on its own membrane, which is what the rising values register.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 105 s |
| Confidence | 5 |

**Correct answer (C): Cells reactive to P were present at low frequency from the outset and then multiplied, since cells reactive to neither one remained at a constant number.**

Citations: AP:43138, AP:43141, AP:43142, AP:43145, AP:43385, AP:43386, MICRO:33434

**Distractors**

- **(A)** `partial_truth` . _right mechanism plus an extra mechanism the data rule out_: Proliferation of P gripping cells is correct, but the added claim of conversion is excluded by the arithmetic: the count of cells gripping neither label holds at 1972 on every day, so no cell left that pool.
  - Citation: AP:43145, AP:43386
- **(B)** `misconception` . _antigen teaches cells a new specificity_: Treats the antigen as instructing cells to build a new site. If that occurred, the unlabelled pool would shrink by the amount the P column grew, yet that pool never changes across the three sampling days.
  - Citation: MICRO:33388, AP:43287
- **(D)** `scale_unit_error` . _per-cell receptor number substituted for cell count_: Applies the reasoning to receptor density on individual cells rather than to cell number. The assay counts cells and the total lymphocyte concentration rises by the same 409 per microlitre, which added proteins on unchanged cells could not produce.
  - Citation: MICRO:33385, MICRO:33386

**Readback check.** Content words of six or more letters in key C: reactive, present, frequency, outset, multiplied, neither, remained, constant, number. Stem contains: rabbit, injected, target, stained, labelled, surface, protein, gripping, counted, lymphocytes, concentration, recorded, animal, strong, antibody, response, microlitre, conclusion, support, counts. No six-letter-or-longer word is shared. The key is also not a value read off the table: the discriminating quantity, 1972 cells gripping neither label, must be computed by subtraction and then compared across days.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests clonal selection as it appears in cell counts: expansion of a rare pre-existing specificity rather than conversion of cells that had a different one. The answer is C because the quantity of lymphocytes gripping neither label works out to 1972 per microlitre on all three days, so nothing was drawn out of that pool, while the P column climbs from 16 to 425 and the total climbs by the identical amount. Subtracting the two stained columns from the total gives 2000 minus 28, 2139 minus 167, and 2409 minus 437, each of which equals 1972. That constant remainder is the decisive figure. Had unlabelled cells been retooled into P recognisers, the remainder would have fallen by the amount the P column rose. Instead the P column gains 409 and the total gains 409, which is what division of an already existing group looks like: new cells are added to the pool rather than moved within it. The Q column, flat at 12, confirms that the change is confined to one specificity and is not a general lymphocyte increase.
>
> (Choice A) The first clause is right, since cells gripping P clearly divided. The second clause fails the arithmetic, because any switching over of unlabelled cells would have drawn cells out of the remainder, and the remainder holds at 1972 on every sampling day.
>
> (Choice B) This treats the injected material as an instructor rather than as a filter. It also fails numerically for the same reason as choice A: a cell taught to grip P is a cell subtracted from the unlabelled pool, yet that pool is unchanged across all three days.
>
> (Choice D) The assay counts cells, not signal intensity per cell, and the total lymphocyte concentration rises in step with the P column. More proteins on the same cells would leave both the cell counts and the total untouched, so this explanation is pitched at the wrong level of organisation.
>
> This is a Data-based and Statistical Reasoning question because it requires the student to derive a quantity not printed in the table, the number of cells gripping neither label, and to use its constancy across all three days to choose between expansion of a rare group and conversion of other cells.

---

## B2-Q8 . Epitope Size and Response Diversity

**Stem.** The binding pocket of an antibody accommodates roughly six amino acid residues at a time. A pathogenic bacterium secretes a toxin that folds into a compact globule of 480 residues. What follows for the set of antibodies a patient raises against this toxin?

- **A.** Several distinct specificities arise, each attaching to a different exposed patch of the same molecule.  <- **KEY**
- **B.** A single specificity arises, because the folded toxin behaves as one indivisible target.
- **C.** The toxin must be trimmed into six residue pieces before any antibody can attach to it.
- **D.** The toxin falls below the size threshold for recognition and must be coupled to a carrier first.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (A): Several distinct specificities arise, each attaching to a different exposed patch of the same molecule.**

Citations: MICRO:32578-32579 (antibodies do not engage an entire antigen but smaller exposed surface regions, and one antigen may carry several such regions bound by different antibodies); MICRO:32585-32586 (antigen size is an important factor, and some molecules are too small to stimulate a response on their own); MICRO:32588 (such a small molecule must first attach to a larger carrier molecule to become antigenic); AP:42975-42976 (these regions are limited by the size of the receptor itself and usually consist of six or fewer amino acid residues)

**Distractors**

- **(B)** `misconception` . _one antigen equals one antibody_: Folding does not convert a large protein into a single recognition unit. The combining site still contacts only a few amino acids, so many separate surface areas remain available and many clones are selected.
  - Citation: MICRO:32578-32579
- **(C)** `process_step_confusion` . _processing step imported into antibody binding_: Cutting a protein into short pieces belongs to the pathway that loads fragments onto surface display molecules for T lymphocytes, not to antibody binding. Antibodies attach to intact folded surfaces without prior processing.
  - Citation: MICRO:32877
- **(D)** `adjacent_fact` . _small molecule carrier rule misapplied_: The carrier requirement is a true statement about molecules too small to stimulate a response alone. A 480 residue toxin is well above that size, so the statement is irrelevant to what was asked.
  - Citation: MICRO:32588

**Readback check.** Key words of six or more letters: Several, distinct, specificities, attaching, different, exposed, molecule. Stem and lead-in words of six or more letters: binding, pocket, antibody, accommodates, roughly, residues, pathogenic, bacterium, secretes, compact, globule, follows, antibodies, patient, raises, against. No overlap, so no distinctive content word is shared between stem and key. The key is not stated in the stem: the student must convert a size ratio between pocket and protein into a prediction about the number of independent specificities produced.

**Explanation (as shipped).**

> This Organ Systems item tests antigen-antibody recognition, specifically why the unit an antibody actually engages is far smaller than the antigen that carries it. The answer is A because a folded 480 residue toxin exposes many separate six residue areas on its surface, and each of those areas can select a different B lineage clone, so the response is a mixture of specificities rather than one. An antibody combining site is a shallow pocket, and only a handful of amino acids from the target can occupy it at once. The consequence is close to arithmetic: a large protein presents many separate areas that are chemically unlike one another, and clonal selection operates on each of them independently, since a clone is chosen by whether its receptor fits that one area. Antibodies of several specificities therefore attach to different parts of the same toxin at the same time, which is why serum raised against a single protein is a mixture and not a pure reagent. The same relationship explains why large antigens are generally stronger stimulants than small ones: a bigger structure supplies more independent handles for selection to act on.
>
> (Choice B) treats the folded protein as one recognition unit. Folding does not merge the surface into a single target, because the pocket still samples only a few amino acids at a time, so many independent clones are engaged by one protein.
>
> (Choice C) borrows a step from the pathway that cuts proteins into short pieces and loads them onto the surface display molecules read by T lymphocytes. Antibodies engage intact native surfaces directly, and no cutting is required before attachment occurs.
>
> (Choice D) describes a molecule too small to stimulate a response on its own, which must be joined to a larger carrier before it is seen. A 480 residue toxin sits far above that threshold and requires no carrier.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the fixed size of an antibody combining site to a large target and state what that implies about how many separate specificities one protein can raise.

---

## B2-Q9 . Shared Surface Patches and Test Specificity

**Stem.** A clinical assay scores a sample as reactive when a purified antibody raised against organism P attaches to material in the patient's serum. Organism Q, which is not related to P and is common in the same area, carries a surface patch whose shape and charge closely resemble one patch on P. What limitation does this place on the interpretation of a reactive sample?

- **A.** Attachment cannot occur unless the two organisms share a recent common ancestor.
- **B.** The assay reports the presence of a complementary patch rather than the species that supplied it.  <- **KEY**
- **C.** Reactive samples are trustworthy here, while non-reactive samples are the ones prone to error.
- **D.** The assay stays valid so long as the antibody was raised against P rather than against Q.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (B): The assay reports the presence of a complementary patch rather than the species that supplied it.**

Citations: MICRO:36278 (some antigens are chemically similar enough that antibodies raised against one bind a chemically similar but different antigen); MICRO:36351-36353 (false positives arise when surface regions from a different pathogen resemble those on the pathogen sought, so such tests are used as screening tests with confirmatory follow-up); MICRO:36276-36277 (specificity arises from unique amino acid patterns that bind only targets providing complementary charges and noncovalent bonds)

**Distractors**

- **(A)** `misconception` . _binding implies phylogenetic kinship_: Cross-binding does not require relatedness. A pocket responds to geometry and charge, so distant lineages that converge on a similar surface arrangement are bound with equal ease.
  - Citation: MICRO:36278
- **(C)** `reversed_relationship` . _positive and negative predictive value inverted_: The reliability runs the other way in this scenario. The look-alike patch makes a reactive result the ambiguous one, while a non-reactive result argues against a matching surface area being present.
  - Citation: MICRO:36351-36353
- **(D)** `partial_truth` . _reagent provenance mistaken for reagent selectivity_: It is true that the reagent was raised against P, and that explains its strong binding to P, but the reagent's origin does not prevent a similar surface area from occupying the same pocket.
  - Citation: MICRO:36276-36278

**Readback check.** Key words of six or more letters: reports, presence, complementary, rather, species, supplied. Stem and lead-in words of six or more letters: clinical, sample, reactive, purified, antibody, against, organism, attaches, material, patient's, serum, related, common, carries, surface, charge, closely, resemble, limitation, interpretation. No overlap. Note that patch and shape are five letters and therefore outside the check, and organism appears in the stem but deliberately not in the key. The key cannot be lifted from the stem: the stem states only that two surface areas resemble one another, and the student must infer the resulting ceiling on what a reactive reading proves.

**Explanation (as shipped).**

> This Organ Systems item tests the limits of binding specificity in antigen-antibody recognition and what those limits do to a test built on attachment alone. The answer is B because attachment is decided by the fit between a small pocket and a small surface area, so any molecule carrying a sufficiently close copy of that area will be captured, no matter which organism supplied it. The pocket contacts only a few residues and reads their geometry and charge, not their ancestry. Two lineages with no recent shared history can arrive at a surface area that satisfies the same pocket, and the assay cannot separate the two events, since in both cases the antibody is held and the readout rises. A rise therefore supports only the conclusion that a complementary surface area was present in the material tested. This is precisely why assays of this design are used as screens rather than as confirmations, and why a reactive sample is followed by a second test that keys on some independent property of the suspected agent, such as its nucleic acid.
>
> (Choice A) assumes that a shared surface shape must reflect shared descent. Unrelated lineages can converge on a similar arrangement of charge and geometry, and the antibody pocket has no access to ancestry, only to fit.
>
> (Choice C) runs the reliability argument backwards for the situation described. The look-alike patch on the second organism is a source of falsely reactive readings, so it is the reactive result that is made ambiguous here, while failure to attach argues against the presence of a matching surface area.
>
> (Choice D) is correct that the antibody was raised against P, which is why it binds P well, but the origin of a reagent does not restrict what can capture it. The reagent's history and its behaviour toward similar surfaces are separate facts.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to carry a property of molecular recognition forward into the interpretation of a clinical assay and to state exactly what a reactive reading can and cannot establish.

---

## B2-Q10 . Binding Strength Versus Discrimination

**Stem.** Two purified antibodies, R1 and R2, were each raised against target molecule X. Molecule Y comes from an unrelated organism and is chemically similar to X. The table gives the concentration of each antibody at which half of its sites are filled by the molecule listed.

| Antibody | Half occupancy with X | Half occupancy with Y |
| --- | --- | --- |
| R1 | 1 nM | 500 nM |
| R2 | 60 nM | 60 nM |

I. R1 separates X from Y more sharply than R2 does.
II. R2 holds X more tightly than R1 does.
III. R2 would give the same reading for a preparation of X as for an equal amount of Y.

Which of the statements are supported by the data?

- **A.** I only
- **B.** II only
- **C.** I and III only  <- **KEY**
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Meets three of the four gate conditions. (a) It combines two separate concepts, the strength of one interaction and the ability to distinguish two similar targets, and requires showing that they are independent. (b) It requires a directional quantitative inference across four values, namely that a higher concentration at half occupancy means a weaker hold, applied to both rows. (c) At least two distractors stay defensible until a specific discriminating fact is applied: statements II and III are each arguable until the direction of the half occupancy measure is settled, so options B and D remain live until that fact is used. |

**Correct answer (C): I and III only**

Citations: MICRO:36283-36284 (affinity is a measure of the binding strength between an antibody binding site and one surface region, and cross-binding is more likely where that strength is low); MICRO:36287-36288 (an antibody with high strength for its intended target is less likely to bind a target it holds less well); MICRO:36397-36398 (assays demanding better discrimination require antibodies that bind a single region with high strength)

**Distractors**

- **(A)** `partial_truth` . _stops at the first supported statement_: Statement I is genuinely supported, but the set is incomplete. The two identical R2 values force statement III as well, since equal half occupancy means an equal reading at equal amounts of either molecule.
  - Citation: MICRO:36283-36284
- **(B)** `reversed_relationship` . _concentration scale read in the wrong direction_: This treats the larger half occupancy value as the tighter hold. The value is a concentration that must be supplied to fill half the sites, so 60 nM is a weaker interaction than 1 nM and statement II is false.
  - Citation: MICRO:36283-36284
- **(D)** `misconception` . _strong binding assumed to mean selective binding_: Including statement II collapses strength of binding and power to distinguish into a single property. The R2 row shows a moderately firm hold that separates nothing, so the two properties vary independently.
  - Citation: MICRO:36287-36288

**Readback check.** The key text is I and III only and contains no content words at all. Statement I words of six or more letters: separates, sharply. Statement III words of six or more letters: reading, preparation, amount. Stem words of six or more letters: purified, antibodies, raised, against, target, molecule, unrelated, organism, chemically, similar, concentration, antibody, occupancy, filled, listed, supported. No overlap. This is not table readback, because neither supported statement is a value taken off the table: both require converting a concentration required for half occupancy into a directional claim about strength, and then converting the pair of R2 values into a claim about what the assay can distinguish.

**Explanation (as shipped).**

> This Organ Systems item pulls apart two properties of antigen-antibody recognition that students routinely merge: how tightly an antibody holds a target, and how well it tells two targets apart. The answer is C because statements I and III both follow from the four tabulated values, while statement II runs the half occupancy scale backwards. A lower concentration at half occupancy means the sites fill when less material is present, so a smaller number signals a stronger hold. R1 needs 1 nM for X but 500 nM for Y, a five hundred fold gap, so across a wide range of concentrations R1 is largely loaded on X while its loading on Y stays low, which is what discrimination looks like in practice. R2 needs 60 nM for either molecule, so no concentration exists at which it is loaded on one and not on the other, and its output cannot indicate which molecule was in the tube. Note that R2 is not weak in absolute terms, since 60 nM is a respectable hold; it is simply indiscriminate, and discrimination rather than raw strength is the property an assay depends on. Statement II asserts the reverse of what the table shows, because 60 nM is more material than 1 nM and therefore the looser grip.
>
> (Choice A) accepts statement I and stops there. Statement III is an equally direct consequence of the two identical values in the R2 row, since equal half occupancy for both molecules means equal fractional loading, and so equal signal, at equal amounts.
>
> (Choice B) reads the larger number as the firmer grip. Half occupancy is a concentration that must be supplied, so a larger value means a weaker interaction, which makes statement II false and statement I true.
>
> (Choice D) folds statement II in with the two supported claims, which amounts to treating strength of binding and power to distinguish as one property. The R2 row shows they are independent, because a moderately firm hold can still fail entirely to separate two molecules.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to convert four half occupancy values into separate claims about binding strength and about discrimination and to reject the claim that runs the concentration scale backwards.

---

## B2-Q11 . Commitment of a Selected B Lymphocyte to Export

**Stem.** A single lymphocyte in a lymph node binds one antigen and divides repeatedly. Several days later some daughters have lost the antigen-binding receptor from their outer membrane, their cytoplasm is packed with ribosome-studded internal membrane, and serum levels of a soluble antigen-binding protein rise steeply. What is the most likely relationship between that soluble protein and the receptor those daughters lost?

- **A.** It carries a freshly generated combining site, since the switch to export requires the cell to run a new round of gene rearrangement.
- **B.** It is assembled outside the cell from subunits shed by the daughters, so its combining site takes shape only after release into the fluid.
- **C.** It carries a combining site identical to the one the cells used before commitment, since both arise from the same rearranged genes in one expanded clone.  <- **KEY**
- **D.** It carries combining sites drawn from the whole repertoire of the node, since many different clones begin exporting at once.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural two_step) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): It carries a combining site identical to the one the cells used before commitment, since both arise from the same rearranged genes in one expanded clone.**

Citations: AP:42328; AP:43277; AP:43386; MICRO:33393; MICRO:33436

**Distractors**

- **(A)** `misconception` . _specificity is remade at activation_: The rearrangement that creates the binding site occurs during maturation, before antigen exposure; commitment to export does not run a fresh rearrangement, and a new site would break the match with the selecting antigen.
  - Citation: MICRO:33388; MICRO:33393; AP:43277
- **(B)** `process_step_confusion` . _synthesis and secretion steps swapped_: Assembly and folding of the combining site occur during synthesis inside the cell, not after release from shed fragments; the choice places an early step after a late one.
  - Citation: AP:42328; AP:43273
- **(D)** `misconception` . _population repertoire substituted for one clone_: Misreads clonal selection: one selected cell yields descendants of a single specificity, so the exported protein cannot carry the assorted sites of the node's other, unselected lineages.
  - Citation: AP:43385; AP:43386

**Readback check.** Content words of six or more letters in key C: carries, combining, identical, before, commitment, rearranged, expanded, clone. None of these appears in the stem, whose long words of six or more letters are lymphocyte, antigen, divides, repeatedly, daughters, receptor, membrane, cytoplasm, ribosome-studded, internal, levels, soluble, protein, steeply, likely, relationship. The key cannot be produced by restating any stem phrase; the student must supply the fact that one rearrangement precedes selection and is inherited unchanged. No choice repeats a stem noun phrase, and the key is not the longest option.

**Explanation (as shipped).**

> This Organ Systems item tests clonal selection and what changes when a chosen B lymphocyte commits to full time export of its binding protein. The answer is C because the exported protein and the outer-membrane receptor of the parent cell are two finished forms of a single gene product, so their combining sites are the same. Each maturing B lymphocyte rearranges its binding genes once, and every descendant of that cell inherits that one rearranged version. Antigen picks out the rare cell whose site already fits, and the descendants whose cytoplasm fills with ribosome-studded internal membrane have not altered the site at all: they have changed only how the product is finished, releasing it into fluid rather than fixing it in the membrane. That is why serum activity against the triggering antigen climbs at the same moment the surface form disappears from those daughters, and why the exported material remains as narrowly targeted as the receptor that started the response. The expanded internal membrane is the machinery for high rate export, not a device for making anything new.
>
> (Choice A) The rearrangement that builds the binding site occurs during maturation, before the cell ever meets antigen, and the shift to export does not run it again. If a new site were generated at this stage, the cell selected by the antigen would stop matching the antigen that selected it, which would defeat the entire logic of picking one cell out of the starting population.
>
> (Choice B) The binding site is folded inside the cell as the protein is built and is complete before the protein leaves; nothing is stitched together in the surrounding fluid from cast off pieces. This choice puts a step that occurs during synthesis after the step of release.
>
> (Choice D) One triggered cell yields one specificity, not a sample of the node's whole collection. Many other cells in the same node carry other sites, but they were not selected by this antigen, so pooling them describes the tissue rather than the lineage the question follows.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to connect an observed change in one cell's surface and interior to a prediction about the targeting of the protein that appears in serum.

---

## B2-Q12 . Adding a Protein Partner to a Capsule Sugar

**Stem.** A bacterial capsule sugar is given to two matched groups of children under two years of age. Group 1 receives the purified sugar alone; group 2 receives the same quantity of that sugar joined covalently to a foreign protein. Serum antibody able to attach to the sugar is assayed 14 days after a first injection and 14 days after an identical second injection given six months later.

| Group | After first injection (units/mL) | After second injection (units/mL) |
| --- | --- | --- |
| 1: sugar alone | 12 | 11 |
| 2: sugar joined to a protein | 15 | 138 |

Which property of the group 2 material accounts for the pattern across its row?

- **A.** Its sugar chain carries more repeating units, so a larger number of matching receptors on one cell are bridged together at the moment of first contact.
- **B.** Much of what is counted in its second column is antibody aimed at the attached partner rather than at the sugar itself.
- **C.** Its sugar cannot engage any matching receptor until the attached partner has been broken down first, so the plain preparation triggers nothing at all.
- **D.** Its attached partner yields peptide fragments the sugar-binding cell can display, recruiting the licensing lymphocyte subset and setting up a much larger reaction on re-exposure.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | Meets (a): combines the display requirement for the licensing subset with the fact that improvement on repeat exposure depends on that help. Meets (c): choices A and B are both defensible until the student applies the flat row 1 values and the stated assay target. Meets (d): the outcome is supplied and the causal feature must be inferred backwards. |

**Correct answer (D): Its attached partner yields peptide fragments the sugar-binding cell can display, recruiting the licensing lymphocyte subset and setting up a much larger reaction on re-exposure.**

Citations: MICRO:33403; MICRO:33406; MICRO:33428; MICRO:33440; MICRO:33815

**Distractors**

- **(A)** `misconception` . _cross-linking alone builds a stronger repeat response_: Repeating units and receptor cross-bridging are present in the plain sugar too, and that is precisely the arrangement that yields the flat row 1 pattern, so it cannot explain row 2.
  - Citation: MICRO:33428; MICRO:33440
- **(B)** `partial_truth` . _true side product mistaken for the measured quantity_: Antibody to the attached protein really is generated, but the stem states the assay detects only antibody that attaches to the sugar, so this cannot account for the reported value.
  - Citation: MICRO:33816
- **(C)** `process_step_confusion` . _processing step placed ahead of receptor binding_: Places processing of the partner before receptor engagement with the sugar and is refuted by the nonzero group 1 first column value.
  - Citation: MICRO:33406; MICRO:33428

**Readback check.** Content words of six or more letters in key D: attached, partner, yields, peptide, fragments, binding, display, recruiting, licensing, lymphocyte, subset, setting, larger, reaction, exposure. Of these only attached appears in the stem, in the neutral phrase joined covalently, and it carries no mechanism. The stem's long words are bacterial, capsule, matched, groups, children, purified, alone, quantity, joined, covalently, foreign, protein, antibody, attach, assayed, injection, identical, months, property, material, accounts, pattern. Table values cannot be copied into any answer, the key is not the only option of its length, and the key demands a mechanism absent from the stem.

**Explanation (as shipped).**

> This Organ Systems item tests antigen presentation as the gate on help from the licensing lymphocyte subset, read out of a two dose vaccine data set. The answer is D because the lymphocyte subset that supplies licensing signals can only act on a target that is showing it a fragment held in a display molecule, and a sugar yields no such fragment. Both preparations gave a modest first result, so the sugar by itself clearly reaches and triggers cells whose receptors fit it; the informative comparison is not the first column but the change from the first column to the second. Group 1 gained nothing on the repeat dose, the signature of a reaction that runs on receptor engagement alone. In group 2 the cell that grabs the sugar also internalises the protein tied to it, breaks that protein up and shows pieces of it on its own display molecule, which recruits licensing cells matched to those pieces. That extra input is what converts a short lived reaction into one that returns far stronger months later, and it is why a designer of such a preparation attaches a protein rather than simply purifying more sugar.
>
> (Choice A) Repetition on a sugar is exactly what lets it engage many receptors on one cell at once, and that engagement is already occurring in group 1, whose first column value is comparable. Cross-bridging alone produces the flat pattern seen in row 1, so it cannot be the source of the difference in row 2.
>
> (Choice B) Antibody against the attached protein is indeed produced, but the assay described counts only antibody that attaches to the sugar, so the second column value is not inflated by that population. The choice is true about the response and irrelevant to the number reported.
>
> (Choice C) Group 1 produced 12 units without any partner present, which directly contradicts the claim that nothing is triggered by the plain sugar. This reverses the order of events as well, since the sugar is bound by its matching receptor first and any protein tied to it is processed afterwards.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to compare change across two columns rather than absolute values and to infer from that comparison which feature of one preparation supplied the missing requirement.

---

## B2-Q13 . Culture Arm Testing Matched Versus Generic Help

**Stem.** A researcher cultures purified B lymphocytes with a foreign protein for seven days and finds no antibody in the medium. In a parallel well, adding cells of the non-killing lymphocyte population, which releases soluble permitting signals, restores antibody output. A colleague argues that the added cells may simply be supplying a general growth factor that any dividing cell would require. Which additional culture arm best addresses that objection?

- **A.** Omit the protein from the well that contains both cell types, then assay the medium.
- **B.** Add partner cells in the same number, but ones able to react only to an unrelated target, holding all else constant.  <- **KEY**
- **C.** Culture the added cells by themselves with the protein and assay the medium for antibody.
- **D.** Raise the number of B lymphocytes tenfold in the well that lacks the added cells.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 95 s |
| Confidence | 4 |

**Correct answer (B): Add partner cells in the same number, but ones able to react only to an unrelated target, holding all else constant.**

Citations: MICRO:33403; MICRO:33404; MICRO:33406; AP:42328

**Distractors**

- **(A)** `partial_truth` . _legitimate baseline that lacks discriminating power_: A no-antigen well is a genuine baseline, but it yields no antibody under either competing explanation and so cannot separate them.
  - Citation: MICRO:33403
- **(C)** `adjacent_fact` . _valid control aimed at a different question_: Tests whether the added cells secrete the measured antibody themselves, an assay housekeeping question unrelated to whether their help is matched or generic.
  - Citation: AP:42328
- **(D)** `misconception` . _scaling responders substitutes for a missing signal_: Treats a missing required input as a shortage of responders; more B lymphocytes without the permitting signal still produce nothing, and the result is uninformative either way.
  - Citation: MICRO:33404

**Readback check.** Content words of six or more letters in key B: partner, number, unrelated, target, holding, constant. None appears in the stem, whose long words are researcher, cultures, purified, lymphocytes, foreign, protein, antibody, medium, parallel, adding, non-killing, lymphocyte, population, releases, soluble, permitting, signals, restores, output, colleague, argues, general, growth, factor, dividing, require, additional, culture, addresses, objection. The key deliberately avoids the stem words protein and population so it cannot be chosen by vocabulary matching; it names an arm nowhere described in the stem and requires reasoning about what each outcome would mean. All four options are of comparable length.

**Explanation (as shipped).**

> This Organ Systems item tests experimental design around antigen presentation, specifically how to show that help delivered to a B lymphocyte is matched to the antigen rather than generic. The answer is B because a growth factor would work on any dividing cell regardless of what that cell is displaying, whereas matched help requires the helping cell to read a fragment of the very protein the B lymphocyte took up. Swapping in partner cells that can respond only to some unrelated target holds cell number, culture conditions and the protein constant and varies one thing: whether the partner cells can recognise what the B lymphocyte is showing them. If antibody still fails to appear, the restoring effect cannot be a nonspecific factor, since a nonspecific factor would be delivered by these cells as readily as by the original ones. If antibody does appear, the colleague is right and the effect is generic. The arm therefore produces opposite outcomes under the two competing explanations, which is what any discriminating control must do.
>
> (Choice A) Removing the protein gives no antibody under either explanation, because a B lymphocyte still needs its receptor engaged before it can respond at all. The arm confirms that the trigger is required but leaves the two competing accounts of the added cells untouched.
>
> (Choice C) Culturing the added cells alone checks whether they are themselves the source of the antibody being measured. That is a reasonable housekeeping control for the assay, but it says nothing about whether their contribution to the mixed well is targeted or generic.
>
> (Choice D) Adding more responders does not create the missing signal, and the outcome would look the same whichever explanation is true. This assumes a shortfall of quantity where the stem describes a shortfall of a required input.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to select the culture arm whose two possible outcomes separate a targeted requirement from a nonspecific one while changing a single variable.

---

## B2-Q14 . Why Re-encounter Shortens the Delay

**Stem.** A volunteer is injected with a harmless bacterial protein. Blood sampling finds no circulating protein able to bind it until about day ten, after which the level rises modestly and then falls back to undetectable over the following weeks. The same material is injected again six months later, and bindable protein is measurable within two days at a level far above the earlier peak. What accounts for the much shorter wait on the repeat injection?

- **A.** Descendants of the cells that answered the first time bind a wider range of shapes, so more of them can take part.
- **B.** Fragment display by other cells is no longer needed once a foreign shape has been met, so one stage is skipped.
- **C.** A trickle of the bindable protein persisted from the first response and simply continued at the same rate.
- **D.** Cells committed to that one specificity had become far more numerous and long lasting, so fewer cycles of proliferation stood ahead of secretion.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (D): Cells committed to that one specificity had become far more numerous and long lasting, so fewer cycles of proliferation stood ahead of secretion.**

Citations: AP:43142; AP:43145; AP:43149; AP:43165; MICRO:33504; MICRO:33517

**Distractors**

- **(A)** `misconception` . _repeat responses are broader rather than more focused_: Only clones whose receptors were already activated by this antigen are stimulated to proliferate, so the expanded population is focused on the same antigen rather than able to bind a wider range of shapes. Breadth would also not explain an earlier onset.
  - Citation: AP:43145
- **(B)** `process_step_confusion` . _a stage of the pathway is dropped on repeat exposure_: Binding of antigen, its processing and surface display, and the cell to cell contacts that follow are listed among the steps that make up the response, and they are required on every encounter. No stage is bypassed on a second exposure; the same stages simply begin from a much larger starting population.
  - Citation: MICRO:33506
- **(C)** `partial_truth` . _residual output explains the second rise_: Antibody levels can remain elevated for a time after a response, but the stem specifies that the level returned to undetectable before the second dose, and a constant trickle cannot produce a rise within two days to well above the first peak.
  - Citation: MICRO:33522

**Readback check.** Content words of six or more letters in key D: committed, specificity, numerous, lasting, cycles, proliferation, secretion. None of these appears anywhere in the stem, which uses volunteer, injected, harmless, bacterial, protein, circulating, sampling, undetectable, following, measurable, material, months, repeat, injection, accounts, shorter. No shared distinctive word, and the key cannot be produced by restating any stem sentence.

**Explanation (as shipped).**

> This question belongs to the Organ Systems category and tests how a repeat meeting with the same antigen differs from the first meeting. The answer is D because the first exposure leaves behind a much larger and much longer lasting set of lymphocytes carrying receptors for that one antigen, so far fewer cycles of proliferation separate the moment of binding from the appearance of secreted antibody in the blood. Before any exposure, the lymphocytes able to bind a given antigen are present in very low numbers within the whole repertoire, and most of the first response is spent selecting those rare cells and expanding them into a working population whose descendants can secrete. Once that expansion has occurred, the surviving descendants persist for years, so the same antigen now meets a population far larger than before and already well advanced toward secretion. Speed on the second occasion therefore comes from starting the same process much further along, not from any change in how secretion itself works. (Choice A) Receptor binding shapes are fixed before the antigen is ever encountered, and only the cells whose receptors already bound this antigen were expanded, so the population left behind is focused on that same antigen rather than spread across a wider range of shapes; greater breadth would in any case not explain an earlier start. (Choice B) Surface display of fragments and the cell to cell contacts it supports are required on a repeat meeting exactly as on a first one, and nothing about a second dose removes a stage from the pathway. (Choice C) The stem states that the level fell back to undetectable well before the second dose, so continued low grade output cannot explain a rise that begins within forty eight hours and greatly exceeds the first peak. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to supply the reason a repeat exposure shortens the interval before antibody appears, drawing on how clonal selection changes the size and readiness of the responding lymphocyte population.

---

## B2-Q15 . Separate Causes for Speed and Size

**Stem.** On meeting an antigen it has encountered once before, an animal makes circulating antibody both sooner and in far greater quantity than it did the first time. An investigator claims that the earlier onset and the larger quantity are two outcomes of two distinct causes, not one cause showing itself in two ways. Three possible findings are listed below. Which findings, if obtained, would support that claim?

I. In animals whose lymphocytes able to bind the antigen are reduced back to the number present before any exposure, but which are otherwise unaltered, a repeat dose still yields antibody within two days, although the peak is no higher than in a first response.

II. In animals that have never met the antigen, artificially raising the number of lymphocytes able to bind it lifts the peak reached but leaves the onset as late as usual.

III. A drug that blocks lymphocyte division, given at the moment of the repeat dose, abolishes both the early onset and the raised peak.

- **A.** I and II only  <- **KEY**
- **B.** I and III only
- **C.** II and III only
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 100 s |
| Confidence | 4 |

**Correct answer (A): I and II only**

Citations: AP:43145; AP:43149; AP:43165; AP:43310; MICRO:33504; MICRO:33517

**Distractors**

- **(B)** `adjacent_fact` . _true observation that does not bear on the claim_: Finding III states something true and relevant to the response, that clonal proliferation is required, but a shared downstream requirement is predicted equally by a one cause account, so it offers no support for separate causes.
  - Citation: AP:43145
- **(C)** `misconception` . _a common requirement counts as evidence of separate causes_: Selecting III while dropping I mistakes a requirement shared by both features for evidence that they arise separately, and abandons the only finding that pulls onset apart from magnitude.
  - Citation: MICRO:33517
- **(D)** `partial_truth` . _correct pair plus one neutral finding_: I and II are the informative dissociations, but including III adds a result consistent with either account, so the selection is broader than the evidence supports.
  - Citation: AP:43310

**Readback check.** The key is the Roman numeral combination 'I and II only' and contains no content words of six or more letters, so no stem echo is possible. The choice cannot be selected by matching vocabulary; it requires evaluating each numbered finding against the claim. Findings I and II are not restatements of any stem sentence, and finding III is written to look supportive while being neutral between the two accounts.

**Explanation (as shipped).**

> This question belongs to the Organ Systems category and tests whether the two features of a repeat response, its earlier onset and its greater size, follow from one cause or from two. The answer is A because findings I and II each break the link between the two features, in opposite directions, whereas finding III is equally expected on either account. After a first exposure the population able to bind that antigen differs from the population in a naive animal in two respects at once: there are far more such cells, and those cells are already advanced along the road to secretion. Finding I strips away the numerical advantage while leaving the advanced state, and the speed survives while the size does not. Finding II grants the numerical advantage to an animal that has no advanced state, and the size improves while the speed does not. Two dissociations pointing in opposite directions show that each feature tracks a different property of the population, which is exactly the investigator's claim, and a student who explains only the speed or only the size has accounted for half of what changed. (Choice B) Finding I is genuinely informative, but finding III reports only that proliferation is needed downstream of both features, which is a true statement about the response that a single cause account predicts just as readily. (Choice C) This selection treats a shared downstream requirement as though it discriminated between the two accounts, and it discards finding I, the one result that separates onset from magnitude. (Choice D) Findings I and II are the two useful dissociations, but adding III does not strengthen the case, because a manipulation that removes both features together is neutral between one cause and two. This is a Scientific Reasoning and Problem Solving question because it asks the student to judge which experimental outcomes could dissociate two co-occurring features of a repeat response and which merely confirm a requirement common to both.

---

## B2-Q16 . Specificity Control in a Two Exposure Time Course

**Stem.** Antigen X is injected into a rabbit at the start of the study. Six weeks later the same rabbit receives a further dose of antigen X together with an unrelated antigen Y that it has never met. The table gives the concentration of circulating protein able to bind each antigen, in arbitrary units, on the days following whichever dose began that time course.

| Days after dose | X, first dose | X, second dose | Y, first dose |
|---|---|---|---|
| 2 | <1 | 12 | <1 |
| 4 | <1 | 140 | <1 |
| 7 | 3 | 620 | <1 |
| 10 | 18 | 900 | 2 |
| 14 | 30 | 950 | 15 |
| 21 | 24 | 780 | 26 |

What does including antigen Y allow the investigator to establish that the two antigen X columns on their own could not?

- **A.** The repeat dose of X reaches a far higher peak than the first dose of X did.
- **B.** Only the substance met earlier shows the swift, large accumulation, which rules out a body-wide lift in reactivity.  <- **KEY**
- **C.** The reply to Y was held back by the simultaneous huge reply to X, so both draw on one shared pool of cells.
- **D.** Having met X already quickens the animal's first reply to unfamiliar material, since binding protein for Y arises sooner than it did for X.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Meets (a): combines the primary versus repeat kinetic contrast with the principle of binding specificity. Meets (c): choices A and B are both consistent with the X columns until the student notices that only the simultaneous Y course can exclude a whole animal change. Meets (d): the student is given the outcome pattern and must infer what the design rules out rather than what it shows. |

**Correct answer (B): Only the substance met earlier shows the swift, large accumulation, which rules out a body-wide lift in reactivity.**

Citations: AP:43145; AP:43405; AP:43417; MICRO:33504; MICRO:33517

**Distractors**

- **(A)** `partial_truth` . _true conclusion that the control does not add_: The statement is supported by the data but is already available from the two X columns alone, so it fails to identify what antigen Y contributes to the design.
  - Citation: MICRO:33517
- **(C)** `misconception` . _competing responses drain a shared pool_: When a different antigen is met for the first time, the expected course is a delayed, low level response, which is exactly what the Y column shows, so nothing in the table indicates suppression by the simultaneous large response to X.
  - Citation: AP:43405
- **(D)** `reversed_relationship` . _acceleration generalised to an unmet antigen_: The direction is inverted by the data: binding protein for Y remains below 1 unit at day 7 while X on first meeting was already detectable at that point, so prior exposure did not speed the response to an unrelated antigen.
  - Citation: AP:43417

**Readback check.** Content words of six or more letters in key B: substance, earlier, accumulation, reactivity. None appears in the stem, which uses injected, rabbit, receives, unrelated, antigen, together, concentration, circulating, protein, arbitrary, following, whichever, investigator, establish, columns. No value in the key is read from the table; the key names what the design excludes, which requires comparing all three columns.

**Explanation (as shipped).**

> This question belongs to the Organ Systems category and tests what a simultaneous unrelated antigen adds to a comparison of first and repeat time courses. The answer is B because Y is given to the same animal at the same moment as the second dose of X, so its slow low course confines the acceleration and amplification to the one antigen the rabbit had met before, excluding any whole animal change in responsiveness acquired over the six weeks. Taken alone, the two X columns are compatible with two very different accounts: either the lymphocytes able to bind X changed, or the rabbit as a whole became a faster and stronger responder to anything. The Y column decides between them. Binding protein for Y stays below 1 unit until day 10 and reaches only 26 units by day 21, essentially the same sluggish, low course that X produced on first meeting, while X in the same animal at the same time is already at 140 units by day 4 and peaks near 950. Confinement of the effect to a single binding shape is what clonal selection predicts, because only lymphocytes whose receptors bound X were selected, expanded and retained, and a first meeting with a different antigen still shows the usual delay and low level. (Choice A) This is a fair reading of the two X columns, but it is exactly the conclusion those two columns already permit, so it names nothing that antigen Y contributes to the design. (Choice C) The data show no suppression of Y: its course matches what a first meeting normally looks like, and a large simultaneous reply to X neither delayed it nor lowered it, so no competition for a shared pool is demonstrated. (Choice D) The numbers run the other way. Binding protein for Y was still below 1 unit at day 7, when X on first meeting had already reached 3 units, so prior contact with X did not hasten the reply to an unfamiliar antigen. This is a Data-based and Statistical Reasoning question because it requires comparing three time courses measured in one animal and deciding which conclusion the added column licenses, rather than reading any single concentration off the table.

---

## B2-Q17 . Enlarged Responsive Population After Clearance

**Stem.** A person meets a particular antigen for the first time; the infection resolves and antibody against that antigen later falls below detection. Thirty years on, the same antigen is met again and is dealt with in two days rather than the two weeks the first episode took. Ignoring for the moment any change in how readily one cell is switched on, the shortened delay follows chiefly from which property of what the first episode left behind?

- **A.** Far more cells bearing receptors matched to it persist than were there at the start, so fewer rounds of proliferation stand between contact and a useful output.  <- **KEY**
- **B.** The surviving cells now carry receptors that fit a wider range of foreign material, so more of them can take part.
- **C.** The surviving cells live far longer than ordinary lymphocytes do, which is why they are still present decades later.
- **D.** The bone marrow releases new lymphocytes of that specificity at a permanently higher rate afterwards.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (A): Far more cells bearing receptors matched to it persist than were there at the start, so fewer rounds of proliferation stand between contact and a useful output.**

Citations: AP:43160; AP:43165; AP:43309; AP:43384; AP:43403; MICRO:33506; MICRO:33518

**Distractors**

- **(B)** `misconception` . _specificity broadens with experience_: A lymphocyte's binding specificity is set at maturation and is not widened by exposure; a broadened repertoire would also predict faster handling of unrelated antigens, which does not occur.
  - Citation: AP:43127; AP:43385; MICRO:32508
- **(C)** `partial_truth` . _true persistence, wrong explanatory role_: The surviving cells are indeed long lived, but longevity explains why the pool still exists decades later, not why the response it mounts is faster; the speed comes from the size of the pool.
  - Citation: AP:43165
- **(D)** `process_step_confusion` . _expansion relocated to the generative site_: Places the enlargement at the marrow's production of new naive lymphocytes rather than at peripheral division of the cells that actually bound the antigen; the marrow generates the full range of specificities without regard to which was used.
  - Citation: AP:43123; AP:43385

**Readback check.** Content words of six or more letters in key A: bearing, receptors, matched, persist, rounds, proliferation, between, contact, useful, output. Stem words of six or more letters: person, particular, antigen, infection, resolves, antibody, against, detection, thirty, rather, episode, ignoring, moment, change, readily, switched, shortened, follows, chiefly, property, behind. No overlap. The key is not a restatement of any stem sentence: the stem reports a timing observation and the key supplies the population-size cause of it. None of the five banned readback patterns applies: the key is not a paraphrase of a stem clause, does not reuse a distinctive stem noun phrase, is not the only choice sharing stem vocabulary, is not distinguishable by length or hedging, and does not restate a definition given in the stem.

**Explanation (as shipped).**

> This question belongs to Organ Systems and tests what an adaptive response leaves behind once it has finished, and why that residue by itself shortens the next encounter. The answer is A because the enlarged pool that survives the first episode is made up of descendants of the very few cells originally picked out by that substance, so a later exposure begins from a much larger base and needs far fewer divisions to reach a protective level of output. In a first exposure the body must find, among an enormous pre-built variety of lymphocytes, the rare ones whose surface binding sites happen to fit. Those few then divide again and again, and the days consumed by that build-up account for most of the lag before antibody can be measured. Most of the progeny become short lived secreting cells and die once the threat is gone, but a substantial fraction stays behind, permanently outnumbering the original handful by orders of magnitude. Present the same substance again and the arithmetic of clonal expansion starts from a far higher point, which on its own removes most of the wait, with no change in what any single cell can recognise. (Choice B) Binding specificity is fixed when a lymphocyte matures and does not broaden with experience. If it did, the accelerated handling would not be restricted to the one substance that produced it, and restriction to that one substance is exactly what is observed. (Choice C) Long survival is real, and it explains why the pool is still present decades later, but persistence answers whether the cells are there, not why what they mount is quicker. Speed comes from how many of them are waiting when the substance returns. (Choice D) The marrow keeps generating fresh lymphocytes across the whole pre-built range of specificities and has no way of knowing which one proved useful. The surplus is generated in the periphery by division of the cells that bound the substance, not upstream at the site where new lymphocytes are made. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall what clonal selection and clonal expansion leave in place after a response resolves and to attach that stored population directly to the shortened lag of a later exposure.

---

## B2-Q18 . Lowered Triggering Requirement of Surviving Lymphocytes

**Stem.** A protein is given at a dose too small to elicit any antibody in a mouse meeting it for the first time. When the number of lymphocytes able to bind that protein is first raised in such a mouse to match the number carried by a mouse that met the protein a year earlier, the low dose still elicits nothing, whereas the previously exposed mouse makes antibody at that dose. In a separate comparison, the soluble signal normally supplied by the lymphocyte subset that licenses others rather than killing them is held at a level that silences the first-time mouse completely, and the previously exposed mouse still makes antibody. Taken together, what do these two findings establish about the origin of the improved second response?

- **A.** The improvement is fully explained by there being more cells able to bind that protein, since more binding events occur at any dose.
- **B.** The always ready, nonspecific defences were upgraded by the first exposure and now handle the protein themselves.
- **C.** Pool size cannot account for it, because adding cells does not lower the input each one must gather before it commits.  <- **KEY**
- **D.** Each surviving cell secretes far more antibody than a newly made one does, so even minimal triggering yields a detectable level.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a): combines clonal expansion of the surviving pool with the per-cell nature of an activation requirement, two separate ideas. Meets (c): choices A and D remain defensible until the student applies the fact that the first finding equalises cell number and that a required input cannot be replaced by extra cells. Meets (d): the outcome is supplied and the cause must be inferred, and one candidate cause must be actively excluded rather than selected. |

**Correct answer (C): Pool size cannot account for it, because adding cells does not lower the input each one must gather before it commits.**

Citations: AP:43160; AP:43165; AP:43305; AP:43403; MICRO:33512; MICRO:33518; MICRO:33521; MICRO:36320

**Distractors**

- **(A)** `partial_truth` . _correct contributor, over-extended to sufficiency_: Pool size does explain much of the ordinary speed advantage, but the first finding equalises the two animals on how many cells can bind the protein and the unexposed animal still makes nothing, so abundance fails as a complete account.
  - Citation: AP:43403; MICRO:33518
- **(B)** `misconception` . _nonspecific arm acquires specific improvement_: The defences that respond identically to any foreign surface are not tailored by prior exposure; an upgrade there would speed responses to unrelated organisms rather than to this one protein alone.
  - Citation: MICRO:32508
- **(D)** `process_step_confusion` . _output magnitude substituted for the commitment step_: Addresses how much product a committed cell makes rather than how much input is needed to commit it, and the documented difference on re-exposure is longer survival of the secreting progeny rather than a higher per-cell rate; it also says nothing about the arm in which the licensing signal was restricted.
  - Citation: AP:43305; MICRO:33521

**Readback check.** Content words of six or more letters in key C: cannot, account, adding, before, commits. Stem words of six or more letters: protein, elicit, antibody, meeting, number, lymphocytes, raised, carried, earlier, elicits, whereas, previously, exposed, separate, comparison, soluble, signal, normally, supplied, lymphocyte, subset, licenses, others, rather, killing, silences, completely, together, findings, establish, origin, improved, response. No overlap. The key is not a restatement of the stem: the stem reports two outcomes and the key states what those outcomes rule out about the mechanism, which requires the per-cell nature of an activation requirement to be applied. None of the five banned readback patterns applies; the key is the shortest choice but is also the only one framed as an exclusion, so length carries no signal.

**Explanation (as shipped).**

> This question belongs to Organ Systems and tests whether the improvement in a repeat adaptive response can be credited entirely to the size of the pool left behind by the first exposure. The answer is C because the amount of stimulus a cell must collect before it is switched on is a property of that cell, and multiplying how many such cells are present does not reduce that requirement; if anything, dividing a fixed dose among more cells gives each one less. In the first finding the low dose yields nothing in the unexposed animal even after its population able to bind the protein has been brought up to match the exposed animal, so the two groups are equated on abundance and still differ in outcome. In the second finding the accessory input that a fresh cell must receive is cut to a level that abolishes the response in the unexposed animal, yet the exposed animal still responds, and a required input cannot be substituted for by extra cells either. The two findings therefore isolate a change in the cells themselves: the survivors are intrinsically easier to switch on, needing less of the material they recognise and less licensing than a cell that has never been used. Faster protection on re-exposure is thus the sum of two contributions, a bigger starting pool and a lower bar for setting each member of it in motion. (Choice A) Greater numbers are genuinely part of the story and account for much of the shortened lag under ordinary conditions, but the first finding deliberately matches the two animals on how many cells can bind the protein and the advantage survives that match, so abundance cannot be the whole account. (Choice B) The defences that act the same way on every foreign surface do not acquire target specific improvement; had they been upgraded, the advantage would extend to unrelated organisms, and specificity to the substance previously met is the defining feature of the improvement being examined. (Choice D) Product per cell concerns how much appears after a cell has committed rather than whether commitment happens, and the cells left behind by an earlier response are distinguished by how readily they start and by how long their secreting progeny persist, not by a higher output rate per cell. It also leaves the second finding unexplained, since there the licensing input rather than the recognised protein was withheld. This is a Scientific Reasoning and Problem Solving question because it asks the student to reason backwards from two outcomes, one of which equates the animals on cell number, and decide which of two candidate causes can and cannot produce them.

---

## B2-Q19 . Cell-Free Control in a Protection Transfer

**Stem.** A mouse that cleared a bacterial infection two months earlier serves as the donor, and cells taken from its spleen are moved into mice of the same inbred line that have never met that bacterium. Those mice then survive a bacterial dose that kills untreated mice of the line. A parallel group receiving spleen cells from a donor with no history of that infection dies at the untreated rate. The investigators conclude that protection travels with the moved cells. Which further group does the design need before that conclusion is safe?

- **A.** Mice given the same donor cells and then challenged with an unrelated bacterium.
- **B.** Mice given the donor cells one week after the challenge instead of before it.
- **C.** Mice given twice as many donor cells, to show a graded relation between number and survival.
- **D.** Mice given the cell-free liquid left when the same donor material is passed through a filter.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 95 s |
| Confidence | 4 |

**Correct answer (D): Mice given the cell-free liquid left when the same donor material is passed through a filter.**

Citations: AP:43160; AP:43165; AP:43423; AP:43446; MICRO:33562; MICRO:33579; MICRO:33518

**Distractors**

- **(A)** `adjacent_fact` . _valid control for a different claim_: Tests specificity of the protection rather than its source; a carried-over soluble product would show the same specificity, so this arm leaves the cellular versus soluble question unresolved.
  - Citation: MICRO:32508
- **(B)** `process_step_confusion` . _timing arm substituted for a source arm_: Shifts the transfer to after the challenge, which addresses therapeutic timing; the later preparation still carries the same dissolved products, so the confound remains in place.
  - Citation: MICRO:33579
- **(C)** `partial_truth` . _dose relation that scales the confound too_: A number-versus-survival relation is suggestive, but the accompanying fluid increases along with the cells, so both candidate causes rise together and neither is isolated.
  - Citation: AP:43446; MICRO:33562

**Readback check.** Content words of six or more letters in key D: liquid, material, passed, through, filter. Stem words of six or more letters: cleared, bacterial, infection, months, earlier, serves, spleen, inbred, bacterium, survive, untreated, parallel, receiving, history, investigators, conclude, protection, travels, before, conclusion, further, design. No overlap; donor is five letters. The key is not a restatement of the stem: the stem describes a transfer and its result, and the key names a control arm that the stem never mentions, which the student must derive from the possibility of soluble carry-over. None of the five banned readback patterns applies.

**Explanation (as shipped).**

> This question belongs to Organ Systems and tests the logic of crediting transferred protection to the cells in a preparation rather than to something else carried along with them. The answer is D because a suspension drawn from an animal that has already responded contains soluble products of that response, above all antibody whose binding sites fit the organism, and antibody transferred on its own is sufficient to protect a recipient that has never met the organism. Only an arm receiving the identical preparation with every cell taken out can separate the two possibilities. Should the filtered fluid protect as well as the intact suspension, survival is attributable to what was dissolved in it; should it fail, survival must be credited to the living population that was removed. Note what the existing arms already accomplish: the group receiving cells from a donor with no prior contact excludes any nonspecific benefit of receiving lymphocytes as such, and using one inbred line excludes rejection of the graft and a reaction to nonself tissue. What is still uncontrolled is the carry-over of dissolved products, and closing that gap is what the stated conclusion requires. (Choice A) Challenging with a different organism tests whether the protection is confined to what the donor previously met. That is a worthwhile question, but it is a different question, and a dissolved product would be equally confined, so this arm cannot tell a cellular cause from a soluble one. (Choice B) Giving the preparation after the challenge asks about treatment timing rather than about where the protection resides, and a suspension delivered later still carries the same dissolved products with it. (Choice C) A graded relation between how much was given and how many survived looks persuasive, but the volume of accompanying fluid rises in step with the number of cells, so both candidate agents increase together and the ambiguity is untouched. This is a Reasoning about the Design and Execution of Research question because it asks the student to name the specific control arm that separates a cellular cause from a soluble one before a transfer experiment can support a causal claim.

---

## B2-Q20 . Accessible Targets in a Prior Exposure

**Stem.** Two harmless test materials are made from one bacterium: one is the protein of its outer wall layer, the other an abundant enzyme the organism keeps inside itself and never puts on its outer face. Animals given either material generate antibody in equal amount and with equal tightness of fit for its own target, yet only the animals given the wall protein material survive a later challenge with the whole bacterium. Which requirement for protection does this result reveal?

- **A.** Protection is strongest when the response is aimed at a molecule buried deep in the organism, where it disables essential machinery.
- **B.** The internal enzyme reached the circulation without being taken up and shown to lymphocytes, so no lasting clone was established for it.
- **C.** Only one of the two responses yields molecules able to grip a feature displayed on the intact cell.  <- **KEY**
- **D.** Both responses install lasting clones, but only the one aimed at the wall layer is renewed often enough to still be present at challenge.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 95 s |
| Confidence | 5 |
| Hard-tier gate | (a) It combines antigen antibody binding specificity with the separate requirement that the bound feature be present on the exterior of the intact pathogen. (c) Choices A and D stay defensible until the student applies the specific facts that both animals produced equal amounts of equally tight product after a single identical schedule. (d) The outcome is given and the causal requirement must be inferred backwards from it. |

**Correct answer (C): Only one of the two responses yields molecules able to grip a feature displayed on the intact cell.**

Citations: MICRO:32718 (antibodies bind epitopes on the surface of pathogens); MICRO:32579 (a single antigen carries several distinct epitopes); AP:43385 (clonal selection expands only lymphocytes of appropriate specificity, whose product carries that same specificity); AP:43428 (a killed or weakened preparation, or its components, installs lasting memory without the disease)

**Distractors**

- **(A)** `reversed_relationship`: It relates target depth to protective value in the wrong direction. A buried molecule is less reachable by a circulating recognition molecule, and the data show the interior target gave no protection at all.
  - Citation: MICRO:32718
- **(B)** `process_step_confusion`: It locates the difference at the uptake and display stage, but both animals must have completed that stage because both generated a large, tightly fitting product; the divergence occurs at the challenge.
  - Citation: MICRO:32870
- **(D)** `partial_truth`: It is right that both animals carry lasting clones, but it attributes the difference to how long those clones persist, which cannot apply when both groups received one treatment and were challenged at the same time.
  - Citation: AP:43385

**Readback check.** Content words of six or more letters in key C: responses, molecules, feature, displayed, intact. None of these appears in the stem, which uses harmless, materials, bacterium, protein, abundant, enzyme, organism, inside, Animals, generate, antibody, tightness, survive, challenge, requirement, protection, result. The key therefore cannot be produced by restating the stem; the student must supply the missing step that protection requires a target reachable on the intact organism, not merely a well fitted product.

**Explanation (as shipped).**

> Organ Systems, antigen and antibody recognition: this item asks what a deliberate harmless prior exposure must supply if the protection it installs is to work when the real organism arrives. The answer is C because protection depends on the expanded clones producing molecules that can physically reach and grip a structure carried on the outside of the intact pathogen, and only the wall protein material offers such a structure. Clonal selection expands whatever lymphocytes happen to fit the material supplied, so both animals expand a well fitted population and both accumulate abundant product of equal fit; the two responses are equivalent in every respect the assay measured. What differs is the address of the target. The enzyme sits behind the wall of the intact organism during a real challenge, so the fitted molecules circulate with nothing to hold, and the infection proceeds as though the animal had never been treated at all. The wall protein, by contrast, is on the exposed face of every cell in the challenge dose, so the same recognition event now lands on the pathogen and the organism is blocked and marked for destruction. This is exactly why a controlled prior exposure has to carry the same reachable features the pathogen itself will present, rather than merely any part of it.
>
> (Choice A) reverses the relationship between target location and protective value. A molecule sequestered inside the organism is harder, not easier, for a circulating recognition molecule to reach, and burial confers no advantage; the useful target is the one on the outside.
>
> (Choice B) misplaces the failure at the uptake and display step. Both animals plainly took up, processed, and displayed their material, because a large, tightly fitting product cannot be generated without that step, so the two responses diverge later, at the challenge itself.
>
> (Choice D) is correct that both animals hold lasting clones, but persistence is not what separates the groups. Both received a single treatment and were challenged at the same later time, so no difference in durability is available to explain the outcome.
>
> This is a Scientific Reasoning and Problem Solving question because the student must recognise that equal amounts of equally tight product do not by themselves confer protection and must infer that reachability of the target on the intact organism is the limiting requirement.

---

## B2-Q21 . Control Arms for a Specificity Claim

**Stem.** A team gives mice a harmless material made from bacterium P, waits four weeks, then challenges them with the unrelated bacterium Q and finds that the mice become infected. They wish to conclude that the protection this material installs does not extend to Q. Which of the following groups must the study include for that conclusion to hold?

I. Mice given no material and then challenged with Q
II. Mice given the material from P and then challenged with P
III. Mice given a material made from Q and then challenged with Q

- **A.** I only
- **B.** I and II only  <- **KEY**
- **C.** I, II, and III
- **D.** II only

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 75 s |
| Confidence | 4 |

**Correct answer (B): I and II only**

Citations: MICRO:32508 (the secondary response is specific to the pathogen in question, and exposure to one agent does not protect against unrelated agents); AP:43428 (a killed or weakened preparation, or its components, installs lasting memory without the disease); MICRO:33546 (an artificial prior exposure installs the capacity for a rapid later response)

**Distractors**

- **(A)** `partial_truth`: The untreated baseline for Q is genuinely required, but on its own it cannot exclude the possibility that the preparation never installed protection in the first place, which is a different explanation for the same outcome.
  - Citation: AP:43428
- **(C)** `adjacent_fact`: It treats an arm that answers a neighbouring question, whether Q is protectable at all, as though it were required for the stated conclusion that protection raised against P fails to reach Q.
  - Citation: MICRO:32508
- **(D)** `misconception`: It assumes a challenge outcome can be interpreted without an untreated comparison group, so the observed infection rate after the P material has nothing to be judged against.
  - Citation: MICRO:32508

**Readback check.** The key is a Roman numeral combination and contains no content words at all, so no stem echo is possible. The numerals themselves are stated neutrally as candidate groups, and the stem nowhere indicates which of them is required; the student must reason out that a negative result needs both an untreated baseline for the challenge organism and a positive demonstration that the material was potent.

**Explanation (as shipped).**

> Organ Systems, the specificity of adaptive protection: this item asks which comparison arms are logically necessary before a failure to protect can be read as evidence that protection is antigen specific. The answer is B because the intended conclusion rests on two separate claims, that the mice met Q at its ordinary infection rate and that the material was capable of protecting at all, and those two claims are supplied by group I and group II respectively. Without group I there is no figure to compare the observed infection rate against, so the outcome after the P material carries no information; Q might infect nearly every animal it meets, treated or not, or hardly any. Without group II an equally simple explanation survives, that this batch of material was inert, degraded, or given below an effective dose, in which case the failure says nothing about the reach of protection and everything about the preparation itself. With both arms present the result is pinned down: the material demonstrably installed protection, and that protection demonstrably did not carry over to an organism sharing none of the same recognised features. Group III addresses a different question, whether Q can be protected against by some material of its own, and the answer to that has no bearing on whether protection raised against P transfers.
>
> (Choice A) supplies the baseline and nothing else. It rules out the possibility that Q fails to infect untreated mice, but it leaves an inert or mishandled preparation standing as a complete alternative explanation for the lack of protection.
>
> (Choice C) treats an informative arm as a required one. A study can establish that protection raised against P does not extend to Q without ever showing that any material protects against Q, so this group strengthens the report but is not needed for the stated conclusion.
>
> (Choice D) confirms that the material was potent but leaves the challenge outcome uninterpretable, because the infection rate observed after the P material has no untreated value to be measured against.
>
> This is a Reasoning about the Design and Execution of Research question because the student must decide which control arms are logically required to support a negative result and must separate a necessary comparison from one that is merely informative.

---

## B2-Q22 . Graded Protection Against a Mutated Coat

**Stem.** Rabbits received one of three prior treatments and were later challenged with one of three organisms. Variant A2 arose from strain A by mutation of its outer coat, while species Z is unrelated to A. The table gives the percentage of rabbits still uninfected fourteen days after challenge. Which conclusion about the material made from strain A does this pattern support?

| Prior treatment | Challenge organism | Percent uninfected |
| --- | --- | --- |
| Material from A | Strain A | 94 |
| Material from A | Variant A2 | 38 |
| Material from A | Species Z | 8 |
| Material from Z | Strain A | 9 |
| None | Strain A | 7 |
| None | Variant A2 | 6 |
| None | Species Z | 10 |

- **A.** Variant A2 is intrinsically less able to establish an infection than strain A is.
- **B.** Any prior treatment raises a general resistance that partly blunts whatever organism follows it.
- **C.** Full protection requires a second dose of the material, which the rabbits meeting A2 had not received.
- **D.** It installed binders that engage part of what A2 now presents and none of what Z presents.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) It combines the specificity of an installed response with the separate idea that a mutated coat retains a subset of the original recognised features, so protection is graded rather than all or none. (b) The student must make a quantitative and directional comparison of each treated value against its own matched untreated value, and read 38 percent as intermediate between 94 and 6 rather than as a lookup. (c) Choices A and B both stay defensible until the student applies the untreated arms for A2 and for Z. |

**Correct answer (D): It installed binders that engage part of what A2 now presents and none of what Z presents.**

Citations: MICRO:28753 (antigenic variation results in the continual emergence of new strains the existing response does not recognise); AP:43644 (surface molecules of agents such as influenza change enough that protection raised one year may not carry to the next); MICRO:33716 (an organism antigenically related to another can install protection that carries across to it); MICRO:32508 (protection is specific to the agent and does not extend to unrelated agents)

**Distractors**

- **(A)** `adjacent_fact`: It attributes the intermediate value to the variant's own infectivity, a different variable, and the untreated arms show A2 infecting naive rabbits just as readily as A does, 6 percent against 7 percent uninfected.
  - Citation: MICRO:28753
- **(B)** `misconception`: It denies specificity, but both unrelated pairings sit within two points of their own untreated rates, 8 against 10 and 9 against 7, so no general resistance was installed by the treatment.
  - Citation: MICRO:32508
- **(C)** `process_step_confusion`: It names the dosing stage as the source of the shortfall, yet all treated groups received the same single dose and that single dose produced 94 percent protection against strain A.
  - Citation: AP:43428

**Readback check.** Content words of six or more letters in key D: installed, binders, engage, presents. None appears in the stem or the table, which use Rabbits, received, treatments, challenged, organisms, Variant, strain, mutation, species, unrelated, percentage, uninfected, fourteen, challenge, conclusion, material, pattern, support, treatment, organism, Percent. The key is not a value read off the table either: 38 percent must be compared against both 94 and 6 before the partial match interpretation can be reached.

**Explanation (as shipped).**

> Organ Systems, the specificity of protection installed by a controlled prior exposure: this item asks what a graded set of challenge outcomes reveals about which features the installed response recognises. The answer is D because the value against A2, 38 percent, sits far above its own untreated rate of 6 percent yet far below the 94 percent recorded against strain A, which is the signature of a partial match, while both pairings involving Z sit level with their matched untreated rates, which is the signature of no match at all. The untreated arms give 7 percent for A and 6 percent for A2, so the two challenges are equally severe in a naive animal and the intermediate 38 percent cannot be blamed on a feeble variant. Mutation of an outer coat alters some of the features an existing response grips and leaves others unchanged, so the portion of the response that still finds a hold sets the portion of animals that stay clear, which is why the figure lands between the two extremes rather than at either one. The two unrelated pairings, 8 percent for the A material against Z where untreated rabbits reached 10 percent, and 9 percent for the Z material against A where untreated rabbits reached 7 percent, differ from their own baselines by no more than two points in either direction, which is precisely what antigen specific protection predicts.
>
> (Choice A) is excluded by the untreated arms. Rabbits given nothing resist A2 no better than they resist A, 6 percent against 7 percent, so the variant is not the weaker organism and its intrinsic capacity cannot explain the intermediate value.
>
> (Choice B) is excluded by the two unrelated pairings, which land within two points of their own untreated rates. A general heightened state installed by any treatment would have lifted those groups above their baselines, and it did not.
>
> (Choice C) misplaces the requirement at the dosing stage. Every treated group received one identical dose, and the group challenged with strain A reached 94 percent on that single dose, so the number of doses cannot account for the shortfall against A2.
>
> This is a Data-based and Statistical Reasoning question because the student must compare each treated value against its own matched untreated value and infer from the size of each gap how much of the recognised structure the mutated variant still retains.

---



---

# BATCH 4 of 4, FINAL (22 questions): lymphoid tissue and tolerance

Units: bone marrow, thymus, lymph nodes and spleen (12) . self versus nonself, host-damaging
responses, and deficiency as a probe of normal function (10).

**This batch completes Biology Chapter 8 at 90 questions.**

## Batch 4 summary

| Metric | Batch 4 | FULL CHAPTER (90) | Target |
|---|---|---|---|
| Difficulty | easy 6 . hard 8 . medium 8 | easy 24 . hard 30 . medium 36 | 27/40/33 |
| Answer letter | A 4 . B 6 . C 6 . D 6 | A 22 . B 23 . C 23 . D 22 | ~25% each |
| Cognitive skill | S1 5 . S2 10 . S3 3 . S4 4 | S1 14 . S2 47 . S3 12 . S4 17 | mixed |
| Confidence | conf4 6 . conf5 16 | conf4 19 . conf5 71 | only 4-5 ship |
| Roman numeral | 3 (14%) | 12 (13%) | 10-15% |
| Distractor categories | adjacent_fact 12 . misconception 21 . partial_truth 14 . process_step_confusion 10 . reversed_relationship 6 . scale_unit_error 3 | | none dominant |
| Em/en dashes | 0 | 0 | 0 |

## Final chapter position

The finished chapter lands on target across every axis: difficulty **27 / 40 / 33** against a
27 / 40 / 33 target, answer letters **24 / 26 / 26 / 24**, Roman numeral format 13 percent against a
10 to 15 percent band, and data-driven items 19 percent against a 15 to 20 percent band. Skill 1,
absent entirely from batch 1, finished at 16 percent.

Per-slice quotas were summed and compared against the batch target before each of batches 3 and 4
launched. That check caught a hand-allocation error in batch 3 that would have shipped the chapter with
answer letter B at 7 and D at 4 in that batch.

## One defect caught after drafting

Four questions in batch 4 (the bone marrow and thymus slice) carried inline source citations of the
form "(AP:42371, MICRO:32964)" inside their SHIPPED explanations, 25 references in total. Shipped
explanations must never contain source references; citations belong in this verification report only.
The auditor for that one slice did not strip them and the other five slices were unaffected. They were
removed deterministically, since every occurrence was a parenthetical insert at a clause boundary, and
the rewritten explanations were re-checked for the choice blocks, the answer sentence, the skill closer,
stray punctuation and residual references. All 22 pass. This check is now part of the full-chapter gate
and confirms 0 leaks across all 90.

## Full-chapter verification (all 90 questions)

| Gate | Result |
|---|---|
| Structural gates (choice blocks, answer sentence, skill closer, option labels, distractor count, hard-tier gate, confidence, banned stems) | all 90 pass |
| Distractor category enum (database CHECK constraint) | 270 of 270 valid |
| Source citation leakage into shipped text | 0 |
| Em and en dashes | 0 |
| Off-outline vocabulary | 0 across 34 forbidden terms |
| Chapter boundary violations | 0 |
| Distinct subtopics | 90 of 90 |
| Near-duplicate keys | none |

**One scope-scan hit investigated and cleared.** Q6 matched the forbidden term "complement", but both
occurrences use the ordinary English verb, describing a binding site whose shape and charge complement
the surface features of a particle. That is correct usage and does not name the complement protein
system, which is described purely functionally throughout the chapter. No change made.

**Scope convention verified across all 90:** zero occurrences of CD4, CD8, helper T, cytotoxic T,
regulatory T, suppressor T, dendritic, natural killer, NK cell, complement (as a noun naming the
system), interferon, plasma cell, memory cell, any immunoglobulin isotype, immunoglobulin,
opsonisation, agglutination, T-cell receptor, TCR, class I, class II, MHC-I, MHC-II, positive
selection, negative selection, cytokine, interleukin, costimulation, perforin, granzyme, Fab, Fc
region, hypervariable. Students meet this vocabulary in the Ch8 flashcard deck, which is not
scope-bound in the same way.

---

## B4-Q1 . Two Site Design of Lymphocyte Production

**Stem.** Every blood cell lineage in an adult arises from stem cells housed in the same set of marrow cavities, yet one lymphocyte lineage exits while still incompetent and completes its final steps inside a small structure lying behind the sternum. Both locations count as primary lymphoid sites. What does splitting the sequence across two locations achieve that carrying it out in one place could not?

- **A.** The marrow lacks the surface display molecules that a lymphocyte under test must engage, so no screening step can be carried out there.
- **B.** The second site receives lymph draining from the body surface, giving the cells under test a broader sample of antigens than the first site can offer.
- **C.** Immature cells are held in a compartment shielded from the debris of active infection and from the tissues they will eventually patrol, so any that react against the host's own peptides are deleted before they can reach a target.  <- **KEY**
- **D.** Separation lets the cells under test meet an assortment of nonself antigens before export, so only those that already recognise a pathogen are released.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (C): Immature cells are held in a compartment shielded from the debris of active infection and from the tissues they will eventually patrol, so any that react against the host's own peptides are deleted before they can reach a target.**

Citations: AP:42362 the primary lymphoid organs are the bone marrow and thymus gland; AP:42363 lymphoid organs are where lymphocytes mature, proliferate and are selected; AP:42371 the B cell undergoes nearly all of its development in the red bone marrow; AP:42372 the immature T cell leaves the bone marrow and matures largely in the thymus; AP:43107 self antigens are brought into the thymus from other parts of the body by presenting cells and the cells that bind them are killed; AP:43089 only two percent of the thymocytes that enter the thymus leave as mature functional cells; MICRO:32964 the first differentiation steps occur in red marrow, after which the immature cells travel to the thymus for the final steps; MICRO:33360 self-reacting cells of the other lineage are eliminated within the marrow itself; MICRO:46420 primary versus secondary lymphoid tissue.

**Distractors**

- **(A)** `misconception`: Marrow cells do carry the display molecules of the major histocompatibility complex, and the other lymphocyte lineage is screened against the host's own material inside the marrow successfully, so absence of display machinery is not the reason for the second site.
  - Citation: MICRO:33360; AP:42371
- **(B)** `adjacent_fact`: Receiving lymph from a drainage field is a true description of a secondary lymphoid organ where mature cells encounter antigen, not of the organ where a lineage is vetted, and it does not explain the two-site arrangement.
  - Citation: MICRO:46420
- **(D)** `reversed_relationship`: It reverses what the developing cell is tested against: the screen uses the host's own material, not pathogen material, and pathogens are normally absent from the site during development.
  - Citation: AP:43107; MICRO:32981

**Readback check.** Content words of six or more letters in key C: Immature, compartment, shielded, debris, active, infection, tissues, eventually, patrol, against, peptides, deleted, target. None of these appears in the stem, whose six-plus-letter words are lineage, arises, housed, marrow, cavities, lymphocyte, incompetent, completes, inside, structure, behind, sternum, locations, primary, lymphoid, splitting, sequence, across, achieve, carrying. No shared content word, and the key cannot be produced by restating any stem sentence.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests the division of labour between the site where lymphocytes are generated and the separate site where one lineage is vetted. The answer is C because the value of a second, separate location is that it is sequestered: a cell that would attack the host can be destroyed there while it is nowhere near the tissues it might damage and nowhere near invading material that would corrupt the test it is being put through. All blood lineages, including both lymphocyte lineages, begin from stem cells in red marrow. One of those lineages departs before it is functional and finishes behind the sternum, where it is confronted with the body's own peptides carried in by resident presenting cells; the great majority of arrivals fail and die, and only about two percent are ever exported. That arithmetic only makes sense if the deleting step happens somewhere the cell can do no harm while it is still dangerous, and somewhere the reference material is essentially all self. Vetting conducted in the middle of an infected tissue would both expose untested cells to targets and blur the very distinction the test is meant to draw.
>
> (Choice A) Nucleated cells throughout the body, marrow included, carry the display molecules of the major histocompatibility complex, and the other lymphocyte lineage is in fact screened against the host's own material inside the marrow. The marrow is not disqualified on that ground.
>
> (Choice B) Collecting lymph from a drainage field describes a secondary lymphoid organ such as a lymph node, which is where already mature cells meet antigen. It is an accurate description of a different structure and says nothing about why development is split in two.
>
> (Choice D) This inverts the logic of the vetting step. Cells are tested against the body's own material, not against pathogens, and the pathogens they will eventually recognise are absent during development. Exporting only cells that had already met a pathogen would leave the host defenceless against everything it had not yet encountered.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to state why the site where a lymphocyte lineage is vetted must be anatomically separate from both its birthplace and the tissues it will later police.

---

## B4-Q2 . Nonself Present During the Screening Window

**Stem.** Newborn mice are inoculated with a virus that establishes a persistent, high-level infection of the organ in which one lymphocyte lineage is tested before release, while replicating only weakly elsewhere. The mice grow up well and show no sign of attacking their own organs. As adults they mount no cell-mediated response at all to this virus, although their responses to unrelated viruses are ordinary. Which account fits the pattern?

- **A.** Fragments of the agent were on show throughout the checking window and were read as the host's own material, so any clone able to bind them was culled.  <- **KEY**
- **B.** The infection wiped out the developing population wholesale, leaving too few cells of that lineage to mount any specific response.
- **C.** Removal of cells directed at the host's own proteins takes place only after the cells reach the circulation, so the site of infection is irrelevant and the defect arose at the activation stage instead.
- **D.** Cells of this lineage survive only if they engage the display molecules carried by the resident cells of the organ, and those that fail to engage them die, which limits the repertoire.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a) it combines the location of the screening step with the clonal structure of the repertoire; (c) choices B and D are each defensible until the specificity of the deficit and the timing of deletion are applied; (d) it supplies an outcome, a selective response failure with intact self-tolerance, and asks the student to infer the cause. |

**Correct answer (A): Fragments of the agent were on show throughout the checking window and were read as the host's own material, so any clone able to bind them was culled.**

Citations: AP:43107 self antigens are transported into the thymus from other parts of the body by presenting cells and the cells that bind them are killed by apoptosis; AP:43087 developing cells in the cortex are exposed to the resident epithelium and must engage its display molecules to survive; AP:43089 only two percent of the thymocytes that enter leave as mature functional cells; MICRO:32981 the final screening step is described as central tolerance because it prevents self-reacting cells from reaching the bloodstream; MICRO:32967 the screening sequence occurs within the organ before export.

**Distractors**

- **(B)** `misconception`: A general wipeout of the lineage would abolish responses to all agents, which contradicts the normal responses to unrelated viruses reported in the stem.
  - Citation: AP:43089
- **(C)** `process_step_confusion`: It relocates deletion of host-directed cells from its true central position, carried out inside the organ and completed before export, to after entry into the circulation, and a post-export activation defect could not be confined to one specificity.
  - Citation: MICRO:32981; MICRO:32967
- **(D)** `partial_truth`: The stated requirement to engage the resident display molecules is genuine but applies equally to every specificity, so it is true without being sufficient and cannot explain a hole limited to the one agent present in the organ.
  - Citation: AP:43087

**Readback check.** Content words of six or more letters in key A: Fragments, throughout, checking, window, material, culled. None appears in the stem, whose six-plus-letter words are Newborn, inoculated, establishes, persistent, high-level, infection, lymphocyte, lineage, tested, before, release, replicating, weakly, elsewhere, attacking, organs, adults, cell-mediated, response, virus, although, responses, unrelated, viruses, ordinary, account, pattern. The key names a mechanism the stem never states and requires the student to supply it.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests what the composition of the environment inside a screening organ does to the repertoire that leaves it. The answer is A because a maturing cell treats whatever is on display in that organ as the standard of self, so an agent abundantly present there during development is written into that standard and the clones capable of recognising it are removed alongside the genuinely self-directed ones. The deleting step is deliberately blind: it asks only whether a cell binds what is displayed locally, not whether the displayed thing originated in the host, and cells that bind are killed by programmed death before export. Because the host's own peptides are richly represented at that site while pathogens normally are not, the step ordinarily removes only dangerous cells. Persistent occupancy of the organ by a virus breaks that assumption, and the price is a permanent gap in the repertoire specific to that one agent. That is precisely the observed pattern: nothing against this virus, ordinary responses to others, and no self-directed disease, since the screen against the host itself worked exactly as designed.
>
> (Choice B) Wholesale loss of the population would cripple responses to every agent and would show up as a general failure to thrive. The preserved responses to unrelated viruses rule this out, and it leaves the specificity of the deficit unexplained.
>
> (Choice C) Removal of cells that react against the host is a central step carried out inside the organ and completed before export, which is why such cells are largely kept out of the circulation in the first place. Relocating that whole process to after export moves a real step to the wrong stage and could not generate a defect confined to a single specificity.
>
> (Choice D) The requirement to engage the display molecules of the resident cells is a genuine feature of this lineage's development and does constrain what it can later see. It is true but not selective: the same requirement applies to the unrelated viruses these mice handle normally, so it cannot account for a gap limited to one agent.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to work backwards from a response failure limited to a single agent to the condition inside the screening organ that must have produced it.

---

## B4-Q3 . Neonatal Versus Adult Loss of Screening Organ

**Stem.** Two groups of mice have the organ that screens one lymphocyte lineage taken out surgically: group 1 on the day of birth, group 2 at nine months of age. Group 1 wastes away with runaway infections and fails to reject skin grafts. Group 2 stays healthy for the rest of its life, showing only a slow narrowing of the range of responses it can raise. What accounts for the gap between the two outcomes?

- **A.** The structure shrinks steadily after puberty, so by nine months it had already ceased to contribute and its loss could change nothing.
- **B.** Loss of the structure halts new output equally in both groups; group 1 suffers because its marrow cannot yet generate the precursors that would seed it.
- **C.** The surgery in group 1 also compromises the marrow, so the failure there is a general shortage of all blood cells rather than of one lineage.
- **D.** By the later age a large, long-lived pool of already vetted cells has built up outside the site and is kept going by division, whereas a day-old mouse has not yet assembled such a pool.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (D): By the later age a large, long-lived pool of already vetted cells has built up outside the site and is kept going by division, whereas a day-old mouse has not yet assembled such a pool.**

Citations: AP:42362 the primary lymphoid organs are the bone marrow and thymus gland; AP:42368 the bone marrow takes over most blood-forming functions during development; AP:42372 the immature T cell leaves the bone marrow and matures largely in the thymus; AP:34502 certain lymphocytes, unlike other white blood cells, live for many years; AP:42420 and AP:42421 thymic involution begins after puberty at a rate of about three percent tissue loss per year; MICRO:32999 the cells that exit the thymus migrate through the bloodstream and lymphatic system to secondary lymphoid sites such as lymph nodes and spleen, where they await activation; MICRO:46420 primary versus secondary lymphoid tissue.

**Distractors**

- **(A)** `partial_truth`: Involution after puberty is real but partial, at roughly three percent of tissue per year; the organ still contributes at nine months, and the protection of the older group comes from the reservoir already exported, not from the organ having stopped working.
  - Citation: AP:42420; AP:42421
- **(B)** `process_step_confusion`: It blames the earliest step, marrow precursor production, which is already functioning at birth, instead of the missing downstream reservoir of already screened cells.
  - Citation: AP:42368; AP:42372
- **(C)** `misconception`: Removing an organ behind the sternum leaves the marrow, a separate primary site, intact, so the newborn deficit is confined to the one lineage that depends on the removed site rather than being a general blood cell shortage.
  - Citation: AP:42362

**Readback check.** Content words of six or more letters in key D: long-lived, already, vetted, outside, division, assembled. None appears in the stem, whose six-plus-letter words are groups, organ, screens, lymphocyte, lineage, surgically, birth, months, wastes, runaway, infections, reject, grafts, healthy, showing, narrowing, range, responses, accounts, between, outcomes. The key introduces the peripheral reservoir, an idea absent from the stem, so it cannot be lifted from it.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests why the timing of losing a primary lymphoid organ changes the outcome so sharply. The answer is D because the organ is a factory for one lineage rather than the place that lineage lives and works: cells that pass its screen leave and take up residence in secondary lymphoid tissue, where they persist for years and can expand by division. An animal that reaches nine months has therefore already stocked its periphery with a broad, self-tolerant repertoire, and removing the factory only stops further stocking; the standing stock decays slowly, which is why the sole deficit seen is a gradual narrowing of the range of responses. A newborn has no such stock, so removing the factory removes the entire supply. The result is the classic picture in group 1: overwhelming infection and failure to reject foreign tissue, both of which need the lineage that is vetted at that site.
>
> (Choice A) The organ genuinely does involute, losing tissue steadily from puberty onward at roughly three percent per year, so this choice starts from a real observation. It goes too far, however: involution reduces output rather than abolishing it, and the reason group 2 is protected is the reservoir it built earlier, not the absence of any function at the time of surgery.
>
> (Choice B) The marrow has taken over most blood cell production well before birth and is generating lymphoid precursors at the time of the neonatal surgery, so a failure of precursor supply is not what distinguishes the newborn. This choice misassigns the deficit to the earliest step of the pathway rather than to the missing downstream reservoir.
>
> (Choice C) The organ removed sits behind the sternum, and the marrow is a separate primary site left intact by that operation, so oxygen carriage and phagocyte production are unaffected. The failure in group 1 is confined to the lineage that depends on the removed site, not spread across all blood cells.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to explain two opposite surgical outcomes by reasoning about what has and has not accumulated in the periphery at each age.

---

## B4-Q4 . Lineage That Never Leaves Its Birthplace

**Stem.** An infant is born without the small organ that lies behind the sternum, while the marrow is normal on biopsy. Blood analysis shows one of the two adaptive cell populations at a near-normal count and the other almost absent. Which one is at a near-normal count, and on what grounds?

- **A.** B lymphocytes, because they are produced at one site and then pass through the missing organ for a check that is not essential.
- **B.** B lymphocytes, because this lineage both arises and is screened inside the very cavities where all blood cells begin, so the absent structure never contributes to its supply.  <- **KEY**
- **C.** T lymphocytes, because it is the other lineage whose final steps depend on the structure behind the sternum.
- **D.** T lymphocytes, because the spleen and lymph nodes are where cells of every lineage meet displayed antigen.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (B): B lymphocytes, because this lineage both arises and is screened inside the very cavities where all blood cells begin, so the absent structure never contributes to its supply.**

Citations: AP:42371 the B cell undergoes nearly all of its development in the red bone marrow; AP:42372 the immature T cell leaves the bone marrow and matures largely in the thymus; AP:33939 B cells mature in the bone marrow while T cells mature in the thymus; MICRO:33355 lymphoblasts destined to become B cells do not leave the bone marrow and travel to the thymus for maturation; MICRO:33360 self-reacting cells of that lineage are eliminated within the marrow; MICRO:33362 cells that pass marrow selection travel to the spleen for their final stages of maturation; MICRO:32964 immature T lymphocytes enter the bloodstream and travel to the thymus for the final steps; MICRO:46420 spleen and lymph nodes are secondary lymphoid tissue.

**Distractors**

- **(A)** `misconception`: It has the right lineage but the wrong route: B lineage cells never pass through the organ behind the sternum at any stage of development, so describing that organ as an inessential waypoint for them is false.
  - Citation: MICRO:33355
- **(C)** `reversed_relationship`: It swaps which lineage depends on which site; the T lineage is the one that finishes behind the sternum, so its count is the one that falls when the organ is absent.
  - Citation: MICRO:32964; AP:42372
- **(D)** `adjacent_fact`: It correctly describes spleen and lymph nodes as places where mature cells meet displayed antigen, but those secondary sites do not generate or developmentally screen the lineage in question and so cannot preserve a lineage lacking its primary site.
  - Citation: MICRO:46420

**Readback check.** Content words of six or more letters in key B: lymphocytes, lineage, arises, screened, inside, cavities, structure, contributes, supply. None appears in the stem, whose six-plus-letter words are infant, without, behind, sternum, marrow, normal, biopsy, analysis, adaptive, populations, near-normal, almost, absent, grounds. The stem never states which population is spared, so the key requires the student to supply the developmental fact.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests which of the two adaptive lineages completes its development without ever entering the organ behind the sternum. The answer is B because the B lineage never migrates to that organ at all: it arises from marrow stem cells and undergoes nearly all of its development in the marrow, including the step that removes members binding the host's own material. Nothing in that programme requires the missing structure, and the last polishing stages take place in the spleen rather than behind the sternum, so the supply of these cells is untouched. The T lineage is the exception among blood cells in that it departs while still immature and must complete its testing behind the sternum, which is why its count collapses when that destination does not form. The practical prediction follows directly: defences that rest on cells finished in the marrow persist, while everything that depends on the lineage vetted behind the sternum, including rejection of foreign tissue, is lost.
>
> (Choice A) This names the right lineage on the wrong anatomy. Cells of the B lineage do not travel to the organ behind the sternum for any step; treating that organ as an optional waypoint for them misstates where their screening happens.
>
> (Choice C) This reverses which lineage depends on which site. It is the T lineage, not the B lineage, whose final steps occur behind the sternum, so the T count is the one that falls when that organ is missing.
>
> (Choice D) The spleen and lymph nodes are indeed places where mature cells encounter displayed antigen, and this statement is accurate as far as it goes. Those are secondary sites, however, and they neither generate nor perform the developmental screening of the lineage in question, so they cannot preserve a lineage whose primary site is absent.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which adaptive lineage completes its development without entering the organ behind the sternum and to apply that fact to an infant born without that organ.

---

## B4-Q5 . Why Rare Clones Must Be Concentrated

**Stem.** The body carries on the order of a trillion lymphocytes, but only a minute fraction of them bear a receptor shaped to bind any one particular antigen. A bacterium introduced by a thorn prick is at first confined to a few cubic millimetres of skin. Which feature of the response makes it likely that a matching cell will meet that bacterium's antigens within days rather than never?

- **A.** Each lymphocyte carries receptors of many different binding shapes, so nearly any cell in the pool can respond to whatever arrives.
- **B.** Phagocytes already living in the skin ingest and destroy the bacterium, which is what clears most punctured-skin infections.
- **C.** Both the invader's molecular fragments and a dense standing pool of the cells that could recognise them are funnelled into the same small filtering organ.  <- **KEY**
- **D.** The bacterium multiplies until its antigens are abundant enough throughout the whole body for chance contact to be certain.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 95 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines the rarity of any one binding specificity with the anatomy of drainage into a filtering organ; (b) requires a probabilistic inference about encounter rate rather than recall of a fact; (c) choices B and D are both defensible until the student applies the specific point that recognition requires physical co-location of antigen and repertoire. |

**Correct answer (C): Both the invader's molecular fragments and a dense standing pool of the cells that could recognise them are funnelled into the same small filtering organ.**

Citations: AP:42303, AP:42448, AP:42462, AP:43127

**Distractors**

- **(A)** `misconception` . _one cell, many specificities_: Each lymphocyte commits to one binding specificity, which is the source of the rarity problem; a cell binding everything would lose the discrimination the system depends on.
  - Citation: AP:43127
- **(B)** `adjacent_fact` . _innate answer to an adaptive question_: True of innate phagocytic clearance but irrelevant to how a specific cell finds its antigen, since it involves no specific recognition step at all.
  - Citation: AP:42685
- **(D)** `process_step_confusion` . _wait for dissemination_: Places body-wide spread before recognition, so the specific response would begin only after the infection is systemic, and dispersal dilutes rather than concentrates the antigen a cell would sample.
  - Citation: AP:42462

**Readback check.** Content words of six or more letters in key C: invader, molecular, fragments, standing, recognise, funnelled, filtering. Stem content words of six or more letters: trillion, lymphocytes, fraction, receptor, particular, antigen, bacterium, introduced, confined, cubic, millimetres, response, matching, antigens. No overlap, so no term can be matched by eye; the student must supply the concentration argument.

**Explanation (as shipped).**

> This Organ Systems question tests how the architecture of a secondary lymphoid organ solves an encounter problem that dispersed defence cannot solve. The answer is C because a cell present at vanishingly low frequency can find its target on a useful timescale only if the target and a concentrated pool of candidate cells are delivered into the same small space. Work through what the stem implies numerically: if only one cell in many tens of thousands carries a fitting receptor, a random search of every tissue compartment in the body would take far longer than an unchecked infection takes to become dangerous. Lymphatic drainage is therefore not merely a return route for tissue fluid; it carries a sample of whatever is in that tissue into a bean-sized organ that already holds lymphocytes packed at very high density. Because a representative sample of the invader and a large slice of the available repertoire now occupy a volume of only a few cubic centimetres, the improbable pairing becomes probable, and the one cell that fits can then be enlarged into a clone big enough to matter. Clonal selection has a physical prerequisite: the selecting agent and the population being selected from must be in contact, and the filtering organ is what guarantees that contact. (Choice A) This inverts the defining property of the adaptive system. Each lymphocyte commits to a single binding shape, which is exactly why any one specificity is rare and why the meeting problem exists at all; a cell able to bind anything would also fail to discriminate self from nonself. (Choice B) This is a true statement about innate defence and it does clear many minor wounds, but it is an answer to a different question. It describes destruction without specific recognition, and so says nothing about how a matching lymphocyte finds its antigen; it also fails whenever the organism resists ingestion. (Choice D) This puts the events in the wrong order. Waiting for body-wide dissemination would mean the specific response begins only after the infection has become systemic, which is the outcome the architecture exists to prevent, and spreading the same material through the whole body lowers rather than raises the concentration any one cell would sample. This is a Scientific Reasoning and Problem Solving question because it asks the student to turn a statement about how rare a matching cell is into a conclusion about where recognition must physically be made to happen.

---

## B4-Q6 . Purpose of the Obligate Drainage Detour

**Stem.** After removal of a breast tumour, the whole group of small bean-shaped filtering organs in one armpit is excised, and the drainage vessels of that arm are left to return tissue fluid to the circulation without passing through any such organ. The patient later sustains an identical superficial cut on each forearm, one on the operated side and one on the intact side. Which of the following would be expected on the operated side?

I. A response specific to the organisms in that cut begins later than the matching response on the intact side.
II. Material carried away from that cut enters the general circulation without first being gathered at a screening point.
III. Bacteria in the cut itself escape ingestion by cells already resident in that skin.

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
| Confidence | 4 |
| Hard-tier gate | (a) combines the routing of drainage with the innate versus adaptive distinction; (c) statements II and III are each defensible until the student decides whether tissue-level ingestion depends on a downstream organ; (d) inverts the usual direction by giving an altered anatomy and asking which functional outcomes follow. |

**Correct answer (B): I and II only**

Citations: AP:42184, AP:42462, AP:42467, MICRO:46429

**Distractors**

- **(A)** `partial_truth` . _true but incomplete set_: Correct that the specific response is delayed but omits the routing change that causes the delay.
  - Citation: AP:42462
- **(C)** `misconception` . _innate defence depends on nodes_: Drops the true delay to the specific response and accepts the false claim that tissue-resident phagocytes stop working when a downstream organ is removed.
  - Citation: AP:42685
- **(D)** `misconception` . _over-inclusive all-of-the-above_: Accepts the false statement that local ingestion of bacteria in the wound requires an intact downstream filtering organ, extending an organ-level conclusion to cells acting in the tissue.
  - Citation: AP:42467

**Readback check.** The key is the label 'I and II only' and contains no content words at all, so no stem echo is possible. Checking the numbered statements against the stem: statement words of six or more letters are response, specific, organisms, matching, intact, material, carried, general, circulation, without, gathered, screening, bacteria, escape, ingestion, resident. 'Intact', 'circulation' and 'without' derive from the setup wording, but none of them identifies which combination is correct, and the choice cannot be reached without deciding the truth of all three statements.

**Explanation (as shipped).**

> This Organ Systems question tests what is actually accomplished during the detour that tissue fluid makes before rejoining the circulation. The answer is B because abolishing the detour removes the step that gathers drained material for inspection, which delays the specific arm of defence, while leaving defences that operate in the tissue itself untouched. Statement I follows from the point that recognition by a rare specific cell is a numbers game: with no waystation in that path, whatever leaves the cut is carried straight into the general circulation instead of being deposited among densely packed lymphocytes, so the specific response starts later than on the intact side. Statement II is the same physical fact seen from the other side; the detour exists so that drained material is collected at a chokepoint and inspected before it goes anywhere else, and with the chokepoint gone that collection step simply does not happen. Statement III fails because defence in the skin does not depend on any distant organ: cells resident in the tissue engulf bacteria on contact, using recognition of general foreign features rather than a specific match, and they are still present after the operation. The discriminating principle is innate versus adaptive: only the adaptive arm requires the anatomical convergence that has been removed. (Choice A) This captures the delay to the specific response but stops short. It leaves out the routing change itself, which is the direct physical consequence of losing the chokepoint and the reason the delay occurs. (Choice C) This keeps the routing point but adds a false claim and drops the true one. Discarding statement I removes the whole immunological cost of the operation, and accepting statement III asserts that tissue phagocytes are somehow disabled by the loss of a structure downstream of them. (Choice D) This applies the right reasoning at the wrong level of organisation. Losing the organ impairs the response that must be assembled in a filtering organ, not the ingestion of bacteria by cells sitting in the wound, which happens locally and needs no such organ. This is a Scientific Reasoning and Problem Solving question because it asks the student to predict, from the removal of one anatomical step, which arms of defence fail and which are untouched.

---

## B4-Q7 . What Node Enlargement Actually Consists Of

**Stem.** A splinter wound on a child's forearm becomes infected. Over three days the bean-shaped organ in the armpit on that side becomes tender and grows to several times its usual bulk, while the matching organ in the opposite armpit stays as it was. The change in bulk is mainly accounted for by which of the following?

- **A.** Swelling of the individual cells already sitting there, with their count unaltered.
- **B.** Multiplication of the wound organisms themselves inside the organ until it is packed with them.
- **C.** An equal proportional expansion of every cell type the organ contains.
- **D.** A large gain in cell numbers, driven by rapid division of the few resident cells whose receptors fit what came from the wound.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (D): A large gain in cell numbers, driven by rapid division of the few resident cells whose receptors fit what came from the wound.**

Citations: AP:42152, AP:42490, AP:43123, MICRO:46506

**Distractors**

- **(A)** `scale_unit_error` . _cell size versus cell number_: Attributes an organ-level volume change to swelling of individual cells, the wrong level of organisation, and implies a response that adds no defensive capacity.
  - Citation: AP:42490
- **(B)** `misconception` . _node as culture vessel_: Treats the filtering organ as a place where the invader multiplies, when arriving organisms are largely ingested and destroyed there.
  - Citation: AP:42462
- **(C)** `partial_truth` . _non-selective proliferation_: Correct that cell division causes the growth but wrong that it is uniform; the value of the response lies in the disproportionate expansion of one fitting population.
  - Citation: AP:43123

**Readback check.** Content words of six or more letters in key D: numbers, driven, division, resident, receptors. Stem content words of six or more letters: splinter, forearm, becomes, infected, bean-shaped, armpit, tender, several, matching, opposite, accounted, following. No overlap. The stem describes only the observation, never the cellular mechanism, so the key cannot be recovered by matching words.

**Explanation (as shipped).**

> This Organ Systems question tests what the familiar swelling beside an infection physically consists of. The answer is D because the organ enlarges by making cells, and specifically by the explosive division of the small subset whose receptors happened to fit the material delivered from the infected site. What arrives from the wound is a sample of the invader and its molecules, and that sample is far too small to add any bulk of its own; what adds bulk is what the arriving sample sets off. The event is selection rather than general stimulation, because only cells with a fitting receptor are triggered to divide, and from a starting frequency of perhaps one in tens of thousands those cells generate a clone large enough to be a substantial fraction of the organ within days. Regions of rapid division become visible inside the organ as it works, and further cells are drawn in from the blood, which adds to the bulk. The one-sidedness in the stem is the giveaway that this is a selective, drainage-linked event rather than anything systemic: only the organ receiving fluid from that limb receives the trigger. (Choice A) This confuses a change in cell size with a change in cell number, the wrong level of organisation for the effect described. Individual cells cannot swell by enough to multiply the volume of a whole organ several times over, and a response that added no cells would leave the body no better equipped to clear the infection. (Choice B) This mistakes the organ for a culture vessel. Material arriving from the wound is inspected and largely destroyed there by cells that ingest foreign matter, so the organism load inside is small; an organ genuinely filling with multiplying bacteria describes a failure of the filter, not the ordinary swelling that accompanies a healing wound. (Choice C) This gets the mechanism right but the selectivity wrong, and the difference matters. Uniform expansion of every resident cell type would produce a bigger organ with the same proportions and no improvement in the response to this particular organism, whereas the useful outcome is the disproportionate amplification of one narrow population. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to identify the cellular event that clonal expansion inside a filtering organ actually amounts to.

---

## B4-Q8 . Draining Versus Remote Node Time Course

**Stem.** A traceable foreign protein is injected into the footpad of a mouse. At set intervals the small filtering organ receiving drainage from that foot and an unrelated one in the neck are removed, and two quantities are measured: how much of the protein is present, in arbitrary units, and how many cells per million bind it.

| Hours after injection | Protein, foot organ | Binding cells per million, foot organ | Protein, neck organ | Binding cells per million, neck organ |
| --- | --- | --- | --- | --- |
| 0 | 0 | 30 | 0 | 30 |
| 6 | 85 | 33 | 0 | 30 |
| 24 | 140 | 210 | 2 | 31 |
| 72 | 60 | 4100 | 4 | 46 |
| 120 | 10 | 2600 | 3 | 380 |

Which conclusion about the neck organ is best supported?

- **A.** Its late rise reflects cells that multiplied at the site of delivery and then travelled there, rather than fresh local triggering.  <- **KEY**
- **B.** The amount accumulating in it by 120 hours is enough to account for the count measured there.
- **C.** The two organs differ only in when the foreign substance reaches them; the eventual size of the responding population is comparable.
- **D.** Its responding cells were already climbing before anything could have left the foot, so the growth came first.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 100 s |
| Confidence | 5 |

**Correct answer (A): Its late rise reflects cells that multiplied at the site of delivery and then travelled there, rather than fresh local triggering.**

Citations: AP:42152, AP:42462, AP:42487, AP:43123

**Distractors**

- **(B)** `misconception` . _trivial signal read as sufficient_: Treats 3 arbitrary units as a sufficient stimulus when a hundredfold expansion at the other site accompanied 140 units, and ignores that the amount is falling while the count rises.
  - Citation: AP:43123
- **(C)** `partial_truth` . _delay only, same magnitude_: Correct that arrival timing differs but wrong that the outcomes match; final counts of 2600 against 380 per million show the second site never builds a comparable population.
  - Citation: AP:42462
- **(D)** `process_step_confusion` . _sequence of events reversed_: Places the rise at the remote site before delivery when the table shows counts of 30, 30 and 31 through the first 24 hours, flat while the draining organ expands.
  - Citation: AP:42487

**Readback check.** Content words of six or more letters in key A: reflects, multiplied, delivery, travelled, triggering. Stem content words of six or more letters: traceable, foreign, protein, injected, footpad, intervals, filtering, receiving, drainage, unrelated, removed, quantities, measured, present, arbitrary, million, injection, conclusion, supported. No overlap. The key is also not a value that can be read off the table; every figure in it must be compared against a paired figure elsewhere before the conclusion follows.

**Explanation (as shipped).**

> This Organ Systems question tests reading a two-site time course to decide whether a rise in responding cells was generated locally or imported. The answer is A because the neck organ shows a large rise in binding cells at a point when the amount of foreign protein it holds is trivial and already falling, so the cells cannot have been produced by stimulation there. Compare the two columns for the foot-draining organ: protein appears by 6 hours, peaks at 140 units by 24 hours, and is then cleared, while binding cells climb from 30 to 4100 per million by 72 hours, a rise of more than a hundredfold that is locked to the arrival of the protein. The neck organ never sees more than 4 units, roughly three per cent of the peak elsewhere, and its cell count is still essentially at baseline at 72 hours when the foot organ has already finished expanding. Only at 120 hours, after the expansion at the drainage site has run, does the neck count rise to 380. The order of events, large expansion at the delivery site first and a modest rise elsewhere afterwards, with no matching antigen signal at the second site, points to redistribution of already amplified cells through the circulation rather than a second, independent triggering event. (Choice B) This misjudges magnitude. Three units at 120 hours is a fraction of what accompanied a hundredfold expansion at the other site, and the amount there is falling while the count rises, so the two cannot stand in a driving relationship. (Choice C) This is right that arrival timing differs but wrong that the outcomes match. The eventual counts are 2600 and 380 per million, a sevenfold gap, so the second site never mounts a comparable population of its own. (Choice D) This reverses the sequence in the table. The neck counts are 30, 30 and 31 at 0, 6 and 24 hours, entirely flat while the foot organ is already expanding, so nothing rose there before material had left the foot. This is a Data-based and Statistical Reasoning question because it asks the student to compare the timing and magnitude of two paired columns and infer where a population of cells was actually produced.

---

## B4-Q9 . Screening Antigen That Never Leaves Vessels

**Stem.** An intravenous line becomes contaminated and delivers bacteria straight into a vein. The organisms multiply in the bloodstream and never establish a focus in any tissue space, so no draining lymph node ever receives them. Which structure allows an adaptive response to be raised against them anyway?

- **A.** The thymus, where developing lymphocytes that react against the body's own molecules are eliminated before they are released into service.
- **B.** The red bone marrow, which raises its output of new lymphocytes until enough of them happen to carry a useful receptor.
- **C.** The spleen, whose lymphocyte-rich sleeves wrap the small arteries within it, so vessel-borne material is screened as it flows past.  <- **KEY**
- **D.** The unencapsulated lymphocyte clusters beneath the linings of the throat and gut, which sample material crossing those surfaces from outside.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (C): The spleen, whose lymphocyte-rich sleeves wrap the small arteries within it, so vessel-borne material is screened as it flows past.**

Citations: AP:42496 and AP:42501 (the spleen is a major secondary lymphoid organ and functions as the location of immune responses to blood-borne pathogens); AP:42519 and AP:42525 (on entering the spleen the splenic artery splits into several arterioles surrounded by white pulp, and white pulp is where adaptive responses are mounted); AP:42461 (any bacteria that infect the interstitial fluid are taken up by the lymphatic capillaries and transported to a regional lymph node); MICRO:46423 and MICRO:46424 (the secondary lymphoid tissues include the spleen and lymph nodes; the spleen filters blood and captures pathogens and antigens that pass into it)

**Distractors**

- **(A)** `adjacent_fact` . _true-but-about-a-different-organ_: True of the thymus but irrelevant to the question asked: screening developing cells for reactivity against the body's own molecules is a maturation step, and the thymus does not sample circulating foreign material.
  - Citation: MICRO:32998 (the three steps of thymic selection eliminate 98% of thymocytes, and only the remainder leave the thymus for the secondary sites)
- **(B)** `misconception` . _more-output-solves-a-targeting-problem_: Specificity is fixed before antigen is met, so increasing production of new cells at random cannot place a fitting receptor in contact with an invader confined to the circulation.
  - Citation: AP:42446 (naive lymphocytes are fully functional immunologically but have yet to encounter an antigen to respond to)
- **(D)** `adjacent_fact` . _right-category-of-tissue-wrong-position_: These clusters are positioned to sample antigen crossing an epithelial surface, not antigen that remains inside vessels and never enters an interstitial space.
  - Citation: AP:42528 and AP:42530 (lymphoid nodules are dense clusters of lymphocytes without a surrounding fibrous capsule, located in the respiratory and digestive tracts, areas routinely exposed to environmental pathogens)

**Readback check.** Content words of six or more letters in key C: spleen, lymphocyte, sleeves, arteries, within, vessel, material, screened. Stem words of six or more letters: intravenous, becomes, contaminated, delivers, bacteria, straight, organisms, multiply, bloodstream, establish, tissue, draining, receives, structure, adaptive, response, raised, anyway. No overlap, so no stem echo. The stem does name one organ, the lymph node, but only to state that it is bypassed, and no choice offers a lymph node, so the mention eliminates nothing and cannot be matched to the key. The key must be selected on the anatomical relationship between the spleen and the vessels, which the stem never supplies.

**Explanation (as shipped).**

> This item belongs to Organ Systems and tests how the secondary lymphoid organs divide the sampling of the body between them. The answer is C because the spleen is the only one of these organs built onto the arterial circuit: the artery supplying it splits into small vessels that are sleeved by lymphocyte-rich tissue, so anything travelling in the circulation is delivered directly into a mass of naive cells and can be picked up by the cells that ingest foreign matter and display fragments of it.
>
> A lymph node is plumbed the opposite way. It is fed by incoming lymphatic channels carrying fluid that has already drained out of interstitial spaces, so a node can only sample antigen that first entered a tissue. An agent seeded straight into a vein and confined to the circulation never travels that route. Because the spleen sits on the circulatory path, clonal selection can proceed there: the rare naive lymphocyte whose receptor fits the invader is exposed to it, is triggered, and expands. That is precisely why the body needs a station screening the circulating compartment in addition to the network screening tissue drainage.
>
> (Choice A) The thymus screens developing lymphocytes for reactivity against the body's own molecules, which is a maturation function carried out before cells are released. It receives no meaningful stream of circulating foreign material to sample, so it cannot be where a response to an invader is initiated.
>
> (Choice B) Raising the output of new lymphocytes does not help, because each cell's binding specificity is fixed before it ever meets an antigen. Producing more cells at random does not bring a fitting one into contact with the invader; the invader has to be brought to a place where lymphocytes are already concentrated.
>
> (Choice D) The unencapsulated clusters under the lining of the throat and gut sample material crossing those surfaces from the outside world. They are positioned for antigen arriving across an epithelium, not for antigen already inside vessels and never entering an interstitial space.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which lymphoid organ is positioned on the circulatory path and is therefore able to initiate a response to material that never enters a tissue space.

---

## B4-Q10 . Why A Coated Organism Is The One That Overwhelms

**Stem.** Two years after his spleen was removed following a car crash, a man still clears boils, dental abscesses and infected cuts without unusual trouble. He then becomes critically ill within hours of acquiring a bacterium whose thick slippery outer layer makes it very hard for any cell to grip and swallow. What accounts for this selective pattern of vulnerability?

- **A.** Ordinary organisms are taken up on the spot, but this one is not until antibody has been raised against its covering, and the site that raises such a response to a blood-borne invader is gone.  <- **KEY**
- **B.** The covering hides the organism from lymphocytes altogether, so no antibody against it can be raised in anyone, whether or not that organ is still present.
- **C.** The removed organ was where developing lymphocytes acquire the ability to tell the body's own molecules from foreign ones, so his tolerance has been disturbed.
- **D.** The removed organ was the only site at which a rare lymphocyte can meet its fitting antigen, so every adaptive response he now mounts is delayed.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): Ordinary organisms are taken up on the spot, but this one is not until antibody has been raised against its covering, and the site that raises such a response to a blood-borne invader is gone.**

Citations: MICRO:33811 and MICRO:28593 (protective polysaccharide capsules help pathogens evade phagocytosis, because the composition of the capsule prevents immune cells from adhering to and ingesting the cell); MICRO:33813 (antibodies produced against the capsular polysaccharide combat the infection); AP:42501 (the spleen functions as the location of immune responses to blood-borne pathogens); AP:42461 (bacteria that infect the interstitial fluid are taken up by lymphatic capillaries and transported to a regional lymph node, a route unaffected by removal of the spleen); MICRO:48159 (patients without a spleen suffer unusually severe illness from an organism multiplying in the blood)

**Distractors**

- **(B)** `misconception` . _physical-resistance-mistaken-for-invisibility_: A thick surface layer blocks physical uptake but is itself antigenic, and antibody against that material is raised, so the claim that no response is possible against it is false.
  - Citation: MICRO:33813 (capsular polysaccharide antigens result in the production of antibodies that combat the infection)
- **(C)** `process_step_confusion` . _maturation-screen-attributed-to-the-wrong-organ_: Screening for reactivity against the body's own molecules is a maturation step in a different organ, and its failure would produce damage to the patient's own tissues rather than selective susceptibility to one organism.
  - Citation: MICRO:32993 and MICRO:32998 (thymic selection eliminates most cells reactive against the body's own molecules during maturation, before the survivors leave the thymus)
- **(D)** `partial_truth` . _one-of-several-sites-treated-as-the-sole-site_: The organ is one meeting place among several, so calling it the only one predicts a general slowing of all adaptive responses, which the preserved local infections rule out.
  - Citation: AP:42448 (lymphocytes concentrate in the secondary lymphoid organs, which include the lymph nodes, spleen, and lymphoid nodules)

**Readback check.** Content words of six or more letters in key A: Ordinary, organisms, antibody, against, covering, raises, response, invader. Stem words of six or more letters: spleen, removed, following, clears, dental, abscesses, infected, without, unusual, trouble, becomes, critically, within, acquiring, bacterium, slippery, swallow, selective, pattern, vulnerability, accounts. No overlap, so no stem echo. The stem describes a surface layer that resists gripping, and both the key and choice B refer back to that layer, so referring to it cannot single out the key. The stem never states what the removed organ did or what a resistant surface requires, so the key must be inferred.

**Explanation (as shipped).**

> This question sits in Organ Systems and asks what a later pattern of infections reveals about which requirement can no longer be met. The answer is A because an organism whose surface layer resists being gripped is not handled by ingestion alone: antibody has to be raised against that surface layer before a phagocyte can hold on to the organism at all, and for an invader multiplying in the bloodstream the place where that response is normally raised is the organ he no longer has. The failure is therefore confined to organisms that carry such a layer and arrive by that route.
>
> Boils, dental abscesses and infected cuts differ on both counts. Those organisms can be gripped and ingested at the site without any antibody being raised first, and antigen leaving the focus is taken up by lymphatic capillaries and carried to a regional node, a pathway the surgery never touched. So the split described in the case is exactly what the loss predicts: unchanged handling of ordinary local infections, catastrophic failure against a coated organism seeded into the blood.
>
> (Choice B) A thick surface layer resists being gripped, but it does not hide the organism from lymphocytes. That layer is itself a foreign structure, and antibody is raised against it, which is why the man's problem is where such a response can be mounted rather than whether it is possible at all.
>
> (Choice C) Screening developing lymphocytes for reactivity against the body's own molecules happens during maturation in a different organ, before those cells enter service. Disturbed tolerance would show up as damage to the patient's own tissues, not as selective susceptibility to one class of organism.
>
> (Choice D) A rare lymphocyte can encounter its target in any of several secondary sites, which is exactly why responses to skin and gum infections survive the loss. Claiming a single meeting place predicts a general slowing of every adaptive response, which contradicts the preserved handling of boils and abscesses.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to read a split between preserved and failed defences and infer which specific requirement of the failed case has no substitute in this patient.

---

## B4-Q11 . Why Rare Clones Must Keep Moving

**Stem.** In an adult, roughly one lymphocyte in every 100,000 carries a receptor able to bind any given foreign structure, and a pathogen that breaches the skin of the foot is held almost entirely within the single lymphoid organ draining that region rather than spreading to the others. A cell bearing a suitable receptor is nonetheless engaged within a few days. What does the continuous traffic of lymphocytes between the circulation and lymphoid tissue accomplish here?

- **A.** It increases the number of copies of each specificity present in the body, raising the chance that one is on hand at any given site.
- **B.** It carries the foreign structure outward from the point of entry to every site, so each lymphocyte can stay in the organ where it already resides.
- **C.** It returns cells that have already been triggered to the region that needs them, which is what removes the delay before the response begins.
- **D.** Each cell passes from one screening station to the next, so any clone eventually meets material held in all of them without having to live where the intruder arrived.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a): the student must combine the rarity of any single specificity under clonal selection with the anatomical fact that a given deposit of antigen is confined to one draining organ. Meets (c): choices A and C are both defensible until the student separates the search phase from the expansion and output phases of the response. Meets (d): the outcome, a fit found within days, is given and the student must infer backwards to the mechanism that makes it possible. |

**Correct answer (D): Each cell passes from one screening station to the next, so any clone eventually meets material held in all of them without having to live where the intruder arrived.**

Citations: AP:42302 and AP:42304 (B and T cells are found circulating in the bloodstream and lymph and residing in secondary lymphoid organs, and the body contains approximately 10^12 lymphocytes); AP:42446 and AP:42447 (naive lymphocytes are fully functional but have yet to encounter an antigen, and in addition to circulating in blood and lymph they concentrate in the secondary lymphoid organs); AP:42455 (high endothelial venules allow cells from the blood to directly enter these tissues); AP:42461 (bacteria that infect the interstitial fluid are transported to the regional lymph node draining that site)

**Distractors**

- **(A)** `misconception` . _traffic-mistaken-for-proliferation_: Moving cells around redistributes a fixed population and does not increase the number of copies of any specificity; clonal expansion follows the encounter rather than preceding it.
  - Citation: AP:42446 (naive lymphocytes are fully functional immunologically but have yet to encounter an antigen, so traffic changes their location rather than their number)
- **(B)** `reversed_relationship` . _antigen-moves-instead-of-cells_: Reverses which element moves: the stem states the invader is held in one organ, so the searching must be done by the cells, not by outward distribution of the target.
  - Citation: AP:42461 (an invader entering the interstitial fluid is transported to the one regional lymph node draining that site)
- **(C)** `process_step_confusion` . _effector-delivery-substituted-for-search_: Names the output stage, delivery of already triggered cells, in place of the search stage, so it cannot explain how a matching cell was located in the first place.
  - Citation: AP:42444 (lymphocytes mature in the primary lymphoid organs but mount immune responses from the secondary lymphoid organs, where the encounter precedes any effector delivery)

**Readback check.** Content words of six or more letters in key D: passes, screening, station, eventually, material, without, having, intruder, arrived. Stem words of six or more letters: roughly, lymphocyte, carries, receptor, foreign, structure, pathogen, breaches, almost, entirely, within, single, lymphoid, organ, draining, region, rather, spreading, others, bearing, suitable, nonetheless, engaged, continuous, traffic, lymphocytes, circulation, tissue, accomplish. No overlap, so no stem echo. The stem supplies a frequency and a confinement fact but never states what movement achieves, so the key must be reasoned to rather than matched.

**Explanation (as shipped).**

> This question belongs to Organ Systems and tests why a defence built on rare, pre committed clones can still find a fit quickly. The answer is D because a lymphocyte is not assigned to one site for life: it crosses out of the circulation into a lymphoid organ, spends some hours there, leaves and enters another. Over a day or two a single cell therefore visits many such stations in turn.
>
> That behaviour turns a hopeless problem into a manageable one. Clonal selection fixes each cell's binding specificity before it ever meets a target, so the body cannot manufacture a fitting receptor on demand; it can only bring the fitting cell and the target into the same place. If cells were stationary, success would require the one clone in 100,000 to happen to reside in the particular organ that captured the invader, and most encounters would fail outright. Because the whole population moves, every clone is repeatedly presented to every deposit of captured material, so the probability that the correct clone eventually arrives approaches certainty over a few days.
>
> (Choice A) Movement between compartments redistributes cells; it does not create them. The size of any clone rises only after its target has triggered it, which is a consequence of the meeting rather than a way of arranging one.
>
> (Choice B) This reverses the direction of the traffic that matters. The stem specifies that the invader stays where it was deposited and does not spread, so the mobile element must be the cells; a stationary population would still fail even if some material did leak away.
>
> (Choice C) Delivering already triggered cells to the affected region is the output stage of the response and occurs only after a fit has been made. It cannot explain how the fit was made, which is what the days before the response are spent on.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to combine the rarity of any one specificity with the confinement of the invader and infer what continuous cell traffic buys the system.

---

## B4-Q12 . Reading a Labelled Lymphocyte Distribution Time Course

**Stem.** Lymphocytes from a donor animal were tagged and injected into the bloodstream of a genetically identical recipient. The table gives the percentage of the injected tag recovered at each site afterwards, and the four columns sum to 100 at every time point. Blood in this animal makes a complete circuit of the body in well under a minute.

| Time after injection | Blood | Spleen | Lymph nodes | Other tissues |
| --- | --- | --- | --- | --- |
| 5 min | 78 | 11 | 3 | 8 |
| 1 h | 26 | 44 | 16 | 14 |
| 6 h | 14 | 31 | 41 | 14 |
| 24 h | 13 | 29 | 44 | 14 |
| 48 h | 13 | 29 | 44 | 14 |

Which conclusion is supported by these results?

- **A.** Most tagged cells are permanently captured by the first site they reach, since the value in the first column falls by roughly two thirds within the first hour.
- **B.** Cells must be leaving the sampled sites and re-entering the vascular space at the rate at which they arrive, since the shares settle after a few hours and then stop changing.  <- **KEY**
- **C.** The rise in the lymph node column between one and six hours shows that the tagged cells divide faster there than they do elsewhere.
- **D.** The nodes must be entered from the circulation more rapidly than the spleen is, because their share is the largest one at 48 hours.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic secondary / structural multi_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): Cells must be leaving the sampled sites and re-entering the vascular space at the rate at which they arrive, since the shares settle after a few hours and then stop changing.**

Citations: AP:42302 (B and T cells are found circulating in the bloodstream and lymph and residing in secondary lymphoid organs); AP:42447 (in addition to circulating in the blood and lymph, lymphocytes concentrate in secondary lymphoid organs); AP:42455 (high endothelial venules allow cells from the blood to directly enter these tissues); AP:42519 (on entering the spleen the splenic artery splits into several arterioles surrounded by white pulp)

**Distractors**

- **(A)** `partial_truth` . _correct-trend-wrong-endpoint_: The early fall is read correctly but the conclusion does not follow: permanent capture would drive the first column toward zero given the rapid circuit time, whereas it settles at 13 per cent and stays there.
  - Citation: AP:42447 (lymphocytes circulate in blood and lymph as well as concentrating in the secondary organs, so residence there is not permanent)
- **(C)** `misconception` . _redistribution-read-as-proliferation_: A rise in one column paired with falls in the others describes redistribution of a fixed total, and a table constrained to sum to 100 cannot show that any population increased in number.
  - Citation: AP:42302 (lymphocytes are simultaneously circulating and resident, so they move between compartments rather than multiplying on arrival)
- **(D)** `reversed_relationship` . _final-magnitude-mistaken-for-rate_: Uses the final share to rank the speed of entry, but the one hour values show the splenic share at 44 per cent against 16 per cent for the nodes, so the actual order of filling is the reverse of the final ranking.
  - Citation: AP:42455 and AP:42447 (cells cross directly from the blood into these tissues and also leave them again, so a standing share reflects accumulated residence rather than rate of entry)

**Readback check.** Content words of six or more letters in key B: leaving, sampled, entering, vascular, shares, settle, changing. Stem and table words of six or more letters: Lymphocytes, donor, animal, tagged, injected, bloodstream, genetically, identical, recipient, percentage, recovered, afterwards, columns, complete, circuit, minute, Spleen, tissues, conclusion, supported. No overlap, so no stem echo. The key is also not a figure read off the table: it requires combining the plateau across the last three time points with the stated circuit time to conclude that continuing flux, not capture, is what holds the values constant.

**Explanation (as shipped).**

> This question falls under Organ Systems and asks for an inference about lymphocyte traffic drawn from a distribution measured over time. The answer is B because the values at 24 and 48 hours are identical and the six hour values are already close to them, yet 13 per cent of the tag is still in the first column, and the whole circulating volume passes through these organs many times an hour. A share that large and that stable cannot be residual material still in transit, because at that circuit rate any cells not returning to the vessels would have been cleared from the first column long before 48 hours.
>
> A value that is constant is therefore evidence of exchange, not of stillness. Cells must be departing the tissues and re-entering the vessels at the same rate as others are leaving the vessels for the tissues, which is the definition of a steady state. The early points make the ordering plain as well: the splenic share is already 44 at one hour while the nodal share is only 16, and only later does the nodal share become the largest.
>
> (Choice A) The fall from 78 to 26 in the first hour is read correctly, but the conclusion does not follow. Permanent capture predicts that the first column would keep falling toward zero as the population makes circuit after circuit; instead it settles at 13 per cent and is still 13 per cent at 48 hours.
>
> (Choice C) A rise in one column matched by falls in the others over the same interval is movement between compartments, not multiplication. The table reports how a fixed quantity of tag is shared out and is constrained to sum to 100, so it cannot demonstrate that any population has grown in number.
>
> (Choice D) Being largest at the end says nothing about the speed of entry. At one hour the splenic share is 44 per cent against 16 per cent for the nodes, so the site that filled faster is the one with the smaller final share, and a standing share reflects how long cells stay as well as how fast they arrive.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to distinguish a static distribution from a steady state by comparing how the values behave across successive time points.

---

## B4-Q13 . Random Repertoire and the Need for Tolerance

**Stem.** Each developing lymphocyte builds its recognition site by joining gene segments in a combination drawn at random, fixed before the cell has ever met anything foreign, and across all such cells a person carries trillions of distinct sites. Why must the body impose a dedicated check on newly made cells rather than trusting this collection as it stands?

- **A.** A site that fits the body's own constituents cannot arise this way, because the gene segments available for joining exclude host-fitting shapes.
- **B.** Shapes produced blindly will inevitably include some complementary to the body's own material, so those cells must be eliminated once they exist.  <- **KEY**
- **C.** Far more sites appear than any one person will ever use, so the surplus has to be trimmed to conserve resources.
- **D.** Most sites made this way fit nothing at all, and the check exists mainly to discard those unusable cells.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (B): Shapes produced blindly will inevitably include some complementary to the body's own material, so those cells must be eliminated once they exist.**

Citations: MICRO:33388, AP:43288, MICRO:33360

**Distractors**

- **(A)** `misconception`: Foreignness is defined relative to the individual, and essentially the same inherited segment pool is shuffled in everyone, so no pool of segments could be pre-purged of host-fitting shapes.
  - Citation: MICRO:33388
- **(C)** `partial_truth`: Surplus really is generated, but resource economy is not what drives the screen; an unused cell is cheap while a host-attacking cell is not.
  - Citation: AP:43111
- **(D)** `adjacent_fact`: Cells with non-functional receptors are removed, but that concerns whether a cell can respond at all, not whether it threatens the host, so it does not account for a self-directed check.
  - Citation: MICRO:33358

**Readback check.** Key content words of six or more letters: Shapes, produced, blindly, inevitably, include, complementary, material, eliminated. Stem content words of six or more letters: developing, lymphocyte, builds, recognition, joining, segments, combination, random, before, anything, foreign, across, person, carries, trillions, distinct, impose, dedicated, rather, trusting, collection, stands. No overlap. The key is not stated in the stem: the stem supplies only that assembly is target-independent and that the repertoire is enormous, and the student must infer that blind sampling necessarily produces host-fitting shapes that then require active removal.

**Explanation (as shipped).**

> This Organ Systems item tests self versus nonself recognition, specifically why unresponsiveness toward the host has to be manufactured rather than inherited. The answer is B because shapes produced blindly will inevitably include some complementary to the body's own material, so those cells must be eliminated once they exist. The joining of gene segments proceeds with no information about what the cell will one day encounter, and that is precisely what lets the adaptive system cover targets no ancestor ever saw. The same indifference cuts both ways: a process that samples the space of possible binding surfaces without regard to origin cannot skip the region of that space already occupied by the host's own molecules. At a repertoire size in the trillions, a self-fitting fraction is not a rare accident but a statistical certainty, so a screening stage that tests immature cells against host constituents and then kills, edits, or silences the responders is a structural requirement of the design rather than an optional refinement. (Choice A) The starting segments cannot be curated to yield only foreign-fitting shapes, because whether something counts as foreign is defined relative to the individual carrying it, while essentially the same inherited segment pool is shuffled in everyone regardless of what that individual's own proteins look like. (Choice C) It is true that one person meets only a sliver of the binding surfaces their marrow generates, but economy is not the pressure that produced a self-directed screen. An unused cell costs almost nothing, whereas a single cell that attacks a working organ can cost the organ, so the screen is aimed at danger rather than at waste. (Choice D) Cells whose receptors turn out to be non-functional are indeed removed, but that outcome decides whether a cell can participate in a response at all, which is a separate question from whether it endangers the host, and it therefore does not explain why the check specifically probes reactivity toward the body itself. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the principle that recognition sites are assembled without reference to any target and to identify the consequence that sparing the host must be imposed as a separate, active step.

---

## B4-Q14 . Autoimmunity as Correct Machinery Wrong Target

**Stem.** A patient develops progressive destruction of the cartilage in several joints. Investigators recover from the inflamed tissue both lymphocytes and soluble products that lock onto a molecule normally present in that cartilage, and the patient clears ordinary infections no less well than healthy controls. Which observations would be expected if this disorder reflects intact recognition machinery aimed at the wrong target rather than a fault in the machinery itself?

I. The offending population arose by expansion of a few precursor cells that already carried the matching site before any damage appeared, as happens after a vaccine.
II. The attachment measured is as strong and as narrowly restricted as attachment seen in a successful response to a bacterium.
III. The host molecule had to be chemically altered into a foreign-like form first, because unaltered host structures cannot be attached at all.

- **A.** III only
- **B.** II only
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

Citations: AP:43127, MICRO:35171, AP:43805

**Distractors**

- **(A)** `misconception`: Rests on the false belief that host structures are inherently unbindable; sparing the host comes from removing the matching cells beforehand, not from any chemical immunity of host molecules, and this choice also discards two fitting observations.
  - Citation: MICRO:35171
- **(B)** `partial_truth`: Statement II is correct but incomplete; without statement I the answer never establishes that a small pre-existing population was selected and expanded in the normal way.
  - Citation: AP:43127
- **(D)** `process_step_confusion`: Inserts a chemical modification stage that the ordinary pathway does not require and that the recovered products contradict, since they attach to the molecule as the tissue presents it.
  - Citation: AP:43805

**Readback check.** The key text is a combination label, I and II only, and carries no content words at all, so no six-letter content word of the key can echo the stem. Checking the underlying statements instead: statement I turns on expansion from pre-existing precursors and statement II on strength and narrowness of attachment, neither of which is asserted anywhere in the scenario. The scenario supplies only the clinical findings and the normal infection handling, so the student must judge each statement against the premise rather than locate it in the text. The key is also not the longest or most detailed option, and every distractor is a defensible reading of at least one statement.

**Explanation (as shipped).**

> This Organ Systems item tests self versus nonself recognition by asking what an autoimmune disorder looks like at the level of the recognition event itself. The answer is C because statements I and II each describe the ordinary adaptive sequence running at full quality, with the only abnormality being the identity of what is bound. Clonal selection means any response starts from rare pre-existing cells whose sites already fit the target and finishes with a large descendant population, and that history is identical whether the fitted target sits on a bacterium or on a joint constituent, which makes statement I expected. Statement II follows from the same reasoning: the damage here is confined to tissues carrying one particular structure, and such confinement is only possible if attachment is tight and discriminating, so loose or promiscuous binding is the opposite of what the clinical picture implies. The normal handling of infections stated in the stem reinforces the interpretation, since a genuine defect in expansion, attachment, or killing would blunt protective responses as well. What has gone wrong is the earlier step that should have deleted or silenced cells bearing host-fitting sites, leaving an otherwise normal effector program pointed at the wrong address. (Choice A) Statement III fails on its own terms, because host structures are perfectly bindable; the chemical shapes displayed by the body's own molecules are no different in kind from those on a microbe, and it is only prior removal of the matching cells that ordinarily spares them. Choosing III alone also discards two observations that fit the premise. (Choice B) Statement II is correct, but stopping there omits the feature that most directly shows the response was assembled in the usual way. Without statement I, nothing in the answer establishes that a small pre-existing population was selected and expanded, which is the signature of an intact adaptive program rather than a random inflammatory accident. (Choice D) Adding statement III inserts a modification step that the normal pathway does not require and that the findings do not support, since the products recovered attach to the molecule as the cartilage actually presents it. This is a Scientific Reasoning and Problem Solving question because it asks the student to decide which experimental observations distinguish a correctly functioning recognition system misdirected at a host structure from a system whose components are themselves defective.

---

## B4-Q15 . Injury Exposing a Sequestered Body Constituent

**Stem.** A man sustains a crushing blow to one testis. Eight months later his blood contains lymphocytes and soluble products that lock onto components carried on the surface of his own sperm, and the untouched testis on the opposite side has become inflamed. Tight junctions between the supporting cells of the seminiferous tubules normally seal those components away from the circulation, and have done so since the organ was built. What does this sequence reveal about how the body comes to leave its own constituents alone?

- **A.** The blow destroyed the step that removes host-reactive cells, so reactions against many unrelated tissues should now follow.
- **B.** Microbes carried in by the wound are displayed alongside host fragments, and the reaction is aimed at the microbial portion while the tissue injury is incidental.
- **C.** The barrier normally holds the local number of responsive cells below the count needed for any reaction, and the injury pushed that number above threshold.
- **D.** Sparing of the body's own molecules is learned by exposing immature adaptive cells to whatever is accessible during a defined developmental window, so anything walled off then was never included and stays a legitimate target.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a), (c) and (d). (a) It requires combining two separate ideas: that unresponsiveness toward the host is imposed by screening immature cells during development, and that a physical barrier can exclude a tissue from that screening. (c) Choices A and C remain defensible until the student applies the specific discriminating facts that the uninjured contralateral organ was also attacked and that the recovered products bind the man's own sperm surface. (d) It inverts the usual direction of reasoning by supplying the outcome, an autoimmune response after trauma, and asking the student to infer what that outcome implies about the mechanism by which tolerance is established. |

**Correct answer (D): Sparing of the body's own molecules is learned by exposing immature adaptive cells to whatever is accessible during a defined developmental window, so anything walled off then was never included and stays a legitimate target.**

Citations: AP:55877, MICRO:35187, MICRO:32982

**Distractors**

- **(A)** `misconception`: A damaged screening apparatus would predict scattered reactivity against many tissues, not a response confined to one cell surface, and a local mechanical injury cannot reach the bone marrow and thymus where new cells are made and tested.
  - Citation: MICRO:32982
- **(B)** `adjacent_fact`: Wound contamination is a real phenomenon but not what these findings show; the recovered products bind the man's own sperm surface by direct measurement, and a wound-borne trigger cannot explain inflammation of the organ on the opposite side.
  - Citation: AP:55877
- **(C)** `scale_unit_error`: Substitutes a question of local cell numbers for a question of which targets are treated as belonging to the body; magnitude governs vigor, not acceptability, and circulating products seeking the untouched contralateral organ are not explained by a local threshold.
  - Citation: MICRO:35187

**Readback check.** Key content words of six or more letters: Sparing, molecules, learned, exposing, immature, adaptive, whatever, accessible, defined, developmental, window, anything, walled, included, legitimate, target. Stem content words of six or more letters: sustains, crushing, testis, months, blood, contains, lymphocytes, soluble, products, components, carried, surface, sperm, untouched, opposite, become, inflamed, junctions, between, supporting, seminiferous, tubules, normally, circulation, organ, built, sequence, reveal, constituents, alone. No overlap. The stem never mentions lymphocyte development or any screening window, so the key cannot be lifted from the text; the student must infer the developmental requirement from the fact that an enclosed structure provoked a response once exposed.

**Explanation (as shipped).**

> This Organ Systems item tests self versus nonself recognition by working backwards from an autoimmune outcome to what it reveals about how sparing of the host is acquired. The answer is D because sparing of the body's own molecules is learned by exposing immature adaptive cells to whatever is accessible during a defined developmental window, so anything walled off then was never included and stays a legitimate target. If nonreactivity were an intrinsic property of anything the genome encodes, no host structure could ever be attacked no matter how it was revealed. The findings say the opposite: a structure that was physically fenced off while the screening cells were maturing behaves exactly like foreign material the first time it reaches the circulation. Two details make this reading specific rather than merely plausible. The reaction follows a single mechanical breach with no further trauma, so it is the escape of previously enclosed material, and not ongoing injury, that set the response going. The reaction then damages the organ on the uninjured side, which shows the products are directed at the structure itself and travel to wherever that structure is found. (Choice A) A destroyed screening apparatus would leave newly made host-reactive cells surviving against constituents throughout the body, predicting scattered damage rather than a reaction confined to one class of cell surface, and a local mechanical injury has no route to alter the bone marrow and thymus, where new cells are made and tested. (Choice B) Material introduced through a wound could in principle be displayed, but the recovered products lock onto the man's own sperm surface, so the target is a host structure by direct measurement; treating the tissue damage as incidental cannot explain why an organ far from the wound became inflamed. (Choice C) This reduces a question about which targets are treated as acceptable to a question about how many cells are locally present. Numbers govern how vigorous a response is, not whether a structure counts as belonging to the body, and a purely local threshold cannot explain circulating products that seek out the organ on the side that was never struck. This is a Scientific Reasoning and Problem Solving question because it asks the student to infer, from an autoimmune response triggered by injury to an anatomically enclosed tissue, that unresponsiveness toward the host depends on exposure during development rather than on any built-in property of host molecules.

---

## B4-Q16 . Locating the Source of Tissue Damage

**Stem.** A person develops severe swelling and tissue damage within minutes of eating a purified plant protein and requires emergency treatment. The same protein at the same dose produces no measurable change in people who eat it routinely.

What accounts for the harm suffered by the affected person?

- **A.** The protein first tears open the tissue it contacts, and the swelling is the repair sequence arriving afterwards.
- **B.** The protein is toxic in itself, and the unaffected eaters simply take it up from the gut more slowly.
- **C.** The harm is inflicted by the host's own defensive machinery acting on the plant material, so its extent tracks the vigour of that individual's committed reaction rather than any destructive property of the food.  <- **KEY**
- **D.** Damage scales with the mass of protein swallowed, so a trace quantity could not produce injury on this scale.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): The harm is inflicted by the host's own defensive machinery acting on the plant material, so its extent tracks the vigour of that individual's committed reaction rather than any destructive property of the food.**

Citations: AP:43736; AP:43757; AP:43762; MICRO:34386; MICRO:34391

**Distractors**

- **(A)** `reversed_relationship`: It places the injury before the response and casts the swelling as repair, reversing the actual direction: the response is what generates the injury, and its onset within minutes is far too rapid for a repair sequence.
  - Citation: AP:43757
- **(B)** `misconception`: It keeps the cause inside the substance. Intrinsic toxicity would produce graded damage in the routine eaters as well, since a slower uptake rate delays harm rather than eliminating it, and those eaters show no change whatever.
  - Citation: MICRO:34386
- **(D)** `scale_unit_error`: Correct reasoning for a chemical poison but the wrong magnitude for a host-generated reaction, which amplifies a trace trigger into damage grossly out of proportion to the amount encountered.
  - Citation: AP:43762

**Readback check.** Key content words of six or more letters: inflicted, defensive, machinery, acting, material, extent, tracks, vigour, individual's, committed, reaction, destructive, property. Stem content words of six or more letters: person, develops, severe, swelling, tissue, damage, minutes, eating, purified, protein, requires, emergency, treatment, produces, measurable, change, people, routinely, accounts, affected, suffered. No word of six or more letters is shared between key and stem. An earlier draft used 'person's' in the key and was rewritten to "the host's" to avoid the shared root with 'person'; a later draft used 'response', which was changed to 'committed reaction' to keep the key free of any word that a reader could pair with the stem's outcome vocabulary.

**Explanation (as shipped).**

> Organ Systems, immune function: this item tests where the tissue damage in a reaction against a harmless environmental molecule actually originates. The answer is C because the identical molecule at the identical dose is harmless in most people, so the variable that decides whether injury occurs sits in the responder and not in the molecule. Adaptive defence works by recognising a shape and then committing effector machinery to whatever carries that shape. Nothing in that machinery evaluates whether the shape belongs to something dangerous; the specificity is for structure, not for threat. Once a lymphocyte population has been selected on an innocuous plant shape, meeting that shape again releases the same vessel-dilating, fluid-leaking, tissue-degrading effectors that would otherwise be aimed at a parasite. Severity therefore scales with how large and how easily triggered that person's committed population is, which is why one eater can be endangered by a quantity another eater never notices.
>
> (Choice A) reverses cause and effect. The swelling is not repair arriving after mechanical injury; it precedes the damage and produces it, and it appears within minutes, far too fast for a wound-healing sequence to have begun.
>
> (Choice B) keeps the cause inside the molecule. If the protein were intrinsically poisonous, a slower rate of uptake would shift the timing of harm but would not abolish it, so routine eaters should show graded damage. They show none at all.
>
> (Choice D) applies a sound idea at the wrong scale. Dose response holds for chemical toxicity, but a host-generated injury is amplified far beyond the trigger that starts it, so trace amounts can produce reactions wildly out of proportion to the mass encountered.
>
> This is a Scientific Reasoning and Problem Solving question because it asks you to locate the source of tissue damage by comparing two sets of people given the identical material and inferring that the causal variable lies in the responder rather than in the substance.

---

## B4-Q17 . Reading a Prior Contact Patch Panel

**Stem.** Substance X and unrelated substance Z are innocuous plant extracts. Four matched groups of volunteers each received one skin patch, and the width of the raised skin area was recorded over four days. Group 4 received a dilute acid instead of a plant extract, as a positive comparison. Widths are in millimetres.

| Group | Skin exposure 3 weeks before | Patch now | 4 h | 24 h | 48 h | 96 h |
|---|---|---|---|---|---|---|
| 1 | none | X | 0 | 0 | 0 | 0 |
| 2 | X | X | 0 | 6 | 14 | 5 |
| 3 | X | Z | 0 | 0 | 0 | 0 |
| 4 | none | dilute acid | 13 | 9 | 3 | 0 |

Which conclusion do these results support?

- **A.** The group 2 injury is generated after the patch by a mobilised host population whose reactivity is confined to the material that individual met previously, whereas the group 4 injury is done by the acid itself.  <- **KEY**
- **B.** Volunteers in group 2 are generally more fragile to chemical injury of the skin than volunteers in group 1.
- **C.** The delay in group 2 shows that X must build up locally over roughly a day before it reaches a damaging level.
- **D.** Group 4 confirms that a patch can injure skin with no prior exposure, so prior exposure is not required for skin injury.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 4 |
| Hard-tier gate | Meets (b), (c) and (d). (b) The key requires a directional inference about the shape of two time courses, early peak versus late peak, not a value read off the table. (c) Choices B and C are both defensible until group 3 and group 1 are specifically applied. (d) The student is given the outcome pattern and must infer which agent produced each injury. |

**Correct answer (A): The group 2 injury is generated after the patch by a mobilised host population whose reactivity is confined to the material that individual met previously, whereas the group 4 injury is done by the acid itself.**

Citations: MICRO:34916; MICRO:34921; MICRO:34926; AP:43787; AP:43791; AP:43799

**Distractors**

- **(B)** `misconception`: A general increase in fragility would mark group 2 with the unrelated extract as well, and group 3 recorded zero at every time point, so the acquired property is specific rather than generic.
  - Citation: MICRO:34921
- **(C)** `adjacent_fact`: Local accumulation to a toxic threshold is a genuine chemical idea from a neighbouring domain, but group 1 received the same patch of X for the same period and never marked, and group 3 was spared as well, so build-up of the substance cannot be what the delay reflects.
  - Citation: AP:43791
- **(D)** `partial_truth`: True as far as it goes but it answers about the acid arm only and leaves untouched the question of why group 2 marked and group 1 did not.
  - Citation: AP:43787

**Readback check.** Key content words of six or more letters: injury, generated, mobilised, population, reactivity, confined, material, individual, previously, whereas. Stem content words of six or more letters: Substance, unrelated, innocuous, extracts, matched, groups, volunteers, received, exposure, before, recorded, positive, comparison, dilute, millimetres, conclusion, results, support. No word of six or more letters is shared between key and stem. An earlier draft used 'extract' in the key and was rewritten to 'material' to avoid the shared root with 'extracts'.

**Explanation (as shipped).**

> Organ Systems, immune function: this item tests reading a four-arm patch panel to decide whether an injury was inflicted by the applied agent or manufactured by the host. The answer is A because the shapes of the two time courses and the two negative arms point the same way. Group 4 shows what direct chemical injury looks like: maximal at four hours and shrinking from then on, because the harm is done at the moment of contact and the body then repairs it. Group 2 shows the opposite profile, nothing at four hours, climbing to a peak at 48 hours and only then receding, which is the signature of an injury that has to be built after the fact by cells that must be summoned and must arrive. Group 1 shows that X is harmless to skin meeting it for the first time, so nothing about the material is intrinsically damaging. Group 3 is the decisive arm: the same primed volunteers are untouched by an unrelated extract, so what they gained from the earlier exposure is not a general vulnerability but a commitment to one structure, which is the defining behaviour of a clonally selected population.
>
> (Choice B) is refuted by group 3. If those volunteers had simply become more fragile, an unrelated patch would mark them too, and Z produced nothing at any time point.
>
> (Choice C) borrows a real pharmacological idea and applies it where the data exclude it. Local accumulation to a toxic level would also occur in group 1, which received the same patch of X for the same period and never marked at all, and accumulation of X would not spare group 3 either.
>
> (Choice D) states something true that does not bear on the question. Nobody disputes that a caustic agent injures naive skin; the acid arm is there to supply a contrasting time course, and it cannot explain why group 2 marked while group 1 did not.
>
> This is a Data-based and Statistical Reasoning question because it asks you to compare the shapes of two time courses and use the two null arms to decide which of the recorded injuries was manufactured by the host rather than by the applied agent.

---

## B4-Q18 . Separating Irritant Injury from Host Response

**Stem.** A worker on a production line forms a red, hardened plaque on the wrist about two days after each shift in which a new solvent touches the skin. Two accounts are on the table: the solvent injures skin directly at the strength used on the line, or the worker's own defence has been mobilised against it. Investigators may run one further test.

Which test would separate the two accounts?

- **A.** Apply a tenfold stronger solution to the worker's other wrist and confirm that the plaque is bigger.
- **B.** Record whether washing the wrist within one minute of contact shortens how long the plaque lasts.
- **C.** Apply the solvent to the worker's back and confirm that a plaque forms there as well.
- **D.** Patch a panel of people who have never met it, at the dose used on the line, and count how many of them form a comparable skin lesion.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (D): Patch a panel of people who have never met it, at the dose used on the line, and count how many of them form a comparable skin lesion.**

Citations: AP:43787; AP:43799; AP:43800; MICRO:34921; MICRO:34926

**Distractors**

- **(A)** `misconception`: It assumes dose dependence is unique to chemical injury. Both a burn and a host-generated reaction grow with dose, so a larger mark at a larger dose is consistent with either account.
  - Citation: AP:43799
- **(B)** `adjacent_fact`: Washing time is a true determinant of how much material enters the skin, but it changes the size of a burn and of a host reaction in the same direction, so it speaks to exposure rather than to mechanism.
  - Citation: MICRO:34926
- **(C)** `partial_truth`: It correctly rules out something peculiar to the wrist, but both accounts already predict a mark at any adequately dosed site, so the comparison leaves the two hypotheses exactly where they were.
  - Citation: AP:43800

**Readback check.** Key content words of six or more letters: people, comparable, lesion. Stem content words of six or more letters: worker, production, hardened, plaque, solvent, touches, accounts, injures, directly, strength, defence, mobilised, against, Investigators, further, separate. No word of six or more letters is shared between key and stem. Earlier drafts of the key used 'compound', 'concentration', 'develops' and 'thickened'; each was replaced because the same word or its root sat in the stem.

**Explanation (as shipped).**

> Organ Systems, immune function: this item tests the design of a comparison that separates a host-generated skin reaction from direct chemical injury. The answer is D because the two accounts make sharply different predictions about people meeting the material for the very first time. A caustic agent damages whatever it touches, so if the strength used on the line is enough to burn this worker's skin, it will burn most first-time skin too, and the rate in a fresh panel will be high. A host-generated reaction requires that a responding population already be present and enlarged, and that only follows an earlier meeting, so the rate in a fresh panel will be close to zero. The rate among first-time subjects is therefore the one variable whose expected value differs between the hypotheses, which is exactly what a discriminating test needs. Everything else about the two accounts, the look of the mark, its size and where it sits, is predicted equally well by both, which is why the remaining options cannot decide anything.
>
> (Choice A) A bigger dose gives a bigger mark under either account. Chemical burns are dose dependent, and host-generated reactions are dose dependent as well, so a stronger solution confirms only that more material does more, not what turned the material into an injury.
>
> (Choice B) Cutting the contact time reduces the amount that gets into the skin, and that shrinks a burn and a host reaction alike. This measures exposure, not mechanism.
>
> (Choice C) Testing a second body site establishes only that the responsiveness is not peculiar to the wrist. Both accounts predict a mark wherever an adequate dose is applied, so the outcome is uninformative either way.
>
> This is a Reasoning about the Design and Execution of Research question because it asks you to choose the single comparison group whose expected result differs between a direct-injury explanation and a host-response explanation of the same skin finding.

---

## B4-Q19 . Localising Transferable Reactivity to a Blood Fraction

**Stem.** An office worker forms a firm red patch on the waist two days after each day spent wearing a nickel-plated belt buckle, while a person who has never worn one shows nothing after the same contact. Investigators suspect the capacity to react is carried by something in the circulation and could be handed on to another individual. They may draw and separate a sample of that circulating material from the affected worker, and may apply nickel to the skin of consenting first-time subjects.

Which design would establish which part of the separated sample carries the capacity to react?

- **A.** Give one matched first-time host the unseparated material and apply nickel; a reaction proves that the capacity travels.
- **B.** Divide the blood into a washed white cell fraction and a cell free plasma fraction, deliver each fraction to its own matched naive volunteer, and then patch both volunteers.  <- **KEY**
- **C.** Return the separated plasma to the affected worker herself and re-apply nickel to her skin.
- **D.** Measure how much nickel is present in the plasma of the affected worker at the time the patch appears.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Meets (a) and (c). (a) It combines a design principle, isolating one variable per arm, with the immunological requirement that the readout host start without the acquired reactivity, and the reader must hold both at once. (c) Choices A and C are defensible until the specific demand that the design must localise the carrier rather than merely demonstrate transfer is applied. |

**Correct answer (B): Divide the blood into a washed white cell fraction and a cell free plasma fraction, deliver each fraction to its own matched naive volunteer, and then patch both volunteers.**

Citations: MICRO:33562; MICRO:34916; MICRO:34921; AP:43787; AP:43788; AP:43799

**Distractors**

- **(A)** `partial_truth`: It correctly demonstrates that the capacity is transferable but delivers both candidate carriers together, so it cannot attribute the capacity to either one and does not answer the question asked.
  - Citation: MICRO:33562
- **(C)** `process_step_confusion`: It returns the fluid to the original reactor rather than to an untreated host, swapping donor and recipient roles so that a positive result is uninterpretable and no baseline exists.
  - Citation: MICRO:33562
- **(D)** `adjacent_fact`: It measures where the trigger goes, which is a real quantity, but says nothing about which circulating component confers the ability to react and creates no host in which transfer could be observed.
  - Citation: MICRO:34916

**Readback check.** Key content words of six or more letters: Divide, washed, fraction, deliver, matched, plasma, volunteer, volunteers. Stem content words of six or more letters: office, worker, wearing, nickel-plated, buckle, person, nothing, contact, Investigators, suspect, capacity, carried, something, circulation, handed, another, individual, separate, sample, circulating, material, affected, consenting, subjects, design, establish, separated, carries. No word of six or more letters is shared between key and stem. An earlier draft of the key used 'sample' and 'separate'; both were replaced ('blood', 'Divide') because they appear in the stem, and the stem's original 'volunteers' was changed to 'subjects' so that the key's 'volunteer' has no echo. The scenario was also moved off the industrial-solvent setting used by the preceding item so that the two stems do not read as the same case.

**Explanation (as shipped).**

> Organ Systems, immune function: this item tests the design of a transfer experiment that assigns an acquired reactivity to one component of the circulation. The answer is B because pinning reactivity on a particular carrier requires that the candidate carriers be delivered separately, into separate untreated hosts, and read out the same way. Splitting into a washed cell portion and a fluid portion creates two arms differing in exactly one thing, which portion the host received, so a mark in one arm and not the other assigns the capacity to that portion. Washing the cells matters because it strips carryover fluid, so a positive cell arm cannot be dismissed as fluid contamination riding along. First-time hosts matter because a host that already reacts cannot demonstrate that anything was conferred on it. Delayed skin reactions of this kind in fact travel with lymphocytes rather than with the fluid phase, which is why the two arms behave differently, but the design is selectable without knowing that result in advance.
>
> (Choice A) Unseparated material does establish that the capacity is transferable at all, which is a real and useful result, but it delivers both candidate carriers at once and therefore cannot say which of them is responsible. It answers the earlier question rather than this one.
>
> (Choice C) Returning fluid to the person it came from swaps the stages of the experiment. That person already reacts, so a mark there shows nothing was conferred, and the comparison contains no untreated host at all.
>
> (Choice D) Measuring how much trigger is circulating describes the distribution of the metal, not the location of the capacity to react. A transfer claim needs a host that acquires the capacity, and this measurement never produces one.
>
> This is a Reasoning about the Design and Execution of Research question because it asks you to construct a fractionation and transfer scheme in which the arms differ by exactly one candidate carrier and every readout host begins without the reactivity under test.

---

## B4-Q20 . Infection Pattern Pointing to One Arm

**Stem.** A three year old has had eight episodes of pus forming bacterial disease of the middle ear and soft tissue, all caused by organisms that grow outside host cells, yet cleared chickenpox, measles and two further viral illnesses on an ordinary schedule. Engulfing white cell counts and overall marrow output are within reference limits. Which missing element best accounts for this history?

- **A.** The thymus schooled lineage that inspects fragments shown on the surfaces of other cells and destroys those carrying foreign ones
- **B.** The lineage whose members, once chosen by a matching encounter, export copies of their own recognition molecule into the blood  <- **KEY**
- **C.** The cells that engulf foreign material and hold pieces of it out on their surfaces for both adaptive lineages to inspect
- **D.** The maturation screens that discard lymphocytes reacting strongly against the body's own molecules

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (B): The lineage whose members, once chosen by a matching encounter, export copies of their own recognition molecule into the blood**

Citations: MICRO:35683; MICRO:35686; AP:43040

**Distractors**

- **(A)** `reversed_relationship` . _mirror-image deficiency_: Names the arm that is evidently working. Loss of the cell inspecting lineage would predict the opposite history, prolonged viral illness with relative competence against organisms in tissue fluid.
  - Citation: AP:43040
- **(C)** `partial_truth` . _upstream shared step offered for a one-sided deficit_: Correctly explains the bacterial half of the history, but a failure at the shared display step would also cripple the antiviral response, which is preserved here.
  - Citation: AP:42995
- **(D)** `adjacent_fact` . _tolerance mechanism imported into an infection question_: A true statement about how tolerance is established, but its failure produces attack on the body's own tissues rather than recurrent infection by one organism class.
  - Citation: AP:43107

**Readback check.** Content words of six or more letters in key B: lineage, members, chosen, matching, encounter, export, copies, recognition, molecule. Six-plus letter words in the stem: episodes, forming, bacterial, disease, middle, tissue, caused, organisms, outside, cleared, chickenpox, measles, further, illnesses, ordinary, schedule, engulfing, counts, overall, marrow, output, within, reference, limits, missing, element, accounts, history. No overlap. The word lineage appears in choices A, B and D, so it is not a distinctive key marker. The stem never states which compartment either arm reaches, so the key cannot be produced by restatement. Banned patterns checked: no choice repeats a stem phrase, no choice is a definitional echo of a stem term, no numeric value is carried over, no synonym pair links stem to key, and the key is not the only choice sharing the stem's register.

**Explanation (as shipped).**

> Organ Systems: this item asks you to reason from a pattern of infections back to the adaptive element that is absent. The answer is B because organisms replicating in the fluid outside host cells are reached by exported recognition molecules, and only the lineage that secretes copies of its own surface receptor can supply them. Adaptive defence runs as two parallel outputs from a shared beginning. One output is a soluble molecule released into plasma and interstitial fluid, where it can reach anything sitting outside a cell; the other acts only on cells that exhibit fragments on their surface, which is exactly what an infected cell does. A child who repeatedly loses ground to pus forming organisms living outside cells, yet clears chickenpox and measles on time, has an intact contact dependent output and a missing soluble one. The history is informative precisely because the two outputs reach different physical compartments.
>
> (Choice A) The lineage that examines the surfaces of other cells and kills those exhibiting foreign fragments is the one that clears viral disease. Had it failed, the history would run the other way: trouble with the viral illnesses and comparative competence against organisms in tissue fluid.
>
> (Choice C) A failure of the cells that take up foreign material and hold pieces of it out would indeed compromise defence against bacteria, but it would compromise the antiviral response as well, since both outputs are launched from that upstream display step. Recovery from four viral illnesses on schedule rules it out, and the normal engulfing cell count offers it no support either.
>
> (Choice D) Losing the screens that remove strongly self reactive cells produces attack on the body's own tissues, not an infectious history. That failure changes what the repertoire is aimed at, not whether the repertoire can be deployed against foreign organisms.
>
> This is a Scientific Reasoning and Problem Solving question because it supplies an outcome, a selective vulnerability to organisms in one physical compartment, and asks you to work backwards to the single element whose absence produces exactly that selectivity and no more.

---

## B4-Q21 . Localising a Block Upstream of Lymphocytes

**Stem.** Laboratory testing on a young child shows that neither virus infected targets are killed nor the soluble molecules that neutralise bacteria growing in tissue fluid are released. Cells of both adaptive lineages circulate in normal numbers and carry structurally diverse surface receptors, and marrow output is unremarkable. An investigator suspects the block lies upstream of those lineages rather than within them. Which experiment would best localise the failure?

- **A.** Sample blood for neutralising molecules before and two weeks after deliberate exposure to a harmless marker substance, testing a healthy donor the same way for comparison
- **B.** Incubate the child's lymphocytes with a purified marker substance and no other cell type, then measure the expansion of each lineage against a healthy donor's lymphocytes treated identically
- **C.** Culture the child's lymphocytes with a healthy donor's ingesting and displaying cells, and separately culture healthy donor lymphocytes with the child's ingesting and displaying cells, giving both the same marker substance  <- **KEY**
- **D.** Feed labelled bacteria to the child's ingesting cells and to a healthy donor's cells, then count the particles taken up by each population and compare the totals

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines antigen presentation with the two-arm architecture of adaptive defence; (c) choices B and D are both defensible until the student applies the specific requirement that the readout must compare a suspect population against a known good partner, and choice A now carries a healthy comparison subject so it cannot be dismissed for lacking a control; (d) the reasoning runs from an observed outcome, total adaptive failure with intact lymphocyte numbers, back to the cell responsible. |

**Correct answer (C): Culture the child's lymphocytes with a healthy donor's ingesting and displaying cells, and separately culture healthy donor lymphocytes with the child's ingesting and displaying cells, giving both the same marker substance**

Citations: AP:42995; AP:43050; MICRO:35705; AP:43684

**Distractors**

- **(A)** `adjacent_fact` . _endpoint assay offered as a localisation experiment_: A valid measurement of one arm's output against a healthy comparison, but it only re-demonstrates the known failure and contains no substitution capable of localising the defective cell type.
  - Citation: MICRO:35705
- **(B)** `misconception` . _free antigen suffices_: Assumes lymphocytes can be triggered by free material with no presenting partner, which removes the interaction being investigated.
  - Citation: AP:42993
- **(D)** `process_step_confusion` . _earlier step substituted for the step in question_: Tests uptake, the stage before display; normal ingestion is compatible with complete failure at the later loading and exhibition step.
  - Citation: AP:43024

**Readback check.** Content words of six or more letters in key C: culture, lymphocytes, healthy, donor, separately, ingesting, displaying, giving, marker, substance. Six-plus letter words in the stem: Laboratory, testing, infected, targets, killed, soluble, molecules, neutralise, bacteria, growing, tissue, released, adaptive, lineages, circulate, normal, numbers, structurally, diverse, surface, receptors, marrow, output, unremarkable, investigator, suspects, upstream, within, experiment, localise, failure. No overlap. The stem deliberately says lineages rather than lymphocytes and never uses display, ingest or foreign, so the key cannot be matched to the stem by shared vocabulary; the discriminating idea, reciprocal substitution of one partner at a time, appears nowhere in the stem. All four choices now name a healthy donor comparison and run to comparable length, so neither a control cue nor a length cue selects the key.

**Explanation (as shipped).**

> Organ Systems: this item tests reasoning about how to assign an adaptive failure to the presenting step rather than to the responding cells. The answer is C because only a reciprocal pairing, in which each partner is tested once against a known good counterpart, can reveal which of two interacting populations carries the fault. When both adaptive outputs are absent while the responding cells are present in normal numbers with a diverse receptor set, the economical explanation is that a step both outputs share has been lost. That shared step is the handing over of fragments by cells that take up foreign matter, since the contact dependent output cannot begin without a fragment held out on a surface and the soluble output against protein targets is licensed through that same display. A single culture cannot separate a broken presenter from a broken responder, because a null result is compatible with either. Swapping one partner at a time converts that null result into an assignment, since the response returns in whichever pairing replaces the faulty population.
>
> (Choice A) Sampling the blood before and after exposure documents that one output is missing, which the history already established. Adding a healthy comparison subject calibrates the size of the failure but still measures only the endpoint of the pathway, so it says nothing about which cell within the pathway is at fault.
>
> (Choice B) Offering purified material to the responding cells alone removes the very interaction under investigation. Nothing is learned about the presenter when the presenter has been left out of the vessel, and the lineage that acts on displayed fragments cannot respond to free material in any case.
>
> (Choice D) Counting particles taken up probes uptake, an earlier and separable stage. A cell can ingest normally and still fail at the later job of loading fragments and exhibiting them on its surface, so a normal uptake count would leave the hypothesis untouched.
>
> This is a Reasoning about the Design and Execution of Research question because it asks you to choose the arrangement of experimental arms that assigns a defect to one of two interacting cell populations rather than merely confirming that the defect exists.

---

## B4-Q22 . Assigning Deficiency Patterns to Immune Arms

**Stem.** The table gives the mean number of infections per year in four unrelated people, grouped by the class of organism recovered. Person Z has no known immune defect and is included for comparison.

| Person | Pus forming bacteria multiplying in tissue fluid | Prolonged or recurrent viral illness | Deep fungal and yeast disease |
| --- | --- | --- | --- |
| W | 9.0 | 0.4 | 0.0 |
| X | 1.1 | 7.0 | 5.2 |
| Y | 10.2 | 8.1 | 6.0 |
| Z | 1.0 | 0.5 | 0.0 |

Which of the following readings of W, X and Y are supported?

I. W's ordinary rate in the second and third columns argues against loss of a step that both arms depend on.
II. In X, the arm that acts on cells exhibiting fragments of proteins made inside them is the one that has failed.
III. Y's row can be produced by loss of a single element that both arms require, without invoking two separate lineage failures.

- **A.** I only
- **B.** II only
- **C.** I and II only
- **D.** I, II, and III  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (D): I, II, and III**

Citations: MICRO:35684; MICRO:35686; MICRO:35705; AP:43684

**Distractors**

- **(A)** `partial_truth` . _interprets only the cleanest row_: Reading I is correct, but the same comparative logic applied to X's two raised columns supports reading II just as firmly, so stopping at one row is incomplete.
  - Citation: MICRO:35686
- **(B)** `misconception` . _treats normal values as carrying no evidence_: Treats an ordinary rate in a column as uninformative, when a rate matching the unaffected person is exactly what excludes a shared upstream failure in W.
  - Citation: MICRO:35684
- **(C)** `process_step_confusion` . _places a shared failure at the wrong stage of the pathway_: Assigns Y's across the board susceptibility to two independent late lineage failures rather than to the single earlier step that both arms require.
  - Citation: AP:42995

**Readback check.** The key text is I, II, and III and contains no content words at all, so no six letter word can be shared with the stem. Checking the numeral statements instead: ordinary, second, third, column, argues, against, depend, exhibiting, fragments, proteins, inside, single, element, require, invoking, separate, lineage, failures. The stem and table use infections, unrelated, people, grouped, organism, recovered, person, immune, defect, included, comparison, forming, bacteria, multiplying, tissue, fluid, prolonged, recurrent, illness, fungal, disease, supported. The overlaps are confined to table headings that every numeral statement must refer to, and no key-selecting word is shared. Rule four is satisfied because no choice is a value read off the table; every reading requires comparison against the unaffected row and an inference about which compartment each organism class occupies.

**Explanation (as shipped).**

> Organ Systems: this item tests whether a table of infection frequencies can be read as evidence about which arm of adaptive defence is missing. The answer is D because all three readings survive comparison with the unaffected row. W matches the unaffected person in the viral and fungal columns, and a lost step feeding both arms would have raised those columns too, so reading I holds. X shows a bacterial rate matching the unaffected person alongside prolonged viral episodes and deep fungal disease, which implicates the output that acts on cells holding out fragments of what they are making internally, so reading II holds. Y is raised in every column, and because both outputs are launched from the same upstream handover of fragments, one lost step accounts for the whole row without postulating two rare failures at once, so reading III holds. The unaffected person matters throughout: without that row, a rate of 1.1 bacterial episodes per year in X might be misread as mild susceptibility rather than as ordinary.
>
> (Choice A) Stopping at reading I treats only W's row as interpretable. X departs from the unaffected person in two columns, one by more than tenfold and one in which the unaffected person records no episodes at all, which is at least as much signal as W supplies.
>
> (Choice B) Taking reading II alone implies that W's normal viral and fungal rates carry no information. They carry a great deal, because they exclude the very shared step whose loss would have raised every column, which is what reading I asserts.
>
> (Choice C) Accepting I and II while rejecting III places Y's trouble at two separate late steps. The architecture makes that unnecessary, because a single earlier step feeds both outputs, and the simpler account is preferred when the data do not distinguish them.
>
> This is a Data-based and Statistical Reasoning question because it requires comparing each affected row against an unaffected reference across three organism classes and converting the resulting pattern of differences into an assignment of the missing element.

---

