-- GenChem Ch1 (Atomic Structure) — Batch 3 of 3: Electron Configurations + Periodic Trends & Zeff
-- 25 questions, all confidence 5 (OpenStax Atoms First 2e); cross-batch deduped, audit clean.
-- Re-runnable. Run in Supabase SQL editor.
BEGIN;
DELETE FROM questions WHERE topic = 'Atomic Structure' AND subtopic IN ('Electron Configurations', 'Periodic Trends');

-- Q1 [Electron Configurations · easy · Skill 1 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s1$Electron Configurations$s1$,
    $qt1$A neutral sulfur atom in its ground state holds 16 electrons distributed across its subshells. Which configuration places every electron in the lowest-energy arrangement consistent with that count?$qt1$,
    $op1$[{"label": "A", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^6\\)"}, {"label": "B", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^4\\)"}, {"label": "C", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^3 4s^1\\)"}, {"label": "D", "text": "\\(1s^2 2s^2 2p^4 3s^2 3p^6\\)"}]$op1$::jsonb,
    'B',
    $ex1$This item targets ground-state electron configuration of a neutral main-group atom. A neutral sulfur atom has \(Z = 16\), so 16 electrons fill subshells in order of increasing energy following the Aufbau principle: \(1s^2 2s^2 2p^6 3s^2 3p^4\), which sums to \(2+2+6+2+4 = 16\). The valence shell \(3p\) holds 4 of its possible 6 electrons, consistent with sulfur's position in Group 16, period 3.\n\n(Choice A) This is the configuration for 18 electrons, \(1s^2 2s^2 2p^6 3s^2 3p^6\), which corresponds to neutral argon (or to the \(\text{S}^{2-}\) anion); a neutral sulfur atom has only 16 electrons, so the \(3p\) subshell cannot be filled to \(3p^6\).\n\n(Choice C) Promoting one electron into \(4s\) to give \(3p^3 4s^1\) leaves the \(3p\) subshell only half-filled while a higher-energy subshell is occupied; because \(3p\) lies below \(4s\) in energy, this is an excited-state arrangement rather than the ground state, even though it still totals 16 electrons.\n\n(Choice D) Writing \(2p^4 3s^2 3p^6\) fills the higher \(3p\) subshell while leaving the lower \(2p\) subshell short of its capacity; the Aufbau order requires \(2p\) to reach \(2p^6\) before \(3p\) is filled, so this inner-shell vacancy is not the ground state despite summing to 16 electrons.\n\nSkill 1$ex1$,
    'easy', '4E', $cc1$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc1$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $ar1A$Configuration of the isoelectronic noble gas / S2- anion rather than the neutral atom$ar1A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar1C$Excited-state promotion of an electron to 4s before filling 3p (Aufbau ordering violation)$ar1C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $ar1D$Filling outer 3p before completing inner 2p subshell (out-of-order Aufbau filling)$ar1D$ FROM q;

-- Q2 [Electron Configurations · medium · Skill 2 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s2$Electron Configurations$s2$,
    $qt2$A calcium atom loses two electrons to form \(\text{Ca}^{2+}\). Given that electrons are removed from the orbital of highest principal quantum number before any lower-shell electron is touched, which ground-state configuration describes the resulting ion?$qt2$,
    $op2$[{"label": "A", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^6\\)"}, {"label": "B", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^6 3d^2\\)"}, {"label": "C", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^4 4s^2\\)"}, {"label": "D", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^6 4s^2\\)"}]$op2$::jsonb,
    'A',
    $ex2$This item tests electronic structure, specifically the rule that cations form by removing electrons from the orbital of highest principal quantum number first. Neutral calcium (\(Z = 20\)) has the ground-state configuration \(1s^2 2s^2 2p^6 3s^2 3p^6 4s^2\), with its two valence electrons in the \(n = 4\) shell. Forming \(\text{Ca}^{2+}\) removes both \(4s\) electrons because \(n = 4\) is the highest principal quantum number occupied. The remaining 18 electrons give \(1s^2 2s^2 2p^6 3s^2 3p^6\), the closed-shell argon configuration \([\text{Ar}]\), making A correct.\n(Choice B) This configuration retains all \(n = 4\) electrons by instead placing the two removed electrons into \(3d\), which inverts the removal rule; \(3d\) is unoccupied in calcium and electrons are taken from \(n = 4\), not added to \(n = 3\).\n(Choice C) Here the two electrons are stripped from the \(3p\) subshell while the \(4s\) electrons are left in place, removing from a lower shell before the highest-\(n\) shell is emptied, which violates the highest-\(n\)-first rule.\n(Choice D) This is the configuration of neutral calcium with all 20 electrons still present, reflecting no electron loss at all and therefore corresponding to the atom rather than the \(2+\) cation.\nSkill 2$ex2$,
    'medium', '4E', $cc2$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc2$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $ar2B$Removes from highest-n correctly in count but redirects the vacancy into the empty 3d subshell, reversing add-versus-remove logic$ar2B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar2C$Strips electrons from the 3p subshell while leaving 4s filled, ignoring the highest-n-first ordering$ar2C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $ar2D$Correct neutral-atom configuration but no electrons removed, so it describes Ca rather than Ca2+$ar2D$ FROM q;

-- Q3 [Electron Configurations · medium · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s3$Electron Configurations$s3$,
    $qt3$A sulfur atom gains two electrons to form the sulfide ion. Assuming the added electrons enter the lowest-energy orbitals still available, what is the ground-state electron configuration of \(\text{S}^{2-}\)?$qt3$,
    $op3$[{"label": "A", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^4\\)"}, {"label": "B", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^5\\)"}, {"label": "C", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^6\\)"}, {"label": "D", "text": "\\(1s^2 2s^2 2p^6 3s^2 3p^2\\)"}]$op3$::jsonb,
    'C',
    $ex3$This item tests electron configuration of a monatomic anion built by aufbau filling. Neutral sulfur (\(Z = 16\)) has the ground-state configuration \(1s^2 2s^2 2p^6 3s^2 3p^4\), with the \(3p\) subshell holding four of its six possible electrons. Forming \(\text{S}^{2-}\) adds two electrons to the species, giving 18 electrons total. By the aufbau principle these electrons occupy the lowest-energy vacancies, which are the two remaining \(3p\) slots, completing that subshell: \(1s^2 2s^2 2p^6 3s^2 3p^6\). This is the closed-shell argon configuration, consistent with sulfide being isoelectronic with \(\text{Ar}\). (Choice A) \(1s^2 2s^2 2p^6 3s^2 3p^4\) is the configuration of neutral sulfur and accounts for only 16 electrons, so it omits the two electrons gained upon forming the dianion. (Choice B) \(1s^2 2s^2 2p^6 3s^2 3p^5\) corresponds to 17 electrons, the count for a \(\text{S}^{-}\) species, reflecting addition of only one electron rather than two required by the \(2-\) charge. (Choice D) \(1s^2 2s^2 2p^6 3s^2 3p^2\) corresponds to 14 electrons, the result of removing two \(3p\) electrons; this matches a \(\text{S}^{2+}\) cation, the opposite of the electron-gain process that produces an anion. Skill 2$ex3$,
    'medium', '4E', $cc3$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc3$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $ar3A$neutral-atom configuration reported for the anion (electron gain ignored)$ar3A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $ar3B$added only one electron instead of two for the 2- charge$ar3B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $ar3D$removed electrons (cation) instead of adding them for an anion$ar3D$ FROM q;

-- Q4 [Electron Configurations · medium · Skill 2 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s4$Electron Configurations$s4$,
    $qt4$A chemist is building the ground-state electron configuration of a neutral scandium atom (\(Z=21\)) by adding electrons one at a time in the experimentally observed filling order (\(1s, 2s, 2p, 3s, 3p, 4s, 3d, 4p, \ldots\)). After placing the first 20 electrons, which exactly reproduces the configuration of argon plus a filled \(4s\) subshell, into which subshell should the single remaining electron go to keep the atom in its ground state?$qt4$,
    $op4$[{"label": "A", "text": "\\(4p\\)"}, {"label": "B", "text": "\\(4d\\)"}, {"label": "C", "text": "\\(4f\\)"}, {"label": "D", "text": "\\(3d\\)"}]$op4$::jsonb,
    'D',
    $ex4$Content category: applying the observed ground-state subshell filling order to determine where the next electron is added. The first 20 electrons fill \(1s, 2s, 2p, 3s, 3p\) (the argon core, 18 electrons) followed by \(4s\) (2 electrons), accounting for the stated \([\text{Ar}]4s^2\) portion. In the experimentally observed sequence presented by OpenStax, the subshell that comes immediately after \(4s\) is \(3d\), so the 21st electron enters \(3d\), giving the ground-state configuration \([\text{Ar}]4s^2 3d^1\). (Choice A) \(4p\) does not receive electrons until after \(3d\) is occupied; placing the next electron in \(4p\) skips the \(3d\) subshell and would not produce the ground state. (Choice B) \(4d\) lies far later in the filling order, after \(4p\) and \(5s\), so it is not the next subshell to be occupied at this point. (Choice C) \(4f\) is filled much later in the sequence (after \(6s\) and \(5d\) begin), so it cannot hold the next electron in scandium. (Choice D) \(3d\) is the correct subshell, as it directly follows \(4s\) in the observed filling order and yields \([\text{Ar}]4s^2 3d^1\). Skill 2$ex4$,
    'medium', '4E', $cc4$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc4$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar4A$Continuing within shell n=4 (after 4s, jumping to 4p) instead of dropping to 3d as the observed order requires$ar4A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $ar4B$Naming a d subshell of the wrong principal quantum number (4d), which fills much later in the sequence$ar4B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $ar4C$Selecting a higher-azimuthal subshell (4f) that appears far later in the observed filling order$ar4C$ FROM q;

-- Q5 [Electron Configurations · medium · Skill 2 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s5$Electron Configurations$s5$,
    $qt5$A high-spin \(\text{Fe}^{3+}\) center sits in an environment weak enough that the \(3d\) electrons fill according to Hund's rule before any pairing occurs. How many unpaired electrons does this ion carry?$qt5$,
    $op5$[{"label": "A", "text": "3 unpaired electrons"}, {"label": "B", "text": "5 unpaired electrons"}, {"label": "C", "text": "4 unpaired electrons"}, {"label": "D", "text": "6 unpaired electrons"}]$op5$::jsonb,
    'B',
    $ex5$This item tests electron configuration and counting unpaired electrons via Hund's rule. Neutral iron is \([\text{Ar}]4s^2 3d^6\); forming \(\text{Fe}^{3+}\) removes the two \(4s\) electrons first and then one \(3d\) electron, giving \([\text{Ar}]3d^5\). With five electrons distributed across the five degenerate \(3d\) orbitals and pairing suppressed in the high-spin case, Hund's rule places one electron in each orbital with parallel spins, leaving all 5 unpaired. (Choice A) Three unpaired corresponds to a configuration in which one orbital is already doubly occupied, which contradicts the stated high-spin, pairing-suppressed condition for a half-filled \(d^5\) shell. (Choice C) Four unpaired arises from treating the ion as a \(d^6\) shell with one pair, i.e., removing too few electrons during ionization rather than reaching \([\text{Ar}]3d^5\). (Choice D) Six unpaired exceeds the number of valence \(d\) electrons present in \(\text{Fe}^{3+}\); a \(d^5\) shell holds only five electrons, so six unpaired is impossible. Skill 2$ex5$,
    'medium', '4E', $cc5$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc5$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $ar5A$Pairs one orbital prematurely, violating the half-filled Hund's-rule arrangement$ar5A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar5C$Removes too few electrons during ionization, leaving a d6 shell with one pair$ar5C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $ar5D$Reports more unpaired electrons than the d-electron count physically allows$ar5D$ FROM q;

-- Q6 [Electron Configurations · easy · Skill 1 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s6$Electron Configurations$s6$,
    $qt6$Within a single 2p orbital of a nitrogen atom, two electrons occupy the same region and share the same principal, azimuthal, and magnetic quantum numbers. According to the Pauli exclusion principle, what must distinguish these two electrons?$qt6$,
    $op6$[{"label": "A", "text": "Their spin quantum numbers \\(m_s\\), one being \\(+\\tfrac{1}{2}\\) and the other \\(-\\tfrac{1}{2}\\)"}, {"label": "B", "text": "Their magnetic quantum numbers \\(m_l\\), since each electron in an orbital takes a distinct \\(m_l\\) value"}, {"label": "C", "text": "Their azimuthal quantum numbers \\(l\\), with one electron in an \\(s\\)-type and the other in a \\(p\\)-type sublevel"}, {"label": "D", "text": "Their principal quantum numbers \\(n\\), with the paired electrons drawn from adjacent shells"}]$op6$::jsonb,
    'A',
    $ex6$This question targets the Pauli exclusion principle and the four-quantum-number identity of electrons in an atom. Each electron is described by the set \\((n, l, m_l, m_s)\\), and the Pauli exclusion principle forbids any two electrons in the same atom from sharing all four values. Two electrons in the same 2p orbital already share \\(n = 2\\), \\(l = 1\\), and one specific \\(m_l\\) value; the only remaining quantum number is the spin quantum number \\(m_s\\), which can be \\(+\\tfrac{1}{2}\\) or \\(-\\tfrac{1}{2}\\). The two electrons must therefore carry opposite spins, which is exactly why a single orbital holds at most two electrons. (Choice B) Within one orbital \\(m_l\\) is fixed by definition; distinct \\(m_l\\) values label different orbitals of the same subshell, not the two electrons sharing one orbital. (Choice C) The azimuthal quantum number \\(l\\) defines the subshell type (\\(s\\), \\(p\\), \\(d\\)); both electrons reside in the same 2p orbital, so both have \\(l = 1\\) and cannot differ here. (Choice D) The principal quantum number \\(n\\) sets the shell; both electrons occupy the \\(n = 2\\) shell, so \\(n\\) is identical and electrons within one orbital are never drawn from different shells. Skill 1$ex6$,
    'easy', '4E', $cc6$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc6$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $ar6B$Confusing which quantum number distinguishes orbitals within a subshell versus electrons within an orbital$ar6B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $ar6C$Invoking the azimuthal quantum number (subshell type) as the distinguishing feature instead of spin$ar6C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar6D$Believing paired electrons in one orbital come from different principal shells$ar6D$ FROM q;

-- Q7 [Electron Configurations · easy · Skill 1 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s7$Electron Configurations$s7$,
    $qt7$A neutral selenium atom \((Z = 34)\) is written using a noble-gas core to abbreviate its inner shells. Assuming a ground-state configuration, which notation correctly represents the atom?$qt7$,
    $op7$[{"label": "A", "text": "\\([\\text{Kr}]4s^2 3d^{10} 4p^4\\)"}, {"label": "B", "text": "\\([\\text{Ar}]4s^2 4p^4\\)"}, {"label": "C", "text": "\\([\\text{Ar}]4s^2 3d^{10} 4p^4\\)"}, {"label": "D", "text": "\\([\\text{Ar}]4s^2 3d^{10} 4p^6\\)"}]$op7$::jsonb,
    'C',
    $ex7$This item targets noble-gas-core abbreviated electron configurations. The core is the noble gas immediately preceding the element, and the remaining electrons fill outward by the Aufbau order. Selenium has 34 electrons; argon \((Z = 18)\) accounts for the first 18, leaving 16 electrons to place. After the core, filling proceeds \(4s^2\) (2 electrons), then \(3d^{10}\) (10 electrons), then \(4p^4\) (4 electrons), for a total of \(2 + 10 + 4 = 16\). This gives \([\text{Ar}]4s^2 3d^{10} 4p^4\), the configuration in choice C.\n(Choice A) Using \([\text{Kr}]\) as the core is incorrect because krypton \((Z = 36)\) follows selenium and already contains more electrons than the atom holds; the abbreviating core must be the noble gas that precedes the element, namely argon. Appending \(4s^2 3d^{10} 4p^4\) to a krypton core would describe 52 electrons, not 34.\n(Choice B) Omitting the \(3d^{10}\) subshell accounts for only \(2 + 4 = 6\) electrons beyond the argon core, totaling 24, which corresponds to chromium-region electron counts rather than selenium. The 3d subshell fills before 4p and cannot be skipped.\n(Choice D) Writing \(4p^6\) places six electrons in the 4p subshell, summing to \(2 + 10 + 6 = 18\) beyond argon for a total of 36; that is the configuration of krypton, the next noble gas, not the neutral selenium atom, which has two fewer p electrons.\nSkill 1$ex7$,
    'easy', '4E', $cc7$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc7$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar7A$Selecting the noble gas that follows the element as the core instead of the one that precedes it$ar7A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $ar7B$Skipping the d-block (3d) filling step between the 4s and 4p subshells$ar7B$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $ar7D$Filling the valence p subshell completely, yielding the next noble gas's configuration$ar7D$ FROM q;

-- Q8 [Electron Configurations · hard · Skill 2 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s8$Electron Configurations$s8$,
    $qt8$Neutral chromium adopts \([\text{Ar}]4s^1 3d^5\) rather than \([\text{Ar}]4s^2 3d^4\). If the stabilization arises from a half-filled \(3d\) set, the ground-state configuration of the \(\text{Cr}^+\) cation should preserve that arrangement when one electron is removed.$qt8$,
    $op8$[{"label": "A", "text": "\\([\\text{Ar}]4s^2 3d^3\\), because ionization first restores the \\(4s^2\\) pairing before the \\(3d\\) electrons are touched"}, {"label": "B", "text": "\\([\\text{Ar}]4s^1 3d^4\\), because the \\(3d\\) electron is removed to leave the lower-energy \\(4s\\) orbital occupied"}, {"label": "C", "text": "\\([\\text{Ar}]4s^0 3d^4\\), because both the \\(4s\\) electron and one \\(3d\\) electron leave to satisfy the \\(+1\\) charge"}, {"label": "D", "text": "\\([\\text{Ar}]4s^0 3d^5\\), because the \\(4s\\) electron ionizes first, leaving the half-filled \\(3d^5\\) set intact"}]$op8$::jsonb,
    'D',
    $ex8$This item tests electron configurations of transition-metal cations, specifically how the half-filled \(3d\) exception in chromium survives ionization. Neutral Cr is \([\text{Ar}]4s^1 3d^5\). For transition metals, the \(4s\) electrons are removed before \(3d\) electrons during ionization because once the \(3d\) orbitals are populated they drop below \(4s\) in energy. Removing the single \(4s\) electron yields \([\text{Ar}]4s^0 3d^5\), which conveniently leaves the half-filled \(3d^5\) set intact, so D is correct.\n(Choice A) \([\text{Ar}]4s^2 3d^3\) is impossible: the neutral atom only has one \(4s\) electron to begin with, so ionization cannot produce a \(4s^2\) configuration, and \(4s\) is preferentially emptied, not filled, on cation formation.\n(Choice B) \([\text{Ar}]4s^1 3d^4\) inverts the ionization order. The \(4s\) orbital lies higher in energy than the occupied \(3d\) orbitals in the ion, so the \(4s\) electron is lost first; retaining \(4s^1\) while depleting \(3d\) contradicts the observed ordering.\n(Choice C) \([\text{Ar}]4s^0 3d^4\) removes two electrons (one \(4s\) and one \(3d\)) and corresponds to \(\text{Cr}^{2+}\), an overcount of charge; a \(+1\) cation requires removal of exactly one electron.\nSkill 2$ex8$,
    'hard', '4E', $cc8$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc8$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar8A$Believes 4s fills/empties to a paired s2 configuration, ignoring the s1 ground state of chromium$ar8A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $ar8B$Reverses ionization order by removing a 3d electron before the higher-energy 4s electron$ar8B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $ar8C$Removes two electrons for a +1 charge, producing the +2 cation configuration instead$ar8C$ FROM q;

-- Q9 [Electron Configurations · medium · Skill 2 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s9$Electron Configurations$s9$,
    $qt9$A solid sample of a first-row transition-metal dichloride is suspended in a Gouy balance, and the sample registers no apparent weight change when the magnetic field is switched on. If the metal is present as a \(+2\) ion in its ground state, which ion is consistent with this observation?$qt9$,
    $op9$[{"label": "A", "text": "\\(\\text{Zn}^{2+}\\), with the configuration \\([\\text{Ar}]3d^{10}\\)"}, {"label": "B", "text": "\\(\\text{Cu}^{2+}\\), with the configuration \\([\\text{Ar}]3d^{9}\\)"}, {"label": "C", "text": "\\(\\text{Fe}^{2+}\\), with the configuration \\([\\text{Ar}]3d^{6}\\)"}, {"label": "D", "text": "\\(\\text{Ni}^{2+}\\), with the configuration \\([\\text{Ar}]3d^{8}\\)"}]$op9$::jsonb,
    'A',
    $ex9$This question targets the link between ground-state electron configuration and magnetic behavior. A sample that shows no weight change in a Gouy balance is not drawn into the field, the signature of a diamagnetic species; diamagnetism requires that every electron be spin-paired, i.e., zero unpaired electrons. The answer is A because \(\text{Zn}^{2+}\) loses both \(4s\) electrons from \([\text{Ar}]3d^{10}4s^2\) to give \([\text{Ar}]3d^{10}\), a completely filled \(3d\) subshell in which all ten electrons are paired, so the ion is diamagnetic and is not pulled into the field. (Choice B) \(\text{Cu}^{2+}\) is \([\text{Ar}]3d^{9}\); a \(d^9\) subshell has one half-filled orbital and therefore one unpaired electron, making the ion paramagnetic. (Choice C) \(\text{Fe}^{2+}\) is \([\text{Ar}]3d^{6}\); distributing six electrons over five \(3d\) orbitals by Hund's rule leaves four orbitals singly occupied, giving four unpaired electrons and strong paramagnetism, so an even electron count does not guarantee full pairing. (Choice D) \(\text{Ni}^{2+}\) is \([\text{Ar}]3d^{8}\); a \(d^8\) free ion has two singly occupied orbitals and thus two unpaired electrons, again paramagnetic. Skill 2 (Scientific Reasoning and Problem Solving).$ex9$,
    'medium', '4E', $cc9$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc9$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'partial_truth', $ar9B$Nearly filled d subshell (d9) mistaken for fully paired; overlooks the single unpaired electron$ar9B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar9C$Assumes an even number of d electrons (d6) means all electrons are paired, ignoring Hund's rule$ar9C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $ar9D$Common late-3d divalent ion (d8) with an even count, but Hund's rule leaves two unpaired electrons$ar9D$ FROM q;

-- Q10 [Electron Configurations · medium · Skill 1 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s10$Electron Configurations$s10$,
    $qt10$A neutral selenium atom has the ground-state configuration \(1s^2 2s^2 2p^6 3s^2 3p^6 4s^2 3d^{10} 4p^4\). Treating selenium as a main-group element, how many of these electrons count as valence electrons?$qt10$,
    $op10$[{"label": "A", "text": "4, corresponding to the four \\(4p^4\\) electrons in the partially filled subshell"}, {"label": "B", "text": "6, corresponding to the \\(4s^2 4p^4\\) electrons in the \\(n=4\\) shell"}, {"label": "C", "text": "16, corresponding to the \\(4s^2 3d^{10} 4p^4\\) electrons added after the argon core"}, {"label": "D", "text": "10, corresponding to the filled \\(3d^{10}\\) subshell that lies just below the outer shell"}]$op10$::jsonb,
    'B',
    $ex10$This item tests counting valence electrons for a main-group element from its full electron configuration. For a main-group (s- or p-block) element, the valence electrons are those occupying the highest principal quantum number, here \(n=4\). Selenium's \(n=4\) electrons are \(4s^2 4p^4\), giving 6 valence electrons, consistent with its placement in group 16. The filled \(3d^{10}\) subshell lies below the outer shell and behaves as part of the core for a p-block element, so it is excluded. (Choice A) Counting only the partially filled \(4p^4\) subshell omits the \(4s^2\) electrons, which share the same \(n=4\) outer shell and are also valence electrons. (Choice C) Summing every electron beyond the \([\text{Ar}]\) core includes the \(3d^{10}\) subshell; for a main-group element the inner d electrons are core, not valence, so this overcounts. (Choice D) The \(3d^{10}\) subshell, although filled and energetically near the outer shell, has principal quantum number \(n=3\) and is part of the core for a p-block element, not the valence set. Skill 1$ex10$,
    'medium', '4E', $cc10$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc10$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $ar10A$counts only the partially filled outer subshell and omits the outer s electrons$ar10A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar10C$treats all electrons beyond the noble-gas core as valence, including filled inner d$ar10C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $ar10D$selects the filled (n-1)d subshell as valence by confusing energetic proximity with shell membership$ar10D$ FROM q;

-- Q11 [Periodic Trends · easy · Skill 1 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s11$Periodic Trends$s11$,
    $qt11$Across period 3, silicon and chlorine occupy the same row, so any size difference between their neutral atoms cannot be attributed to a change in the number of occupied electron shells. Why does the chlorine atom have a smaller atomic radius than the silicon atom?$qt11$,
    $op11$[{"label": "A", "text": "Chlorine holds its valence electrons in a higher principal energy level than silicon does."}, {"label": "B", "text": "Chlorine's valence electrons experience greater shielding from the added inner-shell electrons."}, {"label": "C", "text": "Chlorine has a larger nuclear charge pulling on valence electrons in the same shell, raising the effective nuclear charge."}, {"label": "D", "text": "Chlorine's valence electrons enter a new shell, increasing electron-electron repulsion within that shell."}]$op11$::jsonb,
    'C',
    $ex11$This question targets periodic trends, specifically the cause of decreasing atomic radius left-to-right across a period. Moving from silicon (\(Z = 14\)) to chlorine (\(Z = 17\)), each added proton increases the nuclear charge while the new electrons fill the same \(n=3\) valence shell, \(3s^2 3p^x\). Because electrons in the same shell shield one another poorly, the screening constant \(S\) rises only slightly, so the effective nuclear charge \(Z_\text{eff} = Z - S\) climbs steadily. The stronger net pull draws the valence shell inward, giving chlorine the smaller radius. The constraint stated in the stem — same row, same number of shells — isolates nuclear charge as the operative variable.\n\n(Choice A) Both silicon and chlorine hold their valence electrons in the same principal level, \(n=3\); the highest occupied shell does not change across a period, so this misstates the electron configuration.\n\n(Choice B) Added electrons across a period enter the same valence shell rather than inner shells, so core shielding stays essentially constant; invoking greater shielding predicts the wrong direction, since rising \(Z_\text{eff}\) actually shrinks the atom.\n\n(Choice D) No new shell opens between silicon and chlorine — both end in \(n=3\) — and the modest increase in same-shell repulsion is outweighed by the larger nuclear charge, so this reverses the dominant effect.\n\nSkill 1$ex11$,
    'easy', '4E', $cc11$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc11$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar11A$Believes moving right across a period adds a higher energy shell, conflating period position with principal quantum number$ar11A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $ar11B$Asserts shielding increases across a period and dominates, predicting the opposite size trend$ar11B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $ar11D$Treats crossing a period like descending a group, opening a new shell and emphasizing repulsion over nuclear charge$ar11D$ FROM q;

-- Q12 [Periodic Trends · easy · Skill 1 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s12$Periodic Trends$s12$,
    $qt12$Moving from \(\text{Li}\) to \(\text{Na}\) to \(\text{K}\), the alkali metals in Group 1 gain successive principal energy shells. Which factor accounts for the atomic radius increasing in this direction down the group?$qt12$,
    $op12$[{"label": "A", "text": "The effective nuclear charge \\(Z_\\text{eff}\\) felt by the outermost electron rises sharply with each added shell."}, {"label": "B", "text": "Each successive element holds fewer valence electrons, loosening the outer shell."}, {"label": "C", "text": "The added protons pull the existing electron cloud inward more strongly than the new shell expands it."}, {"label": "D", "text": "Each successive element places its valence electrons in a higher principal energy level that lies farther from the nucleus."}]$op12$::jsonb,
    'D',
    $ex12$This question targets periodic trends in atomic structure. Down a group, the highest occupied principal quantum number \(n\) increases by one with each element: \(\text{Li}\) fills \(n=2\), \(\text{Na}\) fills \(n=3\), and \(\text{K}\) fills \(n=4\). Each higher \(n\) shell has a larger average distance from the nucleus, and the inner electrons of the filled shells shield the outermost electron from the added nuclear charge, so the valence electron occupies an orbital farther out. The net result is a larger atomic radius, making (D) correct. (Choice A) \(Z_\text{eff}\) on the outermost electron stays roughly constant down a group rather than rising sharply, because increased core shielding largely offsets the added protons; even where \(Z_\text{eff}\) edges up slightly, a higher \(Z_\text{eff}\) would contract the atom, contradicting the observed increase. (Choice B) All Group 1 elements share one valence electron; the valence count does not decrease down the group. (Choice C) The proton count does grow, but the dominant effect is the addition of a new, more distant shell that expands the radius, not an inward contraction of the cloud. Skill 1.$ex12$,
    'easy', '4E', $cc12$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc12$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $ar12A$Claims Z_eff rises sharply down a group and would expand the atom, inverting both the trend in effective nuclear charge and its effect on radius$ar12A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $ar12B$Assumes valence electron count changes down a group rather than staying constant within Group 1$ar12B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $ar12C$Correctly notes protons are added but wrongly concludes nuclear attraction dominates and shrinks the atom, ignoring the new outer shell$ar12C$ FROM q;

-- Q13 [Periodic Trends · medium · Skill 2 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s13$Periodic Trends$s13$,
    $qt13$A sulfur atom gains two electrons to form the sulfide ion \(\text{S}^{2-}\), completing the \(3p\) subshell. With the nuclear charge fixed at \(Z = 16\), which factor most directly accounts for \(\text{S}^{2-}\) having a larger radius than the neutral sulfur atom?$qt13$,
    $op13$[{"label": "A", "text": "Added electrons increase electron-electron repulsion within the \\(n = 3\\) shell while the nuclear charge stays the same, lowering the effective nuclear charge per electron."}, {"label": "B", "text": "The added electrons occupy a new \\(n = 4\\) shell that lies farther from the nucleus than the valence shell of neutral sulfur."}, {"label": "C", "text": "Gaining electrons raises the effective nuclear charge, which pulls the electron cloud inward but elongates the bonding orbitals."}, {"label": "D", "text": "The added electrons increase the number of protons screened, raising \\(Z\\) and weakening each electron's attraction to the nucleus."}]$op13$::jsonb,
    'A',
    $ex13$This question targets periodic trends in ionic versus atomic radius. When a neutral atom gains electrons to form an anion, the nuclear charge \(Z\) is unchanged but the electron count rises, so the same nuclear pull is now shared among more electrons. The result is greater electron-electron repulsion in the valence shell and a lower effective nuclear charge per electron \(Z_\text{eff} = Z - S\), so the electron cloud expands and the anion is larger than the parent atom. For \(\text{S}^{2-}\), the configuration becomes \(1s^2 2s^2 2p^6 3s^2 3p^6\); the two extra electrons remain in the \(n = 3\) shell, and the swelling comes from repulsion at fixed \(Z\), making (A) correct. (Choice B) The added electrons complete the existing \(3p\) subshell to give \([\text{Ne}]3s^2 3p^6\); no \(n = 4\) shell is populated, so a new outer shell does not explain the size increase. (Choice C) Adding electrons at fixed proton count cannot raise the effective nuclear charge; \(Z_\text{eff}\) decreases, and a higher \(Z_\text{eff}\) would contract rather than enlarge the species, so the direction of the relationship is inverted. (Choice D) The proton count is fixed at \(Z = 16\) when electrons are gained; adding electrons does not raise \(Z\), so attributing the expansion to a larger nuclear charge misstates what changes during anion formation. Skill 2$ex13$,
    'medium', '4E', $cc13$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc13$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $ar13B$new outer shell added on electron gain$ar13B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $ar13C$anion formation raises effective nuclear charge$ar13C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar13D$gaining electrons increases the proton count Z$ar13D$ FROM q;

-- Q14 [Periodic Trends · hard · Skill 2 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s14$Periodic Trends$s14$,
    $qt14$A materials lab is comparing four monatomic ions — \(\text{S}^{2-}\), \(\text{Cl}^-\), \(\text{K}^+\), and \(\text{Ca}^{2+}\) — that are isoelectronic (18 electrons each). A technician needs to list them from largest to smallest ionic radius before modeling how they pack into a crystal lattice. Assuming the technician reasons only from the property that actually differs among these species, which ordering should be reported?$qt14$,
    $op14$[{"label": "A", "text": "\\(\\text{Ca}^{2+} > \\text{K}^+ > \\text{Cl}^- > \\text{S}^{2-}\\)"}, {"label": "B", "text": "\\(\\text{S}^{2-} > \\text{Cl}^- > \\text{K}^+ > \\text{Ca}^{2+}\\)"}, {"label": "C", "text": "\\(\\text{Cl}^- > \\text{S}^{2-} > \\text{Ca}^{2+} > \\text{K}^+\\)"}, {"label": "D", "text": "\\(\\text{Ca}^{2+} > \\text{S}^{2-} > \\text{K}^+ > \\text{Cl}^-\\)"}]$op14$::jsonb,
    'B',
    $ex14$This is an isoelectronic periodic-trend ranking: identify the single variable that sets size when electron count is held constant. All four ions share 18 electrons, so electron–electron repulsion and the occupied shells are identical across the set; the only property that differs is nuclear charge. With a fixed electron cloud, a larger proton count exerts a stronger pull, raising \(Z_\text{eff}\) felt by every electron and contracting the radius. Ranking by proton number gives \(\text{S}^{2-}\) (\(Z = 16\)) > \(\text{Cl}^-\) (\(Z = 17\)) > \(\text{K}^+\) (\(Z = 19\)) > \(\text{Ca}^{2+}\) (\(Z = 20\)), i.e. radius decreases as \(Z\) increases, making B correct.\n(Choice A) This is the exact reverse, ordering by increasing radius (smallest first) or treating higher nuclear charge as producing a larger ion; for an isoelectronic series the species with the most protons (\(\text{Ca}^{2+}\)) is the smallest, not the largest.\n(Choice C) This ranks by the magnitude of ionic charge — pairing the \(2-\)/\(2+\) ions and the \(1-\)/\(1+\) ions and assuming charge sign or magnitude alone dictates size — rather than by proton count; charge magnitude does not order an isoelectronic set independently of \(Z\).\n(Choice D) This interleaves anions and cations by charge magnitude (both \(2\)-charged ions placed ahead of both \(1\)-charged ions), which ignores that within a fixed 18-electron set the continuous variable governing radius is nuclear charge, yielding a strictly monotonic decrease with \(Z\).\nSkill 2$ex14$,
    'hard', '4E', $cc14$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc14$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $ar14A$Orders the isoelectronic series by increasing radius (treats more protons as producing a larger ion)$ar14A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar14C$Ranks by ionic charge magnitude/sign instead of proton count$ar14C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $ar14D$Interleaves ions by charge magnitude, mixing the charge-based and Z-based ordering steps$ar14D$ FROM q;

-- Q15 [Periodic Trends · medium · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s15$Periodic Trends$s15$,
    $qt15$A chemistry student tabulating first ionization energies across period 2 expects a smooth increase from left to right, but notices that boron requires slightly less energy to remove its first electron than beryllium does, breaking the upward trend at the Group 2-to-Group 13 step. Given that beryllium is \([\text{He}]2s^2\) and boron is \([\text{He}]2s^2 2p^1\), which factor most directly accounts for boron's lower first ionization energy?$qt15$,
    $op15$[{"label": "A", "text": "Beryllium's two \\(2s\\) electrons repel each other strongly, so the \\(2s\\) electron in beryllium is held more loosely and easier to remove than boron's \\(2p\\) electron."}, {"label": "B", "text": "Boron has one more proton than beryllium, and the added nuclear charge pulls all of boron's electrons outward, reducing the energy needed to remove the outermost one."}, {"label": "C", "text": "The electron removed from boron occupies a \\(2p\\) orbital, which is higher in energy and less penetrating than the filled \\(2s\\) subshell, so it is held less tightly than a \\(2s\\) electron in beryllium."}, {"label": "D", "text": "Boron's half-filled \\(2p\\) subshell gives it extra stability, and releasing this stabilized electron lowers the ionization energy relative to beryllium."}]$op15$::jsonb,
    'C',
    $ex15$This question targets the rationale for the small dip in first ionization energy from Group 2 to Group 13 in period 2. The general trend is that first ionization energy rises across a period as nuclear charge increases while electrons enter the same shell, but the Be-to-B step is a documented exception. Beryllium's outermost electron occupies the \(2s\) subshell, which penetrates close to the nucleus and is held tightly. Boron's outermost electron occupies a \(2p\) orbital, which lies higher in energy and is less penetrating; the filled \(2s\) subshell partially shields the \(2p\) electron from the nucleus. Because the \(2p\) electron is intrinsically easier to remove than a \(2s\) electron, boron's first ionization energy dips slightly below beryllium's despite boron's larger nuclear charge. (Choice A) Electron-electron repulsion within beryllium's \(2s^2\) pair is not the operative factor; the dip arises from the difference between removing a \(2p\) electron versus a \(2s\) electron, and beryllium's filled \(2s\) subshell is comparatively stable, not destabilized into easy ionization. (Choice B) The added proton in boron increases the effective nuclear charge and would, on its own, raise ionization energy; it does not pull electrons outward to loosen them, so it cannot explain a lower value. (Choice D) A half-filled subshell stability argument applies to the larger nitrogen-to-oxygen dip (\(2p^3\) configuration), not to boron, whose single \(2p^1\) electron is neither half-filled nor specially stabilized. Skill 2$ex15$,
    'medium', '4E', $cc15$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc15$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar15A$Attributes the dip to repulsion within the filled 2s pair rather than the 2s-versus-2p orbital energy difference$ar15A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $ar15B$Treats the added nuclear charge as loosening electrons, reversing its actual ionization-raising effect$ar15B$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $ar15D$Imports the half-filled-subshell stability argument that explains the separate N-to-O dip$ar15D$ FROM q;

-- Q16 [Periodic Trends · medium · Skill 2 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s16$Periodic Trends$s16$,
    $qt16$Within Group 1, cesium loses its outermost \(6s\) electron more readily than lithium loses its \(2s\) electron, despite cesium's nucleus carrying a far greater positive charge. Which factor most directly accounts for cesium's lower first ionization energy?$qt16$,
    $op16$[{"label": "A", "text": "Cesium's valence electron experiences a larger effective nuclear charge, which loosens its hold on the electron."}, {"label": "B", "text": "Cesium's greater nuclear charge increases the attraction for the valence electron, raising the energy released on ionization."}, {"label": "C", "text": "Cesium has more valence electrons available to be removed, so the first one departs with less energy input."}, {"label": "D", "text": "Cesium's valence electron occupies a higher principal energy level and is shielded by more inner electrons, leaving it more weakly bound to the nucleus."}]$op16$::jsonb,
    'D',
    $ex16$This question targets periodic trends in first ionization energy and the interplay between nuclear charge, shielding, and orbital size down a group. Ionization energy is governed by how tightly the nucleus holds the outermost electron, which depends on effective nuclear charge \(Z_\text{eff} = Z - S\) and the distance of that electron from the nucleus. Descending Group 1, the valence electron occupies progressively higher principal energy levels (\(2s\) for Li up to \(6s\) for Cs), and each new period adds a filled inner shell that screens the nuclear charge. The added shielding keeps \(Z_\text{eff}\) roughly constant while the orbital radius grows sharply, so the \(6s\) electron in cesium sits far from the nucleus and feels a weak net pull. Less energy is therefore required to remove it, making cesium's first ionization energy lower than lithium's. (Choice A) The valence electron in cesium does not experience a larger \(Z_\text{eff}\); inner-shell shielding offsets the larger \(Z\), so \(Z_\text{eff}\) stays comparable to lithium's while distance increases. (Choice B) Greater nuclear charge alone would predict stronger attraction and higher ionization energy, which is the reverse of the observed trend; this ignores the shielding and distance effects that dominate. (Choice C) The number of valence electrons available does not lower the energy needed to remove the first one; all Group 1 atoms have a single \(ns^1\) valence electron, so this premise is false. Skill 2$ex16$,
    'medium', '4E', $cc16$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc16$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar16A$Believing Z_eff increases down a group because nuclear charge increases, ignoring shielding$ar16A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $ar16B$Applying the higher-Z-means-stronger-pull logic to predict the opposite ionization-energy trend$ar16B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar16C$Conflating number of valence electrons with the energy cost of removing the first electron$ar16C$ FROM q;

-- Q17 [Periodic Trends · hard · Skill 2 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s17$Periodic Trends$s17$,
    $qt17$Across Period 3, the first ionization energy of phosphorus exceeds that of sulfur, breaking the otherwise increasing left-to-right trend. If the comparison is restricted to the energy required to remove the highest-energy electron from each neutral atom, which feature of sulfur accounts for its lower value?$qt17$,
    $op17$[{"label": "A", "text": "Sulfur's \\(3p^4\\) configuration forces electron pairing in one \\(3p\\) orbital, and the resulting electron-electron repulsion makes that paired electron easier to remove."}, {"label": "B", "text": "Sulfur's half-filled \\(3p^3\\) subshell provides extra exchange stability, so removing an electron from the stable set requires less energy."}, {"label": "C", "text": "Sulfur's outermost electron occupies a \\(3d\\) orbital that is higher in energy than phosphorus's \\(3p\\) orbital, so it is more weakly held."}, {"label": "D", "text": "Sulfur has a larger effective nuclear charge than phosphorus, which expands the \\(3p\\) cloud and weakens its hold on the outermost electron."}]$op17$::jsonb,
    'A',
    $ex17$This item targets the group 15-to-16 exception in the first-ionization-energy trend, where a configuration-stability argument explains a localized dip. Phosphorus has a \\(3p^3\\) configuration in which each of the three \\(3p\\) orbitals holds a single electron, a half-filled subshell that is stabilized by exchange energy. Sulfur, at \\(3p^4\\), must place a second electron into one of those \\(3p\\) orbitals, producing a doubly occupied orbital. The two electrons sharing one orbital experience increased mutual repulsion, which raises the energy of that paired electron and makes it comparatively easy to remove. As a result, sulfur's first ionization energy falls below phosphorus's even though nuclear charge has increased, which is exactly the small dip the trend predicts. (Choice B) Inverts the relationship: the half-filled \\(3p^3\\) stability belongs to phosphorus, and that extra stability is why phosphorus is harder to ionize, not why sulfur is easier; sulfur is \\(3p^4\\), not half-filled. (Choice C) Misassigns the valence orbital: the outermost electron of sulfur resides in \\(3p\\), not \\(3d\\); the \\(3d\\) set is empty in neutral sulfur and plays no role in removing its highest-energy electron. (Choice D) Couples a true premise to a false consequence and reverses the size effect: a larger effective nuclear charge contracts the electron cloud and would tighten the atom's hold, which cannot explain a lower ionization energy. Skill 2$ex17$,
    'hard', '4E', $cc17$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc17$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $ar17B$Assigns the half-filled-subshell stability to the wrong element, reversing which atom is stabilized$ar17B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar17C$Believes a period-3 valence electron occupies a 3d orbital rather than 3p$ar17C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $ar17D$Correct that Zeff increases but wrongly claims it expands the cloud and lowers IE$ar17D$ FROM q;

-- Q18 [Periodic Trends · hard · Skill 4 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s18$Periodic Trends$s18$,
    $qt18$Successive ionization energies (in \(\text{kJ/mol}\)) for a neutral third-period element are measured as \(\text{IE}_1 = 578\), \(\text{IE}_2 = 1817\), \(\text{IE}_3 = 2745\), and \(\text{IE}_4 = 11{,}577\). The element forms a chloride in which it adopts its most common oxidation state. Which formula represents that chloride?$qt18$,
    $op18$[{"label": "A", "text": "\\(\\text{XCl}_2\\)"}, {"label": "B", "text": "\\(\\text{XCl}_3\\)"}, {"label": "C", "text": "\\(\\text{XCl}_4\\)"}, {"label": "D", "text": "\\(\\text{XCl}\\)"}]$op18$::jsonb,
    'B',
    $ex18$This item tests periodic trends, specifically using the position of the large jump in successive ionization energies to infer the number of valence electrons and the resulting ionic charge. The first three ionization energies rise gradually (578 → 1817 → 2745 kJ/mol), but \(\text{IE}_4\) leaps to 11,577 kJ/mol, more than four times \(\text{IE}_3\). That jump marks the point where the next electron must come from the noble-gas core (here \([\text{Ne}]\)) rather than the valence shell. A jump after the third removal means exactly three valence electrons are accessible, identifying a third-period Group 13 element (aluminum, \(1s^2 2s^2 2p^6 3s^2 3p^1\)). With three valence electrons, the most common oxidation state is +3, giving \(\text{Al}^{3+}\) and the chloride \(\text{XCl}_3\) (\(\text{AlCl}_3\)), so B is correct.\n(Choice A) \(\text{XCl}_2\) corresponds to a +2 ion, which would require the large jump to fall after the second ionization (between \(\text{IE}_2\) and \(\text{IE}_3\)); here \(\text{IE}_3\) is only modestly larger than \(\text{IE}_2\), so the third electron is still a valence electron and a +2 charge undercounts the available valence electrons.\n(Choice C) \(\text{XCl}_4\) corresponds to a +4 ion, but removing a fourth electron breaches the stable core, as shown by the steep \(\text{IE}_4\); the energy cost makes a +4 state inaccessible under ordinary chemical conditions.\n(Choice D) \(\text{XCl}\) corresponds to a +1 ion, which would require a large jump immediately after \(\text{IE}_1\); the smooth progression through \(\text{IE}_3\) shows that three electrons are removed with comparable ease, so a +1 charge ignores the two additional easily removed valence electrons.\nSkill 4$ex18$,
    'hard', '4E', $cc18$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc18$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar18A$Places the large IE jump one step too early, inferring a +2 ion from a +3 element$ar18A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar18C$Treats the post-jump core electron as a valence electron, assigning an inaccessible +4 state$ar18C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $ar18D$Counts only the first easily removed electron and assigns +1, ignoring the smooth IE2/IE3 progression$ar18D$ FROM q;

-- Q19 [Periodic Trends · medium · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s19$Periodic Trends$s19$,
    $qt19$Moving from boron to fluorine across period 2, electron affinity becomes more negative even though each added electron enters the same principal energy level. A chemist attributes this trend to the change in effective nuclear charge felt by an incoming electron. Which factor most directly accounts for the more negative electron affinity at fluorine relative to boron?$qt19$,
    $op19$[{"label": "A", "text": "The added electron at fluorine occupies a higher principal energy level, lowering its potential energy and releasing more energy."}, {"label": "B", "text": "The atomic radius increases across the period, allowing the incoming electron to settle farther from electron-electron repulsion."}, {"label": "C", "text": "The nuclear charge increases by one proton per element while the added electrons screen one another poorly within the same \\(2p\\) subshell, so \\(Z_\\text{eff}\\) rises and binds the incoming electron more tightly."}, {"label": "D", "text": "Each successive element gains a fully paired \\(2p\\) subshell, and the extra pairing stabilization is what drives the release of energy."}]$op19$::jsonb,
    'C',
    $ex19$This question targets periodic trends in electron affinity and their basis in effective nuclear charge. Across period 2 the added electrons all enter the \\(n=2\\) shell, and electrons within the same shell shield one another inefficiently (\\(S\\) rises by much less than 1 per added electron). Because nuclear charge climbs by a full proton at each step while screening lags, \\(Z_\\text{eff} = Z - S\\) increases from boron to fluorine. A larger \\(Z_\\text{eff}\\) pulls an incoming electron in more strongly, so more energy is released and electron affinity becomes more negative — matching choice C.\n\n(Choice A) The added electron across period 2 enters the same principal level (\\(n=2\\), the \\(2p\\) subshell), not a higher one; a higher level would place the electron farther from the nucleus and make electron affinity less negative, the opposite of the observed trend.\n\n(Choice B) Atomic radius decreases across a period as \\(Z_\\text{eff}\\) rises; the contraction, not an increase, accompanies the more negative electron affinity, so this premise is factually inverted.\n\n(Choice D) Fluorine's \\(2p\\) subshell is not fully paired (\\(2p^5\\)), and pairing generally adds electron-electron repulsion rather than net stabilization; the dominant driver of the trend is rising \\(Z_\\text{eff}\\), not pairing energy.\n\nSkill 2$ex19$,
    'medium', '4E', $cc19$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc19$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar19A$Confusing horizontal period movement with vertical group movement (added electron entering a higher shell)$ar19A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $ar19B$Claiming atomic radius increases across a period when it decreases$ar19B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar19D$Attributing the trend to subshell pairing stabilization rather than effective nuclear charge$ar19D$ FROM q;

-- Q20 [Periodic Trends · medium · Skill 1 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s20$Periodic Trends$s20$,
    $qt20$A chemist compares the electron-attracting tendency of chlorine, located one period below and one group to the right of oxygen, against that of oxygen itself. Although chlorine sits farther to the right along its period, the comparison must reconcile two opposing periodic influences. Which element holds the greater electronegativity, and what governs the outcome?$qt20$,
    $op20$[{"label": "A", "text": "\\(\\text{Cl}\\), because its larger nuclear charge of \\(Z = 17\\) outweighs any effect of period placement"}, {"label": "B", "text": "\\(\\text{Cl}\\), because moving rightward across a period always raises electronegativity more than moving up a group raises it"}, {"label": "C", "text": "\\(\\text{O}\\) and \\(\\text{Cl}\\) are equal, because the rightward shift and the downward shift cancel one another"}, {"label": "D", "text": "\\(\\text{O}\\), because the shorter distance from the nucleus to the valence shell in period 2 outweighs the rightward gain chlorine has in period 3"}]$op20$::jsonb,
    'D',
    $ex20$This item targets periodic trends, specifically how the across-period and down-group components of electronegativity combine when they oppose each other. Electronegativity rises left-to-right across a period and falls top-to-bottom down a group. Oxygen sits in period 2 and chlorine one period lower and one group to the right, so the two trends conflict. The dominant factor is the proximity of the bonding electrons to the nucleus: oxygen's valence shell (n = 2) lies much closer to its nucleus than chlorine's (n = 3), giving the oxygen nucleus a stronger grip on shared electrons. The smaller radius wins, so oxygen (Pauling \\(\\approx 3.44\\)) exceeds chlorine (Pauling \\(\\approx 3.16\\)), making D correct. (Choice A) A larger total nuclear charge does not by itself determine electronegativity, because added inner electrons shield the valence shell; the effective nuclear charge felt by the bonding electrons together with their distance, not the raw \\(Z = 17\\), sets the trend. (Choice B) The across-period increase does not universally dominate the down-group decrease; here the upward (smaller-period) advantage of oxygen overrides chlorine's rightward position, so the rule stated is false. (Choice C) The two influences do not cancel to equality; measured values place oxygen distinctly above chlorine, so no offsetting balance occurs. Skill 1.$ex20$,
    'medium', '4E', $cc20$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc20$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar20A$equating raw nuclear charge Z with electronegativity while ignoring shielding and distance$ar20A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $ar20B$overgeneralizing the across-period trend as always dominant over the down-group trend$ar20B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar20C$assuming opposing periodic trends cancel exactly to give equal electronegativity$ar20C$ FROM q;

-- Q21 [Periodic Trends · medium · Skill 1 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s21$Periodic Trends$s21$,
    $qt21$Moving from \(\text{Na}\) to \(\text{Mg}\), one proton is added to the nucleus while the added electron enters the same \(3s\) subshell as the existing valence electron. Within Slater's framework, electrons in the same subshell shield one another only partially. This constraint accounts for the rise in effective nuclear charge felt by a \(3s\) electron across this step because$qt21$,
    $op21$[{"label": "A", "text": "the added \\(3s\\) electron contributes only a fraction of a unit to \\(S\\), so the full +1 increase in \\(Z\\) outweighs the small gain in shielding."}, {"label": "B", "text": "the added \\(3s\\) electron contributes a full unit to \\(S\\), exactly canceling the +1 increase in \\(Z\\) so that \\(Z_\\text{eff}\\) stays fixed."}, {"label": "C", "text": "the inner-shell electrons increase their shielding contribution as \\(Z\\) rises, lowering \\(Z_\\text{eff}\\) despite the added proton."}, {"label": "D", "text": "the added proton raises \\(Z\\) while same-subshell electrons provide zero shielding, so \\(Z_\\text{eff}\\) increases by the full added proton plus the lost shielding."}]$op21$::jsonb,
    'A',
    $ex21$This item tests periodic-trend reasoning through the shielding model behind \(Z_\text{eff} = Z - S\). Across a period, each step adds one proton (\(Z\) rises by 1) and one electron to the same valence shell. Because electrons in the same subshell shield one another only partially (Slater assigns roughly 0.35 per same-shell electron, less than 1), the increase in the shielding constant \(S\) is smaller than the +1 increase in \(Z\). The net effect is a rise in \(Z_\text{eff}\) for the valence electron, which is the mechanism behind the leftward-to-rightward contraction and rising ionization energy across a period. Choice A correctly states that the same-subshell electron adds only a fraction to \(S\), so \(Z\) outpaces \(S\) and \(Z_\text{eff}\) climbs.

(Choice B) A same-subshell electron does not contribute a full unit to \(S\); partial shielding means \(S\) rises by less than 1, so \(Z_\text{eff}\) does not stay fixed but increases across the period.

(Choice C) Core electrons shield nearly completely and their per-electron contribution to \(S\) does not grow as \(Z\) increases; the trend is a rise in \(Z_\text{eff}\), not a decrease, so the stated direction is reversed.

(Choice D) Same-subshell electrons provide partial, not zero, shielding; treating them as non-shielding and adding "lost shielding" to the proton overstates the increase, conflating the added proton's effect with a shielding contribution that does not vanish.

Skill 1$ex21$,
    'medium', '4E', $cc21$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc21$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $ar21B$treating same-subshell shielding as a full unit (S+1), canceling the proton$ar21B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $ar21C$claiming Zeff decreases across a period via growing core shielding$ar21C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $ar21D$correct that Z rises but wrongly assigning zero same-subshell shielding and double-counting$ar21D$ FROM q;

-- Q22 [Periodic Trends · hard · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s22$Periodic Trends$s22$,
    $qt22$A chemist measures the energy needed to strip electrons one at a time from a gaseous sodium atom and finds that the second ionization energy is nearly ten times the first, a jump far steeper than the gradual rise seen between most successive ionizations of heavier atoms. Which feature of the sodium atom best accounts for this single dramatic jump between the first and second ionizations?$qt22$,
    $op22$[{"label": "A", "text": "The first electron leaves a half-filled \\(3s\\) subshell whose lost exchange stabilization makes the remaining electron unusually easy to remove, lowering \\(IE_1\\) relative to \\(IE_2\\)."}, {"label": "B", "text": "Removing the first electron increases the nuclear charge felt by every remaining electron, so each successive ionization energy roughly doubles in the same smooth way."}, {"label": "C", "text": "The first electron comes from the lone \\(3s^1\\) valence level, but the second must be drawn out of the closed \\(n = 2\\) shell of the \\(\\text{[Ne]}\\)-like core, where electrons lie much closer to the nucleus and feel a far larger \\(Z_\\text{eff}\\)."}, {"label": "D", "text": "The second electron is removed from a \\(3p\\) orbital that is higher in energy than the \\(3s\\), and crossing from one subshell to the next within \\(n = 3\\) requires a large energy input."}]$op22$::jsonb,
    'C',
    $ex22$This question targets successive ionization energies and how a large jump signals a transition from valence to core electrons. Neutral sodium is \(\text{[Ne]}3s^1\). The first ionization removes the single \(3s^1\) valence electron, which is well shielded by the \(n = 1\) and \(n = 2\) electrons and feels a relatively small effective nuclear charge, so \(IE_1\) is low. The resulting \(\text{Na}^+\) ion has the closed, noble-gas \(\text{[Ne]}\) configuration. The second ionization must pull an electron out of that \(n = 2\) core, where the electrons sit much closer to the nucleus, are shielded far less, and experience a dramatically higher \(Z_\text{eff}\). Breaking into a stable closed-shell core is energetically very costly, which is exactly why \(IE_2\) is roughly an order of magnitude greater than \(IE_1\). (Choice A) The \(3s^1\) configuration is a single electron, not a half-filled subshell, and exchange stabilization applies to electrons of parallel spin within a partly filled subshell; it does not explain a tenfold jump tied to reaching the core. (Choice B) Successive ionization energies of a given atom do rise because each removal leaves a more positive ion with higher \(Z_\text{eff}\), but that effect is gradual; it cannot account for the abrupt single jump, which specifically marks the valence-to-core boundary rather than a uniform doubling. (Choice C is correct.) (Choice D) Once the \(3s^1\) electron is gone, \(\text{Na}^+\) has no \(3p\) electron to remove; the next electron necessarily comes from the \(n = 2\) shell, so the jump reflects entering the core, not moving from \(3s\) to \(3p\) within \(n = 3\). Skill 2$ex22$,
    'hard', '4E', $cc22$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc22$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar22A$Misreads \(3s^1\) as a half-filled subshell and invokes exchange/half-filled stability that does not apply$ar22A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $ar22B$Correctly notes successive IEs rise with increasing \(Z_\text{eff}\) but wrongly treats the rise as smooth/uniform, missing the core-shell discontinuity$ar22B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $ar22D$Confuses the electron-removal sequence, placing the second removal in a \(3p\) subshell that is not occupied in \(\text{Na}^+\)$ar22D$ FROM q;

-- Q23 [Periodic Trends · hard · Skill 1 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s23$Periodic Trends$s23$,
    $qt23$Across period 3, the trend toward weaker metallic character is conventionally attributed to the rising effective nuclear charge pulling valence electrons more tightly. For the pair silicon \(\left(\text{Si}, Z=14\right)\) and lead \(\left(\text{Pb}, Z=82\right)\) within group 14, lead is considerably more metallic despite carrying a far larger nuclear charge. Which factor most directly accounts for lead's greater metallic character?$qt23$,
    $op23$[{"label": "A", "text": "Lead's valence electrons experience a larger effective nuclear charge, which loosens their hold on the lattice"}, {"label": "B", "text": "Lead has more valence electrons available to delocalize, raising its metallic character above that of silicon"}, {"label": "C", "text": "Lead's higher first ionization energy makes electron removal easier, favoring metallic bonding"}, {"label": "D", "text": "Lead's valence electrons occupy a higher principal energy level farther from the nucleus, so they are held less tightly and more readily delocalized despite the greater nuclear charge"}]$op23$::jsonb,
    'D',
    $ex23$This item tests the periodic trend in metallic character, specifically why metallic character increases down a group even as nuclear charge rises sharply. Metallic character reflects how readily an atom loses or delocalizes its valence electrons. Moving down group 14 from Si to Pb, each step adds a principal energy level (higher n), placing the valence electrons progressively farther from the nucleus and behind additional filled inner shells. The increased distance and intervening core-electron shielding cause the net attraction felt by the valence electrons to drop, so they are lost or delocalized more easily, lowering ionization energy and raising metallic character. The added nuclear charge is largely cancelled by the added core shielding, so distance and shielding dominate the outcome (Choice D).\n(Choice A) Effective nuclear charge stays roughly constant down a group because added protons are offset by added shielding; a larger \(Z_\text{eff}\) would tighten the hold on valence electrons and decrease metallic character, the opposite of the observed trend.\n(Choice B) Both Si and Pb are group 14 elements with four valence electrons, so the count of delocalizable valence electrons is identical; the difference in metallic character is not driven by electron number.\n(Choice C) Lead actually has a lower first ionization energy than silicon, and a higher ionization energy would make electron removal harder, which would weaken rather than favor metallic bonding.\nSkill 1$ex23$,
    'hard', '4E', $cc23$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc23$, 'general-chemistry', 1, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $ar23A$Claims rising effective nuclear charge loosens valence electrons, inverting the actual Z_eff-to-attraction relationship$ar23A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $ar23B$Attributes the trend to a difference in valence electron count, ignoring that both elements are group 14$ar23B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $ar23C$Asserts a higher ionization energy eases electron removal and favors metallic bonding, reversing the IE-metallicity link$ar23C$ FROM q;

-- Q24 [Periodic Trends · hard · Skill 4 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s24$Periodic Trends$s24$,
    $qt24$A study guide lists experimentally measured atomic radii for four representative elements, each pulled from a different group or period of the periodic table:

| Element | Atomic radius (pm) |
|---------|--------------------|
| Carbon (C) | 77 |
| Chlorine (Cl) | 99 |
| Calcium (Ca) | 197 |
| Potassium (K) | 227 |

A student preparing for an exam wants to confirm that these tabulated values are consistent with the standard periodic trend before relying on the table. Working only from each element's position on the periodic table, which element should the student predict to have the largest atomic radius?$qt24$,
    $op24$[{"label": "A", "text": "Carbon, because as the element with the fewest electrons it has the least electron-electron repulsion crowding its valence shell"}, {"label": "B", "text": "Chlorine, because its high effective nuclear charge pulls electrons into a larger, more diffuse outer shell"}, {"label": "C", "text": "Calcium, because it sits in period 4 and the addition of a filled outer shell makes it larger than any element in an earlier period"}, {"label": "D", "text": "Potassium, because it lies farthest down and to the left, the region of lowest effective nuclear charge and highest principal quantum number"}]$op24$::jsonb,
    'D',
    $ex24$Content category: periodic trends in atomic radius as a function of position (principal quantum number down a group, effective nuclear charge across a period). Atomic radius increases down a group, because each new period adds a valence shell with a higher principal quantum number \(n\) that lies farther from the nucleus, and decreases left-to-right across a period, because protons are added while electrons enter the same shell, raising the effective nuclear charge \(Z_{eff}\) and contracting the shell. The element with the largest radius therefore occupies the lower-left region of the table. Among the four listed, potassium (period 4, group 1) is both the lowest period present and the farthest left; it has the largest \(n\) for its valence electron and the lowest \(Z_{eff}\) of the group, so it should have the largest radius. The table confirms this: \(227 > 197 > 99 > 77\) pm, with potassium at \(227\) pm. (Choice A) Electron count alone does not set size; carbon (period 2) has a small \(n=2\) valence shell held tightly by a relatively high \(Z_{eff}\), giving it the smallest radius (77 pm), the opposite of largest. (Choice B) Chlorine's higher effective nuclear charge across period 3 contracts its electron cloud rather than expanding it; high \(Z_{eff}\) produces a smaller radius (99 pm), so the stated cause-and-effect is reversed. (Choice C) Calcium does lie in period 4, but radius also depends on horizontal position: calcium (group 2) sits one column right of potassium, giving it a higher \(Z_{eff}\) and a smaller radius (197 pm versus 227 pm), so it is not the largest. Skill 4$ex24$,
    'hard', '4E', $cc24$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc24$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar24A$fewer electrons means more room / least repulsion implies largest atom$ar24A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $ar24B$treats high effective nuclear charge as expanding rather than contracting the radius$ar24B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $ar24C$applies down-a-group correctly but ignores the across-a-period contraction that makes K larger than Ca$ar24C$ FROM q;

-- Q25 [Periodic Trends · medium · Skill 2 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s25$Periodic Trends$s25$,
    $qt25$Neon and sodium occupy adjacent positions in the same period, yet neon's first ionization energy is roughly four times larger than sodium's. Holding period constant, which factor most directly accounts for neon being so much harder to ionize than its right-hand neighbor sodium?$qt25$,
    $op25$[{"label": "A", "text": "Neon's smaller atomic radius lets its valence electrons pair off, and electron pairing alone stabilizes the atom against losing an electron."}, {"label": "B", "text": "Neon's outermost electron sits in a filled \\(n=2\\) shell where it feels a higher \\(Z_\\text{eff}\\), whereas sodium's removed electron is a lone \\(3s^1\\) electron screened into a new shell."}, {"label": "C", "text": "Removing an electron from neon would expose its filled \\(2p^6\\) subshell, and emptying a subshell releases energy that opposes ionization."}, {"label": "D", "text": "Neon holds more protons than sodium, so its greater nuclear charge binds the valence electrons more tightly than sodium's does."}]$op25$::jsonb,
    'B',
    $ex25$This item targets periodic trends in first ionization energy, specifically how electron configuration and effective nuclear charge govern how tightly a valence electron is held. The hinge is that neon and sodium sit at a period boundary: neon (\\(1s^2 2s^2 2p^6\\)) loses an electron from a completed \\(n=2\\) shell, where that electron experiences a high \\(Z_\\text{eff} = Z - S\\) and lies close to the nucleus, while sodium (\\([\\text{Ne}]3s^1\\)) loses a single \\(3s^1\\) electron that occupies a new, more distant shell and is heavily screened by the underlying neon core. The combination of a filled, low-lying shell and high \\(Z_\\text{eff}\\) makes neon's electron far harder to remove, which is why first ionization energy collapses sharply on crossing into the next period, making B correct.\n(Choice A) Smaller radius does correlate with higher ionization energy, but pairing of electrons does not by itself stabilize an atom against ionization; in fact, electron-electron repulsion within a paired orbital can slightly lower ionization energy, so pairing is not the operative factor here.\n(Choice C) Removing one electron from \\(2p^6\\) yields \\(2p^5\\); it does not empty the subshell, and no special energy is released by partially depleting a filled subshell. The stability of the filled configuration raises ionization energy because the electron is tightly bound, not because of an energy release upon removal.\n(Choice D) Sodium actually has one more proton than neon (\\(Z=11\\) versus \\(Z=10\\)), so a claim that neon holds more protons reverses the actual nuclear-charge relationship; the relevant quantity is \\(Z_\\text{eff}\\) felt by the removed electron, not total proton count.\nSkill 2$ex25$,
    'medium', '4E', $cc25$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc25$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar25A$Attributing ionization-energy stability to electron pairing itself rather than to shell filling and effective nuclear charge$ar25A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar25C$Misframing removal of one electron from a filled p subshell as 'emptying' it and invoking a nonexistent energy release$ar25C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $ar25D$Reversing which neighbor has more protons, asserting neon outnumbers sodium in nuclear charge$ar25D$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch3_questions FROM questions WHERE topic='Atomic Structure' AND subtopic IN ('Electron Configurations','Periodic Trends');
SELECT COUNT(*) AS total_atomic_structure FROM questions WHERE topic='Atomic Structure';