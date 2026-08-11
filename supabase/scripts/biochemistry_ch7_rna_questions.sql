-- Biochemistry Chapter 7: RNA and the Genetic Code, standalone questions
-- BATCH 1 of 4 (18 questions): Unit A, the genetic code as a code (architecture, reading frame,
--   start and stop signals, ORF reading, degeneracy, wobble, codon-anticodon pairing) . Unit B,
--   RNA types and structure (the three RNAs, pre-mRNA, single-strandedness and folding, the
--   2-prime hydroxyl as a functional handle).
--
-- CHAPTER SIZE: 72 questions in four batches of 18, per the Step 1 pre-flight: transcription,
-- processing, translation, the code and operons are confirmed unclaimed bank-wide. The recorded
-- Ch6 reservation contract is honoured in reverse: no hybridization/Tm, cDNA, blot-discrimination,
-- telomerase, primase, or uracil-composition keys (all live in Biochem Ch6). Mutation-type labels
-- (silent/missense/nonsense/frameshift) NEVER appear as answer choices chapter-wide; Bio Ch12
-- owns the taxonomy. FORWARD RESERVATION: membrane insertion topology, trafficking and membrane-
-- protein classification are reserved for the future Biochem Ch8 bank.
-- See biochemistry_ch7_rna_questions.plan.md for the full audit trail.
--
-- !! BATCH 1 OWNS THE CHAPTER DELETE !! Batches 2-4 are pure INSERTs and run after this file.

BEGIN;

DELETE FROM public.questions WHERE topic = 'RNA and the Genetic Code';

-- Q1 . Triplet code architecture and consequences . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Triplet code architecture and consequences$q$,
    $q$A bacterial gene directs synthesis of a polypeptide containing 120 amino acid residues. The genetic code is a triplet code that is commaless and non-overlapping, read in successive groups of three nucleotides from a fixed starting point. Based on these properties, which of the following conclusions can be drawn about the coding portion of the corresponding mRNA?

I. It must contain at least 363 nucleotides, including those of the termination codon.
II. No nucleotide within it contributes to more than one codon, and no nucleotides are skipped between successive codons.
III. Replacing a single nucleotide within it with a different nucleotide would alter the base sequence of exactly one codon, leaving the grouping of every other nucleotide unchanged.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests the architecture of the genetic code: the code is a triplet code, commaless and non-overlapping, read in successive groups of three from a fixed starting point, and each of those properties carries testable consequences. The answer is D because all three conclusions follow necessarily from the stated properties. Statement I is the counting consequence of the triplet property: 120 residues require 120 codons, which is 360 nucleotides, and the termination signal occupies one additional triplet, so the coding portion must contain at least 363 nucleotides. Statement II expresses what commaless and non-overlapping mean in practice: because there is no internal punctuation and no sharing of bases between adjacent codons, every nucleotide in the coding region is read exactly once, as part of exactly one codon, with nothing skipped in between. Statement III combines the fixed starting point with the non-overlapping property: grouping is determined only by counting three at a time from that point, and a replacement neither adds nor removes a nucleotide, so the count is undisturbed and every codon boundary stays where it was. The one codon containing the substituted base acquires a new base sequence, and every other codon is read exactly as before. (Choice A) accepts the arithmetic of statement I but rejects the structural consequences in II and III. Those consequences would fail only in a punctuated or overlapping code, and the stem specifies the opposite, so II and III must hold as well. (Choice B) rejects statement III, reflecting the intuition that any single-base change must disturb the reading of everything downstream. Regrouping requires a change in the nucleotide count: only the gain or loss of bases in a number that is not a multiple of three redraws the downstream triplets, whereas a replacement preserves the count and confines the change to the codon that contains it. (Choice C) rejects statement I, typically by computing 120 times 3 equals 360 and stopping there. The termination triplet adds three nucleotides that are read by the ribosome but specify no residue, so 360 undercounts the minimum coding length by exactly one codon. This is a Scientific Reasoning and Problem Solving question because it requires deriving numerical and structural consequences from the stated properties of the code rather than recalling an isolated definition.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$accepts only the numeric statement$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$substitution treated as a register shift$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$forgets the stop codon in the count$q$ FROM q;

-- Q2 . Codon regrouping after nucleotide removal . medium . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Codon regrouping after nucleotide removal$q$,
    $q$A cell-free system translates the synthetic mRNA 5'-AUGCAUGCAUCGACU-3' beginning at its 5'-terminal AUG. A second synthetic mRNA is prepared that is identical except that the fourth nucleotide, a C, is absent. Which triplet does the ribosome read as the third codon of the second mRNA?$q$,
    $q$[{"label":"A","text":"5'-CAU-3'"},{"label":"B","text":"5'-GCA-3'"},{"label":"C","text":"5'-AUG-3'"},{"label":"D","text":"5'-CGA-3'"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests reading-frame logic: a ribosome groups an mRNA into codons purely by counting nucleotides three at a time from its starting point, so the identity of every codon depends on where that count begins and on every nucleotide upstream of it. The answer is A because removing the fourth nucleotide changes the register of the entire downstream message. The original mRNA is grouped AUG, CAU, GCA, UCG, ACU. Deleting the fourth nucleotide leaves 5'-AUGAUGCAUCGACU-3'. Counting in threes from the 5' end, the ribosome reads AUG as the first codon, AUG as the second, and CAU as the third, so the third codon of the second mRNA is 5'-CAU-3'. Written out fully, the second message is read AUG, AUG, CAU, CGA, with the final two nucleotides, CU, too few to form another codon. The ribosome has no way to detect that a nucleotide is absent; because the code is commaless, no internal signal can restore the original grouping, and every triplet after the removal point is drawn from a shifted register. This is the same principle that makes the reading frame so consequential in real genes: a message is decoded correctly only when grouping begins at the intended point and no nucleotide is gained or lost within the coding region. (Choice B) 5'-GCA-3' is the third codon of the original mRNA. Selecting it assumes that only the codon containing the missing nucleotide is altered while downstream grouping is preserved, but with no punctuation between codons the shift propagates through the whole remaining sequence. (Choice C) 5'-AUG-3' does appear in the regrouped message, but as the second codon rather than the third; this choice reflects a positional miscount after an otherwise correct regrouping. (Choice D) 5'-CGA-3' likewise belongs to the correctly regrouped message, but it is the fourth codon read, one position beyond the codon the question asks about. This is a Data-based and Statistical Reasoning question because it requires rebuilding the codon grouping directly from the supplied nucleotide sequence and identifying the triplet at a specified position in the new reading.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    4,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$downstream grouping preserved$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$off-by-one position count$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$correct regrouping, wrong position$q$ FROM q;

-- Q3 . Initiating AUG sets reading frame . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Initiating AUG sets reading frame$q$,
    $q$A 22 nucleotide mRNA fragment, 5'-CAUGGAUGCCGAUUACGCUAGC-3', contains AUG triplets beginning at nucleotide 2 and at nucleotide 6, and no others. In a reconstituted translation system, initiation is directed to the AUG at nucleotide 2 in one trial and to the AUG at nucleotide 6 in a second trial. Apart from the initiating methionine, the two peptides produced are entirely different sequences; the second is not simply a shorter version of the first. Which property of translation explains this result?$q$,
    $q$[{"label":"A","text":"Codon grouping begins at the initiating AUG and continues in uninterrupted, nonoverlapping triplets, and the two initiation sites are offset by a number of nucleotides that is not a multiple of three."},{"label":"B","text":"A ribosome that initiates at an internal AUG translates the downstream sequence in the 3' to 5' direction, reversing the order in which the codons are read."},{"label":"C","text":"Each initiation site recruits a distinct set of aminoacyl tRNA synthetases, so identical codons become matched with different amino acids in the two trials."},{"label":"D","text":"The AUG used for initiation is read by a specialized initiator tRNA that differs from the tRNA that reads internal methionine codons."}]$q$::jsonb,
    'A',
    $q$Gene Expression includes the mechanics of translation, and this question tests the concept that the AUG at which initiation occurs establishes the reading frame for the entire downstream message. The answer is A because the ribosome reads an mRNA as a continuous run of nonoverlapping triplets beginning immediately at the initiator AUG, with no internal punctuation to mark where one codon ends and the next begins. The grouping of every downstream nucleotide into codons is therefore fixed by the position at which reading starts. Here the two AUG triplets begin at nucleotides 2 and 6, an offset of four nucleotides. Because four is not a multiple of three, the two start points fall in different registers: initiation at nucleotide 2 parses the message as AUG, GAU, GCC, GAU, UAC, GCU, AGC, while initiation at nucleotide 6 parses the same string as AUG, CCG, AUU, ACG, CUA. No downstream codon is common to the two readings, so the two peptides are entirely different sequences. Only if the two AUGs were separated by an exact multiple of three would the downstream codons coincide and the second product emerge as a shorter piece of the first. (Choice B) Ribosomes decode mRNA exclusively in the 5' to 3' direction regardless of where initiation occurs. A ribosome that initiates at an internal AUG still moves toward the 3' end of the message; it never reads the sequence backward, so reversal of direction cannot explain the result. (Choice C) Aminoacyl tRNA synthetases charge tRNAs with their amino acids before and independently of any initiation event, and the same charged tRNA pools serve every ribosome in the system. The pairing between a given codon and its amino acid is identical in both trials; what differs is which triplets are presented to the ribosome as codons in the first place. (Choice D) It is true that the methionine placed at an initiating AUG is delivered by a dedicated initiator tRNA distinct from the tRNA that reads internal methionine codons, but this fact concerns only the first residue of each product. It cannot explain why every amino acid downstream of the methionine differs between the two peptides. This is a Scientific Reasoning and Problem Solving question because it requires applying the arithmetic of triplet grouping to a specific sequence, recognizing that a four nucleotide offset between the two initiation sites is not a multiple of three, and inferring from that relationship that the two start points must impose completely different codon groupings on the same message.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$reversed-directionality misconception$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$upstream-step attribution (charging vs decoding)$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$true-but-irrelevant neighboring fact$q$ FROM q;

-- Q4 . Stop codon recognition without tRNA . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Stop codon recognition without tRNA$q$,
    $q$During elongation, each codon that enters the ribosomal A site is matched by an aminoacyl-tRNA, and one residue is added to the growing chain. When the triplet 5'-UAA-3' enters the A site, however, no residue is added and the finished chain detaches from the ribosome. Which molecule occupies the A site when this triplet is positioned there?$q$,
    $q$[{"label":"A","text":"An uncharged tRNA whose anticodon base-pairs with the triplet"},{"label":"B","text":"A protein factor that recognizes the triplet directly and promotes hydrolysis of the bond linking the chain to the final tRNA"},{"label":"C","text":"An aminoacyl-tRNA carrying a modified residue that is clipped from the chain after it is freed"},{"label":"D","text":"The small ribosomal subunit, which rebinds the message and begins searching for the next AUG"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests what a termination codon is: a signal read by a protein rather than by any transfer RNA, specifying release of the chain instead of an amino acid. The answer is B because no cellular tRNA carries an anticodon that decodes 5'-UAA-3'. When this triplet is positioned in the A site, a protein release factor, shaped so that it can occupy the site a tRNA would normally fill, binds and recognizes the triplet directly. Binding of the factor activates hydrolysis of the bond joining the completed chain to the tRNA in the P site, freeing the product, after which the ribosomal complex comes apart. In this way UAA, UAG, and UGA function as punctuation for the message: they mark where the encoded information ends, and the machinery that reads them is a protein, making termination an active, protein-mediated event rather than a passive stall at an unreadable codon. The absence of a decoding tRNA is precisely what gives these three triplets their meaning within the code: they are assignments to a release event rather than to any of the twenty amino acids. (Choice A) An uncharged tRNA would still be a tRNA reading the codon through base pairing, and no cellular tRNA has an anticodon complementary to a termination triplet; delivery of an uncharged tRNA would stall the ribosome rather than trigger orderly release. (Choice C) borrows from rare recoding events in which specialized tRNAs insert unusual residues at particular termination triplets in specific sequence contexts, but in standard translation no residue, modified or otherwise, is added at UAA, and nothing is clipped from the finished chain at termination. (Choice D) describes a step that belongs to initiation, when the small subunit locates a start codon to establish a reading frame; it is not the event that occurs when a termination triplet arrives in the A site of an elongating ribosome, and the small subunit does not enter or displace the contents of the A site. This is a Knowledge of Scientific Concepts and Principles question because it asks for direct recall of the molecule that decodes a termination codon and the nature of the release event it triggers.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$uncharged tRNA reads the stop$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$recoding exception generalized$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$initiation step at termination$q$ FROM q;

-- Q5 . Deriving a peptide from an ORF . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Deriving a peptide from an ORF$q$,
    $q$A synthetic mRNA has the sequence 5'-CCAUGCACGAAUAGGCUUU-3' and is translated by a system in which translation initiates at the first AUG in the sequence. The following codon assignments apply: AUG is methionine (initiation), CCA is proline, UGC is cysteine, ACG is threonine, AAU is asparagine, CAC is histidine, GAA is glutamate, GCU is alanine, and UAG specifies no amino acid and ends synthesis. Which peptide does this mRNA direct?$q$,
    $q$[{"label":"A","text":"Pro-Cys-Thr-Asn"},{"label":"B","text":"His-Glu"},{"label":"C","text":"Met-His-Glu"},{"label":"D","text":"Met-His-Glu-Ala"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests open reading frame analysis: locating the initiation codon, holding the frame it establishes, and applying supplied codon assignments, including a termination signal, to derive a peptide. The answer is C because the first AUG spans nucleotides 3 through 5 of 5'-CCAUGCACGAAUAGGCUUU-3'. Reading successive triplets from that point gives AUG, CAC, GAA, and then UAG. Using the supplied assignments, AUG contributes the initiating methionine, CAC contributes histidine, and GAA contributes glutamate; UAG specifies no amino acid and ends synthesis. The product is therefore Met-His-Glu, a tripeptide. Every nucleotide after the terminator, including the GCU triplet that would encode alanine, lies outside the translated region and is never decoded. This is the essence of an open reading frame: a run of codons bounded by an initiation codon and a termination codon, read in one fixed register. A student cannot answer by looking up a single codon; the same table applied in the wrong register, or without the termination rule, produces each of the wrong choices. (Choice A) Pro-Cys-Thr-Asn comes from setting the frame at the 5' terminus of the mRNA, grouping the message CCA, UGC, ACG, AAU. Translation does not begin at the physical end of the message; the frame is established by the first AUG, and the two nucleotides upstream of it are simply not translated. (Choice B) His-Glu treats AUG as a pure positional signal that marks where reading begins without itself being decoded. The initiation codon is translated: it pairs with an initiator tRNA carrying methionine, so the first residue of the product is methionine, not histidine. (Choice D) Met-His-Glu-Ala begins correctly but reads through the termination triplet to the downstream GCU. UAG is decoded by no tRNA; when it enters the ribosome, the chain is released, so alanine is never added. This is a Scientific Reasoning and Problem Solving question because it requires combining start-site identification, frame maintenance, and supplied codon assignments to derive the complete peptide rather than looking up a single codon.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$frame set at the 5' terminus$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$start codon not translated$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$read-through past the terminator$q$ FROM q;

-- Q6 . Wobble pairing and tRNA economy . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Wobble pairing and tRNA economy$q$,
    $q$Cells translate all 61 amino-acid-specifying codons yet typically maintain fewer than 61 distinct tRNA species. During decoding, each tRNA must still pair with the mRNA before its amino acid is added to the growing chain. Which property of that pairing allows a limited set of tRNAs to cover the full set of codons?$q$,
    $q$[{"label":"A","text":"Aminoacyl-tRNA synthetases attach the same amino acid to several tRNAs that carry unrelated anticodons."},{"label":"B","text":"The 5' base of the anticodon can form nonstandard pairs with the 3' base of the codon, so one tRNA reads multiple synonymous codons."},{"label":"C","text":"The 5' base of the codon pairs loosely with the 3' base of the anticodon, relaxing specificity at the start of each codon."},{"label":"D","text":"Release factors rather than tRNAs recognize stop codons, reducing the number of tRNA species a cell must produce."}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests the wobble hypothesis, the built-in flexibility in the pairing geometry between an mRNA codon and a tRNA anticodon. The answer is B because the base occupying the 5' end of the anticodon aligns with the third, 3' base of the codon, and this single position tolerates nonstandard pairing. A G at the anticodon's 5' position can pair with either C or U in the codon, and the modified base inosine can pair with U, C, or A. Because the first two codon positions still demand strict Watson-Crick complementarity, specificity for the amino acid is preserved, yet one tRNA species can recognize two or more codons that differ only at their final base. Since synonymous codons for a given amino acid usually differ at exactly that position, a single anticodon can service an entire set of them, which is why cells decode all 61 sense codons with fewer than 61 tRNA species. (Choice A) Aminoacyl-tRNA synthetases do charge families of isoacceptor tRNAs with the same amino acid, but charging occurs at the 3' acceptor end of the tRNA, not at the anticodon. Shared charging explains how several different tRNAs can carry one amino acid; it does not reduce the number of tRNA molecules needed to pair with distinct codons, so it cannot explain the discrepancy. (Choice C) This choice reverses the geometry. The relaxed position is the codon's 3' base pairing with the anticodon's 5' base; the codon's 5' base is one of the two strictly read positions, and loosening it would scramble amino acid identity rather than conserve tRNA species. (Choice D) Release factors do recognize stop codons in place of tRNAs, but the stem already restricts the count to the 61 codons that specify amino acids, so the handling of the three stop codons is irrelevant to why fewer than 61 tRNAs suffice for those 61 codons. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall which position of the codon-anticodon duplex permits nonstandard pairing and how that geometry allows a limited tRNA set to read the complete codon repertoire.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$true fact, wrong mechanism$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$position polarity swap$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true but insufficient$q$ FROM q;

-- Q7 . Degeneracy preserving protein sequence . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Degeneracy preserving protein sequence$q$,
    $q$A single-nucleotide substitution alters the final base of a codon within the coding region of an mRNA for a bacterial enzyme. The purified enzyme from cells expressing this altered mRNA is identical in amino acid sequence and catalytic activity to the enzyme from unaltered cells. What feature of the genetic code accounts for this result?$q$,
    $q$[{"label":"A","text":"The ribosome detects the mispaired base and restores the original nucleotide before the codon is read."},{"label":"B","text":"Processing machinery excises the altered segment from the transcript before translation begins."},{"label":"C","text":"The substituted codon recruits a chemically similar amino acid that preserves the enzyme's folded structure."},{"label":"D","text":"Because multiple synonymous codons specify each amino acid, the altered codon still directs incorporation of the original residue."}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests degeneracy of the genetic code, the assignment of multiple codons to a single amino acid. The answer is D because the code contains 61 amino-acid-specifying codons but only 20 standard amino acids, so most amino acids are specified by two, four, or even six synonymous codons. Synonymous codons typically differ from one another at just one base, most often the last one, so a substitution there frequently converts one codon into another codon for the very same amino acid. When the ribosome reaches the altered codon, it recruits a tRNA carrying the identical residue, and the finished protein is indistinguishable from the original in both sequence and activity. Nothing needs to be repaired or compensated for; the message has changed in spelling but not in meaning, which is precisely the buffering role degeneracy is thought to play against random sequence changes. (Choice A) The ribosome does not proofread or correct the mRNA template. It reads whatever codon is presented in the A site; fidelity mechanisms during translation act on codon-anticodon pairing and aminoacyl-tRNA selection, not on restoring an original nucleotide sequence in the message. (Choice B) Spliceosomal processing removes entire introns from pre-mRNA in eukaryotes; it does not excise single substituted nucleotides, and the bacterial system described in the stem lacks spliceosomes altogether, so this step cannot occur at all, let alone rescue the codon. (Choice C) Chemically conservative replacements can sometimes preserve a protein's folded structure and activity, but that mechanism would still yield a protein containing a different amino acid at the affected position. The stem states that the purified enzyme is identical in amino acid sequence, which rules out any scenario in which a different residue was incorporated. This is a Scientific Reasoning and Problem Solving question because it requires you to connect an observed unchanged protein back to the underlying property of the code, reasoning from the substitution through the synonymous codon to the identity of the incorporated residue.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$imagined proofreading$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$wrong processing step$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$contradicted by given data$q$ FROM q;

-- Q8 . Antiparallel anticodon sequence derivation . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Antiparallel anticodon sequence derivation$q$,
    $q$During elongation, the codon 5'-GCU-3' occupies the ribosomal A site. tRNA molecules sample the site until one pairs stably with this codon across all three positions. Written in the 5' to 3' direction, what is the sequence of that tRNA's anticodon?$q$,
    $q$[{"label":"A","text":"5'-AGC-3'"},{"label":"B","text":"5'-CGA-3'"},{"label":"C","text":"5'-UCG-3'"},{"label":"D","text":"5'-GCU-3'"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests codon-anticodon pairing, specifically the requirement that the two triplets pair in an antiparallel and complementary fashion. The answer is A because deriving an anticodon takes two distinct steps: complement each base of the codon, then account for the opposite polarity of the paired strand. The codon 5'-GCU-3' pairs base by base with the anticodon 3'-CGA-5'; G pairs with C, C pairs with G, and U pairs with A. Rewriting 3'-CGA-5' in conventional 5' to 3' notation gives 5'-AGC-3'. A useful self-check is to align the two triplets head to tail: the codon's 5' G sits opposite the anticodon's 3' C, and the codon's 3' U sits opposite the anticodon's 5' A, exactly as antiparallel nucleic acid strands must align. This antiparallel arrangement is the same geometry found in every nucleic acid duplex, from the DNA double helix to the short helical stems within the tRNA itself. (Choice B) 5'-CGA-3' is the complement of the codon written in the same direction, which would require the two RNA strands to pair parallel to each other. Nucleic acid duplexes, including the short codon-anticodon helix formed in the A site, form only between antiparallel strands, so a tRNA presenting this sequence could not pair stably across all three positions. (Choice C) 5'-UCG-3' is the codon read backward without complementing the bases. Reversing the polarity is only half of the derivation; each position must also be complementary, and aligning this sequence with the codon would place G opposite G, C opposite C, and U opposite U, none of which can hydrogen bond as a standard pair. (Choice D) 5'-GCU-3' is identical to the codon itself, reflecting the mistaken idea that the anticodon copies the codon because the tRNA must match the message. Matching here means complementary pairing, not identity, and an identical triplet would present three self-pairs that cannot form. This is a Scientific Reasoning and Problem Solving question because it asks you to apply complementary base pairing together with antiparallel strand polarity to derive a sequence rather than to recall a stated fact.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$same-direction complement trap$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$half the derivation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$identity equals matching$q$ FROM q;

-- Q9 . Minimum tRNA count under wobble . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Minimum tRNA count under wobble$q$,
    $q$The six codons specifying serine are 5'-UCU-3', 5'-UCC-3', 5'-UCA-3', 5'-UCG-3', 5'-AGU-3', and 5'-AGC-3'. Assume that a single tRNA species can pair with every codon that differs from the others it reads only at the third codon position, while pairing at the first two positions must be an exact Watson-Crick match. Under this assumption, what is the minimum number of distinct serine tRNA species needed to translate all six codons?$q$,
    $q$[{"label":"A","text":"One"},{"label":"B","text":"Two"},{"label":"C","text":"Three"},{"label":"D","text":"Six"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests the consequence of wobble pairing for the tRNA inventory of a cell, using a supplied set of codon assignments. The answer is B because the stated rule lets one tRNA cover any group of codons that are identical at their first two positions. Sorting the six serine codons by their first two bases yields exactly two groups: UCU, UCC, UCA, and UCG all begin with UC, while AGU and AGC begin with AG. One tRNA species reads the entire UC group, since its four members differ only at position three, and a second tRNA reads the AG pair for the same reason. No single tRNA can span both groups, because a UC codon and an AG codon differ at the first and second positions, where the stem requires exact Watson-Crick pairing. The minimum under the stated assumption is therefore two species. (Choice A) One tRNA would suffice only if relaxed pairing extended to the first two codon positions. Wobble genuinely reduces the number of tRNAs a cell needs, but the flexibility is confined to the third position, so codons that differ in their first two bases always require different tRNA species. (Choice C) Three is the count obtained by applying the real, more restrictive wobble pairing rules, in which a given anticodon base reads only certain third-position bases and a four-codon group often splits into a pyrimidine-ending pair and a purine-ending pair. The stem, however, explicitly grants a single tRNA the ability to read all third-position variants, so that biological refinement must be set aside in favor of the stated assumption. (Choice D) Six assumes that every codon demands its own perfectly matched tRNA across all three positions. That is exactly the strict one-codon, one-tRNA picture that the wobble concept overturns, and it directly contradicts the pairing rule the question instructs you to apply. This is a Data-based and Statistical Reasoning question because it requires you to organize a supplied codon set into equivalence groups under a stated pairing rule and count those groups to determine a minimum.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$over-extended wobble$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true biology, wrong ruleset$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$one codon one tRNA$q$ FROM q;

-- Q10 . Codon position substitution tolerance . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Codon position substitution tolerance$q$,
    $q$An mRNA fragment reads 5'-AUGCAUGGUACC-3', and translation initiates at the first nucleotide of the fragment, with nucleotides numbered from the 5' end. A researcher prepares two mutant mRNAs, one carrying an A-to-G substitution at nucleotide 5 and the other carrying a U-to-C substitution at nucleotide 9. The protein translated from the nucleotide 9 mutant is identical in amino acid sequence to the protein from the original mRNA, whereas the protein from the nucleotide 5 mutant carries a single amino acid replacement. Which statement best explains why the nucleotide 9 protein is unchanged while the nucleotide 5 protein is not?$q$,
    $q$[{"label":"A","text":"The ribosome pairs the anticodon with only the first two bases of each codon, so the identity of a codon's third base is never read during elongation."},{"label":"B","text":"Replacing one pyrimidine with another is chemically conservative and is tolerated at any position of a codon, whereas replacing one purine with another always changes the encoded amino acid."},{"label":"C","text":"Nucleotide 9 occupies the third position of its codon, where synonymous codons for an amino acid typically differ, whereas nucleotide 5 occupies a second position, the strongest single determinant of amino acid identity."},{"label":"D","text":"Nucleotide 9 begins the codon spanning nucleotides 9 through 11, and substitutions at the first position of a codon never alter the encoded amino acid."}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the positional architecture of degeneracy, the pattern in which the first two bases of a codon largely determine the amino acid while synonymous codons typically differ at the third base. The answer is C because translation initiating at nucleotide 1 sets a reading frame in which the codons span nucleotides 1 through 3, 4 through 6, 7 through 9, and 10 through 12. Mapping each substitution onto that frame is the essential first step: nucleotide 5 falls at the second position of the second codon, and nucleotide 9 falls at the third position of the third codon. The code table is organized into blocks defined by the first two bases of each codon, and codons ending in the pyrimidines U and C virtually always specify the same amino acid, so a U-to-C change at a third position converts a codon into a synonym of itself and leaves every residue in the protein intact. The middle base, in contrast, is the strongest single determinant of amino acid identity, so the A-to-G change at nucleotide 5 assigns a new residue, exactly matching the single replacement observed. (Choice A) The third base is not skipped during decoding; it is read through relaxed pairing and must still pair with the anticodon. Tolerance at this position comes from the code assigning synonyms that differ there, not from the position being invisible, and in the code's two-codon half-blocks a third-position change between a pyrimidine and a purine does alter the residue. (Choice B) Chemical conservativeness of the swap is not what decides the outcome. A pyrimidine-for-pyrimidine change at a second position still changes the encoded amino acid, and purine-for-purine changes at third positions are frequently synonymous, so both halves of this claim fail once codon position is taken into account. (Choice D) This choice applies the wrong reading frame. With initiation at nucleotide 1, the third codon spans nucleotides 7 through 9, so nucleotide 9 is a third position, not a first position; moreover, first-position substitutions frequently change the encoded residue, so the stated tolerance rule is also false. This is a Scientific Reasoning and Problem Solving question because it requires you to construct the reading frame from the stated initiation site, map each substituted nucleotide to its codon position, and apply the positional pattern of degeneracy to explain the contrasting outcomes.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$tolerant position mistaken for unread position$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$chemistry of the swap over position of the swap$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$frame grouped from the wrong start$q$ FROM q;

-- Q11 . RNA class functional division of labor . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$RNA class functional division of labor$q$,
    $q$A cultured eukaryotic cell line carries a mutation confined to a single class of RNA. Its protein coding transcripts are synthesized, matured, and exported to the cytoplasm at normal rates. Charging assays show that each amino acid is still attached to its correct carrier RNA, and sequencing shows that the message reading end of each carrier RNA is unaltered. Despite all of this, the cells fail to accumulate any new polypeptides. Which class of RNA is most likely defective?$q$,
    $q$[{"label":"A","text":"Messenger RNA"},{"label":"B","text":"Heterogeneous nuclear RNA"},{"label":"C","text":"Ribosomal RNA"},{"label":"D","text":"Transfer RNA"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the division of labor among the three major classes of RNA: messenger RNA carries the protein coding message from nucleus to cytoplasm, transfer RNA delivers amino acids, and ribosomal RNA builds and operates the machine that joins them. The answer is C because every other participant in protein synthesis has been cleared by direct observation, so the failure must lie in the ribosomal RNA that forms the structural and functional core of the ribosome. Work through the observations by elimination. The message arm is intact: protein coding transcripts are synthesized, matured, and exported to the cytoplasm at normal rates, so a usable template reaches the site of synthesis. The adapter arm is intact at both of its working ends: charging assays confirm that each amino acid is attached to its correct carrier RNA, and sequencing confirms that the message reading ends are unaltered, so activated building blocks stand ready and can still find their assigned positions. The only remaining component of the pathway is the ribosome itself, and the ribosome is predominantly ribosomal RNA, which folds into the scaffold of both subunits and provides the machine's working center. Ribosomal RNA accounts for the majority of the ribosome's mass and is far from inert packing material; without properly made ribosomal RNA, functional ribosomes cannot assemble, leaving the cell with a readable message and loaded adapters but no machine to bring them together, exactly the phenotype described. (Choice A) Loss of messenger RNA would certainly halt protein synthesis, but the stem states that protein coding transcripts are produced, matured, and exported normally, which directly excludes this class. (Choice B) Heterogeneous nuclear RNA is the unprocessed nuclear precursor of messenger RNA; because maturation and export are proceeding normally, the precursor pool must be intact and cannot be the defective class. (Choice D) The normal charging result and the unaltered message reading ends clear the carrier RNAs at both of their working ends, so the adapters passed inspection; blaming them ignores observations the stem explicitly supplies. This is a Scientific Reasoning and Problem Solving question because it requires eliminating RNA classes one at a time from experimental observations to isolate the component responsible for the failed process.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$true consequence, contradicted by given data$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$neighboring molecule in the same pathway$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$blames a step the data already cleared$q$ FROM q;

-- Q12 . Transfer RNA two ended adapter logic . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Transfer RNA two ended adapter logic$q$,
    $q$In a reconstituted translation system, the codon 5'-UGU-3' specifies cysteine and the codon 5'-GCA-3' specifies alanine. Researchers mutate only the anticodon loop of a cysteine specific tRNA so that it now base pairs with 5'-GCA-3', and charging assays confirm that the altered tRNA still carries cysteine on its 3' end. If this altered molecule is the only cysteine carrying tRNA present, at which positions of the growing polypeptide will cysteine appear?$q$,
    $q$[{"label":"A","text":"At positions encoded by 5'-GCA-3' codons in the mRNA"},{"label":"B","text":"At positions encoded by 5'-UGU-3' codons in the mRNA"},{"label":"C","text":"At no position, because the ribosome rejects any tRNA whose attached amino acid does not match the codon"},{"label":"D","text":"At no position, because the cysteine is removed and replaced with alanine at the ribosome before each peptide bond forms"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests the two ended adapter logic of transfer RNA architecture: the anticodon loop at one end of the cloverleaf reads the message, the amino acid rides on the 3' CCA end at the other, and the two ends operate independently. The answer is A because the ribosome selects an incoming tRNA solely by base pairing between the mRNA codon and the tRNA anticodon, so this altered adapter will deposit its cysteine cargo wherever its new anticodon can pair, at codons that normally specify alanine. Once an amino acid has been loaded onto a tRNA, nothing in the elongating ribosome reexamines the identity of that amino acid; placement is dictated entirely by which codon the anticodon pairs with. The mutation moved the reading end to a new codon while leaving the carrying end and its cysteine untouched, so the finished protein will contain cysteine at positions the gene intended for alanine. This independence of the two ends is precisely why tRNA is described as a molecular adapter: one end reads, the other end carries, and neither checks the other's work. (Choice B) This reverses the relationship by assuming that the attached amino acid determines where the tRNA delivers; codon recognition belongs exclusively to the anticodon end, and that end no longer pairs with the cysteine codon. (Choice C) No such checkpoint exists; the ribosome does not compare the delivered amino acid against the codon, and fidelity at this step rests entirely on codon anticodon pairing, which is exactly what makes this experiment informative. (Choice D) Amino acid attachment, and any correction of a wrongly attached amino acid, is the business of the aminoacyl tRNA synthetase before the tRNA ever reaches the ribosome; the stem confirms the adapter arrives still carrying cysteine, so no swap to alanine can occur during elongation. This is a Scientific Reasoning and Problem Solving question because it asks you to predict the outcome of an experiment that deliberately decouples the reading end of a tRNA from its carrying end.$q$,
    'medium',
    '5D',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$swaps which end of the adapter governs targeting$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$invents a nonexistent proofreading checkpoint$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$relocates the charging step into elongation$q$ FROM q;

-- Q13 . Ribosomal RNA scaffold and catalyst roles . medium . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Ribosomal RNA scaffold and catalyst roles$q$,
    $q$Ribosomes contain both protein and RNA, and ribosomal RNA accounts for the majority of the particle's mass. Within the intact ribosome, the RNA component itself performs which of the following functions?

I. Maintaining the folded three dimensional architecture of the ribosomal subunits
II. Catalyzing a bond forming reaction during protein synthesis
III. Delivering activated amino acids to the site of protein synthesis$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and III only"},{"label":"D","text":"I and II only"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests the modern understanding of ribosomal RNA as both a structural scaffold and an active catalyst rather than inert packing material. The answer is D because statements I and II are both accurate: ribosomal RNA folds into the framework that maintains the architecture of the small and large subunits, and it also possesses genuine enzymatic activity, catalyzing bond formation during protein synthesis. Ribosomal RNA makes up most of the ribosome's mass, and its folded helices position the ribosomal proteins and the reacting molecules, so the ribosome is best understood as an RNA machine assisted by proteins rather than a protein machine held together by RNA. The finding that this RNA is itself catalytic places it among the ribozymes and overturned the older assumption that all biological catalysts must be proteins. Recognizing this dual capability explains why the ribosome remains functional even though its RNA outweighs its protein. Statement III, in contrast, describes the wrong RNA entirely: activated amino acids are delivered to the site of protein synthesis by transfer RNAs, each carrying its cargo on its 3' end, not by ribosomal RNA. (Choice A) Accepting only the structural role repeats the outdated picture of ribosomal RNA as passive scaffolding; it is true as far as it goes, but it omits the catalytic activity that structural and biochemical work established. (Choice B) Accepting only the catalytic role makes the opposite omission; the same RNA molecules that catalyze also form the load bearing architecture of both subunits, so denying the structural role discards half of the correct picture. (Choice C) This combination swaps in the delivery job that belongs to transfer RNA; delivering activated amino acids is a genuine RNA function, but it is performed by a different class of RNA operating outside the ribosome's own structure. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall the accepted functional roles of ribosomal RNA within the ribosome.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    1,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$old model retained, half the truth$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$opposite half truth$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$right function, wrong RNA$q$ FROM q;

-- Q14 . Identity of heterogeneous nuclear RNA . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Identity of heterogeneous nuclear RNA$q$,
    $q$Eukaryotic protein coding genes are transcribed within the nucleus. A researcher briefly pulse labels a mammalian cell line and immediately isolates the labeled RNA, recovering a population of long transcripts of widely varying sizes that are direct copies of protein coding genes and are found only in the nucleus, never in the cytoplasm. Which name identifies this RNA population?$q$,
    $q$[{"label":"A","text":"Mature messenger RNA"},{"label":"B","text":"Heterogeneous nuclear RNA (hnRNA)"},{"label":"C","text":"Small nuclear RNA (snRNA)"},{"label":"D","text":"Ribosomal RNA"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests recognition of the primary transcript, the freshly synthesized RNA population that eukaryotic protein coding genes produce inside the nucleus. The answer is B because a rapidly labeled, size varied, nucleus restricted collection of direct gene copies is heterogeneous nuclear RNA, also called pre-mRNA, the immature transcript pool that has not yet been converted into an export ready message. Each clue in the stem maps onto this identity. The transcripts appear within minutes of labeling, so they are immediate products of transcription rather than accumulated mature species. They vary widely in length because they are unedited copies of genes of many different sizes, which is the origin of the name. They remain confined to the nucleus because a primary transcript must be modified before it is permitted to leave, so raw copies never appear in the cytoplasm in this form; only after that nuclear maturation, covered elsewhere, does the molecule earn the name messenger RNA. (Choice A) Mature messenger RNA is the finished product that emerges after nuclear maturation and functions in the cytoplasm; identifying a freshly labeled, nucleus only population as mature message confuses the end of the pathway with its beginning. (Choice C) Small nuclear RNAs are indeed nuclear residents, but they are short, uniformly sized molecules that serve as components of the nuclear machinery; they are not long direct copies of protein coding genes. (Choice D) Ribosomal RNA is also transcribed in the nucleus as a large precursor, but it is not copied from protein coding genes and never serves as a translatable message; its destination is the ribosome, not the protein coding pathway described. This is a Knowledge of Scientific Concepts and Principles question because it asks you to attach the correct name to the described primary transcript population of the eukaryotic nucleus.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$end product mistaken for precursor$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$shares the location, fails the size and origin clues$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$shares the location and length, fails the coding origin clue$q$ FROM q;

-- Q15 . Single strandedness enables intramolecular folding . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Single strandedness enables intramolecular folding$q$,
    $q$Transfer RNA molecules adopt a compact L-shaped conformation that positions the anticodon and the amino acid attachment site at opposite ends of the molecule, and this conformation is required for the molecule to work during protein synthesis. Which property of the molecule makes this conformation possible?$q$,
    $q$[{"label":"A","text":"Guanine's ability to pair with uracil as well as cytosine allows the chain to switch freely among many alternative shapes"},{"label":"B","text":"Covalent bonds form between distant bases, permanently locking the chain into its final shape"},{"label":"C","text":"Because the chain is a single strand, internal complementary regions can double back and pair, forming short stems that organize the fold"},{"label":"D","text":"Base pairing between the anticodon and a messenger RNA codon supplies the contacts that hold the molecule in its folded state"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the structural chain that links RNA single strandedness to intramolecular folding and, ultimately, to biological function. The answer is C because an RNA chain, unlike double helical DNA, has no full length partner strand occupying its bases. Any internal stretch is therefore free to search the rest of the same chain for a complementary run, double back, and form a short antiparallel duplex. These paired segments, called stems, together with their connecting loops, collapse the chain into hairpins and cloverleaf arms, and additional tertiary contacts then fold those elements into the compact L shape of transfer RNA. The same logic explains why ribosomal RNA acquires an elaborate architecture: single strandedness is not a limitation but the very feature that permits a defined three dimensional structure, which in turn is what these molecules need to perform their roles in protein synthesis. (Choice A) Guanine can indeed form a nonstandard pair with uracil within folded RNAs, and such pairs appear in real stems. However, this pairing versatility does not make the molecule flip freely among many alternative shapes; transfer RNA folds into one defined functional conformation, and such nonstandard pairs merely add to the stability of that single fold. (Choice B) The folded shape is maintained by hydrogen bonded base pairs and base stacking, which are individually weak, noncovalent interactions. Distant bases are not joined by covalent crosslinks, and the fold is not permanently locked; it is an equilibrium structure held together by many cooperative weak contacts. (Choice D) Pairing between the anticodon and a codon of messenger RNA is a transient, intermolecular event that occurs during translation, after the transfer RNA is already folded. It is a step in decoding, not a source of the molecule's own tertiary structure, so it cannot explain how the folded shape arises. This is a Scientific Reasoning and Problem Solving question because it requires connecting a structural property of a nucleic acid, single strandedness, through intramolecular base pairing to the functional three dimensional shape that pairing produces.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q16 . Hairpin prediction from sequence data . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Hairpin prediction from sequence data$q$,
    $q$A researcher synthesizes two 16-nucleotide RNA molecules: Sequence 1 is 5'-GGCAGCUUCGGCUGCC-3' and Sequence 2 is 5'-GGCAGCUUCGGGCAGC-3'. In this experiment a hairpin is scored as stable only if it contains a stem of at least five consecutive base pairs. When each molecule is placed under folding conditions, which outcome is expected?$q$,
    $q$[{"label":"A","text":"Only Sequence 1 folds into a hairpin, because its final six nucleotides can pair in antiparallel orientation with its first six nucleotides"},{"label":"B","text":"Only Sequence 2 folds into a hairpin, because it carries two identical copies of GGCAGC that can bind each other"},{"label":"C","text":"Both sequences fold into hairpins, because both contain guanine and cytosine rich segments, and high guanine plus cytosine content is sufficient to drive pairing"},{"label":"D","text":"Neither sequence folds into a hairpin, because a lone RNA strand has no partner strand available for base pairing"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests whether you can predict intramolecular folding from raw sequence data by applying the rules of antiparallel complementary base pairing. The answer is A because a hairpin stem forms only when one segment of a strand is the reverse complement of another segment of the same strand. In Sequence 1, the first six nucleotides are GGCAGC and the last six are GCUGCC. When the chain doubles back, the two segments run in opposite directions, and aligning them antiparallel gives the pairs G with C, G with C, C with G, A with U, G with C, and C with G, a six base pair stem closed by a UUCG loop. That exceeds the five pair threshold given in the problem, so Sequence 1 folds into a stable hairpin. In Sequence 2, the final six nucleotides are GGCAGC, identical to the first six rather than complementary to them; identical segments cannot satisfy antiparallel pairing geometry, and no other stretch of five or more consecutive complementary pairs exists anywhere in the molecule, so no stable stem can form. (Choice B) Identical repeats look self matching at a glance, but base pairing requires complementarity read in opposite directions along the two segments. Two copies of the same sequence would have to run parallel to align, and even then they would mismatch at nearly every position, guanine facing guanine and so on. (Choice C) Guanine and cytosine pairs are indeed held by three hydrogen bonds and contribute strongly to a stem once formed, but composition alone cannot create pairing; the bases must be arranged as reverse complements of one another, and Sequence 2's guanine and cytosine rich segments are not. (Choice D) This reverses the actual relationship between strandedness and folding. It is precisely because a lone RNA strand has no partner occupying its bases that those bases remain available for internal pairing, and folding back on itself is the characteristic behavior of single stranded RNA. This is a Data-based and Statistical Reasoning question because it requires extracting and aligning nucleotide sequence data to determine which molecule contains the internal complementarity needed to form a hairpin.$q$,
    'hard',
    '5D',
    $q$Gene Expression$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- Q17 . Reactive sugar hydroxyl underlying catalysis . easy . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Reactive sugar hydroxyl underlying catalysis$q$,
    $q$Certain RNA molecules called ribozymes accelerate specific cellular reactions, and researchers attribute this ability in part to a chemically reactive group that DNA nucleotides lack. DNA shows no comparable catalytic behavior in cells. Which feature of the ribonucleotide supplies this reactivity?$q$,
    $q$[{"label":"A","text":"The nitrogenous bases of RNA are stronger nucleophiles than the corresponding bases in DNA"},{"label":"B","text":"Newly transcribed RNA retains high energy triphosphate groups along its length that drive the catalyzed reactions"},{"label":"C","text":"Uracil lacks the methyl group present on thymine, leaving an exposed ring position"},{"label":"D","text":"A hydroxyl group on the second carbon of the sugar, a position at which deoxyribonucleotides carry only a hydrogen atom"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests what the distinctive chemistry of the ribonucleotide sugar allows RNA to do, namely act as more than a passive carrier of sequence information. The answer is D because ribose carries a hydroxyl group on its second carbon, a position that in deoxyribose bears only a hydrogen atom. A hydroxyl is a genuine functional group: it can donate hydrogen bonds, help coordinate metal ions, and, once activated, attack other groups during a chemical transformation. In several natural ribozymes the reaction proceeds exactly this way, with a suitably positioned sugar hydroxyl serving as the nucleophile that initiates catalysis. Because every sugar in the chain carries this reactive handle, an RNA molecule is studded with chemically usable groups, which is consistent with RNA's documented ability to catalyze reactions, something no cellular DNA is known to do. (Choice A) With the exception of uracil replacing thymine, the bases of RNA are the same bases found in DNA, and their intrinsic chemistry is not systematically more nucleophilic in RNA. A feature shared by both molecules cannot explain a capability that RNA has and DNA lacks. (Choice B) High energy triphosphates power the polymerization of nucleotides while RNA is being synthesized; the finished chain contains ordinary phosphodiester linkages and at most a single terminal triphosphate. Ribozyme catalysis is a property of the folded, completed molecule, not a leftover of the energetics of its own synthesis. (Choice C) Uracil does differ from thymine by the absence of a methyl group at one ring carbon, but that is a real yet irrelevant difference here; a missing methyl group does not create a reactive functional group, and it has no established role in conferring catalytic ability. This is a Scientific Reasoning and Problem Solving question because it asks you to identify which molecular feature of the ribonucleotide is chemically capable of explaining an observed functional difference between RNA and DNA.$q$,
    'easy',
    '5D',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q;

-- Q18 . Compensatory mutations localize function to shape . hard . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Compensatory mutations localize function to shape$q$,
    $q$A 60-nucleotide RNA is required for a particular cellular process, and a folding model predicts that nucleotides 10 through 15 pair with nucleotides 40 through 45 to form a stem. Researchers replace nucleotides 10 through 15 with their complementary bases, and this variant no longer supports the process. They then construct a double variant in which nucleotides 40 through 45 are also replaced, restoring pairing between the two regions even though both regions now differ from the original sequence, and this double variant fully supports the process. These results support which conclusion?$q$,
    $q$[{"label":"A","text":"A cellular factor recognizes the specific base identities at positions 10 through 15"},{"label":"B","text":"The process requires the paired stem itself rather than the particular bases that compose it"},{"label":"C","text":"The double variant regained function because the second change reverted the first region to its original bases"},{"label":"D","text":"Nucleotides outside the paired regions could likewise be replaced without consequence, since only pairing was shown to matter"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests interpretation of a compensatory mutation experiment designed to distinguish whether an RNA's function resides in its nucleotide sequence or in its folded shape. The answer is B because of the logic connecting the two constructs. The first variant changes one side of the predicted stem, which destroys pairing but also changes sequence, so by itself it cannot separate the two explanations. The decisive construct is the double variant: it restores the ability of the two regions to pair while leaving both regions different from the original sequence. If a cellular factor needed to read specific bases, this variant should remain nonfunctional, because those bases are gone; instead, function returns in full, so what the process requires is the paired stem itself, the shape, and not the identity of the bases within it. (Choice A) This is the conclusion the experiment rules out, and it inverts what the data show. The fully functional double variant carries non original bases at positions 10 through 15, so a factor reading those exact base identities would fail to recognize it, yet the process proceeds normally. (Choice C) This misreads the design. The compensatory change is made on the opposite side of the stem, at positions 40 through 45, and the problem states explicitly that both regions differ from the original sequence, so no reversion occurred. Confusing restoration of pairing with restoration of sequence is exactly the error this design guards against. (Choice D) This overextends the data. The unpaired nucleotides between the two stem halves were never altered in either construct, so the experiment says nothing about whether they can be replaced. Concluding that they are freely substitutable goes beyond what was tested, even though the stem bases themselves proved replaceable when pairing was preserved. This is a Reasoning about the Design and Execution of Research question because it requires evaluating what a compensatory double mutation can and cannot demonstrate about where an RNA's function resides.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    3,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

COMMIT;

-- Verification: expect 18 questions and 54 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'RNA and the Genetic Code') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'RNA and the Genetic Code') AS distractor_rows;
