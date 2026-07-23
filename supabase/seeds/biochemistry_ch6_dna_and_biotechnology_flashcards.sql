-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 6 — DNA and Biotechnology
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: dna_and_biotechnology
-- Sort order: 6
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--    1. DNA Structure & Nucleotides
--    2. Base Pairing & DNA Properties
--    3. Eukaryotic Chromosome Organization
--    4. DNA Replication — Machinery & Mechanism
--    5. DNA Replication — Leading/Lagging Strands & Finishing
--    6. DNA Repair & Cancer
--    7. Recombinant DNA & Biotechnology
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Biology 2e (Ch 14 DNA Structure and Function, Ch 17 Biotechnology and Genomics)
-- and LibreTexts Biochemistry. Scope: DNA structure/replication/repair/biotechnology
-- only — the genetic code, transcription, and translation are Ch 7. See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'DNA and Biotechnology',
          'DNA & Biotechnology',
          'Biochemistry Review Chapter Six: DNA and Biotechnology'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'dna_and_biotechnology',
        'DNA and Biotechnology',
        'DNA structure and base pairing, eukaryotic chromosome organization, the replication machinery and leading/lagging strands, DNA repair and cancer genes, and the recombinant-DNA toolkit: cloning, restriction enzymes, libraries, PCR, electrophoresis and blotting, sequencing, and gene therapy.',
        6
    )
    RETURNING id INTO deck;

    -- ── DNA Structure & Nucleotides ───────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'A {{c1::nucleoside}} is a nitrogenous base bonded to a five-carbon sugar, with no phosphate group attached.',
     1),
    (deck, 1, 'cloze',
     'Attaching one to three {{c1::phosphate}} groups to a nucleoside converts it into a nucleotide.',
     1),
    (deck, 2, 'cloze',
     'The sugar in DNA is {{c1::deoxyribose}}, whereas RNA contains {{c1::ribose}}.',
     1),
    (deck, 3, 'cloze',
     'DNA''s deoxyribose lacks the hydroxyl (—OH) group that ribose carries on its {{c1::2′}} carbon.',
     1),
    (deck, 4, 'cloze',
     'Purines have a {{c1::two}}-ring structure, whereas pyrimidines have a {{c1::one}}-ring structure.',
     1),
    (deck, 5, 'cloze',
     'The two purines are {{c1::adenine and guanine}}; the three pyrimidines are {{c1::cytosine, thymine, and uracil}}.',
     1),
    (deck, 6, 'cloze',
     'Adjacent nucleotides are joined into the backbone by {{c1::phosphodiester}} bonds, connecting the 3′ carbon of one sugar to the 5′ carbon of the next.',
     1),
    (deck, 7, 'cloze',
     'By convention, a single nucleic-acid strand is written and read in the {{c1::5′→3′}} direction.',
     1),
    (deck, 8, 'cloze',
     'Within a nucleotide, the nitrogenous base attaches to the sugar''s {{c1::1′}} carbon.',
     1),
    (deck, 9, 'cloze',
     'If one DNA strand runs 5′→3′, its complementary partner runs {{c1::3′→5′}}.',
     1);

    -- ── Base Pairing & DNA Properties ─────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
     'In DNA, adenine always pairs with {{c1::thymine}}, and guanine always pairs with {{c2::cytosine}}.',
     2),
    (deck, 11, 'cloze',
     'Because every base pair links one {{c1::purine}} with one {{c1::pyrimidine}}, the double helix keeps a uniform 2-nm diameter.',
     1),
    (deck, 12, 'cloze',
     'In the double helix, an A–T pair is held together by {{c1::two}} hydrogen bonds, while a G–C pair is held by {{c1::three}}.',
     1),
    (deck, 13, 'cloze',
     '{{c1::Chargaff''s}} rules state that double-stranded DNA holds equal amounts of A and T, and of G and C.',
     1),
    (deck, 14, 'cloze',
     'If a double-stranded DNA sample is 30% adenine, then it is {{c1::30}}% thymine, {{c1::20}}% guanine, and {{c1::20}}% cytosine.',
     1),
    (deck, 15, 'cloze',
     'The predominant form of DNA in living cells, {{c1::B-DNA}}, winds as a {{c2::right}}-handed double helix.',
     2),
    (deck, 16, 'cloze',
     'One full turn of the B-DNA helix (3.4 nm long) spans about {{c1::10}} base pairs.',
     1),
    (deck, 17, 'cloze',
     '{{c1::Z-DNA}} is a {{c2::left}}-handed helix that tends to appear in GC-rich or high-salt stretches of DNA.',
     2),
    (deck, 18, 'cloze',
     'Separating the two DNA strands by breaking their hydrogen bonds — using heat, alkaline pH, or urea — is called {{c1::denaturation}}.',
     1),
    (deck, 19, 'cloze',
     'When denatured DNA is cooled, the complementary strands re-form base pairs and restore the duplex — a reversible process called {{c1::reannealing}} or {{c1::renaturation}}.',
     1),
    (deck, 20, 'cloze',
     'DNA''s {{c1::melting temperature (Tm)}} is reached once half of the sample has denatured, and it climbs as {{c2::GC}} content increases.',
     2),
    (deck, 21, 'cloze',
     '{{c1::Hybridization}} is the base-pairing of two complementary single strands, such as a labeled probe binding its target DNA or RNA.',
     1),
    (deck, 22, 'cloze',
     'Besides hydrogen bonds, {{c1::base stacking}} — van der Waals attractions between adjacent aromatic rings — is a major source of double-helix stability.',
     1);

    -- ── Eukaryotic Chromosome Organization ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 23, 'cloze',
     'A human somatic (body) cell contains {{c1::46}} chromosomes ({{c1::23}} homologous pairs).',
     1),
    (deck, 24, 'cloze',
     'Short stretches of DNA coil around a histone {{c1::octamer}} to form the basic unit of DNA packaging, a {{c2::nucleosome}}.',
     2),
    (deck, 25, 'cloze',
     'A nucleosome''s histone octamer is assembled from two copies each of the four core histones: {{c1::H2A, H2B, H3, and H4}}.',
     1),
    (deck, 26, 'cloze',
     'The overall complex of nuclear DNA bound to its histone proteins is called {{c1::chromatin}}.',
     1),
    (deck, 27, 'cloze',
     'Neighboring nucleosomes are joined by linker DNA and clamped by the linker histone {{c1::H1}}, which is not part of the octamer core.',
     1),
    (deck, 28, 'cloze',
     'Densely packed chromatin that is transcriptionally silent is called {{c1::heterochromatin}}, whereas loosely packed, transcriptionally active chromatin is {{c1::euchromatin}}.',
     1),
    (deck, 29, 'cloze',
     'Twisting of the double helix upon itself, so it becomes over- or under-wound relative to its relaxed state, is called {{c1::supercoiling}}.',
     1),
    (deck, 30, 'cloze',
     'The ends of linear chromosomes are capped by {{c1::telomeres}} — repetitive, noncoding DNA (in humans, TTAGGG repeats) that erodes slightly with each round of replication.',
     1),
    (deck, 31, 'cloze',
     'The enzyme {{c1::telomerase}}, which carries its own built-in RNA template, rebuilds chromosome ends to offset their shortening during replication.',
     1),
    (deck, 32, 'cloze',
     'Sister chromatids stay joined at the {{c1::centromere}} until they are pulled apart during {{c2::anaphase}} of mitosis.',
     2),
    (deck, 33, 'cloze',
     'Eukaryotic genomic DNA divides into {{c1::single-copy (unique)}} DNA — most protein-coding genes — and {{c1::repetitive}} DNA — largely noncoding satellite and telomeric sequences.',
     1);

    -- ── DNA Replication — Machinery & Mechanism ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     'The {{c1::Meselson–Stahl}} experiment, using heavy (¹⁵N) versus light (¹⁴N) nitrogen labeling, proved that DNA replication is {{c2::semiconservative}}.',
     2),
    (deck, 35, 'cloze',
     'After one round of replication, each resulting double helix contains one {{c1::original (parental)}} strand paired with one {{c1::newly synthesized}} strand.',
     1),
    (deck, 36, 'cloze',
     'The number of replication origins is {{c1::one}} in a prokaryote''s circular chromosome but {{c1::many}} across a eukaryote''s linear chromosomes.',
     1),
    (deck, 37, 'cloze',
     'Unwinding at an origin produces {{c1::replication forks}} that extend {{c2::bidirectionally}} away from it.',
     2),
    (deck, 38, 'cloze',
     '{{c1::Helicase}} separates the two parental strands at the fork by breaking the hydrogen bonds between paired bases.',
     1),
    (deck, 39, 'cloze',
     '{{c1::Single-stranded binding proteins}} coat the separated template strands to keep them from reforming a double helix.',
     1),
    (deck, 40, 'cloze',
     '{{c1::Topoisomerase}} nicks and reseals the DNA to relieve the supercoiling that accumulates ahead of the advancing fork.',
     1),
    (deck, 41, 'cloze',
     'DNA polymerase reads the template strand {{c1::3′→5′}} while building the new strand {{c1::5′→3′}}.',
     1),
    (deck, 42, 'cloze',
     'DNA polymerase can only attach an incoming nucleotide to a free {{c1::3′-OH}} group.',
     1),
    (deck, 43, 'cloze',
     'Because DNA polymerase needs an existing 3′ end, {{c1::primase}} first lays down a short {{c1::RNA}} starter on the template.',
     1),
    (deck, 44, 'cloze',
     'Each incoming nucleotide arrives as a {{c1::deoxynucleoside triphosphate (dNTP)}}, whose phosphate cleavage supplies the energy for the new phosphodiester bond.',
     1),
    (deck, 45, 'cloze',
     'A ring-shaped {{c1::sliding clamp}} tethers DNA polymerase to the template DNA, greatly increasing its {{c2::processivity}}.',
     2),
    (deck, 46, 'cloze',
     'In eukaryotes, the sliding clamp is specifically named {{c1::PCNA}}.',
     1),
    (deck, 47, 'cloze',
     'The main replicative polymerase in prokaryotes is {{c1::DNA polymerase III}}, while eukaryotes elongate using polymerases {{c2::α, δ, and ε}}.',
     2);

    -- ── DNA Replication — Leading/Lagging Strands & Finishing ─────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 48, 'cloze',
     'Growing continuously toward the replication fork, the {{c1::leading}} strand needs only {{c1::one}} RNA primer for its entire length.',
     1),
    (deck, 49, 'cloze',
     'The strand copied discontinuously, in short stretches laid down away from the replication fork, is the {{c1::lagging}} strand.',
     1),
    (deck, 50, 'cloze',
     'Each short piece of the lagging strand, called an {{c1::Okazaki fragment}}, must be initiated by its own {{c2::primer}}.',
     2),
    (deck, 51, 'cloze',
     'RNA primers are removed and replaced with DNA by {{c1::DNA polymerase I}} in prokaryotes and by {{c2::RNase H}} in eukaryotes.',
     2),
    (deck, 52, 'cloze',
     'Once the RNA primers are replaced with DNA, the nicks left in the sugar-phosphate backbone are sealed by {{c1::DNA ligase}}.',
     1);

    -- ── DNA Repair & Cancer ───────────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 53, 'cloze',
     'During replication, DNA polymerase corrects a mispaired base using its {{c1::3′→5′ exonuclease}} activity.',
     1),
    (deck, 54, 'cloze',
     'Mismatch repair identifies which strand to fix because the newly made daughter strand is transiently {{c1::unmethylated}}, whereas the parental template is {{c1::methylated}}.',
     1),
    (deck, 55, 'cloze',
     'Mismatch repair operates after replication is finished, catching base-pair errors that {{c1::proofreading}} failed to remove.',
     1),
    (deck, 56, 'cloze',
     'Nucleotide excision repair removes lesions that {{c1::distort}} the double helix, classically UV-induced {{c2::thymine}} dimers.',
     2),
    (deck, 57, 'cloze',
     'A hereditary defect in nucleotide excision repair causes {{c1::xeroderma pigmentosum}}, producing extreme UV sensitivity and elevated skin-cancer risk.',
     1),
    (deck, 58, 'cloze',
     'Base excision repair corrects a single faulty base, such as a cytosine that has {{c1::deaminated}} into uracil, which a DNA {{c2::glycosylase}} then cuts out.',
     2),
    (deck, 59, 'cloze',
     'Excising a damaged base leaves an {{c1::apurinic/apyrimidinic (AP)}} site, whose sugar-phosphate backbone is then nicked by an {{c1::AP endonuclease}}.',
     1),
    (deck, 60, 'cloze',
     'A normal gene that promotes cell division is a {{c1::proto-oncogene}}; a gain-of-function mutation converts it into a division-driving {{c1::oncogene}}.',
     1),
    (deck, 61, 'cloze',
     'Genes that act as brakes on cell division or that assist DNA repair are {{c1::tumor-suppressor}} genes; losing their function promotes cancer.',
     1);

    -- ── Recombinant DNA & Biotechnology ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 62, 'cloze',
     'Recombinant DNA is one molecule assembled from DNA of {{c1::two different sources}}, a combination that does not occur naturally.',
     1),
    (deck, 63, 'cloze',
     'Restriction endonucleases (a bacterial defense against foreign DNA) cut the double helix only at short {{c1::palindromic}} recognition sites.',
     1),
    (deck, 64, 'cloze',
     'A staggered, offset cut leaves single-stranded overhangs called {{c1::sticky}} ends, whereas a straight cut across both strands leaves {{c1::blunt}} ends.',
     1),
    (deck, 65, 'cloze',
     'After a restriction enzyme opens the vector, {{c1::DNA ligase}} seals the insert in place by forming {{c2::phosphodiester}} bonds.',
     2),
    (deck, 66, 'cloze',
     'A recombinant plasmid vector carries three parts: an {{c1::origin of replication}}, a {{c1::selectable marker}}, and the {{c1::DNA insert}}.',
     1),
    (deck, 67, 'cloze',
     'A {{c1::genomic}} library holds cloned fragments representing all of an organism''s DNA, both coding and noncoding regions.',
     1),
    (deck, 68, 'cloze',
     'A cDNA library, made by {{c1::reverse transcriptase}} copying mature mRNA, contains {{c2::exons}} but not {{c2::introns}}.',
     2),
    (deck, 69, 'cloze',
     'PCR amplifies DNA by repeating three steps each cycle: {{c1::denaturation}}, {{c1::annealing}}, and {{c1::extension}}.',
     1),
    (deck, 70, 'cloze',
     'PCR uses {{c1::Taq}} polymerase because, unlike ordinary polymerases, it survives the repeated high-temperature denaturation steps without being destroyed.',
     1),
    (deck, 71, 'cloze',
     'In PCR, two short {{c1::primers}} complementary to opposite ends of the target define exactly which stretch of DNA is copied.',
     1),
    (deck, 72, 'cloze',
     'In gel electrophoresis, DNA''s {{c1::negative}} charge drives it through the gel toward the {{c1::positive}} electrode.',
     1),
    (deck, 73, 'cloze',
     'Gel electrophoresis sorts DNA by size: {{c1::smaller}} fragments migrate {{c1::farther}} from the loading well.',
     1),
    (deck, 74, 'cloze',
     'Naming blots by their target molecule: DNA is detected on a {{c1::Southern}} blot, RNA on a {{c1::Northern}} blot, and protein on a {{c1::Western}} blot.',
     1),
    (deck, 75, 'cloze',
     'A Southern blot pinpoints one target sequence by incubating the membrane with a labeled single-stranded {{c1::probe}} that base-pairs only with its complement.',
     1),
    (deck, 76, 'cloze',
     'Sanger sequencing terminates DNA chains with {{c1::dideoxynucleotides}}, which lack the {{c1::3′-OH}} needed to attach the next nucleotide.',
     1),
    (deck, 77, 'cloze',
     'Gene therapy treats an inherited deficiency by delivering a {{c1::functional copy}} of the faulty gene, frequently packaged in a {{c2::viral}} vector.',
     2),
    (deck, 78, 'cloze',
     'A {{c1::transgenic}} mouse has an extra gene added to its genome, while a {{c1::knockout}} mouse has a specific gene deleted or inactivated.',
     1),
    (deck, 79, 'cloze',
     'A {{c1::chimera}} is a single organism whose cells trace back to two genetically distinct lineages.',
     1),
    (deck, 80, 'cloze',
     'An embryonic stem cell is unspecialized and can develop into {{c1::any cell type in the body}} before its fate is fixed.',
     1),
    (deck, 81, 'cloze',
     'Stem-cell developmental potential descends from {{c1::totipotent}} (whole organism, placenta included) to {{c1::pluripotent}} (all three germ layers) to {{c1::multipotent}} (a few related cell types).',
     1);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 82, 'cloze',
     'An {{c1::expression vector}} places a cloned gene downstream of a {{c2::promoter}}, so a host cell transcribes and translates it to make recombinant protein (e.g., human insulin).',
     2),
    (deck, 83, 'cloze',
     'DNA technology''s practical applications span forensics, agriculture, and pharmaceuticals — namely {{c1::DNA fingerprinting, GMO crops, and recombinant protein production}}.',
     1),
    (deck, 84, 'cloze',
     'In {{c1::Hershey–Chase}}, bacteriophage DNA was radiolabeled with {{c2::³²P}} while the protein coat was labeled with {{c2::³⁵S}}; only DNA entered bacteria, identifying it as the genetic material.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 85;
END $$;
