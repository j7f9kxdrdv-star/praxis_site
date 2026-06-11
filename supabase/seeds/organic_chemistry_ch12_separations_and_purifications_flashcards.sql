-- Praxis Prep — Organic Chemistry Chapter 12: Separations and Purifications
-- v6-compliant flashcard deck (41 cards)
-- Subtopics: 12.1 Solubility-Based Methods (12), 12.2 Distillation (7), 12.3 Chromatography (22)
-- Source-laundered against LibreTexts Organic Chemistry (Nichols' Lab Techniques),
-- LibreTexts Analytical Chemistry, OpenStax Chemistry 2e, and AAMC content outline (CP 4D).
-- Idempotent: deletes any prior version of this deck under historical title spellings before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Separations and Purifications',
            'Organic Chemistry Chapter 12: Separations and Purifications',
            'Organic Chemistry Ch 12: Separations and Purifications',
            'Organic Chemistry Chapter 12 - Separations and Purifications'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Organic Chemistry Chapter 12: Separations and Purifications',
        'Organic Chemistry Ch 12: Separations and Purifications',
        'Organic Chemistry Chapter 12 - Separations and Purifications'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'organic_chemistry',
        'Organic Chemistry',
        'separations and purifications',
        'Separations and Purifications',
        'Solubility-based methods (extraction, washing, filtration, recrystallization), distillation (simple, vacuum, fractional), and chromatography (TLC, paper, reverse-phase, column, ion-exchange, size-exclusion, affinity, GC, GC-MS, HPLC).',
        12
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 12.1 Solubility-Based Methods (cards 1–12)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'In {{c1::extraction}}, a mixture is shaken with {{c2::two immiscible solvents}} so the target compound concentrates in {{c3::the phase where it is more soluble}}.',
        3),
    (deck, 1, 'cloze',
        'Splitting a fixed solvent volume across {{c1::several smaller extractions}} pulls out {{c2::more total solute}} than using the same volume in {{c3::a single large extraction}}.',
        3),
    (deck, 2, 'cloze',
        'In extraction, the {{c1::aqueous}} phase dissolves {{c2::polar and hydrogen-bonding}} compounds, while the {{c3::organic}} phase dissolves {{c4::nonpolar}} compounds.',
        4),
    (deck, 3, 'cloze',
        'A {{c1::separatory funnel}} holds the two immiscible layers; gentle swirling maximizes contact, then the layers are allowed to {{c2::settle into a sharp interface}} before draining.',
        2),
    (deck, 4, 'cloze',
        'In a separatory funnel, the {{c1::denser}} layer is drained out {{c2::the bottom stopcock}} first; for most organic work this is the {{c3::aqueous}} layer.',
        3),
    (deck, 5, 'cloze',
        'Acid–base extraction trick: add aqueous {{c1::base}} to deprotonate an organic acid into its {{c2::water-soluble conjugate base}}, or add aqueous {{c1::acid}} to protonate an organic base into its {{c2::water-soluble conjugate acid}}.',
        2),
    (deck, 6, 'cloze',
        'A {{c1::wash}} is the reverse of extraction: a small amount of solvent is run over the product to dissolve {{c2::impurities}} while leaving the {{c3::target compound}} behind.',
        3),
    (deck, 7, 'cloze',
        'A {{c1::rotary evaporator}} removes volatile solvent from a dissolved product by combining {{c2::reduced pressure}} with gentle warming so the solvent {{c3::boils off at a lower temperature}}.',
        3),
    (deck, 8, 'cloze',
        '{{c1::Filtration}} separates a {{c2::solid (residue)}} from a {{c3::liquid (filtrate)}} by passing the mixture through a porous medium.',
        3),
    (deck, 9, 'cloze',
        '{{c1::Gravity filtration}} is used when the {{c2::filtrate}} is the desired product; a {{c3::hot solvent}} is often used so the product stays {{c4::dissolved}} as it passes through.',
        4),
    (deck, 10, 'cloze',
        '{{c1::Vacuum filtration}} is used when the {{c2::solid}} is the desired product; applied suction pulls the liquid through the filter quickly so the {{c3::crystals dry on the filter pad}}.',
        3),
    (deck, 11, 'cloze',
        'In {{c1::recrystallization}}, a solid is dissolved in {{c2::hot solvent}} and then cooled slowly so the pure product {{c3::crystallizes out}} while impurities {{c4::stay in solution}}.',
        4);

    -- ============================================================
    -- 12.2 Distillation (cards 13–19)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 12, 'cloze',
        '{{c1::Distillation}} separates liquids by differences in {{c2::boiling point}} — the component with the {{c3::lowest boiling point}} vaporizes first and is collected after {{c4::condensing back to liquid}}.',
        4),
    (deck, 13, 'cloze',
        '{{c1::Simple distillation}} works when both liquids boil below {{c2::150 °C}} and their boiling points differ by at least {{c3::25 °C}}.',
        3),
    (deck, 14, 'cloze',
        '{{c1::Vacuum distillation}} is used when boiling points are above {{c2::150 °C}}; lowering the pressure {{c3::lowers the boiling point}} so the product distills without {{c4::thermal degradation}}.',
        4),
    (deck, 15, 'cloze',
        'When two liquids'' boiling points differ by {{c1::less than 25 °C}}, use {{c2::fractional distillation}}; the {{c3::fractionating column}} forces repeated {{c4::condense–revaporize cycles}} that sharpen the separation.',
        4),
    (deck, 16, 'cloze',
        '{{c1::Boiling chips}} are added to distillation flasks to provide nucleation sites that prevent {{c2::superheating}} and the sudden, violent boiling known as {{c3::bumping}}.',
        3),
    (deck, 17, 'cloze',
        'To separate {{c1::hexane (69 °C)}} from {{c2::toluene (110 °C)}}, choose {{c3::simple}} distillation because the boiling-point gap exceeds {{c4::25 °C}} and both stay under 150 °C.',
        4),
    (deck, 18, 'cloze',
        'To separate {{c1::ether (35 °C)}} from {{c2::methylene chloride (40 °C)}}, choose {{c3::fractional}} distillation because the boiling-point gap is under {{c4::25 °C}}.',
        4);

    -- ============================================================
    -- 12.3 Chromatography (cards 20–41) ★ high-yield
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 19, 'cloze',
        'Every form of chromatography moves a sample dissolved in a {{c1::mobile phase}} past a {{c2::stationary phase}}, separating compounds by how strongly each interacts with {{c3::the stationary phase}}.',
        3),
    (deck, 20, 'cloze',
        'In standard chromatography, the {{c1::stationary phase}} is typically a {{c2::polar solid}}, and the {{c3::mobile phase}} is a {{c4::liquid or gas}} that carries the sample through.',
        4),
    (deck, 21, 'cloze',
        'As the mobile phase {{c1::elutes}} (flows through) the stationary phase, dissolved compounds are {{c2::carried along at different rates}} depending on their {{c3::affinity for each phase}}.',
        3),
    (deck, 22, 'cloze',
        '{{c1::Partitioning}} describes how each compound divides between the two phases — those with greater affinity for the {{c2::mobile phase}} travel {{c3::faster}} and separate out earlier.',
        3),
    (deck, 23, 'cloze',
        'A compound with strong affinity for the {{c1::stationary phase}} has a {{c2::smaller}} retention factor and migrates {{c3::more slowly}} than one that prefers the mobile phase.',
        3),
    (deck, 24, 'cloze',
        'The retention factor is calculated as {{c1::distance traveled by the spot}} divided by {{c2::distance traveled by the solvent front}}; values fall between {{c3::0 and 1}}.',
        3),
    (deck, 25, 'cloze',
        '{{c1::Thin-layer (TLC)}} and {{c1::paper}} chromatography identify {{c2::small, non-volatile compounds}}; both use a {{c3::polar}} stationary phase (silica or paper) with a {{c4::nonpolar}} mobile phase.',
        4),
    (deck, 26, 'cloze',
        'Because TLC spots are colorless, they are visualized with {{c1::UV light}}, an {{c2::iodine chamber}}, or by spraying with a {{c3::chemical stain}}.',
        3),
    (deck, 27, 'cloze',
        '{{c1::Reverse-phase chromatography}} flips the standard polarity setup: the stationary phase is {{c2::nonpolar}} and the mobile phase is {{c3::polar}}.',
        3),
    (deck, 28, 'cloze',
        '{{c1::Column chromatography}} packs the stationary phase ({{c2::silica or alumina beads}}) into a vertical tube and can separate by {{c3::polarity, size, or affinity}} depending on the column type.',
        3),
    (deck, 29, 'cloze',
        'In a standard column, a {{c1::nonpolar solvent}} flows {{c2::down through the beads under gravity}}, and {{c3::fractions are collected}} at the bottom as different compounds elute.',
        3),
    (deck, 30, 'cloze',
        'Three specialized column chromatographies sort compounds by different properties: {{c1::ion-exchange}} (by {{c2::charge}}), {{c1::size-exclusion}} (by {{c2::molecular size}}), and {{c1::affinity}} (by {{c2::specific binding}}).',
        2),
    (deck, 31, 'cloze',
        '{{c1::Ion-exchange}} chromatography uses a {{c2::charged}} stationary phase to bind compounds carrying the {{c3::opposite charge}}; releasing them requires changing {{c4::pH or salt concentration}}.',
        4),
    (deck, 32, 'cloze',
        'In {{c1::size-exclusion}} chromatography, the beads have pores that trap {{c2::small molecules}}; {{c3::large molecules}} cannot enter and so elute {{c4::first}}.',
        4),
    (deck, 33, 'cloze',
        '{{c1::Affinity}} chromatography uses a stationary phase functionalized with a {{c2::specific binding partner}} (e.g., an antibody or receptor) that traps only the {{c3::target compound}}.',
        3),
    (deck, 34, 'cloze',
        'To recover the target from an affinity column, the {{c1::buffer is changed}} (pH, salt, or competing ligand) to {{c2::disrupt the binding interaction}} and elute the compound.',
        2),
    (deck, 35, 'cloze',
        '{{c1::Gas chromatography (GC)}} vaporizes the sample and separates components by how strongly each {{c2::adsorbs to the column''s coating}}; signal is detected as compounds {{c3::exit the column}}.',
        3),
    (deck, 36, 'cloze',
        'In GC, the {{c1::stationary phase}} is a long coiled column coated with {{c2::a metal or polymer}}, and the {{c3::mobile phase}} is an {{c4::inert (nonreactive) gas}} such as helium.',
        4),
    (deck, 37, 'cloze',
        'GC requires samples to be {{c1::volatile}} (easily vaporized) — typically {{c2::low-boiling liquids}} or {{c3::sublimable solids}}; nonvolatile compounds must be analyzed by a different method.',
        3),
    (deck, 38, 'cloze',
        'Pairing GC with {{c1::mass spectrometry (GC-MS)}} adds {{c2::molecular weight and fragmentation data}} to retention time, enabling structural identification of unknown components in a mixture.',
        2),
    (deck, 39, 'cloze',
        '{{c1::High-performance liquid chromatography (HPLC)}} was originally defined by its {{c2::high operating pressure}}; modern HPLC is distinguished instead by {{c3::computer-controlled solvent gradients}} and {{c4::sophisticated detectors}}.',
        4),
    (deck, 40, 'cloze',
        'HPLC achieves high resolution on very {{c1::small sample sizes}}, which is critical for analyzing {{c2::trace components}} in pharmaceutical and biological samples.',
        2);

    RAISE NOTICE 'Seeded deck % with 41 cards.', deck;
END $$;
