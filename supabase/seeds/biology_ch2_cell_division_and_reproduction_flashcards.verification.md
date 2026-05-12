# Verification Report — Biology Ch 2: Cell Division & Human Reproduction

**Deck:** Cell Division & Human Reproduction
**Source SQL:** supabase/seeds/biology_ch2_cell_division_and_reproduction_flashcards.sql
**Verified:** 2026-05-11
**Corpus:**
- Primary — `reference-textbooks/biology/openstax-biology-2e.txt` (cell cycle Ch 10; meiosis Ch 11; Mendelian genetics Ch 12; sex determination Ch 43)
- Primary — `reference-textbooks/biology/openstax-anatomy-physiology-2e.txt` (reproductive anatomy Ch 27; endocrine axis Ch 17; menstrual cycle Ch 27.2)
- Scope authority — `reference-textbooks/aamc/aamc-content-outline-2026.txt` (Foundation 2C mitosis/meiosis; Foundation 3B reproductive system; Foundation 5C-D endocrine + reproductive hormones)

**.docx provenance:** *Biology Review Chapter Two .docx* (titled "Reproduction") — adapted from Kaplan MCAT review; Source-Laundry rules applied per card. Subtopic ordering re-sequenced from the .docx's three-section structure to a 16-section AAMC Foundations layout. No prose from the .docx survives verbatim. Multiple .docx transcription errors (see "Disagreements with corpus") were silently corrected against textbook sources before becoming cards.

**Bucket caveat:** The deck spans AAMC Foundations 2C (cell-division content) and 3B/5C (reproductive anatomy + endocrine content). It is filed under "Molecular and Cellular Biology" in the Flashcards UI for visual continuity with Biology Ch1 and because the reproductive content here is framed through *gametogenesis* (a cell-level process). Deep organ-system reproductive physiology will live in a future dedicated chapter under a separate bucket.

---

## Summary

- **Total cards:** 61
- **Confidence 5:** 55
- **Confidence 4:** 6
- **Confidence 3:** 0
- **Confidence 2:** 0
- **Confidence 1:** 0
- **Cards flagged for `needs_sme_review`:** 0
- **Cards where corpus contradicts the card:** 0
- **Source-material claims corrected before becoming cards:** 7 *(see Disagreements with corpus)*

---

## Per-card verification

### Subtopic 1 — Cell Cycle Overview

**Card 0**
**Cloze claim:** Four ordered phases (G₁, S, G₂, M); first three = interphase; non-cyclers in G₀.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.2 ("The Cell Cycle").

**Card 1**
**Cloze claim:** G₁ = growth/organelle synthesis; S = DNA replication; G₂ = verification, repair, division prep.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.2.

**Card 2**
**Cloze claim:** Permanently post-mitotic cells (neurons, cardiac myocytes, mature adipocytes) reside in G₀.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.2; OpenStax A&P 2e §3.6.

**Card 3**
**Cloze claim:** GI epithelium / skin epithelium / bone-marrow HSCs cycle rapidly; neurons / cardiac muscle / mature adipocytes are largely post-mitotic.
**Confidence:** 5
**Source:** OpenStax A&P 2e §3.6, §4.2; OpenStax Biology 2e §10.2.

### Subtopic 2 — Cell Cycle Controls

**Card 4**
**Cloze claim:** G₁/S restriction point = commitment-to-cycle transition; passing it commits cell to complete cycle even without further growth-factor signaling.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.3 ("Control of the Cell Cycle").

**Card 5**
**Cloze claim:** p53 guards G₁/S and G₂/M checkpoints; arrests cycle for repair, senescence, or apoptosis.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.3, §10.4.

**Card 6**
**Cloze claim:** Cyclin + CDK → active complex → phosphorylates TFs → drives next phase.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.3.

**Card 7**
**Cloze claim:** TP53 mutation is among the most common cancer drivers; loss of p53 → loss of damage-response checkpoint.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.4 ("Cancer and the Cell Cycle"); OpenStax Microbiology §19.2 (cancer biology).

**Card 8**
**Cloze claim:** Malignant tumors invade and metastasize via blood/lymph.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.4; OpenStax A&P 2e §4.6.

### Subtopic 3 — Mitosis

**Card 9**
**Cloze claim:** Prophase events: condensation, nucleolar disappearance, NE dissolution, centrosome migration, spindle nucleation.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.2 (Mitosis).

**Card 10**
**Cloze claim:** Metaphase: chromosomes on metaphase plate, kinetochore-microtubule attachment.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.2.

**Card 11**
**Cloze claim:** Anaphase: centromere split → sister chromatids to opposite poles via shortening kMTs.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.2.

**Card 12**
**Cloze claim:** Telophase reverses prophase; cytokinesis driven by actin-myosin contractile ring.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.2.

**Card 13**
**Cloze claim:** Mitosis yields two genetically identical diploid (2n = 46) daughter cells.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.2.

### Subtopic 4 — Meiosis vs Mitosis Foundations

**Card 14**
**Cloze claim:** Meiosis = 1 round replication + 2 rounds division → 4 haploid (n = 23) gametes.
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.1 ("The Process of Meiosis").

**Card 15**
**Cloze claim:** Meiosis I = reductional (separates homologs); meiosis II = equational (separates sister chromatids).
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.1.

**Card 16**
**Cloze claim:** Homologs = maternal/paternal copies of same chr (similar genes, different alleles); sister chromatids = identical DNA copies joined at centromere.
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.1.

**Card 17**
**Cloze claim:** Post-S phase human somatic cell: 92 chromatids, 46 chromosomes, 23 homologous pairs.
**Confidence:** 5
**Source:** OpenStax Biology 2e §10.2, §11.1.

### Subtopic 5 — Meiosis I

**Card 18**
**Cloze claim:** Prophase I events: condensation + NE dissolution + spindle reformation + synapsis (homologs pair as tetrads via synaptonemal complex).
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.1.

**Card 19**
**Cloze claim:** Crossing over occurs between non-sister chromatids of homologs at chiasmata; shuffles linked alleles, increases gamete diversity.
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.1; §12.2 (linked genes & recombination).

**Card 20**
**Cloze claim:** Metaphase I: tetrads align on opposite sides of metaphase plate (vs. mitosis: individual chromosomes single-file).
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.1.

**Card 21**
**Cloze claim:** Anaphase I: homologs to opposite poles; centromeres do not split; each chromosome still 2 sister chromatids.
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.1.

**Card 22**
**Cloze claim:** Telophase I yields 2 haploid daughter cells (still duplicated chromosomes); interkinesis precedes meiosis II.
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.1.

### Subtopic 6 — Meiosis II

**Card 23**
**Cloze claim:** Meiosis II runs like mitosis on haploid cells: prophase II → metaphase II → anaphase II (sister chromatids finally separate) → telophase II + cytokinesis.
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.1.

**Card 24**
**Cloze claim:** Meiosis II final outcome: up to 4 genetically unique haploid cells from 1 diploid primary cell.
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.1.

### Subtopic 7 — Genetic Implications

**Card 25**
**Cloze claim:** Mendel's law of segregation = each gamete carries only one allele per gene; mechanism = anaphase I homolog separation.
**Confidence:** 5
**Source:** OpenStax Biology 2e §12.2 ("Characteristics and Traits").
**Notes:** .docx attributed segregation to "disjunction" generically; this card grounds it in the specific anaphase I event.

**Card 26**
**Cloze claim:** Mendel's law of independent assortment = different genes assort independently; mechanism = random metaphase I orientation of homolog pairs, NOT crossing over.
**Confidence:** 5
**Source:** OpenStax Biology 2e §12.2.
**Notes:** .docx incorrectly attributed this law to crossing over; corrected per textbook mechanism.

**Card 27**
**Cloze claim:** Linkage = tendency of nearby genes to co-inherit; closer = more linked = less likely to be separated by crossing over.
**Confidence:** 5
**Source:** OpenStax Biology 2e §12.3 ("Laws of Inheritance" / linked genes).

**Card 28**
**Cloze claim:** Nondisjunction (meiosis I, II, or mitosis) → aneuploidy (abnormal chromosome count).
**Confidence:** 5
**Source:** OpenStax Biology 2e §11.2 ("Sexual Reproduction"); §13.2 (chromosomal disorders).

### Subtopic 8 — Sex Chromosomes & Determination

**Card 29**
**Cloze claim:** 23rd pair determines chromosomal sex; XX female, XY male; ova always X, sperm X or Y → sperm determines offspring sex.
**Confidence:** 5
**Source:** OpenStax Biology 2e §43.3; OpenStax A&P 2e §28.1.

**Card 30**
**Cloze claim:** SRY gene on Y encodes a transcription factor (TDF) → testicular development; default pathway absent SRY = ovarian.
**Confidence:** 5
**Source:** OpenStax A&P 2e §28.1; OpenStax Biology 2e §43.3.

**Card 31**
**Cloze claim:** Males hemizygous for most X-linked genes; X-linked recessives express in any inheriting male; females may be heterozygous carriers.
**Confidence:** 5
**Source:** OpenStax Biology 2e §13.2 (sex-linked inheritance).

**Card 32**
**Cloze claim:** AIS in 46,XY → nonfunctional androgen receptors → testes develop and secrete testosterone but body can't respond → phenotypically female despite XY.
**Confidence:** 4
**Source:** OpenStax A&P 2e §28.1 (sex differentiation disorders). AAMC outline does not name AIS specifically but lists "sex-linked disorders" and developmental anomalies in scope.
**Notes:** Confidence 4 because AIS is at the high end of MCAT scope; user requested inclusion. Mechanism description (receptor defect, testes still form) matches mainstream sources.

### Subtopic 9 — Male Reproductive Anatomy

**Card 33**
**Cloze claim:** Testes = seminiferous tubules (Sertoli cells nurse sperm) + interstitium (Leydig cells make testosterone).
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.1 ("Anatomy and Physiology of the Male Reproductive System").

**Card 34**
**Cloze claim:** Sperm pathway: seminiferous tubules → epididymis → vas deferens → ejaculatory duct → urethra.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.1.

**Card 35**
**Cloze claim:** Three accessory glands: seminal vesicles (fructose, alkaline) + prostate (alkaline) + bulbourethral/Cowper's (preejaculate lubricant).
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.1.

**Card 36**
**Cloze claim:** Sperm + seminal fluid = semen. Testes in scrotum (lower temperature required for spermatogenesis).
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.1.

### Subtopic 10 — Spermatogenesis

**Card 37**
**Cloze claim:** Spermatogenesis stages: spermatogonium (2n) → primary spermatocyte (2n, replicated) → secondary spermatocyte (n, after meiosis I) → spermatid (n, after meiosis II) → spermatozoon.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.1.
**Notes:** Corrects multiple .docx errors: "first mitotic division" → first *meiotic* division (implicit in "after meiosis I"); "secondary spermatozoites" → secondary spermatocytes; "mature spermatocytes" → spermatozoa.

**Card 38**
**Cloze claim:** Spermatogenesis: 4 functional sperm per spermatogonium; continuous from puberty onward.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.1.

**Card 39**
**Cloze claim:** Sperm anatomy: head (genome + acrosome from Golgi) + midpiece (mitochondria for ATP) + tail (flagellum).
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.1.

### Subtopic 11 — Female Reproductive Anatomy

**Card 40**
**Cloze claim:** Ovaries contain thousands of follicles (multilayered sacs that protect/nourish ova); one dominant follicle releases its egg per cycle.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

**Card 41**
**Cloze claim:** Egg pathway: ovary → peritoneal cavity → fallopian tube (ciliated) → uterus → cervix → vagina.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

**Card 42**
**Cloze claim:** External female genitalia (labia, clitoris, etc.) collectively = vulva.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

### Subtopic 12 — Oogenesis

**Card 43**
**Cloze claim:** All oogonia formed during fetal development; no replenishment after birth (contrast with male stem-cell pool).
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2 ("Oogenesis").

**Card 44**
**Cloze claim:** All primary oocytes arrested in prophase I at birth; remain so until ovulation (sometimes decades).
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

**Card 45**
**Cloze claim:** Oogenesis = unequal cytokinesis → 1 ovum + up to 3 polar bodies (which degenerate).
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

**Card 46**
**Cloze claim:** Secondary oocyte arrested in metaphase II; completes meiosis II only upon fertilization.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

**Card 47**
**Cloze claim:** Two layers around ovulated oocyte: zona pellucida (acellular glycoprotein, binds sperm, triggers acrosome reaction) + corona radiata (follicular cells).
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2, §28.1.

### Subtopic 13 — Hypothalamic-Pituitary-Gonadal Axis

**Card 48**
**Cloze claim:** Hypothalamic GnRH → anterior pituitary FSH/LH → gonadal gametes + sex steroids.
**Confidence:** 5
**Source:** OpenStax A&P 2e §17.3; §27.1.

**Card 49**
**Cloze claim:** Male axis: FSH → Sertoli (sperm support); LH → Leydig (testosterone).
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.1.

**Card 50**
**Cloze claim:** Female axis: FSH → follicle development; LH surge → ovulation + corpus luteum conversion.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

**Card 51**
**Cloze claim:** Estrogen (follicles) thickens/vascularizes endometrium; progesterone (corpus luteum) maintains it post-ovulation.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

### Subtopic 14 — The Menstrual Cycle

**Card 52**
**Cloze claim:** Four phases: follicular → ovulation → luteal → menses.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

**Card 53**
**Cloze claim:** Follicular phase mechanism + hormones: low E/P lifts negative feedback → ↑GnRH → ↑FSH/LH → follicle recruitment → estrogen ↑ thickens endometrium and (early on) suppresses GnRH.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2; §17.3.

**Card 54**
**Cloze claim:** Ovulation: estrogen peak flips feedback to positive → LH surge → follicle rupture → ovum released into peritoneal cavity.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

**Card 55**
**Cloze claim:** Luteal phase: corpus luteum → ↑progesterone (+ some estrogen) → maintains endometrium; high steroids negative-feedback on GnRH/FSH/LH (prevents second ovulation).
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

**Card 56**
**Cloze claim:** Menses: if no implantation, corpus luteum degenerates → estrogen + progesterone fall → endometrium sheds; loss of negative feedback lets GnRH rise → next cycle starts.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2.

**Card 57**
**Cloze claim:** Overall feedback logic: negative feedback dominates, briefly flipped to positive feedback at ovulation, then back to negative during luteal phase, then removed during menses.
**Confidence:** 4
**Source:** OpenStax A&P 2e §27.2.
**Notes:** Confidence 4 because the framing (summary of cycle feedback logic in one sentence) is a synthesis card rather than a direct textbook quotation; every component is sourced individually elsewhere in the deck.

### Subtopic 15 — Pregnancy

**Card 58**
**Cloze claim:** Implanting embryo's trophoblast secretes hCG; hCG mimics LH and maintains corpus luteum through 1st trimester.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2 (Pregnancy); §28.2.

**Card 59**
**Cloze claim:** By end of 1st trimester, placenta produces sufficient estrogen/progesterone on its own; corpus luteum atrophies; hCG falls; placenta sustains the remaining pregnancy.
**Confidence:** 4
**Source:** OpenStax A&P 2e §28.2 ("Embryonic Development").
**Notes:** Confidence 4 because "end of first trimester" timing varies slightly across sources (some give ~10 weeks, others ~12). The qualitative claim (placental hormonal takeover, corpus luteum atrophy) is unambiguous.

### Subtopic 16 — Menopause

**Card 60**
**Cloze claim:** Menopause = ovarian insensitivity to FSH/LH → estrogen/progesterone fall → endometrial atrophy + cessation of menstruation; lost negative feedback → FSH/LH rise.
**Confidence:** 5
**Source:** OpenStax A&P 2e §27.2 (final section).

---

## needs_sme_review

*(None — all 61 cards verified at confidence 4 or 5.)*

---

## Disagreements with corpus

Seven source-material claims (from the .docx and/or .apkg) conflicted with the reference textbooks. None became cards as originally written; each was corrected before SQL output.

1. **.docx: "Crossing Over explains Mendel's Second Law of Independent Assortment."**
   - **Issue:** Independent assortment results from *random orientation of homologous chromosome pairs at metaphase I*, not from crossing over. The .docx confuses the *enhancement* of recombination (crossing over) with the *basis* of independent segregation.
   - **Resolution:** Card 26 attributes independent assortment to metaphase I random orientation per OpenStax Biology 2e §12.2. Card 19 covers crossing over separately as a recombination mechanism.

2. **.docx (spermatogenesis): "The first mitotic division will result in haploid secondary spermatozoites."**
   - **Issue:** Two errors: (a) the first division of spermatogenesis is *meiotic*, not mitotic; (b) the post-meiosis-I cells are *secondary spermatocytes*, not "spermatozoites."
   - **Resolution:** Card 37 uses textbook-correct nomenclature per OpenStax A&P 2e §27.1.

3. **.docx: "The spermatids undergo maturation to become mature spermatocytes."**
   - **Issue:** Mature output cells are *spermatozoa*; "spermatocyte" refers to the meiosis-stage cells (primary, secondary), not the final product.
   - **Resolution:** Card 37 ends correctly at *spermatozoa*.

4. **.docx (pregnancy): "first semester / second semester."**
   - **Issue:** Typo for trimester (×2 occurrences).
   - **Resolution:** Cards 58 and 59 use *trimester* per textbook.

5. **.docx (telophase I): "The cells are not haploid. Once amalgam's chromosomes separate, only N chromosomes are found."**
   - **Issue:** Garbled. By the end of telophase I, each daughter cell IS haploid (n) — though chromosomes are still duplicated.
   - **Resolution:** Card 22 states clearly that telophase I produces *haploid* daughter cells with chromosomes still composed of sister chromatids.

6. **.docx (Leydig cells): "The cells of late-degreed testosterone and other male sex hormones."**
   - **Issue:** Garbled (likely OCR error). Should describe Leydig cells secreting testosterone.
   - **Resolution:** Cards 33 and 49 use the corrected wording per OpenStax A&P 2e §27.1.

7. **.docx (general): multiple transcription errors** — "Kynitic cores" → kinetochores, "antiphase" → anaphase, "central mirror" → centromere, "metaphase blade" → metaphase plate, "nuclear memory" → nuclear membrane, "synaptosis" → synapsis, "Surgeon LH" → surge in LH, "metro cycle" → menstrual cycle, "pellicula" → pellucida, "television" → telophase, "interfaced form" → interphase form.
   - **Resolution:** All silently corrected to textbook spellings during rewrite; affects multiple cards across the deck.

---

## Discrepancies between primary and secondary sources

None of concern. Where OpenStax Biology 2e and OpenStax A&P 2e cover overlapping content (e.g., the menstrual cycle), their statements are consistent. Minor timing variations on "end of first trimester" (Card 59) noted but do not affect MCAT-level claims.

---

## Post-verification SME decisions

*(Reserved for future SME / content lead. Each entry should record: card number, decision, rationale, date.)*
