-- ============================================================
-- Praxis Prep: MCAT Psych/Soc Chapter 2 Batch 3
-- 75 questions: Other Senses (25), Object Recognition (25),
-- High-Yield Gap Coverage (25)
-- ============================================================

-- ============================================================
-- OTHER SENSES (Questions 1–25)
-- ============================================================

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A 32-year-old chef reports that foods taste bland after recovering from a viral upper respiratory infection. MRI shows no structural brain lesions. Which of the following best explains her diminished taste perception?',
  '[{"label": "A", "text": "Damage to cranial nerve VIII reducing signal transduction from taste buds"},
    {"label": "B", "text": "Loss of olfactory receptor neuron function reducing retronasal olfaction"},
    {"label": "C", "text": "Destruction of Meissner corpuscles on the tongue surface"},
    {"label": "D", "text": "Lesion of the primary gustatory cortex in the occipital lobe"}]',
  'B',
  'Flavor perception depends heavily on retronasal olfaction — smell that reaches olfactory receptors from the back of the mouth during eating. Viral URIs commonly damage olfactory receptor neurons, reducing this input and making food taste bland. A) CN VIII is the vestibulocochlear nerve (hearing/balance), not taste; gustatory signals travel via CN VII, IX, and X. C) Meissner corpuscles detect light touch in skin, not taste; taste buds on papillae are the relevant receptors. D) Primary gustatory cortex is in the insula and frontal operculum, not the occipital lobe (which processes vision).',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A researcher studies how pheromones influence mate selection in rodents. She finds that surgical removal of a specific structure eliminates pheromone-driven mating behavior while leaving odor discrimination for food intact. Which structure was most likely removed?',
  '[{"label": "A", "text": "Main olfactory bulb"},
    {"label": "B", "text": "Vomeronasal organ"},
    {"label": "C", "text": "Piriform cortex"},
    {"label": "D", "text": "Orbitofrontal cortex"}]',
  'B',
  'The vomeronasal organ (VNO) is a specialized chemosensory structure that detects pheromones and sends signals through the accessory olfactory bulb to limbic areas controlling reproductive behavior. Its removal eliminates pheromone-driven behavior while leaving general olfaction intact. A) The main olfactory bulb processes general odors; removing it would impair food-odor discrimination as well. C) The piriform cortex is primary olfactory cortex involved in conscious odor perception, not specifically pheromone processing. D) The orbitofrontal cortex integrates olfactory and taste information for flavor evaluation but is not the primary pheromone-processing structure.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'Unlike all other sensory modalities, olfactory information initially reaches the cortex without first synapsing in the thalamus. Which of the following correctly traces the initial olfactory pathway?',
  '[{"label": "A", "text": "Olfactory receptor neurons → olfactory bulb → piriform cortex"},
    {"label": "B", "text": "Olfactory receptor neurons → thalamus → orbitofrontal cortex"},
    {"label": "C", "text": "Olfactory receptor neurons → hypothalamus → amygdala"},
    {"label": "D", "text": "Olfactory receptor neurons → lateral geniculate nucleus → piriform cortex"}]',
  'A',
  'Olfaction is unique because it initially bypasses the thalamus. Olfactory receptor neurons project axons through the cribriform plate to synapse in the olfactory bulb, which then sends signals via the olfactory tract to the piriform cortex (primary olfactory cortex). B) This pathway includes the thalamus, contradicting the unique thalamus-bypassing feature of olfaction. C) While olfactory signals do reach the hypothalamus and amygdala, this is not the correct initial relay sequence — the olfactory bulb is the first central relay. D) The lateral geniculate nucleus is a thalamic relay for vision, not olfaction.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A patient with diabetic peripheral neuropathy reports that she cannot feel a vibrating tuning fork placed on her ankle, though she can still feel a pinprick. Which receptor type is most likely affected by her neuropathy?',
  '[{"label": "A", "text": "Free nerve endings"},
    {"label": "B", "text": "Merkel cells"},
    {"label": "C", "text": "Pacinian corpuscles"},
    {"label": "D", "text": "Ruffini endings"}]',
  'C',
  'Pacinian corpuscles are deep-pressure and vibration receptors with large receptive fields. They are rapidly adapting mechanoreceptors located deep in the dermis and are specifically tuned to detect vibration (like a tuning fork). A) Free nerve endings detect pain and temperature — since the patient can still feel a pinprick, these are intact. B) Merkel cells detect sustained pressure and fine texture, not vibration. D) Ruffini endings detect skin stretch and contribute to proprioception, not vibration detection.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A neurologist measures two-point discrimination thresholds on different body regions. She finds the smallest threshold (greatest acuity) at one location and the largest threshold (least acuity) at another. Which pair correctly matches the smallest and largest thresholds?',
  '[{"label": "A", "text": "Smallest: fingertips; Largest: upper back"},
    {"label": "B", "text": "Smallest: upper back; Largest: fingertips"},
    {"label": "C", "text": "Smallest: forearm; Largest: lips"},
    {"label": "D", "text": "Smallest: thigh; Largest: palm"}]',
  'A',
  'Two-point discrimination threshold is smallest (most sensitive) where receptor density is highest and cortical representation is largest — the fingertips. The upper back has sparse receptor density and minimal cortical representation, yielding the largest threshold. B) This reverses the correct relationship. C) The forearm has relatively poor acuity while the lips have excellent acuity — this is backwards. D) The thigh has poor acuity and the palm has good acuity — also reversed.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A researcher places a metal object at exactly skin temperature on a participant''s forearm. The participant reports feeling nothing at the contact site. This phenomenon is best explained by which concept?',
  '[{"label": "A", "text": "Sensory adaptation of Pacinian corpuscles"},
    {"label": "B", "text": "Physiological zero — the temperature at which thermoreceptors are not activated"},
    {"label": "C", "text": "Gate theory blocking afferent thermal signals"},
    {"label": "D", "text": "Two-point threshold being too large in the forearm"}]',
  'B',
  'Physiological zero is the skin temperature (~30-36°C) at which neither warm nor cold thermoreceptors are activated. An object at this temperature produces no thermal sensation. A) Pacinian corpuscles detect vibration/deep pressure, not temperature; and the issue is not adaptation but absence of stimulation. C) Gate theory of pain involves large-diameter fibers blocking pain signals at the spinal cord — it does not explain absence of thermal perception. D) Two-point threshold relates to spatial acuity of touch, not temperature detection.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A patient experiencing a myocardial infarction reports severe pain in his left arm and jaw despite no injury to those regions. This clinical finding is best explained by:',
  '[{"label": "A", "text": "Phantom limb pain caused by cortical reorganization"},
    {"label": "B", "text": "Convergence of visceral and somatic afferent fibers onto shared spinal cord neurons"},
    {"label": "C", "text": "Activation of large-diameter A-beta fibers closing the pain gate"},
    {"label": "D", "text": "Sensitization of peripheral nociceptors in the left arm"}]',
  'B',
  'Referred pain occurs when visceral afferents (from the heart) and somatic afferents (from the arm/jaw) converge on the same second-order neurons in the spinal cord. The brain misattributes the visceral signal to the somatic region. A) Phantom limb pain occurs after amputation due to cortical reorganization — this patient has intact limbs and the pain source is cardiac. C) Gate theory describes pain modulation, not pain referral from viscera. D) There is no actual peripheral nociceptor activation in the arm — the pain is referred from the heart.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A physical therapist treats a patient with chronic lower back pain by applying transcutaneous electrical nerve stimulation (TENS). The patient reports significant pain relief during treatment. Which theory best explains the mechanism of TENS?',
  '[{"label": "A", "text": "Gate theory — electrical stimulation activates large-diameter A-beta fibers that inhibit pain signal transmission"},
    {"label": "B", "text": "Opponent-process theory — the electrical sensation creates an opposing emotional response"},
    {"label": "C", "text": "Weber''s law — the electrical stimulus raises the just noticeable difference for pain"},
    {"label": "D", "text": "Signal detection theory — TENS shifts the patient''s response bias toward reporting less pain"}]',
  'A',
  'The gate theory of pain (Melzack & Wall) proposes that activation of large-diameter A-beta fibers (which carry non-painful touch/pressure signals) can inhibit transmission of pain signals carried by small-diameter C fibers at the spinal cord level. TENS activates these large fibers, effectively "closing the gate" on pain. B) Opponent-process theory relates to color vision or emotion, not pain modulation. C) Weber''s law describes the relationship between stimulus magnitude and JND — it does not explain pain relief mechanisms. D) Signal detection theory involves separating sensitivity from response bias; TENS produces physiological pain relief, not just a change in reporting bias.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'An amputee reports burning pain in his missing right hand. His neurologist finds that touching the right side of his face also produces sensation perceived as coming from the missing hand. Which phenomenon best explains why facial stimulation produces hand sensation?',
  '[{"label": "A", "text": "Referred pain from facial nociceptors converging on hand spinal neurons"},
    {"label": "B", "text": "Cortical reorganization in the somatosensory cortex, where the face area expands into the adjacent hand area"},
    {"label": "C", "text": "Activation of mirror neurons creating bilateral sensory representation"},
    {"label": "D", "text": "Peripheral nerve regeneration connecting facial nerves to former hand nerve pathways"}]',
  'B',
  'In the somatosensory homunculus, the face representation is adjacent to the hand representation. After amputation, the cortical area formerly devoted to the hand becomes deafferented. The adjacent face area undergoes cortical reorganization, expanding into the deafferented hand territory. When the face is touched, the brain interprets signals reaching the former hand cortex as hand sensation. A) Referred pain involves visceral-somatic convergence at the spinal cord, not cortical reorganization. C) Mirror neurons are involved in action observation, not somatosensory remapping. D) Peripheral nerve regeneration between face and hand pathways does not occur — this is a central (cortical) phenomenon.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A gustatory researcher isolates a single taste receptor cell and exposes it to various stimuli. The cell responds maximally to the amino acid glutamate and shows minimal response to NaCl, HCl, quinine, and sucrose. This cell most likely contains receptors for:',
  '[{"label": "A", "text": "Sweet taste — glutamate activates the same T1R receptors as sugars"},
    {"label": "B", "text": "Umami taste — glutamate is the primary stimulus for T1R1/T1R3 receptors"},
    {"label": "C", "text": "Salty taste — glutamate dissociates into Na+ ions in solution"},
    {"label": "D", "text": "Bitter taste — glutamate is an amino acid detected by T2R receptors"}]',
  'B',
  'Umami is the fifth basic taste, and its primary stimulus is glutamate (and other amino acids). Umami receptors are heterodimers of T1R1 and T1R3 subunits that specifically bind glutamate. A) Sweet taste receptors (T1R2/T1R3) respond to sugars, not glutamate specifically; different T1R subunit combinations create different taste specificities. C) Salty taste is mediated by direct Na+ ion influx through ENaC channels — glutamate does not dissociate into Na+. D) Bitter taste receptors (T2R family) detect potentially toxic compounds like quinine and alkaloids, not amino acids.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'During a taste experiment, a participant can identify sour and salty stimuli but cannot detect sweet or bitter tastes. Biopsy reveals selective loss of taste receptor cells on specific papillae. Which papillae are most likely damaged?',
  '[{"label": "A", "text": "Fungiform papillae only, as they are the sole location for sweet and bitter receptors"},
    {"label": "B", "text": "Circumvallate papillae, which contain the highest density of taste buds and disproportionately represent sweet and bitter"},
    {"label": "C", "text": "Filiform papillae, which are the primary taste receptor structures for sweet and bitter"},
    {"label": "D", "text": "Foliate papillae exclusively, as they are the only papillae innervated by the glossopharyngeal nerve"}]',
  'B',
  'Circumvallate papillae, located at the back of the tongue in a V-shape, contain the highest density of taste buds (hundreds per papilla) and are particularly responsive to bitter stimuli — an evolutionary advantage for detecting toxins before swallowing. They also contribute significantly to sweet perception. A) Fungiform papillae contain taste buds sensitive to all five tastes, not just sweet and bitter; and they are not the sole location. C) Filiform papillae provide texture sensation but do NOT contain taste buds — they are the most numerous papillae but serve mechanical, not gustatory, function. D) Foliate papillae are on the sides of the tongue and are innervated by both CN VII and CN IX; they are not the only papillae with glossopharyngeal innervation.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A toxicologist notes that humans can detect the bitter taste of certain plant alkaloids at extremely low concentrations — far lower than the threshold for detecting sweet or salty stimuli. The evolutionary advantage of this low bitter threshold is most likely:',
  '[{"label": "A", "text": "Bitter compounds are more soluble than sweet or salty ones, facilitating receptor binding"},
    {"label": "B", "text": "T2R bitter receptors are G-protein coupled and amplify signals more than ion-channel-based salt receptors"},
    {"label": "C", "text": "Detecting potentially toxic substances at low concentrations confers a survival advantage"},
    {"label": "D", "text": "Bitter substances always co-occur with sour substances, doubling the receptor activation"}]',
  'C',
  'The low detection threshold for bitter taste is an evolutionary adaptation. Many toxic compounds (alkaloids, glycosides) taste bitter, and detecting them at very low concentrations allows organisms to reject potentially lethal foods before ingesting a harmful dose. A) Solubility does not determine detection threshold — the receptor sensitivity and signal transduction cascade are more relevant. B) While T2R receptors are indeed GPCRs, this is a mechanism description, not an evolutionary explanation; the question asks about evolutionary advantage. D) Bitter and sour do not always co-occur, and even if they did, this would not explain the independently low bitter threshold.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A neuroscience student touches a hot stove and immediately withdraws her hand. She then applies ice to the burn, and the initial application feels intensely cold before the area becomes numb. The numbness during prolonged ice application is best explained by:',
  '[{"label": "A", "text": "Gate theory — cold signals from ice close the gate to pain transmission"},
    {"label": "B", "text": "Sensory adaptation — thermoreceptors decrease firing rate with sustained, unchanging stimulation"},
    {"label": "C", "text": "Physiological zero — the ice brings skin temperature to the neutral point"},
    {"label": "D", "text": "Lateral inhibition — surrounding cold receptors inhibit the central cold receptors"}]',
  'B',
  'Sensory adaptation occurs when receptors decrease their firing rate in response to a constant, unchanging stimulus. Thermoreceptors respond most strongly to temperature changes; with prolonged ice application at a constant temperature, they adapt and reduce signaling, producing numbness. A) Gate theory explains pain modulation through large-fiber activation, not thermoreceptor adaptation. C) Physiological zero is normal skin temperature (~30-36°C) — ice makes skin much colder than this, not at the neutral point. D) Lateral inhibition is a spatial contrast mechanism (commonly in vision and touch), not the primary explanation for temporal adaptation to a constant thermal stimulus.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A researcher maps the somatosensory cortex and finds that the cortical area devoted to the lips and tongue is disproportionately large compared to the cortical area for the trunk. This disproportionate representation is best explained by:',
  '[{"label": "A", "text": "The lips and tongue have larger surface area than the trunk"},
    {"label": "B", "text": "The density of sensory receptors and behavioral importance of a body region determines cortical representation"},
    {"label": "C", "text": "The trunk has fewer spinal cord segments devoted to somatosensory processing"},
    {"label": "D", "text": "The lips and tongue are closer to the brain, reducing signal degradation"}]',
  'B',
  'The somatosensory homunculus represents body regions proportional to their receptor density and behavioral importance, not physical size. The lips and tongue have extremely high receptor density and are critical for speech, eating, and fine tactile discrimination. B) This correctly identifies the principle. A) The trunk has far greater surface area than the lips — physical size does not determine cortical representation. C) The number of spinal segments is not the primary determinant of cortical representation size. D) Distance from the brain does not determine cortical area — the hands are farther than the trunk but have larger cortical representation.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A patient undergoing surgery receives a local anesthetic that blocks small-diameter, unmyelinated C fibers first, followed by larger myelinated fibers at higher doses. At the lowest effective dose, the patient would most likely lose sensation of:',
  '[{"label": "A", "text": "Vibration and deep pressure before pain and temperature"},
    {"label": "B", "text": "Pain and temperature before touch and pressure"},
    {"label": "C", "text": "Light touch and proprioception before pain and temperature"},
    {"label": "D", "text": "All sensory modalities simultaneously"}]',
  'B',
  'Small-diameter unmyelinated C fibers carry slow pain and temperature information and are blocked first by local anesthetics at low doses. Larger myelinated fibers (A-beta for touch/pressure, A-alpha for proprioception) require higher concentrations to block. A) This is reversed — vibration/deep pressure travel via large myelinated fibers blocked last. C) Light touch and proprioception travel via myelinated fibers blocked at higher doses, not first. D) Different fiber types have different susceptibilities to local anesthetics based on diameter and myelination, so blockade is sequential, not simultaneous.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A food scientist studies how holding the nose while eating eliminates the ability to distinguish between apple and onion slices of identical texture. This finding best demonstrates:',
  '[{"label": "A", "text": "Taste receptor cells on the tongue cannot distinguish between fructose and sulfur compounds"},
    {"label": "B", "text": "Retronasal olfaction is critical for flavor discrimination beyond basic taste qualities"},
    {"label": "C", "text": "Somatosensory input from the tongue is the primary determinant of food identification"},
    {"label": "D", "text": "Gustatory adaptation eliminates the ability to detect differences between similar foods"}]',
  'B',
  'When the nose is held, retronasal olfaction (volatile chemicals reaching olfactory receptors from the back of the mouth) is blocked. Since basic taste qualities (sweet, sour, salty, bitter, umami) are similar between apple and onion at matched textures, it is the olfactory component that distinguishes them. A) Taste receptors can detect different compounds, but both apple and onion have sweet components — the distinguishing factor is smell, not taste receptor limitation. C) Since the textures were matched, somatosensory input is identical — it cannot explain the normal ability to distinguish them. D) Gustatory adaptation requires prolonged exposure to one stimulus; this is not what occurs during nose-holding.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'Sour taste perception is initiated by hydrogen ions (H+). A researcher hypothesizes that lowering the pH of a solution will linearly increase sour taste intensity. However, results show that organic acids (like citric acid) taste more sour than hydrochloric acid at the same pH. Which factor best explains this discrepancy?',
  '[{"label": "A", "text": "Organic acids activate both H+ ion channels and specific G-protein coupled receptors on taste cells"},
    {"label": "B", "text": "Organic acid molecules can penetrate taste cell membranes, releasing H+ intracellularly and amplifying the sour signal"},
    {"label": "C", "text": "Hydrochloric acid denatures taste receptor proteins at low pH, reducing their sensitivity"},
    {"label": "D", "text": "Organic acids simultaneously activate umami receptors, which are misinterpreted as enhanced sourness"}]',
  'B',
  'Undissociated organic acid molecules (like citric acid) can cross the taste cell membrane and dissociate inside the cell, releasing H+ intracellularly. This adds to the extracellular H+ effect, amplifying the sour signal beyond what pH alone predicts. A) While this is a plausible mechanism, current evidence supports the intracellular acidification model rather than specific GPCR activation for sour taste enhancement by organic acids. C) At the pH values used in typical taste experiments, HCl does not denature taste receptor proteins — the effect is about signal transduction, not protein damage. D) Citric acid does not significantly activate umami receptors, and cross-modal taste enhancement between sour and umami is not supported by this experimental finding.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A researcher studies nociception by recording from dorsal horn neurons while applying different stimuli to a participant''s forearm. She finds that gentle brushing of the skin around a small burn area produces pain. This phenomenon is called:',
  '[{"label": "A", "text": "Phantom pain — central nervous system generates pain without peripheral input"},
    {"label": "B", "text": "Referred pain — visceral signals are mislocalized to the forearm"},
    {"label": "C", "text": "Allodynia — normally non-painful stimuli produce pain due to central sensitization"},
    {"label": "D", "text": "Analgesia — descending pain inhibition pathways are activated by the brush stimulus"}]',
  'C',
  'Allodynia is pain from a stimulus that does not normally provoke pain (like gentle brushing). It occurs through central sensitization — after tissue injury (the burn), dorsal horn neurons become hyperexcitable, so even low-threshold mechanoreceptor input (A-beta fibers from brushing) is interpreted as painful. A) Phantom pain occurs after deafferentation (e.g., amputation), not from stimulation near a burn. B) Referred pain involves mislocalization of visceral pain — this is cutaneous stimulation near an injury site. D) Analgesia is pain reduction — the opposite of what is described; the patient is experiencing increased pain.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A patient with anosmia (loss of smell) following head trauma most likely sustained damage to which structure?',
  '[{"label": "A", "text": "Olfactory receptor neuron axons passing through the cribriform plate"},
    {"label": "B", "text": "Cochlear branch of cranial nerve VIII"},
    {"label": "C", "text": "Taste buds on the circumvallate papillae"},
    {"label": "D", "text": "Somatosensory fibers in the trigeminal nerve"}]',
  'A',
  'Post-traumatic anosmia most commonly results from shearing of the delicate olfactory receptor neuron axons as they pass through the cribriform plate of the ethmoid bone. Head trauma can fracture or shift the cribriform plate, severing these fine unmyelinated axons. A) This is the most common mechanism. B) CN VIII carries auditory and vestibular information, not olfactory. C) Taste buds mediate gustation, not olfaction; damage would affect taste, not smell. D) The trigeminal nerve carries somatosensory information from the face (and some chemical irritant detection in the nose), but its damage would not cause anosmia.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'In a study of somatosensory processing, a patient with a lesion in the postcentral gyrus of the right hemisphere would most likely show impaired:',
  '[{"label": "A", "text": "Touch and pressure sensation on the right side of the body"},
    {"label": "B", "text": "Touch and pressure sensation on the left side of the body"},
    {"label": "C", "text": "Motor control of the left hand"},
    {"label": "D", "text": "Visual processing of objects in the left visual field"}]',
  'B',
  'The postcentral gyrus houses the primary somatosensory cortex (S1). Somatosensory pathways cross (decussate), so the right hemisphere processes touch from the left side of the body. A lesion in the right postcentral gyrus impairs left-sided sensation. A) Right body sensation is processed by the left hemisphere, not the right. C) Motor control originates from the precentral gyrus (primary motor cortex), not the postcentral gyrus. D) Visual processing occurs in the occipital lobe, not the postcentral gyrus of the parietal lobe.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A researcher investigates how the body detects skin stretch during joint movement. She identifies receptors in the dermis that are slowly adapting, have large receptive fields, and respond to sustained lateral skin stretch. These receptors are most likely:',
  '[{"label": "A", "text": "Pacinian corpuscles"},
    {"label": "B", "text": "Meissner corpuscles"},
    {"label": "C", "text": "Ruffini endings"},
    {"label": "D", "text": "Merkel cells"}]',
  'C',
  'Ruffini endings are slowly adapting mechanoreceptors with large receptive fields located deep in the dermis. They respond best to sustained skin stretch, making them important for detecting finger position and joint movement. A) Pacinian corpuscles are rapidly adapting with large receptive fields — they detect vibration and deep pressure changes, not sustained stretch. B) Meissner corpuscles are rapidly adapting with small receptive fields — they detect light touch and low-frequency vibration, not sustained stretch. D) Merkel cells are slowly adapting with small receptive fields — they detect sustained pressure and fine texture, not skin stretch.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'During a wine tasting, a sommelier detects subtle differences between two Pinot Noir wines. She notes that one has a "barnyard" aroma and the other has a "cherry" aroma. Which characteristic of the olfactory system best explains the ability to make such fine discriminations?',
  '[{"label": "A", "text": "Each olfactory receptor neuron expresses all 400 receptor types, allowing complete analysis by single cells"},
    {"label": "B", "text": "Combinatorial receptor coding — each odorant activates a unique pattern across ~400 receptor types"},
    {"label": "C", "text": "The olfactory system uses labeled-line coding, with one receptor type per odorant molecule"},
    {"label": "D", "text": "Olfactory discrimination depends entirely on concentration differences rather than receptor patterns"}]',
  'B',
  'The olfactory system uses combinatorial coding: each of the ~400 olfactory receptor types responds to multiple odorants, and each odorant activates a unique combination of receptors. This allows discrimination of thousands of distinct odors. A) Each olfactory receptor neuron expresses only ONE receptor type (the one-receptor-one-neuron rule), not all 400. C) Labeled-line coding (one receptor = one stimulus) would limit discrimination to only ~400 odors; the combinatorial code vastly exceeds this. D) Concentration affects intensity perception but does not explain qualitative discrimination between different odorants like "barnyard" vs. "cherry."',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'A child touches a hot pan and screams. Her mother immediately rubs the child''s arm near the burn and the child reports that the pain decreases. According to the gate theory of pain, the rubbing reduces pain because:',
  '[{"label": "A", "text": "Rubbing activates C fibers that release endorphins in the spinal cord"},
    {"label": "B", "text": "Rubbing activates large-diameter A-beta fibers that stimulate inhibitory interneurons in the dorsal horn"},
    {"label": "C", "text": "Rubbing causes sensory adaptation of nociceptors at the burn site"},
    {"label": "D", "text": "Rubbing generates descending signals from the motor cortex that suppress pain signals"}]',
  'B',
  'Gate theory (Melzack & Wall) proposes that activation of large-diameter A-beta fibers (which carry touch/pressure) stimulates inhibitory interneurons in the substantia gelatinosa of the dorsal horn. These interneurons "close the gate" by inhibiting transmission of pain signals from small-diameter C fibers to ascending projection neurons. A) C fibers carry pain signals and would open the gate; rubbing activates A-beta fibers, not C fibers. Endorphins are part of descending modulation, not gate theory per se. C) Sensory adaptation of nociceptors takes much longer and would not explain immediate relief from rubbing a nearby area. D) While descending modulation exists, gate theory specifically describes a spinal cord mechanism involving peripheral fiber competition, not motor cortex output.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Other Senses',
  'An olfactory researcher finds that a patient can detect odors but cannot identify or name them, despite having intact language abilities. The lesion is most likely located in the:',
  '[{"label": "A", "text": "Olfactory bulb"},
    {"label": "B", "text": "Orbitofrontal cortex"},
    {"label": "C", "text": "Piriform cortex"},
    {"label": "D", "text": "Cribriform plate"}]',
  'B',
  'The orbitofrontal cortex is crucial for conscious odor identification and assigning meaning to smells. A lesion here impairs the ability to identify/name odors while leaving basic detection intact (which depends on earlier processing stages). A) An olfactory bulb lesion would impair odor detection itself, not just identification. C) The piriform cortex (primary olfactory cortex) is involved in basic odor processing and some recognition — damage here would likely impair detection as well as identification. D) The cribriform plate is a bone structure through which olfactory nerve fibers pass — damage here would impair odor detection, not higher-level identification.',
  'hard'
);

-- ============================================================
-- OBJECT RECOGNITION & PERCEPTION (Questions 26–50)
-- ============================================================

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A radiologist examines a chest X-ray and immediately notices a small lung nodule that a medical student missed despite studying the same image for several minutes. The radiologist''s superior detection is best explained by:',
  '[{"label": "A", "text": "Bottom-up processing — the radiologist has better visual acuity"},
    {"label": "B", "text": "Top-down processing — prior knowledge and experience guide attention to diagnostically relevant features"},
    {"label": "C", "text": "The radiologist has a lower absolute threshold for light detection"},
    {"label": "D", "text": "Change blindness — the student could not detect changes between sequential X-rays"}]',
  'B',
  'Top-down processing uses prior knowledge, expectations, and experience to guide perception. The radiologist''s years of training create perceptual expertise that directs attention to subtle findings. A) Bottom-up processing is data-driven, starting from raw sensory features — visual acuity differences do not explain expertise-based pattern recognition. C) Absolute threshold for light detection is similar in healthy adults and does not explain diagnostic expertise. D) Change blindness involves failure to detect changes between sequential scenes — this task involves detection within a single static image.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A graphic designer arranges a series of dots on a poster. Some dots are red and some are blue, but dots of the same color are placed near each other in clusters. Viewers consistently perceive the dots as forming colored groups rather than individual scattered elements. This grouping is best explained by the Gestalt principle of:',
  '[{"label": "A", "text": "Continuity — viewers perceive the dots as following smooth paths"},
    {"label": "B", "text": "Closure — viewers mentally complete gaps between dots to form shapes"},
    {"label": "C", "text": "Proximity combined with similarity — nearby dots of the same color are grouped together"},
    {"label": "D", "text": "Pragnanz — viewers simplify the arrangement into the most basic form possible"}]',
  'C',
  'Two Gestalt principles operate here: proximity (elements close together are grouped) and similarity (elements sharing features like color are grouped). When both operate together, as in this scenario, grouping is especially strong. A) Continuity involves perceiving elements as following smooth, continuous paths — dots arranged in clusters do not necessarily follow paths. B) Closure involves mentally filling in gaps to perceive complete shapes — the dots already form visible groups without gap-filling. D) Pragnanz (law of simplicity) states we perceive the simplest organization, but the specific grouping mechanism here is proximity + similarity.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A participant in an attention experiment is asked to count the number of passes made by a basketball team wearing white shirts. During the task, a person in a gorilla suit walks through the scene, but the participant fails to notice. This failure of awareness is an example of:',
  '[{"label": "A", "text": "Change blindness — the gorilla was present in some frames but absent in others"},
    {"label": "B", "text": "Inattentional blindness — focused attention on the counting task prevented awareness of an unexpected stimulus"},
    {"label": "C", "text": "Selective attention failure — the participant''s attentional filter was set too broadly"},
    {"label": "D", "text": "Signal detection error — the gorilla was below the participant''s absolute threshold"}]',
  'B',
  'This describes the famous Simons & Chabris (1999) gorilla experiment, which demonstrates inattentional blindness — failure to perceive an unexpected stimulus when attention is focused on another task. The gorilla is clearly visible but goes unnoticed because attentional resources are devoted to counting. A) Change blindness involves failure to detect changes between alternating scenes; the gorilla was continuously present, not changing between views. C) Selective attention was actually working successfully (the participant was filtering for white-shirt passes) — it was too narrow, not too broad. D) The gorilla was clearly suprathreshold — a fully visible person in a gorilla suit; the issue is attention, not sensory threshold.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A researcher shows participants two alternating photos of a street scene. In one photo, a fire hydrant is present; in the other, it has been digitally removed. A brief blank screen separates each photo. Many participants fail to detect the disappearance. This phenomenon is:',
  '[{"label": "A", "text": "Inattentional blindness — participants are focused on other aspects of the scene"},
    {"label": "B", "text": "Change blindness — the transient disruption prevents detection of the change"},
    {"label": "C", "text": "Perceptual set — participants expect the scene to remain constant"},
    {"label": "D", "text": "Feature detection failure — the fire hydrant lacks distinctive low-level visual features"}]',
  'B',
  'Change blindness is the failure to detect changes between two scenes when there is a brief visual disruption (blank screen, saccade, or flicker) between them. The disruption eliminates the transient motion signal that would normally draw attention to the change. A) Inattentional blindness involves failure to see an unexpected stimulus during focused attention — here participants are actively looking at the scenes, not focused on a competing task. C) Perceptual set involves expectations influencing perception, but the mechanism here is the disruption eliminating change signals, not expectation. D) A fire hydrant has distinctive features — the issue is that change detection requires a transient signal that is masked by the blank screen.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A psychologist shows participants an ambiguous image that can be perceived as either a duck or a rabbit. She finds that participants tested near Easter are more likely to see a rabbit first. This effect of context on perception demonstrates:',
  '[{"label": "A", "text": "Bottom-up processing — the physical features of the image change near Easter"},
    {"label": "B", "text": "Perceptual set — expectations and context bias which interpretation is perceived first"},
    {"label": "C", "text": "Gestalt closure — the brain completes the image differently based on season"},
    {"label": "D", "text": "Signal detection theory — Easter shifts the response criterion for detecting rabbit features"}]',
  'B',
  'Perceptual set is a predisposition to perceive stimuli in a particular way based on expectations, context, culture, and recent experience. The Easter context primes rabbit-related concepts, biasing initial interpretation of the ambiguous figure. A) Bottom-up processing is data-driven from physical features — the image is identical regardless of season. C) Gestalt closure involves completing incomplete figures; the duck-rabbit image is complete, and the issue is interpretation, not completion. D) While signal detection concepts could theoretically apply, perceptual set is the more specific and appropriate concept for context-dependent perceptual interpretation of ambiguous stimuli.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A neuroscientist studying visual processing finds that certain neurons in the primary visual cortex respond selectively to bars of light at specific orientations. These neurons were first described by Hubel and Wiesel and are called:',
  '[{"label": "A", "text": "Ganglion cells — they respond to oriented stimuli in the retina"},
    {"label": "B", "text": "Feature detectors — simple and complex cells that respond to specific visual features like edges and orientations"},
    {"label": "C", "text": "Mirror neurons — they respond when the organism observes specific visual patterns"},
    {"label": "D", "text": "Place cells — they respond to specific spatial locations in the visual field"}]',
  'B',
  'Hubel and Wiesel discovered feature detectors in the primary visual cortex (V1): simple cells respond to bars of light at specific orientations in specific retinal locations, and complex cells respond to oriented bars regardless of exact position. A) Retinal ganglion cells have center-surround receptive fields responding to spots of light, not oriented bars — they are in the retina, not cortex. C) Mirror neurons fire during action observation and execution, found in premotor/parietal cortex, not V1 orientation processing. D) Place cells are in the hippocampus and encode spatial location of the organism, not visual features.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A cognitive psychologist studies how the brain simultaneously processes color, shape, motion, and depth of a visual scene. She argues that these features are analyzed concurrently in separate cortical areas before being integrated. This model is known as:',
  '[{"label": "A", "text": "Serial processing — each feature is analyzed sequentially in V1"},
    {"label": "B", "text": "Parallel processing — multiple visual features are processed simultaneously in specialized cortical areas"},
    {"label": "C", "text": "Bottom-up processing — features are analyzed starting from the most basic to the most complex"},
    {"label": "D", "text": "Convergent processing — all features are analyzed in a single cortical region simultaneously"}]',
  'B',
  'Parallel processing describes the simultaneous analysis of multiple visual features (color in V4, motion in V5/MT, form in the ventral stream, depth in multiple areas) in separate specialized cortical areas. This allows rapid, efficient scene analysis. A) Serial processing would mean features are analyzed one at a time in sequence — this is too slow to explain the speed of visual perception. C) Bottom-up processing describes the direction of information flow (from simple to complex), not the simultaneous nature of feature analysis. D) The features are processed in distributed specialized areas, not a single region — that would be convergent processing, which is not how the visual system works.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A patient with damage to the ventral visual stream (temporal lobe) can reach for and grasp objects accurately but cannot identify what those objects are. This dissociation supports:',
  '[{"label": "A", "text": "The distinction between the ''what'' pathway (ventral) and the ''where/how'' pathway (dorsal)"},
    {"label": "B", "text": "Bottom-up processing being more important than top-down processing"},
    {"label": "C", "text": "Gestalt principles being localized exclusively in the temporal lobe"},
    {"label": "D", "text": "Feature detection occurring after object recognition in the processing hierarchy"}]',
  'A',
  'This describes visual agnosia — inability to identify objects despite intact vision and motor ability. It supports the two-stream model: the ventral stream (''what'' pathway, through temporal lobe) processes object identity, while the dorsal stream (''where/how'' pathway, through parietal lobe) processes spatial location and guides action. B) This finding is about anatomical specialization, not the direction of information processing. C) Gestalt principles are organizational rules that operate across multiple brain areas, not localized to one lobe. D) Feature detection occurs in V1 before object recognition — the patient''s deficit is in later stages of the ventral stream, not in the processing order.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A person views a series of still images in rapid succession, each showing a ball in a slightly different position. The person perceives the ball as moving smoothly across the screen. This perceptual phenomenon is called:',
  '[{"label": "A", "text": "Phi phenomenon — apparent motion perceived from sequential static images"},
    {"label": "B", "text": "Change blindness — the viewer fails to detect changes between static frames"},
    {"label": "C", "text": "Size constancy — the ball appears the same size despite distance changes"},
    {"label": "D", "text": "Stroboscopic motion — apparent motion from rapid alternation of static images showing an object in different positions"}]',
  'D',
  'Stroboscopic motion is the perception of smooth movement when static images of an object in progressively different positions are shown in rapid succession — this is the basis of film and animation. A) Phi phenomenon is a related but distinct effect: it is the perception of apparent motion from two stationary lights flashing alternately, without an object appearing to move through space. Stroboscopic motion specifically involves images of an object in different positions. B) Change blindness is failure to detect changes between scenes, not perception of motion. C) Size constancy is perceiving consistent object size despite retinal image changes — unrelated to motion perception.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A patient with damage to the right parietal lobe neglects the left side of space — she does not eat food on the left side of her plate, draws only the right half of a clock, and bumps into objects on her left. This condition implicates the parietal lobe''s role in:',
  '[{"label": "A", "text": "Object recognition and identification"},
    {"label": "B", "text": "Spatial attention and awareness"},
    {"label": "C", "text": "Primary visual processing of the left visual field"},
    {"label": "D", "text": "Motor planning for left-sided movements"}]',
  'B',
  'Hemispatial neglect (or contralateral neglect) from right parietal damage demonstrates the parietal lobe''s critical role in spatial attention and awareness. The patient is not blind but lacks awareness of the left side of space. A) Object recognition depends on the ventral stream/temporal lobe — this patient''s deficit is spatial awareness, not identification. C) Primary visual processing occurs in the occipital lobe (V1), not the parietal lobe; also, the patient''s deficit is attentional, not visual. D) Motor planning involves the frontal lobe (premotor and supplementary motor areas); neglect is an attentional/perceptual deficit, not a motor one.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A researcher presents participants with an incomplete circle that is missing a small segment. Participants overwhelmingly report seeing a complete circle. This tendency is explained by the Gestalt principle of:',
  '[{"label": "A", "text": "Proximity — the endpoints of the arc are close together"},
    {"label": "B", "text": "Similarity — all parts of the arc share the same curvature"},
    {"label": "C", "text": "Closure — the brain fills in missing information to perceive complete forms"},
    {"label": "D", "text": "Continuity — the brain perceives the arc as following a smooth path"}]',
  'C',
  'The Gestalt principle of closure states that the brain tends to fill in gaps in incomplete figures to perceive them as complete, whole forms. An incomplete circle is perceived as a full circle because the brain closes the gap. A) Proximity groups nearby elements together but does not explain filling in gaps within a single figure. B) Similarity groups elements with shared features but does not explain gap-filling in an incomplete figure. D) Continuity describes the tendency to perceive smooth, continuous patterns rather than abrupt changes — while related, the specific act of filling in a missing segment to complete a form is closure.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A student is reading a paragraph where several letters in words are replaced with numbers (e.g., "r3ading" for "reading"). Despite the substitutions, she can read the paragraph fluently. Her ability to read despite the errors best illustrates:',
  '[{"label": "A", "text": "Bottom-up processing — the visual features of numbers sufficiently match those of letters"},
    {"label": "B", "text": "Top-down processing — context and expectations allow the brain to infer the correct words"},
    {"label": "C", "text": "Feature detection — visual cortex neurons respond identically to letters and their number substitutes"},
    {"label": "D", "text": "Perceptual adaptation — repeated exposure to number-letter substitutions trains new neural pathways"}]',
  'B',
  'Top-down processing uses prior knowledge, context, and expectations to interpret sensory input. The reader uses word context, sentence meaning, and spelling patterns to infer the correct words despite degraded input. A) Bottom-up processing relies on actual physical features — numbers like "3" are visually different from "e," so bottom-up processing alone would not yield correct letter identification. C) Feature detection neurons in V1 respond to basic features like edges and orientations — they would not treat "3" and "e" identically. D) This reading ability occurs on first exposure without training; it does not require perceptual adaptation.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A driver approaches a curve in the road and perceives the road as continuing smoothly beyond the point she can see, rather than ending abruptly. This perception demonstrates the Gestalt principle of:',
  '[{"label": "A", "text": "Closure — the brain completes the road by filling in the unseen portion"},
    {"label": "B", "text": "Continuity — the brain perceives the road as following a smooth, continuous path"},
    {"label": "C", "text": "Similarity — all portions of the road share the same color and texture"},
    {"label": "D", "text": "Figure-ground — the road is perceived as the figure against the landscape background"}]',
  'B',
  'The Gestalt principle of continuity (also called good continuation) states that we tend to perceive elements as following smooth, continuous paths rather than making abrupt directional changes. The driver perceives the road as continuing along its curved trajectory. A) Closure involves filling in gaps in incomplete figures to see complete forms — the road is not an incomplete shape but a path that continues beyond the line of sight. C) Similarity groups elements with shared features but does not explain the expectation that the road continues. D) Figure-ground segregation separates objects from background — this is occurring but does not explain the specific perception of continuation.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A friend walks away from you across a large field. Although the image of your friend on your retina shrinks progressively, you do not perceive her as actually getting smaller. This perceptual stability is an example of:',
  '[{"label": "A", "text": "Shape constancy — the perceived shape remains stable despite retinal image changes"},
    {"label": "B", "text": "Size constancy — the perceived size remains stable despite changes in retinal image size"},
    {"label": "C", "text": "Color constancy — perceived color remains stable despite changes in illumination"},
    {"label": "D", "text": "Brightness constancy — perceived brightness remains stable despite luminance changes"}]',
  'B',
  'Size constancy is the ability to perceive an object as maintaining its actual size despite changes in the size of its retinal image as distance changes. The brain integrates distance cues with retinal image size to compute actual size. A) Shape constancy refers to perceiving consistent shape despite viewpoint changes (e.g., a door appears rectangular even when viewed at an angle) — not relevant to size changes with distance. C) Color constancy maintains stable color perception under different lighting conditions — unrelated to size/distance changes. D) Brightness constancy maintains stable brightness perception despite changes in illumination — also unrelated to this scenario.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A cognitive neuroscientist studies a patient who sustained occipital lobe damage. The patient is unable to consciously perceive visual stimuli but can still reach accurately toward objects placed in his "blind" field. This dissociation is known as:',
  '[{"label": "A", "text": "Visual agnosia — inability to recognize objects despite intact basic vision"},
    {"label": "B", "text": "Blindsight — the ability to respond to visual stimuli without conscious awareness"},
    {"label": "C", "text": "Hemispatial neglect — failure to attend to one side of visual space"},
    {"label": "D", "text": "Prosopagnosia — selective inability to recognize faces"}]',
  'B',
  'Blindsight occurs after damage to the primary visual cortex (V1 in the occipital lobe). Patients lack conscious visual experience in the affected field but can still make accurate visually guided responses, likely through subcortical pathways (e.g., superior colliculus to dorsal stream). A) Visual agnosia involves inability to recognize/identify objects despite being able to see them — the patient here cannot consciously see at all. C) Hemispatial neglect is an attentional deficit from parietal damage, not a loss of visual processing. D) Prosopagnosia is selective face recognition impairment, typically from fusiform gyrus damage — not loss of all visual awareness.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A cognitive psychologist designs an experiment where participants must identify a target letter in a display. When the target is surrounded by similar distractor letters, reaction time increases significantly compared to when distractors are dissimilar. This result is best explained by:',
  '[{"label": "A", "text": "Change blindness — similar distractors create change detection difficulties"},
    {"label": "B", "text": "Feature detection theory — similar items share features, making the target harder to distinguish"},
    {"label": "C", "text": "Inattentional blindness — focused attention causes participants to miss the target"},
    {"label": "D", "text": "Perceptual set — participants expect the target to look different from distractors"}]',
  'B',
  'When distractors share features with the target, visual search becomes more effortful because the target cannot "pop out" based on a single unique feature. This requires serial, item-by-item search rather than parallel processing, increasing reaction time. A) Change blindness involves failure to detect changes between alternating displays, not difficulty with visual search in a single display. C) Inattentional blindness involves missing unexpected stimuli during focused attention — participants are actively searching for the target, not focused on something else. D) Perceptual set involves context-driven expectations biasing interpretation — the increase in reaction time is better explained by feature-level similarity interfering with visual search.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'An architect designs a building with converging parallel lines on the facade to create an illusion of greater depth. A perceptual psychologist notes that this technique exploits the same depth cue that makes railroad tracks appear to converge in the distance. The relevant monocular depth cue is:',
  '[{"label": "A", "text": "Interposition — closer objects overlap more distant ones"},
    {"label": "B", "text": "Linear perspective — parallel lines appear to converge with increasing distance"},
    {"label": "C", "text": "Binocular disparity — each eye receives a slightly different image"},
    {"label": "D", "text": "Texture gradient — surface texture becomes finer with distance"}]',
  'B',
  'Linear perspective is a monocular depth cue in which parallel lines appear to converge as they recede into the distance (like railroad tracks). Architects exploit this cue to create illusory depth on flat surfaces. A) Interposition (occlusion) occurs when one object partially blocks another — not relevant to converging lines. C) Binocular disparity is a binocular cue requiring two eyes; the question specifies a monocular depth cue on a flat facade. D) Texture gradient involves texture becoming finer/denser with distance — related but distinct from the convergence of parallel lines.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A researcher studies selective attention using a dichotic listening task. Participants attend to a message in one ear while ignoring a message in the other ear. After the task, participants can report the attended message but recall almost nothing about the unattended message''s meaning — though they can report its physical characteristics (e.g., whether it was male or female voice). This finding supports:',
  '[{"label": "A", "text": "Late selection theory — all information is fully processed semantically before selection"},
    {"label": "B", "text": "Early selection theory — unattended information is filtered at a sensory level before semantic processing"},
    {"label": "C", "text": "Perceptual load theory — attentional capacity determines how much unattended information is processed"},
    {"label": "D", "text": "Feature integration theory — attention is needed to bind features of unattended stimuli"}]',
  'B',
  'Broadbent''s early selection (filter) theory proposes that attention acts as a filter early in processing, allowing only physical characteristics of unattended stimuli through while blocking semantic content. This matches the finding that participants can report physical features but not meaning of the unattended message. A) Late selection theory predicts that unattended message meaning should be processed — this is contradicted by the finding. C) Perceptual load theory could explain the results but is a more recent, integrative framework; the classic finding described here was specifically used to support early selection. D) Feature integration theory is about binding features to perceive objects — it does not specifically address dichotic listening or selective attention filtering.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A neuroimaging study reveals that a patient has damage specifically to the association cortex in the temporal lobe. Which cognitive ability would be most impaired?',
  '[{"label": "A", "text": "Basic detection of auditory tones and sound frequencies"},
    {"label": "B", "text": "Higher-order integration of auditory information, such as understanding speech and recognizing objects by sound"},
    {"label": "C", "text": "Voluntary motor planning for reaching movements"},
    {"label": "D", "text": "Detection of visual stimuli in the contralateral visual field"}]',
  'B',
  'The temporal lobe association cortex surrounds the primary auditory cortex and performs higher-order processing: integrating auditory features into meaningful percepts like speech comprehension and sound-based object recognition. A) Basic detection of tones occurs in the primary auditory cortex (Heschl''s gyrus), not the association cortex. C) Motor planning involves frontal lobe areas (premotor cortex, supplementary motor area), not temporal association cortex. D) Visual detection depends on the occipital lobe (primary visual cortex), not temporal association areas — though the temporal lobe is involved in visual object recognition via the ventral stream.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A participant looks at a pattern of black blobs on a white page and initially sees only random shapes. After being told the image contains a Dalmatian dog, she can immediately identify it and cannot "unsee" it. This irreversible perceptual reorganization best demonstrates:',
  '[{"label": "A", "text": "Bottom-up processing — the visual features reorganize themselves after extended viewing"},
    {"label": "B", "text": "Top-down processing — knowledge of what to look for fundamentally changes perception of the same stimulus"},
    {"label": "C", "text": "Sensory adaptation — prolonged viewing adapts the visual system to the blob pattern"},
    {"label": "D", "text": "Gestalt proximity — knowing about the dog causes the blobs to appear closer together"}]',
  'B',
  'This is a classic demonstration of top-down processing: once the participant has the concept of "Dalmatian dog," her prior knowledge reorganizes the perception of the same physical stimulus. The irreversibility shows how powerfully knowledge shapes perception. A) The physical features (bottom-up input) are unchanged — only the participant''s knowledge changed. B) This is correct. C) Sensory adaptation involves decreased response to constant stimulation over time — this perceptual shift was immediate upon receiving information. D) The blobs did not physically change position — proximity is not altered by knowledge; the Gestalt principle being demonstrated is more about figure-ground organization guided by top-down knowledge.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A visual perception researcher studies how the brain maintains stable object recognition despite dramatic changes in viewing angle. She shows participants a coffee mug from the front, side, and top, and finds they identify it equally quickly from all angles. This ability is most dependent on:',
  '[{"label": "A", "text": "Feature detectors in V1 that respond to orientation-specific edges"},
    {"label": "B", "text": "View-invariant object representations in the inferotemporal cortex"},
    {"label": "C", "text": "Binocular disparity providing depth information from each viewpoint"},
    {"label": "D", "text": "The Gestalt principle of pragnanz simplifying each view into the same basic form"}]',
  'B',
  'The inferotemporal (IT) cortex, at the end of the ventral (''what'') stream, contains neurons that respond to specific objects regardless of viewing angle, size, or position — view-invariant object representations. This allows recognition from novel viewpoints. A) V1 feature detectors respond to basic oriented edges and would yield very different responses from different viewing angles — they do not support view-invariant recognition. C) Binocular disparity provides depth for a given viewpoint but does not explain how different 2D views map to the same object identity. D) Pragnanz describes a preference for simple, good forms but does not explain how radically different retinal projections map to the same object identity.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'An experiment tests whether attention is needed for feature binding. Participants view brief displays of colored shapes and must report which color was associated with which shape. Under time pressure, participants frequently report seeing "illusory conjunctions" — for example, reporting a red circle when the display contained a red square and a blue circle. This finding supports:',
  '[{"label": "A", "text": "Feature integration theory — attention is required to correctly bind features like color and shape"},
    {"label": "B", "text": "Gestalt similarity — similar features are automatically grouped regardless of spatial arrangement"},
    {"label": "C", "text": "Bottom-up processing — the raw visual features are incorrectly perceived"},
    {"label": "D", "text": "Change blindness — rapid presentation prevents detection of feature changes"}]',
  'A',
  'Treisman''s feature integration theory proposes that individual features (color, shape) are processed pre-attentively in parallel, but binding them into unified objects requires focused attention. When attention is limited (time pressure), features are "free-floating" and may be incorrectly combined, producing illusory conjunctions. A) This is correct. B) Gestalt similarity groups similar elements but does not predict systematic misbinding of features between objects. C) The individual features (red, blue, circle, square) are correctly perceived — the error is in which features go together, not in feature perception itself. D) Change blindness involves failure to detect changes between sequential displays, not misbinding of features within a single display.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Object Recognition',
  'A researcher studying the Gestalt principle of pragnanz presents participants with a complex geometric figure that could be decomposed in multiple ways. Participants consistently decompose it into the simplest possible component shapes. Which statement best describes pragnanz?',
  '[{"label": "A", "text": "The brain groups elements that are close together in space"},
    {"label": "B", "text": "The brain fills in missing parts of a figure to perceive it as complete"},
    {"label": "C", "text": "The brain organizes perceptual input into the simplest, most regular interpretation possible"},
    {"label": "D", "text": "The brain follows elements along the smoothest path"}]',
  'C',
  'Pragnanz (also called the law of good figure or law of simplicity) is the overarching Gestalt principle stating that the brain organizes sensory input into the simplest, most regular, most symmetric interpretation available. It is considered the foundational principle underlying all other Gestalt laws. A) This describes proximity — grouping nearby elements. B) This describes closure — completing incomplete figures. D) This describes continuity — following smooth paths.',
  'easy'
);

-- ============================================================
-- HIGH-YIELD GAP COVERAGE (Questions 51–75)
-- ============================================================

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A psychophysics researcher finds that a participant can detect a 4-gram difference when holding a 200-gram weight. According to Weber''s law, what is the just noticeable difference (JND) when the participant holds a 600-gram weight?',
  '[{"label": "A", "text": "4 grams"},
    {"label": "B", "text": "8 grams"},
    {"label": "C", "text": "12 grams"},
    {"label": "D", "text": "24 grams"}]',
  'C',
  'Weber''s law: JND = k × I, where k is a constant ratio and I is stimulus intensity. From the initial measurement: k = 4/200 = 0.02. For 600g: JND = 0.02 × 600 = 12g. A) 4g assumes a fixed JND regardless of stimulus magnitude — this violates Weber''s law, which states JND is proportional. B) 8g implies k = 8/600 ≈ 0.013, a different proportion than 0.02. D) 24g implies k = 24/600 = 0.04, double the correct proportion.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A participant enters a dark movie theater from bright sunlight. After 30 minutes, she can see details in the dim theater that were invisible when she first entered. Which statement correctly describes the underlying mechanism of dark adaptation?',
  '[{"label": "A", "text": "Cones adapt quickly (5-7 minutes) and reach maximum sensitivity; rods adapt slowly (20-30 minutes) but achieve much greater sensitivity"},
    {"label": "B", "text": "Rods adapt within 5 minutes and are responsible for all color vision in darkness"},
    {"label": "C", "text": "Cones and rods adapt at the same rate, reaching maximum sensitivity simultaneously at 15 minutes"},
    {"label": "D", "text": "Rods adapt quickly (5 minutes) while cones take 30 minutes but provide greater sensitivity in darkness"}]',
  'A',
  'During dark adaptation, cones adapt quickly (5-7 min) but plateau at relatively low sensitivity. Rods adapt much more slowly (20-30 min) but ultimately achieve far greater sensitivity, becoming the dominant photoreceptors in dim light. This produces the characteristic two-phase dark adaptation curve. A) Correct. B) Rods take 20-30 minutes, not 5, and rods do not provide color vision — they only detect luminance. C) Cones and rods have different adaptation rates and achieve different maximum sensitivities. D) This reverses the adaptation speeds — rods are slower, not faster.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A researcher studies color vision and presents participants with a red patch for 30 seconds, then asks them to look at a white wall. Participants report seeing a green afterimage. Which theory of color vision best explains this afterimage?',
  '[{"label": "A", "text": "Trichromatic theory — the red-sensitive cones fatigue and only green/blue cones respond to white light"},
    {"label": "B", "text": "Opponent-process theory — prolonged red stimulation fatigues the red channel, causing the green opponent channel to dominate"},
    {"label": "C", "text": "Feature detection theory — cortical neurons for red become adapted, allowing green feature detectors to respond"},
    {"label": "D", "text": "Frequency theory — the visual system shifts its frequency tuning from red to green wavelengths"}]',
  'B',
  'Opponent-process theory (Hering) proposes color is processed via opponent channels: red-green, blue-yellow, and black-white. Prolonged stimulation of the red channel fatigues it, so when viewing a neutral stimulus (white), the green opponent response dominates, producing a green afterimage. A) Trichromatic theory explains initial color coding by three cone types but does not specifically predict opponent afterimages — cone fatigue alone does not fully explain why the percept is specifically green (the opponent color). C) Feature detection applies to V1 orientation-selective neurons, not color afterimages. D) Frequency theory describes auditory pitch perception via firing rate matching, not color vision.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A male patient cannot distinguish between red and green traffic lights but has normal blue-yellow discrimination. Genetic testing reveals a deficiency in medium-wavelength (green) cone photopigment. This condition is classified as:',
  '[{"label": "A", "text": "Protanopia — absence of long-wavelength (red) cone photopigment"},
    {"label": "B", "text": "Deuteranopia — absence of medium-wavelength (green) cone photopigment"},
    {"label": "C", "text": "Tritanopia — absence of short-wavelength (blue) cone photopigment"},
    {"label": "D", "text": "Achromatopsia — complete absence of all cone function"}]',
  'B',
  'Deuteranopia is a type of red-green color blindness caused by absence of medium-wavelength (green/M) cone photopigment. It is the most common form of color blindness and is X-linked recessive, explaining its prevalence in males. A) Protanopia involves absence of long-wavelength (red/L) cones — it also causes red-green confusion but the genetic test specifies green cone deficiency. C) Tritanopia involves short-wavelength (blue/S) cone deficiency, causing blue-yellow confusion — this patient has normal blue-yellow discrimination. D) Achromatopsia involves total cone failure, producing complete color blindness and reduced acuity — this patient has selective red-green impairment.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'The Young-Helmholtz trichromatic theory proposes that color vision is based on three types of cones. A key limitation of this theory is that it cannot fully explain:',
  '[{"label": "A", "text": "Why mixing red and green light produces yellow perception"},
    {"label": "B", "text": "Why color afterimages consistently appear as the complementary color"},
    {"label": "C", "text": "Why there are three types of cone photoreceptors in the retina"},
    {"label": "D", "text": "Why spectral sensitivity differs across individuals with different cone ratios"}]',
  'B',
  'Trichromatic theory explains color mixing and initial photoreceptor coding but cannot account for why afterimages are always in complementary (opponent) colors. This requires opponent-process theory, which describes how color signals are recoded into opposing channels (red-green, blue-yellow) at post-receptoral stages. A) Trichromatic theory can explain additive color mixing — red and green cones both activated produces yellow perception. C) Trichromatic theory IS the explanation for three cone types — this is not a limitation. D) Differences in cone ratios are consistent with trichromatic theory — individual variation in cone distribution is a refinement, not a challenge.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A visual perception researcher shows participants the Muller-Lyer illusion — two horizontal lines of equal length, one with outward-pointing arrows and one with inward-pointing arrows. Participants consistently judge the line with outward-pointing arrows as longer. Which explanation is most widely accepted?',
  '[{"label": "A", "text": "The outward arrows increase the retinal image size of the line"},
    {"label": "B", "text": "Misapplied size constancy — the brain interprets the arrow configurations as depth cues and adjusts perceived length"},
    {"label": "C", "text": "Gestalt continuity — the outward arrows extend the perceived path of the line"},
    {"label": "D", "text": "Selective attention — participants fixate longer on the outward-arrow line"}]',
  'B',
  'The most widely accepted explanation is Gregory''s misapplied constancy theory: outward arrows resemble the inside corners of a room (which appears farther away), triggering size constancy scaling that makes the line appear longer. Inward arrows resemble an outside building corner (closer), so size constancy makes that line appear shorter. A) Both lines produce the same retinal image length — the arrows do not change the line''s actual projection. C) Continuity describes following smooth paths, not length distortion from arrow configurations. D) Eye-tracking studies show that fixation differences do not account for the robust and consistent magnitude of the illusion.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'The Ponzo illusion shows two identical horizontal lines placed between converging lines (like railroad tracks). The upper line appears longer. Which depth cue is being exploited by this illusion?',
  '[{"label": "A", "text": "Binocular disparity — each eye views the converging lines differently"},
    {"label": "B", "text": "Linear perspective — converging lines signal increasing distance, and size constancy makes the ''farther'' line appear larger"},
    {"label": "C", "text": "Interposition — the upper line overlaps the converging lines more"},
    {"label": "D", "text": "Motion parallax — the upper line appears to move more slowly, signaling greater distance"}]',
  'B',
  'The Ponzo illusion exploits linear perspective: converging lines (like railroad tracks) cue increasing distance. The upper line, appearing "farther" in this depth context, triggers size constancy scaling — the brain enlarges its perceived size to compensate for apparent distance, making it look longer than the identical lower line. A) Binocular disparity requires two eyes viewing a 3D scene — the Ponzo illusion works perfectly on flat 2D images with one eye. C) Interposition involves one object partially blocking another — neither line overlaps the converging lines more. D) Motion parallax requires observer movement — this illusion occurs in static images.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'An Ames room is designed so that one corner is much farther from the viewer than the other, but the room appears rectangular through a peephole. A person standing in the far corner appears tiny while a person in the near corner appears giant. The illusion works because:',
  '[{"label": "A", "text": "The room eliminates all monocular depth cues, forcing the brain to rely on incorrect assumptions about room shape"},
    {"label": "B", "text": "The trapezoidal room shape and monocular viewing eliminate depth cues that would reveal true distances, so the brain assumes the room is rectangular and misattributes size differences to actual size differences"},
    {"label": "C", "text": "Binocular disparity confirms the room is rectangular, overriding conflicting size information"},
    {"label": "D", "text": "The room activates the dorsal stream pathway, which processes spatial information inaccurately"}]',
  'B',
  'The Ames room is constructed as a trapezoid but viewed through a peephole (monocular viewing), eliminating binocular depth cues. The room is carefully designed so its retinal image matches a rectangular room, exploiting the brain''s strong assumption that rooms are rectangular. When people at different distances produce different retinal image sizes, the brain (assuming equal distance) attributes the difference to actual body size. A) The room carefully preserves certain monocular cues that support the rectangular interpretation — it does not eliminate all cues. C) Binocular disparity would actually break the illusion by revealing the true room shape — the peephole prevents binocular viewing. D) The dorsal stream accurately processes available spatial information; the illusion arises from deliberate elimination of depth information, not stream dysfunction.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'At a crowded party, a person is engaged in conversation but suddenly turns her head when she hears her name spoken by someone across the room. This phenomenon is called:',
  '[{"label": "A", "text": "Inattentional blindness — she was blind to other stimuli until her name was spoken"},
    {"label": "B", "text": "The cocktail party effect — the ability to detect personally relevant information in unattended auditory channels"},
    {"label": "C", "text": "Change blindness — her name created a detectable change in the auditory environment"},
    {"label": "D", "text": "Sensory adaptation — adaptation to party noise makes her name stand out as a novel stimulus"}]',
  'B',
  'The cocktail party effect describes the ability to selectively attend to one conversation while monitoring unattended channels for personally relevant information (like one''s name). This suggests some semantic processing of unattended stimuli occurs, consistent with late-selection models of attention. A) Inattentional blindness is a visual phenomenon where unexpected stimuli are missed during focused attention — this is an auditory phenomenon. C) Change blindness involves failure to detect visual changes between scenes; the party noise is continuous, not alternating. D) Sensory adaptation involves decreased response to constant stimulation; the name is a novel stimulus, but the phenomenon is about attentional selection, not adaptation.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A researcher shows participants a video of a person saying "ga" while the audio plays "ba." Participants report hearing "da" — a percept that matches neither the visual nor auditory input alone. This is an example of:',
  '[{"label": "A", "text": "Inattentional blindness — participants fail to perceive the correct visual input"},
    {"label": "B", "text": "The McGurk effect — multisensory integration produces a percept different from either unimodal input"},
    {"label": "C", "text": "Selective attention — participants choose to attend to the visual input over the auditory"},
    {"label": "D", "text": "Perceptual set — prior expectations about speech override the actual sensory input"}]',
  'B',
  'The McGurk effect demonstrates that speech perception involves multisensory integration. When visual (lip movements for "ga") and auditory ("ba") information conflict, the brain fuses them into a compromise percept ("da") that differs from both inputs. This shows vision and hearing interact during speech perception. A) Both inputs are perceived — the brain integrates them rather than missing one. C) Participants do not selectively choose one input; the result ("da") matches neither visual ("ga") nor auditory ("ba") alone. D) Perceptual set involves expectations from context or experience — the McGurk effect occurs even with no prior expectation, as it is an automatic multisensory integration process.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A musician reports that when she hears C major, she always sees the color blue. When hearing D minor, she always sees dark green. Neuroimaging reveals cross-activation between her auditory and visual cortices. This perceptual experience is called:',
  '[{"label": "A", "text": "Synesthesia — involuntary, consistent cross-modal sensory experiences"},
    {"label": "B", "text": "Hallucination — perception of visual stimuli without appropriate external input"},
    {"label": "C", "text": "Perceptual set — musical training has created associations between sounds and colors"},
    {"label": "D", "text": "Eidetic imagery — photographic memory of previously seen colors associated with musical keys"}]',
  'A',
  'Synesthesia is a neurological condition in which stimulation of one sensory modality automatically and consistently triggers an experience in another modality. The cross-activation between auditory and visual cortices on neuroimaging supports the neural basis of genuine synesthesia. A) Correct — involuntary, consistent, and involves cross-modal sensory coupling. B) Hallucinations are perceptions without external stimuli and are typically not consistent or triggered by specific sensory inputs; synesthetic experiences are reliable and stimulus-specific. C) Perceptual set involves expectation-based interpretation — synesthesia is an automatic neurological phenomenon present from early life, not learned through training. D) Eidetic imagery is vivid visual recall of previously seen images; synesthetic color experiences are not recalled memories but automatic concurrent perceptions.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A 55-year-old construction worker presents with gradually worsening hearing loss in both ears. Audiometric testing shows reduced air conduction AND bone conduction, with no air-bone gap. Weber test lateralizes to the better ear. This pattern is most consistent with:',
  '[{"label": "A", "text": "Conductive hearing loss — sound is not efficiently transmitted through the outer/middle ear"},
    {"label": "B", "text": "Sensorineural hearing loss — damage to the cochlear hair cells or auditory nerve"},
    {"label": "C", "text": "Mixed hearing loss — combined conductive and sensorineural components"},
    {"label": "D", "text": "Central auditory processing disorder — intact peripheral hearing with impaired cortical processing"}]',
  'B',
  'Sensorineural hearing loss involves damage to the cochlea (especially outer hair cells) or auditory nerve. In sensorineural loss, both air and bone conduction are reduced equally (no air-bone gap), and the Weber test lateralizes to the better-hearing ear. Chronic noise exposure from construction work is a classic cause. A) Conductive hearing loss shows an air-bone gap: air conduction is impaired while bone conduction is relatively preserved; Weber lateralizes to the affected ear. C) Mixed hearing loss would show elements of both — some air-bone gap plus overall reduction; this patient has no air-bone gap. D) Central auditory processing disorder shows normal audiometric thresholds with impaired speech comprehension — this patient has measurably reduced conduction thresholds.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'An elderly patient with severe sensorineural hearing loss receives a cochlear implant. The device bypasses damaged hair cells by:',
  '[{"label": "A", "text": "Amplifying sound waves to stimulate remaining outer hair cells in the cochlea"},
    {"label": "B", "text": "Converting sound into electrical signals that directly stimulate the auditory nerve fibers"},
    {"label": "C", "text": "Replacing the ossicles with a mechanical transducer to improve middle ear conduction"},
    {"label": "D", "text": "Stimulating the auditory cortex directly through transcranial electrodes"}]',
  'B',
  'Cochlear implants bypass damaged or absent hair cells by converting sound waves (captured by an external microphone) into electrical signals delivered via an electrode array inserted into the cochlea. These signals directly stimulate auditory nerve fibers (spiral ganglion neurons), which transmit the signal to the brain. A) Amplifying sound is what hearing aids do; cochlear implants bypass hair cells entirely rather than trying to stimulate remaining ones. C) Replacing ossicles addresses conductive hearing loss (middle ear problem); cochlear implants address sensorineural loss (inner ear problem). D) Direct cortical stimulation (auditory brainstem implants) exists but is different from cochlear implants, which stimulate at the cochlear level.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A physical therapist assesses a patient''s proprioception by asking her to close her eyes and identify the position of her passively moved finger. The patient cannot determine finger position. Which receptors are most likely impaired?',
  '[{"label": "A", "text": "Pacinian corpuscles in the skin and Meissner corpuscles in the fingertips"},
    {"label": "B", "text": "Muscle spindles and Golgi tendon organs in the muscles and tendons"},
    {"label": "C", "text": "Free nerve endings in the joint capsule"},
    {"label": "D", "text": "Ruffini endings in the dermis only"}]',
  'B',
  'Proprioception — the sense of body/limb position — depends primarily on muscle spindles (which detect muscle length and length changes) and Golgi tendon organs (which detect muscle tension). Together, they provide the CNS with information about joint position and movement. A) Pacinian and Meissner corpuscles are cutaneous mechanoreceptors for vibration and light touch — they contribute to tactile perception, not primarily proprioception. C) Free nerve endings detect pain and temperature, not joint position. D) Ruffini endings detect skin stretch and contribute modestly to joint position sense, but muscle spindles and Golgi tendon organs are the primary proprioceptors.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A neuroscientist examines the somatosensory homunculus and notes that certain body parts have disproportionately large cortical representation. Which pair of body regions would have the LARGEST cortical representation relative to their actual body surface area?',
  '[{"label": "A", "text": "Trunk and upper arm"},
    {"label": "B", "text": "Hands and face (including lips and tongue)"},
    {"label": "C", "text": "Thighs and shoulders"},
    {"label": "D", "text": "Feet and lower back"}]',
  'B',
  'In the somatosensory homunculus, the hands and face (especially lips, tongue, and fingertips) have the largest cortical representation relative to their physical size. This reflects their high receptor density and their importance for fine tactile discrimination, manipulation, and speech. A) The trunk and upper arm have relatively small cortical representation despite large physical surface area. C) Thighs and shoulders have moderate physical size but small cortical representation. D) Feet have moderate representation (larger than trunk but smaller than hands); lower back has minimal cortical area.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A sensory psychologist defines the absolute threshold as the minimum stimulus intensity detected 50% of the time. Which of the following best represents a real-world example of the absolute threshold for vision?',
  '[{"label": "A", "text": "Reading normal-sized text on a page under standard lighting"},
    {"label": "B", "text": "Seeing a candle flame on a clear dark night from 30 miles away"},
    {"label": "C", "text": "Distinguishing between two shades of blue that differ by one wavelength"},
    {"label": "D", "text": "Detecting a 1-decibel change in ambient room lighting"}]',
  'B',
  'The absolute threshold for vision is classically described as seeing a candle flame on a clear dark night from approximately 30 miles away — an extremely faint stimulus detected 50% of the time. This represents the minimum detectable stimulus, not a difference between stimuli. A) Reading text under standard lighting is well above threshold — this represents a suprathreshold task. C) Distinguishing between two similar stimuli describes a difference threshold (JND), not the absolute threshold. D) Decibels measure sound intensity, not light; and detecting a change is a difference threshold, not an absolute threshold.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A student lifts two weights sequentially: first 500g, then a test weight. She can detect a difference when the test weight is 510g but not 505g. According to Weber''s law, what is the Weber fraction (k) for this stimulus?',
  '[{"label": "A", "text": "k = 0.01"},
    {"label": "B", "text": "k = 0.02"},
    {"label": "C", "text": "k = 0.05"},
    {"label": "D", "text": "k = 0.10"}]',
  'B',
  'Weber''s law states ΔI/I = k, where ΔI is the JND and I is the standard stimulus intensity. The JND is 510 - 500 = 10g. Therefore, k = 10/500 = 0.02. A) k = 0.01 would predict a JND of 5g (0.01 × 500), but the student could not detect a 5g difference. C) k = 0.05 would predict a JND of 25g (0.05 × 500), meaning the student would need 525g to notice a difference — this is too large. D) k = 0.10 would predict a JND of 50g (0.10 × 500), which is far too large for this context.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A patient with red-green color blindness has difficulty with a task requiring color discrimination. His ophthalmologist explains that he has normal short-wavelength (blue) cones but is missing one of the other two cone types. Which theory of color vision best explains why he specifically confuses red and green?',
  '[{"label": "A", "text": "Opponent-process theory — his red-green channel is non-functional"},
    {"label": "B", "text": "Trichromatic theory — missing one cone type (L or M) reduces the number of colors that can be discriminated in the red-green range"},
    {"label": "C", "text": "Frequency theory — his visual system cannot encode red and green at different frequencies"},
    {"label": "D", "text": "Place theory — the specific retinal location of his missing cones determines which colors are confused"}]',
  'B',
  'The trichromatic (Young-Helmholtz) theory best explains cone-level color blindness. With only two functioning cone types (S + either L or M), the visual system cannot distinguish wavelengths that differentially stimulate L vs. M cones. This is a photoreceptor-level deficit. A) Opponent-process theory operates at post-receptoral stages — the primary deficit in dichromatic color blindness is at the cone level, which is explained by trichromatic theory. The opponent channels are non-functional BECAUSE the cone input is missing. C) Frequency theory describes auditory pitch encoding, not color vision. D) Place theory also applies to auditory processing (tonotopic organization); retinal location does not determine which colors are confused in color blindness.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'During dark adaptation, a researcher measures the detection threshold for light at regular intervals. She observes a characteristic curve with two phases: an initial rapid decrease in threshold followed by a second, slower decrease. The transition point between these two phases is called the:',
  '[{"label": "A", "text": "Weber fraction — the point where the ratio of JND to stimulus changes"},
    {"label": "B", "text": "Rod-cone break — the point where rods surpass cones in sensitivity and become the primary detectors"},
    {"label": "C", "text": "Absolute threshold — the minimum detectable stimulus intensity"},
    {"label": "D", "text": "Signal detection criterion — the decision boundary for reporting light detection"}]',
  'B',
  'The rod-cone break occurs approximately 7-10 minutes into dark adaptation. Initially, cones (which adapt faster but reach a lower maximum sensitivity) dominate detection. At the rod-cone break, rod sensitivity surpasses cone sensitivity, and rods become the primary detectors, producing the second, slower phase of further threshold decrease. A) The Weber fraction is the ratio ΔI/I for difference thresholds, not a feature of dark adaptation curves. C) The absolute threshold is the final, lowest point of the dark adaptation curve, not the transition point. D) The signal detection criterion relates to response bias in detection tasks, not the photoreceptor transition in dark adaptation.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A patient reports that after staring at a bright yellow stimulus, she sees a blue afterimage. According to opponent-process theory, this occurs because:',
  '[{"label": "A", "text": "Yellow-responsive cones have fatigued, allowing blue cones to dominate"},
    {"label": "B", "text": "The yellow channel of the blue-yellow opponent pair has fatigued, causing the blue channel to produce an unopposed signal"},
    {"label": "C", "text": "The brain generates blue to maintain color constancy in changing illumination"},
    {"label": "D", "text": "Short-wavelength cone photopigment regenerates faster than medium and long-wavelength photopigments"}]',
  'B',
  'In opponent-process theory, colors are processed in opponent pairs: red-green, blue-yellow, and black-white. Prolonged stimulation of one end (yellow) fatigues that channel. When viewing a neutral stimulus, the opponent (blue) channel produces a signal without opposition, creating a blue afterimage. A) There are no "yellow-responsive cones" per se — yellow is encoded by simultaneous activation of L and M cones, not by a dedicated yellow cone. This explanation invokes trichromatic theory inadequately. C) Color constancy maintains stable color perception under different lighting but does not explain afterimages from fatiguing stimulation. D) Photopigment regeneration rates do not explain the specific opponent color relationships seen in afterimages.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A patient with damage to the middle ear ossicles (incus) presents with hearing loss. Audiometric testing would most likely show:',
  '[{"label": "A", "text": "Reduced air conduction with preserved bone conduction (air-bone gap), Weber test lateralizing to the affected ear"},
    {"label": "B", "text": "Reduced air conduction and bone conduction equally, Weber test lateralizing to the better ear"},
    {"label": "C", "text": "Normal air conduction with reduced bone conduction"},
    {"label": "D", "text": "Normal thresholds on audiometry with impaired speech discrimination"}]',
  'A',
  'Ossicular damage causes conductive hearing loss: sound cannot efficiently reach the cochlea via the air-conduction pathway (through the ossicles), but the cochlea itself is intact. Bone conduction bypasses the middle ear, so it remains normal — creating an air-bone gap. In the Weber test, bone-conducted sound lateralizes to the affected ear because ambient noise is reduced in that ear (masking effect). A) Correct — this is the classic conductive hearing loss pattern. B) This pattern describes sensorineural hearing loss (cochlear/nerve damage). C) Bone conduction is not selectively reduced by middle ear pathology. D) Normal thresholds with impaired speech discrimination suggests central auditory processing disorder, not middle ear damage.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A researcher measures the JND for brightness. A participant can just detect a difference when a 100-candela light increases to 102 candelas. According to Weber''s law, the participant would need what intensity to detect a difference from a 400-candela light?',
  '[{"label": "A", "text": "402 candelas"},
    {"label": "B", "text": "404 candelas"},
    {"label": "C", "text": "408 candelas"},
    {"label": "D", "text": "420 candelas"}]',
  'C',
  'Weber''s law: k = ΔI/I = 2/100 = 0.02. For a 400-candela light: ΔI = 0.02 × 400 = 8 candelas. The detectable intensity = 400 + 8 = 408 candelas. A) 402 implies ΔI = 2 (fixed JND), violating Weber''s proportional relationship. B) 404 implies ΔI = 4, giving k = 4/400 = 0.01, a different proportion. D) 420 implies ΔI = 20, giving k = 20/400 = 0.05, also incorrect.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A researcher studies proprioception in athletes. She finds that gymnasts who land from a high jump use information from muscle spindles to rapidly adjust their leg position. Muscle spindles specifically detect:',
  '[{"label": "A", "text": "Muscle tension and force production"},
    {"label": "B", "text": "Muscle length and changes in length (stretch)"},
    {"label": "C", "text": "Joint angle only, independent of muscle state"},
    {"label": "D", "text": "Skin deformation overlying the muscle"}]',
  'B',
  'Muscle spindles are proprioceptors embedded within skeletal muscles that detect muscle length and rate of change in length (velocity of stretch). They are essential for proprioception and for the stretch reflex. A) Muscle tension and force production are detected by Golgi tendon organs, located at muscle-tendon junctions — not muscle spindles. C) Joint angle is determined by integrating information from multiple sources including muscle spindles, but spindles specifically detect muscle length, not joint angle directly. D) Skin deformation is detected by cutaneous mechanoreceptors (Meissner, Pacinian, etc.), not by muscle spindles, which are intramuscular structures.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A sensory psychologist measures absolute thresholds for hearing and finds that a participant can detect a ticking watch in a quiet room from 20 feet away. This measurement is closest to which classic example of absolute threshold?',
  '[{"label": "A", "text": "The absolute threshold for taste — a teaspoon of sugar in two gallons of water"},
    {"label": "B", "text": "The absolute threshold for hearing — a watch ticking in a quiet room at 20 feet"},
    {"label": "C", "text": "The absolute threshold for touch — a bee''s wing dropping on the cheek from 1 cm"},
    {"label": "D", "text": "The absolute threshold for smell — a drop of perfume in a three-room apartment"}]',
  'B',
  'This is the classic textbook example of the absolute threshold for hearing: the ability to hear a watch ticking in an otherwise quiet room at 20 feet distance. Each option describes a different sensory modality''s absolute threshold. A) The taste example is correct for taste threshold but does not match the auditory scenario described. C) The touch example describes the touch absolute threshold — a wing drop on the cheek — not hearing. D) The smell example describes the olfactory absolute threshold — not the auditory scenario.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A cognitive psychologist studies how quickly participants detect a red "X" among green "O" distractors versus among green "X" distractors. Detection is much faster in the first condition. This difference occurs because:',
  '[{"label": "A", "text": "Color and shape differences both distinguish the target in condition one, enabling parallel ''pop-out'' search"},
    {"label": "B", "text": "The green Os are harder to perceive than green Xs, making them less distracting"},
    {"label": "C", "text": "Condition one has fewer distractors than condition two"},
    {"label": "D", "text": "The absolute threshold for detecting red is lower than for detecting the letter X"}]',
  'A',
  'When a target differs from distractors in multiple basic features (color AND shape), it "pops out" through parallel, pre-attentive processing. A red X among green Os differs in both color and shape, enabling effortless detection. A red X among green Xs differs only in color, which still enables relatively fast search, but the scenario describes that detection among green Os is MUCH faster because of the conjunctive feature advantage. A) Correct — dual feature differences enable faster pop-out. B) There is no evidence that Os are harder to perceive than Xs; perceptual difficulty of distractors is not the relevant factor. C) The question does not state different distractor numbers — the comparison is about feature similarity. D) Absolute threshold describes minimum detection, not search speed; color detection threshold is not relevant here.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A neurologist examines a patient who can hear sounds normally but cannot recognize spoken words or familiar environmental sounds (like a dog barking), despite intact language production. MRI shows bilateral damage to the auditory association cortex. This condition is called:',
  '[{"label": "A", "text": "Broca''s aphasia — impaired speech production from frontal lobe damage"},
    {"label": "B", "text": "Auditory agnosia — inability to recognize sounds despite intact hearing"},
    {"label": "C", "text": "Conductive hearing loss — impaired sound transmission through the middle ear"},
    {"label": "D", "text": "Wernicke''s aphasia — impaired language comprehension from temporal lobe damage"}]',
  'B',
  'Auditory agnosia is the inability to recognize or identify sounds despite intact hearing ability. It results from damage to auditory association cortex, which processes and integrates auditory information beyond basic detection. A) Broca''s aphasia impairs speech production, not sound recognition; this patient has intact language production. C) Conductive hearing loss is a peripheral mechanical problem — this patient hears sounds normally; the deficit is in recognition. D) Wernicke''s aphasia specifically impairs language comprehension and produces fluent but meaningless speech — this patient has a broader sound recognition deficit (including non-speech sounds) with intact production, pointing to auditory agnosia rather than Wernicke''s aphasia specifically.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A Golgi tendon organ in the quadriceps muscle is activated during a heavy squat exercise. What specific information does this receptor provide to the central nervous system?',
  '[{"label": "A", "text": "The current length of the quadriceps muscle"},
    {"label": "B", "text": "The rate of change of quadriceps muscle length"},
    {"label": "C", "text": "The tension or force being generated by the quadriceps muscle"},
    {"label": "D", "text": "The temperature of the quadriceps muscle during exercise"}]',
  'C',
  'Golgi tendon organs (GTOs) are proprioceptors located at muscle-tendon junctions that specifically detect muscle tension (force). During heavy loading (like a squat), GTOs signal the amount of force the muscle is producing, providing a protective mechanism against excessive force that could damage the muscle or tendon. A) Muscle length is detected by muscle spindles, not GTOs. B) Rate of change of muscle length (velocity of stretch) is also detected by muscle spindles (specifically the primary/Ia afferents). D) Muscle temperature is detected by thermoreceptors, not proprioceptors like GTOs.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A perception researcher hypothesizes that visual illusions like the Müller-Lyer illusion should be less effective in cultures where people live in environments without many rectangular buildings and straight-edged structures. Cross-cultural research has generally:',
  '[{"label": "A", "text": "Supported this hypothesis — people in non-carpentered environments are less susceptible to the Müller-Lyer illusion"},
    {"label": "B", "text": "Refuted this hypothesis — the illusion is equally strong across all cultures"},
    {"label": "C", "text": "Shown that the illusion only exists in Western cultures"},
    {"label": "D", "text": "Found that illusion susceptibility depends solely on genetic factors, not environmental experience"}]',
  'A',
  'The carpentered world hypothesis proposes that people in environments with many rectangular structures develop stronger depth-from-angles heuristics. Cross-cultural research (e.g., Segall, Campbell, & Herskovits) generally supports this: people from non-carpentered environments (e.g., the San people, certain rural African populations) show reduced susceptibility to the Müller-Lyer illusion. A) Correct — cultural/environmental experience modulates illusion strength. B) The illusion exists cross-culturally but varies in magnitude — it is not equally strong everywhere. C) The illusion exists in many cultures, just with varying strength — it is not exclusive to Western cultures. D) Genetic factors alone do not explain the cross-cultural variation; environmental exposure plays a significant role.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Sensation and Perception',
  'A patient with a complete spinal cord transection at T10 reports feeling the urge to urinate but has no sensation in his legs. A dermatologist performing a sensory exam finds intact sensation at the umbilicus but absent sensation below. This pattern is best explained by:',
  '[{"label": "A", "text": "The umbilicus is innervated by T10 dermatome, which is above the lesion; leg dermatomes are below the lesion"},
    {"label": "B", "text": "Visceral sensation from the bladder bypasses the spinal cord via cranial nerves"},
    {"label": "C", "text": "The somatosensory cortex reorganizes to represent the legs in the trunk region"},
    {"label": "D", "text": "Phantom sensation creates the illusion of umbilical touch"}]',
  'A',
  'A T10 spinal cord transection interrupts all sensory fibers entering the cord below T10. The umbilicus is innervated by the T10 dermatome (at or just above the lesion level), so sensation there is preserved. Leg dermatomes (L1-S5) enter below the lesion, so leg sensation is lost. Bladder urgency sensation travels via pelvic splanchnic nerves (S2-S4), which enter below T10 — the patient likely has altered, not normal, bladder sensation. A) Correct — dermatomal innervation explains the sensory level. B) Bladder afferents travel through spinal nerves, not cranial nerves; they would actually be affected by this lesion. C) Cortical reorganization takes time and would not explain immediate post-injury sensory patterns. D) Phantom sensation occurs after deafferentation but would not explain preserved real sensation at the umbilicus.',
  'hard'
);
