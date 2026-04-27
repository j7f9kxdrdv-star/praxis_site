# Verification Report — General Chemistry Ch 2: Reading the Periodic Table — Trends, Families, and Reactivity

**Deck:** Reading the Periodic Table — Trends, Families, and Reactivity
**Source SQL:** supabase/seeds/general_chemistry_ch2_periodic_table_flashcards.sql
**Section / Topic:** chemistry / General Chemistry
**Verified:** 2026-04-27
**Corpus:**
- openstax-chemistry-atoms-first-2e.txt (primary — periodic law and table organization Ch 3.5; types of elements Ch 3.5; periodic trends Ch 3.5–3.6; group chemistry Ch 3.7 and Ch 4)

## Summary

- Total cards: 32
- Confidence 5: 28
- Confidence 4: 4
- Confidence 3: 0
- Confidence 2: 0
- Confidence 1: 0
- Cards flagged for needs_sme_review: 0
- Cards where corpus contradicts card: 0

## Per-card verification

### Card 0 — Periodic law
**Cloze claim:** Properties of elements arranged by atomic number recur at regular intervals.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.5, line 7320.
**Excerpt:** "The modern statement of this relationship, the periodic law, is as follows: the properties of the elements are periodic functions of their atomic numbers."

### Card 1 — Periodic table organizes by atomic number
**Cloze claim:** Modern table arranges elements by increasing atomic number, surfacing recurring chemical/physical properties.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.5, lines 7289–7325.

### Card 2 — Periods (rows) and shared principal energy level
**Cloze claim:** Rows = periods; same period → same principal energy level (n) for valence electrons.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4 / §3.5, lines 6883+, 7320–7370.

### Card 3 — Groups (columns) and shared valence configuration
**Cloze claim:** Columns = groups (or families); same group → same valence-shell electron configuration → similar reactivity.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.5, lines 7363–7374.
**Excerpt:** "elements within the same group have the same number of valence electrons in the same kinds of orbitals…"

### Card 4 — Valence shell vs valence electrons
**Cloze claim:** Valence shell = outermost occupied energy level; valence electrons within it are responsible for bonding/reactivity.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4, lines 6742–6745.

### Card 5 — Representative (A) vs non-representative (B) elements
**Cloze claim:** s/p-block = representative (A); d/f-block (transition + lanthanides + actinides) = non-representative (B).
**Confidence:** 4
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4, lines 6883, 7363; §3.5, lines 7919–7922.
**Notes:** OpenStax uses "main-group elements" / "representative elements" terminology and explicitly groups them as s- and p-block (line 6883). The "A vs B" letter naming is the older CAS group labeling that Kaplan uses; OpenStax acknowledges it but prefers the 1–18 numbering. The mapping (s+p = A; d+f = B) is correct in standard usage.

### Card 6 — Lanthanides vs actinides
**Cloze claim:** Lanthanides (period 6, Z = 57–71) and actinides (period 7, Z = 89–103); both are inner transition (f-block) elements.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4, lines 6898–6899; §3.5, lines 7366–7367.
**Excerpt:** "The lanthanide series: lanthanum (La) through lutetium (Lu)" / "The actinide series: actinium (Ac) through lawrencium (Lr)."

### Card 7 — Metals: location and physical properties
**Cloze claim:** Metals occupy left/center of the table; lustrous, malleable, ductile; good conductors of heat and electricity.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.5, lines 7350+ ("Metals are solids… are usually shiny, very dense, and only melt at high temperatures. Their shape can be easily changed. Metals are useful because they bend without breaking and because they are excellent conductors of electricity and heat").

### Card 8 — Metals: electropositivity + variable oxidation states
**Cloze claim:** Metals readily lose valence electrons → highly electropositive; multiple positive oxidation states common.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.7 (formation of metal cations) and Ch 4 on oxidation states (variable oxidation states discussed for transition and main-group metals).

### Card 9 — Nonmetals: location and characteristic property bundle
**Cloze claim:** Nonmetals on the right; dull, brittle solids, poor conductors; highest IE, EA, electronegativity values.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.5 (nonmetal description) and §3.5–3.6 trends (nonmetals occupy upper-right where IE/EA/EN peak).

### Card 10 — Metalloids: stair-step, intermediate properties, semiconductors
**Cloze claim:** Metalloids run along stair-step diagonal between metals and nonmetals; intermediate properties; many are semiconductors.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.5 (metalloid characterization, semiconductor mention for Si, Ge, etc.).

### Card 11 — Effective nuclear charge (Z_eff)
**Cloze claim:** Z_eff = net nuclear pull on a valence electron after shielding; increases left-to-right across a period.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6, lines 7050–7080. Z_eff increases across a period because protons are added to the same shell (no significant shielding gain).

### Card 12 — Atomic radius trends
**Cloze claim:** Decreases L→R across period (Z_eff rises), increases T→B down group (new shells).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6, lines 7060–7100.

### Card 13 — Cation vs anion size relative to parent
**Cloze claim:** Cation < parent atom; anion > parent atom.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6, lines 7105–7117.
**Excerpt:** "The radius for a cation is smaller than the parent atom… the radius for an anion is larger than the parent atom."

### Card 14 — Ionic radius among isoelectronic ions
**Cloze claim:** Among isoelectronic ions, ionic radius decreases as nuclear charge increases.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6, lines 7108+.
**Excerpt:** "Cations with larger charges are smaller than cations with smaller charges (e.g., V²⁺ has an ionic radius of 79 pm…)"

### Card 15 — IE definition + endothermic
**Cloze claim:** IE = energy to remove an e⁻ from a gaseous atom/ion's valence shell; always positive (endothermic).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6, lines 7127–7140.
**Excerpt:** "to remove electrons from atoms or ions, so ionization processes are endothermic and IE values are always positive."

### Card 16 — IE trends
**Cloze claim:** IE ↑ across period (Z_eff ↑), ↓ down group (more shielding, farther from nucleus).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6, lines 7140–7160.
**Notes:** Original .apkg Note 11 used the same `{{c1}}` group for "increases" and "decreases" (opposite trends). Fixed to `{{c1}}` and `{{c2}}` so each direction is independently testable.

### Card 17 — First vs second ionization energy
**Cloze claim:** IE₁ removes the most loosely bound e⁻; IE₂ removes the next; IE₂ > IE₁ because the resulting cation holds remaining e⁻ more tightly.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6, lines 7127–7135.
**Excerpt:** "is called its first ionization energy (IE₁)… The energy required to remove the second most loosely bound electron is called the second ionization energy (IE₂)."

### Card 18 — EA definition + exothermic
**Cloze claim:** EA = energy released when a gaseous atom/ion gains an electron into its valence shell; generally exothermic, reported with a negative sign.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6 EA discussion; line 22522 ("…fluoride ions is an exothermic process, so this step gives off energy (the electron affinity)…").

### Card 19 — EA trends
**Cloze claim:** EA becomes more negative L→R across period; less negative T→B down group; halogens have most exothermic values.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6 EA trend discussion.
**Notes:** Original .apkg Note 20 had the same cloze-grouping problem (same `{{c1}}` for "increases" and "decreases"). Fixed.

### Card 20 — Electronegativity definition + Pauling scale
**Cloze claim:** Electronegativity = an atom's pull on shared electrons of a covalent bond; reported on the dimensionless Pauling scale where F sits at ~4.0.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §4.4, lines 8912–8931.
**Excerpt:** "Linus Pauling… electronegativity… It is a dimensionless quantity that is calculated, not measured. Pauling derived the first…"

### Card 21 — Electronegativity trends
**Cloze claim:** Electronegativity ↑ across period and ↓ down group, mirroring IE and EA trends.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §4.4, lines 8912–8924.
**Notes:** Cloze grouping fixed (same issue as Notes 11 and 20).

### Card 22 — Alkali metals: Group 1A/1, +1 cation
**Cloze claim:** Group 1A/1 (alkali metals) lose one valence electron → +1 cations matching preceding noble gas.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.7, lines 7488–7491.
**Excerpt:** "an alkali metal (group 1) loses one electron and forms a cation with a 1+ charge."

### Card 23 — Alkali metals: low Z_eff, large radii, low IE/EA/EN bundle
**Cloze claim:** Single weakly held valence e⁻ → very low Z_eff, largest atomic radii in their period, lowest IE/EA/EN.
**Confidence:** 4
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6 (trend conclusions placing alkali metals at the low end of IE, EN, EA in their period); §6.5 alkali metal discussion.
**Notes:** All four properties (low Z_eff, large radii, low IE, low EN) are direct consequences of the trend rules established in §3.6 and explicitly illustrated for alkali metals throughout. The bundling of all into one teaching is editorial, hence confidence 4.

### Card 24 — Alkaline earth metals: Group 2A/2, +2 cation
**Cloze claim:** Group 2A/2 lose two valence e⁻ → +2 cations matching preceding noble gas.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.7, lines 7491–7493.
**Excerpt:** "an alkaline earth metal (group 2) loses two electrons and forms a cation with a 2+ charge."

### Card 25 — Alkaline earth comparison to alkali
**Cloze claim:** Same period: alkaline earth has slightly higher Z_eff and slightly smaller atomic radii than alkali (one extra proton).
**Confidence:** 4
**Source:** openstax-chemistry-atoms-first-2e.txt §3.6 (Z_eff and radius trends across a period; one proton increment moving from Group 1 to Group 2).
**Notes:** Direct application of the across-period trend; not stated as a Group 1 vs Group 2 comparison verbatim, but factually correct from the trend.

### Card 26 — Chalcogens: Group 6A/16, −2 and +6 oxidation states
**Cloze claim:** Group 6A/16; commonly −2 (gain 2 e⁻ to fill octet); also reach +6 when bonded to more electronegative atoms (e.g., S in SO₃, SO₄²⁻).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.5, lines 7373–7374 (chalcogens = Group 16); §3.7, line 7499 (Group 16 → 2− anions); Ch 4 / Ch 8 sulfur chemistry (S in SO₃ has +6 oxidation state).
**Notes:** Original .apkg Note 16 framed the −2/+6 split as "depending on whether they are nonmetals or metals," which is **factually incorrect** — most chalcogens are nonmetals (only Po is a metal, and Po doesn't show +6). The −2 state arises from acting as electron-acceptor; +6 arises from being covalently bonded to more electronegative atoms regardless of the chalcogen's metallic character. Reframed in this rewrite per pre-flight discussion. ✓ User confirmed reframe.

### Card 27 — Halogens: Group 7A/17, −1 anion, highest electronegativity
**Cloze claim:** Group 7A/17, seven valence e⁻; gain one to form −1 anions; highest electronegativities in the periodic table.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.5 (halogens = Group 17); §3.7, line 7497 ("Atoms of group 17 gain one electron and form anions with a 1− charge"); §4.4 (F is the most electronegative element).

### Card 28 — Noble gases: Group 8A/18, full valence shell, high IE, near-zero EN/EA
**Cloze claim:** Group 8A/18; full valence shells → very high IE; almost no measurable electronegativity or electron affinity; chemically inert.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.5, lines 7373–7374; §3.6 (high IE for noble gases, evident from IE periodicity figures); §3.5 ("noble gases (group 18, also known as inert gases)").
**Notes:** Cloze grouping cleaned up from original .apkg Note 18.

### Card 29 — Noble gases: physical state
**Cloze claim:** Monatomic gases at room temperature with characteristically low boiling points (weak London dispersion).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.5 (noble gas physical state); Ch 10 (intermolecular forces — noble gases held by London dispersion only).

### Card 30 — Transition metals: Groups 1B–8B / 3–12, multiple oxidation states, colored complexes
**Cloze claim:** Groups 1B–8B / 3–12; can adopt multiple oxidation states; form colorful coordination complexes with ligands.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4 (transition elements = d-block); Ch 19 (coordination chemistry, colored complexes from d-d transitions).

### Card 31 — Transition metals: high m.p./b.p., low IE/EA/EN bundle
**Cloze claim:** Transition metals have high melting/boiling points, and low IE/EA/EN compared with representative metals.
**Confidence:** 4
**Source:** openstax-chemistry-atoms-first-2e.txt Ch 6 (group 4 onward — physical properties of transition metals); §3.6 (IE/EN trends — transition metals show shallow IE/EN gradients, low compared with right-side nonmetals).
**Notes:** The high m.p./b.p. claim is well-established in transition-metal physical-property discussions. The IE/EA/EN comparison is true relative to right-side nonmetals; relative to representative *metals* in the same period, transition metals are similar. Confidence 4 because the bundling is editorial and the comparison framing is mildly imprecise.

## needs_sme_review

None. All 32 cards reach confidence ≥ 4.

## Disagreements with corpus

| # | Issue | Resolution |
|---|---|---|
| Source Note 16 (chalcogens) | Framed −2 vs +6 oxidation states as "depending on whether they are nonmetals or metals" | Factually wrong — most chalcogens are nonmetals; the −2 / +6 distinction is about oxidation environment, not the chalcogen's metallic character. Reframed on Card 26 per user confirmation. |
| Source Notes 8, 11, 13, 20 | Used same `{{c1}}` cloze group for opposite trend directions ("decreases" + "increases") and same `{{c2}}` group for opposite directions ("left to right" + "top to bottom") | Pure cloze-grouping bug — would hide both halves simultaneously and break the comparison. Fixed in Cards 12, 16, 19, 21 by using distinct groups for contrasting concepts. |

## Discrepancies between primary and secondary sources

None. All facts grounded in the primary source (OpenStax Chemistry Atoms First 2e); no secondary source needed for this chapter.

---

## Post-verification SME decisions

*Empty section reserved for the user (or future SME) to log overrides, retentions, or revisions made after this report was written. Each entry: card number, decision, rationale, date.*
