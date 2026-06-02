-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 3 — Nonenzymatic Protein Function and Protein Analysis
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: nonenzymatic_protein_function_and_protein_analysis
-- Sort order: 3
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--   1.  Structural Proteins
--   2.  Cytoskeletal Proteins
--   3.  Motor Proteins
--   4.  Binding Proteins
--   5.  Cell Adhesion Molecules
--   6.  Antibodies / Immunoglobulins
--   7.  Ion Channels
--   8.  Enzyme-Linked Receptors
--   9.  G Protein-Coupled Receptors
--   10. G Protein Subtypes (Gs, Gi, Gq)
--   11. Protein Isolation Prep
--   12. Electrophoresis
--   13. Chromatography
--   14. Structure Determination
--   15. Amino Acid Sequencing
--   16. Activity & Concentration Assays
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- LibreTexts Biochemistry, OpenStax Biology 2e (Ch 9 Cell Communication,
-- Ch 42 Adaptive Immunity), OpenStax Anatomy & Physiology 2e (Ch 4
-- Connective Tissue, Ch 21 Adaptive Immune Response), and the AAMC
-- Foundation 1B/3B content outlines. See companion .verification.md for
-- per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'Nonenzymatic Protein Function and Protein Analysis',
          'Non-enzymatic Protein Function and Protein Analysis',
          'Nonenzymatic Protein Function & Protein Analysis',
          'Biochemistry Review Chapter Three: Non-enzymatic Protein Function and Protein Analysis'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'nonenzymatic_protein_function_and_protein_analysis',
        'Nonenzymatic Protein Function and Protein Analysis',
        'Cellular roles of structural, cytoskeletal, motor, binding, adhesion, and immune proteins; bio-signaling via ion channels, enzyme-linked receptors, and GPCRs; and laboratory methods for protein isolation, separation, structure determination, sequencing, and quantification.',
        3
    )
    RETURNING id INTO deck;

    -- ── Structural Proteins ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     '{{c1::Structural proteins}} are characterized by highly repetitive secondary structure that gives tissues mechanical strength and shape; the main examples are collagen, elastin, and {{c2::keratin}}.',
     2),
    (deck, 1, 'cloze',
     '{{c1::Collagen}} forms a characteristic {{c2::triple helix}} and is the most abundant protein in the extracellular matrix of connective tissue.',
     2),
    (deck, 2, 'cloze',
     '{{c1::Elastin}} stretches and recoils like a spring, restoring the original shape of tissues such as skin, lungs, and blood vessels.',
     1),
    (deck, 3, 'cloze',
     '{{c1::Keratin}} is an intermediate-filament protein found in epithelial cells and is the primary structural component of {{c2::hair and nails}}.',
     2);

    -- ── Cytoskeletal Proteins ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 4, 'cloze',
     '{{c1::Actin}} monomers polymerize into microfilaments and form the thin filaments of muscle myofibrils; actin is the most {{c2::abundant}} protein in eukaryotic cells.',
     2),
    (deck, 5, 'cloze',
     'Actin filaments are {{c1::polar}}, with a positive end and a negative end; this polarity lets motor proteins travel {{c2::unidirectionally}} along the filament.',
     2),
    (deck, 6, 'cloze',
     '{{c1::Tubulin}} polymerizes into {{c2::microtubules}}, which provide cellular structure, separate chromosomes during mitosis and meiosis, and serve as tracks for intracellular transport.',
     2),
    (deck, 7, 'cloze',
     'In a microtubule, the {{c1::negative}} end sits near the nucleus and the {{c2::positive}} end points toward the cell periphery.',
     2);

    -- ── Motor Proteins ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     '{{c1::Motor proteins}} are enzymes with {{c2::ATPase}} activity; they hydrolyze ATP to produce the conformational change that generates mechanical force along actin or microtubules.',
     2),
    (deck, 9, 'cloze',
     '{{c1::Myosin}} is a motor protein that walks along {{c2::actin}} filaments; it powers muscle contraction as the thick filament of myofibrils and also drives some intracellular cargo transport.',
     2),
    (deck, 10, 'cloze',
     '{{c1::Kinesins}} are motor proteins that walk along microtubules toward the {{c2::positive end}}, transporting vesicles outward toward the cell periphery.',
     2),
    (deck, 11, 'cloze',
     '{{c1::Dyneins}} walk along microtubules toward the {{c2::negative end}}, transporting vesicles inward toward the nucleus, and also drive movement of {{c3::cilia and flagella}}.',
     3);

    -- ── Binding Proteins ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 12, 'cloze',
     '{{c1::Binding proteins}} sequester, transport, or stabilize other molecules; classic examples are {{c2::hemoglobin}}, calcium-binding proteins, and DNA-binding proteins.',
     2),
    (deck, 13, 'cloze',
     'The affinity of a protein for its ligand is measured by the {{c1::dissociation constant (Kd)}}; a {{c2::smaller}} Kd corresponds to a higher binding affinity.',
     2),
    (deck, 14, 'cloze',
     'A binding protein can act as a {{c1::transporter}} (carrying its ligand to a new location) or as a {{c2::sequestration}} agent (holding the ligand inactive or keeping its free concentration low).',
     2);

    -- ── Cell Adhesion Molecules ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     '{{c1::Cell adhesion molecules (CAMs)}} are membrane proteins that bind cells to other cells or to the extracellular matrix; the three main families are cadherins, integrins, and {{c2::selectins}}.',
     2),
    (deck, 16, 'cloze',
     '{{c1::Cadherins}} are glycoproteins that mediate {{c2::calcium-dependent}} adhesion and typically hold cells of the same {{c3::type}} together.',
     3),
    (deck, 17, 'cloze',
     '{{c1::Integrins}} are membrane-spanning proteins with {{c2::alpha and beta}} chains that bind the extracellular matrix and transmit signals that regulate cell division, apoptosis, and migration.',
     2),
    (deck, 18, 'cloze',
     '{{c1::Selectins}} are CAMs that bind {{c2::carbohydrate}} groups on adjacent cells; they form the weakest CAM bonds and are central to white blood cell migration and {{c3::inflammation}}.',
     3);

    -- ── Antibodies / Immunoglobulins ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 19, 'cloze',
     '{{c1::Antibodies}} (immunoglobulins) are Y-shaped proteins produced by {{c2::B cells}} that neutralize pathogens and toxins and recruit other immune cells to clear them.',
     2),
    (deck, 20, 'cloze',
     'An antibody is built from {{c1::two}} identical heavy chains and {{c1::two}} identical light chains held together by {{c2::disulfide}} bonds and non-covalent interactions.',
     2),
    (deck, 21, 'cloze',
     'The tips of an antibody''s Y form the {{c1::antigen-binding (variable)}} region, which binds one specific antigen; the rest of the molecule is the {{c2::constant}} region, which recruits other immune cells.',
     2),
    (deck, 22, 'cloze',
     '{{c1::Neutralization}}: an antibody binds a pathogen or toxin and physically blocks it from interacting with host cells, preventing it from exerting its effect.',
     1),
    (deck, 23, 'cloze',
     '{{c1::Opsonization}}: antibodies coat a pathogen and flag it for {{c2::phagocytosis}} by macrophages and neutrophils.',
     2),
    (deck, 24, 'cloze',
     '{{c1::Agglutination}}: antibodies crosslink multiple antigens (or whole pathogens) into large insoluble complexes that macrophages can then engulf and digest.',
     1),
    (deck, 25, 'cloze',
     '{{c1::Complement activation}}: bound antibodies recruit complement proteins, which assemble into pores that lyse the pathogen directly.',
     1);

    -- ── Ion Channels ─────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
     '{{c1::Ion channels}} are transmembrane proteins that create selective pathways for ions to cross the membrane by {{c2::facilitated diffusion}} down their electrochemical gradients.',
     2),
    (deck, 27, 'cloze',
     'The three main classes of ion channels are {{c1::ungated}} (always open), {{c2::voltage-gated}} (open in response to membrane potential), and {{c3::ligand-gated}} (open in response to a chemical messenger).',
     3),
    (deck, 28, 'cloze',
     '{{c1::Ungated (leak) channels}} are always open and let ions flow freely down their gradient; the {{c2::potassium}} leak channel is the main contributor to the resting membrane potential.',
     2),
    (deck, 29, 'cloze',
     '{{c1::Voltage-gated}} channels open or close in response to changes in {{c2::membrane potential}}; voltage-gated Na+ channels drive the depolarization phase of the action potential.',
     2),
    (deck, 30, 'cloze',
     '{{c1::Ligand-gated}} channels open when a specific chemical messenger binds; for example, the nicotinic {{c2::acetylcholine}} receptor on muscle opens to admit Na+ when ACh binds.',
     2),
    (deck, 31, 'cloze',
     'Like enzymes, ion channels and other membrane transporters can show {{c1::saturation}} kinetics — once every channel is occupied, the transport rate plateaus at a maximum called {{c2::Tmax}}.',
     2);

    -- ── Enzyme-Linked Receptors ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     '{{c1::Enzyme-linked (catalytic) receptors}} are membrane proteins that, on ligand binding, activate an intracellular enzymatic domain — most often a {{c2::kinase}} — that initiates a downstream cascade.',
     2),
    (deck, 33, 'cloze',
     'An enzyme-linked receptor has three domains: a {{c1::membrane-spanning}} domain that anchors it, a {{c2::ligand-binding}} extracellular domain, and an intracellular {{c3::catalytic}} domain.',
     3);

    -- ── G Protein-Coupled Receptors ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     '{{c1::G protein-coupled receptors (GPCRs)}} are the largest class of membrane receptors in humans; ligand binding activates a {{c2::heterotrimeric}} G protein that then alters intracellular signaling.',
     2),
    (deck, 35, 'cloze',
     'A heterotrimeric G protein has {{c1::alpha, beta, and gamma}} subunits. At rest the alpha subunit binds GDP; ligand binding to the GPCR triggers exchange of {{c2::GDP for GTP}}, and the alpha subunit dissociates to act on its effector.',
     2),
    (deck, 36, 'cloze',
     'After activating its effector, the alpha subunit slowly hydrolyzes its bound {{c1::GTP}} back to GDP and re-associates with the beta and gamma subunits, ending the signal.',
     1);

    -- ── G Protein Subtypes (Gs, Gi, Gq) ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 37, 'cloze',
     '{{c1::Gs}} stimulates {{c2::adenylyl cyclase}}, raising intracellular cAMP. {{c3::Gi}} inhibits adenylyl cyclase, lowering intracellular cAMP.',
     3),
    (deck, 38, 'cloze',
     '{{c1::Gq}} activates {{c2::phospholipase C}}, which cleaves the membrane phospholipid PIP2 into {{c3::DAG and IP3}}.',
     3),
    (deck, 39, 'cloze',
     '{{c1::IP3}} produced by the Gq pathway diffuses to the endoplasmic reticulum and opens calcium channels there, releasing stored {{c2::Ca2+}} into the cytosol as a second messenger.',
     2);

    -- ── Protein Isolation Prep ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 40, 'cloze',
     '{{c1::Homogenization}} mechanically disrupts the tissue (crushing, grinding, or blending) to release intracellular contents into a uniform solution that can be processed further.',
     1),
    (deck, 41, 'cloze',
     '{{c1::Centrifugation}} separates proteins from much smaller molecules by sedimenting components according to their size and density — a standard early step before more selective isolation techniques.',
     1);

    -- ── Electrophoresis ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     '{{c1::Electrophoresis}} drives charged molecules through a gel using an electric field; negatively charged molecules migrate toward the {{c2::anode}}, and positively charged molecules migrate toward the {{c3::cathode}}.',
     3),
    (deck, 43, 'cloze',
     'In electrophoresis the migration velocity of a molecule is {{c1::v = Ez/f}}, where E is field strength, z is net charge, and f is the {{c2::frictional}} coefficient (resistance from size and shape).',
     2),
    (deck, 44, 'cloze',
     'Standard protein electrophoresis uses a {{c1::polyacrylamide gel}}, a slightly porous matrix that separates proteins by a combination of size and {{c2::charge}}.',
     2),
    (deck, 45, 'cloze',
     '{{c1::Native PAGE}} runs proteins in their folded, biologically active state, preserving shape, size, and charge; the functional protein can be {{c2::recovered}} from the gel if unstained.',
     2),
    (deck, 46, 'cloze',
     '{{c1::SDS-PAGE}} coats proteins with the detergent {{c2::sodium dodecyl sulfate (SDS)}}, which denatures them and gives every protein a uniform {{c3::negative}} charge, so they separate by mass alone.',
     3),
    (deck, 47, 'cloze',
     '{{c1::Isoelectric focusing (IEF)}} separates proteins by their {{c2::isoelectric point (pI)}}: each protein migrates through a pH gradient until it reaches the pH where it carries no net charge and stops.',
     2),
    (deck, 48, 'cloze',
     'At its isoelectric point, an amino acid exists as a {{c1::zwitterion}} — the amino group is {{c2::protonated}}, the carboxyl group is {{c2::deprotonated}}, and any side chain is electrically neutral.',
     2);

    -- ── Chromatography ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 49, 'cloze',
     '{{c1::Chromatography}} separates a mixture by exploiting how strongly each component binds a fixed {{c2::stationary phase}} versus how readily it dissolves in a flowing {{c3::mobile phase}}.',
     3),
    (deck, 50, 'cloze',
     '{{c1::Retention time}} is how long a compound spends bound to the stationary phase. Components with high affinity for the stationary phase have long retention times; components that prefer the mobile phase {{c2::elute}} faster.',
     2),
    (deck, 51, 'cloze',
     'In {{c1::column chromatography}}, the stationary phase is a column packed with polar beads (silica or alumina); the less polar a compound, the {{c2::faster}} it elutes.',
     2),
    (deck, 52, 'cloze',
     'In {{c1::ion-exchange}} chromatography, the column beads carry a {{c2::charge}}; proteins with the opposite charge bind tightly and are retained, while like-charged proteins flow through quickly.',
     2),
    (deck, 53, 'cloze',
     'In {{c1::size-exclusion}} chromatography, the beads contain pores; small molecules enter the pores and are slowed down, while large molecules cannot enter and {{c2::elute first}}.',
     2),
    (deck, 54, 'cloze',
     'In {{c1::affinity}} chromatography, the column carries a ligand specific for the target protein; the protein binds and is later eluted with a {{c2::free}} ligand that competes for the same binding site.',
     2);

    -- ── Structure Determination ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 55, 'cloze',
     '{{c1::X-ray crystallography}} reveals atomic structure by diffracting X-rays through a {{c2::crystallized}} protein; it gives very high spatial resolution but requires that the protein form a crystal.',
     2),
    (deck, 56, 'cloze',
     '{{c1::NMR spectroscopy}} determines protein structure in solution by detecting how atomic nuclei resonate in a strong magnetic field — no crystallization required, but limited to {{c2::smaller}} proteins.',
     2),
    (deck, 57, 'cloze',
     '{{c1::Circular dichroism (CD)}} measures the difference in absorption of left- vs right-handed circularly polarized light to characterize {{c2::secondary structure}} content (alpha-helix vs beta-sheet) and protein folding.',
     2);

    -- ── Amino Acid Sequencing ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 58, 'cloze',
     '{{c1::Amino acid composition}} (which residues are present and in what ratio) is determined by complete protein {{c2::hydrolysis}} followed by chromatographic analysis of the freed amino acids.',
     2),
    (deck, 59, 'cloze',
     '{{c1::Edman degradation}} sequentially cleaves and identifies the {{c2::N-terminal}} amino acid of a protein one residue at a time; effective for small proteins of about {{c3::50-70 residues}}.',
     3),
    (deck, 60, 'cloze',
     'Larger proteins are first cut into manageable fragments by reagents that cleave at specific residues: {{c1::trypsin}} cleaves after lysine or arginine; {{c2::chymotrypsin}} cleaves after aromatic residues; {{c3::cyanogen bromide}} cleaves after methionine.',
     3),
    (deck, 61, 'cloze',
     'Sequencing methods that reduce a protein to its {{c1::primary structure}} break disulfide bridges and salt bridges in the process, so their original positions cannot be recovered from this analysis.',
     1);

    -- ── Activity & Concentration Assays ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 62, 'cloze',
     'Protein {{c1::activity}} is measured by monitoring a known reaction at a fixed substrate concentration and comparing the rate to a standard; the assay also reveals losses from {{c2::denaturation}} or contamination.',
     2),
    (deck, 63, 'cloze',
     '{{c1::UV spectroscopy}} measures protein concentration by exploiting the absorbance of aromatic side chains (tryptophan, tyrosine, phenylalanine) around {{c2::280 nm}}; sensitive but easily skewed by contaminants.',
     2),
    (deck, 64, 'cloze',
     'The {{c1::Bradford assay}} mixes the protein sample with {{c2::Coomassie}} dye; dye binding stabilizes a blue form whose absorbance is proportional to protein concentration.',
     2),
    (deck, 65, 'cloze',
     'Three classic colorimetric protein-concentration assays are the {{c1::Bradford}} assay, the {{c2::Lowry}} assay, and the {{c3::bicinchoninic acid (BCA)}} assay; each compares the unknown to a standard curve.',
     3),
    (deck, 66, 'cloze',
     'The Bradford assay is highly accurate when only one protein is present in the sample, but it is disrupted by {{c1::detergents}} (which compete for the dye) and excess {{c2::buffer}}.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 67;
END $$;
