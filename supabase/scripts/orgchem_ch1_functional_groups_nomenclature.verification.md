# OrgChem Ch1 — Functional Groups & Nomenclature — Verification

**Deliverable:** `orgchem_ch1_functional_groups_nomenclature_questions.sql` (24 standalone questions)
**Pipeline:** Chem/Phys standalone v7 · **Section:** `chem_phys` · **Discipline:** `organic-chemistry`
**Foundation:** 5D · **content_category:** *Structure, function, and reactivity of biologically relevant molecules*
**Sourcing:** LibreTexts Organic Chemistry + 2026 AAMC content outline. The chapter `.docx` was treated as a liability, not a source — no prose or question framing was drawn from it; every stem and distractor was authored fresh.

---

## 1. Scope decision — whole-document cross-subject scan

A per-concept cartographer scan mapped all 24 candidate nomenclature/functional-group concepts against the **entire** AAMC outline (every subject: OC/GC/BC/BIO/PHY/PsychSoc). Result: **16 in-scope, 8 out.** The 8 out are exactly what a "Nomenclature" chapter is usually built around:

| OFF-OUTLINE (excluded) | Why |
|---|---|
| IUPAC parent-chain selection | not itemized anywhere; "Nomenclature" bullets mean recognition + common names, not name-construction |
| IUPAC lowest-locant numbering | same |
| Substituent alphabetical ordering / di-tri prefixes | same |
| Functional-group suffix-priority ranking | same |
| Alkanes as a named class | 5D lists functional-group families, not bare hydrocarbons |
| Alkynes (`-yne`) | not itemized under any subject |
| Degrees of unsaturation | off-outline course machinery |
| Diol / geminal / vicinal vocabulary | not itemized; brief aside at most |

**In-scope core (what this chapter tests):** functional-group **recognition/classification** across alcohols, aldehydes, ketones, carboxylic acids, esters, amides, anhydrides (5D); **common names** (formic/acetic/propionic, formaldehyde/acetone); **carbonyl-class structural distinctions**; and **carbon oxidation level** (ties to 5E redox). Deep *reactivity* of each family (nucleophilic addition, gem-diol hydration, relative reactivity of derivatives) was deliberately **deferred** to the dedicated Alcohols / Aldehydes & Ketones / Carboxylic Acids / Acid Derivatives chapters, so Ch1 owns a clean, non-overlapping "recognition" lane.

Decision (approved): **Lean recognition Ch1, ~24 questions.**

## 2. Blueprint delivered (24)

| Subtopic | n | Concepts |
|---|---|---|
| Functional-Group Identification | 10 | amide/peptide, aldehyde vs ketone, acid vs ester, ester vs amide, anhydride, alcohol vs ether vs carbonyl, carbonyl presence, acidic-H group, acid-derivative type by substituent, property→group |
| Common Names & Carbonyl Structure | 8 | acetic acid, formaldehyde vs acetone, `-al` classification, propionic = 3-C acid, ester back-derivation, N-substituted amide, terminal vs internal carbonyl, same-class matching |
| Carbon Oxidation Level | 6 | rank alcohol<aldehyde<acid, oxidation vs reduction direction, assign oxidation number, most-oxidized group, most-reduced carbon, 4-way ordering |

## 3. Distributions

- **Answer key:** A6 / B6 / C6 / D6 (rebalanced at assembly via index-cycling permutation).
- **Difficulty:** 8 easy / 10 medium / 6 hard (25% hard). Three items (C17 oxidation-number calculation, C20 four-way ordering, D24 five-structure classification) were honestly relabeled hard after the verify/red-team pass under-graded them.
- **Cognitive skill:** 9 Skill-1 (recognition) / 15 Skill-2 (reasoning). No Skill-3/4 — this recognition chapter contains no research-design or data/statistics tasks, so forcing those tags would be dishonest.

## 4. Quality gates passed

- **Readback ban (primary release-blocker):** every item is APPLY-not-NAME — the stem supplies condensed structures / a scenario and asks the student to classify, rank, or derive. No "what suffix does an aldehyde use" recall items. Adversarial red-team ran an explicit readback lens on each question.
- **Format:** live Praxist chem 3-block format — opener names the content category; key reasoning in the opener (untagged); `(Choice X)` blocks for the three wrong choices only; Skill closer. Verified programmatically across all 24 (no missing/extra choice tags, no key-tagged blocks).
- **Notation:** all formulas inline LaTeX (`\(\text{CH}_3\text{CHO}\)`); HTML-entity escapes (`&lt;`) normalized to real symbols.
- **Numeric correctness (spot-verified by hand):** C17 acetaldehyde carbonyl C = −1+0+2 = **+1** ✓ · C15 CH₃OH(−2)<HCHO(0)<HCOOH(+2) ✓ · C20 CH₄(−4)<CH₃OH(−2)<HCHO(0)<HCOOH(+2) ✓ · C18 CO₂ = +4 max ✓ · A9 two acyl groups sharing O = anhydride ✓.
- **Scope tripwires:** assembler aborts on any naming-mechanics language ("longest chain", "lowest locant", "parent chain", "alphabetical order", "number the chain") — none present.
- **Distractors:** one `question_distractor_metadata` row per wrong choice (72 total), each a nameable wrong model (functional-group confusion, oxidation-direction reversal, adjacent class, partial truth).

## 5. Idempotency

`BEGIN; DELETE FROM questions WHERE section='chem_phys' AND topic='Functional Groups & Nomenclature'; … COMMIT;` — safe to re-run; wipes and re-inserts the whole topic with its distractor metadata.
