-- ============================================================
-- Praxis Prep — Psych/Soc Chapter 2: Sensation and Perception
-- Batch 1 (Questions 1–50): Sensation Basics + Vision
-- MCAT-style concept questions — clinical vignettes, experimental
-- setups, and real-world scenarios requiring multi-step reasoning.
-- Run AFTER 001_phase1_schema.sql
-- ============================================================


-- ==============================
-- SENSATION BASICS (Q1–30)
-- ==============================

-- Q1: Transduction
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A researcher studying olfaction places electrodes on olfactory receptor neurons and observes that when airborne molecules bind to receptor proteins on the cilia, a graded electrical change is generated within the neuron. The molecule-to-electrical-signal conversion represents which of the following processes?',
  '[{"label": "A", "text": "Perception — the brain is assigning meaning to the chemical stimulus"},
    {"label": "B", "text": "Sensory adaptation — the receptor is downregulating its response over time"},
    {"label": "C", "text": "Transduction — the physical/chemical stimulus is being converted into a neural signal"},
    {"label": "D", "text": "Top-down processing — prior experience is shaping how the receptor responds"}]',
  'C',
  'Transduction is the process by which sensory receptors convert a physical or chemical stimulus (here, the binding of an odorant molecule) into an electrochemical signal (the graded potential). This is a bottom-up process occurring at the receptor itself. A) Perception is the higher-order cognitive interpretation of the signal — it occurs in the brain, not at the receptor. B) Sensory adaptation refers to a decrease in receptor response over time with sustained stimulation; it is not the initial conversion event. D) Top-down processing describes how expectations and experience influence perception at a cognitive level — not a receptor-level transduction mechanism.',
  'easy'
);

-- Q2: Sensation vs. Perception
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A patient with a lesion in the primary somatosensory cortex reports that she feels pressure on her hand when touched (intact nerve endings and spinal tracts confirmed) but cannot determine the shape or texture of an object placed in her palm. This case best illustrates the distinction between:',
  '[{"label": "A", "text": "Absolute threshold and difference threshold"},
    {"label": "B", "text": "Sensation and perception"},
    {"label": "C", "text": "Photoreceptors and mechanoreceptors"},
    {"label": "D", "text": "Sensory adaptation and habituation"}]',
  'B',
  'Sensation refers to the basic detection of a stimulus by sensory receptors and peripheral nerves — the patient''s sensory receptors and ascending pathways are intact, so she can sense touch (pressure). Perception is the brain''s interpretation and organization of sensory data into meaningful information — the cortical lesion disrupts her ability to perceive object shape and texture, the interpretive step. A) Threshold concepts concern detection sensitivity, not cortical interpretation. C) Receptor type does not explain a cortical deficit. D) Adaptation and habituation relate to changes in responsiveness over time, not cortical lesion effects.',
  'medium'
);

-- Q3: Sensory receptor types
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'During a surgery, a patient under local anesthesia accidentally touches a hot instrument. Free nerve endings in the skin immediately generate action potentials that travel to the brain. Which type of sensory receptor is responsible for detecting this potentially damaging thermal stimulus?',
  '[{"label": "A", "text": "Mechanoreceptors, which respond to mechanical deformation of tissue"},
    {"label": "B", "text": "Osmoreceptors, which detect changes in solute concentration"},
    {"label": "C", "text": "Nociceptors, which respond to tissue-damaging or potentially damaging stimuli"},
    {"label": "D", "text": "Photoreceptors, which convert electromagnetic energy into neural signals"}]',
  'C',
  'Nociceptors are free nerve endings that detect noxious stimuli — mechanical damage, extreme temperature, or chemical irritants — signaling actual or potential tissue harm (pain). In this scenario, the extreme heat qualifies as a potentially damaging thermal stimulus, activating nociceptors. A) Mechanoreceptors detect physical deformation (pressure, vibration, stretch) — not the primary response to harmful heat. B) Osmoreceptors monitor osmotic pressure (e.g., in the hypothalamus) — irrelevant here. D) Photoreceptors are specialized for light energy in the retina — not involved in skin temperature detection. Note: thermoreceptors detect temperature generally; nociceptors specifically signal the painful, potentially damaging end of the temperature spectrum.',
  'easy'
);

-- Q4: Distal vs. proximal stimulus
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A student stands 10 meters from a stop sign. The actual red octagonal sign at 10 meters is one representation of the stimulus, while the inverted, reduced image formed on the student''s retina is another. In psychophysics terminology, these two representations are called, respectively:',
  '[{"label": "A", "text": "Proximal stimulus and distal stimulus"},
    {"label": "B", "text": "Distal stimulus and proximal stimulus"},
    {"label": "C", "text": "Absolute threshold and difference threshold"},
    {"label": "D", "text": "Bottom-up stimulus and top-down stimulus"}]',
  'B',
  'The distal stimulus is the actual object in the environment — in this case, the real stop sign 10 meters away. The proximal stimulus is the representation of that object at the sensory surface — the retinal image. The key distinction is that the distal stimulus exists in the world, while the proximal stimulus is what actually contacts and stimulates the sensory organ. A) This reverses the correct assignment. C) Thresholds relate to detection sensitivity, not to stimulus representation levels. D) Bottom-up/top-down describes processing direction, not the stimulus itself.',
  'medium'
);

-- Q5: Psychophysics definition
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A research team designs a study to determine the minimum sound pressure level that humans can detect in a quiet room, and separately examines how changes in loudness are subjectively experienced as a function of changes in sound energy. These investigators are working within which scientific discipline?',
  '[{"label": "A", "text": "Neuroanatomy — mapping the structural pathways of the auditory system"},
    {"label": "B", "text": "Psychophysics — quantifying relationships between physical stimuli and sensory/perceptual experience"},
    {"label": "C", "text": "Cognitive neuroscience — using brain imaging to study conscious thought"},
    {"label": "D", "text": "Behavioral genetics — examining hereditary contributions to sensory ability"}]',
  'B',
  'Psychophysics is the branch of psychology that systematically studies the relationship between physical properties of stimuli (e.g., sound pressure level in decibels) and the psychological (subjective) experience they produce (e.g., perceived loudness). Determining detection thresholds and examining how perceived magnitude scales with physical intensity are classic psychophysics questions. A) Neuroanatomy focuses on structure, not stimulus-response quantification. C) Cognitive neuroscience uses imaging and computational models to study cognition broadly. D) Behavioral genetics examines gene-behavior relationships — not stimulus-experience scaling.',
  'easy'
);

-- Q6: Absolute threshold
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'In a sensory detection experiment, a participant detects a faint tone 50% of the time across many trials at a given intensity. A researcher reports this intensity as the participant''s absolute threshold for that tone. Which of the following best explains why the 50% detection criterion is used rather than 100%?',
  '[{"label": "A", "text": "Sensory adaptation causes the threshold to rise over time, so 100% detection is unachievable"},
    {"label": "B", "text": "Signal detection theory shows that 100% detection always reflects a liberal response bias"},
    {"label": "C", "text": "Neural noise and variability in sensory systems mean detection is probabilistic, making 50% a reliable statistical definition"},
    {"label": "D", "text": "The difference threshold by definition equals the absolute threshold at the 50% detection point"}]',
  'C',
  'The 50% detection criterion is used because sensory detection is inherently probabilistic — biological noise, attentional fluctuations, and receptor variability mean that even for a fixed physical stimulus, a participant will not detect it on every trial. The absolute threshold is therefore defined statistically as the intensity detected on half of trials, providing a stable and reproducible measure of sensitivity. A) While adaptation does raise thresholds over time, this is not why 100% is avoided in the operational definition. B) SDT does discuss response bias, but the 50% criterion predates SDT and reflects the probabilistic nature of detection, not just bias. D) The difference threshold (JND) and absolute threshold are separate concepts; they do not converge at 50%.',
  'medium'
);

-- Q7: Difference threshold / JND
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A chef training new staff tells them: "When seasoning a large pot of soup, you need to add far more salt to notice a difference than you would when seasoning a small bowl." This observation is most consistent with which psychophysical principle?',
  '[{"label": "A", "text": "The absolute threshold — the minimum amount of salt detectable has increased"},
    {"label": "B", "text": "Weber''s law — the just noticeable difference is a constant proportion of the original stimulus magnitude"},
    {"label": "C", "text": "Signal detection theory — the criterion for reporting a difference shifts in a noisy kitchen environment"},
    {"label": "D", "text": "Sensory adaptation — the taste receptors have adapted to the background salt level"}]',
  'B',
  'Weber''s law states that the just noticeable difference (JND) between two stimuli is a constant fraction (Weber fraction) of the original stimulus intensity. A large pot of soup has more baseline salt, so the JND — the minimum added amount perceived as "saltier" — is proportionally larger. The chef''s observation directly illustrates this principle. A) The absolute threshold is the minimum detectable amount in the absence of background stimulus, not the increment needed to notice a change. C) SDT addresses how decision criteria affect hit and false-alarm rates under noise, not the proportional scaling of JNDs. D) Sensory adaptation is a decrease in response to a sustained stimulus over time, not the proportional scaling of detection increments.',
  'medium'
);

-- Q8: Weber's law calculation context
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'An audiologist determines that a patient can just detect a 2 dB increase over a background of 40 dB, and a 4 dB increase over a background of 80 dB. If this pattern holds at 100 dB background, what increase would the patient first notice?',
  '[{"label": "A", "text": "2 dB"},
    {"label": "B", "text": "4 dB"},
    {"label": "C", "text": "5 dB"},
    {"label": "D", "text": "10 dB"}]',
  'C',
  'Weber''s law states that JND / I = k (a constant). From the data: at 40 dB background, JND = 2 dB, so k = 2/40 = 0.05. At 80 dB, JND = 4 dB, so k = 4/80 = 0.05. Consistent. At 100 dB: JND = 0.05 × 100 = 5 dB. A) 2 dB corresponds to the 40 dB background — does not scale proportionally. B) 4 dB corresponds to the 80 dB background. D) 10 dB would imply k = 0.10, inconsistent with the established Weber fraction of 0.05.',
  'hard'
);

-- Q9: Signal detection theory — hit vs. false alarm
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'In a signal detection experiment, a radiologist reviews chest X-rays under time pressure. She reports a nodule as present on 90% of trials where a nodule actually exists, but also reports a nodule on 40% of trials where none is present. Her 90% detection rate for real nodules is best classified as:',
  '[{"label": "A", "text": "A correct rejection — she correctly identified the absence of a nodule"},
    {"label": "B", "text": "A miss — she failed to detect an existing nodule"},
    {"label": "C", "text": "A hit — she correctly detected a signal that was present"},
    {"label": "D", "text": "A false alarm — she reported a signal that was not present"}]',
  'C',
  'In signal detection theory (SDT), a hit occurs when a signal is present and the observer correctly reports it. The radiologist correctly identifies real nodules on 90% of signal-present trials — these are hits. A) A correct rejection is a "no" response on a noise-only trial — the opposite of what is described. B) A miss is a failure to report a real signal — the radiologist''s misses would be the remaining 10% of signal-present trials. D) A false alarm is reporting a signal when none exists — this describes her 40% rate on nodule-absent trials, not the 90% rate described in the question.',
  'medium'
);

-- Q10: SDT — miss and correct rejection
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'Continuing the radiologist scenario from above: on trials where no nodule is present, she reports "no nodule" 60% of the time. This 60% "no signal" response on noise-only trials is classified as:',
  '[{"label": "A", "text": "A hit"},
    {"label": "B", "text": "A miss"},
    {"label": "C", "text": "A false alarm"},
    {"label": "D", "text": "A correct rejection"}]',
  'D',
  'A correct rejection (also called a true negative) occurs when no signal is present and the observer correctly reports its absence. The radiologist correctly reports "no nodule" on 60% of nodule-absent trials — these are correct rejections. A) A hit requires a signal to be present. B) A miss is an incorrect "no" response on a signal-present trial. C) A false alarm is an incorrect "yes" response on a noise-only trial — this describes her other 40% of nodule-absent trials.',
  'medium'
);

-- Q11: SDT — liberal vs. conservative criterion
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'Two airport security screeners review identical X-ray images. Screener A flags 80% of bags containing a weapon (hit rate) but also flags 50% of harmless bags (false alarm rate). Screener B flags 60% of bags containing a weapon but only 10% of harmless bags. Which statement best characterizes their response criteria?',
  '[{"label": "A", "text": "Screener A has a more conservative criterion; Screener B has a more liberal criterion"},
    {"label": "B", "text": "Screener A has a more liberal criterion; Screener B has a more conservative criterion"},
    {"label": "C", "text": "Both screeners have equal sensitivity (d'') because they work with the same images"},
    {"label": "D", "text": "Screener B has higher sensitivity because his hit rate minus false alarm rate is larger"}]',
  'B',
  'In SDT, a liberal criterion means an observer is willing to say "signal present" with relatively little evidence — resulting in more hits but also more false alarms. Screener A''s high hit rate (80%) paired with a high false alarm rate (50%) indicates a liberal criterion. A conservative criterion means requiring stronger evidence before responding "yes" — fewer false alarms but also fewer hits. Screener B''s lower false alarm rate (10%) with a lower hit rate (60%) indicates a conservative criterion. A) This reverses the correct labels. C) Sensitivity (d'') depends on the separation of signal and noise distributions — two observers with different criteria can have different sensitivity even with the same physical images if one is more attentive or experienced. D) Simple subtraction of rates is not a valid measure of sensitivity; d'' requires converting rates to z-scores.',
  'hard'
);

-- Q12: Catch trials and noise trials
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A psychophysicist studying pain perception presents participants with mild electrical pulses on some trials and no stimulus on others, without telling participants which type of trial is occurring. Trials with no electrical stimulus are included primarily to:',
  '[{"label": "A", "text": "Establish the absolute threshold by determining the minimum current that produces a response"},
    {"label": "B", "text": "Measure the false alarm rate, allowing the researcher to separate response bias from true sensitivity"},
    {"label": "C", "text": "Induce sensory adaptation by giving the nervous system a rest between signal trials"},
    {"label": "D", "text": "Control for the Weber fraction by normalizing responses to a zero baseline"}]',
  'B',
  'Catch trials (also called noise-only or blank trials) are trials in which no signal is presented. Participants'' responses on these trials reveal their false alarm rate — how often they report detecting a signal that is not there. By comparing hit rates on signal trials to false alarm rates on catch trials, the researcher can apply signal detection theory to separate d'' (sensitivity — how well the participant actually detects the signal) from the response criterion (bias toward saying yes or no). A) The absolute threshold is estimated from signal-present trials, not catch trials. C) Catch trials are not designed to allow adaptation — they are interspersed to measure response bias. D) The Weber fraction involves proportional JND calculations, not catch trial baselines.',
  'medium'
);

-- Q13: Sensory adaptation
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A person enters a room with a strong odor of fresh paint. Initially the smell is overwhelming, but after 15 minutes it is barely noticeable even though the paint is still off-gassing at the same rate. A friend who enters the room at the 15-minute mark immediately notices the strong smell. This phenomenon is best explained by:',
  '[{"label": "A", "text": "Top-down processing — the first person''s expectations have changed, reducing perceived odor"},
    {"label": "B", "text": "The just noticeable difference — the odor level has fallen below the first person''s JND"},
    {"label": "C", "text": "Sensory adaptation — sustained receptor stimulation has caused a reduction in the first person''s sensitivity to the constant stimulus"},
    {"label": "D", "text": "Habituation — the first person''s behavioral response has been extinguished through repeated exposure"}]',
  'C',
  'Sensory adaptation is a decrease in receptor sensitivity in response to prolonged, constant stimulation. With continuous olfactory receptor activation by paint odors, the receptors reduce their firing rate, making the smell less noticeable over time. The friend entering fresh has unadapted receptors and detects the same concentration at full strength. A) Top-down processing involves cognitive influence on perception — the mechanism here is peripheral receptor adaptation, not a change in expectations. B) The JND is about discriminating between two stimulus levels; the issue here is reduced sensitivity to a constant stimulus, not discrimination. D) Habituation is a behavioral/learning phenomenon (decreased response to a repeated stimulus at the level of neural circuits or behavioral output); sensory adaptation is more specifically a receptor-level physiological change.',
  'medium'
);

-- Q14: Projection areas
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'After suffering a stroke affecting the primary auditory cortex in the temporal lobe, a patient loses the ability to consciously perceive sounds despite having intact cochleae and auditory nerves confirmed by audiological testing. This finding demonstrates the role of cortical projection areas in:',
  '[{"label": "A", "text": "Transducing mechanical vibrations from the air into neural signals"},
    {"label": "B", "text": "Receiving and processing sensory information so that it enters conscious awareness"},
    {"label": "C", "text": "Adjusting the absolute threshold based on current attentional state"},
    {"label": "D", "text": "Calculating the Weber fraction for auditory stimuli"}]',
  'B',
  'Cortical projection areas (primary sensory cortices) are the destinations in the cerebral cortex where sensory information is first received and processed, enabling conscious perception. Damage to the primary auditory cortex eliminates conscious sound perception even when peripheral organs are intact — the signal arrives but cannot be consciously processed. A) Transduction occurs in the hair cells of the cochlea — a peripheral process unaffected by the cortical stroke. C) Absolute threshold adjustments involve both peripheral and central factors, but the question addresses why perception fails despite intact periphery. D) Weber fraction calculations are behavioral/perceptual measures, not a cortical function per se.',
  'medium'
);

-- Q15: Ganglia
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'During embryonic development, cells migrate from the neural crest to form clusters of neuron cell bodies located outside the central nervous system. These clusters relay sensory information from peripheral receptors toward the spinal cord and brain. These structures are best identified as:',
  '[{"label": "A", "text": "Nuclei — groups of neuron cell bodies inside the CNS"},
    {"label": "B", "text": "Ganglia — clusters of neuron cell bodies located in the peripheral nervous system"},
    {"label": "C", "text": "Glial cell masses — non-neuronal support structures"},
    {"label": "D", "text": "Projection areas — cortical regions that receive sensory input"}]',
  'B',
  'Ganglia are collections of neuron cell bodies located outside the CNS, in the peripheral nervous system. Dorsal root ganglia, for example, contain the cell bodies of sensory neurons that carry signals from peripheral receptors to the spinal cord. A) Nuclei are clusters of neuron cell bodies inside the CNS — the same anatomical concept but within the brain or spinal cord. C) Glial cells are non-neuronal support cells; they do not transmit sensory signals. D) Projection areas are cortical targets of sensory pathways, not peripheral relay clusters.',
  'easy'
);

-- Q16: Mechanoreceptors
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A patient with diabetes develops peripheral neuropathy and loses the ability to feel the texture of objects held in the hand or detect vibrations applied to the fingertips, while pain and temperature sensation remain partially intact. The sensory receptors most likely damaged are:',
  '[{"label": "A", "text": "Photoreceptors — specialized for detecting light"},
    {"label": "B", "text": "Osmoreceptors — detecting changes in osmotic pressure"},
    {"label": "C", "text": "Mechanoreceptors — responding to mechanical stimuli such as pressure, vibration, and texture"},
    {"label": "D", "text": "Chemoreceptors — detecting chemical stimuli in the environment"}]',
  'C',
  'Mechanoreceptors in the skin (Meissner''s corpuscles, Pacinian corpuscles, Merkel''s discs, Ruffini endings) detect mechanical stimuli — pressure, vibration, texture, and stretch. Loss of texture and vibration detection with relatively spared pain/temperature points to mechanoreceptor or their associated large myelinated fiber (A-beta) damage. A) Photoreceptors are retinal cells responding to light — irrelevant to touch. B) Osmoreceptors detect osmolarity changes (e.g., in the hypothalamus) — not peripheral touch. D) Chemoreceptors detect chemical signals — relevant to taste, smell, and internal chemosensing, not texture or vibration.',
  'medium'
);

-- Q17: Photoreceptors as sensory receptors
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'Which of the following most accurately describes the general function of photoreceptors in the visual system?',
  '[{"label": "A", "text": "They amplify light signals by reflecting them off the tapetum lucidum before transduction"},
    {"label": "B", "text": "They convert electromagnetic energy (light) into graded electrochemical potentials through photopigment activation"},
    {"label": "C", "text": "They transmit action potentials directly to the visual cortex via the optic nerve"},
    {"label": "D", "text": "They detect contrast and edges using center-surround antagonism at the level of the retina"}]',
  'B',
  'Photoreceptors (rods and cones) contain photopigments (e.g., rhodopsin in rods) that absorb photons and undergo conformational changes, triggering a G-protein cascade that alters ion channel conductance — converting light energy into a graded electrochemical (receptor) potential. This is transduction. A) The tapetum lucidum is found in many nocturnal animals but not in humans; it is not part of human photoreceptor function. C) Photoreceptors generate graded potentials, not action potentials; it is the retinal ganglion cells that send action potentials along the optic nerve. D) Center-surround antagonism is a property of bipolar cells and retinal ganglion cells, not photoreceptors themselves.',
  'medium'
);

-- Q18: Osmoreceptors
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'After a marathon runner becomes severely dehydrated, specialized neurons in the hypothalamus detect the increased blood osmolarity and trigger the sensation of thirst as well as release of antidiuretic hormone. These hypothalamic neurons are best classified as:',
  '[{"label": "A", "text": "Nociceptors — detecting a painful internal stimulus"},
    {"label": "B", "text": "Thermoreceptors — monitoring core body temperature"},
    {"label": "C", "text": "Osmoreceptors — detecting changes in osmotic pressure of body fluids"},
    {"label": "D", "text": "Chemoreceptors — detecting changes in blood pH and gas levels"}]',
  'C',
  'Osmoreceptors in the hypothalamus (particularly the organum vasculosum of the lamina terminalis and supraoptic nucleus region) monitor the osmolarity of the blood and extracellular fluid. When osmolarity rises (as in dehydration), they trigger ADH release and thirst. A) Nociceptors signal tissue damage or noxious stimuli — dehydration-induced osmolarity change is not a nociceptive stimulus. B) Thermoreceptors detect temperature; this scenario involves fluid osmolarity. D) Chemoreceptors (e.g., peripheral and central chemoreceptors in the aortic arch, carotid bodies, and medulla) detect blood CO2, O2, and pH — a distinct function from osmoreception.',
  'medium'
);

-- Q19: Olfactory receptors
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'Unlike most sensory pathways that relay through the thalamus before reaching the cortex, olfactory signals from receptor neurons in the nasal epithelium project directly to the olfactory bulb and then to the piriform cortex and limbic structures. This unique routing helps explain why:',
  '[{"label": "A", "text": "Smell is the sense most resistant to adaptation with prolonged exposure"},
    {"label": "B", "text": "Odors have a particularly strong and direct capacity to evoke emotional memories"},
    {"label": "C", "text": "Olfaction has a lower absolute threshold than any other sensory modality"},
    {"label": "D", "text": "Smell requires more cortical processing area than vision or hearing"}]',
  'B',
  'The olfactory system is unique in that it bypasses the thalamic relay and projects directly to the piriform cortex and the limbic system (including the amygdala and hippocampus). The amygdala processes emotional responses and the hippocampus is critical for memory formation — their direct olfactory input explains why smells evoke emotionally vivid and autobiographical memories more powerfully than other senses. A) Olfaction is actually prone to relatively rapid adaptation. C) While olfaction is sensitive, the lowest absolute thresholds vary by substance and modality; this is not directly explained by the non-thalamic routing. D) The olfactory cortex is not larger than visual or auditory cortex.',
  'medium'
);

-- Q20: Taste receptors
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A pharmaceutical company is developing a bitter-blocking drug to help patients tolerate oral medications. The target receptor cells are located in taste buds on the tongue and palate and respond to specific chemical ligands via G-protein-coupled receptor cascades. These cells are best classified as:',
  '[{"label": "A", "text": "Mechanoreceptors — detecting the texture of the tablet"},
    {"label": "B", "text": "Gustatory (taste) receptor cells — chemoreceptors specialized for detecting dissolved chemicals"},
    {"label": "C", "text": "Olfactory receptor neurons — detecting volatile aromatic compounds"},
    {"label": "D", "text": "Nociceptors — signaling the irritating quality of bitter compounds"}]',
  'B',
  'Taste (gustatory) receptor cells in taste buds are chemoreceptors that detect dissolved chemical stimuli (tastants). They use G-protein-coupled receptor mechanisms for bitter, sweet, and umami, and ion channel mechanisms for salty and sour. A) Mechanoreceptors detect physical deformation — texture perception, not chemical taste. C) Olfactory receptor neurons are in the nasal epithelium and detect airborne volatile molecules — they contribute to flavor perception but are not the tongue taste receptors. D) Nociceptors detect noxious/painful stimuli; while some bitter compounds can be aversive, the primary receptor type for bitter taste is the gustatory receptor, not nociceptors.',
  'easy'
);

-- Q21: Signal detection theory — sensitivity vs. bias
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A clinician tests two patients for touch sensitivity using a monofilament. Patient A correctly detects the filament 70% of the time when present, with a 5% false alarm rate. Patient B correctly detects it 70% of the time when present, with a 30% false alarm rate. Which conclusion is most supported by signal detection theory?',
  '[{"label": "A", "text": "Patient A and B have identical sensitivity because their hit rates are the same"},
    {"label": "B", "text": "Patient B has greater actual sensitivity because they responded more frequently overall"},
    {"label": "C", "text": "Patient A has greater sensitivity (d'') because the same hit rate is achieved with a lower false alarm rate"},
    {"label": "D", "text": "Patient A has a more liberal criterion, leading to better discrimination"}]',
  'C',
  'Sensitivity in SDT (d'') reflects the distance between the signal and noise distributions — it is measured by comparing the hit rate to the false alarm rate, not the hit rate alone. Patient A achieves the same hit rate (70%) as Patient B but with a much lower false alarm rate (5% vs. 30%), meaning Patient A discriminates signal from noise much more accurately. A lower false alarm rate at the same hit rate means greater d''. A) Equal hit rates do not imply equal sensitivity — false alarm rates must be considered. B) More frequent overall responses indicate a more liberal criterion, not necessarily greater sensitivity. D) Patient A''s low false alarm rate suggests a more conservative criterion (requiring stronger evidence before saying "yes"), not a liberal one.',
  'hard'
);

-- Q22: Sensory receptor specificity
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'The principle of "labeled lines" in sensory neuroscience states that the identity of a sensation (what you feel) is determined not by the pattern of signals but by which specific sensory neuron is activated. Which everyday observation is most consistent with this principle?',
  '[{"label": "A", "text": "Pressing firmly on a closed eye produces a visual sensation of light (phosphene), even though the stimulus is mechanical"},
    {"label": "B", "text": "Cold water feels less cold after prolonged immersion due to sensory adaptation"},
    {"label": "C", "text": "Loud sounds cause greater neural firing rates than soft sounds in auditory neurons"},
    {"label": "D", "text": "Bitter and sweet tastes activate different cortical regions"}]',
  'A',
  'The labeled-line principle holds that the brain interprets a signal based on which sensory neuron fires, regardless of what actually activated it. Pressure on the eye activates photoreceptors or ganglion cells in the visual pathway, and the brain — knowing this line is a visual line — interprets the signal as light (a phosphene). This is a classic demonstration that the quality of sensation depends on which pathway is activated, not what type of energy caused the activation. B) Adaptation involves receptor sensitivity changes, not labeled-line pathway identity. C) Firing rate encodes intensity within a modality — not the principle of labeled lines. D) Cortical differentiation of taste quality is consistent with labeled lines, but it describes a central phenomenon; A gives a clearer experimental demonstration of the principle.',
  'hard'
);

-- Q23: Absolute threshold — practical context
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'Classic psychophysics research reports that humans can detect a candle flame at 30 miles on a clear, dark night. This benchmark illustrates the concept of:',
  '[{"label": "A", "text": "The difference threshold — the smallest detectable change in candle brightness"},
    {"label": "B", "text": "The absolute threshold — the minimum stimulus intensity detectable under ideal conditions"},
    {"label": "C", "text": "Weber''s law — the candle brightness needed scales with background illumination"},
    {"label": "D", "text": "Sensory adaptation — the visual system becomes maximally sensitive after 30 miles"}]',
  'B',
  'The absolute threshold is the minimum stimulus level that can be detected under ideal conditions. Reporting that humans can see a candle at 30 miles on a clear, dark night is a benchmark description of how sensitive human vision is at its best — i.e., its absolute threshold for light detection. A) The difference threshold involves detecting a change between two stimuli levels, not a minimum detectable stimulus. C) Weber''s law applies when there is a background stimulus to compare against; the 30-mile figure describes detection of a single faint stimulus in darkness. D) Sensory adaptation describes a decrease in sensitivity with sustained stimulation — the scenario describes the sensitivity achievable after full dark adaptation, not a distance-dependent adaptation process.',
  'easy'
);

-- Q24: Sensory adaptation — functional value
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'From an evolutionary perspective, which of the following best explains why sensory adaptation is advantageous rather than purely a limitation?',
  '[{"label": "A", "text": "Adaptation increases an organism''s absolute threshold, making it more selective about stimuli"},
    {"label": "B", "text": "Adaptation reduces neural resources devoted to unchanging stimuli, freeing attention for novel or changing stimuli that are more likely to signal important events"},
    {"label": "C", "text": "Adaptation prevents overstimulation of nociceptors, reducing the risk of chronic pain"},
    {"label": "D", "text": "Adaptation synchronizes sensory systems so that all modalities habituate at the same rate"}]',
  'B',
  'Sensory adaptation is functionally valuable because constant, unchanging stimuli are generally less informative than changes in the environment. By reducing neural responses to sustained input, the nervous system can redirect attentional and processing resources toward novel, changing stimuli — the events most likely to signal threats, opportunities, or important environmental changes. A) Raising the absolute threshold would reduce sensitivity, which is not straightforwardly advantageous. C) Nociceptive adaptation does occur but is typically minimal by design — persistent pain signals are important warning signals; this is not the primary evolutionary advantage of adaptation broadly. D) Different sensory modalities and receptor types adapt at different rates depending on the nature of the receptor.',
  'medium'
);

-- Q25: JND and Weber's law — application
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A patient recovering from a hand injury lifts a 10 kg weight and can just detect when 1 kg is added. After gaining muscle strength, she lifts a 20 kg weight. According to Weber''s law, what is the minimum additional weight she can now detect?',
  '[{"label": "A", "text": "1 kg — the JND remains constant in absolute terms"},
    {"label": "B", "text": "2 kg — the JND scales proportionally with the baseline stimulus"},
    {"label": "C", "text": "0.5 kg — greater strength increases sensitivity"},
    {"label": "D", "text": "10 kg — the JND equals the original baseline weight"}]',
  'B',
  'Weber''s law: JND = k × I, where k is the Weber fraction and I is the baseline stimulus intensity. From the original data: k = 1 kg / 10 kg = 0.10. At a new baseline of 20 kg: JND = 0.10 × 20 kg = 2 kg. A) Weber''s law specifically states that the JND is a constant proportion, not a constant absolute amount — JND changes with the baseline. C) Muscle strength changes motor output; Weber''s law concerns perceptual discrimination thresholds in sensory systems, which are not directly altered by motor strength. D) JND = the baseline weight would imply k = 1.0, far above the established fraction.',
  'medium'
);

-- Q26: Signal detection — noise trials
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'In a signal detection study on pain, the researcher delivers actual electrical pulses on some trials and delivers no current on others. Trials on which no stimulus is delivered are included to measure which component of the SDT framework?',
  '[{"label": "A", "text": "The hit rate — proportion of stimulus trials correctly identified"},
    {"label": "B", "text": "The miss rate — proportion of stimulus trials not identified"},
    {"label": "C", "text": "The false alarm rate — proportion of no-stimulus trials on which the participant reports a sensation"},
    {"label": "D", "text": "The Weber fraction — proportional change needed for a just noticeable difference"}]',
  'C',
  'Noise-only (no-stimulus) trials in SDT are included specifically to quantify the false alarm rate — the proportion of blank trials on which an observer incorrectly reports detecting a signal. The false alarm rate is essential for computing the criterion (response bias) and sensitivity (d''). Without it, one cannot distinguish a genuinely sensitive observer from one who simply says "yes" to everything. A) Hit rate is measured from signal-present trials, not no-stimulus trials. B) Miss rate is also derived from signal-present trials. D) The Weber fraction is derived from a different paradigm (JND measurement), not from no-stimulus trials in SDT.',
  'medium'
);

-- Q27: Perception — top-down vs. bottom-up
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'An experienced emergency physician examining an X-ray notices an abnormal opacity in the lung that a first-year medical student fails to detect, even though both are looking at the same image. The physician''s superior detection is most likely attributable to:',
  '[{"label": "A", "text": "A lower absolute threshold resulting from years of radiological training"},
    {"label": "B", "text": "Top-down processing — prior knowledge and experience guide attention toward diagnostically relevant features"},
    {"label": "C", "text": "Superior transduction ability in the physician''s photoreceptors"},
    {"label": "D", "text": "A more conservative response criterion that eliminates false alarms"}]',
  'B',
  'Top-down processing refers to how existing knowledge, expectations, and experience shape perception. The physician''s clinical training has created mental schemas and feature templates for abnormal findings, directing attention toward and facilitating detection of the relevant opacity. A) Absolute threshold is a sensory limit determined by receptor and neural physiology — it is not substantially altered by training. C) Photoreceptor transduction is a physiological process unaffected by years of medical training. D) A more conservative criterion would reduce false alarms but also increase misses — it would not straightforwardly improve detection of real signals.',
  'medium'
);

-- Q28: Thermoreceptors
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A researcher applies a probe cooled to 20°C to a small patch of skin. Some spots on the skin report coolness while immediately adjacent spots report no sensation. This spatial variation in sensitivity is best explained by:',
  '[{"label": "A", "text": "Uniform distribution of mechanoreceptors that are selectively responding to temperature"},
    {"label": "B", "text": "The punctate distribution of thermoreceptors — temperature-sensitive free nerve endings are not uniformly distributed across the skin"},
    {"label": "C", "text": "Two-point discrimination thresholds varying across the dermatome"},
    {"label": "D", "text": "The referred pain phenomenon, in which internal organ signals are mislocated to the skin"}]',
  'B',
  'Thermoreceptors are free nerve endings that are unevenly (punctately) distributed across the skin surface, with cold spots and warm spots rather than a uniform sheet of receptors. Mapping temperature sensitivity reveals discrete sensitive spots separated by insensitive zones. A) Mechanoreceptors detect mechanical deformation, not temperature; and they are also punctately distributed, but the question is about temperature detection. C) Two-point discrimination refers to spatial resolution for touch, not temperature punctate distribution. D) Referred pain involves visceral pain signals misattributed to a body surface dermatome — not the mechanism of skin thermoreceptor mapping.',
  'medium'
);

-- Q29: Sensation — receptor potentials and action potentials
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'When a Pacinian corpuscle (a skin mechanoreceptor) is deformed by pressure, a graded receptor potential is generated. If this potential reaches threshold, an action potential fires in the associated sensory nerve axon. Which of the following correctly characterizes the relationship between receptor potential and action potential in this sequence?',
  '[{"label": "A", "text": "The receptor potential and action potential are both graded and decrease in amplitude over distance"},
    {"label": "B", "text": "The receptor potential is graded and local; the action potential is all-or-none and propagates over distance"},
    {"label": "C", "text": "Both are all-or-none signals that are generated simultaneously at the receptor"},
    {"label": "D", "text": "The receptor potential propagates to the brain, while the action potential remains local at the receptor"}]',
  'B',
  'Receptor (generator) potentials are graded electrochemical changes — their amplitude varies continuously with stimulus intensity, and they are local signals that do not propagate far. They trigger action potentials at the first node of Ranvier (or axon hillock) when they reach threshold. Action potentials are all-or-none events — once threshold is reached, a full-amplitude spike fires and propagates unchanged over the length of the axon. A) Action potentials do not decrease in amplitude (they are regenerated at each node in myelinated fibers). C) Only action potentials are all-or-none; receptor potentials are graded. D) This is the opposite of the correct direction of propagation.',
  'hard'
);

-- Q30: Perception — perceptual constancy
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'When a person walks from bright sunlight into a dimly lit building, the physical luminance hitting the retina changes dramatically, yet a white piece of paper still appears white and a black pen still appears black. This stability of perceived color/brightness despite changing illumination is best explained by:',
  '[{"label": "A", "text": "Dark adaptation — rhodopsin regenerates and restores cone sensitivity"},
    {"label": "B", "text": "Perceptual constancy — the visual system uses contextual information to maintain stable perception of object properties"},
    {"label": "C", "text": "The just noticeable difference — the luminance change exceeds the Weber fraction for brightness"},
    {"label": "D", "text": "Transduction — photoreceptors convert the new light level into appropriate neural signals"}]',
  'B',
  'Perceptual constancy is the tendency to perceive object properties (color, size, shape, brightness) as stable despite changes in the sensory input reaching the receptors. Lightness/brightness constancy allows objects to appear the same reflectance even when overall illumination changes, because the visual system computes reflectance relative to the surrounding scene. A) Dark adaptation is a slow process taking 20–30 minutes; the immediate perception of paper as white on entering a dark building is perceptual constancy, not adaptation. C) JND describes discrimination between two stimuli — not the stability of perceived properties across illumination changes. D) Transduction describes the conversion of light to neural signals at the receptor level — it is the mechanism, not the explanation for perceptual stability.',
  'medium'
);


-- ==============================
-- VISION (Q31–50)
-- ==============================

-- Q31: Cornea and lens — refraction
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'An optometrist explains that the majority of the eye''s total refractive power comes from its outermost transparent surface, while a second transparent structure provides fine-tuning of focus by changing its curvature. These two structures are, respectively:',
  '[{"label": "A", "text": "The iris and the pupil"},
    {"label": "B", "text": "The sclera and the choroid"},
    {"label": "C", "text": "The cornea and the crystalline lens"},
    {"label": "D", "text": "The fovea and the optic disc"}]',
  'C',
  'The cornea provides approximately two-thirds of the eye''s total refractive power — its fixed curvature and the air-to-tissue interface create strong refraction. The crystalline lens provides additional, adjustable refraction through accommodation (ciliary muscle contraction changes lens curvature). A) The iris regulates pupil size (light entry), not refraction. B) The sclera is the white fibrous outer coat providing structure; the choroid is the vascular middle layer — neither is primarily refractive. D) The fovea is the area of highest acuity on the retina; the optic disc is where the optic nerve exits — both are retinal structures, not refractive elements.',
  'easy'
);

-- Q32: Accommodation — ciliary muscle and lens
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A 55-year-old accountant finds it increasingly difficult to read fine print up close without reading glasses, even though his distance vision remains clear. His ophthalmologist explains that the lens has become less elastic with age. Which accommodation mechanism is failing?',
  '[{"label": "A", "text": "The iris dilates insufficiently, reducing light entry for near tasks"},
    {"label": "B", "text": "The ciliary muscles weaken, preventing pupil constriction during near focus"},
    {"label": "C", "text": "The lens cannot increase its curvature sufficiently for near focus because it has lost elasticity — a condition called presbyopia"},
    {"label": "D", "text": "The suspensory ligaments become too tight, permanently flattening the lens"}]',
  'C',
  'Accommodation for near vision requires the ciliary muscle to contract, releasing tension on the suspensory (zonular) ligaments, allowing the elastic lens to become more curved (rounder) to increase its refractive power. With aging, the lens loses elasticity (presbyopia) — even when the ciliary muscle contracts and ligament tension is released, the lens cannot round up sufficiently, and near focus fails. A) Pupil size (iris control) affects depth of field and light entry but is not the primary mechanism of accommodation. B) Pupil constriction (miosis) during near response is a reflex that accompanies but does not cause accommodation; ciliary muscle weakness is relevant but presbyopia is primarily a lens elasticity problem. D) Loose suspensory ligaments (from ciliary muscle contraction) allow rounding — tight ligaments flatten the lens; the problem in presbyopia is lens stiffness, not ligament tightness.',
  'medium'
);

-- Q33: Iris and pupil
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'When a neurologist shines a penlight into one of a patient''s eyes and both pupils constrict — the illuminated eye (direct response) and the other eye (consensual response) — this reflex tests the integrity of which pathway?',
  '[{"label": "A", "text": "The primary visual cortex (V1) in the occipital lobe"},
    {"label": "B", "text": "The afferent pathway (optic nerve/tract) and the efferent parasympathetic pathway (oculomotor nerve CN III)"},
    {"label": "C", "text": "The lateral geniculate nucleus (LGN) of the thalamus"},
    {"label": "D", "text": "The macula and foveal cone density"}]',
  'B',
  'The pupillary light reflex arc: afferent signals travel via the optic nerve (CN II) and optic tract to the pretectal nucleus in the midbrain (bypassing the LGN and cortex). The pretectal nucleus projects bilaterally to the Edinger-Westphal nucleus, which sends parasympathetic efferent signals via CN III to the ciliary ganglion, causing sphincter pupillae contraction in both eyes. A) The cortex is not part of the pupillary reflex — patients with cortical blindness still have intact pupil reflexes. C) The LGN is a relay for conscious vision, not pupillary reflexes (the reflex bypasses it via the pretectal nucleus). D) The macula determines visual acuity — not pupillary reflexes.',
  'hard'
);

-- Q34: Rods vs. cones
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'An astronomer observing faint stars at night finds she can see a dim star more clearly when she looks slightly to the side rather than directly at it. This phenomenon — averted vision — is best explained by:',
  '[{"label": "A", "text": "Cones are more densely packed in the peripheral retina, providing greater sensitivity in dim light"},
    {"label": "B", "text": "The fovea is dominated by cones (low sensitivity in dim light); the peripheral retina has more rods (high sensitivity in dim light)"},
    {"label": "C", "text": "The optic disc is located in the nasal retina, creating a blind spot that improves when averted"},
    {"label": "D", "text": "Rhodopsin in foveal cones requires more light to activate than peripheral photoreceptors"}]',
  'B',
  'Rods vastly outnumber cones in the peripheral retina and contain rhodopsin, which is extremely sensitive to light — enabling scotopic (dim light) vision. The fovea is packed almost entirely with cones, which require more photons to activate and are specialized for photopic (bright light) and color vision. Looking slightly away from a dim star shifts its image away from the rod-free fovea to the rod-rich periphery, increasing sensitivity. A) This is the opposite of the actual distribution — cones are dense at the fovea, rods in the periphery. C) The optic disc (blind spot) is located nasally; averted vision moves the image onto a different retinal zone, not specifically onto or away from the optic disc. D) Rhodopsin is found in rods, not cones; foveal cones contain opsins, which are less sensitive in dim light.',
  'medium'
);

-- Q35: Rhodopsin and phototransduction
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'After entering a dark movie theater from bright sunlight, a person requires several minutes before they can see the seats clearly. During this dark adaptation period, which process is most directly responsible for the restoration of dim-light sensitivity?',
  '[{"label": "A", "text": "The iris dilates fully, allowing more light to reach the retina"},
    {"label": "B", "text": "Cone photopigments regenerate, restoring color discrimination in darkness"},
    {"label": "C", "text": "Rhodopsin (rod photopigment) regenerates from all-trans retinal back to the 11-cis form, restoring rod sensitivity"},
    {"label": "D", "text": "The optic nerve increases its firing rate to compensate for reduced photon availability"}]',
  'C',
  'In bright light, rhodopsin in rods is bleached — the 11-cis retinal chromophore is converted to all-trans retinal, dissociating from opsin and inactivating the photopigment. In darkness, enzymatic processes slowly reconvert all-trans retinal to 11-cis retinal, which recombines with opsin to regenerate functional rhodopsin. This regeneration (taking 20–30 minutes for full rod dark adaptation) restores maximum dim-light sensitivity. A) Pupil dilation is fast (seconds) and contributes early but accounts for only a modest gain in sensitivity; the major dark adaptation effect is rod rhodopsin regeneration. B) Cone photopigments also regenerate (faster, within ~5–10 minutes), explaining initial rapid adaptation, but the prolonged dim-light sensitivity improvement is due to rod regeneration. D) The optic nerve transmits signals; it does not generate additional photosensitivity.',
  'medium'
);

-- Q36: Fovea and visual acuity
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'When reading, people move their eyes so the text falls on a specific retinal region. A patient with macular degeneration develops a central scotoma (blind spot) and must use eccentric viewing (looking off to the side) to function. The macula/fovea is the preferred fixation point because:',
  '[{"label": "A", "text": "It contains the highest density of rods, maximizing sensitivity in normal lighting"},
    {"label": "B", "text": "It is the thinnest part of the retina, allowing the most direct light path to photoreceptors — and contains the highest density of cones for maximal acuity"},
    {"label": "C", "text": "It is where the optic nerve exits, providing direct neural transmission to the brain"},
    {"label": "D", "text": "It has the greatest convergence of photoreceptors onto single ganglion cells, improving sensitivity"}]',
  'B',
  'The fovea (central pit of the macula) has the highest cone density of any retinal region, minimal convergence (nearly 1:1 cone-to-ganglion cell ratio), and a thinned inner retina (inner layers are displaced laterally) so light reaches photoreceptors with minimal scattering — all factors that maximize spatial acuity (resolution). A) The fovea is nearly rod-free — rods are the peripheral photoreceptors. C) The optic nerve exits at the optic disc, which is lateral to the fovea and is actually the blind spot — not a high-acuity point. D) High convergence (many photoreceptors onto one ganglion cell) is a feature of the rod-rich periphery, improving sensitivity at the cost of acuity — the opposite of foveal design.',
  'medium'
);

-- Q37: Blind spot (optic disc)
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'The blind spot in the human visual field corresponds anatomically to the location where:',
  '[{"label": "A", "text": "Cone density is highest and rod density is lowest, creating a gap in scotopic vision"},
    {"label": "B", "text": "The optic nerve exits the eye (optic disc), creating a region devoid of photoreceptors"},
    {"label": "C", "text": "The lens casts a shadow on the retina, blocking light from reaching photoreceptors"},
    {"label": "D", "text": "The fovea''s rod-free zone creates a sensitivity gap for dim-light stimuli"}]',
  'B',
  'The optic disc is the site where retinal ganglion cell axons exit the eye to form the optic nerve, and where retinal blood vessels enter. Because there are no photoreceptors here, it creates a blind spot — a region of the visual field from which no information is detected. The brain "fills in" this gap using surrounding visual information. A) High cone density (fovea) does create a scotopic gap, but it is not the classical blind spot — it can still detect bright stimuli. C) The lens does not cast a significant blind spot; the issue is a complete absence of photoreceptors. D) The fovea''s rod-free zone is not the blind spot; the fovea still has abundant cones for photopic detection.',
  'easy'
);

-- Q38: Retinal cell layers — bipolar and ganglion cells
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'In the retina, photoreceptors do not send axons directly to the brain. Instead, signals pass through intermediate neurons before being transmitted via the optic nerve. The correct order of signal flow through retinal layers is:',
  '[{"label": "A", "text": "Ganglion cells → bipolar cells → photoreceptors → optic nerve"},
    {"label": "B", "text": "Photoreceptors → bipolar cells → ganglion cells → optic nerve"},
    {"label": "C", "text": "Photoreceptors → horizontal cells → amacrine cells → optic nerve"},
    {"label": "D", "text": "Bipolar cells → photoreceptors → ganglion cells → optic nerve"}]',
  'B',
  'The direct signal pathway through the retina is: photoreceptors (rods and cones) → bipolar cells → retinal ganglion cells, whose axons form the optic nerve and project to the brain. Horizontal cells modulate communication between photoreceptors and bipolar cells (lateral inhibition at the outer plexiform layer), and amacrine cells modulate bipolar-to-ganglion cell communication (at the inner plexiform layer). A) This reverses the order. C) Horizontal and amacrine cells are modulatory interneurons, not the main signal path. D) Bipolar cells receive input from photoreceptors, not the other way around.',
  'easy'
);

-- Q39: Horizontal cells and lateral inhibition
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A researcher finds that when a small spot of light is shone on a retinal region, neurons at the center of the illuminated area are excited, while neurons immediately surrounding the illuminated area are inhibited, enhancing edge contrast. This phenomenon is most directly mediated by:',
  '[{"label": "A", "text": "Amacrine cells, which connect ganglion cells across the inner nuclear layer"},
    {"label": "B", "text": "Horizontal cells, which connect neighboring photoreceptors and bipolar cells and mediate lateral inhibition"},
    {"label": "C", "text": "Ganglion cell axons, which send collateral branches back to inhibit adjacent ganglion cells"},
    {"label": "D", "text": "The LGN, which performs center-surround processing before signals reach the cortex"}]',
  'B',
  'Horizontal cells are laterally projecting interneurons in the outer nuclear layer of the retina. They receive input from photoreceptors and feed back inhibitory signals to neighboring photoreceptors and bipolar cells, creating lateral inhibition. This generates the center-surround receptive fields of bipolar cells (and ultimately ganglion cells), enhancing contrast and edge detection. A) Amacrine cells modulate inner retinal signaling (between bipolar and ganglion cells) — they contribute to other aspects of retinal processing but are not primarily responsible for the outer-layer lateral inhibition described. C) Ganglion cell axons project forward via the optic nerve — they do not send local inhibitory collaterals within the retina. D) The LGN does have center-surround organization, but this originates in the retina through horizontal cell lateral inhibition.',
  'hard'
);

-- Q40: Optic chiasm — visual field organization
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A patient presents with "tunnel vision" — she has lost peripheral vision bilaterally but retains central vision. MRI reveals a pituitary tumor compressing the optic chiasm from below. Which fibers are most likely being compressed to produce this pattern?',
  '[{"label": "A", "text": "The temporal (lateral) retinal fibers, which carry nasal visual field information and do not cross at the chiasm"},
    {"label": "B", "text": "The nasal (medial) retinal fibers, which cross at the chiasm and carry temporal visual field information from each eye"},
    {"label": "C", "text": "The optic radiations in the temporal lobe, which carry inferior visual field information"},
    {"label": "D", "text": "The macula-sparing fibers that project directly to the superior colliculus"}]',
  'B',
  'At the optic chiasm, fibers from the nasal half of each retina cross to the contralateral optic tract (they carry information from the temporal visual field of each eye). Fibers from the temporal half of each retina do not cross (they carry information from the nasal visual field). Pituitary tumors compress the central, crossing nasal fibers at the chiasm, knocking out temporal visual field information from both eyes — producing bitemporal hemianopia (loss of peripheral/lateral vision = tunnel vision). A) Temporal retinal fibers do not cross; compressing them would affect nasal visual fields, not the bitemporal pattern seen. C) Optic radiations are in the temporal/parietal lobe — damage here causes a homonymous field loss (same side in both eyes), not bitemporal loss. D) The superior colliculus pathway does not have macula-sparing fibers relevant to this pattern.',
  'hard'
);

-- Q41: Lateral geniculate nucleus (LGN)
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'After leaving the optic chiasm, most visual afferent signals synapse in a thalamic relay nucleus before reaching the primary visual cortex. This structure, which maintains retinotopic organization and is organized into distinct layers receiving input from each eye separately, is the:',
  '[{"label": "A", "text": "Superior colliculus — a midbrain structure involved in reflexive eye movements"},
    {"label": "B", "text": "Lateral geniculate nucleus (LGN) of the thalamus — the primary thalamic relay for conscious visual processing"},
    {"label": "C", "text": "Edinger-Westphal nucleus — a parasympathetic nucleus controlling pupil size"},
    {"label": "D", "text": "Inferior temporal cortex — involved in object recognition"}]',
  'B',
  'The lateral geniculate nucleus (LGN) of the thalamus is the main relay station for visual information en route to the primary visual cortex (V1). It has 6 layers: layers 1 and 2 are magnocellular (M cells — motion, depth, low contrast), layers 3–6 are parvocellular (P cells — color, fine detail), and it maintains retinotopic mapping. A) The superior colliculus receives some optic tract input and is important for reflexive gaze shifts and spatial attention, but not for the primary conscious visual processing pathway. C) The Edinger-Westphal nucleus controls parasympathetic pupillary constriction and accommodation — not a visual relay. D) The inferior temporal cortex is higher-order visual cortex for object recognition — downstream of the LGN.',
  'medium'
);

-- Q42: Primary visual cortex and feature detectors
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'Hubel and Wiesel recorded from neurons in area V1 (primary visual cortex) of cats and found that individual neurons responded maximally to bars of light at specific orientations rather than to diffuse light. These neurons are called:',
  '[{"label": "A", "text": "Ganglion cells — because they receive direct photoreceptor input and have center-surround receptive fields"},
    {"label": "B", "text": "Feature detectors — cortical neurons specialized to respond to specific stimulus properties such as orientation, direction of movement, or spatial frequency"},
    {"label": "C", "text": "Parvocellular neurons — because they specialize in fine detail and color"},
    {"label": "D", "text": "Amacrine cells — interneurons that modulate signal processing within the retina"}]',
  'B',
  'Hubel and Wiesel''s landmark work identified feature detectors — neurons in V1 that respond selectively to specific visual features (orientation, direction of motion, spatial frequency) rather than to simple diffuse illumination. Simple cells respond to oriented bars at specific positions; complex cells respond to oriented bars regardless of position. A) Ganglion cells are retinal neurons with center-surround (not oriented bar) receptive fields. C) Parvocellular neurons are a layer type in the LGN and V1 input layers — they are defined by cell size and input type, not by orientation selectivity. D) Amacrine cells are retinal interneurons — not cortical neurons studied by Hubel and Wiesel.',
  'easy'
);

-- Q43: Parallel processing — ventral vs. dorsal stream
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A neurologist evaluates two patients. Patient A can reach accurately toward objects and navigate around furniture but cannot recognize the face of a family member. Patient B recognizes faces and reads text normally but frequently misjudges the location of objects and has trouble reaching for them. These deficits suggest damage to which visual processing streams, respectively?',
  '[{"label": "A", "text": "Patient A: dorsal stream damage; Patient B: ventral stream damage"},
    {"label": "B", "text": "Patient A: ventral stream damage; Patient B: dorsal stream damage"},
    {"label": "C", "text": "Both patients have LGN lesions affecting different cell layers"},
    {"label": "D", "text": "Patient A: magnocellular pathway damage; Patient B: parvocellular pathway damage"}]',
  'B',
  'The two main cortical visual streams are: (1) the ventral stream ("what" pathway) — from V1 through the temporal lobe — processes object identity, color, and form recognition; and (2) the dorsal stream ("where/how" pathway) — from V1 through the parietal lobe — processes spatial location and visually guided action. Patient A can act (dorsal stream intact) but cannot recognize faces (ventral stream damaged — resulting in prosopagnosia). Patient B can recognize (ventral stream intact) but cannot accurately locate or reach for objects (dorsal stream damaged — resulting in optic ataxia). A) This reverses the stream assignments. C) LGN lesions would produce field deficits, not these dissociations. D) Magno/parvocellular pathways feed into both streams; this distinction doesn''t map onto the described clinical dissociation.',
  'hard'
);

-- Q44: Parvocellular vs. magnocellular
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A researcher presents subjects with stimuli varying in color detail and high spatial frequency (fine pattern) versus stimuli varying in motion and low spatial frequency (coarse pattern). Which visual processing subsystem is best suited for the first type of stimulus?',
  '[{"label": "A", "text": "Magnocellular pathway — specialized for motion, depth, and low-contrast, rapidly changing stimuli"},
    {"label": "B", "text": "Parvocellular pathway — specialized for color, fine spatial detail, and high spatial frequency processing"},
    {"label": "C", "text": "The superior colliculus pathway — specialized for reflexive orienting to high-detail stimuli"},
    {"label": "D", "text": "The koniocellular pathway — specialized for motion detection in the periphery"}]',
  'B',
  'The parvocellular (P) pathway originates in midget retinal ganglion cells, passes through layers 3–6 of the LGN, and ultimately feeds predominantly into the ventral ("what") stream. P cells have high spatial resolution, slow temporal response, and color-opponent receptive fields — making them ideal for processing fine detail and color. The magnocellular (M) pathway (layers 1–2 of LGN) has large receptive fields, fast temporal response, and poor color discrimination — making it suited for motion and low-contrast, rapidly changing stimuli. A) This describes magnocellular properties, appropriate for the second stimulus type. C) The superior colliculus is for orienting and reflexive eye movements, not detail discrimination. D) The koniocellular (K) pathway receives input from bistratified ganglion cells and processes blue-yellow color signals — not motion in the periphery.',
  'medium'
);

-- Q45: Depth perception — binocular disparity
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A patient who lost function in one eye as an infant plays basketball well but consistently misjudges the distance to the basket when attempting three-point shots compared to teammates with normal binocular vision. Which depth cue is most critically impaired by monocular vision?',
  '[{"label": "A", "text": "Linear perspective — the apparent convergence of parallel lines at a distance"},
    {"label": "B", "text": "Binocular disparity — the slight difference in each eye''s retinal image used by the brain to compute depth"},
    {"label": "C", "text": "Motion parallax — the relative movement of objects at different distances when the head moves"},
    {"label": "D", "text": "Relative size — smaller objects are perceived as farther away"}]',
  'B',
  'Binocular disparity is a binocular (two-eye) depth cue: because the eyes are horizontally separated, each receives a slightly different retinal image. The brain uses the degree of disparity to compute distance — greater disparity = closer object. This cue is lost with monocular vision. Linear perspective, relative size, texture gradient, and motion parallax are all monocular cues that remain available with one eye. Motion parallax requires head movement but only one eye. The patient''s consistent misjudgment of three-point distance — a task requiring precise absolute depth judgment — points to loss of the powerful binocular disparity cue, which is most precise for nearby to intermediate distances.',
  'medium'
);

-- Q46: Depth perception — monocular cues
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A Renaissance painter creates a convincing impression of depth on a flat canvas. She paints distant mountains as smaller, lighter in color (atmospheric haze), and with less textural detail than nearby objects, and makes parallel roads appear to converge toward a horizon point. She is exploiting which category of depth cues?',
  '[{"label": "A", "text": "Binocular cues — specifically stereopsis and convergence"},
    {"label": "B", "text": "Monocular (pictorial) cues — including relative size, aerial perspective, texture gradient, and linear perspective"},
    {"label": "C", "text": "Vestibular cues — proprioceptive signals from head position"},
    {"label": "D", "text": "Accommodation cues — the degree of lens curvature change for near vs. far objects"}]',
  'B',
  'Pictorial (monocular) depth cues can be represented on a flat two-dimensional surface: relative size (distant objects subtend smaller visual angles), aerial/atmospheric perspective (distant objects appear lighter and less saturated due to light scattering), texture gradient (texture becomes denser with distance), and linear perspective (parallel lines converge at a vanishing point). These are monocular cues because they do not require two eyes. A) Binocular cues (stereopsis, vergence) require two eyes and cannot be depicted on a flat canvas. C) Vestibular cues come from the inner ear — irrelevant to painting. D) Accommodation provides some depth information for very close objects; it is a physiological cue that cannot be painted.',
  'easy'
);

-- Q47: Superior colliculus
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A patient with damage to the primary visual cortex (V1) is clinically blind in the affected visual field. However, when a stimulus is presented in the blind field and the patient is asked to "guess" where it is, she points to the correct location at above-chance rates, despite having no conscious visual experience. This phenomenon — called blindsight — most likely relies on a visual pathway that bypasses V1. Which structure is most likely mediating blindsight?',
  '[{"label": "A", "text": "The lateral geniculate nucleus — its projections to V1 are preserved"},
    {"label": "B", "text": "The superior colliculus — a midbrain structure that receives direct retinal input and mediates spatial localization and orientation without conscious awareness"},
    {"label": "C", "text": "The optic chiasm — which reroutes signals around the damaged cortex"},
    {"label": "D", "text": "The fovea — which has direct projections to the parietal lobe"}]',
  'B',
  'Blindsight is thought to depend on the superior colliculus (and possibly projections to extrastriate cortex via the pulvinar), which receives direct retinal ganglion cell input and is involved in spatial localization, reflexive orienting, and eye movement control. This pathway bypasses the striate cortex (V1), allowing spatial responses without conscious visual experience. A) The LGN projects to V1; if V1 is damaged, signals traveling LGN → V1 would not produce responses. C) The optic chiasm simply routes signals — it does not bypass cortical damage. D) Foveal projections travel through the standard retino-geniculo-striate pathway, which requires V1.',
  'hard'
);

-- Q48: Sclera and choroid
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'The white of the eye visible externally is the outer fibrous coat that maintains the globe''s shape. Beneath it lies a pigmented, highly vascular layer that supplies oxygen and nutrients to the outer retina and contains melanin that absorbs stray light. These layers are, respectively:',
  '[{"label": "A", "text": "Cornea and iris"},
    {"label": "B", "text": "Sclera and choroid"},
    {"label": "C", "text": "Retina and optic nerve"},
    {"label": "D", "text": "Lens and ciliary body"}]',
  'B',
  'The sclera is the tough, white, fibrous outer coat of the eye — visible as the white of the eye — that maintains the structural integrity of the globe. The choroid is the vascular, pigmented middle layer (uvea) between the sclera and retina. It is richly vascularized (supplying the photoreceptors) and contains melanin to absorb excess light and reduce internal scatter. A) The cornea is the transparent anterior dome; the iris is the colored muscular diaphragm — neither is the white structural coat or the vascular middle layer. C) The retina is the neural layer; the optic nerve is the axon bundle — not the structural/vascular coats. D) The lens is the transparent biconvex focusing element; the ciliary body produces aqueous humor and controls accommodation.',
  'easy'
);

-- Q49: Aqueous humor and intraocular pressure
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A patient is diagnosed with open-angle glaucoma, in which impaired drainage of the fluid filling the anterior segment of the eye leads to elevated intraocular pressure that gradually damages the optic nerve. The fluid responsible for maintaining this pressure is:',
  '[{"label": "A", "text": "Vitreous humor — the gel-like substance that fills the posterior segment of the eye"},
    {"label": "B", "text": "Aqueous humor — the clear fluid produced by the ciliary body that circulates in the anterior and posterior chambers"},
    {"label": "C", "text": "Rhodopsin — the photopigment in rods that is bleached by light"},
    {"label": "D", "text": "Cerebrospinal fluid — which circulates around the optic nerve sheath"}]',
  'B',
  'Aqueous humor is the clear fluid produced continuously by the ciliary body epithelium that fills the posterior chamber (between iris and lens) and the anterior chamber (between cornea and iris). It drains primarily through the trabecular meshwork and Schlemm''s canal. In glaucoma, impaired drainage leads to increased intraocular pressure, which compresses and damages optic nerve fibers. A) Vitreous humor fills the vitreous chamber (posterior segment, behind the lens) — it is a gel that does not circulate and is not the fluid implicated in typical glaucoma. C) Rhodopsin is a photopigment — not a fluid. D) CSF does surround the optic nerve sheath and elevated CSF pressure can affect the optic nerve, but the fluid in open-angle glaucoma is aqueous humor.',
  'medium'
);

-- Q50: Parallel processing and visual cortex areas
INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'After visual signals reach the primary visual cortex (V1), they are processed in parallel by multiple specialized extrastriate areas rather than sequentially through a single pathway. A patient with a lesion in area V4 loses the ability to perceive color (achromatopsia) despite intact motion and form perception. This finding best supports which principle of visual cortical organization?',
  '[{"label": "A", "text": "Serial processing — V1 processes color before passing signals to motion areas"},
    {"label": "B", "text": "Parallel processing — different visual attributes (color, motion, form) are processed by distinct, specialized cortical areas simultaneously"},
    {"label": "C", "text": "Feature detection — V4 neurons respond to oriented bars of specific wavelengths"},
    {"label": "D", "text": "Binocular rivalry — competing monocular inputs are resolved in extrastriate cortex"}]',
  'B',
  'Parallel processing in the visual cortex means that different visual attributes are processed simultaneously in distinct areas: V4 is associated with color processing, V5/MT with motion processing, and other areas with form and depth. The selective loss of color perception with V4 damage, while motion and form perception are spared, is a classic demonstration that these attributes are processed in parallel streams rather than in a single serial hierarchy. A) If processing were purely serial with V1 handling color first, a V4 lesion would also disrupt downstream motion and form processing. C) Feature detectors in V1 respond to oriented bars; V4''s specialization is color, not oriented bars — and the principle demonstrated here is parallel organization, not single-neuron feature tuning. D) Binocular rivalry is a perceptual competition between conflicting monocular inputs — unrelated to color-selective extrastriate processing.',
  'medium'
);
