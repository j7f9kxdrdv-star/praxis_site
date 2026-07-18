-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 7 — RNA and the Genetic Code
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: rna_and_the_genetic_code
-- Sort order: 7
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--    1. RNA Structure & Types
--    2. The Genetic Code
--    3. Mutations
--    4. Transcription
--    5. RNA Processing
--    6. Translation
--    7. Prokaryotic Gene Expression — Operons
--    8. Eukaryotic Gene Expression
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Biology 2e (Ch 15 Genes and Proteins, Ch 16 Gene Expression) and LibreTexts
-- Biochemistry. Scope: RNA / genetic code / transcription / translation / gene-expression
-- control only — DNA structure, replication, and repair are Ch 6. See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'RNA and the Genetic Code',
          'RNA & the Genetic Code',
          'Biochemistry Review Chapter Seven: RNA and the Genetic Code'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'rna_and_the_genetic_code',
        'RNA and the Genetic Code',
        'RNA types, the genetic code (codons, degeneracy, wobble, start/stop), mutation types, transcription and the RNA polymerases, mRNA processing and splicing, translation on the ribosome, and control of gene expression in prokaryotes (operons) and eukaryotes (transcription factors, chromatin, noncoding RNAs).',
        7
    )
    RETURNING id INTO deck;

    -- ── RNA Structure & Types ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'RNA''s sugar is {{c1::ribose}}, which unlike DNA''s sugar carries a hydroxyl group on its {{c2::2′}} carbon.',
     2),
    (deck, 1, 'cloze',
     'In RNA, the pyrimidine base {{c1::uracil}} replaces the thymine used in DNA.',
     1),
    (deck, 2, 'cloze',
     'An RNA molecule is usually {{c1::single-stranded}}, unlike DNA.',
     1),
    (deck, 3, 'cloze',
     'The RNA that carries a gene''s protein-coding information from DNA to the ribosome for translation is {{c1::messenger RNA (mRNA)}}.',
     1),
    (deck, 4, 'cloze',
     'The adapter RNA that brings amino acids to the ribosome and pairs them with mRNA codons is {{c1::transfer RNA (tRNA)}}.',
     1),
    (deck, 5, 'cloze',
     'A tRNA recognizes the matching mRNA triplet through a complementary three-base sequence called its {{c1::anticodon}}.',
     1),
    (deck, 6, 'cloze',
     'The RNA that forms the ribosome''s structural and catalytic core is {{c1::ribosomal RNA (rRNA)}}.',
     1),
    (deck, 7, 'cloze',
     'A tRNA folds into a {{c1::cloverleaf}} secondary structure and attaches its amino acid at the {{c2::3′-CCA}} tail.',
     2);

    -- ── The Genetic Code ──────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     'The central dogma states that genetic information flows from {{c1::DNA}} to {{c1::RNA}} to {{c1::protein}}.',
     1),
    (deck, 9, 'cloze',
     'In the central dogma, copying DNA into RNA is {{c1::transcription}}, and decoding RNA into protein is {{c2::translation}}.',
     2),
    (deck, 10, 'cloze',
     'Each mRNA codon is a set of {{c1::three}} consecutive nucleotides that specifies one amino acid.',
     1),
    (deck, 11, 'cloze',
     'There are {{c1::64}} codons but only {{c1::20}} amino acids, so the code is {{c2::degenerate}}.',
     2),
    (deck, 12, 'cloze',
     '{{c2::Wobble}} is flexible pairing between the codon''s {{c1::third}} base and the anticodon''s {{c1::5′}} base, letting one tRNA read several codons.',
     2),
    (deck, 13, 'cloze',
     'An mRNA codon and its tRNA anticodon base-pair in an {{c1::antiparallel}} orientation.',
     1),
    (deck, 14, 'cloze',
     'The genetic code is nearly {{c1::universal}}: an mRNA transferred to a different species is translated into the same amino acid sequence.',
     1),
    (deck, 15, 'cloze',
     'The genetic code is {{c1::non-overlapping}} (each base belongs to just one codon) and {{c1::commaless}} (codons are read consecutively with no spacers).',
     1),
    (deck, 16, 'cloze',
     'The start codon {{c1::AUG}} begins translation and also codes for the amino acid {{c1::methionine}}.',
     1),
    (deck, 17, 'cloze',
     'The three stop codons are {{c1::UAA}}, {{c1::UGA}}, and {{c1::UAG}}; they end translation and encode no amino acid.',
     1);

    -- ── Mutations ─────────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     'A {{c1::point mutation}} affects only a single base of DNA, most commonly a substitution in which one nucleotide takes the place of another.',
     1),
    (deck, 19, 'cloze',
     'A {{c1::silent}} mutation swaps a nucleotide yet, because the genetic code is degenerate, the new codon still specifies the same amino acid.',
     1),
    (deck, 20, 'cloze',
     'A {{c1::missense}} mutation changes a codon so that it now encodes a different amino acid, which may alter the protein''s structure or function.',
     1),
    (deck, 21, 'cloze',
     'A {{c1::nonsense}} mutation turns an amino-acid codon into a premature stop codon, ending translation early and truncating the protein.',
     1),
    (deck, 22, 'cloze',
     'Inserting or deleting a number of bases not divisible by three causes a {{c1::frameshift}} mutation, so every codon past the change is misread.',
     1),
    (deck, 23, 'cloze',
     'Sickle-cell disease arises from a missense mutation in β-globin that replaces {{c1::glutamate (glutamic acid) with valine}} at position 6.',
     1);

    -- ── Transcription ─────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 24, 'cloze',
     'The enzyme {{c1::RNA polymerase}} carries out transcription, building a complementary copy of a gene from its DNA template.',
     1),
    (deck, 25, 'cloze',
     'RNA polymerase reads the DNA template {{c1::3′→5′}} and synthesizes the new RNA strand {{c1::5′→3′}}.',
     1),
    (deck, 26, 'cloze',
     'Unlike DNA polymerase, RNA polymerase does not require a {{c1::primer}} to initiate RNA synthesis.',
     1),
    (deck, 27, 'cloze',
     'RNA polymerase {{c1::I}} synthesizes most ribosomal RNA (rRNA) within the nucleolus.',
     1),
    (deck, 28, 'cloze',
     'Of the three eukaryotic RNA polymerases, only RNA polymerase {{c1::II}} transcribes protein-coding genes into messenger RNA.',
     1),
    (deck, 29, 'cloze',
     'RNA polymerase {{c1::III}} synthesizes transfer RNA (tRNA) and the 5S ribosomal RNA.',
     1),
    (deck, 30, 'cloze',
     'RNA polymerase II binds a gene''s promoter, which frequently contains a {{c1::TATA box}} recognized by basal transcription factors.',
     1),
    (deck, 31, 'cloze',
     'Before any processing, the primary transcript made by RNA polymerase II is called {{c1::hnRNA (pre-mRNA)}}.',
     1),
    (deck, 32, 'cloze',
     'The DNA strand that RNA polymerase reads to make a transcript is the {{c1::template}} (or {{c1::antisense}}) strand.',
     1);

    -- ── RNA Processing ────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 33, 'cloze',
     'Before translation, a eukaryotic pre-mRNA undergoes three modifications: {{c1::5′ capping}}, {{c2::poly-A tail addition}}, and {{c3::splicing}}.',
     3),
    (deck, 34, 'cloze',
     'The 5′ cap on a eukaryotic mRNA is a molecule of {{c1::7-methylguanosine}}.',
     1),
    (deck, 35, 'cloze',
     'A eukaryotic transcript is capped at its {{c1::5′}} end and gets its poly-A tail at its {{c1::3′}} end.',
     1),
    (deck, 36, 'cloze',
     'The 5′ cap and poly-A tail shield the mRNA from {{c1::degradation}} by exonucleases, and the tail also enables its {{c2::export}} from the nucleus.',
     2),
    (deck, 37, 'cloze',
     'The coding segments kept in mature mRNA are {{c1::exons}}; the noncoding segments removed during processing are {{c1::introns}}.',
     1),
    (deck, 38, 'cloze',
     'The spliceosome stitches neighboring exons together and releases each removed intron as a looped structure called a {{c1::lariat}}.',
     1),
    (deck, 39, 'cloze',
     'Each subunit of the spliceosome pairs proteins with one molecule of {{c1::small nuclear RNA (snRNA)}}.',
     1),
    (deck, 40, 'cloze',
     'A single gene can yield several proteins when {{c1::alternative splicing}} joins its {{c2::exons}} in different combinations.',
     2),
    (deck, 41, 'cloze',
     'A prokaryotic mRNA is {{c1::polycistronic}}, coding for {{c1::several proteins}}, and is never {{c2::spliced}} because these genes lack {{c2::introns}}.',
     2);

    -- ── Translation ───────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'Translation proceeds in three ordered stages: {{c1::initiation}}, {{c1::elongation}}, and {{c1::termination}}.',
     1),
    (deck, 43, 'cloze',
     'The {{c1::small}} ribosomal subunit binds the mRNA template, while the {{c1::large}} subunit binds the tRNAs.',
     1),
    (deck, 44, 'cloze',
     'A prokaryotic ribosome is a {{c1::70S}} particle built from a {{c2::50S}} large subunit and a {{c2::30S}} small subunit (Svedberg values don''t sum).',
     2),
    (deck, 45, 'cloze',
     'A eukaryotic ribosome is an {{c1::80S}} particle built from a {{c2::60S}} large subunit and a {{c2::40S}} small subunit.',
     2),
    (deck, 46, 'cloze',
     'The ribosome''s three tRNA sites: the {{c1::A (aminoacyl)}} site binds the incoming tRNA, the {{c2::P (peptidyl)}} site holds the growing chain, and the {{c3::E (exit)}} site holds the spent tRNA.',
     3),
    (deck, 47, 'cloze',
     'In prokaryotic initiation, the {{c1::30S}} subunit binds the {{c2::Shine-Dalgarno}} sequence and positions {{c3::N-formylmethionine (fMet)}} at the start codon.',
     3),
    (deck, 48, 'cloze',
     'In eukaryotic initiation, the {{c1::40S}} subunit binds the {{c2::5′ cap}}, scans to the start codon, and positions ordinary {{c3::methionine (Met)}}.',
     3),
    (deck, 49, 'cloze',
     'During elongation, {{c1::peptidyl transferase}} joins each amino acid to the chain; because this catalyst is made of {{c2::rRNA}}, it is a {{c2::ribozyme}}.',
     2),
    (deck, 50, 'cloze',
     'In translocation, the ribosome advances {{c1::one codon}} toward the mRNA''s {{c2::3′}} end, shifting each tRNA from the A to the P to the E site.',
     2),
    (deck, 51, 'cloze',
     'In translation, a {{c1::stop (nonsense)}} codon in the A site prompts a {{c2::release factor}} to add a {{c3::water}} molecule, cleaving the finished polypeptide from its tRNA.',
     3),
    (deck, 52, 'cloze',
     '{{c1::Aminoacyl-tRNA synthetase}} charges a tRNA by attaching its specific amino acid, a step powered by {{c2::ATP}}.',
     2),
    (deck, 53, 'cloze',
     'Proteins that cannot fold correctly on their own achieve their proper shape with help from molecular {{c1::chaperones}}.',
     1),
    (deck, 54, 'cloze',
     'Covalent post-translational additions to proteins include {{c1::phosphorylation}}, {{c1::glycosylation}}, {{c1::carboxylation}}, and {{c1::prenylation}}.',
     1);

    -- ── Prokaryotic Gene Expression — Operons ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 55, 'cloze',
     'A bacterial {{c1::operon}} is a cluster of related genes under a single promoter, transcribed together into one {{c2::polycistronic}} mRNA.',
     2),
    (deck, 56, 'cloze',
     'In an operon, RNA polymerase binds the {{c1::promoter}}, whereas the repressor binds the {{c2::operator}} sequence just upstream of the structural genes.',
     2),
    (deck, 57, 'cloze',
     'A repressor is encoded by a separate {{c1::regulator}} gene that has its own promoter and is transcribed independently of the operon.',
     1),
    (deck, 58, 'cloze',
     'The {{c1::Jacob-Monod}} model explains how an operon is switched on or off by regulatory proteins such as repressors and activators binding the DNA.',
     1),
    (deck, 59, 'cloze',
     'An {{c1::inducible}} operon such as lac is off by default and switches on when an {{c1::inducer}} inactivates the repressor, freeing the operator.',
     1),
    (deck, 60, 'cloze',
     'An operon that is transcribed by default but can be shut off in response to a signal, like the trp operon, is termed {{c1::repressible}}.',
     1),
    (deck, 61, 'cloze',
     'In the trp operon, tryptophan is the {{c1::corepressor}}: it activates the protein that binds the operator to block transcription.',
     1),
    (deck, 62, 'cloze',
     'In {{c1::negative}} control a repressor binds DNA to lower transcription, whereas in {{c1::positive}} control an activator binds to raise it.',
     1);

    -- ── Eukaryotic Gene Expression ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 63, 'cloze',
     'Eukaryotic {{c1::transcription factors}} are regulatory proteins that bind DNA to turn a gene''s expression up or down.',
     1),
    (deck, 64, 'cloze',
     'A {{c1::promoter}} lies near the transcription start site (about 25 base pairs upstream), whereas an {{c2::enhancer}} boosts transcription from thousands of base pairs away.',
     2),
    (deck, 65, 'cloze',
     'Specific DNA sequences bound by signal-activated transcription factors to control a target gene''s transcription are called {{c1::response elements}}.',
     1),
    (deck, 66, 'cloze',
     'Histone {{c1::acetylation}} neutralizes the histones'' positive charge, loosening their grip on DNA and opening chromatin for transcription.',
     1),
    (deck, 67, 'cloze',
     'Histone {{c1::deacetylation}} and DNA {{c1::methylation}} compact chromatin and switch the affected genes off.',
     1),
    (deck, 68, 'cloze',
     'Chromatin exists as loosely packed, actively transcribed {{c1::euchromatin}} and tightly packed, silenced {{c1::heterochromatin}}.',
     1),
    (deck, 69, 'cloze',
     'A heritable change in gene expression that leaves the DNA base sequence unchanged is called {{c1::epigenetic}}.',
     1),
    (deck, 70, 'cloze',
     'Noncoding {{c1::miRNA}} and {{c1::siRNA}} silence genes by base-pairing with complementary mRNA, blocking its translation or triggering its degradation — a process called {{c2::RNA interference}}.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 71;
END $$;
