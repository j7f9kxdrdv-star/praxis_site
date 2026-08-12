-- ════════════════════════════════════════════════════════════════════
-- Biology Chapter 11 — The Musculoskeletal System
-- ════════════════════════════════════════════════════════════════════
-- Section: biology
-- Topic:   Body Systems
-- Subtopic slug: the_musculoskeletal_system
-- Sort order: 11
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--   1.  Three Muscle Types Overview
--   2.  Skeletal Muscle Properties
--   3.  Smooth Muscle Properties
--   4.  Cardiac Muscle + Conduction
--   5.  Red vs White Fibers
--   6.  Sarcomere Components
--   7.  Thick/Thin Filaments + Regulatory Proteins
--   8.  Myocyte Gross Structure
--   9.  NMJ + Motor Unit + Initiation
--   10. Cross-Bridge Cycle + Sliding Filament
--   11. Relaxation + Twitch/Summation/Tetanus
--   12. Energy Reserves + Oxygen Debt
--   13. Skeleton Types + Long Bone Anatomy
--   14. Bone Microstructure
--   15. Bone Cells + Remodeling + Hormonal Control
--   16. Cartilage + Joints + Muscle Attachments
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Anatomy & Physiology 2e (Ch 6 Bone Tissue, Ch 9 Joints, Ch 10
-- Muscle Tissue, Ch 11 Muscular System, Ch 15 Autonomic Nervous System,
-- Ch 19 Cardiovascular System), and the AAMC Foundation 3B Concept 2
-- content outline. See companion .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biology'
      AND title IN (
          'The Musculoskeletal System',
          'Musculoskeletal System',
          'Biology Review, Chapter 11: The Musculoskeletal System'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biology',
        'Body Systems',
        'the_musculoskeletal_system',
        'The Musculoskeletal System',
        'The three muscle types (skeletal, smooth, cardiac) and their properties; red vs white fibers; sarcomere structure and the sliding filament model of contraction; cardiac conduction and autonomic control; energy reserves and oxygen debt; bone composition and microstructure (compact/spongy, osteons); bone remodeling and hormonal control (PTH, vitamin D, calcitonin); cartilage; joints; and the vocabulary of muscle attachments and movements.',
        11
    )
    RETURNING id INTO deck;

    -- ── Three Muscle Types Overview ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'The three muscle types are {{c1::skeletal}}, {{c1::smooth}}, and {{c1::cardiac}} muscle — distinguished by their striation, nucleation, voluntary vs involuntary control, and locations.',
     1),
    (deck, 1, 'cloze',
     'The {{c1::striated}} muscle types are {{c2::skeletal}} and {{c2::cardiac}}; the only {{c1::non-striated}} muscle is {{c2::smooth}}.',
     2),
    (deck, 2, 'cloze',
     'The only {{c1::voluntary}} muscle type is skeletal (controlled by the somatic nervous system); smooth and cardiac are {{c1::involuntary}}, controlled by the autonomic nervous system.',
     1);

    -- ── Skeletal Muscle Properties ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 3, 'cloze',
     '{{c1::Skeletal muscle}} is {{c2::striated}}, {{c2::multinucleated}}, and under {{c2::voluntary}} (somatic) control; it generates the force for movement, posture, and thermoregulation.',
     2),
    (deck, 4, 'cloze',
     'Skeletal muscle appears {{c1::striated}} under the microscope because actin and myosin are organized into repeating contractile units called {{c2::sarcomeres}}.',
     2),
    (deck, 5, 'cloze',
     'Skeletal muscle cells are {{c1::multinucleated}}, with their nuclei typically located at the {{c2::periphery}} of the cell rather than centrally.',
     2),
    (deck, 6, 'cloze',
     'Skeletal muscle is innervated by {{c1::motor (efferent)}} neurons of the {{c2::somatic}} nervous system, which is why its contractions are voluntary.',
     2);

    -- ── Smooth Muscle Properties ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
     '{{c1::Smooth muscle}} is {{c2::non-striated}}, {{c2::uninucleated}} (with one centrally located nucleus), and under {{c2::involuntary}} (autonomic) control.',
     2),
    (deck, 8, 'cloze',
     'Smooth muscle lines the walls of {{c1::blood vessels}}, the digestive tract, the respiratory tree, the bladder, and the uterus — handling slow, sustained, involuntary functions.',
     1),
    (deck, 9, 'cloze',
     'Smooth muscle shows {{c1::myogenic activity}}, meaning it can contract without nervous input, and maintains a constant low-level baseline contraction called {{c2::tonus}}.',
     2);

    -- ── Cardiac Muscle + Conduction ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
     '{{c1::Cardiac muscle}} is {{c2::striated}}, typically {{c2::uninucleated}} (occasionally binucleated), and under {{c2::involuntary}} (autonomic) control; it is found only in the heart.',
     2),
    (deck, 11, 'cloze',
     'Cardiac muscle cells are joined by {{c1::intercalated discs}} containing {{c2::gap junctions}}; ions flow directly between cells through these junctions, synchronizing depolarization across the myocardium.',
     2),
    (deck, 12, 'cloze',
     'The cardiac conduction sequence is: {{c1::SA node}} → {{c2::AV node}} → bundle of His → Purkinje fibers; depolarization spreads myogenically without nervous-system input.',
     2),
    (deck, 13, 'cloze',
     'The {{c1::vagus nerve}} provides {{c2::parasympathetic}} innervation to the heart and slows the heart rate; vagal tone is the resting brake on cardiac pacing.',
     2),
    (deck, 14, 'cloze',
     '{{c1::Norepinephrine}} from sympathetic neurons and {{c1::epinephrine}} from the adrenal medulla bind to {{c2::adrenergic receptors}} on the heart, increasing rate and contractility.',
     2);

    -- ── Red vs White Fibers ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     '{{c1::Red (slow-twitch)}} fibers are rich in {{c2::myoglobin}} and mitochondria; they rely on {{c3::aerobic}} metabolism and dominate in muscles built for sustained, endurance activity.',
     3),
    (deck, 16, 'cloze',
     '{{c1::White (fast-twitch)}} fibers contain little myoglobin and rely on {{c2::anaerobic}} metabolism; they generate rapid, powerful contractions but {{c3::fatigue quickly}}.',
     3),
    (deck, 17, 'cloze',
     '{{c1::Myoglobin}} is an oxygen-binding protein with an {{c2::iron}}-containing heme group; it stores oxygen in muscle and gives red fibers their color.',
     2);

    -- ── Sarcomere Components ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     'A {{c1::sarcomere}} is the basic contractile unit of striated muscle, bounded on each end by a {{c2::Z-line}}.',
     2),
    (deck, 19, 'cloze',
     'The {{c1::M-line}} runs down the {{c2::center}} of each sarcomere, holding the thick filaments in place.',
     2),
    (deck, 20, 'cloze',
     'The {{c1::I-band}} contains only {{c2::thin (actin)}} filaments and lies on either side of each Z-line.',
     2),
    (deck, 21, 'cloze',
     'The {{c1::H-zone}} contains only {{c2::thick (myosin)}} filaments and lies in the center of the sarcomere, surrounding the M-line.',
     2),
    (deck, 22, 'cloze',
     'The {{c1::A-band}} spans the entire length of the {{c2::thick}} filaments (including any overlap with thin filaments) and stays a {{c3::constant}} length during contraction.',
     3),
    (deck, 23, 'cloze',
     'During contraction: the {{c1::I-band shortens}}, the {{c1::H-zone shortens}}, and Z-lines move closer together, but the {{c2::A-band length stays constant}}.',
     2);

    -- ── Thick/Thin Filaments + Regulatory Proteins ──────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 24, 'cloze',
     '{{c1::Thick}} filaments are bundles of {{c2::myosin}}; {{c1::thin}} filaments are made of {{c2::actin}} together with two regulatory proteins, troponin and tropomyosin.',
     2),
    (deck, 25, 'cloze',
     '{{c1::Troponin}} sits on the thin filament and binds {{c2::Ca²⁺}}; calcium binding triggers a conformational shift that moves tropomyosin off the myosin-binding sites.',
     2),
    (deck, 26, 'cloze',
     '{{c1::Tropomyosin}} is a thin-filament protein that physically {{c2::blocks}} the myosin-binding sites on actin at rest; troponin-bound Ca²⁺ pulls it away to allow cross-bridge formation.',
     2),
    (deck, 27, 'cloze',
     '{{c1::Titin}} acts as a molecular spring that anchors thick filaments to the Z-line; it prevents excessive {{c2::stretching}} and helps the sarcomere recoil.',
     2);

    -- ── Myocyte Gross Structure ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 28, 'cloze',
     'Each muscle fiber (myocyte) contains many {{c1::myofibrils}} aligned in parallel; each myofibril is a chain of sarcomeres joined end-to-end.',
     1),
    (deck, 29, 'cloze',
     'Myofibrils are wrapped by the {{c1::sarcoplasmic reticulum}}, a modified endoplasmic reticulum that stores high concentrations of {{c2::Ca²⁺}} for release during contraction.',
     2),
    (deck, 30, 'cloze',
     'The cell membrane of a muscle fiber is called the {{c1::sarcolemma}}; it propagates action potentials across the muscle cell surface.',
     1),
    (deck, 31, 'cloze',
     '{{c1::T-tubules (transverse tubules)}} are invaginations of the sarcolemma that carry action potentials deep into the muscle cell to reach the {{c2::sarcoplasmic reticulum}} of every sarcomere.',
     2);

    -- ── NMJ + Motor Unit + Initiation ───────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     'Skeletal muscle contraction begins at the {{c1::neuromuscular junction}}, where a motor neuron releases {{c2::acetylcholine}} into the synapse with the muscle fiber.',
     2),
    (deck, 33, 'cloze',
     'The nerve terminal at the neuromuscular junction is also called the {{c1::motor end plate}}; it sits on a specialized region of the sarcolemma.',
     1),
    (deck, 34, 'cloze',
     'A {{c1::motor unit}} is a single motor neuron together with all the muscle fibers it innervates; recruiting more motor units produces stronger overall contraction.',
     1),
    (deck, 35, 'cloze',
     'Each individual muscle fiber follows an {{c1::all-or-nothing}} rule: it either fully contracts above threshold or not at all; stronger overall contraction comes from recruiting more fibers.',
     1),
    (deck, 36, 'cloze',
     'ACh binds receptors on the sarcolemma, triggering depolarization that travels through the T-tubules to the sarcoplasmic reticulum, which releases {{c1::Ca²⁺}} into the {{c2::sarcoplasm}}.',
     2);

    -- ── Cross-Bridge Cycle + Sliding Filament ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 37, 'cloze',
     'Released Ca²⁺ binds {{c1::troponin}}, which shifts {{c2::tropomyosin}} off the actin filament and exposes the myosin-binding sites.',
     2),
    (deck, 38, 'cloze',
     'Once myosin heads bind actin, release of {{c1::Pi (inorganic phosphate)}} from the myosin head drives the {{c2::power stroke}}, pulling the thin filament toward the sarcomere center.',
     2),
    (deck, 39, 'cloze',
     'After the power stroke, {{c1::ATP}} binds the myosin head and releases it from {{c2::actin}}, breaking the cross-bridge.',
     2),
    (deck, 40, 'cloze',
     'Myosin then hydrolyzes the bound ATP to {{c1::ADP and Pi}}; this energy is used to {{c2::recock}} the myosin head into position for another cross-bridge cycle.',
     2),
    (deck, 41, 'cloze',
     'In the {{c1::sliding filament model}}, repeated cross-bridge cycling causes the thin filaments to slide past the thick filaments, {{c2::shortening}} the sarcomere — but the filaments themselves do not change length.',
     2);

    -- ── Relaxation + Twitch/Summation/Tetanus ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'Muscle relaxes when {{c1::acetylcholinesterase}} degrades ACh in the synapse, ending the signal; the sarcoplasmic reticulum then pumps {{c2::Ca²⁺}} back out of the sarcoplasm.',
     2),
    (deck, 43, 'cloze',
     'A {{c1::simple twitch}} is a single muscle fiber''s response to a brief at-threshold stimulus; the brief delay between stimulus and contraction is the {{c2::latent period}}.',
     2),
    (deck, 44, 'cloze',
     'In {{c1::frequency summation}}, stimuli arrive faster than the fiber can fully relax, so contractions overlap and add together, producing a stronger and more prolonged response.',
     1),
    (deck, 45, 'cloze',
     'If stimuli arrive so rapidly that the fiber cannot relax between them at all, the result is a sustained maximal contraction called {{c1::tetanus}}.',
     1);

    -- ── Energy Reserves + Oxygen Debt ───────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 46, 'cloze',
     '{{c1::Creatine phosphate}} is built up at rest by transferring a phosphate group onto creatine; during exertion, the reaction reverses to rapidly regenerate {{c2::ATP}} from ADP.',
     2),
    (deck, 47, 'cloze',
     'During exercise, muscle uses {{c1::myoglobin}}-bound oxygen to sustain aerobic metabolism; once the oxygen is depleted, fibers switch to {{c2::anaerobic}} metabolism.',
     2),
    (deck, 48, 'cloze',
     'When muscle runs out of oxygen, fast-twitch fibers (and eventually slow-twitch) shift to anaerobic glycolysis and produce {{c1::lactic acid}}, which contributes to muscle {{c2::fatigue}}.',
     2),
    (deck, 49, 'cloze',
     '{{c1::Oxygen debt}} is the extra oxygen required after strenuous exercise to oxidize accumulated lactic acid back to {{c2::pyruvate}} (which can re-enter the citric acid cycle) and restore energy reserves.',
     2);

    -- ── Skeleton Types + Long Bone Anatomy ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 50, 'cloze',
     'An {{c1::exoskeleton}} encases the body from the outside (arthropods); an {{c1::endoskeleton}} sits inside the body and supports it from within (vertebrates).',
     1),
    (deck, 51, 'cloze',
     'The {{c1::axial skeleton}} consists of the skull, vertebrae, rib cage, and hyoid; the {{c1::appendicular skeleton}} consists of the limbs, pectoral girdle, and pelvis.',
     1),
    (deck, 52, 'cloze',
     'A long bone has a cylindrical shaft called the {{c1::diaphysis}} that widens at each end into the {{c2::metaphysis}}, terminating in the {{c3::epiphysis}}.',
     3),
    (deck, 53, 'cloze',
     'The {{c1::epiphyseal (growth) plate}} is a cartilaginous region in the metaphysis where mitotic cells drive longitudinal bone growth; it closes during {{c2::puberty}}, ending vertical growth.',
     2),
    (deck, 54, 'cloze',
     'The {{c1::periosteum}} is the fibrous sheath surrounding a long bone; {{c2::tendons}} attach muscle to bone, while {{c2::ligaments}} attach bone to bone at joints.',
     2);

    -- ── Bone Microstructure ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 55, 'cloze',
     '{{c1::Compact (cortical)}} bone is dense and provides strength; {{c1::spongy (cancellous)}} bone is lighter and contains a lattice of {{c2::trabeculae}} with marrow-filled cavities.',
     2),
    (deck, 56, 'cloze',
     '{{c1::Red}} marrow contains hematopoietic stem cells that generate all blood cells; {{c1::yellow}} marrow is composed primarily of {{c2::fat}} and is relatively inactive.',
     2),
    (deck, 57, 'cloze',
     'Bone matrix has two components: an {{c1::organic}} portion (collagen and glycoproteins) and an {{c1::inorganic}} portion (calcium, phosphate, and hydroxide ions that crystallize as {{c2::hydroxyapatite}}).',
     2),
    (deck, 58, 'cloze',
     'Compact bone is organized into {{c1::osteons (Haversian systems)}} — concentric rings of bone matrix called {{c2::lamellae}} arranged around a central canal.',
     2),
    (deck, 59, 'cloze',
     '{{c1::Haversian canals}} run parallel to the bone''s long axis; {{c1::Volkmann''s canals}} run perpendicular to connect them. Both carry blood vessels and nerves to the osteocytes living in {{c2::lacunae}}.',
     2);

    -- ── Bone Cells + Remodeling + Hormonal Control ──────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 60, 'cloze',
     '{{c1::Osteoblasts}} build new bone by secreting matrix; {{c1::osteoclasts}} (multinucleated bone macrophages) {{c2::resorb}} bone, releasing calcium and phosphate back into the blood.',
     2),
    (deck, 61, 'cloze',
     '{{c1::Osteocytes}} are mature bone cells (former osteoblasts) trapped in {{c2::lacunae}}; they communicate via tiny channels called {{c3::canaliculi}} that allow nutrient and waste exchange.',
     3),
    (deck, 62, 'cloze',
     '{{c1::Parathyroid hormone (PTH)}} is released in response to low blood calcium; it stimulates {{c2::osteoclast}} activity, increasing bone resorption and raising blood Ca²⁺.',
     2),
    (deck, 63, 'cloze',
     '{{c1::Vitamin D}} (activated by PTH) increases intestinal absorption of calcium and reinforces PTH''s effect on bone, ultimately favoring stronger remodeled bone over time.',
     1),
    (deck, 64, 'cloze',
     '{{c1::Calcitonin}}, released by parafollicular cells of the {{c2::thyroid}} in response to high blood calcium, promotes bone formation and {{c3::lowers}} blood calcium — opposing PTH.',
     3),
    (deck, 65, 'cloze',
     'Bone {{c1::remodels}} in response to mechanical stress: regions of high stress build up additional bone, while regions of low stress lose bone mass over time.',
     1);

    -- ── Cartilage + Joints + Muscle Attachments ─────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 66, 'cloze',
     '{{c1::Cartilage}} is softer and more flexible than bone; it consists of a firm but elastic matrix called {{c2::chondrin}} secreted by cells called {{c3::chondrocytes}}.',
     3),
    (deck, 67, 'cloze',
     'In {{c1::endochondral}} ossification, cartilage is gradually replaced by bone (most long bones); in {{c1::intramembranous}} ossification, mesenchymal tissue transforms directly into bone (the skull).',
     1),
    (deck, 68, 'cloze',
     '{{c1::Synarthroses}} (immovable joints) consist of bones fused together by fibrous connective tissue; they are found primarily in the {{c2::skull}}.',
     2),
    (deck, 69, 'cloze',
     '{{c1::Movable joints}} (e.g., hinge, ball-and-socket) are enclosed by a {{c2::synovial capsule}}, which encloses the joint cavity and is strengthened by ligaments.',
     2),
    (deck, 70, 'cloze',
     'The {{c1::synovium}} lines the synovial capsule and secretes {{c2::synovial fluid}} that lubricates joint movement; {{c3::articular cartilage}} caps the bone surfaces to cushion impact.',
     3),
    (deck, 71, 'cloze',
     'The {{c1::origin}} of a muscle is its larger, more stable attachment point; the {{c1::insertion}} is the smaller, more mobile attachment point that gets pulled during contraction.',
     1),
    (deck, 72, 'cloze',
     '{{c1::Antagonistic}} muscle pairs work in opposite directions (one contracts while the other relaxes); {{c1::synergistic}} muscles work together to produce the same movement.',
     1),
    (deck, 73, 'cloze',
     'A {{c1::flexor}} decreases the joint angle; an {{c1::extensor}} increases it. An {{c2::abductor}} moves a limb away from the midline; an {{c2::adductor}} moves it toward the midline.',
     2),
    (deck, 74, 'cloze',
     '{{c1::Medial rotation}} rotates the long axis of a limb toward the midline; {{c1::lateral rotation}} rotates it away from the midline.',
     1);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 75, 'cloze',
     'Contracting skeletal muscles compress the blood vessels running through them; their one-way valves block backflow, so this pump raises {{c1::venous return}}.',
     1),
    (deck, 76, 'cloze',
     'The skeleton protects internal organs: the {{c1::cranium}} surrounds the brain, while the {{c2::rib cage}} shields the heart and lungs.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 77;
END $$;
