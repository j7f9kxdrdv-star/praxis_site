-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 12 — Bioenergetics and Regulation of Metabolism
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: bioenergetics_and_regulation_of_metabolism
-- Sort order: 12
--
-- Coverage (AAMC-aligned order):
--   1.  Open vs Closed Systems + Internal Energy
--   2.  Enthalpy, Entropy, Gibbs Free Energy
--   3.  ΔG and Spontaneity
--   4.  Standard vs Physiological Conditions
--   5.  ATP Structure & Energy Tier
--   6.  ATP Hydrolysis & Coupling
--   7.  Biological Oxidation-Reduction
--   8.  Electron Carriers (NAD+, NADP+, FAD)
--   9.  Metabolic States Overview
--   10. Insulin
--   11. Glucagon
--   12. Cortisol & Catecholamines
--   13. Thyroid Hormone
--   14. Tissue Metabolism: Liver & Adipose
--   15. Tissue Metabolism: Muscle, Heart, Brain
--   16. Integrative Metabolism + Body Mass
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- LibreTexts Biochemistry (Bioenergetics; ATP and Phosphoryl Transfer;
-- Electron Carriers; Hormonal Regulation of Metabolism; Tissue-Specific
-- Metabolism), OpenStax Anatomy & Physiology 2e (Ch 17 Endocrine; Ch 24
-- Metabolism and Nutrition), and OpenStax Chemistry: Atoms First 2e
-- (Ch 16 Thermodynamics) — plus the AAMC Foundation 1D Concept 1 and
-- Foundation 3A content outlines. See companion .verification.md for
-- per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'Bioenergetics and Regulation of Metabolism',
          'Bioenergetics & Regulation of Metabolism',
          'Biochemistry Review Chapter 12: Bioenergetics and Regulation of Metabolism'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'bioenergetics_and_regulation_of_metabolism',
        'Bioenergetics and Regulation of Metabolism',
        'Open and closed biological systems; enthalpy, entropy, and Gibbs free energy; spontaneity and coupling; standard vs physiological free-energy conditions; ATP structure and the high-energy phosphoanhydride bond; biological oxidation-reduction and electron carriers (NAD+/NADH, NADP+/NADPH, FAD/FADH2); the three metabolic states (postprandial, postabsorptive, prolonged fasting); the major regulatory hormones (insulin, glucagon, cortisol, catecholamines, thyroid hormones); tissue-specific fuel preferences for liver, adipose, skeletal and cardiac muscle, and brain; respiratory quotient, calorimetry, BMR, and the appetite hormones (ghrelin, leptin, orexin); BMI.',
        12
    )
    RETURNING id INTO deck;

    -- ── Open vs Closed Systems + Internal Energy ────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'An {{c1::open system}} exchanges both energy and matter with its environment; a {{c1::closed system}} exchanges only energy (no matter).',
     1),
    (deck, 1, 'cloze',
     'The {{c1::internal energy (U)}} of a system is the sum of all atomic-level interactions — vibrational, rotational, translational, and stored chemical bonds.',
     1),
    (deck, 2, 'cloze',
     'In a closed system, the change in internal energy obeys ΔU = {{c1::Q − W}}: energy can enter as heat (Q) or leave as work (W) done on the surroundings.',
     1);

    -- ── Enthalpy, Entropy, Gibbs Free Energy ────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 3, 'cloze',
     '{{c1::Enthalpy (ΔH)}} measures the total heat content change during a reaction; at constant pressure, ΔH equals the heat exchanged with the surroundings.',
     1),
    (deck, 4, 'cloze',
     '{{c1::Entropy (ΔS)}} measures the degree of {{c2::disorder}} or energy dispersion in a system; increasing entropy favors spontaneous reactions.',
     2),
    (deck, 5, 'cloze',
     'The {{c1::Gibbs free energy}} equation combines enthalpy and entropy at temperature T: ΔG = {{c2::ΔH − TΔS}}, predicting spontaneity at a given temperature.',
     2),
    (deck, 6, 'cloze',
     'A reaction is always spontaneous when ΔH is {{c1::negative}} and ΔS is {{c1::positive}}; always nonspontaneous when ΔH is positive and ΔS is negative.',
     1);

    -- ── ΔG and Spontaneity ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
     'A {{c1::negative}} ΔG indicates a spontaneous (exergonic) reaction that proceeds forward; a {{c1::positive}} ΔG indicates a nonspontaneous (endergonic) reaction that requires energy input.',
     1),
    (deck, 8, 'cloze',
     'As a reaction approaches equilibrium, ΔG approaches {{c1::zero}}; at equilibrium there is no net change in the concentrations of products and reactants.',
     1),
    (deck, 9, 'cloze',
     'ΔG depends on actual concentrations via ΔG = {{c1::ΔG° + RT ln(Q)}}; reactions with more products than reactants are more endergonic (positive ΔG) than at standard state.',
     1),
    (deck, 10, 'cloze',
     'When H⁺ is a {{c1::reactant}}, lowering pH (more H⁺) drives the reaction {{c2::forward}} toward products; when H⁺ is a {{c1::product}}, lowering pH shifts equilibrium {{c2::backward}} (basic conditions favor product formation).',
     2),
    (deck, 11, 'cloze',
     'Cells drive otherwise unfavorable reactions by {{c1::coupling}} them to highly exergonic reactions like {{c2::ATP hydrolysis}}, summing the ΔG values so the net is negative.',
     2);

    -- ── Standard vs Physiological Conditions ────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 12, 'cloze',
     '{{c1::Standard free energy (ΔG°)}} is measured at standard concentrations (1 M), pressure (1 atm), and temperature ({{c2::25 °C}}).',
     2),
    (deck, 13, 'cloze',
     'Biological standard free energy {{c1::ΔG°''}} adjusts for {{c2::pH 7}} and physiological conditions (typically 37 °C, ~310 K).',
     2),
    (deck, 14, 'cloze',
     'Living cells are NOT at chemical equilibrium — most metabolic reactions are kept far from equilibrium so that cells can continuously {{c1::harness free energy}} for work.',
     1);

    -- ── ATP Structure & Energy Tier ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     '{{c1::ATP (adenosine triphosphate)}} consists of an adenosine (adenine + ribose) attached to {{c2::three}} phosphate groups in series.',
     2),
    (deck, 16, 'cloze',
     'ATP is a {{c1::mid-level}} energy carrier — its phosphoanhydride bonds carry enough free energy to drive most cellular reactions but not so much that it cannot be regenerated.',
     1),
    (deck, 17, 'cloze',
     'Removing one phosphate from ATP gives {{c1::ADP (adenosine diphosphate)}}; removing two gives {{c1::AMP (adenosine monophosphate)}}.',
     1);

    -- ── ATP Hydrolysis & Coupling ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     'ATP is regenerated from ADP + Pi through two mechanisms: {{c1::substrate-level phosphorylation}} (direct transfer in glycolysis and TCA) and {{c1::oxidative phosphorylation}} (driven by the proton motive force at ATP synthase).',
     1),
    (deck, 19, 'cloze',
     'ATP hydrolysis is highly exergonic because the products (ADP + Pi) are stabilized by {{c1::resonance}}, {{c1::ionization}}, and relief of {{c1::charge repulsion}} that exist in ATP itself.',
     1),
    (deck, 20, 'cloze',
     'Instead of free hydrolysis, ATP often donates a phosphate group directly to another molecule by {{c1::phosphoryl group transfer}}, activating that substrate for the next reaction.',
     1),
    (deck, 21, 'cloze',
     'ATP is a poor {{c1::long-term storage}} molecule because it is unstable and cycles rapidly; fats and glycogen are used for long-term storage instead.',
     1);

    -- ── Biological Oxidation-Reduction ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 22, 'cloze',
     'Redox reactions are often analyzed as two {{c1::half-reactions}} — one oxidation, one reduction — making it easier to track {{c2::electron flow}} and calculate net free energy.',
     2),
    (deck, 23, 'cloze',
     'Many cellular redox reactions are mediated by reusable {{c1::electron carriers}} that shuttle high-energy electrons between enzymes; carriers may be {{c2::soluble}} or {{c2::membrane-bound}}.',
     2),
    (deck, 24, 'cloze',
     'Common cytoplasmic electron carriers include {{c1::NADH}}, {{c1::NADPH}}, {{c1::FADH₂}}, plus glutathione, cytochromes, and ubiquinone.',
     1);

    -- ── Electron Carriers (NAD+, NADP+, FAD) ────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 25, 'cloze',
     '{{c1::NAD⁺}} is the major electron acceptor in {{c2::catabolic}} pathways — glycolysis, the citric acid cycle, and oxidative phosphorylation; it is reduced to NADH.',
     2),
    (deck, 26, 'cloze',
     '{{c1::NADP⁺}} differs from NAD⁺ by an extra phosphate; its reduced form NADPH drives {{c2::anabolic}} reactions like fatty acid synthesis and the pentose phosphate pathway.',
     2),
    (deck, 27, 'cloze',
     '{{c1::FAD (flavin adenine dinucleotide)}} is a flavoprotein derived from vitamin {{c2::B₂ (riboflavin)}}; it accepts electrons in the TCA cycle (Complex II / succinate DH) and fatty acid β-oxidation.',
     2),
    (deck, 28, 'cloze',
     'As a memory trick: {{c1::NAD⁺/NADH}} powers catabolism (energy harvest); {{c1::NADP⁺/NADPH}} powers anabolism (biosynthesis and antioxidant defense).',
     1);

    -- ── Metabolic States Overview ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     'The {{c1::postprandial (well-fed/absorptive)}} state begins shortly after eating: blood glucose rises, {{c2::insulin}} surges, and the body shifts toward anabolic metabolism (storage).',
     2),
    (deck, 30, 'cloze',
     'The {{c1::postabsorptive (short-term fasting)}} state follows a normal interval between meals: insulin drops while {{c2::glucagon}} and catecholamines rise, triggering catabolic metabolism.',
     2),
    (deck, 31, 'cloze',
     'In {{c1::prolonged fasting (starvation)}}, glucagon and epinephrine are dramatically elevated; after about 24 hours, {{c2::gluconeogenesis}} becomes the dominant glucose source for the body.',
     2),
    (deck, 32, 'cloze',
     'The {{c1::counter-regulatory}} hormones — glucagon, cortisol, epinephrine, norepinephrine, and growth hormone — all oppose the actions of {{c2::insulin}} on liver, muscle, and adipose tissue.',
     2);

    -- ── Insulin ─────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 33, 'cloze',
     '{{c1::Insulin}} is a peptide hormone secreted by the {{c2::β-cells}} of the pancreatic islets of Langerhans in response to elevated plasma {{c3::glucose}}.',
     3),
    (deck, 34, 'cloze',
     'The most important physiological controller of insulin secretion is {{c1::plasma glucose}}; insulin release is directly proportional to blood glucose concentration.',
     1),
    (deck, 35, 'cloze',
     'The three major target tissues for insulin are the {{c1::liver}}, {{c1::skeletal muscle}}, and {{c1::adipose tissue}}; in these tissues insulin promotes glucose uptake and anabolic storage.',
     1),
    (deck, 36, 'cloze',
     'In the liver and muscle, insulin activates {{c1::glucokinase}} and {{c2::glycogen synthase}} while inactivating glycogen phosphorylase — net effect: glucose storage as {{c3::glycogen}}.',
     3),
    (deck, 37, 'cloze',
     'In adipose tissue, insulin increases glucose uptake, activates {{c1::lipoprotein lipase}} (clearing VLDL and chylomicrons), and promotes {{c2::triacylglycerol synthesis}} while suppressing lipolysis.',
     2),
    (deck, 38, 'cloze',
     'In muscle cells, insulin increases {{c1::amino acid uptake}}, stimulates {{c2::protein synthesis}}, and decreases protein breakdown.',
     2),
    (deck, 39, 'cloze',
     'Tissues whose glucose uptake does NOT require insulin include {{c1::nervous tissue}}, {{c1::red blood cells}}, kidney tubules, intestinal mucosa, and {{c1::pancreatic β-cells}}.',
     1);

    -- ── Glucagon ────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 40, 'cloze',
     '{{c1::Glucagon}} is a peptide hormone secreted by the {{c2::α-cells}} of the pancreatic islets of Langerhans; its primary target tissue is the {{c3::hepatocyte}}.',
     3),
    (deck, 41, 'cloze',
     'Glucagon secretion is stimulated by {{c1::low}} plasma glucose and by a protein-rich meal; it is inhibited by {{c2::high}} plasma glucose.',
     2),
    (deck, 42, 'cloze',
     'In the liver, glucagon activates {{c1::glycogen phosphorylase}} and inactivates glycogen synthase — driving rapid breakdown of glycogen into glucose released into the bloodstream.',
     1),
    (deck, 43, 'cloze',
     'Glucagon stimulates hepatic gluconeogenesis by promoting the conversion of pyruvate to PEP via {{c1::pyruvate carboxylase}} and {{c1::PEP carboxykinase}}, and by activating {{c2::fructose-1,6-bisphosphatase}}.',
     2),
    (deck, 44, 'cloze',
     'Enzymes that {{c1::glucagon}} phosphorylates are generally dephosphorylated by {{c1::insulin}}, and vice versa — the two hormones operate in mirror image on metabolic enzymes.',
     1),
    (deck, 45, 'cloze',
     'Glucagon also increases hepatic {{c1::ketogenesis}} during prolonged fasting, supplying ketone bodies to peripheral tissues and the brain.',
     1);

    -- ── Cortisol & Catecholamines ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 46, 'cloze',
     '{{c1::Cortisol}} is a steroid hormone produced by the {{c2::adrenal cortex}}; its release is part of the stress response and follows a diurnal rhythm.',
     2),
    (deck, 47, 'cloze',
     'Cortisol elevates blood glucose by inhibiting glucose uptake in peripheral tissues and stimulating hepatic gluconeogenesis from {{c1::amino acids}}; it also increases lipolysis.',
     1),
    (deck, 48, 'cloze',
     'Cortisol has a {{c1::permissive}} function: it potentiates the metabolic effects of glucagon, epinephrine, and other catecholamines without producing those effects on its own.',
     1),
    (deck, 49, 'cloze',
     '{{c1::Catecholamines (epinephrine and norepinephrine)}} are secreted by the {{c2::adrenal medulla}}; they mediate the fight-or-flight response through the sympathetic nervous system.',
     2),
    (deck, 50, 'cloze',
     'Catecholamines activate {{c1::glycogen phosphorylase}} in liver and muscle, increase {{c2::lipolysis}} via hormone-sensitive lipase, and raise basal metabolic rate by acting on the heart and other organs.',
     2);

    -- ── Thyroid Hormone ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     '{{c1::Thyroid hormones (T₃, T₄)}} increase {{c2::basal metabolic rate}} — measured by elevated O₂ consumption and heat production — and act primarily on lipid and carbohydrate metabolism.',
     2),
    (deck, 52, 'cloze',
     '{{c1::T₄ (thyroxine)}} has a longer latency (hours to days) but a more sustained effect; {{c1::T₃ (triiodothyronine)}} acts more rapidly but has a shorter duration.',
     1),
    (deck, 53, 'cloze',
     'Peripheral tissues convert T₄ to the more potent {{c1::T₃}} as needed; T₃ is the predominant active form at the cellular level.',
     1),
    (deck, 54, 'cloze',
     '{{c1::Epinephrine}} requires thyroid hormone to exert its full metabolic effect — without sufficient T₃/T₄, catecholamines lose much of their metabolic punch.',
     1);

    -- ── Tissue Metabolism: Liver & Adipose ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 55, 'cloze',
     'The liver has two central metabolic roles: maintaining {{c1::constant blood glucose}} across the fed-fasting cycle, and synthesizing {{c2::ketone bodies}} when β-oxidation outpaces TCA capacity.',
     2),
    (deck, 56, 'cloze',
     'The liver is the body''s primary regulator of {{c1::blood glucose}}: it stores glucose as glycogen after meals and releases glucose through glycogenolysis and gluconeogenesis during fasting.',
     1),
    (deck, 57, 'cloze',
     'After a meal, the liver replenishes {{c1::glycogen}}, then converts excess glucose to {{c2::acetyl-CoA}} for fatty acid synthesis; FAs become TAGs released as VLDL.',
     2),
    (deck, 58, 'cloze',
     'In the well-fed state, the liver derives most of its energy from {{c1::amino acids}}; in the fasting state, it uses {{c1::fatty acids}}.',
     1),
    (deck, 59, 'cloze',
     'In the fed state, insulin drives glucose uptake and {{c1::triacylglycerol synthesis}} in adipose tissue; in fasting, HSL activates and adipose releases {{c2::free fatty acids}} into circulation.',
     2),
    (deck, 60, 'cloze',
     'In the fed state, adipose tissue accumulates fatty acids released from circulating {{c1::VLDL and chylomicrons}} by {{c2::lipoprotein lipase}}, then re-esterifies them into TAGs for storage.',
     2);

    -- ── Tissue Metabolism: Muscle, Heart, Brain ─────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 61, 'cloze',
     'Resting skeletal muscle uses {{c1::glucose}} after a meal (replenishing glycogen) and switches to {{c1::fatty acids}} and ketones during fasting.',
     1),
    (deck, 62, 'cloze',
     'Active muscle progresses through three energy sources: {{c1::creatine phosphate}} for the first seconds, then {{c1::anaerobic glycolysis}} for short bursts, then {{c1::aerobic oxidation}} of glucose and fatty acids for sustained activity.',
     1),
    (deck, 63, 'cloze',
     'Cardiac muscle prefers {{c1::fatty acids}} as fuel even in the fed state; during prolonged fasting it can also burn {{c2::ketones}}. A failing heart shifts to glucose oxidation.',
     2),
    (deck, 64, 'cloze',
     'The brain consumes about {{c1::25%}} of the body''s daily glucose; under normal conditions it relies entirely on {{c2::glucose}} from the bloodstream because fatty acids cannot cross the blood-brain barrier.',
     2),
    (deck, 65, 'cloze',
     'During prolonged fasting, the brain adapts to using {{c1::ketone bodies}} for up to two-thirds of its energy needs; this {{c2::spares protein}} that would otherwise be catabolized for gluconeogenesis.',
     2),
    (deck, 66, 'cloze',
     'In hypoglycemic conditions, the {{c1::hypothalamus}} senses falling blood glucose and triggers the release of {{c2::glucagon}} and epinephrine to restore plasma glucose.',
     2);

    -- ── Integrative Metabolism + Body Mass ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 67, 'cloze',
     'The {{c1::respiratory quotient (RQ)}} is defined as {{c2::CO₂ produced / O₂ consumed}}; its value reveals which fuel mixture (carbs, fats, proteins) the body is oxidizing.',
     2),
    (deck, 68, 'cloze',
     '{{c1::Calorimetry}} measures heat exchange with the environment, providing an empirical estimate of {{c2::basal metabolic rate (BMR)}} — the baseline energy expenditure at rest.',
     2),
    (deck, 69, 'cloze',
     'Body weight reflects long-term energy balance: weight is stable when energy intake equals expenditure, increases when intake exceeds expenditure (stored as {{c1::adipose triacylglycerols}}), and decreases when expenditure exceeds intake.',
     1),
    (deck, 70, 'cloze',
     '{{c1::Ghrelin}} is secreted by the {{c2::stomach}} in anticipation of meals (cued by sight, sound, taste, smell); it increases appetite and triggers orexin release.',
     2),
    (deck, 71, 'cloze',
     '{{c1::Leptin}} is secreted by {{c2::adipocytes}} (fat cells) and decreases appetite by suppressing orexin production — a satiety signal whose levels correlate with adipose mass.',
     2),
    (deck, 72, 'cloze',
     '{{c1::Orexin}} increases appetite and is also involved in the {{c2::sleep-wake cycle}} and alertness; hypoglycemia is one of its triggers.',
     2),
    (deck, 73, 'cloze',
     '{{c1::Body mass index (BMI)}} is calculated as {{c2::mass (kg) / height² (m²)}}; it is a rough population-level indicator of body composition but does not distinguish fat from muscle mass.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 74;
END $$;
