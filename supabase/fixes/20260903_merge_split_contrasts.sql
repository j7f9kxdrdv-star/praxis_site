-- ============================================================
-- Split contrasts: put both halves of a contrast in the same blank
--
-- A cloze card shows every group except the one being tested. When a card is
-- built on a two-way contrast and puts each half in its OWN group, asking for
-- one PRINTS the other, and the answer follows by elimination. Mikko hit this
-- again on the microtubule card: "the ___ end sits near the nucleus and the
-- POSITIVE end points toward the cell periphery."
--
-- 27 cards are repaired here by folding the two halves into one group, so
-- they blank together. Groups are then renumbered contiguously, because the
-- renderer matches the literal cN while the study page feeds a positional
-- index; those agree only while groups run 1..N with no gaps.
--
-- Each merge was verified before being written: groups contiguous from 1,
-- exactly one group fewer than before, and the card's words unchanged (only
-- the blanking moved).
--
-- PROGRESS ON THESE CARDS IS DELETED: 101 rows across 3 account(s).
-- 20 of those blanks were scheduled past the 2026-09-12 exam and would never
-- have come back in time. A leaking card could be answered without knowing it,
-- so its review history is not evidence of knowledge. These re-enter as new
-- cards and will come back within days, with the leak closed.
-- ============================================================

BEGIN;

-- Amino Acids, Peptides, and Proteins: de- negation of "protonated"
--   was: At physiological pH (~7.4), an amino acid exists predominantly as a {{c1::zwitterion}}: the α-amino group is {{c2::protonated}} (-NH₃+) and the α-carboxyl group
--   now: At physiological pH (~7.4), an amino acid exists predominantly as a {{c1::zwitterion}}: the α-amino group is {{c2::protonated}} (-NH₃+) and the α-carboxyl group
UPDATE public.flashcards SET cloze_text = 'At physiological pH (~7.4), an amino acid exists predominantly as a {{c1::zwitterion}}: the α-amino group is {{c2::protonated}} (-NH₃+) and the α-carboxyl group is {{c2::deprotonated}} (-COO-).', cloze_count = 2 WHERE id = '114d4bfc-e110-404f-962e-b0a169ccaf03';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '114d4bfc-e110-404f-962e-b0a169ccaf03';

-- The Respiratory System: veins / arteries
--   was: Deoxygenated blood leaves the {{c1::right ventricle}} through the {{c2::pulmonary arteries}} (the only post-natal {{c2::arteries}} carrying oxygen-poor blood), 
--   now: Deoxygenated blood leaves the {{c1::right ventricle}} through the {{c2::pulmonary arteries}} (the only post-natal {{c2::arteries}} carrying oxygen-poor blood), 
UPDATE public.flashcards SET cloze_text = 'Deoxygenated blood leaves the {{c1::right ventricle}} through the {{c2::pulmonary arteries}} (the only post-natal {{c2::arteries}} carrying oxygen-poor blood), reaches the {{c3::pulmonary (lung) capillaries}} to load O₂ at the alveoli, then drains via the {{c2::pulmonary veins}} into the {{c4::left atrium}}, completing the pulmonary circuit.', cloze_count = 4 WHERE id = '11c29d37-68e5-4fb1-8f70-79cc4770ca37';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '11c29d37-68e5-4fb1-8f70-79cc4770ca37';

-- Separations and Purifications: polar / nonpolar
--   was: {{c1::Reverse-phase chromatography}} flips the standard polarity setup: the stationary phase is {{c2::nonpolar}} and the mobile phase is {{c3::polar}}.
--   now: {{c1::Reverse-phase chromatography}} flips the standard polarity setup: the stationary phase is {{c2::nonpolar}} and the mobile phase is {{c2::polar}}.
UPDATE public.flashcards SET cloze_text = '{{c1::Reverse-phase chromatography}} flips the standard polarity setup: the stationary phase is {{c2::nonpolar}} and the mobile phase is {{c2::polar}}.', cloze_count = 2 WHERE id = '1df36460-2f5b-451a-b1e4-53eec96df726';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '1df36460-2f5b-451a-b1e4-53eec96df726';

-- Motion & Forces: positive / negative
--   was: When a vector is multiplied by a scalar n, the resulting vector has magnitude {{c1::|n| times the original}}. If n is {{c2::positive}}, the new vector is parall
--   now: When a vector is multiplied by a scalar n, the resulting vector has magnitude {{c1::|n| times the original}}. If n is {{c2::positive}}, the new vector is parall
UPDATE public.flashcards SET cloze_text = 'When a vector is multiplied by a scalar n, the resulting vector has magnitude {{c1::|n| times the original}}. If n is {{c2::positive}}, the new vector is parallel to the original; if n is {{c2::negative}}, the new vector is antiparallel.', cloze_count = 2 WHERE id = '2809e8ee-3adb-490b-ae68-1d3176fdf793';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '2809e8ee-3adb-490b-ae68-1d3176fdf793';

-- Motion & Forces: horizontal / vertical
--   was: Because no {{c1::horizontal}} force acts on a projectile (ignoring air resistance), the {{c1::horizontal velocity remains constant}} throughout the flight. Only
--   now: Because no {{c1::horizontal}} force acts on a projectile (ignoring air resistance), the {{c1::horizontal velocity remains constant}} throughout the flight. Only
UPDATE public.flashcards SET cloze_text = 'Because no {{c1::horizontal}} force acts on a projectile (ignoring air resistance), the {{c1::horizontal velocity remains constant}} throughout the flight. Only the {{c1::vertical}} velocity changes, dropping by g (≈ 9.8 m/s²) each second.', cloze_count = 1 WHERE id = '3757167c-57e0-4777-9cbe-6c52a4efefd9';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '3757167c-57e0-4777-9cbe-6c52a4efefd9';

-- The Respiratory System: visceral / parietal
--   was: Two layers of serous membrane sandwich each lung: the {{c1::visceral}} pleura clings to the lung surface while the {{c2::parietal}} pleura lines the thoracic wa
--   now: Two layers of serous membrane sandwich each lung: the {{c1::visceral}} pleura clings to the lung surface while the {{c1::parietal}} pleura lines the thoracic wa
UPDATE public.flashcards SET cloze_text = 'Two layers of serous membrane sandwich each lung: the {{c1::visceral}} pleura clings to the lung surface while the {{c1::parietal}} pleura lines the thoracic wall, and between them sits the sealed, fluid-filled {{c2::pleural cavity}} whose fluid lets the lung expand tight against the chest wall as the thorax enlarges.', cloze_count = 2 WHERE id = '3f33b9e5-9810-42bb-a442-22d0405c0646';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '3f33b9e5-9810-42bb-a442-22d0405c0646';

-- Embryonic Development & Gestation: in- negation of "determinate"
--   was: In {{c1::indeterminate}} cleavage, each daughter cell can still form a complete organism, which is how monozygotic twins arise. In {{c2::determinate}} cleavage,
--   now: In {{c1::indeterminate}} cleavage, each daughter cell can still form a complete organism, which is how monozygotic twins arise. In {{c1::determinate}} cleavage,
UPDATE public.flashcards SET cloze_text = 'In {{c1::indeterminate}} cleavage, each daughter cell can still form a complete organism, which is how monozygotic twins arise. In {{c1::determinate}} cleavage, each daughter is already committed to a specific lineage.', cloze_count = 1 WHERE id = '3fe30088-a559-4ec3-9bbd-973d3e39c8de';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '3fe30088-a559-4ec3-9bbd-973d3e39c8de';

-- Carboxylic Acids: polar / nonpolar
--   was: Soap molecules are {{c1::amphipathic}}: they have a {{c2::polar carboxylate head}} (hydrophilic) and a {{c3::nonpolar hydrocarbon tail}} (hydrophobic).
--   now: Soap molecules are {{c1::amphipathic}}: they have a {{c2::polar carboxylate head}} (hydrophilic) and a {{c2::nonpolar hydrocarbon tail}} (hydrophobic).
UPDATE public.flashcards SET cloze_text = 'Soap molecules are {{c1::amphipathic}}: they have a {{c2::polar carboxylate head}} (hydrophilic) and a {{c2::nonpolar hydrocarbon tail}} (hydrophobic).', cloze_count = 2 WHERE id = '4f3acfeb-9e17-4eb1-b909-70bc58ae8ee0';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '4f3acfeb-9e17-4eb1-b909-70bc58ae8ee0';

-- Periodic Trends & Chemical Families: increases / decreases
--   was: Electron affinity {{c1::increases}} (becomes more exothermic) from left to right across a period and {{c2::decreases}} from top to bottom in a group. {{c3::Grou
--   now: Electron affinity {{c1::increases}} (becomes more exothermic) from left to right across a period and {{c1::decreases}} from top to bottom in a group. {{c2::Grou
UPDATE public.flashcards SET cloze_text = 'Electron affinity {{c1::increases}} (becomes more exothermic) from left to right across a period and {{c1::decreases}} from top to bottom in a group. {{c2::Group 1A and 2A}} elements have very low EAs (they prefer to lose electrons), while {{c3::halogens (Group 7A)}} have the highest EAs.', cloze_count = 3 WHERE id = '4f400965-ec4e-4643-9554-a21d47b91411';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '4f400965-ec4e-4643-9554-a21d47b91411';

-- Nonenzymatic Protein Function and Protein Analysis: positive / negative
--   was: In a microtubule, the {{c1::negative}} end sits near the nucleus and the {{c2::positive}} end points toward the cell periphery.
--   now: In a microtubule, the {{c1::negative}} end sits near the nucleus and the {{c1::positive}} end points toward the cell periphery.
UPDATE public.flashcards SET cloze_text = 'In a microtubule, the {{c1::negative}} end sits near the nucleus and the {{c1::positive}} end points toward the cell periphery.', cloze_count = 1 WHERE id = '5419bd9a-5491-4916-a792-9137b0f70dbd';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '5419bd9a-5491-4916-a792-9137b0f70dbd';

-- Separations and Purifications: polar / nonpolar
--   was: In extraction, the {{c1::aqueous}} phase dissolves {{c2::polar and hydrogen-bonding}} compounds, while the {{c3::organic}} phase dissolves {{c4::nonpolar}} comp
--   now: In extraction, the {{c1::aqueous}} phase dissolves {{c2::polar and hydrogen-bonding}} compounds, while the {{c3::organic}} phase dissolves {{c2::nonpolar}} comp
UPDATE public.flashcards SET cloze_text = 'In extraction, the {{c1::aqueous}} phase dissolves {{c2::polar and hydrogen-bonding}} compounds, while the {{c3::organic}} phase dissolves {{c2::nonpolar}} compounds.', cloze_count = 3 WHERE id = '6cff16af-42de-4b68-8a75-357775f255c5';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '6cff16af-42de-4b68-8a75-357775f255c5';

-- Sensory Systems & Perception: anterior / posterior
--   was: The space in front of the lens is divided by the iris into two compartments. The {{c1::anterior chamber}} lies between the cornea and the iris; the {{c2::poster
--   now: The space in front of the lens is divided by the iris into two compartments. The {{c1::anterior chamber}} lies between the cornea and the iris; the {{c1::poster
UPDATE public.flashcards SET cloze_text = 'The space in front of the lens is divided by the iris into two compartments. The {{c1::anterior chamber}} lies between the cornea and the iris; the {{c1::posterior chamber}} lies between the iris and the lens. Both are filled with {{c2::aqueous humor}}, secreted by the ciliary body and drained through the {{c3::canal of Schlemm}}.', cloze_count = 3 WHERE id = '70e808f6-a85f-49c5-a81b-3d79bf34d7a9';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '70e808f6-a85f-49c5-a81b-3d79bf34d7a9';

-- The Nervous System: increases / decreases
--   was: Sympathetic activation {{c1::increases}} heart rate, raises blood glucose, dilates pupils, relaxes the bronchi, redirects blood to skeletal muscle, and {{c2::de
--   now: Sympathetic activation {{c1::increases}} heart rate, raises blood glucose, dilates pupils, relaxes the bronchi, redirects blood to skeletal muscle, and {{c1::de
UPDATE public.flashcards SET cloze_text = 'Sympathetic activation {{c1::increases}} heart rate, raises blood glucose, dilates pupils, relaxes the bronchi, redirects blood to skeletal muscle, and {{c1::decreases}} digestion.', cloze_count = 1 WHERE id = '766fdc79-085c-4b18-befc-e47905f62aa5';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '766fdc79-085c-4b18-befc-e47905f62aa5';

-- Equilibrium: reversible / irreversible
--   was: A {{c1::reversible}} reaction can proceed in both the forward and reverse directions, whereas an {{c2::irreversible}} reaction proceeds essentially in one direc
--   now: A {{c1::reversible}} reaction can proceed in both the forward and reverse directions, whereas an {{c1::irreversible}} reaction proceeds essentially in one direc
UPDATE public.flashcards SET cloze_text = 'A {{c1::reversible}} reaction can proceed in both the forward and reverse directions, whereas an {{c1::irreversible}} reaction proceeds essentially in one direction until the limiting reactant is consumed.', cloze_count = 1 WHERE id = '76fa89f4-8e2f-40c5-836c-ca816257202d';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '76fa89f4-8e2f-40c5-836c-ca816257202d';

-- Alcohols: positive / negative
--   was: {{c1::Alkyl groups}} (electron-donating) {{c2::stabilize positive charges}} (helpful for carbocations) but {{c3::destabilize negative charges}} (making non-arom
--   now: {{c1::Alkyl groups}} (electron-donating) {{c2::stabilize positive charges}} (helpful for carbocations) but {{c2::destabilize negative charges}} (making non-arom
UPDATE public.flashcards SET cloze_text = '{{c1::Alkyl groups}} (electron-donating) {{c2::stabilize positive charges}} (helpful for carbocations) but {{c2::destabilize negative charges}} (making non-aromatic alcohols less acidic).', cloze_count = 2 WHERE id = '865c4ae6-a8b8-485f-b07e-d2f4f718a7fb';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '865c4ae6-a8b8-485f-b07e-d2f4f718a7fb';

-- Periodic Trends & Chemical Families: increases / decreases
--   was: Atomic radius {{c1::decreases}} from left to right across a period (rising Z_(eff) pulls the same outer shell tighter) and {{c2::increases}} from top to bottom 
--   now: Atomic radius {{c1::decreases}} from left to right across a period (rising Z_(eff) pulls the same outer shell tighter) and {{c1::increases}} from top to bottom 
UPDATE public.flashcards SET cloze_text = 'Atomic radius {{c1::decreases}} from left to right across a period (rising Z_(eff) pulls the same outer shell tighter) and {{c1::increases}} from top to bottom in a group (each new period adds an electron shell at a larger principal quantum number).', cloze_count = 1 WHERE id = '8f7d617e-ae05-4a2c-872d-811eb745bbe5';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '8f7d617e-ae05-4a2c-872d-811eb745bbe5';

-- Social Thinking: in- negation of "direct benefits"
--   was: {{c1::Mate choice (intersexual selection)}} confers {{c2::direct benefits}} (material support, protection) and {{c3::indirect benefits}} (better offspring survi
--   now: {{c1::Mate choice (intersexual selection)}} confers {{c2::direct benefits}} (material support, protection) and {{c2::indirect benefits}} (better offspring survi
UPDATE public.flashcards SET cloze_text = '{{c1::Mate choice (intersexual selection)}} confers {{c2::direct benefits}} (material support, protection) and {{c2::indirect benefits}} (better offspring survival via good genes).', cloze_count = 2 WHERE id = '90ddabbf-1f94-47d8-87fa-d7ba0e4f4b1a';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '90ddabbf-1f94-47d8-87fa-d7ba0e4f4b1a';

-- Embryonic Development & Gestation: in- negation of "complete regeneration"
--   was: {{c1::Complete regeneration}} restores the original tissue (e.g., the liver after partial hepatectomy). {{c2::Incomplete regeneration}} replaces the lost tissue
--   now: {{c1::Complete regeneration}} restores the original tissue (e.g., the liver after partial hepatectomy). {{c1::Incomplete regeneration}} replaces the lost tissue
UPDATE public.flashcards SET cloze_text = '{{c1::Complete regeneration}} restores the original tissue (e.g., the liver after partial hepatectomy). {{c1::Incomplete regeneration}} replaces the lost tissue with scar tissue rather than a perfect functional copy.', cloze_count = 1 WHERE id = 'bbd49e94-5f9a-4164-b8da-f62169336f5b';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'bbd49e94-5f9a-4164-b8da-f62169336f5b';

-- Brain, Behavior & Development: afferent / efferent
--   was: There are three functional types of neurons: {{c1::sensory (afferent)}} neurons carry signals from receptors toward the CNS, {{c2::motor (efferent)}} neurons ca
--   now: There are three functional types of neurons: {{c1::sensory (afferent)}} neurons carry signals from receptors toward the CNS, {{c1::motor (efferent)}} neurons ca
UPDATE public.flashcards SET cloze_text = 'There are three functional types of neurons: {{c1::sensory (afferent)}} neurons carry signals from receptors toward the CNS, {{c1::motor (efferent)}} neurons carry signals from the CNS to muscles and glands, and {{c2::interneurons}} sit between other neurons and serve as the integrators of neural circuits.', cloze_count = 2 WHERE id = 'cba3f6de-8961-4d0f-bcda-575147686f59';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'cba3f6de-8961-4d0f-bcda-575147686f59';

-- The Nervous System: dorsal / ventral
--   was: {{c1::Dorsal}} (posterior) roots of spinal nerves carry sensory signals into the cord; {{c2::ventral}} (anterior) roots carry motor signals out to muscles and g
--   now: {{c1::Dorsal}} (posterior) roots of spinal nerves carry sensory signals into the cord; {{c1::ventral}} (anterior) roots carry motor signals out to muscles and g
UPDATE public.flashcards SET cloze_text = '{{c1::Dorsal}} (posterior) roots of spinal nerves carry sensory signals into the cord; {{c1::ventral}} (anterior) roots carry motor signals out to muscles and glands.', cloze_count = 1 WHERE id = 'ccc9bda9-7e6b-4e45-9e84-375a49c84116';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'ccc9bda9-7e6b-4e45-9e84-375a49c84116';

-- Separations and Purifications: polar / nonpolar
--   was: {{c1::Thin-layer (TLC)}} and {{c1::paper}} chromatography identify {{c2::small, non-volatile compounds}}; both use a {{c3::polar}} stationary phase (silica gel 
--   now: {{c1::Thin-layer (TLC)}} and {{c1::paper}} chromatography identify {{c2::small, non-volatile compounds}}; both use a {{c3::polar}} stationary phase (silica gel 
UPDATE public.flashcards SET cloze_text = '{{c1::Thin-layer (TLC)}} and {{c1::paper}} chromatography identify {{c2::small, non-volatile compounds}}; both use a {{c3::polar}} stationary phase (silica gel or cellulose) with a {{c3::nonpolar}} mobile phase.', cloze_count = 3 WHERE id = 'd61643e9-9c14-49a9-b677-52c9f6aa0f96';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'd61643e9-9c14-49a9-b677-52c9f6aa0f96';

-- Carboxylic Acids: polar / nonpolar
--   was: In water, soaps self-assemble into {{c1::micelles}}, spherical structures with {{c2::polar heads facing outward}} and {{c3::nonpolar tails facing inward}}, diss
--   now: In water, soaps self-assemble into {{c1::micelles}}, spherical structures with {{c2::polar heads facing outward}} and {{c2::nonpolar tails facing inward}}, diss
UPDATE public.flashcards SET cloze_text = 'In water, soaps self-assemble into {{c1::micelles}}, spherical structures with {{c2::polar heads facing outward}} and {{c2::nonpolar tails facing inward}}, dissolving grease in the hydrophobic interior.', cloze_count = 2 WHERE id = 'd6976b3c-82a0-4ca5-a647-8b74d6c7f1ec';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'd6976b3c-82a0-4ca5-a647-8b74d6c7f1ec';

-- Equilibrium: positive / negative
--   was: The equilibrium constant is linked to the standard free energy change by {{c1::ΔG° = −RT ln K_(eq)}}; a K_(eq) greater than 1 corresponds to a {{c2::negative}} 
--   now: The equilibrium constant is linked to the standard free energy change by {{c1::ΔG° = −RT ln K_(eq)}}; a K_(eq) greater than 1 corresponds to a {{c2::negative}} 
UPDATE public.flashcards SET cloze_text = 'The equilibrium constant is linked to the standard free energy change by {{c1::ΔG° = −RT ln K_(eq)}}; a K_(eq) greater than 1 corresponds to a {{c2::negative}} ΔG° (products favored), while a K_(eq) less than 1 corresponds to a {{c2::positive}} ΔG° (reactants favored).', cloze_count = 2 WHERE id = 'eb071e3c-ecff-4e9e-8f61-d7c2cb0fe3b6';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'eb071e3c-ecff-4e9e-8f61-d7c2cb0fe3b6';

-- Bonding: increases / decreases
--   was: As the number of bonds between two atoms grows, bond length {{c1::decreases}} and bond strength {{c2::increases}}: triple < double < single in length, and tripl
--   now: As the number of bonds between two atoms grows, bond length {{c1::decreases}} and bond strength {{c1::increases}}: triple < double < single in length, and tripl
UPDATE public.flashcards SET cloze_text = 'As the number of bonds between two atoms grows, bond length {{c1::decreases}} and bond strength {{c1::increases}}: triple < double < single in length, and triple > double > single in strength.', cloze_count = 1 WHERE id = 'f452fb0b-fffc-4f17-a8c4-d2b874825811';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'f452fb0b-fffc-4f17-a8c4-d2b874825811';

-- Naming Organic Molecules: prefix / suffix
--   was: Every IUPAC name follows the pattern {{c1::prefix}}, then {{c2::parent chain}}, then {{c3::suffix}}: the {{c1::prefix}} lists the substituents (in alphabetical 
--   now: Every IUPAC name follows the pattern {{c1::prefix}}, then {{c2::parent chain}}, then {{c1::suffix}}: the {{c1::prefix}} lists the substituents (in alphabetical 
UPDATE public.flashcards SET cloze_text = 'Every IUPAC name follows the pattern {{c1::prefix}}, then {{c2::parent chain}}, then {{c1::suffix}}: the {{c1::prefix}} lists the substituents (in alphabetical order with locants), the {{c2::parent chain}} names the longest carbon chain, and the {{c1::suffix}} encodes the highest-priority functional group.', cloze_count = 2 WHERE id = 'f5dc5e93-95c6-43a7-a935-1a886b51a3f0';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'f5dc5e93-95c6-43a7-a935-1a886b51a3f0';

-- Amino Acids, Peptides, and Proteins: de- negation of "protonated"
--   was: When the {{c1::pH}} is below an ionizable group's pKa, the group is mostly {{c2::protonated}}; when pH is above the pKa, it is mostly {{c3::deprotonated}}.
--   now: When the {{c1::pH}} is below an ionizable group's pKa, the group is mostly {{c2::protonated}}; when pH is above the pKa, it is mostly {{c2::deprotonated}}.
UPDATE public.flashcards SET cloze_text = 'When the {{c1::pH}} is below an ionizable group''s pKa, the group is mostly {{c2::protonated}}; when pH is above the pKa, it is mostly {{c2::deprotonated}}.', cloze_count = 2 WHERE id = 'fdd00cbc-7038-4b17-9070-af01df89f3ba';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'fdd00cbc-7038-4b17-9070-af01df89f3ba';

-- Electrochemistry: anode / cathode
--   was: A {{c1::cell diagram}} is shorthand for an electrochemical cell, listing species from left to right starting with the {{c2::anode}} and ending with the {{c3::ca
--   now: A {{c1::cell diagram}} is shorthand for an electrochemical cell, listing species from left to right starting with the {{c2::anode}} and ending with the {{c2::ca
UPDATE public.flashcards SET cloze_text = 'A {{c1::cell diagram}} is shorthand for an electrochemical cell, listing species from left to right starting with the {{c2::anode}} and ending with the {{c2::cathode}}.', cloze_count = 2 WHERE id = 'feafece4-77a2-4240-965e-6f1ec2cc74b8';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'feafece4-77a2-4240-965e-6f1ec2cc74b8';

COMMIT;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0: every repaired card's group count must equal cloze_count.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text, '\{\{c(\d+)::', 'g') AS mm) AS n
  FROM public.flashcards WHERE id IN ('114d4bfc-e110-404f-962e-b0a169ccaf03','11c29d37-68e5-4fb1-8f70-79cc4770ca37','1df36460-2f5b-451a-b1e4-53eec96df726','2809e8ee-3adb-490b-ae68-1d3176fdf793','3757167c-57e0-4777-9cbe-6c52a4efefd9','3f33b9e5-9810-42bb-a442-22d0405c0646','3fe30088-a559-4ec3-9bbd-973d3e39c8de','4f3acfeb-9e17-4eb1-b909-70bc58ae8ee0','4f400965-ec4e-4643-9554-a21d47b91411','5419bd9a-5491-4916-a792-9137b0f70dbd','6cff16af-42de-4b68-8a75-357775f255c5','70e808f6-a85f-49c5-a81b-3d79bf34d7a9','766fdc79-085c-4b18-befc-e47905f62aa5','76fa89f4-8e2f-40c5-836c-ca816257202d','865c4ae6-a8b8-485f-b07e-d2f4f718a7fb','8f7d617e-ae05-4a2c-872d-811eb745bbe5','90ddabbf-1f94-47d8-87fa-d7ba0e4f4b1a','bbd49e94-5f9a-4164-b8da-f62169336f5b','cba3f6de-8961-4d0f-bcda-575147686f59','ccc9bda9-7e6b-4e45-9e84-375a49c84116','d61643e9-9c14-49a9-b677-52c9f6aa0f96','d6976b3c-82a0-4ca5-a647-8b74d6c7f1ec','eb071e3c-ecff-4e9e-8f61-d7c2cb0fe3b6','f452fb0b-fffc-4f17-a8c4-d2b874825811','f5dc5e93-95c6-43a7-a935-1a886b51a3f0','fdd00cbc-7038-4b17-9070-af01df89f3ba','feafece4-77a2-4240-965e-6f1ec2cc74b8')
) t WHERE n <> cloze_count;

-- Expect 0: no leftover progress pointing at a blank that no longer exists.
SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
