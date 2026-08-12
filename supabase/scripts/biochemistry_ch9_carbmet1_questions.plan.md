<!-- Step 1 pre-flight record for Biochem Ch9, Carbohydrate Metabolism I, the FINAL biochem
     chapter. Cross-subject AAMC scope verdict, boundary audit against the live Ch10/11/12
     metabolism arc and the recorded Ch4 grant, independently re-verified by the synthesis
     agent, sizing decision, and the drafter contract. -->

# Biochem Ch9 — Carbohydrate Metabolism I: Sizing Verdict

## RECOMMENDED COUNT: 45 (two batches: 21 + 24)

This is an honest-sized chapter, not an open-territory 72. The Ch4 grant hands Ch9 the entire interior of glycolysis, glycogen enzymology, gluconeogenesis bypasses, feeder pathways, and half the PPP — that core is genuinely ABSENT bank-wide and dense. But the ~270-question Ch10/11/12 arc plus Ch4/Ch8/Bio Ch5/Bio Ch9/Bio Ch11 have fenced off roughly a third of the cartographer's IN_SCOPE list into premise-only status (GLUT2, GLUT4, LDH-purpose, Cori, PDH, hormonal state logic, G6Pase tissue logic, reciprocal phosphorylation). I count exactly 45 answer-turning points surviving both passes, enumerated below. Forcing 72 would require ~27 keys drawn from burned lanes — the force-fit precedent predicts ~30% redundancy. 45 matches the honest-precedent profile (Ch5: 45, Ch8: 48, minimal repair).

Verification I ran this session (not just trusting the audit):
- **GLUT2 sensor logic is KEYED**, not distractor-only: Ch12 Q62 [I19], ans B — "GLUT2's Km sits well above normal blood glucose... entry and the ATP signal rise almost in step with plasma glucose" (biochem_ch12_bioenergetics_regulation_metabolism_questions.sql, ~L1504). This resolves an internal audit contradiction (see Disagreements).
- **Fructose-2,6-bisphosphate: zero hits in Ch12** — grep "2,6-bisphos" returns 0. Apparent hits were substring false positives: "phospho**fructokinase**" matches "fructokinase". Warn drafters/auditors to grep with word boundaries.
- **GLUT5: zero hits in shipped SQL** bank-wide (appears only in biology_ch9_digestive_questions.plan.md as "zero hits bank-wide"; the shipped digestive bank did not take it). Open.
- **Glycogenin** appears once as a false-claim distractor (Ch12 L856: "stays bound to glycogenin... glucagon receptors"); never keyed. Ch9 may key its true priming role but must not reuse that distractor framing.
- Debranching, transketolase/transaldolase, aldolase B, true fructokinase, galactokinase, uridyltransferase, Rapoport-Luebering/BPG mutase: zero key hits confirmed.

---

## THE SIX JUDGEMENT CALLS

**1. PDH lane: ZERO Ch9 keys.** The honest answer is exactly the suspected one. Ch10 owns products/CO2-labeling (Q1), matrix localization/bridge (Q2), TPP/thiamine (Q6, Q9), kinase/phosphatase covalent control (Q4), allosteric/product flux (Q5, Q8); Ch11 Q62 owns the fasting acetyl-CoA feedback. The cartographer's "handoff framing (insulin stimulation, acetyl-CoA inhibition)" is NOT open — those are precisely Ch10 Q4/Q5's axes. Ruling: PDH appears in Ch9 only as an unkeyed destination noun in pyruvate-fate stems ("pyruvate that enters the mitochondrion for oxidation..."). The deck's bridge cards (33–38) carry the recall load. Zero questions budgeted.

**2. The regulation line — litmus test for drafters:** *Cover the hormone name in the stem with your thumb. If the credited answer is still fully derivable from the named effector molecule and enzyme mechanics, it is a Ch9 key. If answering requires knowing which hormone rises in which state, it belongs to Ch12 — kill it.* Hormones may appear as stem scenery ("glucagon signaling has lowered fructose-2,6-bisphosphate...") but the key must turn on: F2,6-BP potency on PFK-1/FBPase-1, the PFK-2 bifunctional kinase/phosphatase relay, AMP/ATP/citrate on PFK-1, acetyl-CoA on pyruvate carboxylase, F1,6-BP feed-forward on pyruvate kinase, NADP+/NADPH on G6PD. Hard-burned conclusions no Ch9 key may reduce to: futile-cycle-waste rationale (Ch12 Q49/~L1194), glucagon-activates-PEPCK+FBPase-1 state output (Q47), phosphorylation-activates-phosphorylase/inactivates-synthase (Q51), insulin's four-enzyme fed-liver program (~L1069).

**3. Anaerobic/Cori: ONE question, keyed on step identity.** The bare "lactate formation regenerates NAD+ so glycolysis continues" is burned TWICE outside biochem's own view: Bio Ch11 batch3 L261 (key D, verbatim) and Ch10 Q75 [I8]. The audit is internally split here (see Disagreements); ruling goes against the optimistic entry. Ch9's single open angle: **which specific reaction stalls without NAD+ — GAPDH, as the stoichiometric NAD+ consumer** — with LDH, lactate, and the tissue setting all as uncredited scenery. No Cori, no alanine cycle, no RBC-no-mitochondria crux, no oxygen debt, no sprint/creatine frames.

**4. Glycogen seam with Ch4: Ch9 gets the machinery, Ch4 keeps the structure.** Off-limits Ch4 keys (verbatim list for drafters): branching→many nonreducing ends→fast mobilization (keyed SIX times: batch3 Q7, Q8, Q9, Q11, Q20, Q22); phosphorolysis product = glucose-1-phosphate (Q21); amylase cleaves α- not β-1,4 (Q13, Q17); charged G1P/G6P retained in muscle (Q24 + batch2 esterification + Ch12 ~L858); glycogen = liver+muscle, more branched than starch (Q19); lactose/sucrose composition and epimer relationships (batch3 Q1/Q2, batch1 Q11). Ch9 owns, all grep-verified ABSENT: UDP-glucose activation, glycogen synthase's primer requirement, glycogenin self-priming, branching enzyme 4:6 block transfer, phosphorylase stalling four residues from a branch (limit dextrin), debranching's dual 4:4-transferase + α-1,6-glucosidase activities **with the one-free-glucose-per-branch arithmetic**, phosphoglucomutase, AMP/Ca²⁺ allosteric activation of muscle phosphorylase (allosteric only — hormonal glycogenolysis is Ch12/Bio Ch5), and the Von Gierke convergence-trap vignette (crux = glycogenolysis AND gluconeogenesis share the G6Pase final step; never the muscle-lacks-it fact Ch12 keys).

**5. Transporter lane: shrinks to nearly nothing — and that is the right answer.** Verified: GLUT2 high-Km sensor logic keyed (Ch12 Q62), GLUT4 recruitment keyed four ways (Ch12 L546/L1119/L1438/L1482), GLUT1 passivity + saturation keyed (Ch8 batch2 Q2/Q3), Km theory owned (Ch2 batch2). Ruling: no Ch9 question keys any GLUT-numbered fact except one — **GLUT5 as fructose's entry transporter** (zero hits bank-wide), folded into the feeder unit. The Km-to-tissue-role application the cartographer wanted survives by rerouting through **hexokinase versus glucokinase** (which IS open): low-Km ubiquitous baseline vs high-Km postprandial liver/beta-cell response, G6P product inhibition vs escape from it, insulin transcriptional induction. Km/Vmax appear as assumed premises, never defined.

**6. Feeder pathways: fully open, 6 questions.** Grep-confirmed zero keys bank-wide for galactokinase, GALT, epimerase, galactosemia, fructokinase, aldolase B, HFI, GLUT5. Cartographer marked both feeders NOT_FOUND in the outline — KEEP anyway under founder precedent (anchor: feeder-pathways line 1319 + monosaccharide lines 1311–1312; enzyme names like aldolase B have always been kept). The regulatory jewel: **fructose enters at glyceraldehyde/DHAP, below the PFK-1 checkpoint, hence unregulated flux** — a genuine MCAT-loved key nobody owns. Diseases (galactosemia, HFI) are scenery framing enzyme-step keys, never classification keys. Guard: no key may reduce to "sucrose = Glc+Fru" / "lactose = Gal+Glc" / epimer geometry (Ch4).

---

## UNIT BREAKDOWN (45 keys)

**Unit 1 — Glycolysis proper (13):** HK-vs-GK Km curve application (data question) · GK tissue restriction (liver + beta cell ONLY) + insulin induction · HK G6P product-inhibition contrast · irreversible-triad identity · PFK-1 rate-limiting + ATP/citrate inhibition · AMP energy-charge activation · F2,6-BP as most potent activator · PFK-2 bifunctional mechanism · GAPDH as sole NADH/oxidation step · PGK substrate-level phosphorylation · pyruvate kinase SLP + F1,6-BP feed-forward · net 2 ATP/2 NADH, cytosolic, O2-independent accounting · Rapoport-Luebering 2,3-BPG bookkeeping (sacrifices the PGK ATP; curve physiology stays Ch3's).

**Unit 2 — Pyruvate fates (2):** GAPDH-stall identity (judgement call 3) · enzyme/compartment fate map (LDH cytosol vs pyruvate carboxylase mito vs PDH-as-destination-noun).

**Unit 3 — Feeders (6):** GLUT5 + fructokinase F1P trap · aldolase B cleavage · below-PFK-1 unregulated entry · galactokinase trap · GALT/UDP-glucose exchange (galactosemia scenery) · epimerase + arrival via G1P→G6P.

**Unit 4 — Glycogen enzymology (9):** UDP-glucose activation (UTP, PPi pull) · synthase primer requirement · glycogenin self-priming · branching 4:6 mechanics · phosphorylase limit-dextrin stall · debranching dual activity + free-glucose arithmetic · phosphoglucomutase · AMP/Ca²⁺ allosteric phosphorylase activation · Von Gierke convergence vignette.

**Unit 5 — Gluconeogenesis bypasses (7):** bypass map (3 steps → 4 enzymes) · pyruvate carboxylase biotin + mitochondrial location · acetyl-CoA→PC activation as the PDH-off/PC-on fate switch (explicitly ABSENT; own it) · PEPCK GTP + malate shuttle of OAA to cytosol · FBPase-1 rate-limiting, AMP/F2,6-BP reciprocal inhibition · G6Pase ER-lumen compartmentalization (the audit's one clean G6Pase angle) · localization (cytosol+mito; liver primary, kidney contribution — never liver-vs-muscle, Ch12's).

**Unit 6 — PPP (8):** architecture (oxidative irreversible / non-oxidative reversible, cytosolic, G6P branch point) · G6PD committed + rate-limiting, NADP+ activation/NADPH inhibition · insulin induction of G6PD (enzyme-level) · NADPH→glutathione→ROS defense (recognition level) · G6PD-deficiency oxidative-hemolysis vignette (enzyme-step crux) · ribose-5-P for nucleotides · transketolase/transaldolase flux-mode reversibility · zero-ATP accounting. Never key "NADPH = reductive-biosynthesis currency" or PPP-feeds-lipogenesis (Ch11 Q30/Q38, Ch12 Q22).

## BATCH SPLIT

- **Batch 1 (21):** Units 1–3. Slices: A = HK/GK lane (4), B = PFK-1/PFK-2 regulation (4), C = payoff phase + energetics + 2,3-BPG (5), D = pyruvate fates + fructose arm (5), E = galactose arm (3).
- **Batch 2 (24):** Units 4–6. Slices: F = glycogen synthesis (4), G = glycogenolysis + Von Gierke (5), H1 = bypass map + PC/PEPCK (4), H2 = FBPase-1/G6Pase/localization (3), I = PPP oxidative + RBC vignette (5), J = PPP non-oxidative + accounting (3).

## BOUNDARY RULES (drafter contract)

Ch9 must NOT test — owner in parentheses:
1. Anything PDH: products, matrix, TPP, kinase/phosphatase, allosterics, thiamine (Ch10).
2. NADH shuttle destinations or whole-glucose ATP totals — Ch9 accounting stops at net 2 ATP/2 NADH (Ch10).
3. Cori cycle, alanine cycle, 6-vs-2 ATP liver bill (Ch12).
4. RBC-lacks-mitochondria fuel logic; bare "lactate regenerates NAD+" purpose (Ch12, Ch10 Q75, Bio Ch11 L261).
5. Hormone identity/direction, islet cells, GPCR-cAMP-PKA cascade (Bio Ch5; Ch12).
6. GLUT4 recruitment; GLUT2 sensor Km; GLUT1 passivity/saturation (Ch12; Ch8).
7. Km/Vmax definitions, affinity inversion, saturation logic — apply, never define (Ch2).
8. Phosphate-charge glucose trapping (Ch4 ×2, Ch12); trap-and-prime rationale and coupled-ΔG arithmetic (Ch12 Q19/Q14).
9. Ch4's structure keys: branching-speed topology, G1P product identity, amylase α/β, disaccharide composition, epimers (Ch4).
10. Muscle-lacks-G6Pase; fed-liver four-enzyme program; synthase/phosphorylase phosphorylation states; futile-cycle rationale (Ch12).
11. 2,3-BPG curve-shift physiology (Biochem Ch3).
12. Digestion/absorption, SGLT/brush border (Bio Ch9).
13. Creatine phosphate, oxygen debt, sprint frames (Bio Ch11).
14. Gluconeogenic substrate eligibility: glycerol-vs-FA (triple-keyed), acetyl-CoA carbon bookkeeping, odd-chain (Ch10/11/12).
15. Anaplerosis-refills-OAA rationale (Ch10 Q34); bare block-the-slowest-step flux template (Ch11).

## OFF-OUTLINE: DROP vs KEEP

**KEEP (commonly tested; founder precedent):** every named enzyme above including PFK-2, aldolase B, fructokinase, galactokinase/GALT/epimerase, glycogenin, phosphoglucomutase, PEPCK, G6PD, transketolase/transaldolase; biotin as PC cofactor; GLUT5; Km-role logic (applied); Rapoport-Luebering bookkeeping; Von Gierke/galactosemia/HFI/G6PD-deficiency as scenery-framed enzyme-step vignettes.

**DROP:** glutathione mechanism beyond recognition (GSH/GSSG chemistry); respiratory-burst/NADPH-oxidase mechanics (deck card suffices); Wernicke-Korsakoff/transketolase clinical; McArdle/Cori-disease/Pompe classification; F1P hepatotoxicity depth beyond the aldolase-B step; bare name-recall of middle glycolytic enzymes (aldolase A, TPI, enolase, mutases — reachable only through the SLP/NADH cruxes); 2,3-BPG hemoglobin physiology.

## ERRATA (two)

1. **Source-doc glare truncation:** the summary's anaerobic bullet cuts off at "red blood cells, skeletal muscle during short intense bursts, and any cell [—]". The missing clause is almost certainly "any cell lacking mitochondria" (Kaplan also lists cornea/lens). Writers MUST source anaerobic-conditions content from LibreTexts/OpenStax, not the summary. Do not guess the list into a key.
2. **Live flashcard error:** flashcard_cloze_quality_fixes_20260715.sql line 67 has a live card claiming insulin activates glucokinase "in the liver and muscle" — glucokinase is liver + pancreatic beta cells only; muscle uses hexokinase. Ch9 questions must carry the correct distribution, and a one-line card fix should ship alongside the chapter so cards and questions do not contradict each other.

## CARTOGRAPHER vs AUDITOR DISAGREEMENTS (ruled, not smoothed)

1. **GLUT2 sensor:** cartographer IN_SCOPE (concept #1); auditor split internally — one entry claimed GLUT2 kinetics live "only in distractor rationales," another cited Ch12 L1504 as a key. **Verified this session: it is a full key (Ch12 Q62 [I19] ans B).** Auditor's pessimistic entry wins; the optimistic entry was wrong. GLUT2 = premise only.
2. **Bare NAD+-regeneration purpose:** audit internally contradictory (RBC entry: "keyed nowhere" vs Bio Ch11 entry: "ALREADY BURNED at L261"). Ruling: burned — Bio Ch11 L261 and Ch10 Q75 both key it. Only GAPDH step-identity survives.
3. **PDH handoff regulation:** cartographer IN_SCOPE; auditor shows every axis keyed. Ruling: zero Ch9 keys.
4. **GLUT4:** cartographer IN_SCOPE; Ch12 keys it four ways. Deck-only.
5. **Liver-vs-muscle glycogen purpose:** cartographer IN_SCOPE; triple-keyed in Ch12. Premise only.
6. **Phosphorylase/synthase reciprocal switching:** cartographer IN_SCOPE; Ch12 Q51 keys it. Premise only; Ch9 keys allosteric (AMP/Ca²⁺), not covalent, control.
7. **Feeders NOT_FOUND vs OWN IT:** cartographer flagged both feeder pathways NOT_FOUND in the outline; auditor says wide open. Ruling: KEEP per founder precedent, anchored to line 1319 + monosaccharide lines — but this is the chapter's weakest outline anchor; keep keys at enzyme-step/entry-point level.

## LANES ORPHANED BY THE BANK CLOSING (explicit, since no future biochem chapter exists)

- **McArdle, Cori disease, Pompe** (glycogen storage diseases beyond Von Gierke): deliberately orphaned. Passage-supported territory if ever needed; not worth discrete keys.
- **Respiratory burst / NADPH oxidase mechanism:** deliberately orphaned at question level; Ch9 deck card covers recall.
- **Beta-cell K_ATP/Ca²⁺ secretion-coupling machinery:** lives only in a Ch12 explanation; Bio Ch5 is complete and did not key it. Deliberately orphaned — AAMC-marginal.
- **Rapoport-Luebering shunt** and **transketolase/transaldolase non-oxidative branch**: would be orphaned if Ch9 declined them — Ch9 takes both (Unit 1 Q13, Unit 6 Q44).

Key file paths: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/supabase/scripts/biochem_ch12_bioenergetics_regulation_metabolism_questions.sql (GLUT2 key verified ~L1495–1515; glycogenin distractor L856), /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/supabase/scripts/flashcard_cloze_quality_fixes_20260715.sql (erratum L67), /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/supabase/seeds/biochemistry_ch9_carbohydrate_metabolism_i_flashcards.sql (deck alignment).

---

# APPENDIX A: scope verdict, all 34 concepts

| Concept | Verdict | Outline home | Line |
|---|---|---|---|
| GLUT2 in liver and pancreatic beta cells, HIGH Km, part of the glucose sensor | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Hormonal Regulati | 1383 |
| GLUT4 in adipose and muscle, insulin-stimulated, LOW Km | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Hormonal Regulati | 1384 |
| Km logic connecting transporter/enzyme kinetics to tissue role | IN_SCOPE | 1A: Structure and function of proteins — Control of Enzyme Activity | 1033 |
| Glycolysis in the cytoplasm of all cells, oxygen-independent, net 2 ATP per glucose | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Glycolysis, Gluco | 1318 |
| Glucokinase versus hexokinase (tissue distribution, glucose sensor role, insulin responsiveness) | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1330 |
| PFK-1 as the rate-limiting step, activated by AMP and fructose 2,6-bisphosphate, inhibited by ATP and citrate | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1330 |
| PFK-2 producing fructose 2,6-bisphosphate, activated by insulin, inhibited by glucagon | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Hormonal Regulati | 1384 |
| Glyceraldehyde-3-phosphate dehydrogenase producing NADH | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Glycolysis, Gluco | 1318 |
| 3-phosphoglycerate kinase and pyruvate kinase as substrate-level phosphorylations | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Glycolysis, Gluco | 1323 |
| The three irreversible glycolytic enzymes (glucokinase/hexokinase, PFK-1, pyruvate kinase) | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1330 |
| Feeder inputs: where fructose and galactose intermediates enter glycolysis | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Glycolysis, Gluco | 1319 |
| NADH reoxidized by the electron transport chain when oxygen is present; lactate dehydrogenase regenerating NAD+ in the cytoplasm when oxygen or mitochondria are absent (red cells, bursting skeletal muscle) | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Glycolysis, Gluco | 1320 |
| Why NAD+ regeneration is REQUIRED for glycolysis to continue | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Glycolysis, Gluco | 1320 |
| Galactose from lactose: galactokinase trapping, galactose-1-phosphate uridyltransferase, the epimerase, arrival at glucose 1-phosphate | NOT_FOUND | - | - |
| Fructose from sucrose and fruit: fructokinase trapping, aldolase B cleaving to glyceraldehyde and DHAP | NOT_FOUND | - | - |
| Pyruvate dehydrogenase as the complex converting pyruvate to acetyl-CoA, stimulated by insulin, inhibited by acetyl-CoA (handoff framing only) | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Citric Acid Cycle | 1338 |
| Glycogen synthase forming alpha-1,4 glycosidic links, activated by insulin in liver and muscle | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1332-1333 |
| Branching enzyme moving an oligoglucose block onto a new alpha-1,6 branch | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1331 |
| Glycogen phosphorylase releasing glucose 1-phosphate by breaking alpha-1,4 links, activated by glucagon in liver and by epinephrine and AMP in exercising muscle | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1332-1333 (also 1319) |
| Debranching enzyme moving a block back to the main chain and hydrolysing the alpha-1,6 branchpoint to release one free glucose | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1331 |
| Phosphorylase-versus-synthase reciprocal regulation logic | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1332-1333 |
| Why liver glycogen serves blood glucose while muscle glycogen serves the muscle itself | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Hormonal Regulati | 1383-1384 |
| Gluconeogenesis occurs in cytoplasm and mitochondria, mainly liver with a kidney contribution | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Glycolysis, Gluco | 1321 |
| Gluconeogenesis is the reversal of glycolysis except at the three irreversible steps | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Glycolysis, Gluco | 1321 |
| Pyruvate carboxylase to oxaloacetate (activated by acetyl-CoA from beta-oxidation) and PEPCK to phosphoenolpyruvate (activated by glucagon and cortisol), together bypassing pyruvate kinase | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism | 1321 |
| Fructose-1,6-bisphosphatase as the rate-limiting step, activated by ATP, inhibited by AMP, controlled oppositely to PFK-1 through fructose 2,6-bisphosphate | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1330 |
| Glucose-6-phosphatase in the liver endoplasmic reticulum releasing free glucose, bypassing glucokinase, and why muscle lacks it | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism | 1321 |
| Reciprocal-regulation principle: the same fructose 2,6-bisphosphate signal speeding glycolysis while braking gluconeogenesis | IN_SCOPE | 1D: Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1330 |
| The pentose phosphate pathway (hexose monophosphate shunt) in the cytoplasm of most cells | IN_SCOPE | 1D. Principles of bioenergetics and fuel molecule metabolism — Glycolysis, Gluco | 1322 |
| Two products of the pathway: NADPH and ribose 5-phosphate (biosynthetic sugars from ribulose 5-phosphate) | IN_SCOPE | 1D. Principles of bioenergetics and fuel molecule metabolism | 1322 |
| Glucose-6-phosphate dehydrogenase as the rate-limiting enzyme, activated by NADP+ and insulin, inhibited by NADPH | IN_SCOPE | 1D. Principles of bioenergetics and fuel molecule metabolism — Principles of Met | 1328 |
| What NADPH is FOR (reductive biosynthesis, antioxidant defense) as distinct from NADH | IN_SCOPE | 1D. Principles of bioenergetics and fuel molecule metabolism — Oxidative Phospho | 1368 |
| Why red cells depend on the shunt (glutathione and oxidative protection, recognition level) | IN_SCOPE | 1D — Oxidative Phosphorylation (oxidative stress); erythrocytes under 3B circula | 1376 |
| The pathway sharing glucose 6-phosphate with glycolysis as a branch point | IN_SCOPE | 1D. Principles of bioenergetics and fuel molecule metabolism | 1315 |

# APPENDIX B: boundary audit, all 41 findings

### PDH complex: products, cofactors, localization

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch10_carbohydrate_metabolism_2_questions.sql`
- **Evidence:** Ch10 owns a 9-question PDH lane. Q1 key: 'One 14CO2 departs and NAD+ is reduced to NADH' (labeled-carboxylate stem). Q2 key: 'resides in the mitochondrial matrix and bridges glycolysis to the citric acid cycle after pyruvate is imported'. Q6 key: 'Thiamine (B1), whose pyrophosphate form is required for the first decarboxylation step'. Q9 key: thiamine deficiency -> 'Pyruvate accumulates and is reduced to lactate... lactic acidosis'. Q3 keys thioester acyl-transfer chemistry of acetyl-CoA.
- **Recommendation:** AVOID IT — Ch10 fully owns PDH products, matrix localization, TPP cofactor, and the thiamine-deficiency/lactic-acidosis clinical angle.

### PDH regulation: kinase/phosphatase, allosterics, product inhibition

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch10_carbohydrate_metabolism_2_questions.sql`
- **Evidence:** Ch10 Q4 key: 'PDH kinase is activated by high ATP and phosphorylates the complex, inactivating it' (stem names 'two enzymes that add or remove a phosphate group', so the phosphatase side is in-scene). Q5 key: 'pyruvate and ADP activate the complex while low acetyl-CoA and NADH relieve product inhibition'. Q8 key (data table): high ATP/ADP or NADH/NAD+ ratios each suppress activity. Ch11 Q62 key: 'Inhibiting PDH blocks conversion of pyruvate to acetyl-CoA' (ketone-body feedback sparing glucose).
- **Recommendation:** AVOID IT — every regulatory axis (covalent, allosteric, product, fasting acetyl-CoA feedback) already carries a live key across Ch10/Ch11.

### Cori cycle (and glucose-alanine cycle)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 Q32 [E10] key: 'Muscle makes lactate to regenerate NAD+ so anaerobic glycolysis can continue, and the liver spends ATP rebuilding that lactate into glucose, so the cycle's energy cost falls on the liver'. Ch12 Q33 [E11] keys the Cahill/alanine cycle: 'ferries amino nitrogen from muscle to liver as nontoxic alanine... carbon skeleton feeds gluconeogenesis'.
- **Recommendation:** AVOID IT — both the NAD+-regeneration logic and the ATP-cost-shift-to-liver logic are the live keys; there is no unburnt angle left on the tissue cycle itself.

### Anaerobic glycolysis / RBC glucose-only / muscle-burst lactate

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 Q34 [E12] key: 'red blood cells, lacking mitochondria, metabolize it anaerobically to lactate in every metabolic state'; Q74 [J10] key: 'Red blood cells lack mitochondria... only cytoplasmic glycolysis of glucose remains'; Q76 [J12] key repeats the same logic; Q37 [F15] key: 'Anaerobic glycolysis of muscle glycogen, generating lactate'; Q70 [J6] keys oxygen-debt repayment. Ch10 Q75 [I8] key: cell 'shifts to anaerobic glycolysis, using lactate dehydrogenase to regenerate NAD+'.
- **Recommendation:** AVOID IT — RBC no-mitochondria logic is triple-keyed and the LDH/NAD+-regeneration purpose is keyed twice; Ch9 must present LDH only as scenery, never as the deciding fact.

### Glucose-6-phosphatase liver-only logic

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 Q35 [E13] key: 'Skeletal muscle lacks glucose-6-phosphatase, so the glucose-6-phosphate freed from its glycogen cannot be dephosphorylated and released'; Q48 [G5] key: 'only the liver has glucose-6-phosphatase, so muscle cannot dephosphorylate its glycogen-derived glucose-6-phosphate for export'; Q75 [J11] key: 'Only liver glycogen supplies glucose to the bloodstream'. Ch4 batch3 Q24 key: the charged phosphate traps the sugar in the muscle cell (membrane logic).
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — the tissue-distribution and phosphate-trap logic are burnt (3+ keys); the only clean angle is G6Pase's ER-lumen compartmentalization (G6P must be transported into the ER before hydrolysis), which no question touches.

### Hormonal STATE logic: insulin/glucagon switching, cortisol, epinephrine, fed/fasting

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Enumerated STATE keys: Q23 GLUT4 vs insulin-independent brain GLUT1/3; Q24 glycogenolysis-before-gluconeogenesis early fast; Q25 post-depletion gluconeogenic substrates (lactate/glycerol/AAs); Q26+Q27 ketone-adapted brain spares protein; Q29 catecholamine glucose defense; Q43 fed-state resumption; Q44 [G1] fed-liver four-enzyme flux logic (glucokinase/glycogen synthase up, phosphorylase/G6Pase down); Q46 beta-cell secretion proportional to glucose; Q47 [G4] glucagon activates glycogenolysis + gluconeogenesis 'via PEP carboxykinase and fructose-1,6-bisphosphatase' + ketogenesis; Q49 [G6] PFK-1/FBPase-1 futile-cycle-prevention rationale; Q50 islet insulin:glucagon ratio flip; Q51 [G8] phosphorylation activates phosphorylase / inactivates synthase; Q52+Q64 cortisol transcriptional gluconeogenesis; Q57+Q58 fast cAMP catecholamine vs slow cortisol; Q60 reversible covalent modification via surface receptors.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — Ch9 should key ENZYME-LEVEL allosterics that no Ch12 key touches: fructose-2,6-bisphosphate on PFK-1/FBPase-1 (zero hits bank-wide), AMP/ATP/citrate on PFK-1, fructose-1,6-BP feed-forward on pyruvate kinase, alanine inhibition of liver PK. Constraint: the futile-cycle RATIONALE (Q49), the glucagon-names-PEPCK/FBPase state conclusion (Q47), and synthase/phosphorylase phosphorylation states (Q51) are keyed — Ch9 stems may use hormonal state as setup but the correct answer must turn on the named effector molecule, not the state outcome.

### Acetyl-CoA allosterically activating pyruvate carboxylase

- **Status:** ABSENT
- **Owner:** `biochem_ch11_lipid_amino_acid_metabolism_questions.sql`
- **Evidence:** No key anywhere turns on acetyl-CoA activating PC. Adjacent keys that must not be re-keyed: Ch10 Q34 [D9] keys anaplerosis rationale ('carboxylating pyruvate to oxaloacetate (anaplerosis) refills the acceptor pool'); Ch11 Q58 [I17] keys OAA diverted to gluconeogenesis causing ketogenesis; Ch11 Q62 keys acetyl-CoA inhibiting PDH. The activation of PC itself is never even mentioned.
- **Recommendation:** OWN IT — key the acetyl-CoA -> pyruvate carboxylase allosteric switch (the PDH-off/PC-on reciprocal fate decision), plus biotin as PC's cofactor; keep the anaplerosis-refills-OAA rationale and OAA-depletion-ketogenesis logic as scenery only.

### Galactose metabolism (galactokinase, GALT, epimerase, galactosemia)

- **Status:** ABSENT
- **Owner:** `biochemistry_ch4_carbohydrates_batch3.sql`
- **Evidence:** Zero hits for galactokinase/GALT/epimerase/galactosemia in Ch10/11/12. Ch4 owns only structure-level facts: batch3 Q2 keys lactose composition 'Galactose and glucose'; batch1 keys galactose/glucose epimer relationships (Q11 'epimers, differing... at C2').
- **Recommendation:** OWN IT — the whole galactokinase -> GALT -> UDP-epimerase pathway and galactosemia are unclaimed; just don't let a key reduce to 'lactose = Gal + Glc' or the epimer relationship, which Ch4 keys.

### Fructose metabolism (fructokinase, aldolase B, PFK-1 bypass)

- **Status:** ABSENT
- **Owner:** `biochemistry_ch4_carbohydrates_batch3.sql`
- **Evidence:** Zero hits for fructokinase/aldolase B/hereditary fructose intolerance in Ch10/11/12. Ch4 owns only: batch3 Q1 key sucrose = 'Glucose and fructose'; batch2 Q11 keys fructose's base-catalyzed tautomerization to a reducing aldehyde.
- **Recommendation:** OWN IT — fructokinase/aldolase B, fructose entering glycolysis below the PFK-1 control point, and HFI are all unclaimed lanes; avoid keys reducible to sucrose composition or fructose reducing-sugar chemistry.

### NADPH roles and the pentose phosphate pathway

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch11_lipid_amino_acid_metabolism_questions.sql`
- **Evidence:** Ch11 Q30 [E10] key: 'NADPH... is the cell's reductive-biosynthesis currency' for FA synthesis; Q33 keys the '42 NADPH and 24 acetyl-CoA' palmitate-scale count; Q38 [F18] key IS a PPP key: 'The pentose phosphate pathway, whose oxidative branch oxidizes glucose-6-phosphate' as the NADPH regenerator for lipogenesis. Ch12 Q22 [C22] keys the NAD+ (acceptor) vs NADPH (donor) redox-poise division of labor. However, G6PD, glutathione, respiratory burst, and the non-oxidative branch have ZERO hits.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — 'PPP oxidative branch supplies NADPH for fat synthesis' and 'NADPH = biosynthetic currency' are burnt keys; Ch9's PPP lane should key G6PD as the rate-limiting committed step and its NADP+ regulation, NADPH's glutathione/antioxidant role in RBCs (G6PD deficiency), and the non-oxidative branch (ribose-5-phosphate for nucleotides, transketolase/transaldolase reversibility) — all completely unclaimed.

### Ch4 grant: glycogen/starch structure, alpha-1,4/alpha-1,6 links, breakdown chemistry

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch4_carbohydrates_batch3.sql`
- **Evidence:** Batch3 header reads 'complex carbohydrates + metabolism-lite' — the literal deferral sentence ('full glycolysis/gluconeogenesis/PPP deferred...') does NOT appear in the SQL or verification files, but the grant is visible in scope: only 2 'Carbohydrate Metabolism' questions exist. Live Ch4 structure keys Ch9 must not re-key: branching -> many non-reducing ends -> rapid parallel mobilization (Q7, Q8, Q9, Q11, Q20, Q22 — six keys on this one fact); amylase cleaves alpha not beta-1,4 (Q13, Q17); glycogen phosphorylase phosphorolysis product = 'Glucose-1-phosphate' with the saved-ATP logic in-stem (Q21); starch digestion -> portal glucose (Q23); charged G1P/G6P retained in muscle (Q24); glycogen = liver+muscle, more branched than starch (Q19).
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — Ch9's glycogen lane should key the ENZYME MACHINERY Ch4 never touched: UDP-glucose activation and glycogen synthase, glycogenin priming, branching enzyme's 4:6 transferase action, debranching enzyme's dual 4:4 transferase + alpha-1,6-glucosidase activities, phosphoglucomutase — zero hits on all of these. Never let a Ch9 key reduce to 'branching makes many non-reducing ends for speed' or 'the product is G1P'.

### Glycolysis proper: ten steps, PFK-1 rate limitation, hexokinase vs glucokinase, SLP steps, 2,3-BPG

- **Status:** ABSENT
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** No question in Ch10/11/12/Ch4 keys the glycolytic reaction sequence, PFK-1's rate-limiting identity, hexokinase-vs-glucokinase kinetics (Km/Vmax/induction), glycolytic substrate-level phosphorylation steps, or 2,3-BPG. Four carve-outs already keyed in Ch12: Q14 [B14] keys the hexokinase coupled-Delta-G arithmetic ('-16.7 kJ/mol; favorable'); Q19 [C19] keys the trap+prime rationale for immediate glucose phosphorylation; Q44 keys glucokinase-trapping inside fed-state logic; Q49 keys the PFK-1/FBPase-1 futile-cycle rationale.
- **Recommendation:** OWN IT — this is the core of Ch9. Key the pathway's enzymology, regulation (with the F2,6-BP mechanism), hexokinase/glucokinase kinetic contrast, glycolytic SLP steps (phosphoglycerate kinase, pyruvate kinase), net 2 ATP/2 NADH accounting, and 2,3-BPG shunt; write around the four Ch12 carve-outs (no key may reduce to coupled-Delta-G arithmetic, trap-and-prime, or futile-cycle-waste rationale).

### Gluconeogenesis bypass enzymology (PC, PEPCK, FBPase-1, G6Pase as the four bypasses)

- **Status:** MENTIONED_ONLY
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** PEPCK and FBPase-1 appear by name only inside Ch12 Q47's hormone-state key (which turns on glucagon's coordinated hepatic output, not on bypass chemistry). What IS keyed nearby: substrate list post-glycogen-depletion (Ch12 Q25); glycerol -> DHAP gluconeogenic vs fatty acids cannot give net glucose (keyed THREE times: Ch10 Q7, Ch11 Q16, Ch12 Q69); even-chain acetyl-CoA no-net-glucose carbon bookkeeping (Ch10 Q15, Q13; Ch11 Q56 odd-chain exception).
- **Recommendation:** OWN IT — key which irreversible glycolytic steps require which bypass enzymes, the PC(biotin/ATP) -> PEPCK(GTP) two-step PEP route and its mitochondria/cytosol malate shuttling; AVOID re-keying the substrate list, the glycerol-vs-fatty-acid contrast (triple-keyed), and acetyl-CoA carbon bookkeeping.

### Glycolytic NADH shuttle fate and whole-glucose ATP yields

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch10_carbohydrate_metabolism_2_questions.sql`
- **Evidence:** Ch10 I-lane owns the shuttles: Q69 keys malate-aspartate -> Complex I (three pumping complexes); Q70 keys glycerol-3-phosphate -> CoQ bypassing Complex I; Q71 key: '2 ATP (~32 for malate-aspartate versus ~30 for glycerol-3-phosphate)'. Ch10 L-lane keys whole-glucose yield: Q93 '~32 ATP', Q36 '10 ATP' per cycle turn, Q37 '20 ATP'.
- **Recommendation:** AVOID IT — Ch9 may state that cytosolic NADH exists as scenery, but any key about where those electrons enter the ETC or total-glucose ATP arithmetic collides with Ch10; keep Ch9's accounting strictly within glycolysis (net 2 ATP / 2 NADH, which is unclaimed).

### Insulin/glucagon secretion and hormonal mechanism (blood-sugar hormone lane)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biology_ch5_endocrine_questions_batch4.sql`
- **Evidence:** Bio Ch5 batch4 'Endocrine Pancreas' keys the entire hormonal lane: L10 key A (delta-cell somatostatin dampens both insulin and glucagon), L23 key B (alpha cells raise glucagon on fasting hypoglycemia), L36 key C (post-meal pancreatic hormone that returns glucose to baseline = insulin), L49 key D (fasting glycogenolysis+gluconeogenesis driven by alpha-cell glucagon), L62 key B (somatostatin-secreting tumor suppresses both hormones), L75 key C (insulin drives storage/anabolic activity in muscle/adipose/liver), L88 key D and L101 key A (type-1 autoimmune beta-cell loss versus insulin resistance with high insulin + high glucose), L127 key D (insulin identity for post-meal glucose fall), L140 key A (insulin-mimetic overdose reversed by alpha-cell glucagon), L153 key B (glucagon activates the glycogenolysis + gluconeogenesis pair in hepatocytes). Batch1 additionally keys glucagon's transduction machinery: L248 (glucagon acts via a plasma-membrane receptor, unlike cortisol), L448 (after cAMP rises, the next step is PKA activation), L511 (adenylyl-cyclase inhibition abolishes glucagon-driven glycogenolysis), L586 (GPCR-cAMP-PKA cascade output = glycogen breakdown/glucose release). Batch3 keys cortisol raises fasting glucose (L191, L204 key B) and adrenal-medulla epinephrine spikes glucose in seconds via glycogenolysis (L320). Ch12 (biochem_ch12_..._questions.sql L1119 key B) also keys the beta-cell sense-glucose -> secrete-insulin-in-proportion -> GLUT4-uptake loop; the K_ATP/Ca2+ secretion cascade appears only in an explanation (L1506) so the detailed coupling machinery is MENTIONED_ONLY, but the sense-and-respond level is keyed.
- **Recommendation:** AVOID IT — no Ch9 key may turn on which hormone/islet cell does what, hormonal direction, counter-regulation, or the GPCR-cAMP-PKA cascade; hormones may appear only as scenery framing purely enzymatic/kinetic keys.

### GLUT4 insulin-recruitment (translocation, tissue selectivity)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Verified — Biochem Ch12 keys it four separate times: L546 key C (insulin recruits GLUT4 to muscle/adipose membranes while brain uses insulin-independent GLUT1/GLUT3 — tissue-selective uptake), L1119 key B (beta cells sense glucose, insulin drives GLUT4-mediated uptake), L1438 key C (fasting: neurons keep importing via constitutive GLUT1/GLUT3 while resting muscle loses GLUT4 surface recruitment), L1482 key A (mechanism itself: pre-formed GLUT4 vesicles translocate to the membrane with no new protein synthesis, transcription/translation-block experiment). Distractor metadata also burns 'brain uses GLUT2' (L1451) and 'both tissues use GLUT4' (L1455).
- **Recommendation:** AVOID IT — GLUT4 recruitment is exhausted in Ch12 at both the tissue-logic and vesicle-mechanism levels; GLUT4 may appear in Ch9 only as an unkeyed premise.

### GLUT1 red-cell passive/facilitated glucose uptake

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch8_membranes_questions_batch2.sql`
- **Evidence:** Verified fresh Ch8 batch2 key — B2 Q3 (L75-87), key A: ATP-poison experiment on circulating RBCs; correct answer turns on GLUT1 transport being driven by the glucose gradient, not metabolic energy (facilitated diffusion is passive). GLUT1 also appears as a burned distractor in the aquaporin item (L139-141). CRITICAL for the suggested replacement angle: the GLUT2 high-Km beta-cell sensor logic is ALSO already keyed — Ch12 L1504 key B (GLUT2's Km sits above blood glucose so it never saturates, letting uptake and the ATP signal track plasma glucose), plus GLUT2-misassignment distractors at Ch12 L554/L564 and L1442. So BOTH 'facilitated diffusion is passive' (Ch8) and the GLUT2-sensor-Km logic (Ch12) are taken.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — do not re-key passivity (Ch8) or the GLUT2-sensor/GLUT4 tissue contrast (Ch12); key the transport step Ch9 alone owns: hexokinase-versus-glucokinase Km/trapping consequences downstream of entry (glucose-6-phosphate keeps the intracellular free-glucose gradient inward), or fructose's GLUT5 entry point — transporters as premise, enzyme/kinetic consequence as key.

### Carbohydrate digestion and absorption, SGLT sodium-coupled uptake

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biology_ch9_digestive_questions_batch3.sql`
- **Evidence:** Bio Ch9 batch3 'Sugar salt coupling in rehydration fluid' (~L605-624), key B: oral-rehydration glucose works because the sugar 'is carried in only alongside sodium, and the extra solute taken up draws fluid after it' — the SGLT secondary-active mechanism is the correct answer, with the Na+/K+-pump-as-energy-source reasoning in the Choice A rebuttal (L624). Also keyed in the digestive lane: brush-border (membrane-bound) locus of final disaccharide digestion (batch2 L594-607, key C experiment triad) and disaccharidase-loss osmotic/fermentation consequence (batch3 L59-90, key A). Biochem Ch8 batch2 separately keys primary-versus-secondary active transport classification (L301-303, key A) and uniporter/symporter/antiporter vocabulary (L327-334); Ch8's own header comment (L11) records that cotransport keys were deliberately left to the Bio bank.
- **Recommendation:** AVOID IT — Ch9 starts at cytosolic glucose; no keys on amylase/disaccharidases, brush-border locus, SGLT/sodium coupling, or primary-versus-secondary transport energetics.

### Exercise muscle metabolism: creatine phosphate, oxygen debt, lactate/NAD+ regeneration, Cori cycle

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biology_ch11_musculoskeletal_batch3.sql`
- **Evidence:** Bio Ch11 batch3 'Muscle Energetics & Fatigue' keys: L248 key C (creatine phosphate transfers phosphate to ADP as the first-seconds ATP source), L261 key D (pyruvate-to-lactate conversion 'regenerates NAD+ from NADH for glycolysis' — the classic why-fermentation key is ALREADY BURNED here, outside biochem), L274 key A (post-exercise oxygen uptake restores ATP/creatine phosphate and reconverts lactate), L295 key B (36-ATP efficiency depends on mitochondrial oxidation, with cytosolic NAD+ regeneration as burned distractor A), L308 key D (oxygen-debt repayment includes creatine-phosphate restoration AND hepatic conversion of lactic acid to glucose — coarse Cori cycle), L333 (burst ATP mechanism). Reengineered file repeats the creatine-phosphate/lactate-clearing keys (L167, L398). Fast-glycolytic-versus-slow-oxidative fiber fuel logic keyed throughout L9-L108.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — no sprint/creatine/oxygen-debt frames and never re-key 'lactate regenerates NAD+'; Ch9 owns the enzyme-level layer Bio Ch11 never touches: GAPDH's stoichiometric NAD+ requirement as the stall point, substrate-level phosphorylation step identity (PGK, pyruvate kinase), and the Cori cycle at the gluconeogenic-bypass-enzyme level (pyruvate carboxylase/PEPCK asymmetry), which is unkeyed anywhere.

### Red-cell metabolism (obligate anaerobic glycolysis, RBC glucose handling, 2,3-BPG)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Three live claims on the RBC: (1) Ch12 L831 key B — brain and RBC keep taking up glucose without insulin, and the mitochondria-less RBC 'metabolizes it anaerobically to lactate in every metabolic state' (RBC-glucose key confirmed; L1851 re-argues RBC insulin-independence in a rebuttal). (2) Ch8 batch2 Q3 (L75-87) key A — RBC GLUT1 passive entry. (3) Biochem Ch3's oxygen-binding lane keys 2,3-BPG's physiological effect: biochemistry_ch3_depth_batch3.sql L102-127 key A (high-altitude rise in erythrocyte 2,3-BPG raises P50, lowers affinity, increases tissue unloading), alongside Bohr-shift key (L77-97) and P50/affinity-reading keys (L132-180).
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — the RBC's fuel logic, GLUT1 entry, and 2,3-BPG's curve-shifting effect are all keyed; Ch9 owns only the pathway origin: the Rapoport-Luebering shunt (1,3-BPG diverted to 2,3-BPG, sacrificing the phosphoglycerate-kinase substrate-level ATP), keyed as glycolytic accounting with the hemoglobin effect as unkeyed scenery.

### Enzyme kinetics Km/Vmax theory

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch2_enzymes_batch2.sql`
- **Evidence:** Confirmed ownership: batch2 carries a dedicated 'Michaelis-Menten Kinetics (Vmax, Km, Saturation)' subtopic lane (L113-230, ~10 items) keying the Km definition (substrate concentration at half-Vmax), the low-Km-equals-high-affinity comparison between two enzymes (L165), saturation/Vmax plateau logic (L152, L178, L217), cross-enzyme Km-affinity ranking (L191), and v0 arithmetic from Km/Vmax (L204).
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE (apply, never define) — Ch9 may key the physiological consequence of hexokinase-versus-glucokinase Km values (which tissue keeps phosphorylating at low glucose, why liver only responds post-prandially), but the definition of Km, the affinity inversion, and Vmax saturation logic must appear only as assumed premises.

### Galactosemia / hereditary fructose intolerance disease classification

- **Status:** ABSENT
- **Owner:** `scripts`
- **Evidence:** Bank-wide grep for 'galactosemia', 'fructose intolerance', and 'aldolase B' across all scripts returns zero hits. Free-galactose/fructose metabolism is untested everywhere: the only non-glycolytic fructose mentions in the whole bank are Bio Ch2 batch3 seminal-vesicle items (L213-241, fructose as sperm-motility fuel — a reproduction-anatomy key, not a metabolism key), and the only galactose string hits are false positives. Galactokinase, GALT, epimerase, fructokinase, and GLUT5 entry appear nowhere.
- **Recommendation:** OWN IT — galactose and fructose metabolic pathways (galactokinase -> GALT -> UDP-glucose epimerase; fructokinase -> aldolase B entering glycolysis below PFK-1, hence unregulated) are wide open for Ch9; per house rule, the diseases themselves stay strictly scenery framing enzyme-step keys, never classification keys.

### Ch4 deferral grant (the recorded contract)

- **Status:** MENTIONED_ONLY
- **Owner:** `biochemistry_ch4_carbohydrates_batch3.sql`
- **Evidence:** There is no literal sentence saying 'deferred to Ch9' anywhere in the Ch4 scripts. The recorded grant is the batch label, present in three places. Exact line, biochemistry_ch4_carbohydrates_batch3.sql line 1: '-- Carbohydrate Structure and Function — Batch 3 — complex carbohydrates + metabolism-lite'. Mirrored in biochemistry_ch4_carbohydrates_batch3.verification.md line 1 ('(Batch 3 — complex carbohydrates + metabolism-lite)') and in commit 3753a2c's body ('Batch 3 (24): complex carbohydrates + metabolism-lite — disaccharides, polysaccharides, cellulose, starch, glycogen, digestion.'). The 'lite' restraint is verifiable in the shipped content: only 2 'Carbohydrate Metabolism' questions exist (verification line 10), keyed on digestion end-product identity (Q23, ans D) and phosphate-charge retention (Q24, ans A) — glycolysis's interior (enzymes, regulation, energetics, PPP, fermentation mechanism) was deliberately left untouched.
- **Recommendation:** OWN IT — the metabolism-lite label plus the two entry-only keys constitute the grant: Ch9 owns everything from the first glycolytic enzyme inward.

### Phosphorylation traps glucose in the cell (negative charge / not a transporter substrate)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch4_carbohydrates_batch2.sql`
- **Evidence:** Keyed THREE times: Ch4 batch2 Esterification Q (line ~355, ans A: 'phosphate group carries a net negative charge, and the transporter cannot move a molecule that is no longer neutral'); Ch4 batch3 Q24 (ans A, same charge/transporter key for muscle glycogen G1P); Ch12 (line ~858, ans C: muscle lacks glucose-6-phosphatase so G6P 'stays charged and trapped'). Ch9 deck card at position 12 carries the identical claim ('glucose-6-phosphate's {{c1::negative charge}} prevents it from crossing').
- **Recommendation:** AVOID IT as a key — three doors closed. APPROACH the hexokinase node FROM A DIFFERENT ANGLE: hexokinase vs glucokinase kinetics (low vs high Km, G6P product inhibition vs none, insulin induction of glucokinase transcription) — all ABSENT as question keys and covered by deck cards 13-17.

### GLUT1 facilitated diffusion is passive/gradient-driven; carrier saturation kinetics

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch8_membranes_questions_batch2.sql`
- **Evidence:** Ch8 batch2 Q3 (ans A) keys GLUT1 continuing at normal rate after total ATP blockade because the gradient, not metabolic energy, drives transport; Ch8 batch2 Q2 (ans D) keys carrier-saturation rate plateau. Ch8 chapter verification records these as outbound claims.
- **Recommendation:** AVOID keying passivity or saturation-plateau logic. APPROACH GLUTs FROM A DIFFERENT ANGLE: GLUT2 as the high-Km glucose SENSOR whose uptake rate scales with blood glucose across the physiological range (liver/beta-cell) — GLUT2 kinetics appear only in Ch12 DISTRACTOR rationales, never as a key; aligns with deck cards 1-2.

### GLUT4 insulin-dependent recruitment; GLUT1/GLUT3 insulin-independent brain/RBC uptake

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 keys this repeatedly: line ~546 (ans C, insulin recruits GLUT4 to muscle/adipose while brain uses insulin-independent GLUT1/GLUT3), line ~731 (ans B, GLUT4 in the fed-state tissue table), line ~1119 (ans B, beta-cell sensing then GLUT4 uptake loop), line ~1438 (ans C, fasting neurons vs resting muscle). Ch9 deck cards 3-6 carry the same facts.
- **Recommendation:** AVOID IT entirely in Ch9 questions — Ch12 owns the insulin/GLUT4 lane four ways; the deck cards cover the recall need.

### RBCs lack mitochondria, so they run anaerobic glycolysis to lactate in every state

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 (line ~831, ans B) keys exactly this: 'red blood cells, lacking mitochondria, metabolize it anaerobically to lactate in every metabolic state.' Ch9 deck card 27 carries the same claim. ERRATUM NOTE for the plan: the source summary's anaerobic bullet is glare-truncated ('red blood cells, skeletal muscle during short intense bursts, and any cell [cut off]'); the missing clause is almost certainly 'any cell lacking mitochondria' (Kaplan also lists cornea/lens) — writers must source the complete list from LibreTexts/OpenStax, not the summary.
- **Recommendation:** AVOID the RBC-no-mitochondria crux. APPROACH fermentation FROM A DIFFERENT ANGLE: key WHY lactate must form — LDH regenerates NAD+ for the GAPDH step, and identify GAPDH as the specific step that stalls without NAD+; that mechanism-level crux is keyed nowhere (it appears only as rationale scenery in Ch10's thiamine item and Ch12's Cori item).

### Cori cycle energetics (lactate to liver, 6 ATP vs 2 ATP, net ATP-consuming)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 (line ~783, ans D) keys the full Cori logic including the liver paying the 6-vs-2 ATP bill; Ch12 line ~808 (ans A) keys the alanine cycle counterpart.
- **Recommendation:** AVOID IT — both shuttle cycles are owned by Ch12.

### PFK-1/FBPase-1 futile cycle and insulin-glucagon reciprocal control

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 (line ~1194, ans A) keys the exact PFK-1/FBPase-1 substrate cycle: no net product, one ATP burned per turn, reciprocal hormonal control prevents it. Ch11 (line ~800, ans B) keys the same futile-cycle logic for FA synthesis/oxidation. Ch9 deck card 57 states the futile-cycle concept.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — key the fructose-2,6-bisphosphate/PFK-2 mechanism (bifunctional kinase/phosphatase, F2,6-BP as the most potent PFK-1 activator and FBPase-1 inhibitor, insulin/glucagon acting on PFK-2): ABSENT bank-wide as a key and matches deck cards 18-22. Never re-key the futile-cycle-waste conclusion or bare hormone reciprocity.

### Hormonal control of glycogen metabolism (insulin's four-enzyme fed-liver program; glucagon/epinephrine glycogenolysis)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch12_bioenergetics_regulation_metabolism_questions.sql`
- **Evidence:** Ch12 (line ~1069, ans D) keys the coordinated program: glucokinase + glycogen synthase activated, glycogen phosphorylase + G6Pase inhibited → net storage. Ch12 line ~573 keys glucagon-activates-phosphorylase (glycogenolysis first, gluconeogenesis later) and line ~600 keys the depletion handoff. Bio Ch5 Endocrine (batch3 line ~320, ans D) keys epinephrine-driven glycogenolysis. Ch9 deck cards 42, 45 mirror these hormone facts.
- **Recommendation:** AVOID hormonal-regulation keys for glycogen. OWN the pure enzymology instead: glycogenin self-priming, branching enzyme (alpha-1,6), debranching enzyme, UDP-glucose as activated donor — all ABSENT as question keys (deck cards 40-48 aligned).

### Glycogen phosphorylase releases glucose-1-phosphate (phosphorolysis product identity)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch4_carbohydrates_batch3.sql`
- **Evidence:** Ch4 batch3 (line ~513, ans B) keys the direct product question verbatim: Pi attack → glucose-1-phosphate, with G6P as the 'downstream product' distractor. Ch4 flashcard deck card 61 and Ch9 deck card 44 both state it.
- **Recommendation:** AVOID re-keying the G1P product identity. APPROACH glycogenolysis FROM A DIFFERENT ANGLE: key the debranching enzyme's necessity (phosphorylase stalls near alpha-1,6 branch points; debrancher's transferase + glucosidase yields one free glucose per branch) — ABSENT.

### Glycogen branching → many nonreducing ends → rapid glucose mobilization

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch4_carbohydrates_batch3.sql`
- **Evidence:** Ch4 batch3 Q7 and Q8 (figure-driven polysaccharide items) key branch topology → more simultaneous enzymatic attack sites → faster mobilization.
- **Recommendation:** AVOID IT — Ch4 owns the topology-speed argument twice, with figures.

### Gluconeogenesis substrate eligibility (acetyl-CoA no net glucose; glycerol→DHAP; odd-chain propionyl route)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch10_carbohydrate_metabolism_2_questions.sql`
- **Evidence:** Ch10 keys it at least four ways: leucine/ketogenic (line ~292, ans A), even-chain carbon bookkeeping (lines ~314 ans B and ~336 ans C), TAG glycerol-vs-fatty-acid tracer (line ~149, ans C). Ch11 keys the odd-chain/B12 glucogenic loss (line ~1300, ans D). Ch9 deck cards 35, 50 state the same claims.
- **Recommendation:** AVOID substrate-eligibility keys. OWN the bypass-enzyme machinery, which is ABSENT as keys: pyruvate carboxylase (biotin, mitochondrial, acetyl-CoA allosteric activation framed as the pyruvate-fate switch — NOT as OAA-pool anaplerosis, which Ch10 keys at line ~762), PEPCK and the OAA detour around irreversible pyruvate kinase, FBPase-1 as the rate-limiting step, and G6Pase's ER location.

### Pyruvate dehydrogenase complex (location, products, regulation, thiamine)

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch10_carbohydrate_metabolism_2_questions.sql`
- **Evidence:** Ch10 owns the whole PDH lane: matrix location/bridge (line ~39, ans B), one CO2 + NADH per pyruvate with C1 label (line ~17, ans A), PDH kinase/phosphatase covalent control by ATP (line ~83, ans D), allosteric/product flux logic (line ~105, ans A), thiamine deficiency at E1 (line ~127, ans B). Ch9 deck cards 33-38 overlap all of these.
- **Recommendation:** AVOID IT in Ch9 questions entirely — the deck's bridge cards are the right vehicle; every PDH question key belongs to Ch10's live bank.

### Pentose phosphate pathway / NADPH

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochem_ch11_lipid_amino_acid_metabolism_questions.sql`
- **Evidence:** SPLIT LANE. Closed: Ch11 Q38 (ans B) keys PPP as the NADPH source for cholesterol/fatty-acid synthesis; Ch12 (line ~523, ans B) keys the NAD+-catabolic vs NADPH-anabolic pool split. Open: Ch12's header (line 8) explicitly records glutathione as a TRIMMED item; zero question keys exist for G6PD, glutathione/ROS defense, respiratory burst, or ribose-5-phosphate (grep-verified). Ch9 deck cards 59-65 cover the full PPP lane including G6PD rate-limiting step, NADP+/insulin activation, respiratory burst, and glutathione.
- **Recommendation:** OWN IT via the open half: G6PD as committed/rate-limiting step, NADPH→glutathione→ROS protection (G6PD-deficiency oxidative-hemolysis vignette), ribose-5-phosphate for nucleotides, no-ATP-in-or-out. AVOID keying 'NADPH powers reductive biosynthesis' — Ch11/Ch12 own that framing.

### Galactose and fructose feeder pathways (galactokinase, GALT/epimerase, fructokinase, aldolase B, PFK-1 bypass)

- **Status:** ABSENT
- **Owner:** `biochemistry_ch9_carbohydrate_metabolism_i_flashcards.sql`
- **Evidence:** Zero question hits bank-wide for galactokinase, aldolase B, fructokinase, uridyltransferase, galactosemia, or hereditary fructose intolerance (grep-verified across scripts and seeds). Only the Ch9 deck covers it (cards 29-32), including 'fructose bypasses PFK-1'.
- **Recommendation:** OWN IT — wide open; include the regulatory consequence of fructose entering below PFK-1, and the galactosemia/HFI clinical vignettes.

### Glycolysis core enzymology and energetics (PFK-1 rate-limiting step, pyruvate kinase feed-forward, GAPDH/NADH step, 2-in/4-out ATP, substrate-level phosphorylation, three irreversible steps)

- **Status:** ABSENT
- **Owner:** `biochemistry_ch9_carbohydrate_metabolism_i_flashcards.sql`
- **Evidence:** No existing question KEY turns on any interior glycolytic step; glycolysis numbers appear only as rationale scenery in Ch10/Ch12. The only substrate-level-phosphorylation keys are Ch10's TCA items (succinyl-CoA→GTP, lines ~676/786) — a different pathway. Ch9 deck cards 6-24 cover this lane densely (irreversible-triad card, PFK-1 rate-limiting + F1,6-BP, AMP/F2,6-BP activation, ATP/citrate inhibition, GAPDH sole NADH step, PEP→pyruvate, F1,6-BP feed-forward on pyruvate kinase).
- **Recommendation:** OWN IT — this is the granted heart of the chapter. Key substrate-level phosphorylation at the glycolytic steps (PGK and pyruvate kinase), which stays distinct from Ch10's succinyl-CoA→GTP key.

### Generic rate-limiting-step logic (block the slow step → pathway flux drops)

- **Status:** FLASHCARD_ONLY
- **Owner:** `general_chemistry_ch5_chemical_kinetics_flashcards.sql`
- **Evidence:** Generic form exists only as a GenChem Ch5 Kinetics deck card (line 151: 'A multistep reaction can never run faster than its {{c1::slowest}} elementary step... {{c2::rate-determining (rate-limiting)}} step'); no Scientific Reasoning deck claims it. BUT the applied template is already question-keyed three times in metabolism: Ch11 statin item (line ~874, ans A: block rate-limiting enzyme → flux drops → uptake upregulates), Ch11 ACC committed-step item (line ~646, ans D), Ch10 CPT-I item (line ~248, ans C).
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE — freely NAME PFK-1/FBPase-1/G6PD as rate-limiting (aligns with deck cards 17, 54, 61), but anchor every key on pathway-specific effectors or consequences (F2,6-BP potency, citrate crosstalk, NADPH feedback); never make the crux the bare block-the-slowest-step flux template Ch11 already keys.

### 2,3-BPG (RBC side pathway) and hemoglobin affinity

- **Status:** TESTED_ELSEWHERE
- **Owner:** `biochemistry_ch3_depth_batch3.sql`
- **Evidence:** Biochem Ch3 depth batch3 (line ~102, ans A) keys 2,3-BPG right-shift/T-state stabilization from altitude data; Bio Ch3 embryo batch4 (ans A) keys HbF affinity with BPG as distractor D. Ch9 deck has NO 2,3-BPG card.
- **Recommendation:** APPROACH FROM A DIFFERENT ANGLE if covered at all — key only the glycolytic bookkeeping of the shunt (bisphosphoglycerate mutase diverts 1,3-BPG around the PGK step, sacrificing one ATP); never the curve-shift physiology.

### Erratum: live flashcard claims glucokinase is in muscle

- **Status:** FLASHCARD_ONLY
- **Owner:** `flashcard_cloze_quality_fixes_20260715.sql`
- **Evidence:** flashcard_cloze_quality_fixes_20260715.sql line 67 updates a live card to read 'In the liver and muscle, insulin activates {{c1::glucokinase}} and {{c2::glycogen synthase}}...' — glucokinase is a liver/pancreatic-beta-cell isoform, not muscle (muscle uses hexokinase). This directly contradicts Ch9 deck cards 13-15 and Ch12's own question rationale (line ~554: glucokinase absent from brain; GLUT/kinase tissue logic).
- **Recommendation:** OWN IT in questions with the correct tissue distribution (liver + beta-cells only), and flag the stale card for a one-line fix ('liver' or 'liver and muscle→hexokinase family' rewording) so cards and questions align.

### Von Gierke disease / glucose-6-phosphatase deficiency

- **Status:** FLASHCARD_ONLY
- **Owner:** `biochemistry_ch9_carbohydrate_metabolism_i_flashcards.sql`
- **Evidence:** No question anywhere keys a glycogen storage disease (grep-verified); only Ch9 deck cards 55-56 cover G6Pase's ER location and Von Gierke fasting hypoglycemia. Adjacent-but-distinct keys exist: Ch12 keys muscle LACKING G6Pase (line ~858) and insulin INHIBITING liver G6Pase (line ~1069).
- **Recommendation:** OWN IT — a Von Gierke vignette (deficient G6Pase → severe fasting hypoglycemia despite intact glycogenolysis AND gluconeogenesis converging on trapped G6P) is open, provided the crux is the shared final step, not the muscle-lacks-it fact Ch12 keys.

