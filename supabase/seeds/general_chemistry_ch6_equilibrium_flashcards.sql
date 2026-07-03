-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Equilibrium
-- Section: chemistry · Topic: General Chemistry
--
-- Coverage: dynamic equilibrium & reversibility; law of mass
-- action and the equilibrium constant (Kc/Kp, multi-step Keq as
-- the product of step constants, and ΔG° = −RT ln Keq); the
-- reaction quotient Q and the Q<K / Q=K / Q>K direction test;
-- properties of Keq (pure solids/liquids excluded, temperature
-- dependence, magnitude interpretation, reverse = 1/Keq); Le
-- Châtelier's principle (concentration, pressure/volume, and
-- temperature stresses; catalyst does not shift position); and
-- kinetic vs thermodynamic reaction control.
--
-- All cards are CLOZE-format and are ORIGINAL Praxist Prep
-- content — written from the underlying chemistry and re-sourced
-- from OpenStax Chemistry: Atoms First 2e (and LibreTexts Organic
-- Chemistry for kinetic/thermodynamic control); see the companion
-- verification.md. No prose is lifted from any third-party source.
--
-- Subtopic ordering follows the AAMC content outline (Foundation
-- 5E: Equilibrium), NOT the source .docx's chapter ordering.
--
-- Idempotent: re-running deletes the prior version of this deck and
-- re-seeds. User review history (flashcard_user_state,
-- flashcard_reviews) attached to those cards cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  DELETE FROM flashcard_decks
   WHERE section = 'chemistry'
     AND title   IN ('Equilibrium', 'Chemical Equilibrium', 'Chapter 6 — Equilibrium');

  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'chemistry',
    'General Chemistry',
    'equilibrium',
    'Equilibrium',
    'Chemical equilibrium for the MCAT: dynamic equilibrium and reversibility; the law of mass action and the equilibrium constant (Kc, Kp, multi-step products, and the Keq–ΔG° relationship); the reaction quotient Q compared to Keq; properties of Keq (pure solids/liquids, temperature dependence, magnitude, and reversal = 1/Keq); Le Châtelier''s principle for concentration, pressure/volume, and temperature stresses; and kinetic vs thermodynamic reaction control.',
    6
  )
  RETURNING id INTO deck;

  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── Dynamic Equilibrium & Reversibility ───────────────────────
  (deck, 0, 'cloze',
   'A {{c1::reversible}} reaction can proceed in both the forward and reverse directions, whereas an {{c2::irreversible}} reaction proceeds essentially in one direction until the limiting reactant is consumed.', 2),
  (deck, 1, 'cloze',
   'At chemical equilibrium the {{c1::forward}} and {{c1::reverse}} reaction rates are {{c2::equal}}, so the concentrations of reactants and products remain {{c3::constant}} over time.', 3),
  (deck, 2, 'cloze',
   'A chemical equilibrium is described as {{c1::dynamic}} rather than static because the reaction has not stopped but instead continues in both directions at the {{c2::same rate}}, producing no net change in concentrations.', 2),
  (deck, 3, 'cloze',
   'A reversible reaction reaches equilibrium at the point where the Gibbs free energy of the system is at a {{c1::minimum}} and the entropy is at a {{c2::maximum}}.', 2),

  -- ── Law of Mass Action & the Equilibrium Constant ─────────────
  (deck, 4, 'cloze',
   'The law of mass action states that at a given {{c1::temperature}}, the reaction quotient for a system at equilibrium has a {{c2::constant}} value, which is called the equilibrium constant K.', 2),
  (deck, 5, 'cloze',
   'For the reaction aA + bB ⇌ cC + dD, the equilibrium constant expression places {{c1::products}} in the numerator and {{c2::reactants}} in the denominator, each raised to its {{c3::stoichiometric coefficient}}: Keq = [C]ᶜ[D]ᵈ / [A]ᵃ[B]ᵇ.', 3),
  (deck, 6, 'cloze',
   'The equilibrium constant written with molar concentrations is {{c1::Kc}}, while the one written with partial pressures of gases is {{c2::Kp}}.', 2),
  (deck, 7, 'cloze',
   'When an overall reaction is the sum of several elementary steps, the overall equilibrium constant equals the {{c1::product}} of the equilibrium constants of the individual steps.', 1),
  (deck, 8, 'cloze',
   'The equilibrium constant is linked to the standard free energy change by {{c1::ΔG° = −RT ln Keq}}; a Keq greater than 1 corresponds to a {{c2::negative}} ΔG° (products favored), while a Keq less than 1 corresponds to a {{c3::positive}} ΔG° (reactants favored).', 3),

  -- ── The Reaction Quotient ─────────────────────────────────────
  (deck, 9, 'cloze',
   'The reaction quotient Q has the {{c1::same form}} as the equilibrium constant expression but is evaluated for {{c2::any}} set of concentrations, not only those at equilibrium.', 2),
  (deck, 10, 'cloze',
   'When {{c1::Q < Keq}}, the reaction proceeds in the {{c2::forward}} direction (net formation of products) to reach equilibrium.', 2),
  (deck, 11, 'cloze',
   'When {{c1::Q > Keq}}, the reaction proceeds in the {{c2::reverse}} direction (net formation of reactants) until equilibrium is restored.', 2),
  (deck, 12, 'cloze',
   'When {{c1::Q = Keq}}, the system is at {{c2::equilibrium}} and undergoes no net reaction, with forward and reverse rates equal.', 2),

  -- ── Properties of the Equilibrium Constant ────────────────────
  (deck, 13, 'cloze',
   'In an equilibrium constant expression, {{c1::pure solids}} and {{c1::pure liquids}} are omitted because their relative concentrations are taken to equal {{c2::1}}.', 2),
  (deck, 14, 'cloze',
   'The value of Keq depends on {{c1::temperature}}, so it changes only when the temperature changes; adding reactant or product, or adding a catalyst, leaves Keq {{c2::unchanged}}.', 2),
  (deck, 15, 'cloze',
   'A {{c1::large}} Keq means the equilibrium mixture is dominated by {{c2::products}}, with the forward reaction proceeding nearly to completion, whereas a {{c1::small}} Keq means little reactant has been converted and {{c2::reactants}} predominate.', 2),
  (deck, 16, 'cloze',
   'The magnitude of Keq indicates how far a reaction proceeds but says {{c1::nothing}} about how {{c2::fast}} equilibrium is reached, since that depends on kinetics.', 2),
  (deck, 17, 'cloze',
   'If the equilibrium constant for a reaction in the forward direction is Keq, the equilibrium constant for the {{c1::reverse}} reaction is {{c2::1/Keq}}.', 2),

  -- ── Le Châtelier's Principle ──────────────────────────────────
  (deck, 18, 'cloze',
   'Le Châtelier''s principle states that when a system at equilibrium is subjected to a {{c1::stress}}, the equilibrium {{c2::shifts}} in the direction that relieves the stress and re-establishes equilibrium.', 2),
  (deck, 19, 'cloze',
   'Adding a reactant or removing a product shifts an equilibrium toward the {{c1::products (forward, right)}}, whereas removing a reactant or adding a product shifts it toward the {{c2::reactants (reverse, left)}}.', 2),
  (deck, 20, 'cloze',
   'Increasing the pressure of a gaseous equilibrium by decreasing the volume shifts the reaction toward the side with {{c1::fewer}} moles of gas; decreasing the pressure by increasing the volume shifts it toward the side with {{c2::more}} moles of gas.', 2),
  (deck, 21, 'cloze',
   'If the numbers of moles of gas are {{c1::equal}} on both sides of a reaction, a change in pressure or volume produces {{c2::no shift}} in the equilibrium position.', 2),
  (deck, 22, 'cloze',
   'For temperature stresses, heat is treated as a {{c1::reactant}} in an endothermic reaction (ΔH > 0) and as a {{c2::product}} in an exothermic reaction (ΔH < 0).', 2),
  (deck, 23, 'cloze',
   'Raising the temperature of an {{c1::endothermic}} reaction shifts the equilibrium toward {{c2::products}} (right), while raising the temperature of an {{c1::exothermic}} reaction shifts it toward {{c2::reactants}} (left).', 2),
  (deck, 24, 'cloze',
   'A catalyst does {{c1::not}} shift the position of an equilibrium; it only speeds the forward and reverse reactions equally, so equilibrium is {{c2::reached faster}} with the same final composition.', 2),

  -- ── Kinetic vs Thermodynamic Control ──────────────────────────
  (deck, 25, 'cloze',
   'The {{c1::kinetic}} product is the one that forms {{c2::faster}} because its pathway has the lower activation barrier, whereas the {{c1::thermodynamic}} product is the one that is more {{c2::stable}}.', 2),
  (deck, 26, 'cloze',
   'The {{c1::kinetic}} product predominates at {{c2::low temperature}}, where the product-forming step is effectively irreversible and outcome is set by relative reaction rates rather than stability.', 2),
  (deck, 27, 'cloze',
   'The {{c1::thermodynamic}} product predominates at {{c2::higher temperature}} under reversible conditions, because the system can equilibrate and minimize its Gibbs free energy, favoring the product with the more {{c3::negative ΔG}}.', 3);

  RAISE NOTICE 'Seeded deck: Equilibrium (% cards)', (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
