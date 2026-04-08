-- ============================================================
-- Praxis Prep — Seed Questions (50 MCAT-style questions)
-- Run this AFTER 001_phase1_schema.sql
-- ============================================================

-- =====================
-- BIO/BIOCHEM SECTION
-- =====================

INSERT INTO questions (section, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES

-- Amino Acids & Proteins
('bio_biochem', 'Amino Acids',
 'Which of the following amino acids contains a sulfur atom in its side chain?',
 '[{"label": "A", "text": "Serine"}, {"label": "B", "text": "Methionine"}, {"label": "C", "text": "Threonine"}, {"label": "D", "text": "Asparagine"}]',
 'B',
 'Methionine contains a thioether group (-S-CH3) in its side chain. Cysteine is the other sulfur-containing amino acid (with a thiol group). Serine and threonine have hydroxyl groups, and asparagine has an amide group.',
 'easy'),

('bio_biochem', 'Amino Acids',
 'At physiological pH (7.4), which amino acid side chain would most likely carry a positive charge?',
 '[{"label": "A", "text": "Glutamate"}, {"label": "B", "text": "Lysine"}, {"label": "C", "text": "Alanine"}, {"label": "D", "text": "Leucine"}]',
 'B',
 'Lysine has a side chain pKa of approximately 10.5, meaning at pH 7.4 it is protonated and carries a positive charge. Glutamate (pKa ~4.1) would be negatively charged. Alanine and leucine have nonpolar, uncharged side chains.',
 'easy'),

('bio_biochem', 'Amino Acids',
 'Disulfide bonds form between which amino acid residues?',
 '[{"label": "A", "text": "Two methionine residues"}, {"label": "B", "text": "Two cysteine residues"}, {"label": "C", "text": "A cysteine and a methionine residue"}, {"label": "D", "text": "Two serine residues"}]',
 'B',
 'Disulfide bonds (S-S bonds) form between the thiol groups (-SH) of two cysteine residues through an oxidation reaction. These covalent bonds help stabilize the tertiary and quaternary structure of proteins. Methionine contains sulfur but cannot form disulfide bonds.',
 'easy'),

-- Enzyme Kinetics
('bio_biochem', 'Enzyme Kinetics',
 'A competitive inhibitor of an enzyme would be expected to:',
 '[{"label": "A", "text": "Increase Km and decrease Vmax"}, {"label": "B", "text": "Increase Km with no effect on Vmax"}, {"label": "C", "text": "Decrease Km and increase Vmax"}, {"label": "D", "text": "Have no effect on Km but decrease Vmax"}]',
 'B',
 'A competitive inhibitor competes with the substrate for the active site. This effectively increases the apparent Km (more substrate needed to reach half-maximal velocity) but does not affect Vmax, because at sufficiently high substrate concentrations, the inhibitor can be outcompeted.',
 'medium'),

('bio_biochem', 'Enzyme Kinetics',
 'Which of the following best describes an allosteric enzyme?',
 '[{"label": "A", "text": "An enzyme that follows Michaelis-Menten kinetics"}, {"label": "B", "text": "An enzyme regulated by molecules binding at a site other than the active site"}, {"label": "C", "text": "An enzyme that requires a metal cofactor"}, {"label": "D", "text": "An enzyme that only catalyzes irreversible reactions"}]',
 'B',
 'Allosteric enzymes are regulated by effector molecules that bind at sites distinct from the active site (allosteric sites). This binding causes conformational changes that alter enzyme activity. Allosteric enzymes typically show sigmoidal kinetics rather than hyperbolic Michaelis-Menten kinetics.',
 'medium'),

-- Cell Biology
('bio_biochem', 'Cell Biology',
 'During which phase of the cell cycle does DNA replication occur?',
 '[{"label": "A", "text": "G1 phase"}, {"label": "B", "text": "S phase"}, {"label": "C", "text": "G2 phase"}, {"label": "D", "text": "M phase"}]',
 'B',
 'DNA replication occurs during the S (synthesis) phase of interphase. G1 is the first gap phase where the cell grows and prepares for DNA synthesis. G2 is the second gap phase where the cell prepares for mitosis. M phase is mitosis, where the replicated chromosomes are separated.',
 'easy'),

('bio_biochem', 'Cell Biology',
 'Which organelle is the primary site of ATP production in eukaryotic cells?',
 '[{"label": "A", "text": "Endoplasmic reticulum"}, {"label": "B", "text": "Golgi apparatus"}, {"label": "C", "text": "Mitochondria"}, {"label": "D", "text": "Lysosome"}]',
 'C',
 'Mitochondria are the primary site of ATP production through oxidative phosphorylation. The electron transport chain and ATP synthase are located in the inner mitochondrial membrane, where the majority of ATP is generated. While some ATP is produced in the cytoplasm via glycolysis, the bulk comes from mitochondria.',
 'easy'),

-- Genetics
('bio_biochem', 'Genetics',
 'If a trait is autosomal recessive and both parents are carriers, what is the probability their offspring will express the trait?',
 '[{"label": "A", "text": "0%"}, {"label": "B", "text": "25%"}, {"label": "C", "text": "50%"}, {"label": "D", "text": "75%"}]',
 'B',
 'When both parents are carriers (heterozygous, Aa), the Punnett square gives: AA (25%), Aa (50%), aa (25%). Only the aa genotype (25%) expresses the recessive trait. This is a fundamental principle of Mendelian genetics.',
 'easy'),

('bio_biochem', 'Genetics',
 'Which type of mutation is most likely to have a severe effect on protein function?',
 '[{"label": "A", "text": "Silent mutation"}, {"label": "B", "text": "Conservative missense mutation"}, {"label": "C", "text": "Frameshift mutation"}, {"label": "D", "text": "Mutation in an intron"}]',
 'C',
 'A frameshift mutation (caused by insertions or deletions not in multiples of 3) shifts the reading frame of the entire downstream sequence, typically resulting in a completely altered and nonfunctional protein. Silent mutations do not change the amino acid, conservative missense mutations replace with similar amino acids, and intronic mutations are often spliced out.',
 'medium'),

-- Metabolism
('bio_biochem', 'Metabolism',
 'The net ATP yield from glycolysis per molecule of glucose is:',
 '[{"label": "A", "text": "1 ATP"}, {"label": "B", "text": "2 ATP"}, {"label": "C", "text": "4 ATP"}, {"label": "D", "text": "36 ATP"}]',
 'B',
 'Glycolysis produces a gross total of 4 ATP per glucose molecule (via substrate-level phosphorylation), but consumes 2 ATP in the energy investment phase, giving a net yield of 2 ATP. It also produces 2 NADH and 2 pyruvate molecules.',
 'easy'),

('bio_biochem', 'Metabolism',
 'Which molecule is the final electron acceptor in the mitochondrial electron transport chain?',
 '[{"label": "A", "text": "NAD+"}, {"label": "B", "text": "FAD"}, {"label": "C", "text": "Oxygen"}, {"label": "D", "text": "Carbon dioxide"}]',
 'C',
 'Molecular oxygen (O2) is the final electron acceptor in the electron transport chain. It accepts electrons from Complex IV (cytochrome c oxidase) and combines with hydrogen ions to form water. This is why we need to breathe — without oxygen, the ETC halts and ATP production via oxidative phosphorylation stops.',
 'easy'),

('bio_biochem', 'Metabolism',
 'During beta-oxidation of fatty acids, which of the following is NOT produced?',
 '[{"label": "A", "text": "Acetyl-CoA"}, {"label": "B", "text": "NADH"}, {"label": "C", "text": "FADH2"}, {"label": "D", "text": "Lactate"}]',
 'D',
 'Beta-oxidation produces acetyl-CoA, NADH, and FADH2 with each cycle of the spiral. Lactate is produced from pyruvate during anaerobic glycolysis (by lactate dehydrogenase) and is not a product of fatty acid oxidation.',
 'medium'),

-- =====================
-- CHEM/PHYS SECTION
-- =====================

('chem_phys', 'General Chemistry',
 'Which of the following solutions has the lowest pH?',
 '[{"label": "A", "text": "0.1 M NaOH"}, {"label": "B", "text": "0.1 M HCl"}, {"label": "C", "text": "0.1 M NaCl"}, {"label": "D", "text": "Pure water"}]',
 'B',
 'HCl is a strong acid that fully dissociates in solution, giving a pH of 1 at 0.1 M concentration. NaOH is a strong base (pH ~13), NaCl is a neutral salt (pH ~7), and pure water has a pH of 7. The lowest pH corresponds to the most acidic solution.',
 'easy'),

('chem_phys', 'General Chemistry',
 'A buffer solution is most effective when:',
 '[{"label": "A", "text": "The pH equals the pKa of the weak acid"}, {"label": "B", "text": "The solution contains only a strong acid"}, {"label": "C", "text": "The concentration of weak acid is much greater than its conjugate base"}, {"label": "D", "text": "The pH is at least 3 units away from the pKa"}]',
 'A',
 'A buffer is most effective (has maximum buffering capacity) when pH = pKa, because at this point the concentrations of the weak acid and its conjugate base are equal. The effective buffering range is typically pKa +/- 1. Outside this range, the buffer cannot effectively resist pH changes.',
 'medium'),

('chem_phys', 'General Chemistry',
 'The oxidation state of manganese in KMnO4 is:',
 '[{"label": "A", "text": "+3"}, {"label": "B", "text": "+5"}, {"label": "C", "text": "+7"}, {"label": "D", "text": "+2"}]',
 'C',
 'In KMnO4: K is +1, each O is -2 (total -8 for 4 oxygens). The sum of oxidation states must equal 0: (+1) + Mn + 4(-2) = 0, so Mn = +7. Permanganate (MnO4-) is a powerful oxidizing agent because of this high oxidation state.',
 'medium'),

-- Organic Chemistry
('chem_phys', 'Organic Chemistry',
 'Which of the following functional groups is present in a carboxylic acid?',
 '[{"label": "A", "text": "-OH"}, {"label": "B", "text": "-COOH"}, {"label": "C", "text": "-CHO"}, {"label": "D", "text": "-NH2"}]',
 'B',
 'The carboxylic acid functional group is -COOH (also written as -CO2H). It consists of a carbonyl group (C=O) bonded to a hydroxyl group (-OH). -OH alone is an alcohol, -CHO is an aldehyde, and -NH2 is an amine.',
 'easy'),

('chem_phys', 'Organic Chemistry',
 'In an SN2 reaction, the rate depends on the concentration of:',
 '[{"label": "A", "text": "Only the substrate"}, {"label": "B", "text": "Only the nucleophile"}, {"label": "C", "text": "Both the substrate and the nucleophile"}, {"label": "D", "text": "Neither the substrate nor the nucleophile"}]',
 'C',
 'SN2 reactions are bimolecular — the rate-determining step involves both the substrate and the nucleophile simultaneously. The rate law is: rate = k[substrate][nucleophile]. This is in contrast to SN1 reactions, where the rate depends only on the substrate concentration.',
 'medium'),

('chem_phys', 'Organic Chemistry',
 'Which molecule would you expect to have the highest boiling point?',
 '[{"label": "A", "text": "CH4 (methane)"}, {"label": "B", "text": "CH3OH (methanol)"}, {"label": "C", "text": "CH3CH3 (ethane)"}, {"label": "D", "text": "CH3F (fluoromethane)"}]',
 'B',
 'Methanol (CH3OH) has the highest boiling point because it can form hydrogen bonds due to its -OH group. Hydrogen bonds are the strongest intermolecular force among those present in these molecules. Methane and ethane only have weak London dispersion forces, and fluoromethane has dipole-dipole interactions but cannot hydrogen bond.',
 'medium'),

-- Physics
('chem_phys', 'Physics',
 'A ball is thrown vertically upward. At the highest point of its trajectory, its acceleration is:',
 '[{"label": "A", "text": "Zero"}, {"label": "B", "text": "9.8 m/s^2 downward"}, {"label": "C", "text": "9.8 m/s^2 upward"}, {"label": "D", "text": "Dependent on the initial velocity"}]',
 'B',
 'At the highest point, the velocity is momentarily zero, but the acceleration due to gravity is still 9.8 m/s^2 directed downward. Gravity acts on the ball throughout its entire flight. A common misconception is that acceleration is zero when velocity is zero.',
 'easy'),

('chem_phys', 'Physics',
 'Two resistors of 4 ohms and 6 ohms are connected in parallel. What is the equivalent resistance?',
 '[{"label": "A", "text": "2.4 ohms"}, {"label": "B", "text": "10 ohms"}, {"label": "C", "text": "5 ohms"}, {"label": "D", "text": "24 ohms"}]',
 'A',
 'For parallel resistors: 1/Req = 1/R1 + 1/R2 = 1/4 + 1/6 = 3/12 + 2/12 = 5/12. Therefore Req = 12/5 = 2.4 ohms. In parallel, the equivalent resistance is always less than the smallest individual resistor.',
 'medium'),

('chem_phys', 'Physics',
 'Sound waves are an example of:',
 '[{"label": "A", "text": "Transverse waves"}, {"label": "B", "text": "Longitudinal waves"}, {"label": "C", "text": "Electromagnetic waves"}, {"label": "D", "text": "Standing waves"}]',
 'B',
 'Sound waves are longitudinal (compression) waves — the particles of the medium vibrate parallel to the direction of wave propagation, creating alternating regions of compression and rarefaction. Transverse waves have perpendicular oscillation, and electromagnetic waves do not require a medium.',
 'easy'),

('chem_phys', 'Physics',
 'If the distance between two charged particles is doubled, the electrostatic force between them:',
 '[{"label": "A", "text": "Doubles"}, {"label": "B", "text": "Quadruples"}, {"label": "C", "text": "Is reduced to one-half"}, {"label": "D", "text": "Is reduced to one-quarter"}]',
 'D',
 'According to Coulomb''s law, F = kq1q2/r^2. The force is inversely proportional to the square of the distance. If the distance is doubled (r becomes 2r), the force becomes F/(2^2) = F/4, or one-quarter of the original force.',
 'medium'),

-- =====================
-- PSYCH/SOC SECTION
-- =====================

('psych_soc', 'Psychology',
 'According to Erikson''s stages of psychosocial development, the conflict during adolescence is:',
 '[{"label": "A", "text": "Trust vs. Mistrust"}, {"label": "B", "text": "Identity vs. Role Confusion"}, {"label": "C", "text": "Intimacy vs. Isolation"}, {"label": "D", "text": "Industry vs. Inferiority"}]',
 'B',
 'Erikson proposed that adolescents face the psychosocial crisis of Identity vs. Role Confusion. During this stage, teenagers explore their sense of self, values, and goals. Successful resolution leads to a strong identity; failure leads to confusion about one''s role in society. Trust vs. Mistrust is infancy, Industry vs. Inferiority is school age, and Intimacy vs. Isolation is young adulthood.',
 'easy'),

('psych_soc', 'Psychology',
 'Classical conditioning was first described by:',
 '[{"label": "A", "text": "B.F. Skinner"}, {"label": "B", "text": "Ivan Pavlov"}, {"label": "C", "text": "Albert Bandura"}, {"label": "D", "text": "John Watson"}]',
 'B',
 'Ivan Pavlov first described classical conditioning through his experiments with dogs, where he demonstrated that a neutral stimulus (bell) could elicit a conditioned response (salivation) after being paired with an unconditioned stimulus (food). While John Watson applied these principles to humans (Little Albert experiment), Pavlov is credited with the discovery.',
 'easy'),

('psych_soc', 'Psychology',
 'A patient with damage to Broca''s area would most likely exhibit:',
 '[{"label": "A", "text": "Inability to understand spoken language"}, {"label": "B", "text": "Difficulty producing fluent speech"}, {"label": "C", "text": "Loss of long-term memory"}, {"label": "D", "text": "Impaired visual processing"}]',
 'B',
 'Broca''s area (located in the left frontal lobe) is responsible for speech production. Damage results in Broca''s aphasia — the patient understands language but has difficulty speaking fluently. Speech is effortful, telegraphic, and often grammatically incomplete. Wernicke''s area damage would impair language comprehension.',
 'medium'),

('psych_soc', 'Psychology',
 'The "bystander effect" suggests that individuals are less likely to help in an emergency when:',
 '[{"label": "A", "text": "They are alone"}, {"label": "B", "text": "Other people are present"}, {"label": "C", "text": "The victim is a family member"}, {"label": "D", "text": "They have received first aid training"}]',
 'B',
 'The bystander effect is the phenomenon where individuals are less likely to offer help when other people are present. This is partly due to diffusion of responsibility (each person feels less personally responsible) and pluralistic ignorance (looking to others for cues and concluding the situation is not an emergency). Being alone actually increases helping behavior.',
 'easy'),

('psych_soc', 'Sociology',
 'Which sociological concept describes the process by which people learn the norms, values, and behaviors of their culture?',
 '[{"label": "A", "text": "Stratification"}, {"label": "B", "text": "Socialization"}, {"label": "C", "text": "Deviance"}, {"label": "D", "text": "Assimilation"}]',
 'B',
 'Socialization is the lifelong process through which individuals learn and internalize the values, beliefs, norms, and social skills of their culture. It occurs through agents of socialization including family, peers, schools, media, and religious institutions. Stratification refers to social hierarchies, deviance to norm violations, and assimilation to cultural adoption by immigrants.',
 'easy'),

('psych_soc', 'Sociology',
 'The concept of "stereotype threat" refers to:',
 '[{"label": "A", "text": "The tendency to form stereotypes about outgroups"}, {"label": "B", "text": "Fear of confirming a negative stereotype about one''s group"}, {"label": "C", "text": "Using stereotypes to make quick judgments"}, {"label": "D", "text": "The process of stereotype formation in childhood"}]',
 'B',
 'Stereotype threat occurs when individuals are aware of a negative stereotype about their social group and fear confirming that stereotype. This anxiety can actually impair performance, creating a self-fulfilling prophecy. For example, reminding women of gender stereotypes about math before a test can decrease their performance.',
 'medium'),

('psych_soc', 'Psychology',
 'Which neurotransmitter is most directly associated with the reward pathway in the brain?',
 '[{"label": "A", "text": "Serotonin"}, {"label": "B", "text": "GABA"}, {"label": "C", "text": "Dopamine"}, {"label": "D", "text": "Acetylcholine"}]',
 'C',
 'Dopamine is the primary neurotransmitter associated with the brain''s reward pathway (mesolimbic pathway). It plays a key role in motivation, pleasure, and reinforcement learning. Serotonin is associated with mood regulation, GABA is the main inhibitory neurotransmitter, and acetylcholine is involved in muscle activation and memory.',
 'easy'),

('psych_soc', 'Psychology',
 'According to Piaget, a child who understands that the amount of water does not change when poured from a tall, thin glass into a short, wide glass has achieved:',
 '[{"label": "A", "text": "Object permanence"}, {"label": "B", "text": "Conservation"}, {"label": "C", "text": "Egocentrism"}, {"label": "D", "text": "Accommodation"}]',
 'B',
 'Conservation is the understanding that certain properties of objects (volume, mass, number) remain the same despite changes in appearance or shape. This ability typically develops during Piaget''s concrete operational stage (ages 7-11). Object permanence is understanding that objects exist when not visible (sensorimotor stage), and egocentrism is the inability to see others'' perspectives.',
 'easy'),

('psych_soc', 'Sociology',
 'A researcher observes that children from higher-income families tend to score better on standardized tests. This is best explained by:',
 '[{"label": "A", "text": "Genetic determinism"}, {"label": "B", "text": "Social capital and access to resources"}, {"label": "C", "text": "Higher innate intelligence"}, {"label": "D", "text": "Better physical health alone"}]',
 'B',
 'Social capital — the networks, resources, and advantages available through social connections — along with access to educational resources (tutoring, books, quality schools) best explains this correlation. Higher-income families can provide more enrichment opportunities. This is a sociological explanation that accounts for structural inequalities rather than attributing differences to innate ability.',
 'medium'),

('psych_soc', 'Psychology',
 'The fight-or-flight response is primarily mediated by the:',
 '[{"label": "A", "text": "Parasympathetic nervous system"}, {"label": "B", "text": "Somatic nervous system"}, {"label": "C", "text": "Sympathetic nervous system"}, {"label": "D", "text": "Central nervous system"}]',
 'C',
 'The sympathetic nervous system activates the fight-or-flight response, releasing norepinephrine and triggering the adrenal glands to release epinephrine (adrenaline). This increases heart rate, dilates pupils, redirects blood to muscles, and prepares the body for action. The parasympathetic system does the opposite — it promotes "rest and digest" functions.',
 'easy'),

-- Additional Bio/Biochem
('bio_biochem', 'Molecular Biology',
 'Which of the following is TRUE about mRNA processing in eukaryotes?',
 '[{"label": "A", "text": "Introns are retained in the mature mRNA"}, {"label": "B", "text": "A 5'' cap and 3'' poly-A tail are added"}, {"label": "C", "text": "Processing occurs in the cytoplasm"}, {"label": "D", "text": "Splicing removes exons from the transcript"}]',
 'B',
 'Eukaryotic mRNA processing includes addition of a 5'' 7-methylguanosine cap, a 3'' poly-A tail, and splicing to remove introns (not exons). These modifications occur in the nucleus before the mature mRNA is exported to the cytoplasm for translation. The cap protects against degradation and aids in translation initiation.',
 'medium'),

('bio_biochem', 'Molecular Biology',
 'The anticodon on a tRNA molecule is complementary to:',
 '[{"label": "A", "text": "A codon on the DNA template strand"}, {"label": "B", "text": "A codon on the mRNA"}, {"label": "C", "text": "Another tRNA anticodon"}, {"label": "D", "text": "The amino acid it carries"}]',
 'B',
 'The tRNA anticodon base-pairs with the complementary codon on the mRNA during translation at the ribosome. For example, if the mRNA codon is AUG (methionine), the tRNA anticodon would be UAC. This codon-anticodon recognition ensures the correct amino acid is added to the growing polypeptide chain.',
 'easy'),

-- Additional Chem/Phys
('chem_phys', 'Physics',
 'A converging lens produces a real, inverted image when the object is placed:',
 '[{"label": "A", "text": "At the focal point"}, {"label": "B", "text": "Between the focal point and the lens"}, {"label": "C", "text": "Beyond the focal point"}, {"label": "D", "text": "At any distance from the lens"}]',
 'C',
 'A converging (convex) lens produces a real, inverted image when the object is placed beyond the focal point (do > f). When the object is at the focal point, rays emerge parallel (image at infinity). When the object is between the focal point and the lens, a virtual, upright, magnified image is produced.',
 'medium'),

('chem_phys', 'General Chemistry',
 'The hybridization of the central carbon atom in ethene (C2H4) is:',
 '[{"label": "A", "text": "sp"}, {"label": "B", "text": "sp2"}, {"label": "C", "text": "sp3"}, {"label": "D", "text": "sp3d"}]',
 'B',
 'In ethene (C2H4), each carbon forms a double bond with the other carbon and single bonds with two hydrogens. This gives three regions of electron density around each carbon, requiring sp2 hybridization. The unhybridized p orbital forms the pi bond of the double bond. sp3 would be single bonds only (like methane), and sp would be a triple bond (like acetylene).',
 'medium'),

-- Additional Psych/Soc
('psych_soc', 'Psychology',
 'Which defense mechanism involves redirecting emotions from a threatening target to a safer one?',
 '[{"label": "A", "text": "Projection"}, {"label": "B", "text": "Displacement"}, {"label": "C", "text": "Sublimation"}, {"label": "D", "text": "Rationalization"}]',
 'B',
 'Displacement involves redirecting emotional feelings (often anger) from the original source to a substitute target that is less threatening. For example, being angry at your boss but yelling at a family member instead. Projection is attributing your own feelings to others, sublimation is channeling unacceptable impulses into socially acceptable activities, and rationalization is creating logical excuses for irrational behavior.',
 'medium'),

('psych_soc', 'Sociology',
 'Which of the following best describes the concept of medicalization?',
 '[{"label": "A", "text": "The process of improving healthcare access"}, {"label": "B", "text": "The tendency to define non-medical problems as medical conditions"}, {"label": "C", "text": "The development of new medical technologies"}, {"label": "D", "text": "The training of new physicians"}]',
 'B',
 'Medicalization refers to the process by which non-medical problems become defined and treated as medical conditions, often in terms of illnesses or disorders. Examples include the medicalization of sadness into clinical depression, shyness into social anxiety disorder, or childhood misbehavior into ADHD. This concept raises questions about the expansion of medical authority into everyday life.',
 'medium');
