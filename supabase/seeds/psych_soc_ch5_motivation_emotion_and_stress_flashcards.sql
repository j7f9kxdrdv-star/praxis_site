-- ════════════════════════════════════════════════════════════════════
-- Psych/Soc Chapter 5 — Motivation, Emotion, and Stress
-- ════════════════════════════════════════════════════════════════════
-- Section: psych_soc
-- Topic:   Psych/Soc
-- Subtopic slug: motivation_emotion_and_stress
-- Sort order: 5
--
-- Coverage (AAMC-aligned order):
--    1. Motivation: Factors & Drives
--    2. Motivation: Theories & Biological Motivators
--    3. Emotion: Components & Theories
--    4. The Physiology of Emotion
--    5. Stress & Appraisal
--    6. Stress Response & Management
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Psychology 2e. Scope: AAMC Motivation (7A) — factors, theories, biological
-- motivators + Emotion (6C) — components, universal emotions, theories, emotion
-- physiology + Stress (6C) — appraisal, stressors, the general adaptation syndrome,
-- outcomes, coping. Out of scope: brain anatomy & structure-function (limbic system,
-- amygdala, hypothalamus, thalamus, hippocampus, PFC, ANS branches → Ch 1); learning
-- & memory (Ch 3); cognition (Ch 4); attitudes/cognitive dissonance (later). See .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'psych_soc'
      AND title IN (
          'Motivation, Emotion, and Stress',
          'Motivation, Emotion & Stress'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'psych_soc',
        'Psych/Soc',
        'motivation_emotion_and_stress',
        'Motivation, Emotion, and Stress',
        'Motivation — extrinsic vs intrinsic, the instinct, arousal, drive-reduction, incentive, and expectancy-value theories, Maslow''s hierarchy and self-determination theory, and biological motivators; emotion — its three components, the universal emotions, the James-Lange, Cannon-Bard, and Schachter-Singer theories, and the physiology of emotional arousal; and stress — cognitive appraisal, types of stressors, the general adaptation syndrome, stress outcomes, and coping and stress-management strategies.',
        5
    )
    RETURNING id INTO deck;

    -- ── Motivation: Factors & Drives ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'In psychology, {{c1::motivation}} refers to the internal wants and needs that drive a person to act toward a goal.',
     1),
    (deck, 1, 'cloze',
     'Motivation that arises from external rewards or pressures is {{c1::extrinsic}}, while motivation that arises from internal interest or satisfaction is {{c1::intrinsic}}.',
     1),
    (deck, 2, 'cloze',
     '{{c1::Instinct}} theory holds that behavior is driven by innate, unlearned, species-specific patterns of action.',
     1),
    (deck, 3, 'cloze',
     'According to {{c1::arousal}} theory, we are motivated to keep our physiological {{c1::arousal}} at an optimal level, neither too high nor too low.',
     1),
    (deck, 4, 'cloze',
     'The {{c1::Yerkes-Dodson}} law states that task performance is best at a {{c2::moderate}} level of arousal.',
     2),
    (deck, 5, 'cloze',
     'Under the Yerkes-Dodson law, the harder or more complex the task, the {{c1::lower}} the arousal level that produces peak performance.',
     1),
    (deck, 6, 'cloze',
     'A {{c1::drive}} is an internal state of tension that directs behavior toward a goal.',
     1),
    (deck, 7, 'cloze',
     '{{c1::Primary}} drives arise directly from biological needs, whereas {{c1::secondary}} drives are learned through experience.',
     1),
    (deck, 8, 'cloze',
     'In {{c1::drive-reduction}} theory, a disruption of {{c1::homeostasis}} creates a physiological need that motivates goal-directed behavior.',
     1);

    -- ── Motivation: Theories & Biological Motivators ──────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
     'Maslow''s hierarchy of needs is arranged so that {{c1::more basic needs must be satisfied before higher needs can motivate behavior}}.',
     1),
    (deck, 10, 'cloze',
     'The two lowest levels of Maslow''s hierarchy, from the base up, are {{c1::physiological needs, then safety needs}}.',
     1),
    (deck, 11, 'cloze',
     'Above safety, Maslow''s hierarchy rises through {{c1::love and belonging, then esteem, then self-actualization at the top}}.',
     1),
    (deck, 12, 'cloze',
     'Maslow described {{c1::self-actualization}} as realizing one''s full potential — a need pursued only after all lower needs are met.',
     1),
    (deck, 13, 'cloze',
     'Self-determination theory proposes three universal psychological needs: {{c1::autonomy, competence, and relatedness}}.',
     1),
    (deck, 14, 'cloze',
     'Incentive theory holds that behavior is driven by {{c1::pursuing external rewards and avoiding punishments}}.',
     1),
    (deck, 15, 'cloze',
     'In expectancy-value theory, motivation equals the expectation of success {{c1::multiplied by}} the value placed on that success.',
     1),
    (deck, 16, 'cloze',
     'Opponent-process theory says that as drug use continues, the body''s opposing reaction grows, producing {{c1::tolerance and withdrawal}}.',
     1),
    (deck, 17, 'cloze',
     'Hunger is a biological drive triggered when {{c1::blood glucose levels drop}}.',
     1),
    (deck, 18, 'cloze',
     'Sexual motivation is shaped by {{c1::hormones together with social and cultural factors}}.',
     1);

    -- ── Emotion: Components & Theories ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 19, 'cloze',
     'An emotion is a {{c1::subjective}} feeling state.',
     1),
    (deck, 20, 'cloze',
     'The three components of emotion are {{c1::cognitive, physiological, and behavioral}}.',
     1),
    (deck, 21, 'cloze',
     'The behavioral component of emotion is expressed through {{c1::facial expressions and body language}}.',
     1),
    (deck, 22, 'cloze',
     'Ekman found that six basic emotions — happiness, sadness, fear, anger, disgust, and surprise — are recognized {{c1::across cultures (universally)}}.',
     1),
    (deck, 23, 'cloze',
     'Some researchers add {{c1::contempt}} to Ekman''s six basic emotions, giving seven universal emotions.',
     1),
    (deck, 24, 'cloze',
     'Emotions serve two adaptive functions: {{c1::communication and survival}}.',
     1),
    (deck, 25, 'cloze',
     'In the {{c1::James-Lange}} theory of emotion, a stimulus produces physiological arousal first, and the emotion is our interpretation of that bodily arousal.',
     1),
    (deck, 26, 'cloze',
     'In the {{c1::Cannon-Bard}} theory of emotion, physiological arousal and the felt emotion occur at the same time but independently of each other.',
     1),
    (deck, 27, 'cloze',
     'In the {{c1::Schachter-Singer}} theory of emotion, physiological arousal alone is not enough — a cognitive label for that arousal is also required.',
     1),
    (deck, 28, 'cloze',
     'The Schachter-Singer theory of emotion is also called the {{c1::two-factor}} theory.',
     1);

    -- ── The Physiology of Emotion ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     'The physiological (bodily) component of an emotion is produced by the {{c1::autonomic (mainly sympathetic)}} nervous system, supplying the arousal that emotion theories invoke.',
     1),
    (deck, 30, 'cloze',
     'Sympathetic activation during an emotion produces bodily signs such as {{c1::a racing heart, sweating, and faster breathing}}.',
     1),
    (deck, 31, 'cloze',
     'Because emotion produces measurable physiological arousal — a bodily signature of feeling — this is the working principle behind {{c1::polygraph / lie-detector}} tests.',
     1),
    (deck, 32, 'cloze',
     'Within the limbic system, the {{c1::amygdala}} attaches emotional significance — especially {{c1::fear}} — to incoming stimuli.',
     1);

    -- ── Stress & Appraisal ────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 33, 'cloze',
     'Stress is a person''s {{c1::physiological and cognitive}} response to a challenge or demand that taxes their resources.',
     1),
    (deck, 34, 'cloze',
     'In {{c1::Lazarus}}''s cognitive appraisal model, a potential stressor is judged in two stages: {{c2::primary and secondary}} appraisal.',
     2),
    (deck, 35, 'cloze',
     'Primary appraisal classifies a stimulus as {{c1::irrelevant, benign-positive, or stressful}}.',
     1),
    (deck, 36, 'cloze',
     'Secondary appraisal evaluates whether a person has the {{c1::resources to cope}} with a stressor.',
     1),
    (deck, 37, 'cloze',
     'A stressor is the {{c1::stimulus}} that triggers stress, while stress is the {{c1::response}} it produces.',
     1),
    (deck, 38, 'cloze',
     '{{c1::Cataclysmic}} stressors are sudden, large-scale events, like natural disasters, that strike many people at once.',
     1),
    (deck, 39, 'cloze',
     'Major {{c1::life changes}} are stressors whether welcome or unwelcome, since even positive ones demand readjustment.',
     1),
    (deck, 40, 'cloze',
     'Though each is minor, {{c1::daily hassles}} can pile up and predict health problems at least as well as major life changes do.',
     1),
    (deck, 41, 'cloze',
     'Three common psychological stressors are {{c1::frustration}}, {{c1::conflict}}, and a lack of {{c1::control}}.',
     1),
    (deck, 42, 'cloze',
     'Motivational conflict takes three forms: {{c1::approach-approach, approach-avoidance, and avoidance-avoidance}}.',
     1),
    (deck, 43, 'cloze',
     'An {{c1::approach-avoidance}} conflict arises when a single goal has both appealing and unappealing features.',
     1),
    (deck, 44, 'cloze',
     'Stress can be {{c1::distress}}, the harmful and negative kind, or {{c1::eustress}}, the beneficial and motivating kind.',
     1);

    -- ── Stress Response & Management ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 45, 'cloze',
     '{{c1::General adaptation syndrome}}, described by Hans Selye, models the body''s reaction to prolonged stress as three successive stages.',
     1),
    (deck, 46, 'cloze',
     'The general adaptation syndrome unfolds in the order {{c1::alarm, then resistance, then exhaustion}}.',
     1),
    (deck, 47, 'cloze',
     'In the alarm reaction, the {{c1::sympathetic nervous system}} activates while {{c1::ACTH}} triggers {{c1::cortisol}} release.',
     1),
    (deck, 48, 'cloze',
     'In the resistance stage, the body adapts to an ongoing stressor while {{c1::stress-hormone levels stay elevated}}.',
     1),
    (deck, 49, 'cloze',
     'If stress persists into the exhaustion stage, depleted reserves leave the body vulnerable to {{c1::illness, organ damage, and even death}}.',
     1),
    (deck, 50, 'cloze',
     'The two coping styles are {{c1::problem-focused}} coping, which acts on the stressor itself, and {{c1::emotion-focused}} coping, which manages one''s internal reaction to it.',
     1),
    (deck, 51, 'cloze',
     'Problem-focused coping is favored for {{c1::controllable}} stressors, while emotion-focused coping predominates for {{c1::uncontrollable}} ones.',
     1),
    (deck, 52, 'cloze',
     'Chronic stress exacts a physiological toll, notably {{c1::suppressing the immune system and straining the cardiovascular system}}.',
     1),
    (deck, 53, 'cloze',
     'Besides physiological damage, prolonged stress also generates {{c1::emotional and behavioral}} consequences.',
     1),
    (deck, 54, 'cloze',
     'Common stress-management techniques include {{c1::exercise, meditation, and social support}}.',
     1),
    (deck, 55, 'cloze',
     'Strong {{c1::social support}} buffers the impact of stress and is linked to stronger immune function and greater longevity.',
     1);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 56, 'cloze',
     'Chronic stress impairs cognitive functions like {{c1::memory, attention, and decision-making}}, and raises the risk of {{c2::anxiety and depression}}.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 57;
END $$;
