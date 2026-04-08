-- ============================================================================
-- Psych/Soc Chapter 2 Batch 2: Vision Advanced & Hearing/Vestibular
-- 50 MCAT-style questions (25 Vision Advanced + 25 Hearing & Vestibular)
-- ============================================================================

-- ============================================================================
-- VISION ADVANCED (Questions 1–25)
-- ============================================================================

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A neuroscience researcher records from individual neurons in the primary visual cortex of a cat. She finds that a specific neuron fires maximally when a vertical bar of light moves across a particular region of the visual field, but does not respond to stationary light or horizontal bars. This neuron is best described as a:',
  '[{"label": "A", "text": "Ganglion cell with a center-surround receptive field"},
    {"label": "B", "text": "Simple cell functioning as a feature detector"},
    {"label": "C", "text": "Magnocellular neuron tuned to color processing"},
    {"label": "D", "text": "Horizontal cell mediating lateral inhibition"}]',
  'B',
  'Simple cells in the primary visual cortex (V1) are classic feature detectors that respond to bars or edges of specific orientation in a particular location — exactly as described. A) Ganglion cells have center-surround receptive fields that respond to spots of light, not oriented bars; they are in the retina, not the cortex. C) Magnocellular neurons process motion and spatial information but are not tuned to color — and the described selectivity for orientation is a cortical feature detector property. D) Horizontal cells are retinal interneurons that mediate lateral inhibition between photoreceptors; they do not exhibit orientation selectivity.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A researcher compares two populations of lateral geniculate nucleus (LGN) neurons. Population X has small receptive fields and responds strongly to color differences, while Population Y has large receptive fields and responds best to rapidly flickering stimuli. Which correctly identifies these populations?',
  '[{"label": "A", "text": "X = magnocellular cells; Y = parvocellular cells"},
    {"label": "B", "text": "X = parvocellular cells; Y = magnocellular cells"},
    {"label": "C", "text": "X = rod bipolar cells; Y = cone bipolar cells"},
    {"label": "D", "text": "X = amacrine cells; Y = horizontal cells"}]',
  'B',
  'Parvocellular (P) cells have small receptive fields, are color-sensitive, and provide high spatial resolution — matching Population X. Magnocellular (M) cells have large receptive fields, are color-blind, and respond to rapid temporal changes (motion, flicker) — matching Population Y. A) This reverses the correct assignment. C) Rod and cone bipolar cells are retinal neurons, not LGN populations, and their properties do not map cleanly onto this description. D) Amacrine and horizontal cells are retinal interneurons involved in modulation, not LGN relay neurons.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A patient undergoing a visual field test is unable to detect a small light presented at exactly 15 degrees temporal to fixation in the right eye. All other regions of the visual field are normal. The most likely explanation is:',
  '[{"label": "A", "text": "Damage to the right optic nerve causing monocular blindness"},
    {"label": "B", "text": "The stimulus fell on the optic disc where photoreceptors are absent"},
    {"label": "C", "text": "Macular degeneration affecting the foveal cones"},
    {"label": "D", "text": "A lesion at the optic chiasm causing bitemporal hemianopia"}]',
  'B',
  'The blind spot (optic disc) is located approximately 15 degrees nasal on the retina, which corresponds to about 15 degrees temporal in the visual field. Since the optic nerve exits at this point, there are no photoreceptors, creating a natural scotoma. A) Optic nerve damage would cause complete monocular vision loss in that eye, not a single focal point of blindness. C) Macular degeneration affects central vision at fixation, not a point 15 degrees off-center. D) A chiasm lesion would produce bilateral temporal visual field loss, not a single small scotoma in one eye.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'During a dilated eye exam, an ophthalmologist uses a slit lamp to examine the structures of the anterior segment. She notes that the fluid between the cornea and the lens appears normal. This fluid is produced by which structure and drains through which pathway?',
  '[{"label": "A", "text": "Ciliary body; canal of Schlemm"},
    {"label": "B", "text": "Lacrimal gland; nasolacrimal duct"},
    {"label": "C", "text": "Choroid plexus; arachnoid granulations"},
    {"label": "D", "text": "Vitreous body; posterior chamber"}]',
  'A',
  'Aqueous humor fills the anterior and posterior chambers of the eye. It is produced by the ciliary body (specifically the ciliary epithelium) and drains through the trabecular meshwork into the canal of Schlemm. Blockage of this drainage causes increased intraocular pressure (glaucoma). B) The lacrimal gland produces tears that bathe the external eye surface and drain through the nasolacrimal duct — this is not intraocular fluid. C) The choroid plexus produces cerebrospinal fluid in the brain ventricles; arachnoid granulations are CNS structures unrelated to the eye. D) The vitreous body is the gel-like substance in the posterior segment; it is not produced and does not drain through the posterior chamber.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A 68-year-old patient has difficulty focusing on near objects but can see distant objects clearly. Her ophthalmologist explains that the lens has become rigid with age. During normal accommodation for near vision, what sequence of events occurs?',
  '[{"label": "A", "text": "Ciliary muscle relaxes → suspensory ligaments tighten → lens flattens"},
    {"label": "B", "text": "Ciliary muscle contracts → suspensory ligaments loosen → lens becomes rounder"},
    {"label": "C", "text": "Ciliary muscle contracts → suspensory ligaments tighten → lens becomes rounder"},
    {"label": "D", "text": "Ciliary muscle relaxes → suspensory ligaments loosen → lens flattens"}]',
  'B',
  'Accommodation for near vision requires: (1) contraction of the ciliary muscle, which (2) reduces tension on the suspensory ligaments (zonules), allowing (3) the elastic lens to become rounder (thicker), increasing its refractive power. In presbyopia, the lens loses elasticity and cannot thicken even when zonules relax. A) Ciliary muscle relaxation with tightened ligaments describes the state for distant vision, not near accommodation. C) The ligaments loosen (not tighten) when the ciliary muscle contracts — tightened ligaments would flatten the lens. D) This sequence is internally contradictory; relaxed ciliary muscle means taut ligaments, not loose ones.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A visual neuroscience experiment uses a prism to shift an image so that it falls exclusively on the nasal retina of the left eye and the temporal retina of the right eye. In which brain hemisphere will this visual information be primarily processed?',
  '[{"label": "A", "text": "Left hemisphere, because ipsilateral temporal fibers project there"},
    {"label": "B", "text": "Right hemisphere, because nasal fibers from the left eye cross at the chiasm"},
    {"label": "C", "text": "Both hemispheres equally, because one eye projects to each side"},
    {"label": "D", "text": "Left hemisphere, because nasal fibers from the left eye and temporal fibers from the right eye both project leftward"}]',
  'B',
  'Nasal retinal fibers cross at the optic chiasm, while temporal retinal fibers remain ipsilateral. Nasal fibers from the LEFT eye cross to the RIGHT hemisphere. Temporal fibers from the RIGHT eye stay in the RIGHT hemisphere. Therefore both inputs converge on the RIGHT hemisphere. This stimulus actually represents the LEFT visual field (which maps to nasal left retina and temporal right retina). A) Temporal fibers from the right eye project ipsilaterally to the right hemisphere, not the left. C) Both inputs go to the same hemisphere (right), not split equally. D) This incorrectly states the projection pattern — nasal fibers cross, they do not project ipsilaterally.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A patient presents with complete loss of the right visual field in both eyes following a stroke. An MRI reveals a lesion in the left hemisphere. Where is the most likely location of the lesion?',
  '[{"label": "A", "text": "Left optic nerve"},
    {"label": "B", "text": "Optic chiasm"},
    {"label": "C", "text": "Left optic tract or left visual cortex"},
    {"label": "D", "text": "Right optic tract"}]',
  'C',
  'Loss of the right visual field in BOTH eyes is called right homonymous hemianopia. The right visual field is processed by the left hemisphere (contralateral processing). A post-chiasmatic lesion on the left side — in the left optic tract, left LGN, left optic radiations, or left visual cortex — would eliminate input from the right visual field of both eyes. A) Left optic nerve damage would cause complete blindness in the LEFT eye only (monocular), not a hemianopia. B) Optic chiasm damage classically causes bitemporal hemianopia (loss of both temporal visual fields), not a homonymous deficit. D) Right optic tract damage would cause LEFT homonymous hemianopia, not right.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A patient with a pituitary tumor compressing the optic chiasm from below reports progressive visual field loss. Which pattern of visual field loss would be expected?',
  '[{"label": "A", "text": "Complete blindness in one eye"},
    {"label": "B", "text": "Loss of the temporal visual field in both eyes"},
    {"label": "C", "text": "Loss of the nasal visual field in both eyes"},
    {"label": "D", "text": "Loss of the right visual field in both eyes"}]',
  'B',
  'The optic chiasm is where nasal retinal fibers cross. Compression of the chiasm (commonly by a pituitary tumor) disrupts these crossing nasal fibers. Nasal retinal fibers carry information from the temporal visual field. Therefore, loss of nasal fibers from both eyes produces bitemporal hemianopia — loss of both temporal visual fields. A) Complete monocular blindness results from optic nerve damage, not chiasm compression. C) Loss of nasal visual fields (binasal hemianopia) would require bilateral lateral compression of the chiasm, which is extremely rare. D) Loss of the right visual field in both eyes (right homonymous hemianopia) results from post-chiasmatic damage on the left side.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A researcher studying retinal processing finds a cell type that receives input from multiple photoreceptors in a horizontal layer and produces graded potentials that inhibit adjacent photoreceptor outputs. This lateral interaction enhances the perception of edges and borders. This cell is most likely a:',
  '[{"label": "A", "text": "Bipolar cell that transmits signals vertically to ganglion cells"},
    {"label": "B", "text": "Amacrine cell that modulates ganglion cell responses to motion"},
    {"label": "C", "text": "Horizontal cell that mediates lateral inhibition for contrast enhancement"},
    {"label": "D", "text": "Ganglion cell with an on-center, off-surround receptive field"}]',
  'C',
  'Horizontal cells connect laterally across the retina, receiving input from photoreceptors and providing inhibitory feedback to neighboring photoreceptors. This lateral inhibition enhances contrast at edges and borders. They produce graded potentials (not action potentials). A) Bipolar cells transmit signals vertically from photoreceptors to ganglion cells and do not have the lateral connectivity described. B) Amacrine cells also operate laterally but primarily modulate interactions between bipolar and ganglion cells, particularly for motion detection — the description emphasizes photoreceptor-level lateral inhibition for edges. D) Ganglion cells produce action potentials (not graded potentials) and represent the output of retinal processing, not the lateral inhibition mechanism itself.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A neuroscientist studying retinal circuitry identifies a class of interneurons that synapse between bipolar cells and ganglion cells. These neurons are especially active when a stimulus moves across the visual field and help modulate the temporal dynamics of ganglion cell firing. These neurons are most likely:',
  '[{"label": "A", "text": "Horizontal cells, which enhance spatial contrast through lateral inhibition"},
    {"label": "B", "text": "Amacrine cells, which modulate motion detection in the inner retina"},
    {"label": "C", "text": "Muller glial cells, which provide structural support to the retina"},
    {"label": "D", "text": "Parvocellular neurons, which process fine detail and color"}]',
  'B',
  'Amacrine cells are interneurons in the inner plexiform layer (between bipolar and ganglion cells) that modulate temporal and motion-related signals. They are critical for detecting motion and adjusting the timing of ganglion cell responses. A) Horizontal cells operate in the outer plexiform layer between photoreceptors and bipolar cells — they mediate lateral inhibition for spatial contrast, not motion modulation between bipolar and ganglion cells. C) Muller glial cells provide structural and metabolic support; they are not interneurons involved in signal processing. D) Parvocellular neurons are in the LGN, not the retina, and they process color and fine spatial detail rather than motion.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A hiker walking through a forest suddenly sees a snake-like shape in her peripheral vision and reflexively turns her head toward it before consciously identifying the object. This rapid, reflexive visual orientation is most likely mediated by the:',
  '[{"label": "A", "text": "Primary visual cortex (V1) processing detailed form information"},
    {"label": "B", "text": "Inferior temporal cortex analyzing object identity"},
    {"label": "C", "text": "Superior colliculus coordinating reflexive eye and head movements toward visual stimuli"},
    {"label": "D", "text": "Lateral geniculate nucleus relaying color information to the cortex"}]',
  'C',
  'The superior colliculus is a midbrain structure that mediates reflexive orienting movements (saccades, head turns) toward sudden visual stimuli, especially in peripheral vision. It operates largely without conscious awareness and is faster than cortical processing. A) V1 processes detailed visual features but is not primarily responsible for reflexive orienting — its processing takes longer and supports conscious perception. B) The inferior temporal cortex is involved in object recognition (the "what" pathway), which occurs after the reflexive orientation has already happened. D) The LGN is a thalamic relay station that transmits visual information to the cortex; it does not directly coordinate motor responses to stimuli.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'An experiment measures how visual information is processed simultaneously through different cortical streams. A participant views a ball being thrown: they perceive its color, shape, motion, and location all at once. This simultaneous analysis of different visual attributes through separate neural pathways is called:',
  '[{"label": "A", "text": "Sensory adaptation"},
    {"label": "B", "text": "Parallel processing"},
    {"label": "C", "text": "Signal transduction"},
    {"label": "D", "text": "Sensory interaction"}]',
  'B',
  'Parallel processing refers to the brain''s ability to simultaneously analyze multiple aspects of a visual scene (color, form, motion, depth) through separate neural pathways. The ventral stream processes "what" (form, color) while the dorsal stream processes "where/how" (motion, spatial location). A) Sensory adaptation is the decreased sensitivity to an unchanging stimulus over time, not simultaneous multi-attribute processing. C) Signal transduction is the conversion of one type of signal to another (e.g., light to neural impulse in photoreceptors) — a molecular process, not a systems-level processing strategy. D) Sensory interaction refers to how one sense influences another (e.g., smell affecting taste), not how different aspects of a single sense are processed simultaneously.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A researcher presents two slightly different images — one to each eye — through a stereoscope. The participant perceives a single three-dimensional scene. Which depth cue is primarily responsible for this perception?',
  '[{"label": "A", "text": "Linear perspective, a monocular cue from converging parallel lines"},
    {"label": "B", "text": "Motion parallax, where closer objects move faster across the visual field"},
    {"label": "C", "text": "Retinal disparity, the difference in images between the two eyes"},
    {"label": "D", "text": "Relative size, where smaller objects appear farther away"}]',
  'C',
  'Retinal (binocular) disparity is the slight difference between the images projected on each retina due to the horizontal separation of the eyes. The brain uses this disparity to compute depth, creating stereoscopic 3D perception. A stereoscope works by presenting slightly offset images to each eye, directly exploiting this cue. A) Linear perspective is a monocular (pictorial) cue — it works with just one eye and does not require two different images. B) Motion parallax is a monocular cue that requires head or body movement; it does not depend on binocular differences. D) Relative size is a monocular cue based on known object sizes; it does not require two separate retinal images.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A student covers one eye and looks down a long corridor. Despite using only monocular vision, she can still perceive that the end of the corridor is farther away than the door next to her. Which combination of monocular depth cues best explains this perception?',
  '[{"label": "A", "text": "Retinal disparity and convergence"},
    {"label": "B", "text": "Linear perspective and relative size"},
    {"label": "C", "text": "Accommodation and retinal disparity"},
    {"label": "D", "text": "Convergence and motion parallax"}]',
  'B',
  'With one eye covered, only monocular cues are available. In a corridor, walls appear to converge toward a vanishing point (linear perspective), and objects at the far end appear smaller than nearby objects (relative size). Both are powerful monocular/pictorial depth cues. A) Retinal disparity and convergence are both binocular cues requiring two eyes — they are unavailable with one eye covered. C) Retinal disparity is binocular and thus unavailable; while accommodation is monocular, it is only effective at very short distances and would not explain corridor depth perception. D) Convergence is binocular (unavailable), and while motion parallax is monocular, it requires head movement, which is not described.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A patient views a friend walking away down a sidewalk. Although the retinal image of the friend shrinks progressively, the patient continues to perceive the friend as the same height. This phenomenon is best explained by:',
  '[{"label": "A", "text": "Feature detection in the primary visual cortex"},
    {"label": "B", "text": "Size constancy, maintaining stable perception despite changing retinal image size"},
    {"label": "C", "text": "Dark adaptation increasing rod sensitivity"},
    {"label": "D", "text": "The opponent-process theory of color vision"}]',
  'B',
  'Size constancy is the perceptual ability to recognize that an object''s actual size remains the same even as its retinal image changes with distance. The brain uses depth cues and prior knowledge to maintain stable size perception. A) Feature detectors in V1 respond to edges and orientations; they do not account for the higher-order perceptual correction of maintaining constant size across distances. C) Dark adaptation involves rods becoming more sensitive in low light — it is completely unrelated to size perception. D) Opponent-process theory explains color perception through antagonistic color pairs (red-green, blue-yellow) and has nothing to do with size perception.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A vision researcher studies a patient who can perceive fine detail and color in bright light but has severely impaired vision in dim environments. According to the duplicity theory of vision, which photoreceptor system is most likely dysfunctional?',
  '[{"label": "A", "text": "Cones, which are responsible for high-acuity color vision in bright light"},
    {"label": "B", "text": "Rods, which are responsible for vision in low-light conditions"},
    {"label": "C", "text": "Both rods and cones, since they work cooperatively in all lighting conditions"},
    {"label": "D", "text": "Ganglion cells, which transmit all photoreceptor signals to the brain"}]',
  'B',
  'Duplicity theory states that the retina has two photoreceptor systems: rods (sensitive to dim light, no color, low acuity) and cones (require bright light, color vision, high acuity). Since this patient has normal cone function (fine detail and color in bright light) but impaired dim-light vision, the rod system is dysfunctional. This is consistent with conditions like retinitis pigmentosa. A) Cone dysfunction would impair color vision and acuity in bright light, which are preserved in this patient. C) If both systems were dysfunctional, the patient would have impairment in all lighting conditions, not just dim environments. D) Ganglion cell dysfunction would affect transmission of ALL visual signals regardless of lighting condition, not selectively impair dim-light vision.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A researcher presents a moving stimulus to a participant and records from neurons in the visual cortex. She finds neurons in area V5/MT that respond strongly to the direction and speed of the moving stimulus. Meanwhile, neurons in area V4 respond strongly to the stimulus''s color. This pattern best illustrates:',
  '[{"label": "A", "text": "Serial processing, where motion is analyzed before color"},
    {"label": "B", "text": "Bottom-up processing, where raw sensory data drives all perception"},
    {"label": "C", "text": "Parallel processing, where different visual attributes are analyzed simultaneously in separate cortical areas"},
    {"label": "D", "text": "Sensory adaptation, where neurons habituate to repeated stimuli"}]',
  'C',
  'The visual system uses parallel processing — different cortical areas simultaneously analyze different stimulus attributes. Area V5/MT specializes in motion, while V4 specializes in color. These operate concurrently, not sequentially. A) Serial processing would mean one attribute is fully analyzed before the next begins; here, both are processed simultaneously in different areas. B) While bottom-up processing does involve raw sensory data driving perception, the key phenomenon described is the simultaneous specialization of different cortical areas — parallel processing. D) Sensory adaptation involves decreased neural response to unchanging stimuli, which is not what is described.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A neurologist tests a patient''s visual fields and finds that the patient cannot see anything in the left visual field of the left eye. The right eye visual fields are completely intact. The most likely site of damage is:',
  '[{"label": "A", "text": "The left optic nerve"},
    {"label": "B", "text": "The optic chiasm"},
    {"label": "C", "text": "The right optic tract"},
    {"label": "D", "text": "The right visual cortex"}]',
  'A',
  'Complete loss of vision in only one eye (all visual fields in the left eye) with the other eye intact indicates damage to the optic nerve of the affected eye — in this case, the left optic nerve. The left optic nerve carries ALL visual information from the left eye (both nasal and temporal visual fields) before fibers separate at the chiasm. A) This is the correct answer — left optic nerve damage causes total monocular blindness in the left eye. B) Chiasm damage would affect BOTH eyes (typically bitemporal hemianopia), not just one eye. C) Right optic tract damage would cause left homonymous hemianopia — loss of the left visual field in BOTH eyes, not blindness in one eye. D) Right visual cortex damage would also produce left homonymous hemianopia affecting both eyes.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'An artist painting outdoors notices that a white sheet of paper appears white in both bright sunlight and in the shade of a tree, despite the dramatic difference in wavelengths reflected under each condition. This perception is best explained by:',
  '[{"label": "A", "text": "Color constancy, where the visual system adjusts for changes in illumination"},
    {"label": "B", "text": "The trichromatic theory of color vision"},
    {"label": "C", "text": "Dark adaptation of rod photoreceptors"},
    {"label": "D", "text": "Retinal disparity between the two eyes"}]',
  'A',
  'Color constancy is the tendency to perceive an object as having a consistent color even when the wavelength composition of the illuminating light changes. The visual system accounts for the ambient lighting conditions to maintain stable color perception. A) This is the correct answer. B) Trichromatic theory explains that color vision arises from three types of cones (red, green, blue), but it does not explain why perceived color remains stable across different lighting conditions. C) Dark adaptation involves rod sensitivity increasing in dim light — it relates to light/dark detection, not maintaining color perception across illumination changes. D) Retinal disparity is a binocular depth cue and has nothing to do with color perception or illumination compensation.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'In a perception lab, a participant views a scene through a window. A door partially blocks the view of a tree behind it. The participant perceives the door as closer than the tree. The participant then closes one eye and still perceives the depth relationship. Which monocular cue is the participant relying on?',
  '[{"label": "A", "text": "Convergence, based on the inward rotation of both eyes"},
    {"label": "B", "text": "Retinal disparity, based on the difference in images between both eyes"},
    {"label": "C", "text": "Interposition (occlusion), where the nearer object partially blocks the farther one"},
    {"label": "D", "text": "Accommodation, based on the lens shape changing for different distances"}]',
  'C',
  'Interposition (also called occlusion or overlap) is a monocular depth cue in which a closer object partially blocks the view of a more distant object. Since the door occludes part of the tree, the brain interprets the door as nearer. This cue works with one eye closed. A) Convergence is a binocular cue requiring both eyes to rotate inward; it is unavailable with one eye closed. B) Retinal disparity requires input from both eyes to compare slightly different images; also unavailable with one eye. D) Accommodation (lens shape changes) is technically monocular but is effective only at very short distances (within arm''s reach) and would not be the primary cue for a scene viewed through a window.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A glaucoma patient has elevated intraocular pressure. The ophthalmologist explains that this is caused by impaired drainage of a fluid that continuously circulates through the anterior chamber. Which of the following correctly describes this fluid and the consequence of its impaired drainage?',
  '[{"label": "A", "text": "Vitreous humor accumulates, compressing the retina and causing detachment"},
    {"label": "B", "text": "Aqueous humor cannot drain properly, increasing pressure that can damage the optic nerve"},
    {"label": "C", "text": "Cerebrospinal fluid leaks into the eye, compressing the lens"},
    {"label": "D", "text": "Lacrimal fluid builds up inside the eye, causing corneal swelling"}]',
  'B',
  'Aqueous humor is the clear fluid produced by the ciliary body that fills the anterior and posterior chambers. It normally drains through the trabecular meshwork into the canal of Schlemm. When drainage is impaired, intraocular pressure rises, which can compress and damage the optic nerve, leading to glaucoma. A) Vitreous humor is the gel-like substance in the posterior cavity; it does not circulate or drain through the anterior chamber, and its accumulation is not the mechanism of glaucoma. C) Cerebrospinal fluid is confined to the central nervous system and does not normally enter the eye. D) Lacrimal fluid (tears) bathes the external eye surface and does not circulate within the eye''s chambers.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A researcher studying binocular vision asks participants to fixate on a nearby pen held at arm''s length and notes the degree to which both eyes rotate inward. She then moves the pen closer and observes increased inward rotation. This binocular depth cue is known as:',
  '[{"label": "A", "text": "Retinal disparity, the difference in retinal images between both eyes"},
    {"label": "B", "text": "Convergence, the inward rotation of the eyes when focusing on near objects"},
    {"label": "C", "text": "Motion parallax, the relative movement of objects at different distances"},
    {"label": "D", "text": "Linear perspective, the apparent convergence of parallel lines"}]',
  'B',
  'Convergence is a binocular depth cue based on the degree of inward rotation of the eyes when focusing on objects at different distances. Closer objects require more convergence (greater inward rotation), and the brain uses this muscular feedback as a depth cue. A) Retinal disparity is the difference between the images on each retina, not the muscular rotation of the eyes; while both are binocular cues, the scenario specifically describes eye rotation. C) Motion parallax is a monocular cue requiring head movement; it does not involve inward eye rotation. D) Linear perspective is a monocular/pictorial cue involving converging lines in a scene, not eye muscle rotation.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A patient with damage to the magnocellular pathway has difficulty perceiving which of the following?',
  '[{"label": "A", "text": "Fine spatial detail in a photograph"},
    {"label": "B", "text": "Color differences between two adjacent objects"},
    {"label": "C", "text": "A ball being thrown rapidly across the visual field"},
    {"label": "D", "text": "Small letters on an eye chart at 20 feet"}]',
  'C',
  'The magnocellular pathway processes motion, rapid temporal changes, and coarse spatial information. Damage would impair the ability to perceive fast-moving objects like a ball in flight. A) Fine spatial detail is processed by the parvocellular pathway, which has high spatial resolution — this would be unaffected by magnocellular damage. B) Color differences are processed by the parvocellular pathway, not the magnocellular pathway (which is largely color-blind). D) Reading small letters requires high spatial resolution, which is a parvocellular function.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A passenger on a train looks out the window and notices that nearby fences appear to rush past quickly while distant mountains appear to move slowly in the same direction as the train. This depth cue is best described as:',
  '[{"label": "A", "text": "Retinal disparity"},
    {"label": "B", "text": "Shape constancy"},
    {"label": "C", "text": "Motion parallax"},
    {"label": "D", "text": "Relative height"}]',
  'C',
  'Motion parallax is a monocular depth cue in which objects at different distances appear to move at different speeds relative to the observer during self-motion. Near objects appear to move quickly in the opposite direction of travel, while distant objects appear to move slowly or in the same direction. A) Retinal disparity is a binocular cue based on the difference in retinal images between the two eyes; it does not involve apparent motion of objects. B) Shape constancy is the tendency to perceive an object''s shape as consistent despite changes in viewing angle; it is unrelated to motion-based depth perception. D) Relative height refers to objects higher in the visual field appearing more distant; it is a static pictorial cue, not a motion-based one.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Vision',
  'A vision scientist records from neurons in the fovea and the peripheral retina of a human donor. Compared to the periphery, the fovea shows a much higher density of one photoreceptor type and a lower convergence ratio (fewer photoreceptors per ganglion cell). What is the functional consequence of this arrangement?',
  '[{"label": "A", "text": "The fovea has better motion sensitivity due to high rod density and temporal summation"},
    {"label": "B", "text": "The fovea has greater visual acuity due to high cone density and dedicated ganglion cell connections"},
    {"label": "C", "text": "The fovea has better dim-light vision due to the low convergence ratio reducing signal noise"},
    {"label": "D", "text": "The periphery has better color discrimination because of widespread cone distribution"}]',
  'B',
  'The fovea is densely packed with cones and has a very low convergence ratio — in the foveal center, each cone connects to its own bipolar cell and ganglion cell, providing maximum spatial resolution (visual acuity). A) The fovea has virtually no rods; motion sensitivity from temporal summation is a peripheral retina characteristic. C) Dim-light vision depends on rods and high convergence (spatial summation), which are features of the periphery, not the fovea. D) The periphery is dominated by rods, not cones, so it has poor color discrimination; color vision is best at the fovea where cones are concentrated.',
  'hard'
);

-- ============================================================================
-- HEARING & VESTIBULAR (Questions 26–50)
-- ============================================================================

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A patient presents with conductive hearing loss. An audiologist determines that the ossicles are not transmitting vibrations effectively. Which step in the auditory transduction pathway is directly impaired?',
  '[{"label": "A", "text": "Sound waves are not being collected by the pinna"},
    {"label": "B", "text": "Mechanical amplification of vibrations from the tympanic membrane to the oval window is reduced"},
    {"label": "C", "text": "Hair cells in the organ of Corti are failing to depolarize"},
    {"label": "D", "text": "The auditory nerve is unable to transmit action potentials to the brain"}]',
  'B',
  'The ossicles (malleus, incus, stapes) amplify vibrations from the tympanic membrane and transmit them to the oval window. When ossicles malfunction (e.g., otosclerosis), this mechanical amplification is impaired, causing conductive hearing loss. A) The pinna collects sound waves from the environment; this step occurs before the ossicles and is not described as impaired. C) Hair cell depolarization occurs in the organ of Corti (inner ear); this represents sensorineural function, not the mechanical conduction that the ossicles perform. D) Auditory nerve transmission is a neural step downstream of the ossicles; impairment here would be sensorineural hearing loss, not conductive.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A researcher studies hair cell responses along the basilar membrane. She finds that hair cells near the base respond maximally to a 10,000 Hz tone, while hair cells near the apex respond maximally to a 200 Hz tone. This pattern of frequency coding is best explained by:',
  '[{"label": "A", "text": "Frequency theory, which states hair cells fire at the same rate as the sound frequency"},
    {"label": "B", "text": "Place theory, which states different locations on the basilar membrane respond to different frequencies"},
    {"label": "C", "text": "Volley principle, which states neurons take turns firing to encode high frequencies"},
    {"label": "D", "text": "Temporal coding, which states frequency is encoded by the timing of neural spikes"}]',
  'B',
  'Place theory (Helmholtz) proposes that different frequencies maximally stimulate different locations on the basilar membrane: high frequencies stimulate the base (narrow, stiff), and low frequencies stimulate the apex (wide, flexible). This tonotopic organization is exactly what the researcher observed. A) Frequency theory proposes that the entire basilar membrane vibrates at the frequency of the sound, with hair cells firing at that rate — it does not explain location-specific responses. C) The volley principle explains how groups of neurons can collectively encode frequencies above 1000 Hz by firing in alternating volleys, but it does not explain differential location-based activation. D) Temporal coding is another term for frequency-based encoding through spike timing, not the spatial coding described.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A neuroscientist records from auditory nerve fibers in response to a 3,000 Hz pure tone. She observes that while no single fiber fires at 3,000 times per second, groups of fibers take turns firing in a coordinated pattern that collectively represents the 3,000 Hz frequency. This encoding mechanism is best described by the:',
  '[{"label": "A", "text": "Place theory, where frequency is determined by the location of basilar membrane stimulation"},
    {"label": "B", "text": "Frequency theory, where individual neurons fire at the exact rate of the sound frequency"},
    {"label": "C", "text": "Volley principle, where groups of neurons alternate firing to represent frequencies above individual neuron firing limits"},
    {"label": "D", "text": "Gate control theory, where neural signals are modulated at the spinal cord level"}]',
  'C',
  'The volley principle explains how the auditory system encodes frequencies between approximately 1,000–5,000 Hz: since individual neurons cannot fire faster than about 1,000 times per second, groups of neurons alternate (volley) their firing so that the collective pattern matches the stimulus frequency. A) Place theory explains frequency coding by location on the basilar membrane (best for high frequencies above 5,000 Hz); it does not describe the coordinated firing pattern of neuron groups. B) Frequency theory proposes individual neurons fire at the stimulus rate, but neurons cannot fire at 3,000 Hz individually — this theory only works for frequencies below about 1,000 Hz. D) Gate control theory pertains to pain perception modulation, not auditory frequency encoding.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A patient exposed to a loud explosion at a construction site experiences immediate hearing loss and is found to have damaged hair cells in the organ of Corti. Which structure directly performs auditory transduction — converting mechanical vibrations into neural signals?',
  '[{"label": "A", "text": "The tympanic membrane, which vibrates in response to sound waves"},
    {"label": "B", "text": "The ossicles, which amplify and transmit vibrations to the inner ear"},
    {"label": "C", "text": "Hair cells in the organ of Corti, whose stereocilia deflection opens ion channels"},
    {"label": "D", "text": "The auditory cortex in the temporal lobe, which interprets neural impulses as sound"}]',
  'C',
  'Auditory transduction occurs in the organ of Corti, where inner hair cells convert mechanical vibrations into electrical signals. When the basilar membrane vibrates, stereocilia on hair cells are deflected, opening mechanically gated ion channels that trigger depolarization and neurotransmitter release onto auditory nerve fibers. A) The tympanic membrane converts airborne sound waves to mechanical vibrations but does not perform transduction into neural signals. B) The ossicles amplify mechanical vibrations and deliver them to the oval window — this is mechanical transmission, not transduction. D) The auditory cortex processes and interprets neural signals that have already been transduced; it is the endpoint of auditory processing, not the site of transduction.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'An elderly patient complains of difficulty hearing high-pitched consonant sounds (like "s," "f," and "th") while low-pitched vowels remain audible. Audiometric testing confirms high-frequency hearing loss. Based on the tonotopic organization of the basilar membrane, which region is most likely damaged?',
  '[{"label": "A", "text": "The apex of the basilar membrane, which is wide and flexible"},
    {"label": "B", "text": "The base of the basilar membrane, which is narrow and stiff"},
    {"label": "C", "text": "The middle of the basilar membrane, encoding mid-range frequencies"},
    {"label": "D", "text": "The entire basilar membrane uniformly, indicating global cochlear degeneration"}]',
  'B',
  'The basilar membrane is tonotopically organized: high frequencies are encoded at the base (which is narrow and stiff), and low frequencies at the apex (which is wide and flexible). High-frequency hearing loss (presbycusis) typically results from damage to the basal region. A) The apex encodes low frequencies; damage here would impair low-pitched sounds, not the high-pitched consonants this patient struggles with. C) Mid-membrane damage would affect mid-range frequencies; the patient specifically has high-frequency loss with preserved low frequencies. D) Uniform damage would cause hearing loss across all frequencies, not the selective high-frequency loss described.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A patient with Meniere''s disease experiences episodes of intense vertigo and nausea. The physician explains that excessive endolymph fluid in the inner ear is disrupting the vestibular organs. Which structures detect rotational head movements and are most likely contributing to the vertigo?',
  '[{"label": "A", "text": "The utricle and saccule, which detect linear acceleration and head tilt"},
    {"label": "B", "text": "The semicircular canals, which detect rotational acceleration in three planes"},
    {"label": "C", "text": "The organ of Corti, which contains hair cells for sound transduction"},
    {"label": "D", "text": "The ossicles, which amplify sound vibrations in the middle ear"}]',
  'B',
  'The three semicircular canals are oriented in three perpendicular planes and detect rotational (angular) acceleration of the head. When excess endolymph disrupts their function, the brain receives false signals about head rotation, causing vertigo. A) The utricle and saccule detect linear acceleration and static head position (gravity), not rotational movement. While they may also be affected in Meniere''s disease, the vertigo (spinning sensation) is primarily attributed to semicircular canal dysfunction. C) The organ of Corti is the auditory transduction organ; its dysfunction would cause hearing loss, not vertigo. D) The ossicles are middle ear bones for sound amplification; they have no vestibular function.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'An astronaut in the International Space Station notices that she has difficulty sensing which way is "up" and frequently experiences spatial disorientation. Which vestibular organs are most affected by the microgravity environment, and why?',
  '[{"label": "A", "text": "Semicircular canals, because they rely on gravity to detect rotational movement"},
    {"label": "B", "text": "Utricle and saccule, because their otoliths depend on gravity to stimulate hair cells for detecting linear acceleration and head tilt"},
    {"label": "C", "text": "The organ of Corti, because sound waves propagate differently without gravity"},
    {"label": "D", "text": "The tympanic membrane, because it cannot vibrate properly in a vacuum"}]',
  'B',
  'The utricle and saccule contain otoliths (calcium carbonate crystals) embedded in a gelatinous membrane above hair cells. On Earth, gravity pulls the otoliths downward, bending hair cells to signal head position relative to gravity. In microgravity, otoliths no longer deflect hair cells appropriately, disrupting the sense of "up" vs. "down." A) Semicircular canals detect rotational acceleration via endolymph flow, which does not depend on gravity — they still function in microgravity when the head rotates. C) The organ of Corti transduces sound; sound propagation in air is not significantly affected by microgravity (the ISS has air). D) The ISS is pressurized with air, not a vacuum, so the tympanic membrane functions normally.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A gymnast performing a series of flips and spins can maintain spatial awareness and balance throughout her routine. Which combination of sensory systems is she MOST relying on for this ability?',
  '[{"label": "A", "text": "Auditory processing and olfaction"},
    {"label": "B", "text": "Vestibular sense and kinesthetic (proprioceptive) sense"},
    {"label": "C", "text": "Gustation and tactile pressure sensing"},
    {"label": "D", "text": "Nociception and thermoception"}]',
  'B',
  'The vestibular system (semicircular canals for rotation, utricle and saccule for linear acceleration) provides information about head position and movement in space. The kinesthetic/proprioceptive sense (from receptors in muscles, tendons, and joints) provides information about body position and limb placement. Together, these allow the gymnast to maintain spatial orientation during complex movements. A) Auditory and olfactory processing are not primary contributors to balance and spatial orientation during movement. C) Gustation (taste) and tactile pressure are irrelevant to spatial awareness during flips and spins. D) Nociception (pain) and thermoception (temperature) provide protective information but do not contribute to balance or spatial orientation.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'During auditory processing, a 500 Hz tone causes individual hair cells and their associated auditory nerve fibers to fire at a rate of 500 action potentials per second, directly matching the stimulus frequency. This encoding mechanism is best described by:',
  '[{"label": "A", "text": "Place theory, where frequency is encoded by the position of stimulation on the basilar membrane"},
    {"label": "B", "text": "Frequency theory, where the firing rate of auditory nerve fibers matches the frequency of the sound"},
    {"label": "C", "text": "Volley principle, where groups of neurons alternate firing to encode the frequency"},
    {"label": "D", "text": "Signal detection theory, where the ability to detect a stimulus depends on its intensity and noise"}]',
  'B',
  'Frequency theory (Rutherford) proposes that the basilar membrane vibrates as a whole, and auditory nerve fibers fire at a rate equal to the frequency of the stimulus. This works well for low frequencies (below ~1,000 Hz) where individual neurons can fire fast enough. At 500 Hz, individual neurons can match this rate. A) Place theory relies on different locations on the basilar membrane being stimulated by different frequencies — the scenario describes rate-matching, not location-specific activation. C) The volley principle involves groups of neurons coordinating their firing because individual neurons cannot fire fast enough; at 500 Hz, individual neurons can still match the rate, so the volley principle is unnecessary. D) Signal detection theory is a psychophysics concept about detecting stimuli amid noise; it does not describe neural frequency encoding.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A patient with damage to the left auditory cortex reports difficulty processing speech. The auditory cortex is located in which brain region?',
  '[{"label": "A", "text": "The frontal lobe, near Broca''s area"},
    {"label": "B", "text": "The temporal lobe, along the superior temporal gyrus"},
    {"label": "C", "text": "The parietal lobe, near the somatosensory cortex"},
    {"label": "D", "text": "The occipital lobe, adjacent to the primary visual cortex"}]',
  'B',
  'The primary auditory cortex is located in the temporal lobe, specifically in the superior temporal gyrus (Brodmann areas 41 and 42). This is where auditory information from the medial geniculate nucleus of the thalamus is first processed cortically. A) The frontal lobe houses Broca''s area (speech production), not the primary auditory cortex. While speech processing involves both regions, the question asks specifically about the auditory cortex location. C) The parietal lobe contains somatosensory cortex for processing touch and body position, not auditory information. D) The occipital lobe is dedicated to visual processing and is anatomically distant from auditory processing areas.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A researcher studying the inner ear finds two distinct fluid compartments in the cochlea. One fluid, rich in potassium ions, fills the scala media and bathes the apical surfaces of hair cells. The other fluid, similar in composition to cerebrospinal fluid, fills the scala vestibuli and scala tympani. These fluids are:',
  '[{"label": "A", "text": "Aqueous humor and vitreous humor"},
    {"label": "B", "text": "Perilymph (K+-poor, Na+-rich) and endolymph (K+-rich, Na+-poor)"},
    {"label": "C", "text": "Endolymph (K+-poor) and perilymph (K+-rich)"},
    {"label": "D", "text": "Cerebrospinal fluid in both compartments with different protein concentrations"}]',
  'B',
  'The cochlea contains two types of fluid: perilymph (found in scala vestibuli and scala tympani), which is similar to extracellular fluid/CSF with high Na+ and low K+; and endolymph (found in scala media/cochlear duct), which uniquely has high K+ and low Na+. The high K+ concentration in endolymph is critical because K+ influx drives hair cell depolarization when mechanically gated channels open. A) Aqueous and vitreous humor are found in the eye, not the ear. C) This reverses the ion compositions — endolymph is K+-rich, not K+-poor. D) While perilymph resembles CSF, endolymph has a very different ionic composition (high K+), and they are not the same fluid with different protein concentrations.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A sound engineer explains that the outer ear structure helps collect sound waves and funnel them toward the ear canal. This external, visible part of the ear is called the:',
  '[{"label": "A", "text": "Tympanic membrane, which vibrates in response to sound pressure waves"},
    {"label": "B", "text": "Pinna (auricle), which collects and directs sound into the auditory canal"},
    {"label": "C", "text": "Oval window, which transmits vibrations from the ossicles to the cochlea"},
    {"label": "D", "text": "Eustachian tube, which equalizes pressure between the middle ear and throat"}]',
  'B',
  'The pinna (auricle) is the visible external ear structure made of cartilage and skin. It collects sound waves from the environment and funnels them into the external auditory canal, also helping with sound localization. A) The tympanic membrane (eardrum) is at the boundary between the outer and middle ear; it is internal and not visible externally. C) The oval window is a membrane at the boundary between the middle and inner ear, deep within the skull. D) The Eustachian tube connects the middle ear to the nasopharynx for pressure equalization; it is not an external structure and does not collect sound.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A biomedical engineer designs a cochlear implant that bypasses damaged hair cells and directly stimulates the auditory nerve. For the implant to reproduce the tonotopic coding of frequency, electrodes stimulating the basal region of the cochlea should encode which type of sounds?',
  '[{"label": "A", "text": "Low-frequency sounds, because the base of the basilar membrane is most responsive to low pitches"},
    {"label": "B", "text": "High-frequency sounds, because the base of the basilar membrane is narrow and stiff, resonating with high frequencies"},
    {"label": "C", "text": "All frequencies equally, because the base of the cochlea processes the full range of hearing"},
    {"label": "D", "text": "Only speech frequencies, because the base is specialized for language processing"}]',
  'B',
  'Tonotopic organization of the basilar membrane means the base (narrow, stiff) responds to high frequencies and the apex (wide, flexible) responds to low frequencies. A cochlear implant must match this organization: basal electrodes encode high-frequency sounds. A) Low frequencies are encoded at the apex, not the base. C) The base does not process all frequencies equally — it is specifically tuned to high frequencies. D) The basilar membrane is not specialized by content type (speech vs. non-speech); it is organized by frequency. Speech sounds span a range of frequencies distributed along the entire membrane.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A patient reports that after spinning in a chair for 30 seconds and then suddenly stopping, they feel as though the room continues to spin. This illusory sensation is best explained by:',
  '[{"label": "A", "text": "Continued movement of endolymph in the semicircular canals after the body stops, causing hair cells to remain deflected"},
    {"label": "B", "text": "Otolith displacement in the utricle detecting ongoing linear acceleration"},
    {"label": "C", "text": "Damage to the auditory nerve causing misinterpretation of vestibular signals"},
    {"label": "D", "text": "Visual persistence in the occipital cortex creating an afterimage of the spinning room"}]',
  'A',
  'When spinning stops suddenly, the endolymph within the semicircular canals continues to flow due to inertia, deflecting the cupula and hair cells. This sends a false signal that rotation is continuing, creating the sensation of the room spinning (vertigo). The sensation fades as endolymph friction brings it to rest. B) Otoliths in the utricle detect linear acceleration and head tilt, not rotational movement. They would not produce the spinning sensation described. C) There is no auditory nerve damage described; this is a normal physiological phenomenon caused by endolymph inertia. D) While visual input contributes to the overall sensation, the primary driver is vestibular — the spinning feeling persists even with eyes closed, confirming it is endolymph-mediated, not a visual afterimage.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'In the process of hearing, sound vibrations must be transmitted from an air-filled space (middle ear) to a fluid-filled space (cochlea). The ossicles solve the impedance mismatch problem primarily through:',
  '[{"label": "A", "text": "Increasing the frequency of sound vibrations to match the resonant frequency of cochlear fluid"},
    {"label": "B", "text": "Concentrating the force from the large tympanic membrane onto the much smaller oval window, amplifying pressure"},
    {"label": "C", "text": "Converting sound waves into electrical signals before they reach the cochlea"},
    {"label": "D", "text": "Filtering out low-frequency sounds that cannot travel through fluid"}]',
  'B',
  'The ossicles solve the impedance mismatch (air-to-fluid transmission would normally lose ~99% of sound energy) primarily by concentrating force from the large tympanic membrane (~55 mm²) onto the much smaller oval window (~3.2 mm²). This area ratio, combined with the lever action of the ossicular chain, amplifies pressure approximately 22-fold. A) The ossicles do not change the frequency of vibrations; they preserve frequency while amplifying pressure. C) The ossicles perform mechanical (not electrical) transduction — electrical conversion occurs at the hair cells. D) The ossicles transmit all audible frequencies; they do not selectively filter out low frequencies.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A dancer performing a pirouette keeps her balance by using information from her vestibular system, vision, and proprioceptors. The proprioceptive information about the position and movement of her limbs comes from receptors located primarily in:',
  '[{"label": "A", "text": "The semicircular canals and vestibular nerve"},
    {"label": "B", "text": "Muscles, tendons, and joint capsules"},
    {"label": "C", "text": "The basilar membrane of the cochlea"},
    {"label": "D", "text": "The retina and optic nerve"}]',
  'B',
  'Proprioception (kinesthetic sense) relies on mechanoreceptors in muscles (muscle spindles), tendons (Golgi tendon organs), and joint capsules that provide information about body position, limb movement, and muscle tension. A) The semicircular canals and vestibular nerve provide vestibular information (head rotation and acceleration), not proprioceptive information about limb position. While both contribute to balance, they are different sensory systems. C) The basilar membrane is part of the auditory system and has no role in proprioception. D) The retina and optic nerve are part of the visual system; while vision contributes to balance, it is not proprioception.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A researcher examines the stereocilia on inner ear hair cells under an electron microscope. She observes that the stereocilia are arranged in a staircase-like pattern from shortest to tallest. When sound vibrations deflect the stereocilia toward the tallest row, what occurs at the molecular level?',
  '[{"label": "A", "text": "Voltage-gated sodium channels open, generating an action potential in the hair cell"},
    {"label": "B", "text": "Tip links between stereocilia are stretched, opening mechanically gated potassium channels and depolarizing the cell"},
    {"label": "C", "text": "Gap junctions between hair cells close, preventing lateral signal spread"},
    {"label": "D", "text": "Calcium pumps actively transport ions out of the cell, causing hyperpolarization"}]',
  'B',
  'When stereocilia deflect toward the tallest row, protein filaments called tip links connecting adjacent stereocilia are stretched. This mechanical tension opens mechanically gated cation channels (primarily K+ channels). Because the endolymph bathing the stereocilia tips is rich in K+, potassium flows into the cell, causing depolarization. A) Hair cells do not generate action potentials via voltage-gated sodium channels like neurons; they produce graded receptor potentials. B) This is the correct mechanism. C) The signal transduction does not involve closing gap junctions between hair cells. D) Deflection toward the tallest stereocilia causes depolarization (excitation), not hyperpolarization. Deflection in the opposite direction would close channels and cause relative hyperpolarization.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A patient who has received the antibiotic gentamicin at high doses for a severe infection develops bilateral hearing loss. The physician explains that gentamicin is toxic to a specific cell type in the inner ear. These cells cannot regenerate in humans, making the hearing loss permanent. The damaged cells are most likely:',
  '[{"label": "A", "text": "Schwann cells myelinating the auditory nerve"},
    {"label": "B", "text": "Hair cells in the organ of Corti"},
    {"label": "C", "text": "Osteocytes in the ossicles"},
    {"label": "D", "text": "Epithelial cells lining the Eustachian tube"}]',
  'B',
  'Aminoglycoside antibiotics like gentamicin are ototoxic — they selectively damage hair cells in the organ of Corti (particularly outer hair cells). In mammals, cochlear hair cells do not regenerate, making the hearing loss permanent. This is a well-known clinical side effect. A) Schwann cells myelinate peripheral nerves; while gentamicin can cause vestibulotoxicity, the primary ototoxic target is hair cells, not Schwann cells. C) Osteocytes in the ossicles are bone cells; gentamicin ototoxicity does not primarily affect the ossicles. D) Eustachian tube epithelial cells are not the target of aminoglycoside ototoxicity; damage there would cause middle ear pressure problems, not sensorineural hearing loss.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'An audiologist performs a bone conduction test by placing a vibrating tuning fork on the mastoid process behind the ear. The patient can hear the tone via bone conduction but not through air conduction. This result indicates:',
  '[{"label": "A", "text": "Sensorineural hearing loss, because the cochlear hair cells are damaged"},
    {"label": "B", "text": "Conductive hearing loss, because the outer or middle ear is not transmitting sound normally but the cochlea is intact"},
    {"label": "C", "text": "Central hearing loss, because the auditory cortex cannot process the signal"},
    {"label": "D", "text": "Normal hearing, because bone conduction always produces a louder signal than air conduction"}]',
  'B',
  'If bone conduction is intact but air conduction is impaired, the cochlea and auditory nerve are functioning normally — the problem lies in the conduction pathway (outer or middle ear). Common causes include cerumen impaction, tympanic membrane perforation, or ossicular chain dysfunction. A) Sensorineural hearing loss involves damage to the cochlea or auditory nerve; if the cochlea were damaged, bone conduction would also be impaired. B) This is correct — the conductive apparatus is impaired but the sensorineural apparatus is intact. C) Central hearing loss involves cortical processing deficits; bone conduction bypasses the outer/middle ear but still requires cortical processing, so central loss would impair both pathways. D) In normal hearing, air conduction is actually louder/more efficient than bone conduction (Rinne test positive).',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'After a concert, a student notices a persistent ringing in her ears despite the absence of any external sound. This phantom sound perception is known as tinnitus. Based on the auditory pathway, which of the following best explains why tinnitus persists after noise exposure?',
  '[{"label": "A", "text": "The pinna continues to resonate at the frequency of the last loud sound it collected"},
    {"label": "B", "text": "Damaged hair cells or altered neural activity in the auditory pathway generate spontaneous signals interpreted as sound"},
    {"label": "C", "text": "The tympanic membrane remains permanently deformed from the loud sound"},
    {"label": "D", "text": "The ossicles continue vibrating at their natural resonant frequency"}]',
  'B',
  'Tinnitus often results from damage to hair cells in the organ of Corti, which can lead to aberrant spontaneous neural activity in the auditory pathway. The brain interprets these signals as sound even though no external stimulus exists. Noise-induced hair cell damage is a common trigger. A) The pinna is a passive sound collector made of cartilage; it does not resonate or store sound energy after exposure. C) The tympanic membrane is elastic and returns to its resting position after sound exposure; permanent deformation would cause hearing loss but not the phantom sound perception of tinnitus. D) The ossicles stop vibrating almost immediately when sound stops; they do not have sustained natural resonance that would persist for hours or days.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A neurosurgeon is mapping the auditory cortex during a surgery. She stimulates different regions and records the patient''s perceptions. She finds that neurons in one region respond best to low-frequency tones while adjacent neurons respond to progressively higher frequencies. This cortical organization mirrors which property of the basilar membrane?',
  '[{"label": "A", "text": "Tonotopic organization, where frequency representation is spatially mapped"},
    {"label": "B", "text": "Somatotopic organization, where body regions are spatially mapped"},
    {"label": "C", "text": "Retinotopic organization, where visual field locations are spatially mapped"},
    {"label": "D", "text": "Chemotopic organization, where different chemicals are spatially mapped"}]',
  'A',
  'Tonotopic organization refers to the systematic spatial mapping of sound frequency — this exists along the basilar membrane (base=high, apex=low) and is preserved throughout the auditory pathway, including in the primary auditory cortex. B) Somatotopic organization is the spatial mapping of body surface regions in the somatosensory cortex — this applies to touch, not hearing. C) Retinotopic organization is the spatial mapping of visual field locations in the visual cortex — this applies to vision. D) Chemotopic organization (mapping of chemical responses) applies to olfaction, not audition.',
  'easy'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A researcher investigates how the auditory system processes a complex 8,000 Hz tone. She finds that place theory alone provides the best explanation for encoding this frequency. Why is place theory most appropriate for this frequency, rather than frequency theory or the volley principle?',
  '[{"label": "A", "text": "Individual neurons can fire at 8,000 Hz, so frequency theory is unnecessary"},
    {"label": "B", "text": "At 8,000 Hz, neither individual neurons nor small groups of neurons can fire fast enough to match the frequency, so spatial coding on the basilar membrane is the primary mechanism"},
    {"label": "C", "text": "Place theory only applies to frequencies above 20,000 Hz"},
    {"label": "D", "text": "The volley principle generates the 8,000 Hz signal, but place theory names the specific neurons involved"}]',
  'B',
  'Individual neurons have a maximum firing rate of about 1,000 Hz (due to refractory periods), so frequency theory cannot encode 8,000 Hz. The volley principle (groups of neurons alternating firing) extends the range to roughly 5,000 Hz, but 8,000 Hz exceeds even this limit. Therefore, place theory (spatial location of maximal stimulation on the basilar membrane) provides the primary encoding mechanism for high frequencies. A) Neurons cannot fire at 8,000 Hz individually — their refractory period limits them to about 1,000 Hz. C) Place theory is effective for frequencies above approximately 5,000 Hz, not just above 20,000 Hz. D) The volley principle has an upper limit of approximately 5,000 Hz and cannot encode 8,000 Hz.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A patient with benign paroxysmal positional vertigo (BPPV) experiences brief episodes of intense vertigo when she turns her head to the right while lying down. The physician explains that calcium carbonate crystals have become dislodged and migrated into one of the semicircular canals. These displaced crystals originated from which structures?',
  '[{"label": "A", "text": "The organ of Corti, where they normally weigh down the tectorial membrane"},
    {"label": "B", "text": "The utricle or saccule, where they normally function as otoliths on the otolithic membrane"},
    {"label": "C", "text": "The basilar membrane, where they increase its mass for low-frequency detection"},
    {"label": "D", "text": "The tympanic membrane, where they provide damping for loud sounds"}]',
  'B',
  'BPPV occurs when otoliths (otoconia) — calcium carbonate crystals normally embedded in the otolithic membrane of the utricle or saccule — become dislodged and migrate into a semicircular canal. These displaced crystals cause abnormal endolymph flow during head movements, triggering false rotational signals and vertigo. A) The organ of Corti does not contain calcium carbonate crystals; the tectorial membrane has a different composition and function. C) The basilar membrane does not contain otoliths; its mechanical properties come from its varying width and stiffness. D) The tympanic membrane does not contain calcium carbonate crystals; it is a thin membrane that vibrates in response to sound waves.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A scuba diver ascending too quickly from a deep dive develops hearing loss and vertigo. Examination reveals a ruptured oval window membrane. Which step in the auditory pathway is directly disrupted by this injury?',
  '[{"label": "A", "text": "Collection of sound waves by the pinna"},
    {"label": "B", "text": "Vibration of the tympanic membrane"},
    {"label": "C", "text": "Transmission of vibrations from the stapes into the cochlear fluids"},
    {"label": "D", "text": "Neural transmission along the auditory nerve to the brainstem"}]',
  'C',
  'The oval window is the membrane-covered opening where the stapes footplate transmits vibrations from the middle ear into the cochlear fluids (perilymph). Rupture of the oval window membrane disrupts this critical interface, causing hearing loss. Perilymph leakage can also enter the middle ear, and disruption of fluid dynamics affects the vestibular system, explaining the vertigo. A) The pinna functions normally regardless of oval window damage; it is in the outer ear. B) The tympanic membrane can vibrate normally even with oval window damage; the tympanic membrane is a separate structure. D) The auditory nerve remains intact — the problem is that vibrations are not properly entering the cochlea to stimulate hair cells in the first place.',
  'hard'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A physical therapist evaluates a patient who has difficulty maintaining balance when standing on an unstable surface with eyes closed. Vision and vestibular function test normal. The most likely impaired sensory system is:',
  '[{"label": "A", "text": "The gustatory system, which provides taste information"},
    {"label": "B", "text": "The proprioceptive (kinesthetic) system, which provides information about body and limb position"},
    {"label": "C", "text": "The olfactory system, which detects chemical stimuli"},
    {"label": "D", "text": "The auditory system, which processes sound for spatial orientation"}]',
  'B',
  'Balance depends on three systems: vision, vestibular sense, and proprioception. With eyes closed, vision is eliminated. Vestibular function is stated as normal. The unstable surface challenges proprioceptive input (from joint, muscle, and tendon receptors). If the patient has impaired proprioception, they cannot compensate for the loss of visual input and the challenging surface, leading to balance difficulty. A) The gustatory (taste) system has no role in balance or spatial orientation. C) The olfactory system does not contribute to balance maintenance. D) While auditory cues can provide some spatial information, the auditory system is not one of the three primary systems for postural balance, and the clinical presentation (unstable surface + eyes closed) specifically tests proprioceptive function.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'An experiment measures the response of auditory nerve fibers to a 200 Hz pure tone. The researcher finds that individual nerve fibers fire in synchrony with each cycle of the sound wave — every 5 milliseconds. This phase-locked firing pattern is most consistent with which theory of pitch perception?',
  '[{"label": "A", "text": "Place theory, because the fibers are at a specific location on the basilar membrane"},
    {"label": "B", "text": "Frequency theory, because the neural firing rate directly corresponds to the stimulus frequency"},
    {"label": "C", "text": "Volley principle, because groups of neurons must alternate to achieve this firing rate"},
    {"label": "D", "text": "Opponent-process theory, because inhibitory and excitatory signals alternate"}]',
  'B',
  'At 200 Hz, individual auditory nerve fibers can fire once per cycle (every 5 ms = 200 Hz), directly matching the stimulus frequency through phase-locked firing. This is the core mechanism of frequency theory — the firing rate of the auditory nerve encodes the frequency of the sound. At 200 Hz, this is well within the capability of individual neurons. A) Place theory involves different basilar membrane locations encoding different frequencies; the scenario describes temporal coding (firing rate), not spatial coding. C) The volley principle is needed for frequencies above ~1,000 Hz where individual neurons cannot keep up; at 200 Hz, individual neurons can phase-lock without needing to alternate. D) Opponent-process theory relates to color vision or motivation theory, not auditory pitch perception.',
  'medium'
);

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'psych_soc',
  'Hearing and Vestibular Sense',
  'A child is diagnosed with bilateral sensorineural hearing loss after meningitis. The infection damaged structures in the inner ear. Which of the following findings would be MOST consistent with sensorineural (rather than conductive) hearing loss?',
  '[{"label": "A", "text": "The tympanic membrane appears perforated on otoscopic examination"},
    {"label": "B", "text": "Bone conduction hearing is impaired in addition to air conduction hearing"},
    {"label": "C", "text": "The ossicular chain is discontinuous on CT imaging"},
    {"label": "D", "text": "Cerumen impaction is visible in the external auditory canal"}]',
  'B',
  'In sensorineural hearing loss, the cochlea or auditory nerve is damaged. Since bone conduction vibrations bypass the outer and middle ear but still require a functioning cochlea, both air and bone conduction are impaired. This distinguishes sensorineural from conductive loss. A) A perforated tympanic membrane causes conductive hearing loss (outer/middle ear problem), not sensorineural. C) Ossicular chain discontinuity is a middle ear problem causing conductive loss. D) Cerumen (earwax) impaction blocks the ear canal, causing conductive hearing loss. None of these would be caused by meningitis damaging the inner ear.',
  'hard'
);
