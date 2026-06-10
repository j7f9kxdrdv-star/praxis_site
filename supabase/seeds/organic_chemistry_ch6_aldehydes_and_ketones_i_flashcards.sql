-- Praxis Prep — Organic Chemistry Chapter 6: Aldehydes and Ketones I
-- v6-compliant flashcard deck (25 cards)
-- Subtopics: 6.1 Description and Properties (8), 6.2 Nucleophilic Addition Reactions (12),
-- 6.3 Oxidation-Reduction Reactions (5).
-- Source-laundered against LibreTexts Organic Chemistry (Aldehydes & Ketones,
-- Nucleophilic Addition chapters), OpenStax Chemistry: Atoms First 2e, and AAMC content
-- outline (CP 4D reactivity, CP 5C stereochemistry).
-- Per user direction, all crossover cards with OrgChem Ch 4 (Analyzing Organic Reactions),
-- OrgChem Ch 5 (Alcohols), and GenChem Ch 11 (Oxidation-Reduction) are retained with
-- aldehyde/ketone-specific framing.
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Aldehydes and Ketones I',
            'Organic Chemistry Chapter 6: Aldehydes and Ketones I',
            'Orgo Chapter 6: Aldehydes and Ketones I'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Aldehydes and Ketones I',
        'Organic Chemistry Chapter 6: Aldehydes and Ketones I',
        'Orgo Chapter 6: Aldehydes and Ketones I'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'organic_chemistry',
        'Organic Chemistry',
        'aldehydes and ketones i',
        'Aldehydes and Ketones I',
        'Aldehyde (terminal carbonyl + at least one H) vs ketone (internal carbonyl + two alkyl groups) structure and IUPAC naming (-al, -one, oxo-, keto-, -carbaldehyde); carbonyl polarity and electrophilicity; boiling point hierarchy (alcohol > carbonyl > alkane); why aldehydes are more reactive than ketones (less steric hindrance, fewer EDG); formation from alcohol oxidation (1° → aldehyde with PCC only, 2° → ketone with many oxidizers); nucleophilic addition mechanism with no-good-LG protonation pathway vs good-LG carbonyl-reformation pathway; hydration to geminal diols; hemiacetals/hemiketals from one equivalent of alcohol and acetals/ketals from two equivalents via anhydrous acid SN1; acetals and ketals as carbonyl protecting groups with aqueous-acid deprotection; imine formation from ammonia or primary amine; oximes, hydrazones, semicarbazones from hydroxylamine, hydrazine, and semicarbazide respectively; imine to enamine tautomerization; cyanohydrins from HCN; aldehyde oxidation to carboxylic acid by stronger-than-PCC oxidizers (KMnO₄, CrO₃, Ag₂O, H₂O₂); ketone resistance to further oxidation; and hydride reduction back to alcohols via LiAlH₄ (strong) vs NaBH₄ (mild, selective for aldehydes and ketones only).',
        6
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 6.1 Description and Properties (cards 1–8)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'An {{c1::aldehyde}} contains a {{c2::terminal carbonyl}} bonded to at least one {{c3::hydrogen}} — the C=O is always at the end of a chain.',
        3),
    (deck, 1, 'cloze',
        'A {{c1::ketone}} contains an {{c2::internal carbonyl}} bonded to {{c3::two alkyl groups}} — the carbonyl is never at the end of a chain.',
        3),
    (deck, 2, 'cloze',
        'Aldehydes take the IUPAC suffix {{c1::-al}}; when not the highest-priority group, they appear as a substituent with the prefix {{c2::oxo-}}; aldehydes attached to a ring use the suffix {{c3::-carbaldehyde}}.',
        3),
    (deck, 3, 'cloze',
        'Ketones take the IUPAC suffix {{c1::-one}}; when used as a substituent, they take the prefix {{c2::oxo- or keto-}}.',
        2),
    (deck, 4, 'cloze',
        'The C=O double bond is strongly polarized — oxygen pulls electron density toward itself, leaving the {{c1::carbonyl carbon}} with a {{c2::partial positive charge}} that makes it {{c3::electrophilic}}.',
        3),
    (deck, 5, 'cloze',
        'For molecules of the same chain length, boiling points rank {{c1::alcohol > carbonyl > alkane}} — alcohols can {{c2::hydrogen bond}}, carbonyls have {{c3::dipole–dipole interactions only}}, and alkanes have only van der Waals forces.',
        3),
    (deck, 6, 'cloze',
        '{{c1::Aldehydes}} are more reactive toward nucleophiles than {{c2::ketones}} for two reasons: {{c3::less steric hindrance and fewer electron-donating alkyl groups stabilizing the partial positive charge}}.',
        3),
    (deck, 7, 'cloze',
        '{{c1::Primary alcohols}} oxidize to {{c2::aldehydes}} only when using {{c3::PCC}} (stronger oxidizers overoxidize to carboxylic acids); {{c1::secondary alcohols}} oxidize to {{c2::ketones}} with PCC, Na₂Cr₂O₇, CrO₃, or KMnO₄.',
        3);

    -- ============================================================
    -- 6.2 Nucleophilic Addition Reactions (cards 9–20)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
        'In nucleophilic addition to a carbonyl, the {{c1::nucleophile attacks the carbonyl carbon}}, pushing the {{c2::π electrons up onto the oxygen}} to form an alkoxide intermediate.',
        2),
    (deck, 9, 'cloze',
        'When there is {{c1::no good leaving group}} on the substrate, the carbonyl cannot reform — instead the alkoxide intermediate is {{c2::protonated}} to give an {{c3::alcohol}}.',
        3),
    (deck, 10, 'cloze',
        'When a {{c1::good leaving group}} IS present (e.g., on a carboxylic acid derivative), the carbonyl reforms and {{c2::kicks off the leaving group}} — this is the basis of nucleophilic acyl substitution.',
        2),
    (deck, 11, 'cloze',
        'In the presence of water, aldehydes and ketones form {{c1::geminal diols}} (two –OH groups on the same carbon) when {{c2::water acts as the nucleophile}} attacking the carbonyl carbon.',
        2),
    (deck, 12, 'cloze',
        'Adding {{c1::one equivalent}} of alcohol to an aldehyde gives a {{c2::hemiacetal}}; the same reaction with a ketone gives a {{c2::hemiketal}}.',
        2),
    (deck, 13, 'cloze',
        'Adding {{c1::two equivalents}} of alcohol to an aldehyde gives an {{c2::acetal}}; with a ketone gives a {{c2::ketal}}. The reaction is catalyzed by {{c3::anhydrous acid}} via an SN1-like mechanism.',
        3),
    (deck, 14, 'cloze',
        'In acetal/ketal formation, the hemiacetal/hemiketal –OH is {{c1::protonated and leaves as water}}, generating a {{c2::carbocation (oxocarbenium ion)}} that the second alcohol attacks.',
        2),
    (deck, 15, 'cloze',
        'Acetals and ketals serve as {{c1::protecting groups}} for carbonyl functionalities; deprotection back to the carbonyl uses {{c2::aqueous acid and heat}}.',
        2),
    (deck, 16, 'cloze',
        'When {{c1::ammonia (NH₃)}} or a primary amine attacks an aldehyde/ketone, the nitrogen displaces oxygen — water is lost and an {{c2::imine (C=N)}} forms.',
        2),
    (deck, 17, 'cloze',
        'Four ammonia-derivative reactions with carbonyls: {{c1::hydroxylamine}} → {{c2::oxime}}; {{c1::hydrazine}} → {{c2::hydrazone}}; {{c1::semicarbazide}} → {{c2::semicarbazone}}; {{c1::primary amine}} → {{c2::imine}}.',
        2),
    (deck, 18, 'cloze',
        'Imines can {{c1::tautomerize}} into {{c2::enamines}}, which contain both a {{c3::C=C double bond and a nitrogen substituent}} (analogous to keto–enol tautomerization).',
        3),
    (deck, 19, 'cloze',
        '{{c1::Hydrogen cyanide (HCN)}} reacts with aldehydes and ketones to form {{c2::cyanohydrins}} — stable products containing both an –OH and a –CN on the same carbon.',
        2);

    -- ============================================================
    -- 6.3 Oxidation-Reduction Reactions (cards 21–25)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
        'Aldehydes can be further oxidized to {{c1::carboxylic acids}} by any oxidizing agent {{c2::stronger than PCC}}.',
        2),
    (deck, 21, 'cloze',
        'Common reagents that oxidize aldehydes to carboxylic acids: {{c1::KMnO₄}}, {{c1::CrO₃}}, {{c1::Ag₂O}}, and {{c1::H₂O₂}}.',
        1),
    (deck, 22, 'cloze',
        'Ketones {{c1::cannot be further oxidized}} (the carbonyl carbon is already maximally oxidized without breaking a C–C bond), but they can be reduced back to {{c2::secondary alcohols}}.',
        2),
    (deck, 23, 'cloze',
        'Hydride reagents reduce carbonyls back to alcohols: {{c1::aldehydes}} → {{c2::primary alcohols}}; {{c1::ketones}} → {{c2::secondary alcohols}}.',
        2),
    (deck, 24, 'cloze',
        '{{c1::LiAlH₄}} is a strong reducing agent that handles carboxylic acids, esters, amides, plus aldehydes and ketones; {{c2::NaBH₄}} is milder — useful when you want to reduce only {{c3::aldehydes or ketones}} and leave other functional groups intact.',
        3);

    RAISE NOTICE 'Seeded deck % with 25 cards.', deck;
END $$;
