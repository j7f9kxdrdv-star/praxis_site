-- ════════════════════════════════════════════════════════════════════
-- Biology Chapter 4 — The Nervous System
-- ════════════════════════════════════════════════════════════════════
-- Section: biology
-- Topic:   Body Systems
-- Subtopic slug: the_nervous_system
-- Sort order: 4
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--   1.  Neuron Structure
--   2.  Myelin & Glial Cells
--   3.  CNS vs PNS Overview
--   4.  Resting Membrane Potential
--   5.  Action Potential
--   6.  Impulse Propagation & Saltatory Conduction
--   7.  Refractory Periods
--   8.  Synaptic Transmission
--   9.  Neurotransmitter Receptors & Clearance
--   10. Summation & Excitatory/Inhibitory Inputs
--   11. Neuron Functional Types
--   12. Somatic vs Autonomic
--   13. Sympathetic vs Parasympathetic
--   14. Brain Anatomy
--   15. Spinal Cord
--   16. Reflex Arcs
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings and topic groupings) and
-- reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Anatomy & Physiology 2e (Ch 12 Nervous Tissue, Ch 13 Anatomy of
-- the Nervous System, Ch 14 Somatic Nervous System, Ch 15 Autonomic Nervous
-- System) and OpenStax Biology 2e (Ch 35 The Nervous System). See companion
-- .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biology'
      AND title IN (
          'The Nervous System',
          'Nervous System',
          'Biology Review Chapter Four: The Nervous System'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biology',
        'Body Systems',
        'the_nervous_system',
        'The Nervous System',
        'Neurons and glia, resting membrane potential, action potential generation and propagation, synaptic transmission, neurotransmitters, organization of the CNS and PNS, autonomic divisions, brain anatomy, and reflex arcs.',
        4
    )
    RETURNING id INTO deck;

    -- ── Neuron Structure ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'A {{c1::neuron}} is a specialized cell that converts incoming {{c2::chemical}} signals into an electrical impulse and then back into a chemical signal at the next cell.',
     2),
    (deck, 1, 'cloze',
     'The cell body of a neuron is called the {{c1::soma}}; it houses the nucleus, endoplasmic reticulum, and ribosomes — the machinery that keeps the rest of the cell alive.',
     1),
    (deck, 2, 'cloze',
     '{{c1::Dendrites}} are branched extensions that receive incoming signals from other neurons and carry them inward to the soma.',
     1),
    (deck, 3, 'cloze',
     'The {{c1::axon}} is a single long projection that carries the action potential away from the soma toward the next cell — a neuron, a muscle, or a gland.',
     1),
    (deck, 4, 'cloze',
     'The {{c1::axon hillock}} is the junction between the soma and axon where excitatory and inhibitory inputs are {{c2::summed}}; if the net depolarization reaches threshold, an action potential fires.',
     2),
    (deck, 5, 'cloze',
     'The axon ends in a {{c1::synaptic terminal}} (synaptic bouton), an enlarged structure that releases {{c2::neurotransmitters}} into the synaptic cleft.',
     2);

    -- ── Myelin & Glial Cells ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 6, 'cloze',
     '{{c1::Myelin}} is a fatty insulating sheath that prevents signal loss along the axon and dramatically increases the {{c2::speed of conduction}}.',
     2),
    (deck, 7, 'cloze',
     'Myelin is produced by {{c1::oligodendrocytes}} in the central nervous system and by {{c2::Schwann cells}} in the peripheral nervous system.',
     2),
    (deck, 8, 'cloze',
     'The {{c1::nodes of Ranvier}} are short gaps in the myelin sheath where the axon membrane is exposed and the action potential is {{c2::regenerated}}.',
     2),
    (deck, 9, 'cloze',
     '{{c1::Astrocytes}} are star-shaped glial cells that nourish neurons and form the {{c2::blood-brain barrier}}, which tightly controls what enters the nervous tissue from the blood.',
     2),
    (deck, 10, 'cloze',
     '{{c1::Microglia}} are the resident phagocytes of the central nervous system; they ingest cellular debris, dead cells, and {{c2::pathogens}}.',
     2),
    (deck, 11, 'cloze',
     '{{c1::Ependymal cells}} line the ventricles of the brain and produce {{c2::cerebrospinal fluid (CSF)}}, which cushions the brain and acts as a shock absorber.',
     2);

    -- ── CNS vs PNS Overview ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 12, 'cloze',
     'The {{c1::central nervous system (CNS)}} consists of the brain and spinal cord; the {{c2::peripheral nervous system (PNS)}} is everything else — the nerves connecting it to the rest of the body.',
     2),
    (deck, 13, 'cloze',
     'The PNS splits into the {{c1::somatic}} nervous system, which controls voluntary movements, and the {{c2::autonomic}} nervous system, which controls involuntary functions like heart rate and digestion.',
     2),
    (deck, 14, 'cloze',
     '{{c1::White matter}} consists of myelinated axons (the myelin gives it its color); {{c2::gray matter}} consists of cell bodies, dendrites, and unmyelinated axons.',
     2);

    -- ── Resting Membrane Potential ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'The resting membrane potential of a neuron is about {{c1::-70 mV}}, with the inside of the cell {{c2::negative}} relative to the outside.',
     2),
    (deck, 16, 'cloze',
     'Potassium is far more concentrated {{c1::inside}} the neuron (~140 mM) than outside (~4 mM), so the K+ gradient drives K+ to leak {{c2::outward}} through leak channels.',
     2),
    (deck, 17, 'cloze',
     'Sodium is far more concentrated {{c1::outside}} the neuron (~145 mM) than inside (~12 mM), so the Na+ gradient drives Na+ to flow {{c2::inward}} through leak channels.',
     2),
    (deck, 18, 'cloze',
     'The K+ equilibrium potential is roughly {{c1::-90 mV}} and the Na+ equilibrium potential is roughly {{c2::+60 mV}}; the resting potential sits closer to K+''s because the membrane is more permeable to K+.',
     2),
    (deck, 19, 'cloze',
     'The {{c1::Na+/K+ ATPase}} pumps {{c2::3 Na+}} out of the cell for every {{c3::2 K+}} pumped in, restoring the ion gradients that the action potential partially dissipates.',
     3);

    -- ── Action Potential ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
     'An action potential is an {{c1::all-or-nothing}} electrical impulse: every AP in a given neuron has the same {{c2::amplitude}}, regardless of how strong the triggering stimulus was.',
     2),
    (deck, 21, 'cloze',
     'An action potential fires only if the axon hillock depolarizes to {{c1::threshold}}, roughly {{c2::-55 mV}}; below this, the signal dies out.',
     2),
    (deck, 22, 'cloze',
     'At threshold, {{c1::voltage-gated Na+ channels}} snap open; Na+ rushes inward down its electrochemical gradient and rapidly {{c2::depolarizes}} the membrane toward +35 mV.',
     2),
    (deck, 23, 'cloze',
     'Near +35 mV, Na+ channels inactivate and {{c1::voltage-gated K+ channels}} open; K+ exits the cell, driving the membrane back toward the resting potential — {{c2::repolarization}}.',
     2),
    (deck, 24, 'cloze',
     'K+ efflux briefly overshoots the resting potential, leaving the membrane temporarily more negative than -70 mV — {{c1::hyperpolarization}}. The Na+/K+ ATPase then restores the resting state.',
     1),
    (deck, 25, 'cloze',
     'Voltage-gated sodium channels exist in three states: {{c1::closed}} (below threshold and after inactivation reverses), {{c2::open}} (from threshold to ~+35 mV), and {{c3::inactivated}} (~+35 mV down to the resting potential).',
     3),
    (deck, 26, 'cloze',
     'A Na+ channel in the {{c1::inactivated}} state cannot reopen until the membrane returns near the resting potential, where it is reset to the {{c2::closed}} state.',
     2);

    -- ── Impulse Propagation & Saltatory Conduction ──────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 27, 'cloze',
     'As Na+ enters one segment of the axon, it depolarizes the {{c1::adjacent segment}} to threshold, opening its Na+ channels too. This domino effect carries the action potential along the axon.',
     1),
    (deck, 28, 'cloze',
     'Conduction speed increases with axon {{c1::cross-sectional area}} (less resistance) and decreases with axon {{c2::length}}; cross-sectional area is the more significant factor.',
     2),
    (deck, 29, 'cloze',
     'In myelinated axons, the action potential is regenerated only at the {{c1::nodes of Ranvier}}, where it appears to jump from node to node — {{c2::saltatory}} conduction.',
     2),
    (deck, 30, 'cloze',
     'Because every action potential has the same amplitude, a stronger stimulus is signaled by an increased {{c1::frequency}} of firing, not by a larger {{c2::action potential}}.',
     2);

    -- ── Refractory Periods ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 31, 'cloze',
     'During the {{c1::absolute refractory period}}, the neuron cannot fire another action potential regardless of stimulus strength because Na+ channels are {{c2::inactivated}}.',
     2),
    (deck, 32, 'cloze',
     'During the {{c1::relative refractory period}}, a second action potential is possible only with a {{c2::stronger-than-normal}} stimulus, because the membrane is hyperpolarized below the usual threshold gap.',
     2);

    -- ── Synaptic Transmission ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 33, 'cloze',
     'A {{c1::synapse}} consists of the presynaptic terminal, the synaptic {{c2::cleft}}, and the postsynaptic membrane; most synapses use a chemical messenger rather than direct electrical contact.',
     2),
    (deck, 34, 'cloze',
     'When the action potential reaches the synaptic terminal, voltage-gated {{c1::calcium}} channels open and the ion flows into the {{c2::presynaptic}} neuron.',
     2),
    (deck, 35, 'cloze',
     'The Ca2+ influx triggers fusion of neurotransmitter-filled {{c1::vesicles}} with the presynaptic membrane, releasing the neurotransmitter into the cleft by {{c2::exocytosis}}.',
     2),
    (deck, 36, 'cloze',
     'Once released, the neurotransmitter diffuses across the {{c1::synaptic cleft}} and binds to receptors on the {{c2::postsynaptic}} membrane.',
     2),
    (deck, 37, 'cloze',
     'When the postsynaptic target is a muscle or gland rather than another neuron, the postsynaptic structure is called an {{c1::effector}}.',
     1);

    -- ── Neurotransmitter Receptors & Clearance ──────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 38, 'cloze',
     'An {{c1::ionotropic}} receptor is a ligand-gated ion channel: NT binding directly opens the channel and immediately {{c2::depolarizes or hyperpolarizes}} the postsynaptic cell.',
     2),
    (deck, 39, 'cloze',
     'A {{c1::metabotropic}} receptor is a G-protein-coupled receptor: NT binding triggers a second-messenger cascade that alters cyclic {{c2::AMP}} levels or intracellular Ca2+.',
     2),
    (deck, 40, 'cloze',
     'A neurotransmitter is cleared from the synaptic cleft by three mechanisms: {{c1::enzymatic degradation}}, {{c2::reuptake}} by the presynaptic neuron, or {{c3::diffusion}} out of the cleft.',
     3),
    (deck, 41, 'cloze',
     '{{c1::Acetylcholinesterase}} degrades acetylcholine in the synaptic cleft, ending the cholinergic signal.',
     1),
    (deck, 42, 'cloze',
     'Dopamine, {{c1::norepinephrine}}, and serotonin are cleared primarily by {{c2::reuptake}} carriers that pump the neurotransmitter back into the presynaptic neuron for recycling.',
     2);

    -- ── Summation & Excitatory/Inhibitory Inputs ────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     'An {{c1::excitatory}} postsynaptic input depolarizes the membrane and pushes it toward threshold; an {{c2::inhibitory}} input hyperpolarizes it and pushes it away from threshold.',
     2),
    (deck, 44, 'cloze',
     'Common excitatory neurotransmitters include {{c1::glutamate}} in the CNS and {{c2::acetylcholine}} at the neuromuscular junction.',
     2),
    (deck, 45, 'cloze',
     'Common inhibitory neurotransmitters include {{c1::GABA}} in the brain and {{c2::glycine}} in the spinal cord.',
     2),
    (deck, 46, 'cloze',
     '{{c1::Temporal}} summation adds up signals that arrive close together in time from one synapse; {{c2::spatial}} summation adds up signals that arrive at the same time from different synapses.',
     2);

    -- ── Neuron Functional Types ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 47, 'cloze',
     '{{c1::Afferent}} neurons (also called {{c2::sensory}} neurons) carry signals from sensory receptors toward the central nervous system.',
     2),
    (deck, 48, 'cloze',
     '{{c1::Efferent}} neurons (also called {{c2::motor}} neurons) carry signals away from the central nervous system to muscles and glands.',
     2),
    (deck, 49, 'cloze',
     '{{c1::Interneurons}} sit between sensory and motor neurons and integrate their signals; they are the most {{c2::numerous}} of the three neuron types and live almost entirely within the CNS.',
     2);

    -- ── Somatic vs Autonomic ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 50, 'cloze',
     'The {{c1::somatic}} nervous system controls voluntary movement; a single motor neuron runs directly from the spinal cord to skeletal muscle, with no intervening {{c2::synapse}}.',
     2),
    (deck, 51, 'cloze',
     'The {{c1::autonomic}} nervous system uses a two-neuron chain: a {{c2::preganglionic}} neuron in the CNS synapses on a {{c3::postganglionic}} neuron in a peripheral ganglion, which then innervates the target.',
     3),
    (deck, 52, 'cloze',
     'The autonomic nervous system controls involuntary functions including {{c1::heart rate}}, breathing, digestion, and {{c2::glandular secretion}} — all of which run without conscious effort.',
     2);

    -- ── Sympathetic vs Parasympathetic ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 53, 'cloze',
     'The {{c1::sympathetic}} nervous system mediates the {{c2::fight-or-flight}} response and is activated by stress, from mild challenges to life-threatening emergencies.',
     2),
    (deck, 54, 'cloze',
     'Sympathetic activation {{c1::increases}} heart rate, raises blood glucose, dilates pupils, relaxes the bronchi, redirects blood to skeletal muscle, and {{c2::decreases}} digestion.',
     2),
    (deck, 55, 'cloze',
     'The {{c1::parasympathetic}} nervous system promotes {{c2::rest-and-digest}} activities, slows the heart, constricts the bronchi, and ramps up gut peristalsis and exocrine secretion.',
     2),
    (deck, 56, 'cloze',
     'The {{c1::vagus nerve}} (cranial nerve X) provides much of the parasympathetic innervation to the thoracic and abdominal organs.',
     1),
    (deck, 57, 'cloze',
     'Both sympathetic and parasympathetic {{c1::preganglionic}} neurons release acetylcholine. Parasympathetic postganglionic neurons release {{c2::acetylcholine}}, while most sympathetic postganglionic neurons release {{c3::norepinephrine}}.',
     3);

    -- ── Brain Anatomy ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 58, 'cloze',
     'The {{c1::brainstem}} consists of the midbrain, {{c2::pons}}, and {{c3::medulla oblongata}}; it handles basic life-sustaining functions like breathing and heart rate.',
     3),
    (deck, 59, 'cloze',
     'The {{c1::cerebellum}} sits behind the brainstem and coordinates {{c2::movement and balance}}; damage causes incoordination but not paralysis.',
     2),
    (deck, 60, 'cloze',
     'The {{c1::limbic system}} is the brain''s emotional and motivational network and is also central to {{c2::memory}} formation.',
     2),
    (deck, 61, 'cloze',
     'The {{c1::cerebral cortex}} is the outermost layer of the brain and handles higher-order processing: decision-making, language, perception, and {{c2::consciousness}}.',
     2);

    -- ── Spinal Cord ─────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 62, 'cloze',
     'From top to bottom, the spinal cord is divided into four regions: {{c1::cervical, thoracic, lumbar, and sacral}}.',
     1),
    (deck, 63, 'cloze',
     '{{c1::Dorsal}} (posterior) roots of spinal nerves carry sensory signals into the cord; {{c2::ventral}} (anterior) roots carry motor signals out to muscles and glands.',
     2),
    (deck, 64, 'cloze',
     'The cell bodies of sensory neurons cluster in the {{c1::dorsal root ganglia}}, just outside the spinal cord — sensory neuron cell bodies live in the {{c2::PNS}}, not the CNS.',
     2);

    -- ── Reflex Arcs ─────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 65, 'cloze',
     'A reflex arc processes the response at the {{c1::spinal cord}} level without input from the brain, allowing dangerously fast reactions to stimuli like a hot surface.',
     1),
    (deck, 66, 'cloze',
     'In a {{c1::monosynaptic}} reflex arc, a sensory neuron synapses directly onto a motor neuron — the classic example is the {{c2::patellar (knee-jerk)}} reflex.',
     2),
    (deck, 67, 'cloze',
     'In a {{c1::polysynaptic}} reflex arc, one or more interneurons sit between the sensory and motor neurons — the classic example is the {{c2::withdrawal}} reflex from a painful stimulus.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 68;
END $$;
