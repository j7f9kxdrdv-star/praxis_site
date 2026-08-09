-- ════════════════════════════════════════════════════════════════════
-- Organic Chemistry Chapter 11 — Spectroscopy
-- ════════════════════════════════════════════════════════════════════
-- Section: organic_chemistry
-- Topic:   Organic Chemistry
-- Subtopic slug: spectroscopy
-- Sort order: 11
--
-- Coverage (AAMC-aligned order):
--   1.  IR Spectroscopy Fundamentals
--   2.  IR Vibration Types
--   3.  IR Detection Rule (Dipole Change)
--   4.  IR Fingerprint Region
--   5.  IR — O-H Group (Alcohol vs Carboxylic Acid)
--   6.  IR — Other Functional Groups (N-H, C=O)
--   7.  UV-Vis Spectroscopy Fundamentals
--   8.  HOMO/LUMO and Energy Gap
--   9.  UV and Conjugation
--   10. NMR Fundamentals (Nuclear Spin)
--   11. Chemical Shift + TMS Calibration
--   12. Shielding and Deshielding
--   13. 1H NMR: Equivalence + Integration
--   14. Spin-Spin Coupling + n+1 Rule
--   15. 1H NMR Chemical Shift Ranges I (sp³, sp², sp)
--   16. 1H NMR Chemical Shift Ranges II (Aromatic, Aldehyde, Carboxylic Acid)
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- LibreTexts Organic Chemistry (IR Spectroscopy; UV-Vis Spectroscopy; NMR
-- Spectroscopy), and the AAMC Foundation 5D Concept 4 content outline.
-- See companion .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'organic_chemistry'
      AND title IN (
          'Spectroscopy',
          'Organic Chemistry Review, Chapter 11: Spectroscopy'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'organic_chemistry',
        'Organic Chemistry',
        'spectroscopy',
        'Spectroscopy',
        'Infrared (IR) spectroscopy (vibration types, dipole-change selection rule, fingerprint region, O-H/N-H/C=O diagnostic peaks); ultraviolet-visible (UV-Vis) spectroscopy (electronic transitions, HOMO/LUMO energy gap, the effect of conjugation on lambda_max); and nuclear magnetic resonance (NMR) spectroscopy (nuclear spin states, chemical shift in ppm, TMS calibration, shielding and deshielding, equivalent protons and integration, spin-spin coupling and the n+1 rule, and the standard 1H NMR chemical-shift ranges for sp3, sp2, sp, aromatic, aldehyde, and carboxylic acid protons).',
        11
    )
    RETURNING id INTO deck;

    -- ── IR Spectroscopy Fundamentals ────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     '{{c1::Infrared (IR) spectroscopy}} measures the absorption of {{c2::infrared light}}, which excites bonds into higher vibrational states; it is primarily used to identify the {{c3::functional groups}} present in a molecule.',
     3),
    (deck, 1, 'cloze',
     'The IR light range used in spectroscopy spans from about {{c1::700 nm}} (near-IR) to {{c1::1 mm}} (far-IR); typical organic spectroscopy uses the mid-IR range.',
     1),
    (deck, 2, 'cloze',
     'An IR spectrum is plotted as percent {{c1::transmittance}} on the y-axis vs {{c2::wavenumber (cm⁻¹)}} on the x-axis; the typical scan range is 4000-400 cm⁻¹.',
     2);

    -- ── IR Vibration Types ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 3, 'cloze',
     'The four IR-active vibrational modes are {{c1::symmetric stretch}}, {{c1::asymmetric stretch}}, {{c1::symmetric bend}}, and {{c1::asymmetric bend}}.',
     1),
    (deck, 4, 'cloze',
     '{{c1::Stretching}} vibrations change the {{c2::bond length}} between two atoms; {{c1::bending}} vibrations change the {{c2::angle}} between bonds.',
     2);

    -- ── IR Detection Rule (Dipole Change) ───────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 5, 'cloze',
     'For a vibration to absorb IR light, the vibration must produce a change in the {{c1::bond dipole moment}}; this is the IR selection rule.',
     1),
    (deck, 6, 'cloze',
     'Symmetric homonuclear diatomics like {{c1::N₂, O₂, H₂}} do NOT absorb IR light because their bond vibrations cause no change in {{c2::dipole moment}}.',
     2),
    (deck, 7, 'cloze',
     '{{c1::Transmittance}} is the fraction of incident IR light that passes through the sample to the detector; an absorption peak appears as a {{c2::dip}} in transmittance.',
     2);

    -- ── IR Fingerprint Region ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     'The {{c1::fingerprint region}} of an IR spectrum lies between {{c2::1500 and 400 cm⁻¹}} and contains a complex pattern of peaks unique to each molecule.',
     2),
    (deck, 9, 'cloze',
     'The fingerprint region is used to confirm a substance''s {{c1::identity}} by matching its peak pattern to a known reference; the diagnostic region (>1500 cm⁻¹) shows functional groups.',
     1);

    -- ── IR — O-H Group ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
     'The {{c1::O-H}} stretch produces a {{c2::broad}} (wide) peak in the IR spectrum because hydrogen bonding spreads the absorption across a range of frequencies.',
     2),
    (deck, 11, 'cloze',
     'The {{c1::alcohol O-H}} stretch appears around {{c2::3300 cm⁻¹}}; the {{c1::carboxylic acid O-H}} stretch is shifted lower (around {{c2::3000 cm⁻¹}}) and is even broader.',
     2),
    (deck, 12, 'cloze',
     'The O-H peak of a carboxylic acid is shifted to a {{c1::lower wavenumber}} than an alcohol because the adjacent {{c2::carbonyl}} pulls electron density out of the O-H bond, weakening it.',
     2);

    -- ── IR — Other Functional Groups ────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 13, 'cloze',
     'The {{c1::C=O (carbonyl)}} stretch appears as a {{c2::sharp, intense}} peak around {{c3::1700 cm⁻¹}} — present in aldehydes, ketones, carboxylic acids, esters, and amides.',
     3),
    (deck, 14, 'cloze',
     'The {{c1::N-H}} stretch sits in the same general region as O-H (~3300 cm⁻¹) but appears as a {{c2::sharp}} peak rather than broad — found in amines, imines, and amides.',
     2),
    (deck, 15, 'cloze',
     'Quick IR diagnostic peaks: {{c1::~3300 cm⁻¹}} broad = O-H (alcohol); {{c1::~3300 cm⁻¹}} sharp = N-H; {{c1::~1700 cm⁻¹}} sharp = C=O.',
     1);

    -- ── UV-Vis Spectroscopy Fundamentals ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 16, 'cloze',
     '{{c1::Ultraviolet-visible (UV-Vis) spectroscopy}} measures the absorption of UV/visible light, which excites {{c2::electrons}} from filled molecular orbitals into empty antibonding orbitals.',
     2),
    (deck, 17, 'cloze',
     'A UV-Vis spectrum is plotted as {{c1::absorbance}} on the y-axis vs {{c2::wavelength (nm)}} on the x-axis; the λₘₐₓ is the wavelength at which the molecule absorbs most strongly.',
     2),
    (deck, 18, 'cloze',
     'For a molecule to absorb UV light, it must contain {{c1::π electrons}} or {{c1::nonbonding (lone pair) electrons}} that can be promoted to higher-energy antibonding orbitals.',
     1),
    (deck, 19, 'cloze',
     'UV samples are typically dissolved in an {{c1::inert, non-absorbent solvent}} (e.g., water, ethanol, or hexane) to avoid background interference at the wavelengths of interest.',
     1);

    -- ── HOMO/LUMO and Energy Gap ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
     'The {{c1::HOMO}} (Highest Occupied Molecular Orbital) is the highest-energy orbital containing electrons; the {{c1::LUMO}} (Lowest Unoccupied Molecular Orbital) is the lowest-energy empty orbital.',
     1),
    (deck, 21, 'cloze',
     'In UV absorption, an electron is promoted from the {{c1::HOMO}} to the {{c1::LUMO}}; the photon energy must exactly match the HOMO-LUMO energy gap.',
     1),
    (deck, 22, 'cloze',
     'A {{c1::smaller}} HOMO-LUMO energy gap means the molecule can absorb a {{c2::longer}} wavelength (lower-energy) photon — and the absorbance shifts toward the visible range.',
     2),
    (deck, 23, 'cloze',
     'A common UV-active transition is the {{c1::π → π*}} excitation in alkenes and aromatics; nonbonding electrons can also undergo {{c2::n → π*}} transitions in carbonyl compounds.',
     2);

    -- ── UV and Conjugation ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 24, 'cloze',
     'Increased {{c1::conjugation}} (longer chains of alternating single and double bonds) lowers the HOMO-LUMO energy gap, pushing λₘₐₓ toward {{c2::longer}} wavelengths (red shift).',
     2),
    (deck, 25, 'cloze',
     'The wavelength of maximum absorbance (λₘₐₓ) of a conjugated system tells you the {{c1::extent of conjugation}}: longer conjugated chains have larger λₘₐₓ values.',
     1);

    -- ── NMR Fundamentals ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
     '{{c1::Nuclear magnetic resonance (NMR) spectroscopy}} probes the {{c2::magnetic environments}} of certain atomic nuclei (most commonly ¹H or ¹³C) to determine molecular structure and connectivity.',
     2),
    (deck, 27, 'cloze',
     'In an external magnetic field, nuclei align in one of two states: the lower-energy {{c1::α (alpha)}} state aligned WITH the field, and the higher-energy {{c1::β (beta)}} state aligned AGAINST it.',
     1),
    (deck, 28, 'cloze',
     'NMR signals arise when nuclei absorb a {{c1::radiofrequency (RF) pulse}} whose energy exactly matches the α→β energy gap; this flip is called {{c2::resonance}}.',
     2);

    -- ── Chemical Shift + TMS Calibration ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     '{{c1::Chemical shift (δ)}} is reported in {{c2::parts per million (ppm)}} of the spectrometer''s operating frequency; this scale makes spectra comparable across different magnetic field strengths.',
     2),
    (deck, 30, 'cloze',
     'NMR spectra are calibrated using {{c1::tetramethylsilane (TMS)}}, whose protons are assigned a chemical shift of exactly {{c2::0 ppm}}.',
     2),
    (deck, 31, 'cloze',
     'Chemical shift in ppm makes spectra {{c1::independent}} of the spectrometer''s magnetic field strength; a peak at 5 ppm is at the same δ on a 60 MHz or a 600 MHz instrument.',
     1);

    -- ── Shielding and Deshielding ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     'On an NMR spectrum, chemical shift INCREASES to the {{c1::left}} (downfield, higher δ) and DECREASES to the {{c1::right}} (upfield, lower δ).',
     1),
    (deck, 33, 'cloze',
     '{{c1::Deshielding}} occurs when a nearby electron-withdrawing group pulls electron density {{c2::away from}} a proton; the bare nucleus feels the external magnetic field more strongly.',
     2),
    (deck, 34, 'cloze',
     'A deshielded proton appears further {{c1::downfield}} (higher chemical shift); a shielded proton — surrounded by electron density — appears further {{c1::upfield}} (lower chemical shift).',
     1);

    -- ── 1H NMR: Equivalence + Integration ───────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
     '{{c1::¹H NMR (proton NMR)}} is the most common variant; medical MRI uses the same proton-NMR principle as a non-invasive diagnostic tool.',
     1),
    (deck, 36, 'cloze',
     'Protons that share the same magnetic environment are {{c1::chemically equivalent}} and produce a single combined peak — even if there are many such protons.',
     1),
    (deck, 37, 'cloze',
     'In CH₃-CH₂-OH (ethanol) there are {{c1::three}} distinct sets of equivalent protons: 3 methyl Hs, 2 methylene Hs, and 1 hydroxyl H — giving 3 peaks on the spectrum.',
     1),
    (deck, 38, 'cloze',
     'The {{c1::area under each NMR peak}} (called the integration) is proportional to the {{c2::number of protons}} producing that peak — used to count protons of each type.',
     2);

    -- ── Spin-Spin Coupling + n+1 Rule ───────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 39, 'cloze',
     '{{c1::Spin-spin coupling (J-coupling)}} is the interaction between magnetic moments of {{c2::neighboring, non-equivalent}} protons; it splits NMR peaks into multiplets.',
     2),
    (deck, 40, 'cloze',
     'The {{c1::n+1 rule}}: a proton with {{c2::n}} non-equivalent neighbors (typically 3 bonds away) splits into {{c2::n+1}} peaks; e.g., 3 neighbors → quartet.',
     2),
    (deck, 41, 'cloze',
     'NMR splitting patterns: 0 neighbors → {{c1::singlet}} (1 peak); 1 neighbor → {{c1::doublet}} (2 peaks); 2 neighbors → {{c1::triplet}} (3 peaks); 3 neighbors → {{c1::quartet}} (4 peaks).',
     1),
    (deck, 42, 'cloze',
     'The spacing between split peaks is the {{c1::coupling constant (J)}}, measured in {{c2::Hertz (Hz)}}; coupled protons share the same J value.',
     2);

    -- ── 1H NMR Chemical Shift Ranges I (sp³, sp², sp) ───────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     'Protons on {{c1::sp³}} hybridized carbons appear in the {{c2::0-3 ppm}} range — alkanes and other saturated environments.',
     2),
    (deck, 44, 'cloze',
     'Protons on {{c1::sp²}} hybridized carbons (vinyl/alkene H) appear between {{c2::4.6-6.0 ppm}}.',
     2),
    (deck, 45, 'cloze',
     'Protons on {{c1::sp}} hybridized carbons (terminal alkyne H) appear between {{c2::2.0-3.0 ppm}} — counterintuitively in the same range as sp³, due to ring-current shielding effects.',
     2),
    (deck, 46, 'cloze',
     'Protons {{c1::α to a carbonyl}} (e.g., on -CH₂- next to C=O) typically appear around {{c2::2-3 ppm}}; the deshielding effect from the C=O moderately shifts them downfield.',
     2);

    -- ── 1H NMR Chemical Shift Ranges II ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 47, 'cloze',
     '{{c1::Aromatic}} protons (on a benzene-type ring) appear in the {{c2::6.0-8.5 ppm}} range — strongly deshielded by ring current effects.',
     2),
    (deck, 48, 'cloze',
     'The proton of an {{c1::aldehyde (-CHO)}} appears far downfield at {{c2::9-10 ppm}} because the carbonyl pulls electron density away from the C-H.',
     2),
    (deck, 49, 'cloze',
     'The acidic proton of a {{c1::carboxylic acid (-COOH)}} appears even further downfield at {{c2::10.5-12 ppm}} — the most deshielded common proton on MCAT NMR spectra.',
     2),
    (deck, 50, 'cloze',
     'Quick rule: the more electron density that is pulled {{c1::away from}} a proton, the more deshielded it becomes, and the further {{c2::downfield}} it appears on the spectrum.',
     2);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     'A mass spectrometer ionizes a sample in the {{c1::gas}} phase and separates the resulting ions by their {{c2::mass-to-charge ratio (m/z)}}.',
     2),
    (deck, 52, 'cloze',
     'In a mass spectrum, the vertical axis shows {{c1::relative abundance}} and the horizontal axis shows {{c2::m/z}}.',
     2),
    (deck, 53, 'cloze',
     'The {{c1::molecular-ion (parent)}} peak is the intact, unfragmented ion and gives the compound''s mass; the {{c2::base}} peak is the tallest (most abundant) peak, set to 100%.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 54;
END $$;
