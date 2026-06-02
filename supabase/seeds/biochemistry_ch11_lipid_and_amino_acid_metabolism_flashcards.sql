-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 11 — Lipid and Amino Acid Metabolism
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: lipid_and_amino_acid_metabolism
-- Sort order: 11
--
-- Coverage (AAMC-aligned order):
--   1.  Lipid Digestion
--   2.  Micelles & Lipid Absorption
--   3.  Lipid Mobilization
--   4.  Lipoproteins Overview
--   5.  Chylomicrons & VLDL
--   6.  IDL, LDL, HDL + Reverse Cholesterol Transport
--   7.  Cholesterol Sources & Functions
--   8.  Cholesterol Synthesis
--   9.  Cholesterol Transport
--   10. Fatty Acid Nomenclature
--   11. Fatty Acid Synthesis
--   12. Triacylglycerol Synthesis + α/ω-Oxidation
--   13. β-Oxidation Mechanism
--   14. β-Oxidation Variants
--   15. Ketone Bodies
--   16. Protein Catabolism
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- LibreTexts Biochemistry (Lipid Digestion, Lipoproteins, Cholesterol,
-- Fatty Acid Synthesis and Oxidation, Ketone Bodies, Protein Catabolism,
-- Urea Cycle) and OpenStax Anatomy & Physiology 2e (Ch 23 Digestive
-- System, Ch 24 Metabolism), and the AAMC Foundation 1D Concepts 4 + 5
-- content outlines. See companion .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'Lipid and Amino Acid Metabolism',
          'Lipid & Amino Acid Metabolism',
          'Biochemistry Review Chapter 11: Lipid and Amino Acid Metabolism'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'lipid_and_amino_acid_metabolism',
        'Lipid and Amino Acid Metabolism',
        'Lipid digestion (bile, pancreatic enzymes, micelles) and absorption (chylomicron packaging, lymphatic route); lipid mobilization (HSL, LPL, hormonal control); the five lipoproteins and their roles in triglyceride and cholesterol transport; cholesterol synthesis (citrate shuttle, HMG-CoA reductase) and transport (LCAT, CETP, albumin); fatty acid nomenclature and the five-step synthesis of palmitate; β-oxidation mechanism and variants (odd-chain, unsaturated, α/ω-oxidation); ketogenesis and ketolysis (SCOT, brain fasting metabolism); protein digestion, transamination/deamination, and the urea cycle.',
        11
    )
    RETURNING id INTO deck;

    -- ── Lipid Digestion ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'Dietary fats are mostly {{c1::triacylglycerols (TAGs)}}, with smaller amounts of cholesterol, cholesteryl esters, phospholipids, and free fatty acids.',
     1),
    (deck, 1, 'cloze',
     'In the duodenum, dietary fat is broken into small droplets by {{c1::emulsification}}, which dramatically increases lipid surface area and exposes more substrate to digestive enzymes.',
     1),
    (deck, 2, 'cloze',
     'Emulsification is driven by {{c1::bile}}, a fluid containing bile salts, cholesterol, and pigments; bile is made by the {{c2::liver}} and stored in the {{c3::gallbladder}}.',
     3),
    (deck, 3, 'cloze',
     'The pancreas secretes three enzymes into the small intestine that hydrolyze emulsified lipids: {{c1::pancreatic lipase}}, {{c1::colipase}}, and {{c1::cholesterol esterase}}.',
     1),
    (deck, 4, 'cloze',
     'After their job is done, {{c1::bile salts}} are actively reabsorbed at the {{c2::terminal ileum}} and recycled back to the liver.',
     2);

    -- ── Micelles & Lipid Absorption ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 5, 'cloze',
     'A {{c1::micelle}} is a sphere of amphipathic lipids with {{c2::hydrophilic heads}} on the outside (facing the aqueous gut lumen) and {{c2::hydrophobic tails}} packed inward.',
     2),
    (deck, 6, 'cloze',
     'Micelles carry free fatty acids, monoacylglycerols, cholesterol, and fat-soluble vitamins to the {{c1::brush border}} of intestinal mucosal cells for absorption.',
     1),
    (deck, 7, 'cloze',
     'Inside the enterocyte, absorbed lipids are {{c1::re-esterified}} into triacylglycerols and cholesteryl esters, then packaged with apoproteins into {{c2::chylomicrons}} for export.',
     2),
    (deck, 8, 'cloze',
     'Chylomicrons leave the intestine through {{c1::lacteals}} (lymphatic vessels), travel up the {{c2::thoracic duct}}, and empty into the bloodstream at the left subclavian vein.',
     2),
    (deck, 9, 'cloze',
     '{{c1::Short-chain}} fatty acids skip the lymphatic route entirely; they are water-soluble enough to enter the bloodstream directly from the intestine by {{c2::simple diffusion}}.',
     2);

    -- ── Lipid Mobilization ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
     '{{c1::Hormone-sensitive lipase (HSL)}} hydrolyzes the stored triacylglycerols in {{c2::adipose tissue}} into free fatty acids and glycerol when the body needs to mobilize fat for energy.',
     2),
    (deck, 11, 'cloze',
     'HSL is activated by falling {{c1::insulin}} levels and by stress hormones {{c1::epinephrine}} and {{c1::cortisol}} — all signals that the body needs to burn stored fat.',
     1),
    (deck, 12, 'cloze',
     '{{c1::Hormone-sensitive lipase (HSL)}} works inside {{c2::adipocytes}} to mobilize stored fat; {{c1::lipoprotein lipase (LPL)}} works on the surface of {{c2::blood vessel endothelium}} to release fatty acids from circulating lipoproteins.',
     2),
    (deck, 13, 'cloze',
     'Glycerol released from triacylglycerol breakdown travels to the {{c1::liver}}, where it can enter {{c2::glycolysis}} or be used for {{c2::gluconeogenesis}}.',
     2);

    -- ── Lipoproteins Overview ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 14, 'cloze',
     'The five major lipoproteins are {{c1::chylomicrons}}, {{c1::VLDL}}, {{c1::IDL}}, {{c1::LDL}}, and {{c1::HDL}}, distinguished by their relative protein and lipid content.',
     1),
    (deck, 15, 'cloze',
     'From least to greatest percent protein (and lowest to highest density): {{c1::chylomicrons < VLDL < IDL < LDL < HDL}}.',
     1),
    (deck, 16, 'cloze',
     '{{c1::Apoproteins (apolipoproteins)}} are the protein components of lipoproteins; they direct lipoprotein interactions with receptors, regulate enzyme activity, and identify lipoprotein particles to specific tissues.',
     1),
    (deck, 17, 'cloze',
     'Lipoproteins are synthesized primarily by the {{c1::liver}} and the {{c1::intestine}}; chylomicrons originate in the intestine and the others (VLDL, HDL) originate in the liver.',
     1);

    -- ── Chylomicrons & VLDL ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     '{{c1::Chylomicrons}} transport {{c2::dietary}} triacylglycerols, cholesterol, and cholesteryl esters from the intestine to peripheral tissues via the lymphatic system.',
     2),
    (deck, 19, 'cloze',
     '{{c1::VLDL (very-low-density lipoprotein)}} is made in the {{c2::liver}} and transports triacylglycerols and fatty acids from the liver to peripheral tissues.',
     2),
    (deck, 20, 'cloze',
     'The fatty acids packaged into VLDL come from excess dietary {{c1::glucose}} that was converted to fatty acids in the liver, plus fatty acids retrieved from {{c2::chylomicron remnants}}.',
     2);

    -- ── IDL, LDL, HDL + Reverse Cholesterol Transport ──────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 21, 'cloze',
     '{{c1::IDL (intermediate-density lipoprotein)}} forms when {{c2::VLDL}} unloads most of its triacylglycerols; it can be reabsorbed by the liver or further processed in the blood.',
     2),
    (deck, 22, 'cloze',
     'IDL becomes {{c1::LDL}} by picking up {{c2::cholesteryl esters}} from HDL — a transfer facilitated by the enzyme CETP.',
     2),
    (deck, 23, 'cloze',
     '{{c1::LDL (low-density lipoprotein)}} delivers {{c2::cholesterol}} to peripheral tissues for membrane and steroid biosynthesis; high circulating LDL is the classic atherosclerosis risk factor.',
     2),
    (deck, 24, 'cloze',
     '{{c1::HDL (high-density lipoprotein)}} performs {{c2::reverse cholesterol transport}}: it picks up excess cholesterol from peripheral tissues and blood vessels and returns it to the liver.',
     2);

    -- ── Cholesterol Sources & Functions ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 25, 'cloze',
     'Cholesterol is essential for {{c1::cell membrane}} fluidity and serves as the precursor for {{c2::steroid hormones}}, bile acids, and {{c2::vitamin D}}.',
     2),
    (deck, 26, 'cloze',
     'Cells obtain cholesterol from dietary uptake (via {{c1::LDL}} from the bloodstream) or from {{c2::de novo}} synthesis in the liver.',
     2),
    (deck, 27, 'cloze',
     'In addition to peripheral cholesterol delivery, HDL also supplies cholesterol to {{c1::steroidogenic tissues}} (e.g., adrenal cortex, gonads) for hormone synthesis.',
     1);

    -- ── Cholesterol Synthesis ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 28, 'cloze',
     'For cholesterol (and fatty acid) synthesis, mitochondrial acetyl-CoA must reach the cytosol — it is transported as {{c1::citrate}}, which is then split back to acetyl-CoA by {{c2::citrate lyase}}.',
     2),
    (deck, 29, 'cloze',
     '{{c1::HMG-CoA reductase}} catalyzes the rate-limiting step of cholesterol biosynthesis (HMG-CoA → {{c2::mevalonate}}) in the smooth endoplasmic reticulum; statins inhibit this enzyme.',
     2),
    (deck, 30, 'cloze',
     'Cholesterol synthesis requires {{c1::NADPH}} as the reducing equivalent and {{c2::ATP}} as the energy source — both supplied by the cytosol.',
     2),
    (deck, 31, 'cloze',
     'HMG-CoA reductase is feedback-inhibited by {{c1::cholesterol}} itself and activated by {{c2::insulin}}, making cholesterol synthesis most active in the well-fed state.',
     2);

    -- ── Cholesterol Transport ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     '{{c1::LCAT (lecithin-cholesterol acyltransferase)}} circulates in the blood and attaches a fatty acid to cholesterol, forming soluble {{c2::cholesteryl esters}} that pack neatly inside HDL.',
     2),
    (deck, 33, 'cloze',
     '{{c1::CETP (cholesteryl ester transfer protein)}} transfers cholesteryl esters from HDL to other lipoproteins like IDL — converting IDL into {{c2::LDL}} in the process.',
     2),
    (deck, 34, 'cloze',
     '{{c1::Free fatty acids}} released from adipose tissue are too hydrophobic to dissolve in blood plasma; they are carried bound to the protein {{c2::albumin}}.',
     2);

    -- ── Fatty Acid Nomenclature ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
     '{{c1::Saturated}} fatty acids contain no carbon-carbon double bonds; {{c1::unsaturated}} fatty acids contain one or more double bonds, which kink the chain and lower the melting point.',
     1),
    (deck, 36, 'cloze',
     'The two essential fatty acids that humans cannot synthesize are {{c1::linoleic acid (omega-6)}} and {{c1::α-linolenic acid (omega-3)}}; both are polyunsaturated and must come from the diet.',
     1),
    (deck, 37, 'cloze',
     'The {{c1::omega}} numbering system labels unsaturated fatty acids by the position of the {{c2::last}} (closest to the methyl end) carbon-carbon double bond — distinct from carboxyl-end counting.',
     2);

    -- ── Fatty Acid Synthesis ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 38, 'cloze',
     'Fatty acid synthesis occurs in the {{c1::cytoplasm}} of {{c2::liver}} cells; the cytoplasmic acetyl-CoA pool is supplied by the citrate shuttle from the mitochondrial matrix.',
     2),
    (deck, 39, 'cloze',
     '{{c1::Acetyl-CoA carboxylase (ACC)}} is the rate-limiting enzyme of fatty acid synthesis; it uses {{c2::biotin}} and ATP to add CO₂ to acetyl-CoA, forming {{c3::malonyl-CoA}}.',
     3),
    (deck, 40, 'cloze',
     'ACC is activated by {{c1::insulin}} and {{c1::citrate}} (signals of abundant energy and acetyl-CoA), and inhibited by palmitoyl-CoA (the end-product feedback signal).',
     1),
    (deck, 41, 'cloze',
     'Each cycle of fatty acid synthesis follows five steps: {{c1::activation}}, {{c1::bond formation}}, {{c1::reduction}}, {{c1::dehydration}}, and a second reduction.',
     1),
    (deck, 42, 'cloze',
     'Fatty acid synthase (also called {{c1::palmitate synthase}}) cycles eight times, using {{c2::8 acetyl-CoA}} units to produce a 16-carbon saturated fatty acid: {{c3::palmitate}} — the only fatty acid humans can synthesize de novo.',
     3);

    -- ── Triacylglycerol Synthesis + α/ω-Oxidation ───────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     'A {{c1::triacylglycerol}} is formed by esterifying {{c2::three}} fatty acids onto a {{c3::glycerol}} backbone, primarily in the liver and to a lesser extent in adipose tissue.',
     3),
    (deck, 44, 'cloze',
     'Triacylglycerols synthesized in the liver are packaged into {{c1::VLDL}} particles and shipped through the bloodstream to {{c2::adipose tissue}} for storage.',
     2),
    (deck, 45, 'cloze',
     '{{c1::α-oxidation}} (in peroxisomes) is used for {{c2::branched-chain}} fatty acids that cannot enter standard β-oxidation directly because of methyl substituents.',
     2),
    (deck, 46, 'cloze',
     '{{c1::ω-oxidation}} occurs in the {{c2::smooth endoplasmic reticulum}} and oxidizes the omega (methyl) end of the fatty acid, producing {{c3::dicarboxylic acids}}.',
     3);

    -- ── β-Oxidation Mechanism ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 47, 'cloze',
     '{{c1::β-oxidation}} occurs in the {{c2::mitochondrial matrix}}; the fatty acid is first activated in the cytosol by attachment to {{c3::CoA}} (via fatty acyl-CoA synthase).',
     3),
    (deck, 48, 'cloze',
     'Long-chain fatty acyl-CoA cannot cross the inner mitochondrial membrane; it is transferred to {{c1::carnitine}} by the rate-limiting enzyme {{c2::CPT I (carnitine palmitoyltransferase I)}} for transport into the matrix.',
     2),
    (deck, 49, 'cloze',
     '{{c1::Short}}- and medium-chain fatty acids diffuse freely into the mitochondrial matrix without help; {{c1::long}}-chain fatty acids require the carnitine shuttle.',
     1),
    (deck, 50, 'cloze',
     'Each cycle of β-oxidation has four steps: {{c1::oxidation}} (creating a double bond), {{c1::hydration}} (adding water across it), a second {{c1::oxidation}} (forming a β-keto group), and {{c1::cleavage}} (releasing acetyl-CoA).',
     1),
    (deck, 51, 'cloze',
     'Each cycle of β-oxidation releases one {{c1::acetyl-CoA}} and produces one {{c2::NADH}} and one {{c2::FADH₂}} for the ETC.',
     2);

    -- ── β-Oxidation Variants ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 52, 'cloze',
     '{{c1::Even}}-chain fatty acids ultimately yield only acetyl-CoA; {{c1::odd}}-chain fatty acids yield acetyl-CoA plus one final {{c2::propionyl-CoA}} (3-carbon unit).',
     2),
    (deck, 53, 'cloze',
     '{{c1::Propionyl-CoA}} is carboxylated by propionyl-CoA carboxylase (using {{c2::biotin}}) to methylmalonyl-CoA, which is then converted to {{c3::succinyl-CoA}} by a vitamin B₁₂-dependent mutase.',
     3),
    (deck, 54, 'cloze',
     'Because {{c1::succinyl-CoA}} is a citric acid cycle intermediate, odd-chain fatty acids can ultimately feed {{c2::gluconeogenesis}} — unlike even-chain fatty acids, which cannot.',
     2),
    (deck, 55, 'cloze',
     'Unsaturated fatty acids require two additional enzymes: an {{c1::isomerase}} repositions cis double bonds to the standard trans 2,3 position, and a {{c1::reductase}} eliminates conjugated double bonds in polyunsaturated chains.',
     1);

    -- ── Ketone Bodies ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 56, 'cloze',
     '{{c1::Ketogenesis}} occurs in {{c2::liver mitochondria}} during prolonged fasting or starvation, when β-oxidation produces more acetyl-CoA than the TCA cycle can process.',
     2),
    (deck, 57, 'cloze',
     'In ketogenesis, {{c1::HMG-CoA synthase}} builds HMG-CoA from three acetyl-CoA, then {{c2::HMG-CoA lyase}} cleaves it to acetoacetate, which is reduced to {{c3::3-hydroxybutyrate}}.',
     3),
    (deck, 58, 'cloze',
     'The two metabolically usable ketone bodies are {{c1::acetoacetate}} and {{c1::3-hydroxybutyrate (β-hydroxybutyrate)}}; acetone is a non-metabolizable side product (responsible for fruity breath).',
     1),
    (deck, 59, 'cloze',
     'In peripheral tissues, ketolysis activates acetoacetate via {{c1::SCOT (succinyl-CoA:acetoacetate CoA transferase)}}, producing acetoacetyl-CoA that splits into {{c2::two acetyl-CoA}} for the TCA cycle.',
     2),
    (deck, 60, 'cloze',
     'After about a week of fasting, the brain begins metabolizing ketone bodies and can derive up to {{c1::two-thirds}} of its energy from them; this spares {{c2::protein}} that would otherwise be catabolized for gluconeogenesis.',
     2),
    (deck, 61, 'cloze',
     'The liver cannot use the ketones it produces because it lacks the enzyme {{c1::SCOT}}; this ensures ketone bodies are exported to peripheral tissues during fasting.',
     1);

    -- ── Protein Catabolism ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 62, 'cloze',
     'Protein digestion begins in the stomach, where the enzyme {{c1::pepsin}} cleaves proteins into smaller peptides under acidic conditions.',
     1),
    (deck, 63, 'cloze',
     'The pancreas secretes {{c1::trypsin}}, {{c1::chymotrypsin}}, and {{c1::carboxypeptidase A and B}} as inactive {{c2::zymogens}}; they continue protein digestion in the small intestine after activation.',
     2),
    (deck, 64, 'cloze',
     'Final protein digestion at the small-intestinal brush border is completed by {{c1::aminopeptidase}} and {{c1::dipeptidase}}, yielding free amino acids, dipeptides, and tripeptides.',
     1),
    (deck, 65, 'cloze',
     'Amino acids and small peptides are absorbed across the intestinal lumen by {{c1::Na⁺-linked secondary active transport}}, then diffuse out at the basolateral membrane into the bloodstream.',
     1),
    (deck, 66, 'cloze',
     'Body proteins are catabolized primarily in {{c1::muscle and liver}}, and only under conditions of {{c2::starvation}} or prolonged catabolic stress.',
     2),
    (deck, 67, 'cloze',
     '{{c1::Transamination}} transfers an amino group from an amino acid to a keto acid, producing a new amino acid and a new keto acid; {{c1::deamination}} removes the amino group entirely as ammonia.',
     1),
    (deck, 68, 'cloze',
     'After loss of the amino group, the remaining {{c1::carbon skeleton}} of an amino acid can feed into {{c2::gluconeogenesis}} (glucogenic AAs) or generate {{c2::acetyl-CoA / ketone bodies}} (ketogenic AAs).',
     2),
    (deck, 69, 'cloze',
     'The toxic ammonia released during deamination is converted to {{c1::urea}} for safe excretion via the {{c2::urea cycle}}, which operates in the {{c3::liver}}.',
     3),
    (deck, 70, 'cloze',
     '{{c1::Basic}} amino acid side chains (e.g., arginine, lysine, histidine) feed nitrogen directly into the {{c2::urea cycle}}, while the remaining carbon skeleton enters gluconeogenesis or ketogenesis.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 71;
END $$;
