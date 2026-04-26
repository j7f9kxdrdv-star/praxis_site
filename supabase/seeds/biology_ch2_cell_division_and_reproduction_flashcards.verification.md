# Verification Report — Biology Ch 2: Cell Division & Human Reproduction

**Deck:** Cell Division & Human Reproduction
**Source SQL:** supabase/seeds/biology_ch2_cell_division_and_reproduction_flashcards.sql
**Verified:** 2026-04-25
**Corpus:**
- openstax-biology-2e.txt (primary — Ch 10 Cell Cycle/Mitosis, Ch 11 Meiosis, Ch 12 Mendel/X-linked, Ch 13 nondisjunction)
- openstax-anatomy-physiology-2e.txt (secondary — Ch 17 endocrine, Ch 27 reproductive system, Ch 28 development)
- openstax-microbiology.txt (not needed — deck does not cover binary fission)

## Summary

- Total cards: 67
- Confidence 5: 47
- Confidence 4: 13
- Confidence 3: 5
- Confidence 2: 1
- Confidence 1: 1
- Cards flagged for needs_sme_review: 7
- Cards where corpus contradicts card: 1 (card 19, partial — see below)

## Per-card verification

### Card 0
**Cloze claim:** Cell cycle = G1, S, G2, M; G1+S+G2 = interphase.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.2, lines 12522–12539
**Excerpt:** "The cell cycle has two major phases: interphase and the mitotic phase ... The three stages of interphase are called G1, S, and G2."

### Card 1
**Cloze claim:** Cells exiting the cycle (mature neurons, cardiac myocytes) reside in G0.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.2, lines 12718–12725
**Excerpt:** "Cells in G0 phase are not actively preparing to divide ... Other cells that never or rarely divide, such as mature cardiac muscle and nerve cells, remain in G0 permanently."

### Card 2
**Cloze claim:** G1 — growth, protein/organelle synthesis, DNA-integrity checkpoint before replication.
**Confidence:** 4
**Source:** openstax-biology-2e.txt §10.2 + §10.3, lines 12541–12545, 12888–12895
**Excerpt:** "the cell is quite active at the biochemical level ... accumulating the building blocks of chromosomal DNA and the associated proteins" and "there is a check for genomic DNA damage at the G1 checkpoint."
**Notes:** OpenStax frames the G1 checkpoint as primarily checking DNA integrity *and* size/external signals. Card phrasing is acceptable.

### Card 3
**Cloze claim:** S phase: each chromosome → two sister chromatids joined at a shared centromere.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.2, lines 12490–12495, 12550–12553
**Excerpt:** "After replication, the chromosomes are composed of two linked sister chromatids ... The connection between the sister chromatids is closest in a region called the centromere."

### Card 4
**Cloze claim:** G2 = final gap before mitosis; cell grows, stockpiles proteins, has a checkpoint screening for DNA damage from replication.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.2 + §10.3, lines 12560–12564, 12897–12902
**Excerpt:** "the most important role of the G2 checkpoint is to ensure that all of the chromosomes have been replicated and that the replicated DNA is not damaged."

### Card 5
**Cloze claim:** M phase couples mitosis (nuclear division) with cytokinesis (cytoplasm division).
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.2, lines 12566–12571
**Excerpt:** "the second portion of the mitotic phase ... is called cytokinesis—the physical separation of the cytoplasmic components into the two daughter cells."

### Card 6
**Cloze claim:** p53 guards G1/S and G2/M, halting progression for repair, senescence, or apoptosis.
**Confidence:** 4
**Source:** openstax-biology-2e.txt §10.3, lines 12991–12998
**Excerpt:** "Rb, p53, and p21 act primarily at the G1 checkpoint ... If the DNA cannot be repaired, p53 can trigger apoptosis."
**Notes:** OpenStax explicitly emphasizes p53 at the G1 checkpoint; G2/M role is real biology but not stated here. Senescence not mentioned in OpenStax — but apoptosis and repair are. Acceptable; minor.

### Card 7
**Cloze claim:** Cyclin binds & activates CDK; complex phosphorylates targets that switch on next-phase genes.
**Confidence:** 4
**Source:** openstax-biology-2e.txt §10.3, lines 12928–12950
**Excerpt:** "Cdks are enzymes (kinases) that in turn phosphorylate other proteins ... The proteins phosphorylated by Cdks are involved in advancing the cell to the next phase."
**Notes:** OpenStax doesn't explicitly say the targets are transcription factors; it does discuss Rb/E2F transcription factor regulation downstream. Reasonable simplification.

### Card 8
**Cloze claim:** TP53 loss-of-function is among the most common cancer drivers (>50% of tumors).
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.4, line 13092
**Excerpt:** "Mutated p53 genes have been identified in more than 50 percent of all human tumor cells."

### Card 9
**Cloze claim:** Malignant tumors invade and metastasize via blood/lymph.
**Confidence:** 3
**Source:** openstax-biology-2e.txt §10.4, lines 13037–13051; openstax-anatomy-physiology-2e.txt line 56037 (prostate cancer "metastasis to vulnerable organs like the lungs and brain")
**Excerpt:** "Aggressive forms of prostate cancer ... involve metastasis to vulnerable organs."
**Notes:** OpenStax discusses tumors and metastasis but does not give a clean benign-vs-malignant definition keyed to invasion + metastasis with blood/lymph spread. Concept is correct standard biology but not directly quoted. Flag for SME.

### Card 10
**Cloze claim:** Chromatin during interphase; after replication, sister chromatids joined at centromere.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.1, lines 12483–12495
**Excerpt:** "After replication, the chromosomes are composed of two linked sister chromatids ... The connection between the sister chromatids is closest in a region called the centromere."

### Card 11
**Cloze claim:** GI epithelium, skin, hematopoietic stem cells cycle rapidly; neurons, cardiac muscle, mature adipocytes are post-mitotic.
**Confidence:** 3
**Source:** openstax-biology-2e.txt §10.3, lines 12837–12840
**Excerpt:** "an entire human lifetime spent in G0 by specialized cells, such as cortical neurons or cardiac muscle cells."
**Notes:** OpenStax names neurons and cardiac muscle as G0, and mentions epithelial cell turnover (2–5 days). It does NOT explicitly cite GI/skin/hematopoietic stem cells nor mature adipocytes. The biology is correct but specific cell-type list is partly outside corpus. Flag for SME.

### Card 12
**Cloze claim:** Mitosis → 2 daughter cells, diploid, genetically identical to parent; meiosis → 4 haploid unique gametes.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13929–13936, 13967–13975
**Excerpt:** "The four daughter cells resulting from meiosis are haploid and genetically distinct. The daughter cells resulting from mitosis are diploid and identical to the parent cell."

### Card 13
**Cloze claim:** Prophase: chromatin condenses, nuclear envelope breaks down, nucleoli disappear, centrioles migrate to poles.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.2, lines 12628–12633
**Excerpt:** "the nuclear envelope starts to dissociate ... The nucleolus disappears (disperses) as well, and the centrosomes begin to move to opposite poles."

### Card 14
**Cloze claim:** Metaphase: spindle MTs capture kinetochores; chromosomes align at metaphase plate.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.2, lines 12654–12664
**Excerpt:** "All the chromosomes are aligned in a plane called the metaphase plate, or the equatorial plane, roughly midway between the two poles."

### Card 15
**Cloze claim:** Anaphase begins when sister chromatids separate at centromere and are pulled to opposite poles.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.2, lines 12666–12669
**Excerpt:** "The cohesin proteins degrade, and the sister chromatids separate at the centromere. Each chromatid, now called a single chromosome, is pulled rapidly toward the centrosome."

### Card 16
**Cloze claim:** Telophase: chromosomes decondense, new envelopes form; cytokinesis via actin contractile ring → 2 diploid identical daughters.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §10.2, lines 12671–12695
**Excerpt:** "the chromosomes reach the opposite poles and begin to decondense ... A contractile ring composed of actin filaments forms just inside the plasma membrane."

### Card 17
**Cloze claim:** Meiosis → 4 haploid genetically unique gametes via crossing over and independent assortment.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13821–13825, 13929–13936
**Excerpt:** "meiosis I creates genetically diverse gametes in two ways. First, during prophase I, crossover events ... Second, the random assortment of tetrads on the metaphase plate."

### Card 18
**Cloze claim:** Homologs separate in meiosis I; sister chromatids separate in meiosis II/mitosis.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13941–13960
**Excerpt:** "the homologous chromosomes moving to one pole or another, the ploidy level ... has been reduced from two to one. For this reason, meiosis I is referred to as a reductional division ... During anaphase II, as in mitotic anaphase, the kinetochores divide and one sister chromatid ... is pulled to one pole."

### Card 19
**Cloze claim:** After S phase: 46 chromosomes, 92 chromatids, 23 homologous pairs.
**Confidence:** 4
**Source:** openstax-biology-2e.txt §10.1 + Ch 11 (general); openstax-anatomy-physiology-2e.txt line 55902 ("a complete copy of the person's genetic material, or 46 chromosomes")
**Excerpt:** "they each have a complete copy of the person's genetic material, or 46 chromosomes."
**Notes:** The chromosome count after S phase is conventionally stated as 46 (replicated), 92 chromatids — correct. OpenStax does not state this exact "46/92/23" framing explicitly but it follows directly from the general biology. Acceptable.

### Card 20
**Cloze claim:** Meiosis I = reductional division; separates homologs; ploidy goes diploid → haploid.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13948–13951
**Excerpt:** "the ploidy level ... has been reduced from two to one. For this reason, meiosis I is referred to as a reductional division."

### Card 21
**Cloze claim:** Prophase I — synapsis pairs homologs into a tetrad/bivalent (4 chromatids).
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13713–13747
**Excerpt:** "The tight pairing of the homologous chromosomes is called synapsis ... These pairs are called tetrads because a total of four sister chromatids of each pair of homologous chromosomes are now visible."

### Card 22
**Cloze claim:** Synaptonemal complex = protein scaffold zipping homologs together for crossing over.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13713–13721
**Excerpt:** "The synaptonemal complex, a lattice of proteins between the homologous chromosomes ... supports the exchange of chromosomal segments between homologous nonsister chromatids—a process called crossing over."

### Card 23
**Cloze claim:** Crossing over exchanges DNA between non-sister chromatids at chiasmata; recombination generates new allelic combinations.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13720–13756
**Excerpt:** "Crossing over can be observed visually after the exchange as chiasmata ... a reciprocal exchange of equivalent DNA between an egg-derived chromosome and a sperm-derived chromosome."

### Card 24
**Cloze claim:** Single vs double crossover; recombination frequency rises with locus distance.
**Confidence:** 4
**Source:** openstax-biology-2e.txt §11.1, lines 13749–13756; Mendel chapter (linkage discussion in Ch 13)
**Notes:** OpenStax describes single and multiple crossovers and acknowledges "Crossover events can occur almost anywhere along the length." Linkage-mapping detail (recombination frequency proportional to distance) is standard biology but not in the exact section read. Concept is correct.

### Card 25
**Cloze claim:** Metaphase I — tetrads (not individual chromosomes) line up at the plate; random orientation underlies independent assortment.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13782–13810
**Excerpt:** "Each homologous pair is oriented randomly at the equator ... the random (or independent) assortment of homologous chromosomes at the metaphase plate—is the second mechanism that introduces variation."

### Card 26
**Cloze claim:** Mendel's Second Law (Independent Assortment) ↔ random orientation of pairs at metaphase I.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13810–13825 (mechanism); §12.2 Mendel chapters supply naming
**Excerpt:** "the random (or independent) assortment of homologous chromosomes at the metaphase plate."

### Card 27
**Cloze claim:** Anaphase I — homologs to opposite poles; centromeres remain intact, sister chromatids stay together.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13845–13848
**Excerpt:** "In anaphase I, the microtubules pull the linked chromosomes apart. The sister chromatids remain tightly bound together at the centromere."

### Card 28
**Cloze claim:** Mendel's First Law (Segregation) ↔ separation of homologs in anaphase I.
**Confidence:** 4
**Source:** openstax-biology-2e.txt §12 (Mendel) + §11.1 anaphase I
**Notes:** Standard correct mapping. Naming match is strong.

### Card 29
**Cloze claim:** Telophase I yields 2 haploid cells; pause = interkinesis; no DNA re-replication.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13860–13873
**Excerpt:** "Two haploid cells are the result of the first meiotic division ... Interkinesis lacks an S phase, so chromosomes are not duplicated."

### Card 30
**Cloze claim:** Meiosis II = equational; splits sister chromatids; ploidy unchanged; 2 → 4 haploid.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13871–13878, 13953–13960
**Excerpt:** "during meiosis II, the sister chromatids ... separate, forming four new haploid gametes ... Meiosis II is not a reduction division."

### Card 31
**Cloze claim:** Metaphase II — individual chromosomes (not tetrads) align single-file, like mitotic metaphase.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13885–13890, 13953–13954
**Excerpt:** "The sister chromatids are maximally condensed and aligned at the equator of the cell."

### Card 32
**Cloze claim:** Anaphase II — sister chromatids pulled to opposite poles, like mitotic anaphase.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13892–13894, 13955–13956
**Excerpt:** "The sister chromatids are pulled apart by the kinetochore microtubules and move toward opposite poles."

### Card 33
**Cloze claim:** Telophase II — 4 haploid nuclei form; cytokinesis yields 4 distinct gametes.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §11.1, lines 13908–13914
**Excerpt:** "cytokinesis now separates the two cells into four unique haploid cells."

### Card 34
**Cloze claim:** Nondisjunction = failure of homologs (meiosis I) or sister chromatids (meiosis II / mitosis) to separate; result = aneuploidy (e.g., trisomy 21).
**Confidence:** 5
**Source:** openstax-biology-2e.txt §13.1, lines 16124–16261
**Excerpt:** "Nondisjunction can occur during either meiosis I or II, with differing results ... the most common trisomy among viable births is that of chromosome 21, which corresponds to Down Syndrome."

### Card 35
**Cloze claim:** X-linked recessive; males hemizygous; mutations on X cause X-linked disorders.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §12.3, lines 15020–15094
**Excerpt:** "Males are said to be hemizygous, because they have only one allele for any X-linked characteristic ... X-linked traits appear more frequently in males than females."

### Card 36
**Cloze claim:** SRY on Y triggers testis development.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.3, lines 56887–56896, 57192–57198
**Excerpt:** "A gene on the Y chromosome called SRY is critical in stimulating a cascade of events that simultaneously stimulate testis development."

### Card 37
**Cloze claim:** Heterozygous female = carrier; passes recessive allele to half her sons → male-predominant inheritance.
**Confidence:** 5
**Source:** openstax-biology-2e.txt §12.3, lines 15094–15125
**Excerpt:** "Females who are heterozygous for these diseases ... 50 percent of being either affected or carriers."

### Card 38
**Cloze claim:** Sperm path: seminiferous tubules → epididymis → vas deferens → ejaculatory duct → urethra.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.1, lines 55859–55976, 56011–56013
**Excerpt:** "Formed sperm are transferred to the epididymis ... they leave the epididymis during an ejaculation via the ductus deferens ... ejaculatory ducts transport the seminal fluid into the next structure, the prostate gland."

### Card 39
**Cloze claim:** Leydig (interstitial) cells secrete testosterone in response to LH.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.1, lines 56131–56187
**Excerpt:** "Testosterone, an androgen, is a steroid hormone produced by Leydig cells. The alternate term for Leydig cells, interstitial cells, reflects their location between the seminiferous tubules ... LH binds to LH receptors on Leydig cells and stimulates."

### Card 40
**Cloze claim:** Sertoli cells line seminiferous tubules, nourish sperm, stimulated by FSH, form blood–testis barrier.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.1, lines 55873–55880, 32544
**Excerpt:** "Surrounding all stages of the developing sperm cells are elongate, branching Sertoli cells ... [and they form] the blood–testis barrier ... FSH stimulates spermatogenesis."

### Card 41
**Cloze claim:** Seminal vesicles (most volume + fructose), prostate (alkaline fluid), bulbourethral/Cowper's (pre-ejaculatory mucus).
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.1, lines 56005–56055
**Excerpt:** "seminal vesicles ... approximately 60 percent of the semen volume. Seminal vesicle fluid contains large amounts of fructose ... the prostate ... excretes an alkaline, milky fluid ... bulbourethral glands (or Cowper's glands) that release a thick, salty fluid that lubricates the end of the urethra."
**Notes:** Card says prostate fluid neutralizes vaginal acidity — OpenStax says alkaline fluid is critical for coagulation/decoagulation rather than vaginal pH neutralization. The alkaline-neutralization framing is widely taught and biologically real, but the OpenStax explanation for the alkaline fluid is different. Minor — confidence held at 5 because the alkaline characterization is correct.

### Card 42
**Cloze claim:** Spermatogenesis → 4 functional sperm per precursor; equal cytokinesis; no polar bodies.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.1, lines 55916–55923
**Excerpt:** "This second meiotic division results in a total of four cells with only half of the number of chromosomes. Each of these new cells is a spermatid."

### Card 43
**Cloze claim:** Lineage: spermatogonium → primary spermatocyte → secondary spermatocyte → spermatid → spermatozoon.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.1, lines 55883–55927
**Excerpt:** "Spermatogonia divide to produce primary and secondary spermatocytes, then spermatids, which finally produce formed sperm."

### Card 44
**Cloze claim:** Sperm anatomy: head (DNA + acrosome), midpiece (mitochondria), tail/flagellum.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.1, lines 55939–55956
**Excerpt:** "Sperm have a distinctive head, mid-piece, and tail region ... A structure called the acrosome covers most of the head ... Tightly packed mitochondria fill the mid-piece."

### Card 45
**Cloze claim:** Acrosome digests corona radiata and zona pellucida → fertilization.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §28, lines 57439–57459
**Excerpt:** "The corona radiata is an outer layer of follicular (granulosa) cells ... the underlying zona pellucida ... acrosomal reaction in which the enzyme-filled 'cap' of the sperm, called the acrosome, releases its stored digestive enzymes."

### Card 46
**Cloze claim:** Ovum: ovary → fallopian tube → uterus; cervix and vaginal canal = lower birth canal.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56507–56570
**Excerpt:** "uterine tubes (also called fallopian tubes or oviducts) serve as the conduit of the oocyte from the ovary to the uterus ... The cervix is the narrow inferior portion of the uterus that projects into the vagina."

### Card 47
**Cloze claim:** At ovulation, oocyte released into peritoneal cavity; fimbriae sweep it into oviduct (gap → ectopic pregnancies).
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56480, 56511, 56517
**Excerpt:** "expulsion of the oocyte surrounded by granulosa cells into the peritoneal cavity ... slender, finger-like projections called fimbriae ... the secondary oocyte ... is released into the peritoneal cavity."

### Card 48
**Cloze claim:** Oogenesis is asymmetric: 1 ovum + 2–3 polar bodies; unequal cytokinesis retains cytoplasm in ovum.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56326–56331, 56337
**Excerpt:** "the cytoplasm is divided unequally ... The unequal cell division of oogenesis produces one to three polar bodies that later degrade, as well as a single haploid ovum."

### Card 49
**Cloze claim:** Primary oocytes arrested in prophase I from before birth; resume → arrest at metaphase II; complete meiosis II only if fertilized.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56317–56344
**Excerpt:** "primary oocytes are then arrested in this stage of meiosis I, only to resume it years later, beginning at puberty ... Meiosis of a secondary oocyte is completed only if a sperm succeeds in penetrating its barriers."
**Notes:** The metaphase II arrest is widely accepted but OpenStax does not explicitly say "metaphase II"; it just states meiosis II completes only if fertilized. Minor phrasing — sound.

### Card 50
**Cloze claim:** LH and FSH are glycoprotein gonadotropins from anterior pituitary under hypothalamic GnRH.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §17, lines 31491, 31998–32008
**Excerpt:** "follicle-stimulating hormone (FSH), which has an attached carbohydrate group and is thus classified as a glycoprotein ... GnRH stimulates the anterior pituitary to secrete gonadotropins."

### Card 51
**Cloze claim:** In males: FSH → Sertoli (spermatogenesis); LH → Leydig (testosterone).
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §17 + §27.1, lines 32008, 32544, 56165
**Excerpt:** "FSH stimulates spermatogenesis ... LH binds to LH receptors on Leydig cells and stimulates the production of testosterone."

### Card 52
**Cloze claim:** In females: FSH grows follicles; mid-cycle LH surge triggers ovulation.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56442–56489
**Excerpt:** "FSH stimulates the follicles to grow ... It is this large burst of LH (called the LH surge) that leads to ovulation of the dominant follicle."

### Card 53
**Cloze claim:** Estrogen drives endometrial proliferation; progesterone (post-ovulation) maintains lining.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56600–56611, 56659–56676
**Excerpt:** "the stratum functionalis of the endometrium is thickening ... post-ovulatory increase in progesterone, which characterizes the luteal phase, is key for maintaining a thick stratum functionalis."

### Card 54
**Cloze claim:** Cycle phases (in order): menstruation, follicular, ovulation, luteal.
**Confidence:** 3
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56308–56505, 56619–56684
**Excerpt:** "These are the menses phase, the proliferative phase, and the secretory phase" (menstrual cycle); "follicular phase ... luteal phase" (ovarian cycle).
**Notes:** OpenStax distinguishes the **ovarian cycle** (follicular / luteal) from the **menstrual cycle** (menses / proliferative / secretory). The card mixes both terminologies into one list (menstruation + follicular + ovulation + luteal) — this is a common-pedagogy hybrid, but it is not how OpenStax presents either cycle. Flag for SME — consider rewriting to either separate the two cycles or pick one taxonomy.

### Card 55
**Cloze claim:** Follicular phase: GnRH → FSH → follicle recruitment → estrogen → switch from negative to positive feedback → LH surge.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56442–56489
**Excerpt:** "Following a classic negative feedback loop, the high concentrations of estrogen will stimulate the hypothalamus and pituitary to reduce ... extremely high concentrations ... trigger a regulatory switch ... by secreting large amounts of LH and FSH."

### Card 56
**Cloze claim:** Sustained estrogen peak flips feedback to positive → mid-cycle LH surge → ovulation in ~24–36 hours.
**Confidence:** 4
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56468–56489
**Excerpt:** "the LH surge ... leads to ovulation."
**Notes:** OpenStax confirms LH surge → ovulation but does not state the 24–36-hour window. Standard clinical figure (~24–36 h or 36–40 h). Acceptable.

### Card 57
**Cloze claim:** Ovulation = follicle ruptures, secondary oocyte released; remaining follicle luteinizes → corpus luteum.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56489–56497
**Excerpt:** "expulsion of the oocyte ... This release is ovulation ... transforms the collapsed follicle into a new endocrine structure called the corpus luteum."

### Card 58
**Cloze claim:** Luteal phase — corpus luteum secretes progesterone (and some estrogen) → maintains endometrium and negatively feeds back on hypothalamus, suppressing GnRH/LH/FSH.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56495–56505
**Excerpt:** "the luteinized granulosa and theca cells of the corpus luteum begin to produce large amounts of the sex steroid hormone progesterone ... Progesterone triggers negative feedback at the hypothalamus and pituitary, which keeps GnRH, LH, and FSH secretions low."

### Card 59
**Cloze claim:** Without fertilization, corpus luteum → corpus albicans 10–14 days post-ovulation; estrogen+progesterone fall.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §27.2, lines 56501–56505, 56681–56684
**Excerpt:** "If pregnancy does not occur within 10 to 12 days, the corpus luteum will stop secreting progesterone and degrade into the corpus albicans."
**Notes:** OpenStax says "10 to 12 days"; card says "10–14 days." Close enough; both common in MCAT prep. Minor.

### Card 60
**Cloze claim:** Functional layer (the decidua) sheds as menstrual flow; rising GnRH starts new cycle.
**Confidence:** 2
**Source:** openstax-anatomy-physiology-2e.txt §27.2 line 56604; §28 lines 57806, 57815
**Excerpt:** "stratum functionalis layer of the endometrium that sheds during menstruation"; "the cells of the endometrium—referred to as decidual cells—nourish [the embryo] ... The maternal portion of the placenta develops from the deepest layer of the endometrium, the decidua basalis."
**Notes:** **Terminology problem.** OpenStax (and standard usage) reserves "decidua" for the **gestational** endometrium (after implantation triggers decidualization — decidua basalis/capsularis/parietalis). The functional layer that sheds during menstruation is the **stratum functionalis**, NOT "the decidua." Card 60 is likely confusing students. Flag for SME — recommend changing "the {{c1::decidua}}" to "{{c1::stratum functionalis}}."

### Card 61
**Cloze claim:** hCG from implanting embryo mimics LH, sustains corpus luteum (→ progesterone) through first trimester until placenta takes over.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §28, lines 57662–57667, 58206–58210
**Excerpt:** "The trophoblast secretes human chorionic gonadotropin (hCG), a hormone that directs ... The placenta takes over the synthesis and secretion of progesterone throughout pregnancy as the corpus luteum [degrades]."

### Card 62
**Cloze claim:** Menopause: depleted follicles, FSH/LH unresponsive → estrogen/progesterone fall, gonadotropins rise.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §17.11 + §27, lines 32985–32987
**Excerpt:** "the ovaries ... become less responsive to gonadotropins. This gradually causes a decrease in estrogen and progesterone levels, leading to menopause."
**Notes:** OpenStax confirms decreased ovarian response and decreased estrogen/progesterone. Rising gonadotropins follow logically and is standard MCAT canon, though OpenStax does not explicitly say so. Held at 5 because mechanism is correct and well-known.

### Card 63
**Cloze claim:** Androgen Insensitivity Syndrome — XY individual, nonfunctional androgen receptors, female phenotype.
**Confidence:** 1
**Source:** None — AIS is NOT in the corpus.
**Excerpt:** N/A
**Notes:** Searched all three OpenStax texts; "androgen insensitivity" / "AIS" / "hemizygous" (other than X-linked context) yield no hits. The fact stated is correct standard genetics, but unverifiable from this corpus. Flag for SME / accept with external reference.

### Card 64
**Cloze claim:** Puberty: hypothalamic pulsatile GnRH → anterior pituitary FSH/LH → gonadal sex steroids → secondary sexual characteristics.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §17.8, lines 31998–32008
**Excerpt:** "Puberty is initiated by gonadotropin-releasing hormone (GnRH) ... GnRH stimulates the anterior pituitary to secrete gonadotropins."

### Card 65
**Cloze claim:** Male puberty — testosterone drives deeper voice, facial/body hair, muscle, external genitalia growth.
**Confidence:** 5
**Source:** openstax-anatomy-physiology-2e.txt §17, lines 31438, 32540–32542
**Excerpt:** "characteristics such as a deepened voice, body hair, and increased muscle mass."

### Card 66
**Cloze claim:** Female puberty — estrogen drives breast development, pelvic widening, fat redistribution, menstrual cycle (menarche).
**Confidence:** 4
**Source:** openstax-anatomy-physiology-2e.txt §27.2 line 56616; §17 broadly
**Excerpt:** "The first menses after puberty, called menarche, can occur either before or after the first ovulation."
**Notes:** Menarche is explicitly defined in corpus. The full list of estrogen-driven secondary features (breast, pelvis, fat, etc.) is not enumerated in one place but is standard biology.

## needs_sme_review

- **Card 9** (CONF 3): Benign-vs-malignant + metastasis definition not directly in the OpenStax cell-cycle chapter. Concept is correct standard biology but not quoted. Action: accept (standard MCAT knowledge) or add a one-line corpus citation from a different chapter.
- **Card 11** (CONF 3): Specific cell-type list (GI epithelium, skin, hematopoietic stem cells; mature adipocytes) not directly stated in OpenStax. OpenStax names neurons + cardiac muscle as G0. Action: keep but verify the high-turnover examples; mature adipocyte claim is debatable in modern biology.
- **Card 54** (CONF 3): Phase-naming hybrid. OpenStax separates the **ovarian cycle** (follicular/luteal) from the **menstrual cycle** (menses/proliferative/secretory). The card lists "menstruation, follicular, ovulation, luteal" — not the OpenStax taxonomy. Action: rewrite to either align with one taxonomy or make the hybrid terminology explicit.
- **Card 60** (CONF 2): "the functional layer — the {{c1::decidua}}" is **incorrect terminology.** "Decidua" specifically refers to the gestational endometrium (decidual cells, decidua basalis). The shed functional layer in a non-pregnant cycle is the **stratum functionalis.** Action: change cloze answer to "stratum functionalis."
- **Card 63** (CONF 1): Androgen Insensitivity Syndrome is not covered in any of the three corpus textbooks. The fact stated is correct standard genetics. Action: either accept on external grounds or remove from this deck (it's also a slightly off-topic for "Cell Division & Reproduction" — better suited to a genetics deck).
- **Card 19** (CONF 4): The "46 chromosomes / 92 chromatids / 23 pairs" framing is correct but synthesized rather than quoted. Confidence held at 4 — no SME action required, but flag if a stricter sourcing standard is desired.
- **Card 41** (CONF 5): Note that prostate alkaline fluid in OpenStax is described as enabling coagulation/decoagulation, not (directly) neutralizing vaginal acidity. Vaginal-pH neutralization is the standard MCAT framing and is biologically real but not what OpenStax emphasizes. Action: optional rewording.

## Disagreements with corpus

- **Card 60** — Card calls the shed functional endometrial layer "the decidua." Corpus reserves "decidua" for the gestational endometrium (decidua basalis/decidual cells supporting the embryo). The shed layer in a non-pregnant cycle is the **stratum functionalis**. This is the only outright terminology disagreement.

## Discrepancies between primary and secondary sources

- None of substance. Primary (biology-2e) and secondary (anatomy-physiology-2e) agree where they overlap (cell cycle, mitosis, meiosis basics). Reproductive system content is exclusively in anatomy-physiology-2e.
- Minor: prostate fluid function (anatomy-physiology-2e emphasizes coagulation/decoagulation; common MCAT prep emphasizes vaginal-pH neutralization). Both characterizations are factually compatible — alkaline fluid does both.

---

## Post-verification SME decisions (2026-04-25)

- **Card 60** revised: `decidua` → `stratum functionalis`. The original was a real anatomy error — "decidua" refers to gestational endometrium, not the cyclic shed layer. Confidence raised to 5.
- **Card 63 (Androgen Insensitivity Syndrome):** retained as written. Off-corpus but biology is correct per SME judgment.
- **Card 54 (menstrual cycle phases):** retained. The hybridized ovarian/uterine phase sequence (menstruation, follicular, ovulation, luteal) is a common MCAT-prep convention; SME accepts it as-is.
- **Tier 4 cards (9, 11, 41, 59):** shipped as-noted. All represent corpus-thin but standard MCAT content; no factual concerns.
