-- Biochemistry Chapter 6: DNA and Biotechnology, standalone questions
-- BATCH 1 of 3 (24 questions): Unit 1, DNA structure and chemistry (nucleotide anatomy, the double
--   helix and base-pairing specificity, Chargaff arithmetic + melting/hybridisation, aromatic
--   heterocycles and nucleotide derivatives) . Unit 2, eukaryotic chromosome organisation
--   (nucleosomes and histones, compaction states, supercoiling, telomere/centromere structure).
--
-- CHAPTER SIZE: 72 questions in three batches of 24, per the Step 1 pre-flight: replication, repair
-- and biotechnology are entirely unclaimed bank-wide, while cancer keys (Bio Ch2), telomere
-- consequences (Bio Ch3), mutation classification (Bio Ch12) and protein gels (Biochem Ch3) are
-- stripped out. ZERO cancer keys chapter-wide; the false "centromeres are high-GC" claim is never
-- a credited answer. FORWARD RESERVATION: the future Biochem Ch7 bank owns transcription, RNA
-- types, the genetic code, translation and gene regulation; Ch6 stops at the DNA molecule.
-- See biochemistry_ch6_dna_questions.plan.md for the full audit trail.
--
-- !! BATCH 1 OWNS THE CHAPTER DELETE !! Batches 2 and 3 are pure INSERTs and run after this file.

BEGIN;

DELETE FROM public.questions WHERE topic = 'DNA and Biotechnology';

-- Q1 . Nucleoside to nucleotide phosphate conversion . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Nucleoside to nucleotide phosphate conversion$q$,
    $q$A biochemist isolates a small molecule in which guanine is joined to deoxyribose through a single covalent bond at the sugar's 1' carbon, with no substituents present other than the sugar's own hydroxyl groups. To supply a collaborator's experiment, she must convert this molecule into a nucleotide. Which modification accomplishes the conversion?$q$,
    $q$[{"label":"A","text":"Formation of a glycosidic bond attaching a second nitrogenous base to the sugar"},{"label":"B","text":"Attachment of one to three phosphate groups at the 5' carbon of the sugar"},{"label":"C","text":"Addition of a hydroxyl group at the 2' carbon of the sugar"},{"label":"D","text":"Formation of a phosphodiester bond between the sugar's 3' carbon and a neighboring nucleotide"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the compositional distinction between a nucleoside and a nucleotide, the two levels of assembly used to describe nucleic acid building blocks. The answer is B because the molecule described, a nitrogenous base joined to a pentose through a glycosidic bond at the sugar's 1' carbon with no phosphate present, is a nucleoside, and the sole structural feature separating a nucleoside from a nucleotide is phosphorylation. A nucleoside consists of the sugar residue plus the base and nothing more. When one, two, or three phosphate groups are attached, conventionally at the 5' carbon of the sugar, the molecule becomes a nucleoside monophosphate, diphosphate, or triphosphate, all of which qualify as nucleotides. Because the nucleoside triphosphate is the activated monomer that polymerases incorporate during nucleic acid synthesis, adding phosphate at the 5' position is exactly the modification that converts the isolated nucleoside into the monomer class the collaborator needs. (Choice A) Each nucleic acid monomer carries exactly one nitrogenous base, attached through a single glycosidic bond at the 1' carbon. Adding a second base is not part of any monomer's structure and would not move the molecule from nucleoside to nucleotide status, which is defined by phosphate content alone. (Choice C) Installing a hydroxyl group at the 2' carbon would convert the deoxyribose of the described molecule into ribose. That change interconverts the DNA type and RNA type sugars, but it is irrelevant to the nucleoside versus nucleotide distinction, because both ribonucleosides and deoxyribonucleosides remain nucleosides until phosphorylated. (Choice D) A phosphodiester bond linking the 3' carbon of one sugar to a neighboring residue is the bridge formed when completed monomers are polymerized into a strand. It describes how nucleotides are joined together in a later step, not the modification that turns a single free nucleoside into a nucleotide. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall that phosphate groups at the sugar's 5' position are the defining difference between a nucleoside and a nucleotide and to select the addition that accomplishes that conversion.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q2 . Sugar composition distinguishing RNA from DNA . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Sugar composition distinguishing RNA from DNA$q$,
    $q$A newly isolated virus is analyzed to classify its genome. Complete hydrolysis of the genetic material releases pentose sugars that each bear hydroxyl groups at both the 2' and 3' carbons. Based on the sugar analysis alone, the genome should be classified as:$q$,
    $q$[{"label":"A","text":"RNA, because the deoxyribose found in DNA lacks one of those two hydroxyl groups"},{"label":"B","text":"DNA, because deoxyribose carries hydroxyl groups at both of those positions"},{"label":"C","text":"RNA, because uracil substitutes for thymine among the bases"},{"label":"D","text":"DNA, because only deoxyribose retains the hydroxyl group used in chain elongation"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests identification of a nucleic acid polymer from its sugar composition, the defining chemical difference between the building blocks of RNA and DNA. The answer is A because a pentose bearing hydroxyl groups at both the 2' and 3' carbons is ribose, and ribose appears only in RNA. Deoxyribose, the sugar of DNA, is named for what it is missing: the hydroxyl at the 2' position is replaced by a hydrogen atom. Both sugars retain the 3' hydroxyl, so that position cannot distinguish the two polymers; the 2' position is the diagnostic site. Since every sugar released from the genome carried the 2' hydroxyl, the polymer must be built from ribonucleotides, and the genome is RNA. The viral setting does not alter the chemistry; many viruses do carry RNA genomes, and the classification rests entirely on the hydrolysis data. (Choice B) This reverses the defining relationship. Deoxyribose is characterized by the absence of the 2' hydroxyl, so a sugar carrying hydroxyls at both the 2' and 3' positions cannot be deoxyribose, and the genome cannot be classified as DNA from this evidence. (Choice C) RNA does use uracil in place of thymine, and the conclusion that the genome is RNA happens to be correct, but the stated reason fails: the analysis examined only the sugars, and no base composition data were collected. A sound classification must rest on the evidence actually in hand, which is the hydroxyl pattern of the pentose, not the identity of the bases. (Choice D) Chain elongation proceeds through the 3' hydroxyl, and that group is present in both ribose and deoxyribose. Because it is shared machinery rather than a distinguishing feature, its presence cannot identify the polymer as DNA, and the claim that only deoxyribose retains it is false. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall that ribose alone retains the 2' hydroxyl and to apply that single compositional fact to classify an unknown nucleic acid from its hydrolysis products.$q$,
    'easy',
    '5D',
    $q$Nucleic Acids$q$,
    'biochemistry',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q3 . Phosphodiester backbone strand directionality . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Phosphodiester backbone strand directionality$q$,
    $q$A chemist synthesizes a linear, unbranched polynucleotide in which every internal linkage is a phosphodiester bridge joining the 3' carbon of one sugar to the 5' carbon of the next. No other covalent connections between residues are present. Which structural property must the finished strand possess?$q$,
    $q$[{"label":"A","text":"Chemically identical termini, because every internal phosphodiester bridge has the same composition"},{"label":"B","text":"Two termini that each end in a free 3' hydroxyl, because polymerization releases all terminal phosphates as pyrophosphate"},{"label":"C","text":"Directionality that appears only after a complementary strand pairs with it in antiparallel orientation"},{"label":"D","text":"Two chemically distinct termini, because one end retains an unlinked 5' carbon and the other an unlinked 3' carbon"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests why the sugar phosphate backbone gives a polynucleotide strand intrinsic directionality. The answer is D because the phosphodiester bridge is asymmetric: it always connects the 3' carbon of one sugar to the 5' carbon of the next, so a linear chain built from this repeating linkage must terminate differently at its two ends. Following the chain residue by residue, each sugar's 3' carbon points toward one neighbor and its 5' carbon toward the other. At one terminus the 5' carbon has no partner and remains unlinked, typically bearing a phosphate group, while at the opposite terminus the 3' carbon remains unlinked and carries a free hydroxyl. Because the two ends are chemically nonequivalent, the strand has an inherent direction, which is why sequences are always written with 5' and 3' labels and read by convention from the 5' end toward the 3' end. This polarity belongs to the covalent backbone itself and exists in a single strand in isolation, before any base pairing occurs. (Choice A) The internal bridges are indeed compositionally repetitive, but repetition of an asymmetric unit does not produce symmetric ends. Precisely because each bridge points from a 3' position to a 5' position, the two termini are guaranteed to differ, so the ends cannot be chemically identical. (Choice B) Pyrophosphate release during enzymatic synthesis removes two of the three phosphates from each incoming triphosphate, but the remaining phosphate is incorporated into the backbone, and the first residue's free 5' end is never consumed. A strand does not terminate in two 3' hydroxyls. (Choice C) Antiparallel orientation describes how two complementary strands align within a duplex. That arrangement is a genuine feature of double stranded DNA, but each single strand already possesses full directionality from its own backbone; pairing reveals nothing that was not present beforehand. This is a Scientific Reasoning and Problem Solving question because it requires you to reason from the asymmetry of a repeating 3' to 5' linkage to the necessary conclusion that the finished strand has two chemically distinct ends and therefore an intrinsic direction.$q$,
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

-- Q4 . Backbone polyanion charge behavior prediction . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Backbone polyanion charge behavior prediction$q$,
    $q$Researchers compare two 24 residue polymers that carry identical base sequences: a standard DNA oligonucleotide and a peptide nucleic acid (PNA) analog whose backbone consists of amide linkages in place of sugar phosphate units. Both polymers are studied in buffer at pH 7.4. In an applied electric field, the DNA migrates steadily toward the positive electrode. The DNA also binds tightly to purified histone octamers, whose surfaces are rich in lysine and arginine residues. Which set of results should the researchers predict for the PNA in the same two assays?$q$,
    $q$[{"label":"A","text":"Migration toward the negative electrode with strong histone binding, because the amide backbone becomes protonated at pH 7.4"},{"label":"B","text":"Migration identical to the DNA's, because the nitrogenous bases shared by both polymers determine the net charge"},{"label":"C","text":"Minimal migration in the field and weak histone binding, because the analog lacks the ionized phosphates that give DNA about one negative charge per residue"},{"label":"D","text":"Migration about half as far as the DNA's, because each amide linkage carries half of a negative charge at pH 7.4"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests the backbone's behavior as a uniform polyanion, reasoning from composition to predict electrophoretic and protein binding behavior. The answer is C because both observed behaviors of the DNA are consequences of its phosphate groups: at pH 7.4 each phosphodiester phosphate is ionized and contributes one negative charge, so the 24 residue oligonucleotide carries roughly 24 negative charges spaced evenly along its length. That uniform negative charge pulls the DNA toward the positive electrode in an electric field and drives electrostatic attraction to the positively charged lysine and arginine side chains on the histone surface. The PNA analog replaces the entire sugar phosphate backbone with amide linkages, which are neutral at physiological pH, eliminating the ionizable groups. With essentially no net charge, the analog experiences almost no electrophoretic force and loses the electrostatic component that dominates histone binding, so minimal migration and weak binding are the supported predictions. The shared bases are uncharged at physiological pH and contribute negligibly to net charge in either polymer. (Choice A) This inverts the charge logic. Amide linkages are not protonated at pH 7.4, and nothing in the analog's composition generates a positive backbone, so movement toward the negative electrode is unsupported, and a positively charged polymer would in any case be predicted to bind the cationic histone surface poorly, not strongly. (Choice B) The bases do not set net charge; DNA's mobility comes from its phosphates, which is why DNA fragments of any sequence migrate toward the positive electrode. Two polymers that share bases but differ in backbone charge will not migrate alike. (Choice D) There is no basis for assigning half a charge to each amide linkage. Amides are neutral at physiological pH, so the analog's charge per residue is approximately zero, not one half, and its predicted migration is minimal rather than proportionally reduced. This is a Data-based and Statistical Reasoning question because it asks you to use the reported migration and binding data for DNA to infer the underlying charge property of its backbone and extrapolate that reasoning to predict the behavior of a backbone modified analog.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', NULL FROM q;

-- Q5 . Antiparallel architecture of the double helix . medium . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Antiparallel architecture of the double helix$q$,
    $q$In the Watson and Crick model of B-DNA, two polynucleotide strands wind around a common helical axis. A student examining a physical model of the duplex records the following observations:

I. The sugar phosphate backbones lie on the exterior of the helix, facing the aqueous surroundings
II. Both strands can be read 5' to 3' while moving in the same direction along the helix axis
III. Each rung of the helix pairs a two ring purine with a single ring pyrimidine

Which of the observations are consistent with the accepted structure?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and III only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the defining architecture of the Watson and Crick double helix: where the backbones sit, how the strands are oriented, and what occupies each rung. The answer is B because statements I and III describe genuine features of B-DNA, while statement II contradicts the antiparallel arrangement of the two strands. In the accepted model, the charged, hydrophilic sugar phosphate backbones face outward into the surrounding water, while the flat nitrogenous bases stack inward and face each other like the rungs of a ladder, making statement I consistent. Each rung holds one two ring purine hydrogen bonded to one single ring pyrimidine, and this pairing rule is what keeps the helix diameter uniform at about 2 nm along its entire length, making statement III consistent as well. Statement II fails because the two strands run in opposite directions: reading one strand 5' to 3' carries you one way along the helix axis, while reading its partner 5' to 3' carries you the opposite way, so the 3' end of each strand lies across from the 5' end of the other. (Choice A) correctly retains the backbone statement but wrongly discards statement III; purine to pyrimidine pairing is not an optional feature, since a rung built from two purines would be too wide and one built from two pyrimidines too narrow to preserve a constant diameter. (Choice C) endorses the claim that both strands can be read 5' to 3' in the same direction, which would describe a parallel duplex, the exact reverse of the head to tail orientation the model requires, and it simultaneously rejects the true statement about backbone placement. (Choice D) accepts all three statements; a student who pictures the two strands as identical arrows pointing the same way has overlooked that the sugars in the two backbones are oriented oppositely, which is what the term antiparallel captures operationally. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall the structural features of the Watson and Crick model and identify which of several listed observations belong to it.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    1,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$accepts one true feature, denies another$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$parallel instead of antiparallel$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$strands as identical same direction arrows$q$ FROM q;

-- Q6 . Donor acceptor complementarity in base pairing . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Donor acceptor complementarity in base pairing$q$,
    $q$A student building a scale model of B-DNA proposes pairing adenine with cytosine, pointing out that this combination still places one purine opposite one pyrimidine across the helix axis. In cellular DNA, however, adenine pairs essentially only with thymine. Which factor best accounts for the failure of adenine and cytosine to form a stable Watson and Crick pair?$q$,
    $q$[{"label":"A","text":"An adenine and cytosine pair would exceed the uniform 2 nm diameter of the double helix"},{"label":"B","text":"The hydrogen bonding groups of cytosine are already occupied by interactions with the sugar phosphate backbone"},{"label":"C","text":"The hydrogen bond donor and acceptor groups of adenine and cytosine are not positioned in a mutually complementary pattern"},{"label":"D","text":"Adenine offers three hydrogen bonds while cytosine offers only two, leaving one bond unsatisfied"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question probes why base pairing in DNA is specific, testing the distinction between the size constraint on a base pair and the complementarity constraint imposed by hydrogen bonding groups. The answer is C because pairing specificity comes from the spatial matching of hydrogen bond donors to hydrogen bond acceptors across the helix axis. Adenine presents a pattern of donor and acceptor groups that aligns with the complementary pattern on thymine, allowing two hydrogen bonds, while guanine aligns with cytosine to form three. When adenine faces cytosine, the groups do not line up in a mutually complementary way, so the bases cannot form the properly oriented hydrogen bonds that a stable Watson and Crick pair requires. Satisfying the purine with pyrimidine size rule is therefore necessary but not sufficient: an acceptable pair must be the right width and must present matching bonding patterns, and an adenine cytosine pair fails the second test. (Choice A) misapplies a real rule; the uniform 2 nm diameter argument excludes purine with purine pairs, which would be too wide, and pyrimidine with pyrimidine pairs, which would be too narrow, but the stem itself notes that adenine with cytosine keeps one purine opposite one pyrimidine, so the rung would be acceptably sized. (Choice B) invents an interaction that does not occur; in the duplex the bases point inward and away from the sugar phosphate backbone, and the backbone forms the covalently linked exterior of the helix rather than consuming the bases' hydrogen bonding capacity. (Choice D) misassigns the real bond counts; it is the adenine thymine pair that forms two hydrogen bonds and the guanine cytosine pair that forms three, and in any case a simple mismatch in the number of available bonds is not the underlying reason the pairing fails, since the deeper problem is that the groups present are not positioned to meet their partners. This is a Scientific Reasoning and Problem Solving question because it requires you to apply the geometric and complementarity constraints on base pairing to explain why a hypothetical adenine cytosine pair cannot form.$q$,
    'medium',
    '5D',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$real rule, wrong case$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$invented structural interaction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$real numbers misassigned$q$ FROM q;

-- Q7 . Complementary strand derivation with correct polarity . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Complementary strand derivation with correct polarity$q$,
    $q$A biochemist records one strand of a DNA duplex in an unconventional orientation, writing it in her notebook as 3'-TACGGC-5'. She asks a rotation student to report the sequence of the complementary strand written in the conventional 5' to 3' direction. Which sequence should the student report?$q$,
    $q$[{"label":"A","text":"5'-GCCGTA-3'"},{"label":"B","text":"5'-TACGGC-3'"},{"label":"C","text":"5'-AUGCCG-3'"},{"label":"D","text":"5'-ATGCCG-3'"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests the derivation of a complementary DNA sequence with correct polarity when the template is presented in an unconventional written orientation. The answer is D because the partner strand must be both base complementary and antiparallel to the given strand. The template is written 3'-TACGGC-5', so its left end is a 3' end; the complementary strand therefore has its 5' end on the left, and reading left to right, T pairs with A, A with T, C with G, G with C, G with C, and C with G, giving 5'-ATGCCG-3'. Because the antiparallel relationship is already encoded in the 3' to 5' labels of the given strand, the complement can be written straight across without reversing the letter order; the familiar reverse and complement procedure applies only when the given strand is written conventionally, 5' to 3'. A quick check confirms the result: rewriting the template conventionally as 5'-CGGCAT-3' and then reverse complementing it returns the same 5'-ATGCCG-3'. (Choice A) is the reflexive reverse complement applied without checking the polarity labels; reversing a strand that was already written 3' to 5' undoes the reversal that was built into the notation, and the resulting sequence could only sit opposite the template if the two strands ran parallel, which the double helix forbids. (Choice B) flips the polarity labels of the given strand without complementing a single base; it is simply the template itself relabeled, and a strand does not pair with an uncomplemented copy of its own sequence. (Choice C) pairs every position correctly and carries the correct polarity but places uracil opposite adenine; uracil is the base found in RNA in place of thymine, so the complement of a DNA strand must contain thymine at those positions. This is a Scientific Reasoning and Problem Solving question because it requires you to integrate base complementarity with strand directionality and adapt a practiced procedure to a template presented in the reverse of its conventional orientation.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$complement written with inverted polarity$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$one of two required steps omitted$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$right logic, wrong molecule composition$q$ FROM q;

-- Q8 . Uracil as compositional marker of RNA . easy . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Uracil as compositional marker of RNA$q$,
    $q$A virologist hydrolyzes the purified genome of a newly isolated virus and recovers adenine, guanine, cytosine, and uracil, with no thymine detected. A bacteriophage DNA control processed identically yields thymine and no uracil. The viral genome is most likely composed of which molecule?$q$,
    $q$[{"label":"A","text":"RNA"},{"label":"B","text":"Single stranded DNA produced by strand separation during the hydrolysis"},{"label":"C","text":"DNA whose thymine residues lost their methyl groups during sample processing"},{"label":"D","text":"DNA in which uracil normally substitutes for cytosine"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests the compositional difference between DNA and RNA, specifically the use of uracil in place of thymine. The answer is A because a genome that yields adenine, guanine, cytosine, and uracil, with no thymine at all, carries the base signature of RNA. The two nucleic acids share three of their four bases; on the base side, the diagnostic difference is that DNA uses thymine where RNA uses uracil. The bacteriophage DNA control is decisive: it went through the identical hydrolysis and workup yet delivered thymine and no uracil, demonstrating that the procedure neither destroys thymine nor manufactures uracil, so the uracil recovered from the viral sample must have been present in the intact genome. Recognizing this swap allows base composition alone to identify an unknown nucleic acid before any sugar analysis is performed. (Choice B) confuses strandedness with composition; heating can separate a duplex into single strands, but denaturation only disrupts the hydrogen bonds between the strands and leaves every base chemically intact, so single stranded DNA would still deliver thymine rather than uracil. (Choice C) leans on a real structural relationship, since thymine is a methylated relative of uracil, but the claim fails on the evidence; if sample processing stripped methyl groups from thymine, the identically processed DNA control would also have shown uracil in place of its thymine, and it did not. (Choice D) names the wrong substitution; uracil stands in for thymine, not for cytosine, and the hydrolysate itself refutes the claim because cytosine was recovered in full alongside the uracil. This is a Scientific Reasoning and Problem Solving question because it requires you to infer the identity of an unknown nucleic acid from its base composition while using a control to rule out artifactual explanations.$q$,
    'easy',
    '5D',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$real phenomenon, irrelevant variable$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true chemistry defeated by the control$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$wrong base named in the swap$q$ FROM q;

-- Q9 . Base composition strandedness inference . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Base composition strandedness inference$q$,
    $q$A virology laboratory hydrolyzes the purified DNA genomes of two newly isolated viruses and quantifies the released bases. Virus 1 yields adenine 22 percent, thymine 22 percent, guanine 28 percent, and cytosine 28 percent. Virus 2 yields adenine 26 percent, thymine 32 percent, guanine 24 percent, and cytosine 18 percent. Which conclusion about the physical form of these genomes is best supported by the data?$q$,
    $q$[{"label":"A","text":"Both genomes are double stranded, because in each sample the total purines equal the total pyrimidines"},{"label":"B","text":"The Virus 1 genome is single stranded, because its GC content exceeds its AT content"},{"label":"C","text":"The Virus 2 genome is single stranded, because its unequal adenine and thymine percentages are impossible for a fully base-paired duplex"},{"label":"D","text":"The Virus 1 genome is single stranded and the Virus 2 genome is double stranded, because duplex DNA tolerates unequal A and T while a lone strand must balance them"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests Chargaff's base composition rules and the inference they license about whether a DNA sample is double stranded or single stranded. The answer is C because in any base-paired duplex every adenine on one strand is matched by a thymine on the other and every guanine is matched by a cytosine, so across the whole molecule the percentage of A must equal the percentage of T and the percentage of G must equal the percentage of C. Virus 1 obeys both equalities, with 22 percent A against 22 percent T and 28 percent G against 28 percent C, exactly the signature expected of duplex DNA. Virus 2 shows 26 percent adenine against 32 percent thymine and 24 percent guanine against 18 percent cytosine. No fully base-paired double helix can generate unequal A and T or unequal G and C, so the Virus 2 genome must be single stranded, since the composition of a lone strand is not constrained by pairing with a partner. (Choice A) It is true that purines and pyrimidines each total 50 percent in both samples, but this aggregate equality is a weaker condition than the pairwise equalities that base pairing enforces; a single strand can meet it coincidentally, as Virus 2 does, so it cannot establish that either genome is a duplex. (Choice B) A GC content above 50 percent influences the stability and melting behavior of a duplex, not whether the molecule is a duplex in the first place; many double-stranded genomes are strongly GC rich, so the composition of Virus 1 is fully compatible with two paired strands. (Choice D) This reverses the correct assignments. Equal A and T together with equal G and C is precisely the pattern that interstrand pairing enforces, so the data argue that Virus 1 is the duplex, and no rule obliges an unpaired strand to balance its own adenine and thymine. This is a Data-based and Statistical Reasoning question because it requires testing measured base composition data from each sample against the quantitative constraints that double-stranded base pairing imposes.$q$,
    'hard',
    '5D',
    $q$Nucleic Acids$q$,
    'biochemistry',
    4,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$true fact, insufficient condition$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$confuses stability variable with strandedness$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$rule inversion$q$ FROM q;

-- Q10 . GC content melting temperature ranking . hard . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$GC content melting temperature ranking$q$,
    $q$Three double-stranded DNA fragments of equal length are dissolved in identical buffers. Fragment X contains 20 percent adenine, Fragment Y contains 32 percent cytosine, and Fragment Z contains 35 percent thymine. When the three solutions are heated gradually, in what order, from lowest to highest, will the fragments reach the temperature at which their two strands fully separate?$q$,
    $q$[{"label":"A","text":"Fragment Z, then Fragment X, then Fragment Y"},{"label":"B","text":"Fragment Y, then Fragment X, then Fragment Z"},{"label":"C","text":"Fragment X, then Fragment Y, then Fragment Z"},{"label":"D","text":"Fragment Z, then Fragment Y, then Fragment X"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests the relationship between GC content and DNA melting temperature, combined with Chargaff arithmetic needed to extract GC content from a single quoted base percentage. The answer is A because each percentage must first be converted into a GC content using the base pairing equalities. In Fragment X, 20 percent adenine implies 20 percent thymine, leaving 60 percent of all bases as guanine plus cytosine. In Fragment Y, 32 percent cytosine implies 32 percent guanine, giving a GC content of 64 percent. In Fragment Z, 35 percent thymine implies 35 percent adenine, leaving only 30 percent GC. A GC pair is held by three interstrand hydrogen bonds while an AT pair is held by two, and melting temperature rises steadily, in a roughly linear fashion, as GC content increases. The strands therefore separate in order of increasing GC content: Z at 30 percent melts first, then X at 60 percent, then Y at 64 percent. Base stacking also contributes strongly to duplex stability, but the extra hydrogen bond carried by every GC pair is what makes the separation temperature climb as GC content rises. (Choice B) This is the exact reverse ordering, which would follow from the mistaken belief that AT-rich DNA resists heat best; AT pairs contribute fewer interstrand hydrogen bonds, so AT-rich duplexes melt at lower, not higher, temperatures. (Choice C) This ordering ranks the fragments by the raw quoted percentages, 20 then 32 then 35, skipping the base pairing conversion entirely; because a different base is quoted for each fragment, the raw numbers are not comparable measures of duplex stability. (Choice D) This ordering results from treating the 32 percent cytosine of Fragment Y as its total GC content rather than doubling it to include the paired guanine, an error that understates the GC content of Y by half and incorrectly drops it below Fragment X. This is a Scientific Reasoning and Problem Solving question because it requires converting single-base percentages into GC contents and then applying the hydrogen bonding relationship that links GC content to strand separation temperature.$q$,
    'hard',
    '5D',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$direction flip$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$skipped conversion step$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$factor-of-two aggregation error$q$ FROM q;

-- Q11 . Thermal denaturation and slow reannealing . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Thermal denaturation and slow reannealing$q$,
    $q$A technician heats a solution of purified duplex DNA to 95 degrees Celsius until the two strands separate completely, then allows the solution to cool slowly over several hours. Analysis of the cooled sample reveals full-length double-stranded molecules indistinguishable from the starting material, even though no enzymes were present. Which property of the DNA duplex makes this recovery possible?$q$,
    $q$[{"label":"A","text":"Heating hydrolyzes the phosphodiester backbone into free nucleotides, which spontaneously repolymerize in the correct order as the solution cools"},{"label":"B","text":"Heating disrupts only the hydrogen bonding and stacking interactions between strands, so the covalently intact complementary strands can re-pair during slow cooling"},{"label":"C","text":"Each separated strand folds back on itself into short hairpin duplexes, and these intramolecular structures account for the double-stranded material observed"},{"label":"D","text":"Duplex recovery depends on an abrupt drop in temperature that traps the strands together, so re-pairing was completed in the first moments of cooling"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the chemical nature of DNA denaturation and reannealing. The answer is B because the two strands of a DNA duplex are joined only by noncovalent forces, chiefly the hydrogen bonds between complementary bases together with base stacking, while each individual strand is held together internally by covalent phosphodiester bonds. Temperatures near 95 degrees Celsius supply enough energy to disrupt the noncovalent interstrand interactions but far too little to hydrolyze the covalent backbone, so denaturation releases two intact, full-length complementary strands into solution. During slow cooling the strands collide repeatedly, sample possible pairings, and progressively zip back together wherever extended complementarity exists, regenerating the original duplex without any enzymatic help. Strongly alkaline conditions separate the strands in the same covalent-bond-sparing way, by disrupting the hydrogen bonding between the bases rather than cleaving the backbone. (Choice A) Heat denaturation does not hydrolyze phosphodiester bonds; if the strands had truly been broken into free nucleotides, no template information would remain, and spontaneous repolymerization into the original sequence in the absence of enzymes could not occur. (Choice C) Individual strands can fold back into short intramolecular hairpins, but such structures are partial, leave loops unpaired, and would not reproduce full-length duplex molecules indistinguishable from the starting material. (Choice D) This reverses the kinetics of reannealing: an abrupt temperature drop tends to trap strands in mismatched or intramolecular structures before correct partners are found, whereas the slow cooling described is exactly what allows fully complementary strands to locate one another. This is a Scientific Reasoning and Problem Solving question because it requires distinguishing the noncovalent interactions broken during thermal denaturation from the covalent backbone that survives it and reasoning about why slow cooling regenerates the duplex.$q$,
    'easy',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$denaturation breaks covalent bonds$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$real phenomenon, wrong explanation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$kinetics inversion$q$ FROM q;

-- Q12 . Probe hybridization requires denatured target . medium . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Probe hybridization requires denatured target$q$,
    $q$A microbiologist suspects that a gene present in bacterial species 1 also occurs in the genome of bacterial species 2. She prepares a fluorescently labelled single-stranded DNA fragment matching part of the species 1 gene and mixes it with fragmented double-stranded genomic DNA purified from species 2. Which additional step is required for the labelled fragment to signal the presence of the shared sequence?$q$,
    $q$[{"label":"A","text":"Add DNA ligase so the labelled fragment can be covalently joined to the species 2 sequence it detects"},{"label":"B","text":"Keep the species 2 DNA fully double stranded so the labelled fragment can slot between the paired bases of the intact helix"},{"label":"C","text":"Redesign the labelled fragment so it is identical in sequence to its target strand, because hybridization joins strands of matching sequence"},{"label":"D","text":"Denature the species 2 DNA so the labelled fragment can form hydrogen-bonded base pairs with a complementary single strand"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests the principle of nucleic acid hybridization, the process by which a labelled single-stranded probe locates a complementary sequence in a target sample. The answer is D because a probe can only report the presence of a shared sequence by forming hydrogen-bonded base pairs with a complementary strand, and the bases of the species 2 genomic DNA are unavailable for new pairing while they remain locked inside an intact double helix. Denaturing the species 2 DNA, whether by heat or by alkaline conditions, exposes single strands whose bases are free to pair. When the mixture is then allowed to hybridize, the labelled fragment anneals wherever a complementary stretch exists, and its label marks the resulting hybrid duplex; if the sequence is absent, the probe finds no partner and produces no stable, detectable signal once unbound probe is removed. The specificity of the entire experiment comes from complementarity alone, while the fluorescent label merely makes the hybrid visible. (Choice A) Hybridization is noncovalent: the probe is retained by base pairing alone, and DNA ligase, an enzyme that seals covalent breaks in a phosphodiester backbone, plays no role in whether the probe finds and binds its target. (Choice B) A single-stranded probe cannot slot into an intact helix, because the hydrogen bond donors and acceptors of the target bases are already fully occupied by the target's own complementary strand; this is precisely why denaturation is the required step. (Choice C) Hybridization joins complementary strands, not identical ones; moreover, because the denatured double-stranded target contributes both of its strands to the mixture, a probe matching either strand of the species 1 gene will find a complementary partner if the sequence is shared. This is a Reasoning about the Design and Execution of Research question because it asks which experimental step makes probe-based sequence detection possible and why the base pairing principle underlying hybridization demands it.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$wrong technique step imported$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$probe invades intact helix$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$identical versus complementary flip$q$ FROM q;

-- Q13 . Huckel rule applied to base analogs . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Huckel rule applied to base analogs$q$,
    $q$A medicinal chemist synthesizes a cytosine analog in which the six-membered ring is expanded to an eight-membered ring containing two nitrogen atoms. The analog remains cyclic and planar, and every ring atom is sp2 hybridized and contributes to a continuous conjugated system that contains eight pi electrons. Based on these features, the analog is:$q$,
    $q$[{"label":"A","text":"aromatic, because a cyclic, planar, fully conjugated ring meets all of the requirements for aromaticity"},{"label":"B","text":"not aromatic, because no nonnegative integer value of n makes 4n+2 equal to eight"},{"label":"C","text":"not aromatic, because a ring containing nitrogen atoms cannot be aromatic"},{"label":"D","text":"aromatic, because eight pi electrons satisfies the 4n+2 count when n equals two"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the criteria that make the nitrogenous bases aromatic heterocycles and asks you to apply those criteria to a modified base. The answer is B because aromaticity requires four conditions to hold simultaneously: the ring must be cyclic, it must be planar, its pi system must be fully conjugated around the entire ring, and that pi system must contain 4n+2 pi electrons for some nonnegative integer value of n. The described analog meets the first three conditions but fails the electron count. Setting 4n+2 equal to eight gives n equal to 1.5, which is not an integer, so eight is not an allowed count; the permitted counts run two, six, ten, fourteen, and so on. The natural pyrimidines cytosine, thymine, and uracil each present a six pi electron system, which fits the rule with n equal to one, and the fused rings of the purines adenine and guanine likewise satisfy the count, which is why all five natural bases are aromatic even though nitrogen replaces carbon at several ring positions. A base analog that fails the count loses the extra thermodynamic stability and the rigid, flat geometry that aromaticity confers on the natural bases. (Choice A) lists three genuinely necessary conditions, and the analog does satisfy all three, but they are not sufficient: the pi electron count is an independent fourth requirement, and a cyclic, planar, fully conjugated ring with the wrong count is not aromatic. (Choice C) is a misconception: aromatic rings may contain ring atoms of more than one element, and the nucleobases themselves are nitrogen containing heterocycles that are fully aromatic, so the presence of two ring nitrogens does not by itself disqualify the analog. (Choice D) misapplies the arithmetic of the rule: with n equal to two, 4n+2 equals ten pi electrons, not eight, so no integer choice of n rescues an eight electron system. This is a Scientific Reasoning and Problem Solving question because it requires applying the Huckel electron count to an unfamiliar ring system instead of recalling the aromaticity of a memorized base.$q$,
    'medium',
    '5D',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$necessary-conditions-treated-as-sufficient$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$heteroatom-disqualifies-aromaticity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$plug-in-arithmetic-error$q$ FROM q;

-- Q14 . Base stacking contribution to duplex stability . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Base stacking contribution to duplex stability$q$,
    $q$Researchers measure the melting temperature (Tm) of three 12-base-pair DNA duplexes that differ only at a single central position. In Duplex I the position holds a natural A:T pair, and Tm is 64 C. In Duplex II the adenine is replaced by a planar aromatic analog of identical size that lacks all hydrogen bond donors and acceptors, and Tm falls to 58 C. In Duplex III the adenine is replaced by a nonplanar, saturated ring that retains adenine's exact hydrogen bond donor and acceptor pattern, and Tm falls to 55 C. All duplexes are otherwise identical in sequence and are measured under the same solution conditions. Which conclusion is best supported by the data?$q$,
    $q$[{"label":"A","text":"Hydrogen bonding between paired bases is the only interaction stabilizing the duplex, since removing the donors and acceptors lowered the Tm"},{"label":"B","text":"Base stacking destabilizes the double helix, because the stacking-competent analog in Duplex II produced a Tm below that of Duplex I"},{"label":"C","text":"Stacking between planar aromatic surfaces stabilizes the duplex on a scale comparable to hydrogen bonding, since eliminating stacking lowered the Tm at least as much as eliminating pairing"},{"label":"D","text":"Duplex III melted at the lowest temperature because an A:T pair shares two hydrogen bonds while a G:C pair shares three"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests structure to stability reasoning: how the aromatic planarity of the bases allows them to stack, and how stacking and hydrogen bonded pairing together stabilize the double helix. The answer is C because the two substitutions dissect the two interactions independently. Duplex II removes only hydrogen bonding while preserving a flat aromatic surface that can still stack, and its Tm falls by 6 C relative to the natural duplex. Duplex III preserves the full donor and acceptor pattern but replaces the flat aromatic ring with a puckered saturated one that cannot stack face to face with its neighbors, and its Tm falls by 9 C. Because the stacking deficient duplex loses at least as much thermal stability as the pairing deficient duplex, the data show that stacking of planar aromatic surfaces is a stabilizing contribution comparable in magnitude to hydrogen bonding, and that duplex stability depends on both together. This is the physical payoff of base aromaticity: aromatic rings are rigid and flat, so adjacent bases can lie face to face inside the helix and interact across their pi surfaces. (Choice A) is the classic misconception that hydrogen bonds alone hold the two strands together; if that were true, Duplex III, which retains every donor and acceptor, would have melted at the same temperature as Duplex I, yet it melted 9 C lower. (Choice B) reverses the relationship: Duplex II melts below Duplex I because it lost its hydrogen bonds, not because its intact stacking is destabilizing; stacking is a favorable interaction in every duplex measured. (Choice D) cites a true fact about A:T pairs sharing two hydrogen bonds and G:C pairs sharing three, but no pair identity changed between these duplexes: Duplex III retains adenine's exact donor and acceptor pattern, so the two versus three bond count cannot explain any Tm difference in this experiment. This is a Data-based and Statistical Reasoning question because it requires comparing melting temperature decreases across engineered duplexes to apportion duplex stability between base stacking and base pairing.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$H-bonds-alone-hold-DNA-together$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$favorable-interaction-read-as-unfavorable$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$true-fact-wrong-experiment$q$ FROM q;

-- Q15 . Coenzymes as adenine nucleotide derivatives . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Coenzymes as adenine nucleotide derivatives$q$,
    $q$Beyond serving as the monomers of nucleic acids, nucleotides appear throughout the cell in modified forms. A student compares the full structures of three common cellular molecules, looking for shared building blocks. Which of the following molecules contain an adenine base bonded to a ribose sugar that carries at least one phosphate group?

I. Adenosine triphosphate (ATP)
II. Nicotinamide adenine dinucleotide (NAD+)
III. Flavin adenine dinucleotide (FAD)$q$,
    $q$[{"label":"A","text":"I, II, and III"},{"label":"B","text":"I only"},{"label":"C","text":"I and II only"},{"label":"D","text":"II and III only"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests recognition of common coenzymes and cofactors as nucleotide derivatives based on their composition. The answer is A because all three molecules contain a complete adenine nucleotide unit: an adenine base attached through a glycosidic bond to ribose, with phosphate bonded at the sugar's 5' position. ATP is adenosine, meaning adenine plus ribose, carrying a chain of three phosphate groups on that 5' carbon. NAD+ is a dinucleotide: one half is a nicotinamide base joined to its own ribose and phosphate, the other half is an adenine nucleotide, and the two halves are connected through their phosphate groups. FAD is assembled the same way, with a flavin containing half linked through a phosphate bridge to an adenine nucleotide, which is why the phrase adenine dinucleotide appears in both coenzyme names. Recognizing this shared architecture is the point of the question: many of the cell's cofactors are built on a nucleotide scaffold, so the adenine plus ribose plus phosphate motif recurs far beyond DNA and RNA themselves. (Choice B) reflects the misconception that ATP is the only free nucleotide outside of nucleic acids; NAD+ and FAD each contain an intact adenine nucleotide as a full half of their structures. (Choice C) is partially correct in including ATP and NAD+ but omits FAD; because the flavin half of FAD is derived from the vitamin riboflavin, students often overlook the molecule's second half, which is an ordinary adenine nucleotide identical in composition to the one in NAD+. (Choice D) follows the surface cue of the word dinucleotide in the two coenzyme names while excluding ATP, but ATP is itself a nucleotide by composition, adenine plus ribose plus phosphate, and needs no dinucleotide label to qualify. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recognize the shared adenine, ribose, and phosphate architecture that makes ATP, NAD+, and FAD nucleotide derivatives.$q$,
    'easy',
    '5D',
    $q$Nucleic Acids$q$,
    'biochemistry',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$cofactors-not-recognized-as-nucleotides$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$half-the-structure-overlooked$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$name-cue-over-composition$q$ FROM q;

-- Q16 . Histone octamer core particle composition . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Histone octamer core particle composition$q$,
    $q$Brief digestion of eukaryotic chromatin with a nonspecific nuclease leaves protected particles, each containing about 146 base pairs of DNA bound tightly to eight polypeptide chains. Based on this protected footprint, the protein component of each particle consists of:$q$,
    $q$[{"label":"A","text":"two copies each of histones H2A, H2B, H3, and H4"},{"label":"B","text":"two copies each of histones H1, H2A, H2B, and H3"},{"label":"C","text":"one copy each of eight distinct histone proteins"},{"label":"D","text":"a single central H1 molecule surrounded by six core histone subunits"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests knowledge of the composition of the nucleosome core particle, the fundamental repeating unit of eukaryotic chromatin. The answer is A because a nuclease-protected fragment of about 146 base pairs bound to eight polypeptides is the signature of the nucleosome core particle, in which DNA winds roughly 1.65 turns around a histone octamer containing two copies each of histones H2A, H2B, H3, and H4. Nucleases preferentially cleave the exposed linker DNA that runs between adjacent particles, while the DNA physically wrapped around the protein spool is shielded from digestion, which is why a uniform protected fragment length survives brief treatment. The octamer itself assembles from two H2A-H2B dimers and one H3-H4 tetramer, giving four histone types at exactly two copies apiece. In intact chromatin these particles repeat along the entire length of the molecule, producing the characteristic beaded appearance and achieving the first roughly sevenfold shortening of the helix. Recognizing the 146 base pair protected footprint as the nucleosomal wrap is the inference that identifies the particle and therefore fixes its protein stoichiometry. (Choice B) Histone H1 is a genuine chromatin protein, but it is the linker histone: it sits outside the core particle at the site where DNA enters and exits the wrap, so it is never counted among the eight core subunits, and this option also omits H4 entirely. (Choice C) The count of eight polypeptides is correct, but they are not eight different proteins; only four histone types are present in the core, and each contributes exactly two copies. (Choice D) No accepted model places H1 at the center of the particle; H1 associates with the outside of the nucleosome, and the interior octamer is built exclusively from the four core histone types in equal pairs. This is a Knowledge of Scientific Concepts and Principles question because it asks for direct recall of the defined subunit stoichiometry of the histone octamer within the nucleosome core particle.$q$,
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
  SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q17 . Electrostatic basis of histone DNA binding . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Electrostatic basis of histone DNA binding$q$,
    $q$A biochemist isolates four abundant nuclear proteins and determines the mole percent of selected amino acids in each. Protein 1 contains 21 percent glutamate plus aspartate and 5 percent lysine plus arginine. Protein 2 contains 24 percent lysine plus arginine and 4 percent glutamate plus aspartate. Protein 3 contains 22 percent histidine and 4 percent lysine plus arginine. Protein 4 contains 45 percent leucine, isoleucine, and phenylalanine combined. Which protein will bind most tightly to the sugar-phosphate backbone of duplex DNA at pH 7.4?$q$,
    $q$[{"label":"A","text":"Protein 1"},{"label":"B","text":"Protein 2"},{"label":"C","text":"Protein 3"},{"label":"D","text":"Protein 4"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the chemical logic of histone-style DNA binding, namely how amino acid composition determines a protein's net charge at physiological pH and therefore its affinity for the polyanionic sugar-phosphate backbone. The answer is B because Protein 2 is dominated by lysine and arginine, whose side chains have pKa values far above 7.4, approximately 10.5 for lysine and 12.5 for arginine, so essentially every one of those residues carries a full positive charge at physiological pH. Duplex DNA presents a phosphate group on every nucleotide, making the backbone densely and uniformly negative regardless of sequence. A protein studded with fixed cationic side chains can therefore grip the backbone through electrostatic attraction at many points simultaneously, which is exactly the strategy histones use to spool DNA into nucleosomes. The prediction follows from the data alone: high basic residue content plus side chain pKa values well above the ambient pH equals strong, sequence-independent binding to DNA. (Choice A) Protein 1 is rich in glutamate and aspartate, which are deprotonated and negatively charged at pH 7.4; an anionic protein is repelled by the like-charged backbone, so this choice reverses the charge relationship that actually drives binding. (Choice C) Histidine is classed as a basic amino acid, but its imidazole side chain has a pKa near 6, so at pH 7.4 the large majority of histidine residues are neutral; a histidine-rich protein therefore carries far less positive charge than its classification suggests and cannot grip the backbone comparably. (Choice D) Branched-chain and aromatic hydrophobic residues drive protein core folding and membrane association; they offer no charged groups to pair with backbone phosphates and are not the basis of histone-like DNA binding. This is a Data-based and Statistical Reasoning question because it requires translating measured amino acid compositions into predicted ionization states at pH 7.4 and using that result to identify which protein can bind the DNA backbone electrostatically.$q$,
    'hard',
    '5D',
    $q$Nucleic Acids$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q18 . Linker histone H1 structural role . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Linker histone H1 structural role$q$,
    $q$A researcher treats isolated chromatin with a reagent that selectively extracts histone H1 while leaving every other chromatin protein in place. Compared with the untreated sample, the extracted material is expected to:$q$,
    $q$[{"label":"A","text":"dissociate completely into protein-free DNA and released histone octamers"},{"label":"B","text":"unwind the 146 base pair wrap from each octamer while keeping the thicker 30 nm fiber intact"},{"label":"C","text":"retain its extended beads-on-a-string organization while failing to compact into the thicker 30 nm fiber"},{"label":"D","text":"remain unchanged at every level of packing, since the eight core subunits alone direct all higher-order folding"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests the structural division of labor between the linker histone H1 and the eight core histones. The answer is C because H1 is not part of the histone octamer; it binds on the outside of each nucleosome at the point where the DNA enters and exits the particle, clamping the wrap in place and enabling strings of nucleosomes to condense into the thicker chromatin fiber. Removing H1 therefore leaves the core particles themselves intact, since the 146 base pair wrap is held by the octamer, but it deprives the sample of the protein that stabilizes the next level of packing. The predicted result is material frozen at the extended beads-on-a-string stage: nucleosomes still present and properly wrapped, higher-order compaction impaired. The fiber level matters because it is where the molecule becomes roughly 50 times shorter than the extended helix, so its loss has a large effect on overall condensation even though every nucleosome remains in place. Because only H1 was extracted, the experiment cleanly separates the packaging role of the core octamer from the stabilizing role of the linker histone. (Choice A) Complete dissociation into naked DNA and free octamers would require stripping the core histones; the grip of the octamer on the wrapped DNA does not depend on H1, so the beaded particles persist after the extraction. (Choice B) This reverses the assignment of roles: the 146 base pair wrap around the octamer is the H1-independent feature, while the thicker fiber is precisely the level that fails to form without the linker histone. (Choice D) It is true that the eight core subunits alone are sufficient to build nucleosomes, but that truth does not extend upward through the hierarchy; fiber-level condensation requires H1, so the structure does not remain unchanged at every level. This is a Scientific Reasoning and Problem Solving question because it asks for a prediction of the structural consequence of selectively removing one chromatin protein, reasoned from which packing level that protein stabilizes.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q19 . Chromatin compaction hierarchy levels . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Chromatin compaction hierarchy levels$q$,
    $q$When interphase nuclei are gently lysed, the released genetic material appears in electron micrographs as an extended strand about 10 nm wide bearing regularly spaced bead-like particles joined by thin threads. Within an intact nucleus, the next higher level of compaction of this material is:$q$,
    $q$[{"label":"A","text":"a maximally condensed chromosome of the type seen in dividing cells"},{"label":"B","text":"a protein-free double helix approximately 2 nm in diameter"},{"label":"C","text":"looped domains anchored to a scaffold of fibrous non-histone proteins"},{"label":"D","text":"a coiled fiber about 30 nm in diameter produced by further winding of the nucleosome chain"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests the hierarchy of chromatin compaction as a purely structural ladder running from the naked helix to the fully condensed chromosome. The answer is D because the described material, a strand about 10 nm wide carrying regular bead-like particles joined by thin threads, is the beads-on-a-string form: nucleosomes connected by stretches of linker DNA. Inside the nucleus, the step immediately above this level is the coiling of the nucleosome chain upon itself into a fiber roughly 30 nm in diameter, a conformation that leaves the molecule about 50 times shorter than the bare double helix. The complete ladder runs from the 2 nm double helix, to the nucleosomal beads near 10 nm, to the 30 nm fiber, then to looped domains organized on protein scaffolds, and finally to the maximally condensed chromosome of dividing cells. Each rung is marked by a characteristic diameter, which is why the 10 nm measurement in the stem, together with the beaded morphology, is enough to place the sample on the ladder without naming it. Because the question asks only for the immediate next rung, the answer must be the 30 nm fiber rather than any later stage. (Choice A) The maximally condensed chromosome is the endpoint of the ladder, reached only after fiber formation and loop organization have already occurred; jumping straight to it skips the intermediate rungs. (Choice B) A protein-free helix about 2 nm across lies below the beaded form on the ladder; moving to it would be decompaction, the opposite direction from the change the question asks about. (Choice C) Looped domains anchored to fibrous scaffold proteins are a genuine level of the hierarchy, but they are built from the 30 nm fiber and therefore sit one rung too high to be the immediate next step. This is a Scientific Reasoning and Problem Solving question because it requires identifying an unnamed structure from its physical description and then placing it correctly within the ordered sequence of chromatin compaction levels.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q;

-- Q20 . Heterochromatin packing and probe accessibility . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Heterochromatin packing and probe accessibility$q$,
    $q$A biologist images interphase nuclei and observes dark-staining chromatin concentrated along the inner face of the nuclear envelope, with lighter-staining chromatin filling the interior. When a small fluorescent DNA-binding probe is added, the interior chromatin labels strongly while the peripheral chromatin labels only weakly. Which structural property of the peripheral chromatin most directly accounts for the weak labeling?$q$,
    $q$[{"label":"A","text":"Its histone proteins have been removed, leaving the DNA bare and unable to retain the probe"},{"label":"B","text":"Its cytosine bases carry covalent marks that occupy the probe's binding site"},{"label":"C","text":"Its DNA is maintained in a single-stranded form that the probe cannot recognize"},{"label":"D","text":"Its nucleoprotein fiber is folded into a highly condensed arrangement that restricts probe entry"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests the distinction between heterochromatin and euchromatin as compaction states of the eukaryotic chromatin fiber. The answer is D because dark-staining chromatin at the nuclear periphery is heterochromatin, the tightly packed form of the DNA-protein fiber, and that tight packing is the structural feature that limits access of soluble molecules to the underlying double helix. In an interphase nucleus, chromatin exists along a spectrum of compaction. Heterochromatin stains darkly precisely because a large mass of nucleoprotein is folded into a small volume, and it characteristically lies along the inner face of the nuclear envelope. Euchromatin stains lightly because its fiber is loosely arranged, leaving the DNA relatively exposed. A small probe that must physically reach the helix therefore labels the open interior chromatin efficiently and the compacted peripheral chromatin poorly. The same packing logic explains why heterochromatic regions are typically transcriptionally silent: machinery that must contact DNA is excluded just as the probe is. (Choice A) is backwards. Heterochromatin does not shed its histones; it retains the full nucleosomal organization and folds it further into higher-order structures. Stripping histones would expose the DNA and increase, not decrease, probe binding. (Choice B) invokes covalent base marks. Chemical modification of bases is a regulatory phenomenon acting at specific sites, whereas the staining and labeling pattern described here is a bulk physical property; a small DNA-binding probe reads the helix broadly rather than one modifiable position, so packing, not chemistry, explains the difference. (Choice C) is false: chromatin in both compaction states consists of double-stranded DNA wrapped in protein. Single-stranded DNA appears only transiently, for example at replication forks, and is never the stable bulk state of a chromosomal region. (Choice D) correctly identifies condensation of the nucleoprotein fiber as the accessibility barrier. This is a Scientific Reasoning and Problem Solving question because it requires connecting a staining and probe-labeling observation to the underlying compaction difference between heterochromatin and euchromatin rather than recalling a stated definition.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- Q21 . Supercoiling strain relief by nicking enzymes . hard . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Supercoiling strain relief by nicking enzymes$q$,
    $q$An in vitro replication system contains a covalently closed circular plasmid, a helicase that opens the parental duplex at the fork, and an enzyme that transiently cuts one backbone strand ahead of the fork, permits controlled rotation of the helix, and then reseals the cut. Under control conditions the plasmid is copied completely. If a drug that blocks the cutting enzyme is added at the start of the reaction, which outcome is most likely?$q$,
    $q$[{"label":"A","text":"The plasmid becomes progressively underwound behind the fork, and copying finishes faster"},{"label":"B","text":"Torsional strain from overwinding builds ahead of the fork, and fork progression stalls before copying is complete"},{"label":"C","text":"The cut strands are attacked by exonucleases, converting the circle into a linear molecule"},{"label":"D","text":"The circle spontaneously dissipates the extra twist by free rotation, so copying is unaffected"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests DNA supercoiling: the torsional strain produced by over- or under-winding a double helix and its relief by enzymes that cut and reseal the backbone. The answer is B because separating the two parental strands at a replication fork forces the helical turns of the unreplicated duplex into a shorter and shorter region ahead of the fork. In a covalently closed circle, neither strand has a free end, so this extra twist cannot escape; it accumulates as positive supercoiling, a physical strain that increasingly opposes further opening of the duplex. The cutting enzyme in this system acts as a swivel: by transiently breaking one strand, letting the helix rotate in a controlled way, and resealing the break, it drains the strain as fast as the fork generates it. When the drug removes this relief valve, strain builds until the helicase can no longer open the template, and the reaction arrests with the plasmid only partially copied. (Choice A) reverses the geometry twice. The topological problem develops ahead of the fork, not behind it, and the unreplicated region becomes overwound, not underwound; in any case, unrelieved strain slows the reaction rather than accelerating it. (Choice C) describes a consequence of nicking, but the drug blocks the enzyme before it cuts, so no free ends are ever generated for exonucleases to attack. The plasmid remains covalently closed, which is precisely why the strain is trapped. (Choice D) fails on topology: a covalently closed circle cannot shed twist by rotating as a whole, because any rotation that unwinds one region of the molecule necessarily overwinds another. Only a transient break in the backbone allows net relaxation, and that is exactly the activity the drug has eliminated. (Choice B) correctly predicts accumulation of overwinding strain followed by stalling. This is a Reasoning about the Design and Execution of Research question because it asks what outcome an enzyme-inhibition experiment on a circular replication template would produce, which requires predicting the behavior of the system when its strain-relief component is selectively removed.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    3,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q22 . Telomere repetitive structure and end protection . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Telomere repetitive structure and end protection$q$,
    $q$A eukaryotic chromosome is examined at its two termini. Which of the following statements accurately characterize the DNA found at these locations?

I. It consists of a short sequence unit repeated in tandem many times
II. It contains a high density of protein-coding genes
III. It shields the chromosome ends from degradation and end-to-end joining$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"I and III only"},{"label":"D","text":"II and III only"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests the structure and protective function of telomeres, the specialized DNA at the two termini of a linear eukaryotic chromosome. The answer is C because statements I and III are accurate and statement II is not. Statement I is correct: telomeric DNA is built from a short unit, in humans the sequence 5'-TTAGGG-3', repeated in tandem hundreds to thousands of times, so the region is highly repetitive rather than informational. Statement III is correct: these repeats, together with the proteins that bind them, cap the chromosome so that its natural ends are not treated as broken DNA. Without such a cap, the exposed ends would be vulnerable to nucleolytic attack and to fusion with the ends of other chromosomes, either of which would compromise the genetic material. Statement II is false: telomeres are noncoding. The tandem repeats contain no open reading frames, and gene density at the extreme termini is essentially zero; gene-rich DNA resides in open, internal regions of the chromosome, not in the repetitive caps. (Choice A) is incomplete. Statement I alone captures the repetitive architecture but omits the protective role, which is equally well established and is the functional reason the repeats exist at the ends in the first place. (Choice B) pairs the true structural statement with the false claim of high gene density, so it cannot be correct regardless of how statement I is judged. (Choice C) combines the two accurate statements, tandem repetition and end protection, and excludes the false one. (Choice D) also includes the false statement II, and by excluding statement I it discards the defining structural feature of the region, its repetitive noncoding organization. This is a Scientific Reasoning and Problem Solving question because it requires evaluating three independent claims about telomere structure and function against one another and assembling only the defensible claims into the correct combination.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q23 . Centromeric DNA sequence composition . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Centromeric DNA sequence composition$q$,
    $q$A metaphase chromosome viewed under the microscope consists of two identical copies joined at a visibly narrowed region partway along their length. If DNA from this narrowed region were isolated and sequenced, the reads would most likely reveal which of the following?$q$,
    $q$[{"label":"A","text":"Many tandem copies of short noncoding repeated sequences"},{"label":"B","text":"An unusually high proportion of guanine and cytosine base pairs"},{"label":"C","text":"A tightly spaced series of actively expressed genes"},{"label":"D","text":"The guanine-rich repeat arrays characteristic of chromosome termini"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests structural identification of the centromere as a repetitive DNA landmark of the eukaryotic chromosome. The answer is A because the narrowed region where the two identical copies of a replicated chromosome remain attached is the centromere, and centromeric DNA consists of long arrays of short noncoding sequences repeated in tandem. After DNA replication, a chromosome exists as two sister chromatids that stay joined at this single constricted site. The DNA underlying the constriction is not an informational stretch; it is satellite-type DNA in which a short unit repeats over and over, a repetitive character shared with the other major chromosomal landmark, the telomere, although the two landmarks differ in sequence and in position. Sequencing reads from the constriction would therefore be dominated by many near-identical copies of a short motif with no open reading frames. (Choice B) states a claim sometimes repeated in review materials, that centromeric DNA is unusually rich in guanine and cytosine. Measured centromeric satellite sequences in humans are not distinguished by elevated GC content, and base composition is not what defines the region in any case; its defining feature is tandem repetition at the site where the chromatid copies are held together. (Choice C) describes the opposite kind of chromatin. Tightly spaced, actively expressed genes are found in open euchromatic regions along the chromosome arms, whereas the constriction is packaged in a compact, largely silent form and is gene-poor. (Choice D) names the correct kind of DNA but the wrong landmark: guanine-rich tandem arrays such as the human TTAGGG repeat occupy the two termini of the chromosome, not the single interior constriction, so reads from the narrowed region would not match them. This is a Scientific Reasoning and Problem Solving question because it requires recognizing a described microscopic feature as the centromere and then inferring what its underlying DNA sequence organization would look like in sequencing data.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q24 . Chromosomal region classification from properties . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Chromosomal region classification from properties$q$,
    $q$A genomics team characterizes four regions, W through Z, of a single eukaryotic chromosome. Region W consists of thousands of tandem copies of a 6-base unit, maps to both extreme ends of the chromosome, and contains no open reading frames. Region X maps to a single interior site that appears as a narrow waist where the two copies of the replicated chromosome stay attached. Region Y stains lightly in interphase and shows the highest gene density on the chromosome. Region Z stains darkly throughout interphase and contains few genes, most of them inactive. Which set of assignments is consistent with every observation?$q$,
    $q$[{"label":"A","text":"W is a centromere, X is a telomere, Y is euchromatin, Z is heterochromatin"},{"label":"B","text":"W is a telomere, X is a centromere, Y is heterochromatin, Z is euchromatin"},{"label":"C","text":"W is a centromere, X is a telomere, Y is heterochromatin, Z is euchromatin"},{"label":"D","text":"W is a telomere, X is a centromere, Y is euchromatin, Z is heterochromatin"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests classification of the major chromosomal landmarks and compaction states from experimental observations. The answer is D because each region's measured properties match exactly one identity. Region W is tandemly repetitive, noncoding, and located at both extreme ends of the chromosome; repetitive noncoding DNA capping the termini is the definition of a telomere. Region X maps to a single interior site forming the narrow waist where the two copies of the replicated chromosome remain attached, and that single constriction is the position of the centromere. Regions Y and Z are distinguished by packing. Light staining in interphase together with the highest gene density on the chromosome indicates an open, loosely arranged fiber, so region Y is euchromatin. Persistent dark staining and a scarcity of active genes indicate a densely compacted fiber, so region Z is heterochromatin. Only choice D assigns all four correctly. (Choice A) correctly pairs Y with euchromatin and Z with heterochromatin but swaps the two landmarks. Position separates them decisively: telomeres occupy the two ends of a linear chromosome, while the centromere is the single interior constriction holding the chromatid copies together, so W must be telomeric and X centromeric. (Choice B) places the landmarks correctly but inverts the compaction states, assigning the lightly staining, gene-dense region to heterochromatin. Light staining reflects a dispersed, loosely packed fiber, and a chromosome's expressed genes reside in that open state, so the gene-dense region must be euchromatin. (Choice C) makes both swaps at once and conflicts with every discriminating observation: it places a telomere at the chromosome interior and treats the darkly staining, gene-poor region as the open state. This is a Data-based and Statistical Reasoning question because it requires integrating mapping position, staining behavior, and gene density measurements to assign each described chromosomal region to its correct structural identity.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

COMMIT;

-- Verification: expect 24 questions and 72 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'DNA and Biotechnology') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'DNA and Biotechnology') AS distractor_rows;
