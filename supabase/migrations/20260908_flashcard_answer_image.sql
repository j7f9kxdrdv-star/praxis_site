-- An image that belongs to a card's ANSWER.
--
-- Cards can already carry an image, but only inside cloze_text, which puts it
-- on the FRONT. All twenty of those live in the Amino Acids deck and the
-- picture is the question there: blank the answers and "____, ____, ____"
-- beside a structure diagram is still answerable, while the same card with the
-- drawing removed is not. That slot is the prompt and must stay where it is.
--
-- This is the other one. It shows when the answer is revealed, win or lose, as
-- a panel under the card, and a card without one shows nothing at all: no empty
-- frame, no reserved space.
--
-- WHY A COLUMN AND NOT MORE INLINE MARKUP. cloze_text is already parsed by two
-- regexes that have collided once this month: notation written with braces was
-- swallowed by the cloze delimiter and broke 61 cards in production. An answer
-- image has no reason to share that string. A column also answers "which cards
-- have one" with a query instead of a scan.

ALTER TABLE public.flashcards
  ADD COLUMN IF NOT EXISTS back_image_url text,
  ADD COLUMN IF NOT EXISTS back_image_alt text;

-- A path under /flashcards/, never an external URL: the images are ours and are
-- served from the app, so a card cannot be made to load someone else's host.
ALTER TABLE public.flashcards
  DROP CONSTRAINT IF EXISTS flashcards_back_image_url_local;
ALTER TABLE public.flashcards
  ADD CONSTRAINT flashcards_back_image_url_local
  CHECK (back_image_url IS NULL OR back_image_url ~ '^/flashcards/[A-Za-z0-9._/-]+$');

-- Alt text is not optional when there is an image. A structure diagram with no
-- description is unusable with a screen reader, and the existing twenty cards
-- all carry one.
ALTER TABLE public.flashcards
  DROP CONSTRAINT IF EXISTS flashcards_back_image_alt_present;
ALTER TABLE public.flashcards
  ADD CONSTRAINT flashcards_back_image_alt_present
  CHECK (back_image_url IS NULL OR nullif(btrim(back_image_alt), '') IS NOT NULL);

COMMENT ON COLUMN public.flashcards.back_image_url IS
  'Answer-side image, shown under the card on reveal. Local path under /flashcards/.';
COMMENT ON COLUMN public.flashcards.back_image_alt IS
  'Required whenever back_image_url is set.';
