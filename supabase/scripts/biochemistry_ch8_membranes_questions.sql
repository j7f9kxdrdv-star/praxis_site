-- Biochemistry Chapter 8: Biological Membranes, standalone questions
-- BATCH 1 of 2 (24 questions): fluid mosaic model and lateral dynamics (heterokaryon/FRAP,
--   temperature fluidity, flip-flop) . asymmetry, flippases, rafts, the self-sealing bilayer .
--   composition and the mitochondrial architecture contrast . membrane protein classification,
--   anchors and GPI . insertion topology (hydropathy, stop-transfer, protease protection).
--
-- CHAPTER SIZE: 48 questions in two batches of 24, per the Step 1 pre-flight: roughly a third of
-- the source chapter is contractually or live-key foreclosed (cholesterol-fluidity = Biochem Ch5;
-- resting potential and the pump = Bio Ch4; Nernst arithmetic = GenChem Ch12; inner-membrane
-- respiration consequences = Biochem Ch10). What Ch8 owns: dynamics/asymmetry, the protein
-- classification and topology units formally granted by the Ch7 reservation, transport taxonomy,
-- vesicle topology, tight junctions. FOUNDER DECISION recorded in the plan: Ch8 takes the
-- osmotic-pressure computation (batch 2); the future GenChem Ch9 Solutions bank keeps the other
-- colligative computations. See biochemistry_ch8_membranes_questions.plan.md for the audit trail.
--
-- !! BATCH 1 OWNS THE CHAPTER DELETE !! Batch 2 is pure INSERTs and runs after this file.

BEGIN;

DELETE FROM public.questions WHERE topic = 'Biological Membranes';

-- Q1 . Fluid mosaic model dynamic predictions . easy . skill 1 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Fluid mosaic model dynamic predictions$q$,
    $q$Early models depicted the plasma membrane's proteins as a continuous rigid coat cemented onto both faces of the lipid bilayer. To test this picture against the Singer and Nicolson model, a researcher attaches a fluorescent tag to one type of integral protein in a living cell and records the tag's location every few seconds for ten minutes. Which observation would be predicted by the fluid mosaic model but not by the rigid coat model?$q$,
    $q$[{"label":"A","text":"The tag occupies the same spot in every frame across the full ten minute recording."},{"label":"B","text":"The tagged protein relocates to the cytoplasmic face of the membrane within a few minutes."},{"label":"C","text":"The tagged protein turns up at new sites in the plane of the membrane as the recording proceeds."},{"label":"D","text":"The tagged protein leaves the bilayer and diffuses through the cytosol as a soluble globule."}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests the defining prediction of the Singer and Nicolson fluid mosaic model, namely that membrane components are mobile within the plane of the bilayer. The answer is C because the fluid mosaic model treats integral proteins as separate bodies floating in a two dimensional lipid fluid, much like tiles suspended in a slowly flowing liquid rather than cemented into a wall. If that picture is right, thermal motion should carry a tagged protein to new places in the membrane over a ten minute recording. A rigid coat model makes the opposite prediction, since a protein locked into a continuous sheet has nowhere to go. The same fluidity explains why a membrane flows back and self seals after a fine needle is withdrawn, underscoring that mobility is a constant structural property of the bilayer, not an occasional event. Observing sideways wandering therefore supports the fluid mosaic model specifically, which is why this simple tracking design can distinguish the two ideas. (Choice A) A tag that never changes position is exactly what the rigid coat model predicts. This outcome would argue for a static membrane and against the fluid mosaic model, so it is the reverse of the prediction being tested. (Choice B) Appearance of the protein on the cytoplasmic face would require the protein to flip across the bilayer, dragging its polar and charged surfaces through the hydrophobic interior. Neither model predicts this, because the energetic cost makes transverse movement of an intact protein essentially nonexistent, and flipping is a different kind of motion from the in plane mobility the model asserts. (Choice D) Integral proteins are held in the membrane by hydrophobic transmembrane segments that are unstable in water. The fluid mosaic model describes motion within the membrane, not release of embedded proteins into the aqueous cytosol as soluble globules. This is a Knowledge of Scientific Concepts and Principles question because it requires recalling that the fluid mosaic model predicts lateral movement of membrane components and applying that prediction to a single tracked protein.$q$,
    'easy',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$static model prediction$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$lateral versus transverse swap$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$membrane escape$q$ FROM q;

-- Q2 . Cell fusion protein intermixing experiment . medium . skill 3 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Cell fusion protein intermixing experiment$q$,
    $q$A mouse cell whose surface proteins carry a green fluorescent marker is fused with a human cell whose surface proteins carry a red marker, and immediately after fusion each color occupies its own half of the hybrid cell surface. After forty minutes at 37 degrees Celsius, green and red signals are uniformly intermingled over the entire hybrid surface, and the same result is obtained when protein synthesis is blocked throughout the experiment. Which conclusion does this result most directly support?$q$,
    $q$[{"label":"A","text":"Fusion stimulates insertion of newly made proteins at random positions across the hybrid surface."},{"label":"B","text":"Surface proteins are held in a fixed lattice whose expansion during fusion repositions them."},{"label":"C","text":"Each protein reaches the opposite hemisphere by repeatedly flipping between the outer and inner leaflets."},{"label":"D","text":"Proteins embedded in the bilayer diffuse within the membrane plane rapidly enough to redistribute within an hour."}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests interpretation of the classic cell fusion experiment that established lateral mobility of membrane proteins. The answer is D because the only requirement for the observed intermixing is that each cell's surface proteins be free to diffuse within the continuous membrane of the hybrid. At the moment of fusion the two protein populations start in separate hemispheres, so any process that scatters them uniformly in forty minutes must move existing proteins sideways through the bilayer plane. Because the same mixing occurs when protein synthesis is blocked, the redistribution cannot depend on making new protein, leaving diffusion of the preexisting molecules as the supported conclusion. This is precisely the dynamic behavior the fluid mosaic model requires and a static membrane architecture cannot produce, which is why this experiment became foundational evidence for the model. (Choice A) Random insertion of newly made proteins could in principle blur the boundary between the two hemispheres, which is exactly why the inhibitor control matters in this design. Since mixing is unchanged when synthesis is blocked, new insertion is ruled out as the explanation for the redistribution. (Choice B) A fixed lattice that merely expands would keep each protein on its original side while spreading the pattern out, preserving the two color separation rather than producing uniform intermingling. This choice also assumes the static membrane picture that the observation itself contradicts. (Choice C) Flipping between leaflets is transverse movement, which changes which face of the membrane a molecule occupies but does not carry it around the cell surface to the opposite hemisphere. Transverse crossing by a large protein with polar and charged surfaces is also vanishingly rare, so it cannot account for redistribution over the whole hybrid within forty minutes. This is a Reasoning about the Design and Execution of Research question because it asks you to identify which conclusion the cell fusion experiment can and cannot support given the protein synthesis control.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    3,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$ignores the control$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$static lattice picture$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$flip-flop as travel$q$ FROM q;

-- Q3 . Protein versus lipid lateral mobility . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Protein versus lipid lateral mobility$q$,
    $q$Within the plasma membrane of a single cultured cell, a fluorescent lipid probe redistributes over the whole cell surface within about a minute, while a fluorescently tagged transmembrane protein requires many minutes, and roughly one third of the protein copies do not measurably move at all. Neither molecule is covalently linked to any other membrane component, and the membrane is well above its transition temperature. Which explanation accounts for both the protein's slower diffusion and its immobile fraction?$q$,
    $q$[{"label":"A","text":"The protein's bulk drags a much larger cross section through the viscous bilayer, and copies bound to the underlying cytoskeleton are held in place."},{"label":"B","text":"The protein must flip to the inner leaflet and back with each step of movement, while lipids move without flipping."},{"label":"C","text":"The lipid probe is carried by motor proteins that do not recognize transmembrane proteins."},{"label":"D","text":"The immobile protein copies occupy gel phase patches that form spontaneously at physiological temperature."}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests why integral proteins diffuse laterally far more slowly than lipids and why some protein copies do not move at all. The answer is A because both observations follow from the physical situation of a transmembrane protein. A lipid is a small molecule occupying a tiny area of one leaflet, so it slips past its neighbors quickly, whereas a transmembrane protein spans the whole bilayer and presents a far larger cross section that must push through the viscous lipid environment, slowing its diffusion far below the lipid's rate. In cells a second constraint applies as well. On the membrane's interior face, some proteins serve to anchor the membrane to cytoskeletal fibers, and copies engaged in such attachments are effectively parked, producing an immobile fraction even though the surrounding lipid remains fully fluid. Size explains the slow movers and anchoring explains the nonmovers, so a single answer accounts for both findings. (Choice B) Lateral diffusion takes place entirely within the plane of the membrane and never requires crossing between leaflets. Flipping is a separate and extremely slow transverse process, and it is not a step in sideways movement for either lipids or proteins, so it cannot explain the observed rate difference. (Choice C) Lateral diffusion of lipids is passive thermal motion, not motor driven transport. No motor system carries lipid probes through the bilayer, so the probe's speed reflects its small size, not active delivery. (Choice D) Gel phase regions would indeed slow diffusion, but the stem states that the membrane is well above its transition temperature, where the bilayer is in the fluid state throughout. Invoking a gel phase contradicts the given conditions, so it cannot be the source of the immobile fraction. This is a Scientific Reasoning and Problem Solving question because it requires linking two separate observations, slow diffusion and an immobile fraction, to a single physical explanation involving protein size and cytoskeletal tethering.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$flip-flop inserted into lateral path$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$active transport of lipids$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$true fact, wrong conditions$q$ FROM q;

-- Q4 . Bilayer phase transition diffusion data . hard . skill 4 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Bilayer phase transition diffusion data$q$,
    $q$Vesicles were prepared from a single purified synthetic phospholipid, and the lateral diffusion coefficient of a fluorescent lipid probe embedded in the vesicle membrane was measured at five temperatures. The values obtained were 0.010 micrometers squared per second at 25 degrees Celsius, 0.012 at 31 degrees, 0.015 at 37 degrees, 2.6 at 45 degrees, and 3.1 at 50 degrees. Which conclusion is best supported by these data?$q$,
    $q$[{"label":"A","text":"Probe diffusion increases in direct proportion to temperature over the range tested."},{"label":"B","text":"The bilayer converts from a tightly packed, ordered state to a fluid state at a transition temperature between 37 and 45 degrees Celsius."},{"label":"C","text":"The vesicles rupture above 40 degrees Celsius, allowing the probe to move freely through the surrounding solution."},{"label":"D","text":"Above 40 degrees Celsius, the probe crosses between the two leaflets as rapidly as it moves within one leaflet."}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests recognition of a lipid phase transition from lateral diffusion data measured at different temperatures. The answer is B because the data show two distinct regimes rather than one continuous trend. From 25 to 37 degrees Celsius, the diffusion coefficient creeps from 0.010 to 0.015 micrometers squared per second, an increase of only fifty percent over twelve degrees. Between 37 and 45 degrees, it leaps more than one hundred fold to 2.6, and then rises only modestly to 3.1 at 50 degrees. A jump of that size over a narrow temperature window is the signature of a cooperative phase change: below the transition temperature the acyl chains are tightly packed in an ordered gel state in which lipids barely move, and above it the bilayer is a liquid crystalline fluid in which lipids diffuse rapidly. The melting temperature of this lipid must therefore lie between 37 and 45 degrees Celsius. (Choice A) Diffusion does rise with temperature, which makes this choice partly true, but direct proportion predicts a smooth, steady increase. The data instead show nearly flat behavior on either side of a single enormous jump, a pattern that proportionality cannot produce. (Choice C) Bilayer vesicles pass through their melting transition intact, in the same way that ice melts to liquid water without the water ceasing to exist; the transition changes chain packing, not the vesicle's existence. The measurement also tracks a probe embedded in the membrane, so the reported coefficients reflect movement within the bilayer rather than escape into the surrounding solution. (Choice D) The experiment measures lateral diffusion only and contains no information about movement between leaflets. Transverse flip-flop remains many orders of magnitude slower than lateral diffusion even in a fully fluid membrane, because it requires a polar head group to cross the hydrophobic core. This is a Data-based and Statistical Reasoning question because it requires comparing diffusion coefficients across temperatures and recognizing that a discontinuous jump indicates a phase transition rather than a gradual trend.$q$,
    'hard',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    4,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$smooth trend imposed on a jump$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$structure destroyed at transition$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$lateral data read as transverse$q$ FROM q;

-- Q5 . Lateral versus transverse lipid movement . hard . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Lateral versus transverse lipid movement$q$,
    $q$A phospholipid molecule resides in the outer leaflet of a protein free synthetic bilayer held well above its transition temperature. Consider the following statements about the molecule's possible movements:

I. It diffuses past neighboring lipids within its own leaflet fast enough to travel a distance equal to the length of a bacterial cell in about one second, without any protein assistance.
II. Its arrival in the inner leaflet is rare on a timescale of hours because the polar head group must pass through the hydrophobic interior.
III. Its arrival in the inner leaflet occurs about as rapidly as its lateral movement within its own leaflet, since thermal energy drives both movements.

Which of the statements accurately describe(s) the movement of this molecule?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I and II only"}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests the contrast between lateral diffusion within a leaflet and transverse flip-flop between leaflets, together with the energetic reason for the difference. The answer is D because statements I and II are both true and statement III is false. Statement I is true: within its own leaflet, a phospholipid diffuses laterally at a very high rate, fast enough to traverse the length of an entire bacterial cell in about one second, and this motion is purely thermal, requiring no protein catalyst. Statement II is also true: to reach the inner leaflet, the lipid must rotate so that its polar, often charged head group passes through the nonpolar hydrocarbon interior of the bilayer, an energetically costly event, so uncatalyzed flip-flop in a protein free bilayer happens only on a timescale of hours or longer. Statement III is false because it equates the two rates; lateral and transverse movement differ by many orders of magnitude precisely because only the transverse route forces polar groups through the hydrophobic core. Sharing a thermal energy source does not make two processes equally fast when their activation barriers differ so drastically. (Choice A) Statement I is correct, but this option wrongly excludes statement II, which accurately captures both the rarity of flip-flop and its energetic cause, the polar head group crossing the nonpolar interior. (Choice B) Statement II is correct, but this option wrongly excludes statement I; rapid, unassisted movement past neighbors inside one leaflet is a defining feature of a fluid bilayer above its transition temperature. (Choice C) This option includes statement III, which fails because a shared thermal driving force cannot overcome the vastly higher barrier of pushing a polar head group through the hydrophobic interior at anything close to the lateral rate; in living cells, rapid transverse movement occurs only when protein catalysts assist it. This is a Scientific Reasoning and Problem Solving question because it requires evaluating each statement against the energetic logic that distinguishes movement within a leaflet from movement between leaflets.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$true statement, incomplete set$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$true statement, incomplete set$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$equal rates from shared driver$q$ FROM q;

-- Q6 . Flippase loss and asymmetry decay . hard . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Flippase loss and asymmetry decay$q$,
    $q$In resting erythrocytes, phosphatidylserine is confined almost entirely to the cytoplasmic leaflet, and spontaneous transverse movement of phospholipids between leaflets occurs but is extremely slow. A researcher treats these cells with a drug that irreversibly inactivates their ATP-dependent flippases without affecting passive lipid movement or activating scramblases. What is the expected fate of the phosphatidylserine distribution after treatment?$q$,
    $q$[{"label":"A","text":"It remains confined to the cytoplasmic leaflet indefinitely, because phospholipids cannot cross the hydrophobic core without protein catalysis."},{"label":"B","text":"It slowly becomes more symmetric, as uncorrected spontaneous transverse movement carries phosphatidylserine into the exoplasmic leaflet."},{"label":"C","text":"It equilibrates between the two leaflets within seconds, because membrane phospholipids diffuse rapidly past their neighbors."},{"label":"D","text":"It becomes even more concentrated in the cytoplasmic leaflet, because flippases normally export phosphatidylserine to the cell surface."}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests the logic that connects flippase activity to the creation and maintenance of leaflet asymmetry. The answer is B because leaflet asymmetry is not a permanent structural feature of the bilayer; it is a steady state that dedicated transporters must continuously defend. Spontaneous transverse movement of a phospholipid, in which the polar head group must pass through the hydrophobic core, is orders of magnitude slower than lateral diffusion, but it still happens at a low rate. In a healthy cell, ATP-dependent flippases capture any phosphatidylserine that strays into the exoplasmic leaflet and return it to the cytoplasmic side, moving it against its concentration gradient at the cost of ATP. Once the flippases are inactivated, that corrective transport disappears while the slow spontaneous leak continues, so phosphatidylserine gradually appears on the cell surface and the distribution drifts toward symmetry over days. Cells spend energy to prevent exactly this outcome, since surface exposed phosphatidylserine marks a cell for clearance and promotes clotting. (Choice A) This is the misconception that the hydrophobic core is an absolute barrier to transverse movement. Uncatalyzed flip-flop is rare, not impossible, which is precisely why asymmetry requires active maintenance rather than being self-sustaining. (Choice C) This confuses lateral diffusion with transverse diffusion. Lipids exchange places with neighbors within one leaflet in microseconds, but crossing between leaflets forces the polar head through the nonpolar interior and takes hours to days without catalysis, so equilibration within seconds is off by many orders of magnitude. (Choice D) This reverses the direction of flippase transport. Flippases move aminophospholipids such as phosphatidylserine inward to the cytoplasmic leaflet; outward movement is handled by different transporters, so losing flippase activity cannot concentrate phosphatidylserine further inside. This is a Scientific Reasoning and Problem Solving question because it requires predicting the time-dependent consequence of removing an active maintenance process from a system with a slow passive leak.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- Q7 . Glycan sidedness accessibility evidence . medium . skill 4 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Glycan sidedness accessibility evidence$q$,
    $q$A membrane-impermeant glycosidase removes terminal sugars only from glycans it can physically contact. When intact erythrocytes are treated with the enzyme, 98 percent of the membrane's total carbohydrate is released. When sealed inside-out vesicles prepared from the same membranes are treated instead, only 2 percent is released. What do these results indicate about the location of the membrane carbohydrates?$q$,
    $q$[{"label":"A","text":"They face the cytosol, since the sealed inside-out vesicles protected them from digestion."},{"label":"B","text":"They are distributed equally between the two faces, and the low vesicle signal reflects inactivation of the glycosidase during membrane isolation."},{"label":"C","text":"They are attached to lipids rather than to proteins, since they remained membrane-associated after cell lysis."},{"label":"D","text":"They occupy almost exclusively the extracellular face, with the small vesicle signal attributable to incompletely sealed or right-side-out contaminants."}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests how accessibility data from a membrane-impermeant probe establish the sidedness of membrane carbohydrates. The answer is D because each preparation presents exactly one face of the membrane to an enzyme that cannot cross the bilayer. An intact erythrocyte exposes only its extracellular face, and there the glycosidase reached 98 percent of the total carbohydrate. A sealed inside-out vesicle exposes only the cytoplasmic face, and there the enzyme reached almost nothing. The only placement consistent with both numbers is that membrane carbohydrates sit almost exclusively on the extracellular face, where the sugar chains of glycoproteins and glycolipids project outward to form the glycocalyx that serves cell recognition and protection. The 2 percent released from the vesicle preparation is best explained by imperfections in the preparation, such as vesicles that failed to seal or that reformed right-side out, rather than by a genuine cytoplasmic glycan population. (Choice A) This reads the geometry backwards. Inside-out vesicles expose the cytoplasmic face to the enzyme, so if the glycans faced the cytosol they would have been digested in the vesicle experiment and protected on intact cells, the opposite of what was observed. (Choice B) An equal distribution would predict roughly half of the carbohydrate released in each condition, not a 98 to 2 split, and invoking enzyme inactivation during isolation is an uncontrolled excuse the data do not support, since the same enzyme stock digests any substrate it can reach. (Choice C) Whether the sugars ride on proteins or on lipids is a real distinction among membrane glycoconjugates, but it is irrelevant here; the experiment measures which face the glycans occupy, not which class of molecule carries them. This is a Data-based and Statistical Reasoning question because it asks you to infer the sided location of membrane glycans from quantitative accessibility measurements taken in two opposite membrane orientations.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    4,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q;

-- Q8 . Lipid raft physical organization . easy . skill 1 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Lipid raft physical organization$q$,
    $q$Treatment of plasma membranes with cold nonionic detergent leaves behind insoluble patches enriched in sphingolipids, cholesterol, and specific anchored proteins, while the surrounding bilayer dissolves away. These resistant patches correspond to microdomains present in the intact membrane of the living cell. In the living cell, how does the lipid organization inside such a patch compare with that of the surrounding bilayer?$q$,
    $q$[{"label":"A","text":"Its lipids are more tightly packed and more ordered, forming a thicker, less fluid region that still moves within the plane of the membrane."},{"label":"B","text":"Its lipids are covalently crosslinked into a rigid lattice that is permanently fixed at one location on the cell surface."},{"label":"C","text":"Its lipids are more loosely packed and more disordered, making the patch more fluid than the bulk membrane around it."},{"label":"D","text":"Its lipids recruit anchored proteins but pack identically to the surrounding bilayer, differing from it only in composition."}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests what a lipid raft is relative to the bulk membrane that surrounds it. The answer is A because rafts are organized microdomains: patches in which the lipids pack more efficiently and adopt a more ordered arrangement than the surrounding bilayer, producing a region that is thicker, more rigid, and less fluid, yet still a noncovalent assembly that drifts laterally within the plane of the membrane. Membrane biophysicists describe the raft as a liquid ordered phase coexisting with the surrounding liquid disordered phase. The long, largely saturated chains of raft sphingolipids extend further than typical bulk chains, which contributes to the greater thickness of these patches. That tight packing is exactly why rafts survive cold detergent treatment while the loosely packed bulk membrane dissolves, and it is why rafts selectively gather certain anchored proteins into one place. The raft concept refines rather than replaces the fluid mosaic model: the membrane remains a two-dimensional fluid, but it is a patchy fluid containing regions of differing order. (Choice B) Rafts are held together by noncovalent packing interactions, not covalent crosslinks, and they are dynamic structures that form, move, and disperse; nothing anchors a raft permanently to one location. (Choice C) This inverts the relationship. A raft is more ordered and less fluid than its surroundings; a patch looser and more disordered than the bulk would be the first material dissolved by detergent rather than the fraction that resists it. (Choice D) The enrichment in anchored proteins is genuine, but it is a consequence of the altered lipid environment rather than the whole story; the defining feature of a raft is precisely that its lipid packing differs from the bulk, which is what the detergent resistance described in the stem demonstrates. This is a Knowledge of Scientific Concepts and Principles question because it asks for the defining physical organization of a lipid raft microdomain compared with the bulk fluid bilayer.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q9 . Raft co-clustering of signaling partners . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Raft co-clustering of signaling partners$q$,
    $q$A GPI-anchored receptor and the transmembrane adaptor protein it activates both partition into the same cholesterol- and sphingolipid-rich microdomains of the plasma membrane. When these microdomains are dispersed by extracting membrane cholesterol, activation of the adaptor drops sharply, even though both proteins remain in the membrane and each retains full activity when tested in isolation. What function was the microdomain serving in this pathway?$q$,
    $q$[{"label":"A","text":"It chemically catalyzed the activation step, acting as a lipid cofactor required for the reaction itself."},{"label":"B","text":"It accelerated both proteins' lateral diffusion so that they could scan the entire membrane surface more quickly."},{"label":"C","text":"It concentrated the receptor and the adaptor within one small patch, raising their local density and encounter frequency."},{"label":"D","text":"It translocated the GPI-anchored receptor across the bilayer so that it could bind the adaptor's cytosolic domain directly."}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests the functional consequence of raft association for membrane signaling proteins. The answer is C because the microdomain acts as a meeting place. Partitioning both the receptor and its adaptor into the same small patch raises the local concentration of each far above its average across the whole cell surface, so productive encounters become frequent. Signaling between membrane proteins depends on collision: two molecules diluted across the entire membrane meet rarely, while the same two molecules confined to a shared microdomain meet constantly. Dispersing the raft does not damage either protein, which is why each retains full activity in isolation; dispersal simply dilutes the partners back into the bulk membrane, dropping their encounter frequency and with it the rate of adaptor activation. This concentrating role is a general theme, since rafts gather receptors, lipid-anchored proteins, and their downstream partners into one patch so that pathways fire efficiently. (Choice A) Lipid microdomains are not catalysts; the chemistry of activation is carried out by the proteins themselves, and the stem establishes that both proteins are fully functional, so no catalytic cofactor was lost. (Choice B) This reverses both the raft's physical character and its purpose. Rafts are more ordered and more tightly packed than bulk membrane, and their value comes from confining partners together, not from speeding proteins across the whole surface; scattering the partners across the membrane is what actually impaired signaling after dispersal. (Choice D) GPI anchors hold proteins on the outer leaflet, and no raft process flips a GPI-anchored protein across the bilayer; communication with the cytosolic side runs through transmembrane partners such as the adaptor itself, which is exactly why the pathway needs both proteins gathered in the same patch. This is a Scientific Reasoning and Problem Solving question because it requires deducing from a dispersal experiment that the raft's contribution was to co-concentrate intact signaling partners rather than to alter either protein's intrinsic activity.$q$,
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
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q10 . Self-sealing bilayer edge energetics . easy . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Self-sealing bilayer edge energetics$q$,
    $q$Phospholipids dispersed in water assemble into extended bilayer sheets, yet a flat sheet is never the stable end state; the sheets curve and close into fluid-filled vesicles. Similarly, when a cell's plasma membrane is punctured by a fine microneedle, the bilayer rapidly reseals around the wound. What energetic factor drives both behaviors?$q$,
    $q$[{"label":"A","text":"Rim phospholipids form covalent bonds with one another, and the energy released by bond formation drives closure."},{"label":"B","text":"A flat sheet terminates in free edges where fatty acyl tails contact water, and closing into a continuous surface eliminates that unfavorable exposure."},{"label":"C","text":"The polar head groups are repelled by water and pull the sheet closed so that they can occupy the dry interior of the membrane."},{"label":"D","text":"Dedicated ATP-driven enzymes stitch the sheet closed, so sealing proceeds only when the cell supplies metabolic energy."}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests the energy logic behind the self-sealing behavior of lipid bilayers. The answer is B because a flat bilayer sheet must terminate somewhere, and at every free edge the fatty acyl tails of the rim lipids stand exposed to water. Hydrophobic surface in contact with water is energetically costly, chiefly because water molecules must organize themselves around the nonpolar chains at an entropic penalty. A sheet that curves and closes on itself becomes a continuous surface with no rim at all: every tail is buried in the bilayer interior and every head group faces water. The closed vesicle is therefore lower in energy than any flat sheet built from the same lipids, and the identical logic explains resealing, since a puncture creates new exposed edge that the fluid bilayer spontaneously eliminates by flowing back together. No enzyme, template, or energy input is required; sealing is a physical consequence of the hydrophobic effect acting on a fluid, noncovalent assembly, which is why pure lipid vesicles with no proteins at all behave the same way. (Choice A) Bilayer assembly and closure are entirely noncovalent. Phospholipids in a membrane are held together by the hydrophobic effect and van der Waals contacts between chains, and no bonds form between neighboring lipids during sealing. (Choice C) This inverts the polarity roles. The head groups are hydrophilic and remain in contact with water on both surfaces of the closed vesicle; it is the tails that avoid water, and the membrane interior is occupied by tails, not head groups. (Choice D) This confuses spontaneous physical self-assembly with protein-catalyzed membrane events. Cells do use ATP-driven machinery for tasks such as moving specific lipids between leaflets, but bilayer closure and resealing occur in protein-free lipid systems, so no metabolic energy is needed. This is a Scientific Reasoning and Problem Solving question because it requires applying the energetic cost of exposed hydrophobic surface to explain why bilayers close into vesicles and reseal after disruption.$q$,
    'easy',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q11 . Protein-to-lipid ratio versus membrane function . hard . skill 4 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Protein-to-lipid ratio versus membrane function$q$,
    $q$Compositional analysis of three human membranes gives the following protein mass fractions: myelin, the membrane outgrowth that wraps and insulates peripheral axons, 18 percent; the plasma membrane of a typical human cell, about 50 percent; the inner mitochondrial membrane, 76 percent. Lipid accounts for most of the remaining mass in each case. Which conclusion about membrane organization do these measurements best support?$q$,
    $q$[{"label":"A","text":"Protein fraction reflects how tightly a membrane must seal its compartment, so the most protein-rich of the three is the most effective diffusion barrier."},{"label":"B","text":"Bilayer architecture fixes membrane protein content near one half by mass, so the myelin and inner mitochondrial values indicate contaminated preparations."},{"label":"C","text":"The mass fraction a membrane devotes to protein scales with the amount of catalytic and transport work that membrane performs."},{"label":"D","text":"A bilayer cannot remain continuous below roughly 40 percent lipid by mass, so the inner mitochondrial fraction must include nonmembrane protein aggregates."}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests whether the protein-to-lipid ratio of a membrane can be read as a signature of that membrane's functional workload. The answer is C because the three measurements form a single directional trend that tracks each membrane's job. Every biological membrane uses a lipid bilayer as its structural fabric, so the lipid fraction is the shared backdrop; what varies is how much protein machinery is embedded in and on that fabric. Myelin exists to wrap axons in an electrically insulating sheath, a task performed by the lipid itself, and it carries the lowest protein load at 18 percent. A typical plasma membrane balances barrier duty against transport, adhesion, and signaling, and sits near one half protein. The inner mitochondrial membrane is packed edge to edge with enzymatic and transport complexes, and its protein fraction climbs to 76 percent, the highest of the three. Reading across the series, the mass a membrane devotes to protein rises exactly as its catalytic and transport responsibilities rise, which is the inference stated in choice C. (Choice A) reverses the relationship between protein content and barrier quality. Sealing a compartment is the work of the lipid bilayer itself; every embedded protein is a potential crossing point or catalytic site rather than a caulking agent. The strongest insulator in the data set, myelin, is also the most protein-poor membrane listed, the opposite of what this choice predicts. (Choice B) converts a typical value into a structural law. Roughly half protein describes an average plasma membrane, but composition genuinely varies from membrane to membrane; the myelin and inner mitochondrial values are reproducible biology measured across many preparations, not artifacts of contamination. (Choice D) invents a threshold that does not exist. There is no minimum lipid percentage near 40 percent required for bilayer continuity; the inner mitochondrial membrane forms a continuous, fully functional bilayer at roughly one quarter lipid by mass because its proteins are accommodated within and across the bilayer rather than displacing it. This is a Data-based and Statistical Reasoning question because it asks you to extract a directional trend from compositional measurements on three membranes and to test each proposed conclusion against both the numbers themselves and the known workload of each membrane.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$function-inverted barrier logic$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$average mistaken for rule$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$invented structural threshold$q$ FROM q;

-- Q12 . Porin basis of outer membrane leakiness . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Porin basis of outer membrane leakiness$q$,
    $q$Intact mitochondria isolated from liver cells are suspended in a buffer containing a radiolabeled disaccharide of approximately 340 daltons. Within seconds the label equilibrates across the outermost mitochondrial membrane and distributes throughout the intermembrane space, yet it never reaches the matrix. Which structural feature of the outer membrane accounts for the rapid equilibration?$q$,
    $q$[{"label":"A","text":"It is organized as a single phospholipid leaflet rather than a bilayer, leaving no continuous hydrophobic core to exclude polar molecules."},{"label":"B","text":"It contains abundant proteins folded into barrel-shaped aqueous channels that admit essentially any solute below a size cutoff."},{"label":"C","text":"Its surface translocase complexes recognize the tracer and actively thread it across the membrane in an extended conformation."},{"label":"D","text":"Its leaflets are enriched in cardiolipin, which loosens acyl-chain packing enough for small polar molecules to pass between lipids."}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests the structural basis for the outer mitochondrial membrane's permissiveness toward small molecules. The answer is B because the outer membrane is riddled with barrel-shaped channel proteins, the porins, whose most abundant representative is the voltage-dependent anion channel, itself the most plentiful protein in that membrane. Each porin folds as a beta barrel whose interior forms a wide, water-filled pore spanning the membrane. Passage through such a pore is governed almost entirely by size: any solute small enough to fit, including sugars, metabolic intermediates, nucleotides, and ions, diffuses through without a receptor, a conformational cycle, or an energy input. A 340 dalton disaccharide falls well under the cutoff, so it equilibrates into the intermembrane space within seconds of mixing. The same molecule is stopped at the inner membrane, which lacks comparable open channels, and that is why the matrix stays label-free. (Choice A) misstates the architecture. The outer membrane is a true phospholipid bilayer with a continuous hydrophobic core; its leakiness comes from proteinaceous pores that let solutes bypass the lipid, not from a missing leaflet. (Choice C) describes the wrong machinery. Translocase complexes of the outer membrane import polypeptides bearing targeting signals, threading them across in an unfolded state; a disaccharide carries no targeting information, and its passage here is passive, unassisted, and far too fast for a recognition-based import cycle. (Choice D) misattributes the behavior to the lipids. Cardiolipin is a genuine mitochondrial membrane lipid, but loosened acyl-chain packing cannot move a polar 340 dalton sugar across a hydrophobic core within seconds; permeation that rapid and that size-governed is the signature of an aqueous protein pore, not of lipid disorder. This is a Scientific Reasoning and Problem Solving question because it requires connecting an experimental observation, the rapid size-limited equilibration of a tracer into one compartment but not another, to the specific membrane architecture capable of producing it.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$monolayer myth$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$protein-import machinery misapplied$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$misplaced mitochondrial lipid$q$ FROM q;

-- Q13 . Inner mitochondrial membrane compositional contrast . easy . skill 1 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Inner mitochondrial membrane compositional contrast$q$,
    $q$A researcher purifies inner mitochondrial membranes from hepatocytes and compares their bulk composition with that of plasma membranes from the same cells. Which of the following compositional features would be expected to distinguish the inner mitochondrial membrane from the plasma membrane?

I. Protein contributes a greater fraction of membrane mass than lipid does
II. Cholesterol is essentially absent
III. A carbohydrate coat covers the matrix-facing surface$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II and III only"},{"label":"C","text":"I and III only"},{"label":"D","text":"I and II only"}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests knowledge of the compositional contrast between the inner mitochondrial membrane and the plasma membrane. The answer is D because statements I and II are both genuine distinguishing features while statement III is false. For statement I, the inner mitochondrial membrane is among the most protein-rich membranes in the cell, with protein contributing roughly three quarters of its mass and lipid only about one quarter, so protein clearly outweighs lipid; in the plasma membrane the two components are closer to an even split, and lipid is never so severely outweighed. For statement II, cholesterol is a characteristic sterol of the animal plasma membrane but is essentially absent from the inner mitochondrial membrane, whose small lipid fraction is built almost entirely of phospholipids, a profile consistent with the bacterial ancestry of the organelle. Statement III fails on sidedness: membrane carbohydrate occurs as glycoproteins and glycolipids restricted to the extracellular face of the plasma membrane, and no carbohydrate coat lines the matrix side of the inner mitochondrial membrane, so III describes neither membrane correctly. (Choice A) accepts the exceptional protein density but omits the sterol difference; a membrane fraction lacking cholesterol while the comparison fraction is cholesterol-rich is exactly the kind of bulk compositional difference this purification would reveal, so stopping at statement I undercounts the contrasts. (Choice B) pairs the true cholesterol statement with the false carbohydrate statement while discarding the true protein statement; it treats a carbohydrate coat as a universal membrane feature when glycosylation is confined to the cell's exterior surface. (Choice C) keeps the protein statement but swaps the true sterol statement for the false carbohydrate one, reflecting the tempting but incorrect assumption that every membrane in an animal cell must contain cholesterol simply because the cell as a whole is rich in it. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall the defining compositional facts of the inner mitochondrial membrane, namely its protein dominance, its lack of cholesterol, and the strictly extracellular location of membrane carbohydrate.$q$,
    'easy',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    1,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$incomplete true subset$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$false statement retained, true dropped$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$cholesterol assumed universal$q$ FROM q;

-- Q14 . Wax classification from hydrolysis products . easy . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Wax classification from hydrolysis products$q$,
    $q$The glossy cuticle on the leaves of a desert shrub limits evaporative water loss. Exhaustive hydrolysis of the cuticle's most abundant lipid releases equimolar amounts of a straight-chain C28 carboxylic acid and a straight-chain C30 primary alcohol. To which lipid class does the intact molecule belong?$q$,
    $q$[{"label":"A","text":"Wax"},{"label":"B","text":"Triacylglycerol"},{"label":"C","text":"Sphingolipid"},{"label":"D","text":"Glycerophospholipid"}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests lipid classification from hydrolysis products, specifically recognition of a wax. The answer is A because a wax is defined chemically as a single ester formed between one very long-chain fatty acid and one long-chain alcohol. Hydrolyzing the one ester bond in such a molecule returns exactly two products in a one to one ratio: the free fatty acid and the free alcohol. A C28 carboxylic acid plus a C30 primary alcohol in equimolar amounts is precisely that signature, and chain lengths in the C20 to C34 range are characteristic of the plant cuticle, where these esters pack into a hydrophobic surface layer that blocks water from escaping or adhering. Waxes play similar protective and waterproofing roles on insect exoskeletons, bird feathers, and the vertebrate ear canal, but the classification here follows from the chemistry of the products, not from the biological setting. (Choice B) also names an ester lipid, but a triacylglycerol is built on a glycerol backbone carrying three fatty acids; its complete hydrolysis yields glycerol plus three fatty acid equivalents and no long-chain alcohol, so the observed one to one acid to alcohol ratio excludes it. (Choice C) points to a lipid family with long hydrocarbon chains, but a sphingolipid is built on a sphingosine backbone with its fatty acid attached through an amide bond; hydrolysis would release sphingosine and, for most family members, a polar head group, none of which appears among the observed products. (Choice D) reflects the assumption that any biologically important lipid must be a membrane phospholipid; a glycerophospholipid would surrender glycerol, phosphate, a polar head alcohol, and two fatty acids on hydrolysis, a product inventory very different from a single acid paired with a single long-chain alcohol. This is a Scientific Reasoning and Problem Solving question because it requires working backward from an inventory of hydrolysis products to the one lipid architecture that could have produced them.$q$,
    'easy',
    '5D',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$wrong ester backbone$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$amide-linked lipid family$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$everything is a phospholipid$q$ FROM q;

-- Q15 . Extraction data protein classification . medium . skill 4 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Extraction data protein classification$q$,
    $q$Researchers isolate sealed, right side out plasma membrane vesicles from human cells and subject identical samples to four separate treatments, measuring whether protein Q remains in the membrane pellet or appears in the soluble fraction. After a wash with 2 M NaCl, Q stays in the pellet. After a wash at pH 11, Q stays in the pellet. After incubation of the intact vesicles with phosphatidylinositol specific phospholipase C added to the surrounding buffer, Q stays in the pellet. After addition of the nonionic detergent Triton X-100, Q appears in the soluble fraction. Which classification of protein Q do these results support?$q$,
    $q$[{"label":"A","text":"A surface protein held to the charged lipid head groups of the bilayer by electrostatic attraction"},{"label":"B","text":"A protein tethered to the outer leaflet by a covalently attached glycosylphosphatidylinositol group"},{"label":"C","text":"An integral protein whose nonpolar surface is buried in the hydrophobic interior of the bilayer"},{"label":"D","text":"A protein bound noncovalently to the extracellular domain of a neighboring integral membrane protein"}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests the classification of a membrane protein from its behavior in a differential extraction experiment. The answer is C because protein Q resists every treatment that strips surface associated proteins and enters solution only when the bilayer itself is taken apart. A concentrated salt wash floods the system with competing ions that screen charge based contacts, and an alkaline wash changes the protonation of the groups that form them, so a protein surviving both cannot be held at the surface by electrostatic attraction. Phosphatidylinositol specific phospholipase C cuts the lipid portion of a glycosylphosphatidylinositol linkage, so retention after that treatment rules out that covalent lipid attachment as well. The one treatment that liberates Q is a nonionic detergent, whose amphipathic molecules insert among the lipids and take the place of the bilayer around any protein surface in direct contact with the membrane interior. A protein freed only under those conditions must have nonpolar surface buried in the hydrophobic interior, which is the defining property of an integral membrane protein. (Choice A) A protein held to head groups by electrostatic attraction is exactly the class that a 2 M NaCl wash removes, because the added ions compete for those charged contacts; Q staying in the pellet after the salt wash contradicts this classification. (Choice B) A glycosylphosphatidylinositol tether is a genuine membrane attachment, but the phospholipase applied here cleaves that lipid, so a protein held that way would have moved into the soluble fraction rather than remaining in the pellet. (Choice D) Binding to the exposed domain of a neighboring membrane protein is a real peripheral mode of association, but such noncovalent protein to protein contacts are ionic and hydrogen bonded in character and give way under high salt or alkaline pH, so a protein attached this way would not have survived the first two washes. This is a Data-based and Statistical Reasoning question because it requires integrating the outcomes of four separate extraction treatments and reasoning from the pattern of retention and release to the structural class of protein Q.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    4,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q16 . Extraction condition anchoring forces . medium . skill 3 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Extraction condition anchoring forces$q$,
    $q$A researcher washes a purified membrane preparation with 1 M NaCl and, in a parallel sample, with a pH 11 carbonate buffer. Both washes release the same subset of membrane proteins into the supernatant, while a second subset remains in the membrane pellet. The retained proteins appear in solution only after the preparation is treated with the nonionic detergent Triton X-100. Which of the following best explains this pattern of release?$q$,
    $q$[{"label":"A","text":"The salt and high pH washes strip the released proteins by disrupting their hydrophobic contacts with the fatty acyl chains, while the detergent frees the retained proteins by neutralizing their charge attractions to the polar bilayer surface."},{"label":"B","text":"The salt and high pH washes weaken the ionic and other polar surface interactions holding the released proteins at the polar face of the bilayer, while the retained proteins expose hydrophobic surfaces to the acyl-chain core and emerge only when detergent dissolves the surrounding lipid."},{"label":"C","text":"The salt and high pH washes compete away the charge interactions holding the released proteins, while the detergent frees the retained proteins by unfolding them so their membrane-embedded segments can slide out of the still-intact bilayer."},{"label":"D","text":"The salt and high pH washes raise the osmotic pressure across the membrane and mechanically eject loosely attached proteins, while the retained proteins stay shielded inside the sealed bilayer until the detergent opens pores that let them escape."}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests the different forces that anchor peripheral membrane proteins to the bilayer surface versus those that hold integral membrane proteins within its hydrophobic core. The answer is B because each treatment removes exactly the class of protein whose anchoring force it can disrupt. Peripheral proteins sit on the polar face of the membrane, held there by ionic bonds, hydrogen bonds, and other charge-based surface contacts. A high concentration of NaCl surrounds those charged groups with counterions and screens their attractions, and a strongly alkaline buffer changes the protonation states of the interacting side chains; either perturbation dismantles the electrostatic and polar network, so the surface-bound set washes into the supernatant. Integral proteins are retained because they are anchored by a different force: their nonpolar surfaces pack against the fatty acyl chains of the hydrocarbon interior, an association driven by the hydrophobic effect. Ions and pH shifts act on charged and protonatable groups and leave this nonpolar interface untouched. Only an amphipathic detergent, which inserts among the lipids, disperses the bilayer, and coats the exposed hydrophobic protein surfaces, can carry these proteins into aqueous solution. (Choice A) reverses the two mechanisms. Salt and pH perturb charge-based contacts, not hydrophobic packing; a nonpolar interface is indifferent to ionic strength. Detergents, in turn, work by dissolving the surrounding lipid, not by neutralizing charges, and Triton X-100 is nonionic and could not titrate electrostatic attractions. (Choice C) starts correctly, since the washes do compete away the charge interactions holding the surface-bound set, but its detergent mechanism fails. Retained proteins cannot unfold and slide out of an intact membrane; the bilayer itself must be disassembled. Triton X-100 is a mild, nonionic detergent used precisely because it releases membrane proteins without denaturing them. (Choice D) invokes osmotic pressure, which does not apply. Osmotic effects govern water movement across a closed compartment and could swell or lyse a vesicle, but they do not selectively strip one class of protein from a membrane, and an alkaline wash is not an osmotic perturbation at all. Detergent solubilization also disassembles the bilayer rather than opening escape pores. This is a Reasoning about the Design and Execution of Research question because it requires interpreting a differential extraction experiment by identifying the specific intermolecular force each washing condition disrupts and matching that force to the class of membrane protein it anchors.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    3,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q17 . Lipid anchored protein classification logic . hard . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Lipid anchored protein classification logic$q$,
    $q$A plasma membrane associated enzyme from a human cell line remains in the membrane fraction after washes with 1 M salt and with alkaline buffer, yet hydropathy analysis of its sequence finds no stretch of about twenty consecutive nonpolar residues. The complete polypeptide is later recovered from the membrane only by detergent solubilization. Which mode of membrane association reconciles these observations?$q$,
    $q$[{"label":"A","text":"The enzyme is a peripheral protein whose association with the membrane surface is purely electrostatic, through contacts with lipid head groups"},{"label":"B","text":"The enzyme crosses the membrane as a beta barrel, a fold whose short alternating strands escape detection by helix based hydropathy scans"},{"label":"C","text":"The enzyme spans the bilayer with a single nonpolar helix of about ten residues, roughly half the length usually required"},{"label":"D","text":"A lipid group covalently attached to the polypeptide inserts into the bilayer, while the protein chain itself stays outside the hydrophobic interior"}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests the classification of a lipid anchored membrane protein once sequence analysis has ruled out a membrane spanning segment. The answer is D because a covalently attached lipid reconciles all three observations at once. Resistance to the salt and alkaline washes excludes a purely electrostatic surface association, since those treatments defeat charge based contacts. The absence of any run of roughly twenty nonpolar residues means the polypeptide itself cannot supply a helix long enough to cross the hydrophobic interior. A fatty acyl group such as myristate or palmitate, an isoprenoid group, or a glycosylphosphatidylinositol group resolves the contradiction: the attachment is covalent, so no wash can dissociate it, and the lipid rather than the polypeptide does the embedding, so analysis of the protein sequence shows nothing unusual. Detergent finally releases the protein because dissolving the bilayer frees the inserted lipid along with everything attached to it. (Choice A) A peripheral protein held by electrostatic contacts with head groups would have eluted during the high salt or alkaline wash, since those treatments screen or abolish exactly the charge interactions that hold such proteins; the observed retention contradicts this mode. (Choice B) Beta barrel proteins genuinely evade helix oriented hydropathy scans, because each strand contributes only a few alternating nonpolar residues, but this fold occurs in the outer membranes of Gram negative bacteria and in mitochondrial membranes, not in the plasma membrane of a human cell. (Choice C) A nonpolar helix of about ten residues rises roughly fifteen angstroms, only about half the thickness of the hydrophobic interior, so it cannot reach across; the requirement of roughly twenty residues exists precisely because that length matches the dimension of the core. This is a Scientific Reasoning and Problem Solving question because it requires combining a negative hydropathy result with the enzyme's extraction behavior to deduce a mode of membrane attachment that neither observation reveals on its own.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', NULL FROM q;

-- Q18 . GPI leaflet and phospholipase release . hard . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$GPI leaflet and phospholipase release$q$,
    $q$A lymphocyte adhesion protein is held at the cell surface solely by a glycosylphosphatidylinositol anchor attached to its carboxy terminus. An investigator adds a bacterial phospholipase that cleaves the phosphodiester bond within phosphatidylinositol to the medium bathing intact cells. What outcome does the location of the lipid linkage predict?$q$,
    $q$[{"label":"A","text":"The protein is shed into the medium, because the lipid holding it sits in the outer leaflet, within reach of an enzyme confined to the cell exterior"},{"label":"B","text":"The protein remains membrane bound, because its membrane spanning helix is not a substrate for this enzyme and continues to hold it in place"},{"label":"C","text":"The protein is freed into the cytosol, because the lipid holding it lies in the leaflet that faces the interior of the cell"},{"label":"D","text":"The lipid is cleaved, but the protein stays at the surface because the glycan attached to it embeds in the bilayer instead"}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests the membrane topology of a glycosylphosphatidylinositol linked protein and what that topology predicts about enzymatic release. The answer is A because the lipid portion of this linkage is built into the outer leaflet, the half of the bilayer that faces the outside of the cell. The protein itself sits entirely outside the membrane, joined through a glycan bridge to a phosphatidylinositol whose fatty acyl chains reach only partway in, from the exterior side. An enzyme added to the medium around intact cells cannot cross the bilayer, so it acts only on what it can reach from the outside. Because the phosphatidylinositol lies in that outer leaflet, the added enzyme can cleave its phosphodiester bond, severing the sole connection between protein and membrane. The protein, which is otherwise water soluble, then diffuses away into the medium, a result used experimentally to identify proteins attached in this way. (Choice B) Proteins held by this linkage have no membrane spanning segment at all; the entire attachment runs from the carboxy terminus through the glycan to the lipid, so once the lipid is cut there is no helix left to retain the protein. (Choice C) This inverts the geometry. A lipid sitting in the leaflet that faces the cytosol could never be reached by an enzyme outside an intact cell, and release toward the interior would in any case be incompatible with an adhesion protein that must face outward to function. (Choice D) The cleavage does occur, but the glycan cannot rescue the attachment; carbohydrate is strongly hydrophilic and cannot insert into the hydrophobic interior of the bilayer, so nothing remains to hold the protein once its lipid is gone. This is a Scientific Reasoning and Problem Solving question because it requires locating the lipid portion of the anchor in a particular leaflet and then predicting which compartment receives the protein once the enzyme cleaves it.$q$,
    'hard',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q19 . Bilayer span requirement for channels . easy . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Bilayer span requirement for channels$q$,
    $q$A student engineers a protein that binds tightly and stably to the outer face of a cultured cell's plasma membrane through ionic contacts with lipid head groups, folding into a ring with a central water filled opening. She predicts that the ring will allow sodium ions to flow into the cell down their gradient. What flaw defeats this prediction?$q$,
    $q$[{"label":"A","text":"The carbohydrate rich glycocalyx at the cell surface would plug the ring's central opening before any ions could reach it"},{"label":"B","text":"Moving ions through a membrane protein requires ATP hydrolysis, and the ring has no way to couple such hydrolysis to ion flow"},{"label":"C","text":"An ion conducting pathway must extend through the entire hydrophobic interior of the bilayer, and a ring resting on one face leaves that interior intact"},{"label":"D","text":"The flaw lies only in the binding mode, and attaching the ring covalently to a membrane lipid would let it conduct"}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests the structural requirement that any protein conducting ions across a membrane must be an integral protein. The answer is C because conduction demands a continuous aqueous pathway from one side of the membrane to the other. The barrier is the roughly thirty angstrom hydrophobic interior of the bilayer, where the energetic cost of placing a charged, water stripped ion is prohibitive. Real ion channels solve this by threading segments through the membrane so that a water filled pore runs the full thickness of the bilayer, shielding the ion from lipid the whole way across. The engineered ring, however stable its binding and however wide its opening, rests on the outer surface; a sodium ion passing through the opening simply arrives at the intact head group layer and hydrophobic interior, the same barrier it faced before. Only a structure that crosses the bilayer can conduct, which is why every ion channel is an integral membrane protein and no surface associated protein performs this function. (Choice A) Cell surfaces do carry a carbohydrate rich coat, but it does not seal off the openings of surface proteins, and it is not why the design fails; even with unobstructed access to the ring, ions would still be stopped by the bilayer beneath it. (Choice B) This confuses channels with pumps. Channels permit passive ion flow down electrochemical gradients with no energy input, so the absence of a coupling mechanism is beside the point; the design fails for a structural reason. (Choice D) A covalent lipid attachment would make the association more permanent, but the polypeptide would still sit on one face of the membrane, and attachment strength is irrelevant because no surface bound protein of any attachment type provides a path through the hydrophobic interior. This is a Scientific Reasoning and Problem Solving question because it requires applying the structural requirement for conducting ions across a bilayer to explain why a protein bound to a single face cannot function as a channel.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q20 . Hydropathy plot topology prediction . medium . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Hydropathy plot topology prediction$q$,
    $q$A newly cloned protein is translated on ER-bound ribosomes, and its growing chain has already engaged the translocon. A Kyte-Doolittle analysis of the full sequence shows a single window of about 20 consecutive strongly hydrophobic residues near the middle of the chain, with the rest of the sequence scoring hydrophilic. Which final arrangement does this analysis predict for the mature protein?$q$,
    $q$[{"label":"A","text":"Integration as a single-pass protein held in the bilayer by one alpha-helical segment"},{"label":"B","text":"Peripheral association with the membrane surface through electrostatic contacts"},{"label":"C","text":"Release into the ER lumen as a fully soluble secreted protein"},{"label":"D","text":"Repeated membrane crossings by a series of short amphipathic beta strands"}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests hydropathy logic, the use of a hydrophobicity plot to predict how a protein is arranged in a lipid bilayer. The answer is A because one uninterrupted window of roughly 20 strongly hydrophobic residues is precisely the signature of a single membrane-spanning alpha helix. An alpha helix rises about 1.5 angstroms per residue, so a run of about 20 residues extends roughly 30 angstroms, which matches the thickness of the hydrocarbon core of a typical bilayer. Side chains hydrophobic enough to score high on a Kyte-Doolittle scale partition favorably out of the aqueous channel of the translocon and into the surrounding lipid, so as the chain passes through, this segment exits sideways and lodges in the membrane. Because the plot shows only one such window and the flanking sequence is hydrophilic, the two flanking domains remain in aqueous compartments on opposite faces of the membrane. The result is a protein embedded exactly once, the defining arrangement of a single-pass integral protein. (Choice B) Peripheral proteins sit on the membrane surface through electrostatic and hydrogen-bonding contacts with lipid head groups or with other proteins, and they can be washed off by changes in salt or pH; they lack long continuous hydrophobic runs, so this plot argues directly against a peripheral arrangement rather than for it. (Choice C) A protein destined to be released as a soluble lumenal or secreted protein must lack long hydrophobic stretches once its targeting information is gone; here the hydrophobic window sits in the middle of the chain, where it cannot be removed along with the N-terminus, so the protein cannot pass entirely through and float free in the lumen. (Choice D) Beta-barrel membrane proteins cross the bilayer using many short strands in which hydrophobic residues alternate with hydrophilic ones, producing a series of weak, closely spaced peaks on a hydropathy plot rather than one long strong peak, and such barrels are characteristic of bacterial and mitochondrial outer membranes rather than of chains threading the ER translocon. This is a Scientific Reasoning and Problem Solving question because it asks you to convert a described hydropathy result into a prediction of membrane topology rather than to recall a memorized fact.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$hydrophobic stretch mistaken for surface stickiness$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$treats an internal anchor as a cleavable targeting sequence$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$real membrane-crossing motif from the wrong membrane system$q$ FROM q;

-- Q21 . Stop-transfer sequence terminus orientation . hard . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Stop-transfer sequence terminus orientation$q$,
    $q$A nascent protein is threading through the ER translocon, and the portion of the chain already delivered to the lumen has had its cleavable N-terminal sequence removed there. Threading continues until a 22-residue hydrophobic sequence near the middle of the protein halts further transfer and remains embedded in the bilayer, after which synthesis finishes on the cytosolic side of the ER membrane. If the protein is later delivered to the plasma membrane by vesicular transport, where do its two termini lie?$q$,
    $q$[{"label":"A","text":"Both termini face the extracellular space"},{"label":"B","text":"The N-terminus faces the cytosol and the C-terminus faces the extracellular space"},{"label":"C","text":"The N-terminus faces the extracellular space and the C-terminus faces the cytosol"},{"label":"D","text":"Both termini face the cytosol"}]$q$::jsonb,
    'C',
    $q$This Plasma Membrane question tests stop-transfer topology and how sidedness established at the ER is preserved through the secretory pathway. The answer is C because the portion of the chain synthesized before the hydrophobic halt was already threaded into the ER lumen, everything made after the halt stayed in the cytosol, and vesicular traffic preserves that arrangement all the way to the cell surface. Before the halt, the growing chain passed through the translocon, so the new N-terminus created by removal of the cleavable N-terminal sequence resided in the lumen. The 22-residue hydrophobic sequence acted as a stop-transfer anchor: it left the translocon laterally, lodged in the bilayer, and blocked any further threading, so the remainder of the chain, including the C-terminus, was completed on the cytosolic face. When a transport vesicle buds from the ER and ultimately fuses with the plasma membrane, the lumenal face of the vesicle membrane becomes the extracellular face of the cell, while the cytosolic face of any membrane always remains cytosolic. The lumenal N-terminus therefore ends up outside the cell, and the C-terminus stays inside, giving the classic type I orientation. (Choice A) Both termini could face the extracellular space only if the C-terminal domain had also crossed into the lumen, but the scenario states that synthesis finished on the cytosolic side after the anchor lodged, so the C-terminal domain never entered the lumen and no later step in the pathway can move it across the bilayer. (Choice B) This choice reverses the true orientation; the N-terminal portion was made first and had already crossed into the lumen before the anchor halted transfer, so the N-terminus cannot be the cytosolic end, and the C-terminus, finished in the cytosol, cannot reach the exterior. (Choice D) It is true that the C-terminus is cytosolic, but the claim fails for the N-terminus, which entered the lumen before the halt and is presented on the cell exterior once the vesicle fuses; a protein with both termini in the cytosol would require the membrane-spanning segment to loop in and out without any lumenal exposure, which this single-anchor history rules out. This is a Scientific Reasoning and Problem Solving question because it requires chaining the logic of a stop-transfer event to the rule that lumenal surfaces become extracellular surfaces in order to predict the final position of each terminus.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$assumes the terminal domain also crossed$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$flipped termini$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$half-right sidedness$q$ FROM q;

-- Q22 . Alternating topogenic sequence membrane passes . hard . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Alternating topogenic sequence membrane passes$q$,
    $q$A nascent chain engages the ER translocon and displays, in order along its sequence, an internal signal-anchor sequence, a stop-transfer sequence, a second signal-anchor sequence, and a second stop-transfer sequence. The chain has no cleavable N-terminal targeting sequence, and translation finishes normally. Which of the statements below accurately describe the mature protein as it sits in the ER membrane?

I. The chain spans the bilayer four times.
II. The segment between the first and second hydrophobic sequences faces the ER lumen.
III. The C-terminus faces the ER lumen.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This Plasma Membrane question tests how alternating topogenic sequences thread a chain back and forth to build a multi-pass membrane protein. The answer is B because statements I and II follow directly from the start-stop alternation while statement III contradicts it. A signal-anchor sequence starts translocation and remains in the bilayer as a membrane-spanning segment, and a stop-transfer sequence halts translocation and likewise remains in the bilayer. Each of the four hydrophobic sequences therefore contributes exactly one membrane crossing, so the mature chain spans the bilayer four times and statement I is true. Once the first signal-anchor engages the translocon, the chain downstream of it threads across the membrane until the first stop-transfer halts movement, so the loop between the first and second hydrophobic sequences is deposited on the lumenal side and statement II is true. The second signal-anchor then restarts threading and the second stop-transfer halts it again, so after the final stop, no further sequence crosses; the rest of the chain, including the C-terminus, is completed on the cytosolic side, making statement III false. (Choice A) This choice accepts the pass count but discards the sidedness logic; the same start-stop reasoning that yields four crossings also fixes the first inter-segment loop on the lumenal side, so statement II cannot be excluded while statement I is kept. (Choice C) This choice reverses the fate of the C-terminus, since a stop-transfer sequence ends translocation and leaves the downstream chain in the cytosol rather than the lumen, and it also wrongly rejects the four-crossing count that follows from four membrane-lodged hydrophobic segments. (Choice D) Including statement III would require translocation to resume after the second stop-transfer so that the C-terminus could cross, but stop-transfer sequences terminate threading rather than pausing it, so the terminus never reaches the lumen. This is a Scientific Reasoning and Problem Solving question because it requires stepping through an alternating series of start and stop signals to deduce both the number of membrane crossings and the compartment facing each portion of the chain.$q$,
    'hard',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    2,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$right count, dropped sidedness$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$flipped terminus compartment$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$threading continues past the final stop$q$ FROM q;

-- Q23 . Protease protection sidedness assay . medium . skill 3 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Protease protection sidedness assay$q$,
    $q$Researchers raise antibodies against two epitopes, X and Y, on a single-pass plasma membrane protein. When intact cells are treated with a protease that cannot cross membranes, epitope X becomes undetectable, while epitope Y is still recognized after the cells are subsequently lysed. When cells are mechanically disrupted before the protease is added, both epitopes become undetectable. What do these results establish?$q$,
    $q$[{"label":"A","text":"Epitope Y lies within the bilayer-embedded segment of the protein"},{"label":"B","text":"Epitope X faces the cytosol and epitope Y faces the extracellular space"},{"label":"C","text":"The protease crossed the intact plasma membrane and degraded one domain selectively"},{"label":"D","text":"Epitope X occupies an extracellular domain and epitope Y occupies a cytosolic domain"}]$q$::jsonb,
    'D',
    $q$This Plasma Membrane question tests the design and interpretation of a protease protection experiment used to map the sidedness of a membrane protein. The answer is D because a protease that cannot cross the membrane can only clip domains it can physically reach, so the pattern of loss and protection reports directly on which side of the bilayer each epitope sits. In intact cells the enzyme contacts only the exterior surface, so loss of epitope X shows that X projects into the extracellular space. Epitope Y survived that treatment even though the very same enzyme destroyed it once the barrier was broken, so Y is intrinsically protease sensitive but was shielded by the intact membrane, placing it on the cytosolic side. The disruption experiment is the essential control in this design: it rules out the alternative interpretation that Y simply lacks cleavage sites for this enzyme, because Y is degraded as soon as the enzyme gains access to both faces. Together the two treatments establish the orientation of the protein, with the X-bearing domain outside the cell and the Y-bearing domain inside it, which is exactly the sidedness information this assay is built to deliver. (Choice A) A segment buried in the hydrocarbon core of the bilayer would remain protected from an aqueous protease even after the cells were disrupted, since the enzyme still cannot enter the lipid interior, but Y was destroyed once access was opened, so Y must occupy an aqueous-exposed domain rather than the membrane-embedded segment. (Choice B) This assignment reverses the logic of accessibility; the domain lost in intact cells is the one the externally added enzyme could reach, which must be the extracellular domain, so X cannot be cytosolic and Y cannot be exterior. (Choice C) The enzyme was chosen precisely because it cannot cross an intact bilayer, and the data confirm the barrier held, since epitope Y was spared until the membrane was broken; selective entry would also leave the disruption result unexplained, because nothing about access would then have changed. This is a Reasoning about the Design and Execution of Research question because it asks you to interpret what a protection assay and its membrane-disruption control can and cannot prove about which face of the membrane each protein domain occupies.$q$,
    'medium',
    '2A',
    $q$Plasma Membrane$q$,
    'biochemistry',
    3,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$true protection rule applied to the wrong domain$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$swapped sidedness$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$impermeant enzyme leaks through$q$ FROM q;

-- Q24 . Glycocalyx surface recognition role . easy . skill 1 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Biological Membranes',
    $q$Glycocalyx surface recognition role$q$,
    $q$The outer surface of an intestinal epithelial cell carries a dense layer assembled from the oligosaccharide chains of membrane glycoproteins and glycolipids. A mutation eliminates most of the enzymes that build these chains, severely thinning this layer. Which capability of the cell is most directly compromised?$q$,
    $q$[{"label":"A","text":"Presentation of surface identity markers that other cells use to recognize it"},{"label":"B","text":"Anchoring of cytoskeletal filaments to the inner face of the membrane"},{"label":"C","text":"Formation of disulfide bonds in newly synthesized secretory proteins"},{"label":"D","text":"Carrier-mediated movement of dietary glucose into the cytosol"}]$q$::jsonb,
    'A',
    $q$This Plasma Membrane question tests the role of the glycocalyx, the carbohydrate-rich layer on the exterior face of the cell. The answer is A because the oligosaccharide chains of membrane glycoproteins and glycolipids form distinctive patterns on the cell surface that serve as molecular identification tags. These sugar patterns vary from cell type to cell type and from individual to individual, allowing neighboring cells and cells of the immune system to distinguish familiar cells from foreign ones, much as unique features identify a face. The layer is also strongly hydrophilic, drawing water to the cell surface and helping the cell interact with dissolved substances, and it participates in the cell to cell attachments that assemble cells into tissues. Stripping the sugar chains away therefore most directly degrades the ability of the cell to display the surface markers by which it is known to its neighbors and to the immune system. Because the mutation removes the chain-building enzymes rather than any single protein, every marker in the layer thins at once, making recognition the capability hit first and hardest. (Choice B) Attachment of cytoskeletal filaments occurs on the cytosolic face of the membrane through contacts with peripheral and integral proteins; the carbohydrate layer is confined to the exterior face of the cell and plays no part in anchoring internal filaments, so this choice places the function on the wrong side of the membrane. (Choice C) Disulfide bond formation in newly made secretory proteins is catalyzed inside the ER lumen during folding; although many of those proteins later carry surface sugars, the bond-forming chemistry itself does not depend on the carbohydrate layer at the cell surface. (Choice D) Movement of glucose into the cytosol is carried out by dedicated transport proteins that bind free sugar molecules; the covalently attached chains of surface glycoproteins and glycolipids are structural and informational and are not a route by which dietary sugar crosses the bilayer. This is a Knowledge of Scientific Concepts and Principles question because it asks for direct recognition of the identity-marking role served by the carbohydrate layer on the outer surface of the plasma membrane.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$wrong face of the membrane$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$real secretory-pathway chemistry, wrong compartment$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$surface sugars mistaken for transport machinery$q$ FROM q;

COMMIT;

-- Verification: expect 24 questions and 72 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'Biological Membranes') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'Biological Membranes') AS distractor_rows;
