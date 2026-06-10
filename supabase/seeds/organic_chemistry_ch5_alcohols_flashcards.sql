-- Praxis Prep — Organic Chemistry Chapter 5: Alcohols
-- v6-compliant flashcard deck (26 cards)
-- Subtopics: 5.1 Description and Properties (10), 5.2 Reactions of Alcohols (9),
-- 5.3 Reactions of Phenols (7) — high-yield.
-- Source-laundered against LibreTexts Organic Chemistry (alcohols, phenols, quinones
-- chapters), OpenStax Biology 2e (electron transport chain for ubiquinone), and
-- AAMC content outline (CP 4D reactivity, BB 1D bioenergetics for the ETC links).
-- Per user direction, all crossover cards with General Chemistry decks (Acids and
-- Bases, Oxidation-Reduction Reactions) and OrgChem Ch 4 (Analyzing Organic
-- Reactions) are retained for spaced-repetition reinforcement with alcohol-specific
-- framing.
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Alcohols',
            'Organic Chemistry Chapter 5: Alcohols',
            'Orgo Chapter 5: Alcohols'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Alcohols',
        'Organic Chemistry Chapter 5: Alcohols',
        'Orgo Chapter 5: Alcohols'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'organic_chemistry',
        'Organic Chemistry',
        'alcohols',
        'Alcohols',
        'Alcohol structure (ROH with -OH hydroxyl) and IUPAC naming (-ol suffix, hydroxy- prefix); phenols and ortho/meta/para substitution; hydrogen bonding effects on boiling point and solubility; acidity factors (phenoxide ring delocalization, electron-withdrawing vs electron-donating groups, alkyl group effects on cations vs anions); reactions of alcohols (PCC mild anhydrous oxidation of primary alcohols to aldehydes only because no geminal diol forms, secondary alcohols to ketones, tertiary alcohols cannot be oxidized; Jones oxidation with CrO₃ in dilute sulfuric acid taking primary to carboxylic acids; mesylates and tosylates as improved leaving groups; acetal and ketal formation from alcohols as carbonyl protecting groups with aqueous-acid deprotection); and reactions of phenols (quinones from phenol oxidation as resonance-stabilized electrophiles, biological role as electron acceptors in the electron transport chain and photosynthesis, vitamin K1 phylloquinone vs vitamin K2 menaquinone for blood clotting and bone health, hydroxyquinones with electron-donating hydroxyl substituents, and ubiquinone / Coenzyme Q as the ETC electron carrier with lipid-soluble long alkyl chain that reduces to ubiquinol).',
        5
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 5.1 Description and Properties (cards 1–10)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        '{{c1::Alcohols}} have the general formula {{c2::R–OH}}, where the {{c3::–OH (hydroxyl)}} group is the functional group.',
        3),
    (deck, 1, 'cloze',
        'In IUPAC nomenclature, alcohols take the suffix {{c1::-ol}}; when not the highest-priority functional group, they appear as a substituent with the prefix {{c2::hydroxy-}}.',
        2),
    (deck, 2, 'cloze',
        'A {{c1::phenol}} is a benzene ring with a {{c2::hydroxyl group}} directly attached; phenols are {{c3::more acidic}} than ordinary alcohols.',
        3),
    (deck, 3, 'cloze',
        'On a benzene ring with two substituents, their relative positions are: {{c1::ortho (o-)}} for adjacent carbons, {{c1::meta (m-)}} for one carbon between, and {{c1::para (p-)}} for opposite sides of the ring.',
        1),
    (deck, 4, 'cloze',
        'Alcohols have significantly {{c1::higher melting and boiling points}} than analogous hydrocarbons because of {{c2::intermolecular hydrogen bonding}}; more –OH groups → more H-bonding → higher BP.',
        2),
    (deck, 5, 'cloze',
        'Hydrogen bonding requires hydrogen attached to a {{c1::highly electronegative atom (N, O, or F)}}, which creates the {{c2::extreme polarity}} needed for the interaction.',
        2),
    (deck, 6, 'cloze',
        'Phenols are more acidic than ordinary alcohols because the {{c1::phenoxide conjugate base}} delocalizes the negative charge into the {{c2::aromatic ring}} via resonance.',
        2),
    (deck, 7, 'cloze',
        '{{c1::Electron-withdrawing groups}} increase acidity by {{c2::stabilizing the negative charge}} of the conjugate base; {{c1::electron-donating groups}} decrease acidity by {{c2::destabilizing}} it.',
        2),
    (deck, 8, 'cloze',
        '{{c1::Alkyl groups}} (electron-donating) {{c2::stabilize positive charges}} (helpful for carbocations) but {{c3::destabilize negative charges}} (making non-aromatic alcohols less acidic).',
        3),
    (deck, 9, 'cloze',
        'Relative boiling-point ranking from H-bonding strength: a {{c1::diol}} (two –OH) > a {{c1::monoalcohol of the same chain length}} > the {{c1::analogous alkane}}; longer chains add van der Waals on top of H-bonding.',
        1);

    -- ============================================================
    -- 5.2 Reactions of Alcohols (cards 11–19)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
        '{{c1::PCC (pyridinium chlorochromate)}} is a {{c2::mild, anhydrous oxidant}} commonly used in organic synthesis.',
        2),
    (deck, 11, 'cloze',
        '{{c1::Primary alcohols + PCC}} → {{c2::aldehydes}} (the reaction stops here and does not proceed to the carboxylic acid).',
        2),
    (deck, 12, 'cloze',
        'PCC stops at the aldehyde because it is {{c1::anhydrous}} — without water, the aldehyde cannot form a {{c2::geminal diol}} intermediate, which is the species that other oxidizers overoxidize to the {{c3::carboxylic acid}}.',
        3),
    (deck, 13, 'cloze',
        '{{c1::Secondary alcohols + PCC (or any stronger oxidizer)}} → {{c2::ketones}}.',
        2),
    (deck, 14, 'cloze',
        '{{c1::Tertiary alcohols}} cannot be further oxidized because they are already as oxidized as possible without {{c2::breaking a C–C bond}}.',
        2),
    (deck, 15, 'cloze',
        '{{c1::Jones oxidation}} (CrO₃ in dilute H₂SO₄ + acetone) oxidizes {{c2::primary alcohols → carboxylic acids}} and {{c3::secondary alcohols → ketones}}.',
        3),
    (deck, 16, 'cloze',
        'The hydroxyl of an alcohol is a poor leaving group, but converting it to a {{c1::mesylate (–OSO₂CH₃)}} or a {{c1::tosylate (–OSO₂C₆H₄CH₃)}} produces a {{c2::much better leaving group}} for nucleophilic substitution.',
        2),
    (deck, 17, 'cloze',
        'Aldehydes and ketones can be protected by reaction with {{c1::two equivalents of alcohol (or a diol)}} to form an {{c2::acetal}} (from aldehydes) or a {{c2::ketal}} (from ketones).',
        2),
    (deck, 18, 'cloze',
        '{{c1::Deprotection}} of an acetal or ketal back to the parent carbonyl is accomplished with {{c2::aqueous acid}}.',
        2);

    -- ============================================================
    -- 5.3 Reactions of Phenols (cards 20–26) ★ high-yield
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 19, 'cloze',
        'Treatment of phenols with oxidizing agents produces {{c1::quinones}} — cyclic diones in which two ring carbons become {{c2::carbonyl groups}}; the conjugated ring makes them {{c3::resonance-stabilized electrophiles}}.',
        3),
    (deck, 20, 'cloze',
        'Quinones biologically act as {{c1::electron acceptors}}, notably in the {{c2::electron transport chain}} of both {{c3::aerobic respiration and photosynthesis}}.',
        3),
    (deck, 21, 'cloze',
        '{{c1::Vitamin K₁ (phylloquinone)}} is found in {{c2::green leafy vegetables}}; {{c1::Vitamin K₂ (menaquinone)}} is produced by {{c2::gut bacteria}} — both are quinones essential for {{c3::blood clotting and bone health}}.',
        3),
    (deck, 22, 'cloze',
        '{{c1::Hydroxyquinones}} share the quinone backbone but carry one or more {{c2::hydroxyl substituents}}; these electron-donating groups make them {{c3::slightly less electrophilic}} than parent quinones.',
        3),
    (deck, 23, 'cloze',
        '{{c1::Ubiquinone (Coenzyme Q)}} is the most biologically important quinone — an electron carrier associated with {{c2::Complexes I, II, and III}} of the mitochondrial electron transport chain.',
        2),
    (deck, 24, 'cloze',
        'Ubiquinone is the {{c1::oxidized}} form; it accepts electrons to become {{c2::ubiquinol}} (the reduced form). Its {{c3::long alkyl chain}} makes it lipid-soluble so it can shuttle within the inner mitochondrial membrane.',
        3),
    (deck, 25, 'cloze',
        'The conjugated ring system of quinones (including ubiquinone) provides {{c1::resonance stabilization}} that lowers the energy barrier for {{c2::electron transfer}}, which is why nature uses them as redox carriers.',
        2);

    RAISE NOTICE 'Seeded deck % with 26 cards.', deck;
END $$;
