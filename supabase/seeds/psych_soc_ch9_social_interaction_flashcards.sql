-- ════════════════════════════════════════════════════════════════════
-- Psych/Soc Chapter 9 — Social Interaction
-- ════════════════════════════════════════════════════════════════════
-- Section: psych_soc
-- Topic:   Psych/Soc
-- Subtopic slug: social_interaction
-- Sort order: 9
--
-- Coverage (AAMC-aligned order):
--    1. Status & Role
--    2. Groups & Networks
--    3. Emotional Expression & Self-Presentation
--    4. Dramaturgy & Communication
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Psychology 2e + Sociology 3e. Scope: AAMC 10A social structure (status, role, groups,
-- networks, organizations) + 8B self-presentation & communication (emotional-expression
-- models, impression management, dramaturgy, verbal/nonverbal communication). Out of scope:
-- groupthink (Ch 8), reference group (Ch 6), symbolic interactionism & the sociological
-- paradigms/institutions/demographics (Ch 11), attribution/prejudice/stereotypes (Ch 10).
-- See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'psych_soc'
      AND title IN (
          'Social Interaction'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'psych_soc',
        'Psych/Soc',
        'social_interaction',
        'Social Interaction',
        'The elements of social structure — status (ascribed, achieved, master), role (with role conflict and role strain), and the types of groups (in-group/out-group, primary/secondary, Gemeinschaft/Gesellschaft), plus networks and organizations; and self-presentation — the models of emotional expression, display rules, impression management and its strategies, the dramaturgical approach with front and back stage, and verbal and nonverbal communication.',
        9
    )
    RETURNING id INTO deck;

    -- ── Status & Role ─────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'In sociology, a {{c1::status}} is a recognized social position a person occupies within a group or society, associated with a certain rank.',
     1),
    (deck, 1, 'cloze',
     'An {{c1::ascribed}} status is a social position held involuntarily, usually from birth — such as one''s race, sex, or family background.',
     1),
    (deck, 2, 'cloze',
     'An {{c1::achieved}} status is a social position a person gains through their own effort or choices, such as becoming a nurse or a spouse.',
     1),
    (deck, 3, 'cloze',
     'A {{c1::master status}} is the single status that most strongly shapes a person''s overall identity and how others treat them.',
     1),
    (deck, 4, 'cloze',
     'A {{c1::role}} is the set of behaviors and expectations that society attaches to a particular status.',
     1),
    (deck, 5, 'cloze',
     '{{c1::Role performance}} is the observable behavior a person actually displays while occupying a status, rather than the behavior merely expected of that status.',
     1),
    (deck, 6, 'cloze',
     'The {{c1::role partner}} is the other person a role is directed toward — for instance, a teacher''s role toward students, or a doctor''s toward patients.',
     1),
    (deck, 7, 'cloze',
     'A {{c1::role set}} is the entire collection of roles tied to one status.',
     1),
    (deck, 8, 'cloze',
     'When two or more of a person''s different roles pull against each other, the resulting tension is {{c1::role conflict}} — not role strain, which arises within a single role.',
     1),
    (deck, 9, 'cloze',
     'Competing or excessive demands within one role produce {{c1::role strain}}, whereas role conflict comes from incompatible demands of two different roles.',
     1);

    -- ── Groups & Networks ─────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
     'A {{c1::group}} is any collection of two or more people who interact with some regularity and share a sense of common identity.',
     1),
    (deck, 11, 'cloze',
     'A {{c1::peer}} group forms voluntarily among people of similar age, interests, or social status.',
     1),
    (deck, 12, 'cloze',
     'A {{c1::family}} group is the social group a person enters through birth, adoption, or marriage.',
     1),
    (deck, 13, 'cloze',
     'An {{c1::in-group}} is a group a person identifies with and feels they belong to, whereas an {{c1::out-group}} is one they do not identify with.',
     1),
    (deck, 14, 'cloze',
     'When an out-group competes with or opposes an in-group, the result is {{c1::group conflict}}.',
     1),
    (deck, 15, 'cloze',
     'A {{c1::primary}} group is small and defined by close, emotional, and enduring personal bonds, such as a family.',
     1),
    (deck, 16, 'cloze',
     'A {{c1::secondary}} group is larger, impersonal, goal-oriented, and often temporary, such as a group of coworkers.',
     1),
    (deck, 17, 'cloze',
     '{{c1::Gemeinschaft}} is a social grouping held together by shared beliefs, tradition, kinship, and close personal ties.',
     1),
    (deck, 18, 'cloze',
     '{{c1::Gesellschaft}} is a social grouping held together by self-interest and formal, goal-directed relationships.',
     1),
    (deck, 19, 'cloze',
     'A {{c1::social network}} is the web of relationships and ties that link people or groups to one another.',
     1),
    (deck, 20, 'cloze',
     'An {{c1::organization}} is a large, structured, deliberately formed body of people who work toward shared goals.',
     1);

    -- ── Emotional Expression & Self-Presentation ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 21, 'cloze',
     'The {{c1::basic}} model of emotional expression holds that certain emotions are universal and biologically based, with their facial expressions recognized across every culture.',
     1),
    (deck, 22, 'cloze',
     'The {{c1::social construction}} model of emotional expression holds that how emotion is displayed depends on the situational and interpersonal context rather than being biologically fixed.',
     1),
    (deck, 23, 'cloze',
     '{{c1::Display}} rules are the culturally specific norms that govern when, how, and how often it is acceptable to express a given emotion.',
     1),
    (deck, 24, 'cloze',
     'A {{c1::cultural syndrome}} is a shared pattern of values, beliefs, norms, and behaviors clustering around one theme, common to people who share a language and region.',
     1),
    (deck, 25, 'cloze',
     '{{c1::Impression management}} is the effort to control how one is perceived by others — the public self a person projects.',
     1),
    (deck, 26, 'cloze',
     'As an impression-management strategy, {{c1::self-disclosure}} means sharing factual information about oneself to shape a desired image.',
     1),
    (deck, 27, 'cloze',
     'The impression-management strategy of {{c1::managing appearances}} uses props, dress, and chosen associations to project a desired image.',
     1),
    (deck, 28, 'cloze',
     '{{c1::Ingratiation}} is the impression-management strategy of winning someone''s approval through flattery or conformity.',
     1),
    (deck, 29, 'cloze',
     '{{c1::Aligning actions}} is the strategy of offering excuses that make one''s questionable behavior seem acceptable.',
     1),
    (deck, 30, 'cloze',
     '{{c1::Alter-casting}} is the impression-management strategy of imposing a particular identity or role onto another person.',
     1);

    -- ── Dramaturgy & Communication ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 31, 'cloze',
     'The {{c1::dramaturgical}} approach, developed by {{c2::Goffman}}, likens social interaction to a staged performance in which people manage how others perceive them.',
     2),
    (deck, 32, 'cloze',
     'In dramaturgy, the {{c1::front stage}} is where a person performs for an audience and works to preserve a desired image.',
     1),
    (deck, 33, 'cloze',
     'In dramaturgy, the {{c1::back stage}} is where a person is away from the audience and free to drop the image they maintain elsewhere.',
     1),
    (deck, 34, 'cloze',
     '{{c1::Verbal}} communication conveys information through words, including spoken, written, and signed language.',
     1),
    (deck, 35, 'cloze',
     '{{c1::Nonverbal}} communication conveys meaning through body language, facial expressions, and prosody (tone of voice).',
     1),
    (deck, 36, 'cloze',
     '{{c1::Prosody}} is the tone, pitch, and rhythm of speech — the nonverbal vocal cues that carry meaning beyond the words spoken.',
     1),
    (deck, 37, 'cloze',
     'Beyond vocalizations, animal communication also relies on {{c1::body language, visual displays, and scents (pheromones)}}, and can occur between humans and animals.',
     1);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 38, 'cloze',
     'A {{c1::dyad}} (two members) is intimate but unstable, collapsing if either leaves; a {{c1::triad}} (three) is more stable because the third can {{c2::mediate or form a coalition}}.',
     2),
    (deck, 39, 'cloze',
     '{{c1::Role exit}} is disengaging from an identity-defining position and re-establishing oneself in a new one; the concept comes from sociologist Helen {{c2::Ebaugh}}.',
     2),
    (deck, 40, 'cloze',
     'Gendered display rules socialize women to {{c1::express emotions more openly}} and men to {{c1::suppress}} them.',
     1),
    (deck, 41, 'cloze',
     'On average, women are more accurate than men at {{c1::decoding others'' nonverbal emotional cues}}.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 42;
END $$;
