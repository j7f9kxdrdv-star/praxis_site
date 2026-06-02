-- ════════════════════════════════════════════════════════════════════
-- Biology Chapter 12 — Genetics and Evolution
-- ════════════════════════════════════════════════════════════════════
-- Section: biology
-- Topic:   Molecular and Cellular Biology
-- Subtopic slug: genetics_and_evolution
-- Sort order: 12
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--   1.  Genes, Chromosomes, Alleles
--   2.  Genotype, Phenotype, Zygosity
--   3.  Patterns of Dominance
--   4.  Penetrance & Expressivity
--   5.  Mendel''s Laws + Meiosis Correlations
--   6.  Epigenetics + X-Inactivation + Imprinting
--   7.  Point Mutations
--   8.  Chromosomal Mutations
--   9.  Mutation Causes + Consequences
--   10. Genetic Variability + Gene Flow
--   11. Genetic Drift + Inbreeding
--   12. Punnett Squares + Monohybrid + Test Cross
--   13. Dihybrid + Sex-Linked + Gene Mapping
--   14. Hardy-Weinberg
--   15. Natural Selection + Modes + Modern Synthesis
--   16. Speciation + Patterns of Evolution
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Biology 2e (Ch 11 Meiosis; Ch 12 Mendel''s Experiments and
-- Heredity; Ch 13 Modern Understandings of Inheritance; Ch 16 Gene
-- Expression; Ch 17 Biotechnology and Genomics; Ch 18 Evolution and the
-- Origin of Species; Ch 19 Population Genetics), and the AAMC Foundation
-- 1C and 3A content outlines. See companion .verification.md for per-card
-- citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biology'
      AND title IN (
          'Genetics and Evolution',
          'Genetics & Evolution',
          'Biology Review Chapter 12: Genetics and Evolution'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biology',
        'Molecular and Cellular Biology',
        'genetics_and_evolution',
        'Genetics and Evolution',
        'Genes, alleles, and chromosomes; genotype/phenotype and zygosity; patterns of dominance; penetrance and expressivity; Mendel''s laws tied to meiosis; epigenetics and X-inactivation; point and chromosomal mutations; gene pool dynamics, genetic drift, and inbreeding; Punnett squares and crosses (monohybrid, test, dihybrid, sex-linked); gene mapping and recombination; Hardy-Weinberg equilibrium; natural selection and its modes; speciation and patterns of evolution.',
        12
    )
    RETURNING id INTO deck;

    -- ── Genes, Chromosomes, Alleles ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'A {{c1::gene}} is a DNA sequence that codes for a heritable trait and can be passed from one generation to the next.',
     1),
    (deck, 1, 'cloze',
     'A {{c1::chromosome}} is a long stretch of DNA that organizes many genes in a linear sequence, allowing them to be evenly distributed to daughter cells during cell division.',
     1),
    (deck, 2, 'cloze',
     'An {{c1::allele}} is one of the alternative versions of a given gene; humans inherit two alleles per gene — one from each parent.',
     1),
    (deck, 3, 'cloze',
     'The {{c1::locus}} of a gene is its physical position on a specific chromosome; the two members of a chromosome pair are called {{c2::homologs}} and carry the same loci.',
     2);

    -- ── Genotype, Phenotype, Zygosity ────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 4, 'cloze',
     'The {{c1::genotype}} is the specific combination of alleles an individual carries; the {{c1::phenotype}} is the observable expression of that genotype.',
     1),
    (deck, 5, 'cloze',
     'A {{c1::dominant}} allele needs only one copy to be expressed (capital letter); a {{c1::recessive}} allele needs two copies to be expressed (lowercase letter).',
     1),
    (deck, 6, 'cloze',
     'A {{c1::homozygous}} genotype carries two identical alleles at a locus; a {{c1::heterozygous}} genotype carries two different alleles.',
     1),
    (deck, 7, 'cloze',
     'A {{c1::hemizygous}} genotype has only one copy of an allele rather than the usual two — the classic case is {{c2::X-linked}} genes in XY males.',
     2);

    -- ── Patterns of Dominance ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     'In {{c1::complete dominance}}, the heterozygote (Aa) is phenotypically indistinguishable from the dominant homozygote (AA); the dominant allele fully {{c2::masks}} the recessive one.',
     2),
    (deck, 9, 'cloze',
     'In {{c1::codominance}}, both alleles in a heterozygote are {{c2::fully and simultaneously}} expressed; ABO blood type AB is the classic example.',
     2),
    (deck, 10, 'cloze',
     'In {{c1::incomplete dominance}}, the heterozygote shows an {{c2::intermediate}} (blended) phenotype between the two homozygotes; e.g., red × white snapdragons produce pink heterozygotes.',
     2);

    -- ── Penetrance & Expressivity ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 11, 'cloze',
     '{{c1::Penetrance}} is the proportion of individuals carrying a given genotype who actually express the associated {{c2::phenotype}}; it is a population-level measure.',
     2),
    (deck, 12, 'cloze',
     '{{c1::Expressivity}} describes the {{c2::variability}} in phenotype severity among individuals who share the same genotype; constant expressivity gives identical phenotypes, variable expressivity does not.',
     2),
    (deck, 13, 'cloze',
     '{{c1::Huntington''s disease}} demonstrates full penetrance: individuals with ≥{{c2::40}} CAG repeats in the HTT gene will all develop the disease if they live long enough.',
     2);

    -- ── Mendel''s Laws + Meiosis Correlations ────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 14, 'cloze',
     'Mendel''s {{c1::first law (law of segregation)}} states that the two alleles of a gene separate into different gametes during {{c2::meiosis}}, so each gamete carries only one allele per gene.',
     2),
    (deck, 15, 'cloze',
     'The law of segregation corresponds to {{c1::anaphase I}} of meiosis, when homologous chromosomes (and their alleles) physically separate into different cells.',
     1),
    (deck, 16, 'cloze',
     'Mendel''s {{c1::second law (law of independent assortment)}} states that the inheritance of one gene does not influence the inheritance of {{c2::another}} gene located on a different chromosome.',
     2),
    (deck, 17, 'cloze',
     'The law of independent assortment corresponds to {{c1::metaphase I}}, when homologous chromosome pairs align on the metaphase plate in random orientations.',
     1);

    -- ── Epigenetics + X-Inactivation + Imprinting ───────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     '{{c1::Epigenetics}} refers to heritable changes in gene expression that do NOT alter the underlying {{c2::DNA sequence}}.',
     2),
    (deck, 19, 'cloze',
     'Common epigenetic modifications include DNA {{c1::methylation}} (usually silences genes) and histone {{c1::acetylation}} (usually activates genes by loosening chromatin).',
     1),
    (deck, 20, 'cloze',
     'A {{c1::Barr body}} is an inactivated {{c2::X chromosome}} condensed in the nucleus of cells in genotypic females; X-inactivation prevents an overdose of X-linked gene expression.',
     2),
    (deck, 21, 'cloze',
     'In {{c1::genomic imprinting}}, gene expression depends on which {{c2::parent}} contributed the allele; only the maternal or only the paternal copy is expressed at certain loci.',
     2);

    -- ── Point Mutations ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 22, 'cloze',
     'A {{c1::point mutation}} changes a single nucleotide in DNA; because a {{c2::codon}} is a three-nucleotide unit, the effect depends on whether the codon''s amino acid still gets coded correctly.',
     2),
    (deck, 23, 'cloze',
     'A {{c1::silent}} mutation changes a nucleotide but produces the same amino acid; this is possible because of the {{c2::degeneracy (wobble)}} of the genetic code.',
     2),
    (deck, 24, 'cloze',
     'A {{c1::missense}} mutation changes a nucleotide so that a different amino acid is encoded; the resulting protein has one altered residue.',
     1),
    (deck, 25, 'cloze',
     'A {{c1::nonsense}} mutation changes a nucleotide so that an amino acid codon becomes a premature {{c2::stop codon}}, truncating the protein.',
     2),
    (deck, 26, 'cloze',
     'A {{c1::frameshift}} mutation is the {{c2::insertion or deletion}} of nucleotides in a number not divisible by 3; it shifts the reading frame and usually garbles every downstream amino acid.',
     2);

    -- ── Chromosomal Mutations ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 27, 'cloze',
     'A chromosomal {{c1::deletion}} removes a segment of DNA from a chromosome; a chromosomal {{c1::duplication}} copies a segment, producing extra copies in the genome.',
     1),
    (deck, 28, 'cloze',
     'In an {{c1::inversion}} mutation, a segment of DNA is reversed end-to-end within the same chromosome; gene content is preserved but the order is flipped.',
     1),
    (deck, 29, 'cloze',
     'A chromosomal {{c1::insertion}} adds a segment of DNA into a chromosome; a {{c1::translocation}} specifically swaps a segment between two different (non-homologous) chromosomes.',
     1),
    (deck, 30, 'cloze',
     'A {{c1::transposon}} (mobile genetic element) can insert itself into and excise itself from the genome; if it lands inside a coding sequence, it disrupts the gene.',
     1);

    -- ── Mutation Causes + Consequences ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 31, 'cloze',
     'The {{c1::wild-type}} allele is the version of a gene that is considered standard or naturally most common in the population; mutations produce {{c2::mutant}} alleles.',
     2),
    (deck, 32, 'cloze',
     'A {{c1::mutagen}} is any agent — radiation (UV, X-rays), chemicals, or certain viruses — that increases the rate of mutation in DNA.',
     1),
    (deck, 33, 'cloze',
     'An {{c1::advantageous}} mutation gives the organism a selective advantage that may improve its reproductive fitness; a {{c1::deleterious}} mutation harms the organism''s function or survival.',
     1),
    (deck, 34, 'cloze',
     '{{c1::Inborn errors of metabolism}} are deleterious mutations in genes encoding metabolic enzymes (e.g., PKU); they typically follow {{c2::autosomal recessive}} inheritance.',
     2);

    -- ── Genetic Variability + Gene Flow ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
     'The {{c1::gene pool}} of a species is the complete set of all alleles present across every individual; greater diversity in the gene pool improves the species'' ability to {{c2::adapt}}.',
     2),
    (deck, 36, 'cloze',
     '{{c1::Genetic variability}} is essential for evolutionary survival — without it, a species cannot adapt to changing environmental pressures.',
     1),
    (deck, 37, 'cloze',
     '{{c1::Genetic leakage}} (gene flow between species) occurs when individuals of different species mate to produce {{c2::hybrid}} offspring; it can transfer alleles across species boundaries.',
     2);

    -- ── Genetic Drift + Inbreeding ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 38, 'cloze',
     '{{c1::Genetic drift}} is a change in allele frequencies due to random {{c2::chance}} rather than selection; its effect is much more pronounced in {{c3::small}} populations.',
     3),
    (deck, 39, 'cloze',
     'The {{c1::founder effect}} is an extreme case of genetic drift: a small group becomes reproductively isolated, so the new population''s gene pool reflects only the founders'' alleles.',
     1),
    (deck, 40, 'cloze',
     '{{c1::Inbreeding}} (mating between close relatives) increases {{c2::homozygosity}} and exposes rare recessive disease alleles; the resulting drop in population fitness is called inbreeding {{c3::depression}}.',
     3),
    (deck, 41, 'cloze',
     '{{c1::Outbreeding (outcrossing)}} introduces unrelated individuals into a breeding group; it increases {{c2::heterozygosity}} and adds genetic diversity to the gene pool.',
     2);

    -- ── Punnett Squares + Monohybrid + Test Cross ───────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'A {{c1::Punnett square}} predicts genotype and phenotype frequencies in offspring from a cross; the parents are the {{c2::P generation}} and successive offspring are {{c2::F₁, F₂, ...}} (filial) generations.',
     2),
    (deck, 43, 'cloze',
     'A {{c1::monohybrid cross}} tracks the inheritance of a {{c2::single}} gene; crossing two heterozygotes (Aa × Aa) gives a classic 3:1 dominant:recessive phenotype ratio.',
     2),
    (deck, 44, 'cloze',
     'A {{c1::test cross}} (sometimes called a back cross) crosses an individual of unknown genotype with a known {{c2::homozygous recessive}} individual to determine which alleles the unknown carries.',
     2),
    (deck, 45, 'cloze',
     'In a test cross, if all offspring show the dominant phenotype the unknown is likely {{c1::homozygous dominant}}; a 1:1 dominant:recessive ratio means the unknown is {{c1::heterozygous}}.',
     1);

    -- ── Dihybrid + Sex-Linked + Gene Mapping ────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 46, 'cloze',
     'Crossing two individuals heterozygous for two unlinked genes (AaBb × AaBb) produces a {{c1::9:3:3:1}} phenotype ratio in the F₁ offspring.',
     1),
    (deck, 47, 'cloze',
     'Genotypic males are {{c1::hemizygous}} for X-linked genes — they carry only one X — which is why X-linked recessive disorders (e.g., hemophilia, color-blindness) are far more common in {{c2::males}}.',
     2),
    (deck, 48, 'cloze',
     '{{c1::Unlinked}} genes are on different chromosomes (or very far apart on the same chromosome) and assort independently; {{c1::linked}} genes are close together on the same chromosome and tend to be inherited together.',
     1),
    (deck, 49, 'cloze',
     '{{c1::Recombination frequency}} is the percent of offspring in which two alleles have been separated by {{c2::crossing over}}; it increases with the physical distance between the genes.',
     2),
    (deck, 50, 'cloze',
     'One {{c1::map unit (centimorgan, cM)}} of genetic distance corresponds to a {{c2::1%}} recombination frequency between two genes.',
     2);

    -- ── Hardy-Weinberg ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     'Three of the five Hardy-Weinberg criteria are: {{c1::very large}} population (no drift), {{c1::no mutations}} affecting the gene pool, and {{c1::random mating}} (no sexual selection).',
     1),
    (deck, 52, 'cloze',
     'The remaining two Hardy-Weinberg criteria are: {{c1::no migration}} (no gene flow in or out) and {{c1::no natural selection}} (all alleles equally successful).',
     1),
    (deck, 53, 'cloze',
     'In Hardy-Weinberg equilibrium, allele frequencies satisfy {{c1::p + q = 1}}, where {{c2::p}} is the frequency of the dominant allele and {{c2::q}} is the frequency of the recessive allele.',
     2),
    (deck, 54, 'cloze',
     'Genotype frequencies satisfy {{c1::p² + 2pq + q² = 1}}: p² is {{c2::homozygous dominant}}, 2pq is {{c2::heterozygous}}, and q² is {{c2::homozygous recessive}}.',
     2),
    (deck, 55, 'cloze',
     'A population that meets all five criteria is in {{c1::Hardy-Weinberg equilibrium}} and is, by definition, NOT {{c2::evolving}}; deviations from HW are evidence of evolution.',
     2);

    -- ── Natural Selection + Modes + Modern Synthesis ────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 56, 'cloze',
     '{{c1::Natural selection}} ("survival of the fittest") is the process by which heritable traits that improve survival and reproduction become {{c2::more common}} in successive generations.',
     2),
    (deck, 57, 'cloze',
     'Darwin''s three tenets: organisms produce {{c1::more offspring than survive}}; chance variations are {{c1::heritable}}; individuals with favorable variations are {{c1::more likely to reproduce}}, increasing those traits in the population.',
     1),
    (deck, 58, 'cloze',
     'The {{c1::modern synthesis (Neo-Darwinism)}} integrates Darwinian natural selection with Mendelian genetics, framing evolution as changes in {{c2::allele frequencies}} within a population over time.',
     2),
    (deck, 59, 'cloze',
     '{{c1::Differential reproduction}} is the underlying mechanism of natural selection: organisms with favorable mutations leave more {{c2::offspring}}, so their alleles increase in frequency.',
     2),
    (deck, 60, 'cloze',
     '{{c1::Inclusive fitness}} measures success not just by direct offspring count but also by the reproductive success of {{c2::relatives}}, explaining altruistic behavior toward kin.',
     2),
    (deck, 61, 'cloze',
     '{{c1::Punctuated equilibrium}} proposes that species stay morphologically stable for long stretches, with most evolutionary change concentrated in brief {{c2::rapid bursts}}.',
     2),
    (deck, 62, 'cloze',
     '{{c1::Stabilizing}} selection favors intermediate phenotypes; {{c1::directional}} selection shifts the population toward one extreme; {{c1::disruptive}} selection favors both extremes simultaneously.',
     1),
    (deck, 63, 'cloze',
     '{{c1::Adaptive radiation}} is the rapid diversification of one ancestral species into many species, each adapted to a different {{c2::niche}} (a specific habitat with its own resources and predators).',
     2);

    -- ── Speciation + Patterns of Evolution ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 64, 'cloze',
     'A {{c1::species}} is the largest group of organisms that can interbreed to produce {{c2::fertile, viable}} offspring; this is the biological species concept.',
     2),
    (deck, 65, 'cloze',
     '{{c1::Speciation}} is the formation of new species, typically driven by reproductive {{c2::isolation}} that prevents two populations from interbreeding successfully.',
     2),
    (deck, 66, 'cloze',
     '{{c1::Prezygotic}} isolating mechanisms prevent fertilization from happening at all (e.g., habitat or behavioral barriers); {{c1::postzygotic}} mechanisms allow fertilization but produce nonviable or sterile offspring (e.g., mules).',
     1),
    (deck, 67, 'cloze',
     '{{c1::Divergent evolution}} is the development of dissimilar traits in two or more lineages that share a {{c2::common ancestor}}; e.g., mammalian forelimbs adapted for swimming, flying, and grasping.',
     2),
    (deck, 68, 'cloze',
     '{{c1::Parallel evolution}} occurs when related species evolve in similar ways for long periods because they face analogous {{c2::environmental pressures}}.',
     2),
    (deck, 69, 'cloze',
     '{{c1::Convergent evolution}} is the independent development of similar traits in lineages that do NOT share a recent common ancestor; e.g., wings of birds and bats.',
     1),
    (deck, 70, 'cloze',
     'The {{c1::molecular clock}} model uses the accumulated rate of {{c2::neutral mutations}} in homologous DNA or protein sequences to estimate how long ago two species diverged.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 71;
END $$;
