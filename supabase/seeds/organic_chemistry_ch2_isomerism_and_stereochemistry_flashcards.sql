-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Isomerism & Stereochemistry
-- Section: organic_chemistry · Topic: Organic Chemistry
--
-- Coverage: the isomer hierarchy (structural vs stereo,
-- conformational vs configurational); structural isomers
-- (same formula, different connectivity; physical vs chemical
-- properties); conformational isomers (Newman projections;
-- four canonical butane conformations with their dihedral
-- angles — totally eclipsed 0°, gauche 60°, eclipsed 120°,
-- anti 180° — and energy ranking); cyclic conformations
-- (the three ring strain types, cyclohexane chair / boat /
-- twist-boat / half-chair, axial vs equatorial, ring flip
-- with wedge/dash preservation, equatorial preference for
-- bulky substituents, flagpole interactions); cis-trans in
-- rings; configurational isomers (definition); chirality
-- fundamentals (chiral object definition, chiral center =
-- 4 different substituents, internal plane of symmetry →
-- achiral); enantiomers (definition, identical properties
-- except optical activity and chiral-environment reactions,
-- plane-polarized light, dextrorotatory/levorotatory + / −
-- notation, equal-magnitude-opposite-direction rule, racemic
-- mixtures); diastereomers (definition, 2ⁿ rule, different
-- physical AND chemical properties, cis-trans alkenes as a
-- subset, diastereomer optical activity, the resolution
-- principle); meso compounds; and configuration assignment
-- (relative vs absolute, Cahn-Ingold-Prelog priority rules
-- with double-bond doubling and outward tie-breaking, E/Z
-- notation, R/S three-step procedure with switch-pair
-- inversion shortcut, Fischer projections and their rotation
-- rules, and how R/S descriptors are written in the IUPAC name).
--
-- All cards are CLOZE-format. Cards are ORIGINAL Praxist Prep
-- content — written from the underlying organic chemistry and
-- re-sourced from the reference textbooks listed in the
-- companion verification.md file; no prose is lifted from any
-- third-party source.
--
-- Subtopic ordering follows the AAMC content outline
-- (Foundation 5D: stereochemistry), NOT the source .docx's
-- chapter ordering. Style follows the Orgo Ch1 cadence
-- reference (organic_chemistry_ch1_naming_organic_molecules_flashcards.sql).
--
-- Idempotent: re-running deletes the prior version of this
-- deck and re-seeds. User review history attached to those
-- cards (flashcard_user_state, flashcard_reviews) cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  -- Wipe any prior copy of this deck (across any historical titles)
  DELETE FROM flashcard_decks
   WHERE section = 'organic_chemistry'
     AND title   IN (
           'Isomerism & Stereochemistry',
           'Isomers',
           'Stereochemistry',
           'Chapter 2 — Isomerism & Stereochemistry',
           'Chapter 2 — Isomers'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'organic_chemistry',
    'Organic Chemistry',
    'isomerism_and_stereochemistry',
    'Isomerism & Stereochemistry',
    'The isomer hierarchy from structural through stereo and configurational; conformational analysis with Newman projections and cyclohexane chair/boat conformations; chirality, enantiomers, optical activity, racemic mixtures, diastereomers, and meso compounds; and the assignment of absolute configuration using Cahn-Ingold-Prelog priority rules, E/Z and R/S notation, and Fischer projections.',
    2
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. Isomer Overview ───────────────────────────────────
  (deck,  0, 'cloze',
   'Isomers — molecules sharing the same molecular formula — divide into two broad classes: {{c1::structural (constitutional) isomers}} differ in {{c2::atomic connectivity}}, while {{c3::stereoisomers}} share connectivity but differ in {{c4::spatial arrangement}}.', 4),

  (deck,  1, 'cloze',
   'Stereoisomers further split into {{c1::conformational}} isomers (interconvertible by rotation around single bonds — same molecule in different orientations) and {{c2::configurational}} isomers (interconvertible only by {{c3::breaking and re-forming covalent bonds}}). Enantiomers and diastereomers are configurational.', 3),

  -- ── 2. Structural Isomers ────────────────────────────────
  (deck,  2, 'cloze',
   '{{c1::Structural (constitutional) isomers}} share the same {{c2::molecular formula}} — and therefore the same molecular weight — but differ in how their atoms are {{c3::connected}}; this difference in connectivity gives them distinct chemical and physical properties.', 3),

  (deck,  3, 'cloze',
   'A {{c1::physical property}} can be observed or measured without changing chemical composition (melting point, boiling point, density, solubility, color, odor). A {{c2::chemical property}} describes how a substance {{c3::reacts}} with other species — by definition, observing it changes the composition.', 3),

  (deck,  4, 'cloze',
   'Two structural isomers can have identical molecular formulas yet behave entirely differently in the lab — different boiling points, different reactivities — because their atoms are bonded in {{c1::different patterns}}, producing different functional groups, branch patterns, or ring structures.', 1),

  -- ── 3. Conformational Isomers / Newman ───────────────────
  (deck,  5, 'cloze',
   '{{c1::Conformational isomers (conformers)}} are the same molecule observed at different rotational positions around a {{c2::single (σ) bond}}; because rotation around a single bond is essentially free at room temperature, conformers rapidly interconvert without breaking any bonds.', 2),

  (deck,  6, 'cloze',
   'A {{c1::Newman projection}} visualizes a molecule along the axis of a chosen {{c2::carbon-carbon bond}}: the front carbon is drawn as a point with three substituents radiating out, and the rear carbon as a circle with three substituents extending from its edge — making the {{c3::dihedral angle}} between groups easy to read.', 3),

  (deck,  7, 'cloze',
   'The four canonical Newman conformations of n-butane around the C2–C3 bond, by dihedral angle between the two methyl groups: {{c1::totally eclipsed (0°)}}, {{c1::gauche (60°)}}, {{c1::eclipsed (120°)}}, and {{c1::anti (180°)}}.', 1),

  (deck,  8, 'cloze',
   'Energy ranking of butane''s Newman conformations from highest to lowest: {{c1::totally eclipsed > eclipsed > gauche > anti}}. The {{c2::anti}} conformation is most stable because the two methyl groups are maximally separated; {{c3::totally eclipsed}} is least stable because the methyls directly overlap.', 3),

  (deck,  9, 'cloze',
   'Conformational isomers are formally classified as stereoisomers, but they are essentially the same molecule sampled at different rotation states — at room temperature, a molecule spends most of its time in its {{c1::lowest-energy}} conformation and only briefly visits higher-energy ones.', 1),

  -- ── 4. Cyclic Conformations ──────────────────────────────
  (deck, 10, 'cloze',
   'Three distinct strain types contribute to the instability of cyclic conformations: {{c1::angle strain}} (bond angles forced away from their ideal values), {{c2::torsional strain}} (eclipsing interactions on adjacent carbons), and {{c3::non-bonded (van der Waals) strain}} (atoms competing for the same space).', 3),

  (deck, 11, 'cloze',
   'Cyclohexane primarily adopts three interconverting conformations: {{c1::chair}}, {{c1::boat}}, and {{c1::twist-boat (skew-boat)}}. The chair is by far the most stable because it simultaneously minimizes all three forms of strain.', 1),

  (deck, 12, 'cloze',
   'During a cyclohexane {{c1::ring flip}} (chair → chair''), the molecule briefly passes through a {{c2::half-chair}} conformation as a high-energy transition state on the way to the twist-boat and the inverted chair.', 2),

  (deck, 13, 'cloze',
   'In a cyclohexane chair, substituents at each carbon occupy two distinct positions: {{c1::axial}} bonds point perpendicular to the average plane of the ring (straight up or down), while {{c2::equatorial}} bonds point outward from the ring near the plane.', 2),

  (deck, 14, 'cloze',
   'A ring flip converts every {{c1::axial}} position into an {{c1::equatorial}} position and vice versa; but the absolute spatial orientation of each substituent is preserved — {{c2::wedges remain wedges}} and {{c2::dashes remain dashes}}.', 2),

  (deck, 15, 'cloze',
   'In a substituted cyclohexane, the preferred chair conformation is the one that places the {{c1::larger substituent in the equatorial position}} — this minimizes the {{c2::1,3-diaxial strain}} a bulky axial group would experience with the axial hydrogens on the same face of the ring.', 2),

  (deck, 16, 'cloze',
   'The {{c1::boat}} conformation of cyclohexane suffers from {{c2::flagpole interactions}} — the two carbons at the bow and stern of the boat point their axial substituents directly at each other, generating significant non-bonded strain. The twist-boat partially relieves this but is still far less stable than the chair.', 2),

  -- ── 5. Cis-Trans in Rings ────────────────────────────────
  (deck, 17, 'cloze',
   'In a substituted cyclic compound, two substituents are {{c1::cis}} if they are on the {{c2::same side}} (same face) of the ring plane and {{c1::trans}} if they are on {{c2::opposite sides}} — this is a true configurational distinction because converting cis to trans would require breaking and reforming a covalent bond.', 2),

  -- ── 6. Configurational Isomers ───────────────────────────
  (deck, 18, 'cloze',
   '{{c1::Configurational isomers}} share the same connectivity but differ in their spatial arrangement in a way that cannot be undone by rotation alone — converting one to the other requires {{c2::breaking and re-forming covalent bonds}}. Enantiomers, diastereomers, and cis/trans isomers are all configurational.', 2),

  -- ── 7. Chirality Fundamentals ────────────────────────────
  (deck, 19, 'cloze',
   'An object is {{c1::chiral}} if its mirror image cannot be superimposed on the original — your two hands are the canonical example. A molecule is chiral if and only if it lacks an {{c2::internal plane of symmetry}}.', 2),

  (deck, 20, 'cloze',
   'A {{c1::chiral center}} (stereocenter) is a carbon bonded to {{c2::four different substituents}}. Any carbon with even two identical substituents is automatically achiral at that position because the molecule contains a plane of symmetry through it.', 2),

  (deck, 21, 'cloze',
   'A molecule containing chiral carbons can be {{c1::overall achiral}} if it possesses an internal plane of symmetry that relates one chiral center to another as its mirror image — such molecules are called {{c2::meso compounds}}.', 2),

  -- ── 8. Enantiomers ───────────────────────────────────────
  (deck, 22, 'cloze',
   '{{c1::Enantiomers}} are pairs of stereoisomers that are non-superimposable {{c2::mirror images}} of each other — they share the same atomic connectivity but have opposite configurations at {{c3::every chiral center}} in the molecule.', 3),

  (deck, 23, 'cloze',
   'Enantiomers have {{c1::identical}} physical and chemical properties with two important exceptions: they rotate {{c2::plane-polarized light}} in opposite directions, and they react differently in {{c3::chiral environments}} (such as enzyme active sites or other chiral reagents).', 3),

  (deck, 24, 'cloze',
   'A molecule is {{c1::optically active}} if it rotates the plane of {{c2::plane-polarized light}}; this happens because light passing through a chiral medium interacts asymmetrically with the electron clouds of the molecules, rotating the polarization plane by an angle measurable with a polarimeter.', 2),

  (deck, 25, 'cloze',
   'A compound that rotates plane-polarized light {{c1::clockwise}} (to the right) is called {{c2::dextrorotatory}} and labeled {{c3::(+)}}; a compound that rotates it {{c1::counterclockwise}} (to the left) is called {{c2::levorotatory}} and labeled {{c3::(−)}}.', 3),

  (deck, 26, 'cloze',
   'One enantiomer rotates plane-polarized light by exactly the {{c1::same magnitude but in the opposite direction}} as its mirror-image partner — so a (+)-isomer rotating +12° is always paired with a (−)-isomer rotating −12° under matched conditions.', 1),

  (deck, 27, 'cloze',
   'A {{c1::racemic mixture}} is a 1:1 mixture of two enantiomers. Because each rotates plane-polarized light by equal magnitude in opposite directions, the rotations cancel and the mixture exhibits {{c2::no net optical activity}} — even though each individual molecule is chiral.', 2),

  -- ── 9. Diastereomers ─────────────────────────────────────
  (deck, 28, 'cloze',
   '{{c1::Diastereomers}} are configurational isomers that are NOT mirror images of each other — they share the same connectivity and contain chiral centers, but they differ at {{c2::some but not all}} stereocenters.', 2),

  (deck, 29, 'cloze',
   'A molecule with n chiral centers has up to {{c1::2ⁿ}} possible stereoisomers — although the actual number is fewer when internal symmetry produces meso compounds that overlap.', 1),

  (deck, 30, 'cloze',
   'Unlike enantiomers, diastereomers have {{c1::different physical AND chemical properties}} — they melt at different temperatures, boil at different points, dissolve differently, and react at different rates. This is what makes them separable by ordinary techniques like distillation or chromatography.', 1),

  (deck, 31, 'cloze',
   'Like enantiomers, diastereomers can be {{c1::optically active}} — each diastereomer rotates plane-polarized light by its own characteristic magnitude and direction. But unlike enantiomer pairs, two diastereomers do NOT have the same magnitude of rotation.', 1),

  (deck, 32, 'cloze',
   'Cis-trans isomerism around a carbon-carbon double bond is a specific subset of {{c1::diastereomerism}}: the two substituents on each side of the C=C bond cannot interconvert by rotation (the π-bond is rigid), so {{c2::cis}} and {{c2::trans}} forms are non-mirror-image stereoisomers.', 2),

  (deck, 33, 'cloze',
   'Reacting a {{c1::racemic mixture}} with a single enantiomer of another chiral compound produces a mixture of {{c2::diastereomers}} — which, because they have different physical properties, can be separated and then converted back to the original enantiomers. This is the classical strategy for resolving enantiomers.', 2),

  -- ── 10. Meso Compounds ───────────────────────────────────
  (deck, 34, 'cloze',
   'A {{c1::meso compound}} contains two or more chiral centers but possesses an {{c2::internal plane of symmetry}} that relates one stereocenter to another as its mirror image — the molecule is {{c3::overall achiral}} and optically inactive, behaving like an internal racemic mixture.', 3),

  -- ── 11. Configuration Assignment ─────────────────────────
  (deck, 35, 'cloze',
   '{{c1::Relative configuration}} compares the arrangement of one chiral molecule to another (often by chemical correlation). {{c2::Absolute configuration}} specifies the exact spatial arrangement at each chiral center, independent of any reference molecule — encoded by the {{c3::R/S system}}.', 3),

  (deck, 36, 'cloze',
   'Under {{c1::Cahn-Ingold-Prelog (CIP) priority rules}}, substituents on a chiral center or double-bonded carbon are ranked by the {{c2::atomic number}} of the atoms directly attached — higher atomic number = higher priority. Ties are broken by working {{c3::outward}}, comparing the next atoms one bond further until a difference is found.', 3),

  (deck, 37, 'cloze',
   'Under CIP priority rules, a {{c1::double bond}} to atom X is treated as {{c2::two single bonds}} to X — for example, a carbon double-bonded to oxygen counts as two C–O bonds when assigning priority.', 2),

  (deck, 38, 'cloze',
   'For alkenes with poly-substituted double bonds, configuration is given by {{c1::E/Z}} notation rather than cis/trans. Apply CIP rules at each double-bonded carbon to identify the higher-priority substituent on each side; if both higher-priority groups are on the {{c2::same side}} → {{c3::Z}} (zusammen); if on {{c2::opposite sides}} → {{c3::E}} (entgegen).', 3),

  (deck, 39, 'cloze',
   'To assign R or S at a chiral center: (1) {{c1::assign CIP priorities}} 1–4 to the four substituents; (2) orient the molecule so the {{c2::lowest-priority (4) group points away from you (into the page)}}; (3) trace 1→2→3 and read the direction — {{c3::clockwise = R}}, {{c3::counterclockwise = S}}.', 3),

  (deck, 40, 'cloze',
   'A useful shortcut: any time you {{c1::switch two substituents}} on a chiral center, the configuration {{c2::inverts}}; therefore if the lowest-priority group is not already pointing into the page, swap it into back, determine R/S as if it were correct, then {{c3::reverse your final answer}}.', 3),

  (deck, 41, 'cloze',
   'In a {{c1::Fischer projection}}, the chiral carbon sits at the intersection of crossed lines. {{c2::Horizontal bonds project out of the page toward the viewer (wedges)}}; {{c3::vertical bonds extend into the page (dashes)}}. The carbon chain runs vertically with the most oxidized end at the top.', 3),

  (deck, 42, 'cloze',
   'Fischer projection manipulations: switching {{c1::any two substituents}} on a chiral carbon = inverted stereochemistry; switching {{c2::two pairs}} = retained; rotating the molecule {{c3::90° in the plane}} = inverted; rotating {{c3::180° in the plane}} = retained.', 3),

  (deck, 43, 'cloze',
   'Once R/S has been assigned, the descriptor is written in {{c1::parentheses with a hyphen}} preceding the rest of the name — for example, {{c2::(R)-2-bromobutane}}, and {{c2::(2S,3R)-3-bromo-2-butanol}} for a molecule with multiple chiral centers labeled by locant.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
