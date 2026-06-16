-- GenChem Ch4 (Compounds & Stoichiometry) — Batch 2 of 3: Reaction Types & Balancing Equations
-- 22 questions, all confidence >=4 (OpenStax Atoms First 2e; every calculation independently re-verified); cross-batch + cross-chapter deduped, audit clean (PASS, 0 genuine conflicts).
-- AAMC foundation 4E "Stoichiometry (GC)" for most rows; the ions/nomenclature/electrolytes items are tagged 5A "Ions in Solutions (GC)".
-- Out of MCAT scope and deliberately excluded: normality / equivalents / gram-equivalent weight, molarity calcs.
-- Re-runnable (subtopic-scoped DELETE). Run the three batches in any order in the Supabase SQL editor.
BEGIN;
DELETE FROM questions WHERE topic = 'Compounds & Stoichiometry' AND subtopic IN ('Types of Reactions', 'Balancing Equations (incl. redox)');

-- Q1 [Types of Reactions · easy · Skill 1 · 4E Stoichiometry (GC) · ans A] (g26)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt26$A sample of magnesium metal is burned in oxygen, proceeding by the balanced equation \(2\,\text{Mg} + \text{O}_2 \rightarrow 2\,\text{MgO}\). Which reaction type best classifies this process?$qt26$,
    $op26$[{"label":"A","text":"Combination (synthesis)"},{"label":"B","text":"Decomposition"},{"label":"C","text":"Single-displacement"},{"label":"D","text":"Double-displacement (metathesis)"}]$op26$::jsonb,
    'A',
    $ex26$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because two separate reactants, magnesium and oxygen, combine to form a single product, magnesium oxide, which is the defining pattern of a combination (synthesis) reaction (\(A + B \rightarrow AB\)). In \(2\,\text{Mg} + \text{O}_2 \rightarrow 2\,\text{MgO}\), two species enter and exactly one species leaves, so the reaction is unambiguously a synthesis. (Choice B) Decomposition runs in the opposite direction, with a single reactant breaking apart into two or more products (\(AB \rightarrow A + B\)); here two reactants converge into one product, so the equation cannot be a decomposition. (Choice C) Single-displacement requires one element to replace another within a compound (\(A + BC \rightarrow AC + B\)), but this equation has no compound on the reactant side for an element to displace from, and it yields only one product rather than an element plus a compound. (Choice D) Double-displacement requires two compounds to exchange ions and form two new compounds (\(AB + CD \rightarrow AD + CB\)); this reaction has no ionic compounds as reactants and produces a single product, so no exchange of partners occurs. Skill 1$ex26$,
    'easy', '4E', $cc26$Stoichiometry (GC)$cc26$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a26B$synthesis_vs_decomposition_direction$a26B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a26C$single_displacement_misapplied$a26C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a26D$double_displacement_misapplied$a26D$ FROM q;

-- Q2 [Types of Reactions · easy · Skill 1 · 4E Stoichiometry (GC) · ans B] (g27)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt27$Heating potassium chlorate drives the balanced reaction \(2\,\text{KClO}_3(s) \rightarrow 2\,\text{KCl}(s) + 3\,\text{O}_2(g)\), in which the single solid starting material yields two distinct products. This single-reactant-to-multiple-products pattern fixes the reaction class.$qt27$,
    $op27$[{"label":"A","text":"Combustion, because the reaction releases \\(\\text{O}_2\\) gas as one of its products."},{"label":"B","text":"Decomposition, because one reactant breaks apart into two or more simpler products."},{"label":"C","text":"Combination, because separate species join together to build a single product."},{"label":"D","text":"Single-displacement, because one element takes the place of another within a compound."}]$op27$::jsonb,
    'B',
    $ex27$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the equation shows exactly one reactant, \(\text{KClO}_3\), splitting into two simpler products, \(\text{KCl}\) and \(\text{O}_2\), which is the defining signature of a decomposition reaction (a single compound broken down, often by heating, into two or more substances). Recognizing the general form \(\text{AB} \rightarrow \text{A} + \text{B}\) is enough to classify it: one species in, multiple species out. (Choice A) Combustion is the reaction of a fuel with \(\text{O}_2\) as a reactant to give oxide products such as \(\text{CO}_2\) and \(\text{H}_2\text{O}\); here \(\text{O}_2\) is produced rather than consumed, so the mere presence of oxygen gas does not make this combustion. (Choice C) Combination (synthesis) is the exact reverse of what occurs here, since it joins two or more reactants into one product (form \(\text{A} + \text{B} \rightarrow \text{AB}\)); this equation moves from one reactant to several products, the opposite direction. (Choice D) Single-displacement requires a free element to replace another element already bound in a compound (form \(\text{A} + \text{BC} \rightarrow \text{AC} + \text{B}\)), but no free element appears among the reactants, so nothing is being displaced. Skill 1$ex27$,
    'easy', '4E', $cc27$Stoichiometry (GC)$cc27$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a27A$Invokes combustion by spotting oxygen gas in the equation, ignoring that combustion consumes O2 as a reactant rather than producing it$a27A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a27C$Names combination/synthesis, which is the directional reverse of decomposition (many reactants to one product)$a27C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a27D$Selects single-displacement despite no free element being present to displace another from a compound$a27D$ FROM q;

-- Q3 [Types of Reactions · medium · Skill 1 · 4E Stoichiometry (GC) · ans C] (g28)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt28$A sample of liquid octane, \(\text{C}_8\text{H}_{18}\), is ignited in a stream of excess \(\text{O}_2\), where it reacts rapidly and releases a large amount of heat and light. This conversion of a hydrocarbon fuel is best classified as which type of reaction?$qt28$,
    $op28$[{"label":"A","text":"A combination reaction"},{"label":"B","text":"A decomposition reaction"},{"label":"C","text":"A combustion reaction"},{"label":"D","text":"A single-displacement reaction"}]$op28$::jsonb,
    'C',
    $ex28$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the defining signature of a combustion reaction is a fuel reacting rapidly with molecular oxygen and releasing energy as heat and light, which is exactly what the described burning of octane in excess \(\text{O}_2\) represents. Combustion is the rapid oxidation of a substance, characteristically a hydrocarbon fuel combining with \(\text{O}_2\), accompanied by the release of heat and light; the description in the stem (a hydrocarbon fuel burning rapidly in excess oxygen, giving off heat and light) matches this category directly, so the reaction is classified as combustion. (Choice A) A combination (synthesis) reaction is one in which two or more simpler reactants join to form a single product, with no requirement that oxygen be a reactant or that heat and light be released, so it does not capture the rapid fuel-plus-oxygen energy release described here. (Choice B) A decomposition reaction is one in which a single compound breaks apart into two or more simpler substances, typically driven by added energy; the stem instead describes a fuel consuming a separate \(\text{O}_2\) reactant rather than one compound splitting on its own. (Choice D) A single-displacement reaction involves one element replacing another element within a compound, such as a free metal displacing a cation from solution; the described process involves a fuel reacting with elemental oxygen and releasing heat and light rather than one element substituting for another. Skill 1$ex28$,
    'medium', '4E', $cc28$Stoichiometry (GC)$cc28$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a28A$combination-synthesis-instead-of-combustion$a28A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a28B$decomposition-single-reactant-breakdown$a28B$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a28D$single-displacement-element-swap$a28D$ FROM q;

-- Q4 [Types of Reactions · medium · Skill 1 · 4E Stoichiometry (GC) · ans D] (g29)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt29$A strip of zinc metal is placed in aqueous copper(II) sulfate, and the balanced equation is \(\text{Zn(s)} + \text{CuSO}_4\text{(aq)} \rightarrow \text{ZnSO}_4\text{(aq)} + \text{Cu(s)}\). Into which reaction class does this equation fall?$qt29$,
    $op29$[{"label":"A","text":"Combination, because two reactants come together into the products."},{"label":"B","text":"Decomposition, because the copper(II) sulfate is broken apart over the course of the reaction."},{"label":"C","text":"Double-displacement, because the \\(\\text{Zn}\\) and \\(\\text{Cu}\\) exchange the \\(\\text{SO}_4^{2-}\\) partner between them."},{"label":"D","text":"Single-displacement, because the free element \\(\\text{Zn}\\) replaces \\(\\text{Cu}\\) in the compound and the displaced \\(\\text{Cu}\\) is set free as an element."}]$op29$::jsonb,
    'D',
    $ex29$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because a single-displacement (single-replacement) reaction has the general form \(\text{A} + \text{BC} \rightarrow \text{AC} + \text{B}\), in which one free element replaces another element within a compound. Here the free element \(\text{Zn(s)}\) takes the place of \(\text{Cu}\) bonded to \(\text{SO}_4^{2-}\), forming \(\text{ZnSO}_4\text{(aq)}\) and liberating \(\text{Cu(s)}\) as a free element. The diagnostic features are that exactly one of the reactants is an uncombined element and exactly one of the products is an uncombined element, with the polyatomic \(\text{SO}_4^{2-}\) carried intact from one metal to the other. (Choice A) Combination (synthesis) follows \(\text{A} + \text{B} \rightarrow \text{AB}\), producing a single product from two or more reactants; this equation yields two products, \(\text{ZnSO}_4\) and \(\text{Cu}\), rather than one combined product, so it is not a combination. (Choice B) Decomposition follows \(\text{AB} \rightarrow \text{A} + \text{B}\), a single reactant splitting into two or more products; this reaction begins with two reactants and the \(\text{SO}_4^{2-}\) group is never broken apart, so no decomposition occurs. (Choice C) Double-displacement requires two compounds, \(\text{AB} + \text{CD} \rightarrow \text{AD} + \text{CB}\), trading ions so that no free elements appear; here one reactant (\(\text{Zn}\)) and one product (\(\text{Cu}\)) are free uncombined elements, which is the signature of single- rather than double-displacement. Skill 1$ex29$,
    'medium', '4E', $cc29$Stoichiometry (GC)$cc29$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a29A$Reads two reactants forming products as a combination/synthesis, ignoring that a single combined product is required and that two products plus a free element are formed.$a29A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a29B$Invokes decomposition because copper(II) sulfate appears to be taken apart, applying a single-reactant-splits class to a two-reactant equation in which the sulfate group stays intact.$a29B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a29C$Confuses single- with double-displacement by treating a free-element-replaces-element swap as a two-compound ion exchange, overlooking that both a reactant and a product are uncombined elements.$a29C$ FROM q;

-- Q5 [Types of Reactions · medium · Skill 1 · 4E Stoichiometry (GC) · ans A] (g30)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt30$In aqueous solution, silver nitrate reacts with sodium chloride according to \(\text{AgNO}_3(aq) + \text{NaCl}(aq) \rightarrow \text{AgCl}(s) + \text{NaNO}_3(aq)\). This reaction is best classified as which type?$qt30$,
    $op30$[{"label":"A","text":"Double-displacement (metathesis) reaction"},{"label":"B","text":"Single-displacement reaction"},{"label":"C","text":"Combination (synthesis) reaction"},{"label":"D","text":"Decomposition reaction"}]$op30$::jsonb,
    'A',
    $ex30$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the two ionic compounds exchange partners: the \(\text{Ag}^+\) and \(\text{Na}^+\) cations swap their \(\text{NO}_3^-\) and \(\text{Cl}^-\) anions, and the insoluble \(\text{AgCl}(s)\) precipitates out of solution. A reaction in which two compounds trade ions to form two new compounds, of the general form \(\text{AB} + \text{CD} \rightarrow \text{AD} + \text{CB}\), is a double-displacement (metathesis) reaction; the formation of a precipitate marks it as the precipitation subtype. (Choice B) A single-displacement reaction has the form \(\text{A} + \text{BC} \rightarrow \text{AC} + \text{B}\), in which a free element displaces another element from a compound; here no free element appears on either side, so this label does not apply. (Choice C) A combination (synthesis) reaction joins two or more reactants into a single product, of the form \(\text{A} + \text{B} \rightarrow \text{AB}\); this equation yields two products rather than one. (Choice D) A decomposition reaction has a single reactant breaking into two or more products, of the form \(\text{AB} \rightarrow \text{A} + \text{B}\); this equation has two reactants rather than one. Skill 1: Knowledge of Scientific Concepts and Principles.$ex30$,
    'medium', '4E', $cc30$Stoichiometry (GC)$cc30$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'adjacent_fact', $a30B$Names a different valid reaction-type label (single-displacement) from the same taxonomy that does not match the given equation$a30B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a30C$Names a different valid reaction-type label (combination/synthesis) that does not match the two-product, partner-swapping equation$a30C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a30D$Names a different valid reaction-type label (decomposition) that requires a single reactant, contradicting the two reactants given$a30D$ FROM q;

-- Q6 [Types of Reactions · easy · Skill 1 · 4E Stoichiometry (GC) · ans B] (g31)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt31$The balanced equation \(\text{HBr}(aq) + \text{KOH}(aq) \rightarrow \text{KBr}(aq) + \text{H}_2\text{O}(l)\) combines an acid and a base to yield a dissolved salt plus water. The most specific reaction-type label for this process is$qt31$,
    $op31$[{"label":"A","text":"a combination (synthesis) reaction, because two reactants merge to form the products."},{"label":"B","text":"a neutralization reaction, a specific acid-base process in which an acid and a base produce a salt and water."},{"label":"C","text":"a single-displacement reaction, because one element replaces another within a compound."},{"label":"D","text":"a combustion reaction, because water is generated as one of the products."}]$op31$::jsonb,
    'B',
    $ex31$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the reactants are an acid \((\text{HBr})\) and a base \((\text{KOH})\), and the products are a salt \((\text{KBr})\) plus water \((\text{H}_2\text{O})\), which is the defining signature of a neutralization reaction. A neutralization reaction is a specific type of acid-base reaction in which an acid and a base (not water) react to give a salt and water; in \(\text{HBr}(aq) + \text{KOH}(aq) \rightarrow \text{KBr}(aq) + \text{H}_2\text{O}(l)\) an \(\text{H}^+\) from the acid combines with an \(\text{OH}^-\) from the base to form \(\text{H}_2\text{O}\), while the \(\text{K}^+\) and \(\text{Br}^-\) ions pair as the salt \(\text{KBr}\). Although the partner-swapping pattern also makes this a double-displacement reaction in the broadest sense, the acid-plus-base producing salt-plus-water makes neutralization the most specific and precise classification. (Choice A) A combination (synthesis) reaction produces a single product from two or more reactants, but this equation yields two products \((\text{KBr}\) and \(\text{H}_2\text{O})\), so it is not a combination reaction. (Choice C) A single-displacement reaction requires a free element to replace an element within a compound, yet no elemental species (such as a pure metal or diatomic element) appears among these reactants, which are all compounds. (Choice D) A combustion reaction requires a fuel reacting with \(\text{O}_2\) to release energy, and although water is a product here, there is no molecular oxygen reactant and no fuel being burned, so the presence of water alone does not make it combustion. Skill 1$ex31$,
    'easy', '4E', $cc31$Stoichiometry (GC)$cc31$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a31A$Labels a two-product reaction as a combination (synthesis), ignoring that synthesis yields a single product$a31A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a31C$Applies the single-displacement category despite no free element being present, confusing it with the displacement-style ion swap$a31C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a31D$Infers combustion solely from water as a product, ignoring the required O2 fuel-oxidation criteria$a31D$ FROM q;

-- Q7 [Types of Reactions · easy · Skill 2 · 4E Stoichiometry (GC) · ans C] (g32)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt32$Ethane, \(\text{C}_2\text{H}_6\), undergoes complete combustion in excess \(\text{O}_2\). What are the only products of this reaction?$qt32$,
    $op32$[{"label":"A","text":"\\(\\text{CO}\\) and \\(\\text{H}_2\\text{O}\\)"},{"label":"B","text":"\\(\\text{CO}_2\\) and \\(\\text{H}_2\\)"},{"label":"C","text":"\\(\\text{CO}_2\\) and \\(\\text{H}_2\\text{O}\\)"},{"label":"D","text":"\\(\\text{CO}_2\\) and \\(\\text{O}_2\\)"}]$op32$::jsonb,
    'C',
    $ex32$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the complete combustion of any hydrocarbon in excess oxygen converts every carbon atom to carbon dioxide and every hydrogen atom to water, leaving only \(\text{CO}_2\) and \(\text{H}_2\text{O}\) as products. The balanced equation is \(2\,\text{C}_2\text{H}_6 + 7\,\text{O}_2 \rightarrow 4\,\text{CO}_2 + 6\,\text{H}_2\text{O}\): the two carbons of ethane appear as \(\text{CO}_2\) and the six hydrogens appear as \(\text{H}_2\text{O}\), with the excess \(\text{O}_2\) supplying enough oxygen for the fully oxidized products. (Choice A) \(\text{CO}\) is the carbon product of incomplete combustion when oxygen is limited; in excess \(\text{O}_2\) the carbon is fully oxidized to \(\text{CO}_2\), so carbon monoxide is not formed. (Choice B) Hydrogen leaves combustion bonded to oxygen as \(\text{H}_2\text{O}\), not released as diatomic \(\text{H}_2\) gas, so \(\text{H}_2\) is not a combustion product. (Choice D) \(\text{O}_2\) is a reactant consumed during combustion, not a product; although excess \(\text{O}_2\) may remain unreacted, it is not a product generated by the reaction. Skill 2$ex32$,
    'easy', '4E', $cc32$Stoichiometry (GC)$cc32$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $a32A$incomplete combustion product (CO) substituted when O2 is actually in excess$a32A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a32B$hydrogen released as diatomic H2 instead of being oxidized to H2O$a32B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a32D$lists the O2 reactant as a product$a32D$ FROM q;

-- Q8 [Types of Reactions · medium · Skill 2 · 4E Stoichiometry (GC) · ans D] (g33)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt33$Aqueous \(\text{Pb(NO}_3)_2\) is combined with aqueous \(\text{KI}\), and a solid drops out of the otherwise clear mixture. Given that all nitrate salts and all group-1 (e.g. \(\text{K}^+\)) salts are soluble while most heavy-metal iodides are not, which species is the precipitate?$qt33$,
    $op33$[{"label":"A","text":"\\(\\text{KNO}_3\\), the salt formed from the spectator ions \\(\\text{K}^+\\) and \\(\\text{NO}_3^-\\)"},{"label":"B","text":"\\(\\text{PbK}\\), the salt formed when the two metal cations combine"},{"label":"C","text":"\\(\\text{KI}\\), an iodide salt that settles out once the solutions are mixed"},{"label":"D","text":"\\(\\text{PbI}_2\\), the insoluble salt of \\(\\text{Pb}^{2+}\\) paired with \\(\\text{I}^-\\)"}]$op33$::jsonb,
    'D',
    $ex33$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because in a double-displacement (metathesis) reaction the cations and anions swap partners, so \(\text{Pb}^{2+}\) pairs with \(\text{I}^-\) and \(\text{K}^+\) pairs with \(\text{NO}_3^-\); solubility rules then flag \(\text{PbI}_2\) as the insoluble product. Writing the swap, \(\text{Pb(NO}_3)_2(aq) + 2\,\text{KI}(aq) \rightarrow \text{PbI}_2(s) + 2\,\text{KNO}_3(aq)\). The two new combinations are \(\text{K}^+\) with \(\text{NO}_3^-\) and \(\text{Pb}^{2+}\) with \(\text{I}^-\); since all nitrates and all group-1 salts are soluble, \(\text{KNO}_3\) stays dissolved, leaving the heavy-metal iodide \(\text{PbI}_2\) (a charge-neutral \(2{+}/1{-}\) criss-cross) as the solid that precipitates. (Choice A) \(\text{KNO}_3\) is the correct partner swap for \(\text{K}^+\) and \(\text{NO}_3^-\), but it is the soluble spectator product, not the precipitate; this inverts which product the solubility rule marks as insoluble. (Choice B) \(\text{PbK}\) pairs the two cations together, which cannot form a salt because a stable ionic compound requires a cation bonded to an anion; in metathesis the cations exchange anions rather than combine with each other. (Choice C) \(\text{KI}\) is an iodide salt, but it is one of the starting reactants present as dissolved \(\text{K}^+\) and \(\text{I}^-\) ions and is soluble, so it cannot be the newly formed solid. Skill 2$ex33$,
    'medium', '4E', $cc33$Stoichiometry (GC)$cc33$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a33A$Identifies the correct spectator-ion product KNO3 but labels the soluble salt as the precipitate, inverting the solubility rule$a33A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a33B$Pairs the two cations (Pb and K) into a nonexistent salt, ignoring that ionic compounds require a cation paired with an anion$a33B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a33C$Selects an iodide salt that forms a solid, but names KI, which is a soluble dissolved reactant rather than the new product$a33C$ FROM q;

-- Q9 [Types of Reactions · hard · Skill 4 · 4E Stoichiometry (GC) · ans A] (g34)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt34$A blast furnace reduces iron ore by the reaction \(\text{Fe}_2\text{O}_3(s) + 3\,\text{CO}(g) \rightarrow 2\,\text{Fe}(s) + 3\,\text{CO}_2(g)\). Identify the oxidizing agent and the reducing agent in this reaction.$qt34$,
    $op34$[{"label":"A","text":"\\(\\text{Fe}_2\\text{O}_3\\) is the oxidizing agent and \\(\\text{CO}\\) is the reducing agent."},{"label":"B","text":"\\(\\text{CO}\\) is the oxidizing agent and \\(\\text{Fe}_2\\text{O}_3\\) is the reducing agent."},{"label":"C","text":"\\(\\text{Fe}\\) is the oxidizing agent and \\(\\text{CO}_2\\) is the reducing agent."},{"label":"D","text":"\\(\\text{O}_2\\) is the oxidizing agent and \\(\\text{C}\\) is the reducing agent."}]$op34$::jsonb,
    'A',
    $ex34$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the oxidizing agent is the species that is itself reduced (it gains electrons) and the reducing agent is the species that is itself oxidized (it loses electrons). Assigning oxidation numbers: in \(\text{Fe}_2\text{O}_3\), oxygen is \(-2\), so each Fe is \(+3\); in \(\text{CO}\), oxygen is \(-2\), so carbon is \(+2\); in the products, elemental \(\text{Fe}(s)\) is \(0\) and in \(\text{CO}_2\) carbon is \(+4\) (oxygen \(-2\)). Iron goes from \(+3\) in \(\text{Fe}_2\text{O}_3\) down to \(0\) in \(\text{Fe}\), so iron is reduced; the compound that supplies it, \(\text{Fe}_2\text{O}_3\), is therefore the oxidizing agent. Carbon goes from \(+2\) in \(\text{CO}\) up to \(+4\) in \(\text{CO}_2\), so carbon is oxidized; the compound that supplies it, \(\text{CO}\), is therefore the reducing agent. (Choice B) This reverses the roles: it labels \(\text{CO}\) (whose carbon is oxidized) as the oxidizing agent and \(\text{Fe}_2\text{O}_3\) (whose iron is reduced) as the reducing agent, which inverts the definitions. (Choice C) \(\text{Fe}\) and \(\text{CO}_2\) are the reduced and oxidized products, not the agents; the oxidizing and reducing agents are always identified among the reactants, the species present before electrons are transferred. (Choice D) \(\text{O}_2\) and free carbon \(\text{C}\) do not appear in this equation; oxygen remains combined throughout and stays at \(-2\), so it is neither oxidized nor reduced and cannot be the oxidizing agent. Skill 4$ex34$,
    'hard', '4E', $cc34$Stoichiometry (GC)$cc34$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a34B$Swaps oxidizing and reducing agent by inverting the definitions (calls the oxidized species the oxidizing agent)$a34B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a34C$Names the products (reduced/oxidized species) as the agents instead of the reactants$a34C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a34D$Assumes elemental O2 and free carbon are the agents, treating oxygen as the oxidizer when it never changes oxidation state$a34D$ FROM q;

-- Q10 [Types of Reactions · hard · Skill 3 · 4E Stoichiometry (GC) · ans B] (g35)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt35$Cold dilute hydroxide absorbs chlorine gas by the balanced reaction \(\text{Cl}_2(g) + 2\,\text{NaOH}(aq) \rightarrow \text{NaCl}(aq) + \text{NaOCl}(aq) + \text{H}_2\text{O}(l)\), where oxygen is \(-2\) and sodium is \(+1\) throughout. Considering only the chlorine atoms, what change in oxidation number occurs across this reaction?$qt35$,
    $op35$[{"label":"A","text":"Every chlorine atom is reduced from \\(0\\) in \\(\\text{Cl}_2\\) to \\(-1\\) in both \\(\\text{NaCl}\\) and \\(\\text{NaOCl}\\)."},{"label":"B","text":"One chlorine atom is oxidized from \\(0\\) to \\(+1\\) in \\(\\text{NaOCl}\\) while the other is reduced from \\(0\\) to \\(-1\\) in \\(\\text{NaCl}\\)."},{"label":"C","text":"One chlorine atom is reduced from \\(0\\) to \\(-1\\) in \\(\\text{NaOCl}\\) while the other is oxidized from \\(0\\) to \\(+1\\) in \\(\\text{NaCl}\\)."},{"label":"D","text":"Every chlorine atom is oxidized from \\(0\\) in \\(\\text{Cl}_2\\) to \\(+1\\) in both \\(\\text{NaCl}\\) and \\(\\text{NaOCl}\\)."}]$op35$::jsonb,
    'B',
    $ex35$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the two chlorine atoms that begin as elemental \(\text{Cl}_2\) (oxidation number \(0\)) end up in two different products with opposite oxidation-number changes. In \(\text{NaCl}\), \(\text{Na}\) is \(+1\), so \(\text{Cl}\) must be \(-1\): that atom is reduced (\(0 \rightarrow -1\), a gain of electrons). In \(\text{NaOCl}\), \(\text{Na}\) is \(+1\) and \(\text{O}\) is \(-2\), so to keep the neutral compound's oxidation numbers summing to zero, \((+1) + \text{Cl} + (-2) = 0\) gives \(\text{Cl} = +1\): that atom is oxidized (\(0 \rightarrow +1\), a loss of electrons). Because the same element (chlorine) is simultaneously oxidized and reduced, this is a disproportionation reaction, and \(\text{Cl}_2\) acts as both the oxidizing agent and the reducing agent. (Choice A) This treats both product chlorines as \(-1\), but the chlorine in \(\text{NaOCl}\) is bonded to \(-2\) oxygen, forcing it to \(+1\) rather than \(-1\); not both atoms are reduced. (Choice C) This assigns the correct \(+1\) and \(-1\) values but swaps which compound holds which atom, calling \(\text{NaOCl}\) the reduced \(-1\) species and \(\text{NaCl}\) the oxidized \(+1\) species, reversing the oxidation and reduction sites. (Choice D) This treats both product chlorines as \(+1\), but the chlorine in \(\text{NaCl}\) paired with \(+1\) sodium must be \(-1\); not both atoms are oxidized. Skill 3$ex35$,
    'hard', '4E', $cc35$Stoichiometry (GC)$cc35$, 'general-chemistry', 3, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $a35A$Sees the disproportionation product but assigns both product chlorines the reduced -1 state, ignoring the +1 forced by oxygen in hypochlorite$a35A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a35C$Correct magnitudes but swaps which product is oxidized vs reduced$a35C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a35D$Assumes both chlorines are oxidized, ignoring the -1 chlorine in NaCl paired with +1 sodium$a35D$ FROM q;

-- Q11 [Types of Reactions · hard · Skill 3 · 4E Stoichiometry (GC) · ans C] (g36)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Types of Reactions',
    $qt36$A strip of copper metal is submerged in aqueous \(\text{MgSO}_4\), and the activity series places \(\text{Mg}\) above \(\text{Cu}\) (Mg is the more readily oxidized metal). The predicted single-displacement outcome is$qt36$,
    $op36$[{"label":"A","text":"a reaction yielding \\(\\text{CuSO}_4\\) and \\(\\text{Mg}\\), as \\(\\text{Cu}\\) displaces \\(\\text{Mg}^{2+}\\) from solution: \\(\\text{Cu} + \\text{MgSO}_4 \\rightarrow \\text{CuSO}_4 + \\text{Mg}\\)."},{"label":"B","text":"a reaction in which \\(\\text{Cu}\\) plates onto the strip as the dissolved \\(\\text{Mg}^{2+}\\) is reduced to \\(\\text{Mg}\\) metal."},{"label":"C","text":"no reaction, because \\(\\text{Cu}\\) is less active than \\(\\text{Mg}\\) and cannot displace \\(\\text{Mg}^{2+}\\) from solution."},{"label":"D","text":"a reaction, because any free metal placed in a dissolved metal salt undergoes single displacement regardless of relative activity."}]$op36$::jsonb,
    'C',
    $ex36$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because a single-displacement reaction between a free metal and a dissolved metal cation proceeds only when the free metal is MORE active (more readily oxidized) than the cation it would displace, and copper is LESS active than magnesium. In \(\text{Cu} + \text{MgSO}_4\), the only displacement that could occur is \(\text{Cu}\) reducing \(\text{Mg}^{2+}\) to \(\text{Mg}\) metal while \(\text{Cu}\) is oxidized to \(\text{Cu}^{2+}\); but since \(\text{Mg}\) sits above \(\text{Cu}\) in the activity series, \(\text{Mg}^{2+}\) holds its electrons more tightly than \(\text{Cu}^{2+}\) would, so \(\text{Cu}\) cannot supply the electrons to reduce \(\text{Mg}^{2+}\). The reaction is non-spontaneous and no reaction is observed; the copper strip simply sits unchanged in the solution. (Choice A) This writes the displacement in the wrong direction, treating \(\text{Cu}\) as more active than \(\text{Mg}\); the activity ordering is reversed, since \(\text{Mg}\) is the metal above \(\text{Cu}\) and only \(\text{Mg}\) (not \(\text{Cu}\)) could drive a displacement here. (Choice B) Plating out \(\text{Mg}\) metal would require \(\text{Cu}\) to reduce \(\text{Mg}^{2+}\), which is exactly the non-spontaneous step the activity series forbids; this describes a real plating outcome but assigns it to the wrong, less-active metal. (Choice D) Single displacement is not automatic for every free-metal/metal-salt pairing; it requires the free metal to outrank the dissolved cation in activity, so the relative-activity comparison cannot be ignored. Skill 3$ex36$,
    'hard', '4E', $cc36$Stoichiometry (GC)$cc36$, 'general-chemistry', 3, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a36A$Writes the displacement with the activity ordering inverted, casting less-active Cu as the metal that displaces the more-active Mg2+$a36A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a36B$Describes a genuine plating/reduction outcome but assigns it to the wrong (less-active) metal, ignoring that Cu cannot reduce Mg2+$a36B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a36D$Treats single displacement as automatic for any free-metal/metal-salt pair, disregarding the relative-activity requirement$a36D$ FROM q;

-- Q12 [Balancing Equations (incl. redox) · easy · Skill 2 · 4E Stoichiometry (GC) · ans D] (g37)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt37$In the contact process for sulfuric acid manufacture, sulfur dioxide is oxidized to sulfur trioxide according to the skeleton equation \(\text{SO}_2 + \text{O}_2 \rightarrow \text{SO}_3\). Which set of coefficients, written in the order (\(\text{SO}_2\), \(\text{O}_2\), \(\text{SO}_3\)), balances this equation using the smallest whole numbers?$qt37$,
    $op37$[{"label":"A","text":"\\((1,\\ 1,\\ 1)\\)"},{"label":"B","text":"\\((2,\\ 2,\\ 2)\\)"},{"label":"C","text":"\\((1,\\ 1,\\ 2)\\)"},{"label":"D","text":"\\((2,\\ 1,\\ 2)\\)"}]$op37$::jsonb,
    'D',
    $ex37$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the set \((2,\ 1,\ 2)\) is the only one that conserves every atom using the smallest whole numbers. Writing \(2\,\text{SO}_2 + \text{O}_2 \rightarrow 2\,\text{SO}_3\) gives 2 S atoms on each side and oxygen of \((2\times2) + (1\times2) = 6\) on the left versus \(2\times3 = 6\) on the right, so both sulfur and oxygen balance. Because no smaller integer combination achieves this (dividing by a common factor is impossible), \((2,\ 1,\ 2)\) is the correct lowest-terms coefficient set. (Choice A) The set \((1,\ 1,\ 1)\) is simply the skeleton equation left unbalanced: it gives 4 O on the left but only 3 O on the right, so oxygen is not conserved. (Choice B) The set \((2,\ 2,\ 2)\) over-counts \(\text{O}_2\): it supplies \((2\times2)+(2\times2)=8\) O on the left against \(2\times3=6\) on the right, and it is also not in lowest terms because every coefficient shares a factor of 2. (Choice C) The set \((1,\ 1,\ 2)\) balances sulfur incorrectly and leaves oxygen unbalanced, giving 1 S and 4 O on the left versus 2 S and 6 O on the right. Skill 2$ex37$,
    'easy', '4E', $cc37$Stoichiometry (GC)$cc37$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a37A$Treats the skeleton (unbalanced) equation as already balanced because each formula appears once$a37A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a37B$Scales all coefficients uniformly without checking lowest terms, over-counting the diatomic O2$a37B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a37C$Balances the SO3 coefficient correctly but fails to balance sulfur and oxygen simultaneously$a37C$ FROM q;

-- Q13 [Balancing Equations (incl. redox) · medium · Skill 2 · 4E Stoichiometry (GC) · ans A] (g38)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt38$The complete combustion of butane is balanced with the smallest whole-number coefficients as \(a\,\text{C}_4\text{H}_{10} + b\,\text{O}_2 \rightarrow c\,\text{CO}_2 + d\,\text{H}_2\text{O}\), and the coefficient on butane is fixed at \(a = 2\). The coefficient \(b\) on \(\text{O}_2\) is:$qt38$,
    $op38$[{"label":"A","text":"\\(13\\)"},{"label":"B","text":"\\(8\\)"},{"label":"C","text":"\\(12\\)"},{"label":"D","text":"\\(7\\)"}]$op38$::jsonb,
    'A',
    $ex38$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because, with \(a = 2\) butane molecules, the carbon and hydrogen balances fix the products and the oxygen balance then requires \(13\,\text{O}_2\). Balance carbon first: \(2\,\text{C}_4\text{H}_{10}\) supplies \(2 \times 4 = 8\) carbon atoms, so \(c = 8\) gives \(8\,\text{CO}_2\). Balance hydrogen next: \(2 \times 10 = 20\) hydrogen atoms require \(d = 10\), giving \(10\,\text{H}_2\text{O}\). Now count oxygen on the product side: \(8\,\text{CO}_2\) carries \(8 \times 2 = 16\) oxygen atoms and \(10\,\text{H}_2\text{O}\) carries \(10 \times 1 = 10\) oxygen atoms, for \(16 + 10 = 26\) oxygen atoms total. Because each \(\text{O}_2\) provides 2 oxygen atoms, \(b = 26 / 2 = 13\). The balanced equation is \(2\,\text{C}_4\text{H}_{10} + 13\,\text{O}_2 \rightarrow 8\,\text{CO}_2 + 10\,\text{H}_2\text{O}\). (Choice B) \(8\) counts only the oxygen in the \(8\,\text{CO}_2\) (\(16\) atoms, \(8\,\text{O}_2\)) and omits the \(10\) oxygen atoms supplied to the \(10\,\text{H}_2\text{O}\). (Choice C) \(12\) results from using \(d = 8\) water molecules (mistakenly matching the \(\text{CO}_2\) coefficient) so that product oxygen is \(16 + 8 = 24\) atoms, \(=12\,\text{O}_2\), which leaves hydrogen unbalanced. (Choice D) \(7\) comes from balancing the undoubled equation \(\text{C}_4\text{H}_{10} + b\,\text{O}_2 \rightarrow 4\,\text{CO}_2 + 5\,\text{H}_2\text{O}\), which needs \(13/2 = 6.5\,\text{O}_2\), then rounding the fractional coefficient up to a whole number instead of doubling every coefficient. Skill 2$ex38$,
    'medium', '4E', $cc38$Stoichiometry (GC)$cc38$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a38B$Counts oxygen only from CO2 and omits the oxygen atoms in the H2O product$a38B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a38C$Sets the water coefficient equal to the CO2 coefficient (8 instead of 10), miscounting hydrogen and lowering the oxygen demand$a38C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a38D$Balances the undoubled equation to a fractional 13/2 O2 and rounds the fraction up rather than scaling all coefficients to whole numbers$a38D$ FROM q;

-- Q14 [Balancing Equations (incl. redox) · medium · Skill 2 · 4E Stoichiometry (GC) · ans B] (g39)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt39$Aluminum burns in oxygen to form aluminum oxide according to the unbalanced skeleton \(\text{Al} + \text{O}_2 \rightarrow \text{Al}_2\text{O}_3\). After the equation is balanced with the smallest whole-number coefficients, what is the sum of all of its coefficients?$qt39$,
    $op39$[{"label":"A","text":"\\(7\\)"},{"label":"B","text":"\\(9\\)"},{"label":"C","text":"\\(3\\)"},{"label":"D","text":"\\(6\\)"}]$op39$::jsonb,
    'B',
    $ex39$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the smallest whole-number balanced equation is \(4\,\text{Al} + 3\,\text{O}_2 \rightarrow 2\,\text{Al}_2\text{O}_3\), whose coefficients sum to \(4 + 3 + 2 = 9\). To balance, note that one formula unit of \(\text{Al}_2\text{O}_3\) contains \(2\) Al and \(3\) O atoms. Balancing oxygen first requires \(6\) O atoms on each side: \(3\,\text{O}_2\) supplies \(6\) O atoms and \(2\,\text{Al}_2\text{O}_3\) holds \(2 \times 3 = 6\) O atoms. The \(2\,\text{Al}_2\text{O}_3\) on the right then contains \(2 \times 2 = 4\) Al atoms, so the reactant side needs \(4\,\text{Al}\). The balanced equation \(4\,\text{Al} + 3\,\text{O}_2 \rightarrow 2\,\text{Al}_2\text{O}_3\) checks out (Al: \(4 = 4\); O: \(6 = 6\)) and uses the smallest integers, giving a coefficient sum of \(9\). (Choice A) A value of \(7\) results from balancing oxygen correctly to give \(3\,\text{O}_2 \rightarrow 2\,\text{Al}_2\text{O}_3\) but then failing to rebalance aluminum, leaving the equation as \(2\,\text{Al} + 3\,\text{O}_2 \rightarrow 2\,\text{Al}_2\text{O}_3\) and summing \(2 + 3 + 2 = 7\); this version has \(2\) Al on the left but \(4\) Al on the right, so it is not balanced. (Choice C) A value of \(3\) results from treating the unbalanced skeleton \(\text{Al} + \text{O}_2 \rightarrow \text{Al}_2\text{O}_3\) as already complete and summing its implied coefficients of \(1 + 1 + 1 = 3\); this leaves \(1\) Al and \(2\) O on the left against \(2\) Al and \(3\) O on the right. (Choice D) A value of \(6\) results from balancing the reactant oxygen to \(3\,\text{O}_2\) but leaving the product coefficient at \(1\), giving \(2\,\text{Al} + 3\,\text{O}_2 \rightarrow \text{Al}_2\text{O}_3\) and summing \(2 + 3 + 1 = 6\); this mismatches both Al and O across the arrow. Skill 2$ex39$,
    'medium', '4E', $cc39$Stoichiometry (GC)$cc39$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a39A$Balances oxygen to 3 O2 and 2 Al2O3 but forgets to rebalance aluminum, leaving Al at 2 and summing 2+3+2=7$a39A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a39C$Treats the unbalanced skeleton equation as complete and sums its implicit coefficients of 1+1+1=3$a39C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a39D$Sets O2 to 3 but leaves the product Al2O3 coefficient at 1, summing 2+3+1=6 with both elements still unbalanced$a39D$ FROM q;

-- Q15 [Balancing Equations (incl. redox) · medium · Skill 2 · 4E Stoichiometry (GC) · ans C] (g40)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt40$The complete combustion of ethanol proceeds as \(\text{C}_2\text{H}_5\text{OH} + \text{O}_2 \rightarrow \text{CO}_2 + \text{H}_2\text{O}\). Balanced to the smallest whole-number coefficients, the set of coefficients in the order \(\text{C}_2\text{H}_5\text{OH}\), \(\text{O}_2\), \(\text{CO}_2\), \(\text{H}_2\text{O}\) is which of the following?$qt40$,
    $op40$[{"label":"A","text":"\\(1,\\ 2,\\ 2,\\ 3\\)"},{"label":"B","text":"\\(2,\\ 6,\\ 4,\\ 6\\)"},{"label":"C","text":"\\(1,\\ 3,\\ 2,\\ 3\\)"},{"label":"D","text":"\\(1,\\ 3,\\ 2,\\ 6\\)"}]$op40$::jsonb,
    'C',
    $ex40$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because balancing \(\text{C}_2\text{H}_5\text{OH} + \text{O}_2 \rightarrow \text{CO}_2 + \text{H}_2\text{O}\) gives \(\text{C}_2\text{H}_5\text{OH} + 3\,\text{O}_2 \rightarrow 2\,\text{CO}_2 + 3\,\text{H}_2\text{O}\), i.e. coefficients \(1, 3, 2, 3\). Start with one ethanol molecule: it holds 2 C atoms, so \(2\,\text{CO}_2\) are needed (carbon balanced), and it holds 6 H atoms, so \(3\,\text{H}_2\text{O}\) are needed (hydrogen balanced). Now count oxygen on the right: \(2\,\text{CO}_2\) supplies \(2 \times 2 = 4\) O and \(3\,\text{H}_2\text{O}\) supplies \(3 \times 1 = 3\) O, for 7 O atoms total. On the left, ethanol already contributes 1 O atom, so the \(\text{O}_2\) must supply the remaining \(7 - 1 = 6\) O atoms, which requires \(6/2 = 3\) molecules of \(\text{O}_2\). The coefficients \(1, 3, 2, 3\) share no common factor, so they are already the smallest whole numbers. (Choice A) The set \(1, 2, 2, 3\) leaves oxygen unbalanced: the right side has \(2(2) + 3(1) = 7\) O atoms, but the left side provides only \(1 + 2(2) = 5\) O atoms, the error of failing to account for the oxygen atom already present in the ethanol when fixing the \(\text{O}_2\) coefficient. (Choice B) The set \(2, 6, 4, 6\) is a balanced equation but not in lowest terms; every coefficient is exactly twice the correct \(1, 3, 2, 3\), so dividing through by the common factor of 2 is required to reach the smallest whole numbers. (Choice D) The set \(1, 3, 2, 6\) doubles the water coefficient, giving \(6 \times 2 = 12\) H atoms on the right against only 6 H atoms in one ethanol, and also overcounts oxygen, the error of matching \(\text{H}_2\text{O}\) to the 6 hydrogen atoms as though each water molecule held a single H rather than two. Skill 2$ex40$,
    'medium', '4E', $cc40$Stoichiometry (GC)$cc40$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a40A$Sets the O2 coefficient from the right-side oxygen total without subtracting the one oxygen atom already contained in the ethanol molecule, leaving oxygen unbalanced at 1,2,2,3$a40A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a40B$Reaches a correctly balanced equation but fails to reduce to lowest whole-number terms, reporting 2,6,4,6 instead of dividing through by the common factor of 2$a40B$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a40D$Assigns the water coefficient equal to the 6 hydrogen atoms in ethanol, treating each H2O as carrying one hydrogen rather than two and yielding 1,3,2,6$a40D$ FROM q;

-- Q16 [Balancing Equations (incl. redox) · hard · Skill 4 · 4E Stoichiometry (GC) · ans D] (g41)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt41$In acidic solution, permanganate oxidizes iron(II) according to the unbalanced skeleton \(\text{MnO}_4^- + \text{Fe}^{2+} + \text{H}^+ \rightarrow \text{Mn}^{2+} + \text{Fe}^{3+} + \text{H}_2\text{O}\). Which set of coefficients conserves every element and the total charge on both sides?$qt41$,
    $op41$[{"label":"A","text":"\\(\\text{MnO}_4^- + \\text{Fe}^{2+} + 8\\,\\text{H}^+ \\rightarrow \\text{Mn}^{2+} + \\text{Fe}^{3+} + 4\\,\\text{H}_2\\text{O}\\)"},{"label":"B","text":"\\(\\text{MnO}_4^- + 5\\,\\text{Fe}^{2+} + 4\\,\\text{H}^+ \\rightarrow \\text{Mn}^{2+} + 5\\,\\text{Fe}^{3+} + 2\\,\\text{H}_2\\text{O}\\)"},{"label":"C","text":"\\(5\\,\\text{MnO}_4^- + \\text{Fe}^{2+} + 8\\,\\text{H}^+ \\rightarrow 5\\,\\text{Mn}^{2+} + \\text{Fe}^{3+} + 4\\,\\text{H}_2\\text{O}\\)"},{"label":"D","text":"\\(\\text{MnO}_4^- + 5\\,\\text{Fe}^{2+} + 8\\,\\text{H}^+ \\rightarrow \\text{Mn}^{2+} + 5\\,\\text{Fe}^{3+} + 4\\,\\text{H}_2\\text{O}\\)"}]$op41$::jsonb,
    'D',
    $ex41$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because only that coefficient set conserves Mn, Fe, O, and H while also balancing the total ionic charge, which is mandatory for a redox equation. Balancing the electron transfer fixes the iron coefficient: manganese is reduced from \(+7\) in \(\text{MnO}_4^-\) to \(+2\) in \(\text{Mn}^{2+}\), gaining 5 electrons, while each iron is oxidized from \(+2\) to \(+3\), losing 1 electron. To make electrons gained equal electrons lost, 5 \(\text{Fe}^{2+}\) are required per 1 \(\text{MnO}_4^-\). The four O atoms in \(\text{MnO}_4^-\) leave as water, so 4 \(\text{H}_2\text{O}\) appear on the right; balancing those 4 waters (8 H atoms) requires 8 \(\text{H}^+\) on the left. The result is \(\text{MnO}_4^- + 5\,\text{Fe}^{2+} + 8\,\text{H}^+ \rightarrow \text{Mn}^{2+} + 5\,\text{Fe}^{3+} + 4\,\text{H}_2\text{O}\). Atom check: Mn \(1=1\), Fe \(5=5\), O \(4=4\), H \(8=8\). Charge check: left \((-1) + 5(+2) + 8(+1) = +17\); right \((+2) + 5(+3) + 0 = +17\). Both atoms and charge balance, so D is correct. (Choice A) Using a 1:1 ratio of \(\text{MnO}_4^-\) to \(\text{Fe}^{2+}\) ignores that one permanganate accepts 5 electrons while one iron releases only 1; the atoms for Mn, O, and H balance, but iron and the overall charge do not (left \(+9\) versus right \(+5\)), because the 5-electron transfer was not matched. (Choice B) This keeps the correct 1:5 Mn-to-Fe ratio but supplies only 4 \(\text{H}^+\) and 2 \(\text{H}_2\text{O}\), accounting for just two of the four oxygen atoms in \(\text{MnO}_4^-\); oxygen is left unbalanced (4 versus 2) and the charge fails (left \(+13\) versus right \(+17\)) because the full set of 4 waters and 8 protons was not used. (Choice C) This places the factor of 5 on the manganese species instead of on iron, reversing which half-reaction is multiplied; doing so unbalances Mn and O (20 O on the left versus 4 on the right) and the charge (left \(+5\) versus right \(+13\)), since the 5:1 electron ratio belongs to \(\text{Fe}^{2+}\) relative to \(\text{MnO}_4^-\), not the other way around. Skill 4$ex41$,
    'hard', '4E', $cc41$Stoichiometry (GC)$cc41$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a41A$Matches MnO4- to Fe2+ in a 1:1 ratio, skipping the step of equalizing the 5-electron gain with the 1-electron loss per iron$a41A$ FROM q
UNION ALL SELECT id, 'B', 'scale_unit_error', $a41B$Correct redox ratio but undercounts H+ and H2O (4 and 2 instead of 8 and 4), balancing only half the oxygen from permanganate$a41B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a41C$Applies the factor of 5 to the manganese species instead of iron, inverting which half-reaction must be multiplied to balance electrons$a41C$ FROM q;

-- Q17 [Balancing Equations (incl. redox) · medium · Skill 2 · 4E Stoichiometry (GC) · ans A] (g42)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt42$Iron rusts according to the unbalanced equation \(\text{Fe} + \text{O}_2 \rightarrow \text{Fe}_2\text{O}_3\). Which coefficient set, written in the order \((\text{Fe},\ \text{O}_2,\ \text{Fe}_2\text{O}_3)\), balances this equation with the smallest whole numbers?$qt42$,
    $op42$[{"label":"A","text":"\\(4,\\ 3,\\ 2\\)"},{"label":"B","text":"\\(2,\\ 3,\\ 1\\)"},{"label":"C","text":"\\(2,\\ 3,\\ 2\\)"},{"label":"D","text":"\\(4,\\ 6,\\ 2\\)"}]$op42$::jsonb,
    'A',
    $ex42$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the set \((4,\ 3,\ 2)\) is the only one that conserves both elements in the smallest whole numbers: \(4\,\text{Fe} + 3\,\text{O}_2 \rightarrow 2\,\text{Fe}_2\text{O}_3\). Checking Fe: \(4\) atoms on the left equal \(2 \times 2 = 4\) atoms on the right. Checking O: \(3 \times 2 = 6\) atoms on the left equal \(2 \times 3 = 6\) atoms on the right. Because the product \(\text{Fe}_2\text{O}_3\) carries an even number of Fe (2) but an odd number of O (3), the oxygen count forces an even number of \(\text{Fe}_2\text{O}_3\) units; taking the smallest such coefficient, \(2\), fixes \(6\) O atoms, which requires \(3\,\text{O}_2\), and the \(4\) Fe atoms in \(2\,\text{Fe}_2\text{O}_3\) require \(4\,\text{Fe}\). (Choice B) The set \(2,\ 3,\ 1\) balances oxygen as \(6 = 1 \times 3 = 3\) only if the product oxygen count is misread, but with one \(\text{Fe}_2\text{O}_3\) the product holds just \(3\) O atoms against \(6\) on the left and only \(2\) Fe atoms against \(2\) on the left, so oxygen is unbalanced. (Choice C) The set \(2,\ 3,\ 2\) leaves Fe unbalanced: the left has \(2\) Fe while \(2\,\text{Fe}_2\text{O}_3\) has \(4\) Fe, so the iron coefficient was not scaled up to match the doubled product. (Choice D) The set \(4,\ 6,\ 2\) doubles the oxygen reactant coefficient, giving \(6 \times 2 = 12\) O atoms on the left against only \(6\) on the right, so oxygen is over-counted even though Fe balances. Skill 2$ex42$,
    'medium', '4E', $cc42$Stoichiometry (GC)$cc42$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a42B$Stops at one formula unit of product and fails to enforce an even count of Fe2O3 required by its odd oxygen subscript, leaving both elements unbalanced$a42B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a42C$Correctly doubles the product to 2 Fe2O3 to balance oxygen but forgets to rescale the Fe coefficient, so iron is left unbalanced$a42C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a42D$Doubles the O2 coefficient to match the 6 oxygen atoms in the product rather than dividing by the O2 subscript of 2, over-counting reactant oxygen$a42D$ FROM q;

-- Q18 [Balancing Equations (incl. redox) · easy · Skill 1 · 4E Stoichiometry (GC) · ans B] (g43)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt43$The combustion of propane is written as \(\text{C}_3\text{H}_8 + 5\,\text{O}_2 \rightarrow 3\,\text{CO}_2 + 4\,\text{H}_2\text{O}\), with 3 carbon, 8 hydrogen, and 10 oxygen atoms appearing on each side. Identify the physical principle that forces these atom counts to match across the arrow.$qt43$,
    $op43$[{"label":"A","text":"Energy released by the reaction must equal the energy absorbed, so the equation is balanced to conserve energy."},{"label":"B","text":"Atoms are neither created nor destroyed in a chemical reaction, so the number of each element must be equal on both sides."},{"label":"C","text":"The total electric charge on the reactant side must equal the total charge on the product side."},{"label":"D","text":"The total number of molecules on the reactant side must equal the total number of molecules on the product side."}]$op43$::jsonb,
    'B',
    $ex43$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because chemical equations must be balanced to honor the law of conservation of mass, which at the atomic level means atoms are neither created nor destroyed during a reaction — they are only rearranged. Consequently, every element must appear in equal numbers on the reactant and product sides. In \(\text{C}_3\text{H}_8 + 5\,\text{O}_2 \rightarrow 3\,\text{CO}_2 + 4\,\text{H}_2\text{O}\), the coefficients are chosen so that carbon (3 = 3), hydrogen (8 = 8), and oxygen (\(5\times2 = 10\) on the left; \(3\times2 + 4\times1 = 10\) on the right) each tally to the same count on both sides, which is exactly what conservation of atoms requires. (Choice A) Energy conservation is a real principle, but balancing coefficients track atom counts, not energy bookkeeping; combustion is exothermic and its energy is not made equal across the arrow. (Choice C) Equal charge on both sides is required only for net ionic equations involving ions; this equation contains neutral molecules, and charge balance is not what fixes the atom counts here. (Choice D) The number of molecules (or moles of molecules) is generally not conserved — here 6 reactant molecules become 7 product molecules — so molecule count is not the conserved quantity that drives balancing. Skill 1$ex43$,
    'easy', '4E', $cc43$Stoichiometry (GC)$cc43$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a43A$conflates conservation of energy with conservation of atoms/mass$a43A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a43C$applies charge-balance requirement to a neutral-molecule equation$a43C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a43D$assumes molecule/mole count is conserved rather than atom count$a43D$ FROM q;

-- Q19 [Balancing Equations (incl. redox) · medium · Skill 2 · 4E Stoichiometry (GC) · ans C] (g44)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt44$White phosphorus burns in oxygen to form tetraphosphorus decoxide by the unbalanced reaction \(\text{P}_4 + \text{O}_2 \rightarrow \text{P}_4\text{O}_{10}\). When this equation is balanced to the smallest whole-number coefficients, what coefficient stands in front of \(\text{O}_2\)?$qt44$,
    $op44$[{"label":"A","text":"\\(2\\)"},{"label":"B","text":"\\(10\\)"},{"label":"C","text":"\\(5\\)"},{"label":"D","text":"\\(20\\)"}]$op44$::jsonb,
    'C',
    $ex44$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because balancing phosphorus first fixes the other coefficients, and then the oxygen balance forces a coefficient of \(5\) on \(\text{O}_2\). One \(\text{P}_4\) supplies \(4\) phosphorus atoms and one \(\text{P}_4\text{O}_{10}\) contains \(4\) phosphorus atoms, so the coefficients on \(\text{P}_4\) and \(\text{P}_4\text{O}_{10}\) are each \(1\): \(\text{P}_4 + \text{O}_2 \rightarrow \text{P}_4\text{O}_{10}\). The single \(\text{P}_4\text{O}_{10}\) then requires \(10\) oxygen atoms on the right. Because \(\text{O}_2\) is diatomic and delivers \(2\) oxygen atoms per molecule, the number of \(\text{O}_2\) molecules needed is \(10 \div 2 = 5\). The balanced equation is \(\text{P}_4 + 5\,\text{O}_2 \rightarrow \text{P}_4\text{O}_{10}\), which is already in smallest whole-number form, so the coefficient on \(\text{O}_2\) is \(5\). (Choice A) A coefficient of \(2\) supplies only \(2 \times 2 = 4\) oxygen atoms, far short of the \(10\) required by one \(\text{P}_4\text{O}_{10}\), so the oxygen atoms do not balance. (Choice B) A coefficient of \(10\) treats the subscript \(10\) as if it were a count of \(\text{O}_2\) molecules, ignoring that each \(\text{O}_2\) provides two oxygen atoms; this supplies \(20\) oxygen atoms, twice the amount needed. (Choice D) A coefficient of \(20\) results from multiplying the \(10\) needed oxygen atoms by \(2\) instead of dividing by \(2\), inverting the diatomic correction and doubling the true coefficient. Skill 2$ex44$,
    'medium', '4E', $cc44$Stoichiometry (GC)$cc44$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a44A$Stops balancing after phosphorus and assigns O2 a small coefficient without matching the ten oxygen atoms in the product$a44A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a44B$Uses the product subscript 10 directly as the O2 coefficient, failing to halve it for the diatomic O2 molecule$a44B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a44D$Multiplies the ten required oxygen atoms by 2 instead of dividing by 2, inverting the diatomic-molecule correction$a44D$ FROM q;

-- Q20 [Balancing Equations (incl. redox) · medium · Skill 2 · 4E Stoichiometry (GC) · ans D] (g45)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt45$The neutralization \(\text{Ca(OH)}_2 + \text{HCl} \rightarrow \text{CaCl}_2 + \text{H}_2\text{O}\) is balanced to the smallest whole-number coefficients. What is the coefficient on \(\text{HCl}\)?$qt45$,
    $op45$[{"label":"A","text":"\\(1\\)"},{"label":"B","text":"\\(3\\)"},{"label":"C","text":"\\(4\\)"},{"label":"D","text":"\\(2\\)"}]$op45$::jsonb,
    'D',
    $ex45$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because balancing the chlorine atoms requires two \(\text{HCl}\) units to supply the two \(\text{Cl}\) atoms in one \(\text{CaCl}_2\). Begin with the metal: one \(\text{Ca(OH)}_2\) gives one \(\text{Ca}\), which fixes one \(\text{CaCl}_2\). That \(\text{CaCl}_2\) contains \(2\) \(\text{Cl}\), so \(2\,\text{HCl}\) are needed on the left. Now count hydrogen: \(\text{Ca(OH)}_2\) supplies \(2\) H and \(2\,\text{HCl}\) supplies \(2\) more, for \(4\) H total, requiring \(2\,\text{H}_2\text{O}\) (\(4\) H). Oxygen checks: \(\text{Ca(OH)}_2\) has \(2\) O and \(2\,\text{H}_2\text{O}\) has \(2\) O. The balanced equation is \(\text{Ca(OH)}_2 + 2\,\text{HCl} \rightarrow \text{CaCl}_2 + 2\,\text{H}_2\text{O}\), coefficients \(1, 2, 1, 2\), so the coefficient on \(\text{HCl}\) is \(2\). (Choice A) A coefficient of \(1\) leaves only one \(\text{Cl}\) on the left while \(\text{CaCl}_2\) requires two, so the chlorine atoms are not balanced. (Choice B) A coefficient of \(3\) supplies three \(\text{Cl}\) atoms and three H from \(\text{HCl}\), overshooting the two \(\text{Cl}\) demanded by \(\text{CaCl}_2\) and producing an odd, non-balancing hydrogen total. (Choice C) A coefficient of \(4\) corresponds to doubling the \(\text{HCl}\) needed, as if \(\text{Ca(OH)}_2\) released two \(\text{Cl}_2\)-worth of chloride or as if every H atom required its own \(\text{HCl}\); only two \(\text{Cl}\) atoms appear in the single \(\text{CaCl}_2\) product. Skill 2$ex45$,
    'medium', '4E', $cc45$Stoichiometry (GC)$cc45$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a45A$Stops after balancing calcium and leaves HCl at 1, ignoring that CaCl2 demands two Cl atoms$a45A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a45B$Matches HCl to the three non-calcium atoms or guesses an odd coefficient that fails the chlorine and hydrogen counts$a45B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a45C$Doubles the required HCl, treating the two hydroxide oxygens or all four hydrogens as each needing a separate HCl$a45C$ FROM q;

-- Q21 [Balancing Equations (incl. redox) · hard · Skill 2 · 4E Stoichiometry (GC) · ans A] (g46)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt46$Glucose undergoes complete combustion according to the unbalanced skeleton \(\text{C}_6\text{H}_{12}\text{O}_6 + \text{O}_2 \rightarrow \text{CO}_2 + \text{H}_2\text{O}\). After the equation is balanced with the smallest whole-number coefficients, the sum of all four coefficients equals which value?$qt46$,
    $op46$[{"label":"A","text":"\\(19\\)"},{"label":"B","text":"\\(22\\)"},{"label":"C","text":"\\(18\\)"},{"label":"D","text":"\\(25\\)"}]$op46$::jsonb,
    'A',
    $ex46$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the balanced equation is \(\text{C}_6\text{H}_{12}\text{O}_6 + 6\,\text{O}_2 \rightarrow 6\,\text{CO}_2 + 6\,\text{H}_2\text{O}\), whose coefficients sum to \(1 + 6 + 6 + 6 = 19\). Balance carbon first: the \(6\) carbon atoms in one \(\text{C}_6\text{H}_{12}\text{O}_6\) require \(6\,\text{CO}_2\). Next balance hydrogen: the \(12\) hydrogen atoms require \(6\,\text{H}_2\text{O}\) (since each water holds \(2\) H, \(12 \div 2 = 6\)). Finally balance oxygen by counting both sides: the product side now holds \((6 \times 2) + (6 \times 1) = 12 + 6 = 18\) oxygen atoms, while the reactant side already contributes the \(6\) oxygen atoms inside glucose, leaving \(18 - 6 = 12\) oxygen atoms to come from \(\text{O}_2\); \(12 \div 2 = 6\), so the coefficient on \(\text{O}_2\) is \(6\). The implied coefficient on \(\text{C}_6\text{H}_{12}\text{O}_6\) is \(1\), giving \(1 + 6 + 6 + 6 = 19\). (Choice B) A value of \(22\) results from balancing oxygen as if all \(18\) product oxygen atoms must be supplied by \(\text{O}_2\) (\(18 \div 2 = 9\)) while ignoring the \(6\) oxygen atoms already present within glucose, yielding the incorrect set \(1 + 9 + 6 + 6 = 22\). (Choice C) A value of \(18\) results from omitting the implied coefficient of \(1\) on \(\text{C}_6\text{H}_{12}\text{O}_6\) and summing only \(6 + 6 + 6\). (Choice D) A value of \(25\) results from assigning one water molecule to each of the \(12\) hydrogen atoms (\(12\,\text{H}_2\text{O}\) instead of \(6\)), an off-by-subscript error that ignores that each water already contains two hydrogen atoms, yielding \(1 + 6 + 6 + 12 = 25\). Skill 2$ex46$,
    'hard', '4E', $cc46$Stoichiometry (GC)$cc46$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a46B$balances oxygen by requiring O2 to supply all 18 product oxygen atoms (coefficient 9), ignoring the 6 oxygen atoms already inside glucose$a46B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a46C$omits the implied coefficient of 1 on glucose and sums only the three explicit coefficients 6+6+6$a46C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a46D$off-by-subscript: assigns one H2O per hydrogen atom (12 H2O) instead of dividing the 12 H atoms by the 2 hydrogens per water molecule$a46D$ FROM q;

-- Q22 [Balancing Equations (incl. redox) · hard · Skill 4 · 4E Stoichiometry (GC) · ans B] (g47)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Balancing Equations (incl. redox)',
    $qt47$In acidic solution, dichromate is reduced to \(\text{Cr}^{3+}\) by the half-reaction \(\text{Cr}_2\text{O}_7^{2-} + a\,\text{H}^+ + n\,e^- \rightarrow b\,\text{Cr}^{3+} + c\,\text{H}_2\text{O}\). Which set of coefficients makes both the atoms and the total charge balance on each side?$qt47$,
    $op47$[{"label":"A","text":"\\(a=14,\\ n=6,\\ b=2,\\ c=7\\), with left-side charge \\(+8\\)"},{"label":"B","text":"\\(a=14,\\ n=6,\\ b=2,\\ c=7\\), with left-side charge \\(+6\\)"},{"label":"C","text":"\\(a=14,\\ n=12,\\ b=2,\\ c=7\\), with left-side charge \\(+6\\)"},{"label":"D","text":"\\(a=7,\\ n=6,\\ b=2,\\ c=7\\), with left-side charge \\(-1\\)"}]$op47$::jsonb,
    'B',
    $ex47$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because only that set conserves every atom and gives equal net charge on both sides. Balance atoms first: the two \(\text{Cr}\) require \(b=2\); the seven \(\text{O}\) in \(\text{Cr}_2\text{O}_7^{2-}\) must leave as water, so \(c=7\); those 7 waters carry \(14\) \(\text{H}\), so \(a=14\). Now balance charge. The right side is \(2(+3) + 7(0) = +6\). The left side, before electrons, is \((-2) + 14(+1) = +12\); to bring \(+12\) down to \(+6\) you add \(6\) electrons (\(6\) units of negative charge), so \(n=6\) and the left-side charge after the electrons is \((-2) + 14(+1) + 6(-1) = +6\), matching the right side. Atoms: \(\text{Cr}\) \(2=2\), \(\text{O}\) \(7=7\), \(\text{H}\) \(14=14\); charge \(+6=+6\). (Choice A) The coefficients are correct, but the stated left-side charge of \(+8\) omits the \(6\) electrons from the tally, computing only \((-2)+14(+1)=+12\) and then mis-adding, so the charge does not actually match the \(+6\) right side. (Choice C) Using \(n=12\) electrons drives the left-side charge to \((-2)+14-12=0\), which no longer equals the \(+6\) right side; the electron count must equal the \(6\)-unit drop in oxidation state for the two \(\text{Cr}\) atoms going from \(+6\) to \(+3\), not double it. (Choice D) Setting \(a=7\) leaves only \(7\) \(\text{H}^+\) to form \(7\) \(\text{H}_2\text{O}\), which would require \(14\) \(\text{H}\), so hydrogen is unbalanced, and the left-side charge \((-2)+7(+1)+6(-1)=-1\) does not match the \(+6\) right side. Skill 4$ex47$,
    'hard', '4E', $cc47$Stoichiometry (GC)$cc47$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a47A$electrons omitted from charge tally$a47A$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a47C$electron count doubled relative to oxidation-state change$a47C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a47D$H+ coefficient set to water count instead of hydrogen count$a47D$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch2_questions FROM questions WHERE topic='Compounds & Stoichiometry' AND subtopic IN ('Types of Reactions', 'Balancing Equations (incl. redox)');
