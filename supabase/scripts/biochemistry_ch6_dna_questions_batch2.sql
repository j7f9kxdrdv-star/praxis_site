-- Biochemistry Chapter 6: DNA and Biotechnology, standalone questions
-- BATCH 2 of 3 (24 questions): Unit 3, replication (Meselson-Stahl and origins, the fork-opening
--   enzymes, primase and directionality, leading/lagging and Okazaki fragments, finishing, the
--   sliding clamp, telomerase enzymology) + replication-coupled repair (proofreading, mismatch
--   repair with methyl-directed strand discrimination).
--
-- PURE INSERTs: run AFTER biochemistry_ch6_dna_questions.sql (batch 1 owns the chapter DELETE).
-- Boundary rules honoured: telomerase keyed as enzymology only (no end-replication problem, no
-- shortening, Bio Ch3 owns those); Greek-letter polymerase table appears only in distractors;
-- zero cancer keys; no mutation-type-classification keys.
-- Q5 was replaced pre-ship: the drafted helicase item duplicated batch 1's noncovalent-repairing
-- key; the replacement keys the functional consequence of helicase loss instead.

BEGIN;

-- B2 Q1 . first generation hybrid band interpretation . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$first generation hybrid band interpretation$q$,
    $q$Escherichia coli cells were grown for many generations in medium containing only heavy nitrogen and were then transferred to medium containing only light nitrogen. After exactly one generation of growth in the light medium, DNA extracted from the culture formed a single band in a cesium chloride gradient, positioned midway between the positions of fully heavy and fully light DNA. Which conclusion is supported by this result alone?$q$,
    $q$[{"label":"A","text":"Replication is semiconservative, because each daughter duplex must contain one parental strand and one newly synthesized strand"},{"label":"B","text":"Replication is conservative, because the parental duplex remained intact and produced the observed hybrid band"},{"label":"C","text":"Replication is dispersive, because the intermediate density shows that old and new DNA segments are interspersed within each strand"},{"label":"D","text":"The conservative model is excluded, but the semiconservative and dispersive models cannot yet be distinguished"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests interpretation of equilibrium density gradient data from the Meselson and Stahl experiment, specifically what one generation of growth in light medium can and cannot establish about the mode of DNA replication. The answer is D because a single band at intermediate density after one generation rules out only the conservative model while leaving two models in play. Conservative replication predicts that the original duplex remains entirely heavy and templates a completely new light duplex, so after one generation the gradient should show two bands, one fully heavy and one fully light, and an intermediate band should never appear in any generation. Semiconservative replication predicts hybrid duplexes containing one heavy parental strand paired with one light new strand, and such molecules band at exactly intermediate density. Dispersive replication predicts daughter molecules in which short old and new segments are interspersed along both strands, giving about fifty percent parental content after one round, and these molecules also band at intermediate density. Two of the three models therefore make identical first generation predictions, and only a second generation separates them: semiconservative replication yields two bands, one intermediate and one fully light, whereas dispersive replication yields a single band that drifts progressively lighter with each generation. (Choice A) Semiconservative replication is the model ultimately shown to be correct, but this conclusion is not supported by the first generation result alone, because dispersive replication predicts the identical single intermediate band. (Choice B) This reverses the conservative prediction: conservative replication requires the parental duplex to stay fully heavy, so the absence of any fully heavy band contradicts the model rather than supporting it. (Choice C) Buoyant density reports the average parental content of an entire molecule; it cannot reveal whether old material is interspersed within each strand or confined to one intact strand, so interspersion is not demonstrated by an intermediate band. This is a Data-based and Statistical Reasoning question because it requires translating a centrifugation banding pattern into which replication models the observation excludes and which remain viable.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    4,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$true conclusion, unsupported by this data slice$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$prediction inverted into support$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$overreads what the measurement can show$q$ FROM q;

-- B2 Q2 . density label design discrimination . medium . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$density label design discrimination$q$,
    $q$To distinguish among the semiconservative, conservative, and dispersive models of replication, Meselson and Stahl grew Escherichia coli in heavy nitrogen medium for many generations, shifted the culture to light nitrogen medium, and analyzed the DNA of successive generations by equilibrium centrifugation in a cesium chloride gradient. A colleague suggests that simply tracking incorporation of a radioactive precursor into newly made DNA would have been an easier experiment. Why does the density label succeed where a tracer of new synthesis alone would fail to discriminate among the three models?$q$,
    $q$[{"label":"A","text":"Each model predicts a different distribution of parental material within individual daughter molecules, and buoyant density reads out that distribution as a distinct band pattern across generations"},{"label":"B","text":"A radioactive tracer would damage the DNA and thereby alter the replication mechanism under study"},{"label":"C","text":"The heavy isotope arrests each chromosome after exactly one round of replication, allowing the generations to be sampled separately"},{"label":"D","text":"Equilibrium centrifugation separates and counts individual parental and daughter strands after the duplexes are denatured in the gradient"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question examines the design logic of the Meselson and Stahl experiment, focusing on why a density label combined with equilibrium centrifugation could discriminate among three competing replication models. The answer is A because the models differ precisely in how parental material is partitioned among daughter molecules, and buoyant density is a direct readout of the fraction of heavy parental nitrogen contained within each individual duplex. Conservative replication predicts an intact fully heavy parental duplex alongside fully light new duplexes; semiconservative replication predicts hybrid duplexes that are exactly half heavy; dispersive replication predicts molecules whose heavy content is diluted a little further with every generation. Because each prediction corresponds to a unique band position and a unique pattern of change over successive generations, one analytical method can test all three hypotheses at once. A tracer that only marked new synthesis would confirm that new DNA is being made, but it could not reveal whether the old material stays together in one duplex, pairs intact with one new strand, or scatters in pieces through both strands, which is exactly the point of disagreement among the models. (Choice B) Radioisotopes can damage DNA at high doses, but this practical concern is not why a density label discriminates among models; even a completely harmless tracer of new synthesis would still fail to report how parental material is distributed within daughter molecules. (Choice C) Nothing about the heavy isotope arrests replication; generation by generation resolution was achieved by harvesting cells at timed intervals after the shift to light medium, not by any property of the label. (Choice D) The analysis was performed on native double stranded DNA, and each band position reflects the density of a whole duplex; the experiment did not denature the DNA or count individual strands, so this misstates the measurement itself. This is a Reasoning about the Design and Execution of Research question because it asks why the chosen labeling and measurement strategy was capable of distinguishing among competing mechanistic hypotheses about the fate of parental DNA.$q$,
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
  SELECT q.id, 'B', 'adjacent_fact', $q$true fact from a neighboring topic, wrong causal role$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$false mechanism assigned to the tool$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$invented procedural step$q$ FROM q;

-- B2 Q3 . multiple origins replication time . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$multiple origins replication time$q$,
    $q$A linear eukaryotic chromosome contains 8.0 x 10^7 base pairs. At the start of replication, 200 evenly spaced origins fire simultaneously, and every replication fork moves at 50 base pairs per second. Approximately how long will complete replication of this chromosome take?$q$,
    $q$[{"label":"A","text":"2.0 x 10^3 seconds"},{"label":"B","text":"4.0 x 10^3 seconds"},{"label":"C","text":"8.0 x 10^3 seconds"},{"label":"D","text":"8.0 x 10^5 seconds"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests quantitative reasoning about multiple origins of replication on a linear eukaryotic chromosome, where each fired origin opens a replication bubble containing two forks that move in opposite directions. The answer is B because the replication workload is divided first among the origins and then between the two forks of each bubble. With 200 evenly spaced origins on 8.0 x 10^7 base pairs, each origin is responsible for 8.0 x 10^7 divided by 200, which is 4.0 x 10^5 base pairs. Each bubble expands bidirectionally, so its two forks split that segment and each fork copies 2.0 x 10^5 base pairs. At 50 base pairs per second, the time required is 2.0 x 10^5 divided by 50, which is 4.0 x 10^3 seconds, a little over one hour. This arithmetic also captures why eukaryotes finish replicating genomes far larger than bacterial genomes in comparable time despite slower forks: firing many origins in parallel multiplies the number of simultaneously active forks, so total synthesis capacity scales with origin number rather than with the speed of any single fork. (Choice A) 2.0 x 10^3 seconds results from dividing each origin's segment among four forks; a replication bubble contains exactly two forks, one at each edge of the bubble, not two forks per edge or one per template strand. (Choice C) 8.0 x 10^3 seconds results from assigning only one fork to each origin; replication from an origin is bidirectional, so ignoring the second fork doubles the apparent time. (Choice D) 8.0 x 10^5 seconds is the answer for a chromosome served by a single origin with two forks, which is the typical prokaryotic arrangement on a circular chromosome; the stem specifies 200 origins firing on a eukaryotic chromosome, so this ignores the given origin number entirely. This is a Data-based and Statistical Reasoning question because it requires computing total replication time from genome size, origin number, the two forks per bubble, and fork velocity.$q$,
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
  SELECT q.id, 'A', 'scale_unit_error', $q$extra factor of two from fork double counting$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$skipped bidirectionality step$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$wrong domain rule imported$q$ FROM q;

-- B2 Q4 . origin sequence specificity bubble pattern . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$origin sequence specificity bubble pattern$q$,
    $q$Electron micrographs of replicating Escherichia coli chromosomes were collected at successive times after the start of replication. In every cell, a single replication bubble first appears at the same chromosomal position and then expands progressively within the circular molecule, and no chromosome ever shows more than one bubble. Which statement about the initiation of bacterial replication best accounts for these observations?$q$,
    $q$[{"label":"A","text":"Replication initiates at hundreds of origins spaced around the circle, as it does on a eukaryotic chromosome"},{"label":"B","text":"Helicase opens the initiation site by cleaving phosphodiester bonds in the sugar phosphate backbone"},{"label":"C","text":"Replication begins at one specific origin sequence on the chromosome that initiator proteins recognize"},{"label":"D","text":"Initiation can occur at any AT rich stretch, so the bubble position varies randomly from chromosome to chromosome"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests how initiation at an origin of replication determines the pattern of replication bubbles observed on a prokaryotic chromosome. The answer is C because Escherichia coli, like most prokaryotes, initiates replication at a single origin on its one circular chromosome. The origin is a specific nucleotide sequence, approximately 245 base pairs long and rich in AT pairs, and initiator proteins recognize and bind this site before helicase unwinds the duplex there. Because initiation is restricted to one defined sequence, every replicating chromosome opens exactly one bubble, and that bubble always appears at the same chromosomal position before expanding until the molecule is fully copied. A single sequence specific origin therefore accounts for both observations at once, the constant location of the bubble and the fact that no chromosome ever carries more than one. (Choice A) Initiation at hundreds of origins describes a eukaryotic chromosome; if a bacterial chromosome initiated at many sites, micrographs taken soon after the start of replication would capture numerous small bubbles on each molecule, which is never observed. (Choice B) Helicase opens the origin by breaking the hydrogen bonds between paired nitrogenous bases, not by cleaving phosphodiester bonds in the backbone; cleaving the backbone would fragment the chromosome rather than create a bubble, and this claim offers no reason for the bubble to appear at one fixed position. (Choice D) The origin is indeed rich in AT sequences, but initiation requires a particular sequence recognized by initiator proteins rather than any AT rich stretch; if arbitrary AT rich sites could serve, the bubble would appear at different positions in different cells instead of at one constant location. This is a Scientific Reasoning and Problem Solving question because it requires linking the single count and constant position of the observed bubble to sequence specific initiation at one origin rather than recalling an isolated fact.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$true of the other domain$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$wrong bond chemistry for unwinding$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true property overgeneralized into the mechanism$q$ FROM q;

-- B2 Q5 . Helicase inactivation fork consequence . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$Helicase inactivation fork consequence$q$,
    $q$A researcher isolates an Escherichia coli strain carrying a temperature-sensitive mutation in the gene encoding the replicative helicase. The strain replicates its chromosome normally at 30 degrees Celsius, but the mutant enzyme is completely inactive at 42 degrees Celsius. If a culture in the middle of a round of chromosomal replication is shifted to 42 degrees Celsius, which of the following outcomes at the replication forks is most likely?$q$,
    $q$[{"label":"A","text":"Replication continues at a normal rate because the parental strands separate spontaneously at the elevated temperature"},{"label":"B","text":"Okazaki fragments are synthesized on the lagging strand but are never joined into a continuous strand"},{"label":"C","text":"The parental duplex is no longer opened at the fork, so no single-stranded template is exposed for new synthesis"},{"label":"D","text":"Strands that were already separated re-anneal behind the fork because they are no longer protected from reforming a duplex"}]$q$::jsonb,
    'C',
    $q$This question tests Nucleic Acids, specifically the role of helicase in DNA replication and the functional consequence of losing strand separation at the replication fork. The answer is C because helicase is the ATP-dependent motor enzyme that unwinds the parental double helix at the replication fork, converting duplex DNA into the two exposed single strands that serve as templates for new synthesis. DNA polymerase can only read a single-stranded template; it has no ability to pry an intact duplex apart on its own. When the temperature shift inactivates the mutant helicase, unwinding at the fork stops. No new single-stranded template is exposed, so the downstream machinery, including the polymerases copying both the leading and lagging strands, has nothing left to copy, and fork progression halts. This is the defining upstream defect: every later step of replication depends on helicase first opening the duplex. (Choice A) The two strands of the double helix do not separate spontaneously under normal growth conditions. The duplex is thermodynamically stable at physiological and growth temperatures, which is exactly why the cell must invest ATP through helicase to open it. A shift to 42 degrees Celsius is far below the temperature required to melt duplex DNA, so replication cannot simply continue without active unwinding. (Choice B) A failure to join Okazaki fragments into a continuous strand points to a defect in DNA ligase, the enzyme that seals the nicks between adjacent fragments on the lagging strand. Ligase is intact in this strain, and fragment joining is a late, downstream event that presupposes single-stranded templates were already exposed and copied, which cannot happen here. (Choice D) Re annealing of already separated strands behind the fork is the signature defect of losing single-strand binding proteins, which coat exposed single strands to keep them from reforming a duplex. Those proteins remain fully functional in this strain. More importantly, when helicase is inactive the parental strands are never separated in the first place, so there is essentially no new single-stranded DNA behind the fork to re-anneal; the lesion sits upstream of any protection step. This is a Knowledge of Scientific Concepts and Principles question because it requires recalling the specific job helicase performs within the replication machinery and predicting the direct functional consequence at the fork when that single activity is removed.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$spontaneous-process fallacy$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$wrong-enzyme defect swap$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true mechanism, wrong lesion$q$ FROM q;

-- B2 Q6 . origin AT richness and duplex opening . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$origin AT richness and duplex opening$q$,
    $q$To study how origin sequence affects the start of bacterial replication, researchers construct two plasmids that are identical except at the origin region: one carries the natural origin sequence, while in the other most adenine and thymine pairs within the origin are replaced by guanine and cytosine pairs, with overall length unchanged. Initiator proteins bind both origins normally and load helicase onto each. In the substituted plasmid, however, initial opening of the double helix at the origin is markedly impaired. Which statement best explains this observation?$q$,
    $q$[{"label":"A","text":"Guanine and cytosine pairs are joined by three hydrogen bonds rather than two, so the substituted origin resists strand separation"},{"label":"B","text":"Guanine and cytosine pairs are connected by stronger phosphodiester bonds, reinforcing the covalent backbone of the substituted origin"},{"label":"C","text":"Adenine and thymine pairs are joined by three hydrogen bonds and guanine and cytosine pairs by only two, so the natural origin is the harder one to open"},{"label":"D","text":"Initiator proteins cannot recognize sequences rich in guanine and cytosine, so the substituted origin is never engaged by the replication machinery"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests reasoning about why origins of replication are rich in adenine and thymine pairs and what happens when that enrichment is removed. Replication begins when initiator proteins recognize the origin and helicase starts to pry the two strands apart, a step that requires disrupting the hydrogen bonds joining complementary bases on opposite strands. The answer is A because an adenine and thymine pair is held together by two hydrogen bonds while a guanine and cytosine pair is held together by three, so a stretch of duplex enriched in guanine and cytosine pairs requires more hydrogen bonds to be broken for each turn of helix that is opened. Bacterial origins are naturally rich in adenine and thymine sequences precisely because such regions are the easiest places to open the helix. Replacing those pairs raises the local stability of the duplex, so helicase struggles to achieve the initial opening even though it loads normally, which matches the observed phenotype exactly. (Choice B) The phosphodiester bonds of the backbone link a sugar to a phosphate within a single strand and are chemically identical no matter which bases are attached. Base substitution changes the number of interstrand hydrogen bonds, not the strength of the covalent backbone, and strand separation never requires breaking the backbone in any case. (Choice C) This reverses the actual counts. Adenine and thymine pairs share two hydrogen bonds and guanine and cytosine pairs share three; if the reversed counts were true, the substituted origin would open more easily than the natural one, which is the opposite of what was observed. (Choice D) This blames the recognition step, but the stem states that initiator proteins bind both origins normally and load helicase onto each. The defect appears downstream of binding, at the point where the duplex must actually be opened. This is a Scientific Reasoning and Problem Solving question because it requires you to connect the hydrogen bonding difference between the two kinds of base pairs to the observed difficulty of opening a substituted origin.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B2 Q7 . torsional strain ahead of fork . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$torsional strain ahead of fork$q$,
    $q$Researchers replicate a long linear DNA molecule whose ends are anchored to beads so that the helix cannot rotate freely, mimicking the topological constraint on chromosomal DNA. After a topoisomerase inhibitor is added, forks continue to advance at a normal rate for a short time but then progressively slow and stall, even though helicase and the polymerases remain fully active. Which mechanism best explains the stalling?$q$,
    $q$[{"label":"A","text":"Unwinding generates negative supercoils behind the fork that drive the separated template strands back into a duplex"},{"label":"B","text":"Topoisomerase is the enzyme that separates the parental strands, so its inhibition leaves the duplex at the fork intact"},{"label":"C","text":"Strand separation requires transient cleavage of the phosphodiester backbone, so with topoisomerase inhibited the helix cannot be opened at any point"},{"label":"D","text":"Each helical turn that helicase opens overwinds the duplex ahead of the fork, and the accumulating positive torsional strain increasingly resists further unwinding"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests reasoning about DNA topology at the replication fork and why topoisomerase inhibition stalls replication. Because the two strands wind around each other, a fork cannot open unless the duplex ahead of it rotates; when the ends are anchored and free rotation is impossible, every helical turn that helicase opens forces an extra turn of overwinding into the unreplicated DNA in front of the fork. The answer is D because this overwinding accumulates as positive supercoiling ahead of the advancing fork, and the resulting torsional strain opposes strand separation more and more strongly until helicase can no longer open the helix and the fork stalls. Topoisomerase normally prevents this by transiently nicking the backbone ahead of the fork, allowing controlled rotation, and resealing the cut, so with the enzyme inhibited the strain simply builds. The kinetics are the giveaway: forks move normally at first because little strain has yet accumulated, then slow progressively as each additional turn of unwinding adds to the torsional load. (Choice A) This reverses both the sign and the location of the problem. Unwinding introduces positive, overwound strain, and it appears in the duplex ahead of the fork; the region behind the fork is coated by single strand binding proteins and is not driven back into a duplex by supercoiling in this scenario. (Choice B) This assigns helicase's job to topoisomerase. Topoisomerase does not separate the parental strands; it relieves the strain generated when helicase does. The observation that forks initially advance at a normal rate proves the duplex was being opened even with topoisomerase inhibited. (Choice C) This is partly true in that topoisomerase does transiently cleave the backbone, but strand separation itself requires only disruption of hydrogen bonds, not covalent cleavage. If backbone cleavage were a prerequisite for any opening of the helix, the forks could never have advanced normally at first, which the observations contradict. This is a Scientific Reasoning and Problem Solving question because it requires you to connect the rotational geometry of unwinding to where torsional strain accumulates and to use the delayed stalling pattern to discriminate among candidate mechanisms.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- B2 Q8 . fork strand reannealing diagnosis . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$fork strand reannealing diagnosis$q$,
    $q$A reconstituted replication system is assembled with exactly one fork protein omitted. At the fork, the parental strands separate transiently but snap back into a duplex just behind the point of unwinding, while the DNA ahead of the fork maintains normal supercoiling throughout the experiment. Omission of which of the following proteins, by itself, could produce these observations?

I. Helicase
II. Single-strand binding protein
III. Topoisomerase$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"III only"},{"label":"D","text":"II and III only"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the ability to diagnose which replication fork protein is missing from the observed behavior of the fork. Two observations must be explained together: the strands do separate but immediately re-anneal just behind the unwinding point, and the DNA ahead of the fork maintains normal supercoiling. The answer is B because only the loss of single strand binding proteins fits both findings. Transient separation proves that helicase is present and actively breaking the hydrogen bonds between the strands, and normal supercoiling ahead of the fork proves that topoisomerase is present and relieving torsional strain as unwinding proceeds. What is missing is the component that preserves the separated state: single strand binding proteins normally coat the exposed templates and physically block the complementary strands from re-pairing, so in their absence the perfectly complementary templates snap back into a duplex as soon as helicase moves on. (Choice A) If helicase had been omitted, the parental strands would never have separated at all, because no other protein in the system breaks the base pairing interactions between the strands. The observed transient unwinding therefore rules out statement I as the omitted component. (Choice C) Topoisomerase relieves torsional strain ahead of the fork by transient nicking and resealing of the backbone; it plays no role in keeping already separated strands apart. Its omission would produce accumulating overwinding ahead of the fork, and the maintained normal supercoiling excludes statement III on two independent grounds. (Choice D) This option correctly includes statement II but also claims that omitting topoisomerase alone could produce the same picture. Topoisomerase omission would cause strain to build ahead of the fork rather than re-annealing behind it, so the normal topology observed ahead of the fork eliminates statement III from any correct combination. This is a Scientific Reasoning and Problem Solving question because it requires you to work backward from two experimental observations at the fork to identify the single missing protein consistent with both.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B2 Q9 . primase primer initiation requirement . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$primase primer initiation requirement$q$,
    $q$A bacterial extract supports complete DNA replication in vitro. When primase is selectively inhibited, helicase still unwinds the parental duplex and single strand binding proteins still coat the exposed templates, yet DNA polymerase III adds no nucleotides. Which property of DNA polymerase III explains this result?$q$,
    $q$[{"label":"A","text":"It cannot load onto template DNA that is coated with single strand binding proteins."},{"label":"B","text":"It can only extend a chain that already provides a free 3' hydroxyl group, which it cannot generate on its own."},{"label":"C","text":"It requires topoisomerase to relieve torsional strain ahead of the fork before catalysis can begin."},{"label":"D","text":"Its proofreading exonuclease degrades any template strand that lacks a primer."}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests why DNA replication cannot begin without primase, which reduces to a universal limitation shared by every DNA polymerase. The answer is B because no DNA polymerase can initiate a new strand on a bare template; the enzyme can only extend a nucleic acid chain that already ends in a free 3' hydroxyl group, and it has no activity that can create that starting point by itself. Primase, a specialized RNA polymerase that belongs to the replication machinery, solves the problem by laying down a short RNA segment, roughly five to ten nucleotides long, that is complementary to the template. That primer terminates in exactly the free 3' hydroxyl the polymerase requires, and each subsequent phosphodiester bond forms at the growing 3' end. This same limitation is why the lagging strand, which restarts repeatedly, needs a fresh primer for every Okazaki fragment while the leading strand needs only one. With primase inhibited, unwinding and strand coating continue normally, but no primer is ever made, so there is never a 3' hydroxyl to build from, and the first bond of the daughter strand can never form. (Choice A) Single strand binding proteins do not obstruct the polymerase; they coat the separated strands to prevent them from reannealing into a duplex, which preserves the template in a usable state rather than blocking access to it. (Choice C) Torsional strain ahead of the fork is managed by topoisomerase, and the stem specifies that unwinding proceeds normally; supercoiling stress would slow fork progression, not selectively prevent the very first nucleotide addition on an already exposed template. (Choice D) The proofreading exonuclease removes mispaired nucleotides from the 3' end of a strand the polymerase is actively extending; it does not degrade unprimed template DNA, so template destruction cannot explain the missing synthesis. This is a Scientific Reasoning and Problem Solving question because it asks you to predict the downstream consequence of inactivating one fork enzyme and to trace that failure to the polymerase's strict requirement for a preexisting free 3' hydroxyl.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$SSB as blocker$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true fact, wrong enzyme's problem$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$misplaced proofreading step$q$ FROM q;

-- B2 Q10 . polymerase reading direction chemistry . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$polymerase reading direction chemistry$q$,
    $q$During elongation, a DNA polymerase advances along one template strand of an unwound duplex, joining one new monomer to the daughter strand in each catalytic cycle. A student claims that the enzyme reads the template 5' to 3' so that the daughter strand can also be assembled 5' to 3'. Which correction pairs the actual reading direction with the actual bond forming chemistry?$q$,
    $q$[{"label":"A","text":"The template is read 5' to 3', and the daughter strand's terminal 5' phosphate attacks the 3' hydroxyl of the incoming nucleotide."},{"label":"B","text":"The template is read 3' to 5', and the daughter strand is assembled 3' to 5' so that the two strands end up parallel to each other."},{"label":"C","text":"The template is read 3' to 5', and the daughter strand's 3' hydroxyl attacks the outermost phosphate of the incoming nucleotide, releasing one phosphate."},{"label":"D","text":"The template is read 3' to 5', and the daughter strand's 3' hydroxyl attacks the innermost phosphate of the incoming nucleotide."}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests the paired directionality rules of DNA synthesis together with the bond forming chemistry that enforces them. The answer is D because the two directions are necessarily opposite: a daughter strand can grow only 5' to 3', and because the two strands of a duplex are antiparallel, the enzyme must therefore travel along the template in the 3' to 5' direction. The chemical reason is that each catalytic cycle is a nucleophilic attack by the free 3' hydroxyl at the tip of the growing strand on the innermost phosphate, the alpha phosphate, of the incoming deoxyribonucleoside triphosphate. That attack forms the new phosphodiester bond and displaces the two outer phosphates together as pyrophosphate. Since the reactive hydroxyl always sits at the 3' terminus of the daughter strand, growth can occur only at that end, and the antiparallel geometry then fixes the reading direction as 3' to 5'. The student's proposal would force the daughter strand to elongate 3' to 5', an activity no DNA polymerase possesses. (Choice A) This reverses both the direction and the chemistry: the growing strand's 3' hydroxyl is the attacking nucleophile and the incoming monomer's phosphate is the target; a 5' phosphate does not attack a 3' hydroxyl, and the template is not read 5' to 3'. (Choice B) A daughter strand laid 3' to 5' against a template read 3' to 5' would leave the two strands parallel, but duplex DNA is strictly antiparallel; no polymerase builds a parallel duplex, and no polymerase elongates a strand 3' to 5'. (Choice C) The reading direction here is correct, which makes this choice tempting, but the attack targets the innermost phosphate rather than the outermost one, and the leaving group is pyrophosphate, two phosphates released together, not a single phosphate. This is a Scientific Reasoning and Problem Solving question because it requires coordinating the antiparallel reading rule with the specific site of nucleophilic attack to identify the only chemically consistent pairing.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$flipped nucleophile$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$parallel duplex$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$near miss on phosphate accounting$q$ FROM q;

-- B2 Q11 . labeled template extension direction . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$labeled template extension direction$q$,
    $q$A single stranded DNA template is written left to right as 5' GGATCCTTAGCA 3', and a short RNA primer laid by primase is annealed near the right end of the written sequence. As DNA polymerase elongates from this primer, in which direction across the written sequence does synthesis proceed, and at which end of the primer are new deoxyribonucleotides added?$q$,
    $q$[{"label":"A","text":"Right to left across the written template, with addition at the primer's 3' end."},{"label":"B","text":"Right to left across the written template, with addition at the primer's 5' end."},{"label":"C","text":"Left to right across the written template, with addition at the primer's 3' end."},{"label":"D","text":"Left to right across the written template, with addition at the primer's 5' end."}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests the application of the replication directionality rules to a template written on the page with labeled ends. The answer is A because a polymerase always reads its template 3' to 5' while assembling the new strand 5' to 3'. In the written sequence the template's 3' end sits at the right, so the enzyme engages near the right side and travels right to left, toward the template's 5' end at the left. The primer is annealed antiparallel to the template, which means the primer's own 3' terminus points leftward, in the direction of travel, and that 3' terminus supplies the free hydroxyl to which every incoming deoxyribonucleotide is joined. Working through both layers, direction of movement across the page and identity of the growing end, gives right to left with addition at the primer's 3' end. Notice that the base sequence itself never matters; only the labeled ends do, which is why this reasoning transfers to any template you are shown. (Choice B) The direction is correct, but extension at the 5' end would require new bonds to form at the primer's terminal 5' phosphate, which reverses the actual chemistry; the 5' end is where primase began the primer, and that end never grows. (Choice C) Reading left to right simply follows the template's own written 5' to 3' polarity, but that is the template's orientation, not the enzyme's reading direction; a polymerase moving left to right here would have to build the daughter strand 3' to 5', which no DNA polymerase can do. (Choice D) This pairs the wrong direction with the wrong terminus, in effect confusing the laying of the primer with its subsequent extension and treating the new strand as if it grew parallel to the template from its starting end; both the antiparallel rule and the growing 3' end rule are violated. This is a Scientific Reasoning and Problem Solving question because it requires mapping abstract polarity rules onto a concretely written sequence and deducing both the direction of synthesis and the chemically growing end.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$right direction, wrong terminus$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$template polarity as reading direction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$priming step conflated with extension$q$ FROM q;

-- B2 Q12 . deoxyribonucleoside triphosphate substrate selection . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$deoxyribonucleoside triphosphate substrate selection$q$,
    $q$At a bacterial replication fork, a short RNA primer has already been laid on the exposed template, and DNA polymerase III is elongating the new strand from it, adding one monomer at a time. Which monomer form does DNA polymerase III bind as its direct substrate for each addition?$q$,
    $q$[{"label":"A","text":"Deoxyribonucleoside monophosphates, the same form found as residues in the finished strand."},{"label":"B","text":"Ribonucleoside triphosphates, identical to the monomers primase polymerizes into the primer."},{"label":"C","text":"Deoxyribonucleoside triphosphates, each arriving with its own triphosphate group attached."},{"label":"D","text":"Deoxyribonucleoside diphosphates, which retain a single transferable phosphate bond."}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests the identity of the monomer that DNA polymerase uses during elongation and how it differs from the monomer primase uses. The answer is C because the direct substrates of DNA polymerase III are deoxyribonucleoside triphosphates. Each incoming monomer arrives carrying its own triphosphate group, and the growing strand's free 3' hydroxyl attacks the innermost phosphate of that incoming triphosphate, forming the new phosphodiester bond while the two outer phosphates depart together as pyrophosphate. The primer in the stem is primase's product: primase, an RNA polymerase belonging to the replication machinery, strings together a short RNA segment directly on the template from ribonucleoside triphosphates, and DNA polymerase III then takes over at that segment's end using its own deoxyribose containing monomers, which is what keeps the rest of the daughter strand DNA. (Choice A) The residues within a finished strand are indeed monophosphates, because two phosphates are lost during incorporation, but the monophosphate is the product left behind in the chain, not the substrate the enzyme binds; free monophosphates cannot be added to a growing strand. (Choice B) Ribonucleoside triphosphates are the monomers primase uses to build its short RNA primer; DNA polymerase III instead selects deoxyribose containing monomers, which is what keeps the daughter strand DNA rather than RNA. (Choice D) Diphosphates carry too few phosphates: the enzyme requires the full triphosphate form, and the incorporation reaction releases the two terminal phosphates together as pyrophosphate, an arrangement a diphosphate substrate could not supply. This is a Knowledge of Scientific Concepts and Principles question because it asks for direct recall of the triphosphate substrate requirement of DNA polymerase and of which enzyme at the fork uses the ribonucleotide pool instead.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$product mistaken for substrate$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$neighboring enzyme's substrate$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$off by one phosphate$q$ FROM q;

-- B2 Q13 . replication fork asymmetry logic . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$replication fork asymmetry logic$q$,
    $q$During replication of a bacterial chromosome, one daughter strand at each fork is synthesized continuously while the other is assembled from short pieces that are later joined. Which of the following properties of the replication machinery, taken together, are required to produce this asymmetry?

I. DNA polymerases extend a new strand only in the 5' to 3' direction
II. The two parental template strands are antiparallel
III. The lagging strand is chemically synthesized in the 3' to 5' direction$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"III only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests why the replication fork is asymmetric, with one daughter strand made continuously and the other discontinuously. The answer is C because the asymmetry follows from exactly two facts acting together: DNA polymerases add nucleotides only to a free 3' hydroxyl, so every new strand grows exclusively 5' to 3' (statement I), and the two parental templates run antiparallel (statement II). As the fork unwinds in one direction, the template oriented 3' to 5' relative to fork movement can be copied continuously in the same direction the fork travels, giving the leading strand. The opposite template is oriented 5' to 3' relative to fork movement, so a polymerase obeying the 5' to 3' rule must copy it moving away from the fork; it can only work in repeated short stretches on freshly exposed template, producing Okazaki fragments. Statement III is false: no polymerase synthesizes 3' to 5'. The lagging strand only appears to grow 3' to 5' overall because its individual 5' to 3' fragments are laid down opposite to the direction of fork movement. (Choice A) Polymerase directionality alone cannot generate asymmetry. If the two templates were parallel instead of antiparallel, a 5' to 3' polymerase could copy both continuously in the direction of fork movement; the constraint creates asymmetry only in combination with statement II. (Choice B) Statement III reverses the actual chemistry. Both daughter strands are synthesized 5' to 3', and the lagging strand's overall 3' to 5' appearance is a consequence of where fragments are placed, not of reversed synthesis; III alone also could not explain continuous leading strand synthesis. (Choice D) Including statement III makes this option internally contradictory, since statement I correctly states the universal 5' to 3' rule that III denies; the two cannot both hold at the same fork. This is a Scientific Reasoning and Problem Solving question because it requires integrating polymerase directionality with template polarity to deduce why only one daughter strand can track the fork continuously.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$necessary but not sufficient condition$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$reversed chemical polarity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$common belief that the lagging strand grows backward$q$ FROM q;

-- B2 Q14 . fork geometry strand identification . hard . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$fork geometry strand identification$q$,
    $q$A student diagrams a bacterial replication fork advancing to the right along a horizontal duplex. The upper parental strand is drawn with its 5' end to the right, within the unreplicated duplex ahead of the fork, and its 3' end to the left, behind the fork. Based on this geometry, what behavior is expected for the daughter strand synthesized on the upper template?$q$,
    $q$[{"label":"A","text":"Continuous synthesis, with the daughter strand's growing 3' end advancing rightward toward the fork"},{"label":"B","text":"Discontinuous synthesis as a series of fragments that are later joined by ligase"},{"label":"C","text":"Continuous synthesis, with the daughter strand elongating leftward away from the fork"},{"label":"D","text":"Synthesis in the 3' to 5' chemical direction so that the daughter strand can follow the fork"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests identification of the leading strand from a described fork geometry, combining template polarity with the polymerase directionality rule. The answer is A because a polymerase copying the upper template travels in the same direction the fork is moving. DNA polymerase reads any template 3' to 5'. The upper template's 3' end lies to the left, behind the fork, and its 5' end lies to the right, ahead of the fork, so reading 3' to 5' carries the polymerase from left to right. Rightward is exactly the direction of fork advance, meaning newly unwound template is continuously delivered in front of the enzyme and synthesis never has to reinitiate. The daughter strand therefore elongates 5' to 3' with its growing 3' end pointed into the fork, which is the defining behavior of the leading strand at this fork. (Choice B) Fragmented synthesis belongs to the other template. The lower parental strand must have its 3' end to the right, ahead of the fork, so its polymerase moves leftward, away from the advancing fork, and must restart on each newly exposed stretch; assigning Okazaki style synthesis to the upper template reverses the polarity assignment. (Choice C) Continuous synthesis directed away from the fork is geometrically impossible on this template, because the 3' to 5' reading direction of the upper strand points toward the fork, not away from it; a leftward moving polymerase on this strand would have to read the template 5' to 3', which no polymerase does. (Choice D) No DNA polymerase synthesizes in the 3' to 5' chemical direction. All polymerases require a free 3' hydroxyl and extend strands 5' to 3'; daughter strands never switch chemical polarity in order to track the fork. This is a Scientific Reasoning and Problem Solving question because it asks you to convert a stated fork direction and template polarity into a two step prediction of continuous versus discontinuous daughter strand synthesis.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$swaps the leading and lagging template assignment$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$correct mode, wrong direction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$belief that a polymerase can reverse chemical polarity$q$ FROM q;

-- B2 Q15 . lagging strand primer counting . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$lagging strand primer counting$q$,
    $q$In a bacterial system, a single replication fork proceeds unidirectionally from an origin and copies a 240,000 base pair segment before terminating. Okazaki fragments in this organism average 1,200 nucleotides, and every fragment is initiated by its own RNA primer. Over this segment, approximately what is the ratio of primers consumed on the lagging strand to primers consumed on the leading strand?$q$,
    $q$[{"label":"A","text":"1 to 1"},{"label":"B","text":"2 to 1"},{"label":"C","text":"100 to 1"},{"label":"D","text":"200 to 1"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests primer accounting at a replication fork using given segment and fragment lengths. The answer is D because the leading strand at a single fork is primed once while the lagging strand is primed once per Okazaki fragment. On the leading strand, the single primer laid down at the origin is simply extended continuously across the entire 240,000 nucleotides, so one primer suffices for the whole segment. The lagging strand is copied discontinuously, and covering 240,000 nucleotides in fragments that average 1,200 nucleotides requires 240,000 divided by 1,200, which is 200 fragments. Since each fragment begins with its own primer, the lagging strand consumes about 200 primers, giving a lagging to leading ratio of about 200 to 1. All of these primers are later removed and replaced with DNA before ligase seals the nicks, but that downstream processing does not change the count of priming events. (Choice A) A 1 to 1 ratio assumes each daughter strand is primed a single time. That holds only for the continuously synthesized leading strand; the lagging strand must reinitiate with a fresh primer every time a new stretch of its template is exposed behind the advancing fork. (Choice B) A 2 to 1 ratio comes from counting strands or fork arms rather than priming events. Primer consumption on the lagging strand scales with the number of fragments, which the given lengths fix at about 200, not with the number of daughter strands at the fork. (Choice C) A 100 to 1 ratio results from halving the calculation, as if only half of the 240,000 nucleotide length were copied discontinuously. The entire lagging daughter strand across the segment is built from fragments, so the full segment length must be divided by the 1,200 nucleotide fragment size. This is a Data-based and Statistical Reasoning question because it requires computing fragment number from the supplied lengths and translating that count into a quantitative comparison of primer use on the two strands.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$each strand needs only one primer$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$counts strands instead of priming events$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$halves the length before dividing$q$ FROM q;

-- B2 Q16 . pulse label fragment origin . easy . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$pulse label fragment origin$q$,
    $q$Rapidly dividing bacteria are exposed to a very brief pulse of radiolabeled thymidine, and their DNA is immediately denatured and separated by size. Much of the newly incorporated label appears in pieces roughly 1,000 nucleotides long rather than in chromosome length strands. Which feature of the replication fork accounts for these small labeled pieces?$q$,
    $q$[{"label":"A","text":"The leading strand is synthesized in bursts each time the fork transiently stalls"},{"label":"B","text":"The lagging strand is built discontinuously, and many of its fragments have not yet been ligated"},{"label":"C","text":"Excision repair enzymes cut newly synthesized DNA into uniform lengths before resealing it"},{"label":"D","text":"Topoisomerase generates the pieces as it nicks DNA to relieve strain ahead of the fork"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests the experimental signature of discontinuous synthesis on the lagging strand. The answer is B because the lagging strand template is exposed only in successive stretches as the fork advances, so its daughter strand must be assembled as Okazaki fragments, each initiated by its own primer and extended 5' to 3' away from the fork. A very brief labeling pulse catches many of these fragments before primer removal and ligation have stitched them to their neighbors, so when the DNA is denatured, a large share of the fresh label runs as pieces of roughly Okazaki fragment size. With a longer chase, those same pieces are processed and joined into continuous strands, and the label shifts into high molecular weight DNA, which is exactly the behavior that originally revealed discontinuous replication. (Choice A) The leading strand tracks the fork continuously from a single priming event, so its newly made DNA is one long uninterrupted strand; a transient pause in fork movement slows elongation but does not sever a continuous daughter strand into pieces. (Choice C) Excision repair pathways remove damaged or mispaired stretches at scattered lesions; they act on a small fraction of the genome and would not convert the bulk of freshly labeled DNA into pieces of a characteristic size during normal replication. (Choice D) Topoisomerase makes transient nicks in the parental duplex ahead of the fork to relieve overwinding and immediately reseals them; it acts briefly on template DNA, not on the newly synthesized labeled strands, and leaves no persistent fragments behind. This is a Scientific Reasoning and Problem Solving question because it asks you to connect a pulse labeling observation to the fork mechanism that produces short nascent fragments on only one of the two daughter strands.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$attributes discontinuity to the wrong strand$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$real pathway, irrelevant to the observation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$assigns fragment generation to the unwinding step$q$ FROM q;

-- B2 Q17 . lagging strand junction sealing . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$lagging strand junction sealing$q$,
    $q$In Escherichia coli, DNA polymerase I has just finished excising the RNA primer at the 5' end of an Okazaki fragment and has replaced it with deoxyribonucleotides. Analysis of the junction at this moment shows that the lagging strand is still not covalently continuous, even though every base is correctly paired. Which event must occur next to complete this region of the strand?$q$,
    $q$[{"label":"A","text":"RNase H must degrade the remaining ribonucleotides before the fragments can be joined"},{"label":"B","text":"DNA polymerase I forms the final phosphodiester bond as it dissociates, so the junction closes without any additional enzyme"},{"label":"C","text":"Primase must synthesize a short bridging primer that DNA polymerase III then extends across the junction"},{"label":"D","text":"DNA ligase must catalyze formation of the final phosphodiester bond at the nick between adjacent fragments"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests the final maturation steps of the lagging strand, specifically the hand off between DNA polymerase I and DNA ligase in prokaryotic replication. The answer is D because a DNA polymerase can only extend a free 3' hydroxyl group with incoming nucleotides; it has no ability to join its final nucleotide to the 5' phosphate of the downstream fragment that already exists. When polymerase I finishes excising primer ribonucleotides and filling the gap with DNA, the backbone at the junction still lacks exactly one phosphodiester bond. This unsealed break is called a nick, and every base across the junction can be correctly paired while the strand itself remains covalently discontinuous. DNA ligase is the enzyme that recognizes the nick and catalyzes formation of that last phosphodiester bond, converting the series of separate Okazaki fragments into one continuous lagging strand. Until ligase acts, the region described in the stem stays broken, which is why the strand is not yet covalently continuous. (Choice A) RNase H is a real ribonuclease that degrades RNA within RNA and DNA hybrids, but the stem specifies that the primer has already been fully excised by polymerase I, so no ribonucleotides remain at the junction for RNase H to attack; this answer places a genuine enzyme where its substrate no longer exists. (Choice B) Polymerase I cannot form the sealing bond as it leaves; polymerases build only by adding nucleotides onto a free 3' hydroxyl, and joining two preexisting strand ends is a chemically distinct reaction that the polymerase active site does not perform. (Choice C) Primase acts at the beginning of fragment synthesis, laying down the short RNA that gives a polymerase its starting point; recruiting it to a completed junction would reinsert RNA into a region from which RNA was just removed and would create a new gap rather than close one. This is a Scientific Reasoning and Problem Solving question because it requires deducing which covalent lesion persists after primer replacement and matching that specific lesion to the one enzyme capable of resolving it.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$real enzyme, wrong moment$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$polymerase seals its own nick$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$initiation step at termination$q$ FROM q;

-- B2 Q18 . sliding clamp processivity definition . easy . skill 1 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$sliding clamp processivity definition$q$,
    $q$During eukaryotic replication, PCNA is loaded at the fork as a closed ring that encircles the DNA duplex, and the replicative polymerase binds to this ring while copying the template. Compared with the same polymerase acting without the clamp, the enzyme held by the ring shows the greatest increase in which property?$q$,
    $q$[{"label":"A","text":"The number of nucleotides it incorporates during a single binding event with the template"},{"label":"B","text":"The rate at which its active site forms each individual phosphodiester bond"},{"label":"C","text":"The accuracy with which mispaired nucleotides are removed by proofreading"},{"label":"D","text":"The ability of the replication machinery to unwind the parental duplex ahead of the fork"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests processivity and the function of the eukaryotic sliding clamp PCNA at the replication fork. The answer is A because processivity is defined as the number of nucleotides a polymerase incorporates during a single binding event with its template. A polymerase that falls off the DNA after adding only a few nucleotides must rebind before it can continue, and each rebinding step is slow relative to nucleotide addition. PCNA solves this problem topologically: the clamp is a closed ring that encircles the double helix, so it cannot diffuse away from the DNA, and a polymerase held by the ring stays associated with the template for thousands of nucleotides per encounter instead of a handful. The chemistry of each addition is unchanged; what changes is how long the enzyme remains engaged each time it binds, which is precisely the definition of processivity. This distinction is worth keeping sharp: processivity describes persistence per binding event, catalytic rate describes bonds formed per second, and fidelity describes accuracy, and the three properties can vary independently of one another. (Choice B) The rate of individual phosphodiester bond formation is a property of the polymerase active site and its substrates; the clamp does not accelerate the catalytic step itself, it prevents dissociation between steps, so speed per bond is the wrong property. (Choice C) Fidelity depends on base selection in the active site and on the separate proofreading exonuclease activity that excises mispaired nucleotides; tethering the enzyme to the template does not alter either of those error correcting functions. (Choice D) Unwinding the parental duplex ahead of the fork is the job of helicase, a distinct enzyme that separates the two strands; PCNA encircles DNA at the site of synthesis and plays no role in opening the helix. This is a Knowledge of Scientific Concepts and Principles question because it asks for the defined property, processivity, that a sliding clamp confers on the polymerase it tethers.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$processivity equals speed$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true fact, wrong property$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$helicase role transplanted$q$ FROM q;

-- B2 Q19 . telomerase internal RNA template . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$telomerase internal RNA template$q$,
    $q$Telomerase extends the unpaired 3' overhang at the end of a linear chromosome by adding tandem repeats. When the purified enzyme is pretreated with ribonuclease, repeat addition is abolished even though its protein subunit remains intact and properly folded. Which of the following conclusions about the telomerase mechanism are supported?

I. The enzyme carries an internal RNA that serves as the template specifying the repeat sequence.
II. The catalytic subunit functions as a reverse transcriptase, synthesizing DNA from an RNA template.
III. The chromosomal DNA strand being extended serves as the template for the new repeats.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II and III only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests telomerase enzymology, specifically how a ribonucleoprotein enzyme templates and catalyzes repeat synthesis. The answer is C because the ribonuclease experiment isolates the contribution of the RNA component. Destroying the RNA abolishes repeat addition even though the protein subunit is intact, so the RNA must be essential to the reaction rather than incidental; the interpretation is that telomerase carries an internal RNA whose sequence serves as the template dictating the tandem repeat added to the 3' overhang, supporting statement I. Because the enzyme polymerizes DNA while reading an RNA template, its catalytic subunit is by definition an RNA dependent DNA polymerase, which is the biochemical meaning of reverse transcriptase, supporting statement II. Statement III fails on both logic and mechanism: if the chromosomal DNA strand were the template, degrading the enzyme's RNA should have left activity untouched, which contradicts the observed result, and the repeats are added beyond the end of the duplex where no parental sequence exists to copy. (Choice A) Selecting I only accepts the internal RNA template but stops short of the classification that follows directly from it; an enzyme that copies an RNA sequence into DNA is necessarily acting as a reverse transcriptase, so II cannot be excluded once I is accepted. (Choice B) Selecting II and III accepts the reverse transcriptase label while assigning the template role to chromosomal DNA, which reverses the actual template relationship; a DNA templated reaction would be ordinary DNA polymerization, not reverse transcription, and it would have been resistant to ribonuclease. (Choice D) Including all three statements requires accepting III, but the ribonuclease sensitivity demonstrated in the stem directly rules out a DNA templated mechanism, so the set is internally inconsistent with the data. This is a Scientific Reasoning and Problem Solving question because it requires using an enzyme inactivation result to decide which templating and catalytic mechanism is consistent with the evidence.$q$,
    'medium',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$incomplete inference chain$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$template relationship inverted$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$all statements sound plausible$q$ FROM q;

-- B2 Q20 . ligase deficient extract interpretation . hard . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$ligase deficient extract interpretation$q$,
    $q$A researcher replicates a plasmid template in two Escherichia coli extracts, one wild type and one carrying a mutant DNA ligase that loses activity at the nonpermissive temperature, with both extracts incubated at that temperature. DNA polymerase I is confirmed to be fully active in both extracts. Replication products are then separated on an alkaline gel, in which all base pairing is disrupted so that each covalently continuous strand migrates according to its own length. Which result from the mutant extract would confirm that fragment joining, rather than primer processing, is the blocked step?$q$,
    $q$[{"label":"A","text":"Accumulation of short lagging strand fragments that retain ribonucleotides at their 5' ends"},{"label":"B","text":"Accumulation of short lagging strand fragments composed entirely of deoxyribonucleotides"},{"label":"C","text":"Fragmentation of the leading strand into pieces the size of Okazaki fragments"},{"label":"D","text":"Migration of the lagging strand as a single species of full length because nicked strands remain associated with the template"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests experimental dissection of lagging strand maturation, using a denaturing gel readout to distinguish a ligation defect from a primer processing defect. The answer is B because the two finishing enzymes leave different molecular signatures when blocked. The stem establishes that polymerase I is fully active, so every RNA primer is still excised and replaced with DNA on schedule; the only step that fails at the nonpermissive temperature is nick sealing by ligase. Each Okazaki fragment therefore matures into a pure DNA piece that is never covalently joined to its neighbors. Because the alkaline gel disrupts all base pairing, every covalently separate piece migrates independently, so the mutant lagging strand appears as an accumulation of short fragments containing no ribonucleotides, while the wild type extract yields long continuous strands. That composite signature, short pieces that are entirely DNA, pins the block to joining rather than to primer processing. (Choice A) Fragments retaining ribonucleotides at their 5' ends are the signature of a primer removal defect; observing them would implicate polymerase I, the very step the stem confirms is intact, so this result would contradict rather than confirm the hypothesis. (Choice C) The leading strand is primed once and synthesized continuously toward the fork, so a ligase defect leaves it essentially full length; leading strand fragmentation would point to an entirely different lesion, such as template damage, not to a joining failure confined to the lagging strand. (Choice D) This choice misreads the detection method: unjoined fragments do remain annealed to the template under native conditions, but the alkaline gel abolishes base pairing, so association with the template cannot make covalently separate fragments migrate as a single species of full length. This is a Reasoning about the Design and Execution of Research question because it asks which gel observation would isolate ligation as the failed step given a control establishing that primer processing is intact.$q$,
    'hard',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    3,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$upstream lesion attributed downstream$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$both strands discontinuous$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$native versus denaturing readout swapped$q$ FROM q;

-- B2 Q21 . proofreading exonuclease directionality . easy . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$proofreading exonuclease directionality$q$,
    $q$A bacterial DNA polymerase carries a point mutation that abolishes one of its catalytic activities while leaving its rate of nucleotide addition unchanged. In a replication assay, the wild-type enzyme misincorporates about 1 nucleotide per 10^7 polymerized, whereas the mutant misincorporates about 1 per 10^5. Based on these data, which activity has the mutation most likely eliminated?$q$,
    $q$[{"label":"A","text":"The 5' to 3' exonuclease activity that removes RNA primers ahead of the enzyme"},{"label":"B","text":"An endonuclease activity that nicks the new strand at a site distant from a mispaired base"},{"label":"C","text":"The 3' to 5' exonuclease activity that excises a just-added nucleotide that fails to pair with the template"},{"label":"D","text":"A 3' to 5' polymerase activity that extends the primer in the direction opposite normal synthesis"}]$q$::jsonb,
    'C',
    $q$This Nucleic Acids question tests the proofreading function of DNA polymerase, the exonuclease activity that removes misincorporated nucleotides during synthesis. The answer is C because a 100 fold rise in the misincorporation rate, with no change in the speed of nucleotide addition, points to loss of an error correcting activity rather than the synthetic activity. DNA polymerases synthesize exclusively in the 5' to 3' direction, and their built in proofreading runs in the reverse direction: a 3' to 5' exonuclease activity clips out a just added nucleotide when it fails to pair correctly with the template, allowing synthesis to resume with the correct base. Because base selection at the insertion site is untouched in this mutant, initial errors occur at the normal frequency, but without the excision step those errors persist in the product, and the measured rate climbs from about 1 per 10^7 to about 1 per 10^5. That 100 fold change matches the fidelity contribution typically credited to proofreading. (Choice A) The 5' to 3' exonuclease activity, found in prokaryotic DNA polymerase I, removes RNA primers in front of the advancing enzyme during Okazaki fragment maturation; it degrades nucleic acid ahead of the polymerase and never evaluates the base the enzyme just added, so its loss would impair primer removal rather than raise the misincorporation rate. (Choice B) An endonuclease that nicks the new strand at a distance from a mispair describes the mismatch repair pathway, which operates after the replication fork has passed; that is a separate protein system, not a catalytic activity of the replicative polymerase being measured in this assay. (Choice D) No polymerase extends a strand in the 3' to 5' direction; chain growth requires attack by the free 3' hydroxyl on an incoming nucleoside triphosphate, so synthesis is obligatorily 5' to 3', and the stem states that addition is unaffected in any case. This is a Data-based and Statistical Reasoning question because it requires inferring which catalytic activity was lost from a measured 100 fold change in replication error rate.$q$,
    'easy',
    '1B',
    $q$Nucleic Acids$q$,
    'biochemistry',
    4,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B2 Q22 . layered replication fidelity rates . hard . skill 4 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$layered replication fidelity rates$q$,
    $q$Researchers reconstitute bacterial DNA replication in vitro and measure error rates under three conditions. With a polymerase capable only of base selection at the insertion site, the error rate is about 1 misincorporation per 10^5 nucleotides. When the polymerase's proofreading activity is restored, the rate falls to about 1 per 10^7. When functional mismatch repair proteins are added as well, the rate falls to about 1 per 10^9. A strain is then engineered whose polymerase lacks proofreading but whose mismatch repair system is fully functional. Which replication error rate is most consistent with these data?$q$,
    $q$[{"label":"A","text":"About 1 error per 10^7 nucleotides"},{"label":"B","text":"About 1 error per 10^9 nucleotides"},{"label":"C","text":"About 1 error per 10^5 nucleotides"},{"label":"D","text":"About 1 error per 10^11 nucleotides"}]$q$::jsonb,
    'A',
    $q$This Nucleic Acids question tests how the successive fidelity mechanisms of base selection, proofreading, and mismatch repair combine multiplicatively to set the overall replication error rate. The answer is A because the data show each layer acting independently on the errors left behind by the previous one. Base selection alone leaves about 1 error per 10^5 nucleotides. Adding proofreading lowers the rate to 1 per 10^7, so proofreading removes about 99 of every 100 errors presented to it, a factor of 10^2. Adding mismatch repair lowers the rate further to 1 per 10^9, so mismatch repair also contributes a factor of about 10^2, acting on the mispairs that escaped both earlier steps. A strain lacking proofreading but retaining mismatch repair therefore starts from the base selection rate of 1 per 10^5 and gains only the mismatch repair improvement of 10^2, which converts 1 error per 10^5 into about 1 error per 10^7 nucleotides. (Choice B) A rate of 1 per 10^9 would require mismatch repair to catch every additional mispair that proofreading normally removes; the layers behave as independent filters that each intercept a fixed fraction of the errors reaching them, so a downstream layer cannot fully compensate for a missing upstream one. (Choice C) A rate of 1 per 10^5 would mean mismatch repair contributes nothing when proofreading is absent, but mismatch repair recognizes the distortion of a mispaired helix after the fork has passed and does not depend on the polymerase having flagged the error; the data show it functions as an independent correction step. (Choice D) A rate of 1 per 10^11 applies the mismatch repair factor on top of the fully intact system, implying that a proofreading deficient mutant replicates one hundred times more accurately than the complete wild-type system, which is impossible when a correction layer has been removed. This is a Data-based and Statistical Reasoning question because it requires extracting the multiplicative fold contribution of each fidelity layer from measured error rates and recombining those factors to predict a mutant phenotype.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', NULL FROM q;

-- B2 Q23 . new strand excision rationale . medium . skill 2 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$new strand excision rationale$q$,
    $q$During bacterial replication, the polymerase mistakenly inserts a T opposite a template G, and the resulting G-T mispair escapes proofreading as the fork moves on. Mismatch repair machinery later binds the mispaired site. If the machinery excised a patch of the parental strand containing the G and resynthesized that patch using the new strand as a template, what would be the outcome at this site?$q$,
    $q$[{"label":"A","text":"The replication fork would stall at the excision gap until a new replisome assembled there"},{"label":"B","text":"The site would be restored to a G-C pair, because gap-filling synthesis reinserts the base originally present in the parental strand"},{"label":"C","text":"Both strands would be cleaved at the mispair, producing a double-strand break that requires recombination to resolve"},{"label":"D","text":"The mispair would be eliminated, but the site would now carry an A-T pair, permanently replacing the original G-C information in both strands"}]$q$::jsonb,
    'D',
    $q$This Nucleic Acids question tests why mismatch repair must direct excision to the newly synthesized strand rather than the parental template. The answer is D because resynthesis across an excision gap is dictated by whichever strand remains intact, and here the remaining strand carries the erroneous base. If the patch containing the parental G is removed, the polymerase filling the gap reads the surviving new strand, encounters the wrongly inserted T, and pairs it with A. The position that originally encoded a G-C pair now carries an A-T pair on both strands. Because the helix is once again perfectly complementary, no surveillance system can tell that anything is wrong, and every subsequent round of replication faithfully copies the altered sequence. Repairing the template strand therefore converts a transient replication error into a permanent change in the genetic information, which is precisely why the machinery must instead excise the patch from the new strand and resynthesize it against the parental template, restoring the original G-C pair. (Choice A) The replication fork has already passed this site; mismatch repair operates on completed double stranded DNA behind the fork, and a short single strand excision gap is filled by a repair polymerase without stalling any fork or recruiting a replisome. (Choice B) This reverses the logic of templated synthesis: the base inserted across the gap is dictated by the strand that remains, and the remaining new strand presents a T, which templates insertion of A, not the original C. The only copy of the original information was the parental G that was just excised. (Choice C) Mismatch repair removes a patch from one strand only and leaves the complementary strand intact to serve as the resynthesis template; it does not cut both strands, so no double-strand break or recombination event results. This is a Scientific Reasoning and Problem Solving question because it requires predicting the sequence consequence of excising the wrong strand by tracking base pairing rules through excision and resynthesis.$q$,
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
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- B2 Q24 . methyl directed strand discrimination . medium . skill 3 . 1B
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'DNA and Biotechnology',
    $q$methyl directed strand discrimination$q$,
    $q$To identify the signal that directs bacterial mismatch repair, researchers construct three circular DNA heteroduplexes, each containing a single G-T mispair, and incubate each with cell extract. When adenines in GATC sequences are methylated on only one strand, repair almost always converts the mispair to the base pair dictated by the methylated strand's sequence. When both strands are methylated, the mispair is largely left unrepaired. When neither strand is methylated, the mispair is corrected, but with no bias toward either strand. Which conclusion do these results best support?$q$,
    $q$[{"label":"A","text":"Repair proteins require a nearby methylated adenine in order to bind a mispaired base"},{"label":"B","text":"Methylation directs which strand is excised only when the mark differs between strands, and repair itself proceeds without any methyl mark"},{"label":"C","text":"Methylating both strands stimulates repair most strongly because additional methyl marks recruit more repair proteins"},{"label":"D","text":"The methyl group is recognized as a lesion, and repair removes the methylated adenine along with surrounding bases"}]$q$::jsonb,
    'B',
    $q$This Nucleic Acids question tests strand discrimination in bacterial mismatch repair, in which transient methylation asymmetry distinguishes parental DNA from newly synthesized DNA. The answer is B because the pattern across the three substrates shows that methylation serves as a comparative signal for strand choice, not as a prerequisite for repair. In the cell, adenines within GATC sequences are methylated, but a newly made strand remains unmethylated for a short window after the fork passes; during that hemimethylated window the machinery excises the strand lacking the mark, which is necessarily the new strand carrying any replication error. The experiment reproduces this logic: with marks on one strand only, repair consistently restores the sequence of the marked strand, while with marks on both strands the machinery has no way to choose and largely leaves the mispair alone. Crucially, the fully unmethylated substrate is still corrected, just without strand bias, showing that mispair recognition and excision require no methyl mark at all and that only a difference between the strands provides direction. (Choice A) This is partially true in that methylation influences the outcome, but the unmethylated heteroduplex was still repaired, so engagement of the repair proteins with the mispair cannot require a methylated adenine; the mark governs strand selection, not binding. (Choice C) This inverts the observed relationship: the fully methylated substrate was the least repaired, not the most, because symmetric marks erase the signal identifying which strand to cut. (Choice D) If the methyl group were treated as a lesion, excision would target the methylated strand and fully methylated DNA would be attacked most actively; the data show the opposite, and normal parental DNA remains methylated indefinitely without triggering repair. This is a Reasoning about the Design and Execution of Research question because it requires selecting the conclusion supported by comparing repair outcomes across substrates that differ only in their strand methylation pattern.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

COMMIT;

-- Verification: expect 48 questions and 144 distractor rows (batches 1+2).
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'DNA and Biotechnology') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'DNA and Biotechnology') AS distractor_rows;
