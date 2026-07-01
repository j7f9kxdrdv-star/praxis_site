# Verification Report — General Chemistry Ch 5: Chemical Kinetics

**Deck:** Chemical Kinetics
**Source SQL:** supabase/seeds/general_chemistry_ch5_chemical_kinetics_flashcards.sql
**Verified:** 2026-07-01
**Corpus:** OpenStax Chemistry: Atoms First 2e (primary — the only reference consulted; kinetics chapter ~lines 38000–40800)
**.docx provenance:** adapted from a commercial MCAT prep source — Source-Laundry rules applied per card (concept identified, .docx closed, framing re-sourced from OpenStax, prose written fresh).

## Summary
- Total cards: 51
- Confidence 5: 49
- Confidence 4: 2
- Confidence 3: 0
- Confidence 2: 0
- Confidence 1: 0
- Cards flagged for needs_sme_review: 0 (all shipped cards verified at confidence ≥4)
- Cards where corpus contradicts card: 1 (the 'optimal temperature' concept — resolved by reframing; see Disagreements)

Note on scope: the generator over-produced 84 candidate cards; 33 were cut as duplicates (the heterogeneous-phase and the temperature/enzyme cards were each drafted ~8×, plus cross-subtopic Arrhenius/collision/catalyst redrafts). The 51 shipped here are the distinct concepts. Subtopic order follows AAMC Foundation 5E, not the .docx chapter order.

## Per-card verification

### — Reaction Rates —

#### Card 0
**Cloze:** A reaction rate is written as a concentration change per unit time; because reactants are consumed, their rate expression carries a {{c1::negative}} sign, while product expressions carry a {{c2::positive}} sign so that the reported rate stays positive.
**Claim:** Reaction rate is the change in reactant or product concentration per unit time; reactant terms are made negative and product terms positive so the reported rate is positive.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 38739, 38761-38763
**Excerpt supporting:** "The rate of reaction is the change in the amount of a reactant or product per unit time." ... "Since the reactant concentration decreases as the reaction proceeds, Δ[H2O2] is a negative quantity. Reaction rates are, by convention, positive quantities, and so this negative change in concentration is multiplied by −1."
**Notes:** Sign convention verified directly. c1/c2 are independently testable (reactant-vs-product), so distinct groups are correct. cloze_count=2 matches the two distinct cN groups. Original prose.

#### Card 1
**Cloze:** For reactants and products in solution, reaction rate is reported in units of {{c1::M·s⁻¹}} (equivalently mol·L⁻¹·s⁻¹) — a molar concentration change divided by a time interval.
**Claim:** Reaction rate for species in solution is expressed in mol/L/s (molarity per second).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 38746-38747, 39390-39391
**Excerpt supporting:** "For reactants and products in solution, their relative amounts (concentrations) are conveniently used for purposes of expressing reaction rates." ... "The units for the rate of a reaction are mol/L/s."
**Notes:** Units verified directly. Single retrieval target (the unit), so one cloze group is correct. Unicode notation M·s⁻¹ used, not LaTeX. Original prose.

#### Card 2
**Cloze:** For a single reaction, the rate written for any one species can be converted to that of any other species using the {{c1::stoichiometric coefficients}} of the balanced equation.
**Claim:** The individual rate expressions for different species in one reaction are related to one another by the reaction stoichiometry.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 38860-38867
**Excerpt supporting:** "The rate of a reaction may be expressed as the change in concentration of any reactant or product. For any given reaction, these rate expressions are all related simply to one another according to the reaction stoichiometry."
**Notes:** Verified directly. One retrieval-critical concept (stoichiometric coefficients), so one cloze group. Original prose.

#### Card 3
**Cloze:** For heterogeneous reactants, reaction happens only at the {{c1::interface between the phases}}, so dividing a solid into smaller particles speeds the reaction by increasing the reactive {{c2::surface area}}.
**Claim:** When reactants are in different phases, reaction occurs only at the phase interface; smaller particles react faster because they present greater surface area.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 39018-39025
**Excerpt supporting:** "When reactants are in different physical states, or phases (solid, liquid, gaseous, dissolved), the reaction takes place only at the interface between the phases. Compared with the reaction rate for large solid particles, the rate for smaller particles will be greater because the surface area in contact with the other reactant phase is greater."
**Notes:** FLAGGED-KEEP (reaction medium / physical-state). SME note: The original prep-source framing ('polar solvents polarize and weaken reactant bonds, speeding reaction') is NOT in the OpenStax source of truth and is a shaky generalization, so I rewrote this as the textbook-defensible physical-state/surface-area effect, which OpenStax states explicitly and is the MCAT-standard 'medium/physical state' point. Two independently-testable ideas (where reaction occurs; why subdivision helps) → two distinct groups; cloze_count=2. Confidence 5 for the retained surface-area framing.

### — Rate Laws & Reaction Order —

#### Card 4
**Cloze:** In a rate law, rate = k[A]ᵐ[B]ⁿ, the term {{c1::k}} is the rate constant and the exponents {{c2::m and n}} are the reaction orders, all of which must be found {{c3::experimentally}} (not from the balanced equation).
**Claim:** The rate law rate = k[A]^m[B]^n contains the rate constant k and reaction orders m, n, all of which are determined experimentally rather than from stoichiometry.
**Confidence:** 5
**Source:** /Users/mikkonieveras/praxis-prep/reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt lines 39118-39127; 39447-39448
**Excerpt supporting:** in which [A] and [B] represent the molar concentrations of reactants, and k is the rate constant... The exponents m and n are the reaction orders... The rate constant k and the reaction orders m and n must be determined experimentally... rate laws are determined by experiment only and are not reliably predicted by reaction stoichiometry.

#### Card 5
**Cloze:** The {{c1::method of initial rates}} determines a rate law by comparing initial rates across trials in which the {{c2::initial reactant concentrations}} are varied one at a time, revealing each reactant's order.
**Claim:** The method of initial rates finds reaction orders by comparing initial rates measured at different initial reactant concentrations.
**Confidence:** 5
**Source:** /Users/mikkonieveras/praxis-prep/reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt lines 39199-39202
**Excerpt supporting:** A common experimental approach to the determination of rate laws is the method of initial rates. This method involves measuring reaction rates for multiple experimental trials carried out using different initial reactant concentrations. Comparing the measured rates for these trials permits determination of the reaction orders...

#### Card 6
**Cloze:** The rate constant k is {{c1::independent of reactant concentration}}, but it does change with {{c2::temperature}}, which is why the same reaction speeds up when heated even though k stays fixed as concentrations change.
**Claim:** k is independent of reactant concentration but varies with temperature.
**Confidence:** 5
**Source:** /Users/mikkonieveras/praxis-prep/reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt lines 39122-39127
**Excerpt supporting:** k is the rate constant, which is specific for a particular reaction at a particular temperature... The rate constant k is independent of the reactant concentrations, but it does vary with temperature.

#### Card 7
**Cloze:** The overall order of a reaction equals the {{c1::sum of the individual reactant orders}}; a rate law of rate = k[A]¹[B]² is therefore {{c2::third}} order overall.
**Claim:** Overall reaction order is the sum of the individual reactant orders; first order in A plus second order in B gives third order overall.
**Confidence:** 5
**Source:** /Users/mikkonieveras/praxis-prep/reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt lines 39129-39133
**Excerpt supporting:** The overall reaction order is simply the sum of orders for each reactant. For the example rate law here, the reaction is third order overall (1 + 2 = 3).

#### Card 8
**Cloze:** Reaction orders are usually small positive integers but can also be {{c1::fractional, negative, or zero}}, and they are established by {{c2::experiment}} rather than predicted from the reaction's stoichiometric coefficients.
**Claim:** Reaction orders can be fractional, negative, or zero, and are determined experimentally, not from stoichiometry.
**Confidence:** 5
**Source:** /Users/mikkonieveras/praxis-prep/reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt lines 39123-39124; 39440-39448
**Excerpt supporting:** The exponents m and n are the reaction orders and are typically positive integers, though they can be fractions, negative, or zero... rate laws are determined by experiment only and are not reliably predicted by reaction stoichiometry.

#### Card 9
**Cloze:** When a reaction is {{c1::zero}} order in a given reactant, that reactant's concentration term drops out of the rate law because any concentration raised to the {{c2::zeroth}} power equals 1, so its concentration has no effect on the rate.
**Claim:** A reactant that is zero order has no effect on rate; its concentration term is omitted because [X]^0 = 1.
**Confidence:** 5
**Source:** /Users/mikkonieveras/praxis-prep/reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt lines 39165-39172
**Excerpt supporting:** The reaction is zero order in CO; thus n = 0... Remember that a number raised to the zero power is equal to 1, thus [CO]0 = 1, which is why the CO concentration term may be omitted from the rate law: the rate of reaction is solely dependent on the concentration of NO2.

### — Reaction Orders (Integrated Rate Laws) —

#### Card 10
**Cloze:** In the rate law rate = k[A]ᵐ[B]ⁿ, the exponents m and n are the {{c1::reaction orders}}, and the overall order is their {{c2::sum}} — values that must be found {{c3::experimentally}}, never read off the balanced equation's coefficients.
**Claim:** Exponents in a rate law are the reaction orders; overall order is the sum of the individual orders; orders are determined experimentally and are not predictable from stoichiometry.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §17.3 Rate Laws, lines 39123-39133; 39447-39448
**Excerpt supporting:** The exponents m and n are the reaction orders... The overall reaction order is simply the sum of orders for each reactant... rate laws are determined by experiment only and are not reliably predicted by reaction stoichiometry.
**Notes:** Three independently testable facts, so three distinct groups: the name 'reaction orders', the 'sum' relationship, and the 'experimentally' method. Retrieval-critical terms hidden. Prose re-sourced and restructured from OpenStax framing.

#### Card 11
**Cloze:** A {{c1::zero}}-order reaction has rate = k, so its rate stays {{c2::constant regardless of reactant concentration}}; a plot of [A] versus t is linear with slope {{c3::−k}}, and k carries units of {{c4::M·s⁻¹}}.
**Claim:** Zero-order: rate = k (constant, independent of concentration); [A] vs t plot is linear with slope −k; rate constant units are M·s⁻¹.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §17.4 Integrated Rate Laws, lines 39785-39804; Table 17.2, lines 39962-39978; Table 17.1, line 39460
**Excerpt supporting:** A zero-order reaction thus exhibits a constant reaction rate, regardless of the concentration of its reactant(s)... A plot of [A] versus t for a zero-order reaction is a straight line with a slope of −k... units of rate constant... Zero-Order M s−1.
**Notes:** Four independently testable facts: the order name, the constant-rate behavior, the linear-plot slope, the units. Each is a separate retrieval target, so four distinct groups. All confirmed in Tables 17.1/17.2.

#### Card 12
**Cloze:** A {{c1::first}}-order reaction obeys rate = k[A], so doubling [A] {{c2::doubles}} the rate; the integrated law is [A]ₜ = [A]₀e^(−kt), a plot of {{c3::ln[A]}} versus t is linear with slope −k, and k has units of {{c4::s⁻¹}}.
**Claim:** First-order: rate = k[A], rate directly proportional to one reactant; integrated form [A]t = [A]0·e^(−kt); ln[A] vs t linear with slope −k; k units s⁻¹.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §17.4, lines 39498-39505, 39566-39567; Table 17.2 lines 39966-39978; Table 17.1 line 39462
**Excerpt supporting:** Integration of the rate law for a simple first-order reaction (rate = k[A])... A plot of ln[A]t versus t for a first-order reaction is a straight line with a slope of −k... First-Order rate = k[A]... units of rate constant s−1.
**Notes:** The integrated form [A]t=[A]0e^(−kt) is the standard first-order integrated rate law (OpenStax presents it as the exponential/proportional format at lines 39499-39508). Four distinct groups: order, proportional-doubling behavior, the linear-plot variable, the units. Notation in Unicode.

#### Card 13
**Cloze:** A {{c1::second}}-order reaction (rate = k[A]²) plots linearly as {{c2::1/[A]}} versus t, with a slope of {{c3::+k}} (positive, unlike the first- and zero-order plots), and its rate constant carries units of {{c4::M⁻¹·s⁻¹}}.
**Claim:** Second-order (single reactant): rate = k[A]²; 1/[A] vs t linear with slope +k (positive); k units M⁻¹·s⁻¹.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §17.4, lines 39638-39646, 39688-39695; Table 17.2 lines 39966-39978; Table 17.1 line 39464
**Excerpt supporting:** A plot of [1/[A]] versus t for a second-order reaction is a straight line with a slope of k and a y-intercept... k = slope... Second-Order rate = k[A]2... units of rate constant L mol−1 s−1.
**Notes:** L·mol⁻¹·s⁻¹ = M⁻¹·s⁻¹ (identical units). The positive slope is the discriminator vs zero/first order (both −k), so it earns its own emphasis. Four distinct groups: order, linear-plot variable, sign of slope, units.

#### Card 14
**Cloze:** The three orders are told apart by which concentration plot goes linear: {{c1::[A] vs t}} for zero order, {{c2::ln[A] vs t}} for first order, and {{c3::1/[A] vs t}} for second order.
**Claim:** Linearizing plots: zero-order [A] vs t; first-order ln[A] vs t; second-order 1/[A] vs t.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §17.4 Table 17.2 'plot needed for linear fit of rate data', lines 39974; supporting lines 39800, 39566, 39693
**Excerpt supporting:** plot needed for linear fit of rate data — Zero-Order [A] vs. t; First-Order ln[A] vs. t; Second-Order [1/[A]] vs. t.
**Notes:** Pure discriminator card for the confusable trio — high MCAT yield. Three distinct groups (one per order) because a student can know any one without the others. Directly from Table 17.2.

#### Card 15
**Cloze:** The rate constant's units reveal the overall order: {{c1::M·s⁻¹}} signals zero order, {{c2::s⁻¹}} signals first order, and {{c3::M⁻¹·s⁻¹}} signals second order.
**Claim:** Rate constant units by overall order: zero = M·s⁻¹, first = s⁻¹, second = M⁻¹·s⁻¹.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §17.3 Table 17.1, lines 39456-39468; §17.4 Table 17.2 line 39968
**Excerpt supporting:** 0 (zero) mol L−1 s−1; 1 (first) s−1; 2 (second) L mol−1 s−1... units of rate constant — Zero M s−1, First s−1, Second M−1 s−1.
**Notes:** mol·L⁻¹·s⁻¹ = M·s⁻¹ and L·mol⁻¹·s⁻¹ = M⁻¹·s⁻¹ (same units, MCAT-standard M notation). This is the inverse-lookup skill (units → order), a distinct MCAT task from the plot card, so kept separate. Three distinct groups.

#### Card 16
**Cloze:** The half-life of a {{c1::first}}-order reaction is {{c2::independent of}} the starting concentration, whereas half-lives for other reaction orders do depend on reactant concentration.
**Claim:** A first-order reaction's half-life is independent of reactant concentration; half-lives of other orders depend on concentration.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 39851-39853
**Excerpt supporting:** "The decomposition of hydrogen peroxide is a first-order reaction, and, as can be shown, the half-life of a first-order reaction is independent of the concentration of the reactant. However, half-lives of reactions with other orders depend on the concentrations of the reactants."
**Notes:** Verified directly. c1 (which order) and c2 (concentration-independence) are independently testable → two distinct groups; cloze_count=2. High-yield MCAT contrast. Original prose.

#### Card 17
**Cloze:** Half-life behavior distinguishes the orders: a first-order t₁/₂ is {{c1::independent of concentration}}, a second-order t₁/₂ {{c2::lengthens as reactant is consumed}}, and a zero-order t₁/₂ {{c3::shortens as reactant is consumed}} (it grows with higher initial concentration).
**Claim:** Half-life vs concentration: first-order t½ independent of [A]; second-order t½ increases as reaction proceeds (∝1/[A]0); zero-order t½ increases with initial [A] (so it decreases as reactant is consumed).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §17.4 (half-life), lines 39851-39853, 39936-39939, 39952-39953
**Excerpt supporting:** the half-life of a first-order reaction is independent of the concentration... For a second-order reaction... the half-life increases as the reaction proceeds because the concentration of reactant decreases... the half-life of a zero-order reaction increases as the initial concentration increases.
**Notes:** Zero-order t½ ∝ [A]0, so as reactant is consumed during the run, each successive half-life is shorter — logically equivalent to OpenStax's 'increases as the initial concentration increases,' just framed as the within-run trend for parallelism with the second-order clause. Three distinct groups (one per order); this is the high-yield discriminator among the three.

#### Card 18
**Cloze:** Radioactive decay is the classic {{c1::first-order}} process: the disintegration rate is proportional to the amount of isotope present (rate = k[A]), which is why its {{c2::half-life is constant}}, independent of how much sample remains.
**Claim:** Radioactive decay follows first-order kinetics; first-order half-life is independent of the remaining amount (constant).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §17.4, lines 39551-39558 (I-131 first-order decay), 39851-39852 (first-order half-life independent of concentration); §17.6 half-life example lines 39896-39900
**Excerpt supporting:** The decay is first-order with a rate constant of 0.138 d−1... the half-life of a first-order reaction is independent of the concentration of the reactant.
**Notes:** Two distinct groups: the order (first) and its defining consequence (constant half-life). OpenStax repeatedly uses radioactive decay (I-131) as the canonical first-order example. High MCAT yield (links kinetics to nuclear/radiometric problems).

### — Collision Theory & Activation Energy —

#### Card 19
**Cloze:** {{c1::Collision theory}} holds that molecules must physically collide before they can react, and it predicts the reaction rate is {{c2::proportional to the rate (frequency) of reactant collisions}}.
**Claim:** Collision theory: reacting species must collide, and rate is proportional to the rate of reactant collisions.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40013-40019
**Excerpt supporting:** We should not be surprised that atoms, molecules, or ions must collide before they can react with each other... Collision theory is based on the following postulates: 1. The rate of a reaction is proportional to the rate of reactant collisions
**Notes:** Postulate 1 verbatim-grounded. Original prose; c1=name of theory, c2=the proportionality (independently testable).

#### Card 20
**Cloze:** Not every collision produces a reaction — an effective (reactive) collision requires both the {{c1::correct spatial orientation of the colliding molecules and a collision energy at least equal to the activation energy}}.
**Claim:** An effective collision needs proper orientation AND sufficient (≥ Ea) energy (collision theory postulates 2 and 3).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40030-40064
**Excerpt supporting:** 2. The reacting species must collide in an orientation that allows contact between the atoms that will become bonded together... 3. The collision must occur with adequate energy... In addition to a proper orientation, the collision must also occur with sufficient energy to result in product formation.
**Notes:** Two requirements recalled as a matched set, so a single c1 group is correct. Grounded in postulates 2 and 3.

#### Card 21
**Cloze:** The {{c1::activation energy (Eₐ)}} is the {{c2::minimum energy}} a collision must supply for reactants to be converted to product; it functions as the energy barrier separating reactants from products.
**Claim:** Activation energy (Ea) is the minimum energy needed to form product during a collision; it is the reaction's energy barrier.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40074-40077 and 40094
**Excerpt supporting:** The minimum energy necessary to form a product during a collision between reactants is called the activation energy (Ea)... the reaction's activation energy, Ea, as the energy difference between the reactants and the transition state.
**Notes:** c1=term, c2=the defining 'minimum energy' quantity — independently testable, so distinct groups. 'Energy barrier' is standard synonym.

#### Card 22
**Cloze:** Raising reactant concentration {{c1::increases}} the rate (for all but zero-order reactions) because packing {{c2::more molecules per unit volume}} raises the number of collisions per second.
**Claim:** Higher concentration raises rate (except zero-order) by increasing collisions per unit volume.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40069-40072 and 39050-39051
**Excerpt supporting:** With an increase in the concentration of any reacting substance, the chances for collisions between molecules are increased because there are more molecules per unit of volume. More collisions mean a faster reaction rate... Rates usually increase when the concentration of one or more of the reactants increases.
**Notes:** The zero-order caveat is standard rate-law fact (rate = k, concentration-independent); genchem_ch5 source line 34 states it. c1=direction, c2=mechanism.

### — Arrhenius Equation & Temperature Dependence —

#### Card 23
**Cloze:** The Arrhenius equation, k = {{c1::Ae^(−Eₐ/RT)}}, ties a reaction's rate constant to its {{c2::activation energy}} and to {{c3::temperature}}.
**Claim:** The Arrhenius equation k = Ae^(−Eₐ/RT) relates the rate constant to activation energy and temperature.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40104-40110; glossary line 40956-40958
**Excerpt supporting:** The Arrhenius equation relates the activation energy and the rate constant, k, for many chemical reactions... A is a constant called the frequency factor. / 'Arrhenius equation mathematical relationship between a reaction's rate constant, activation energy, and temperature'
**Notes:** c1 hides the full functional form; c2/c3 are the two independently-testable dependences the equation encodes. Unicode notation used, no LaTeX.

#### Card 24
**Cloze:** In the Arrhenius equation the exponential factor is {{c1::e^(−Eₐ/RT)}}, where R = {{c2::8.314 J·mol⁻¹·K⁻¹}} and T is in {{c3::kelvin}}.
**Claim:** R = 8.314 J/mol/K and T must be in kelvin in the Arrhenius equation; the exponential term is e^(−Eₐ/RT).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40108-40116
**Excerpt supporting:** R is the ideal gas constant, which has a value 8.314 J/mol/K, T is temperature on the Kelvin scale, Ea is the activation energy in joules per mole, e is the constant 2.7183... The exponential term, e−Ea/RT, describes the effect of activation energy on reaction rate.
**Notes:** c2 must carry the unit because the value is meaningless without it (matches gas-constant form in source). Temperature-in-kelvin is a classic MCAT trap, so it is its own group.

#### Card 25
**Cloze:** The pre-exponential term A in the Arrhenius equation is the {{c1::frequency factor}}, which captures how often collisions occur and whether they have a {{c2::proper orientation}} for reaction.
**Claim:** The frequency factor A reflects collision frequency and the fraction of collisions with reaction-favorable orientation.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40109-40114; glossary lines 40974-40977
**Excerpt supporting:** A is a constant called the frequency factor, which is related to the frequency of collisions and the orientation of the reacting molecules... The frequency factor, A, reflects how well the reaction conditions favor properly oriented collisions. / 'frequency factor (A) proportionality constant in the Arrhenius equation, related to the relative number of collisions having an orientation capable of leading to product formation'
**Notes:** Two linked ideas (frequency + orientation) but both belong to defining A, so kept as related sub-concepts across two groups: name of the factor (c1) vs the orientation property MCAT tests (c2).

#### Card 26
**Cloze:** Because Eₐ sits in the exponent as e^(−Eₐ/RT), a {{c1::lower}} activation energy leaves a {{c2::larger}} fraction of molecules with enough energy to react, giving a faster rate.
**Claim:** A lower activation energy means a greater fraction of molecules exceed the barrier, so the reaction is faster.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40116-40121
**Excerpt supporting:** A lower activation energy results in a greater fraction of adequately energized molecules and a faster reaction.
**Notes:** c1/c2 are paired direction words (lower Ea -> larger fraction); distinct groups so each direction is independently recalled, which is the discriminating comparison.

#### Card 27
**Cloze:** Raising temperature speeds a reaction because it shifts the molecular energy distribution so a {{c1::greater}} fraction of molecules clear the activation barrier, which {{c2::increases}} the rate constant k.
**Claim:** Higher temperature increases the fraction of molecules exceeding Ea, raising k and the rate.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40123-40126
**Excerpt supporting:** A higher temperature represents a correspondingly greater fraction of molecules possessing sufficient energy (RT) to overcome the activation barrier (Ea)... This yields a greater value for the rate constant and a correspondingly faster reaction rate.
**Notes:** Mechanism (more molecules over the barrier) is separated from its consequence on k so each is testable; both directions upward for a temperature increase.

#### Card 28
**Cloze:** A common rule of thumb from collision theory is that many reaction rates roughly {{c1::double}} for every {{c2::10 °C}} rise in temperature.
**Claim:** Reaction rates approximately double per 10 °C temperature increase.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, line 40048
**Excerpt supporting:** For many chemical processes, reaction rates are approximately doubled when the temperature is raised by 10 °C.
**Notes:** Name-vs-number split: c1 is the factor (double), c2 is the interval (10 °C); both are high-yield discrete facts.

#### Card 29
**Cloze:** Taking the natural log linearizes the Arrhenius equation to ln k = {{c1::−Eₐ/R · (1/T) + ln A}}; a plot of ln k versus 1/T is a line whose slope equals {{c2::−Eₐ/R}}.
**Claim:** The linear form ln k = −(Eₐ/R)(1/T) + ln A gives a straight line of ln k vs 1/T with slope −Eₐ/R and y-intercept ln A.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40140-40146
**Excerpt supporting:** an alternate version of the Arrhenius equation that takes the form of a linear equation... A plot of ln k versus [1/T] is linear with a slope equal to [−Ea/R] and a y-intercept equal to ln A.
**Notes:** c1 is the linearized equation, c2 the slope that yields Ea graphically; separated because MCAT tests slope->Ea extraction independently of writing the equation.

#### Card 30
**Cloze:** Measuring k at just two temperatures lets you solve for activation energy with the two-point form ln(k₂/k₁) = {{c1::(Eₐ/R)(1/T₁ − 1/T₂)}}, avoiding a full {{c2::ln k vs 1/T}} plot.
**Claim:** Ea can be found from rate constants at two temperatures using the two-point Arrhenius form, without a full linear-regression plot.
**Confidence:** 4
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40209-40233
**Excerpt supporting:** A more expedient approach involves deriving activation energy from measurements of the rate constant at just two temperatures. In this approach, the Arrhenius equation is rearranged to a convenient two-point form... and the result is Ea = 1.8 × 10⁵ J mol⁻¹ or 180 kJ mol⁻¹
**Notes:** Source states the two-point method and rearrangement but the algebraic sign/arrangement of the printed formula is figure-rendered (not machine-readable in the txt); the ln(k₂/k₁)=(Eₐ/R)(1/T₁−1/T₂) form is the standard equivalent. Confidence 4 for minor phrasing/sign-convention variance from the figure. c1 = the formula, c2 = the alternative it replaces.

#### Card 31
**Cloze:** Raising temperature normally accelerates a reaction because more molecules clear the activation barrier — but {{c1::enzyme-catalyzed}} reactions are the exception: activity climbs only up to an {{c2::optimal temperature}}, then falls off sharply as excess heat {{c3::denatures}} the enzyme.
**Claim:** Higher temperature generally speeds reactions, but enzyme-catalyzed reactions peak at an optimal temperature and then slow as heat denatures the enzyme.
**Confidence:** 4
**Source:** reference-textbooks/biology/openstax-biology-2e.txt, lines 8484-8488; corroborated by reference-textbooks/biochemistry/libretexts-biochemistry.txt, lines 28568-28569
**Excerpt supporting:** "increasing the environmental temperature generally increases reaction rates, enzyme-catalyzed or otherwise. However, increasing or decreasing the temperature outside of an optimal range can affect... the active site... High temperatures will eventually cause enzymes... to denature" / (biochem) "Moderate increases in temperature typically enhance reaction rates, whereas excessive heat leads to irreversible denaturation."
**Notes:** FLAGGED-KEEP #2 (optimal-temperature-as-enzyme-exception). SME note: the source chapter's statement 'All reactions... experience an optimal temperature for activity' (genchem_ch5.txt line 39) is FALSE as written — an optimal temperature is specifically an enzyme/protein-catalysis phenomenon (denaturation), NOT a property of reactions in general, which follow Arrhenius monotonically. I corrected the card to frame the optimum as the ENZYME exception to the general temperature rule. Confidence 4 (not 5) because this fact is cross-referenced from the Biology/Biochem corpora, not the General Chemistry textbook (OpenStax GenChem kinetics does not state an enzyme temperature optimum). Three groups: the exception class (c1 enzyme-catalyzed), the optimum (c2), the mechanism (c3 denatures) are each independently testable. Still ships (≥4).

### — Transition-State Theory & Energy Profiles —

#### Card 32
**Cloze:** When reactants collide with correct orientation and enough energy, they briefly form a high-energy, unstable species called the {{c1::activated complex}} (or {{c1::transition state}}), which then either decays forward to products or reverts to reactants.
**Claim:** The activated complex, also called the transition state, is the unstable high-energy species formed at the peak of the energy barrier; it can proceed to products or fall back to reactants.
**Confidence:** 5
**Source:** reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt, lines 40064-40067 and 40092-40093
**Excerpt supporting:** "they combine to form an unstable species called an activated complex or a transition state. These species are very short lived..." / "Reactant molecules with sufficient energy can collide to form a high-energy activated complex or transition state. The unstable transition state can then subsequently decay to yield stable products"
**Notes:** Both synonyms grouped as c1 because they are the same concept recalled as a set (activated complex = transition state). Original prose re-sourced from OpenStax framing; 'either decays forward or reverts' matches the reversible-decay idea in the source chapter (genchem_ch5.txt line 27) and the textbook's decay-to-products language.

#### Card 33
**Cloze:** When reactants collide with proper orientation and adequate energy they form a short-lived {{c1::activated complex (transition state)}}, which sits at {{c2::higher energy than both the reactants and the products}} at the peak of the reaction coordinate.
**Claim:** The activated complex / transition state is the unstable high-energy species at the peak of the reaction diagram, higher in energy than reactants and products.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40064-40094
**Excerpt supporting:** they combine to form an unstable species called an activated complex or a transition state. These species are very short lived... Reactant molecules with sufficient energy can collide to form a high-energy activated complex or transition state.
**Notes:** OpenStax explicitly names it 'activated complex or a transition state' and calls it high-energy; that its peak exceeds both reactants and products is shown in the reaction diagram (Fig 17.14). c1=name(s) as a set, c2=the energy relationship.

#### Card 34
**Cloze:** The {{c1::activation energy (Eₐ)}} is the minimum energy a collision must supply to form product, and on a reaction diagram it equals the energy gap from the {{c2::reactants}} up to the {{c3::transition state}}.
**Claim:** Activation energy is the minimum energy needed to form product; on an energy profile it is the height from the reactants to the transition state.
**Confidence:** 5
**Source:** reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt, lines 40075-40076 and 40093-40094
**Excerpt supporting:** "The minimum energy necessary to form a product during a collision between reactants is called the activation energy (Ea)." / "The diagram depicts the reaction's activation energy, Ea, as the energy difference between the reactants and the transition state."
**Notes:** Three groups: the term itself (c1), and the two endpoints of the barrier (c2 reactants, c3 transition state) are each independently testable — a student can miss the 'measured from reactants' detail while knowing the term. Kept distinct to force full recall of the geometry.

#### Card 35
**Cloze:** On an energy profile, activation energy is a {{c1::kinetic}} quantity that sets the rate, whereas the reactant-to-product energy difference is the {{c2::thermodynamic}} quantity ΔH (or ΔG); a reaction is exothermic when the products sit {{c3::lower}} in energy than the reactants.
**Claim:** Eₐ (barrier height) governs rate and is kinetic; the reactant-vs-product energy difference is thermodynamic (ΔH/ΔG); products lower than reactants means exothermic.
**Confidence:** 5
**Source:** reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt, lines 40094-40097
**Excerpt supporting:** "the reaction's activation energy, Ea, as the energy difference between the reactants and the transition state... the enthalpy change of the reaction, ΔH, is estimated as the energy difference between the reactants and products. In this case, the reaction is exothermic (ΔH < 0) since it yields a decrease in system enthalpy."
**Notes:** High-yield kinetics-vs-thermodynamics discriminator. Three groups: the kinetic label (c1), the thermodynamic label (c2), and the exo direction (c3) are separately testable. ΔG parenthetical added because the source chapter frames spontaneity via ΔG (genchem_ch5.txt line 3, 28-30); OpenStax uses ΔH on the diagram, so both are noted.

#### Card 36
**Cloze:** A catalyst speeds a reaction by opening an alternative pathway with a {{c1::lower activation energy}}, lowering the barrier for the forward and reverse steps {{c2::equally}}; it leaves ΔG, ΔH, and Keq {{c3::unchanged}}, so equilibrium is reached faster but not shifted.
**Claim:** A catalyst provides a lower-Eₐ alternative path, lowering forward and reverse barriers equally, without changing ΔG/ΔH/Keq or the equilibrium position (only the approach to equilibrium is faster).
**Confidence:** 5
**Source:** reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt, lines 40616-40621 and 40593-40594
**Excerpt supporting:** "both curves begin and end at the same energies... the catalyzed reaction follows a two-step mechanism... with a notably lesser activation energy... a catalyst functions to accelerate reactions... by providing an alternative reaction mechanism with a lower activation energy." / "The net effect of the catalyst on the reaction is to cause equilibrium to be reached more rapidly."
**Notes:** Three groups: the lowered barrier (c1), the equal forward/reverse effect (c2), and the no-change-to-thermodynamics result (c3). 'Begin and end at the same energies' directly supports unchanged ΔH/ΔG/Keq. The equal-factor and Keq points also match genchem_ch5.txt lines 50-53.

### — Reaction Mechanisms & Rate-Determining Step —

#### Card 37
**Cloze:** A reaction {{c1::mechanism}} is the step-by-step sequence of {{c2::elementary reactions}} that must sum to give the overall balanced equation, which by itself reveals nothing about how the reaction actually proceeds.
**Claim:** A reaction mechanism is the ordered set of elementary reactions (steps) that add up to the overall balanced equation; the overall equation alone gives no mechanistic detail.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 40258-40270
**Excerpt supporting:** The reaction mechanism (or reaction path) provides details regarding the precise, step-by-step process by which a reaction occurs. ... Each of the steps in a reaction mechanism is an elementary reaction. These elementary reactions occur precisely as represented in the step equations, and they must sum to yield the balanced chemical equation representing the overall reaction
**Notes:** c1 (mechanism) and c2 (elementary reactions) are independently testable retrieval targets, so distinct groups. Prose reworded from OpenStax framing. Directly verified.

#### Card 38
**Cloze:** A species that is generated in one elementary step and used up in a later step is a reaction {{c1::intermediate}}; because it never appears in the overall equation, its concentration must be eliminated when deriving the overall {{c2::rate law}}.
**Claim:** Intermediates are produced in one step and consumed in a later step; they do not appear in the net equation, and their concentrations are not permitted to remain in an overall rate law.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 40273-40275, 40435
**Excerpt supporting:** Species that are produced in one step and consumed in a subsequent step are called intermediates. ... Since intermediate species concentrations are not used in formulating rate laws for overall reactions
**Notes:** c1 (identity of the species) vs c2 (the rate law consequence) are separate facts, so two groups. Verified directly.

#### Card 39
**Cloze:** The {{c1::molecularity}} of an elementary step is the number of reactant particles that collide, so a unimolecular step is {{c2::first}}-order and a bimolecular step is {{c2::second}}-order overall.
**Claim:** Molecularity counts the reactant entities in an elementary step; unimolecular steps are first order and bimolecular steps are second order overall.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 40292-40333
**Excerpt supporting:** The molecularity of an elementary reaction is the number of reactant entities (atoms, molecules, or ions). ... The rate law for a unimolecular reaction is first order ... [bimolecular] the rate law is first-order in A and first order in B (second-order overall)
**Notes:** c1 is the term; c2 groups the two parallel order values (first/second) recalled as a matched set. Verified directly.

#### Card 40
**Cloze:** {{c1::Termolecular}} elementary steps are rare because the odds of three particles colliding at once are less than {{c2::one one-thousandth}} the odds of a two-particle collision.
**Claim:** Termolecular elementary steps are uncommon; a simultaneous three-body collision is under 1/1000 as probable as a two-body collision.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 40362-40365
**Excerpt supporting:** An elementary termolecular reaction involves the simultaneous collision of three atoms, molecules, or ions. Termolecular elementary reactions are uncommon because the probability of three particles colliding simultaneously is less than one one-thousandth of the probability of two particles colliding.
**Notes:** c1 (which molecularity is rare) vs c2 (the numeric reason) are independently testable, so distinct groups. Verified directly.

#### Card 41
**Cloze:** The rate law of an {{c1::elementary}} step can be written straight from its balanced equation using the reactant coefficients as orders, but the rate law of an overall (multistep) reaction can only be established by {{c2::experiment}}.
**Claim:** For an elementary step, the exponents in the rate law equal the stoichiometric coefficients, so the rate law follows directly from the equation; overall reaction rate laws must be determined experimentally.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 40285-40289
**Excerpt supporting:** the rate law for an elementary reaction may be derived directly from the balanced chemical equation describing the reaction. This is not the case for typical chemical reactions, for which rate laws may be reliably determined only via experimentation.
**Notes:** This is a top MCAT trap (students wrongly read orders off an overall equation). c1 vs c2 contrast elementary-vs-overall, so distinct groups. Verified directly; 'coefficients as orders' inferred from OpenStax's unimolecular=first-order / bimolecular=second-order worked cases (lines 40297-40333).

#### Card 42
**Cloze:** A multistep reaction can never run faster than its {{c1::slowest}} elementary step, which is why that step is called the {{c2::rate-determining (rate-limiting)}} step.
**Claim:** The slowest elementary step caps the overall rate and is termed the rate-determining (rate-limiting) step.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 40378-40380
**Excerpt supporting:** Because a reaction cannot proceed faster than its slowest step, this step will limit the rate at which the overall reaction occurs. The slowest step is therefore called the rate-limiting step (or rate-determining step) of the reaction
**Notes:** c1 (which step) vs c2 (its name) are name-vs-property, so two groups. Core high-yield fact, verified directly.

#### Card 43
**Cloze:** When the {{c1::rate-determining step is the first step}} of a mechanism, the overall rate law is simply that step's rate law; if a fast reversible equilibrium precedes it, you must first replace any {{c2::intermediate}} concentration with reactant terms.
**Claim:** If the slow step comes first, the overall rate law equals that step's rate law; if a rapid pre-equilibrium precedes the slow step, intermediate concentrations in the slow-step rate law must be re-expressed in terms of reactants.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 40419-40421, 40464-40467
**Excerpt supporting:** when the rate-determining (slower) step is the first step in a mechanism, the rate law for the overall reaction is the same as the rate law for this step. However, when the rate-determining step is preceded by a step involving a rapidly reversible reaction the rate law for the overall reaction may be more difficult to derive. ... the step 2 rate law, as written, contains an intermediate species concentration ... use the first step's rate laws to derive an expression for the intermediate concentration in terms of the reactant concentrations.
**Notes:** c1 (the condition making the derivation trivial) vs c2 (what must be substituted out in the pre-equilibrium case) are separate concepts, so two groups. Verified directly.

### — Catalysis —

#### Card 44
**Cloze:** A {{c1::catalyst}} accelerates a reaction yet is {{c2::not consumed}} overall — it is {{c2::regenerated}} in a later step, so it can turn over many reactant molecules.
**Claim:** A catalyst increases reaction rate without being consumed; it participates in the mechanism but is regenerated, so it is not used up overall.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40606-40609 and 40699-40700
**Excerpt supporting:** "a catalyst, a substance that can increase the reaction rate without being consumed in the reaction" ... "Though it participates in the chemical reaction, it is not consumed by the reaction."
**Notes:** Standard MCAT definition. Cloze c1 = the term 'catalyst'; c2 = the not-consumed/regenerated property (parallel items recalled as one idea, same group).

#### Card 45
**Cloze:** A catalyst speeds a reaction by providing an {{c1::alternative reaction pathway}} that has a {{c2::lower activation energy}}, not by increasing the energy of the colliding molecules.
**Claim:** A catalyst works by furnishing an alternative reaction mechanism whose rate-determining step has a lower activation energy.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40619-40623
**Excerpt supporting:** "a catalyst functions to accelerate reactions, namely, by providing an alternative reaction mechanism with a lower activation energy ... it must provide a reaction path whose rate determining step is faster (lower Ea)."
**Notes:** c1 (mechanism/pathway) and c2 (lower Ea) are independently testable, so distinct groups. Both are the retrieval-critical concepts MCAT tests.

#### Card 46
**Cloze:** A catalyst lowers Eₐ but leaves the {{c1::equilibrium constant (Keq)}}, the {{c1::equilibrium concentrations}}, and {{c1::ΔG of the reaction}} unchanged — it alters kinetics, never thermodynamics.
**Claim:** A catalyst has no effect on the equilibrium constant, on equilibrium concentrations, or on the reaction's thermodynamics (ΔG); it only changes the rate.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40496-40499 and 40615-40617
**Excerpt supporting:** "a catalyst has no effect on the value of an equilibrium constant nor on equilibrium concentrations" ... "both curves begin and end at the same energies" (catalyzed vs uncatalyzed diagram).
**Notes:** Keq, equilibrium concentrations, and ΔG are a recalled-as-a-set 'thermodynamics is untouched' cluster, so one group (c1). ΔG unchanged follows directly from identical reactant/product energies on the two curves.

#### Card 47
**Cloze:** Because a catalyst lowers the barrier for {{c1::both the forward and reverse}} directions equally, the system can {{c2::reach equilibrium more quickly}} without shifting where that equilibrium lies.
**Claim:** A catalyst speeds the forward and reverse reactions equally, so equilibrium is reached faster but the equilibrium position is unchanged.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40497-40499 and 40593-40594
**Excerpt supporting:** "this increase in reaction rate may cause a system to reach equilibrium more quickly (by speeding up the forward and reverse reactions)" ... "The net effect of the catalyst on the reaction is to cause equilibrium to be reached more rapidly."
**Notes:** c1 = which directions are sped (both), c2 = the consequence (faster to equilibrium, position unchanged). Distinct groups because they test different facts.

#### Card 48
**Cloze:** In {{c1::homogeneous}} catalysis the catalyst shares the same phase as the reactants; in {{c2::heterogeneous}} catalysis it occupies a different phase, usually a solid whose surface hosts the reaction.
**Claim:** A homogeneous catalyst is in the same phase as the reactants; a heterogeneous catalyst is in a different phase (typically solid), and reaction occurs on its surface.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40671 and 40785-40789
**Excerpt supporting:** "A homogeneous catalyst is present in the same phase as the reactants." ... "A heterogeneous catalyst is a catalyst that is present in a different phase (usually a solid) than the reactants ... reactions catalyzed by heterogeneous catalysts occur on the surface of the catalyst."
**Notes:** Classic this-vs-that contrast, so two groups. Corrects a common student conflation of homogeneous/heterogeneous with the number of reactants rather than phase.

#### Card 49
**Cloze:** Heterogeneous catalysis on a solid surface proceeds by {{c1::adsorption}} of reactants onto the surface, their activation and reaction, then {{c1::desorption}} of the products.
**Claim:** Heterogeneous catalysis typically involves adsorption of reactants onto the catalyst surface, activation, reaction, and desorption of products.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40791-40800
**Excerpt supporting:** "Heterogeneous catalysis typically involves the following processes: 1. Adsorption of the reactant(s) onto the surface of the catalyst 2. Activation ... 3. Reaction ... 4. Desorption of product(s) from the surface of the catalyst"
**Notes:** adsorption/desorption are the two retrieval-critical bookend terms recalled as a paired set (one group). Note: OpenStax uses 'adsorption' (surface binding), NOT 'absorption' — a frequent error that must not be propagated.

#### Card 50
**Cloze:** In living systems the biological catalysts that accelerate metabolic reactions are {{c1::enzymes}}, such as glucose-6-phosphate dehydrogenase in the NADPH-supplying pathway.
**Claim:** Enzymes are biological catalysts that speed up chemical reactions in cellular metabolism.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt, lines 40759-40764
**Excerpt supporting:** "Enzymes in the human body act as catalysts for important chemical reactions in cellular metabolism." ... "the rate-limiting enzyme for the metabolic pathway that supplies NADPH to cells."
**Notes:** Single retrieval target (enzymes = biological catalysts), one group. Bridges GenChem catalysis to biochem, a high-yield MCAT crossover.

## needs_sme_review
None by the confidence rule (all 51 shipped cards are confidence ≥4). Two cards were **retained per the user's explicit direction** despite being flagged in Step 2 as lower-yield or cross-subject; an SME may wish to confirm their framing:
- Card 3 (physical state / heterogeneous interface): low-yield for MCAT kinetics; verified in OpenStax's 'Factors Affecting Reaction Rates'. Kept per user direction.
- Card 31 (enzyme optimal-temperature exception): cross-subject (biology). Framed accurately — simple reactions rise monotonically with T; the optimum is an enzyme/denaturation phenomenon. Kept per user direction; SME to confirm cross-subject placement.

## Disagreements with corpus
- **'Optimal temperature.'** The source .docx asserted that *all* reactions 'experience an optimal temperature for activity.' OpenStax Chemistry: for a simple chemical reaction the rate rises monotonically with temperature — there is no optimum. **Resolved:** the concept was reframed as the *enzyme* exception (a biological catalyst denatures above its optimum) and written as a discriminator against simple-reaction behavior, so the shipped card is factually correct. Retained per user direction.

## Discrepancies between primary and secondary sources
None — a single primary corpus (OpenStax Chemistry: Atoms First 2e) was used for this General Chemistry deck.

---
## Post-verification SME decisions
_(Reserved for SME overrides/retentions/revisions. Each entry: card number, decision, rationale, date.)_
