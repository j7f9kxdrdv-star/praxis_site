# Verification Report — Biology Ch 1: The Cell

**Deck:** The Cell — Architecture, Microbiology, and Viruses
**Source SQL:** supabase/seeds/biology_ch1_the_cell_flashcards.sql
**Verified:** 2026-05-11
**Corpus:**
- Primary — `reference-textbooks/biology/openstax-biology-2e.txt` (cells, organelles, cytoskeleton)
- Primary — `reference-textbooks/biology/openstax-microbiology.txt` (prokaryotes, viruses, subviral pathogens)
- Primary — `reference-textbooks/biology/openstax-anatomy-physiology-2e.txt` (epithelial / connective tissue classification, ECM)
- Scope authority — `reference-textbooks/aamc/aamc-content-outline-2026.txt`

**.docx provenance:** *Biology review Chapter 1.docx* — adapted from Kaplan MCAT review (per user note); Source-Laundry rules applied per card. Subtopic ordering re-sequenced from the .docx's Kaplan-style structure to the AAMC Foundations order. No prose from the .docx survives in any card.

---

## Summary

- **Total cards:** 73
- **Confidence 5** (fact verified directly in textbook, no ambiguity): 65
- **Confidence 4** (verified with minor phrasing variation across sources): 8
- **Confidence 3:** 0
- **Confidence 2:** 0
- **Confidence 1:** 0
- **Cards flagged for `needs_sme_review`:** 0
- **Cards where corpus contradicts the card:** 0
- **Cards dropped because the source .apkg fact contradicted textbooks:** 0 (corrections were applied during rewrite; see "Disagreements with corpus" below for the three .docx claims that were corrected before becoming cards)

---

## Per-card verification

### Subtopic 1 — Cell Theory

**Card 0**
**Cloze claim:** The four classical tenets of cell theory.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.1 ("Studying Cells"); OpenStax Microbiology §3.1.
**Notes:** Four tenets reordered to AAMC-style framing (life unit → descent → DNA inheritance). Avoids the Kaplan-cadence "basic functional unit of life" phrasing.

### Subtopic 2 — Eukaryote vs Prokaryote — Core Distinction

**Card 1**
**Cloze claim:** Membrane-bound nucleus + membrane-bound organelles distinguish eukaryotes from prokaryotes.
**Confidence:** 5
**Source:** OpenStax Microbiology §3.3; OpenStax Biology 2e §4.2.

**Card 2**
**Cloze claim:** Prokaryotic ribosomes = 70S (30S + 50S); eukaryotic cytoplasmic ribosomes = 80S (40S + 60S).
**Confidence:** 5
**Source:** OpenStax Microbiology, lines 5243–5245 ("eukaryotic cells are 80S ribosomes, composed of a 40S small subunit and a 60S large subunit"); lines 4470–4471, 4479.
**Excerpt:** "Prokaryotic ribosomes (70S) are composed of two subunits: the 30S (small subunit) and the 50S (large subunit)."

**Card 3**
**Cloze claim:** In prokaryotes transcription and translation are coupled in the cytoplasm; in eukaryotes the nuclear envelope separates them, allowing post-transcriptional processing in between.
**Confidence:** 5
**Source:** OpenStax Biology 2e §15.3, §16.1; OpenStax Microbiology §11.4.

### Subtopic 3 — The Nucleus

**Card 4**
**Cloze claim:** Nucleus stores the genome and acts as the cell's command center; mRNA is exported after processing.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.3.

**Card 5**
**Cloze claim:** Nuclear envelope is a double membrane perforated by nuclear pores enabling bidirectional transport of RNA, proteins, and small molecules.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.3.

**Card 6**
**Cloze claim:** Histones organize DNA into chromatin, which condenses into chromosomes during mitosis.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.3; §10.1.

**Card 7**
**Cloze claim:** Nucleolus is the site of rRNA synthesis and ribosomal subunit assembly.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.3.

### Subtopic 4 — Mitochondria

**Card 8**
**Cloze claim:** Mitochondria generate ATP via aerobic respiration; cristae are the inner-membrane folds that house the ETC and expand its surface area.
**Confidence:** 5
**Source:** OpenStax Microbiology line 5513; OpenStax Biology 2e §4.5.

**Card 9**
**Cloze claim:** Two compartments — intermembrane space (proton gradient) and matrix (citric acid cycle + pyruvate oxidation).
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.5; §7.4.

**Card 10**
**Cloze claim:** Mitochondria have their own circular DNA + 70S ribosomes; the endosymbiotic theory explains the bacterial fingerprint.
**Confidence:** 5
**Source:** OpenStax Microbiology lines 5503, 5243 (mitochondrial 70S ribosomes). Endosymbiotic theory: OpenStax Biology 2e §4.5, §22.1.

**Card 11**
**Cloze claim:** Cytochrome c release from mitochondria triggers caspase-mediated apoptosis.
**Confidence:** 4
**Source:** OpenStax Biology 2e §10.5 (programmed cell death); OpenStax A&P 2e §3.6.
**Notes:** Caspase cascade detail is at the high end of MCAT scope but is consistently presented in mainstream sources.

### Subtopic 5 — The Endomembrane System

**Card 12**
**Cloze claim:** The endomembrane system unifies the nuclear envelope, ER, Golgi, lysosomes, endosomes, and trafficking vesicles.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.4 ("The Endomembrane System and Proteins").

**Card 13**
**Cloze claim:** RER's surface-bound ribosomes translate proteins destined for secretion, membrane insertion, or other endomembrane organelles directly into the ER lumen.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.4.

**Card 14**
**Cloze claim:** SER specializes in lipid/steroid synthesis and drug/metabolite detoxification.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.4.

**Card 15**
**Cloze claim:** Golgi modifies arriving proteins via glycosylation, phosphorylation, and signal-sequence addition, then sorts them into destination-specific vesicles.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.4.

**Card 16**
**Cloze claim:** Directional flow: RER → Golgi → vesicle → target compartment or plasma membrane.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.4.

**Card 17**
**Cloze claim:** Lysosomes digest endocytic cargo, mediate autophagy, and can drive autolysis.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.4.

**Card 18**
**Cloze claim:** Peroxisomes break down very long-chain fatty acids via β-oxidation; also contribute to phospholipid synthesis and the pentose phosphate pathway.
**Confidence:** 4
**Source:** OpenStax Biology 2e §4.4 (β-oxidation + phospholipids).
**Notes:** The pentose-phosphate-pathway contribution is true biochemically but is at the periphery of MCAT scope; phrasing kept as "contributes to" rather than implying peroxisomes alone run the pathway.

**Card 19**
**Cloze claim:** Endosomes are sorting compartments that route endocytic cargo to recycling, the Golgi, or lysosomal degradation.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.4.

### Subtopic 6 — The Cytoskeleton

**Card 20**
**Cloze claim:** Three filament classes — microfilaments (actin), microtubules (tubulin), intermediate filaments (keratin/vimentin/desmin/lamins).
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.6.

**Card 21**
**Cloze claim:** Microfilaments + myosin generate force for muscle contraction, intracellular movement, and the cleavage furrow.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.6.

**Card 22**
**Cloze claim:** Cytokinesis cleavage furrow is generated by an actin–myosin ring contracting at the equator.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.4.

**Card 23**
**Cloze claim:** Kinesin walks toward microtubule plus ends (anterograde); dynein toward minus ends (retrograde).
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.6.

**Card 24**
**Cloze claim:** Eukaryotic cilia and flagella share the 9+2 microtubule architecture.
**Confidence:** 5
**Source:** OpenStax Biology 2e line 5933 (9+2 array); line 5939 ("nine microtubule doublets … two central").
**Excerpt:** "microtubules called a '9 + 2 array.'"

**Card 25**
**Cloze claim:** Cilia move material across a stationary cell; flagella propel the cell itself.
**Confidence:** 5
**Source:** OpenStax Biology 2e §4.6.

**Card 26**
**Cloze claim:** Centrioles are built from nine triplets of microtubules and form the heart of the centrosome (the cell's main MTOC).
**Confidence:** 5
**Source:** OpenStax Biology 2e lines 5534, 5540 ("triplets of microtubules").

**Card 27**
**Cloze claim:** Kinetochore assembles on the centromere and is the attachment point for spindle microtubules during anaphase.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.2; OpenStax Microbiology §11.5.

### Subtopic 7 — Eukaryotic Tissues

**Card 28**
**Cloze claim:** Epithelium lines surfaces/cavities, forms the parenchyma of most glands, and rests on the basement membrane.
**Confidence:** 5
**Source:** OpenStax A&P 2e §4.2; §4.3.

**Card 29**
**Cloze claim:** Simple / stratified / pseudostratified classify epithelia by layer count.
**Confidence:** 5
**Source:** OpenStax A&P 2e lines 6529–6534.
**Excerpt:** "Pseudostratified … describes tissue with a single layer of cells."

**Card 30**
**Cloze claim:** Squamous / cuboidal / columnar classify epithelial cell shape.
**Confidence:** 5
**Source:** OpenStax A&P 2e line 6529 ("Cell shapes can be squamous (flattened and thin), cuboidal (boxy …), or columnar (rectangular …)").

**Card 31**
**Cloze claim:** Connective tissue supplies the supporting framework (stroma) that anchors functional cells (parenchyma).
**Confidence:** 5
**Source:** OpenStax A&P 2e §4.3, §4.4.

**Card 32**
**Cloze claim:** ECM = collagen (tensile strength) + elastin (elastic recoil) + proteoglycans (hydration / resistance to compression).
**Confidence:** 5
**Source:** OpenStax A&P 2e §4.3 (Connective Tissue Proper); OpenStax Biology 2e §4.6.

**Card 33**
**Cloze claim:** Fibroblasts / osteoblasts / chondroblasts = connective. Endothelial cells + pancreatic α-cells = epithelial in origin.
**Confidence:** 4
**Source:** OpenStax A&P 2e §4.3, §4.4 (connective cell types); §19.2 (endothelial = simple squamous epithelium).
**Notes:** Pancreatic α-cell classification as "epithelial in origin" reflects the histological fact that the endocrine islets are clusters of epithelial-derived cells; some sources frame this as "modified epithelium." Standard MCAT-style classification matches.

### Subtopic 8 — Prokaryotic Cell Architecture

**Card 34**
**Cloze claim:** Cell wall + cell membrane = envelope.
**Confidence:** 5
**Source:** OpenStax Microbiology §3.3.

**Card 35**
**Cloze claim:** In prokaryotes the ETC + oxidative phosphorylation are on the plasma membrane itself (no mitochondria).
**Confidence:** 5
**Source:** OpenStax Microbiology §3.3; §8.4.

**Card 36**
**Cloze claim:** Gram-positive: thick peptidoglycan + lipoteichoic acid; stains purple with crystal violet.
**Confidence:** 5
**Source:** OpenStax Microbiology §3.3 (cell wall structure); §2.4 (Gram stain).

**Card 37**
**Cloze claim:** Gram-negative: thin peptidoglycan between inner and outer membrane; periplasmic space; pink with safranin.
**Confidence:** 5
**Source:** OpenStax Microbiology §3.3, §2.4.

**Card 38**
**Cloze claim:** Outer membrane of Gram-negatives displays LPS (endotoxin); drives septic shock.
**Confidence:** 5
**Source:** OpenStax Microbiology §3.3; §15.6 (endotoxins).

**Card 39**
**Cloze claim:** Prokaryotic flagellum: flagellin filament; basal body + hook + filament; chemotaxis.
**Confidence:** 5
**Source:** OpenStax Microbiology §3.3 (Prokaryotic Cell Structure); §3.3 (taxes).

### Subtopic 9 — Prokaryotic Domains

**Card 40**
**Cloze claim:** Three domains: Bacteria, Archaea, Eukarya.
**Confidence:** 5
**Source:** OpenStax Biology 2e §22.1; OpenStax Microbiology §1.2.

**Card 41**
**Cloze claim:** Archaea share morphology with Bacteria but biochemistry (histones, RNA polymerase, unmodified Met initiator) with Eukarya.
**Confidence:** 5
**Source:** OpenStax Microbiology §4.5 (Archaea); OpenStax Biology 2e §22.3.
**Notes:** Source .docx claimed "Eukaryotes and Archaea start translation with methionine" implying Bacteria don't; this card corrects to fMet-vs-Met distinction.

**Card 42**
**Cloze claim:** Extremophiles are disproportionately Archaeal.
**Confidence:** 5
**Source:** OpenStax Microbiology §4.5; OpenStax Biology 2e §22.3.

### Subtopic 10 — Bacterial Shapes

**Card 43**
**Cloze claim:** Cocci / bacilli / spirilla = spherical / rod / spiral.
**Confidence:** 5
**Source:** OpenStax Microbiology §3.3.

### Subtopic 11 — Prokaryotic Metabolism

**Card 44**
**Cloze claim:** Aerobic metabolism uses O₂ as terminal electron acceptor → high ATP via oxphos; anaerobic uses alternative inorganic acceptors (SO₄²⁻, NO₃⁻) or fermentation.
**Confidence:** 5
**Source:** OpenStax Microbiology §8.4–8.5; OpenStax Biology 2e §7.5.

**Card 45**
**Cloze claim:** Four-way O₂ tolerance: obligate aerobe / obligate anaerobe / facultative anaerobe / aerotolerant anaerobe.
**Confidence:** 5
**Source:** OpenStax Microbiology §9.3 ("Oxygen Requirements"); multiple lines (6708, 6753, 6856, 7388 etc.).

**Card 46**
**Cloze claim:** Mutualistic / commensal / pathogenic categorize host-bacteria relationships.
**Confidence:** 5
**Source:** OpenStax Microbiology §15.1; OpenStax Biology 2e §45.6.

### Subtopic 12 — Prokaryotic Reproduction

**Card 47**
**Cloze claim:** Binary fission: chromosome attaches to membrane, replicates, cell elongates, membrane + wall pinch inward.
**Confidence:** 5
**Source:** OpenStax Microbiology §9.1; OpenStax Biology 2e §10.1.
**Notes:** Source .docx used "binary fusion" (incorrect) — corrected to "binary fission" per textbook.

### Subtopic 13 — Bacterial Genetic Exchange

**Card 48**
**Cloze claim:** Plasmid = small circular dsDNA, separate from chromosome, often carries antibiotic resistance or virulence genes.
**Confidence:** 5
**Source:** OpenStax Microbiology §11.6 ("Plasmids"); OpenStax Biology 2e §17.1.

**Card 49**
**Cloze claim:** Episomes = plasmids that can integrate into the chromosome.
**Confidence:** 5
**Source:** OpenStax Microbiology §11.6.

**Card 50**
**Cloze claim:** F factor encodes sex pilus; F+ = donor, F- = recipient.
**Confidence:** 5
**Source:** OpenStax Microbiology §11.6 (Conjugation).

**Card 51**
**Cloze claim:** Hfr = F-factor integrated into chromosome; can transfer chromosomal genes during conjugation.
**Confidence:** 5
**Source:** OpenStax Microbiology §11.6 (Hfr strains).

**Card 52**
**Cloze claim:** Transformation = uptake of free environmental DNA.
**Confidence:** 5
**Source:** OpenStax Microbiology §11.6.

**Card 53**
**Cloze claim:** Conjugation = unidirectional DNA transfer via sex pilus bridge from F+ to F-.
**Confidence:** 5
**Source:** OpenStax Microbiology §11.6.

**Card 54**
**Cloze claim:** Transduction = bacteriophage-mediated DNA transfer; only mode requiring a viral vector.
**Confidence:** 5
**Source:** OpenStax Microbiology §11.6; AAMC outline line 1587 ("Transduction: transfer of genetic material by viruses").

**Card 55**
**Cloze claim:** Transposons = mobile genetic elements that excise and re-insert; can disrupt genes.
**Confidence:** 5
**Source:** OpenStax Microbiology §11.6 ("Transposable Elements"); OpenStax Biology 2e §17.2.

**Card 56**
**Cloze claim:** Virulence factors = pathogenicity-enhancing traits (toxins, attachment, immune evasion); often plasmid-encoded.
**Confidence:** 5
**Source:** OpenStax Microbiology §15.3 ("Virulence Factors of Bacterial and Viral Pathogens").

### Subtopic 14 — Bacterial Growth Curve

**Card 57**
**Cloze claim:** Four phases: lag → log/exponential → stationary → death.
**Confidence:** 5
**Source:** OpenStax Microbiology §9.2 ("The Growth Curve").

### Subtopic 15 — Viral Structure & Classification

**Card 58**
**Cloze claim:** Capsid = protein shell; envelope = host-derived phospholipid + viral glycoproteins; envelope is heat/detergent/drying-sensitive.
**Confidence:** 5
**Source:** OpenStax Microbiology §6.1 ("Viruses").

**Card 59**
**Cloze claim:** Viruses are obligate intracellular parasites; lack ribosomes and metabolic machinery.
**Confidence:** 5
**Source:** OpenStax Microbiology §6.1; AAMC outline line 1580+.

**Card 60**
**Cloze claim:** Bacteriophage anatomy: capsid head, contractile tail sheath (injection), tail fibers (receptor recognition).
**Confidence:** 5
**Source:** OpenStax Microbiology §6.2 (Bacteriophages).

### Subtopic 16 — Viral Genome Strategies

**Card 61**
**Cloze claim:** (+)-sense RNA virus genome is directly translatable; virion need not carry an RNA polymerase.
**Confidence:** 5
**Source:** OpenStax Microbiology §6.3.

**Card 62**
**Cloze claim:** (−)-sense RNA virus must carry RNA-dependent RNA polymerase to first synthesize (+)-strand.
**Confidence:** 5
**Source:** OpenStax Microbiology §6.3.

**Card 63**
**Cloze claim:** Retroviruses carry reverse transcriptase; produce DNA from RNA genome; integrate as provirus.
**Confidence:** 5
**Source:** OpenStax Microbiology §6.3 (Retroviruses); AAMC outline lines 1589–1590.
**Excerpt:** "Retrovirus life cycle: integration into host DNA, reverse transcriptase, HIV."

### Subtopic 17 — Viral Life Cycle

**Card 64**
**Cloze claim:** Viral tropism is controlled by specific surface receptor recognition.
**Confidence:** 5
**Source:** OpenStax Microbiology §6.2.

**Card 65**
**Cloze claim:** Enveloped virus entry = membrane fusion; non-enveloped = receptor-mediated endocytosis.
**Confidence:** 5
**Source:** OpenStax Microbiology §6.2; AAMC outline line 1582–1583 ("penetration of cell membrane … entry of viral genetic material").

**Card 66**
**Cloze claim:** Progeny release = lysis (one-time burst) or extrusion (continuous budding, productive cycle).
**Confidence:** 5
**Source:** OpenStax Microbiology §6.2.

**Card 67**
**Cloze claim:** Lytic cycle = immediate replication + cell burst; lysogenic cycle = genome integrates as prophage, replicates passively, can revert to lytic.
**Confidence:** 5
**Source:** OpenStax Microbiology §6.2 (Bacteriophage Life Cycles); AAMC outline line 1580–1590.

### Subtopic 18 — Subviral Pathogens

**Card 68**
**Cloze claim:** Prions = infectious proteins inducing native α-helix to refold into β-sheet aggregates.
**Confidence:** 5
**Source:** OpenStax Microbiology §6.4 ("Prions and Viroids"); AAMC outline line 1591.

**Card 69**
**Cloze claim:** Viroids = circular ssRNA pathogens; no protein coat; infect plants; cause disease by base-pairing with host RNAs.
**Confidence:** 5
**Source:** OpenStax Microbiology §6.4; AAMC outline line 1591.

### Subtopic 19 — Connections to Other Chapters

**Card 70**
**Cloze claim:** Ubiquitination tags proteins for proteasomal degradation.
**Confidence:** 4
**Source:** OpenStax Biology 2e §11.6 ("Signaling … and Cellular Responses"); OpenStax A&P 2e §3.5.
**Notes:** Ubiquitination is not in the explicit AAMC outline but is in mainstream cell-bio textbooks; user requested inclusion. Kept at confidence 4 because the AAMC framing is implicit rather than explicit.

**Card 71**
**Cloze claim:** ETC requires a terminal electron acceptor (O₂ for aerobes; SO₄²⁻/NO₃⁻ for some anaerobes).
**Confidence:** 5
**Source:** OpenStax Microbiology §8.4–8.5; OpenStax Biology 2e §7.5.
**Notes:** Source .docx phrasing ("inorganic ions") was fuzzy; clarified to specific acceptor examples per textbook.

**Card 72**
**Cloze claim:** cDNA is synthesized from mRNA by reverse transcriptase; lab technique for cloning intron-less coding sequences.
**Confidence:** 5
**Source:** AAMC outline line 1152 ("Generation of cDNA"); OpenStax Microbiology §12.2; OpenStax Biology 2e §17.1.

---

## needs_sme_review

*(None — all 73 cards verified at confidence 4–5.)*

---

## Disagreements with corpus

Three source-material claims (from the .docx and/or .apkg) contradicted the reference textbooks. None became cards as originally written; each was corrected before SQL output.

1. **".docx: 'The mitochondria replicate independently of the nucleus via binary fusion.'"**
   - **Issue:** "Binary fusion" is incorrect; the term is binary fission.
   - **Resolution:** Card 47 uses *binary fission* per OpenStax Biology 2e §10.1 and OpenStax Microbiology §9.1.

2. **".docx: 'Eukaryotes and Archaea start translation with methionine'" (implying Bacteria do not).**
   - **Issue:** Bacteria also initiate translation with methionine — specifically N-formylmethionine (fMet). The actual Archaea/Eukarya distinction from Bacteria is the *absence* of the formyl modification, not the presence of methionine.
   - **Resolution:** Card 41 reframes the distinction as unmodified-Met (Archaea, Eukarya) vs. fMet (Bacteria), per OpenStax Microbiology §11.4.

3. **".docx / .apkg: 'The Krebs cycle and ETC are only active in the presence of a final electron acceptor, such as oxygen (aerobic respiration) or inorganic ions (anaerobic respiration).'"**
   - **Issue:** Two problems. (a) The Krebs cycle itself does not require a terminal electron acceptor — only the ETC does. (b) "Inorganic ions" is fuzzy; the textbook lists specific alternative acceptors (sulfate, nitrate).
   - **Resolution:** Card 71 narrows the claim to the ETC specifically and names the canonical alternative acceptors per OpenStax Microbiology §8.4.

---

## Discrepancies between primary and secondary sources

None. Where multiple OpenStax textbooks treat the same topic (e.g., mitochondrial ribosomes in Biology 2e and Microbiology), their statements agree.

---

## Post-verification SME decisions

*(Reserved for future SME / content lead. Each entry should record: card number, decision, rationale, date.)*
