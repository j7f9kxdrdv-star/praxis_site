-- ============================================================
-- Cross-chapter concepts need the other chapter's content category
--
-- FOUND BY THE VERIFIER, on 6 of 2,659 mappings.
--
-- When a concept is reused across chapters, its questions arrive carrying a
-- DIFFERENT AAMC content category, and concept_content_categories has to say so.
-- The extension added the cross-chapter MAPPINGS without adding the matching
-- category rows, so compatibility validation correctly refused them.
--
-- This is the many-to-many architecture being right and my seeding being
-- incomplete. It caught one of my own new concepts as well as three reuses:
-- Waxes was seeded under Lipids only, while it also serves a Biological
-- Membranes question, which is the exact cross-chapter case it was created for.
--
-- Additive: four rows, all is_primary false so each concept keeps the primary
-- category it already had. Nothing else changes.
-- ============================================================

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary) VALUES
  -- Nernst applied in a vesicle, taught under Plasma Membrane as well as Biosignaling.
  ((SELECT id FROM public.concepts WHERE canonical_name = 'Ion Channels'), 'Plasma Membrane', false),
  -- Goldman/multi-ion permeability, taught under Plasma Membrane as well as The Action Potential.
  ((SELECT id FROM public.concepts WHERE canonical_name = 'Resting Membrane Potential'), 'Plasma Membrane', false),
  -- Bile storage and delivery, examined in organ-system physiology as well as metabolism.
  ((SELECT id FROM public.concepts WHERE canonical_name = 'Lipid Digestion & Bile'), 'Organ Systems', false),
  -- Wax structure, asked in the membranes chapter as well as the lipids chapter.
  ((SELECT id FROM public.concepts WHERE canonical_name = 'Waxes'), 'Plasma Membrane', false)
ON CONFLICT (concept_id, content_category) DO NOTHING;

-- ── Verification ────────────────────────────────────────────────────────
SELECT (SELECT count(*) FROM public.concept_content_categories) AS category_rows,  -- 583
       (SELECT count(*) FROM public.question_concepts)          AS mappings,       -- 2659
       (SELECT count(*) FROM public.concepts)                   AS concepts;       -- 576

-- Every mapping's question category must now be on its concept. Expect zero rows.
SELECT 'category mismatch' AS problem, count(*) AS n
FROM public.question_concepts qc
JOIN public.questions q ON q.id = qc.question_id
WHERE NOT EXISTS (SELECT 1 FROM public.concept_content_categories cc
                  WHERE cc.concept_id = qc.concept_id AND cc.content_category = q.content_category);

-- Concepts now spanning more than one content category. Expect 7.
SELECT c.canonical_name, count(*) AS categories
FROM public.concept_content_categories cc JOIN public.concepts c ON c.id = cc.concept_id
GROUP BY c.canonical_name HAVING count(*) > 1 ORDER BY c.canonical_name;

-- ── ROLLBACK ────────────────────────────────────────────────────────────
-- DELETE FROM public.concept_content_categories
-- WHERE is_primary = false AND (content_category, concept_id) IN (
--   SELECT 'Plasma Membrane', id FROM public.concepts WHERE canonical_name IN ('Ion Channels','Resting Membrane Potential','Waxes')
--   UNION ALL SELECT 'Organ Systems', id FROM public.concepts WHERE canonical_name = 'Lipid Digestion & Bile');
