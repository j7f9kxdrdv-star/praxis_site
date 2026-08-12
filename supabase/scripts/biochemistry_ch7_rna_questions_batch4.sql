-- Biochemistry Chapter 7: RNA and the Genetic Code, standalone questions
-- BATCH 4 of 4 (18 questions), CHAPTER COMPLETE at 72: Unit G, prokaryotic regulation (operon
--   anatomy, the corrected polycistronic definition keyed with the source doc's garbled version
--   as distractor, lac induction logic and the constitutive operator mutant, trp corepressor
--   shutdown, cAMP/CAP positive control, the dual-sugar integration, control classification) .
--   Unit H, eukaryotic regulation at the machinery level (factor-element specificity, enhancer
--   distance and orientation independence, element classification, response elements in
--   non-hormone framing, gene amplification, small-RNA silencing).
--
-- PURE INSERTs: run AFTER batches 1-3. Boundary rules honoured: zero chromatin-mark, hormone, or
-- experimental-design-control keys (Bio Ch12, Bio Ch5, and the future Scientific Reasoning bank
-- own those); batch 2's basal-machinery keys are not re-keyed; the entire operon unit is the
-- bank's first coverage of gene regulation logic.

BEGIN;

-- B4 Q1 . promoter operator functional distinction . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$promoter operator functional distinction$q$,
    $q$A biosynthetic gene cluster in Escherichia coli is normally transcribed as a single unit and is shut off by a DNA-binding repressor protein. In a mutant strain from which the repressor gene has been completely deleted, transcripts from the cluster remain undetectable, although the strain's RNA polymerase initiates normally at other genes. Genome sequencing reveals a single base substitution just upstream of the cluster's transcription start site; which element did the substitution most likely disrupt?$q$,
    $q$[{"label":"A","text":"The operator for the cluster"},{"label":"B","text":"The Shine-Dalgarno sequence of the first gene in the cluster"},{"label":"C","text":"The intrinsic terminator downstream of the cluster"},{"label":"D","text":"The promoter for the cluster"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests the anatomy of a bacterial operon, specifically the functional distinction between the promoter, where RNA polymerase binds, and the operator, where the repressor binds. The answer is D because with the repressor gene deleted, only a defect in the polymerase binding element itself can explain a complete loss of transcripts. In an operon, the promoter lies upstream of the transcription start site and is the sequence RNA polymerase must recognize before it can initiate; the operator lies in the polymerase's path and works only as a landing site for repressor protein. Deleting the repressor gene removes the sole protein that acts through the operator, so no operator change, however drastic, can silence the cluster in this strain. Because the polymerase initiates normally at other genes, the enzyme itself is intact, and the block must reside in the cluster's own DNA. A base substitution that destroys polymerase recognition of the promoter abolishes initiation and therefore all downstream transcription, matching the observation of undetectable transcripts. (Choice A) The operator functions only when a repressor is present to occupy it; in a strain that makes no repressor protein at all, even an operator with greatly increased repressor affinity has nothing to bind, so an operator lesion cannot explain the silence. This choice conflates the repressor's binding element with the polymerase's binding element. (Choice B) The Shine-Dalgarno sequence is a ribosome binding site on the mRNA that acts during translation initiation; damaging it would yield a normal transcript that is poorly translated, not an absence of transcript, so the block observed here occurs before that element ever matters. (Choice C) An intrinsic terminator acts only after transcription has begun; mutating one typically causes readthrough past the normal endpoint rather than preventing initiation, so it cannot account for a total lack of transcript from the cluster. This is a Scientific Reasoning and Problem Solving question because it requires using the repressor deletion to eliminate operator based explanations and then deducing which operon element a mutation must strike to abolish transcription entirely.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$operator equals promoter conflation$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$transcription versus translation element$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$real element wrong phenotype$q$ FROM q;

-- B4 Q2 . polycistronic message multiple proteins . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$polycistronic message multiple proteins$q$,
    $q$Researchers purify a single intact mRNA species transcribed from a bacterial amino acid biosynthesis gene cluster and add it to a cell-free bacterial translation system. The system produces three enzymes of clearly different sizes, and each enzyme retains an N-terminal formylmethionine residue. Which feature of the purified transcript accounts for these results?$q$,
    $q$[{"label":"A","text":"Transcription of the cluster began at several different sites within the gene, producing overlapping messages"},{"label":"B","text":"The transcript carries three independent open reading frames, each with its own start and stop codons"},{"label":"C","text":"The transcript was spliced into three shorter isoforms before ribosomes engaged it"},{"label":"D","text":"Ribosomes read one long reading frame into a single polyprotein that proteases then cleaved into three enzymes"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests the definition and consequence of a polycistronic message, the hallmark transcript of a bacterial operon. The answer is B because one mRNA that carries three independent open reading frames can direct three separate rounds of initiation, elongation, and termination, yielding three distinct proteins from a single message. In bacteria, the genes of an operon are transcribed together into one continuous transcript, but each coding region within that transcript keeps its own start codon and its own stop codon. Ribosomes load at each reading frame independently, which is why every one of the three enzymes carries its own N-terminal formylmethionine, the residue that marks a fresh initiation event in bacterial translation. Three independent initiation events on one purified transcript can only mean three separate reading frames within it. (Choice A) Transcription initiating at several different sites within the cluster would generate a population of distinct, overlapping mRNAs, but the researchers purified a single intact mRNA species; this idea also mislocates the explanation in transcription when the observation concerns how one finished transcript is translated. It is a common garbled restatement of what polycistronic actually means. (Choice C) Splicing a transcript into multiple isoforms is carried out by spliceosomal machinery in the eukaryotic nucleus; bacteria lack that machinery, and a purified, intact transcript in a cell-free system undergoes no such processing before translation. (Choice D) A single long reading frame translated into one polyprotein and then cleaved would produce fragments of which only one, the original N-terminal piece, could retain the initiator formylmethionine; because all three enzymes carry it, each must arise from its own initiation event rather than from proteolysis, a strategy characteristic of certain viruses rather than of bacterial operons. This is a Knowledge of Scientific Concepts and Principles question because it asks which structural feature defines a polycistronic mRNA and how that feature yields several separately translated proteins from one message.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$calibrated erratum distractor$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$eukaryotic processing imported into bacteria$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$viral strategy transplant$q$ FROM q;

-- B4 Q3 . operon coordinate pathway control . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$operon coordinate pathway control$q$,
    $q$In a newly characterized soil bacterium, the three enzymes of an unusual sugar degradation pathway are synthesized together within minutes of the sugar's appearance, and synthesis of all three stops together when the sugar is exhausted. Deleting a short DNA segment lying between a single promoter and the first enzyme's coding sequence makes all three enzymes constitutively expressed, even though the cell still produces a DNA-binding regulatory protein that binds the free sugar normally. Which genomic arrangement accounts for these observations?$q$,
    $q$[{"label":"A","text":"The three genes are cotranscribed as one mRNA, and the deleted segment is the DNA site where the regulatory protein sits in the polymerase's path"},{"label":"B","text":"The three genes are scattered at separate chromosomal locations, each with its own promoter, and all are controlled by the same diffusible regulatory protein"},{"label":"C","text":"The deleted segment is the gene encoding the regulatory protein, so its removal lifts repression from all three enzymes at once"},{"label":"D","text":"The three genes are transcribed constantly at a fixed low level, and the sugar allosterically activates the preformed enzymes without any change in gene expression"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests why operon organization gives bacteria coordinate control of an entire pathway through a single cis-acting control point. The answer is A because only genes joined in one transcription unit under one operator-like site can all be switched on and off together by a single event at a single stretch of DNA. The synchronized appearance and disappearance of all three enzymes points to shared transcriptional control, and the deletion result localizes that control: the deleted segment lies between the promoter and the coding sequences, exactly where a repressor's site sits in the polymerase's path, and removing it derepresses all three enzymes at once. A cis-acting site can govern only the DNA to which it is physically attached, so one such site controlling three enzymes means the three genes are transcribed together as one polycistronic message. This arrangement is precisely the operon's advantage for bacteria: the cell manufactures the entire enzyme set of a pathway exactly when it is needed and shuts the whole set off with one regulatory decision at one control point. (Choice B) A shared diffusible repressor acting on three scattered genes could explain the coordinate timing, but each scattered gene would then need its own copy of the binding site; deleting the one segment described could derepress only the gene physically next to it, never all three. (Choice C) The stem states that the regulatory protein is still produced and still binds the sugar normally after the deletion, so the deleted segment cannot be the gene encoding that protein; this choice reverses the roles of the cis-acting DNA site and the trans-acting factor that binds it. (Choice D) Constant transcription with allosteric activation of preformed enzymes would change catalytic activity without changing synthesis, yet the stem describes synthesis of the enzymes starting and stopping together, and a purely post-translational activation mechanism cannot explain why deleting a DNA segment makes expression constitutive. This is a Scientific Reasoning and Problem Solving question because it requires reasoning backward from expression timing and a deletion phenotype to the genomic organization and single control point that make coordinate regulation of a whole pathway possible.$q$,
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
  SELECT q.id, 'B', 'partial_truth', $q$regulon versus operon$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$cis element versus trans factor$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$post-translational versus transcriptional control$q$ FROM q;

-- B4 Q4 . inducer double negative logic . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$inducer double negative logic$q$,
    $q$In E. coli growing in a glucose-poor medium without lactose, the lac structural genes are transcribed at only a trace level. When lactose becomes available, its metabolite allolactose accumulates and expression of these genes rises sharply, even though allolactose never contacts the operon's DNA. Which event most directly links allolactose accumulation to this rise in expression?$q$,
    $q$[{"label":"A","text":"Allolactose binds RNA polymerase directly and increases the enzyme's rate of initiation at the lac genes."},{"label":"B","text":"Allolactose binds the repressor protein and lowers its affinity for the operator, so the repressor vacates the site it was blocking."},{"label":"C","text":"Allolactose prevents translation of the repressor's message, so no new repressor protein is synthesized."},{"label":"D","text":"Allolactose binds the repressor protein and strengthens its hold on the operator."}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests the inducible logic of the lac operon, in which the inducer switches genes on by inactivating an inhibitor rather than by stimulating any part of the transcription machinery. The answer is B because allolactose binds the repressor protein and changes its shape, lowering the repressor's affinity for the operator; when the repressor releases the operator, the standing block on transcription disappears and RNA polymerase is free to transcribe the structural genes. The lac operon is off by default because the repressor sits on the operator, a DNA element positioned so that its occupancy prevents polymerase from moving into the structural genes. Induction is therefore a double negative: the inducer does not activate anything, it removes the molecule that was preventing expression. Because allolactose never contacts the DNA, the only way it can influence the operon is through a protein intermediate, and the repressor is that intermediate. This arrangement lets the operon respond to the presence of its own substrate: lactose appears, allolactose accumulates, repression is lost, and the enzymes for using lactose are made exactly when they are useful. (Choice A) Allolactose does not bind RNA polymerase, and induction of the lac operon is not accomplished by making the polymerase intrinsically better at initiation; the polymerase is already fully capable of transcribing the operon and is merely blocked from doing so. (Choice C) Interfering with translation of the repressor's message would eventually lower repressor levels, but this is the wrong regulatory step; induction acts on repressor protein that already exists, which is why expression can rise within minutes instead of waiting for old repressor to be diluted away by growth. (Choice D) This reverses the actual effect: an inducer that tightened the repressor's grip on the operator would lock the operon off, the opposite of the observed rise in expression. This is a Scientific Reasoning and Problem Solving question because it asks you to apply the double negative logic of an inducible operon to identify the single molecular event that converts inducer accumulation into new transcription.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$direct activation instead of derepression$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$wrong regulatory step (translation of repressor message vs allosteric release)$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$same binding partner, inverted effect$q$ FROM q;

-- B4 Q5 . constitutive operator mutant diagnosis . medium . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$constitutive operator mutant diagnosis$q$,
    $q$A mutant E. coli strain growing under glucose-poor conditions expresses the lac structural gene products at high levels whether or not lactose is present. Introducing a plasmid that directs abundant expression of wild type repressor protein fails to restore lactose dependent regulation in this strain. Which defect accounts for both observations?$q$,
    $q$[{"label":"A","text":"The repressor protein carries a change that prevents it from binding allolactose."},{"label":"B","text":"The repressor protein carries a change that prevents it from binding the operator."},{"label":"C","text":"The promoter carries a change that prevents RNA polymerase from recognizing it."},{"label":"D","text":"The operator sequence carries a change that prevents the repressor from occupying it."}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests interpretation of a constitutive phenotype in the lac operon, asking which regulatory element must be broken when expression is always on. The answer is D because an operator that repressor protein can no longer occupy leaves nothing to block transcription, so the structural genes are expressed at high levels regardless of lactose, and no amount of extra functional repressor can change that. The operator is a DNA site, so it acts only on the operon physically attached to it. Supplying wild type repressor from a plasmid cannot restore regulation, because that repressor has no intact site to sit on. This is the classic behavior of a cis acting element: it works only on the DNA molecule it belongs to, in contrast to the repressor, which diffuses through the cell and can act on any copy of the operator present. The failed rescue is therefore the deciding observation. Any defect residing in the repressor protein itself would be complemented by functional repressor supplied from the plasmid, while a defect in the DNA element cannot be. Constitutive expression plus failure of the plasmid rescue together force the conclusion that the operator itself is altered. (Choice A) A repressor that cannot bind allolactose would never receive the signal to let go of the operator, producing an operon that is permanently off rather than permanently on, the opposite of the observed phenotype. (Choice B) A repressor unable to bind the operator does explain constitutive expression, but it is a protein defect; the plasmid supplying abundant wild type repressor would then occupy the intact operator and restore lactose dependent regulation, which did not happen. (Choice C) A promoter change that prevents RNA polymerase from recognizing it would eliminate expression under all conditions rather than elevate it, so it cannot account for high level production of the gene products. This is a Reasoning about the Design and Execution of Research question because it asks you to combine a constitutive expression phenotype with the outcome of a plasmid complementation experiment to identify which regulatory component is defective.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$mutation predicting the opposite phenotype$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$explains half the evidence, fails the discriminator$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$real neighboring cis element, wrong consequence$q$ FROM q;

-- B4 Q6 . lactose absent state prediction . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$lactose absent state prediction$q$,
    $q$An E. coli culture is growing in a medium that lacks lactose. A student makes the following predictions about the lac operon in these cells:

I. The repressor protein occupies the operator.
II. The structural genes are being transcribed at a high rate.
III. Adding an inducer to the medium would lower the repressor's occupancy of the operator.

Which of the predictions will hold?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"I and III only"},{"label":"D","text":"II and III only"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests state prediction for the lac operon, asking you to work out repressor position, operator occupancy, and transcriptional output when lactose is absent. The answer is C because predictions I and III hold while prediction II does not. With no lactose in the medium, no allolactose is generated, so the repressor keeps its operator binding conformation and sits on the operator, making prediction I hold. An occupied operator blocks RNA polymerase from moving into the structural genes, so transcription stays near baseline rather than running at a high rate, and prediction II fails. Prediction III runs the logic one step forward: supplying an inducer would give the repressor a ligand, the ligand would shift the repressor to a shape with reduced affinity for the operator, and occupancy of the operator would fall, so prediction III holds. The operon is wired this way because the encoded proteins are useful only when their substrate is around; the default state is off, and a metabolite of the substrate itself is the release signal. (Choice A) This option accepts the bound repressor but stops there; the system's response to a future inducer is fully determined by the same logic, so prediction III must also be counted. (Choice B) This pairing is internally contradictory: if the repressor occupies the operator as prediction I states, the structural genes cannot simultaneously be transcribed at a high rate, so prediction II cannot accompany prediction I. (Choice D) This option inverts the default state, treating the operon as if it were on when lactose is absent; the lac operon is inducible and sits off by default, so prediction II fails even though prediction III holds. This is a Scientific Reasoning and Problem Solving question because it asks you to run the operon's regulatory logic through a stated condition and then extend it one predictive step beyond what the stem describes.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$correct state, incomplete projection$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$internally contradictory pairing$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$default state inverted$q$ FROM q;

-- B4 Q7 . uninducible repressor expression table . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$uninducible repressor expression table$q$,
    $q$Researchers measure beta-galactosidase activity as a readout of lac operon transcription in two E. coli strains cultured in glucose-poor medium; lactose uptake and its conversion to allolactose are verified to be normal in both. Strain 1 shows 2 activity units without lactose and 950 units with lactose. Strain 2 shows 2 units without lactose and 3 units with lactose. When the repressor gene is then deleted from strain 2, activity is roughly 900 units both with and without lactose. Which state of the strain 2 regulatory components do these data force?$q$,
    $q$[{"label":"A","text":"Its repressor remains bound to the operator even when allolactose is present."},{"label":"B","text":"Its operator has lost the ability to be occupied by the repressor."},{"label":"C","text":"Its promoter can no longer be used by RNA polymerase."},{"label":"D","text":"Its beta-galactosidase protein is produced but is catalytically inactive."}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests reading an expression table back to the molecular state of the lac operon's regulatory components. The answer is A because strain 2 stays near baseline even when lactose is supplied, yet expression is fully restored the moment the repressor gene is deleted; the only state consistent with both results is a repressor that stays parked on the operator despite the presence of allolactose. Work through what the data force. Strain 1 behaves as an inducible operon should, low without lactose and high with it. Strain 2 fails to induce, so something is still blocking transcription when inducer is present, and the stem rules out any shortage of intracellular allolactose. The deletion result identifies the block: removing the repressor alone sends activity to roughly the induced wild type level under both conditions, proving that the promoter, the structural genes, and the enzyme are all functional, and that the repressor was the component holding the operon off. A repressor that binds the operator normally but cannot respond to allolactose produces exactly this pattern, since it never receives the release signal. (Choice B) An operator unable to be occupied by the repressor predicts high activity in every strain 2 measurement, the reverse of the low values observed before the deletion. (Choice C) A promoter that polymerase cannot use fits the first two strain 2 measurements, but the discriminating result eliminates it: deleting the repressor could not restore roughly 900 units of activity if RNA polymerase had no usable promoter. (Choice D) An inactive enzyme confuses the transcriptional readout with protein function and is also excluded by the rescue, because full activity after repressor deletion shows the strain makes catalytically normal enzyme once transcription is allowed. This is a Data-based and Statistical Reasoning question because it asks you to identify the single molecular state compatible with every measurement in the table, including the deletion result that discriminates among otherwise defensible explanations.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$state predicting the opposite table$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$fits early rows, killed by the discriminator$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$post-translational step swapped for transcriptional control$q$ FROM q;

-- B4 Q8 . end product corepressor shutdown . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$end product corepressor shutdown$q$,
    $q$An E. coli culture growing in minimal medium synthesizes its own tryptophan using enzymes encoded by a single operon. When the culture is transferred to a medium supplying abundant tryptophan, transcription of the biosynthetic genes stops within minutes. Which event most directly accounts for the shutdown?$q$,
    $q$[{"label":"A","text":"Tryptophan binds RNA polymerase directly and blocks its progression along the operon."},{"label":"B","text":"The repressor protein binds the operator on its own once continued synthesis becomes unnecessary."},{"label":"C","text":"Tryptophan binds the repressor protein, shifting it into a conformation that occupies the operator."},{"label":"D","text":"cAMP levels fall, so an activator protein no longer stabilizes polymerase at the promoter."}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the repressible logic of the trp operon, in which the pathway's end product serves as a corepressor that switches off its own synthesis. The answer is C because the trp repressor is made in a form that cannot bind DNA by itself; only when tryptophan molecules bind the repressor does the protein shift into a shape that can occupy the operator and exclude RNA polymerase. The trp operon runs by default because the cell usually needs to manufacture this amino acid, and the biosynthetic enzymes are transcribed continuously from a single message. Abundant environmental tryptophan makes continued synthesis wasteful, and the cell reads abundance in the most direct way possible: the end product itself is the signal. Tryptophan molecules bind the free repressor, the activated complex settles onto the operator between the promoter and the structural genes, and polymerase can no longer initiate transcription. This end-product feedback guarantees that the assembly line shuts down at exactly the moment its output stops being needed. (Choice A) Tryptophan does not act on RNA polymerase itself. The regulatory decision is made at the operator through the repressor protein, and polymerase is excluded from initiating rather than stalled partway along the genes. Placing the block on the enzyme instead of the DNA control site mislocates the mechanism. (Choice B) The repressor cannot bind the operator alone. Framing the shutdown as the repressor somehow sensing that synthesis is unnecessary skips the obligatory step: the corepressor must first bind and reshape the protein. Without bound tryptophan the repressor stays off the DNA and transcription simply continues. (Choice D) Falling cAMP and the loss of activator binding describe catabolite control of sugar-utilization operons, a positive regulatory system that responds to glucose availability. The trp shutdown is a negative control event at its own operator and does not involve cAMP or an activator. This is a Scientific Reasoning and Problem Solving question because it asks you to predict which molecular event silences a biosynthetic operon when its end product suddenly becomes abundant.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B4 Q9 . novel operon control classification . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$novel operon control classification$q$,
    $q$In a newly characterized soil bacterium, the genes of operon Z are not transcribed under standard growth conditions. When compound J enters the cell, it binds regulatory protein R, and R then detaches from a DNA site located between the promoter and the structural genes. Transcription of operon Z begins shortly afterward. Which classification best fits the control of operon Z?$q$,
    $q$[{"label":"A","text":"A repressible operon under negative control"},{"label":"B","text":"An inducible operon under negative control"},{"label":"C","text":"An inducible operon under positive control"},{"label":"D","text":"A repressible operon under positive control"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests classification of prokaryotic operon control from observed behavior: the default transcriptional state plus the action of the small molecule define the category. The answer is B because the operon is silent until compound J appears, which makes it inducible, and the protein enforcing that silence does so by occupying DNA and blocking transcription, which makes the control negative. Two independent questions classify any operon. First, what is the default state: an operon that stays off until a signal turns it on is inducible, while one that runs until a signal turns it off is repressible. Second, what does the DNA-bound regulator do: a protein whose binding prevents transcription is a negative regulator, while one whose binding stimulates transcription is a positive regulator. Here protein R sits on a site between the promoter and the genes, transcription is off while R is bound, and expression begins only after J pulls R off the DNA. R is therefore a repressor, J is an inducer, and the system is inducible under negative control, the same logic that suits catabolic pathways that should run only when their substrate is actually available. (Choice A) A repressible operon is transcribed by default and shut off when its signal accumulates. Operon Z shows the opposite default, silence, so this label reverses the observed behavior on the first classification axis. (Choice C) Inducible is right, but positive control would require an activator whose DNA binding stimulates transcription. R does the opposite: its presence on the DNA silences the genes, and induction works by removing R, not by recruiting an activator to the promoter. (Choice D) This label misreads both axes at once, combining the wrong default state with the wrong regulator type. It can arise from assuming that any small molecule that switches genes on must be feeding a positive activator in a biosynthetic pathway, when the described mechanism is relief of repression. This is a Scientific Reasoning and Problem Solving question because it requires mapping a described pattern of regulatory behavior onto the correct control category rather than recalling a memorized example operon.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B4 Q10 . cAMP independent activator variant . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$cAMP independent activator variant$q$,
    $q$A mutant strain of E. coli produces a catabolite activator protein (CAP) variant that folds into its DNA-binding conformation even when no cAMP is bound. The mutant and a wild-type strain are each grown in medium containing both abundant glucose and lactose. How will lac operon transcription in the mutant compare with that in the wild type?$q$,
    $q$[{"label":"A","text":"It will be similar, because the lac repressor still determines operator occupancy regardless of CAP activity."},{"label":"B","text":"It will be lower, because the DNA-bound variant physically excludes RNA polymerase from the promoter region."},{"label":"C","text":"It will be similar, because cAMP must still accumulate before the variant can stimulate transcription."},{"label":"D","text":"It will be higher, because the variant stabilizes RNA polymerase binding at the promoter without requiring the starvation signal."}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests catabolite control: the inverse relationship between glucose and cAMP, and the role of cAMP-bound CAP as a positive regulator that boosts polymerase recruitment. The answer is D because the mutant CAP no longer needs cAMP to reach its active shape, so it occupies its site upstream of the polymerase-binding region and stimulates initiation even while abundant glucose keeps cAMP low. In wild-type cells grown on glucose plus lactose, allolactose releases the lac repressor from the operator, but transcription stays modest: high glucose suppresses cAMP accumulation, CAP remains in its inactive form, and polymerase binds the promoter only weakly. The mutation uncouples CAP from its signal, locking the protein in the DNA-binding form so the operon receives its activating input regardless of the sugar environment. With the repressor already off the operator in both strains, the mutant satisfies both requirements for strong expression and transcribes the operon above the wild-type rate. The mutation effectively deletes the glucose arm of the regulatory logic. (Choice A) The repressor does gate operator access, but lactose has already removed it in both strains under these conditions, so repressor status cannot distinguish mutant from wild type. The variable that differs between the strains is CAP activity, and CAP activity does change the transcription rate. (Choice B) CAP is an activator, not a repressor. Its binding site lies upstream of the polymerase-binding site, and occupancy stabilizes polymerase at the promoter rather than excluding it. Treating DNA-bound CAP as a roadblock converts positive control into its mirror image. (Choice C) This choice reinstates the very step the mutation bypasses. cAMP accumulation is normally the prerequisite for CAP activation, but a variant that folds into the active conformation without the nucleotide no longer waits for glucose to run out before stimulating the promoter. This is a Scientific Reasoning and Problem Solving question because it asks you to trace the transcriptional consequence of a regulatory protein that has been uncoupled from its normal activating signal.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

-- B4 Q11 . combined sugar expression prediction . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$combined sugar expression prediction$q$,
    $q$A laboratory grows three E. coli cultures in media that differ only in carbon source. Culture I receives lactose as its sole sugar. Culture II receives lactose together with abundant glucose. Culture III receives glycerol as its sole carbon source, with neither lactose nor glucose present. After one hour, beta-galactosidase levels are measured in each culture. In which culture(s) will beta-galactosidase be produced at a high level?

I. Culture I
II. Culture II
III. Culture III$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests the dual requirement for strong lac operon expression: the repressor must be off the operator and cAMP-bound CAP must be active at the promoter at the same time. The answer is A because only culture I satisfies both conditions: lactose removes the repressor while the absence of glucose raises cAMP so that CAP stimulates polymerase recruitment. Work through each culture with the two controls in hand. In culture I, allolactose derived from lactose binds the repressor and pulls it off the operator, and glucose scarcity lets cAMP accumulate; cAMP-bound CAP settles upstream of the polymerase-binding site, polymerase is recruited efficiently, and beta-galactosidase output is high. In culture II, the repressor is likewise removed, but abundant glucose keeps cAMP low, CAP stays inactive, and the operon is transcribed at only a low rate, well short of the high level asked for. In culture III, CAP is active because glucose is absent, but with no lactose in the medium the repressor remains bound to the operator and transcription is blocked. High output requires both signals simultaneously, an AND condition, and only culture I meets it. (Choice B) Selecting culture II alone treats glucose as the activating signal, reversing the inverse relationship between glucose and cAMP: abundant glucose lowers cAMP and idles CAP, so the preferred fuel suppresses rather than boosts the operon. (Choice C) Cultures I and II do share a lactose-freed operator, but escape from repression alone yields only weak transcription in culture II because the activating arm is missing; counting that low-level state as high expression ignores catabolite control entirely. (Choice D) Including culture III assumes the operon runs whenever the cell is short of preferred fuel, but with no lactose present the bound repressor keeps the genes off no matter how active CAP becomes, since an operon for lactose processing is useless without its substrate. This is a Data-based and Statistical Reasoning question because it requires combining two independent regulatory inputs across a set of described culture conditions to predict which condition yields high enzyme output.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B4 Q12 . activator cognate element specificity . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$activator cognate element specificity$q$,
    $q$In a fibroblast line, genes R and S are each transcribed at a low basal level, and each has an intact promoter that assembles the general transcription machinery normally. A 14 base sequence recognized by the activator protein VVX1 lies about 300 bases upstream of gene R but is absent from the region around gene S, and VVX1 cannot bind promoter sequences or RNA polymerase II on its own. When VVX1 is expressed at high levels in these cells, which transcription pattern is expected?$q$,
    $q$[{"label":"A","text":"Transcription of both genes rises, because a high concentration of activator stimulates the general machinery at every assembled promoter"},{"label":"B","text":"Transcription of gene S rises while gene R is silenced, because activators repress the genes whose upstream elements they occupy"},{"label":"C","text":"Transcription of gene R rises above its basal level while gene S stays at basal, because VVX1 acts only where its recognition sequence is present"},{"label":"D","text":"Neither gene changes, because a factor that cannot contact RNA polymerase II directly has no way to influence transcription"}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests the distinction between specific transcription factors and the basal machinery: activator proteins increase transcription of particular genes by binding their own DNA elements. The answer is C because VVX1 can act only through the 14 base sequence it recognizes, and that sequence lies upstream of gene R but not gene S. Every gene with a working promoter is transcribed at a low basal rate once the general machinery assembles. An activator raises transcription above that basal rate in a gene specific way: it first docks on its cognate sequence, and the DNA bound activator then makes stimulatory contacts with the proteins assembled at the promoter, often with the help of bending or bridging proteins. Gene R supplies the docking site, so its transcription climbs when VVX1 floods the cell. Gene S offers no docking site, so no amount of VVX1 can be recruited to it, and its transcription stays at the basal level set by the general machinery. (Choice A) reflects the misconception that an abundant activator behaves like a general transcription factor and boosts every active promoter. Cells contain hundreds of specific factors, each binding its own sequence motif, and they are not interchangeable with the basal machinery; without its recognition sequence near gene S, VVX1 has no way to act there, however plentiful it becomes. (Choice B) reverses the relationship twice. Activators stimulate rather than silence the genes whose elements they occupy, and they are inert at genes lacking the element, so gene R rises while gene S is simply unchanged rather than induced. (Choice D) begins from a true premise, since VVX1 indeed cannot bind the promoter or the polymerase directly, but the conclusion drawn from it is wrong. Activators do not need direct polymerase binding; once anchored to their sequence they change shape and work through contacts with the promoter bound machinery, which is exactly how gene R is stimulated. This is a Scientific Reasoning and Problem Solving question because it asks you to predict which of two genes responds to an overexpressed activator by applying the rule that specific factors act only through their own DNA elements.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B4 Q13 . enhancer position and orientation independence . hard . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$enhancer position and orientation independence$q$,
    $q$A 180 base DNA segment called E lies about 4,000 bases upstream of a gene encoding a liver enzyme. To characterize E, a researcher builds reporter constructs that all carry the same unaltered reporter promoter and measures the rate at which new reporter transcripts are synthesized. With E in its native upstream position and orientation, the synthesis rate is about 40 times that of an otherwise identical construct from which E has been removed. Flipping E to the opposite orientation in place gives about 38 times, and moving that flipped copy to a site 9,000 bases past the reporter's last exon gives about 36 times. Which conclusion do these constructs best support?$q$,
    $q$[{"label":"A","text":"E is an enhancer: proteins bound to it stimulate the promoter through bending of the intervening DNA, so its effect is largely independent of how far it sits from the start site and of which direction it faces"},{"label":"B","text":"E is a second promoter supplying an alternative start site, since a segment that keeps nearly full activity from a new location must be initiating transcription there itself"},{"label":"C","text":"E raises reporter output, but its activity from a position past the last exon shows that it acts on the finished transcript rather than on transcription"},{"label":"D","text":"E is a distal element that assembles the general transcription machinery by itself, which is why no fixed spacing from the start site is required"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests the experimental signature of an enhancer: stimulation that survives both inversion and relocation far from the gene. The answer is A because every construct carries the same reporter promoter, so the promoter cannot account for any difference among them, and the only variables are where segment E sits and which way it faces. Removing E drops synthesis to the baseline against which the other rates are measured, so E is responsible for the roughly 40 fold stimulation. Flipping E in place changes almost nothing, and carrying the flipped copy to a site 9,000 bases past the last exon still leaves about 36 times the baseline rate. Activation that ignores orientation and survives a shift of more than 13,000 bases is the defining behavior of an enhancer: the specific factors bound to it are brought to the promoter by bending of the intervening DNA, and such a loop can form whether the element lies ahead of the gene or behind it. (Choice B) treats E as a second promoter. A promoter sets the start site and works only from a fixed position and direction relative to it, so a segment that keeps nearly full activity after being inverted and moved past the last exon cannot be one; every construct still relies on the shared promoter it retains. (Choice C) accepts that E raises reporter output but misassigns the step at which it acts. The measured quantity is the rate at which new transcripts are made, a transcriptional readout rather than a measure of transcript survival, and folding of the DNA lets an element positioned past the last exon reach the promoter while transcription is being initiated. (Choice D) starts from the true observation that E works from many positions but explains it with the wrong mechanism. An enhancer is a binding site for specific activator proteins, and the general machinery still assembles at the promoter; the activators bound at E act by contacting that promoter bound machinery, which is why a promoter is required in every construct. This is a Reasoning about the Design and Execution of Research question because it asks you to interpret a set of constructs that vary only the position and orientation of one segment and decide which class of control element the resulting pattern of activity identifies.$q$,
    'hard',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    3,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B4 Q14 . repressor bound distant element identification . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$repressor bound distant element identification$q$,
    $q$In a cell line that expresses protein Q, a particular gene is transcribed at a low rate, and protein Q binds a 20 base sequence located 2,000 bases upstream of that gene. When the 20 base sequence is deleted from the genome, the gene's transcription rate in this cell line rises about eightfold. In a related cell line that makes no protein Q, the same gene is already transcribed at the high rate, and the deletion changes nothing. Which classification of the 20 base sequence is most consistent with these findings?$q$,
    $q$[{"label":"A","text":"An enhancer, since sequences thousands of bases from a gene raise its transcription when proteins bind them"},{"label":"B","text":"Part of the gene's promoter, since removing promoter sequence frees the general machinery to initiate more often"},{"label":"C","text":"A sequence carried in the mature mRNA that shortens the transcript's lifetime whenever protein Q is present"},{"label":"D","text":"A silencer whose bound repressor blocks transcription, so removing it leaves the gene transcribed at its unrepressed rate"}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests the two classes of distant control element: enhancers bind activator proteins and raise transcription of their gene, while silencers bind repressor proteins and lower it. The answer is D because deleting the sequence raises transcription, and it does so only in the cell line that contains protein Q. Eukaryotic repressor proteins bind control sequences that may sit far from the promoter and block transcription of the associated gene, with folding of the intervening DNA bringing the distant site close to the promoter region. While protein Q occupies the 20 base sequence, the gene is held at a low rate; deleting the sequence leaves protein Q nowhere to bind, so transcription climbs to the unrepressed rate, which is the rate the gene shows all along in cells that never make protein Q. The absence of any effect in those cells fits the same picture, since an unoccupied repressor site was not restraining anything. (Choice A) names the opposite class of element. Activators bound to an enhancer raise transcription of their gene, so deleting an enhancer would lower the rate rather than raise it eightfold. (Choice B) misplaces the promoter. The promoter is the region immediately upstream of the coding sequence where the general machinery assembles at the start site, not a 20 base stretch 2,000 bases away, and losing promoter sequence reduces correctly initiated transcription instead of increasing it. (Choice C) shifts to the wrong level of control. A sequence 2,000 bases upstream of the gene is never copied into the message, so it cannot sit within the mRNA as a stability element, and the quantity that changed after the deletion was the transcription rate itself. This is a Knowledge of Scientific Concepts and Principles question because it asks you to classify an upstream control sequence from the protein that binds it and the direction of the change produced by deleting it.$q$,
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
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

-- B4 Q15 . shared response element transferred to a new gene . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$shared response element transferred to a new gene$q$,
    $q$When cultured human cells are shifted from 37 to 42 degrees Celsius, a normally inactive cytoplasmic protein rapidly acquires the ability to bind DNA and moves into the nucleus, and transcription of five chaperone genes located on four different chromosomes rises sharply and in unison. Each of the five genes carries a nearly identical 12 base sequence a few hundred bases upstream of its start site, and genes whose transcription does not change lack that sequence. A researcher then inserts a single copy of the 12 base sequence 200 bases upstream of a reporter gene that these cells normally transcribe at a low rate that does not vary with temperature. What is the most likely behavior of the reporter after the temperature shift?$q$,
    $q$[{"label":"A","text":"Its transcription stays low, because coordinated induction requires the responding genes to sit together at a single chromosomal locus"},{"label":"B","text":"Its transcription rises with the shift, because the inserted sequence gives the newly activated protein a binding site from which it can stimulate the reporter's promoter"},{"label":"C","text":"Its transcription rises at 37 degrees Celsius as well as at 42, because a sequence of this kind raises initiation whether or not the protein that recognizes it is active"},{"label":"D","text":"Its transcription is unchanged, but its mRNA becomes longer lived at 42 degrees Celsius, because upstream sequences of this kind act after the transcript is made"}]$q$::jsonb,
    'B',
    $q$This Gene Expression question tests how a single signal switches on a whole battery of genes: each responding gene carries its own copy of the same short recognition sequence, and one activated factor binds every copy. The answer is B because the reporter now carries that recognition sequence in the position such control sequences occupy, so the protein that the temperature shift activates has somewhere to dock upstream of the reporter and can stimulate the machinery at the reporter's promoter. The original observations point that way: the shift converts an inactive cytoplasmic protein into a nuclear DNA binding protein, the five induced genes share a sequence, and unresponsive genes lack it. A factor recognizes its particular sequence motif wherever that motif occurs, so supplying the motif to a new gene should hand that gene the same responsiveness, which is exactly why induction was simultaneous across genes scattered over four chromosomes. (Choice A) supposes that coordination requires physical clustering. The five natural targets already lie on four different chromosomes, so proximity is plainly not what synchronizes them; the shared sequence is, and one copy placed upstream of the reporter is enough to enroll it. (Choice C) treats the sequence itself as intrinsically stimulating. A recognition sequence does nothing until its factor is present in a form able to bind DNA, and at 37 degrees Celsius that protein sits inactive in the cytoplasm, so the reporter should stay at its low rate until the temperature rises. (Choice D) moves the effect to the wrong step. The inserted sequence lies upstream of the reporter rather than within the transcribed region, and sequences of this kind are protein binding sites that set how often transcription is initiated, not features of the finished message that determine how long it survives. This is a Scientific Reasoning and Problem Solving question because it asks you to infer the mechanism behind a coordinated induction and then predict what happens when the shared sequence is transferred to an unrelated gene.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B4 Q16 . copy number output scaling . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$copy number output scaling$q$,
    $q$A tumor derived cell line carries approximately 20 genomic copies of a growth factor receptor gene, whereas normal cells from the same tissue carry 2 copies. Nuclear run-on assays show that each individual gene copy is transcribed at the same rate in both cell lines. The tumor line contains about ten times more receptor mRNA than the normal cells. Which conclusion do these observations support?$q$,
    $q$[{"label":"A","text":"Each gene copy in the tumor line is transcribed about ten times faster than a copy in normal cells."},{"label":"B","text":"The tumor line degrades receptor mRNA more slowly, which accounts for the elevated transcript level."},{"label":"C","text":"The elevated transcript level results from an increased number of transcribed templates, with each copy behaving like a normal copy."},{"label":"D","text":"Because the tumor line carries 20 copies, its mRNA should be twentyfold elevated, so about half of the copies must be transcriptionally silenced."}]$q$::jsonb,
    'C',
    $q$This Gene Expression question tests gene amplification, the strategy of increasing a gene's total output by raising its copy number while leaving the behavior of each individual copy unchanged. The answer is C because the data show output scaling with template number: the tumor line carries 20 copies where normal cells carry 2, a tenfold difference, and the run-on assay shows that every copy is transcribed at an identical per copy rate in both lines. When each template works at the same rate, total transcript production is simply the per copy rate multiplied by the number of copies. A tenfold increase in copy number therefore predicts exactly the tenfold increase in receptor mRNA that was measured, so no change in promoter strength, transcript stability, or silencing needs to be invoked. This is the defining logic of amplification: the cell multiplies identical templates, and the output multiplies with them, a mechanism that lets some cells boost a single product enormously without altering any regulatory sequence. (Choice A) A tenfold faster per copy rate is directly contradicted by the run-on data, which show equal transcription rates per copy in the two lines; this choice assigns the increase to the wrong variable, per copy activity instead of template number. (Choice B) Slower mRNA degradation is a real regulatory mechanism, but it is neither needed nor supported here: the copy number difference already accounts quantitatively for the entire tenfold change, and an added stability effect would push the transcript level above tenfold rather than matching it. (Choice D) This choice confuses the absolute copy count with the fold change. The tumor line has 20 copies and normal cells have 2, so the expected elevation is 20 divided by 2, or tenfold, exactly as observed; no silencing of half the copies is required to explain the data. This is a Data-based and Statistical Reasoning question because it asks you to combine measured copy numbers, per copy transcription rates, and total mRNA levels into a single quantitative conclusion about how the elevated output arose.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$wrong-variable attribution$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$real mechanism, wrong experiment$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$ratio versus absolute count error$q$ FROM q;

-- B4 Q17 . small RNA target fate . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$small RNA target fate$q$,
    $q$A mammalian cell produces a 22 nucleotide RNA that is complementary to a sequence within the mRNA encoding enzyme E. The small RNA assembles with a cytoplasmic protein complex and then guides that complex to the enzyme E mRNA. Which of the following outcomes for the enzyme E message are consistent with this interaction?

I. Translation of the enzyme E mRNA is inhibited.

II. The enzyme E mRNA is cleaved and degraded.

III. RNA polymerase II is blocked from initiating transcription at the enzyme E promoter.$q$,
    $q$[{"label":"A","text":"I and II only"},{"label":"B","text":"I and III only"},{"label":"C","text":"II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'A',
    $q$This Gene Expression question tests small RNA silencing at the level of target recognition, specifically what happens to an mRNA once a complementary small RNA guides a silencing complex to it. The answer is A because statements I and II describe the two established fates of a message targeted by a small RNA loaded silencing complex, while statement III places the effect at the wrong step. Statement I is consistent: when the guide RNA pairs with its target, the associated protein complex can block ribosomes from productively translating the message, so enzyme E synthesis falls even while the mRNA persists. Statement II is also consistent: with strong pairing, the complex cleaves the target, and the fragments are then destroyed by cellular nucleases, removing the message entirely. Either route silences the gene post transcriptionally, meaning the message is intercepted after it has already been made. Statement III is not consistent because the described complex acts on the mRNA in the cytoplasm, not on the gene; RNA polymerase II continues to initiate at the promoter, and transcription of the gene proceeds normally. (Choice B) This pairing keeps the true translational block but adds the false promoter effect, confusing silencing of the transcript with repression of transcription, which occurs at a different step and uses different machinery. (Choice C) Degradation alone is too narrow; translational inhibition without cleavage is an equally valid outcome of this interaction, so excluding statement I discards a correct consequence of the pairing. (Choice D) Including all three statements treats the small RNA as if it also shuts down the gene at its promoter, but small RNA silencing leaves transcription initiation intact and exerts its effect on the message itself. This is a Scientific Reasoning and Problem Solving question because it asks you to reason from a described RNA and protein interaction to the set of downstream fates that the interaction can and cannot produce.$q$,
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
  SELECT q.id, 'B', 'process_step_confusion', $q$wrong step in expression pathway$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$incomplete outcome set$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$silencing equals gene shutdown$q$ FROM q;

-- B4 Q18 . siRNA knockdown readout . easy . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'RNA and the Genetic Code',
    $q$siRNA knockdown readout$q$,
    $q$A researcher suspects that protein Q drives the migration of a cultured cell line. She transfects the cells with a short double stranded RNA whose guide strand is complementary to a sequence in the mRNA encoding protein Q. Which observation would confirm that this treatment silenced its intended target?$q$,
    $q$[{"label":"A","text":"Protein Q accumulates because the small RNA shields its mRNA from ribonucleases."},{"label":"B","text":"The chromosomal gene encoding protein Q is excised from the genome of treated cells."},{"label":"C","text":"Protein Q is ubiquitinated and degraded more rapidly by the proteasome in treated cells."},{"label":"D","text":"Protein Q levels fall in treated cells even though the DNA sequence of its gene is unchanged."}]$q$::jsonb,
    'D',
    $q$This Gene Expression question tests the interpretation of an siRNA knockdown experiment, in which a small double stranded RNA silences one transcript without touching the gene that encodes it. The answer is D because the signature of successful knockdown is a drop in the targeted protein while the genome remains unaltered. The introduced RNA is unwound, and its guide strand directs a silencing complex to the complementary mRNA, which is then cleaved or blocked from translation. Less message is available to ribosomes, so protein Q levels fall over subsequent hours to days as the existing protein turns over. Because the intervention never contacts the DNA, the chromosomal gene encoding Q stays intact, and the effect fades once the small RNA is diluted or degraded. A parallel drop in the targeted mRNA, measured directly, would strengthen the same conclusion, since the transcript is the molecule the small RNA actually engages. Observing reduced protein Q alongside an unchanged gene therefore demonstrates that silencing occurred at the RNA level, which is exactly what this loss of function design is meant to accomplish before any conclusion about migration can be drawn. (Choice A) This reverses the effect: pairing of the guide strand with the message recruits a nuclease containing complex, so the mRNA is destroyed or muted rather than protected, and protein Q falls rather than accumulates. (Choice B) Excision of the chromosomal gene describes a knockout, a genome level manipulation; siRNA transfection acts only on RNA and cannot remove or rewrite a gene. (Choice C) Faster proteasomal destruction of protein Q is a genuine cellular route for lowering a protein, but it is not how siRNA works; knockdown reduces synthesis of new protein by removing its template rather than accelerating degradation of protein already made. This is a Reasoning about the Design and Execution of Research question because it asks which molecular readout confirms that an introduced siRNA silenced its intended transcript rather than altering the gene itself.$q$,
    'easy',
    '1B',
    $q$Gene Expression$q$,
    'biochemistry',
    3,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$inverted consequence$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$knockdown versus knockout$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$real mechanism, wrong pathway$q$ FROM q;

COMMIT;

-- Verification: expect 72 questions, 216 distractor rows, and letters 18/18/18/18.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'RNA and the Genetic Code') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'RNA and the Genetic Code') AS distractor_rows;

SELECT correct_answer, COUNT(*) FROM public.questions
WHERE topic = 'RNA and the Genetic Code' GROUP BY correct_answer ORDER BY correct_answer;
