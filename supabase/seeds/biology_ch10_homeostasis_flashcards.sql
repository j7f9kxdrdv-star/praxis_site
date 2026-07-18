-- ════════════════════════════════════════════════════════════════════
-- Biology Chapter 10 — Homeostasis (Excretory System & Skin)
-- ════════════════════════════════════════════════════════════════════
-- Section: biology
-- Topic:   Body Systems
-- Subtopic slug: homeostasis
-- Sort order: 10
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--    1. Excretory Functions & Kidney Anatomy
--    2. The Nephron & the Three Processes
--    3. Nephron Segments
--    4. Hormonal Control of the Kidney
--    5. Urine Storage & Elimination
--    6. Skin Structure & Layers
--    7. Skin Sensory Receptors
--    8. Thermoregulation & Skin Homeostasis
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Anatomy & Physiology 2e (Ch 5 Integumentary System, Ch 25 Urinary System) and
-- OpenStax Biology 2e (Ch 41 Osmotic Regulation and Excretion). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'biology'
      AND title IN (
          'Homeostasis',
          'Homeostasis (Excretory System & Skin)',
          'The Excretory System',
          'Biology Review Chapter Ten: Homeostasis'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biology',
        'Body Systems',
        'homeostasis',
        'Homeostasis',
        'Homeostatic regulation by the excretory system and skin: kidney anatomy and the nephron, glomerular filtration/secretion/reabsorption, the countercurrent multiplier, hormonal control (RAAS, aldosterone, ADH), urine storage and elimination, skin layers and cell types, cutaneous sensory receptors, and thermoregulation.',
        10
    )
    RETURNING id INTO deck;

    -- ── Excretory Functions & Kidney Anatomy ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'The excretory system maintains homeostasis by regulating {{c1::blood pressure}}, {{c1::blood osmolarity}}, and {{c1::acid–base balance}}, while clearing {{c1::nitrogenous wastes}}.',
     1),
    (deck, 1, 'cloze',
     'In mammals the liver converts toxic ammonia into {{c1::urea}}, the principal soluble nitrogenous waste that the kidneys then excrete.',
     1),
    (deck, 2, 'cloze',
     'The kidneys are paired organs positioned high against the posterior abdominal wall, within the {{c1::retroperitoneal}} space.',
     1),
    (deck, 3, 'cloze',
     'At rest the kidneys are heavily perfused, receiving about {{c1::25}}% of the total cardiac output.',
     1),
    (deck, 4, 'cloze',
     'A frontal section of the kidney reveals an outer {{c1::cortex}} surrounding an inner {{c1::medulla}}.',
     1),
    (deck, 5, 'cloze',
     'The {{c1::nephron}} is the functional unit of the kidney — the microscopic structure that cleanses the blood.',
     1),
    (deck, 6, 'cloze',
     'Two capillary beds connected in series make the kidney''s blood supply a {{c1::portal}} system.',
     1),
    (deck, 7, 'cloze',
     'In renal blood flow the first capillary bed is the {{c1::glomerulus}}; blood then reaches the second bed, the {{c2::vasa recta and peritubular capillaries}}.',
     2),
    (deck, 8, 'cloze',
     'Blood enters the glomerulus through the {{c1::afferent arteriole}} and leaves through the {{c1::efferent arteriole}}, which carries it on to the second capillary bed.',
     1),
    (deck, 9, 'cloze',
     'The renal portal system is the only portal system in which an {{c1::arteriole}} sits between the two capillary beds.',
     1);

    -- ── The Nephron & the Three Processes ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
     'In the kidney, {{c1::filtration}} forces water and small solutes from the blood into the nephron, and it happens only at {{c2::Bowman''s capsule (the glomerulus)}}.',
     2),
    (deck, 11, 'cloze',
     '{{c1::Secretion}} moves solutes from blood into filtrate at any site other than {{c2::Bowman''s capsule}}.',
     2),
    (deck, 12, 'cloze',
     'Moving solutes from the filtrate back into the blood is called {{c1::reabsorption}}.',
     1),
    (deck, 13, 'cloze',
     'Glomerular filtration sorts by particle size: water, ions, glucose, and amino acids pass into the filtrate, while {{c1::blood cells and large plasma proteins}} stay behind in circulation.',
     1),
    (deck, 14, 'cloze',
     'The fresh filtrate in Bowman''s capsule has nearly the same composition as blood plasma, differing mainly by its near-total lack of {{c1::proteins}}.',
     1),
    (deck, 15, 'cloze',
     'The set of opposing hydrostatic and oncotic pressures that determines net glomerular filtration is known collectively as the {{c1::Starling forces}}.',
     1),
    (deck, 16, 'cloze',
     'At the glomerulus, filtration is powered by the blood''s {{c1::hydrostatic}} pressure pushing fluid outward, opposed by its {{c1::colloid osmotic (oncotic)}} pressure pulling fluid back in.',
     1);

    -- ── Nephron Segments ──────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 17, 'cloze',
     'The {{c1::proximal convoluted tubule}} reabsorbs nearly all filtered {{c2::glucose, amino acids, and vitamins}}, along with about two-thirds of the water and Na⁺.',
     2),
    (deck, 18, 'cloze',
     'The {{c1::proximal convoluted tubule}} not only reabsorbs solutes but also secretes wastes such as {{c2::H⁺, ammonia, and certain drugs}} into the filtrate.',
     2),
    (deck, 19, 'cloze',
     'The loop of Henle''s descending limb reabsorbs {{c1::water}} but is impermeable to {{c1::salt}}.',
     1),
    (deck, 20, 'cloze',
     'The loop of Henle''s ascending limb is impermeable to {{c1::water}} and actively reabsorbs {{c2::salt (Na⁺/Cl⁻)}}.',
     2),
    (deck, 21, 'cloze',
     'The hyperosmotic medullary gradient is created chiefly by the {{c1::thick ascending}} limb pumping {{c2::NaCl}} into the medullary interstitium.',
     2),
    (deck, 22, 'cloze',
     'Kidney interstitial osmolality climbs from about {{c1::300}} mOsm/kg at the cortex to roughly {{c1::1200}} mOsm/kg in the inner medulla.',
     1),
    (deck, 23, 'cloze',
     'As the {{c1::collecting duct}} descends through the hyperosmotic medulla, its {{c2::variable}} water permeability lets water exit osmotically, concentrating the urine.',
     2),
    (deck, 24, 'cloze',
     'The {{c1::distal convoluted tubule}} adjusts the filtrate by reabsorbing Na⁺ and secreting K⁺, largely under the hormone {{c2::aldosterone}}.',
     2),
    (deck, 25, 'cloze',
     'Blood flows {{c1::slowly}} through the {{c2::vasa recta}} so it can recover water and solutes without washing out the medullary osmotic gradient.',
     2),
    (deck, 26, 'cloze',
     'The loop of Henle concentrates urine by building a hyperosmotic medullary gradient, a mechanism named the {{c1::counter-current multiplier}}.',
     1);

    -- ── Hormonal Control of the Kidney ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 27, 'cloze',
     'Aldosterone, the final hormone of the renin–angiotensin–aldosterone system (RAAS), is a {{c1::steroid}} secreted by the {{c1::adrenal cortex}}.',
     1),
    (deck, 28, 'cloze',
     'ADH (vasopressin), a {{c1::peptide}} hormone, is produced by neurosecretory cells of the {{c2::hypothalamus}} and released from the {{c2::posterior pituitary}}.',
     2),
    (deck, 29, 'cloze',
     'Two signals trigger ADH release: low blood {{c1::volume}} or high blood {{c2::osmolarity}}.',
     2),
    (deck, 30, 'cloze',
     'The kidney fine-tunes blood pH by selectively reabsorbing or secreting {{c1::bicarbonate (HCO₃⁻)}} and {{c1::hydrogen ions (H⁺)}}.',
     1),
    (deck, 31, 'cloze',
     'A drop in blood pressure or volume prompts the {{c1::juxtaglomerular}} cells of the afferent arteriole to release the enzyme {{c1::renin}}, kicking off the cascade that restores pressure.',
     1),
    (deck, 32, 'cloze',
     'Aldosterone raises renal {{c1::Na⁺}} reabsorption, expanding blood volume and pressure while leaving plasma osmolarity {{c2::unchanged}}.',
     2),
    (deck, 33, 'cloze',
     'ADH makes the collecting duct more permeable, so more {{c1::water}} is reabsorbed; blood volume rises and blood osmolarity {{c1::falls}}.',
     1);

    -- ── Urine Storage & Elimination ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     'After leaving the collecting ducts, urine drains through the renal pelvis into the {{c1::ureter}}, is stored in the {{c2::bladder}}, and exits the body through the {{c3::urethra}}.',
     3),
    (deck, 35, 'cloze',
     'Urine does not reach the bladder by gravity alone; smooth muscle in the ureter wall drives it forward with rhythmic waves of {{c1::peristalsis}}.',
     1),
    (deck, 36, 'cloze',
     'The bladder wall is built from interlacing smooth muscle called the {{c1::detrusor}}, which contracts forcefully to expel urine.',
     1),
    (deck, 37, 'cloze',
     'The internal urethral sphincter is {{c1::smooth muscle under involuntary (autonomic) control}}.',
     1),
    (deck, 38, 'cloze',
     'The external urethral sphincter is {{c1::skeletal muscle under voluntary (conscious) control}}.',
     1),
    (deck, 39, 'cloze',
     'The micturition reflex is a spinal {{c1::parasympathetic}} reflex that makes the detrusor contract while the internal urethral sphincter relaxes, voiding the bladder.',
     1);

    -- ── Skin Structure & Layers ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 40, 'cloze',
     'From deepest to most superficial, the five epidermal strata are the stratum {{c1::basale}}, {{c2::spinosum}}, {{c3::granulosum}}, {{c4::lucidum}}, and {{c5::corneum}}.',
     5),
    (deck, 41, 'cloze',
     'The extra fifth stratum, present only in the thick skin of the palms and soles, is the stratum {{c1::lucidum}}.',
     1),
    (deck, 42, 'cloze',
     'Stem cells in the stratum {{c1::basale}} divide to produce {{c2::keratinocytes}}, cells that synthesize {{c2::keratin}} to harden and waterproof the skin, hair, and nails.',
     2),
    (deck, 43, 'cloze',
     'Packed with dead, keratin-filled cells, the outermost stratum {{c1::corneum}} makes the skin''s surface relatively {{c2::impermeable}} to water and blocks microbes.',
     2),
    (deck, 44, 'cloze',
     'The {{c1::epidermis}} is avascular (no blood vessels) and depends on diffusion of nutrients from the underlying {{c1::dermis}}, which is well vascularized.',
     1),
    (deck, 45, 'cloze',
     'In the stratum basale, {{c1::melanocytes}} make the UV-absorbing pigment {{c1::melanin}} and pass it to keratinocytes, shielding their {{c2::DNA}} from radiation.',
     2),
    (deck, 46, 'cloze',
     'The epidermis''s resident immune cells are the {{c1::Langerhans}} cells, dendritic cells that act as {{c2::antigen-presenting}} cells against invading pathogens.',
     2),
    (deck, 47, 'cloze',
     'The hypodermis, or subcutaneous layer, is composed mainly of {{c1::adipose}} tissue and connective tissue, and it anchors the skin to underlying muscle and bone.',
     1),
    (deck, 48, 'cloze',
     'Beyond the epidermal barrier, extra physical protection comes from hard {{c1::nails}} shielding the fingertips, protective {{c2::hair}}, and thick {{c3::calluses}} that build up where skin is repeatedly rubbed.',
     3),
    (deck, 49, 'cloze',
     'From superficial to deep, the skin''s three layers are the {{c1::epidermis}}, the {{c1::dermis}}, and the {{c1::hypodermis}}.',
     1),
    (deck, 50, 'cloze',
     'Below the epidermis, the dermis has two layers: a superficial {{c1::papillary}} layer and a deeper {{c1::reticular}} layer of dense connective tissue.',
     1);

    -- ── Skin Sensory Receptors ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     'Steady, sustained pressure and fine texture are detected by {{c1::Merkel cells (tactile discs)}}.',
     1),
    (deck, 52, 'cloze',
     'The tactile corpuscle, which transduces light touch in the dermal papillae, is known by the eponym {{c1::Meissner}}.',
     1),
    (deck, 53, 'cloze',
     'Deep pressure and high-frequency vibration are detected by {{c1::lamellated (Pacinian) corpuscles}}.',
     1),
    (deck, 54, 'cloze',
     'Stretching of the skin is detected by {{c1::bulbous corpuscles (Ruffini endings)}}.',
     1),
    (deck, 55, 'cloze',
     'Pain and temperature are detected by {{c1::free nerve endings}}.',
     1);

    -- ── Thermoregulation & Skin Homeostasis ───────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 56, 'cloze',
     'Dermal blood vessels respond to temperature: {{c1::vasodilation}} in heat dumps excess heat, while {{c1::vasoconstriction}} in cold conserves core heat.',
     1),
    (deck, 57, 'cloze',
     'Sweat cools the body only when it {{c1::evaporates}}, drawing heat away from the skin surface.',
     1),
    (deck, 58, 'cloze',
     'In the cold, the brain drives skeletal muscles to contract rapidly and randomly, generating heat; this reflex is called {{c1::shivering}}.',
     1),
    (deck, 59, 'cloze',
     'Sweat glands are coiled exocrine glands embedded in the {{c1::dermis}}, with a duct that carries sweat up to a surface pore.',
     1),
    (deck, 60, 'cloze',
     'The skin''s keratinized barrier limits loss of {{c1::water}} and {{c1::salt}} from the body.',
     1),
    (deck, 61, 'cloze',
     'Contraction of the {{c1::arrector pili}} muscles pulls hairs upright, trapping an insulating layer of air against the skin.',
     1),
    (deck, 62, 'cloze',
     'Sweat glands are the key exception: their postganglionic {{c1::sympathetic}} fibers release {{c2::acetylcholine}}.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 63;
END $$;
