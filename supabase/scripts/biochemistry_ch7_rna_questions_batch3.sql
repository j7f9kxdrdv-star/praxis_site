-- Biochemistry Chapter 7: RNA and the Genetic Code, standalone questions
-- BATCH 3 of 4 (18 questions): Unit E, translation (ribosome subunits and the A/P/E sites,
--   Shine-Dalgarno versus cap-scanning initiation, assembly order, the elongation cycle, the
--   peptidyl-transferase-is-rRNA crown jewel keyed on the stripped-subunit evidence, release-
--   factor termination, GTP cost counting, coupled transcription-translation) . Unit F,
--   targeting and post-translational processing (signal-sequence mechanism with deletion/swap
--   predictions, signal cleavage, glycosylation, prenylation, chaperones as kinetic assistants).
--
-- PURE INSERTs: run AFTER batches 1 and 2. Boundary rules honoured: no antibiotic-selectivity
-- key (Bio Ch1 owns it; subunit composition itself is keyed here); the chaperone key is
-- compatible with the live Anfinsen keys (prevent aggregation, never determine the fold); no
-- vesicle tracing past the ER (Ch8 forward reservation). Q3 was replaced pre-ship: a slice
-- writer duplicated the crown-jewel ribozyme-evidence item; the replacement keys tRNA traffic
-- through the A, P and E sites with identical pinned metadata.

BEGIN;

-- B3 Q1 . reconstituting ribosomes from subunits . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$reconstituting ribosomes from subunits$q$,
    $q$A researcher lyses a bacterial culture and a mammalian cell line, dissociates all of the ribosomes into their component subunits, and pools the subunits into a single mixture. She then attempts to reassemble a functional bacterial 70S ribosome from the pool. Which pair of subunits must she combine?$q$,
    $q$[{"label":"A","text":"A 40S subunit and a 30S subunit"},{"label":"B","text":"A 50S subunit and a 30S subunit"},{"label":"C","text":"A 60S subunit and a 40S subunit"},{"label":"D","text":"A 50S subunit and a 40S subunit"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests knowledge of ribosome subunit composition, specifically which subunits assemble into the prokaryotic 70S ribosome. The answer is B because the bacterial ribosome is built from a large 50S subunit and a small 30S subunit. Sedimentation coefficients, expressed in Svedberg units, describe how rapidly a particle sediments in a centrifugal field, and that behavior depends on particle shape and density as well as mass. Because the coefficient is not a simple measure of mass, the values of the two subunits are not additive: combining a 50S subunit with a 30S subunit produces a 70S ribosome rather than an 80S particle. The eukaryotic ribosome has a parallel but distinct architecture, pairing a 60S large subunit with a 40S small subunit to form the 80S ribosome, and those eukaryotic subunits are also present in the pooled mixture as decoys. To reconstitute a functional bacterial 70S particle, the researcher must therefore select the one large and one small subunit that are both bacterial in origin, the 50S and the 30S. (Choice A) Pairing a 40S subunit with a 30S subunit is tempting because the numbers appear to sum to 70, but Svedberg values do not add arithmetically, so numerical addition cannot identify the correct pair. This option also combines two small subunits, one eukaryotic and one prokaryotic, and no functional ribosome can be built from two small subunits. (Choice C) A 60S subunit joined to a 40S subunit is the composition of the eukaryotic 80S ribosome present in the mammalian lysate, not the bacterial 70S particle the researcher is trying to rebuild. (Choice D) The 50S subunit is indeed the correct bacterial large subunit, but the 40S small subunit belongs to the eukaryotic ribosome. A mixed pairing of a bacterial large subunit with a eukaryotic small subunit does not reproduce the natural composition of the 70S particle. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall which large and small subunits assemble into the prokaryotic ribosome and to recognize that sedimentation values are not additive.$q$,
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
  SELECT q.id, 'A', 'scale_unit_error', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B3 Q2 . subunit division of labor . medium . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$subunit division of labor$q$,
    $q$The two ribosomal subunits divide the work of translation between them. Consider the following activities:

I. Binding the mRNA template and monitoring codon-anticodon pairing as the message is read
II. Catalyzing formation of the peptide bonds that link successive amino acids
III. Providing the binding sites through which incoming charged tRNAs deliver their amino acids

Which of these activities occur primarily on the large ribosomal subunit?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I and III only"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the division of labor between the small and large ribosomal subunits during translation. The answer is C because both peptide bond catalysis (activity II) and sequential tRNA binding (activity III) are functions housed primarily on the large subunit. The large subunit contains the peptidyl transferase center, the catalytic site where each new peptide bond forms between the incoming amino acid and the growing chain. The large subunit also provides the compartments through which successive charged tRNAs dock, surrender their amino acids to the chain, and ultimately exit. The small subunit performs the complementary job described in activity I: it binds the mRNA template and monitors the pairing between each codon and the anticodon of the tRNA being auditioned, ensuring that only a correctly matched tRNA is accepted. Sorting each described task to its subunit therefore places II and III on the large subunit and I on the small subunit. (Choice A) Activity I, binding the mRNA and monitoring codon-anticodon pairing, is the defining role of the small subunit, so assigning it to the large subunit reverses the actual division of labor. This choice also excludes both of the activities the large subunit genuinely performs. (Choice B) Activity II alone is incomplete. Peptide bond catalysis is indeed a large subunit function, but the large subunit additionally supplies the tRNA binding compartments of activity III, so stopping at II captures only part of its role. (Choice D) This combination pairs one correct assignment, activity III, with the mistaken belief that because tRNAs pair with codons, the decoding function must sit on the same subunit that holds the tRNA body. In fact, codon reading takes place where the mRNA threads through the ribosome, on the small subunit, even though the tRNA bodies extend into the large subunit. This is a Knowledge of Scientific Concepts and Principles question because it asks you to assign each described translational activity to the correct ribosomal subunit.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B3 Q3 . Labeled tRNA itinerary through sites . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Labeled tRNA itinerary through sites$q$,
    $q$A biochemist attaches a fluorescent tag to the body of a phenylalanyl-tRNA, adds it to an active in vitro translation system, and follows the tag through one complete elongation cycle on a single ribosome. From the moment this charged tRNA is delivered to the ribosome until the moment it is released, which itinerary will the tag trace through the ribosomal tRNA binding sites?$q$,
    $q$[{"label":"A","text":"Entry at the A site as an aminoacyl-tRNA, movement to the P site where it holds the growing polypeptide, and departure from the E site as a deacylated tRNA"},{"label":"B","text":"Entry at the A site, movement to the P site where it holds the growing polypeptide, and release directly from the P site once it no longer carries the chain"},{"label":"C","text":"Entry at the P site, since tRNAs destined to carry the peptide chain bind the peptidyl site first, followed by passage through the A site and release from the E site"},{"label":"D","text":"Entry at the E site, movement to the P site, and departure from the A site, matching the ribosome's 5' to 3' movement along the mRNA"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests the ordered path that a single tRNA travels through the ribosome's three binding sites during translation elongation. The answer is A because every elongator tRNA follows the same one-way route through the ribosome. The tagged tRNA arrives at the A (aminoacyl) site as a charged aminoacyl-tRNA, admitted when its anticodon pairs with the mRNA codon positioned in that site. After the growing polypeptide becomes joined to the amino acid carried by this tRNA, the ribosome translocates along the mRNA, shifting the tagged tRNA into the P (peptidyl) site. There it holds the elongating chain while the next charged tRNA is recruited to the newly vacated A site. Once the chain is handed forward to that newcomer, the now deacylated tagged tRNA is shifted into the E (exit) site and released from the ribosome, free to be recharged by its aminoacyl-tRNA synthetase. The fluorescent tag therefore traces the sequence A site, then P site, then E site, with a defined chemical status at each stop: charged on entry, peptide-bearing in the middle, and empty on the way out. (Choice B) The first two legs of this itinerary are accurate, since the tagged tRNA does enter at the A site and does advance to the P site while holding the chain. The exit step is wrong, however. A deacylated tRNA is not ejected directly from the P site; translocation first moves it into the dedicated E site, and release occurs from there. (Choice C) This reverses the roles of the first two sites. The P site is named for the peptidyl-tRNA it holds in the middle of the cycle, not for being a point of entry, and elongator tRNAs never bind there first. The only tRNA that ever begins in the P site is the initiator tRNA during formation of the translation complex, an exception that does not apply to a charged tRNA followed through an elongation cycle. (Choice D) The directionality cited here is a genuine feature of translation, since the ribosome does advance along the mRNA toward its 3' end, but that fact describes movement along the message, not the route of a tRNA within the ribosome. Relative to the three sites, every elongator tRNA moves from A to P to E, so an E-to-P-to-A itinerary runs the traffic exactly backward. This is a Scientific Reasoning and Problem Solving question because it requires converting an experimental description of a labeled molecule tracked over time into a prediction about the ordered series of ribosomal sites that molecule must occupy, rather than recalling an isolated definition.$q$,
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
  SELECT q.id, 'B', 'partial_truth', $q$truncated pathway$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$name-based role reversal$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$true fact, wrong frame$q$ FROM q;

-- B3 Q4 . elongation snapshot residue count . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$elongation snapshot residue count$q$,
    $q$A bacterial ribosome is chemically frozen during elongation, and the contents of its three tRNA sites are catalogued. The P site holds a tRNA attached to a growing peptide of four amino acid residues. The A site holds a charged tRNA carrying a single methionine that has not yet been joined to anything. The E site is empty. If the block is removed and the ribosome completes only the single next event in the elongation cycle, how many amino acid residues will be attached to the tRNA occupying the A site?$q$,
    $q$[{"label":"A","text":"Zero"},{"label":"B","text":"One"},{"label":"C","text":"Four"},{"label":"D","text":"Five"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests data-based reasoning about the state of a translating ribosome frozen in mid-elongation. The answer is D because the next event in the cycle is peptide bond formation, which transfers the entire four residue chain from the P site tRNA onto the amino acid held by the A site tRNA, producing a five residue peptide attached to the A site tRNA. The catalogued snapshot shows a charged tRNA already delivered to the A site and a peptidyl tRNA in the P site, which places the ribosome after tRNA selection but before bond formation. When the block is removed, the peptidyl transferase center joins the carboxyl end of the four residue chain to the amino group of the methionine in the A site. The chemistry of this transfer runs from the P site tRNA to the A site tRNA, so the lengthened chain ends up on the A site tRNA while the P site tRNA is left empty. Counting gives four transferred residues plus the one methionine already present, for five residues in total on the A site tRNA. (Choice A) Zero reverses the direction of transfer. If the methionine were added onto the chain held by the P site tRNA, the A site tRNA would be stripped bare, but peptidyl transfer runs the other way, moving the chain onto the A site tRNA. (Choice B) One would be correct only if the next event left the A site tRNA unchanged, for example if translocation happened before bond formation. In the elongation cycle the bond forms first, while both tRNAs still occupy their sites, so the A site tRNA cannot remain a single residue carrier after the next event. (Choice C) Four is the chain length before the event and assumes the peptide simply relocates to the A site tRNA without incorporating the methionine. The incoming residue is joined to the chain in the very same step, so the count must increase by one. This is a Data-based and Statistical Reasoning question because it requires you to read the catalogued state of each ribosomal site and predict the residue count that results from the next step in elongation.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- B3 Q5 . Shine Dalgarno ribosome positioning . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$Shine Dalgarno ribosome positioning$q$,
    $q$A bacterial mRNA contains several internal AUG triplets in addition to its true start codon. A purine-rich element located a few nucleotides upstream of the start codon base pairs with rRNA in the small 30S ribosomal subunit, and a mutation that scrambles this element sharply reduces translation of the message even though the start codon itself is unchanged. The scrambled element most likely impairs translation because it can no longer:$q$,
    $q$[{"label":"A","text":"serve as the binding site for the initiation factor that escorts the initiator tRNA to the ribosome"},{"label":"B","text":"base pair with the anticodon of the initiator tRNA"},{"label":"C","text":"anchor the small ribosomal subunit so that initiation begins at the correct AUG rather than an internal one"},{"label":"D","text":"recruit the large 50S subunit to the message so that scanning toward the start codon can begin"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the mechanistic role of the Shine Dalgarno sequence in prokaryotic translation initiation. The answer is C because the purine rich element described is the Shine Dalgarno sequence, which base pairs with a complementary region of the rRNA within the small 30S ribosomal subunit. That pairing anchors the 30S subunit on the transcript at a fixed spacing upstream of the authentic start codon, so the correct AUG, and not one of the internal AUG triplets, is delivered into position where the initiator tRNA carrying N formylmethionine can occupy the P site. The element is therefore purely positional: it selects where initiation happens rather than participating in decoding or catalysis. This positioning logic also explains why bacterial ribosomes can initiate at internal sites of a polycistronic message, since each open reading frame can carry its own upstream ribosome binding element. When the element is scrambled, the 30S subunit can no longer be anchored at the proper site, productive initiation complexes rarely form, and translation collapses even though the start codon itself is untouched. (Choice A) The initiator tRNA is escorted to the ribosome by an initiation factor that binds the tRNA and the small subunit; that factor does not read this mRNA element, which interacts with rRNA rather than with protein factors. (Choice B) The anticodon of the initiator tRNA pairs with the AUG start codon itself, and the stem states that the start codon is unchanged; the upstream element never base pairs with tRNA. (Choice D) Bacterial ribosomes do not scan along the message, and the large 50S subunit joins only after the small subunit and initiator tRNA are already seated at the start codon; the large subunit is recruited by the completed small subunit initiation complex, not by an mRNA sequence element. This is a Scientific Reasoning and Problem Solving question because it requires predicting which initiation function is lost when a described base pairing interaction between an mRNA element and the small ribosomal subunit is disrupted.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B3 Q6 . cap directed small subunit recruitment . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$cap directed small subunit recruitment$q$,
    $q$In a eukaryotic cell-free translation system, an mRNA is treated with an enzyme that removes its 7-methylguanosine cap while leaving the remainder of the transcript, including the start codon and poly(A) tail, intact. The lysate lacks exonuclease activity, so the decapped transcript remains chemically stable throughout the experiment. Compared with the capped version, the decapped message will yield far less protein primarily because:$q$,
    $q$[{"label":"A","text":"the small 40S subunit is rarely loaded onto the 5' end of the message, so scanning toward the start codon seldom begins"},{"label":"B","text":"the initiator tRNA can no longer be charged with methionine by its synthetase"},{"label":"C","text":"the ribosome assembles at the start codon but cannot catalyze formation of the first peptide bond"},{"label":"D","text":"the transcript is rapidly destroyed from its unprotected 5' end before ribosomes can engage it"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question examines the ribosome recruitment role of the 5' cap in eukaryotic translation initiation. The answer is A because the 7-methylguanosine cap serves as the docking site through which cap binding protein and its partner initiation factors load the small 40S ribosomal subunit, already carrying the initiator methionyl tRNA, onto the 5' end of the message. From that entry point the 40S complex scans in the 5' to 3' direction until it encounters the start codon, at which point the large 60S subunit joins to complete the ribosome. Removing the cap eliminates the docking site, so the 40S subunit is rarely recruited, scanning almost never begins, and initiation fails even though every downstream element of the transcript is intact. The cap also normally shields transcripts from degradation, but the stem deliberately removes that variable by using a nuclease-free lysate, isolating the recruitment function as the reason protein output falls. (Choice B) Attachment of methionine to the initiator tRNA is carried out by an aminoacyl tRNA synthetase in a reaction that is completely independent of the mRNA and its cap; charging proceeds normally whether or not the message is capped. (Choice C) Peptide bond formation is catalyzed at the peptidyl transferase center of the large subunit after the full ribosome has assembled at the start codon; in the decapped system the failure occurs far upstream of this step, because the small subunit rarely reaches the start codon at all. (Choice D) Protection from 5' exonucleases is a genuine function of the cap in cells, but the stem specifies that this lysate lacks exonuclease activity and that the transcript remains stable, so degradation cannot account for the reduced output in this experiment. This is a Scientific Reasoning and Problem Solving question because it asks you to predict which step of initiation fails when a defined chemical feature is removed under conditions that exclude transcript degradation as an explanation.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B3 Q7 . ribosomal subunit assembly order . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$ribosomal subunit assembly order$q$,
    $q$During translation initiation, ribosomal components and the initiator tRNA assemble on an mRNA in a defined order that is shared by prokaryotes and eukaryotes. Which event completes the formation of a translation-competent ribosome on the message?$q$,
    $q$[{"label":"A","text":"Entry of the initiator tRNA into the A site of a ribosome that has already fully assembled on the mRNA"},{"label":"B","text":"Binding of an intact ribosome, with both subunits already joined, to the start codon"},{"label":"C","text":"Pairing of the initiator tRNA with the start codon before any ribosomal subunit has engaged the message"},{"label":"D","text":"Joining of the large subunit to a small subunit and initiator tRNA already positioned at the start codon"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests knowledge of the assembly order of the translation initiation complex. The answer is D because, in both prokaryotes and eukaryotes, the small ribosomal subunit and the initiator tRNA engage the mRNA first, forming an initiation complex positioned at the start codon, and only after that complex is in place does the large subunit join to produce a complete, translation-competent ribosome. In bacteria, the 30S subunit is anchored near the start codon and accepts the initiator tRNA carrying N formylmethionine before the 50S subunit arrives. In eukaryotes, the 40S subunit, loaded with the initiator methionyl tRNA, locates the start codon and is then joined by the 60S subunit. In both systems the arrival of the large subunit is the final event of initiation, and it leaves the initiator tRNA in the P site, ready for the first incoming aminoacyl tRNA to enter the A site when elongation begins. If the large subunit could not join, a small subunit initiation complex would still form on the message, but no peptide bond could ever be made, because the catalytic center for peptide bond formation resides on the large subunit. (Choice A) The initiator tRNA is positioned in the P site, not the A site, and it engages the message as part of the small subunit initiation complex before the ribosome is fully assembled, not after assembly is complete. (Choice B) Intact ribosomes do not bind mRNA as preformed two subunit particles during initiation; the subunits are separate, and the small subunit must engage the message on its own before the large subunit is recruited. (Choice C) The initiator tRNA does not find the start codon by itself ahead of the ribosomal machinery; it is delivered in association with the small subunit and initiation factors, so codon pairing occurs within the small subunit complex. This is a Knowledge of Scientific Concepts and Principles question because it asks for direct recall of the ordered assembly of the initiation complex, in which the small subunit and initiator tRNA engage the message before the large subunit completes the ribosome.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

-- B3 Q8 . diagnostic features of initiation systems . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$diagnostic features of initiation systems$q$,
    $q$A synthetic mRNA lacks any 5' cap, and its only functional AUG lies several hundred nucleotides downstream of the 5' end, with a purine-rich hexanucleotide positioned about eight nucleotides upstream of that AUG. In one of two cell-free lysates this message is translated efficiently, and analysis of the product reveals a formyl group attached to the alpha amino nitrogen of its N terminal methionine. The lysate that translated this message most likely came from:$q$,
    $q$[{"label":"A","text":"eukaryotic cells, because scanning from the 5' end always reaches the first available AUG whether or not a cap is present"},{"label":"B","text":"bacterial cells, because an internal purine-rich element can position the ribosome directly at a start codon without any requirement at the 5' end"},{"label":"C","text":"eukaryotic cells, because the formyl group marks the initiator methionine that the 80S ribosome lays down at the start codon"},{"label":"D","text":"bacterial cells, because bacterial ribosomes enter at the 5' cap and read along the message to the first AUG"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question requires diagnosing which translation system is at work from the features a message and its product display. The answer is B because two independent observations both point to a bacterial system. First, the message is translated efficiently despite lacking a 5' cap and despite its start codon sitting far from the 5' end; bacterial small subunits are positioned directly at start codons by base pairing between an upstream purine-rich element, the Shine Dalgarno sequence, and the rRNA of the 30S subunit, so no 5' end entry point and no scanning are required. Second, the product begins with a formylated methionine, and N formylmethionine is the initiator residue laid down in the P site only in prokaryotic translation, whereas eukaryotic cytosolic initiation uses unmodified methionine. The purine-rich hexanucleotide at the described spacing upstream of the AUG is exactly what a bacterial ribosome binding site looks like, so both the mechanism of initiation and the chemistry of the first residue identify the lysate as bacterial. (Choice A) Eukaryotic 40S subunits are recruited to the message through the cap and its binding proteins before scanning can begin; with no cap present, loading of the small subunit rarely occurs, so efficient translation of this message argues against a eukaryotic system rather than for one. (Choice C) This choice attaches the prokaryotic marker to the wrong system: the formyl group is diagnostic of bacterial initiation, whereas the eukaryotic 80S ribosome initiates with a methionine that carries no formyl modification. (Choice D) The conclusion is right but the mechanism is impossible: bacterial ribosomes never use a cap, which is a eukaryotic feature, and this message has no cap at all, so an answer built on cap-dependent entry cannot be credited even though it names the correct system. This is a Scientific Reasoning and Problem Solving question because it requires reasoning backward from message architecture and product chemistry to identify the translating system through its discriminating initiation features.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B3 Q9 . peptidyl transfer intermediate state . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$peptidyl transfer intermediate state$q$,
    $q$During elongation, a bacterial ribosome holds a peptidyl-tRNA bearing a five-residue chain in its P site. An aminoacyl-tRNA is then delivered to the A site, and the peptidyl transferase reaction occurs, but translocation has not yet taken place. Which arrangement describes the two tRNAs at this moment?$q$,
    $q$[{"label":"A","text":"A deacylated tRNA sits in the E site, the six-residue peptidyl-tRNA occupies the P site, and the A site is empty"},{"label":"B","text":"The P-site tRNA holds a six-residue chain because the incoming amino acid was transferred onto the P-site peptide"},{"label":"C","text":"The A-site tRNA holds a six-residue chain, and the P-site tRNA carries no amino acid or peptide"},{"label":"D","text":"Both tRNAs remain attached to their original cargo until GTP hydrolysis drives peptide transfer and translocation together"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the state of the two ribosomal tRNA sites immediately after the peptidyl transferase reaction of the elongation cycle. The answer is C because peptidyl transfer moves the entire growing chain from the P-site tRNA onto the amino acid carried by the A-site tRNA, not the other way around. The free amino group of the A-site amino acid attacks the ester bond that links the five-residue peptide to the P-site tRNA, and the whole chain, now six residues long, becomes attached to the tRNA sitting in the A site. That leaves the P-site tRNA deacylated, holding neither an amino acid nor a peptide. Because translocation has not yet occurred, the ribosome has not advanced along the mRNA, the E site is unoccupied, and the new peptidyl-tRNA is still physically located in the A site; keeping the order of delivery, transfer, translocation, and exit straight is what the question rewards. (Choice A) This describes the ribosome after translocation. Once the ribosome ratchets one codon in the 3' direction, the six-residue peptidyl-tRNA shifts from the A site to the P site and the deacylated tRNA shifts to the E site, but the stem freezes the cycle before that step happens. (Choice B) This reverses the direction of transfer. The chain does not grow by pulling one amino acid onto a stationary P-site peptide; instead the entire peptide is handed onto the incoming amino acid, which is exactly why the growing chain changes tRNAs during every cycle of elongation. (Choice D) GTP hydrolysis is genuinely required during the cycle, but for aminoacyl-tRNA delivery and for translocation, not for peptide bond formation itself. The transfer reaction is powered by the high-energy ester bond linking the peptide to the P-site tRNA and is already complete at the moment described, so both tRNAs have exchanged cargo before any translocation-associated GTP is spent. This is a Scientific Reasoning and Problem Solving question because it requires working out the chemical cargo of each tRNA at a defined intermediate point in the elongation cycle rather than reciting the cycle from start to finish.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$one step ahead$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$transfer direction inverted$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true fact, wrong step$q$ FROM q;

-- B3 Q10 . stripped subunit ribozyme evidence . hard . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$stripped subunit ribozyme evidence$q$,
    $q$In a classic experiment, researchers subjected large ribosomal subunits to protease digestion and harsh extractions that removed more than 95 percent of the subunits' protein content. When the treated particles were supplied with appropriate substrates, they still catalyzed peptide bond formation at rates close to those of intact subunits. Which conclusion does this result best support?$q$,
    $q$[{"label":"A","text":"The small quantity of protein that survived the extraction constitutes the true peptidyl transferase"},{"label":"B","text":"Ribosomal proteins normally catalyze peptide bond formation, with the subunit's RNA serving only as a scaffold that positions them"},{"label":"C","text":"The catalytic activity that joins amino acids resides in the large subunit's rRNA, so the ribosome acts as a ribozyme"},{"label":"D","text":"Aminoacyl-tRNA synthetases co-purifying with the subunits supplied the bond-forming activity"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests interpretation of the classic evidence that peptidyl transferase, the activity that forms peptide bonds during translation, is carried out by RNA. The answer is C because an activity that persists after nearly all protein has been removed must reside in the component that remains, and what remains of a large ribosomal subunit after its proteins are stripped away is its rRNA. If any ribosomal protein were the catalyst, an extraction harsh enough to remove more than 95 percent of the protein would be expected to remove or unfold that catalyst and abolish activity, yet the treated particles formed peptide bonds at close to normal rates. The inference the data best support is therefore that the folded rRNA itself performs the chemistry, which makes the ribosome a ribozyme. Structural studies later reinforced this conclusion by showing that no protein side chain lies close enough to the peptidyl transferase center to participate in catalysis. (Choice A) A few percent of protein did survive, so this alternative sounds cautious, but it is the weaker inference: near-normal activity after depletion of almost all protein is hard to reconcile with a protein catalyst that should have been progressively lost, and the surviving proteins are peripheral rather than positioned at the catalytic center. (Choice B) This inverts the actual division of labor. The experiment shows catalysis surviving without the proteins, so the proteins cannot be the catalysts with RNA as mere scaffolding; if anything, the proteins play the supporting structural role while the RNA does the chemistry. (Choice D) Aminoacyl-tRNA synthetases do form a high-energy bond, but it is the ester bond attaching an amino acid to its tRNA during charging in the cytosol, a reaction that consumes ATP and is entirely distinct from peptide bond formation at the large subunit. This is a Reasoning about the Design and Execution of Research question because it asks which conclusion about the identity of the catalyst is supported by the outcome of a protein-stripping experiment on the large ribosomal subunit.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    3,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$residual-component alternative$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$role inversion$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$neighboring enzyme$q$ FROM q;

-- B3 Q11 . release factor water addition . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$release factor water addition$q$,
    $q$A translating ribosome advances until a UAA codon occupies its A site. Soon afterward, the completed polypeptide is found free in the cytosol with an intact carboxyl terminus, and the ribosomal subunits have separated from the mRNA. Which event most directly released the polypeptide?$q$,
    $q$[{"label":"A","text":"A tRNA with an anticodon complementary to UAA bound the A site and accepted the finished chain"},{"label":"B","text":"Translocation moved the peptidyl-tRNA into the E site, from which peptide-bearing tRNAs are expelled"},{"label":"C","text":"Dissociation of the large and small subunits pulled the chain free of the P-site tRNA"},{"label":"D","text":"A protein release factor occupied the A site and directed addition of water to the bond joining the chain to the P-site tRNA"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests the mechanism by which translation terminates and the finished protein is set free. The answer is D because no cellular tRNA recognizes a stop codon; instead a protein release factor binds the A site when UAA arrives there. The release factor redirects the chemistry of the peptidyl transferase center so that a water molecule, rather than the amino group of a new amino acid, attacks the ester bond connecting the completed chain to the P-site tRNA. Hydrolysis of that bond liberates the polypeptide with a normal free carboxyl terminus, exactly as observed in the stem, and only then do the ribosomal subunits dissociate from the mRNA and from each other so they can be recycled into new initiation complexes. (Choice A) This is the classic misconception that stop codons are decoded the way sense codons are. Stop codons have no complementary tRNAs; recognition is performed by a protein factor, and that substitution of a protein reader for a tRNA is precisely what distinguishes termination from another round of elongation. (Choice B) Translocation moves only deacylated tRNA into the E site, while a tRNA still carrying the chain is retained in the P site; no step of the cycle expels a peptide-bearing tRNA through the E site. The chain must first be cut free of its tRNA by hydrolysis before it can leave the ribosome. (Choice C) Subunit dissociation genuinely occurs at termination, but it follows release of the polypeptide and is a downstream consequence of the process, not the event that severs the covalent link between the chain and the P-site tRNA. This is a Scientific Reasoning and Problem Solving question because it requires identifying which molecular event in the termination sequence is directly responsible for the observed appearance of a free, completed polypeptide.$q$,
    'easy',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$stop codons read by tRNA$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$wrong exit route$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$real event, wrong cause$q$ FROM q;

-- B3 Q12 . elongation GTP cost counting . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$elongation GTP cost counting$q$,
    $q$In a bacterial translation system, delivery of each aminoacyl-tRNA to the A site consumes one GTP, and each translocation of the ribosome by one codon consumes one GTP. Initiation places the initiator tRNA directly into the P site without using either of these elongation steps. The system synthesizes a peptide exactly 51 residues long, and the final translocation that positions the stop codon in the A site is counted as part of elongation. Based only on these figures, how many GTP molecules are consumed by the elongation phase?$q$,
    $q$[{"label":"A","text":"51"},{"label":"B","text":"100"},{"label":"C","text":"102"},{"label":"D","text":"153"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests energy accounting across the elongation phase of translation using the per-step GTP costs supplied in the stem. The answer is B because a 51-residue peptide requires exactly 50 rounds of elongation. Initiation deposits the initiator tRNA, carrying residue 1, directly into the P site at no elongation cost, so only residues 2 through 51 must be delivered to the A site: 50 deliveries at one GTP each is 50 GTP. Every round also ends with one translocation, and the stem specifies that the final translocation bringing the stop codon into the A site is included, giving 50 translocations at one GTP each, another 50 GTP. The elongation total is therefore 50 plus 50, or 100 GTP, which is two GTP for every peptide bond formed. (Choice A) Counting one GTP per residue undercounts by half; each residue added during elongation costs two GTP, one for A-site delivery and one for translocation, while the first residue costs neither because it arrives during initiation. (Choice C) A total of 102 treats the initiator methionine as if it too were delivered to the A site and translocated by the elongation machinery, adding two GTP for a residue the stem explicitly says was placed during initiation without either elongation step. (Choice D) A total of 153 is three payments for each of the 51 residues, as if every residue, including the initiator, required a delivery, a translocation, and an amino acid activation payment; but tRNA charging is carried out by aminoacyl-tRNA synthetases using ATP before the ribosome ever engages the amino acid, and the stem restricts the count to the two GTP-consuming elongation steps it defines. This is a Data-based and Statistical Reasoning question because it requires applying supplied per-step GTP costs to compute the total energy consumed over all elongation cycles for a peptide of stated length.$q$,
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
  SELECT q.id, 'A', 'scale_unit_error', $q$wrong counting unit$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$initiation billed as elongation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$imported off-budget cost$q$ FROM q;

-- B3 Q13 . nascent transcript ribosome loading . medium . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$nascent transcript ribosome loading$q$,
    $q$Electron micrographs of Escherichia coli show RNA polymerase molecules moving along DNA with strings of ribosomes trailing behind each polymerase, already translating the growing RNA chains. Comparable micrographs of human cells never show ribosomes engaging transcripts that are still being synthesized. Which statement best explains this difference?$q$,
    $q$[{"label":"A","text":"Bacterial transcripts emerge directly into ribosome-containing cytosol and need no processing, whereas eukaryotic transcripts must be processed and exported across the nuclear envelope before ribosomes can reach them"},{"label":"B","text":"Bacterial ribosomes translate mRNA in the 3' to 5' direction, so they can begin at the transcript end closest to the advancing polymerase"},{"label":"C","text":"Eukaryotic RNA polymerases move so much faster than ribosomes that translating ribosomes can never keep pace with the growing transcript"},{"label":"D","text":"Bacterial mRNAs acquire a 5' cap while transcription is under way, and the cap recruits ribosomes onto the nascent chain"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests why transcription and translation can be coupled in prokaryotes but not in eukaryotes. The answer is A because a bacterial mRNA is synthesized directly into cytosol that already contains ribosomes, and the transcript is translatable exactly as it is made. RNA polymerase extrudes the 5' end of the message first, ribosomes initiate near the 5' end and read toward the 3' end, and both machines track in the same direction, so a ribosome can load onto the nascent chain and follow the polymerase while additional ribosomes queue behind it, producing the trailing strings seen in the micrographs. In eukaryotes the same arrangement is impossible because transcription occurs inside the nucleus, where no functional ribosomes operate, and the pre-mRNA must be processed and exported through the nuclear envelope before translation can begin; the envelope plus the processing requirement form a gate that separates the two processes in space and time. (Choice B) Translation proceeds 5' to 3' in bacteria just as it does everywhere else. This choice reverses the polarity, and the reversal would in fact make coupling impossible, because a reader that started from the 3' end could not begin until the transcript was complete. (Choice C) A speed mismatch cannot explain the complete absence of the arrangement in eukaryotic cells; the separation is architectural rather than kinetic, and the bacterial micrographs themselves show ribosomes keeping pace close behind the polymerase. (Choice D) Capping during transcription is a eukaryotic processing event; bacterial mRNAs carry no 5' cap at all, so a cap cannot be what recruits bacterial ribosomes onto a nascent transcript. This is a Data-based and Statistical Reasoning question because it requires inferring from a described microscopy observation which structural difference between the two cell types permits or forbids simultaneous transcription and translation.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$polarity flip$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$kinetic pseudo-explanation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$borrowed eukaryotic feature$q$ FROM q;

-- B3 Q14 . signal peptide deletion swap predictions . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$signal peptide deletion swap predictions$q$,
    $q$A secreted peptide hormone carries a hydrophobic stretch at its amino terminus that is bound by the signal recognition particle as the stretch emerges from the ribosome. Researchers express two engineered genes in cultured cells: construct 1 encodes the hormone with the amino terminal stretch deleted, and construct 2 encodes a normally cytosolic enzyme with that stretch fused to its amino terminus. Which pair of outcomes is predicted for the two engineered proteins?$q$,
    $q$[{"label":"A","text":"Both proteins are delivered to the endoplasmic reticulum, because the targeting information resides in the messenger RNA rather than in the polypeptide"},{"label":"B","text":"The construct 1 protein is delivered to the endoplasmic reticulum, while the construct 2 protein remains in the cytosol"},{"label":"C","text":"Both proteins remain in the cytosol, because the signal functions only within its original protein"},{"label":"D","text":"The construct 1 protein remains in the cytosol, while the construct 2 protein is delivered to the endoplasmic reticulum"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests the mechanism by which an amino terminal signal sequence commits a nascent protein to the endoplasmic reticulum. The answer is D because the signal peptide is both necessary and sufficient for endoplasmic reticulum targeting. As the hydrophobic amino terminal stretch emerges from the ribosome, the signal recognition particle binds it and escorts the entire ribosome to the endoplasmic reticulum membrane, where the rest of the chain is threaded across as translation continues. Deleting the stretch removes the only feature the particle recognizes, so construct 1 is completed by free ribosomes and remains in the cytosol. Grafting the stretch onto a normally cytosolic enzyme creates a new binding site for the particle, so construct 2 is captured during translation and delivered to the endoplasmic reticulum membrane. Together the two constructs test necessity and sufficiency, and both outcomes follow from a single recognition event acting on the polypeptide itself, not on any other cellular component. (Choice A) places the targeting information in the messenger RNA, but the particle reads the emerging protein segment, not the transcript. If the message carried the routing information, deleting a short peptide coding region while leaving the rest of the mRNA intact would not strand the protein in the cytosol, yet the deletion does exactly that. (Choice B) inverts both predictions. A protein stripped of the recognized segment cannot be captured by the particle, and a protein newly carrying it can, so this pairing reverses the causal logic of recognition. (Choice C) is half correct in that construct 1 does stay cytosolic, but it assumes the signal works only in its original protein context. Because the particle binds the hydrophobic segment itself rather than the whole hormone, the transplanted signal still functions on a foreign protein, which is precisely what makes it sufficient. This is a Data-based and Statistical Reasoning question because it asks you to predict the localization outcomes of a deletion construct and a fusion construct from the described recognition mechanism.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    4,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$routing information in the wrong molecule$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$flipped construct outcomes$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$necessity granted, sufficiency denied$q$ FROM q;

-- B3 Q15 . mature secreted protein shortening . medium . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$mature secreted protein shortening$q$,
    $q$A gene's open reading frame encodes a 424 amino acid polypeptide with a predicted mass of 47 kilodaltons. The protein that cells secrete into the culture medium migrates at 44 kilodaltons even after all attached carbohydrate is enzymatically removed before electrophoresis. Amino terminal sequencing shows that the secreted protein begins at residue 24 of the predicted sequence, and the predicted residues 1 through 23 form a mostly hydrophobic stretch. Which event best accounts for these observations?$q$,
    $q$[{"label":"A","text":"A peptidase removed an amino terminal segment as the protein was imported into the endoplasmic reticulum"},{"label":"B","text":"Ribosomes initiated translation at a start codon downstream of the first, so residues 1 through 23 were never made"},{"label":"C","text":"The enzymatic removal of carbohydrate also cut residues 1 through 23 from the polypeptide backbone"},{"label":"D","text":"The transcript lost the coding region for residues 1 through 23 during splicing of the precursor messenger RNA"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests signal peptide cleavage as a step in protein maturation. The answer is A because proteins that enter the secretory route are synthesized with a temporary amino terminal signal peptide that a peptidase clips off during import into the endoplasmic reticulum, so the gene predicts a longer polypeptide than the cell ever exports. Every observation matches that mechanism: the secreted protein is about 3 kilodaltons lighter than the open reading frame predicts even after carbohydrate removal, it begins at residue 24, and the missing residues 1 through 23 form a short hydrophobic stretch sized and composed like a typical signal peptide. Because the protein reached the culture medium, it must have carried a functional signal when it was synthesized, and because the mature form lacks those residues, the signal must have been removed after doing its job. Cleavage during import is the only event consistent with both the protein's route and its final composition. (Choice B) proposes initiation at a downstream start codon, which would also yield a shorter protein, but it fails a decisive test: a protein synthesized without its amino terminal signal would never have been recognized by the signal recognition particle, so it would have remained cytosolic instead of appearing in the medium. (Choice C) confuses two different chemistries. Enzymatic removal of carbohydrate breaks the bonds linking sugars to amino acid side chains; it does not excise a stretch of the polypeptide backbone, so deglycosylation cannot explain 23 missing residues. (Choice D) moves the explanation to the wrong level. Splicing removes introns from the precursor messenger RNA in the nucleus, but the message here must still have encoded residues 1 through 23, because the protein could not have entered the secretory route without first translating a signal peptide; the shortening happened to the protein, not to the transcript. This is a Data-based and Statistical Reasoning question because it asks you to reconcile a mass difference, amino terminal sequencing data, and the protein's secreted location with a single maturation event.$q$,
    'medium',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    4,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'adjacent_fact', $q$real mechanism, wrong evidence fit$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$conflating sugar removal with proteolysis$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong level of the pathway$q$ FROM q;

-- B3 Q16 . covalent sugar maturation mark . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$covalent sugar maturation mark$q$,
    $q$A protein purified from human plasma carries several oligosaccharide groups that remain attached through repeated washing, high salt, and boiling in detergent. A researcher concludes that the protein was deliberately secreted by cells rather than released into the blood by cell rupture. Which of the following statements are both accurate and supportive of this conclusion?

I. The sugar groups are joined to the protein by covalent bonds
II. Covalent sugar addition of this kind occurs on proteins passing through the secretory pathway
III. The sugar groups were attached by the ribosome during peptide bond formation$q$,
    $q$[{"label":"A","text":"II only"},{"label":"B","text":"III only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests glycosylation as a covalent maturation mark carried by proteins that pass through the secretory pathway. The answer is C because statements I and II are accurate and jointly support the conclusion, while statement III is false. Sugar groups that survive repeated washing, high salt, and boiling in detergent cannot be held on by weak surface adsorption; only covalent attachment resists such harsh treatment, so statement I is a sound inference from the purification behavior. Statement II then supplies the logical link: covalent sugar addition of this kind is performed on proteins as they mature through the secretory route, so the marks serve as a record of the path the protein took on its way out of the cell. A cytosolic protein spilled into the blood by cell rupture would never have acquired them, which is exactly why their presence argues for deliberate secretion. Statement III is false because the ribosome catalyzes peptide bond formation between amino acids and nothing else; sugars are attached to the polypeptide by separate modifying enzymes after the ribosome has done its work, so a claim crediting the ribosome cannot support any conclusion. (Choice A) keeps the pathway logic of statement II but discards statement I, yet the covalency inference is what rules out the trivial alternative that free sugars simply stuck to the protein during handling, so statement I is a necessary part of the support. (Choice B) selects the single statement that is wrong; attributing sugar attachment to the ribosome confuses translation itself with the maturation chemistry that follows it. (Choice D) includes the two supported statements but also credits statement III, and a body of support that contains a false mechanistic claim cannot stand as a whole. This is a Scientific Reasoning and Problem Solving question because it asks which combination of inferences about a covalent modification justifies a conclusion about how a plasma protein left the cell.$q$,
    'easy',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$incomplete support set$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$translation conflated with modification$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$overinclusive set with a false claim$q$ FROM q;

-- B3 Q17 . blocked prenyl anchor consequence . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$blocked prenyl anchor consequence$q$,
    $q$A signaling GTPase activates its downstream effectors only when held at the inner face of the plasma membrane by a covalently attached isoprenoid lipid near its carboxy terminus. Researchers treat cells with a drug that blocks the transferase that attaches this lipid, leaving the protein's synthesis and its GTP binding activity intact. Which outcome is most likely in the treated cells?$q$,
    $q$[{"label":"A","text":"The GTPase embeds directly in the bilayer through its polypeptide backbone, preserving effector activation"},{"label":"B","text":"The GTPase remains dispersed in the cytosol, and activation of its membrane effectors decreases"},{"label":"C","text":"The signal recognition particle redirects the GTPase to the endoplasmic reticulum for anchoring"},{"label":"D","text":"Effector activation increases because the unanchored GTPase diffuses through the cell more freely"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests prenylation, the covalent attachment of an isoprenoid lipid that anchors an otherwise soluble protein at a membrane surface. The answer is B because the lipid is the protein's only means of holding onto the membrane. The polypeptide itself is water soluble, so without the transferase reaction the newly made GTPase simply stays dissolved in the cytosol. Since effector activation requires the GTPase to be held at the inner face of the plasma membrane, an unanchored GTPase, however competent at binding GTP, is in the wrong place, and signaling through its effectors falls. The drug thus uncouples an intact catalytic protein from its site of action, which is the defining functional consequence of blocking a lipid anchor: the modification controls location, not catalysis, and losing it strands a working enzyme away from its partners. (Choice A) imagines the protein compensating by inserting its own backbone into the bilayer, but a soluble folded protein cannot spontaneously embed itself in a membrane; burying its polar surface in the hydrophobic interior would be energetically prohibitive, which is why the cell attaches a hydrophobic lipid to it instead. (Choice C) confuses two independent targeting systems. The signal recognition particle acts on amino terminal signal peptides as they emerge from the ribosome during translation; it plays no role in lipid attachment, and this cytosolic GTPase never enters that route, so blocking a transferase cannot hand the protein to that machinery. (Choice D) reverses the outcome. Freer diffusion does not help a protein whose effectors are confined to the membrane surface; concentrating the GTPase in two dimensions at the membrane is what makes encounters with its effectors efficient, so losing the anchor lowers rather than raises signaling. This is a Scientific Reasoning and Problem Solving question because it asks you to trace the functional consequence of removing a covalent lipid anchor from a membrane associated signaling protein.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$impossible compensation$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$wrong targeting machinery$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$flipped functional outcome$q$ FROM q;

-- B3 Q18 . chaperone dilution refolding interpretation . hard . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$chaperone dilution refolding interpretation$q$,
    $q$A purified enzyme is chemically denatured and then allowed to refold. When diluted to very low protein concentration, most molecules regain full activity on their own, but at tenfold higher concentration nearly all of the protein instead forms inactive aggregates. Adding a chaperone system plus ATP to the concentrated sample restores a high yield of active enzyme, and the recovered enzyme is identical in structure to the original. Which interpretation do these results best support?$q$,
    $q$[{"label":"A","text":"The chaperone supplies steric information that specifies the enzyme's native conformation"},{"label":"B","text":"The chaperone remains permanently bound to the refolded enzyme and is required to maintain its native structure"},{"label":"C","text":"The aggregate is the thermodynamically favored state, and the chaperone shifts the equilibrium toward an otherwise unstable native fold"},{"label":"D","text":"The chaperone transiently shields aggregation prone intermediates, raising the yield of the fold that the enzyme's own sequence encodes"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests how chaperones assist protein folding kinetically without supplying structural information. The answer is D because each condition in the experiment isolates one variable. At low concentration the denatured enzyme refolds correctly on its own, which proves that everything needed to specify the native structure is already encoded in the amino acid sequence. At high concentration the same molecules fail, not because that information is gone but because partly folded intermediates expose sticky hydrophobic patches and find each other faster than they finish folding; aggregation is a competing side reaction that wins when intermolecular collisions are frequent. The chaperone plus ATP rescues the concentrated sample by transiently shielding those intermediates, buying each molecule time to complete the fold its own sequence directs, and the product is structurally identical to the original protein. Chaperones therefore change the rate and yield of productive folding, not the destination. (Choice A) is the classic trap: if the chaperone supplied the steric information for the fold, the enzyme could not have refolded correctly in dilute solution without any chaperone present, so the low concentration control refutes this reading directly. (Choice B) overstates a real feature. Chaperones do bind folding intermediates, but the interaction is transient and ATP driven; the recovered enzyme here is active and identical to the original on its own, so no permanent partnership is required to maintain the structure. (Choice C) inverts kinetics and thermodynamics. The dilute control shows the native state forms and persists without help, so the aggregate is not a preferred equilibrium state the chaperone must overcome; it is a kinetic trap that dominates only when collisions between intermediates outpace folding. This is a Reasoning about the Design and Execution of Research question because it asks which mechanistic interpretation the dilution control and the chaperone rescue condition jointly support.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$chaperone as fold template$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$transient interaction made permanent$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$kinetic trap read as equilibrium$q$ FROM q;

COMMIT;

-- Verification: expect 54 questions and 162 distractor rows (batches 1-3).
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'RNA and the Genetic Code') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'RNA and the Genetic Code') AS distractor_rows;
