-- Biochemistry Ch3: Non-enzymatic Protein Function & Protein Analysis — Batch 3 — in-scope depth (O2-binding, signaling, quantitation)
-- Original Praxist Prep questions, grounded in LibreTexts Biochemistry; scope verified vs AAMC 2026 outline.
-- Idempotent: deletes only this batch's subtopics, then re-inserts. question_attempts / distractor_metadata cascade.

DELETE FROM questions WHERE topic = 'Non-enzymatic Protein Function and Protein Analysis' AND subtopic IN ('2D Electrophoresis', 'Affinity Chromatography', 'Ion-Exchange Chromatography', 'Multi-Step Purification', 'Oxygen-Binding Proteins', 'Quantitative Analysis', 'Signal Transduction', 'Size-Exclusion Chromatography');

-- Q1 [Oxygen-Binding Proteins] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Oxygen-Binding Proteins', 'A physiologist tabulates the fractional O2 saturation of adult hemoglobin (Hb) at several oxygen partial pressures, chosen to bracket the values encountered in the pulmonary capillaries and in peripheral tissues:

| \(P_{O_2}\) (mmHg) | Physiological site | Hb saturation (%) |
|---|---|---|
| 100 | alveolar/arterial blood | 98 |
| 40  | resting-muscle capillary  | 75 |
| 20  | exercising-muscle capillary | 32 |

Blood arriving from the lungs enters tissue capillaries at 98% saturation. Using only the tabulated values, which statement is best supported by the data?

(Assume blood equilibrates with the local \(P_{O_2}\) at each site and that Hb concentration is constant throughout.)', '[{"label": "A", "text": "A 20 mmHg drop from resting-muscle to exercising-muscle \\(P_{O_2}\\) unloads more O2 per unit Hb than the larger 60 mmHg drop from the lungs to resting muscle."}, {"label": "B", "text": "Because Hb is nearly fully loaded at 100 mmHg, the fraction of O2 it releases is greatest across the lung-to-resting-muscle interval, where \\(P_{O_2}\\) falls the most."}, {"label": "C", "text": "The O2 unloaded is proportional to the drop in \\(P_{O_2}\\), so the 60 mmHg fall from lungs to resting muscle delivers roughly three times as much O2 as the 20 mmHg fall to exercising muscle."}, {"label": "D", "text": "Since saturation is still 75% at resting-muscle \\(P_{O_2}\\), Hb delivers little O2 until \\(P_{O_2}\\) approaches zero, so tissues rely mainly on dissolved O2 rather than Hb-bound O2."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Structure and Function of Proteins and Their Constituent Amino Acids.''

The answer is A because the amount of O2 released equals the drop in saturation between two sites, and you must compare that drop to the size of the \(P_{O_2}\) change to see where unloading is most efficient. From lungs (98%) to resting muscle (75%), saturation falls 23 percentage points across a 60 mmHg drop, i.e. about 0.38 points per mmHg. From resting muscle (75%) to exercising muscle (32%), saturation falls 43 percentage points across only a 20 mmHg drop, i.e. about 2.2 points per mmHg. A smaller pressure change therefore unloads nearly twice the total O2 and far more per mmHg. This disproportion is the functional signature of the sigmoidal, cooperative curve: its steepest region sits in the tissue \(P_{O_2}\) range, so once \(P_{O_2}\) falls into that window (as in working muscle) a small further decline dumps a large additional fraction of bound O2 exactly where demand is highest.

(Choice A) is correct: computing the saturation drop per mmHg for each interval (0.38 vs 2.2 points/mmHg) shows the smaller 20 mmHg drop unloads more O2 per unit Hb, which the data directly support.

(Choice B) is incorrect: it assumes the largest \(P_{O_2}\) drop must release the most O2, but the numbers show the opposite. The 60 mmHg lung-to-resting fall releases only 23 points of saturation, while the 20 mmHg resting-to-exercising fall releases 43 points. The size of the pressure change alone does not determine the release; the local slope of the curve does.

(Choice C) is incorrect: it treats O2 release as linear (proportional) in \(P_{O_2}\), which would be true only for a straight line, not a sigmoid. If release were proportional, the 60 mmHg drop (23 points) would exceed the 20 mmHg drop (43 points), yet the tabulated values contradict this. The proportional prediction fails precisely because the curve is steep near tissue \(P_{O_2}\).

(Choice D) is incorrect: 75% saturation at 40 mmHg does not mean little delivery; between 40 and 20 mmHg saturation drops from 75% to 32%, meaning Hb hands off well over half of its remaining bound O2 in that narrow window. Hb-bound O2, not the small dissolved pool, supplies respiring tissue, and the data show substantial release across the tissue range.

At the Skill 4 level, this question requires converting tabulated saturation values into per-interval and per-mmHg O2 release, then judging which physiological interval extracts oxygen most efficiently, using the data to reason about how the shape of the binding curve serves loading in the lungs and unloading in active tissue.', 'hard', '1A', 'Structure and Function of Proteins and Their Constituent Amino Acids', 'biochemistry', 4, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'larger stimulus must produce larger response' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'assumes linear/proportional response on a nonlinear curve' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'high residual saturation misread as low delivery' FROM q;

-- Q2 [Oxygen-Binding Proteins] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Oxygen-Binding Proteins', 'A physiologist measures the fractional O2 saturation of two purified O2-binding proteins across a range of O2 partial pressures. One protein is found in skeletal muscle; the other circulates in blood. The table below shows each protein''s percent saturation at the pO2 typical of the lungs (~100 mmHg) and of metabolically active tissue (~30 mmHg):

| Protein | % saturation at 100 mmHg (lungs) | % saturation at 30 mmHg (tissue) |
|---------|----------------------------------|----------------------------------|
| Protein X | 98% | 60% |
| Protein Y | 97% | 91% |

Based on these data, which protein is the O2 transporter that carries O2 through the blood, and what is the correct reason?', '[{"label": "A", "text": "Protein X carries O2 in blood; because its saturation falls steeply between lung and tissue pressures, it unloads a large fraction of its bound O2 where tissues need it."}, {"label": "B", "text": "Protein Y carries O2 in blood; because it holds a higher saturation at every pressure, its greater affinity lets it pick up and carry more O2 out of the lungs."}, {"label": "C", "text": "Protein X carries O2 in blood; because its affinity is low at all pressures, it binds O2 only weakly and therefore releases essentially all of it once it reaches the tissues."}, {"label": "D", "text": "Protein Y carries O2 in blood; because its curve rises and saturates at lower pressures, it loads O2 faster in the lungs and so moves more O2 per pass through them."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Structure and Function of Proteins and Their Constituent Amino Acids.''

The answer is A because a good O2 transporter must load O2 in the lungs and then release a meaningful fraction of it in the tissues. Protein X is nearly fully loaded in the lungs (98% at ~100 mmHg) but drops to 60% at tissue pO2 (~30 mmHg), so it delivers roughly \(98\% - 60\% = 38\%\) of its capacity over the physiological range. This steep, cooperative (sigmoidal) response between lung and tissue pressures is exactly what makes hemoglobin an efficient shuttle. Protein Y stays almost saturated even at tissue pO2 (91%), releasing only ~6%, which is the high-affinity, hyperbolic behavior of myoglobin — a storage protein, not a transporter.

(Choice A) is correct: Protein X is the transporter. It is essentially saturated at lung pO2 yet gives up a large fraction of its O2 as pO2 falls to tissue levels; that large lung-to-tissue difference in saturation is what a circulating transporter must provide.

(Choice B) is incorrect: This reverses the roles. Protein Y''s higher saturation at every pressure reflects higher affinity, which means it holds O2 too tightly to release it in the tissues. Higher affinity does not make a better transporter — it makes a better store, because the protein cannot let go of its cargo where it is needed.

(Choice C) is incorrect: It identifies the right protein but for the wrong reason. Protein X does not have low affinity "at all pressures" — it is ~98% saturated in the lungs, which requires that it bind O2 well when pO2 is high. Its usefulness comes from the change in affinity across the pressure range (cooperativity), not from binding weakly everywhere.

(Choice D) is incorrect: Reaching saturation at lower pressures (a high-affinity, hyperbolic curve, Protein Y) does help loading in the lungs, but net delivery depends on unloading in the tissues, not loading speed. Protein Y stays ~91% saturated at tissue pO2, so it barely releases any O2 and cannot serve as a transporter regardless of how readily it loads.

Skill 2: This item requires interpreting quantitative saturation data and reasoning about how the shape of an O2-binding curve maps onto physiological function — recognizing that transport efficiency is set by the difference in saturation between lung and tissue pO2, not by absolute affinity or loading behavior alone.', 'medium', '1A', 'Structure and Function of Proteins and Their Constituent Amino Acids', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'higher affinity equals better transporter' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'right protein, wrong mechanism (low affinity at all pressures)' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'conflates lung-loading speed with net O2 delivery' FROM q;

-- Q3 [Oxygen-Binding Proteins] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Oxygen-Binding Proteins', 'During a bout of intense sprinting, an exercise physiologist samples the interstitial fluid of a subject''s contracting quadriceps. Relative to resting values, the local capillary blood shows a pH drop from 7.40 to 7.20 and a rise in dissolved CO2, while the partial pressure of O2 in the muscle tissue has fallen sharply. The physiologist wants to describe how these local conditions alter the hemoglobin oxygen-dissociation curve within this capillary bed and what that alteration accomplishes for the sprinting muscle. Which prediction is correct?', '[{"label": "A", "text": "The curve shifts rightward and hemoglobin''s P50 rises, so hemoglobin releases a greater fraction of its bound O2 to the working muscle at a given tissue pO2."}, {"label": "B", "text": "The curve shifts leftward and hemoglobin''s P50 falls, so hemoglobin binds O2 more tightly and retains it as it passes through the muscle."}, {"label": "C", "text": "The curve shifts rightward and hemoglobin''s P50 rises, so hemoglobin holds O2 more tightly and delivers less O2 to the working muscle."}, {"label": "D", "text": "The curve is unchanged because pH and CO2 act only in the lungs, so oxygen delivery is set entirely by the fall in tissue pO2."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Structure and Function of Proteins and Their Constituent Amino Acids.''

The answer is A because the elevated H+ (lower pH) and elevated CO2 in metabolically active muscle are heterotropic allosteric effectors that stabilize the T (deoxy) state of hemoglobin, lowering its affinity for O2. Lower affinity shifts the oxygen-dissociation curve to the right, which raises \(P_{50}\) (the pO2 at half-saturation, a higher number meaning it takes more O2 pressure to half-saturate). A right-shifted curve means that at the same tissue pO2, hemoglobin holds a smaller fraction of its O2, so it unloads more O2 exactly where the sprinting muscle needs it. This is the Bohr effect operating to match O2 delivery to demand.

(Choice A) is correct: right shift, higher \(P_{50}\), and enhanced unloading are the coupled consequences of decreased affinity produced by the local acidosis and hypercapnia.

(Choice B) is incorrect: it reverses the relationship. A leftward shift with a lower \(P_{50}\) is what increased affinity looks like (e.g., in the lungs as O2 loads and H+/CO2 dissociate). Low pH and high CO2 in active tissue do the opposite — they decrease affinity, not increase it.

(Choice C) is incorrect: it correctly names the rightward shift and rising \(P_{50}\) but attaches the wrong functional outcome. A right shift by definition lowers affinity, so hemoglobin releases more O2, not less; "holds O2 more tightly" contradicts the very shift being described.

(Choice D) is incorrect: hemoglobin''s affinity is pH- and CO2-dependent (unlike myoglobin), so these effectors modulate the curve within the tissue capillary, not only in the lungs. The fall in tissue pO2 does drive unloading, but the Bohr effect additionally right-shifts the curve so that more O2 is released for the same pO2 drop.

Skill 2 note: succeeding here requires reasoning from the given local conditions (falling pH, rising CO2) to a direction of curve shift, then linking that shift to its physiological consequence for oxygen delivery — not recalling a stated definition.', 'medium', '1A', 'Structure and Function of Proteins and Their Constituent Amino Acids', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Believing low pH / high CO2 increases hemoglobin affinity, producing a left shift' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'Correctly identifying the rightward shift but coupling it to reduced (rather than enhanced) O2 unloading' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Believing pH/CO2 modulate hemoglobin only in the lungs, so tissue delivery depends solely on pO2' FROM q;

-- Q4 [Oxygen-Binding Proteins] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Oxygen-Binding Proteins', 'A physiologist studies a healthy sea-level resident who ascends to a high-altitude research station, where the partial pressure of inspired O2 is markedly reduced. Over several days of acclimatization, glycolytic flux in the person''s erythrocytes increases and the intracellular concentration of 2,3-bisphosphoglycerate (2,3-BPG) rises substantially above its sea-level value, while hemoglobin concentration and body temperature remain unchanged. The physiologist measures whole-blood oxygen–hemoglobin equilibrium curves before ascent and after acclimatization:

  • Before ascent: P50 = 26 mmHg
  • After acclimatization: P50 = 32 mmHg

In peripheral capillaries of actively respiring muscle, the local O2 partial pressure is about 20–30 mmHg. Compared with the sea-level condition, which single statement best describes how the acclimatized state affects hemoglobin''s O2 affinity and the fraction of bound O2 that hemoglobin releases to this muscle tissue?', '[{"label": "A", "text": "O2 affinity is decreased, and hemoglobin unloads a larger fraction of its bound O2 to the muscle tissue"}, {"label": "B", "text": "O2 affinity is increased, and hemoglobin unloads a smaller fraction of its bound O2 to the muscle tissue"}, {"label": "C", "text": "O2 affinity is decreased, and hemoglobin unloads a smaller fraction of its bound O2 to the muscle tissue"}, {"label": "D", "text": "O2 affinity is increased, and hemoglobin unloads a larger fraction of its bound O2 to the muscle tissue"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Structure and Function of Proteins and Their Constituent Amino Acids.''

The answer is A because a rise in erythrocyte 2,3-BPG lowers hemoglobin''s affinity for O2 and thereby increases O2 unloading at the tissues. \(P_{50}\) is the O2 partial pressure at which hemoglobin is half-saturated, so a higher \(P_{50}\) (26 → 32 mmHg) means more O2 is required to reach half-saturation—i.e., the curve is right-shifted and affinity is decreased. Mechanistically, 2,3-BPG is a strongly negatively charged allosteric effector that binds in the central cavity between the β subunits, where it forms additional salt bridges that stabilize the low-affinity T (tense, deoxy) state. Because affinity is lowest where it matters—at the low \(P_{O_2}\) of respiring muscle (about 20–30 mmHg)—hemoglobin holds less tightly to O2 there and releases a larger fraction of its bound O2 to the tissue. This right-shift is the adaptive point of elevated 2,3-BPG at altitude: it improves peripheral O2 delivery.

(Choice A) is correct: decreased affinity (higher \(P_{50}\)) plus greater fractional unloading at low tissue \(P_{O_2}\) is exactly the physiological consequence of T-state stabilization by 2,3-BPG.

(Choice B) is incorrect: it reverses the direction of the affinity change. A higher \(P_{50}\) indicates lower, not higher, affinity, and a lower-affinity hemoglobin unloads more O2 at the tissue, not less. This choice treats 2,3-BPG as if it left-shifted the curve.

(Choice C) is incorrect: it correctly reads the affinity change (decreased) but draws the wrong delivery conclusion. Decreased affinity means O2 is bound less tightly at low \(P_{O_2}\), so the fraction released to tissue rises, not falls; pairing "decreased affinity" with "less unloading" is internally inconsistent.

(Choice D) is incorrect: it inverts both physical facts—claiming increased affinity (which a rising \(P_{50}\) contradicts) yet more unloading. This mismatches the data, because an increased-affinity (left-shifted) hemoglobin would retain O2 more tightly and deliver less to tissue, the opposite of what is stated here.

Skill 2 note: this item requires interpreting \(P_{50}\) as an inverse index of affinity and then predicting a functional outcome (fractional O2 release at a specified low tissue \(P_{O_2}\)) from the effector''s stabilization of the T state, rather than recalling a definition.', 'hard', '1A', 'Structure and Function of Proteins and Their Constituent Amino Acids', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Interprets a higher P50 as higher affinity, reversing the inverse P50–affinity relationship and the resulting delivery direction' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'Reads the affinity change correctly but pairs decreased affinity with reduced tissue unloading, an internally inconsistent conclusion' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Believes 2,3-BPG left-shifts the curve (increases affinity) yet somehow increases delivery, mismatching both facts' FROM q;

-- Q5 [Oxygen-Binding Proteins] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Oxygen-Binding Proteins', 'At the placenta, maternal and fetal blood are separated by a thin membrane across which O2 diffuses. Researchers measured the P50 (the partial pressure of O2 at which the protein is half-saturated) for the two hemoglobins present at this interface under identical conditions:

| Hemoglobin | P50 |
|---|---|
| Maternal HbA | 27 mmHg |
| Fetal HbF | 19 mmHg |

Consider a region of the placental interface where the local O2 partial pressure is such that both hemoglobins are exposed to the same pO2. Based on these data, which statement correctly describes the net movement of O2 and the reason for it?', '[{"label": "A", "text": "Net O2 moves from maternal HbA to fetal HbF, because HbF''s lower P50 reflects a greater tendency to bind and retain O2 at a given pO2."}, {"label": "B", "text": "Net O2 moves from fetal HbF to maternal HbA, because HbF''s lower P50 reflects a weaker grip on O2 that releases it toward maternal blood."}, {"label": "C", "text": "Net O2 moves from maternal HbA to fetal HbF, because HbF''s higher P50 lets it load O2 more readily than maternal blood can."}, {"label": "D", "text": "No net O2 movement occurs, because equal pO2 on both sides means the two hemoglobins are equally saturated and at equilibrium."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Structure and Function of Proteins and Their Constituent Amino Acids.''

The answer is A because P50 is the pO2 at which a hemoglobin is half-saturated, so a lower P50 means the protein reaches high saturation at a lower O2 pressure — i.e., it binds O2 with higher affinity. Fetal HbF (\(P_{50}=19\) mmHg) has a lower P50 than maternal HbA (\(P_{50}=27\) mmHg), so its binding curve is left-shifted. At any shared pO2 across the placental membrane, HbF is more saturated (holds O2 more tightly) than HbA, so O2 dissociates from the lower-affinity maternal HbA and is captured by the higher-affinity fetal HbF. Net O2 therefore flows down the effective gradient from maternal blood into fetal blood, which is precisely what allows the fetus to extract O2 from the mother.

(Choice A) is correct: it correctly pairs the lower P50 of HbF with higher O2 affinity and the resulting maternal-to-fetal net transfer.

(Choice B) is incorrect: it inverts the physiology. A lower P50 signals a stronger, not weaker, grip on O2, and the direction of net transfer must be maternal-to-fetal for the fetus to be oxygenated; this choice both misreads P50 and reverses the transfer direction.

(Choice C) is incorrect: it reaches the right transfer direction but with a false premise — it claims HbF has a higher P50, contradicting the data. A protein that loads O2 more readily has a lower P50, so the stated reasoning does not follow from the numbers given.

(Choice D) is incorrect: equal pO2 does not imply equal saturation when the two proteins have different affinities. Because HbF''s curve is left-shifted relative to HbA''s, the two are at different saturations at the same pO2, creating the affinity difference that drives net O2 transfer rather than eliminating it.

Skill 2 in action: rather than recalling a fact, you had to convert the operational P50 values into a statement about relative O2 affinity, map that onto which hemoglobin holds O2 more tightly at a shared pO2, and predict the resulting direction of net transfer across the interface.', 'medium', '1A', 'Structure and Function of Proteins and Their Constituent Amino Acids', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Believes lower P50 means weaker O2 binding, and reverses the direction of placental O2 transfer' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'Knows O2 flows to the fetus but wrongly thinks readier O2 loading corresponds to a higher P50' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Assumes equal pO2 forces equal saturation, ignoring that affinity differences shift the binding curve' FROM q;

-- Q6 [Oxygen-Binding Proteins] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Oxygen-Binding Proteins', 'A physiology lab measures the oxygen-binding behavior of four hemoglobin samples under standardized conditions and reports the partial pressure of O₂ at which each sample is exactly half-saturated:

| Sample | Half-saturation O₂ pressure (mm Hg) |
|--------|--------------------------------------|
| W      | 19                                   |
| X      | 26                                   |
| Y      | 31                                   |
| Z      | 12                                   |

All four samples were tested at the same temperature and total hemoglobin concentration, and each generated a normal sigmoidal saturation curve. In a respiring tissue capillary where the local O₂ pressure is low, which sample would release (unload) the greatest fraction of its bound oxygen to the surrounding tissue?', '[{"label": "A", "text": "Sample Y, because it reaches half-saturation only at the highest O₂ pressure among the four samples"}, {"label": "B", "text": "Sample Z, because it reaches half-saturation at the lowest O₂ pressure among the four samples"}, {"label": "C", "text": "Sample W, because its half-saturation value lies closest to the middle of the four reported values"}, {"label": "D", "text": "Sample X, because a value of 26 mm Hg is nearest the typical resting tissue O₂ pressure of roughly 26 mm Hg"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Structure and Function of Proteins and Their Constituent Amino Acids.''

The answer is A because the O₂ pressure at half-saturation is \(P_{50}\), and \(P_{50}\) is inversely related to oxygen affinity: a higher \(P_{50}\) means more O₂ pressure is required to half-saturate the protein, so the protein holds O₂ less tightly (lower affinity). Sample Y has the highest \(P_{50}\) (31 mm Hg), so it has the lowest O₂ affinity of the four samples. A low-affinity hemoglobin gives up its bound O₂ most readily as the surrounding O₂ pressure falls in a respiring tissue, so Sample Y unloads the greatest fraction of its oxygen to the tissue.

(Choice A) is correct: Y''s \(P_{50}\) of 31 mm Hg is the largest value, marking it as the lowest-affinity sample; low affinity is exactly what maximizes O₂ release at low tissue \(pO_2\).

(Choice B) is incorrect: Sample Z does reach half-saturation at the lowest O₂ pressure (12 mm Hg), but a low \(P_{50}\) signals the highest affinity, not the lowest. High-affinity hemoglobin clings to O₂ and unloads the least in the tissues, so Z is the poorest, not the best, oxygen deliverer. This choice inverts the \(P_{50}\)–affinity relationship.

(Choice C) is incorrect: proximity of a \(P_{50}\) value to the middle of the data set has no bearing on oxygen delivery. The relevant comparison is which sample has the lowest affinity (highest \(P_{50}\)), not which value is near the median; W''s mid-range \(P_{50}\) simply makes it an intermediate deliverer.

(Choice D) is incorrect: matching \(P_{50}\) to a particular tissue \(pO_2\) does not determine which sample unloads the most oxygen. Unloading is governed by how low the affinity is (how high the \(P_{50}\) is) relative to the others; a numerical coincidence between 26 mm Hg and a resting-tissue pressure is a distractor, and Y still delivers a greater fraction than X.

To reason from the data alone, treat the half-saturation pressure as \(P_{50}\), rank the four values, recognize that the largest \(P_{50}\) corresponds to the weakest O₂ binding, and connect weakest binding to greatest release at low tissue O₂ pressure — a multi-step chain from raw numbers to a physiological conclusion.', 'hard', '1A', 'Structure and Function of Proteins and Their Constituent Amino Acids', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Inverts the P50-affinity relationship: treats lowest P50 (highest affinity) as best unloader' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Treats proximity to the median value as physiologically meaningful instead of comparing affinities' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'Assumes matching P50 to tissue pO2 determines unloading rather than relative affinity' FROM q;

-- Q7 [Oxygen-Binding Proteins] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Oxygen-Binding Proteins', 'A team studies a purified tetrameric hemoglobin using stopped-flow equipment that lets them add exactly one O2 molecule per tetramer and then measure how fast a second O2 binds to the same tetramer. In the fully deoxygenated sample, the initial O2 association is slow. After a single O2 has bound to one subunit, the researchers observe that a second O2 binds to a neighboring, still-empty subunit much faster than the first O2 did. No allosteric effectors (H+, CO2, or BPG) were added, and the total protein concentration was unchanged throughout. Which statement best accounts for the faster binding of the second O2 in this experiment?', '[{"label": "A", "text": "Binding of the first O2 drives the tetramer toward a quaternary conformation in which the remaining subunits present higher-affinity binding sites."}, {"label": "B", "text": "Binding of the first O2 lowers the local pH around the tetramer, and the resulting proton release raises the affinity of the empty subunits."}, {"label": "C", "text": "Binding of the first O2 covalently links the four subunits, so the empty subunits can no longer dissociate and are forced to retain O2."}, {"label": "D", "text": "Binding of the first O2 saturates the highest-affinity subunit, so the remaining O2 must bind the lower-affinity subunits that are left."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Structure and Function of Proteins and Their Constituent Amino Acids.''

The answer is A because the experiment isolates a single binding event and shows that the first O2 makes the next one bind faster, which is the functional signature of positive cooperativity. In hemoglobin, occupancy of one subunit triggers a shift in the quaternary structure from the low-affinity T (tense/deoxy) state toward the high-affinity R (relaxed/oxy) state: a small movement of the heme iron on binding propagates to the subunit interfaces, altering salt bridges and hydrogen bonds so that the still-empty subunits now present higher-affinity sites. Because affinity is higher (lower \(K_d\)), the second O2 associates more readily. This is a functional consequence of the first binding event, not merely a restatement of what cooperativity is.

(Choice A) is correct: the first O2 promotes the T\(\rightarrow\)R quaternary transition, raising the affinity (lowering \(K_d\)) of the remaining subunits, which explains the observed increase in binding speed under the stated conditions.

(Choice B) is incorrect: this describes the Bohr effect (a heterotropic effect of \(\mathrm{H^+}\)/\(\mathrm{CO_2}\)), and it points the wrong way — lower pH and more protons decrease, not increase, O2 affinity. The stem explicitly states no effectors were added, so the acceleration must come from the homotropic O2-induced conformational change, not from a pH shift.

(Choice C) is incorrect: cooperativity does not involve any new covalent bonds between subunits. The subunits are held together by noncovalent interfaces, and the affinity change comes from a reversible conformational transition; O2 binding remains reversible, so no subunit is "forced" to retain O2.

(Choice D) is incorrect: this reverses the direction of cooperativity. In positive cooperativity the sites start in a uniformly low-affinity state and get better as binding proceeds; the second O2 binds a site whose affinity has increased, not a leftover lower-affinity site. A pre-set hierarchy from highest- to lowest-affinity would predict the second O2 binding more slowly, the opposite of what was measured.

Skill 2: rather than defining cooperativity, you had to take an isolated single-binding measurement, rule out the heterotropic (pH/effector) and no-covalent-linkage explanations, and infer that the first binding event functionally raises the affinity of the remaining subunits via the T\(\rightarrow\)R shift.', 'medium', '1A', 'Structure and Function of Proteins and Their Constituent Amino Acids', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'adjacent_fact', 'confusing homotropic O2 cooperativity with the heterotropic Bohr effect' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believing subunit communication requires new covalent bonds rather than a reversible conformational change' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'treating cooperativity as a fixed high-to-low affinity hierarchy so subsequent binding is weaker, not stronger' FROM q;

-- Q8 [Oxygen-Binding Proteins] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Oxygen-Binding Proteins', 'A previously healthy adult is brought to the emergency department after being trapped in a smoke-filled room. Arterial blood gas analysis shows a normal dissolved-oxygen tension (PaO₂ 95 mm Hg) but a carboxyhemoglobin fraction of 40%, meaning roughly 40% of the heme sites are occupied by carbon monoxide rather than dioxygen. A hematologist notes that on this patient''s blood, the P₅₀ of the hemoglobin population still carrying dioxygen is markedly lower than the normal value of 26 mm Hg. Compared with a healthy person who has the same PaO₂ but no carbon monoxide exposure, how is oxygen delivery to peripheral tissues most accurately described, and why?', '[{"label": "A", "text": "Delivery is reduced by more than the 40% loss of carrying capacity would predict, because the remaining oxygen-bound sites hold dioxygen more tightly and release less of it at tissue oxygen tensions."}, {"label": "B", "text": "Delivery is reduced by almost exactly 40%, since only the fraction of sites occupied by carbon monoxide is unavailable and the oxygen on the remaining sites unloads normally in tissues."}, {"label": "C", "text": "Delivery is essentially preserved, because the increased affinity of the remaining sites lets hemoglobin extract more dissolved oxygen from plasma and hand it off efficiently to tissues."}, {"label": "D", "text": "Delivery is only mildly reduced, because the normal PaO₂ keeps plasma dissolved oxygen high enough that peripheral tissues meet their needs directly from dissolved oxygen."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Structure and Function of Proteins and Their Constituent Amino Acids.''

The answer is A because two independent injuries compound each other. First, carbon monoxide binds the heme Fe²⁺ sixth coordination site with far higher affinity than dioxygen, so the 40% of sites it occupies simply cannot carry O₂ — a loss of carrying capacity. Second, the reported drop in \(P_{50}\) (from 26 mm Hg toward a lower value) signals a left-shift of the dissociation curve for the sites still carrying dioxygen: lower \(P_{50}\) means higher O₂ affinity. Because tissue O₂ delivery depends on hemoglobin *releasing* (unloading) O₂ at the low \(pO_2\) of respiring tissue, a left-shifted, tighter-binding population unloads a smaller fraction of what it carries. So the deliverable O₂ falls by more than the 40% capacity loss alone — the unloading defect stacks on top of the capacity defect. This is why 40% carboxyhemoglobin is far more dangerous than simply losing 40% of red cells.

(Choice A) is correct: it captures both mechanisms — reduced capacity plus impaired unloading from the higher-affinity (lower \(P_{50}\)) remaining sites — which is exactly what produces delivery loss greater than 40%.

(Choice B) is incorrect: it accounts only for the capacity loss and assumes the remaining sites behave normally. It ignores the stated fall in \(P_{50}\); a left-shifted curve unloads less O₂ at tissue tensions, so the true deficit exceeds 40%.

(Choice C) is incorrect: it reverses the physiological consequence of higher affinity. Tighter binding helps *loading* in the lungs but hurts *unloading* in tissues, and the plasma dissolved-O₂ pool is far too small to matter for delivery. Preserved or improved delivery is the opposite of what a left-shift causes.

(Choice D) is incorrect: dissolved O₂ at a PaO₂ of 95 mm Hg carries only a tiny amount of oxygen (roughly 0.3 mL/dL) relative to hemoglobin-bound O₂; a normal PaO₂ cannot compensate for lost hemoglobin capacity and impaired release, which is precisely why the patient is hypoxic despite normal PaO₂.

As a Skill 2 problem, success depends not on recalling that CO binds hemoglobin, but on integrating two facts — occupancy lowers capacity and a lower \(P_{50}\) means tighter binding — and predicting their combined effect on the unloading step that actually delivers O₂ to tissue.', 'hard', '1A', 'Structure and Function of Proteins and Their Constituent Amino Acids', 'biochemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'partial_truth', 'accounts for capacity loss but ignores the left-shift / unloading defect on remaining sites' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'treats higher affinity (lower P50) as improving tissue delivery, reversing loading vs unloading' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'believes normal PaO2 / dissolved O2 can compensate for lost hemoglobin capacity' FROM q;

-- Q9 [Signal Transduction] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Signal Transduction', 'A hormone-triggered pathway in a liver cell proceeds through four steps, with the following stoichiometry measured experimentally:

- Step 1: One hormone molecule binds one receptor, activating that single receptor (1 → 1).
- Step 2: Each activated receptor, before it is switched off, activates 70 molecules of a G protein (1 → 70).
- Step 3: Each activated G protein switches on exactly one molecule of a membrane enzyme (1 → 1).
- Step 4: Each activated membrane enzyme, before it is inactivated, catalyzes the synthesis of 500 small intracellular signaling molecules (1 → 500).

A researcher wants to test four separate single mutations, each of which alters exactly one feature of one step, to see which produces the largest reduction in the total number of intracellular signaling molecules generated per hormone molecule that binds. Which mutation would reduce that total output the MOST?

- Mutation W: causes each activated receptor to activate 35 G proteins instead of 70 (Step 2).
- Mutation X: causes each activated G protein to switch on 2 membrane enzymes instead of 1 (Step 3).
- Mutation Y: causes each hormone molecule to bind 2 receptors instead of 1 (Step 1).
- Mutation Z: makes each activated G protein switch on its one membrane enzyme 3 times faster, without changing the 1-to-1 ratio (Step 3 rate).', '[{"label": "A", "text": "Mutation W, because it halves the output of a step whose 1-to-many stoichiometry multiplies through the rest of the cascade"}, {"label": "B", "text": "Mutation Z, because speeding up a step proportionally raises every downstream step, so slowing it would be the largest cut"}, {"label": "C", "text": "Mutation X, because doubling enzyme activation at Step 3 changes the step that contributes the most molecules"}, {"label": "D", "text": "Mutation Y, because binding two receptors removes the pathway''s only true point of signal amplification"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Biosignaling.''

The answer is A because the total output per bound hormone is the product of the step stoichiometries: \(1 \times 70 \times 1 \times 500 = 35{,}000\) molecules. The amplifying steps are the ones with a 1-to-many ratio (Step 2, \(1\to70\), and Step 4, \(1\to500\)); a single activated protein at each of these steps begets many products, so a change there multiplies through everything downstream. Mutation W cuts Step 2 from 70 to 35, giving \(1 \times 35 \times 1 \times 500 = 17{,}500\) — a halving of the entire cascade output. Of the four options, only W reduces a genuinely amplifying step in a way that lowers the total, so it produces the largest reduction.

(Choice A) is correct: because Step 2 is a catalytic, one-to-many step, halving its fan-out (70 → 35) propagates multiplicatively and halves the final total from 35,000 to 17,500 molecules per hormone.

(Choice B) is incorrect: Mutation Z changes only the rate of Step 3, not its stoichiometry. The total number of signaling molecules per hormone is fixed by the per-step product counts, not by how fast each step runs; a 1-to-1 step still passes on exactly one activated enzyme per G protein whether it does so quickly or slowly, so the total stays \(1 \times 70 \times 1 \times 500 = 35{,}000\). This reasoning wrongly assumes that speeding (or slowing) a step linearly rescales the whole product, which the stated fixed stoichiometry does not support.

(Choice C) is incorrect: Mutation X doubles Step 3 (1 → 2), which would raise output to \(1 \times 70 \times 2 \times 500 = 70{,}000\) — an increase, not a reduction. Choosing X reflects the misconception that the step producing the largest raw count (Step 4''s 500) or any downstream change automatically dominates; direction and whether the change increases or decreases fan-out matter.

(Choice D) is incorrect: Mutation Y doubles receptor binding (Step 1 becomes 1 → 2), which increases total output to \(2 \times 70 \times 1 \times 500 = 70{,}000\). Step 1 is a 1-to-1 (non-amplifying) step, and calling it the "only true point of amplification" reverses the actual relationship — the amplifying steps are the catalytic 1-to-many ones (Steps 2 and 4), not the binding step.

At the Skill 2 level, this problem requires you to apply the amplification principle to a novel numbered cascade: recognize that total intracellular response equals the product of per-step fan-out factors, identify which steps are catalytic (one-to-many) versus one-to-one, and predict the quantitative consequence of altering a single step rather than recalling any definition.', 'medium', '3B', 'Biosignaling', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'assumes changing the rate/speed of a fixed 1-to-1 step linearly rescales the cascade''s total product' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'treats an increase in fan-out as a reduction and assumes the largest-count step dominates any change' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'mislabels the non-amplifying 1-to-1 binding step as the point of amplification' FROM q;

-- Q10 [Signal Transduction] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Signal Transduction', 'A cultured epithelial cell line expresses a G-protein-coupled receptor (GPCR) that, upon binding a peptide hormone, activates a stimulatory G-protein (Gsα) whose GTP-bound form stimulates adenylate cyclase to convert ATP into cAMP; the cAMP then activates protein kinase A (PKA). Researchers generate a variant cell line ("Mut") carrying a single amino-acid substitution in the catalytic residue of Gsα that is required for hydrolysis of the bound GTP; the substitution abolishes this hydrolytic step but does not alter GTP binding or the ability of Gsα to contact adenylate cyclase. Intracellular cAMP was measured in the parental ("WT") and Mut lines under matched conditions:

| Cell line | No hormone (nM cAMP) | + Hormone (nM cAMP) |
|-----------|----------------------|----------------------|
| WT        | 15                   | 480                  |
| Mut       | 470                  | 495                  |

Starting from the "no hormone" state, a saturating dose of a competitive antagonist that occupies the hormone-binding pocket of the GPCR (preventing hormone from binding, and having no effect on Gsα or adenylate cyclase) is now added to the Mut line. Which result for intracellular cAMP in the Mut line is expected, and why?', '[{"label": "A", "text": "cAMP stays near 470 nM, because the mutant Gsα remains GTP-bound and continues to stimulate adenylate cyclase whether or not the receptor is occupied."}, {"label": "B", "text": "cAMP falls to about 15 nM, because occupying the receptor prevents it from loading GTP onto Gsα and thereby shuts the pathway off at its source."}, {"label": "C", "text": "cAMP was never truly elevated and reads near 15 nM, because a Gsα that cannot hydrolyze GTP is trapped in its GDP-bound state and cannot signal."}, {"label": "D", "text": "cAMP rises above 495 nM, because blocking the receptor removes a hormone-dependent brake that normally limits adenylate cyclase output."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Biosignaling.''

The answer is A because the mutation removes Gsα''s intrinsic GTPase step, so once Gsα is GTP-bound it cannot switch itself off; it persistently stimulates adenylate cyclase and keeps cAMP high independent of what the receptor is doing. The data already show this: the Mut line sits at ~470 nM cAMP with no hormone (versus 15 nM for WT), meaning the pathway is locked "on" upstream of the effector enzyme and downstream of the receptor. Because the antagonist acts only at the receptor''s hormone-binding pocket, and the constitutively active Gsα no longer depends on receptor input, blocking the receptor cannot lower the signal — cAMP stays near its already-elevated ~470 nM.

(Choice A) is correct: The GTP-bound Gsα is the active state, and losing the hydrolysis step leaves it "continually activated." Its stimulation of cyclase is uncoupled from receptor occupancy, so a receptor-level antagonist leaves cAMP essentially unchanged and high.

(Choice B) is incorrect: This treats receptor occupancy as the required, rate-limiting input to Gsα. That is true in WT, but the mutation places the lesion downstream of the receptor; a Gsα stuck in its GTP-bound form does not need the receptor to load nucleotide, so blocking the receptor does not return cAMP to the 15 nM baseline.

(Choice C) is incorrect: It reverses the activity rule for G-proteins. The GTP-bound form is the active form and the GDP-bound form is inactive; a mutant that cannot hydrolyze GTP is trapped in the active GTP-bound state, not an inactive one. The measured 470 nM cAMP in the unstimulated Mut line directly contradicts the claim that no signal was ever generated.

(Choice D) is incorrect: No hormone-dependent negative feedback on adenylate cyclase is described in this pathway, and the "+ hormone" Mut value (495 nM) is barely above its no-hormone value (470 nM), showing the system is already near-maximally driven. Removing the antagonist''s target (the receptor) provides no mechanism to push output above the hormone-stimulated ceiling.

As a reasoning (Skill 2) task, success requires locating the perturbation within the cascade — recognizing that a GTPase-dead Gsα is constitutively active and lies downstream of the receptor — and then predicting that a receptor-level intervention cannot control a signal that has been uncoupled from the receptor, rather than restating any single definition.', 'hard', '3B', 'Biosignaling', 'biochemistry', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'treats an upstream step (receptor occupancy/GTP loading) as required even when the lesion is downstream of it' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'inverts the G-protein activity rule, assuming GTP hydrolysis is needed to turn signaling ON so the GTPase-dead mutant is ''inactive''' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'invents a hormone-dependent negative-feedback brake on adenylate cyclase that the pathway does not contain' FROM q;

-- Q11 [Signal Transduction] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Signal Transduction', 'The insulin receptor is a receptor tyrosine kinase. On binding insulin, two receptor molecules are brought together in the membrane, and only once they are paired does the cytoplasmic kinase domain of an activated receptor transfer phosphate onto tyrosine residues located on the cytoplasmic tail of the other receptor in the pair. A researcher expresses three receptor variants in cultured cells and, after adding a saturating dose of insulin, measures (1) whether the receptor accumulates as pairs in the membrane and (2) the amount of phosphotyrosine detected on the receptor''s cytoplasmic tail:

  Variant | Extracellular domain | Cytoplasmic kinase domain | Paired in membrane? | Phosphotyrosine on tail?
  Wild type | normal | catalytically active | Yes | High
  Variant 1 | mutation blocks insulin-induced pairing | catalytically active | No | None detected
  Variant 2 | normal | active site mutated (cannot bind ATP) | Yes | None detected

Both Variant 1 and Variant 2 fail to recruit the downstream adaptor proteins that normally bind the phosphorylated tail. Variant 1 shows no phosphotyrosine even though, on its own, its kinase domain is fully capable of catalysis. Which statement best explains this result?', '[{"label": "A", "text": "The kinase domain modifies tyrosines only on a second receptor molecule, so a receptor that never pairs has no accessible tail to phosphorylate"}, {"label": "B", "text": "Blocking extracellular pairing prevents insulin from entering the cell, and without intracellular insulin the kinase domain stays catalytically inactive"}, {"label": "C", "text": "An unpaired receptor cannot bind ATP, so its kinase domain lacks the phosphate donor needed to modify any tyrosine residue"}, {"label": "D", "text": "Loss of pairing exposes the phosphorylated tyrosines to cytoplasmic phosphatases, which strip the phosphate as quickly as it is added"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Biosignaling.''

The answer is A because autophosphorylation in a receptor tyrosine kinase is an intermolecular event: each activated kinase domain deposits phosphate onto tyrosine residues on the other receptor of the pair, not onto itself. Variant 1''s kinase domain is fully catalytically active on its own, so the enzyme works; what it lacks is a substrate. Because the extracellular mutation prevents insulin-induced pairing, each receptor stays a lone molecule with no second tail positioned nearby to receive a phosphate. The data support this: Variant 1 pairs ''No'' and shows ''None detected,'' while Variant 2 pairs ''Yes'' yet also shows none because its own catalytic machinery is dead — two different broken steps converging on the same output. Without the phosphotyrosine marks, the docking sites that recruit downstream adaptor proteins never form, so signaling stops in both variants for different reasons.

(Choice A) is correct: it identifies the reaction as one receptor acting on a second receptor, so a molecule that cannot pair has an intact enzyme but no accessible substrate, explaining zero phosphotyrosine despite a functional kinase.

(Choice B) is incorrect: the receptor transduces the insulin signal across the membrane through conformational change and pairing; insulin does not need to enter the cytoplasm, and the intracellular kinase is not switched on by intracellular insulin. This misconstrues how a transmembrane receptor works.

(Choice C) is incorrect: ATP binding is a property of the individual kinase domain''s active site, which the stem states is catalytically active in Variant 1. Pairing does not create the ATP-binding site; the true failure is the absence of a second tail to act on, not an inability to bind the phosphate donor.

(Choice D) is incorrect: a phosphatase-based explanation would require phosphate to first be added and then removed, but the reasoning here is that no phosphate is ever transferred because there is no second tail to phosphorylate; invoking phosphatases adds an unsupported step the data do not require.

Skill 2 note: succeeding here means moving beyond the definition of autophosphorylation to apply the intermolecular mechanism to a novel mutant, using the paired-vs-unpaired data to distinguish ''enzyme broken'' (Variant 2) from ''substrate absent'' (Variant 1) as separate routes to the same loss of signaling.', 'medium', '3B', 'Biosignaling', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'ligand must enter cell to act' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'conflates dimerization with ATP-binding capability' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'invokes phosphatase reversal not supported by data' FROM q;

-- Q12 [Signal Transduction] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Signal Transduction', 'A heterotrimeric G protein-coupled receptor activates its cognate Gα subunit, which then stimulates a downstream effector enzyme that produces a diffusible second messenger. A researcher engineers two versions of this Gα subunit and expresses each in otherwise identical cells:

- Variant WT: the native Gα.
- Variant Q→L: a single substitution at the catalytic glutamine in the switch-II region that positions the water molecule used to cleave the terminal phosphate of the bound guanine nucleotide.

Each cell line is given a 30-second pulse of agonist, after which the agonist is thoroughly washed out at t = 0. Intracellular second-messenger concentration (arbitrary units) is then recorded:

  Time after washout (min):   0     2      5     15
  WT:                        95    40     12     4
  Q→L:                       98    92     90    88

Assuming receptor number, effector abundance, and messenger-degrading machinery are equal in both lines, which statement best accounts for the Q→L data?', '[{"label": "A", "text": "The substitution prevents cleavage of the bound nucleotide''s terminal phosphate, so the subunit stays in its effector-stimulating state and keeps driving messenger production after agonist removal."}, {"label": "B", "text": "The substitution locks the subunit in its guanosine-diphosphate-loaded state, which is the conformation that engages and stimulates the effector enzyme."}, {"label": "C", "text": "The substitution blocks exchange of guanosine diphosphate for guanosine triphosphate, so the released βγ dimer alone sustains effector output once the agonist is gone."}, {"label": "D", "text": "The substitution accelerates nucleotide cleavage, so the subunit re-forms the inactive heterotrimer more slowly and the effector stays engaged."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Biosignaling.''

The answer is A because the switch-II glutamine positions the catalytic water that hydrolyzes the terminal (γ) phosphate of bound GTP; removing it produces a GTPase-dead subunit that cannot convert its bound GTP to GDP. Since the GTP-loaded conformation is the one that engages and stimulates the effector, the subunit stays "on" indefinitely. The data show exactly this: in WT, messenger falls back toward baseline within minutes of agonist washout (95 → 4) because each activated subunit hydrolyzes its GTP and switches off, whereas in Q→L the messenger stays high (98 → 88) long after the agonist is gone — signaling that fails to terminate rather than signaling that is stronger at the peak. The peaks (95 vs 98) are essentially identical; the divergence is entirely in how the signal decays, which is the signature of a broken off-switch, not a stronger on-switch.

(Choice A) is correct: it correctly ties the loss of γ-phosphate cleavage to a persistently GTP-bound, effector-stimulating subunit that keeps producing messenger even after the receptor stops loading new subunits — matching the sustained plateau.

(Choice B) is incorrect: it reverses the active/inactive relationship. The GTP-bound (not GDP-bound) conformation stimulates the effector; a GDP-loaded subunit is the "off" state and would give a rapid return to baseline, the opposite of the observed plateau.

(Choice C) is incorrect: it misattributes the sustained output to the βγ dimer and invents a GDP→GTP exchange block. The mutation is in the catalytic residue for hydrolysis, not in the nucleotide-exchange step; and the persistence here reflects an α subunit trapped in its GTP-bound active state, not free βγ.

(Choice D) is incorrect: it inverts the kinetics. Faster hydrolysis would switch the subunit off sooner and speed the return to baseline, producing a decay faster than WT — not the flat, elevated trace observed.

To reach the answer you had to reason from the pattern in the data — identical peaks but a WT curve that decays and a mutant curve that does not — and infer that the defect lies in the mechanism that turns the signal off (γ-phosphate hydrolysis), rather than accepting any single restated definition of the subunit''s activity.', 'hard', '3B', 'Biosignaling', 'biochemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Confusing which nucleotide-bound state (GTP vs GDP) is the active, effector-stimulating conformation' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Attributing sustained effector activation to the free βγ dimer and confusing hydrolysis with nucleotide exchange' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'Believing faster GTP hydrolysis prolongs rather than shortens the active state' FROM q;

-- Q13 [Quantitative Analysis] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Quantitative Analysis', 'A researcher runs a purified protein of unknown mass on an SDS-PAGE gel alongside a set of molecular-weight standards. After staining, the relative migration distance (Rf, the distance a band travels divided by the distance traveled by the tracking dye) is measured for each band. The standards give the following data:

| Standard | Molecular weight | Rf |
|---|---|---|
| 1 | 97.4 kDa | 0.20 |
| 2 | 66.2 kDa | 0.30 |
| 3 | 45.0 kDa | 0.40 |
| 4 | 31.0 kDa | 0.50 |
| 5 | 21.5 kDa | 0.60 |

The unknown protein migrates with an Rf of 0.44. Based on the standard data, which value is the best estimate of the unknown protein''s molecular weight?', '[{"label": "A", "text": "39 kDa"}, {"label": "B", "text": "45 kDa"}, {"label": "C", "text": "31 kDa"}, {"label": "D", "text": "25 kDa"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because on an SDS-PAGE gel the logarithm of molecular weight, not molecular weight itself, is a linear function of relative migration distance. A calibration curve of \(\log(M_r)\) versus \(R_f\) is constructed from the standards, and the unknown''s mass is read off (interpolated) from that line. Using the tabulated standards, the log-linear fit is approximately \(\log_{10}(M_r) = -1.64\,R_f + 5.31\). At \(R_f = 0.44\), \(\log_{10}(M_r) \approx 4.59\), so \(M_r \approx 10^{4.59} \approx 3.9 \times 10^{4}\), i.e. about 39 kDa. Equivalently, because \(R_f = 0.44\) lies between the 45.0 kDa standard (\(R_f = 0.40\)) and the 31.0 kDa standard (\(R_f = 0.50\)), interpolating on the log scale places the unknown below 45 kDa but well above 31 kDa, consistent with roughly 39 kDa.

(Choice A) is correct: it is obtained by interpolating on the logarithmic axis, which is the relationship SDS-PAGE calibration curves actually follow.

(Choice B) is incorrect: 45 kDa results from treating molecular weight itself as a linear function of \(R_f\) and fitting a straight line to the raw (untransformed) mass values, ignoring that the true relationship is linear in \(\log(M_r)\). Because the log axis compresses the larger masses, a linear-in-mass fit systematically overestimates the mass for a band in this region.

(Choice C) is incorrect: 31 kDa is the mass of the flanking standard just below the unknown (\(R_f = 0.50\)). Reporting the nearest lower band instead of interpolating rounds the estimate down and would only be correct if the unknown co-migrated with that standard, which it does not (\(R_f = 0.44 \neq 0.50\)).

(Choice D) is incorrect: about 25 kDa arises from inverting the migration measurement—for example, measuring the distance from the dye front rather than from the well, which effectively uses \(1 - R_f = 0.56\). Reading the curve at \(R_f = 0.56\) shifts the estimate toward the smaller, faster-migrating end and yields a mass that is too low.

To answer, you had to recognize which quantity is linearly related to \(R_f\), extract the trend from the tabulated standards, and interpolate on the correct (logarithmic) scale rather than applying a plausible-looking but incorrect linear read-off—reasoning from the data to the mass rather than matching a stated rule.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 4, 120)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'treats molecular weight as linear in Rf instead of log(MW) linear in Rf' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'reports the nearest flanking standard''s value instead of interpolating between standards' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'inverts the migration measurement, using 1-Rf (distance from dye front) rather than Rf' FROM q;

-- Q14 [Quantitative Analysis] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Quantitative Analysis', 'A researcher purifying a 45-kDa enzyme runs two samples from the same purification, side by side, on a single Coomassie-stained SDS-PAGE gel. Densitometry of the 45-kDa band gives an integrated intensity of 4,200 arbitrary units in Lane A and 8,300 arbitrary units in Lane B. From this gel alone, the researcher wants to claim that Lane B contains roughly twice as much of the enzyme as Lane A. Which additional piece of information would most directly justify converting the ~2:1 intensity ratio into a valid statement about the relative amounts of enzyme loaded?', '[{"label": "A", "text": "Confirmation that the total sample amount deposited in each lane was held constant and that both band intensities fall within the stain''s linear response range"}, {"label": "B", "text": "Confirmation that both bands migrated to the same apparent molecular weight relative to the ladder standards"}, {"label": "C", "text": "Confirmation that the gel was stained with silver rather than Coomassie so that both bands were detectable"}, {"label": "D", "text": "Confirmation that each protein was fully denatured and uniformly coated with SDS before loading"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because a band-intensity ratio can be read as an amount ratio only when the measurement is calibrated by a control. Densitometric intensity is proportional to the mass of protein in a band, so the raw 4,200:8,300 (~1:2) reading is consistent with Lane B holding twice the enzyme — but only if two conditions hold. First, the comparison must be normalized: if the two lanes were loaded with different total sample amounts, then a difference in the target band could simply reflect how much was pipetted in, not a real difference in enzyme content, so a loading/reference control is required. Second, the dye–protein relationship is linear only over a limited range; once a band saturates the stain, adding more protein no longer proportionally increases the measured signal, so a truly doubled amount could read as much less than double. Establishing equal loading and linear-range operation is exactly what turns a ratio of intensities into a valid ratio of amounts.

(Choice A) is correct: it supplies both the normalization (equal total loaded) and the caveat (intensities within the stain''s linear range) needed for intensity to track amount.

(Choice B) is incorrect: matching migration to the same apparent molecular weight confirms the two bands are the same species, which is necessary for comparing them at all, but identity of a band says nothing about whether the intensity-to-amount conversion is quantitatively valid.

(Choice C) is incorrect: silver stain is roughly 10–50× more sensitive than Coomassie, so it improves detection of faint bands, but greater sensitivity does not establish equal loading or linearity — silver staining in fact has a narrower linear range and is generally worse, not better, for this kind of quantitation.

(Choice D) is incorrect: complete denaturation and uniform SDS coating standardize electrophoretic mobility so proteins separate cleanly by size; this affects where a band runs and how tight it is, not whether its measured intensity can be scaled into a relative amount.

At the Skill 2 level, the task is to recognize that a numerical intensity ratio is only interpretable once the measurement is anchored by a control (equal loading) and constrained to its valid operating window (the linear range) — reasoning from the data to the condition that makes the data mean what the researcher wants it to mean.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 95)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'adjacent_fact', 'confusing_identity_verification_with_quantitation' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'sensitivity_mistaken_for_quantitative_accuracy' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'separation_prep_step_mistaken_for_quantitation_control' FROM q;

-- Q15 [Quantitative Analysis] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Quantitative Analysis', 'A researcher runs a size-exclusion (gel-filtration) column and, using the same conditions, first generates a calibration curve from five globular protein standards. The elution volume (V_e, the volume at the center of each protein''s peak) for each standard is:

| Standard        | Native MW (kDa) | V_e (mL) |
|-----------------|-----------------|----------|
| Thyroglobulin   | 669             | 9.8      |
| Aldolase        | 158             | 12.7     |
| Conalbumin      | 75              | 14.2     |
| Ovalbumin       | 44              | 15.3     |
| Ribonuclease A  | 13.7            | 17.6     |

A single unknown globular protein, run on the same column under identical conditions, elutes as one symmetric peak centered at V_e = 13.45 mL. Which value is the best estimate of the unknown''s native molecular weight?', '[{"label": "A", "text": "≈ 109 kDa"}, {"label": "B", "text": "≈ 117 kDa"}, {"label": "C", "text": "≈ 75 kDa"}, {"label": "D", "text": "≈ 200 kDa"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because size-exclusion calibration is log-linear: across a set of globular standards, the logarithm of molecular weight is a straight-line function of elution volume, so an unknown''s MW must be read off that log scale, not off raw MW. The unknown''s \(V_e = 13.45\) mL sits between Aldolase (158 kDa at 12.7 mL) and Conalbumin (75 kDa at 14.2 mL). Its position along the volume axis is \((13.45 - 12.7)/(14.2 - 12.7) = 0.50\) — exactly halfway. Interpolating in \(\log_{10}(\mathrm{MW})\): \(\log_{10}(158) = 2.199\) and \(\log_{10}(75) = 1.875\), so \(\log_{10}(\mathrm{MW}) = 2.199 - 0.50(2.199 - 1.875) = 2.037\), giving \(\mathrm{MW} = 10^{2.037} \approx 109\) kDa. (Because the five standards fall on a single log-linear line, fitting the full calibration curve through all of them gives the same estimate.)

(Choice A) is correct: it uses the correct log-linear interpolation between the two bracketing standards, which agrees with the full-curve fit.

(Choice B) is incorrect: 117 kDa is the arithmetic midpoint of the two flanking masses, \((158 + 75)/2 = 116.5\) kDa. This treats MW itself (rather than \(\log \mathrm{MW}\)) as linear in \(V_e\). Because the calibration is linear in the logarithm, straight averaging of the masses overestimates the true value.

(Choice C) is incorrect: 75 kDa simply snaps the unknown to the nearest tabulated standard (Conalbumin). A calibration curve is meant to be interpolated, not used as a lookup table; the unknown elutes 0.75 mL earlier than Conalbumin, so it must be heavier than 75 kDa.

(Choice D) is incorrect: 200 kDa reverses the size–elution relationship. In gel filtration, larger species are excluded from the pores, spend less time inside the beads, and therefore elute in a smaller volume; smaller species partition into the internal volume and elute later. The unknown elutes after (at a larger volume than) the 158 kDa standard, so it must be lighter than 158 kDa, not heavier.

To reason to the key on Skill 4, you had to integrate the calibration data with the underlying model: recognize that the standards define a log-linear MW–versus–\(V_e\) relationship, locate the unknown between the correct pair of standards using its elution volume, and interpolate on the logarithmic scale rather than defaulting to a linear average or a nearest-neighbor lookup.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 4, 120)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'linear_interpolation_of_MW_instead_of_log_MW' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'snapping_unknown_to_nearest_standard_instead_of_interpolating' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'assuming_elution_volume_increases_with_molecular_weight' FROM q;

-- Q16 [2D Electrophoresis] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', '2D Electrophoresis', 'A researcher separates a four-protein mixture by two-dimensional gel electrophoresis. The first dimension is run across an immobilized pH gradient (pH 3 at the left edge, pH 10 at the right edge), after which the strip is laid horizontally atop a uniform SDS-polyacrylamide slab and the second dimension is run downward. The measured properties of the four proteins are:

| Protein | pI  | Molecular mass (kDa) |
|---------|-----|----------------------|
| W       | 4.2 | 68                   |
| X       | 8.9 | 15                   |
| Y       | 4.5 | 14                   |
| Z       | 8.6 | 71                   |

After staining, one spot appears in the upper-right corner of the developed gel (near the top edge, toward the right side). Which protein produced that spot?', '[{"label": "A", "text": "Protein Z, because its high mass and basic character place it near the top on the right side"}, {"label": "B", "text": "Protein W, because its high mass and acidic character place it near the top on the right side"}, {"label": "C", "text": "Protein X, because its low mass and basic character place it near the top on the right side"}, {"label": "D", "text": "Protein Y, because its low mass and acidic character place it near the top on the right side"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is Z because the two axes of a 2D gel encode two independent properties, and the upper-right corner requires a specific pairing of both. In the first dimension (isoelectric focusing), each protein migrates until it reaches the position where the gel pH equals its \(pI\), where its net charge is zero and migration halts. With pH 3 at the left and pH 10 at the right, a protein with a high (basic) \(pI\) focuses toward the right edge, while a low (acidic) \(pI\) focuses toward the left. In the second dimension (SDS-PAGE), SDS coats every protein with uniform negative charge density so migration depends only on mass: large proteins are retarded by the gel matrix and stay near the top, while small proteins run far toward the bottom. "Upper-right" therefore demands high mass (top) AND high \(pI\) (right). Only Z satisfies both, with a \(pI\) of 8.6 (right) and a mass of 71 kDa (top).

(Choice A) is correct: Z has \(pI = 8.6\) (basic → focuses right) and mass 71 kDa (large → migrates little, stays near the top), placing it in the upper-right corner.

(Choice B) is incorrect: W is indeed large (68 kDa, so near the top), but its \(pI\) of 4.2 is acidic, so it focuses toward the left (pH 3) edge, not the right. It would appear in the upper-LEFT corner. This choice correctly reads the mass axis but inverts the direction of the pH-gradient axis.

(Choice C) is incorrect: X has a basic \(pI\) (8.9 → focuses right), but at only 15 kDa it is small and would migrate far down the SDS gel to sit near the BOTTOM, not the top. This choice gets the right side correct but reverses the mass–position relationship (small proteins run farther, not less).

(Choice D) is incorrect: Y is both small (14 kDa → near the bottom) and acidic (\(pI = 4.5\) → focuses left), so it would sit in the lower-LEFT corner — the opposite corner from the observed spot on both axes.

At the Skill 2 level, you cannot recall a fact to answer this; you must map each protein''s two measured values onto the two orthogonal separation axes and recognize that the upper-right position is defined by the conjunction of high mass and high \(pI\), then test each candidate against both criteria simultaneously.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'correct mass axis but inverts the pH-gradient direction (acidic pI placed on the basic side)' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'correct pH axis but reverses mass-migration relationship (small protein placed near top instead of bottom)' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'conflates acidic with basic and small with large, mapping both axes backward' FROM q;

-- Q17 [2D Electrophoresis] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', '2D Electrophoresis', 'A proteomics lab is analyzing a cell lysate. On a standard 1D SDS-PAGE gel, two proteins of interest, Protein X and Protein Y, both migrate as a single overlapping band at an apparent molecular weight of 45 kDa. Suspecting the band contains two distinct species, a researcher measures the isoelectric points of the purified proteins and finds pI = 5.2 for Protein X and pI = 8.6 for Protein Y. The lysate is then re-run using two-dimensional gel electrophoresis, in which isoelectric focusing across a pH 3–11 gradient precedes the SDS-PAGE step. Which of the following best describes the expected result for Protein X and Protein Y on the 2D gel, and the reason for it?', '[{"label": "A", "text": "They resolve into two separate spots, because the isoelectric focusing step sorts them to different horizontal positions before the size-based step is run"}, {"label": "B", "text": "They resolve into two separate spots, because the SDS-PAGE step now sorts them by molecular weight into different vertical positions"}, {"label": "C", "text": "They remain a single overlapping spot, because both dimensions ultimately separate proteins on the basis of net charge"}, {"label": "D", "text": "They remain a single overlapping spot, because isoelectric focusing halts each protein only once it reaches the anode"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because the two proteins co-migrate on 1D SDS-PAGE for a single reason: SDS coats proteins with uniform negative charge so that they separate essentially by molecular weight alone, and both are ~45 kDa. Two-dimensional electrophoresis adds a first dimension, isoelectric focusing (IEF), that separates on an entirely independent property—the isoelectric point. In IEF a protein migrates through a pH gradient until it reaches the pH equal to its pI, where its net charge is zero and it stops. Because Protein X (pI 5.2) and Protein Y (pI 8.6) focus at very different points in the pH 3–11 gradient, they are placed at different horizontal positions before SDS-PAGE ever runs. The two dimensions are orthogonal (pI, then mass), so proteins that are identical in one property but differ in the other are pulled apart. Since X and Y differ in pI, they resolve into two separate spots.

(Choice A) is correct: 2D electrophoresis resolves the pair precisely because the added IEF dimension sorts by pI—a property on which X and Y differ—positioning them horizontally before the size step, whereas 1D SDS-PAGE only sorted by the mass they share.

(Choice B) is incorrect: the SDS-PAGE dimension separates by molecular weight, and both proteins are ~45 kDa. That dimension already ran in 1D and failed to split them; adding it again in the second dimension cannot resolve species of equal mass. The resolving power comes from the new pI dimension, not the size dimension.

(Choice C) is incorrect: the two dimensions are not redundant. SDS-PAGE separates by molecular weight (SDS masks intrinsic charge to give uniform charge-to-mass ratio), while IEF separates by pI. Only IEF is charge-related, so it is false that both dimensions separate on net charge; if they did, 2D would add no resolving power over 1D.

(Choice D) is incorrect: in IEF a protein does not stop at an electrode. It migrates until it reaches the position where the gradient pH equals its pI and its net charge becomes zero; a species below its pI is positively charged and moves toward the cathode, not toward the anode. Because X and Y have different pIs, they halt at different focusing positions, which is exactly what allows them to be resolved.

This item is Skill 2 because it does not ask for the definition of 2D electrophoresis; it requires applying the principle that the two dimensions probe independent properties to predict, from given pI and mass data, that proteins sharing mass but differing in pI will be separated by the orthogonal IEF step.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 95)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'attributes the resolution to the size dimension (which the proteins share and which already failed in 1D) rather than the new pI dimension' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes both 2D dimensions separate by charge, missing that SDS-PAGE normalizes charge and separates by mass, so the dimensions are non-orthogonal/redundant' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'thinks IEF stops proteins at an electrode (anode) rather than at the position where pH equals pI' FROM q;

-- Q18 [Ion-Exchange Chromatography] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Ion-Exchange Chromatography', 'A purification protocol calls for capturing a recombinant enzyme (isoelectric point pI = 9.4) directly from a clarified cell lysate. The technician equilibrates a chromatography column and loads the sample in a buffer held at pH 7.4, then washes with several column volumes of the same low-salt buffer. To ensure the enzyme is retained on the resin (rather than washing straight through with the flow-through fraction), which resin should the technician have packed into the column?

A. A resin bearing covalently attached diethylaminoethyl (DEAE) groups, which are protonated and positively charged at pH 7.4
B. A resin bearing covalently attached carboxymethyl (CM) groups, which are deprotonated and negatively charged at pH 7.4
C. A resin bearing covalently attached quaternary ammonium groups, which carry a fixed positive charge at pH 7.4
D. A resin bearing porous, uncharged cross-linked dextran beads that fractionate solutes strictly by hydrodynamic radius', '[{"label": "A", "text": "A resin bearing covalently attached diethylaminoethyl (DEAE) groups, which are protonated and positively charged at pH 7.4"}, {"label": "B", "text": "A resin bearing covalently attached carboxymethyl (CM) groups, which are deprotonated and negatively charged at pH 7.4"}, {"label": "C", "text": "A resin bearing covalently attached quaternary ammonium groups, which carry a fixed positive charge at pH 7.4"}, {"label": "D", "text": "A resin bearing porous, uncharged cross-linked dextran beads that fractionate solutes strictly by hydrodynamic radius"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is B because retention on an ion-exchange resin requires the resin''s fixed charge to be opposite in sign to the protein''s net charge under the loading conditions. The buffer pH of 7.4 lies below the enzyme''s pI of 9.4, so the protein sits on the acidic side of its isoelectric point: its basic groups remain protonated while few acidic groups are ionized, giving the protein a net positive charge. A net-positive protein is retained only by a resin carrying negatively charged groups (a cation exchanger). Carboxymethyl (CM) groups are deprotonated carboxylates and therefore negatively charged at pH 7.4, so a CM resin electrostatically binds the positively charged enzyme and holds it through the low-salt wash.

(Choice A) is incorrect: DEAE groups are positively charged, making this an anion exchanger. A positively charged resin repels a net-positive protein, so the enzyme would not be retained and would appear in the flow-through.

(Choice B) is correct: at pH 7.4 (below pI 9.4) the enzyme is net positive, and the negatively charged CM (carboxylate) groups are the complementary charge needed to retain it.

(Choice C) is incorrect: a quaternary ammonium group carries a fixed positive charge, so this is a strong anion exchanger. Like the DEAE resin, it binds net-negative proteins and would let the net-positive enzyme flow through rather than retaining it.

(Choice D) is incorrect: uncharged porous dextran beads are a size-exclusion (gel-filtration) medium. They separate by molecular size and carry no fixed charge, so they cannot electrostatically capture and retain a target protein during a low-salt wash.

At the Skill 2 level, this question asks you to translate a numerical relationship (buffer pH versus pI) into a predicted net charge, then match that charge to the complementary resin chemistry rather than recalling a memorized resin label.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Reverses the pH-vs-pI charge logic (treats the protein as net negative) or the resin-charge pairing, selecting a positively charged anion exchanger' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Believes ''ion exchanger = positively charged resin binds proteins'' regardless of protein sign; conflates a strong anion exchanger with a general protein-binding resin' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'Confuses ion-exchange retention with size-exclusion; picks a within-scope chromatography medium that cannot retain by charge' FROM q;

-- Q19 [Ion-Exchange Chromatography] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Ion-Exchange Chromatography', 'A biochemist loads a mixture of four purified proteins onto a carboxymethyl (CM) cation-exchange column that has been equilibrated in a pH 6.0 buffer. After the unbound material washes through, the column is developed with a continuous gradient that raises the NaCl concentration from 0 M to 1.0 M. Each protein''s net charge at pH 6.0 and its molecular weight are given below:

| Protein | Net charge at pH 6.0 | Molecular weight (kDa) |
|---------|----------------------|------------------------|
|   W     |        +2            |          64            |
|   X     |        +8            |          18            |
|   Y     |        +4            |          45            |
|   Z     |        +6            |          30            |

Assuming the four proteins bind the resin only through their net charge, which protein requires the highest NaCl concentration to elute and therefore appears in the last collected fraction?', '[{"label": "A", "text": "Protein W"}, {"label": "B", "text": "Protein X"}, {"label": "C", "text": "Protein Y"}, {"label": "D", "text": "Protein Z"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is B because a CM column carries fixed negative groups, so at pH 6.0 the more positively charged a protein is, the more electrostatic contacts it forms with the resin and the more tightly it binds. In a rising-salt gradient, Na\(^+\) ions compete with bound proteins for those negative sites; a weakly bound protein is displaced at low salt, while a strongly bound protein holds on until the salt is high enough to out-compete its many charge contacts. Protein X carries the largest net positive charge (\(+8\)), binds most tightly, and is therefore the last to be released, requiring the highest NaCl concentration.

(Choice A) is incorrect: Protein W has the smallest net charge (\(+2\)), so it forms the fewest contacts with the resin and is displaced by Na\(^+\) at the lowest salt concentration. It elutes first, not last.

(Choice B) is correct: Protein X''s \(+8\) net charge gives it the strongest electrostatic grip on the negatively charged resin, so only the highest salt in the gradient can compete it off, placing it in the final fraction.

(Choice C) is incorrect: Protein Y (\(+4\)) is only intermediate in charge and would elute in a middle fraction. Choosing it likely reflects anchoring on its larger 45 kDa mass, but ion exchange separates by charge, not size, so molecular weight does not set the elution order here.

(Choice D) is incorrect: Protein Z (\(+6\)) binds more tightly than W and Y but still less tightly than X, so it elutes just before X rather than last. Selecting Z treats the second-strongest binder as the last to leave, overlooking that X''s greater charge demands even more salt to displace.

To answer, you had to apply the competitive-elution principle to the supplied charge data and rank the proteins by binding strength rather than recall a definition, which is why this is a Skill 2 (scientific reasoning and problem-solving) item.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Believes the most weakly bound (lowest charge) protein elutes last instead of first, reversing the salt-competition relationship' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Confuses ion-exchange with size-exclusion and orders elution by molecular weight rather than net charge' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'Correctly identifies a strong binder but stops at the second-highest charge, failing to rank all four to find the true maximum' FROM q;

-- Q20 [Size-Exclusion Chromatography] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Size-Exclusion Chromatography', 'A biochemist loads a mixture of four purified proteins onto a size-exclusion column whose beads have a defined pore-size distribution. All four proteins are compact, globular, and behave identically except for their native molecular masses:

- Aldolase: 158 kDa
- Ovalbumin: 44 kDa
- Ribonuclease A: 14 kDa
- Thyroglobulin: 669 kDa

The column is run isocratically, and the eluate is collected in numbered fractions as it leaves the column (fraction 1 first, higher-numbered fractions later). Absorbance at 280 nm is used to detect each protein as a discrete peak. Assuming none of the proteins is large enough to be fully excluded and all resolve as separate peaks, which protein''s peak appears in the earliest-numbered fraction?', '[{"label": "A", "text": "Thyroglobulin, because its large native size keeps it out of the bead interior so it travels the shortest effective path"}, {"label": "B", "text": "Ribonuclease A, because its small native size lets it slip through the column most rapidly"}, {"label": "C", "text": "Ovalbumin, because its intermediate mass balances pore access against mobile-phase flow most efficiently"}, {"label": "D", "text": "Aldolase, because at 158 kDa it is retained least by the aromatic residues that absorb at 280 nm"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because in size-exclusion (gel filtration) chromatography, separation is governed by whether a molecule can access the solvent volume inside the beads'' pores. A large protein like thyroglobulin (669 kDa) is too big to enter most of the pores, so it is confined largely to the mobile phase flowing around the beads. It samples a smaller total volume, traverses the shortest effective path, and therefore elutes first — in the earliest-numbered fraction. Smaller proteins partition into the pore volume, are repeatedly delayed, and elute at progressively larger volumes (later fractions). Reasoning from the stated masses, the descending mass order thyroglobulin (669) > aldolase (158) > ovalbumin (44) > ribonuclease A (14) predicts the elution order, so the largest protein appears first.

(Choice A) is correct: Thyroglobulin is the largest species and is excluded from the interior pore volume, so it flows around the beads and elutes in the smallest volume, i.e., the earliest fraction.

(Choice B) is incorrect: This applies the intuitive but wrong "small molecule = fast" rule. Ribonuclease A, being the smallest, penetrates the pore volume most completely, is delayed the most, and elutes last — in a late-numbered fraction, not the earliest.

(Choice C) is incorrect: There is no "efficiency optimum" at intermediate mass; elution order is monotonic in accessible pore volume, not a balance point. Ovalbumin (44 kDa) elutes third, between aldolase and ribonuclease A, not first.

(Choice D) is incorrect: Absorbance at 280 nm is only a detection method (aromatic side chains), not a retention mechanism; SEC beads are chosen to be inert, so \(A_{280}\) does not determine when a protein elutes. Retention here depends on size-based pore access, not on the detector wavelength.

Applying the concept: recognizing that elution order in SEC runs opposite to the naive "smaller is faster" expectation, and mapping the four stated masses onto accessible pore volume, is what identifies thyroglobulin as the first-eluting peak.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'small-molecules-elute-first (intuitive size reversal)' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'intermediate-mass efficiency optimum instead of monotonic pore-access order' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'conflating detection method (A280) with retention mechanism' FROM q;

-- Q21 [Size-Exclusion Chromatography] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Size-Exclusion Chromatography', 'A biochemist purifies a 45 kDa monomeric enzyme and characterizes it on a size-exclusion column (void volume V_o = 8.0 mL, total volume V_t = 20.0 mL). Detecting eluate at 280 nm, she finds the native enzyme elutes as a single sharp peak centered at 14.0 mL. She then treats an identical amount of the same enzyme with a chaotropic agent that disrupts its tertiary structure without cleaving any peptide bonds, and re-injects it onto the same column equilibrated in that agent. Assuming no adsorption to the resin, which elution volume is the enzyme most likely to show in the second run, and why?', '[{"label": "A", "text": "About 10.5 mL, because disrupting the fold increases the molecule''s Stokes radius and it is now excluded from more of the pore volume"}, {"label": "B", "text": "About 17.0 mL, because the extended chain threads more deeply into the pores and samples a larger fraction of the internal volume"}, {"label": "C", "text": "Still about 14.0 mL, because the polypeptide''s mass is unchanged and mass alone sets the elution volume"}, {"label": "D", "text": "Beyond 20.0 mL, because exposed hydrophobic residues in the unfolded chain adsorb to the beads and retard its passage"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because in size-exclusion (gel filtration) chromatography, a solute''s elution volume is governed by its Stokes (hydrodynamic) radius, which reflects both size and shape, not by mass alone. A compact folded protein occupies a small effective sphere, so it can partition into more of the internal pore volume and elutes at a larger volume. Disrupting the tertiary structure with a chaotropic agent (without breaking peptide bonds) leaves the mass unchanged but unfolds the chain into an extended, more elongated conformation with a substantially larger Stokes radius. A larger \(R_s\) is excluded from more of the pore volume, lowering the partition coefficient \(K\) and shifting the peak toward the void volume \(V_o = 8.0\ \text{mL}\). An elution volume of ~10.5 mL (between \(V_o\) and the native 14.0 mL) is the only choice consistent with an earlier-eluting, larger-radius species.

(Choice A) is correct: unfolding raises \(R_s\), decreases \(K\), and moves elution earlier (toward \(V_o\)), i.e., from 14.0 mL down to ~10.5 mL.

(Choice B) is incorrect: it reverses the relationship. A larger hydrodynamic radius is excluded from more pore volume, not less, so the denatured form cannot elute later (17.0 mL) than the native form; later elution corresponds to a smaller, not larger, effective size.

(Choice C) is incorrect: it invokes the common misconception that mass sets elution order. Elution tracks Stokes radius (size and shape); two species of identical mass but different shape elute at different volumes, so an unchanged mass does not fix the elution volume at 14.0 mL.

(Choice D) is incorrect: the stem specifies no adsorption to the resin, so retardation past \(V_t = 20.0\ \text{mL}\) (which requires noncovalent binding to the matrix) is excluded; ideal size exclusion confines every non-adsorbing solute between \(V_o\) and \(V_t\).

To answer this question, the test-taker must apply the principle that hydrodynamic radius (not mass) determines gel-filtration behavior to a new scenario, predicting that a denaturation-induced increase in Stokes radius shifts the peak earlier toward the void volume.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'larger radius mistakenly mapped to deeper pore penetration and later elution' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'belief that molecular mass alone (not shape/Stokes radius) governs SEC elution' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'matrix adsorption/beyond-Vt elution applied despite explicit no-adsorption condition' FROM q;

-- Q22 [Affinity Chromatography] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Affinity Chromatography', 'A researcher lyses bacteria that overexpress a recombinant enzyme and loads the clarified lysate onto a column packed with nitrilotriacetic-acid resin that has been charged with Ni²⁺. After the sample fully enters the resin, the column is washed with several bed volumes of binding buffer (pH 8.0, 20 mM imidazole). Four abundant proteins in the lysate have the following properties:

| Protein | Fusion tag present | Net charge at pH 8.0 | Molecular weight |
|---------|-------------------|----------------------|------------------|
| W | FLAG peptide (DYKDDDDK) | −6 | 28 kDa |
| X | six consecutive His residues | +2 | 45 kDa |
| Y | none | −11 | 92 kDa |
| Z | glutathione S-transferase | +4 | 26 kDa |

Assuming each tag folds and is solvent-exposed, which protein is expected to remain bound to the resin after the wash step is complete?', '[{"label": "A", "text": "Protein W"}, {"label": "B", "text": "Protein X"}, {"label": "C", "text": "Protein Y"}, {"label": "D", "text": "Protein Z"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is B because the resin presents an immobilized Ni²⁺ ion held by nitrilotriacetic acid, and this metal center is the specific ligand that retains protein. Retention on this column requires a functional group that can coordinate the immobilized Ni²⁺, and a run of consecutive histidine residues supplies exactly that: the imidazole side chains chelate the nickel. Protein X carries six consecutive His residues, so it is the only species that forms a direct coordinate interaction with the immobilized ligand and stays on the resin while the wash buffer carries everything else through. The other proteins lack a group that binds the nickel center, so their charge, size, or unrelated tags do not keep them on the column.

(Choice A) is incorrect: the FLAG peptide (DYKDDDDK) binds an anti-FLAG antibody resin, not an immobilized-metal resin. On Ni²⁺-charged resin the FLAG tag has no group that coordinates nickel, so protein W flows through with the wash.

(Choice B) is correct: the six-histidine run coordinates the immobilized Ni²⁺ through the imidazole side chains, which is precisely the ligand-specific interaction this resin is built to capture, so protein X is retained.

(Choice C) is incorrect: a large, highly acidic protein would bind an anion-exchange resin because of its net charge, but net charge does not create affinity for an immobilized Ni²⁺ center. Its size (92 kDa) is likewise irrelevant on an affinity resin, so protein Y washes through.

(Choice D) is incorrect: the glutathione S-transferase tag is captured by an immobilized-glutathione resin, not by a nickel-charged resin. Because GST offers no imidazole-rich metal-coordinating surface, protein Z does not bind the nickel ligand and elutes in the wash.

Skill 2 note: rather than recalling a definition, you had to map the physical retention mechanism of the column (coordination of an immobilized metal ion) onto the one protein whose tag chemistry actually engages that ligand, while recognizing that charge, mass, and mismatched tags are properties this particular resin does not select on.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 2, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'tag_present_implies_binding' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'charge_or_size_confused_with_affinity' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'correct_tag_wrong_matching_ligand' FROM q;

-- Q23 [Affinity Chromatography] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Affinity Chromatography', 'A researcher purifies a recombinant esterase on an affinity column whose beads carry a covalently attached small-molecule inhibitor that occupies the enzyme''s active site. After the sample is loaded and contaminants are washed away, the bound esterase is split across four identical columns, and a different elution buffer is applied to each. The researcher measures the amount of protein recovered from each column and the specific activity (units of esterase activity per milligram) of that recovered protein:

Column 1 — buffer at pH 2.5: 95% of protein recovered; specific activity 4 U/mg
Column 2 — buffer containing 6 M guanidinium chloride: 97% of protein recovered; specific activity 2 U/mg
Column 3 — buffer with a high concentration of the same free inhibitor added: 88% of protein recovered; specific activity 210 U/mg
Column 4 — buffer with elevated NaCl (1 M): 15% of protein recovered; specific activity 205 U/mg

The researcher needs the largest possible quantity of catalytically active esterase. Which elution condition best meets this goal, and why?', '[{"label": "A", "text": "Column 3, because saturating the buffer with free inhibitor competes the enzyme off its active-site tether while leaving the folded structure intact"}, {"label": "B", "text": "Column 1, because protonation at pH 2.5 releases nearly all of the bound enzyme, giving the highest total recovery of usable protein"}, {"label": "C", "text": "Column 2, because guanidinium chloride recovers the most protein and its denaturing action strips the enzyme cleanly from the column"}, {"label": "D", "text": "Column 4, because raising the ionic strength disrupts the interaction without the harshness of low pH or denaturants, preserving activity"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because the goal is the largest quantity of *active* enzyme, which is the product of how much protein comes off the column and how much of that protein is still catalytically competent (its specific activity). The bead-attached ligand is an active-site inhibitor, so the enzyme is held by the same specific interaction that a free inhibitor molecule would make. Flooding the column with excess free inhibitor sets up a competition: free ligand in solution mass-competes the enzyme off the immobilized ligand, releasing it under mild, non-denaturing conditions. Column 3 recovers 88% of the protein at 210 U/mg — by far the highest activity per milligram — so the total active yield (recovery × specific activity) is the greatest of the four options. The competitive strategy displaces the target while leaving its native fold, and therefore its catalytic site, intact.

(Choice A) is correct: competitive elution with excess free ligand releases the enzyme by out-competing the immobilized ligand for the active site, a gentle process that leaves the protein folded and active (210 U/mg), and the 88% recovery keeps the total active yield high.

(Choice B) is incorrect: pH 2.5 does strip nearly all the protein off (95%), but the specific activity collapses to 4 U/mg. Extreme low pH disrupts the folded structure of most enzymes, so although the mass recovery is high, almost none of the recovered protein is catalytically active — high protein yield is not the same as high active yield.

(Choice C) is incorrect: 6 M guanidinium chloride is a chaotropic denaturant. It efficiently removes protein (97%) precisely because it unfolds the enzyme and thereby destroys the binding interaction, but the same unfolding destroys the active site (2 U/mg). Maximizing protein recovered while sacrificing structure defeats the stated goal of recovering active enzyme.

(Choice D) is incorrect: raising ionic strength preserves activity (205 U/mg) but is the wrong lever for an affinity interaction based on a specific active-site fit rather than on ionic attraction. That is why only 15% of the protein is recovered — most stays stuck to the column. High salt is the elution mechanism for ion-exchange (charge-based) resins, not for a ligand that binds a defined structural pocket, so the total active yield is low.

To recover the most active protein, you must reason across both columns of data at once — combining recovery with per-milligram activity to judge total active yield — rather than optimizing either number alone.', 'hard', '5C', 'Separations and Purifications', 'biochemistry', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'partial_truth', 'conflates high protein recovery with high active-protein recovery, ignoring that low-pH elution denatures' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'treats maximal protein stripping by a denaturant as success, overlooking loss of native structure/activity' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'imports the ion-exchange elution mechanism (raise ionic strength) into an affinity/active-site context' FROM q;

-- Q24 [Multi-Step Purification] medium skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Non-enzymatic Protein Function and Protein Analysis', 'Multi-Step Purification', 'A researcher purifying an enzyme monitors purification level (fold-increase in specific activity relative to the crude lysate) after each step. Cation-exchange chromatography is run first and improves the purification level from 1 to 12. The researcher then runs the pooled active fractions over a second, identical cation-exchange column under the same buffer and gradient conditions, and observes the following:

  Step 1 — Crude lysate: purification level = 1
  Step 2 — Cation exchange #1: purification level = 12
  Step 3 — Cation exchange #2 (identical column): purification level = 13

A colleague suggests replacing the second cation-exchange step with size-exclusion chromatography, after which the purification level rises to 47. Which statement best accounts for the negligible improvement contributed by the second cation-exchange column compared with the size-exclusion column?', '[{"label": "A", "text": "Contaminants that co-eluted with the enzyme in the first step share its net charge, so a second charge-based separation cannot resolve them, whereas size-exclusion sorts on an unrelated property."}, {"label": "B", "text": "Running a column twice denatures the enzyme, lowering its specific activity and masking any purity gain the second identical column would otherwise provide."}, {"label": "C", "text": "The second cation-exchange column had already reached its binding capacity, so no additional target protein could adsorb and be concentrated during that step."}, {"label": "D", "text": "Size-exclusion resolves proteins by charge more finely than ion exchange does, so it simply repeats the first separation with higher resolution."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Separations and Purifications.''

The answer is A because each chromatographic method resolves proteins on one specific physical property, and any contaminant that behaves like the target on that property will co-elute with it. The first cation-exchange step already removed proteins whose net charge differed from the enzyme''s; the contaminants that remain are precisely those that share the enzyme''s charge behavior. Running a second, identical charge-based column separates on that same property again, so those co-charged contaminants elute together with the target once more and the purification level barely moves (12 to 13). Size-exclusion, by contrast, sorts on size/shape, a property independent of charge. Contaminants that are indistinguishable from the enzyme by charge are generally distinguishable by size, so the orthogonal step removes them and the purification level jumps to 47. This is the core rationale for combining orthogonal methods: each new step attacks a property the previous steps could not.

(Choice A) is correct: it identifies that the residual contaminants co-elute because they share the target''s charge, and that an independent (orthogonal) property is needed to resolve them — exactly why the size-exclusion step succeeds where the repeated charge step fails.

(Choice B) is incorrect: while denaturation can lower specific activity, the data show the purification level rose slightly (12 to 13) rather than falling, and the subsequent size-exclusion step reached 47 using the same pooled material, so the enzyme clearly remained active. Denaturation does not explain why a repeated charge separation is intrinsically ineffective.

(Choice C) is incorrect: binding capacity governs how much protein a column can hold, not the purity achieved. Even with unlimited capacity, a second charge-based column would still fail to separate contaminants that share the target''s charge, so capacity is not the limiting factor here.

(Choice D) is incorrect: size-exclusion separates by size/shape (molecular weight), not by charge, and it does not repeat the ion-exchange separation. This choice reverses the actual basis of separation and would predict no improvement, contradicting the jump to 47.

This is a Skill 1 (Knowledge of Scientific Concepts) question: it asks you to recognize the foundational principle that orthogonal purification steps separate on independent properties, and to apply that principle to interpret why a repeated method stalls while a complementary method advances purity.', 'medium', '5C', 'Separations and Purifications', 'biochemistry', 1, 90)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'attributes_stalled_purity_to_denaturation_rather_than_shared_property' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'confuses_binding_capacity_with_resolving_power' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'misassigns_size_exclusion_separation_basis_to_charge' FROM q;

