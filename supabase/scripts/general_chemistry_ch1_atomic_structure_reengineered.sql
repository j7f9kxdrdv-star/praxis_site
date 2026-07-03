-- General Chemistry Ch1: Atomic Structure — REMEDIATED (quality + scope sweep); grounded in OpenStax Atoms First 2e
-- Remediated 6/6 flagged questions in place (UPDATE by id, ids preserved). 3 re-engineered, 3 scope-flagged.
-- distractor_category mapped to the question_distractor_metadata CHECK set. Idempotent; safe to re-run.

BEGIN;

-- [Isotopes & Atomic Weight] ans=B medium skill2
UPDATE questions SET
  question_text = 'A newly characterized element X occurs naturally as just two isotopes. In a sample, \(72\%\) of the atoms have an isotopic mass of \(84.91\ \text{amu}\) and the remaining \(28\%\) have an isotopic mass of \(86.91\ \text{amu}\). What value would this sample contribute for the standard atomic weight of element X reported on the periodic table?',
  options = '[{"label": "A", "text": "\\(84.91\\ \\text{amu}\\)"}, {"label": "B", "text": "\\(85.47\\ \\text{amu}\\)"}, {"label": "C", "text": "\\(85.91\\ \\text{amu}\\)"}, {"label": "D", "text": "\\(86.91\\ \\text{amu}\\)"}]'::jsonb,
  correct_answer = 'B',
  explanation = 'This is a General Chemistry question that falls under the content category ''Atoms, nuclear decay, electronic structure, and atomic chemical behavior.'' The atomic weight listed on the periodic table is not the mass of any single atom but a weighted average of all naturally occurring isotopes, equal to the sum of each isotope''s mass multiplied by its fractional abundance. Because the average is weighted by abundance, it lies between the two isotopic masses and is pulled toward whichever isotope is more plentiful. (Choice B) is correct: \((0.72)(84.91) + (0.28)(86.91) = 61.14 + 24.33 = 85.47\ \text{amu}\); the value sits between the two isotopic masses and closer to \(84.91\) because that lighter isotope dominates at \(72\%\). (Choice A) is incorrect: \(84.91\ \text{amu}\) is the mass of the most abundant isotope alone, but a weighted average must be shifted upward by the \(28\%\) of atoms at \(86.91\ \text{amu}\), so the atomic weight cannot equal the dominant isotope''s mass. (Choice C) is incorrect: \(85.91\ \text{amu}\) is the simple arithmetic mean of \(84.91\) and \(86.91\), which would only be correct if the two isotopes were equally abundant; using \(50/50\) instead of the actual \(72/28\) weighting overstates the contribution of the heavier isotope. (Choice D) is incorrect: \(86.91\ \text{amu}\) is the mass of the heavier, less abundant isotope; the average is not set by the heaviest species, and choosing it inverts the weighting by favoring the \(28\%\) minority over the \(72\%\) majority. This is a Scientific Reasoning and Problem Solving question because you must apply the abundance-weighted average to isotopic data to predict where the atomic weight falls rather than reading a single value off the data.',
  difficulty = 'medium',
  cognitive_skill = 2
WHERE id = 'e884152e-3363-4b3f-bcfd-7d4fb4d84410';
DELETE FROM question_distractor_metadata WHERE question_id = 'e884152e-3363-4b3f-bcfd-7d4fb4d84410';
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype) VALUES
  ('e884152e-3363-4b3f-bcfd-7d4fb4d84410', 'A', 'misconception', 'average equals mass of most abundant isotope'),
  ('e884152e-3363-4b3f-bcfd-7d4fb4d84410', 'C', 'misconception', 'uses unweighted arithmetic mean instead of abundance-weighted average'),
  ('e884152e-3363-4b3f-bcfd-7d4fb4d84410', 'D', 'misconception', 'average set by heaviest isotope / inverted weighting');

-- [Quantization, Bohr & Spectra] ans=A hard skill2
UPDATE questions SET
  question_text = 'In the Bohr model of the hydrogen atom, the energy of an electron in level \(n\) is \(E_n = -\dfrac{k}{n^2}\), with \(k = 2.179\times10^{-18}\ \text{J}\). A student compares four emission transitions in a hydrogen lamp, each of which releases a single photon. Which transition emits the photon of highest energy?',
  options = '[{"label": "A", "text": "The \\(n=3 \\to n=1\\) transition"}, {"label": "B", "text": "The \\(n=6 \\to n=3\\) transition"}, {"label": "C", "text": "The \\(n=5 \\to n=2\\) transition"}, {"label": "D", "text": "The \\(n=4 \\to n=2\\) transition"}]'::jsonb,
  correct_answer = 'A',
  explanation = 'This is a General Chemistry question that falls under the content category ''Atoms, nuclear decay, electronic structure, and atomic chemical behavior.'' In the Bohr model the energy levels are quantized as \(E_n = -k/n^2\), so the spacing between adjacent levels is not uniform: it is enormous near the nucleus (between \(n=1\) and \(n=2\)) and shrinks rapidly toward zero as \(n\) grows. The energy of an emitted photon equals \(|\Delta E| = k\left(\tfrac{1}{n_f^2} - \tfrac{1}{n_i^2}\right)\), so the transition ending at the lowest final level dominates, regardless of how many levels the electron drops through. (Choice A) is correct: ending at \(n_f=1\) taps the largest gap in the atom, giving \(|\Delta E| = k(1 - \tfrac{1}{9}) \approx 1.94\times10^{-18}\ \text{J}\) — roughly four times any of the others, so this photon is the most energetic. (Choice B) is incorrect: this transition spans the largest change in level number (\(\Delta n = 3\)), which tempts students to pick it, but both levels lie high up where the spacing is tiny, giving only \(|\Delta E| \approx 1.82\times10^{-19}\ \text{J}\) — the lowest energy of the four. (Choice C) is incorrect: \(k(\tfrac{1}{4} - \tfrac{1}{25}) \approx 4.58\times10^{-19}\ \text{J}\); ending at \(n=2\) is far weaker than ending at \(n=1\), so despite the large drop this photon carries only about a quarter of the key''s energy. (Choice D) is incorrect: \(k(\tfrac{1}{4} - \tfrac{1}{16}) \approx 4.09\times10^{-19}\ \text{J}\); like Choice C it terminates at \(n=2\), so it cannot rival a transition that terminates at \(n=1\). This is a Scientific Reasoning and Problem Solving question because you must apply the \(E_n = -k/n^2\) relationship to recognize that non-uniform level spacing—not the number of levels crossed—determines the emitted photon energy.',
  difficulty = 'hard',
  cognitive_skill = 2
WHERE id = 'bb9a71d8-55fb-4b78-bda8-9cb8a454bec1';
DELETE FROM question_distractor_metadata WHERE question_id = 'bb9a71d8-55fb-4b78-bda8-9cb8a454bec1';
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype) VALUES
  ('bb9a71d8-55fb-4b78-bda8-9cb8a454bec1', 'B', 'misconception', 'largest-delta-n-means-most-energy'),
  ('bb9a71d8-55fb-4b78-bda8-9cb8a454bec1', 'C', 'adjacent_fact', 'large-drop-but-wrong-final-level'),
  ('bb9a71d8-55fb-4b78-bda8-9cb8a454bec1', 'D', 'adjacent_fact', 'same-final-level-different-start');

-- [Quantum Model & Quantum Numbers] ans=C medium skill2
UPDATE questions SET
  question_text = 'A spectroscopist characterizing a single orbital in a hydrogen-like ion determines two things: the subshell it belongs to contains exactly five equivalent orbitals, and the radial probability distribution of an electron in this orbital passes through zero exactly once between the nucleus and infinity. What is the principal quantum number \(n\) of this orbital?',
  options = '[{"label": "A", "text": "\\(n = 2\\)"}, {"label": "B", "text": "\\(n = 3\\)"}, {"label": "C", "text": "\\(n = 4\\)"}, {"label": "D", "text": "\\(n = 5\\)"}]'::jsonb,
  correct_answer = 'C',
  explanation = 'This is a General Chemistry question that falls under the content category ''Atoms, nuclear decay, electronic structure, and atomic chemical behavior.'' The number of orbitals in a subshell is \(2l + 1\), and the number of radial nodes in an orbital is \(n - l - 1\); together these let you recover a specific orbital''s quantum numbers from measurable features. Five orbitals in the subshell give \(2l + 1 = 5\), so \(l = 2\) (a \(d\) subshell), and one radial node gives \(n - l - 1 = 1\), so \(n = l + 2 = 4\) — a \(4d\) orbital. (Choice A) is incorrect: \(n = 2\) would follow from misreading the single radial node as the total node count and setting \(n - 1 = 1\), which ignores the angular contribution and the \(l = 2\) requirement (a \(2d\) orbital does not even exist, since \(l\) must be less than \(n\)). (Choice B) is incorrect: \(n = 3\) is the smallest shell that contains a \(d\) subshell, so it is tempting once you identify \(l = 2\), but a \(3d\) orbital has \(n - l - 1 = 3 - 2 - 1 = 0\) radial nodes, contradicting the observed single node. (Choice C) is correct: combining \(l = 2\) from the five-orbital subshell with one radial node gives \(n - 2 - 1 = 1\), so \(n = 4\). (Choice D) is incorrect: \(n = 5\) comes from over-mapping the "five orbitals" clue directly onto \(n\), but the count of five orbitals fixes \(l\), not \(n\); a \(5d\) orbital would have \(5 - 2 - 1 = 2\) radial nodes, not one. This is a Scientific Reasoning and Problem Solving question because you must apply the relationships \(2l + 1\) and \(n - l - 1\) to two independent measured features to deduce \(n\).',
  difficulty = 'medium',
  cognitive_skill = 2
WHERE id = 'e2f1ef53-dd7b-49f5-9dbf-eee878059b3e';
DELETE FROM question_distractor_metadata WHERE question_id = 'e2f1ef53-dd7b-49f5-9dbf-eee878059b3e';
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype) VALUES
  ('e2f1ef53-dd7b-49f5-9dbf-eee878059b3e', 'A', 'misconception', 'conflates radial nodes with total nodes (n-1)'),
  ('e2f1ef53-dd7b-49f5-9dbf-eee878059b3e', 'B', 'misconception', 'assumes lowest allowed shell for the subshell, ignoring node data'),
  ('e2f1ef53-dd7b-49f5-9dbf-eee878059b3e', 'D', 'misconception', 'over-maps orbital-count clue onto principal quantum number');

-- [Quantization, Bohr & Spectra] ans=A medium skill2
UPDATE questions SET
  question_text = 'In the Bohr model, the energy of the electron in a hydrogen atom is given by \(E_n = -k/n^2\), where \(k = 2.179 \times 10^{-18}\) J. Each of the following transitions is a "drop" of exactly one principal energy level. Which transition emits the photon of greatest energy?',
  options = '[{"label": "A", "text": "The \\(n = 2 \\to n = 1\\) transition"}, {"label": "B", "text": "The \\(n = 3 \\to n = 2\\) transition"}, {"label": "C", "text": "The \\(n = 4 \\to n = 3\\) transition"}, {"label": "D", "text": "The \\(n = 5 \\to n = 4\\) transition"}]'::jsonb,
  correct_answer = 'A',
  explanation = 'This is a General Chemistry question that falls under the content category ''Atoms, nuclear decay, electronic structure, and atomic chemical behavior.'' In the Bohr model the allowed energies follow \(E_n = -k/n^2\), so the levels are not evenly spaced: because energy depends on \(1/n^2\), the gap between adjacent levels shrinks rapidly as \(n\) increases. The emitted photon''s energy equals the size of the energy gap crossed, \(E_{\text{photon}} = |E_{\text{lower}} - E_{\text{higher}}|\), so the single-level drop with the largest gap emits the highest-energy photon.\n\n(Choice A) is correct: The \(n = 2 \to n = 1\) drop spans the two lowest levels, where \(1/n^2\) changes the most (\(1/1 - 1/4 = 3/4\)); this gap, \(|{-k} - ({-k/4})| = 0.75k \approx 1.63 \times 10^{-18}\) J, is the largest of any single-level drop, so it emits the most energetic photon.\n\n(Choice B) is incorrect: The \(n = 3 \to n = 2\) drop spans \(1/4 - 1/9 \approx 0.139k \approx 3.0 \times 10^{-19}\) J, roughly five times smaller than the \(2 \to 1\) gap; this reflects the misconception that all one-level drops release comparable energy rather than sharply decreasing energy.\n\n(Choice C) is incorrect: The \(n = 4 \to n = 3\) gap is only \(1/9 - 1/16 \approx 0.049k \approx 1.1 \times 10^{-19}\) J; choosing it treats the transition as if it were as energetic as the low-\(n\) drops.\n\n(Choice D) is incorrect: The \(n = 5 \to n = 4\) drop involves the highest quantum numbers but the smallest gap (\(\approx 4.9 \times 10^{-20}\) J); it reflects the common error that higher orbits, having more energy, must release more energy per level, when in fact the level spacing narrows toward the ionization limit.\n\nThis is a Scientific Reasoning and Problem Solving question because you must apply the \(E_n = -k/n^2\) relationship to compare energy-level spacings and infer which single-level transition releases the most energy.',
  difficulty = 'medium',
  cognitive_skill = 2
WHERE id = 'dbfd14b5-e157-4c5f-a29a-e11bea08215d';
DELETE FROM question_distractor_metadata WHERE question_id = 'dbfd14b5-e157-4c5f-a29a-e11bea08215d';
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype) VALUES
  ('dbfd14b5-e157-4c5f-a29a-e11bea08215d', 'B', 'misconception', 'assumes uniform level spacing'),
  ('dbfd14b5-e157-4c5f-a29a-e11bea08215d', 'C', 'misconception', 'ignores 1/n^2 scaling'),
  ('dbfd14b5-e157-4c5f-a29a-e11bea08215d', 'D', 'misconception', 'higher orbit means larger energy gap');

-- [Periodic Trends] ans=A medium skill2
UPDATE questions SET
  question_text = 'Across the second period, first ionization energy generally rises with increasing nuclear charge. Oxygen (\(\text{[He]}2s^2 2p^4\)), however, has a slightly lower first ionization energy than nitrogen (\(\text{[He]}2s^2 2p^3\)), which sits immediately to its left. Which statement best accounts for this deviation from the trend?',
  options = '[{"label": "A", "text": "In oxygen, one \\(2p\\) orbital holds a pair of electrons, and removing that electron relieves the added electron-electron repulsion while leaving a half-filled subshell."}, {"label": "B", "text": "Oxygen has a larger atomic radius than nitrogen, so its valence electrons lie farther from the nucleus and are held less tightly."}, {"label": "C", "text": "The electron removed from oxygen occupies a new subshell that is higher in energy than the subshell emptied in nitrogen, so it leaves more easily."}, {"label": "D", "text": "Oxygen''s extra electron shields the nucleus more than its extra proton increases attraction, so its valence electrons feel a lower effective nuclear charge."}]'::jsonb,
  correct_answer = 'A',
  explanation = 'This is a General Chemistry question that falls under the content category ''Atoms, nuclear decay, electronic structure, and atomic chemical behavior.'' First ionization energy generally increases from left to right across a period because effective nuclear charge rises while the valence electrons remain in the same shell. A small deviation appears once a subshell becomes more than half-filled: the next electron must pair up in an already-occupied orbital, and the resulting electron-electron repulsion makes that electron easier to remove.

(Choice A) is correct: nitrogen''s \(2p^3\) places one electron in each of the three \(2p\) orbitals (all unpaired, a stable half-filled subshell), whereas oxygen''s \(2p^4\) forces one orbital to hold a pair. Removing that paired electron eliminates the pairing repulsion and returns oxygen to a half-filled \(2p^3\) configuration, so slightly less energy is required than the general trend predicts.

(Choice B) is incorrect: atomic radius decreases from nitrogen to oxygen because effective nuclear charge increases across the period, so oxygen''s valence electrons actually lie closer to the nucleus, not farther. This would predict a higher ionization energy, the opposite of what is observed.

(Choice C) is incorrect: the electrons removed from both nitrogen and oxygen come from the same \(2p\) subshell, not a new higher-energy subshell. This reasoning describes the separate beryllium-to-boron dip, where ionization moves from a \(2s\) to a \(2p\) electron, and does not apply here.

(Choice D) is incorrect: effective nuclear charge increases from nitrogen to oxygen, since the added proton outweighs the partial shielding from the added same-shell electron. A rising effective nuclear charge would raise ionization energy, so it cannot explain the observed dip.

This is a Scientific Reasoning and Problem Solving question because you must apply subshell electron configuration and electron-pairing repulsion to explain why a specific element deviates from the general periodic trend.',
  difficulty = 'medium',
  cognitive_skill = 2
WHERE id = 'ebb78b48-4acc-430c-b6c1-ac68966cd25a';
DELETE FROM question_distractor_metadata WHERE question_id = 'ebb78b48-4acc-430c-b6c1-ac68966cd25a';
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype) VALUES
  ('ebb78b48-4acc-430c-b6c1-ac68966cd25a', 'B', 'reversed_relationship', 'assumes atomic radius increases across a period, reversing the actual trend'),
  ('ebb78b48-4acc-430c-b6c1-ac68966cd25a', 'C', 'misconception', 'misapplies the beryllium-to-boron s-to-p subshell reasoning to the nitrogen-to-oxygen case'),
  ('ebb78b48-4acc-430c-b6c1-ac68966cd25a', 'D', 'misconception', 'believes added-electron shielding outweighs the added proton, wrongly lowering effective nuclear charge across a period');

-- [Periodic Trends] ans=B medium skill2
UPDATE questions SET
  question_text = 'The successive ionization energies (in kJ/mol) of a neutral main-group element X are measured as: \(\text{IE}_1 = 738\), \(\text{IE}_2 = 1451\), \(\text{IE}_3 = 7733\), \(\text{IE}_4 = 10\,540\). Based on this pattern, element X is most likely a member of which group?',
  options = '[{"label": "A", "text": "The alkali metals (group 1)"}, {"label": "B", "text": "The alkaline earth metals (group 2)"}, {"label": "C", "text": "The boron group (group 13)"}, {"label": "D", "text": "The noble gases (group 18)"}]'::jsonb,
  correct_answer = 'B',
  explanation = 'This is a General Chemistry question that falls under the content category ''Atoms, nuclear decay, electronic structure, and atomic chemical behavior.'' Successive ionization energies for a single element always increase, but there is a sharp jump when ionization crosses from the valence shell into the noble-gas core, because core electrons lie much closer to the nucleus and are far harder to remove than valence electrons. The number of electrons removed relatively easily before that jump therefore equals the number of valence electrons, which fixes the group. (Choice B) is correct: the first two ionizations (\(738\) and \(1451\) kJ/mol) are comparatively low, but \(\text{IE}_3\) leaps to \(7733\) kJ/mol — roughly a fivefold increase — signaling that the third electron must be pulled from the filled core. Exactly two electrons come off easily, so X has two valence electrons and belongs to group 2. (Choice A) is incorrect: an alkali metal has one valence electron, so the large jump would appear right after \(\text{IE}_1\) (between \(\text{IE}_1\) and \(\text{IE}_2\)); here \(\text{IE}_2\) is still modest, so only one valence electron cannot be correct. (Choice C) is incorrect: a group 13 element has three valence electrons, which would place the jump after \(\text{IE}_3\) (between \(\text{IE}_3\) and \(\text{IE}_4\)); instead the data show \(\text{IE}_3\) itself is already the jump, so the third electron is a core electron. (Choice D) is incorrect: associating very large ionization energies with the noble gases confuses a high first ionization energy with the internal jump pattern — a noble gas has a completely filled valence shell (eight valence electrons for the representative noble gases), so no early jump would occur at all, and the pattern shown does not match. This is a Scientific Reasoning and Problem Solving question because you must apply the principle that the large jump in successive ionization energies marks the valence–core boundary and read the data to count the valence electrons.',
  difficulty = 'medium',
  cognitive_skill = 2
WHERE id = '24148f17-4a09-4665-a041-6490640cc18a';
DELETE FROM question_distractor_metadata WHERE question_id = '24148f17-4a09-4665-a041-6490640cc18a';
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype) VALUES
  ('24148f17-4a09-4665-a041-6490640cc18a', 'A', 'misconception', 'misreads jump position as after IE1 (one valence electron)'),
  ('24148f17-4a09-4665-a041-6490640cc18a', 'C', 'misconception', 'off-by-one: reads jump one ionization too late (three valence electrons)'),
  ('24148f17-4a09-4665-a041-6490640cc18a', 'D', 'partial_truth', 'associates large ionization energies with noble gases generally');

COMMIT;
