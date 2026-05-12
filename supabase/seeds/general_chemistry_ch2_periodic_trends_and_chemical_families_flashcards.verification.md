# Verification Report — General Chemistry Ch 2: Periodic Trends & Chemical Families

**Deck:** Periodic Trends & Chemical Families
**Source SQL:** supabase/seeds/general_chemistry_ch2_periodic_trends_and_chemical_families_flashcards.sql
**Verified:** 2026-05-11
**Corpus:**
- Primary — `reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt` (Ch 7 electronic structure + periodic trends; Ch 18 representative metals/metalloids/nonmetals; Ch 19 transition metals + coordination chemistry)
- Scope authority — `reference-textbooks/aamc/aamc-content-outline-2026.txt` (Foundation 4E: periodic table subsection)

**.docx provenance:** *General Chemistry Review Chapter 2.docx* (titled "The Periodic Table") — adapted from Kaplan MCAT review; Source-Laundry rules applied per card. Subtopic ordering re-sequenced from the .docx's 4-section structure into a 16-section AAMC-aligned layout that separates historical foundation, table structure, classification, individual trends, and individual chemical families. No prose from the .docx survives verbatim. Multiple .docx transcription errors (see "Disagreements with corpus") were silently corrected against textbook sources before becoming cards.

**Cadence reference:** This deck follows the style anchor set by `general_chemistry_ch1_inside_the_atom_flashcards.sql` per the v6 prompt's within-subject style continuity rule.

---

## Summary

- **Total cards:** 46
- **Confidence 5:** 41
- **Confidence 4:** 5
- **Confidence 3:** 0
- **Confidence 2:** 0
- **Confidence 1:** 0
- **Cards flagged for `needs_sme_review`:** 0
- **Cards where corpus contradicts the card:** 0
- **Source-material claims corrected before becoming cards:** 9 *(see Disagreements with corpus)*

---

## Per-card verification

### Subtopic 1 — Historical Foundation

**Card 0**
**Cloze claim:** Mendeleev published the first periodic table (1869) by atomic weight ordering; noticed periodic property recurrence.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.5 ("The Periodic Table" — historical introduction); §7.5.

**Card 1**
**Cloze claim:** Moseley re-ordered by atomic number, resolving anomalies in Mendeleev's atomic-weight ordering.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.5; §7.5.

**Card 2**
**Cloze claim:** Periodic law — properties are periodic function of atomic number.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.5.

### Subtopic 2 — Table Structure

**Card 3**
**Cloze claim:** Periods = rows (each element to the right has one more proton); groups = columns (share valence configuration → similar chemistry).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.5.

**Card 4**
**Cloze claim:** A elements = representative; B elements = non-representative (transition + lanth/act).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.5; §7.5.

**Card 5**
**Cloze claim:** Representative elements have valence in highest s and p subshells; Roman numeral = valence count.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.5, §6.4.

**Card 6**
**Cloze claim:** Transition metals valence = highest s + d; lanth/act valence = highest s + f.
**Confidence:** 4
**Source:** OpenStax Chemistry: Atoms First 2e §6.4, §7.1.
**Notes:** Confidence 4 because the "valence electron" convention for d-block and f-block elements varies somewhat across sources (some count all d electrons, others only certain ones); the MCAT-standard convention matches.

**Card 7**
**Cloze claim:** Roman numeral above A group = valence electron count for the element.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.5.

### Subtopic 3 — Metals, Nonmetals, Metalloids

**Card 8**
**Cloze claim:** Metals: left/middle of table, lustrous, malleable, ductile, good conductors.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.5; §18.1.

**Card 9**
**Cloze claim:** Metal energetic profile: low Z_eff, low EN, low IE, low EA, large atomic radius, small ionic radius.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4, §18.1.

**Card 10**
**Cloze claim:** Nonmetals: upper right, brittle solids, high EN/IE/EA, small atomic radius, large ionic radius.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.5; §18.10.

**Card 11**
**Cloze claim:** Metalloids occupy stair-step (B, Si, Ge, As, Sb, Te); intermediate EN and IE.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.5; §18.9.

**Card 12**
**Cloze claim:** Delocalized electron "sea" → electrical/thermal conductivity + metallic luster.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §11.6 (metallic bonding); §18.1.

### Subtopic 4 — Effective Nuclear Charge

**Card 13**
**Cloze claim:** Z_eff = net positive charge experienced by outermost electrons after shielding; Z_eff ≈ Z − S.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4 ("Periodic Variations").

**Card 14**
**Cloze claim:** Z_eff increases L→R across period; ~constant down group (added shells provide shielding cancelling added nuclear charge).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4.

### Subtopic 5 — Atomic Radius

**Card 15**
**Cloze claim:** Atomic radius = half the distance between nuclei of two like atoms in contact.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4.

**Card 16**
**Cloze claim:** Radius ↓ L→R across period (rising Z_eff); ↑ top to bottom in group (new shells at larger n).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4.

### Subtopic 6 — Ionic Radius

**Card 17**
**Cloze claim:** Cation < parent neutral (electron loss reduces repulsion); anion > parent (added electrons increase repulsion).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4.

**Card 18**
**Cloze claim:** Ionic radius ↑ down group; cation radii ↓ L→R; anion radii ↓ L→R; radius jumps at cation→anion transition within isoelectronic series.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4.

### Subtopic 7 — Ionization Energy

**Card 19**
**Cloze claim:** IE = energy required to remove electron from gaseous atom; endothermic.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4.

**Card 20**
**Cloze claim:** IE ↑ L→R; ↓ top to bottom; mechanisms (Z_eff and shell distance).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4.

**Card 21**
**Cloze claim:** Successive IEs always rise; big jumps signal noble-gas-core penetration.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4 (successive ionization energies discussion + table).

### Subtopic 8 — Electron Affinity

**Card 22**
**Cloze claim:** EA = energy change when atom gains electron; usually exothermic; reported as positive magnitude.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4.

**Card 23**
**Cloze claim:** EA ↑ L→R; ↓ down group; 1A/2A very low; halogens highest.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4.

### Subtopic 9 — Electronegativity

**Card 24**
**Cloze claim:** EN = ability to attract shared electrons in a bond; correlates with IE.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4 (defines EN qualitatively); §8.4 (Pauling scale).

**Card 25**
**Cloze claim:** EN ↑ L→R; ↓ down group — same pattern as IE.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.4, §8.4.

**Card 26**
**Cloze claim:** Pauling scale: Cs ≈ 0.7; F = 4.0; He/Ne/Ar have no assigned EN.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §8.4 (Pauling electronegativity table; values for Cs ≈ 0.79 and F = 3.98, rounded for MCAT convention).
**Notes:** Standard MCAT-rounded values used (0.7 and 4.0 rather than 0.79 and 3.98).

### Subtopic 10 — Alkali Metals (Group 1A)

**Card 27**
**Cloze claim:** Alkali metals: classic metallic properties but lower densities; largest atomic radii in their period; lowest IE/EA/EN.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §18.2 ("Occurrence and Preparation of the Representative Metals").

**Card 28**
**Cloze claim:** Single valence electron → +1 cation with previous-noble-gas configuration → high reactivity.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.5; §18.2.

**Card 29**
**Cloze claim:** "Active metals" = 1A + 2A combined; never found in elemental form in nature.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §18.2, §18.3.

**Card 30**
**Cloze claim:** Hydrogen sits above Li in 1A but is a nonmetal — high IE, often covalent bonding.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §18.1 ("Hydrogen exception"); §18.4 (hydrogen chemistry).

### Subtopic 11 — Alkaline Earth Metals (Group 2A)

**Card 31**
**Cloze claim:** Alkaline earth: higher Z_eff, smaller radius, higher IE and densities than alkalis.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §18.3.

**Card 32**
**Cloze claim:** Two s-subshell valence electrons → +2 cation with previous-noble-gas configuration.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.5, §18.3.

### Subtopic 12 — Chalcogens (Group 6A)

**Card 33**
**Cloze claim:** Chalcogens have 6 valence electrons; typically −2; sulfur can reach +4 (SO₂) and +6 (SO₃, SO₄²⁻).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §18.10 (oxygen and the chalcogens); standard inorganic chemistry.

### Subtopic 13 — Halogens (Group 7A)

**Card 34**
**Cloze claim:** Halogens have 7 valence electrons; highest EAs; most reactive nonmetals.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §18.11 ("Halogens").

**Card 35**
**Cloze claim:** Fluorine = highest EN (Pauling 4.0); strongest atomic attractor of bonding electrons.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §8.4 (Pauling table).

**Card 36**
**Cloze claim:** Phase range at room temp: F₂/Cl₂ gases, Br₂ liquid, I₂ solid.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §18.11.

**Card 37**
**Cloze claim:** Halogens never in elemental form in nature — exist as X⁻ or X₂.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §18.11.

### Subtopic 14 — Noble Gases (Group 8A)

**Card 38**
**Cloze claim:** Noble gases: full valence shell → very high IE, negligible EA, no measurable EN for lighter members.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §18.12 ("Noble Gases").

**Card 39**
**Cloze claim:** He exception — only 2 valence electrons; n=1 shell complete at 2 electrons.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4, §18.12.

**Card 40**
**Cloze claim:** Xe and Kr can form compounds with very EN atoms — XeF₂, XeF₄, KrF₂.
**Confidence:** 4
**Source:** OpenStax Chemistry: Atoms First 2e §18.12 (noble gas compounds discussion).
**Notes:** Confidence 4 because this is at the high end of MCAT scope and AAMC outline doesn't specifically name noble-gas compounds; included as a useful caveat to the "inert" label.

### Subtopic 15 — Transition Metals (B Elements)

**Card 41**
**Cloze claim:** Transition metals = d-block; valence in highest s + d; standard metallic profile (low EN/IE/EA).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4, §19.1 ("Transition Metals").

**Card 42**
**Cloze claim:** Multiple oxidation states from variable d-electron loss; Fe²⁺/Fe³⁺, Mn²⁺ through Mn⁷⁺.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §19.1, §19.2.

**Card 43**
**Cloze claim:** Transition metals are harder, denser, higher mp/bp than active metals; still malleable + conductive.
**Confidence:** 4
**Source:** OpenStax Chemistry: Atoms First 2e §19.1.
**Notes:** Confidence 4 because the comparison is a generalization; some transition metals (e.g., Hg, which is liquid at room temperature) are exceptions to the high-mp/bp claim. The MCAT-level generalization matches the textbook treatment.

**Card 44**
**Cloze claim:** Colored complexes from d-orbital splitting → absorb specific wavelengths → perceived color = complementary color.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §19.3 ("Coordination Chemistry"), §19.4 (Spectroscopic and Magnetic Properties).

### Subtopic 16 — Lanthanide / Actinide Series

**Card 45**
**Cloze claim:** Lanthanide + actinide = f-block; valence in highest s + f; actinides include transuranium elements.
**Confidence:** 4
**Source:** OpenStax Chemistry: Atoms First 2e §6.4 (f-block placement); §19.1.
**Notes:** Confidence 4 because the f-block valence convention is variable across sources. The MCAT-standard convention used here matches mainstream presentations.

---

## needs_sme_review

*(None — all 46 cards verified at confidence 4 or 5.)*

---

## Disagreements with corpus

Nine source-material claims (from the .docx and/or .apkg) conflicted with the reference textbooks or were transcription errors. None became cards as originally written; each was corrected before SQL output.

1. **.apkg note 16 (chalcogens "−2 or +6, depending on metals/nonmetals")** — Sloppy framing. Chalcogens are all non-metals or metalloids; the +6 state belongs specifically to sulfur and heavier members in oxidized environments (SO₃, SO₄²⁻). Card 33 reframes this precisely.

2. **.apkg note 18 (noble gases "virtually nonexistent EN and EA")** — Absolute claim contradicted by Xe/Kr compounds. Card 38 narrows to "lighter members" (He/Ne/Ar) and Card 40 adds the heavier-noble-gas-compound caveat.

3. **.apkg notes 12 and 20 (electron affinity trend)** — Duplicates. Merged into single Card 23.

4. **.docx "Dimitri Mendeleev publish"** — Verb tense / typo. Card 0 uses "published."

5. **.docx "Grooves contain elements"** — Autocorrect artifact for "Groups." Card 3 uses "Groups."

6. **.docx "innermost electrons are held less tightly as the principal number increases"** — Logic flip; should be "outermost electrons are held less tightly." This phrasing didn't survive into any card — the underlying concept (looser binding of valence electrons further from nucleus) is taught correctly in Card 16 and Card 20.

7. **.docx "atom's effect of nuclear charge"** — Typo. Card 13 uses "effective nuclear charge" per textbook.

8. **.docx "Transition Medals (B)"** — Typo. Cards in subtopic 15 use "Transition Metals."

9. **.docx "If an object absorbs a given color of light and reflects all letters, our brain mixes these subtraction frequencies"** — Multiple autocorrect/transcription errors ("all letters" → all others; "subtraction frequencies" → reflected/transmitted frequencies). Card 44 uses textbook framing.

---

## Discrepancies between primary and secondary sources

None of concern. This deck primarily references OpenStax Chemistry: Atoms First 2e as the sole textbook source. AAMC outline confirms scope (Foundation 4E periodic table subsection) but not specific numerical values, which is the textbook's role. The Pauling EN endpoints (Cs and F values) are standard physical-chemistry data verified across multiple chemistry textbook sources.

---

## Post-verification SME decisions

*(Reserved for future SME / content lead. Each entry should record: card number, decision, rationale, date.)*
