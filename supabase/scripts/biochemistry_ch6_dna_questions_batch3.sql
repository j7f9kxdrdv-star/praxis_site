-- Biochemistry Chapter 6: DNA and Biotechnology, standalone questions
-- BATCH 3 of 3 (24 questions), CHAPTER COMPLETE at 72: the rest of Unit 4 repair (NER with
--   thymine dimers and XP, BER with cytosine deamination and the why-thymine inference, repeat
--   expansion) + all of Unit 5 biotechnology (restriction enzymes and restriction-modification,
--   cloning vectors and transform-and-select, libraries and cDNA, PCR logic and arithmetic,
--   agarose gels, Southern and the blot family, dideoxy sequencing, knockouts).
--
-- PURE INSERTs: run AFTER batches 1 and 2 (batch 1 owns the chapter DELETE).
-- Boundary rules honoured: zero cancer keys (XP appears as scenery, keys stay mechanistic);
-- gels key the DNA size-sieving lane only (protein gels are Biochem Ch3's); blots keyed on
-- target discrimination, never antibody mechanics; no mutation-type-classification keys.
-- Editorial trims vs the plan, recorded honestly: gene-therapy standalone dropped, restriction
-- and NER each compressed by one; replication (Unit 3) ran two heavier in batch 2.

BEGIN;

-- B3 Q1 . helix distortion pathway routing . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$helix distortion pathway routing$q$,
    $q$In a cultured human cell, ultraviolet light covalently joins two adjacent thymines on one strand, and elsewhere on the same chromosome spontaneous deamination converts a cytosine into a base normally found only in RNA. Both lesions are corrected before the next S phase. Which feature of the ultraviolet lesion directs it into nucleotide excision repair rather than into the pathway that corrects the second lesion?$q$,
    $q$[{"label":"A","text":"The joined thymines are detected as mismatched bases by a glycosylase that scans for incorrect pairing."},{"label":"B","text":"The joined thymines are released as a single free base, leaving an abasic site that is nicked and refilled."},{"label":"C","text":"The joined thymines are recognized only after they stall a replication fork during S phase."},{"label":"D","text":"The joined thymines bend the double helix, and the repair machinery recognizes that structural distortion rather than any specific base."}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests lesion to pathway matching in DNA repair, specifically why bulky ultraviolet damage is handled by nucleotide excision repair while a single incorrect base is handled by base excision repair. The answer is D because covalently linking two adjacent thymines creates a rigid lesion that bends and unwinds the double helix, and the nucleotide excision repair machinery patrols the genome for exactly this kind of structural distortion rather than for any specific wrong base. Once the distortion is bound, endonucleases nick the damaged strand on the 5' and 3' sides of the lesion, an oligonucleotide patch containing the dimer is released, and DNA polymerase fills the gap using the undamaged strand as template before ligase seals the final nick. A lone uracil, in contrast, barely perturbs helix geometry; it is located by a dedicated glycosylase that inspects individual bases, which commits that lesion to base excision repair. The routing decision therefore comes down to overall helix shape versus a single chemically incorrect base. (Choice A) The dimer does not create a mispaired base for a scanning enzyme to find; both thymines remain on the same strand opposite their adenines, and glycosylases in any case initiate base excision repair, the pathway serving the uracil lesion. (Choice B) Release of one free base to leave an abasic site that is then nicked and refilled is the base excision sequence; two covalently joined thymines cannot leave as a single free base and must instead be excised within a longer single stranded segment. (Choice C) Bulky lesions can stall a replication fork, but nucleotide excision repair does not require a stalled fork to act; the stem specifies that both lesions were corrected before the next S phase, so recognition happened on nonreplicating DNA. This is a Scientific Reasoning and Problem Solving question because it asks you to connect the structural consequence of a covalent pyrimidine crosslink to the recognition logic that routes a lesion into one repair pathway rather than another.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q;

-- B3 Q2 . xeroderma repair synthesis assay . medium . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$xeroderma repair synthesis assay$q$,
    $q$Skin fibroblasts from a patient with xeroderma pigmentosum and from a healthy donor receive identical doses of ultraviolet light and are then incubated with labeled nucleotides while prevented from entering S phase. The healthy cells incorporate substantial label into their DNA, but the patient cells incorporate almost none. Which deficiency in the patient cells best accounts for this result?$q$,
    $q$[{"label":"A","text":"Loss of the glycosylase that removes uracil, so uracil residues persist in the DNA without being excised"},{"label":"B","text":"Inability to excise the helix distorting photoproducts, so no single stranded gaps are generated for a polymerase to fill"},{"label":"C","text":"Failure to form pyrimidine photoproducts upon irradiation, so no substrate for repair ever appears"},{"label":"D","text":"A replicative polymerase that cannot use labeled nucleotides as substrates during genome duplication"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the repair defect underlying xeroderma pigmentosum and how a repair synthesis assay reports nucleotide excision repair activity. The answer is B because label incorporated outside of S phase can only come from repair patches: nucleotide excision repair must first cut out an oligonucleotide spanning the ultraviolet induced pyrimidine lesion, and the resulting single stranded gap is what DNA polymerase fills with labeled nucleotides before ligase seals the nick. Healthy cells excise the helix distorting dimers and therefore show gap filling label; xeroderma pigmentosum cells carry defective excision machinery, so no patch is removed, no gap exists, and essentially no label appears even though the lesions are present in their DNA. The assay therefore localizes the defect to the excision capability itself rather than to lesion formation or to replication. This same failure to remove dimers is why patients are extremely sensitive to sunlight, with damage accumulating in skin cell DNA at every exposure. (Choice A) Uracil arises from cytosine deamination and is handled by a glycosylase in base excision repair; ultraviolet light instead crosslinks adjacent pyrimidines, so a uracil glycosylase defect would not explain the missing repair synthesis after irradiation. (Choice C) Dimer formation is a direct photochemical reaction between adjacent pyrimidines and requires no cellular enzyme, so patient cells form photoproducts just as readily as healthy cells; what they lack is the ability to remove them. (Choice D) The measurement deliberately excludes S phase synthesis, and replication is intact in these patients; a polymerase unable to use nucleotide substrates would be lethal in all cells rather than producing an ultraviolet specific repair deficit. This is a Reasoning about the Design and Execution of Research question because it asks you to interpret what a non S phase labeling readout measures and to infer which repair capability must be absent when that signal disappears.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    3,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B3 Q3 . deaminated cytosine repair steps . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$deaminated cytosine repair steps$q$,
    $q$In a nondividing cell, a cytosine residue in genomic DNA spontaneously loses its exocyclic amine group through hydrolysis. Which of the following events must occur for this position to be restored to its original state?

I. An enzyme cleaves the bond linking the altered base to its deoxyribose
II. The sugar phosphate backbone is cut at the site left without a base
III. An endonuclease removes an oligonucleotide segment spanning nucleotides on both sides of the lesion$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"III only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests the ordered steps of base excision repair following spontaneous cytosine damage. The answer is C because loss of cytosine's exocyclic amine is a hydrolytic deamination that converts the base to uracil, a base that does not belong in DNA. Restoration begins when uracil DNA glycosylase cleaves the glycosidic bond between the wrong base and its deoxyribose, so statement I is required. That leaves an abasic site with an intact backbone; before a polymerase can install the correct nucleotide, the sugar phosphate backbone at the baseless position must be nicked to create a usable end, so statement II is also required. The small gap is then filled with a cytosine bearing nucleotide and the strand is sealed by ligase. This base first, backbone second order is the signature of base excision repair. Statement III instead describes excision of a multinucleotide patch flanking the lesion, which is the strategy nucleotide excision repair applies to bulky helix distorting damage; a single uracil is handled base by base, so III is not part of this pathway. (Choice A) Statement I alone is insufficient: removing the base leaves an abasic site with a continuous backbone, and no polymerase can insert the replacement nucleotide until the backbone is opened at that position. (Choice B) Statement III belongs to nucleotide excision repair; selecting it alone applies the pathway used for lesions such as pyrimidine dimers and omits both true steps of the base excision route. (Choice D) Adding statement III wrongly imports the oligonucleotide patch step of nucleotide excision repair into a pathway that excises only the single damaged base before nicking and filling. This is a Scientific Reasoning and Problem Solving question because it asks you to identify the chemical lesion from a description of the reaction and then reason through which mechanistic steps its dedicated repair pathway does and does not include.$q$,
    'easy',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B3 Q4 . thymine damage discrimination rationale . hard . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$thymine damage discrimination rationale$q$,
    $q$Consider a hypothetical organism whose double stranded DNA genome pairs adenine with uracil, using no thymine at all. In one of its cells, an ordinary cytosine residue undergoes spontaneous hydrolytic deamination shortly before the genome is replicated. Compared with a thymine containing genome, what problem does this event create for the organism's repair systems?$q$,
    $q$[{"label":"A","text":"The damaged position is chemically indistinguishable from correctly encoded bases, so the change escapes recognition and becomes a permanent mutation after replication."},{"label":"B","text":"The altered base pairs so tightly with adenine that the replication fork stalls at the damaged position."},{"label":"C","text":"A uracil removing glycosylase excises bases throughout the genome, fragmenting it at every normal adenine uracil pair."},{"label":"D","text":"The altered base is thymine, producing a thymine guanine mispair that the mismatch repair system corrects."}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests the chemical logic of why DNA encodes thymine rather than uracil. The answer is A because spontaneous hydrolytic deamination of cytosine produces uracil. In a genome where uracil is a legitimate information carrying base paired with adenine, a uracil created by deamination is chemically identical to every correctly encoded uracil, so no surveillance enzyme could mark it as damage. The lesion then behaves as uracil at the replication fork and templates adenine, converting the original guanine cytosine pair into an adenine uracil pair in a daughter genome, at which point the change is permanent. Real DNA solves this problem by methylating the uracil scaffold to make thymine: because every legitimate T carries the methyl group, any unmethylated uracil found in DNA is guaranteed to be damage, and uracil DNA glycosylase can remove every uracil it encounters without ever destroying encoded information. The hypothetical genome sacrifices exactly that unambiguous damage flag. (Choice B) An adenine uracil pair forms the same two hydrogen bonds as an adenine thymine pair, since the methyl group does not participate in pairing; the fork proceeds normally through such a pair rather than stalling. (Choice C) This describes a real cell's glycosylase transplanted into the hypothetical organism, but a uracil using organism could not maintain such an activity in the first place, because it would attack normal encoded bases; the organism's actual problem is that it must lack this surveillance entirely, leaving deamination invisible. (Choice D) Deamination of 5 methylcytosine does yield thymine and a thymine guanine mispair, but the stem specifies an ordinary cytosine, whose deamination product is uracil, not thymine. This is a Scientific Reasoning and Problem Solving question because it asks you to reason from the chemistry of cytosine deamination to the counterfactual consequence for damage recognition in a genome that uses uracil as a native base.$q$,
    'hard',
    '5D',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B3 Q5 . repeat tract intergenerational expansion . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$repeat tract intergenerational expansion$q$,
    $q$A man carries one disease associated allele containing 44 consecutive CAG units and one common allele containing 18 units at the locus associated with Huntington disease. Genotyping of his four children shows that three inherited the long allele with tract lengths of 48, 61, and 79 units, while the fourth inherited the short allele with exactly 18 units. Which replication event best accounts for these tract length measurements?$q$,
    $q$[{"label":"A","text":"Repeated nucleotide misincorporation by the polymerase, converted into extra CAG units by mismatch repair"},{"label":"B","text":"Firing of additional replication origins within the repeat region, duplicating that segment more than once per cycle"},{"label":"C","text":"Transient looping out of the template strand within the tract, causing the polymerase to skip repeat units as it copied"},{"label":"D","text":"Transient dissociation and out of register reannealing of the newly synthesized strand, causing repeat units to be copied more than once"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests how tandem repeat tracts expand across generations through slipped strand mispairing during replication. The answer is D because a long run of identical CAG units allows the newly synthesized strand to detach transiently from its template and reanneal out of register; since every repeat looks the same, the nascent strand can slip backward and still form a locally perfect duplex. When synthesis resumes, the polymerase recopies repeats it has already copied, the redundant nascent sequence is stabilized as a looped out structure, and the daughter molecule ends up carrying more units than the template did. The data fit this slippage mechanism in both respects: the 44 unit allele expanded in every transmission, to 48, 61, and 79 units, while the 18 unit allele passed unchanged, showing that instability increases with tract length exactly as expected when longer runs offer more opportunities for out of register pairing. Huntington disease is simply the locus where this behavior is observed; the mechanism is purely replicative. (Choice A) Mismatch repair corrects single mispaired bases; converting scattered misincorporations into whole additional trinucleotide units would require templated synthesis of new repeats, which point error correction cannot perform. (Choice B) Eukaryotic chromosomes fire many origins, but licensing ensures every segment replicates exactly once per cycle; origin count could not add units to one allele in three independent transmissions while leaving the short allele untouched. (Choice C) A loop that forms on the template strand causes the polymerase to skip units, contracting the tract in the daughter strand; the offspring tracts are longer than the parent's 44, so the loop must have formed on the newly synthesized strand, the opposite arrangement. This is a Data-based and Statistical Reasoning question because it asks you to extract the direction and length dependence of repeat instability from parent and offspring tract measurements and match that quantitative pattern to a specific replication error.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q;

-- B3 Q6 . palindromic recognition site identification . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$palindromic recognition site identification$q$,
    $q$A newly purified type II restriction endonuclease is assumed to behave like most enzymes of its class, recognizing a single palindromic site in double stranded DNA and cleaving within it. Four candidate recognition sequences are synthesized as double stranded oligonucleotides. Which sequence, written as its top strand read 5' to 3', could be the recognition site of this enzyme?$q$,
    $q$[{"label":"A","text":"5'-AATTAA-3'"},{"label":"B","text":"5'-GAATTC-3'"},{"label":"C","text":"5'-GGAGGA-3'"},{"label":"D","text":"5'-GATTAC-3'"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the recognition site logic of type II restriction endonucleases, which cleave short palindromic sequences in double stranded DNA. The answer is B because 5'-GAATTC-3' reads identically in the 5' to 3' direction on both strands of the duplex, the defining property of a biological palindrome. To test a candidate, write its complementary strand antiparallel beneath it and then read that strand in its own 5' to 3' direction. For 5'-GAATTC-3', the partner strand is 3'-CTTAAG-5', and reading it 5' to 3' gives GAATTC again, so the double stranded site has twofold symmetry. This symmetry is functionally important because most type II enzymes act as homodimers, with each identical subunit engaging one half of the symmetric site, allowing the enzyme to cut both backbones at equivalent positions. This sequence is in fact the site of the widely used enzyme EcoRI, named for the Escherichia coli strain in which it was found. Site length also predicts cut frequency: a specific six base site occurs on average once every 4 to the sixth power, roughly 4,096, base pairs of random sequence, whereas a four base site occurs about once every 256 base pairs and is cut far more often. (Choice A) 5'-AATTAA-3' is a mirror style palindrome, reading the same forward and backward along a single strand, like a palindrome in ordinary text. Restriction enzymes do not use this kind of symmetry; the reverse complement of this sequence is 5'-TTAATT-3', which does not match the original, so the duplex lacks the required twofold symmetry. (Choice C) 5'-GGAGGA-3' is a direct repeat of the triplet GGA. Internal repetition along one strand is not palindromy; its reverse complement is 5'-TCCTCC-3', which does not match the top strand. (Choice D) 5'-GATTAC-3' has the six base pair length typical of common recognition sites, but its reverse complement is 5'-GTAATC-3', which differs from the top strand, so a symmetric dimeric enzyme has no equivalent half sites to bind. This is a Knowledge of Scientific Concepts and Principles question because it asks you to apply the definition of a double stranded DNA palindrome to identify which candidate sequence a type II restriction enzyme could recognize.$q$,
    'easy',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$single strand mirror palindrome mistaken for inverted repeat$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$direct repeat mistaken for palindromic symmetry$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$correct site length without palindromic symmetry$q$ FROM q;

-- B3 Q7 . compatible overhang ligation logic . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$compatible overhang ligation logic$q$,
    $q$Enzyme P cleaves 5'-GAATTC-3' between the G and the first A on each strand, and enzyme Q cleaves 5'-CAATTG-3' between the C and the first A on each strand, so each of these enzymes leaves four base single stranded 5' overhangs. Enzyme R cleaves 5'-CCCGGG-3' between the third C and the first G on each strand, leaving no single stranded overhang. A student digests separate DNA samples with each enzyme and then combines fragments in the presence of DNA ligase. Which of the following junctions can form by direct annealing of complementary overhangs before ligation?

I. An end produced by enzyme P joined to another end produced by enzyme P
II. An end produced by enzyme P joined to an end produced by enzyme Q
III. An end produced by enzyme P joined to an end produced by enzyme R$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"III only"},{"label":"C","text":"I and II only"},{"label":"D","text":"II and III only"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests the logic of sticky end compatibility, the basis for joining restriction fragments in recombinant DNA work. The answer is C because junctions I and II both involve ends carrying identical complementary overhangs, while junction III pairs an overhanging end with a blunt end that has no single stranded region available to anneal. Writing out the cuts shows why. Enzyme P makes a staggered cut in its site, leaving a protruding 5'-AATT single stranded extension on every end it creates, so two P generated ends base pair with each other, making junction I possible. Enzyme Q cuts its own site the same way, and although its recognition sequence differs from that of enzyme P, the four base extension it leaves is also 5'-AATT; a P end and a Q end are therefore fully complementary and anneal just as readily, making junction II possible, after which ligase seals both backbones. Compatibility is determined by the overhang sequence alone, not by the identity of the enzyme or the full recognition site. As a consequence, the hybrid junction formed between a P end and a Q end regenerates neither GAATTC nor CAATTG, so neither enzyme can recut it. (Choice A) I only is the answer expected if fragments could be joined only when cut by the same enzyme; this overlooks that two different enzymes can leave the same single stranded extension, and once the two overhangs are written out, the P and Q ends are seen to be perfectly complementary. (Choice B) III only confuses the two steps of joining: annealing between complementary extensions must precede sealing, and a blunt end produced by enzyme R has no extension at all, so it cannot base pair with the four base overhang of a P end, while assuming the matching P and P or P and Q overhangs cannot pair gets the annealing requirement backwards. (Choice D) II and III correctly includes the cross enzyme junction but wrongly adds the sticky to blunt pairing, which fails for the same geometric reason: there is no single stranded partner for the overhang to grip. This is a Scientific Reasoning and Problem Solving question because it requires deriving the overhang sequences left by three described enzymes and predicting which ends can base pair with each other.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$same enzyme only ligation belief$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$annealing versus ligase sealing confusion$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$right cross enzyme logic, wrong blunt inclusion$q$ FROM q;

-- B3 Q8 . methylation based self nonself discrimination . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$methylation based self nonself discrimination$q$,
    $q$A bacterial strain rapidly fragments injected bacteriophage DNA at 5'-GAATTC-3' sites, yet its own chromosome, which contains hundreds of the same sequence, remains intact. A rare infecting phage escapes fragmentation, completes a lytic cycle in this strain, and releases progeny virions. When these progeny infect fresh cells of the same strain, nearly all of them establish successful infections. Which mechanism most directly accounts for the progeny phages' new resistance to fragmentation?$q$,
    $q$[{"label":"A","text":"Host enzymes covalently modified the recognition sites of the progeny genomes during replication, adding methyl groups that block endonuclease cleavage."},{"label":"B","text":"The endonuclease cleaves only methylated GAATTC sites, and the progeny genomes emerged from the host in an unmethylated state."},{"label":"C","text":"Point mutations eliminated every GAATTC site from the progeny genomes during the single cycle of replication."},{"label":"D","text":"The escaping phage acquired a gene encoding an inhibitor protein that inactivates the host endonuclease in newly infected cells."}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests the restriction modification system, the mechanism prokaryotes use to destroy foreign DNA while sparing their own genome. The answer is A because DNA replicated inside a host carrying a restriction modification system is methylated by the host methyltransferase at the same recognition sequence the endonuclease targets, and methylated sites are not cleaved. The strain in the passage pairs an endonuclease that cuts unmethylated 5'-GAATTC-3' with a companion methyltransferase acting on that same sequence; the chromosome survives because every one of its own sites carries the methyl mark, which serves as the cell's molecular definition of self. Incoming phage DNA from another source lacks methylation at these sites, is treated as nonself, and is fragmented. The rare phage that escapes and replicates inside the strain builds its progeny genomes in the presence of the host methyltransferase, so those genomes leave the cell with methylated GAATTC sites and are chemically indistinguishable from self DNA during the next infection. This protection is an acquired chemical mark rather than a genetic change, and it would be lost after a single round of growth in a strain lacking the methyltransferase. (Choice B) reverses the discrimination logic: the endonuclease cleaves unmethylated sites and spares methylated ones, and if it cleaved only methylated DNA, the heavily methylated host chromosome would be the molecule destroyed. (Choice C) point mutations arise far too rarely to eliminate every one of the many GAATTC sites in a phage genome within a single replication cycle, and a genome that truly lost all its sites would remain resistant wherever it was later propagated, unlike a methyl mark, which must be renewed by replication in a methylating host. (Choice D) inhibitor proteins that block restriction enzymes do exist in some phages, but this choice requires the phage to gain a new gene during a single lytic cycle, and the host strain described here carries no inhibitor gene directed against its own endonuclease for the phage to pick up; replication inside the host, by contrast, necessarily exposes every progeny genome to the host methyltransferase, so no genetic change is needed to explain the resistance. This is a Scientific Reasoning and Problem Solving question because it asks you to infer from an infection pattern how methylation acquired in one host marks phage DNA as self during the next round of infection.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$cleaves methylated inversion$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$evolutionary site avoidance misapplied to one cycle$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$real phenomenon with no gene source in this host$q$ FROM q;

-- B3 Q9 . origin requirement for plasmid maintenance . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$origin requirement for plasmid maintenance$q$,
    $q$A researcher constructs a candidate cloning vector that contains an ampicillin resistance gene and a polylinker with several unique restriction sites, then introduces it into E. coli. Transformed cells initially survive on ampicillin plates, but as the population divides over many generations the plasmid disappears from the descendants and resistance is lost. Which additional element must the vector carry to prevent this loss?$q$,
    $q$[{"label":"A","text":"A gene encoding DNA ligase to reseal the plasmid after each round of cell division"},{"label":"B","text":"A second antibiotic resistance gene conferring resistance to kanamycin"},{"label":"C","text":"An origin of replication recognized by the host cell's replication machinery"},{"label":"D","text":"Additional unique restriction sites within the polylinker region"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests cloning vector anatomy, specifically why a functional vector must carry an origin of replication in addition to a selectable marker and a multiple cloning site. The answer is C because a plasmid persists in a growing bacterial population only if the host replication machinery duplicates it before each cell division, and that duplication can begin only at an origin sequence carried on the vector itself. Every standard cloning plasmid needs three core elements, each with a distinct job: an origin of replication so the vector is copied and passed to both daughter cells, a selectable marker such as an antibiotic resistance gene so cells that carry the vector can be distinguished from cells that do not, and a multiple cloning site containing unique restriction sites so a foreign fragment can be inserted at a defined position. The vector described contains the marker and the polylinker but lacks an origin. An unreplicated plasmid is progressively diluted as the population doubles, so the resistance phenotype it confers vanishes from the descendants, exactly matching the loss described in the stem. (Choice A) DNA ligase acts during construction of the recombinant molecule in vitro, sealing phosphodiester bonds between vector and insert; it is not a component the vector must encode, and no resealing step occurs at each cell division. (Choice B) A second resistance gene expands the ways transformants can be selected, and some real vectors do carry two markers, but selection only reveals which cells hold the plasmid; it cannot cause the plasmid to be copied or inherited. (Choice D) Extra unique restriction sites make the polylinker more versatile for inserting different fragments, but the cloning site functions only while the recombinant plasmid is being built; it plays no role in maintaining the vector inside dividing host cells. This is a Knowledge of Scientific Concepts and Principles question because it asks you to match each essential component of a cloning vector to its purpose and recognize that stable propagation depends on the origin of replication.$q$,
    'easy',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$in vitro enzyme imagined as an in vivo maintenance component$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$true vector feature attached to the wrong purpose$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$construction-phase feature offered for a maintenance-phase failure$q$ FROM q;

-- B3 Q10 . antibiotic plate selection logic . medium . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$antibiotic plate selection logic$q$,
    $q$A plasmid carrying a kanamycin resistance gene is used to transform a culture of E. coli, and under these conditions fewer than one cell in ten thousand takes up the plasmid. A technician mistakenly spreads the entire transformation mixture on rich nutrient plates that contain no kanamycin and incubates them overnight. Which outcome should the technician expect, and why does it undermine the experiment?$q$,
    $q$[{"label":"A","text":"No growth anywhere on the plate, because kanamycin must be present to activate expression of the resistance gene"},{"label":"B","text":"Colonies arising only from plasmid-bearing cells, because cells that fail to take up DNA are killed during the transformation procedure itself"},{"label":"C","text":"Fewer colonies than a kanamycin plate would show, because the antibiotic normally stimulates division of resistant cells"},{"label":"D","text":"Near-confluent growth across the plate, because cells lacking the plasmid grow as well as transformants, leaving the rare transformants unidentifiable"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests the logic of the selection step in the transform and select workflow, specifically what the antibiotic plate accomplishes and what is lost without it. The answer is D because transformation is extremely inefficient, so the plated mixture is dominated by cells that never took up the plasmid; on a plate with no kanamycin those cells grow just as well as transformants, producing a nearly confluent lawn in which the rare plasmid-bearing cells cannot be picked out. With uptake below one cell in ten thousand, untransformed cells would outnumber and bury any transformant colonies thousands of times over. The antibiotic plate is the essential filter of the workflow: kanamycin kills every cell lacking the resistance gene, so the only survivors are cells that acquired the plasmid, and each survivor grows into a visible, isolated colony. Omitting the antibiotic changes nothing about uptake, so the biology proceeds normally, but the experiment loses all of its selective information because survival no longer reports plasmid possession. (Choice A) The antibiotic is a poison that resistant cells survive; it is not an inducer required to switch on the resistance gene, and its absence never prevents growth, so a rich plate without kanamycin supports abundant growth. (Choice B) Chemical or heat shock transformation stresses the entire culture, but it does not selectively eliminate cells that failed to take up DNA; the overwhelming majority of surviving cells are untransformed, which is precisely why a selection step is required afterward. (Choice C) This reverses the antibiotic's role: kanamycin does not stimulate division of resistant cells, it eliminates sensitive ones, so removing it increases rather than decreases the number of cells that grow. This is a Reasoning about the Design and Execution of Research question because it asks you to predict the consequence of omitting the selection plate and to recognize that antibiotic plating, not transformation itself, is the step that makes plasmid-bearing cells identifiable.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    3,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$selection agent confused with an expression inducer$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$real procedural stress inflated into a selective kill$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$growth-inhibition role flipped into growth promotion$q$ FROM q;

-- B3 Q11 . empty vector self ligation diagnosis . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$empty vector self ligation diagnosis$q$,
    $q$A student digests both a plasmid vector and a target DNA fragment with EcoRI, and an agarose gel confirms that the digested vector runs as a single linear band. In this vector, the multiple cloning site lies outside the ampicillin resistance gene. After ligation, transformation, and overnight incubation on ampicillin plates, many colonies appear, but plasmid DNA purified from every colony tested is the same size as the empty vector. Which event during the procedure best explains this result?$q$,
    $q$[{"label":"A","text":"The transformation step failed, so none of the plated cells contained plasmid DNA"},{"label":"B","text":"The vector's two EcoRI sticky ends annealed to each other during ligation, recircularizing the vector without an insert"},{"label":"C","text":"EcoRI failed to cut the vector, leaving an intact circle that could never accept the fragment"},{"label":"D","text":"Every fragment that ligated into a vector landed inside the ampicillin resistance gene, so all insert-bearing cells died on the plate"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question integrates the full cloning workflow of digestion, ligation, transformation, and selection, and asks you to reason backward from a flawed outcome to the step that failed. The answer is B because a vector cut once by EcoRI carries two identical complementary sticky ends, and during ligation those ends can anneal to each other just as readily as to an insert bearing matching overhangs; DNA ligase then seals the junction and regenerates a circular empty vector. That recircularized vector still carries its origin of replication and its intact ampicillin resistance gene, so it transforms cells and produces colonies on the selection plate that are indistinguishable, by survival alone, from colonies carrying a true recombinant. Ampicillin selection reports only that a plasmid was taken up, not that the plasmid contains the insert, which is why every colony can grow while none carries the fragment and why every purified plasmid matches the empty vector size. (Choice A) A failed transformation would leave no cells carrying any plasmid, and without a plasmid there is no resistance gene, so the ampicillin plate would show no colonies at all rather than many. (Choice C) An uncut vector would also yield colonies with empty-vector-sized plasmids, but the gel described in the stem showed the digested vector running as a single linear band, which directly demonstrates that EcoRI linearized it. (Choice D) Insertional inactivation of a marker can occur in vectors whose cloning site sits inside a resistance gene, but the stem specifies that this multiple cloning site lies outside the ampicillin gene, so ligating a fragment there would leave recombinant cells fully resistant and able to form colonies. This is a Scientific Reasoning and Problem Solving question because it requires combining sticky end ligation chemistry with the logic of antibiotic selection to deduce which step in the workflow produced antibiotic resistant colonies that lack the insert.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$outcome attributed to a step whose failure predicts the opposite result$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$mechanism consistent with the outcome but contradicted by a stated control$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$real technique from a different vector design misapplied to this one$q$ FROM q;

-- B3 Q12 . cDNA insert for bacterial expression . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$cDNA insert for bacterial expression$q$,
    $q$A biotechnology team clones a human clotting factor gene from a genomic library into a bacterial expression plasmid. Although E. coli transcribes and translates the insert, the resulting protein is the wrong size and nonfunctional. Which alternative insert would most directly resolve this problem?$q$,
    $q$[{"label":"A","text":"The same genomic clone extended to include the gene's native promoter and enhancer sequences"},{"label":"B","text":"A genomic clone isolated from a library prepared from liver tissue that expresses the factor"},{"label":"C","text":"A DNA copy synthesized by reverse transcription of the gene's mature mRNA"},{"label":"D","text":"The same genomic clone placed downstream of a stronger bacterial promoter"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests the practical distinction between genomic library clones and cDNA as starting material for expressing a eukaryotic protein in bacteria. The answer is C because DNA synthesized by reverse transcription of the mature mRNA contains only exon sequence, and an intron-free coding sequence is precisely what a bacterial host needs. A genomic clone carries the gene exactly as it sits on the chromosome: exons interrupted by introns, plus flanking DNA. In human cells the introns are removed from the primary transcript before translation, but E. coli possesses no machinery for removing them, so the ribosome reads into retained intron sequence, disrupting the reading frame and the encoded protein. That is why the observed protein is the wrong size and nonfunctional. Because reverse transcriptase copies the mature, fully processed transcript back into DNA, a clone built from that copy encodes an uninterrupted reading frame and directs synthesis of the correct polypeptide. (Choice A) Genomic clones can indeed include native promoters and enhancers, which is one feature that distinguishes genomic libraries from cDNA libraries, but additional eukaryotic regulatory sequence does nothing about the introns inside the coding region, and bacterial RNA polymerase does not efficiently recognize eukaryotic promoters anyway. (Choice B) Genomic DNA is essentially identical in every nucleated cell of the body, so a genomic library made from liver contains the same intron-bearing gene as a library made from any other tissue. Tissue of origin matters for cDNA libraries, which capture only the transcripts that tissue expresses, not for genomic libraries. (Choice D) A stronger bacterial promoter would increase how much transcript and protein the cell makes, but every transcript produced would still carry intron sequence, so the cell would simply make more of the same defective protein; raising the yield of a defective product does not repair it. This is a Scientific Reasoning and Problem Solving question because it requires diagnosing why a genomic insert fails in a bacterial host and selecting the starting material that corrects the failure.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B3 Q13 . cDNA first strand enzyme requirement . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$cDNA first strand enzyme requirement$q$,
    $q$Researchers isolate polyadenylated transcripts from pancreatic islet cells to build a library that represents only the genes those cells actively express. Before cloning, each transcript must first be copied into a complementary DNA strand. Which enzymatic activity accomplishes this first synthesis step?$q$,
    $q$[{"label":"A","text":"DNA-dependent RNA polymerase activity"},{"label":"B","text":"RNA-dependent DNA polymerase activity"},{"label":"C","text":"RNA-dependent RNA polymerase activity"},{"label":"D","text":"DNA-dependent DNA polymerase activity"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the technique logic of cDNA library construction, specifically the enzymatic activity required for first strand synthesis. The answer is B because copying an mRNA molecule into a complementary DNA strand requires an enzyme that reads an RNA template while polymerizing DNA, which is by definition an RNA-dependent DNA polymerase. Reverse transcriptase, an enzyme originally identified in retroviruses, provides exactly this activity and is the standard laboratory tool for the job. Polymerase names of this form state the template first and the product second, so answering requires identifying RNA as the template and DNA as the product in the conversion described. Starting from mature polyadenylated transcripts is what makes the finished library represent only the genes the islet cells actively express, since sequences that are never transcribed in that tissue never appear among the templates. (Choice A) A DNA-dependent RNA polymerase reads DNA and synthesizes RNA. That is the activity of transcription, which runs in exactly the opposite direction from the conversion required here and would regenerate RNA rather than produce a clonable DNA strand. (Choice C) RNA-dependent RNA polymerases copy RNA templates into new RNA molecules. Certain RNA viruses replicate their genomes this way, but the product would still be RNA, which cannot be inserted into a DNA cloning vector and propagated in bacteria. (Choice D) DNA-dependent DNA polymerase activity does participate in cDNA library construction, but only at the second step, when the completed first DNA strand serves as the template for synthesis of the second strand to form a double-stranded insert. Because this activity cannot read an RNA template, it cannot carry out the first synthesis step the question asks about. This is a Knowledge of Scientific Concepts and Principles question because it asks for recall of which polymerase class copies an RNA template into DNA during cDNA synthesis.$q$,
    'easy',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B3 Q14 . PCR annealing step purpose . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$PCR annealing step purpose$q$,
    $q$A technician programs a thermocycler for 30 PCR cycles but sets the second temperature step of every cycle to 95 degrees Celsius rather than the intended 55 degrees Celsius; the first and third steps are programmed correctly. All reagents, including a thermostable polymerase, are present and functional. Which outcome should the technician expect?$q$,
    $q$[{"label":"A","text":"No product accumulates because the primers cannot base-pair with the template at that temperature"},{"label":"B","text":"Product accumulates normally because the thermostable polymerase is unaffected by the higher temperature"},{"label":"C","text":"Product accumulates but contains frequent errors because the elevated temperature reduces polymerase fidelity"},{"label":"D","text":"No product accumulates because the template strands fail to separate"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests the mapping between each temperature step of a PCR cycle and its purpose. The answer is A because the second step of each cycle is the annealing step, in which the reaction is cooled to roughly 50 to 65 degrees Celsius so that the short primers can form stable base pairs with their complementary sites on the template. At 95 degrees Celsius the hydrogen bonds holding a short primer to its site cannot persist, so primers never occupy the template. The polymerase can only extend a primer that is already base-paired to the template, because it requires a primed double-stranded junction to begin synthesis. Because the third step was also programmed correctly, the polymerase and free nucleotides sit ready to extend, but extension can never begin without an annealed primer. With no annealed primers in any cycle, no new strands are made and no product accumulates no matter how many cycles run. (Choice B) It is true that a thermostable polymerase tolerates 95 degrees Celsius without unfolding, which is exactly why enzymes like Taq are used in PCR, but enzyme survival is not sufficient for amplification; the polymerase has nothing to extend if primers cannot anneal, so product does not accumulate normally. (Choice C) This reflects the idea that heat simply makes the polymerase sloppy. Whatever the intrinsic fidelity of the enzyme, the failure in this scenario is complete rather than error-prone, because with no primer base-paired to the template, synthesis never initiates at all. (Choice D) Strand separation is the purpose of the first step, which was programmed correctly at 95 degrees Celsius, so the template strands do separate as intended. This choice assigns the failure to the wrong step of the cycle; the defect lies in primer annealing, not in denaturation. This is a Scientific Reasoning and Problem Solving question because it requires assigning each thermal step of the PCR cycle to its function and predicting the consequence of eliminating primer annealing.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B3 Q15 . same strand primer pair failure . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$same strand primer pair failure$q$,
    $q$A student attempts to amplify a 400 base pair target located in the middle of a purified 3 kb linear DNA template. Reaction 1 uses a correctly designed primer pair, while reaction 2 uses two 20-nucleotide primers that are perfectly complementary to sites on the same template strand, one on each side of the target. After 30 cycles, agarose gel electrophoresis shows a single bright 400 bp band in the reaction 1 lane and no visible band in the reaction 2 lane, although the template, dNTPs, and thermostable polymerase in reaction 2 were confirmed to be active. What accounts for the missing band in reaction 2?$q$,
    $q$[{"label":"A","text":"The two primers annealed to each other instead of the template, forming dimers that prevented any extension"},{"label":"B","text":"The 95 degree denaturation step stripped the annealed primers off the template before the polymerase could extend them"},{"label":"C","text":"Extension products formed, but at lengths near 3 kb they were too large to resolve as a band on the gel"},{"label":"D","text":"Neither primer can anneal to the new strands that are made, so copies of the target accumulate linearly and never reach detectable amounts"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests primer orientation logic, specifically why the two primers must flank the target on opposite strands for exponential amplification. The answer is D because a primer is extended only after annealing to a strand it complements, and both primers in reaction 2 complement the same template strand. Each cycle, both primers anneal to that one strand type and are extended, producing new strands whose sequence matches the opposite, uncopied strand. Those products have the same sense as the primers themselves, so neither primer can base-pair with them, and the products never serve as templates in later cycles. Only the original template molecules are copied each cycle, so the copy number grows by a fixed increment per cycle instead of doubling. A correctly oriented pair, in which each primer complements the 3-prime end of one strand so the two extension products converge across the target, lets every new strand template the other primer, giving roughly a billion-fold amplification over 30 cycles and the bright 400 bp band in lane 1, while a linear process adds only tens of new copies per template molecule, far below the detection limit of a stained gel. (Choice A) Primer dimers form when two primers are complementary to each other. Two primers that each complement the same strand both carry the sequence sense of the opposite strand, so they are not complementary to one another, and dimer formation is not a consequence of this design. (Choice B) Each cycle runs denaturation first, then annealing, then extension, so primers that anneal during the cool step are extended before the next 95 degree step arrives; reaction 1 produced abundant product under the identical thermal program, which rules out this mechanism. (Choice C) Run-off extension toward the template end does occur in reaction 2, but a fragment near 3 kb resolves perfectly well on standard agarose; the products fail to appear because they accumulate linearly and remain too scarce to stain, not because of their size. This is a Data-based and Statistical Reasoning question because it requires interpreting the gel results of two parallel reactions and reasoning from the missing band back to the flaw in primer orientation.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- B3 Q16 . PCR cycle fold amplification arithmetic . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$PCR cycle fold amplification arithmetic$q$,
    $q$A clinical laboratory receives a sample containing approximately 1,000 copies of a viral DNA target. The detection method to be used downstream requires approximately 1 billion copies of the target sequence. Assuming each PCR cycle doubles the number of target molecules, approximately how many cycles are required?$q$,
    $q$[{"label":"A","text":"10"},{"label":"B","text":"20"},{"label":"C","text":"30"},{"label":"D","text":"40"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the exponential arithmetic of amplification by the polymerase chain reaction. The answer is B because the sample must be amplified one millionfold, and 20 doubling cycles produce approximately a millionfold increase. The required amplification factor is the ratio of final copies to starting copies: 1 billion divided by 1,000 is 1 million. Because every cycle doubles the target, n cycles multiply the starting material by 2 raised to the n, so the task reduces to finding the exponent for which 2 raised to the n is about 1 million. The key benchmark is that 2 raised to the 10th is approximately 1,000, so 10 cycles give roughly a thousandfold amplification. Two consecutive blocks of 10 cycles multiply a thousandfold by another thousandfold, which is a millionfold, so about 20 cycles are needed. Starting from 1,000 copies, 20 cycles therefore yield approximately 1 billion copies, exactly the stated requirement; this exponential behavior is what lets a reaction that runs for only a few hours convert a trace amount of template into a quantity that instruments can detect. (Choice A) Ten cycles amplify only about a thousandfold, taking 1,000 copies to roughly 1 million, which falls three orders of magnitude short of the 1 billion copy target. (Choice C) Thirty cycles give approximately a billionfold amplification. That familiar figure tempts test takers to match it to the 1 billion final copies, but the exponent must be matched to the fold increase rather than the final count; 30 cycles applied to 1,000 starting copies would overshoot to about a trillion copies. (Choice D) Forty cycles is double the correct answer and reflects the mistaken idea that each of the two template strands requires its own cycle; in fact both strands are copied within every cycle, which is precisely why the copy number doubles each round. This is a Data-based and Statistical Reasoning question because it requires converting stated starting and final copy numbers into a required fold amplification and solving the exponential doubling relationship for the number of cycles.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    4,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'scale_unit_error', $q$order-of-magnitude undershoot$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true fact, wrong quantity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$per-strand double counting$q$ FROM q;

-- B3 Q17 . in vitro versus in vivo amplification . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$in vitro versus in vivo amplification$q$,
    $q$A researcher must generate millions of copies of a 900 base pair DNA segment by the end of the workday, and the laboratory has no equipment for culturing bacteria. Which approach meets both constraints?$q$,
    $q$[{"label":"A","text":"Polymerase chain reaction, because thermal cycling drives repeated rounds of enzymatic synthesis in a cell-free reaction that finishes within hours"},{"label":"B","text":"Polymerase chain reaction, because the heat-stable polymerase inserts the segment into a host chromosome that then replicates it"},{"label":"C","text":"Plasmid cloning, because replication inside dividing bacteria generates copies faster than enzymatic synthesis in a reaction tube"},{"label":"D","text":"Plasmid cloning, because DNA polymerases cannot copy DNA outside a living cell"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests the choice between the two major DNA amplification strategies, enzymatic amplification in a reaction tube and cloning through living bacterial cells. The answer is A because the polymerase chain reaction satisfies both stated constraints: it needs no living cells, so the absence of bacterial culture equipment is irrelevant, and its repeated cycles of denaturation, primer annealing, and polymerase extension can produce millions of copies in a few hours. The reaction requires only the template, two primers, deoxynucleotide building blocks, and a heat-stable polymerase, all combined in a single tube that is cycled through temperature changes. Plasmid based cloning instead amplifies DNA in vivo: the fragment is joined to a vector, the vector is taken up by bacteria, and copies accumulate only as the transformed cells replicate the plasmid while colonies grow, a workflow that requires culture facilities and typically takes days rather than hours. Cloning remains the better choice for other goals, such as long term propagation of a construct or expression of an encoded protein, but neither goal is stated here. (Choice B) This names the right technique for the wrong reason; the heat-stable polymerase simply extends primers along the template in solution and never integrates the fragment into any host chromosome. Integration into host DNA describes no step of the polymerase chain reaction. (Choice C) This reverses the actual speed relationship: growth and division of transformed bacterial colonies takes days, while thermal cycling in a tube reaches millionfold amplification within hours. (Choice D) DNA polymerases function readily outside cells when supplied with template, primer, and nucleotides; the entire polymerase chain reaction is built on exactly that cell-free activity, so the claim contradicts the technique's central premise. This is a Scientific Reasoning and Problem Solving question because it requires mapping practical constraints, no cell culture and a same day deadline, onto the defining operational differences between cell-free enzymatic amplification and cloning through living cells.$q$,
    'easy',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$right technique, borrowed mechanism$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$flipped speed comparison$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$cells-required fallacy$q$ FROM q;

-- B3 Q18 . agarose size only migration ordering . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$agarose size only migration ordering$q$,
    $q$A student loads three linear DNA fragments of 0.5 kb, 2 kb, and 6 kb into a single well of a standard agarose gel and applies current for one hour. Ranked from greatest to least distance traveled from the loading well, what is the expected order of the fragments?$q$,
    $q$[{"label":"A","text":"6 kb, then 2 kb, then 0.5 kb"},{"label":"B","text":"All three travel the same distance, because every DNA fragment has the same charge-to-mass ratio"},{"label":"C","text":"The order cannot be predicted without knowing each fragment's base composition"},{"label":"D","text":"0.5 kb, then 2 kb, then 6 kb"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests why agarose gel electrophoresis separates DNA fragments and how migration distance relates to fragment length. The answer is D because DNA separation in agarose depends on size alone, and smaller fragments thread through the gel's pores more easily, so the 0.5 kb fragment travels farthest, followed by the 2 kb fragment, with the 6 kb fragment remaining closest to the well. Every nucleotide adds one negatively charged phosphate to the backbone, so charge and mass grow in strict proportion and every fragment has essentially the same charge-to-mass ratio. In free solution that uniformity would make all fragments move at nearly the same speed; the agarose matrix is what creates separation, acting as a molecular sieve whose pores retard long molecules far more than short ones. Migration distance in a given run therefore reports fragment length and nothing else, which is why a ladder of known sizes can calibrate the gel. This is also why a gel cannot distinguish two different sequences of identical length; both run as a single band, and running the gel longer stretches every distance proportionally without ever changing the order. (Choice A) This reverses the size relationship; the longest fragment is hindered most by the sieving matrix and finishes nearest the loading well, not farthest from it. (Choice B) The premise is correct, since a uniform charge-to-mass ratio is a real property of DNA, but the conclusion ignores the gel itself; the sieving matrix converts an equal driving force per unit mass into unequal velocities that depend on length. (Choice C) Base composition does not influence migration under standard conditions, because every base pair contributes the same backbone charge; unlike melting behavior, which depends on GC content, gel mobility of double-stranded DNA depends only on length. This is a Scientific Reasoning and Problem Solving question because it requires reasoning from DNA's uniform charge-to-mass ratio to the conclusion that the sieving matrix makes size the sole determinant of migration order.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$bigger-runs-farther flip$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$true premise, missing sieve$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$sequence-dependence myth$q$ FROM q;

-- B3 Q19 . double digest restriction site mapping . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$double digest restriction site mapping$q$,
    $q$A linear 10 kb DNA molecule contains exactly one recognition site for restriction enzyme X and exactly one for restriction enzyme Y. Digestion with X alone yields fragments of 3 kb and 7 kb, while digestion with Y alone yields fragments of 4 kb and 6 kb. A double digest with both enzymes yields fragments of 3 kb, 1 kb, and 6 kb. What is the distance between the X site and the Y site?$q$,
    $q$[{"label":"A","text":"3 kb"},{"label":"B","text":"4 kb"},{"label":"C","text":"1 kb"},{"label":"D","text":"7 kb"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests restriction mapping, using single and double digest band patterns to place two cut sites on a linear molecule. The answer is C because the double digest pattern is consistent only with the two sites lying 1 kb apart. Work from one end of the 10 kb molecule. The X digest gives 3 kb and 7 kb pieces, so the single X site sits 3 kb from one end; a linear molecule with one cut site always yields two fragments, the number of sites plus one. The same rule predicts that the double digest of a linear molecule with two total sites must yield three fragments, which the data confirm. The Y digest gives 4 kb and 6 kb pieces, so the Y site sits either 4 kb or 6 kb from that same reference end, and the single digests alone cannot distinguish these two placements. The double digest decides it: if Y were 6 kb from the reference end, cuts at 3 kb and 6 kb would give fragments of 3 kb, 3 kb, and 4 kb, and the gel would show only two band positions, one of them doubly intense. The observed pattern of 3 kb, 1 kb, and 6 kb instead matches cuts at 3 kb and 4 kb from the same end, so the distance between the sites is 4 minus 3, or 1 kb, with the 1 kb band itself being the fragment bounded by the two cuts; on the gel this 1 kb fragment would also migrate farthest of the three double digest bands, since agarose separates linear DNA by length. (Choice A) Three kb is the distance from the X site to the nearer end of the molecule, a single digest fragment length mistaken for the separation between the two sites. (Choice B) Four kb correctly locates the Y site relative to the reference end, but the question asks for the separation between the sites, which requires subtracting the X position from the Y position. (Choice D) Seven kb is the distance from the X site to the far end of the molecule, a real band in the X digest that answers a different distance than the one asked. This is a Data-based and Statistical Reasoning question because it requires integrating fragment sizes from three digest patterns to reconstruct a restriction map and compute the distance separating the two cut sites.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$end distance for intersite distance$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$correct coordinate, missing subtraction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$real band, wrong distance$q$ FROM q;

-- B3 Q20 . probe sequence specificity . medium . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$probe sequence specificity$q$,
    $q$A researcher digests total human genomic DNA with a restriction enzyme and separates the products on an agarose gel, producing a continuous smear of thousands of fragment sizes. The fragments are transferred to a nylon membrane, made single stranded, and incubated with a radiolabeled single-stranded DNA segment matching part of one gene, after which the washed membrane shows a single sharp band on film. Which feature of the procedure explains why the label appears at only one position?$q$,
    $q$[{"label":"A","text":"The labeled strand forms a stable duplex only with membrane fragments containing a sequence complementary to it"},{"label":"B","text":"The transfer step moves only the fragment of interest from the gel onto the membrane"},{"label":"C","text":"The restriction enzyme cleaves genomic DNA only at sites within the gene being studied"},{"label":"D","text":"Fragments of identical length migrate to a single position, so each gel position holds one unique sequence"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests the logic of Southern blotting, specifically how a labeled probe locates one target fragment within an entire genomic digest. The answer is A because hybridization is sequence specific: a labeled single strand forms a stable double helix only where a membrane-bound fragment carries bases complementary to it, so among thousands of immobilized fragments only the one containing the target sequence retains the label after washing. The agarose gel separates purely by size, because every DNA fragment has essentially the same charge-to-mass ratio, and size separation carries no sequence information. Specificity therefore enters only at the probing step, when base pairing rejects every fragment that cannot align its bases with the labeled strand. Stringent washing then strips away probe molecules held by anything weaker than extensive complementary pairing, leaving detectable signal at a single position that reports both the presence and the restriction fragment size of the target. This is why a probe can pick out a single gene even though a genomic digest yields an enormous number of fragments spread continuously down the lane. (Choice B) Transfer is not selective; capillary or electrophoretic transfer moves the entire fragment population from the gel onto the membrane in its original pattern, so the membrane starts out carrying the same smear the gel did. (Choice C) A restriction enzyme cuts at its recognition sequence wherever that sequence occurs, which across a genome means thousands of sites in many unrelated loci; cutting is not confined to the gene under study. (Choice D) Although fragments of equal length do co-migrate, each position in a genomic digest contains many different sequences of the same size, so shared migration position cannot isolate a single fragment. This is a Reasoning about the Design and Execution of Research question because it asks which step of the Southern blot procedure converts a size-sorted smear into a single sequence-specific signal.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    3,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$wrong step credited with specificity$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true fact misapplied to explain specificity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$correct premise, wrong conclusion$q$ FROM q;

-- B3 Q21 . blot target discrimination . medium . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$blot target discrimination$q$,
    $q$A laboratory creates a transgenic mouse line intended to carry and express an added jellyfish gene, but a protein blot of mouse tissue detects none of the encoded protein. The team considers three follow-up analyses:

I. Probing a membrane of electrophoresed genomic DNA fragments with a labeled strand matching the added gene
II. Probing a membrane of electrophoresed total cellular RNA with the same labeled strand
III. Repeating the protein blot using a more sensitive detection method

Which of these analyses would be required to determine whether the failure occurred at genomic integration or instead at transcription?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests discrimination among the blotting techniques by the molecule each one detects: a Southern blot reports a DNA sequence in the genome, a Northern blot reports an RNA transcript, and a Western blot reports the protein product. The answer is C because separating a failure of genomic integration from a failure of transcription requires examining both nucleic acid levels. Analysis I probes electrophoresed genomic DNA, so it reveals whether the added gene is physically present in the mouse genome; this is a Southern blot. Analysis II probes electrophoresed cellular RNA with the same labeled strand, so it reveals whether any integrated copy is being transcribed; this is a Northern blot. Only the combination is diagnostic: if I is positive and II is negative, the gene integrated but is not transcribed, whereas if I is negative, the gene never integrated at all and the transcription question is moot. Analysis III remains at the protein level and cannot separate these upstream possibilities no matter how sensitive it becomes. (Choice A) A blot of genomic DNA alone shows whether the gene is present but says nothing about whether it is transcribed, so even a positive result would leave the failure point unresolved between transcription and a downstream step. (Choice B) An RNA blot alone is ambiguous in the negative case: absence of a transcript signal could mean the gene is present but silent or that it was never integrated, and only the genomic DNA result distinguishes those two situations. (Choice D) Repeating the protein blot examines the same downstream endpoint that already failed; because protein absence is compatible with either an integration failure or a transcription failure, a protein-level result cannot assign the defect to one of those two stages, so III is not required. This is a Reasoning about the Design and Execution of Research question because it asks which blotting analyses, defined by the molecule each one detects, must be combined to localize the failure point in a transgenic expression experiment.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    3,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$necessary component mistaken for sufficient answer$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$necessary component mistaken for sufficient answer$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$downstream assay credited with upstream resolution$q$ FROM q;

-- B3 Q22 . dideoxy chain termination . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$dideoxy chain termination$q$,
    $q$During chain-termination sequencing, DNA polymerase occasionally adds a dideoxynucleotide rather than a normal deoxynucleotide to the 3' end of a growing strand. That strand is never extended again, even though active polymerase and abundant normal nucleotides remain in the tube. Which property of the incorporated analog accounts for the permanent halt?$q$,
    $q$[{"label":"A","text":"It distorts the template strand so the polymerase can no longer read subsequent bases"},{"label":"B","text":"It lacks the sugar hydroxyl group needed to attack the next incoming nucleotide"},{"label":"C","text":"Its triphosphate cannot be hydrolyzed, leaving no energy source for new bond formation"},{"label":"D","text":"It prevents the primer from annealing to the template at the start of synthesis"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the chemical basis of chain termination by dideoxynucleotides in Sanger sequencing. The answer is B because strand extension is chemistry at the 3' end: each new backbone linkage forms when the hydroxyl group on the 3' carbon of the terminal sugar attacks the innermost phosphate of the incoming nucleoside triphosphate, creating a phosphodiester bond. A dideoxynucleotide carries hydrogen rather than a hydroxyl at that 3' position, so once it occupies the strand's 3' end there is no nucleophile available to attack the next incoming nucleotide, and the strand is chemically incapable of growing no matter how much polymerase or substrate remains. Termination is therefore permanent and positional, which is exactly what sequencing exploits: every terminated strand ends at a position where the analog was incorporated in place of the normal nucleotide. Because incorporation is random, the ratio of dideoxynucleotide to normal nucleotide in the tube sets the distribution of fragment lengths the reaction produces. (Choice A) The analog is incorporated by ordinary template-directed base pairing and does not distort the template; the downstream bases remain perfectly readable, but no chemistry can add onto the blocked 3' end. (Choice C) The energy for each new phosphodiester bond comes from hydrolysis of the incoming nucleotide's own triphosphate, not from the triphosphate of the residue already sitting at the 3' end; the analog's triphosphate was consumed normally at the moment it was added, so energy supply is not the problem. (Choice D) Primer annealing occurs before synthesis begins and is unaffected by nucleotide analogs in solution; the halt described here occurs during elongation, after the primer has already been extended by the polymerase. This is a Knowledge of Scientific Concepts and Principles question because it asks for the specific structural feature of a dideoxynucleotide that makes its incorporation terminate DNA synthesis.$q$,
    'easy',
    '5D',
    $q$Nucleic Acids$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$termination blamed on the template rather than the primer terminus$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true energetic fact attached to the wrong molecule$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong phase of the reaction$q$ FROM q;

-- B3 Q23 . sequencing ladder read reconstruction . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$sequencing ladder read reconstruction$q$,
    $q$A student runs four separate chain-termination sequencing reactions on identical primed templates. Each reaction contains all four normal nucleotides, which are unlabeled, plus a small amount of a single chain terminator that carries the only detectable label in the tube, so only strands ending in the terminator are visualized. Product lengths are counted as the number of newly added nucleotides beyond the primer. The reaction containing the C terminator yields detected products 1 and 6 nucleotides long. The reaction with the A terminator yields products 2 and 5 nucleotides long. The reaction with the G terminator yields a 3 nucleotide product, and the reaction with the T terminator yields a 4 nucleotide product. What is the sequence of the six newly synthesized nucleotides, written 5' to 3'?$q$,
    $q$[{"label":"A","text":"5'-CATGAC-3'"},{"label":"B","text":"5'-GTACTG-3'"},{"label":"C","text":"5'-GTCATG-3'"},{"label":"D","text":"5'-CAGTAC-3'"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests reading a chain-termination ladder, in which each terminated fragment's length reports the identity of the base at one position of the newly made strand. The answer is D because synthesis proceeds 5' to 3', so the shortest product identifies the base closest to the 5' end of the new strand and each additional nucleotide of length steps one position toward the 3' end. Every detected product ends in the labeled terminator itself, which is why a product's length directly names the base at that position. Assigning terminators to lengths: the C terminator produced lengths 1 and 6, placing C at positions 1 and 6; the A terminator produced lengths 2 and 5, placing A at positions 2 and 5; the G terminator produced length 3, placing G at position 3; and the T terminator produced length 4, placing T at position 4. Reading positions 1 through 6 in order therefore gives 5'-CAGTAC-3'. (Choice A) 5'-CATGAC-3' results from reading the ladder backward, assigning the shortest fragment to the 3' end; this reverses the direction of synthesis, which always adds the first new nucleotide at what becomes the 5' end of the newly synthesized stretch. (Choice B) 5'-GTACTG-3' is the template strand written 5' to 3'; the question asks for the product strand, and reporting the template confuses the strand the polymerase reads with the strand it writes. (Choice C) 5'-GTCATG-3' comes from complementing the product base by base without reversing it, an operation that ignores the antiparallel orientation of paired strands; it is the template written in the wrong direction and corresponds to no strand read conventionally. This is a Scientific Reasoning and Problem Solving question because it requires converting described fragment lengths and their terminators into base positions and assembling those positions into a correctly oriented sequence.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$correct position mapping, reversed read direction$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$template swapped for product$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$complementation without antiparallel flip$q$ FROM q;

-- B3 Q24 . knockout phenotype functional inference . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$knockout phenotype functional inference$q$,
    $q$Mice engineered so that both copies of gene K are disrupted produce no K protein. These knockout mice accumulate compound S in liver cells and lack compound P, which wild-type livers contain, and reintroducing an intact copy of gene K restores both compounds to normal levels. Which conclusion about the normal molecular role of the K protein is best supported?$q$,
    $q$[{"label":"A","text":"The K protein normally carries out the step that consumes S and produces P in liver cells"},{"label":"B","text":"The K protein normally carries out the step that converts P into S"},{"label":"C","text":"The metabolic changes are caused by the selection cassette inserted during gene disruption rather than by loss of K"},{"label":"D","text":"The K protein normally synthesizes S, and its loss removes feedback control over S production"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests the interpretive logic of knockout methodology: disrupting a gene eliminates its product, and the resulting phenotype reveals what that product normally does. The answer is A because the pattern of changes points in one direction. With the K protein absent, S rises while P disappears, which is the signature of losing the step that normally consumes S and generates P: the upstream compound backs up because nothing removes it, and the downstream compound is no longer made. The rescue experiment secures the inference, since restoring an intact copy of K returns both compounds to normal, demonstrating that loss of the K product itself, and not a side effect of the engineering procedure, caused the metabolic change. This is the central strategy of reverse genetics: remove one gene product, observe what the cell can no longer do, and assign that capability to the missing product. (Choice B) If the K protein converted P into S, knocking it out would cause P to accumulate and S to fall, the exact opposite of the observed pattern; this choice inverts the direction of the inferred step. (Choice C) The rescue result eliminates this interpretation: the disruption cassette remains in the genome of rescued animals, so if the cassette itself caused the phenotype, restoring K would not have normalized both compounds. (Choice D) If the K protein synthesized S, its absence would lower S rather than raise it; accumulation of a compound in a knockout indicates the missing product normally consumed that compound, and invoking lost feedback does not rescue this reading because it fails to explain why P vanished as well. This is a Scientific Reasoning and Problem Solving question because it asks which molecular function must be assigned to a gene product to account for the metabolite changes observed when its gene is knocked out and then restored.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$direction of pathway flipped$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$procedural artifact blamed for a genetic phenotype$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$accumulation equated with production$q$ FROM q;

COMMIT;

-- Verification: expect 72 questions and 216 distractor rows, and letters 18/18/18/18.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'DNA and Biotechnology') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'DNA and Biotechnology') AS distractor_rows;

SELECT correct_answer, COUNT(*) FROM public.questions
WHERE topic = 'DNA and Biotechnology' GROUP BY correct_answer ORDER BY correct_answer;
