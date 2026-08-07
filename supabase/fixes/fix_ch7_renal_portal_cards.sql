-- Restore the renal portal system to the Ch7 Cardiovascular flashcard deck.
--
-- The deck build dropped this card as "factually wrong for humans", reasoning that a true renal
-- portal system is a comparative-anatomy feature of fish/birds/reptiles. That reasoning conflates
-- two different structures. OpenStax Anatomy and Physiology 2e, the reference text this pipeline
-- verifies against, says the opposite in two places:
--
--   AP:31903  "The human body has three portal systems: two venous (hypophyseal and hepatic)
--              and one arterial (renal)."
--   AP:52533  "Since a capillary bed (the glomerulus) drains into a vessel that in turn forms a
--              second capillary bed, the definition of a portal system is met. This is the only
--              portal system in which an arteriole is found between the first and second
--              capillary beds."
--
-- The comparative-anatomy renal portal system (venous, draining the hindlimbs) is a separate thing
-- humans genuinely lack. The human glomerulus to efferent-arteriole to peritubular arrangement is
-- textbook-supported and belongs in the deck alongside the hepatic and hypophyseal cards.
--
-- Two cards: one parallel to the existing hepatic/hypophyseal pair, one testing the discriminating
-- fact (the arteriole between the beds). Appends only; existing cards and SRS progress untouched.

INSERT INTO public.flashcards (deck_id, card_type, cloze_text, cloze_count, position)
SELECT 'fe0359b9-8e7b-4620-b573-600cfe292b20',
       'cloze',
       'The renal portal system carries blood from the {{c1::glomerulus}}, through the efferent arteriole, to the {{c2::peritubular capillaries}} and vasa recta.',
       2,
       (SELECT COALESCE(MAX(position), 0) + 1 FROM public.flashcards
        WHERE deck_id = 'fe0359b9-8e7b-4620-b573-600cfe292b20')
WHERE NOT EXISTS (
  SELECT 1 FROM public.flashcards
  WHERE deck_id = 'fe0359b9-8e7b-4620-b573-600cfe292b20'
    AND cloze_text LIKE '%renal portal system carries blood%'
);

INSERT INTO public.flashcards (deck_id, card_type, cloze_text, cloze_count, position)
SELECT 'fe0359b9-8e7b-4620-b573-600cfe292b20',
       'cloze',
       'Of the three human portal systems, the renal is the only one whose two capillary beds are linked by an {{c1::arteriole}} rather than a vein.',
       1,
       (SELECT COALESCE(MAX(position), 0) + 1 FROM public.flashcards
        WHERE deck_id = 'fe0359b9-8e7b-4620-b573-600cfe292b20')
WHERE NOT EXISTS (
  SELECT 1 FROM public.flashcards
  WHERE deck_id = 'fe0359b9-8e7b-4620-b573-600cfe292b20'
    AND cloze_text LIKE '%only one whose two capillary beds%'
);

-- Verification: expect FOUR portal cards (definition, hepatic, hypophyseal, renal x2 = 5 rows).
SELECT position, cloze_count, cloze_text
FROM public.flashcards
WHERE deck_id = 'fe0359b9-8e7b-4620-b573-600cfe292b20'
  AND cloze_text ILIKE '%portal%'
ORDER BY position;
