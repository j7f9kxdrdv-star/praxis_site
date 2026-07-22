-- ════════════════════════════════════════════════════════════════════
-- Psych/Soc Chapter 8 — Social Processes, Attitudes, and Behavior
-- ════════════════════════════════════════════════════════════════════
-- Section: psych_soc
-- Topic:   Psych/Soc
-- Subtopic slug: social_processes_attitudes_and_behavior
-- Sort order: 8
--
-- Coverage (AAMC-aligned order):
--    1. The Presence of Others
--    2. Group Decision-Making & Social Influence
--    3. Compliance Techniques
--    4. Culture & Socialization
--    5. Norms, Deviance & Social Control
--    6. Attitudes
--    7. Attitude Change
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Psychology 2e + Sociology 3e. Scope: AAMC 7B (presence of others, group decision-making,
-- norms & deviance, socialization) + 7C/8B (attitudes and attitude change). Out of scope:
-- the looking-glass self & identity formation (Ch 6); conditioning mechanics (Ch 3); brain
-- anatomy (Ch 1); motivation/emotion (Ch 5). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'psych_soc'
      AND title IN (
          'Social Processes, Attitudes, and Behavior',
          'Social Processes, Attitudes & Behavior'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'psych_soc',
        'Psych/Soc',
        'social_processes_attitudes_and_behavior',
        'Social Processes, Attitudes, and Behavior',
        'How the presence of others shapes behavior (social facilitation, deindividuation, the bystander effect, social loafing); group decision-making and social influence (group polarization, groupthink, conformity, obedience, compliance); culture, socialization, norms, deviance and its perspectives, and collective behavior; and attitudes — their components and the theories of attitude change including the elaboration likelihood model and cognitive dissonance.',
        8
    )
    RETURNING id INTO deck;

    -- ── The Presence of Others ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     '{{c1::Social facilitation}} is the tendency for the mere presence of other people to change how well an individual performs a task.',
     1),
    (deck, 1, 'cloze',
     'Social facilitation tends to help performance on {{c1::simple, well-learned}} tasks but hurt it on {{c1::difficult, unfamiliar}} tasks.',
     1),
    (deck, 2, 'cloze',
     '{{c1::Deindividuation}} occurs when anonymity within a group reduces a person''s self-awareness and sense of accountability, loosening normal self-restraint.',
     1),
    (deck, 3, 'cloze',
     'The {{c1::bystander effect}} is the finding that a person becomes less likely to help someone in distress when other people are also present.',
     1),
    (deck, 4, 'cloze',
     'The bystander effect operates through {{c1::diffusion of responsibility}}, in which each person assumes someone else in the group will step in to help.',
     1),
    (deck, 5, 'cloze',
     '{{c1::Social loafing}} is the tendency to invest less individual effort on a task when working in a group than when working alone.',
     1),
    (deck, 6, 'cloze',
     'Social loafing is the reduced individual effort exerted in a group because one member''s performance {{c1::cannot be evaluated separately}} from the group.',
     1),
    (deck, 7, 'cloze',
     '{{c1::Peer pressure}} is social influence to change one''s behavior that comes from friends and social groups rather than from an authority figure.',
     1);

    -- ── Group Decision-Making & Social Influence ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     '{{c1::Group polarization}} occurs when discussion among like-minded members pushes their shared position to a more extreme version of its original stance.',
     1),
    (deck, 9, 'cloze',
     '{{c1::Groupthink}} occurs when a group''s desire for harmony and consensus suppresses dissent, yielding poor decisions that ignore outside input.',
     1),
    (deck, 10, 'cloze',
     '{{c1::Conformity}} is adjusting one''s behavior or beliefs to match a peer group, not to satisfy a command from an authority figure.',
     1),
    (deck, 11, 'cloze',
     '{{c1::Asch''s}} line-judgment experiments demonstrated conformity: about three-quarters of participants matched the group''s obviously wrong answer at least once.',
     1),
    (deck, 12, 'cloze',
     '{{c1::Normative}} social influence is conforming in order to be liked and accepted by the group, not because you think the group is right.',
     1),
    (deck, 13, 'cloze',
     '{{c1::Informational}} social influence is conforming because you believe others are more competent and know the correct answer, not merely to gain acceptance.',
     1),
    (deck, 14, 'cloze',
     '{{c1::Obedience}} is changing one''s behavior in response to a direct command from a perceived authority figure, rather than to match a peer group.',
     1),
    (deck, 15, 'cloze',
     'In {{c1::Milgram''s}} shock experiments, about two-thirds of ordinary participants obeyed an experimenter''s orders to deliver what they believed were dangerous shocks to a stranger.',
     1),
    (deck, 16, 'cloze',
     'The mechanisms a community uses to encourage members to follow its norms — through sanctions and other pressures — are called {{c1::social control}}.',
     1),
    (deck, 17, 'cloze',
     'In Asch''s conformity studies, the presence of just {{c1::one other dissenter}} from the majority dropped conformity to nearly zero.',
     1);

    -- ── Compliance Techniques ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     '{{c1::Compliance}} is a change in behavior in response to a direct request from someone who holds no authority over you.',
     1),
    (deck, 19, 'cloze',
     'The {{c1::foot-in-the-door}} technique gains compliance by first securing agreement to a small request, then following it with a larger one.',
     1),
    (deck, 20, 'cloze',
     'The {{c1::door-in-the-face}} technique opens with an unreasonably large request that gets refused, then presents the smaller request the persuader actually wanted.',
     1),
    (deck, 21, 'cloze',
     'With the {{c1::lowball}} technique, a person agrees to an attractive offer, and only afterward does the seller reveal the hidden costs that make it less appealing.',
     1),
    (deck, 22, 'cloze',
     'The {{c1::that''s-not-all}} technique boosts compliance by adding an extra bonus or discount before the person has decided whether to accept.',
     1);

    -- ── Culture & Socialization ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 23, 'cloze',
     '{{c1::Culture}} refers to the shared beliefs, values, behaviors, and material objects that characterize a group or society.',
     1),
    (deck, 24, 'cloze',
     '{{c1::Assimilation}} occurs when a minority person or group gradually gives up its own cultural identity and blends into the dominant culture.',
     1),
    (deck, 25, 'cloze',
     '{{c1::Multiculturalism}} encourages several distinct groups to coexist and be equally valued within one community, rather than blending into a single dominant identity.',
     1),
    (deck, 26, 'cloze',
     'A {{c1::subculture}} is a group that sets itself apart from the dominant culture but still operates within it, whereas a counterculture actively opposes that culture''s values.',
     1),
    (deck, 27, 'cloze',
     '{{c1::Socialization}} is the lifelong process of learning a society''s norms, customs, values, and beliefs.',
     1),
    (deck, 28, 'cloze',
     'Primary socialization takes place during {{c1::childhood}}, mainly through the {{c1::family}}, whereas secondary socialization occurs later in the wider society.',
     1),
    (deck, 29, 'cloze',
     'The agents of socialization — the groups and institutions that teach us society''s ways — are {{c1::family, peers, school, religion, the workplace, and mass media}}.',
     1);

    -- ── Norms, Deviance & Social Control ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 30, 'cloze',
     '{{c1::Norms}} are a society''s shared rules and expectations that define which behaviors count as acceptable.',
     1),
    (deck, 31, 'cloze',
     '{{c1::Folkways}} are a culture''s everyday customs and routine conventions, and breaking one draws only mild disapproval.',
     1),
    (deck, 32, 'cloze',
     '{{c1::Mores}} are norms rooted in a group''s sense of right and wrong, so violating them provokes serious condemnation.',
     1),
    (deck, 33, 'cloze',
     '{{c1::Taboos}} are a society''s most serious prohibitions, and violating one typically provokes deep disgust or revulsion.',
     1),
    (deck, 34, 'cloze',
     '{{c1::Sanctions}} are the rewards and punishments a society uses to enforce its norms and encourage conformity.',
     1),
    (deck, 35, 'cloze',
     'Sanctions enforced through laws, fines, or arrest are {{c1::formal}} sanctions, whereas those delivered through everyday reactions like frowns or praise are {{c1::informal}} sanctions.',
     1),
    (deck, 36, 'cloze',
     '{{c1::Anomie}} is a condition of normlessness in which a society''s usual norms weaken or break down.',
     1),
    (deck, 37, 'cloze',
     '{{c1::Deviance}} is any behavior that violates a society''s accepted social norms.',
     1),
    (deck, 38, 'cloze',
     '{{c1::Differential association}} theory explains deviance as learned behavior, picked up from close companions who model and encourage rule-breaking.',
     1),
    (deck, 39, 'cloze',
     '{{c1::Labeling}} theory holds that an act is deviant not in itself, but because of how others react to the person who does it.',
     1),
    (deck, 40, 'cloze',
     '{{c1::Strain}} theory attributes deviance to the gap between society''s valued goals and the legitimate means people have to reach them.',
     1),
    (deck, 41, 'cloze',
     '{{c1::Stigma}} is a powerful negative label that discredits a person and spoils their standing in society.',
     1),
    (deck, 42, 'cloze',
     'Spontaneous, short-lived, noninstitutionalized activity such as fads, mass hysteria, and riots is called {{c1::collective behavior}}.',
     1);

    -- ── Attitudes ─────────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     'An {{c1::attitude}} is a learned tendency to evaluate a person, idea, or object either positively or negatively.',
     1),
    (deck, 44, 'cloze',
     'Attitudes have three components: the {{c1::affective}} part (feelings and emotions), the {{c1::behavioral}} part (how a person acts toward the object), and the {{c1::cognitive}} part (beliefs and thoughts).',
     1),
    (deck, 45, 'cloze',
     'Knowledge, ego expression, adaptation, and ego defense are the four categories described by the {{c1::functional attitudes}} theory.',
     1),
    (deck, 46, 'cloze',
     'In functional attitudes theory, the {{c1::knowledge}} function gives a person a consistent framework for making sense of the world.',
     1),
    (deck, 47, 'cloze',
     'In functional attitudes theory, the {{c1::ego-expressive}} function lets a person signal their identity and values to other people.',
     1),
    (deck, 48, 'cloze',
     'In functional attitudes theory, the {{c1::ego-defensive}} function helps a person cope with anxiety and maintain their self-esteem.',
     1),
    (deck, 49, 'cloze',
     'In functional attitudes theory, the {{c1::adaptation (adjustment)}} function helps a person earn rewards and win social approval.',
     1),
    (deck, 50, 'cloze',
     'The learning theory of attitudes holds that attitudes are acquired through {{c1::direct experience, direct instruction, and conditioning}}.',
     1);

    -- ── Attitude Change ───────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     'The {{c1::elaboration likelihood model}} explains persuasion through two routes that differ in how carefully a person thinks about a message.',
     1),
    (deck, 52, 'cloze',
     'In the elaboration likelihood model, the {{c1::central}} route to persuasion involves careful, effortful evaluation of an argument''s actual content, unlike the peripheral route.',
     1),
    (deck, 53, 'cloze',
     'In the elaboration likelihood model, the {{c1::peripheral}} route to persuasion relies on superficial cues such as a speaker''s attractiveness or credibility, not the argument''s merits.',
     1),
    (deck, 54, 'cloze',
     'In the elaboration likelihood model, attitude change produced by the central route tends to be {{c1::longer lasting}} than change produced by the peripheral route.',
     1),
    (deck, 55, 'cloze',
     'The {{c1::social cognitive theory}} of attitudes proposes that attitudes form by observing others, together with a person''s own factors and their environment.',
     1),
    (deck, 56, 'cloze',
     '{{c1::Cognitive dissonance}} is the mental discomfort that arises from holding two conflicting attitudes or from acting in a way that contradicts one''s attitude.',
     1),
    (deck, 57, 'cloze',
     'To reduce cognitive dissonance, a person typically {{c1::changes an attitude or belief to bring it in line with their behavior}}.',
     1),
    (deck, 58, 'cloze',
     'Attitude change depends on three kinds of factors: characteristics of the {{c1::message, the source, and the target audience}}.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 59;
END $$;
