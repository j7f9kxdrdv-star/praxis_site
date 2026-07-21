-- ════════════════════════════════════════════════════════════════════
-- Psych/Soc Chapter 4 — Cognition, Consciousness, and Language
-- ════════════════════════════════════════════════════════════════════
-- Section: psych_soc
-- Topic:   Psych/Soc
-- Subtopic slug: cognition_consciousness_and_language
-- Sort order: 4
--
-- Coverage (AAMC-aligned order):
--    1. Cognition & Cognitive Development
--    2. Problem-Solving & Decision-Making
--    3. Intelligence
--    4. Consciousness & Sleep
--    5. Hypnosis, Meditation & Consciousness-Altering Drugs
--    6. Language
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Psychology 2e. Scope: AAMC 6B cognition (info-processing, Piaget, problem-solving,
-- intelligence, attention) + Consciousness (sleep stages/cycles, dreaming, drugs) +
-- Language (components, development theories, aphasia syndromes). Out of scope: brain
-- anatomy incl. language-AREA locations, pineal/melatonin & EEG-as-tool, general
-- neurotransmitter functions (Ch 1); sensation/perception (Ch 2); learning & memory
-- mechanisms (Ch 3); emotion/stress theories (later). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'psych_soc'
      AND title IN (
          'Cognition, Consciousness, and Language',
          'Cognition, Consciousness & Language'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'psych_soc',
        'Psych/Soc',
        'cognition_consciousness_and_language',
        'Cognition, Consciousness, and Language',
        'The information-processing model and Piaget''s stages of cognitive development; attention; problem-solving and decision-making with heuristics and biases; theories of intelligence; states of consciousness including the sleep stages, cycles, and dreaming; hypnosis, meditation, and the major classes of consciousness-altering drugs with the reward pathway; and language — its components, theories of development, and the aphasia syndromes.',
        4
    )
    RETURNING id INTO deck;

    -- ── Cognition & Cognitive Development ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'The {{c1::information-processing}} model likens the mind to a computer that encodes, stores, and retrieves data.',
     1),
    (deck, 1, 'cloze',
     'Piaget''s four stages of cognitive development, in order, are {{c1::sensorimotor, preoperational, concrete operational, and formal operational}}.',
     1),
    (deck, 2, 'cloze',
     'Piaget''s first stage, the {{c1::sensorimotor}} stage, lasts from birth to about {{c1::age 2}}.',
     1),
    (deck, 3, 'cloze',
     'The sensorimotor stage ends once an infant develops {{c1::object permanence}} — grasping that things still exist when out of sight.',
     1),
    (deck, 4, 'cloze',
     'Piaget''s second stage, the {{c1::preoperational}} stage, spans roughly ages {{c1::2 to 7}}.',
     1),
    (deck, 5, 'cloze',
     'In the preoperational stage, a child starts to use {{c1::symbolic}} thought, letting one object stand for another in pretend play.',
     1),
    (deck, 6, 'cloze',
     '{{c1::Egocentrism}}, a hallmark of the preoperational child, is the inability to take another person''s point of view.',
     1),
    (deck, 7, 'cloze',
     'Piaget''s third stage, the {{c1::concrete operational}} stage, runs from about ages {{c1::7 to 11}}.',
     1),
    (deck, 8, 'cloze',
     'In the concrete operational stage, children finally master {{c1::conservation}} — knowing a quantity is unchanged when only its appearance changes.',
     1),
    (deck, 9, 'cloze',
     'Piaget''s fourth stage, the {{c1::formal operational}} stage, begins around {{c1::age 11}} and continues into adulthood.',
     1),
    (deck, 10, 'cloze',
     'The formal operational stage brings the capacity for {{c1::abstract and hypothetical}} reasoning.',
     1),
    (deck, 11, 'cloze',
     'With normal aging, {{c1::mild}} cognitive decline is expected, whereas {{c1::marked}} decline points to an underlying disorder.',
     1),
    (deck, 12, 'cloze',
     'Cognitive development is shaped by the interacting influences of {{c1::heredity, environment, and culture}}.',
     1),
    (deck, 13, 'cloze',
     '{{c1::Selective}} attention means concentrating on one stimulus while still monitoring whether others need a response.',
     1),
    (deck, 14, 'cloze',
     'By relying on automatic processing, {{c1::divided}} attention lets someone handle several tasks at once.',
     1);

    -- ── Problem-Solving & Decision-Making ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'A {{c1::mental set}} is the tendency to keep tackling a new problem with a strategy that worked before, even when it now blocks a better solution.',
     1),
    (deck, 16, 'cloze',
     '{{c1::Functional fixedness}} is the inability to imagine using an object for anything other than its usual, intended purpose.',
     1),
    (deck, 17, 'cloze',
     'An {{c1::algorithm}} is a step-by-step procedure that, when followed exactly, is guaranteed to reach a correct solution.',
     1),
    (deck, 18, 'cloze',
     '{{c1::Trial and error}} is a problem-solving approach in which you attempt different solutions one after another until one finally works.',
     1),
    (deck, 19, 'cloze',
     '{{c1::Deductive}} reasoning starts from a general rule or premise and applies it to reach a specific, logically certain conclusion.',
     1),
    (deck, 20, 'cloze',
     '{{c1::Inductive}} reasoning starts from specific observations and builds them into a broad, general rule.',
     1),
    (deck, 21, 'cloze',
     'A {{c1::heuristic}} is a mental shortcut or rule of thumb that speeds up a decision but does not guarantee the best answer.',
     1),
    (deck, 22, 'cloze',
     'The {{c1::availability}} heuristic judges how likely an event is by how quickly relevant examples spring to mind.',
     1),
    (deck, 23, 'cloze',
     'The {{c1::representativeness}} heuristic judges likelihood by how closely a case matches a typical prototype or stereotype.',
     1),
    (deck, 24, 'cloze',
     '{{c1::Overconfidence}} is the tendency to place too much faith in the accuracy of your own judgments and knowledge.',
     1),
    (deck, 25, 'cloze',
     '{{c1::Belief perseverance}} is the tendency to hold on to an idea even after evidence has clearly contradicted it.',
     1),
    (deck, 26, 'cloze',
     '{{c1::Confirmation bias}} is the tendency to seek out and favor evidence that supports what you already believe, while ignoring what contradicts it.',
     1);

    -- ── Intelligence ──────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 27, 'cloze',
     'The theory that each person holds at least eight relatively independent intelligences was proposed by the psychologist {{c1::Gardner}}.',
     1),
    (deck, 28, 'cloze',
     'The single-factor view of intelligence holds that one broad ability, which Spearman labeled {{c1::g}}, underlies performance on nearly all mental tasks.',
     1),
    (deck, 29, 'cloze',
     'Gardner counts abilities such as {{c1::musical}} and {{c1::bodily-kinesthetic}} skill as full, separate intelligences, alongside linguistic and logical-mathematical ability.',
     1),
    (deck, 30, 'cloze',
     'Gardner''s interpersonal and intrapersonal intelligences are often merged into a single construct called {{c1::emotional intelligence}}.',
     1),
    (deck, 31, 'cloze',
     'Individual differences in intelligence are attributed to a combination of {{c1::genetics and environment}}, not to any single cause.',
     1);

    -- ── Consciousness & Sleep ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     'On an EEG, a brain that is awake and actively engaged is dominated by {{c1::beta}} waves, the fastest, lowest-amplitude pattern.',
     1),
    (deck, 33, 'cloze',
     'When someone is awake but relaxed with the eyes closed and drifting toward sleep, the EEG slows into {{c1::alpha}} waves.',
     1),
    (deck, 34, 'cloze',
     'The lightest, transitional first stage of NREM sleep is marked by the emergence of {{c1::theta}} waves.',
     1),
    (deck, 35, 'cloze',
     'Stage 2 NREM sleep is identified on EEG by two brief events: {{c1::sleep spindles}} and {{c1::K-complexes}}.',
     1),
    (deck, 36, 'cloze',
     'The deepest NREM sleep, stages 3 and 4, shows large {{c1::delta}} waves and is therefore also called {{c1::slow-wave}} sleep.',
     1),
    (deck, 37, 'cloze',
     'REM sleep is nicknamed {{c1::paradoxical}} sleep because its EEG looks almost like an awake brain even though the body is soundly asleep.',
     1),
    (deck, 38, 'cloze',
     'Most vivid dreaming takes place during {{c1::REM}} sleep.',
     1),
    (deck, 39, 'cloze',
     'During REM sleep the voluntary muscles are essentially paralyzed, a state called {{c1::atonia}}.',
     1),
    (deck, 40, 'cloze',
     'One complete pass through the sleep stages takes roughly {{c1::90 minutes}}, after which the cycle begins again.',
     1),
    (deck, 41, 'cloze',
     'As the night progresses, each successive {{c1::REM}} period grows longer than the one before it.',
     1),
    (deck, 42, 'cloze',
     'The sleep-wake cycle is governed by the body''s {{c1::circadian}} rhythm, an internal clock running on an approximately {{c1::24-hour}} period.',
     1),
    (deck, 43, 'cloze',
     'A rise in the hormone {{c1::cortisol}} during the early morning hours helps push the body toward waking.',
     1),
    (deck, 44, 'cloze',
     'Slow-wave (deep NREM) sleep is thought to consolidate {{c1::declarative}} memories, whereas REM sleep consolidates {{c1::procedural}} memories.',
     1),
    (deck, 45, 'cloze',
     'Sleep-wake disorders split into {{c1::dyssomnias}}, which disturb the amount, timing, or quality of sleep, and {{c1::parasomnias}}, which involve abnormal behaviors during sleep.',
     1),
    (deck, 46, 'cloze',
     'Three classic dyssomnias — disorders of how much or how well you sleep — are {{c1::insomnia}}, {{c1::narcolepsy}}, and {{c1::sleep apnea}}.',
     1),
    (deck, 47, 'cloze',
     'Two common parasomnias — abnormal events that intrude on sleep — are {{c1::night terrors}} and {{c1::sleepwalking, or somnambulism}}.',
     1);

    -- ── Hypnosis, Meditation & Consciousness-Altering Drugs ───────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 48, 'cloze',
     'Hypnosis is a state of heightened {{c1::suggestibility}} in which the person otherwise appears to remain in control of their own behavior.',
     1),
    (deck, 49, 'cloze',
     'Meditation is the practice of {{c1::quieting or clearing the mind}}, often used to relieve anxiety and reach relaxed awareness.',
     1),
    (deck, 50, 'cloze',
     'The depressant drug class includes {{c1::alcohol, barbiturates, and benzodiazepines}}, all of which suppress central nervous system activity.',
     1),
    (deck, 51, 'cloze',
     'Depressants quiet the body by acting as agonists that boost the activity of the neurotransmitter {{c1::GABA}}.',
     1),
    (deck, 52, 'cloze',
     'The stimulant class includes {{c1::amphetamines, cocaine, and ecstasy (MDMA)}}, drugs that ramp up overall neural activity.',
     1),
    (deck, 53, 'cloze',
     'Stimulants heighten arousal by raising the synaptic levels of {{c1::dopamine, norepinephrine, and serotonin}}.',
     1),
    (deck, 54, 'cloze',
     'Opioids such as {{c1::heroin, morphine, and oxycodone}} relieve pain and produce intense euphoria.',
     1),
    (deck, 55, 'cloze',
     'A lethal opioid overdose most commonly causes death through {{c1::respiratory depression}}.',
     1),
    (deck, 56, 'cloze',
     'Hallucinogens such as {{c1::LSD, mescaline, and psilocybin}} produce profound distortions of perception and sensory experience.',
     1),
    (deck, 57, 'cloze',
     'The primary psychoactive ingredient in marijuana is {{c1::THC (tetrahydrocannabinol)}}.',
     1),
    (deck, 58, 'cloze',
     'Marijuana resists simple classification because it can produce {{c1::depressant, stimulant, and hallucinogenic}} effects at the same time.',
     1),
    (deck, 59, 'cloze',
     'Drug addiction is driven chiefly by the brain''s {{c1::mesolimbic}} reward pathway.',
     1),
    (deck, 60, 'cloze',
     'The main neurotransmitter signaling along the mesolimbic reward pathway is {{c1::dopamine}}.',
     1),
    (deck, 61, 'cloze',
     'The mesolimbic reward pathway links three structures: the {{c1::ventral tegmental area, nucleus accumbens, and medial forebrain bundle}}.',
     1);

    -- ── Language ──────────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 62, 'cloze',
     'Of the five components of language, {{c1::phonology}} covers the speech sounds that make up spoken words.',
     1),
    (deck, 63, 'cloze',
     '{{c1::Morphology}} is the language component covering how words are built, such as adding ''-s'' to form plurals or ''-ed'' to mark past tense.',
     1),
    (deck, 64, 'cloze',
     '{{c1::Semantics}} is the component of language concerned with the meaning of words.',
     1),
    (deck, 65, 'cloze',
     '{{c1::Syntax}} is the component of language covering the rules for the order in which words are arranged into sentences.',
     1),
    (deck, 66, 'cloze',
     '{{c1::Pragmatics}} is the component of language describing how word choice and delivery change with the social context.',
     1),
    (deck, 67, 'cloze',
     'Chomsky maintained that the ability to acquire language is {{c1::innate}}, a stance known as the {{c1::nativist (biological)}} theory.',
     1),
    (deck, 68, 'cloze',
     'To explain how children learn language so quickly, Chomsky proposed an inborn mechanism he called the {{c1::language acquisition device (LAD)}}.',
     1),
    (deck, 69, 'cloze',
     'The {{c1::learning (behaviorist)}} theory, proposed by {{c1::Skinner}}, holds that children acquire language through reinforcement and feedback from caregivers.',
     1),
    (deck, 70, 'cloze',
     'The {{c1::social interactionist}} theory attributes language development to a child''s fundamental desire to communicate and bond with others.',
     1),
    (deck, 71, 'cloze',
     'The {{c1::Whorfian (linguistic relativity)}} hypothesis proposes that the words and grammatical structures a person uses shape how they perceive and reason about the world.',
     1),
    (deck, 72, 'cloze',
     'In Broca''s aphasia, speech is {{c1::nonfluent and effortful}}, though comprehension remains intact.',
     1),
    (deck, 73, 'cloze',
     'In {{c1::Wernicke''s}} aphasia, speech is {{c2::fluent but nonsensical}}, and the person''s comprehension is impaired.',
     2),
    (deck, 74, 'cloze',
     '{{c1::Conduction}} aphasia, from damage to the {{c1::arcuate fasciculus}}, spares comprehension and speech production yet destroys the ability to repeat words.',
     1),
    (deck, 75, 'cloze',
     'After {{c1::babbling}} and first words around age 1, toddlers reach {{c2::telegraphic (two-word)}} speech near age 2.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 76;
END $$;
