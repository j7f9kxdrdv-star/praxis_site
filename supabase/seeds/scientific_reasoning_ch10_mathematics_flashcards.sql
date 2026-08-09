-- Praxis Prep — Scientific Reasoning Chapter 10: Mathematics
-- v6-compliant flashcard deck (34 cards)
-- Subtopics: 10.1 Arithmetic and Significant Figures (7), 10.2 Exponents and Logarithms (12),
-- 10.3 Trigonometry (7), 10.4 Problem Solving (8).
-- Source-laundered against OpenStax College Algebra (exponent and logarithm laws),
-- OpenStax Algebra and Trigonometry (right-triangle trig, special angles),
-- OpenStax College Physics 2e (sig fig conventions, SI prefixes, temperature scales),
-- and AAMC SIRS framework (math fluency underlies all four science sections).
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Mathematics',
            'Math Review Chapter 1: Mathematics',
            'Physics Chapter 10: Mathematics',
            'Scientific Reasoning Chapter 10: Mathematics'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Mathematics',
        'Math Review Chapter 1: Mathematics',
        'Physics Chapter 10: Mathematics',
        'Scientific Reasoning Chapter 10: Mathematics'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'scientific_reasoning',
        'Scientific Reasoning',
        'mathematics',
        'Mathematics',
        'Arithmetic and significant figures (scientific notation, sig fig counting and arithmetic rules, calculator-free estimation strategy); exponents and logarithms (all 7 exponent rules, square root shortcuts, all 6 log rules, common vs natural log); trigonometry (SOH CAH TOA, tan = sin/cos identity, inverse trig, special angles 30/45/60 and boundary angles 0/90/180); and problem solving (direct vs inverse relationships, all 12 SI prefixes, Fahrenheit/Celsius/Kelvin conversions, substitution / setting-equal / elimination methods for systems of equations).',
        10
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 10.1 Arithmetic and Significant Figures (cards 1–7)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        '{{c1::Scientific notation}} writes a number as a {{c2::significand × a power of 10}} (e.g., 6.02 × 10²³); it makes very large or very small numbers easy to read and to operate on.',
        2),
    (deck, 1, 'cloze',
        'To count significant figures, count every digit between the {{c1::first nonzero digit on the left}} and the {{c1::last nonzero digit on the right}} — any zero between them counts.',
        1),
    (deck, 2, 'cloze',
        '{{c1::Leading zeros}} (those left of the first nonzero digit) are {{c2::never significant}}.',
        2),
    (deck, 3, 'cloze',
        '{{c1::Trailing zeros}} (right of the last nonzero digit) are significant {{c2::only if a decimal point is present}}; without one, they are not.',
        2),
    (deck, 4, 'cloze',
        'For {{c1::multiplication and division}}, the result keeps the {{c2::fewest significant figures}} of any input value.',
        2),
    (deck, 5, 'cloze',
        'For {{c1::addition and subtraction}}, the result keeps the {{c2::fewest decimal places}} of any input value.',
        2),
    (deck, 6, 'cloze',
        'Calculator-free estimation: when multiplying, if you round one factor {{c1::up}}, round the other {{c2::down}} to compensate; when dividing, round both numerator and denominator in the {{c3::same direction}}.',
        3);

    -- ============================================================
    -- 10.2 Exponents and Logarithms (cards 8–19)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
        'Any nonzero number raised to the zeroth power equals {{c1::1}}: X⁰ = 1.',
        1),
    (deck, 8, 'cloze',
        'Multiplying powers with the same base: {{c1::add}} the exponents — Xᴬ · Xᴮ = {{c2::Xᴬ⁺ᴮ}}.',
        2),
    (deck, 9, 'cloze',
        'Dividing powers with the same base: {{c1::subtract}} the exponents — Xᴬ / Xᴮ = {{c2::Xᴬ⁻ᴮ}}.',
        2),
    (deck, 10, 'cloze',
        'A power raised to a power: {{c1::multiply}} the exponents — (Xᴬ)ᴮ = {{c2::Xᴬᴮ}}.',
        2),
    (deck, 11, 'cloze',
        'When a fraction is raised to an exponent, the exponent is {{c1::distributed to both numerator and denominator}} — (X/Y)ᴬ = Xᴬ / Yᴬ.',
        1),
    (deck, 12, 'cloze',
        'A {{c1::negative exponent}} represents the {{c2::reciprocal}}: X⁻ᴬ = {{c3::1 / Xᴬ}}.',
        3),
    (deck, 13, 'cloze',
        'A {{c1::fractional exponent}} A/B means the {{c2::B-th root}} of Xᴬ: X to the power A/B = ᴮ√(Xᴬ).',
        2),
    (deck, 14, 'cloze',
        'MCAT square-root shortcuts: √2 ≈ {{c1::1.4}} and √3 ≈ {{c2::1.7}}; for an arbitrary √N, divide N by a {{c3::known perfect square}} to simplify before estimating.',
        3),
    (deck, 15, 'cloze',
        'Two log identities to memorize: logₐ(1) = {{c1::0}} (because a⁰ = 1) and logₐ(a) = {{c2::1}} (because a¹ = a).',
        2),
    (deck, 16, 'cloze',
        'Log of a {{c1::product}} equals the sum of logs: log(A · B) = {{c2::log A + log B}}; log of a {{c1::quotient}} equals the difference of logs: log(A / B) = {{c2::log A − log B}}.',
        2),
    (deck, 17, 'cloze',
        'Log of a {{c1::power}}: log(Aᴮ) = {{c2::B · log A}}; log of a {{c1::reciprocal}}: log(1 / A) = {{c2::−log A}}.',
        2),
    (deck, 18, 'cloze',
        'The {{c1::common logarithm}} uses base {{c2::10}}; the {{c1::natural logarithm (ln)}} uses base {{c2::e ≈ 2.718}} (Euler''s number).',
        2);

    -- ============================================================
    -- 10.3 Trigonometry (cards 20–26)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 19, 'cloze',
        'SOH CAH TOA — sin θ = {{c1::opposite}} / {{c2::hypotenuse}}; cos θ = {{c1::adjacent}} / {{c2::hypotenuse}}; tan θ = {{c1::opposite}} / {{c2::adjacent}}.',
        2),
    (deck, 20, 'cloze',
        'A universally useful trig identity: tan θ = {{c1::sin θ / cos θ}}.',
        1),
    (deck, 21, 'cloze',
        '{{c1::Inverse trig}} functions (sin⁻¹, cos⁻¹, tan⁻¹) take a {{c2::ratio}} as input and return {{c3::the angle}} that produces it.',
        3),
    (deck, 22, 'cloze',
        'At θ = 30°: sin = {{c1::1/2}}, cos = {{c2::√3/2}}, tan = {{c3::√3/3}}.',
        3),
    (deck, 23, 'cloze',
        'At θ = 45°: sin = cos = {{c1::√2/2}}, and tan = {{c2::1}}.',
        2),
    (deck, 24, 'cloze',
        'At θ = 60°: sin = {{c1::√3/2 (≈ 0.87)}}, cos = {{c2::1/2 (= 0.5)}}, tan = {{c3::√3 (≈ 1.7)}}.',
        3),
    (deck, 25, 'cloze',
        'Boundary angles — at 0°, (sin, cos, tan) = {{c1::(0, 1, 0)}}; at 90°, = {{c2::(1, 0, undefined)}}; at 180°, = {{c3::(0, −1, 0)}}.',
        3);

    -- ============================================================
    -- 10.4 Problem Solving (cards 27–34)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
        'A {{c1::direct relationship}} means both variables change in the {{c2::same direction}} (one up, the other up); an {{c1::inverse relationship}} means they change in {{c2::opposite directions}} (one up, the other down).',
        2),
    (deck, 27, 'cloze',
        'SI prefixes (positive powers): 10¹² = {{c1::tera (T)}}, 10⁹ = {{c1::giga (G)}}, 10⁶ = {{c1::mega (M)}}, 10³ = {{c1::kilo (k)}}, 10² = {{c1::hecto (h)}}, 10¹ = {{c1::deka (da)}}.',
        1),
    (deck, 28, 'cloze',
        'SI prefixes (negative powers): 10⁻¹ = {{c1::deci (d)}}, 10⁻² = {{c1::centi (c)}}, 10⁻³ = {{c1::milli (m)}}, 10⁻⁶ = {{c1::micro (μ)}}, 10⁻⁹ = {{c1::nano (n)}}, 10⁻¹² = {{c1::pico (p)}}.',
        1),
    (deck, 29, 'cloze',
        'Fahrenheit ↔ Celsius: F = {{c1::(9/5) C + 32}}, equivalently C = {{c2::(5/9)(F − 32)}}; anchor: 0 °C = 32 °F.',
        2),
    (deck, 30, 'cloze',
        'Celsius ↔ Kelvin: K = {{c1::C + 273}}; anchor: 0 °C = 273 K (the size of one degree is the same on both scales).',
        1),
    (deck, 31, 'cloze',
        'Substitution method — solve one equation for one variable, then {{c1::insert that expression into the other equation}} to reduce the system to a single-variable problem.',
        1),
    (deck, 32, 'cloze',
        'Setting-equations-equal method — a special case of substitution: solve {{c1::both equations for the same variable}}, then set the two expressions equal to each other.',
        1),
    (deck, 33, 'cloze',
        'Elimination method — multiply one or both equations so a variable has the {{c1::same coefficient}} in both, then {{c2::add or subtract}} the equations to eliminate that variable.',
        2);

    RAISE NOTICE 'Seeded deck % with 34 cards.', deck;
END $$;
