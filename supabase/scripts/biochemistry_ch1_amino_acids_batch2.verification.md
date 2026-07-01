# Biochemistry Ch1 — Amino Acids · Batch 2 (Acid-Base & pI) Verification Audit
**Subtopics:** pKa & Protonation States · Zwitterions & Titration Curves · Isoelectric Point (pI)  
**Source:** LibreTexts Biochemistry · Foundation 1A · discipline=biochemistry

25/25 shipped. Deduped vs 12 live amino-acid acid-base/IEF questions (no gly/ala/val/glu/asp/lys/his calcs, no IEF). 4 questions regenerated to remove serine/cysteine near-duplicate clusters. Letters 7/6/6/6; difficulty 4E/13M/8H (calculation-heavy — chapter rebalances in B3/B4).

---

## Q1 — pKa & Protonation States · **easy** · Skill 2 · 75s · conf 5
**Stem:** A solution of free cysteine is titrated, and a chemist tracks the thiol (\(-\text{SH}\)) side chain, which has a \(\text{pK}_a\) of about \(8.3\). At what solution \(\text{pH}\) are exactly half of the thiol groups present in their deprotonated (\(-\text{S}^-\)) form?

- **A.** At a \(\text{pH}\) of \(8.3\) ✅
- **B.** At a \(\text{pH}\) about \(2\) units below \(8.3\)
- **C.** At a \(\text{pH}\) about \(2\) units above \(8.3\)
- **D.** At a \(\text{pH}\) of \(7.0\)

**Correct (A):** libretexts-biochemistry.txt lines 5509-5510: "If the pH = pKa, the HH equation becomes 0 = log A/HA or 1 = A/HA. Therefore, the functional group will be 50% deprotonated." Also line 3110 (table): "pH = pKa ... 0 = log (A-/HA) ... 1 = (A-/HA) = 50/59 ... fn group 50% protonated." Thiol pKa: line 5601 "Cys (RSH, pKa 8.5-9.5)"; line 3040 "thiol ... 10" (R-group ionization table).

**Distractors:**
- **B** — _misconception_: Two units below the pKa the group is ~99% protonated (the fully-protonated extreme), not half deprotonated. LibreTexts line 5505-5506: "If the pH is 2 units below the pKa ... the functional group will be about 99% protonated." This confuses the protonated extreme with the midpoint.  
  ↳ libretexts-biochemistry.txt lines 5505-5506: "If the pH is 2 units below the pKa, the HH equation becomes -2 = log A/HA, or .01 = A/HA. This means the functional group will be about 99% protonated."
- **C** — _reversed_relationship_: Two units above the pKa the group is ~99% deprotonated (the fully-deprotonated extreme), not half. This reverses 'half' into 'essentially complete' deprotonation. LibreTexts line 5507-5508: "If the pH is 2 units above the pKa ... the functional group will be 99% deprotonated."  
  ↳ libretexts-biochemistry.txt lines 5507-5508: "If the pH is 2 units above the pKa, the HH equation becomes 2 = log A/HA, or 100 = A/HA. Therefore, the functional group will be 99% deprotonated."
- **D** — _adjacent_fact_: pH 7.0 is the neutral pH of pure water, not this group's pKa; it confuses 'neutral pH' with 'half-deprotonated pH.' Because 7.0 < 8.3, the thiol is mostly protonated here, not 50/50. Half-deprotonation depends only on the group's pKa (8.3), per LibreTexts line 5509-5510.  
  ↳ libretexts-biochemistry.txt lines 5509-5510: "If the pH = pKa ... the functional group will be 50% deprotonated." (Half-deprotonation occurs at pH = pKa = 8.3, not at pH 7.0.)

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is A because the \(\text{pK}_a\) of an ionizable group is, by definition, the \(\text{pH}\) at which that group is exactly half deprotonated. LibreTexts states this directly: "If the \(\text{pH} = \text{pK}_a\) ... the functional group will be 50% deprotonated," because the Henderson-Hasselbalch equation reduces to \(0 = \log([\text{A}^-]/[\text{HA}])\), giving \([\text{A}^-] = [\text{HA}]\) (a 50/50 mixture). Since the thiol's \(\text{pK}_a\) is \(8.3\), the half-deprotonated point is exactly \(\text{pH} = 8.3\). (Choice A) is correct: setting \(\text{pH}\) equal to the \(\text{pK}_a\) of \(8.3\) makes \([-\text{S}^-] = [-\text{SH}]\), the 50% deprotonated condition. (Choice B) is wrong because \(2\) units below the \(\text{pK}_a\) the group is about 99% protonated, not half deprotonated — that is the "fully protonated" extreme, not the midpoint. (Choice C) is wrong because \(2\) units above the \(\text{pK}_a\) the group is about 99% deprotonated, the opposite extreme from half. (Choice D) is wrong because \(\text{pH} = 7.0\) is below the \(\text{pK}_a\) of \(8.3\), so the thiol is mostly protonated; \(7.0\) is the neutral point of pure water, which is unrelated to this group's \(\text{pK}_a\). This is a Scientific Reasoning and Problem Solving question because you must apply the relationship between \(\text{pH}\) and \(\text{pK}_a\) to identify the half-deprotonation point for a specific side chain.

---

## Q2 — pKa & Protonation States · **easy** · Skill 2 · 75s · conf 5
**Stem:** The thiol side chain of a cysteine residue has \(\text{pK}_a \approx 8.4\). A free cysteine is dissolved in a buffer held at \(\text{pH} = 6\). At this \(\text{pH}\), which protonation state predominates for the thiol side chain?

- **A.** Deprotonated thiolate \(-\text{S}^-\), negatively charged
- **B.** Protonated thiol \(-\text{SH}\), neutral ✅
- **C.** Half protonated, an equal \(-\text{SH}/-\text{S}^-\) mix
- **D.** Protonated thiol \(-\text{SH}_2^+\), positively charged

**Correct (B):** libretexts-biochemistry.txt lines 5505-5506: "If the pH is 2 units below the pKa, the HH equation becomes -2 = log A/HA, or .01 = A/HA. This means the functional group will be about 99% protonated (with either 0 or +1 charge, depending on the functional group)." Reinforced at lines 3076-3077: "the acid is essentially fully protonated ... At low pH, the acid exists as HA." Thiol charge-when-protonated: line 5486 ("Cys (thiol), which have zero charges when protonated"); thiol identity: line 1116 ("The sulfur analog of an alcohol is called a thiol").

**Distractors:**
- **A** — _reversed_relationship_: This applies the pH-above-pKa rule when pH is actually below pKa. LibreTexts lines 5507-5508 say the group is ~99% deprotonated only when 'pH is 2 units above the pKa'; at pH 6 (below pKa 8.4) the thiol is protonated, not the negative thiolate -S-.  
  ↳ libretexts-biochemistry.txt lines 5507-5508: 'If the pH is 2 units above the pKa ... the functional group will be 99% deprotonated.'
- **C** — _process_step_confusion_: A 50/50 -SH/-S- mixture occurs only at pH = pKa (here pH 8.4), not at pH 6. The student confuses the half-equivalence/buffer point with a pH well below the pKa, where the group is overwhelmingly protonated.  
  ↳ libretexts-biochemistry.txt lines 5509-5510: 'If the pH = pKa ... the functional group will be 50% deprotonated.'
- **D** — _misconception_: Treats the thiol as a base that gains a proton to become a cation. A thiol is the sulfur analog of an alcohol, not an amine; it is acidic, so its protonated form is the neutral -SH (charge 0) and it cannot form -SH2+.  
  ↳ libretexts-biochemistry.txt line 5486: 'Cys (thiol), which have zero charges when protonated.' Line 1116: 'The sulfur analog of an alcohol is called a thiol.'

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is B because the side-chain \(\text{pH}\) sits below the group's \(\text{pK}_a\): \(\text{pH} = 6\) is about 2.4 units below \(\text{pK}_a = 8.4\). LibreTexts states that when the pH is 2 units below the \(\text{pK}_a\) \"the functional group will be about 99% protonated (with either 0 or +1 charge, depending on the functional group)\" (libretexts-biochemistry.txt, lines 5505-5506), and that at low pH \"the acid exists as HA\" (lines 3076-3077). For a thiol the protonated form is the reduced \(-\text{SH}\) (sulfhydryl), which carries no charge: LibreTexts lists \"Cys (thiol), which have zero charges when protonated\" (line 5486), and it loses its proton to become the negative thiolate only above the \(\text{pK}_a\). So at \(\text{pH} = 6\) the cysteine thiol is predominantly the neutral \(-\text{SH}\). (Choice B) is correct: \(\text{pH} < \text{pK}_a\) means mostly protonated, and the protonated thiol \(-\text{SH}\) is neutral. (Choice A) reverses the rule — the deprotonated, negative thiolate \(-\text{S}^-\) dominates only when \(\text{pH} > \text{pK}_a\), since \"if the pH is 2 units above the pKa ... the functional group will be 99% deprotonated\" (lines 5507-5508), which is not the case here. (Choice C) describes the 50/50 point, but \"if the pH = pKa ... the functional group will be 50% deprotonated\" (lines 5509-5510); equal protonated and deprotonated populations require \(\text{pH} = 8.4\), not 6. (Choice D) invents a cationic thiol — a thiol is the sulfur analog of an alcohol (line 1116) and is not basic, so it has no extra proton to gain; its protonated state is the neutral \(-\text{SH}\) (zero charge, line 5486), never \(-\text{SH}_2^+\). This is a Scientific Reasoning and Problem Solving question because you must apply the relationship between \(\text{pH}\) and \(\text{pK}_a\) to deduce the dominant protonation and charge state of a specific side chain.

---

## Q3 — pKa & Protonation States · **medium** · Skill 2 · 75s · conf 5
**Stem:** A biochemist examines an ionizable side chain on an amino acid residue in a buffered solution whose \(\text{pH}\) is exactly 1 unit above the group's \(\text{pK}_a\). Assuming ideal behavior, the ratio of the deprotonated form to the protonated form, \([\text{A}^-]/[\text{HA}]\), at this \(\text{pH}\) would most likely be approximately:

- **A.** \(1{:}1\)
- **B.** \(1{:}10\)
- **C.** \(10{:}1\) ✅
- **D.** \(100{:}1\)

**Correct (C):** LibreTexts Biochemistry, Ch. 3.1 (line 5536): 'or pH = pKa + log [A]/[HA] = 4.7 + log 1 = 4.7'; and Ch. 3.1 (line 5507): 'If the pH is 2 units above the pKa, the HH equation becomes 2 = log A/HA, or 100 = A/HA. Therefore, the functional group will be 99% deprotonated.'

**Distractors:**
- **A** — _process_step_confusion / forgot the pH-pKa offset_: 1:1 is the ratio only when pH = pKa; it ignores that pH is 1 unit above pKa.  
  ↳ LibreTexts Biochemistry, Ch. 3.1 (line 5509): 'If the pH = pKa, the HH equation becomes 0 = log A/HA or 1 = A/HA.'
- **B** — _reversed_relationship / inverted ratio direction_: 1:10 reverses the ratio to protonated:deprotonated (or uses pKa - pH); above the pKa the deprotonated form is favored, not the protonated form.  
  ↳ LibreTexts Biochemistry, Ch. 3.1 (line 5536): 'or pH = pKa + log [A]/[HA]' (ratio is A-/HA, deprotonated over protonated).
- **D** — _scale_unit_error / applied 2-unit rule to a 1-unit difference_: 100:1 corresponds to 2 pH units above the pKa, not 1 unit; it applies the wrong magnitude of the pH-pKa difference.  
  ↳ LibreTexts Biochemistry, Ch. 3.1 (line 5507): 'If the pH is 2 units above the pKa, the HH equation becomes 2 = log A/HA, or 100 = A/HA.'

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is C because the Henderson-Hasselbalch equation states that \(\text{pH} = \text{pK}_a + \log([\text{A}^-]/[\text{HA}])\) (LibreTexts Biochemistry, Ch. 3.1: 'or pH = pKa + log [A]/[HA] = 4.7 + log 1 = 4.7'). When the \(\text{pH}\) is 1 unit above the \(\text{pK}_a\), \(\log([\text{A}^-]/[\text{HA}]) = 1\), so \([\text{A}^-]/[\text{HA}] = 10^{1} = 10\), giving a deprotonated-to-protonated ratio of \(10{:}1\). This parallels the textbook's stated rule that 2 units above the \(\text{pK}_a\) yields \(100{:}1\) (Ch. 3.1: 'If the pH is 2 units above the pKa, the HH equation becomes 2 = log A/HA, or 100 = A/HA'), confirming that each full \(\text{pH}\) unit above \(\text{pK}_a\) multiplies the ratio by ten. (Choice A) \(1{:}1\) is incorrect: this is the ratio when \(\text{pH} = \text{pK}_a\) ('If the pH = pKa, the HH equation becomes 0 = log A/HA or 1 = A/HA'), so it ignores the \(+1\) difference between \(\text{pH}\) and \(\text{pK}_a\). (Choice B) \(1{:}10\) is incorrect: this reverses the ratio, reporting protonated-to-deprotonated (or equivalently using \(\text{pK}_a - \text{pH}\)); above the \(\text{pK}_a\) the deprotonated form dominates. (Choice C) is correct: \(\log([\text{A}^-]/[\text{HA}]) = \text{pH} - \text{pK}_a = 1\), so the ratio is \(10{:}1\) in favor of the deprotonated form. (Choice D) \(100{:}1\) is incorrect: this is the ratio for 2 units above the \(\text{pK}_a\), not 1 unit, so it overstates the difference by one order of magnitude. This is a Scientific Reasoning and Problem Solving question because you must apply the Henderson-Hasselbalch equation to a specific \(\text{pH}\)-\(\text{pK}_a\) difference and compute the resulting concentration ratio.

---

## Q4 — pKa & Protonation States · **medium** · Skill 2 · 105s · conf 5
**Stem:** A researcher dissolves free serine in a buffer held at \(\text{pH} = 7.4\). Serine's \(\alpha\)-carboxyl group has a \(\text{pK}_a\) near \(2\) and its \(\alpha\)-amino group has a \(\text{pK}_a\) near \(9.5\). At this pH, which charges do the two backbone groups contribute?

- **A.** \(\alpha\)-carboxyl \(0\); \(\alpha\)-amino \(0\)
- **B.** \(\alpha\)-carboxyl \(+1\); \(\alpha\)-amino \(-1\)
- **C.** \(\alpha\)-carboxyl \(-1\); \(\alpha\)-amino \(0\)
- **D.** \(\alpha\)-carboxyl \(-1\); \(\alpha\)-amino \(+1\) ✅

**Correct (D):** LibreTexts Biochemistry, /Users/mikkonieveras/praxis-prep/reference-textbooks/biochemistry/libretexts-biochemistry.txt, lines 3115–3116: \"If the potential acid HA is a protonated amine (RNH3+), the fully deprotonated state (RNH2) is uncharged. The fully deprotonated state has a -1 charge if it is a carboxylic acid.\" and lines 3096–3110 (pH < pKa -> mostly protonated; pH > pKa -> mostly deprotonated).

**Distractors:**
- **A** — _reversed_relationship_: Treating both groups as neutral inverts the pH-vs-pKa rule: a carboxyl is neutral only when protonated (pH < pKa), but here pH 7.4 >> pKa 2 so it is deprotonated (-1); an amine is neutral only when deprotonated (pH > pKa), but here pH 7.4 < pKa 9.5 so it stays +1.  
  ↳ LibreTexts, lines 3096–3110 (pH > pKa -> deprotonated; pH < pKa -> protonated) and 3115–3116.
- **B** — _misconception_: Swaps the sign convention for the two functional groups. Per the text a deprotonated carboxylic acid is -1 (not +1) and a protonated amine is +1 (not -1); a carboxyl can never be positive and an amine can never be negative.  
  ↳ LibreTexts, lines 3115–3116: \"...uncharged... The fully deprotonated state has a -1 charge if it is a carboxylic acid\"; line 2950 (amines become positively charged on protonation).
- **C** — _process_step_confusion_: Correctly deprotonates the carboxyl but over-deprotonates the alpha-amino, ignoring that pH 7.4 is below its pKa (~9.5); since pH < pKa the amino remains protonated at +1, not 0.  
  ↳ LibreTexts, lines 3096–3110 (pH < pKa -> ~99% protonated) and 3115–3116 (deprotonated amine is uncharged).

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is D because each group's charge is set by comparing \(\text{pH}\) to its \(\text{pK}_a\): when \(\text{pH} > \text{pK}_a\) the group is mostly deprotonated, and when \(\text{pH} < \text{pK}_a\) it is mostly protonated (LibreTexts, lines 3096–3110). At \(\text{pH} = 7.4\), the \(\alpha\)-carboxyl (\(\text{pK}_a \approx 2\)) sits well above its \(\text{pK}_a\), so it is deprotonated to \(-\text{COO}^-\); a deprotonated carboxylic acid carries a net charge of \(-1\) (lines 3115–3116: \"The fully deprotonated state has a -1 charge if it is a carboxylic acid\"). The \(\alpha\)-amino (\(\text{pK}_a \approx 9.5\)) sits below its \(\text{pK}_a\), so it stays protonated as \(-\text{NH}_3^+\), which carries \(+1\) (line 2950: amines \"become positively charged on protonation\"); the same line set notes a protonated amine becomes uncharged (\(0\)) only once it is deprotonated. The result is the zwitterion that dominates near physiological pH (line 5574). Serine's hydroxyl side chain is non-ionizable at this pH, so only the two backbone groups contribute charge. (Choice A) is wrong: it treats both groups as neutral, which would require \(\text{pH} < \text{pK}_a\) for the carboxyl and \(\text{pH} > \text{pK}_a\) for the amino — the reverse of the actual relationships here. (Choice B) reverses the sign convention, assigning \(+1\) to the carboxyl and \(-1\) to the amino; a carboxyl can only be \(0\) or \(-1\) and an amine only \(+1\) or \(0\) (lines 3115–3116). (Choice C) correctly deprotonates the carboxyl to \(-1\) but mistakenly deprotonates the \(\alpha\)-amino too, even though \(\text{pH} = 7.4\) is below its \(\text{pK}_a \approx 9.5\), so the amino is still protonated at \(+1\), not \(0\). (Choice D) is correct: \(\alpha\)-carboxyl \(-1\) and \(\alpha\)-amino \(+1\). This is a Scientific Reasoning and Problem Solving question because you must apply the \(\text{pH}\)-versus-\(\text{pK}_a\) rule to each group and translate its protonation state into the correct charge.

---

## Q5 — pKa & Protonation States · **medium** · Skill 1 · 100s · conf 5
**Stem:** A chemist dissolves a single free serine residue in pure water and notes that the molecule can both donate and accept a proton, behaving as an amphoteric species. Which pairing of backbone groups accounts for this dual acid–base behavior?

- **A.** \(\alpha\)-Carboxyl donates a proton; \(\alpha\)-amino accepts one ✅
- **B.** \(\alpha\)-Amino donates a proton; \(\alpha\)-carboxyl accepts one
- **C.** \(\alpha\)-Carboxyl both donates and accepts protons
- **D.** Side-chain hydroxyl donates; \(\alpha\)-amino accepts one

**Correct (A):** LibreTexts Biochemistry, libretexts-biochemistry.txt, lines 5477-5479: "Monomeric amino acids have an alpha-amino group and a carboxyl group, both of which may be protonated or deprotonated... When protonated, the amino group carries a +1 charge, and the carboxyl group carries a zero charge. When deprotonated, the amino group is neutral, while the carboxyl group carries a -1 charge." Cross-ref OpenStax Biology 2e, openstax-biology-2e.txt, lines 3354-3355: "This carboxyl group ionizes to release hydrogen ions (H+) from the COOH group resulting in the negatively charged COO- group."

**Distractors:**
- **B** — _reversed_relationship_: This swaps the acid and base roles. The \(\alpha\)-amino group (\(\text{pK}_a \approx 9\)) holds a proton and acts as the BASE, while the \(\alpha\)-carboxyl (\(\text{pK}_a \approx 2\)) releases a proton and acts as the ACID — the opposite of what this choice states.  
  ↳ libretexts-biochemistry.txt, lines 5478-5479: "When protonated, the amino group carries a +1 charge, and the carboxyl group carries a zero charge. When deprotonated, the amino group is neutral, while the carboxyl group carries a -1 charge." (carboxyl loses a proton = acid; amino retains/accepts a proton = base)
- **C** — _misconception_: A single \(\alpha\)-carboxyl group can only donate a proton (act as an acid); it cannot also accept one. Amphoterism requires two different groups — one acidic and one basic — not one group doing both.  
  ↳ openstax-biology-2e.txt, lines 3354-3355: "This carboxyl group ionizes to release hydrogen ions (H+) from the COOH group resulting in the negatively charged COO- group." (carboxyl only releases H+; it is solely an acid)
- **D** — _adjacent_fact_: Serine's side-chain hydroxyl is a neutral, essentially non-ionizing group in water (\(\text{pK}_a \approx 13\)) and is not the backbone acid; the \(\alpha\)-carboxyl (\(\text{pK}_a \approx 2\)) is the proton donor responsible for the molecule's acidic behavior.  
  ↳ libretexts-biochemistry.txt, lines 5485-5486: "...Glu and Asp (carboxylic acids), Tyr and Ser (alcohols), and Cys (thiol), which have zero charges when protonated." The Ser hydroxyl carries no charge under normal aqueous conditions (pKa ~13, line 5601: "Ser (ROH, pKa 13)"), so it is not the backbone acid; the \(\alpha\)-carboxyl (lines 5477-5479) is.

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is A because a free amino acid carries both an \(\alpha\)-carboxyl group and an \(\alpha\)-amino group; LibreTexts states these groups "may be protonated or deprotonated," and that "when protonated, the amino group carries a \(+1\) charge" while a carboxyl group "ionizes to release hydrogen ions" to form \(-\text{COO}^-\) (OpenStax). The carboxyl group (\(\text{pK}_a \approx 2\)) therefore acts as the ACID, donating its proton to become \(-\text{COO}^-\), and the amino group (\(\text{pK}_a \approx 9\)) acts as the BASE, holding/accepting a proton as \(-\text{NH}_3^+\); having one acidic and one basic group is exactly what makes the molecule amphoteric, and at intermediate \(\text{pH}\) both are charged, giving the net-neutral zwitterion. (Choice A) is correct: the \(\alpha\)-carboxyl is the proton donor (acid) and the \(\alpha\)-amino is the proton acceptor (base), so the molecule is both an acid and a base. (Choice B) reverses the two roles — the amino group is the base, not the acid, and the carboxyl is the acid, not the base. (Choice C) assigns both roles to one group; a single carboxyl can only act as an acid, so this cannot explain dual behavior. (Choice D) substitutes serine's neutral side-chain hydroxyl (\(\text{pK}_a \approx 13\), essentially un-ionized in water) for the \(\alpha\)-carboxyl, which is not the backbone acid responsible for amphoterism. This is a Knowledge of Scientific Concepts and Principles question because you must recall which backbone groups act as the acid and the base in a free amino acid.

---

## Q6 — pKa & Protonation States · **medium** · Skill 2 · 105s · conf 5
**Stem:** A biochemist tabulates the side-chain \(\text{pK}_a\) values for three residues she is studying: cysteine (thiol), tyrosine (phenol), and arginine (guanidinium). Working only from the chemistry of these groups, she ranks the side chains from the one that loses its side-chain proton at the LOWEST \(\text{pH}\) to the one that loses it at the HIGHEST \(\text{pH}\). Which ranking, lowest \(\text{pK}_a\) to highest, does she record?

| Residue | Side-chain group |
|---|---|
| Cysteine | thiol \((-\text{SH})\) |
| Tyrosine | phenol \((-\text{OH})\) |
| Arginine | guanidinium \((-\text{NH}^+)\) |

- **A.** Tyrosine < Cysteine < Arginine
- **B.** Cysteine < Tyrosine < Arginine ✅
- **C.** Arginine < Tyrosine < Cysteine
- **D.** Cysteine < Arginine < Tyrosine

**Correct (B):** libretexts-biochemistry.txt line 10009: "Cys (pKa =8.37), Tyr (pKa = 10.46), Arg (pKa = 12.48)" (side-chain pKa values); line 3110: "pH = pKa ... fn group 50% protonated" (pKa = the pH of half-deprotonation, so lowest pKa is lost first).

**Distractors:**
- **A** — _misconception_: Places tyrosine's phenol below cysteine's thiol, but the textbook lists the thiol at pKa 8.37 and the phenol at 10.46, so the thiol is the more acidic group and has the lower pKa; the order is Cys < Tyr, not Tyr < Cys.  
  ↳ libretexts-biochemistry.txt line 10009: "Cys (pKa =8.37), Tyr (pKa = 10.46)" (Cys pKa is below Tyr pKa).
- **C** — _reversed_relationship_: Lists the residues highest-to-lowest (Arg 12.48 > Tyr 10.46 > Cys 8.37), answering 'most acidic last' instead of the requested lowest-pKa-first ranking.  
  ↳ libretexts-biochemistry.txt line 10009: "Cys (pKa =8.37), Tyr (pKa = 10.46), Arg (pKa = 12.48)"; line 3110 defines pKa as the pH of half-deprotonation, so lowest pKa is lost first.
- **D** — _partial_truth_: Correctly keeps cysteine lowest but swaps tyrosine and arginine, putting the guanidinium (12.48) below the phenol (10.46); arginine's side chain is the least acidic and must rank highest.  
  ↳ libretexts-biochemistry.txt line 10009: "Tyr (pKa = 10.46), Arg (pKa = 12.48)" (Arg pKa exceeds Tyr pKa).

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is B because the side-chain \(\text{pK}_a\) reports the \(\text{pH}\) at which a group is half-deprotonated, so a group that gives up its proton at a lower \(\text{pH}\) has the lower \(\text{pK}_a\). The textbook lists the three side-chain \(\text{pK}_a\) values together as cysteine thiol \((\text{pK}_a = 8.37)\), tyrosine phenol \((\text{pK}_a = 10.46)\), and arginine guanidinium \((\text{pK}_a = 12.48)\), so the thiol is the most acidic, the phenol is intermediate, and the guanidinium holds its proton most tightly. Ordering lowest to highest therefore gives cysteine \((8.37)\) < tyrosine \((10.46)\) < arginine \((12.48)\). (Choice A) inverts cysteine and tyrosine, placing the phenol below the thiol, which contradicts the thiol \((8.37)\) being more acidic than the phenol \((10.46)\). (Choice B) is correct: it orders thiol < phenol < guanidinium, exactly tracking \(8.37 < 10.46 < 12.48\). (Choice C) is the full reverse ranking (highest to lowest), which would answer 'most acidic last' rather than first. (Choice D) keeps cysteine lowest but swaps tyrosine and arginine, putting the guanidinium \((12.48)\) below the phenol \((10.46)\) even though guanidinium is the least acidic of the three. This is a Scientific Reasoning and Problem Solving question because you must apply the meaning of \(\text{pK}_a\) to rank ionizable side chains by acidity.

---

## Q7 — pKa & Protonation States · **hard** · Skill 2 · 150s · conf 5
**Stem:** A peptide is dissolved in a buffer at \(\text{pH} = 7.4\). A researcher consults the following side-chain \(\text{pK}_a\) values for four of its residues to predict which side chains carry charge.

| Residue | Side-chain group | Side-chain \(\text{pK}_a\) |
|---|---|---|
| Arginine | guanidinium | 12.5 |
| Tyrosine | phenol \(-\text{OH}\) | 10.5 |
| Serine | alcohol \(-\text{OH}\) | ~13 |
| Methionine | thioether | none |

Based on these values, which residue's side chain carries a net charge at \(\text{pH} = 7.4\)?

- **A.** Arginine, a charge of \(+1\) ✅
- **B.** Tyrosine, a charge of \(-1\)
- **C.** Serine, a charge of \(-1\)
- **D.** Methionine, a charge of \(+1\)

**Correct (A):** libretexts-biochemistry.txt line 6113: "Arginine ... 12.5"; lines 6117-6119: "The deprotonated forms of Lys and Arg with lower pKbs are much stronger bases ... so at physiological pH, they would always be protonated"; line 5485: "Lys, Arg, and His, which have a + 1 charge when protonated"; lines 5505-5506: "If the pH is 2 units below the pKa ... the functional group will be about 99% protonated (with either 0 or +1 charge ...)."

**Distractors:**
- **B** — _process_step_confusion_: Tyrosine's phenol pKa is 10.5; pH 7.4 is ~3 units BELOW it, so the -OH stays protonated and neutral. Assigning -1 confuses 'pH below pKa' (protonated) with 'pH above pKa' (deprotonated). Tyr only becomes -1 well above pH 10.5.  
  ↳ libretexts-biochemistry.txt line 8280: 'At high pH, the side-chain hydroxyl is deprotonated (pKa = 10.5)'; line 5486: 'Tyr and Ser (alcohols) ... which have zero charges when protonated'; lines 5507-5508: 'If the pH is 2 units above the pKa ... will be 99% deprotonated.'
- **C** — _misconception_: The serine alcohol side chain (pKa ~13) carries zero charge when protonated and is ~5.6 units below its pKa at pH 7.4, so it does not ionize. Treating the -OH as a deprotonatable acid that reaches -1 at physiological pH is a misconception; the Ser hydroxyl does not ionize in this range.  
  ↳ libretexts-biochemistry.txt line 5486: 'Tyr and Ser (alcohols), and Cys (thiol), which have zero charges when protonated'; line 30183: 'the active site serine side chain (pKa ~ 13, not considering its environment)'.
- **D** — _adjacent_fact_: Methionine's side chain is a thioether with no ionizable proton, so it cannot carry +1 (or any) charge. Methionine is a nonpolar amino acid; only Lys, Arg, and His side chains gain a +1 charge when protonated.  
  ↳ libretexts-biochemistry.txt lines 5257-5258: 'Methionine ... The terminal methyl group is a thioether, which generally cannot form a permanent dipole'; line 5485: 'Lys, Arg, and His, which have a + 1 charge when protonated.'

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is A because when the \(\text{pH}\) is more than 2 units below a group's \(\text{pK}_a\), that group is about 99% protonated, and a protonated guanidinium side chain carries a charge of \(+1\). Arginine's side-chain \(\text{pK}_a\) is 12.5, and \(\text{pH} = 7.4\) is about 5 units below it (\(12.5 - 7.4 = 5.1\)), so the side chain stays protonated and \(+1\); the textbook notes that at physiological \(\text{pH}\) Lys and Arg "would always be protonated." (Choice A) is correct: arginine's guanidinium stays protonated and carries a charge of \(+1\) at \(\text{pH} = 7.4\). (Choice B) is wrong because tyrosine's phenol \(\text{pK}_a\) is 10.5, and \(\text{pH} = 7.4\) is ~3 units below it, so the \(-\text{OH}\) stays protonated and neutral; it would only become \(-1\) well above its \(\text{pK}_a\). (Choice C) is wrong because the serine alcohol \(-\text{OH}\) (\(\text{pK}_a \approx 13\)) carries zero charge when protonated and is nowhere near deprotonation at \(\text{pH} = 7.4\), so it never reaches \(-1\) under physiological conditions. (Choice D) is wrong because the methionine thioether side chain has no ionizable proton and cannot carry any charge. This is a Scientific Reasoning and Problem Solving question because you must apply the relationship between \(\text{pH}\) and \(\text{pK}_a\) to a set of side-chain \(\text{pK}_a\) values to reason toward which residue is charged.

---

## Q8 — pKa & Protonation States · **hard** · Skill 2 · 150s · conf 5
**Stem:** A researcher dissolves free tyrosine, methionine, arginine, and asparagine separately in buffer held at \(\text{pH} = 7.4\) and asks which side chains carry a charge under these conditions. Consider the following statements about the side-chain (R-group) ionizable groups at \(\text{pH} = 7.4\):

I. The guanidinium group of arginine (side-chain \(\text{pK}_a \approx 12.5\)) is protonated and bears a charge of \(+1\).
II. The phenol group of tyrosine (side-chain \(\text{pK}_a \approx 10.5\)) is deprotonated and bears a charge of \(-1\).
III. The side chain of asparagine carries no charge.

Which of the statements are correct?

- **A.** I only
- **B.** III only
- **C.** I and III only ✅
- **D.** II and III only

**Correct (C):** libretexts-biochemistry.txt lines 10008-10009: "When considering which amino acid's pKa to choose for pI calculation, you first need to determine which in the peptide can contribute to a charge on the molecule. For vasopressin, that would be Cys (pKa =8.37), Tyr (pKa = 10.46), Arg (pKa = 12.48)..."; lines 6117-6118: "The deprotonated forms of Lys and Arg with lower pKbs are much stronger bases than the deprotonated form of His, so at physiological pH, they would always be protonated"; lines 5300-5301 (asparagine amide non-basic): "The lone pair is delocalized into the peptide bond (via resonance), so it is unavailable for sharing"; lines 3106-3108 (protonation rule): "2 units > pKa (more basic, expect deprotonated)... fn group about 99% deprotonated."

**Distractors:**
- **A** — _partial_truth_: Statement I is genuinely correct (arginine's guanidinium, pKa 12.48 > 7.4, is protonated and +1 per lines 10009 and 6117-6118), but choosing 'I only' wrongly rejects the equally true Statement III. Asparagine's amide side chain is non-ionizable (its lone pair is delocalized into the C=O bond, lines 5300-5301), so it indeed carries no charge and Statement III must be included.  
  ↳ libretexts-biochemistry.txt lines 5300-5301: "The lone pair is delocalized into the peptide bond (via resonance), so it is unavailable for sharing."
- **B** — _partial_truth_: Statement III is correct (asparagine's amide cannot ionize, lines 5297-5301), but choosing 'III only' wrongly rejects the true Statement I. Arginine's guanidinium has pKa 12.48; because 7.4 < 12.48, it stays protonated and bears +1, so Statement I is also correct and must be included.  
  ↳ libretexts-biochemistry.txt lines 10008-10009 (Arg pKa = 12.48) and lines 6117-6118: at physiological pH Lys and Arg "would always be protonated."
- **D** — _reversed_relationship_: This accepts the false Statement II by reversing the pH-vs-pKa rule. Tyrosine's phenol has pKa = 10.46; since 7.4 < 10.46 the group is mostly PROTONATED (neutral -OH), not deprotonated/negative. Treating it as deprotonated assumes pH 7.4 lies above the pKa, the opposite of the correct comparison.  
  ↳ libretexts-biochemistry.txt lines 10003-10004: "At a pH of 6 there is not enough hydroxide present to deprotonate the -OH of Tyr, so there is no charge as its pKa is 10.46"; line 10009 (Tyr pKa = 10.46); line 8280 (side-chain hydroxyl deprotonated at high pH, pKa = 10.5).

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is C because applying the protonation rule (when \(\text{pH} < \text{pK}_a\) a group is mostly protonated; when \(\text{pH} > \text{pK}_a\) it is mostly deprotonated) to each side chain at \(\text{pH} = 7.4\) shows that only arginine (Statement I) and asparagine (Statement III) are described correctly. Arginine's guanidinium side chain has \(\text{pK}_a \approx 12.5\); because \(7.4 < 12.5\), the group stays protonated and bears a charge of \(+1\) (the textbook lists Arg \(\text{pK}_a = 12.48\) and states Arg \"would always be protonated\" at physiological pH), so I is correct. Asparagine's side chain is an amide whose lone pair is delocalized into the \(\text{C=O}\) bond, so it is non-ionizable and never carries a charge, making III correct. Tyrosine's phenol has \(\text{pK}_a \approx 10.5\) (textbook Tyr \(\text{pK}_a = 10.46\)); since \(7.4 < 10.46\), it is still protonated (neutral \(-\text{OH}\)), NOT deprotonated, so Statement II is false. (Choice A) is wrong because it omits the true Statement III about asparagine. (Choice B) is wrong because it omits the true Statement I about arginine. (Choice C) is correct: I and III are the only accurate statements, because arginine (\(7.4 < 12.5\)) is protonated and charged while asparagine's amide cannot ionize. (Choice D) is wrong because it accepts the false Statement II — it reverses the protonation logic, treating \(7.4 > 10.5\) when in fact \(7.4 < 10.5\), so tyrosine's phenol is protonated and neutral, not negatively charged. This is a Scientific Reasoning and Problem Solving question because you must apply the relationship between \(\text{pH}\) and \(\text{pK}_a\) to each side chain to deduce its protonation and charge state.

---

## Q9 — Zwitterions & Titration Curves · **easy** · Skill 1 · 70s · conf 5
**Stem:** An amino acid with a non-ionizable side chain is dissolved near neutral \(\text{pH}\), where it exists predominantly as a zwitterion with a net charge of zero. A student reasons that "net zero" describes the molecule's overall charge but may not describe its individual groups. Which charge configuration on the \(\alpha\)-groups most likely accounts for this net-zero zwitterion?

- **A.** No charge on either \(\alpha\)-group
- **B.** A single \(+1\) charge overall
- **C.** A single \(-1\) charge overall
- **D.** Both a \(+1\) and a \(-1\) charge ✅

**Correct (D):** libretexts-biochemistry.txt lines 5478-5479: "When protonated, the amino group carries a +1 charge, and the carboxyl group carries a zero charge. When deprotonated, the amino group is neutral, while the carboxyl group carries a -1 charge."

**Distractors:**
- **A** — _misconception_: This treats a net charge of zero as meaning no charges are present. A zwitterion is net-zero because it carries both a +1 and a -1; near neutral pH the carboxyl is deprotonated (-1) and the amino group protonated (+1), so neither alpha-group is uncharged.  
  ↳ libretexts-biochemistry.txt lines 5478-5479: 'When protonated, the amino group carries a +1 charge... When deprotonated... the carboxyl group carries a -1 charge.'
- **B** — _adjacent_fact_: A single net +1 charge describes the fully protonated cationic form, in which the carboxyl is still protonated (charge 0) and the amino group is protonated (+1). That form dominates only at very low pH, not the net-zero zwitterion near neutral pH.  
  ↳ libretexts-biochemistry.txt line 5560: 'At a pH of 2, all ionizable groups would be protonated, and the overall charge of the protein would be positive.'
- **C** — _adjacent_fact_: A single net -1 charge describes the anionic form present only at high pH, after both the carboxyl and the alpha-amino group have been deprotonated. It is not the net-zero zwitterion that predominates near neutral pH.  
  ↳ libretexts-biochemistry.txt lines 5562-5563: 'At high pH, all the ionizable groups will become deprotonated... and the overall charge... will be negative.'

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is D because a zwitterion is a dipolar ion: its net charge is zero, but that zero arises from a full positive and a full negative charge that coexist on the molecule, not from the absence of charge. The LibreTexts text states that "when protonated, the amino group carries a +1 charge," and that "when deprotonated... the carboxyl group carries a -1 charge." Near neutral pH the \(\alpha\)-carboxyl (\(\text{pK}_a \approx 2\)) is deprotonated to \(-\text{COO}^-\) (charge \(-1\)) while the \(\alpha\)-amino (\(\text{pK}_a \approx 9{-}10\)) stays protonated as \(-\text{NH}_3^+\) (charge \(+1\)); the side chain contributes nothing, so the two opposite charges sum to a net of zero. (Choice A) is wrong: a molecule with no charge on either \(\alpha\)-group is not a zwitterion, and at neutral pH the carboxyl is deprotonated (\(-1\)) and the amino group protonated (\(+1\)) rather than both neutral. (Choice B) is wrong: a single net \(+1\) charge describes the fully protonated cation that dominates only at very low pH, not the net-neutral zwitterion. (Choice C) is wrong: a single net \(-1\) charge describes the anion that dominates only at high pH, after the \(\alpha\)-amino group has been deprotonated. (Choice D) is correct: the simultaneous \(+1\) on \(-\text{NH}_3^+\) and \(-1\) on \(-\text{COO}^-\) is exactly what makes the species a net-zero dipolar zwitterion. This is a Knowledge of Scientific Concepts and Principles question because you must recall that a zwitterion carries equal and opposite charges that sum to a net of zero.

---

## Q10 — pKa & Protonation States · **medium** · Skill 2 · 120s · conf 5
**Stem:** A biochemist studying the active site of an mRNA-capping enzyme finds that an active-site tyrosine, whose phenolic side chain has a \(\text{pK}_a\) of 10.1, is functioning as a general acid. Under the local conditions, the side chain is measured to be 75% deprotonated (ionized). Applying the Henderson-Hasselbalch equation, the local \(\text{pH}\) is most likely closest to which value?

- **A.** Approximately 9.62
- **B.** Approximately 10.58 ✅
- **C.** Approximately 10.10
- **D.** Approximately 9.98

**Correct (B):** libretexts-biochemistry.txt lines 4867-4880 (active-site tyrosine 75% ionized; 'pH = 10.1 + (0.477)'; 'pH = 10.58') and line 5536 ('pH = pKa + log [A]/[HA]').

**Distractors:**
- **A** — _reversed_relationship_: Subtracts the log term instead of adding it (10.1 - 0.477 = 9.62), or equivalently inverts the ratio to 25/75; this puts pH below the pKa and predicts a majority-protonated side chain, contradicting the stated 75%-ionized condition.  
  ↳ libretexts-biochemistry.txt lines 5505-5510 (pH below pKa => functional group is majority protonated) and line 5536 (pH = pKa + log [A]/[HA]).
- **C** — _process_step_confusion_: Reports the pKa (10.1) itself, ignoring the 75% datum; pH equals pKa only at half-dissociation, where [A-]=[HA] (50% ionized), not at 75% ionized.  
  ↳ libretexts-biochemistry.txt lines 5509-5510 ('If the pH = pKa ... the functional group will be 50% deprotonated').
- **D** — _partial_truth_: Uses the correct equation but inserts the percentage 0.75 as the ratio (log 0.75 = -0.125, giving 10.1 - 0.125 = 9.98) instead of forming [A-]/[HA] = 75/25 = 3; the equation requires the ratio of the two species, not the bare fraction ionized.  
  ↳ libretexts-biochemistry.txt line 5536 ('pH = pKa + log [A]/[HA]') and lines 4879-4880 (worked ratio 75/25 -> log = 0.477).

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is B because the Henderson-Hasselbalch equation, \(\text{pH} = \text{pK}_a + \log\left(\frac{[\text{A}^-]}{[\text{HA}]}\right)\), relates pH to the ratio of deprotonated to protonated side chain. LibreTexts writes this form explicitly as "pH = pKa + log [A]/[HA]" (line 5536). A side chain that is 75% deprotonated has \([\text{A}^-]/[\text{HA}] = 75/25 = 3\), and \(\log(3) = 0.477\), so \(\text{pH} = 10.1 + 0.477 \approx 10.58\). This reproduces the textbook worked example, which uses an active-site tyrosine that is "75% ionized" and computes "pH = 10.1 + (0.477)" giving "pH = 10.58" (lines 4867-4880); the same passage notes that tyrosine's R-group "can act as either an acid or base" (lines 4864-4865). Because the side chain is more than half deprotonated, the pH must lie above the \(\text{pK}_a\) of 10.1. (Choice A) Approximately 9.62 results from subtracting the log term instead of adding it (\(10.1 - 0.477\)), or equivalently from inverting the ratio to \(25/75\); this places the pH below the \(\text{pK}_a\), which would predict a majority-protonated side chain, contradicting the 75%-ionized datum (LibreTexts 5505-5510). (Choice B) is correct: adding \(\log(3) = 0.477\) to the \(\text{pK}_a\) of 10.1 gives \(\text{pH} \approx 10.58\), matching the textbook calculation (lines 4879-4880, 5536). (Choice C) Approximately 10.10 is simply the \(\text{pK}_a\); this answer ignores the 75% datum and treats the residue as 50% ionized, but pH equals \(\text{pK}_a\) only at half-dissociation, where \([\text{A}^-]=[\text{HA}]\) (lines 5509-5510). (Choice D) Approximately 9.98 comes from plugging "75%" in as the ratio itself (\(\log 0.75 = -0.125\), giving \(10.1 - 0.125\)) rather than forming the correct \([\text{A}^-]/[\text{HA}] = 75/25 = 3\); the equation requires the ratio of the two species, not the lone percentage (line 5536). This is a Scientific Reasoning and Problem Solving question because you must apply the Henderson-Hasselbalch equation to a described situation, convert a percent-ionized value into the correct concentration ratio, and solve for pH.

---

## Q11 — Zwitterions & Titration Curves · **medium** · Skill 2 · 105s · conf 5
**Stem:** A student titrates a pure solution of leucine, a nonpolar amino acid whose side chain is an isobutyl group, from strongly acidic to strongly basic pH while recording the curve of pH versus added base. As she interprets the resulting curve, how many distinct buffering plateaus (regions where \(\text{pH} = \text{pK}_a\)) should she expect to observe?

- **A.** Two plateaus ✅
- **B.** Three plateaus
- **C.** One plateau
- **D.** Four plateaus

**Correct (A):** libretexts-biochemistry.txt, lines 3158-3162: "all amino acids have an amine and carboxylic acid group, and some have an additional ionizable side chain. Each has its pKa values. Those with three ionizable groups are triprotic acids... If the pKa values are separated enough, three general plateaus, each centered at the pKa value of the ionizable group, can be seen in their titration curves." Line 5516: "Titration curves for Gly (no ionizable side chain)..." Line 3151: "the titration plot of pH vs NaOH... has multiple plateaus at pH=pKa."

**Distractors:**
- **B** — _adjacent_fact_: Three plateaus is the count for a triprotic amino acid bearing an ionizable side chain (e.g., Glu or Lys), not for a nonpolar amino acid. The textbook ties the third plateau to 'an additional ionizable side chain'; leucine's isobutyl group is not ionizable, so no third plateau forms.  
  ↳ libretexts-biochemistry.txt, lines 3158-3161: 'some have an additional ionizable side chain... three general plateaus, each centered at the pKa value of the ionizable group, can be seen in their titration curves.'
- **C** — _process_step_confusion_: Counting only one plateau treats leucine as if it had a single ionizable group, conflating the molecule with a monoprotic acid and ignoring that the alpha-amino group deprotonates at its own pKa separately from the alpha-carboxyl. Each plateau is centered where pH = pKa, and there are two such pKa values.  
  ↳ libretexts-biochemistry.txt, line 3151: 'the titration plot of pH vs NaOH... has multiple plateaus at pH=pKa'; line 5501: 'At the curve's inflection point, pH = pKa.'
- **D** — _misconception_: Four plateaus over-counts the ionizable groups by treating the nonpolar isobutyl side chain (a saturated hydrocarbon with no acidic or basic proton) as titratable. Leucine has only two ionizable groups, so the plateau count cannot exceed two.  
  ↳ libretexts-biochemistry.txt, lines 3158-3161: 'all amino acids have an amine and carboxylic acid group, and some have an additional ionizable side chain. Each has its pKa values'; line 5516: 'Gly (no ionizable side chain).'

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is A because the number of buffering plateaus on a titration curve equals the number of ionizable groups, and leucine has exactly two: the \(\alpha\)-carboxyl (\(-\text{COOH}\), \(\text{pK}_a \approx 2\)) and the \(\alpha\)-amino (\(-\text{NH}_3^+\), \(\text{pK}_a \approx 9.6\)). The textbook states that 'all amino acids have an amine and carboxylic acid group, and some have an additional ionizable side chain. Each has its pK_a values... three general plateaus, each centered at the pK_a value of the ionizable group, can be seen in their titration curves' (libretexts-biochemistry.txt, lines 3158-3161), and it explicitly treats glycine as having 'no ionizable side chain' (line 5516). Leucine's isobutyl side chain is a saturated hydrocarbon with no acidic or basic proton, so it contributes no plateau; the curve therefore shows only the two terminal-group plateaus, each centered where \(\text{pH} = \text{pK}_a\) (line 3151). (Choice A) is correct: two ionizable groups (\(\alpha\)-carboxyl and \(\alpha\)-amino) give two pK_a values and thus two buffering plateaus. (Choice B) is wrong because a third plateau would require a third ionizable group; three plateaus describe a triprotic amino acid with an ionizable side chain (e.g., Glu, Lys), not a nonpolar one like leucine. (Choice C) is wrong because it counts the molecule as if it had a single ionizable group, ignoring that the \(\alpha\)-amino group titrates separately from the \(\alpha\)-carboxyl. (Choice D) is wrong because it over-counts ionizable groups, treating the nonpolar isobutyl side chain (and an imagined extra group) as titratable when it has no ionizable proton. This is a Scientific Reasoning and Problem Solving question because you must apply the rule that plateau count equals ionizable-group count to reason from leucine's structure to the shape of its titration curve.

---

## Q12 — Zwitterions & Titration Curves · **medium** · Skill 4 · 110s · conf 5
**Stem:** A student titrates a pure amino acid from low to high pH and records the curve summarized below. Two flat buffering regions appear and no others are detected across the measured range.

| Buffering region | Center (pH) |
|---|---|
| Region 1 | ~2.1 |
| Region 2 | ~9.1 |

Assuming each flat region marks a distinct ionizable group, the data are most consistent with which amino acid?

- **A.** Glutamate
- **B.** Histidine
- **C.** Serine ✅
- **D.** Arginine

**Correct (C):** libretexts-biochemistry.txt lines 3160-3161: "If the pKa values are separated enough, three general plateaus, each centered at the pKa value of the ionizable group, can be seen in their titration curves." And line 5564 (3.1.10 Isoelectric Point): "The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." Serine's side chain is a hydroxyl (line 5263, "the hydroxyl- and sulfhydryl-containing amino acids, serine, threonine, and cysteine"; line 5601, "Ser (ROH, pKa 13)"), which does not titrate in the standard range, so serine shows only two buffering regions and pI = (2.1 + 9.1)/2 = 5.6.

**Distractors:**
- **A** — _adjacent_fact_: Glutamate carries an acidic carboxyl side chain (pKa ~4), giving it three ionizable groups and therefore a third buffering region; a curve with only two flat regions cannot be glutamate.  
  ↳ libretexts-biochemistry.txt lines 5264-5265: 'glutamic acid (glutamate), and aspartic acid (aspartate) constitute the acidic amino acids and contain side chains with carboxylic acid functional groups capable of fully ionizing in solution'; lines 3160-3161: amino acids with three ionizable groups show three plateaus, one centered at each pKa.
- **B** — _adjacent_fact_: Histidine's imidazole side chain (pKa ~6.5) is a third ionizable group that would create a buffering region between the two shown, so a two-region curve is inconsistent with histidine.  
  ↳ libretexts-biochemistry.txt line 5266: 'The basic amino acids, lysine, arginine, and histidine, contain amine functional groups that can be protonated to carry a full charge'; line 5601: 'His (pKa 6-7)'; line 6161: His 'pKa of about 6.5'; lines 3160-3161: three ionizable groups give three plateaus.
- **D** — _adjacent_fact_: Arginine's guanidinium side chain (pKa ~12) is a third ionizable group, producing a third buffering region at high pH; with only two flat regions detected the amino acid cannot be arginine.  
  ↳ libretexts-biochemistry.txt line 5266: 'The basic amino acids, lysine, arginine, and histidine, contain amine functional groups that can be protonated to carry a full charge'; line 10009: 'Arg (pKa = 12.48)'; lines 3160-3161: amino acids with three ionizable groups show three plateaus, one centered at each pKa.

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is C because each flat (buffering) region of a titration curve is centered at the \(\text{pK}_a\) of one ionizable group, so two regions mean exactly two ionizable groups. A region near \(\text{pH} = 2.1\) fits the \(\alpha\)-\(\text{COOH}\) and a region near \(\text{pH} = 9.1\) fits the \(\alpha\)-\(\text{NH}_3^+\); the absence of a third region means there is no ionizable side chain in the measured range. Serine's only side-chain group is a hydroxyl with a very high \(\text{pK}_a\) (~13), so it does not titrate here, leaving just two buffering regions; its \(\text{pI} = (2.1 + 9.1)/2 = 5.6\), the average of the two \(\text{pK}_a\) values flanking the neutral zwitterion. (Choice A) is incorrect: glutamate's acidic carboxyl side chain (\(\text{pK}_a\) ~4) would add a third buffering region, giving three flat regions, not two. (Choice B) is incorrect: histidine's imidazole side chain (\(\text{pK}_a\) ~6.5) would produce a third buffering region between the two shown. (Choice C) is correct: with only an \(\alpha\)-\(\text{COOH}\) (~2.1) and an \(\alpha\)-\(\text{NH}_3^+\) (~9.1) titrating, serine shows exactly two buffering regions and behaves as a two-ionizable-group amino acid. (Choice D) is incorrect: arginine's guanidinium side chain (\(\text{pK}_a\) ~12) is a third ionizable group, so its curve would show a third buffering region at high pH. This is a Data-based and Statistical Reasoning question because you must interpret the number and position of buffering regions in the titration data and reason from that pattern back to the amino acid's ionizable-group count.

---

## Q13 — Zwitterions & Titration Curves · **medium** · Skill 2 · 105s · conf 5
**Stem:** A peptide contains a single tyrosine residue whose phenolic side chain has the \(\text{pK}_a\) values shown in the table below. A researcher wants to dissolve the peptide in a solution in which this phenol group most strongly resists changes in \(\text{pH}\).

| Ionizable group | \(\text{pK}_a\) |
|---|---|
| \(\alpha\text{-COOH}\) | 2.2 |
| \(\alpha\text{-NH}_3^+\) | 9.1 |
| Tyr phenol (\(-\text{OH}\)) | 10.5 |

At which \(\text{pH}\) does the tyrosine phenol provide the greatest buffering capacity?

- **A.** \(\text{pH} = 7.4\)
- **B.** \(\text{pH} = 12.5\)
- **C.** \(\text{pH} = 9.5\)
- **D.** \(\text{pH} = 10.0\) ✅

**Correct (D):** libretexts-biochemistry.txt lines 3377-3378: "To review, buffer solutions contain a weak acid and its conjugate base. They have a maximal buffering capacity at a pH equal to the weak acid's pKa. Generally, a buffered solution can best withstand a change in pH of only + 1 pH unit from the pKa." Tyrosine side-chain phenol pKa from line 8280: "the side-chain hydroxyl is deprotonated (pKa = 10.5)" (also line 10009: "Tyr (pKa = 10.46)").

**Distractors:**
- **A** — _partial_truth_: pH 7.4 is physiological pH, but it lies 3.1 units below the phenol pKa of 10.5, far outside the +/-1 buffering window; at this pH the phenol is essentially fully protonated (-OH) with almost no conjugate base (-O-) to absorb added acid. Per lines 3377-3378, buffering is maximal at pH = pKa and limited to about +/-1 unit. This is a 510-tempting trap because students default to physiological pH.  
  ↳ libretexts-biochemistry.txt lines 3377-3378 (maximal buffering at pH = pKa, +/- 1 unit) and line 3110 (at pH = pKa the group is '50% protonated')
- **B** — _process_step_confusion_: pH 12.5 is 2.0 units ABOVE the phenol pKa of 10.5, outside the +/-1 window; here the phenol is essentially fully deprotonated (-O-) with little weak acid remaining to neutralize added base. This results from adding 2 to the pKa instead of recognizing that buffering centers ON the pKa, or from confusing the Tyr phenol with the Arg guanidinium (pKa ~12.5). Lines 3377-3378 require the pH to lie within +/-1 of the pKa.  
  ↳ libretexts-biochemistry.txt lines 3377-3378 (buffering window centered at pKa, +/- 1 unit); line 3161 (titration-curve plateaus 'centered at the pKa value')
- **C** — _partial_truth_: pH 9.5 lies within the buffering window, but it sits exactly 1.0 unit below the phenol pKa of 10.5 (the outer edge), so it buffers LESS effectively than pH 10.0, which is only 0.5 unit from the pKa. The question asks for the GREATEST buffering capacity, which occurs nearest pH = pKa per lines 3377-3378. A test-taker who knows the +/-1 rule but stops at the edge rather than finding the value closest to the pKa selects this.  
  ↳ libretexts-biochemistry.txt lines 3377-3378 ("maximal buffering capacity at a pH equal to the weak acid's pKa")

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is D because a weak acid group buffers best when the solution \(\text{pH}\) is near its \(\text{pK}_a\): the textbook states that buffers have a "maximal buffering capacity at a pH equal to the weak acid's pKa," and that "a buffered solution can best withstand a change in pH of only + 1 pH unit from the pKa." For the tyrosine phenol, \(\text{pK}_a = 10.5\), so the effective buffering window is roughly \(9.5 \le \text{pH} \le 11.5\). Of the choices, only \(\text{pH} = 10.0\) lies near the center of this window (\(|10.0 - 10.5| = 0.5\)), where the phenol exists as a comparable mixture of protonated \(-\text{OH}\) and deprotonated \(-\text{O}^-\) and can absorb either added acid or added base. (Choice A) \(\text{pH} = 7.4\) is the tempting physiological value, but it lies \(3.1\) units below the \(\text{pK}_a\), far outside the \(\pm 1\) window; here the phenol is essentially fully protonated (\(-\text{OH}\)) with almost no conjugate base to neutralize added acid. (Choice B) \(\text{pH} = 12.5\) is \(2.0\) units above the \(\text{pK}_a\), outside the window; here the phenol is essentially fully deprotonated (\(-\text{O}^-\)) with little weak acid left to neutralize added base. (Choice C) \(\text{pH} = 9.5\) lies within the window but sits exactly \(1.0\) unit below the \(\text{pK}_a\) (the very edge of the window), so it buffers less effectively than \(\text{pH} = 10.0\), which is much closer to \(10.5\). (Choice D) is correct: \(\text{pH} = 10.0\) is closest to the phenol \(\text{pK}_a\) of \(10.5\), giving the greatest buffering capacity. This is a Scientific Reasoning and Problem Solving question because you must apply the relationship between \(\text{pK}_a\) and buffering range to a specific \(\text{pK}_a\) value and select the \(\text{pH}\) that maximizes buffering.

---

## Q14 — Zwitterions & Titration Curves · **hard** · Skill 4 · 160s · conf 5
**Stem:** A biochemist titrates serine, whose side-chain hydroxyl (\(\text{pK}_a \approx 13\)) stays protonated across the experimental range, leaving two relevant ionizations.

| Ionizable group | \(\text{pK}_a\) |
|---|---|
| \(\alpha\text{-COOH}\) | 2.2 |
| \(\alpha\text{-NH}_3^+\) | 9.2 |

The titration curve below shows a buffering plateau centered near \(\text{pH} = 2.2\), a long rise, then a second plateau centered near \(\text{pH} = 9.2\). Over which pH range does the zwitterionic (net-zero) form predominate?

- **A.** Below 2.2 and above 9.2
- **B.** Between pH 2.2 and 9.2 ✅
- **C.** Only at pH 5.7
- **D.** Between pH 9.2 and 13

**Correct (B):** LibreTexts Biochemistry, /Users/mikkonieveras/praxis-prep/reference-textbooks/biochemistry/libretexts-biochemistry.txt, lines 5558-5565: "At a pH of 2, all ionizable groups would be protonated, and the overall charge of the protein would be positive... As pH increases, the most acidic groups will begin to deprotonate, and the net charge will become less positive. At high pH, all the ionizable groups will become deprotonated... At some pH, then, the net charge will be 0. This pH is called the isoelectric point (pI). The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." Also lines 5505-5510 (the +-2 rule: pH 2 units above pKa -> 99% deprotonated; pH 2 units below -> 99% protonated) and lines 3160-3162 (plateaus centered at each pKa value). Serine side-chain pKa 13: line 5601 "Ser (ROH, pKa 13)".

**Distractors:**
- **A** — _reversed_relationship_: This inverts where the zwitterion lives. Below pH 2.2 BOTH groups are protonated, giving the fully cationic +1 form; above pH 9.2 BOTH are deprotonated, giving the anionic -1 form. The net-neutral zwitterion predominates BETWEEN the two flanking pKa values, not outside them. Per lines 5560-5563, low pH gives net positive and high pH gives net negative.  
  ↳ LibreTexts Biochemistry, libretexts-biochemistry.txt, lines 5560-5563: 'At a pH of 2, all ionizable groups would be protonated, and the overall charge of the protein would be positive... At high pH, all the ionizable groups will become deprotonated... and the overall charge of the protein will be negative.'
- **C** — _partial_truth_: pH 5.7 is correctly the pI = (2.2 + 9.2)/2, the point of MAXIMUM zwitterion fraction and net-zero average charge. But the question asks where the zwitterion PREDOMINATES, which is the entire interval between the two flanking pKa values, not the single isoelectric pH. Treating the net-zero condition as one point rather than a predominance range is the error.  
  ↳ LibreTexts Biochemistry, libretexts-biochemistry.txt, lines 5564-5565: 'The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI.' (pI = (2.2+9.2)/2 = 5.7 is a single pH, not the predominance window.)
- **D** — _process_step_confusion_: This selects the wrong pair of pKa values, using the side-chain hydroxyl pKa of 13 as a boundary. The serine -OH stays protonated and uncharged across the entire experimental range, so it is NOT one of the two groups flanking the neutral form; the flanking values are alpha-COOH (2.2) and alpha-NH3+ (9.2). Between pH 9.2 and 13 the molecule is already net -1, not a zwitterion.  
  ↳ LibreTexts Biochemistry, libretexts-biochemistry.txt, line 5601: 'Ser (ROH), pKa 13' (the hydroxyl does not ionize in the normal pH range), and lines 5564-5565 (pI uses the two groups 'closest to and on either side of the pI,' i.e., 2.2 and 9.2, not 13).

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is B because the zwitterion is the net-neutral species that flanks the isoelectric point, and it predominates over the entire pH interval bracketed by the two \(\text{pK}_a\) values closest to it. Applying the \(\pm 2\) rule, above \(\text{pH} = 2.2\) the \(\alpha\text{-COOH}\) is mostly deprotonated to \(-\text{COO}^-\) (charge \(-1\)), while below \(\text{pH} = 9.2\) the \(\alpha\text{-NH}_3^+\) is still mostly protonated (charge \(+1\)); the two charges cancel to a net charge of \(0\) throughout that window. The textbook notes that as pH rises the most acidic group deprotonates first and the net charge passes through zero, with the \(\text{pI}\) found by averaging the two \(\text{pK}_a\) values on either side of the neutral species: \(\text{pI} = (2.2 + 9.2)/2 = 5.7\) — but 5.7 is the single point of maximum zwitterion fraction, not the boundary of where it predominates. (Choice A) is incorrect: below \(\text{pH} = 2.2\) both groups are protonated, giving the fully cationic \(+1\) form, and above \(\text{pH} = 9.2\) both are deprotonated, giving the anionic \(-1\) form — the zwitterion does NOT predominate there. (Choice B) is correct: between the two flanking \(\text{pK}_a\) values the species carries one \(+\) and one \(-\) for a net charge of \(0\). (Choice C) is incorrect: \(\text{pH} = 5.7\) is the \(\text{pI}\), where the zwitterion is at its maximum, but it still predominates across the whole interval, not at a single pH. (Choice D) is incorrect: this range uses the non-ionizing side-chain \(\text{pK}_a\) of 13 as a boundary, the wrong pair of values; the hydroxyl stays protonated and does not flank the neutral form. This is a Data-based and Statistical Reasoning question because you must interpret the titration table and curve to map plateau positions onto protonation states and locate the net-zero predominance window.

---

## Q15 — Zwitterions & Titration Curves · **hard** · Skill 2 · 165s · conf 5
**Stem:** A student titrates a purified amino acid from low to high pH and records a curve with three distinct buffering plateaus, each centered at a different \(\text{pK}_a\). Considering what three plateaus reveal about the molecule's ionizable groups, which statement(s) can be inferred from this curve alone?

I. The amino acid carries an ionizable side chain in addition to its \(\alpha\)-groups.
II. The side chain must be a carboxylic acid rather than a basic group.
III. The \(\text{pI}\) equals the average of the two lowest \(\text{pK}_a\) values.

- **A.** I only ✅
- **B.** III only
- **C.** I and III only
- **D.** II and III only

**Correct (A):** LibreTexts Biochemistry, lines 3158-3162: "all amino acids have an amine and carboxylic acid group, and some have an additional ionizable side chain. Each has its pKa values. Those with three ionizable groups are triprotic acids... If the pKa values are separated enough, three general plateaus, each centered at the pKa value of the ionizable group, can be seen in their titration curves." Cross-ref lines 5102-5104: every alpha amino acid contains a carboxylic acid and an amine group separated by the alpha carbon.

**Distractors:**
- **B** — _process_step_confusion_: Selects statement III, which misstates the pI rule. The textbook (line 5564) defines pI as the average of the two pKa values flanking the net-zero (zwitterionic) species, not automatically the two lowest pKa. For a basic amino acid the flanking pair is the two highest pKa, so 'two lowest' is only coincidentally right for acidic residues. It also drops the genuinely correct statement I.  
  ↳ LibreTexts Biochemistry, line 5564: 'The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI.'
- **C** — _partial_truth_: Pairs the correct statement I with the incorrect statement III. The three plateaus do reveal an ionizable side chain (I), but the curve does not reveal whether that side chain is acidic or basic, so you cannot identify which two pKa flank the zwitterion and cannot conclude pI is the average of the two lowest values. Tempting because for the common acidic-residue case the two lowest pKa happen to flank the neutral form.  
  ↳ LibreTexts Biochemistry, line 5564 (pI = average of the two pKa flanking the net-zero species) and lines 5266-5267 (basic side chains of Lys, Arg, His also carry ionizable groups), so side-chain identity is not fixed by plateau count alone.
- **D** — _misconception_: Includes statement II, which over-specifies the side chain as a carboxylic acid. The textbook lists basic amino acids (lysine, arginine, histidine) whose amine/imidazole/guanidino side chains are also ionizable and produce a third plateau; the curve's shape alone cannot distinguish an acidic from a basic side chain. It also keeps the false statement III and omits the true statement I.  
  ↳ LibreTexts Biochemistry, lines 5266-5267: 'The basic amino acids, lysine, arginine, and histidine, contain amine functional groups that can be protonated to carry a full charge' (each an ionizable side chain giving a third plateau).

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is A because three plateaus on a titration curve reveal three ionizable groups: the textbook states that "all amino acids have an amine and carboxylic acid group, and some have an additional ionizable side chain... Those with three ionizable groups are triprotic acids... If the pKa values are separated enough, three general plateaus, each centered at the pKa value of the ionizable group, can be seen in their titration curves" (LibreTexts 3158-3162). Because the \(\alpha\)-carboxyl and \(\alpha\)-amino groups are universal to every \(\alpha\)-amino acid (LibreTexts 5102-5104), the third plateau must come from an ionizable R group, so only statement I follows. The curve alone shows three \(\text{pK}_a\) values but does not assign chemical identity to the side chain, nor does it fix which two \(\text{pK}_a\) flank the neutral species, so the other inferences over-reach. (Choice A) is correct: three plateaus require three ionizable groups, and since two are the invariant \(\alpha\)-\(\text{COOH}\) and \(\alpha\)-\(\text{NH}_3^+\), the molecule must bear an ionizable side chain. (Choice B) is wrong because statement III is false and statement I is true; \(\text{pI}\) is the average of the two \(\text{pK}_a\) flanking the net-neutral (zwitterionic) species, which for a basic amino acid would be the two highest values, not the two lowest (LibreTexts 5564). (Choice C) wrongly adds statement III: the curve shows three \(\text{pK}_a\) but cannot tell you whether the side chain is acidic or basic, so you cannot know which pair flanks the zwitterion and cannot conclude \(\text{pI}\) is the average of the two lowest. (Choice D) wrongly includes statement II: a basic side chain such as that of lysine, arginine, or histidine also produces three plateaus, so the curve shape cannot establish that the side chain is a carboxylic acid (LibreTexts 5266-5267). This is a Scientific Reasoning and Problem Solving question because you must apply the relationship between number of plateaus and number of ionizable groups to reason from a titration curve to a structural conclusion while rejecting over-specified inferences.

---

## Q16 — Zwitterions & Titration Curves · **medium** · Skill 4 · 105s · conf 5
**Stem:** A student titrates serine from low pH with strong base and records the curve below. Serine has two ionizable groups that titrate in this range: \(\alpha\text{-COOH}\) with \(\text{pK}_{a1} = 2.2\) and \(\alpha\text{-NH}_3^+\) with \(\text{pK}_{a2} = 9.2\) (the side-chain \(-\text{OH}\) does not titrate here). The curve shows two flat buffering plateaus separated by a steep equivalence inflection near \(\text{pH} = 5.7\). At which \(\text{pH}\) is the carboxyl group exactly half-deprotonated, with \([-\text{COOH}] = [-\text{COO}^-]\)?

- **A.** \(\text{pH} = 5.7\)
- **B.** \(\text{pH} = 9.2\)
- **C.** \(\text{pH} = 4.0\)
- **D.** \(\text{pH} = 2.2\) ✅

**Correct (D):** libretexts-biochemistry.txt lines 3080-3081: "What happens if just enough NaOH is added to react with half of the HA? The mass balance would tell us that A-=HA, and at that point, the pH = pKa of the acid." Also lines 5501-5502: "At the curve's inflection point, pH = pKa... At this pH, [HA]=[A-]." The carboxyl's half-equivalence pH equals pKa1 = 2.2.

**Distractors:**
- **A** — _process_step_confusion_: pH 5.7 is the equivalence/inflection point between the two plateaus, which equals the pI (average of the flanking pKa, (2.2+9.2)/2 = 5.7) and the net-zero zwitterion pH, not the half-equivalence point of the carboxyl. Confuses the half-equivalence plateau center with the inter-plateau equivalence point.  
  ↳ libretexts-biochemistry.txt lines 5564-5565: 'The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI.' (2.2+9.2)/2 = 5.7 = pI, not a half-equivalence point.
- **B** — _adjacent_fact_: pH 9.2 is pKa2, the half-equivalence point of the alpha-amino group, not the carboxyl. It is a real plateau center but for the wrong ionizable group named in the stem.  
  ↳ libretexts-biochemistry.txt lines 3160-3161: titration plateaus are 'each centered at the pKa value of the ionizable group'; 9.2 centers the amino plateau, 2.2 centers the carboxyl plateau.
- **C** — _misconception_: pH 4.0 matches no feature of this curve: it is neither a plateau center (half-equivalence, pH = pKa) nor the inter-plateau equivalence point, so [-COOH] does not equal [-COO-] there. A student wrongly treats 4.0 as a meaningful intermediate; half-deprotonation occurs only at pH = pKa1 = 2.2.  
  ↳ libretexts-biochemistry.txt lines 5501-5502: half-deprotonation ([HA]=[A-]) occurs only when pH = pKa; pKa1 = 2.2, not 4.0.

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is D because the half-equivalence point of a given group is, by definition, the pH at which that group is exactly half-deprotonated, and the LibreTexts text states that when "just enough NaOH is added to react with half of the HA... \(A^-=HA\), and at that point, the pH = pKa of the acid" (libretexts-biochemistry.txt, lines 3080-3081); equivalently "At the curve's inflection point, pH = pKa... At this pH, \([HA]=[A^-]\)" (lines 5501-5502). The group being half-deprotonated here is the \(\alpha\text{-COOH}\), so the half-equivalence pH equals its \(\text{pK}_{a1} = 2.2\), which is the center of the first (lower) buffering plateau. (Choice A) \(\text{pH} = 5.7\) is the equivalence (inflection) point that lies BETWEEN the two plateaus and equals the \(\text{pI}\), the average of the two flanking pKa values \((2.2 + 9.2)/2 = 5.7\) (lines 5564-5565); it is the net-zero zwitterion pH, not a half-equivalence point, so it is wrong. (Choice B) \(\text{pH} = 9.2\) is \(\text{pK}_{a2}\), the half-equivalence point of the \(\alpha\text{-NH}_3^+\) group, not of the carboxyl; the text notes the two plateaus are each "centered at the pKa value of the ionizable group" (lines 3160-3161), so this is the wrong group's value. (Choice C) \(\text{pH} = 4.0\) corresponds to no defining feature of this curve; it is neither a plateau center (a half-equivalence point) nor the inter-plateau equivalence point, so it does not satisfy \([-\text{COOH}] = [-\text{COO}^-]\). (Choice D) is correct: the carboxyl is half-deprotonated when \(\text{pH} = \text{pK}_{a1} = 2.2\). This is a Data-based and Statistical Reasoning question because you must interpret the titration curve and pKa set, distinguishing a half-equivalence plateau center from the equivalence inflection between plateaus, to read off the correct pH.

---

## Q17 — Isoelectric Point (pI) · **easy** · Skill 1 · 75s · conf 5
**Stem:** A student titrates a solution of free serine, whose polar side chain stays uncharged across the titration, and wants to calculate its isoelectric point \(\text{pI}\). To find the \(\text{pH}\) at which serine exists predominantly as the net-neutral zwitterion, the two \(\text{pK}_a\) values she should average are those of the:

- **A.** side-chain hydroxyl and \(\alpha\)-amino groups
- **B.** side-chain hydroxyl and \(\alpha\)-carboxyl groups
- **C.** \(\alpha\)-carboxyl and \(\alpha\)-amino groups ✅
- **D.** all three ionizable groups, averaged equally

**Correct (C):** LibreTexts Biochemistry, libretexts-biochemistry.txt, lines 5564-5565: "The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." Lines 5560-5563 describe how charge moves from positive through net-zero to negative as groups deprotonate, and line 5574 confirms amino acids are zwitterions. Serine is classed as polar uncharged (lines 5263-5264); its side-chain alcohol carries zero charge when protonated (line 5486) and has a pKa ~13 (line 5601), so it does not ionize in the pI range.

**Distractors:**
- **A** — _misconception_: Treats serine's side-chain hydroxyl as an ionizable group that flanks the zwitterion. The textbook lists serine among the polar UNCHARGED amino acids (lines 5263-5264) and notes its side-chain alcohol has zero charge when protonated with pKa ~13 (lines 5486, 5601), so it does not ionize in the titration range; the neutral form is flanked by the alpha-carboxyl below it, not the hydroxyl. This pairing drops the alpha-carboxyl, one of the two correct flanking groups.  
  ↳ libretexts-biochemistry.txt lines 5263-5264 (serine is polar uncharged), 5486 (Ser alcohol has zero charge when protonated), 5601 (Ser side-chain pKa ~13), and 5564-5565 (average the two groups flanking the pI).
- **B** — _misconception_: Same error as A but in reverse: it substitutes the non-ionizing side-chain hydroxyl for the alpha-amino group. Serine's zwitterion is bounded above by the alpha-amino group (-NH3+, pKa ~9.2), so omitting it and using the hydroxyl (pKa ~13) averages the wrong pair and would not give the net-zero pH.  
  ↳ libretexts-biochemistry.txt lines 5486 and 5601 (Ser side chain uncharged in range, pKa ~13) and 5564-5565 (two groups closest to and on either side of the pI).
- **D** — _process_step_confusion_: Applies the polyprotic rule to a molecule that does not have a third charge-changing group in the pI range. Serine has only two groups that change charge there (alpha-carboxyl and alpha-amino), so averaging 'all three ionizable groups' confuses serine with an amino acid that has an ionizable side chain and ignores that pI uses only the TWO groups flanking the zwitterion.  
  ↳ libretexts-biochemistry.txt lines 5564-5565 (average only the two flanking groups) and 5486, 5601 (serine side chain stays uncharged in the titration range).

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is C because the \(\text{pI}\) is found by averaging the \(\text{pK}_a\) values of the two groups that flank the net-neutral (zwitterionic) species on either side. The textbook states the \(\text{pI}\) "can be determined by averaging the \(\text{pK}_a\) values of the two groups closest to and on either side of the \(\text{pI}\)" (LibreTexts 5564-5565). For serine the side chain is an alcohol that carries zero charge when protonated (line 5486) and has a \(\text{pK}_a \approx 13\) (line 5601), so it stays uncharged across the titration; the only two groups that gain or lose charge are the \(\alpha\)-carboxyl (\(-\text{COO}^-\), \(\text{pK}_a \approx 2.2\)) and the \(\alpha\)-amino (\(-\text{NH}_3^+\), \(\text{pK}_a \approx 9.2\)); the zwitterion sits between them, giving \(\text{pI} = (2.2 + 9.2)/2 \approx 5.7\). (Choice A) is incorrect: the side-chain hydroxyl does not ionize in this range, so it is not one of the groups flanking the zwitterion; pairing it with the \(\alpha\)-amino group leaves out the \(\alpha\)-carboxyl that actually borders the neutral form. (Choice B) is incorrect for the same reason in reverse: it substitutes the non-ionizing hydroxyl for the \(\alpha\)-amino group, ignoring that serine's neutral form is bounded below by \(-\text{COO}^-\) and above by \(-\text{NH}_3^+\). (Choice C) is correct: averaging the \(\alpha\)-carboxyl and \(\alpha\)-amino \(\text{pK}_a\) values gives the \(\text{pH}\) where serine carries no net charge. (Choice D) is incorrect because serine has only two groups that change charge in this range; treating it as if three groups must be averaged misapplies the rule used for amino acids with an ionizable side chain. This is a Knowledge of Scientific Concepts and Principles question because you must recall that the \(\text{pI}\) of a neutral amino acid is the average of the \(\text{pK}_a\) values of the two groups flanking the zwitterion.

---

## Q18 — Isoelectric Point (pI) · **medium** · Skill 2 · 110s · conf 5
**Stem:** A biochemist needs the isoelectric point of serine, whose hydroxyl-containing side chain does not ionize over the working pH range. Using the constants in the table, the \(\text{pI}\) of serine is closest to which value?

| Ionizable group (serine) | \(\text{pK}_a\) |
| --- | --- |
| \(\alpha\)-\(\text{COOH}\) | 2.2 |
| \(\alpha\)-\(\text{NH}_3^+\) | 9.2 |
| side-chain \(-\text{OH}\) | ~13 (does not ionize in range) |

- **A.** \(\text{pI} \approx 5.7\) ✅
- **B.** \(\text{pI} \approx 11.1\)
- **C.** \(\text{pI} \approx 9.2\)
- **D.** \(\text{pI} \approx 2.2\)

**Correct (A):** LibreTexts Biochemistry, /Users/mikkonieveras/praxis-prep/reference-textbooks/biochemistry/libretexts-biochemistry.txt lines 5563-5565: "This pH is called the isoelectric point (pI). The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." Lines 5485-5486 list Ser among side chains that carry zero charge when protonated; line 5516 names "Gly (no ionizable side chain)" as the model two-group case; line 5601 gives Ser (ROH) pKa ~13. Arithmetic: (2.2 + 9.2)/2 = 5.7.

**Distractors:**
- **B** — _process_step_confusion_: Treats serine's non-ionizing side-chain hydroxyl (pKa ~13) as a third charged group and averages it with the alpha-NH3+: (9.2 + 13)/2 = 11.1. The table and text state the -OH does not ionize in range, so only the alpha-COOH and alpha-NH3+ flank the zwitterion.  
  ↳ lines 5485-5486 (Ser carries zero charge when protonated) and line 5601 (Ser ROH pKa ~13)
- **C** — _partial_truth_: Reports a single pKa value (the alpha-NH3+, 9.2) instead of averaging the two flanking pKa values. The pI is defined as the average of the two groups on either side of the neutral species, not one pKa.  
  ↳ lines 5564-5565: pI is determined by averaging the pKa values of the two groups closest to and on either side of the pI
- **D** — _partial_truth_: Reports only the alpha-COOH pKa (2.2) instead of averaging both flanking groups. Like Choice C, it stops at a single pKa rather than computing (2.2 + 9.2)/2 = 5.7.  
  ↳ lines 5564-5565: pI is the average of the two flanking pKa values

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is A because the \(\text{pI}\) is found by averaging the two \(\text{pK}_a\) values flanking the net-neutral (zwitterionic) species, and serine's side-chain \(-\text{OH}\) does not ionize in range, so the only two relevant groups are the \(\alpha\)-\(\text{COOH}\) and \(\alpha\)-\(\text{NH}_3^+\). The textbook states the \(\text{pI}\) 'can be determined by averaging the pKa values of the two groups closest to and on either side of the pI' (LibreTexts lines 5564-5565), and lists serine among residues with no ionizable side chain for charge purposes (lines 5485-5486, 5516). The arithmetic is \(\text{pI} = (2.2 + 9.2)/2 = 11.4/2 = 5.7\). (Choice A) is correct: averaging the \(\alpha\)-\(\text{COOH}\) and \(\alpha\)-\(\text{NH}_3^+\) \(\text{pK}_a\) values gives \(\text{pI} \approx 5.7\). (Choice B) is wrong because it counts the non-ionizing side-chain \(-\text{OH}\) (\(\text{pK}_a \approx 13\)) as a charged group and averages it with the \(\alpha\)-\(\text{NH}_3^+\): \((9.2 + 13)/2 \approx 11.1\); but serine's hydroxyl does not ionize in range, so only two groups count (lines 5485-5486, 5601). (Choice C) is wrong because it reports a single \(\text{pK}_a\) (the \(\alpha\)-\(\text{NH}_3^+\) value, 9.2) rather than averaging the two flanking values; \(\text{pI}\) requires an average, not one \(\text{pK}_a\) (lines 5564-5565). (Choice D) is wrong because it reports only the \(\alpha\)-\(\text{COOH}\) \(\text{pK}_a\) (2.2) instead of averaging both flanking groups (lines 5564-5565). This is a Scientific Reasoning and Problem Solving question because you must apply the pI-averaging rule, decide which two of the listed \(\text{pK}_a\) values flank the zwitterion, and compute the result.

---

## Q19 — Isoelectric Point (pI) · **medium** · Skill 2 · 110s · conf 5
**Stem:** A student is calculating the isoelectric point of arginine, whose three ionizable groups have approximate \(\text{pK}_a\) values of \(2.0\) (\(\alpha\text{-}\text{COOH}\)), \(9.0\) (\(\alpha\text{-}\text{NH}_3^+\)), and \(12.5\) (guanidinium side chain). To find the \(\text{pI}\), she must average the two \(\text{pK}_a\) values that flank the net-neutral form. Which \(\text{pI}\) does she obtain?

- **A.** \(5.5\)
- **B.** \(10.75\) ✅
- **C.** \(7.25\)
- **D.** \(7.8\)

**Correct (B):** libretexts-biochemistry.txt lines 5563-5565: "At some pH, then, the net charge will be 0. This pH is called the isoelectric point (pI). The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." Worked straddle method confirmed at lines 10020-10021: "to calculate the pI, we need to add the two pKa values that straddle the net neutral pH ... and find the average between them." Side-chain pKa from line 6113: "Arginine ... 12.5"; backbone charges from lines 5478-5479 (amino group +1 protonated/0 deprotonated; carboxyl 0 protonated/-1 deprotonated) and protonated amine pKa ~10 at line 3030, supporting alpha-NH3+ ~9 and alpha-COOH ~2.

**Distractors:**
- **A** — _misconception_: Averages the two LOWEST pKa (2.0 and 9.0), which is the neutral-amino-acid formula pI=(pK_COOH+pK_NH3+)/2. For a BASIC amino acid the extra protonated side chain shifts the net-neutral form upward, so the flanking pair is the two highest pKa (9.0 and 12.5), not the two lowest.  
  ↳ libretexts-biochemistry.txt line 5564 ('averaging the pKa values of the two groups closest to and on either side of the pI'); line 6113 (Arginine side chain pKa 12.5 makes it basic).
- **C** — _process_step_confusion_: Averages the lowest and highest pKa (2.0 and 12.5), skipping the middle alpha-NH3+ (9.0). These two groups do not bracket the net-neutral species, so their average is not the pI.  
  ↳ libretexts-biochemistry.txt line 5564 (must average the two groups 'closest to and on either side of the pI', i.e., the pair flanking net zero, which are 9.0 and 12.5); lines 10020-10021 (use the two pKa that 'straddle the net neutral pH').
- **D** — _process_step_confusion_: Averages all three pKa values ((2.0+9.0+12.5)/3 = 7.83) rather than only the two flanking the net-neutral form. pI is defined by the two adjacent pKa around net zero, not the mean of every ionizable group.  
  ↳ libretexts-biochemistry.txt line 5564 ('averaging the pKa values of the two groups closest to and on either side of the pI' — two groups, not all three).

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is B because the textbook states that the \(\text{pI}\) is found by averaging the \(\text{pK}_a\) values of the two groups closest to and on either side of the net-neutral species. Arginine is basic, so as pH rises the \(\alpha\text{-}\text{COOH}\) (\(\text{pK}_a\) \(2.0\)) loses its proton first, taking the molecule from \(+2\) to a still-positive \(+1\); the molecule only reaches net zero after the \(\alpha\text{-}\text{NH}_3^+\) (\(\text{pK}_a\) \(9.0\)) deprotonates, and the very last group to leave is the guanidinium side chain (\(\text{pK}_a\) \(12.5\)). The net-neutral zwitterion is therefore flanked by the two HIGHEST \(\text{pK}_a\) values, so \(\text{pI} = (9.0 + 12.5)/2 = 10.75\). (Choice A) \(5.5\) averages the two LOWEST \(\text{pK}_a\) (\((2.0 + 9.0)/2\)) — that is the formula for a neutral amino acid, but arginine's basic side chain means the neutral form sits higher, between \(9.0\) and \(12.5\). (Choice B) is correct: averaging the two \(\text{pK}_a\) flanking the net-neutral form, \((9.0 + 12.5)/2 = 10.75\). (Choice C) \(7.25\) averages the lowest and highest \(\text{pK}_a\) (\((2.0 + 12.5)/2\)), skipping the middle group, so it does not bracket the neutral species. (Choice D) \(7.8\) averages all three \(\text{pK}_a\) (\((2.0 + 9.0 + 12.5)/3\)) instead of only the two that flank net neutrality. This is a Scientific Reasoning and Problem Solving question because you must apply the rule that \(\text{pI}\) is the average of the two \(\text{pK}_a\) bracketing the net-neutral form to a specific basic amino acid and select the correct pair.

---

## Q20 — Isoelectric Point (pI) · **hard** · Skill 2 · 150s · conf 5
**Stem:** A student titrates free arginine and records three \(\text{pK}_a\) values: \(\alpha\text{-COOH} = 2.0\), \(\alpha\text{-}\text{NH}_3^+ = 9.0\), and the guanidinium side chain \(= 12.5\). Reasoning that the net-neutral (zwitterionic) species is flanked by the two \(\text{pK}_a\) values on either side of it, what \(\text{pI}\) should the student calculate?

- **A.** \(\text{pI} \approx 5.5\)
- **B.** \(\text{pI} \approx 7.3\)
- **C.** \(\text{pI} \approx 12.5\)
- **D.** \(\text{pI} \approx 10.8\) ✅

**Correct (D):** libretexts-biochemistry.txt lines 5564-5565: "The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." Arginine guanidinium pKa = 12.5 (line 6113); basic side chains (Lys/Arg) always protonated at physiological pH (lines 6117-6118). Amino group carries +1 when protonated / carboxyl carries -1 when deprotonated (lines 5478-5479). For basic arginine the two pKa flanking the zwitterion are alpha-NH3+ and guanidinium: (9.0 + 12.5)/2 = 10.75 ≈ 10.8.

**Distractors:**
- **A** — _process_step_confusion_: Averages the two LOWEST pKa values, (2.0 + 9.0)/2 = 5.5. This is the correct pair only for an amino acid with no ionizable basic side chain (where the zwitterion is flanked by alpha-COOH and alpha-NH3+). For basic arginine, the net-neutral species sits higher on the pH scale, flanked by alpha-NH3+ and the guanidinium side chain, not by the two backbone groups.  
  ↳ libretexts-biochemistry.txt lines 5564-5565 (average the two pKa flanking the pI) and lines 6117-6118 (Lys/Arg always protonated at physiological pH, so their side-chain pKa must be included in the upper averaging pair).
- **B** — _process_step_confusion_: Averages the two EXTREME pKa values, (2.0 + 12.5)/2 = 7.25 ≈ 7.3, skipping the central alpha-NH3+ group. The two pKa to average must straddle the net-neutral species and be adjacent to it; the lowest and highest pKa do not bracket the zwitterion for a triprotic basic residue.  
  ↳ libretexts-biochemistry.txt lines 5564-5565: 'averaging the pKa values of the two groups closest to and on either side of the pI' — the two values must be the closest flanking pair, not the outermost pair.
- **C** — _partial_truth_: Reports the guanidinium side-chain pKa (12.5) by itself without averaging. The pKa is the pH where that one group is half-deprotonated, not the pH of overall net-zero charge; a pI is always the midpoint between two pKa values, never a single pKa.  
  ↳ libretexts-biochemistry.txt line 6113 (arginine side chain pKa = 12.5) and lines 5564-5565 (pI requires averaging the two pKa flanking the neutral species, not a single pKa).

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is D because the \(\text{pI}\) is found by averaging the two \(\text{pK}_a\) values that flank the net-neutral species. Arginine is a basic amino acid with three ionizable groups (\(\alpha\text{-COOH} = 2.0\), \(\alpha\text{-}\text{NH}_3^+ = 9.0\), guanidinium \(= 12.5\)); as pH rises the \(\alpha\text{-COOH}\) deprotonates first (giving the net-neutral zwitterion), and the next group to lose a proton is the \(\alpha\text{-}\text{NH}_3^+\). The textbook states the \(\text{pI}\) is found by "averaging the pKa values of the two groups closest to and on either side of the pI," so for this basic residue you average \(\alpha\text{-}\text{NH}_3^+\) and the guanidinium side chain: \(\text{pI} = (9.0 + 12.5)/2 = 10.75 \approx 10.8\). (Choice A) is incorrect because \(\text{pI} \approx 5.5\) comes from averaging the two lowest \(\text{pK}_a\) values, \((2.0 + 9.0)/2\) — the pair that flanks the neutral species of a residue WITHOUT a basic side chain, not arginine. (Choice B) is incorrect because \(\text{pI} \approx 7.3\) comes from averaging the extreme \(\text{pK}_a\) values, \((2.0 + 12.5)/2\), which skips over the central \(\alpha\text{-}\text{NH}_3^+\) group rather than using the two that actually straddle the zwitterion. (Choice C) is incorrect because \(\text{pI} \approx 12.5\) simply reports the guanidinium \(\text{pK}_a\) alone without averaging it with the adjacent group, ignoring that a \(\text{pI}\) is always a midpoint between two \(\text{pK}_a\) values. (Choice D) is correct: averaging the \(\alpha\text{-}\text{NH}_3^+\) (9.0) and guanidinium (12.5) \(\text{pK}_a\) values gives \(\text{pI} \approx 10.8\), consistent with arginine being a strongly basic amino acid. This is a Scientific Reasoning and Problem Solving question because you must apply the pI-averaging rule to a specific pKa set, identify which two of three pKa values flank the net-neutral species, and compute the result.

---

## Q21 — Isoelectric Point (pI) · **medium** · Skill 2 · 110s · conf 5
**Stem:** A generic acidic amino acid carries three ionizable groups with representative \(\text{pK}_a\) values of \(2.0\) (\(\alpha\)-carboxyl), \(4.0\) (side-chain carboxyl), and \(9.5\) (\(\alpha\)-amino), and as base is added from very low \(\text{pH}\) its net charge progresses from \(+1\) toward \(-2\). The \(\text{pI}\) is found by averaging the two \(\text{pK}_a\) values that flank the net-neutral form. Which two \(\text{pK}_a\) values should be averaged, and why?

- **A.** 4.0 and 9.5; they straddle physiological pH
- **B.** 2.0 and 9.5; they are the carboxyl and amino groups
- **C.** 2.0 and 4.0; they bracket the zero-charge species ✅
- **D.** all three; the side chain adds charge

**Correct (C):** libretexts-biochemistry.txt lines 5563-5565: "At some pH, then, the net charge will be 0. This pH is called the isoelectric point (pI). The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." Charge progression from lines 5560-5562: at low pH all ionizable groups are protonated and the net charge is positive; "As pH increases, the most acidic groups will begin to deprotonate, and the net charge will become less positive." For an acidic amino acid the two most acidic groups are the alpha-carboxyl and the side-chain carboxyl (lines 5264-5266: glutamate and aspartate "constitute the acidic amino acids and contain side chains with carboxylic acid functional groups capable of fully ionizing in solution"), so the neutral form is flanked by the two lowest pKa values: pI = (2.0 + 4.0)/2 = 3.0.

**Distractors:**
- **A** — _adjacent_fact_: 4.0 and 9.5 flank the -1 species, not the net-neutral one; their average (6.75) is the pH of half-charge between the -1 and -2 forms, not the pI. The pI must average the two pKa values bracketing the zero-charge form.  
  ↳ libretexts-biochemistry.txt lines 5563-5565: 'At some pH, then, the net charge will be 0... The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI.' Lines 5561-5562 confirm net charge becomes less positive as the most acidic groups deprotonate first, so the neutral form sits between the two lowest pKa values, not between the side chain and amino group.
- **B** — _misconception_: 2.0 and 9.5 (alpha-carboxyl and alpha-amino) is the correct pair only for a neutral amino acid lacking an ionizable side chain. For an acidic amino acid the side-chain carboxyl deprotonates before the amino group, so the neutral form is no longer bracketed by the alpha-amino pKa.  
  ↳ libretexts-biochemistry.txt lines 5264-5266: acidic amino acids 'contain side chains with carboxylic acid functional groups capable of fully ionizing in solution,' adding a third ionization below the amino group, which lines 5563-5565 require be accounted for when choosing the flanking pKa values.
- **D** — _process_step_confusion_: The pI is defined as the average of exactly the two pKa values flanking the net-neutral species, never all three; averaging all three groups confuses the number of ionizations with the two that bracket zero charge.  
  ↳ libretexts-biochemistry.txt lines 5563-5564: 'At some pH, then, the net charge will be 0... The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI' — two groups, not all ionizable groups.

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is C because the \(\text{pI}\) is found by averaging the \(\text{pK}_a\) values of the two groups closest to and on either side of the net-neutral species. Tracking the charge as base is added: at low \(\text{pH}\) all groups are protonated, so the \(\alpha\)-carboxyl is neutral, the side-chain carboxyl is neutral, and the \(\alpha\)-amino is \(-\text{NH}_3^+\), giving a net charge of \(+1\). Deprotonating the lowest \(\text{pK}_a\) group (the \(\alpha\)-carboxyl, \(\text{pK}_a = 2.0\)) converts it to \(-\text{COO}^-\), producing the net-neutral zwitterion (\(-1\) from \(\alpha\)-\(\text{COO}^-\), \(+1\) from \(-\text{NH}_3^+\)). The very next deprotonation (the side-chain carboxyl, \(\text{pK}_a = 4.0\)) drives the molecule to a net charge of \(-1\). The zero-charge form is therefore bracketed by \(\text{pK}_a = 2.0\) and \(\text{pK}_a = 4.0\), so \(\text{pI} = (2.0 + 4.0)/2 = 3.0\) — the two lowest \(\text{pK}_a\) values, exactly as expected for an acidic amino acid. (Choice A) 4.0 and 9.5 are the \(\text{pK}_a\) values that flank the \(-1\) species, not the neutral one; averaging them gives \(6.75\), which is the \(\text{pH}\) of half-charge between the \(-1\) and \(-2\) forms, not the \(\text{pI}\). (Choice B) 2.0 and 9.5 are the standard pair for a neutral amino acid with no ionizable side chain, but here the acidic side chain deprotonates before the amino group, so the neutral form is no longer flanked by the \(\alpha\)-amino \(\text{pK}_a\). (Choice C) is correct: 2.0 and 4.0 bracket the zero-charge species, so they are the two \(\text{pK}_a\) values averaged. (Choice D) the \(\text{pI}\) is always the average of exactly the two \(\text{pK}_a\) values flanking the neutral form; averaging all three has no defined meaning and ignores which species actually carries zero charge. This is a Scientific Reasoning and Problem Solving question because you must apply protonation-state reasoning to identify which two ionizations flank the net-neutral form and then average those two \(\text{pK}_a\) values.

---

## Q22 — Isoelectric Point (pI) · **hard** · Skill 2 · 150s · conf 5
**Stem:** A student titrates free cysteine from low to high pH and records the following \(\text{pK}_a\) values for its three ionizable groups: \(\alpha\text{-COOH} \approx 1.9\), thiol \((-\text{SH}) \approx 8.4\), and \(\alpha\text{-NH}_3^+ \approx 10.5\). As base is added, cysteine passes through a form that carries no net charge before any further deprotonation makes it anionic. Using the two \(\text{pK}_a\) values that flank this zwitterionic species, what is the isoelectric point \((\text{pI})\) of cysteine?

- **A.** \(\text{pI} \approx 5.1\) ✅
- **B.** \(\text{pI} \approx 6.2\)
- **C.** \(\text{pI} \approx 9.5\)
- **D.** \(\text{pI} \approx 8.4\)

**Correct (A):** LibreTexts Biochemistry, /Users/mikkonieveras/praxis-prep/reference-textbooks/biochemistry/libretexts-biochemistry.txt, lines 5564-5565: "This pH is called the isoelectric point (pI). The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." Worked averaging example, lines 10020-10021: "we need to add the two pKa values that straddle the net neutral pH (8.37 and 10) and find the average between them. This results in a pI of 9.18!" Cysteine thiol pKa, line 10009: "Cys (pKa =8.37)"; thiol neutral-when-protonated, line 5486: "Cys (thiol), which have zero charges when protonated", and line 10013: deprotonated thiol gives "an S-". Compute: pI = (1.9 + 8.4)/2 = 5.15 ≈ 5.1.

**Distractors:**
- **B** — _process_step_confusion_: Averages the alpha-COOH and alpha-NH3+ pKa ((1.9+10.5)/2 = 6.2), the method for a neutral amino acid with no ionizable side chain. Cysteine's thiol (pKa ~8.4) is more acidic than the alpha-amino group, so it — not the alpha-amino group — flanks the upper edge of the neutral species. This averages the wrong pair by ignoring the side chain.  
  ↳ /Users/mikkonieveras/praxis-prep/reference-textbooks/biochemistry/libretexts-biochemistry.txt lines 5564-5565 ('averaging the pKa values of the two groups closest to and on either side of the pI') and line 5486 (Cys thiol is ionizable and neutral only when protonated); the thiol at ~8.4 deprotonates before the alpha-NH3+ at ~10.5, so it brackets the neutral form.
- **C** — _process_step_confusion_: Averages the thiol and alpha-NH3+ pKa ((8.4+10.5)/2 ≈ 9.5). Those two groups straddle the net -1 to net -2 transition, not the net-neutral zwitterion. This is the averaging pattern appropriate for a BASIC amino acid (where the two highest pKa flank neutrality) misapplied to cysteine, whose acidic thiol places the neutral form between the alpha-COOH and the thiol.  
  ↳ /Users/mikkonieveras/praxis-prep/reference-textbooks/biochemistry/libretexts-biochemistry.txt lines 5564-5565 (average the two pKa flanking the net-zero form) and lines 10013-10014 (deprotonating the thiol takes the molecule to a negative net charge, so the thiol bounds the upper edge of the NEUTRAL species, not the alpha-amino group).
- **D** — _misconception_: Reports the thiol side-chain pKa (8.4) itself as the pI rather than averaging two pKa values. The pI is defined as the pH of net-zero charge obtained by averaging the two flanking pKa, not by reading off a single ionization constant.  
  ↳ /Users/mikkonieveras/praxis-prep/reference-textbooks/biochemistry/libretexts-biochemistry.txt lines 5564-5565 ('The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI') — a single pKa is not the pI; line 10009 lists the thiol pKa (8.37) as one of several ionizations, not the pI.

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is A because the \(\text{pI}\) is the pH where net charge is zero, found by averaging the two \(\text{pK}_a\) values 'closest to and on either side of' the neutral (zwitterionic) species (LibreTexts 3.1.10, lines 5564-5565). For cysteine the fully protonated form (pH below \(1.9\)) is \(+1\); deprotonating the \(\alpha\text{-COOH}\) at \(\approx 1.9\) gives the net-neutral zwitterion (\(-\text{COO}^-\), \(-\text{SH}\) neutral, \(-\text{NH}_3^+\)); the next deprotonation at the thiol \(\approx 8.4\) yields a net charge of \(-1\) (the \(-\text{SH}\) is neutral when protonated and \(-1\) when deprotonated, per lines 5486 and 10013-10014). The neutral species is therefore flanked by \(\alpha\text{-COOH}\) and the thiol, so \(\text{pI} = (1.9 + 8.4)/2 = 10.3/2 = 5.15 \approx 5.1\); this mirrors the worked averaging method the text uses for vasopressin, \(\text{pI}=(8.37+10)/2=9.18\) (lines 10020-10021). (Choice A) is correct: averaging the two \(\text{pK}_a\) flanking the zwitterion, \((1.9+8.4)/2 \approx 5.1\). (Choice B) averages the \(\alpha\text{-COOH}\) and \(\alpha\text{-NH}_3^+\) (\((1.9+10.5)/2=6.2\)), which ignores the acidic thiol side chain and so misidentifies which groups flank the neutral form. (Choice C) averages the thiol and \(\alpha\text{-NH}_3^+\) (\((8.4+10.5)/2\approx9.5\)); those two flank the \(-1\)/\(-2\) transition, not the neutral species, so this is the method for a basic amino acid applied to the wrong pair. (Choice D) reports the thiol \(\text{pK}_a\) (\(8.4\)) itself rather than averaging two values, treating a single side-chain \(\text{pK}_a\) as the \(\text{pI}\). This is a Scientific Reasoning and Problem Solving question because you must apply the protonation-state logic of the Henderson-Hasselbalch framework to a given \(\text{pK}_a\) set, identify the two groups bracketing the net-neutral form, and compute the \(\text{pI}\).

---

## Q23 — Isoelectric Point (pI) · **medium** · Skill 2 · 110s · conf 5
**Stem:** A biochemist compares two amino acids, each with three ionizable groups: an acidic amino acid with \(\text{pK}_a\) values \(\alpha\text{-COOH} \approx 2\), acidic side chain \(\approx 4\), \(\alpha\text{-NH}_3^+ \approx 9\), and a basic amino acid with \(\alpha\text{-COOH} \approx 2\), \(\alpha\text{-NH}_3^+ \approx 9\), basic side chain \(\approx 12\). The acidic amino acid is found to have a much lower \(\text{pI}\) than the basic one. The most direct reason for this difference is that the \(\text{pI}\) of each is fixed by:

- **A.** averaging all three \(\text{pK}_a\) values together
- **B.** averaging the two \(\text{pK}_a\) values flanking the neutral form ✅
- **C.** averaging only the two side-chain-related \(\text{pK}_a\) values
- **D.** the single lowest \(\text{pK}_a\) in each amino acid

**Correct (B):** libretexts-biochemistry.txt lines 5563-5565: "At some pH, then, the net charge will be 0. This pH is called the isoelectric point (pI). The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." Supported by lines 5560-5563 (acidic groups deprotonate as pH rises, driving net charge negative) and lines 3174-3179 (acidic Asp/Glu contribute negative charge; the basic amine of Lys contributes positive charge).

**Distractors:**
- **A** — _process_step_confusion_: Averaging all three pKa [(2+4+9)/3 = 5.0 for the acidic amino acid] includes a pKa that does NOT border the neutral species. The textbook specifies only 'the two groups closest to and on either side of the pI,' so the third, non-flanking pKa must be excluded.  
  ↳ libretexts-biochemistry.txt lines 5564-5565: 'The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI.'
- **C** — _partial_truth_: It is true the side chain governs whether pI is high or low, but the rule is to average the two pKa flanking neutrality, not 'the two side-chain values.' For the acidic amino acid the neutral form is bracketed by the alpha-COOH and the single acidic side chain, so picking two side-chain pKa misidentifies the bracketing groups.  
  ↳ libretexts-biochemistry.txt lines 5560-5565: acidic groups deprotonate as pH rises ('the most acidic groups will begin to deprotonate, and the net charge will become less positive') and pI is the average of the two groups on either side of net-zero charge.
- **D** — _scale_unit_error_: pI is a pH at which net charge is zero, derived from averaging two pKa; it is not a single pKa value. Using the lowest pKa alone (~2 for both) would give both amino acids nearly the same pI and erase the acidic-vs-basic distinction the data show.  
  ↳ libretexts-biochemistry.txt lines 5563-5565: pI is the pH where 'the net charge will be 0' and is found by 'averaging the pKa values of the two groups closest to and on either side of the pI.'

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is B because the textbook states that "The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI" — that is, the two \(\text{pK}_a\) values that flank the net-neutral (zwitterionic) species. For the acidic amino acid, the neutral form is bracketed by the \(\alpha\text{-COOH}\) and the acidic side chain, so \(\text{pI} = (2 + 4)/2 = 3.0\) (LOW). For the basic amino acid, the neutral form is bracketed by the \(\alpha\text{-NH}_3^+\) and the basic side chain, so \(\text{pI} = (9 + 12)/2 = 10.5\) (HIGH). The extra acidic group adds a low \(\text{pK}_a\) on the acid side of neutrality and the extra basic group adds a high \(\text{pK}_a\) on the base side, which is exactly why an acidic residue has a low \(\text{pI}\) and a basic residue a high \(\text{pI}\). (Choice A) is wrong: averaging all three [\((2+4+9)/3 = 5.0\) for the acid] dilutes in the unrelated third \(\text{pK}_a\) and does not give the pH where charge is zero — only the two groups flanking neutrality count. (Choice B) is correct: averaging the two \(\text{pK}_a\) flanking the neutral form gives \(3.0\) for the acidic and \(10.5\) for the basic amino acid, reproducing the low-vs-high \(\text{pI}\) split. (Choice C) is wrong: for the acidic amino acid only one side chain is acidic, and forcing "the two side-chain values" mis-identifies which groups bracket neutrality; the neutral form here is flanked by the \(\alpha\text{-COOH}\) and the side chain, not by two side chains. (Choice D) is wrong: \(\text{pI}\) is a pH of net-zero charge obtained from a two-\(\text{pK}_a\) average, not from a single \(\text{pK}_a\); using the lowest alone [\(\approx 2\)] would assign nearly the same \(\text{pI}\) to both amino acids and erase the acidic-vs-basic difference. This is a Scientific Reasoning and Problem Solving question because you must apply the flanking-\(\text{pK}_a\) averaging rule to a given \(\text{pK}_a\) set to explain why an acidic residue's \(\text{pI}\) lies low and a basic residue's lies high.

---

## Q24 — Isoelectric Point (pI) · **hard** · Skill 2 · 150s · conf 5
**Stem:** A student calculates the isoelectric point of free tyrosine, whose three ionizable groups have the following \(\text{pK}_a\) values: \(\alpha\text{-COOH} = 2.2\), \(\alpha\text{-NH}_3^+ = 9.1\), and the phenol side chain \(= 10.5\). Because the phenol group does not flank the net-neutral (zwitterionic) species, which value should the student obtain for the \(\text{pI}\)?

- **A.** 9.80
- **B.** 6.35
- **C.** 7.27
- **D.** 5.65 ✅

**Correct (D):** libretexts-biochemistry.txt lines 5564-5565: "This pH is called the isoelectric point (pI). The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." Lines 10010-10021 (vasopressin pI worked example): "we want to determine which two pKa values are the closest and straddle the pH at which the molecule has a net neutral charge... to calculate the pI, we need to add the two pKa values that straddle the net neutral pH... and find the average between them." Lines 5478-5479: "When protonated, the amino group carries a +1 charge, and the carboxyl group carries a zero charge. When deprotonated, the amino group is neutral, while the carboxyl group carries a -1 charge." Lines 5485-5486: Tyr (alcohol/phenol) has "zero charges when protonated." Line 8280: tyrosine "side-chain hydroxyl is deprotonated (pKa = 10.5)."

**Distractors:**
- **A** — _misconception / basic-AA rule misapplied to an acidic (phenolic) side chain_: Averages the alpha-NH3+ (9.1) and phenol (10.5), the rule for a BASIC amino acid where a cationic side chain raises the pI. Tyrosine's phenol is not a base and is uncharged when protonated, so this pair does not flank the zwitterion. (9.1 + 10.5)/2 = 9.80.  
  ↳ libretexts-biochemistry.txt lines 5485-5486: Tyr (alcohol/phenol) has 'zero charges when protonated' (i.e., it is not a cationic/basic group); lines 5564-5565: pI averages the two groups 'closest to and on either side of the pI.'
- **B** — _partial_truth / acidic-AA rule misapplied; phenol treated as flanking the zwitterion_: Averages the alpha-COOH (2.2) and phenol (10.5), wrongly treating the phenol as the side chain that flanks the neutral form the way an acidic side chain (Asp/Glu) does. The phenol lies ABOVE the alpha-NH3+, so it cannot be one of the two groups straddling the zwitterion. (2.2 + 10.5)/2 = 6.35.  
  ↳ libretexts-biochemistry.txt lines 10010-10012: pI uses 'which two pKa values are the closest and straddle the pH at which the molecule has a net neutral charge'; line 8280: phenol pKa = 10.5, which sits above the alpha-NH3+ (9.1) and so does not flank the neutral species.
- **C** — _process_step_confusion / averaged all ionizable pKa instead of the two flanking ones_: Averages all three ionizable pKa values instead of only the two that flank the net-neutral form. The pI rule uses exactly two flanking pKa, never the mean of every ionizable group. (2.2 + 9.1 + 10.5)/3 = 7.27.  
  ↳ libretexts-biochemistry.txt lines 5564-5565: pI is 'averaging the pKa values of the two groups closest to and on either side of the pI' (two groups, not all groups); lines 10020-10021: 'add the two pKa values that straddle the net neutral pH... and find the average between them.'

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is D because the \(\text{pI}\) is found by averaging the \(\text{pK}_a\) values of the two groups that straddle the net-neutral species, and for tyrosine those are the \(\alpha\text{-COOH}\) and \(\alpha\text{-NH}_3^+\), not the phenol. As the textbook states, the \(\text{pI}\) is determined "by averaging the pKa values of the two groups closest to and on either side of the pI"; for vasopressin the source likewise instructs you to "determine which two pKa values are the closest and straddle the pH at which the molecule has a net neutral charge." Tyrosine's phenol side chain (\(\text{pK}_a \approx 10.5\)) is uncharged when protonated and only deprotonates to \(-1\) at high pH, so it lies above both backbone groups and cannot flank the zwitterion. Working from the bottom up: below \(\text{pH} = 2.2\) the charge is \(+1\); between \(2.2\) and \(9.1\) the \(\alpha\text{-COO}^-\) (\(-1\)) cancels the \(\alpha\text{-NH}_3^+\) (\(+1\)) for net zero; the phenol stays neutral throughout this window. Thus \(\text{pI} = (2.2 + 9.1)/2 = 5.65\). (Choice A) is 9.80, the result of averaging \(\alpha\text{-NH}_3^+\) and the phenol \((9.1 + 10.5)/2\) as if tyrosine were a basic amino acid. (Choice B) is 6.35, from averaging \(\alpha\text{-COOH}\) and the phenol \((2.2 + 10.5)/2\), wrongly treating the phenol as if it flanked the neutral form like the acidic side chain of Asp/Glu. (Choice C) is 7.27, the average of all three \(\text{pK}_a\) values \((2.2 + 9.1 + 10.5)/3\) instead of only the two flanking groups. (Choice D) is correct: averaging only the \(\alpha\text{-COOH}\) and \(\alpha\text{-NH}_3^+\) that bound the zwitterion gives \((2.2 + 9.1)/2 = 5.65\). This is a Scientific Reasoning and Problem Solving question because you must apply the rule for which two \(\text{pK}_a\) flank the net-neutral form to a specific residue and compute the \(\text{pI}\).

---

## Q25 — Isoelectric Point (pI) · **hard** · Skill 2 · 150s · conf 5
**Stem:** A student titrates free threonine in water and records the table of \(\text{pK}_a\) values shown. Threonine is a polar-uncharged amino acid whose \(\beta\)-hydroxyl side chain does not ionize over the accessible \(\text{pH}\) range. Using the two flanking \(\text{pK}_a\) values, the student calculates the \(\text{pI}\) of threonine.

| Ionizable group | \(\text{pK}_a\) |
|---|---|
| \(\alpha\text{-}\text{COOH}\) | 2.1 |
| \(\beta\text{-OH (side chain)}\) | does not ionize |
| \(\alpha\text{-}\text{NH}_3^+\) | 9.1 |

What \(\text{pI}\) should the student obtain?

- **A.** \(\text{pI} = 9.80\)
- **B.** \(\text{pI} = 8.07\)
- **C.** \(\text{pI} = 5.60\) ✅
- **D.** \(\text{pI} = 7.40\)

**Correct (C):** libretexts-biochemistry.txt lines 5563-5565: "At some pH, then, the net charge will be 0. This pH is called the isoelectric point (pI). The pI can be determined by averaging the pKa values of the two groups closest to and on either side of the pI." And lines 5262-5267 classifying threonine as polar uncharged: "Within the polar uncharged class... These include the hydroxyl- and sulfhydryl-containing amino acids, serine, threonine, and cysteine." Worked averaging example, lines 10020-10021: "to calculate the pI, we need to add the two pKa values that straddle the net neutral pH... and find the average between them."

**Distractors:**
- **A** — _misconception_: Treats the threonine beta-hydroxyl as an ionizable group with a phenol-like pKa (~10.5) and averages (9.1 + 10.5)/2 = 9.8. The textbook places serine and threonine hydroxyls in the polar-UNcharged class with no charge-bearing side-chain pKa; only acidic (Asp/Glu) and basic (Lys/Arg/His) side chains 'carry a full charge.'  
  ↳ libretexts-biochemistry.txt lines 5262-5267: polar uncharged class includes 'the hydroxyl-...containing amino acids, serine, threonine, and cysteine,' contrasted with acidic side chains 'capable of fully ionizing in solution' and basic side chains 'protonated to carry a full charge.'
- **B** — _process_step_confusion_: Averages all three listed groups, wrongly assigning the non-ionizing OH a pKa (~13): (2.1 + 9.1 + 13)/3 = 8.07. The pI is the mean of only the two pKa flanking the net-neutral zwitterion, not the mean of every group.  
  ↳ libretexts-biochemistry.txt line 5564: pI is found by 'averaging the pKa values of the two groups closest to and on either side of the pI'; line 5601 gives 'Ser (ROH, pKa 13)' as the essentially non-ionizing hydroxyl; line 10020: 'add the two pKa values that straddle the net neutral pH... and find the average.'
- **D** — _partial_truth_: Reports physiological pH (7.4) as the pI. The zwitterion is indeed the dominant net-neutral form near physiological pH, but the pI is fixed by the residue's own flanking pKa (here 2.1 and 9.1), which average to 5.60, not 7.40.  
  ↳ libretexts-biochemistry.txt line 5574: 'amino acids are zwitterions'; lines 5563-5564 define pI as the pH of net-zero charge obtained by averaging the two flanking pKa, independent of physiological pH.

**Explanation:** This is a Biochemistry question that falls under the content category 'Structure and Function of Proteins and Their Constituent Amino Acids.' The answer is C because the \(\text{pI}\) is found by "averaging the pKa values of the two groups closest to and on either side of the pI," and you only count groups that can contribute to a charge on the molecule. Threonine is a polar-uncharged amino acid: its \(\beta\)-hydroxyl side chain does not ionize over the accessible \(\text{pH}\) range (the textbook even lists \(-\text{OH}\) groups like serine's with \(\text{pK}_a \approx 13\)), so the only ionizable groups are the \(\alpha\text{-}\text{COOH}\) (\(\text{pK}_a = 2.1\)) and \(\alpha\text{-}\text{NH}_3^+\) (\(\text{pK}_a = 9.1\)). Between these two \(\text{pK}_a\), threonine exists as the net-neutral zwitterion, so \(\text{pI} = (2.1 + 9.1)/2 = 11.2/2 = 5.60\). (Choice A) \(\text{pI} = 9.80\) treats the non-ionizing \(\beta\)-hydroxyl as an ionizable group with a phenol-like \(\text{pK}_a \approx 10.5\) and averages the two highest values, \((9.1 + 10.5)/2\) — but the textbook lists serine and threonine hydroxyls as polar-uncharged groups with no charge-bearing side-chain \(\text{pK}_a\), unlike the ionizing acidic and basic side chains. (Choice B) \(\text{pI} = 8.07\) averages all three "groups" including a non-ionizing \(-\text{OH}\) counted as \(\text{pK}_a \approx 13\), \((2.1 + 9.1 + 13)/3\); the \(\text{pI}\) is the average of only the two \(\text{pK}_a\) that flank the zwitterion, never the mean of every group. (Choice C) is correct: averaging only the two backbone \(\text{pK}_a\) that straddle the net-neutral species gives \((2.1 + 9.1)/2 = 5.60\). (Choice D) \(\text{pI} = 7.40\) mistakes physiological \(\text{pH} = 7.4\) for the \(\text{pI}\); although the zwitterion is the dominant net-neutral form near physiological pH, the \(\text{pI}\) is set by the residue's own flanking \(\text{pK}_a\), not by physiological pH. This is a Scientific Reasoning and Problem Solving question because you must apply the pI-averaging rule and the ionizable-group classification to a \(\text{pK}_a\) table to compute the correct value.

---
