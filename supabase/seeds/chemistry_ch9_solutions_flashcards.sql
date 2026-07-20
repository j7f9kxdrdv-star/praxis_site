-- ════════════════════════════════════════════════════════════════════
-- General Chemistry Chapter 9 — Solutions
-- ════════════════════════════════════════════════════════════════════
-- Section: chemistry
-- Topic:   General Chemistry
-- Subtopic slug: solutions
-- Sort order: 9
--
-- Coverage (AAMC-aligned order):
--    1. Nature of Solutions & Solvation
--    2. Solubility & Saturation
--    3. Units of Concentration
--    4. Solubility Equilibria: Ksp & the Ion Product
--    5. Common-Ion Effect, Complex Ions & Solubility/pH
--    6. Colligative Properties
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Chemistry (Atoms First) 2e. Scope: AAMC Solubility (GC) + Ions in Solutions (GC, BC)
-- + Colligative properties/osmotic pressure (GC). Out of scope: electrolytes (Ch 4),
-- Henry's law & gas mole fraction (Ch 8), Le Chatelier/Keq machinery (Ch 6), pH math
-- (Ch 10), solvent extraction (orgchem). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'chemistry'
      AND title IN (
          'Solutions',
          'General Chemistry Review Chapter Nine: Solutions'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'chemistry',
        'General Chemistry',
        'solutions',
        'Solutions',
        'The nature of solutions and solvation, solubility and saturation with the solubility rules, units of concentration (molarity, molality, mole fraction, percent by mass, normality) and dilution, solubility equilibria with the solubility product constant Ksp and the ion product, the common-ion effect and complex-ion formation with solubility and pH, and colligative properties including Raoult''s law, boiling-point elevation, freezing-point depression, and osmotic pressure.',
        9
    )
    RETURNING id INTO deck;

    -- ── Nature of Solutions & Solvation ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'A solution is a {{c1::homogeneous}} mixture — two or more substances dispersed into a {{c1::single phase}}.',
     1),
    (deck, 1, 'cloze',
     'In a homogeneous mixture, the component present in the greatest amount is the {{c1::solvent}}; the components present in lesser amounts are the {{c1::solutes}}.',
     1),
    (deck, 2, 'cloze',
     'Solvation establishes solute–solvent attractive forces; when the solvent is {{c1::water}}, the process is specifically called {{c1::hydration}}.',
     1),
    (deck, 3, 'cloze',
     'Forming a solution requires breaking {{c1::solute–solute and solvent–solvent}} attractions and establishing new {{c1::solute–solvent}} attractions.',
     1),
    (deck, 4, 'cloze',
     'Pulling solute particles apart and pulling solvent particles apart are {{c1::endothermic}} steps of dissolution; forming solute–solvent attractions is {{c1::exothermic}}.',
     1),
    (deck, 5, 'cloze',
     'Dissolving a gas in a liquid is overall {{c1::exothermic}}, because widely separated gas particles have no {{c1::solute-solute}} attractions needing energy to break.',
     1),
    (deck, 6, 'cloze',
     'The axiom "like dissolves like" means a solute dissolves best in a solvent of similar {{c1::polarity and intermolecular-force type}}.',
     1),
    (deck, 7, 'cloze',
     'Oils barely dissolve in water because water–water {{c1::hydrogen bonding}} is far stronger than any attraction water can form with nonpolar molecules.',
     1);

    -- ── Solubility & Saturation ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     'Solubility is the {{c1::maximum concentration}} a solute can reach in a particular solvent at a specified temperature and pressure.',
     1),
    (deck, 9, 'cloze',
     'A compound''s molar solubility gives the moles that dissolve in each liter of its {{c1::saturated solution}}.',
     1),
    (deck, 10, 'cloze',
     'A solution is {{c1::saturated}} when the dissolved solute concentration equals its solubility and {{c1::unsaturated}} when it falls below that limit.',
     1),
    (deck, 11, 'cloze',
     'A {{c1::supersaturated}} solution holds more dissolved solute than equilibrium solubility permits; this unstable state precipitates the excess when disturbed.',
     1),
    (deck, 12, 'cloze',
     'A supersaturated solution precipitates its excess solute once a {{c1::seed crystal}} is added or the solution is {{c1::mechanically agitated}}.',
     1),
    (deck, 13, 'cloze',
     'Heating water {{c1::increases}} the solubility of most solid solutes.',
     1),
    (deck, 14, 'cloze',
     'Gases generally become {{c1::less}} soluble in a liquid as the temperature of the solution rises.',
     1),
    (deck, 15, 'cloze',
     'Every salt whose cation is {{c1::a Group 1 (alkali metal) ion or ammonium, NH₄⁺}} dissolves in water, with no exceptions.',
     1),
    (deck, 16, 'cloze',
     'Nitrate (NO₃⁻) and acetate (CH₃COO⁻) salts are {{c1::soluble in water, with no exceptions}}.',
     1),
    (deck, 17, 'cloze',
     'Halide salts of Cl⁻, Br⁻, and I⁻ are water-soluble except those of {{c1::Ag⁺, Pb²⁺, and Hg₂²⁺}}.',
     1),
    (deck, 18, 'cloze',
     'Sulfate (SO₄²⁻) salts are water-soluble except those of {{c1::Ca²⁺, Sr²⁺, Ba²⁺}} and {{c2::Pb²⁺, Ag⁺, Hg₂²⁺}}.',
     2),
    (deck, 19, 'cloze',
     '{{c1::Carbonates, phosphates, sulfides, and sulfites}} are insoluble unless the cation is a Group 1 metal or ammonium (NH₄⁺).',
     1),
    (deck, 20, 'cloze',
     'Hydroxides and metal oxides are generally insoluble; the main exceptions are Group 1 cations, ammonium, and {{c1::Ca²⁺, Sr²⁺, and Ba²⁺}}, whose hydroxides are at least slightly soluble.',
     1);

    -- ── Units of Concentration ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 21, 'cloze',
     'Percent by mass = (mass of {{c1::solute}} / mass of {{c1::solution}}) × 100%; both masses must be expressed in the same unit.',
     1),
    (deck, 22, 'cloze',
     'The mole fraction χ of a solution component equals the moles of that component divided by {{c1::the total moles of every species present, solvent included}}.',
     1),
    (deck, 23, 'cloze',
     'Molarity (M) = moles of solute per liter of {{c1::solution — the total volume after mixing, not the solvent volume}}.',
     1),
    (deck, 24, 'cloze',
     'Molality (m) = moles of solute per kilogram of {{c1::solvent}}; because it is mass-based, molality does not change with temperature.',
     1),
    (deck, 25, 'cloze',
     'Normality (N) counts reactive {{c1::equivalents}} of solute per {{c1::liter of solution}}, so 1 M H₂SO₄ is {{c2::2}} N in acid–base reactions.',
     2),
    (deck, 26, 'cloze',
     'Molarity and molality are {{c1::nearly equal}} in dilute aqueous solution, because a liter of that solution has a mass close to {{c1::1 kg}}.',
     1),
    (deck, 27, 'cloze',
     'Heating a solution lowers its {{c1::molarity}} but not its {{c1::molality}}, the unit preferred for colligative-property equations.',
     1),
    (deck, 28, 'cloze',
     'Diluting a stock solution changes its volume and concentration but leaves {{c1::the moles of solute}} unchanged — the basis of the dilution equation.',
     1),
    (deck, 29, 'cloze',
     'The dilution equation is {{c1::M₁V₁ = M₂V₂}}, where subscript 1 is the concentrated stock and subscript 2 the final diluted solution.',
     1),
    (deck, 30, 'cloze',
     'Reaction rate laws, pH, and osmotic pressure all require the solute concentration expressed in {{c1::molarity}}.',
     1),
    (deck, 31, 'cloze',
     'Boiling-point elevation ΔTb and freezing-point depression ΔTf require concentration as {{c1::molality}}, while Raoult''s law requires {{c1::mole fraction χ}}.',
     1);

    -- ── Solubility Equilibria: Ksp & the Ion Product ──────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     'A saturated AgCl solution is in {{c1::dynamic}} equilibrium: solid dissolves into Ag⁺ and Cl⁻ at {{c1::the same rate}} the ions re-precipitate.',
     1),
    (deck, 33, 'cloze',
     'When an ionic solid separates into its aqueous ions, the equilibrium constant for that process is the {{c1::solubility product constant (Ksp)}}.',
     1),
    (deck, 34, 'cloze',
     'For the dissolution AₘBₙ(s) ⇌ mAⁿ⁺(aq) + nBᵐ⁻(aq), Ksp = {{c1::[Aⁿ⁺]ᵐ[Bᵐ⁻]ⁿ}}.',
     1),
    (deck, 35, 'cloze',
     'The excess undissolved salt is left out of a Ksp expression because the concentration of a pure solid is {{c1::constant}}.',
     1),
    (deck, 36, 'cloze',
     'For a dissolving salt, the {{c1::ion product (IP)}} is written exactly like Ksp but evaluated with the actual, non-equilibrium concentrations present.',
     1),
    (deck, 37, 'cloze',
     'When IP < Ksp, the solution is {{c1::unsaturated}} and {{c1::added solid will dissolve}}.',
     1),
    (deck, 38, 'cloze',
     'When the ion product exactly equals Ksp, the solution is {{c1::saturated}} — dissolution and precipitation run at equal rates, so ion concentrations hold steady.',
     1),
    (deck, 39, 'cloze',
     'A solution whose IP exceeds Ksp is {{c1::supersaturated}}, so solute {{c1::precipitates}} until IP drops back to Ksp.',
     1),
    (deck, 40, 'cloze',
     'Converting between Ksp and molar solubility is valid only if the dissolved ions undergo {{c1::no further reaction}} in solution.',
     1),
    (deck, 41, 'cloze',
     'Comparing Ksp values ranks solubility correctly only for salts sharing {{c1::the same dissolution stoichiometry}}; otherwise a larger Ksp can belong to the less soluble salt.',
     1);

    -- ── Common-Ion Effect, Complex Ions & Solubility/pH ───────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'AgI is far less soluble in 0.10 M NaI than in pure water — a classic demonstration of the {{c1::common ion}} effect.',
     1),
    (deck, 43, 'cloze',
     'Adding a common ion shifts AgI(s) ⇌ Ag⁺(aq) + I⁻(aq) {{c1::left}}, so AgI''s solubility {{c1::decreases}}.',
     1),
    (deck, 44, 'cloze',
     'Separating ions by slowly raising a shared counter-ion concentration so their salts come out of solution one at a time is called {{c1::selective precipitation}}.',
     1),
    (deck, 45, 'cloze',
     'In selective precipitation, when target ions are at equal concentration, the {{c1::least soluble}} salt precipitates {{c1::first}}.',
     1),
    (deck, 46, 'cloze',
     'A complex ion pairs a central metal cation — usually a transition metal — with bound molecules or ions called {{c1::ligands}}.',
     1),
    (deck, 47, 'cloze',
     'A ligand — either neutral (NH₃) or anionic (CN⁻) — {{c1::donates a lone pair}} to the central metal ion, so it acts as a Lewis {{c1::base}}.',
     1),
    (deck, 48, 'cloze',
     'In a complex ion, the central metal ion is the Lewis {{c1::acid}} — the electron-pair {{c1::acceptor}} in each coordinate covalent bond.',
     1),
    (deck, 49, 'cloze',
     'The metal–ligand bond in a complex ion is a {{c1::coordinate covalent (dative)}} bond, in which the ligand supplies {{c1::both}} bonding electrons.',
     1),
    (deck, 50, 'cloze',
     'A complex ion''s coordination number counts {{c1::donor atoms}} bound to the central metal — not ligands, since one polydentate ligand occupies several sites.',
     1),
    (deck, 51, 'cloze',
     'The equilibrium constant for a metal ion binding ligands into a complex ion is the {{c1::formation (or stability)}} constant, abbreviated {{c1::Kf}}.',
     1),
    (deck, 52, 'cloze',
     'Adding aqueous NH₃ to AgCl(s) {{c1::increases}} its solubility, because free Ag⁺ is tied up as the complex ion [Ag(NH₃)₂]⁺.',
     1),
    (deck, 53, 'cloze',
     'Salts of basic anions (carbonates, sulfides, hydroxides) become {{c1::more}} soluble as pH drops, because acid {{c1::consumes that anion and pulls dissolution forward}}.',
     1);

    -- ── Colligative Properties ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 54, 'cloze',
     'A solution property that depends only on how many solute particles are dissolved, not on what they are, is a {{c1::colligative}} property.',
     1),
    (deck, 55, 'cloze',
     'Nonvolatile solute particles crowd a solution''s surface, so {{c1::vaporization slows while condensation is unaffected}}; equilibrium therefore settles at a lower vapor pressure.',
     1),
    (deck, 56, 'cloze',
     'With only nonvolatile solutes, Raoult''s law gives a solution''s vapor pressure as {{c1::the solvent''s mole fraction times the pure solvent''s vapor pressure, P = χsolvent × P°solvent}}.',
     1),
    (deck, 57, 'cloze',
     'A liquid boils once its vapor pressure matches {{c1::the surrounding atmospheric pressure}}, so a nonvolatile solute that lowers vapor pressure {{c2::raises}} the boiling point.',
     2),
    (deck, 58, 'cloze',
     'For a nonvolatile solute, boiling-point elevation is ΔTb = {{c1::i·Kb·m}}.',
     1),
    (deck, 59, 'cloze',
     'For a dilute solution, freezing-point depression is {{c1::ΔTf = i·Kf·m, where Kf is the solvent''s cryoscopic (freezing-point-depression) constant and m is molality}}.',
     1),
    (deck, 60, 'cloze',
     'Kf is ambiguous: in ΔTf = i·Kf·m it is the solvent''s cryoscopic (freezing-point-depression) constant; in complex-ion equilibria it is the {{c1::formation (stability) constant}}.',
     1),
    (deck, 61, 'cloze',
     'A solution''s osmotic pressure (π) is the applied pressure that exactly halts {{c1::net solvent flow across a semipermeable membrane}}.',
     1),
    (deck, 62, 'cloze',
     'For a dilute solution, osmotic pressure π = {{c1::iMRT}}.',
     1),
    (deck, 63, 'cloze',
     'The van''t Hoff factor i equals {{c1::the number of particles released into solution per formula unit of solute dissolved}}.',
     1),
    (deck, 64, 'cloze',
     'Assuming complete dissociation, predicted van''t Hoff factors are glucose i = {{c1::1}}, NaCl i = {{c1::2}}, and CaCl₂ i = {{c1::3}}.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 65;
END $$;
