-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 9 — Carbohydrate Metabolism I
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: carbohydrate_metabolism_i
-- Sort order: 9
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--    1. Glucose Transport (GLUTs)
--    2. Glycolysis Overview & Energetics
--    3. Glycolytic Enzymes & Regulation
--    4. Fermentation & Other Monosaccharides
--    5. Pyruvate Dehydrogenase (the Bridge)
--    6. Glycogenesis & Glycogenolysis
--    7. Gluconeogenesis
--    8. Pentose Phosphate Pathway
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against LibreTexts
-- Biochemistry (glycolysis/gluconeogenesis/glycogen/PPP) and OpenStax Biology 2e (Ch 7).
-- Scope: glycolysis through the pyruvate-dehydrogenase bridge, glycogen, gluconeogenesis, and
-- the PPP — the citric acid cycle, ETC, and beta-oxidation are Ch 10-12. See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'Carbohydrate Metabolism I',
          'Biochemistry Review Chapter Nine: Carbohydrate Metabolism I'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'carbohydrate_metabolism_i',
        'Carbohydrate Metabolism I',
        'Glucose transport (GLUTs), glycolysis and its enzymes and regulation, fermentation and the galactose/fructose feeder pathways, the pyruvate dehydrogenase bridge, glycogenesis and glycogenolysis, gluconeogenesis and its bypass enzymes, and the pentose phosphate pathway.',
        9
    )
    RETURNING id INTO deck;

    -- ── Glucose Transport (GLUTs) ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'The glucose-sensing transporter GLUT2 is expressed in the {{c1::liver}} and {{c1::pancreatic β-cells}}.',
     1),
    (deck, 1, 'cloze',
     'For glucose, GLUT2 has a {{c1::high}} Kₘ — that is, a {{c1::low}} affinity.',
     1),
    (deck, 2, 'cloze',
     'Glucose uptake is insulin-dependent through {{c1::GLUT4}} but insulin-independent through {{c1::GLUT2}}.',
     1),
    (deck, 3, 'cloze',
     'GLUT4, the insulin-responsive transporter, sits in {{c1::skeletal muscle}} and {{c1::adipose}} tissue.',
     1),
    (deck, 4, 'cloze',
     'GLUT4 has a {{c1::low}} Kₘ — that is, a {{c1::high}} affinity for glucose.',
     1),
    (deck, 5, 'cloze',
     '{{c1::Insulin}} raises glucose uptake by fusing GLUT4-storing vesicles with the plasma membrane, adding more transporters.',
     1);

    -- ── Glycolysis Overview & Energetics ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 6, 'cloze',
     'Glycolysis unfolds entirely within the {{c1::cytoplasm}} and can run without {{c2::oxygen}}.',
     2),
    (deck, 7, 'cloze',
     'Glycolysis breaks one molecule of glucose down into two molecules of {{c1::pyruvate}}.',
     1),
    (deck, 8, 'cloze',
     'Per glucose, glycolysis nets the cell {{c1::2}} ATP and {{c1::2}} NADH.',
     1),
    (deck, 9, 'cloze',
     'Glycolysis''s investment phase consumes {{c1::2}} ATP, while its payoff phase generates {{c2::4}} ATP.',
     2),
    (deck, 10, 'cloze',
     'Glycolysis makes ATP through {{c1::substrate-level}} phosphorylation, not {{c1::oxidative}} phosphorylation.',
     1),
    (deck, 11, 'cloze',
     'The three irreversible, regulated steps of glycolysis are catalyzed by {{c1::hexokinase/glucokinase}}, {{c1::phosphofructokinase-1 (PFK-1)}}, and {{c1::pyruvate kinase}}.',
     1);

    -- ── Glycolytic Enzymes & Regulation ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 12, 'cloze',
     'Phosphorylation by hexokinase traps glucose in the cell because glucose-6-phosphate''s {{c1::negative charge}} prevents it from crossing the plasma membrane.',
     1),
    (deck, 13, 'cloze',
     'Hexokinase is present in {{c1::all}} body cells and has a {{c2::low}} Kₘ for glucose.',
     2),
    (deck, 14, 'cloze',
     'Glucokinase, the hexokinase isoform of {{c1::liver and pancreatic β-cells}}, has a {{c2::high}} Kₘ for glucose.',
     2),
    (deck, 15, 'cloze',
     'Hexokinase is inhibited by its product glucose-6-phosphate, but the liver''s {{c1::glucokinase}} is not.',
     1),
    (deck, 16, 'cloze',
     'In the liver, glucokinase transcription is {{c1::induced}} by the hormone {{c1::insulin}}.',
     1),
    (deck, 17, 'cloze',
     'Phosphofructokinase-1 catalyzes glycolysis''s {{c1::rate-limiting}} step, converting fructose-6-phosphate to {{c2::fructose-1,6-bisphosphate}}.',
     2),
    (deck, 18, 'cloze',
     'PFK-1 is allosterically activated by {{c1::AMP}} and {{c1::fructose-2,6-bisphosphate}}.',
     1),
    (deck, 19, 'cloze',
     'PFK-1 is allosterically inhibited by {{c1::ATP}} and {{c1::citrate}}.',
     1),
    (deck, 20, 'cloze',
     'The kinase {{c1::PFK-2}} synthesizes fructose-2,6-bisphosphate, the most potent allosteric activator of glycolysis''s rate-limiting enzyme.',
     1),
    (deck, 21, 'cloze',
     '{{c1::Insulin}} activates PFK-2, whereas {{c1::glucagon}} inhibits it.',
     1),
    (deck, 22, 'cloze',
     'Glyceraldehyde-3-phosphate dehydrogenase oxidizes glyceraldehyde-3-phosphate to 1,3-bisphosphoglycerate, the only glycolytic step producing {{c1::NADH}}.',
     1),
    (deck, 23, 'cloze',
     'Pyruvate kinase catalyzes glycolysis''s final step: {{c1::phosphoenolpyruvate}} → pyruvate.',
     1),
    (deck, 24, 'cloze',
     'Pyruvate kinase is feed-forward activated by {{c1::fructose-1,6-bisphosphate}}.',
     1);

    -- ── Fermentation & Other Monosaccharides ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 25, 'cloze',
     'When oxygen is scarce, pyruvate is reduced to {{c1::lactate}} by the enzyme {{c1::lactate dehydrogenase}}.',
     1),
    (deck, 26, 'cloze',
     'Reducing pyruvate to lactate regenerates the {{c1::NAD⁺}} that glycolysis must reuse to keep producing ATP without oxygen.',
     1),
    (deck, 27, 'cloze',
     'Lacking {{c1::mitochondria}}, mature red blood cells depend entirely on glycolysis and lactate fermentation for ATP.',
     1),
    (deck, 28, 'cloze',
     'During intense exercise, {{c1::skeletal muscle}} outpaces its oxygen supply and switches to lactate fermentation to keep glycolysis running.',
     1),
    (deck, 29, 'cloze',
     'Galactose is trapped by galactokinase and, through a uridyltransferase and an epimerase, converted into {{c1::glucose-1-phosphate}} for glycolysis.',
     1),
    (deck, 30, 'cloze',
     '{{c1::Aldolase B}} splits fructose-1-phosphate into two trioses, {{c2::glyceraldehyde and dihydroxyacetone phosphate}}, which then feed glycolysis.',
     2),
    (deck, 31, 'cloze',
     'Without oxygen, glycolysis with lactate fermentation nets only {{c1::2}} ATP per glucose.',
     1),
    (deck, 32, 'cloze',
     'Fructose is split into trioses that enter glycolysis late, bypassing the pathway''s main regulatory enzyme, {{c1::phosphofructokinase-1}}.',
     1);

    -- ── Pyruvate Dehydrogenase (the Bridge) ───────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 33, 'cloze',
     'The pyruvate dehydrogenase complex operates in the {{c1::mitochondrial matrix}}, where it converts pyruvate into acetyl-CoA.',
     1),
    (deck, 34, 'cloze',
     'Besides acetyl-CoA, the pyruvate dehydrogenase reaction generates one {{c1::NADH}} and releases one {{c2::CO₂}} per pyruvate.',
     2),
    (deck, 35, 'cloze',
     'The pyruvate dehydrogenase step is {{c1::irreversible}}, so once pyruvate becomes acetyl-CoA those carbons {{c1::cannot return to glucose}}.',
     1),
    (deck, 36, 'cloze',
     'Pyruvate dehydrogenase is inhibited by its own products, {{c1::acetyl-CoA and NADH}} — a signal that the cell already has ample energy.',
     1),
    (deck, 37, 'cloze',
     'The hormone {{c1::insulin}} activates pyruvate dehydrogenase, so a well-fed cell channels pyruvate into acetyl-CoA.',
     1),
    (deck, 38, 'cloze',
     'When acetyl-CoA builds up, it allosterically activates pyruvate carboxylase, steering pyruvate away from acetyl-CoA and into {{c1::gluconeogenesis}}.',
     1);

    -- ── Glycogenesis & Glycogenolysis ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 39, 'cloze',
     'In glycogen, glucose units along each chain are joined by {{c1::α-1,4}} glycosidic bonds, while the branch points are joined by {{c1::α-1,6}} bonds.',
     1),
    (deck, 40, 'cloze',
     'New glycogen chains are built on a core protein, {{c1::glycogenin}}, which primes synthesis by attaching the first glucose to itself.',
     1),
    (deck, 41, 'cloze',
     '{{c1::Glycogen synthase}} extends the growing chain by adding glucose units through α-1,4 glycosidic bonds.',
     1),
    (deck, 42, 'cloze',
     'The anabolic hormone {{c1::insulin}} stimulates glycogen synthase, driving excess blood glucose into storage as glycogen.',
     1),
    (deck, 43, 'cloze',
     '{{c1::Branching enzyme}} builds glycogen''s α-1,6 linkages, attaching short glucose chains as side chains onto the main backbone.',
     1),
    (deck, 44, 'cloze',
     'In glycogenolysis, {{c1::glycogen phosphorylase}} cleaves α-1,4 bonds at chain ends, releasing {{c1::glucose-1-phosphate}}.',
     1),
    (deck, 45, 'cloze',
     'Liver glycogen phosphorylase is activated by {{c1::glucagon}}; the muscle isozyme responds to {{c2::epinephrine and AMP}}.',
     2),
    (deck, 46, 'cloze',
     'During glycogenolysis, {{c1::debranching enzyme}} clears the α-1,6-linked glucose at junctions that glycogen phosphorylase cannot cut.',
     1),
    (deck, 47, 'cloze',
     'Glycogen synthase extends the glycogen chain using {{c1::UDP-glucose}} as the activated donor.',
     1);

    -- ── Gluconeogenesis ───────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 48, 'cloze',
     'Gluconeogenesis synthesizes new glucose from {{c1::non-carbohydrate}} precursors, occurring mainly in the {{c2::liver}} during fasting.',
     2),
    (deck, 49, 'cloze',
     'Aside from the liver, the only organ with meaningful gluconeogenesis is the {{c1::kidney}}, especially during prolonged fasting.',
     1),
    (deck, 50, 'cloze',
     'Gluconeogenesis builds glucose from three non-carbohydrate sources: {{c1::lactate, glucogenic amino acids, and glycerol}}.',
     1),
    (deck, 51, 'cloze',
     'Pyruvate carboxylase (pyruvate → oxaloacetate) is allosterically activated by {{c1::acetyl-CoA}}, a signal of ample fuel.',
     1),
    (deck, 52, 'cloze',
     'PEPCK converts oxaloacetate to phosphoenolpyruvate and is transcriptionally induced by the counter-regulatory hormones {{c1::glucagon and cortisol}}.',
     1),
    (deck, 53, 'cloze',
     'Because pyruvate kinase is irreversible, gluconeogenesis routes pyruvate through the intermediate {{c1::oxaloacetate}} before forming PEP.',
     1),
    (deck, 54, 'cloze',
     'The committed, rate-limiting enzyme of gluconeogenesis is {{c1::fructose-1,6-bisphosphatase}}.',
     1),
    (deck, 55, 'cloze',
     'Glucose-6-phosphatase is located in the {{c1::endoplasmic reticulum}} of liver cells, where it hydrolyzes glucose-6-phosphate to release free glucose into the blood.',
     1),
    (deck, 56, 'cloze',
     'Von Gierke disease (type I glycogen storage disease), marked by severe fasting hypoglycemia, is caused by a deficiency of {{c1::glucose-6-phosphatase}}.',
     1),
    (deck, 57, 'cloze',
     'Glycolysis and gluconeogenesis are reciprocally regulated so they don''t run at once, which would form a {{c1::futile cycle}} that consumes ATP with no net product.',
     1),
    (deck, 58, 'cloze',
     'Pyruvate carboxylase, the first gluconeogenic bypass enzyme, depends on the cofactor {{c1::biotin}} to add CO₂ to pyruvate.',
     1);

    -- ── Pentose Phosphate Pathway ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 59, 'cloze',
     'Occurring entirely in the {{c1::cytoplasm}}, the pentose phosphate pathway neither generates nor consumes {{c2::ATP}}.',
     2),
    (deck, 60, 'cloze',
     'The oxidative phase of the pentose phosphate pathway yields {{c1::NADPH}}, while its non-oxidative phase produces {{c2::ribose-5-phosphate}} for nucleotide synthesis.',
     2),
    (deck, 61, 'cloze',
     'In the pentose phosphate pathway, {{c1::glucose-6-phosphate dehydrogenase}} catalyzes the rate-limiting, committed first step of the oxidative phase.',
     1),
    (deck, 62, 'cloze',
     'Glucose-6-phosphate dehydrogenase is activated by {{c1::NADP⁺}} and the hormone {{c2::insulin}}, but is inhibited by {{c1::NADPH}}.',
     2),
    (deck, 63, 'cloze',
     'NADPH supplies the reducing power to synthesize {{c1::fatty acids and cholesterol}}, the classic reductive biosynthesis reactions.',
     1),
    (deck, 64, 'cloze',
     'In phagocytes, NADPH fuels the {{c1::respiratory burst}}, producing reactive oxygen species that kill engulfed bacteria.',
     1),
    (deck, 65, 'cloze',
     'NADPH keeps {{c1::glutathione}} in its reduced form, letting it neutralize {{c2::reactive oxygen species}}.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 66;
END $$;
