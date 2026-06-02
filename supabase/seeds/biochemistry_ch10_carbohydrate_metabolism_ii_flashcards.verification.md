# Verification Report — Biochemistry Ch 10: Carbohydrate Metabolism II

**Deck:** Carbohydrate Metabolism II
**Source SQL:** supabase/seeds/biochemistry_ch10_carbohydrate_metabolism_ii_flashcards.sql
**Verified:** 2026-06-02

## Summary

- Total cards: 58
- Confidence 5: 55
- Confidence 4: 3
- Confidence 3: 0
- Confidence 2: 0
- Confidence 1: 0
- `needs_sme_review`: 0
- Dropped during editorial pass: 0
- Split for length compliance: 2 (.apkg note 49 8-blank ATP card → 4 focused cards; note 8 5-blank citrate synthase card → consolidated to 4 blanks)

**Length-compliance check (per v6 CARD LENGTH & FOCUS rule):**
- All 58 cards confirmed ≤ 40 words of answer prose
- All 58 cards confirmed ≤ 4 cloze blanks
- One discrete concept per card — no over-budget exceptions used
- **Parallel-concept clozing rule applied throughout**: acetyl-CoA sources list, PDH kinase/phosphatase pair, NADH/FADH₂ ATP yields, Fe²⁺/Fe³⁺ cytochrome cycle, F₀/F₁ ATP synthase pair, chemiosmotic/conformational coupling pair — all parallel members of comparison cards are clozed together.

**Primary references:**
- LibreTexts Biochemistry (Pyruvate Dehydrogenase Complex; Citric Acid Cycle; Electron Transport Chain; Oxidative Phosphorylation)
- OpenStax Biology 2e (Ch 7 Cellular Respiration — cross-reference for overview-level facts)
- AAMC Content Outline 2026, Foundation 1D Concept 3 (Metabolism of carbohydrates)

## Per-card verification

### Card 0 — Acetyl-CoA central role
**Cloze claim:** Central two-carbon TCA entry; from carbs, FAs, ketogenic AAs, ketone bodies, ethanol.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Acetyl-CoA Overview).

### Card 1 — Thioester bond
**Cloze claim:** High-energy thioester between acetyl group and CoA -SH; hydrolysis drives reactions.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Coenzyme A and Thioesters).

### Card 2 — Carbohydrate route to acetyl-CoA
**Cloze claim:** Pyruvate decarboxylated by PDH complex in mitochondrial matrix.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 3 — Acetyl-CoA sources list
**Cloze claim:** Pyruvate, FAs, ketogenic AAs, ketone bodies, ethanol.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 4 — PDH location and role (CORRECTED)
**Cloze claim:** PDH catalyzes the link reaction between glycolysis and TCA in the mitochondrial matrix.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (PDH Complex). **Correction:** .docx para 9 says PDH "catalyzes the reactions in glycolysis" — wrong. PDH catalyzes the link reaction *between* glycolysis (cytosol) and TCA cycle (matrix).

### Card 5 — PDH overall reaction
**Cloze claim:** Pyruvate + CoA-SH + NAD⁺ → acetyl-CoA + CO₂ + NADH; exergonic, irreversible.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 6 — PDH cofactors
**Cloze claim:** TPP, lipoamide, FAD, NAD⁺, CoA-SH; Mg²⁺.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (PDH Cofactors).

### Card 7 — Pyruvate dehydrogenase (E1)
**Cloze claim:** Oxidatively decarboxylates pyruvate, releases CO₂, transfers 2-carbon group to lipoamide.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 8 — Dihydrolipoyl transacetylase (E2)
**Cloze claim:** Transfers acetyl group from lipoamide to CoA → acetyl-CoA.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 9 — Dihydrolipoyl dehydrogenase (E3)
**Cloze claim:** Reoxidizes lipoamide; transfers electrons to FAD; reduces NAD⁺ to NADH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 10 — PDH product inhibition
**Cloze claim:** Allosterically inhibited by acetyl-CoA and NADH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (PDH Regulation).

### Card 11 — PDH kinase
**Cloze claim:** Phosphorylates and inactivates PDH when ATP/NADH high.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 12 — PDH phosphatase
**Cloze claim:** Dephosphorylates and reactivates PDH when ADP rises.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 13 — β-oxidation location
**Cloze claim:** Mitochondrial matrix; removes 2-carbon units from carboxyl end.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Fatty Acid Oxidation).

### Card 14 — Carnitine shuttle
**Cloze claim:** Long-chain fatty acyl-CoA cannot cross IMM directly; carnitine transports across; handed back to mitochondrial CoA-SH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Carnitine Shuttle).

### Card 15 — β-oxidation yields
**Cloze claim:** Each round: 1 acetyl-CoA + 1 NADH + 1 FADH₂.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 16 — Purely ketogenic amino acids
**Cloze claim:** Ketogenic AAs cannot contribute to glucose synthesis; only Leu and Lys are purely ketogenic.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Amino Acid Catabolism).

### Card 17 — Mixed ketogenic/glucogenic
**Cloze claim:** Ile, Phe, Tyr, Trp, Thr.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 18 — Ethanol metabolism
**Cloze claim:** Alcohol dehydrogenase + acetaldehyde dehydrogenase; each step generates NADH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Alcohol Metabolism).

### Card 19 — Pentose phosphate pathway
**Cloze claim:** Cytosolic alternative G6P fate; produces NADPH + ribose-5-phosphate.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Pentose Phosphate Pathway).

### Card 20 — NADPH role
**Cloze claim:** Reductive biosynthesis (fatty acids, cholesterol); glutathione regeneration for antioxidant defense.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 21 — TCA purpose and location
**Cloze claim:** Mitochondrial matrix; oxidizes acetyl-CoA to CO₂; generates NADH, FADH₂, GTP.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Citric Acid Cycle Overview).

### Card 22 — TCA depends on O₂ indirectly
**Cloze claim:** Without O₂, ETC stalls, NADH/FADH₂ accumulate and inhibit TCA enzymes.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 23 — TCA yields per acetyl-CoA
**Cloze claim:** 3 NADH, 1 FADH₂, 1 GTP, 2 CO₂.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 24 — Step 1 citrate synthase
**Cloze claim:** Joins acetyl-CoA + oxaloacetate → citrate (6 carbons).
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 25 — Step 2 aconitase
**Cloze claim:** Isomerizes citrate to isocitrate via water removal/re-addition.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 26 — Step 3 isocitrate dehydrogenase (CORRECTED simplification)
**Cloze claim:** Rate-limiting; isocitrate → α-KG + first CO₂ + first NADH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry. **Note:** .docx paras 73-74 say isocitrate is oxidized to "oxaloacetate" — wrong (the intermediate is oxalosuccinate). Card uses the standard simplified net reaction.

### Card 27 — Step 4 α-KG dehydrogenase
**Cloze claim:** α-KG → succinyl-CoA + second CO₂ + NADH; analogous to PDH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 28 — Step 5 succinyl-CoA synthetase
**Cloze claim:** Succinyl-CoA → succinate; substrate-level phosphorylation of GDP → GTP.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 29 — Step 6 succinate dehydrogenase
**Cloze claim:** Succinate → fumarate using FAD; only TCA enzyme in inner membrane; same as Complex II.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 30 — Step 7 fumarase
**Cloze claim:** Hydrates fumarate to L-malate.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 31 — Step 8 malate dehydrogenase
**Cloze claim:** Malate → oxaloacetate; third NADH; OAA ready for next cycle.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 32 — Citrate synthase regulation
**Cloze claim:** Allosterically inhibited by ATP, NADH, citrate, succinyl-CoA.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 33 — Isocitrate DH regulation
**Cloze claim:** Inhibited by ATP/NADH; activated by ADP/NAD⁺.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 34 — α-KG DH regulation
**Cloze claim:** Inhibited by succinyl-CoA, NADH, ATP; activated by ADP, Ca²⁺.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 35 — ETC overview
**Cloze claim:** Inner mitochondrial membrane; accepts e⁻ from NADH/FADH₂; final acceptor O₂ → H₂O.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Electron Transport Chain).

### Card 36 — Reduction potential drives flow
**Cloze claim:** Each successive complex has higher affinity for e⁻; releases energy.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 37 — Cristae
**Cloze claim:** IMM folds maximize surface area for ETC complexes and ATP synthase.
**Confidence:** 5
**Source:** OpenStax Biology 2e §7.4.

### Card 38 — Stepwise transfer
**Cloze claim:** Small steps capture energy efficiently; minimize heat loss vs direct NADH → O₂ jump.
**Confidence:** 4
**Source:** LibreTexts Biochemistry. Standard framing; the "minimize heat" interpretation is widely used in MCAT prep though formally the framing is about useful work captured per step.

### Card 39 — Complex I (CORRECTED)
**Cloze claim:** NADH → FMN → Fe-S → CoQ; pumps 4 protons.
**Confidence:** 5
**Source:** LibreTexts Biochemistry. **Correction:** .docx para 148 says Complex I transfers electrons "from FADH2" — wrong. Complex I uses FMN (flavin mononucleotide), not FAD. FAD belongs to Complex II.

### Card 40 — Complex II
**Cloze claim:** = TCA step 6 succinate DH; FADH₂ → CoQ; does NOT pump protons.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 41 — Why FADH₂ yields less ATP
**Cloze claim:** FADH₂ skips Complex I; fewer protons pumped; ~1.5 ATP vs ~2.5 ATP per NADH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 42 — Complex III
**Cloze claim:** CoQH₂ → cytochrome c via Q cycle; pumps 4 protons.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Q Cycle).

### Card 43 — Cytochromes Fe²⁺/Fe³⁺
**Cloze claim:** Heme proteins; iron cycles between Fe³⁺ (oxidized) and Fe²⁺ (reduced); one electron at a time.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 44 — Complex IV
**Cloze claim:** Cytochrome c → O₂ → H₂O; pumps 2 protons.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 45 — Why shuttles are needed
**Cloze claim:** Cytosolic NADH cannot cross IMM; shuttles transfer electrons.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (NADH Shuttles).

### Card 46 — Glycerol-3-phosphate shuttle (CORRECTED)
**Cloze claim:** Cytosolic NADH → mitochondrial FADH₂ (Complex II); ~1.5 ATP per cytosolic NADH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry. **Correction:** .docx para 179 says "1.58 ATP" — garbled. The standard value is 1.5 ATP per cytosolic NADH via this shuttle.

### Card 47 — Malate-aspartate shuttle
**Cloze claim:** Cardiac muscle preference; cytosolic NADH → mitochondrial NADH (Complex I); full ~2.5 ATP.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 48 — Proton motive force
**Cloze claim:** Electrochemical gradient across IMM: pH (chemical) + charge (electrical); built by ETC.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Proton Motive Force).

### Card 49 — F₀ vs F₁
**Cloze claim:** F₀ = ion channel (protons flow back); F₁ = phosphorylates ADP → ATP.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (ATP Synthase Structure).

### Card 50 — Chemiosmotic coupling (Mitchell)
**Cloze claim:** Direct link: proton gradient chemical energy drives ATP synthesis.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Mitchell's Chemiosmotic Hypothesis).

### Card 51 — Conformational coupling (Boyer)
**Cloze claim:** Rotary mechanism; proton flow rotates F₁; conformational changes catalyze and release ATP.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Boyer's Rotary Mechanism).

### Card 52 — ATP yields per NADH/FADH₂
**Cloze claim:** NADH ~2.5 ATP; FADH₂ ~1.5 ATP.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 53 — Glycolysis ATP
**Cloze claim:** 2 ATP direct + 2 NADH → ~7 ATP via shuttles.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 54 — PDH ATP
**Cloze claim:** 2 turns/glucose × NADH → ~5 ATP.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 55 — TCA ATP
**Cloze claim:** 2 turns × (3 NADH + 1 FADH₂ + 1 GTP) → ~20 ATP.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 56 — Grand total
**Cloze claim:** 30-32 ATP per glucose; depends on NADH shuttle.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 57 — Respiratory control (CORRECTED)
**Cloze claim:** Without O₂, ETC stalls and TCA stops; ADP + NAD⁺ (not NADH) promote TCA.
**Confidence:** 4
**Source:** LibreTexts Biochemistry. **Correction:** .docx para 130 says "ADP and NADH promote the citric acid cycle" — wrong. NADH is an inhibitor; NAD⁺ is the activator (it's the substrate of the dehydrogenase reactions). The 4 rating reflects the slightly compound framing (respiratory control + corrected regulator pair in one card).

## needs_sme_review

None. All 58 cards rated confidence 4 or 5.

## Disagreements with corpus

**Five material factual disagreements in the source materials**, all in the chapter outline (.docx):

1. **.docx para 9 — factual error.** Describes the PDH complex as catalyzing "the reactions in glycolysis." PDH catalyzes the link reaction *between* glycolysis (in cytosol) and the TCA cycle (in matrix), not glycolysis itself. Glycolysis is catalyzed by ten different cytosolic enzymes, none of which is PDH. Corrected per LibreTexts (Card 4).

2. **.docx paras 73-74 — factual error.** Describe isocitrate dehydrogenase as oxidizing isocitrate to **oxaloacetate**, which is then decarboxylated to α-ketoglutarate. The unstable intermediate is actually **oxalosuccinate** (a β-keto acid), not oxaloacetate; most MCAT-level treatments simplify by skipping the intermediate. Card 26 uses the standard simplified one-step net reaction.

3. **.docx para 130 — factual error.** "High levels of ADP and NADH promote the citric acid cycle" — NADH is a TCA inhibitor, not an activator. The activator is **NAD⁺** (the substrate form). Corrected per LibreTexts (Card 57).

4. **.docx para 148 — factual error.** Describes Complex I as transferring electrons "from FADH2" to coenzyme Q. Complex I actually uses **FMN/FMNH₂** (flavin mononucleotide). FAD belongs to Complex II. Corrected per LibreTexts (Card 39).

5. **.docx para 179 — typo/garble.** Cites "1.58 ATP for every molecule of succinate NADH" via the glycerol-3-phosphate shuttle. The standard value is **1.5 ATP per cytosolic NADH** through this shuttle (because electrons enter the ETC as FADH₂ via Complex II, skipping Complex I). Corrected per LibreTexts (Card 46).

The one confidence-4 card (38, stepwise transfer minimizes heat) uses the MCAT-prep framing that is widely accepted but covered with somewhat looser language in introductory texts.

## Discrepancies between primary and secondary sources

None encountered. LibreTexts Biochemistry and OpenStax Biology 2e treat PDH, TCA, ETC, and oxidative phosphorylation consistently across the relevant chapters.

## Source-material discrepancies corrected during editorial pass

The chapter outline document contained five substantive factual errors (above) plus numerous autocorrect typos. The Anki deck contained two over-budget cloze notes. All issues were corrected against the reference textbooks before any card was written:

1. **Factual errors:** PDH/glycolysis (para 9); isocitrate intermediate (paras 73-74); NADH/NAD⁺ TCA activation (para 130); FMN/FAD in Complex I (para 148); 1.58/1.5 ATP from glycerol-3-P shuttle (para 179) — all corrected per LibreTexts.
2. .docx para 4 — "Cetyl Coenzyme A" → Acetyl-CoA (autocorrect)
3. .docx paras 48-49 — "Phenonylene" → Phenylalanine; "Ty Racine" → Tyrosine (Card 17)
4. .docx para 66 — "Citrus synthase" → Citrate synthase (Card 24)
5. .docx para 101 — "oxyacetate" → oxaloacetate (Card 31)
6. .docx para 165 — "accumulating steps" → concluding steps (Card 44)
7. .docx para 181 — "systolic" → cytosolic (×3 occurrences in the malate-aspartate shuttle description)
8. .docx para 190 — "Confirmational coupling" → Conformational coupling (Card 51)
9. .docx para 195 — "free change of the reaction" → free energy change (kJ/mol)
10. .apkg note 49 — 8-blank ATP yield card split into 4 focused cards (Cards 53-56)
11. .apkg note 8 — 5-blank citrate synthase regulation card consolidated to 4 blanks (Card 32)

---

## Post-verification SME decisions

*(Empty section reserved for future SME or content owner to log overrides, retentions, or revisions made after the report was generated.)*
