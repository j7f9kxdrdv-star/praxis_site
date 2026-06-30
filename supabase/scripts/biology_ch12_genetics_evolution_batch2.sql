-- Biology Ch12: Genetics and Evolution — BATCH 2 (Crosses, Sex-Linkage, Pedigrees, Gene Mapping)
-- Safe to re-run: deletes only this batch's subtopics, then re-inserts.

DELETE FROM questions WHERE topic = 'Genetics and Evolution' AND subtopic IN ('Punnett Squares & Monohybrid Crosses', 'Dihybrid & Test Crosses', 'Sex-Linked Inheritance & Pedigrees', 'Gene Mapping & Recombination');

-- Q1 [Punnett Squares & Monohybrid Crosses] easy skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Punnett Squares & Monohybrid Crosses', 'A geneticist self-crosses two pea plants that are each heterozygous for seed color \(\left(Aa \times Aa\right)\), where the yellow allele \(\left(A\right)\) is completely dominant to the green allele \(\left(a\right)\). Among a large number of offspring, the expected ratio of yellow-seeded to green-seeded plants is closest to which value?', '[{"label": "A", "text": "A \\(3{:}1\\) ratio"}, {"label": "B", "text": "A \\(1{:}2{:}1\\) ratio"}, {"label": "C", "text": "A \\(1{:}1\\) ratio"}, {"label": "D", "text": "An all-yellow ratio"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is A because a \(2 \times 2\) Punnett square for \(Aa \times Aa\) yields offspring genotypes in a \(YY{:}Yy{:}yy\)-style ratio of \(1{:}2{:}1\), but because the dominant \(A\) allele masks the recessive \(a\) allele, the three \(A\_\) offspring (\(\tfrac{1}{4}\,AA + \tfrac{2}{4}\,Aa\)) all show the yellow phenotype while only the \(\tfrac{1}{4}\,aa\) offspring show green. Summing the dominant classes gives \(\tfrac{3}{4}\) yellow to \(\tfrac{1}{4}\) green, a \(3{:}1\) phenotypic ratio, exactly the outcome the textbook reports: "we expect the offspring to exhibit a phenotypic ratio of 3 yellow:1 green." (Choice A) is correct: the \(\tfrac{3}{4}\) dominant to \(\tfrac{1}{4}\) recessive split reduces to \(3{:}1\). (Choice B) is the genotypic ratio of this same cross (\(1\,AA : 2\,Aa : 1\,aa\)), which is correct for genotypes but not for phenotypes under complete dominance, since \(AA\) and \(Aa\) look identical. (Choice C) is the \(1{:}1\) ratio produced by a test cross of a heterozygote against a homozygous recessive (\(Aa \times aa\)), not by a heterozygote self-cross. (Choice D) describes the F1 result of crossing two true-breeding parents (\(AA \times aa\)), where all offspring are \(Aa\) and yellow, not the segregating F2 self-cross. This is a Scientific Reasoning and Problem Solving question because you must apply the rules of allele segregation and the sum rule of probability to a Punnett square to predict a phenotypic ratio.', 'easy', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', NULL FROM q;

-- Q2 [Punnett Squares & Monohybrid Crosses] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Punnett Squares & Monohybrid Crosses', 'In guinea pigs, black coat color (B) is completely dominant to white (b). A breeder crosses a black guinea pig of unknown genotype to a white guinea pig and, across a large litter, observes that roughly half the offspring are black and half are white. The genotype of the black parent is most likely best described as which of the following?', '[{"label": "A", "text": "Homozygous dominant, \\(BB\\)"}, {"label": "B", "text": "Heterozygous, \\(Bb\\)"}, {"label": "C", "text": "Homozygous recessive, \\(bb\\)"}, {"label": "D", "text": "Heterozygous, predicting a \\(3{:}1\\) ratio"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is B because the white parent is homozygous recessive (\(bb\)) and can donate only a recessive \(b\) allele, so each offspring''s phenotype is determined by the allele it inherits from the black parent. The textbook states that in a test cross to a homozygous recessive organism, "if the dominant expressing organism is a heterozygote, the F1 offspring will exhibit a 1:1 ratio of heterozygotes and recessive homozygotes" (OpenStax Biology 2e, lines 14844-14845). Observing a roughly \(1{:}1\) split of black to white offspring therefore implies the black parent must be heterozygous, \(Bb\). (Choice A) is incorrect: the text notes that if the dominant-expressing organism is a homozygote, "then all F1 offspring will be heterozygotes expressing the dominant trait" (lines 14843-14844), so a \(BB\) parent would yield all black offspring, not a \(1{:}1\) split. (Choice B) is correct: a \(1{:}1\) phenotypic ratio from a cross to a homozygous recessive tester is the diagnostic signature of a heterozygous \(Bb\) parent (lines 14844-14845). (Choice C) is incorrect: a \(bb\) animal is homozygous recessive and would express the white phenotype, not black, so the black parent cannot be \(bb\) (lines 14777-14778). (Choice D) is incorrect: the \(3{:}1\) ratio arises from a cross between two heterozygotes (a monohybrid self-cross), where offspring segregate "in a 3:1 ratio" (line 15226), whereas a heterozygote crossed to a homozygous recessive tester yields \(1{:}1\), not \(3{:}1\). This is a Scientific Reasoning and Problem Solving question because you must apply test-cross logic in reverse, using an observed offspring ratio to deduce an unknown parental genotype.', 'easy', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', NULL FROM q;

-- Q3 [Punnett Squares & Monohybrid Crosses] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Punnett Squares & Monohybrid Crosses', 'In pea plants, yellow seed color \(Y\) is completely dominant to green \(y\). A breeder self-crosses a heterozygous yellow-seeded plant, and the resulting offspring fill the Punnett square below. Based on the box frequencies, the probability that any single offspring is homozygous recessive is most likely:

| \(Yy \times Yy\) | \(Y\) | \(y\) |
|---|---|---|
| \(Y\) | \(YY\) | \(Yy\) |
| \(y\) | \(Yy\) | \(yy\) |', '[{"label": "A", "text": "\\(\\tfrac{1}{2}\\)"}, {"label": "B", "text": "\\(\\tfrac{3}{4}\\)"}, {"label": "C", "text": "\\(\\tfrac{1}{4}\\)"}, {"label": "D", "text": "\\(\\tfrac{1}{16}\\)"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is C because the homozygous recessive genotype \(yy\) occupies exactly one of the four equally likely boxes in the \(Yy \times Yy\) Punnett square, giving a probability of \(\tfrac{1}{4}\). A self-cross of a heterozygote produces the four combinations \(YY\), \(Yy\), \(yY\), and \(yy\) in a \(1{:}2{:}1\) genotypic ratio, and "because each possibility is equally likely, genotypic ratios can be determined from a Punnett square" (OpenStax Biology 2e, lines 14809-14817). Counting the single \(yy\) box out of the four boxes yields \(\tfrac{1}{4}\); equivalently, the recessive allele must come from both gametes, \(\tfrac{1}{2} \times \tfrac{1}{2} = \tfrac{1}{4}\). (Choice A) \(\tfrac{1}{2}\) counts only one parent contributing a recessive allele and forgets that both gametes must carry \(y\); the \(\tfrac{1}{2}\) is the chance a single gamete is recessive, not the chance the zygote is \(yy\). (Choice B) \(\tfrac{3}{4}\) is the dominant (yellow) phenotypic proportion from the "ratio of 3 yellow:1 green" (lines 14817-14819), not the homozygous recessive frequency. (Choice C) is correct: the lone \(yy\) box is 1 of 4 equally likely outcomes, so the probability is \(\tfrac{1}{4}\). (Choice D) \(\tfrac{1}{16}\) results from squaring the single-gene answer as if two independent genes were both homozygous recessive, \(\tfrac{1}{4} \times \tfrac{1}{4} = \tfrac{1}{16}\) (line 15282), which applies to a dihybrid double-recessive, not this monohybrid cross. This is a Scientific Reasoning and Problem Solving question because you must apply the rules of probability to a Punnett square and read the homozygous recessive box frequency from the cross.', 'medium', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', NULL FROM q;

-- Q4 [Punnett Squares & Monohybrid Crosses] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Punnett Squares & Monohybrid Crosses', 'A geneticist crosses a true-breeding tall pea plant \((TT)\) with a true-breeding short pea plant \((tt)\), where tall is completely dominant. The Punnett square below summarizes the gametes and the F1 zygotes produced.

| \(\times\) | \(T\) | \(T\) |
|---|---|---|
| \(t\) | \(Tt\) | \(Tt\) |
| \(t\) | \(Tt\) | \(Tt\) |

Based on these results, the F1 generation is expected to show which of the following?', '[{"label": "A", "text": "A \\(3{:}1\\) ratio of tall to short"}, {"label": "B", "text": "A \\(1{:}2{:}1\\) ratio of genotypes"}, {"label": "C", "text": "All intermediate, blending the parental heights"}, {"label": "D", "text": "All heterozygous, all expressing the dominant phenotype"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is D because each true-breeding parent can contribute only one kind of allele to its gametes: the \(TT\) parent makes only \(T\) gametes and the \(tt\) parent makes only \(t\) gametes. As the Punnett square shows, every one of the four zygote boxes is \(Tt\), so the F1 is uniformly heterozygous; because tall is completely dominant, all F1 plants are tall. The textbook states this directly: "For a monohybrid cross of two true-breeding parents, each parent contributes one type of allele. In this case, only one genotype is possible. All offspring are Yy and have yellow seeds." (Choice A) A \(3{:}1\) ratio of dominant to recessive is the phenotypic ratio of the F2 generation, produced only when the heterozygous F1 plants self-fertilize ("the offspring to exhibit a phenotypic ratio of 3 yellow:1 green"); it does not appear in the F1 of a true-breeding cross. (Choice B) A \(1{:}2{:}1\) ratio of genotypes is the F2 genotypic ratio ("a ratio of YY:Yy:yy genotypes of 1:2:1"), again requiring an F1 self-cross, not the P-to-F1 cross shown. (Choice C) is the blending-theory prediction, which Mendel disproved: "the white flower trait in the F1 generation had completely disappeared" rather than producing intermediate offspring. (Choice D) is correct: all four boxes are \(Tt\), so the F1 is entirely heterozygous and entirely tall, exactly as the textbook describes for a true-breeding monohybrid cross. This is a Scientific Reasoning and Problem Solving question because you must apply the law of segregation and the rules of the Punnett square to reason from the cross table to the genotype and phenotype of the F1 generation.', 'medium', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', NULL FROM q;

-- Q5 [Punnett Squares & Monohybrid Crosses] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Punnett Squares & Monohybrid Crosses', 'In pea plants, round seeds \((R)\) are dominant to wrinkled seeds \((r)\). A breeder crosses a heterozygous round-seeded plant with a wrinkled-seeded plant \((Rr \times rr)\). For any single offspring of this cross, the probability that the seed is round is closest to:', '[{"label": "A", "text": "\\(\\tfrac{1}{2}\\)"}, {"label": "B", "text": "\\(\\tfrac{3}{4}\\)"}, {"label": "C", "text": "\\(1\\)"}, {"label": "D", "text": "\\(\\tfrac{1}{4}\\)"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is A because a test cross between a heterozygote and a homozygous recessive parent yields a \(1{:}1\) phenotypic ratio. The heterozygous parent \((Rr)\) produces \(R\) and \(r\) gametes in equal proportion, while the wrinkled parent \((rr)\) can only contribute \(r\); combining these gives offspring genotypes \(\tfrac{1}{2}\,Rr\) (round) and \(\tfrac{1}{2}\,rr\) (wrinkled), so the probability of the dominant round phenotype is \(\tfrac{1}{2}\). The textbook states that when the dominant-expressing organism is a heterozygote, "the F1 offspring will exhibit a 1:1 ratio of heterozygotes and recessive homozygotes (Figure 12.5)." (Choice A) is correct: \(\tfrac{1}{2}\) of offspring are \(Rr\) and show the dominant round phenotype. (Choice B) \(\tfrac{3}{4}\) is the dominant-phenotype fraction from a monohybrid self-cross \((Rr \times Rr)\), which gives the \(3{:}1\) ratio of the F2 generation — not the \(1{:}1\) ratio of a test cross. (Choice C) \(1\) is the result only if the round parent were homozygous dominant \((RR)\), since then "all F1 offspring will be heterozygotes expressing the dominant trait." (Choice D) \(\tfrac{1}{4}\) is the fraction of homozygous recessive (wrinkled) offspring in an \(Rr \times Rr\) cross, which describes the recessive phenotype rather than the dominant one in the wrong cross. This is a Scientific Reasoning and Problem Solving question because you must apply the law of segregation to a defined test cross and compute the offspring phenotype probability.', 'medium', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', NULL FROM q;

-- Q6 [Punnett Squares & Monohybrid Crosses] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Punnett Squares & Monohybrid Crosses', 'A pea plant heterozygous for seed color \((Yy)\), where yellow \((Y)\) is completely dominant to green \((y)\), is self-crossed. Considering the \(2 \times 2\) Punnett square for this cross, what is the probability that a given offspring has specifically the heterozygous genotype \((Yy)\)?', '[{"label": "A", "text": "\\(\\tfrac{1}{4}\\)"}, {"label": "B", "text": "\\(\\tfrac{1}{2}\\)"}, {"label": "C", "text": "\\(\\tfrac{3}{4}\\)"}, {"label": "D", "text": "\\(\\tfrac{1}{3}\\)"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is B because a \(Yy \times Yy\) self-cross produces a \(2 \times 2\) Punnett square with four equally likely boxes — \(YY\), \(Yy\), \(yY\), and \(yy\) — and two of those four boxes are heterozygous \((Yy)\). The textbook notes "there are two ways to obtain the Yy genotype: a Y from the egg and a y from the sperm, or a y from the egg and a Y from the sperm. Both of these possibilities must be counted," yielding a genotypic "ratio of YY:Yy:yy genotypes of 1:2:1." Computing the probability: \(\tfrac{2}{4} = \tfrac{1}{2}\). The key trap is that the question asks for a specific genotype, not the dominant phenotype, so the \(3{:}1\) phenotypic ratio does not apply here. (Choice A) \(\tfrac{1}{4}\) counts only one heterozygous box (or is the probability of \(YY\) alone, or of \(yy\) alone), forgetting that two of the four boxes are \(Yy\). (Choice B) is correct: two of the four equally likely boxes are \(Yy\), so \(\tfrac{2}{4} = \tfrac{1}{2}\). (Choice C) \(\tfrac{3}{4}\) is the probability of the dominant yellow phenotype (the \(3{:}1\) phenotypic ratio: "we expect the offspring to exhibit a phenotypic ratio of 3 yellow:1 green"), which combines \(YY\) and \(Yy\) rather than isolating the heterozygote. (Choice D) \(\tfrac{1}{3}\) wrongly treats the three distinct genotypes as equally likely, dividing one outcome by three categories instead of two heterozygous boxes by four equally likely boxes. This is a Scientific Reasoning and Problem Solving question because you must apply the Punnett square and the rules of probability to a self-cross to compute a specific genotypic probability rather than recall a phenotypic ratio.', 'hard', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', NULL FROM q;

-- Q7 [Punnett Squares & Monohybrid Crosses] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Punnett Squares & Monohybrid Crosses', 'A botanist crosses a true-breeding pea plant with inflated pods and a true-breeding plant with constricted pods. The entire F1 generation has inflated pods, but when the F1 plants self-fertilize, roughly one-quarter of the F2 plants have constricted pods. Which of the following accounts for the absence of constricted pods in the F1 and their reappearance in the F2?', '[{"label": "A", "text": "Pod alleles blended, then unblended in F2"}, {"label": "B", "text": "A new constricted mutation arose in F2"}, {"label": "C", "text": "Heterozygous F1 masked the recessive allele"}, {"label": "D", "text": "Incomplete dominance produced an F2 intermediate"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is C because the constricted-pod trait is recessive: the true-breeding parents are \(II\) (inflated) and \(ii\) (constricted), so every F1 plant is heterozygous \(Ii\), in which the dominant inflated allele masks the recessive allele and produces a uniformly inflated phenotype. When two \(Ii\) heterozygotes self-fertilize, the F2 Punnett square yields a \(1{:}2{:}1\) genotypic ratio (\(\tfrac{1}{4}\,II : \tfrac{1}{2}\,Ii : \tfrac{1}{4}\,ii\)) and a \(3{:}1\) phenotypic ratio, so the \(\tfrac{1}{4}\) of F2 plants that are homozygous recessive \(ii\) are the ones in which the constricted trait reappears. The textbook states that recessive traits "become latent, or disappear, in the offspring of a hybridization" but "reappear in the progeny of the hybrid offspring," and that "the traits of the recessive allele will only be observed in homozygous recessive individuals." (Choice C) is correct: the recessive allele was hidden in the heterozygous F1 and is expressed only when two recessive alleles reunite in the \(ii\) F2 homozygotes. (Choice A) invokes the blending theory, which Mendel''s results specifically disproved; reappearance of the unchanged recessive trait shows the alleles "remained separate (not blended)" in the F1. (Choice B) is wrong because no new mutation is needed; the recessive allele was carried silently through the heterozygous F1 and simply became homozygous in one-quarter of the F2. (Choice D) describes incomplete dominance, which would have produced an intermediate phenotype in the F1 rather than a uniformly inflated one, and a \(1{:}2{:}1\) phenotypic ratio in the F2 rather than the observed reappearance of the parental constricted phenotype. This is a Scientific Reasoning and Problem Solving question because you must apply Mendel''s law of segregation to a cross outcome and reason from the F1/F2 phenotypes back to the genotypic basis of the trait''s disappearance and reappearance.', 'hard', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', NULL FROM q;

-- Q8 [Dihybrid & Test Crosses] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Dihybrid & Test Crosses', 'A pea plant heterozygous for both seed color and seed texture \((YyRr)\) is self-crossed, and the two genes assort independently. Among a large number of \(F_2\) offspring, the four seed phenotypes are expected to appear in which ratio?', '[{"label": "A", "text": "\\(12{:}3{:}1\\)"}, {"label": "B", "text": "\\(1{:}2{:}1\\)"}, {"label": "C", "text": "\\(3{:}1\\)"}, {"label": "D", "text": "\\(9{:}3{:}3{:}1\\)"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is D because a self-cross of a doubly heterozygous \(YyRr\) parent, with the two genes assorting independently, produces a \(9{:}3{:}3{:}1\) phenotypic ratio among the \(F_2\) offspring. Each \(YyRr\) parent forms four equally likely gametes (\(YR\), \(Yr\), \(yR\), \(yr\)), and arranging these on a \(4\times4\) Punnett square gives 16 equally likely genotypic combinations that resolve into four phenotypes: \(9\) round/yellow, \(3\) round/green, \(3\) wrinkled/yellow, and \(1\) wrinkled/green. This works because each trait pair independently follows its own \(3{:}1\) ratio, and applying the product rule gives \(\tfrac{3}{4}\times\tfrac{3}{4}=\tfrac{9}{16}\) for the double-dominant class and \(\tfrac{1}{4}\times\tfrac{1}{4}=\tfrac{1}{16}\) for the double-recessive class. (Choice A) \(12{:}3{:}1\) is the dominant-epistasis ratio (e.g., the \(WwYy\times WwYy\) summer-squash cross), which arises only when one gene masks the other; here the two genes do not interact. (Choice B) \(1{:}2{:}1\) is the genotypic ratio of a single-gene monohybrid \(F_2\) (homozygous dominant : heterozygous : homozygous recessive), not the phenotypic ratio of a two-gene cross. (Choice C) \(3{:}1\) is what you get if you collapse the cross to a single trait pair; the full \(9{:}3{:}3{:}1\) ratio is the product of two such \(3{:}1\) ratios, not just one. (Choice D) is correct: independent assortment of two heterozygous gene pairs yields the classic \(9{:}3{:}3{:}1\) dihybrid phenotypic ratio. This is a Scientific Reasoning and Problem Solving question because you must apply Mendel''s law of independent assortment and the product rule to compute the expected \(F_2\) phenotypic distribution of a dihybrid self-cross.', 'easy', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', NULL FROM q;

-- Q9 [Dihybrid & Test Crosses] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Dihybrid & Test Crosses', 'A breeder self-crosses pea plants that are heterozygous for two independently assorting genes, where round seed shape \((R)\) is dominant to wrinkled \((r)\) and yellow color \((Y)\) is dominant to green \((y)\). The cross and its single-gene probabilities are summarized below. Based on the product rule, what fraction of the \(F_2\) offspring is expected to be both round and yellow?

| Cross: \(RrYy \times RrYy\) | Round | Wrinkled |
|---|---|---|
| Single-gene ratio (each gene) | \(\tfrac{3}{4}\) | \(\tfrac{1}{4}\) |
| | Yellow | Green |
| Single-gene ratio (each gene) | \(\tfrac{3}{4}\) | \(\tfrac{1}{4}\) |', '[{"label": "A", "text": "\\(\\tfrac{9}{16}\\)"}, {"label": "B", "text": "\\(\\tfrac{3}{16}\\)"}, {"label": "C", "text": "\\(\\tfrac{1}{16}\\)"}, {"label": "D", "text": "\\(\\tfrac{3}{4}\\)"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is A because the two genes assort independently, so the probability of both dominant phenotypes is the product of the two single-gene probabilities. The textbook states that, collapsing the \(9{:}3{:}3{:}1\) dihybrid ratio into two \(3{:}1\) ratios, "three quarters of the F2 generation offspring would be round" and "three quarters of the F2 offspring would be yellow," and "the proportion of round and yellow F2 offspring is expected to be (3/4) × (3/4) = 9/16." Reading the round (\(\tfrac{3}{4}\)) and yellow (\(\tfrac{3}{4}\)) probabilities from the table and multiplying gives \(\tfrac{3}{4} \times \tfrac{3}{4} = \tfrac{9}{16}\), the round-and-yellow class of the \(9{:}3{:}3{:}1\) ratio. (Choice A) is correct: \(\tfrac{3}{4} \times \tfrac{3}{4} = \tfrac{9}{16}\) is exactly the both-dominant proportion the product rule yields. (Choice B) \(\tfrac{3}{16}\) results from multiplying one dominant probability by one recessive probability, \(\tfrac{3}{4} \times \tfrac{1}{4}\) — the proportion of an offspring showing one dominant and one recessive trait (e.g., round, green), not both dominant. (Choice C) \(\tfrac{1}{16}\) results from multiplying both recessive probabilities, \(\tfrac{1}{4} \times \tfrac{1}{4}\), which is the wrinkled-and-green (both-recessive) class. (Choice D) \(\tfrac{3}{4}\) is the single-gene probability for one trait alone (e.g., round) and ignores the second gene; failing to apply the product rule across both genes leaves only the monohybrid \(3{:}1\) result. This is a Scientific Reasoning and Problem Solving question because you must apply the product rule to the tabulated single-gene probabilities to compute the combined two-gene phenotype frequency.', 'medium', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', NULL FROM q;

-- Q10 [Dihybrid & Test Crosses] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Dihybrid & Test Crosses', 'In pea plants, round seeds \(R\) are dominant to wrinkled seeds \(r\). A breeder crosses a plant with round seeds and an unknown genotype to a wrinkled-seeded plant, and all 40 resulting offspring have round seeds. Based on this result, the breeder concludes that the round-seeded parent most likely has which genotype?', '[{"label": "A", "text": "Heterozygous \\(Rr\\)"}, {"label": "B", "text": "Homozygous dominant \\(RR\\)"}, {"label": "C", "text": "Homozygous recessive \\(rr\\)"}, {"label": "D", "text": "Hemizygous for \\(R\\)"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is B because in a test cross the dominant-expressing plant is crossed to a homozygous recessive \(rr\) partner, which can only contribute an \(r\) gamete; the offspring phenotypes therefore reveal the unknown parent''s gametes directly. The textbook states that if the dominant-expressing organism is a homozygote, then all F1 offspring will be heterozygotes expressing the dominant trait, whereas a heterozygote would yield a \(1{:}1\) ratio of dominant to recessive offspring. Working the cross: \(RR \times rr\) gives all \(Rr\) (100% round), while \(Rr \times rr\) gives \(\tfrac{1}{2}\) \(Rr\) (round) and \(\tfrac{1}{2}\) \(rr\) (wrinkled); since all 40 offspring are round with no wrinkled ones appearing, the data point to \(RR\). (Choice A) is incorrect because a heterozygous \(Rr\) parent would have produced an expected \(1{:}1\) ratio with about half the offspring wrinkled, which was not observed. (Choice B) is correct: only a homozygous dominant \(RR\) parent supplies \(R\) to every gamete, so every test-cross offspring receives \(R\) and shows the round phenotype. (Choice C) is incorrect because a homozygous recessive \(rr\) parent would itself have wrinkled seeds, contradicting the stated round phenotype of the tested parent. (Choice D) is incorrect because hemizygosity applies to genes on the X chromosome where one sex has a single allele copy, not to an autosomal seed-shape gene in a pea plant. This is a Scientific Reasoning and Problem Solving question because you must apply test-cross logic to the offspring data and reason backward from the all-dominant phenotype ratio to the parent''s genotype.', 'medium', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', NULL FROM q;

-- Q11 [Dihybrid & Test Crosses] easy skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Dihybrid & Test Crosses', 'A breeder crosses a pea plant that has round seeds (round is dominant to wrinkled) with a plant that has wrinkled seeds, and the resulting offspring show round and wrinkled seeds in roughly equal numbers. This result most likely indicates that the round-seeded parent has which genotype?', '[{"label": "A", "text": "Homozygous dominant, \\(RR\\)"}, {"label": "B", "text": "Homozygous recessive, \\(rr\\)"}, {"label": "C", "text": "Heterozygous, \\(Rr\\)"}, {"label": "D", "text": "Hemizygous for round, \\(R\\)"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is C because crossing the round-seeded plant with a wrinkled (homozygous recessive, \(rr\)) plant is a test cross, and a roughly \(1{:}1\) ratio of dominant to recessive offspring is the signature of a heterozygous, dominant-expressing parent. A heterozygous \(Rr\) parent produces \(\tfrac{1}{2}\) \(R\) gametes and \(\tfrac{1}{2}\) \(r\) gametes; paired with the \(rr\) parent''s all-\(r\) gametes, this yields \(\tfrac{1}{2}\) \(Rr\) (round) and \(\tfrac{1}{2}\) \(rr\) (wrinkled), the observed near-equal split. The textbook states that in a test cross, "if the dominant expressing organism is a heterozygote, the F1 offspring will exhibit a 1:1 ratio of heterozygotes and recessive homozygotes." (Choice A) is incorrect: a homozygous dominant \(RR\) parent crossed with \(rr\) would give all \(Rr\) round offspring with no wrinkled seeds, not a \(1{:}1\) split. (Choice B) is incorrect: an \(rr\) parent would itself have wrinkled, not round, seeds, so it cannot be the round-seeded parent. (Choice C) is correct: the \(1{:}1\) dominant-to-recessive ratio reveals that the round parent carries one recessive allele, making it heterozygous \(Rr\). (Choice D) is incorrect: seed shape in peas is an autosomal trait carried on a homologous chromosome pair, so a diploid plant carries two alleles and is not hemizygous; hemizygosity applies to genes on a single sex chromosome. This is a Scientific Reasoning and Problem Solving question because you must apply the law of segregation and test-cross logic to reason from an observed offspring ratio back to the parent''s genotype.', 'easy', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', NULL FROM q;

-- Q12 [Dihybrid & Test Crosses] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Dihybrid & Test Crosses', 'A pea breeder self-crosses an \(YyRr\) plant, where yellow \((Y)\) is dominant to green \((y)\) and round \((R)\) is dominant to wrinkled \((r)\). The two genes assort independently, so each trait follows its own monohybrid ratio:

| Trait | P(dominant) | P(recessive) |
|---|---|---|
| Color | \(\tfrac{3}{4}\) yellow | \(\tfrac{1}{4}\) green |
| Shape | \(\tfrac{3}{4}\) round | \(\tfrac{1}{4}\) wrinkled |

Using the product rule, the probability that a single \(F_2\) offspring is yellow and wrinkled is closest to which value?', '[{"label": "A", "text": "\\(\\tfrac{9}{16}\\)"}, {"label": "B", "text": "\\(\\tfrac{1}{16}\\)"}, {"label": "C", "text": "\\(\\tfrac{6}{16}\\)"}, {"label": "D", "text": "\\(\\tfrac{3}{16}\\)"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is D because the yellow-and-wrinkled class combines one dominant phenotype with one recessive phenotype, and the product rule multiplies the two independent monohybrid probabilities. The textbook states that for a class with one dominant and one recessive phenotype, the proportion is \((3/4) \times (1/4) = 3/16\): \(P(\text{yellow}) = \tfrac{3}{4}\) and \(P(\text{wrinkled}) = \tfrac{1}{4}\), so \(P(\text{yellow and wrinkled}) = \tfrac{3}{4} \times \tfrac{1}{4} = \tfrac{3}{16}\). The word "and" signals the product rule because color and shape are independent events. (Choice A) \(\tfrac{9}{16}\) results from multiplying the two dominant probabilities, \((3/4) \times (3/4)\), as if both traits were dominant (yellow and round). (Choice B) \(\tfrac{1}{16}\) results from multiplying the two recessive probabilities, \((1/4) \times (1/4)\), as if both traits were recessive (green and wrinkled). (Choice C) \(\tfrac{6}{16}\) results from summing both single-mixed classes, \(\tfrac{3}{16} + \tfrac{3}{16}\) (yellow/wrinkled plus green/round), which answers "one dominant and one recessive in either order" rather than the one specified class. (Choice D) is correct: a single specified mixed class equals \((3/4) \times (1/4) = \tfrac{3}{16}\). This is a Scientific Reasoning and Problem Solving question because you must apply the product rule to the per-trait probabilities in the table to compute the frequency of one specified phenotypic class.', 'hard', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', NULL FROM q;

-- Q13 [Dihybrid & Test Crosses] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Dihybrid & Test Crosses', 'In peas, round seed (\(R\)) is dominant to wrinkled (\(r\)) and yellow seed (\(Y\)) is dominant to green (\(y\)). A breeder crosses a round, yellow plant of unknown genotype to a wrinkled, green plant and scores the offspring as shown. The two genes assort independently. Which genotype of the unknown round, yellow parent is most consistent with these counts?

| Offspring phenotype | Count |
|---|---|
| round, yellow | 31 |
| round, green | 29 |
| wrinkled, yellow | 33 |
| wrinkled, green | 27 |', '[{"label": "A", "text": "\\(RrYy\\)"}, {"label": "B", "text": "\\(RrYY\\)"}, {"label": "C", "text": "\\(RRYY\\)"}, {"label": "D", "text": "\\(RrYy\\) with the genes linked"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is A because the wrinkled, green tester is homozygous recessive (\(rryy\)) and contributes only \(ry\) gametes, so each offspring''s phenotype reports exactly one gamete made by the unknown round, yellow parent. The four phenotypic classes appear in counts of 31:29:33:27, which is essentially \(1{:}1{:}1{:}1\) (expected \(\tfrac{1}{4}\) each, or 30 of 120 per class). A parent producing all four gamete types — \(RY\), \(Ry\), \(rY\), \(ry\) — in equal frequency must be heterozygous at both loci, \(RrYy\), with the two genes assorting independently (Mendel''s dihybrid heterozygote forms "four equally likely gametes," giving a \(1{:}1{:}1{:}1\) testcross ratio). (Choice A) is correct: only \(RrYy\) generates all four gamete classes in equal proportions, reproducing the observed \(1{:}1{:}1{:}1\) split. (Choice B) \(RrYY\) is homozygous for color, so every gamete carries \(Y\); the testcross would yield only yellow offspring in a \(1{:}1\) round:wrinkled ratio (two classes, no green), not four equal classes. (Choice C) \(RRYY\) is homozygous dominant for both genes and makes only \(RY\) gametes, so a testcross would produce a single phenotypic class, all round and yellow. (Choice D) If the two genes were linked, parental-type offspring would outnumber recombinant types, skewing the data away from \(1{:}1{:}1{:}1\); the observed equality is the signature of independent assortment, not linkage. This is a Data-based and Statistical Reasoning question because you must interpret the offspring counts as a ratio and infer the parental genotype from that ratio.', 'hard', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 4, 160)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'partial_truth', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', NULL FROM q;

-- Q14 [Sex-Linked Inheritance & Pedigrees] easy skill1 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Sex-Linked Inheritance & Pedigrees', 'A man inherits a single recessive allele for red-green color blindness on his X chromosome and consequently shows the color-blind phenotype, even though the allele is recessive. The expression of this single recessive allele in the male is best explained by the fact that he is', '[{"label": "A", "text": "homozygous recessive for the trait"}, {"label": "B", "text": "hemizygous, carrying only one X"}, {"label": "C", "text": "a carrier of the recessive allele"}, {"label": "D", "text": "heterozygous on his sex chromosomes"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is B because human males have an XY chromosome pair, so for any gene present on the X but not on the Y they carry only a single allele. The textbook states that "Males are said to be hemizygous, because they have only one allele for any X-linked characteristic" and that "human males need to inherit only one recessive mutant X allele to be affected," which is why a single recessive allele such as \(X^c Y\) is expressed despite being recessive. (Choice A) is incorrect because being homozygous recessive requires two copies of the recessive allele, but a male has only one X chromosome and therefore cannot be homozygous for an X-linked gene; the textbook notes hemizygosity "makes the descriptions of dominance and recessiveness irrelevant for XY males." (Choice B) is correct: with only one X chromosome the male has a single allele, so that lone recessive allele is necessarily expressed. (Choice C) is incorrect because a carrier is a heterozygous female (e.g., \(X^C X^c\)) who has a second, dominant allele masking the trait and remains unaffected, the opposite of an affected hemizygous male. (Choice D) is incorrect because a male''s sex chromosomes are X and Y, which are non-homologous and carry only one copy of the X-linked gene, so he is not heterozygous for that locus. This is a Knowledge of Scientific Concepts and Principles question because you must recall that males are hemizygous for X-linked genes and therefore express a single recessive X-linked allele.', 'easy', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', NULL FROM q;

-- Q15 [Sex-Linked Inheritance & Pedigrees] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Sex-Linked Inheritance & Pedigrees', 'A woman who is a carrier for an X-linked recessive form of hemophilia (genotype \(X^H X^h\)) has children with a man who is unaffected (genotype \(X^H Y\)). For any given son they have, what is the probability that he is affected by the disorder?', '[{"label": "A", "text": "\\(\\tfrac{1}{4}\\)"}, {"label": "B", "text": "\\(0\\)"}, {"label": "C", "text": "\\(\\tfrac{1}{2}\\)"}, {"label": "D", "text": "\\(\\tfrac{3}{4}\\)"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is C because a son receives his single X chromosome from his mother and his Y chromosome from his father, so his phenotype depends only on which of the mother''s two X chromosomes he inherits. The carrier mother \(X^H X^h\) passes \(X^H\) to half of her sons and \(X^h\) to the other half; a son who receives \(X^h\) is hemizygous and therefore affected, while a son who receives \(X^H\) is unaffected. Working the cross \(X^H X^h \times X^H Y\), the four equally likely offspring boxes are \(X^H X^H\), \(X^H X^h\), \(X^H Y\), and \(X^h Y\); among the two sons (\(X^H Y\) and \(X^h Y\)), exactly one is affected, giving a \(\tfrac{1}{2}\) probability. The textbook states that a carrier female "will pass the disease to half of their sons" and that "the male offspring of a person who is a carrier of a recessive X-linked disorder will have a 50 percent chance of being affected." (Choice A) \(\tfrac{1}{4}\) counts the one affected son against all four offspring boxes; this is the unconditional chance that a child is an affected son, but the question already conditions on the child being a son, so the denominator should be the two sons, not all four offspring. (Choice B) \(0\) reverses the source of the son''s X chromosome — it assumes the son''s sex chromosome that carries the disease comes from the father, but the father contributes only the Y, and the son''s single X (and thus his disease status) comes entirely from the carrier mother. (Choice C) is correct: half of the carrier mother''s sons inherit her \(X^h\) allele and, being hemizygous, are affected, so the probability is \(\tfrac{1}{2}\). (Choice D) \(\tfrac{3}{4}\) misapplies the autosomal \(3{:}1\) dominant-to-recessive phenotype ratio from a monohybrid cross; that ratio does not apply because males are hemizygous, having only one allele for an X-linked gene. This is a Scientific Reasoning and Problem Solving question because you must apply the rules of X-linked transmission to a specific carrier-by-unaffected cross and compute the probability for the male offspring.', 'medium', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', NULL FROM q;

-- Q16 [Sex-Linked Inheritance & Pedigrees] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Sex-Linked Inheritance & Pedigrees', 'A pedigree for an X-linked recessive form of color blindness shows the following nuclear family:

| Individual | Phenotype |
|------------|-----------|
| Father     | Unaffected |
| Mother     | Unaffected |
| Son        | Affected (color blind) |
| Daughter   | Unaffected |

Given that the son is hemizygous for the recessive allele, the parent who transmitted the recessive allele on his single \(X\) chromosome is most likely his:', '[{"label": "A", "text": "father, who passed an affected \\(X\\)"}, {"label": "B", "text": "father, who passed the \\(Y\\) chromosome"}, {"label": "C", "text": "mother, who is homozygous affected"}, {"label": "D", "text": "mother, who is an unaffected carrier"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is D because a son receives his \(Y\) chromosome from his father and his single \(X\) chromosome from his mother, so an affected hemizygous son (\(X^c Y\)) must have inherited the recessive allele from his mother. Because the mother is phenotypically unaffected yet transmitted the recessive allele, she must be a heterozygous carrier (\(X^C X^c\)): the textbook states that "female carriers can contribute the trait to their male children, resulting in the male exhibiting the trait," and that affected sons are "destined to express the trait, as they will inherit their father''s Y chromosome." The criss-cross pattern is therefore father \(\to\) \(Y\), mother \(\to\) recessive \(X\), and a carrier mother passes the disease to half of her sons. (Choice A) is incorrect because the father contributes the \(Y\), not an \(X\), to a son, so any allele on the father''s \(X\) cannot reach his son. (Choice B) is a partial truth: the father does pass the \(Y\), but the \(Y\) carries no allele for this X-linked gene, so it is not the source of the recessive allele that makes the son affected. (Choice C) is incorrect because a homozygous affected mother (\(X^c X^c\)) would herself be color blind, contradicting her unaffected phenotype in the pedigree; an unaffected transmitting mother must instead be a heterozygous carrier. (Choice D) is correct: the unaffected mother carries one recessive allele as a heterozygote (\(X^C X^c\)) and passed that \(X^c\) to her son. This is a Scientific Reasoning and Problem Solving question because you must apply the rules of X-linked recessive transmission to a pedigree to deduce the source and zygosity of the allele.', 'medium', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', NULL FROM q;

-- Q17 [Sex-Linked Inheritance & Pedigrees] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Sex-Linked Inheritance & Pedigrees', 'A geneticist examines a four-generation pedigree for a disorder that appears only in males. In every affected branch, an affected son is born to two unaffected parents, the affected male''s mother is herself the daughter or sister of another affected male, and no affected female ever appears. Which of the following conclusions about the disorder is/are supported by this pedigree?

I. The disorder is inherited as an X-linked recessive trait, with affected sons receiving the mutant allele from unaffected carrier mothers.
II. An affected father would be expected to transmit the disorder to all of his sons.
III. Affected females should appear about as frequently as affected males in each generation.', '[{"label": "A", "text": "I only"}, {"label": "B", "text": "III only"}, {"label": "C", "text": "I and III only"}, {"label": "D", "text": "II and III only"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is A because only statement I is consistent with the pedigree. The textbook states that with X-linked recessive disorders, "human males need to inherit only one recessive mutant X allele to be affected," so "X-linked disorders are disproportionately observed in males," while "female carriers can contribute the trait to their male children, resulting in the male exhibiting the trait" (lines 15101-15109). A pedigree in which affected sons \(X^a Y\) are repeatedly born to unaffected parents, are linked through unaffected \(X^A X^a\) carrier mothers, and in which no affected females appear is the signature of X-linked recessive transmission, making statement I correct and the answer "I only." (Choice A) is correct: statement I alone is supported, because the carrier-mother-to-affected-son pattern with no affected daughters is exactly the inheritance the textbook describes for X-linked recessive traits (lines 15104-15109). (Choice B) is wrong because it requires statement III, which is false: the textbook explains that because males need only one mutant X allele while "Females must inherit recessive X-linked alleles from both of their parents in order to express the trait," the trait "appear[s] more frequently in males than females" (lines 15103-15105, 15093-15094), so affected females are NOT as frequent as affected males. (Choice C) is wrong because, although it correctly includes statement I, it also includes the false statement III for the same reason. (Choice D) is wrong because it includes statements II and III, both false: for statement II, an affected father \(X^a Y\) passes his Y to every son and his \(X^a\) only to daughters, so "Her male offspring... will inherit their father''s Y chromosome" (line 15090) means sons get the trait from the mother, not the father — a father transmits an X-linked recessive allele to his daughters, not his sons. This is a Scientific Reasoning and Problem Solving question because you must apply the rules of X-linked recessive inheritance to a described pedigree to evaluate which conclusions the data support.', 'hard', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 165)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', NULL FROM q;

-- Q18 [Sex-Linked Inheritance & Pedigrees] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Sex-Linked Inheritance & Pedigrees', 'A genetic counselor examines the family below, in which a single trait is tracked across one set of parents and their four children. Neither parent is affected, yet two of their children are affected, and the affected children include both a son and a daughter. Based on this pedigree, the inheritance mode that best fits the data is:

| Individual | Sex | Phenotype |
|---|---|---|
| Parent 1 | Female | Unaffected |
| Parent 2 | Male | Unaffected |
| Child 1 | Son | Affected |
| Child 2 | Son | Unaffected |
| Child 3 | Daughter | Affected |
| Child 4 | Daughter | Unaffected |', '[{"label": "A", "text": "Autosomal dominant"}, {"label": "B", "text": "Autosomal recessive"}, {"label": "C", "text": "X-linked recessive"}, {"label": "D", "text": "X-linked dominant"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is B because two unaffected parents who produce affected children indicate a recessive trait, and an affected daughter forces that recessive allele onto an autosome rather than the X chromosome. The textbook''s pedigree rule states that for a recessive disorder, affected individuals have the genotype \(aa\) while unaffected individuals are \(AA\) or \(Aa\), and that \"if neither parent has the disorder but their child does, they must be heterozygous\" — so both parents are carriers \(Aa\), and an \(Aa \times Aa\) cross yields affected \(aa\) offspring of either sex. The deciding clue is the affected daughter: the text notes that for an X-linked recessive trait, \"Females must inherit recessive X-linked alleles from both of their parents in order to express the trait,\" which would require an affected (hemizygous \(X^a Y\)) father, but Parent 2 is unaffected — so X-linked recessive is impossible here, leaving autosomal recessive. (Choice A) is incorrect because a dominant trait cannot skip the parents: an affected child carrying the dominant allele would have to inherit it from an affected parent, yet both parents are unaffected. (Choice B) is correct: two unaffected carrier parents \(Aa \times Aa\) on an autosome can produce affected \(aa\) sons and daughters in equal likelihood, matching the pedigree. (Choice C) is incorrect because under X-linked recessive inheritance an affected daughter (\(X^a X^a\)) requires a father who is \(X^a Y\) and therefore affected; the unaffected father rules this out, and the text adds that such disorders are \"disproportionately observed in males,\" not split evenly across affected sons and daughters. (Choice D) is incorrect because, like any dominant pattern, an affected child must inherit the dominant allele from an affected parent, but neither parent is affected. This is a Scientific Reasoning and Problem Solving question because you must apply the rules of recessive and X-linked inheritance to a pedigree and eliminate every mode that contradicts the observed affected son and daughter.', 'hard', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 160)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', NULL FROM q;

-- Q19 [Sex-Linked Inheritance & Pedigrees] easy skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Sex-Linked Inheritance & Pedigrees', 'Red-green color blindness, an X-linked recessive condition, is observed far more often in male patients than in female patients in a clinical population. Which of the following best accounts for this difference between the sexes?', '[{"label": "A", "text": "The recessive allele is dominant in males"}, {"label": "B", "text": "Affected males transmit the allele to sons"}, {"label": "C", "text": "Males need only one recessive allele to be affected"}, {"label": "D", "text": "The Y chromosome carries a duplicate allele"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is C because a male has only a single X chromosome and is therefore hemizygous for any X-linked gene; the textbook states that "Males are said to be hemizygous, because they have only one allele for any X-linked characteristic" and that "Because human males need to inherit only one recessive mutant X allele to be affected, X-linked disorders are disproportionately observed in males." A female, by contrast, "must inherit recessive X-linked alleles from both of their parents in order to express the trait," so a single recessive allele leaves her an unaffected carrier (\(X^A X^a\)). Because one recessive copy is enough to affect a hemizygous male (\(X^a Y\)) but two copies are required to affect a female, X-linked recessive conditions such as red-green color blindness "appear more frequently in males than females." (Choice A) is incorrect because the allele is not converted to dominant in males; dominance and recessiveness are simply irrelevant for a hemizygous male, who expresses whatever single allele his lone X carries. (Choice B) is incorrect and reflects a reversed transmission pattern: an affected father passes his \(X^a\) to all of his daughters (making them carriers), never to his sons, who receive his Y chromosome. (Choice C) is correct: needing only one recessive allele to be affected is exactly why hemizygous males show the trait more often than females, who require two recessive alleles. (Choice D) is incorrect because the Y chromosome does not carry a duplicate of the X-linked gene; the absence of a second allele on the Y is precisely what makes the male hemizygous. This is a Scientific Reasoning and Problem Solving question because you must apply the concept of male hemizygosity to explain the observed sex difference in disease frequency.', 'easy', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', NULL FROM q;

-- Q20 [Gene Mapping & Recombination] easy skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Gene Mapping & Recombination', 'Two genes located on the same chromosome in a fruit fly population recombine in \(8\%\) of offspring, on average. Based on this recombination frequency, the genetic distance between these two genes is closest to which value?', '[{"label": "A", "text": "\\(8\\ \\text{cM}\\)"}, {"label": "B", "text": "\\(4\\ \\text{cM}\\)"}, {"label": "C", "text": "\\(0.08\\ \\text{cM}\\)"}, {"label": "D", "text": "\\(16\\ \\text{cM}\\)"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is A because map distance in centimorgans corresponds directly to recombination frequency expressed as a percentage: a \(0.01\) (i.e., \(1\%\)) recombination frequency equals \(1\ \text{cM}\). A recombination frequency of \(8\%\) therefore equals \(8 \times 1\ \text{cM} = 8\ \text{cM}\). The textbook states that map distances in centimorgans "correspond to recombination frequencies (in percent)," giving the worked example that genes recombining in \(17\%\) of offspring lie \(17\ \text{cM}\) apart. (Choice A) is correct: converting \(8\%\) recombination directly to \(8\ \text{cM}\) applies the \(1\%{=}1\ \text{cM}\) relationship exactly. (Choice B) \(4\ \text{cM}\) results from incorrectly halving the recombination frequency, as if only one of the two reciprocal recombinant classes counted toward the distance; the full recombinant frequency defines the distance. (Choice C) \(0.08\ \text{cM}\) confuses the decimal form of the frequency (\(0.08\)) with the percentage form, an error of \(100\times\); the centimorgan tracks the percentage, not the decimal fraction. (Choice D) \(16\ \text{cM}\) results from doubling the recombination frequency, which has no basis—each \(1\%\) maps to exactly \(1\ \text{cM}\), not \(2\). This is a Scientific Reasoning and Problem Solving question because you must apply the relationship between recombination frequency and centimorgan distance to compute a genetic map distance from cross data.', 'easy', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'scale_unit_error', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', NULL FROM q;

-- Q21 [Gene Mapping & Recombination] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Gene Mapping & Recombination', 'A geneticist performs a test cross between a fruit fly heterozygous at two linked loci and a fully recessive fly, then scores the 1000 offspring by phenotype as shown.

| Offspring class | Count |
|---|---|
| Parental type 1 | 440 |
| Parental type 2 | 440 |
| Recombinant type 1 | 60 |
| Recombinant type 2 | 60 |

Based on these data, the map distance between the two loci is most nearly:', '[{"label": "A", "text": "\\(88\\ \\text{cM}\\)"}, {"label": "B", "text": "\\(6\\ \\text{cM}\\)"}, {"label": "C", "text": "\\(0.12\\ \\text{cM}\\)"}, {"label": "D", "text": "\\(12\\ \\text{cM}\\)"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is D because map distance in centimorgans equals the recombination frequency expressed as a percent. The recombination frequency is the fraction of offspring that are recombinant (nonparental) types: \(\tfrac{60+60}{1000} = \tfrac{120}{1000} = 0.12\), or a \(12\%\) recombination frequency. Because a \(0.01\) recombination frequency corresponds to \(1\ \text{cM}\), a \(12\%\) recombination frequency corresponds directly to \(12\ \text{cM}\) between the two linked loci. (Choice A) \(88\ \text{cM}\) comes from using the parental count \(\tfrac{440+440}{1000} = 88\%\) instead of the recombinant count; the parental types are inherited together and do NOT measure crossover distance. (Choice B) \(6\ \text{cM}\) results from incorrectly halving the recombinant frequency, but the full recombinant fraction is used directly to get map distance. (Choice C) \(0.12\ \text{cM}\) keeps the recombination frequency as the decimal \(0.12\) without converting to a percent, ignoring that a \(0.01\) recombination frequency equals \(1\ \text{cM}\), so the true value is \(100\) times larger. (Choice D) is correct: a \(12\%\) recombination frequency equals \(12\ \text{cM}\). This is a Scientific Reasoning and Problem Solving question because you must apply the recombination-frequency-to-map-distance relationship to count data from a test cross.', 'medium', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'scale_unit_error', NULL FROM q;

-- Q22 [Gene Mapping & Recombination] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Gene Mapping & Recombination', 'A geneticist test-crosses a fruit fly that is heterozygous for two genes, \(AaBb\), to a fully recessive \(aabb\) partner and scores all \(800\) offspring. The two parental-type classes total \(720\) flies, while the two recombinant-type classes total \(80\) flies, as shown below.

| Offspring class | Count |
|---|---|
| Parental type 1 (\(AaBb\)) | \(360\) |
| Parental type 2 (\(aabb\)) | \(360\) |
| Recombinant type 1 (\(Aabb\)) | \(40\) |
| Recombinant type 2 (\(aaBb\)) | \(40\) |

Based on these data, the map distance between the two genes is closest to which value?', '[{"label": "A", "text": "\\(5\\ \\text{cM}\\)"}, {"label": "B", "text": "\\(10\\ \\text{cM}\\)"}, {"label": "C", "text": "\\(11\\ \\text{cM}\\)"}, {"label": "D", "text": "\\(1\\ \\text{cM}\\)"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is B because recombination frequency is the proportion of recombinant (nonparental) offspring out of the total, and a recombination frequency of \(0.01\) corresponds to \(1\ \text{cM}\). The textbook works this exact calculation: "we could calculate the recombination''s frequency as 50/1000 = 0.05 ... Sturtevant divided his genetic map into map units, or centimorgans (cM), in which a 0.01 recombination frequency corresponds to 1 cM." Here you must add BOTH recombinant classes for the numerator: \((40+40)/800 = 80/800 = 0.10\), and since map distance in cM equals the recombination frequency expressed as a percent, \(0.10 = 10\%\), giving \(10\ \text{cM}\). (Choice A) \(5\ \text{cM}\) results from counting only one recombinant class, \(40/800 = 0.05\), instead of summing both nonparental classes. (Choice B) is correct: both recombinant classes are summed, \(80/800 = 0.10\), which equals \(10\ \text{cM}\). (Choice C) \(11\ \text{cM}\) results from dividing the recombinants by the parental count rather than the total offspring, \(80/720 \approx 0.111\); the denominator must be all offspring, not just the parentals. (Choice D) \(1\ \text{cM}\) results from a unit-conversion error, treating the \(0.10\) recombination frequency as if it equaled \(0.01\) (which would be \(1\ \text{cM}\)); a frequency of \(0.10\) is ten times that, \(10\ \text{cM}\). This is a Scientific Reasoning and Problem Solving question because you must apply the recombination-frequency-to-centimorgan relationship to test-cross count data to compute a map distance.', 'medium', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', NULL FROM q;

-- Q23 [Gene Mapping & Recombination] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Gene Mapping & Recombination', 'A geneticist studying three linked loci in a fungus measures the following pairwise recombination distances: genes \(A\) and \(B\) are \(8\ \text{cM}\) apart, genes \(B\) and \(C\) are \(12\ \text{cM}\) apart, and genes \(A\) and \(C\) are \(20\ \text{cM}\) apart. On the basis of these data, which of the following statements about the arrangement of the three genes is accurate?

I. Gene \(B\) lies between genes \(A\) and \(C\).
II. Gene \(A\) lies between genes \(B\) and \(C\).
III. The \(A\)–\(C\) distance equals the sum of the \(A\)–\(B\) and \(B\)–\(C\) distances.', '[{"label": "A", "text": "I only"}, {"label": "B", "text": "III only"}, {"label": "C", "text": "I and III only"}, {"label": "D", "text": "II and III only"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is C because the largest of the three pairwise distances flanks the remaining gene, and because map distances are additive along a chromosome. The textbook states that map distances in centimorgans correspond to recombination frequencies and that this lets us "additively calculate distances between several genes on the same chromosome" (lines 16059-16060, 16086-16087); the worked example computes the body color-to-wing size separation as \(65.5 - 48.5 = 17\ \text{cM}\), showing distances combine by addition and subtraction. Here the largest distance is \(A\)–\(C = 20\ \text{cM}\), so \(A\) and \(C\) flank the third gene; placing \(B\) between them gives the order \(A\)–\(B\)–\(C\), and \(8\ \text{cM} + 12\ \text{cM} = 20\ \text{cM}\) confirms it. Thus statement I (\(B\) is the middle gene) and statement III (the two short distances sum to the long one) are both true, while statement II places an end gene in the middle and is false. (Choice A) I only is a partial truth: it correctly puts \(B\) in the middle but ignores the additive relationship the data themselves verify, since \(8 + 12 = 20\) (line 16086). (Choice B) III only confirms the arithmetic yet wrongly treats the gene order as undetermined, even though the largest distance unambiguously identifies \(A\) and \(C\) as the flanking genes (lines 16058-16060). (Choice C) is correct: \(B\) is flanked by \(A\) and \(C\), giving order \(A\)–\(B\)–\(C\), and \(20\ \text{cM} = 8\ \text{cM} + 12\ \text{cM}\). (Choice D) II and III only reverses the placement rule, putting the terminal gene \(A\) in the middle; the gene that lies between the others is the one NOT appearing in the largest pairwise distance, which is \(B\), not \(A\) (lines 16064-16068). This is a Scientific Reasoning and Problem Solving question because you must apply the additivity of map distances to deduce gene order from three recombination measurements.', 'hard', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', NULL FROM q;

-- Q24 [Gene Mapping & Recombination] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Gene Mapping & Recombination', 'A geneticist crosses Drosophila to measure recombination frequencies among three linked genes on one chromosome and tabulates the data below.

| Gene pair | Recombination frequency |
|-----------|-------------------------|
| \(A\)–\(B\) | \(17\%\) |
| \(B\)–\(C\) | \(8\%\) |
| \(A\)–\(C\) | \(25\%\) |

Treating the genes as additively ordered along the chromosome, the map distance separating the two outermost genes is closest to which value?', '[{"label": "A", "text": "\\(25\\ \\text{cM}\\)"}, {"label": "B", "text": "\\(9\\ \\text{cM}\\)"}, {"label": "C", "text": "\\(17\\ \\text{cM}\\)"}, {"label": "D", "text": "\\(12.5\\ \\text{cM}\\)"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is A because map distance in centimorgans equals recombination frequency in percent, and because distances along a chromosome add, the two outer genes must be the pair separated by the largest distance. The textbook states that a \(0.01\) recombination frequency corresponds to \(1\ \text{cM}\) and that this linear representation ''allowed Sturtevant to additively calculate distances between several genes on the same chromosome.'' Here the smallest interval is \(B\)–\(C = 8\%\) and the next is \(A\)–\(B = 17\%\); ordering the genes so these two intervals are adjacent gives \(A\)–\(B\)–\(C\), and the outer distance is \(17\ \text{cM} + 8\ \text{cM} = 25\ \text{cM}\), matching the measured \(A\)–\(C\) value. (Choice A) is correct: adding the two adjacent intervals of the ordered map yields \(25\ \text{cM}\) for the outermost pair. (Choice B) \(9\ \text{cM}\) results from subtracting the intervals (\(17 - 8\)), which would mean the genes overlap rather than lie end to end and contradicts the additivity the textbook describes. (Choice C) \(17\ \text{cM}\) is only the single largest interval (\(A\)–\(B\)); it forgets to add the adjacent \(B\)–\(C\) interval needed to span the full distance. (Choice D) \(12.5\ \text{cM}\) averages the two intervals (\(\tfrac{17+8}{2}\)) instead of summing them, but map distances add and are not averaged. This is a Scientific Reasoning and Problem Solving question because you must apply the additivity of map distances to data in a recombination table to deduce gene order and compute the outer distance.', 'hard', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', NULL FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', NULL FROM q;

-- Q25 [Gene Mapping & Recombination] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Genetics and Evolution', 'Gene Mapping & Recombination', 'A geneticist test-crosses a dihybrid fly and observes that two genes show a recombination frequency of \(50\%\), while a second pair of genes shows a recombination frequency of \(17\%\). Which of the following statements about these results is/are accurate?

I. The \(50\%\) value proves that those two genes lie on the same chromosome.
II. The \(50\%\) value means those two genes assort independently, as if on separate chromosomes.
III. The \(17\%\) value indicates that those two genes are linked on the same chromosome.', '[{"label": "A", "text": "I only"}, {"label": "B", "text": "III only"}, {"label": "C", "text": "I and III only"}, {"label": "D", "text": "II and III only"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Transmission of Heritable Information from Generation to Generation.'' The answer is D because only statements II and III correctly interpret recombination frequency. Sturtevant showed that genes range from "linking perfectly (recombination frequency = 0) to unlinking perfectly (recombination frequency = 0.5)," and that "perfectly unlinked genes correspond to the frequencies Mendel predicted to assort independently in a dihybrid cross" (lines 16081-16084), so a \(50\%\) recombination frequency means the genes behave as if on separate chromosomes and assort independently (statement II is accurate, statement I is not). The textbook also states that "a crossover frequency between 0 percent and 50 percent indicates that the genes are on the same chromosome and crossover sometimes occurs" (lines 16020-16021), so the \(17\%\) value identifies linked genes that are \(17\ \text{cM}\) apart (statement III is accurate). (Choice A) is wrong because it selects only statement I, the one false statement: a \(50\%\) frequency means genes behave as if unlinked, not that they share a chromosome. (Choice B) is a partial truth that includes the correct statement III but omits the equally correct statement II. (Choice C) pairs the true statement III with the false statement I. (Choice D) is correct: a \(50\%\) recombination frequency reflects independent assortment as on separate chromosomes (II), and a sub-\(50\%\) frequency such as \(17\%\) reflects linkage on the same chromosome (III). This is a Scientific Reasoning and Problem Solving question because you must apply the relationship between recombination frequency and gene linkage to interpret two cross outcomes.', 'medium', '1C', 'Transmission of Heritable Information from Generation to Generation', 'biology', 2, 105)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', NULL FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', NULL FROM q;
