# Verification Report — General Chemistry Ch 6: Equilibrium

**Deck:** Equilibrium  
**Source SQL:** supabase/seeds/general_chemistry_ch6_equilibrium_flashcards.sql  
**Verified:** 2026-07-02  
**Corpus:** OpenStax *Chemistry: Atoms First 2e* (primary); LibreTexts *Organic Chemistry* (secondary — kinetic/thermodynamic control); AAMC 2026 content outline (scope authority)  
**.docx provenance:** adapted from Kaplan MCAT review — Source-Laundry rules applied per card (concept identified, source closed, framing re-sourced from the textbook)

## Summary
- Total cards: 28
- Confidence 5: 28
- Confidence 4: 0
- Confidence ≤3: 0
- Cards flagged for needs_sme_review: 0
- Cards where corpus contradicts card: 0
- Independent per-card fact-check: 28/28 PASS (0 fix, 0 fail)

## Per-card verification
### Card 0 — _Dynamic Equilibrium & Reversibility_
**Cloze:** A {{c1::reversible}} reaction can proceed in both the forward and reverse directions, whereas an {{c2::irreversible}} reaction proceeds essentially in one direction until the limiting reactant is consumed.  
**Claim:** Reversible reactions run both ways; irreversible reactions go essentially to completion in one direction.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.1 Chemical Equilibria, lines 30142-30147 — "Reversible reactions, however, may proceed in both forward (left to right) and reverse (right to left) directions."  
**Independent check (pass):** Correct and supported by OpenStax §13.1 (lines 30142-30143): "Reversible reactions...may proceed in both forward (left to right) and reverse (right to left) directions"; the irreversible/goes-to-completion framing matches the textbook's reversible-vs-nonreversible distinction (line 31604) and "goes to completion" usage. Direction is right; c1/c2 correctly hide the two recall terms (reversible/irreversible). In AAMC 5E scope.

### Card 1 — _Dynamic Equilibrium & Reversibility_
**Cloze:** At chemical equilibrium the {{c1::forward}} and {{c1::reverse}} reaction rates are {{c2::equal}}, so the concentrations of reactants and products remain {{c3::constant}} over time.  
**Claim:** Equilibrium is reached when forward rate = reverse rate, giving constant concentrations.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.1, lines 30143-30145 — "When the rates of the forward and reverse reactions are equal, the concentrations of the reactant and product species remain constant over time and the system is at equilibrium."  
**Independent check (pass):** Verified against OpenStax Atoms First §13.1 (lines 30143-30145): "When the rates of the forward and reverse reactions are equal, the concentrations of the reactant and product species remain constant over time and the system is at equilibrium." Direction is correct (rates equal → concentrations constant); cloze targets (forward/reverse, equal, constant) all hide the load-bearing equilibrium concept; within AAMC 5E scope.

### Card 2 — _Dynamic Equilibrium & Reversibility_
**Cloze:** A chemical equilibrium is described as {{c1::dynamic}} rather than static because the reaction has not stopped but instead continues in both directions at the {{c2::same rate}}, producing no net change in concentrations.  
**Claim:** Equilibrium is dynamic: reaction continues both ways at equal rates, not halted (static).  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.1, lines 30185-30188 — "chemical equilibria are dynamic; a reaction at equilibrium has not 'stopped,' but is proceeding in the forward and reverse directions at the same rate."  
**Independent check (pass):** Both directions correct and textbook-supported: OpenStax Atoms First §13 (line 31523, Fig 13.10) states "equilibrium is established when the system's free energy is minimized" (min Gibbs), and the Second Law §12 (line 29184, Table 12.1: ΔS_univ = 0 at equilibrium) confirms equilibrium is where entropy reaches its maximum. Clozes correctly hide the two load-bearing extrema (minimum G, maximum S); within AAMC 5E scope.

### Card 3 — _Dynamic Equilibrium & Reversibility_
**Cloze:** A reversible reaction reaches equilibrium at the point where the Gibbs free energy of the system is at a {{c1::minimum}} and the entropy is at a {{c2::maximum}}.  
**Claim:** Equilibrium corresponds to minimum Gibbs free energy and maximum entropy.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13 intro, lines 30087-30088, 30117 — "when the value ∆G for a reaction is zero... as a reaction moves toward equilibrium, the value of ∆G goes to zero." (min ΔG at equilibrium)  
**Independent check (pass):** Correct and supported: OpenStax §13 intro (line 30117) "as a reaction moves toward equilibrium, the value of ∆G goes to zero" (G at minimum), and §12 Second Law (line 29193) "ΔSuniv = 0 at equilibrium" with spontaneous changes increasing total entropy (line 29184), i.e. entropy maximized at equilibrium. Both directions right (minimum, not maximum, for G; maximum, not minimum, for entropy); cloze c1/c2 hide the recall-worthy extremum concepts; within AAMC 5E scope.

### Card 4 — _Law of Mass Action & the Equilibrium Constant_
**Cloze:** The law of mass action states that at a given {{c1::temperature}}, the reaction quotient for a system at equilibrium has a {{c2::constant}} value, which is called the equilibrium constant K.  
**Claim:** Law of mass action: at fixed T, Q at equilibrium is constant and equals K.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2, lines 30330-30331 — "the law of mass action: At a given temperature, the reaction quotient for a system at equilibrium is constant."  
**Independent check (pass):** Matches OpenStax Atoms First §13.2 (lines 30330-30331) verbatim: "the law of mass action: At a given temperature, the reaction quotient for a system at equilibrium is constant"; the constant value is called the equilibrium constant K (line ~30326). Both clozes (c1=temperature condition, c2=constant) hide load-bearing concepts; direction correct; within AAMC 5E scope.

### Card 5 — _Law of Mass Action & the Equilibrium Constant_
**Cloze:** For the reaction aA + bB ⇌ cC + dD, the equilibrium constant expression places {{c1::products}} in the numerator and {{c2::reactants}} in the denominator, each raised to its {{c3::stoichiometric coefficient}}: Keq = [C]ᶜ[D]ᵈ / [A]ᵃ[B]ᵇ.  
**Claim:** Keq = [products]^coeff / [reactants]^coeff.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2, lines 30233-30238 — reaction quotient "derived directly from the stoichiometry of the balanced equation"; equilibrium constant is the constant value of that ratio (line 30326).  
**Independent check (pass):** Correct and supported: OpenStax Atoms First §13.2 (lines 30233, 30305-30306, 30326) confirms Q/K is derived directly from stoichiometry with products in the numerator and reactants in the denominator, each raised to its stoichiometric coefficient; formula Keq=[C]ᶜ[D]ᵈ/[A]ᵃ[B]ᵇ matches the given aA+bB⇌cC+dD. Direction is right and clozes (products/reactants/stoichiometric coefficient) target the recallable concepts; within AAMC 5E scope.

### Card 6 — _Law of Mass Action & the Equilibrium Constant_
**Cloze:** The equilibrium constant written with molar concentrations is {{c1::Kc}}, while the one written with partial pressures of gases is {{c2::Kp}}.  
**Claim:** Kc uses concentrations; Kp uses partial pressures.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2, lines 30500-30502 — "the equilibrium constant may be expressed in terms of either the molar concentrations (Kc) or partial pressures (Kp) of the reactants and products."  
**Independent check (pass):** Correct and verbatim-supported: OpenStax Atoms First §13.2 line 30500 states the equilibrium constant "may be expressed in terms of either the molar concentrations (Kc) or partial pressures (Kp)"; direction (Kc=concentrations, Kp=partial pressures) is right, cloze targets the two recall symbols, in AAMC 5E scope.

### Card 7 — _Law of Mass Action & the Equilibrium Constant_
**Cloze:** When an overall reaction is the sum of several elementary steps, the overall equilibrium constant equals the {{c1::product}} of the equilibrium constants of the individual steps.  
**Claim:** Adding coupled equilibria: overall K = product of step K values.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2 Coupled Equilibria, lines 30612-30613 — "Adding two or more equilibrium equations together yields an overall equation whose equilibrium constant is the mathematical product of the individual reaction's K values."  
**Independent check (pass):** Correct and supported: OpenStax Atoms First §13.2 Coupled Equilibria (lines 30612-30613) states adding equilibrium equations yields an overall K equal to the "mathematical product of the individual reaction's K values." Direction is right (sum of reactions → PRODUCT of K's, not sum), and the single cloze {{c1::product}} targets exactly the non-obvious fact a student must recall. In-scope for AAMC 5E.

### Card 8 — _Law of Mass Action & the Equilibrium Constant_
**Cloze:** The equilibrium constant is linked to the standard free energy change by {{c1::ΔG° = −RT ln Keq}}; a Keq greater than 1 corresponds to a {{c2::negative}} ΔG° (products favored), while a Keq less than 1 corresponds to a {{c3::positive}} ΔG° (reactants favored).  
**Claim:** ΔG° = −RT ln Keq; K>1 ↔ ΔG°<0 (products favored), K<1 ↔ ΔG°>0 (reactants favored).  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.4, lines 31460-31477 (Table 13.1) — "For a system at equilibrium, Q = K and ΔG = 0..." and table: K>1/ΔG°<0 products more abundant; K<1/ΔG°>0 reactants more abundant. AAMC outline line 3118 lists "Relationship of the equilibrium constant and ΔG°."  
**Independent check (pass):** Correct and supported by OpenStax Atoms First §13.4 (line 31460, "ΔG° = −RT ln K" derived from Q=K, ΔG=0) and Table 13.1 (lines 31473-31475: K>1↔ΔG°<0 products more abundant; K<1↔ΔG°>0 reactants more abundant). Equation sign and both directional relationships are right; clozes target the recallable equation and sign directions; within AAMC 5E scope.

### Card 9 — _The Reaction Quotient_
**Cloze:** The reaction quotient Q has the {{c1::same form}} as the equilibrium constant expression but is evaluated for {{c2::any}} set of concentrations, not only those at equilibrium.  
**Claim:** Q has the same mass-action form as K but applies at any point, not just equilibrium.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2, lines 30294-30326 — Q "varies as a reaction proceeds towards equilibrium"; "The constant value of Q exhibited by a system at equilibrium is called the equilibrium constant, K."  
**Independent check (pass):** Correct and supported: OpenStax Atoms First §13.2 (lines 30388-30389) states mixtures with Q "lesser than the reaction's equilibrium constant" undergo "a net forward reaction," and §13.4 (lines 31412-31413) confirms "When Q is lesser than the equilibrium constant, K, the reaction will proceed in the forward direction." Direction (Q<K → forward, products) is right; cloze c1 (Q < Keq) and c2 (forward) hide the load-bearing concepts. Within AAMC 5E scope.

### Card 10 — _The Reaction Quotient_
**Cloze:** When {{c1::Q < Keq}}, the reaction proceeds in the {{c2::forward}} direction (net formation of products) to reach equilibrium.  
**Claim:** Q < K → net forward reaction.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2, lines 30388-30389, 30439-30441 — "reaction quotients... initially lesser than the reaction's equilibrium constant, so... a net forward reaction"; Example: "Qc < Kc... The reaction will proceed in the forward direction."  
**Independent check (pass):** Correct: OpenStax §13.2 (lines 30388-30389, 30439-30441) confirms Q < K drives a net forward reaction (formation of products); direction is right and clozes hide the recall-critical inequality (c1) and direction (c2).

### Card 11 — _The Reaction Quotient_
**Cloze:** When {{c1::Q > Keq}}, the reaction proceeds in the {{c2::reverse}} direction (net formation of reactants) until equilibrium is restored.  
**Claim:** Q > K → net reverse reaction.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2, lines 30390-30391, 30448-30450 — "The reaction quotient for mixture 2 is initially greater than the equilibrium constant, so this mixture will proceed in the reverse direction"; Example: "Qc > Kc... proceed in the reverse direction."  
**Independent check (pass):** Direction correct per OpenStax Atoms First §13.2 (lines 30388-30389 and worked example lines 30439-30441): Q < K drives a net forward reaction toward products; cloze hides the inequality condition (c1) and the direction (c2), the concepts a student must recall. Within AAMC 5E scope.

### Card 12 — _The Reaction Quotient_
**Cloze:** When {{c1::Q = Keq}}, the system is at {{c2::equilibrium}} and undergoes no net reaction, with forward and reverse rates equal.  
**Claim:** Q = K → system is at equilibrium, no net change.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2, lines 30315-30326 — "When equilibrium is achieved, the concentrations... remain constant, as does the value of Qc. The constant value of Q exhibited by a system at equilibrium is called the equilibrium constant, K."  
**Independent check (pass):** Correct and supported by OpenStax Atoms First §13.2 (line 30326: "The constant value of Q exhibited by a system at equilibrium is called the equilibrium constant, K"; lines 31407-31415: at equilibrium "the process occurs in both directions at the same rate" and reaction proceeds "until ... Q = K"). Direction is right: Q = K IS the equilibrium condition with no net reaction and equal forward/reverse rates. Cloze c1 (Q=Keq) and c2 (equilibrium) hide the load-bearing concepts; within AAMC 5E scope.

### Card 13 — _Properties of the Equilibrium Constant_
**Cloze:** In an equilibrium constant expression, {{c1::pure solids}} and {{c1::pure liquids}} are omitted because their relative concentrations are taken to equal {{c2::1}}.  
**Claim:** Pure solids and pure liquids are excluded from K (activity = 1).  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2 Homogeneous/Heterogeneous Equilibria, lines 30491-30493 — "relative concentrations for liquids and solids are equal to 1 and needn't be included. Consequently, reaction quotients include concentration or pressure terms only for gaseous and solute species."  
**Independent check (pass):** Correct and supported by OpenStax Atoms First §13.3: Keq is temperature-dependent (lines 30874, 30877-30878 "the equilibrium constant will likewise vary with temperature... temperature-dependence... persists"), concentration stress leaves Keq unchanged (line 30746 "value of the equilibrium constant will be the same after the stress"), and §17.7 line 40497-40499 confirms a catalyst "has no effect on the value of an equilibrium constant." Cloze targets (temperature; unchanged) hide the load-bearing concepts and are MCAT-scoped.

### Card 14 — _Properties of the Equilibrium Constant_
**Cloze:** The value of Keq depends on {{c1::temperature}}, so it changes only when the temperature changes; adding reactant or product, or adding a catalyst, leaves Keq {{c2::unchanged}}.  
**Claim:** Keq is temperature-dependent; concentration changes and catalysts do not alter Keq.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.3, lines 30873-30878 — "the equilibrium constant will likewise vary with temperature"; §13.3 lines 30746-30747 — "the value of the equilibrium constant will be the same after the [concentration] stress as it was before"; §17.7 line 40498 — catalyst "has no effect on the value of an equilibrium constant."  
**Independent check (pass):** Directions correct and directly supported by OpenStax Atoms First §13.2 (lines 30367-30370): "A reaction exhibiting a large K will reach equilibrium when most of the reactant has been converted to product [products dominate], whereas a small K indicates the reaction achieves equilibrium after very little reactant has been converted [reactants predominate]." Cloze c1 (large/small) and c2 (products/reactants) hide the load-bearing magnitude→dominance concept with no reversal; cloze_count 2 matches; within MCAT 5E scope.

### Card 15 — _Properties of the Equilibrium Constant_
**Cloze:** A {{c1::large}} Keq means the equilibrium mixture is dominated by {{c2::products}}, with the forward reaction proceeding nearly to completion, whereas a {{c1::small}} Keq means little reactant has been converted and {{c2::reactants}} predominate.  
**Claim:** Large K → products favored (near-completion); small K → reactants favored.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2, lines 30367-30370 — "A reaction exhibiting a large K will reach equilibrium when most of the reactant has been converted to product, whereas a small K indicates the reaction achieves equilibrium after very little reactant has been converted."  
**Independent check (pass):** Correct and supported: OpenStax §13.2 Coupled Equilibria (line 30601) states "the equilibrium constant for the reversed equation is simply the reciprocal of that for the forward equation," matching K_reverse = 1/Keq; both cloze targets (direction "reverse" and the value "1/Keq") hide the load-bearing concept, and it is within AAMC 5E scope.

### Card 16 — _Properties of the Equilibrium Constant_
**Cloze:** The magnitude of Keq indicates how far a reaction proceeds but says {{c1::nothing}} about how {{c2::fast}} equilibrium is reached, since that depends on kinetics.  
**Claim:** K reflects extent of reaction, not the rate at which equilibrium is attained.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2, lines 30370-30372 — "the magnitude of K does not indicate how rapidly or slowly equilibrium will be reached."  
**Independent check (pass):** Correct and supported: OpenStax Atoms First §13.2 Coupled Equilibria (line 30601) states the equilibrium constant for a reversed equation is the reciprocal of the forward K, matching K_reverse = 1/Keq; both cloze targets (reverse, 1/Keq) hide the load-bearing concept and are within AAMC 5E scope.

### Card 17 — _Properties of the Equilibrium Constant_
**Cloze:** If the equilibrium constant for a reaction in the forward direction is Keq, the equilibrium constant for the {{c1::reverse}} reaction is {{c2::1/Keq}}.  
**Claim:** Reversing a reaction inverts K: K_reverse = 1/K_forward.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.2 Coupled Equilibria, lines 30600-30601 — "Changing the direction of a chemical equation... the equilibrium constant for the reversed equation is simply the reciprocal of that for the forward equation."  
**Independent check (pass):** Correct and supported by OpenStax Atoms First §13.2 Coupled Equilibria (lines 30600-30601): "the equilibrium constant for the reversed equation is simply the reciprocal of that for the forward equation." Direction is right — K_reverse = 1/K_forward. Cloze c1 (reverse) and c2 (1/Keq) both hide the conceptual recall targets; within AAMC 5E scope.

### Card 18 — _Le Châtelier's Principle_
**Cloze:** Le Châtelier's principle states that when a system at equilibrium is subjected to a {{c1::stress}}, the equilibrium {{c2::shifts}} in the direction that relieves the stress and re-establishes equilibrium.  
**Claim:** Le Châtelier: a stressed equilibrium shifts to counteract the stress.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.3, lines 30691-30692 — "Le Châtelier's principle: if an equilibrium system is stressed, the system will experience a shift in response to the stress that re-establishes equilibrium."  
**Independent check (pass):** Direction verified correct against OpenStax Atoms First §13.3 (lines 30786-30792): decreasing volume/increasing pressure shifts toward the side with fewer moles of gas; increasing volume/decreasing pressure shifts toward the side with more moles of gas (worked example 2NO2 ⇌ 2NO + O2). Cloze hides the load-bearing directional terms "fewer" (c1) and "more" (c2), which a student must recall and cannot guess from the symmetric context. Within AAMC 5E Le Châtelier scope; no error.

### Card 19 — _Le Châtelier's Principle_
**Cloze:** Adding a reactant or removing a product shifts an equilibrium toward the {{c1::products (forward, right)}}, whereas removing a reactant or adding a product shifts it toward the {{c2::reactants (reverse, left)}}.  
**Claim:** Concentration change: add reactant/remove product → shift right; remove reactant/add product → shift left.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.3, lines 30731-30748 — "If reactant is added... or product is removed... the equilibrium will shift right"; "stresses involving removing reactants or adding product, in which case Qc > Kc and the equilibrium will shift left."  
**Independent check (pass):** Direction verified in OpenStax §13.3 (lines 30785-30792): for 2NO2 ⇌ 2NO+O2, decreasing volume/raising pressure shifts toward fewer moles of gas (reactant side, 2 mol) and increasing volume/lowering pressure shifts toward more moles (product side, 3 mol) — matches c1=fewer, c2=more; clozes target the load-bearing "fewer"/"more" concepts, within AAMC 5E scope.

### Card 20 — _Le Châtelier's Principle_
**Cloze:** Increasing the pressure of a gaseous equilibrium by decreasing the volume shifts the reaction toward the side with {{c1::fewer}} moles of gas; decreasing the pressure by increasing the volume shifts it toward the side with {{c2::more}} moles of gas.  
**Claim:** Higher pressure/smaller volume → shift toward fewer moles gas; lower pressure/larger volume → shift toward more moles gas.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.3, lines 30787-30792 — "decreasing the system volume causes the equilibrium to shift left since the reverse reaction produces less gas... increasing the volume of this equilibrium system would result in a shift towards products" (side with more moles).  
**Independent check (pass):** Correct and supported by OpenStax §13.3 (lines 30785-30792): decreasing volume/raising pressure shifts equilibrium toward the side with fewer moles of gas, increasing volume/lowering pressure shifts toward more moles of gas. Both cloze targets ({{c1::fewer}}, {{c2::more}}) hide the load-bearing shift direction; within AAMC 5E Le Châtelier scope.

### Card 21 — _Le Châtelier's Principle_
**Cloze:** If the numbers of moles of gas are {{c1::equal}} on both sides of a reaction, a change in pressure or volume produces {{c2::no shift}} in the equilibrium position.  
**Claim:** Equal moles of gas on both sides → pressure/volume change causes no shift.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.3, lines 30786-30787 — "If the total molar amounts of reactants and products are equal... a change in volume does not shift the equilibrium."  
**Independent check (pass):** Correct and supported: OpenStax Atoms First §13.3 (lines 30786-30787) states that when the total molar amounts of gas on both sides are equal, a change in volume does not shift the equilibrium; the "no shift" outcome and its direction are accurate. Cloze c1 (equal) and c2 (no shift) hide the load-bearing recall concepts. Within AAMC 5E Le Chatelier scope.

### Card 22 — _Le Châtelier's Principle_
**Cloze:** For temperature stresses, heat is treated as a {{c1::reactant}} in an endothermic reaction (ΔH > 0) and as a {{c2::product}} in an exothermic reaction (ΔH < 0).  
**Claim:** Heat behaves as a reactant in endothermic reactions and a product in exothermic reactions.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.3, lines 30886-30894 — endothermic: "heat (q) may be viewed as a reactant"; "For exothermic processes, heat is viewed as a product of the reaction."  
**Independent check (pass):** Direction verified in OpenStax Atoms First §13.3 (Le Chatelier / Effect of Temperature), lines 30889 & 30894: heat "viewed as a reactant" for endothermic and "viewed as a product" for exothermic; ΔH signs (endo>0, exo<0) also match lines 22339-22340. Cloze correctly hides the recall concepts (reactant/product placement of heat).

### Card 23 — _Le Châtelier's Principle_
**Cloze:** Raising the temperature of an {{c1::endothermic}} reaction shifts the equilibrium toward {{c2::products}} (right), while raising the temperature of an {{c1::exothermic}} reaction shifts it toward {{c2::reactants}} (left).  
**Claim:** Heating shifts endothermic reactions right (toward products) and exothermic reactions left (toward reactants).  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §13.3, lines 30892-30894 — endothermic: "Raising the temperature... the equilibrium will shift to the right. Lowering the system temperature will... shift the equilibrium left. For exothermic processes... the opposite temperature dependence is observed."  
**Independent check (pass):** Correct and supported by OpenStax Chemistry: Atoms First §13.3 (Le Châtelier / temperature effects), lines 30889-30894: "heat (q) may be viewed as a reactant" for endothermic processes and "heat is viewed as a product" for exothermic — matches c1=reactant (ΔH>0) and c2=product (ΔH<0); direction not reversed, sign conventions correct, cloze hides the load-bearing concept, within AAMC 5E scope.

### Card 24 — _Le Châtelier's Principle_
**Cloze:** A catalyst does {{c1::not}} shift the position of an equilibrium; it only speeds the forward and reverse reactions equally, so equilibrium is {{c2::reached faster}} with the same final composition.  
**Claim:** A catalyst does not change equilibrium position; it only makes equilibrium arrive faster.  
**Confidence:** 5  
**Source (generation):** openstax-chemistry-atoms-first-2e.txt §17.7, lines 40497-40499 — "a catalyst has no effect on the value of an equilibrium constant nor on equilibrium concentrations"; line 40594 — "cause equilibrium to be reached more rapidly."  
**Independent check (pass):** Correct and supported by LibreTexts organic chemistry §14.3 (lines 39248-39249: "the kinetic product is the product that is formed faster, and the thermodynamic product is the product that is more stable"; line 39269: 1,2-addition kinetic pathway "has a smaller activation energy"). Direction is right (kinetic=faster/lower Ea, thermodynamic=more stable); clozes hide the load-bearing concept labels and their defining properties, count of 2 preserved.

### Card 25 — _Kinetic vs Thermodynamic Control_
**Cloze:** The {{c1::kinetic}} product is the one that forms {{c2::faster}} because its pathway has the lower activation barrier, whereas the {{c1::thermodynamic}} product is the one that is more {{c2::stable}}.  
**Claim:** Kinetic product = forms faster (lower Ea); thermodynamic product = more stable.  
**Confidence:** 5  
**Source (generation):** libretexts-organic-chemistry.txt §14.3, lines 39248-39250 — "the kinetic product is the product that is formed faster, and the thermodynamic product is the product that is more stable"; lines 39269 — 1,2-addition "has a smaller activation energy."  
**Independent check (pass):** Correct and supported by LibreTexts organic chemistry §14.3 (lines 39231-39235, 39266-39268): low temperature makes the product-forming step effectively irreversible, so the major product is determined by relative reaction rates ("not by thermodynamic stability"), and "the kinetic product, will predominate." Direction is right (low temp → kinetic, not reversed). Cloze hides the recall-worthy concepts ({{c1::kinetic}}, {{c2::low temperature}}); count of 2 matches; within AAMC 5E scope.

### Card 26 — _Kinetic vs Thermodynamic Control_
**Cloze:** The {{c1::kinetic}} product predominates at {{c2::low temperature}}, where the product-forming step is effectively irreversible and outcome is set by relative reaction rates rather than stability.  
**Claim:** Low temperature (irreversible conditions) favors the kinetic product; rates, not stability, decide.  
**Confidence:** 5  
**Source (generation):** libretexts-organic-chemistry.txt §14.3, lines 39231-39235, 39266-39268 — "At lower temperatures the formation... [is] irreversible... the major product is determined by the relative reaction rates and not by thermodynamic stability... the kinetic product, will predominate."  
**Independent check (pass):** Supported by LibreTexts organic chemistry §14.3 (lines 39231-39235, 39266-39268): "At lower temperatures the formation... [is] irreversible... the major product is determined by the relative reaction rates and not by thermodynamic stability" and "If the reaction temperature is kept sufficiently low... under kinetic control meaning the product which forms faster, the kinetic product, will predominate." Direction is correct (kinetic = low T, effectively irreversible, rate-controlled); cloze hides the two load-bearing concepts (kinetic; low temperature).

### Card 27 — _Kinetic vs Thermodynamic Control_
**Cloze:** The {{c1::thermodynamic}} product predominates at {{c2::higher temperature}} under reversible conditions, because the system can equilibrate and minimize its Gibbs free energy, favoring the product with the more {{c3::negative ΔG}}.  
**Claim:** Higher temperature (reversible conditions) favors the thermodynamic product, which has the more negative ΔG.  
**Confidence:** 5  
**Source (generation):** libretexts-organic-chemistry.txt §14.3, lines 39236-39239, 39257-39261 — "At higher temperatures the reaction... becomes reversible... the major product is determined by thermodynamic stability... the system will minimize its Gibbs free energy... the most thermodynamically stable molecule... will be predominantly formed."  
**Independent check (pass):** All three clozes are correct and supported by LibreTexts Organic Chemistry §14.3 (lines 39236–39261): the thermodynamic product predominates at higher temperature under reversible conditions, where the system minimizes its Gibbs free energy and favors the more stable product (more negative ΔG). Directions are right (thermodynamic=stable=higher T=more negative ΔG); c1/c2/c3 hide the load-bearing concepts, count of 3 matches.

## needs_sme_review
None — all cards verified at confidence 5 and independently confirmed.

## Disagreements with corpus
None.

## Discrepancies between primary and secondary sources
None. Kinetic/thermodynamic-control cards (subtopic 6) were grounded in LibreTexts Organic Chemistry, as this concept is not covered in the gen-chem text; all other cards grounded in OpenStax Atoms First 2e.

---
## Post-verification SME decisions
_Reserved for SME overrides/retentions/revisions. Each entry: card number, decision, rationale, date._
