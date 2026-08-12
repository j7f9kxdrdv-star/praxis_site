-- Praxis Prep — Scientific Reasoning Chapter 12: Data-Based and Statistical Reasoning
-- v6-compliant flashcard deck (42 cards)
-- Subtopics: 12.1 Central Tendency (5), 12.2 Distributions (6),
-- 12.3 Variability + Outliers (8), 12.4 Probability (5),
-- 12.5 Hypothesis Testing (8), 12.6 Charts/Graphs/Tables (7), 12.7 Correlation (3).
-- Source-laundered against OpenStax Introductory Statistics (Ch. 2 descriptive stats,
-- Ch. 3 probability, Ch. 6 normal distribution, Ch. 8 confidence intervals,
-- Ch. 9 hypothesis testing, Ch. 12 linear regression and correlation), OpenStax
-- Psychology 2e Ch. 2, and AAMC Scientific Inquiry and Reasoning Skills (SIRS)
-- Skill 4 (Data-Based and Statistical Reasoning).
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Data-Based and Statistical Reasoning',
            'Physics Chapter 12: Data-Based and Statistical Reasoning',
            'Scientific Reasoning Chapter 12: Data-Based and Statistical Reasoning'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Data-Based and Statistical Reasoning',
        'Physics Chapter 12: Data-Based and Statistical Reasoning',
        'Scientific Reasoning Chapter 12: Data-Based and Statistical Reasoning'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'scientific_reasoning',
        'Scientific Reasoning',
        'data based and statistical reasoning',
        'Data-Based and Statistical Reasoning',
        'Measures of central tendency (mean, median, mode); distributions (normal with the 68-95-99 rule, skewed, bimodal); measures of variability and outliers (range, IQR, standard deviation, 1.5xIQR and 3-SD outlier rules); probability (independence, mutual exclusivity, exhaustiveness, AND/OR rules, at-least-one shortcut); hypothesis testing (null vs alternative, p-value, alpha, Type I and II errors, power, confidence intervals); charts and graphs (pie, bar vs histogram, box plot anatomy, line, semi-log, log-log, slope); and correlation vs causation with the correlation coefficient r.',
        12
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 12.1 Measures of Central Tendency (cards 1–5)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        '{{c1::Measures of central tendency}} represent the middle of a data set with a {{c2::single summary value}} — mean, median, or mode.',
        2),
    (deck, 1, 'cloze',
        'The {{c1::mean (arithmetic average)}} is the sum of all values divided by {{c2::the number of values}}; it weighs every value equally and is {{c3::most affected by outliers}}.',
        3),
    (deck, 2, 'cloze',
        'The {{c1::median}} is the {{c2::midpoint}} of an ordered data set — 50% of values fall above and 50% below — and is the better choice when the data are {{c3::skewed or contain outliers}}.',
        3),
    (deck, 3, 'cloze',
        'The position of the median in an ordered data set is {{c1::(n + 1) / 2}}; if n is even, the median is the {{c2::mean of the two middle values}}.',
        2),
    (deck, 4, 'cloze',
        'The {{c1::mode}} is the value that appears {{c2::most often}}; a data set can have {{c3::multiple modes or none}}.',
        3);

    -- ============================================================
    -- 12.2 Distributions (cards 6–11)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 5, 'cloze',
        'A {{c1::normal distribution}} is symmetric and bell-shaped; the {{c2::mean, median, and mode all coincide}} at the center.',
        2),
    (deck, 6, 'cloze',
        'The 68-95-99 rule: in a normal distribution, about {{c1::68%}} of values fall within 1 SD of the mean, about {{c2::95%}} within 2 SD, and about {{c3::99%}} within 3 SD.',
        3),
    (deck, 7, 'cloze',
        'The {{c1::standard normal distribution}} is a normal distribution rescaled to have a mean of {{c2::0}} and a standard deviation of {{c3::1}}; any normal data set can be transformed to it.',
        3),
    (deck, 8, 'cloze',
        'A {{c1::skewed distribution}} has a tail on one side: {{c2::positive (right) skew}} pulls toward larger values, while {{c2::negative (left) skew}} pulls toward smaller values.',
        2),
    (deck, 9, 'cloze',
        'In a positively skewed distribution, {{c1::mean > median > mode}}; in a negatively skewed distribution, {{c1::mean < median < mode}}. The mean is always pulled toward the {{c2::tail}}.',
        2),
    (deck, 10, 'cloze',
        'A {{c1::bimodal distribution}} has {{c2::two peaks}} with a valley between them; when the peaks are well-separated, the data are often analyzed as {{c3::two separate distributions}}.',
        3);

    -- ============================================================
    -- 12.3 Measures of Variability and Outliers (cards 12–19)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 11, 'cloze',
        'The {{c1::range}} equals {{c2::maximum − minimum}}; it is {{c3::heavily affected by outliers}} because it depends only on the two extreme values.',
        3),
    (deck, 12, 'cloze',
        'As an MCAT estimation shortcut, the standard deviation is roughly {{c1::one-fourth (¼) of the range}}.',
        1),
    (deck, 13, 'cloze',
        'The {{c1::interquartile range (IQR)}} equals {{c2::Q3 − Q1}}; it captures the middle 50% of the data and is {{c3::resistant to outliers}}.',
        3),
    (deck, 14, 'cloze',
        'The {{c1::standard deviation (SD)}} measures the average spread of data points around the {{c2::mean}}; it is calculated by squaring each deviation from the mean, averaging, and taking the {{c3::square root}}.',
        3),
    (deck, 15, 'cloze',
        'Sample SD divides by {{c1::n − 1}} (not n) — known as {{c2::Bessel''s correction}} — to give an unbiased estimate of the population SD.',
        2),
    (deck, 16, 'cloze',
        'Outlier rule (IQR method): any value below {{c1::Q1 − 1.5 × IQR}} or above {{c1::Q3 + 1.5 × IQR}} is considered an outlier.',
        1),
    (deck, 17, 'cloze',
        'Outlier rule (SD method): any value more than {{c1::3 standard deviations from the mean}} is considered an outlier.',
        1),
    (deck, 18, 'cloze',
        'Outliers arise from one of three causes — {{c1::a true statistical anomaly}}, {{c1::a measurement error}}, or {{c1::a non-normal distribution}} — and the procedure for handling them must be decided {{c2::before the study begins}}.',
        2);

    -- ============================================================
    -- 12.4 Probability (cards 20–24)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 19, 'cloze',
        'Two events are {{c1::independent}} if the outcome of one {{c2::does not affect the probability}} of the other; otherwise they are {{c1::dependent}}.',
        2),
    (deck, 20, 'cloze',
        'Events are {{c1::mutually exclusive}} if they cannot occur at the same time, so P(A AND B) = {{c2::0}}.',
        2),
    (deck, 21, 'cloze',
        'A set of outcomes is {{c1::exhaustive}} if it covers {{c2::every possible outcome}} of the situation.',
        2),
    (deck, 22, 'cloze',
        'AND rule for independent events: P(A AND B) = {{c1::P(A) × P(B)}}.',
        1),
    (deck, 23, 'cloze',
        'OR rule: P(A OR B) = {{c1::P(A) + P(B) − P(A AND B)}}; for the "at least one" question, use the shortcut P(at least one) = {{c2::1 − P(none)}}.',
        2);

    -- ============================================================
    -- 12.5 Hypothesis Testing (cards 25–32)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 24, 'cloze',
        'The {{c1::null hypothesis (H₀)}} states that two populations are {{c2::equal}} (or a parameter equals a given value); it is the statement we attempt to {{c3::reject}}.',
        3),
    (deck, 25, 'cloze',
        'The {{c1::alternative hypothesis (H₁)}} can be {{c2::non-directional}} ("they are not equal") or {{c2::directional}} ("one is greater/less than the other").',
        2),
    (deck, 26, 'cloze',
        'The {{c1::p-value}} is the probability of observing the data (or something more extreme) {{c2::if the null hypothesis is true}}; a smaller p-value is {{c3::stronger evidence against the null}}.',
        3),
    (deck, 27, 'cloze',
        'Decision rule: if p < {{c1::α (significance level)}}, {{c2::reject the null}}; if p ≥ α, {{c2::fail to reject the null}}.',
        2),
    (deck, 28, 'cloze',
        'The most commonly used significance level in biomedical research is α = {{c1::0.05}}.',
        1),
    (deck, 29, 'cloze',
        'A {{c1::Type I error}} is rejecting a {{c2::true null}} — a {{c3::false positive}} — and its rate equals α.',
        3),
    (deck, 30, 'cloze',
        'A {{c1::Type II error}} is failing to reject a {{c2::false null}} — a {{c3::false negative}} — with rate β; statistical {{c1::power}} = {{c2::1 − β}}.',
        2),
    (deck, 31, 'cloze',
        'A {{c1::confidence interval}} is a range built from the sample mean ± (a z or t score) × spread; a {{c2::95% confidence level}} is standard, and a wider interval corresponds to {{c3::higher confidence}}.',
        3);

    -- ============================================================
    -- 12.6 Charts, Graphs, and Tables (cards 33–39) ★ high-yield
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
        '{{c1::Pie charts}} display {{c2::relative proportions}} of categories; they become hard to read when there are {{c3::too many categories}}.',
        3),
    (deck, 33, 'cloze',
        '{{c1::Bar charts}} display {{c2::categorical}} data, while {{c1::histograms}} display {{c2::numerical (continuous)}} data and are especially useful for showing a {{c3::distribution}}.',
        3),
    (deck, 34, 'cloze',
        'A {{c1::box plot}} shows the {{c2::median, Q1, Q3, and range}}: the box marks the central spread with a line inside, and the whiskers extend to the {{c3::extreme values within 1.5 × IQR}} (outliers plotted separately).',
        3),
    (deck, 35, 'cloze',
        'A {{c1::line graph}} shows the relationship between {{c2::two continuous variables}} and may be linear, parabolic, exponential, or logarithmic in shape.',
        2),
    (deck, 36, 'cloze',
        'Slope from a linear plot: {{c1::m = rise / run = Δy / Δx}}.',
        1),
    (deck, 37, 'cloze',
        '{{c1::Semi-log plots}} linearize {{c2::exponential}} data by making one axis logarithmic; {{c1::log–log plots}} linearize {{c2::power-law}} relationships by making both axes logarithmic.',
        2),
    (deck, 38, 'cloze',
        '{{c1::Linear data}} are the least likely to need transformation into a semi-log or log–log plot — they are already {{c2::straight on standard axes}}.',
        2);

    -- ============================================================
    -- 12.7 Correlation and Causation (cards 40–42)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 39, 'cloze',
        '{{c1::Positive correlation}} means both variables move in the {{c2::same direction}}; {{c1::negative correlation}} means they move in {{c2::opposite directions}}.',
        2),
    (deck, 40, 'cloze',
        'The {{c1::correlation coefficient (r)}} ranges from {{c2::−1 to +1}}: −1 is a perfect negative, +1 is a perfect positive, and {{c3::0}} indicates no apparent linear relationship.',
        3),
    (deck, 41, 'cloze',
        '{{c1::Correlation does not imply causation}} — to argue causation from an observed correlation, evaluate {{c2::Hill''s criteria}} (temporality, dose-response, plausibility, etc., from Ch 11).',
        2);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     '{{c1::Random error}} is unpredictable, non-directional variation that lowers precision (reliability) but averages out over many measurements, unlike {{c1::systematic error}}, which shifts results consistently in one direction.',
     1);

    RAISE NOTICE 'Seeded deck % with 43 cards.', deck;
END $$;
