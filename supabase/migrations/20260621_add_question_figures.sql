-- Add optional figure support to standalone questions.
-- Primary path: inline original SVG authored in-house (vector; original by construction, no copyright
-- exposure; ships in the same SQL as the question; renders between the stem and the answer choices).
-- Escape hatch: figure_url for an externally hosted raster image (figure_svg takes precedence if both set).
-- Both columns are nullable and additive; safe to re-run.

ALTER TABLE questions ADD COLUMN IF NOT EXISTS figure_svg TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS figure_url TEXT;

COMMENT ON COLUMN questions.figure_svg IS 'Optional inline original SVG markup for a question figure (authored in-house; rendered between the stem and the answer choices). Takes precedence over figure_url.';
COMMENT ON COLUMN questions.figure_url IS 'Optional URL to an externally hosted question-figure image (escape hatch for raster/photographic figures).';
