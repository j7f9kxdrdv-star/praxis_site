-- Praxis Prep — Organic Chemistry Chapter 4: Analyzing Organic Reactions
-- v6-compliant flashcard deck (37 cards)
-- Subtopics: 4.1 Acids and Bases (9), 4.2 Nucleophiles/Electrophiles/Leaving Groups (8),
-- 4.3 Nucleophilic Substitution SN1 vs SN2 (8), 4.4 Oxidation-Reduction (6),
-- 4.5 Chemoselectivity, Steric Protection, and Problem-Solving (6) — high-yield.
-- Source-laundered against LibreTexts Organic Chemistry (acid-base, SN1/SN2 mechanisms,
-- carbon redox, protecting groups), OpenStax Chemistry: Atoms First 2e, and AAMC content
-- outline (CP 5E acid-base equilibria, CP 5C stereochemistry, CP 4D reactivity).
-- Per user direction, all crossover cards with General Chemistry decks (Acids and Bases,
-- Oxidation-Reduction Reactions) are retained with organic-specific framing.
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Analyzing Organic Reactions',
            'Organic Chemistry Chapter 4: Analyzing Organic Reactions',
            'Orgo Chapter 4: Analyzing Organic Reactions'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Analyzing Organic Reactions',
        'Organic Chemistry Chapter 4: Analyzing Organic Reactions',
        'Orgo Chapter 4: Analyzing Organic Reactions'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'organic_chemistry',
        'Organic Chemistry',
        'analyzing organic reactions',
        'Analyzing Organic Reactions',
        'Acids and bases (Lewis vs Brønsted-Lowry, coordinate covalent bonds, amphoteric water, Ka and pKa, strong vs weak acid ranges, alpha hydrogen acidity via enolate resonance, common acidic and basic functional groups); nucleophiles, electrophiles, and leaving groups (nucleophilicity as kinetic vs basicity as thermodynamic, four nucleophilicity factors, protic vs aprotic halide ordering, electrophile strength, heterolysis, weak-base leaving groups); nucleophilic substitution mechanisms — SN1 (two-step, rate-limiting carbocation formation, first-order kinetics, racemic product, prefers 3° > 2° > 1°) vs SN2 (concerted backside attack, second-order kinetics, Walden inversion, prefers methyl > 1° > 2°); oxidation-reduction in organic (oxidation state framework, OIL RIG, CH₄ to CO₂ extremes, carbon oxidation series alkyl < alcohol < aldehyde/ketone < carboxylic acid, common oxidizing and reducing agent lists); and chemoselectivity, steric protection, and the 6-step problem-solving framework (most-oxidized-functional-group reacts first, carbonyl reactivity ranking, aldehyde > ketone via steric reasoning, protecting groups, stereospecificity vs stereoselectivity).',
        4
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 4.1 Acids and Bases (cards 1–9)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'A {{c1::Lewis acid}} {{c2::accepts}} an electron pair (acts as an {{c3::electrophile}}); a {{c1::Lewis base}} {{c2::donates}} an electron pair (acts as a {{c3::nucleophile}}).',
        3),
    (deck, 1, 'cloze',
        'A {{c1::coordinate covalent bond}} is a covalent bond in which {{c2::both bonding electrons came from the same atom}} — typically formed when a Lewis acid and Lewis base interact.',
        2),
    (deck, 2, 'cloze',
        'A {{c1::Brønsted-Lowry acid}} {{c2::donates a proton (H⁺)}}; a {{c1::Brønsted-Lowry base}} {{c2::accepts a proton}}.',
        2),
    (deck, 3, 'cloze',
        '{{c1::Amphoteric}} species act as either acid or base depending on environment; {{c2::water}} gives up H⁺ to become {{c3::OH⁻}} (conjugate base) or accepts H⁺ to become {{c4::H₃O⁺}} (conjugate acid).',
        4),
    (deck, 4, 'cloze',
        'The {{c1::acid dissociation constant (Ka)}} = {{c2::[H⁺][A⁻] / [HA]}}; {{c3::pKa = −log(Ka)}}, and a {{c4::lower pKa}} means a stronger acid.',
        4),
    (deck, 5, 'cloze',
        'Strong acids typically have {{c1::pKa < −2}} (they almost completely dissociate in water); weak organic acids typically have {{c2::pKa between −2 and 20}}.',
        2),
    (deck, 6, 'cloze',
        '{{c1::α-hydrogens}} (on the carbon adjacent to a carbonyl) are unusually acidic because their conjugate base (the {{c2::enolate}}) is stabilized by {{c3::resonance}} delocalization onto the carbonyl oxygen.',
        3),
    (deck, 7, 'cloze',
        'Functional groups that readily act as acids: {{c1::alcohols}}, {{c1::aldehydes and ketones (via α-H)}}, {{c1::carboxylic acids}}, and most {{c1::carboxylic acid derivatives}}.',
        1),
    (deck, 8, 'cloze',
        'The main functional groups acting as bases are {{c1::amines}} and {{c1::amides}}, because the {{c2::nitrogen lone pair}} can donate to a Lewis acid.',
        2);

    -- ============================================================
    -- 4.2 Nucleophiles, Electrophiles, and Leaving Groups (cards 10–17)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
        'A {{c1::nucleophile}} ("nucleus-loving") carries {{c2::lone pairs or π bonds}} that form new bonds to electrophiles; nucleophiles are often {{c3::negatively charged}} or carry partial negative charge.',
        3),
    (deck, 10, 'cloze',
        '{{c1::Nucleophilicity}} is a {{c2::kinetic}} property (rate of reaction with an electrophile); {{c1::basicity}} is a {{c2::thermodynamic}} property (equilibrium position). For the same attacking atom, more basic usually means more nucleophilic.',
        2),
    (deck, 11, 'cloze',
        'Four factors govern nucleophilicity: {{c1::charge (more negative = more nucleophilic)}}, {{c1::electronegativity (lower = more nucleophilic)}}, {{c1::steric hindrance (bulkier = less nucleophilic)}}, and {{c1::solvent type (protic vs aprotic)}}.',
        1),
    (deck, 12, 'cloze',
        'In {{c1::polar protic}} solvents, halide nucleophilicity is {{c2::I⁻ > Br⁻ > Cl⁻ > F⁻}} (bigger halides shed solvation faster); in {{c1::polar aprotic}} solvents it reverses to {{c2::F⁻ > Cl⁻ > Br⁻ > I⁻}} (no H-bond cage, so basicity wins).',
        2),
    (deck, 13, 'cloze',
        'An {{c1::electrophile}} ("electron-loving") is {{c2::positively charged or positively polarized}} and accepts an electron pair when forming a bond; electrophiles essentially always act as {{c3::Lewis acids}}.',
        3),
    (deck, 14, 'cloze',
        'Greater positive charge means greater electrophilicity — for example, a {{c1::carbocation}} is more electrophilic than a {{c2::carbonyl carbon}}.',
        2),
    (deck, 15, 'cloze',
        '{{c1::Heterolysis}} is bond cleavage in which {{c2::both bonding electrons}} go to one atom; the {{c3::leaving group}} is the fragment that retains those electrons after departure.',
        3),
    (deck, 16, 'cloze',
        'The best leaving groups are {{c1::weak bases}} (the conjugate bases of {{c2::strong acids}}) because they stabilize the extra electrons — typical examples include {{c3::halides (Cl⁻, Br⁻, I⁻) and water}}.',
        3);

    -- ============================================================
    -- 4.3 Nucleophilic Substitution: SN1 vs SN2 (cards 18–25)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 17, 'cloze',
        '{{c1::SN1}} (unimolecular nucleophilic substitution) is a {{c2::two-step}} reaction: Step 1 ({{c3::rate-limiting}}) — leaving group departs to form a {{c4::carbocation}}; Step 2 — nucleophile attacks the carbocation.',
        4),
    (deck, 18, 'cloze',
        'Because SN1''s rate-limiting step involves only the substrate, the rate depends only on {{c1::[substrate]}} — making SN1 a {{c2::first-order}} reaction overall.',
        2),
    (deck, 19, 'cloze',
        'The SN1 carbocation intermediate is {{c1::planar (sp²)}}, so the nucleophile can attack from either face — the product is typically a {{c2::racemic mixture}}.',
        2),
    (deck, 20, 'cloze',
        'SN1 strongly prefers {{c1::more substituted}} carbons ({{c2::3° > 2° > 1°}}) because {{c3::alkyl groups stabilize the carbocation}} via inductive electron donation.',
        3),
    (deck, 21, 'cloze',
        '{{c1::SN2}} (bimolecular nucleophilic substitution) is a {{c2::concerted single-step}} reaction — the nucleophile {{c3::attacks from the back side}} as the leaving group departs.',
        3),
    (deck, 22, 'cloze',
        'SN2''s single step involves both substrate and nucleophile, so the rate depends on {{c1::[substrate] × [nucleophile]}} — making SN2 a {{c2::second-order}} reaction overall.',
        2),
    (deck, 23, 'cloze',
        'SN2''s backside attack inverts the stereochemistry at the reactive carbon (a {{c1::Walden inversion}}); if leaving-group and nucleophile priorities match, this also flips {{c2::R ↔ S}}.',
        2),
    (deck, 24, 'cloze',
        'SN2 prefers {{c1::less substituted}} carbons ({{c2::methyl > 1° > 2°}}; 3° essentially won''t react) because the backside is blocked by {{c3::steric hindrance}} on substituted substrates.',
        3);

    -- ============================================================
    -- 4.4 Oxidation-Reduction in Organic (cards 26–31)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 25, 'cloze',
        '{{c1::Oxidation state}} is the hypothetical charge an atom would carry if all bonds were {{c2::fully ionic}}; remember {{c3::OIL RIG}} — Oxidation Is Loss of electrons, Reduction Is Gain.',
        3),
    (deck, 26, 'cloze',
        'For carbon, {{c1::CH₄ (methane)}} is the most {{c2::reduced}} form; {{c1::CO₂ (carbon dioxide)}} is the most {{c2::oxidized}}.',
        2),
    (deck, 27, 'cloze',
        'Functional groups ordered by increasing carbon oxidation state: {{c1::alkyl}} < {{c1::alcohol}} < {{c1::aldehyde / ketone}} < {{c1::carboxylic acid}} — each step adds bonds to oxygen or removes bonds to hydrogen.',
        1),
    (deck, 28, 'cloze',
        'For carbon: {{c1::oxidation}} replaces a bond to a less electronegative atom with one to a more electronegative atom (more C–O); {{c1::reduction}} does the reverse (more C–H).',
        1),
    (deck, 29, 'cloze',
        'Common organic oxidizing agents: {{c1::PCC (pyridinium chlorochromate)}}, {{c1::CrO₃}}, {{c1::Na₂Cr₂O₇}}, {{c1::KMnO₄}}, and {{c1::O₂}}.',
        1),
    (deck, 30, 'cloze',
        'Common organic reducing agents: {{c1::LiAlH₄ (strong)}}, {{c1::NaBH₄ (mild, aldehydes/ketones only)}}, {{c1::CaH₂}}, and {{c1::NaH}}.',
        1);

    -- ============================================================
    -- 4.5 Chemoselectivity, Steric Protection, Problem-Solving (cards 32–37) ★
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 31, 'cloze',
        '{{c1::Chemoselectivity}} is the preferential reaction of one functional group when others are present; the {{c2::most oxidized functional group}} usually reacts first because it contains the most {{c3::electrophilic carbon}}.',
        3),
    (deck, 32, 'cloze',
        'Reactivity ranking toward nucleophiles: {{c1::carboxylic acids and derivatives}} > {{c2::aldehydes}} > {{c3::ketones}} > {{c4::alcohols / amines}}.',
        4),
    (deck, 33, 'cloze',
        '{{c1::Aldehydes}} are more reactive toward nucleophiles than {{c2::ketones}} because they have less {{c3::steric hindrance}} at the carbonyl carbon (one alkyl group instead of two).',
        3),
    (deck, 34, 'cloze',
        'A {{c1::protecting group}} is a bulky group temporarily attached to a reactive functional group to {{c2::prevent unwanted reactions}} during synthesis — e.g., {{c3::diols or tert-butyl ethers}} can protect aldehydes and ketones.',
        3),
    (deck, 35, 'cloze',
        'Six steps to analyze an organic reaction: (1) {{c1::know your nomenclature}}, (2) {{c1::identify functional groups}}, (3) {{c1::identify other reagents}}, (4) {{c1::identify the most reactive functional groups}}, (5) {{c1::identify the first step}}, (6) {{c1::consider stereospecificity / selectivity}}.',
        1),
    (deck, 36, 'cloze',
        '{{c1::Stereospecificity}} — the starting stereochemistry dictates the product stereochemistry by mechanism (e.g., SN2 inversion); {{c1::stereoselectivity}} — one stereoisomer forms preferentially due to product stability or strain differences.',
        1);

    RAISE NOTICE 'Seeded deck % with 37 cards.', deck;
END $$;
