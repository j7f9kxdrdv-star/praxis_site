-- Biochemistry Ch3: Non-enzymatic Protein Function & Protein Analysis — Batch 2 — Separation & Purification (5C)
-- Original Praxist Prep questions, grounded in LibreTexts Biochemistry; scope verified vs AAMC 2026 outline.
-- Idempotent: deletes only this batch's subtopics, then re-inserts. question_attempts / distractor_metadata cascade.

DELETE FROM questions WHERE topic = 'Non-enzymatic Protein Function and Protein Analysis' AND subtopic IN ('Chromatography', 'Electrophoresis', 'Isoelectric Focusing', 'Native PAGE', 'SDS-PAGE');

-- Q1 [Electrophoresis] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Electrophoresis', 'During a native gel electrophoresis run, two globular proteins, Protein X and Protein Y, are loaded into the same gel and subjected to an identical, uniform electric field. At the buffer pH used, both proteins carry a net positive charge and migrate toward the cathode. Protein X has a net charge of +2 and a frictional coefficient of 4 (arbitrary units), while Protein Y has a net charge of +3 and a frictional coefficient of 6 (same units). The steady-state migration velocity of each protein is described by \(v = Ez/f\), where \(E\) is the field strength, \(z\) is the net charge, and \(f\) is the frictional coefficient. After the field is applied, how will the two proteins migrate relative to each other?', '[{"label": "A", "text": "Protein X and Protein Y migrate at the same velocity and remain together as a single band."}, {"label": "B", "text": "Protein Y migrates faster than Protein X and separates ahead of it toward the cathode."}, {"label": "C", "text": "Protein X migrates faster than Protein Y and separates ahead of it toward the cathode."}, {"label": "D", "text": "Their relative velocities cannot be determined without knowing each protein''s isoelectric point."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because migration velocity is set by the ratio of net charge to frictional coefficient, \(v = Ez/f\), not by charge or size alone. Since both proteins experience the same field \(E\), the field term cancels when comparing them, and only the ratio \(z/f\) matters. For Protein X, \(z/f = 2/4 = 0.5\); for Protein Y, \(z/f = 3/6 = 0.5\). The ratios are equal, so \(v_X = v_Y\): Protein Y''s larger charge is exactly offset by its larger frictional coefficient, and the two proteins co-migrate as one band. (Choice A) is correct: computing \(z/f\) for each protein yields 0.5 for both, so their velocities are identical and they do not resolve into separate bands. (Choice B) is incorrect: it applies charge-only reasoning, assuming the protein with the higher net charge (+3 for Y) must move faster; this ignores that Y also has the larger \(f\), which raises frictional drag and cancels the charge advantage. (Choice C) is incorrect: it applies size-only reasoning, assuming the protein with the smaller frictional coefficient (4 for X) must move faster; this ignores that X also carries the smaller charge (+2), so its lower drag is offset by its lower driving force. (Choice D) is incorrect: the net charge \(z\) needed for \(v = Ez/f\) is already given (+2 and +3), so the isoelectric point is not required; pI would only be needed if the charges were unknown and had to be inferred from pH. To arrive at the answer, you had to apply the relationship \(v = Ez/f\) to the specific values given rather than recall a definition, recognizing that equal charge-to-friction ratios produce equal migration velocities.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'charge-only reasoning: assumes the more highly charged species always migrates faster, ignoring the frictional coefficient in v = Ez/f' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'size-only reasoning: assumes the smaller/lower-friction species always migrates faster, ignoring the net charge term in v = Ez/f' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'invokes isoelectric point as necessary information when net charge is already provided, conflating charge determination with charge application' FROM q;

-- Q2 [Electrophoresis] easy skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Electrophoresis', 'During electrophoresis of a mixture of small peptides, a technician loads the sample and applies a constant voltage across the gel. In the buffer used, one peptide carries a net charge of \(+2\). The electrode at the top of the gel is the cathode and the electrode at the bottom is the anode. Toward which electrode will this peptide move once the field is applied?', '[{"label": "A", "text": "Toward the cathode, which is the negatively charged electrode"}, {"label": "B", "text": "Toward the anode, which is the positively charged electrode"}, {"label": "C", "text": "Toward the anode, which is the negatively charged electrode"}, {"label": "D", "text": "Toward the cathode, which is the positively charged electrode"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because in an electric field a charged species is pulled toward the electrode of opposite sign; a peptide with a net charge of \(+2\) is a cation, and cations migrate toward the cathode, which is the negatively charged electrode. (Choice A) is correct: the peptide''s \(+2\) charge makes it a cation, and the field drives it toward the negative electrode (the cathode), consistent with the direction of the electrical force \(F_E = Ez\) on a positive charge in the field. (Choice B) is incorrect: it correctly identifies the anode as the positively charged electrode, but a \(+2\) peptide is repelled from, not attracted to, a positive electrode; this reflects the "like attracts like" misconception. (Choice C) is incorrect: although a cation does move toward the negatively charged electrode, that electrode is the cathode, not the anode—the anode is the positive electrode, so this choice mislabels the electrode. (Choice D) is incorrect: it names the correct destination electrode (the cathode) but mislabels its sign as positive; the cathode is the negatively charged electrode, so the reasoning that a positive peptide is attracted there because the electrode is positive is self-contradictory. This is a Skill 1 question because it asks you to recall and apply the fundamental rule governing the direction of migration in electrophoresis—that a species moves toward the electrode of opposite charge—to a species of stated charge.', 'easy', '5C', 'Separations and Purifications', 'biochemistry', 1, 45)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'like-attracts-like: positive species drawn to the positive electrode' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'anode/cathode name-sign swap: correct sign attraction but electrode mislabeled' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'cathode mislabeled as positive, pairing right destination with wrong sign justification' FROM q;

-- Q3 [Electrophoresis] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Electrophoresis', 'A researcher runs two small nucleic-acid fragments, P and Q, in the same electrophoresis apparatus so that both experience an identical applied electric field. Fragment P carries a net charge of \(-4\) and has a frictional coefficient of \(2.0\) (arbitrary units). Fragment Q carries a net charge of \(-6\) and, because it is more compact, has a frictional coefficient of \(1.5\) (same units). Both fragments migrate toward the anode. Once each fragment reaches a steady migration velocity, how do their velocities compare, and why?', '[{"label": "A", "text": "Q migrates faster than P, because Q has both greater charge magnitude and a smaller frictional coefficient."}, {"label": "B", "text": "P migrates faster than Q, because Q''s larger charge magnitude increases the retarding frictional force it experiences."}, {"label": "C", "text": "P migrates faster than Q, because a lower frictional coefficient reduces the driving force acting on Q."}, {"label": "D", "text": "The two fragments migrate at equal velocities, because they move through the same applied field."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' At steady migration velocity the electrical driving force equals the retarding frictional force, so \(QE = fv\), which rearranges to \(v = QE/f\). Velocity therefore rises with charge magnitude \(Q\) and applied field \(E\), and falls as the frictional coefficient \(f\) (which grows with molecular size) increases. The answer is A because both variables favor Q: with the field \(E\) identical for both fragments, Q''s larger charge magnitude (\(6\) vs \(4\)) increases the numerator while its smaller frictional coefficient (\(1.5\) vs \(2.0\)) shrinks the denominator, so \(v_Q \propto 6/1.5 = 4\) exceeds \(v_P \propto 4/2.0 = 2\).

(Choice A) is correct: Q''s higher charge density (greater \(Q\), smaller \(f\)) makes \(v = QE/f\) larger for Q, so it migrates faster.

(Choice B) is incorrect: charge magnitude appears in the driving-force numerator, not the frictional term. The frictional force \(f v\) depends on size (the frictional coefficient) and velocity, not on the particle''s charge, so greater charge speeds migration rather than adding retarding friction.

(Choice C) is incorrect: the driving force is \(QE\), set by charge and field alone; the frictional coefficient \(f\) appears only in the retarding term \(fv\). A smaller \(f\) reduces friction and thus increases velocity—it does not weaken the driving force.

(Choice D) is incorrect: an identical applied field does not guarantee identical velocity. Velocity is \(QE/f\), so two fragments in the same field still migrate differently whenever their charge or frictional coefficient differs, as they do here.

This item requires applying the relationship \(v = QE/f\) to specific charge and friction values to predict which molecule moves faster, rather than recalling a definition.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'conflates charge with friction' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'friction affects driving force instead of retarding force' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'same-field-implies-same-speed' FROM q;

-- Q4 [Electrophoresis] easy skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Electrophoresis', 'A researcher separates a mixture of two globular proteins by polyacrylamide gel electrophoresis under native (non-denaturing) conditions. Protein P has a molecular weight of 25 kDa and Protein Q has a molecular weight of 90 kDa. At the running pH, the two proteins happen to carry nearly identical net charge and have very similar charge-to-friction ratios, so in a hypothetical charge-driven separation performed in free buffer solution (with no gel present) they would migrate as a single overlapping band. When the same mixture is instead run through the polymerized gel, the two proteins resolve into two clearly separated bands, with Protein P advancing farther toward the electrode than Protein Q. Which statement best explains what the gel matrix contributes to this separation?', '[{"label": "A", "text": "Its network of pores retards the larger protein more than the smaller one, adding a size-dependent effect that the free-solution field alone could not provide."}, {"label": "B", "text": "It magnifies the small difference in net charge between the two proteins, converting a charge tie into a charge-based separation."}, {"label": "C", "text": "It supplies the driving force that pulls both proteins toward the electrode, replacing the need for an applied electric field."}, {"label": "D", "text": "It forms covalent bonds with each protein, anchoring them at fixed positions determined by their binding affinities."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because the polymerized gel is a porous, spider-web-like matrix, and molecules must thread through its pores as the electric field drives them: smaller molecules pass through the pores more readily than larger ones, so the gel imposes a size-dependent (sieving) mechanism on top of the charge-driven motion. In free buffer the two proteins share nearly identical charge-to-friction ratios and would co-migrate, but the matrix retards the 90 kDa Protein Q more than the 25 kDa Protein P, so P advances farther and the two resolve. The scenario is engineered so that charge cannot distinguish the proteins; only the size-based sieving supplied by the matrix can, which is precisely why a matrix is needed. (Choice A) is correct: the pores discriminate by size, retarding the larger protein and providing separation that free-solution electrophoresis, which depends on charge-to-friction ratio, could not achieve here. (Choice B) is incorrect: the matrix does not amplify charge differences; the proteins are stated to have essentially the same net charge, and the gel''s contribution is a size effect, not a charge effect. (Choice C) is incorrect: the applied electric field, not the gel, provides the driving force; the porous gel is a passive medium that also suppresses convection currents but does not push the proteins. (Choice D) is incorrect: the gel does not covalently bind or affinity-anchor the proteins; positions reflect how far each migrated through the pores, and there is no chemical bond fixing them in place. This question assesses Skill 1 (Knowledge of Scientific Concepts and Principles) because it requires recalling that a gel functions as a molecular sieve and applying that basic principle to explain why a matrix is required.', 'easy', '5C', 'Separations and Purifications', 'biochemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'attributes the matrix''s size-based role to charge instead' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'confuses the passive gel medium with the electric field as the driving force' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'imports affinity/covalent-binding ideas from other separation methods' FROM q;

-- Q5 [Native PAGE] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Native PAGE', 'A researcher runs a purified sample on a native PAGE gel (no SDS, proteins kept folded) and observes a single sharp band. Suspecting the sample might still contain two components, she reruns an identical aliquot on an SDS-PAGE gel and now sees two distinct bands: one at 45 kDa and one at 62 kDa. Assuming both gels ran correctly, which statement best explains why the two-component nature of the sample was hidden on the native gel but revealed on the SDS gel?', '[{"label": "A", "text": "On the native gel the two folded proteins happened to have matching combinations of size, shape, and charge, giving them equal mobility, whereas SDS gives every protein the same charge density and rod shape so they separate strictly by mass."}, {"label": "B", "text": "The native gel denatures proteins into extended chains that all move at one rate, while SDS refolds them so that each compact protein moves according to its own mass."}, {"label": "C", "text": "The SDS gel has larger pores that let the smaller 45 kDa protein pass a component the tighter native gel physically excluded, so only the SDS gel could show both bands."}, {"label": "D", "text": "On the native gel both proteins carried identical net charge, and because electrophoretic mobility depends only on net charge, identical charge alone forced them to comigrate regardless of their masses."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because native PAGE keeps proteins folded, so their migration is set by the combined effect of size (Stokes radius), shape, and net charge — electrophoretic mobility is proportional to charge density, \(U = Q/f\) with \(f = 6\pi\eta R_s\), so \(U \propto Q/R_s\). Two different proteins can therefore have offsetting differences (e.g., the larger protein also carrying more charge) that yield the same overall mobility and a single comigrating band. SDS-PAGE removes charge and shape as variables — SDS coats every protein with a constant charge-to-mass ratio and a uniform rod shape — so mobility becomes a function of mass alone, resolving the 45 kDa and 62 kDa species into separate bands. (Choice A) is correct: it correctly attributes native comigration to a coincidental match in the size/shape/charge combination and attributes SDS resolution to mass-only separation. (Choice B) is incorrect: it reverses the roles of the two techniques — native PAGE preserves the folded (compact) state and SDS-PAGE is the denaturing method that produces extended rod-like chains, not the other way around. (Choice C) is incorrect: differing pore size is not why the components resolved; both proteins entered the native gel and comigrated as one band, and SDS-PAGE separates them by masking charge/shape so mobility tracks mass, not by admitting an otherwise-excluded protein. (Choice D) is incorrect: native mobility does not depend on net charge alone — it depends on charge density (charge relative to size and shape), so equal net charge would not by itself force comigration, and here the proteins differ in mass. Answering this required applying how each separation variable behaves under native versus denaturing conditions to interpret an ambiguous gel result rather than recalling a definition, which reflects Skill 2 reasoning.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'swaps which technique denatures vs. preserves native fold' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'attributes resolution to pore-size/sieving exclusion rather than removal of charge and shape variables' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'treats native mobility as governed by net charge alone instead of charge density (size/shape/charge combined)' FROM q;

-- Q6 [Native PAGE] medium skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Native PAGE', 'A researcher has a crude bacterial lysate containing several soluble proteins, one of which is a metabolic enzyme she wants to isolate in a form that still catalyzes its reaction so she can measure its activity afterward. She plans to resolve the lysate on a polyacrylamide gel, locate the position of her enzyme, physically excise that region of the gel, and elute the protein from the excised slice for an enzymatic assay. To maximize the chance that the eluted protein is still catalytically active, which experimental approach should she use?', '[{"label": "A", "text": "Run the lysate under nondenaturing conditions and cut the target band from an unstained parallel lane, using a stained reference lane only to mark its position"}, {"label": "B", "text": "Run the lysate with sodium dodecyl sulfate added to the sample and gel, then cut the target band directly from the gel after electrophoresis"}, {"label": "C", "text": "Run the lysate under nondenaturing conditions, stain the entire gel with Coomassie Brilliant Blue, then cut the target band directly from the stained gel"}, {"label": "D", "text": "Run the lysate under nondenaturing conditions, stain the entire gel with silver, then cut the target band directly from the stained gel"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because catalytic activity depends on the protein remaining in its folded, native conformation, and the only way to recover an active enzyme is to keep it out of contact with anything that unfolds or chemically fixes it. Nondenaturing (native) PAGE separates proteins while they stay folded and retain their intrinsic charge, so the enzyme in the gel is still potentially functional. The problem is that unstained protein is invisible, and the common stains destroy activity, so the researcher runs a stained reference lane to locate the band and then cuts the corresponding position from an unstained lane, eluting an enzyme that never touched a denaturing stain.

(Choice A) is correct: native conditions preserve the folded, active enzyme, and excising from an unstained lane (localized via a stained reference lane) recovers protein that was never exposed to a denaturing or fixing agent.

(Choice B) is incorrect: sodium dodecyl sulfate is a detergent that coats and unfolds proteins, so although it produces clean size-based separation, the protein cut from the gel is denatured and would not be catalytically active.

(Choice C) is incorrect: Coomassie Brilliant Blue is dissolved in methanol/acetic acid, which fixes (precipitates and immobilizes) the protein in the gel; this fixation denatures the enzyme, so excising from the stained gel yields inactive protein even though the run itself was native.

(Choice D) is incorrect: silver staining likewise requires fixer and developer solutions that chemically modify and immobilize the protein in the gel, so the enzyme cut from the silver-stained gel is denatured and inactive, regardless of the native run.

This question requires Skill 1 (knowledge of scientific concepts) because it asks you to recall that native PAGE keeps proteins folded and functional and that protein stains denature them, then apply that knowledge to select the procedure that recovers active enzyme.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 1, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'believes SDS-PAGE preserves protein function because it gives cleaner separation' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'recognizes native run is needed but forgets that Coomassie fixation denatures the protein' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'recognizes native run is needed but assumes a more sensitive stain (silver) is gentle enough to preserve activity' FROM q;

-- Q7 [SDS-PAGE] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'SDS-PAGE', 'A biochemist analyzes a mixture of four purified proteins. Their properties are tabulated below:

| Protein | Molecular mass (kDa) | Net charge at pH 8.8 | Native shape |
|---------|----------------------|----------------------|--------------|
| P | 25 | strongly negative | globular |
| Q | 25 | slightly positive | rod-like |
| R | 60 | strongly negative | globular |
| S | 60 | slightly positive | rod-like |

The mixture is boiled with excess sodium dodecyl sulfate and a reducing agent, then loaded onto a polyacrylamide gel and run toward the anode. Which outcome is observed?', '[{"label": "A", "text": "P and Q co-migrate as one band, and R and S co-migrate as a second, more slowly moving band"}, {"label": "B", "text": "P and R co-migrate as one band, and Q and S co-migrate as a second, faster-moving band"}, {"label": "C", "text": "All four proteins migrate as four distinct bands whose spacing reflects their differing native shapes"}, {"label": "D", "text": "P migrates fastest and S migrates slowest, with Q and R forming intermediate bands ordered by net charge"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because SDS binds each protein at a constant ratio (about 1.4 g SDS per gram of protein), coating every polypeptide with a large, uniform negative charge that overwhelms the protein''s intrinsic charge and gives all proteins a similar charge density and the same rod-like shape. With charge density and shape held constant, electrophoretic mobility through the sieving gel is set by molecular mass alone. P and Q both have a mass of 25 kDa, so despite their opposite intrinsic charges and different native shapes they acquire the same charge-to-mass ratio and co-migrate; R and S both have a mass of 60 kDa and likewise co-migrate but move more slowly because larger SDS-coated complexes are retarded more by the gel matrix. So the gel resolves two bands, grouped strictly by mass.

(Choice A) is correct: proteins of equal mass (P with Q at 25 kDa; R with S at 60 kDa) co-migrate regardless of their native charge or shape, and the smaller pair moves ahead of the larger pair.

(Choice B) is incorrect: it groups the proteins by net charge (the two "strongly negative" proteins together, the two "slightly positive" together). SDS masks intrinsic charge, so native charge does not determine the banding pattern.

(Choice C) is incorrect: SDS denatures each protein into a rod-shaped complex, eliminating native shape as a variable. Band spacing reflects mass, not the original globular-versus-rod-like conformation.

(Choice D) is incorrect: it treats net charge as a separation variable and predicts four bands. Because intrinsic charge is swamped by SDS, the equal-mass proteins are not resolved from each other, and only two bands appear.

This question requires Skill 2 reasoning: rather than recalling a definition, you apply the principle that SDS standardizes charge density and shape to a novel dataset and predict which proteins co-migrate and in what order.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'separates by intrinsic charge' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'native shape still matters' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'charge as ordering variable' FROM q;

-- Q8 [SDS-PAGE] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'SDS-PAGE', 'A researcher analyzes a purified protein by SDS-PAGE. The intact assembly has an apparent mass of 65 kDa and is built from one copy each of two different polypeptides, chain A (40 kDa) and chain B (25 kDa), which are held together by an inter-chain S–S linkage between a cysteine on A and a cysteine on B. The researcher prepares two identical samples: sample 1 is heated in SDS loading buffer alone, and sample 2 is heated in SDS loading buffer to which dithiothreitol (DTT) has been added. Both samples are then loaded onto the same gel and run against molecular-weight standards. Which band pattern is observed for sample 1 (SDS only) versus sample 2 (SDS + DTT)?', '[{"label": "A", "text": "Sample 1: a single band at 65 kDa; sample 2: two bands, at 40 kDa and 25 kDa"}, {"label": "B", "text": "Sample 1: two bands, at 40 kDa and 25 kDa; sample 2: a single band at 65 kDa"}, {"label": "C", "text": "Sample 1: two bands, at 40 kDa and 25 kDa; sample 2: two bands, at 40 kDa and 25 kDa"}, {"label": "D", "text": "Sample 1: a single band at 65 kDa; sample 2: a single band at 65 kDa"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because SDS is a detergent that denatures the protein and coats it in negative charge by disrupting noncovalent interactions, but it does not break covalent bonds. The inter-chain disulfide is a covalent S–S bond, so in sample 1 (SDS only) chains A and B stay covalently tethered and migrate together as one 65 kDa species. Only in sample 2, where the reducing agent DTT is present, is the disulfide cleaved, releasing chain A and chain B to migrate independently at 40 kDa and 25 kDa. Because SDS makes mobility a function of mass alone (\(\ln M_r\) is linear in \(R_f\)), each freed chain resolves at its own molecular weight.

(Choice A) is correct: without a reducing agent the covalent disulfide survives, giving one 65 kDa band; adding DTT cleaves it, splitting the assembly into 40 kDa and 25 kDa bands.

(Choice B) is incorrect: this reverses the roles of the two lanes. It assumes SDS alone separates the chains and that adding a reducing agent somehow re-links them, but reducing agents cleave disulfides—they do not form them—so the SDS-only lane cannot be the one that shows separated subunits.

(Choice C) is incorrect: this treats SDS itself as capable of breaking the disulfide, so both lanes would show separated subunits. SDS disrupts only noncovalent interactions; the covalent S–S bond persists unless a reducing agent is added, so the SDS-only lane must show a single 65 kDa band.

(Choice D) is incorrect: this assumes the disulfide is never broken under either condition. DTT is a reducing agent added specifically in sample 2, and it does cleave the inter-chain disulfide, so sample 2 must resolve into two subunit bands rather than remaining one 65 kDa band.

By predicting the outcome of a described procedure from the chemical nature of the bonds involved, this question requires reasoning about the design and execution of a research protocol (Skill 2) rather than recalling a definition.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'swapping which lane shows separation and assuming a reducing agent re-forms disulfides' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believing SDS itself cleaves covalent disulfide bonds' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'believing disulfide bonds persist even in the presence of a reducing agent' FROM q;

-- Q9 [SDS-PAGE] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'SDS-PAGE', 'A researcher wants to estimate the molecular mass of a newly isolated globular protein, X. She first runs a native (nondenaturing) polyacrylamide gel loaded with X alongside two mass standards of known molecular weight. On this gel, protein X migrates farther than a standard that is actually lighter than X and less far than a standard that is actually heavier than X, so its position relative to the standards does not track molecular weight. Which change to her procedure would allow her to reliably read protein X''s molecular mass off a plot of the standards?', '[{"label": "A", "text": "Coat the proteins with an anionic detergent so that all species carry a charge proportional to their mass before electrophoresis"}, {"label": "B", "text": "Keep the gel nondenaturing but raise the applied voltage so that migration distance becomes proportional to mass"}, {"label": "C", "text": "Replace electrophoresis with isoelectric focusing so the proteins separate along a pH gradient"}, {"label": "D", "text": "Keep the gel nondenaturing but add a reducing agent to break disulfide bonds before loading"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because migration in a gel depends on charge density and shape, not mass alone; on a native gel each protein keeps its own net charge and folded shape, so position cannot be read as molecular weight (exactly what the data show). Coating every protein with an anionic detergent such as SDS binds in constant proportion to mass (~1.4 g per gram of protein) and masks the intrinsic charges, giving every species the same charge density and a uniform rod-like shape. Mobility then depends only on sieving through the gel, so migration becomes a function of molecular weight alone and mass can be read against the standards.

(Choice A) is correct: normalizing charge density with an anionic detergent removes charge and shape as variables, leaving mass as the sole determinant of migration — the requirement for reading mass off a standard curve.

(Choice B) is incorrect: raising the voltage speeds every protein up but changes nothing about the relationship between mobility and mass; a native protein''s migration still reflects its charge density and shape, so the standards still fail to predict mass.

(Choice C) is incorrect: isoelectric focusing separates proteins by isoelectric point (pI) along a pH gradient, not by size, so it reports the pH at which a protein is neutral — not its molecular mass.

(Choice D) is incorrect: a reducing agent only cleaves disulfide bonds; without a detergent to normalize charge density, the released chains still migrate according to their individual charge and shape, so mass still cannot be read from the standards.

This question requires the Skill 2 ability to reason with a separations concept: recognizing from the failed native-gel data that charge and shape confound size, and selecting the technique that normalizes charge density so that migration reports molecular mass.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'more_force_fixes_it' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'wrong_technique_for_goal' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'necessary_but_insufficient_step' FROM q;

-- Q10 [SDS-PAGE] medium skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'SDS-PAGE', 'A researcher prepares two purified proteins for analysis by SDS-PAGE. Protein X has a native isoelectric point (pI) of 9.2 (a net positive charge at the running buffer pH of 8.6), while Protein Y has a pI of 4.8 (a net negative charge at pH 8.6). Both samples are boiled with excess SDS and β-mercaptoethanol, then loaded into adjacent wells at the top of the gel. When the electric field is applied, in which direction will each protein move through the gel?', '[{"label": "A", "text": "Both proteins move toward the anode (positive electrode)."}, {"label": "B", "text": "Both proteins move toward the cathode (negative electrode)."}, {"label": "C", "text": "Protein X moves toward the cathode and Protein Y moves toward the anode, based on their native charges."}, {"label": "D", "text": "Protein X moves toward the anode and Protein Y moves toward the cathode, based on their native charges."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because SDS is an anionic detergent that binds proteins at a nearly constant ratio (about 1.4 g SDS per gram of protein, one negative charge per SDS molecule), which masks each protein''s intrinsic charge and coats every polypeptide with a large, uniform net negative charge. Because both Protein X and Protein Y become anions once coated, both are driven by the field toward the anode, the positive electrode, regardless of their native pI. Their different native charges no longer determine direction; separation instead occurs by mass (sieving through the gel pores). (Choice A) is correct: after SDS coating, both proteins carry a large net negative charge and therefore both migrate to the anode. (Choice B) is incorrect: it reverses the migration direction. A negatively charged species is attracted to the positive electrode (anode), not the negative electrode (cathode); anions do not move toward the cathode. (Choice C) is incorrect: it assumes the proteins retain and are sorted by their native charges, with the basic Protein X (net positive) moving to the cathode. SDS overwhelms and masks the native charge, so intrinsic pI does not set the direction. (Choice D) is incorrect: although it correctly sends the acidic-coated proteins toward the anode for Protein X, it wrongly sends Protein Y (native negative) to the cathode; both SDS-coated proteins are anionic and move the same way, toward the anode. In terms of the mobility relationship \(v = Ez/f\), the field \(E\) acts on the SDS-imparted negative charge \(z\) to push both proteins toward the anode. This question requires recalling the foundational science concept that SDS confers a uniform net negative charge that dictates a single migration direction toward the anode.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'confuses anode/cathode polarity; sends anions to the negative electrode' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes proteins retain native charge in SDS-PAGE and are sorted by pI' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'applies SDS coating to one protein but reverts to native charge for the other' FROM q;

-- Q11 [Isoelectric Focusing] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Isoelectric Focusing', 'A researcher runs isoelectric focusing on a single purified protein whose isoelectric point (pI) has been measured as 5.2. The gel strip carries a stable linear pH gradient running from pH 3.0 at the left end (positioned at the anode, +) to pH 10.0 at the right end (positioned at the cathode, −). The protein sample is loaded into a well at the position where the local gel pH is 8.0, and a voltage is then applied until the bands stop moving. When the run is stopped, at what final position does the protein band form, and why did it move in that direction from the loading well?', '[{"label": "A", "text": "At the pH 5.2 region, having moved toward the anode because at pH 8.0 the protein carried a net negative charge"}, {"label": "B", "text": "At the pH 5.2 region, having moved toward the cathode because at pH 8.0 the protein carried a net positive charge"}, {"label": "C", "text": "At the pH 8.0 loading well, because the applied field cannot displace a protein already sitting above its pI"}, {"label": "D", "text": "At the pH 3.0 end, because a protein continues migrating toward the anode until it reaches the lowest available pH"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because in isoelectric focusing a protein carries a charge determined by the local pH relative to its own pI, and it migrates until it reaches the point where the gel pH equals its pI and its net charge becomes zero. The protein is loaded at pH 8.0, which is above its pI of 5.2, so more of its ionizable groups are deprotonated than protonated and the protein carries a net negative charge. A net-negative species is pulled toward the positive electrode (the anode), which sits at the low-pH (pH 3.0) end of this gradient. As the band moves toward the anode it passes through regions of steadily decreasing pH; its net negative charge shrinks until, at the pH 5.2 region, the pH matches the pI, the net charge reaches zero, the driving force vanishes, and the band stops and sharpens. So the protein comes to rest at the pH 5.2 region, having migrated toward the anode.

(Choice A) is correct: at the loading pH of 8.0 (> pI), the protein is net negative, so it migrates toward the anode (low-pH end) and halts where pH = pI = 5.2, where the electrophoretic velocity \(v = Ez/f\) goes to zero because the net charge \(z\) becomes zero.

(Choice B) is incorrect: it names the correct final resting pH (5.2) but reverses the charge/direction reasoning. At pH 8.0, which is above the pI, the protein is net negative, not net positive; a net-positive protein would occur only at a pH below the pI, and it is the net-negative form here that is drawn to the anode rather than the cathode.

(Choice C) is incorrect: the applied field does displace the protein. Only at the exact pH that equals the pI is the net charge zero and the electrophoretic force absent; at pH 8.0 the protein is charged, so \(v = Ez/f\) is nonzero and it migrates until it reaches the pH 5.2 region.

(Choice D) is incorrect: the protein does not run all the way to the lowest-pH (anode) end. As it moves toward lower pH, its net negative charge decreases and reverses sign the moment it crosses its pI; any overshoot toward more acidic pH makes it net positive and pushes it back, so it is focused at the pH 5.2 region rather than accumulating at pH 3.0.

Because this question requires applying the isoelectric-focusing mechanism to a specific loading pH and gradient geometry to predict both the direction of migration and the final resting position, rather than recalling a definition, it engages Skill 2 (Scientific Reasoning and Problem-Solving).', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Correct pI landing point but reversed charge sign / migration direction (thinks pH above pI gives net positive charge and cathode migration)' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Believes a protein already above its pI is immobile / the field cannot move it, confusing the zero-charge condition with the starting position' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'Correct migration direction (toward anode) but no focusing stop; thinks the protein runs to the extreme low-pH electrode end like standard zone electrophoresis' FROM q;

-- Q12 [Isoelectric Focusing] medium skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Isoelectric Focusing', 'A researcher runs a mixture of proteins on an isoelectric focusing gel that has a stable pH gradient (pH 3 at the anode to pH 10 at the cathode). The voltage is left on continuously. Migration velocity in the gel follows \(v = Ez/f\), where \(E\) is the field strength, \(z\) is the protein''s net charge, and \(f\) is its frictional coefficient. After 90 minutes, one protein has settled into a sharp band and stops advancing, even though the voltage remains applied and \(E\) is unchanged across the gel. A probe shows the local pH at that band is 5.8; independent titration measurements give this protein a pI of 5.8, a molecular weight of 45 kDa, and a Stokes radius comparable to the other proteins in the mixture that are still moving. Which statement best explains why this protein has stopped moving?', '[{"label": "A", "text": "At the band position the protein''s net charge is zero, so the field exerts no driving force on it."}, {"label": "B", "text": "At the band position the pore size of the gel matrix has become too small for a 45 kDa protein to pass through."}, {"label": "C", "text": "At the band position the protein has reached the anode and can migrate no farther in that direction."}, {"label": "D", "text": "At the band position the field strength has fallen to zero, so no protein in that region can migrate."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because the mobility relation \(v = Ez/f\) shows that migration velocity is directly proportional to the protein''s net charge \(z\). The band sits where the local pH (5.8) equals the protein''s pI (5.8), and by definition a protein at its pI carries zero net charge—the positive and negative charges exactly cancel into an overall zwitterionic state. With \(z = 0\), the electrical driving force \(F_E = zE\) is zero and \(v = Ez/f = 0\), so the protein stops even though the field is still applied. (Choice A) is correct: it correctly ties the halt to \(z = 0\) at pH = pI, which zeroes the driving term in \(v = Ez/f\). (Choice B) is incorrect: the problem states the Stokes radius is comparable to other proteins that are still migrating, and isoelectric focusing relies on charge, not on a sieving pore-size cutoff, so a size barrier does not explain the halt. (Choice C) is incorrect: the band is at pH 5.8, which is in the middle of the pH 3–10 gradient, not at the anode; the protein stopped in the interior of the gel, not at an electrode boundary. (Choice D) is incorrect: the stem explicitly states \(E\) is unchanged across the gel and the voltage remains applied, so the field is nonzero at the band; the term that goes to zero is \(z\), not \(E\). This question tests Skill 1 (Knowledge of Scientific Concepts and Principles) because it requires recalling that a protein at its isoelectric point has no net charge and applying that fact to the electrophoretic mobility equation to explain why migration ceases.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'conflating IEF with size-based sieving (SDS-PAGE) as the stopping mechanism' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'believing the protein migrates all the way to an electrode rather than to an interior pH = pI band' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'attributing zero velocity to a vanished field (E=0) instead of to zero net charge (z=0)' FROM q;

-- Q13 [Isoelectric Focusing] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Isoelectric Focusing', 'A researcher has a sample containing two distinct proteins, P and Q. Independent characterization shows that both proteins have a molecular weight of 42 kDa, but their measured isoelectric points differ: P has a pI of 5.1 and Q has a pI of 8.4. The researcher runs the mixture on two separate gels — one SDS-PAGE gel and one isoelectric focusing gel — and stains each for total protein. Which outcome is most consistent with the physical basis of each separation?', '[{"label": "A", "text": "The SDS-PAGE gel shows one band, while the isoelectric focusing gel shows two bands."}, {"label": "B", "text": "The SDS-PAGE gel shows two bands, while the isoelectric focusing gel shows one band."}, {"label": "C", "text": "Both gels show two bands, because each protein carries a distinct net charge in both methods."}, {"label": "D", "text": "Both gels show one band, because the proteins share an identical molecular weight."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because the two techniques resolve proteins by different physical properties: SDS-PAGE separates by molecular weight, whereas isoelectric focusing (IEF) separates by isoelectric point (pI). In SDS-PAGE, the detergent binds at a constant ratio (about 1.4 g SDS per gram of protein) and masks the protein''s intrinsic charges, so all complexes carry a similar charge density and \(migration\) depends only on sieving by mass. Because P and Q are both 42 kDa, they co-migrate to the same position and appear as a single band. In IEF, a pH gradient is established and each protein migrates until it reaches the pH equal to its pI, where its net charge is zero and it stops (\(net\ charge = 0\) at the pI). Since P (pI 5.1) and Q (pI 8.4) focus at different positions in the gradient, they resolve into two distinct bands. (Choice A) is correct: SDS-PAGE gives one band (equal mass) and IEF gives two bands (different pI), matching the property each method actually resolves. (Choice B) is incorrect: it reverses the two methods — SDS-PAGE cannot distinguish equal-mass proteins, and IEF (not SDS-PAGE) is what separates by pI, so the band counts are swapped. (Choice C) is incorrect: although both proteins do carry a net charge in a general electric field, SDS-PAGE deliberately swamps intrinsic charge differences with a uniform SDS coat, so charge is not the separating variable there; the equal masses make them co-migrate as one band. (Choice D) is incorrect: it correctly predicts the SDS-PAGE result but wrongly assumes IEF also depends on mass — IEF ignores mass and separates by pI, so the differing pIs still yield two bands. This is a Skill 2 question because it requires applying the distinct separation principles of SDS-PAGE and IEF to predict experimental outcomes from given mass and pI data, rather than recalling a definition.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Swaps which technique separates by mass vs. pI' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Believes intrinsic protein charge governs SDS-PAGE migration' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'Correct for SDS-PAGE but assumes IEF also depends on mass' FROM q;

-- Q14 [Isoelectric Focusing] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Isoelectric Focusing', 'A researcher performs isoelectric focusing on a mixture of two purified proteins in a gel strip. Before the sample is loaded, ampholytes establish a stable linear pH gradient that runs from pH 3.0 at the anode to pH 10.0 at the cathode. Protein X has an isoelectric point of 5.2, and Protein Y has an isoelectric point of 8.4. Both proteins are applied together at a single point in the middle of the strip, and a voltage is then applied until each protein reaches a stable position. When the run is complete, where are the two proteins located relative to the electrodes?', '[{"label": "A", "text": "Protein X comes to rest closer to the anode, and Protein Y comes to rest closer to the cathode."}, {"label": "B", "text": "Protein X comes to rest closer to the cathode, and Protein Y comes to rest closer to the anode."}, {"label": "C", "text": "Both proteins continue migrating to the cathode and concentrate together at that end of the strip."}, {"label": "D", "text": "Both proteins continue migrating to the anode and concentrate together at that end of the strip."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' In isoelectric focusing, a stable pH gradient is set up in the gel, and each protein migrates until it reaches the position where the local pH equals its isoelectric point (pI), the pH at which the protein carries no net charge; there it stops. A protein sitting where the pH is below its pI is protonated and positively charged, so it moves toward the cathode (the higher-pH end); a protein where the pH is above its pI is negatively charged and moves toward the anode (the lower-pH end). The answer is A because the gradient runs from low pH at the anode (3.0) to high pH at the cathode (10.0), so the protein with the lower pI focuses at the more acidic position nearer the anode, and the protein with the higher pI focuses at the more basic position nearer the cathode.

(Choice A) is correct: Protein X (pI 5.2) stops where the gradient reaches pH 5.2, which is toward the low-pH (anode) side; Protein Y (pI 8.4) stops where the gradient reaches pH 8.4, which is toward the high-pH (cathode) side. The protein with the lower pI ends up nearer the anode.

(Choice B) is incorrect: this reverses the mapping between pI and the pH gradient. Because pH increases from anode to cathode, the lower-pI protein (X) must focus nearer the low-pH anode, not the cathode, and the higher-pI protein (Y) must focus nearer the high-pH cathode, not the anode.

(Choice C) is incorrect: proteins do not migrate indefinitely to one electrode in isoelectric focusing. Once a protein reaches the pH equal to its pI, its net charge is zero and the electric field no longer drives it, so it halts. Only a protein whose entire local environment stayed below its pI would keep heading toward the cathode, which is not the case here since the gradient spans both proteins'' pI values.

(Choice D) is incorrect: for the same reason as Choice C, neither protein piles up at an electrode. Migration stops at the position where pH = pI, and because pH 5.2 and pH 8.4 both lie within the 3.0–10.0 gradient, each protein comes to rest at a distinct interior position rather than accumulating together at the anode.

To answer this question, you had to apply your understanding of how a pH gradient and the concept of isoelectric point together determine each protein''s final resting position, using the given pI and endpoint pH values to predict the outcome rather than recall a definition.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Flips the pI-to-pH-gradient mapping, placing the lower-pI protein at the cathode and the higher-pI protein at the anode' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Treats IEF like standard electrophoresis where charged species migrate all the way to an electrode, ignoring that migration stops at pH = pI' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Same continued-migration-to-an-electrode error as C but directed to the opposite electrode, ignoring the pI = pH stopping point' FROM q;

-- Q15 [Chromatography] medium skill1 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Chromatography', 'A biochemist loads a mixture of four purified proteins onto a cation-exchange column packed with carboxymethyl (CM) resin, which bears covalently attached negatively charged –OCH₂COO⁻ groups. The column is equilibrated and run in a buffer held at pH 6.0, and the proteins are then eluted using a gradually increasing NaCl gradient. The isoelectric points (pI) of the four proteins are:

• Protein W: pI = 5.0
• Protein X: pI = 6.5
• Protein Y: pI = 8.0
• Protein Z: pI = 9.5

The proteins differ only in surface charge; assume no other interactions with the resin. Which protein requires the highest salt concentration to elute (i.e., has the longest retention on the column)?', '[{"label": "A", "text": "Protein W, because at pH 6.0 its surface charge produces the extreme in charge magnitude of the set"}, {"label": "B", "text": "Protein X, because at pH 6.0 its pI lies closest to the buffer pH of the mobile phase"}, {"label": "C", "text": "Protein Y, because at pH 6.0 it carries an intermediate net charge among the bound proteins"}, {"label": "D", "text": "Protein Z, because at pH 6.0 it carries the strongest net charge attracting it to the resin"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' Retention on a chromatography column reflects how strongly a compound interacts with the stationary phase: the more tightly a solute binds the resin, the more mobile-phase strength (here, salt) is needed to displace it, so it elutes last. On a cation exchanger, the stationary phase carries fixed negative charges, so binding strength scales with a protein''s net positive charge. A protein is net positive when the buffer pH is below its pI, and it becomes more positive the further pH sits below pI.

The answer is D because at pH 6.0 Protein Z (pI 9.5) is the farthest below its pI, giving it the largest net positive charge and therefore the strongest electrostatic attraction to the negatively charged CM resin; it binds most tightly, so it requires the highest salt concentration to elute and has the longest retention.

(Choice A) is incorrect: Protein W has pI 5.0, so at pH 6.0 (above its pI) it is net negatively charged. It is repelled by the negative resin, does not bind, and washes straight through with the earliest (shortest) retention. Its pI being the set extreme does not translate into strong binding, because the sign of the charge, not the mere distance from the buffer pH, determines whether it interacts at all.

(Choice B) is incorrect: Protein X (pI 6.5) is only slightly below its pI at pH 6.0, so it carries a small net positive charge. Being closest to the buffer pH means the weakest positive charge and the weakest resin interaction, so it elutes early at low salt — the reverse of longest retention.

(Choice C) is incorrect: Protein Y (pI 8.0) is net positive and binds, but its charge magnitude at pH 6.0 is intermediate between X and Z. It binds more tightly than X but less tightly than Z, so it elutes before Z and does not have the longest retention.

(Choice D) is correct: Protein Z has the largest net positive charge at pH 6.0, binds the negative resin most strongly, and thus elutes last at the highest salt.

This question requires Skill 1 (knowledge of scientific concepts): recognizing that chromatographic retention time reflects the strength of a solute''s interaction with the stationary phase and applying the charge-versus-pI relationship of ion-exchange chromatography to predict elution order.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 1, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', NULL FROM q;

-- Q16 [Chromatography] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Chromatography', 'A biochemist runs a mixture of three small metabolites (P, Q, and R) through a single chromatography column and measures, for each compound, the ratio of the amount adsorbed to the stationary phase relative to the amount dissolved in the flowing mobile phase at equilibrium. The measured stationary-to-mobile ratios are: P = 0.4, Q = 3.5, and R = 1.2. The column is run under a constant mobile-phase flow, and all three compounds are chemically stable and detected as they exit. In what order do the three compounds first exit (elute from) the column?', '[{"label": "A", "text": "P, then R, then Q"}, {"label": "B", "text": "Q, then R, then P"}, {"label": "C", "text": "R, then P, then Q"}, {"label": "D", "text": "Q, then P, then R"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The stationary-to-mobile ratio reported for each compound is a partition ratio: how strongly the compound sits on the stationary phase versus how much of it travels dissolved in the moving mobile phase. A compound spends time bound to the stationary phase (not moving) and time in the mobile phase (moving with the flow), so the fraction of time it spends in the mobile phase sets how fast it travels down the column. A large stationary-to-mobile ratio means the compound is mostly stuck to the stationary phase, moves little, and takes a long time to reach the end (long retention). A small ratio means the compound rides mostly in the mobile phase, moves quickly, and exits early. Ranking by the ratio: P = 0.4 (smallest, mostly mobile, fastest), R = 1.2 (intermediate), Q = 3.5 (largest, mostly stationary, slowest). Elution order from first-out to last-out is therefore P, then R, then Q.

The answer is A because compounds elute in order of increasing affinity for the stationary phase: the one that partitions most into the mobile phase (P, ratio 0.4) migrates fastest and exits first, followed by R (1.2), and finally Q (3.5), which clings to the stationary phase and is retained longest.

(Choice A) is correct: it orders the compounds by increasing stationary-phase affinity (0.4 < 1.2 < 3.5), which is the same as decreasing mobile-phase residence, so the fastest-migrating compound (P) elutes first and the most-retained compound (Q) elutes last.

(Choice B) is incorrect: this reverses the underlying rule. It treats a high stationary-to-mobile ratio as meaning fast migration, putting Q (3.5) first. In reality, strong binding to the stationary phase holds a compound back, so Q is retained longest and elutes last, not first.

(Choice C) is incorrect: this puts R first, as if the intermediate compound eluted before P. P has the smallest ratio (0.4) and thus the greatest tendency to stay in the mobile phase, so P must migrate faster than R and elute before it. The relative positions of R and P are swapped here.

(Choice D) is incorrect: it leads with Q, the compound with the largest stationary-to-mobile ratio (3.5) and therefore the strongest binding to the stationary phase. This confuses the most-retained compound (the last peak to exit) with the first to elute. High stationary-phase affinity produces the longest retention, so Q must elute last, not first.

This question requires Skill 2 (Scientific Reasoning and Problem-Solving) because the stem supplies partition data and asks you to apply the governing principle of chromatography — that migration speed is set by how a compound distributes between the stationary and mobile phases — to predict an experimental outcome rather than recall a definition.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Believes high stationary-phase affinity causes fast migration (retention rule inverted)' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Correctly retains Q last but misorders the two fast compounds, treating the intermediate ratio as fastest' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'Confuses ''most retained/last peak'' with ''first to exit,'' leading with the strongest binder' FROM q;

-- Q17 [Chromatography] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Chromatography', 'A researcher separates a four-component mixture on a column packed with unmodified silica (a stationary phase covered in exposed –OH groups) using a nonpolar hexane-based mobile phase. The four compounds have identical molecular weights and differ only in their functional groups:

- Compound W: a straight-chain alkane (only C–C and C–H bonds)
- Compound X: an ether (one C–O–C linkage)
- Compound Y: a primary alcohol (one –OH group)
- Compound Z: a carboxylic acid (one –COOH group)

Which compound is collected FIRST as the mobile phase carries the mixture through the column?', '[{"label": "A", "text": "Compound W, the alkane"}, {"label": "B", "text": "Compound X, the ether"}, {"label": "C", "text": "Compound Y, the alcohol"}, {"label": "D", "text": "Compound Z, the carboxylic acid"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because the silica stationary phase is highly polar (its surface is covered in exposed –OH groups that hydrogen-bond and dipole-interact with polar solutes). In this normal-phase setup with a nonpolar hexane mobile phase, a compound is retained in proportion to how strongly it sticks to the polar silica, so the LEAST polar compound spends the least time bound and travels through the column fastest. Ranking the four by polarity: carboxylic acid (–COOH, hydrogen-bond donor and acceptor) > primary alcohol (–OH) > ether (C–O–C, hydrogen-bond acceptor only) > alkane (no polar groups). The alkane (Compound W) interacts least with the silica –OH groups, so it is swept along by the nonpolar mobile phase and elutes first.

(Choice A) is correct: the alkane has no polar functional groups, so it barely adsorbs to the polar silica and is carried off the column first by the nonpolar mobile phase.

(Choice B) is incorrect: the ether''s oxygen is a hydrogen-bond acceptor, so it adsorbs to the silica –OH groups more than the alkane does and is retained longer, eluting after the alkane rather than first.

(Choice C) is incorrect: the alcohol''s –OH is both a hydrogen-bond donor and acceptor, giving it strong affinity for the polar silica; it sticks more tightly than the ether or alkane and is one of the last to elute, not the first.

(Choice D) is incorrect: the carboxylic acid is the most polar of the four (–COOH donates and accepts hydrogen bonds strongly), so it binds the silica –OH groups most tightly and elutes LAST — this choice reverses the correct relationship between polarity and elution speed on a polar stationary phase.

This question requires Skill 2 reasoning: rather than recalling a definition, you must rank the four compounds by polarity from their functional groups and then apply the normal-phase principle (on a polar silica column, less polar solutes are retained least and elute fastest) to predict which reaches the collection point first.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'partial_truth', 'correctly identifies the ether as low-polarity but not the lowest; stops one rank short of the fully nonpolar alkane' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'treats the familiar/common –OH group as the ''default fastest'' or confuses the alcohol for the least-interacting species' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'applies the reversed-phase rule (most polar elutes first) or inverts the polarity-vs-retention relationship, picking the most polar as fastest' FROM q;

-- Q18 [Chromatography] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Chromatography', 'A researcher loads a mixture of four purified proteins onto a chromatography column whose resin bears covalently attached quaternary-ammonium (positively charged) functional groups. The column is equilibrated and run entirely with a buffer held at pH 7.0, and elution is then performed with a gradient of increasing NaCl concentration. The isoelectric points (pI) of the four proteins are:

- Protein Q: pI = 4.5
- Protein R: pI = 6.3
- Protein S: pI = 8.1
- Protein T: pI = 9.6

Assuming charge is the only factor governing the separation, which protein is retained most strongly and therefore requires the highest salt concentration to elute?', '[{"label": "A", "text": "Protein Q, because at pH 7.0 it carries the largest net negative charge of the four proteins"}, {"label": "B", "text": "Protein R, because its pI is nearest to the buffer pH, so it interacts with the resin over the longest time"}, {"label": "C", "text": "Protein S, because its pI lies just above the buffer pH, giving it a small positive charge that matches the resin"}, {"label": "D", "text": "Protein T, because at pH 7.0 it carries the largest net positive charge of the four proteins"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The resin carries a fixed positive charge (a quaternary-ammonium group), which makes this an anion-exchange column: it binds molecules of opposite charge, i.e., proteins that are net negatively charged at the operating pH. A protein''s net charge is set by the relationship between the buffer pH and its pI — when pH > pI the protein is net negative, and when pH < pI it is net positive. At pH 7.0, only proteins Q (pI 4.5) and R (pI 6.3) have pH above their pI and are therefore net negative; the further the pH is above the pI, the more negative the protein. Proteins S (pI 8.1) and T (pI 9.6) have pH below their pI and are net positive, so they are repelled by the positive resin and wash through without binding.

The answer is A because among the two net-negative proteins, Q sits farthest below the buffer pH (\(\text{pH} - \text{pI} = 7.0 - 4.5 = 2.5\)) versus R (\(7.0 - 6.3 = 0.7\)). Q therefore carries the largest net negative charge, binds the positively charged resin most tightly through the strongest electrostatic attraction, and requires the highest salt concentration in the gradient to displace it — meaning it elutes last.

(Choice A) is correct: Q has the largest gap between pH and pI on the net-negative side, so it is the most negatively charged, binds the anion exchanger most strongly, and elutes at the highest salt.

(Choice B) is incorrect: R is net negative and does bind, but with pI 6.3 it is only weakly negative at pH 7.0 and binds far more loosely than Q; a pI near the buffer pH means a small net charge and weak retention, not the longest interaction.

(Choice C) is incorrect: S has a pI (8.1) above the buffer pH, so at pH 7.0 it is net positive, not positive-because-it-matches-the-resin. A positive protein is repelled by the positive resin and flows through rather than being retained; opposite charges, not like charges, drive binding.

(Choice D) is incorrect: T does carry the largest net positive charge, but on an anion (positive) exchanger a positive protein is repelled and does not bind at all; it elutes first, not last. This choice applies the correct sign logic to the wrong resin polarity.

Because this question requires you to combine the pH-versus-pI rule for net charge with the opposite-charge binding rule of an anion exchanger and then rank binding strength by charge magnitude, it is testing Skill 2: reasoning about scientific principles rather than recalling a definition.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'pI-nearest-pH-means-strongest-retention' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'like-charge-matches-and-binds-resin' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'largest-magnitude-charge-binds-regardless-of-sign' FROM q;

-- Q19 [Chromatography] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Chromatography', 'A research team purifies a cytosolic enzyme using a cation-exchange column packed with carboxymethyl (CM) resin, whose functional groups carry a fixed negative charge. The column is equilibrated and loaded in a buffer at pH 6.0 containing 20 mM NaCl. The enzyme (pI = 8.5) binds tightly to the resin and does not appear in the flow-through, while several contaminating proteins with pI values below 6.0 wash straight through. After the contaminants are removed, the team must recover the intact, correctly folded enzyme in a distinct peak. Which change to the mobile phase would MOST reliably release the bound enzyme from the resin?', '[{"label": "A", "text": "Raise the NaCl concentration to 500 mM while keeping the buffer at pH 6.0"}, {"label": "B", "text": "Replace the running buffer with deionized water to lower the ionic strength"}, {"label": "C", "text": "Lower the buffer pH to 4.0 while keeping the NaCl at 20 mM"}, {"label": "D", "text": "Raise the buffer pH to 7.0 while keeping the NaCl at 20 mM"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because the enzyme is retained by ion-ion attraction between its net positive surface (the loading pH of 6.0 is below its pI of 8.5, so ionizable groups leave it positively charged) and the fixed negative CM groups on the resin. A bound protein held this way is released when small mobile counterions are supplied in excess: raising NaCl to 500 mM floods the column with \(\text{Na}^+\), which competes for and displaces the protein from the resin''s negative sites ("eluted by increasing the Na+ concentration"), freeing the enzyme without altering its charge state or fold.

(Choice A) is correct: increasing the salt concentration supplies abundant \(\text{Na}^+\) counterions that outcompete the protein for the resin''s negative sites, eluting it under mild, non-denaturing conditions that preserve the intact fold.

(Choice B) is incorrect: lowering the ionic strength does the opposite of what is needed. Removing competing counterions strengthens the electrostatic attraction between the still-positive protein and the negative resin, so the enzyme binds even more tightly rather than eluting.

(Choice C) is incorrect: dropping the pH further below the pI protonates additional side chains, making the enzyme MORE positively charged. This deepens its attraction to the negatively charged CM resin and tightens binding instead of releasing it.

(Choice D) is incorrect: this moves pH in the correct direction (toward and past the pI reduces net positive charge) but not far enough. At pH 7.0 the protein is still below its pI of 8.5, so it remains net positive and stays bound; only crossing above the pI would neutralize or reverse its charge.

This question requires Skill 2 reasoning because you must apply your understanding of ion-exchange retention to a specific loading condition, predict the enzyme''s charge state from its pI relative to the buffer pH, and determine which single mobile-phase manipulation actually disrupts the ion-ion interaction holding it to the resin.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'believes diluting or washing with water elutes bound analyte, when lowering ionic strength strengthens the electrostatic binding' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'changes pH in the wrong direction, making the protein more positive and increasing binding rather than releasing it' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'moves pH toward the pI but stops short of crossing it, so the protein stays net positive and remains bound' FROM q;

-- Q20 [Chromatography] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Chromatography', 'A researcher loads a mixture of four purified proteins onto a size-exclusion (gel-filtration) column and elutes it under native (non-denaturing) conditions with a single buffer. The proteins and their properties are:

| Protein | Molecular weight | Shape in native buffer |
|---------|------------------|------------------------|
| P | 55 kDa | Highly elongated (fibrous); its hydrodynamic radius is comparable to that of a ~120 kDa globular protein |
| Q | 90 kDa | Globular |
| R | 40 kDa | Globular |
| S | 12 kDa | Globular |

None of the proteins interacts chemically with the column matrix, and no protein is large enough to be fully excluded at the void volume together with another. In which order do the four proteins emerge from the column, listed from the first fraction collected to the last?

Note: All molecules move through the column; the question is the order in which they exit.', '[{"label": "A", "text": "P, then Q, then R, then S"}, {"label": "B", "text": "Q, then P, then R, then S"}, {"label": "C", "text": "S, then R, then Q, then P"}, {"label": "D", "text": "Q, then R, then S, then P"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because size-exclusion chromatography separates molecules by their effective (hydrodynamic) size, and larger molecules elute first. The porous beads admit small molecules into the pores, forcing them to take a longer path through the column, while molecules too large for the pores flow only in the space around the beads and take the shortest path out. Elution order therefore runs from largest effective size (first) to smallest (last). Ranking by effective size: protein P is fibrous with a hydrodynamic radius like a ~120 kDa sphere (largest, elutes first), then Q at 90 kDa, then R at 40 kDa, then S at 12 kDa (smallest, elutes last). This gives P, Q, R, S. Because the run is non-denaturing, shape still contributes, so P''s elongation—not its 55 kDa mass—governs its position.

(Choice A) is correct: ordering by effective size (P ~120 kDa-equivalent > Q 90 > R 40 > S 12) with the largest eluting first matches the size-exclusion principle.

(Choice B) is incorrect: this ranks the proteins by molecular weight alone (Q 90 > P 55 > R 40 > S 12). Under native conditions, elution tracks hydrodynamic size, and P''s elongated shape makes it behave as the largest species, so it must elute before Q despite P''s smaller mass.

(Choice C) is incorrect: this is the reverse order, placing the smallest protein first. It mistakenly treats size-exclusion like a method in which small molecules travel fastest; in fact small molecules are delayed inside the pores and elute last.

(Choice D) is incorrect: this correctly starts with the largest globular protein but places the fibrous protein P last, as if its elongated shape caused it to be retained. Shape increases P''s effective size (larger \(R_S\)), which speeds elution rather than delaying it, so P must elute first, not last.

Skill 2 is tested here because you must apply the mechanism of size-exclusion chromatography to novel data—using the given hydrodynamic-size information rather than raw molecular weights—to predict the elution order.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'ignores_shape_uses_mass_only' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'small_elutes_first_reversal' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'elongation_causes_retention' FROM q;

-- Q21 [Chromatography] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Chromatography', 'A researcher loads a mixture of three globular proteins onto a chromatography column packed with porous beads whose pores admit molecules smaller than about 80 kDa. The proteins are thyroglobulin (669 kDa), ovalbumin (44 kDa), and ribonuclease A (14 kDa). A single buffer is passed continuously through the column, and fractions are collected in the order they leave the column. In which fraction does ovalbumin appear relative to the other two proteins?', '[{"label": "A", "text": "It leaves the column after thyroglobulin but before ribonuclease A."}, {"label": "B", "text": "It leaves the column before both thyroglobulin and ribonuclease A."}, {"label": "C", "text": "It leaves the column after both thyroglobulin and ribonuclease A."}, {"label": "D", "text": "It leaves the column at the same time as thyroglobulin, ahead of ribonuclease A."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The column described is a size-exclusion (gel-filtration) column: molecules too large for the bead pores are excluded from the internal volume and travel through the void volume around the beads, so they elute quickly, whereas smaller molecules that enter the pores follow a longer path and elute later. Elution order therefore runs from largest to smallest. Ranking the three proteins by mass gives thyroglobulin (669 kDa) > ovalbumin (44 kDa) > ribonuclease A (14 kDa), so ovalbumin elutes second—after the excluded thyroglobulin and before the smaller ribonuclease A.

The answer is A because ovalbumin (44 kDa) is the intermediate-sized protein: it partly enters the pores (it is below the ~80 kDa cutoff) but is larger than ribonuclease A, so it accesses less of the internal pore volume and travels a shorter path than the smallest protein. Thyroglobulin (669 kDa) exceeds the pore-admission limit, is excluded, and elutes first; ribonuclease A (14 kDa) samples the pores most extensively and elutes last. Ovalbumin thus appears in the middle fraction.

(Choice A) is correct: it places ovalbumin after the largest protein (thyroglobulin, excluded and fastest) and before the smallest (ribonuclease A, most retained and slowest), matching the largest-to-smallest elution order.

(Choice B) is incorrect: it claims ovalbumin leaves before both others, which would require ovalbumin to be the largest species. Thyroglobulin (669 kDa) is far larger, is excluded from the pores, and necessarily elutes ahead of ovalbumin, so ovalbumin cannot be first.

(Choice C) is incorrect: it claims ovalbumin leaves after both others, which would require ovalbumin to be the smallest species that samples the pores most extensively. Ribonuclease A (14 kDa) is smaller, takes the longest path, and elutes after ovalbumin, so ovalbumin cannot be last. This choice reflects the reversed assumption that small molecules elute first.

(Choice D) is incorrect: co-elution with thyroglobulin would require both proteins to be excluded from the pores and travel only through the void volume. Ovalbumin (44 kDa) is below the ~80 kDa admission limit, so it does enter the pores and is retarded relative to the excluded thyroglobulin; the two cannot leave together.

This question requires Skill 2 reasoning: rather than recalling a definition, you must apply the size-exclusion elution principle to the given molecular weights and pore cutoff to predict where the intermediate-sized protein appears in the fraction sequence.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'scale_unit_error', 'Misjudges which protein is largest / ignores that 669 kDa exceeds 44 kDa' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'Believes smallest molecules elute first (reversed elution order)' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Assumes any two large-ish proteins are both excluded and co-elute, ignoring the pore cutoff' FROM q;

-- Q22 [Chromatography] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Chromatography', 'A researcher packs a chromatography column with agarose beads to which a small-molecule ligand, biotin, has been covalently attached. A cell lysate containing four proteins is loaded onto the column in buffer, and the column is then washed extensively with the same buffer. The four proteins have the following properties:

| Protein | Molecular weight (kDa) | Net charge at buffer pH | Dissociation constant (Kd) for biotin |
|---------|------------------------|-------------------------|----------------------------------------|
| Q       | 22                     | −4                      | no measurable binding                  |
| R       | 65                     | +3                      | 1 × 10⁻¹⁵ M                            |
| S       | 48                     | −6                      | no measurable binding                  |
| T       | 90                     | +5                      | no measurable binding                  |

After the extensive wash step, which protein is still bound to the column and can subsequently be recovered by adding free biotin to the buffer?', '[{"label": "A", "text": "Protein R, because it forms a specific complex with the immobilized biotin and is therefore retained on the column"}, {"label": "B", "text": "Protein T, because its large molecular weight prevents it from passing through the spaces between the beads"}, {"label": "C", "text": "Protein S, because its strongly negative net charge causes it to adhere to the agarose bead surface"}, {"label": "D", "text": "Protein Q, because its small size lets it enter the beads and become trapped in their interior"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because the column separates proteins by their ability to form a specific, non-covalent complex with the ligand attached to the beads. Only protein R binds biotin (and it does so with an extraordinarily high affinity, Kd = \(1\times10^{-15}\) M), so only R is held on the column while the wash buffer carries the non-binding proteins away. Because the interaction is reversible and specific, R can then be displaced by flooding the column with free biotin, which competes for R''s binding site and releases it into the buffer.

(Choice A) is correct: Retention on this column depends on recognizing and binding the immobilized ligand. R is the only protein with measurable biotin affinity, so it is the only one that resists the wash and is later eluted by free biotin.

(Choice B) is incorrect: A protein''s size does not determine retention here. Separation by the ability of large molecules to pass around beads while small ones enter the pores describes size-based (gel-filtration) behavior, not this ligand-based column. Protein T has no biotin affinity and washes straight through despite being the largest.

(Choice C) is incorrect: Retention on this column is not driven by electrostatic attraction to the resin. Charge-based binding to a charged resin describes a different technique; the agarose here is functionalized with biotin, and S has no biotin affinity, so its negative charge does not keep it on the column—it washes through.

(Choice D) is incorrect: Being trapped inside porous beads by small size again describes a size-based mechanism, not specific ligand binding. Q neither binds biotin nor is retained by size, so it elutes in the wash regardless of its low molecular weight.

To answer this question, you needed to apply your understanding of how an immobilized ligand selectively captures its binding partner to a novel data set, identifying which protein is retained based on its affinity rather than its size or charge.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'confusing_affinity_with_size_exclusion' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'confusing_affinity_with_ion_exchange' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'size_exclusion_pore_trapping_confusion' FROM q;

-- Q23 [Chromatography] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Chromatography', 'A researcher purifies a recombinant kinase using an affinity resin in which a small-molecule inhibitor that binds the kinase''s active site (dissociation constant \(K_d \approx 20\ \text{nM}\)) is covalently linked to the beads. A crude cell lysate is loaded onto the column, and the flow-through and a wash buffer carry away all other proteins, leaving only the kinase retained on the resin. The kinase must be recovered in its native, catalytically active form. Which mobile phase should the researcher pass through the column to release the kinase most effectively while keeping it folded and active?', '[{"label": "A", "text": "A buffer containing a high concentration of the same soluble inhibitor that is attached to the beads"}, {"label": "B", "text": "A buffer with a steadily increasing gradient of sodium chloride concentration"}, {"label": "C", "text": "A buffer identical to the loading buffer but pumped at a much slower flow rate"}, {"label": "D", "text": "A buffer whose beads have a larger pore size than those used in the packed column"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The kinase is held on the resin by a specific interaction between its active site and an immobilized inhibitor; releasing it requires disrupting that one interaction without denaturing the protein.

The answer is A because the immobilized inhibitor and free soluble inhibitor compete for the same active site. Flooding the column with a high concentration of the free inhibitor shifts the binding equilibrium so that the active site becomes occupied by soluble inhibitor rather than the bead-bound one, competitively displacing the kinase off the resin. Because only a gentle, specific ligand competition is used, the protein is eluted in its native, active form.

(Choice A) is correct: adding excess free ligand (the same inhibitor) competitively displaces the bound protein from the affinity resin, the standard gentle elution strategy for affinity chromatography.

(Choice B) is incorrect: a rising salt gradient is the elution method for ion-exchange chromatography, where retention depends on electrostatic attraction to charged resin groups. The kinase here is held by a specific active-site interaction, not by bulk charge, so increasing ionic strength would not reliably break that contact.

(Choice C) is incorrect: slowing the flow rate only lengthens the time the protein spends on the column; it does not change the binding equilibrium. A protein held with \(K_d \approx 20\ \text{nM}\) will remain bound regardless of how slowly buffer is pumped, so it will not elute.

(Choice D) is incorrect: pore size governs separation in size-exclusion chromatography, where molecules are sorted by whether they enter the bead pores. It has no effect on a protein already anchored to the resin through active-site binding, and swapping beads is not an elution step for a packed affinity column.

Skill 2: This item requires reasoning from the described capture mechanism (specific active-site binding to an immobilized ligand) to predict the elution strategy that will selectively and gently release the target, and distinguishing it from elution logic that belongs to other chromatographic modes.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'applies ion-exchange salt-gradient elution to an affinity column' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes changing flow rate alters binding equilibrium rather than just residence time' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'applies size-exclusion pore-size logic to release a bound protein' FROM q;

-- Q24 [Chromatography] medium skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Chromatography', 'A researcher purifying protein X (net charge −4 at the working pH, 30 kDa) finds that a contaminant, protein Y (net charge −4 at the working pH, 80 kDa), co-elutes with X in a single sharp peak during anion-exchange chromatography, so the fraction is still impure. Both proteins are stable and monomeric. To recover pure X in one additional chromatography step, which approach is most likely to separate X from Y?', '[{"label": "A", "text": "Pass the impure fraction over a size-exclusion column, since X and Y differ substantially in molecular weight"}, {"label": "B", "text": "Repeat the anion-exchange step using a shallower salt gradient to sharpen the elution peak"}, {"label": "C", "text": "Switch to a cation-exchange column and elute both proteins with a salt gradient"}, {"label": "D", "text": "Lower the pH so both proteins carry a more positive net charge before reloading the anion-exchange column"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.'' The answer is A because X and Y share the same net charge (−4) at the working pH, so any charge-based method elutes them together; separating them requires a second method that sorts on a property where they actually differ. X (30 kDa) and Y (80 kDa) differ substantially in molecular weight, and size-exclusion chromatography separates proteins by size and shape—large proteins that cannot enter the bead pores elute first, while smaller proteins are retained longer—so this orthogonal step resolves the two.

(Choice A) is correct: switching to a property on which X and Y actually differ (size) lets a second, independent method achieve what the first could not. Combining separations that exploit unrelated properties is what drives a mixture toward purity.

(Choice B) is incorrect: a shallower gradient only fine-tunes resolution along the charge axis. Because X and Y have identical net charge, they respond to salt identically and will continue to co-elute no matter how the gradient is shaped.

(Choice C) is incorrect: cation exchange is still a charge-based separation. Two proteins with the same net charge behave the same on any ion-exchange resin (anion or cation), so this does not exploit a property that distinguishes them.

(Choice D) is incorrect: shifting pH changes the charge of both proteins, but if they have similar charge behavior they will shift in parallel and remain difficult to resolve on a charge column; more importantly, this stays within the same separation dimension rather than adding an independent one.

This question requires Skill 1 (Knowledge of Scientific Concepts and Principles): recognizing that ion-exchange and size-exclusion separate on independent properties (charge vs. size) and applying that a second, orthogonal method is what improves purity when contaminants co-elute in the first.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'believes finer optimization of the same method can resolve species that are identical on that method''s property' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'treats anion vs. cation exchange as an independent dimension when both are charge-based' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'changes conditions of the same (charge) dimension rather than adding an orthogonal one' FROM q;

