-- ============================================================
-- Praxis Prep — Flashcard Seed
-- Deck: Cell Architecture, Microbes & Viruses
-- Section: biology · Topic: Molecular and Cellular Biology
--
-- Coverage: cell theory, eukaryote vs prokaryote, organelles,
-- cytoskeleton, tissues, prokaryotic structure & genetics,
-- viruses, prions, viroids.
--
-- All cards are CLOZE-format. Cards are original Praxist Prep
-- content (reworded from source material).
--
-- Idempotent: re-running deletes the prior version of this
-- deck and re-seeds. User review history attached to those
-- cards (flashcard_user_state, flashcard_reviews) cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  -- Wipe any prior copy of this deck
  -- (also matches the older Kaplan-styled name in case it was previously seeded)
  DELETE FROM flashcard_decks
   WHERE section = 'biology'
     AND topic   = 'Molecular and Cellular Biology'
     AND title   IN ('Cell Architecture, Microbes & Viruses', 'Chapter 1 — The Cell');

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'biology',
    'Molecular and Cellular Biology',
    'cells_and_microbes',
    'Cell Architecture, Microbes & Viruses',
    'Cell theory, eukaryotic and prokaryotic structure, organelles, cytoskeleton, tissue types, bacterial genetics, viral life cycles, prions, and viroids.',
    1
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── Cell Theory ─────────────────────────────────────────────
  (deck,  0, 'cloze',
   'Cell theory rests on four core principles: every living organism is built from {{c1::cells}}; the cell is the smallest {{c2::functional}} unit of life; new cells arise only from {{c3::pre-existing cells}}; and cells store hereditary information as {{c4::DNA}} that is passed from parent to daughter cell.', 4),

  (deck,  1, 'cloze',
   'A modern addendum to cell theory excludes {{c1::viruses}} from the definition of life because they cannot reproduce without a host cell.', 1),

  -- ── Eukaryote vs Prokaryote ────────────────────────────────
  (deck,  2, 'cloze',
   'The presence of {{c1::membrane-bound organelles}} (including a true nucleus) is the defining structural feature that separates {{c2::eukaryotic}} cells from prokaryotic cells.', 2),

  (deck,  3, 'cloze',
   'Eukaryotic ribosomes sediment at {{c1::80S}}, whereas prokaryotic ribosomes sediment at {{c2::70S}} — a difference that many antibiotics exploit.', 2),

  (deck,  4, 'cloze',
   'Because prokaryotes lack a nucleus, {{c1::transcription}} and {{c1::translation}} happen at the same time in the cytoplasm. In eukaryotes, transcription is confined to the {{c2::nucleus}} while translation occurs in the {{c3::cytoplasm}}.', 3),

  (deck,  5, 'cloze',
   '{{c1::Histones}} are DNA-packaging proteins found in eukaryotic nuclei and in {{c2::archaeal}} cells, but they are absent from {{c3::bacteria}}.', 3),

  (deck,  6, 'cloze',
   'The {{c1::Krebs cycle}} and the {{c2::electron transport chain}} only run when a final electron acceptor is available — typically {{c3::oxygen}} (aerobic respiration) or an inorganic ion such as sulfate or nitrate (anaerobic respiration).', 3),

  -- ── Cytosol & Nucleus ──────────────────────────────────────
  (deck,  7, 'cloze',
   'The {{c1::cytosol}} is the aqueous portion of the cytoplasm in which organelles are suspended; it hosts many metabolic reactions including {{c2::glycolysis}}.', 2),

  (deck,  8, 'cloze',
   'DNA is stored inside the {{c1::nucleus}}, which functions as the control center responsible for {{c2::transcription}} and overall regulation of gene expression.', 2),

  (deck,  9, 'cloze',
   'The {{c1::nuclear envelope}} is a double membrane perforated by {{c2::nuclear pores}} that selectively regulate exchange between nucleoplasm and cytoplasm.', 2),

  (deck, 10, 'cloze',
   'Inside the nucleus, the {{c1::nucleolus}} is the dense subregion where {{c2::ribosomal RNA (rRNA)}} is transcribed and ribosomal subunits are partially assembled.', 2),

  (deck, 11, 'cloze',
   'DNA in the nucleus wraps around histone proteins to form {{c1::chromatin}}, which condenses further during cell division into {{c2::chromosomes}}.', 2),

  -- ── Mitochondria ────────────────────────────────────────────
  (deck, 12, 'cloze',
   'The chief role of the {{c1::mitochondrion}} is to generate {{c2::ATP}} through oxidative phosphorylation, and it can also initiate {{c3::apoptosis}} by releasing cytochrome c.', 3),

  (deck, 13, 'cloze',
   'Mitochondria carry their own circular genome and divide independently of the cell by {{c1::binary fission}} — evidence supporting the {{c2::endosymbiotic theory}}.', 2),

  (deck, 14, 'cloze',
   'The {{c1::outer mitochondrial membrane}} is highly permeable thanks to {{c2::porins}}, while the {{c3::inner membrane}} is folded into {{c4::cristae}} and is the site of the electron transport chain.', 4),

  (deck, 15, 'cloze',
   'The space between the two mitochondrial membranes is called the {{c1::intermembrane space}} and serves as the reservoir for the {{c2::proton gradient}} that drives ATP synthase.', 2),

  (deck, 16, 'cloze',
   'The {{c1::mitochondrial matrix}} is the innermost compartment that houses the enzymes of the {{c2::Krebs (citric acid) cycle}} and the cell''s mitochondrial DNA.', 2),

  (deck, 17, 'cloze',
   'Because mitochondrial DNA is inherited only from the mother, this pattern is referred to as {{c1::cytoplasmic (extranuclear) inheritance}}.', 1),

  -- ── Lysosomes & Endosomes ──────────────────────────────────
  (deck, 18, 'cloze',
   'A {{c1::lysosome}} is filled with hydrolytic enzymes that work optimally at {{c2::acidic}} pH, allowing it to digest worn-out organelles and material brought in by endocytosis.', 2),

  (deck, 19, 'cloze',
   'When a lysosome ruptures and releases its enzymes into the cytosol, the resulting self-digestion is called {{c1::autolysis}}.', 1),

  (deck, 20, 'cloze',
   'Material taken up by endocytosis is initially packaged into an {{c1::endosome}}, which can then mature and fuse with a {{c2::lysosome}} for degradation.', 2),

  -- ── Endoplasmic Reticulum ──────────────────────────────────
  (deck, 21, 'cloze',
   'The studded appearance of the {{c1::rough endoplasmic reticulum}} comes from bound {{c2::ribosomes}}; its main job is synthesizing proteins destined for {{c3::secretion}} or insertion into membranes.', 3),

  (deck, 22, 'cloze',
   'Lacking ribosomes, the {{c1::smooth endoplasmic reticulum}} specializes in {{c2::lipid}} synthesis and the {{c3::detoxification}} of drugs and metabolic byproducts.', 3),

  (deck, 23, 'cloze',
   'Specialized roles of the smooth ER include {{c1::steroid hormone}} synthesis, {{c2::glycogen}} breakdown in hepatocytes, and storage of {{c3::calcium ions}} in muscle (the sarcoplasmic reticulum).', 3),

  -- ── Golgi Apparatus ────────────────────────────────────────
  (deck, 24, 'cloze',
   'After leaving the ER, proteins enter the {{c1::Golgi apparatus}}, where they are {{c2::modified}}, sorted, and packaged into vesicles for delivery.', 2),

  (deck, 25, 'cloze',
   'Vesicles budded from the {{c1::trans face}} of the Golgi can become {{c2::secretory vesicles}}, lysosomes, or vesicles destined for the plasma membrane.', 2),

  -- ── Peroxisomes ─────────────────────────────────────────────
  (deck, 26, 'cloze',
   '{{c1::Peroxisomes}} use molecular oxygen to break down {{c2::very-long-chain fatty acids}} via beta-oxidation, generating {{c3::hydrogen peroxide}} as a byproduct.', 3),

  (deck, 27, 'cloze',
   'The enzyme {{c1::catalase}} inside peroxisomes neutralizes the toxic hydrogen peroxide produced during fatty acid breakdown.', 1),

  (deck, 28, 'cloze',
   'Beyond fatty acid catabolism, peroxisomes also contribute to {{c1::lipid}} biosynthesis and to the {{c2::pentose phosphate pathway}}.', 2),

  -- ── Cytoskeleton: Microfilaments ───────────────────────────
  (deck, 29, 'cloze',
   '{{c1::Microfilaments}} are built from polymerized {{c2::actin}} monomers and are responsible for cell shape changes and muscle contraction (in concert with myosin).', 2),

  (deck, 30, 'cloze',
   'During cytokinesis, a contractile ring of {{c1::actin}} and {{c2::myosin}} pinches the cell in two, forming the {{c3::cleavage furrow}}.', 3),

  -- ── Cytoskeleton: Microtubules ─────────────────────────────
  (deck, 31, 'cloze',
   '{{c1::Microtubules}} are hollow tubes assembled from {{c2::tubulin}} dimers; they form the mitotic spindle and serve as tracks for organelle transport.', 2),

  (deck, 32, 'cloze',
   'Two motor proteins walk along microtubules: {{c1::kinesin}} generally carries cargo toward the {{c2::plus (peripheral)}} end, while {{c3::dynein}} hauls cargo toward the {{c4::minus (centrosomal)}} end.', 4),

  (deck, 33, 'cloze',
   'Eukaryotic cilia and flagella both display the characteristic {{c1::9+2}} arrangement: nine microtubule doublets surrounding two central microtubules.', 1),

  -- ── Cytoskeleton: Centrioles & Centrosome ──────────────────
  (deck, 34, 'cloze',
   'A {{c1::centriole}} is a barrel-shaped structure made from {{c2::nine triplets}} of microtubules around a hollow core.', 2),

  (deck, 35, 'cloze',
   'The {{c1::centrosome}} acts as the principal {{c2::microtubule organizing center (MTOC)}} of the cell and contains a pair of perpendicular centrioles.', 2),

  (deck, 36, 'cloze',
   'During mitosis, spindle microtubules attach to chromosomes at a specialized protein complex on the centromere called the {{c1::kinetochore}}.', 1),

  -- ── Cytoskeleton: Intermediate filaments ───────────────────
  (deck, 37, 'cloze',
   '{{c1::Intermediate filaments}} provide tensile strength and anchor organelles; common examples include {{c2::keratin}}, {{c2::desmin}}, {{c2::vimentin}}, and the nuclear-lining {{c2::lamins}}.', 2),

  -- ── Tissue Formation: Epithelial ───────────────────────────
  (deck, 38, 'cloze',
   '{{c1::Epithelial tissue}} covers body surfaces and lines cavities, and rests on a fibrous {{c2::basement membrane}} that anchors it to underlying connective tissue.', 2),

  (deck, 39, 'cloze',
   'In organ anatomy, the functional cells are called the {{c1::parenchyma}}, while the structural support tissue is termed the {{c2::stroma}}.', 2),

  (deck, 40, 'cloze',
   'Epithelia are classified by layering: {{c1::simple}} (one layer), {{c2::stratified}} (multiple layers), and {{c3::pseudostratified}} (one layer that appears multilayered because nuclei sit at different heights).', 3),

  (deck, 41, 'cloze',
   'Epithelial cells are also classified by shape: {{c1::squamous}} (flat, scale-like), {{c2::cuboidal}} (cube-shaped), and {{c3::columnar}} (tall, column-shaped).', 3),

  -- ── Tissue Formation: Connective ───────────────────────────
  (deck, 42, 'cloze',
   '{{c1::Connective tissue}} supports the body and is characterized by sparse cells embedded in an abundant {{c2::extracellular matrix (ECM)}}, which it produces and secretes.', 2),

  (deck, 43, 'cloze',
   'Cell-type sourcing rule of thumb: fibroblasts, osteoblasts, and chondroblasts are all {{c1::connective}} tissue cells, while endothelial cells lining blood vessels and pancreatic α-cells are {{c2::epithelial}} in origin.', 2),

  -- ── Prokaryotes: Domain Archaea ────────────────────────────
  (deck, 44, 'cloze',
   '{{c1::Archaea}} are single-celled prokaryotes that often inhabit hostile environments — these specialists are collectively called {{c2::extremophiles}}.', 2),

  (deck, 45, 'cloze',
   'Archaea share with {{c1::bacteria}} a single circular chromosome and a lack of membrane-bound organelles, but resemble {{c2::eukaryotes}} in starting translation with {{c3::methionine}} and packaging DNA with histone-like proteins.', 3),

  -- ── Bacterial Shapes & Lifestyle ───────────────────────────
  (deck, 46, 'cloze',
   'Bacteria are classified by shape into {{c1::cocci}} (spherical), {{c2::bacilli}} (rod-shaped), and {{c3::spirilli}} (spiral).', 3),

  (deck, 47, 'cloze',
   'Bacteria that live with a host without harming it (and often help) are called {{c1::mutualistic symbiotes}}, whereas those that cause disease are {{c2::pathogens}} or {{c3::parasites}}.', 3),

  -- ── Oxygen Tolerance ───────────────────────────────────────
  (deck, 48, 'cloze',
   '{{c1::Obligate aerobes}} cannot survive without {{c2::oxygen}} because they rely on aerobic metabolism to generate ATP.', 2),

  (deck, 49, 'cloze',
   '{{c1::Obligate anaerobes}} are {{c2::poisoned}} by oxygen and depend exclusively on {{c3::anaerobic metabolism}}.', 3),

  (deck, 50, 'cloze',
   '{{c1::Facultative anaerobes}} are flexible: they prefer aerobic metabolism when oxygen is available but can switch to {{c2::anaerobic}} metabolism when it is not.', 2),

  (deck, 51, 'cloze',
   '{{c1::Aerotolerant anaerobes}} never use oxygen for metabolism but are not harmed by its presence.', 1),

  -- ── Prokaryotic Cell Structure & Gram Staining ─────────────
  (deck, 52, 'cloze',
   'A bacterial {{c1::cell wall}} is composed of cross-linked {{c2::peptidoglycan}} and lies external to the plasma membrane, providing rigidity and osmotic protection.', 2),

  (deck, 53, 'cloze',
   '{{c1::Gram-positive}} bacteria stain {{c2::purple}} because their thick peptidoglycan layer retains the crystal violet dye, and they additionally contain {{c3::lipoteichoic acid}}.', 3),

  (deck, 54, 'cloze',
   '{{c1::Gram-negative}} bacteria stain {{c2::pink}}; they have a thin peptidoglycan layer sandwiched between two membranes, and an outer membrane studded with {{c3::lipopolysaccharide (LPS)}}.', 3),

  (deck, 55, 'cloze',
   'The narrow gap between the inner and outer membranes of Gram-negative bacteria is called the {{c1::periplasmic space}} and houses degradative enzymes.', 1),

  (deck, 56, 'cloze',
   'The thick peptidoglycan and lipoteichoic acid of {{c1::Gram-positive}} bacteria make them more vulnerable to {{c2::penicillin}}, which blocks cell-wall synthesis.', 2),

  (deck, 57, 'cloze',
   'When released from a lysed Gram-negative bacterium, {{c1::lipopolysaccharide (LPS)}} acts as an endotoxin that triggers a strong {{c2::immune}} response and can cause septic shock.', 2),

  -- ── Prokaryotic Flagella ───────────────────────────────────
  (deck, 58, 'cloze',
   'A bacterial flagellum is constructed from the protein {{c1::flagellin}} and has three regions: the {{c2::filament}}, the {{c2::hook}}, and the membrane-embedded {{c2::basal body}}.', 2),

  (deck, 59, 'cloze',
   'Directed bacterial movement toward attractants or away from repellents in response to chemical gradients is called {{c1::chemotaxis}}.', 1),

  -- ── Plasmids & Genetic Exchange ────────────────────────────
  (deck, 60, 'cloze',
   '{{c1::Plasmids}} are small, circular pieces of DNA that replicate independently of the bacterial chromosome and frequently encode {{c2::antibiotic resistance}} or virulence factors.', 2),

  (deck, 61, 'cloze',
   'A plasmid that has integrated reversibly into the bacterial chromosome is called an {{c1::episome}}.', 1),

  (deck, 62, 'cloze',
   'Bacterial reproduction is asexual and proceeds by {{c1::binary fission}}, a simple division that produces two genetically identical daughter cells.', 1),

  (deck, 63, 'cloze',
   '{{c1::Transformation}} is the uptake of naked DNA from the environment, which can then be incorporated into the bacterial genome.', 1),

  (deck, 64, 'cloze',
   '{{c1::Conjugation}} transfers genetic material directly between bacteria through a {{c2::conjugation bridge (sex pilus)}}, typically driven by an {{c3::F (fertility) factor}} plasmid.', 3),

  (deck, 65, 'cloze',
   'In bacterial conjugation, the cell carrying the F factor is the {{c1::donor (F+, "male")}} cell, while the cell receiving DNA is the {{c2::recipient (F-, "female")}} cell.', 2),

  (deck, 66, 'cloze',
   'When the F factor integrates into the bacterial chromosome, the cell becomes an {{c1::Hfr (high frequency of recombination)}} cell, capable of transferring chromosomal genes during conjugation.', 1),

  (deck, 67, 'cloze',
   '{{c1::Transduction}} moves DNA between bacteria using a {{c2::bacteriophage}} as the delivery vector.', 2),

  (deck, 68, 'cloze',
   '{{c1::Transposons}} are mobile genetic elements that can jump between locations in a genome and are present in both prokaryotic and eukaryotic cells.', 1),

  -- ── Bacterial Growth Curve ─────────────────────────────────
  (deck, 69, 'cloze',
   'Bacterial growth in batch culture proceeds through four phases: the {{c1::lag phase}} (adaptation, little division), the {{c2::log/exponential phase}} (rapid doubling), the {{c3::stationary phase}} (growth balanced by death as nutrients run low), and the {{c4::death phase}} (population collapse).', 4),

  -- ── Viruses: Structure ─────────────────────────────────────
  (deck, 70, 'cloze',
   'A virus is essentially nucleic acid wrapped in a protein shell called the {{c1::capsid}}; many also acquire a lipid {{c2::envelope}} pinched off from a host membrane.', 2),

  (deck, 71, 'cloze',
   'A complete, infectious virus particle outside a host cell is termed a {{c1::virion}}.', 1),

  (deck, 72, 'cloze',
   'Viruses must reproduce inside a host because they lack their own ribosomes — a condition described as being {{c1::obligate intracellular parasites}}.', 1),

  (deck, 73, 'cloze',
   '{{c1::Bacteriophages}} are viruses that infect bacteria; their structure includes a head (capsid), a contractile {{c2::tail sheath}}, and {{c3::tail fibers}} that recognize the host cell wall.', 3),

  -- ── Viruses: Genomes & Replication ─────────────────────────
  (deck, 74, 'cloze',
   'A {{c1::positive-sense}} RNA virus carries a genome that can be read directly as mRNA by the host''s ribosomes, allowing immediate translation upon entry.', 1),

  (deck, 75, 'cloze',
   '{{c1::Negative-sense}} RNA viruses (e.g., influenza) must first be transcribed into positive-sense mRNA by their own packaged enzyme, {{c2::RNA-dependent RNA polymerase (RNA replicase)}}.', 2),

  (deck, 76, 'cloze',
   '{{c1::Retroviruses}} (such as HIV) carry single-stranded RNA along with the enzyme {{c2::reverse transcriptase}}, which converts that RNA into {{c3::DNA}} before integration into the host chromosome.', 3),

  (deck, 77, 'cloze',
   'In molecular biology, complementary DNA ({{c1::cDNA}}) is produced in the lab by treating an mRNA template with {{c2::reverse transcriptase}}.', 2),

  -- ── Viruses: Life Cycle ────────────────────────────────────
  (deck, 78, 'cloze',
   'Every viral life cycle moves through three broad stages: {{c1::infection}} (attachment and entry), {{c2::replication and assembly}} of progeny, and {{c3::release}} of new virions.', 3),

  (deck, 79, 'cloze',
   'In the {{c1::lytic cycle}}, viral genes are expressed immediately, hundreds of new virions are assembled, and the host cell is destroyed during release; viruses that always do this are termed {{c2::virulent}}.', 2),

  (deck, 80, 'cloze',
   'In the {{c1::lysogenic cycle}}, viral DNA integrates into the host chromosome and is replicated passively; the dormant integrated form is called a {{c2::provirus}} (or {{c2::prophage}} in bacteria).', 2),

  (deck, 81, 'cloze',
   'A bacterium harboring a prophage is protected from infection by the same phage strain — a phenomenon known as {{c1::superinfection}} immunity.', 1),

  -- ── Subviral particles: Prions & Viroids ───────────────────
  (deck, 82, 'cloze',
   '{{c1::Prions}} are infectious {{c2::proteins}} that propagate disease by inducing normal proteins to misfold from {{c3::α-helical}} into {{c3::β-pleated sheet}} conformations, making them aggregation-prone and protease-resistant.', 3),

  (deck, 83, 'cloze',
   '{{c1::Viroids}} are tiny, circular RNA molecules that infect {{c2::plants}} and cause disease by silencing host genes via complementary base-pairing.', 2),

  -- ── Metabolism quick-reference ─────────────────────────────
  (deck, 84, 'cloze',
   '{{c1::Aerobic metabolism}} produces ATP using oxygen as the final electron acceptor; {{c2::anaerobic metabolism}} produces ATP without oxygen, often via fermentation or the use of inorganic ions as electron acceptors.', 2),

  -- ── Additional high-yield items from chapter outline ───────
  (deck, 85, 'cloze',
   'Bacterial pili used specifically for DNA transfer during conjugation are called {{c1::sex pili}}, and they are encoded by the {{c2::F factor}}.', 2),

  (deck, 86, 'cloze',
   'Short, hair-like adhesion structures on bacteria — distinct from flagella and not used for DNA transfer — are called {{c1::fimbriae}}.', 1),

  (deck, 87, 'cloze',
   'A {{c1::virulence factor}} is any plasmid- or chromosome-encoded trait (toxins, capsules, adhesion proteins) that increases a pathogen''s ability to cause disease.', 1),

  (deck, 88, 'cloze',
   'The plasma membrane of a bacterium serves as the site of the {{c1::electron transport chain}}, since prokaryotes lack mitochondria.', 1),

  (deck, 89, 'cloze',
   'In a Gram-positive cell wall, the polymer {{c1::lipoteichoic acid}} extends from the plasma membrane through the peptidoglycan and helps anchor the wall and trigger host immune responses.', 1),

  (deck, 90, 'cloze',
   'The structural protein that polymerizes to form a bacterial flagellum is {{c1::flagellin}}, which is biochemically distinct from the {{c2::tubulin}} found in eukaryotic flagella.', 2),

  (deck, 91, 'cloze',
   'A eukaryotic flagellum is built from {{c1::microtubules}} arranged in the {{c2::9+2}} pattern and beats with whip-like motion powered by {{c3::dynein}}.', 3),

  (deck, 92, 'cloze',
   'Cilia and flagella are anchored to the cell by a {{c1::basal body}}, which has the same {{c2::nine-triplet}} microtubule structure as a centriole.', 2),

  (deck, 93, 'cloze',
   'A {{c1::pseudostratified}} epithelium has only one layer of cells but appears multilayered because the nuclei sit at different vertical levels — classically lining the {{c2::respiratory tract}}.', 2),

  (deck, 94, 'cloze',
   'Stratified squamous epithelium is found where mechanical abrasion is high, such as the {{c1::skin}} and the lining of the {{c2::esophagus}}.', 2),

  (deck, 95, 'cloze',
   '{{c1::Ubiquitination}} tags damaged or unwanted proteins for destruction by the {{c2::proteasome}}, providing a key route of regulated protein turnover in eukaryotes.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
