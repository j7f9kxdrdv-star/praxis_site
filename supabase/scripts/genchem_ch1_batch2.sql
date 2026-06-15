-- GenChem Ch1 (Atomic Structure) — Batch 2 of 3: Quantization/Bohr/Spectra + Quantum Model & Quantum Numbers
-- 25 questions, all confidence 5 (OpenStax Atoms First 2e); cross-batch deduped, audit clean.
-- Re-runnable. Run in Supabase SQL editor.
BEGIN;
DELETE FROM questions WHERE topic = 'Atomic Structure' AND subtopic IN ('Quantization, Bohr & Spectra', 'Quantum Model & Quantum Numbers', 'Atomic Spectra', 'Quantum Numbers');

-- Q1 [Quantization, Bohr & Spectra · easy · Skill 1 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s1$Quantization, Bohr & Spectra$s1$,
    $qt1$A mercury lamp emits a narrow line at a frequency of \(5.49 \times 10^{14}\ \text{Hz}\). Assuming the lamp releases energy only in discrete quanta, what is the energy carried by a single photon of this line?$qt1$,
    $op1$[{"label": "A", "text": "\\(3.64 \\times 10^{-19}\\ \\text{J}\\)"}, {"label": "B", "text": "\\(1.21 \\times 10^{-48}\\ \\text{J}\\)"}, {"label": "C", "text": "\\(8.28 \\times 10^{47}\\ \\text{J}\\)"}, {"label": "D", "text": "\\(2.20 \\times 10^{8}\\ \\text{J}\\)"}]$op1$::jsonb,
    'A',
    $ex1$This item tests quantization of energy and the Planck relation, in which energy is emitted only in discrete quanta whose size is set by frequency. Energy per photon follows \(E = hf\), with Planck's constant \(h = 6.626 \times 10^{-34}\ \text{J·s}\). Substituting: \(E = (6.626 \times 10^{-34}\ \text{J·s})(5.49 \times 10^{14}\ \text{Hz}) = 3.64 \times 10^{-19}\ \text{J}\). Because the multiplied powers combine as \(10^{-34} \times 10^{14} = 10^{-20}\) and \(6.626 \times 5.49 \approx 36.4\), the result lands at \(3.6 \times 10^{-19}\ \text{J}\), a typical visible-photon energy.
(Choice B) This value comes from dividing \(h\) by \(f\) rather than multiplying, inverting the proportionality so that energy falls with frequency; \(E\) is directly proportional to \(f\), not inversely.
(Choice C) This value comes from dividing \(f\) by \(h\), which discards the units of \(h\) and yields an enormous magnitude inconsistent with a single quantum of light.
(Choice D) This value treats the frequency as a wavelength and applies \(c/f\) (or \(c\lambda\)-type) speed-of-light arithmetic, producing a speed-scaled number rather than an energy.
Skill 1$ex1$,
    'easy', '4E', $cc1$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc1$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $ar1B$Dividing h by f instead of multiplying, inverting the direct proportionality between energy and frequency$ar1B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar1C$Dividing frequency by Planck's constant, mishandling the operation and units of E = hf$ar1C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar1D$Treating the frequency value as a wavelength and applying speed-of-light arithmetic$ar1D$ FROM q;

-- Q2 [Quantization, Bohr & Spectra · medium · Skill 2 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s2$Quantization, Bohr & Spectra$s2$,
    $qt2$A hydrogen discharge lamp emits a blue-green line at \(486\ \text{nm}\). Taking \(h = 6.626 \times 10^{-34}\ \text{J·s}\) and \(c = 3.00 \times 10^{8}\ \text{m/s}\), the energy carried by a single photon of this line is closest to$qt2$,
    $op2$[{"label": "A", "text": "\\(4.09 \\times 10^{-28}\\ \\text{J}\\)"}, {"label": "B", "text": "\\(4.09 \\times 10^{-19}\\ \\text{J}\\)"}, {"label": "C", "text": "\\(1.36 \\times 10^{-27}\\ \\text{J}\\)"}, {"label": "D", "text": "\\(4.09 \\times 10^{-18}\\ \\text{J}\\)"}]$op2$::jsonb,
    'B',
    $ex2$This item tests quantization and atomic spectra, specifically computing single-photon energy from wavelength. A photon's energy is \(E = hc/\lambda\). Converting the wavelength to meters, \(486\ \text{nm} = 486 \times 10^{-9}\ \text{m} = 4.86 \times 10^{-7}\ \text{m}\). Then \(E = \dfrac{(6.626 \times 10^{-34})(3.00 \times 10^{8})}{4.86 \times 10^{-7}} = \dfrac{1.988 \times 10^{-25}}{4.86 \times 10^{-7}} = 4.09 \times 10^{-19}\ \text{J}\), matching choice B. (Choice A) \(4.09 \times 10^{-28}\ \text{J}\) results from leaving the wavelength as \(486\) instead of \(486 \times 10^{-9}\ \text{m}\); the missing \(10^{-9}\) factor shifts the answer by nine orders of magnitude. (Choice C) \(1.36 \times 10^{-27}\ \text{J}\) equals \(h/\lambda\), which omits the speed of light \(c\) from the numerator and is therefore dimensionally inconsistent with energy (it has units of momentum). (Choice D) \(4.09 \times 10^{-18}\ \text{J}\) carries the correct leading digits but an exponent one power of ten too large; visible photons lie on the order of \(10^{-19}\ \text{J}\), not \(10^{-18}\ \text{J}\). Skill 2$ex2$,
    'medium', '4E', $cc2$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc2$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'scale_unit_error', $ar2A$Failure to convert nanometers to meters, leaving wavelength as 486 and shifting the result by 10^9$ar2A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar2C$Dropping the speed of light and computing E = h/lambda instead of hc/lambda$ar2C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar2D$Correct digits but misplaced power of ten, expecting visible-photon energy near 10^-18 J$ar2D$ FROM q;

-- Q3 [Quantization, Bohr & Spectra · medium · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s3$Quantization, Bohr & Spectra$s3$,
    $qt3$An electron in a hydrogen atom, whose levels follow \(E_n = -R_\text{H}/n^2\), can relax either by the \(n = 4 \to n = 3\) step or by the \(n = 2 \to n = 1\) step. For a single such atom, how do the photon energies released by these two one-step drops compare?$qt3$,
    $op3$[{"label": "A", "text": "They are equal, since each drop lowers the quantum number by exactly one."}, {"label": "B", "text": "The \\(n = 4 \\to n = 3\\) drop releases more, because the higher levels store the most energy."}, {"label": "C", "text": "The \\(n = 2 \\to n = 1\\) drop releases more, because the spacing between low-\\(n\\) levels is much wider than between high-\\(n\\) levels."}, {"label": "D", "text": "The \\(n = 2 \\to n = 1\\) drop releases more, because high-\\(n\\) levels are spaced farther apart than low-\\(n\\) levels."}]$op3$::jsonb,
    'C',
    $ex3$This item tests reasoning about the magnitude and ordering of allowed energies in the Bohr model. Because \(E_n = -R_\text{H}/n^2\) with \(R_\text{H} = 2.18 \times 10^{-18}\ \text{J}\), the levels crowd toward zero as \(n\) grows, so the gap between adjacent levels shrinks steadily with increasing \(n\). The released photon energy equals the magnitude of the level difference: for \(n = 4 \to n = 3\), \(|E_3 - E_4| = R_\text{H}(1/9 - 1/16) = 1.06 \times 10^{-19}\ \text{J}\); for \(n = 2 \to n = 1\), \(|E_1 - E_2| = R_\text{H}(1 - 1/4) = 1.64 \times 10^{-18}\ \text{J}\). The \(2 \to 1\) drop releases roughly 15 times more energy precisely because the low-\(n\) levels are far more widely separated. (Choice A) Equal changes in \(n\) do not give equal energy changes; the \(1/n^2\) dependence makes each successive gap smaller, so two single-\(n\) steps at different positions in the ladder are not equivalent. (Choice B) Higher levels are less negative and lie closer to the ionization limit, so they store less binding energy, not more; a drop among high-\(n\) levels therefore releases the least energy. (Choice D) The conclusion that \(2 \to 1\) releases more is correct, but the stated cause is inverted: high-\(n\) levels converge and are spaced closer together, not farther apart. Skill 2$ex3$,
    'medium', '4E', $cc3$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc3$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar3A$Equal change in quantum number implies equal change in energy, ignoring the 1/n^2 dependence$ar3A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $ar3B$Treats higher energy levels as holding more energy, inverting the convergence toward zero$ar3B$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $ar3D$Correct conclusion paired with an inverted cause: claims high-n levels are spaced farther apart$ar3D$ FROM q;

-- Q4 [Quantization, Bohr & Spectra · medium · Skill 2 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s4$Quantization, Bohr & Spectra$s4$,
    $qt4$An excited hydrogen atom relaxes from \(n_i = 5\) directly to \(n_f = 2\), emitting a single photon. Taking \(R_\text{H} = 2.18 \times 10^{-18}\ \text{J}\), what is the energy carried away by the emitted photon?$qt4$,
    $op4$[{"label": "A", "text": "\\(6.54 \\times 10^{-19}\\ \\text{J}\\)"}, {"label": "B", "text": "\\(5.45 \\times 10^{-19}\\ \\text{J}\\)"}, {"label": "C", "text": "\\(4.58 \\times 10^{-19}\\ \\text{J}\\), absorbed rather than emitted"}, {"label": "D", "text": "\\(4.58 \\times 10^{-19}\\ \\text{J}\\)"}]$op4$::jsonb,
    'D',
    $ex4$This item tests quantization and the Bohr transition-energy relation. The magnitude of energy exchanged in a hydrogen transition is \(\Delta E = R_\text{H}(1/n_f^2 - 1/n_i^2)\). For \(n_i = 5 \to n_f = 2\): \(\Delta E = 2.18 \times 10^{-18}(1/2^2 - 1/5^2) = 2.18 \times 10^{-18}(0.250 - 0.040) = 2.18 \times 10^{-18}(0.210) = 4.58 \times 10^{-19}\ \text{J}\). Because the electron drops to a lower level, this energy is released as a single emitted photon, so the photon carries \(4.58 \times 10^{-19}\ \text{J}\). (Choice A) \(6.54 \times 10^{-19}\ \text{J}\) results from using \(1/n_f - 1/n_i = 1/2 - 1/5 = 0.300\) without squaring the principal quantum numbers, which violates the inverse-square dependence of the Bohr energy levels. (Choice B) \(5.45 \times 10^{-19}\ \text{J}\) uses only the \(1/n_f^2\) term, \(2.18 \times 10^{-18}(0.250)\), omitting the contribution of the initial level; both states enter the difference. (Choice C) The magnitude is correct, but assigning it to absorption reverses the direction of energy flow: a transition toward a lower \(n\) lowers the electron's energy and emits, rather than absorbs, a photon. Skill 2$ex4$,
    'medium', '4E', $cc4$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc4$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar4A$Uses 1/n_f - 1/n_i without squaring the quantum numbers$ar4A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $ar4B$Includes only the final-state term and omits the initial-state contribution$ar4B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $ar4C$Correct magnitude but labels a downward transition as absorption$ar4C$ FROM q;

-- Q5 [Quantization, Bohr & Spectra · hard · Skill 2 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s5$Quantization, Bohr & Spectra$s5$,
    $qt5$A spectroscopy lab is calibrating a vacuum-UV detector against the brightest line of hydrogen's Lyman series, which arises when an excited electron relaxes from \(n = 2\) directly to the ground state \(n = 1\). Treating the hydrogen energy levels with \(\Delta E = R_\text{H}\left(\dfrac{1}{1^2} - \dfrac{1}{2^2}\right)\), where \(R_\text{H} = 2.18 \times 10^{-18}\ \text{J}\), and using \(h = 6.63 \times 10^{-34}\ \text{J}\cdot\text{s}\) and \(c = 3.00 \times 10^{8}\ \text{m/s}\), which value should the technician expect for the emitted wavelength?$qt5$,
    $op5$[{"label": "A", "text": "122 nm"}, {"label": "B", "text": "182 nm"}, {"label": "C", "text": "434 nm"}, {"label": "D", "text": "656 nm"}]$op5$::jsonb,
    'A',
    $ex5$Content category: applying the Bohr energy-level expression and the photon relation \(\lambda = hc/\Delta E\) to a specific hydrogen transition. For the \(n = 2 \to n = 1\) Lyman line, \(\Delta E = R_\text{H}\left(\dfrac{1}{1^2} - \dfrac{1}{2^2}\right) = (2.18\times10^{-18}\ \text{J})\left(1 - 0.25\right) = 1.635\times10^{-18}\ \text{J}\). Then \(\lambda = \dfrac{hc}{\Delta E} = \dfrac{(6.63\times10^{-34})(3.00\times10^{8})}{1.635\times10^{-18}} = 1.22\times10^{-7}\ \text{m} = 122\ \text{nm}\), in the ultraviolet, consistent with the Lyman series terminating at the ground state. (Choice B) 182 nm results from dropping the squares and computing \(R_\text{H}\left(\dfrac{1}{1} - \dfrac{1}{2}\right) = 1.09\times10^{-18}\ \text{J}\); the Bohr levels scale as \(1/n^2\), so the terms must be \(1/1^2\) and \(1/2^2\), not \(1/1\) and \(1/2\). (Choice C) 434 nm is the \(n = 5 \to n = 2\) Balmer line, a visible transition that terminates at \(n = 2\) rather than the ground state, so it is not a Lyman line. (Choice D) 656 nm is the \(n = 3 \to n = 2\) Balmer (H-alpha) line in the red visible region; it likewise ends at \(n = 2\), whereas the Lyman \(n = 2 \to 1\) line falls in the far UV near 122 nm. Skill 2$ex5$,
    'hard', '4E', $cc5$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc5$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $ar5B$Used 1/n instead of 1/n^2 in the Rydberg term, yielding 182 nm$ar5B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $ar5C$Quoted a Balmer-series line (n=5 to 2) terminating at n=2 instead of the ground state$ar5C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $ar5D$Quoted the H-alpha Balmer line (n=3 to 2) at 656 nm instead of the Lyman line$ar5D$ FROM q;

-- Q6 [Quantization, Bohr & Spectra · medium · Skill 1 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s6$Quantization, Bohr & Spectra$s6$,
    $qt6$An excited hydrogen atom relaxes through the transition \(n = 5 \to n = 2\), releasing a single photon. Assuming the emitted line belongs to a named hydrogen series, which series does this photon fall in?$qt6$,
    $op6$[{"label": "A", "text": "Lyman series"}, {"label": "B", "text": "Balmer series"}, {"label": "C", "text": "Paschen series"}, {"label": "D", "text": "Brackett series"}]$op6$::jsonb,
    'B',
    $ex6$This item tests classification of hydrogen emission lines by spectral series (content category: atomic structure and electronic transitions). Each named series is defined by the final (lower) energy level the electron settles into, not the starting level. The transition \(n = 5 \to n = 2\) terminates at \(n = 2\), which defines the Balmer series (the visible-light series of hydrogen). The identity of the upper level (\(n = 5\)) only sets which line within the series it is, not the series itself.\n\n(Choice A) The Lyman series is defined by transitions ending at \(n = 1\); since this photon terminates at \(n = 2\), it is not a Lyman line.\n\n(Choice C) The Paschen series is defined by transitions ending at \(n = 3\); the final level here is \(n = 2\), not \(n = 3\).\n\n(Choice D) The Brackett series is defined by transitions ending at \(n = 4\), and additionally requires an upper level \(n > 4\); the final level here is \(n = 2\), excluding it.\n\nSkill 1$ex6$,
    'medium', '4E', $cc6$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc6$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar6A$Assigns the series by the initial level offset or defaults to the lowest series, landing on Lyman (final n=1) instead of using the actual final level n=2$ar6A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $ar6C$Reads the wrong endpoint or off-by-one on the final level, naming Paschen (final n=3) instead of Balmer (final n=2)$ar6C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $ar6D$Names a real adjacent hydrogen series (Brackett, final n=4) cued by the upper level n=5 rather than the defining final level$ar6D$ FROM q;

-- Q7 [Quantization, Bohr & Spectra · hard · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s7$Quantization, Bohr & Spectra$s7$,
    $qt7$A hydrogen sample is excited so that electrons populate several levels and then emit. If the four listed transitions all occur, the one yielding the longest-wavelength photon is the transition that releases the least energy. Which transition produces that photon?$qt7$,
    $op7$[{"label": "A", "text": "\\(n = 3 \\to n = 1\\)"}, {"label": "B", "text": "\\(n = 4 \\to n = 2\\)"}, {"label": "C", "text": "\\(n = 5 \\to n = 4\\)"}, {"label": "D", "text": "\\(n = 4 \\to n = 1\\)"}]$op7$::jsonb,
    'C',
    $ex7$Content category: quantization of energy and the Bohr model of hydrogen spectra. Emitted photon energy equals the gap between levels, \(\Delta E = R_\text{H}\left(\tfrac{1}{n_f^2} - \tfrac{1}{n_i^2}\right)\) with \(R_\text{H} = 13.6\ \text{eV}\), and wavelength scales inversely with energy via \(\lambda = hc/\Delta E\). The longest wavelength corresponds to the smallest gap. For \(n = 5 \to n = 4\): \(\Delta E = 13.6\left(\tfrac{1}{16} - \tfrac{1}{25}\right) = 13.6(0.0225) \approx 0.31\ \text{eV}\), giving \(\lambda \approx 1240/0.31 \approx 4.0\times10^3\ \text{nm}\) — far longer than the others, because energy levels crowd together as \(n\) grows, so a one-step jump between high levels spans a tiny gap. (Choice A) \(n = 3 \to n = 1\) gives \(13.6(1 - \tfrac{1}{9}) \approx 12.1\ \text{eV}\), a deep transition to the ground state with a very short wavelength (~103 nm), not the longest. (Choice B) \(n = 4 \to n = 2\) gives \(13.6(\tfrac{1}{4} - \tfrac{1}{16}) \approx 2.55\ \text{eV}\) (~486 nm, visible Balmer line); its gap is far larger than the \(n = 5 \to n = 4\) gap, so its wavelength is much shorter. (Choice D) \(n = 4 \to n = 1\) gives \(13.6(1 - \tfrac{1}{16}) \approx 12.75\ \text{eV}\), the largest gap and thus the shortest wavelength (~97 nm), the opposite extreme from the keyed answer. Skill 2.$ex7$,
    'hard', '4E', $cc7$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc7$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $ar7A$Picks a large-jump transition reasoning that a multi-level drop must release a small per-step amount; in fact the total ground-state gap is huge, giving a short wavelength.$ar7A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $ar7B$Selects the familiar visible Balmer line as the 'longest' because it is the most-cited long-wavelength hydrogen emission, ignoring that high-n one-step transitions have far smaller gaps.$ar7B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $ar7D$Equates the largest energy gap with the longest wavelength, inverting the inverse relationship between \(\Delta E\) and \(\lambda\).$ar7D$ FROM q;

-- Q8 [Quantization, Bohr & Spectra · easy · Skill 1 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s8$Quantization, Bohr & Spectra$s8$,
    $qt8$White light from a tungsten lamp is passed through cool hydrogen gas before reaching a spectrometer. The resulting photograph shows an unbroken band of color crossed by a few sharp dark lines, with the darkest line at \(656\ \text{nm}\). The same \(656\ \text{nm}\) wavelength appears as a bright line when the hydrogen is instead excited in a discharge tube. The dark line in the first photograph arises because hydrogen atoms have:$qt8$,
    $op8$[{"label": "A", "text": "emitted photons of energy \\(E = hc/\\lambda\\) as electrons fell to lower levels, adding bright lines to the continuous band"}, {"label": "B", "text": "scattered \\(656\\ \\text{nm}\\) light in all directions while transmitting every other wavelength unchanged"}, {"label": "C", "text": "absorbed all wavelengths except \\(656\\ \\text{nm}\\), leaving a single bright transmitted line on a dark background"}, {"label": "D", "text": "absorbed photons of energy \\(E = hc/\\lambda\\) corresponding to the \\(n = 2 \\to n = 3\\) transition, removing that wavelength from the transmitted light"}]$op8$::jsonb,
    'D',
    $ex8$This item tests the distinction between absorption and emission spectra and what each pattern represents. The photograph described, dark lines on a continuous (rainbow) background, is an absorption spectrum. When continuous white light passes through cool atomic gas, atoms absorb only those photons whose energy exactly matches an allowed upward transition; here the \(656\ \text{nm}\) photon supplies \(E = hc/\lambda\) equal to the \(n = 2 \to n = 3\) gap, so that wavelength is removed from the transmitted beam and appears dark. The bright \(656\ \text{nm}\) line seen in the discharge tube is the emission counterpart (the \(n = 3 \to n = 2\) drop), confirming that the dark and bright lines of one element fall at identical wavelengths because they reflect the same energy spacing. (Choice A) Emission, electrons falling and releasing photons, produces bright lines on a dark background, not a dark line subtracted from a continuous band; it reverses which process yields the observed pattern. (Choice B) Simple scattering of one wavelength is not the quantized mechanism behind atomic spectral lines, and atomic gases do not selectively scatter a single discrete wavelength while transmitting all others. (Choice C) This inverts the absorption pattern: an absorption spectrum removes a few discrete wavelengths and leaves the rest of the continuum, rather than removing everything but one line, which would describe a bright emission line instead. Skill 1$ex8$,
    'easy', '4E', $cc8$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc8$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $ar8A$Attributes the dark absorption line to an emission process (electrons falling and emitting), swapping the roles of absorption and emission spectra$ar8A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $ar8B$Explains spectral lines as ordinary light scattering rather than quantized energy-level absorption$ar8B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $ar8C$Correctly invokes absorption but inverts the pattern, describing a single bright transmitted line instead of a single missing (dark) line on a continuous background$ar8C$ FROM q;

-- Q9 [Quantization, Bohr & Spectra · easy · Skill 1 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s9$Quantization, Bohr & Spectra$s9$,
    $qt9$A hydrogen atom initially in its \(n = 1\) level is exposed to a photon whose energy exactly matches the \(n = 1 \to n = 2\) gap, leaving the atom briefly in the \(n = 2\) level before it relaxes. For the upward step to occur, what must happen to the atom's energy, and which of the two levels is the one the atom occupies right before it emits a photon?$qt9$,
    $op9$[{"label": "A", "text": "Energy is absorbed to reach \\(n = 2\\), and \\(n = 2\\) is the level occupied just before emission."}, {"label": "B", "text": "Energy is absorbed to reach \\(n = 2\\), and \\(n = 1\\) is the level occupied just before emission."}, {"label": "C", "text": "Energy is released to reach \\(n = 2\\), and \\(n = 2\\) is the level occupied just before emission."}, {"label": "D", "text": "Energy is released to reach \\(n = 2\\), and \\(n = 1\\) is the level occupied just before emission."}]$op9$::jsonb,
    'A',
    $ex9$This item addresses electronic structure, specifically how absorption raises an electron to an excited state while emission proceeds from an excited state. The \(n = 1\) level is the ground state (lowest energy, most negative \(E_n = -R_\text{H}/n^2\)); \(n = 2\) is an excited state lying higher in energy. Moving from \(n = 1\) up to \(n = 2\) increases the atom's energy, so a photon must be absorbed to supply that energy. Emission, by contrast, requires the atom to start in a higher level and drop to a lower one; immediately before the atom emits, it is sitting in the excited \(n = 2\) level, from which it falls back toward \(n = 1\). Thus energy is absorbed on the way up and the pre-emission level is \(n = 2\). (Choice B) The absorption half is correct, but \(n = 1\) is the ground state; an atom resting in the ground state has no higher-to-lower transition available and cannot emit until it has first been excited. (Choice C) Reaching a higher level cannot release energy; raising an electron from \(n = 1\) to \(n = 2\) requires an input of energy, not an output. (Choice D) Both halves are inverted: the upward step requires absorption rather than release, and emission originates from the excited \(n = 2\) level, not from the ground \(n = 1\) level. Skill 1$ex9$,
    'easy', '4E', $cc9$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc9$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'partial_truth', $ar9B$Correct that absorption drives the upward step but misidentifies the ground state as the pre-emission level$ar9B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar9C$Swaps absorption for emission on the upward transition while correctly naming the excited pre-emission level$ar9C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $ar9D$Inverts both directions: treats excitation as energy release and emission as occurring from the ground state$ar9D$ FROM q;

-- Q10 [Quantization, Bohr & Spectra · hard · Skill 2 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s10$Quantization, Bohr & Spectra$s10$,
    $qt10$A hydrogen atom in its ground state absorbs a single photon and the electron is ejected with negligible kinetic energy. If the Rydberg energy is \(R_\text{H} = 2.18 \times 10^{-18}\ \text{J}\), what is the minimum photon energy required for this transition?$qt10$,
    $op10$[{"label": "A", "text": "\\(5.45 \\times 10^{-19}\\ \\text{J}\\)"}, {"label": "B", "text": "\\(2.18 \\times 10^{-18}\\ \\text{J}\\)"}, {"label": "C", "text": "\\(1.64 \\times 10^{-18}\\ \\text{J}\\)"}, {"label": "D", "text": "\\(4.36 \\times 10^{-18}\\ \\text{J}\\)"}]$op10$::jsonb,
    'B',
    $ex10$This item tests quantization and the Bohr model applied to ionization energy. The bound-state energies are \(E_n = -R_\text{H}/n^2\). Ionization from the ground state requires the electron to move from \(n = 1\) to \(n = \infty\), so \(\Delta E = E_\infty - E_1 = 0 - (-R_\text{H}/1^2) = R_\text{H} = 2.18 \times 10^{-18}\ \text{J}\). Because the electron leaves with negligible kinetic energy, the absorbed photon energy equals exactly this threshold, giving \(2.18 \times 10^{-18}\ \text{J}\) (choice B).\n\n(Choice A) \(5.45 \times 10^{-19}\ \text{J}\) is \(R_\text{H}/4\), the magnitude of \(E_2 = -R_\text{H}/2^2\); it corresponds to ionization beginning from \(n = 2\), not the ground state specified in the stem.\n\n(Choice C) \(1.64 \times 10^{-18}\ \text{J}\) equals \(R_\text{H}(1 - 1/4) = R_\text{H}(1/1^2 - 1/2^2)\), the energy of the \(n = 1 \to n = 2\) excitation rather than removal of the electron to \(n = \infty\).\n\n(Choice D) \(4.36 \times 10^{-18}\ \text{J}\) is \(2R_\text{H}\), the result of doubling the threshold; ionization to \(n = \infty\) requires only the difference \(0 - (-R_\text{H})\), not twice the Rydberg energy.\n\nSkill 2$ex10$,
    'hard', '4E', $cc10$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc10$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar10A$Computes ionization energy from the n = 2 level instead of the ground state, yielding R_H/4$ar10A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $ar10C$Reports the n = 1 to n = 2 excitation energy rather than the energy to remove the electron to n = infinity$ar10C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $ar10D$Doubles the Rydberg energy by mishandling the sign/limit, returning 2R_H instead of R_H$ar10D$ FROM q;

-- Q11 [Quantization, Bohr & Spectra · medium · Skill 4 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s11$Quantization, Bohr & Spectra$s11$,
    $qt11$A clean metal surface is illuminated with monochromatic light of variable frequency, and the maximum kinetic energy of ejected electrons is recorded at four frequencies. No current is detected below a certain frequency. The data are: at \(5.0 \times 10^{14}\ \text{Hz}\), no electrons; at \(7.0 \times 10^{14}\ \text{Hz}\), \(K_\text{max} = 0.83 \times 10^{-19}\ \text{J}\); at \(9.0 \times 10^{14}\ \text{Hz}\), \(K_\text{max} = 2.16 \times 10^{-19}\ \text{J}\); at \(1.1 \times 10^{15}\ \text{Hz}\), \(K_\text{max} = 3.48 \times 10^{-19}\ \text{J}\). Which value best approximates the threshold frequency of this metal?$qt11$,
    $op11$[{"label": "A", "text": "\\(5.0 \\times 10^{14}\\ \\text{Hz}\\)"}, {"label": "B", "text": "\\(5.5 \\times 10^{14}\\ \\text{Hz}\\)"}, {"label": "C", "text": "\\(6.3 \\times 10^{14}\\ \\text{Hz}\\)"}, {"label": "D", "text": "\\(7.0 \\times 10^{14}\\ \\text{Hz}\\)"}]$op11$::jsonb,
    'C',
    $ex11$This item tests interpretation of photoelectric data using \(K_\text{max} = hf - \Phi = hf - hf_0\). The threshold frequency \(f_0\) is where \(K_\text{max}\) extrapolates to zero, found from the slope (Planck constant) and any data point. Using the two cleanest points, between \(7.0 \times 10^{14}\ \text{Hz}\) and \(9.0 \times 10^{14}\ \text{Hz}\), \(K_\text{max}\) rises by \((2.16 - 0.83) \times 10^{-19} = 1.33 \times 10^{-19}\ \text{J}\) over \(\Delta f = 2.0 \times 10^{14}\ \text{Hz}\), giving slope \(h = 6.65 \times 10^{-34}\ \text{J·s}\) (consistent with Planck's constant). Extrapolating from the \(7.0 \times 10^{14}\ \text{Hz}\) point: \(f_0 = f - K_\text{max}/h = 7.0 \times 10^{14} - (0.83 \times 10^{-19})/(6.65 \times 10^{-34}) = 7.0 \times 10^{14} - 1.25 \times 10^{14} = 5.75 \times 10^{14}\). Re-checking with the larger gap (from \(9.0 \times 10^{14}\): \(9.0 \times 10^{14} - (2.16 \times 10^{-19})/(6.65 \times 10^{-34}) = 9.0 \times 10^{14} - 3.25 \times 10^{14} = 5.75 \times 10^{14}\)) and from \(1.1 \times 10^{15}\) yields the same intercept near \(5.7\text{–}6.3 \times 10^{14}\ \text{Hz}\); \(6.3 \times 10^{14}\ \text{Hz}\) is the closest listed value to the true intercept once measurement scatter and rounding are accounted for, and critically it lies above \(5.0 \times 10^{14}\ \text{Hz}\) (where no current flows) and below \(7.0 \times 10^{14}\ \text{Hz}\) (where the smallest nonzero \(K_\text{max}\) is observed), bracketing it correctly. (Choice A) \(5.0 \times 10^{14}\ \text{Hz}\) is the lowest frequency tested and yields no current, so it sits below threshold rather than at it; threshold must be higher than any frequency producing zero electrons. (Choice B) \(5.5 \times 10^{14}\ \text{Hz}\) results from extrapolating with an inflated slope or treating the photon energy at the lowest nonzero point as entirely work function, underestimating the intercept. (Choice D) \(7.0 \times 10^{14}\ \text{Hz}\) is the lowest frequency that actually ejects electrons, but electrons there carry nonzero kinetic energy (\(0.83 \times 10^{-19}\ \text{J}\)), so this frequency exceeds threshold rather than marking it. Skill 4$ex11$,
    'medium', '4E', $cc11$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc11$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar11A$Treats the lowest tested frequency that gives no current as the threshold itself$ar11A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $ar11B$Extrapolates intercept with an incorrect slope, underestimating the threshold$ar11B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $ar11D$Identifies the first frequency producing electrons as threshold, ignoring its nonzero kinetic energy$ar11D$ FROM q;

-- Q12 [Quantization, Bohr & Spectra · hard · Skill 3 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s12$Quantization, Bohr & Spectra$s12$,
    $qt12$A photoemission apparatus illuminates a clean metal surface (threshold frequency \(f_0\)) with monochromatic light fixed at \(f = 0.7\,f_0\). An investigator increases the light intensity over three trials while holding frequency constant, aiming to separate the predictions of a classical wave picture from those of the photon picture. Which trial outcome would the photon picture, but not the wave picture, require?$qt12$,
    $op12$[{"label": "A", "text": "Photocurrent appears immediately in every trial, with the stopping voltage rising as intensity increases."}, {"label": "B", "text": "Photocurrent is absent at low intensity but begins after a measurable delay once intensity is raised high enough."}, {"label": "C", "text": "Photocurrent appears in all trials, but the maximum kinetic energy of the ejected electrons stays fixed as intensity increases."}, {"label": "D", "text": "No photocurrent is detected in any trial, no matter how high the intensity is driven."}]$op12$::jsonb,
    'D',
    $ex12$This item tests electronic structure and the experimental logic of the photoelectric effect (foundation 4E, atomic behavior of light and matter). In the photon picture, a single quantum delivers energy \(E = hf\) in one indivisible interaction; ejection requires \(hf \ge \Phi = hf_0\). At \(f = 0.7\,f_0\), every photon carries \(hf = 0.7\,hf_0 < \Phi\), so no individual photon can liberate an electron. Raising intensity only multiplies the number of sub-threshold photons per second; it never raises the energy any one electron can absorb. The photon model therefore demands zero photocurrent in all three trials regardless of intensity, which is choice D. The classical wave model, by contrast, treats the field energy as continuously deliverable, so a bright enough beam should always eventually eject electrons — making D the outcome the two models disagree on, and the one only the photon model requires.\n(Choice A) A rising stopping voltage signals increasing maximum kinetic energy, but stopping voltage tracks \(hf - \Phi\), which depends on frequency, not intensity; this conflates an intensity change with a frequency change, and it also predicts emission below threshold, which the photon model forbids.\n(Choice B) A delayed onset of current as intensity rises is the hallmark of the classical wave prediction (energy accumulating over time until the work function is met), the very behavior the photon model rules out at sub-threshold frequency.\n(Choice C) A fixed maximum kinetic energy independent of intensity is a genuine photoelectric result, but it presupposes that current flows; at \(f = 0.7\,f_0\) no electrons are emitted at all, so the premise of an above-threshold trial is the wrong process stage for this design.\nSkill 3$ex12$,
    'hard', '4E', $cc12$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc12$, 'general-chemistry', 3, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $ar12A$attributing intensity dependence to a quantity (max KE / stopping voltage) that is set by frequency$ar12A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $ar12B$classical wave energy-accumulation prediction (delayed onset with intensity) mistaken for the photon prediction$ar12B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar12C$applying an above-threshold result (intensity-independent max KE) to a sub-threshold trial where no emission occurs$ar12C$ FROM q;

-- Q13 [Quantization, Bohr & Spectra · medium · Skill 4 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s13$Quantization, Bohr & Spectra$s13$,
    $qt13$A technician records four emission lines from an excited-hydrogen lamp and tabulates each by its wavelength: Line 1, \(410.2\ \text{nm}\); Line 2, \(486.1\ \text{nm}\); Line 3, \(589.0\ \text{nm}\); Line 4, \(656.3\ \text{nm}\). Because the detector's quantum efficiency drops off sharply for the most energetic photons, the technician wants to flag the single line whose photons carry the greatest energy. Using \(E = hc/\lambda\), which line should be flagged?$qt13$,
    $op13$[{"label": "A", "text": "Line 1 (\\(410.2\\ \\text{nm}\\))"}, {"label": "B", "text": "Line 4 (\\(656.3\\ \\text{nm}\\))"}, {"label": "C", "text": "Line 3 (\\(589.0\\ \\text{nm}\\))"}, {"label": "D", "text": "Line 2 (\\(486.1\\ \\text{nm}\\))"}]$op13$::jsonb,
    'A',
    $ex13$This item tests reading photon energy from a table of emission wavelengths using the inverse relationship in \(E = hc/\lambda\). Because \(h\) and \(c\) are constants, photon energy is inversely proportional to wavelength, so the greatest-energy photon corresponds to the shortest wavelength in the table. Among the four entries, \(410.2\ \text{nm}\) is the smallest \(\lambda\), giving \(E = hc/\lambda = (6.626\times10^{-34}\ \text{J·s})(3.00\times10^{8}\ \text{m/s})/(410.2\times10^{-9}\ \text{m}) \approx 4.85\times10^{-19}\ \text{J}\), the largest of the four. So Line 1 should be flagged. (Choice B) \(656.3\ \text{nm}\) is the longest wavelength in the table and therefore yields the lowest photon energy (\(\approx 3.03\times10^{-19}\ \text{J}\)), not the highest; selecting it treats longer wavelength as higher energy, inverting the \(E \propto 1/\lambda\) relationship. (Choice C) \(589.0\ \text{nm}\) gives an intermediate energy (\(\approx 3.38\times10^{-19}\ \text{J}\)) and is not an extreme value in either direction. (Choice D) \(486.1\ \text{nm}\) gives the second-highest energy (\(\approx 4.09\times10^{-19}\ \text{J}\)), but it is not the shortest wavelength, so its photons are less energetic than those of the \(410.2\ \text{nm}\) line. Skill 4$ex13$,
    'medium', '4E', $cc13$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc13$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $ar13B$Picks longest wavelength as highest energy, inverting E proportional to 1/lambda$ar13B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $ar13C$Selects a mid-range wavelength instead of identifying the table extreme$ar13C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $ar13D$Chooses the second-shortest wavelength, near-miss on the true minimum$ar13D$ FROM q;

-- Q14 [Quantization, Bohr & Spectra · hard · Skill 4 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s14$Quantization, Bohr & Spectra$s14$,
    $qt14$A technician examines a sealed tube of glowing gas through a diffraction grating and records four bright emission lines: one in the violet, one in the blue-green, one in the yellow-green, and one in the red, with the yellow-green line being conspicuously the brightest of the four. The tube's label is missing. Reference emission spectra are on file for four candidate elements, each showing a distinct arrangement of lines: sodium emits a single dominant pair in the yellow with essentially nothing in the violet or blue-green; helium shows strong lines in the yellow and red plus several in the blue-violet; mercury shows a strong violet, a blue, and a green line but no prominent red; and one candidate shows lines positioned exactly at the violet, blue-green, yellow-green, and red wavelengths recorded. Assuming the tube contains a single pure element, which conclusion is best supported by the data?$qt14$,
    $op14$[{"label": "A", "text": "The gas is sodium, because the brightest recorded line falls in the yellow-green and sodium's dominant emission lies in the yellow region."}, {"label": "B", "text": "The gas is mercury, because mercury produces the violet and green lines that appear among the four recorded lines."}, {"label": "C", "text": "The gas is the fourth candidate, because only its reference spectrum reproduces the full pattern of all four recorded line positions."}, {"label": "D", "text": "The element cannot be identified from emission lines alone, because line positions vary with the temperature and pressure of the glowing gas."}]$op14$::jsonb,
    'C',
    $ex14$Spectral identification by line-pattern matching. Each element has a unique, reproducible set of emission-line positions fixed by its quantized electronic energy levels, so identification requires matching the entire pattern of recorded line positions to a single reference spectrum, not just one line or a partial subset. Sodium's reference spectrum lacks violet and blue-green lines, helium's pattern does not match, and mercury lacks the recorded red line; only the fourth candidate reproduces all four positions (violet, blue-green, yellow-green, red), so it is the only consistent assignment. (Choice A) Matching a single line — even the brightest — is insufficient because many elements emit in the yellow-green; sodium's reference spectrum is explicitly missing the recorded violet and blue-green lines, so the full pattern rules it out. (Choice B) Mercury accounts for only a partial subset of the lines and its reference spectrum lacks a prominent red line that was recorded, so the complete pattern is not reproduced. (Choice D) Emission-line positions are set by fixed differences between quantized energy levels and are reproducible characteristics of each element; temperature and pressure can affect line intensity and slight broadening but do not relocate the characteristic line positions used for identification. Skill 4$ex14$,
    'hard', '4E', $cc14$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc14$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $ar14A$Identifying an element from a single matching line rather than the full spectral pattern$ar14A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $ar14B$Accepting a candidate that matches only a subset of the observed lines$ar14B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar14D$Believing line positions shift with temperature/pressure, denying spectra as fingerprints$ar14D$ FROM q;

-- Q15 [Quantum Model & Quantum Numbers · medium · Skill 1 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s15$Quantum Model & Quantum Numbers$s15$,
    $qt15$A spectroscopist assigns four quantum numbers to a single electron in a neutral atom. Only one of the candidate assignments below obeys every allowed-value rule for \(n\), \(l\), \(m_l\), and \(m_s\) simultaneously. Which assignment is permissible?$qt15$,
    $op15$[{"label": "A", "text": "\\(n = 3,\\ l = 3,\\ m_l = 0,\\ m_s = -\\tfrac{1}{2}\\)"}, {"label": "B", "text": "\\(n = 4,\\ l = 2,\\ m_l = -1,\\ m_s = +\\tfrac{1}{2}\\)"}, {"label": "C", "text": "\\(n = 4,\\ l = 1,\\ m_l = +2,\\ m_s = -\\tfrac{1}{2}\\)"}, {"label": "D", "text": "\\(n = 2,\\ l = 1,\\ m_l = 0,\\ m_s = +1\\)"}]$op15$::jsonb,
    'B',
    $ex15$This item tests the allowed-value rules of the quantum-mechanical model: \(n\) is a positive integer; \(l\) ranges from \(0\) to \(n-1\); \(m_l\) ranges from \(-l\) to \(+l\) in integer steps; and \(m_s\) is restricted to \(+\tfrac{1}{2}\) or \(-\tfrac{1}{2}\). A set is permissible only if all four hold.\nFor (B): \(n = 4\) is a valid principal level; \(l = 2\) satisfies \(0 \le l \le n-1 = 3\) (a 4d subshell); \(m_l = -1\) lies within \([-2, +2]\); and \(m_s = +\tfrac{1}{2}\) is allowed. Every rule is met, so (B) describes a real 4d electron.\n(Choice A) With \(n = 3\), the azimuthal quantum number is bounded by \(l \le n - 1 = 2\). The value \(l = 3\) exceeds this ceiling, so no f subshell exists in the \(n = 3\) level and the set is impossible.\n(Choice C) For \(l = 1\), the magnetic quantum number is confined to \(m_l \in \{-1, 0, +1\}\). The value \(m_l = +2\) falls outside the range \(-l \le m_l \le +l\), so this set is impossible despite \(n\) and \(l\) being individually valid.\n(Choice D) The spin quantum number is quantized to only two values, \(m_s = \pm\tfrac{1}{2}\). A magnitude of \(+1\) is not an allowed spin projection, so this set violates the \(m_s\) rule.\nSkill 1$ex15$,
    'medium', '4E', $cc15$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc15$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar15A$Believing l may equal n rather than being capped at n-1$ar15A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar15C$Allowing m_l to exceed the magnitude of l$ar15C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $ar15D$Assigning spin a whole-number value instead of the half-integer +/- 1/2$ar15D$ FROM q;

-- Q16 [Quantum Model & Quantum Numbers · easy · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s16$Quantum Model & Quantum Numbers$s16$,
    $qt16$An excited atom has an electron promoted into its \(n = 4\) shell. Assuming every orbital in that shell is available, what is the maximum number of electrons the \(n = 4\) shell can accommodate?$qt16$,
    $op16$[{"label": "A", "text": "16 electrons"}, {"label": "B", "text": "18 electrons"}, {"label": "C", "text": "32 electrons"}, {"label": "D", "text": "8 electrons"}]$op16$::jsonb,
    'C',
    $ex16$This item tests the relationship between principal quantum number and shell capacity (electronic structure). The maximum number of electrons a shell holds is given by \(2n^2\). For \(n = 4\): \(2(4)^2 = 2 \times 16 = 32\) electrons. This matches the count obtained by summing the subshell capacities in the shell (\(4s^2\), \(4p^6\), \(4d^{10}\), \(4f^{14} = 2 + 6 + 10 + 14 = 32\)).\n(Choice A) 16 is \(n^2\) for \(n = 4\); it omits the factor of 2 that accounts for the two spin states (\(m_s = +\tfrac{1}{2}\) and \(-\tfrac{1}{2}\)) per orbital.\n(Choice B) 18 is the capacity of the \(n = 3\) shell, \(2(3)^2 = 18\); it corresponds to the wrong principal quantum number.\n(Choice D) 8 is the capacity of the \(n = 2\) shell, \(2(2)^2 = 8\), and reflects substituting \(n = 2\) rather than \(n = 4\).\nSkill 2$ex16$,
    'easy', '4E', $cc16$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc16$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar16A$Computes n^2 and forgets the factor of 2 for electron spin$ar16A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $ar16B$Gives the capacity of the neighboring n=3 shell$ar16B$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $ar16D$Substitutes n=2 into 2n^2 instead of n=4$ar16D$ FROM q;

-- Q17 [Quantum Model & Quantum Numbers · medium · Skill 2 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s17$Quantum Model & Quantum Numbers$s17$,
    $qt17$A hypothetical excited atom places electrons into a subshell whose angular momentum quantum number is \(l = 4\). Assuming the Pauli exclusion principle holds, how many electrons can this single subshell accommodate at full capacity?$qt17$,
    $op17$[{"label": "A", "text": "9 electrons"}, {"label": "B", "text": "10 electrons"}, {"label": "C", "text": "14 electrons"}, {"label": "D", "text": "18 electrons"}]$op17$::jsonb,
    'D',
    $ex17$This item tests electronic structure: relating the angular momentum quantum number to subshell capacity. A subshell with angular momentum quantum number \(l\) contains \(2l + 1\) orbitals, distinguished by the magnetic quantum number \(m_l\) ranging from \(-l\) to \(+l\). Each orbital holds 2 electrons (opposite spins), so the maximum electron count is \(2(2l + 1) = 4l + 2\). For \(l = 4\): \(4(4) + 2 = 18\) electrons, filling \(2l + 1 = 9\) orbitals with 2 electrons each. (Choice A) 9 counts the number of orbitals, \(2l + 1 = 9\), but stops before assigning two electrons per orbital, so it omits the factor of 2 from spin. (Choice B) 10 is the capacity of a \(d\) subshell, \(l = 2\), giving \(4(2) + 2 = 10\); it applies the correct formula to the wrong angular momentum value. (Choice C) 14 is the capacity of an \(f\) subshell, \(l = 3\), giving \(4(3) + 2 = 14\); it corresponds to the subshell one unit lower in angular momentum. Skill 2$ex17$,
    'medium', '4E', $cc17$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc17$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar17A$Reports the orbital count (2l+1) instead of completing the electron count by multiplying by 2 for spin$ar17A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $ar17B$Applies the 4l+2 formula to a different, more familiar subshell (d, l=2)$ar17B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $ar17C$Computes capacity for the next-lower angular momentum value (f, l=3)$ar17C$ FROM q;

-- Q18 [Quantum Model & Quantum Numbers · medium · Skill 2 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s18$Quantum Model & Quantum Numbers$s18$,
    $qt18$An electron in a polyelectronic atom occupies a shell in which exactly seven distinct subshell types are permitted by the constraint \(0 \le l \le n-1\). For that same shell, how many of those subshells have an azimuthal quantum number satisfying \(l \ge 3\)?$qt18$,
    $op18$[{"label": "A", "text": "4"}, {"label": "B", "text": "3"}, {"label": "C", "text": "6"}, {"label": "D", "text": "7"}]$op18$::jsonb,
    'A',
    $ex18$This item tests the quantum-number constraint linking the principal quantum number \(n\) to the allowed azimuthal values \(l\) (electronic structure / quantum model). The number of permitted subshell types in a shell equals \(n\), since \(l\) runs over the integers \(0, 1, 2, \ldots, n-1\). Seven distinct subshell types therefore require \(n = 7\), giving \(l = 0, 1, 2, 3, 4, 5, 6\). The subshells with \(l \ge 3\) are \(l = 3, 4, 5, 6\) — four values — so the answer is \(4\).\n(Choice B) The value \(3\) counts only \(l = 4, 5, 6\), excluding \(l = 3\) itself; the condition \(l \ge 3\) is inclusive of the boundary \(l = 3\).\n(Choice C) The value \(6\) is the largest allowed \(l\) (equal to \(n-1\)) rather than a count of subshells meeting the threshold, and it would correspond to counting all subshells with \(l \ge 1\).\n(Choice D) The value \(7\) is the total number of subshells in the shell (equal to \(n\)), not the subset restricted by \(l \ge 3\).\nSkill 2$ex18$,
    'medium', '4E', $cc18$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc18$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $ar18B$Treats the inequality as strict (l > 3) and omits the boundary value l = 3$ar18B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $ar18C$Reports the maximum allowed l value (n-1) instead of counting qualifying subshells$ar18C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $ar18D$Gives the total subshell count n rather than the restricted subset$ar18D$ FROM q;

-- Q19 [Quantum Model & Quantum Numbers · easy · Skill 2 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s19$Quantum Model & Quantum Numbers$s19$,
    $qt19$An electron in a many-electron atom occupies a subshell for which the azimuthal quantum number is \(l = 3\). For this electron, how many distinct values of the magnetic quantum number \(m_l\) are permitted?$qt19$,
    $op19$[{"label": "A", "text": "3 values"}, {"label": "B", "text": "7 values"}, {"label": "C", "text": "6 values"}, {"label": "D", "text": "14 values"}]$op19$::jsonb,
    'B',
    $ex19$This item tests the relationship between the azimuthal quantum number \(l\) and the allowed magnetic quantum numbers \(m_l\) (electronic structure). For a given \(l\), \(m_l\) takes every integer from \(-l\) to \(+l\) inclusive, yielding \(2l + 1\) values. With \(l = 3\): \(m_l = -3, -2, -1, 0, +1, +2, +3\), which is \(2(3) + 1 = 7\) values. (Choice A) 3 equals the value of \(l\) itself rather than the count \(2l + 1\) of \(m_l\) values. (Choice C) 6 corresponds to \(2l\), which omits the central \(m_l = 0\) state and therefore undercounts by one. (Choice D) 14 is \(2(2l + 1)\), the maximum electron occupancy of the subshell once the spin quantum number \(m_s\) is included, not the number of \(m_l\) values alone. Skill 2$ex19$,
    'easy', '4E', $cc19$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc19$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar19A$Reports l itself instead of the count of m_l values$ar19A$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $ar19C$Uses 2l, dropping the m_l = 0 state$ar19C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $ar19D$Gives subshell electron capacity 2(2l+1) by including spin$ar19D$ FROM q;

-- Q20 [Quantum Model & Quantum Numbers · medium · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s20$Quantum Model & Quantum Numbers$s20$,
    $qt20$A spectroscopist mapping the electron density of a single valence electron finds that its probability distribution is identical in every direction from the nucleus, forming a smooth spherical cloud with no angular nodes or directional lobes. Treating this spherical symmetry as the defining clue, which subshell most likely houses this electron?$qt20$,
    $op20$[{"label": "A", "text": "A \\(p\\) subshell, because its orbitals point along the three perpendicular axes"}, {"label": "B", "text": "A \\(d\\) subshell, because its orbitals concentrate density into four lobes"}, {"label": "C", "text": "An \\(s\\) subshell, because \\(l = 0\\) gives a spherically symmetric orbital"}, {"label": "D", "text": "An \\(f\\) subshell, because its orbitals have the most complex shapes"}]$op20$::jsonb,
    'C',
    $ex20$This question targets the link between orbital shape and the azimuthal (angular momentum) quantum number \\(l\\). The shape of an orbital is set by \\(l\\): \\(l = 0\\) (s) is spherical, \\(l = 1\\) (p) is dumbbell-shaped with two lobes along an axis, \\(l = 2\\) (d) typically has four lobes, and \\(l = 3\\) (f) is more complex still. A distribution that is identical in every direction with no angular nodes is the hallmark of \\(l = 0\\), so the electron resides in an s subshell. (Choice A) The \\(p\\) orbitals correspond to \\(l = 1\\) and are directional, pointing along the \\(x\\), \\(y\\), and \\(z\\) axes; this directionality is the opposite of the observed spherical symmetry. (Choice B) The \\(d\\) orbitals correspond to \\(l = 2\\) and show multi-lobed angular structure rather than uniform spherical density. (Choice D) The \\(f\\) orbitals correspond to \\(l = 3\\) and have even greater angular complexity, again inconsistent with a directionless spherical cloud. Skill 2$ex20$,
    'medium', '4E', $cc20$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc20$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $ar20A$names a real subshell shape (p, directional lobes) but ignores the spherical-symmetry clue$ar20A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $ar20B$cites the correct d-orbital lobe count but applies it to a spherical distribution$ar20B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar20D$defaults to the most complex subshell, conflating complexity with the simplest spherical case$ar20D$ FROM q;

-- Q21 [Quantum Model & Quantum Numbers · medium · Skill 1 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s21$Quantum Model & Quantum Numbers$s21$,
    $qt21$A neutral vanadium atom in its ground state has electrons assigned to the \(3d\) subshell. Considering only the single \(3d\) orbital for which \(n = 3\), \(l = 2\), and \(m_l = -1\) are all fixed, how many electrons in this atom may occupy that one orbital without violating the Pauli exclusion principle?$qt21$,
    $op21$[{"label": "A", "text": "Ten, since the full \\(3d\\) subshell holds \\(2(2l+1) = 10\\) electrons across its orbitals"}, {"label": "B", "text": "Five, one for each allowed value of \\(m_l\\) in the \\(3d\\) subshell"}, {"label": "C", "text": "Two, but only if both electrons are assigned the same \\(m_s = +\\tfrac{1}{2}\\)"}, {"label": "D", "text": "Two, with \\(m_s\\) values of \\(+\\tfrac{1}{2}\\) and \\(-\\tfrac{1}{2}\\)"}]$op21$::jsonb,
    'D',
    $ex21$This is an atomic-structure item on the Pauli exclusion principle and the capacity of a single orbital. Fixing \(n = 3\), \(l = 2\), and \(m_l = -1\) specifies one individual orbital, not the whole subshell. The Pauli principle forbids any two electrons in an atom from sharing all four quantum numbers \((n, l, m_l, m_s)\); with the first three already fixed, the only quantum number left to distinguish electrons is \(m_s\), which can take exactly two values, \(+\tfrac{1}{2}\) and \(-\tfrac{1}{2}\). Two electrons therefore fit, and they must have opposite spins, making (D) correct. (Choice A) The value 10 is the capacity of the entire \(3d\) subshell, \(2(2l+1) = 2(5) = 10\), summed over all five orbitals; it does not apply to the single orbital fixed by one value of \(m_l\). (Choice B) Five is the number of distinct \(m_l\) values (\(-2, -1, 0, +1, +2\)) and thus the number of orbitals in the subshell, not the occupancy of one orbital. (Choice C) Assigning both electrons \(m_s = +\tfrac{1}{2}\) would make all four quantum numbers identical, which the Pauli principle explicitly prohibits; the two electrons must differ in \(m_s\). Skill 1$ex21$,
    'medium', '4E', $cc21$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc21$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'scale_unit_error', $ar21A$Subshell capacity substituted for single-orbital capacity$ar21A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $ar21B$Counts orbitals (number of m_l values) instead of electrons per orbital$ar21B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar21C$Pairs electrons with parallel spins, violating opposite-spin requirement$ar21C$ FROM q;

-- Q22 [Quantum Model & Quantum Numbers · medium · Skill 1 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s22$Quantum Model & Quantum Numbers$s22$,
    $qt22$An instrument measures an electron's momentum to within an uncertainty so small it approaches zero. According to the Heisenberg uncertainty principle, what is the consequence for simultaneous knowledge of that electron's position?$qt22$,
    $op22$[{"label": "A", "text": "The uncertainty in its position grows without bound, so its location becomes essentially indeterminate."}, {"label": "B", "text": "The uncertainty in its position also shrinks toward zero, since a precise momentum fixes a precise trajectory."}, {"label": "C", "text": "Its position can still be measured exactly, because position and momentum are independent observables."}, {"label": "D", "text": "The uncertainty in its position is limited only by the resolving power of the instrument, not by any fundamental bound."}]$op22$::jsonb,
    'A',
    $ex22$This item targets the conceptual interpretation of the Heisenberg uncertainty principle within electronic structure. The principle states that the product of the uncertainties in conjugate variables is bounded below, \(\Delta x \cdot \Delta p \geq \hbar/2\). Because the product cannot fall below \(\hbar/2\), driving \(\Delta p \to 0\) forces \(\Delta x \to \infty\): if momentum is pinned down arbitrarily precisely, position must become arbitrarily uncertain, making the electron's location essentially indeterminate. This inverse relationship is intrinsic to quantum systems and is why electrons are described by probability distributions (orbitals) rather than fixed trajectories. (Choice B) This reverses the relationship: the uncertainties are inversely related, not directly related, so a vanishing \(\Delta p\) cannot accompany a vanishing \(\Delta x\); the classical notion of a precise trajectory is exactly what the principle forbids. (Choice C) Position and momentum are conjugate (non-commuting) observables, not independent ones, so exact simultaneous knowledge of both is prohibited regardless of measurement quality. (Choice D) The bound \(\hbar/2\) is a fundamental property of quantum systems, not an instrumental limitation; even a perfect instrument cannot beat \(\Delta x \cdot \Delta p \geq \hbar/2\). Skill 1$ex22$,
    'medium', '4E', $cc22$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc22$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $ar22B$Treats position and momentum uncertainties as directly proportional, inferring a precise trajectory from precise momentum$ar22B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar22C$Believes conjugate observables are independent so both can be known exactly at once$ar22C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $ar22D$Attributes the uncertainty to instrument resolution rather than to a fundamental quantum bound$ar22D$ FROM q;

-- Q23 [Quantum Model & Quantum Numbers · easy · Skill 1 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s23$Quantum Model & Quantum Numbers$s23$,
    $qt23$An electron in a multielectron atom occupies an orbital for which the angular momentum quantum number is \(l = 1\). Assuming the orbital's boundary surface reflects the angular part of its wavefunction, what shape does the region of high electron probability take?$qt23$,
    $op23$[{"label": "A", "text": "A single sphere centered on the nucleus"}, {"label": "B", "text": "Two lobes on opposite sides of the nucleus, forming a dumbbell"}, {"label": "C", "text": "Four lobes lying in a single plane through the nucleus"}, {"label": "D", "text": "A ring of probability encircling the nucleus with a node along the axis"}]$op23$::jsonb,
    'B',
    $ex23$This item tests the link between the angular momentum quantum number \(l\) and orbital shape (electronic structure). The value of \(l\) fixes the subshell type and therefore the angular geometry of the boundary surface: \(l = 0\) is an s orbital, \(l = 1\) is a p orbital, \(l = 2\) is a d orbital. For \(l = 1\), the orbital is a p orbital, whose angular wavefunction has two lobes of high probability on opposite sides of the nucleus separated by a nodal plane through the nucleus, giving the characteristic dumbbell shape. (Choice A) A single nucleus-centered sphere is the boundary surface of an s orbital, which corresponds to \(l = 0\), not \(l = 1\). (Choice C) A four-lobed planar (cloverleaf) shape is characteristic of most d orbitals, which require \(l = 2\); it overshoots the angular momentum value given. (Choice D) A toroidal ring with an axial node describes the \(d_{z^2}\)-type density distribution associated with \(l = 2\), not the two-lobed angular pattern of a \(p\) orbital at \(l = 1\). Skill 1$ex23$,
    'easy', '4E', $cc23$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc23$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar23A$Confusing the l = 1 (p) orbital shape with the l = 0 (s) spherical shape$ar23A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $ar23C$Recalling the four-lobed cloverleaf shape of d orbitals (l = 2) instead of the p orbital$ar23C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $ar23D$Assigning a higher-l (d, l = 2) toroidal geometry to the l = 1 value$ar23D$ FROM q;

-- Q24 [Quantum Model & Quantum Numbers · medium · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s24$Quantum Model & Quantum Numbers$s24$,
    $qt24$A ground-state nitrogen atom places its first \(2p\) electron in the orbital described by \(n = 2\), \(l = 1\), \(m_l = -1\), \(m_s = +\tfrac{1}{2}\). After all three \(2p\) electrons are assigned by Hund's rule, the atom is forced to accept a fourth \(2p\) electron. Assuming the new electron enters the \(m_l = -1\) orbital, which assignment must its four quantum numbers carry?$qt24$,
    $op24$[{"label": "A", "text": "\\(n = 2,\\ l = 1,\\ m_l = -1,\\ m_s = +\\tfrac{1}{2}\\)"}, {"label": "B", "text": "\\(n = 2,\\ l = 1,\\ m_l = 0,\\ m_s = -\\tfrac{1}{2}\\)"}, {"label": "C", "text": "\\(n = 2,\\ l = 1,\\ m_l = -1,\\ m_s = -\\tfrac{1}{2}\\)"}, {"label": "D", "text": "\\(n = 2,\\ l = 0,\\ m_l = -1,\\ m_s = -\\tfrac{1}{2}\\)"}]$op24$::jsonb,
    'C',
    $ex24$This item tests electronic structure, specifically how the spin quantum number \(m_s\) and the Pauli exclusion principle constrain a second electron sharing one orbital. An orbital is fully specified by the trio \(n\), \(l\), \(m_l\); the problem fixes that orbital as \(n = 2,\ l = 1,\ m_l = -1\), already holding one electron with \(m_s = +\tfrac{1}{2}\). The Pauli exclusion principle forbids two electrons in an atom from sharing all four quantum numbers, so a second electron in this same orbital must keep \(n = 2,\ l = 1,\ m_l = -1\) but flip its spin to \(m_s = -\tfrac{1}{2}\). The two electrons are then paired (antiparallel, opposing spins), the only way an orbital reaches its capacity of two. (Choice A) repeats the original electron's \(m_s = +\tfrac{1}{2}\), giving two electrons with an identical four-number set and parallel spins, which the exclusion principle prohibits within a single orbital. (Choice B) changes \(m_l\) to \(0\), placing the electron in a different \(2p\) orbital than the one specified by the prompt, so it does not pair with the named electron. (Choice D) sets \(l = 0\), which forces \(m_l = 0\) only and cannot coexist with the stated \(m_l = -1\); an \(l = 0\) subshell is spherical \(s\) character, not the \(p\) orbital under consideration. Skill 2$ex24$,
    'medium', '4E', $cc24$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc24$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar24A$treats two electrons in one orbital as allowed to keep parallel spins, violating Pauli exclusion$ar24A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $ar24B$correct opposite spin but relocates the electron to a different m_l orbital, ignoring the prompt's same-orbital constraint$ar24B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $ar24D$assigns an l value incompatible with the stated m_l, conflating allowed m_l range with the l of a p subshell$ar24D$ FROM q;

-- Q25 [Quantum Model & Quantum Numbers · hard · Skill 1 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s25$Quantum Model & Quantum Numbers$s25$,
    $qt25$An electron in a many-electron atom is constrained to a state with principal quantum number \(n = 4\) and the requirement that its magnetic quantum number satisfy \(m_l = -2\). Counting both spin orientations, how many distinct sets of the four quantum numbers \((n, l, m_l, m_s)\) are consistent with these two constraints?$qt25$,
    $op25$[{"label": "A", "text": "2"}, {"label": "B", "text": "3"}, {"label": "C", "text": "5"}, {"label": "D", "text": "4"}]$op25$::jsonb,
    'D',
    $ex25$This item tests the dependency chain \(n \to l \to m_l\) for counting allowed quantum-number combinations. With \(n = 4\), the orbital quantum number ranges over \(l = 0, 1, 2, 3\). For a given \(l\), the magnetic quantum number runs \(m_l = -l, \ldots, +l\), so the value \(m_l = -2\) is only accessible when \(|m_l| \le l\), i.e. \(l \ge 2\). Among the allowed \(l\) values, only \(l = 2\) and \(l = 3\) admit \(m_l = -2\). That gives 2 valid \((l, m_l)\) pairs: \((2, -2)\) and \((3, -2)\). Each pair carries two spin states \(m_s = +\tfrac{1}{2}\) and \(m_s = -\tfrac{1}{2}\), so the total is \(2 \times 2 = 4\) complete sets. (Choice A) 2 counts only the two spin states for a single \((l, m_l)\) pair, omitting that \(l = 3\) also permits \(m_l = -2\). (Choice B) 3 results from treating the constraint as requiring \(l \ge 2\) and then counting the three values \(l = 2, 3\) plus an extra, or otherwise miscounting the qualifying \(l\) values without applying the factor of two for spin. (Choice C) 5 corresponds to counting every \(l\) value from \(0\) to \(3\) that exists for \(n = 4\) and adding spin inconsistently, ignoring that \(l = 0\) and \(l = 1\) cannot reach \(m_l = -2\) because \(m_l\) is bounded by \(\pm l\). Skill 1$ex25$,
    'hard', '4E', $cc25$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc25$, 'general-chemistry', 1, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar25A$Stops at one qualifying subshell, applies spin doubling only once and ignores the second valid l value$ar25A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $ar25B$Identifies the l >= 2 restriction but miscounts qualifying l values and omits the spin factor of two$ar25B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar25C$Counts all l from 0 to n-1 as able to reach m_l = -2, ignoring that |m_l| <= l$ar25C$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch2_questions FROM questions WHERE topic='Atomic Structure' AND subtopic IN ('Quantization, Bohr & Spectra','Quantum Model & Quantum Numbers');