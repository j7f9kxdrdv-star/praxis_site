-- Biochemistry Chapter 7: RNA and the Genetic Code, standalone questions
-- BATCH 2 of 4 (18 questions): Unit C, transcription (template versus coding strand, transcript
--   derivation, directionality, de-novo initiation with no primer, intrinsic duplex melting,
--   promoters, TBP/TFIID recruitment of Pol II, assembly order, start-site logic) . Unit D, mRNA
--   processing (the 5-prime cap as protection, the poly-A tail, nuclear processing before export,
--   the spliceosome, alternative splicing).
--
-- PURE INSERTs: run AFTER biochemistry_ch7_rna_questions.sql (batch 1 owns the chapter DELETE).
-- Source-doc errata keyed CORRECTLY: RNA polymerase melts the duplex itself (helicase-in-
-- transcription is a distractor); TBP/TFIID binds the TATA box and recruits Pol II (the Kaplan
-- shorthand "Pol II binds TATA" is a calibrated distractor, never credited). The open mirror of
-- Ch6's primase keys is claimed: RNA polymerase initiates de novo. No mutation-type labels in any
-- option; no splice-site-mutation consequence keys (Bio Ch12 owns them).

BEGIN;

-- B2 Q1 . template versus coding strand roles . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$template versus coding strand roles$q$,
    $q$A researcher isolates the mRNA transcribed from a gene and determines its complete sequence. When this mRNA is aligned against the two strands of the gene, it lines up with one DNA strand base for base, except that U appears at every position where that strand has T. Which conclusion about the roles of the two DNA strands during transcription is supported?$q$,
    $q$[{"label":"A","text":"The matching strand base paired with incoming ribonucleotides as the polymerase moved along it"},{"label":"B","text":"The matching strand is the one the polymerase traversed from its 3' end toward its 5' end"},{"label":"C","text":"The strand complementary to the matching strand served as the template that the polymerase read"},{"label":"D","text":"The transcript was copied from the matching strand and then edited to replace each thymine with uracil"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the division of labor between the template strand and the coding strand of a gene during transcription. The answer is C because RNA polymerase never copies a strand directly. The enzyme reads one strand and assembles a complementary, antiparallel RNA, so the finished transcript is complementary to the strand that was read and identical to the strand that was not read, apart from U standing in for T. Because the isolated mRNA aligns with one DNA strand base for base, that strand must be the coding strand, also called the nontemplate strand, and the polymerase must have read its partner, the template strand. The reasoning runs backward from product to mechanism: sequence identity with the transcript rules a strand out as the template, since a template and its product are complements, never copies. (Choice A) The strand that base pairs with incoming ribonucleotides is by definition the template. A strand whose sequence matches the transcript cannot have paired with it position by position, because a sequence is complementary to its partner rather than to itself, so the matching strand played no pairing role during synthesis. (Choice B) The template is indeed traversed from its 3' end toward its 5' end, but that directional fact belongs to the nonmatching strand of this gene. Attaching a correct rule about template reading to the wrong strand does not convert the coding strand into the strand the enzyme read. (Choice D) RNA is never synthesized with thymine that is later swapped for uracil. RNA polymerase incorporates uridine nucleotides opposite template adenines from the first phosphodiester bond onward, so the U for T difference arises during polymerization, not from an editing step applied to a copy of the matching strand. This is a Scientific Reasoning and Problem Solving question because it requires inferring each strand's mechanistic role in transcription from the sequence relationship between a finished mRNA and the two strands of its gene.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$wrong strand given the mechanistic role$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$correct rule, wrong object$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$invented editing mechanism$q$ FROM q;

-- B2 Q2 . transcript derivation from labeled duplex . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$transcript derivation from labeled duplex$q$,
    $q$Both strands of a short region within a gene are given here, with the polarity of each strand labeled. Strand 1: 5'-ATGCCGTT-3'. Strand 2: 3'-TACGGCAA-5'. During transcription of this region, RNA polymerase uses Strand 2 as its template. Which sequence, written with conventional 5' to 3' polarity, is the RNA produced from this region?$q$,
    $q$[{"label":"A","text":"5'-AACGGCAU-3'"},{"label":"B","text":"5'-AUGCCGUU-3'"},{"label":"C","text":"5'-UUGCCGUA-3'"},{"label":"D","text":"5'-ATGCCGTT-3'"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests deriving a transcript's sequence and polarity from a labeled DNA duplex. The answer is B because the RNA must be complementary and antiparallel to Strand 2, the assigned template. Reading Strand 2 from its 3' end, the bases encountered are T, A, C, G, G, C, A, A; pairing each with its ribonucleotide partner gives A, U, G, C, C, G, U, U, and because the chain grows 5' to 3' while the template is read 3' to 5', the first base placed becomes the transcript's 5' end. The product is therefore 5'-AUGCCGUU-3'. The result can be confirmed with the coding strand shortcut: a transcript matches the nontemplate strand in sequence and polarity with U in place of T, and Strand 1 is 5'-ATGCCGTT-3', which reproduces the answer exactly after that substitution. Both routes must agree, and checking one against the other catches most polarity slips. (Choice A) 5'-AACGGCAU-3' is the RNA that would result if Strand 1 had served as the template. The stem assigns the template role to Strand 2, so this choice transcribes the wrong strand of the duplex. (Choice C) This choice lists the correct eight bases in reverse order, the product of pairing the template correctly but recording the RNA with its polarity inverted, as though the chain grew 3' to 5'. A nucleic acid sequence is defined by its polarity, so the reversed string names a different molecule. (Choice D) 5'-ATGCCGTT-3' is simply the coding strand. The transcript does share the coding strand's sequence and polarity, which is what makes this tempting, but an RNA product contains uracil rather than thymine, so a sequence containing T cannot be the transcript. This is a Data-based and Statistical Reasoning question because it requires deriving the product sequence base by base, with correct polarity, from the strand sequences and polarity labels supplied in the stem.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$wrong strand transcribed$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$polarity flip$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$forgot U for T substitution$q$ FROM q;

-- B2 Q3 . antiparallel template reading direction . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$antiparallel template reading direction$q$,
    $q$A bacterial gene is laid out horizontally so that the template strand's 3' end lies at the left and its 5' end lies at the right. The promoter sits at the left end, and RNA polymerase initiates there and transcribes the full gene. In which direction along this horizontal layout does the polymerase travel, and at which end of the completed transcript are the first ribonucleotides it added?$q$,
    $q$[{"label":"A","text":"It moves right to left, and the first ribonucleotides added form the transcript's 3' end"},{"label":"B","text":"It moves left to right, and the first ribonucleotides added form the transcript's 3' end"},{"label":"C","text":"It moves right to left, and the first ribonucleotides added form the transcript's 5' end"},{"label":"D","text":"It moves left to right, and the first ribonucleotides added form the transcript's 5' end"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests the paired directionality rules of transcription: the template is read 3' to 5' while the RNA is synthesized 5' to 3'. The answer is D because the template's 3' end lies at the left, and RNA polymerase always moves along the template from its 3' end toward its 5' end. Starting at the promoter on the left end, the enzyme must therefore travel left to right. At the same time, every new ribonucleotide is added to the free 3'-OH of the growing chain, so the chain elongates at its 3' end and the very first ribonucleotides incorporated end up as the transcript's 5' end. Both halves of the answer follow from one principle: template read 3' to 5' and RNA built 5' to 3' are two descriptions of the same antiparallel enzymatic motion, so fixing the template's orientation fixes everything else. (Choice A) This choice reverses both facts. Right to left travel would mean reading the template from its 5' end, which no RNA polymerase does, and the first nucleotides added cannot end up at the 3' end because the 3' end is where growth continues until termination. (Choice B) The direction of travel is correct, but this choice misplaces the chemistry of growth. Because nucleotides are appended to the 3'-OH, the newest residues sit at the 3' end and the earliest ones define the 5' end, not the reverse. (Choice C) Placing the first nucleotides at the 5' end is correct, but right to left movement would require the polymerase to read the template 5' to 3'. With the template's 3' end at the left and initiation at the left end, the enzyme is committed to rightward travel. This is a Scientific Reasoning and Problem Solving question because it requires applying the antiparallel directionality rules of transcription to a specific described orientation to predict both the enzyme's path and the product's chemistry.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$double inversion$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$growth-end swap$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$wrong read direction$q$ FROM q;

-- B2 Q4 . primer independent transcription initiation . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$primer independent transcription initiation$q$,
    $q$A biochemist prepares two cell free reactions with purified components: one carries out DNA replication and the other carries out transcription of the same gene. No oligonucleotide primers and no primase are added to either tube. The transcription reaction yields full length RNA while the replication reaction yields no new DNA; which capability of RNA polymerase explains this difference?$q$,
    $q$[{"label":"A","text":"It selects ribonucleotides, which base pair with an exposed template faster than deoxyribonucleotides do"},{"label":"B","text":"It synthesizes RNA in the 3' to 5' direction, so no free 3'-OH group is needed to start the chain"},{"label":"C","text":"It can join the first ribonucleotides on the template de novo, without an existing 3' end to extend"},{"label":"D","text":"It contains a built in primase activity that lays down a short leader before elongation begins"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the contrast between how transcription and replication begin: RNA polymerase initiates synthesis de novo, while DNA polymerase cannot. The answer is C because RNA polymerase can position the first ribonucleotides on the template and form the initial phosphodiester bond without any preexisting 3'-OH to build from. DNA polymerases, in contrast, can only extend a chain; they require a primer that supplies a free 3'-OH before the first deoxyribonucleotide can be added, and in cells that primer is a short RNA laid down by primase. With primers and primase both omitted, the replication tube has no 3' end to extend and fails at initiation, while the transcription tube proceeds normally because its polymerase never needed one. This de novo capability is why a promoter sequence alone, rather than a preexisting nucleic acid end, is sufficient to define where transcription begins. (Choice A) Any kinetic difference between ribonucleotide and deoxyribonucleotide pairing is irrelevant to this outcome. The replication reaction fails at initiation, before elongation rates could matter, because no primer is present to extend. (Choice B) This reverses the actual chemistry. RNA is synthesized 5' to 3', with each new residue added to the growing chain's 3'-OH; no nucleic acid polymerase builds 3' to 5', and directionality is not what frees RNA polymerase from a primer requirement in any case. (Choice D) RNA polymerase carries no primase activity, and no primer of any kind is laid down before transcription begins. Primase is a replication enzyme whose product serves DNA polymerase; importing it into transcription misassigns the machinery of one process to the other, and the stem states that no primase was added. This is a Scientific Reasoning and Problem Solving question because it requires using the divergent outcomes of two controlled reactions to identify which initiation capability distinguishes RNA polymerase from DNA polymerase.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$fabricated rate explanation$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$inverted synthesis direction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$replication machinery import$q$ FROM q;

-- B2 Q5 . polymerase intrinsic duplex melting . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$polymerase intrinsic duplex melting$q$,
    $q$As RNA polymerase elongates a transcript, a short region of unpaired DNA travels along the gene together with the enzyme. No replication proteins are present at the site. Which factor is responsible for separating the two DNA strands within this moving region?$q$,
    $q$[{"label":"A","text":"RNA polymerase itself, which melts the duplex locally as it advances"},{"label":"B","text":"A helicase that runs just ahead of the polymerase and breaks the hydrogen bonds between base pairs"},{"label":"C","text":"Single stranded DNA binding proteins that pry the two strands apart and keep the region open"},{"label":"D","text":"A topoisomerase that nicks one strand so that the duplex can swivel open at the moving region"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests which activity opens the DNA duplex during transcription. The answer is A because RNA polymerase itself melts the double helix locally, creating the short unpaired region, the transcription bubble, that travels with the enzyme. As the polymerase advances, DNA unwinds just ahead of it and the strands reanneal just behind it, so the bubble stays small and moves at the enzyme's pace. Exposing the template this way is what allows incoming ribonucleotides to base pair with it, and a short RNA to DNA hybrid persists inside the bubble before the transcript is displaced and the duplex reforms. No separate unwinding enzyme is recruited for the task; strand opening is built into the polymerase's own mechanism, which makes the transcription machinery leaner than the replication fork, where unwinding, strand stabilization, and priming are distributed across separate proteins. (Choice B) A dedicated helicase that unwinds parental DNA is a feature of replication, where it operates at the replication fork by breaking hydrogen bonds between the strands. Transcription does not use a helicase to open the duplex, and the stem specifies that no replication proteins are present. (Choice C) Single stranded DNA binding proteins are also replication components, and even in that setting they do not pry the duplex apart. They coat strands that have already been separated to prevent reannealing, so they could not account for the initial opening even if they were present. (Choice D) Topoisomerases act on the torsional stress that accumulates around an advancing polymerase, nicking and resealing DNA to relax supercoils. Relieving overwinding near the bubble is not the same as breaking the base pairs that hold the two strands together, so this enzyme cannot be the agent of strand separation. This is a Knowledge of Scientific Concepts and Principles question because it asks which enzymatic activity accomplishes duplex melting during transcription elongation.$q$,
    'easy',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$helicase unwinds it$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$replication stabilizer miscast as opener$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$nearby true enzyme, wrong job$q$ FROM q;

-- B2 Q6 . polymerase assignment for messenger RNA . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$polymerase assignment for messenger RNA$q$,
    $q$A hepatocyte is actively transcribing the gene for serum albumin, a secreted protein. Which nuclear enzyme synthesizes the primary transcript of the albumin gene?$q$,
    $q$[{"label":"A","text":"RNA polymerase I"},{"label":"B","text":"RNA polymerase III"},{"label":"C","text":"RNA polymerase II"},{"label":"D","text":"DNA polymerase"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the eukaryotic division of transcriptional labor, specifically which nuclear RNA polymerase is assigned to protein coding genes. The answer is C because albumin is a protein, so its gene must first be copied into a precursor messenger RNA before any ribosome can translate it, and in eukaryotic nuclei every precursor messenger RNA is synthesized by RNA polymerase II. The inference runs from product to enzyme. A secreted protein reaches the translation machinery only by way of a message, the message begins as a nuclear primary transcript, and eukaryotes hand every nuclear protein coding transcript to a single enzyme, RNA polymerase II. The fastest discriminator among the three nuclear polymerases is the fate of the product: translated messages point to polymerase II, large ribosome components point to polymerase I, and small stable adapters plus the 5S ribosomal RNA point to polymerase III. Because the other two polymerases make only stable RNAs that function without ever being translated, neither can be the source of the albumin transcript no matter how strongly the gene is expressed. Keeping this assignment straight also explains classic experimental observations, such as the selective loss of new messenger RNA when polymerase II is inhibited while ribosomal RNA synthesis continues. (Choice A) RNA polymerase I synthesizes the large ribosomal RNA precursor in the nucleolus. Its product is a structural part of the ribosome, never a message, so it cannot transcribe a gene whose product is a secreted protein. (Choice B) RNA polymerase III makes small structural RNAs, including transfer RNAs and the 5S ribosomal RNA. These products are also untranslated, so this polymerase is likewise excluded from protein coding genes. (Choice D) DNA polymerase belongs to replication rather than transcription. It copies DNA into DNA and cannot synthesize an RNA product, so it cannot generate a primary transcript of any kind. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall the polymerase assignment that routes every eukaryotic protein coding gene through RNA polymerase II.$q$,
    'easy',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B2 Q7 . inverted promoter directionality consequence . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$inverted promoter directionality consequence$q$,
    $q$In a eukaryotic cell line, the core promoter of a protein coding gene, including its TATA box, is excised and reinserted at its original genomic position in the reverse orientation. Chromatin immunoprecipitation confirms that TFIID and the other general transcription factors still occupy the element at normal levels. Which outcome is most likely for expression of this gene?$q$,
    $q$[{"label":"A","text":"The normal pre-mRNA is still produced, because promoter DNA is double stranded and directs assembly equally well in either arrangement."},{"label":"B","text":"The normal start site is used but transcript output falls, because the flipped element binds its factors more weakly."},{"label":"C","text":"The gene body is transcribed from its usual template strand, but the polymerase now synthesizes the RNA in the 3' to 5' direction."},{"label":"D","text":"The machinery is aimed away from the gene and initiates on the opposite strand, so the gene's normal transcript is no longer made."}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests what a promoter actually accomplishes: it positions and orients the transcription machinery, and in doing so it fixes both where transcription starts and which DNA strand is read as template. The answer is D because a promoter is a directional element, not a symmetric landing pad. When the element is flipped, the general transcription factors and RNA polymerase II still assemble, but they assemble in mirror image, aiming the polymerase along the duplex in the direction opposite to the gene body. An enzyme aimed the opposite way must use the complementary strand as its template, and it elongates away from the coding region, so the gene downstream of the element is never copied into its normal precursor message. The chromatin immunoprecipitation result is the deliberate control in this stem: occupancy is intact, so the loss of the message must be a matter of geometry rather than a failure to bind. (Choice A) Proteins do engage promoter DNA as a double stranded surface, but the information in the element is directional; assembly on the flipped element points the enzyme the wrong way, so the claim that a promoter works equally well in either arrangement is the core misconception this item targets. (Choice B) Reduced output from the normal start site would require weakened factor binding, and the occupancy data rule that out; the defect here is a change in direction, not a partial drop in efficiency. (Choice C) RNA polymerases add nucleotides only to a free 3' end, so RNA synthesis is always 5' to 3'; no rearrangement of promoter DNA can reverse that chemistry, making this choice a reversal of an invariant polarity rather than a possible outcome. This is a Scientific Reasoning and Problem Solving question because it requires you to predict the transcriptional consequence of inverting a directional control element, reasoning from promoter orientation to template strand choice and elongation direction.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q;

-- B2 Q8 . TBP mediated polymerase recruitment . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$TBP mediated polymerase recruitment$q$,
    $q$A graduate student is ordering the earliest events of transcription initiation at a TATA containing eukaryotic promoter of a protein coding gene. Which of the following events occur during assembly of the initiation machinery at this promoter?

I. Sequence specific recognition of the TATA element by TBP, a subunit of TFIID
II. Direct, factor independent binding of free RNA polymerase II to the TATA element
III. Recruitment of RNA polymerase II by the promoter bound TFIID scaffold$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and III only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests the recognition and recruitment logic at a TATA containing eukaryotic promoter. The answer is B because events I and III are real steps in initiation, while event II describes a shortcut that does not occur. The first sequence specific contact at the core promoter is made by TBP, the TATA binding protein, which is carried to the DNA as one subunit of the larger TFIID complex, so event I happens. Once TFIID is seated on the element, it becomes the platform on which the remaining general transcription factors assemble in order, and it is this protein scaffold, not the naked DNA, that finally recruits RNA polymerase II, so event III happens as well. Event II fails because free RNA polymerase II has no intrinsic ability to locate a TATA element; the polymerase is the last major arrival, brought in by the factor platform, so any account in which the polymerase reads the element on its own inverts the true order of assembly. Holding the order straight, factors first and polymerase last, settles all three statements. (Choice A) Event I is genuine, but stopping there omits the recruitment step that gives TFIID its purpose; recognition without recruitment leaves the polymerase with no route to the promoter, so this answer is incomplete rather than fully wrong. (Choice C) This pairing keeps the correct recruitment step but replaces TBP recognition with direct polymerase binding, a step that never occurs; the polymerase does not read the TATA sequence itself. (Choice D) Including all three events forces the false event II into the sequence; a polymerase that could bind the element directly would make the general factor apparatus unnecessary, which contradicts the strict requirement for TFIID in initiation. This is a Scientific Reasoning and Problem Solving question because it asks you to evaluate competing accounts of initiation and keep the recognition step, the recruitment step, and the polymerase's late arrival in their correct causal order.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B2 Q9 . TFIID omission assembly failure . medium . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$TFIID omission assembly failure$q$,
    $q$A biochemist reconstitutes eukaryotic transcription in vitro by combining a template that carries a strong TATA box promoter, purified RNA polymerase II, ribonucleotides, and every general transcription factor except TFIID. A parallel reaction contains the complete factor set. Compared with the complete reaction, what result should the omission produce?$q$,
    $q$[{"label":"A","text":"Promoter directed transcripts fail to appear, because the scaffold that nucleates preinitiation assembly and recruits the polymerase is never established."},{"label":"B","text":"Transcripts initiate at the correct site but are released prematurely, because the omitted factor acts only after the polymerase has begun elongating."},{"label":"C","text":"Transcripts appear at near normal levels but initiate from random positions, because the remaining factors and the polymerase assemble on the DNA without sequence guidance."},{"label":"D","text":"Transcription fails only because the duplex remains base paired, and supplementing the reaction with a replicative helicase restores activity."}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests the order of assembly at an RNA polymerase II promoter, probed by a factor omission experiment. The answer is A because preinitiation complex assembly is nucleated by TFIID: its TBP subunit makes the founding sequence specific contact with the TATA element, and the seated complex becomes the platform onto which the remaining general factors and, last of all, the polymerase are loaded. Remove the founding factor and nothing downstream of it can happen. The other factors have no independent means of finding the promoter, the polymerase is never recruited, and the reaction yields no promoter directed transcripts even though every catalytic ingredient is present and active. This is the signature of an ordered pathway: omitting the first component silences the entire series, whereas omitting a later component would leave the early intermediates detectable at the promoter. (Choice B) A factor that acted only during elongation would leave initiation intact and merely shorten the products; TFIID acts before the polymerase ever engages the DNA, so the failure occurs upstream of initiation, not after it. (Choice C) Initiation from random sites is the behavior of a prokaryotic core polymerase deprived of its sigma factor, and that fact does not transfer to this reaction; without TFIID the remaining general factors cannot assemble on the promoter at all and the polymerase is never recruited, so the omission abolishes the products instead of scattering their start sites. (Choice D) Strand separation is not the missing function: RNA polymerase melts the duplex itself during transcription, and dedicated helicases that unwind DNA ahead of a fork belong to replication, so adding one cannot create the recruitment platform the reaction lacks. This is a Reasoning about the Design and Execution of Research question because it asks you to predict the outcome of a defined component omission in a reconstituted system and to use that outcome to place the omitted factor at the start of the assembly pathway.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    3,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B2 Q10 . TATA spacing sets start site . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$TATA spacing sets start site$q$,
    $q$A molecular biologist fuses three promoter variants to the same luciferase reporter and transfects each construct into one cell line. Primer extension is then used to map the 5' ends of the reporter transcripts. Construct P1 carries the natural promoter, with its TATA element centered about 25 base pairs upstream of the natural start site, and yields 100 percent activity with a single major 5' end at position +1. In construct P2 the TATA element is scrambled, and activity falls to 9 percent with 5' ends scattered across a 60 base pair window. In construct P3 the intact TATA element is relocated 20 base pairs farther upstream, and activity is 80 percent with a single major 5' end at position -20. Which conclusion do these data support?$q$,
    $q$[{"label":"A","text":"Scrambling the TATA element eliminates transcription of the reporter entirely, so the element is essential for any initiation."},{"label":"B","text":"The TATA element positions initiation at a roughly fixed distance downstream of itself while also supporting efficient initiation."},{"label":"C","text":"The sequence at the natural +1 position is what selects the start site, independent of any upstream element."},{"label":"D","text":"Relocating the TATA element lowers activity because the polymerase must scan farther along the DNA before reaching the natural +1 site."}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests how promoter mutation data reveal the two jobs of the TATA element, supporting efficient initiation and fixing where initiation occurs. The answer is B because the three constructs separate those jobs cleanly. P1 sets the baseline: an element about 25 base pairs upstream of the start gives full activity and one sharp 5' end at +1. P2 shows the efficiency role: destroying the element drops activity to 9 percent and scatters the 5' ends across a wide window, meaning the machinery still fires occasionally but no longer knows where. P3 is the decisive construct: the element is intact but moved 20 base pairs upstream, activity stays high at 80 percent, and the single major start site moves upstream by the same 20 base pairs, to position -20. The start site tracks the element at a constant spacing, which is exactly what is expected if the bound machinery measures a set distance downstream from the element to choose the initiation point. Together the constructs support both halves of the conclusion: the element drives efficient initiation and dictates the start position. (Choice A) The P2 data contradict a total loss claim; 9 percent residual activity with dispersed starts is reduced and mispositioned initiation, not eliminated initiation, so this choice overstates the result. (Choice C) If the sequence at +1 chose the start site, the P3 start would have remained at +1, because that sequence was untouched; instead the start followed the relocated element, refuting an element independent mechanism. (Choice D) A scanning explanation predicts initiation still at +1 after a longer approach, with activity lost to the added distance; the observed start at -20 shows the machinery never travels to +1 at all, so the modest activity drop cannot be explained by scanning distance. This is a Data-based and Statistical Reasoning question because it asks you to integrate activity levels and mapped 5' ends across three promoter variants to infer both the efficiency and the positioning functions of a core promoter element.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B2 Q11 . cap shielding the nascent transcript . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$cap shielding the nascent transcript$q$,
    $q$In eukaryotic cells, exonucleases that attack RNA from its 5' end are active in both the nucleus and the cytoplasm. A nascent RNA polymerase II transcript nevertheless resists such attack from the moment it emerges from the polymerase, well before splicing is complete. Which modification accounts for this early resistance?$q$,
    $q$[{"label":"A","text":"A stretch of adenosines added by a template-independent polymerase after cleavage of the completed transcript"},{"label":"B","text":"Spliceosomal excision of intervening sequences from the interior of the transcript"},{"label":"C","text":"A methylated guanosine joined to the transcript through an atypical 5'-to-5' triphosphate bridge"},{"label":"D","text":"A GC-rich hairpin that forms at the transcript's terminus and sequesters it from solution"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the processing role of the eukaryotic 5' cap as an early protective mark on the maturing message. The answer is C because the only modification present from the instant a polymerase II transcript emerges is the 7-methylguanosine cap, which is installed co-transcriptionally on the very first portion of the new RNA; the enzymes that build it travel with the polymerase, which is why the cap appears when the transcript is only a few dozen nucleotides long. The cap guanosine is attached backward, so the linkage runs 5' to 5' through a triphosphate bridge. As a result, the transcript no longer presents the ordinary free 5' terminus that 5' exonucleases require as a substrate, and the message is shielded from its earliest moments onward. Beyond protection, this structure is also one of the marks that identifies the RNA as a message undergoing maturation, distinguishing it from other nuclear RNAs. (Choice A) A template-independent polymerase does add a long adenosine stretch to eukaryotic messages, but that addition occurs at the 3' end and only after the finished transcript has been cleaved downstream of a consensus signal; it arrives too late in processing, and at the wrong terminus, to explain resistance at the 5' end of a still-growing RNA. (Choice B) Spliceosomal excision of intervening sequences is a genuine nuclear processing event, but removing internal segments creates no chemical barrier at either terminus, and the stem specifies that resistance is established well before splicing is complete. (Choice D) A hairpin that forms and sequesters the end of a transcript describes the rho-independent terminator of prokaryotic transcription; it forms at the 3' end of a completed bacterial message and plays no protective role at the 5' terminus of a eukaryotic transcript. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recognize which chemical modification of eukaryotic pre-mRNA is in place early enough, and at the correct end, to account for the described nuclease resistance.$q$,
    'easy',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$right protection, wrong end and timing$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$different processing step misapplied$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$prokaryotic 3' structure imported to wrong context$q$ FROM q;

-- B2 Q12 . adenosine tail lifetime data . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$adenosine tail lifetime data$q$,
    $q$Researchers synthesize three capped reporter transcripts that are identical except at their 3' ends and inject equal amounts of each directly into the cytoplasm of cultured cells. Variant 1 carries a 200-nucleotide homopolymeric run of adenosine and shows a half-life of 10 hours. Variant 2 ends immediately after its stop codon with no added segment and shows a half-life of 30 minutes. Variant 3 carries a 200-nucleotide added segment of mixed, random sequence and shows a half-life of 35 minutes. Which conclusion do these measurements support?$q$,
    $q$[{"label":"A","text":"Long cytoplasmic survival requires an adenosine-specific terminal segment rather than added length alone"},{"label":"B","text":"Terminal segments protect a transcript in proportion to their length, regardless of base composition"},{"label":"C","text":"The shared 5' modification is sufficient by itself to confer a long cytoplasmic lifetime"},{"label":"D","text":"Variant 2 decayed quickly because transcripts lacking a terminal segment are retained in the nucleus"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests the protective, lifetime-extending role of the poly-A tail, evaluated through half-life data. The answer is A because the three variants isolate one variable at a time at the transcript's 3' end. Comparing Variant 1 with Variant 2 shows that a terminal addition matters enormously: the adenosine-bearing transcript survives about twenty times longer than the bare one, 10 hours versus 30 minutes. Comparing Variant 1 with Variant 3 then shows that added length alone is not the explanation, because a random-sequence extension of the identical 200-nucleotide length leaves the half-life essentially at baseline, 35 minutes versus 30 minutes. Together the comparisons point to a sequence-specific mechanism: a homopolymeric run of adenosines is recognized by protective machinery that blocks exonucleolytic attack from the 3' end and thereby buys the message a long working lifetime, while an arbitrary extension of the same size recruits no such protection. (Choice B) Proportional, composition-independent protection predicts that Variants 1 and 3 should behave alike, since both carry 200 added nucleotides; instead their half-lives differ by more than an order of magnitude, so length alone cannot be the operative variable. (Choice C) Every variant carries the same 5' modification, yet two of the three decay within roughly half an hour; a feature shared by all three transcripts cannot explain a twentyfold difference in outcome, and a 5' structure leaves the opposite end of the molecule open to attack. (Choice D) Nuclear retention cannot apply here because all three transcripts were injected directly into the cytoplasm, bypassing the nucleus entirely; this choice confuses the export-gating role of processing with the cytoplasmic stability that the experiment actually measures. This is a Data-based and Statistical Reasoning question because it asks you to identify which conclusion about transcript stability is supported by controlled half-life comparisons across engineered variants.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$correct variable family, wrong attribute$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$wrong end credited with the effect$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$compartment logic misapplied to the design$q$ FROM q;

-- B2 Q13 . nuclear processing gates export . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$nuclear processing gates export$q$,
    $q$A cell-permeable drug applied to cultured human cells simultaneously blocks capping, 3' cleavage with adenosine addition, and spliceosome assembly, while leaving RNA polymerase II fully active. Protein-coding genes continue to be transcribed throughout the treatment. What is the most likely fate of the transcripts produced during treatment?$q$,
    $q$[{"label":"A","text":"They are exported normally, because the nuclear pore machinery recognizes transcript length rather than processing status"},{"label":"B","text":"They remain confined to the nucleus and are eventually degraded without ever engaging the translation machinery"},{"label":"C","text":"They are translated co-transcriptionally as each message emerges from the polymerase"},{"label":"D","text":"They are exported and translated into longer proteins that contain segments encoded by retained intervening sequences"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests where pre-mRNA processing occurs and the rule that only a fully processed message may leave that compartment. The answer is B because capping, 3' cleavage with adenosine addition, and splicing all occur in the nucleus, and passage to the cytoplasm is restricted to transcripts that have completed all of these events; the modifications double as the credentials that the export machinery checks. With every processing step blocked, RNA polymerase II continues to produce pre-mRNA, but none of it qualifies for export, so the transcripts accumulate in the nucleus. Lacking protective structures at either end, they are also easy substrates for nuclear ribonucleases and are cleared by degradation. Because eukaryotic ribosomes operate in the cytoplasm, a message that never leaves the nucleus is never translated. (Choice A) Export is not a simple size filter; the machinery that carries messages through nuclear pores loads only onto transcripts bearing the marks of completed processing, so unprocessed RNAs of any length are excluded. (Choice C) Translation of a message while it is still being synthesized is a prokaryotic arrangement, possible only because those cells have no nuclear envelope; in a eukaryotic cell the growing transcript emerges into the nucleoplasm, physically separated from the ribosome pool. (Choice D) Retained intervening sequences could in principle contribute extra coding information, but this outcome presupposes that unprocessed messages are exported and translated, and the export requirement forbids exactly that; the drug's products never reach the translation machinery at all. This is a Scientific Reasoning and Problem Solving question because it asks you to predict the fate of transcripts in a novel inhibitor scenario by applying the compartmental logic of eukaryotic mRNA processing and export.$q$,
    'easy',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$export imagined as a passive size filter$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$prokaryotic arrangement imported into a eukaryote$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true premise built on a forbidden export step$q$ FROM q;

-- B2 Q14 . terminal marks identify processed message . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$terminal marks identify processed message$q$,
    $q$A biochemist purifies an abundant monocistronic mRNA from an unlabeled cell extract. One end of the molecule bears a methyl-modified guanine nucleotide attached in reverse orientation, so that the linkage joins two 5' carbons through a bridge of three phosphates; the other end bears an uninterrupted run of roughly 200 adenine nucleotides. What do these structural features indicate about the transcript's origin?$q$,
    $q$[{"label":"A","text":"It could have come from either a bacterium or a eukaryote, because messages of both types receive terminal protection against nucleases"},{"label":"B","text":"It came from a bacterium, because bacterial messages begin to be translated while they are still being synthesized"},{"label":"C","text":"It is a eukaryotic primary transcript that was captured before any nuclear modification had occurred"},{"label":"D","text":"It is a mature eukaryotic message that completed nuclear processing before isolation"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests the contrast between prokaryotic and eukaryotic messages, using terminal structures as diagnostic features. The answer is D because the two described modifications, a guanosine joined backward through a 5'-to-5' triphosphate linkage and a long homopolymeric run of adenosines, are precisely the additions made to a eukaryotic pre-mRNA during nuclear processing. The backward guanosine is the 7-methylguanosine cap, added co-transcriptionally to the 5' end, and the adenosine run is the poly-A tail, added by a template-independent polymerase after cleavage at the 3' end. A prokaryotic message receives neither structure: it is synthesized in the cytoplasm and translated essentially as it is made, without capping, tailing, or splicing. Finding both marks on one molecule therefore identifies it as a eukaryotic transcript that has passed through the processing pathway, since the tail in particular is added only after synthesis of the message body is complete. (Choice A) Bacterial messages receive no terminal protective additions of this kind; their transcripts are typically short-lived and can be degraded while translation is still underway, so the described features cannot come from either cell type interchangeably. (Choice B) It is true that bacterial messages begin to be translated during their own synthesis, but that fact argues against a bacterial origin here rather than for it, because a message consumed as it is made receives no such terminal modifications. (Choice C) A primary transcript captured before modification would show a free, unmodified 5' terminus and no terminal adenosine run; the presence of both structures indicates that processing has already happened, which is the reverse of what this choice claims. This is a Scientific Reasoning and Problem Solving question because it asks you to infer a transcript's cellular origin and processing history from its described terminal structures rather than from a stated label.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$false equivalence between cell types$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$true fact driving the wrong inference$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$processing state read backward$q$ FROM q;

-- B2 Q15 . snRNP intron excision machinery . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$snRNP intron excision machinery$q$,
    $q$In a nuclear extract, a radiolabeled eukaryotic pre-mRNA containing two introns is incubated under splicing conditions, and the RNA products are analyzed. Which of the following results would indicate that the spliceosome processed the transcript normally?

I. The intron sequences are absent from the final RNA product
II. The exons in the final product are joined in a 5' to 3' order different from their order in the pre-mRNA
III. Depleting the extract of snRNPs prevents formation of the final product$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"I and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests how the spliceosome processes a eukaryotic pre-mRNA and which molecular machinery carries out that processing. The answer is C because statements I and III are both expected results of normal spliceosome activity, while statement II is not. The spliceosome is a large nuclear complex built from five small nuclear RNAs bound to proteins, the snRNPs U1, U2, U4, U5, and U6. These snRNPs recognize sequences at the two ends of each intron, excise the intron, and ligate the flanking exons together. Statement I is therefore expected: the intron sequences present in the pre-mRNA are removed and do not appear in the spliced product. Statement III is also expected: because snRNPs are the recognition and assembly components of the spliceosome, depleting them from the extract prevents splicing, so the ligated final product cannot form. Statement II is false because splicing joins exons in the same 5' to 3' order in which they occur in the pre-mRNA; the exon order is conserved, and splicing never shuffles exons into a new sequence. (Choice A) I only is incomplete. Intron removal is a genuine outcome, but this choice ignores the snRNP dependence of the reaction; splicing is not carried out by free-standing protein enzymes acting alone, so removing snRNPs must abolish product formation, making statement III an expected result as well. (Choice B) This combination wrongly accepts statement II. Even in alternative splicing, where different exon subsets are chosen in different cells, the exons that are retained always keep their original 5' to 3' order, so a product with reordered exons would indicate an artifact rather than normal spliceosome activity. (Choice D) Including all three statements again requires accepting exon reordering, which the splicing mechanism cannot produce; the spliceosome only removes internal segments and joins the remaining segments in their existing orientation. This is a Scientific Reasoning and Problem Solving question because it requires predicting which experimental outcomes follow from the known mechanism of spliceosome-mediated intron removal rather than recalling an isolated fact.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$accepts one true outcome, misses machinery dependence$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$splicing-as-shuffling misconception$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$all-of-the-above overreach$q$ FROM q;

-- B2 Q16 . spliceosome blockade intermediate prediction . medium . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$spliceosome blockade intermediate prediction$q$,
    $q$Researchers treat cultured mammalian cells with a compound that prevents U snRNPs from assembling on newly synthesized transcripts, while RNA polymerase II transcription continues at normal rates. After several hours, total cellular RNA is analyzed and compared with RNA from untreated cells. Which RNA population is expected to increase in the treated cells?$q$,
    $q$[{"label":"A","text":"Nuclear precursor transcripts that still contain their intron sequences"},{"label":"B","text":"Cytoplasmic mRNAs from which all introns have been removed"},{"label":"C","text":"Branched lariat RNAs derived from excised introns"},{"label":"D","text":"Transcripts lacking a 5' cap, because cap addition requires the assembled spliceosome"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests the function of spliceosome assembly in nuclear RNA processing and asks you to predict which intermediate accumulates when that assembly is inhibited. The answer is A because the substrate of the spliceosome is the intron-containing precursor transcript in the nucleus, and blocking a processing complex causes its substrate to pile up. Splicing normally begins when U1 snRNP base pairs with the 5' splice site of an intron, after which the remaining small nuclear ribonucleoproteins assemble on the transcript, excise each intron, and ligate the flanking exons. If snRNP assembly is chemically prevented while RNA polymerase II continues transcribing, precursor transcripts are still synthesized, but they cannot be matured. The result is a growing nuclear pool of pre-mRNA that retains its introns, the precursor population that would normally be converted into export-ready message. This follows the general logic of any pathway inhibition experiment: the species immediately upstream of the blocked step accumulates, while species downstream of the block decline. (Choice B) is the reverse of the expected result. Intron-free cytoplasmic mRNA is the downstream product of splicing, so inhibiting the spliceosome depletes this population rather than expanding it. (Choice C) confuses the substrate of the blocked step with its product. The branched lariat is released only when an assembled spliceosome actually excises an intron; with assembly prevented, excision never occurs, so lariats become scarcer, not more abundant. (Choice D) misattributes capping to the spliceosome. The 5' cap is installed by separate capping enzymes while the transcript is still being synthesized, so capping proceeds normally in the treated cells and uncapped transcripts do not build up. This is a Reasoning about the Design and Execution of Research question because it requires predicting the molecular intermediate that accumulates in a targeted inhibition experiment rather than describing the normal processing pathway.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    3,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$upstream/downstream inversion in a pathway block$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$product of the inhibited step mistaken for the accumulating species$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$neighboring processing step misattributed to the blocked machinery$q$ FROM q;

-- B2 Q17 . combinatorial exon isoform expansion . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$combinatorial exon isoform expansion$q$,
    $q$Proteomic surveys of human tissues catalog many more distinct proteins than the roughly 20,000 protein-coding genes present in the genome. A student proposes that most of this excess arises from an event acting on the primary transcript before it leaves the nucleus. Which mechanism satisfies the student's proposal and accounts for the numerical discrepancy?$q$,
    $q$[{"label":"A","text":"Because several codons specify the same amino acid, a single mature mRNA directs synthesis of several different proteins"},{"label":"B","text":"Nucleases cleave each transcript into fragments that are then translated as separate short proteins"},{"label":"C","text":"Enzymes add phosphate and carbohydrate groups to finished proteins, generating chemically distinct forms"},{"label":"D","text":"Different subsets of a transcript's exons are joined together, producing several distinct mature mRNAs from one gene"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests alternative splicing as the mechanism by which a limited set of genes produces a much larger set of proteins. The answer is D because joining different subsets of exons from a single primary transcript generates multiple distinct mature mRNAs, each translated into a different protein isoform. The stem constrains the mechanism in two ways: it must act on the primary transcript inside the nucleus, and it must multiply the number of distinct proteins beyond the number of genes. Alternative splicing satisfies both. A precursor with several exons can be spliced so that some exons are retained in one cell type and skipped in another, and by one estimate the majority of human genes are expressed as multiple protein products in this way. Because the number of possible exon combinations grows combinatorially with exon count, a genome of roughly 20,000 genes can specify a proteome several times larger. (Choice A) reverses the logic of the degenerate genetic code. Degeneracy means that several codons specify one amino acid, so different mRNA sequences can converge on the same protein; it never allows one mature mRNA to direct several different proteins, since the ribosome reads one fixed message into one product. (Choice B) describes a mechanism that does not operate on eukaryotic messages. Nuclear processing removes introns and joins exons into one continuous coding message; transcripts are not routinely chopped into independently translated fragments, and random cleavage would destroy coding information rather than create functional isoforms. (Choice C) names a real source of protein diversity at the wrong step. Phosphorylation and glycosylation act on finished proteins after translation, so they fail the stem's requirement of an event acting on the primary transcript before it leaves the nucleus. This is a Scientific Reasoning and Problem Solving question because it requires connecting the combinatorial use of exons to the numerical mismatch between genes and proteins rather than simply recalling a definition.$q$,
    'easy',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$degeneracy direction flipped$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$invented fragmentation mechanism$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true diversifier at the wrong pathway step$q$ FROM q;

-- B2 Q18 . shared peptide splicing evidence . hard . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$shared peptide splicing evidence$q$,
    $q$A contractile protein isolated from skeletal muscle and a related protein isolated from neurons are each digested with trypsin, and the resulting peptides are separated and sequenced. Several peptides are identical between the two proteins, but each protein also yields peptides whose sequences are absent from the other. Genome sequencing of the organism shows that a single locus encodes both proteins and that no closely related second copy of the gene exists. Which conclusion accounts for all of these observations?$q$,
    $q$[{"label":"A","text":"The two proteins arose from duplicated genes that accumulated different mutations after the duplication"},{"label":"B","text":"The two tissues join different combinations of exons from the same primary transcript, so the proteins share some encoded segments but not others"},{"label":"C","text":"The neuronal protein is generated by proteolytic cleavage of the muscle protein"},{"label":"D","text":"Covalent modifications added after translation convert one protein into the other in a tissue-specific manner"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests the experimental evidence that identifies alternative splicing as the source of related protein isoforms. The answer is B because tissue-specific selection of exons from one primary transcript is the only listed mechanism that explains every observation at once: a single genomic locus, peptides shared between the two proteins, and peptides unique to each. Exons retained in both splice variants encode the identical tryptic peptides, while exons included in one tissue but skipped in the other encode the peptides found in only one protein. Because both messages are read from the same gene, the single-locus sequencing result is also expected. Partial sequence identity between two proteins that map to one gene is the classic fingerprint of alternative splicing, and it is a major reason eukaryotic proteomes contain more proteins than genes. (Choice A) explains both the shared and the unique peptides but is eliminated by the genomic data. Duplicated genes diverging by mutation would indeed produce related proteins, yet sequencing found one locus and no second copy, so the two-gene model is excluded by a directly measured fact. (Choice C) accounts for only half of the peptide data. A proteolytic fragment contains a subset of the parent protein's peptides, so cleavage explains the sharing, but it cannot explain why each protein has peptides absent from the other; a cleaved product should contain no sequence that the parent lacks. (Choice D) fails on chemistry. Post-translational modifications add or alter chemical groups on an existing polypeptide backbone; they do not insert or delete stretches of amino acid sequence, so two chains that differ by entire unique peptide segments cannot be interconverted by modification alone. This is a Reasoning about the Design and Execution of Research question because it asks you to weigh peptide-mapping and genome-sequencing evidence against competing molecular explanations and select the one mechanism consistent with all of the data.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    3,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$plausible alternative eliminated by a stated measurement$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$explains half the data set$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$PTM as sequence-changing mechanism$q$ FROM q;

COMMIT;

-- Verification: expect 36 questions and 108 distractor rows (batches 1+2).
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'RNA and the Genetic Code') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'RNA and the Genetic Code') AS distractor_rows;
