-- Praxis Prep — Organic Chemistry Chapter 8: Carboxylic Acids
-- v6-compliant flashcard deck (26 cards)
-- Subtopics: 8.1 Description and Properties (10), 8.2 Reactions of Carboxylic Acids (16).
-- Source-laundered against LibreTexts Organic Chemistry (Carboxylic Acids and Derivatives
-- chapters), OpenStax Chemistry: Atoms First 2e, and AAMC content outline (CP 4D reactivity,
-- CP 5E acid-base, BB 1B macromolecules for amide bonds).
-- Per user direction, all crossover cards with OrgChem Ch 4 (Analyzing Organic Reactions),
-- Ch 5 (Alcohols), Ch 6 (Aldehydes and Ketones I), and Ch 7 (Enolates) retained for spaced-
-- repetition reinforcement with carboxylic-acid-specific framing.
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Carboxylic Acids',
            'Organic Chemistry Chapter 8: Carboxylic Acids',
            'Orgo Chapter 8: Carboxylic Acids'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Carboxylic Acids',
        'Organic Chemistry Chapter 8: Carboxylic Acids',
        'Orgo Chapter 8: Carboxylic Acids'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'organic_chemistry',
        'Organic Chemistry',
        'carboxylic acids',
        'Carboxylic Acids',
        'Carboxylic acid structure (-COOH = carbonyl + hydroxyl on the same carbon, always terminal) and nomenclature (-oic acid, -carboxylic acid for ring-attached, -dioic acid for dicarboxylic, -oate for salts and esters); physical properties driven by exceptional hydrogen bonding (dimers via two H-bonds, BP exceeding the corresponding alcohols); acidity from carboxylate resonance plus electron-withdrawing carbonyl, with EWG vs EDG substituent effects, the proximity rule, the dicarboxylic > monocarboxylic > deprotonated-monocarboxylate ordering, and the extreme α-H acidity of β-dicarboxylic acids; synthesis from oxidation of primary alcohols and aldehydes; nucleophilic acyl substitution as the master mechanism for all derivative formations (carboxylic acid, ester, amide, anhydride, acyl halide); amides via reaction with ammonia or amines, IUPAC -amide / N- naming, lactams as cyclic amides, and the resonance stabilization that gives the C-N bond partial double-bond character; Fischer esterification with acid catalysis, ester naming, and lactones as cyclic esters; anhydrides from condensation of two carboxylic acids; LiAlH₄ reduction of carboxylic acids all the way to primary alcohols (NaBH₄ cannot); decarboxylation requiring β-keto or β-dicarboxylic positioning and proceeding through a six-membered cyclic transition state; and saponification of fatty acids by NaOH/KOH to form soap, amphipathic soap structure (polar carboxylate head + nonpolar tail), and self-assembly into micelles that dissolve grease in their hydrophobic interior.',
        8
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 8.1 Description and Properties (cards 1–10)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'A {{c1::carboxylic acid (–COOH)}} contains a {{c2::carbonyl group and a hydroxyl group on the same carbon}}; it is always a {{c3::terminal}} functional group.',
        3),
    (deck, 1, 'cloze',
        'IUPAC carboxylic acid suffixes: {{c1::-oic acid}} for linear, {{c1::-carboxylic acid}} for the group attached to a ring, and {{c1::-dioic acid}} for dicarboxylic acids.',
        1),
    (deck, 2, 'cloze',
        'Salts of carboxylic acids are named with the {{c1::cation first}}, followed by the acid name with {{c2::-oate}} replacing -oic acid.',
        2),
    (deck, 3, 'cloze',
        'Carboxylic acids are excellent hydrogen bonders because {{c1::both the hydroxyl OH and the carbonyl oxygen}} can participate — the molecule is both a strong H-bond {{c2::donor and acceptor}}.',
        2),
    (deck, 4, 'cloze',
        'Carboxylic acids commonly form {{c1::dimers}} (two molecules joined by {{c2::two hydrogen bonds}}); these multiple H-bonds give them {{c3::higher boiling points than the corresponding alcohols}}.',
        3),
    (deck, 5, 'cloze',
        'Carboxylic acids are unusually acidic because the {{c1::carboxylate conjugate base}} delocalizes the negative charge across {{c2::both oxygen atoms}} via resonance, and the electron-withdrawing carbonyl further {{c3::stabilizes that negative charge}}.',
        3),
    (deck, 6, 'cloze',
        '{{c1::Electron-withdrawing groups}} (–NO₂, halides) {{c2::increase}} acidity by {{c3::stabilizing}} the carboxylate; {{c1::electron-donating groups}} (–NH₂, –OCH₃) {{c2::decrease}} acidity by {{c3::destabilizing}} it.',
        3),
    (deck, 7, 'cloze',
        'For substituent effects on acidity, {{c1::the closer the substituent}} is to the carboxyl group, the {{c2::greater the effect}} on acidity — the influence falls off rapidly with distance.',
        2),
    (deck, 8, 'cloze',
        '{{c1::Dicarboxylic acids}} are more acidic than analogous monocarboxylic acids because each carboxyl group {{c2::electron-withdraws}} on the other; once the first proton leaves, the remaining acid is {{c3::less acidic}} (the carboxylate destabilizes a second negative charge).',
        3),
    (deck, 9, 'cloze',
        'In {{c1::β-dicarboxylic acids}}, the α-hydrogens between the two carboxyls are {{c2::extremely acidic}} because the resulting carbanion is stabilized by {{c3::both carboxyl groups'' electron-withdrawing effect}}.',
        3);

    -- ============================================================
    -- 8.2 Reactions of Carboxylic Acids (cards 11–26)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
        'Carboxylic acids can be synthesized by {{c1::oxidation}} of {{c2::primary alcohols or aldehydes}} using strong oxidizers like {{c3::Na₂Cr₂O₇, CrO₃, or KMnO₄}}.',
        3),
    (deck, 11, 'cloze',
        'In {{c1::nucleophilic acyl substitution}}, a nucleophile attacks the {{c2::carbonyl carbon}} to form a {{c3::tetrahedral intermediate}}; the carbonyl then reforms, kicking off the leaving group.',
        3),
    (deck, 12, 'cloze',
        'The carboxylic acid derivatives all share a carbonyl with a leaving group attached: {{c1::carboxylic acid}}, {{c1::ester}}, {{c1::amide}}, {{c1::anhydride}}, and {{c1::acyl halide}}.',
        1),
    (deck, 13, 'cloze',
        'Amides form when a carboxylic acid reacts with {{c1::ammonia or an amine}} via nucleophilic acyl substitution; the reaction proceeds in either {{c2::acidic or basic}} conditions.',
        2),
    (deck, 14, 'cloze',
        'Amides take the suffix {{c1::-amide}} (replacing -oic acid); alkyl groups on the nitrogen are listed with the prefix {{c2::N-}}. Cyclic amides are called {{c3::lactams}}.',
        3),
    (deck, 15, 'cloze',
        'Amides are stabilized by resonance — the nitrogen lone pair donates into the carbonyl, delocalizing electrons between {{c1::nitrogen and oxygen}}; this gives the C–N bond {{c2::partial double-bond character}} and restricts rotation.',
        2),
    (deck, 16, 'cloze',
        '{{c1::Fischer esterification}} couples a carboxylic acid with an alcohol under {{c2::acid catalysis}} to give an ester plus water — a {{c3::condensation reaction}}.',
        3),
    (deck, 17, 'cloze',
        'The acid catalyst in Fischer esterification protonates the {{c1::carbonyl oxygen}}, which places an additional {{c2::positive charge on the carbonyl carbon}} and increases its susceptibility to {{c3::nucleophilic attack}} by the alcohol.',
        3),
    (deck, 18, 'cloze',
        'Esters are named with the {{c1::alkyl group from the alcohol first}}, then the acid name with {{c2::-oate}} replacing -oic acid. Cyclic esters are called {{c3::lactones}}.',
        3),
    (deck, 19, 'cloze',
        '{{c1::Anhydrides}} (R–CO–O–CO–R) are formed by the {{c2::condensation of two carboxylic acids}} with loss of {{c3::a water molecule}}.',
        3),
    (deck, 20, 'cloze',
        '{{c1::LiAlH₄}} reduces a carboxylic acid all the way to a {{c2::primary alcohol}} (via an aldehyde intermediate that is also reduced); {{c3::NaBH₄}} cannot reduce carboxylic acids.',
        3),
    (deck, 21, 'cloze',
        '{{c1::Decarboxylation}} is the loss of the carboxyl group as {{c2::CO₂}}, replacing it with a hydrogen — common when a carboxylic acid is heated.',
        2),
    (deck, 22, 'cloze',
        'Decarboxylation occurs readily only when the carboxyl is {{c1::β to another carbonyl}} ({{c2::β-keto acids or β-dicarboxylic acids}}); the reaction proceeds through a {{c3::six-membered cyclic transition state}}.',
        3),
    (deck, 23, 'cloze',
        '{{c1::Saponification}} is the reaction of a {{c2::long-chain fatty acid with NaOH or KOH}} to form a {{c3::soap}} (the carboxylate salt of the fatty acid).',
        3),
    (deck, 24, 'cloze',
        'Soap molecules are {{c1::amphipathic}}: they have a {{c2::polar carboxylate head}} (hydrophilic) and a {{c3::nonpolar hydrocarbon tail}} (hydrophobic).',
        3),
    (deck, 25, 'cloze',
        'In water, soaps self-assemble into {{c1::micelles}} — spherical structures with {{c2::polar heads facing outward}} and {{c3::nonpolar tails facing inward}}, dissolving grease in the hydrophobic interior.',
        3);

    RAISE NOTICE 'Seeded deck % with 26 cards.', deck;
END $$;
