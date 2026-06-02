-- Praxis Prep — Physics Chapter 9: Atomic and Nuclear Phenomena
-- v6-compliant flashcard deck (40 cards)
-- Subtopics: 9.1 Photoelectric Effect (9), 9.2 Absorption and Emission (5),
-- 9.3 Nuclear Forces and Binding Energy (7), 9.4 Nuclear Reactions (5),
-- 9.5 Radioactive Decay (9), 9.6 Half-Life and Exponential Decay (5).
-- Source-laundered against OpenStax College Physics 2e (Ch. 29 photons / Ch. 30 atomic physics
-- / Ch. 31 radioactivity and nuclear physics), OpenStax University Physics Vol. 3, and
-- AAMC content outline (CP 4D — Atomic and Nuclear Phenomena).
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Atomic and Nuclear Phenomena',
            'Physics Chapter 9: Atomic and Nuclear Phenomena',
            'Physics Ch 9: Atomic and Nuclear Phenomena',
            'Physics Chapter 9 - Atomic and Nuclear Phenomena'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Physics Chapter 9: Atomic and Nuclear Phenomena',
        'Physics Ch 9: Atomic and Nuclear Phenomena',
        'Physics Chapter 9 - Atomic and Nuclear Phenomena'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'physics',
        'Physics',
        'atomic and nuclear phenomena',
        'Atomic and Nuclear Phenomena',
        'The photoelectric effect (threshold frequency, photon energy E=hf, work function, max KE); absorption and emission spectra (Bohr model, IR, UV-Vis, fluorescence); nuclear forces (strong, weak), binding energy, and mass defect (E=mc^2); nuclear reactions (fusion, fission, isotopic notation); radioactive decay (alpha, beta-minus, beta-plus, gamma, electron capture); and half-life with exponential decay.',
        9
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 9.1 The Photoelectric Effect (cards 1–9)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'The {{c1::photoelectric effect}} ejects {{c2::electrons}} from a {{c3::metal surface}} when struck by light of {{c4::sufficient frequency}}.',
        4),
    (deck, 1, 'cloze',
        'The {{c1::threshold frequency (f_T)}} is the minimum incident-light frequency needed to {{c2::eject an electron}} from a given metal; it depends on the metal''s {{c3::work function}}.',
        3),
    (deck, 2, 'cloze',
        'Whether emission happens depends on photon {{c1::frequency}}, not on {{c2::intensity}} — below the threshold frequency, even a {{c3::very bright (high-intensity)}} beam ejects nothing.',
        3),
    (deck, 3, 'cloze',
        'Once light''s frequency is above the threshold, the resulting current is proportional to the {{c1::intensity}} of the beam — more {{c2::photons per second}} eject more {{c3::electrons per second}}.',
        3),
    (deck, 4, 'cloze',
        'The energy of a single photon is given by {{c1::E = hf}}, where h is {{c2::Planck''s constant}} and f is the {{c3::light frequency}}.',
        3),
    (deck, 5, 'cloze',
        'The {{c1::work function (W)}} is the minimum energy required to {{c2::liberate an electron}} from a particular metal''s surface; it is a {{c3::property of the metal}}.',
        3),
    (deck, 6, 'cloze',
        'The work function relates to the threshold frequency by {{c1::W = h · f_T}} (Planck''s constant times the threshold frequency).',
        1),
    (deck, 7, 'cloze',
        'The maximum kinetic energy of an ejected electron is {{c1::K_max = hf − W}} — the photon''s energy minus the energy spent {{c2::escaping the metal}}.',
        2),
    (deck, 8, 'cloze',
        'The greater the incident photon''s energy {{c1::above the work function}}, the {{c2::more kinetic energy}} the ejected electron carries away.',
        2);

    -- ============================================================
    -- 9.2 Absorption and Emission of Light (cards 10–14)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
        'The {{c1::Bohr model}} states that electrons occupy {{c2::discrete energy levels}} — only specific orbits are allowed, not a continuous range.',
        2),
    (deck, 10, 'cloze',
        'An electron absorbs or emits a photon whose energy equals {{c1::the difference between two energy levels (ΔE)}}; this is why each element has a characteristic {{c2::absorption and emission spectrum}}.',
        2),
    (deck, 11, 'cloze',
        '{{c1::Infrared (IR) spectroscopy}} probes molecular {{c2::vibrations}} and is used to identify {{c3::functional groups}} in a compound.',
        3),
    (deck, 12, 'cloze',
        '{{c1::UV-Vis spectroscopy}} probes {{c2::electronic transitions}} and is especially sensitive to {{c3::conjugated π-systems}}.',
        3),
    (deck, 13, 'cloze',
        'In {{c1::fluorescence}}, a molecule absorbs a {{c2::high-frequency}} photon, then returns to the ground state in {{c3::multiple steps}}, re-emitting {{c4::longer-wavelength}} photons.',
        4);

    -- ============================================================
    -- 9.3 Nuclear Forces, Binding Energy, and Mass Defect (cards 15–21)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 14, 'cloze',
        'The {{c1::strong nuclear force}} is a {{c2::short-range}} attractive force that holds {{c3::protons and neutrons}} together inside the nucleus.',
        3),
    (deck, 15, 'cloze',
        'The {{c1::weak nuclear force}} is a short-range force responsible for certain types of {{c2::radioactive decay}}, notably {{c3::beta decay}}.',
        3),
    (deck, 16, 'cloze',
        'The four fundamental forces, listed from strongest to weakest, are {{c1::strong nuclear}}, {{c1::electromagnetic}}, {{c1::weak nuclear}}, and {{c1::gravitational}}.',
        1),
    (deck, 17, 'cloze',
        'The {{c1::mass defect}} is the difference between the sum of the masses of {{c2::free nucleons}} and the actual mass of the {{c3::assembled nucleus}}.',
        3),
    (deck, 18, 'cloze',
        'The mass defect corresponds to energy released when the nucleus formed, via Einstein''s relation {{c1::E = mc²}} — a tiny mass becomes {{c2::a large amount of energy}}.',
        2),
    (deck, 19, 'cloze',
        '{{c1::Nuclear binding energy}} is the energy required to {{c2::disassemble a nucleus}} into its individual {{c3::protons and neutrons}}.',
        3),
    (deck, 20, 'cloze',
        'Stability is measured by {{c1::binding energy per nucleon}}, which peaks near {{c2::iron-56}} — this is why both fusion of small nuclei and {{c3::fission of large nuclei}} release energy.',
        3);

    -- ============================================================
    -- 9.4 Nuclear Reactions (cards 22–26)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 21, 'cloze',
        'In isotopic notation {{c1::^A_Z X}}, the {{c2::mass number (A)}} appears on top and the {{c3::atomic number (Z)}} appears on the bottom of the element symbol.',
        3),
    (deck, 22, 'cloze',
        'The atomic number Z counts {{c1::protons}}, the mass number A counts {{c2::protons + neutrons}}, so the neutron count is {{c3::A − Z}}.',
        3),
    (deck, 23, 'cloze',
        '{{c1::Fusion}} combines {{c2::small nuclei}} into a larger one, while {{c1::fission}} splits {{c2::a large nucleus}} into smaller ones.',
        2),
    (deck, 24, 'cloze',
        'Both fusion and fission release energy because the products have {{c1::higher binding energy per nucleon}}, and the {{c2::lost mass}} converts to energy via {{c3::E = mc²}}.',
        3),
    (deck, 25, 'cloze',
        'Fusion requires extreme {{c1::temperature and pressure}} to overcome the {{c2::electrostatic (Coulomb) repulsion}} between positive nuclei — which is why it powers {{c3::stars}}.',
        3);

    -- ============================================================
    -- 9.5 Radioactive Decay (cards 27–35)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
        '{{c1::Radioactive decay}} is the spontaneous emission of {{c2::particles or energy}} from an {{c3::unstable nucleus}}.',
        3),
    (deck, 27, 'cloze',
        'An {{c1::alpha (α) particle}} is a {{c2::helium-4 nucleus, ⁴₂He}}, consisting of {{c3::2 protons and 2 neutrons}}.',
        3),
    (deck, 28, 'cloze',
        'In {{c1::alpha decay}}, the nucleus emits an α particle (⁴₂He), so Z {{c2::decreases by 2}} and A {{c3::decreases by 4}}.',
        3),
    (deck, 29, 'cloze',
        'In {{c1::beta-minus (β⁻) decay}}, a {{c2::neutron converts to a proton}}, emitting an {{c3::electron and an antineutrino}}; Z increases by 1 and A is {{c4::unchanged}}.',
        4),
    (deck, 30, 'cloze',
        'In {{c1::beta-plus (β⁺) decay}}, a {{c2::proton converts to a neutron}}, emitting a {{c3::positron and a neutrino}}; Z decreases by 1 and A is {{c4::unchanged}}.',
        4),
    (deck, 31, 'cloze',
        'A {{c1::positron}} is the antiparticle of the electron — same {{c2::mass as an electron}} but with charge {{c3::+1}}.',
        3),
    (deck, 32, 'cloze',
        'An {{c1::antineutrino}} accompanies {{c2::β⁻}} decay, while a {{c1::neutrino}} accompanies {{c2::β⁺}} decay.',
        2),
    (deck, 33, 'cloze',
        'In {{c1::gamma (γ) decay}}, an {{c2::excited nucleus}} releases a high-energy photon as it relaxes to the {{c3::ground state}}; both Z and A are {{c4::unchanged}}.',
        4),
    (deck, 34, 'cloze',
        'In {{c1::electron capture}}, the nucleus pulls in an {{c2::inner-shell electron}}, converting a proton to a neutron and emitting a {{c3::neutrino}}; Z decreases by 1 and A is {{c4::unchanged}}.',
        4);

    -- ============================================================
    -- 9.6 Half-Life and Exponential Decay (cards 36–40)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
        'The {{c1::half-life (t½)}} of a radioactive sample is the time required for {{c2::half of the original nuclei}} to decay.',
        2),
    (deck, 36, 'cloze',
        'Half-life relates to the decay constant by {{c1::t½ = 0.693 / λ}} (equivalently, ln 2 ÷ λ).',
        1),
    (deck, 37, 'cloze',
        'The number of nuclei remaining at time t is {{c1::n(t) = n₀ · e^(−λt)}}, where n₀ is the {{c2::starting number}} and λ is the {{c3::decay constant}}.',
        3),
    (deck, 38, 'cloze',
        'After n half-lives, the fraction of the original sample remaining is {{c1::(½)^n}} — so {{c2::¼}} remains after 2 half-lives and {{c3::⅛}} remains after 3.',
        3),
    (deck, 39, 'cloze',
        'After roughly {{c1::7 to 8 half-lives}}, a radioactive sample is considered effectively fully decayed — {{c2::less than 1%}} of the original sample remains.',
        2);

    RAISE NOTICE 'Seeded deck % with 40 cards.', deck;
END $$;
