-- ════════════════════════════════════════════════════════════════════
-- General Chemistry Chapter 10 — Acids and Bases
-- ════════════════════════════════════════════════════════════════════
-- Section: chemistry
-- Topic:   General Chemistry
-- Subtopic slug: acids_and_bases
-- Sort order: 10
--
-- Coverage (AAMC-aligned order):
--   1.  Three Acid-Base Definitions (Arrhenius, BL, Lewis)
--   2.  Definition Hierarchy + Amphoteric Species
--   3.  Acid Nomenclature
--   4.  Autoionization of Water + Kw
--   5.  pH and pOH Scales
--   6.  Strong vs Weak Acids/Bases
--   7.  Ka and Kb
--   8.  Conjugate Acid-Base Pairs
--   9.  Salt Formation and Neutralization
--   10. Salt Hydrolysis + pH Outcomes
--   11. Equivalents and Normality
--   12. Polyvalent (Polyprotic) Acids
--   13. Titration Fundamentals
--   14. Titration Curves by Acid-Base Type
--   15. Buffer Solutions + Henderson-Hasselbalch
--   16. Bicarbonate Buffer + Buffering Capacity
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Chemistry: Atoms First 2e (Ch 14 Acid-Base Equilibria, Ch 15
-- Equilibria of Other Reaction Classes) and OpenStax Anatomy & Physiology
-- 2e (Ch 26 Fluid, Electrolyte, and Acid-Base Balance — bicarbonate
-- buffer), and the AAMC Foundation 5B Concept 1 content outline. See
-- companion .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'chemistry'
      AND title IN (
          'Acids and Bases',
          'Acids & Bases',
          'General Chemistry Review Chapter 10 Acids and Bases',
          'General Chemistry Review Chapter 10: Acids and Bases'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'chemistry',
        'General Chemistry',
        'acids_and_bases',
        'Acids and Bases',
        'The three acid-base definitions (Arrhenius, Brønsted-Lowry, Lewis) and their hierarchy; amphoteric species; acid nomenclature for binary acids and oxyacids; autoionization of water and Kw; pH and pOH scales; strong vs weak acids and bases (including the six MCAT strong acids); Ka and Kb; conjugate acid-base pairs; salt formation, neutralization, and the four salt hydrolysis pH outcomes; equivalents and normality; polyvalent (polyprotic) acids; titration fundamentals and titration curves by acid-base type (including the half-equivalence point and amino acid titration); buffer solutions and the Henderson-Hasselbalch equation; the bicarbonate buffer system and buffering capacity.',
        10
    )
    RETURNING id INTO deck;

    -- ── Three Acid-Base Definitions ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'An {{c1::Arrhenius acid}} is a substance that dissociates in aqueous solution to {{c2::increase the concentration of H⁺}} (or H₃O⁺) ions.',
     2),
    (deck, 1, 'cloze',
     'An {{c1::Arrhenius base}} is a substance that dissociates in aqueous solution to {{c2::increase the concentration of OH⁻}} (hydroxide) ions.',
     2),
    (deck, 2, 'cloze',
     'A {{c1::Brønsted-Lowry acid}} is a proton (H⁺) {{c2::donor}}; a {{c1::Brønsted-Lowry base}} is a proton {{c2::acceptor}}.',
     2),
    (deck, 3, 'cloze',
     'A {{c1::Lewis acid}} is an electron-pair {{c2::acceptor}}; a {{c1::Lewis base}} is an electron-pair {{c2::donor}}.',
     2),
    (deck, 4, 'cloze',
     'The Lewis acid-base reaction is the attack of an electrophile (Lewis acid) by the {{c1::lone pair}} of a nucleophile (Lewis base) to form a {{c2::coordinate covalent}} bond.',
     2);

    -- ── Definition Hierarchy + Amphoteric Species ───────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 5, 'cloze',
     'Every Arrhenius acid is also a {{c1::Brønsted-Lowry}} acid, and every Brønsted-Lowry acid is also a {{c1::Lewis}} acid — but the converse is NOT necessarily true.',
     1),
    (deck, 6, 'cloze',
     'An {{c1::amphoteric}} species can act as either an acid or a base depending on its environment — it can gain a proton in an acid environment or donate a proton in a basic one.',
     1),
    (deck, 7, 'cloze',
     '{{c1::Water}} is the canonical amphoteric species; it can donate a proton to a base or accept a proton from an acid.',
     1),
    (deck, 8, 'cloze',
     'The intermediate (partially dissociated) conjugate base of a {{c1::polyvalent}} (polyprotic) acid is usually amphoteric; HCO₃⁻ and HSO₄⁻ are classic examples.',
     1);

    -- ── Acid Nomenclature ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
     'Acids formed from anions ending in {{c1::-ide}} take the prefix {{c1::hydro-}} and the suffix {{c1::-ic acid}}: e.g., Cl⁻ (chloride) → HCl (hydrochloric acid).',
     1),
    (deck, 10, 'cloze',
     'Acids formed from oxygen-containing anions are called {{c1::oxyacids}}; the suffix depends on the anion''s oxygen count.',
     1),
    (deck, 11, 'cloze',
     'Anions ending in {{c1::-ite}} (less oxygen) form acids ending in {{c2::-ous acid}}; anions ending in {{c1::-ate}} (more oxygen) form acids ending in {{c2::-ic acid}}.',
     2),
    (deck, 12, 'cloze',
     'The chlorine oxyacids by increasing oxygen: HClO ({{c1::hypochlorous}}), HClO₂ ({{c1::chlorous}}), HClO₃ ({{c1::chloric}}), HClO₄ ({{c1::perchloric}}).',
     1),
    (deck, 13, 'cloze',
     'Key oxyacids to memorize: {{c1::H₂SO₄}} (sulfuric), {{c1::HNO₃}} (nitric), {{c1::H₃PO₄}} (phosphoric), {{c1::H₂CO₃}} (carbonic).',
     1);

    -- ── Autoionization of Water + Kw ────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 14, 'cloze',
     'Pure water undergoes {{c1::autoionization}}, in which one water molecule donates a proton to another, producing {{c2::hydronium (H₃O⁺)}} and hydroxide (OH⁻) ions.',
     2),
    (deck, 15, 'cloze',
     'The water-dissociation constant {{c1::Kw}} = [H₃O⁺][OH⁻] = {{c2::1 × 10⁻¹⁴}} at 25 °C (298 K).',
     2),
    (deck, 16, 'cloze',
     'Kw depends only on {{c1::temperature}}: it increases when water is heated (because autoionization is endothermic), but pH 7 is neutral only at 25 °C.',
     1);

    -- ── pH and pOH Scales ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 17, 'cloze',
     'The {{c1::p-scale}} is the negative base-10 logarithm of a concentration: {{c2::pH = −log[H⁺]}} and pOH = −log[OH⁻].',
     2),
    (deck, 18, 'cloze',
     'At 25 °C, {{c1::pH + pOH = 14}}; as pH increases, pOH decreases by the same amount.',
     1),
    (deck, 19, 'cloze',
     'pH < 7 indicates a solution is {{c1::acidic}}; pH > 7 indicates {{c1::basic}}; pH = 7 indicates {{c1::neutral}} at 25 °C.',
     1),
    (deck, 20, 'cloze',
     'To estimate pX for a value (n × 10⁻ᵐ) on the MCAT: pX ≈ {{c1::m − 0.n}}. Example: pKa for Ka = 1.8 × 10⁻⁵ is approximately {{c2::5 − 0.18 = 4.82}}.',
     2);

    -- ── Strong vs Weak Acids/Bases ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 21, 'cloze',
     '{{c1::Strong}} acids and bases completely dissociate in aqueous solution; {{c1::weak}} acids and bases only partially dissociate, establishing an equilibrium.',
     1),
    (deck, 22, 'cloze',
     'The six MCAT strong acids are {{c1::HCl, HBr, HI, H₂SO₄, HNO₃, and HClO₄}}; assume any other acid is weak unless told otherwise.',
     1),
    (deck, 23, 'cloze',
     'The MCAT strong bases are {{c1::NaOH, KOH}}, and other soluble hydroxides of {{c2::Group IA}} (alkali metal) metals; Group IIA hydroxides like Ca(OH)₂ are also strong if soluble.',
     2),
    (deck, 24, 'cloze',
     'Acids are {{c1::stronger}} when {{c2::electronegative}} elements sit near the acidic proton — those atoms pull electron density out of the H–X bond, weakening it and freeing the proton.',
     2);

    -- ── Ka and Kb ───────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 25, 'cloze',
     'For an acid HA, the dissociation constant is {{c1::Ka = [H₃O⁺][A⁻] / [HA]}}; smaller Ka means a {{c2::weaker}} acid (less dissociation).',
     2),
    (deck, 26, 'cloze',
     'For a base B, the dissociation constant is {{c1::Kb = [BH⁺][OH⁻] / [B]}}; smaller Kb means a {{c2::weaker}} base.',
     2),
    (deck, 27, 'cloze',
     'For a conjugate acid-base pair, {{c1::Ka × Kb = Kw}} = 1 × 10⁻¹⁴; equivalently, pKa + pKb = 14.',
     1),
    (deck, 28, 'cloze',
     'A species is classified as a {{c1::weak}} acid or base when its Ka or Kb is {{c2::less than 1}}.',
     2);

    -- ── Conjugate Acid-Base Pairs ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     'A {{c1::conjugate base}} is what remains after an acid loses its proton; a {{c1::conjugate acid}} is what forms when a base gains a proton.',
     1),
    (deck, 30, 'cloze',
     'A {{c1::strong}} acid produces a very weak (essentially inert) conjugate base; a {{c1::strong}} base produces a very weak conjugate acid.',
     1),
    (deck, 31, 'cloze',
     'The conjugate of a {{c1::weak}} acid is itself a weak base, and the conjugate of a weak base is a weak acid — both retain noticeable reactivity.',
     1),
    (deck, 32, 'cloze',
     'Within a conjugate pair, if Ka is {{c1::large}}, Kb is {{c1::small}}, and vice versa — a strong acid cannot have a strong conjugate base.',
     1);

    -- ── Salt Formation and Neutralization ───────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 33, 'cloze',
     'A {{c1::neutralization}} reaction combines an acid and a base to form a {{c2::salt}} (and usually water); these reactions typically go essentially to completion.',
     2),
    (deck, 34, 'cloze',
     'A {{c1::salt}} is an ionic compound formed from the cation of a base and the anion of an acid; in solution, salts dissociate into their constituent ions.',
     1),
    (deck, 35, 'cloze',
     '{{c1::Hydrolysis}} is the reverse of neutralization: the ions of a dissolved salt react with water to regenerate the parent acid or base, possibly shifting the solution''s pH.',
     1);

    -- ── Salt Hydrolysis + pH Outcomes ───────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 36, 'cloze',
     'A salt of a {{c1::strong}} acid and a {{c1::strong}} base dissolves to give a {{c2::neutral}} (pH 7) solution; its conjugate ions are inert and do not hydrolyze.',
     2),
    (deck, 37, 'cloze',
     'A salt of a {{c1::strong acid}} and a {{c1::weak base}} dissolves to give an {{c2::acidic}} solution; the weak base''s conjugate acid hydrolyzes water to release H⁺.',
     2),
    (deck, 38, 'cloze',
     'A salt of a {{c1::weak acid}} and a {{c1::strong base}} dissolves to give a {{c2::basic}} solution; the weak acid''s conjugate base hydrolyzes water to release OH⁻.',
     2),
    (deck, 39, 'cloze',
     'A salt of a weak acid and a weak base may be acidic, basic, or neutral — the outcome depends on the relative magnitudes of {{c1::Ka}} and {{c2::Kb}} of the parent species.',
     2);

    -- ── Equivalents and Normality ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 40, 'cloze',
     'An {{c1::acid equivalent}} equals 1 mole of {{c2::H⁺}} (or one equivalent of proton-donating capacity); a base equivalent equals 1 mole of {{c2::OH⁻}}.',
     2),
    (deck, 41, 'cloze',
     '{{c1::Normality (N)}} is the concentration of {{c2::acid or base equivalents}} per liter of solution; it differs from molarity for polyvalent species.',
     2),
    (deck, 42, 'cloze',
     '{{c1::Gram equivalent weight}} is the mass of a compound that produces one equivalent (one mole of H⁺ or OH⁻).',
     1);

    -- ── Polyvalent (Polyprotic) Acids ───────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     'A {{c1::polyvalent (polyprotic)}} acid can donate {{c2::more than one}} proton per molecule; H₂SO₄ is diprotic, and H₃PO₄ is triprotic.',
     2),
    (deck, 44, 'cloze',
     'Polyprotic acids dissociate {{c1::stepwise}}, with each successive Ka {{c2::smaller}} than the one before it; H₃PO₄ has three distinct pKa values.',
     2),
    (deck, 45, 'cloze',
     'The intermediate forms of a polyprotic acid (e.g., HCO₃⁻, H₂PO₄⁻) are {{c1::amphoteric}} — they can act as either an acid or a base.',
     1);

    -- ── Titration Fundamentals ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 46, 'cloze',
     '{{c1::Titration}} determines the unknown concentration of one reactant by gradually adding a second reactant of known concentration until the reaction is complete.',
     1),
    (deck, 47, 'cloze',
     'The {{c1::titrant}} is the solution of known concentration added from the burette; the {{c1::titrand}} (analyte) is the solution of unknown concentration in the flask.',
     1),
    (deck, 48, 'cloze',
     'The {{c1::equivalence point}} is reached when the number of acid equivalents added equals the number of base equivalents originally present.',
     1),
    (deck, 49, 'cloze',
     'The {{c1::endpoint}} is when the indicator visibly changes color; it is an experimental approximation of the {{c1::equivalence point}}.',
     1),
    (deck, 50, 'cloze',
     'Indicators are themselves weak acids or bases that change color when protonated/deprotonated; a good indicator has a {{c1::pKa}} close to the expected equivalence point pH.',
     1);

    -- ── Titration Curves by Acid-Base Type ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     'Titrating a strong acid with a strong base yields a sharp {{c1::sigmoidal}} curve with the equivalence point at pH = {{c2::7}}.',
     2),
    (deck, 52, 'cloze',
     'Titrating a weak acid with a strong base yields a curve with an equivalence point at pH {{c1::> 7}}; the resulting solution is basic because the conjugate base remains.',
     1),
    (deck, 53, 'cloze',
     'Titrating a strong acid with a weak base yields a curve with an equivalence point at pH {{c1::< 7}}; the resulting solution is acidic because the conjugate acid remains.',
     1),
    (deck, 54, 'cloze',
     'Titrating a weak acid with a weak base produces a shallow, almost featureless curve; the equivalence point lies {{c1::near neutral}} and may be difficult to identify visually.',
     1),
    (deck, 55, 'cloze',
     'At the {{c1::half-equivalence point}}, exactly half of the weak acid has been neutralized, so [HA] = [A⁻] and {{c2::pH = pKa}}.',
     2),
    (deck, 56, 'cloze',
     'Polyprotic titrations show {{c1::multiple buffer regions}} and equivalence points; amino acid titrations show three equivalence points corresponding to the carboxyl group, amino group, and {{c2::side chain}}.',
     2);

    -- ── Buffer Solutions + Henderson-Hasselbalch ────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 57, 'cloze',
     'A {{c1::buffer}} is a solution that resists changes in pH when small amounts of acid or base are added; it consists of a weak acid + its conjugate base (or weak base + its conjugate acid).',
     1),
    (deck, 58, 'cloze',
     'A buffer works because its {{c1::weak acid}} component neutralizes added {{c2::OH⁻}} (becoming the conjugate base), while its {{c1::conjugate base}} neutralizes added {{c2::H⁺}} (becoming the weak acid).',
     2),
    (deck, 59, 'cloze',
     'Two classic MCAT buffers: acetic acid + sodium acetate (an {{c1::acid buffer}}, pKa ≈ 4.76); ammonia + ammonium chloride (a {{c1::basic buffer}}).',
     1),
    (deck, 60, 'cloze',
     'For a weak acid buffer, the Henderson-Hasselbalch equation is {{c1::pH = pKa + log([A⁻]/[HA])}}, predicting buffer pH from the pKa and concentration ratio.',
     1),
    (deck, 61, 'cloze',
     'For a weak base buffer, the Henderson-Hasselbalch equation is {{c1::pOH = pKb + log([BH⁺]/[B])}}, predicting buffer pOH similarly.',
     1),
    (deck, 62, 'cloze',
     'When the concentrations of conjugate base and weak acid are equal ([A⁻] = [HA]), the log term is zero and {{c1::pH = pKa}}.',
     1);

    -- ── Bicarbonate Buffer + Buffering Capacity ─────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 63, 'cloze',
     '{{c1::Buffering capacity}} is the amount of acid or base a buffer can absorb before its pH changes significantly; it is greatest within {{c2::±1 pH unit}} of the pKa.',
     2),
    (deck, 64, 'cloze',
     'The {{c1::bicarbonate buffer}} system maintains blood pH around 7.35-7.45: CO₂ + H₂O ⇌ {{c2::H₂CO₃}} ⇌ H⁺ + {{c3::HCO₃⁻}}.',
     3),
    (deck, 65, 'cloze',
     'In metabolic acidosis, respiratory rate increases to {{c1::blow off CO₂}}, shifting the bicarbonate equilibrium {{c2::left}} and reducing free H⁺ — a respiratory compensation for the pH drop.',
     2);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 66, 'cloze',
     'To find a hydrolyzing salt''s pH, obtain the reactive ion''s ionization constant from {{c1::Ka × Kb = Kw}}, then solve its weak-acid or weak-base equilibrium.',
     1),
    (deck, 67, 'cloze',
     'Sodium acetate dissolves in water to give a {{c1::basic}} solution because acetate ion hydrolyzes, producing {{c1::OH⁻}}.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 68;
END $$;
