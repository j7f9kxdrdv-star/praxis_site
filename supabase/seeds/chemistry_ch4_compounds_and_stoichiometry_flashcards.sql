-- ════════════════════════════════════════════════════════════════════
-- General Chemistry Chapter 4 — Compounds and Stoichiometry
-- ════════════════════════════════════════════════════════════════════
-- Section: chemistry
-- Topic:   General Chemistry
-- Subtopic slug: compounds_and_stoichiometry
-- Sort order: 4
--
-- Coverage (AAMC-aligned order):
--    1. Moles, Mass & the Mole Concept
--    2. Compound Composition & Formulas
--    3. Types of Chemical Reactions
--    4. Balancing Equations & Stoichiometric Calculations
--    5. Ionic Compounds & Nomenclature
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Chemistry (Atoms First) 2e. Scope: AAMC Stoichiometry (GC) — the mole concept, formulas,
-- reaction types, balancing, limiting reagent/yields, and ionic nomenclature; Avogadro's Law/
-- gas, deep redox (Ch 11), and deep solutions (Ch 9) are out of scope. See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'chemistry'
      AND title IN (
          'Compounds and Stoichiometry',
          'Compounds & Stoichiometry',
          'General Chemistry Review Chapter Four: Compounds and Stoichiometry'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'chemistry',
        'General Chemistry',
        'compounds_and_stoichiometry',
        'Compounds and Stoichiometry',
        'The mole concept and molar mass, empirical vs molecular formulas and percent composition, the major reaction types, balancing equations and stoichiometric calculations (limiting reagent, theoretical and percent yield), and ionic compound nomenclature and electrolytes.',
        4
    )
    RETURNING id INTO deck;

    -- ── Moles, Mass & the Mole Concept ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'One mole of a substance contains {{c1::6.022×10²³}} particles, a value known as {{c2::Avogadro''s number}}.',
     2),
    (deck, 1, 'cloze',
     'A compound''s molar mass in g/mol and its formula weight in amu have the {{c1::same numeric value}}.',
     1),
    (deck, 2, 'cloze',
     'A compound''s formula (molecular) weight is the {{c1::sum}} of the average atomic masses (in amu) of all atoms in its formula.',
     1),
    (deck, 3, 'cloze',
     'A compound is a pure substance made of {{c1::two or more elements}} chemically combined in a fixed mass ratio.',
     1),
    (deck, 4, 'cloze',
     'Density equals an object''s {{c1::mass}} divided by its {{c1::volume}}.',
     1),
    (deck, 5, 'cloze',
     'For acid–base and redox reactions, one equivalent is one {{c1::mole}} of the reacting species (protons or electrons) exchanged.',
     1);

    -- ── Compound Composition & Formulas ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 6, 'cloze',
     'The principle that any pure sample of a compound always contains the same elements in the same mass ratio is the law of {{c1::constant composition (definite proportions)}}.',
     1),
    (deck, 7, 'cloze',
     'A compound''s empirical formula expresses its atoms as their {{c1::smallest whole-number ratio}}.',
     1),
    (deck, 8, 'cloze',
     'A compound''s molecular formula states the {{c1::actual number of atoms}} of each element in one molecule.',
     1),
    (deck, 9, 'cloze',
     'A molecular formula is always a {{c1::whole-number multiple}} of the compound''s empirical formula.',
     1),
    (deck, 10, 'cloze',
     'Percent composition by mass of an element = (mass of that element ÷ {{c1::molar mass of the compound}}) × 100%.',
     1),
    (deck, 11, 'cloze',
     'To determine an empirical formula, convert each element''s mass or percent to {{c1::moles}}, then divide every value by the {{c2::smallest}} one.',
     2),
    (deck, 12, 'cloze',
     'To scale an empirical formula up to the true molecular formula, you must also know the compound''s {{c1::molar mass}}.',
     1);

    -- ── Types of Chemical Reactions ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 13, 'cloze',
     'A reaction that joins two or more reactants into a single product is a {{c1::combination}} (or {{c1::synthesis}}) reaction.',
     1),
    (deck, 14, 'cloze',
     'A reaction in which a single reactant splits into two or more products is a {{c1::decomposition}} reaction.',
     1),
    (deck, 15, 'cloze',
     'In complete combustion, a hydrocarbon fuel reacts with O₂ to yield {{c1::CO₂ and H₂O}}.',
     1),
    (deck, 16, 'cloze',
     'A + BC → AC + B, where free element A bonds with C and releases B, is a {{c1::single-displacement}} (or {{c1::replacement}}) reaction.',
     1),
    (deck, 17, 'cloze',
     'A reaction in which two compounds exchange ions to form two new compounds is a {{c1::double-displacement}} (or {{c1::metathesis}}) reaction.',
     1),
    (deck, 18, 'cloze',
     'A double-displacement reaction that yields an insoluble solid product is classified as a {{c1::precipitation}} reaction.',
     1),
    (deck, 19, 'cloze',
     'A neutralization reaction between an acid and a base produces {{c1::a salt and water}}.',
     1),
    (deck, 20, 'cloze',
     'In a {{c1::disproportionation}} reaction, a single element is simultaneously oxidized and reduced.',
     1);

    -- ── Balancing Equations & Stoichiometric Calculations ─────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 21, 'cloze',
     'Balance a chemical equation only by changing {{c1::coefficients}}, never {{c1::subscripts}}, because changing the latter would alter the compound''s identity.',
     1),
    (deck, 22, 'cloze',
     'When balancing by inspection, adjust the {{c1::least common}} atoms first and leave {{c1::hydrogen and oxygen}} for last.',
     1),
    (deck, 23, 'cloze',
     'The coefficients of a balanced equation give the {{c1::mole ratios}} used to relate quantities of reactants and products.',
     1),
    (deck, 24, 'cloze',
     'No stoichiometric (mole-ratio) calculation is valid until the chemical equation is first {{c1::balanced}}.',
     1),
    (deck, 25, 'cloze',
     'The reactant used up first in a reaction, which therefore sets the maximum product yield, is the {{c1::limiting}} reactant.',
     1),
    (deck, 26, 'cloze',
     '{{c1::Theoretical yield}} is the maximum product obtainable when the limiting reactant is fully consumed with no side reactions.',
     1),
    (deck, 27, 'cloze',
     'Percent yield = ({{c1::actual}} yield ÷ {{c1::theoretical}} yield) × 100%.',
     1),
    (deck, 28, 'cloze',
     'An {{c1::oxidation number}} is the hypothetical charge an atom would carry if the compound''s bonds were treated as fully ionic.',
     1),
    (deck, 29, 'cloze',
     'Oxidation-number rules: a free, uncombined element is assigned {{c1::0}}, and a monatomic ion is assigned {{c2::its charge}}.',
     2),
    (deck, 30, 'cloze',
     'In most compounds oxygen''s oxidation number is {{c1::−2}}, and hydrogen''s is usually {{c2::+1}}.',
     2),
    (deck, 31, 'cloze',
     'The oxidation numbers of every atom in a molecule or ion add up to that species'' {{c1::total charge}}.',
     1);

    -- ── Ionic Compounds & Nomenclature ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     'When a metal can exist as several different cations, its charge is written as a {{c1::Roman numeral}} in parentheses directly after the metal name.',
     1),
    (deck, 33, 'cloze',
     'A representative element''s ionic charge can be predicted directly from its {{c1::group number}} on the periodic table.',
     1),
    (deck, 34, 'cloze',
     'In the older naming system, the suffix -ous denotes a metal cation''s {{c1::lower}} charge and -ic denotes its {{c1::higher}} charge.',
     1),
    (deck, 35, 'cloze',
     'A monatomic anion is named by taking the nonmetal element''s name and replacing its ending with the suffix {{c1::-ide}}.',
     1),
    (deck, 36, 'cloze',
     'For oxyanions of the same central element, the -ate form contains {{c1::more}} oxygen atoms than the -ite form.',
     1),
    (deck, 37, 'cloze',
     'At the extremes of an oxyanion series, the prefix {{c1::hypo-}} marks the fewest oxygens (e.g. ClO⁻) and {{c1::per-}} the most (e.g. ClO₄⁻).',
     1),
    (deck, 38, 'cloze',
     'A {{c1::strong}} electrolyte dissociates essentially completely in solution, whereas a {{c1::weak}} electrolyte only partially ionizes.',
     1),
    (deck, 39, 'cloze',
     'Even a sparingly soluble ionic compound counts as a {{c1::strong}} electrolyte, because the small fraction that dissolves dissociates {{c1::completely}}.',
     1),
    (deck, 40, 'cloze',
     'A substance that dissolves without producing any ions is a {{c1::nonelectrolyte}}, so its solution cannot conduct electricity.',
     1),
    (deck, 41, 'cloze',
     'An electrolyte solution conducts electricity because the dissolved compound releases freely mobile {{c1::ions}} into the water.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 42;
END $$;
