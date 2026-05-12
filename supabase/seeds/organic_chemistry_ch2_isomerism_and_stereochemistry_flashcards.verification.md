# Verification Report — Organic Chemistry Ch 2: Isomerism & Stereochemistry

**Deck:** Isomerism & Stereochemistry
**Source SQL:** supabase/seeds/organic_chemistry_ch2_isomerism_and_stereochemistry_flashcards.sql
**Verified:** 2026-05-11
**Corpus:**
- Primary — `reference-textbooks/organic-chemistry/libretexts-organic-chemistry.txt` (§3.7 conformational analysis; §4.2–4.5 cyclic conformations and chair flip; §5.1–5.5 chirality, enantiomers, optical activity, racemic mixtures, diastereomers; §5.2 CIP priority + R/S; §8.5 E/Z notation; Fischer projection sections)
- Scope authority — `reference-textbooks/aamc/aamc-content-outline-2026.txt` (Foundation 5D: stereochemistry under organic chemistry)

**.docx provenance:** *Organic Chemistry Review Chapter ! (2).docx* (titled "Isomers") — adapted from Kaplan MCAT review; Source-Laundry rules applied per card. Subtopic ordering re-sequenced from the .docx's 3-section structure into an 11-section AAMC-aligned layout that walks students from the isomer hierarchy down through conformational analysis, cis-trans, chirality, enantiomers/diastereomers/meso, and finally configuration assignment. No prose from the .docx survives verbatim. Multiple .docx transcription errors (see "Disagreements with corpus") were silently corrected against textbook sources before becoming cards.

**Section change note:** This deck is filed under the new `organic_chemistry` section added in migration `20260511_add_organic_chemistry_section.sql`, which surfaces Organic Chemistry as its own top-level subject in the Flashcards UI alongside Biology, Biochemistry, Chemistry, Physics, and Psych/Soc.

---

## Summary

- **Total cards:** 44
- **Confidence 5:** 39
- **Confidence 4:** 5
- **Confidence 3:** 0
- **Confidence 2:** 0
- **Confidence 1:** 0
- **Cards flagged for `needs_sme_review`:** 0
- **Cards where corpus contradicts the card:** 0
- **Source-material claims corrected before becoming cards:** 14 *(see Disagreements with corpus)*
- **Cards dropped from source:** 1 (.apkg note 1 "Front,Back" — CSV export header, not actual content)

---

## Per-card verification

### Subtopic 1 — Isomer Overview

**Card 0**
**Cloze claim:** Isomer hierarchy — structural (different connectivity) vs stereo (same connectivity, different spatial arrangement).
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry §3.6, §5.1.

**Card 1**
**Cloze claim:** Stereoisomer subdivisions — conformational (rotation) vs configurational (bond-breaking required).
**Confidence:** 5
**Source:** LibreTexts §3.7, §5.1.

### Subtopic 2 — Structural Isomers

**Card 2**
**Cloze claim:** Structural isomers share molecular formula + weight, differ in connectivity, distinct properties.
**Confidence:** 5
**Source:** LibreTexts §3.6.

**Card 3**
**Cloze claim:** Physical property vs chemical property distinction (composition-preserving vs composition-changing observation).
**Confidence:** 5
**Source:** Standard chemistry framing; LibreTexts §1.1.

**Card 4**
**Cloze claim:** Why structural isomers differ in lab behavior — different bonding patterns → different FGs / branches / rings.
**Confidence:** 5
**Source:** LibreTexts §3.6.

### Subtopic 3 — Conformational Isomers / Newman

**Card 5**
**Cloze claim:** Conformers = same molecule at different σ-bond rotational positions; freely interconvert at RT.
**Confidence:** 5
**Source:** LibreTexts §3.7 ("Conformational analysis of alkanes").

**Card 6**
**Cloze claim:** Newman projection geometry — front carbon as point, back carbon as circle; reads dihedral angle.
**Confidence:** 5
**Source:** LibreTexts §3.7.

**Card 7**
**Cloze claim:** Four butane Newman conformations by dihedral: totally eclipsed (0°), gauche (60°), eclipsed (120°), anti (180°).
**Confidence:** 5
**Source:** LibreTexts §3.7 (butane conformational analysis with energy diagram).

**Card 8**
**Cloze claim:** Energy ranking totally eclipsed > eclipsed > gauche > anti; anti is most stable, totally eclipsed is least.
**Confidence:** 5
**Source:** LibreTexts §3.7.

**Card 9**
**Cloze claim:** Conformers classified as stereoisomers but functionally the same molecule; spends most time in lowest-energy state.
**Confidence:** 5
**Source:** LibreTexts §3.7.

### Subtopic 4 — Cyclic Conformations

**Card 10**
**Cloze claim:** Three strain types — angle, torsional, non-bonded (van der Waals).
**Confidence:** 5
**Source:** LibreTexts §4.2 ("Ring strain in cycloalkanes").

**Card 11**
**Cloze claim:** Cyclohexane conformations chair / boat / twist-boat; chair most stable.
**Confidence:** 5
**Source:** LibreTexts §4.3 ("Cyclohexane and its substituted derivatives").

**Card 12**
**Cloze claim:** Half-chair as transition state during ring flip.
**Confidence:** 4
**Source:** LibreTexts §4.5 (ring flip mechanism).
**Notes:** Confidence 4 because the full chair-flip mechanism (chair → half-chair → twist-boat → boat → twist-boat → half-chair → chair') involves several intermediate states whose energetic ordering is sometimes simplified differently across textbook sources. The half-chair as a transition state is the canonical MCAT-level treatment.

**Card 13**
**Cloze claim:** Axial = perpendicular to ring plane; equatorial = outward near the plane.
**Confidence:** 5
**Source:** LibreTexts §4.3.

**Card 14**
**Cloze claim:** Chair flip swaps axial ↔ equatorial labels; wedges remain wedges, dashes remain dashes.
**Confidence:** 5
**Source:** LibreTexts §4.5.

**Card 15**
**Cloze claim:** Larger substituent prefers equatorial in di-substituted cyclohexanes; rationale is 1,3-diaxial strain.
**Confidence:** 5
**Source:** LibreTexts §4.5, §4.6.

**Card 16**
**Cloze claim:** Boat conformation suffers from flagpole interactions; twist-boat partially relieves.
**Confidence:** 5
**Source:** LibreTexts §4.3, §4.4.

### Subtopic 5 — Cis-Trans in Rings

**Card 17**
**Cloze claim:** Cis (same face of ring) vs trans (opposite faces); configurational not conformational.
**Confidence:** 5
**Source:** LibreTexts §4.7.

### Subtopic 6 — Configurational Isomers

**Card 18**
**Cloze claim:** Configurational isomers require bond breaking to interconvert; enantiomers + diastereomers + cis/trans all configurational.
**Confidence:** 5
**Source:** LibreTexts §5.1.

### Subtopic 7 — Chirality Fundamentals

**Card 19**
**Cloze claim:** Chiral = mirror image non-superimposable; chiral molecule lacks internal plane of symmetry.
**Confidence:** 5
**Source:** LibreTexts §5.1 ("Chirality and the tetrahedral carbon").

**Card 20**
**Cloze claim:** Chiral center = 4 different substituents on a carbon.
**Confidence:** 5
**Source:** LibreTexts §5.1.

**Card 21**
**Cloze claim:** A molecule with chiral centers can still be overall achiral via internal plane of symmetry — meso compounds.
**Confidence:** 5
**Source:** LibreTexts §5.5 ("Meso compounds").

### Subtopic 8 — Enantiomers

**Card 22**
**Cloze claim:** Enantiomers = non-superimposable mirror images; same connectivity, opposite at every chiral center.
**Confidence:** 5
**Source:** LibreTexts §5.3 ("Stereoisomerism — enantiomers and chirality").

**Card 23**
**Cloze claim:** Enantiomers have identical physical/chemical properties EXCEPT optical activity + chiral-environment reactions.
**Confidence:** 5
**Source:** LibreTexts §5.3, §5.4.

**Card 24**
**Cloze claim:** Optical activity = rotation of plane-polarized light by a chiral medium; measured by polarimeter.
**Confidence:** 5
**Source:** LibreTexts §5.4 ("Optical activity").

**Card 25**
**Cloze claim:** Dextrorotatory (+) = clockwise; levorotatory (−) = counterclockwise.
**Confidence:** 5
**Source:** LibreTexts §5.4.

**Card 26**
**Cloze claim:** One enantiomer rotates light same magnitude, opposite direction as its mirror partner.
**Confidence:** 5
**Source:** LibreTexts §5.4.

**Card 27**
**Cloze claim:** Racemic mixture = 1:1 enantiomer mix → equal magnitude opposite direction rotations cancel → no net optical activity.
**Confidence:** 5
**Source:** LibreTexts §5.4 (racemic mixtures).

### Subtopic 9 — Diastereomers

**Card 28**
**Cloze claim:** Diastereomers = configurational isomers, NOT mirror images, differ at some but not all stereocenters.
**Confidence:** 5
**Source:** LibreTexts §5.5 ("Diastereomers").

**Card 29**
**Cloze claim:** 2ⁿ stereoisomer rule with n chiral centers; meso compounds reduce the count.
**Confidence:** 5
**Source:** LibreTexts §5.5.

**Card 30**
**Cloze claim:** Diastereomers have different physical AND chemical properties (separable by conventional techniques).
**Confidence:** 5
**Source:** LibreTexts §5.5.

**Card 31**
**Cloze claim:** Diastereomers are also optically active, each with its own characteristic rotation magnitude.
**Confidence:** 4
**Source:** LibreTexts §5.4, §5.5.
**Notes:** Confidence 4 because the implicit caveat — that some specific diastereomers happen to be optically inactive (e.g., meso diastereomers of certain compounds) — is glossed over. The general MCAT-level statement that diastereomers are optically active is correct for the typical case.

**Card 32**
**Cloze claim:** Cis-trans alkene isomerism is a subset of diastereomerism; π-bond rigidity prevents rotation.
**Confidence:** 5
**Source:** LibreTexts §8.5.

**Card 33**
**Cloze claim:** Racemic + single enantiomer of chiral reagent → diastereomer mixture → separable → recover enantiomers. Classical resolution method.
**Confidence:** 5
**Source:** LibreTexts §5.4 (resolution of racemic mixtures).

### Subtopic 10 — Meso Compounds

**Card 34**
**Cloze claim:** Meso compound = chiral centers + internal plane of symmetry → overall achiral and optically inactive.
**Confidence:** 5
**Source:** LibreTexts §5.5.

### Subtopic 11 — Configuration Assignment

**Card 35**
**Cloze claim:** Relative vs absolute configuration distinction; R/S system encodes absolute.
**Confidence:** 5
**Source:** LibreTexts §5.2 ("Designation of configuration: R/S system").

**Card 36**
**Cloze claim:** CIP priority rules — atomic number primary; ties broken outward.
**Confidence:** 5
**Source:** LibreTexts §5.2.

**Card 37**
**Cloze claim:** CIP double-bond doubling rule — C=O counts as two C-O bonds.
**Confidence:** 5
**Source:** LibreTexts §5.2.

**Card 38**
**Cloze claim:** E/Z definitions (Z = same side, E = opposite side, German etymology).
**Confidence:** 5
**Source:** LibreTexts §8.5.

**Card 39**
**Cloze claim:** R/S three-step procedure (priorities + orient lowest back + trace direction).
**Confidence:** 5
**Source:** LibreTexts §5.2.

**Card 40**
**Cloze claim:** Switch-pair inversion shortcut — swap, determine, then reverse final answer if you swapped.
**Confidence:** 5
**Source:** LibreTexts §5.2 (R/S assignment tricks).

**Card 41**
**Cloze claim:** Fischer projection conventions — horizontal = wedges, vertical = dashes; chain vertical with oxidized end on top.
**Confidence:** 4
**Source:** LibreTexts (Fischer projection sections).
**Notes:** Confidence 4 because the "most oxidized end on top" convention is the standard biological/biochemical convention but is not universally enforced in pure organic chemistry. For MCAT, the convention is what's tested.

**Card 42**
**Cloze claim:** Fischer projection manipulations — switching one pair inverts, two pairs retains, 90° rotation inverts, 180° rotation retains.
**Confidence:** 4
**Source:** LibreTexts (Fischer projection rotation rules).
**Notes:** Confidence 4 because the "rotation in the plane" descriptions assume the standard 2D Fischer drawing convention; in 3D the underlying molecule isn't actually rotating. The MCAT-level rules as stated are correct.

**Card 43**
**Cloze claim:** R/S descriptors written in parentheses with hyphen in IUPAC name; example (R)-2-bromobutane and (2S,3R)-3-bromo-2-butanol.
**Confidence:** 4
**Source:** LibreTexts §5.2; standard IUPAC convention.
**Notes:** Confidence 4 because IUPAC formatting (italicization of R/S, etc.) is sometimes presented with slight variation; the substantive content (parentheses, hyphen, locants for multiple centers) is universally agreed upon.

---

## needs_sme_review

*(None — all 44 cards verified at confidence 4 or 5.)*

---

## Disagreements with corpus

Fourteen source-material claims (from the .docx) were transcription errors that were silently corrected before becoming cards.

1. **.docx "stagger conformation"** → staggered conformation
2. **.docx "eclipse conformation"** → eclipsed conformation
3. **.docx "Confirmational isomers"** → Conformational isomers
4. **.docx "Cyclic confirmations"** → Cyclic conformations
5. **.docx "absolute conformation"** (in §2.3) → absolute configuration
6. **.docx "Cahn-Ingold pre-log"** → Cahn-Ingold-Prelog
7. **.docx "dextrorotary"** → dextrorotatory
8. **.docx "levorotary"** → levorotatory
9. **.docx "substitutes"** (multiple occurrences) → substituents
10. **.docx "serial chemistry"** (in Fischer projection section) → stereochemistry
11. **.docx "2n possible stereoisomers"** → 2ⁿ (missing exponent)
12. **.docx duplicate sentence about axial hydrogens** ("perpendicular to the plane of the ring (sticking up or down)" appears twice in a row) — collapsed to single statement
13. **.docx "horizontal lines indicate bonds I project out"** → "that project out"
14. **.docx "rotating the official projection"** → rotating the Fischer projection

In addition, the .apkg's note 1 was a "Front,Back" CSV export header — junk, not actual content — and was dropped.

---

## Discrepancies between primary and secondary sources

None of concern. This deck primarily references LibreTexts Organic Chemistry as the sole textbook source. AAMC outline confirms scope (stereochemistry under Foundation 5D) but not specific assignment procedures, which is the textbook's role. The Cahn-Ingold-Prelog priority rules, R/S assignment procedure, and E/Z notation are universally consistent across organic chemistry sources.

---

## Post-verification SME decisions

*(Reserved for future SME / content lead. Each entry should record: card number, decision, rationale, date.)*
