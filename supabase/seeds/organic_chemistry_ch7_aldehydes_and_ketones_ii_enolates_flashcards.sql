-- Praxis Prep — Organic Chemistry Chapter 7: Aldehydes and Ketones II — Enolates
-- v6-compliant flashcard deck (21 cards)
-- Subtopics: 7.1 General Principles (5), 7.2 Enolate Chemistry (10),
-- 7.3 Aldol Condensation (6).
-- Source-laundered against LibreTexts Organic Chemistry (Enolates, Aldol Condensation,
-- Michael Addition chapters), OpenStax Chemistry: Atoms First 2e, and AAMC content
-- outline (CP 4D reactivity, CP 5C stereochemistry).
-- Per user direction, all crossover cards with OrgChem Ch 4 (Analyzing Organic Reactions)
-- and Ch 6 (Aldehydes and Ketones I) retained for spaced-repetition reinforcement
-- with enolate-mechanism-specific framing.
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Aldehydes and Ketones II: Enolates',
            'Organic Chemistry Chapter 7: Aldehydes and Ketones II',
            'Orgo Chapter 7: Aldehydes and Ketones II'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Aldehydes and Ketones II: Enolates',
        'Organic Chemistry Chapter 7: Aldehydes and Ketones II',
        'Orgo Chapter 7: Aldehydes and Ketones II'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'organic_chemistry',
        'Organic Chemistry',
        'aldehydes and ketones ii',
        'Aldehydes and Ketones II: Enolates',
        'α-carbons and α-hydrogens; why α-H is unusually acidic (electron-withdrawing carbonyl + resonance-stabilized enolate); aldehyde α-H more acidic than ketone α-H (EDG alkyl destabilizes enolate); steric and electronic reasons aldehydes are more reactive than ketones; keto-enol tautomers and the keto-favored equilibrium; acid/base-catalyzed tautomerization; α-racemization of chiral α-carbons; enolate formation by strong base (OH⁻, LDA, KH); enolate as a better nucleophile than the neutral enol; Michael addition (1,4-conjugate addition to α,β-unsaturated carbonyl); kinetic enolate (less substituted, low T, LDA, strong bulky bases) vs thermodynamic enolate (more substituted, higher T, weaker reversible bases); enamines from secondary amines as the nitrogen analog of enols and tautomers of imines; aldol addition forming a β-hydroxy carbonyl via enolate attacking a second carbonyl; dehydration step under strong base + heat to form α,β-unsaturated carbonyl (aldol condensation = condensation + dehydration vocabulary); the single-substrate constraint to avoid product mixtures; and retro-aldol reaction (reverse of aldol condensation, aqueous base + heat, cleaves the C-C bond between α- and β-carbons).',
        7
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 7.1 General Principles (cards 1–5)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'The {{c1::α-carbon}} is the carbon directly {{c2::adjacent to the carbonyl carbon}}, and any hydrogens attached to it are called {{c3::α-hydrogens}}.',
        3),
    (deck, 1, 'cloze',
        'α-hydrogens are unusually acidic because the {{c1::electron-withdrawing carbonyl}} weakens the C–H bond and {{c2::resonance stabilizes the conjugate base (enolate)}}.',
        2),
    (deck, 2, 'cloze',
        'The {{c1::enolate}} conjugate base is stabilized by resonance — the negative charge can sit on the {{c2::α-carbon (carbanion form)}} or, more stably, on the {{c3::carbonyl oxygen (enolate form)}}.',
        3),
    (deck, 3, 'cloze',
        'α-hydrogens of {{c1::ketones}} are slightly less acidic than those of {{c2::aldehydes}} because the additional {{c3::electron-donating alkyl group}} destabilizes the enolate anion.',
        3),
    (deck, 4, 'cloze',
        'Ketones are also less reactive toward nucleophiles than aldehydes for two reasons: {{c1::greater steric hindrance}} at the carbonyl carbon and {{c2::EDG-driven destabilization of the developing partial positive charge}} in the transition state.',
        2);

    -- ============================================================
    -- 7.2 Enolate Chemistry (cards 6–15)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 5, 'cloze',
        '{{c1::Tautomers}} are isomers that differ in the placement of a {{c2::proton}} and a {{c3::double bond}} — the keto and enol forms of a carbonyl are the canonical example.',
        3),
    (deck, 6, 'cloze',
        'The {{c1::keto form}} (C=O) is much more stable than the {{c2::enol form}} (C=C–OH, a vinyl alcohol); the equilibrium lies {{c3::far to the keto side}}.',
        3),
    (deck, 7, 'cloze',
        '{{c1::Tautomerization (enolization)}} interconverts the keto and enol forms and is catalyzed by either {{c2::acid or base}}.',
        2),
    (deck, 8, 'cloze',
        'Any aldehyde or ketone with a {{c1::chiral α-carbon}} will rapidly become a {{c2::racemic mixture}} as the keto and enol forms interconvert — a phenomenon called {{c3::α-racemization}}.',
        3),
    (deck, 9, 'cloze',
        'Treating a carbonyl with a {{c1::strong base}} removes an α-hydrogen and produces an {{c2::enolate anion}}, which is a much better nucleophile than the neutral enol because it carries a {{c3::full negative charge}}.',
        3),
    (deck, 10, 'cloze',
        'Common strong bases used to form enolates: {{c1::hydroxide (OH⁻)}}, {{c1::lithium diisopropylamide (LDA)}}, and {{c1::potassium hydride (KH)}}.',
        1),
    (deck, 11, 'cloze',
        'In a {{c1::Michael addition}}, an enolate attacks an {{c2::α,β-unsaturated carbonyl}} — a {{c3::1,4-conjugate addition}} driven by resonance stabilization of the intermediate.',
        3),
    (deck, 12, 'cloze',
        'When a ketone has two different α-carbons, deprotonation can give either the {{c1::kinetic enolate}} (less substituted α-C, less stable but forms faster) or the {{c2::thermodynamic enolate}} (more substituted α-C, more stable but forms slower).',
        2),
    (deck, 13, 'cloze',
        'The {{c1::kinetic enolate}} is favored at {{c2::low temperatures}} with {{c3::strong, sterically hindered bases (LDA)}}; the {{c1::thermodynamic enolate}} is favored at {{c2::higher temperatures}} with {{c3::weaker, reversible bases}}.',
        3),
    (deck, 14, 'cloze',
        '{{c1::Enamines}} form when a {{c2::secondary amine}} reacts with an aldehyde or ketone — they are the nitrogen analogs of enols and are {{c3::tautomers of imines}} (primary amines instead give imines).',
        3);

    -- ============================================================
    -- 7.3 Aldol Condensation (cards 16–21)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
        'Aldol addition step 1: a catalytic base deprotonates an aldehyde or ketone to form an {{c1::enolate}}, which then attacks the {{c2::carbonyl carbon}} of a second aldehyde or ketone molecule, forming a new {{c3::C–C bond}}.',
        3),
    (deck, 16, 'cloze',
        'The aldol addition product is a {{c1::β-hydroxy aldehyde or ketone}} — a carbonyl with a hydroxyl group on the β-carbon.',
        1),
    (deck, 17, 'cloze',
        'Under {{c1::strong base and heat}}, the aldol product undergoes {{c2::dehydration}} via E1 or E2 — losing water to form an {{c3::α,β-unsaturated carbonyl}}. This second step makes the overall reaction an aldol *condensation*.',
        3),
    (deck, 18, 'cloze',
        'The reaction is called a {{c1::condensation}} because two molecules join with the loss of a small molecule; the same step is also called a {{c1::dehydration}} because the small molecule lost is {{c2::water (H₂O)}}.',
        2),
    (deck, 19, 'cloze',
        'Aldol condensations only give clean products when {{c1::a single type of aldehyde or ketone}} is used — with two different substrates you can''t control which acts as nucleophile vs electrophile, so {{c2::a mixture of products}} results.',
        2),
    (deck, 20, 'cloze',
        'The {{c1::retro-aldol}} reaction is the {{c2::reverse of aldol condensation}}, catalyzed by {{c3::aqueous base and heat}}; it cleaves the bond between the α- and β-carbons.',
        3);

    RAISE NOTICE 'Seeded deck % with 21 cards.', deck;
END $$;
