-- ============================================================
-- URGENT: repair the subscript markup I broke
--
-- The subscript notation shipped earlier today used braces, F_{out}, and that
-- collides with the cloze delimiter. A card reading
--
--   {{c1::MA = F_{out} / F_{in}}}
--
-- is parsed non-greedily to the FIRST "}}", which now falls inside the
-- notation. The blank swallowed "MA = F_{out} / F_{in" and left a stray "}"
-- sitting outside it, which is exactly what Mikko saw on screen.
--
-- Braces belong to the cloze syntax. Notation cannot also use them. The markup
-- is now parenthesised:
--
--   F_(out)   10^(-5)
--
-- 61 cards are converted here. 31 of them had the notation INSIDE a cloze
-- answer and were actively parsing wrong; the rest had it in the stem, where
-- it merely displayed as literal braces.
--
-- Every conversion is checked before being written: after the swap the cloze
-- parser must find exactly cloze_count groups and no brace markup may remain.
--
-- THIS IS SAFE TO RUN BEFORE THE WEB DEPLOY. Until the renderer ships these
-- read as F_(out), which is at least intact and legible, rather than a blank
-- that eats half the formula.
-- ============================================================

UPDATE public.flashcards SET cloze_text = 'K_(m) is inversely related to enzyme-substrate affinity: a {{c1::small}} K_(m) means the enzyme reaches half saturation at low [S] (high affinity); a {{c1::large}} K_(m) means low affinity.' WHERE id = '0018234b-7032-45f6-b15a-eac0ea0c0430';
UPDATE public.flashcards SET cloze_text = '{{c1::V_(max)}} is the maximum reaction rate reached when every active site is saturated with substrate; the only way to raise {{c1::V_(max)}} is to increase {{c2::enzyme concentration}}.' WHERE id = '01622ae1-7d21-4083-80eb-296abdd9a64c';
UPDATE public.flashcards SET cloze_text = 'A solution whose IP exceeds K_(sp) is {{c1::supersaturated}}, so solute {{c1::precipitates}} until IP drops back to K_(sp).' WHERE id = '02596a50-d92e-4b1f-8a4c-4eb7add024af';
UPDATE public.flashcards SET cloze_text = 'The excess undissolved salt is left out of a K_(sp) expression because the concentration of a pure solid is {{c1::constant}}.' WHERE id = '06eeca27-9251-45ec-9a75-0d0a0e006558';
UPDATE public.flashcards SET cloze_text = 'The {{c1::efficiency}} of a real machine is the ratio of its useful work output to the work input, usually expressed as a percentage: {{c2::(W_(out) / W_(in)) × 100%}}. For an ideal frictionless machine this equals 100%; real machines are always less.' WHERE id = '0d9846de-b7f2-4020-9825-f839f31b582b';
UPDATE public.flashcards SET cloze_text = 'Comparing K_(sp) values ranks solubility correctly only for salts sharing {{c1::the same dissolution stoichiometry}}; otherwise a larger K_(sp) can belong to the less soluble salt.' WHERE id = '10168503-d77e-45d0-bfab-6e3725384613';
UPDATE public.flashcards SET cloze_text = 'A species is classified as a {{c1::weak}} acid or base when its K_(a) or K_(b) is {{c2::less than 1}}.' WHERE id = '104e5382-4f52-46de-a879-423869864ba2';
UPDATE public.flashcards SET cloze_text = 'The water-dissociation constant {{c1::K_(w)}} = [H₃O⁺][OH⁻] = {{c2::1 × 10⁻¹⁴}} at 25 °C (298 K).' WHERE id = '13f7771f-9209-401d-ab1e-d2f305ea18c1';
UPDATE public.flashcards SET cloze_text = 'A {{c1::large}} K_(eq) means the equilibrium mixture is dominated by {{c2::products}}, with the forward reaction proceeding nearly to completion, whereas a {{c1::small}} K_(eq) means little conversion has occurred and {{c2::reactants}} predominate.' WHERE id = '16bcfdfd-2e4f-46cf-a189-87eee625e05e';
UPDATE public.flashcards SET cloze_text = 'A {{c1::competitive inhibitor}} resembles the substrate and binds the {{c2::active site}}; the inhibition is overcome by adding more substrate, so V_(max) is {{c3::unchanged}} but the apparent K_(m) {{c3::increases}}.' WHERE id = '1df9f037-3a3e-46cc-825a-c054fb3d05d3';
UPDATE public.flashcards SET cloze_text = 'For a base B, the dissociation constant is {{c1::K_(b) = [BH⁺][OH⁻] / [B]}}; smaller K_(b) means a {{c2::weaker}} base.' WHERE id = '24de2d06-cad4-44a6-b8f5-40248e66b74c';
UPDATE public.flashcards SET cloze_text = 'A {{c1::mixed inhibitor}} binds an allosteric site on either the enzyme or the ES complex with different affinities; V_(max) always {{c2::decreases}}, while K_(m) can rise or fall based on which form is preferred.' WHERE id = '2697203c-db37-4fa4-9e37-758c1414b773';
UPDATE public.flashcards SET cloze_text = 'On a Lineweaver-Burk plot, the y-intercept equals {{c1::1/V_(max)}} and the x-intercept equals {{c2::-1/K_(m)}}.' WHERE id = '26bb181a-19bb-414d-922f-a2202084f54e';
UPDATE public.flashcards SET cloze_text = 'Within a conjugate pair, if K_(a) is {{c1::large}}, K_(b) is {{c1::small}}, and vice versa. A strong acid cannot have a strong conjugate base.' WHERE id = '3040d620-47ad-4888-9331-588e23428515';
UPDATE public.flashcards SET cloze_text = 'The mole fraction of component i is χᵢ = {{c1::nᵢ / n_(total)}}.' WHERE id = '31d8f65e-5bbc-484d-91bf-f944cccf43fc';
UPDATE public.flashcards SET cloze_text = 'The {{c1::turnover number (k_(cat))}} is the number of substrate molecules converted to product per enzyme molecule per second when the enzyme is fully {{c2::saturated}}.' WHERE id = '35027833-f2d1-4428-8c74-2c67ad46289e';
UPDATE public.flashcards SET cloze_text = 'A quick memory tool: {{c1::competitive}} affects K_(m) only, {{c1::noncompetitive}} affects V_(max) only, {{c1::uncompetitive}} affects both, and {{c1::mixed}} affects both with variable K_(m) direction.' WHERE id = '40457cc6-65d1-4b13-9a4e-daf8368d57a8';
UPDATE public.flashcards SET cloze_text = 'When {{c1::K_(eq) > 1}}, E°(cell) is {{c2::positive}}; when {{c1::K_(eq) < 1}}, E°(cell) is {{c2::negative}}; when {{c1::K_(eq) = 1}}, E°(cell) equals {{c2::zero}}.' WHERE id = '43024be0-12f8-41f5-b9a2-99abca85c9a9';
UPDATE public.flashcards SET cloze_text = 'If the equilibrium constant for a reaction in the forward direction is K_(eq), the equilibrium constant for the {{c1::reverse}} reaction is {{c2::1/K_(eq)}}.' WHERE id = '44fe8095-6e2a-4d2f-a3e6-ddc2b164f55f';
UPDATE public.flashcards SET cloze_text = 'Polyprotic acids dissociate {{c1::stepwise}}, with each successive K_(a) {{c2::smaller}} than the one before it; H₃PO₄ has three distinct pKa values.' WHERE id = '475b6f2a-eaac-4ce2-97a2-4a4a7cd627c6';
UPDATE public.flashcards SET cloze_text = 'A plot of V vs [S] for a Michaelis-Menten enzyme is a {{c1::hyperbola}} that rises steeply at low [S] and asymptotically approaches {{c2::V_(max)}} at high [S].' WHERE id = '505e386f-1da7-4279-858c-51cf4397dbf5';
UPDATE public.flashcards SET cloze_text = 'For a nonvolatile solute, boiling-point elevation is ΔTb = {{c1::i·K_(b)·m}}.' WHERE id = '5a07dafc-2c92-46c3-9f4a-f5b8620c99a8';
UPDATE public.flashcards SET cloze_text = 'The partial pressure of component i in a gas mixture is Pᵢ = {{c1::χᵢ × P_(total)}}.' WHERE id = '5e91be3a-05a6-41f4-828c-c3c1bc221ad4';
UPDATE public.flashcards SET cloze_text = 'When an ionic solid separates into its aqueous ions, the equilibrium constant for that process is the {{c1::solubility product constant (K_(sp))}}.' WHERE id = '69f3aa92-991d-4994-9f4e-3d2f9cdbba1d';
UPDATE public.flashcards SET cloze_text = 'An {{c1::uncompetitive inhibitor}} binds only to the {{c2::enzyme-substrate complex}}, locking the substrate in place; both K_(m) and V_(max) {{c3::decrease}} by the same factor.' WHERE id = '81ee77d7-5dd5-47f8-8382-9403a220df52';
UPDATE public.flashcards SET cloze_text = 'The magnitude of K_(eq) indicates how far a reaction proceeds but says {{c1::nothing}} about how {{c2::fast}} equilibrium is reached, since that depends on kinetics.' WHERE id = '8855771a-e92a-4147-a602-f9f91d1bd1ed';
UPDATE public.flashcards SET cloze_text = '{{c1::Effective nuclear charge (Z_(eff))}} is the net positive charge actually experienced by an atom''s outermost electrons after accounting for {{c2::shielding}} by the inner-shell electrons. Formally Z_(eff) ≈ {{c3::Z − S}}, where S is the {{c2::shielding}} constant.' WHERE id = '8c04acab-ca5b-4849-a165-5138bc535b4e';
UPDATE public.flashcards SET cloze_text = 'Atomic radius {{c1::decreases}} from left to right across a period (rising Z_(eff) pulls the same outer shell tighter) and {{c2::increases}} from top to bottom in a group (each new period adds an electron shell at a larger principal quantum number).' WHERE id = '8f7d617e-ae05-4a2c-872d-811eb745bbe5';
UPDATE public.flashcards SET cloze_text = 'To estimate pX for a value (n × 10⁻ᵐ) on the MCAT: pX ≈ {{c1::m − 0.n}}. Example: pKa for K_(a) = 1.8 × 10⁻⁵ is approximately {{c2::5 − 0.18 = 4.82}}.' WHERE id = '925e173e-12df-43e7-946b-4a2ccdd543b5';
UPDATE public.flashcards SET cloze_text = '{{c1::Catalytic efficiency}} is given by the ratio {{c2::k_(cat) / K_(m)}}; a high {{c2::k_(cat)}} (fast turnover) or low {{c2::K_(m)}} (tight binding) both increase it.' WHERE id = '9c43199d-e5c4-4fad-847d-dab11e3dfea7';
UPDATE public.flashcards SET cloze_text = 'A {{c1::noncompetitive inhibitor}} binds an {{c2::allosteric site}} and reduces the maximum rate; it cannot be overcome by adding substrate, so V_(max) {{c3::decreases}} while K_(m) is {{c3::unchanged}}.' WHERE id = 'a0b0a4e3-867d-41ce-85af-5f06e624d531';
UPDATE public.flashcards SET cloze_text = 'When {{c1::Q < K_(eq)}}, the reaction proceeds in the {{c2::forward}} direction (net formation of products) to reach equilibrium.' WHERE id = 'a3f9b700-9a06-4244-a469-a161faa9b4f5';
UPDATE public.flashcards SET cloze_text = '{{c1::Mechanical advantage}} of a simple machine is the ratio of the output force it produces to the input force applied: {{c2::MA = F_(out) / F_(in)}}.' WHERE id = 'a55d2eb6-82ae-4d85-88ef-2ac2d3f5a860';
UPDATE public.flashcards SET cloze_text = 'For a conjugate acid-base pair, {{c1::K_(a) × K_(b) = K_(w)}} = 1 × 10⁻¹⁴; equivalently, pKa + pKb = 14.' WHERE id = 'a6790f5d-5c79-4b3a-95f6-39056e1b3d83';
UPDATE public.flashcards SET cloze_text = 'When {{c1::Q > K_(eq)}}, the reaction proceeds in the {{c2::reverse}} direction (net formation of reactants) until equilibrium is restored.' WHERE id = 'a860060a-f4bf-4a7d-a1e6-5cd9cb89b970';
UPDATE public.flashcards SET cloze_text = '{{c1::K_(m)}} (the Michaelis constant) equals the substrate concentration at which the reaction velocity is {{c2::half of V_(max)}}.' WHERE id = 'a946197c-f867-41ce-b1b5-74692a5a5d08';
UPDATE public.flashcards SET cloze_text = 'The {{c1::acid dissociation constant (K_(a))}} = {{c2::[H⁺][A⁻] / [HA]}}; {{c3::pKa = −log(K_(a))}}, and a {{c4::lower pKa}} means a stronger acid.' WHERE id = 'aacc1d5a-c25b-4612-8cc4-a97ebce3523c';
UPDATE public.flashcards SET cloze_text = 'The value of K_(eq) depends on {{c1::temperature}}, so it changes only when the {{c1::temperature}} changes; adding reactant or product, or adding a catalyst, leaves K_(eq) {{c2::unchanged}}.' WHERE id = 'b5e743ab-ee81-4c20-aeda-fffa9cc0a4fa';
UPDATE public.flashcards SET cloze_text = 'A salt of a weak acid and a weak base may be acidic, basic, or neutral. The outcome depends on the relative magnitudes of {{c1::K_(a)}} and {{c2::K_(b)}} of the parent species.' WHERE id = 'b77b673d-3e69-46db-a18b-8aeea25ab136';
UPDATE public.flashcards SET cloze_text = 'For the dissolution AₘBₙ(s) ⇌ mAⁿ⁺(aq) + nBᵐ⁻(aq), K_(sp) = {{c1::[Aⁿ⁺]ᵐ[Bᵐ⁻]ⁿ}}.' WHERE id = 'bbd360e7-3184-4973-9dcd-a0552226e9ef';
UPDATE public.flashcards SET cloze_text = 'ΔG° = −nFE°(cell) = {{c1::−RT ln K_(eq)}}, so E°(cell) and K_(eq) are linked: large K_(eq) → large positive E°.' WHERE id = 'c084856d-1f83-4e5f-b51d-ad038ea6b0b5';
UPDATE public.flashcards SET cloze_text = 'K_(w) depends only on {{c1::temperature}}: it increases when water is heated (because autoionization is endothermic), but pH 7 is neutral only at 25 °C.' WHERE id = 'c4582a64-f6aa-4df5-847d-46dbe0961283';
UPDATE public.flashcards SET cloze_text = 'For a mixture of ideal gases, the total pressure is P_(total) = {{c1::P₁ + P₂ + P₃ + …}}' WHERE id = 'c50e33f7-1532-4969-81b4-7bad14de7e1b';
UPDATE public.flashcards SET cloze_text = 'For a dissolving salt, the {{c1::ion product (IP)}} is written exactly like K_(sp) but evaluated with the actual, non-equilibrium concentrations present.' WHERE id = 'c5707c55-9d00-4dc5-98bc-fd58ae6e4e45';
UPDATE public.flashcards SET cloze_text = 'For an acid HA, the dissociation constant is {{c1::K_(a) = [H₃O⁺][A⁻] / [HA]}}; smaller K_(a) means a {{c2::weaker}} acid (less dissociation).' WHERE id = 'c8aa9580-fb45-46f3-85b0-f1e2cef59f72';
UPDATE public.flashcards SET cloze_text = 'The {{c1::Michaelis-Menten}} equation describes initial reaction velocity: V = {{c2::V_(max)[S] / (K_(m) + [S])}}, predicting how rate depends on substrate concentration.' WHERE id = 'cd29e1f7-c783-4d55-9fa4-0e58c55f44f2';
UPDATE public.flashcards SET cloze_text = 'A catalyst lowers Eₐ but leaves the {{c1::equilibrium constant (K_(eq))}}, the {{c1::equilibrium concentrations}}, and {{c1::ΔG of the reaction}} unchanged. It alters kinetics, never thermodynamics.' WHERE id = 'd4a6d5f0-81e9-491b-903d-d4adc4413037';
UPDATE public.flashcards SET cloze_text = 'When IP < K_(sp), the solution is {{c1::unsaturated}} and {{c1::added solid will dissolve}}.' WHERE id = 'd99ced19-83e7-422c-bcf8-e814e4edd813';
UPDATE public.flashcards SET cloze_text = 'If a mixed inhibitor prefers the {{c1::free enzyme}}, K_(m) {{c2::rises}} (lowering apparent affinity); if it prefers the {{c1::ES complex}}, K_(m) {{c2::falls}}.' WHERE id = 'ddd71801-93b1-4dd7-bbec-4139698b70bc';
UPDATE public.flashcards SET cloze_text = 'When the ion product exactly equals K_(sp), the solution is {{c1::saturated}}. Dissolution and precipitation run at equal rates, so ion concentrations hold steady.' WHERE id = 'e4f3c0b7-05ae-4a14-a269-523f9a026204';
UPDATE public.flashcards SET cloze_text = 'When {{c1::Q = K_(eq)}}, the system is at {{c2::equilibrium}} and undergoes no net reaction, with forward and reverse rates equal.' WHERE id = 'e8d2bf30-5ee4-444a-8795-a7bd23f2978e';
UPDATE public.flashcards SET cloze_text = 'k_(cat) can be calculated from V_(max) using {{c1::k_(cat) = V_(max) / [E]total}}, where [E]total is the total enzyme concentration.' WHERE id = 'e929b270-cbaa-44ce-98fd-46dd6dcbbcd9';
UPDATE public.flashcards SET cloze_text = 'Ionization energy {{c1::increases}} from left to right across a period (rising Z_(eff) binds the valence electron more tightly) and {{c1::decreases}} from top to bottom in a group (valence electron is farther from the nucleus and more shielded).' WHERE id = 'e948523f-2b46-496b-af2b-2ed14b2ddf1c';
UPDATE public.flashcards SET cloze_text = 'The equilibrium constant is linked to the standard free energy change by {{c1::ΔG° = −RT ln K_(eq)}}; a K_(eq) greater than 1 corresponds to a {{c2::negative}} ΔG° (products favored), while a K_(eq) less than 1 corresponds to a {{c3::positive}} ΔG° (reactants favored).' WHERE id = 'eb071e3c-ecff-4e9e-8f61-d7c2cb0fe3b6';
UPDATE public.flashcards SET cloze_text = 'For thin lenses placed close together, their powers (in diopters) combine as P_(total) = {{c1::P₁ + P₂ + …}}.' WHERE id = 'ed6cfe38-79b5-4953-a1e0-a1e680b86ef0';
UPDATE public.flashcards SET cloze_text = 'For the reaction aA + bB ⇌ cC + dD, the equilibrium constant expression places {{c1::products}} in the numerator and {{c2::reactants}} in the denominator, each raised to its {{c3::stoichiometric coefficient}}: K_(eq) = [C]ᶜ[D]ᵈ / [A]ᵃ[B]ᵇ.' WHERE id = 'ef054ebc-0238-414b-a34e-ed33d1fad255';
UPDATE public.flashcards SET cloze_text = 'A catalyst speeds a reaction by opening an alternative pathway with a {{c1::lower activation energy}}, lowering the barrier for the forward and reverse steps {{c2::equally}}; it leaves ΔG, ΔH, and K_(eq) {{c3::unchanged}}, so equilibrium is reached faster but not shifted.' WHERE id = 'ef7cf84a-9b6f-44b1-b762-e3379942f3bb';
UPDATE public.flashcards SET cloze_text = 'To find a hydrolyzing salt''s pH, obtain the reactive ion''s ionization constant from {{c1::K_(a) × K_(b) = K_(w)}}, then solve its weak-acid or weak-base equilibrium.' WHERE id = 'f1a92089-a4e6-41c3-9396-ce9de97a23a9';
UPDATE public.flashcards SET cloze_text = 'Converting between K_(sp) and molar solubility is valid only if the dissolved ions undergo {{c1::no further reaction}} in solution.' WHERE id = 'f3729e32-b88d-4ee0-a418-07a030f73b1e';
UPDATE public.flashcards SET cloze_text = 'Z_(eff) {{c1::increases}} from left to right across a period (more protons added with negligible new shielding) but stays roughly {{c2::constant}} down a group (each added shell provides new shielding that cancels the added nuclear charge).' WHERE id = 'f42093b3-4233-40ee-baef-b1992ee339c3';
UPDATE public.flashcards SET cloze_text = 'Simple machines do not create energy; they only redistribute it. For an ideal (frictionless) machine, the work done by the input equals the work done by the output: {{c1::F_(in) × din = F_(out) × dout}}. So a higher mechanical advantage always comes with a longer input-distance trade-off.' WHERE id = 'fe5aa4fe-9520-4906-af28-c9b12268e385';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect zero: no brace markup left anywhere.
SELECT COUNT(*) AS brace_markup_remaining FROM public.flashcards
WHERE cloze_text ~ '[_^]\{';

-- Expect 61.
SELECT COUNT(*) AS cards_using_paren_markup FROM public.flashcards
WHERE cloze_text ~ '[_^]\(';

-- Expect zero: every card's group count must still match cloze_count.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> cloze_count;
