# Verification Report — Biology Ch 1: Cell Architecture, Microbes & Viruses

**Deck:** Cell Architecture, Microbes & Viruses
**Source SQL:** supabase/seeds/biology_ch1_the_cell_flashcards.sql
**Verified:** 2026-04-26
**Corpus:**
- openstax-biology-2e.txt (primary for cell biology / organelles / cytoskeleton)
- openstax-microbiology.txt (primary for prokaryotes / viruses / prions / viroids / bacterial genetics)
- openstax-anatomy-physiology-2e.txt (primary for tissue types)

## Summary

- Total cards: 96
- Confidence 5: 62
- Confidence 4: 22
- Confidence 3: 7
- Confidence 2: 5
- Confidence 1: 0
- Cards flagged for needs_sme_review: 12
- Cards where corpus contradicts card: 0

## Per-card verification

### Card 0 — Cell theory four principles
**Cloze claim:** Four principles: cells build organisms; cell is smallest functional unit of life; new cells from pre-existing cells; hereditary information is DNA passed parent→daughter.
**Confidence:** 4
**Source:** openstax-biology-2e.txt §4.1, lines 5145–5165, 6271
**Excerpt:** "The unified cell theory states that one or more cells comprise all living things, the cell is the basic unit of life, [and new cells arise from existing cells]."
**Notes:** OpenStax Biology 2e gives a 3-pillar "unified cell theory." A 4th principle ("DNA hereditary, passed to daughter cells") is widely included in MCAT prep but is NOT stated as a "core principle of cell theory" in the OpenStax corpus. The fact is true, but the framing as "four core principles" is editorial. Mark needs_sme_review borderline-acceptable.

### Card 1 — Modern addendum excludes viruses
**Cloze claim:** Modern addendum excludes viruses from definition of life because they cannot reproduce without a host.
**Confidence:** 3
**Source:** openstax-microbiology.txt line 1898–1899: "Like viruses, prions are not found on the tree of life because they are acellular."
**Notes:** Not framed as a "modern addendum to cell theory" in the corpus. The substantive claim (viruses excluded; need a host) is supported throughout, but the specific "addendum" wording isn't traceable.

### Card 2 — Membrane-bound organelles distinguish eukaryotes
**Cloze claim:** Presence of membrane-bound organelles (incl. true nucleus) defines eukaryotes vs prokaryotes.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5326–5328: "1) a membrane-bound nucleus; 2) numerous membrane-bound organelles such as the endoplasmic reticulum, Golgi apparatus..."

### Card 3 — 80S vs 70S ribosomes
**Cloze claim:** Eukaryotic 80S, prokaryotic 70S; antibiotic target.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 18596–18597: "the large subunit is 50S, for a total of 70S... Mammalian ribosomes have a small 40S subunit and a large 60S subunit, for a total of 80S."

### Card 4 — Coupled transcription/translation in prokaryotes
**Cloze claim:** Prokaryotes do simultaneous transcription/translation; eukaryotic transcription is in nucleus, translation in cytoplasm.
**Confidence:** 5
**Source:** openstax-microbiology.txt line 18782, 18915, 20257–20267: "transcription and translation can occur simultaneously [in prokaryotes]" / "Transcription and translation are not coupled in [eukaryotes]."

### Card 5 — Histones in archaea but not bacteria
**Cloze claim:** Histones found in eukaryotes and archaea, absent in bacteria.
**Confidence:** 5
**Source:** openstax-microbiology.txt lines 4448–4449, 17405–17407, 18263–18264: "Chromosomal DNA is typically wrapped around histones (in eukaryotes and archaea) or histone-like proteins (in bacteria)."

### Card 6 — Krebs/ETC require final electron acceptor
**Cloze claim:** Krebs cycle and ETC need final electron acceptor — typically O2 (aerobic) or sulfate/nitrate (anaerobic).
**Confidence:** 4
**Source:** openstax-microbiology.txt §8 metabolism (chapters around 13000–13300) discusses aerobic/anaerobic respiration with sulfate/nitrate acceptors.
**Notes:** The simplified statement that Krebs "only runs when a final electron acceptor is available" is true in practice (NADH must be reoxidized) but slightly oversimplified — Krebs proper does not directly use the acceptor, the ETC does. Phrasing acceptable.

### Card 7 — Cytosol hosts glycolysis
**Cloze claim:** Cytosol is aqueous portion of cytoplasm; hosts glycolysis.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §4 cytoplasm definition; glycolysis is repeatedly described as occurring in the cytoplasm/cytosol.

### Card 8 — Nucleus stores DNA, controls transcription
**Cloze claim:** DNA stored in nucleus; control center for transcription/regulation.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §4 ~5400.

### Card 9 — Nuclear envelope is double membrane with pores
**Cloze claim:** Nuclear envelope is double-membraned, perforated by nuclear pores.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5410–5413: "The nuclear envelope is a double-membrane structure... punctuated with pores that control the passage of ions, molecules, and RNA."

### Card 10 — Nucleolus makes rRNA, partial ribosome assembly
**Cloze claim:** Nucleolus is dense subregion where rRNA is transcribed, ribosomal subunits partially assembled.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5442–5446: nucleolus "have sections of DNA that encode ribosomal RNA... ribosome synthesis occurs."

### Card 11 — Chromatin condenses to chromosomes
**Cloze claim:** DNA wraps around histones forming chromatin; condenses into chromosomes during division.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 12461–12465.

### Card 12 — Mitochondrion makes ATP, releases cytochrome c for apoptosis
**Cloze claim:** Mitochondria make ATP via oxidative phosphorylation and initiate apoptosis via cytochrome c.
**Confidence:** 3
**Source:** openstax-biology-2e.txt lines 5485–5495 covers ATP role; cytochrome c apoptosis role NOT directly stated in any of the three corpus files.
**Notes:** ATP function fully supported; cytochrome c apoptosis claim is high-yield MCAT but unverifiable in this corpus.

### Card 13 — Mitochondria divide by binary fission (endosymbiosis)
**Cloze claim:** Mitochondria carry circular genome, divide by binary fission — supports endosymbiotic theory.
**Confidence:** 5
**Source:** openstax-microbiology.txt line 4137: "fission of these organelles strongly resembles the binary fission of bacteria"; openstax-biology-2e.txt 5610–5624 endosymbiotic theory.

### Card 14 — Outer mitochondrial membrane has porins; inner has cristae
**Cloze claim:** Outer membrane permeable via porins; inner membrane folded into cristae and houses ETC.
**Confidence:** 3
**Source:** openstax-biology-2e.txt lines 5485–5496 confirms cristae and ETC location.
**Notes:** "Porins" not mentioned by name in any of the three corpus files. The outer membrane permeability is described but the protein name is unverified. Inner membrane/cristae/ETC fully supported.

### Card 15 — Intermembrane space holds proton gradient
**Cloze claim:** Space between two mitochondrial membranes = intermembrane space; reservoir of proton gradient driving ATP synthase.
**Confidence:** 5
**Source:** openstax-biology-2e.txt line 5494–5495: "the space between the two membranes the intermembrane space."

### Card 16 — Mitochondrial matrix houses Krebs and mtDNA
**Cloze claim:** Matrix is innermost compartment; houses Krebs enzymes and mtDNA.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5486–5495.

### Card 17 — Cytoplasmic (extranuclear) inheritance
**Cloze claim:** Mitochondrial DNA is maternally inherited; called cytoplasmic/extranuclear inheritance.
**Confidence:** 4
**Source:** openstax-biology-2e.txt line 21188: "mitochondrial DNA in most multicellular organisms passes from the mother."
**Notes:** Maternal inheritance confirmed. The label "cytoplasmic (extranuclear) inheritance" is conventional but not stated verbatim.

### Card 18 — Lysosome: hydrolytic, acidic
**Cloze claim:** Lysosome filled with hydrolytic enzymes optimal at acidic pH.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5547–5555.

### Card 19 — Autolysis
**Cloze claim:** Lysosome ruptures → self-digestion = autolysis.
**Confidence:** 2
**Source:** "Autolysis" term not located in the corpus.
**Notes:** Concept correct but term unverified in corpus. needs_sme_review.

### Card 20 — Endosome → lysosome maturation
**Cloze claim:** Endocytosed material packaged in endosome; can mature and fuse with lysosome.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 7415–7416: "newly formed compartment (endosome)... merges with the plasma membrane... lysosome destroys."

### Card 21 — RER: studded ribosomes; protein synthesis for secretion/membranes
**Cloze claim:** RER is studded by ribosomes; synthesizes proteins for secretion or membrane insertion.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5664, 5684–5696.

### Card 22 — SER: lipid synthesis & detoxification
**Cloze claim:** SER lacks ribosomes; lipid synthesis and drug detoxification.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5712–5716.

### Card 23 — SER specialized roles (steroids, glycogen, calcium/SR)
**Cloze claim:** Steroid hormone synthesis, glycogen breakdown in hepatocytes, Ca2+ storage in muscle (SR).
**Confidence:** 4
**Source:** openstax-biology-2e.txt lines 5712–5716 covers Ca2+/sarcoplasmic reticulum and steroid synthesis. Glycogen breakdown localization noted but less explicit.

### Card 24 — Golgi modifies/sorts/packages
**Cloze claim:** Proteins from ER enter Golgi, modified, sorted, packaged.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5751–5777.

### Card 25 — Trans face buds → secretory vesicles, lysosomes, plasma membrane
**Cloze claim:** Vesicles bud from trans face → secretory vesicles, lysosomes, or plasma-membrane vesicles.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5764–5777.

### Card 26 — Peroxisomes break down VLCFA via β-oxidation; produce H2O2
**Cloze claim:** Peroxisomes use O2 to break down very-long-chain fatty acids via β-oxidation; H2O2 byproduct.
**Confidence:** 4
**Source:** openstax-biology-2e.txt lines 5507–5512; openstax-microbiology.txt 5357–5360.
**Notes:** "Very-long-chain fatty acids" specifically not stated; corpus says peroxisomes carry out oxidation reactions and produce H2O2.

### Card 27 — Catalase neutralizes H2O2
**Cloze claim:** Catalase breaks down H2O2.
**Confidence:** 4
**Source:** openstax-biology-2e.txt lines 5510–5512: "enzymes safely break down the H2O2 into oxygen and water." (Catalase implied; not named.)
**Notes:** Catalase is the textbook MCAT answer; corpus describes the function but not by enzyme name.

### Card 28 — Peroxisomes contribute to lipid biosynthesis & PPP
**Cloze claim:** Peroxisomes contribute to lipid biosynthesis and the pentose phosphate pathway.
**Confidence:** 3
**Source:** openstax-microbiology.txt line 5357–5360 mentions "biosynthesis."
**Notes:** "Pentose phosphate pathway" peroxisomal localization not directly stated. needs_sme_review.

### Card 29 — Microfilaments = actin; cell shape & contraction
**Cloze claim:** Microfilaments built from actin; cell shape changes and muscle contraction with myosin.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5853–5876.

### Card 30 — Cleavage furrow = actin/myosin contractile ring
**Cloze claim:** Contractile ring of actin & myosin pinches cell, forming cleavage furrow.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 12692–12695, 13856.

### Card 31 — Microtubules = tubulin dimers; spindle, transport
**Cloze claim:** Hollow tubes of tubulin dimers; mitotic spindle and organelle transport.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5905–5910.

### Card 32 — Kinesin (+ end) and dynein (− end)
**Cloze claim:** Kinesin → plus (peripheral) end; dynein → minus (centrosomal) end.
**Confidence:** 3
**Source:** openstax-microbiology.txt line 5461 mentions both motors but does not specify directionality.
**Notes:** Directionality is high-yield MCAT and correct, but neither corpus file states which motor goes which direction. needs_sme_review.

### Card 33 — 9+2 cilia/flagella
**Cloze claim:** Eukaryotic cilia/flagella display 9+2 array.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5933–5939; openstax-microbiology.txt line 5672.

### Card 34 — Centriole = nine triplets
**Cloze claim:** Centriole is barrel-shaped, made of nine triplets of microtubules.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5532–5540.

### Card 35 — Centrosome = MTOC with paired centrioles
**Cloze claim:** Centrosome is principal MTOC; pair of perpendicular centrioles.
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 5526–5534.

### Card 36 — Kinetochore at centromere
**Cloze claim:** Spindle microtubules attach to chromosome at kinetochore (specialized complex on centromere).
**Confidence:** 5
**Source:** openstax-biology-2e.txt lines 12601, 12617–12623.

### Card 37 — Intermediate filaments: keratin, desmin, vimentin, lamins
**Cloze claim:** Intermediate filaments provide tensile strength; examples keratin, desmin, vimentin, lamins.
**Confidence:** 4
**Source:** openstax-biology-2e.txt lines 5887–5902 confirms intermediate filaments + keratin; openstax-microbiology.txt 5444 confirms lamins (nuclear lamina).
**Notes:** "Desmin" and "vimentin" specifically not located in corpus. The named examples are conventional and correct.

### Card 38 — Epithelial tissue & basement membrane
**Cloze claim:** Epithelial covers/lines surfaces; rests on basement membrane anchoring it to connective tissue.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt lines 6314, 6443–6446.

### Card 39 — Parenchyma vs stroma
**Cloze claim:** Parenchyma = functional cells; stroma = structural support.
**Confidence:** 2
**Source:** Terms not located in any of the three corpus files (other than incidental usage).
**Notes:** Standard histology terms; correct, but unverified. needs_sme_review.

### Card 40 — Epithelial layering
**Cloze claim:** Simple (one layer), stratified (multiple), pseudostratified (one but appears multi).
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt lines 6531–6534.

### Card 41 — Epithelial shapes
**Cloze claim:** Squamous (flat), cuboidal (cube), columnar (tall column).
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt lines 6529.

### Card 42 — Connective tissue: sparse cells in ECM
**Cloze claim:** Connective tissue: sparse cells embedded in ECM, which it secretes.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt lines 6725–6738.

### Card 43 — Cell origins (fibroblasts/osteoblasts → connective; endothelial/α-cells → epithelial)
**Cloze claim:** Fibroblasts, osteoblasts, chondroblasts → connective; endothelial cells and pancreatic α-cells → epithelial origin.
**Confidence:** 3
**Source:** openstax-anatomy-physiology-2e.txt line 6431, 6545: "endothelium... is a type of epithelium" — confirmed. Pancreatic α-cells not explicitly classified as "epithelial in origin" in corpus.
**Notes:** Endothelial-as-epithelial confirmed; α-cell epithelial-origin claim is correct embryologically but unverified in corpus. needs_sme_review for α-cell wording.

### Card 44 — Archaea / extremophiles
**Cloze claim:** Archaea single-celled prokaryotes inhabit hostile environments — extremophiles.
**Confidence:** 5
**Source:** openstax-microbiology.txt lines 1654–1664: "archaea live in extreme environments."

### Card 45 — Archaea share features with both
**Cloze claim:** Archaea share circular chromosome and lack of organelles with bacteria; resemble eukaryotes in starting translation with methionine and using histone-like proteins.
**Confidence:** 4
**Source:** openstax-microbiology.txt lines 5056–5057 (table comparing): archaea contain histones; bacteria lack. Methionine start common to eukaryotes (line 18725); archaea use methionine like eukaryotes (vs bacterial fMet).
**Notes:** Methionine-vs-fMet distinction not explicitly stated in corpus (only for eukaryotes). Otherwise solid.

### Card 46 — Bacterial shapes
**Cloze claim:** Cocci (spherical), bacilli (rod), spirilli (spiral).
**Confidence:** 4
**Source:** openstax-microbiology.txt lines 1635–1636: "spherical (coccus), rod-shaped (bacillus), or curved (spirillum, spirochete, or vibrio)."
**Notes:** Card uses "spirilli" — corpus uses singular "spirillum" (and proper plural is "spirilla"). Minor terminology issue; consider correcting "spirilli" → "spirilla."

### Card 47 — Mutualistic symbiotes vs pathogens/parasites
**Cloze claim:** Bacteria living with host without harm = mutualistic symbiotes; disease-causing = pathogens/parasites.
**Confidence:** 4
**Source:** openstax-microbiology.txt various; symbiosis discussed at length, "mutualism" used; "pathogen/parasite" repeatedly used.
**Notes:** Term "mutualistic symbiote" specifically not located, but standard. Concept fully supported.

### Card 48 — Obligate aerobes
**Cloze claim:** Cannot survive without oxygen.
**Confidence:** 5
**Source:** openstax-microbiology.txt §9 lines 15202–15254.

### Card 49 — Obligate anaerobes
**Cloze claim:** Poisoned by oxygen, depend on anaerobic metabolism.
**Confidence:** 5
**Source:** openstax-microbiology.txt line 15250: "obligate anaerobes, which are killed by oxygen."

### Card 50 — Facultative anaerobes
**Cloze claim:** Prefer aerobic; switch to anaerobic when oxygen absent.
**Confidence:** 5
**Source:** openstax-microbiology.txt line 15251–15254.

### Card 51 — Aerotolerant anaerobes
**Cloze claim:** Never use O2 but not harmed by it.
**Confidence:** 5
**Source:** openstax-microbiology.txt line 15254: "aerotolerant anaerobes... indifferent to the presence of oxygen. They do not use oxygen."

### Card 52 — Cell wall = peptidoglycan
**Cloze claim:** Bacterial cell wall is cross-linked peptidoglycan, external to plasma membrane.
**Confidence:** 5
**Source:** openstax-microbiology.txt 1633, 1685, 4357 etc.

### Card 53 — Gram-positive: purple, thick peptidoglycan, lipoteichoic acid
**Cloze claim:** Gram-positive stain purple from thick peptidoglycan retaining crystal violet; contain lipoteichoic acid.
**Confidence:** 5
**Source:** openstax-microbiology.txt 3180–3201; lipoteichoic acid mentioned in §3.

### Card 54 — Gram-negative: pink, thin peptidoglycan, LPS
**Cloze claim:** Gram-negative pink; thin peptidoglycan between two membranes; LPS on outer membrane.
**Confidence:** 5
**Source:** openstax-microbiology.txt 3200–3201, 4789–4800.

### Card 55 — Periplasmic space
**Cloze claim:** Gap between inner/outer Gram-negative membranes is periplasmic space; houses degradative enzymes.
**Confidence:** 4
**Source:** openstax-microbiology.txt §3 cell envelope (~4785) describes periplasmic gel-like space.

### Card 56 — Gram-positive vulnerable to penicillin
**Cloze claim:** Gram-positive's thick peptidoglycan + LTA make them more vulnerable to penicillin (which blocks cell-wall synthesis).
**Confidence:** 4
**Source:** openstax-microbiology.txt 25239: "[broader spectrum drugs are] active against more gram-negative bacteria than penicillin" — implies penicillin's primary activity is gram-positive.
**Notes:** Mechanism (penicillin blocks cell wall synthesis) confirmed in §14; differential gram+ susceptibility supported but stated indirectly.

### Card 57 — LPS endotoxin
**Cloze claim:** Released LPS = endotoxin; triggers immune response and septic shock.
**Confidence:** 5
**Source:** openstax-microbiology.txt 4789–4800: "lipopolysaccharide (LPS), which functions as an endotoxin... fever, hemorrhaging, and septic shock."

### Card 58 — Bacterial flagellum: filament/hook/basal body
**Cloze claim:** Built from flagellin; three regions filament, hook, basal body.
**Confidence:** 5
**Source:** openstax-microbiology.txt 4921–4938.

### Card 59 — Chemotaxis
**Cloze claim:** Bacterial movement along chemical gradients = chemotaxis.
**Confidence:** 4
**Source:** Standard microbiology term referenced throughout corpus.

### Card 60 — Plasmids
**Cloze claim:** Small circular DNA replicating independently; often encode antibiotic resistance/virulence.
**Confidence:** 5
**Source:** openstax-microbiology.txt 4458–4464, 17502–17503.

### Card 61 — Episome
**Cloze claim:** Plasmid integrated reversibly into bacterial chromosome = episome.
**Confidence:** 2
**Source:** "Episome" not explicitly defined in corpus (only "F plasmid integrates → Hfr").
**Notes:** Term is valid but unverified. needs_sme_review.

### Card 62 — Binary fission
**Cloze claim:** Bacterial reproduction asexual via binary fission, two genetically identical daughters.
**Confidence:** 5
**Source:** openstax-microbiology.txt 5060, 5159–5161.

### Card 63 — Transformation
**Cloze claim:** Uptake of naked environmental DNA.
**Confidence:** 5
**Source:** openstax-microbiology.txt 16725–16767.

### Card 64 — Conjugation via sex pilus and F factor
**Cloze claim:** Conjugation = direct DNA transfer via conjugation bridge (sex pilus); driven by F factor plasmid.
**Confidence:** 5
**Source:** openstax-microbiology.txt 4890, 19497–19515.

### Card 65 — F+ donor / F− recipient
**Cloze claim:** F+ ("male") donor, F− ("female") recipient.
**Confidence:** 5
**Source:** openstax-microbiology.txt 19499–19508.

### Card 66 — Hfr
**Cloze claim:** F factor integrating into chromosome → Hfr cell, which transfers chromosomal genes.
**Confidence:** 5
**Source:** openstax-microbiology.txt 19518–19560.

### Card 67 — Transduction
**Cloze claim:** DNA transferred between bacteria using bacteriophage.
**Confidence:** 5
**Source:** openstax-microbiology.txt 10276–10295.

### Card 68 — Transposons
**Cloze claim:** Mobile genetic elements that jump between locations; in prokaryotes and eukaryotes.
**Confidence:** 5
**Source:** openstax-microbiology.txt 16577–16578, 17084.

### Card 69 — Bacterial growth phases
**Cloze claim:** Lag → log/exponential → stationary → death.
**Confidence:** 5
**Source:** openstax-microbiology.txt 14638–14690.

### Card 70 — Capsid + envelope
**Cloze claim:** Virus = nucleic acid in capsid; many have lipid envelope from host membrane.
**Confidence:** 5
**Source:** openstax-microbiology.txt §6 (capsid and envelope discussed).

### Card 71 — Virion
**Cloze claim:** Complete infectious particle outside host = virion.
**Confidence:** 4
**Source:** openstax-microbiology.txt §6 (virion is standard term used throughout).

### Card 72 — Obligate intracellular parasites
**Cloze claim:** Viruses must reproduce inside host because they lack ribosomes.
**Confidence:** 5
**Source:** openstax-microbiology.txt 9762, 9801: "obligate intracellular parasites."

### Card 73 — Bacteriophage structure: head, tail sheath, tail fibers
**Cloze claim:** Phage = head (capsid), contractile tail sheath, tail fibers recognizing host cell wall.
**Confidence:** 4
**Source:** openstax-microbiology.txt §6 phage anatomy discussed; T-even phage description supports details.

### Card 74 — +sense RNA virus
**Cloze claim:** +sense RNA carries genome readable directly as mRNA.
**Confidence:** 5
**Source:** openstax-microbiology.txt 10347+ "+ssRNA viruses... the RNA strand can be directly translated by host ribosomes."

### Card 75 — −sense RNA virus + RdRp
**Cloze claim:** −sense RNA viruses (e.g. influenza) must be transcribed first by RNA-dependent RNA polymerase (RNA replicase).
**Confidence:** 5
**Source:** openstax-microbiology.txt 10347.

### Card 76 — Retrovirus + reverse transcriptase
**Cloze claim:** Retroviruses (HIV) have ssRNA + reverse transcriptase → makes DNA → integrates into host chromosome.
**Confidence:** 5
**Source:** openstax-microbiology.txt 10364–10376.

### Card 77 — cDNA from reverse transcriptase
**Cloze claim:** cDNA produced in lab by treating mRNA with reverse transcriptase.
**Confidence:** 5
**Source:** openstax-biology-2e.txt 20959–20971.

### Card 78 — Three viral life cycle stages
**Cloze claim:** Infection (attachment+entry) → replication and assembly → release.
**Confidence:** 4
**Source:** openstax-microbiology.txt §6 phage lytic cycle stages described.

### Card 79 — Lytic cycle / virulent phage
**Cloze claim:** Lytic = immediate gene expression, hundreds of new virions, host destroyed; always-lytic = virulent.
**Confidence:** 5
**Source:** openstax-microbiology.txt 10210–10230.

### Card 80 — Lysogenic / provirus / prophage
**Cloze claim:** Lysogenic = viral DNA integrates and replicated passively; integrated = provirus (or prophage in bacteria).
**Confidence:** 5
**Source:** openstax-microbiology.txt 10241–10254, 10368.

### Card 81 — Superinfection immunity
**Cloze claim:** Bacterium with prophage protected from infection by same phage strain = superinfection immunity.
**Confidence:** 2
**Source:** Term "superinfection immunity" with this prophage meaning is NOT in the corpus. Corpus uses "superinfection" only in the antibiotic-secondary-infection sense (openstax-microbiology.txt 24924–24978).
**Notes:** The phenomenon is real (lambda phage repressor blocks superinfecting phage), but the corpus does not support either the term or the mechanism here. needs_sme_review — strongest candidate for revision.

### Card 82 — Prions misfold α-helix → β-pleated sheet
**Cloze claim:** Prions induce misfolding from α-helical → β-pleated sheet, aggregation-prone, protease-resistant.
**Confidence:** 2
**Source:** openstax-microbiology.txt 10989–11011 confirms prions are misfolded proteins (PrPc → PrPsc) that induce normal-protein misfolding. The specific α-helix → β-sheet conformational change is NOT stated in the corpus.
**Notes:** Biochemistry textbooks (not in corpus) confirm this fact. needs_sme_review for α/β specifics.

### Card 83 — Viroids = circular RNA, plants, silence host genes
**Cloze claim:** Viroids = tiny circular RNA infecting plants; cause disease by silencing host genes via complementary base-pairing.
**Confidence:** 2
**Source:** openstax-microbiology.txt 10923–10951 confirms circular RNA and plant pathogens. Mechanism described as "take control of host machinery to replicate their RNA genome" — does NOT mention RNA silencing or complementary base-pairing as pathogenic mechanism.
**Notes:** RNA silencing mechanism is supported by primary literature but NOT this corpus. needs_sme_review.

### Card 84 — Aerobic vs anaerobic metabolism
**Cloze claim:** Aerobic uses O2 as final electron acceptor; anaerobic uses fermentation or inorganic ions.
**Confidence:** 5
**Source:** openstax-microbiology.txt §8 metabolism.

### Card 85 — Sex pili encoded by F factor
**Cloze claim:** Sex pili used for conjugation DNA transfer; encoded by F factor.
**Confidence:** 5
**Source:** openstax-microbiology.txt 4890, 19497–19499.

### Card 86 — Fimbriae
**Cloze claim:** Hair-like adhesion structures distinct from flagella, not for DNA transfer.
**Confidence:** 5
**Source:** openstax-microbiology.txt 4881–4897.

### Card 87 — Virulence factor
**Cloze claim:** Plasmid- or chromosome-encoded trait (toxins, capsules, adhesion proteins) increasing pathogen's disease ability.
**Confidence:** 5
**Source:** openstax-microbiology.txt §3, 17163.

### Card 88 — Bacterial plasma membrane houses ETC
**Cloze claim:** Bacterial plasma membrane = site of ETC (no mitochondria).
**Confidence:** 4
**Source:** openstax-microbiology.txt §8 metabolism (prokaryotic ETC located in plasma membrane).

### Card 89 — Lipoteichoic acid in Gram-positive
**Cloze claim:** LTA extends from plasma membrane through peptidoglycan; helps anchor wall and trigger immune response.
**Confidence:** 4
**Source:** openstax-microbiology.txt §3 cell wall coverage.

### Card 90 — Flagellin vs tubulin
**Cloze claim:** Bacterial flagellum polymerized from flagellin; biochemically distinct from tubulin in eukaryotic flagella.
**Confidence:** 5
**Source:** openstax-microbiology.txt 4922–4923 (flagellin); 5905–5910 (eukaryotic flagella = microtubules/tubulin in Biology 2e).

### Card 91 — Eukaryotic flagellum 9+2 microtubules + dynein
**Cloze claim:** Eukaryotic flagellum from microtubules in 9+2 pattern; whip-like via dynein.
**Confidence:** 5
**Source:** openstax-microbiology.txt 5672, 5919–5939 (Biology 2e).

### Card 92 — Basal body = nine triplets like centriole
**Cloze claim:** Cilia/flagella anchored by basal body with same nine-triplet structure as centriole.
**Confidence:** 4
**Source:** openstax-biology-2e.txt 5919 mentions centrioles' relation to flagella/cilia structure.
**Notes:** Direct equivalence basal body ≡ centriole structure not stated verbatim in corpus but strongly implied.

### Card 93 — Pseudostratified epithelium in respiratory tract
**Cloze claim:** Pseudostratified single layer appears multilayered; lines respiratory tract.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt 6573, 44803.

### Card 94 — Stratified squamous: skin and esophagus
**Cloze claim:** Stratified squamous found in skin and esophagus (high abrasion).
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt 6413, 7931 (skin), 47887 (esophagus non-keratinized stratified squamous).

### Card 95 — Ubiquitination → proteasome
**Cloze claim:** Ubiquitin tags proteins for proteasomal destruction.
**Confidence:** 5
**Source:** openstax-biology-2e.txt 19816, 19835–19843.

## needs_sme_review

Cards rated < 4:

- **Card 1** (conf 3): "Modern addendum to cell theory" framing not in corpus. Substantively true; consider rephrasing to "Viruses are excluded from the tree of life because they cannot reproduce without a host."
- **Card 12** (conf 3): Cytochrome c apoptosis claim correct but not in corpus. Either keep (it is high-yield) or split off this clause.
- **Card 14** (conf 3): "Porins" not in corpus. Consider rewording to "is highly permeable to small molecules" if no biochemistry source available.
- **Card 19** (conf 2): "Autolysis" term not in corpus. Concept correct.
- **Card 28** (conf 3): "Pentose phosphate pathway" peroxisomal localization unverified.
- **Card 32** (conf 3): Kinesin/dynein directionality unverified in corpus despite being correct MCAT canon.
- **Card 39** (conf 2): "Parenchyma/stroma" not located in any corpus text.
- **Card 43** (conf 3): Pancreatic α-cell "epithelial in origin" claim unverified in corpus.
- **Card 61** (conf 2): "Episome" term not defined in corpus.
- **Card 81** (conf 2): "Superinfection immunity" prophage usage not in corpus; corpus uses "superinfection" with a different antibiotic-related meaning. **Strongest candidate for revision.**
- **Card 82** (conf 2): α-helix → β-pleated sheet conformational change for prions not in corpus.
- **Card 83** (conf 2): Viroid pathogenic mechanism (RNA silencing via base-pairing) not in corpus; corpus only states viroids hijack host machinery to replicate.

## Disagreements with corpus

None — no card directly contradicts the corpus. All flagged cards are unverifiable, not wrong.

## Discrepancies between primary and secondary sources

- **Cell theory principles count:** OpenStax Biology 2e gives 3 principles ("unified cell theory"); Card 0 asserts 4. The 4th principle (DNA hereditary material) is widely taught but not formally part of OpenStax's cell theory.
- **Spirilli vs spirilla vs spirillum:** Card 46 uses "spirilli." OpenStax microbiology uses "spirillum" (singular). Standard plural is "spirilla." Recommend correction: `spirilli` → `spirilla`.
- **Intermediate filament diameter:** Biology 2e gives 8–10 nm (line 5889); MCAT prep often uses ~10 nm. Card 37 doesn't state a number, so no conflict.

---

## Post-verification SME decisions (2026-04-25)

- **Card 0** ("four core principles" of cell theory): retained. SME accepts the MCAT-prep convention of including DNA-as-hereditary-material as a fourth principle, despite OpenStax's 3-principle framing.
- **Card 46** ("spirilli"): retained as written. Note: standard Latin plural is "spirilla" — recorded for future reference if the deck is revised.
- **Cards 81 (superinfection immunity), 82 (prion α-helix → β-sheet), 83 (viroid RNA silencing), 39 (parenchyma/stroma), 61 (episome)**: all retained. Each is established MCAT-level content found in current biology/microbiology textbooks but not directly in the OpenStax-only corpus. SME (post-bac coursework) confirms current usage and accuracy.
- Tier 3 cards (kinesin/dynein, cytochrome c, porins, catalase, vimentin/desmin): shipped as-noted.
