-- Praxis Prep — Scientific Reasoning Chapter 11: Reasoning About Research Design
-- v6-compliant flashcard deck (38 cards)
-- Subtopics: 11.1 Scientific Method + FINER (4), 11.2 Basic Science Research (6),
-- 11.3 Human Subjects Designs (10), 11.4 Sources of Error (6),
-- 11.5 Research Ethics (7), 11.6 Populations, Samples, Validity, Significance (5).
-- Source-laundered against OpenStax Psychology 2e Ch. 2 (Research), OpenStax
-- Concepts of Biology Ch. 1 (Scientific Method), Belmont Report (research ethics),
-- and AAMC Scientific Inquiry and Reasoning Skills (SIRS) framework.
-- Idempotent: deletes any prior version of this deck before inserting.
--
-- PREREQUISITE: Run migration 20260602_add_scientific_reasoning_section.sql
-- first to extend the section CHECK constraint to allow 'scientific_reasoning'.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Reasoning About Research Design',
            'Physics Chapter 11: Reasoning About the Design and Execution of Research',
            'Scientific Reasoning Chapter 11: Reasoning About Research Design'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Reasoning About Research Design',
        'Physics Chapter 11: Reasoning About the Design and Execution of Research',
        'Scientific Reasoning Chapter 11: Reasoning About Research Design'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'scientific_reasoning',
        'Scientific Reasoning',
        'research design',
        'Reasoning About Research Design',
        'The scientific method (8 steps) and FINER criteria; basic science research (controls, independent vs dependent variables, accuracy vs precision); human subjects study designs (experimental vs observational, randomization, blinding, cohort vs cross-sectional vs case-control, Hill''s criteria for causality); sources of error (bias types, confounding); research ethics (four core principles, respect for persons, equipoise); and populations, samples, validity, and statistical vs clinical significance.',
        11
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 11.1 The Scientific Method and FINER (cards 1–4)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'The scientific method is 8 steps grouped into 3 phases: {{c1::ask a testable question and gather data}}, then {{c2::form and test a hypothesis with new data}}, then {{c3::publish and verify results}}.',
        3),
    (deck, 1, 'cloze',
        'A {{c1::hypothesis}} is a {{c2::proposed answer}} to a testable question, often phrased as an {{c3::if–then statement}}.',
        3),
    (deck, 2, 'cloze',
        '{{c1::Experimentation}} manipulates and controls variables to test cause and effect; {{c1::observation}} records subjects in their natural environment without changing anything.',
        1),
    (deck, 3, 'cloze',
        'The FINER method evaluates a research question on five criteria: {{c1::Feasibility}}, {{c1::Interest}}, {{c1::Novelty}}, {{c1::Ethics}}, and {{c1::Relevance}}.',
        1);

    -- ============================================================
    -- 11.2 Basic Science Research (cards 5–10)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 4, 'cloze',
        '{{c1::Basic science research}} happens in a {{c2::laboratory (not on people)}}, gives the experimenter the most control, and is the design best suited to {{c3::demonstrating causality}}.',
        3),
    (deck, 5, 'cloze',
        'The {{c1::independent variable}} is {{c2::manipulated}} by the experimenter, while the {{c1::dependent variable}} is {{c2::measured or observed}}.',
        2),
    (deck, 6, 'cloze',
        'A {{c1::positive control}} verifies that a change in the dependent variable {{c2::occurs when expected}}; a {{c1::negative control}} verifies that {{c2::no change occurs when none is expected}}.',
        2),
    (deck, 7, 'cloze',
        'The {{c1::placebo effect}} is a measurable response to a {{c2::sham intervention}} (sugar pill, fake procedure); it is typically assessed using a {{c3::negative control group}}.',
        3),
    (deck, 8, 'cloze',
        '{{c1::Accuracy (validity)}} is how close a measurement is to the {{c2::true value}}; {{c1::precision (reliability)}} is how {{c2::consistent}} repeated measurements are.',
        2),
    (deck, 9, 'cloze',
        'A {{c1::systematic error}} is a {{c2::consistent, non-random deviation}} from the true value — it affects {{c3::accuracy but not precision}}.',
        3);

    -- ============================================================
    -- 11.3 Human Subjects Research — Study Designs (cards 11–20)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
        '{{c1::Experimental}} studies manipulate the independent variable and can establish {{c2::causation}}; {{c1::observational}} studies record without manipulating and can only show {{c2::correlation}}.',
        2),
    (deck, 11, 'cloze',
        '{{c1::Randomization}} assigns subjects to groups using an algorithm to control for {{c2::between-group differences}} that could otherwise confound the comparison.',
        2),
    (deck, 12, 'cloze',
        'In a {{c1::single-blind}} trial, only one party (usually the subject or the assessor) is unaware of group assignment; in a {{c1::double-blind}} trial, the {{c2::subject, investigator, and assessor}} are all unaware.',
        2),
    (deck, 13, 'cloze',
        'Blinding matters because without it, only the treatment group fully experiences the {{c1::placebo effect}} — which makes the apparent treatment effect look {{c2::larger than it really is}}.',
        2),
    (deck, 14, 'cloze',
        'A {{c1::cohort study}} sorts subjects by {{c2::exposure (risk factor)}} and follows them {{c3::forward in time}} to see who develops the outcome.',
        3),
    (deck, 15, 'cloze',
        'A {{c1::cross-sectional study}} measures {{c2::exposure and outcome at the same point in time}} — a single snapshot of a population.',
        2),
    (deck, 16, 'cloze',
        'A {{c1::case–control study}} sorts subjects by {{c2::outcome status first}}, then looks {{c3::backward}} to compare past exposure between groups.',
        3),
    (deck, 17, 'cloze',
        'Hill''s criteria for causality (9 total): {{c1::temporality}}, {{c1::strength}}, {{c1::dose-response}}, {{c1::consistency}}, {{c1::plausibility}}, {{c1::consideration of alternatives}}, {{c1::experiment}}, {{c1::specificity}}, and {{c1::coherence}}.',
        1),
    (deck, 18, 'cloze',
        'Hill''s {{c1::temporality}} criterion — the {{c2::exposure must occur before the outcome}} for a relationship to be considered causal.',
        2),
    (deck, 19, 'cloze',
        'Hill''s {{c1::dose-response}} criterion — as the exposure increases, the response should {{c2::increase proportionally}}; a consistent dose-response relationship strengthens the causal inference.',
        2);

    -- ============================================================
    -- 11.4 Sources of Error in Research (cards 21–26)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
        '{{c1::Bias}} is a {{c2::systematic error}} introduced during {{c3::data collection}}; it skews results in one direction and affects accuracy but not precision.',
        3),
    (deck, 21, 'cloze',
        '{{c1::Bias}} is a flaw in the {{c2::data-collection}} phase; {{c1::confounding}} is an error during the {{c2::data-analysis}} phase — they arise at different stages of the study.',
        2),
    (deck, 22, 'cloze',
        '{{c1::Selection bias}} occurs when the {{c2::study sample}} is not representative of the {{c3::target population}} — for example, the volunteer effect.',
        3),
    (deck, 23, 'cloze',
        '{{c1::Detection bias}} arises when {{c2::knowledgeable assessors}} apply their expertise inconsistently across study groups, distorting outcome measurement.',
        2),
    (deck, 24, 'cloze',
        '{{c1::Observation bias}}, also called the {{c2::Hawthorne effect}}, is a change in subject behavior that occurs simply because they {{c3::know they are being studied}}.',
        3),
    (deck, 25, 'cloze',
        'A {{c1::confounding variable}} is a {{c2::third variable}} that influences both the {{c3::independent and dependent variables}}, creating an apparent relationship that isn''t actually causal.',
        3);

    -- ============================================================
    -- 11.5 Research Ethics (cards 27–33)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
        'The four core principles of medical and research ethics are {{c1::beneficence}}, {{c1::nonmaleficence}}, {{c1::autonomy}}, and {{c1::justice}}.',
        1),
    (deck, 27, 'cloze',
        '{{c1::Beneficence}} is the obligation to act in the {{c2::patient''s best interest}} and to maximize net benefit while minimizing potential harm.',
        2),
    (deck, 28, 'cloze',
        '{{c1::Nonmaleficence}} is the obligation to {{c2::avoid interventions in which the potential for harm outweighs the potential for benefit}}.',
        2),
    (deck, 29, 'cloze',
        '{{c1::Autonomy}} (respect for autonomy) is the duty to respect the patient''s {{c2::own decisions about their own health care}}.',
        2),
    (deck, 30, 'cloze',
        '{{c1::Justice}} is the duty to distribute health-care resources {{c2::fairly}} and to treat similar patients with {{c3::similar care}} — it applies to both the choice of research topic and the execution of the study.',
        3),
    (deck, 31, 'cloze',
        '{{c1::Respect for persons}} encompasses {{c2::honesty, informed consent, and confidentiality}}, and requires extra protections for {{c3::vulnerable populations (children, pregnant individuals, prisoners)}} — typically enforced by an Institutional Review Board (IRB).',
        3),
    (deck, 32, 'cloze',
        '{{c1::Equipoise}} means that in a head-to-head trial comparing two treatments, researchers must have {{c2::no prior knowledge that one option is superior}} to the other.',
        2);

    -- ============================================================
    -- 11.6 Populations, Samples, Validity, and Significance (cards 34–38)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 33, 'cloze',
        'A {{c1::population}} is the complete group of all individuals who satisfy the attributes of interest; a {{c1::sample}} is any subset drawn from a population.',
        1),
    (deck, 34, 'cloze',
        'A {{c1::parameter}} is a value calculated from a {{c2::population}}; a {{c1::statistic}} is a value calculated from a {{c2::sample}} and is used to estimate the parameter.',
        2),
    (deck, 35, 'cloze',
        '{{c1::Random sampling}} is the gold standard for getting a {{c2::representative sample}} of a population; non-random methods can introduce {{c3::selection bias}}.',
        3),
    (deck, 36, 'cloze',
        '{{c1::Internal validity}} is the extent to which a study correctly establishes {{c2::cause and effect within the study sample}}; {{c1::external validity (generalizability)}} is the extent to which the results {{c2::apply beyond the study sample}}.',
        2),
    (deck, 37, 'cloze',
        '{{c1::Statistical significance}} means the result is {{c2::unlikely to be due to chance}}; {{c1::clinical significance}} means the change is {{c2::large enough to matter in real-world practice}} — an intervention should demonstrate both.',
        2);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 38, 'cloze',
     'A scientific hypothesis is not generated at random but is derived from {{c1::existing theory, prior findings, and observations}}.',
     1),
    (deck, 39, 'cloze',
     'Descriptive qualitative and survey designs that cannot establish causation include {{c1::questionnaires, interviews, and focus groups}} plus {{c2::case studies and ethnographic (naturalistic) observation}}.',
     2);

    RAISE NOTICE 'Seeded deck % with 40 cards.', deck;
END $$;
