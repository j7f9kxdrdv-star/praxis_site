-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 1 — Amino Acids, Peptides, and Proteins
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: amino_acids_peptides_and_proteins
-- Sort order: 1
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--   1.  Amino Acid Structure
--   2.  Stereochemistry
--   3.  Nonpolar & Aromatic Side Chains
--   4.  Polar & Charged Side Chains
--   5.  Hydrophobic vs Hydrophilic Behavior
--   6.  Acid-Base Chemistry
--   7.  Zwitterions and Titration States
--   8.  pI Concept & Formulas
--   9.  Peptide Nomenclature & Bond Formation
--   10. Peptide Bond Hydrolysis
--   11. Primary Structure
--   12. Secondary Structure
--   13. Proline & Secondary Structure
--   14. Tertiary Structure + Solvation Driver
--   15. Quaternary Structure + Conjugated Proteins
--   16. Denaturation
--
-- Scope note: this deck focuses on the conceptual chapter content
-- (acid-base chemistry, peptide bonds, structure levels). Per-amino-acid
-- structural memorization (the 20 structures) lives in the separate
-- amino_acids deck and is not duplicated here.
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- LibreTexts Biochemistry, LibreTexts Organic Chemistry (stereochemistry),
-- and the AAMC Foundation 1A and 1B content outlines. See companion
-- .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'Amino Acids, Peptides, and Proteins',
          'Amino Acids, Peptides and Proteins',
          'Amino Acids Peptides and Proteins',
          'Biochemistry Review Chapter One: Amino Acids, Peptides, and Proteins'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'amino_acids_peptides_and_proteins',
        'Amino Acids, Peptides, and Proteins',
        'Amino acid structure and stereochemistry, side-chain classification, acid-base chemistry and the isoelectric point, peptide bond formation and hydrolysis, and the four levels of protein structure including denaturation and conjugated proteins.',
        1
    )
    RETURNING id INTO deck;

    -- ── Amino Acid Structure ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'An {{c1::amino acid}} contains an amino group (-NH2), a carboxyl group (-COOH), a hydrogen atom, and a unique {{c2::side chain (R group)}}, all bonded to the central α-carbon.',
     2),
    (deck, 1, 'cloze',
     'Human proteins are built from {{c1::20}} {{c2::α-amino acids}} encoded by the standard genetic code; these are the proteinogenic (proteogenic) amino acids.',
     2),
    (deck, 2, 'cloze',
     'The {{c1::α-carbon}} of an amino acid is the central carbon bonded to four groups — amino, carboxyl, hydrogen, and the side chain — making it a {{c2::chiral}} center.',
     2),
    (deck, 3, 'cloze',
     'The average molecular weight of an amino acid residue in a protein is roughly {{c1::110 Da}}, a useful rule of thumb when estimating molecular weight from sequence length.',
     1);

    -- ── Stereochemistry ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 4, 'cloze',
     '{{c1::Glycine}} is the only proteinogenic amino acid that is not optically active because its R group is just a {{c2::hydrogen}}, leaving the α-carbon without four distinct groups.',
     2),
    (deck, 5, 'cloze',
     'All 20 proteinogenic amino acids in human proteins are of the {{c1::L}} configuration when assigned by the Fischer projection convention.',
     1),
    (deck, 6, 'cloze',
     'Under {{c1::Cahn-Ingold-Prelog (R/S)}} rules, all proteinogenic amino acids have the {{c2::S}} configuration — except {{c3::cysteine}}, whose sulfur side chain outranks its carboxyl group and makes it R.',
     3),
    (deck, 7, 'cloze',
     'The {{c1::Cahn-Ingold-Prelog (CIP)}} system ranks the four substituents on a stereocenter by atomic number to assign each chiral center an unambiguous {{c2::R or S}} label.',
     2);

    -- ── Nonpolar & Aromatic Side Chains ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     'The nonpolar amino acids are alanine, valine, leucine, isoleucine, glycine, {{c1::methionine}}, and {{c2::proline}}, all of which carry hydrophobic R groups.',
     2),
    (deck, 9, 'cloze',
     '{{c1::Methionine}} is one of two amino acids whose side chain contains a {{c2::sulfur}} atom (the other is cysteine); the side chain itself is nonpolar.',
     2),
    (deck, 10, 'cloze',
     '{{c1::Proline}} is unique because its side chain loops back and bonds to the α-amino nitrogen, forming a rigid {{c2::five-membered ring}}.',
     2),
    (deck, 11, 'cloze',
     'The aromatic amino acids are {{c1::tryptophan}}, {{c2::phenylalanine}}, and {{c3::tyrosine}}; their conjugated rings let them absorb UV light near 280 nm.',
     3),
    (deck, 12, 'cloze',
     '{{c1::Tryptophan}} has an indole double-ring system containing a nitrogen; {{c2::phenylalanine}} has a plain benzyl ring; {{c3::tyrosine}} is phenylalanine with an added hydroxyl group.',
     3),
    (deck, 13, 'cloze',
     'Because of their conjugated ring systems, the aromatic amino acids — especially {{c1::tryptophan}} and {{c2::tyrosine}} — absorb UV light around {{c3::280 nm}}, the basis of UV protein quantification.',
     3);

    -- ── Polar & Charged Side Chains ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 14, 'cloze',
     'The polar uncharged amino acids are serine, threonine, asparagine, glutamine, and {{c1::cysteine}}; they carry side chains capable of hydrogen bonding but do not gain or lose protons in normal pH ranges.',
     1),
    (deck, 15, 'cloze',
     '{{c1::Serine}} and {{c1::threonine}} both carry a hydroxyl (-OH) on their side chain, making them strongly {{c2::polar}} and good hydrogen-bond donors and acceptors.',
     2),
    (deck, 16, 'cloze',
     '{{c1::Asparagine}} and {{c1::glutamine}} carry an {{c2::amide}} group on their side chain; this amide nitrogen does not gain or lose protons with pH.',
     2),
    (deck, 17, 'cloze',
     'The acidic amino acids are {{c1::aspartate}} and {{c2::glutamate}}; their side chains carry a {{c3::carboxylate (-COO-)}} that is deprotonated and negatively charged at physiological pH.',
     3),
    (deck, 18, 'cloze',
     'The basic amino acids are {{c1::lysine}}, {{c2::arginine}}, and {{c3::histidine}}; their side chains carry nitrogen-containing groups that are typically protonated and positively charged at physiological pH.',
     3),
    (deck, 19, 'cloze',
     '{{c1::Lysine}} has a terminal primary amine, {{c2::arginine}} has a guanidinium group whose positive charge is delocalized across three nitrogens, and {{c3::histidine}} has an imidazole ring with two nitrogens.',
     3);

    -- ── Hydrophobic vs Hydrophilic Behavior ─────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
     '{{c1::Hydrophobic}} side chains (the nonpolar amino acids) cluster in the {{c2::interior}} of a folded globular protein, where they minimize contact with water.',
     2),
    (deck, 21, 'cloze',
     '{{c1::Hydrophilic}} side chains — including all charged and most polar residues — are found on the {{c2::surface}} of a folded globular protein, in contact with water.',
     2),
    (deck, 22, 'cloze',
     'The strongly hydrophobic amino acids are alanine, valine, leucine, isoleucine, and {{c1::phenylalanine}}, whose long alkyl or aromatic side chains have no polar groups.',
     1);

    -- ── Acid-Base Chemistry ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 23, 'cloze',
     'Amino acids are {{c1::amphoteric}} — they can act as either an acid or a base because they carry both an acidic carboxyl group and a basic amino group.',
     1),
    (deck, 24, 'cloze',
     'When the {{c1::pH}} is below an ionizable group''s pKa, the group is mostly {{c2::protonated}}; when pH is above the pKa, it is mostly {{c3::deprotonated}}.',
     3),
    (deck, 25, 'cloze',
     'The {{c1::pKa}} of an ionizable group is the pH at which, on average, exactly half of the molecules of that species are {{c2::deprotonated}}.',
     2),
    (deck, 26, 'cloze',
     'Every amino acid has at least two pKa values: the α-carboxyl group near {{c1::pKa ~2}} and the α-amino group near {{c2::pKa ~9-10}}.',
     2);

    -- ── Zwitterions and Titration States ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 27, 'cloze',
     'A {{c1::zwitterion}} is a dipolar form of a molecule that carries both a positive and a negative charge but is overall {{c2::electrically neutral}}.',
     2),
    (deck, 28, 'cloze',
     'At very low pH (e.g., pH 1), an amino acid carries a {{c1::positive}} net charge: the amino group is protonated (-NH3+) and the carboxyl group is also protonated (-COOH).',
     1),
    (deck, 29, 'cloze',
     'At physiological pH (~7.4), an amino acid exists predominantly as a {{c1::zwitterion}}: the α-amino group is {{c2::protonated}} (-NH3+) and the α-carboxyl group is {{c3::deprotonated}} (-COO-).',
     3),
    (deck, 30, 'cloze',
     'At very high pH (e.g., pH 11), an amino acid carries a {{c1::negative}} net charge: the carboxyl group remains deprotonated and the amino group is now deprotonated to -NH2.',
     1),
    (deck, 31, 'cloze',
     'Near a pKa value, an amino acid acts as a {{c1::buffer}}: adding more base produces only a small pH change because the deprotonation reaction absorbs the added hydroxide.',
     1);

    -- ── pI Concept & Formulas ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     'The {{c1::isoelectric point (pI)}} of an amino acid is the pH at which it carries no net {{c2::charge}}.',
     2),
    (deck, 33, 'cloze',
     'For an amino acid with a non-ionizable side chain, the pI is the {{c1::average}} of the α-amino and α-carboxyl pKa values: pI = ({{c2::pKa,COOH + pKa,NH3+}})/2.',
     2),
    (deck, 34, 'cloze',
     'For an amino acid with an acidic side chain (Asp, Glu), the pI is the average of the {{c1::two lowest}} pKa values: pI = (pKa,COOH + pKa,R)/2; this gives a {{c2::low}} pI.',
     2),
    (deck, 35, 'cloze',
     'For an amino acid with a basic side chain (Lys, Arg, His), the pI is the average of the {{c1::two highest}} pKa values: pI = (pKa,R + pKa,NH3+)/2; this gives a {{c2::high}} pI.',
     2);

    -- ── Peptide Nomenclature & Bond Formation ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 36, 'cloze',
     'A {{c1::dipeptide}} contains 2 residues, a {{c1::tripeptide}} 3, an {{c2::oligopeptide}} up to about 20, and a {{c3::polypeptide}} more than 20.',
     3),
    (deck, 37, 'cloze',
     'A peptide bond forms by a {{c1::condensation (dehydration)}} reaction between the carboxyl group of one amino acid and the amino group of another, releasing {{c2::water}}.',
     2),
    (deck, 38, 'cloze',
     'In peptide bond formation, the electrophilic {{c1::carbonyl carbon}} of one amino acid is attacked by the nucleophilic {{c2::amino nitrogen}} of the next, and a hydroxyl is lost to form water.',
     2),
    (deck, 39, 'cloze',
     'Peptide sequences are written and read from the {{c1::N-terminus}} (free amino group, drawn left) to the {{c2::C-terminus}} (free carboxyl group, drawn right).',
     2);

    -- ── Peptide Bond Hydrolysis ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 40, 'cloze',
     'Peptide bond hydrolysis adds a hydrogen atom to the amide {{c1::nitrogen}} and a hydroxyl group to the carbonyl carbon, cleaving the bond; in vivo it is catalyzed by {{c2::hydrolytic enzymes}}.',
     2),
    (deck, 41, 'cloze',
     '{{c1::Trypsin}} cleaves peptide bonds on the carboxyl side of {{c2::lysine and arginine}} — basic residues with positively charged side chains.',
     2),
    (deck, 42, 'cloze',
     '{{c1::Chymotrypsin}} cleaves peptide bonds on the carboxyl side of {{c2::phenylalanine, tryptophan, and tyrosine}} — the aromatic residues.',
     2);

    -- ── Primary Structure ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     'The {{c1::primary structure}} of a protein is its linear sequence of amino acids, encoded in DNA and read from {{c2::N-terminus to C-terminus}}.',
     2),
    (deck, 44, 'cloze',
     'Primary structure is held together by {{c1::covalent peptide bonds}} between adjacent residues — by far the strongest interactions in protein structure.',
     1),
    (deck, 45, 'cloze',
     'The primary structure of a protein alone encodes all the information needed for folding at every higher level: secondary, tertiary, and {{c1::quaternary}}.',
     1);

    -- ── Secondary Structure ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 46, 'cloze',
     '{{c1::Secondary structure}} is local folding of neighboring residues into regular patterns; it is stabilized primarily by {{c2::hydrogen bonds}} between the carbonyl oxygens and amide hydrogens of the backbone.',
     2),
    (deck, 47, 'cloze',
     'The {{c1::α-helix}} is a rod-shaped structure in which the backbone coils with hydrogen bonds between a carbonyl oxygen and an amide hydrogen {{c2::four residues}} farther along the chain.',
     2),
    (deck, 48, 'cloze',
     'In an α-helix, side chains project {{c1::outward}} from the helix core; the α-helix is the dominant secondary structure of {{c2::keratin}}, the structural protein of hair and nails.',
     2),
    (deck, 49, 'cloze',
     'In a {{c1::β-pleated sheet}}, peptide chains lie side by side and form hydrogen bonds between strands; the strands can run in the same direction ({{c2::parallel}}) or opposite directions ({{c2::antiparallel}}).',
     2);

    -- ── Proline & Secondary Structure ───────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 50, 'cloze',
     '{{c1::Proline}}''s rigid cyclic structure puts a sharp kink in the backbone, so it is rarely found in the middle of an {{c2::α-helix}} (except in transmembrane helices).',
     2),
    (deck, 51, 'cloze',
     'Proline is rarely found in the middle of a β-sheet but is frequently found at the {{c1::turns}} between β-strands and at the {{c2::start}} of an α-helix.',
     2);

    -- ── Tertiary Structure + Solvation Driver ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 52, 'cloze',
     '{{c1::Tertiary structure}} is the full three-dimensional fold of a single polypeptide chain, determined mainly by interactions between {{c2::side chains (R groups)}}.',
     2),
    (deck, 53, 'cloze',
     'The dominant driver of tertiary folding is the {{c1::hydrophobic effect}}: nonpolar side chains cluster in the protein interior, away from water, while polar and charged side chains face outward.',
     1),
    (deck, 54, 'cloze',
     '{{c1::Disulfide bonds}} are covalent S-S linkages between two {{c2::cysteine}} residues; their formation requires oxidation (loss of two hydrogens and two electrons) and they create loops within or between polypeptide chains.',
     2),
    (deck, 55, 'cloze',
     'Burying hydrophobic side chains inside the protein lets nearby water molecules move more freely instead of being locked into a rigid {{c1::solvation layer}}, raising overall {{c2::entropy}} and driving folding.',
     2),
    (deck, 56, 'cloze',
     '{{c1::Fibrous}} proteins (e.g., collagen, keratin) form long sheets or strands and are typically structural; {{c2::globular}} proteins (e.g., myoglobin, hemoglobin) are spherical and are typically functional or transport.',
     2);

    -- ── Quaternary Structure + Conjugated Proteins ──────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 57, 'cloze',
     '{{c1::Quaternary structure}} is the spatial arrangement of two or more polypeptide {{c2::subunits}} into a single functional complex; not every protein has quaternary structure.',
     2),
    (deck, 58, 'cloze',
     'Quaternary assemblies can increase {{c1::stability}}, reduce the DNA needed to encode a complex, shuttle intermediates between catalytic sites, and enable {{c2::cooperativity}} and allosteric regulation.',
     2),
    (deck, 59, 'cloze',
     'A {{c1::conjugated protein}} carries a covalently attached non-amino-acid component — a {{c2::prosthetic group}} — that is essential to its function.',
     2),
    (deck, 60, 'cloze',
     'Proteins with lipid, carbohydrate, or nucleic acid prosthetic groups are called {{c1::lipoproteins, glycoproteins, and nucleoproteins}}; the classic example is {{c2::hemoglobin}}, whose iron-containing heme prosthetic group binds oxygen.',
     2);

    -- ── Denaturation ────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 61, 'cloze',
     '{{c1::Denaturation}} is the loss of a protein''s higher-order structure (tertiary and often quaternary), causing loss of function; it is often {{c2::irreversible}}.',
     2),
    (deck, 62, 'cloze',
     'The two main causes of denaturation are {{c1::heat}}, which overcomes hydrophobic and noncovalent interactions, and {{c2::solutes}} (including reducing agents and detergents), which break disulfide bridges and disrupt other forces.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 63;
END $$;
