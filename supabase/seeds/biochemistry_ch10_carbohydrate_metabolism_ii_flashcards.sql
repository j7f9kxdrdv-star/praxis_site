-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 10 — Carbohydrate Metabolism II
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: carbohydrate_metabolism_ii
-- Sort order: 10
--
-- Coverage (AAMC-aligned order):
--   1.  Acetyl-CoA & Its Sources
--   2.  PDH Complex Overview
--   3.  PDH Enzyme Mechanism
--   4.  PDH Regulation
--   5.  Fatty Acid β-Oxidation
--   6.  Other Acetyl-CoA Sources + Pentose Phosphate Pathway
--   7.  TCA Cycle Overview & Location
--   8.  TCA Steps 1-4 (citrate → α-ketoglutarate)
--   9.  TCA Steps 5-8 (succinyl-CoA → oxaloacetate)
--   10. TCA Regulation
--   11. ETC Overview & Driving Force
--   12. ETC Complexes I & II
--   13. ETC Complexes III & IV
--   14. NADH Shuttles
--   15. ATP Synthase & Proton Motive Force
--   16. ATP Yield & Respiratory Control
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- LibreTexts Biochemistry (Pyruvate Dehydrogenase, Citric Acid Cycle,
-- Electron Transport Chain, Oxidative Phosphorylation) and OpenStax
-- Biology 2e (Ch 7 Cellular Respiration), and the AAMC Foundation 1D
-- Concept 3 content outline. See companion .verification.md for per-card
-- citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'Carbohydrate Metabolism II',
          'Carbohydrate Metabolism 2',
          'Biochemistry Review Chapter 10: Carbohydrate Metabolism 2'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'carbohydrate_metabolism_ii',
        'Carbohydrate Metabolism II',
        'Acetyl-CoA generation (pyruvate dehydrogenase complex, fatty acid β-oxidation, amino acid catabolism, ketone bodies, alcohol); citric acid cycle (eight enzymatic steps, regulation at three checkpoints); electron transport chain (four complexes, reduction potential, proton pumping); NADH shuttles; ATP synthase and the proton motive force (chemiosmotic and conformational coupling); ATP yield per glucose; respiratory control. Includes a brief introduction to the pentose phosphate pathway.',
        10
    )
    RETURNING id INTO deck;

    -- ── Acetyl-CoA & Its Sources ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     '{{c1::Acetyl-CoA}} is the central two-carbon entry point into the citric acid cycle; it can be made from carbohydrates, fatty acids, ketogenic amino acids, ketone bodies, and {{c2::ethanol}}.',
     2),
    (deck, 1, 'cloze',
     'The high-energy bond in acetyl-CoA is a {{c1::thioester}} bond between the acetyl group and the {{c2::-SH}} (sulfhydryl) group of coenzyme A; hydrolysis releases enough energy to drive other reactions.',
     2),
    (deck, 2, 'cloze',
     'From carbohydrates, acetyl-CoA is formed when {{c1::pyruvate}} (the product of glycolysis) is decarboxylated by the {{c2::pyruvate dehydrogenase complex}} in the mitochondrial matrix.',
     2),
    (deck, 3, 'cloze',
     'Acetyl-CoA can be generated from {{c1::pyruvate}} (carbohydrate), {{c1::fatty acids}} (β-oxidation), {{c1::ketogenic amino acids}}, {{c1::ketone bodies}}, and {{c1::ethanol}}.',
     1);

    -- ── PDH Complex Overview ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 4, 'cloze',
     'The {{c1::pyruvate dehydrogenase (PDH) complex}} catalyzes the link reaction between glycolysis and the TCA cycle (pyruvate → acetyl-CoA); it resides in the {{c2::mitochondrial matrix}}.',
     2),
    (deck, 5, 'cloze',
     'Net PDH reaction: pyruvate + {{c1::CoA-SH}} + {{c1::NAD⁺}} → acetyl-CoA + {{c2::CO₂}} + {{c2::NADH}}; the reaction is exergonic and effectively irreversible.',
     2),
    (deck, 6, 'cloze',
     'PDH requires five cofactors: {{c1::TPP (vitamin B₁)}}, lipoamide (lipoic acid), {{c1::FAD (vitamin B₂)}}, NAD⁺, and CoA-SH; Mg²⁺ is also required.',
     1);

    -- ── PDH Enzyme Mechanism ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
     '{{c1::Pyruvate dehydrogenase (E1)}} of the PDH complex oxidatively decarboxylates pyruvate, releasing {{c2::CO₂}} and transferring the remaining two-carbon group to lipoamide.',
     2),
    (deck, 8, 'cloze',
     '{{c1::Dihydrolipoyl transacetylase (E2)}} transfers the two-carbon acetyl group from {{c2::lipoamide}} to coenzyme A, forming acetyl-CoA that enters the TCA cycle.',
     2),
    (deck, 9, 'cloze',
     '{{c1::Dihydrolipoyl dehydrogenase (E3)}} reoxidizes the reduced lipoamide back to its active form, transferring electrons to FAD and ultimately reducing {{c2::NAD⁺ to NADH}}.',
     2);

    -- ── PDH Regulation ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
     'PDH is allosterically inhibited by its own products {{c1::acetyl-CoA}} and {{c1::NADH}}, providing negative feedback when downstream demand is low.',
     1),
    (deck, 11, 'cloze',
     '{{c1::PDH kinase}} phosphorylates and {{c2::inactivates}} PDH when cellular ATP or NADH levels are high (i.e., when energy supply already exceeds demand).',
     2),
    (deck, 12, 'cloze',
     '{{c1::PDH phosphatase}} dephosphorylates and {{c2::reactivates}} PDH when {{c3::ADP}} levels rise — a signal that the cell needs more ATP production.',
     3);

    -- ── Fatty Acid β-Oxidation ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 13, 'cloze',
     'Fatty acid {{c1::β-oxidation}} occurs in the {{c2::mitochondrial matrix}} and produces acetyl-CoA by removing two-carbon units from the carboxyl end of the fatty acid chain.',
     2),
    (deck, 14, 'cloze',
     'Long-chain fatty acyl-CoA cannot cross the inner mitochondrial membrane on its own; it is transferred to {{c1::carnitine}} for transport into the matrix, then handed back to a mitochondrial {{c2::CoA-SH}}.',
     2),
    (deck, 15, 'cloze',
     'Each round of β-oxidation removes one {{c1::two-carbon}} acetyl-CoA unit from the carboxyl end and produces one {{c2::NADH}} and one {{c2::FADH₂}} for the ETC.',
     2);

    -- ── Other Acetyl-CoA Sources + Pentose Phosphate Pathway ────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 16, 'cloze',
     '{{c1::Ketogenic}} amino acids (e.g., leucine, lysine) feed into acetyl-CoA or ketone bodies and {{c2::cannot}} contribute to glucose synthesis; purely ketogenic AAs are only leucine and lysine.',
     2),
    (deck, 17, 'cloze',
     'Five amino acids are both ketogenic and glucogenic: {{c1::isoleucine}}, {{c1::phenylalanine}}, {{c1::tyrosine}}, {{c1::tryptophan}}, and {{c1::threonine}}.',
     1),
    (deck, 18, 'cloze',
     'Ethanol is converted to acetyl-CoA by {{c1::alcohol dehydrogenase}} (ethanol → acetaldehyde) followed by {{c2::acetaldehyde dehydrogenase}} (acetaldehyde → acetate → acetyl-CoA), generating NADH at each step.',
     2),
    (deck, 19, 'cloze',
     'The {{c1::pentose phosphate pathway (PPP)}} runs in the cytosol as an alternative fate for glucose-6-phosphate; it produces {{c2::NADPH}} and {{c3::ribose-5-phosphate}} for biosynthesis.',
     3),
    (deck, 20, 'cloze',
     '{{c1::NADPH}} (distinct from NADH) powers reductive biosynthesis — including {{c2::fatty acid}} synthesis, cholesterol synthesis, and regeneration of {{c2::glutathione}} for antioxidant defense.',
     2);

    -- ── TCA Cycle Overview & Location ───────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 21, 'cloze',
     'The {{c1::citric acid cycle}} (Krebs cycle, TCA cycle) operates in the {{c2::mitochondrial matrix}} and fully oxidizes acetyl-CoA to CO₂ while generating NADH, FADH₂, and GTP.',
     2),
    (deck, 22, 'cloze',
     'Although the TCA cycle does not use O₂ directly, it depends on it: without O₂, the ETC cannot reoxidize {{c1::NADH and FADH₂}}, so these accumulate and {{c2::inhibit}} TCA enzymes.',
     2),
    (deck, 23, 'cloze',
     'Each turn of the TCA cycle (one acetyl-CoA) yields {{c1::3 NADH}}, {{c1::1 FADH₂}}, and {{c1::1 GTP}} (or ATP), and releases {{c2::2 CO₂}}.',
     2);

    -- ── TCA Steps 1-4 (citrate → α-ketoglutarate) ───────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 24, 'cloze',
     'Step 1: {{c1::citrate synthase}} joins acetyl-CoA and {{c2::oxaloacetate}} in a condensation reaction, producing the 6-carbon molecule {{c3::citrate}}.',
     3),
    (deck, 25, 'cloze',
     'Step 2: {{c1::aconitase}} isomerizes citrate to its more easily oxidized isomer {{c2::isocitrate}} by removing and re-adding water.',
     2),
    (deck, 26, 'cloze',
     'Step 3: {{c1::isocitrate dehydrogenase}} (the rate-limiting enzyme of the TCA cycle) oxidatively decarboxylates isocitrate to {{c2::α-ketoglutarate}}, releasing the first {{c3::CO₂}} and producing the first {{c3::NADH}}.',
     3),
    (deck, 27, 'cloze',
     'Step 4: the {{c1::α-ketoglutarate dehydrogenase complex}} converts α-ketoglutarate to {{c2::succinyl-CoA}}, releasing the second CO₂ and producing another NADH; this complex is mechanistically analogous to PDH.',
     2);

    -- ── TCA Steps 5-8 (succinyl-CoA → oxaloacetate) ─────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 28, 'cloze',
     'Step 5: {{c1::succinyl-CoA synthetase}} hydrolyzes the high-energy thioester bond of succinyl-CoA to form {{c2::succinate}}, coupling the energy to substrate-level phosphorylation of GDP → {{c3::GTP}}.',
     3),
    (deck, 29, 'cloze',
     'Step 6: {{c1::succinate dehydrogenase}} oxidizes succinate to fumarate using {{c2::FAD}} (not NAD⁺) — this is the only TCA enzyme embedded in the {{c3::inner mitochondrial membrane}} and is the same as ETC Complex II.',
     3),
    (deck, 30, 'cloze',
     'Step 7: {{c1::fumarase}} hydrates fumarate to {{c2::L-malate}} by adding water across the alkene bond.',
     2),
    (deck, 31, 'cloze',
     'Step 8: {{c1::malate dehydrogenase}} oxidizes malate to {{c2::oxaloacetate}}, producing the third {{c3::NADH}}; the regenerated oxaloacetate is ready to start another cycle.',
     3);

    -- ── TCA Regulation ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     '{{c1::Citrate synthase}}, the enzyme that begins the {{c2::citric acid cycle}}, is allosterically inhibited by {{c3::ATP}}, {{c3::NADH}}, {{c1::citrate}}, and succinyl-CoA — all signals that energy or downstream products are abundant.',
     3),
    (deck, 33, 'cloze',
     '{{c1::Isocitrate dehydrogenase}}, the rate-limiting enzyme of the {{c2::citric acid cycle}}, is inhibited by {{c3::ATP and NADH}} and activated by {{c3::ADP and NAD⁺}} (signals of an energy-deficient state).',
     3),
    (deck, 34, 'cloze',
     'The {{c1::α-ketoglutarate dehydrogenase complex}} is inhibited by its own products ({{c2::succinyl-CoA and NADH}}) plus ATP, and activated by {{c2::ADP and Ca²⁺}}.',
     2);

    -- ── ETC Overview & Driving Force ────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
     'The {{c1::electron transport chain}} sits on the {{c2::inner mitochondrial membrane}}; it accepts electrons from NADH and FADH₂ and ultimately passes them to O₂ to form water.',
     2),
    (deck, 36, 'cloze',
     'Electron flow through the ETC follows {{c1::reduction potential}}: each successive complex has a higher affinity for electrons than the previous one, releasing energy at each step.',
     1),
    (deck, 37, 'cloze',
     'The {{c1::cristae}} are folds of the inner mitochondrial membrane that dramatically increase its {{c2::surface area}}, providing more space to embed ETC complexes and ATP synthase.',
     2),
    (deck, 38, 'cloze',
     'The ETC transfers electrons in {{c1::small steps}} (rather than one direct NADH → O₂ jump), allowing energy to be captured efficiently and minimizing loss as {{c2::heat}}.',
     2);

    -- ── ETC Complexes I & II ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 39, 'cloze',
     '{{c1::Complex I (NADH-CoQ oxidoreductase)}} accepts electrons from NADH, passes them through {{c2::FMN}} and iron-sulfur clusters to coenzyme Q, and pumps {{c3::4 protons}} into the intermembrane space.',
     3),
    (deck, 40, 'cloze',
     '{{c1::Complex II (succinate-CoQ oxidoreductase)}} is identical to TCA step 6 — it transfers electrons from {{c2::FADH₂}} to coenzyme Q and does {{c3::not}} pump protons.',
     3),
    (deck, 41, 'cloze',
     'Because Complex II does not pump protons, electrons that enter via {{c1::FADH₂}} skip Complex I and contribute fewer protons to the gradient — yielding ~{{c2::1.5 ATP}} each vs ~2.5 ATP per NADH.',
     2);

    -- ── ETC Complexes III & IV ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     '{{c1::Complex III (cytochrome reductase)}} transfers electrons from CoQH₂ to {{c2::cytochrome c}} via the {{c3::Q cycle}}, pumping 4 protons into the intermembrane space.',
     3),
    (deck, 43, 'cloze',
     'Cytochromes are heme proteins that shuttle electrons one at a time; their {{c1::iron}} atom cycles between {{c2::Fe³⁺ (oxidized)}} and {{c2::Fe²⁺ (reduced)}} as electrons pass through.',
     2),
    (deck, 44, 'cloze',
     '{{c1::Complex IV (cytochrome c oxidase)}} transfers electrons from cytochrome c to {{c2::O₂}} (the final acceptor), forming {{c3::H₂O}} and pumping 2 protons into the intermembrane space.',
     3);

    -- ── NADH Shuttles ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 45, 'cloze',
     'NADH produced in the {{c1::cytosol}} during glycolysis cannot cross the {{c2::inner mitochondrial membrane}}; shuttle systems transfer its high-energy electrons to mitochondrial carriers.',
     2),
    (deck, 46, 'cloze',
     'The {{c1::glycerol-3-phosphate shuttle}} transfers cytosolic NADH electrons to mitochondrial {{c2::FADH₂}}, which enters at Complex II — yielding only ~{{c3::1.5 ATP}} per cytosolic NADH.',
     3),
    (deck, 47, 'cloze',
     'The {{c1::malate-aspartate shuttle}} (preferred by cardiac muscle) transfers cytosolic reducing equivalents to mitochondrial {{c2::NADH}}, which enters at Complex I — yielding the full ~{{c3::2.5 ATP}}.',
     3);

    -- ── ATP Synthase & Proton Motive Force ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 48, 'cloze',
     'The {{c1::proton motive force}} is the electrochemical gradient across the inner mitochondrial membrane — a combination of a {{c2::pH}} gradient (chemical) and a charge difference (electrical) — built up by ETC proton pumping.',
     2),
    (deck, 49, 'cloze',
     'ATP synthase has two parts: {{c1::F₀}} is a membrane-spanning ion channel that allows protons to flow back down their gradient, and {{c1::F₁}} uses the energy of that flow to phosphorylate ADP into ATP.',
     1),
    (deck, 50, 'cloze',
     '{{c1::Chemiosmotic coupling}} (Mitchell''s hypothesis) describes the direct link between the proton motive force and ATP synthesis: the chemical energy of the proton gradient drives {{c2::ADP + Pi → ATP}}.',
     2),
    (deck, 51, 'cloze',
     '{{c1::Conformational coupling}} (Boyer''s rotary mechanism) explains how proton flow causes physical rotation of the F₁ subunit, driving conformational changes that catalyze and release {{c2::ATP}}.',
     2);

    -- ── ATP Yield & Respiratory Control ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 52, 'cloze',
     'Each {{c1::NADH}} that enters at Complex I yields ~{{c2::2.5 ATP}}; each {{c1::FADH₂}} that enters at Complex II yields ~{{c2::1.5 ATP}}.',
     2),
    (deck, 53, 'cloze',
     '{{c1::Glycolysis}} yields {{c2::2 ATP}} directly (substrate-level phosphorylation) plus {{c2::2 NADH}}, contributing ~7 more when those cytosolic carriers eventually feed the ETC via shuttles.',
     2),
    (deck, 54, 'cloze',
     'The {{c1::PDH complex}} (2 turns per glucose) produces {{c2::2 NADH}} → ~5 ATP from the ETC.',
     2),
    (deck, 55, 'cloze',
     'Two turns of the {{c1::TCA cycle}} per glucose produce {{c2::6 NADH, 2 FADH₂, and 2 GTP}} → ~20 ATP.',
     2),
    (deck, 56, 'cloze',
     'The grand total ATP yield from one glucose under fully aerobic conditions is {{c1::30-32 ATP}}; the range depends on which {{c2::NADH shuttle}} is used.',
     2),
    (deck, 57, 'cloze',
     'Without O₂, the ETC cannot turn over, NADH and FADH₂ accumulate, and the {{c1::citric acid cycle}} stalls — known as respiratory control; ADP and {{c2::NAD⁺}} (not NADH) promote TCA when energy demand rises.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 58;
END $$;
