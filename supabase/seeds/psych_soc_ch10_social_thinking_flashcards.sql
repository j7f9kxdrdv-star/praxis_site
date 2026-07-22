-- Praxis Prep — Psych/Soc Chapter 10: Social Thinking
-- v6-compliant flashcard deck (46 cards)
-- Subtopics: 10.1 Social Behavior (22), 10.2 Social Perception and Attribution (13),
-- 10.3 Stereotypes, Prejudice, and Discrimination (11). All three subtopics flagged
-- high-yield in the source textbook.
-- Source-laundered against OpenStax Psychology 2e (Ch. 9 Lifespan Development for
-- attachment; Ch. 12 Social Psychology for attribution, biases, attraction, prejudice),
-- OpenStax Sociology 3e (Ch. 1 cultural relativism / ethnocentrism; Ch. 11 discrimination
-- types), and Fiske, Cuddy, Glick, & Xu (2002) for the Stereotype Content Model.
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Social Thinking',
            'Psych/Soc Chapter 10: Social Thinking',
            'Behavioral Sciences Chapter 10: Social Thinking'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Social Thinking',
        'Psych/Soc Chapter 10: Social Thinking',
        'Behavioral Sciences Chapter 10: Social Thinking'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'psych_soc',
        'Psych/Soc',
        'social thinking',
        'Social Thinking',
        'Social behavior (attraction, aggression, all four attachment styles, social support, mating systems and mate choice, altruism, game theory and inclusive fitness); social perception and attribution (perception components, impression biases like primacy/recency/halo/just-world, self-serving bias, in-group/out-group, attribution theory with Kelley''s three cues, correspondent inference, fundamental attribution error, individualist vs collectivist cultural attribution); and stereotypes, prejudice, and discrimination (Stereotype Content Model with warmth and competence, self-fulfilling prophecy, stereotype threat, prejudice, power/prestige/class, ethnocentrism vs cultural relativism, individual vs institutional discrimination).',
        10
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 10.1 Social Behavior (cards 1–22) ★ high-yield
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'Four major factors that influence interpersonal attraction: {{c1::similarity}}, {{c1::self-disclosure}}, {{c1::reciprocity}}, and {{c1::proximity}}.',
        1),
    (deck, 1, 'cloze',
        'Physical attractiveness is shaped by {{c1::facial symmetry}} and proportions close to the {{c2::golden ratio (≈ 1.618)}}.',
        2),
    (deck, 2, 'cloze',
        '{{c1::Self-disclosure}} is sharing one''s fears, thoughts, and goals with another person and being met with {{c2::non-judgmental empathy}}; it must be {{c3::reciprocal}} to deepen attraction.',
        3),
    (deck, 3, 'cloze',
        '{{c1::Reciprocal liking}} — people tend to like others more when they {{c2::believe the other person likes them}}.',
        2),
    (deck, 4, 'cloze',
        '{{c1::Proximity}} (physical closeness) increases attraction in part through the {{c2::mere exposure (familiarity) effect}} — we prefer stimuli we have encountered more often.',
        2),
    (deck, 5, 'cloze',
        '{{c1::Aggression}} is a behavior intended to {{c2::cause harm or increase social dominance}}; most displays end with {{c3::threat and withdrawal}} rather than actual bodily harm.',
        3),
    (deck, 6, 'cloze',
        'The {{c1::amygdala}} signals threat and {{c2::increases aggression}} when activated; the {{c3::prefrontal cortex}} reduces emotional reactivity and impulsiveness, dampening aggression.',
        3),
    (deck, 7, 'cloze',
        'Higher {{c1::testosterone}} is linked to more aggressive behavior, and the {{c2::cognitive neoassociation model}} states we are more likely to respond aggressively when feeling {{c3::negative emotions}}.',
        3),
    (deck, 8, 'cloze',
        'Exposure to {{c1::violent behavior}} (witnessed or via media) can {{c2::contribute to aggressive behavior}} in observers.',
        2),
    (deck, 9, 'cloze',
        '{{c1::Attachment}} is an emotional bond between a caregiver and a child that begins to develop during {{c2::infancy}}, formed through {{c3::sensitive and responsive}} caregiving.',
        3),
    (deck, 10, 'cloze',
        '{{c1::Secure attachment}} — caregiver is consistent; child explores freely and {{c2::returns to the caregiver as a secure base}}.',
        2),
    (deck, 11, 'cloze',
        '{{c1::Avoidant attachment}} — caregiver shows little response to distress; child shows {{c2::no preference between caregiver and stranger}} and {{c3::little distress or relief}} when the caregiver leaves or returns.',
        3),
    (deck, 12, 'cloze',
        '{{c1::Ambivalent (anxious-ambivalent) attachment}} — caregiver responds {{c2::inconsistently}}; child is highly distressed at separation but shows {{c3::mixed (push–pull) reactions}} when the caregiver returns.',
        3),
    (deck, 13, 'cloze',
        '{{c1::Disorganized attachment}} — child shows {{c2::no clear behavioral pattern}} (dazed, frozen, mix of avoidance and approach); often associated with {{c3::erratic or abusive caregiving}}.',
        3),
    (deck, 14, 'cloze',
        'Five types of social support: {{c1::emotional}}, {{c1::esteem}}, {{c1::material (tangible)}}, {{c1::informational}}, and {{c1::network}} support.',
        1),
    (deck, 15, 'cloze',
        'Four mating-system categories: {{c1::monogamy}} (one exclusive partner), {{c1::polygyny}} (one male with multiple females), {{c1::polyandry}} (one female with multiple males), and {{c1::promiscuity}} (mating without exclusivity).',
        1),
    (deck, 16, 'cloze',
        '{{c1::Mate choice (intersexual selection)}} confers {{c2::direct benefits}} (material support, protection) and {{c3::indirect benefits}} (better offspring survival via good genes).',
        3),
    (deck, 17, 'cloze',
        '{{c1::Indicator traits}} are observable features that signal an organism''s overall {{c2::health and fitness}}, increasing its attractiveness to potential mates.',
        2),
    (deck, 18, 'cloze',
        '{{c1::Fisherian (runaway) selection}} is a {{c2::positive feedback loop}} in which a trait becomes more and more {{c3::exaggerated}} over generations, even when it offers no survival benefit (or a small cost).',
        3),
    (deck, 19, 'cloze',
        '{{c1::Altruism}} is helping behavior that benefits another at a cost to the self; the {{c2::empathy-altruism hypothesis}} proposes that we help others when we feel {{c3::empathy for them}}, regardless of the cost.',
        3),
    (deck, 20, 'cloze',
        '{{c1::Game theory}} models social decisions; an {{c2::evolutionary stable strategy (ESS)}} is one that, once adopted, natural selection prevents from being displaced. The four interaction outcomes are {{c3::altruism, cooperation, spite, and selfishness}}.',
        3),
    (deck, 21, 'cloze',
        '{{c1::Inclusive fitness}} measures an organism''s reproductive success as the sum of its {{c2::own offspring plus the offspring of relatives}} that share its genes — explaining why altruism toward kin can be favored by selection.',
        2);

    -- ============================================================
    -- 10.2 Social Perception and Attribution (cards 23–35) ★ high-yield
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 22, 'cloze',
        '{{c1::Social perception (social cognition)}} provides the tools to make judgments about others; its three components are the {{c2::perceiver}}, the {{c2::target}}, and the {{c2::situation}}.',
        2),
    (deck, 23, 'cloze',
        '{{c1::Primacy effect}} — first impressions weigh more heavily than later ones; {{c1::recency effect}} — the {{c2::most recent}} information weighs more heavily.',
        2),
    (deck, 24, 'cloze',
        'The {{c1::halo effect}} is a cognitive bias in which an overall positive impression of someone makes specific traits also {{c2::seem positive}} (and vice versa for an overall negative impression).',
        2),
    (deck, 25, 'cloze',
        'The {{c1::just-world hypothesis}} — the belief that good things happen to good people and bad things happen to bad people — can lead to {{c2::victim blaming}} because it denies the possibility of innocent victims.',
        2),
    (deck, 26, 'cloze',
        '{{c1::Self-serving bias}} — attributing one''s own successes to {{c2::internal factors}} (ability, effort) and one''s failures to {{c3::external factors}} (bad luck, circumstances); it protects self-esteem.',
        3),
    (deck, 27, 'cloze',
        '{{c1::In-group bias}} — viewing members of one''s own group {{c2::more favorably}}; {{c1::out-group bias}} — viewing those outside one''s group {{c2::more harshly}}.',
        2),
    (deck, 28, 'cloze',
        '{{c1::Attribution theory}} describes how we {{c2::infer the causes of other people''s behavior}}.',
        2),
    (deck, 29, 'cloze',
        '{{c1::Dispositional (internal) attributions}} explain behavior by the person''s {{c2::beliefs, attitudes, or personality}}; {{c1::situational (external) attributions}} explain it by features of the {{c2::surrounding context (norms, threats, peer pressure)}}.',
        2),
    (deck, 30, 'cloze',
        'Three attribution cues used to infer causes (Kelley''s covariation model): {{c1::consistency}} (does the person behave this way over time?), {{c1::consensus}} (do others behave the same way?), and {{c1::distinctiveness}} (does the person behave this way only in certain situations?).',
        1),
    (deck, 31, 'cloze',
        '{{c1::Correspondent inference theory}} — when someone''s behavior is {{c2::unexpected}} and {{c3::directly affects us}}, we tend to attribute it to disposition.',
        3),
    (deck, 32, 'cloze',
        'The {{c1::fundamental attribution error}} is our bias toward {{c2::dispositional}} explanations and away from {{c3::situational}} ones when judging others'' behavior.',
        3),
    (deck, 33, 'cloze',
        '{{c1::Attribute substitution}} — when faced with a complex judgment, we substitute a {{c2::simpler heuristic}} that approximately answers a related question.',
        2),
    (deck, 34, 'cloze',
        '{{c1::Individualist}} cultures emphasize personal goals and independence, and their members make {{c2::more dispositional attributions}} (more fundamental attribution error); {{c1::collectivist}} cultures emphasize group interdependence and make {{c2::more situational attributions}}.',
        2);

    -- ============================================================
    -- 10.3 Stereotypes, Prejudice, and Discrimination (cards 36–46) ★ high-yield
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
        '{{c1::Stereotypes}} are expectations and impressions about the {{c2::characteristics of members of a group}}; their cognitive purpose is to {{c3::categorize and simplify a complex social world}}.',
        3),
    (deck, 36, 'cloze',
        'The {{c1::Stereotype Content Model (SCM)}} classifies stereotypes along two dimensions: {{c2::warmth}} (intent — is the group a friend or competitor?) and {{c3::competence}} (ability to act on that intent).',
        3),
    (deck, 37, 'cloze',
        'Four SCM quadrants: {{c1::admiration}} (high warmth, high competence — in-group), {{c1::paternalistic / pity}} (high warmth, low competence — elderly, disabled), {{c1::envious}} (low warmth, high competence — rich, out-group competitors), and {{c1::contemptuous}} (low warmth, low competence — homeless, poor).',
        1),
    (deck, 38, 'cloze',
        '{{c1::Self-fulfilling prophecy}} — a stereotype creates expectations that cause the {{c2::target to behave in line with the expectation}}, confirming it.',
        2),
    (deck, 39, 'cloze',
        '{{c1::Stereotype threat}} — anxiety about confirming a negative stereotype about one''s group {{c2::reduces performance}} on the relevant task through stress and self-monitoring.',
        2),
    (deck, 40, 'cloze',
        '{{c1::Prejudice}} is an {{c2::irrational positive or negative attitude}} toward a person or group formed {{c3::before any actual experience}} with them.',
        3),
    (deck, 41, 'cloze',
        'Three social forces that drive prejudice: {{c1::power}} (control over resources), {{c1::prestige}} (respect from others), and {{c1::class}} (socioeconomic status).',
        1),
    (deck, 42, 'cloze',
        '{{c1::Ethnocentrism}} — judging another culture by the standards of one''s own; {{c1::cultural relativism}} — judging a culture {{c2::on its own terms}}, in the context of its own values and norms.',
        2),
    (deck, 43, 'cloze',
        '{{c1::Discrimination}} is a {{c2::behavior}} that treats individuals differently based on group membership; importantly, {{c3::prejudice does not always lead to discrimination}} (and discrimination can occur without conscious prejudice).',
        3),
    (deck, 44, 'cloze',
        '{{c1::Individual discrimination}} — one person treating another unfairly based on {{c2::group membership}}.',
        2),
    (deck, 45, 'cloze',
        '{{c1::Institutional discrimination}} — discrimination {{c2::built into the structure}} of an organization or society, affecting entire groups regardless of any individual''s prejudice.',
        2),
    (deck, 46, 'cloze',
        '{{c1::Foraging}} is the animal behavior of searching for, capturing, and consuming food resources in the environment.',
        1),
    (deck, 47, 'cloze',
        '{{c1::Implicit personality theory}} is the set of assumptions a person holds about how different personality traits and behaviors tend to occur together in others.',
        1),
    (deck, 48, 'cloze',
        'A reliance on {{c1::central traits}} is the tendency to organize impressions of others around the characteristics that matter most to the perceiver.',
        1);

    RAISE NOTICE 'Seeded deck % with 49 cards.', deck;
END $$;
