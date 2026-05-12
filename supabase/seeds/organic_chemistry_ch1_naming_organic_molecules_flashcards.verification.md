# Verification Report — Organic Chemistry Ch 1: Naming Organic Molecules

**Deck:** Naming Organic Molecules
**Source SQL:** supabase/seeds/organic_chemistry_ch1_naming_organic_molecules_flashcards.sql
**Verified:** 2026-05-11
**Corpus:**
- Primary — `reference-textbooks/organic-chemistry/libretexts-organic-chemistry.txt` (Ch 3 alkane nomenclature; Ch 10 alcohols + diols; Ch 15 carboxylic acids and derivatives; functional-group priority §15.1; §50790 aldehyde > ketone priority; §55778 carboxylic acid highest priority)
- Scope authority — `reference-textbooks/aamc/aamc-content-outline-2026.txt` (Foundation 4D bond formation; Foundation 5D biological molecules; nomenclature explicitly required for every functional group class at lines 2937, 2949, 2975, 2986, 2999)

**.docx provenance:** *Organic Chemistry Review Chapter 1.docx* (titled "nomenclature") — adapted from Kaplan MCAT review; Source-Laundry rules applied per card. Subtopic ordering re-sequenced from the .docx's 4-section structure into a 13-section AAMC-aligned layout that walks students from the IUPAC framework outward to specific functional-group classes in increasing structural complexity. No prose from the .docx survives verbatim. Multiple .docx transcription errors (see "Disagreements with corpus") were silently corrected against textbook sources before becoming cards.

**Out-of-scope content dropped:** 3 .apkg cards (notes 21 ethers, 22 nitriles, 26 stereochemistry) — these topics belong in later Orgo chapters that have their own dedicated AAMC outline sections; including them here would dilute the nomenclature focus and create overlap with future chapters.

**Cadence reference status:** This is the first Organic Chemistry deck shipped under v6 and serves as the cadence template for subsequent Orgo chapters per the v6 prompt's style-anchor rule for new subjects.

---

## Summary

- **Total cards:** 40
- **Confidence 5:** 36
- **Confidence 4:** 4
- **Confidence 3:** 0
- **Confidence 2:** 0
- **Confidence 1:** 0
- **Cards flagged for `needs_sme_review`:** 0
- **Cards where corpus contradicts the card:** 0
- **Source-material claims corrected before becoming cards:** 8 *(see Disagreements with corpus)*

---

## Per-card verification

### Subtopic 1 — IUPAC Framework

**Card 0**
**Cloze claim:** IUPAC nomenclature = systematic naming; unique-name encodes connectivity + FGs + positions.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry §3.1 ("IUPAC nomenclature of alkanes" intro).

**Card 1**
**Cloze claim:** IUPAC name = prefix – parent chain – suffix.
**Confidence:** 5
**Source:** LibreTexts §3.1.

**Card 2**
**Cloze claim:** 4-step procedure (parent chain → suffix → numbering → substituents).
**Confidence:** 5
**Source:** LibreTexts §3.1; standard IUPAC nomenclature procedure.

### Subtopic 2 — Parent Chain Identification

**Card 3**
**Cloze claim:** Parent chain = longest carbon chain containing highest-priority FG.
**Confidence:** 5
**Source:** LibreTexts §3.1; §15.1.

**Card 4**
**Cloze claim:** Tiebreak: most-substituted chain wins among equal-length candidates.
**Confidence:** 4
**Source:** LibreTexts §3.1.
**Notes:** Confidence 4 because the tiebreak rule has some variation across sources (some use "greatest number of substituents," some use "earliest locant sum"). The MCAT-standard interpretation matches the .docx and is consistent with mainstream presentations.

### Subtopic 3 — Suffix Determination

**Card 5**
**Cloze claim:** Highest-priority FG → suffix; others → prefixes.
**Confidence:** 5
**Source:** LibreTexts §15.1.

### Subtopic 4 — Functional Group Priority

**Card 6**
**Cloze claim:** Priority order: COOH > ester > amide > aldehyde > ketone > alcohol > amine > alkene > alkyne > halide > alkane.
**Confidence:** 5
**Source:** LibreTexts line 55778 ("Carboxylic acids are given the highest nomenclature priority by the IUPAC system"); line 50790 (aldehyde > ketone); §15.1 (full hierarchy).

**Card 7**
**Cloze claim:** Oxidation-state logic — more heteroatom bonds = higher priority; H-bonds lower oxidation state.
**Confidence:** 5
**Source:** LibreTexts §15.1; standard organic chemistry framing.

**Card 8**
**Cloze claim:** Suffix summary across 6 major FG classes (-ol, -al, -one, -oic acid, -oate, -amide).
**Confidence:** 5
**Source:** LibreTexts §10.2 (-ol); §11 (-al, -one); §15.2 (-oic acid, -oate, -amide).

### Subtopic 5 — Chain Numbering

**Card 9**
**Cloze claim:** Lowest-locant rule for highest-priority FG; tiebreak via substituent locants.
**Confidence:** 5
**Source:** LibreTexts §3.1.

**Card 10**
**Cloze claim:** Double > triple bond tiebreak ("double over triple" when priorities tie).
**Confidence:** 5
**Source:** LibreTexts §8.1 (alkene/alkyne nomenclature).

**Card 11**
**Cloze claim:** Ring numbering: start at greatest substitution; proceed for lowest locant set.
**Confidence:** 5
**Source:** LibreTexts §3.1 (cycloalkane nomenclature).

### Subtopic 6 — Substituent Naming

**Card 12**
**Cloze claim:** Alkyl substituent: -ane → -yl (methyl, ethyl, propyl).
**Confidence:** 5
**Source:** LibreTexts §3.1.

**Card 13**
**Cloze claim:** Halogen prefixes: fluoro-, chloro-, bromo-, iodo-.
**Confidence:** 5
**Source:** LibreTexts §3.4 (alkyl halide nomenclature).

**Card 14**
**Cloze claim:** Multiplying prefixes di-/tri-/tetra- with each occurrence getting its own locant.
**Confidence:** 5
**Source:** LibreTexts §3.1.

**Card 15**
**Cloze claim:** Non-hyphenated prefixes iso-/neo-/cyclo-; n- hyphenated for normal/straight-chain.
**Confidence:** 5
**Source:** LibreTexts §3.1.

**Card 16**
**Cloze claim:** Alphabetization rule — multiplying prefixes (di-, tri-, tetra-) NOT counted; "diethyl" alphabetizes under "e."
**Confidence:** 5
**Source:** LibreTexts §3.1; standard IUPAC rule.

### Subtopic 7 — Alkane Series

**Card 17**
**Cloze claim:** Alkane formula CₙH₂ₙ₊₂ for saturated acyclic alkanes.
**Confidence:** 5
**Source:** LibreTexts line 8808 ("formula of the type Cn H2n+2").

**Card 18**
**Cloze claim:** C1–C5 names: methane, ethane, propane, butane, pentane.
**Confidence:** 5
**Source:** LibreTexts §3.1.

**Card 19**
**Cloze claim:** C6–C10 names: hexane, heptane, octane, nonane, decane.
**Confidence:** 5
**Source:** LibreTexts §3.1.

### Subtopic 8 — Alkenes & Alkynes

**Card 20**
**Cloze claim:** -ene (double bond), -yne (triple bond) suffixes; locant before suffix gives lower-numbered carbon of bond.
**Confidence:** 5
**Source:** LibreTexts §8.1.

### Subtopic 9 — Alcohols

**Card 21**
**Cloze claim:** Alcohol -ol suffix replaces -e; hydroxyl carbon gets lowest locant.
**Confidence:** 5
**Source:** LibreTexts §10.2 (alcohol nomenclature).

**Card 22**
**Cloze claim:** Hydroxy- prefix when alcohol is not highest priority.
**Confidence:** 5
**Source:** LibreTexts §10.2; §15.1.

**Card 23**
**Cloze claim:** Alcohol > alkene/alkyne in priority because hydroxyl-bearing carbon is more oxidized.
**Confidence:** 5
**Source:** LibreTexts §15.1.

### Subtopic 10 — Diols

**Card 24**
**Cloze claim:** Diols/glycols use -diol suffix; each hydroxyl has its own locant.
**Confidence:** 5
**Source:** LibreTexts §10.2.

**Card 25**
**Cloze claim:** Geminal (same C) vs vicinal (adjacent C) diol distinction; geminal diols spontaneously dehydrate to carbonyl.
**Confidence:** 5
**Source:** LibreTexts §10.6 (geminal diols / hydrates of carbonyls).

### Subtopic 11 — Aldehydes & Ketones

**Card 26**
**Cloze claim:** Aldehyde -al suffix; terminal carbonyl; always carbon #1.
**Confidence:** 5
**Source:** LibreTexts §11 (aldehyde nomenclature).

**Card 27**
**Cloze claim:** Ketone -one suffix; internal carbonyl; numbered for lowest locant.
**Confidence:** 5
**Source:** LibreTexts §11.

**Card 28**
**Cloze claim:** Aldehyde > ketone priority; ketone becomes oxo- substituent when both present.
**Confidence:** 5
**Source:** LibreTexts line 50790 ("aldehydes have a higher priority than ketones, molecules which contain both functional groups are named as aldehydes and the ketone is..."); §15.1.

**Card 29**
**Cloze claim:** Common aldehyde names: methanal = formaldehyde, ethanal = acetaldehyde, propanal = propionaldehyde.
**Confidence:** 5
**Source:** LibreTexts §11; standard organic chemistry common names.

**Card 30**
**Cloze claim:** Propanone (CH₃COCH₃) = acetone.
**Confidence:** 5
**Source:** LibreTexts §11.

**Card 31**
**Cloze claim:** Carbonyl-as-substituent: oxo- prefix (or keto- in some sources); locant given for carbonyl carbon.
**Confidence:** 4
**Source:** LibreTexts §15.1.
**Notes:** Confidence 4 because the "keto-" terminology is older and less commonly used in modern IUPAC; "oxo-" is the strictly preferred IUPAC term. Both terms appear on the MCAT, so we teach both.

### Subtopic 12 — Carboxylic Acids

**Card 32**
**Cloze claim:** Carboxylic acid -oic acid suffix; terminal -COOH; always position 1.
**Confidence:** 5
**Source:** LibreTexts §15.2; line 55778 (highest priority position).

**Card 33**
**Cloze claim:** Common acid names: methanoic = formic, ethanoic = acetic, propanoic = propionic.
**Confidence:** 5
**Source:** LibreTexts §15.2; line 5759+ (acetic acid throughout); standard organic common names.

### Subtopic 13 — Carboxylic Acid Derivatives

**Card 34**
**Cloze claim:** Ester naming: alkyl group first + parent acid with -oate replacing -oic acid; example ethyl ethanoate / ethyl acetate.
**Confidence:** 5
**Source:** LibreTexts §15.3 (ester nomenclature).

**Card 35**
**Cloze claim:** Alkoxy group (-OR) = substituent replacing hydroxyl in ester; also the defining feature of ethers.
**Confidence:** 4
**Source:** LibreTexts §15.3.
**Notes:** Confidence 4 because the alkoxy-group description is accurate but the ether connection is a slight stretch beyond this chapter's nomenclature focus; included as a useful structural reference.

**Card 36**
**Cloze claim:** Amide naming: amino group replaces hydroxyl; -amide replaces -oic acid suffix.
**Confidence:** 5
**Source:** LibreTexts §15.5 (amide nomenclature).

**Card 37**
**Cloze claim:** N- prefix (capital N) for substituents on amide nitrogen; example N-methylpropanamide.
**Confidence:** 5
**Source:** LibreTexts §15.5.

**Card 38**
**Cloze claim:** Symmetric anhydride: replace "acid" with "anhydride" in parent name; example acetic anhydride.
**Confidence:** 5
**Source:** LibreTexts §15.4 (anhydride nomenclature).

**Card 39**
**Cloze claim:** Asymmetric anhydride: both acids named in alphabetical order before "anhydride"; example ethanoic propanoic anhydride.
**Confidence:** 4
**Source:** LibreTexts §15.4.
**Notes:** Confidence 4 because asymmetric anhydride nomenclature has minor convention variation across sources (e.g., some omit the "acid" word in each component, others retain it). The MCAT-standard convention used here matches Kaplan/LibreTexts treatments.

---

## needs_sme_review

*(None — all 40 cards verified at confidence 4 or 5.)*

---

## Disagreements with corpus

Eight source-material claims (from the .docx) were transcription errors that were silently corrected before becoming cards.

1. **.docx "die, try, and tetra"** — Autocorrect mangling. Card 14 uses "di-, tri-, tetra-" per textbook.

2. **.docx "Propionoic acid"** — Spelling. Card 33 uses "propionic acid" per textbook.

3. **.docx "In our mind, the hydroxyl group is replaced by an amino group"** — Autocorrect from "amide." The phrasing didn't survive into any card; the underlying concept (amide as carboxylic acid derivative with -NH₂ replacing -OH) is taught correctly in Card 36.

4. **.docx "naming dials" / "Dials with hydroxyl groups"** — Autocorrect. Card 24 uses "diols" per textbook.

5. **.docx "substitutes"** (multiple occurrences) — Wrong word. All cards use "substituents" per textbook convention.

6. **.docx "the carbonum"** — Garbled. Card 28's carbonyl/aldehyde/ketone framing uses standard terminology.

7. **.docx "pair molecule"** — Autocorrect from "parent molecule." The phrasing didn't survive; all references to the parent chain or parent molecule use textbook terminology.

8. **.docx "numbering the change"** — Autocorrect from "numbering the chain." Card 9 uses textbook framing.

---

## Discrepancies between primary and secondary sources

None of concern. This deck primarily references LibreTexts Organic Chemistry as the sole textbook source for organic nomenclature. AAMC outline confirms scope (Foundation 4D / 5D, with nomenclature explicitly required for every major FG class at lines 2937, 2949, 2975, 2986, 2999) but not specific naming-procedure details, which is the textbook's role. Where common names appear (formic/acetic/propionic acids; formaldehyde/acetaldehyde/acetone), they are universally accepted across organic chemistry textbooks.

Minor convention variations (e.g., oxo- vs keto- substituent prefix, asymmetric anhydride naming) are flagged at confidence 4 in the affected cards.

---

## Post-verification SME decisions

*(Reserved for future SME / content lead. Each entry should record: card number, decision, rationale, date.)*
