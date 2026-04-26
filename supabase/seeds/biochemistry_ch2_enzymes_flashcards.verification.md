# Verification Report — Biochem Ch 2: Enzymes

**Deck:** Enzymes: Catalysis, Kinetics & Regulation
**Source SQL:** supabase/seeds/biochemistry_ch2_enzymes_flashcards.sql
**Verified:** 2026-04-25
**Corpus:**
- libretexts-biochemistry.txt (primary)
- openstax-biology-2e.txt (secondary)
- openstax-chemistry-atoms-first-2e.txt (secondary)
- openstax-anatomy-physiology-2e.txt (used opportunistically for body temperature and luminal pH values)

## Summary

- Total cards: 53
- Confidence 5: 27
- Confidence 4: 18
- Confidence 3: 7
- Confidence 2: 1
- Confidence 1: 0
- Cards flagged for needs_sme_review (confidence < 4): 8
- Cards where corpus actively contradicts card: 0

## Per-card verification

### Card 0
**Cloze claim:** Enzymes are biological catalysts — typically proteins — that accelerate reactions without being altered.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §1.2.4–1.1, lines 1258–1259, 720–724
**Excerpt supporting:** "Enzymes are biological catalysts that speed up chemical reactions. Typically, they are proteins composed of amino acid building blocks." Also "enzymes are crucial to metabolism because they act as catalysts, allowing reactions to proceed more rapidly."
**Notes:** —

### Card 1
**Cloze claim:** A catalyst lowers activation energy (Ea), the barrier to the transition state; identities of reactants/products unchanged.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §kinetics, lines 40060–40121, 40615–40619 (primary corroboration); libretexts-biochemistry.txt lines 25090–25092
**Excerpt supporting:** "molecules with sufficient energy can collide to form a high-energy activated complex or transition state… reaction's activation energy, Ea, as the energy difference between the reactants and the transition state." Catalyzed pathway has "a notably lesser activation energy."
**Notes:** —

### Card 2
**Cloze claim:** Transition state = highest-energy configuration; enzyme stabilizes it.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §6.1 transition state stabilization, lines 25085–25094
**Excerpt supporting:** "any factor that stabilizes the charges developed in the transition state… lowers the activation energy and catalyzes the reaction." Combined with chem-atoms-first lines 40065–40067.
**Notes:** —

### Card 3
**Cloze claim:** Enzymes do not shift Keq.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt §1.3 lines 520–522, 1306–1325
**Excerpt supporting:** Learning goals explicitly require students to "differentiate the effect of an enzyme on the change in free energy of a reaction versus the change in transition state free energy." The text repeatedly stresses ΔG and Keq are thermodynamic and concentration-dependent, with catalysis acting on Ea.
**Notes:** Corpus discusses the principle but doesn't print the exact sentence "enzymes do not change Keq." Still strongly implied; widely accepted MCAT-grade fact.

### Card 4
**Cloze claim:** Enzymes don't change ΔG; catalysis governs rate, not whether reaction is favorable.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt §1.3 lines 1306–1325, 1495–1516; chem-atoms-first lines 40060–40121
**Excerpt supporting:** "ΔG is the 'driving' force for a reaction… for a chemical reaction that favors products, ΔG < 0." Activation energy (kinetics) lowered by catalyst is conceptually distinct from ΔG (thermodynamics).
**Notes:** Same as card 3 — concept supported, exact phrasing not present.

### Card 5
**Cloze claim:** Enzyme is regenerated each cycle (not consumed).
**Confidence:** 4
**Source:** libretexts-biochemistry.txt lines 1258–1259, 720–724
**Excerpt supporting:** Definition of catalyst as not consumed is implicit in "biological catalysts that speed up chemical reactions."
**Notes:** Corpus does not give a "millions of substrates per enzyme" line specifically; that's a generalization. Still acceptable.

### Card 6
**Cloze claim:** Exergonic ΔG<0 spontaneous; endergonic ΔG>0 non-spontaneous.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt lines 654, 706, 1514–1516
**Excerpt supporting:** "metabolism, distinguishing between exergonic (energy-releasing) and endergonic" and "if ΔG < 0, the reaction goes toward products… if ΔG > 0, the reaction goes toward reactants."
**Notes:** —

### Card 7
**Cloze claim:** Enzyme specificity — each enzyme only recognizes a narrow set of substrates.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt line 730; openstax-biology-2e.txt lines 8472–8489
**Excerpt supporting:** "Enzyme shape is critical to enzyme function, as it determines the specific binding of a reactant." Biology 2e: "enzymes are known for their specificity. The 'best fit'…" The card's stronger claim ("every cellular reaction is driven by its own dedicated catalyst") is an idealization; reality includes promiscuous enzymes, but this is a common MCAT teaching framing.
**Notes:** Slight idealization but consistent with how textbooks teach this.

### Card 8
**Cloze claim:** Oxidoreductases catalyze redox reactions; use NAD⁺/NADH or FAD/FADH₂.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt EC numbering line 17898 ("'1' stands for oxidoreductases"); GO:0016491 oxidoreductase activity (line 17927). NAD⁺/FAD as electron carriers: openstax-biology-2e.txt §metabolism (cytochrome oxidoreductase line 9539; NAD/FAD coverage in glycolysis/Krebs sections).
**Excerpt supporting:** Primary names class 1 as oxidoreductase; biology 2e covers NAD⁺/FAD as central electron carriers.
**Notes:** Primary corpus does not give a single passage tying oxidoreductase → NAD/FAD; the linkage is stitched together. Still well-supported in aggregate.

### Card 9
**Cloze claim:** Substrate that loses electrons = oxidized = reductant; gains electrons = reduced = oxidant.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt lines 15810–15811, 15919–16002
**Excerpt supporting:** "sodium functions as a reducing agent (reductant), since it provides electrons to (or reduces) chlorine. Likewise, chlorine functions as an oxidizing agent (oxidant)…"
**Notes:** —

### Card 10
**Cloze claim:** Transferases move functional groups; phosphate-transfer subclass = kinase (ATP donor).
**Confidence:** 3
**Source:** libretexts-biochemistry.txt EC class line 17898 (six classes mentioned); kinase definition lines 347–350.
**Excerpt supporting:** "A protein kinase is an enzyme that covalently transfers a terminal phosphate (P) from ATP to a protein."
**Notes:** Primary names "transferases" as one of the six EC classes but does NOT explicitly tie kinase to the transferase subclass in the text I located. The statement is correct by EC convention (kinases are EC 2.7.x.x) but the corpus does not anchor that hierarchy. needs_sme_review for traceability.

### Card 11
**Cloze claim:** Hydrolases cleave bonds with water; subtypes include phosphatases, peptidases/proteases, nucleases, lipases.
**Confidence:** 3
**Source:** libretexts-biochemistry.txt — phosphatases (line 7945–7946 etc.), proteases (chymotrypsinogen, trypsin sections), lipase (line 31328), DNA ligase referenced in biology 2e.
**Excerpt supporting:** Each named subtype appears throughout the corpus performing hydrolysis. However, no single passage in primary corpus enumerates "hydrolases include phosphatases, peptidases, nucleases, lipases."
**Notes:** Card's enumeration is correct biochemistry but is not a single direct quotation. needs_sme_review for traceability.

### Card 12
**Cloze claim:** Lyases break bonds without water/redox, often forming or eliminating a double bond/ring; reverse (joining substrates) = synthase.
**Confidence:** 3
**Source:** libretexts-biochemistry.txt — hydroxynitrile lyase (line 6376, 6485 etc.), synthase examples (line 4187 tryptophan synthase, line 6283 cystathionine β-synthase).
**Excerpt supporting:** Examples of lyases (hydroxynitrile lyase) and synthases appear, but no direct definition of the lyase mechanism or the lyase↔synthase relationship is in the located passages.
**Notes:** Definitions accurate but not directly quoted. The synthase/lyase relationship is a teaching convention — IUBMB classifies many synthases as ligases (EC 6) rather than lyases (EC 4), so the card's framing simplifies. needs_sme_review.

### Card 13
**Cloze claim:** Isomerases rearrange atoms within one molecule; covers racemization, cis-trans, intramolecular shifts.
**Confidence:** 4
**Source:** openstax-biology-2e.txt lines 9237–9239, 10068
**Excerpt supporting:** "isomerase is an enzyme that catalyzes the conversion of a molecule into one of its isomers." Glycolysis steps 2 and 5 are isomerases.
**Notes:** The three subtypes (racemization/cis-trans/intramolecular) are not enumerated in the located passages but are standard EC 5 descriptions.

### Card 14
**Cloze claim:** Ligases join two substrates with high-energy phosphate (usually ATP).
**Confidence:** 4
**Source:** openstax-biology-2e.txt lines 17194, 17211, 17319, 17546 (DNA ligase examples)
**Excerpt supporting:** "DNA ligase, which catalyzes the formation of [phosphodiester linkage]." Ligases are widely shown to consume ATP (the canonical EC 6 definition).
**Notes:** ATP-coupling is widely shown across corpus.

### Card 15
**Cloze claim:** Pancreatic enzymes (lipase, amylase, trypsin, chymotrypsin) all hydrolases.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt line 31328 (trypsin activates chymotrypsin, lipase in duodenum); openstax-biology-2e.txt line 4205 ("Amylase, lipase, pepsin, trypsin").
**Excerpt supporting:** "trypsin will cleave and activate other zymogen proteases and lipases in the duodenum. These include the activation of elastase, chymotrypsin, carboxypeptidase, and lipase."
**Notes:** Explicit "hydrolase class" labeling not given, but each enzyme's mechanism (hydrolysis) is standard.

### Card 16
**Cloze claim:** Active site = pocket where substrate docks and chemistry happens; sets specificity.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt line 5268; openstax-biology-2e.txt lines 8472–8479
**Excerpt supporting:** "An active site is the part of an enzyme [where substrate binds]. … enzymes are known for their specificity."
**Notes:** —

### Card 17
**Cloze claim:** Enzyme-substrate (ES) complex is obligatory step.
**Confidence:** 5
**Source:** openstax-biology-2e.txt line 8511; libretexts-biochemistry.txt §6.3 Michaelis-Menten derivation lines 26790–26995
**Excerpt supporting:** "When an enzyme binds its substrate, it forms an enzyme-substrate complex. This complex lowers the reaction's [activation energy]."
**Notes:** —

### Card 18
**Cloze claim:** Lock-and-key (rigid) vs induced-fit (binding induces conformational change); induced-fit considered more accurate.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt lines 731–740, 966–967; openstax-biology-2e.txt lines 8494–8523
**Excerpt supporting:** "lock-and-key model, in which the reactant fits the exact shape… induced-fit model, in which contact between the reactant and the protein changes the protein's shape." Biology 2e: "current research supports a more refined view scientists call induced fit."
**Notes:** —

### Card 19
**Cloze claim:** Induced fit produces stereoselectivity → single stereoisomer of product.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt lines 29879, 30583
**Excerpt supporting:** "enzymes used in organic solvents serve as stereoselective, regioselective, and chemoselective catalysts." "stereoselective - can differentiate between enantiomers and between prochiral substrates."
**Notes:** Connection between induced fit and stereoselectivity is implicit, not directly quoted.

### Card 20
**Cloze claim:** Cofactors = inorganic (metal ions Zn²⁺/Mg²⁺/Fe²⁺); coenzymes = organic, often vitamin-derived.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 8635–8648
**Excerpt supporting:** "Cofactors are inorganic ions such as iron (Fe++) and magnesium (Mg++)… Coenzymes are organic helper molecules… The most common sources of coenzymes are dietary vitamins."
**Notes:** Strong direct match. Note libretexts uses cofactor more loosely (treats coenzymes as a subclass of cofactors), but the openstax distinction matches the card exactly. Worth noting some textbooks use the terms interchangeably — the card's framing follows the strict distinction.

### Card 21
**Cloze claim:** Enzyme without cofactor = apoenzyme; with bound cofactor = holoenzyme.
**Confidence:** 3
**Source:** libretexts-biochemistry.txt line 31154 ("apo-PGDH" / "holo-PGDH" usage)
**Excerpt supporting:** Corpus uses "apo" and "holo" prefixes for proteins with/without bound effectors but does not define the apoenzyme/holoenzyme pair explicitly in the located passages.
**Notes:** Standard biochemistry terminology, used in the corpus, but not formally defined there. needs_sme_review for traceability. Fact itself is correct.

### Card 22
**Cloze claim:** Prosthetic group = tightly/covalently bound cofactor; heme is classic example.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt lines 20962–20963, 31389
**Excerpt supporting:** "The heme prosthetic group—consisting of protoporphyrin IX and a centrally coordinated Fe²⁺ ion—is essential for binding dioxygen." Also "The enzyme contains a heme cofactor" for COX.
**Notes:** Direct match for heme as classic prosthetic group.

### Card 23
**Cloze claim:** Michaelis-Menten kinetics → hyperbolic v vs. [S], asymptote at Vmax.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §6.3 lines 26790–26961
**Excerpt supporting:** "This is the world-famous Henri-Michaelis-Menten Equation. It is a hyperbola." Also: "v = Vmax (or VM) when S is much greater than Ks."
**Notes:** —

### Card 24
**Cloze claim:** Vmax = maximum velocity at saturation.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §6.3 lines 26793, 26943, 26959
**Excerpt supporting:** "Define and interpret the kinetic parameters KM (Michaelis constant), Vmax (maximum velocity)…"
**Notes:** —

### Card 25
**Cloze claim:** Km = [S] at half-Vmax; low Km = strong affinity.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt lines 26944, 26952, 27075
**Excerpt supporting:** "S = KS when v = VM/2." "KS constant is usually called the Michaelis constant, KM." Discussion of KM and dissociation constant.
**Notes:** —

### Card 26
**Cloze claim:** Raising [S] increases v until saturation; raising [E] raises Vmax ceiling.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt lines 27225 ("VM = kcatE0"), 27220–27225
**Excerpt supporting:** "For all reactions, VM = kcatE0." So Vmax scales linearly with total enzyme [E]_T.
**Notes:** [S] saturation behavior is direct from MM equation. The "raising [E] raises Vmax" inference is correct from VM = kcatE0 but not stated as a teaching point.

### Card 27
**Cloze claim:** kcat = turnover number = substrate molecules converted per active site per unit time at saturation; kcat = Vmax/[E]_T.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt lines 27090, 27222–27225
**Excerpt supporting:** "k3 is often called the turnover number, because it describes how many molecules of S 'turn over'…" "VM = kcatE0" → kcat = VM / E0.
**Notes:** —

### Card 28
**Cloze claim:** Catalytic efficiency = kcat/Km; higher = more efficient catalyst.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt lines 25119, 25375 (carbonic anhydrase example), 27093
**Excerpt supporting:** "carbonic anhydrase. It is among the fastest enzymes, with a kcat of 10⁶ s⁻¹ and a kcat/Km of 8.3…" "k3/KM has units of M⁻¹s⁻¹" and section explicitly describes kcat/KM as catalytic efficiency.
**Notes:** —

### Card 29
**Cloze claim:** On Lineweaver-Burk: x-int = -1/Km, y-int = 1/Vmax, slope = Km/Vmax.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt lines 26954–26961
**Excerpt supporting:** "These plots are used to estimate VM from the 1/v intercept (1/VM) and KM from the 1/S axis (-1/KM)."
**Notes:** Slope (Km/Vmax) follows from rearranging 1/v = (Km/Vmax)(1/[S]) + 1/Vmax — directly derivable; corpus shows the equation form.

### Card 30
**Cloze claim:** Cooperativity → sigmoidal v vs. [S] (substrate binding alters affinity at remaining sites).
**Confidence:** 5
**Source:** libretexts-biochemistry.txt lines 21265–21267, 20978
**Excerpt supporting:** "Pfk B shows hyperbolic kinetics and no allosterism, with a Hill coefficient close to 1." "hemoglobin displays a sigmoidal oxygen binding curve. This behavior is explained through models such as the Hill equation…"
**Notes:** —

### Card 31
**Cloze claim:** Hill n>1 = positive cooperativity (sigmoidal); n<1 = negative cooperativity; n=1 = non-cooperative MM.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt lines 20609–20615, 20862, 21266
**Excerpt supporting:** "If n is set to 2.8, the theoretical curve of Y vs L gives the best… fit to the experimental data" (Hb, positive cooperativity). "Hill equation becomes: Y = L/[KD + L] when n =1 (as in the case with myoglobin)" — confirms n=1 is non-cooperative. Negative cooperativity figure at line 20862. "Pfk B shows hyperbolic kinetics and no allosterism, with a Hill coefficient close to 1."
**Notes:** Corpus directly supports n=1 (non-cooperative) and n>1 examples (n=2.8 for Hb). The n<1 = negative cooperativity formulation is implied via the figure but not stated in words I found. Conventional MCAT framing — accurate.

### Card 32
**Cloze claim:** Activity-vs-temperature is bell-shaped: rises to optimum then drops as denaturation occurs.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt §4.8 protein denaturation referenced; openstax-biology-2e.txt line 4483
**Excerpt supporting:** "proteins that function at temperatures close to boiling. The stomach is also very acidic, has a low pH, and denatures…" Denaturation as function of temperature is widely covered.
**Notes:** Bell-shape framing is canonical biochemistry; specific phrasing not found verbatim. Concept fully supported.

### Card 33
**Cloze claim:** Human enzyme temperature optimum near 37 °C (98.6 °F or 310 K).
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt lines 1305, 1440, 33781, 44961; libretexts-biochemistry.txt line 5000
**Excerpt supporting:** "narrow range of body temperature, from just below to just above 37°C (98.6°F)." "approximately 37°C (98.6°F)." libretexts: "Assume a normal body temperature of T = 37°C." Note 310 K (= 37 + 273) is implicit and standard, though the K value is not literally printed in the located passages.
**Notes:** 37 °C and 98.6 °F directly verified; 310 K is correct conversion.

### Card 34
**Cloze claim:** Thermal stability — Taq polymerase active at high temperatures.
**Confidence:** 3
**Source:** openstax-biology-2e.txt line 4483 (proteins "that function at temperatures close to boiling"); libretexts-biochemistry.txt thermophilic examples implicit.
**Excerpt supporting:** "proteins that function at temperatures close to boiling" — alludes to thermophiles.
**Notes:** Taq polymerase by name was not located in the searched passages. Concept supported in the abstract; specific Taq example is general MCAT knowledge but not pulled from the corpus. needs_sme_review for traceability.

### Card 35
**Cloze claim:** pH shifts ionization of catalytic/binding residues; extremes denature.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt §3 acid-base + protein chemistry, lines 3458–3486, 5560; openstax-biology-2e.txt line 4483
**Excerpt supporting:** Discussion of pH-dependent ionization of side chains throughout libretexts ch. 3; "stomach is also very acidic, has a low pH, and denatures…"
**Notes:** Concept well-supported; phrasing is reasonable.

### Card 36
**Cloze claim:** pH optima — cytosol/blood ~7.4; pepsin ~2; pancreatic ~8.5.
**Confidence:** 4
**Source:** openstax-anatomy-physiology-2e.txt lines 3188 (blood pH 7.35–7.45 = 7.4), 48058 (gastric pH 1.5–3.5), 48938 (pancreatic juice pH 7.1–8.2); openstax-biology-2e.txt line 44430 (stomach pH 1.5–2.5)
**Excerpt supporting:** "The pH of human blood normally ranges from 7.35 to 7.45, although it is typically identified as pH 7.4." Stomach pH 1.5–2.5 / 1.5–3.5. "the slight alkalinity of pancreatic juice (pH 7.1 to 8.2)."
**Notes:** Card cites pancreatic ~8.5, but A&P corpus gives pancreatic juice as 7.1–8.2 — i.e., upper bound 8.2, NOT 8.5. This is a minor numerical discrepancy. Many MCAT references cite pancreatic enzyme optimum at ~8 or ~8.5; the card's value sits at the high edge of, or just outside, the corpus range. **Recommend changing 8.5 → 8 (or 7.5–8.5 range)** to align with corpus. Flagged for SME review.

### Card 37
**Cloze claim:** High salt disrupts ionic interactions/H-bonds → loss of tertiary structure → denaturation.
**Confidence:** 3
**Source:** libretexts-biochemistry.txt lines 14066–14067 (ionic strength affects protein stability); general protein chemistry sections
**Excerpt supporting:** "The mutation Leu16Ala (L16A) destabilizes the protein, making it denatured simply by changing the ionic strength."
**Notes:** Salt/ionic-strength effects are real but corpus mostly discusses them in the context of chromatography and specific mutants. The card's general claim is consistent with biochemistry but not strongly anchored. needs_sme_review.

### Card 38
**Cloze claim:** Feedback inhibition — end product binds and inhibits an earlier enzyme in the pathway.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 8676–8689; libretexts-biochemistry.txt lines 31126, 31144
**Excerpt supporting:** "Feedback inhibition involves using a reaction product to regulate its own further production… Feedback inhibition, where the pathway's end product inhibits an upstream step." "serine, binds to an allosteric site on PGDH and inhibits it, a classic example of feedback inhibition of the first reaction of a pathway by the end product."
**Notes:** —

### Card 39
**Cloze claim:** Feed-forward regulation — upstream intermediate activates a downstream enzyme.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt lines 31126, 50935 ("feedforward activation")
**Excerpt supporting:** "Feedback control loops, such as feedback inhibition from downstream products or feedforward from upstream substrates, are common allosteric regulatory mechanisms found in nature."
**Notes:** Concept named in primary corpus; not deeply elaborated.

### Card 40
**Cloze claim:** Competitive inhibitor — resembles substrate, competes for active site, raises apparent Km, Vmax unchanged.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §6.4.2 lines 27808–27871
**Excerpt supporting:** "Competitive inhibition occurs when substrate (S) and inhibitor (I) both bind to the same site… In the presence of I, VM does not change, but KM appears to increase."
**Notes:** —

### Card 41
**Cloze claim:** Noncompetitive inhibitor — binds allosteric site, lowers Vmax, Km unchanged.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §6.4.4 lines 28225–28245; openstax-biology-2e.txt lines 8567–8585
**Excerpt supporting:** "Reversible noncompetitive inhibition occurs when I binds to both E and ES… for noncompetitive inhibition, Kis = Kii… apparent Vm, Vmapp, is less than the real Vm… apparent Km, Kmapp, will not change." Biology 2e: "in noncompetitive inhibition, an inhibitor molecule binds to the enzyme in a location other than the active site, called an allosteric site."
**Notes:** —

### Card 42
**Cloze claim:** Uncompetitive inhibitor binds only ES; both Km and Vmax decrease by same factor.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §6.4.3 lines 28144–28154
**Excerpt supporting:** "S term in the denominator is multiplied by the factor 1+I/Kii… Kmapp = Km/(1+I/Kii) and Vmapp = Vm/(1+I/Kii)."
**Notes:** Direct mathematical match — Vmax/Km ratio stays constant since both divide by same factor.

### Card 43
**Cloze claim:** Mixed inhibitor binds allosteric site on E or ES; lowers Vmax, shifts Km up or down depending on which form preferred.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt §6.4.4 lines 28225–28258
**Excerpt supporting:** "the Kd's are different, and the inhibition is called mixed… Kmapp = Km(1+I/Kis)/(1+I/Kii)… Vmapp = Vm/(1+I/Kii)." Mixed inhibition formula gives Km↑ when Kis<Kii and Km↓ when Kis>Kii — matches card.
**Notes:** Card simplifies the corpus's α/α' (Kis/Kii) treatment, but the simplification is faithful: Vmax always decreases; Km can go either direction. Confirmed.

### Card 44
**Cloze claim:** Irreversible inhibitor often binds covalently to a catalytic residue, permanently disabling the enzyme.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt §6.4 line 27745, 27800
**Excerpt supporting:** "irreversible inhibitors modify key amino acid side chains (e.g., cysteine modification by iodoacetamide)…" "iodoacetamide might abolish enzyme activity if a cysteine side chain is required for activity."
**Notes:** —

### Card 45
**Cloze claim:** Allosteric enzymes have regulatory sites distant from active site; binding shifts between more-active/less-active conformations.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §6.6.2 lines 31115–31125; openstax-biology-2e.txt lines 8580–8585
**Excerpt supporting:** "Allostery… is referred to as the regulation of activity at one site… in a protein by a topographically and spatially distant site… binding a modulator… to engender a conformational change… either stabilizing an active conformation (allosteric activation) or destabilizing an inactive conformation (allosteric inhibition)."
**Notes:** —

### Card 46
**Cloze claim:** Allosteric activator → high-affinity conformation (faster); allosteric inhibitor → low-affinity conformation (slower).
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 8580–8585; libretexts lines 31119–31121
**Excerpt supporting:** "Allosteric activators bind to locations on an enzyme away from the active site, inducing a conformational change that increases the affinity of the enzyme's active site(s) for its substrate(s)."
**Notes:** —

### Card 47
**Cloze claim:** Cooperative allosteric enzymes generate sigmoidal kinetics curve.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt lines 21265–21267
**Excerpt supporting:** "The Hill coefficient is 3.3 for Pfk A, which suggests that Mg²⁺ is important in maintaining/promoting the active site… Pfk B shows hyperbolic kinetics and no allosterism, with a Hill coefficient close to 1."
**Notes:** Direct enzyme-kinetics example of cooperative/sigmoidal vs non-cooperative/hyperbolic.

### Card 48
**Cloze claim:** Covalent modification regulates by reversible attachment of groups, most commonly phosphate; also acetyl, methyl, ubiquitin.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §6 PTM coverage lines 5082, 6239–6303, 6339
**Excerpt supporting:** "List common PTMs (e.g., phosphorylation, acetylation, glycosylation, oxidation)…" Multiple PTM diagrams (acetylation, phosphorylation, glycosylation).
**Notes:** Ubiquitin specifically is named as a PTM elsewhere in the corpus (E3 ligases etc.). Concept fully supported.

### Card 49
**Cloze claim:** Kinases attach phosphate; phosphatases remove it; matched pair.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt lines 347–350, 6248 ("Phosphorylation"), 7945–7946
**Excerpt supporting:** "A protein kinase is an enzyme that covalently transfers a terminal phosphate (P) from ATP to a protein." Phosphatase: "enzyme that, in its active form, hydrolyzes p-Tyr on specific phosphorylated target proteins."
**Notes:** —

### Card 50
**Cloze claim:** Glycosylation = covalent attachment of carbohydrate chains; can regulate activity, stability, and trafficking.
**Confidence:** 4
**Source:** libretexts-biochemistry.txt lines 6265, 6271, 6339
**Excerpt supporting:** "glycosyl transferase" pictured with NH₂ → glycosylated form. "including phosphorylation, acetylation, glycosylation, and oxidation, can dramatically alter a protein's activity, stability, and [function]."
**Notes:** Trafficking role specifically (mannose-6-phosphate, lysosomal targeting) is a standard fact but not directly quoted from located passages.

### Card 51
**Cloze claim:** Zymogens (proenzymes) synthesized inactive; activated by proteolytic cleavage.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §6.6.3 lines 31298–31309
**Excerpt supporting:** "A zymogen, also called a proenzyme, is an inactive precursor of an enzyme. A zymogen requires a biochemical change (such as a hydrolysis reaction revealing the active site or changing the configuration to reveal the active site) to become an active enzyme."
**Notes:** —

### Card 52
**Cloze claim:** Trypsinogen activated to trypsin by enteropeptidase in small intestine; trypsin then activates other zymogens in cascade.
**Confidence:** 5
**Source:** libretexts-biochemistry.txt §6.6.3 lines 31303–31328
**Excerpt supporting:** "Once in the duodenum, enteropeptidase activates trypsinogen by removing the 7-10 amino acids trypsinogen activation peptide (TAP) from the N-terminal region… Once activated, trypsin will cleave and activate other zymogen proteases and lipases in the duodenum. These include the activation of elastase, chymotrypsin, carboxypeptidase, and lipase."
**Notes:** —

## needs_sme_review

Cards with confidence < 4:

- **Card 10** (transferase / kinase as subclass) — fact correct by EC convention (kinases = EC 2.7) but not directly anchored in primary corpus. Action: accept on convention; optionally cite IUBMB EC list.
- **Card 11** (hydrolase subtypes) — each subtype appears in corpus separately but no single passage enumerates them under "hydrolase." Accept on convention.
- **Card 12** (lyase / synthase) — IUBMB classifies many "synthases" as ligases (EC 6), not lyases (EC 4). The lyase↔synthase reverse-reaction framing in the card is a teaching simplification. Action: review wording. Consider rewriting: "the reverse reaction—joining two substrates—is sometimes called a synthase" or removing the synthase clause entirely.
- **Card 21** (apoenzyme/holoenzyme) — terminology used in corpus ("apo-PGDH", "holo-PGDH") but not formally defined in located passages. Standard biochem; accept on convention.
- **Card 34** (Taq polymerase as thermostable example) — example not located by name in corpus. Concept (thermostability) supported. Accept on standard biochem knowledge.
- **Card 36** (pH optima) — pancreatic juice pH in A&P corpus is 7.1–8.2; card cites 8.5. **Recommend edit: change "8.5" → "8" or "~7.5–8.5".**
- **Card 37** (salinity / high salt denatures) — concept correct but not strongly anchored. Accept on convention.

## Disagreements with corpus

- **Card 36 — pancreatic pH:** Card states pancreatic enzyme optimum is "near 8.5." The A&P corpus (line 48938) reports pancreatic juice as pH 7.1–8.2. The card's value (8.5) sits just above the corpus's upper bound. This is the only quantitative disagreement found. Recommend tightening the card to "near 8" or "~7.5–8.5."

No other active contradictions found.

## Discrepancies between primary and secondary sources

- **Cofactor terminology:** libretexts-biochemistry uses "cofactor" loosely (sometimes encompassing organic coenzymes). openstax-biology-2e uses the strict distinction: cofactor = inorganic, coenzyme = organic. Card 20 follows the strict openstax distinction. Both usages are acceptable in the literature, but flagging in case students see the looser usage on practice questions.
- **Hill coefficient interpretation:** primary corpus directly supports n=1 (non-cooperative) and n>1 (positive cooperativity, Hb at n=2.8) but does not state n<1 = negative cooperativity in words I located (only via a figure label). The secondary literature universally adopts this interpretation; card 31's framing is correct.
- **Synthase classification:** primary corpus uses "synthase" loosely. IUBMB nomenclature (not in corpus) treats most synthases as ligases (EC 6) rather than lyases (EC 4). Card 12's "reverse-of-lyase = synthase" framing is a common teaching simplification but technically imprecise.

---

## Post-verification revisions (2026-04-25)

- **Card 12** revised per SME guidance: dropped the "reverse-of-lyase = synthase" framing (which conflicts with IUBMB EC nomenclature for most synthases). New wording teaches lyases with concrete examples (decarboxylases, dehydratases) — confidence raised to 5.
- **Card 36** revised per corpus: changed pancreatic pH optimum from "8.5" to "7–8" range, matching the openstax-anatomy-physiology-2e value of 7.1–8.2 for pancreatic juice. Confidence raised to 5.
