-- Praxis Prep — Organic Chemistry Chapter 3: Bonding
-- v6-compliant flashcard deck (32 cards)
-- Subtopics: 3.1 Atomic Orbitals and Quantum Numbers (9),
-- 3.2 Molecular Orbitals (10), 3.3 Hybridization and Resonance (13).
-- Source-laundered against LibreTexts Organic Chemistry (atomic structure,
-- MO theory, hybridization, resonance), OpenStax Chemistry: Atoms First 2e
-- (Ch. 3 Electronic Structure, Ch. 5 Bonding, Ch. 8 Advanced Bonding Theories),
-- and AAMC content outline (CP 4A atomic structure, CP 5A bonding).
-- Per user direction, crossover cards with General Chemistry decks (Inside
-- the Atom, Bonding & Chemical Interactions) are retained for spaced-
-- repetition reinforcement with organic-specific framing.
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Bonding',
            'Organic Chemistry Chapter 3: Bonding',
            'Orgo Chapter 3: Bonding'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Bonding',
        'Organic Chemistry Chapter 3: Bonding',
        'Orgo Chapter 3: Bonding'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'organic_chemistry',
        'Organic Chemistry',
        'bonding',
        'Bonding',
        'Atomic orbitals and the four quantum numbers (principal n, azimuthal l with s/p/d/f subshells, magnetic m_l, spin m_s); orbital shapes (s, p, d); nodes and the Schrödinger probability framework; molecular orbital formation (bonding vs antibonding); sigma vs pi bonds with composition of single, double, and triple bonds; bond length and bond strength relationships; rotation restrictions including resonance-driven rigidity; hybridization (sp³, sp², sp) with geometry (109.5°, 120°, 180°), s-character percentages (25%, 33%, 50%), and the alkane/alkene/alkyne mapping; and resonance/conjugation (delocalization of pi electrons through aligned p orbitals, UV absorption, and weighted-average electron density biased toward the most stable resonance form).',
        3
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 3.1 Atomic Orbitals and Quantum Numbers (cards 1–9)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'An electron in an atom is described by four quantum numbers: {{c1::principal (n)}}, {{c1::azimuthal (l)}}, {{c1::magnetic (mₗ)}}, and {{c1::spin (mₛ)}}.',
        1),
    (deck, 1, 'cloze',
        'The {{c1::principal quantum number (n)}} corresponds to the {{c2::energy level (shell)}} and is essentially a measure of orbital {{c3::size}}; smaller n means lower energy and closer to the nucleus.',
        3),
    (deck, 2, 'cloze',
        'The {{c1::azimuthal quantum number (l)}} describes the {{c2::subshell shape}} and ranges from {{c3::0 to n − 1}}; values 0, 1, 2, 3 correspond to the {{c4::s, p, d, and f}} subshells.',
        4),
    (deck, 3, 'cloze',
        'The {{c1::magnetic quantum number (mₗ)}} describes the {{c2::orientation of the orbital}} within a subshell and ranges from {{c3::−l to +l}}.',
        3),
    (deck, 4, 'cloze',
        'The {{c1::spin quantum number (mₛ)}} indicates the electron''s spin direction, with only two possible values: {{c2::+1/2 or −1/2}}.',
        2),
    (deck, 5, 'cloze',
        'The {{c1::s orbital}} is {{c2::spherical and centered on the nucleus}}; the {{c1::p orbital}} has {{c2::two lobes (dumbbell-shaped) with a node at the nucleus}}; the {{c1::d orbital}} has {{c2::four lobes (clover-shaped, except the donut-around-axis variant)}} with two nodes.',
        2),
    (deck, 6, 'cloze',
        'A {{c1::node}} is a region where the {{c2::probability of finding an electron is zero}}.',
        2),
    (deck, 7, 'cloze',
        'Each orbital can hold at most {{c1::two electrons}}, which must have {{c2::opposite spins}} (one +1/2 and one −1/2) — the Pauli exclusion principle.',
        2),
    (deck, 8, 'cloze',
        'Atomic orbitals are described by wave functions derived from the {{c1::Schrödinger equation}}; the {{c2::probability density}} of finding an electron at a point equals {{c3::the square of the wave function (ψ²)}}.',
        3);

    -- ============================================================
    -- 3.2 Molecular Orbitals (cards 10–19)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
        'When two atomic orbitals combine, they form {{c1::molecular orbitals (MOs)}} via mathematical {{c2::addition or subtraction}} of the underlying atomic wave functions.',
        2),
    (deck, 10, 'cloze',
        'When wave functions have the {{c1::same}} sign (constructive interference), they form a {{c2::bonding MO}} that is {{c3::lower in energy and more stable}}; when they have {{c1::opposite}} signs (destructive interference), they form an {{c2::antibonding MO}} that is {{c3::higher in energy and less stable}}.',
        3),
    (deck, 11, 'cloze',
        'A {{c1::sigma (σ) bond}} forms by {{c2::head-to-head}} overlap of orbitals along the internuclear axis; every {{c3::single bond}} is a sigma bond.',
        3),
    (deck, 12, 'cloze',
        'A {{c1::pi (π) bond}} forms by {{c2::side-by-side overlap of parallel p orbitals}}, placing electron density above and below the internuclear axis.',
        2),
    (deck, 13, 'cloze',
        'Bond composition: a {{c1::single}} bond is 1 sigma; a {{c2::double}} bond is 1 sigma + 1 pi; a {{c3::triple}} bond is 1 sigma + 2 pi.',
        3),
    (deck, 14, 'cloze',
        'A pi bond {{c1::cannot exist independently}} of a sigma bond — the sigma bond must form {{c2::first}} so that the adjacent p orbitals end up {{c3::parallel}} and able to overlap side-by-side.',
        3),
    (deck, 15, 'cloze',
        '{{c1::Single bonds}} (pure sigma) allow {{c2::free rotation}} around the bond axis; {{c1::double and triple bonds}} {{c2::restrict rotation}}, locking the atoms in place.',
        2),
    (deck, 16, 'cloze',
        'As the number of bonds between two atoms increases, bond length {{c1::decreases}} and bond strength {{c2::increases}} — triple < double < single in length, and triple > double > single in strength.',
        2),
    (deck, 17, 'cloze',
        'An individual pi bond is {{c1::weaker}} than a sigma bond, but bond strengths are {{c2::additive}}, so a double bond is overall {{c3::stronger}} than a single bond.',
        3),
    (deck, 18, 'cloze',
        '{{c1::Partial double-bond character}} from resonance also restricts free rotation, producing {{c2::more rigid}} molecular structures.',
        2);

    -- ============================================================
    -- 3.3 Hybridization and Resonance (cards 20–32)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 19, 'cloze',
        '{{c1::Hybrid orbitals}} are formed by {{c2::mathematically mixing one s orbital with one or more p orbitals}} to produce equivalent, energetically identical orbitals optimized for bonding.',
        2),
    (deck, 20, 'cloze',
        '{{c1::sp³ hybridization}} mixes 1 s and 3 p orbitals to form {{c2::four equivalent orbitals at 109.5° (tetrahedral)}}; this is the geometry of saturated carbons in {{c3::alkanes}}.',
        3),
    (deck, 21, 'cloze',
        '{{c1::sp² hybridization}} mixes 1 s and 2 p orbitals to form {{c2::three orbitals at 120° (trigonal planar)}}; the remaining {{c3::unhybridized p orbital}} forms the pi bond — geometry of {{c4::alkenes}}.',
        4),
    (deck, 22, 'cloze',
        '{{c1::sp hybridization}} mixes 1 s and 1 p orbital to form {{c2::two orbitals at 180° (linear)}}; the {{c3::two remaining unhybridized p orbitals}} form the two pi bonds of a triple bond — geometry of {{c4::alkynes}}.',
        4),
    (deck, 23, 'cloze',
        's-character by hybridization: {{c1::sp³}} = {{c2::25%}} s-character, {{c1::sp²}} = {{c2::33%}}, and {{c1::sp}} = {{c2::50%}}.',
        2),
    (deck, 24, 'cloze',
        'The more s-character in a hybrid orbital, the {{c1::shorter}} and {{c2::stronger}} the resulting bond (because s orbitals hold electron density closer to the nucleus than p orbitals).',
        2),
    (deck, 25, 'cloze',
        '{{c1::Resonance}} is the {{c2::delocalization of pi electrons or lone pairs}} across multiple atoms, producing a more stable structure than any single Lewis form predicts.',
        2),
    (deck, 26, 'cloze',
        '{{c1::Conjugation}} requires {{c2::alternating single and multiple bonds}} so that {{c3::unhybridized p orbitals line up along the molecular backbone}}.',
        3),
    (deck, 27, 'cloze',
        'In a conjugated system, the aligned p orbitals overlap continuously, allowing pi electrons to {{c1::delocalize}} through the {{c2::shared p orbital backbone}}.',
        2),
    (deck, 28, 'cloze',
        'Delocalization through conjugation {{c1::adds stability}} to a molecule by {{c2::spreading electron density over more atoms}}.',
        2),
    (deck, 29, 'cloze',
        'Conjugated systems also enable {{c1::UV absorption}} — the more extensive the conjugation, the {{c2::longer the wavelength}} of light absorbed.',
        2),
    (deck, 30, 'cloze',
        'Resonance forms differ only in {{c1::the placement of electrons}}; the {{c2::positions of the atoms remain fixed}}.',
        2),
    (deck, 31, 'cloze',
        'The true electron distribution is a {{c1::weighted average}} of all resonance forms, biased toward the {{c2::most stable}} resonance form when their stabilities differ.',
        2);

    RAISE NOTICE 'Seeded deck % with 32 cards.', deck;
END $$;
