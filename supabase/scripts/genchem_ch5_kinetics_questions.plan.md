<!-- Step 1 pre-flight record for GenChem Ch5, Chemical Kinetics — the first chem/phys chapter
     under prompt v7. Cross-subject AAMC scope verdict, live-bank boundary audit (Biochem Ch2
     enzymes and Ch12 thermodynamics are the main owners), the GenChem Ch6 equilibrium forward
     reservation, the nuclear seam ruling, source-doc errata, and the v7 house conventions. -->

# GenChem Ch5 Chemical Kinetics — Sizing Report (prompt v7)

## Verification of load-bearing claims (all greps run against /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw)

VERIFIED, with file:line evidence:
- `biochemistry_ch2_enzymes_batch1.sql` keys, all confirmed at source: Q1 "It lowers the activation energy" (line 9), Q3 "ΔG unchanged" (line 35), Q4 Pauling TS-stabilization (line 48), Q5 "peak is lower; endpoints unchanged" (line 61), Q6 arrow X/Y (line 74), Q7 statements I+II (line 93), Q25 add-enzyme-at-equilibrium → "no net change" (line 335).
- `biochemistry_ch2_enzymes_batch3.sql`: optimal-temperature key (line 217), denaturation fall-off (line 230), curve shape (line 243), +10 °C → "rate increases" with the doubling rule cited (line 282). Ch2 totals exactly 100 questions (`grep -c "VALUES ('bio_biochem'"` across 4 batches = 100).
- `biochemistry_ch2_enzymes_batch2.sql` line 230: the first-to-zero-order saturation switch is keyed (key B) in enzyme framing.
- `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql` line 196: glucose + O2, ΔG ≈ −2870 kJ/mol, key A = "ΔG tells you only whether… not how fast; rate set by the activation-energy barrier". The qualitative prize is confirmed TAKEN.
- Chem/phys bank negatives, word-boundary greps across all `genchem_*.sql` and `orgchem_*.sql`: ZERO hits for `\brate law\b`, `\brate constant\b`, `\bhalf-?life\b`, `\bcollision`, `\breaction order\b`, first/zero/second-order. "Arrhenius" in the question bank is exclusively the acid-base definition (`genchem_ch10_batch2.sql` lines 15–142); kinetics-Arrhenius exists only in flashcard files. Kinetics territory in the question bank is genuinely virgin.
- Ch5 deck (`supabase/seeds/general_chemistry_ch5_chemical_kinetics_flashcards.sql`, 51 cards): slope signs −k/−k/+k stated exactly (lines 81/83/85), TS "higher energy than both the reactants and the products" (line 131), first-order t½ concentration-independent (lines 91/93), radioactive decay as classic first-order (line 95), frequency factor = collision frequency + orientation (line 113) — the deck does NOT carry the source's "more molecules in the vessel" looseness, enzyme-optimum exception card (line 125), enzymes-as-biological-catalysts card (line 169).
- Ch6 equilibrium deck claims kinetic-vs-thermodynamic control as cards 25–27 (lines 111–118) and catalyst-no-shift (line 109) — confirmed.
- Physics Ch9 deck owns t½ = 0.693/λ and decay subtopics 9.5/9.6 (lines 5, 185, 188) — confirmed.
- AAMC outline: 5E topic name at lines 3092–3093 verbatim "Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)" with U+2015; the 5E preamble enumerates rate factors as concentration/temperature/catalyst only (no solvent); 4E Atomic Nucleus (PHY, GC) owns "Half-life, exponential decay, semi-log plots" (lines 2624–2632). Word-boundary checks: outline has ZERO hits for "collision", "exergonic", "endergonic"; only "intermediate" hit is Intermediate filaments (line 1509). Cartographer's NOT_FOUND verdicts confirmed.
- House conventions in `genchem_ch10_batch1.sql`: section 'chem_phys', foundation '5A' + verbatim content_category 'Acid-Base Equilibria (GC, BC)', discipline 'general-chemistry', subtopic-scoped DELETE, 24/24/24/24 answer rebalance across 96 — confirmed; ch10 uses bare "Skill N" tags (16× Skill 1, 38× Skill 2, 10× Skill 4), while `orgchem_ch1_functional_groups_nomenclature_questions.sql` uses full-sentence closers (14 + 1 verified) — Ch5 adopts the v7 full-sentence closer.

## RECOMMENDED COUNT: 72 questions (3 batches × 24, drafter slices of 4)

Kinetics is compact: the 5E kinetics list is ~10 bullets, and this chapter loses more territory to other owners than any prior chem chapter (equilibrium sub-bullets reserved for Ch6, kinetic/thermodynamic control reserved for Ch6, the qualitative kinetics-thermo prize taken by Biochem Ch12, catalyst-lowers-Ea/TS-stabilization/single-peak-diagram/no-Keq-shift recall all taken by Biochem Ch2, enzyme kinetics wholly off-limits). Counting answer-turning points that survive both passes gives ~70–75; forcing 96 (Ch10/Ch12 size) would replicate the ~30% redundancy failure mode. 72 matches Ch11 precedent.

### Unit breakdown (6 subtopics × 12; SHARED subtopic strings for idempotent DELETEs)

| # | Subtopic | Count | Content |
|---|----------|-------|---------|
| 1 | Reaction Rates & Rate Laws | 12 | rate definition, sign convention, −(1/a)d[A]/dt stoichiometric scaling, M/s units, rate = k[A]^x[B]^y, exponents-are-experimental trap |
| 2 | Reaction Order & the Method of Initial Rates | 12 | trial-pair deduction, overall order, computing k from a trial, k units by order (M·s⁻¹ / s⁻¹ / M⁻¹·s⁻¹), zero-order rate = k |
| 3 | Integrated Rate Laws & Half-Life | 12 | which-plot-is-linear, slope signs (−k, −k, +k per deck), exponential decay, t½ = ln 2/k ≈ 0.693/k, t½-by-order discrimination, ≤1 radioisotope-scenery stem |
| 4 | Collision Theory & the Arrhenius Equation | 12 | energy + orientation criteria, Boltzmann-fraction reasoning, k = Ae^(−Ea/RT) qualitative consequences, ln k vs 1/T slope = −Ea/R, two-point comparison (ratio-supplied), frequency factor at definition level only |
| 5 | Energy Profiles, Transition States & Mechanisms | 12 | TS at maximum above both endpoints/cannot be isolated, Ea(fwd) vs Ea(rev), ΔH = Ea(fwd) − Ea(rev) endpoint reading (outline specifies ΔH, not ΔG), multistep diagrams (peaks = TS, valleys = intermediates), RDS = highest barrier, molecularity, rate-law-from-slow-step and mechanism-consistency |
| 6 | Catalysts | 12 | catalyst-vs-intermediate ID in a written mechanism, regeneration, homogeneous vs heterogeneous + adsorption sequence (1–2 recognition items max), equal-factor k_f/k_r mechanism, quantitative Ea-drop effect on k, catalyst in an experimental rate law, catalyst-cannot-make-nonspontaneous-go (quantitative dressing) |

Batch split: B1 = subtopics 1+2 (24), B2 = 3+4 (24), B3 = 5+6 (24). Slices of 4 questions (6 slices/batch). Answer rebalance 18/18/18/18 across the chapter. Skill mix guidance: subtopics 2–3 heavily Skill 4 (data), 1 and 4 mixed Skill 1/2, 5–6 mostly Skill 2.

## The six judgement calls

**1. THE KINETICS-THERMODYNAMICS PRIZE — closed qualitatively, open quantitatively.** Verified: Biochem Ch12 line 196 keys the exact "spontaneous ≠ fast" principle on glucose oxidation, and Ch12 also owns ΔG sign conventions (line 152), ΔG = 0 at equilibrium, Q-vs-K direction, and ΔG = ΔH − TΔS. Ruling: the ΔG-versus-rate line supports ~3 Ch5 keys, all quantitative: (a) reading Ea(fwd)/Ea(rev)/ΔH off a numeric described profile; (b) a data question where the MORE exergonic of two reactions is the SLOWER (rates computed/ranked from Ea or k, ΔG given as scenery); (c) catalyst-affects-k-not-spontaneity framed through the Arrhenius exponential. Never re-key a ΔG definition or sign call; never use glucose oxidation; ΔG appears in stems as given scenery only.

**2. THE ENZYME SEAM — open catalyst keys after Ch2's 100 questions (enumerated, evidence verified):** OPEN: (i) catalyst-vs-intermediate discrimination in a written multistep mechanism (zero keys anywhere; every bank "intermediate" is oxidation-state/electronegativity/potential sense); (ii) homogeneous vs heterogeneous + adsorption→surface reaction→desorption (zero bank hits for "collision"/catalysis phase); (iii) the equal-factor mechanism — k_f and k_r raised by the same factor so k_f/k_r is invariant (Ch2 Q25 keys the OUTCOME "no net change" but never the rate-constant mechanism; Ch5 must use a nonenzymatic gas-phase/industrial system and must not re-ask add-catalyst-at-equilibrium); (iv) quantitative effect of an Ea drop on k via e^(−Ea/RT); (v) catalyst appearing in an experimental rate law. CLOSED (verbatim keys in Ch2 batch1/batch3): bare "lowers Ea" (Q1), TS stabilization (Q4), single-peak catalyzed-vs-uncatalyzed overlay (Q5/Q6), ΔG/Keq-unchanged recall (Q3/Q7/Q25), enzyme temperature optimum/denaturation/10 °C doubling (batch3 lines 217/230/243/282).

**3. THE EQUILIBRIUM RESERVATION — forward line for Ch6:** "Ch5 keys only the rate side: a catalyst raises k_forward and k_reverse by an equal factor, so equilibrium is reached faster with position/Keq untouched, and the rate-versus-equilibrium-position distinction. Ch6 owns: Law of Mass Action, Keq expressions and values, Kc/Kp, Q-vs-K, Le Chatelier stresses, Keq–ΔG° linkage, and kinetic-vs-thermodynamic control (its live deck cards 25–27 already claim it). No Ch5 key may contain an equilibrium-constant value, expression, or shift direction; equilibrium appears only as the destination a catalyst reaches faster." Ch10 collision check: PASS — Ch10's live keys are Ka/Kb/Kw/Henderson-Hasselbalch/bicarbonate-Le-Chatelier (acid-base-specific); since Ch5 keys no equilibrium math at all, no collision is possible. (Ch10's Le Chatelier and Kw-temperature keys are a Ch6 seam problem, noted for that future audit, not Ch5's.)

**4. THE NUCLEAR SEAM — chemical framing, ruled:** All keyed half-life/decay computations use chemical species (solution decomposition, drug hydrolysis, ln[A]-vs-t data). Write t½ = ln 2/k ≈ 0.693/k, consonant with the physics deck's 0.693/λ (verified line 188). At most ONE stem may use a radioisotope as scenery, and its key must be first-order math only. Never key decay-particle identity, nuclear stability, binding energy, or semi-log radioisotope bookkeeping — 4E territory, claimed by the physics Ch9 deck (subtopics 9.5/9.6 verified) and its future bank. Every Ch5 row carries foundation '5E'; no row is tagged '4E'.

**5. SOURCE-DOC ERRATA — refereed:** (a) "All reactions experience an optimal temperature" — FALSE for ordinary reactions (rate rises monotonically with T per Arrhenius); ruled NEVER a credited claim; explicitly approved as a distractor, whose rationale states that only enzyme-catalyzed reactions peak (consistent with deck card line 125). (b) Frequency factor A "increased by increasing the number of molecules in a vessel" — ruled NON-CREDITABLE: concentration enters the rate through [A]^m in the rate law; k (and A within it) is concentration-independent, changed only by temperature and Ea/catalyst. Drafters describe A solely as collision frequency × orientation fraction (matching deck card line 113, which is already correct); any option routing concentration effects through A is a designed distractor. (c) CONFIRMED as stated: the deck asserts TS "at higher energy than both the reactants and the products" (line 131) and slope signs −k ([A] vs t, zero), −k (ln[A] vs t, first), +k (1/[A] vs t, second) at lines 81/83/85; drafters must match these exactly.

**6. DATA PRESENTATION under v7 — ruled: compact in-stem LaTeX lines, no tables, no figures.** Live chem/phys precedent (Ch10–12) uses zero Markdown tables; mobile-first is a hard rule and in-stem lines render reliably at phone width. Format: "Trial 1: [A] = 0.10 M, [B] = 0.10 M, initial rate = 2.0 × 10⁻³ M·s⁻¹" — max 3 trials, one-clean-factor concentration steps, calculator-free ratios. Energy profiles are text-described (Ch2 batch1 Q5/Q6 precedent: described diagrams with labeled arrows work); no figure_svg for this chapter.

## Boundary rules (Ch5 must NOT test X; Y owns it)

1. Bare "catalyst lowers activation energy" or TS-stabilization recall — Biochem Ch2 batch1 (Q1, Q4).
2. Catalyzed-vs-uncatalyzed single-peak diagram overlay — Biochem Ch2 batch1 (Q5/Q6).
3. "Catalyst leaves ΔG/Keq/equilibrium position unchanged" as recall, incl. add-catalyst-at-equilibrium — Biochem Ch2 batch1 (Q3/Q7/Q25); Ch5 may key only the equal-factor k_f/k_r mechanism, nonenzymatically.
4. Qualitative "spontaneous does not mean fast" and any ΔG definition/sign/computation — Biochem Ch12 batch 1.
5. Enzyme anything: Km/Vmax/kcat, saturation order-switch, temperature optimum, denaturation, 10 °C doubling rule as key — Biochem Ch2 (100 Qs). Enzymes = passing scenery at most.
6. Keq expressions/values, Q-vs-K, Le Chatelier, Keq–ΔG°, kinetic-vs-thermodynamic control — future GenChem Ch6 bank (its deck claims them); ΔG°=−RT ln K also owned by Biochem Ch12 + GenChem Ch12.
7. Nuclear decay particulars (α/β/γ identity, binding energy, radioisotope-framed keyed computations) — physics Ch9 deck / future physics bank (4E).
8. "Rate-limiting enzyme of pathway X" framings — biochem metabolism chapters (different sense of rate-limiting).
9. Bare "Arrhenius" without "equation" — always write "Arrhenius equation"; Ch10 trained students on the acid definition.

## Off-outline concepts: DROP vs KEEP

KEEP (commonly-tested precedent — named enzymes/applied Km/Chargaff standard):
- Two-point Arrhenius comparison — actually ON-outline via "Use of the Arrhenius Equation" (line 3110); ratio-supplied arithmetic only.
- Collision theory energy + orientation criteria — no outline anchor but classic MCAT discrete; anchored to Activation energy (3105).
- Exergonic/endergonic vocabulary — premises/stems only, never the keyed definition (Ch12 owns those keys).
- Intermediates and the intermediate/TS/catalyst distinction — rides in with RDS (3103) and energy profiles (3107–3109); keyable within mechanism/profile questions.
- First-order half-life t½ = 0.693/k — bridges 4E/5E, chemical framing per seam ruling.

DROP:
- Medium/solvent effect on rate — absent from the AAMC's own factor list (verified preamble: concentration, temperature, catalyst only); rarely tested. Not even a distractor axis.
- Mixed/broken/fractional orders as keys — no outline gesture, essentially never tested; at most ONE recognition-level distractor chapter-wide.
- Frequency-factor mechanistic interpretation beyond symbol-level definition — cartographer's own commonly_tested_anyway = false; definition-level mention only.

## SQL field values (verbatim, house-convention verified against genchem_ch10_batch1.sql)

- section: `chem_phys`
- topic: `Chemical Kinetics`
- discipline: `general-chemistry`
- foundation: `5E`
- content_category: `Rate Processes in Chemical Reactions - Kinetics and Equilibrium (GC)` (outline line 3092 uses U+2015 ―; normalize to plain hyphen per house plain-ASCII precedent)
- Explanation format: opener "This is a General Chemistry question that falls under the content category '…'", then "The answer to this question is X because …", (Choice X) blocks for wrong answers only, distractor metadata rows per wrong choice, and the v7 FULL-SENTENCE skill closer (orgchem_ch1/biochem_ch12 style), not ch10's bare "Skill N" tag.
- Subtopic-scoped idempotent DELETE per batch; run-in-any-order batches.

## Cartographer-versus-auditor disagreements (not smoothed over)

1. **Kinetic vs thermodynamic control** — GENUINE CONTRADICTION. Cartographer: IN_SCOPE for Ch5 (outline line 3111, commonly_tested_anyway true). Auditor SEAM 1: AVOID, Ch6 deck claims it. I verified the Ch6 deck carries it as cards 25–27 (lines 111–118). RULING: auditor wins — Ch6 owns it; forking ownership across chapters is the exact failure the pipeline guards against. Ch5 may use "the kinetic product forms faster" only as distractor scenery. Flag for the Ch6 pre-flight: AAMC files this under 5E Rate Processes, so Ch6's blueprint must explicitly pick it up.
2. **Kinetics-thermo prize** — cartographer marks it IN_SCOPE/commonly-tested without registering the Ch12 collision; auditor found Ch12 Q9 owns the qualitative key (I verified line 196 verbatim). RULING: auditor wins; quantitative faces only (call 1 above).
3. **Radioactive decay** — cartographer reads the 4E dual-tag (PHY, GC) as licensing first-order-decay applications in Ch5; auditor restricts nuclear to scenery. RULING: mostly auditor — chemical keyed math, ≤1 radioisotope-scenery stem (call 4).
4. **Homogeneous/heterogeneous catalysis** — cartographer: recognition-level, rarely tested (commonly_tested_anyway false); auditor: "OWN IT" including the adsorption sequence. RULING: split the difference — 1–2 recognition-level items inside the Catalysts subtopic, no more.
5. Minor citation drift, non-load-bearing: the boundary audit cites Ch2 batch3 "Q17/Q18/Q19/Q22" — the rows verify in substance at batch3 lines 217/230/243/282 (subtopic 'Local Conditions: Temperature, pH & Salinity'). Also the audit's Ch5-deck card indices (e.g., "cards 0–3", "16–18") do not match the deck's positional ordering exactly, but every substantive card claim verified verbatim; drafters should cite deck claims by content, not index.

---

# APPENDIX A: scope verdict, all 35 concepts

| Concept | Verdict | Outline home | Line |
|---|---|---|---|
| Kinetics-thermodynamics distinction: negative delta-G says a reaction CAN occur, kinetics says how FAST; spontaneity implies nothing about rate | IN_SCOPE | 5E: Principles of chemical thermodynamics and kinetics — Rate Processes in Chemi | 3111 |
| Exergonic versus endergonic vocabulary as premises | NOT_FOUND | - | - |
| Reaction mechanisms: multi-step sequences summing to the overall reaction | IN_SCOPE | 5E: Rate Processes in Chemical Reactions — Kinetics and Equilibrium | 3103 |
| Intermediates as species formed and consumed, appearing in neither overall side | NOT_FOUND | - | - |
| The rate-determining (slow) step limiting the overall rate | IN_SCOPE | 5E: Rate Processes in Chemical Reactions — Kinetics and Equilibrium | 3103 |
| Mechanism-to-rate-law link: rate law reflects the composition of the rate-determining step's transition state; a proposed mechanism must reproduce the observed rate law | IN_SCOPE | 5E: Rate Processes in Chemical Reactions — Kinetics and Equilibrium | 3098 |
| Collision theory: rate proportional to collision frequency times the effective fraction | NOT_FOUND | - | - |
| Effective collisions require sufficient energy AND correct orientation | NOT_FOUND | - | - |
| Activation energy as the minimum collision energy (the barrier) | IN_SCOPE | 5E Principles of chemical thermodynamics and kinetics — Rate Processes in Chemic | 3105 |
| Arrhenius equation k = A e^(-Ea/RT): symbols and qualitative consequences (higher T or lower Ea raises k exponentially) | IN_SCOPE | 5E Principles of chemical thermodynamics and kinetics — Rate Processes in Chemic | 3110 |
| The frequency factor A as attempt/orientation frequency | IN_SCOPE | 5E Principles of chemical thermodynamics and kinetics — Rate Processes in Chemic | 3110 |
| Transition-state (activated-complex) theory: transition state at the energy maximum, higher than reactants and products, can proceed forward or revert | IN_SCOPE | 5E Principles of chemical thermodynamics and kinetics — Rate Processes in Chemic | 3106 |
| Reaction coordinate diagram read in words: barrier heights, delta-G of reaction as endpoint difference, catalyzed vs uncatalyzed profiles | IN_SCOPE | 5E Principles of chemical thermodynamics and kinetics — Rate Processes in Chemic | 3107 |
| Two-point Arrhenius comparison (which of two reactions or temperatures gives the larger k, qualitatively or with supplied ratios) | IN_SCOPE | 5E Principles of chemical thermodynamics and kinetics — Rate Processes in Chemic | 3110 |
| Concentration raising collision frequency and reaction rate (except zero-order reactions) | IN_SCOPE | 5E. Principles of chemical thermodynamics and kinetics — Rate Processes in Chemi | 3096 |
| Temperature raising the fraction of molecules exceeding Ea | IN_SCOPE | 5E. Principles of chemical thermodynamics and kinetics — Rate Processes in Chemi | 3104 |
| Medium/solvent effect on rate (polar solvents assisting polarizable reactants), recognition level | NOT_FOUND | - | - |
| Catalysts: lower Ea without being consumed, regenerated by reaction's end | IN_SCOPE | 5E. Principles of chemical thermodynamics and kinetics — Rate Processes in Chemi | 3113 |
| Homogeneous versus heterogeneous catalysis (same phase versus distinct phase) | IN_SCOPE | 5E. Principles of chemical thermodynamics and kinetics — Rate Processes in Chemi | 3113 |
| Catalyst symmetry facts: forward AND reverse Ea both drop, both rates rise by the same factor, ΔG/Keq/equilibrium position untouched | IN_SCOPE | 5E. Principles of chemical thermodynamics and kinetics — Rate Processes in Chemi | 3113 |
| A catalyst cannot make a nonspontaneous reaction proceed | IN_SCOPE | 5E. Principles of chemical thermodynamics and kinetics — Rate Processes (GC) + E | 3113 |
| Rate defined from disappearance of reactant / appearance of product, with sign conventions and stoichiometric scaling (rate = -(1/a)d[A]/dt) | IN_SCOPE | 5E: Principles of chemical thermodynamics and kinetics — Rate Processes in Chemi | 3095 |
| Rate units of molarity per second | IN_SCOPE | 5E — Rate Processes in Chemical Reactions: Kinetics and Equilibrium (GC) | 3095 |
| Rate law rate = k[A]^x[B]^y with experimentally determined exponents (never from overall stoichiometry) | IN_SCOPE | 5E — Rate Processes in Chemical Reactions: Kinetics and Equilibrium (GC) | 3098 |
| Order with respect to each reactant; overall order as the sum of exponents | IN_SCOPE | 5E — Rate Processes in Chemical Reactions: Kinetics and Equilibrium (GC) | 3099 |
| Initial-rates method: comparing trial pairs where one concentration changes to deduce each exponent | IN_SCOPE | 5E — Rate Processes in Chemical Reactions: Kinetics and Equilibrium (GC) | 3096 |
| Rate-constant units varying with overall order (M/s zero order, 1/s first order, 1/(M·s) second order) | IN_SCOPE | 5E — Rate Processes in Chemical Reactions: Kinetics and Equilibrium (GC) | 3098 |
| Computing k from a supplied experimental trial | IN_SCOPE | 5E — Rate Processes in Chemical Reactions: Kinetics and Equilibrium (GC) | 3098 |
| Zero-order kinetics: rate independent of concentrations, rate = k, [A]-vs-time plot linear with slope -k, rate changed only by temperature or catalyst | IN_SCOPE | 5E: Principles of chemical thermodynamics and kinetics — Rate Processes in Chemi | 3098-3099 |
| First-order kinetics: rate proportional to one reactant, k in s^-1, exponential decay of concentration, ln[A] vs time linear with slope -k | IN_SCOPE | 5E Rate Processes (GC); reinforced by 4E and the SIRS math skills | 3098-3099; 2631; 2136-2137 |
| Radioactive decay as the classic first-order process (framing question: does physics own the nuclear side?) | IN_SCOPE | 4E: Atoms, nuclear decay, electronic structure, and atomic chemical behavior — A | 2629-2631 |
| First-order half-life constant, t(1/2) = 0.693/k | IN_SCOPE | 4E: Atoms, nuclear decay, electronic structure, and atomic chemical behavior — A | 2631 |
| Second-order kinetics: rate proportional to a squared single reactant or two first-order reactants, k in M^-1 s^-1, 1/[A] vs time linear with slope +k | IN_SCOPE | 5E: Principles of chemical thermodynamics and kinetics — Rate Processes in Chemi | 3098-3099 |
| Identifying reaction order from described linear-plot behavior (which transformation linearizes the data) | IN_SCOPE | Scientific Inquiry and Reasoning Skills (math/data skills) combined with 5E Reac | 2136-2137; 3099; 2631 |
| Mixed, broken, and non-integer (fractional) reaction orders at recognition level | NOT_FOUND | - | - |

# APPENDIX B: boundary audit, all 43 findings

### Catalysts/enzymes lowering activation energy (bare recall)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch1.sql`
- **Evidence:** Ch2 batch1 Q1 key A: stem 'By acting as a biological catalyst, the enzyme speeds the reaction by changing which quantity?' -> key 'It lowers the activation energy'. Reinforced in Q22 of batch3 (distractor A rationale: heat does not lower Ea, the enzyme does).
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — quantitative: catalyst's effect on the rate constant k via the Arrhenius exponential (compute/compare catalyzed vs uncatalyzed k or rate ratios), or heterogeneous vs homogeneous chemical catalysts; never the one-line 'what does a catalyst lower?' recall.

### Rate enhancement without the catalyst being consumed / catalyst regenerated

- **Status:** MENTIONED_ONLY
- **Owner:** `biochemistry_ch2_enzymes_batch4.sql`
- **Evidence:** 'Not consumed' appears only as scenery: Ch2 batch4 allosteric-inhibitor stem ('binds reversibly... and is not consumed') and Ch2 batch2 cosubstrate-vs-prosthetic-group keys about NAD+/FAD being 'regenerated' (a cofactor question, not a catalyst-definition key). No biochem key turns on the catalyst-unconsumed property itself.
- **Recommendation:** OWN IT — ideal GenChem framing: identify the catalyst in a written multistep mechanism as the species consumed in an early step and regenerated in a later one (contrast with an intermediate, which is produced then consumed).

### Transition-state stabilization as the mechanism of catalysis

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch1.sql`
- **Evidence:** Ch2 batch1 Q4 key C: 'According to Pauling's hypothesis, the enzyme achieves this acceleration primarily because it binds and' -> key 'stabilizes the transition state' (binds TS more tightly than substrate, lowering Ea).
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — transition state vs intermediate identity on multistep coordinate diagrams (peaks are transition states, valleys are intermediates); avoid any 'how does the catalyst work?' = TS-stabilization key.

### Energy-diagram reading (Ea vs delta-G on a single-peak diagram)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch1.sql`
- **Evidence:** Ch2 batch1 Q5 key D: with enzyme added 'The peak is lower; endpoints unchanged'. Q6 key B: 'Arrow X [reactant-to-peak, Ea] shortens; arrow Y [reactant-to-product, delta-G] unchanged'. Both keys turn entirely on reading a one-peak catalysis diagram.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — multistep (two-or-more-peak) diagrams: identify the rate-determining step as the highest barrier, count intermediates, compare forward vs reverse Ea; the catalyzed-vs-uncatalyzed single-peak overlay is taken.

### Catalyst does not change delta-G, Keq, or equilibrium position

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch1.sql`
- **Evidence:** Three Ch2 batch1 keys turn on it: Q3 key A ('Its delta-G is unchanged' for an endergonic reaction plus enzyme), Q7 key D (statements I and II true, enzyme cannot convert endergonic to exergonic), Q25 key B (adding more enzyme to an equilibrated mixture -> 'no net change occurs'). Also the standing distractor rationale in Ch12 Q13 ('enzymes... do not change delta-G-standard or the position of equilibrium').
- **Recommendation:** AVOID IT — this is the single most re-keyed idea in the biochem bank (3 keys + multiple distractor rationales); any GenChem version would collide head-on.

### Temperature effects on enzyme rate / optimal-temperature curve

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch3.sql`
- **Evidence:** Ch2 batch3 owns the whole curve: Q17 key A (peak of rise-then-fall curve = 'The enzyme's optimal temperature'), Q18 key B ('Activity falls off sharply as the enzyme denatures' above optimum), Q19 key C (curve shape: rises to maximum then declines), Q22 key B (warming 10 C below optimum -> 'The rate of the reaction increases', citing the doubling-per-10-C rule).
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — non-enzymatic temperature dependence via the Arrhenius relation (k rises monotonically with T; larger fraction of molecules exceed Ea, Boltzmann-distribution reasoning); never use an enzyme or a peaked activity curve, and don't key on the 'doubles per 10 C' rule Ch2 already cites.

### Enzyme kinetics Km/Vmax, saturation, first-to-zero-order transition

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch2.sql`
- **Evidence:** Ch2 batch2 owns it outright: Q9-Q18 Michaelis-Menten (Q9 key A defines Vmax at saturation; Q18 key B is explicitly the order transition: 'v is approximately proportional to [S] when [S] << Km and approaches a constant value of Vmax when [S] >> Km'), Q19-Q25 kcat and kcat/Km, plus batch3 Q1-Q6 Lineweaver-Burk.
- **Recommendation:** AVOID IT — determine GenChem reaction orders exclusively via method-of-initial-rates tables and integrated rate laws on non-enzymatic reactions; do not use enzyme saturation as the example of changing order, since Ch2 Q18's key is exactly that.

### Delta-G sign conventions, exergonic/endergonic, spontaneity

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 batch 1 keys: Q7 key C (delta-G = -18 kJ/mol -> 'exergonic and proceeds spontaneously... releasing free energy'), Q15 key C (-RT ln K computation with sign->spontaneity link), Q8 key D (delta-G = 0 at equilibrium), Q12 key D (Q vs K sets sign of delta-G and direction).
- **Recommendation:** AVOID IT — thermodynamic spontaneity keys belong to Ch12; a kinetics chapter should treat delta-G sign as given scenery only, never as the tested quantity.

### Delta-G = delta-H minus T-delta-S (computation and temperature-dependence analysis)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 Q5 key A: computes delta-G = 55 - 44.7 = +10.3 kJ/mol with J-to-kJ conversion, 'non-spontaneous'. Ch12 Q6 key B: delta-H<0, delta-S<0 -> 'Only at low temperatures, where the favorable delta-H term outweighs the unfavorable -T-delta-S term'.
- **Recommendation:** AVOID IT — both the plug-and-chug and the four-quadrant sign analysis are keyed in Ch12 batch 1.

### Kinetics-versus-thermodynamics distinction (spontaneous does not mean fast) — the prize

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 Q9 [B9 Free Energy & Equilibrium] key A is precisely this concept: glucose + O2 (delta-G ~ -2870 kJ/mol) sits unreacted for months; key = 'delta-G tells you only whether the reaction is favorable and how much energy it can release—not how fast it goes; the rate is instead set by the activation-energy barrier'. Explanation states 'thermodynamics and kinetics are independent' and 'spontaneous is a thermodynamic label... not a claim about speed'. The conceptual prize is NOT open.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — the conceptual 'favorable but slow, why?' item is taken (and its glucose-oxidation scenario is off-limits). GenChem Ch5 can still own quantitative faces of the distinction: kinetic vs thermodynamic product control, showing from Arrhenius/rate-law data that k is independent of delta-G magnitude, or a data question where the more exergonic of two reactions is the slower one and the key turns on computed rates.

### Ch10 ETC rate content and activation-energy scenery

- **Status:** MENTIONED_ONLY
- **Owner:** `biochem_ch10_carbohydrate_metabolism_2_questions.sql`
- **Evidence:** Ch10 ETC/OxPhos keys turn on biological flux direction (which carriers accumulate on an inhibitor block, residual O2 consumption via Complex II entry, respiratory-control/ADP regulation in K-section Q85-Q92) — never on a chemical-kinetics quantity. Activation energy appears in Ch10 only inside distractors of Q96 (options A and C invoke it; key D is delta-G summation for ATP coupling).
- **Recommendation:** OWN IT (no block) — ETC 'rate' language is pathway-flux reasoning, not chemical kinetics; Ch5 is free to test rate constants, orders, and Ea quantitatively, just avoid mitochondrial/respiration dressings.

### Reaction mechanisms, rate-determining steps, and intermediates (chemical-kinetics sense)

- **Status:** MENTIONED_ONLY
- **Owner:** `biochem_ch11_lipid_amino_acid_metabolism_questions.sql`
- **Evidence:** Every biochem 'rate-limiting' key is the metabolic-regulation sense: Ch11 line ~641 key = ACC as the committed, rate-limiting step of fatty-acid synthesis; Ch11 line ~1080 = CPT-I transport rate-limiting for palmitate oxidation; Ch10 = isocitrate dehydrogenase as 'rate-limiting enzyme of the citric acid cycle'; Ch12 line ~1553 = protein synthesis as the rate-limiting step for a hormonal delay. No biochem key derives a rate law from elementary steps, identifies the slowest elementary step of a chemical mechanism, or distinguishes intermediates from transition states; Ch2 contains essentially zero mechanism-intermediate content (grep: 0-3 incidental mentions).
- **Recommendation:** OWN IT — elementary steps, molecularity, rate-law-from-slow-step, and intermediate identification are fully open; steer clear of 'which enzyme is the rate-limiting step of pathway X' framings, which biochem owns.

### Reaction rates / rate expressions (sign convention, units, stoichiometric coupling)

- **Status:** FLASHCARD_ONLY
- **Owner:** `general_chemistry_ch5_chemical_kinetics_flashcards.sql`
- **Evidence:** Zero keys anywhere in the ~500-question chem/phys bank (genchem_ch1-4, ch10-12, orgchem_ch1, all hard_update files). The only 'reaction rate' string in the bank is scenery in genchem_ch1_batch1.sql (isotopes have 'the same reaction rate' — key turns on nuclide identity). Ch5 deck cards 0-3 carry the negative/positive sign convention, M·s⁻¹ units, and coefficient conversion.
- **Recommendation:** OWN IT — virgin territory in the question bank; align sign-convention and unit facts with deck cards 0-3.

### Rate laws, reaction order, method of initial rates, units of k

- **Status:** FLASHCARD_ONLY
- **Owner:** `general_chemistry_ch5_chemical_kinetics_flashcards.sql`
- **Evidence:** No question in the chem/phys bank keys on any rate-law fact ('rate law' and 'rate constant' return zero question-bank hits). Ch5 deck cards 4-10 and 15 carry: orders found experimentally not from coefficients, method of initial rates, overall order = sum, zero-order term drops out, k-units-by-order discriminator (M·s⁻¹ / s⁻¹ / M⁻¹·s⁻¹).
- **Recommendation:** OWN IT — ideal for data-table initial-rates questions (fits the bank's data-reasoning bar); keep k-unit answers consistent with deck card 15.

### Integrated rate laws and linear-plot discriminators ([A] vs t, ln[A] vs t, 1/[A] vs t)

- **Status:** FLASHCARD_ONLY
- **Owner:** `general_chemistry_ch5_chemical_kinetics_flashcards.sql`
- **Evidence:** Absent from all question files. Ch5 deck cards 11-14 carry the full discriminator set including slope signs (−k for zero/first, +k for second) and the first-order form [A]t = [A]0·e^(−kt).
- **Recommendation:** OWN IT — figure/plot-driven questions are the natural format; match the deck's slope-sign claims exactly (second-order slope is positive).

### Half-life by order (first-order t½ concentration-independent; zero/second-order dependence)

- **Status:** FLASHCARD_ONLY
- **Owner:** `physics_ch9_atomic_and_nuclear_phenomena_flashcards.sql`
- **Evidence:** No question keys anywhere ('half-life' returns zero question-bank hits). Ch5 deck cards 16-18 carry the by-order behavior AND card 18 claims 'radioactive decay is the classic first-order process… half-life is constant'. physics_ch9 deck cards 36-40 carry t½ = 0.693/λ and n(t) = n₀·e^(−λt). No physics question bank exists yet — the nuclear seam is deck-only on both sides.
- **Recommendation:** OWN IT with chemical species; if a radioisotope stem is used, key only on first-order math (write t½ = ln 2/k, consonant with the physics deck's 0.693/λ) and never on decay-mode particle bookkeeping, which physics Ch9 will own.

### Activation energy and collision theory

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch1.sql`
- **Evidence:** In the bio_biochem section (section field verified 'bio_biochem'), biochemistry_ch2_enzymes_batch1.sql keys 'It lowers the activation energy' as a correct answer, keys transition-state stabilization ('binding the transition state more tightly than the substrate lowers... Ea'), and batch3 keys 'the rate of the reaction increases' for in-range temperature rise. The chem/phys bank itself has zero activation-energy keys ('kinetic energy' hits in genchem_ch1 are photoelectric/mass-spec, not thermal/collision).
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — own it quantitatively (energy-profile diagrams reading Ea vs ΔH, collision orientation + energy criteria, fraction-clearing-the-barrier reasoning); never key the bare qualitative fact 'a catalyst lowers Ea', which biochem Ch2 already keys verbatim in the enzyme frame.

### Arrhenius equation (k = A·e^(−Ea/RT), linearized ln k vs 1/T, two-point form)

- **Status:** FLASHCARD_ONLY
- **Owner:** `general_chemistry_ch5_chemical_kinetics_flashcards.sql`
- **Evidence:** 'Arrhenius' in the question bank refers exclusively to the Arrhenius ACID-BASE definition (genchem_ch10_batch2.sql and batch4 key acid/base classification, not kinetics). Ch5 deck cards 23-30 carry the equation, frequency factor, R value, slope = −Ea/R, and the two-point form ln(k₂/k₁) = (Ea/R)(1/T₁ − 1/T₂).
- **Recommendation:** OWN IT — but in stems/explanations disambiguate explicitly ('Arrhenius equation', never bare 'Arrhenius') since Ch10 has trained students to read 'Arrhenius' as the acid definition.

### Catalyst function (not consumed, alternative pathway, homogeneous vs heterogeneous, catalytic surfaces/electrodes)

- **Status:** MENTIONED_ONLY
- **Owner:** `genchem_ch10_batch4.sql`
- **Evidence:** Two chem/phys questions mention catalysts as scenery only: genchem_ch11_batch2.sql names Lindlar's catalyst but the key turns on oxidation-number bookkeeping of H₂ addition; genchem_ch10_batch4.sql (Q9, g91) asks WHICH enzyme interconverts CO₂/H₂CO₃ — the key is identifying carbonic anhydrase, though its explanation states catalysis 'lets the bicarbonate system reach equilibrium within seconds'. genchem_ch12 (electrochemistry) has zero catalytic-electrode keys. Deck cards 44-49 carry regeneration, alternative pathway, and adsorption/desorption for heterogeneous catalysis.
- **Recommendation:** OWN IT from the general-chemistry angle (catalyst regenerated within a mechanism, surface catalysis, catalyst appearing in the rate law when in an early step) — avoid the enzyme frame, which biochem Ch2 owns.

### Catalyst does not shift Keq / does not change ΔG (kinetics-vs-thermodynamics boundary)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch1.sql`
- **Evidence:** biochemistry_ch2_enzymes_batch1.sql keys it directly ('speeds a reaction... without altering reaction thermodynamics... the equilibrium constant, Keq, is unchanged. What is changed is the rate at which equilibrium is achieved') and uses 'increases Keq' as a distractor; batch3 repeats 'Enzymes do not affect the thermodynamics of reactions' as key rationale. Also FLASHCARD claims: Ch5 deck cards 36, 46-47 and Ch6 equilibrium deck line 109 ('a catalyst does not shift the position of an equilibrium... reached faster with the same final composition') and line 87 ('adding a catalyst leaves Keq unchanged').
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — frame it kinetically, which no live question does: catalyst raises k_forward and k_reverse by the same factor so k_f/k_r (= Keq) is invariant, or read it off a two-pathway energy diagram (both barriers lowered, ΔG endpoints fixed); use an inorganic/gas-phase system, never an enzyme, and never bare 'does Keq change? no' recall.

### Equilibrium-constant machinery and Le Chatelier (the equilibrium-adjacent keys Ch5 must stay clear of)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `genchem_ch10_batch4.sql`
- **Evidence:** Enumerated live equilibrium-adjacent keys: (1) genchem_ch10_batch2.sql keys Ka·Kb = Kw, Kw autoionization setting [H₃O⁺]=[OH⁻], hydrolysis Kb = Kw/Ka, and the weak-acid ICE expression Ka = x²/C; (2) genchem_ch10_batch3.sql keys Henderson-Hasselbalch/pKa buffer math throughout; (3) genchem_ch10_batch4.sql keys Le Chatelier twice on the bicarbonate equilibrium (buffer stress response; exhaling CO₂ shifts the system left/right); (4) genchem_acidsbases_hard_update.sql keys a temperature-shifted ion-product (Kw at non-25 °C — i.e., 'K changes only with temperature' is already exploited); (5) genchem_ch12_batch4.sql keys the Nernst equation's Q dependence and Q→Keq as a cell dies. The Ch6 equilibrium deck additionally carries Q-vs-Keq, mass action, and Le Chatelier cards for the FUTURE Ch6 bank, plus kinetic-vs-thermodynamic-control cards (lines 113-117).
- **Recommendation:** AVOID IT — no Keq calculations, no Q-vs-K comparisons, no Le Chatelier stress-response keys, and no kinetic-vs-thermodynamic product control (reserved for the future Ch6 bank per its deck); equilibrium may appear in Ch5 only as the destination a catalyst reaches faster.

### Temperature–kinetic-energy link (KMT, Boltzmann distribution)

- **Status:** FLASHCARD_ONLY
- **Owner:** `chemistry_ch8_the_gas_phase_flashcards.sql`
- **Evidence:** GenChem Ch1-4 question bank has NO KMT keys — every 'kinetic energy' key in genchem_ch1_batch1/batch2 and genchem_atomic_hard_update.sql is photoelectric-effect or mass-spectrometer KE, not thermal. The claim 'temperature ∝ average kinetic energy' lives in three decks: chemistry_ch8 gas-phase deck (KEavg = (3/2)kB·T, KMT postulates, elastic collisions), chemistry_ch7 thermochem deck line 86, physics_ch3 thermodynamics deck line 63.
- **Recommendation:** OWN IT as the mechanism behind temperature dependence (energy-distribution shift → larger fraction exceeds Ea → k rises), consistent with the three decks' claims; leave full KMT postulates and (3/2)kBT math to the future gas-phase chapter.

### Reaction mechanisms, intermediates, molecularity, rate-determining step

- **Status:** FLASHCARD_ONLY
- **Owner:** `general_chemistry_ch5_chemical_kinetics_flashcards.sql`
- **Evidence:** Every 'intermediate' hit in the chem/phys bank is a different sense of the word: intermediate OXIDATION STATE (genchem_ch11_batch3.sql, genchem_redox_hard_update.sql), intermediate electronegativity/bond length (genchem_ch3), intermediate reduction potential (genchem_ch12_batch2.sql), or intermediate calculation value (all hard_update files). orgchem_ch1_functional_groups_nomenclature_questions.sql has ZERO mechanism, intermediate, or transition-state keys — it is pure functional-group ID and nomenclature. Ch5 deck cards 37-43 carry mechanism/RDS/molecularity/intermediate-elimination claims.
- **Recommendation:** OWN IT — mechanism-consistency-with-rate-law questions (slow-first-step vs fast-pre-equilibrium) are unclaimed by any live question; a strong fit for the data-reasoning bar.

### Enzyme kinetics framing (temperature optimum, denaturation, enzymes as biological catalysts)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch3.sql`
- **Evidence:** biochemistry_ch2_enzymes_batch3.sql keys the in-range temperature→rate-increase question and keys denaturation-adjacent facts; batch1 keys enzyme-as-catalyst definitionally. Ch5 deck card 31 (enzyme optimum/denaturation exception) and card 50 (enzymes as biological catalysts) overlap this territory as flashcard claims.
- **Recommendation:** AVOID IT — keep Ch5 questions on inorganic/small-molecule systems; do not key enzyme temperature optima, denaturation, or enzyme-catalyst definitions, all owned by the 25-question bio_biochem Ch2 enzymes set.

### META — House conventions Ch5 must match (verified in genchem_ch10_batch1.sql)

- **Status:** MENTIONED_ONLY
- **Owner:** `genchem_ch10_batch1.sql`
- **Evidence:** genchem_ch10_batch1.sql: section 'chem_phys'; short topic ('Acids & Bases' — Ch5 should be 'Chemical Kinetics'); SHARED subtopic strings with subtopic-scoped idempotent DELETE; foundation code + VERBATIM AAMC topic name in content_category ('5A' + 'Acid-Base Equilibria (GC, BC)' matches outline line 2730 exactly, plain hyphen); discipline 'general-chemistry'; inline LaTeX \( \) everywhere incl. options JSON; explanations open "This is a General Chemistry question that falls under the content category '...'" then "The answer to this question is X because ..."; (Choice X) blocks for WRONG answers only; distractor metadata rows per wrong choice. NOTE: ch10 (v6-era) ends explanations with a bare 'Skill 1' tag, but the v7-era files end with FULL-SENTENCE skill closers — orgchem_ch1 ('...so this is a Knowledge of Scientific Concepts and Principles question.', '...is a Scientific Reasoning and Problem Solving question because...') and biochem_ch12 ('This item is Skill 2: it requires distinguishing...'). Ch5 must use the full-sentence closer, not the bare tag. Answer letters rebalanced across the whole chapter (ch10 header: 24/24/24/24 across 96).
- **Recommendation:** OWN IT — copy ch10's structural conventions verbatim but adopt the orgchem_ch1/biochem_ch12 full-sentence skill closer.

### META — AAMC placement of kinetics and the verbatim content-category string for Ch5

- **Status:** MENTIONED_ONLY
- **Owner:** `aamc-content-outline-2026.txt`
- **Evidence:** reference-textbooks/aamc/aamc-content-outline-2026.txt line 2233: '5E. Principles of chemical thermodynamics and kinetics.' Kinetics is the 5E topic at lines 3092-3093: 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)' with subtopics: reaction rate; rate law/rate constant/reaction order; rate-determining step; temperature dependence (activation energy, activated complex/transition state, energy-profile interpretation, Arrhenius equation); kinetic vs thermodynamic control; catalysts; equilibrium (Law of Mass Action, Keq, Le Chatelier); Keq-ΔG° relationship. House precedent stores the topic-level name verbatim ('Electrochemistry (GC)', 'Acid-Base Equilibria (GC, BC)'), so Ch5 rows carry foundation '5E' + content_category 'Rate Processes in Chemical Reactions - Kinetics and Equilibrium (GC)' (normalize the outline's U+2015 horizontal bar to a plain hyphen, matching the house's plain-ASCII precedent in 'Acid-Base Equilibria (GC, BC)'). Do NOT use 5E topic 'Enzymes (BC, BIO)' — that is Biochem Ch2's territory.
- **Recommendation:** OWN IT — foundation '5E', content_category 'Rate Processes in Chemical Reactions - Kinetics and Equilibrium (GC)' on every Ch5 row.

### SEAM 1 — Catalyst does not shift equilibrium position / Keq (no-Keq-shift)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch1.sql`
- **Evidence:** biochemistry_ch2_enzymes_batch1.sql Q25 (line ~332): enzyme added to an already-equilibrated reversible reaction, key = concentrations do not change (equilibrium reached faster, not shifted) — the exact no-Keq-shift fact keyed in ENZYME framing. Also keyed adjacently: Q3/Q4 (enzyme speeds rate without altering ΔG or Keq). Both the Ch5 and Ch6 flashcard decks carry the fact as cards ('catalyst lowers Ea but leaves Keq... unchanged').
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — Ch5 may still own no-Keq-shift under the forward reservation, but only via the rate-constant mechanism biochem never keyed: catalyst raises k_forward AND k_reverse equally so their ratio (= Keq) is untouched, framed on a nonenzymatic industrial/gas-phase catalyst; never re-ask 'add catalyst at equilibrium, what happens' (duplicates Q25).

### SEAM 1 — Keq computation, law of mass action, writing/interpreting equilibrium-constant expressions

- **Status:** FLASHCARD_ONLY
- **Owner:** `general_chemistry_ch6_equilibrium_flashcards.sql`
- **Evidence:** general_chemistry_ch6_equilibrium_flashcards.sql (live deck) claims: law of mass action, Kc/Kp, multi-step Keq, magnitude interpretation, reverse = 1/Keq, pure solids/liquids excluded. No live question keys generic Keq computation (only the special case Kw expression in genchem_ch10_batch1 Q2, acid-base framing).
- **Recommendation:** AVOID IT — reserved for the future Ch6 question bank per the forward reservation; Ch5 keys only catalyst-and-rate facts, never a Keq value or expression.

### SEAM 1 — Reaction quotient Q versus K direction test

- **Status:** TESTED_ELSEWHERE
- **Owner:** `genchem_ch12_batch4.sql`
- **Evidence:** genchem_ch12_batch4.sql Q69 (Q<1 raises Ecell above E° via Nernst) and Q77 (Q = [Cd2+]/[Ag+]^2, solids excluded, direction+magnitude of Ecell change) key Q-reasoning in ELECTROCHEMICAL framing; the generic Q<K/Q=K/Q>K direction test exists only as Ch6 flashcards.
- **Recommendation:** AVOID IT — generic Q-vs-K belongs to the future Ch6 bank; the electrochemical variant is already taken by Ch12.

### SEAM 1 — Le Chatelier's principle (concentration/pressure/temperature stresses)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `genchem_ch10_batch1.sql`
- **Evidence:** genchem_ch10_batch1.sql Q13 keys the endothermic-shift-right temperature logic (heating water raises Kw, Le Chatelier reasoning is the keyed pathway); genchem_ch12_batch4 Q70/Q77 key concentration-stress effects on cell potential; Ch6 flashcard deck claims the full principle.
- **Recommendation:** AVOID IT — no Ch5 key may turn on a shift direction; equilibrium-position reasoning is Ch6's (and already partially Ch10/Ch12's).

### SEAM 1 — Kinetic vs thermodynamic control of a reaction

- **Status:** FLASHCARD_ONLY
- **Owner:** `general_chemistry_ch6_equilibrium_flashcards.sql`
- **Evidence:** AAMC lists it under the 5E Rate Processes topic (outline line ~3105), but the live Ch6 equilibrium flashcard deck explicitly claims 'kinetic vs thermodynamic reaction control' (deck header, sourced to LibreTexts OrgChem); no question keys it anywhere.
- **Recommendation:** AVOID IT — the flashcard pipeline already assigned it to Ch6; keying it in Ch5 would fork ownership across chapters. Leave it for the Ch6 bank.

### SEAM 1 — ΔG° = −RT ln Keq and free-energy/Keq computation

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** biochem_ch12_bioenergetics_regulation_metabolism_questions.sql ('Free Energy & Equilibrium' subtopic, line ~221) keys the full ΔG = ΔG°' + RT ln Q computation (Skill 4) and states ΔG° = −RT ln Keq in explanation; genchem_ch12_batch3 Q62/Q68 key the Keq↔E°↔ΔG° sign triangle.
- **Recommendation:** AVOID IT — thermodynamic linkage of Keq is owned by Biochem Ch12 (bio framing) and GenChem Ch12 (electrochem framing); also Ch6-reserved on the GC side.

### SEAM 1/3 — Thermodynamics-kinetics independence (ΔG sets favorability, Ea sets rate)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** biochem_ch12 line ~196: glucose oxidation with ΔG = −2870 kJ/mol yet kinetically inert; key = 'thermodynamics and kinetics are independent... slow oxidation reflects a high activation barrier'; Skill-2 closer names exactly this distinction.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — do not re-key the qualitative statement; Ch5 owns the QUANTITATIVE energy-profile version instead: read Ea(fwd), Ea(rev), and ΔH = Ea(fwd) − Ea(rev) off numeric profiles, or rank rates from tabulated Ea values at fixed T.

### SEAM 2 — First-order half-life (t1/2 = 0.693/k, concentration-independent)

- **Status:** FLASHCARD_ONLY
- **Owner:** `physics_ch9_atomic_and_nuclear_phenomena_flashcards.sql`
- **Evidence:** Zero live question keys any half-life kinetics: the bank-wide 'half-life' grep hits only hormone plasma half-life (biology ch5/biochem ch12, pharmacokinetic scenery) and poly-A mRNA lifetime. GenChem Ch1's question bank has NO decay subtopic (subtopics: Subatomic Particles, Isotopes & Atomic Weight, Electron Configurations, Quantization/Bohr, Quantum Numbers, Periodic Trends, The Mole) despite carrying the 4E content-category string. The physics_ch9 flashcard deck claims subtopics '9.5 Radioactive Decay (9 cards)' and '9.6 Half-Life and Exponential Decay (5 cards)'; the Ch5 kinetics deck carries the order-discriminating half-life card. No physics questions exist in the bank at all.
- **Recommendation:** OWN IT — in CHEMICAL framing (decomposition of a reactant in solution, drug hydrolysis, ln[A] vs t plots): key t1/2 = 0.693/k, its concentration-independence, and the order-discriminating half-life behavior. Nuclear decay may appear as SCENERY only ('radioisotopes decay by first-order kinetics' as a stem lead-in is fine) but the keyed computation must be chemical, since AAMC files nuclear half-life under 4E Atomic Nucleus (PHY, GC) and the physics Ch9 deck/future bank owns that framing.

### SEAM 2 — Nuclear decay particulars: alpha/beta/gamma identity, binding energy, semi-log decay plots of radioisotopes

- **Status:** FLASHCARD_ONLY
- **Owner:** `physics_ch9_atomic_and_nuclear_phenomena_flashcards.sql`
- **Evidence:** AAMC outline lines 2624-2631 place 'Radioactive decay: α, β, γ decay; Half-life, exponential decay, semi-log plots' under 4E 'Atomic Nucleus (PHY, GC)', not 5E. physics_ch9 flashcard deck (40 cards, live) claims all of it; genchem_ch1 questions never key it.
- **Recommendation:** AVOID IT — wrong foundation (4E) for a 5E chapter and claimed by the physics Ch9 deck; never let a Ch5 key turn on decay-particle identity, nuclear stability, or a radioisotope-framed computation.

### SEAM 3 — Catalyst lowers activation energy via alternative pathway (bare fact) and transition-state stabilization

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch1.sql`
- **Evidence:** biochemistry_ch2_enzymes_batch1.sql: Q1 keys 'lowers the activation energy' verbatim as the answer; Q4 keys Pauling transition-state stabilization; Q5/Q6 key the energy-diagram consequences (peak lowered, both Ea-forward and Ea-reverse arrows shortened, ΔG unchanged) — all in enzyme framing.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — the angles Biochem Ch2 did NOT key and Ch5 may own: (1) catalyst-vs-intermediate discrimination inside a written multistep mechanism (consumed-then-regenerated vs generated-then-consumed species); (2) homogeneous vs heterogeneous catalysis and the adsorption→surface reaction→desorption sequence; (3) the QUANTITATIVE effect of an Ea drop on k via e^(−Ea/RT) (compute/rank the rate factor); (4) catalyst appearing in an experimental rate law. Never key the bare 'catalysts lower Ea' or 'stabilize the transition state' statements.

### SEAM 3 — Temperature raises reaction rate; ~doubling per 10 °C rule

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch3.sql`
- **Evidence:** biochemistry_ch2_enzymes_batch3.sql ('Local Conditions: Temperature, pH & Salinity', 9 Qs): one question keys 'the rate of the reaction increases' for a +10 °C step below the enzyme optimum, with the doubling rule of thumb quoted in the explanation; neighboring questions key the rise-then-denature activity curve.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — Ch5 owns the QUANTITATIVE Arrhenius machinery nowhere keyed: ln k = ln A − Ea/RT, the linear ln k vs 1/T plot (slope = −Ea/R), the two-point Ea method, and collision-theory reasoning (higher T → larger fraction of collisions exceeding Ea). Do not key the qualitative 'warmer → faster' or the 10 °C doubling rule as an answer.

### SEAM 3 — Enzyme kinetics proper: Michaelis-Menten (Km, Vmax, saturation), kcat/Km, cooperativity, inhibition classes, Lineweaver-Burk, pH/salinity effects

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch2.sql`
- **Evidence:** Biochem Ch2 owns ~100 live questions across 12 subtopics (batch DELETE lists: 'Michaelis-Menten Kinetics (Vmax, Km, Saturation)' 10 Qs, 'Catalytic Efficiency (kcat and kcat/Km)' 7, 'Cooperativity' 10, 'Lineweaver-Burk' 6, 'Reversible Inhibition' 13, 'Irreversible Inhibition' 2, 'Enzyme Regulation' 10, etc.). Critically, batch2 line ~230 already keys the apparent-order switch: v proportional to [S] when [S]<<Km and constant at Vmax when [S]>>Km — i.e., first-order-to-zero-order saturation behavior in enzyme framing.
- **Recommendation:** AVOID IT — zero enzyme-kinetics keys in Ch5; keep every rate-law/order question on NONENZYMATIC reactions, and specifically do not frame a zero-order-vs-first-order question around catalyst/enzyme saturation (collides with batch2's apparent-order question). Enzymes may appear only as passing scenery, never as the keyed system.

### Rate laws, rate constant, and reaction order determined from initial-rates data

- **Status:** ABSENT
- **Owner:** `general_chemistry_ch5_chemical_kinetics_flashcards.sql`
- **Evidence:** No live question in the ~2,400-question bank keys rate = k[A]^m[B]^n, order determination, or k units; only the Ch5 deck's own flashcards cover it (cards: 'exponents must be found experimentally (not from the balanced equation)', k-unit discriminators).
- **Recommendation:** OWN IT — core Ch5 territory; build data-table initial-rates questions (reason from the data per the MCAT quality bar), including the 'orders are not stoichiometric coefficients' trap and k-unit determination.

### Integrated rate laws: linear-plot signatures (ln[A] vs t, 1/[A] vs t, [A] vs t), slope signs, k units by order

- **Status:** ABSENT
- **Owner:** `general_chemistry_ch5_chemical_kinetics_flashcards.sql`
- **Evidence:** No question anywhere keys integrated rate laws or plot-linearity discrimination; exists only as Ch5 deck cards (own-chapter deck does not block questions).
- **Recommendation:** OWN IT — including which-plot-is-linear identification and slope interpretation (−k vs +k), a strong Skill-4 data/figure opportunity.

### Reaction mechanisms: elementary steps, molecularity, intermediates, rate-determining step, mechanism-rate-law consistency

- **Status:** ABSENT
- **Owner:** `biochemistry_ch9_carbmet1_questions_batch2.sql`
- **Evidence:** No live question keys mechanism reasoning. 'Rate-limiting/rate-determining' language appears in the bank only as metabolic-pathway regulation facts (e.g., pathway rate-limiting ENZYMES in biochem ch9/ch12 and one archetype note in biochem ch4) — a different claim (which enzyme controls a pathway) from mechanism-derived kinetics.
- **Recommendation:** OWN IT — slowest-elementary-step logic, predicting the rate law from a slow first step, molecularity of elementary steps, and intermediate identification; stay off 'rate-limiting enzyme of glycolysis'-type framings.

### Collision theory and reaction-rate expressions (effective collisions, orientation + energy criteria; rate = −1/a d[A]/dt stoichiometric coupling; M/s units)

- **Status:** ABSENT
- **Owner:** `general_chemistry_ch5_chemical_kinetics_flashcards.sql`
- **Evidence:** No live question keys collision theory or rate-expression stoichiometry; Ch5 deck cards cover both (sign convention, stoichiometric conversion between species rates).
- **Recommendation:** OWN IT — clean opening-subtopic material for the chapter's easy tier.

### Transition state / activated complex as an entity (transient species with partial bonds, at the profile maximum, cannot be isolated)

- **Status:** MENTIONED_ONLY
- **Owner:** `biochemistry_ch2_enzymes_batch1.sql`
- **Evidence:** Biochem Ch2's profile questions key barrier-HEIGHT changes (Q5: peak is lower; Q6: which arrow shortens), not the identity or properties of the activated complex itself; 'transition state' appears in ch2 explanations and biochem_ch12 distractor text as supporting prose only.
- **Recommendation:** OWN IT — via the definitional/positional angle (what the activated complex is, where it sits on the coordinate, why it cannot be isolated), keeping keys off 'the catalyst lowers/stabilizes it' which Ch2 owns.

