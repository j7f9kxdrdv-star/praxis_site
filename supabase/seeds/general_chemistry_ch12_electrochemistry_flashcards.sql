-- ════════════════════════════════════════════════════════════════════
-- General Chemistry Chapter 12 — Electrochemistry
-- ════════════════════════════════════════════════════════════════════
-- Section: chemistry
-- Topic:   General Chemistry
-- Subtopic slug: electrochemistry
-- Sort order: 12
--
-- Coverage (AAMC-aligned order):
--   1.  Electrochemical Cell Fundamentals + Isoelectric Focusing
--   2.  Galvanic vs Electrolytic Cell Comparison
--   3.  Electrode Polarity Direction
--   4.  Daniell Cell
--   5.  Salt Bridge
--   6.  Cell Diagrams
--   7.  Concentration Cells
--   8.  Rechargeable Batteries Overview
--   9.  Lead-Acid Battery
--   10. Ni-Cd and NiMH Batteries
--   11. Electrolytic Cells + Electrolysis
--   12. Faraday's Constant + Electrodeposition
--   13. Reduction Potentials + SHE
--   14. EMF Equation
--   15. EMF vs Thermodynamics
--   16. Nernst Equation + EMF vs Keq
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Chemistry: Atoms First 2e (Ch 17 Electrochemistry) and the
-- AAMC Foundation 5E Concept 2 content outline. See companion
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
          'Electrochemistry',
          'General Chemistry Review Chapter 12: Electrochemistry'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'chemistry',
        'General Chemistry',
        'electrochemistry',
        'Electrochemistry',
        'Electrochemical cell fundamentals (anode, cathode, electron and current flow); galvanic vs electrolytic cell comparison; electrode polarity; the Daniell cell as the canonical galvanic example; the salt bridge; cell diagram notation; concentration cells; rechargeable batteries (lead-acid, Ni-Cd, NiMH); electrolysis applications including molten NaCl and electroplating; Faraday''s constant and the electrodeposition equation; reduction potentials and the standard hydrogen electrode; the EMF equation (E°cell = E°cathode − E°anode); the link between EMF and thermodynamics (ΔG° = −nFE°cell = −RT ln Keq); the Nernst equation; and isoelectric focusing as a biochemistry application of electromigration.',
        12
    )
    RETURNING id INTO deck;

    -- ── Electrochemical Cell Fundamentals + IEF ─────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'An {{c1::electrochemical cell}} is a contained system where redox reactions occur, with separate sites for oxidation and reduction so that the electron transfer can do useful electrical work.',
     1),
    (deck, 1, 'cloze',
     'The {{c1::anode}} is the electrode where {{c2::oxidation}} occurs; the {{c1::cathode}} is the electrode where {{c2::reduction}} occurs — true in every electrochemical cell, galvanic or electrolytic.',
     2),
    (deck, 2, 'cloze',
     'A useful mnemonic: {{c1::An Ox}} (Anode = Oxidation) and {{c1::Red Cat}} (Reduction = Cathode) — anode = oxidation site, cathode = reduction site, always.',
     1),
    (deck, 3, 'cloze',
     '{{c1::Electrons}} flow from anode to cathode through the external wire; {{c1::current}} (the flow of positive charge) runs in the opposite direction — cathode to anode.',
     1),
    (deck, 4, 'cloze',
     'In any electrochemical cell, the {{c1::cathode}} attracts {{c2::cations}} (positive ions), and the {{c1::anode}} attracts {{c2::anions}} (negative ions).',
     2),
    (deck, 5, 'cloze',
     'In {{c1::isoelectric focusing (IEF)}}, an electric field is applied across a pH gradient; amino acids migrate until they reach the pH equal to their {{c2::isoelectric point (pI)}}, where their net charge is zero.',
     2),
    (deck, 6, 'cloze',
     'In IEF, an amino acid migrates toward the {{c1::cathode}} when its net charge is positive (pH < pI) and toward the {{c1::anode}} when its net charge is negative (pH > pI).',
     1);

    -- ── Galvanic vs Electrolytic Cell Comparison ────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
     '{{c1::Galvanic (voltaic) cells}} house spontaneous redox reactions (ΔG < 0, EMF > 0) and release energy; {{c1::electrolytic cells}} house nonspontaneous reactions (ΔG > 0, EMF < 0) and require external energy input.',
     1),
    (deck, 8, 'cloze',
     'In any electrochemical cell, {{c1::ΔG}} and {{c1::EMF}} always have opposite signs: ΔG < 0 (favorable) ↔ EMF > 0; ΔG > 0 (unfavorable) ↔ EMF < 0.',
     1),
    (deck, 9, 'cloze',
     'A {{c1::concentration cell}} is a special type of galvanic cell where the two electrodes are made of the {{c2::same material}}, and the EMF arises from a {{c3::concentration gradient}}.',
     3),
    (deck, 10, 'cloze',
     'Quick summary: {{c1::galvanic}} cells convert chemical energy to {{c2::electrical energy}}; {{c1::electrolytic}} cells convert electrical energy to chemical energy — they are opposite-direction processes.',
     2);

    -- ── Electrode Polarity Direction ────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 11, 'cloze',
     'In a {{c1::galvanic}} cell, the {{c2::anode}} carries the {{c3::negative (−)}} sign and the {{c2::cathode}} carries the positive (+) sign — electrons leave the anode and flow to the cathode.',
     3),
    (deck, 12, 'cloze',
     'In an {{c1::electrolytic}} cell, polarity is reversed: the {{c2::anode}} is positive (+) (connected to + of external source) and the {{c2::cathode}} is negative (−), but the oxidation/reduction sites stay the same.',
     2),
    (deck, 13, 'cloze',
     'In an electrolytic cell, the {{c1::anode}} (oxidation site) is connected to the {{c2::positive}} terminal of the external power source — that terminal pulls electrons away, driving oxidation at that electrode.',
     2);

    -- ── Daniell Cell ────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 14, 'cloze',
     'The {{c1::Daniell cell}} is a classic galvanic cell: a {{c2::zinc}} electrode sits in aqueous ZnSO₄, and a {{c3::copper}} electrode sits in aqueous CuSO₄.',
     3),
    (deck, 15, 'cloze',
     'At the Daniell cell anode, zinc metal is oxidized: {{c1::Zn(s) → Zn²⁺(aq) + 2e⁻}}; the zinc bar slowly dissolves into solution.',
     1),
    (deck, 16, 'cloze',
     'At the Daniell cell cathode, copper(II) ions are reduced: {{c1::Cu²⁺(aq) + 2e⁻ → Cu(s)}}; copper metal {{c2::plates onto}} the cathode (called galvanization).',
     2),
    (deck, 17, 'cloze',
     'The overall Daniell cell reaction is: {{c1::Zn(s) + Cu²⁺(aq) → Zn²⁺(aq) + Cu(s)}} — zinc dissolves, copper plates out, and electrical energy is generated.',
     1);

    -- ── Salt Bridge ─────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     'A {{c1::salt bridge}} (typically containing an inert salt like KNO₃) connects the two half-cells and allows ions to flow between compartments, maintaining {{c2::charge balance}} as the reaction proceeds.',
     2),
    (deck, 19, 'cloze',
     'In the salt bridge: {{c1::cations}} migrate toward the cathode compartment (which is gaining electrons), while {{c1::anions}} migrate toward the anode compartment (which is gaining positive ions).',
     1),
    (deck, 20, 'cloze',
     'Without a salt bridge, charge would quickly build up on each side (positive at the anode, negative at the cathode), stopping the reaction; the salt bridge {{c1::neutralizes}} this buildup.',
     1),
    (deck, 21, 'cloze',
     'The salt bridge also serves to {{c1::close the electrical circuit}} — without it, no continuous loop exists for current to flow, and the cell cannot deliver electrical energy.',
     1);

    -- ── Cell Diagrams ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 22, 'cloze',
     'A {{c1::cell diagram}} is shorthand for an electrochemical cell, listing species from left to right starting with the {{c2::anode}} and ending with the {{c3::cathode}}.',
     3),
    (deck, 23, 'cloze',
     'In a cell diagram, a {{c1::single vertical line ( | )}} marks a phase boundary; a {{c1::double vertical line ( || )}} marks a salt bridge or other barrier.',
     1),
    (deck, 24, 'cloze',
     'The Daniell cell diagram is written: {{c1::Zn(s) | Zn²⁺(1 M) || Cu²⁺(1 M) | Cu(s)}} — anode on the left, cathode on the right.',
     1),
    (deck, 25, 'cloze',
     'Example diagram with an SHE: Pt | H₂(1 atm) | H⁺(1 M) || Cu²⁺(1 M) | Cu(s) reads as the {{c1::SHE on the left (anode)}} paired with a copper electrode on the right (cathode), separated by a salt bridge.',
     1);

    -- ── Concentration Cells ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
     'In a concentration cell, current flows because of a {{c1::concentration gradient}} between the two half-cell solutions; ions move spontaneously toward {{c2::equilibrium}} concentrations.',
     2),
    (deck, 27, 'cloze',
     'In a concentration cell, the {{c1::dilute}} half-cell acts as the anode (oxidation increases ion concentration there), and the {{c1::concentrated}} half-cell acts as the cathode (reduction depletes ions there).',
     1),
    (deck, 28, 'cloze',
     'The voltage of a concentration cell is calculated using the {{c1::Nernst equation}}; at equilibrium the two concentrations equalize and EMF reaches {{c2::zero}}.',
     2);

    -- ── Rechargeable Batteries Overview ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     'A {{c1::rechargeable battery}} functions as a {{c2::galvanic}} cell while discharging (spontaneous) and as an {{c2::electrolytic}} cell while charging (driven by an external power source).',
     2),
    (deck, 30, 'cloze',
     '{{c1::Energy density}} is the amount of energy a battery can store per unit {{c2::mass}} (or volume); higher energy density means more energy from a lighter or smaller battery.',
     2),
    (deck, 31, 'cloze',
     'Battery performance is {{c1::temperature-dependent}}: cold reduces ion mobility and reaction kinetics, lowering effective EMF and discharge current — why car batteries struggle in winter.',
     1);

    -- ── Lead-Acid Battery ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     'A {{c1::lead-acid battery}} (lead storage battery) has a {{c2::Pb}} (lead) anode and a porous {{c2::PbO₂}} (lead(IV) oxide) cathode, both immersed in concentrated {{c3::H₂SO₄}}.',
     3),
    (deck, 33, 'cloze',
     'While discharging, both lead-acid electrodes become coated with {{c1::PbSO₄}} as Pb is oxidized at the anode and PbO₂ is reduced at the cathode, consuming sulfuric acid.',
     1),
    (deck, 34, 'cloze',
     'During charging, an external power source reverses the electrochemistry: PbSO₄ is converted back to {{c1::Pb}} and {{c1::PbO₂}}, regenerating the concentrated H₂SO₄ electrolyte.',
     1);

    -- ── Ni-Cd and NiMH Batteries ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
     'A {{c1::nickel-cadmium (Ni-Cd)}} battery (discharging) uses a {{c2::Cd}} anode and a {{c2::NiO(OH)}} cathode in a {{c3::KOH}} electrolyte.',
     3),
    (deck, 36, 'cloze',
     '{{c1::Nickel-metal hydride (NiMH)}} batteries are largely replacing Ni-Cd because they have higher energy density and avoid the toxicity of {{c2::cadmium}}.',
     2),
    (deck, 37, 'cloze',
     'A {{c1::surge current}} is a brief, larger-than-average current released early in a battery''s discharge cycle, before the steady-state operating current is established.',
     1);

    -- ── Electrolytic Cells + Electrolysis ───────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 38, 'cloze',
     '{{c1::Electrolysis}} is a redox reaction driven by an external voltage source — used to decompose compounds (e.g., splitting water into H₂ and O₂) or to refine metals.',
     1),
    (deck, 39, 'cloze',
     'Because the electrolytic reaction is nonspontaneous and only proceeds with external energy, electrolytic cells {{c1::do not}} require separate compartments or a {{c2::salt bridge}} — both electrodes can sit in the same solution.',
     2),
    (deck, 40, 'cloze',
     'A classic example of electrolysis is {{c1::molten NaCl}}: external voltage forces Na⁺ to be reduced to Na metal at the cathode and Cl⁻ to be oxidized to Cl₂ gas at the anode.',
     1),
    (deck, 41, 'cloze',
     '{{c1::Electroplating}} is an electrolysis application that uses a small electric current to deposit a thin layer of metal (often Cu, Ni, Cr, Au) onto a conductive object.',
     1);

    -- ── Faraday's Constant + Electrodeposition ──────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     '{{c1::Faraday''s constant (F)}} equals the charge of one mole of electrons: {{c2::96,485 C/mol e⁻}}.',
     2),
    (deck, 43, 'cloze',
     'In electrolysis, the amount of chemical change is directly proportional to the number of {{c1::moles of electrons}} (i.e., total charge) passed through the cell.',
     1),
    (deck, 44, 'cloze',
     'The {{c1::electrodeposition equation}} gives the moles of metal deposited: {{c2::mol M = It / (nF)}}, where I = current, t = time, n = electrons per metal ion, F = Faraday''s constant.',
     2),
    (deck, 45, 'cloze',
     'Faraday''s laws of electrolysis: (1) mass deposited is proportional to total {{c1::charge}} passed; (2) for equal charges, mass deposited depends on the {{c2::equivalent weight}} of the species (M/n).',
     2);

    -- ── Reduction Potentials + SHE ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 46, 'cloze',
     'A {{c1::reduction potential}} quantifies the tendency of a chemical species to gain electrons (be reduced); a more {{c2::positive}} value indicates a stronger pull on electrons.',
     2),
    (deck, 47, 'cloze',
     'All reduction potentials are measured relative to the {{c1::standard hydrogen electrode (SHE)}}, which is assigned a potential of exactly {{c2::0 V}} by convention.',
     2),
    (deck, 48, 'cloze',
     '{{c1::Standard reduction potentials (E°)}} are measured at {{c2::25 °C (298 K)}}, 1 atm pressure, and 1 M solute concentrations — matching the standard state used in thermodynamics.',
     2),
    (deck, 49, 'cloze',
     'To convert a {{c1::reduction}} potential to an {{c1::oxidation}} potential, reverse the half-reaction and {{c2::flip the sign}} of the potential.',
     2),
    (deck, 50, 'cloze',
     'A species with a very {{c1::positive}} reduction potential is a strong {{c2::oxidizing agent}}; a species with a very {{c1::negative}} reduction potential is a strong {{c2::reducing agent}}.',
     2);

    -- ── EMF Equation ────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     'The standard cell EMF (electromotive force) is calculated as {{c1::E°cell = E°cathode − E°anode}}, using reduction potentials for both electrodes (do NOT flip the anode sign).',
     1),
    (deck, 52, 'cloze',
     'For a {{c1::galvanic}} cell, the species with the more {{c2::positive}} reduction potential is reduced — it serves as the cathode; the other species is oxidized at the anode.',
     2),
    (deck, 53, 'cloze',
     'For an {{c1::electrolytic}} cell, the external source FORCES the species with the more {{c2::positive}} reduction potential to be oxidized — it becomes the anode (opposite of galvanic).',
     2),
    (deck, 54, 'cloze',
     'A standard {{c1::voltmeter}} measures cell EMF but draws a small current; a {{c1::potentiometer}} draws essentially no current and gives a more accurate EMF reading.',
     1);

    -- ── EMF vs Thermodynamics ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 55, 'cloze',
     'The fundamental link between thermodynamics and electrochemistry is {{c1::ΔG° = −nFE°cell}}, where n is moles of electrons transferred and F is Faraday''s constant.',
     1),
    (deck, 56, 'cloze',
     'Galvanic cells have {{c1::negative ΔG°}} and {{c1::positive E°cell}} (spontaneous); electrolytic cells have {{c1::positive ΔG°}} and {{c1::negative E°cell}} (nonspontaneous).',
     1),
    (deck, 57, 'cloze',
     'The {{c1::n}} in ΔG° = −nFE°cell represents the number of {{c2::electrons}} transferred per balanced redox equation; balancing the half-reactions correctly is essential for the right value of n.',
     2),
    (deck, 58, 'cloze',
     'When conditions differ from standard, use {{c1::ΔG = ΔG° + RT ln Q}} to calculate the actual (non-standard) free-energy change for the cell reaction.',
     1);

    -- ── Nernst Equation + EMF vs Keq ────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 59, 'cloze',
     'The {{c1::Nernst equation}} adjusts EMF for nonstandard conditions: {{c2::E = E° − (RT/nF) ln Q}}, where Q is the reaction quotient.',
     2),
    (deck, 60, 'cloze',
     'At 25 °C, the Nernst equation simplifies to {{c1::E = E° − (0.0592/n) log Q}}, useful for quick MCAT calculations without temperature factors.',
     1),
    (deck, 61, 'cloze',
     'In the Nernst equation, as products accumulate Q increases, the {{c1::log Q}} term becomes more positive, and the actual cell EMF {{c2::decreases}} below E° — toward zero at equilibrium.',
     2),
    (deck, 62, 'cloze',
     'ΔG° = −nFE°cell = {{c1::−RT ln Keq}}, so E°cell and Keq are linked: large Keq → large positive E°.',
     1),
    (deck, 63, 'cloze',
     'When {{c1::Keq > 1}}, E°cell is {{c2::positive}}; when Keq < 1, E°cell is {{c2::negative}}; when Keq = 1, E°cell equals {{c2::zero}}.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 64;
END $$;
