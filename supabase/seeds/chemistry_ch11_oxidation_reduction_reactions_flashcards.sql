-- Praxis Prep — General Chemistry Chapter 11: Oxidation-Reduction Reactions
-- v6-compliant flashcard deck (30 cards)
-- Subtopics: 11.1 Redox Fundamentals (7), 11.2 Assigning Oxidation Numbers (9),
-- 11.3 Balancing Redox Reactions (4), 11.4 Ionic Equations and Reaction Types (7),
-- 11.5 Redox Titrations (3).
-- Source-laundered against OpenStax Chemistry: Atoms First 2e (Ch. 4 stoichiometry,
-- Ch. 16 electrochemistry), LibreTexts General Chemistry, and AAMC content outline
-- (CP 4A bonding / CP 5E acid-base equilibria and electrochemistry).
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Oxidation-Reduction Reactions',
            'General Chemistry Chapter 11: Oxidation-Reduction Reactions',
            'General Chemistry Ch 11: Oxidation-Reduction Reactions',
            'General Chemistry Chapter 11 - Oxidation-Reduction Reactions',
            'Chemistry Chapter 11: Oxidation-Reduction Reactions'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'General Chemistry Chapter 11: Oxidation-Reduction Reactions',
        'General Chemistry Ch 11: Oxidation-Reduction Reactions',
        'General Chemistry Chapter 11 - Oxidation-Reduction Reactions',
        'Chemistry Chapter 11: Oxidation-Reduction Reactions'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'chemistry',
        'General Chemistry',
        'oxidation reduction reactions',
        'Oxidation-Reduction Reactions',
        'Redox fundamentals (electron transfer, OIL RIG, oxidizing and reducing agents); assigning oxidation numbers (all 8 rules); balancing redox reactions via the half-reaction (ion-electron) method in acidic and basic solution; complete vs net ionic equations and spectator ions; common reaction families (combination, decomposition, combustion, double displacement); disproportionation; redox titrations (indicator-based and potentiometric).',
        11
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 11.1 Redox Fundamentals (cards 1–7)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'A {{c1::redox (oxidation–reduction) reaction}} involves the {{c2::transfer of electrons}} from one species to another.',
        2),
    (deck, 1, 'cloze',
        'The mnemonic OIL RIG stands for {{c1::Oxidation Is Loss}} (of electrons) and {{c1::Reduction Is Gain}} (of electrons).',
        1),
    (deck, 2, 'cloze',
        'Oxidation and reduction always occur {{c1::simultaneously}} — every electron lost by one species is {{c2::gained by another}}.',
        2),
    (deck, 3, 'cloze',
        'An {{c1::oxidizing agent}} causes another species to be oxidized and is itself {{c2::reduced}}; a {{c1::reducing agent}} causes another species to be reduced and is itself {{c2::oxidized}}.',
        2),
    (deck, 4, 'cloze',
        'Common oxidizing agents to recognize: {{c1::O₂, the halogens (F₂, Cl₂, Br₂, I₂), KMnO₄, K₂Cr₂O₇ / CrO₃, H₂O₂, and concentrated H₂SO₄ or HNO₃}}.',
        1),
    (deck, 5, 'cloze',
        'Common reducing agents to recognize: {{c1::H₂, NaBH₄, LiAlH₄, active metals (Zn, Mg, Na), and the biological carriers NADH and FADH₂}}.',
        1),
    (deck, 6, 'cloze',
        '{{c1::NaBH₄}} is a mild, selective reducer (only reduces aldehydes and ketones), while {{c2::LiAlH₄}} is much stronger and also reduces {{c3::carboxylic acids, esters, and amides}}.',
        3);

    -- ============================================================
    -- 11.2 Assigning Oxidation Numbers (cards 8–16)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
        'Oxidation numbers are bookkeeping tools that track the {{c1::redistribution of electrons}} in a reaction, letting us identify which species was {{c2::oxidized versus reduced}}.',
        2),
    (deck, 8, 'cloze',
        'The oxidation number of any {{c1::free element or diatomic molecule}} (e.g., Na, O₂, P₄, S₈) is {{c2::zero}}.',
        2),
    (deck, 9, 'cloze',
        'The oxidation number of a {{c1::monatomic ion}} equals the {{c2::charge of the ion}} — Na⁺ is +1, Fe³⁺ is +3, Cl⁻ is −1.',
        2),
    (deck, 10, 'cloze',
        '{{c1::Group IA}} metals in compounds are always {{c2::+1}}; {{c1::Group IIA}} metals in compounds are always {{c2::+2}}.',
        2),
    (deck, 11, 'cloze',
        '{{c1::Group VIIA}} halogens are typically {{c2::−1}}, unless combined with a more {{c3::electronegative}} element (e.g., Cl is +1 in HOCl).',
        3),
    (deck, 12, 'cloze',
        'Hydrogen is usually {{c1::+1}}, but is {{c2::−1}} when bonded to a less electronegative element such as a metal — for example in {{c3::NaH or LiAlH₄}}.',
        3),
    (deck, 13, 'cloze',
        'Oxygen is usually {{c1::−2}}, except in {{c2::peroxides (O₂²⁻)}} where it is −1, and in {{c3::OF₂}} where it is +2 (fluorine outranks oxygen in electronegativity).',
        3),
    (deck, 14, 'cloze',
        'The sum of oxidation numbers in a {{c1::neutral compound}} equals {{c2::zero}}.',
        2),
    (deck, 15, 'cloze',
        'The sum of oxidation numbers in a {{c1::polyatomic ion}} equals the {{c2::overall charge of that ion}} — for SO₄²⁻ the sum is {{c3::−2}}.',
        3);

    -- ============================================================
    -- 11.3 Balancing Redox Reactions (cards 17–20)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 16, 'cloze',
        'The {{c1::half-reaction (ion-electron) method}} splits a redox reaction into separate {{c2::oxidation and reduction half-reactions}}, balances each one, and then recombines them.',
        2),
    (deck, 17, 'cloze',
        'Half-reaction balancing steps: balance non-H/O atoms, balance O with {{c1::H₂O}}, balance H with {{c2::H⁺}}, balance charge with {{c3::electrons (e⁻)}}, then scale and add so the electrons cancel.',
        3),
    (deck, 18, 'cloze',
        'In {{c1::acidic solution}}, balance H and O using {{c2::H₂O and H⁺}}.',
        2),
    (deck, 19, 'cloze',
        'In {{c1::basic solution}}, balance as if acidic, then {{c2::add OH⁻ to both sides to neutralize each H⁺ (forming H₂O)}}.',
        2);

    -- ============================================================
    -- 11.4 Ionic Equations and Reaction Types (cards 21–27)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
        'A {{c1::complete ionic equation}} shows every aqueous strong electrolyte broken into its {{c2::individual ions}}.',
        2),
    (deck, 21, 'cloze',
        '{{c1::Spectator ions}} appear identically on both sides of a complete ionic equation and {{c2::do not participate}} in the reaction.',
        2),
    (deck, 22, 'cloze',
        'A {{c1::net ionic equation}} keeps only the species that actually react — those forming {{c2::precipitates, gases, or weak electrolytes}} — and drops the spectator ions.',
        2),
    (deck, 23, 'cloze',
        'When writing ionic equations, {{c1::aqueous strong electrolytes}} split into ions, while {{c2::solids, liquids, gases, and weak electrolytes}} stay together as one unit.',
        2),
    (deck, 24, 'cloze',
        'Four common reaction families to recognize: {{c1::combination}}, {{c1::decomposition}}, {{c1::combustion}}, and {{c1::double displacement (metathesis)}}.',
        1),
    (deck, 25, 'cloze',
        'Double-displacement (metathesis) reactions are typically {{c1::not}} redox reactions because the ions {{c2::keep their oxidation states}} as they swap partners.',
        2),
    (deck, 26, 'cloze',
        'In a {{c1::disproportionation}} reaction, a single element is {{c2::simultaneously oxidized and reduced}} — for example, Cl₂ + 2 OH⁻ → {{c3::Cl⁻ + ClO⁻ + H₂O}}.',
        3);

    -- ============================================================
    -- 11.5 Redox Titrations (cards 28–30)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 27, 'cloze',
        'A {{c1::redox titration}} follows the transfer of {{c2::electrons (charge)}} between titrant and analyte to reach the equivalence point.',
        2),
    (deck, 28, 'cloze',
        'Redox titrations can use {{c1::indicators}} that change color at a specific {{c2::voltage (potential)}}.',
        2),
    (deck, 29, 'cloze',
        'In a {{c1::potentiometric titration}}, no indicator is used — instead a {{c2::voltmeter}} measures the {{c3::electromotive force (emf)}} of the cell as titrant is added.',
        3);

    RAISE NOTICE 'Seeded deck % with 30 cards.', deck;
END $$;
