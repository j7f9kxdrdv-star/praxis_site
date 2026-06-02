-- ════════════════════════════════════════════════════════════════════
-- General Chemistry Chapter 11 — Oxidation-Reduction Reactions
-- ════════════════════════════════════════════════════════════════════
-- Section: chemistry
-- Topic:   General Chemistry
-- Subtopic slug: oxidation_reduction_reactions
-- Sort order: 11
--
-- Coverage (AAMC-aligned order):
--   1.  Oxidation & Reduction Definitions
--   2.  Oxidizing Agents vs Reducing Agents
--   3.  Common Oxidizing Agents
--   4.  Common Reducing Agents
--   5.  Oxidation Number Rules: Elements & Monatomic Ions
--   6.  Oxidation Number Rules: Groups IA, IIA, VIIA
--   7.  Oxidation Number Rules: Hydrogen
--   8.  Oxidation Number Rules: Oxygen
--   9.  Oxidation Number Rules: Sum
--   10. Balancing Redox: Half-Reaction Method
--   11. Balancing in Acidic vs Basic Solution
--   12. Complete vs Net Ionic Equations
--   13. Spectator Ions
--   14. Combination, Decomposition, Combustion
--   15. Double Displacement vs Disproportionation
--   16. Redox Titrations
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Chemistry: Atoms First 2e (Ch 4 Stoichiometry; Ch 17
-- Electrochemistry) and LibreTexts Organic Chemistry (oxidizing and
-- reducing reagents), and the AAMC Foundation 5E Concept 2 content
-- outline. See companion .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'chemistry'
      AND title IN (
          'Oxidation-Reduction Reactions',
          'Oxidation Reduction Reactions',
          'Redox Reactions',
          'General Chemistry Review, Chapter 11: Oxidation-Reduction Reactions'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'chemistry',
        'General Chemistry',
        'oxidation_reduction_reactions',
        'Oxidation-Reduction Reactions',
        'Oxidation and reduction defined (OIL RIG); oxidizing and reducing agents and their common examples (KMnO4, H2O2, halogens, NaBH4, LiAlH4, NADH/FADH2); the full set of oxidation-number rules (free elements, monatomic ions, Groups IA/IIA/VIIA, hydrogen, oxygen, and sums); balancing redox reactions by the half-reaction (ion-electron) method including acidic and basic solution conditions; complete vs net ionic equations and spectator ions; the major reaction types (combination, decomposition, combustion, double displacement, disproportionation); and redox titrations including potentiometric titration.',
        11
    )
    RETURNING id INTO deck;

    -- ── Oxidation & Reduction Definitions ───────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     '{{c1::Oxidation}} is the loss of electrons; {{c1::reduction}} is the gain of electrons. The two must occur simultaneously — electrons released by one species must be accepted by another.',
     1),
    (deck, 1, 'cloze',
     'The classic mnemonic for redox is {{c1::OIL RIG}}: {{c2::Oxidation Is Loss}}, {{c2::Reduction Is Gain}} of electrons.',
     2),
    (deck, 2, 'cloze',
     'A {{c1::redox reaction}} is fundamentally about the transfer of {{c2::electrons}} from one species to another; both halves (oxidation and reduction) must be present.',
     2);

    -- ── Oxidizing Agents vs Reducing Agents ─────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 3, 'cloze',
     'An {{c1::oxidizing agent}} causes another species to be oxidized and is itself {{c2::reduced}}; a {{c1::reducing agent}} causes another species to be reduced and is itself {{c2::oxidized}}.',
     2),
    (deck, 4, 'cloze',
     'Oxidizing agents typically contain {{c1::oxygen}} or another highly {{c2::electronegative}} element capable of pulling electrons away from another molecule.',
     2),
    (deck, 5, 'cloze',
     'Reducing agents typically contain {{c1::reactive metals}} or {{c1::hydrides (H⁻)}} — species willing to donate electrons or transfer hydrogen with its electrons.',
     1);

    -- ── Common Oxidizing Agents ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 6, 'cloze',
     'Common oxidizing agents include {{c1::O₂}}, halogens (F₂, Cl₂, Br₂, I₂), {{c1::H₂O₂}}, {{c1::KMnO₄}} (permanganate), and {{c1::HNO₃}} (nitric acid).',
     1),
    (deck, 7, 'cloze',
     'The {{c1::halogens}} (F₂, Cl₂, Br₂, I₂) are strong oxidizing agents, with strength {{c2::decreasing}} down the group as electronegativity decreases.',
     2),
    (deck, 8, 'cloze',
     'In biology, the major oxidizing agents are {{c1::NAD⁺}} and {{c1::FAD}}, which collect electrons from catabolic pathways like glycolysis and the citric acid cycle.',
     1);

    -- ── Common Reducing Agents ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
     'Common reducing agents include reactive metals (Na, Zn, Mg), {{c1::H₂}} gas, hydrides like {{c2::NaBH₄}} and {{c2::LiAlH₄}}, and biological carriers like NADH and FADH₂.',
     2),
    (deck, 10, 'cloze',
     '{{c1::LiAlH₄}} is a much stronger reducing agent than {{c1::NaBH₄}} — strong enough to reduce carboxylic acids, esters, and amides, whereas NaBH₄ reduces only aldehydes and ketones.',
     1),
    (deck, 11, 'cloze',
     'In biology, {{c1::NADH}} and {{c1::FADH₂}} are the reduced forms that carry high-energy electrons to the electron transport chain for ATP production.',
     1);

    -- ── Oxidation Number Rules: Elements & Monatomic Ions ──────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 12, 'cloze',
     'The oxidation number of any {{c1::free element}} (including diatomic species like N₂, O₂, F₂) is {{c2::zero}}.',
     2),
    (deck, 13, 'cloze',
     'The oxidation number of a {{c1::monatomic ion}} equals its overall {{c2::charge}}: Na⁺ = +1, Mg²⁺ = +2, Cl⁻ = −1, S²⁻ = −2.',
     2),
    (deck, 14, 'cloze',
     'Oxidation numbers are a bookkeeping tool that lets you track {{c1::electron transfer}} during a redox reaction by comparing each atom''s oxidation number before and after.',
     1);

    -- ── Oxidation Number Rules: Groups IA, IIA, VIIA ───────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'In compounds, {{c1::Group IA}} (alkali metals: Li, Na, K) always have oxidation number {{c2::+1}}; {{c1::Group IIA}} (alkaline earths: Be, Mg, Ca) always have oxidation number {{c2::+2}}.',
     2),
    (deck, 16, 'cloze',
     'In compounds, {{c1::Group VIIA}} elements (halogens) typically have oxidation number {{c2::−1}}, EXCEPT when bonded to a more electronegative element (e.g., in HOCl, Cl is +1).',
     2),
    (deck, 17, 'cloze',
     'These oxidation-number rules reflect each element''s typical {{c1::ionization}} behavior: alkali metals readily lose 1 electron, alkaline earths lose 2, and halogens readily gain 1.',
     1);

    -- ── Oxidation Number Rules: Hydrogen ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     'Hydrogen has an oxidation number of {{c1::+1}} in most compounds (e.g., HCl, H₂O, NH₃) because it is bonded to a more electronegative element.',
     1),
    (deck, 19, 'cloze',
     'Hydrogen has an oxidation number of {{c1::−1}} in {{c2::metal hydrides}} (e.g., NaH, CaH₂, LiAlH₄), where it is bonded to a less electronegative element.',
     2);

    -- ── Oxidation Number Rules: Oxygen ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
     'Oxygen has an oxidation number of {{c1::−2}} in most compounds (e.g., H₂O, CO₂, Fe₂O₃) because it is highly electronegative and pulls electrons from its bonding partner.',
     1),
    (deck, 21, 'cloze',
     'In {{c1::peroxides}} (e.g., H₂O₂, Na₂O₂), oxygen has an oxidation number of {{c2::−1}} because the two oxygens share an O–O bond and split the electrons equally.',
     2),
    (deck, 22, 'cloze',
     'In {{c1::OF₂}} (oxygen difluoride), oxygen has an oxidation number of {{c2::+2}} because fluorine is more electronegative than oxygen and pulls electrons toward itself.',
     2);

    -- ── Oxidation Number Rules: Sum ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 23, 'cloze',
     'The sum of all oxidation numbers in a neutral compound equals {{c1::zero}}.',
     1),
    (deck, 24, 'cloze',
     'The sum of all oxidation numbers in a polyatomic ion equals the {{c1::charge of the ion}}; e.g., in SO₄²⁻, the sum equals −2.',
     1),
    (deck, 25, 'cloze',
     'To find an unknown oxidation number in a neutral compound, set the sum of oxidation numbers to {{c1::0}} and solve algebraically (e.g., in H₂SO₄, S must be +6).',
     1);

    -- ── Balancing Redox: Half-Reaction Method ──────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
     'The {{c1::half-reaction (ion-electron) method}} splits a redox reaction into separate {{c2::oxidation}} and {{c2::reduction}} half-reactions; each is balanced for atoms and charge, then recombined.',
     2),
    (deck, 27, 'cloze',
     'A balanced redox reaction must balance both the {{c1::number of atoms}} AND the total {{c1::charge}} on each side; balancing only atoms is insufficient.',
     1),
    (deck, 28, 'cloze',
     'In each half-reaction, balance {{c1::atoms first}}, then add electrons to balance the {{c2::charge}}; the number of electrons gained in reduction must equal the number lost in oxidation.',
     2),
    (deck, 29, 'cloze',
     'After balancing each half-reaction separately, scale them so the electrons {{c1::cancel}} when added together, then sum to produce the balanced overall equation.',
     1);

    -- ── Balancing in Acidic vs Basic Solution ──────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 30, 'cloze',
     'In {{c1::acidic}} solution, balance oxygen with {{c2::H₂O}} and balance hydrogen with {{c2::H⁺}} on the side needing them.',
     2),
    (deck, 31, 'cloze',
     'In {{c1::basic}} solution, balance oxygen with {{c2::H₂O}} and hydrogen with {{c2::OH⁻}} — alternatively, balance as if acidic and then add OH⁻ to both sides to neutralize H⁺.',
     2),
    (deck, 32, 'cloze',
     'The available species for balancing depends on solution conditions: free {{c1::H⁺}} is plentiful in acidic solution; in basic solution, you must use {{c1::OH⁻}} instead.',
     1),
    (deck, 33, 'cloze',
     'Half-reaction balancing procedure: (1) split into half-reactions, (2) balance non-O/H atoms, (3) balance O with {{c1::H₂O}}, (4) balance H with {{c1::H⁺}}, (5) balance charge with {{c1::electrons}}.',
     1);

    -- ── Complete vs Net Ionic Equations ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     'A {{c1::complete ionic equation}} writes every dissolved (aqueous) ionic compound and strong electrolyte as its separated {{c2::individual ions}}, showing every species present in solution.',
     2),
    (deck, 35, 'cloze',
     'A {{c1::net ionic equation}} shows only the species that {{c2::actually participate}} in the reaction — those forming precipitates, gases, or weak electrolytes.',
     2),
    (deck, 36, 'cloze',
     'When writing ionic equations: {{c1::aqueous}} ionic compounds and strong electrolytes are split into ions; {{c1::solids}}, {{c1::gases}}, weak electrolytes, and water stay together as molecules.',
     1);

    -- ── Spectator Ions ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 37, 'cloze',
     '{{c1::Spectator ions}} appear identically on both sides of a complete ionic equation — they do not participate in the reaction and are dropped from the net ionic equation.',
     1),
    (deck, 38, 'cloze',
     'In the precipitation reaction Ag⁺ + Cl⁻ → AgCl (with Na⁺ and NO₃⁻ in solution), Na⁺ and NO₃⁻ are {{c1::spectator}} ions and are omitted from the net ionic equation.',
     1);

    -- ── Combination, Decomposition, Combustion ──────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 39, 'cloze',
     'A {{c1::combination (synthesis)}} reaction joins two or more species into a single product: A + B → AB. Common examples include rusting (Fe + O₂ → Fe₂O₃) and salt formation.',
     1),
    (deck, 40, 'cloze',
     'A {{c1::decomposition}} reaction breaks one reactant into two or more products: AB → A + B. Heating CaCO₃ to give CaO + CO₂ is a classic example.',
     1),
    (deck, 41, 'cloze',
     'A {{c1::combustion}} reaction burns a fuel (typically a hydrocarbon) with an oxidant (usually O₂) to produce {{c2::CO₂ and H₂O}}; combustion reactions are strongly exothermic.',
     2);

    -- ── Double Displacement vs Disproportionation ──────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'A {{c1::double displacement}} reaction swaps the counter-ions of two ionic compounds: AB + CD → AD + CB. Most precipitation and acid-base reactions follow this pattern.',
     1),
    (deck, 43, 'cloze',
     'Double displacement reactions are usually {{c1::not}} redox reactions because the ions retain their {{c2::oxidation states}} throughout — only the partners change.',
     2),
    (deck, 44, 'cloze',
     'A {{c1::disproportionation (dismutation)}} reaction is one in which a single element is BOTH {{c2::oxidized and reduced}} in the same reaction (e.g., 2 H₂O₂ → 2 H₂O + O₂).',
     2);

    -- ── Redox Titrations ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 45, 'cloze',
     'A {{c1::redox titration}} follows the transfer of electrons between titrant and analyte to find the equivalence point; indicators that change color at a specific {{c2::voltage (potential)}} mark the endpoint.',
     2),
    (deck, 46, 'cloze',
     'In a {{c1::potentiometric titration}}, no indicator is used; instead, a {{c2::voltmeter}} measures the electromotive force (EMF) of the solution to detect the equivalence point.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 47;
END $$;
