-- ════════════════════════════════════════════════════════════════════
-- Biology Chapter 8 — The Immune System
-- ════════════════════════════════════════════════════════════════════
-- Section: biology
-- Topic:   Body Systems
-- Subtopic slug: the_immune_system
-- Sort order: 8
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--    1. Innate vs. Adaptive Immunity
--    2. Immune Tissues & Cell Origin
--    3. Innate Defenses & Cells
--    4. Antigen Presentation & MHC
--    5. Humoral Immunity — B-cells & Antibodies
--    6. Cell-Mediated Immunity — T-cells
--    7. Clonal Selection & Immunologic Memory
--    8. Self vs. Non-self — Autoimmunity & Hypersensitivity
--    9. Active vs. Passive Immunity & Vaccination
--   10. The Lymphatic System
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Anatomy & Physiology 2e (Ch 21, The Lymphatic and Immune System)
-- and OpenStax Biology 2e (Ch 42, The Immune System). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'biology'
      AND title IN (
          'The Immune System',
          'Immune System',
          'Biology Review Chapter Eight: The Immune System'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biology',
        'Body Systems',
        'the_immune_system',
        'The Immune System',
        'Innate vs. adaptive immunity, immune tissues, innate defenses and cells, antigen presentation and MHC, humoral (B-cell/antibody) and cell-mediated (T-cell) immunity, clonal selection and memory, self-tolerance and autoimmunity, active/passive immunity and vaccination, and the lymphatic system.',
        8
    )
    RETURNING id INTO deck;

    -- ── Innate vs. Adaptive Immunity ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'The innate immune response acts {{c1::rapidly}}, whereas the adaptive response develops more {{c1::slowly}} on a first exposure to a pathogen.',
     1),
    (deck, 1, 'cloze',
     'The innate immune response is {{c1::nonspecific}}, whereas the adaptive response is {{c1::specific}}.',
     1),
    (deck, 2, 'cloze',
     'Of the two arms, only {{c1::adaptive}} immunity forms lasting immunologic memory and so responds faster and stronger when the same pathogen returns.',
     1),
    (deck, 3, 'cloze',
     'Despite differing in speed and specificity, the cellular defenses of both the innate and adaptive arms are carried out by {{c1::leukocytes (white blood cells)}}.',
     1);

    -- ── Immune Tissues & Cell Origin ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 4, 'cloze',
     'All blood cells, including every leukocyte, ultimately arise from one self-renewing precursor: the {{c1::hematopoietic stem cell}}.',
     1),
    (deck, 5, 'cloze',
     'In adults, hemopoiesis (the formation of blood cells) takes place in the {{c1::red bone marrow}}.',
     1),
    (deck, 6, 'cloze',
     'B cells finish maturing in the {{c1::bone marrow}}, whereas T cells finish maturing in the {{c2::thymus}}.',
     2),
    (deck, 7, 'cloze',
     'The bone marrow and thymus, where lymphocytes develop and mature, are together called the {{c1::primary}} lymphoid organs.',
     1),
    (deck, 8, 'cloze',
     'The lymph nodes and spleen, where mature lymphocytes are activated and mount responses to antigen, are the {{c1::secondary}} lymphoid organs.',
     1),
    (deck, 9, 'cloze',
     'A monocyte is a circulating blood leukocyte that migrates into the tissues and differentiates into a {{c1::macrophage}}.',
     1),
    (deck, 10, 'cloze',
     'Gut-associated lymphoid tissue (GALT) comprises the tonsils, adenoids, {{c1::Peyer''s patches}} of the small intestine, and the {{c1::appendix}}.',
     1);

    -- ── Innate Defenses & Cells ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 11, 'cloze',
     'Intact skin resists microbes because its dead surface layer is dry and heavily {{c1::keratinized}}, and its sweat and sebaceous secretions keep the surface {{c2::acidic}}.',
     2),
    (deck, 12, 'cloze',
     'The enzyme {{c1::lysozyme}}, found in tears and saliva, kills bacteria by digesting their {{c2::cell walls}}.',
     2),
    (deck, 13, 'cloze',
     'In the airways, {{c1::mucus}} traps inhaled microbes, and beating {{c2::cilia}} continuously sweep the trapped debris upward toward the throat to be swallowed.',
     2),
    (deck, 14, 'cloze',
     'The stomach destroys many swallowed pathogens with its highly {{c1::acidic}} environment, while the gut''s normal {{c2::flora}} outcompete invaders for nutrients and space.',
     2),
    (deck, 15, 'cloze',
     'Defensins are antimicrobial {{c1::peptides}} — not enzymes — that kill microbes by puncturing their {{c2::plasma membranes}}.',
     2),
    (deck, 16, 'cloze',
     'A phagocyte engulfs a pathogen into a phagosome, which then fuses with a {{c1::lysosome}} to digest the microbe.',
     1),
    (deck, 17, 'cloze',
     'A {{c1::macrophage}} is the most versatile, tissue-resident phagocyte; it engulfs pathogens and debris and secretes {{c2::cytokines}} that recruit other immune cells.',
     2),
    (deck, 18, 'cloze',
     'The most abundant leukocyte, the {{c1::neutrophil}}, is a granulocyte rushed from the blood to infection sites; accumulations of these dead phagocytes form {{c2::pus}}.',
     2),
    (deck, 19, 'cloze',
     'By carrying captured antigen from infected tissue to the lymph nodes, the {{c1::dendritic cell}} bridges the innate and adaptive immune responses.',
     1),
    (deck, 20, 'cloze',
     'The {{c1::eosinophil}} is a granulocyte specialized to attack large multicellular {{c2::parasites}}, releasing toxic proteins from its granules.',
     2),
    (deck, 21, 'cloze',
     'Injured tissue triggers {{c1::mast cells and basophils}} to release {{c2::histamine}}, which causes vasodilation and increased capillary permeability at the site.',
     2),
    (deck, 22, 'cloze',
     'Unlike the agranulocytes (lymphocytes and monocytes), the granulocytes — {{c1::neutrophils, eosinophils, and basophils}} — carry prominent cytoplasmic granules.',
     1),
    (deck, 23, 'cloze',
     'Complement proteins opsonize microbes, recruit phagocytes by chemotaxis, and assemble a {{c1::membrane attack complex}} whose pores puncture the pathogen, causing {{c2::osmotic lysis}}.',
     2),
    (deck, 24, 'cloze',
     'Immune cells coordinate their responses by secreting {{c1::cytokines}}, small signaling proteins that act as chemical messengers between cells.',
     1),
    (deck, 25, 'cloze',
     'Cells infected by a virus secrete {{c1::interferons}}, which signal neighboring cells to make antiviral proteins and limit the virus''s spread.',
     1),
    (deck, 26, 'cloze',
     'Natural killer (NK) cells kill {{c1::virus-infected and cancerous}} cells by triggering their {{c2::apoptosis}}.',
     2),
    (deck, 27, 'cloze',
     'NK cells destroy ''{{c1::missing-self}}'' targets — virus-infected or tumor cells that have {{c1::downregulated MHC class I}}.',
     1),
    (deck, 28, 'cloze',
     '{{c1::Pattern recognition receptors}} let innate immune cells detect conserved molecular patterns shared by many pathogens; a classic example is {{c1::Toll-like receptors}}.',
     1),
    (deck, 29, 'cloze',
     'The four cardinal signs of inflammation are {{c1::redness, heat, swelling, and pain}}; loss of function is sometimes named as a fifth.',
     1);

    -- ── Antigen Presentation & MHC ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 30, 'cloze',
     'A foreign, “non-self” molecule that triggers an immune response is an {{c1::antigen}}.',
     1),
    (deck, 31, 'cloze',
     'The specific small region of an antigen that a receptor or antibody actually binds is its {{c1::epitope}}, also called an {{c1::antigenic determinant}}.',
     1),
    (deck, 32, 'cloze',
     'The three professional antigen-presenting cells are {{c1::macrophages}}, {{c1::dendritic cells}}, and {{c1::B cells}}.',
     1),
    (deck, 33, 'cloze',
     'MHC class I molecules present {{c1::endogenous (intracellular)}} antigens to {{c2::CD8⁺ cytotoxic}} T cells.',
     2),
    (deck, 34, 'cloze',
     'MHC class II molecules present {{c1::exogenous (extracellular)}} antigens to {{c1::CD4⁺ helper}} T cells.',
     1),
    (deck, 35, 'cloze',
     'MHC class I is expressed on virtually all {{c1::nucleated}} cells, whereas MHC class II appears only on {{c2::professional antigen-presenting}} cells.',
     2);

    -- ── Humoral Immunity — B-cells & Antibodies ───────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 36, 'cloze',
     'Once activated, a naïve B cell differentiates into a {{c1::plasma cell}}, which secretes antibody, or a {{c2::memory B cell}}, which enables a faster secondary response.',
     2),
    (deck, 37, 'cloze',
     'Every antibody is built from {{c1::two}} identical heavy chains and {{c1::two}} identical light chains held together by disulfide bonds.',
     1),
    (deck, 38, 'cloze',
     'Each antibody chain has a constant region plus a {{c1::variable}} region; the {{c1::variable}} regions form the antigen-binding site and set the antibody''s specificity.',
     1),
    (deck, 39, 'cloze',
     'As a nonenzymatic protein, an antibody acts not by catalysis but by {{c1::binding}} its specific antigen with high {{c1::affinity}}.',
     1),
    (deck, 40, 'cloze',
     'Secreted antibodies fight pathogens by {{c1::neutralization}} (blocking infective sites), {{c2::opsonization}} (tagging them for phagocytes), and {{c3::agglutination}} (clumping them together).',
     3),
    (deck, 41, 'cloze',
     'Producing IgG, IgA, or IgE instead of IgM — a new antibody isotype with the same antigen specificity — is called {{c1::class switching}}.',
     1),
    (deck, 42, 'cloze',
     'Somatic {{c1::hypermutation}} of variable-region genes lets activated B cells refine their antibodies, progressively raising their binding {{c2::affinity}} for the antigen.',
     2),
    (deck, 43, 'cloze',
     'The most abundant antibody in serum (~80%) and the only class that crosses the placenta to protect the fetus is {{c1::IgG}}.',
     1),
    (deck, 44, 'cloze',
     'The first antibody class secreted in a primary response, assembled as a ten-site pentamer, is {{c1::IgM}}.',
     1),
    (deck, 45, 'cloze',
     '{{c1::IgA}} is the main antibody in secretions—saliva, tears, mucus, and breast milk—that guard mucosal surfaces.',
     1),
    (deck, 46, 'cloze',
     '{{c1::IgE}} binds mast cells to drive allergic reactions and anaphylaxis, and also mediates defense against parasitic worms.',
     1),
    (deck, 47, 'cloze',
     'Co-expressed with IgM on naïve B cells, {{c1::IgD}} serves as an antigen receptor but has little other known function.',
     1);

    -- ── Cell-Mediated Immunity — T-cells ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 48, 'cloze',
     'Helper T cells bear the {{c1::CD4}} co-receptor and recognize antigen displayed on class {{c1::II}} MHC molecules.',
     1),
    (deck, 49, 'cloze',
     'Helper T cells secrete {{c1::cytokines}} to enhance and coordinate the activity of other immune cells.',
     1),
    (deck, 50, 'cloze',
     'Cytotoxic T cells bear the {{c1::CD8}} co-receptor and recognize antigen displayed on class {{c1::I}} MHC molecules.',
     1),
    (deck, 51, 'cloze',
     'Cytotoxic T cells destroy virus-infected target cells by inducing {{c1::apoptosis}}.',
     1),
    (deck, 52, 'cloze',
     'Regulatory (suppressor) T cells dampen other T-cell responses to maintain {{c1::self-tolerance}}.',
     1),
    (deck, 53, 'cloze',
     'Memory T cells are {{c1::long-lived}} and mount a much {{c1::faster}} response on re-exposure to the same pathogen.',
     1),
    (deck, 54, 'cloze',
     'In thymic positive selection, a thymocyte survives only if its receptor can bind {{c1::self-MHC}} molecules.',
     1),
    (deck, 55, 'cloze',
     'In thymic negative selection, thymocytes whose receptors bind {{c1::self-antigens}} too strongly are deleted by apoptosis.',
     1);

    -- ── Clonal Selection & Immunologic Memory ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 56, 'cloze',
     'The theory that an antigen stimulates a preexisting lymphocyte whose receptor already matches it—rather than instructing the receptor''s shape—is {{c1::clonal selection}}.',
     1),
    (deck, 57, 'cloze',
     'After an antigen selects a matching lymphocyte, that cell divides repeatedly into many identical daughter cells—a process termed {{c1::clonal expansion}}.',
     1),
    (deck, 58, 'cloze',
     'On re-exposure, the secondary adaptive response is both {{c1::faster}} and {{c1::stronger}} than the primary response, often clearing the pathogen before symptoms appear.',
     1),
    (deck, 59, 'cloze',
     '{{c1::Memory}} B and T cells arise during the primary response but do not become effector cells then; they persist for years and rapidly do so upon re-exposure.',
     1);

    -- ── Self vs. Non-self — Autoimmunity & Hypersensitivity ───────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 60, 'cloze',
     'When a self-reactive T cell escapes thymic deletion, self-{{c1::tolerance}} breaks down and autoimmune disease can follow.',
     1),
    (deck, 61, 'cloze',
     'In multiple sclerosis, autoimmune attack destroys {{c1::myelin}} in the central nervous system, disrupting nerve conduction.',
     1),
    (deck, 62, 'cloze',
     'An allergy is a type I (immediate) hypersensitivity in which {{c1::IgE}} antibodies against a harmless allergen coat mast cells.',
     1),
    (deck, 63, 'cloze',
     'When an allergen crosslinks IgE on a mast cell, the cell degranulates and releases {{c1::histamine}}, producing allergy symptoms.',
     1);

    -- ── Active vs. Passive Immunity & Vaccination ─────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 64, 'cloze',
     'Active immunity is resistance from {{c1::your own}} adaptive response making antibodies — acquired naturally by infection or artificially by {{c2::vaccination}}.',
     2),
    (deck, 65, 'cloze',
     'Because passive immunity supplies ready-made antibodies instead of triggering the recipient''s own response, it produces {{c1::no immunological memory}} and its protection soon fades.',
     1),
    (deck, 66, 'cloze',
     'Passive immunity is natural when {{c1::maternal antibodies cross the placenta or pass through breast milk}}, and artificial when {{c2::immunoglobulins are injected (IVIg)}}.',
     2),
    (deck, 67, 'cloze',
     'Vaccines fall into three types: {{c1::live-attenuated}} (whole pathogen that still replicates weakly), {{c2::inactivated}} (whole pathogen that can no longer replicate), and {{c3::subunit}} (isolated antigens only).',
     3),
    (deck, 68, 'cloze',
     'Vaccination exposes you to antigen that cannot produce the full {{c1::disease}}, yet still generates the {{c2::memory cells}} that give long-term protection.',
     2);

    -- ── The Lymphatic System ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 69, 'cloze',
     'Most fluid that leaks from capillaries into the tissues is reabsorbed by the blood; the small excess left behind is returned to circulation by the {{c1::lymphatic system}}.',
     1),
    (deck, 70, 'cloze',
     'Blocked or destroyed lymphatic drainage lets protein-rich fluid back up in the tissues, a condition called {{c1::lymphedema}}.',
     1),
    (deck, 71, 'cloze',
     'In the small intestine, specialized lymphatic capillaries called {{c1::lacteals}} absorb dietary fat packaged as {{c2::chylomicrons}}.',
     2),
    (deck, 72, 'cloze',
     'Dietary fats and fat-soluble vitamins enter {{c1::lymphatic}} vessels rather than blood capillaries because chylomicrons are too large to enter them directly.',
     1),
    (deck, 73, 'cloze',
     'Lymph re-enters the blood mainly through the {{c1::thoracic duct}} (into the left subclavian vein); the smaller {{c2::right lymphatic duct}} drains only the upper right body.',
     2),
    (deck, 74, 'cloze',
     'Spaced along the lymphatic vessels, {{c1::lymph nodes}} filter the passing lymph and serve as sites where lymphocytes are activated and proliferate.',
     1),
    (deck, 75, 'cloze',
     'Once {{c1::interstitial}} fluid drains into the lymphatic capillaries, it is renamed lymph.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 76;
END $$;
