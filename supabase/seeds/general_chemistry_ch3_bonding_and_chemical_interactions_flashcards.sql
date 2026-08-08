-- ════════════════════════════════════════════════════════════════════
-- General Chemistry Chapter 3 — Bonding & Chemical Interactions
-- ════════════════════════════════════════════════════════════════════
-- Section: chemistry
-- Topic:   General Chemistry
-- Subtopic slug: bonding_and_chemical_interactions
-- Sort order: 3
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--   1.  Bonding Fundamentals & Octet Rule
--   2.  Octet Rule Exceptions
--   3.  Ionic Bonds: Formation
--   4.  Ionic Bonds: Properties
--   5.  Covalent Bonds: Formation
--   6.  Covalent Polarity (EN Cutoffs)
--   7.  Coordinate Covalent + Lewis Acid/Base
--   8.  Bond Order, Length, and Energy
--   9.  Lewis Structures
--   10. Formal Charge
--   11. Resonance Structures
--   12. VSEPR Geometries
--   13. Electron vs Molecular Geometry
--   14. Molecular Polarity
--   15. Sigma vs Pi Bonds + Molecular Orbitals
--   16. Intermolecular Forces
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Chemistry: Atoms First 2e (Ch 4 Chemical Bonding, Ch 5
-- Molecular Geometry and Bonding Theories, Ch 10 Intermolecular Forces),
-- and the AAMC Foundation 5A Concept 1 content outline. See companion
-- .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'chemistry'
      AND title IN (
          'Bonding & Chemical Interactions',
          'Bonding and Chemical Interactions',
          'Bonding',
          'General Chemistry Review: Chapter Three: Bonding and Chemical Interactions'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'chemistry',
        'General Chemistry',
        'bonding_and_chemical_interactions',
        'Bonding & Chemical Interactions',
        'The octet rule and its exceptions; ionic and covalent bonding (formation, properties, polarity); electronegativity-difference cutoffs; coordinate covalent bonds and Lewis acid/base theory; bond order, length, and energy; Lewis structures and formal charge; resonance; VSEPR theory and the five core molecular geometries; electron vs molecular geometry; molecular polarity; sigma and pi bonds; and intermolecular forces (London dispersion, dipole-dipole, hydrogen bonding).',
        3
    )
    RETURNING id INTO deck;

    -- ── Bonding Fundamentals & Octet Rule ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'A {{c1::chemical bond}} is a strong attractive force between two atoms, formed through the interaction of their {{c2::valence electrons}}; the noble gases are the only elements that generally do not form bonds.',
     2),
    (deck, 1, 'cloze',
     'The {{c1::octet rule}} states that atoms tend to bond so that each ends up with {{c2::8}} valence electrons — the stable electron configuration of a noble gas.',
     2),
    (deck, 2, 'cloze',
     'Atoms gain, lose, or share electrons in pursuit of a {{c1::noble gas}} configuration; once that filled shell is achieved, the atom is energetically stable and unreactive.',
     1);

    -- ── Octet Rule Exceptions ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 3, 'cloze',
     'Some atoms are stable with fewer than 8 valence electrons — the {{c1::incomplete octet}} exception. Hydrogen and helium stop at 2; lithium, beryllium, and {{c2::boron}} stop short of 8.',
     2),
    (deck, 4, 'cloze',
     'Atoms in period {{c1::3}} or higher can hold more than 8 valence electrons — the {{c2::expanded octet}} exception — because they have empty {{c3::d}}-orbitals available for bonding.',
     3),
    (deck, 5, 'cloze',
     'Molecules with an {{c1::odd number}} of valence electrons (e.g., NO, NO2) cannot give every atom a full octet; one atom always carries an unpaired electron.',
     1);

    -- ── Ionic Bonds: Formation ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 6, 'cloze',
     'An {{c1::ionic bond}} is the electrostatic attraction between a {{c2::cation}} and an {{c2::anion}} formed when an atom with low ionization energy transfers electrons to an atom with high electron affinity.',
     2),
    (deck, 7, 'cloze',
     'Ionic bonds typically form between a {{c1::metal}} (low ionization energy → easily gives up electrons) and a {{c1::nonmetal}} (high electron affinity → readily accepts them).',
     1),
    (deck, 8, 'cloze',
     'Two atoms whose electronegativity difference exceeds about {{c1::1.7}} typically form an {{c2::ionic}} bond — the difference is large enough that one atom fully captures the bonding electrons.',
     2),
    (deck, 9, 'cloze',
     'An atom that loses electrons becomes a positively charged {{c1::cation}}; an atom that gains electrons becomes a negatively charged {{c1::anion}}.',
     1);

    -- ── Ionic Bonds: Properties ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
     'Ionic compounds have very {{c1::high}} melting and boiling points because breaking the lattice requires overcoming strong electrostatic attractions between many ions at once.',
     1),
    (deck, 11, 'cloze',
     'In the solid state, ionic compounds form a {{c1::crystalline lattice}} of alternating positive and negative ions — geometry that {{c2::maximizes}} attraction between opposite charges and {{c2::minimizes}} repulsion between like charges.',
     2),
    (deck, 12, 'cloze',
     'Solid ionic compounds do {{c1::not}} conduct electricity because ions are locked in place; in {{c2::molten or aqueous}} form, the freed ions can move and the compound becomes a good conductor.',
     2);

    -- ── Covalent Bonds: Formation ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 13, 'cloze',
     'A {{c1::covalent bond}} forms when two atoms share one or more pairs of electrons; this happens between atoms with {{c2::similar}} electronegativities (typically two nonmetals).',
     2),
    (deck, 14, 'cloze',
     'When two atoms have similar electronegativities, the energy cost of fully transferring an electron is greater than the energy gained from forming ions, so they {{c1::share}} electrons instead.',
     1),
    (deck, 15, 'cloze',
     'Covalent compounds typically form discrete molecular units held together by weak intermolecular forces — they have {{c1::lower}} melting and boiling points than ionic compounds and are usually {{c2::poor}} conductors of electricity.',
     2);

    -- ── Covalent Polarity (EN Cutoffs) ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 16, 'cloze',
     'By electronegativity difference (ΔEN): {{c1::< 0.5}} → nonpolar covalent; {{c1::0.5–1.7}} → polar covalent; {{c1::> 1.7}} → ionic.',
     1),
    (deck, 17, 'cloze',
     'A {{c1::nonpolar covalent}} bond shares electrons {{c2::equally}} between the two atoms; bonds between identical atoms (e.g., H–H, O=O) are always nonpolar covalent.',
     2),
    (deck, 18, 'cloze',
     'A {{c1::polar covalent}} bond shares electrons {{c2::unequally}}: the more electronegative atom takes a partial negative charge (δ–) and the less electronegative atom takes a partial positive charge (δ+).',
     2),
    (deck, 19, 'cloze',
     'The {{c1::dipole moment}} of a polar bond is a vector p = qd, where q is the partial charge and d is the separation; it points from {{c2::positive to negative}} and is measured in {{c3::debye}} units.',
     3);

    -- ── Coordinate Covalent + Lewis Acid/Base ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
     'In a {{c1::coordinate covalent}} (dative) bond, both shared electrons originate from the {{c2::same atom}} rather than one from each — a lone pair on one atom fills an empty orbital on the other.',
     2),
    (deck, 21, 'cloze',
     'A {{c1::Lewis acid}} is an electron-pair {{c2::acceptor}}; a {{c1::Lewis base}} is an electron-pair {{c2::donor}}. Their bonding produces a coordinate covalent bond.',
     2),
    (deck, 22, 'cloze',
     'Once a coordinate covalent bond forms, it is {{c1::indistinguishable}} from a normal covalent bond — both involve a shared electron pair; the distinction is only about the electrons'' {{c2::origin}}.',
     2);

    -- ── Bond Order, Length, and Energy ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 23, 'cloze',
     '{{c1::Bond order}} is the number of shared electron pairs between two atoms: {{c2::single}} bond = 1, {{c2::double}} bond = 2, {{c2::triple}} bond = 3.',
     2),
    (deck, 24, 'cloze',
     'As bond order increases, the two nuclei are pulled closer together, so bond length {{c1::decreases}}; triple bonds are shorter than double, which are shorter than single.',
     1),
    (deck, 25, 'cloze',
     'As bond order increases, bond energy {{c1::increases}}; breaking a triple bond requires more energy than a double, which requires more than a single.',
     1),
    (deck, 26, 'cloze',
     'Bond length and bond strength are {{c1::inversely}} related: shorter bonds are stronger, and longer bonds are weaker. Triple bonds are the {{c2::shortest and strongest}}; single bonds are the longest and weakest.',
     2);

    -- ── Lewis Structures ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 27, 'cloze',
     'A {{c1::Lewis structure}} (Lewis dot diagram) shows the bonding in a molecule using dots for each {{c2::valence}} electron and lines for shared pairs, including any {{c3::lone pairs}}.',
     3),
    (deck, 28, 'cloze',
     'When drawing a Lewis structure, the {{c1::least electronegative}} atom (other than hydrogen, which can never be central) goes in the center.',
     1),
    (deck, 29, 'cloze',
     'To draw a Lewis structure: sum {{c1::valence electrons}} from all atoms (adjust for charge); place single bonds to the central atom; complete octets on the outer atoms; place leftover electrons on the {{c2::central atom}}.',
     2),
    (deck, 30, 'cloze',
     'If the central atom is left with fewer than 8 valence electrons after the first pass, convert lone pairs on outer atoms into {{c1::double or triple}} bonds to satisfy the octet.',
     1);

    -- ── Formal Charge ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 31, 'cloze',
     '{{c1::Formal charge}} = V − (lone-pair electrons) − ½·(bonding electrons), where V is the atom''s neutral valence electron count.',
     1),
    (deck, 32, 'cloze',
     'The sum of the formal charges of all atoms in a molecule or ion equals the overall {{c1::charge}} of that molecule or ion.',
     1),
    (deck, 33, 'cloze',
     'The best Lewis structure minimizes both the {{c1::number}} and the {{c1::magnitude}} of formal charges; whenever possible, every atom carries a formal charge of zero.',
     1),
    (deck, 34, 'cloze',
     '{{c1::Formal charge}} assumes electrons are shared equally and so underestimates the effect of electronegativity; {{c2::oxidation number}} assumes the more electronegative atom takes all bonding electrons and so overestimates it.',
     2);

    -- ── Resonance Structures ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
     '{{c1::Resonance structures}} are alternate Lewis structures of the same molecule that differ only in the placement of {{c2::electrons}}, not atoms; they are drawn with a {{c3::double-headed arrow}} between them.',
     3),
    (deck, 36, 'cloze',
     'The actual molecule is none of the individual resonance structures — it is a {{c1::resonance hybrid}}, an average that combines them. Delocalization across multiple structures {{c2::stabilizes}} the molecule.',
     2),
    (deck, 37, 'cloze',
     'More stable (and major-contributor) resonance structures have {{c1::smaller}} formal charges, {{c1::less}} separation of opposite charges, and place any {{c1::negative}} formal charge on the more electronegative atom.',
     1),
    (deck, 38, 'cloze',
     'If two proposed Lewis structures differ in {{c1::bond connectivity}} or atom arrangement, they are different {{c2::compounds}}, not resonance structures of the same compound.',
     2);

    -- ── VSEPR Geometries ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 39, 'cloze',
     '{{c1::VSEPR (Valence Shell Electron Pair Repulsion)}} theory predicts molecular geometry by arranging electron-pair regions around the central atom as {{c2::far apart}} as possible to minimize repulsion.',
     2),
    (deck, 40, 'cloze',
     '{{c1::2}} regions of electron density around the central atom give a {{c2::linear}} geometry with a {{c3::180°}} bond angle (e.g., CO2, BeCl2).',
     3),
    (deck, 41, 'cloze',
     '{{c1::3}} regions of electron density give a {{c2::trigonal planar}} geometry with {{c3::120°}} bond angles (e.g., BF3, SO3).',
     3),
    (deck, 42, 'cloze',
     '{{c1::4}} regions of electron density give a {{c2::tetrahedral}} geometry with {{c3::109.5°}} bond angles (e.g., CH4, NH4+).',
     3),
    (deck, 43, 'cloze',
     '{{c1::5}} regions of electron density give a {{c2::trigonal bipyramidal}} geometry with {{c3::90°, 120°, and 180°}} bond angles (e.g., PCl5).',
     3),
    (deck, 44, 'cloze',
     '{{c1::6}} regions of electron density give an {{c2::octahedral}} geometry with {{c3::90° and 180°}} bond angles (e.g., SF6).',
     3);

    -- ── Electron vs Molecular Geometry ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 45, 'cloze',
     '{{c1::Electron geometry}} describes the arrangement of all electron-pair regions around the central atom, counting both {{c2::bonding pairs and lone pairs}}.',
     2),
    (deck, 46, 'cloze',
     '{{c1::Molecular geometry}} describes the arrangement of just the {{c2::bonded atoms}} around the central atom; lone pairs are still present but no longer reflected in the shape''s name.',
     2),
    (deck, 47, 'cloze',
     'Water has 4 electron regions ({{c1::tetrahedral}} electron geometry) but only 2 bonded atoms, so its molecular geometry is {{c2::bent}} with a bond angle near 104.5°.',
     2);

    -- ── Molecular Polarity ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 48, 'cloze',
     'A molecule with only {{c1::nonpolar}} bonds is always nonpolar overall — there are no bond dipoles to cancel or reinforce.',
     1),
    (deck, 49, 'cloze',
     'A molecule with polar bonds may be polar or nonpolar overall: if molecular geometry is {{c1::symmetric}}, the bond dipoles cancel and the molecule is nonpolar (e.g., CO2).',
     1),
    (deck, 50, 'cloze',
     'When polar bond dipoles do {{c1::not}} cancel because of asymmetric geometry, the molecule has a net {{c2::dipole moment}} and is overall polar (e.g., H2O).',
     2);

    -- ── Sigma vs Pi Bonds + Molecular Orbitals ──────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     'A {{c1::sigma (σ)}} bond is formed by the {{c2::head-on}} overlap of two atomic orbitals along the internuclear axis; every single bond is a sigma bond.',
     2),
    (deck, 52, 'cloze',
     'A {{c1::pi (π)}} bond is formed by the {{c2::side-by-side}} overlap of two parallel p-orbitals; pi bonds are only present in double and triple bonds, never in a single bond alone.',
     2),
    (deck, 53, 'cloze',
     'A {{c1::single}} bond = 1 σ; a {{c1::double}} bond = 1 σ + 1 π; a {{c1::triple}} bond = 1 σ + 2 π.',
     1),
    (deck, 54, 'cloze',
     'When two atomic orbitals overlap with the same sign, a {{c1::bonding}} molecular orbital forms; when they overlap with opposite signs, an {{c1::antibonding}} molecular orbital forms.',
     1);

    -- ── Intermolecular Forces ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 55, 'cloze',
     'From weakest to strongest, the three main intermolecular forces are: {{c1::London dispersion}} < {{c1::dipole-dipole}} < {{c1::hydrogen bonding}}.',
     1),
    (deck, 56, 'cloze',
     '{{c1::London dispersion (van der Waals)}} forces arise from {{c2::temporary}} dipoles created by random fluctuations in electron distribution; they are present in all atoms and molecules.',
     2),
    (deck, 57, 'cloze',
     'London dispersion forces grow stronger with greater {{c1::molecular size}} and {{c1::surface area}}, because larger electron clouds are easier to polarize and produce larger temporary dipoles.',
     1),
    (deck, 58, 'cloze',
     '{{c1::Dipole-dipole}} interactions occur between molecules that carry {{c2::permanent}} dipoles; the partial-positive end of one molecule is attracted to the partial-negative end of another.',
     2),
    (deck, 59, 'cloze',
     'A {{c1::hydrogen bond}} is an unusually strong dipole-dipole interaction between an H atom covalently bonded to {{c2::N, O, or F}} and a lone pair on a nearby N, O, or F.',
     2),
    (deck, 60, 'cloze',
     'Hydrogen bonding raises a substance''s boiling point dramatically — it explains why {{c1::water}} (mw 18) is a liquid at room temperature while methane (mw 16) is a gas.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 61;
END $$;
