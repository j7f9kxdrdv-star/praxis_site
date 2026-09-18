-- ============================================================
-- Closed sets split across indices: three cards, same defect
--
-- A set the stem declares as complete ("the two major", or three named basic
-- amino acids) cannot have its members on different cloze numbers. Whichever
-- member is hidden, the others are printed, and anyone who knows the set is
-- closed reads the answer off the page. Same defect as pulmonary/systemic.
--
-- FOUND WHILE STUDYING, 2026-09-18. Mikko hit the first one:
--
--   The two major inhibitory neurotransmitters of the CNS are {{c1::GABA}}
--   (primarily in the brain) and {{c2::glycine}} (primarily in the brainstem
--   and spinal cord). ...
--
-- The stem says there are exactly TWO and then names one of them. Studying c1
-- prints glycine, studying c2 prints GABA, and either way the remaining answer
-- follows without recalling anything. This is the same defect as the pulmonary
-- and systemic circuits: a closed pair whose halves sit on different indices.
--
-- A SECOND CARD HAD IT TOO, in a different deck, and had not been seen yet:
--
--   Common inhibitory neurotransmitters include {{c1::GABA}} in the brain and
--   {{c2::glycine}} in the spinal cord.
--
-- Same shape, same giveaway. Fixed here rather than waiting for it to surface
-- in a session.
--
-- THE FIX IS THE INDEX, NOT THE PROSE. Both terms move to c1 so they mask
-- together and the student has to produce the pair. Verified through
-- checkRewriteSafety: MERGE_GROUPS, safe, with "gaba || glycine" now recorded
-- as co-masked, which is what stops a future audit proposing the split back.
--
-- THE GAP A MERGE LEAVES IS CLOSED. On the first card, merging c2 into c1 left
-- c1 and c3 behind. cloze_count would then be 2 while the session queue walks
-- indices 1 and 2, so item 2 would match no blank and hand the student the
-- whole card with its answers in place. Hyperpolarization is renumbered to c2.
--
-- WHAT THIS COSTS. cloze_count drops 3 -> 2 and 2 -> 1, so one scheduling unit
-- per card stops being scheduled. The review rows stay: flashcard_reviews is
-- append-only history and those reviews really happened.
--
-- NOT FIXED, NOTED: on the first card, studying c2 leaves "increasing chloride
-- influx, making the receiving neuron less likely to fire" visible while
-- hiding "hyperpolarization". That is the definition sitting beside the term.
-- It is a judgement call rather than a closed pair, so it is left for a human
-- rather than merged on my own initiative.
--
-- UPDATE by id. No reseed.
-- ============================================================

-- ── Brain, Behavior & Development ───────────────────────────────────────
UPDATE public.flashcards
SET
  cloze_text = 'The two major inhibitory neurotransmitters of the CNS are {{c1::GABA}} (primarily in the brain) and {{c1::glycine}} (primarily in the brainstem and spinal cord). Both produce {{c2::hyperpolarization}} of the postsynaptic membrane by increasing chloride influx, making the receiving neuron less likely to fire.',
  cloze_count = 2
WHERE id = 'fc413f0c-f541-499b-87d0-ceaf24d6d5fd';

-- ── The Nervous System ──────────────────────────────────────────────────
UPDATE public.flashcards
SET
  cloze_text = 'Common inhibitory neurotransmitters include {{c1::GABA}} in the brain and {{c1::glycine}} in the spinal cord.',
  cloze_count = 1
WHERE id = 'fabe94ee-5a30-406f-8c5b-c5ca9a80ac45';

-- ── Amino Acids, Peptides, and Proteins ─────────────────────────────────
--
-- Mikko hit this one in the same session:
--
--   {{c1::Lysine}} has a terminal primary amine, {{c2::arginine}} has a
--   guanidinium group ... and {{c3::histidine}} has an imidazole ring ...
--
-- The three basic amino acids are a closed set, and all three sat on separate
-- indices: every variant printed the other two. Studying c3 showed lysine and
-- arginine, which leaves exactly one answer for anyone who knows there are
-- three.
--
-- All three move to c1. The card stays answerable because each blank keeps its
-- OWN structural cue: a terminal primary amine, a guanidinium group across
-- three nitrogens, an imidazole ring with two. The student now matches three
-- side chains to three names instead of being handed two of them.
--
-- cloze_count 3 -> 1. Two scheduling units stop being scheduled; the review
-- rows stay, since they record reviews that really happened.
UPDATE public.flashcards
SET
  cloze_text = '{{c1::Lysine}} has a terminal primary amine, {{c1::arginine}} has a guanidinium group whose positive charge is delocalized across three nitrogens, and {{c1::histidine}} has an imidazole ring with two nitrogens.',
  cloze_count = 1
WHERE id = '255c5324-f19a-4fed-b7e1-f24a8e9b051c';

-- ── Verification ────────────────────────────────────────────────────────
SELECT id, cloze_count, cloze_text
FROM public.flashcards
WHERE id IN (
  'fc413f0c-f541-499b-87d0-ceaf24d6d5fd',
  'fabe94ee-5a30-406f-8c5b-c5ca9a80ac45',
  '255c5324-f19a-4fed-b7e1-f24a8e9b051c'
);
