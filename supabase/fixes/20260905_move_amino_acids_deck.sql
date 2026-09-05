-- ============================================================
-- "Amino Acids" was a top-level section containing one deck
--
-- Every other section in the flashcard library holds 9 to 12 decks. This one
-- held exactly one, a 43-card reference deck, which meant the analytics page
-- rendered a whole section header for a single row and the library grouped it
-- as though it were a discipline of its own.
--
-- It belongs in Biochemistry, which already carries the related teaching deck
-- "Amino Acids, Peptides, and Proteins". The two are complementary: one is the
-- reference table, the other is the concept material.
--
-- The deck keeps its id, its title and all 43 cards. Only its placement moves,
-- so no user progress is affected: progress is keyed on the card, not the
-- section.
--
-- sort_order goes to 13 because its current value of 1 is already taken
-- inside Biochemistry by "Amino Acids, Peptides, and Proteins".
-- ============================================================

UPDATE public.flashcard_decks
SET section = 'biochemistry',
    topic = 'Biochemistry',
    sort_order = 13
WHERE id = 'b593c1c9-7d34-4451-8b41-fc25b1d832aa';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0: the amino_acids section should no longer exist.
SELECT COUNT(*) AS decks_left_in_amino_acids
FROM public.flashcard_decks WHERE section = 'amino_acids';

-- Expect 13, and no duplicate sort_order within the section.
SELECT COUNT(*) AS biochemistry_decks,
       COUNT(DISTINCT sort_order) AS distinct_sort_orders
FROM public.flashcard_decks WHERE section = 'biochemistry';

-- Expect every section to hold more than one deck.
SELECT section, COUNT(*) AS decks
FROM public.flashcard_decks GROUP BY section ORDER BY decks;
