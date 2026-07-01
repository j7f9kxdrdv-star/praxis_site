-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Chemical Kinetics
-- Section: chemistry · Topic: General Chemistry
--
-- Coverage: reaction rates (rate expressions, sign convention,
-- units, stoichiometric coupling); rate laws, reaction order, and
-- k's units by order; integrated rate laws with the zero/first/
-- second-order linear-plot and k-unit discriminators; collision
-- theory and activation energy; the Arrhenius equation (incl.
-- the linearized ln k vs 1/T form and the two-point Ea method)
-- and temperature dependence; transition-state theory and energy
-- profiles (exergonic vs endergonic); reaction mechanisms and the
-- rate-determining step; and catalysis (homogeneous vs
-- heterogeneous; lowers Ea for both directions; no effect on ΔG
-- or Keq).
--
-- All cards are CLOZE-format and are ORIGINAL Praxist Prep
-- content — written from the underlying chemistry and re-sourced
-- from OpenStax Chemistry: Atoms First 2e; see the companion
-- verification.md. No prose is lifted from any third-party source.
--
-- Subtopic ordering follows the AAMC content outline (Foundation
-- 5E: Principles of chemical thermodynamics and kinetics), NOT the
-- source .docx's chapter ordering.
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
     AND title   IN ('Chemical Kinetics', 'Kinetics', 'Chapter 5 — Chemical Kinetics');

  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'chemistry',
    'General Chemistry',
    'chemical_kinetics',
    'Chemical Kinetics',
    'Chemical kinetics for the MCAT: reaction rates and rate expressions; rate laws, reaction order, and the units of k; integrated rate laws and the linear-plot signatures of zero-, first-, and second-order reactions; collision theory and activation energy; the Arrhenius equation and temperature dependence; transition-state theory and reaction-energy profiles; reaction mechanisms and the rate-determining step; and catalysis (homogeneous vs heterogeneous, effect on Ea but not on ΔG or Keq).',
    5
  )
  RETURNING id INTO deck;

  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── Reaction Rates ────────────────────────────────────────
  (deck, 0, 'cloze',
   'A reaction rate is written as a concentration change per unit time; because reactants are consumed, their rate expression carries a {{c1::negative}} sign, while product expressions carry a {{c2::positive}} sign so that the reported rate stays positive.', 2),
  (deck, 1, 'cloze',
   'For reactants and products in solution, reaction rate is reported in units of {{c1::M·s⁻¹}} (equivalently mol·L⁻¹·s⁻¹) — a molar concentration change divided by a time interval.', 1),
  (deck, 2, 'cloze',
   'For a single reaction, the rate written for any one species can be converted to that of any other species using the {{c1::stoichiometric coefficients}} of the balanced equation.', 1),
  (deck, 3, 'cloze',
   'For heterogeneous reactants, reaction happens only at the {{c1::interface between the phases}}, so dividing a solid into smaller particles speeds the reaction by increasing the reactive {{c2::surface area}}.', 2),

  -- ── Rate Laws & Reaction Order ────────────────────────────
  (deck, 4, 'cloze',
   'In a rate law, rate = k[A]ᵐ[B]ⁿ, the term {{c1::k}} is the rate constant and the exponents {{c2::m and n}} are the reaction orders, all of which must be found {{c3::experimentally}} (not from the balanced equation).', 3),
  (deck, 5, 'cloze',
   'The {{c1::method of initial rates}} determines a rate law by comparing initial rates across trials in which the {{c2::initial reactant concentrations}} are varied one at a time, revealing each reactant''s order.', 2),
  (deck, 6, 'cloze',
   'The rate constant k is {{c1::independent of reactant concentration}}, but it does change with {{c2::temperature}}, which is why the same reaction speeds up when heated even though k stays fixed as concentrations change.', 2),
  (deck, 7, 'cloze',
   'The overall order of a reaction equals the {{c1::sum of the individual reactant orders}}; a rate law of rate = k[A]¹[B]² is therefore {{c2::third}} order overall.', 2),
  (deck, 8, 'cloze',
   'Reaction orders are usually small positive integers but can also be {{c1::fractional, negative, or zero}}, and they are established by {{c2::experiment}} rather than predicted from the reaction''s stoichiometric coefficients.', 2),
  (deck, 9, 'cloze',
   'When a reaction is {{c1::zero}} order in a given reactant, that reactant''s concentration term drops out of the rate law because any concentration raised to the {{c2::zeroth}} power equals 1, so its concentration has no effect on the rate.', 2),

  -- ── Reaction Orders (Integrated Rate Laws) ────────────────
  (deck, 10, 'cloze',
   'In the rate law rate = k[A]ᵐ[B]ⁿ, the exponents m and n are the {{c1::reaction orders}}, and the overall order is their {{c2::sum}} — values that must be found {{c3::experimentally}}, never read off the balanced equation''s coefficients.', 3),
  (deck, 11, 'cloze',
   'A {{c1::zero}}-order reaction has rate = k, so its rate stays {{c2::constant regardless of reactant concentration}}; a plot of [A] versus t is linear with slope {{c3::−k}}, and k carries units of {{c4::M·s⁻¹}}.', 4),
  (deck, 12, 'cloze',
   'A {{c1::first}}-order reaction obeys rate = k[A], so doubling [A] {{c2::doubles}} the rate; the integrated law is [A]ₜ = [A]₀e^(−kt), a plot of {{c3::ln[A]}} versus t is linear with slope −k, and k has units of {{c4::s⁻¹}}.', 4),
  (deck, 13, 'cloze',
   'A {{c1::second}}-order reaction (rate = k[A]²) plots linearly as {{c2::1/[A]}} versus t, with a slope of {{c3::+k}} (positive, unlike the first- and zero-order plots), and its rate constant carries units of {{c4::M⁻¹·s⁻¹}}.', 4),
  (deck, 14, 'cloze',
   'The three orders are told apart by which concentration plot goes linear: {{c1::[A] vs t}} for zero order, {{c2::ln[A] vs t}} for first order, and {{c3::1/[A] vs t}} for second order.', 3),
  (deck, 15, 'cloze',
   'The rate constant''s units reveal the overall order: {{c1::M·s⁻¹}} signals zero order, {{c2::s⁻¹}} signals first order, and {{c3::M⁻¹·s⁻¹}} signals second order.', 3),
  (deck, 16, 'cloze',
   'The half-life of a {{c1::first}}-order reaction is {{c2::independent of}} the starting concentration, whereas half-lives for other reaction orders do depend on reactant concentration.', 2),
  (deck, 17, 'cloze',
   'Half-life behavior distinguishes the orders: a first-order t₁/₂ is {{c1::independent of concentration}}, a second-order t₁/₂ {{c2::lengthens as reactant is consumed}}, and a zero-order t₁/₂ {{c3::shortens as reactant is consumed}} (it grows with higher initial concentration).', 3),
  (deck, 18, 'cloze',
   'Radioactive decay is the classic {{c1::first-order}} process: the disintegration rate is proportional to the amount of isotope present (rate = k[A]), which is why its {{c2::half-life is constant}}, independent of how much sample remains.', 2),

  -- ── Collision Theory & Activation Energy ──────────────────
  (deck, 19, 'cloze',
   '{{c1::Collision theory}} holds that molecules must physically collide before they can react, and it predicts the reaction rate is {{c2::proportional to the rate (frequency) of reactant collisions}}.', 2),
  (deck, 20, 'cloze',
   'Not every collision produces a reaction — an effective (reactive) collision requires both the {{c1::correct spatial orientation of the colliding molecules and a collision energy at least equal to the activation energy}}.', 1),
  (deck, 21, 'cloze',
   'The {{c1::activation energy (Eₐ)}} is the {{c2::minimum energy}} a collision must supply for reactants to be converted to product; it functions as the energy barrier separating reactants from products.', 2),
  (deck, 22, 'cloze',
   'Raising reactant concentration {{c1::increases}} the rate (for all but zero-order reactions) because packing {{c2::more molecules per unit volume}} raises the number of collisions per second.', 2),

  -- ── Arrhenius Equation & Temperature Dependence ───────────
  (deck, 23, 'cloze',
   'The Arrhenius equation, k = {{c1::Ae^(−Eₐ/RT)}}, ties a reaction''s rate constant to its {{c2::activation energy}} and to {{c3::temperature}}.', 3),
  (deck, 24, 'cloze',
   'In the Arrhenius equation the exponential factor is {{c1::e^(−Eₐ/RT)}}, where R = {{c2::8.314 J·mol⁻¹·K⁻¹}} and T is in {{c3::kelvin}}.', 3),
  (deck, 25, 'cloze',
   'The pre-exponential term A in the Arrhenius equation is the {{c1::frequency factor}}, which captures how often collisions occur and whether they have a {{c2::proper orientation}} for reaction.', 2),
  (deck, 26, 'cloze',
   'Because Eₐ sits in the exponent as e^(−Eₐ/RT), a {{c1::lower}} activation energy leaves a {{c2::larger}} fraction of molecules with enough energy to react, giving a faster rate.', 2),
  (deck, 27, 'cloze',
   'Raising temperature speeds a reaction because it shifts the molecular energy distribution so a {{c1::greater}} fraction of molecules clear the activation barrier, which {{c2::increases}} the rate constant k.', 2),
  (deck, 28, 'cloze',
   'A common rule of thumb from collision theory is that many reaction rates roughly {{c1::double}} for every {{c2::10 °C}} rise in temperature.', 2),
  (deck, 29, 'cloze',
   'Taking the natural log linearizes the Arrhenius equation to ln k = {{c1::−Eₐ/R · (1/T) + ln A}}; a plot of ln k versus 1/T is a line whose slope equals {{c2::−Eₐ/R}}.', 2),
  (deck, 30, 'cloze',
   'Measuring k at just two temperatures lets you solve for activation energy with the two-point form ln(k₂/k₁) = {{c1::(Eₐ/R)(1/T₁ − 1/T₂)}}, avoiding a full {{c2::ln k vs 1/T}} plot.', 2),
  (deck, 31, 'cloze',
   'Raising temperature normally accelerates a reaction because more molecules clear the activation barrier — but {{c1::enzyme-catalyzed}} reactions are the exception: activity climbs only up to an {{c2::optimal temperature}}, then falls off sharply as excess heat {{c3::denatures}} the enzyme.', 3),

  -- ── Transition-State Theory & Energy Profiles ─────────────
  (deck, 32, 'cloze',
   'When reactants collide with correct orientation and enough energy, they briefly form a high-energy, unstable species called the {{c1::activated complex}} (or {{c1::transition state}}), which then either decays forward to products or reverts to reactants.', 1),
  (deck, 33, 'cloze',
   'When reactants collide with proper orientation and adequate energy they form a short-lived {{c1::activated complex (transition state)}}, which sits at {{c2::higher energy than both the reactants and the products}} at the peak of the reaction coordinate.', 2),
  (deck, 34, 'cloze',
   'The {{c1::activation energy (Eₐ)}} is the minimum energy a collision must supply to form product, and on a reaction diagram it equals the energy gap from the {{c2::reactants}} up to the {{c3::transition state}}.', 3),
  (deck, 35, 'cloze',
   'On an energy profile, activation energy is a {{c1::kinetic}} quantity that sets the rate, whereas the reactant-to-product energy difference is the {{c2::thermodynamic}} quantity ΔH (or ΔG); a reaction is exothermic when the products sit {{c3::lower}} in energy than the reactants.', 3),
  (deck, 36, 'cloze',
   'A catalyst speeds a reaction by opening an alternative pathway with a {{c1::lower activation energy}}, lowering the barrier for the forward and reverse steps {{c2::equally}}; it leaves ΔG, ΔH, and Keq {{c3::unchanged}}, so equilibrium is reached faster but not shifted.', 3),

  -- ── Reaction Mechanisms & Rate-Determining Step ───────────
  (deck, 37, 'cloze',
   'A reaction {{c1::mechanism}} is the step-by-step sequence of {{c2::elementary reactions}} that must sum to give the overall balanced equation, which by itself reveals nothing about how the reaction actually proceeds.', 2),
  (deck, 38, 'cloze',
   'A species that is generated in one elementary step and used up in a later step is a reaction {{c1::intermediate}}; because it never appears in the overall equation, its concentration must be eliminated when deriving the overall {{c2::rate law}}.', 2),
  (deck, 39, 'cloze',
   'The {{c1::molecularity}} of an elementary step is the number of reactant particles that collide, so a unimolecular step is {{c2::first}}-order and a bimolecular step is {{c2::second}}-order overall.', 2),
  (deck, 40, 'cloze',
   '{{c1::Termolecular}} elementary steps are rare because the odds of three particles colliding at once are less than {{c2::one one-thousandth}} the odds of a two-particle collision.', 2),
  (deck, 41, 'cloze',
   'The rate law of an {{c1::elementary}} step can be written straight from its balanced equation using the reactant coefficients as orders, but the rate law of an overall (multistep) reaction can only be established by {{c2::experiment}}.', 2),
  (deck, 42, 'cloze',
   'A multistep reaction can never run faster than its {{c1::slowest}} elementary step, which is why that step is called the {{c2::rate-determining (rate-limiting)}} step.', 2),
  (deck, 43, 'cloze',
   'When the {{c1::rate-determining step is the first step}} of a mechanism, the overall rate law is simply that step''s rate law; if a fast reversible equilibrium precedes it, you must first replace any {{c2::intermediate}} concentration with reactant terms.', 2),

  -- ── Catalysis ─────────────────────────────────────────────
  (deck, 44, 'cloze',
   'A {{c1::catalyst}} accelerates a reaction yet is {{c2::not consumed}} overall — it is {{c2::regenerated}} in a later step, so it can turn over many reactant molecules.', 2),
  (deck, 45, 'cloze',
   'A catalyst speeds a reaction by providing an {{c1::alternative reaction pathway}} that has a {{c2::lower activation energy}}, not by increasing the energy of the colliding molecules.', 2),
  (deck, 46, 'cloze',
   'A catalyst lowers Eₐ but leaves the {{c1::equilibrium constant (Keq)}}, the {{c1::equilibrium concentrations}}, and {{c1::ΔG of the reaction}} unchanged — it alters kinetics, never thermodynamics.', 1),
  (deck, 47, 'cloze',
   'Because a catalyst lowers the barrier for {{c1::both the forward and reverse}} directions equally, the system can {{c2::reach equilibrium more quickly}} without shifting where that equilibrium lies.', 2),
  (deck, 48, 'cloze',
   'In {{c1::homogeneous}} catalysis the catalyst shares the same phase as the reactants; in {{c2::heterogeneous}} catalysis it occupies a different phase, usually a solid whose surface hosts the reaction.', 2),
  (deck, 49, 'cloze',
   'Heterogeneous catalysis on a solid surface proceeds by {{c1::adsorption}} of reactants onto the surface, their activation and reaction, then {{c1::desorption}} of the products.', 1),
  (deck, 50, 'cloze',
   'In living systems the biological catalysts that accelerate metabolic reactions are {{c1::enzymes}}, such as glucose-6-phosphate dehydrogenase in the NADPH-supplying pathway.', 1);

  RAISE NOTICE 'Seeded deck: Chemical Kinetics (% cards)', (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
