# Verification Report — Biochemistry Ch 2: Enzymes

**Deck:** Enzymes
**Source SQL:** supabase/seeds/biochemistry_ch2_enzymes_flashcards.sql
**Verified:** 2026-06-02

## Summary

- Total cards: 63
- Confidence 5: 60
- Confidence 4: 3
- Confidence 3: 0
- Confidence 2: 0
- Confidence 1: 0
- `needs_sme_review`: 0
- Dropped during editorial pass: 2 (.apkg note 1 placeholder; .apkg note 67 BSA wet-lab uses — out of scope)
- Consolidated for duplication: 1 pair (.apkg notes 68 + 70 on lysosomal hydrolases) → folded into Card 14
- Repaired: 1 (.apkg note 51 malformed cloze syntax)

**Length-compliance check (per v6 CARD LENGTH & FOCUS rule):**
- All 63 cards confirmed ≤ 40 words of answer prose
- All 63 cards confirmed ≤ 4 cloze blanks
- One discrete concept per card — no over-budget exceptions used
- **Parallel-concept clozing rule applied**: where a card lists parallel members of one set (e.g., positive/negative/no cooperativity; tense/relaxed states; inorganic/organic helpers), all parallel members are clozed together rather than just one. This avoids the failure mode where a single visible plain-text member gives away the answer pattern for the clozed one.

**Primary references:**
- LibreTexts Biochemistry (Enzyme Catalysis, Enzyme Classification, Michaelis-Menten Kinetics, Enzyme Inhibition, Allosteric Regulation, Cooperative Binding)
- OpenStax Chemistry: Atoms First 2e (activation energy, transition state, reaction coordinates)
- AAMC Content Outline 2026, Foundation 1D Concept 1 (Enzymes)

## Per-card verification

### Card 0 — Enzyme definition
**Cloze claim:** Enzymes are biological catalysts that speed reactions without being consumed.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Introduction to Enzymes).

### Card 1 — Lower activation energy, no effect on ΔG/equilibrium
**Cloze claim:** Lower Ea to reach transition state; don't change ΔG or equilibrium.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; OpenStax Chemistry: Atoms First 2e (Activation Energy).

### Card 2 — Kinetics vs thermodynamics
**Cloze claim:** Affect rate, not thermodynamics; reach equilibrium faster but don't shift it.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Catalysis Principles).

### Card 3 — Enzyme specificity
**Cloze claim:** Each enzyme catalyzes one reaction or class of reaction with its specific substrate(s).
**Confidence:** 5
**Source:** LibreTexts Biochemistry; AAMC Content Outline Foundation 1D Concept 1.

### Card 4 — Endergonic
**Cloze claim:** Endergonic = requires energy input, ΔG > 0, products higher energy than reactants.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; OpenStax Chemistry: Atoms First 2e (Free Energy).

### Card 5 — Exergonic
**Cloze claim:** Exergonic = releases energy, ΔG < 0, products lower energy than reactants.
**Confidence:** 5
**Source:** Same as Card 4.

### Card 6 — Transition state
**Cloze claim:** Highest-energy point along reaction coordinate; Ea = gap from reactant to peak.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e (Reaction Coordinates and Transition States).

### Card 7 — Six enzyme classes
**Cloze claim:** Six classes sorted by reaction type; names indicate chemistry.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Enzyme Classification); standard EC nomenclature.

### Card 8 — Oxidoreductases
**Cloze claim:** Catalyze redox; use cofactor as electron carrier (NAD+/NADH, FAD/FADH2).
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 9 — Transferases + kinases
**Cloze claim:** Transfer functional groups; kinases transfer phosphate, usually from ATP.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 10 — Hydrolases
**Cloze claim:** Use water to break bonds; peptidases, nucleases, lipases as examples.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 11 — Lyases
**Cloze claim:** Cleave or join without water and without redox; often ring or double-bond chemistry.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 12 — Isomerases
**Cloze claim:** Rearrange bonds within one molecule; interconvert isomers (stereo and constitutional).
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 13 — Ligases
**Cloze claim:** Join two larger molecules using energy from ATP hydrolysis.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 14 — Pancreatic + lysosomal hydrolases
**Cloze claim:** Both groups are predominantly hydrolases — pancreatic for digestion, lysosomal for intracellular breakdown.
**Confidence:** 5
**Source:** OpenStax A&P 2e §23 (Pancreatic Secretions); OpenStax Biology 2e §4 (Lysosomes); consolidated from .apkg notes 68, 70, 76.

### Card 15 — Active site
**Cloze claim:** Pocket where substrate binds and catalysis occurs; 3D shape dictates specificity.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Enzyme Active Sites).

### Card 16 — ES complex
**Cloze claim:** Temporary enzyme-substrate association during catalysis.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 17 — Active-site stabilizing forces
**Cloze claim:** Hydrogen bonds, ionic interactions, and transient covalent bonds stabilize binding.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 18 — Lock-and-key model
**Cloze claim:** Active site pre-shaped for substrate; no conformational change required.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Substrate Binding Models).

### Card 19 — Induced fit model
**Cloze claim:** Substrate molds the active site; conformational change requires energy (endergonic).
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 20 — Cofactor vs coenzyme (with parallelism fix)
**Cloze claim:** Cofactors = non-protein helpers, typically inorganic (metal ions); coenzymes = small organic helpers, vitamin-derived.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Cofactors and Coenzymes).

### Card 21 — Apoenzyme vs holoenzyme
**Cloze claim:** Apoenzyme = inactive without cofactor; holoenzyme = active with cofactor.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 22 — Prosthetic group
**Cloze claim:** Tightly (often covalently) bound cofactor/coenzyme required for function.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 23 — Common organic coenzymes
**Cloze claim:** NAD+, FAD, coenzyme A; shuttle electrons or functional groups.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 24 — Water-soluble vitamins
**Cloze claim:** B-complex + vitamin C; easily excreted, require regular replenishment.
**Confidence:** 5
**Source:** OpenStax A&P 2e §24 (Vitamins); LibreTexts Biochemistry.

### Card 25 — Fat-soluble vitamins
**Cloze claim:** A, D, E, K; depend on lipid partition coefficients; stored in body fat.
**Confidence:** 5
**Source:** OpenStax A&P 2e §24; LibreTexts Biochemistry.

### Card 26 — Partition coefficient
**Cloze claim:** Quantifies distribution between polar and nonpolar phases; fat-soluble vitamins favor nonpolar.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry (Partition Coefficients).

### Card 27 — Michaelis-Menten equation
**Cloze claim:** V = Vmax[S]/(Km + [S]).
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Michaelis-Menten Kinetics). **Correction:** .docx para 79 has the equation as "V = Vmas [S] / Km + [S]" with the "Vmas" autocorrect typo and missing parentheses; corrected here.

### Card 28 — Vmax
**Cloze claim:** Max rate at saturation; only raised by ↑ [enzyme].
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 29 — Km definition
**Cloze claim:** Km = [S] at which V = ½ Vmax.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 30 — Km affinity interpretation (with parallelism)
**Cloze claim:** Small Km = high affinity; large Km = low affinity.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 31 — MM hyperbolic curve
**Cloze claim:** V vs [S] is hyperbola; asymptotes to Vmax.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 32 — Lineweaver-Burk plot
**Cloze claim:** Double-reciprocal form of MM; 1/V vs 1/[S] linearizes the curve.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Lineweaver-Burk Analysis).

### Card 33 — LB intercepts
**Cloze claim:** y-intercept = 1/Vmax; x-intercept = -1/Km.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 34 — kcat (turnover number)
**Cloze claim:** Substrate molecules converted to product per enzyme per second at saturation.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Catalytic Constants).

### Card 35 — kcat formula
**Cloze claim:** kcat = Vmax / [E]total.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 36 — Catalytic efficiency
**Cloze claim:** kcat/Km; raised by high kcat or low Km.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 37 — Cooperative enzymes definition
**Cloze claim:** Multiple subunits and active sites; binding at one alters affinity at others.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Cooperative Binding).

### Card 38 — T vs R state (with parallelism)
**Cloze claim:** Subunits switch between low-affinity tense (T) and high-affinity relaxed (R); binding pulls T → R.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (MWC Model).

### Card 39 — Sigmoidal curve
**Cloze claim:** Cooperative V vs [S] is sigmoidal, not hyperbolic.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 40 — Hill coefficient (with parallelism fix)
**Cloze claim:** n > 1 positive; n < 1 negative; n = 1 no cooperativity.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Hill Equation).

### Card 41 — Temperature optimum + Q10
**Cloze claim:** Peak around 37°C; rate ~doubles per 10°C rise to optimum, then enzyme denatures.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Temperature Effects on Enzymes).

### Card 42 — Thermal denaturation reversibility
**Cloze claim:** Mild overheating reversible by cooling; full disruption of tertiary/quaternary structure is irreversible.
**Confidence:** 4
**Source:** LibreTexts Biochemistry. Standard framing, though the boundary between "mild" and "full" denaturation is enzyme-specific.

### Card 43 — pH optimum (general)
**Cloze claim:** Most enzymes ~7.4; pH affects ionization of active-site residues; extreme deviations denature.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (pH Effects).

### Card 44 — Pepsin vs pancreatic pH optima
**Cloze claim:** Pepsin pH ~2 (stomach); pancreatic enzymes pH ~8.5 (small intestine).
**Confidence:** 5
**Source:** OpenStax A&P 2e §23.5 (Chemical Digestion).

### Card 45 — Salinity
**Cloze claim:** High salt disrupts ionic and hydrogen bonds; alters conformation; at extreme levels denatures.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 46 — Feedback inhibition
**Cloze claim:** End product inhibits an earlier enzyme in the same pathway; conserves resources.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Metabolic Regulation).

### Card 47 — Feed-forward regulation
**Cloze claim:** Early intermediate activates downstream enzyme; ramps output in anticipation of demand.
**Confidence:** 4
**Source:** LibreTexts Biochemistry. Feed-forward regulation is a well-established concept but less universally tested than feedback inhibition.

### Card 48 — Competitive inhibition
**Cloze claim:** Binds active site (resembles substrate); Vmax unchanged, apparent Km increases; overcome by ↑ substrate.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Reversible Inhibition).

### Card 49 — Noncompetitive inhibition (CORRECTED)
**Cloze claim:** Binds allosteric site; Vmax decreases, Km unchanged; cannot be overcome by ↑ substrate.
**Confidence:** 5
**Source:** LibreTexts Biochemistry. **Correction:** .docx para 141 states noncompetitive inhibition "does alter the value of KM" — directly contradicting the standard fact. Corrected to Km unchanged per LibreTexts and consistent with .apkg note 15.

### Card 50 — Uncompetitive inhibition
**Cloze claim:** Binds only ES complex; both Km and Vmax decrease by the same factor.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 51 — Mixed inhibition
**Cloze claim:** Binds allosteric site on free enzyme or ES complex with different affinities; Vmax always decreases; Km direction depends on preference.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 52 — Mixed inhibition Km direction
**Cloze claim:** Prefers free enzyme → Km rises; prefers ES complex → Km falls.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 53 — Reversible inhibition summary mnemonic
**Cloze claim:** Competitive = Km only; noncompetitive = Vmax only; uncompetitive = both; mixed = both with variable Km direction.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 54 — Allosteric enzymes
**Cloze claim:** Have regulatory (allosteric) sites distinct from active site; binding shifts between active and inactive conformations.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Allosteric Regulation).

### Card 55 — Allosteric activator vs inhibitor
**Cloze claim:** Activator stabilizes accessible-active-site conformation; inhibitor stabilizes hidden conformation.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 56 — Irreversible inhibition (REPAIRED from malformed .apkg note 51)
**Cloze claim:** Permanent (often covalent) binding at active site; not reversible by removing substrate.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Irreversible Inhibition).

### Card 57 — Irreversible inhibitor examples
**Cloze claim:** Penicillin (covalently inactivates bacterial transpeptidase); aspirin (covalently acetylates COX).
**Confidence:** 5
**Source:** LibreTexts Biochemistry; standard pharmacology examples.

### Card 58 — Phosphorylation
**Cloze claim:** Kinase attaches phosphate (often from ATP) to Ser/Thr/Tyr; switches enzyme activity on or off.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Covalent Modification).

### Card 59 — Dephosphorylation
**Cloze claim:** Phosphatases remove phosphate groups; reverse kinase action.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 60 — Glycosylation
**Cloze claim:** Covalent sugar attachment; tags for transport, alters activity or selectivity.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 61 — Zymogen
**Cloze claim:** Inactive precursor; activated by proteolytic cleavage that exposes the active site.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Zymogen Activation); OpenStax A&P 2e §23.

### Card 62 — Enzyme suffix patterns
**Cloze claim:** -cyclase makes cyclic molecules; -phosphatase removes phosphates; -acetylase adds acetyl groups.
**Confidence:** 4
**Source:** LibreTexts Biochemistry. Enzyme nomenclature suffixes are widely used but the exact suffix-to-action mapping for the full set of -ase enzymes is convention rather than a strict rule.

## needs_sme_review

None. All 63 cards rated confidence 4 or 5.

## Disagreements with corpus

**One material factual disagreement and one equation typo in the source materials.**

1. **.docx para 141 — factual error.** The chapter outline states that adding a noncompetitive inhibitor "does alter the value of KM" — directly contradicting the standard biochemistry fact, which is that noncompetitive inhibition reduces Vmax with Km unchanged. The .docx's own explanation in the same sentence actually supports Km being unchanged. Corrected per LibreTexts Biochemistry and consistent with .apkg note 15. Card 49 reflects the corrected fact (Vmax decreases, Km unchanged).

2. **.docx para 79 — equation typo.** Michaelis-Menten equation rendered as "V = Vmas [S] / Km + [S]" with the "Vmas" autocorrect typo and missing parentheses around the denominator. Both errors would yield a mathematically incorrect formula. Card 27 supplies the correctly typeset equation: V = Vmax[S] / (Km + [S]).

The three confidence-4 cards (42, 47, 62) use framings that are firmly established but lightly framed in introductory texts: the boundary of thermal-denaturation reversibility (enzyme-specific in practice); feed-forward regulation as a parallel to feedback (less universally tested); and enzyme-suffix mapping (convention rather than strict rule).

## Discrepancies between primary and secondary sources

None encountered. LibreTexts Biochemistry and OpenStax Chemistry: Atoms First 2e treat enzyme kinetics and catalysis topics consistently with each other.

## Source-material discrepancies corrected during editorial pass

The chapter outline document contained multiple autocorrect-introduced typos, one substantive factual error, and one equation typo. The Anki deck contained one malformed cloze, one duplicated pair, one out-of-scope card, and one placeholder. All were corrected against the reference textbooks before any card was written:

1. **Factual error (substantive):** .docx claims noncompetitive inhibition alters Km; corrected to Vmax decreases, Km unchanged per LibreTexts.
2. **Equation typo:** .docx Michaelis-Menten equation "V = Vmas [S] / Km + [S]" → V = Vmax[S] / (Km + [S]).
3. .docx "McKellie's-Menten" → Michaelis-Menten (autocorrect)
4. .docx "Kinesis catalyzes" → Kinases catalyze (autocorrect)
5. .docx "braking" → breaking (autocorrect)
6. .docx "Lyases has catalyzed" → Lyases catalyze (grammar)
7. .docx "Isomerase has catalyzed" → Isomerases catalyze (grammar)
8. .docx "lock-in key" → lock-and-key (autocorrect)
9. .docx "Induce fit" → induced fit (grammar)
10. .docx "low-affinity 10 state (T)" → low-affinity tense (T) state (autocorrect garble)
11. .docx "Co-operativity" → Cooperativity (hyphenation)
12. .apkg note 51 — malformed cloze syntax `{{c1::Irreversible inhibition{{` → repaired and rewritten as the canonical irreversible-inhibition card
13. .apkg note 67 (BSA wet-lab uses) — dropped as out-of-scope research-methods content
14. .apkg note 1 ("Text,Extra" placeholder) — dropped
15. .apkg notes 68 + 70 (duplicate lysosomal hydrolase facts) — consolidated into Card 14
16. **5 .apkg notes with back-field inhibitor plot images** — stripped per text-only deck policy; conceptual content preserved in card prose

---

## Post-verification SME decisions

*(Empty section reserved for future SME or content owner to log overrides, retentions, or revisions made after the report was generated.)*
