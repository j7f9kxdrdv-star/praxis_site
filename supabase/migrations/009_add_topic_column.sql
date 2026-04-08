-- ============================================================
-- Add topic column for two-level category hierarchy
-- topic = main category (e.g., "Sensation & Perception")
-- subtopic = subcategory (e.g., "Vision", "Hearing & Vestibular")
-- ============================================================

ALTER TABLE questions ADD COLUMN IF NOT EXISTS topic TEXT;

-- Set topic for all Psych/Soc Chapter 2 questions
UPDATE questions SET topic = 'Sensation & Perception'
WHERE section = 'psych_soc'
  AND subtopic IN ('Sensation and Perception', 'Vision', 'Hearing and Vestibular Sense', 'Other Senses', 'Object Recognition');

-- Rename the generic "Sensation and Perception" subtopic to "Sensory Processing"
-- so it doesn't duplicate the topic name
UPDATE questions SET subtopic = 'Sensory Processing'
WHERE section = 'psych_soc'
  AND subtopic = 'Sensation and Perception';

-- Set topic for the original seed questions (Psychology, Sociology)
UPDATE questions SET topic = 'Behavior & Social Processes'
WHERE section = 'psych_soc'
  AND subtopic IN ('Psychology', 'Sociology');

-- Set topic for Bio/Biochem questions
UPDATE questions SET topic = 'Molecular & Cellular Biology'
WHERE section = 'bio_biochem';

-- Set topic for Chem/Phys questions
UPDATE questions SET topic = 'Chemical & Physical Foundations'
WHERE section = 'chem_phys';
