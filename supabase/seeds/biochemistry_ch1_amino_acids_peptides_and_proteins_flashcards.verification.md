# Verification Report — Biochemistry Ch 1: Amino Acids, Peptides, and Proteins

**Deck:** Amino Acids, Peptides, and Proteins
**Source SQL:** supabase/seeds/biochemistry_ch1_amino_acids_peptides_and_proteins_flashcards.sql
**Verified:** 2026-06-02

## Summary

- Total cards: 63
- Confidence 5: 60
- Confidence 4: 3
- Confidence 3: 0
- Confidence 2: 0
- Confidence 1: 0
- `needs_sme_review`: 0
- Dropped during editorial pass: 1 (.apkg note 56 on autophagy — out of scope for this chapter; belongs in a later metabolism chapter)
- Split for length compliance: 1 (.apkg note 23 had 9 cloze groups — split into the nonpolar overview card and absorbed into the hydrophobic-identity card)

**Length-compliance check (per v6 CARD LENGTH & FOCUS rule):**
- All 63 cards confirmed ≤ 40 words of answer prose
- All 63 cards confirmed ≤ 4 cloze blanks
- One discrete concept per card — no over-budget exceptions used

**Scope note:** This deck focuses on the conceptual chapter content (acid-base chemistry, peptide bonds, protein structure levels, classification PRINCIPLES). Per-amino-acid structural memorization (the 20 individual structures) lives in the separate `amino_acids` deck and is not duplicated here. Specific amino acids appear in this deck only when they illustrate a chapter concept (glycine as achiral, methionine for sulfur, proline for cyclic structure, cysteine for disulfides, the aromatic trio for UV absorbance).

**Primary references:**
- LibreTexts Biochemistry (Amino Acid Structure, Acid-Base Properties, Peptide Bond, Protein Structure)
- LibreTexts Organic Chemistry (Stereochemistry — CIP and Fischer systems)
- AAMC Content Outline 2026, Foundation 1A Concept 1 (Amino acids and proteins) and Foundation 1B Concept 4 (Three-dimensional protein structure)

## Per-card verification

### Card 0 — Amino acid general structure
**Cloze claim:** Amino group, carboxyl group, hydrogen, R group, all on the α-carbon.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Amino Acid Structure).

### Card 1 — 20 proteinogenic amino acids
**Cloze claim:** Human proteins built from 20 α-amino acids encoded by the genetic code.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; AAMC Content Outline Foundation 1A Concept 1.

### Card 2 — α-carbon as chiral center
**Cloze claim:** α-carbon bonded to four distinct groups; chiral center.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry (Chirality); LibreTexts Biochemistry.

### Card 3 — Average residue weight ~110 Da
**Cloze claim:** Average amino acid residue weight in proteins is approximately 110 Da.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Protein Mass Estimation). Standard biochemistry rule of thumb.

### Card 4 — Glycine achiral
**Cloze claim:** Glycine R group is H; α-carbon does not have four distinct groups; not optically active.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; LibreTexts Organic Chemistry.

### Card 5 — L configuration (Fischer)
**Cloze claim:** All 20 proteinogenic amino acids are L under Fischer projection convention.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Stereochemistry of Amino Acids).

### Card 6 — CIP S vs R for cysteine (CORRECTED)
**Cloze claim:** Under CIP, all are S except cysteine (R), because the sulfur side chain outranks the carboxyl group.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry (Cahn-Ingold-Prelog Priority Rules); LibreTexts Biochemistry. **Correction:** the .docx confuses CIP (R/S) and Fischer (D/L) conventions by saying "Cysteine has R configuration while all others have L configuration." The corrected fact is: all 20 are L (Fischer); under CIP, all are S except cysteine which is R because S has higher atomic number than O.

### Card 7 — CIP system mechanics
**Cloze claim:** CIP ranks substituents by atomic number to assign R or S to each stereocenter.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 8 — Nonpolar amino acids list
**Cloze claim:** Ala, Val, Leu, Ile, Gly, Met, Pro carry hydrophobic R groups.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Amino Acid Classification).

### Card 9 — Methionine sulfur
**Cloze claim:** Methionine side chain contains sulfur; nonpolar; pairs with cysteine as the two sulfur-containing amino acids.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 10 — Proline cyclic structure
**Cloze claim:** Proline side chain bonds back to α-amino nitrogen, forming a 5-membered ring.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 11 — Aromatic amino acids identity + UV
**Cloze claim:** Trp, Phe, Tyr; conjugated rings absorb UV near 280 nm.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; consistent with Biochem Ch 3 deck card 63 on UV spectroscopy.

### Card 12 — Trp/Phe/Tyr structural relationships
**Cloze claim:** Trp has indole double-ring with N; Phe has benzyl ring; Tyr is Phe + OH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Aromatic Amino Acid Structures).

### Card 13 — Aromatic UV absorbance at 280 nm
**Cloze claim:** Trp and Tyr dominate UV absorbance near 280 nm; basis of UV protein quantification.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (UV Spectroscopy of Proteins).

### Card 14 — Polar uncharged amino acids
**Cloze claim:** Ser, Thr, Asn, Gln, Cys; H-bond capable; do not gain/lose protons under normal pH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Amino Acid Classification).

### Card 15 — Serine/threonine hydroxyl
**Cloze claim:** Ser and Thr both carry -OH side chain; strongly polar; H-bond donors and acceptors.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 16 — Asparagine/glutamine amide
**Cloze claim:** Asn and Gln carry amide side chain; amide nitrogen does not gain or lose protons with pH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 17 — Acidic amino acids
**Cloze claim:** Asp and Glu; carboxylate side chain; deprotonated at physiological pH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 18 — Basic amino acids
**Cloze claim:** Lys, Arg, His; nitrogen-containing side chains; protonated and positively charged at physiological pH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry. Note: histidine is partially protonated at pH 7.4 because its imidazole pKa (~6) is near physiological pH; the simplification "typically protonated and positively charged at physiological pH" is consistent with standard MCAT framing.

### Card 19 — Lys/Arg/His side chain specifics
**Cloze claim:** Lys = terminal primary amine; Arg = guanidinium with charge delocalized over 3 N; His = imidazole with 2 N.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Basic Amino Acid Side Chains).

### Card 20 — Hydrophobic location
**Cloze claim:** Hydrophobic side chains cluster in protein interior, away from water.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Protein Folding).

### Card 21 — Hydrophilic location
**Cloze claim:** Hydrophilic side chains (charged + most polar) face the surface, in contact with water.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 22 — Strongly hydrophobic identity
**Cloze claim:** Ala, Val, Leu, Ile, Phe — strongly hydrophobic.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Hydropathy).

### Card 23 — Amphoteric
**Cloze claim:** Amino acids can act as either acid or base because they carry both a carboxyl and amino group.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Acid-Base Properties of Amino Acids).

### Card 24 — pH vs pKa rule
**Cloze claim:** pH < pKa → mostly protonated; pH > pKa → mostly deprotonated.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; LibreTexts Organic Chemistry (Acid-Base Equilibria).

### Card 25 — pKa precise definition
**Cloze claim:** pKa = pH at which exactly half of the species is deprotonated.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 26 — Two pKa values
**Cloze claim:** Every amino acid has at least two pKa values; α-COOH ~2; α-NH3+ ~9-10.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Amino Acid Titration Curves).

### Card 27 — Zwitterion definition
**Cloze claim:** Dipolar form with both positive and negative charge; net electrically neutral.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 28 — Form at low pH
**Cloze claim:** At pH ~1, amino group protonated (-NH3+) and carboxyl group protonated (-COOH); net positive.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Amino Acid Titration).

### Card 29 — Form at physiological pH (zwitterion)
**Cloze claim:** At pH ~7.4, α-amino protonated and α-carboxyl deprotonated; zwitterion.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 30 — Form at high pH
**Cloze claim:** At pH ~11, both groups deprotonated; net negative charge.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 31 — Titration buffering near pKa
**Cloze claim:** Near pKa, amino acid acts as buffer; adding base produces small pH change.
**Confidence:** 4
**Source:** LibreTexts Biochemistry (Titration Curve Buffer Regions); standard acid-base chemistry concept.

### Card 32 — pI definition
**Cloze claim:** pI = pH at which amino acid has no net charge.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 33 — pI formula for neutral amino acid
**Cloze claim:** pI = (pKa,COOH + pKa,NH3+)/2 for non-ionizable-side-chain amino acids.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 34 — pI formula for acidic amino acid
**Cloze claim:** Acidic amino acids: pI = average of the two lowest pKa values; low pI.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Isoelectric Point Calculations).

### Card 35 — pI formula for basic amino acid
**Cloze claim:** Basic amino acids: pI = average of the two highest pKa values; high pI.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 36 — Peptide nomenclature
**Cloze claim:** Di-, tri-, oligo- (up to ~20), poly- (>20) peptides.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Peptide Nomenclature). The 20-residue cutoff is standard MCAT framing.

### Card 37 — Peptide bond formation (condensation)
**Cloze claim:** Condensation (dehydration) between carboxyl of one and amino of another; releases water.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Peptide Bond Formation).

### Card 38 — Peptide bond mechanism
**Cloze claim:** Electrophilic carbonyl C attacked by nucleophilic amino N; hydroxyl lost as water.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; LibreTexts Organic Chemistry (Amide Formation).

### Card 39 — N-to-C reading convention
**Cloze claim:** Peptides written and read N-terminus (left) to C-terminus (right).
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 40 — Hydrolysis mechanism
**Cloze claim:** Hydrolysis adds H to N and OH to carbonyl C; catalyzed in vivo by hydrolytic enzymes.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 41 — Trypsin specificity (K, R)
**Cloze claim:** Trypsin cleaves after lysine and arginine (positively charged basic residues).
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Protein Sequencing — Enzymatic Cleavage); cross-referenced with Biochem Ch 3 deck card 60.

### Card 42 — Chymotrypsin specificity (F, W, Y) — CORRECTED
**Cloze claim:** Chymotrypsin cleaves after phenylalanine, tryptophan, tyrosine (aromatic residues).
**Confidence:** 5
**Source:** LibreTexts Biochemistry. **Correction:** the .docx para 118 attributes this specificity to "trypsin," which is wrong. The correct enzyme is chymotrypsin. Trypsin and chymotrypsin specificities are preserved as separate cards (41 + 42).

### Card 43 — Primary structure definition
**Cloze claim:** Linear amino acid sequence; encoded in DNA; read N-to-C.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Primary Structure).

### Card 44 — Primary structure stabilization
**Cloze claim:** Held together by covalent peptide bonds; strongest interactions in protein structure.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 45 — Sequence encodes higher folding
**Cloze claim:** Primary structure encodes all higher-level folding (secondary, tertiary, quaternary).
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Anfinsen's principle).

### Card 46 — Secondary structure overview
**Cloze claim:** Local backbone folding; stabilized primarily by hydrogen bonds between backbone carbonyl O and amide H.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Secondary Structure).

### Card 47 — α-helix structure
**Cloze claim:** Rod-shaped coil; H-bonds between carbonyl O and amide H 4 residues farther along.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (α-Helix Geometry).

### Card 48 — α-helix side chains + keratin
**Cloze claim:** Side chains project outward; α-helix is the dominant secondary structure of keratin.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; OpenStax A&P 2e §5.1.

### Card 49 — β-pleated sheet + parallel/antiparallel
**Cloze claim:** Strands lie side by side with H-bonds; parallel (same direction) or antiparallel (opposite).
**Confidence:** 5
**Source:** LibreTexts Biochemistry (β-Sheet Topology).

### Card 50 — Proline kink in α-helix
**Cloze claim:** Proline's cyclic structure kinks the backbone; rarely in middle of α-helix (except transmembrane).
**Confidence:** 5
**Source:** LibreTexts Biochemistry; standard structural biology.

### Card 51 — Proline at turns and helix starts
**Cloze claim:** Proline rare in β-sheet middles; common at β-turn positions and helix start.
**Confidence:** 4
**Source:** LibreTexts Biochemistry. Proline's positional preferences are well established in structural biology but lightly framed in introductory texts.

### Card 52 — Tertiary structure definition
**Cloze claim:** 3D fold of one polypeptide chain; determined by side-chain interactions.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Tertiary Structure).

### Card 53 — Hydrophobic effect drives folding
**Cloze claim:** Hydrophobic effect is the dominant driver; nonpolar interior, polar/charged surface.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Protein Folding Thermodynamics).

### Card 54 — Disulfide bonds
**Cloze claim:** Covalent S-S between two cysteines; requires oxidation (lose 2 H, 2 e−); creates loops.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Disulfide Bond Chemistry).

### Card 55 — Solvation layer + entropy
**Cloze claim:** Burying hydrophobic side chains frees water from rigid solvation shells; raises entropy and drives folding.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Hydrophobic Effect Thermodynamics).

### Card 56 — Fibrous vs globular
**Cloze claim:** Fibrous (e.g., collagen, keratin) = sheets/strands, structural; globular (e.g., myoglobin, hemoglobin) = spherical, functional/transport.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Protein Classification).

### Card 57 — Quaternary structure definition
**Cloze claim:** Spatial arrangement of multiple polypeptide subunits into a functional complex; not all proteins have it.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Quaternary Structure).

### Card 58 — Quaternary roles
**Cloze claim:** Increase stability, save DNA, channel intermediates between catalytic sites, enable cooperativity/allosteric regulation.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Card 59 — Conjugated proteins
**Cloze claim:** Carry covalently attached non-amino-acid prosthetic group essential to function.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Conjugated Proteins).

### Card 60 — Prosthetic group naming + heme
**Cloze claim:** Lipoproteins, glycoproteins, nucleoproteins; hemoglobin's heme (with iron) binds oxygen.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; OpenStax A&P 2e §18.2 (hemoglobin structure).

### Card 61 — Denaturation
**Cloze claim:** Loss of tertiary/quaternary structure; loss of function; often irreversible.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (Protein Denaturation).

### Card 62 — Two causes of denaturation
**Cloze claim:** Heat (breaks hydrophobic and noncovalent interactions); solutes (break disulfide bridges, disrupt other forces).
**Confidence:** 4
**Source:** LibreTexts Biochemistry. The two-causes framing is standard MCAT prep; in reality pH changes and pressure also denature proteins, but heat and solutes are the canonical examples.

## needs_sme_review

None. All 63 cards rated confidence 4 or 5.

## Disagreements with corpus

**One material disagreement and one terminology error in the source materials.**

1. **.docx para 118 — factual error.** The chapter outline attributes the cleavage specificity for phenylalanine, tryptophan, and tyrosine to **trypsin**. This specificity actually belongs to **chymotrypsin**, per LibreTexts Biochemistry and standard biochemistry. The deck dedicates separate cards to trypsin (cleaves after K/R, card 41) and chymotrypsin (cleaves after F/W/Y, card 42), each with its correct specificity.

2. **.docx para 11 — terminology error.** The chapter outline states "Cysteine has an R absolute configuration, while all other amino acids have the L absolute configuration." This conflates two distinct stereochemistry conventions: Cahn-Ingold-Prelog (R/S) and Fischer (D/L). The corrected facts per LibreTexts: all 20 proteinogenic amino acids are **L** in the Fischer convention; under **CIP** rules, cysteine is **R** while all others are **S** (the difference arises because the sulfur side chain of cysteine outranks the carboxyl group by atomic number, swapping the priority order). The deck separates these into two cards (5 + 6).

The three confidence-4 cards (31, 51, 62) use standard biochemistry framings that are firmly established but lightly covered in introductory texts (titration buffering near pKa; proline positional preferences at turns and helix starts; the two canonical denaturation causes).

## Discrepancies between primary and secondary sources

None encountered. LibreTexts Biochemistry and LibreTexts Organic Chemistry treat these topics consistently with each other.

## Source-material discrepancies corrected during editorial pass

The chapter outline document contained multiple autocorrect-introduced typos, one terminology error (R/S vs L/D), and one factual error (enzyme specificity). All were corrected against the reference textbooks before any card was written:

1. **Factual error (substantive):** .docx attributes F/W/Y cleavage to trypsin; corrected to **chymotrypsin** per LibreTexts.
2. **Terminology error:** .docx confuses CIP (R/S) and Fischer (D/L) conventions for cysteine vs other amino acids; corrected per LibreTexts.
3. .docx "Cahn-InGold-prelog" → Cahn-Ingold-Prelog (capitalization)
4. .docx "thoronine" → threonine (autocorrect)
5. .docx "have a mind side, James" → have an amide side chain (autocorrect garble)
6. .docx "Importing in Keratin" → important in keratin (autocorrect)
7. .docx "Prolimar zoos" → prolines (autocorrect garble)
8. .docx "disolified" / "disorified" → disulfide (autocorrect)
9. .docx "salivation layer" / "salvation" → solvation (autocorrect)
10. .docx "isoelectro point" → isoelectric point (autocorrect)
11. .docx "Courtney structure" → quaternary structure (autocorrect)
12. .docx "leg up to thousands" → long up to thousands (autocorrect)
13. .apkg note 7 "postive" → positive (autocorrect)
14. .apkg note 56 (autophagy) — out-of-scope for amino acid/peptide/protein chemistry, dropped
15. .apkg note 23 (nonpolar list, 9 cloze groups) — split for length-rule compliance
16. **15 .apkg notes with back-field image references** (amino acid structures, α-helix/β-sheet diagrams, proline kink, quaternary structure illustrations) — stripped per established text-only deck policy. The conceptual content is preserved in card prose.

---

## Post-verification SME decisions

*(Empty section reserved for future SME or content owner to log overrides, retentions, or revisions made after the report was generated.)*
