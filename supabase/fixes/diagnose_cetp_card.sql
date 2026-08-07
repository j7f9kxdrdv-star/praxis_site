-- Diagnostic only, changes nothing. Shows the live text of every card mentioning CETP,
-- so the fix can be written against what is actually there rather than the seed file.
SELECT id, cloze_count, cloze_text
  FROM public.flashcards
 WHERE cloze_text LIKE '%CETP%'
 ORDER BY id;
