-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 4 — Carbohydrate Structure and Function
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: carbohydrate_structure_and_function
-- Sort order: 4
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--   1.  Carbohydrate Overview & Composition
--   2.  Aldoses vs Ketoses + Carbon-Count Naming
--   3.  Common Monosaccharides
--   4.  Stereoisomers and Optical Activity
--   5.  Enantiomers, Diastereomers, Epimers, Anomers
--   6.  D vs L Designation + Fischer Projections
--   7.  Cyclization: Hemiacetals and Hemiketals
--   8.  Furanose vs Pyranose Rings
--   9.  Alpha vs Beta Anomers + Mutarotation
--   10. Haworth Projections & Chair Conformations
--   11. Oxidation Reactions
--   12. Reducing Sugars
--   13. Reduction + Deoxy Sugars + Tautomerization
--   14. Esterification + Glycoside Formation
--   15. Disaccharides
--   16. Polysaccharides (Cellulose, Starch, Glycogen)
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- LibreTexts Biochemistry, LibreTexts Organic Chemistry (stereochemistry,
-- hemiacetal/acetal chemistry), and the AAMC Foundation 1B Concept 1
-- content outline. See companion .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'Carbohydrate Structure and Function',
          'Carbohydrate Structure & Function',
          'Carbohydrates',
          'Biochemistry Review Chapter 4: Carbohydrate Structure and Function'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'carbohydrate_structure_and_function',
        'Carbohydrate Structure and Function',
        'Monosaccharide classification and stereochemistry (aldoses/ketoses, D/L, Fischer projections, anomers), cyclization to furanose and pyranose rings, mutarotation, oxidation and reduction reactions, reducing sugars, esterification and glycoside formation, the major disaccharides (sucrose, lactose, maltose), and the polysaccharides cellulose, starch, and glycogen.',
        4
    )
    RETURNING id INTO deck;

    -- ── Carbohydrate Overview & Composition ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     '{{c1::Carbohydrates}} are biomolecules made of carbon, hydrogen, and oxygen in a {{c2::1:2:1}} ratio — effectively (CH2O)n — and serve as energy sources, energy storage, and structural components.',
     2),
    (deck, 1, 'cloze',
     '{{c1::Monosaccharides}} are the simplest carbohydrates — single sugar units that can be linked together to build disaccharides and polysaccharides.',
     1);

    -- ── Aldoses vs Ketoses + Carbon-Count Naming ────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 2, 'cloze',
     'An {{c1::aldose}} is a monosaccharide whose most oxidized carbon is an {{c2::aldehyde}}; a {{c1::ketose}} has its most oxidized carbon as a {{c2::ketone}}.',
     2),
    (deck, 3, 'cloze',
     'By carbon count, monosaccharides are named {{c1::trioses}} (3 C), {{c1::tetroses}} (4 C), {{c1::pentoses}} (5 C), and {{c1::hexoses}} (6 C).',
     1),
    (deck, 4, 'cloze',
     'The simplest aldose is {{c1::glyceraldehyde}} (an aldotriose); the simplest ketose is {{c2::dihydroxyacetone}} (a ketotriose).',
     2),
    (deck, 5, 'cloze',
     'The {{c1::carbonyl}} carbon of a monosaccharide gets the lowest possible number; in most ketohexoses on the MCAT, the ketone sits at C{{c2::2}}.',
     2);

    -- ── Common Monosaccharides ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 6, 'cloze',
     'The three most testable hexoses are {{c1::glucose}}, {{c1::fructose}}, and {{c1::galactose}}; all three share the molecular formula C6H12O6 but differ in structure.',
     1),
    (deck, 7, 'cloze',
     '{{c1::Glucose}} and {{c1::galactose}} are aldohexoses (C1 is an aldehyde); {{c2::fructose}} is a ketohexose (C2 is a ketone).',
     2),
    (deck, 8, 'cloze',
     '{{c1::Ribose}} is an aldopentose — a five-carbon aldose — and forms the sugar backbone of {{c2::RNA}}.',
     2);

    -- ── Stereoisomers and Optical Activity ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
     '{{c1::Stereoisomers}} share the same molecular formula and connectivity but differ in the spatial arrangement of their atoms.',
     1),
    (deck, 10, 'cloze',
     'A molecule with n {{c1::chiral centers}} can have up to {{c2::2^n}} stereoisomers; an aldohexose with 4 chiral centers thus has 16 total.',
     2),
    (deck, 11, 'cloze',
     'A molecule is {{c1::optically active}} if it has at least one chiral center; achiral molecules cannot rotate plane-polarized light.',
     1);

    -- ── Enantiomers, Diastereomers, Epimers, Anomers ────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 12, 'cloze',
     '{{c1::Enantiomers}} are non-identical, non-superimposable {{c2::mirror images}} of each other; they rotate plane-polarized light in equal but opposite directions.',
     2),
    (deck, 13, 'cloze',
     '{{c1::Diastereomers}} are stereoisomers that are NOT mirror images of each other; they often have different physical properties (melting point, solubility).',
     1),
    (deck, 14, 'cloze',
     '{{c1::Epimers}} are a special class of diastereomers that differ at exactly {{c2::one}} chiral center.',
     2),
    (deck, 15, 'cloze',
     '{{c1::Anomers}} are stereoisomers that differ at the {{c2::anomeric carbon}} — the new chiral center formed when a sugar cyclizes.',
     2);

    -- ── D vs L Designation + Fischer Projections ────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 16, 'cloze',
     'In a Fischer projection, a {{c1::D-sugar}} has the hydroxyl on its {{c2::highest-numbered chiral center}} drawn on the right; an {{c1::L-sugar}} has it drawn on the left.',
     2),
    (deck, 17, 'cloze',
     'In a Fischer projection, {{c1::horizontal}} bonds point out of the page (wedges) and {{c1::vertical}} bonds point into the page (dashes).',
     1),
    (deck, 18, 'cloze',
     'A given sugar in its D form and its L form (e.g., D-glucose and L-glucose) are {{c1::enantiomers}}; they are exact mirror images.',
     1);

    -- ── Cyclization: Hemiacetals and Hemiketals ─────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 19, 'cloze',
     'Monosaccharides cyclize through an intramolecular reaction between their {{c1::carbonyl}} group (electrophile) and a {{c2::hydroxyl}} group (nucleophile) farther along the chain.',
     2),
    (deck, 20, 'cloze',
     'An aldose cyclizes to form a {{c1::hemiacetal}}: the carbonyl carbon becomes the new chiral center and is bonded to one hydroxyl (-OH) and one alkoxy (-OR) group.',
     1),
    (deck, 21, 'cloze',
     'A ketose cyclizes to form a {{c1::hemiketal}}: the same hemiacetal-style chemistry, but starting from a ketone instead of an aldehyde.',
     1);

    -- ── Furanose vs Pyranose Rings ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 22, 'cloze',
     'Only {{c1::5-membered}} and {{c1::6-membered}} cyclic sugars are stable in solution; smaller and larger rings carry too much {{c2::ring strain}}.',
     2),
    (deck, 23, 'cloze',
     'A {{c1::5-membered}} cyclic sugar is called a {{c2::furanose}}; a {{c1::6-membered}} cyclic sugar is called a {{c2::pyranose}}.',
     2),
    (deck, 24, 'cloze',
     'The {{c1::anomeric carbon}} is the carbon in a cyclic sugar that was originally the carbonyl carbon; it is bonded to {{c2::two}} oxygens (one as -OH, one in the ring).',
     2);

    -- ── Alpha vs Beta Anomers + Mutarotation ────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 25, 'cloze',
     'In the {{c1::α-anomer}} of a D-sugar, the hydroxyl on the anomeric carbon points {{c2::trans}} to the CH2OH group (down in Haworth, axial in chair).',
     2),
    (deck, 26, 'cloze',
     'In the {{c1::β-anomer}} of a D-sugar, the hydroxyl on the anomeric carbon points {{c2::cis}} to the CH2OH group (up in Haworth, equatorial in chair).',
     2),
    (deck, 27, 'cloze',
     '{{c1::Mutarotation}} is the spontaneous interconversion of α and β anomers in solution, producing an equilibrium mixture and a measurable shift in {{c2::optical rotation}}.',
     2),
    (deck, 28, 'cloze',
     'The {{c1::α-anomer}} of D-glucose is less stable because the anomeric OH sits {{c2::axial}}, creating more steric strain than the equatorial position of the β-anomer.',
     2);

    -- ── Haworth Projections & Chair Conformations ───────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     'A {{c1::Haworth projection}} draws a cyclic sugar as a planar ring; substituents on the ring point above (up) or below (down) the plane of the page.',
     1),
    (deck, 30, 'cloze',
     'In their most stable form, pyranose rings adopt a {{c1::chair}} conformation; substituents lie in {{c2::axial}} or {{c2::equatorial}} positions to minimize steric strain.',
     2);

    -- ── Oxidation Reactions ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 31, 'cloze',
     'Oxidation of the aldehyde group of an aldose produces a carboxylic acid called an {{c1::aldonic acid}}.',
     1),
    (deck, 32, 'cloze',
     'A {{c1::lactone}} is a cyclic ester; in carbohydrate chemistry, lactones form when the anomeric carbon retains its carbonyl character after oxidation.',
     1),
    (deck, 33, 'cloze',
     'Any monosaccharide that exists in equilibrium with an open-chain form bearing a free aldehyde — i.e., any sugar with a {{c1::hemiacetal}} ring — is a {{c2::reducing sugar}}.',
     2);

    -- ── Reducing Sugars ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     '{{c1::Tollens''}} reagent detects reducing sugars by producing a characteristic {{c2::silver mirror}} as Ag+ is reduced to metallic silver by the aldehyde group.',
     2),
    (deck, 35, 'cloze',
     '{{c1::Benedict''s}} reagent detects reducing sugars by forming a {{c2::red precipitate}} of Cu2O as Cu2+ is reduced to Cu+.',
     2),
    (deck, 36, 'cloze',
     '{{c1::Sucrose}} is a non-reducing sugar: both anomeric carbons are tied up in the glycosidic bond, so neither sugar can open into a free {{c2::aldehyde}}.',
     2);

    -- ── Reduction + Deoxy Sugars + Tautomerization ──────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 37, 'cloze',
     'Reduction of an aldose''s carbonyl group to a hydroxyl produces a sugar alcohol called an {{c1::alditol}}; ribitol and sorbitol are examples.',
     1),
    (deck, 38, 'cloze',
     'A {{c1::deoxy sugar}} has a hydrogen replacing one of its hydroxyl groups; the classic example is {{c2::deoxyribose}}, the sugar of DNA.',
     2),
    (deck, 39, 'cloze',
     '{{c1::Tautomerization}} is the rearrangement of a molecule by moving a hydrogen and shifting a double bond; a keto form can interconvert with its {{c2::enol}} form, which carries a double bond plus a hydroxyl group.',
     2);

    -- ── Esterification + Glycoside Formation ────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 40, 'cloze',
     '{{c1::Esterification}} is a condensation reaction in which a {{c2::carboxylic acid}} reacts with an {{c2::alcohol}} (under acid catalysis) to form an ester and water.',
     2),
    (deck, 41, 'cloze',
     'Sugars commonly form {{c1::phosphate esters}} by reaction with phosphoric acid or ATP; the resulting sugar phosphates (e.g., glucose-6-phosphate) are key intermediates in metabolism.',
     1),
    (deck, 42, 'cloze',
     'When a sugar''s hemiacetal hydroxyl reacts with another alcohol, the anomeric -OH is replaced by an -OR group; the new bond is a {{c1::glycosidic bond}} and the product is a {{c2::glycoside}}.',
     2),
    (deck, 43, 'cloze',
     'Glycoside formation is a {{c1::dehydration}} reaction (loses water); breaking a glycosidic bond requires the reverse reaction — {{c1::hydrolysis}} (adds water).',
     1);

    -- ── Disaccharides ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 44, 'cloze',
     'A {{c1::disaccharide}} is two monosaccharides joined by a single glycosidic bond, formed by a {{c2::dehydration}} reaction between their hydroxyl groups.',
     2),
    (deck, 45, 'cloze',
     '{{c1::Sucrose}} (table sugar) = {{c2::glucose + fructose}} joined by an α-1,2 glycosidic bond.',
     2),
    (deck, 46, 'cloze',
     '{{c1::Lactose}} (milk sugar) = {{c2::galactose + glucose}} joined by a β-1,4 glycosidic bond.',
     2),
    (deck, 47, 'cloze',
     '{{c1::Maltose}} (formed during starch breakdown) = {{c2::glucose + glucose}} joined by an α-1,4 glycosidic bond.',
     2),
    (deck, 48, 'cloze',
     'Quick recall: sucrose uses {{c1::α-1,2}}, lactose uses {{c1::β-1,4}}, and maltose uses {{c1::α-1,4}} glycosidic bonds.',
     1);

    -- ── Polysaccharides ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 49, 'cloze',
     '{{c1::Polysaccharides}} are long chains of monosaccharides linked by glycosidic bonds; they can be branched or linear depending on which hydroxyl groups participate in linkage.',
     1),
    (deck, 50, 'cloze',
     'A {{c1::homopolysaccharide}} contains only one type of monosaccharide (e.g., glycogen — all glucose); a {{c1::heteropolysaccharide}} contains two or more types.',
     1),
    (deck, 51, 'cloze',
     'In a {{c1::linear}} polysaccharide, each internal monomer participates in only two glycosidic bonds; {{c1::branched}} polysaccharides have internal monomers that form three or more glycosidic bonds.',
     1),
    (deck, 52, 'cloze',
     '{{c1::Cellulose}} is a linear homopolysaccharide of {{c2::β-1,4}}-linked D-glucose units; it is the main structural component of {{c3::plant}} cell walls.',
     3),
    (deck, 53, 'cloze',
     'Cellulose chains pack together via {{c1::hydrogen bonds}}, forming stiff structural fibers; humans cannot digest cellulose because we lack the enzyme {{c2::cellulase}}.',
     2),
    (deck, 54, 'cloze',
     '{{c1::Starch}} is the plant equivalent of glycogen — a glucose storage polysaccharide built from {{c2::α-1,4}}-linked D-glucose units that humans can digest.',
     2),
    (deck, 55, 'cloze',
     '{{c1::Amylose}} is the linear form of starch; {{c1::amylopectin}} is the branched form, with α-1,4 main-chain bonds plus periodic {{c2::α-1,6}} branch bonds.',
     2),
    (deck, 56, 'cloze',
     '{{c1::Amylopectin}} is more water-soluble than amylose because its {{c2::branched}} structure exposes more surface to interact with water.',
     2),
    (deck, 57, 'cloze',
     '{{c1::α-amylase}} cleaves α-1,4 bonds randomly along starch, releasing maltose and short chains; {{c1::β-amylase}} cleaves only at the non-reducing end, releasing maltose.',
     1),
    (deck, 58, 'cloze',
     '{{c1::Glycogen}} is the storage polysaccharide of animals — a highly branched glucose polymer with α-1,4 main chains and {{c2::α-1,6}} branch points.',
     2),
    (deck, 59, 'cloze',
     'Glycogen is stored primarily in the {{c1::liver}} and {{c1::skeletal muscle}}; liver glycogen buffers blood glucose, while muscle glycogen fuels local contraction.',
     1),
    (deck, 60, 'cloze',
     'Glycogen is {{c1::more branched}} than amylopectin (more frequent α-1,6 branch points), which increases its water solubility and the rate at which it can be {{c2::degraded}} to glucose.',
     2),
    (deck, 61, 'cloze',
     '{{c1::Glycogen phosphorylase}} cleaves α-1,4 bonds at the non-reducing end of a glycogen branch and adds a phosphate, releasing {{c2::glucose-1-phosphate}} for metabolism.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 62;
END $$;
