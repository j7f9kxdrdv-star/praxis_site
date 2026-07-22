-- ════════════════════════════════════════════════════════════════════
-- Psych/Soc Chapter 6 — Identity and Personality
-- ════════════════════════════════════════════════════════════════════
-- Section: psych_soc
-- Topic:   Psych/Soc
-- Subtopic slug: identity_and_personality
-- Sort order: 6
--
-- Coverage (AAMC-aligned order):
--    1. Self-Concept, Identity & Self-Evaluation
--    2. Formation of Identity: Social Theories
--    3. Freud's Psychosexual Stages
--    4. Erikson & Kohlberg
--    5. Personality: Psychoanalytic & Humanistic
--    6. Personality: Trait Theories
--    7. Personality: Social-Cognitive, Behaviorist & Biological
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Psychology 2e. Scope: AAMC Self-Identity (8A) — self-concept, self-esteem/efficacy/
-- locus of control, identity formation (Cooley, Mead, Vygotsky, Freud, Erikson, Kohlberg)
-- + Personality (7A) — the six perspectives (psychoanalytic, humanistic, trait, social-
-- cognitive, behaviorist, biological). Out of scope: Maslow's hierarchy levels (Ch 5);
-- operant-conditioning mechanics (Ch 3); brain anatomy (Ch 1); psychological-disorder
-- classification (later chapter). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'psych_soc'
      AND title IN (
          'Identity and Personality',
          'Identity & Personality'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'psych_soc',
        'Psych/Soc',
        'identity_and_personality',
        'Identity and Personality',
        'Self-concept and identity with self-esteem, self-efficacy, and locus of control; identity formation through the looking-glass self, Mead''s social self, and Vygotsky''s zone of proximal development; the developmental stage theories of Freud, Erikson, and Kohlberg; and the six personality perspectives — psychoanalytic (id/ego/superego and defense mechanisms), humanistic, trait (Eysenck, the Big Five, Allport), social-cognitive, behaviorist, and biological.',
        6
    )
    RETURNING id INTO deck;

    -- ── Self-Concept, Identity & Self-Evaluation ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     '{{c1::Self-concept}} is the whole set of beliefs we hold about who we are — our present, past, and possible future selves.',
     1),
    (deck, 1, 'cloze',
     'An {{c1::identity}} is a component of our self-concept that comes from belonging to a particular social group.',
     1),
    (deck, 2, 'cloze',
     'Identities commonly form around demographic categories such as {{c1::race/ethnicity, gender, age, sexual orientation, and social class}}.',
     1),
    (deck, 3, 'cloze',
     '{{c1::Self-esteem}} is our overall evaluation of our own worth.',
     1),
    (deck, 4, 'cloze',
     'Self-esteem rises as our actual self approaches both our {{c1::ideal self and our ought self}}.',
     1),
    (deck, 5, 'cloze',
     'The {{c1::ideal}} self is who we want to be, while the {{c1::ought}} self is who we feel we should be.',
     1),
    (deck, 6, 'cloze',
     '{{c1::Self-efficacy}}, a concept from Bandura, is our belief that we can succeed at a specific task.',
     1),
    (deck, 7, 'cloze',
     '{{c1::Learned helplessness}}, shown by Seligman, is the loss of perceived control and passive giving-up that follows repeated, inescapable adversity.',
     1),
    (deck, 8, 'cloze',
     '{{c1::Julian Rotter}} introduced locus of control — our beliefs about how much power we hold over life''s outcomes.',
     1),
    (deck, 9, 'cloze',
     'An {{c1::internal}} locus of control credits outcomes to our own effort, while an {{c1::external}} one credits luck, fate, or other people.',
     1),
    (deck, 10, 'cloze',
     'A {{c1::reference group}} is the set of people we compare ourselves against when judging our own qualities.',
     1);

    -- ── Formation of Identity: Social Theories ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 11, 'cloze',
     '{{c1::Cooley}}''s {{c1::looking-glass self}} holds that we build our self-concept from how we imagine others perceive and judge us.',
     1),
    (deck, 12, 'cloze',
     '{{c1::Mead}} argued that the self is not present at birth but develops through {{c2::social interaction}}.',
     2),
    (deck, 13, 'cloze',
     'In Mead''s theory, the {{c1::"I"}} is the spontaneous, unsocialized self, while the {{c1::"Me"}} is the socialized self that reflects others'' expectations.',
     1),
    (deck, 14, 'cloze',
     'Mead''s {{c1::generalized other}} is a person''s internalized sense of society''s expectations.',
     1),
    (deck, 15, 'cloze',
     'In the first of Mead''s stages, the {{c1::preparatory}} stage, children merely imitate others without grasping the social roles behind the behavior.',
     1),
    (deck, 16, 'cloze',
     'In Mead''s {{c1::play}} stage, a child takes on the role of one other person at a time, such as a parent or a doctor.',
     1),
    (deck, 17, 'cloze',
     'In Mead''s {{c1::game}} stage, a child juggles multiple roles at once and comes to grasp the generalized other.',
     1),
    (deck, 18, 'cloze',
     'In Mead''s account, {{c1::role-taking}} is learning to view a situation from another person''s perspective.',
     1),
    (deck, 19, 'cloze',
     '{{c1::Vygotsky}}''s {{c2::zone of proximal development}} is the gap between what a learner can do alone and what they can achieve with a more knowledgeable other''s help.',
     2),
    (deck, 20, 'cloze',
     '{{c1::Imitation}} of role models is among the earliest ways a child learns from others and begins shaping an emerging self.',
     1);

    -- ── Freud's Psychosexual Stages ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 21, 'cloze',
     '{{c1::Freud}} held that personality forms through a sequence of psychosexual stages, each powered by the {{c2::libido}} and centered on a bodily erogenous zone.',
     2),
    (deck, 22, 'cloze',
     'In Freud''s model, failing to resolve a stage''s conflict leaves a person {{c1::fixated}} at that stage, carrying its influence into adult personality.',
     1),
    (deck, 23, 'cloze',
     'Freud''s first stage, the {{c1::oral}} stage (birth to ~1 year), centers pleasure on the {{c1::mouth}}.',
     1),
    (deck, 24, 'cloze',
     'Fixation at Freud''s {{c1::anal}} stage (~1–3 years), the period of {{c1::toilet training}}, can produce a personality marked by extreme orderliness or messiness.',
     1),
    (deck, 25, 'cloze',
     'Freud''s third stage, the {{c1::phallic}} stage (~3–6 years), turns on resolving the Oedipus (or Electra) complex.',
     1),
    (deck, 26, 'cloze',
     'In the phallic stage, the {{c1::Oedipus complex}} (boys) and {{c1::Electra complex}} (girls) name a child''s desire for the opposite-sex parent and rivalry with the same-sex parent.',
     1),
    (deck, 27, 'cloze',
     'In Freud''s {{c1::latency}} period (~6 years to puberty), sexual urges are set aside while the child invests energy in school, friendships, and hobbies.',
     1),
    (deck, 28, 'cloze',
     'Freud''s final {{c1::genital}} stage begins at puberty; those who resolved the earlier stages reach it as well-adjusted adults capable of mature intimate relationships.',
     1);

    -- ── Erikson & Kohlberg ────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     '{{c1::Erikson}}''s psychosocial theory of development describes {{c2::eight}} stages, each defined by a conflict the person must resolve at that phase of life.',
     2),
    (deck, 30, 'cloze',
     'In Erikson''s theory, successfully resolving a stage''s conflict builds a sense of {{c1::competence}}, whereas failing to resolve it leaves feelings of {{c1::inadequacy}}.',
     1),
    (deck, 31, 'cloze',
     'Erikson''s infancy stage (birth to 1 year) centers on the conflict {{c1::trust versus mistrust}}.',
     1),
    (deck, 32, 'cloze',
     'Erikson''s toddlerhood stage (ages 1 to 3) centers on the conflict {{c1::autonomy versus shame and doubt}}.',
     1),
    (deck, 33, 'cloze',
     'Erikson''s preschool stage (ages 3 to 6) centers on the conflict {{c1::initiative versus guilt}}.',
     1),
    (deck, 34, 'cloze',
     'Erikson''s school-age stage (ages 7 to 11) centers on the conflict {{c1::industry versus inferiority}}.',
     1),
    (deck, 35, 'cloze',
     'Erikson''s adolescent stage (ages 12 to 18) centers on the conflict {{c1::identity versus role confusion}}.',
     1),
    (deck, 36, 'cloze',
     'Erikson''s young-adulthood stage (ages 19 to 29) centers on the conflict {{c1::intimacy versus isolation}}.',
     1),
    (deck, 37, 'cloze',
     'Erikson''s middle-adulthood stage (ages 30 to 64) centers on the conflict {{c1::generativity versus stagnation}}.',
     1),
    (deck, 38, 'cloze',
     'Erikson''s late-adulthood stage (age 65 onward) centers on the conflict {{c1::integrity versus despair}}.',
     1),
    (deck, 39, 'cloze',
     '{{c1::Kohlberg}}''s theory of moral development advances through three levels: {{c2::preconventional, conventional, and postconventional}}.',
     2),
    (deck, 40, 'cloze',
     'In Kohlberg''s {{c1::preconventional}} level, moral reasoning is driven by avoiding punishment and pursuing self-interest or reward.',
     1),
    (deck, 41, 'cloze',
     'In Kohlberg''s {{c1::conventional}} level, moral reasoning is driven by winning social approval and upholding law and order.',
     1),
    (deck, 42, 'cloze',
     'In Kohlberg''s {{c1::postconventional}} level, moral reasoning rests on the social contract and abstract, universal ethical principles.',
     1);

    -- ── Personality: Psychoanalytic & Humanistic ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     'The {{c1::psychoanalytic}} perspective, rooted in Freud''s work, holds that personality is driven largely by unconscious urges and desires.',
     1),
    (deck, 44, 'cloze',
     'In Freud''s model, the {{c1::id}} follows the {{c1::pleasure}} principle, demanding immediate gratification of primitive drives like hunger, thirst, and sex.',
     1),
    (deck, 45, 'cloze',
     'The {{c1::ego}} operates on the {{c1::reality}} principle, mediating between the id''s primitive urges and the superego''s moral demands.',
     1),
    (deck, 46, 'cloze',
     'The {{c1::superego}} is the internalized moral conscience that judges our behavior and strives for perfection.',
     1),
    (deck, 47, 'cloze',
     'To reduce anxiety created by the clash between competing urges, the ego unconsciously deploys {{c1::defense mechanisms}}.',
     1),
    (deck, 48, 'cloze',
     'Blocking a distressing thought from awareness unconsciously is {{c1::repression}}; consciously choosing to set it aside is {{c1::suppression}}.',
     1),
    (deck, 49, 'cloze',
     'In {{c1::projection}}, a person attributes their own unacceptable feelings or impulses to someone else.',
     1),
    (deck, 50, 'cloze',
     'In {{c1::displacement}}, an unacceptable impulse is redirected from its true target onto a safer, less threatening one.',
     1),
    (deck, 51, 'cloze',
     '{{c1::Sublimation}} channels an unacceptable impulse into a socially acceptable activity, such as sport or art.',
     1),
    (deck, 52, 'cloze',
     'In {{c1::reaction formation}}, a person expresses feelings or behaviors that are the opposite of their anxiety-provoking true impulses.',
     1),
    (deck, 53, 'cloze',
     'In {{c1::denial}}, a person protects themselves from anxiety by refusing to accept a distressing fact or reality.',
     1),
    (deck, 54, 'cloze',
     'In {{c1::regression}}, a person under stress reverts to behaviors typical of an earlier, more immature developmental stage.',
     1),
    (deck, 55, 'cloze',
     'In {{c1::rationalization}}, a person reduces anxiety by making acceptable-sounding excuses that justify their behavior.',
     1),
    (deck, 56, 'cloze',
     '{{c1::Jung}} proposed the {{c2::collective unconscious}}, an inherited store of {{c2::archetypes}} shared by all humans across cultures.',
     2),
    (deck, 57, 'cloze',
     '{{c1::Adler}} emphasized the {{c1::inferiority complex}}, a sense of not measuring up that drives people to strive for superiority.',
     1),
    (deck, 58, 'cloze',
     '{{c1::Horney}} argued that the unconscious is driven mainly by {{c2::social}} rather than {{c2::sexual}} needs, breaking from Freud.',
     2),
    (deck, 59, 'cloze',
     'The {{c1::humanistic}} perspective focuses on healthy people striving toward {{c2::self-actualization, the realization of one''s fullest potential}}.',
     2),
    (deck, 60, 'cloze',
     'Rogers''s {{c1::unconditional positive regard}} means fully accepting and valuing a person no matter what they say or do.',
     1);

    -- ── Personality: Trait Theories ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 61, 'cloze',
     '{{c1::Type}} theories sort people into a few discrete categories, whereas {{c1::trait}} theories rate each person along continuous dimensions.',
     1),
    (deck, 62, 'cloze',
     '{{c1::Sheldon}}''s somatotype approach is a type theory that sorts people by body build into endomorphs, mesomorphs, and ectomorphs.',
     1),
    (deck, 63, 'cloze',
     'Two early type theories that sort people into fixed categories are the ancient Greek four {{c1::humors}} and the {{c2::Myers-Briggs Type Indicator}}.',
     2),
    (deck, 64, 'cloze',
     '{{c1::Eysenck}}''s trait model, abbreviated PEN, rates personality on three dimensions: {{c2::psychoticism, extraversion, and neuroticism}}.',
     2),
    (deck, 65, 'cloze',
     'Today the most widely accepted trait theory in personality psychology is the {{c1::Big Five}}, which places people along several broad dimensions.',
     1),
    (deck, 66, 'cloze',
     'The Big Five traits, in the order of the acronym OCEAN, are {{c1::openness, conscientiousness, extraversion, agreeableness, and neuroticism}}.',
     1),
    (deck, 67, 'cloze',
     'Allport''s {{c1::cardinal}} trait is a single dominant trait that organizes a person''s whole life, and not everyone develops one.',
     1),
    (deck, 68, 'cloze',
     'Allport''s {{c1::central}} traits are the handful of major characteristics — such as honest, kind, or shy — that best describe someone.',
     1),
    (deck, 69, 'cloze',
     'Allport''s {{c1::secondary}} traits are situational preferences and attitudes that surface only in particular contexts.',
     1),
    (deck, 70, 'cloze',
     '{{c1::McClelland}} described the need for achievement (N-Ach) as a personality trait — the drive to pursue and master challenges.',
     1);

    -- ── Personality: Social-Cognitive, Behaviorist & Biological ───────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 71, 'cloze',
     '{{c1::Bandura}} developed the social-cognitive theory of personality, holding that our thinking and reasoning — not just learned habits — shape who we become.',
     1),
    (deck, 72, 'cloze',
     'Bandura''s {{c1::reciprocal determinism}} describes how a person''s traits, their behavior, and their environment each continuously influence the other two.',
     1),
    (deck, 73, 'cloze',
     'The {{c1::behaviorist}} perspective, championed by {{c1::Skinner}}, denies hidden inner drives and treats personality as response patterns learned entirely from one''s environment.',
     1),
    (deck, 74, 'cloze',
     'For behaviorists, personality is not inborn but a set of consistent, learned response tendencies acquired through {{c1::operant conditioning}}.',
     1),
    (deck, 75, 'cloze',
     'The {{c1::biological}} perspective explains personality as rooted in genetics, heredity, and inborn traits rather than in upbringing or culture.',
     1),
    (deck, 76, 'cloze',
     '{{c1::Temperament}} — an innate, biologically based disposition that appears very early in infancy — provides the foundation later shaped into adult personality.',
     1),
    (deck, 77, 'cloze',
     'The situational approach, advanced by {{c1::Mischel}} in the person-situation debate, holds that behavior shifts so much across settings that stable traits alone poorly predict it.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 78;
END $$;
