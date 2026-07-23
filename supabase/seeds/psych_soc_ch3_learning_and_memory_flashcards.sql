-- ════════════════════════════════════════════════════════════════════
-- Psych/Soc Chapter 3 — Learning and Memory
-- ════════════════════════════════════════════════════════════════════
-- Section: psych_soc
-- Topic:   Psych/Soc
-- Subtopic slug: learning_and_memory
-- Sort order: 3
--
-- Coverage (AAMC-aligned order):
--    1. Habituation & Associative Learning
--    2. Classical Conditioning
--    3. Operant Conditioning
--    4. Observational Learning & Biological Factors
--    5. Memory: Encoding & Storage
--    6. Memory: Retrieval & Forgetting
--    7. Neurobiology of Learning & Memory
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Psychology 2e. Scope: AAMC 7C Learning (habituation, classical/operant/observational
-- conditioning) + AAMC 6B Memory (encoding, storage, retrieval, forgetting) + the
-- synaptic-change/LTP bridge. Out of scope: brain anatomy & neurotransmitters (Ch 1),
-- sensation/perception (Ch 2), cognition/consciousness/language (Ch 4), and attitude-
-- change & emotion theories (later chapters). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'psych_soc'
      AND title IN (
          'Learning and Memory',
          'Learning & Memory'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'psych_soc',
        'Psych/Soc',
        'learning_and_memory',
        'Learning and Memory',
        'Types of learning from habituation through associative learning; classical conditioning and its processes; operant conditioning with reinforcement, punishment, and reinforcement schedules; observational learning and its biological basis; memory encoding and the sensory/short-term/working/long-term storage stages; retrieval, cues, and forgetting through decay and interference; and the neurobiology of learning and memory including neuroplasticity and long-term potentiation.',
        3
    )
    RETURNING id INTO deck;

    -- ── Habituation & Associative Learning ────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'Learning is a relatively {{c1::permanent}} change in behavior (or knowledge) that results from {{c2::experience}}.',
     2),
    (deck, 1, 'cloze',
     '{{c1::Habituation}} is the gradual weakening of a response after the same stimulus is presented over and over.',
     1),
    (deck, 2, 'cloze',
     '{{c1::Dishabituation}} is the sudden recovery of a response to the original stimulus after a new, different stimulus is introduced.',
     1),
    (deck, 3, 'cloze',
     'Habituation is a form of {{c1::non-associative}} learning, whereas classical and operant conditioning are forms of {{c1::associative}} learning.',
     1),
    (deck, 4, 'cloze',
     '{{c1::Associative}} learning is the process of connecting two events — two stimuli, or a behavior and its consequence — that occur together.',
     1);

    -- ── Classical Conditioning ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 5, 'cloze',
     '{{c1::Classical conditioning}} is learning to associate a neutral stimulus with an unconditioned stimulus that already triggers an automatic, reflexive response.',
     1),
    (deck, 6, 'cloze',
     'Before any pairing takes place, a {{c1::neutral stimulus}} does not naturally elicit the reflexive response on its own.',
     1),
    (deck, 7, 'cloze',
     'With no learning required, an {{c1::unconditioned stimulus}} automatically produces an {{c1::unconditioned response}}.',
     1),
    (deck, 8, 'cloze',
     'After repeated pairing, the once-neutral cue becomes a {{c1::conditioned stimulus}}, and what it now elicits on its own is the {{c1::conditioned response}}.',
     1),
    (deck, 9, 'cloze',
     '{{c1::Acquisition}} is the initial period of learning, when the neutral stimulus first becomes connected to the unconditioned stimulus.',
     1),
    (deck, 10, 'cloze',
     '{{c1::Extinction}} is the gradual fading of the conditioned response when the conditioned stimulus is presented repeatedly without the unconditioned stimulus.',
     1),
    (deck, 11, 'cloze',
     '{{c1::Spontaneous recovery}} is the reappearance of a previously extinguished conditioned response after a period of rest.',
     1),
    (deck, 12, 'cloze',
     'In {{c1::stimulus generalization}}, stimuli that resemble the conditioned stimulus also come to elicit the conditioned response.',
     1),
    (deck, 13, 'cloze',
     'In {{c1::stimulus discrimination}}, the organism responds only to the specific conditioned stimulus and not to other, similar stimuli.',
     1),
    (deck, 14, 'cloze',
     'For conditioning to take hold, the neutral stimulus is normally presented {{c1::just before}} the unconditioned stimulus, with only a brief gap between them.',
     1);

    -- ── Operant Conditioning ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'Operant conditioning modifies {{c1::voluntary}} behaviors, whereas classical conditioning acts on {{c1::reflexive}} responses.',
     1),
    (deck, 16, 'cloze',
     'In operant conditioning, {{c1::reinforcement}} makes a behavior more likely to recur, while {{c1::punishment}} makes it less likely to recur.',
     1),
    (deck, 17, 'cloze',
     'In operant-conditioning terms, {{c1::positive}} labels a procedure that adds a stimulus, whereas {{c1::negative}} labels one that removes a stimulus.',
     1),
    (deck, 18, 'cloze',
     'Adding a desirable stimulus to strengthen a behavior — like giving a dog a treat right after it sits — is {{c1::positive reinforcement}}.',
     1),
    (deck, 19, 'cloze',
     'A car''s seatbelt chime that shuts off the instant you buckle up, which makes you more likely to buckle next time, illustrates {{c1::negative reinforcement}}.',
     1),
    (deck, 20, 'cloze',
     'Adding an unpleasant stimulus to weaken a behavior — such as scolding a student who is texting in class — is {{c1::positive punishment}}.',
     1),
    (deck, 21, 'cloze',
     'Taking away a child''s favorite toy after misbehavior, which then decreases the misbehavior, is {{c1::negative punishment}}.',
     1),
    (deck, 22, 'cloze',
     'A {{c1::primary}} reinforcer satisfies a biological need on its own with no learning required, as food and water do.',
     1),
    (deck, 23, 'cloze',
     'A {{c1::secondary}}, or {{c1::conditioned}}, reinforcer has no innate value and becomes rewarding only through association with other reinforcers, as money does.',
     1),
    (deck, 24, 'cloze',
     '{{c1::Shaping}} teaches a complex behavior by reinforcing successive approximations — steps that move progressively closer to the target behavior.',
     1),
    (deck, 25, 'cloze',
     'On {{c1::ratio}} schedules reinforcement depends on the number of responses made, whereas on {{c1::interval}} schedules it depends on the amount of time elapsed.',
     1),
    (deck, 26, 'cloze',
     'Among the four partial reinforcement schedules, {{c1::variable-ratio}} produces the highest, steadiest response rate and the greatest resistance to extinction.',
     1),
    (deck, 27, 'cloze',
     '{{c1::Escape}} learning ends an aversive stimulus that is already present, while {{c1::avoidance}} learning prevents the aversive stimulus before it begins.',
     1);

    -- ── Observational Learning & Biological Factors ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 28, 'cloze',
     'Acquiring a new behavior by watching and then copying someone else is called {{c1::observational learning}}, or {{c1::modeling}}.',
     1),
    (deck, 29, 'cloze',
     'In observational learning, a person can pick up a behavior {{c1::without ever being reinforced}} for it, simply by watching a model.',
     1),
    (deck, 30, 'cloze',
     'A {{c1::mirror neuron}} fires both when an individual performs an action and when it watches someone else perform that same action.',
     1),
    (deck, 31, 'cloze',
     'Feeling an emotion simply by observing another person feel it is called {{c1::vicarious}} emotion, an effect linked to mirror neurons.',
     1),
    (deck, 32, 'cloze',
     'Because of {{c1::biological predispositions}}, animals learn some stimulus-response associations far more readily than others.',
     1),
    (deck, 33, 'cloze',
     '{{c1::Instinctive drift}} is an animal''s tendency to revert toward its evolved, species-typical behaviors, disrupting a previously conditioned response.',
     1),
    (deck, 34, 'cloze',
     'Beyond simple stimulus pairing, associative learning is also shaped by {{c1::cognitive}} processes, such as learning to expect that one event predicts another.',
     1);

    -- ── Memory: Encoding & Storage ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
     'Getting information into the memory system — where the brain labels it and links it to concepts you already hold — is the process called {{c1::encoding}}.',
     1),
    (deck, 36, 'cloze',
     'Encoding is {{c1::automatic}} when details like time or location register without conscious awareness, but {{c1::effortful}} when it requires focused attention and active processing.',
     1),
    (deck, 37, 'cloze',
     'Of the three types of encoding, {{c1::semantic}} encoding uses the deepest level of processing and produces the strongest memory for verbal information.',
     1),
    (deck, 38, 'cloze',
     'Sensory memory is modality-specific: {{c1::iconic}} memory momentarily holds visual images, while {{c1::echoic}} memory momentarily holds sounds.',
     1),
    (deck, 39, 'cloze',
     'In the Atkinson-Shiffrin model, information passes in order through brief {{c1::sensory}} memory, limited {{c1::short-term}} memory, and finally {{c1::long-term}} memory.',
     1),
    (deck, 40, 'cloze',
     'Short-term memory holds only about {{c1::seven}} items — Miller''s ''magic number'' — for roughly {{c2::15 to 30 seconds}} before they fade or move to long-term storage.',
     2),
    (deck, 41, 'cloze',
     'Beyond passive short-term storage, {{c1::working memory}} adds attention and executive control to actively manipulate the information currently held in mind.',
     1),
    (deck, 42, 'cloze',
     '{{c1::Maintenance}} rehearsal merely repeats information to hold it in short-term memory, whereas {{c1::elaborative}} rehearsal links it to existing knowledge and moves it into long-term memory.',
     1),
    (deck, 43, 'cloze',
     'Long-term memories you can consciously bring to mind and state in words are {{c1::explicit}}, also called {{c1::declarative}}, memory.',
     1),
    (deck, 44, 'cloze',
     'Explicit memory has two subtypes: {{c1::semantic}} memory for facts and general knowledge, and {{c1::episodic}} memory for events you have personally lived through.',
     1),
    (deck, 45, 'cloze',
     'A long-term memory expressed through performance rather than conscious recollection — such as a conditioned response — is {{c1::implicit}}, or {{c1::nondeclarative}}, memory.',
     1),
    (deck, 46, 'cloze',
     'The implicit memory that stores how to carry out well-practiced skills, like riding a bicycle or tying a shoe, is {{c1::procedural}} memory.',
     1),
    (deck, 47, 'cloze',
     'Within a semantic network, recalling one concept partially energizes the concepts linked to it by meaning — a retrieval process named {{c1::spreading activation}}.',
     1),
    (deck, 48, 'cloze',
     'By the serial position effect, recall is strongest for a list''s opening items (the {{c1::primacy}} effect) and its closing items (the {{c1::recency}} effect).',
     1);

    -- ── Memory: Retrieval & Forgetting ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 49, 'cloze',
     '{{c1::Recall}} is the retrieval process of accessing stored information without any cues to prompt you, as an essay exam demands.',
     1),
    (deck, 50, 'cloze',
     '{{c1::Recognition}} is the retrieval process of identifying previously learned information when you encounter it again, as on a multiple-choice test.',
     1),
    (deck, 51, 'cloze',
     '{{c1::Relearning}} is picking up previously studied material faster the second time, showing that some memory was retained even when it could not be recalled directly.',
     1),
    (deck, 52, 'cloze',
     'A {{c1::retrieval cue}} is any associated stimulus — a word, a place, or a bodily feeling — that helps bring a stored memory back into awareness.',
     1),
    (deck, 53, 'cloze',
     'In {{c1::priming}}, an earlier stimulus — such as reading the word ''picnic'' — activates associated concepts so a related word like ''plate'' comes to mind more readily.',
     1),
    (deck, 54, 'cloze',
     'Scuba divers who studied word lists underwater later recalled them best underwater rather than on land, demonstrating {{c1::context-dependent}} memory.',
     1),
    (deck, 55, 'cloze',
     '{{c1::State-dependent}} memory is improved recall when your internal physiology during retrieval matches the internal physiology present during encoding.',
     1),
    (deck, 56, 'cloze',
     'A cheerful person recalls happy memories more readily, and a sad person recalls unhappy ones — an effect called {{c1::mood-congruent memory}}.',
     1),
    (deck, 57, 'cloze',
     'A {{c1::flashbulb}} memory is an unusually vivid, long-lasting recollection of the moment one learned of a shocking, emotionally powerful event.',
     1),
    (deck, 58, 'cloze',
     '{{c1::Proactive}} interference is when older learning disrupts recall of newer material, whereas {{c1::retroactive}} interference is when newer learning disrupts recall of older material.',
     1),
    (deck, 59, 'cloze',
     'According to {{c1::decay}} theory, a memory trace fades and grows less accessible over time when the information is left unused.',
     1),
    (deck, 60, 'cloze',
     'In the {{c1::misinformation effect}}, false or leading details encountered after an event get woven into a person''s memory of what originally happened.',
     1),
    (deck, 61, 'cloze',
     'Recalling something you only imagined as if it had really happened is a classic {{c1::source-monitoring}} error.',
     1),
    (deck, 62, 'cloze',
     '{{c1::Korsakoff''s syndrome}}, a memory disorder from severe thiamine (vitamin B1) deficiency, is marked by confabulation — fabricating stories to fill the gaps.',
     1);

    -- ── Neurobiology of Learning & Memory ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 63, 'cloze',
     'Physically, learning and memory are stored as lasting changes in the {{c1::strength of synaptic connections}}.',
     1),
    (deck, 64, 'cloze',
     '{{c1::Neuroplasticity}} is the nervous system''s ability to change and adapt, including by forming and strengthening synaptic connections.',
     1),
    (deck, 65, 'cloze',
     'Neuroplasticity is {{c1::greatest in early childhood and declines with age}}.',
     1),
    (deck, 66, 'cloze',
     'In {{c1::synaptic pruning}}, the brain eliminates its weak or unused connections.',
     1),
    (deck, 67, 'cloze',
     '{{c1::Long-term potentiation}} is the persistent strengthening of a synapse that follows repeated stimulation.',
     1),
    (deck, 68, 'cloze',
     'Long-term potentiation strengthens a synapse through greater {{c1::neurotransmitter release}} and a higher density of {{c2::postsynaptic receptors}}.',
     2),
    (deck, 69, 'cloze',
     'Long-term potentiation is thought to be the synaptic mechanism that transforms {{c1::short-term memory into long-term memory}}.',
     1);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 70, 'cloze',
     'A worker paid per dozen items assembled is on a {{c1::fixed-ratio}} schedule, whereas a slot-machine gambler is on a {{c1::variable-ratio}} schedule — the most resistant to {{c2::extinction}}.',
     2),
    (deck, 71, 'cloze',
     'A hospital patient who may take another painkiller dose only once per hour follows a {{c1::fixed-interval}} schedule; refreshing social media for new posts reflects a {{c1::variable-interval}} schedule.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 72;
END $$;
