-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 2 — Enzymes
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: enzymes
-- Sort order: 2
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--   1.  Enzymes as Catalysts
--   2.  Endergonic vs Exergonic + Activation Energy
--   3.  Enzyme Classification (6 classes)
--   4.  Active Site & Substrate Binding
--   5.  Lock-and-Key vs Induced Fit
--   6.  Cofactors, Coenzymes, Apoenzyme/Holoenzyme
--   7.  Vitamins as Coenzyme Precursors
--   8.  Michaelis-Menten Kinetics
--   9.  Lineweaver-Burk Plot
--   10. kcat & Catalytic Efficiency
--   11. Cooperative Enzymes
--   12. Environmental Conditions
--   13. Feedback Regulation
--   14. Reversible Inhibition Types
--   15. Allosteric Enzymes & Irreversible Inhibition
--   16. Covalent Modifications & Zymogens
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- LibreTexts Biochemistry, OpenStax Chemistry: Atoms First 2e (activation
-- energy, transition state), and the AAMC Foundation 1D Concept 1 content
-- outline. See companion .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'Enzymes',
          'Biochemistry Review Chapter Two: Enzymes'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'enzymes',
        'Enzymes',
        'Enzymes as biological catalysts, the six enzyme classes, active-site mechanisms (lock-and-key vs induced fit), cofactors and coenzymes, Michaelis-Menten and Lineweaver-Burk kinetics, kcat and catalytic efficiency, cooperative enzymes and the Hill coefficient, environmental effects (temperature, pH, salinity), feedback regulation, the four reversible inhibition types, irreversible inhibition, allosteric enzymes, covalent modifications, and zymogens.',
        2
    )
    RETURNING id INTO deck;

    -- ── Enzymes as Catalysts ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     '{{c1::Enzymes}} are biological catalysts — proteins (or, rarely, RNAs) that speed up chemical reactions in the cell without being consumed by the reaction.',
     1),
    (deck, 1, 'cloze',
     'Enzymes accelerate reactions by lowering the {{c1::activation energy}} required to reach the transition state; they do not change the overall {{c2::ΔG}} or equilibrium of the reaction.',
     2),
    (deck, 2, 'cloze',
     'Enzymes affect only the {{c1::kinetics}} (rate) of a reaction, not its {{c1::thermodynamics}}; they can reach equilibrium faster but cannot shift the position of that equilibrium.',
     1),
    (deck, 3, 'cloze',
     '{{c1::Enzyme specificity}} means that each enzyme catalyzes only a particular reaction or a particular class of reaction acting on its specific {{c2::substrate(s)}}.',
     2);

    -- ── Endergonic vs Exergonic + Activation Energy ─────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 4, 'cloze',
     'An {{c1::endergonic}} reaction requires energy input to proceed and has a {{c2::positive}} ΔG; the products contain more free energy than the reactants.',
     2),
    (deck, 5, 'cloze',
     'An {{c1::exergonic}} reaction releases energy as it proceeds and has a {{c2::negative}} ΔG; the products contain less free energy than the reactants.',
     2),
    (deck, 6, 'cloze',
     'The {{c1::transition state}} is the highest-energy point along a reaction coordinate; activation energy is the gap between the reactant energy and this peak.',
     1);

    -- ── Enzyme Classification ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
     'Enzymes are sorted into {{c1::six}} classes by the type of reaction they catalyze; the names tell you the chemistry — for example, transferases transfer functional groups and hydrolases use water to break bonds.',
     1),
    (deck, 8, 'cloze',
     '{{c1::Oxidoreductases}} catalyze oxidation-reduction reactions, transferring electrons between molecules; they typically use a cofactor as an {{c2::electron carrier}} (e.g., NAD+/NADH, FAD/FADH2).',
     2),
    (deck, 9, 'cloze',
     '{{c1::Transferases}} catalyze the transfer of a functional group from one molecule to another; the {{c2::kinases}} are a key subclass that transfer a phosphate group, usually from ATP.',
     2),
    (deck, 10, 'cloze',
     '{{c1::Hydrolases}} break a single substrate into two products by adding water across a bond; examples include {{c2::peptidases, nucleases, and lipases}}.',
     2),
    (deck, 11, 'cloze',
     '{{c1::Lyases}} break a single substrate into two products (or join two into one) without using water and without an oxidation-reduction step, often forming or breaking a {{c2::ring or double bond}}.',
     2),
    (deck, 12, 'cloze',
     '{{c1::Isomerases}} rearrange bonds within a single molecule to interconvert {{c2::isomers}}, including stereoisomers and constitutional isomers.',
     2),
    (deck, 13, 'cloze',
     '{{c1::Ligases}} join two larger molecules in a synthesis reaction and typically require energy from hydrolysis of {{c2::ATP}}.',
     2),
    (deck, 14, 'cloze',
     'Both pancreatic and lysosomal enzymes are predominantly {{c1::hydrolases}}: pancreatic enzymes digest food in the small intestine, while lysosomal enzymes degrade macromolecules inside the cell.',
     1);

    -- ── Active Site & Substrate Binding ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'The {{c1::active site}} is the pocket on the enzyme where the substrate binds and catalysis takes place; its three-dimensional shape dictates the enzyme''s {{c2::specificity}}.',
     2),
    (deck, 16, 'cloze',
     'The temporary physical association between an enzyme and its substrate during catalysis is called the {{c1::enzyme-substrate (ES) complex}}.',
     1),
    (deck, 17, 'cloze',
     'Within the active site, {{c1::hydrogen bonds, ionic interactions, and transient covalent bonds}} between the enzyme and substrate stabilize the binding geometry and accelerate catalysis.',
     1);

    -- ── Lock-and-Key vs Induced Fit ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     'The {{c1::lock-and-key}} model assumes the active site is pre-shaped to match the substrate; no conformational change is needed for binding.',
     1),
    (deck, 19, 'cloze',
     'The {{c1::induced fit}} model says the substrate causes the active site to mold around it; the conformational change requires energy, making this binding step {{c2::endergonic}}.',
     2);

    -- ── Cofactors, Coenzymes, Apoenzyme/Holoenzyme ──────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
     '{{c1::Cofactors}} are non-protein helpers required for enzyme activity; they are typically {{c2::inorganic}} (metal ions like Zn2+, Mg2+), while {{c3::coenzymes}} are small {{c2::organic}} helpers, usually vitamin-derived.',
     3),
    (deck, 21, 'cloze',
     'An enzyme without its cofactor is an {{c1::apoenzyme}} (inactive); the same enzyme with its cofactor bound is a {{c1::holoenzyme}} (active).',
     1),
    (deck, 22, 'cloze',
     'A {{c1::prosthetic group}} is a cofactor or coenzyme that is tightly (often covalently) bound to its enzyme; it is required for function and does not dissociate easily.',
     1),
    (deck, 23, 'cloze',
     'Common organic coenzymes derived from vitamins include {{c1::NAD+}}, {{c1::FAD}}, and {{c1::coenzyme A}}; they shuttle electrons or functional groups between reactions.',
     1);

    -- ── Vitamins as Coenzyme Precursors ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 24, 'cloze',
     'The {{c1::water-soluble}} vitamins include the {{c2::B-complex}} vitamins and vitamin C (ascorbic acid); because they are easily excreted in urine, they must be replenished regularly.',
     2),
    (deck, 25, 'cloze',
     'The {{c1::fat-soluble}} vitamins are {{c2::A, D, E, and K}}; their absorption and storage depend on lipid partition coefficients, and they accumulate in body fat.',
     2),
    (deck, 26, 'cloze',
     'A {{c1::partition coefficient}} quantifies how a molecule distributes between a polar and a nonpolar environment; fat-soluble vitamins favor the nonpolar phase, which determines how they are absorbed and stored.',
     1);

    -- ── Michaelis-Menten Kinetics ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 27, 'cloze',
     'The {{c1::Michaelis-Menten}} equation describes initial reaction velocity: V = {{c2::Vmax[S] / (Km + [S])}}, predicting how rate depends on substrate concentration.',
     2),
    (deck, 28, 'cloze',
     '{{c1::Vmax}} is the maximum reaction rate reached when every active site is saturated with substrate; the only way to raise Vmax is to increase {{c2::enzyme concentration}}.',
     2),
    (deck, 29, 'cloze',
     '{{c1::Km}} (the Michaelis constant) equals the substrate concentration at which the reaction velocity is {{c2::half of Vmax}}.',
     2),
    (deck, 30, 'cloze',
     'Km is inversely related to enzyme-substrate affinity: a {{c1::small}} Km means the enzyme reaches half saturation at low [S] (high affinity); a {{c1::large}} Km means low affinity.',
     1),
    (deck, 31, 'cloze',
     'A plot of V vs [S] for a Michaelis-Menten enzyme is a {{c1::hyperbola}} that rises steeply at low [S] and asymptotically approaches {{c2::Vmax}} at high [S].',
     2);

    -- ── Lineweaver-Burk Plot ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     'The {{c1::Lineweaver-Burk}} plot is the double-reciprocal form of Michaelis-Menten: 1/V vs 1/[S]; this transformation linearizes the hyperbola for easy graphical analysis.',
     1),
    (deck, 33, 'cloze',
     'On a Lineweaver-Burk plot, the y-intercept equals {{c1::1/Vmax}} and the x-intercept equals {{c2::-1/Km}}.',
     2);

    -- ── kcat & Catalytic Efficiency ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     'The {{c1::turnover number (kcat)}} is the number of substrate molecules converted to product per enzyme molecule per second when the enzyme is fully {{c2::saturated}}.',
     2),
    (deck, 35, 'cloze',
     'kcat can be calculated from Vmax using {{c1::kcat = Vmax / [E]total}}, where [E]total is the total enzyme concentration.',
     1),
    (deck, 36, 'cloze',
     '{{c1::Catalytic efficiency}} is given by the ratio {{c2::kcat / Km}}; a high kcat (fast turnover) or low Km (tight binding) both increase it.',
     2);

    -- ── Cooperative Enzymes ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 37, 'cloze',
     '{{c1::Cooperative enzymes}} have multiple subunits and multiple active sites; substrate binding at one site changes the affinity of the other sites for substrate.',
     1),
    (deck, 38, 'cloze',
     'Cooperative enzyme subunits switch between a low-affinity {{c1::tense (T)}} state and a high-affinity {{c1::relaxed (R)}} state; substrate binding pulls subunits from T toward R.',
     1),
    (deck, 39, 'cloze',
     'A V vs [S] plot for a cooperative enzyme is {{c1::sigmoidal}} (S-shaped) rather than hyperbolic, reflecting the cooperative jump in affinity once binding begins.',
     1),
    (deck, 40, 'cloze',
     'The {{c1::Hill coefficient}} (n) quantifies cooperativity: n > 1 indicates {{c2::positive}} cooperativity, n < 1 indicates {{c2::negative}} cooperativity, and n = 1 indicates {{c2::no}} cooperativity.',
     2);

    -- ── Environmental Conditions ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 41, 'cloze',
     'Most human enzymes peak around {{c1::37°C}} (body temperature); reaction rate roughly doubles per 10°C rise up to this optimum, then falls sharply as the enzyme {{c2::denatures}}.',
     2),
    (deck, 42, 'cloze',
     'Some mildly overheated enzymes can regain function if cooled, but once {{c1::tertiary or quaternary}} structure is fully disrupted, denaturation is typically {{c2::irreversible}}.',
     2),
    (deck, 43, 'cloze',
     'The pH optimum for most enzymes is near {{c1::7.4}}; deviations alter the {{c2::ionization}} of active-site residues and can denature the enzyme.',
     2),
    (deck, 44, 'cloze',
     'Pepsin, which works in the stomach, has a pH optimum near {{c1::2}}; pancreatic enzymes, which work in the small intestine, have a pH optimum near {{c2::8.5}}.',
     2),
    (deck, 45, 'cloze',
     'High {{c1::salt}} concentrations disrupt {{c2::ionic and hydrogen}} bonds within an enzyme, altering conformation and, at extreme levels, causing denaturation.',
     2);

    -- ── Feedback Regulation ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 46, 'cloze',
     '{{c1::Feedback inhibition}} (negative feedback) occurs when the end product of a metabolic pathway inhibits an enzyme {{c2::earlier in the same pathway}}, conserving resources once the product accumulates.',
     2),
    (deck, 47, 'cloze',
     '{{c1::Feed-forward regulation}} is the opposite case: an early intermediate in a pathway activates a downstream enzyme, ramping up output in anticipation of demand.',
     1);

    -- ── Reversible Inhibition Types ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 48, 'cloze',
     'A {{c1::competitive inhibitor}} resembles the substrate and binds the {{c2::active site}}; the inhibition is overcome by adding more substrate, so Vmax is {{c3::unchanged}} but the apparent Km {{c3::increases}}.',
     3),
    (deck, 49, 'cloze',
     'A {{c1::noncompetitive inhibitor}} binds an {{c2::allosteric site}} and reduces the maximum rate; it cannot be overcome by adding substrate, so Vmax {{c3::decreases}} while Km is {{c3::unchanged}}.',
     3),
    (deck, 50, 'cloze',
     'An {{c1::uncompetitive inhibitor}} binds only to the {{c2::enzyme-substrate complex}}, locking the substrate in place; both Km and Vmax {{c3::decrease}} by the same factor.',
     3),
    (deck, 51, 'cloze',
     'A {{c1::mixed inhibitor}} binds an allosteric site on either the enzyme or the ES complex with different affinities; Vmax always {{c2::decreases}}, while Km can rise or fall based on which form is preferred.',
     2),
    (deck, 52, 'cloze',
     'If a mixed inhibitor prefers the {{c1::free enzyme}}, Km {{c2::rises}} (lowering apparent affinity); if it prefers the {{c1::ES complex}}, Km {{c2::falls}}.',
     2),
    (deck, 53, 'cloze',
     'A quick memory tool: {{c1::competitive}} affects Km only, {{c1::noncompetitive}} affects Vmax only, {{c1::uncompetitive}} affects both, and {{c1::mixed}} affects both with variable Km direction.',
     1);

    -- ── Allosteric Enzymes & Irreversible Inhibition ────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 54, 'cloze',
     '{{c1::Allosteric enzymes}} have at least one regulatory ({{c2::allosteric}}) site distinct from the active site; ligand binding at the allosteric site shifts the enzyme between active and inactive conformations.',
     2),
    (deck, 55, 'cloze',
     'An {{c1::allosteric activator}} stabilizes the enzyme conformation that has a more accessible active site, while an {{c1::allosteric inhibitor}} stabilizes the conformation that hides it.',
     1),
    (deck, 56, 'cloze',
     '{{c1::Irreversible inhibition}} occurs when the inhibitor binds the enzyme permanently — often through a {{c2::covalent}} bond at the active site — and cannot be reversed by removing substrate.',
     2),
    (deck, 57, 'cloze',
     'Classic irreversible inhibitors include {{c1::penicillin}}, which covalently inactivates a bacterial transpeptidase, and {{c1::aspirin}}, which covalently acetylates cyclooxygenase.',
     1);

    -- ── Covalent Modifications & Zymogens ───────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 58, 'cloze',
     '{{c1::Phosphorylation}} is a covalent enzyme modification in which a {{c2::kinase}} attaches a phosphate group (often from ATP) to a serine, threonine, or tyrosine residue, switching enzyme activity on or off.',
     2),
    (deck, 59, 'cloze',
     '{{c1::Phosphatases}} catalyze the removal of phosphate groups, reversing the activity switch made by kinases.',
     1),
    (deck, 60, 'cloze',
     '{{c1::Glycosylation}} is the covalent attachment of sugar groups to a protein; it can mark the enzyme for transport, alter its activity, or change its substrate selectivity.',
     1),
    (deck, 61, 'cloze',
     'A {{c1::zymogen}} (proenzyme) is an inactive precursor stored until needed; it is activated by a specific change — typically {{c2::proteolytic cleavage}} — that exposes its active site.',
     2),
    (deck, 62, 'cloze',
     'Many enzymes are named for what they do: a {{c1::cyclase}} makes cyclic molecules (e.g., adenylate cyclase makes cAMP), a {{c2::phosphatase}} removes phosphates, and an {{c3::acetylase}} adds acetyl groups.',
     3);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 63;
END $$;
