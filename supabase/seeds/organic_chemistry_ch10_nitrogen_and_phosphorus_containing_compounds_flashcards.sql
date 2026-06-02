-- ════════════════════════════════════════════════════════════════════
-- Organic Chemistry Chapter 10 — Nitrogen and Phosphorus Containing Compounds
-- ════════════════════════════════════════════════════════════════════
-- Section: organic_chemistry
-- Topic:   Organic Chemistry
-- Subtopic slug: nitrogen_and_phosphorus_containing_compounds
-- Sort order: 10
--
-- Coverage (AAMC-aligned order):
--   1.  Amino Acid Structure + Chirality
--   2.  Acid-Base Behavior + Zwitterions
--   3.  Side-Chain Classification — Nonpolar + Aromatic
--   4.  Side-Chain Classification — Polar + Charged
--   5.  Peptide Bond Formation
--   6.  Peptide Bond Resonance + Planarity
--   7.  Strecker Synthesis — Setup
--   8.  Strecker Mechanism
--   9.  Gabriel Synthesis — Setup
--   10. Gabriel Step 1 — First SN2 Alkylation
--   11. Gabriel Step 2 — α-Carbon Alkylation
--   12. Gabriel Steps 3-4 — Hydrolysis + Decarboxylation
--   13. Phosphoric Acid + Inorganic Phosphate
--   14. Phosphate pKa + Buffering
--   15. Organic Phosphates + Phosphodiester Bonds
--   16. Pyrophosphate + DNA Polymerization
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- LibreTexts Organic Chemistry (Amino Acid Synthesis — Strecker, Gabriel;
-- Phosphate Chemistry) and LibreTexts Biochemistry (Amino Acid Structure,
-- DNA Polymerization), and the AAMC Foundation 1A and 5D content
-- outlines. See companion .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'organic_chemistry'
      AND title IN (
          'Nitrogen and Phosphorus Containing Compounds',
          'Nitrogen & Phosphorus Containing Compounds',
          'Nitrogen and Phosphorus-Containing Compounds',
          'Organic Chemistry Review: Chapter 10: Nitrogen and Phosphorus Containing Compounds'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'organic_chemistry',
        'Organic Chemistry',
        'nitrogen_and_phosphorus_containing_compounds',
        'Nitrogen and Phosphorus Containing Compounds',
        'Amino acid structure (α-carbon, chirality, L vs D, CIP S/R designations); acid-base behavior and zwitterions; side-chain classification (nonpolar nonaromatic, aromatic, polar uncharged, acidic, basic); peptide bond formation and hydrolysis; amide planarity from resonance; the Strecker synthesis of α-amino acids (mechanism with imine and aminonitrile intermediates); the Gabriel synthesis using phthalimide and diethyl bromomalonate (two SN2 alkylations, hydrolysis, decarboxylation); phosphoric acid and inorganic phosphate (pKa values, buffering, physiological forms); organic phosphates and phosphodiester bonds in nucleic acids; pyrophosphate and the thermodynamics of DNA polymerization.',
        10
    )
    RETURNING id INTO deck;

    -- ── Amino Acid Structure + Chirality ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'An {{c1::amino acid}} contains an amino group (-NH₂), a carboxyl group (-COOH), a hydrogen atom, and a unique side chain (R group) all bonded to a central {{c2::α-carbon}}.',
     2),
    (deck, 1, 'cloze',
     'The α-carbon of an amino acid is a {{c1::chiral center (stereocenter)}} because it bears four different substituents — except in {{c2::glycine}}, where the R group is just a hydrogen.',
     2),
    (deck, 2, 'cloze',
     'All naturally occurring amino acids in eukaryotic proteins are {{c1::L}}-amino acids (under the Fischer convention), which means the amino group is drawn on the {{c2::left}} in the Fischer projection.',
     2),
    (deck, 3, 'cloze',
     'Under {{c1::CIP (R/S) rules}}, all L-amino acids have the {{c2::(S)}} configuration EXCEPT {{c3::cysteine}}, which has (R) — because its sulfur side chain has a higher priority than the carboxyl group.',
     3);

    -- ── Acid-Base Behavior + Zwitterions ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 4, 'cloze',
     'Amino acids are {{c1::amphoteric}} — they can act as both acids and bases — because they possess both an acidic carboxyl group and a basic amino group on the same molecule.',
     1),
    (deck, 5, 'cloze',
     'A {{c1::zwitterion}} is a dipolar form of an amino acid carrying a positive charge (NH₃⁺) on the amino group AND a negative charge (COO⁻) on the carboxyl group, with no net overall charge.',
     1),
    (deck, 6, 'cloze',
     'In strongly acidic solution, both the carboxyl and amino groups are fully {{c1::protonated}}, giving the amino acid a net positive charge.',
     1),
    (deck, 7, 'cloze',
     'In strongly basic solution, both the carboxyl and amino groups are fully {{c1::deprotonated}}, giving the amino acid a net negative charge.',
     1);

    -- ── Side-Chain Classification — Nonpolar + Aromatic ─────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     'The {{c1::nonpolar nonaromatic}} amino acids — alanine, valine, leucine, isoleucine, glycine, proline, and methionine — have hydrophobic R groups and tend to bury in protein interiors.',
     1),
    (deck, 9, 'cloze',
     'The three {{c1::aromatic}} amino acids are {{c2::tryptophan}}, {{c2::phenylalanine}}, and {{c2::tyrosine}}; their conjugated rings absorb UV light near 280 nm.',
     2),
    (deck, 10, 'cloze',
     '{{c1::Methionine}} carries a thioether (-S-CH₃) in its nonpolar side chain, and {{c2::proline}} has a cyclic side chain that loops back to its amino nitrogen — both are technically nonpolar.',
     2);

    -- ── Side-Chain Classification — Polar + Charged ─────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 11, 'cloze',
     'The {{c1::polar uncharged}} amino acids — serine, threonine, asparagine, glutamine, and cysteine — bear oxygen-, nitrogen-, or sulfur-containing groups that form hydrogen bonds with water.',
     1),
    (deck, 12, 'cloze',
     'The {{c1::acidic (negatively charged)}} amino acids are {{c2::aspartate (Asp/D)}} and {{c2::glutamate (Glu/E)}}; their side chains carry a carboxylate (-COO⁻) at physiological pH.',
     2),
    (deck, 13, 'cloze',
     'The {{c1::basic (positively charged)}} amino acids are {{c2::lysine (Lys/K)}}, {{c2::arginine (Arg/R)}}, and {{c2::histidine (His/H)}}; their side chains carry a positive charge at physiological pH (histidine is partially).',
     2),
    (deck, 14, 'cloze',
     'Polar, acidic, and basic amino acids are {{c1::hydrophilic}} — they tend to be found on protein surfaces, where they form {{c2::hydrogen bonds}} with surrounding water.',
     2);

    -- ── Peptide Bond Formation ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'A {{c1::peptide bond}} forms when the carboxyl group of one amino acid condenses with the amino group of another, releasing {{c2::water}} in a dehydration reaction.',
     2),
    (deck, 16, 'cloze',
     'A {{c1::polypeptide}} is a chain of amino acids linked by peptide bonds; polypeptides are the basic building blocks of proteins, which are large, folded polypeptides with functional roles.',
     1),
    (deck, 17, 'cloze',
     'Peptide bonds are cleaved by {{c1::hydrolysis}} — adding a water molecule across the bond to release free amino acids; this is catalyzed by strong acid, strong base, or {{c2::proteolytic enzymes}}.',
     2);

    -- ── Peptide Bond Resonance + Planarity ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     'The C–N bond in a peptide (amide) bond has {{c1::partial double-bond character}} arising from {{c2::resonance}} — the nitrogen lone pair delocalizes into the carbonyl π system.',
     2),
    (deck, 19, 'cloze',
     'Because of resonance, the peptide bond is {{c1::planar}} and rotation around the C–N axis is {{c2::restricted}}; this limits the conformations a protein backbone can adopt.',
     2);

    -- ── Strecker Synthesis — Setup ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
     'The {{c1::Strecker synthesis}} converts an aldehyde into an α-amino acid using {{c2::NH₄Cl (ammonia source)}} and {{c3::KCN (cyanide)}} as the key reactants.',
     3),
    (deck, 21, 'cloze',
     'In Strecker synthesis, the {{c1::aldehyde}} dictates the R group of the resulting amino acid — using formaldehyde (HCHO) gives glycine, using acetaldehyde (CH₃CHO) gives alanine.',
     1),
    (deck, 22, 'cloze',
     'The Strecker synthesis produces a {{c1::racemic mixture}} of L- and D-amino acids because the key intermediate (an imine) is planar, allowing cyanide to attack from either {{c2::face}}.',
     2);

    -- ── Strecker Mechanism ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 23, 'cloze',
     'Strecker step 1: NH₃ attacks the protonated {{c1::aldehyde}} carbonyl carbon, then loss of water gives an {{c2::imine}} (C=N) — a condensation reaction.',
     2),
    (deck, 24, 'cloze',
     'Strecker step 2: cyanide (CN⁻) performs a {{c1::nucleophilic addition}} to the imine, producing an {{c2::α-aminonitrile}} (a carbon bearing both -NH₂ and -C≡N).',
     2),
    (deck, 25, 'cloze',
     'Strecker step 3: aqueous hydrolysis (typically acidic, with heat) converts the {{c1::nitrile (-C≡N)}} group of the α-aminonitrile into a {{c2::carboxylic acid (-COOH)}}, finishing the amino acid.',
     2);

    -- ── Gabriel Synthesis — Setup ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
     'The {{c1::Gabriel synthesis}} builds an α-amino acid by alkylating a phthalimide-protected nitrogen, then unmasking the free amine through hydrolysis and decarboxylation.',
     1),
    (deck, 27, 'cloze',
     'Gabriel synthesis uses three carbon-containing starting materials: {{c1::potassium phthalimide}} (the nitrogen source), {{c2::diethyl bromomalonate}} (the carboxyl source), and an {{c3::alkyl halide (R-X)}} (the R-group source).',
     3),
    (deck, 28, 'cloze',
     'The deprotonated {{c1::phthalimide}} salt is a strong nucleophile because the negative charge on nitrogen is stabilized by delocalization into the two flanking {{c2::carbonyl}} groups.',
     2);

    -- ── Gabriel Step 1 — First SN2 Alkylation ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     'Gabriel step 1: phthalimide anion attacks the C–Br carbon of diethyl bromomalonate via {{c1::SN2}}, displacing bromide and giving the phthalimidomalonic ester.',
     1),
    (deck, 30, 'cloze',
     'Once nitrogen is locked inside the bulky phthalimide ring, it is no longer {{c1::nucleophilic}}; this prevents over-alkylation that plagues simpler amine alkylations.',
     1),
    (deck, 31, 'cloze',
     'The alkyl halide R-X must be a good SN2 substrate ({{c1::primary or methyl}}); this is why Gabriel synthesis cannot make amino acids with branched β-carbons like {{c2::valine}}.',
     2);

    -- ── Gabriel Step 2 — α-Carbon Alkylation ────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     'The α-carbon between the two ester carbonyls of phthalimidomalonic ester is acidic (pKa ≈ {{c1::13}}) because the resulting enolate is stabilized by both adjacent {{c2::carbonyl}} groups.',
     2),
    (deck, 33, 'cloze',
     'Gabriel step 2: a base (e.g., NaOEt) deprotonates the α-carbon, and the resulting {{c1::enolate}} performs a second {{c2::SN2}} attack on the alkyl halide R-X, installing the side chain.',
     2);

    -- ── Gabriel Steps 3-4 — Hydrolysis + Decarboxylation ────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     'Gabriel step 3: aqueous {{c1::strong base + heat}} hydrolyzes both the phthalimide group (releasing phthalic acid and the free amine) and the two ester groups (giving a {{c2::malonic-type diacid}}).',
     2),
    (deck, 35, 'cloze',
     'Gabriel step 4: heating the {{c1::malonic-type}} diacid drives {{c2::decarboxylation}} — one carboxyl group leaves as CO₂ — yielding the final α-amino acid product.',
     2),
    (deck, 36, 'cloze',
     'Like Strecker, Gabriel synthesis produces a {{c1::racemic mixture}} of L- and D-amino acids because the α-carbon stereocenter is created without any chiral influence during the reaction.',
     1);

    -- ── Phosphoric Acid + Inorganic Phosphate ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 37, 'cloze',
     '{{c1::Phosphoric acid (H₃PO₄)}} is also called {{c2::inorganic phosphate (Pᵢ)}} when referring to its dissociated forms; it has three acidic hydrogens.',
     2),
    (deck, 38, 'cloze',
     'The four protonation states of phosphoric acid (from low to high pH) are {{c1::H₃PO₄ → H₂PO₄⁻ → HPO₄²⁻ → PO₄³⁻}}.',
     1),
    (deck, 39, 'cloze',
     'At physiological pH (~7.4), the dominant phosphate forms are {{c1::H₂PO₄⁻ (dihydrogen phosphate)}} and {{c1::HPO₄²⁻ (hydrogen phosphate)}}, present in nearly equal proportions.',
     1);

    -- ── Phosphate pKa + Buffering ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 40, 'cloze',
     'The three pKa values of H₃PO₄ are approximately {{c1::2.15, 7.20, and 12.32}} — for loss of the first, second, and third proton respectively.',
     1),
    (deck, 41, 'cloze',
     'Phosphate is an excellent biological buffer because its pKa values span a wide pH range, and the {{c1::pKa₂ ≈ 7.20}} sits very close to physiological pH (~7.4).',
     1),
    (deck, 42, 'cloze',
     'The H₂PO₄⁻/HPO₄²⁻ pair acts as the {{c1::intracellular phosphate buffer}}, soaking up small additions of acid or base to keep cytoplasmic pH near 7.4.',
     1);

    -- ── Organic Phosphates + Phosphodiester Bonds ───────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     '{{c1::Inorganic phosphate (Pᵢ)}} is free phosphate not attached to any organic molecule; {{c1::organic phosphate}} is a phosphate group covalently bonded to a carbon-containing molecule (e.g., glucose-6-phosphate, ATP, GTP).',
     1),
    (deck, 44, 'cloze',
     'A {{c1::phosphodiester bond}} forms when a single phosphate group is esterified to TWO separate hydroxyl groups; phosphodiester bonds link the {{c2::sugar}} backbones of DNA and RNA.',
     2),
    (deck, 45, 'cloze',
     'Phosphate anhydride bonds (e.g., in ATP) are "high-energy" because hydrolysis is favored by {{c1::resonance stabilization}} of the products and relief of {{c2::charge repulsion}} between phosphate negatives.',
     2);

    -- ── Pyrophosphate + DNA Polymerization ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 46, 'cloze',
     '{{c1::Pyrophosphate (PPᵢ)}} is two phosphate groups linked by an anhydride bond; it has the formula P₂O₇⁴⁻ and is the dimer of inorganic phosphate.',
     1),
    (deck, 47, 'cloze',
     'When DNA polymerase adds a nucleotide to a growing strand, it cleaves a {{c1::pyrophosphate (PPᵢ)}} from the incoming dNTP, providing the energy for the new phosphodiester bond.',
     1),
    (deck, 48, 'cloze',
     'The released PPᵢ is rapidly hydrolyzed in solution to {{c1::two}} inorganic phosphates (2 Pᵢ); this irreversible hydrolysis pulls the DNA polymerization equilibrium {{c2::forward}}.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 49;
END $$;
