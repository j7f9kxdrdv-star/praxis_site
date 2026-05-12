-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: The Cell — Architecture, Microbiology, and Viruses
-- Section: biology · Topic: Molecular and Cellular Biology
--
-- Coverage: cell theory; eukaryote vs. prokaryote; the nucleus
-- (envelope, pores, chromatin, nucleolus); mitochondria
-- (structure, function, endosymbiotic origin, apoptosis);
-- the endomembrane system (ER, Golgi, lysosomes, peroxisomes,
-- endosomes, vesicle trafficking); the cytoskeleton
-- (microfilaments, microtubules, intermediate filaments,
-- centrioles, kinetochore, cilia/flagella); eukaryotic tissues
-- (epithelial classification, connective tissue, ECM,
-- parenchyma vs. stroma); prokaryotic architecture (cell wall,
-- envelope, Gram +/-, flagella, chemotaxis); the three domains
-- of life and Archaeal hybrid features; bacterial shapes;
-- prokaryotic metabolism (aerobic / anaerobic; four oxygen-
-- tolerance categories); binary fission; bacterial genetic
-- exchange (plasmids, episomes, F factor, Hfr cells,
-- transformation, conjugation, transduction, transposons,
-- virulence factors); bacterial growth curve; viral structure
-- (capsid, envelope, bacteriophage anatomy); viral genome
-- strategies ((+)-sense, (-)-sense, retroviruses); viral life
-- cycle (attachment, entry, release — lysis vs. extrusion,
-- lytic vs. lysogenic); subviral pathogens (prions, viroids);
-- and a small connections section (ubiquitination, the ETC
-- terminal electron acceptor rule, cDNA generation).
--
-- All cards are CLOZE-format. Cards are ORIGINAL Praxist Prep
-- content — written from the underlying biology and re-sourced
-- from the reference textbooks listed in the companion
-- verification.md file; no prose is lifted from any third-
-- party source.
--
-- Subtopic ordering follows the AAMC content outline
-- (Foundations 1A, 2A–2C, plus microbiology subsections),
-- NOT the source .docx's chapter ordering.
--
-- Idempotent: re-running deletes the prior version of this
-- deck and re-seeds. User review history attached to those
-- cards (flashcard_user_state, flashcard_reviews) cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  -- Wipe any prior copy of this deck (across any historical titles)
  DELETE FROM flashcard_decks
   WHERE section = 'biology'
     AND title   IN (
           'The Cell',
           'The Cell — Architecture, Microbiology, and Viruses',
           'Cell Architecture, Microbes & Viruses',
           'Chapter 1 — The Cell',
           'Chapter 1 — Cell Architecture, Microbes & Viruses'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'biology',
    'Molecular and Cellular Biology',
    'the_cell',
    'The Cell',
    'Cell theory, eukaryotic organelles and the endomembrane system, the cytoskeleton, eukaryotic tissues, prokaryotic architecture and the three domains of life, bacterial metabolism and genetic exchange, viral structure and life cycles, and subviral pathogens (prions and viroids).',
    1
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. Cell Theory ───────────────────────────────────────
  (deck,  0, 'cloze',
   'The classical cell theory rests on four claims: {{c1::all living things are made of cells}}, {{c1::the cell is the smallest living unit of life}}, {{c1::every cell descends from a pre-existing cell}}, and {{c1::DNA carries the hereditary information passed from one generation of cells to the next}}.', 1),

  -- ── 2. Eukaryote vs Prokaryote — Core Distinction ────────
  (deck,  1, 'cloze',
   'The defining cytological split between {{c1::prokaryotes}} and {{c1::eukaryotes}} is the absence (vs. presence) of a {{c2::membrane-bound nucleus}}; only eukaryotes also wrap their organelles in their own membranes.', 2),

  (deck,  2, 'cloze',
   'Prokaryotic cytoplasmic ribosomes sediment at {{c1::70S}} ({{c2::30S}} + {{c2::50S}} subunits), whereas eukaryotic cytoplasmic ribosomes are larger — {{c1::80S}} ({{c2::40S}} + {{c2::60S}}) — a difference exploited by antibiotics that target the bacterial size class without harming the host.', 2),

  (deck,  3, 'cloze',
   'In {{c1::prokaryotes}}, transcription and translation occur simultaneously in the cytoplasm — ribosomes begin reading an mRNA while RNA polymerase is still synthesizing it. In {{c2::eukaryotes}}, the nuclear envelope physically separates transcription (in the nucleus) from translation (in the cytoplasm), allowing post-transcriptional processing in between.', 2),

  -- ── 3. The Nucleus ───────────────────────────────────────
  (deck,  4, 'cloze',
   'The {{c1::nucleus}} stores the cell''s genome and acts as its command center: transcription happens here, and the resulting mRNA is exported to the cytoplasm for translation only after processing.', 1),

  (deck,  5, 'cloze',
   'The nucleus is wrapped in a {{c1::double membrane}} called the nuclear envelope, perforated by {{c2::nuclear pores}} that gate the bidirectional movement of RNA, proteins, and small molecules between nucleoplasm and cytoplasm.', 2),

  (deck,  6, 'cloze',
   'Within the nucleus, linear DNA winds around organizing proteins called {{c1::histones}} to form {{c2::chromatin}}, which condenses further into the recognizable {{c2::chromosomes}} visible during mitosis.', 2),

  (deck,  7, 'cloze',
   'The dark, dense sub-region of the nucleus where {{c2::ribosomal RNA}} is transcribed and pre-assembled into ribosomal subunits is the {{c1::nucleolus}}.', 2),

  -- ── 4. Mitochondria ──────────────────────────────────────
  (deck,  8, 'cloze',
   'Mitochondria generate ATP through aerobic respiration and house the electron transport chain on folds of the inner membrane called {{c1::cristae}}, which expand the surface area available for ETC complexes the cell can deploy.', 1),

  (deck,  9, 'cloze',
   'The mitochondrion has two membrane-bound compartments: the {{c1::intermembrane space}} (between outer and inner membranes), where the ETC pumps protons to build a gradient, and the {{c1::matrix}} (enclosed by the inner membrane), where the citric acid cycle and pyruvate oxidation run.', 1),

  (deck, 10, 'cloze',
   'Mitochondria carry their own {{c1::circular DNA}} and {{c1::70S ribosomes}} and divide by binary fission — fingerprints of an ancestral bacterium engulfed by a proto-eukaryotic host and the basis of the {{c2::endosymbiotic theory}}.', 2),

  (deck, 11, 'cloze',
   'Mitochondria also gate programmed cell death: when outer-membrane permeability rises, {{c1::cytochrome c}} leaks into the cytosol and triggers the caspase cascade of {{c2::apoptosis}}.', 2),

  -- ── 5. The Endomembrane System ───────────────────────────
  (deck, 12, 'cloze',
   'The {{c1::endomembrane system}} is the network of organelles whose membranes are physically or functionally continuous — the nuclear envelope, endoplasmic reticulum, Golgi apparatus, lysosomes, endosomes, and the vesicles trafficking between them.', 1),

  (deck, 13, 'cloze',
   'Ribosomes studded across the cytosolic face of the {{c1::rough endoplasmic reticulum}} translate proteins destined for {{c2::secretion}}, {{c2::membrane insertion}}, or delivery to other endomembrane organelles directly into the ER lumen.', 2),

  (deck, 14, 'cloze',
   'Lacking ribosomes, the {{c1::smooth endoplasmic reticulum}} specializes in {{c2::lipid and steroid synthesis}} and the {{c2::detoxification of drugs and metabolic byproducts}} — both reactions that exploit its extensive membrane surface.', 2),

  (deck, 15, 'cloze',
   'The {{c1::Golgi apparatus}} sits downstream of the ER and modifies arriving proteins by adding {{c2::carbohydrates}}, {{c2::phosphates}}, or {{c2::signal sequences}} before sorting them into vesicles bound for a specific destination.', 2),

  (deck, 16, 'cloze',
   'Proteins move through the endomembrane system in a directed flow: synthesized in the {{c1::rough ER}}, modified in the {{c1::Golgi}}, then packaged into {{c1::vesicles}} that bud off and fuse with the target compartment or the plasma membrane.', 1),

  (deck, 17, 'cloze',
   '{{c1::Lysosomes}} are acidic, hydrolytic-enzyme-filled vesicles that digest material delivered by {{c2::endocytosis}}, worn-out organelles cleared by {{c2::autophagy}}, and — under certain conditions — the cell itself ({{c2::autolysis}}).', 2),

  (deck, 18, 'cloze',
   '{{c1::Peroxisomes}} use hydrogen-peroxide-generating reactions to break down {{c2::very long-chain fatty acids}} via β-oxidation and also contribute to phospholipid synthesis and the pentose phosphate pathway.', 2),

  (deck, 19, 'cloze',
   '{{c1::Endosomes}} are membrane-bound sorting compartments that receive cargo from endocytic vesicles, then decide whether it gets recycled back to the surface, returned to the Golgi, or routed to lysosomes for degradation.', 1),

  -- ── 6. The Cytoskeleton ──────────────────────────────────
  (deck, 20, 'cloze',
   'The cytoskeleton is built from three filament classes, distinguished by diameter and protein subunit: thin {{c1::microfilaments}} of {{c2::actin}}, hollow {{c1::microtubules}} of {{c2::tubulin}}, and rope-like {{c1::intermediate filaments}} of tissue-specific proteins such as keratin, vimentin, desmin, and the lamins.', 2),

  (deck, 21, 'cloze',
   '{{c1::Microfilaments}} of polymerized actin resist compression, anchor membrane proteins, and — by interacting with {{c2::myosin}} — generate the force for muscle contraction, intracellular movement, and the cleavage furrow that pinches dividing cells apart.', 2),

  (deck, 22, 'cloze',
   'During cytokinesis in animal cells, a ring of {{c1::actin microfilaments}} bound to {{c1::myosin}} contracts at the cell equator, generating the {{c2::cleavage furrow}} that separates the two daughter cells.', 2),

  (deck, 23, 'cloze',
   'Microtubules serve as tracks for two motor proteins moving cargo in opposite directions: {{c1::kinesin}} walks toward the plus end (typically anterograde, toward the cell periphery), while {{c1::dynein}} walks toward the minus end (retrograde, toward the cell center).', 1),

  (deck, 24, 'cloze',
   'In eukaryotic cells, both {{c1::cilia}} and {{c1::flagella}} share the same internal architecture — a {{c2::9+2}} arrangement of microtubules: nine outer doublets surrounding two central singlets.', 2),

  (deck, 25, 'cloze',
   'Within a eukaryotic cell, {{c1::cilia}} sweep extracellular material across a stationary cell surface, while {{c1::flagella}} propel the cell itself through its environment — the same architecture deployed for two distinct jobs.', 1),

  (deck, 26, 'cloze',
   '{{c1::Centrioles}} sit at the heart of the centrosome (the cell''s primary microtubule-organizing center) and are themselves built from {{c2::nine triplets}} of microtubules ringing a hollow core.', 2),

  (deck, 27, 'cloze',
   'The {{c1::kinetochore}} is a protein complex assembled on the {{c2::centromere}} of each chromosome during mitosis; it serves as the attachment point for spindle microtubules that pull sister chromatids apart at anaphase.', 2),

  -- ── 7. Eukaryotic Tissues ────────────────────────────────
  (deck, 28, 'cloze',
   '{{c1::Epithelial tissue}} lines body surfaces and cavities, forms the parenchyma of most glands, and is anchored to the underlying connective tissue by a thin specialized matrix called the {{c2::basement membrane}}.', 2),

  (deck, 29, 'cloze',
   'Epithelia are classified by layer count: {{c1::simple}} epithelium is one cell thick (built for diffusion or absorption), {{c1::stratified}} epithelium stacks multiple layers (built for protection), and {{c1::pseudostratified}} epithelium looks layered but is actually a single layer of cells of varying heights.', 1),

  (deck, 30, 'cloze',
   'Three epithelial cell shapes appear repeatedly on the MCAT: {{c1::squamous}} (flat and scale-like), {{c1::cuboidal}} (cube-shaped, as wide as it is tall), and {{c1::columnar}} (tall and rectangular).', 1),

  (deck, 31, 'cloze',
   'Where epithelium does an organ''s specialized work, {{c1::connective tissue}} supplies its structural framework — the {{c2::stroma}} of extracellular matrix, vessels, and nerves that anchors the functional {{c2::parenchyma}} cells in place.', 2),

  (deck, 32, 'cloze',
   'The {{c1::extracellular matrix (ECM)}} is the secreted three-dimensional network surrounding and supporting tissue cells; its dominant macromolecules are {{c2::collagen}} (tensile strength), {{c2::elastin}} (elastic recoil), and {{c2::proteoglycans}} (hydration and resistance to compression).', 2),

  (deck, 33, 'cloze',
   'Standard MCAT tissue classifications worth memorizing: {{c1::fibroblasts}}, {{c1::osteoblasts}}, and {{c1::chondroblasts}} are connective tissue cells; {{c2::endothelial cells}} lining blood vessels and the {{c2::α-cells of pancreatic islets}} are epithelial in origin despite their internal location.', 2),

  -- ── 8. Prokaryotic Cell Architecture ─────────────────────
  (deck, 34, 'cloze',
   'In prokaryotes, the {{c1::cell wall}} and the underlying {{c1::cell membrane}} together form the {{c2::envelope}} that defines what the cell can absorb, secrete, and resist osmotically.', 2),

  (deck, 35, 'cloze',
   'Because prokaryotes lack mitochondria, the {{c1::cell (plasma) membrane}} itself hosts the {{c2::electron transport chain}} and is the site of ATP synthesis by oxidative phosphorylation in aerobic bacteria.', 2),

  (deck, 36, 'cloze',
   'A {{c1::Gram-positive}} bacterium has a thick outer layer of {{c2::peptidoglycan}} laced with {{c2::lipoteichoic acid}}; it absorbs crystal violet and appears deep purple under the Gram stain.', 2),

  (deck, 37, 'cloze',
   'A {{c1::Gram-negative}} bacterium has a thin peptidoglycan layer between an inner and an outer membrane, separated by the {{c2::periplasmic space}}; it fails to retain crystal violet and stains pink with the safranin counterstain.', 2),

  (deck, 38, 'cloze',
   'The outer membrane of {{c1::Gram-negative}} bacteria displays {{c2::lipopolysaccharide (LPS)}} on its surface — a glycolipid recognized by the host immune system as endotoxin and a major driver of septic shock.', 2),

  (deck, 39, 'cloze',
   'A prokaryotic flagellum is built from {{c1::flagellin}} and has three parts: a {{c2::basal body}} (the rotary motor anchored in the membrane), a {{c2::hook}} (universal joint), and a {{c2::filament}} (helical tail); together they let the cell swim toward attractants and away from repellents — a response known as {{c3::chemotaxis}}.', 3),

  -- ── 9. Prokaryotic Domains ───────────────────────────────
  (deck, 40, 'cloze',
   'All life is currently sorted into three domains: {{c1::Bacteria}} and {{c1::Archaea}} (both prokaryotic) and {{c1::Eukarya}} (everything with a true nucleus).', 1),

  (deck, 41, 'cloze',
   '{{c1::Archaea}} resemble {{c2::Bacteria}} morphologically — single circular chromosome, no nucleus, divide by binary fission — but resemble {{c2::Eukarya}} biochemically: their DNA associates with histones, their RNA polymerases are similar, and they initiate translation with unmodified methionine rather than the formylmethionine used by Bacteria.', 2),

  (deck, 42, 'cloze',
   '{{c1::Extremophiles}} — organisms that thrive in extreme temperature, salinity, pH, or anoxic environments — are disproportionately drawn from the domain {{c2::Archaea}}.', 2),

  -- ── 10. Bacterial Shapes ─────────────────────────────────
  (deck, 43, 'cloze',
   'Bacteria are sorted by gross morphology into three classic shapes: {{c1::cocci}} (spherical), {{c1::bacilli}} (rod-shaped), and {{c1::spirilla}} (helical or spiral).', 1),

  -- ── 11. Prokaryotic Metabolism ───────────────────────────
  (deck, 44, 'cloze',
   '{{c1::Aerobic}} metabolism uses oxygen as the terminal electron acceptor and yields a large ATP harvest via oxidative phosphorylation; {{c2::anaerobic}} metabolism either uses an alternative inorganic acceptor (sulfate, nitrate) or skips oxidative phosphorylation entirely in favor of fermentation.', 2),

  (deck, 45, 'cloze',
   'Bacteria that require oxygen to live are {{c1::obligate aerobes}}; those killed by oxygen are {{c1::obligate anaerobes}}; those that use oxygen when present and switch to fermentation when it is not are {{c1::facultative anaerobes}}; those that ignore oxygen entirely (always fermenting but tolerant of its presence) are {{c1::aerotolerant anaerobes}}.', 1),

  (deck, 46, 'cloze',
   'Bacteria living on or in a host can be {{c1::mutualistic symbionts}} (both partners benefit), {{c1::commensal}} (one benefits, the other is unaffected), or {{c1::pathogenic}} (the bacterium benefits at the host''s expense).', 1),

  -- ── 12. Prokaryotic Reproduction ─────────────────────────
  (deck, 47, 'cloze',
   'Prokaryotes reproduce by {{c1::binary fission}}: the circular chromosome attaches to the cell membrane and replicates, the cell elongates, and an inward pinch of the plasma membrane and cell wall splits it into two genetically identical daughter cells.', 1),

  -- ── 13. Bacterial Genetic Exchange ───────────────────────
  (deck, 48, 'cloze',
   'A {{c1::plasmid}} is a small, circular, double-stranded DNA molecule that exists separately from the bacterial chromosome and carries genes dispensable for survival but often advantageous, such as {{c2::antibiotic resistance}} or {{c2::virulence factors}}.', 2),

  (deck, 49, 'cloze',
   '{{c1::Episomes}} are a subset of plasmids capable of integrating directly into the bacterial chromosome and replicating along with it.', 1),

  (deck, 50, 'cloze',
   'The {{c1::F (fertility) factor}} is a plasmid encoding the sex pilus required for conjugation; cells carrying it are designated {{c2::F+}} (donors) and cells lacking it are {{c2::F-}} (recipients).', 2),

  (deck, 51, 'cloze',
   'When the F factor integrates into the bacterial chromosome, the resulting {{c1::Hfr (high-frequency recombination)}} cell can transfer chromosomal genes during conjugation — not just the plasmid itself.', 1),

  (deck, 52, 'cloze',
   'In {{c1::transformation}}, a bacterium takes up free DNA from its environment — typically released by the lysis of other cells — and integrates fragments of it into its own genome.', 1),

  (deck, 53, 'cloze',
   'In {{c1::conjugation}}, a donor (F+) bacterium extends a {{c2::sex pilus}} to make physical contact with a recipient (F-) cell, then transfers DNA unidirectionally through the resulting conjugation bridge.', 2),

  (deck, 54, 'cloze',
   'In {{c1::transduction}}, a {{c2::bacteriophage}} accidentally packages a fragment of host DNA during assembly and injects that fragment into a new bacterium during the next infection — the only mode of bacterial genetic exchange that requires a viral vector.', 2),

  (deck, 55, 'cloze',
   '{{c1::Transposons}} are mobile genetic elements that excise from one location in the genome and insert into another; when they land inside a coding region, they can disrupt the gene they hit.', 1),

  (deck, 56, 'cloze',
   '{{c1::Virulence factors}} are traits — often plasmid-encoded — that raise a bacterium''s pathogenicity: toxin production, surface attachment proteins, and mechanisms for evading host immune defenses.', 1),

  -- ── 14. Bacterial Growth Curve ───────────────────────────
  (deck, 57, 'cloze',
   'In batch culture, a bacterial population moves through four phases: {{c1::lag phase}} (cells adapt to the medium without dividing), {{c1::exponential / log phase}} (rapid doubling), {{c1::stationary phase}} (division balanced by death as nutrients run low), and {{c1::death phase}} (population collapses).', 1),

  -- ── 15. Viral Structure & Classification ─────────────────
  (deck, 58, 'cloze',
   'A virion is, at minimum, a nucleic-acid genome packaged inside a protein shell called the {{c1::capsid}}; some viruses are additionally wrapped in an {{c2::envelope}} of host-derived phospholipid studded with viral glycoproteins — a layer highly sensitive to heat, detergents, and drying.', 2),

  (deck, 59, 'cloze',
   'Viruses are {{c1::obligate intracellular parasites}}: because they lack ribosomes and the metabolic machinery for protein synthesis, they can replicate only by hijacking the apparatus of a {{c2::host cell}}.', 2),

  (deck, 60, 'cloze',
   'A typical {{c1::bacteriophage}} has a polyhedral capsid (holding the genome), a contractile {{c2::tail sheath}} that injects the genome into the host like a syringe, and {{c2::tail fibers}} that recognize and bind specific receptors on the bacterial surface.', 2),

  -- ── 16. Viral Genome Strategies ──────────────────────────
  (deck, 61, 'cloze',
   'A {{c1::positive-sense}} (+-strand) RNA genome can serve directly as mRNA — host ribosomes translate it the moment it enters the cytoplasm — so the virion does not need to package its own RNA polymerase.', 1),

  (deck, 62, 'cloze',
   'A {{c1::negative-sense}} (−-strand) RNA genome cannot be translated directly; the virion must carry its own {{c2::RNA-dependent RNA polymerase}} to first transcribe a complementary positive-sense strand that ribosomes can read.', 2),

  (deck, 63, 'cloze',
   '{{c1::Retroviruses}} (e.g., HIV) are enveloped single-stranded RNA viruses that carry {{c2::reverse transcriptase}} in the virion, allowing them to convert their RNA genome into DNA that integrates into the host chromosome as a {{c3::provirus}}.', 3),

  -- ── 17. Viral Life Cycle ─────────────────────────────────
  (deck, 64, 'cloze',
   'A virus can only infect cell types that display the {{c1::specific surface receptors}} its attachment proteins recognize — which is why viral tropism (the range of cells a virus can enter) is so narrow and why a missing receptor renders a cell effectively invisible to the virus.', 1),

  (deck, 65, 'cloze',
   'Enveloped viruses can enter the host by {{c1::fusing their envelope with the plasma membrane}}, releasing the capsid into the cytoplasm; non-enveloped viruses are typically taken up by {{c1::receptor-mediated endocytosis}}.', 1),

  (deck, 66, 'cloze',
   'Once viral progeny have assembled, the cell may rupture and spill them all at once — {{c1::lysis}} — or new virions may continuously bud off the plasma membrane while the host stays alive, a non-lytic strategy called {{c2::extrusion}} (the productive cycle).', 2),

  (deck, 67, 'cloze',
   'In the {{c1::lytic}} cycle a phage hijacks host machinery, assembles new virions, and bursts the cell open to release them; in the {{c2::lysogenic}} cycle the phage instead integrates its genome into the host chromosome as a {{c2::prophage}} that replicates passively until environmental stress triggers a switch back to the lytic cycle.', 2),

  -- ── 18. Subviral Pathogens ───────────────────────────────
  (deck, 68, 'cloze',
   '{{c1::Prions}} are infectious proteins — not living organisms — that cause disease by inducing a normal cellular protein to refold from its native {{c2::α-helical}} conformation into a misfolded {{c2::β-pleated sheet}} form that aggregates and resists degradation.', 2),

  (deck, 69, 'cloze',
   '{{c1::Viroids}} are tiny, circular, single-stranded RNA pathogens that infect plants; they carry no protein coat and cause disease by base-pairing with host RNA sequences to silence or otherwise interfere with host gene expression.', 1),

  -- ── 19. Connections to Other Chapters ────────────────────
  (deck, 70, 'cloze',
   '{{c1::Ubiquitination}} — the covalent attachment of one or more ubiquitin molecules to a target protein — most commonly tags that protein for destruction by the {{c2::proteasome}}, the cell''s regulated protein-degradation machine.', 2),

  (deck, 71, 'cloze',
   'The {{c1::electron transport chain}} runs only when a terminal {{c2::electron acceptor}} is available: oxygen in aerobic respiration, or alternative inorganic molecules (sulfate, nitrate) in some anaerobic bacteria.', 2),

  (deck, 72, 'cloze',
   '{{c1::cDNA}} (complementary DNA) is synthesized in vitro from a mature {{c2::mRNA}} template using the enzyme {{c2::reverse transcriptase}} — a technique that lets molecular biologists clone the protein-coding sequence of a gene without its introns.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
