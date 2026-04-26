-- ============================================================
-- Praxis Prep — Flashcard Seed
-- Deck: Enzymes: Catalysis, Kinetics & Regulation
-- Section: biochemistry · Topic: Enzymes and Enzyme Kinetics
--
-- Coverage: enzymes as biological catalysts, the six enzyme
-- classes, substrate binding (lock-and-key vs induced fit),
-- cofactors / coenzymes / prosthetic groups, Michaelis–Menten
-- kinetics, kcat and catalytic efficiency, Lineweaver–Burk,
-- cooperativity and the Hill coefficient, effects of
-- temperature / pH / salinity, feedback and feed-forward
-- regulation, the four reversible inhibition modes plus
-- irreversible inhibition, allosteric regulation, covalent
-- modification, and zymogens.
--
-- All cards are CLOZE-format. Cards are original Praxis Prep
-- content — written from the underlying biochemistry, not
-- lifted from any third-party source material.
--
-- Idempotent: re-running deletes the prior version of this
-- deck and re-seeds. User review history attached to those
-- cards (flashcard_user_state, flashcard_reviews) cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  -- Wipe any prior copy of this deck
  -- (matches older working titles in case an earlier seed used them)
  DELETE FROM flashcard_decks
   WHERE section = 'biochemistry'
     AND title   IN ('Enzymes: Catalysis, Kinetics & Regulation',
                     'Chapter 2 — Enzymes',
                     'Enzymes');

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'biochemistry',
    'Enzymes and Enzyme Kinetics',
    'enzymes_catalysis_kinetics_regulation',
    'Enzymes: Catalysis, Kinetics & Regulation',
    'Enzymes as biological catalysts, the six enzyme classes, substrate binding and cofactors, Michaelis–Menten kinetics, cooperativity, environmental effects on activity, reversible and irreversible inhibition, allosteric and covalent regulation, and zymogens.',
    2
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── Enzymes & Catalysis ─────────────────────────────────────
  (deck,  0, 'cloze',
   'Enzymes are {{c1::biological catalysts}} — typically {{c2::proteins}} — that accelerate specific reactions inside living systems without being altered by the reactions themselves.', 2),

  (deck,  1, 'cloze',
   'A catalyst accelerates a reaction by lowering its {{c1::activation energy (Ea)}}, the barrier a reactant must clear to reach the transition state; the identities of the reactants and products are unchanged.', 1),

  (deck,  2, 'cloze',
   'The {{c1::transition state}} is the highest-energy configuration along the reaction coordinate; an enzyme works by stabilizing this state so it forms more readily.', 1),

  (deck,  3, 'cloze',
   'Although enzymes accelerate both the forward and reverse reactions, they do not shift the {{c1::equilibrium constant (Keq)}} — thermodynamics, not catalysis, determines where the reaction ultimately settles.', 1),

  (deck,  4, 'cloze',
   'Enzymes lower kinetic barriers but leave the overall {{c1::free-energy change (ΔG)}} untouched; catalysis therefore governs {{c2::how fast}} a reaction proceeds, not {{c2::whether}} it is thermodynamically favorable.', 2),

  (deck,  5, 'cloze',
   'Because an enzyme is regenerated at the end of each catalytic cycle, it is not {{c1::consumed}} by the reaction it speeds up — a single enzyme molecule can process millions of substrates before denaturing.', 1),

  (deck,  6, 'cloze',
   'A reaction is {{c1::exergonic}} when ΔG is {{c2::negative}} (spontaneous, releases free energy) and {{c1::endergonic}} when ΔG is {{c2::positive}} (non-spontaneous, requires free-energy input).', 2),

  (deck,  7, 'cloze',
   'The property known as enzyme {{c1::specificity}} means each enzyme recognizes only a narrow set of substrates, so every cellular reaction is driven by its own dedicated catalyst.', 1),

  (deck,  8, 'cloze',
   '{{c1::Oxidoreductases}} catalyze {{c2::redox}} reactions in which electrons pass between substrates; they rely on electron-carrier cofactors such as {{c2::NAD⁺/NADH}} or {{c2::FAD/FADH₂}}.', 2),

  (deck,  9, 'cloze',
   'In a redox reaction, the substrate that {{c1::loses}} electrons is oxidized and acts as the {{c2::reductant}}, while the substrate that {{c1::gains}} those electrons is reduced and acts as the {{c2::oxidant}}.', 2),

  (deck, 10, 'cloze',
   '{{c1::Transferases}} move a functional group from one molecule to another; the subclass that specifically transfers a {{c2::phosphate}} group — usually donated by ATP — is a {{c3::kinase}}.', 3),

  (deck, 11, 'cloze',
   '{{c1::Hydrolases}} cleave bonds by adding water; familiar subtypes include {{c2::phosphatases}} (remove phosphate), {{c2::peptidases/proteases}} (hydrolyze peptide bonds), {{c2::nucleases}} (cleave nucleic-acid bonds), and {{c2::lipases}} (cleave ester bonds in lipids).', 2),

  (deck, 12, 'cloze',
   '{{c1::Lyases}} break bonds without using water or redox chemistry, often forming or eliminating a {{c2::double bond}} or a ring; classic examples include {{c2::decarboxylases}} (releasing CO₂) and {{c2::dehydratases}} (releasing H₂O).', 2),

  (deck, 13, 'cloze',
   '{{c1::Isomerases}} rearrange atoms within a single molecule to produce its {{c2::isomer}}, covering racemization, cis–trans interconversion, and intramolecular group shifts.', 2),

  (deck, 14, 'cloze',
   '{{c1::Ligases}} join two substrates into a single product and pay for the new bond by hydrolyzing a {{c2::high-energy phosphate}}, most often supplied by {{c2::ATP}}.', 2),

  (deck, 15, 'cloze',
   'The pancreatic digestive enzymes — lipase, amylase, trypsin, and chymotrypsin — all belong to the {{c1::hydrolase}} class because they cleave their substrates using water.', 1),

  -- ── Substrate Binding & Cofactors ──────────────────────────
  (deck, 16, 'cloze',
   'The {{c1::active site}} is the small pocket on an enzyme where substrate docks and chemistry happens; its three-dimensional shape and residue chemistry set the enzyme''s specificity.', 1),

  (deck, 17, 'cloze',
   'When substrate binds the active site, the transient intermediate that forms before catalysis is the {{c1::enzyme–substrate (ES) complex}} — an obligatory step on the path to product.', 1),

  (deck, 18, 'cloze',
   'The {{c1::lock-and-key}} model imagines a rigid active site whose shape already matches the substrate, whereas the {{c2::induced-fit}} model — now considered more accurate — holds that substrate binding triggers a {{c3::conformational change}} that tightens the enzyme around it.', 3),

  (deck, 19, 'cloze',
   'Because the induced-fit rearrangement orients catalytic residues around one specific substrate geometry, enzymes exhibit {{c1::stereoselectivity}}, yielding a single stereoisomer of product from a defined stereochemical pathway.', 1),

  (deck, 20, 'cloze',
   '{{c1::Cofactors}} are the {{c1::inorganic}} enzyme helpers, most often {{c1::metal ions}} such as Zn²⁺, Mg²⁺, or Fe²⁺, whereas {{c2::coenzymes}} are the {{c2::organic}} helpers, many of which trace back to dietary {{c2::vitamins}}.', 2),

  (deck, 21, 'cloze',
   'An enzyme stripped of its required cofactor or coenzyme is catalytically inactive and is called an {{c1::apoenzyme}}; once the helper is bound and the complex can catalyze, it becomes a {{c2::holoenzyme}}.', 2),

  (deck, 22, 'cloze',
   'A {{c1::prosthetic group}} is a cofactor or coenzyme that is {{c2::tightly or covalently bound}} to its enzyme — unlike loosely associated coenzymes, it stays with the enzyme between catalytic cycles; the {{c2::heme}} group of cytochromes is a classic example.', 2),

  -- ── Kinetics: Michaelis–Menten, kcat & Cooperativity ───────
  (deck, 23, 'cloze',
   '{{c1::Michaelis–Menten kinetics}} describes how reaction velocity of a single-substrate enzyme depends on substrate concentration, producing a characteristic {{c2::hyperbolic}} curve that asymptotes at Vₘₐₓ.', 2),

  (deck, 24, 'cloze',
   '{{c1::Vₘₐₓ}} is the maximum velocity the reaction can reach once every active site is occupied — the enzyme population is fully {{c2::saturated}} with substrate.', 2),

  (deck, 25, 'cloze',
   '{{c1::Kₘ}} equals the substrate concentration at which reaction velocity reaches {{c1::half of Vₘₐₓ}}; a {{c2::low}} Kₘ reflects strong enzyme–substrate affinity, whereas a {{c2::rising}} Kₘ signals that the enzyme is losing its grip on the substrate.', 2),

  (deck, 26, 'cloze',
   'Raising substrate concentration {{c1::increases velocity}} until the enzyme is {{c1::saturated}}, after which velocity plateaus at Vₘₐₓ; raising enzyme concentration instead {{c2::raises the Vₘₐₓ ceiling}} itself, because more active sites become available.', 2),

  (deck, 27, 'cloze',
   'The turnover number {{c1::kcat}} is the number of substrate molecules each active site converts to product per unit time at saturation, and is calculated as {{c2::Vₘₐₓ / [E]ₜ}}.', 2),

  (deck, 28, 'cloze',
   '{{c1::Catalytic efficiency}} collapses an enzyme''s speed and affinity into a single number, defined as {{c2::kcat / Kₘ}}; higher values identify the more efficient catalyst.', 2),

  (deck, 29, 'cloze',
   'On a Lineweaver–Burk plot (1/v vs 1/[S]), the x-intercept equals {{c1::−1/Kₘ}}, the y-intercept equals {{c2::1/Vₘₐₓ}}, and the slope equals {{c3::Kₘ/Vₘₐₓ}} — a linear form that makes Kₘ and Vₘₐₓ easy to read off.', 3),

  (deck, 30, 'cloze',
   '{{c1::Cooperativity}} describes the situation in which substrate binding at one active site of a multi-subunit enzyme alters the affinity of the remaining sites, producing a {{c2::sigmoidal}} velocity curve rather than a hyperbolic one.', 2),

  (deck, 31, 'cloze',
   'A Hill coefficient of {{c1::n > 1}} indicates {{c1::positive cooperativity}} (sigmoidal curve), a value of {{c2::n < 1}} reflects {{c2::negative cooperativity}}, and {{c3::n = 1}} describes {{c3::non-cooperative}} Michaelis–Menten behavior.', 3),

  -- ── Temperature, pH & Salinity ─────────────────────────────
  (deck, 32, 'cloze',
   'Enzyme activity climbs with temperature up to an optimum and then falls sharply as heat disrupts non-covalent bonds and drives {{c1::denaturation}}; the overall activity-vs-temperature relationship is therefore {{c2::bell-shaped}} around that optimum.', 2),

  (deck, 33, 'cloze',
   'For most human enzymes the temperature optimum sits near {{c1::37 °C}}, equivalent to roughly {{c1::98.6 °F}} or {{c1::310 K}}.', 1),

  (deck, 34, 'cloze',
   '{{c1::Thermal stability}} describes how well an enzyme resists heat-driven unfolding — thermophilic enzymes such as Taq polymerase remain active at temperatures where most human enzymes have already denatured.', 1),

  (deck, 35, 'cloze',
   'Moving pH away from the optimum shifts the {{c1::ionization state}} of catalytic and substrate-binding residues, distorting binding geometry and catalysis; extreme deviations outright {{c2::denature}} the enzyme.', 2),

  (deck, 36, 'cloze',
   'Enzymes cluster around distinct pH optima: most cytosolic and blood-resident enzymes work near {{c1::7.4}}, gastric enzymes such as pepsin near {{c1::2}}, and pancreatic enzymes secreted into the small intestine near {{c1::7–8}}.', 1),

  (deck, 37, 'cloze',
   'High salt concentrations disrupt the {{c1::ionic interactions}} and {{c1::hydrogen bonds}} that hold an enzyme''s tertiary structure together, risking loss of active-site geometry and eventual {{c2::denaturation}}.', 2),

  -- ── Inhibition & Regulation ────────────────────────────────
  (deck, 38, 'cloze',
   '{{c1::Feedback inhibition}} (negative feedback) occurs when the end product of a metabolic pathway binds and inhibits an {{c2::earlier}} enzyme in the same pathway, preventing wasteful over-accumulation of that product.', 2),

  (deck, 39, 'cloze',
   '{{c1::Feed-forward regulation}} activates a downstream enzyme in response to rising levels of an {{c2::upstream intermediate}}, priming the pathway to handle flux that is already on its way.', 2),

  (deck, 40, 'cloze',
   'A {{c1::competitive}} inhibitor resembles the substrate and competes for the {{c2::active site}}; it {{c3::raises}} the apparent Kₘ but leaves Vₘₐₓ unchanged, because saturating substrate can outcompete it.', 3),

  (deck, 41, 'cloze',
   'A {{c1::noncompetitive}} inhibitor binds an {{c2::allosteric site}} whether or not substrate is already bound; it {{c3::lowers}} Vₘₐₓ while leaving Kₘ unchanged, because adding more substrate cannot rescue the crippled enzyme.', 3),

  (deck, 42, 'cloze',
   'An {{c1::uncompetitive}} inhibitor binds only the {{c2::enzyme–substrate complex}} and locks it, so both Kₘ and Vₘₐₓ {{c3::decrease}} by the same factor and the Vₘₐₓ/Kₘ ratio stays constant.', 3),

  (deck, 43, 'cloze',
   'A {{c1::mixed}} inhibitor binds an allosteric site on either the free enzyme or the ES complex; it {{c2::lowers}} Vₘₐₓ and shifts Kₘ {{c3::up or down}} depending on which form the inhibitor prefers.', 3),

  (deck, 44, 'cloze',
   'An {{c1::irreversible}} inhibitor binds — often {{c2::covalently}} — to a catalytic residue and permanently disables the enzyme; activity can only be restored when the cell synthesizes replacement enzyme.', 2),

  (deck, 45, 'cloze',
   '{{c1::Allosteric enzymes}} carry regulatory sites that sit apart from the active site; molecules binding these {{c2::allosteric sites}} shift the enzyme between {{c3::more-active and less-active}} conformations.', 3),

  (deck, 46, 'cloze',
   'An allosteric {{c1::activator}} stabilizes the enzyme''s high-affinity conformation and speeds catalysis, while an allosteric {{c2::inhibitor}} stabilizes the low-affinity conformation and slows it.', 2),

  (deck, 47, 'cloze',
   'Cooperative allosteric enzymes generate a {{c1::sigmoidal}} kinetics curve rather than the hyperbolic Michaelis–Menten curve, because substrate binding at one subunit shifts the affinity of the others.', 1),

  (deck, 48, 'cloze',
   '{{c1::Covalent modification}} regulates enzyme activity by reversibly attaching or removing functional groups — most commonly a {{c2::phosphate}} group (phosphorylation by kinases, removal by phosphatases), but also acetyl, methyl, or ubiquitin tags.', 2),

  (deck, 49, 'cloze',
   '{{c1::Kinases}} attach a phosphate group to activate or deactivate a target enzyme, while {{c2::phosphatases}} remove that phosphate and reverse the effect — a matched pair that lets the cell toggle activity on demand.', 2),

  (deck, 50, 'cloze',
   '{{c1::Glycosylation}} is the covalent attachment of carbohydrate chains to an enzyme or other protein and can regulate activity, stability, and correct {{c2::trafficking}} to the protein''s cellular destination.', 2),

  (deck, 51, 'cloze',
   '{{c1::Zymogens}} (proenzymes) are synthesized in an inactive form so they cannot digest the tissue that produces them; they become active only after {{c2::proteolytic cleavage}} removes a blocking segment.', 2),

  (deck, 52, 'cloze',
   '{{c1::Trypsinogen}} is the inactive pancreatic zymogen secreted into the small intestine, where enteropeptidase cleaves it into the active protease {{c2::trypsin}}, which then activates other pancreatic zymogens in a cascade.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
