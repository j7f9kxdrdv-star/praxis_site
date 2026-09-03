-- ============================================================
-- Multi-character subscripts: move the notation into markup
--
-- Spotted by Mikko while studying: "MA = Fout / Fin" should read F with a
-- subscript out over F with a subscript in.
--
-- THIS ONE COULD NOT BE FIXED IN THE CONTENT. Unicode has subscript forms for
-- only a e h i j k l m n o p r s t u v x, and NO multi-character forms at all.
-- F_out, V_max, k_cat, Z_eff, K_sp and K_eq can never be written as characters
-- however the card is edited. Subscript digits do exist, which is why the
-- chemical formulas were fixable in plain text and these are not.
--
-- So the renderer learned a small markup instead:
--
--   F_{out}   ->  F with a real subscript
--   10^{-5}   ->  ten to the minus five
--
-- lib/flashcards/cloze.ts parses it, components/flashcards/RichText.tsx draws
-- it. Deliberately not LaTeX: the braces delimit exactly one run, nothing needs
-- escaping, and an unmatched brace renders as itself instead of swallowing the
-- rest of the card.
--
-- 61 cards converted. K_m and K_a could have used Unicode, but mixing two
-- conventions for the same idea is worse than one that always works.
--
-- ORDER MATTERS IN THE GENERATOR, and boundaries more so. Longest suffix first,
-- so Vmax is not eaten by a shorter rule, and standalone tokens only: an
-- unbounded match would turn "Kaplan" into K_{a}plan and "Wingate" into
-- W_{in}gate. The generator refuses to emit any card where a subscript is
-- followed by more letters, which is what that failure looks like.
--
-- MOBILE STILL RENDERS THESE FLAT. React Native has no sub element, so
-- praxist-mobile shows the markup as literal text until it gets its own
-- renderer. Web is correct from the next deploy.
-- ============================================================

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'K_{m} is inversely related to enzyme-substrate affinity: a {{c1::small}} K_{m} means the enzyme reaches half saturation at low [S] (high affinity); a {{c1::large}} K_{m} means low affinity.' WHERE id = '0018234b-7032-45f6-b15a-eac0ea0c0430';

-- Enzymes
UPDATE public.flashcards SET cloze_text = '{{c1::V_{max}}} is the maximum reaction rate reached when every active site is saturated with substrate; the only way to raise {{c1::V_{max}}} is to increase {{c2::enzyme concentration}}.' WHERE id = '01622ae1-7d21-4083-80eb-296abdd9a64c';

-- Solutions
UPDATE public.flashcards SET cloze_text = 'A solution whose IP exceeds K_{sp} is {{c1::supersaturated}}, so solute {{c1::precipitates}} until IP drops back to K_{sp}.' WHERE id = '02596a50-d92e-4b1f-8a4c-4eb7add024af';

-- Solutions
UPDATE public.flashcards SET cloze_text = 'The excess undissolved salt is left out of a K_{sp} expression because the concentration of a pure solid is {{c1::constant}}.' WHERE id = '06eeca27-9251-45ec-9a75-0d0a0e006558';

-- Energy, Work & Simple Machines
UPDATE public.flashcards SET cloze_text = 'The {{c1::efficiency}} of a real machine is the ratio of its useful work output to the work input, usually expressed as a percentage: {{c2::(W_{out} / W_{in}) × 100%}}. For an ideal frictionless machine this equals 100%; real machines are always less.' WHERE id = '0d9846de-b7f2-4020-9825-f839f31b582b';

-- Solutions
UPDATE public.flashcards SET cloze_text = 'Comparing K_{sp} values ranks solubility correctly only for salts sharing {{c1::the same dissolution stoichiometry}}; otherwise a larger K_{sp} can belong to the less soluble salt.' WHERE id = '10168503-d77e-45d0-bfab-6e3725384613';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'A species is classified as a {{c1::weak}} acid or base when its K_{a} or K_{b} is {{c2::less than 1}}.' WHERE id = '104e5382-4f52-46de-a879-423869864ba2';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'The water-dissociation constant {{c1::K_{w}}} = [H₃O⁺][OH⁻] = {{c2::1 × 10⁻¹⁴}} at 25 °C (298 K).' WHERE id = '13f7771f-9209-401d-ab1e-d2f305ea18c1';

-- Equilibrium
UPDATE public.flashcards SET cloze_text = 'A {{c1::large}} K_{eq} means the equilibrium mixture is dominated by {{c2::products}}, with the forward reaction proceeding nearly to completion, whereas a {{c1::small}} K_{eq} means little conversion has occurred and {{c2::reactants}} predominate.' WHERE id = '16bcfdfd-2e4f-46cf-a189-87eee625e05e';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'A {{c1::competitive inhibitor}} resembles the substrate and binds the {{c2::active site}}; the inhibition is overcome by adding more substrate, so V_{max} is {{c3::unchanged}} but the apparent K_{m} {{c3::increases}}.' WHERE id = '1df9f037-3a3e-46cc-825a-c054fb3d05d3';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'For a base B, the dissociation constant is {{c1::K_{b} = [BH⁺][OH⁻] / [B]}}; smaller K_{b} means a {{c2::weaker}} base.' WHERE id = '24de2d06-cad4-44a6-b8f5-40248e66b74c';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'A {{c1::mixed inhibitor}} binds an allosteric site on either the enzyme or the ES complex with different affinities; V_{max} always {{c2::decreases}}, while K_{m} can rise or fall based on which form is preferred.' WHERE id = '2697203c-db37-4fa4-9e37-758c1414b773';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'On a Lineweaver-Burk plot, the y-intercept equals {{c1::1/V_{max}}} and the x-intercept equals {{c2::-1/K_{m}}}.' WHERE id = '26bb181a-19bb-414d-922f-a2202084f54e';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'Within a conjugate pair, if K_{a} is {{c1::large}}, K_{b} is {{c1::small}}, and vice versa. A strong acid cannot have a strong conjugate base.' WHERE id = '3040d620-47ad-4888-9331-588e23428515';

-- The Gas Phase
UPDATE public.flashcards SET cloze_text = 'The mole fraction of component i is χᵢ = {{c1::nᵢ / n_{total}}}.' WHERE id = '31d8f65e-5bbc-484d-91bf-f944cccf43fc';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'The {{c1::turnover number (k_{cat})}} is the number of substrate molecules converted to product per enzyme molecule per second when the enzyme is fully {{c2::saturated}}.' WHERE id = '35027833-f2d1-4428-8c74-2c67ad46289e';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'A quick memory tool: {{c1::competitive}} affects K_{m} only, {{c1::noncompetitive}} affects V_{max} only, {{c1::uncompetitive}} affects both, and {{c1::mixed}} affects both with variable K_{m} direction.' WHERE id = '40457cc6-65d1-4b13-9a4e-daf8368d57a8';

-- Electrochemistry
UPDATE public.flashcards SET cloze_text = 'When {{c1::K_{eq} > 1}}, E°(cell) is {{c2::positive}}; when {{c1::K_{eq} < 1}}, E°(cell) is {{c2::negative}}; when {{c1::K_{eq} = 1}}, E°(cell) equals {{c2::zero}}.' WHERE id = '43024be0-12f8-41f5-b9a2-99abca85c9a9';

-- Equilibrium
UPDATE public.flashcards SET cloze_text = 'If the equilibrium constant for a reaction in the forward direction is K_{eq}, the equilibrium constant for the {{c1::reverse}} reaction is {{c2::1/K_{eq}}}.' WHERE id = '44fe8095-6e2a-4d2f-a3e6-ddc2b164f55f';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'Polyprotic acids dissociate {{c1::stepwise}}, with each successive K_{a} {{c2::smaller}} than the one before it; H₃PO₄ has three distinct pKa values.' WHERE id = '475b6f2a-eaac-4ce2-97a2-4a4a7cd627c6';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'A plot of V vs [S] for a Michaelis-Menten enzyme is a {{c1::hyperbola}} that rises steeply at low [S] and asymptotically approaches {{c2::V_{max}}} at high [S].' WHERE id = '505e386f-1da7-4279-858c-51cf4397dbf5';

-- Solutions
UPDATE public.flashcards SET cloze_text = 'For a nonvolatile solute, boiling-point elevation is ΔTb = {{c1::i·K_{b}·m}}.' WHERE id = '5a07dafc-2c92-46c3-9f4a-f5b8620c99a8';

-- The Gas Phase
UPDATE public.flashcards SET cloze_text = 'The partial pressure of component i in a gas mixture is Pᵢ = {{c1::χᵢ × P_{total}}}.' WHERE id = '5e91be3a-05a6-41f4-828c-c3c1bc221ad4';

-- Solutions
UPDATE public.flashcards SET cloze_text = 'When an ionic solid separates into its aqueous ions, the equilibrium constant for that process is the {{c1::solubility product constant (K_{sp})}}.' WHERE id = '69f3aa92-991d-4994-9f4e-3d2f9cdbba1d';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'An {{c1::uncompetitive inhibitor}} binds only to the {{c2::enzyme-substrate complex}}, locking the substrate in place; both K_{m} and V_{max} {{c3::decrease}} by the same factor.' WHERE id = '81ee77d7-5dd5-47f8-8382-9403a220df52';

-- Equilibrium
UPDATE public.flashcards SET cloze_text = 'The magnitude of K_{eq} indicates how far a reaction proceeds but says {{c1::nothing}} about how {{c2::fast}} equilibrium is reached, since that depends on kinetics.' WHERE id = '8855771a-e92a-4147-a602-f9f91d1bd1ed';

-- Periodic Trends & Chemical Families
UPDATE public.flashcards SET cloze_text = '{{c1::Effective nuclear charge (Z_{eff})}} is the net positive charge actually experienced by an atom''s outermost electrons after accounting for {{c2::shielding}} by the inner-shell electrons. Formally Z_{eff} ≈ {{c3::Z − S}}, where S is the {{c2::shielding}} constant.' WHERE id = '8c04acab-ca5b-4849-a165-5138bc535b4e';

-- Periodic Trends & Chemical Families
UPDATE public.flashcards SET cloze_text = 'Atomic radius {{c1::decreases}} from left to right across a period (rising Z_{eff} pulls the same outer shell tighter) and {{c2::increases}} from top to bottom in a group (each new period adds an electron shell at a larger principal quantum number).' WHERE id = '8f7d617e-ae05-4a2c-872d-811eb745bbe5';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'To estimate pX for a value (n × 10⁻ᵐ) on the MCAT: pX ≈ {{c1::m − 0.n}}. Example: pKa for K_{a} = 1.8 × 10⁻⁵ is approximately {{c2::5 − 0.18 = 4.82}}.' WHERE id = '925e173e-12df-43e7-946b-4a2ccdd543b5';

-- Enzymes
UPDATE public.flashcards SET cloze_text = '{{c1::Catalytic efficiency}} is given by the ratio {{c2::k_{cat} / K_{m}}}; a high {{c2::k_{cat}}} (fast turnover) or low {{c2::K_{m}}} (tight binding) both increase it.' WHERE id = '9c43199d-e5c4-4fad-847d-dab11e3dfea7';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'A {{c1::noncompetitive inhibitor}} binds an {{c2::allosteric site}} and reduces the maximum rate; it cannot be overcome by adding substrate, so V_{max} {{c3::decreases}} while K_{m} is {{c3::unchanged}}.' WHERE id = 'a0b0a4e3-867d-41ce-85af-5f06e624d531';

-- Equilibrium
UPDATE public.flashcards SET cloze_text = 'When {{c1::Q < K_{eq}}}, the reaction proceeds in the {{c2::forward}} direction (net formation of products) to reach equilibrium.' WHERE id = 'a3f9b700-9a06-4244-a469-a161faa9b4f5';

-- Energy, Work & Simple Machines
UPDATE public.flashcards SET cloze_text = '{{c1::Mechanical advantage}} of a simple machine is the ratio of the output force it produces to the input force applied: {{c2::MA = F_{out} / F_{in}}}.' WHERE id = 'a55d2eb6-82ae-4d85-88ef-2ac2d3f5a860';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'For a conjugate acid-base pair, {{c1::K_{a} × K_{b} = K_{w}}} = 1 × 10⁻¹⁴; equivalently, pKa + pKb = 14.' WHERE id = 'a6790f5d-5c79-4b3a-95f6-39056e1b3d83';

-- Equilibrium
UPDATE public.flashcards SET cloze_text = 'When {{c1::Q > K_{eq}}}, the reaction proceeds in the {{c2::reverse}} direction (net formation of reactants) until equilibrium is restored.' WHERE id = 'a860060a-f4bf-4a7d-a1e6-5cd9cb89b970';

-- Enzymes
UPDATE public.flashcards SET cloze_text = '{{c1::K_{m}}} (the Michaelis constant) equals the substrate concentration at which the reaction velocity is {{c2::half of V_{max}}}.' WHERE id = 'a946197c-f867-41ce-b1b5-74692a5a5d08';

-- Analyzing Organic Reactions
UPDATE public.flashcards SET cloze_text = 'The {{c1::acid dissociation constant (K_{a})}} = {{c2::[H⁺][A⁻] / [HA]}}; {{c3::pKa = −log(K_{a})}}, and a {{c4::lower pKa}} means a stronger acid.' WHERE id = 'aacc1d5a-c25b-4612-8cc4-a97ebce3523c';

-- Equilibrium
UPDATE public.flashcards SET cloze_text = 'The value of K_{eq} depends on {{c1::temperature}}, so it changes only when the {{c1::temperature}} changes; adding reactant or product, or adding a catalyst, leaves K_{eq} {{c2::unchanged}}.' WHERE id = 'b5e743ab-ee81-4c20-aeda-fffa9cc0a4fa';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'A salt of a weak acid and a weak base may be acidic, basic, or neutral. The outcome depends on the relative magnitudes of {{c1::K_{a}}} and {{c2::K_{b}}} of the parent species.' WHERE id = 'b77b673d-3e69-46db-a18b-8aeea25ab136';

-- Solutions
UPDATE public.flashcards SET cloze_text = 'For the dissolution AₘBₙ(s) ⇌ mAⁿ⁺(aq) + nBᵐ⁻(aq), K_{sp} = {{c1::[Aⁿ⁺]ᵐ[Bᵐ⁻]ⁿ}}.' WHERE id = 'bbd360e7-3184-4973-9dcd-a0552226e9ef';

-- Electrochemistry
UPDATE public.flashcards SET cloze_text = 'ΔG° = −nFE°(cell) = {{c1::−RT ln K_{eq}}}, so E°(cell) and K_{eq} are linked: large K_{eq} → large positive E°.' WHERE id = 'c084856d-1f83-4e5f-b51d-ad038ea6b0b5';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'K_{w} depends only on {{c1::temperature}}: it increases when water is heated (because autoionization is endothermic), but pH 7 is neutral only at 25 °C.' WHERE id = 'c4582a64-f6aa-4df5-847d-46dbe0961283';

-- The Gas Phase
UPDATE public.flashcards SET cloze_text = 'For a mixture of ideal gases, the total pressure is P_{total} = {{c1::P₁ + P₂ + P₃ + …}}' WHERE id = 'c50e33f7-1532-4969-81b4-7bad14de7e1b';

-- Solutions
UPDATE public.flashcards SET cloze_text = 'For a dissolving salt, the {{c1::ion product (IP)}} is written exactly like K_{sp} but evaluated with the actual, non-equilibrium concentrations present.' WHERE id = 'c5707c55-9d00-4dc5-98bc-fd58ae6e4e45';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'For an acid HA, the dissociation constant is {{c1::K_{a} = [H₃O⁺][A⁻] / [HA]}}; smaller K_{a} means a {{c2::weaker}} acid (less dissociation).' WHERE id = 'c8aa9580-fb45-46f3-85b0-f1e2cef59f72';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'The {{c1::Michaelis-Menten}} equation describes initial reaction velocity: V = {{c2::V_{max}[S] / (K_{m} + [S])}}, predicting how rate depends on substrate concentration.' WHERE id = 'cd29e1f7-c783-4d55-9fa4-0e58c55f44f2';

-- Chemical Kinetics
UPDATE public.flashcards SET cloze_text = 'A catalyst lowers Eₐ but leaves the {{c1::equilibrium constant (K_{eq})}}, the {{c1::equilibrium concentrations}}, and {{c1::ΔG of the reaction}} unchanged. It alters kinetics, never thermodynamics.' WHERE id = 'd4a6d5f0-81e9-491b-903d-d4adc4413037';

-- Solutions
UPDATE public.flashcards SET cloze_text = 'When IP < K_{sp}, the solution is {{c1::unsaturated}} and {{c1::added solid will dissolve}}.' WHERE id = 'd99ced19-83e7-422c-bcf8-e814e4edd813';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'If a mixed inhibitor prefers the {{c1::free enzyme}}, K_{m} {{c2::rises}} (lowering apparent affinity); if it prefers the {{c1::ES complex}}, K_{m} {{c2::falls}}.' WHERE id = 'ddd71801-93b1-4dd7-bbec-4139698b70bc';

-- Solutions
UPDATE public.flashcards SET cloze_text = 'When the ion product exactly equals K_{sp}, the solution is {{c1::saturated}}. Dissolution and precipitation run at equal rates, so ion concentrations hold steady.' WHERE id = 'e4f3c0b7-05ae-4a14-a269-523f9a026204';

-- Equilibrium
UPDATE public.flashcards SET cloze_text = 'When {{c1::Q = K_{eq}}}, the system is at {{c2::equilibrium}} and undergoes no net reaction, with forward and reverse rates equal.' WHERE id = 'e8d2bf30-5ee4-444a-8795-a7bd23f2978e';

-- Enzymes
UPDATE public.flashcards SET cloze_text = 'k_{cat} can be calculated from V_{max} using {{c1::k_{cat} = V_{max} / [E]total}}, where [E]total is the total enzyme concentration.' WHERE id = 'e929b270-cbaa-44ce-98fd-46dd6dcbbcd9';

-- Periodic Trends & Chemical Families
UPDATE public.flashcards SET cloze_text = 'Ionization energy {{c1::increases}} from left to right across a period (rising Z_{eff} binds the valence electron more tightly) and {{c1::decreases}} from top to bottom in a group (valence electron is farther from the nucleus and more shielded).' WHERE id = 'e948523f-2b46-496b-af2b-2ed14b2ddf1c';

-- Equilibrium
UPDATE public.flashcards SET cloze_text = 'The equilibrium constant is linked to the standard free energy change by {{c1::ΔG° = −RT ln K_{eq}}}; a K_{eq} greater than 1 corresponds to a {{c2::negative}} ΔG° (products favored), while a K_{eq} less than 1 corresponds to a {{c3::positive}} ΔG° (reactants favored).' WHERE id = 'eb071e3c-ecff-4e9e-8f61-d7c2cb0fe3b6';

-- Light and Optics
UPDATE public.flashcards SET cloze_text = 'For thin lenses placed close together, their powers (in diopters) combine as P_{total} = {{c1::P₁ + P₂ + …}}.' WHERE id = 'ed6cfe38-79b5-4953-a1e0-a1e680b86ef0';

-- Equilibrium
UPDATE public.flashcards SET cloze_text = 'For the reaction aA + bB ⇌ cC + dD, the equilibrium constant expression places {{c1::products}} in the numerator and {{c2::reactants}} in the denominator, each raised to its {{c3::stoichiometric coefficient}}: K_{eq} = [C]ᶜ[D]ᵈ / [A]ᵃ[B]ᵇ.' WHERE id = 'ef054ebc-0238-414b-a34e-ed33d1fad255';

-- Chemical Kinetics
UPDATE public.flashcards SET cloze_text = 'A catalyst speeds a reaction by opening an alternative pathway with a {{c1::lower activation energy}}, lowering the barrier for the forward and reverse steps {{c2::equally}}; it leaves ΔG, ΔH, and K_{eq} {{c3::unchanged}}, so equilibrium is reached faster but not shifted.' WHERE id = 'ef7cf84a-9b6f-44b1-b762-e3379942f3bb';

-- Acids and Bases
UPDATE public.flashcards SET cloze_text = 'To find a hydrolyzing salt''s pH, obtain the reactive ion''s ionization constant from {{c1::K_{a} × K_{b} = K_{w}}}, then solve its weak-acid or weak-base equilibrium.' WHERE id = 'f1a92089-a4e6-41c3-9396-ce9de97a23a9';

-- Solutions
UPDATE public.flashcards SET cloze_text = 'Converting between K_{sp} and molar solubility is valid only if the dissolved ions undergo {{c1::no further reaction}} in solution.' WHERE id = 'f3729e32-b88d-4ee0-a418-07a030f73b1e';

-- Periodic Trends & Chemical Families
UPDATE public.flashcards SET cloze_text = 'Z_{eff} {{c1::increases}} from left to right across a period (more protons added with negligible new shielding) but stays roughly {{c2::constant}} down a group (each added shell provides new shielding that cancels the added nuclear charge).' WHERE id = 'f42093b3-4233-40ee-baef-b1992ee339c3';

-- Energy, Work & Simple Machines
UPDATE public.flashcards SET cloze_text = 'Simple machines do not create energy; they only redistribute it. For an ideal (frictionless) machine, the work done by the input equals the work done by the output: {{c1::F_{in} × din = F_{out} × dout}}. So a higher mechanical advantage always comes with a longer input-distance trade-off.' WHERE id = 'fe5aa4fe-9520-4906-af28-c9b12268e385';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 61.
SELECT COUNT(*) AS cards_updated FROM public.flashcards
WHERE id IN ('0018234b-7032-45f6-b15a-eac0ea0c0430', '01622ae1-7d21-4083-80eb-296abdd9a64c', '02596a50-d92e-4b1f-8a4c-4eb7add024af', '06eeca27-9251-45ec-9a75-0d0a0e006558', '0d9846de-b7f2-4020-9825-f839f31b582b', '10168503-d77e-45d0-bfab-6e3725384613', '104e5382-4f52-46de-a879-423869864ba2', '13f7771f-9209-401d-ab1e-d2f305ea18c1', '16bcfdfd-2e4f-46cf-a189-87eee625e05e', '1df9f037-3a3e-46cc-825a-c054fb3d05d3', '24de2d06-cad4-44a6-b8f5-40248e66b74c', '2697203c-db37-4fa4-9e37-758c1414b773', '26bb181a-19bb-414d-922f-a2202084f54e', '3040d620-47ad-4888-9331-588e23428515', '31d8f65e-5bbc-484d-91bf-f944cccf43fc', '35027833-f2d1-4428-8c74-2c67ad46289e', '40457cc6-65d1-4b13-9a4e-daf8368d57a8', '43024be0-12f8-41f5-b9a2-99abca85c9a9', '44fe8095-6e2a-4d2f-a3e6-ddc2b164f55f', '475b6f2a-eaac-4ce2-97a2-4a4a7cd627c6', '505e386f-1da7-4279-858c-51cf4397dbf5', '5a07dafc-2c92-46c3-9f4a-f5b8620c99a8', '5e91be3a-05a6-41f4-828c-c3c1bc221ad4', '69f3aa92-991d-4994-9f4e-3d2f9cdbba1d', '81ee77d7-5dd5-47f8-8382-9403a220df52', '8855771a-e92a-4147-a602-f9f91d1bd1ed', '8c04acab-ca5b-4849-a165-5138bc535b4e', '8f7d617e-ae05-4a2c-872d-811eb745bbe5', '925e173e-12df-43e7-946b-4a2ccdd543b5', '9c43199d-e5c4-4fad-847d-dab11e3dfea7', 'a0b0a4e3-867d-41ce-85af-5f06e624d531', 'a3f9b700-9a06-4244-a469-a161faa9b4f5', 'a55d2eb6-82ae-4d85-88ef-2ac2d3f5a860', 'a6790f5d-5c79-4b3a-95f6-39056e1b3d83', 'a860060a-f4bf-4a7d-a1e6-5cd9cb89b970', 'a946197c-f867-41ce-b1b5-74692a5a5d08', 'aacc1d5a-c25b-4612-8cc4-a97ebce3523c', 'b5e743ab-ee81-4c20-aeda-fffa9cc0a4fa', 'b77b673d-3e69-46db-a18b-8aeea25ab136', 'bbd360e7-3184-4973-9dcd-a0552226e9ef', 'c084856d-1f83-4e5f-b51d-ad038ea6b0b5', 'c4582a64-f6aa-4df5-847d-46dbe0961283', 'c50e33f7-1532-4969-81b4-7bad14de7e1b', 'c5707c55-9d00-4dc5-98bc-fd58ae6e4e45', 'c8aa9580-fb45-46f3-85b0-f1e2cef59f72', 'cd29e1f7-c783-4d55-9fa4-0e58c55f44f2', 'd4a6d5f0-81e9-491b-903d-d4adc4413037', 'd99ced19-83e7-422c-bcf8-e814e4edd813', 'ddd71801-93b1-4dd7-bbec-4139698b70bc', 'e4f3c0b7-05ae-4a14-a269-523f9a026204', 'e8d2bf30-5ee4-444a-8795-a7bd23f2978e', 'e929b270-cbaa-44ce-98fd-46dd6dcbbcd9', 'e948523f-2b46-496b-af2b-2ed14b2ddf1c', 'eb071e3c-ecff-4e9e-8f61-d7c2cb0fe3b6', 'ed6cfe38-79b5-4953-a1e0-a1e680b86ef0', 'ef054ebc-0238-414b-a34e-ed33d1fad255', 'ef7cf84a-9b6f-44b1-b762-e3379942f3bb', 'f1a92089-a4e6-41c3-9396-ce9de97a23a9', 'f3729e32-b88d-4ee0-a418-07a030f73b1e', 'f42093b3-4233-40ee-baef-b1992ee339c3', 'fe5aa4fe-9520-4906-af28-c9b12268e385');

-- Expect zero: no subscript should be followed by more letters, which is what
-- a bad substring match looks like ("Kaplan" -> K_{a}plan).
SELECT COUNT(*) AS mangled_words FROM public.flashcards
WHERE cloze_text ~ '[A-Za-z]_\{[a-z]+\}[a-z]';
