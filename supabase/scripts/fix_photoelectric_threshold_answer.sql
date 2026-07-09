-- ════════════════════════════════════════════════════════════════════
-- FIX: photoelectric threshold-frequency question — corrected answer key + explanation
-- Question id: e93f3e35-eec1-43b3-969b-c2c1b1817826
-- Root cause: data extrapolate to f0 = 5.75e14 Hz (slope = Planck's constant);
-- nearest listed value is 5.5e14 Hz (Choice B), NOT 6.3e14 Hz (Choice C).
-- The stored key (C) was wrong; the explanation computed 5.75e14 three times then
-- illogically selected C. This flips the answer to B, rewrites the explanation, and
-- rebuilds distractor metadata (B is now the answer; C becomes a distractor).
-- Idempotent: safe to re-run.
-- ════════════════════════════════════════════════════════════════════

BEGIN;

UPDATE questions
SET correct_answer = 'B',
    explanation = 'For the photoelectric effect, \(K_\text{max} = h(f - f_0)\), so a plot of \(K_\text{max}\) versus \(f\) is a straight line whose slope is Planck''s constant and whose frequency-axis intercept (where \(K_\text{max} = 0\)) is the threshold \(f_0\). Using the two highest data points, the slope is \(\frac{(3.48 - 0.83)\times 10^{-19}\ \text{J}}{(1.1\times 10^{15} - 7.0\times 10^{14})\ \text{Hz}} = \frac{2.65\times 10^{-19}}{4.0\times 10^{14}} \approx 6.6 \times 10^{-34}\ \text{J·s}\), which confirms the slope is Planck''s constant. Extrapolating down from \((7.0\times 10^{14}\ \text{Hz},\ 0.83\times 10^{-19}\ \text{J})\), \(K_\text{max}\) reaches zero after another \(\frac{0.83\times 10^{-19}}{6.6\times 10^{-34}} \approx 1.26\times 10^{14}\ \text{Hz}\), giving \(f_0 \approx 7.0\times 10^{14} - 1.26\times 10^{14} \approx 5.75\times 10^{14}\ \text{Hz}\). The listed value nearest this intercept is \(5.5\times 10^{14}\ \text{Hz}\). (Choice B) is correct: \(5.5\times 10^{14}\ \text{Hz}\) is the option closest to the extrapolated intercept \(f_0 \approx 5.75\times 10^{14}\ \text{Hz}\) where \(K_\text{max}\) falls to zero. (Choice A) \(5.0\times 10^{14}\ \text{Hz}\) is a frequency at which no electrons are ejected at all, so it lies below the threshold rather than at it; the extrapolated intercept where \(K_\text{max}\) reaches zero is higher, near \(5.75\times 10^{14}\ \text{Hz}\), and \(5.5\times 10^{14}\ \text{Hz}\) sits closer to that value. (Choice C) \(6.3\times 10^{14}\ \text{Hz}\) does fall inside the correct bracket—between the no-current frequency (\(5.0\times 10^{14}\ \text{Hz}\)) and the first current-producing frequency (\(7.0\times 10^{14}\ \text{Hz}\))—but knowing only that \(f_0\) lies between those two values is not enough; extrapolating the fitted line to \(K_\text{max} = 0\) places the intercept well below the middle of that range, near \(5.75\times 10^{14}\ \text{Hz}\), so \(6.3\times 10^{14}\ \text{Hz}\) overestimates it. (Choice D) \(7.0\times 10^{14}\ \text{Hz}\) already ejects electrons with \(K_\text{max} = 0.83\times 10^{-19}\ \text{J}\), so it lies above the threshold, not at it; a positive \(K_\text{max}\) means the photon energy there already exceeds the work function. Skill 4 is required because \(f_0\) is never one of the measured frequencies: the data must be treated as a linear trend and extended back to the \(K_\text{max} = 0\) intercept rather than read directly off any single data point.'
WHERE id = 'e93f3e35-eec1-43b3-969b-c2c1b1817826';

-- Rebuild distractor metadata for the corrected answer (wrong choices = A, C, D).
DELETE FROM question_distractor_metadata WHERE question_id = 'e93f3e35-eec1-43b3-969b-c2c1b1817826';

INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype) VALUES
  ('e93f3e35-eec1-43b3-969b-c2c1b1817826', 'A', 'misconception', 'Mistakes the highest no-current frequency for the threshold; the threshold lies just above it, where K_max extrapolates to zero.'),
  ('e93f3e35-eec1-43b3-969b-c2c1b1817826', 'C', 'process_step_confusion', 'Brackets the threshold between the no-current (5.0e14 Hz) and first-current (7.0e14 Hz) frequencies instead of extrapolating the K_max line to zero, overestimating the intercept.'),
  ('e93f3e35-eec1-43b3-969b-c2c1b1817826', 'D', 'partial_truth', 'Correctly identifies 7.0e14 Hz as the lowest frequency that ejects electrons, but ignores that those electrons already carry nonzero K_max, so the true threshold is lower.');

COMMIT;
