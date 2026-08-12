-- Biochemistry Chapter 8: Biological Membranes, standalone questions
-- BATCH 2 of 2 (24 questions), CHAPTER COMPLETE at 48: permeability and diffusion kinetics,
--   osmosis/tonicity with the founder-claimed osmotic-pressure computation, active transport
--   taxonomy (non-gut machinery), endocytosis/exocytosis with the vesicle topology invariant,
--   the two precisely carved membrane-potential items (single-ion sign logic, Nernst-vs-GHK
--   selection), and the junction unit (tight junctions keyed for the first time bank-wide,
--   connexon structure, hemidesmosome anchoring contrast).
--
-- PURE INSERTs: run AFTER biochemistry_ch8_membranes_questions.sql (batch 1 owns the DELETE).
-- Collision lanes honoured: no resting-potential, pump, Nernst-arithmetic, gut/kidney
-- cotransport, synaptic-exocytosis, gap-coupling, or receptor-cascade keys (Bio Ch4/Ch9/Ch10,
-- GC12, Bio Ch11, Bio Ch5 own them). Other colligative computations remain reserved for the
-- future GenChem Ch9 Solutions bank per the amended plan.

BEGIN;

-- B2 Q1 . unaided bilayer solute permeability ranking . medium . skill 1 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$unaided bilayer solute permeability ranking$q$,
    $q$A researcher prepares protein-free liposomes from pure phospholipid and adds three solutes to the surrounding solution, each at the same concentration. Which of the following solutes would require a membrane transport protein to enter the liposome interior at a physiologically useful rate?

I. Molecular oxygen
II. Glucose
III. Potassium ions$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"III only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests the permeability hierarchy of the lipid bilayer, which solutes cross unaided and which require a transport protein. The answer is C because glucose and potassium ions both need protein assistance to enter at physiologically useful rates, while molecular oxygen does not. A pure phospholipid bilayer presents a continuous hydrophobic core, so a solute's unaided crossing rate is set by how readily it sheds its water shell and dissolves in that nonpolar interior. Small nonpolar molecules such as molecular oxygen partition into the hydrocarbon core easily and diffuse across rapidly, so item I crosses on its own. Glucose is a comparatively large polar molecule whose many hydroxyl groups are strongly hydrated; stripping away that water to enter the nonpolar core is so unfavorable that unaided glucose flux is orders of magnitude too slow to supply a cell, making item II protein dependent. Potassium ions carry a full charge, and moving a bare charge into a low dielectric hydrocarbon environment is energetically prohibitive, so item III is essentially impermeant without a channel or carrier. (Choice A) inverts the hierarchy: the small nonpolar gas is precisely the solute that crosses the bare bilayer most readily, so oxygen is the last of the three species to need protein help. (Choice B) is incomplete rather than wrong about ions: potassium is indeed the least permeant species listed, but glucose also crosses a protein free bilayer far too slowly for physiology, so the answer cannot stop at item III. (Choice D) overextends the barrier concept: the bilayer is selectively rather than absolutely impermeable, and small uncharged nonpolar molecules such as oxygen and carbon dioxide cross it by simple diffusion at high rates without any protein pathway. This is a Knowledge of Scientific Concepts and Principles question because it asks you to apply the principle that bilayer permeability falls as solute polarity, size, and charge increase in order to sort three specific solutes into protein dependent and protein independent groups.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    1,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$inverted permeability hierarchy$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$ions only$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$bilayer is absolutely impermeable$q$ FROM q;

-- B2 Q2 . carrier saturation rate plateau . hard . skill 4 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$carrier saturation rate plateau$q$,
    $q$The initial rate of entry of two uncharged solutes, X and Y, into membrane vesicles containing purified transport proteins is measured as the external concentration of each solute is raised. The entry rate of X increases in direct proportion to its concentration over the entire range tested. The entry rate of Y climbs steeply at low concentrations but then levels off at a plateau, with further concentration increases producing no additional rate gain. Which conclusion about solute Y is supported by these observations?$q$,
    $q$[{"label":"A","text":"Y crosses the membrane by simple diffusion, dissolving directly in the lipid core of the bilayer"},{"label":"B","text":"Y is moved by primary active transport, and the plateau marks the point at which the vesicles' ATP supply is exhausted"},{"label":"C","text":"The plateau occurs because Y has reached the same concentration inside the vesicles as outside, eliminating net flux"},{"label":"D","text":"Y enters through a finite, countable population of carrier proteins whose binding sites are fully occupied at high concentration"}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests how transport kinetics distinguish simple diffusion from protein mediated facilitated diffusion. The answer is D because a transport rate that saturates at a plateau is the signature of a finite, countable population of protein binding sites. Simple diffusion through the lipid itself involves no binding step, so its rate rises in direct proportion to the concentration difference with no ceiling; that is exactly the behavior solute X displays. Solute Y instead shows a hyperbolic rate curve: at low concentration most carrier binding sites are free and the rate climbs steeply, but once essentially every carrier is occupied on every cycle, adding more solute cannot raise the rate, because the number of transport proteins, not the supply of solute, has become limiting. This is the same logic as enzyme saturation, and it applies to passive carriers just as it does to enzymes; a maximum rate exists only when a limited number of molecular machines does the work. A carrier's curve also has a characteristic half maximal concentration, analogous to the dissociation constant of a binding interaction, which is meaningful only when discrete binding sites exist. (Choice A) assigns X's mechanism to Y and reverses the diagnostic: a solute dissolving directly in the lipid core would show the linear, nonsaturating behavior that X displays, never a plateau. (Choice B) misreads the plateau as an energy limit: saturation of a passive carrier requires no ATP at all, and nothing in the data indicates uphill movement, so invoking ATP exhaustion adds a mechanism the observations never demand. (Choice C) confuses two different plateaus: equilibration of inside and outside concentrations does abolish net flux, but these are initial rate measurements taken before significant internal accumulation, and an equilibration artifact would have flattened the curve for X as well, which it did not. This is a Data-based and Statistical Reasoning question because it asks you to infer a solute's transport mechanism from the shape of its rate versus concentration relationship as described in an experiment.$q$,
    'hard',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    4,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$mechanisms swapped between solutes$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$saturation implies ATP dependence$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$equilibrium plateau vs site saturation$q$ FROM q;

-- B2 Q3 . GLUT1 down gradient passive uptake . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$GLUT1 down gradient passive uptake$q$,
    $q$In circulating red blood cells, plasma glucose is near 5 millimolar while free glucose inside the cell stays lower because glycolysis steadily consumes it, and the carrier GLUT1 moves glucose inward across the membrane. A researcher applies a poison that immediately and completely blocks all cellular ATP production, and during the first few minutes the glucose levels on the two sides of the membrane remain essentially unchanged. During those first few minutes, what happens to GLUT1-mediated glucose entry?$q$,
    $q$[{"label":"A","text":"It continues at close to its normal rate, because the downhill concentration gradient for glucose, not metabolic energy, drives each transport cycle"},{"label":"B","text":"It stops at once, because each GLUT1 transport cycle is powered by ATP hydrolysis"},{"label":"C","text":"Net glucose movement reverses, because without ATP the carrier can operate only in the export direction"},{"label":"D","text":"It stops, because uncharged solutes such as glucose depend on the membrane potential to drive their uptake"}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests why facilitated diffusion through GLUT1 is a passive process. The answer is A because the driving force for GLUT1 mediated transport is the transmembrane glucose concentration gradient itself, so eliminating ATP production leaves the transporter running essentially normally for as long as that gradient persists. GLUT1 is a passive carrier: glucose binds, the protein shifts shape, and glucose is released on the far side, moving spontaneously from the higher plasma concentration toward the lower internal concentration maintained by glycolytic consumption. No step in that cycle is coupled to ATP hydrolysis or to any other energy input, which is exactly what distinguishes facilitated diffusion from active transport. Downhill movement and the absence of an energy requirement travel together as a package: the process is thermodynamically favorable on its own, so an acute metabolic blockade cannot stop it. Red cells rely on this arrangement constantly: glycolytic consumption keeps internal free glucose low, so the inward driving force is regenerated by metabolism of the sugar itself rather than by any transport machinery. (Choice B) imports the machinery of a pump into a passive carrier: primary active transporters hydrolyze ATP on each cycle, but GLUT1 never does, and requiring ATP would make glucose entry active rather than facilitated. (Choice C) reverses the transporter's behavior: GLUT1 is intrinsically bidirectional, and the direction of net flux is set by which side has more glucose, not by the cell's energy state, so with plasma glucose still higher than internal glucose the net movement remains inward. (Choice D) borrows a driving force that applies only to charged solutes: the membrane potential acts on ions because they carry charge, whereas glucose is uncharged and its movement responds only to its own concentration difference. This is a Scientific Reasoning and Problem Solving question because it asks you to predict the outcome of an energy blockade by reasoning from the thermodynamic driving force behind a passive transporter.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$carriers hydrolyze ATP per cycle$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$energy state sets flux direction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$membrane potential as driving force$q$ FROM q;

-- B2 Q4 . channel versus carrier classification . easy . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$channel versus carrier classification$q$,
    $q$A transport protein reconstituted into synthetic liposomes moves urea down its concentration gradient at roughly one thousand molecules per second, with no energy source present. Each transport event requires urea to bind the protein, which then alternates between two conformations that expose the binding site first to one side of the membrane and then to the other. Into which functional class does this protein fall?$q$,
    $q$[{"label":"A","text":"A ligand-gated ion channel"},{"label":"B","text":"A carrier protein"},{"label":"C","text":"A primary active transport pump"},{"label":"D","text":"A nonselective open aqueous pore"}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests the functional distinction between the two classes of facilitated diffusion proteins, channels and carriers. The answer is B because a protein that must bind its solute and then alternate between two shapes, exposing the binding site to opposite sides of the membrane in turn, is by definition a carrier, and its modest turnover of roughly a thousand molecules per second matches carrier behavior. Channels and pores work in a fundamentally different way: they provide a continuous hydrated pathway through the membrane, so solutes stream through without an individual binding and release event for each particle, giving rates of tens of millions of ions or molecules per second. Carriers are far slower precisely because every transported molecule requires a complete conformational cycle. The absence of any energy source, together with movement downhill, confirms that this is passive facilitated diffusion rather than pumping. This division of labor is general: solutes crossing at rates approaching free diffusion implicate channels, while slower, substrate specific, saturable movement implicates carriers. (Choice A) confuses two uses of binding: in a ligand gated channel a ligand binds once to open the pore, after which many solute particles flow through freely, whereas here every single urea molecule must itself be bound and handed across, which is a carrier cycle, not gating. (Choice C) fixes on a genuine similarity, since pumps also alternate between shapes, but pumping means moving solute against its concentration difference using an energy source, and this protein moves urea downhill with no energy supply present. (Choice D) is incompatible with both the rate and the mechanism: an open aqueous pore passes solutes continuously at rates approaching free diffusion and involves no obligatory substrate binding step for each particle. This is a Scientific Reasoning and Problem Solving question because it asks you to map a described transport rate and mechanism onto the correct class of membrane transport protein.$q$,
    'easy',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$substrate binding mistaken for gating$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$pumps also alternate conformations$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$any passive protein is a pore$q$ FROM q;

-- B2 Q5 . aquaporin water flux inference . hard . skill 4 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$aquaporin water flux inference$q$,
    $q$Under identical osmotic gradients, water enters intact red blood cells about 100 times faster than it enters protein-free liposomes built from the same lipids. Adding a reagent that covalently modifies membrane proteins sharply reduces water entry into the red cells but leaves water entry into the liposomes unchanged. What accounts for the rapid water movement across the red cell membrane?$q$,
    $q$[{"label":"A","text":"Membrane proteins loosen the packing of neighboring lipids, so water dissolves in and crosses the bilayer itself far more quickly"},{"label":"B","text":"Water molecules are conducted through GLUT1, the glucose carrier abundant in the red cell membrane"},{"label":"C","text":"A protein pump hydrolyzes ATP to drive water into the cell, and modifying the pump blocks this active influx"},{"label":"D","text":"Dedicated water channels in the red cell membrane provide a continuous aqueous pathway that bypasses the lipid barrier"}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests how to infer the pathway of membrane water movement from comparative flux data. The answer is D because both observations point to a protein pathway dedicated to water: the red cell membrane outperforms a chemically identical protein free bilayer by two orders of magnitude, and disabling membrane proteins removes exactly that excess flux. A pure lipid bilayer does pass water, but only slowly, and that slow background leak is what the liposomes display; it is untouched by the reagent because no protein contributes to it. The red cell's additional capacity must therefore run through membrane proteins, and the only protein class able to conduct water in bulk at such rates is one forming a continuous aqueous pore, the water channel known as an aquaporin. Channel conduction also explains why the difference is so large, since channels pass their solutes at rates orders of magnitude above what carriers or the bilayer itself achieve. The specificity of the inhibition further localizes the fast pathway to a discrete protein species rather than to any bulk property of the lipid phase. (Choice A) contradicts the built in controls: the lipids are identical in the two systems, and a general loosening of lipid packing would not be abolished by covalent modification of specific proteins, nor could dissolution in the bilayer plausibly rise a hundredfold. (Choice B) names a real and abundant red cell membrane protein, but GLUT1 is a carrier that moves solutes one conformational cycle at a time, and carrier turnover is far too slow to account for bulk osmotic water flow of this magnitude. (Choice C) correctly places proteins in the pathway but wrongly makes the process active: cells never pump water directly by ATP hydrolysis, and here water moves passively down the osmotic gradient the experimenter supplies, so no energy coupled step is needed or indicated. This is a Data-based and Statistical Reasoning question because it asks you to deduce a transport pathway from a quantitative flux comparison combined with the response to a protein directed inhibitor.$q$,
    'hard',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$proteins fluidize the bilayer generally$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$true protein, wrong pathway$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$protein involvement right, energetics wrong$q$ FROM q;

-- B2 Q6 . particle count osmosis direction . easy . skill 4 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$particle count osmosis direction$q$,
    $q$A U shaped tube is divided at its base by a membrane that is permeable to water but impermeable to all solutes. The left arm is filled with 0.20 M sucrose, and the right arm is filled with 0.15 M NaCl, which dissociates completely in solution. In which direction will net water movement occur?$q$,
    $q$[{"label":"A","text":"Toward the sucrose arm, because 0.20 M is a higher molar concentration than 0.15 M"},{"label":"B","text":"In neither direction, because neither solute can cross the membrane to establish a gradient"},{"label":"C","text":"Toward the NaCl arm, because its total particle concentration of 0.30 osmolar exceeds the sucrose arm's 0.20 osmolar"},{"label":"D","text":"Toward the sucrose arm, because larger solute molecules attract water more strongly than small ions"}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests osmosis, specifically whether the direction of net water movement can be predicted by counting the total dissolved particles on each side of a selectively permeable barrier. The answer is C because water moves toward the compartment with the higher total particle concentration, and that count must include dissociation. Sucrose remains intact in solution, so 0.20 M sucrose contributes 0.20 osmolar of dissolved particles. NaCl separates completely into sodium ions and chloride ions, so 0.15 M NaCl contributes 2 x 0.15 = 0.30 osmolar. Free water is therefore relatively more abundant on the sucrose side, and water diffuses down its own concentration gradient into the NaCl arm. Net flow continues until the hydrostatic pressure of the rising column balances the osmotic driving force. Note that the ranking would flip if the sucrose were raised above 0.30 M, because the comparison always tracks total osmolarity, never the identity of the solute. (Choice A) This applies correct arithmetic to the wrong quantity. The labeled molar concentration of formula units really is higher for sucrose, but osmosis is a colligative phenomenon that responds to the number of independent dissolved particles, so the dissociated salt side wins despite its lower molarity. (Choice B) Impermeant solutes do not prevent osmosis; they are what sustain it. Precisely because neither solute can cross the membrane, the particle imbalance cannot dissipate by solute diffusion, and the only mobile species, water, must move instead. (Choice D) Sucrose molecules are indeed far larger than sodium or chloride ions, but solute size and identity are irrelevant to osmotic behavior. Colligative effects depend only on how many independent particles are dissolved, not on how large or heavy each particle is. This is a Data-based and Statistical Reasoning question because it requires converting the two supplied molar concentrations into total particle concentrations and comparing those computed values to predict the direction of net water flow.$q$,
    'easy',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    4,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B2 Q7 . red cell dilute saline outcome . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$red cell dilute saline outcome$q$,
    $q$Normal human red blood cells maintain a cytosolic osmolarity of about 300 mOsm per liter, set largely by solutes that cannot cross the plasma membrane. A technician accidentally suspends a sample of these cells in saline with a total osmolarity of 100 mOsm per liter. What outcome should the technician expect?$q$,
    $q$[{"label":"A","text":"The cells will gain water, swell, and may rupture as they stretch past capacity"},{"label":"B","text":"The cells will lose water and shrivel as water moves out into the saline"},{"label":"C","text":"The cells will hold a constant volume because the ions in the saline cannot cross the membrane"},{"label":"D","text":"The cells will swell because sodium ions flow inward and drag water along with them"}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests tonicity, the prediction of a cell's volume change from the relative solute concentrations of its cytosol and the surrounding bath. The answer is A because the described saline is strongly hypotonic to the cell. The cytosol holds about 300 mOsm per liter of largely impermeant solute while the bath holds only 100 mOsm per liter, so free water is more concentrated outside the cell than inside. Water flows down its own concentration gradient across the membrane and into the cell. A red blood cell has no wall to resist expansion, so it swells as water accumulates, and if the influx continues the stretched bilayer fails and the cell lyses, releasing its contents into the bath. The volume change is unavoidable because the dominant intracellular solutes cannot leave to relieve the gradient, and this is exactly why clinical infusions must be kept close to isotonic with plasma. (Choice B) This reverses the direction of water movement. Shrinkage and crenation are the response to a hypertonic bath, one more concentrated than the cytosol; here the bath is the dilute compartment, so water enters rather than leaves. (Choice C) The impermeability of the bath ions does not protect the cell's volume; it does the opposite. Because the solute imbalance cannot be relieved by solute diffusion, movement of water is the only available route toward equilibrium, and the cell's volume must change. (Choice D) This assigns the water gain to the wrong mechanism. The swelling is produced by water moving osmotically in response to the total particle imbalance, not by an inward flood of sodium dragging water behind it; the red cell membrane is essentially impermeable to these ions, so no bulk inward sodium flow is available to carry water with it. This is a Scientific Reasoning and Problem Solving question because it requires classifying the described bath as hypotonic relative to the cytosol and reasoning from that classification to the mechanical fate of the cell.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B2 Q8 . permeant solute tonicity distinction . hard . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$permeant solute tonicity distinction$q$,
    $q$A red blood cell with an internal osmolarity of 300 mOsm per liter, contributed almost entirely by impermeant solutes, is placed in a 300 mOsm per liter aqueous urea solution. Urea crosses the red cell membrane readily through the lipid bilayer and dedicated transporters. Over the following minutes, what will happen to the cell?$q$,
    $q$[{"label":"A","text":"Its volume will remain constant, because the internal and external osmolarities are equal"},{"label":"B","text":"It will shrink and crenate as extracellular urea draws water out of the cell"},{"label":"C","text":"It will swell briefly, then return to its original volume once urea concentrations equalize"},{"label":"D","text":"It will swell progressively and ultimately burst as urea enters and water follows"}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests the distinction between osmolarity and tonicity, which separates a solution's total particle count from the subset of particles that can drive sustained water movement. The answer is D because urea is a permeant solute, which makes the bath isosmotic yet functionally hypotonic. At the moment of mixing, the particle concentrations match at 300 mOsm per liter and there is no net water flux. But urea crosses the membrane readily, so it diffuses down its own gradient into the cell and continues entering until its concentrations inside and outside are equal. Once urea has equilibrated it exerts no net osmotic effect at all, and the remaining bookkeeping is lopsided: the cell still contains 300 mOsm per liter of impermeant solute, while the bath contains essentially none. Water therefore moves steadily inward toward the impermeant particles, the cell swells, and with no wall to resist expansion it eventually bursts. The general rule is that effective tonicity is set only by solutes that cannot cross the membrane, so a permeant solute at any concentration behaves osmotically much like the water it dissolves in. (Choice A) This is the trap of treating osmolarity and tonicity as interchangeable. The osmolarities are indeed equal at the start, but equal totals do not mean equal effective concentrations, because a matched count of freely crossing particles cannot hold water in place. (Choice B) This reverses the flux. Urea entry raises the intracellular particle count, so water follows urea into the cell; nothing in this system draws water outward at any stage. (Choice C) This misidentifies which equilibration settles the system. Urea concentrations do equalize, but that step does not restore volume, because the impermeant intracellular solutes remain permanently unbalanced and keep drawing water inward after urea has finished moving. This is a Scientific Reasoning and Problem Solving question because it requires integrating the stated membrane permeability of urea with osmotic bookkeeping to predict the cell's fate instead of reading it off the matched concentrations.$q$,
    'hard',
    '2A',
    $q$Plasma Membrane$q$,
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

-- B2 Q9 . dissociation osmotic pressure comparison . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$dissociation osmotic pressure comparison$q$,
    $q$A researcher prepares two aqueous solutions at 300 K, 0.10 M glucose and 0.10 M CaCl2, and assumes ideal behavior with complete dissociation of the salt. Using pi = iMRT with R = 0.08 L atm per mol per K, the glucose solution's osmotic pressure works out to 2.4 atm. What is the osmotic pressure of the CaCl2 solution, and how does it compare with that of the glucose solution?$q$,
    $q$[{"label":"A","text":"2.4 atm, equal to the glucose solution, because both solutions are 0.10 M"},{"label":"B","text":"7.2 atm, three times that of the glucose solution, because each formula unit yields three dissolved particles"},{"label":"C","text":"4.8 atm, twice that of the glucose solution, because dissociation of a salt doubles its particle count"},{"label":"D","text":"0.8 atm, one third that of the glucose solution, because dissociation splits each unit's osmotic contribution among three ions"}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests the osmotic pressure computation pi = iMRT, and specifically the van 't Hoff factor i, which counts the independent particles released per formula unit of dissolved solute. The answer is B because complete dissociation of CaCl2 triples the particle count relative to an equal molarity of glucose. Glucose remains intact in water, so i = 1 and pi = 1 x 0.10 x 0.08 x 300 = 2.4 atm, reproducing the value supplied in the stem. Each CaCl2 formula unit separates into one calcium ion and two chloride ions, so i = 3 and pi = 3 x 0.10 x 0.08 x 300 = 7.2 atm. Osmotic pressure is a colligative property, so identical molarities of two solutes produce different pressures whenever their dissociation behavior differs, and here the salt's pressure comes out exactly three times the sugar's. This same tripling is why a 0.10 M solution of this salt is osmotically equivalent to a 0.30 M solution of a nondissociating solute. (Choice A) This omits the van 't Hoff factor entirely and treats equal molarity as equal pressure. Molarity of formula units is the wrong count for a colligative property; the equation requires the concentration of independent dissolved particles, which dissociation triples for this salt. (Choice C) This borrows the dissociation pattern of a different class of salt. A factor of two describes a 1 to 1 electrolyte such as NaCl or KCl, which releases two ions per formula unit; CaCl2 is a 2 to 1 electrolyte and releases three, one calcium and two chloride. (Choice D) This applies the dissociation correction in the wrong direction. Splitting into ions multiplies the effective particle concentration rather than diluting it; dividing by three treats each ion as a fraction of a particle, when in fact each ion counts fully and independently toward the osmotic total. This is a Data-based and Statistical Reasoning question because it requires executing the particle count arithmetic of the van 't Hoff equation with the supplied values and comparing the two computed pressures.$q$,
    'hard',
    '5D',
    $q$Plasma Membrane$q$,
    'biochemistry',
    4,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- B2 Q10 . uphill accumulation energy requirement . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$uphill accumulation energy requirement$q$,
    $q$A cultured fibroblast maintains the cytosolic concentration of a small neutral amino acid near 10 mM while the surrounding medium contains 0.1 mM. Radiolabeling experiments show that the cell continues to take up additional amino acid from the medium over time. What does this observation reveal about the import mechanism?$q$,
    $q$[{"label":"A","text":"The amino acid crosses the bilayer by simple diffusion, since small neutral molecules pass membranes freely"},{"label":"B","text":"Carrier proteins make the uptake favorable by lowering the activation energy for membrane crossing"},{"label":"C","text":"The transporter must be coupled to an energy source because the amino acid moves against its concentration gradient"},{"label":"D","text":"The amino acid enters by facilitated diffusion through a carrier that has not yet reached saturation"}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests the thermodynamic signature of active transport, namely that a solute accumulating against its concentration gradient must be moved by an energy coupled mechanism. The answer is C because the amino acid is already one hundred times more concentrated in the cytosol than in the surrounding medium, yet the radiolabel shows that inward movement continues. Transport from 0.1 mM outside to 10 mM inside is movement from a region of low concentration to a region of high concentration, so the free energy change for each additional molecule imported is positive and the process cannot occur spontaneously. Transport proteins act as catalysts for membrane crossing, and catalysis changes only the rate of a process; it cannot reverse the direction that thermodynamics dictates. The only way to drive an unfavorable movement is to couple it to a favorable one, such as ATP hydrolysis or the downhill flow of a second solute, and that coupling is the defining feature of active transport. (Choice A) Simple diffusion through the bilayer proceeds only down a concentration gradient. A small neutral solute may indeed cross the bilayer slowly, but diffusion alone would tend to equalize the concentrations rather than concentrate the solute one hundredfold inside the cell. (Choice B) Carrier proteins do lower the kinetic barrier for crossing the hydrophobic core, but lowering activation energy changes the rate of a process, not its direction. The overall free energy change for uphill import remains positive no matter how efficient the carrier is. (Choice D) Facilitated diffusion is a passive process that runs only downhill regardless of whether the carrier is saturated. Saturation describes how close the carrier is to its maximum velocity and says nothing about an ability to pump a solute against a gradient. This is a Scientific Reasoning and Problem Solving question because it requires comparing the measured concentrations on the two sides of the membrane, recognizing that continued inward movement is thermodynamically uphill, and concluding that the transporter must be coupled to an energy source.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B2 Q11 . primary versus secondary energy source . easy . skill 1 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$primary versus secondary energy source$q$,
    $q$In a muscle cell, a plasma membrane calcium ATPase exports calcium from the cytosol while hydrolyzing ATP in each transport cycle. A sodium-calcium exchanger in the same membrane also exports calcium, but its cycle is driven by sodium ions flowing into the cell down their electrochemical gradient rather than by ATP hydrolysis. How should these two transporters be classified?$q$,
    $q$[{"label":"A","text":"The calcium ATPase performs primary active transport, and the exchanger performs secondary active transport"},{"label":"B","text":"Both are primary active transporters because each moves calcium against its concentration gradient"},{"label":"C","text":"The calcium ATPase performs secondary active transport, and the exchanger performs primary active transport"},{"label":"D","text":"The exchanger performs facilitated diffusion because its cycle does not hydrolyze ATP"}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests the classification of active transporters as primary or secondary based on their immediate energy source. The answer is A because primary active transport is defined by direct coupling to ATP hydrolysis within the transport cycle, while secondary active transport is powered by the dissipation of an ion gradient that was established separately. The calcium ATPase binds and hydrolyzes ATP as part of its own pumping cycle, so its energy input is direct and the pump is classified as a primary active transporter. The sodium calcium exchanger hydrolyzes no ATP at all; it allows sodium ions to run down their electrochemical gradient into the cell and harnesses that favorable inward flow to push calcium out of the cytosol against its gradient. Because the sodium gradient it spends was itself built at the expense of ATP elsewhere in the membrane, the exchanger uses ATP only indirectly, which is exactly what the label secondary conveys. The classification therefore follows from asking where each transporter gets its energy, not from what solute it moves or in which direction. (Choice B) Moving a solute against its gradient is what makes a transporter active, but it does not make the transporter primary; the primary versus secondary distinction rests entirely on the immediate energy source, and only one of these two proteins consumes ATP in its own cycle. (Choice C) This reverses the assignments. The transporter that hydrolyzes ATP within its own cycle is the primary one, and the transporter that spends a preexisting ion gradient is the secondary one, not the other way around. (Choice D) Facilitated diffusion moves a solute only down its gradient with no energy coupling at all. The exchanger moves calcium uphill, out of a low calcium cytosol, so it is performing active transport even though ATP is not hydrolyzed in its cycle. This is a Knowledge of Scientific Concepts and Principles question because it asks for the definitional distinction between primary and secondary active transport, applied to two transporters whose energy sources are described.$q$,
    'easy',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B2 Q12 . liposome transporter direction terminology . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$liposome transporter direction terminology$q$,
    $q$A biochemist reconstitutes three purified transport proteins into separate liposome preparations and tracks solute movement. Transporter I moves a single sugar molecule into the lumen with no other solute. Transporter II couples the entry of protons into the lumen to the exit of a divalent metal ion from the lumen. Transporter III moves sodium ions and an amino acid together from the exterior into the lumen. Which of the transporters function(s) as an antiporter?

I. Transporter I
II. Transporter II
III. Transporter III$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"III only"},{"label":"D","text":"II and III only"}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests the directional vocabulary of membrane transport, assigning the terms uniporter, symporter, and antiporter to transport proteins described by their behavior in reconstituted vesicles. The answer is B because only transporter II moves its two solutes in opposite directions across the same membrane. In its cycle, protons enter the vesicle lumen while the divalent metal ion exits the lumen, so the two species cross the bilayer in opposing directions during a single transport event, which is the definition of antiport. Transporter I handles a single sugar with no cosolute, making it a uniporter, and transporter III carries sodium ions and the amino acid in the same direction, from the exterior into the lumen, making it a symporter. Sorting the three descriptions therefore requires tracking the direction of every solute relative to the membrane rather than simply counting how many solutes a protein touches. The count of solutes separates uniport from the two coupled mechanisms, but only the relative direction of movement separates symport from antiport. (Choice A) Transporter I moves one sugar and nothing else. A protein that carries a single species is a uniporter, and the antiport label cannot apply because antiport requires two coupled solutes moving in opposite directions. (Choice C) Transporter III moves both of its solutes inward together. Carrying two different species in the same direction is the definition of symport, which is the opposite directional pairing from antiport, so this choice assigns the term backwards. (Choice D) This choice correctly identifies transporter II but also sweeps in transporter III. A symporter does not become an antiporter merely because it handles two different solutes; the deciding feature is the relative direction of movement, not the number of transported species. This is a Scientific Reasoning and Problem Solving question because it asks the reader to extract the direction of each solute from experimental descriptions of three reconstituted transporters and map those directional patterns onto the correct transport terminology.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B2 Q13 . ATP depletion transporter failure order . hard . skill 3 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$ATP depletion transporter failure order$q$,
    $q$An investigator treats cultured vascular smooth muscle cells with a poison that blocks all cellular ATP synthesis, and intracellular ATP falls to near zero within one minute. Before treatment, cytosolic calcium was kept low by two proteins in the plasma membrane: a calcium ATPase that hydrolyzes ATP as it exports calcium, and a sodium-calcium exchanger that exports calcium as sodium ions flow into the cell. Which outcome is expected in the first few minutes after ATP depletion?$q$,
    $q$[{"label":"A","text":"Both transporters stop simultaneously, because both classes of active transport depend directly on ATP hydrolysis"},{"label":"B","text":"The exchanger stops first, because ion gradients collapse faster than ATP stores are exhausted"},{"label":"C","text":"The calcium ATPase continues to run, because it can switch to the sodium gradient once ATP is unavailable"},{"label":"D","text":"The calcium ATPase stops promptly, while the exchanger continues transiently on the preexisting sodium gradient"}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests the energetic logic that separates primary from secondary active transport, applied to an inhibition experiment in which cellular ATP is abruptly removed. The answer is D because the two calcium extrusion pathways depend on different immediate energy sources and therefore fail on different timescales. The plasma membrane calcium ATPase hydrolyzes ATP within its own cycle, so when intracellular ATP falls to near zero the pump loses its substrate and stalls almost immediately. The sodium calcium exchanger consumes no ATP directly; it is powered by the inward electrochemical gradient of sodium, a store of energy held in the ion distribution across the membrane itself. That gradient was established before the poison was added, and although it can no longer be maintained, it dissipates gradually rather than instantly as sodium leaks and continued exchange slowly run it down. During that window the exchanger keeps extruding calcium on the stored gradient, so the secondary pathway outlasts the primary one. (Choice A) Only primary active transport consumes ATP within its own transport cycle. Secondary transporters draw on preexisting ion gradients, so the two classes are not expected to fail at the same moment when ATP synthesis is blocked. (Choice B) This reverses the expected timing. The sodium gradient is a reservoir of stored energy that persists for a time after ATP is gone, whereas the ATPase is deprived of its substrate the moment ATP is depleted, so the pump fails first. (Choice C) This swaps the energy sources of the two proteins. The calcium ATPase is built to couple calcium movement to ATP hydrolysis and has no mechanism for harvesting the sodium gradient; spending that gradient is the exchanger's mechanism, not the pump's. This is a Reasoning about the Design and Execution of Research question because it asks which transporter a metabolic poison should silence first, and predicting the outcome of that perturbation requires tracing each transporter's immediate energy source through the timeline of the experiment.$q$,
    'hard',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    3,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

-- B2 Q14 . receptor clustering cargo enrichment . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$receptor clustering cargo enrichment$q$,
    $q$A cultured fibroblast internalizes a circulating lipoprotein particle through vesicles that bud from clathrin-coated regions of its plasma membrane. Inside newly formed vesicles, the particle is roughly one thousand times more concentrated than in the surrounding fluid. Which feature of this uptake route most directly accounts for the enrichment?$q$,
    $q$[{"label":"A","text":"The clathrin lattice binds the particle directly on the extracellular side and pulls it into the forming vesicle as the membrane curves inward."},{"label":"B","text":"The vesicles formed are far smaller than pinocytotic vesicles, so the fluid they trap holds its solutes at a proportionally higher concentration."},{"label":"C","text":"Surface receptors bind the particle and gather at the budding site before the vesicle pinches off, so capture reflects receptor occupancy rather than the particle's abundance in the bulk medium."},{"label":"D","text":"After the vesicle buds, an ATP-driven pump in its membrane transports additional particles across the vesicle membrane, concentrating the cargo after capture."}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests the selectivity mechanism of receptor-mediated endocytosis, the feature that lets a cell concentrate one specific cargo far above its level in the surrounding fluid. The answer is C because the particle enters bound, not dissolved. Cell surface receptors recognize the lipoprotein with high affinity, and once ligand is bound, the receptor-ligand complexes migrate laterally in the plane of the membrane and gather at the specialized region that will invaginate and bud inward. The forming vesicle therefore packages as many particles as there are occupied receptors lining its membrane, so loading is set by receptor occupancy rather than by how much particle happens to be dissolved in the tiny volume of fluid the vesicle also traps. That is why this route can achieve roughly thousandfold enrichment of a scarce ligand, something bulk fluid uptake can never do, since a vesicle that simply swallows extracellular fluid contains every solute at exactly its bulk concentration. (Choice A) misstates the geometry of the coat protein. Clathrin assembles on the cytoplasmic face of the membrane, where it stabilizes curvature and drives budding; it never contacts the extracellular space, so it cannot bind or select the cargo itself. (Choice B) is a scale error. Making a vesicle smaller reduces the volume of fluid captured but not the concentration of solutes within that fluid; a smaller sample of the same solution is not a more concentrated one. (Choice D) confuses vesicular capture with transporter physiology. The cargo is enclosed during budding, and no ATP-driven pump moves an intact particle across the vesicle membrane afterward; a macromolecular lipoprotein is orders of magnitude too large to pass through any pump or carrier. This is a Scientific Reasoning and Problem Solving question because it asks you to reason from an observed thousandfold cargo enrichment to the one mechanistic feature of the uptake route that could produce it.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$coat protein as cargo receptor$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'scale_unit_error', $q$confusing amount with concentration$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$grafting pump transport onto vesicular uptake$q$ FROM q;

-- B2 Q15 . nonselective fluid uptake classification . easy . skill 1 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$nonselective fluid uptake classification$q$,
    $q$A cultured epithelial cell continuously pinches off small vesicles whose interiors contain extracellular fluid. When two structurally unrelated tracer molecules are added to the medium at equal concentrations, both appear inside the newly formed vesicles at those same concentrations, and neither binds any protein on the cell surface. Which uptake process is the cell performing?$q$,
    $q$[{"label":"A","text":"Phagocytosis"},{"label":"B","text":"Pinocytosis"},{"label":"C","text":"Receptor-mediated endocytosis"},{"label":"D","text":"Facilitated diffusion"}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests the taxonomy of endocytic uptake: classifying a described event as phagocytosis, pinocytosis, or receptor-mediated endocytosis based on its mechanism rather than its name. The answer is B because every observed feature is the signature of nonselective bulk fluid uptake. The vesicles are small and contain extracellular fluid rather than a large discrete particle, and two structurally unrelated tracers both appear inside at exactly their outside concentrations without binding anything on the cell surface. Uptake in direct proportion to bulk concentration is the fingerprint of a process that simply encloses a droplet of medium: whatever happens to be dissolved comes along, with no enrichment and no discrimination between solutes. That combination, small fluid-filled vesicles plus concentration-proportional and receptor-independent capture, defines pinocytosis, often described as cell drinking. (Choice A) fails on cargo scale and vesicle type. Phagocytosis engulfs large particles such as cell debris, extending membrane around a discrete object and enclosing it in a large vacuole; it does not continuously generate small vesicles filled with dissolved solutes. (Choice C) is endocytosis, but of the wrong kind. Receptor-mediated endocytosis requires cargo to bind specific surface receptors, and that binding concentrates the ligand in the vesicle well above its fluid level; here neither tracer binds a surface protein and neither is enriched, so the receptor criterion is unmet. (Choice D) is not a vesicular process at all. Facilitated diffusion carries individual solutes through channel or carrier proteins directly across the bilayer; it forms no vesicles, and a single carrier could not move two structurally unrelated tracers with identical efficiency. This is a Knowledge of Scientific Concepts and Principles question because it asks you to classify an uptake event by matching its vesicle size, cargo type, and selectivity to the defining criteria of the endocytosis categories.$q$,
    'easy',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$right taxonomy, wrong cargo scale$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$correct superclass, wrong subclass$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$conflating vesicular and transporter transport$q$ FROM q;

-- B2 Q16 . lumenal tag exocytosis fate . medium . skill 3 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$lumenal tag exocytosis fate$q$,
    $q$A researcher engineers a secretory cell so that a protein embedded in the membrane of its secretory vesicles carries a fluorescent tag on the domain facing the vesicle lumen. The cell is then stimulated, and the vesicles fuse with the plasma membrane and release their soluble contents. Where should the researcher expect to find the tag after fusion is complete?$q$,
    $q$[{"label":"A","text":"Anchored in the plasma membrane, with the tagged domain exposed on the extracellular surface"},{"label":"B","text":"Anchored in the plasma membrane, with the tagged domain facing the cytosol"},{"label":"C","text":"Free in the extracellular medium, released together with the vesicle's soluble contents"},{"label":"D","text":"Free in the cytosol, released as the vesicle membrane disassembles during fusion"}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests the topology invariant of vesicle traffic: a membrane face never changes sides, so the lumenal face of a vesicle becomes the extracellular face after fusion with the plasma membrane. The answer is A because fusion merges the two bilayers continuously without ever flipping them. Before fusion, the tagged domain projects into the vesicle lumen, a compartment that is topologically equivalent to the outside of the cell, while the opposite end of the protein faces the cytosol. When the vesicle bilayer merges with the plasma membrane bilayer, the vesicle's lumenal leaflet becomes continuous with the outer leaflet of the plasma membrane and the lumen opens to the extracellular space, so the tag is now displayed on the cell surface, where an antibody added to the medium could reach it without permeabilizing the cell. The cytosolic face stays cytosolic throughout, since no protein domain crosses the bilayer during fusion. (Choice B) reverses the topology. The tag would face the cytosol only if the protein inverted its orientation during fusion, and membrane fusion never flips proteins across the bilayer; the cytosolic domain remains the cytosolic domain. (Choice C) confuses membrane cargo with soluble cargo. The soluble contents of the lumen are indeed discharged into the medium, but the tagged protein is anchored in the vesicle membrane, and that membrane is incorporated into the plasma membrane rather than leaving the cell. (Choice D) invokes a step that does not exist. The vesicle membrane merges into the plasma membrane during fusion; it is not disassembled into the cytosol, so nothing anchored in it is set free inside the cell. This is a Reasoning about the Design and Execution of Research question because it asks you to predict where an engineered lumenal tag will localize after exocytosis, which is exactly the readout the researcher's labeling experiment is built to detect.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    3,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$flipping the sidedness invariant$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$treating membrane cargo as soluble cargo$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$imagined vesicle disassembly step$q$ FROM q;

-- B2 Q17 . secretory membrane area balance . hard . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$secretory membrane area balance$q$,
    $q$A pancreatic acinar cell secretes digestive enzymes by continuous fusion of enzyme-filled vesicles with its apical plasma membrane, yet its total surface area remains constant for days. A drug is then applied that blocks vesicle retrieval by endocytosis without changing the rate of vesicle fusion. What change should occur in the cell's plasma membrane surface area over the next several hours?$q$,
    $q$[{"label":"A","text":"It decreases, because each fusion event consumes plasma membrane lipids to rebuild the secretory vesicle"},{"label":"B","text":"It remains constant, because the fused vesicle membrane exits the cell together with the secreted enzymes"},{"label":"C","text":"It remains constant, because lipid flip-flop between leaflets transfers the added membrane into internal stores"},{"label":"D","text":"It increases steadily, because each fusion event adds vesicle membrane that is no longer being retrieved"}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests membrane accounting during vesicle cycling: exocytosis adds membrane to the cell surface, endocytosis removes it, and a secretory cell holds its surface area constant only because the two arms run in balance. The answer is D because the drug removes the retrieval arm while leaving the addition arm running. Each time a vesicle fuses, its entire membrane, lipids and proteins alike, is incorporated into the plasma membrane, so ongoing secretion is a continuous stream of membrane delivery to the cell surface. Normally the cell withdraws an equivalent amount by compensatory endocytosis and recycles it inward, which is why surface area stays constant for days despite heavy secretory traffic. With retrieval blocked and fusion unchanged, deliveries continue with no withdrawals, so the plasma membrane must expand steadily, in proportion to the ongoing secretion rate. (Choice A) reverses the direction of the exocytic arm. Fusion contributes vesicle membrane to the surface rather than consuming surface membrane; it is the now blocked endocytic arm that normally removes plasma membrane, so nothing in the treated cell is drawing area down. (Choice B) confuses the vesicle's two kinds of cargo. The soluble enzymes in the lumen are released to the exterior, but the vesicle membrane itself is not secreted; it merges into the plasma membrane and remains part of the cell, which is precisely why unretrieved fusion enlarges the surface. (Choice C) misapplies a real phenomenon. Flip-flop is the slow transverse movement of individual lipids between the two leaflets of a single bilayer; it can redistribute lipids across that membrane but cannot export area from the plasma membrane into internal stores, so it offsets nothing. This is a Scientific Reasoning and Problem Solving question because it requires combining the membrane addition and retrieval arms of vesicle cycling and inferring the direction of surface area change when one arm is pharmacologically blocked.$q$,
    'hard',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$inverting which arm adds and which removes$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$membrane secreted with its cargo$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$real phenomenon misapplied to area bookkeeping$q$ FROM q;

-- B2 Q18 . vesicle anion equilibrium potential sign . hard . skill 4 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$vesicle anion equilibrium potential sign$q$,
    $q$A biochemist reconstitutes a chloride-selective channel into the membranes of synthetic lipid vesicles; no other transport proteins are present. Each vesicle contains 100 mM KCl inside and is suspended in a large bath containing 10 mM KCl, and the membrane is impermeable to potassium ions. At 37 degrees Celsius, a tenfold concentration ratio of a monovalent ion corresponds to an equilibrium potential magnitude of approximately 61 millivolts. Once chloride reaches electrochemical equilibrium, what is the electrical potential of the vesicle interior relative to the bath?$q$,
    $q$[{"label":"A","text":"Approximately positive 61 millivolts"},{"label":"B","text":"Approximately negative 61 millivolts"},{"label":"C","text":"Approximately 0 millivolts"},{"label":"D","text":"Approximately positive 122 millivolts"}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests determining the sign of a single ion's equilibrium potential from its concentration gradient in a model vesicle system. The answer is A because chloride is tenfold more concentrated inside the vesicle, so it diffuses outward through the reconstituted channel, and each departing anion carries negative charge out, leaving the vesicle interior with a slight excess of positive charge. An interior-positive potential attracts the negatively charged chloride ion back inward, opposing further efflux. Net movement stops when this inward electrical pull exactly balances the outward diffusional push, and the supplied conversion states that a tenfold gradient of a monovalent ion is balanced by a potential of about 61 millivolts. The interior therefore sits near positive 61 millivolts relative to the bath. Only a tiny number of ions must actually cross to charge the membrane to this value, so the stated bulk concentrations remain essentially unchanged at equilibrium. (Choice B) A negative interior is the result of applying cation logic to an anion. If the interior were negative, it would repel chloride outward, adding to the diffusional force rather than balancing it, so efflux would never stop; the sign must be inverted for a negatively charged permeant species. (Choice C) A potential of zero would require the chloride concentrations on the two sides to equalize, but the membrane becomes charged long before the bulk concentrations can change. The equilibrium here is electrochemical, a persistent concentration gradient held in place by a persistent electrical potential, not chemical equality. (Choice D) Doubling to 122 millivolts comes from adding a second 61 millivolt term for the potassium gradient. The membrane is impermeable to potassium, and an ion that cannot cross the membrane cannot move charge, so its gradient makes no contribution to the equilibrium potential; only the permeant ion sets it. This is a Data-based and Statistical Reasoning question because it requires combining the supplied concentration data with the given millivolt conversion factor to infer the direction of net anion flux and the sign of the potential that balances it.$q$,
    'hard',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    4,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$sign flip for anion$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$equilibrium means equal concentrations$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$double-counting an impermeant ion$q$ FROM q;

-- B2 Q19 . multi-ion permeability equation selection . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$multi-ion permeability equation selection$q$,
    $q$A cultured epithelial cell sits in a defined medium, and its membrane is measurably permeable to potassium, sodium, and chloride, with a membrane potential lying between the individual equilibrium potentials of those three ions. A researcher adds a compound that selectively increases the membrane's permeability to sodium while leaving every ion concentration and the other two permeabilities unchanged. What change in the membrane potential should the researcher predict?$q$,
    $q$[{"label":"A","text":"It shifts toward the potassium equilibrium potential"},{"label":"B","text":"It shifts toward the sodium equilibrium potential but does not reach it"},{"label":"C","text":"It remains unchanged because no ion concentration was altered"},{"label":"D","text":"It becomes exactly equal to the sodium equilibrium potential"}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests choosing between the Nernst and Goldman-Hodgkin-Katz (GHK) treatments of membrane potential and predicting the effect of a permeability change. The answer is B because a membrane permeant to several ions is described by the GHK equation, which weights each ion's contribution according to its permeability. Raising sodium permeability increases sodium's weight in that permeability-weighted average, so the membrane potential moves toward the sodium equilibrium potential. In effect, each permeant ion pulls the potential toward its own equilibrium value with a strength set by its permeability, and the measured potential is the compromise among those pulls. Because potassium and chloride remain permeant, their terms still contribute, and the potential stops short of the sodium value. The Nernst equation covers only the special case of a single permeant ion at equilibrium, so it cannot be applied directly to a three-ion membrane. (Choice A) Increasing sodium permeability strengthens sodium's influence over the weighted average, so the potential moves away from, not toward, the potassium equilibrium potential; this choice reverses the direction of the predicted shift. (Choice C) This is single-ion Nernst reasoning misapplied to a multi-ion membrane. In the Nernst equation the potential is fixed by one ion's concentrations, but in the GHK equation permeabilities appear alongside concentrations, so changing a permeability alone shifts the potential even when every concentration is held constant. (Choice D) Equality with the sodium equilibrium potential is the limiting case in which sodium is effectively the only permeant ion. With potassium and chloride still carrying current across the membrane, the weighted average must lie between the equilibrium potentials, so the shift is toward the sodium value without reaching it. This is a Scientific Reasoning and Problem Solving question because it requires selecting the multi-ion GHK model over the single-ion Nernst model and using its permeability weighting to predict the direction of a potential shift.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$direction of shift reversed$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$Nernst logic misapplied to multi-ion membrane$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$correct direction, overstated endpoint$q$ FROM q;

-- B2 Q20 . receptor channel versus enzyme classification . easy . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$receptor channel versus enzyme classification$q$,
    $q$Biochemists purify a single species of plasma membrane protein from cultured epithelial cells and reconstitute it, alone, into a planar lipid bilayer separating two identical salt solutions. When a small extracellular metabolite that binds the protein is added to one side, ionic current across the bilayer switches on within milliseconds, and recordings show the current turning on and off in abrupt unitary steps; no chemical reaction products are detected on either side. Which classification of this membrane protein accounts for these observations?$q$,
    $q$[{"label":"A","text":"A receptor whose intracellular domain becomes an active enzyme when ligand binds"},{"label":"B","text":"A receptor that opens a separate channel protein by acting through an intermediary membrane protein"},{"label":"C","text":"A ligand-gated ion channel"},{"label":"D","text":"A carrier that shuttles ions by alternately exposing a binding site to each membrane face"}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests the structural classification of cell-surface receptors, some of which are themselves ion channels while others are themselves enzymes. The answer is C because the single purified protein binds its ligand and immediately passes ionic current across the bilayer, so the receptor and the ion pathway must be the same molecule; that is the defining architecture of a receptor that itself forms a channel. The abrupt unitary steps in the current record are the signature of individual channel molecules snapping between open and closed conformations. Because the protein was reconstituted alone, nothing else in the bilayer could have produced the current, and the absence of any chemical product rules out catalysis. Ligand binding simply drives a conformational change that opens the protein's own ion-permeable pathway through the membrane. (Choice A) A receptor whose intracellular domain acts as an enzyme responds to ligand binding by catalyzing a chemical modification, which would generate detectable reaction products; here no products appear on either side, and the observed output is charge movement rather than chemistry. (Choice B) A receptor that works through a separate intermediary protein cannot explain this result, because the reconstituted bilayer contained only the one purified protein; a relay requiring additional components would produce no current in this stripped-down system, yet current was observed within milliseconds. (Choice D) A carrier moves solutes by alternately exposing a binding site to the two faces of the membrane, a cycle that is orders of magnitude slower than channel conduction and produces smooth, graded flux rather than abrupt unitary current steps; the millisecond, stepwise record excludes carrier behavior. This is a Scientific Reasoning and Problem Solving question because it requires applying the structural criteria that distinguish receptor classes to a reconstitution experiment and identifying the class consistent with a current produced by a single purified protein.$q$,
    'easy',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$real class, wrong evidence$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$inserted relay step$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$channel versus carrier confusion$q$ FROM q;

-- B2 Q21 . tight junction paracellular seal . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$tight junction paracellular seal$q$,
    $q$A researcher cultures a continuous epithelial monolayer on a porous filter separating an upper fluid chamber from a lower chamber. A small water-soluble tracer that cannot cross lipid bilayers is added to the upper chamber, and essentially none reaches the lower chamber over several hours. If the researcher then adds a calcium chelator that disassembles the junctional belts encircling each cell near its apical surface, which outcome is most likely?$q$,
    $q$[{"label":"A","text":"The tracer remains confined to the upper chamber because it still cannot cross any cell's plasma membrane."},{"label":"B","text":"The tracer reaches the lower chamber after being endocytosed at the upper surface of the cells and released from their lower surface."},{"label":"C","text":"The tracer reaches the lower chamber by diffusing through the spaces between adjacent cells."},{"label":"D","text":"The tracer remains confined to the upper chamber because the spot-like adhesive junctions between the cells still seal the intercellular space."}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests the sealing role of tight junctions in an epithelial barrier. The answer is C because the belts described in the stem are tight junctions, continuous bands that encircle each epithelial cell near its apical margin and fuse the membranes of neighboring cells to one another. In an intact monolayer these belts eliminate the gap between cells, which is why an epithelium can hold two fluid compartments at different compositions: a solute that cannot enter the cells is trapped, because both available routes are closed. The transcellular route is closed to this tracer since it cannot penetrate a lipid bilayer, and the paracellular route between cells is closed by the belts. The chelator disassembles the belts, so the paracellular pathway opens while every cell membrane remains exactly as impermeable as before. The tracer therefore leaks into the lower chamber by diffusing through the reopened spaces between adjacent cells, never entering a cell at any point. (Choice A) The tracer indeed still cannot cross any plasma membrane, but that fact closes only the transcellular route. Passage between cells requires no bilayer crossing at all, so membrane impermeability stops protecting the lower chamber the moment the junctional seal is gone. (Choice B) Uptake at one surface followed by release at the other is transcytosis, a vesicular process carried out by the cell's own endocytic machinery. Disassembling junctions does not recruit the tracer into vesicles, and nothing in the stem suggests the tracer is a cargo for such transport. (Choice D) The spot-like adhesive junctions between epithelial cells are desmosomes. They rivet neighboring cells together at discrete points, but they are isolated buttons rather than continuous belts, so they leave the intercellular space open and cannot maintain a fluid-tight seal on their own. This is a Scientific Reasoning and Problem Solving question because it asks you to predict which transport route opens across an epithelium once its junctional seal is disassembled.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$true fact applied to the wrong route$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$swaps in an unrelated transport process$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$assigns the sealing role to the anchoring junction$q$ FROM q;

-- B2 Q22 . tight junction fence function . hard . skill 3 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$tight junction fence function$q$,
    $q$In a polarized epithelial monolayer, a fluorescently tagged membrane transporter is detected exclusively on the apical surface of each cell. Investigators first block all new protein synthesis and then apply an agent that disassembles the junctional belts joining neighboring cells. Within two hours the tag is detected on both the apical and basolateral surfaces; which conclusion does this result best support?$q$,
    $q$[{"label":"A","text":"The junctional belt normally blocks membrane proteins from drifting within the plane of the membrane, and its loss allowed the tagged transporter to diffuse laterally into the basolateral domain."},{"label":"B","text":"Newly synthesized copies of the transporter were delivered to the wrong surface once the junctional belts were removed."},{"label":"C","text":"Tagged transporter molecules left the membrane of one cell, crossed the intercellular space opened by the treatment, and inserted into the basolateral membranes of neighboring cells."},{"label":"D","text":"The treatment flipped the transporter across the bilayer, exposing its tagged domain on the opposite face of the membrane."}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests the fence function of tight junctions, the property that keeps the apical and basolateral membrane domains of a polarized epithelial cell compositionally distinct. The answer is A because membrane proteins diffuse laterally within a fluid bilayer, and the tight junction belt is the physical barrier that normally halts that drift at the boundary between the two domains. The design isolates the fence role cleanly. Protein synthesis is blocked before the junctions are disturbed, so every tagged molecule detected afterward must already have been resident in the apical membrane, and the only variable changed is the presence of the junctional belt. When the tag then spreads over the entire cell surface, the interpretation best supported is that preexisting apical proteins diffused within the plane of the membrane past the line the belt used to occupy, mixing into the basolateral domain. (Choice B) Misdelivery of newly synthesized transporter to the wrong surface is a real sorting failure, but it requires new protein, and the inhibitor eliminates that source. This control is precisely what distinguishes lateral diffusion of old protein from misdirected trafficking of new protein. (Choice C) Disassembling the junctions opens an aqueous path between cells for small solutes, but an integral membrane protein is held in its own bilayer by hydrophobic transmembrane segments. It cannot dissolve into the intercellular fluid, travel to a neighboring cell, and reinsert there, so transfer between cells cannot explain the result. (Choice D) Inverting a protein's orientation is a transverse change: it would swap which side of one membrane the tagged domain faces. The observed change is lateral, a move from one region of the cell surface to another region of the same surface, and flipping a large folded protein across a bilayer is energetically prohibitive in any case. This is a Reasoning about the Design and Execution of Research question because it asks you to use the protein synthesis control to decide which mechanism of redistribution the experiment actually demonstrates.$q$,
    'hard',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    3,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$ignores the experimental control$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$confuses the opened seal with a protein transfer route$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$lateral versus transverse axis swap$q$ FROM q;

-- B2 Q23 . connexon hemichannel assembly . medium . skill 1 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$connexon hemichannel assembly$q$,
    $q$Connexin is an integral membrane protein that can assemble into channels linking adjacent epithelial cells. Which of the following statements about the architecture of one complete cell-to-cell channel is (are) accurate?

I. Within the membrane of a single cell, six connexin subunits oligomerize into a hemichannel called a connexon
II. A complete channel forms only when a connexon in one cell's membrane docks with a connexon in the adjacent cell's membrane
III. A complete channel contains twelve connexin subunits in total$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"I and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests the architecture of the gap junction channel, specifically the stoichiometry by which connexin subunits build the complete intercellular structure. The answer is D because all three statements are accurate descriptions of the assembly. Statement I is correct: within the plasma membrane of one cell, six connexin subunits oligomerize into a ring-shaped hemichannel called a connexon, with the central opening of the ring forming the pore. Statement II is correct: a connexon spans only the membrane in which it was assembled, so no single connexon can bridge two cells. A continuous conduit exists only after a connexon in one cell's membrane docks end to end with a connexon presented by the adjacent cell, and the paired assembly then passes through both plasma membranes. Statement III follows from the first two by simple arithmetic: two connexons per complete channel, each built from six connexins, gives twelve connexin subunits in the finished structure. (Choice A) Accepting only statement I stops at the hemichannel. It wrongly discards both the docking event that joins two connexons across the intercellular gap and the subunit total that this pairing produces. (Choice B) Rejecting statement III while accepting the other two is a counting error. If the complete channel is a pair of connexons and each connexon contains six subunits, the total must be twelve; six would describe only half of the structure. (Choice C) Rejecting statement II implies that one connexon by itself spans both membranes and connects the two cells. In fact a lone connexon is confined to a single membrane and is only a hemichannel; the cell-to-cell channel does not exist until two hemichannels contributed by neighboring cells pair with each other. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall the six-subunit connexon and the two-connexon pairing that together determine the subunit count of a complete gap junction channel.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    1,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$stops at the hemichannel$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'scale_unit_error', $q$miscounts the doubled stoichiometry$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$skips the pairing step in assembly$q$ FROM q;

-- B2 Q24 . hemidesmosome anchoring target contrast . easy . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$hemidesmosome anchoring target contrast$q$,
    $q$An experimental treatment causes a cultured epithelial sheet to detach from the underlying connective tissue as one intact, continuous layer, while the individual cells within the sheet remain tightly bound to their neighbors. Which junction did the treatment most likely disrupt?$q$,
    $q$[{"label":"A","text":"Desmosomes"},{"label":"B","text":"Hemidesmosomes"},{"label":"C","text":"Tight junctions"},{"label":"D","text":"Gap junctions"}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests the anchoring targets of epithelial junctions: which junction fastens a cell sideways to its neighbor and which fastens the sheet downward to the layer beneath it. The answer is B because the pattern of failure points to the cell-to-matrix attachment. The cells remain firmly bound to one another, so the lateral, cell-to-cell adhesions are still working; yet the whole sheet peels off the underlying connective tissue as one continuous layer, so the connection that failed must run from the basal surface of each cell to the basement membrane below. Hemidesmosomes are the junctions with exactly that target: they rivet the epithelium into the underlying extracellular matrix rather than into another cell, so their loss releases the intact sheet from its foundation while leaving every cell-to-cell contact in place. (Choice A) Desmosomes have the opposite anchoring target. They fasten a cell to an adjacent cell, resisting forces that would pull neighbors apart. If desmosomes had failed, the sheet would have separated into individual cells or fragments rather than lifting away in one piece, and the stem states that binding between neighbors is preserved. (Choice C) Tight junctions do form belts around epithelial cells, but their job is to close the space between cells against leakage of solutes. Losing them makes an epithelium leaky; it does not detach the layer from the tissue underneath, because they provide little of the mechanical anchorage in either direction. (Choice D) Gap junctions connect adjacent cells through paired connexons embedded in the two facing membranes. They are conduits rather than adhesive rivets, so their loss cannot account for a mechanical detachment of any kind, and they connect cell to cell rather than cell to matrix in any case. This is a Scientific Reasoning and Problem Solving question because it asks you to infer, from which attachments survived and which failed, the identity of the junction that anchors an epithelium to its basement membrane.$q$,
    'easy',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$swaps the two anchoring targets$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$real epithelial junction with the wrong function$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$treats a channel as an adhesive structure$q$ FROM q;

COMMIT;

-- Verification: expect 48 questions, 144 distractor rows, and letters 12/12/12/12.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'Biological Membranes') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'Biological Membranes') AS distractor_rows;

SELECT correct_answer, COUNT(*) FROM public.questions
WHERE topic = 'Biological Membranes' GROUP BY correct_answer ORDER BY correct_answer;
