-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Cell Division & Human Reproduction
-- Section: biology · Topic: Molecular and Cellular Biology
--
-- Coverage: the cell cycle (G₁/S/G₂/M, G₀, interphase,
-- restriction point); cell cycle controls (p53, cyclin/CDK,
-- TP53 mutation in cancer, metastasis); mitosis (prophase →
-- metaphase → anaphase → telophase + cytokinesis); meiosis
-- foundations (reductional vs equational, homologs vs sister
-- chromatids, post-S chromatid/chromosome counts); meiosis I
-- (prophase I synapsis/tetrads/crossing over/chiasmata,
-- metaphase I, anaphase I, telophase I + interkinesis);
-- meiosis II; genetic implications (Mendel's laws of
-- segregation + independent assortment, linkage,
-- nondisjunction → aneuploidy); sex chromosomes & sex
-- determination (XX/XY, SRY gene, hemizygous males, female
-- carriers, androgen insensitivity syndrome); male
-- reproductive anatomy (testes, Sertoli/Leydig, sperm
-- pathway, seminal fluid sources, semen, scrotum);
-- spermatogenesis (stages, four-sperm outcome, sperm
-- anatomy with acrosome); female reproductive anatomy
-- (ovaries + follicles, egg pathway, vulva); oogenesis
-- (fixed oocyte pool, prophase I arrest at birth, ovum +
-- polar bodies via unequal cytokinesis, metaphase II arrest,
-- zona pellucida + corona radiata); the HPG axis (GnRH →
-- FSH/LH; male and female axis specifics; estrogen vs
-- progesterone roles); the menstrual cycle (follicular →
-- ovulation → luteal → menses; feedback logic);
-- pregnancy (hCG, placental takeover at end of 1st trimester);
-- and menopause.
--
-- All cards are CLOZE-format. Cards are ORIGINAL Praxist Prep
-- content — written from the underlying biology and re-sourced
-- from the reference textbooks listed in the companion
-- verification.md file; no prose is lifted from any third-
-- party source.
--
-- Subtopic ordering follows the AAMC content outline
-- (Foundation 2C for cell division/genetics; Foundation 3B
-- for reproductive anatomy; Foundation 5C-D for HPG and
-- menstrual cycle), NOT the source .docx's chapter ordering.
-- The deck spans Foundations 2C and 3B intentionally; the
-- bucket "Molecular and Cellular Biology" keeps Ch1 and Ch2
-- together in the UI, with reproductive-physiology framed
-- through gametogenesis. Deep organ-system physiology of
-- reproduction will live in a future dedicated chapter.
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
           'Cell Division & Human Reproduction',
           'Cell Division and Reproduction',
           'Cell Division & Reproduction',
           'Reproduction',
           'Chapter 2 — Cell Division & Human Reproduction',
           'Chapter 2 — Cell Division and Reproduction',
           'Chapter 2 — Reproduction'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'biology',
    'Molecular and Cellular Biology',
    'cell_division_and_reproduction',
    'Cell Division & Human Reproduction',
    'The cell cycle and its checkpoints, mitosis, meiosis I & II with crossing over and Mendelian implications, nondisjunction and aneuploidy, sex chromosomes and the SRY gene, male and female reproductive anatomy, spermatogenesis and oogenesis, the hypothalamic-pituitary-gonadal axis, the four phases of the menstrual cycle, pregnancy hormonal maintenance, and menopause.',
    2
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. Cell Cycle Overview ───────────────────────────────
  (deck,  0, 'cloze',
   'A dividing cell moves through {{c1::four}} ordered phases — {{c2::G₁}}, {{c2::S}}, {{c2::G₂}}, and {{c2::M}} — with the first three collectively called {{c3::interphase}}. Cells that have exited the cycle and stopped preparing to divide reside in {{c4::G₀}}.', 4),

  (deck,  1, 'cloze',
   'During interphase the cell uses {{c1::G₁}} to grow and stockpile organelles, {{c2::S}} to replicate its DNA, and {{c3::G₂}} to verify replication, repair errors, and prepare for division.', 3),

  (deck,  2, 'cloze',
   'Cells that have permanently exited the cell cycle — neurons, mature cardiac myocytes, mature adipocytes — sit in {{c1::G₀}}, performing their specialized functions without preparing to divide.', 1),

  (deck,  3, 'cloze',
   'Tissues with constant cell turnover — {{c1::gastrointestinal epithelium}}, {{c1::skin epithelium}}, and {{c1::bone-marrow hematopoietic stem cells}} — cycle rapidly through G₁→M. By contrast, {{c2::neurons}}, {{c2::cardiac muscle cells}}, and {{c2::mature adipocytes}} are largely post-mitotic and reside in G₀.', 2),

  -- ── 2. Cell Cycle Controls ───────────────────────────────
  (deck,  4, 'cloze',
   'The {{c1::restriction point}} is the critical transition between G₁ and S phase — once a cell passes it, the cell is committed to completing the cycle even if growth-factor signals are subsequently withdrawn.', 1),

  (deck,  5, 'cloze',
   'The tumor suppressor {{c1::p53}} acts at the {{c2::G₁/S}} and {{c2::G₂/M}} checkpoints, halting cell-cycle progression when DNA damage is detected so the cell can repair, enter senescence, or trigger apoptosis.', 2),

  (deck,  6, 'cloze',
   'Cell-cycle progression requires a {{c1::cyclin}} to bind and activate its matching {{c1::cyclin-dependent kinase (CDK)}}; the active complex phosphorylates {{c2::transcription factors}} that switch on the genes needed for the next phase.', 2),

  (deck,  7, 'cloze',
   'Cancer arises when checkpoint genes lose function — mutations in {{c1::TP53}} (the gene encoding p53) are among the most common drivers because they cripple checkpoint arrest after DNA damage, letting genetically damaged cells continue to divide.', 1),

  (deck,  8, 'cloze',
   'A tumor becomes {{c1::malignant}} once its cells acquire the ability to invade surrounding tissue and {{c2::metastasize}} — to spread via blood or lymph and seed new tumors at distant sites.', 2),

  -- ── 3. Mitosis ───────────────────────────────────────────
  (deck,  9, 'cloze',
   'In {{c1::prophase}}, chromosomes condense, nucleoli disappear, the nuclear envelope dissolves, and the {{c2::centrosomes}} migrate to opposite poles where they nucleate the {{c2::spindle apparatus}} from microtubules.', 2),

  (deck, 10, 'cloze',
   'In {{c1::metaphase}}, condensed chromosomes align along the {{c2::metaphase plate}} — equidistant from the two poles — with spindle microtubules attached to each {{c3::kinetochore}} on the sister-chromatid centromeres.', 3),

  (deck, 11, 'cloze',
   'In {{c1::anaphase}}, centromeres split and the {{c2::sister chromatids}} (now each its own chromosome) are pulled to opposite poles by the shortening of kinetochore microtubules.', 2),

  (deck, 12, 'cloze',
   'In {{c1::telophase}}, chromosomes decondense, nuclear envelopes reform around each set, nucleoli reappear, and the spindle disassembles; {{c2::cytokinesis}} (driven by an actin-myosin contractile ring) then splits the cytoplasm into two daughter cells.', 2),

  (deck, 13, 'cloze',
   'Mitosis yields {{c1::two}} genetically identical {{c2::diploid (2n = 46)}} daughter cells — each carrying a full copy of the parent''s chromosomes.', 2),

  -- ── 4. Meiosis vs Mitosis Foundations ────────────────────
  (deck, 14, 'cloze',
   'Meiosis takes a single diploid germ cell through one round of replication and {{c1::two}} rounds of division, yielding up to {{c2::four}} genetically unique {{c3::haploid (n = 23)}} gametes.', 3),

  (deck, 15, 'cloze',
   'Meiosis I is called the {{c1::reductional}} division because it halves the chromosome number by separating {{c2::homologous chromosomes}}; meiosis II is called the {{c3::equational}} division because — like mitosis — it separates {{c4::sister chromatids}} without further changing ploidy.', 4),

  (deck, 16, 'cloze',
   '{{c1::Homologous chromosomes}} are the maternal and paternal copies of the same chromosome (e.g., maternal chr 15 and paternal chr 15) — similar genes, different alleles. {{c2::Sister chromatids}} are the two identical DNA copies produced by S-phase replication, held together at the {{c3::centromere}}.', 3),

  (deck, 17, 'cloze',
   'After S phase, a human somatic cell contains {{c1::92}} chromatids organized as {{c2::46}} chromosomes — i.e., {{c3::23}} homologous pairs each made of two sister chromatids.', 3),

  -- ── 5. Meiosis I ─────────────────────────────────────────
  (deck, 18, 'cloze',
   'In {{c1::prophase I}}, chromatin condenses, the nuclear envelope dissolves, and the spindle reforms — but uniquely, {{c2::homologous chromosomes}} pair off in a process called {{c3::synapsis}}, producing four-chromatid structures called {{c3::tetrads}} held together by the synaptonemal complex.', 3),

  (deck, 19, 'cloze',
   'During prophase I, non-sister chromatids of paired homologs exchange equivalent segments at contact points called {{c1::chiasmata}} — a process named {{c2::crossing over}} that shuffles linked alleles and increases gamete-to-gamete genetic diversity.', 2),

  (deck, 20, 'cloze',
   'In {{c1::metaphase I}}, homologous chromosome pairs (tetrads) line up on opposite sides of the {{c2::metaphase plate}} — unlike mitosis, where individual chromosomes align single-file.', 2),

  (deck, 21, 'cloze',
   'In {{c1::anaphase I}}, homologous chromosomes are pulled to opposite poles — but centromeres do NOT split, so each pole receives chromosomes still composed of {{c2::two sister chromatids}}.', 2),

  (deck, 22, 'cloze',
   'In {{c1::telophase I}}, a nuclear envelope may reform and cytokinesis produces two {{c2::haploid}} daughter cells (each still containing duplicated chromosomes); a brief rest period called {{c3::interkinesis}} precedes meiosis II.', 3),

  -- ── 6. Meiosis II ────────────────────────────────────────
  (deck, 23, 'cloze',
   'Meiosis II runs essentially like mitosis — but on haploid cells: {{c1::prophase II}} (spindle reforms) → {{c1::metaphase II}} (chromosomes align individually at the plate) → {{c1::anaphase II}} (sister chromatids finally separate) → {{c1::telophase II}} with cytokinesis.', 1),

  (deck, 24, 'cloze',
   'By the end of meiosis II, one diploid primary cell has produced up to {{c1::four}} genetically unique {{c2::haploid}} cells, each ready to mature into a gamete.', 2),

  -- ── 7. Genetic Implications ──────────────────────────────
  (deck, 25, 'cloze',
   'Mendel''s {{c1::law of segregation}} states that the two alleles for a single gene separate during gamete formation so that each gamete carries only one allele — a consequence of {{c2::anaphase I}}, when each homologous chromosome of a pair moves to a different daughter cell.', 2),

  (deck, 26, 'cloze',
   'Mendel''s {{c1::law of independent assortment}} states that alleles for different genes segregate into gametes independently of one another — a consequence of the {{c2::random orientation}} of homologous chromosome pairs at metaphase I, not of crossing over per se.', 2),

  (deck, 27, 'cloze',
   'Genes located close together on the same chromosome tend to be inherited as a unit — a phenomenon called {{c1::linkage}}; the closer two genes are physically, the more likely they are to stay together and the {{c2::less likely}} crossing over will separate them.', 2),

  (deck, 28, 'cloze',
   '{{c1::Nondisjunction}} — the failure of homologs (meiosis I) or sister chromatids (meiosis II or mitosis) to separate properly — produces gametes or cells with abnormal chromosome counts, a condition called {{c2::aneuploidy}}.', 2),

  -- ── 8. Sex Chromosomes & Determination ───────────────────
  (deck, 29, 'cloze',
   'Chromosomal sex is determined by the {{c1::23rd}} chromosome pair — {{c2::XX}} in females, {{c2::XY}} in males. Because ova carry only the {{c3::X}} chromosome and sperm can carry either {{c3::X or Y}}, it is the sperm that determines the chromosomal sex of the offspring.', 3),

  (deck, 30, 'cloze',
   'The {{c1::SRY gene}} on the Y chromosome encodes a transcription factor that drives the indifferent fetal gonad toward testicular development; absent SRY, the default developmental pathway is {{c2::ovarian}}.', 2),

  (deck, 31, 'cloze',
   'Males are {{c1::hemizygous}} for most X-linked genes — they carry only one copy — so an X-linked recessive allele is fully expressed in any male who inherits it. Females, with two X chromosomes, may be heterozygous {{c2::carriers}} who do not express the trait but can pass it to their sons.', 2),

  (deck, 32, 'cloze',
   '{{c1::Androgen insensitivity syndrome (AIS)}} arises in a 46,XY individual whose cells lack functional {{c2::androgen receptors}} — the testes develop and secrete testosterone, but the body cannot respond to it, producing a phenotypically female external appearance despite the XY genotype.', 2),

  -- ── 9. Male Reproductive Anatomy ─────────────────────────
  (deck, 33, 'cloze',
   'Each testis houses two functional compartments: the highly coiled {{c1::seminiferous tubules}}, where sperm are produced and nurtured by {{c2::Sertoli cells}}, and the surrounding {{c1::interstitium}}, where {{c2::Leydig cells}} produce testosterone.', 2),

  (deck, 34, 'cloze',
   'After they are produced, sperm travel: seminiferous tubules → {{c1::epididymis}} (maturation + storage) → {{c1::vas deferens}} → {{c1::ejaculatory duct}} → {{c1::urethra}} → out through the penis at ejaculation.', 1),

  (deck, 35, 'cloze',
   'Seminal fluid is contributed by three accessory glands: the {{c1::seminal vesicles}} (fructose for sperm energy, alkaline buffering), the {{c1::prostate}} (more alkaline secretions to neutralize vaginal acidity), and the {{c1::bulbourethral (Cowper''s) glands}} (clear lubricant that clears the urethra before ejaculation).', 1),

  (deck, 36, 'cloze',
   'The combination of sperm and seminal fluid is called {{c1::semen}}. The testes themselves sit outside the body in the {{c2::scrotum}}, where the slightly lower temperature is required for {{c3::spermatogenesis}} to proceed.', 3),

  -- ── 10. Spermatogenesis ──────────────────────────────────
  (deck, 37, 'cloze',
   'Spermatogenesis proceeds: diploid {{c1::spermatogonia}} → diploid {{c1::primary spermatocytes}} (after DNA replication) → haploid {{c1::secondary spermatocytes}} (after meiosis I) → haploid {{c1::spermatids}} (after meiosis II) → mature {{c1::spermatozoa}}.', 1),

  (deck, 38, 'cloze',
   'Unlike oogenesis, spermatogenesis divides cytoplasm evenly — each spermatogonium ultimately yields {{c1::four}} functional sperm, and the process continues from puberty onward without depletion of the stem-cell pool.', 1),

  (deck, 39, 'cloze',
   'A mature spermatozoon has three regions: a {{c1::head}} containing the genome and capped by the {{c2::acrosome}} (a Golgi-derived enzyme-filled vesicle that digests through the corona radiata and zona pellucida), a {{c1::midpiece}} packed with {{c3::mitochondria}} for ATP, and a flagellar {{c1::tail}} for swimming.', 3),

  -- ── 11. Female Reproductive Anatomy ──────────────────────
  (deck, 40, 'cloze',
   'The {{c1::ovaries}} contain thousands of {{c2::follicles}} — multilayered sacs that enclose, nourish, and protect immature ova until ovulation; one dominant follicle releases its egg per cycle from puberty through menopause.', 2),

  (deck, 41, 'cloze',
   'After ovulation, an ovum travels: ovary → peritoneal cavity → {{c1::fallopian tube (oviduct)}} (ciliated lining propels it forward) → muscular {{c1::uterus}} (potential site of implantation) → {{c1::cervix}} (narrow opening) → {{c1::vagina}}.', 1),

  (deck, 42, 'cloze',
   'The internal female reproductive organs are the ovaries, fallopian tubes, uterus, and vagina; the external genitalia — labia, clitoris, and associated structures — are collectively called the {{c1::vulva}}.', 1),

  -- ── 12. Oogenesis ────────────────────────────────────────
  (deck, 43, 'cloze',
   'Unlike males (who continuously produce sperm from a stem-cell pool), every {{c1::oogonium}} a female will ever have is formed during {{c2::fetal development}}; no new oocytes are generated after birth.', 2),

  (deck, 44, 'cloze',
   'By the time of birth, all of a female''s oogonia have replicated their DNA and arrested as {{c1::primary oocytes}} in {{c2::prophase I}}, where they will wait — sometimes for decades — until ovulation.', 2),

  (deck, 45, 'cloze',
   'Oogenesis divides cytoplasm {{c1::unequally}}: each primary oocyte ultimately produces {{c2::one}} large functional {{c3::ovum}} and {{c2::up to three}} small non-functional {{c3::polar bodies}} that degenerate.', 3),

  (deck, 46, 'cloze',
   'After ovulation, the egg is now a {{c1::secondary oocyte}} arrested in {{c2::metaphase II}}; it completes meiosis II only if a sperm penetrates it — fertilization is what triggers the final division.', 2),

  (deck, 47, 'cloze',
   'An ovulated oocyte is enclosed in two protective layers: the {{c1::zona pellucida}} (an acellular glycoprotein shell that binds sperm and triggers the acrosome reaction) and, surrounding it, the {{c1::corona radiata}} (a halo of follicular cells that remained attached during ovulation).', 1),

  -- ── 13. Hypothalamic-Pituitary-Gonadal Axis ──────────────
  (deck, 48, 'cloze',
   'The hypothalamus releases pulses of {{c1::GnRH}}, which drives the anterior pituitary to release {{c2::FSH}} and {{c2::LH}}; these gonadotropins in turn stimulate the gonads to produce gametes and sex steroids.', 2),

  (deck, 49, 'cloze',
   'In males, {{c1::FSH}} stimulates {{c2::Sertoli cells}} (which nurse developing sperm), and {{c1::LH}} stimulates {{c2::Leydig cells}} (which secrete {{c3::testosterone}} and other androgens).', 3),

  (deck, 50, 'cloze',
   'In females, {{c1::FSH}} drives follicle development, and a midcycle surge of {{c1::LH}} triggers {{c2::ovulation}} and converts the ruptured follicle into the corpus luteum.', 2),

  (deck, 51, 'cloze',
   '{{c1::Estrogen}} (secreted by developing follicles) thickens and vascularizes the endometrium during the follicular phase; {{c2::progesterone}} (secreted by the corpus luteum after ovulation) maintains the thickened endometrium so it can support an embryo if fertilization occurs.', 2),

  -- ── 14. The Menstrual Cycle ──────────────────────────────
  (deck, 52, 'cloze',
   'The menstrual cycle has four phases: {{c1::follicular}} (egg matures, endometrium rebuilds) → {{c1::ovulation}} → {{c1::luteal}} (corpus luteum maintains endometrium) → {{c1::menses}} (endometrium sheds if no pregnancy).', 1),

  (deck, 53, 'cloze',
   'The {{c1::follicular phase}} begins as estrogen and progesterone from the previous cycle bottom out, lifting their negative feedback on the hypothalamus; rising {{c2::GnRH}} stimulates the anterior pituitary to release {{c2::FSH}} and {{c2::LH}}, which together recruit ovarian follicles. The growing follicles secrete estrogen that thickens the {{c3::endometrium}} and — early on — suppresses GnRH via negative feedback.', 3),

  (deck, 54, 'cloze',
   'Late in the follicular phase, estrogen rises to a threshold that flips the hypothalamic feedback from negative to {{c1::positive}}, producing a sharp surge in {{c2::LH}} (and a smaller spike in FSH) that triggers {{c3::ovulation}} — the release of the ovum from the dominant follicle into the peritoneal cavity.', 3),

  (deck, 55, 'cloze',
   'After ovulation, the ruptured follicle becomes the {{c1::corpus luteum}}, which secretes high levels of {{c2::progesterone}} (and some estrogen) to maintain the endometrium. These elevated steroids exert {{c3::negative feedback}} on GnRH, FSH, and LH — preventing a second ovulation in the same cycle.', 3),

  (deck, 56, 'cloze',
   'If implantation does not occur, the corpus luteum loses its LH support and degenerates; falling {{c1::estrogen}} and {{c1::progesterone}} cause the endometrium to slough off as {{c2::menstrual flow}}, and the loss of negative feedback lets {{c3::GnRH}} rise to begin a new cycle.', 3),

  (deck, 57, 'cloze',
   'The cycle''s hormone logic in one line: negative feedback dominates until estrogen peaks late in the follicular phase, briefly flipping to {{c1::positive feedback}} (the LH surge → ovulation), then reverting to negative feedback during the luteal phase, and finally being removed entirely when the corpus luteum degenerates — letting the next cycle start.', 1),

  -- ── 15. Pregnancy ────────────────────────────────────────
  (deck, 58, 'cloze',
   'If fertilization occurs, the implanting embryo''s trophoblast secretes {{c1::human chorionic gonadotropin (hCG)}}, which mimics LH to maintain the {{c2::corpus luteum}} — keeping estrogen and progesterone high enough to preserve the endometrium through the first trimester.', 2),

  (deck, 59, 'cloze',
   'By the end of the {{c1::first trimester}}, the placenta has grown large enough to produce sufficient estrogen and progesterone on its own; the corpus luteum atrophies, hCG levels fall, and the placenta sustains the pregnancy for the remaining ~6 months.', 1),

  -- ── 16. Menopause ────────────────────────────────────────
  (deck, 60, 'cloze',
   '{{c1::Menopause}} occurs when the aging ovaries become unresponsive to FSH and LH; estrogen and progesterone fall, the endometrium atrophies and menstruation stops, and — with negative feedback lost — FSH and {{c2::LH}} blood levels actually rise.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
