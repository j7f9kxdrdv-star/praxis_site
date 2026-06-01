# Verification Report — Amino Acids (reference deck)

**Deck:** Amino Acids
**Source SQL:** supabase/seeds/amino_acids_flashcards.sql
**Verified:** 2026-05-31
**Corpus:**
- Primary — `reference-textbooks/biochemistry/libretexts-biochemistry.txt` (amino acid structures, side-chain classification, pKa values, special features)
- Scope authority — `reference-textbooks/aamc/aamc-content-outline-2026.txt` (Foundation 1A "Structure and Function of Proteins and Their Constituent Amino Acids")

**Source provenance:** Built from a user-supplied .apkg containing 19 structure images (extracted from the .apkg's media archive) plus one additional Glycine structure sourced from Wikimedia Commons (public-domain skeletal SVG). The user's original .apkg contributed only the images plus a sketch of side-chain classification cards; all card prose is original Praxist Prep content written from biochemistry textbook references. The deck deviates from the v6 prompt's "text-only" rule by design — the AA structure images are essential pedagogy for this content and are referenced via inline `<img src="...">` tags that the cloze renderer (`lib/flashcards/cloze.ts`) parses into image segments.

**Section status:** This deck is filed under the new `amino_acids` top-level section added in migration `20260511_add_amino_acids_section.sql`. The Flashcards UI's `SECTIONS` array was updated in `app/dashboard/flashcards/page.tsx` to surface it as its own subject row.

**Renderer change:** Image rendering required a focused addition to the cloze renderer. The change extends `ClozeSegment` with an `"image"` variant, has `renderClozeSegments` parse inline `<img src="..." alt="...">` tags into image segments, and updates the JSX renderers in `app/dashboard/flashcards/session/page.tsx` and `app/dashboard/flashcards/[deckId]/study/page.tsx` to mount images as real `<img>` elements rather than emitting raw HTML strings.

---

## Summary

- **Total cards:** 43
- **Confidence 5:** 38
- **Confidence 4:** 5
- **Confidence 3:** 0
- **Confidence 2:** 0
- **Confidence 1:** 0
- **Cards flagged for `needs_sme_review`:** 0
- **Cards where corpus contradicts the card:** 0
- **Cards added beyond the source .apkg:** 19 (backbone intro, tyrosine cross-classification, all special-features cards, all pKa cards, hydrophobicity cards) plus 1 missing identification card (Glycine)

---

## Per-card verification

### Subtopic 1 — Amino Acid Backbone

**Card 0**
**Cloze claim:** Generic AA structure — α-carbon bonded to amino group, carboxyl group, hydrogen, R group.
**Confidence:** 5
**Source:** LibreTexts Biochemistry, "Amino Acids" introduction; AAMC outline Foundation 1A.

**Card 1**
**Cloze claim:** Proteinogenic AAs are L-configured at α-carbon except glycine, which is achiral.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; standard biochemistry result.

### Subtopic 2 — Identification: Nonpolar Nonaromatic (Cards 2–8)

**Cards 2–8** (Glycine, Alanine, Valine, Leucine, Isoleucine, Methionine, Proline)
**Cloze claim per card:** Name + three-letter abbreviation + one-letter code, with side-chain structure image.
**Confidence:** 5 (each)
**Source:** LibreTexts Biochemistry, standard amino acid identification chart; abbreviations per IUPAC-IUBMB convention.
**Notes:** Glycine added (not in original .apkg). Isoleucine "Ile/I" corrected from the .apkg's "lle/l" typo.

### Subtopic 3 — Identification: Aromatic (Cards 9–11)

**Cards 9–11** (Phenylalanine, Tryptophan, Tyrosine)
**Cloze claim per card:** Name + three-letter + one-letter, with structure image.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Subtopic 4 — Identification: Polar Uncharged (Cards 12–16)

**Cards 12–16** (Serine, Threonine, Cysteine, Asparagine, Glutamine)
**Cloze claim per card:** Name + abbreviations, with structure image.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Subtopic 5 — Identification: Acidic (Cards 17–18)

**Cards 17–18** (Aspartate, Glutamate)
**Cloze claim per card:** Name (acid and conjugate-base forms) + abbreviations, with structure image.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.
**Notes:** Both common-name conventions included ("Aspartate / Aspartic Acid") since MCAT testing uses both.

### Subtopic 6 — Identification: Basic (Cards 19–21)

**Cards 19–21** (Lysine, Arginine, Histidine)
**Cloze claim per card:** Name + abbreviations, with structure image.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Subtopic 7 — Side-Chain Classification

**Card 22**
**Cloze claim:** Nonpolar nonaromatic set: Gly, Ala, Val, Leu, Ile, Met, Pro.
**Confidence:** 5
**Source:** LibreTexts Biochemistry, side-chain classification.

**Card 23**
**Cloze claim:** Aromatic set (Phe, Tyr, Trp) absorbing UV near 280 nm.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

**Card 24**
**Cloze claim:** Polar uncharged set: Ser, Thr, Asn, Gln, Cys.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

**Card 25**
**Cloze claim:** Acidic set (Asp, Glu) negatively charged at physiological pH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

**Card 26**
**Cloze claim:** Basic set (Lys, Arg, His) positively charged at physiological pH.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

**Card 27**
**Cloze claim:** Tyrosine cross-classified as aromatic AND polar uncharged.
**Confidence:** 4
**Source:** LibreTexts Biochemistry.
**Notes:** Confidence 4 because the cross-classification is convention-dependent — some sources list tyrosine strictly as aromatic, others note both. The MCAT-standard treatment matches both classifications.

### Subtopic 8 — Special Structural Features

**Card 28**
**Cloze claim:** Glycine is the only achiral amino acid (side chain = H).
**Confidence:** 5
**Source:** LibreTexts Biochemistry; universal biochemistry result.

**Card 29**
**Cloze claim:** Proline side chain loops to α-amino N forming five-membered ring; kinks chains and disrupts α-helix and β-sheet.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (proline structure and secondary-structure disruption).

**Card 30**
**Cloze claim:** Cysteine forms disulfide bonds; critical to insulin and antibodies.
**Confidence:** 5
**Source:** LibreTexts Biochemistry (cysteine, disulfide bonds, insulin and immunoglobulin examples).

**Card 31**
**Cloze claim:** Methionine = universal eukaryotic translation start residue at the N-terminus, encoded by AUG.
**Confidence:** 5
**Source:** LibreTexts Biochemistry / Molecular Biology; universal molecular biology result.

**Card 32**
**Cloze claim:** Histidine side-chain pKa ~6 enables proton transfer in enzyme active sites and buffering in hemoglobin.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; classic histidine role.

**Card 33**
**Cloze claim:** Sulfur AAs Met (thioether) vs Cys (thiol); only Cys-thiol reactive enough for disulfides.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

**Card 34**
**Cloze claim:** Tryptophan largest AA; indole-ring UV absorption is basis for 280 nm protein quantification.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; standard spectrophotometric quantification of proteins.

### Subtopic 9 — pKa Values of Ionizable Side Chains

**Card 35**
**Cloze claim:** Seven ionizable AAs: Lys, Arg, His (basic); Asp, Glu (acidic); Tyr, Cys (high-pH ionization).
**Confidence:** 5
**Source:** LibreTexts Biochemistry, side-chain pKa tables.

**Card 36**
**Cloze claim:** Asp ≈ 3.65, Glu ≈ 4.25; both deprotonated at pH 7.4.
**Confidence:** 4
**Source:** LibreTexts Biochemistry, standard pKa tables.
**Notes:** Confidence 4 because reported side-chain pKa values vary slightly across textbook sources (Lehninger gives Asp 3.65 / Glu 4.25; Stryer gives Asp 3.9 / Glu 4.07; both fall in the same physiological range). The MCAT-acceptable values are used here.

**Card 37**
**Cloze claim:** Lys ≈ 10.5, Arg ≈ 12.5, His ≈ 6.0.
**Confidence:** 4
**Source:** LibreTexts Biochemistry; Lehninger pKa table (Lys 10.53, Arg 12.48, His 6.00).
**Notes:** Confidence 4 for the same reason as Card 36 — minor variation across sources. Values used here are the standard rounded MCAT memorization values.

**Card 38**
**Cloze claim:** Cys ≈ 8.3 (thiol), Tyr ≈ 10.1 (phenol).
**Confidence:** 4
**Source:** LibreTexts Biochemistry; Lehninger (Cys 8.33, Tyr 10.07).
**Notes:** Confidence 4 for cross-source variation.

**Card 39**
**Cloze claim:** Backbone pKa values: α-COOH ~2.0, α-NH₃⁺ ~9–10.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; universal biochemistry result.

**Card 40**
**Cloze claim:** Zwitterion at physiological pH: COO⁻ + NH₃⁺ → net charge 0.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

### Subtopic 10 — Hydrophobicity in Folded Proteins

**Card 41**
**Cloze claim:** Nonpolar side chains bury in protein interior; hydrophobic effect drives folding.
**Confidence:** 5
**Source:** LibreTexts Biochemistry; classic protein-folding thermodynamics.

**Card 42**
**Cloze claim:** Polar / charged side chains sit on protein surface and hydrogen-bond with water.
**Confidence:** 5
**Source:** LibreTexts Biochemistry.

---

## needs_sme_review

*(None — all 43 cards verified at confidence 4 or 5.)*

---

## Disagreements with corpus

None of substance. The .apkg the user supplied was thin on prose (no claims to fact-check) and the .apkg contained one abbreviation typo (Isoleucine "lle/l" → corrected to "Ile/I" in Card 6) plus one missing entry (Glycine, added as Card 2). All prose was written from textbook references.

---

## Discrepancies between primary and secondary sources

Minor pKa value variation across biochemistry textbook sources (Lehninger vs Stryer vs LibreTexts) for the seven ionizable side-chain pKa values; values used in Cards 36–38 are the standard MCAT-memorization rounded values. Flagged at confidence 4 in the affected cards.

---

## Post-verification SME decisions

*(Reserved for future SME / content lead. Each entry should record: card number, decision, rationale, date.)*
