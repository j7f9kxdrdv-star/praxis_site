-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Cell Division & Human Reproduction
-- Section: biology · Topic: Chapter 2 — Cell Division & Human Reproduction
--
-- Coverage: the cell cycle and mitosis, meiosis I & II with
-- recombination and nondisjunction, the male and female
-- reproductive systems, gametogenesis, the menstrual cycle,
-- and hormonal control of reproduction.
--
-- All cards are CLOZE-format. Cards are ORIGINAL Praxist Prep
-- content — written from the underlying concepts, not lifted
-- from any third-party source material.
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
  DELETE FROM flashcard_decks
   WHERE section = 'biology'
     AND title   IN ('Cell Division & Human Reproduction', 'Chapter 2 — Reproduction');

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'biology',
    'Chapter 2 — Cell Division & Human Reproduction',
    'cell_division_and_reproduction',
    'Cell Division & Human Reproduction',
    'The cell cycle, mitosis, meiosis, recombination, nondisjunction, male and female reproductive anatomy, gametogenesis, the menstrual cycle, and endocrine control of reproduction.',
    2
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 2.1 The Cell Cycle & Mitosis ─────────────────────────
  (deck,  0, 'cloze',
   'A dividing cell moves through {{c1::four}} ordered phases — {{c2::G₁}}, {{c2::S}}, {{c2::G₂}}, and {{c2::M}} — with the first three collectively called {{c3::interphase}}.', 3),

  (deck,  1, 'cloze',
   'A cell that has exited the division cycle — such as a mature neuron or cardiac myocyte — sits in {{c1::G₀}}, performing its specialized role without preparing to replicate its DNA.', 1),

  (deck,  2, 'cloze',
   'During the {{c1::G₁ phase}}, the cell grows, synthesizes new proteins and organelles, and passes a checkpoint that verifies its DNA is intact before committing to replication.', 1),

  (deck,  3, 'cloze',
   'In {{c1::S phase}}, each chromosome is duplicated so that it now consists of two {{c2::sister chromatids}} joined at a shared centromere.', 2),

  (deck,  4, 'cloze',
   'The {{c1::G₂ phase}} is the final gap before mitosis; the cell continues to grow, stockpiles the proteins needed for division, and passes a checkpoint that screens for {{c2::DNA damage}} introduced during replication.', 2),

  (deck,  5, 'cloze',
   'The {{c1::M phase}} is where division actually happens — it couples {{c2::mitosis}} (nuclear division) with {{c2::cytokinesis}} (splitting of the cytoplasm).', 2),

  (deck,  6, 'cloze',
   'The tumor suppressor protein {{c1::p53}} guards the {{c2::G₁/S}} and {{c2::G₂/M}} checkpoints, halting progression when DNA damage is detected so the cell can repair, senesce, or undergo apoptosis.', 2),

  (deck,  7, 'cloze',
   'Progression through each checkpoint requires a {{c1::cyclin}} to bind and activate its matching {{c1::cyclin-dependent kinase (CDK)}}; the active complex then phosphorylates {{c2::transcription factors}} that switch on the next wave of cell-cycle genes.', 2),

  (deck,  8, 'cloze',
   'Cancer arises when mutations disable the genes that enforce cell-cycle control — loss-of-function mutations in the {{c1::TP53}} tumor-suppressor gene are among the most common drivers because they cripple checkpoint arrest after DNA damage.', 1),

  (deck,  9, 'cloze',
   'A tumor becomes {{c1::malignant}} rather than benign when its cells acquire the ability to invade surrounding tissue and {{c2::metastasize}} — spreading via blood or lymph to seed new tumors at distant sites.', 2),

  (deck, 10, 'cloze',
   '{{c1::Chromatin}} is the loose DNA–histone complex seen during interphase; after replication it condenses, and each duplicated chromosome appears as a pair of identical {{c2::sister chromatids}} held together at the {{c3::centromere}}.', 3),

  (deck, 11, 'cloze',
   'Tissues that must constantly regenerate — {{c1::gastrointestinal epithelium}}, {{c1::skin epithelium}}, and {{c1::hematopoietic stem cells}} — cycle rapidly, while {{c2::neurons}}, {{c2::cardiac muscle cells}}, and {{c2::mature adipocytes}} are largely post-mitotic and rarely divide.', 2),

  (deck, 12, 'cloze',
   'Mitosis generates {{c1::two}} daughter cells that are {{c2::diploid}} and genetically {{c3::identical}} to the parent — in contrast to meiosis, which produces four haploid, genetically unique gametes.', 3),

  (deck, 13, 'cloze',
   'During {{c1::prophase}}, chromatin condenses into visible chromosomes, the {{c2::nuclear envelope}} breaks down, nucleoli disappear, and {{c3::centrioles}} migrate to opposite poles and nucleate the spindle apparatus.', 3),

  (deck, 14, 'cloze',
   'In {{c1::metaphase}}, spindle microtubules capture each chromosome at its {{c2::kinetochore}} and align the chromosomes along the {{c3::metaphase plate}} at the cell''s equator.', 3),

  (deck, 15, 'cloze',
   '{{c1::Anaphase}} begins when the bonds holding sister chromatids snap at the centromere and each chromatid is pulled toward an opposite pole — so each daughter receives a complete chromosome set.', 1),

  (deck, 16, 'cloze',
   'In {{c1::telophase}}, chromosomes decondense, new nuclear envelopes assemble around each set, and the spindle breaks down; {{c2::cytokinesis}} then pinches the cytoplasm via a contractile ring of actin, producing two genetically identical {{c3::diploid}} daughter cells.', 3),

  -- ── 2.2 Meiosis ──────────────────────────────────────────
  (deck, 17, 'cloze',
   'Meiosis converts one diploid germ cell into {{c1::four}} {{c2::haploid}} gametes that are genetically {{c3::unique}} — a consequence of crossing over and independent assortment.', 3),

  (deck, 18, 'cloze',
   '{{c1::Homologous chromosomes}} are the maternal and paternal copies of the same chromosome (e.g., maternal chromosome 15 and paternal chromosome 15) and separate during {{c2::meiosis I}}; {{c1::sister chromatids}} are identical copies joined at the {{c3::centromere}} and separate during {{c2::meiosis II}} or mitosis.', 3),

  (deck, 19, 'cloze',
   'Once a human cell finishes S phase it contains {{c1::46 chromosomes}}, {{c1::92 chromatids}}, and {{c1::23 homologous pairs}} — ready to enter either mitosis or meiosis I.', 1),

  (deck, 20, 'cloze',
   '{{c1::Meiosis I}} is the reductional division: it separates {{c2::homologous chromosomes}}, so each daughter cell leaves with {{c3::half}} the original chromosome number and ploidy drops from diploid to haploid.', 3),

  (deck, 21, 'cloze',
   'During {{c1::prophase I}}, homologous chromosomes pair up along their length in a process called {{c2::synapsis}}, forming a four-chromatid structure known as a {{c3::tetrad}} (or bivalent).', 3),

  (deck, 22, 'cloze',
   'The {{c1::synaptonemal complex}} is the protein scaffold that zips homologous chromosomes together during prophase I, holding them in precise alignment so that {{c2::crossing over}} can occur between aligned regions.', 2),

  (deck, 23, 'cloze',
   'Crossing over exchanges DNA between non-sister chromatids at contact points called {{c1::chiasmata}}; this is how {{c2::recombination}} generates new combinations of maternal and paternal alleles on the same chromosome.', 2),

  (deck, 24, 'cloze',
   'A {{c1::single crossover}} swaps one segment between non-sister chromatids, while a {{c2::double crossover}} swaps two — the farther apart two loci sit on a chromosome, the greater the chance a crossover falls between them and the {{c3::higher}} their observed recombination frequency.', 3),

  (deck, 25, 'cloze',
   'In {{c1::metaphase I}}, tetrads — not individual chromosomes — line up at the metaphase plate, and the {{c2::random orientation}} of each homologous pair provides the physical basis for independent assortment.', 2),

  (deck, 26, 'cloze',
   '{{c1::Mendel''s Second Law (Independent Assortment)}} states that the alleles of different genes sort into gametes independently of one another, a physical consequence of how homologous pairs orient {{c2::randomly}} at the metaphase I plate.', 2),

  (deck, 27, 'cloze',
   'In {{c1::anaphase I}}, homologous chromosomes are pulled to opposite poles while the {{c2::centromeres remain intact}} — sister chromatids stay joined and travel together as a unit.', 2),

  (deck, 28, 'cloze',
   '{{c1::Mendel''s First Law (Segregation)}} states that the two alleles at a gene locus separate into different gametes, which physically corresponds to the separation of {{c2::homologous chromosomes}} during anaphase I.', 2),

  (deck, 29, 'cloze',
   'Telophase I produces {{c1::two haploid}} daughter cells whose chromosomes may or may not decondense; the brief pause that follows is called {{c2::interkinesis}}, and notably, DNA is {{c3::not}} re-replicated before meiosis II begins.', 3),

  (deck, 30, 'cloze',
   '{{c1::Meiosis II}} is the equational division: it splits {{c2::sister chromatids}} apart without changing ploidy, so the two haploid cells entering meiosis II become {{c3::four}} haploid gametes.', 3),

  (deck, 31, 'cloze',
   'In {{c1::metaphase II}}, individual chromosomes — not tetrads — align single-file at the metaphase plate, exactly as they do in mitotic metaphase.', 1),

  (deck, 32, 'cloze',
   '{{c1::Anaphase II}} mirrors mitotic anaphase: the centromeres finally release, and {{c2::sister chromatids}} are pulled to opposite poles as independent chromosomes.', 2),

  (deck, 33, 'cloze',
   'Telophase II finishes with nuclear envelopes reforming around each of the {{c1::four}} haploid nuclei; cytokinesis then completes division, producing four genetically distinct {{c2::gametes}}.', 2),

  (deck, 34, 'cloze',
   '{{c1::Nondisjunction}} is the failure of homologs (in meiosis I) or sister chromatids (in meiosis II or mitosis) to separate correctly; the resulting gametes carry an abnormal chromosome count and produce {{c2::aneuploid}} offspring such as trisomy 21.', 2),

  -- ── 2.3 The Reproductive System ──────────────────────────
  (deck, 35, 'cloze',
   'The X chromosome carries many genes unrelated to sex determination, so mutations on it produce {{c1::X-linked (sex-linked)}} disorders; because males carry only one X, they are termed {{c2::hemizygous}} and express X-linked recessive traits whenever they inherit the allele.', 2),

  (deck, 36, 'cloze',
   'The Y chromosome is largely gene-poor but carries the {{c1::SRY}} gene, whose product drives the undifferentiated gonad to develop into a {{c2::testis}} and initiates the male developmental cascade.', 2),

  (deck, 37, 'cloze',
   'A heterozygous female who carries one recessive X-linked disease allele is a {{c1::carrier}} — unaffected herself but able to pass the allele to {{c2::half}} of her sons, which explains the male-predominant inheritance pattern of X-linked recessive disorders.', 2),

  (deck, 38, 'cloze',
   'Sperm travel from their site of production in the {{c1::seminiferous tubules}} of the testis, mature in the {{c2::epididymis}}, then pass through the {{c2::vas deferens}} and {{c2::ejaculatory duct}} before exiting via the {{c2::urethra}}.', 2),

  (deck, 39, 'cloze',
   'The {{c1::interstitial cells of Leydig}} sit between the seminiferous tubules and secrete {{c2::testosterone}} in response to pituitary LH.', 2),

  (deck, 40, 'cloze',
   '{{c1::Sertoli cells}} line the seminiferous tubules and nourish developing sperm; they are stimulated by {{c2::FSH}} and form the blood–testis barrier that shields gametes from the immune system.', 2),

  (deck, 41, 'cloze',
   'Semen is assembled from secretions of three accessory glands: the {{c1::seminal vesicles}} contribute most of the fluid volume along with fructose to fuel sperm, the {{c1::prostate gland}} adds alkaline fluid to neutralize vaginal acidity, and the {{c1::bulbourethral (Cowper''s) glands}} release a pre-ejaculatory mucus that lubricates the urethra.', 1),

  (deck, 42, 'cloze',
   '{{c1::Spermatogenesis}} produces {{c2::four}} functional sperm from each precursor cell; unlike oogenesis, cytokinesis is equal and there are no polar bodies.', 2),

  (deck, 43, 'cloze',
   'The spermatogenic lineage progresses as {{c1::spermatogonium}} → {{c1::primary spermatocyte}} → {{c1::secondary spermatocyte}} → {{c1::spermatid}} → {{c1::spermatozoon}}, with meiosis I completed between primary and secondary spermatocyte and meiosis II completed before the spermatid stage.', 1),

  (deck, 44, 'cloze',
   'A mature sperm has three regions: the {{c1::head}}, packed with condensed DNA and capped by an enzyme-filled {{c2::acrosome}}; the {{c1::midpiece}}, loaded with {{c3::mitochondria}} that power motility; and the {{c1::tail (flagellum)}}, which propels the cell.', 3),

  (deck, 45, 'cloze',
   'The {{c1::acrosome}} carries hydrolytic enzymes that digest the {{c2::corona radiata}} and {{c2::zona pellucida}} surrounding the ovum, permitting sperm penetration and fertilization.', 2),

  (deck, 46, 'cloze',
   'A released ovum is swept from the {{c1::ovary}} into the {{c2::fallopian tube}} (oviduct), where fertilization typically occurs; the resulting embryo then travels to the {{c3::uterus}} for implantation, with the {{c4::cervix}} and {{c4::vaginal canal}} forming the lower birth canal.', 4),

  (deck, 47, 'cloze',
   'At ovulation the secondary oocyte is released not directly into the fallopian tube but into the {{c1::peritoneal cavity}}, and the finger-like {{c2::fimbriae}} of the oviduct then sweep it into the tube — a gap that explains rare ectopic pregnancies.', 2),

  (deck, 48, 'cloze',
   'Oogenesis is asymmetric: each primary oocyte yields just {{c1::one}} functional ovum and two or three {{c2::polar bodies}}, because cytokinesis is unequal and almost all the cytoplasm is retained by the ovum.', 2),

  (deck, 49, 'cloze',
   'Primary oocytes are arrested in {{c1::prophase I}} from before birth until just before ovulation; each cycle a selected follicle resumes meiosis and its oocyte re-arrests in {{c2::metaphase II}}, only completing meiosis II if {{c3::fertilization}} occurs.', 3),

  (deck, 50, 'cloze',
   'Both {{c1::LH (luteinizing hormone)}} and {{c1::FSH (follicle-stimulating hormone)}} are glycoprotein gonadotropins secreted by the {{c2::anterior pituitary}} under hypothalamic GnRH control.', 2),

  (deck, 51, 'cloze',
   'In males, {{c1::FSH}} acts on Sertoli cells to support {{c2::spermatogenesis}}, while {{c1::LH}} acts on Leydig cells to drive {{c2::testosterone}} production.', 2),

  (deck, 52, 'cloze',
   'In females, {{c1::FSH}} stimulates growth of ovarian follicles, while the mid-cycle {{c2::LH}} surge triggers {{c3::ovulation}} of the dominant follicle.', 3),

  (deck, 53, 'cloze',
   '{{c1::Estrogen}} drives proliferation and thickening of the endometrium in the first half of the cycle, while {{c2::progesterone}} — released after ovulation — stabilizes and maintains that lining in preparation for possible implantation.', 2),

  (deck, 54, 'cloze',
   'A single menstrual cycle passes through four phases in order: {{c1::menstruation}}, {{c1::follicular}}, {{c1::ovulation}}, and {{c1::luteal}} — driven by tightly coordinated changes in FSH, LH, estrogen, and progesterone.', 1),

  (deck, 55, 'cloze',
   'During the {{c1::follicular phase}}, rising GnRH drives {{c2::FSH}} release, which recruits ovarian follicles; growing follicles secrete {{c3::estrogen}} that first suppresses then — once high enough — flips to positive feedback, setting the stage for the LH surge.', 3),

  (deck, 56, 'cloze',
   'Late in the follicular phase, a sustained peak in {{c1::estrogen}} switches feedback from negative to positive, producing the mid-cycle {{c2::LH surge}} that induces ovulation within roughly 24–36 hours.', 2),

  (deck, 57, 'cloze',
   'Ovulation is the rupture of the dominant follicle and release of a {{c1::secondary oocyte}}; the empty follicle left behind on the ovary luteinizes and becomes the {{c2::corpus luteum}}.', 2),

  (deck, 58, 'cloze',
   'During the {{c1::luteal phase}}, the corpus luteum secretes {{c2::progesterone}} (and some estrogen) that maintains the endometrium and exerts negative feedback on the hypothalamus, suppressing {{c3::GnRH}}, LH, and FSH to prevent a second ovulation.', 3),

  (deck, 59, 'cloze',
   'If fertilization does not occur, the corpus luteum regresses into the {{c1::corpus albicans}} about 10–14 days after ovulation, and the sharp drop in {{c2::estrogen}} and {{c2::progesterone}} removes the support that was holding up the endometrium.', 2),

  (deck, 60, 'cloze',
   'Once progesterone and estrogen fall, the spiral arteries of the endometrium constrict and the functional layer — the {{c1::stratum functionalis}} — sheds as {{c2::menstrual flow}}, while withdrawal of negative feedback lets {{c3::GnRH}} rise and a new cycle begins.', 3),

  (deck, 61, 'cloze',
   'If fertilization occurs, the implanting embryo secretes {{c1::hCG (human chorionic gonadotropin)}}, which mimics LH to keep the {{c2::corpus luteum}} alive and progesterone flowing through the first trimester until the {{c3::placenta}} takes over hormone production.', 3),

  (deck, 62, 'cloze',
   'At {{c1::menopause}}, depleted ovarian follicles stop responding to {{c2::FSH}} and {{c2::LH}}, so estrogen and progesterone fall, negative feedback is lost, and gonadotropin levels consequently {{c3::rise}} — the biochemical signature of post-menopausal status.', 3),

  (deck, 63, 'cloze',
   '{{c1::Androgen insensitivity syndrome}} arises in an {{c2::XY}} individual whose cells lack functional androgen receptors; testes form and secrete testosterone, but target tissues cannot respond, so the external phenotype is {{c3::female}}.', 3),

  (deck, 64, 'cloze',
   'At {{c1::puberty}}, the hypothalamus ramps up pulsatile release of {{c2::GnRH}}, which triggers anterior-pituitary release of {{c3::FSH}} and {{c3::LH}}; these in turn drive gonadal output of sex steroids that produce the secondary sexual characteristics.', 3),

  (deck, 65, 'cloze',
   'In males, rising {{c1::testosterone}} at puberty produces the secondary sex characteristics — deepening of the voice, facial and body hair, increased muscle mass, and growth of the external genitalia.', 1),

  (deck, 66, 'cloze',
   'In females, rising {{c1::estrogen}} at puberty triggers breast development, widening of the pelvis, redistribution of body fat, and initiation of the menstrual cycle — an event specifically called {{c2::menarche}}.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;

-- ============================================================
-- Companion one-liner: align Chapter 1's topic column to the
-- new "Chapter N — Title" convention so Ch1 and Ch2 group
-- consistently in the Flashcards UI. Safe to run more than once.
-- ============================================================
UPDATE flashcard_decks
   SET topic = 'Chapter 1 — Cell Architecture, Microbes & Viruses'
 WHERE section = 'biology'
   AND title   = 'Cell Architecture, Microbes & Viruses';
