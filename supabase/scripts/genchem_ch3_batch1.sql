-- GenChem Ch3 (Bonding & Chemical Interactions) — Batch 1 of 4: Lewis Structures & Bonding Foundations
-- 24 questions, all confidence >=4 (OpenStax Atoms First 2e; stereochemistry verified vs standard organic conventions); AAMC foundation 5B; cross-batch + cross-chapter deduped, audit clean (PASS, 0 genuine conflicts).
-- Re-runnable. Run the four batches IN ORDER (1->2->3->4) in the Supabase SQL editor.
BEGIN;
-- Batch 1 purges ALL prior rows for this chapter (including the legacy 150-question seed from migration 010) so the chapter does not double-count.
DELETE FROM questions WHERE topic = 'Bonding & Chemical Interactions';

-- Q1 [Octet Rule & Exceptions · easy · Skill 1 · general-chemistry · ans A] (g1)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Octet Rule & Exceptions',
    $qt1$A neutral carbon atom bonds only to hydrogen atoms in \(\text{CH}_4\), where each hydrogen contributes a single electron. The number of covalent bonds carbon forms is set by its need to reach a noble-gas valence configuration.$qt1$,
    $op1$[{"label":"A","text":"Four, because carbon shares one electron pair with each of four hydrogen atoms to surround itself with eight valence electrons."},{"label":"B","text":"Two, because carbon shares one electron pair with each of two hydrogen atoms to surround itself with four valence electrons."},{"label":"C","text":"Four, because each hydrogen shares an electron pair with carbon to surround itself with eight valence electrons."},{"label":"D","text":"Eight, because carbon forms one covalent bond for each of the eight valence electrons it must acquire."}]$op1$::jsonb,
    'A',
    $ex1$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is A because a neutral carbon atom has four valence electrons and must share four additional electrons by forming four covalent bonds, one shared pair with each of four hydrogen atoms, to reach the eight-electron (noble-gas) configuration. In a covalent bond each shared pair counts toward the octet of the central atom, so four C-H bonds give carbon a total of eight valence electrons (its own four plus a share in four bonding pairs), satisfying the octet rule that drives covalent bond formation; the small hydrogen atoms each reach a two-electron (helium) configuration rather than an octet. (Choice B) Carbon has four valence electrons and needs four more, not two, to complete an octet, so it forms four bonds and ends with eight valence electrons rather than four. (Choice C) The number of bonds is correct, but the octet rule applies to carbon here; hydrogen attains a filled first shell of only two electrons (a helium configuration), not an octet. (Choice D) The octet rule is satisfied by sharing four electron pairs, not by forming eight separate bonds; carbon already owns four valence electrons and needs to share only four more to reach eight. Skill 1$ex1$,
    'easy', '5B', $cc1$Nature of molecules and intermolecular interactions$cc1$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a1B$Miscounts how many electrons carbon must gain, treating four valence electrons as the target instead of eight$a1B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a1C$Assigns the octet target to the wrong atom, claiming hydrogen seeks eight electrons rather than two$a1C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a1D$Confuses the total octet count with the number of bonds, equating eight needed electrons with eight bonds$a1D$ FROM q;

-- Q2 [Octet Rule & Exceptions · easy · Skill 1 · general-chemistry · ans B] (g2)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Octet Rule & Exceptions',
    $qt2$In the trigonal planar molecule \(\text{BF}_3\), the central boron atom forms three single \(\text{B}-\text{F}\) bonds and holds no lone pairs. How many valence electrons surround boron in this structure?$qt2$,
    $op2$[{"label":"A","text":"\\(2\\) valence electrons"},{"label":"B","text":"\\(6\\) valence electrons"},{"label":"C","text":"\\(8\\) valence electrons"},{"label":"D","text":"\\(10\\) valence electrons"}]$op2$::jsonb,
    'B',
    $ex2$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is B because the three \(\text{B}-\text{F}\) single bonds contribute \(3 \times 2 = 6\) shared electrons around boron, with no lone pairs to add. Boron is an electron-deficient central atom: with only three valence electrons of its own, it forms only three bonds and is stabilized with an incomplete octet of \(6\) electrons rather than \(8\), making \(\text{BF}_3\) a classic exception to the octet rule (and a Lewis acid, since the empty orbital can accept an electron pair). (Choice A) \(2\) electrons would surround boron only if it formed a single bond, but \(\text{BF}_3\) contains three \(\text{B}-\text{F}\) bonds, each contributing a shared pair. (Choice C) \(8\) electrons assumes boron satisfies a complete octet, but boron is electron-deficient and cannot reach \(8\) without exceeding the electrons available, leaving it at \(6\). (Choice D) \(10\) electrons describes an expanded octet, which is unavailable to boron because it is a period-2 element lacking accessible \(d\) orbitals; expanded octets require period-3 or higher central atoms. Skill 1$ex2$,
    'easy', '5B', $cc2$Nature of molecules and intermolecular interactions$cc2$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'scale_unit_error', $a2A$counts electrons from a single bond rather than all three B-F bonds$a2A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a2C$assumes boron completes a full octet of eight$a2C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a2D$applies expanded-octet exception to a period-2 atom$a2D$ FROM q;

-- Q3 [Octet Rule & Exceptions · medium · Skill 2 · general-chemistry · ans C] (g3)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Octet Rule & Exceptions',
    $qt3$In \(\text{SF}_6\), the central sulfur is bonded to six fluorine atoms with no lone pairs on sulfur. How many electrons surround the central sulfur, and what allows this arrangement?$qt3$,
    $op3$[{"label":"A","text":"Eight electrons, because every neutral covalent compound must satisfy a strict octet on its central atom."},{"label":"B","text":"Ten electrons, because fluorine forces sulfur to share exactly one extra pair beyond the octet."},{"label":"C","text":"Twelve electrons, because sulfur is a period-3 element and can accommodate more than eight valence electrons."},{"label":"D","text":"Twelve electrons, because sulfur has fewer valence electrons than the octet requires and must borrow pairs from fluorine."}]$op3$::jsonb,
    'C',
    $ex3$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is C because the six \(\text{S-F}\) bonding pairs place \(6 \times 2 = 12\) electrons around sulfur, a hypervalent (expanded-octet) arrangement permitted because sulfur lies in period 3. Elements in the third period and beyond can act as central atoms that exceed an octet, so sulfur in \(\text{SF}_6\) holds twelve electrons rather than the eight predicted by the strict octet rule. (Choice A) An octet on the central atom is not a strict requirement; expanded-octet species such as \(\text{SF}_6\), \(\text{PCl}_5\), and \(\text{XeF}_4\) are well-established exceptions, so eight electrons is incorrect here. (Choice B) Six \(\text{S-F}\) single bonds account for twelve electrons, not ten, so this undercounts the bonding pairs around sulfur. (Choice D) The electron count of twelve is correct, but the rationale is reversed: the expansion is enabled by sulfur being a period-3 element that can exceed an octet, not by sulfur having a deficiency of valence electrons that requires borrowing pairs. Skill 2$ex3$,
    'medium', '5B', $cc3$Nature of molecules and intermolecular interactions$cc3$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a3A$Belief that the octet rule is inviolable for every central atom, ignoring expanded-octet exceptions$a3A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a3B$Miscounting bonding pairs (treating only one bond as 'extra') to arrive at ten electrons$a3B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a3D$Correct electron count paired with an inverted rationale attributing expansion to a valence-electron deficiency rather than period-3 capacity$a3D$ FROM q;

-- Q4 [Octet Rule & Exceptions · medium · Skill 2 · general-chemistry · ans D] (g4)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Octet Rule & Exceptions',
    $qt4$Nitric oxide, \(\text{NO}\), is assembled from one nitrogen atom and one oxygen atom. Working from its actual total valence-electron count, this molecule most likely cannot satisfy which structural requirement?$qt4$,
    $op4$[{"label":"A","text":"Both atoms can share enough electrons to give every atom a full octet."},{"label":"B","text":"The \\(\\text{N}\\) atom can expand its valence shell to hold ten electrons."},{"label":"C","text":"The \\(\\text{O}\\) atom can complete an octet while \\(\\text{N}\\) stays electron-deficient."},{"label":"D","text":"Every electron can be paired so that no unpaired electron remains."}]$op4$::jsonb,
    'D',
    $ex4$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is D because \(\text{NO}\) has \(5 + 6 = 11\) valence electrons, an odd total, so the electrons cannot all be paired and one unpaired electron necessarily remains. Nitrogen (group 15) contributes 5 valence electrons and oxygen (group 16) contributes 6, giving 11; because every bonding pair and every lone pair holds two electrons, an odd grand total mathematically guarantees that one electron is left unpaired regardless of how the bonds and lone pairs are arranged, which is what makes \(\text{NO}\) a stable odd-electron radical that violates the octet rule. (Choice A) Giving every atom a full octet would require an even number of shared and unshared electrons summing to 8 on each atom, but 11 valence electrons cannot be distributed to complete octets on both atoms; the lowest-formal-charge structure (\(\text{N=O}\) with the odd electron on \(\text{N}\)) leaves nitrogen with only 7 electrons. (Choice B) Expanding the nitrogen shell to ten electrons is impossible because a second-period atom has no energetically accessible d orbitals and only four valence orbitals (one \(2s\) and three \(2p\)), capping it at eight electrons; the relevant exception here is the odd electron count, not hypervalency. (Choice C) Oxygen completing an octet while nitrogen stays electron-deficient is exactly what the accepted Lewis structure shows, so this requirement is satisfiable rather than impossible. Skill 2$ex4$,
    'medium', '5B', $cc4$Nature of molecules and intermolecular interactions$cc4$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a4A$assumes both atoms can reach full octets, ignoring that an odd valence-electron total forbids it$a4A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a4B$invokes valence-shell expansion (a different octet exception) for a second-period atom that has no d orbitals$a4B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a4C$labels the satisfiable outcome (O octet, N deficient) as the impossible requirement, inverting which condition actually fails$a4C$ FROM q;

-- Q5 [Octet Rule & Exceptions · easy · Skill 1 · general-chemistry · ans A] (g5)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Octet Rule & Exceptions',
    $qt5$In the molecule \(\text{HF}\), the single covalent bond gives a stable electron configuration to each atom. How many electrons surround the hydrogen atom once that bond is formed, and what filled shell does this number satisfy?$qt5$,
    $op5$[{"label":"A","text":"\\(2\\) electrons, satisfying a filled first shell (the duet of \\(\\text{He}\\))"},{"label":"B","text":"\\(8\\) electrons, satisfying a full octet like the other second-period atoms"},{"label":"C","text":"\\(6\\) electrons, leaving hydrogen two short of a complete octet"},{"label":"D","text":"\\(2\\) electrons, satisfying a filled second shell shared from fluorine"}]$op5$::jsonb,
    'A',
    $ex5$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is A because hydrogen has only the \(1s\) orbital available, so a single shared pair gives it two electrons, which fills its first shell to match the noble-gas configuration of helium. Hydrogen is the principal exception to the octet rule: because the \(n=1\) shell holds a maximum of two electrons, a "filled shell" for hydrogen is a duet rather than an octet, and one covalent bond in \(\text{HF}\) supplies exactly that pair. (Choice B) Hydrogen cannot accommodate eight electrons because it lacks the additional orbitals of the second shell that second-period atoms such as fluorine use to reach an octet. (Choice C) A single bond places two electrons around hydrogen, not six, and hydrogen is not short of anything once its first shell holds two electrons. (Choice D) The pair shared in \(\text{HF}\) populates hydrogen's own first shell (the \(1s\)), not a second shell, so the stable configuration is the helium duet rather than a filled \(n=2\) shell. Skill 1$ex5$,
    'easy', '5B', $cc5$Nature of molecules and intermolecular interactions$cc5$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a5B$Applying the octet rule universally and assuming hydrogen also needs eight electrons$a5B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a5C$Miscounting shared electrons and treating hydrogen as octet-deficient$a5C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a5D$Correct electron count (2) but attributing it to a filled second shell rather than hydrogen's own first shell$a5D$ FROM q;

-- Q6 [Octet Rule & Exceptions · medium · Skill 2 · general-chemistry · ans B] (g6)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Octet Rule & Exceptions',
    $qt6$Among the neutral molecules \(\text{PCl}_5\), \(\text{NF}_3\), \(\text{CO}_2\), and \(\text{H}_2\text{O}\), exactly one places more than eight electrons around its central atom. Which molecule does so, and what feature of its central atom permits it?$qt6$,
    $op6$[{"label":"A","text":"\\(\\text{NF}_3\\), because nitrogen forms three bonds plus a lone pair and the extra fluorines crowd ten electrons onto \\(\\text{N}\\)."},{"label":"B","text":"\\(\\text{PCl}_5\\), because phosphorus is a period-3 element with energetically accessible \\(3d\\)-level space, letting it hold ten bonding electrons across five \\(\\text{P}-\\text{Cl}\\) bonds."},{"label":"C","text":"\\(\\text{CO}_2\\), because the two \\(\\text{C}=\\text{O}\\) double bonds give carbon four shared pairs, which counts as ten electrons around \\(\\text{C}\\)."},{"label":"D","text":"\\(\\text{H}_2\\text{O}\\), because the two bonding pairs together with two lone pairs surround oxygen with more than eight electrons."}]$op6$::jsonb,
    'B',
    $ex6$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is B because phosphorus in \(\text{PCl}_5\) forms five \(\text{P}-\text{Cl}\) single bonds, surrounding \(\text{P}\) with ten bonding electrons, and as a period-3 element it can accommodate an expanded valence shell beyond the octet. Octet expansion is restricted to central atoms in period 3 or below (P, S, Si, Cl, etc.), where the valence shell can hold more than eight electrons; period-2 atoms such as N, C, and O are limited to eight because they lack accessible shell space. Counting electrons confirms only \(\text{PCl}_5\) exceeds eight: \(\text{NF}_3\) gives \(\text{N}\) three bonding pairs plus one lone pair (eight electrons), \(\text{CO}_2\) gives \(\text{C}\) two double bonds (four shared pairs, eight electrons), and \(\text{H}_2\text{O}\) gives \(\text{O}\) two bonding pairs plus two lone pairs (eight electrons). (Choice A) In \(\text{NF}_3\) nitrogen has exactly three bonds and one lone pair for eight electrons; as a period-2 element it cannot expand its octet regardless of how many fluorines surround it, so it does not hold ten electrons. (Choice C) The two \(\text{C}=\text{O}\) bonds in \(\text{CO}_2\) place four shared pairs around carbon, but four pairs is eight electrons, not ten, so carbon satisfies the octet exactly rather than exceeding it. (Choice D) In \(\text{H}_2\text{O}\) oxygen carries two bonding pairs and two lone pairs, which totals exactly eight electrons; this is a completed octet, not an expanded one. Skill 2$ex6$,
    'medium', '5B', $cc6$Nature of molecules and intermolecular interactions$cc6$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a6A$assumes a period-2 atom (N) can expand its octet when surrounded by more electronegative atoms$a6A$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a6C$miscounts four shared electron pairs as ten electrons instead of eight$a6C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a6D$correctly tallies oxygen's bonding and lone pairs but labels a completed octet as an expanded one$a6D$ FROM q;

-- Q7 [Octet Rule & Exceptions · hard · Skill 2 · general-chemistry · ans C] (g7)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Octet Rule & Exceptions',
    $qt7$In \(\text{XeF}_4\), the four \(\text{Xe}-\text{F}\) bonds are single bonds and every \(\text{F}\) atom completes its octet with three lone pairs. After this assignment, the leftover valence electrons reside entirely on the central \(\text{Xe}\) atom.$qt7$,
    $op7$[{"label":"A","text":"Each \\(\\text{F}\\) atom is left short of a full octet, so the leftover electrons must be promoted into a \\(\\text{Xe}=\\text{F}\\) double bond."},{"label":"B","text":"No electrons remain after the bonds and \\(\\text{F}\\) lone pairs are placed, so \\(\\text{Xe}\\) ends up with a precise octet of 8 electrons."},{"label":"C","text":"Two lone pairs remain and sit on \\(\\text{Xe}\\), giving it 12 electrons and forcing an expanded octet on the central atom."},{"label":"D","text":"One lone pair remains on \\(\\text{Xe}\\), giving it 10 electrons in an expanded octet."}]$op7$::jsonb,
    'C',
    $ex7$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is C because the 36 total valence electrons leave two lone pairs on \(\text{Xe}\) after the four bonds and the fluorine octets are satisfied, so \(\text{Xe}\) holds 12 electrons. Counting: \(\text{Xe}\) contributes 8 valence electrons and four \(\text{F}\) atoms contribute \(4 \times 7 = 28\), for \(36\) electrons (18 pairs); the four \(\text{Xe}-\text{F}\) single bonds use 4 pairs, and completing each \(\text{F}\) octet uses \(4 \times 3 = 12\) pairs, accounting for 16 pairs (32 electrons); the remaining 2 pairs (4 electrons) have nowhere to go but \(\text{Xe}\), which then carries 4 bonding pairs plus 2 lone pairs, i.e. 12 electrons, an expanded octet that period-5 \(\text{Xe}\) can accommodate. (Choice A) The fluorine atoms are already octet-complete with three lone pairs apiece, so no \(\text{Xe}=\text{F}\) double bond is needed and the leftover electrons are not absorbed by the terminal atoms. (Choice B) This assumes all electrons are consumed by the bonds and the \(\text{F}\) lone pairs, ignoring that 4 electrons remain and must localize on \(\text{Xe}\), so \(\text{Xe}\) cannot end at a plain octet. (Choice D) This undercounts the leftover by one pair; \(36 - 32 = 4\) electrons remain, which is two lone pairs (12 electrons on \(\text{Xe}\)), not one lone pair (10 electrons). Skill 2$ex7$,
    'hard', '5B', $cc7$Nature of molecules and intermolecular interactions$cc7$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a7A$Forcing a double bond to a halogen to avoid an expanded octet, even though terminal F is already octet-satisfied$a7A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a7B$Insisting the central atom obeys a strict octet and ignoring leftover non-bonding electrons$a7B$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a7D$Miscounting leftover electrons as one lone pair (10 e-) instead of two lone pairs (12 e-)$a7D$ FROM q;

-- Q8 [Octet Rule & Exceptions · hard · Skill 2 · general-chemistry · ans D] (g8)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Octet Rule & Exceptions',
    $qt8$In gas-phase \(\text{BeH}_2\) (connectivity H-Be-H), the central beryllium completes two \(\text{Be-H}\) single bonds. Constrained by the terminal atoms being only hydrogen, beryllium most likely remains electron-deficient because$qt8$,
    $op8$[{"label":"A","text":"each \\(\\text{Be-H}\\) bond is a polar covalent bond, and the resulting partial positive charge on \\(\\text{Be}\\) removes electron density until fewer than eight electrons surround it."},{"label":"B","text":"beryllium uses only its two valence electrons for bonding and cannot form the additional two bonds that an octet would require around the central atom."},{"label":"C","text":"hydrogen is satisfied by a duet, so each \\(\\text{Be-H}\\) bonding pair counts toward hydrogen's shell but not toward the electron count around beryllium."},{"label":"D","text":"the two terminal hydrogens carry no lone pairs to donate and contribute only their bonding pairs, leaving beryllium surrounded by just two bonding pairs, or four electrons."}]$op8$::jsonb,
    'D',
    $ex8$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is D because the only electrons that can surround beryllium are those in its two \(\text{Be-H}\) bonding pairs, and since hydrogen has no lone pairs to add and beryllium itself has none, that totals just four electrons. Beryllium contributes its two valence electrons and each hydrogen contributes one, giving two shared pairs; counting all four electrons in those two bonds, beryllium is surrounded by four electrons rather than eight, which is the defining feature of an electron-deficient central atom. With both terminal positions occupied by hydrogen, there is no terminal lone pair that could shift onto beryllium (as a resonance double bond) and no fifth or sixth electron available, so the duet-satisfied hydrogens leave the octet around beryllium permanently unmet. (Choice A) Bond polarity redistributes electron density within each \(\text{Be-H}\) bond, but the electron count used to assess the octet tallies whole shared pairs regardless of polarity; the deficiency arises from having only two bonding pairs, not from charge separation reducing a would-be octet. (Choice B) It is true that beryllium has only two valence electrons, but a central atom is not limited to forming one bond per valence electron, since additional bonds can draw on lone pairs donated by terminal atoms; the binding constraint here is specifically that the hydrogen terminals supply no such lone pairs. (Choice C) Hydrogen is indeed satisfied by a duet, but each \(\text{Be-H}\) bonding pair is shared and is counted toward the shells of both bonded atoms; the pair does count around beryllium, and the shortfall is that there are only two such pairs, not that the pairs fail to count. Skill 2$ex8$,
    'hard', '5B', $cc8$Nature of molecules and intermolecular interactions$cc8$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a8A$attributes electron deficiency to bond polarity removing density rather than to too few bonding pairs$a8A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a8B$correctly notes beryllium's two valence electrons but wrongly claims one-bond-per-electron caps the bond count$a8B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a8C$treats a shared bonding pair as counting only toward hydrogen's duet and not toward beryllium's shell$a8C$ FROM q;

-- Q9 [Lewis Structures · easy · Skill 2 · general-chemistry · ans A] (g9)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Lewis Structures',
    $qt9$A chemist begins a Lewis structure for \(\text{CO}_2\) (connectivity O-C-O) and must first tally the electrons available for the structure. How many valence electrons does \(\text{CO}_2\) contribute in total?$qt9$,
    $op9$[{"label":"A","text":"\\(16\\) valence electrons"},{"label":"B","text":"\\(22\\) valence electrons"},{"label":"C","text":"\\(20\\) valence electrons"},{"label":"D","text":"\\(12\\) valence electrons"}]$op9$::jsonb,
    'A',
    $ex9$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is A because carbon (group 14) supplies \(4\) valence electrons and each oxygen (group 16) supplies \(6\), giving \(4 + 2(6) = 16\). For a neutral molecule, the valence-electron pool for a Lewis structure is the sum of each atom's group-number valence electrons; in \(\text{CO}_2\) that is \(4\) from \(\text{C}\) plus \(6\) from each of the two \(\text{O}\) atoms, totaling \(16\) electrons (8 pairs) to distribute as bonds and lone pairs. (Choice B) \(22\) is the count of all electrons in the molecule (carbon's \(6\) plus \(8\) from each oxygen, \(6 + 16 = 22\)), but a Lewis structure uses only valence electrons, not the full electron inventory. (Choice C) \(20\) results from assigning each oxygen \(8\) electrons as if its filled octet were its valence contribution (\(4 + 8 + 8\)); the valence contribution is the group number of \(6\), not the octet of \(8\). (Choice D) \(12\) counts only the two oxygen atoms (\(2 \times 6\)) and omits carbon's \(4\) valence electrons. Skill 2$ex9$,
    'easy', '5B', $cc9$Nature of molecules and intermolecular interactions$cc9$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'adjacent_fact', $a9B$Sums total electrons (atomic numbers) instead of valence electrons$a9B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a9C$Treats each oxygen's filled octet (8) as its valence contribution$a9C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a9D$Omits the central carbon's valence electrons from the tally$a9D$ FROM q;

-- Q10 [Lewis Structures · medium · Skill 2 · general-chemistry · ans B] (g10)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Lewis Structures',
    $qt10$Before drawing a Lewis structure for the nitrate ion \(\text{NO}_3^-\), a chemist tallies the electrons the diagram must contain. What is the total number of valence electrons available for \(\text{NO}_3^-\)?$qt10$,
    $op10$[{"label":"A","text":"\\(23\\)"},{"label":"B","text":"\\(24\\)"},{"label":"C","text":"\\(22\\)"},{"label":"D","text":"\\(25\\)"}]$op10$::jsonb,
    'B',
    $ex10$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is B because nitrogen contributes \(5\), the three oxygens contribute \(3 \times 6 = 18\), and the \(-1\) charge adds \(1\) more electron, giving \(5 + 18 + 1 = 24\). When tallying valence electrons for a polyatomic ion, the electrons supplied by each atom are summed from group number (\(\text{N}\) is in group 15 with \(5\), each \(\text{O}\) is in group 16 with \(6\)), and the ionic charge is then applied to the total: each unit of negative charge represents one extra electron that must appear in the structure, while each unit of positive charge would remove one. (Choice A) \(23\) results from counting the neutral atoms (\(5 + 18\)) but neglecting to adjust for the ionic charge, so the extra electron carried by the anion is omitted. (Choice C) \(22\) results from subtracting one electron for the charge; a \(-1\) charge means an electron has been gained, not lost, so the count must increase rather than decrease. (Choice D) \(25\) results from adding two electrons rather than one, overcounting the single unit of negative charge. Skill 2$ex10$,
    'medium', '5B', $cc10$Nature of molecules and intermolecular interactions$cc10$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a10A$Sums the neutral atomic contributions but omits the charge-adjustment step$a10A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a10C$Subtracts an electron for the negative charge instead of adding one (treats an anion like a cation)$a10C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a10D$Adds two electrons instead of one, overcounting the magnitude of the -1 charge$a10D$ FROM q;

-- Q11 [Lewis Structures · easy · Skill 2 · general-chemistry · ans C] (g11)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Lewis Structures',
    $qt11$In the Lewis structure of \(\text{NH}_3\), the central nitrogen forms a single bond to each of three hydrogen atoms. How many lone pairs reside on that nitrogen atom?$qt11$,
    $op11$[{"label":"A","text":"\\(0\\) lone pairs"},{"label":"B","text":"\\(2\\) lone pairs"},{"label":"C","text":"\\(1\\) lone pair"},{"label":"D","text":"\\(3\\) lone pairs"}]$op11$::jsonb,
    'C',
    $ex11$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is C because nitrogen contributes \(5\) valence electrons, three of which are committed to the three \(\text{N}-\text{H}\) bonding pairs, leaving exactly one nonbonding pair on \(\text{N}\). Counting from the Lewis structure, the three single bonds account for \(3\) of nitrogen's electrons, and the remaining \(5-3=2\) electrons pair up as a single lone pair, which is why \(\text{NH}_3\) is trigonal pyramidal rather than trigonal planar. (Choice A) Assigning \(0\) lone pairs treats nitrogen as if all five valence electrons were used in bonding, as carbon's four are in \(\text{CH}_4\), but nitrogen has one more valence electron than it has bonds. (Choice B) Assigning \(2\) lone pairs corresponds to the count on the oxygen of \(\text{H}_2\text{O}\), an adjacent hydride with two bonds and two lone pairs, not to nitrogen with three bonds and one lone pair. (Choice D) Assigning \(3\) lone pairs mislabels the three bonding pairs as lone pairs; those pairs are shared with hydrogen and are not nonbonding. Skill 2$ex11$,
    'easy', '5B', $cc11$Nature of molecules and intermolecular interactions$cc11$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a11A$Treats nitrogen like carbon, placing all valence electrons into bonds and leaving no lone pair$a11A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a11B$Imports the lone-pair count of oxygen in water onto nitrogen in ammonia$a11B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a11D$Counts the three bonding pairs as lone pairs instead of nonbonding pairs$a11D$ FROM q;

-- Q12 [Lewis Structures · medium · Skill 2 · general-chemistry · ans D] (g12)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Lewis Structures',
    $qt12$In \(\text{CF}_4\), a tetrahedral molecule in which a central carbon is single-bonded to four fluorines, each terminal fluorine completes a full octet. Constrained to that octet, how many lone pairs does each terminal \(\text{F}\) carry?$qt12$,
    $op12$[{"label":"A","text":"\\(4\\) lone pairs"},{"label":"B","text":"\\(1\\) lone pair"},{"label":"C","text":"\\(2\\) lone pairs"},{"label":"D","text":"\\(3\\) lone pairs"}]$op12$::jsonb,
    'D',
    $ex12$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is D because a neutral fluorine atom brings \(7\) valence electrons, and committing one electron to a single C-F bond leaves \(6\) nonbonding electrons, which pair into \(3\) lone pairs. In \(\text{CF}_4\) each terminal \(\text{F}\) forms exactly one \(\sigma\) bond to carbon; the shared bonding pair plus the three lone pairs gives \(8\) electrons around \(\text{F}\) and satisfies the octet \((2\) bonding \(+ 6\) nonbonding\()\). The carbon, bonded to four fluorines, uses all four of its valence electrons in bonds and has no lone pairs, but the terminal fluorines retain their nonbonding electrons as three lone pairs each. (Choice A) Four lone pairs would assign all \(8\) of fluorine's surrounding electrons as nonbonding and count the C-F bonding pair a second time as a lone pair; the bonding pair is shared between C and F and cannot also be counted as a lone pair on \(\text{F}\). (Choice B) One lone pair counts only \(2\) of the \(6\) nonbonding electrons on each \(\text{F}\) and leaves the fluorine with just \(4\) electrons, which violates the octet that the constraint requires. (Choice C) Two lone pairs corresponds to a terminal atom that forms a double bond and holds \(4\) nonbonding electrons, as in a carbonyl oxygen; fluorine forms only a single bond in \(\text{CF}_4\), so it keeps \(6\) nonbonding electrons rather than \(4\). Skill 2$ex12$,
    'medium', '5B', $cc12$Nature of molecules and intermolecular interactions$cc12$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a12A$counts the shared C-F bonding pair as a fourth lone pair, assigning all eight surrounding electrons to F as nonbonding$a12A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a12B$reports only one of fluorine's three lone pairs, undercounting the nonbonding electrons and breaking the octet$a12B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a12C$applies the double-bonded terminal-atom lone-pair count (four nonbonding electrons) to a single-bonded fluorine$a12C$ FROM q;

-- Q13 [Lewis Structures · medium · Skill 2 · general-chemistry · ans A] (g13)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Lewis Structures',
    $qt13$Hydrogen peroxide \(\text{H}_2\text{O}_2\) is built from two H and two O atoms, and each H can form only one bond. Which skeletal arrangement gives the most reasonable Lewis structure?$qt13$,
    $op13$[{"label":"A","text":"\\(\\text{H}-\\text{O}-\\text{O}-\\text{H}\\), with the two O atoms bonded to each other and one H on each O"},{"label":"B","text":"\\(\\text{H}-\\text{H}-\\text{O}-\\text{O}\\), with the two H atoms bonded to each other at one end"},{"label":"C","text":"\\(\\text{O}-\\text{H}-\\text{H}-\\text{O}\\), with both H atoms bridging between the two O atoms"},{"label":"D","text":"\\(\\text{H}-\\text{O}(\\text{H})-\\text{O}\\), with both H atoms on one O and the other O terminal"}]$op13$::jsonb,
    'A',
    $ex13$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is A because hydrogen, which can form only one bond, must always occupy a terminal position, forcing the two O atoms to bond to each other with one H on each. Each H contributes a single \(1s\) electron and can hold only two electrons, so an H atom can never be a central/bridging atom or bond to another H in a stable neutral structure; the only skeleton that gives every atom an acceptable bonding count is \(\text{H}-\text{O}-\text{O}-\text{H}\), where each O has two bonds plus two lone pairs (formal charge 0) and each terminal H has one bond. (Choice B) places the two H atoms bonded to each other, but H holds only one bond and cannot serve as an interior atom linking the rest of the chain. (Choice C) makes each H a bridge between the two O atoms, which would require each H to form two bonds and exceed its one-bond, two-electron capacity. (Choice D) puts both H atoms on a single O, leaving that O with three bonds (a +1 formal-charge situation) and the other O with only one bond, a far less reasonable arrangement than the symmetric \(\text{H}-\text{O}-\text{O}-\text{H}\) skeleton. Skill 2$ex13$,
    'medium', '5B', $cc13$Nature of molecules and intermolecular interactions$cc13$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a13B$Treats hydrogen as able to occupy an interior/bridging position or bond to another H, ignoring its one-bond limit$a13B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a13C$Forces H to bridge two heavy atoms, giving hydrogen two bonds and confusing terminal placement with central placement$a13C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a13D$Keeps H bonded only to O (true) but clusters both H on one O, producing an unreasonable formal-charge/bonding distribution$a13D$ FROM q;

-- Q14 [Lewis Structures · hard · Skill 2 · general-chemistry · ans B] (g14)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Lewis Structures',
    $qt14$Hydrogen cyanide \(\text{HCN}\) (connectivity H-C-N) is drawn so that every atom satisfies the octet rule (duet for H). In this lowest-formal-charge structure, how many bonding pairs and how many lone (nonbonding) pairs are present in the whole molecule?$qt14$,
    $op14$[{"label":"A","text":"4 bonding pairs and 0 lone pairs"},{"label":"B","text":"4 bonding pairs and 1 lone pair"},{"label":"C","text":"2 bonding pairs and 2 lone pairs"},{"label":"D","text":"3 bonding pairs and 1 lone pair"}]$op14$::jsonb,
    'B',
    $ex14$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is B because the octet-satisfying structure \(\text{H}-\text{C}\equiv\text{N}:\) contains one \(\text{C}-\text{H}\) single bond plus a \(\text{C}\equiv\text{N}\) triple bond (four shared pairs total) and exactly one lone pair, which sits on nitrogen. Counting shared pairs: the \(\text{C}-\text{H}\) bond is one pair and the \(\text{C}\equiv\text{N}\) triple bond is three pairs, giving \(4\) bonding pairs; hydrogen has no lone pairs, carbon uses all four of its bonds and keeps none, and nitrogen (5 valence electrons, 3 of them in the triple bond) retains a single nonbonding pair, so the molecule has \(1\) lone pair. (Choice A) This keeps the correct count of four shared pairs but drops nitrogen's lone pair; nitrogen contributes only three electrons to the triple bond, leaving two electrons that must be placed as a lone pair to complete its octet. (Choice C) This counts the two bonded atom connections (\(\text{C}-\text{H}\) and \(\text{C}-\text{N}\)) as one pair each rather than counting all shared pairs, so it ignores that the carbon-nitrogen linkage is a triple bond worth three bonding pairs and miscounts the nonbonding pairs. (Choice D) This correctly tallies the three pairs of the triple bond and the nitrogen lone pair but omits the \(\text{C}-\text{H}\) bonding pair, undercounting the total shared pairs by one. Skill 2$ex14$,
    'hard', '5B', $cc14$Nature of molecules and intermolecular interactions$cc14$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a14A$triple-bonded nitrogen left without its lone pair$a14A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a14C$counts bonded-atom connections instead of shared electron pairs$a14C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a14D$omits the C-H bonding pair while counting the triple bond and lone pair$a14D$ FROM q;

-- Q15 [Lewis Structures · easy · Skill 1 · general-chemistry · ans C] (g15)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Lewis Structures',
    $qt15$Phosphorus trichloride, \(\text{PCl}_3\), contains one phosphorus atom and three chlorine atoms. When its Lewis structure is assembled, which atom occupies the central position?$qt15$,
    $op15$[{"label":"A","text":"A chlorine atom, because chlorine is the most electronegative atom present"},{"label":"B","text":"A chlorine atom, because chlorine is the most abundant atom and is needed in the center to bond to all others"},{"label":"C","text":"The phosphorus atom, because phosphorus is the least electronegative non-hydrogen atom present"},{"label":"D","text":"The phosphorus atom, because phosphorus is the most electronegative non-hydrogen atom present"}]$op15$::jsonb,
    'C',
    $ex15$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is C because the central atom in a Lewis structure is the least electronegative non-hydrogen atom, and phosphorus is less electronegative than chlorine. The convention places the least electronegative atom in the center because it is most willing to share its electrons with several surrounding atoms; in \(\text{PCl}_3\), the single \(\text{P}\) atom is central and each of the three \(\text{Cl}\) atoms is terminal, bonded by one \(\text{P}-\text{Cl}\) single bond. (Choice A) reverses the relationship by placing the most electronegative atom (chlorine) in the center, whereas the rule selects the least electronegative non-hydrogen atom. (Choice B) relies on abundance rather than electronegativity; the number of atoms of an element does not determine the central position, and the lone phosphorus is central despite chlorine being more numerous. (Choice D) names the correct atom but justifies it with an incorrect statement, since phosphorus is the least, not the most, electronegative non-hydrogen atom in the molecule. Skill 1$ex15$,
    'easy', '5B', $cc15$Nature of molecules and intermolecular interactions$cc15$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a15A$Selects the most electronegative atom as central, inverting the least-electronegative-is-central rule$a15A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a15B$Chooses the central atom by counting abundance rather than by electronegativity$a15B$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a15D$Identifies the correct central atom but supplies a wrong electronegativity justification$a15D$ FROM q;

-- Q16 [Lewis Structures · hard · Skill 2 · general-chemistry · ans D] (g16)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Lewis Structures',
    $qt16$A proposed Lewis structure for \(\text{SiH}_4\) places one lone pair on the silicon atom in addition to four \(\text{Si–H}\) single bonds. What is the most defensible objection to this structure?$qt16$,
    $op16$[{"label":"A","text":"It violates the octet rule because silicon is left with only six electrons in its valence shell."},{"label":"B","text":"It assigns silicon a formal charge of \\(+1\\), which is impossible for a group 14 atom."},{"label":"C","text":"It is acceptable, because silicon can expand its octet to hold ten valence electrons."},{"label":"D","text":"It shows ten valence electrons total, but \\(\\text{SiH}_4\\) has only eight, so the lone pair must be removed."}]$op16$::jsonb,
    'D',
    $ex16$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is D because \(\text{SiH}_4\) supplies only \(4 + 4(1) = 8\) valence electrons, yet four \(\text{Si–H}\) bonds (8 electrons) plus a lone pair (2 electrons) require 10, so the extra pair cannot exist and must be removed. A correct Lewis structure begins by summing the valence electrons of every atom, and any structure whose drawn electrons exceed that count is invalid regardless of how the atoms are otherwise arranged; for \(\text{SiH}_4\) the eight available electrons are exactly accounted for by four bonding pairs, leaving silicon with a complete octet and no room for a lone pair. (Choice A) The proposed structure actually gives silicon ten electrons (four bonds plus a lone pair), not six, so describing it as electron-deficient reverses the real problem of having too many electrons. (Choice B) Computing formal charge on silicon in the proposed structure gives \(\text{FC} = 4 - 2 - \tfrac{1}{2}(8) = -2\), not \(+1\), and in any case a wrong formal charge is a downstream symptom rather than the governing objection, which is the incorrect total electron count. (Choice C) Silicon does have available \(3d\) orbitals and can exceed an octet in species such as \(\text{SiF}_6^{2-}\), but octet expansion requires additional electrons supplied by extra ligands or charge, whereas neutral \(\text{SiH}_4\) furnishes only eight electrons and therefore cannot accommodate a fifth pair. Skill 2$ex16$,
    'hard', '5B', $cc16$Nature of molecules and intermolecular interactions$cc16$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a16A$Claims the structure is electron-deficient (six electrons) when it is actually electron-excessive (ten electrons), reversing the direction of the counting error.$a16A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a16B$Jumps to a formal-charge objection with an incorrectly computed value, mistaking a downstream calculation for the governing electron-count rule.$a16B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a16C$Invokes octet expansion as a blanket justification, ignoring that expansion still requires the total valence-electron count to support the extra pair.$a16C$ FROM q;

-- Q17 [Formal Charge · medium · Skill 2 · general-chemistry · ans A] (g17)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Formal Charge',
    $qt17$Carbon monoxide \(\text{CO}\) is drawn as its best (octet-satisfying) Lewis structure, with a triple bond and one lone pair on each atom. What is the formal charge on the carbon atom?$qt17$,
    $op17$[{"label":"A","text":"\\(-1\\)"},{"label":"B","text":"\\(0\\)"},{"label":"C","text":"\\(+1\\)"},{"label":"D","text":"\\(-2\\)"}]$op17$::jsonb,
    'A',
    $ex17$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is A because applying \(\text{FC} = V - (\text{nonbonding } e^-) - \tfrac{1}{2}(\text{bonding } e^-)\) to carbon gives \(4 - 2 - \tfrac{1}{2}(6) = -1\). In the octet-satisfying Lewis structure of \(\text{CO}\), carbon and oxygen are joined by a triple bond and each atom carries one lone pair; carbon's valence electron count is \(V = 4\), it holds \(2\) nonbonding electrons (its lone pair), and it shares \(6\) bonding electrons across the triple bond, so half of those (\(3\)) are assigned to carbon, leaving \(4 - 2 - 3 = -1\). (Choice B) A value of \(0\) treats carbon as if it were neutral because the overall molecule is neutral, but formal charge is computed per atom and the \(+1/-1\) charges on oxygen and carbon sum to the neutral molecule. (Choice C) A value of \(+1\) is the formal charge on the oxygen atom (\(6 - 2 - 3 = +1\)), so this reverses the assignment between the two atoms. (Choice D) A value of \(-2\) results from omitting the factor of one-half on the bonding electrons or otherwise over-assigning shared electrons to carbon during the formal-charge calculation. Skill 2$ex17$,
    'medium', '5B', $cc17$Nature of molecules and intermolecular interactions$cc17$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a17B$Assumes a neutral overall molecule forces zero formal charge on each atom$a17B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a17C$Swaps the formal charges of carbon and oxygen$a17C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a17D$Mis-executes the FC formula by mishandling the one-half factor on bonding electrons$a17D$ FROM q;

-- Q18 [Formal Charge · hard · Skill 2 · general-chemistry · ans B] (g18)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Formal Charge',
    $qt18$In the lowest-formal-charge Lewis structure of the sulfate ion \(\text{SO}_4^{2-}\), sulfur is bonded to four oxygen atoms through two \(\text{S=O}\) double bonds and two \(\text{S-O}^-\) single bonds and carries no lone pairs of its own. For this structure, the formal charge on the central sulfur atom is most likely$qt18$,
    $op18$[{"label":"A","text":"\\(-2\\)"},{"label":"B","text":"\\(0\\)"},{"label":"C","text":"\\(+2\\)"},{"label":"D","text":"\\(+6\\)"}]$op18$::jsonb,
    'B',
    $ex18$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is B because formal charge is computed as the number of valence electrons of the neutral atom minus the nonbonding (lone-pair) electrons minus one-half the bonding electrons, following the OpenStax bookkeeping procedure. Neutral sulfur has \(6\) valence electrons. In the described expanded-octet structure, sulfur has no lone pairs (\(0\) nonbonding electrons) and participates in two \(\text{S=O}\) double bonds plus two \(\text{S-O}^-\) single bonds, for a total of \(6\) bonds, i.e. \(12\) bonding electrons. Thus \(\text{FC}(\text{S}) = 6 - 0 - \tfrac{1}{2}(12) = 6 - 6 = 0\). The two single-bonded oxygens each carry a \(-1\) formal charge, accounting for the ion's overall \(2-\) charge while sulfur itself is left at zero, which is why this structure is preferred over the all-single-bond alternative. (Choice A) Assigning \(-2\) to sulfur incorrectly places the entire \(2-\) charge of the ion on the central atom; the ion's net charge is distributed over the terminal single-bonded oxygens, not localized on sulfur. (Choice C) The value \(+2\) results from evaluating only an all-single-bond structure with four \(\text{S-O}\) bonds, giving \(6 - 0 - \tfrac{1}{2}(8) = +2\); the question specifies the expanded-octet structure with two double bonds, where the two extra shared pairs lower sulfur's formal charge to zero. (Choice D) The value \(+6\) is sulfur's oxidation number in sulfate, not its formal charge; oxidation number assigns all shared electrons to the more electronegative oxygen, whereas formal charge splits each bond evenly, so the two quantities need not match. Skill 2$ex18$,
    'hard', '5B', $cc18$Nature of molecules and intermolecular interactions$cc18$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a18A$assigning the ion's overall charge to the central atom$a18A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a18C$computing formal charge from the wrong (all-single-bond) Lewis structure$a18C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a18D$confusing formal charge with oxidation number$a18D$ FROM q;

-- Q19 [Formal Charge · hard · Skill 2 · general-chemistry · ans C] (g19)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Formal Charge',
    $qt19$Consider the resonance form of the nitrite ion \(\text{NO}_2^-\) (connectivity O-N-O) in which nitrogen forms a double bond to each oxygen and carries no lone pair. What is the formal charge on the central nitrogen in this resonance form?$qt19$,
    $op19$[{"label":"A","text":"\\(-1\\)"},{"label":"B","text":"\\(0\\)"},{"label":"C","text":"\\(+1\\)"},{"label":"D","text":"\\(+2\\)"}]$op19$::jsonb,
    'C',
    $ex19$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is C because in the specified resonance form nitrogen has no lone pair and shares four bonding pairs, giving \(\text{FC} = 5 - 0 - \tfrac{1}{2}(8) = +1\). Formal charge is computed as \(\text{FC} = V - (\text{nonbonding electrons}) - \tfrac{1}{2}(\text{bonding electrons})\), where \(V = 5\) for nitrogen. In the resonance form described, nitrogen forms two \(\text{N}=\text{O}\) double bonds, so it participates in four bonding pairs (8 bonding electrons) and holds zero nonbonding electrons; substituting gives \(5 - 0 - 4 = +1\). (Choice A) A value of \(-1\) results from reversing the subtraction or from assigning nitrogen ownership of all eight bonding electrons rather than half of them, which inverts the sign of the deviation from the neutral atom. (Choice B) A value of \(0\) is the formal charge nitrogen carries in the more familiar nitrite resonance form with one single bond, one double bond, and one lone pair (\(5 - 2 - 3 = 0\)), not in the no-lone-pair, two-double-bond form specified here. (Choice D) A value of \(+2\) arises from omitting all bonding-electron credit and computing \(5 - 0 - \tfrac{1}{2}(\text{0})\) incorrectly, or from counting only the lone-pair absence twice; nitrogen still receives half of the eight shared electrons, capping the formal charge at \(+1\). Skill 2$ex19$,
    'hard', '5B', $cc19$Nature of molecules and intermolecular interactions$cc19$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a19A$sign inverted by assigning N all bonding electrons or reversing the FC subtraction$a19A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a19B$formal charge of N in the standard single-plus-double-bond resonance form rather than the specified two-double-bond form$a19B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a19D$omits the half-of-bonding-electrons credit, overcounting the positive charge$a19D$ FROM q;

-- Q20 [Formal Charge · hard · Skill 2 · general-chemistry · ans D] (g20)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Formal Charge',
    $qt20$Nitrous oxide \(\text{N}_2\text{O}\) has the connectivity N-N-O, and every contributing Lewis structure carries nonzero formal charges. The contributor that dominates the resonance hybrid keeps each formal-charge magnitude as small as possible while placing any negative formal charge on the most electronegative atom.$qt20$,
    $op20$[{"label":"A","text":"The form with a central-atom arrangement \\(:\\!\\text{N}\\!-\\!\\text{N}\\!\\equiv\\!\\text{O}\\!:\\), giving formal charges \\(-2\\) (terminal N), \\(+1\\) (central N), and \\(0\\) (O)."},{"label":"B","text":"The form \\(:\\!\\text{N}\\!\\equiv\\!\\text{N}\\!\\equiv\\!\\text{O}\\!:\\) with two N≡ bonds, giving formal charges \\(0\\), \\(+2\\), and \\(0\\)."},{"label":"C","text":"The form \\(:\\!\\text{N}\\!=\\!\\text{N}\\!=\\!\\text{O}\\!:\\), giving formal charges \\(-1\\) (terminal N), \\(+1\\) (central N), and \\(0\\) (O)."},{"label":"D","text":"The form \\(:\\!\\text{N}\\!\\equiv\\!\\text{N}\\!-\\!\\text{O}\\!:\\), giving formal charges \\(0\\) (terminal N), \\(+1\\) (central N), and \\(-1\\) (O)."}]$op20$::jsonb,
    'D',
    $ex20$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is D because that arrangement holds every formal-charge magnitude to no more than 1 while seating the \(-1\) on oxygen, the most electronegative atom. Using \(FC = V - \text{nonbonding} - \tfrac{1}{2}\,\text{bonding}\) for \(:\!\text{N}\!\equiv\!\text{N}\!-\!\text{O}\!:\): the triple-bonded terminal N has \(5-2-\tfrac{1}{2}(6)=0\); the central N has \(5-0-\tfrac{1}{2}(8)=+1\); and the singly-bonded O with three lone pairs has \(6-6-\tfrac{1}{2}(2)=-1\). Among the contributors that obey the octet rule, both this form and the cumulated-double-bond form share the smallest possible spread of magnitudes (0, +1, and -1), but the deciding criterion is that the negative charge should reside on the more electronegative atom, which is oxygen here. (Choice A) This arrangement places a \(-2\) on the terminal nitrogen, so its largest formal-charge magnitude is 2, which is worse than the \(\pm 1\) maximum achievable, making it a minor contributor. (Choice B) Two N\(\equiv\) bonds force ten electrons onto the central nitrogen, violating the octet, and assign it a \(+2\); both the octet violation and the magnitude of 2 make this form non-contributing. (Choice C) The cumulated form gives magnitudes of 0, +1, and -1 just as the keyed form does, but it locates the \(-1\) on the terminal nitrogen rather than on oxygen, so by the electronegativity criterion it is the less favorable of the two equally low-magnitude contributors. Skill 2$ex20$,
    'hard', '5B', $cc20$Nature of molecules and intermolecular interactions$cc20$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'scale_unit_error', $a20A$Selecting a structure with an unnecessarily large formal-charge magnitude (-2) by misplacing the bonding electrons$a20A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a20B$Choosing an octet-violating structure that puts +2 on a second-row atom while believing more bonds always lower charge$a20B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a20C$Picking a structure with the correct minimal magnitudes but the negative charge on the less electronegative atom$a20C$ FROM q;

-- Q21 [Formal Charge · medium · Skill 2 · general-chemistry · ans A] (g21)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Formal Charge',
    $qt21$In the ammonium ion \(\text{NH}_4^+\), the central nitrogen atom forms four equivalent single bonds to hydrogen and retains no lone pairs. Using \(\text{FC} = (\text{valence electrons}) - (\text{nonbonding electrons}) - \tfrac{1}{2}(\text{bonding electrons})\), what is the formal charge on the nitrogen atom?$qt21$,
    $op21$[{"label":"A","text":"\\(+1\\)"},{"label":"B","text":"\\(0\\)"},{"label":"C","text":"\\(-1\\)"},{"label":"D","text":"\\(+2\\)"}]$op21$::jsonb,
    'A',
    $ex21$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is A because nitrogen contributes \(5\) valence electrons, has \(0\) nonbonding electrons, and participates in four single bonds, giving \(8\) bonding electrons. Per OpenStax, formal charge equals valence electrons minus nonbonding electrons minus half the bonding electrons: \(\text{FC} = 5 - 0 - \tfrac{1}{2}(8) = 5 - 0 - 4 = +1\). The sum of formal charges over all atoms must equal the overall charge of the ion, and since each hydrogen carries \(\text{FC} = 1 - 0 - \tfrac{1}{2}(2) = 0\), nitrogen accounts for the entire \(+1\) charge of \(\text{NH}_4^+\). (Choice B) A value of \(0\) treats the nitrogen as if it were in neutral ammonia and ignores that the ion carries a net positive charge; the formal-charge sum would then be \(0\), inconsistent with the \(+1\) ion. (Choice C) A value of \(-1\) results from reversing the sign of the bonding term, computing \(5 - 0 + \tfrac{1}{2}(8)\) incorrectly or subtracting valence electrons from the shared count rather than assigning half the bonding electrons to nitrogen. (Choice D) A value of \(+2\) arises from counting only three of nitrogen's four \(\text{N}-\text{H}\) bonds (six bonding electrons): \(5 - 0 - \tfrac{1}{2}(6) = +2\), which omits one bond. Skill 2$ex21$,
    'medium', '5B', $cc21$Nature of molecules and intermolecular interactions$cc21$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a21B$ignores the ionic charge and treats nitrogen as neutral ammonia$a21B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a21C$reverses the sign of the bonding-electron term in the formal-charge formula$a21C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a21D$subtracts all bonding electrons instead of half when assigning ownership$a21D$ FROM q;

-- Q22 [Formal Charge · medium · Skill 1 · general-chemistry · ans B] (g22)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Formal Charge',
    $qt22$In gaseous \(\text{HCl}\), a single bond joins the hydrogen and chlorine atoms. A chemist compares the formal charges with the oxidation numbers of the two atoms. Which assignment correctly reflects how each bookkeeping convention treats the shared bonding pair?$qt22$,
    $op22$[{"label":"A","text":"The oxidation-number convention divides the bonding pair equally, giving each atom \\(0\\), whereas the formal-charge convention awards both bonding electrons to chlorine, giving \\(\\text{H}=+1\\) and \\(\\text{Cl}=-1\\)."},{"label":"B","text":"The formal-charge convention divides the bonding pair equally, giving each atom \\(0\\), whereas the oxidation-number convention awards both bonding electrons to chlorine, giving \\(\\text{H}=+1\\) and \\(\\text{Cl}=-1\\)."},{"label":"C","text":"Both conventions weight the bonding pair by electronegativity, so each gives \\(\\text{H}=+1\\) and \\(\\text{Cl}=-1\\)."},{"label":"D","text":"The formal charge on each atom is \\(0\\), and the oxidation numbers are \\(\\text{H}=-1\\) and \\(\\text{Cl}=+1\\)."}]$op22$::jsonb,
    'B',
    $ex22$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is B because the formal-charge convention assumes the two bonding electrons are split evenly between the bonded atoms: hydrogen is assigned \(1\) electron and keeps its \(1\) valence electron, giving \(1-0-1=0\), while chlorine is assigned \(1\) bonding electron plus its \(6\) nonbonding electrons, giving \(7-6-1=0\); both formal charges are \(0\). The oxidation-number convention instead assigns the entire bonding pair to the more electronegative atom, so chlorine takes both bonding electrons to give \(\text{Cl}=-1\) and hydrogen, left with none, gives \(\text{H}=+1\). (Choice A) This reverses the two conventions: it is oxidation number, not formal charge, that assigns the shared pair entirely to chlorine, and formal charge, not oxidation number, that splits the pair evenly. (Choice C) Formal charge does not weight bonding electrons by electronegativity; it splits them equally regardless of the atoms involved, so the formal charges here are \(0\), not \(+1\) and \(-1\). (Choice D) The formal charges of \(0\) are correct, but the oxidation numbers are inverted: the more electronegative chlorine receives the bonding electrons and becomes \(-1\), while hydrogen becomes \(+1\). Skill 1: Knowledge of Scientific Concepts and Principles.$ex22$,
    'medium', '5B', $cc22$Nature of molecules and intermolecular interactions$cc22$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a22A$Swaps which convention assumes even electron sharing versus full transfer to the electronegative atom$a22A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a22C$Believes formal charge, like oxidation number, weights shared electrons by electronegativity$a22C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a22D$Correct formal charges but oxidation numbers assigned with electronegativity priority reversed$a22D$ FROM q;

-- Q23 [Lewis Acids & Bases · medium · Skill 1 · general-chemistry · ans C] (g23)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Lewis Acids & Bases',
    $qt23$Gaseous \(\text{BF}_3\) (an electron-deficient molecule) combines with \(\text{NH}_3\) to form the adduct \(\text{F}_3\text{B}\text{-}\text{NH}_3\). In this reaction \(\text{BF}_3\) most likely acts as which species?$qt23$,
    $op23$[{"label":"A","text":"A Lewis acid, because it donates an electron pair to nitrogen"},{"label":"B","text":"A Lewis base, because the fluorine lone pairs make it electron-rich"},{"label":"C","text":"A Lewis acid, because its electron-deficient boron accepts the nitrogen lone pair"},{"label":"D","text":"A Brønsted acid, because it transfers a proton to nitrogen"}]$op23$::jsonb,
    'C',
    $ex23$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is C because the boron in \(\text{BF}_3\) has only six valence electrons and an empty \(2p\) orbital, so it acts as a Lewis acid by accepting the lone pair on nitrogen. A Lewis acid is defined as an electron-pair acceptor; the electron-deficient boron uses its vacant orbital to receive the \(\text{N}\) lone pair, forming the new \(\text{B}\text{-}\text{N}\) bond in \(\text{F}_3\text{B}\text{-}\text{NH}_3\), while \(\text{NH}_3\) (the electron-pair donor) is the Lewis base. (Choice A) correctly labels \(\text{BF}_3\) a Lewis acid but reverses the defining behavior, since a Lewis acid accepts rather than donates an electron pair. (Choice B) misidentifies \(\text{BF}_3\) as a Lewis base; although fluorine carries lone pairs, the reactive site is the electron-deficient boron, which seeks electron density rather than supplying it. (Choice D) applies the Brønsted definition, but \(\text{BF}_3\) has no proton to transfer, so its acidity here is strictly Lewis-type electron-pair acceptance. Skill 1$ex23$,
    'medium', '5B', $cc23$Nature of molecules and intermolecular interactions$cc23$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a23A$Correct Lewis-acid label paired with the inverted donor/acceptor role$a23A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a23B$Equating peripheral fluorine lone pairs with Lewis basicity instead of recognizing the electron-deficient boron site$a23B$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a23D$Substituting the Brønsted proton-transfer definition for the Lewis electron-pair definition$a23D$ FROM q;

-- Q24 [Lewis Acids & Bases · medium · Skill 1 · general-chemistry · ans D] (g24)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Bonding & Chemical Interactions', 'Lewis Acids & Bases',
    $qt24$In dry conditions, aluminum chloride reacts with a chloride ion to give the tetrachloroaluminate ion: \(\text{AlCl}_3 + \text{Cl}^- \rightarrow \text{AlCl}_4^-\). Treating this as a Lewis acid-base reaction, which species acts as the Lewis acid, and what feature of that species accounts for the role it plays?$qt24$,
    $op24$[{"label":"A","text":"\\(\\text{Cl}^-\\), because it supplies a lone pair of electrons to form the new \\(\\text{Al}\\text{-}\\text{Cl}\\) bond"},{"label":"B","text":"\\(\\text{AlCl}_4^-\\), because the product carries the negative charge that drives the reaction"},{"label":"C","text":"\\(\\text{Cl}^-\\), because it accepts a share of the aluminum atom's bonding electrons"},{"label":"D","text":"\\(\\text{AlCl}_3\\), because the electron-deficient aluminum atom accepts a lone pair from the chloride ion"}]$op24$::jsonb,
    'D',
    $ex24$This is a General Chemistry question that falls under the content category 'Nature of molecules and intermolecular interactions'. The answer to this question is D because a Lewis acid is defined as an electron-pair acceptor, and in \(\text{AlCl}_3\) the aluminum atom has only six electrons in its valence shell (three \(\text{Al}\text{-}\text{Cl}\) bonds and no lone pair), leaving an empty valence orbital. That electron-deficient aluminum accepts a lone pair donated by the chloride ion to form a new coordinate \(\text{Al}\text{-}\text{Cl}\) bond, completing aluminum's octet and producing \(\text{AlCl}_4^-\). Because \(\text{AlCl}_3\) accepts the electron pair, it is the Lewis acid; the chloride ion, which donates the pair, is the Lewis base. (Choice A) This correctly states that \(\text{Cl}^-\) supplies the lone pair, but supplying or donating an electron pair is the defining behavior of a Lewis base, not a Lewis acid, so naming \(\text{Cl}^-\) as the acid attaches the donor species to the wrong role. (Choice B) \(\text{AlCl}_4^-\) is the product (the adduct) of the reaction rather than a reactant, and the Lewis acid is identified among the reacting species by its electron-pair-accepting behavior; the overall negative charge of the product does not make it the acid. (Choice C) The chloride ion is the electron-pair donor in this reaction; describing it as accepting a share of aluminum's bonding electrons reverses the actual direction of electron-pair donation, which runs from chloride into the empty orbital on aluminum. Skill 1$ex24$,
    'medium', '5B', $cc24$Nature of molecules and intermolecular interactions$cc24$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a24A$electron-pair donor (Lewis base) mislabeled as the Lewis acid$a24A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a24B$reaction product (adduct) named as the Lewis acid instead of a reactant$a24B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a24C$direction of lone-pair donation reversed so the donor is described as accepting electrons$a24C$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch1_questions FROM questions WHERE topic='Bonding & Chemical Interactions' AND subtopic IN ('Octet Rule & Exceptions', 'Lewis Structures', 'Formal Charge', 'Lewis Acids & Bases');
