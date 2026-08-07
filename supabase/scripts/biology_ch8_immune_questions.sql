-- Biology Chapter 8: The Immune System, standalone questions
-- BATCH 1 of 4 (22 questions): innate immunity.
--   Units: surface and chemical barriers . complement and interferon (framed functionally)
--          . innate cells and inflammation
--
-- Chapter target is 90 questions (not 100): the AAMC outline names only ~12 immune bullets, and
-- Ch6 Respiratory, Ch7 Cardiovascular, Biochem Ch3, Bio Ch1/Ch3/Ch5 already own large parts of the
-- commercial chapter's content. See the verification report for the full boundary map.
--
-- SCOPE CONVENTION FOR THIS CHAPTER: entities the AAMC outline does not name (complement, interferon,
-- natural killer cells, dendritic cells, granulocyte subsets, isotypes) are described functionally and
-- are never required as recalled vocabulary. The discriminator is always an outline-named principle:
-- innate vs adaptive, self vs nonself, antigen presentation, binding specificity, or clonal selection.
--
-- !! BATCH 1 OWNS THE CHAPTER DELETE !! Batches 2-4 are pure INSERTs and run after this file.

BEGIN;

DELETE FROM public.questions WHERE topic = 'The Immune System';

-- Q1 . Skin as a Physical Barrier . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Skin as a Physical Barrier$q$,
    $q$An investigator applies a suspension of a harmless soil bacterium to a volunteer's intact forearm skin and to an adjacent patch where the outermost dead cell layer has been scraped away. Viable bacterial counts in the underlying tissue rise only at the scraped patch. The outcome at the intact patch is most likely explained by which of the following?$q$,
    $q$[{"label":"A","text":"The layer acts against the applied cells only after a previous encounter with that species."},{"label":"B","text":"The layer acts against the applied cells more effectively with each successive application."},{"label":"C","text":"The layer acts against the applied cells without regard to previous encounters."},{"label":"D","text":"The layer acts against the applied cells by way of phagocytes in the tissue below."}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the outer keratinized layer stops the applied cells on structural grounds that cannot vary with what the volunteer has met before. The topmost layer of the epidermis is a tightly connected, dense sheet of dead, keratin-filled cell husks, and a sheet of dead cells carries no receptors and therefore no capacity to distinguish one organism from another. Defenses built into the tissue in this way do not target any specific organism; they act against a wide range of them. Removing that sheet by scraping was the only variable that differed between the two patches, and removing it was sufficient to let viable counts rise in the tissue below. The exclusion measured at the intact patch is therefore a mechanical outcome rather than a recognition-dependent one. (Choice A) This makes surface exclusion conditional on a prior encounter, which imports the behavior of the lymphocyte-based arm into a structure that has no recognition machinery. A layer of dead keratin-filled husks cannot sample an organism or compare it with anything met earlier. Defenses of this kind are described as nonspecific precisely because they do not target any particular organism. (Choice B) This assigns progressive improvement to a structure. Built-in defenses are not acquired over time and do not improve after repeated exposures, so a sheet of dead cells cannot become better at handling one organism. The single application described also provides no repeated measurements from which such a trend could be read. (Choice C) The layer denies entry by physical construction, so its performance does not depend on what the volunteer has met before. Scraping it away removed the only variable that differed between the patches, which is why counts rose there and not at the intact site. (Choice D) Phagocytes ingest and kill organisms that have already penetrated the first-line barriers, so their action is a step that follows entry rather than a means of preventing it. The scraped patch sat over the same tissue and therefore the same available phagocytes, yet counts rose there, so cells in the tissue below cannot be what distinguished the two sites. Attributing the intact-patch result to them confuses clearance after entry with exclusion at the surface. This is a Scientific Reasoning and Problem Solving question because you must infer, from the difference between an intact and a scraped skin surface, which category of defense produced the outcome.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$specificity transplanted onto a structural barrier$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$memory attributed to a built-in defense$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$post-entry clearance offered as the mechanism of surface exclusion$q$ FROM q;

-- Q2 . Gastric Acid as a Chemical Barrier . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Gastric Acid as a Chemical Barrier$q$,
    $q$A volunteer takes a medication that raises the pH of stomach fluid from about \( 2 \) to about \( 6 \). In a standardized challenge with an acid-sensitive bacterial species, the number of viable cells recovered from the small intestine rises roughly one hundredfold. Which additional outcome is most likely while the volunteer continues taking the medication?$q$,
    $q$[{"label":"A","text":"Recovery of a second, unrelated acid-sensitive species also rises."},{"label":"B","text":"Recovery rises only for acid-sensitive species the volunteer previously ingested."},{"label":"C","text":"Recovery of the acid-sensitive species falls to baseline within hours as specific antibody appears."},{"label":"D","text":"Recovery of the acid-sensitive species falls to baseline over repeated challenges."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the defense the medication removed acts on a chemical property shared by many ingested organisms rather than on features unique to one species. Highly acidic gastric fluid kills most ingested microbes, and that killing depends on the hydrogen ion concentration of the fluid rather than on any recognition of the organism. Raising the pH from about \( 2 \) to about \( 6 \) lowers the hydrogen ion concentration roughly ten thousandfold, so any swallowed organism with the same acid sensitivity gains the same reprieve. A second, structurally unrelated organism of that kind should therefore also be recovered in greater numbers. Defenses of the specific arm behave in the opposite way, because they are directed at one organism and leave others untouched. (Choice A) The barrier that was weakened is chemical and undiscriminating, so the benefit extends to any swallowed organism with the same acid sensitivity, including one structurally unrelated to the challenge species. Nothing about raising the pH restricts the effect to the organism used in the challenge. (Choice B) This restricts the effect to organisms swallowed before, which is the behavior of the specific arm rather than of gastric fluid. Adaptive immunity is defined by specificity and memory, and gastric acidity has neither property. An organism swallowed for the first time benefits from the raised pH exactly as a familiar one does. (Choice C) Specific antibody is not detectable in serum until roughly \( 10 \) days after a first encounter, so no such antibody could act within hours. Even if antibody were present, it would not restore the acidity of gastric fluid, which is the variable the medication changed. The timescale in this option is off by orders of magnitude. (Choice D) A chemical barrier does not strengthen with repetition, so recovery would not decline challenge by challenge while the medication continues to hold the pH near \( 6 \). Improvement on re-exposure is a property of the specific arm. The manipulated variable here is gastric acidity, which repeated challenges do not restore. This is a Scientific Reasoning and Problem Solving question because you must predict how loss of an undiscriminating chemical barrier affects a second, unrelated ingested organism.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$specificity imposed on a chemical barrier$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$adaptive timeline compressed from days to hours$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$memory attributed to a chemical barrier$q$ FROM q;

-- Q3 . Colonization Resistance by Resident Flora . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Colonization Resistance by Resident Flora$q$,
    $q$A broad-spectrum antimicrobial course reduces the resident bacterial population of a volunteer's large intestine by roughly \( 99\% \). Over the following week, a drug-resistant species that had been present at low numbers becomes the dominant organism, and no antibody specific for that species is detectable before or after treatment. Which of the following most likely explains its expansion?$q$,
    $q$[{"label":"A","text":"The antimicrobial directly stimulated division of the resistant species."},{"label":"B","text":"The depleted residents had been presenting antigen to lymphocytes."},{"label":"C","text":"The depleted residents had sustained a memory response against the species."},{"label":"D","text":"The depleted residents had occupied binding sites and consumed nutrients."}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the resident population had been holding the resistant species down by occupying the surfaces it needs and consuming the nutrients it requires. Resident organisms act as a first-line defense through their occupation of cellular binding sites and their competition for available nutrients, which blocks the early attachment and proliferation steps a newcomer must complete in order to establish itself. Removing \( 99\% \) of that population releases both the surface real estate and the nutrient supply, and the resistant species is by definition still present and still viable. The stated absence of specific antibody at every time point rules out any explanation routed through the specific arm. What changed was the competitive environment, not the state of any lymphocyte population. (Choice A) An antimicrobial agent inhibits or kills susceptible cells, and being unaffected by such an agent is not the same as being driven to divide by it. Nothing in the scenario supplies a growth signal to the resistant species. Its expansion followed the removal of its competitors rather than any positive action of the drug upon it. (Choice B) Resident bacteria in the intestinal lumen are not the host cells that display antigen to lymphocytes, so depleting them does not remove antigen presentation. The scenario also states that no antibody specific for the expanding species is detectable at any point, so the specific arm was never engaged against it. This substitutes an antigen-handling step for an ecological one. (Choice C) There is no specific response against this species to lose, because no specific antibody is detectable before or after treatment. Resident organisms compete with newcomers for binding sites and nutrients rather than maintaining a programmed response against them. The suppression that was lifted was competitive rather than lymphocyte-based. (Choice D) With the competing population reduced by \( 99\% \), binding sites and nutrients that had been unavailable become accessible, permitting the attachment and proliferation steps that were previously blocked. This mechanism requires no prior encounter and no specific antibody, which matches every measurement given. This is a Scientific Reasoning and Problem Solving question because you must use the absence of a specific antibody response to select the mechanism that accounts for a resistant organism overgrowing a depleted resident population.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$drug recast as a growth stimulus rather than as a remover of competitors$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$antigen handling substituted for ecological competition$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$a specific memory response invented where the data exclude one$q$ FROM q;

-- Q4 . Defence Timeline After a Breach . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Defence Timeline After a Breach$q$,
    $q$Two volunteers receive identical small puncture wounds that introduce the same bacterial species, which neither has encountered before, and volunteer 2 has no functional lymphocytes. In volunteer 1, phagocytes accumulate at the wound within \( 6 \) hours and serum antibody specific for that species appears at about day \( 10 \). Compared with volunteer 1, volunteer 2 most likely shows which pattern?$q$,
    $q$[{"label":"A","text":"No phagocyte accumulation at \\( 6 \\) hours and no specific antibody at day \\( 10 \\)."},{"label":"B","text":"Phagocyte accumulation at \\( 6 \\) hours and no specific antibody at day \\( 10 \\)."},{"label":"C","text":"Phagocyte accumulation near day \\( 10 \\) and specific antibody at day \\( 10 \\)."},{"label":"D","text":"Phagocyte accumulation at \\( 6 \\) hours and specific antibody before day \\( 10 \\)."}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because phagocyte recruitment to a breached surface proceeds without lymphocytes, whereas the appearance of specific antibody does not. A puncture through the skin creates a point of entry, and phagocytes provide a swift, effective defense against a broad range of microbes as a critical component of innate nonspecific immunity, so their accumulation does not wait on any lymphocyte. Antibody directed at one particular species is produced by B lymphocytes, and the first specific antibody is not measurable in serum until roughly \( 10 \) days after a first encounter. A volunteer lacking functional lymphocytes therefore keeps the hours-scale phagocyte response but cannot generate the day-scale specific one. Sorting the two measurements by their cellular requirement is what the comparison asks for. (Choice A) Losing phagocyte accumulation as well would require a defect in the rapid arm, which the scenario does not specify. Phagocytes are recruited to a breached surface independently of lymphocytes, so their arrival at \( 6 \) hours should be preserved in volunteer 2. Only the lymphocyte-dependent output is expected to fail. (Choice B) The hours-scale phagocyte response is intact because it does not require lymphocytes, while specific antibody cannot appear because the cells that produce it are absent. This is exactly the dissociation the two-volunteer comparison is built to reveal. (Choice C) Delaying phagocyte arrival to day \( 10 \) ties the rapid arm to the timing of the specific arm, but the rapid arm is the faster one precisely because it needs no prior encounter and no lymphocyte. This option also grants specific antibody to a volunteer with no functional lymphocytes, contradicting the stated defect. Both halves of the pattern are inconsistent with the scenario. (Choice D) Antibody appearing earlier than day \( 10 \) would mean a faster specific response, which is the opposite of what removing lymphocytes produces. A first encounter carries a lag of roughly \( 10 \) days even when lymphocytes are fully functional. Volunteer 2 should show no specific antibody at all. This is a Scientific Reasoning and Problem Solving question because you must separate which measured outcome after a barrier breach depends on lymphocytes and which does not.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$the rapid arm treated as lymphocyte-dependent$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$the two arms forced onto a single timeline$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$removing lymphocytes made to accelerate the specific response$q$ FROM q;

-- Q5 . Layered Surface Defences and Response Timing . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Layered Surface Defences and Response Timing$q$,
    $q$A standardized suspension of a bacterial species is applied to three skin sites on one volunteer: intact skin, abraded skin, and abraded skin from which resident surface organisms were first removed by a treatment that leaves host cells intact. Viable counts in the underlying tissue at \( 4 \) hours are lowest at the intact site, intermediate at the abraded site, and highest at the abraded and cleared site, while serum antibody specific for the applied species is first detected on day \( 11 \). Which conclusion do these results best support?$q$,
    $q$[{"label":"A","text":"Two separate defenses limited entry at \\( 4 \\) hours, and neither required the response detected on day \\( 11 \\)."},{"label":"B","text":"Two separate defenses limited entry at \\( 4 \\) hours, and both were strengthened by the response detected on day \\( 11 \\)."},{"label":"C","text":"Two separate defenses limited entry at \\( 4 \\) hours, and both acted by engaging lymphocytes at the site."},{"label":"D","text":"One defense limited entry at \\( 4 \\) hours, and its strength was set by the response detected on day \\( 11 \\)."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the three-site gradient identifies two independently removable defenses, and both were already operating a week before any specific antibody existed. Comparing the intact site with the abraded site isolates the contribution of the outer keratinized dead-cell layer, since that is the only variable removed between them. Comparing the abraded site with the abraded and cleared site isolates a second contribution, the resident surface organisms, which limit entry by occupying binding sites and competing for the nutrients a newcomer would otherwise use. Both effects were measured at \( 4 \) hours, whereas specific antibody was not detected until day \( 11 \), so neither effect could have been produced or supported by that later response. A defense that first becomes measurable on day \( 11 \) cannot account for a difference observed on the first day. (Choice A) The gradient across the three sites requires two removable contributors, and the \( 4 \) hour time point precedes the appearance of specific antibody by more than a week, so both contributors acted without it. This is the only reading consistent with both the spatial and the temporal data. (Choice B) The count of defenses is correct, and the two arms of defense do operate together over longer periods, which makes this tempting. However, the counts were taken at \( 4 \) hours, when no specific antibody was present, so the day \( 11 \) response cannot have strengthened anything that was measured. The experiment also provides no counts after day \( 11 \) with which such reinforcement could be tested. (Choice C) The count of defenses is again correct, but neither a sheet of dead keratinized cells nor a resident bacterial population works by recruiting lymphocytes to the site. Both act before any recognition occurs, by denying physical access and by consuming the resources a newcomer requires. Engaging lymphocytes is a step that follows entry rather than a means of preventing it. (Choice D) A single defense cannot generate three distinct count levels from three conditions that differ by two independent manipulations. This option also ties the \( 4 \) hour result to a response first detected on day \( 11 \), reversing the order of events. Both the number of defenses and the causal direction are inconsistent with the data. This is a Data-based and Statistical Reasoning question because you must read a three-condition gradient of viable counts together with a single time point for specific antibody and determine how many defenses acted and whether any depended on the later response.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    120
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$correct count of defenses, impossible timing$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$surface exclusion recast as lymphocyte recruitment$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$a later response made to set an earlier outcome$q$ FROM q;

-- Q6 . Directing a Plasma Protein Cascade to One Surface . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Directing a Plasma Protein Cascade to One Surface$q$,
    $q$A plasma fraction whose channel-forming proteins assemble slowly on any foreign surface is added to a mixed suspension of two structurally unrelated particles, P and Q. The suspension also contains a purified binding protein produced by lymphocytes of an animal previously exposed to P, and assembly is far faster wherever that binding protein has attached. After \(30\) min, channels most likely appear:$q$,
    $q$[{"label":"A","text":"mainly on P, because the binding protein attaches only to surfaces bearing P."},{"label":"B","text":"mainly on Q, because the binding protein shields P surfaces from the cascade."},{"label":"C","text":"equally on P and Q, because the binding protein attaches to any foreign surface."},{"label":"D","text":"mainly on P, because the binding protein suppresses assembly on unrelated surfaces."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because a binding protein made by lymphocytes of an animal exposed to P occupies P surfaces and not those of a structurally unrelated particle, so the accelerated route to channel assembly operates on P alone. The stem supplies two routes to assembly: a slow one that proceeds on any foreign surface, and a fast one that operates wherever the binding protein has attached. Where that protein attaches is fixed by its own binding site, whose shape and charge complement the surface features of the particle the donor animal met. Because P and Q share no structural features, the protein is present on P and absent from Q, so the fast route is confined to P. Q is left with only the slow route and carries far fewer channels at \(30\) min. (Choice A) Correct. The binding protein occupies P surfaces and not the surfaces of a structurally unrelated particle, so only P carries the accelerating attachment. Channels therefore accumulate on P while Q is limited to the slower route. (Choice B) Attachment of a binding protein can in other settings block a step on the surface it covers, which makes shielding a plausible-sounding role. The stem states, however, that assembly is faster wherever this protein has attached, so its presence promotes channel formation on P rather than protecting it. Q is the surface the protein does not occupy, and it is the one left with the slow route. (Choice C) A binding protein produced after exposure to one particle does not attach to every foreign surface, because its binding site accommodates only features that complement it. Structurally unrelated surfaces are not bound, so no acceleration occurs on Q. Equal channel numbers would require an attachment step with no selectivity at all. (Choice D) This choice reaches the right distribution by the wrong route. The binding protein cannot act on a surface it never touches, so it does not suppress assembly on Q, which retains the slow route described in the stem. The difference between the two particles arises from acceleration on P rather than from suppression elsewhere. This is a Scientific Reasoning and Problem Solving question because you must predict where an accelerating attachment occurs from the binding selectivity of a lymphocyte-derived protein.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$attachment read as protective rather than promoting$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$lymphocyte-derived binding protein treated as broadly reactive$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$right distribution, wrong mechanism$q$ FROM q;

-- Q7 . Rigid Cell Walls and Pore-Mediated Lysis . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Rigid Cell Walls and Pore-Mediated Lysis$q$,
    $q$Two cell types are suspended separately in the same dilute buffer and treated with the same pore-forming plasma proteins, and a fluorescent tracer confirms that channels open in both cell types within \(2\) min. Type 1 has only a plasma membrane, while type 2 has a thick rigid wall outside its membrane. The type 1 suspension clears within \(10\) min as cell contents are released, whereas the type 2 suspension stays turbid for hours, a difference most likely arising because the wall:$q$,
    $q$[{"label":"A","text":"prevents the pore-forming proteins from reaching the plasma membrane."},{"label":"B","text":"abolishes the solute concentration difference across the plasma membrane."},{"label":"C","text":"transports the entering solvent back out across the plasma membrane."},{"label":"D","text":"resists the volume increase that would otherwise rupture the cell."}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the wall is a rigid layer outside the membrane that physically limits how far the cell can expand, so the volume gain needed for rupture never occurs. Both suspensions received the same protein preparation and a tracer confirmed open channels in both, so any account that turns on the walled cells never acquiring channels is excluded by the data. With channels open, both cell types face the same inward drive because both sit in the same dilute buffer. What differs is the fate of that drive: the bare membrane of type 1 stretches until it fails, releasing contents and clearing the suspension, while type 2 pushes its membrane against a rigid layer that will not yield. Persistent turbidity means the type 2 cells are still intact particles scattering light. (Choice A) A thick layer outside the membrane can in other settings keep a large assembling complex from reaching the membrane, and that is a genuine mechanism of resistance for such cells. In this experiment, however, a fluorescent tracer shows that channels open in the walled cells within \(2\) min. The data therefore exclude an access-based explanation for this particular result. (Choice B) A wall is a passive structural layer that is porous to small solutes, so it does not sit between the cytoplasm and the buffer as an osmotic barrier. The concentration difference across the plasma membrane is essentially the same for both cell types. The wall changes the mechanical outcome of that difference, not the difference itself. (Choice C) Walls contain no pumps and do no transport work, which is carried out by proteins in the plasma membrane. Even a cell that did export material would be outpaced by solvent entering through wide open channels. Attributing transport to the wall misassigns a membrane function. (Choice D) Correct. The rigid wall resists the expansion that solvent entry would otherwise produce, so the membrane cannot stretch to the point of failure. The cells stay intact and the suspension stays turbid even though channels are open. This is a Scientific Reasoning and Problem Solving question because you must use the tracer and turbidity results to reject an access-based explanation and identify the mechanical limit on cell swelling.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$textbook-true mechanism excluded by the data$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$wall confused with a semipermeable barrier$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$membrane transport function assigned to the wall$q$ FROM q;

-- Q8 . Testing Whether a Plasma Defense Is Tailored to Its Target . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Testing Whether a Plasma Defense Is Tailored to Its Target$q$,
    $q$An investigator proposes that the channel-forming activity of plasma is present before any encounter with a target and is not tailored to a particular target. Plasma can be drawn from animals of any exposure history, two structurally unrelated particles P and Q are available, and destruction of particles can be measured. Which comparison would most directly test that proposal?$q$,
    $q$[{"label":"A","text":"Plasma from unexposed and from P-exposed animals, each assayed against P and Q."},{"label":"B","text":"Plasma from P-exposed animals, assayed against P before and after that exposure."},{"label":"C","text":"Plasma from unexposed animals, assayed against P across a range of plasma dilutions."},{"label":"D","text":"Plasma from P-exposed animals and from Q-exposed animals, each assayed against the particle it met."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because it varies exposure history and target identity at the same time, which is the only arrangement that puts both halves of the proposal at risk. The proposal makes two claims: that the activity is there before any encounter, and that it is not tuned to the target it acts on. Testing the first requires plasma from animals with no history of either particle, and testing the second requires assaying each plasma against a target it has never met alongside one it has. The four combinations that result allow a mismatched condition to be compared directly against a matched one. If destruction is equal across all four, both claims survive; if the matched combination is faster, the activity is tuned after all. (Choice A) Correct. Crossing two exposure histories with two targets produces both matched and mismatched conditions and includes plasma from animals with no history at all. That is the minimum arrangement in which either half of the proposal could fail. (Choice B) Comparing one animal group against a single particle before and after exposure does address whether the activity depends on encounter. With only one target in the design, however, there is no mismatched condition, so tuning to a target cannot be detected. The comparison tests half the proposal and leaves the other half untouched. (Choice C) A dilution series measures how much activity a sample contains and establishes that the assay responds to concentration. It varies neither exposure history nor target identity, which are the two variables the proposal is about. A clean dose response would leave the proposal exactly where it started. (Choice D) Assaying each plasma only against the particle its donor met looks like a controlled pairing but removes the informative condition. Because no plasma is ever tested against a target it has not encountered, matched and mismatched performance can never be compared. Any difference between the two groups would be attributable to the particles rather than to tuning. This is a Reasoning about the Design and Execution of Research question because you must select the arrangement that crosses exposure history with target identity so that both halves of the proposal can fail.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$tests one half of a two-part claim$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$quantity measured instead of the proposed variables$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$matched-only design mistaken for a specificity test$q$ FROM q;

-- Q9 . Self Versus Nonself Discrimination in Plasma . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Self Versus Nonself Discrimination in Plasma$q$,
    $q$Host cells display surface regulatory molecules that strip an assembling plasma-protein channel complex off the membrane before it is complete, whereas foreign particles display none. A host cell line is engineered so that it no longer makes these regulatory molecules and is then placed in fresh plasma. The line is destroyed at the same rate as an unrelated foreign particle, a result best supporting the account that:$q$,
    $q$[{"label":"A","text":"foreign structural features initiate the assembly, and the regulatory molecules only slow one already begun."},{"label":"B","text":"assembly begins on any surface alike, and the regulatory molecules alone determine which cells survive."},{"label":"C","text":"a previous encounter tunes the plasma proteins to one surface, and the regulatory molecules refine that tuning."},{"label":"D","text":"a local rise in plasma protein concentration near foreign material initiates the assembly, and the regulatory molecules blunt it."}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a host cell stripped of the regulatory molecules is destroyed just like an unrelated foreign particle, which shows that survival tracks the display of those molecules rather than any reading of the target as belonging to the body. These plasma proteins begin assembling on essentially any surface they contact, including the body's own. What keeps host cells intact is an actively displayed molecule that dismantles the assembling complex before it is finished. Removing that molecule converts a host cell into a target at the rate seen for a foreign particle, so the discrimination is implemented as the display of a protective marker rather than as detection of foreignness. This is a general design principle in self versus nonself discrimination: the safe state is the marked state, and losing the mark is sufficient to be treated as nonself. (Choice A) If these proteins genuinely read foreign structural features, then removing a regulatory molecule from a host cell should not by itself make that cell a target. The engineered line carries no foreign features and is destroyed anyway. The regulatory molecules are therefore doing the discriminating rather than adjusting the pace of something already under way. (Choice B) Correct. Survival tracks the presence of the regulatory molecules and nothing else, since a host cell that loses them is destroyed at the rate observed for an unrelated foreign particle. Discrimination is therefore based on a displayed marker rather than on any property that distinguishes the target itself. (Choice C) These plasma proteins circulate continuously and act on a first encounter, so no earlier exposure is required and none is recorded. Tuning to a particular surface after exposure describes the specific arm of immunity rather than this one. The engineered host cell line had also never been a target before. (Choice D) The concentration of these proteins is set by continuous production and does not surge selectively around foreign material. Even a local rise would not explain why a host cell becomes vulnerable purely by losing one surface molecule. The determining variable in the experiment is that molecule, not the protein concentration. This is a Scientific Reasoning and Problem Solving question because you must infer from an engineered loss of function how a nonspecific plasma defense separates the body's own cells from everything else.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$foreignness detection with the marker demoted to a modifier$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$memory imported into an always-present defense$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$abundance mistaken for selectivity$q$ FROM q;

-- Q10 . Direction of an Innate Antiviral Signal . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Direction of an Innate Antiviral Signal$q$,
    $q$In a region of tissue where an intracellular agent is replicating, an altered host cell secretes a small soluble protein and then dies. The protein does not reverse the alteration in the cell that produced it, yet over the following hours the appearance of new alterations in that tissue slows. The protein most likely produces this effect by:$q$,
    $q$[{"label":"A","text":"reversing the alteration in cells that already contain the agent."},{"label":"B","text":"binding the agent in the extracellular fluid so that it cannot enter cells."},{"label":"C","text":"inducing a resistant state in nearby cells that are not yet altered."},{"label":"D","text":"entering the circulation to protect cells in tissues far from this site."}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because a signal that cannot help the cell that made it can only reduce new alterations by preparing cells that have not yet been reached. The secreting cell dies, so the slowing of new alterations must come from a change in some other population. The population positioned to matter is the still normal tissue immediately around the dying cell, which lies in the path of the spreading agent. A protein that induces a resistant state in those cells before the agent arrives lowers the number that can be altered, which is exactly the pattern described. The defense is therefore preemptive and directed outward rather than restorative and directed inward. (Choice A) The stem states that the alteration in the producing cell is not reversed, and there is no reason to expect the same protein to reverse it in other cells. A signal capable of repairing altered cells would have rescued its own source first. The death of the producing cell argues against this route. (Choice B) Binding and neutralizing an agent in extracellular fluid is a real defensive strategy, but it is the work of specific binding proteins made by lymphocytes. A short-lived signal released by a dying host cell is better suited to changing the state of nearby cells. Neutralization would also not require the signal to originate from an altered cell at all. (Choice C) Correct. The protein acts on neighboring cells that are still normal and raises their resistance before the agent reaches them. Fewer of those cells can then be altered, which is why the rate of new alterations falls even though the source cell dies. (Choice D) Some signaling molecules do enter the circulation and act at a distance, so this is a real mode of action. It would not, however, explain a fall in new alterations at the site where the agent is actually spreading. Local protection of the cells immediately at risk is the more direct account. This is a Scientific Reasoning and Problem Solving question because you must determine which population a secreted signal must act on for the observed local slowing to occur.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$signal as a cure for cells already affected$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$extracellular neutralization borrowed from the specific arm$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$long-range signalling substituted for local signalling$q$ FROM q;

-- Q11 . Properties of a Broad Antiviral Signal . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Properties of a Broad Antiviral Signal$q$,
    $q$An altered host cell releases a soluble protein that acts on nearby normal cells and lowers the rate at which those cells are subsequently altered. This activity is measurable in animals that have had no previous encounter with the agent. Which of the following would be expected of this protein?

I. Recipient cells also resist a second, structurally unrelated intracellular agent.
II. Recipient cells become protected within hours, sooner than a defense requiring proliferation of a matched lymphocyte population could act.
III. A second encounter with the same agent leaves recipient cells far more strongly protected than the first encounter did.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"III only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I and II only"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because items I and II follow from a defense that is present without prior exposure and acts on the recipient cell's own machinery, while item III describes an improvement with repeated exposure that this kind of defense does not show. The activity is measurable in animals with no history of the agent, which places it among the built-in defenses rather than the ones assembled after exposure. Defenses of that kind are not tailored to a single target, so a resistant state induced in a recipient cell is expected to work against an unrelated agent as well, which supports item I. They also act on a timescale of hours because nothing has to be selected and expanded first, whereas a defense built from a matched lymphocyte population needs days of proliferation, which supports item II. Built-in defenses do not improve on repeated encounter, which is precisely what item III asserts, so item III fails. (Choice A) Item I is indeed expected, since a resistant state built into the recipient cell is not tailored to one agent. Restricting the answer to item I alone discards the timing comparison in item II. Speed is one of the defining features of a defense that requires no prior exposure. (Choice B) Item III describes a stronger response on a second encounter, which is the signature of the arm of immunity that is assembled after exposure and retained. The activity here is present in animals that have never met the agent and does not depend on that history. Selecting item III alone also discards two items that do follow. (Choice C) Item II is correct, because a defense needing no prior selection step acts far sooner than one that must expand a matched population of cells. Item III is not, since improvement across repeated encounters belongs to the specific arm. Pairing a correct item with an incorrect one makes this combination wrong. (Choice D) Correct. Item I follows from the absence of tailoring to a single agent, and item II follows from the absence of any selection and proliferation step. Item III is excluded because a defense that operates without prior exposure does not strengthen with repetition. This is a Scientific Reasoning and Problem Solving question because you must decide which properties follow from a defense that operates without prior exposure and which belong to the specific arm instead.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$correct item, incomplete set$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$memory attributed to a built-in defense$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$true item paired with a false one$q$ FROM q;

-- Q12 . Constitutive Plasma Defenses Versus Induced Specificity . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Constitutive Plasma Defenses Versus Induced Specificity$q$,
    $q$An animal is challenged with foreign particle P on day \(0\) and again on day \(30\). Plasma is assayed for activity X, a set of channel-forming proteins present in plasma from birth, and for activity Y, a P-binding protein produced by lymphocytes.

| Day | X (\(\%\) of day \(0\)) | Y (arbitrary units) |
| --- | --- | --- |
| 0 | 100 | 0 |
| 5 | 103 | 14 |
| 30 | 98 | 9 |
| 35 | 101 | 165 |

The animal meets structurally unrelated particle Q for the first time on day \(60\), and the most likely finding on day \(62\) is that:$q$,
    $q$[{"label":"A","text":"Q is damaged promptly by X, while Y directed at Q is still near \\(0\\)."},{"label":"B","text":"Q is damaged promptly by Y, while X is still near \\(100\\%\\)."},{"label":"C","text":"Q is not damaged until X climbs well above \\(100\\%\\), which takes several days."},{"label":"D","text":"Q is damaged promptly by X, which by day \\(60\\) has climbed well above \\(100\\%\\) after the earlier challenges."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because activity X sits at roughly \(100\%\) of its starting value throughout, including after two challenges, so it is available at once against a target the animal has never met, while activity Y is built only against the particle that induced it. Across the whole table X varies between \(98\%\) and \(103\%\), which is measurement scatter rather than a response, and it rises after neither the first challenge nor the second. Y behaves in the opposite way, appearing modestly after the first challenge and reaching \(165\) units after the second, the pattern of a defense that is assembled against one particular target and then strengthened. When particle Q appears on day \(60\), the animal has no Y directed at Q, because Y is specific to whatever induced it, so any prompt damage to Q must come from the always-present X. Two days is also far too short for a targeted binding protein against Q to reach a meaningful level. (Choice A) Correct. X is present at its usual level and is not tailored to any single target, so it can act on Q immediately. Y directed at Q has not been induced, and day \(62\) is too early for it to have risen. (Choice B) This reverses the roles the table assigns to the two activities. Y is the activity that appears only after a challenge and is directed at the particle that caused it, so no Y against Q exists on day \(62\). X is the activity that is already circulating and can act first. (Choice C) The table shows X holding near \(100\%\) even after two challenges, so there is no evidence that it must be induced before it can act. Treating X as something that has to be built up imports the behavior of Y. Prompt damage to Q does not require any rise in X. (Choice D) The prediction of prompt damage by X is right, but the stated reason contradicts the data. X reads \(98\%\) on day \(30\) and \(101\%\) on day \(35\), showing no accumulation from the earlier challenges. A defense that is effective without changing in amount is not the same as one that has been boosted. This is a Data-based and Statistical Reasoning question because you must read two plasma activity time courses, distinguish scatter from a real change, and extend the pattern to a target the animal has not encountered.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    120
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$roles of the two activities swapped$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$constitutive activity treated as inducible$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$right outcome, data-contradicted reason$q$ FROM q;

-- Q13 . Basis of the Induced Resistant State . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Basis of the Induced Resistant State$q$,
    $q$Normal cells treated with a soluble protein released by altered cells show a \(70\%\) fall in total protein synthesis within \(6\) h. When these treated cells are then exposed separately to two structurally unrelated intracellular agents, both agents replicate poorly in them. No lymphocytes are present in the cultures, and the protection observed is best explained as arising from:$q$,
    $q$[{"label":"A","text":"loss of a host resource needed by the first agent only, with the second agent blocked at the cell surface."},{"label":"B","text":"loss of a host resource that both agents must use, rather than an attack on either agent."},{"label":"C","text":"direct chemical attack on both agents once they have entered the treated cells."},{"label":"D","text":"display of agent fragments on the treated cell surface for recognition by other cells."}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a broad fall in the treated cell's own protein synthesis removes machinery that any intracellular agent must borrow, which explains why two agents with nothing structural in common both replicate poorly. The treated cells are not attacking anything; what changed is a general property of the host cell. Intracellular agents cannot make their own proteins and must use the host cell's synthetic machinery, so a cell running at a fraction of its normal output is a poor place for any of them to replicate. Because the resource withdrawn is shared by unrelated agents, the protection is broad rather than targeted, which is the hallmark of a defense that requires no prior exposure. The cost of that strategy is that the treated cell also gives up much of its own biosynthesis. (Choice A) Protection here is not agent specific, since two structurally unrelated agents replicate poorly in the same treated cells. Invoking one mechanism for one agent and a separate surface block for the other is unnecessary and unsupported by the data. A single shared explanation accounts for both results. (Choice B) Correct. The treated cell loses much of the biosynthetic capacity that any intracellular agent must use, so replication of unrelated agents falls for the same underlying reason. Nothing in the data requires the treated cell to attack either agent directly. (Choice C) A direct chemical attack would have to recognize something about the agent, and it is unlikely that one activity would attack two unrelated agents equally well. The measured change is in the host cell's own synthesis rather than in any agent-directed activity. The breadth of the effect points away from targeted attack. (Choice D) Display of fragments on a cell surface is a real event in host defense, but it works by signaling to other cells that something is wrong inside, and no cells able to receive that signal are present in these cultures. The observed effect is reduced replication inside the treated cells themselves. Surface display would not lower replication in a culture that contains nothing able to respond to it. This is a Scientific Reasoning and Problem Solving question because you must connect a broad reduction in host biosynthesis to protection against agents that share no structural features.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$two mechanisms invented for one broad effect$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$host-directed change read as agent-directed attack$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$real defense that cannot operate in this culture$q$ FROM q;

-- Q14 . Chemotaxis and Gradient Sensing . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Chemotaxis and Gradient Sensing$q$,
    $q$Phagocytes are placed in the central well of a migration chamber that has one side well at each end. With no attractant anywhere few cells leave the center, while attractant in the left side well alone draws many cells into that well; the assay is then repeated with the same amount of attractant also added to the central well.

In this third condition, phagocyte accumulation in the left side well will most likely be:$q$,
    $q$[{"label":"A","text":"above the second condition value, because more attractant is present overall."},{"label":"B","text":"above the second condition value, because attractant contact begins sooner."},{"label":"C","text":"near the first condition value, because no spatial cue remains."},{"label":"D","text":"near zero, because raised attractant levels repel phagocytes."}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because directed migration is driven by a spatial difference in attractant level across the cell, so flooding the starting well erases that difference and accumulation falls back toward the no-attractant baseline. A phagocyte travels by extending pseudopodia in an amoeboid fashion, and it steers by comparing how much attractant reaches one side of itself with how much reaches the other. Net movement toward a source continues only while that comparison favors one direction. When attractant sits at the same level in the starting compartment and in the destination compartment, every direction looks alike to the cell, so pseudopod extension is equally likely on all sides and travel becomes undirected. Accumulation in the left well therefore collapses toward the value obtained when no attractant was present at all.

(Choice A) Total exposure to attractant is indeed greater in the third condition, but total exposure is not what steers a cell. Adding attractant to the starting well raises the amount present while abolishing the difference between compartments, and it is that difference which produces net accumulation.

(Choice B) Contact with attractant does begin sooner when the chemical is already in the starting well, but the timing of first receptor occupancy does not establish a direction. A cell occupied equally on all sides extends pseudopodia in every direction and ends up scattered rather than concentrated in one well.

(Choice C) With attractant at the same level in the starting well and in the left well, no spatial difference remains for the cell to read, so migration is undirected. Accumulation in the left well should therefore approach the count obtained in the first condition, in which no attractant was present anywhere.

(Choice D) Uniformly high attractant levels can saturate surface receptors and blunt responsiveness, but saturation removes direction rather than reversing it. Nothing in this setup would actively drive cells out of the left well, so counts should settle near baseline rather than below it.

This is a Scientific Reasoning and Problem Solving question because you must predict how phagocyte accumulation changes when an attractant is made uniform rather than localized.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$more-is-more$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$wrong-controlling-variable$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$attractant-becomes-repellent$q$ FROM q;

-- Q15 . Phagocyte Size Limits and External Attack . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Phagocyte Size Limits and External Attack$q$,
    $q$A parasitic worm many hundreds of times larger than a leukocyte lodges in connective tissue. Innate leukocytes that store membrane-damaging proteins in internal vesicles bind tightly to the worm.

These bound leukocytes most likely damage the worm by:$q$,
    $q$[{"label":"A","text":"discharging their stored proteins directly onto the target."},{"label":"B","text":"enclosing the worm in a vesicle and digesting it internally."},{"label":"C","text":"removing small pieces of the worm by repeated endocytosis."},{"label":"D","text":"discharging their stored proteins into tissue fluid at a distance."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because a target that cannot fit inside a vesicle cannot be handled by ingestion, so the cell must release its destructive contents outward onto the surface it is touching. Phagocytosis works by wrapping a pseudopod around an object and pinching it off into an internal vesicle, so the targets it can handle are limited to objects small enough to fit inside the cell. Some innate leukocytes carry an internal store of membrane-damaging proteins that can be released into the area around the cell to degrade targets externally. Tight adhesion to the worm is what makes this route useful, because it concentrates the discharge at the point of contact instead of dispersing it. The result is damage to the worm's surface membrane with no ingestion step at all.

(Choice A) Ingestion is not available for an object hundreds of times the size of the cell, so the stored proteins must be delivered outward. Adhesion places the cell against the surface it is attacking, so the released proteins act where they are concentrated rather than being diluted.

(Choice B) Enclosing the worm in a vesicle would require the leukocyte's plasma membrane to surround an object far larger than the entire cell. Internal digestion is the normal route for bacterial-sized particles and cellular debris, not for a multicellular organism.

(Choice C) Nibbling small pieces of surface by repeated endocytosis removes only trace amounts of membrane and cytoplasm and would be far too slow to injure a large organism. It also leaves unexplained why the cell maintains a store of membrane-damaging proteins in the first place.

(Choice D) Releasing the stored proteins into bulk tissue fluid would dilute them below useful concentrations and would expose neighboring host cells to damage. Tight binding exists precisely so that the discharge is aimed at the adjacent surface rather than broadcast.

This is a Scientific Reasoning and Problem Solving question because you must predict how an innate leukocyte attacks a target too large to be enclosed in a vesicle.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$default-to-phagocytosis$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$real-process-wrong-scale$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$right-mechanism-wrong-geometry$q$ FROM q;

-- Q16 . Resident Macrophages as the Source of Recruitment Signals . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Resident Macrophages as the Source of Recruitment Signals$q$,
    $q$A sterile irritant is placed in the dermis of two animals. In one animal the macrophages that normally reside in that patch of dermis have been depleted beforehand, while its circulating leukocytes and their gradient-sensing machinery remain intact.

Six hours later, the depleted site most likely shows:$q$,
    $q$[{"label":"A","text":"a larger influx of circulating leukocytes, because fewer resident cells compete for the irritant."},{"label":"B","text":"an unchanged influx of circulating leukocytes, because they detect the irritant from inside the vessel."},{"label":"C","text":"an unchanged influx of circulating leukocytes, because the irritant itself diffuses out as the attractant."},{"label":"D","text":"a smaller influx of circulating leukocytes, because fewer local signals are produced."}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the recruitment of blood-borne cells into a tissue is initiated by chemical mediators released by the macrophages already living in that tissue, so removing those cells removes most of the summoning signal. Tissue-resident macrophages act as sentries: they detect distress signals from damaged or stressed cells and respond by secreting proinflammatory and chemotactic mediators into the surrounding tissue. Those mediators act on the nearby capillary endothelium and establish the chemical cue that circulating leukocytes follow. Because the circulating cells in this experiment retain a fully functional gradient-sensing apparatus, the limiting factor is the signal rather than the responder. With fewer sentries present, less signal is generated and the six-hour influx is correspondingly blunted.

(Choice A) Competition for a single inert irritant is not what governs the size of a leukocyte influx, and resident cells do not suppress recruitment. Removing the local sentries removes the source of the mediators that draw cells in, so the influx should fall rather than rise.

(Choice B) Circulating leukocytes do not survey the tissue outside the vessel from within the lumen. They respond to mediators that have been generated in the tissue and have reached the vessel wall, which is why local sentry cells are required.

(Choice C) A sterile mineral or chemical irritant is not itself the attractant that guides leukocytes to a site. The attracting molecules are host-derived mediators released by resident cells and by damaged tissue in response to the irritant.

(Choice D) Resident macrophages are the principal early source of the chemotactic mediators that summon blood leukocytes into a tissue. Depleting them leaves the responders intact but starves them of the signal, producing a smaller influx at six hours.

This is a Scientific Reasoning and Problem Solving question because you must trace which step of a recruitment sequence is disabled when the tissue-resident sentries are removed.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$resident-cells-inhibit$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$surveillance-from-the-lumen$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$stimulus-mistaken-for-attractant$q$ FROM q;

-- Q17 . Interpreting a Phagocyte Migration Assay . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Interpreting a Phagocyte Migration Assay$q$,
    $q$Phagocytes are placed in the upper compartment of a two-chamber device separated by a porous filter. A chemical attractant is added to each compartment at the levels shown, and cells reaching the lower compartment are counted after \(90\) minutes.

| Upper compartment \(\left(\text{nM}\right)\) | Lower compartment \(\left(\text{nM}\right)\) | Cells crossing |
| --- | --- | --- |
| \(0\) | \(0\) | \(14\) |
| \(0\) | \(10\) | \(148\) |
| \(0\) | \(100\) | \(305\) |
| \(100\) | \(100\) | \(22\) |
| \(100\) | \(10\) | \(16\) |

Which conclusion is best supported by these counts?$q$,
    $q$[{"label":"A","text":"Crossing rises with the amount of attractant in the lower compartment."},{"label":"B","text":"Crossing depends on the difference between compartments rather than the amount."},{"label":"C","text":"Attractant above \\(10\\ \\text{nM}\\) becomes toxic and suppresses crossing."},{"label":"D","text":"Cells cross toward whichever compartment holds the smaller amount."}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because the two rows that share the same lower-compartment value give opposite results depending on what is in the upper compartment, which isolates the difference between compartments as the controlling variable. Rows three and four both have \(100\ \text{nM}\) below, yet crossing is \(305\) when the upper compartment is empty and only \(22\) when the upper compartment matches it. Rows two and five both have \(10\ \text{nM}\) below, and crossing is \(148\) with an empty upper compartment but \(16\) when the upper compartment is higher. In every condition where the two compartments are equal or the upper value exceeds the lower value, counts fall to the level of the no-attractant control. Directed migration is therefore produced by an imbalance across the filter, not by the quantity of attractant a cell encounters.

(Choice A) This holds within the first three rows but fails at row four, where the lower compartment still contains \(100\ \text{nM}\) and crossing collapses to \(22\). A conclusion that a single row contradicts cannot be the best supported one.

(Choice B) Pairs of rows matched for lower-compartment content differ by more than tenfold in crossing depending on the upper-compartment content. That comparison shows the imbalance across the filter, not the absolute amount, drives migration.

(Choice C) Row three has \(100\ \text{nM}\) in the lower compartment and yields the highest count in the entire table at \(305\). Toxicity at that level would have to suppress crossing in row three as well, so the data rule this out.

(Choice D) Row five places \(100\ \text{nM}\) above and \(10\ \text{nM}\) below, so cells offered a route toward the smaller amount would cross in large numbers. Only \(16\) cells cross, which is baseline, so movement is not directed toward lower amounts.

This is a Data-based and Statistical Reasoning question because you must compare paired conditions in a migration table to identify which variable controls directed movement.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$true-for-a-subset$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$invoke-toxicity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$inverted-gradient-direction$q$ FROM q;

-- Q18 . Distinguishing Resident from Recruited Phagocytes . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Distinguishing Resident from Recruited Phagocytes$q$,
    $q$A researcher asks whether the phagocytes that have engulfed an inert particle \(30\) minutes after it is placed in skin were already in the skin or arrived from the blood. A fluorescent label can be injected intravenously and is taken up only by cells that are inside blood vessels at the time of injection.

Which design would best answer this question?$q$,
    $q$[{"label":"A","text":"Inject the label before placing the particle, then score labeling among particle-containing skin phagocytes."},{"label":"B","text":"Inject the label \\(30\\) minutes after placing the particle, then score labeling among particle-containing skin phagocytes."},{"label":"C","text":"Count particle-containing skin phagocytes immediately before and \\(30\\) minutes after placing the particle."},{"label":"D","text":"Count labeled leukocytes in the blood immediately before and \\(30\\) minutes after placing the particle."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because labeling the blood pool before the challenge marks every cell that could later emigrate, so label status in a particle-containing skin phagocyte reports directly on that cell's origin. The question is one of provenance rather than of number, so the design must tag one candidate population at a moment when the two populations are still separated. Injecting the label first marks only cells inside vessels; any skin phagocyte found \(30\) minutes later carrying both the label and the particle must have crossed out of the circulation, and any unlabeled particle-containing cell must have been resident. This is a single-animal readout that does not depend on comparing totals across time, so it is insensitive to the sampling noise that affects counting approaches.

(Choice A) Pre-labeling establishes an origin marker at a time when blood cells and skin cells are still distinct populations. Scoring label and particle together in the same cell therefore assigns each engulfing phagocyte to a source without further assumption.

(Choice B) Labeling after the particle has been in place for \(30\) minutes marks the blood pool only from that moment onward. Cells that had already emigrated during those \(30\) minutes would carry no label and would be indistinguishable from cells that were resident all along, so the design cannot separate the two possibilities.

(Choice C) A change in the number of particle-containing skin phagocytes says nothing about where those cells came from, because resident cells can also migrate within the tissue toward the particle. The measure is silent on the actual variable of interest.

(Choice D) A change in circulating leukocyte number is an indirect readout that is easily confounded by marrow release, vessel tone, and margination. It never links any individual particle-containing skin phagocyte to a blood origin.

This is a Reasoning about the Design and Execution of Research question because you must choose the labeling schedule that separates cells already present in a tissue from cells that emigrated from the circulation.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$marker-applied-after-the-event$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$measures-quantity-not-origin$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$wrong-compartment-readout$q$ FROM q;

-- Q19 . Vascular Change and Delivery of Plasma Components . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Vascular Change and Delivery of Plasma Components$q$,
    $q$An animal is given a drug that blocks histamine receptors on blood vessel walls, and a sterile splinter is then placed under its skin. One hour later the site shows much less swelling than the same site in an untreated animal.

Which additional finding at the treated site is most likely?$q$,
    $q$[{"label":"A","text":"Reduced internalization of debris by phagocytes already stationed in that tissue."},{"label":"B","text":"Increased blood flow through the vessels that supply the site."},{"label":"C","text":"Reduced accumulation of blood-derived proteins in the tissue around the splinter."},{"label":"D","text":"Reduced numbers of phagocytes circulating in the blood entering the site."}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the same vascular change that produces visible swelling is the change that lets plasma proteins escape into the tissue, so blocking it must reduce both together. Histamine acting on local vessels widens them and increases the permeability of their walls, which allows plasma to leak into the interstitial space. That leakage is not merely a cosmetic side effect of inflammation: it is the route by which blood-derived defensive and repair molecules, including clotting factors, gain access to a damaged site. A drug that blocks the receptors mediating this change therefore reduces the swelling and the delivery of blood-borne protein by a single common mechanism. The tissue's own resident cells are untouched by a drug directed at vascular receptors.

(Choice A) The drug acts on receptors expressed by vessel walls, not on the binding and engulfment machinery of a phagocyte. Cells already stationed in the tissue continue to recognize and internalize debris at their usual rate.

(Choice B) Loss of the vasodilating signal reduces the caliber of local vessels relative to an inflamed control, so local flow falls rather than rises. This is why a blocked site also loses the warmth and redness of the untreated site.

(Choice C) Increased permeability of local vessels is what allows plasma and its dissolved proteins to enter the interstitium, and it is also what produces the swelling. Blocking the receptors that drive that permeability change reduces the interstitial protein load along with the swelling.

(Choice D) The number of phagocytes circulating in blood is set by production in marrow and release into the circulation, neither of which this drug alters. Fewer cells may end up in the tissue, but the blood pool itself is not depleted.

This is a Scientific Reasoning and Problem Solving question because you must infer what else is lost when the vascular permeability change underlying inflammatory swelling is blocked.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$vascular-block-read-as-cell-block$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$flow-increases-when-dilation-blocked$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$wrong-compartment-for-the-effect$q$ FROM q;

-- Q20 . Resident Versus Recruited Populations Over Time . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Resident Versus Recruited Populations Over Time$q$,
    $q$A microbial extract is placed in the dermis of two animals; the second animal first receives a drug that prevents leukocytes from responding to chemical gradients. Cell P normally resides in dermis and cell Q normally circulates in blood, and counts of each per microscope field at the site are shown.

| Time after placement | P, untreated | Q, untreated | P, drug | Q, drug |
| --- | --- | --- | --- | --- |
| \(0.5\ \text{h}\) | \(41\) | \(2\) | \(40\) | \(2\) |
| \(6\ \text{h}\) | \(47\) | \(205\) | \(45\) | \(8\) |

Which conclusion about the cell Q population present at \(6\ \text{h}\) is best supported by these counts?$q$,
    $q$[{"label":"A","text":"It arose from division of the cell Q already at the site at \\(0.5\\ \\text{h}\\)."},{"label":"B","text":"It arose from conversion of resident cell P into cell Q."},{"label":"C","text":"It arrived from the blood along a signal generated at the site."},{"label":"D","text":"It arrived from the blood after bone marrow raised its output."}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the six-hour population appears only when gradient following is intact, which places its origin in the circulation and identifies a locally generated signal as the thing the cells are following. At \(0.5\ \text{h}\) the two animals are indistinguishable, with roughly \(40\) P cells and \(2\) Q cells each, so the earliest cells at the site are the ones that already lived there. By \(6\ \text{h}\) the untreated site holds \(205\) Q cells against \(8\) in the treated site, a difference of more than twentyfold, while P is essentially unchanged in both animals. The only variable separating the animals is the ability to respond to a gradient, so the late Q population must have traveled to the site along a cue generated there rather than having arisen in place. This is the two-phase structure of an innate response: an immediate contribution from stationed cells followed by a much larger recruited wave.

(Choice A) Both animals begin with the same \(2\) Q cells at the site, so local division would be expected to yield comparable six-hour counts in both, which it does not. Expansion from \(2\) to \(205\) in \(5.5\ \text{h}\) would also demand a division rate far beyond what leukocytes achieve.

(Choice B) Cell P is not consumed in either animal, rising from \(41\) to \(47\) untreated and from \(40\) to \(45\) treated. Conversion of P into Q would draw the P count down as Q climbed, and no such drawdown appears in either column.

(Choice C) Equal half-hour counts identify the tissue-dwelling cell as the early responder, and the divergence at six hours shows that the late influx requires an intact gradient response. Cells that must follow a gradient in order to arrive are arriving from somewhere else, and the signal they follow is generated at the challenged site.

(Choice D) Marrow output cannot be read from counts taken at a tissue site, and raising production alone would not move cells across a vessel wall into the dermis. The drug is specified to act on gradient responses rather than on production.

This is a Data-based and Statistical Reasoning question because you must compare two cell populations across two time points and two treatments to determine where the late influx originates.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    125
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$local-proliferation-explains-the-rise$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$conversion-in-the-wrong-direction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$blame-the-wrong-step$q$ FROM q;

-- Q21 . Antigen Transport to a Lymphoid Organ . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Antigen Transport to a Lymphoid Organ$q$,
    $q$A large protein antigen that remains largely trapped in skin is taken up by skin sentinel phagocytes, which degrade it and display peptide fragments on their surface. In one animal these cells display fragments normally but cannot respond to the chemical cue that draws them into lymphatic vessels.

Compared with a normal animal, this animal most likely shows:$q$,
    $q$[{"label":"A","text":"expansion of antigen-specific lymphocytes in bone marrow, where such cells are produced."},{"label":"B","text":"little expansion of antigen-specific lymphocytes in the draining lymph node."},{"label":"C","text":"normal expansion of antigen-specific lymphocytes, since they patrol peripheral tissue directly."},{"label":"D","text":"normal expansion of antigen-specific lymphocytes, since node-resident phagocytes display the fragments."}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because displayed antigen must physically reach the lymphoid organ where circulating lymphocytes are screened, and blocking the carrier's exit from the skin severs that delivery step. Selection of a lymphocyte clone is a numbers problem: only a vanishingly small fraction of lymphocytes carries a receptor matching any given antigen, so the immune system solves it by funneling both the displayed antigen and the recirculating lymphocyte pool into the same small structures. Lymph nodes and spleen are exactly those structures, and they contain the phagocytes that perform presentation as well as germinal centers rich in B and T lymphocytes. In this animal the display step works and the antigen is processed correctly, but the cell holding the display stays in the skin. With the display and the responder pool never brought together, few matching lymphocytes are selected and expanded in the draining node.

(Choice A) Bone marrow is the site where these cells are produced, but production is independent of any particular antigen. Selection of a matching clone and its expansion occur where displayed antigen and recirculating lymphocytes meet, which is a secondary lymphoid organ rather than marrow.

(Choice B) The trapped antigen cannot reach the node on its own, and the cell carrying its display cannot leave the skin. Because clonal selection requires the displayed fragment and the rare matching lymphocyte to encounter one another in a lymphoid organ, expansion in the draining node is markedly reduced.

(Choice C) Peripheral tissue is patrolled by innate cells and by lymphocytes that have already been activated, not by the unselected pool that must be screened first. The single lymphocyte in the pool that matches this antigen is very unlikely to be sitting in that patch of skin.

(Choice D) Lymph nodes do contain their own phagocytes capable of presenting antigen, but those cells can only display material that has been delivered to them. Since the antigen stays in the skin and its carrier cannot travel, the node's own presenting cells have nothing to show.

This is a Scientific Reasoning and Problem Solving question because you must trace how blocking the movement of an antigen-bearing cell out of a peripheral tissue affects lymphocyte selection in a lymphoid organ.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    120
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$primary-for-secondary-lymphoid-organ$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$lymphocytes-survey-tissue-directly$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true-cells-no-cargo$q$ FROM q;

-- Q22 . Innate Triggering by Damage Versus Non-Self . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Innate Triggering by Damage Versus Non-Self$q$,
    $q$A sterile glass sliver carrying no microbial molecules is placed in the tissue of an animal. Redness, swelling and phagocyte accumulation develop with the same timing and magnitude as at a second site given a heat-treated microbial preparation.

Which explanation best accounts for the response to the sliver?$q$,
    $q$[{"label":"A","text":"Contents spilled from injured host cells engage the same receptors and mediators."},{"label":"B","text":"Receptors that detect conserved microbial patterns bind the mineral surface of the sliver."},{"label":"C","text":"Lymphocytes carrying receptors matched to the sliver drive the early cellular influx."},{"label":"D","text":"Antibody raised against the sliver over the same interval directs the arriving cells."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because innate sensing is triggered by signals from damaged host cells as well as by non-self molecules, so a sterile object that injures tissue produces the same downstream response. Innate recognition operates through receptors on phagocytes, and those receptors respond both to conserved molecular patterns shared by microbes and to distress signals released by damaged or stressed host cells. Either input activates the same phagocyte program and the same release of mediators that dilate vessels, raise permeability, and recruit further cells. This is why an injury with no microbial component at all, such as a crush injury or an embedded fragment, produces redness, swelling, heat, and pain on the same schedule as a microbial challenge. The identical timing and magnitude at the two sites is exactly what a shared downstream pathway predicts.

(Choice A) Molecules released when host cells are torn open act on innate receptors and set off the same mediator cascade that microbial molecules do. Because the two inputs converge on one output, a sterile injury and a microbial preparation can generate responses of matched size and speed.

(Choice B) The sliver is stated to carry no microbial molecules, so receptors that recognize conserved microbial structures have nothing to bind on it. If pattern recognition were the only available trigger, a sterile object would provoke no response at all, which contradicts the observation.

(Choice C) Lymphocytes do accumulate at sites of inflammation, but they act only after antigen has been processed, displayed, and matched to a rare clone, which takes days rather than the interval described here. A mineral fragment also presents no protein epitopes for such a receptor to match, so no sliver-specific lymphocyte population exists to drive the influx.

(Choice D) Antibody directed at a newly encountered material develops over a period of days, and it is raised against protein epitopes, which a mineral fragment does not supply. The response described here unfolds on the timescale of the innate reaction, far too quickly for antibody to be organizing it.

This is a Scientific Reasoning and Problem Solving question because you must explain why a sterile object provokes an innate response equal to that provoked by microbial material.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$innate-equals-microbial-detection$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$adaptive-cell-on-an-innate-timescale$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$adaptive-product-on-an-innate-timescale$q$ FROM q;

COMMIT;

-- Verification: expect 22 questions and 66 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'The Immune System') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'The Immune System') AS distractor_rows;
