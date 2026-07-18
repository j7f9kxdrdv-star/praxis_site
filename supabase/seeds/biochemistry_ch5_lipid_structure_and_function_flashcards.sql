-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 5 — Lipid Structure and Function
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: lipid_structure_and_function
-- Sort order: 5
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--    1. Lipid Fundamentals & Classes
--    2. Storage Lipids — Fatty Acids, Triacylglycerols, Saponification & Micelles
--    3. Phospholipids & Membrane Structure
--    4. Sphingolipids
--    5. Steroids, Cholesterol & Steroid-Hormone Signaling
--    6. Waxes, Terpenes & Terpenoids
--    7. Fat-Soluble Vitamins & Prostaglandins
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- LibreTexts Biochemistry (Lipids) and OpenStax Biology 2e (Ch 3 Biological
-- Macromolecules). Lipid STRUCTURE/FUNCTION only — fatty-acid metabolism
-- (beta-oxidation, ketone bodies) is out of scope (see Ch 11). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'Lipid Structure and Function',
          'Lipid Structure & Function',
          'Biochemistry Review Chapter Five: Lipid Structure and Function'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'lipid_structure_and_function',
        'Lipid Structure and Function',
        'The chemistry and roles of lipids: fatty acids and triacylglycerols, saponification and micelles, phospholipids and membrane structure, sphingolipids, steroids and cholesterol, waxes, terpenes and terpenoids, the fat-soluble vitamins, and prostaglandins.',
        5
    )
    RETURNING id INTO deck;

    -- ── Lipid Fundamentals & Classes ──────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'Lipids are grouped into one class not by a shared chemical structure but by a single physical property: their {{c1::solubility}}.',
     1),
    (deck, 1, 'cloze',
     'Lipids fill three broad biological roles: {{c1::energy storage}}, {{c1::structural components of membranes}}, and {{c1::cell signaling}}.',
     1),
    (deck, 2, 'cloze',
     'A molecule that has both a hydrophilic (polar) region and a hydrophobic (nonpolar) region is described as {{c1::amphipathic (also called amphiphilic)}}.',
     1);

    -- ── Storage Lipids — Fatty Acids, Triacylglycerols, Saponification & Micelles ───
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 3, 'cloze',
     'A fatty acid whose tail has only single carbon–carbon bonds (no C=C) is {{c1::saturated}}.',
     1),
    (deck, 4, 'cloze',
     'A cis carbon–carbon double bond puts a rigid {{c1::kink}} in an unsaturated fatty acid, stopping the chains from packing tightly.',
     1),
    (deck, 5, 'cloze',
     'Tightly packing saturated fats melt at a {{c1::higher}} temperature and are {{c1::solid}} at room temp, while kinked unsaturated fats melt {{c1::lower}} and stay {{c1::liquid}}.',
     1),
    (deck, 6, 'cloze',
     'Omega (ω) numbering of a fatty acid''s carbons starts at the {{c1::methyl}} end of the chain.',
     1),
    (deck, 7, 'cloze',
     'The two essential fatty-acid families humans must get from food are omega-{{c1::3}} and omega-{{c1::6}}.',
     1),
    (deck, 8, 'cloze',
     'A triglyceride joins one glycerol to three fatty acids through {{c1::ester}} bonds, each created by a dehydration reaction that releases a water molecule.',
     1),
    (deck, 9, 'cloze',
     'Gram for gram, triacylglycerols release about {{c1::twice}} the energy of carbohydrates because their carbons are far more {{c2::reduced}}.',
     2),
    (deck, 10, 'cloze',
     'Unlike heavily hydrated {{c1::glycogen}}, hydrophobic triacylglycerols store energy compactly, carrying no extra water weight.',
     1),
    (deck, 11, 'cloze',
     'In animals, triacylglycerols are stored in fat-tissue cells known as {{c1::adipocytes}}.',
     1),
    (deck, 12, 'cloze',
     'In blood, water-insoluble free fatty acids are transported bound to the plasma protein {{c1::albumin}}.',
     1),
    (deck, 13, 'cloze',
     'Boiling a triacylglycerol with a strong base such as NaOH cleaves its ester bonds into glycerol and fatty-acid salts, a reaction called {{c1::saponification}}.',
     1),
    (deck, 14, 'cloze',
     'Soaps are amphipathic surfactants: their polar {{c1::carboxylate}} head dissolves in water while their long hydrocarbon tail does not.',
     1),
    (deck, 15, 'cloze',
     'In water, soaps self-assemble into a {{c1::micelle}} that traps lipid-soluble grime in a hydrophobic core while its outer carboxylate shell keeps it water-soluble.',
     1);

    -- ── Phospholipids & Membrane Structure ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 16, 'cloze',
     'A phospholipid is amphipathic: a hydrophilic phosphate head plus {{c1::two}} hydrophobic {{c2::fatty-acid}} tails.',
     2),
    (deck, 17, 'cloze',
     'A three-carbon {{c1::glycerol}} backbone carrying two fatty acids and a phosphate group is the scaffold of the {{c1::glycerophospholipids}}.',
     1),
    (deck, 18, 'cloze',
     'In a glycerol-based membrane lipid, the polar head group links to the backbone via a {{c1::phosphodiester}} bond.',
     1),
    (deck, 19, 'cloze',
     'The identity of a phospholipid''s {{c1::head group}} determines its specific {{c2::function}}.',
     2),
    (deck, 20, 'cloze',
     'The glycerophospholipid phosphatidylcholine (head group = choline) is also known by the common name {{c1::lecithin}}.',
     1),
    (deck, 21, 'cloze',
     'The degree of fatty-acid {{c1::saturation}} in the tails is the primary structural determinant of membrane {{c2::fluidity}}.',
     2),
    (deck, 22, 'cloze',
     'Because they have a single tail, soaps and free fatty acids form a spherical {{c1::micelle}}, while two-tailed phospholipids instead build a {{c2::bilayer}}.',
     2),
    (deck, 23, 'cloze',
     'Lipid rafts are tightly packed membrane microdomains especially rich in {{c1::cholesterol}} and saturated lipids, and they cluster {{c2::signaling}} proteins.',
     2);

    -- ── Sphingolipids ─────────────────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 24, 'cloze',
     'Ceramide and its derivatives are built on a {{c1::sphingosine}} backbone rather than glycerol.',
     1),
    (deck, 25, 'cloze',
     'The simplest sphingolipid, a {{c1::ceramide}}, is a sphingosine backbone bearing one fatty acid linked through an {{c1::amide}} bond.',
     1),
    (deck, 26, 'cloze',
     'Sphingomyelin links a {{c1::choline or ethanolamine}} head group to its ceramide through a {{c2::phosphodiester}} bond.',
     2),
    (deck, 27, 'cloze',
     'The sphingolipid {{c1::sphingomyelin}} is a major component of the {{c1::myelin}} sheath that insulates neuronal axons.',
     1),
    (deck, 28, 'cloze',
     'A glycosphingolipid with a single sugar is a {{c1::cerebroside}}, while one with two or more sugars is a {{c1::globoside}}.',
     1),
    (deck, 29, 'cloze',
     'A glycosphingolipid replaces sphingomyelin''s {{c1::phosphate}} head group with one or more sugar residues attached directly to the ceramide.',
     1),
    (deck, 30, 'cloze',
     'A ganglioside''s oligosaccharide head group carries one or more terminal {{c1::N-acetylneuraminic acid (NANA / sialic acid)}} residues.',
     1);

    -- ── Steroids, Cholesterol & Steroid-Hormone Signaling ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 31, 'cloze',
     'Steroids are lipids built on a rigid core of {{c1::four}} fused hydrocarbon rings, unlike the flexible chains of fats and phospholipids.',
     1),
    (deck, 32, 'cloze',
     'The steroid ring system is made of three {{c1::cyclohexane}} rings fused to a single {{c1::cyclopentane}} ring.',
     1),
    (deck, 33, 'cloze',
     'The saturated four-ring carbon skeleton shared by all steroids is named {{c1::gonane}}.',
     1),
    (deck, 34, 'cloze',
     'A steroid bearing a hydroxyl (–OH) group at carbon {{c1::3}} of the ring system is called a {{c2::sterol}}.',
     2),
    (deck, 35, 'cloze',
     '{{c1::Cholesterol}} is the most abundant steroid in the human body and the sterol embedded in animal cell membranes.',
     1),
    (deck, 36, 'cloze',
     'Cholesterol stabilizes membrane fluidity as temperature changes: below the transition temperature it {{c1::raises}} fluidity, while above it the rigid ring {{c1::lowers}} fluidity.',
     1),
    (deck, 37, 'cloze',
     'Cholesterol is the biosynthetic precursor of {{c1::bile acids}}, {{c1::steroid hormones}}, and {{c1::vitamin D}}.',
     1),
    (deck, 38, 'cloze',
     'Steroid hormones are lipid-soluble and bind {{c1::intracellular}} receptors that directly alter {{c2::gene transcription}}.',
     2),
    (deck, 39, 'cloze',
     'Hydrophilic peptide hormones cannot cross the membrane, so they bind {{c1::cell-surface receptors}} and relay their signal through {{c1::second messengers}}.',
     1),
    (deck, 40, 'cloze',
     'Steroid hormones act at very {{c1::low}} concentrations because their receptors bind them with very {{c1::high}} affinity.',
     1),
    (deck, 41, 'cloze',
     'Every steroid shares the same four-ring skeleton; individual steroids differ in their {{c1::functional groups}} and {{c1::oxidation state}}.',
     1);

    -- ── Waxes, Terpenes & Terpenoids ──────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'A wax is a long-chain {{c1::fatty acid}} joined to a long-chain {{c1::alcohol}}, forming an extremely {{c2::hydrophobic}} molecule.',
     2),
    (deck, 43, 'cloze',
     'The long-chain fatty acid and long-chain alcohol of a wax are connected by an {{c1::ester}} bond.',
     1),
    (deck, 44, 'cloze',
     'Waxes coat plant and animal surfaces, protecting against {{c1::water loss}} and against {{c1::parasites}}.',
     1),
    (deck, 45, 'cloze',
     'Terpenes are assembled from repeating {{c1::isoprene}} units, each a branched {{c1::five}}-carbon hydrocarbon ({{c1::C₅H₈}}).',
     1),
    (deck, 46, 'cloze',
     'Terpenes are {{c1::odiferous}} molecules that serve as biological precursors to {{c2::steroids}}.',
     2),
    (deck, 47, 'cloze',
     'A monoterpene is built from {{c1::two}} isoprene units, for a total of {{c1::ten}} carbons.',
     1),
    (deck, 48, 'cloze',
     'A terpenoid differs from a terpene by containing {{c1::oxygen}}.',
     1);

    -- ── Fat-Soluble Vitamins & Prostaglandins ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 49, 'cloze',
     'The four fat-soluble vitamins are {{c1::A}}, {{c1::D}}, {{c1::E}}, and {{c1::K}}.',
     1),
    (deck, 50, 'cloze',
     'Unlike water-soluble vitamins, the fat-soluble ones are stored in body fat and poorly excreted, so excess intake can build up and cause {{c1::toxicity}}.',
     1),
    (deck, 51, 'cloze',
     'Vitamin A (carotene) yields two active molecules: {{c1::retinal}}, used by the eye for sight, and {{c1::retinoic acid}}, which directs gene transcription and epithelial development.',
     1),
    (deck, 52, 'cloze',
     'The kidneys convert vitamin D (cholecalciferol) into its active hormonal form, {{c1::calcitriol}}.',
     1),
    (deck, 53, 'cloze',
     'In the intestine, calcitriol (active vitamin D) increases absorption of dietary {{c1::calcium}} and {{c1::phosphate}}.',
     1),
    (deck, 54, 'cloze',
     'Prolonged vitamin D deficiency impairs bone mineralization, causing the childhood bone disease {{c1::rickets}}.',
     1),
    (deck, 55, 'cloze',
     'The body''s main fat-soluble antioxidant is {{c1::vitamin E (tocopherols)}}, donating electrons to neutralize free radicals in membranes.',
     1),
    (deck, 56, 'cloze',
     'Vitamin K is required for the {{c1::γ-carboxylation}} of glutamate residues on prothrombin, a modification that creates calcium-binding sites.',
     1),
    (deck, 57, 'cloze',
     'Prostaglandins belong to the {{c1::eicosanoid}} family of signaling lipids and are synthesized from the fatty acid {{c2::arachidonic acid}}.',
     2),
    (deck, 58, 'cloze',
     'Rather than circulating in blood like hormones, prostaglandins act locally as {{c1::autocrine}} and {{c1::paracrine}} signals.',
     1),
    (deck, 59, 'cloze',
     'Prostaglandins are major mediators of {{c1::pain}} and {{c1::fever}}, which is why NSAIDs like aspirin block the enzyme that produces them.',
     1),
    (deck, 60, 'cloze',
     'Prostaglandins also act on {{c1::smooth muscle}} to modulate its contraction.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 61;
END $$;
