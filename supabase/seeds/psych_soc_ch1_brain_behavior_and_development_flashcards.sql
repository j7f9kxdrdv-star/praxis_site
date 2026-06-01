-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Brain, Behavior & Development
-- Section: psych_soc · Topic: Psych / Soc
--
-- Coverage: a brief history of neuropsychology (Gall, Flourens,
-- James, Broca, Helmholtz, Sherrington); neurons and reflex
-- arcs; the CNS / PNS distinction with the 31 spinal + 12
-- cranial nerve count and the olfactory/optic exception;
-- somatic vs autonomic nervous systems; the sympathetic
-- (fight-or-flight) vs parasympathetic (rest-and-digest)
-- antagonistic split with specific physiological effects;
-- meninges (dura mater, arachnoid mater, pia mater) and
-- cerebrospinal fluid; the hindbrain (medulla, pons,
-- cerebellum); midbrain (superior and inferior colliculi);
-- forebrain embryonic origins; brain mapping methods (lesion,
-- electrical stimulation, EEG, rCBF, CT, PET, MRI, fMRI);
-- the thalamus (sensory relay except smell) and hypothalamus
-- (lateral / ventromedial / anterior subdivisions; hypophyseal
-- portal system); pineal gland and posterior pituitary; basal
-- ganglia with Parkinson''s disease; the limbic system with all
-- four components (septal nuclei, amygdala, hippocampus,
-- anterior cingulate cortex) plus anterograde vs retrograde
-- amnesia; the cerebral cortex with its gyri/sulci, four lobes
-- and their major functional regions (Broca''s and Wernicke''s
-- areas, motor and somatosensory cortices, motor homunculus,
-- association vs projection areas); hemispheric laterality
-- (contralateral/ipsilateral, dominant vs non-dominant
-- functional split, corpus callosum); neurotransmitters
-- (agonist/antagonist concept; ACh and Alzheimer''s;
-- catecholamines dopamine/NE/Epi with Parkinson''s and
-- dopamine hypothesis of schizophrenia; serotonin; GABA,
-- glycine, glutamate; endorphins and peptide NTs); endocrine
-- system (pituitary as master gland, adrenal medulla vs
-- cortex, gonads); behavioral genetics (innate vs learned,
-- nature vs nurture, family / twin / adoption study designs,
-- concordance rates, MZ vs DZ twins); critical periods;
-- neurulation; teratogens; primitive infant reflexes (rooting,
-- Moro, Babinski, grasping); and motor and social development
-- trends (cephalocaudal, proximodistal, stranger and
-- separation anxiety, parallel play, parent → self → other).
--
-- All cards are CLOZE-format. Card content is ORIGINAL Praxist
-- Prep prose written from the underlying biopsychology and
-- developmental psychology, re-sourced from OpenStax
-- Psychology 2e references in the companion verification.md
-- file; no prose is lifted from any third-party source. Text-
-- only deck (no images bundled).
--
-- Subtopic ordering follows the AAMC content outline
-- (Foundation 6: Biological, psychological, and social
-- factors that influence behavior), NOT the source .docx''s
-- chapter ordering.
--
-- This deck is the cadence reference for subsequent Psych/Soc
-- chapters under v6 (per the prompt''s style-anchor rule for
-- new subjects).
--
-- Idempotent: re-running deletes the prior version of this
-- deck and re-seeds. User review history attached to those
-- cards (flashcard_user_state, flashcard_reviews) cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  -- Wipe any prior copy of this deck
  DELETE FROM flashcard_decks
   WHERE section = 'psych_soc'
     AND title   IN (
           'Brain, Behavior & Development',
           'Biology and Behavior',
           'Neurobiology & Behavior',
           'Chapter 1 — Brain, Behavior & Development',
           'Chapter 1 — Biology and Behavior'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'psych_soc',
    'Psych / Soc',
    'brain_behavior_and_development',
    'Brain, Behavior & Development',
    'A foundational tour of the biology of behavior: history of neuropsychology; nervous system organization (CNS/PNS, somatic/autonomic, sympathetic/parasympathetic); brain anatomy from meninges and CSF through the hindbrain, midbrain, and forebrain subdivisions; brain mapping methods; the limbic system and cerebral cortex; hemispheric laterality; neurotransmitters and their clinical correlations; endocrine system basics; behavioral genetics; and prenatal, motor, and social development.',
    1
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. History of Neuropsychology ────────────────────────
  (deck,  0, 'cloze',
   '{{c1::Franz Gall}} proposed one of the earliest theories that behavior, intellect, and personality might be linked to brain anatomy. His doctrine — {{c2::phrenology}} — argued that a well-developed trait would enlarge the corresponding brain region and produce a measurable bulge on the skull. The theory was later {{c3::falsified}}, but it foreshadowed the modern principle of regional brain specialization.', 3),

  (deck,  1, 'cloze',
   '{{c1::Pierre Flourens}} was the first to systematically study the functions of major brain regions using {{c2::extirpation (ablation)}} — surgically removing parts of the brain in animals and observing the resulting behavioral deficits. His work supported the idea that {{c3::specific brain regions have specific functions}}.', 3),

  (deck,  2, 'cloze',
   '{{c1::William James}} is often called the founder of American psychology. He studied how mental processes help individuals adapt to their environment — the foundation of the school of thought called {{c2::functionalism}}.', 2),

  (deck,  3, 'cloze',
   '{{c1::Paul Broca}} was the first to demonstrate that a specific functional impairment could be linked to a specific {{c2::brain lesion}}. He studied a patient who could not produce speech and traced the deficit to damage in a left-hemisphere region of the frontal lobe — now known as {{c3::Broca''s area}}.', 3),

  (deck,  4, 'cloze',
   '{{c1::Hermann von Helmholtz}} was the first to measure the {{c2::speed of a nerve impulse}}, providing an early quantitative link between psychological reaction time and underlying neural activity. {{c3::Charles Sherrington}} later inferred the existence of {{c4::synapses}}; he initially believed synaptic transmission was electrical, but it is now known to be primarily {{c5::chemical}}.', 5),

  -- ── 2. Neurons and Reflex Arcs ───────────────────────────
  (deck,  5, 'cloze',
   'There are three functional types of neurons: {{c1::sensory (afferent)}} neurons carry signals from receptors toward the CNS, {{c2::motor (efferent)}} neurons carry signals from the CNS to muscles and glands, and {{c3::interneurons}} sit between other neurons and serve as the integrators of neural circuits.', 3),

  (deck,  6, 'cloze',
   'Of the three neuron types, {{c1::interneurons}} are by far the most numerous in the human nervous system. They are concentrated in the {{c2::brain and spinal cord}} and underlie the rapid integration of incoming signals — including the routing of reflexes.', 2),

  (deck,  7, 'cloze',
   'A {{c1::reflex arc}} uses interneurons in the {{c2::spinal cord}} to route an incoming sensory signal directly to motor neurons, producing a rapid response without waiting for the brain. A copy of the signal still ascends to the brain for conscious awareness, but the muscle response begins before the brain processes it.', 2),

  -- ── 3. Central vs Peripheral Nervous System ──────────────
  (deck,  8, 'cloze',
   'The nervous system divides into two anatomical components. The {{c1::central nervous system (CNS)}} consists of the {{c2::brain and spinal cord}}; the {{c3::peripheral nervous system (PNS)}} consists of all nerve tissue outside the CNS.', 3),

  (deck,  9, 'cloze',
   'The peripheral nervous system contains {{c1::31}} pairs of {{c2::spinal}} nerves (emanating from the spinal cord) and {{c1::12}} pairs of {{c3::cranial}} nerves (emanating directly from the brain).', 3),

  (deck, 10, 'cloze',
   'The {{c1::olfactory and optic nerves}} are unusual: developmentally they are outgrowths of the {{c2::central nervous system}}, but functionally and anatomically they are classified with the {{c3::peripheral nervous system}}.', 3),

  -- ── 4. Somatic vs Autonomic ──────────────────────────────
  (deck, 11, 'cloze',
   'The {{c1::somatic nervous system}} is the {{c2::voluntary}} branch of the PNS. It carries sensory information from skin, joints, and muscles to the CNS via {{c3::afferent}} fibers, and carries motor commands back to skeletal muscle via {{c3::efferent}} fibers.', 3),

  (deck, 12, 'cloze',
   'The {{c1::autonomic nervous system (ANS)}} is the {{c2::involuntary}} branch of the PNS. It regulates heartbeat, respiration, digestion, glandular secretions, body temperature, and other functions that occur without conscious control.', 2),

  -- ── 5. Sympathetic vs Parasympathetic ────────────────────
  (deck, 13, 'cloze',
   'The autonomic nervous system has two branches that typically act as {{c1::antagonists}} — opposing each other''s effects on the same target organs. They are the {{c2::sympathetic (fight-or-flight) and parasympathetic (rest-and-digest)}} branches.', 2),

  (deck, 14, 'cloze',
   'The {{c1::parasympathetic}} nervous system is dominant during rest and recovery — it slows heart rate, constricts the bronchi, and stimulates digestion and exocrine secretions. Its primary neurotransmitter is {{c2::acetylcholine}}.', 2),

  (deck, 15, 'cloze',
   'The {{c1::sympathetic}} nervous system is activated by stress, anywhere from a mild annoyance to a life-threatening emergency, and orchestrates the {{c2::fight-or-flight}} response that prepares the body to confront or escape a threat.', 2),

  (deck, 16, 'cloze',
   'When the sympathetic nervous system activates, the following changes occur: heart rate {{c1::rises}}, blood is redistributed to {{c2::skeletal muscle}} for locomotion, blood glucose climbs, bronchi {{c3::relax}} to maximize oxygen intake, digestion {{c4::slows}}, pupils dilate to maximize light intake, and {{c5::epinephrine}} is released into the bloodstream from the adrenal medulla.', 5),

  -- ── 6. Meninges and Cerebrospinal Fluid ──────────────────
  (deck, 17, 'cloze',
   'The brain is wrapped in three connective-tissue layers, collectively the {{c1::meninges}}: the tough outer {{c2::dura mater}} fused to the skull, the middle web-like {{c3::arachnoid mater}}, and the delicate inner {{c4::pia mater}} adhering directly to the brain surface.', 4),

  (deck, 18, 'cloze',
   'The meninges anchor the brain inside the skull, cushion it from impacts, and {{c1::reabsorb cerebrospinal fluid}} after it has circulated through the central nervous system.', 1),

  (deck, 19, 'cloze',
   '{{c1::Cerebrospinal fluid (CSF)}} is the aqueous fluid that nourishes the brain and spinal cord and provides a {{c2::protective cushion}}. It is produced by specialized cells lining the {{c3::ventricles}} of the brain.', 3),

  -- ── 7. Hindbrain ─────────────────────────────────────────
  (deck, 20, 'cloze',
   'The {{c1::hindbrain}} sits at the junction of the brain and spinal cord and manages the vital functions necessary for survival — including balance, motor coordination, breathing, digestion, and general arousal states such as sleeping and waking. It develops from two embryonic divisions: the myelencephalon (becoming the medulla) and the {{c2::metencephalon (becoming the pons and cerebellum)}}.', 2),

  (deck, 21, 'cloze',
   'The {{c1::medulla oblongata}} is a lower-brain structure that regulates the most basic vital functions: {{c2::breathing, heart rate, and digestion}}. Damage here is rapidly life-threatening.', 2),

  (deck, 22, 'cloze',
   'The {{c1::pons}} lies above the medulla and below the midbrain. It serves as a relay station, carrying {{c2::sensory and motor pathways}} between the cerebral cortex and the medulla.', 2),

  (deck, 23, 'cloze',
   'The {{c1::cerebellum}} sits at the back of the hindbrain and is responsible for {{c2::posture, balance, and coordinated motor movement}}. Damage to the cerebellum produces characteristic deficits: clumsiness, loss of balance, and slurred speech.', 2),

  -- ── 8. Midbrain ──────────────────────────────────────────
  (deck, 24, 'cloze',
   'The {{c1::midbrain (mesencephalon)}} receives sensory and motor information from the rest of the body and is responsible for {{c2::involuntary reflex responses triggered by visual or auditory stimuli}}.', 2),

  (deck, 25, 'cloze',
   'The midbrain contains two prominent paired nuclei called the {{c1::colliculi}}. The {{c2::superior}} colliculus receives {{c3::visual}} sensory input and mediates visual reflexes; the {{c2::inferior}} colliculus receives {{c3::auditory}} sensory input and mediates reflexes such as turning toward a sudden loud noise.', 3),

  -- ── 9. Forebrain Overview ────────────────────────────────
  (deck, 26, 'cloze',
   'The forebrain develops embryonically from two divisions. The {{c1::telencephalon}} gives rise to the {{c2::cerebral cortex, basal ganglia, and limbic system}}; the {{c3::diencephalon}} gives rise to the {{c4::thalamus, hypothalamus, posterior pituitary, and pineal gland}}.', 4),

  (deck, 27, 'cloze',
   'The forebrain handles the most {{c1::complex perceptual, cognitive, and behavioral}} processes — including memory, emotion, intellectual reasoning, and the higher-order judgments most characteristic of humans. It is also the most recent region to evolve.', 1),

  -- ── 10. Brain Mapping Methods ────────────────────────────
  (deck, 28, 'cloze',
   '{{c1::Lesion studies}} infer the function of a brain region by observing what behavioral capacity is lost when that region is damaged. In humans, naturally occurring lesions (from stroke, tumor, or injury) are observed; in animals, lesions can be created experimentally — most precisely using {{c2::stereotactic instruments}} that target specific regions in three-dimensional coordinates.', 2),

  (deck, 29, 'cloze',
   'During brain surgery, a surgeon can stimulate the cortex with a small electrode and observe the behavioral or perceptual response. By systematically mapping which sites produce which responses, neurosurgeons can construct a {{c1::cortical map}} — historically a major source of our knowledge about cortical localization.', 1),

  (deck, 30, 'cloze',
   'An {{c1::electroencephalogram (EEG)}} records the electrical activity of the brain using {{c2::scalp electrodes}}. It captures the summed activity of large groups of neurons and is a non-invasive method especially useful for tracking {{c3::sleep stages, seizures, and rapid changes in arousal}}.', 3),

  (deck, 31, 'cloze',
   '{{c1::Regional cerebral blood flow (rCBF)}} measures patterns of neural activity by tracking {{c2::increased blood flow}} to active brain regions. The technique relies on the assumption that regions engaged in a cognitive task require more blood — a principle that also underlies the fMRI BOLD signal.', 2),

  (deck, 32, 'cloze',
   'Four key brain imaging techniques: {{c1::CT (CAT scan)}} uses multiple x-rays to build cross-sectional images of tissue; {{c2::PET}} uses a radioactive sugar to image metabolic uptake; {{c3::MRI}} uses magnetic fields and hydrogen-atom signals to image structure; {{c4::fMRI}} extends MRI by tracking the BOLD blood-oxygen signal to reveal regional activity in real time.', 4),

  -- ── 11. Thalamus and Hypothalamus ────────────────────────
  (deck, 33, 'cloze',
   'The {{c1::thalamus}} sits in the diencephalon and serves as the brain''s primary {{c2::sensory relay station}}. It receives signals from all senses {{c3::except smell (olfaction)}} and routes them to the appropriate areas of the cerebral cortex for processing.', 3),

  (deck, 34, 'cloze',
   'The {{c1::hypothalamus}} is small but functionally critical — it maintains {{c2::homeostasis}}, regulates the autonomic nervous system, and drives basic behaviors such as hunger, thirst, sexual behavior, and aggression.', 2),

  (deck, 35, 'cloze',
   'The hypothalamus is divided into three functional regions: the {{c1::lateral}} hypothalamus is the {{c2::hunger center}} (signals when food/fluids are needed); the {{c1::ventromedial}} hypothalamus is the {{c2::satiety center}} (signals when to stop eating); the {{c1::anterior}} hypothalamus regulates {{c3::sexual behavior, sleep, and body temperature}}.', 3),

  (deck, 36, 'cloze',
   'The hypothalamus controls the anterior pituitary gland through the {{c1::hypophyseal portal system}} — a small set of blood vessels that carry hypothalamic releasing hormones directly to the anterior pituitary, bypassing the general circulation.', 1),

  (deck, 37, 'cloze',
   'A useful contrast: the {{c1::thalamus}} acts as a sensory {{c2::relay}} (passing information from senses to cortex), while the {{c3::hypothalamus}} acts as a {{c4::regulator}} (maintaining homeostasis and driving behaviors). The two structures are anatomically adjacent but functionally distinct.', 4),

  -- ── 12. Pineal Gland and Posterior Pituitary ─────────────
  (deck, 38, 'cloze',
   'The {{c1::pineal gland}} secretes the hormone {{c2::melatonin}}, which regulates the body''s {{c3::circadian rhythm}}. The gland receives direct signals from the retina, allowing the body to coordinate sleep-wake cycles with the day-night cycle.', 3),

  (deck, 39, 'cloze',
   'The {{c1::posterior pituitary}} is unusual for an endocrine gland: it does not synthesize its own hormones. Instead, it consists of {{c2::axonal projections from the hypothalamus}} that store and release hormones produced in hypothalamic neurons.', 2),

  (deck, 40, 'cloze',
   'The two hormones stored and released by the posterior pituitary are {{c1::antidiuretic hormone (ADH, also called vasopressin)}} — which promotes water retention — and {{c2::oxytocin}} — which drives uterine contractions during labor and milk letdown during nursing.', 2),

  -- ── 13. Basal Ganglia ────────────────────────────────────
  (deck, 41, 'cloze',
   'The {{c1::basal ganglia}} are forebrain nuclei that coordinate {{c2::smooth, intentional movement}} and maintain {{c3::postural stability}}. They form part of the {{c4::extrapyramidal motor system}}, modulating voluntary movement without directly driving motor neurons.', 4),

  (deck, 42, 'cloze',
   '{{c1::Parkinson''s disease}} is caused by the loss of {{c2::dopaminergic neurons in the basal ganglia}}, leading to characteristic symptoms: resting tremors, jerky movements, and posture instability. Imbalances of basal ganglia activity also play a role in {{c3::schizophrenia and obsessive-compulsive disorder}}.', 3),

  -- ── 14. Limbic System ────────────────────────────────────
  (deck, 43, 'cloze',
   'The {{c1::limbic system}} is a ring of interconnected forebrain structures primarily responsible for {{c2::emotion and memory}}. Its four core components are the {{c3::septal nuclei, amygdala, hippocampus, and anterior cingulate cortex}}.', 3),

  (deck, 44, 'cloze',
   'The {{c1::septal nuclei}} contain one of the brain''s primary {{c2::pleasure centers}}. Mild electrical stimulation here is reported to be intensely pleasurable, and these nuclei are heavily implicated in {{c3::addictive behavior}}.', 3),

  (deck, 45, 'cloze',
   'The {{c1::amygdala}} plays a key role in {{c2::defense and aggression}}, processing the emotions of {{c3::fear and rage}}. Damage to the amygdala produces docility and hypersexual states — the classic Klüver-Bucy pattern.', 3),

  (deck, 46, 'cloze',
   'The {{c1::hippocampus}} is critical for {{c2::learning and the consolidation of long-term memories}}. It communicates with the rest of the limbic system through a long axonal projection called the {{c3::fornix}}.', 3),

  (deck, 47, 'cloze',
   'After hippocampal damage, patients typically show {{c1::anterograde amnesia}} — the inability to form {{c2::new}} long-term memories from that point forward, while older memories remain intact. {{c3::Retrograde amnesia}} is the loss of memories formed {{c4::before}} the injury, with the ability to form new memories often preserved.', 4),

  (deck, 48, 'cloze',
   'The {{c1::anterior cingulate cortex}} contributes to higher-order cognitive processes including {{c2::impulse control, decision-making, and emotional regulation}}. It bridges the limbic system with the prefrontal cortex.', 2),

  -- ── 15. Cerebral Cortex — Lobes and Features ─────────────
  (deck, 49, 'cloze',
   'The cerebral cortex (sometimes called the {{c1::neocortex}}, reflecting its evolutionary recency) is folded into ridges called {{c2::gyri}} and valleys called {{c2::sulci}}. This folding dramatically increases the cortical {{c3::surface area}} that can fit inside the skull.', 3),

  (deck, 50, 'cloze',
   'The cerebral cortex is divided into four lobes: the {{c1::frontal, parietal, occipital, and temporal}} lobes. Each contains specialized regions for specific perceptual, motor, or cognitive functions, though the lobes work as an integrated whole.', 1),

  (deck, 51, 'cloze',
   'The {{c1::frontal lobe}} contains the {{c2::prefrontal cortex}} (handling executive function, impulse control, long-term planning) and the {{c2::primary motor cortex}} (on the precentral gyrus, initiating voluntary movement). It also contains {{c3::Broca''s area}}, which controls speech production.', 3),

  (deck, 52, 'cloze',
   'The {{c1::parietal lobe}} contains the {{c2::somatosensory cortex}} on the {{c3::postcentral gyrus}}, where touch, pressure, temperature, and pain signals from the body terminate. The lobe also handles spatial processing and orientation.', 3),

  (deck, 53, 'cloze',
   'The {{c1::occipital lobe}} sits at the rear of the brain and contains the {{c2::visual cortex (striate cortex)}}, which performs the bulk of visual processing.', 2),

  (deck, 54, 'cloze',
   'The {{c1::temporal lobe}} contains the {{c2::auditory cortex}}, which processes sound including speech and music, as well as {{c3::Wernicke''s area}} (language comprehension). The lobe also contributes to memory and emotion.', 3),

  (deck, 55, 'cloze',
   'Cortical regions are classified as either projection or association areas. {{c1::Projection}} areas perform rudimentary motor or sensory tasks — the primary motor cortex and the primary somatosensory cortex are classic examples. {{c2::Association}} areas integrate input from diverse regions to enable higher-order processing such as planning and decision-making. The systematic body-part organization of the motor cortex is visualized in the {{c3::motor homunculus}}.', 3),

  -- ── 16. Hemispheres and Laterality ───────────────────────
  (deck, 56, 'cloze',
   'Most cortical communication with the body is {{c1::contralateral}}: the left hemisphere controls and receives from the right side of the body, and vice versa. Some functions communicate {{c2::ipsilaterally}} (same side), but the contralateral pattern dominates.', 2),

  (deck, 57, 'cloze',
   'The {{c1::dominant hemisphere}} (typically the left, even in most left-handed people) is more heavily involved in {{c2::language production and comprehension}} — housing Broca''s area and Wernicke''s area. It is also primarily {{c3::analytic}}, well suited to processing details and sequential information.', 3),

  (deck, 58, 'cloze',
   'The {{c1::non-dominant hemisphere}} (typically the right) is associated with {{c2::intuition, creativity, music cognition, and spatial processing}}. It is more sensitive to the {{c3::emotional tone}} of language and assembles individual stimuli into holistic perceptions.', 3),

  (deck, 59, 'cloze',
   'The {{c1::corpus callosum}} is a thick bundle of {{c2::myelinated axons}} connecting the two cerebral hemispheres. It allows the dominant and non-dominant hemispheres to share information continuously — analytic language content from one side, emotional and contextual nuance from the other.', 2),

  -- ── 17. Neurotransmitters ────────────────────────────────
  (deck, 60, 'cloze',
   'A drug that {{c1::mimics}} the action of a neurotransmitter at its receptor is called an {{c2::agonist}}. A drug that {{c1::blocks}} the action of a neurotransmitter is called an {{c2::antagonist}}.', 2),

  (deck, 61, 'cloze',
   '{{c1::Acetylcholine}} is used both peripherally and centrally. In the {{c2::peripheral}} nervous system it transmits impulses to skeletal muscle and is the primary parasympathetic neurotransmitter; in the {{c3::central}} nervous system it modulates attention and arousal. The loss of cholinergic neurons projecting to the hippocampus is a hallmark of {{c4::Alzheimer''s disease}}.', 4),

  (deck, 62, 'cloze',
   'The {{c1::catecholamines}} are a group of three structurally related neurotransmitters — {{c2::dopamine, norepinephrine, and epinephrine}} — synthesized from the amino acid tyrosine. They are heavily involved in emotional experience and the sympathetic stress response.', 2),

  (deck, 63, 'cloze',
   '{{c1::Dopamine}} maintains {{c2::smooth movement and steady posture}} via the basal ganglia. Loss of dopaminergic neurons in the basal ganglia produces {{c3::Parkinson''s disease}}; excess dopamine activity (or oversensitivity to it) is implicated in the positive symptoms of {{c4::schizophrenia}} — the dopamine hypothesis.', 4),

  (deck, 64, 'cloze',
   '{{c1::Norepinephrine (NE)}} acts mainly as a {{c2::local neurotransmitter}} in the central and sympathetic nervous systems. {{c3::Epinephrine}} is released systemically as a {{c4::hormone}} from the {{c5::adrenal medulla}}, traveling in the bloodstream to broadcast sympathetic effects across the body.', 5),

  (deck, 65, 'cloze',
   'Imbalances of norepinephrine are linked to mood and anxiety disorders: {{c1::low}} norepinephrine levels are associated with {{c2::depression}}, while {{c3::high}} levels are associated with {{c4::anxiety and mania}}.', 4),

  (deck, 66, 'cloze',
   '{{c1::Serotonin}} is a biogenic amine neurotransmitter that modulates {{c2::mood, sleep, eating, and dreaming}}. Low serotonin is associated with {{c3::depression}}; abnormally high serotonin activity is associated with {{c4::manic states}}.', 4),

  (deck, 67, 'cloze',
   'The two major inhibitory neurotransmitters of the CNS are {{c1::GABA (primarily in the brain) and glycine (primarily in the brainstem and spinal cord)}}. Both produce {{c2::hyperpolarization}} of the postsynaptic membrane by increasing chloride influx, making the receiving neuron less likely to fire.', 2),

  (deck, 68, 'cloze',
   '{{c1::Glutamate}} is the primary {{c2::excitatory}} neurotransmitter of the central nervous system. It depolarizes the postsynaptic membrane, making the receiving neuron more likely to fire.', 2),

  (deck, 69, 'cloze',
   '{{c1::Endorphins}} are the most important {{c2::peptide neurotransmitters}} (also called neuropeptides). They act as natural painkillers with effects similar to morphine and other opioid drugs. Peptide NTs are typically {{c3::slow-acting but longer-lasting}} than small-molecule neurotransmitters.', 3),

  -- ── 18. Endocrine, Genetics & Development ────────────────
  (deck, 70, 'cloze',
   'The endocrine system is the body''s second major communication network, using chemical messengers called {{c1::hormones}}. It is {{c2::slower}} than the nervous system because hormones travel to their targets through the {{c3::bloodstream}}, but its effects are typically longer-lasting.', 3),

  (deck, 71, 'cloze',
   'The {{c1::pituitary gland}} is sometimes called the {{c2::master gland}} because it secretes hormones that regulate other endocrine glands throughout the body. The {{c3::anterior pituitary}} actually performs this regulatory role; the posterior pituitary instead stores and releases hormones made in the hypothalamus.', 3),

  (deck, 72, 'cloze',
   'The adrenal glands sit on top of the kidneys and have two distinct parts. The {{c1::adrenal medulla}} releases {{c2::epinephrine and norepinephrine}} during sympathetic activation. The {{c1::adrenal cortex}} produces a class of steroid hormones called {{c3::corticosteroids}}, including {{c4::cortisol}} (the major stress hormone) plus sex hormones in smaller amounts.', 4),

  (deck, 73, 'cloze',
   'The {{c1::gonads}} — testes in males, ovaries in females — produce sex hormones in large concentrations (testosterone and estrogen). These hormones drive {{c2::libido and mating behavior}}; testosterone in particular is associated with increased {{c3::aggression}}.', 3),

  (deck, 74, 'cloze',
   '{{c1::Innate}} behaviors are genetically programmed and appear in all members of a species regardless of environment or experience. {{c2::Learned}} behaviors are not based on heredity — they emerge through experience and interaction with the environment.', 2),

  (deck, 75, 'cloze',
   'A trait or behavior''s {{c1::adaptive value}} is the extent to which it benefits a species'' {{c2::evolutionary fitness}} — i.e., its contribution to survival and reproduction. Traits with high adaptive value tend to be preserved by {{c3::natural selection}}.', 3),

  (deck, 76, 'cloze',
   'The {{c1::nature vs. nurture}} debate asks how much of behavior is determined by inherited characteristics ({{c2::nature}}) and how much by environment and experience ({{c3::nurture}}). The modern consensus is that virtually every behavioral trait reflects an interaction between the two.', 3),

  (deck, 77, 'cloze',
   'Behavioral geneticists use three complementary study designs. {{c1::Family studies}} compare relatives but cannot separate shared genes from shared environment. {{c2::Twin studies}} compare concordance rates between {{c3::monozygotic (MZ) and dizygotic (DZ)}} twins to isolate genetic effects. {{c4::Adoption studies}} compare children to both biological and adoptive parents to disentangle genetics from upbringing.', 4),

  (deck, 78, 'cloze',
   '{{c1::Monozygotic (identical)}} twins share approximately {{c2::100%}} of their genes; {{c3::dizygotic (fraternal)}} twins share approximately {{c4::50%}}. Higher concordance rates for a trait in MZ than DZ twins indicates a {{c5::genetic contribution}} to that trait.', 5),

  (deck, 79, 'cloze',
   'A {{c1::critical period}} is a developmental window during which the nervous system is especially {{c2::susceptible to environmental input}}. Skills or traits not acquired during the critical period may be difficult or impossible to acquire later — language acquisition is the canonical example.', 2),

  (deck, 80, 'cloze',
   'The nervous system begins forming at {{c1::3 to 4 weeks}} of gestational age in a process called {{c2::neurulation}}. The {{c3::ectoderm}} folds inward to form a neural groove; the folds then close to form the {{c4::neural tube}} (which becomes the CNS) and the {{c5::neural crest cells}} (which migrate to form diverse tissues including dorsal root ganglia, melanocytes, and calcitonin-producing thyroid cells).', 5),

  (deck, 81, 'cloze',
   'A {{c1::teratogen}} is any substance or exposure during pregnancy that disrupts normal fetal development. Major teratogens include {{c2::alcohol, nicotine, x-rays, and certain viruses}} that cross the placenta. {{c3::Maternal malnutrition}} is considered the single leading cause of abnormal prenatal development.', 3),

  (deck, 82, 'cloze',
   'Newborn humans show several {{c1::primitive reflexes}} that disappear over the first year of life. The {{c2::rooting reflex turns the head toward a touch on the cheek, the Moro reflex spreads then retracts the arms in response to a sense of falling, the Babinski reflex fans the toes when the sole is stroked, and the grasping reflex curls the fingers around any object placed in the palm}}.', 2),

  (deck, 83, 'cloze',
   'Motor development in infants follows two predictable trends. The {{c1::cephalocaudal}} trend means development proceeds from head to toe — infants control the head before the trunk, the trunk before walking. The {{c2::proximodistal}} trend means development proceeds from the body''s center outward — control of the shoulders develops before fine control of the fingers.', 2),

  (deck, 84, 'cloze',
   'Early social development follows a predictable trajectory. Infants first display {{c1::stranger anxiety}} (fear of unfamiliar individuals), then {{c2::separation anxiety}} (distress when parted from a caregiver). Toddlers begin {{c3::parallel play}} — playing alongside other children without much interaction. Social orientation broadly shifts from {{c4::parent → self → other}} over the early years.', 4);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
