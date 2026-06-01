-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Sensory Systems & Perception
-- Section: psych_soc · Topic: Psych / Soc
--
-- Coverage: sensation vs perception fundamentals (transduction,
-- distal vs proximal stimuli, psychophysics); seven sensory
-- receptor classes; absolute threshold, threshold of conscious
-- perception with subliminal perception, difference threshold
-- (JND), Weber''s law, discrimination testing; signal detection
-- theory with four outcomes (hit/miss/false alarm/correct
-- negative) plus signal vs catch trials; sensory adaptation;
-- eye anatomy (sclera, cornea, iris with dilator and constrictor
-- pupillae, anterior and posterior chambers with aqueous humor
-- and canal of Schlemm, lens with ciliary muscle and suspensory
-- ligaments and accommodation, vitreous humor, choroid); retina
-- structure (Duplicity Theory, rods with rhodopsin, three cone
-- types — S/M/L wavelengths, macula and fovea, the photoreceptor
-- pathway through bipolar/horizontal/amacrine/ganglion cells,
-- the optic disc as the blind spot); visual pathway (optic
-- nerve, optic chiasm with nasal-fiber crossing, optic tract,
-- LGN, optic radiations, visual cortex; superior colliculus
-- reflex branch); visual parallel processing (parvocellular for
-- form/color with high spatial resolution; magnocellular for
-- motion with high temporal resolution; binocular neurons for
-- depth; feature detector cells); outer ear (pinna, external
-- auditory canal, tympanic membrane with frequency/amplitude
-- encoding); middle ear (ossicles malleus/incus/stapes,
-- Eustachian tube); inner ear (bony and membranous labyrinths,
-- perilymph and endolymph, cochlea with three scalae, organ
-- of Corti, basilar and tectorial membranes, oval and round
-- windows, hair cells with stereocilia mechanoreceptor
-- mechanism, place theory, tonotopic organization); vestibular
-- system (utricle and saccule with otoliths for linear
-- acceleration; semicircular canals with ampullae for
-- rotational acceleration); auditory pathway (vestibulocochlear
-- nerve → MGN → auditory cortex in temporal lobe; superior
-- olive for sound localization, inferior colliculus for startle
-- reflex); smell (olfactory chemoreceptors, olfactory pathway
-- bypassing the thalamus, pheromones); taste (five modalities
-- including umami, taste buds and papillae); somatosensation
-- (four modalities and five mechanoreceptor types: Pacinian for
-- deep pressure/high-frequency vibration, Meissner for light
-- touch, Merkel for sustained light pressure, Ruffini for
-- stretch, free nerve endings for pain and temperature;
-- two-point threshold; physiological zero; nociceptors and gate
-- theory of pain; kinesthetic sense/proprioception); object
-- recognition (bottom-up data-driven vs top-down conceptually-
-- driven processing; perceptual organization; perceptual
-- constancy); depth perception (monocular cues — relative size,
-- interposition, linear perspective, motion parallax; binocular
-- cues — retinal disparity, convergence); and the six Gestalt
-- principles (proximity, similarity, good continuation,
-- subjective contours, closure, Prägnanz).
--
-- All cards are CLOZE-format. Card content is ORIGINAL Praxist
-- Prep prose written from the underlying perceptual psychology
-- and neuroanatomy, re-sourced from OpenStax Psychology 2e
-- references in the companion verification.md file; no prose
-- is lifted from any third-party source. Text-only deck (no
-- images bundled).
--
-- Subtopic ordering follows the AAMC content outline
-- (Foundation 6A: Sensing the environment), NOT the source
-- .docx''s chapter ordering. Style follows the Psych/Soc Ch1
-- cadence reference.
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
           'Sensory Systems & Perception',
           'Sensation and Perception',
           'Sensation, Perception & Object Recognition',
           'Chapter 2 — Sensory Systems & Perception',
           'Chapter 2 — Sensation and Perception'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'psych_soc',
    'Psych / Soc',
    'sensory_systems_and_perception',
    'Sensory Systems & Perception',
    'A complete walkthrough of human sensation and perception: receptor types and thresholds, signal detection theory, the visual system (eye anatomy, retina, pathway, parallel processing), the auditory and vestibular systems (outer/middle/inner ear, cochlea, place theory), olfaction and taste, somatosensation (five mechanoreceptor types, pain and proprioception), object recognition (bottom-up vs top-down), depth perception (monocular and binocular cues), and the six Gestalt principles.',
    2
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. Sensation vs Perception Fundamentals ──────────────
  (deck,  0, 'cloze',
   '{{c1::Sensation}} is the process of {{c2::transduction}} — converting physical stimuli (light, sound, pressure, chemicals, and so on) from the environment into {{c3::electrical signals}} the nervous system can transmit. Sensation happens at the sensory receptors of the peripheral nervous system.', 3),

  (deck,  1, 'cloze',
   '{{c1::Perception}} is the higher-order processing of incoming sensory signals to extract their {{c2::meaning and significance}}. While sensation is performed by peripheral receptors, perception is the work of the {{c3::central nervous system}}, integrating raw input with memory and context.', 3),

  (deck,  2, 'cloze',
   'Cell bodies of sensory neurons outside the CNS cluster together in {{c1::sensory ganglia}}. The brain regions that ultimately analyze incoming sensory information are called {{c2::projection areas}} — for example, the visual cortex is the projection area for visual input.', 2),

  (deck,  3, 'cloze',
   'A {{c1::distal stimulus}} is the actual object or event in the world (a tree, a sound source, a hot stove). The {{c2::proximal stimulus}} is the pattern of energy that physically reaches the receptors — photons hitting the retina, sound waves vibrating the eardrum, heat touching skin thermoreceptors.', 2),

  (deck,  4, 'cloze',
   'A {{c1::sensory stimulus}} activates a sensory receptor and initiates sensation. An {{c2::incentive stimulus}} is an external object or event that motivates behavior by offering a reward or punishment — its role is motivational rather than purely perceptual.', 2),

  (deck,  5, 'cloze',
   '{{c1::Psychophysics}} is the field that studies the quantitative relationship between {{c2::the physical magnitude of a stimulus and the subjective sensation or perception it evokes}}. Thresholds, the just noticeable difference, and Weber''s law are all psychophysical results.', 2),

  -- ── 2. Sensory Receptor Types ────────────────────────────
  (deck,  6, 'cloze',
   '{{c1::Sensory receptors}} are specialized neurons that respond to environmental stimuli by triggering electrical signals (action potentials) carried toward the central nervous system. Different receptor classes respond selectively to different forms of energy.', 1),

  (deck,  7, 'cloze',
   'Seven major sensory receptor classes: {{c1::photoreceptors (light), mechanoreceptors (pressure, movement, sound), nociceptors (pain), thermoreceptors (temperature), osmoreceptors (blood osmolarity), olfactory receptors (volatile chemicals), and taste receptors (dissolved chemicals)}}.', 1),

  -- ── 3. Thresholds ────────────────────────────────────────
  (deck,  8, 'cloze',
   'A {{c1::sensory threshold}} is the minimum stimulus required to produce some perceptual outcome. Different thresholds describe different perceptual transitions — from detection, to conscious awareness, to discrimination between two stimuli.', 1),

  (deck,  9, 'cloze',
   'The {{c1::absolute threshold}} is the {{c2::minimum stimulus intensity}} required to activate a sensory system. Below the absolute threshold, the stimulus is not transduced into action potentials and never reaches the CNS at all.', 2),

  (deck, 10, 'cloze',
   'The {{c1::threshold of conscious perception}} is the higher intensity required for a stimulus to be consciously noticed. Stimuli that exceed the absolute threshold (and thus reach the CNS) but fall short of conscious perception are called {{c2::subliminal}} — they are processed by the brain but never reach awareness.', 2),

  (deck, 11, 'cloze',
   'The {{c1::difference threshold}} — also called the {{c1::just noticeable difference (JND)}} — is the smallest magnitude difference between two stimuli that an observer can reliably detect. {{c2::Weber''s law}} generalizes the finding: the JND is a {{c3::constant proportion}} of the original stimulus magnitude (not a fixed absolute amount) across most of the perceptible range.', 3),

  (deck, 12, 'cloze',
   '{{c1::Discrimination testing}} is the experimental method used to measure the JND. A baseline stimulus is presented, then varied by progressively larger amounts until the participant reports noticing a change. The smallest reliably noticed change is recorded as the {{c2::just noticeable difference}} for that baseline.', 2),

  -- ── 4. Signal Detection + Adaptation ─────────────────────
  (deck, 13, 'cloze',
   '{{c1::Signal detection theory (SDT)}} models perception as a decision under uncertainty: detecting a stimulus depends not only on its physical intensity but also on {{c2::nonsensory factors}} such as the observer''s experience, expectations, motivation, and the perceived cost of errors.', 2),

  (deck, 14, 'cloze',
   'Signal detection experiments include both signal trials (stimulus present) and {{c1::catch trials}} (stimulus absent). Each trial produces one of four outcomes: {{c2::hit (signal present, correctly detected), miss (signal present, missed), false alarm (signal absent, falsely reported), or correct negative (signal absent, correctly identified)}}.', 2),

  (deck, 15, 'cloze',
   '{{c1::Sensory adaptation}} is the gradual reduction in receptor or perceptual response to a {{c2::constant stimulus}} over time — the reason you stop noticing the smell of your own house, the touch of your clothing, or background noise. Adaptation has both peripheral (receptor-level) and central (perceptual) components.', 2),

  -- ── 5. Eye Anatomy ───────────────────────────────────────
  (deck, 16, 'cloze',
   'The {{c1::sclera}} is the tough, white outer layer covering most of the eye and giving the eyeball its characteristic appearance. Its role is structural: it maintains eye shape and provides attachment points for the {{c2::extraocular muscles}}.', 2),

  (deck, 17, 'cloze',
   'Light first passes through the {{c1::cornea}}, a clear dome at the front of the eye that gathers and pre-focuses the incoming rays. The {{c2::iris}} is the colored ring of muscle behind it; the iris contains a {{c3::dilator pupillae}} (sympathetic) that widens the pupil and a {{c3::constrictor pupillae}} (parasympathetic) that narrows it.', 3),

  (deck, 18, 'cloze',
   'The space in front of the lens is divided by the iris into two compartments. The {{c1::anterior chamber}} lies between the cornea and the iris; the {{c2::posterior chamber}} lies between the iris and the lens. Both are filled with {{c3::aqueous humor}}, secreted by the ciliary body and drained through the {{c4::canal of Schlemm}}.', 4),

  (deck, 19, 'cloze',
   'The {{c1::lens}} sits behind the iris and provides the variable focusing the cornea cannot. It is suspended by {{c2::suspensory ligaments}} attached to the {{c3::ciliary muscle}}; when the ciliary muscle contracts (under parasympathetic control), it changes the lens''s curvature to focus on near versus distant objects — a process called {{c4::accommodation}}.', 4),

  (deck, 20, 'cloze',
   'Behind the lens, the bulk of the eye is filled by the {{c1::vitreous humor}} — a transparent gel that maintains the eyeball''s shape and supports the retina against the back wall.', 1),

  (deck, 21, 'cloze',
   'The {{c1::choroid}} is the vascular layer sandwiched between the sclera and the retina. It supplies oxygen and nutrients to the outer retinal layers and contains pigment that absorbs stray light, preventing internal reflections that would degrade the visual image.', 1),

  -- ── 6. Retina Structure ──────────────────────────────────
  (deck, 22, 'cloze',
   'The {{c1::Duplicity Theory of Vision}} states that the retina contains two distinct classes of photoreceptors that specialize for different conditions: {{c2::rods}} for low-light, peripheral, and black-and-white vision, and {{c2::cones}} for color and fine-detail vision in bright light.', 2),

  (deck, 23, 'cloze',
   '{{c1::Rods}} are extremely sensitive — capable of responding to single photons — but contain only one pigment, {{c2::rhodopsin}}, so they cannot discriminate color and only signal {{c3::light versus dark}}. They dominate peripheral and dim-light vision.', 3),

  (deck, 24, 'cloze',
   '{{c1::Cones}} require bright light to function but support color vision and high-acuity discrimination of fine detail. There are three cone types, each preferring a different wavelength range: {{c2::short (S, blue), medium (M, green), and long (L, red)}}; together their activation patterns let the brain distinguish thousands of colors.', 2),

  (deck, 25, 'cloze',
   'The {{c1::macula}} is a small central region of the retina densely packed with cones. At its center sits the {{c2::fovea}} — containing exclusively {{c3::cones}}, no rods — which provides the sharpest visual acuity in normal daylight viewing. When you look directly at something, you are projecting it onto the fovea.', 3),

  (deck, 26, 'cloze',
   'Signals from rods and cones flow first to {{c1::bipolar cells}}, which then synapse on {{c2::ganglion cells}} whose axons exit the eye as the optic nerve. {{c3::Horizontal cells and amacrine cells}} run laterally, integrating signals across neighboring photoreceptors to sharpen edges and emphasize gradients before signals leave the retina.', 3),

  (deck, 27, 'cloze',
   'The point where ganglion-cell axons exit the eye to form the optic nerve is called the {{c1::optic disc}}. Because it contains no photoreceptors, it creates a small {{c2::blind spot}} in each eye''s visual field — typically unnoticed because the brain fills it in from surrounding context and the other eye''s input.', 2),

  -- ── 7. Visual Pathway ────────────────────────────────────
  (deck, 28, 'cloze',
   'The visual pathway runs: retina → {{c1::optic nerves}} → {{c2::optic chiasm}} → optic tracts → {{c3::lateral geniculate nucleus (LGN) of the thalamus}} → optic radiations → {{c4::visual cortex}} in the occipital lobe.', 4),

  (deck, 29, 'cloze',
   'At the {{c1::optic chiasm}}, only the {{c2::nasal retinal fibers}} (carrying information from the temporal visual field) cross to the opposite side; the temporal retinal fibers stay on the same side. The net result: each {{c3::hemisphere processes the opposite visual field}} — your left brain sees the right side of the world, regardless of which eye the light entered.', 3),

  (deck, 30, 'cloze',
   'Not all visual fibers go through the LGN. A side branch projects directly to the {{c1::superior colliculus}} in the midbrain, which mediates {{c2::reflexive eye movements}} and rapid orientations to visual stimuli — for example, turning your head and eyes automatically toward sudden movement in your periphery.', 2),

  (deck, 31, 'cloze',
   'The {{c1::visual cortex}} (sometimes called the striate cortex) is located in the {{c2::occipital lobe}}. It performs the deepest analysis of visual information — edge detection, color processing, motion analysis, and object recognition — drawing on input streams that have already been filtered by the retina, LGN, and other relays.', 2),

  -- ── 8. Visual Parallel Processing ────────────────────────
  (deck, 32, 'cloze',
   'The brain analyzes visual information through {{c1::parallel processing}}: separate neural streams simultaneously process {{c2::color, form, motion, and depth}}, then the streams are integrated to construct a unified visual experience.', 2),

  (deck, 33, 'cloze',
   '{{c1::Parvocellular}} cells in the LGN handle {{c2::form and color}}. They have {{c3::high spatial resolution}} (fine detail) but {{c4::low temporal resolution}} (poor at tracking fast motion), so they work best with stationary or slowly moving objects.', 4),

  (deck, 34, 'cloze',
   '{{c1::Magnocellular}} cells in the LGN handle {{c2::motion}}. They have {{c3::high temporal resolution}} (excellent at tracking rapid change) but {{c4::low spatial resolution}}, so they produce a blurry but motion-sensitive picture — particularly important for detecting objects approaching from the periphery.', 4),

  (deck, 35, 'cloze',
   '{{c1::Binocular neurons}} in the visual cortex receive input from both eyes simultaneously and compare them. By computing the {{c2::disparity}} between left-eye and right-eye images, these cells extract {{c3::depth}} information about the three-dimensional structure of the scene.', 3),

  (deck, 36, 'cloze',
   '{{c1::Feature detector cells}} respond selectively to a particular visual feature — a specific orientation of an edge, a specific direction of motion, or a specific contour shape. Higher cortical areas combine the outputs of many feature detectors to recognize complex objects.', 1),

  -- ── 9. Outer/Middle Ear ──────────────────────────────────
  (deck, 37, 'cloze',
   'The outer ear consists of the visible {{c1::pinna (auricle)}}, which channels sound waves into the {{c2::external auditory canal}}, which directs them to the {{c3::tympanic membrane (eardrum)}}. The tympanic membrane separates the outer ear from the middle ear.', 3),

  (deck, 38, 'cloze',
   'The {{c1::tympanic membrane}} vibrates in step with incoming sound waves. Its {{c2::rate}} of vibration encodes the sound''s {{c3::frequency (pitch)}}, while the {{c4::amplitude}} of vibration encodes the sound''s {{c5::intensity (loudness)}}.', 5),

  (deck, 39, 'cloze',
   'The middle ear contains the three smallest bones in the body — the {{c1::malleus, incus, and stapes (sometimes called hammer, anvil, and stirrup)}}. They amplify the vibrations from the tympanic membrane and transmit them to the inner ear; the base of the {{c2::stapes}} rests on the {{c3::oval window}} of the cochlea.', 3),

  (deck, 40, 'cloze',
   'The {{c1::Eustachian tube}} connects the middle ear to the nasal cavity, allowing air to flow between them. Its function is to {{c2::equalize pressure}} across the tympanic membrane — the reason ears pop during altitude changes.', 2),

  -- ── 10. Inner Ear and Cochlea ────────────────────────────
  (deck, 41, 'cloze',
   'The inner ear consists of a {{c1::bony labyrinth}} (a hollow cavity within the temporal bone) housing a continuous tubular {{c2::membranous labyrinth}} suspended inside it. The bony labyrinth is filled with {{c3::perilymph}}; the membranous labyrinth is filled with potassium-rich {{c4::endolymph}}.', 4),

  (deck, 42, 'cloze',
   'The {{c1::cochlea}} is a spiral-shaped organ in the inner ear that contains the receptors for {{c2::hearing}}. Its interior is divided into three parallel chambers called {{c3::scalae}}; the middle scala houses the actual hearing apparatus, the organ of Corti.', 3),

  (deck, 43, 'cloze',
   'The {{c1::organ of Corti}} sits on a flexible base called the {{c2::basilar membrane}}, with the {{c3::tectorial membrane}} above. Sandwiched between the two membranes are rows of {{c4::hair cells}} — the auditory mechanoreceptors that transduce sound into electrical signals.', 4),

  (deck, 44, 'cloze',
   'Sound enters the cochlea through the {{c1::oval window}}, where the stapes pushes on the perilymph. The {{c2::round window}} is a flexible membrane on the opposite side that lets the perilymph displace — without it, the incompressible fluid could not move and the basilar membrane could not vibrate.', 2),

  (deck, 45, 'cloze',
   'Hair cells are named for the tuft of {{c1::stereocilia}} projecting from their surface. When the basilar membrane vibrates, the stereocilia {{c2::sway against the tectorial membrane}}, opening {{c3::mechanically gated ion channels}}. The resulting ion flow depolarizes the hair cell and generates a receptor potential that is converted to action potentials in the auditory nerve.', 3),

  (deck, 46, 'cloze',
   '{{c1::Place theory}} states that the {{c2::location}} of a vibrating hair cell along the basilar membrane determines the perceived {{c3::pitch}} of a sound. Each location is mechanically tuned to a different frequency, so which hair cells fire encodes the frequency content of the sound.', 3),

  (deck, 47, 'cloze',
   'The cochlea is {{c1::tonotopically}} organized: {{c2::high}}-frequency sounds vibrate the basilar membrane near the {{c3::base (close to the oval window)}}, while {{c2::low}}-frequency sounds vibrate it near the {{c3::apex (the far end of the spiral)}}. This spatial-frequency map is the physical basis of place theory.', 3),

  -- ── 11. Vestibular System ────────────────────────────────
  (deck, 48, 'cloze',
   'The {{c1::utricle and saccule}} sit in the vestibule and detect {{c2::linear acceleration}} (and the static pull of gravity). Each contains modified hair cells capped with calcium-carbonate crystals called {{c3::otoliths}}. As the head accelerates, the otoliths lag behind by inertia, bending the hair cells and signaling motion.', 3),

  (deck, 49, 'cloze',
   'The three {{c1::semicircular canals}} detect {{c2::rotational acceleration}} in three perpendicular planes (one for each canal). Each canal ends in a swelling called an {{c3::ampulla}} containing hair cells. When the head rotates, endolymph in the canal lags behind by inertia, bending the hair cells in the ampulla.', 3),

  (deck, 50, 'cloze',
   'Quick discriminator: the {{c1::utricle and saccule}} sense {{c2::linear}} acceleration; the {{c3::semicircular canals}} sense {{c4::rotational (angular)}} acceleration. Together they inform the brain about both motion and orientation in three-dimensional space.', 4),

  -- ── 12. Auditory Pathway ─────────────────────────────────
  (deck, 51, 'cloze',
   'Auditory signals leave the cochlea via the {{c1::vestibulocochlear nerve (CN VIII)}} and ascend through the brainstem to the {{c2::medial geniculate nucleus (MGN) of the thalamus}}, then project to the {{c3::auditory cortex in the temporal lobe}}.', 3),

  (deck, 52, 'cloze',
   'Two important side branches of the auditory pathway: the {{c1::superior olive}} (in the brainstem) helps {{c2::localize sound}} by comparing the timing and intensity of input from the two ears. The {{c3::inferior colliculus}} (in the midbrain) mediates the auditory {{c4::startle reflex}} and helps coordinate eye and head movements toward a sound source.', 4),

  -- ── 13. Smell + Taste ────────────────────────────────────
  (deck, 53, 'cloze',
   'Smell is detected by {{c1::olfactory chemoreceptors}} embedded in the {{c2::olfactory epithelium}} at the top of the nasal cavity. Volatile compounds inhaled into the nasal passages must {{c3::bind}} their matching chemoreceptors to trigger a signal.', 3),

  (deck, 54, 'cloze',
   'Olfactory signals travel via the olfactory nerves to the {{c1::olfactory bulb}}, then along the {{c2::olfactory tract}} to higher brain regions including the {{c3::limbic system}}. Crucially, olfactory signals are the only sensory modality that bypasses the {{c4::thalamus}} — explaining why smells so directly evoke emotion and memory.', 4),

  (deck, 55, 'cloze',
   '{{c1::Pheromones}} are chemical signals secreted by an animal that, when detected by another animal''s chemoreceptors, alter the recipient''s {{c2::social, foraging, or sexual behavior}}. They are well-documented in many non-human species; their role in humans remains debated.', 2),

  (deck, 56, 'cloze',
   'The five fundamental taste modalities are {{c1::sweet, salty, sour, bitter, and umami}} (the savory taste associated with glutamate). All are detected by {{c2::chemoreceptors}} sensitive to dissolved compounds in saliva — taste cannot occur without dissolution.', 2),

  (deck, 57, 'cloze',
   'Taste chemoreceptors are organized into clusters called {{c1::taste buds}}, located in small bumps on the tongue called {{c2::papillae}}. Taste signals travel through the brainstem to a {{c3::taste relay in the thalamus}}, then to higher cortical regions for processing.', 3),

  -- ── 14. Somatosensation ──────────────────────────────────
  (deck, 58, 'cloze',
   '{{c1::Somatosensation}} (touch and bodily sensation) is described as having four major modalities: {{c2::pressure, vibration, pain, and temperature}}. At least five distinct receptor types in skin and underlying tissue convey these signals to the CNS.', 2),

  (deck, 59, 'cloze',
   '{{c1::Pacinian corpuscles}} are large, deep-skin mechanoreceptors with a distinctive onion-like layered structure. They specialize for {{c2::deep pressure and high-frequency vibration}} and are rapidly adapting — they respond to changes in pressure but stop firing under sustained pressure.', 2),

  (deck, 60, 'cloze',
   '{{c1::Meissner corpuscles}} are clustered in the dermal papillae of glabrous (hairless) skin — fingertips, lips, palms. They detect {{c2::light touch and low-frequency vibration}}, supporting our acute tactile discrimination of textures and shapes.', 2),

  (deck, 61, 'cloze',
   '{{c1::Merkel cells}} are small, slowly adapting mechanoreceptors in the upper epidermis. They detect {{c2::sustained light pressure and texture}}, providing the slow-touch information that lets you maintain a continuous grip without re-checking it.', 2),

  (deck, 62, 'cloze',
   '{{c1::Ruffini endings}} are elongated mechanoreceptors located deeper in the dermis. They detect {{c2::stretching of the skin}} and contribute to the sense of finger position and joint movement during sustained grip.', 2),

  (deck, 63, 'cloze',
   '{{c1::Free nerve endings}} are the simplest tactile receptors — bare neuron tips with no specialized end-organ. They detect {{c2::pain and temperature}}, the most evolutionarily ancient somatosensory functions, and they function as both nociceptors and thermoreceptors.', 2),

  (deck, 64, 'cloze',
   'The {{c1::two-point threshold}} is the minimum distance between two points of skin contact such that they can be felt as {{c2::two distinct stimuli}} rather than one. The threshold varies enormously across the body — fingertips have very small two-point thresholds (high acuity), while the back has very large ones.', 2),

  (deck, 65, 'cloze',
   '{{c1::Physiological zero}} is the normal temperature of the skin used as the brain''s reference for thermal perception. Objects warmer than physiological zero are judged hot; objects cooler are judged cold — even though both may be at temperatures far from any absolute standard.', 1),

  (deck, 66, 'cloze',
   'Pain perception arises mainly from {{c1::nociceptor}} activation. The {{c2::gate theory of pain}} proposes a spinal-cord gating mechanism that can {{c3::amplify or suppress}} pain signals before they reach the brain — explaining why distraction, rubbing an injury, or psychological state can change perceived pain intensity from the same physical injury.', 3),

  (deck, 67, 'cloze',
   'The {{c1::kinesthetic sense (proprioception)}} is the perception of body position and movement in space. Its receptors, called {{c2::proprioceptors}}, sit mostly in {{c3::muscles, tendons, and joints}}, and they are essential for balance, hand-eye coordination, and skilled motor performance.', 3),

  -- ── 15. Object Recognition ───────────────────────────────
  (deck, 68, 'cloze',
   '{{c1::Bottom-up (data-driven)}} processing constructs perceptions starting from raw sensory features — analyzing individual stimuli and combining them into a whole. It is {{c2::slower but more accurate}}, and it is required when the stimulus is novel or unfamiliar.', 2),

  (deck, 69, 'cloze',
   '{{c1::Top-down (conceptually-driven)}} processing constructs perceptions starting from {{c2::memory and expectations}}, then fitting incoming sensory data into the predicted whole. It is {{c3::faster but more error-prone}} — perceptual illusions and misperceptions arise when the expectations are wrong.', 3),

  (deck, 70, 'cloze',
   '{{c1::Perceptual organization}} is the brain''s ability to combine bottom-up and top-down processing — together with all available sensory cues — into a coherent, integrated perception of an object or scene. It binds depth, form, motion, color, and context into a single unified experience.', 1),

  (deck, 71, 'cloze',
   '{{c1::Perceptual constancy}} is the ability to perceive certain stable properties of objects (size, shape, color, lightness) as {{c2::unchanged}} even when the proximal stimulus changes — for example, recognizing a friend''s face from any angle, or knowing a piece of paper is white whether seen in sunlight or shadow.', 2),

  -- ── 16. Depth Perception + Gestalt ───────────────────────
  (deck, 72, 'cloze',
   'Depth perception is supported by two classes of cues. {{c1::Monocular cues}} require only one eye and can be picked up from a 2D image — they are what allow paintings, photographs, and movies to convey depth. {{c2::Binocular cues}} require both eyes and provide the most accurate depth estimates for nearby objects.', 2),

  (deck, 73, 'cloze',
   '{{c1::Relative size}} is the monocular depth cue that {{c2::larger}} retinal images come from {{c3::closer}} objects, assuming similar real-world size. If you know two objects are roughly the same actual size, the one that projects a larger image must be closer.', 3),

  (deck, 74, 'cloze',
   '{{c1::Interposition (occlusion)}} is the monocular cue that an object which partially covers another must be {{c2::closer}} than the object it is blocking. This is a very strong cue — interposition almost never lies.', 2),

  (deck, 75, 'cloze',
   '{{c1::Linear perspective}} is the monocular cue that {{c2::parallel lines appear to converge}} as they recede into the distance. The greater the convergence, the greater the perceived depth — the classic railroad-tracks-meeting-at-the-horizon effect.', 2),

  (deck, 76, 'cloze',
   '{{c1::Motion parallax}} is the monocular cue that, as the observer moves, {{c2::closer objects appear to move faster}} across the field of view than distant objects. Looking out a car window, nearby telephone poles whip past while distant mountains hardly seem to move at all.', 2),

  (deck, 77, 'cloze',
   '{{c1::Retinal disparity}} is the most important binocular depth cue: the {{c2::slight difference between the images projected onto the two retinas}}. Because the eyes are horizontally separated, each eye sees a scene from a marginally different angle, and the visual cortex computes depth from the disparity. The {{c3::more disparate}} the two images, the {{c4::closer}} the object.', 4),

  (deck, 78, 'cloze',
   '{{c1::Convergence}} is the second binocular depth cue: the brain detects {{c2::how much the two eyes turn inward}} to focus on an object. Greater convergence means a closer object. The cue is effective at short distances but loses precision beyond a few meters, where the eyes are nearly parallel.', 2),

  (deck, 79, 'cloze',
   '{{c1::Gestalt psychology}} emphasizes that perception is fundamentally about organizing pieces into wholes. Several {{c2::Gestalt principles}} describe how the visual system groups raw elements into perceived objects and patterns.', 2),

  (deck, 80, 'cloze',
   'The Gestalt {{c1::law of proximity}} states that visual elements located {{c2::close together}} in space tend to be perceived as belonging to a single {{c3::group}}. Spatial nearness is a powerful organizing cue — even when the grouped elements are dissimilar in shape or color, proximity is often sufficient to bind them perceptually.', 3),

  (deck, 81, 'cloze',
   'The Gestalt {{c1::law of similarity}} states that visual elements sharing some property (color, shape, size) tend to be {{c2::grouped together}}, even when they are spatially separated. Color and shape similarity can override proximity to organize elements into perceptual groups.', 2),

  (deck, 82, 'cloze',
   'The Gestalt {{c1::law of good continuation}} states that elements arranged along a {{c2::smooth, continuous path}} tend to be perceived as a single unit. Two crossing lines are seen as two continuous lines rather than four meeting segments because each line follows a smoother continuation.', 2),

  (deck, 83, 'cloze',
   '{{c1::Subjective contours}} are perceived edges or shapes that have no physical counterpart in the stimulus. The classic example is the {{c2::Kanizsa triangle}}, where three notched circles create the illusion of a white triangle floating above them — the brain fills in contours that are not actually present.', 2),

  (deck, 84, 'cloze',
   'The Gestalt {{c1::law of closure}} states that the visual system tends to perceive {{c2::incomplete or partially-enclosed}} figures as complete, closed wholes. If a shape is mostly outlined with only small gaps, the brain mentally fills in the gaps and perceives a continuous boundary.', 2),

  (deck, 85, 'cloze',
   'The Gestalt law of {{c1::Prägnanz (good form)}} states that, given an ambiguous stimulus, perceptual organization will favor the {{c2::simplest, most regular, most symmetric}} interpretation possible. Prägnanz is the overarching principle from which the more specific Gestalt laws derive.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
