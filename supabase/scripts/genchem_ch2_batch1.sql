-- GenChem Ch2 (The Periodic Table) — Batch 1 of 3: Periodic Table Structure & Classification
-- 20 questions, all confidence >=4 (OpenStax Atoms First 2e); cross-batch + cross-chapter deduped, audit clean (PASS, 0 genuine conflicts).
-- Re-runnable. Run in Supabase SQL editor.
BEGIN;
DELETE FROM questions WHERE topic = 'The Periodic Table' AND subtopic IN ('Periodic Table Structure & Classification');

-- Q1 [Periodic Table Structure & Classification · easy · Skill 1 · ans A] (g1)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt1$Tellurium has a larger atomic mass than iodine, yet the modern periodic table places \(\text{Te}\) (\(Z = 52\)) before \(\text{I}\) (\(Z = 53\)). Which principle best accounts for this ordering?$qt1$,
    $op1$[{"label":"A","text":"Element properties recur periodically when the elements are arranged by increasing atomic number rather than by increasing atomic mass."},{"label":"B","text":"Element properties recur periodically when the elements are arranged by increasing atomic mass rather than by increasing atomic number."},{"label":"C","text":"Elements are ordered so that atomic mass increases monotonically across each period, fixing every element's position."},{"label":"D","text":"Elements are ordered by increasing neutron number, which sets the periodic recurrence of their properties."}]$op1$::jsonb,
    'A',
    $ex1$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure.' The modern periodic law states that the chemical and physical properties of the elements are periodic functions of their atomic numbers \(Z\) (the proton count), not their atomic masses. Tellurium has a larger atomic mass (\(\approx 127.6\)) than iodine (\(\approx 126.9\)), so a strictly mass-ordered table would invert the two. Ordering instead by atomic number places \(\text{Te}\) (\(Z = 52\)) before \(\text{I}\) (\(Z = 53\)), which correctly groups \(\text{I}\) with the other halogens and \(\text{Te}\) with the other chalcogens, matching their observed chemistry; this is why the \(Z\)-based law supersedes Mendeleev's original mass-based arrangement, making A correct. (Choice B) This reverses the modern periodic law: arranging by increasing atomic mass is precisely what produces the \(\text{Te}\)–\(\text{I}\) inversion and the mismatch with chemical behavior, so atomic mass is the discarded ordering criterion, not the governing one. (Choice C) Atomic mass does not increase monotonically across every period; the \(\text{Te}\)/\(\text{I}\) pair (along with \(\text{Ar}\)/\(\text{K}\) and \(\text{Co}\)/\(\text{Ni}\)) is a documented mass inversion, so position cannot be fixed by requiring mass to rise steadily. (Choice D) Periodic recurrence tracks atomic number, the proton count that determines electron configuration; neutron number varies among isotopes of one element and does not set an element's place in the table or the recurrence of its properties. Skill 1: this question requires recall and identification of the foundational statement of the periodic law.$ex1$,
    'easy', '4E', $cc1$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc1$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a1B$atomic-mass-substituted-for-atomic-number as ordering basis$a1B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a1C$assumes atomic mass increases monotonically across every period$a1C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a1D$neutron-number proposed as the periodic ordering variable$a1D$ FROM q;

-- Q2 [Periodic Table Structure & Classification · easy · Skill 1 · ans C] (g2)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt2$A chemist writing out the ground-state electron configuration of a neutral aluminum atom records \([\text{Ne}]3s^2 3p^1\). Reading only this configuration, in which period of the periodic table does aluminum most likely reside?$qt2$,
    $op2$[{"label":"A","text":"Period 1"},{"label":"B","text":"Period 2"},{"label":"C","text":"Period 3"},{"label":"D","text":"Period 4"}]$op2$::jsonb,
    'C',
    $ex2$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. For a representative (main-group) element, the period number equals the highest principal quantum number \(n\) of any occupied shell. In \([\text{Ne}]3s^2 3p^1\), the \([\text{Ne}]\) core fills the \(n=1\) and \(n=2\) shells, while the outermost \(3s\) and \(3p\) electrons occupy the \(n=3\) shell; the largest occupied value of \(n\) is therefore \(3\), placing aluminum in period 3. (Choice A) The \(n=1\) shell is the first shell occupied, but it is buried inside the \([\text{Ne}]\) core rather than the highest occupied shell, so it sets the lowest principal quantum number rather than the period. (Choice B) The \([\text{Ne}]\) core ends at \(n=2\), but that shell is fully enclosed by the higher \(3s\) and \(3p\) electrons; the period is fixed by the maximum \(n\) occupied, which is \(3\), not the value reached by the noble-gas core. (Choice D) No electrons occupy any shell with \(n=4\) in this configuration; the highest occupied shell is \(n=3\), and adding one to the maximum principal quantum number overshoots the actual outermost shell. Skill 1$ex2$,
    'easy', '4E', $cc2$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc2$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'scale_unit_error', $a2A$lowest-occupied-shell-read-as-period$a2A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a2B$noble-gas-core-shell-read-as-period$a2B$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a2D$off-by-one-max-principal-quantum-number$a2D$ FROM q;

-- Q3 [Periodic Table Structure & Classification · easy · Skill 1 · ans B] (g3)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt3$Phosphorus has the ground-state valence configuration \(3s^2 3p^3\). Of the elements below, the one most likely to share phosphorus's group on the periodic table is the element whose valence configuration is$qt3$,
    $op3$[{"label":"A","text":"\\(4s^2 3d^3\\)"},{"label":"B","text":"\\(5s^2 5p^3\\)"},{"label":"C","text":"\\(3s^2 3p^4\\)"},{"label":"D","text":"\\(4s^2 4p^2\\)"}]$op3$::jsonb,
    'B',
    $ex3$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Elements in the same group share the same valence-shell electron configuration: the same number and type of valence electrons, differing only in the principal quantum number \(n\). Phosphorus sits in group 15 with valence configuration \(3s^2 3p^3\), a filled valence \(s\) subshell plus three \(p\) electrons (five valence electrons total). The configuration \(5s^2 5p^3\) reproduces that exact \(ns^2 np^3\) pattern at \(n=5\); this is arsenic's group-mate antimony, also in group 15. Because the valence pattern is identical, the chemical behavior is analogous, which is precisely what defines membership in the same group.

(Choice A) The configuration \(4s^2 3d^3\) describes a transition metal (vanadium), whose outermost electrons fill an \(s\) and an underlying \(d\) subshell. This is not an \(ns^2 np^3\) main-group pattern, so it places the element in the d-block rather than group 15.

(Choice C) The configuration \(3s^2 3p^4\) has six valence electrons (\(ns^2 np^4\)), one more p electron than phosphorus. That extra valence electron places the element in group 16 (sulfur), an adjacent group, not the same group.

(Choice D) The configuration \(4s^2 4p^2\) has only four valence electrons (\(ns^2 np^2\)) and belongs to group 14 (germanium). Matching the principal quantum-number jump expected going down a group does not by itself put two elements in the same group; the count and type of valence electrons must also match, and here the p-electron count differs.

Skill 1: Knowledge of Scientific Concepts and Principles.$ex3$,
    'easy', '4E', $cc3$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc3$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a3A$transition-metal d-block configuration mistaken for a main-group family member$a3A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a3C$same-period neighbor with one extra p electron read as same group$a3C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a3D$different valence-electron count treated as same group because it lies lower in the table$a3D$ FROM q;

-- Q4 [Periodic Table Structure & Classification · medium · Skill 2 · ans D] (g4)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt4$A lab tech is building a quick-reference card for the second-period nonmetals and needs to fill in the valence-electron count for carbon. The only data she has on hand is a periodic table showing carbon in group 14 (the column headed by carbon and silicon), with no electron configurations written out. Working from group placement alone, how many valence electrons should she record for a neutral carbon atom, and what valence-shell occupancy does that correspond to?$qt4$,
    $op4$[{"label":"A","text":"6 valence electrons, an \\(ns^2\\,np^4\\) valence shell"},{"label":"B","text":"2 valence electrons, an \\(ns^2\\) valence shell"},{"label":"C","text":"14 valence electrons, matching the group-14 label"},{"label":"D","text":"4 valence electrons, an \\(ns^2\\,np^2\\) valence shell"}]$op4$::jsonb,
    'D',
    $ex4$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure.' For main-group (representative) elements, the number of valence electrons equals the ones digit of the IUPAC group number for groups 13-18, or equivalently the older A-group designation. Group 14 corresponds to 4 valence electrons. Carbon sits in period 2, so its valence shell is the n=2 shell, filled as \(2s^2\,2p^2\) — a general \(ns^2\,np^2\) pattern giving 2 + 2 = 4 valence electrons. Thus the tech should record 4 valence electrons with an \(ns^2\,np^2\) valence shell, which is choice D. (Choice A) An \(ns^2\,np^4\) shell totals 6 valence electrons and is the configuration of the group-16 elements (the oxygen family), not group 14; carbon's p subshell holds only two electrons, not four. (Choice B) An \(ns^2\) shell with 2 valence electrons describes the group-2 alkaline earth metals; it ignores the two p electrons that carbon, as a group-14 element, also carries in its valence shell. (Choice C) The numeral 14 is the group label, not a count of valence electrons; valence-electron totals for main-group elements run from 1 to 8, and reading the full group number as the electron count conflates the column index with the outer-shell population. Skill 2$ex4$,
    'medium', '4E', $cc4$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc4$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a4A$Cites the valence configuration of a neighboring group (group 16, ns^2 np^4) instead of group 14$a4A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a4B$Counts only the s electrons and omits the p electrons, giving the group-2 configuration$a4B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a4C$Reads the full IUPAC group number 14 as the valence-electron count rather than using its ones digit$a4C$ FROM q;

-- Q5 [Periodic Table Structure & Classification · medium · Skill 2 · ans A] (g5)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt5$A neutral aluminum atom has the ground-state valence configuration \(3s^2 3p^1\). Constrained to reach the configuration of the nearest preceding noble gas, which monatomic ion is aluminum most likely to form?$qt5$,
    $op5$[{"label":"A","text":"\\(\\text{Al}^{3+}\\), losing all three valence electrons to attain the \\([\\text{Ne}]\\) configuration"},{"label":"B","text":"\\(\\text{Al}^{2+}\\), losing only the two \\(3s\\) electrons while retaining the \\(3p^1\\) electron"},{"label":"C","text":"\\(\\text{Al}^{3-}\\), gaining three electrons to fill the \\(3p\\) subshell and reach the \\([\\text{Ar}]\\) configuration"},{"label":"D","text":"\\(\\text{Al}^{5+}\\), losing every electron in the \\(n=3\\) shell plus one \\(2p\\) electron"}]$op5$::jsonb,
    'A',
    $ex5$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure.' Aluminum sits in Group 13 (the \(ns^2 np^1\) group), so it carries three valence electrons. As a representative metal of low electronegativity, it loses those three electrons rather than gaining any, producing \(\text{Al}^{3+}\) with the configuration \([\text{Ne}]\), matching the nearest preceding noble gas neon. The group number for representative metals predicts the common cation charge directly: Group 13 yields a \(3+\) ion. (Choice B) Removing only the \(3s^2\) pair and leaving the \(3p^1\) electron gives an incomplete loss of valence electrons; a partially emptied valence shell does not correspond to a noble-gas configuration, so \(\text{Al}^{2+}\) is not the favored monatomic ion. (Choice C) Gaining three electrons to form \(\text{Al}^{3-}\) is the behavior expected of a Group 15 nonmetal completing an octet; aluminum's low ionization energy and metallic character make electron loss, not gain, the favored path, so an anion does not form. (Choice D) Reaching \(\text{Al}^{5+}\) would require breaking into the filled \([\text{Ne}]\) core after the three valence electrons are gone; core electrons are held far too tightly to be removed under ordinary chemical conditions, so only the three valence electrons are lost. Skill 2.$ex5$,
    'medium', '4E', $cc5$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc5$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a5B$stops electron removal after the s-subshell and keeps the lone p electron, yielding a partial valence loss$a5B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a5C$treats a low-electronegativity metal as if it gains electrons like a nonmetal completing an octet$a5C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a5D$overcounts removable electrons by including tightly held core electrons in the valence count$a5D$ FROM q;

-- Q6 [Periodic Table Structure & Classification · medium · Skill 2 · ans B] (g6)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt6$A neutral atom in its ground state has the electron configuration \([\text{Ar}]4s^2 3d^2\). Based on the subshell that receives its differentiating electron, this element most likely belongs to which block of the periodic table?$qt6$,
    $op6$[{"label":"A","text":"The s-block"},{"label":"B","text":"The d-block"},{"label":"C","text":"The p-block"},{"label":"D","text":"The f-block"}]$op6$::jsonb,
    'B',
    $ex6$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Block assignment is set by the subshell that receives the differentiating (last-added) electron, not by the outermost shell. For \([\text{Ar}]4s^2 3d^2\), the \(4s\) subshell fills first and the two final electrons enter the \(3d\) subshell; because the differentiating electron occupies a \(d\) subshell, the element is a transition metal in the d-block. (Choice A) The s-block comprises elements whose differentiating electron enters an \(ns\) subshell, giving valence configurations of \(ns^1\) or \(ns^2\) with no partly filled \(d\) or \(f\) subshell; here the \(4s\) subshell is the outermost but is filled before the differentiating \(3d\) electrons are added, so it does not set the block. (Choice C) The p-block consists of elements whose differentiating electron enters an \(np\) subshell, yielding valence configurations of the form \(ns^2 np^{1-6}\); the configuration \([\text{Ar}]4s^2 3d^2\) contains no occupied \(p\) subshell beyond the argon core. (Choice D) The f-block (inner transition metals) is defined by a differentiating electron entering an \((n-2)f\) subshell; \([\text{Ar}]4s^2 3d^2\) has its differentiating electron in a \(d\) subshell rather than an \(f\) subshell, placing it among the d-block transition metals. Skill 2$ex6$,
    'medium', '4E', $cc6$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc6$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a6A$Assigns block from the highest-n (outermost) subshell 4s rather than the subshell receiving the differentiating electron$a6A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a6C$Conflates a four-electron valence region and partly filled valence shell with a main-group p-block configuration$a6C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a6D$Correctly uses a partly filled inner subshell to assign the block but mislabels the d subshell as f (inner transition)$a6D$ FROM q;

-- Q7 [Periodic Table Structure & Classification · medium · Skill 1 · ans C] (g7)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt7$An instructor is sorting period-4 elements into the periodic table's A and B blocks and pauses on gallium, whose ground-state configuration is \([\text{Ar}]3d^{10}4s^2 4p^1\). Noting that the \(3d\) subshell is completely filled and lies beneath the highest occupied principal level, the instructor decides the classification should hinge on which subshell received the differentiating (last-added) electron. On that basis, how should gallium be classified?$qt7$,
    $op7$[{"label":"A","text":"A transition (B-group) element, because the \\([\\text{Ar}]\\) core is followed by a filled \\(3d^{10}\\) subshell."},{"label":"B","text":"An inner transition element, because a \\(d\\) subshell lies below the highest occupied principal level."},{"label":"C","text":"A representative (main-group, A) element, because the subshell actively being filled is the outer \\(4p\\) subshell."},{"label":"D","text":"A transition (B-group) element, because the outer principal level holds both \\(s\\) and \\(p\\) electrons."}]$op7$::jsonb,
    'C',
    $ex7$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Classification rests on which subshell is being filled by the differentiating (last-added) electron. In gallium, \([\text{Ar}]3d^{10}4s^2 4p^1\), the \(3d^{10}\) subshell is completely filled and lies in the \(n=3\) level, one principal level below the highest occupied level \((n=4)\); a filled inner \(d\) subshell counts as part of the core, exactly as OpenStax treats gallium. The last electron added enters the outer \(4p\) subshell, and elements whose differentiating electron enters an outer \(s\) or \(p\) subshell are representative (main-group, A) elements, so gallium is a representative element. (Choice A) A filled \(3d^{10}\) subshell does not make an element a transition metal; transition (B-group) elements are those whose differentiating electron enters a partially filled \(d\) subshell, whereas in gallium the \(d\) subshell is already complete and counts as core while the \(4p\) subshell is the one being filled. (Choice B) Inner transition elements are defined by a differentiating electron entering an \(f\) subshell, not by the mere presence of a lower-lying \(d\) subshell; a completed \(d\) subshell beneath the outer level is core and does not place gallium among the inner transition (\(f\)-block) elements. (Choice D) The simultaneous presence of \(s\) and \(p\) electrons in the outer principal level is the signature of a representative element, not a transition element; transition character is set by an incompletely filled \(d\) subshell, so outer \(s\) plus \(p\) occupancy points toward the A-group classification rather than the B-group. Skill 1$ex7$,
    'medium', '4E', $cc7$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc7$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a7A$Treats any filled 3d10 subshell as proof of transition-metal status, ignoring that it is core$a7A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a7B$Cites a real lower-lying d subshell but misattributes inner-transition (f-block) status from it$a7B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a7D$Reverses the rule by reading outer s+p occupancy as transition character rather than main-group character$a7D$ FROM q;

-- Q8 [Periodic Table Structure & Classification · medium · Skill 1 · ans D] (g8)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt8$A chemist needs the count of valence electrons for vanadium, whose ground-state configuration is \([\text{Ar}]4s^2 3d^3\). Because vanadium is a transition (d-block) metal rather than a main-group element, which electrons most likely make up its valence electrons?$qt8$,
    $op8$[{"label":"A","text":"Only the two \\(4s^2\\) electrons, since the \\(3d^3\\) electrons lie in an inner subshell that counts as core, giving two valence electrons."},{"label":"B","text":"Only the three \\(3d^3\\) electrons of the partially filled subshell, giving three valence electrons."},{"label":"C","text":"Only an outermost \\(s\\) electron, because any \\(d\\) subshell is part of the core, giving the \\(4s\\) electrons alone as valence."},{"label":"D","text":"Both the \\(4s^2\\) and the \\(3d^3\\) electrons (the \\(ns\\) plus the \\((n-1)d\\)), giving five valence electrons in total."}]$op8$::jsonb,
    'D',
    $ex8$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure.' For a transition (d-block) element, the valence electrons include both the outermost \(ns\) electrons and the \((n-1)d\) electrons, because the \((n-1)d\) subshell is being filled across the block and its electrons participate in bonding. This differs from a main-group element, whose filled \((n-1)d^{10}\) subshell is buried in the core. Vanadium, \([\text{Ar}]4s^2 3d^3\), is a transition metal in period 4, so \(n = 4\) and \((n-1)d = 3d\); its valence electrons are the two \(4s\) electrons together with the three \(3d\) electrons, \(2 + 3 = 5\) valence electrons in all. (Choice A) Treating the \(3d^3\) electrons as core mirrors how a main-group atom's filled \((n-1)d^{10}\) is core, but for a transition metal the partially filled \((n-1)d\) is part of the valence set; excluding the \(3d\) electrons undercounts the valence electrons. (Choice B) Restricting the count to the partially filled \(3d^3\) subshell omits the \(4s^2\) electrons, yet the outermost \(ns\) electrons are valence electrons for a transition metal just as the \((n-1)d\) electrons are, so both subshells must be included. (Choice C) The claim that any \(d\) subshell belongs to the core holds only for a main-group element with a completed \((n-1)d^{10}\); in a transition metal the \((n-1)d\) electrons are valence, so confining valence to a single \(s\) electron misclassifies the \(3d^3\) electrons. Skill 1$ex8$,
    'medium', '4E', $cc8$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc8$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a8A$treats the partially filled (n-1)d as core the way a main-group atom's filled (n-1)d10 is core, counting only the ns electrons$a8A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a8B$counts only the partially filled (n-1)d subshell and omits the outermost ns electrons$a8B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a8C$applies the rule that any d subshell is core, leaving only an s electron as valence$a8C$ FROM q;

-- Q9 [Periodic Table Structure & Classification · easy · Skill 1 · ans A] (g9)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt9$A periodic table prints the two rows beginning with cerium (\(\text{Ce}\)) and thorium (\(\text{Th}\)) as a detached block below the main grid rather than inserting them into periods 6 and 7. The elements in these two detached rows are best classified as members of which block?$qt9$,
    $op9$[{"label":"A","text":"The f-block (inner transition elements), whose differentiating electrons fill \\(4f\\) and \\(5f\\) subshells"},{"label":"B","text":"The d-block (transition elements), whose differentiating electrons fill \\(3d\\) through \\(5d\\) subshells"},{"label":"C","text":"The p-block (main-group elements), whose differentiating electrons fill \\(np\\) subshells"},{"label":"D","text":"The s-block (main-group elements), whose differentiating electrons fill \\(ns\\) subshells"}]$op9$::jsonb,
    'A',
    $ex9$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. The two detached rows beginning with cerium (\(\text{Ce}\)) and thorium (\(\text{Th}\)) are the lanthanides and the actinides. They are pulled out and printed below the main grid purely by convention: inserting all fourteen elements of each row into periods 6 and 7 would make the table impractically wide, so they are displayed separately while still belonging logically between the s-block and d-block of those periods. Their defining feature is that the differentiating (last-added) electron enters an \(f\) subshell, the \(4f\) subshell across the lanthanides and the \(5f\) subshell across the actinides, which makes them the f-block, also called the inner transition elements. (Choice B) The d-block (transition) elements fill \(d\) subshells such as \(3d\), \(4d\), and \(5d\) and occupy the central body of the table within periods 4 through 7; they are not the elements detached below the grid. (Choice C) The p-block main-group elements fill \(np\) subshells and lie on the right side of the table; their electron filling does not involve \(f\) orbitals and they are not relocated below the main body. (Choice D) The s-block main-group elements fill \(ns\) subshells and occupy the two leftmost columns; like the p-block they remain in the main grid and have no \(f\)-subshell filling. Skill 1$ex9$,
    'easy', '4E', $cc9$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc9$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'adjacent_fact', $a9B$Confusing the inner transition (f-block) elements with the ordinary transition (d-block) elements that occupy the table's central body$a9B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a9C$Assigning the detached rows to the p-block, ignoring that their differentiating electrons fill f rather than p subshells$a9C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a9D$Assigning the detached rows to the s-block, ignoring that their differentiating electrons fill f rather than s subshells$a9D$ FROM q;

-- Q10 [Periodic Table Structure & Classification · hard · Skill 4 · ans B] (g10)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt10$A lab technician is cataloging a sample of an unlabeled main-group metal and has only its ground-state electron configuration, \([\text{Kr}]4d^{10}5s^2 5p^2\), plus a printed periodic table that shows period numbers down the left edge and group numbers across the top. Assuming the configuration is read correctly, where on that table should the technician expect to locate this element?$qt10$,
    $op10$[{"label":"A","text":"Period 4, Group 14"},{"label":"B","text":"Period 5, Group 14"},{"label":"C","text":"Period 5, Group 12"},{"label":"D","text":"Period 5, Group 4"}]$op10$::jsonb,
    'B',
    $ex10$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure.' The period of a main-group element equals the largest principal quantum number (n) appearing in its ground-state configuration. In \([\text{Kr}]4d^{10}5s^2 5p^2\) the highest n is 5 (the \(5s\) and \(5p\) subshells), so the element sits in Period 5. The group of a p-block element is found from its valence electrons: the outermost shell holds \(5s^2 5p^2\), giving four valence electrons and a terminal \(np^2\) configuration. Under the modern 1–18 numbering, an \(ns^2 np^2\) valence pattern corresponds to Group 14 (the carbon group). The filled \(4d^{10}\) core lies one shell below the valence shell and does not raise the period count or define the group for a p-block element. Period 5 and Group 14 identify the element as tin (Sn, Z = 50). (Choice A) Period 4 would require the largest principal quantum number to be 4, but the configuration contains \(5s\) and \(5p\) electrons, making 5 the highest n; the group assignment of 14 is correct, but the period is read from the wrong shell. (Choice C) Group 12 is reserved for the \(nd^{10}ns^2\) elements (such as zinc, cadmium, mercury) whose configurations end after a filled d subshell with no occupied p valence orbitals; here the valence shell continues into \(5p^2\), so the element is two columns to the right of Group 12. (Choice D) Group 4 contains transition metals with a partially filled d subshell ending in \(nd^2\) (such as titanium or zirconium); this element has a completely filled \(4d^{10}\) subshell and its differentiating electrons occupy the \(5p\) orbitals, placing it in the p-block rather than the d-block. Skill 4$ex10$,
    'hard', '4E', $cc10$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc10$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a10A$Assigns the period from an inner-shell principal quantum number instead of the highest occupied n$a10A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a10C$Counts only through the filled d subshell and stops at the Group 12 (nd10 ns2) column, ignoring the p valence electrons$a10C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a10D$Treats a filled d-block element as a Group 4 transition metal by using the d-electron count for the group number$a10D$ FROM q;

-- Q11 [Periodic Table Structure & Classification · medium · Skill 2 · ans C] (g11)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt11$A representative element sits in period 4, group VIIA (group 17) of the periodic table. Working only from its position, a chemist must write the valence-shell configuration without consulting a full orbital diagram. Which configuration most likely represents the valence shell of this element in its ground state?$qt11$,
    $op11$[{"label":"A","text":"\\(4s^2 3d^{10} 4p^5\\)"},{"label":"B","text":"\\(4s^2 4p^4\\)"},{"label":"C","text":"\\(4s^2 4p^5\\)"},{"label":"D","text":"\\(3s^2 3p^5\\)"}]$op11$::jsonb,
    'C',
    $ex11$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure.' For a representative (main-group) element, the period number gives the principal quantum number \(n\) of the valence shell, and the group number among the A-groups gives the total number of valence \(s\) and \(p\) electrons. Period 4 fixes \(n = 4\), and group VIIA means seven valence electrons distributed as \(ns^2 np^5\). Substituting \(n = 4\) gives the valence-shell configuration \(4s^2 4p^5\), which corresponds to bromine. The general pattern \(ns^2 np^5\) is the defining signature of the halogen group, so reading \(n\) from the period and the \(s+p\) count from the group reproduces the valence shell directly.\n\n(Choice A) The \(3d^{10}\) subshell is a filled inner subshell that lies below the \(n = 4\) valence shell; for a representative element the valence shell contains only the highest-\(n\) \(s\) and \(p\) electrons, so the completed \(3d^{10}\) belongs to the core and is not counted among the valence electrons.\n\n(Choice B) \(4s^2 4p^4\) totals six valence electrons, the \(ns^2 np^4\) signature of group VIA (group 16); it places the element one group to the left of the stated group VIIA position and so describes selenium rather than the halogen indicated.\n\n(Choice D) \(3s^2 3p^5\) has the correct group VIIA count of seven valence electrons but assigns the principal quantum number from period 3 \((n = 3)\) rather than the stated period 4; this is the valence shell of chlorine, the element one period higher in the same group.\n\nSkill 2$ex11$,
    'medium', '4E', $cc11$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc11$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a11A$Counts the filled inner 3d10 subshell as part of the valence shell instead of restricting valence to the highest-n s and p electrons$a11A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a11B$Off-by-one group assignment giving ns2 np4 (group VIA) instead of ns2 np5 (group VIIA)$a11B$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a11D$Correct group electron count but principal quantum number n read from the wrong period (n=3 instead of n=4)$a11D$ FROM q;

-- Q12 [Periodic Table Structure & Classification · easy · Skill 1 · ans D] (g12)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt12$Potassium \(\left(\text{K},\ [\text{Ar}]4s^1\right)\) and sodium \(\left(\text{Na},\ [\text{Ne}]3s^1\right)\) sit in the same group and react with chlorine in the same 1:1 ratio. Which feature shared by the two atoms is most directly responsible for this matching reactivity?$qt12$,
    $op12$[{"label":"A","text":"They occupy the same period of the periodic table."},{"label":"B","text":"They have the same number of occupied principal energy levels."},{"label":"C","text":"They have the same total number of electrons."},{"label":"D","text":"They have the same number of valence electrons."}]$op12$::jsonb,
    'D',
    $ex12$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Elements in the same group occupy the same vertical column and share an identical valence-shell electron configuration: potassium ends in \(4s^1\) and sodium ends in \(3s^1\), so each has exactly one valence electron. Because chemical reactivity is governed by the valence electrons that an atom loses, gains, or shares, both metals lose their single \(ns^1\) electron to form a \(+1\) cation and therefore combine with chlorine in the same 1:1 ratio (\(\text{KCl}\), \(\text{NaCl}\)). (Choice A) Potassium lies in period 4 and sodium in period 3, so they are not in the same period; periods reflect the highest principal quantum number \(n\), not group membership, and do not by themselves set reactivity. (Choice B) The two atoms differ in their number of occupied principal energy levels, since potassium fills through \(n=4\) while sodium fills only through \(n=3\), so this count is not shared and is not the basis for their common behavior. (Choice C) Potassium has 19 electrons and sodium has 11, so their total electron counts differ; total electron number tracks atomic number rather than the valence structure that drives bonding. Skill 1$ex12$,
    'easy', '4E', $cc12$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc12$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a12A$Confuses group with period, treating shared column as shared row$a12A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a12B$Cites number of occupied shells, a real property that differs down a group$a12B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a12C$Uses total electron count instead of valence electron count as the driver of reactivity$a12C$ FROM q;

-- Q13 [Periodic Table Structure & Classification · medium · Skill 1 · ans A] (g13)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt13$Arsenic sits in period 4 and its ground-state configuration is abbreviated \([\text{Ar}]4s^2 3d^{10} 4p^3\). Regarding arsenic's location in the periodic table, the bracketed \([\text{Ar}]\) most directly marks the$qt13$,
    $op13$[{"label":"A","text":"end of period 3, the row immediately above arsenic, whose closure supplies the core electrons."},{"label":"B","text":"end of period 4, arsenic's own row, whose closure supplies the valence electrons."},{"label":"C","text":"start of period 4, the noble gas that opens arsenic's row ahead of the \\(4s\\) electrons."},{"label":"D","text":"end of period 3, contributing core electrons that include arsenic's \\(3d^{10}\\) subshell."}]$op13$::jsonb,
    'A',
    $ex13$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. A noble-gas-core abbreviation replaces the inner electrons of an atom with the symbol of the noble gas that terminates the period directly above the element. Arsenic lies in period 4, so its core is the configuration of argon, the element closing period 3; the bracket \([\text{Ar}]\) therefore stands for the \(18\) core electrons \(1s^2 2s^2 2p^6 3s^2 3p^6\), and the electrons written explicitly after the bracket (\(4s^2 3d^{10} 4p^3\)) are those added across period 4. Because argon ends period 3, the row immediately above arsenic, choice A correctly identifies both the row and the role of the bracketed electrons. (Choice B) Argon does not close period 4; period 4 ends at krypton, and the noble-gas core never represents the element's own row, since the explicitly written \(4s^2 3d^{10} 4p^3\) electrons—not the bracket—are arsenic's outermost electrons. (Choice C) A noble gas marks the end, not the start, of a period; the element opening period 4 is potassium, an alkali metal, and the bracketed symbol denotes a filled noble-gas configuration that precedes the \(4s\) electrons rather than launching the new row. (Choice D) Although the bracket does represent core electrons from the end of period 3, the \(3d^{10}\) subshell is written explicitly outside the bracket and is filled during period 4; it is not part of the \([\text{Ar}]\) core, which contains only the \(18\) electrons through \(3p^6\). Skill 1$ex13$,
    'medium', '4E', $cc13$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc13$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a13B$noble-gas-core read as the element's own period and valence shell$a13B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a13C$noble gas placed at the start rather than the end of the preceding period$a13C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a13D$correct period but absorbs explicitly written 3d electrons into the core$a13D$ FROM q;

-- Q14 [Periodic Table Structure & Classification · hard · Skill 1 · ans B] (g14)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt14$Period 3 and period 4 both begin by filling an \(ns\) subshell, yet period 3 holds only 8 elements while period 4 holds 18. The two periods most likely differ in length because$qt14$,
    $op14$[{"label":"A","text":"period 4 has a higher principal quantum number \\(n\\), and each successive value of \\(n\\) adds eight more electron slots to a period."},{"label":"B","text":"the \\(3d\\) subshell first becomes available for filling within period 4, adding 10 electron capacity to the \\(4s\\) and \\(4p\\) subshells already filled across the period."},{"label":"C","text":"the \\(3d\\) subshell fills during period 3, so period 3 is shortened by the 10 electrons that period 4 instead retains in its valence shell."},{"label":"D","text":"period 4 begins filling the \\(4f\\) subshell, whose 14-electron capacity lengthens the period relative to period 3."}]$op14$::jsonb,
    'B',
    $ex14$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. The length of a period equals the total electron capacity of the subshells that fill across it. Period 3 fills only \(3s\) (2 electrons) and \(3p\) (6 electrons), giving 8 elements. Period 4 fills \(4s\) (2), then for the first time the \(3d\) subshell (10), and finally \(4p\) (6): \(2 + 10 + 6 = 18\). The \(3d\) subshell does not lie below \(3p\) in energy until after \(4s\) is occupied, so it does not enter the filling sequence until period 4, which is precisely why the period jumps from 8 to 18. (Choice A) Period length is set by which subshells become available, not by \(n\) alone; the increment is not a fixed eight per period, as shown by the 2, 8, 8, 18, 18, 32 pattern where lengths repeat and then jump by ten and fourteen. (Choice C) The \(3d\) subshell fills during period 4, not period 3; period 3 contains no d-block elements, and d electrons are not retained as a valence shell in the sense implied. This reverses which period gains the d-subshell. (Choice D) The \(4f\) subshell does not begin filling until period 6 (the lanthanides); its 14-electron capacity accounts for the length-32 periods, not the length-18 period 4. Skill 1$ex14$,
    'hard', '4E', $cc14$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc14$, 'general-chemistry', 1, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a14A$Believing period length scales directly with the principal quantum number, adding a fixed number of slots per period$a14A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a14C$Reversing which period the 3d subshell fills in, attributing d-filling to period 3 instead of period 4$a14C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a14D$Citing the 4f subshell (responsible for length-32 periods) instead of the 3d subshell responsible for length-18 periods$a14D$ FROM q;

-- Q15 [Periodic Table Structure & Classification · medium · Skill 2 · ans C] (g15)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt15$A neutral atom in its ground state has a valence shell described by the general configuration \(ns^2\,np^4\), where \(n\) is the principal quantum number of the outermost occupied shell. To which chemical family does this element most likely belong?$qt15$,
    $op15$[{"label":"A","text":"The alkaline earth metals (Group 2)"},{"label":"B","text":"The halogens (Group 17)"},{"label":"C","text":"The chalcogens (Group 16)"},{"label":"D","text":"The pnictogens (Group 15)"}]$op15$::jsonb,
    'C',
    $ex15$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. The family an element belongs to is fixed by the number of valence electrons, which equals the sum of the superscripts in the general valence configuration. The configuration \(ns^2\,np^4\) gives \(2 + 4 = 6\) valence electrons, placing the element in Group 16. Group 16 is the chalcogen family (oxygen, sulfur, selenium, etc.), so the configuration most likely corresponds to a chalcogen. (Choice A) The alkaline earth metals have only the \(s\) subshell filled in their valence configuration, \(ns^2\), giving 2 valence electrons; the \(np^4\) contribution rules out Group 2. (Choice B) The halogens have valence configuration \(ns^2\,np^5\) for a total of 7 valence electrons; \(ns^2\,np^4\) has one fewer \(p\) electron and therefore is not a halogen. (Choice D) The pnictogens have valence configuration \(ns^2\,np^3\) for a total of 5 valence electrons; the given configuration has one more \(p\) electron than Group 15. Skill 2$ex15$,
    'medium', '4E', $cc15$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc15$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a15A$Counting only the s-subshell electrons and ignoring the np contribution, landing on Group 2$a15A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a15B$Confusing the chalcogen configuration with the neighboring halogen ns2 np5 configuration$a15B$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a15D$Confusing the chalcogen configuration with the neighboring pnictogen ns2 np3 configuration$a15D$ FROM q;

-- Q16 [Periodic Table Structure & Classification · medium · Skill 1 · ans D] (g16)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt16$Period 6 of the periodic table begins with cesium \((6s^1)\) and ends with radon \((6s^2 6p^6)\). Filling this row in order of increasing energy populates the \(6s\), \(4f\), \(5d\), and \(6p\) subshells before the next period starts. How many elements occupy period 6?$qt16$,
    $op16$[{"label":"A","text":"8 elements"},{"label":"B","text":"18 elements"},{"label":"C","text":"50 elements"},{"label":"D","text":"32 elements"}]$op16$::jsonb,
    'D',
    $ex16$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. The length of any period equals the total number of orbitals filled across that row, with each orbital holding two electrons (and thus accommodating two elements). Period 6 fills the \(6s\) subshell (1 orbital, 2 elements), then the \(4f\) subshell (7 orbitals, 14 elements — the lanthanides), then the \(5d\) subshell (5 orbitals, 10 elements), and finally the \(6p\) subshell (3 orbitals, 6 elements). Summing gives \(2 + 14 + 10 + 6 = 32\), so period 6 contains 32 elements, matching choice D. The key structural feature distinguishing period 6 from period 4 is the appearance of an \(f\) subshell: once \(n = 6\), the \(4f\) orbitals finally drop low enough in energy to fill, adding 14 elements that periods 4 and 5 lack. (Choice A) Counting 8 elements reflects only the \(ns\) and \(np\) subshells (\(6s\) plus \(6p\), giving \(2 + 6 = 8\)), the width of a short representative-element period like period 2 or 3. It omits the \(5d\) transition metals and the \(4f\) lanthanides that also fill across period 6. (Choice B) Counting 18 elements reflects the \(6s\), \(5d\), and \(6p\) subshells (\(2 + 10 + 6 = 18\)), which is the correct width of period 4 or period 5 but not period 6. It omits the \(4f\) subshell, whose 14 lanthanides are the defining addition that makes period 6 longer than the rows above it. (Choice C) Counting 50 elements adds a second \(f\) subshell to the tally (\(2 + 14 + 14 + 10 + 6 = 46\), or treating two \(f\) blocks as \(2 + 14 + 14 + 10 + 6\) and rounding the count upward), incorporating an \(f\) subshell that does not fill until period 7 (the \(5f\) actinides). Only one \(f\) subshell, the \(4f\), fills during period 6. Skill 1$ex16$,
    'medium', '4E', $cc16$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc16$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $a16A$Counts only the ns and np representative-element subshells, yielding the width of a short period (period 2/3) while ignoring the d and f blocks.$a16A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a16B$Applies the period-4/5 length by counting ns, (n-1)d, and np but omitting the (n-2)f lanthanide subshell that fills during period 6.$a16B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a16C$Over-includes a second f subshell (the 5f actinides that belong to period 7), inflating the count beyond the single 4f block that fills in period 6.$a16C$ FROM q;

-- Q17 [Periodic Table Structure & Classification · medium · Skill 1 · ans A] (g17)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt17$A neutral arsenic atom (\(Z = 33\)) has the ground-state configuration \([\text{Ar}]4s^2 3d^{10} 4p^3\). Because arsenic is a representative (main-group) element, only the electrons in its highest occupied principal level govern its chemistry. Which electrons in this atom count as its valence electrons?$qt17$,
    $op17$[{"label":"A","text":"The \\(4s^2 4p^3\\) electrons, totaling 5 electrons in the \\(n = 4\\) shell"},{"label":"B","text":"The \\(4p^3\\) electrons alone, totaling 3 electrons in the partially filled outer subshell"},{"label":"C","text":"The \\(3d^{10} 4p^3\\) electrons, totaling 13 electrons in the two highest-energy subshells"},{"label":"D","text":"The \\(4s^2 3d^{10} 4p^3\\) electrons, totaling 15 electrons added beyond the argon core"}]$op17$::jsonb,
    'A',
    $ex17$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. For a representative (main-group) element, the valence electrons are those in the highest occupied principal energy level \(n\), which form the reactive outer shell; all electrons in lower shells, including any filled \((n-1)d\) subshell, are core. In arsenic the highest occupied principal level is \(n = 4\), populated by \(4s^2 4p^3\), giving 5 valence electrons, consistent with arsenic's placement in Group 15. The filled \(3d^{10}\) subshell has \(n = 3\) and is buried beneath the \(n = 4\) shell, so it belongs to the core.\n(Choice B) Restricting the count to the partially filled \(4p^3\) subshell omits the \(4s^2\) electrons, which occupy the same highest principal level \(n = 4\) and are equally part of the reactive outer shell; both subshells of the valence shell must be included.\n(Choice C) Grouping \(3d^{10}\) with \(4p^3\) treats the inner d subshell as valence because it is energetically close to the outer shell, but \(3d\) has principal quantum number \(n = 3\) and lies below the \(n = 4\) valence shell, so a filled \((n-1)d\) set is core for a main-group element.\n(Choice D) Summing every electron beyond the \([\text{Ar}]\) core counts the filled \(3d^{10}\) subshell as valence; for a representative element the inner d electrons are core, and valence is defined by the highest principal level \(n\), not by everything past the preceding noble gas.\nSkill 1$ex17$,
    'medium', '4E', $cc17$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc17$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'partial_truth', $a17B$Counts only the partially filled outer p subshell and omits the outer s electrons in the same n=4 shell$a17B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a17C$Includes the filled (n-1)d subshell as valence by confusing energetic proximity with shell membership$a17C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a17D$Treats all electrons beyond the noble-gas core as valence, including the filled inner 3d subshell$a17D$ FROM q;

-- Q18 [Periodic Table Structure & Classification · medium · Skill 1 · ans B] (g18)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt18$A periodic table printed with the older North American convention labels the column containing fluorine, chlorine, and bromine as Group VIIA. Under the modern IUPAC 1-18 numbering, that same column is designated as which group number?$qt18$,
    $op18$[{"label":"A","text":"Group 7"},{"label":"B","text":"Group 17"},{"label":"C","text":"Group 16"},{"label":"D","text":"Group 18"}]$op18$::jsonb,
    'B',
    $ex18$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. The halogens \(\text{F}\), \(\text{Cl}\), and \(\text{Br}\) share a valence configuration of \(ns^2 np^5\) and occupy the old Group VIIA. The modern IUPAC scheme numbers all columns sequentially 1 through 18 across the table, so the main-group columns to the right of the d-block run \(\text{VA} \to 15\), \(\text{VIA} \to 16\), \(\text{VIIA} \to 17\), and \(\text{VIIIA} \to 18\). The halogen column is therefore Group 17, making B correct.\n\n(Choice A) Group 7 in the IUPAC scheme is a d-block (transition-metal) column headed by manganese with valence character \(3d^5 4s^2\); it corresponds to the old VIIB label, not VIIA, so reading the Roman numeral VII as a literal "7" lands on the wrong block entirely.\n\n(Choice C) Group 16 is the chalcogen column (oxygen, sulfur) carrying an \(ns^2 np^4\) configuration; it is the old VIA column, one position to the left of the halogens, so it is off by one group from VIIA.\n\n(Choice D) Group 18 is the noble-gas column with the filled \(ns^2 np^6\) valence shell, corresponding to the old VIIIA label; it lies one column to the right of the halogens and is the adjacent main group rather than the halogen column itself.\n\nSkill 1$ex18$,
    'medium', '4E', $cc18$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc18$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a18A$Reading the Roman numeral VII literally as the IUPAC number 7, landing on the d-block VIIB column instead of the main-group halogens$a18A$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a18C$Off-by-one group shift, mapping VIIA to 16 (the chalcogen VIA column) instead of 17$a18C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a18D$Selecting the neighboring noble-gas column (old VIIIA = modern 18) rather than the halogen column$a18D$ FROM q;

-- Q19 [Periodic Table Structure & Classification · hard · Skill 1 · ans C] (g19)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt19$In period 4, scandium (\(Z=21\)) is the first element placed in the d-block, immediately to the right of calcium (\(Z=20\)) in the s-block. Which feature of the aufbau filling order most directly explains why the d-block is inserted between the s-block and the p-block within a single period?$qt19$,
    $op19$[{"label":"A","text":"The \\(3d\\) subshell is lower in energy than the \\(4s\\) subshell, so \\(3d\\) fills before \\(4s\\) and therefore precedes the s-block."},{"label":"B","text":"The \\(3d\\) subshell fills only after the \\(4p\\) subshell is complete, placing the d-block after the p-block in the period."},{"label":"C","text":"The \\(3d\\) subshell fills after the \\(4s\\) subshell but before the \\(4p\\) subshell, so it is occupied between the s-block and p-block elements."},{"label":"D","text":"The \\(3d\\) and \\(4p\\) subshells are degenerate, so the d-block and p-block fill simultaneously across the period."}]$op19$::jsonb,
    'C',
    $ex19$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. The block structure of the periodic table mirrors the order in which subshells are filled. In period 4 the relevant aufbau sequence is \(4s \rightarrow 3d \rightarrow 4p\): the \(4s\) subshell (filled at K and Ca) is lower in energy than the \(3d\) subshell, but the \(3d\) subshell (filled across Sc through Zn) lies below the \(4p\) subshell (filled across Ga through Kr). Because the \((n-1)d\) subshell, here \(3d\), is occupied after the \(ns\) subshell (\(4s\)) yet before the \(np\) subshell (\(4p\)), the ten d-block elements are inserted between the two s-block columns and the six p-block columns, giving the d-block its central position. (Choice A) The \(4s\) subshell is occupied before \(3d\) in the neutral-atom filling order; if \(3d\) genuinely filled first, the d-block would precede the s-block, contrary to the observed table, and Ca would not lie immediately left of Sc. (Choice B) If \(3d\) filled only after \(4p\) were complete, the d-block would appear after the p-block (to the right of the noble gas region) rather than between the s- and p-blocks. (Choice D) The \(3d\) and \(4p\) subshells are not degenerate; they differ in energy, and electrons enter \(3d\) to completion (through Zn) before any \(4p\) orbital is occupied, so the two blocks fill sequentially, not simultaneously. Skill 1.$ex19$,
    'hard', '4E', $cc19$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc19$, 'general-chemistry', 1, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a19A$Inverts the 4s/3d filling order, claiming 3d fills before 4s$a19A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a19B$Misorders the aufbau sequence so 3d follows rather than precedes 4p$a19B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a19D$Treats (n-1)d and np subshells as degenerate, implying simultaneous filling$a19D$ FROM q;

-- Q20 [Periodic Table Structure & Classification · hard · Skill 4 · ans D] (g20)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Table Structure & Classification',
    $qt20$A chemistry student is filling a blank periodic-table fragment that shows only the s-block and p-block columns, and must shade the single cell occupied by the element with atomic number \(Z = 20\). Working from the aufbau filling order, the student tracks where the highest-energy electron lands before marking the grid. Assuming the element follows the expected (non-anomalous) filling order, into which cell should it be shaded?$qt20$,
    $op20$[{"label":"A","text":"Period 4, Group 18, p-block"},{"label":"B","text":"Period 3, Group 2, s-block"},{"label":"C","text":"Period 4, Group 12, p-block"},{"label":"D","text":"Period 4, Group 2, s-block"}]$op20$::jsonb,
    'D',
    $ex20$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Filling orbitals in aufbau order for \(Z = 20\) gives \(1s^2\,2s^2\,2p^6\,3s^2\,3p^6\,4s^2\), which is calcium. The highest-energy (last-added) electron enters the \(4s\) subshell, so the element belongs to the s-block. The principal quantum number of that outermost subshell, \(n = 4\), fixes the period as Period 4, and a filled \(4s^2\) configuration with no electrons yet in \(4p\) or \(3d\) places the element in Group 2, the second s-block column. (Choice A) Period 4, Group 18 with a p-block assignment corresponds to a noble-gas configuration ending in \(4p^6\) (krypton, \(Z = 36\)); calcium's configuration terminates at \(4s^2\) and has no occupied \(4p\) orbitals. (Choice B) The period number equals the principal quantum number of the outermost occupied subshell; for \(4s^2\) that is \(n = 4\), so Period 3 is one period too low and would describe a \(3s^2\) element (magnesium, \(Z = 12\)). (Choice C) An \(s^2\) outer configuration is an s-block, not a p-block, placement, and Group 12 lies past the d-block; reaching Group 12 in Period 4 requires filling \(3d^{10}\) on top of \(4s^2\) (zinc, \(Z = 30\)), which calcium has not done. Skill 4$ex20$,
    'hard', '4E', $cc20$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc20$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a20A$noble-gas endpoint of the same period substituted for the actual outer subshell$a20A$ FROM q
UNION ALL SELECT id, 'B', 'scale_unit_error', $a20B$off-by-one period from misreading the principal quantum number of the outermost subshell$a20B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a20C$s2 outer shell misclassified as p-block and pushed past the d-block to Group 12$a20C$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch1_questions FROM questions WHERE topic='The Periodic Table' AND subtopic IN ('Periodic Table Structure & Classification');
