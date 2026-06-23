-- Biology Ch1 audit fix: one cosmetic wording defect (cilia/flagella dynein question).
-- Answer (C) is correct and unchanged; only repairs a garbled clause in the explanation.
-- UPDATE-by-id (preserves the question id so student answer-history stays linked).
BEGIN;

UPDATE questions
SET explanation = replace(
  explanation,
  $old$so a single dynein-arm loss bends neither.$old$,
  $new$so a single dynein-arm defect leaves neither able to beat — one lesion explains both the immotile sperm and the poor mucus clearance.$new$
)
WHERE id = 'e2d7e2c8-2d91-4e4d-bef8-fd5428dfc3d6';

COMMIT;

-- verify: should return still_garbled=false, fixed=true
SELECT (explanation LIKE '%bends neither%')                          AS still_garbled,
       (explanation LIKE '%leaves neither able to beat%')            AS fixed
FROM questions
WHERE id = 'e2d7e2c8-2d91-4e4d-bef8-fd5428dfc3d6';
