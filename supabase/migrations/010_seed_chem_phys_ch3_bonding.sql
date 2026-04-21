-- ============================================================
-- Praxis Prep — Chem/Phys Chapter 3: Bonding & Chemical Interactions
-- 150 MCAT-style concept questions (AAMC-style, harder than MCAT)
-- 40 easy / 60 medium / 50 hard across 11 subtopic areas
-- Run AFTER 009_add_topic_column.sql
-- ============================================================


-- ----------------------------------------------------------
-- Bonding
-- ----------------------------------------------------------
-- Q1: Octet Rule
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'A chemist adds gaseous NH3 to gaseous BF3 and the adduct F3B-NH3 forms spontaneously. Compared to free BF3, how do the formal charge on boron and the B-F bond length change in the adduct?',
  '[{"label": "A", "text": "Formal charge on B becomes -1 and B-F bond length decreases"}, {"label": "B", "text": "Formal charge on B becomes -1 and B-F bond length increases"}, {"label": "C", "text": "Formal charge on B becomes 0 and B-F bond length decreases"}, {"label": "D", "text": "Formal charge on B remains 0 and B-F bond length is unchanged"}]',
  'B',
  'The answer is B because accepting the nitrogen lone pair gives B four bonds and a formal charge of -1, and loss of F->B back-bonding lengthens the B-F bonds. In free BF3 the empty B 2p orbital accepts pi density from F lone pairs, giving B-F partial double-bond character; once N supplies a full sigma pair, the back-donation is no longer needed and the B-F bonds revert to pure single bonds. Choice A gets the formal charge right but slips on step 2 by forgetting the loss of back-bonding. Choice D ignores both changes. This is a Knowledge of Scientific Concepts and Principles question because you must recall formal charge accounting and recognize pi back-bonding as the structural consequence.',
  'hard'
);

-- Q2: Exceptions to Octet Rule
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'In the series SF4, SF6, and SeF6, which central atom carries the largest share of positive charge, and what is the best modern explanation for the existence of these hypervalent species?',
  '[{"label": "A", "text": "S in SF6; expansion into empty 3d orbitals forms six equivalent 2-electron bonds"}, {"label": "B", "text": "S in SF6; highly polar bonds with significant ionic character allow more than four attachments without true 10- or 12-electron octets"}, {"label": "C", "text": "Se in SeF6; 4d orbitals are closer in energy to 4p and directly participate in bonding"}, {"label": "D", "text": "S in SF4; the lone pair on S concentrates positive charge at the equatorial position"}]',
  'B',
  'The answer is B because SF6 has the largest electronegativity difference and the smallest central atom, giving the most polar bonds and the greatest positive charge on S, and modern computational work shows hypervalent bonding comes from ionic/3-center character rather than d-orbital mixing. Natural bond orbital analyses show d-orbital populations on S are too small to make true sp3d2 hybrids. Choice A is the textbook answer but is the exact step-2 trap the question targets. Choice C uses the right reasoning but on the wrong atom. This is a Knowledge of Scientific Concepts and Principles question because you must recall the current understanding of hypervalency and compare polarity across a size-varied series.',
  'hard'
);

-- Q3: Exceptions to Octet Rule
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'Nitric oxide (NO) dimerizes reversibly to N2O2 only at very low temperatures, with a weak N-N bond (~10 kJ/mol). Which feature of NO best explains why the dimer is so weakly bound?',
  '[{"label": "A", "text": "The unpaired electron in NO occupies a pi* antibonding orbital, so pairing it gives only a small net bonding gain"}, {"label": "B", "text": "Dimerization requires breaking the N=O pi bond, which is energetically costly"}, {"label": "C", "text": "The NO molecule is diamagnetic, so dimerization has no driving force"}, {"label": "D", "text": "Dimerization would place two nitrogen lone pairs in antibonding orbitals"}]',
  'A',
  'The answer is A because NO''s single unpaired electron sits in a pi* orbital, and coupling two pi* electrons in the dimer raises bonding character only slightly while retaining most of the antibonding energy. Choice B is wrong because dimerization preserves the intramolecular N=O bonds. Choice C contradicts NO''s well-known paramagnetism. Choice D invokes lone pairs rather than the relevant antibonding electrons. This is a Scientific Reasoning and Problem Solving question because you must apply molecular orbital bond-order reasoning to an odd-electron species.',
  'hard'
);

-- Q4: Types of Chemical Bonds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'Four solids at 25 C are tested: (I) KCl, (II) diamond, (III) solid I2, (IV) Cu. Which ordering from LOWEST to HIGHEST electrical conductivity in the pure solid state is correct?',
  '[{"label": "A", "text": "III < II < I < IV"}, {"label": "B", "text": "II < III < I < IV"}, {"label": "C", "text": "III < I < II < IV"}, {"label": "D", "text": "I < III < II < IV"}]',
  'A',
  'The answer is A because solid I2 (molecular, no mobile carriers) and diamond (localized sigma network, wide band gap) are essentially insulators, solid KCl has a very small ionic conductivity from slow ion hopping through defects, and Cu has a delocalized electron sea. The key step-2 trap is remembering that solid ionic compounds DO conduct slightly above room temperature via defect migration, making KCl > diamond in the solid. Choice B reverses this and is the predictable slip. This is a Knowledge of Scientific Concepts and Principles question because you must recall how each bonding type governs charge-carrier availability.',
  'medium'
);

-- Q5: Types of Chemical Bonds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'A student dissolves 0.10 mol of each of two compounds in 1.0 L of water. Compound X yields a conductivity that matches Kohlrausch''s law for a strong 1:1 electrolyte; compound Y shows conductivity about 3% of that value and obeys Ostwald''s dilution law. Which conclusion is best supported?',
  '[{"label": "A", "text": "X is an ionic solid; Y is a weak acid or weak base that only partially ionizes"}, {"label": "B", "text": "X is a strong covalent network; Y is a nonelectrolyte sugar"}, {"label": "C", "text": "X is a nonpolar molecular compound; Y is an ionic hydrate"}, {"label": "D", "text": "Both are ionic, but Y has lower solubility"}]',
  'A',
  'The answer is A because Kohlrausch behavior at a single concentration is the signature of full dissociation (ionic), while Ostwald''s dilution law is the signature of an equilibrium between molecule and ions (weak electrolyte). Choice B is wrong because a nonelectrolyte would give ~0% conductivity, not 3%. Choice D confuses solubility with ionization; a partially soluble ionic compound still obeys Kohlrausch for what is dissolved. This is a Data-based and Statistical Reasoning question because you must interpret quantitative conductivity behavior to classify the bonding types.',
  'hard'
);

-- Q6: Electronegativity and Bond Character
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'Going from HF to HI, the bond dipole moment (in Debye) decreases from 1.83 to 0.42 and the bond length increases from 0.92 to 1.61 angstroms. Based on these data, what is the approximate trend in percent ionic character, and what causes the trend?',
  '[{"label": "A", "text": "Ionic character decreases because mu/(e*d) falls; the dominant factor is the decreasing electronegativity difference"}, {"label": "B", "text": "Ionic character increases because mu increases; the dominant factor is better orbital overlap"}, {"label": "C", "text": "Ionic character is approximately constant because mu and d both change proportionally"}, {"label": "D", "text": "Ionic character decreases only because the bond becomes longer; electronegativity is irrelevant"}]',
  'A',
  'The answer is A because percent ionic character is mu/(e*d), and while d grows, mu shrinks much faster, so the ratio drops; the underlying cause is that the halogen becomes less electronegative down the group. For HF, mu/(e*d) is roughly 42%; for HI it is about 5%. Choice B inverts the trend. Choice D is the step-2 slip: it identifies one factor in the formula but ignores the physical cause. This is a Scientific Reasoning and Problem Solving question because you must apply the mu/(e*d) definition to experimental data.',
  'hard'
);

-- Q7: Electronegativity and Bond Character
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'Given electronegativities H = 2.1, C = 2.5, N = 3.0, O = 3.5, F = 4.0, which ordering of bonds is correct from LEAST to MOST ionic character?',
  '[{"label": "A", "text": "C-H < C-N < C-O < H-F"}, {"label": "B", "text": "C-H < C-O < C-N < H-F"}, {"label": "C", "text": "C-N < C-H < C-O < H-F"}, {"label": "D", "text": "C-H < C-N < H-F < C-O"}]',
  'A',
  'The answer is A because percent ionic character tracks the absolute electronegativity difference: C-H = 0.4, C-N = 0.5, C-O = 1.0, H-F = 1.9. Choice B swaps the middle pair by comparing without computing. Choice D commits the common slip of treating H-F as less ionic than C-O because H is less electronegative than C, forgetting that ionic character depends on the DIFFERENCE, not the absolute value. This is a Knowledge of Scientific Concepts and Principles question because you must recall that ionic character scales with |delta-EN|.',
  'medium'
);

-- Q8: Octet Rule
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'For the linear molecule N2O (N=N=O connectivity), two major resonance structures contribute. In the structure with the most favorable formal-charge distribution, what are the formal charges on the terminal N, central N, and O, respectively?',
  '[{"label": "A", "text": "0, 0, 0"}, {"label": "B", "text": "-1, +1, 0"}, {"label": "C", "text": "0, +1, -1"}, {"label": "D", "text": "-2, +1, +1"}]',
  'B',
  'The answer is B because the structure :N(triple bond)N(+)-O(-): keeps the negative charge on the more electronegative O only in the other contributor, while the structure :N(-)=N(+)=O: places the negative on the LESS electronegative terminal N. However, experimental dipole direction shows the terminal N end is negative, so -1, +1, 0 is the leading contributor. Choice C is the trap: students assume ''negative belongs on the more electronegative atom'' without checking which resonance form is actually dominant for N2O. Choice A violates octet for the central N. This is a Scientific Reasoning and Problem Solving question because you must apply formal-charge rules and evaluate which resonance form dominates.',
  'hard'
);

-- Q9: Types of Chemical Bonds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'In the complex [Fe(CN)6]^4-, the Fe-C interaction is best described as containing which combination of bonding components?',
  '[{"label": "A", "text": "A pure ionic interaction between Fe2+ and CN-"}, {"label": "B", "text": "A sigma dative bond from C to Fe plus pi back-donation from filled Fe d orbitals to CN pi* orbitals"}, {"label": "C", "text": "A sigma dative bond from Fe to C with no pi component"}, {"label": "D", "text": "Six equivalent nonpolar covalent bonds"}]',
  'B',
  'The answer is B because CN- is a strong-field ligand precisely because it donates sigma density from C to Fe and accepts pi density from filled metal t2g orbitals into its pi* orbitals, synergically stabilizing the low-spin complex. Choice A ignores the covalent character that low-spin splitting demands. Choice C is the step-2 slip: students identify the sigma donation but forget the back-bonding that makes CN- a strong-field ligand. This is a Knowledge of Scientific Concepts and Principles question because you must recall synergic sigma/pi bonding in transition metal complexes.',
  'medium'
);

-- Q10: Exceptions to Octet Rule
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'A student considers whether NF5 could exist as an analogue of PF5. Beyond the usual argument about the absence of n = 2 d orbitals, which additional steric/electronic factor makes NF5 especially unfavorable?',
  '[{"label": "A", "text": "N-F bonds are too weak to overcome F-F electron repulsion in the trigonal bipyramid"}, {"label": "B", "text": "The covalent radius of nitrogen (~70 pm) is too small to accommodate five fluorines without severe F...F repulsion"}, {"label": "C", "text": "Nitrogen''s first ionization energy is too high to form the required N5+ cation"}, {"label": "D", "text": "Fluorine''s electron affinity is insufficient to stabilize the extra bond"}]',
  'B',
  'The answer is B because nitrogen''s small covalent radius produces F...F contacts well below the sum of fluorine van der Waals radii, so even if d-orbital participation were not an issue, steric crowding alone destabilizes NF5. Choice A is a real factor but it is not the PRIMARY reason given that N-F bonds are individually strong. Choice C confuses covalent hypervalency with ionization. This is a Scientific Reasoning and Problem Solving question because you must apply geometric reasoning to predict instability.',
  'hard'
);

-- Q11: Electronegativity and Bond Character
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'The experimental dipole moment of LiH is 5.88 D and the bond length is 1.60 angstroms. Using mu(ionic) = e * d with e = 1.602e-19 C and 1 D = 3.336e-30 C*m, what is the approximate percent ionic character of the Li-H bond?',
  '[{"label": "A", "text": "About 25%"}, {"label": "B", "text": "About 77%"}, {"label": "C", "text": "About 41%"}, {"label": "D", "text": "About 95%"}]',
  'B',
  'The answer is B because mu(100% ionic) = (1.602e-19)(1.60e-10)/3.336e-30 ~ 7.68 D, and 5.88/7.68 ~ 0.77 or 77%. Choice C is the trap for students who divide mu by e*d but forget to convert Debye to C*m (or who use d in angstroms without converting to meters). Choice A is the mistake of comparing electronegativity differences qualitatively rather than computing. This is a Scientific Reasoning and Problem Solving question because you must apply mu/(e*d) with correct unit conversions.',
  'hard'
);

-- Q12: Octet Rule
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Bonding',
  'In the most stable Lewis structure for the cyanide ion (CN-), what are the formal charges on C and N, and what is the C-N bond order?',
  '[{"label": "A", "text": "C = -1, N = 0, bond order 3"}, {"label": "B", "text": "C = 0, N = -1, bond order 3"}, {"label": "C", "text": "C = -1, N = 0, bond order 2"}, {"label": "D", "text": "C = 0, N = -1, bond order 2"}]',
  'A',
  'The answer is A because the triple-bonded structure :C(triple bond)N: gives C = 4 - 2 - 3 = -1 and N = 5 - 2 - 3 = 0, and both atoms satisfy the octet only with a triple bond. Choice B is the intuitive slip: students place the negative charge on the more electronegative atom without computing formal charge. Choices C and D give only two bonds, leaving C or N short of an octet. Note that CN- behaves chemically as a C-centered nucleophile, consistent with the -1 on C. This is a Knowledge of Scientific Concepts and Principles question because you must recall formal-charge accounting and octet requirements.',
  'hard'
);


-- ----------------------------------------------------------
-- Ionic Bonds
-- ----------------------------------------------------------
-- Q13: Lattice Energy
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'MgO and NaF have similar interionic distances (about 2.1 and 2.3 angstroms) but the lattice energy of MgO (~3795 kJ/mol) is roughly 4x that of NaF (~923 kJ/mol). What factor in the Born-Lande expression U proportional to (q1*q2)/r accounts for this ratio?',
  '[{"label": "A", "text": "The distance ratio alone, because U depends inversely on r"}, {"label": "B", "text": "The product of the charges, because (2)(2)/(1)(1) = 4"}, {"label": "C", "text": "The Madelung constant, which differs between rock salt structures"}, {"label": "D", "text": "The difference in electronegativity between Mg-O and Na-F"}]',
  'B',
  'The answer is B because the Born-Lande expression makes U proportional to (q1*q2)/r, and doubling each charge gives a 4x product while the r values are nearly equal and the Madelung constants are identical (both rock salt). Choice C is a distractor: same structure means same Madelung constant. Choice D confuses bond polarity with lattice electrostatics. This is a Scientific Reasoning and Problem Solving question because you must apply the lattice energy formula to compare two salts with matched geometry.',
  'hard'
);

-- Q14: Cation and Anion Formation
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'Manganese can in principle lose up to seven electrons (Mn7+ is observed in permanganate, MnO4-), yet in simple ionic salts Mn2+ is by far the most common. Which factor MOST directly explains the special stability of Mn2+?',
  '[{"label": "A", "text": "Mn2+ has a half-filled 3d^5 configuration with maximized exchange stabilization"}, {"label": "B", "text": "Mn2+ has completely filled 3d^10 and is therefore noble-gas-like"}, {"label": "C", "text": "Mn2+ has the smallest ionic radius of all manganese cations"}, {"label": "D", "text": "Mn2+ forms only in strongly basic solution where other oxidation states are unstable"}]',
  'A',
  'The answer is A because Mn (3d^5 4s^2) loses its two 4s electrons to give the half-filled 3d^5 configuration, which has an unusually large exchange energy (five unpaired electrons, maximum spin multiplicity). Choice B confuses half-filled with fully filled. Choice C is true but does not drive the stability. Higher oxidation states exist (Mn7+ in MnO4-) but require covalent, not ionic, bonding. This is a Knowledge of Scientific Concepts and Principles question because you must recall exchange-energy stabilization of half-filled subshells.',
  'medium'
);

-- Q15: Lattice Energy
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'Rank the following in order of INCREASING magnitude of lattice energy: KCl, LiCl, CaO, MgO, Al2O3.',
  '[{"label": "A", "text": "KCl < LiCl < CaO < MgO < Al2O3"}, {"label": "B", "text": "LiCl < KCl < MgO < CaO < Al2O3"}, {"label": "C", "text": "KCl < LiCl < MgO < CaO < Al2O3"}, {"label": "D", "text": "KCl < LiCl < CaO < Al2O3 < MgO"}]',
  'A',
  'The answer is A because for 1:1 salts charge dominates (CaO and MgO with 2+/2- beat KCl and LiCl with 1+/1-), within same-charge pairs the smaller ion wins (LiCl > KCl, MgO > CaO), and Al2O3 with 3+/2- has the largest lattice energy. Choice B reverses LiCl/KCl by size and confuses MgO with CaO. Choice D is the trap for students who know charge dominates but forget that ionic radius still matters when charges are equal, and who think ''2+ times 3+'' with two cations beats Al2O3. This is a Scientific Reasoning and Problem Solving question because you must apply q1*q2/r to five salts simultaneously.',
  'medium'
);

-- Q16: Properties of Ionic Compounds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'Among NaF (mp 993 C), MgO (mp 2852 C), AgCl (mp 455 C), and CsI (mp 626 C), which PAIR of factors best explains why AgCl has a much lower melting point than NaF despite similar sizes and both being 1:1 salts?',
  '[{"label": "A", "text": "Smaller lattice energy of AgCl due to more polar bonds and greater Madelung constant"}, {"label": "B", "text": "Polarization of Cl- by the more polarizing Ag+ gives substantial covalent character, lowering effective lattice stability"}, {"label": "C", "text": "The d10 configuration of Ag+ increases lattice ionicity relative to Na+"}, {"label": "D", "text": "AgCl crystallizes with a different Madelung constant because of its layered structure"}]',
  'B',
  'The answer is B because Fajans'' rules predict that a small, highly charged cation with a filled d subshell (Ag+) strongly polarizes a soft anion (Cl-), introducing covalent character that weakens the overall ionic lattice even though the formal charges are identical. Choice A contradicts itself (more polar bonds would raise, not lower, mp). Choice C inverts the effect. AgCl and NaCl both adopt the rock-salt structure, so Choice D is false. This is a Knowledge of Scientific Concepts and Principles question because you must recall Fajans'' polarizability concept.',
  'hard'
);

-- Q17: Born-Haber Cycle
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'For LiF(s) given: sublimation of Li = +161, first ionization of Li = +520, 1/2 bond energy of F2 = +79, electron affinity of F = -328, and enthalpy of formation of LiF(s) = -617 kJ/mol, what is the lattice energy of LiF (defined as the energy released when gas-phase ions combine to form the solid)?',
  '[{"label": "A", "text": "-1049 kJ/mol"}, {"label": "B", "text": "+1049 kJ/mol"}, {"label": "C", "text": "-617 kJ/mol"}, {"label": "D", "text": "-1205 kJ/mol"}]',
  'A',
  'The answer is A because Hess''s law gives delta Hf = sub(Li) + IE(Li) + 1/2 BE(F2) + EA(F) + U, so U = -617 - 161 - 520 - 79 - (-328) = -1049 kJ/mol. Choice B has the correct magnitude but wrong sign (the trap for students who write U as ''energy required to separate'' rather than ''energy released to form''). Choice D forgets to subtract electron affinity. This is a Scientific Reasoning and Problem Solving question because you must apply Hess''s law sign conventions correctly.',
  'hard'
);

-- Q18: Properties of Ionic Compounds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'Molten MgCl2 conducts electricity, but the electrical conductivity per mole of charge carriers is LOWER than for molten NaCl. Which factor best explains this?',
  '[{"label": "A", "text": "Mg2+ has a smaller ionic radius and higher charge density, causing stronger ion-ion attraction and reduced ion mobility"}, {"label": "B", "text": "Molten MgCl2 has lower ionic conductivity because magnesium forms molecular MgCl2 rather than free ions"}, {"label": "C", "text": "Mg2+ carries twice the charge and therefore moves twice as fast"}, {"label": "D", "text": "Molten MgCl2 is more viscous because of covalent networks"}]',
  'A',
  'The answer is A because Mg2+ has a very high charge-to-radius ratio, so Coulombic drag between it and Cl- increases the viscosity felt by the moving ions, lowering their mobility. Choice B is wrong because MgCl2 dissociates essentially completely when molten. Choice C confuses charge with mobility; higher charge increases drag, not speed. This is a Scientific Reasoning and Problem Solving question because you must apply charge-density reasoning to ionic mobility.',
  'easy'
);

-- Q19: Born-Haber Cycle
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'Two hypothetical 1:1 salts, AX and AY, have Born-Haber cycles that are identical except that the electron affinity of Y (-295 kJ/mol) is less negative than that of X (-349 kJ/mol), and the lattice energy of AY is 95 kJ/mol less negative than AX. If delta Hf for AX is -410 kJ/mol, what is delta Hf for AY?',
  '[{"label": "A", "text": "-261 kJ/mol"}, {"label": "B", "text": "-369 kJ/mol"}, {"label": "C", "text": "-505 kJ/mol"}, {"label": "D", "text": "-410 kJ/mol"}]',
  'A',
  'The answer is A because delta Hf(AY) - delta Hf(AX) = [EA(Y) - EA(X)] + [U(AY) - U(AX)] = (-295 - (-349)) + (95) = 54 + 95 = +149 kJ/mol, giving delta Hf(AY) = -410 + 149 = -261 kJ/mol. Choice B ignores the EA difference. Choice C adds signs in the wrong direction and is the step-2 trap. This is a Scientific Reasoning and Problem Solving question because you must apply Hess''s law with careful sign tracking.',
  'hard'
);

-- Q20: Cation and Anion Formation
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'The successive ionization energies (kJ/mol) of an element X are: 738, 1451, 7733, 10540, 13630. Based on this pattern, which group does X most likely belong to, and what is its most probable common ionic charge in compounds?',
  '[{"label": "A", "text": "Group 2; X2+"}, {"label": "B", "text": "Group 1; X+"}, {"label": "C", "text": "Group 13; X3+"}, {"label": "D", "text": "Group 14; X4+"}]',
  'A',
  'The answer is A because the huge jump occurs between the 2nd and 3rd ionization energies (1451 -> 7733), indicating that removal of the third electron would breach a noble-gas core; X therefore has exactly two valence electrons. Choice B would show the jump between the 1st and 2nd. Choice C would show it between the 3rd and 4th. This is a Data-based and Statistical Reasoning question because you must interpret the ionization-energy pattern to deduce electron configuration.',
  'medium'
);

-- Q21: Properties of Ionic Compounds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'A student dissolves Na2SO4, Na2S, and BaSO4 in water at 25 C. Only BaSO4 fails to dissolve appreciably (Ksp ~ 1e-10). Using thermodynamic reasoning, which BEST explains why BaSO4 is effectively insoluble while the two sodium salts dissolve readily?',
  '[{"label": "A", "text": "Dissolution of BaSO4 has an unfavorable enthalpy because its lattice energy exceeds the combined hydration enthalpies of Ba2+ and SO4^2-"}, {"label": "B", "text": "Dissolution of BaSO4 is entropically forbidden because two ions form from one formula unit"}, {"label": "C", "text": "Ba2+ and SO4^2- form covalent bonds in solution"}, {"label": "D", "text": "The hydration enthalpy of Na+ is so large that only Na salts dissolve"}]',
  'A',
  'The answer is A because both ions in BaSO4 are large and doubly charged, giving a high lattice energy that exceeds the hydration enthalpy, so dissolution is endothermic and the unfavorable enthalpy dominates the small entropy gain. Choice B inverts the entropy argument (dissolution generally increases entropy). Choice D treats Na hydration as explanatory when the real issue is the BaSO4 lattice. This is a Scientific Reasoning and Problem Solving question because you must compare lattice and hydration enthalpies to rationalize solubility.',
  'medium'
);

-- Q22: Lattice Energy
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'CaF2 has a lattice energy of 2651 kJ/mol and NaF has a lattice energy of 923 kJ/mol. The ionic radii are similar (Ca2+ ~100 pm, Na+ ~102 pm, F- ~133 pm). Besides the increase in cation charge, what additional structural feature of CaF2 amplifies its lattice energy relative to that of NaF?',
  '[{"label": "A", "text": "CaF2 adopts a rock-salt lattice, which has a higher Madelung constant than NaF"}, {"label": "B", "text": "CaF2 adopts the fluorite structure, in which each Ca2+ is surrounded by eight F-, giving a higher total of Coulombic interactions per formula unit"}, {"label": "C", "text": "CaF2 has covalent character not present in NaF"}, {"label": "D", "text": "F- ions in CaF2 are more polarizable than those in NaF"}]',
  'B',
  'The answer is B because NaF crystallizes in the 6-coordinate rock-salt structure while CaF2 adopts the fluorite structure with 8:4 coordination, and the larger number of nearest-neighbor attractions (higher Madelung constant) increases the lattice energy beyond the q1*q2 effect. Choice A has NaF and CaF2 confused. Choice C invokes a negligible factor. This is a Knowledge of Scientific Concepts and Principles question because you must recall that coordination number and Madelung constant both enter the Born-Lande expression.',
  'hard'
);

-- Q23: Cation and Anion Formation
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'Pb is in group 14 but commonly forms Pb2+ rather than Pb4+ in ionic compounds, while Sn forms both Sn2+ and Sn4+ readily. What is the most accepted explanation for the preference for Pb2+?',
  '[{"label": "A", "text": "The inert-pair effect: relativistic contraction stabilizes the 6s^2 pair in Pb so that only the 6p electrons are readily lost"}, {"label": "B", "text": "Pb2+ has a half-filled 5d^5 subshell, which is unusually stable"}, {"label": "C", "text": "Pb4+ is too small to form a stable lattice with most anions"}, {"label": "D", "text": "The hydration enthalpy of Pb4+ is endergonic"}]',
  'A',
  'The answer is A because relativistic effects contract and stabilize 6s orbitals more than 5s, making the 6s^2 pair of Pb energetically reluctant to ionize (the ''inert pair''), so Pb preferentially loses its two 6p electrons to give Pb2+. Choice B invents a half-filled d configuration that Pb2+ does not have. Choice C confuses size with stability. This is a Knowledge of Scientific Concepts and Principles question because you must recall the inert-pair effect for heavy p-block elements.',
  'medium'
);

-- Q24: Born-Haber Cycle
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'A student asks why MgCl rather than MgCl2 is not the thermodynamically favored product of Mg + 1/2 Cl2. Which Born-Haber term makes delta Hf for hypothetical MgCl much less negative than delta Hf for MgCl2?',
  '[{"label": "A", "text": "The high second ionization energy of Mg makes MgCl2 less favorable than MgCl"}, {"label": "B", "text": "The much larger lattice energy of MgCl2 more than compensates for the large second ionization energy of Mg, whereas MgCl has only a modest lattice energy"}, {"label": "C", "text": "The electron affinity of Cl is not large enough to stabilize MgCl"}, {"label": "D", "text": "The sublimation enthalpy of Mg is too large for MgCl to form"}]',
  'B',
  'The answer is B because going from MgCl (hypothetical 1+/1-) to MgCl2 (2+/2 times 1-) dramatically increases the lattice energy (~2500 vs ~800 kJ/mol) due to the doubled charge on Mg and the addition of another Cl- to the lattice, and this gain outweighs the cost of the second ionization of Mg. Choice A has the sign exactly backwards. Choice C and D miss the real driver. This is a Scientific Reasoning and Problem Solving question because you must evaluate Born-Haber energetics for a non-standard stoichiometry.',
  'hard'
);

-- Q25: Properties of Ionic Compounds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Ionic Bonds',
  'A materials engineer needs a hard, high-melting ceramic for a cutting tool. Of the following ionic compounds, which combination of cation/anion characteristics gives the highest expected melting point?',
  '[{"label": "A", "text": "Small, highly charged cation with small, highly charged anion (e.g., Al2O3)"}, {"label": "B", "text": "Large cation with small, highly charged anion (e.g., Cs2O)"}, {"label": "C", "text": "Small cation with large, singly charged anion (e.g., LiI)"}, {"label": "D", "text": "Large cation with large, singly charged anion (e.g., CsI)"}]',
  'A',
  'The answer is A because melting point tracks lattice energy, which scales as q1*q2/r, so both high charges and small radii maximize it. Al2O3 has 3+ and 2- ions with small radii, giving a lattice energy above 15000 kJ/mol and a melting point above 2000 C. Choice B maximizes only one of the factors. This is a Knowledge of Scientific Concepts and Principles question because you must recall that lattice energy (hence mp) maximizes when both charge and inverse radius are maximized.',
  'medium'
);


-- ----------------------------------------------------------
-- Covalent Bonds
-- ----------------------------------------------------------
-- Q26: Bond Order
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'An IR spectroscopist measures the N-O stretching frequency for NO+, NO, and NO- (approximately 2377, 1876, and 1470 cm^-1, respectively). Based on MO theory, what are the bond orders of these three species?',
  '[{"label": "A", "text": "3, 2.5, 2"}, {"label": "B", "text": "2, 2.5, 3"}, {"label": "C", "text": "3, 2, 1.5"}, {"label": "D", "text": "2.5, 2, 1.5"}]',
  'A',
  'The answer is A because removing an electron from NO''s pi* orbital to form NO+ gives (8-2)/2 = 3, NO itself has (8-3)/2 = 2.5, and adding one more electron to pi* gives NO- with (8-4)/2 = 2. The IR trend confirms this: higher bond order -> stiffer spring -> higher frequency. Choice B reverses the trend by assigning bond order to electron count rather than to bonding minus antibonding. This is a Scientific Reasoning and Problem Solving question because you must apply the MO bond-order formula to a heteronuclear diatomic.',
  'hard'
);

-- Q27: Bond Length
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'C-O bond lengths in CO (112.8 pm), CO2 (116.3 pm), formate HCOO- (127 pm), and methanol (143 pm) are listed. Which statement best characterizes the relationship between bond order and bond length across these species, and why does formate fit between CO2 and methanol?',
  '[{"label": "A", "text": "Bond length increases as bond order decreases; formate has a resonance-averaged bond order of 1.5"}, {"label": "B", "text": "Bond length and bond order are not systematically related; formate''s length reflects hybridization alone"}, {"label": "C", "text": "Bond length decreases with bond order; formate has a bond order of 2 like CO2"}, {"label": "D", "text": "Bond length is controlled entirely by atomic size and is independent of bond order here"}]',
  'A',
  'The answer is A because each increase in bond order (1, 1.5, 2, 3) pulls the atoms closer, and the formate ion''s two equivalent C-O bonds average a single and double bond to give order 1.5, landing its bond length between single-bond methanol and double-bond CO2. Choice C misassigns the formate bond order. Choice B dismisses a clean trend. This is a Data-based and Statistical Reasoning question because you must interpret bond-length data in terms of resonance-averaged bond order.',
  'hard'
);

-- Q28: Bond Energy
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'Using average bond energies C-H = 413, O=O = 498, C=O = 799, O-H = 463 kJ/mol, estimate delta H for CH4(g) + 2 O2(g) -> CO2(g) + 2 H2O(g).',
  '[{"label": "A", "text": "-810 kJ"}, {"label": "B", "text": "-498 kJ"}, {"label": "C", "text": "+810 kJ"}, {"label": "D", "text": "-1660 kJ"}]',
  'A',
  'The answer is A because delta H = (bonds broken) - (bonds formed) = [4(413) + 2(498)] - [2(799) + 4(463)] = [1652 + 996] - [1598 + 1852] = 2648 - 3450 = -802 kJ, which rounds to -810 given the tabulated averages. Choice B forgets the O=O bonds. Choice C is the step-2 slip of reversing the sign convention (forming - breaking). This is a Scientific Reasoning and Problem Solving question because you must apply delta H = Sigma(bonds broken) - Sigma(bonds formed) to a combustion reaction.',
  'hard'
);

-- Q29: Bond Order
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'In the nitrate ion (NO3-), which has three equivalent resonance structures, what is the N-O bond order, and what is the formal charge on nitrogen in each contributing structure?',
  '[{"label": "A", "text": "Bond order 1.33; formal charge on N = +1"}, {"label": "B", "text": "Bond order 1.33; formal charge on N = 0"}, {"label": "C", "text": "Bond order 1.5; formal charge on N = +1"}, {"label": "D", "text": "Bond order 2; formal charge on N = +1"}]',
  'A',
  'The answer is A because each resonance form has one N=O and two N-O bonds, so averaging gives (2+1+1)/3 = 1.33, and in each structure nitrogen has four bonds (one double, two single) with no lone pair, giving formal charge 5 - 0 - 4 = +1. Choice C incorrectly uses 1.5 (the carbonate value for three bonds averaged from two single and one double among THREE, common slip). This is a Scientific Reasoning and Problem Solving question because you must apply resonance-averaging and formal-charge rules together.',
  'hard'
);

-- Q30: Bond Length
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'A student predicts the C-C bond length in benzene from ethane (154 pm), ethylene (134 pm), and acetylene (120 pm). Using a linear interpolation based on bond order, what bond length does a pi-bond order of 1.5 predict, and how does it compare to the experimental value of 139 pm?',
  '[{"label": "A", "text": "~144 pm; the experimental value is shorter because delocalization is stronger than a simple average suggests"}, {"label": "B", "text": "~134 pm; the experimental value matches because benzene is really three double bonds"}, {"label": "C", "text": "~154 pm; benzene behaves like a ring of single bonds"}, {"label": "D", "text": "~120 pm; benzene has triple-bond character"}]',
  'A',
  'The answer is A because a linear interpolation between 134 and 154 pm at order 1.5 gives 144 pm, but the experimental 139 pm is shorter because cyclic pi delocalization provides extra bond shortening beyond what a simple two-structure average predicts. Choice B conflates the dominant Lewis picture with reality. Choice C ignores the pi system entirely. This is a Scientific Reasoning and Problem Solving question because you must apply an interpolation model and recognize its limits.',
  'hard'
);

-- Q31: Bond Energy
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'The C=C bond energy (614 kJ/mol) is less than twice the C-C bond energy (348 kJ/mol). What does this imply about the individual pi bond energy in ethylene, and why is the pi bond weaker than the sigma bond?',
  '[{"label": "A", "text": "pi bond ~ 266 kJ/mol; sideways p-p overlap is less efficient than head-on sp3-sp3 overlap"}, {"label": "B", "text": "pi bond ~ 614 kJ/mol; the pi bond is stronger because it uses pure p orbitals"}, {"label": "C", "text": "pi bond ~ 348 kJ/mol; it equals the sigma bond since both are formed from p orbitals"}, {"label": "D", "text": "pi bond ~ 962 kJ/mol; the pi system of ethylene is very strong"}]',
  'A',
  'The answer is A because the pi bond energy is estimated as 614 - 348 = 266 kJ/mol, and the lower value reflects that sideways overlap of p orbitals above and below the internuclear axis is less effective than the head-on sigma overlap. Choice B inverts the physical intuition. This also explains why C=C can be twisted relatively easily around the double bond. This is a Scientific Reasoning and Problem Solving question because you must apply bond-energy partitioning to distinguish sigma and pi components.',
  'hard'
);

-- Q32: Coordinate Covalent Bonds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'In the ammonium ion NH4+, spectroscopic measurements show that all four N-H bonds have the same length and energy, even though one was formed by donation of nitrogen''s lone pair to H+. Which statement best explains this equivalence?',
  '[{"label": "A", "text": "Once formed, the four bonds share a common set of sigma molecular orbitals derived from sp3 hybrids, so the ''coordinate'' label describes only the origin, not the final bonding"}, {"label": "B", "text": "The coordinate bond is always 25% weaker than normal covalent bonds, but rotation makes it appear equivalent"}, {"label": "C", "text": "Proton tunneling between the four positions averages the bond lengths"}, {"label": "D", "text": "Electron density is localized on the hydrogen atoms"}]',
  'A',
  'The answer is A because after sp3 hybridization and symmetry-adapted orbital combinations, all four N-H bonds are indistinguishable; the ''coordinate'' vs ''normal'' distinction is a bookkeeping artifact from the Lewis picture. Choice B invents a weakness that experiment rules out. Choice C invents dynamics that do not happen. This is a Knowledge of Scientific Concepts and Principles question because you must recall that bond equivalence arises from the molecular orbital symmetry of NH4+.',
  'hard'
);

-- Q33: Coordinate Covalent Bonds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'Carbon monoxide binds to Fe(II) in hemoglobin through carbon rather than oxygen, despite oxygen being more electronegative. Which explanation best accounts for this orientation?',
  '[{"label": "A", "text": "Carbon carries a small negative formal charge in CO and has the larger HOMO lobe, making it the better sigma donor; Fe also back-donates into CO pi* orbitals"}, {"label": "B", "text": "Oxygen is sterically blocked by the porphyrin ring"}, {"label": "C", "text": "The Fe-O bond would be ionic and unstable"}, {"label": "D", "text": "CO binds through the carbon lone pair because carbon is less electronegative and therefore more nucleophilic"}]',
  'A',
  'The answer is A because the CO Lewis structure :C(triple bond)O: gives C a formal charge of -1 despite O being more electronegative, and the HOMO is a C-centered lone pair; Fe also engages in pi back-donation into CO''s pi* orbitals, which is optimized with C closest to the metal. Choice D captures the right conclusion for the wrong reason (nucleophilicity is about HOMO energy, not just electronegativity). This is a Knowledge of Scientific Concepts and Principles question because you must reconcile formal charge, HOMO location, and back-bonding.',
  'medium'
);

-- Q34: Bond Energy
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'Using bond energies N(triple bond)N = 941, H-H = 436, and N-H = 391 kJ/mol, estimate delta H for N2(g) + 3 H2(g) -> 2 NH3(g).',
  '[{"label": "A", "text": "-166 kJ"}, {"label": "B", "text": "-103 kJ"}, {"label": "C", "text": "+103 kJ"}, {"label": "D", "text": "-509 kJ"}]',
  'B',
  'The answer is B because delta H = [941 + 3(436)] - [6(391)] = [941 + 1308] - 2346 = 2249 - 2346 = -97 kJ, which rounds to approximately -100 kJ (experimental ~ -92 kJ). Choice A is the common trap for students who count 2 NH3 as 2 N-H bonds instead of 6. Choice C reverses the sign. This is a Scientific Reasoning and Problem Solving question because you must apply bond-counting stoichiometry without slips.',
  'hard'
);

-- Q35: Bond Order
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'Using MO theory for homonuclear diatomics of period 2, rank the bond orders of O2^2-, O2-, O2, and O2+, and identify the species with the shortest O-O bond.',
  '[{"label": "A", "text": "O2+ > O2 > O2- > O2^2-; shortest bond is O2+"}, {"label": "B", "text": "O2 > O2+ > O2- > O2^2-; shortest bond is O2"}, {"label": "C", "text": "O2+ > O2- > O2 > O2^2-; shortest bond is O2+"}, {"label": "D", "text": "O2^2- > O2- > O2 > O2+; shortest bond is O2^2-"}]',
  'A',
  'The answer is A because adding electrons to pi* orbitals lowers the bond order: O2+ = 2.5, O2 = 2, O2- = 1.5, O2^2- = 1. The species with the highest bond order has the shortest, strongest bond, which is O2+ at ~112 pm (compared to O2 at 121 pm, O2- at 128 pm, O2^2- at 149 pm). Choice D inverts the MO trend. This is a Knowledge of Scientific Concepts and Principles question because you must recall the MO diagram for O2 and the link between bond order and length.',
  'hard'
);

-- Q36: Bond Length
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'The S-O bond lengths are SO2 143 pm, SO3 142 pm, and SO4^2- 149 pm. Which factor most directly explains why SO4^2- has the longest S-O bonds?',
  '[{"label": "A", "text": "SO4^2- has the lowest S-O bond order (1.5) because its four equivalent bonds share only two ''double-bond'' contributions across four positions"}, {"label": "B", "text": "SO4^2- has the greatest steric strain"}, {"label": "C", "text": "SO4^2- has the highest formal charge on sulfur"}, {"label": "D", "text": "SO4^2- has tetrahedral geometry, so its bonds are purely sigma"}]',
  'A',
  'The answer is A because in the best resonance picture of SO4^2-, sulfur has two S=O and two S-O bonds, averaging to a bond order of 1.5, compared to ~1.67 in SO3 (one single and two double averaged over three, no: for SO3 resonance gives 4/3 double character... actually SO3 bond order is also ~1.33-1.67 depending on model, but experimentally 142 pm is close to that of SO2 at bond order ~1.5-2). The lowest average bond order in the tetrahedral sulfate correlates with the longest bonds. Choice D ignores the resonance double-bond character present in all three. This is a Scientific Reasoning and Problem Solving question because you must apply resonance averaging to rationalize bond-length trends.',
  'hard'
);

-- Q37: Bond Energy
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'The H-X bond energies decrease in the order HF (570) > HCl (432) > HBr (366) > HI (298 kJ/mol). Which factor is the PRIMARY driver of this trend?',
  '[{"label": "A", "text": "Poorer orbital size matching between the large halogen np orbital and the compact H 1s orbital as X becomes larger"}, {"label": "B", "text": "Decreasing electronegativity of X lowers the ionic contribution to the H-X bond"}, {"label": "C", "text": "Increasing lone-pair-lone-pair repulsion as X becomes smaller"}, {"label": "D", "text": "Increasing pi back-bonding from X to H as X becomes larger"}]',
  'A',
  'The answer is A because bond strength depends on orbital overlap; the H 1s orbital is small, and as X becomes larger (F to I) its valence p orbital becomes diffuse and overlaps less effectively. Choice B captures a real secondary effect but it is not the primary driver (the ionic stabilization is comparable to the overlap loss). Choice C is the F2-versus-Cl2 argument, which does not apply to H-X bonds. This is a Scientific Reasoning and Problem Solving question because you must apply orbital-overlap reasoning to a size series.',
  'hard'
);

-- Q38: Coordinate Covalent Bonds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'The multidentate ligand EDTA^4- binds Ca2+ to form [Ca(EDTA)]^2- with a binding constant about 10^10 higher than that of six separate water molecules. Which thermodynamic factor most directly explains this ''chelate effect''?',
  '[{"label": "A", "text": "A large favorable entropy change because one ligand replaces six waters, increasing the number of free species"}, {"label": "B", "text": "A very large favorable enthalpy change because EDTA forms much stronger Ca-O bonds than water"}, {"label": "C", "text": "Covalent character in the Ca-EDTA bonds"}, {"label": "D", "text": "A decrease in the coordination number of calcium"}]',
  'A',
  'The answer is A because the chelate reaction [Ca(H2O)6]^2+ + EDTA^4- -> [Ca(EDTA)]^2- + 6 H2O releases six water molecules from a single ligand, giving a large positive delta S that dominates the free energy of binding; the per-bond enthalpies of Ca-O(EDTA) and Ca-OH2 are similar. Choice B is the step-2 trap: students intuit stronger bonds when the real explanation is entropic. This is a Knowledge of Scientific Concepts and Principles question because you must recall the entropic basis of the chelate effect.',
  'medium'
);

-- Q39: Bond Energy
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Covalent Bonds',
  'Despite F being smaller than Cl and thus expected to give better overlap, the F-F bond energy (159 kJ/mol) is lower than that of Cl-Cl (242 kJ/mol). Which factor best explains this anomaly?',
  '[{"label": "A", "text": "Strong lone-pair-lone-pair repulsion between the compact, electron-rich fluorine atoms at the short F-F internuclear distance"}, {"label": "B", "text": "Weaker orbital overlap because the 2p orbitals of F are too small to interact effectively"}, {"label": "C", "text": "Larger ionic contribution to Cl-Cl than to F-F"}, {"label": "D", "text": "The 2s-2p mixing in F2 weakens the sigma bond"}]',
  'A',
  'The answer is A because the three lone pairs on each F occupy a volume comparable to the short F-F bond length (~142 pm), so lone-pair repulsion destabilizes F2 more than Cl2 (Cl-Cl ~ 199 pm). Choice B is the pattern-matching trap: students expect smaller to mean better overlap. This same repulsion explains why F-F is even weaker than Br-Br. This is a Knowledge of Scientific Concepts and Principles question because you must recall why F2 is anomalously weak.',
  'hard'
);


-- ----------------------------------------------------------
-- Polarity
-- ----------------------------------------------------------
-- Q40: Bond Polarity
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'Using Pauling electronegativities (H 2.1, C 2.5, N 3.0, O 3.5, F 4.0, Si 1.8, Cl 3.0), which bond has the LARGEST dipole magnitude per unit bond length, and which has the smallest?',
  '[{"label": "A", "text": "Largest: Si-F; Smallest: C-H"}, {"label": "B", "text": "Largest: H-F; Smallest: C-C"}, {"label": "C", "text": "Largest: C-F; Smallest: Si-C"}, {"label": "D", "text": "Largest: N-O; Smallest: C-N"}]',
  'A',
  'The answer is A because Si-F has the largest electronegativity difference (|1.8-4.0| = 2.2) of any pair shown, and C-H has the smallest among the heteroatom bonds offered (|2.5-2.1| = 0.4). Dipole per length is approximately proportional to delta EN for bonds of similar length, so the largest delta EN wins. Choice B uses a valid C-C comparison but not against the strongest dipole in the set. This is a Knowledge of Scientific Concepts and Principles question because you must recall that bond polarity scales with |delta EN|.',
  'medium'
);

-- Q41: Dipole Moment
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'NF3 (0.23 D) and NH3 (1.47 D) are both trigonal pyramidal, yet NF3 is much less polar despite N-F being a more polar bond than N-H. Which statement best explains this?',
  '[{"label": "A", "text": "The N-F bond dipoles point from N to F, opposing the dipole from the N lone pair, while the N-H dipoles point from H to N, reinforcing it"}, {"label": "B", "text": "NF3 adopts a different geometry that cancels its dipoles"}, {"label": "C", "text": "N-F bonds are actually nonpolar due to back-bonding"}, {"label": "D", "text": "Fluorine''s small size prevents the lone pair from contributing"}]',
  'A',
  'The answer is A because in NH3 the bond dipoles (H(+) -> N(-)) add vectorially with the lone-pair dipole to give a large net moment, whereas in NF3 the bond dipoles (N(+) -> F(-)) point away from the lone pair and partially cancel the lone-pair contribution. Choice B is wrong: both are C3v. This is a Scientific Reasoning and Problem Solving question because you must combine bond dipoles with a lone-pair dipole vectorially.',
  'hard'
);

-- Q42: Molecular Polarity
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'Which of the following molecules has polar bonds but ZERO net dipole moment?',
  '[{"label": "A", "text": "H2O"}, {"label": "B", "text": "BF3"}, {"label": "C", "text": "NH3"}, {"label": "D", "text": "CH2Cl2"}]',
  'B',
  'The answer is B because BF3 has three polar B-F bonds but the trigonal planar geometry places them 120 degrees apart in a plane, so their dipoles cancel exactly. Water is bent with a net dipole, NH3 is pyramidal with a net dipole, and CH2Cl2 is tetrahedral but asymmetric, so its dipoles do not cancel. Choice A is the trap for students who forget that bond polarity alone is not enough; geometry must be symmetric. This is a Knowledge of Scientific Concepts and Principles question because you must recall that net polarity requires both polar bonds and an asymmetric arrangement.',
  'easy'
);

-- Q43: Electronegativity Differences
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'Rank the following bonds from LEAST to MOST polar, using electronegativities H 2.1, C 2.5, N 3.0, O 3.5, F 4.0.',
  '[{"label": "A", "text": "C-C < C-N < C-O < C-F"}, {"label": "B", "text": "C-C < C-O < C-N < C-F"}, {"label": "C", "text": "C-N < C-C < C-O < C-F"}, {"label": "D", "text": "C-C < C-N < C-F < C-O"}]',
  'A',
  'The answer is A because the electronegativity differences are 0 (C-C), 0.5 (C-N), 1.0 (C-O), and 1.5 (C-F), a strictly increasing sequence. Choice D is the step-2 trap for students who know C-F is polar but forget that the DIFFERENCE, not the electronegativity of the partner, sets the ordering. This is a Knowledge of Scientific Concepts and Principles question because you must recall that bond polarity scales linearly with |delta EN|.',
  'easy'
);

-- Q44: Molecular Polarity
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'CCl4 has a dipole moment of 0 D, but CHCl3 has a dipole moment of 1.04 D. Given that C-Cl is more polar than C-H, the dipole moment of CHCl3 suggests that the net moment points approximately WHERE, and WHY is it nonzero?',
  '[{"label": "A", "text": "From the H side toward the three Cl side; the three C-Cl dipoles no longer cancel because one tetrahedral position is occupied by the less polar C-H"}, {"label": "B", "text": "From the three Cl side toward the H side; CHCl3 is tetrahedral but asymmetric"}, {"label": "C", "text": "The net dipole is along the C-H bond because C-H is the most polar bond"}, {"label": "D", "text": "There is no preferred direction; the dipole arises from dynamic geometry fluctuations"}]',
  'A',
  'The answer is A because in CCl4 the four C-Cl dipoles cancel by tetrahedral symmetry, but replacing one Cl with H removes one C-Cl dipole; the remaining three no longer sum to zero, pointing net away from H and toward the Cl side (i.e. from H to the C-Cl3 centroid). Choice B reverses the direction (the dipole vector by convention points from delta(+) H to delta(-) Cl). Choice C inverts the polarities. This is a Scientific Reasoning and Problem Solving question because you must combine tetrahedral vector cancellation with symmetry breaking.',
  'hard'
);

-- Q45: Dipole Moment
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'cis-1,2-Dichloroethylene and trans-1,2-dichloroethylene have the same atoms and molecular formula but different dipole moments (cis ~1.9 D, trans ~0 D). What is the net dipole direction in the cis isomer, and why does the trans isomer give zero?',
  '[{"label": "A", "text": "In cis, the two C-Cl dipoles add because they point in similar directions relative to the C=C axis; in trans, they point in opposite directions and cancel by inversion symmetry"}, {"label": "B", "text": "In cis, the C-H dipoles dominate; in trans, the C-Cl dipoles dominate"}, {"label": "C", "text": "The trans isomer has no polar bonds"}, {"label": "D", "text": "The cis isomer has a higher dipole because of steric repulsion between the two Cl atoms"}]',
  'A',
  'The answer is A because in cis, the two Cl atoms are on the same side of the C=C double bond and their bond dipoles combine constructively, while in trans the Cl atoms sit across an inversion center and their dipoles cancel exactly. Choice D is the step-2 slip: students correctly identify the cis as more polar but attribute it to steric rather than vector addition. This is a Knowledge of Scientific Concepts and Principles question because you must recall the inversion symmetry of trans-disubstituted alkenes.',
  'hard'
);

-- Q46: Molecular Polarity
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'Two 20-residue peptide fragments have identical sequences except that one has alanine at position 10 and the other has serine at position 10. Predict the relative water solubility and partition coefficient (log P) of the two peptides.',
  '[{"label": "A", "text": "The serine fragment is more water-soluble and has a lower log P, because the -CH2OH side chain contributes polar/H-bonding character"}, {"label": "B", "text": "The alanine fragment is more water-soluble because -CH3 is smaller than -CH2OH"}, {"label": "C", "text": "Both have the same solubility because the backbone dominates"}, {"label": "D", "text": "The alanine fragment has a lower log P because it is less polar"}]',
  'A',
  'The answer is A because the serine side chain -CH2OH contains a polar O-H capable of hydrogen bonding to water, increasing water affinity and lowering log P (the octanol/water partition ratio). Choice B confuses size with polarity. Choice D is the step-2 slip: ''less polar'' does mean ''lower log P'' is wrong because log P measures octanol/water preference, so less polar = HIGHER log P. This is a Scientific Reasoning and Problem Solving question because you must apply polarity reasoning to partition coefficients.',
  'hard'
);

-- Q47: Bond Polarity
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'A diatomic molecule has a measured dipole moment of 1.82 D and a bond length of 1.27 angstroms. Using 1 D = 3.336e-30 C*m and e = 1.602e-19 C, what is the approximate percent ionic character of this bond?',
  '[{"label": "A", "text": "About 30%"}, {"label": "B", "text": "About 75%"}, {"label": "C", "text": "About 18%"}, {"label": "D", "text": "About 50%"}]',
  'A',
  'The answer is A because mu(100% ionic) = e*d = (1.602e-19)(1.27e-10)/(3.336e-30) ~ 6.10 D, and 1.82/6.10 ~ 0.30 or 30%. Choice B forgets the unit conversion, multiplying directly in inconsistent units. Choice C makes the d-unit slip the other direction. This is a Scientific Reasoning and Problem Solving question because you must apply mu/(e*d) with correct unit handling.',
  'hard'
);

-- Q48: Molecular Polarity
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'Three isomers of C3H8O have similar molecular weights (~60 g/mol): n-propane (C3H8, MW 44, bp -42 C), dimethyl ether (CH3OCH3, MW 46, bp -24 C), and ethanol (CH3CH2OH, MW 46, bp 78 C). Which interaction best explains why ethanol''s boiling point is dramatically higher than the ether''s, despite both having a C-O bond?',
  '[{"label": "A", "text": "Ethanol has an O-H bond and therefore forms intermolecular hydrogen bonds, while dimethyl ether has only dipole-dipole interactions"}, {"label": "B", "text": "Ethanol has a larger dipole moment than dimethyl ether"}, {"label": "C", "text": "The C-O-C angle in dimethyl ether prevents effective packing"}, {"label": "D", "text": "Ethanol has more C-H bonds than dimethyl ether"}]',
  'A',
  'The answer is A because hydrogen bonding between O-H groups of adjacent ethanol molecules adds an intermolecular interaction worth ~20 kJ/mol that ether cannot access; both have similar dipole moments, so dipole-dipole alone cannot explain the 100-degree difference. Choice B is the step-2 trap: the dipole moments are comparable, and hydrogen bonding dominates. This is a Knowledge of Scientific Concepts and Principles question because you must recall hydrogen bonding as a distinct class of intermolecular force.',
  'hard'
);

-- Q49: Dipole Moment
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'Ozone (O3) has a dipole moment of 0.53 D despite being composed entirely of oxygen atoms. Which structural feature BEST explains its nonzero dipole?',
  '[{"label": "A", "text": "O3 is bent (117 degrees), and the central O carries a formal +1 while the terminal O''s carry partial -1/2 each, giving a net dipole along the C2v symmetry axis"}, {"label": "B", "text": "The three O-O bonds are not equivalent in electronegativity because of isotope differences"}, {"label": "C", "text": "O3 is linear but with unequal bond lengths"}, {"label": "D", "text": "Ozone''s dipole arises entirely from lone-pair repulsions"}]',
  'A',
  'The answer is A because the bent (C2v) geometry places the central O in an inequivalent position, and its formal charge of +1 (versus -1/2 each on the terminal oxygens via resonance) creates charge asymmetry along the molecular symmetry axis. Choice B is chemically irrelevant. Choice C contradicts the known bent geometry. This is a Knowledge of Scientific Concepts and Principles question because you must recall that formal-charge asymmetry in a bent symmetric molecule still produces a net dipole.',
  'medium'
);

-- Q50: Electronegativity Differences
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'XeF2 contains polar Xe-F bonds yet has a dipole moment of zero. What is its molecular geometry, and how does this geometry produce the observed zero moment?',
  '[{"label": "A", "text": "Linear (F-Xe-F); the two Xe-F bond dipoles point in exactly opposite directions and cancel"}, {"label": "B", "text": "Bent; the bond dipoles cancel due to inversion symmetry"}, {"label": "C", "text": "Tetrahedral; the three lone pairs push the fluorines into a symmetric arrangement"}, {"label": "D", "text": "Trigonal bipyramidal; the axial fluorines cancel"}]',
  'A',
  'The answer is A because Xe has five electron domains around it (two bonds + three lone pairs), so VSEPR predicts trigonal bipyramidal electron geometry with the three lone pairs in the equatorial plane (minimizing lone-pair repulsions), leaving the fluorines at the two axial positions. The resulting F-Xe-F unit is LINEAR and the two bond dipoles cancel exactly. Choice D identifies the electron geometry but not the molecular geometry. This is a Scientific Reasoning and Problem Solving question because you must apply VSEPR lone-pair placement to predict molecular shape and polarity.',
  'medium'
);

-- Q51: Molecular Polarity
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'Among the following trigonal bipyramidal molecules, which is most likely to possess a nonzero net dipole moment?',
  '[{"label": "A", "text": "PF5"}, {"label": "B", "text": "PCl3F2 with Cl atoms in the axial positions"}, {"label": "C", "text": "PCl3F2 with Cl atoms in the equatorial positions"}, {"label": "D", "text": "AsF5"}]',
  'B',
  'The answer is B because the Cl-axial isomer has C2v symmetry: the two axial P-Cl dipoles lie along +z and -z and cancel, but the equatorial plane contains 1 Cl plus 2 F at 120 degree intervals, and because mu(P-F) > mu(P-Cl), the equatorial vector sum does not go to zero and points along the P-Cl(eq) axis. Choice C looks plausible because the Cl-equatorial isomer is in fact the thermodynamically favored form by Bent''s rule (more electronegative F prefers axial positions with higher p character), but that isomer has C3v symmetry in which the two axial P-F dipoles cancel AND the three equatorial P-Cl dipoles at 120 degrees sum to zero, giving no net dipole. Choices A (PF5, D3h) and D (AsF5, D3h) both have all-equivalent substituents and zero dipole by symmetry. This is a Scientific Reasoning and Problem Solving question because you must combine VSEPR geometry with vector addition of bond dipoles and recognize that it is the symmetry of the substitution pattern, not the presence of polar bonds, that determines whether the molecular dipole is zero.',
  'hard'
);

-- Q52: Bond Polarity
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'Using Pauling electronegativities (H = 2.20, C = 2.55, N = 3.04, Cl = 3.16, F = 3.98), which of the following bonds has the smallest bond dipole moment despite having a nonzero electronegativity difference?',
  '[{"label": "A", "text": "H–F"}, {"label": "B", "text": "C–H"}, {"label": "C", "text": "N–Cl"}, {"label": "D", "text": "C–Cl"}]',
  'C',
  'The answer is C because the electronegativity difference for N–Cl is only 0.12, smaller than C–H (0.35), C–Cl (0.61), and H–F (1.78). A common trap is choosing C–H because students memorize it as ''essentially nonpolar,'' but the numerical difference favors N–Cl. Note that bond length also influences dipole magnitude, but at this small an electronegativity difference the polarity is the dominant factor. This is a Knowledge of Scientific Concepts and Principles question because you must recall how electronegativity differences scale to produce bond dipole moments.',
  'medium'
);

-- Q53: Dipole Moment
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Polarity',
  'cis-1,2-dichloroethylene has a measured dipole moment of about 1.9 D, while trans-1,2-dichloroethylene has a dipole moment of essentially zero. Which statement best explains the measured moment of the cis isomer?',
  '[{"label": "A", "text": "Only the cis isomer has polar C–Cl bonds; the trans isomer''s bonds are nonpolar."}, {"label": "B", "text": "The C=C π bond contributes a dipole only when the Cl atoms are on the same side."}, {"label": "C", "text": "Both isomers have polar C–Cl bonds, but in the trans isomer the C–Cl bond dipoles point in opposite directions along a shared axis and cancel."}, {"label": "D", "text": "The cis isomer has sp3-hybridized carbons while the trans isomer has sp2-hybridized carbons, altering bond polarity."}]',
  'C',
  'The answer is C because both isomers contain identical polar C–Cl bonds; only the vector sum differs. In the planar trans isomer the two C–Cl dipoles are antiparallel and cancel exactly, yielding μ ≈ 0. In the cis isomer the two C–Cl dipoles subtend a nonzero angle, so their sum is appreciable (~1.9 D). Distractor A misattributes the difference to bond polarity rather than molecular symmetry; D is wrong because both isomers are sp2 at the alkene carbons. This is a Scientific Reasoning and Problem Solving question because you must apply vector addition of bond dipoles to distinguish cis/trans geometric isomers.',
  'hard'
);


-- ----------------------------------------------------------
-- Lewis Structures
-- ----------------------------------------------------------
-- Q54: Drawing Lewis Structures
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'In the best Lewis structure for the thiocyanate ion, SCN−, which has a central carbon, how many lone pairs of electrons reside on the sulfur atom?',
  '[{"label": "A", "text": "0"}, {"label": "B", "text": "1"}, {"label": "C", "text": "2"}, {"label": "D", "text": "3"}]',
  'D',
  'The answer is D because the best (lowest formal-charge-magnitude) Lewis structure of SCN− has a single S–C bond, a C≡N triple bond, and three lone pairs on sulfur, giving formal charges of −1 on S, 0 on C, and 0 on N. This minimizes formal charge and places the negative charge on the more electronegative of the terminal atoms for this pair (S is less electronegative than N, so the real preferred structure places the charge on S only when resonance considerations of softness/size come into play, but with SCN− this is the dominant resonance form). A common mistake is drawing S=C=N− (which gives S two lone pairs) without recognizing it is a higher-energy resonance form. This is a Knowledge of Scientific Concepts and Principles question because you must recall octet and formal-charge rules to identify the dominant Lewis structure.',
  'medium'
);

-- Q55: Formal Charge
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'The azide ion, N3−, has three resonance structures. In the symmetric resonance structure with two N=N double bonds, what is the formal charge on the central nitrogen?',
  '[{"label": "A", "text": "−2"}, {"label": "B", "text": "−1"}, {"label": "C", "text": "0"}, {"label": "D", "text": "+1"}]',
  'D',
  'The answer is D because the central N in N=N=N− has 0 lone-pair electrons and 4 bonding pairs (8 bonding electrons), so FC = 5 − 0 − 4 = +1. Each terminal nitrogen has 2 lone pairs and one double bond, giving FC = 5 − 4 − 2 = −1, so the overall charge is −1 + 1 − 1 = −1, matching the ion. Students who forget that formal charge counts half the bonding electrons often give −1. This is a Scientific Reasoning and Problem Solving question because you must apply the formal charge formula to a specific resonance contributor.',
  'medium'
);

-- Q56: Resonance Structures
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'The carbonate ion, CO3^2−, is commonly described with three equivalent resonance structures. What is the predicted bond order of each C–O bond in CO3^2−?',
  '[{"label": "A", "text": "1"}, {"label": "B", "text": "4/3"}, {"label": "C", "text": "3/2"}, {"label": "D", "text": "2"}]',
  'B',
  'The answer is B because the three equivalent resonance structures each show one C=O and two C–O single bonds, so the average bond order is (2 + 1 + 1)/3 = 4/3 ≈ 1.33. Students who choose 3/2 are confusing CO3^2− with the nitrate/carboxylate-style two-resonance averaging; here there are three resonance forms, not two. Bond-length data for carbonate (~1.28 Å) is consistent with a bond order between single and double, closer to 1 than to 2. This is a Scientific Reasoning and Problem Solving question because you must apply resonance-averaging to compute fractional bond order.',
  'medium'
);

-- Q57: Resonance Stabilization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'Which of the following anions is expected to be the most stabilized by resonance delocalization of its negative charge?',
  '[{"label": "A", "text": "Methoxide (CH3O−)"}, {"label": "B", "text": "Acetate (CH3CO2−)"}, {"label": "C", "text": "Phenoxide (C6H5O−)"}, {"label": "D", "text": "Carbonate (CO3^2−)"}]',
  'D',
  'The answer is D because carbonate has three equivalent resonance structures that delocalize the negative charge over three oxygen atoms, giving the greatest resonance stabilization per charge. Acetate has only two equivalent resonance structures (2 oxygens), phenoxide has four resonance contributors but only one places the charge on the more electronegative oxygen while the others place it on carbon (less favorable), and methoxide has no resonance delocalization at all. A student who ranks by ''number of resonance structures'' alone might pick phenoxide; the key is which atoms bear the charge. This is a Scientific Reasoning and Problem Solving question because you must apply resonance theory while weighing which resonance contributors are most stabilizing.',
  'medium'
);

-- Q58: Formal Charge
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'For the sulfate ion SO4^2−, consider two Lewis structures: Structure I has four S–O single bonds with S carrying a +2 formal charge, and Structure II has two S=O double bonds and two S–O single bonds with S carrying a 0 formal charge. Which statement best describes why Structure II is considered a more important contributor on first-row-style formal-charge analysis, even though modern calculations suggest S–O bonds in sulfate are largely single?',
  '[{"label": "A", "text": "Structure I violates the octet rule for oxygen."}, {"label": "B", "text": "Structure II minimizes formal charges on all atoms, which is the criterion used in the MCAT-level formal-charge treatment."}, {"label": "C", "text": "Structure I places negative charges on atoms that are too electronegative."}, {"label": "D", "text": "Structure II has more lone pairs on oxygen, lowering the total electron count."}]',
  'B',
  'The answer is B because the formal-charge rule for selecting ''best'' Lewis structures prefers the one whose atoms carry the smallest-magnitude formal charges; Structure II gives 0 on S and −1 on only two oxygens, while Structure I gives +2 on S and −1 on all four oxygens. Students should know that ab initio and NBO calculations indicate the ''expanded-octet'' structure overstates S=O double-bond character, but MCAT-level formal-charge reasoning still selects Structure II as ''best.'' This is a Knowledge of Scientific Concepts and Principles question because you must recall the formal-charge criterion used to rank Lewis structures.',
  'medium'
);

-- Q59: Drawing Lewis Structures
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'Nitric oxide, NO, is an odd-electron (radical) molecule. In its best Lewis structure, which atom carries the unpaired electron and what is the bond order of the N–O bond?',
  '[{"label": "A", "text": "Nitrogen; bond order 2"}, {"label": "B", "text": "Oxygen; bond order 2"}, {"label": "C", "text": "Nitrogen; bond order 2.5"}, {"label": "D", "text": "Oxygen; bond order 3"}]',
  'A',
  'The answer is A because the best Lewis structure of NO places the unpaired electron on the less electronegative nitrogen (giving N the ''less stable'' location is consistent with formal-charge minimization here: placing the radical on N yields formal charges of 0/0 with an N=O double bond). Students often pick oxygen because ''oxygen is more electronegative,'' but this is the reverse of the formal-charge rule. MO theory gives a bond order of 2.5 (one electron in a π* orbital), but at the Lewis-structure level the bond is drawn as a double bond, so bond order 2 is the Lewis-level answer. This is a Knowledge of Scientific Concepts and Principles question because you must recall the special treatment of odd-electron species in Lewis theory.',
  'hard'
);

-- Q60: Resonance Structures
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'Which of the following species does NOT have equivalent resonance structures in which every resonance contributor has the same energy?',
  '[{"label": "A", "text": "NO3−"}, {"label": "B", "text": "CO3^2−"}, {"label": "C", "text": "HCO2− (formate)"}, {"label": "D", "text": "OCN− (cyanate, central C)"}]',
  'D',
  'The answer is D because OCN− has resonance contributors that place different formal charges on the two unequal terminal atoms (O and N), so the contributors are not equivalent in energy; the dominant resonance structure has the negative charge on the more electronegative oxygen. NO3−, CO3^2−, and formate each have two or three equivalent resonance forms because the terminal atoms involved in resonance are identical. A student who counts ''number of resonance structures'' without checking whether the terminal atoms are equivalent will miss this. This is a Scientific Reasoning and Problem Solving question because you must apply the criterion of equivalence to distinguish symmetric from asymmetric resonance delocalization.',
  'medium'
);

-- Q61: Resonance Stabilization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'An organic chemist compares the pKa of phenol (pKa ≈ 10) to that of cyclohexanol (pKa ≈ 16). The ~6 pKa-unit difference is most directly attributed to which effect?',
  '[{"label": "A", "text": "Greater inductive electron withdrawal by the aromatic ring"}, {"label": "B", "text": "Resonance delocalization of the conjugate-base negative charge into the aromatic π system"}, {"label": "C", "text": "Hybridization change of oxygen from sp3 in cyclohexanol to sp2 in phenol"}, {"label": "D", "text": "Hydrogen bonding between phenol and the solvent"}]',
  'B',
  'The answer is B because the phenoxide ion stabilizes its negative charge by resonance delocalization onto the ortho and para carbons of the ring, spreading the charge over four atoms; cyclohexanol''s alkoxide has no such delocalization. Induction contributes (distractor A) but accounts for <1 pKa unit; resonance dominates. The oxygen in phenol is already sp2-leaning due to conjugation, but hybridization change is a consequence, not the primary cause. This is a Scientific Reasoning and Problem Solving question because you must apply resonance stabilization to rationalize a measured acidity difference.',
  'medium'
);

-- Q62: Formal Charge
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'In the best Lewis structure of ozone (O3), the central oxygen carries what formal charge, and the two terminal oxygens carry which formal charges?',
  '[{"label": "A", "text": "Central +1; one terminal 0, one terminal −1"}, {"label": "B", "text": "Central 0; both terminal 0"}, {"label": "C", "text": "Central −1; both terminal 0"}, {"label": "D", "text": "Central +1; both terminal −1/2 (averaged)"}]',
  'A',
  'The answer is A because in a single ozone resonance structure, the central O has one lone pair (2 electrons), one single bond, and one double bond (6 bonding electrons), giving FC = 6 − 2 − 3 = +1. One terminal O has a single bond and three lone pairs (FC = 6 − 6 − 1 = −1), and the other terminal O has a double bond and two lone pairs (FC = 6 − 4 − 2 = 0). The second resonance form inverts this. Distractor D confuses formal charge with bond-order averaging. This is a Scientific Reasoning and Problem Solving question because you must apply the formal-charge formula to each atom in a nontrivial polyatomic.',
  'medium'
);

-- Q63: Drawing Lewis Structures
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'XeF4 is a well-known hypervalent molecule. Based on its best Lewis structure, how many total electron pairs (bonding plus lone) surround the central Xe atom?',
  '[{"label": "A", "text": "4"}, {"label": "B", "text": "5"}, {"label": "C", "text": "6"}, {"label": "D", "text": "7"}]',
  'C',
  'The answer is C because Xe in XeF4 has four Xe–F single bonds (4 bonding pairs) plus two lone pairs on Xe, giving 6 electron pairs total, which corresponds to an octahedral electronic geometry and (after lone-pair placement) a square-planar molecular geometry. Students who stop at ''4 bonds'' miss the two lone pairs on xenon required to satisfy the 8-electron count from 4 F atoms plus Xe''s 8 valence electrons (total 8 + 4 = 12 electrons around Xe = 6 pairs). This is a Knowledge of Scientific Concepts and Principles question because you must recall the expanded-octet treatment of noble-gas halides.',
  'medium'
);

-- Q64: Resonance Stabilization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'Which cation is most stabilized by resonance delocalization of its positive charge?',
  '[{"label": "A", "text": "tert-butyl cation, (CH3)3C+"}, {"label": "B", "text": "Allyl cation, CH2=CH–CH2+"}, {"label": "C", "text": "Benzyl cation, C6H5–CH2+"}, {"label": "D", "text": "Methyl cation, CH3+"}]',
  'C',
  'The answer is C because the benzyl cation delocalizes its positive charge over four carbon atoms (ortho, para, and benzylic) through resonance with the aromatic ring, while the allyl cation delocalizes over only two carbons. The tert-butyl cation is stabilized by hyperconjugation and induction, not true resonance, and the methyl cation has neither. Students who treat hyperconjugation as ''resonance'' may incorrectly choose tert-butyl; the question specifically asks about resonance delocalization. This is a Scientific Reasoning and Problem Solving question because you must apply resonance theory to rank cation stabilities.',
  'easy'
);

-- Q65: Formal Charge
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'In HCN drawn as H–C≡N, what are the formal charges on C and N, respectively?',
  '[{"label": "A", "text": "C: 0; N: 0"}, {"label": "B", "text": "C: −1; N: +1"}, {"label": "C", "text": "C: +1; N: −1"}, {"label": "D", "text": "C: 0; N: −1"}]',
  'A',
  'The answer is A because carbon has 0 lone pairs and 4 bonding pairs (one to H, three to N), giving FC = 4 − 0 − 4 = 0, while nitrogen has one lone pair and three bonding pairs (triple bond), giving FC = 5 − 2 − 3 = 0. The sum is 0, matching neutral HCN. Students who mistakenly assign the negative formal charge to the more electronegative N forget that N already has exactly the electrons it needs. This is a Scientific Reasoning and Problem Solving question because you must apply the formal-charge formula systematically.',
  'medium'
);

-- Q66: Resonance Structures
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'Consider the four resonance contributors of the enolate of acetaldehyde: CH2=CH–O− ↔ −CH2–CH=O. Which contributor is the most significant contributor to the real structure?',
  '[{"label": "A", "text": "CH2=CH–O− (negative charge on oxygen)"}, {"label": "B", "text": "−CH2–CH=O (negative charge on carbon)"}, {"label": "C", "text": "Both contribute equally"}, {"label": "D", "text": "Neither; the real structure is a third form with charge on hydrogen"}]',
  'A',
  'The answer is A because the contributor with the negative charge on the more electronegative oxygen is lower in energy and therefore contributes more to the resonance hybrid. Although both resonance forms exist, O-centered negative charge is more stable than C-centered negative charge; this is why enolates are O-protonated/alkylated under thermodynamic control. Students who assume ''equal weighting'' because both structures are drawn with equal emphasis miss the electronegativity argument. This is a Scientific Reasoning and Problem Solving question because you must apply the rules of resonance-contributor ranking to a specific organic species.',
  'easy'
);

-- Q67: Drawing Lewis Structures
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'Sulfur hexafluoride (SF6) and iodine heptafluoride (IF7) are both stable hypervalent molecules. In the best Lewis structures of SF6 and IF7, the central atoms carry how many total electron pairs, respectively?',
  '[{"label": "A", "text": "5 and 6"}, {"label": "B", "text": "6 and 7"}, {"label": "C", "text": "6 and 8"}, {"label": "D", "text": "7 and 8"}]',
  'B',
  'The answer is B because SF6 has 6 bonding pairs and 0 lone pairs on S (12 electrons around S), while IF7 has 7 bonding pairs and 0 lone pairs on I (14 electrons around I). Students who forget that the central atoms have no lone pairs in these fully-fluorinated hypervalent cases may add extra lone pairs and choose 7 or 8. This is a Knowledge of Scientific Concepts and Principles question because you must recall that SF6 is octahedral and IF7 is pentagonal bipyramidal from their Lewis structures.',
  'hard'
);

-- Q68: Resonance Stabilization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Lewis Structures',
  'The experimentally measured N–O bond length in nitrate (NO3−) is about 1.25 Å, intermediate between a typical N–O single bond (~1.40 Å) and N=O double bond (~1.20 Å). Which statement best accounts for this observation?',
  '[{"label": "A", "text": "The three N–O bonds are each exactly single bonds, and the measurement is anomalous."}, {"label": "B", "text": "Resonance delocalization gives each N–O bond an average bond order of 4/3."}, {"label": "C", "text": "One bond is double and two are single, and the 1.25 Å is the average over crystal packing."}, {"label": "D", "text": "Nitrate is better described with expanded-octet nitrogen carrying three double bonds."}]',
  'B',
  'The answer is B because resonance between the three equivalent NO3− Lewis structures delocalizes one double bond over three equivalent bonds, giving average bond order (2+1+1)/3 = 4/3 and predicting a length between single and double bond, consistent with 1.25 Å. Distractor D is wrong because nitrogen (second-row) cannot expand its octet, and distractor C describes a frozen localized picture inconsistent with the observed equivalence of all three bonds. This is a Data-based and Statistical Reasoning question because you must interpret bond-length data and map it onto a resonance-theoretic prediction.',
  'hard'
);


-- ----------------------------------------------------------
-- VSEPR Theory
-- ----------------------------------------------------------
-- Q69: Electronic Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'The electronic (steric) geometry of a central atom refers to the arrangement of all electron domains (bonds and lone pairs). What is the electronic geometry of the central atom in ClF3?',
  '[{"label": "A", "text": "Trigonal planar"}, {"label": "B", "text": "Trigonal pyramidal"}, {"label": "C", "text": "Tetrahedral"}, {"label": "D", "text": "Trigonal bipyramidal"}]',
  'D',
  'The answer is D because chlorine in ClF3 has 3 bonding pairs plus 2 lone pairs = 5 electron domains, which corresponds to a trigonal bipyramidal electronic geometry. The lone pairs occupy two of the equatorial positions (which minimize lone-pair–lone-pair repulsion), leading to a T-shaped molecular geometry. Students who confuse electronic with molecular geometry may choose ''T-shaped,'' but the question specifies electronic geometry. This is a Knowledge of Scientific Concepts and Principles question because you must recall the VSEPR electron-domain counting rules.',
  'medium'
);

-- Q70: Effect of Lone Pairs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'In the series NH3, H2O, and HF (each with a single central atom after H), the measured H–X–H (or H–X) bond angles are approximately 107°, 104.5°, and — (only one H, undefined). Focusing on NH3 and H2O, why is the H–O–H angle smaller than the H–N–H angle?',
  '[{"label": "A", "text": "Oxygen is more electronegative than nitrogen, so it pulls the bonding pairs closer together."}, {"label": "B", "text": "H2O has two lone pairs on oxygen vs. one lone pair on nitrogen in NH3, and lone-pair/bond-pair repulsion compresses the bond angle more strongly with more lone pairs."}, {"label": "C", "text": "The oxygen atom is smaller than nitrogen, forcing the hydrogens closer."}, {"label": "D", "text": "Water has sp3d hybridization while ammonia has sp3 hybridization."}]',
  'B',
  'The answer is B because each additional lone pair on the central atom increases lone-pair repulsion on the remaining bonding pairs, progressively compressing the bond angle below the ideal tetrahedral 109.5°. NH3 has one lone pair (angle 107°) and H2O has two (angle 104.5°). Distractor A conflates electronegativity with geometry (electronegativity of the central atom actually tends to open the bond angle when comparing HOH vs HSH). Distractor D is wrong; both are sp3. This is a Scientific Reasoning and Problem Solving question because you must apply VSEPR''s lone-pair repulsion rules to explain a bond-angle trend.',
  'hard'
);

-- Q71: Molecular Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'What is the molecular geometry around the sulfur atom in SF4?',
  '[{"label": "A", "text": "Tetrahedral"}, {"label": "B", "text": "Square planar"}, {"label": "C", "text": "See-saw (disphenoidal)"}, {"label": "D", "text": "Trigonal pyramidal"}]',
  'C',
  'The answer is C because SF4 has 4 bonding pairs and 1 lone pair around S (5 electron domains, trigonal bipyramidal electronic geometry). The lone pair preferentially occupies an equatorial site (lower repulsion cost than axial), leaving 4 F atoms in a see-saw arrangement: two axial and two equatorial. Students who pick tetrahedral miss the lone pair; those who pick square planar are confusing with XeF4. This is a Knowledge of Scientific Concepts and Principles question because you must recall the VSEPR placement of lone pairs in five-coordinate geometry.',
  'medium'
);

-- Q72: Bond Angles
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'In PCl3F2 (trigonal bipyramidal), assume the three Cl atoms occupy the equatorial positions and the two F atoms occupy the axial positions. What is the approximate Cl–P–Cl equatorial bond angle?',
  '[{"label": "A", "text": "90°"}, {"label": "B", "text": "109.5°"}, {"label": "C", "text": "120°"}, {"label": "D", "text": "180°"}]',
  'C',
  'The answer is C because in an ideal trigonal bipyramidal geometry the three equatorial positions lie in a plane with 120° between them, while the axial positions are 90° from each equatorial and 180° from each other. The question specifies equatorial–equatorial, so 120° is correct. Students who answer 90° are giving the axial–equatorial angle. This is a Knowledge of Scientific Concepts and Principles question because you must recall the bond-angle geometry of a trigonal bipyramid.',
  'medium'
);

-- Q73: Molecular Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'Which of the following molecules or ions has a square planar molecular geometry?',
  '[{"label": "A", "text": "SF4"}, {"label": "B", "text": "XeF4"}, {"label": "C", "text": "PF5"}, {"label": "D", "text": "CF4"}]',
  'B',
  'The answer is B because XeF4 has 4 bonding pairs and 2 lone pairs (6 electron domains total, octahedral electronic geometry); the two lone pairs occupy opposite (trans) positions to minimize their mutual repulsion, leaving the four F atoms in a square-planar arrangement. SF4 is see-saw (5 domains, 1 lone pair), PF5 is trigonal bipyramidal (5 domains, 0 lone pairs), and CF4 is tetrahedral. This is a Knowledge of Scientific Concepts and Principles question because you must recall VSEPR geometries arising from six-coordinate centers with two lone pairs.',
  'easy'
);

-- Q74: Electronic Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'The molecule I3− (triiodide) is linear. What is the electronic (steric) geometry of the central iodine atom in I3−?',
  '[{"label": "A", "text": "Linear"}, {"label": "B", "text": "Trigonal planar"}, {"label": "C", "text": "Tetrahedral"}, {"label": "D", "text": "Trigonal bipyramidal"}]',
  'D',
  'The answer is D because the central I has 2 bonding pairs plus 3 lone pairs = 5 electron domains, which is a trigonal bipyramidal electronic geometry. The 3 lone pairs occupy all three equatorial positions (lowest repulsion), leaving the two I atoms in the axial positions — which gives the linear molecular geometry. Students who choose ''linear'' are conflating molecular and electronic geometry. This is a Scientific Reasoning and Problem Solving question because you must apply VSEPR electron-domain counting to a hypervalent anion.',
  'medium'
);

-- Q75: Molecular Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'Which molecule has the same molecular geometry (shape) as water?',
  '[{"label": "A", "text": "CO2"}, {"label": "B", "text": "NO2 (neutral radical)"}, {"label": "C", "text": "SO2"}, {"label": "D", "text": "BeCl2"}]',
  'C',
  'The answer is C because SO2 has 2 bonding domains and 1 lone pair on S, giving a bent molecular geometry with a bond angle near 119° — the same overall shape as water. H2O is bent because of 2 bonds + 2 lone pairs. NO2 (neutral) is also bent due to one unpaired electron acting as a half-domain, but the question asks for the closest match in shape and electron-domain structure; SO2 with a true lone pair is the canonical bent analogue. CO2 and BeCl2 are linear. Some graders accept NO2, but SO2 is the better AAMC-style answer because its lone pair is a full pair. This is a Scientific Reasoning and Problem Solving question because you must apply VSEPR to identify isostructural molecules.',
  'easy'
);

-- Q76: Bond Angles
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'The H–C–H bond angle in methane (CH4) is 109.5°. The H–N–H bond angle in ammonia is approximately 107°, and in the ammonium ion NH4+ the H–N–H bond angle is 109.5°. Which best explains why the angle in NH4+ returns to 109.5°?',
  '[{"label": "A", "text": "NH4+ has no lone pairs on nitrogen, so lone-pair/bond-pair compression is absent."}, {"label": "B", "text": "The positive charge increases the electronegativity of nitrogen and widens the bond angle."}, {"label": "C", "text": "NH4+ is sp2-hybridized while NH3 is sp3."}, {"label": "D", "text": "The fourth N–H bond in NH4+ forms with an extra proton that has a different bond length."}]',
  'A',
  'The answer is A because NH4+ has 4 bond pairs and 0 lone pairs around N, restoring true tetrahedral symmetry and the ideal 109.5° angle. In NH3, a single lone pair compresses the remaining H–N–H angles to about 107°. Both NH3 and NH4+ are sp3 hybridized (distractor C is wrong). This is a Scientific Reasoning and Problem Solving question because you must apply VSEPR lone-pair repulsion logic to account for a measured bond-angle change on protonation.',
  'hard'
);

-- Q77: Effect of Lone Pairs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'Consider the series CH4, NH3, H2O, H3O+, NH4+. Which has the LARGEST H–X–H bond angle?',
  '[{"label": "A", "text": "H2O"}, {"label": "B", "text": "NH3"}, {"label": "C", "text": "CH4 and NH4+ (tied at 109.5°)"}, {"label": "D", "text": "H3O+"}]',
  'C',
  'The answer is C because both CH4 and NH4+ have 4 bonding pairs and 0 lone pairs on the central atom, giving an ideal tetrahedral angle of 109.5°. NH3 (1 lone pair) is about 107°, H2O (2 lone pairs) is about 104.5°, and H3O+ (1 lone pair on O) is about 107–109°, slightly smaller than NH4+. Students who pick only CH4 forget that NH4+ is structurally identical in electron-domain terms. This is a Scientific Reasoning and Problem Solving question because you must apply the VSEPR lone-pair compression rule across an isoelectronic-like series.',
  'easy'
);

-- Q78: Molecular Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'Xenon tetrafluoride (XeF4) and methane (CH4) both have four atoms bonded to the central atom, but their shapes differ dramatically. Which explanation best accounts for this difference?',
  '[{"label": "A", "text": "Xe is too large to form tetrahedral bonds to F."}, {"label": "B", "text": "XeF4 has two lone pairs on Xe in addition to the four bonds, giving 6 electron domains total; the lone pairs take opposite octahedral positions, leaving the F atoms square planar."}, {"label": "C", "text": "Xe uses d orbitals that force a square-planar arrangement regardless of lone pairs."}, {"label": "D", "text": "F–F repulsion in XeF4 is much larger than H–H repulsion in CH4, forcing the square-planar shape."}]',
  'B',
  'The answer is B because the correct VSEPR analysis of XeF4 counts 4 bonds + 2 lone pairs = 6 electron domains (octahedral electronic geometry); the two lone pairs occupy trans positions to minimize their mutual repulsion, leaving the four F atoms in a square-planar arrangement. Distractor C is a common misconception — modern treatments show d-orbital participation in main-group hypervalency is minimal; the geometry comes from VSEPR, not d orbitals. This is a Scientific Reasoning and Problem Solving question because you must apply the full VSEPR electron-counting procedure to a hypervalent species.',
  'hard'
);

-- Q79: Electronic Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'What is the electronic geometry around the central atom in IF5?',
  '[{"label": "A", "text": "Trigonal bipyramidal"}, {"label": "B", "text": "Octahedral"}, {"label": "C", "text": "Square pyramidal"}, {"label": "D", "text": "Pentagonal bipyramidal"}]',
  'B',
  'The answer is B because the central iodine in IF5 has 5 bonding pairs and 1 lone pair = 6 electron domains, giving an octahedral electronic geometry. The lone pair occupies one vertex of the octahedron, producing a square-pyramidal molecular geometry. Distractor C is a common trap — it is the molecular geometry, not the electronic geometry. This is a Knowledge of Scientific Concepts and Principles question because you must recall the distinction between electronic and molecular geometry in VSEPR.',
  'easy'
);

-- Q80: Molecular Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'The thionyl chloride molecule (SOCl2) has S at the center, bonded to one O (via a double bond) and two Cl atoms, with one lone pair on S. What is its molecular geometry?',
  '[{"label": "A", "text": "Trigonal planar"}, {"label": "B", "text": "Trigonal pyramidal"}, {"label": "C", "text": "Tetrahedral"}, {"label": "D", "text": "See-saw"}]',
  'B',
  'The answer is B because S has 3 bonding electron domains (treating the S=O double bond as one domain) plus 1 lone pair = 4 electron domains total, giving tetrahedral electronic geometry and trigonal pyramidal molecular geometry (like NH3). Students who count the double bond as two domains may overcomplicate this; VSEPR counts all bonds to one atom as a single domain regardless of bond order. This is a Scientific Reasoning and Problem Solving question because you must apply VSEPR domain-counting rules to a multiply-bonded central atom.',
  'medium'
);

-- Q81: Bond Angles
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'Rank the following bond angles from LARGEST to SMALLEST: (i) F–B–F in BF3, (ii) H–C–H in CH4, (iii) H–N–H in NH3, (iv) H–O–H in H2O.',
  '[{"label": "A", "text": "(i) > (ii) > (iii) > (iv)"}, {"label": "B", "text": "(ii) > (i) > (iii) > (iv)"}, {"label": "C", "text": "(i) > (iii) > (ii) > (iv)"}, {"label": "D", "text": "(ii) > (iii) > (i) > (iv)"}]',
  'A',
  'The answer is A because BF3 is trigonal planar (120°), CH4 is tetrahedral (109.5°), NH3 has 1 lone pair so its H–N–H angle is ~107°, and H2O has 2 lone pairs so its H–O–H angle is ~104.5°. The ordering 120° > 109.5° > 107° > 104.5° matches choice A. Students who forget that BF3 has only 3 electron domains may rank it below CH4. This is a Scientific Reasoning and Problem Solving question because you must apply VSEPR angle rules across electron-domain counts with varying lone-pair numbers.',
  'easy'
);

-- Q82: Effect of Lone Pairs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'In a trigonal bipyramidal electron geometry, lone pairs preferentially occupy equatorial rather than axial positions. Which statement best explains this preference?',
  '[{"label": "A", "text": "Equatorial positions have no 90° neighbors, eliminating close lone-pair repulsions."}, {"label": "B", "text": "At equatorial positions, a lone pair has only two 90° neighbors, whereas at axial positions it would have three 90° neighbors; 90° repulsions are far more costly than 120° repulsions."}, {"label": "C", "text": "Lone pairs are smaller at equatorial positions due to partial d-orbital character."}, {"label": "D", "text": "Axial bonds are shorter, creating more steric strain for a lone pair."}]',
  'B',
  'The answer is B because in a trigonal bipyramidal arrangement an axial domain has three neighbors at 90° (the three equatorial) whereas an equatorial domain has only two neighbors at 90° (the two axial), with the other equatorials at 120°. Because repulsions fall off rapidly with angle, the 90°-neighbor count dominates, and lone pairs (which are the most repulsive domain) minimize these by choosing equatorial positions. Distractor A overstates — equatorial positions do have 90° axial neighbors. This is a Knowledge of Scientific Concepts and Principles question because you must recall the geometric justification for VSEPR preference rules.',
  'easy'
);

-- Q83: Molecular Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'BrF3 has which of the following molecular geometries?',
  '[{"label": "A", "text": "Trigonal planar"}, {"label": "B", "text": "Trigonal pyramidal"}, {"label": "C", "text": "T-shaped"}, {"label": "D", "text": "See-saw"}]',
  'C',
  'The answer is C because Br in BrF3 has 3 bonding pairs + 2 lone pairs = 5 electron domains, giving trigonal bipyramidal electronic geometry. Both lone pairs occupy equatorial positions (to minimize 90° repulsions), leaving the three F atoms in a T-shaped arrangement: two axial and one equatorial. Students who pick trigonal pyramidal or planar are missing the two lone pairs on bromine. This is a Scientific Reasoning and Problem Solving question because you must apply the VSEPR equatorial-preference rule to a 5-domain species with two lone pairs.',
  'easy'
);

-- Q84: Electronic Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'In the molecule XeOF4 (xenon oxytetrafluoride), with Xe as the central atom, what is the electronic geometry around Xe?',
  '[{"label": "A", "text": "Tetrahedral"}, {"label": "B", "text": "Trigonal bipyramidal"}, {"label": "C", "text": "Octahedral"}, {"label": "D", "text": "Pentagonal bipyramidal"}]',
  'C',
  'The answer is C because Xe in XeOF4 has 5 bonding domains (4 to F, 1 to O; the Xe=O is still one domain) plus 1 lone pair on Xe, giving 6 electron domains = octahedral electronic geometry. The lone pair occupies one vertex of the octahedron, producing a square-pyramidal molecular geometry. Students who treat the Xe=O double bond as two domains will over-count. This is a Scientific Reasoning and Problem Solving question because you must apply VSEPR electron-domain counting to a hypervalent, multiply-bonded central atom.',
  'medium'
);

-- Q85: Bond Angles
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'In SF4 (see-saw geometry), which is the best estimate of the F(axial)–S–F(equatorial) bond angle, assuming the lone pair occupies an equatorial site?',
  '[{"label": "A", "text": "Exactly 90°"}, {"label": "B", "text": "Slightly less than 90°"}, {"label": "C", "text": "Exactly 120°"}, {"label": "D", "text": "Slightly greater than 109.5°"}]',
  'B',
  'The answer is B because the lone pair in the equatorial position repels the axial bonding pairs, compressing the axial F–S–F angle below the ideal 180° and pushing the axial F atoms slightly toward the opposite equatorial F. This bends the axial-to-equatorial angle to slightly less than the ideal 90°. Experimentally the axial F–S–F angle in SF4 is about 173° (not 180°) and the F(ax)–S–F(eq) angle is about 87°. Students who assume ideal VSEPR angles miss the lone-pair-induced compression. This is a Scientific Reasoning and Problem Solving question because you must apply lone-pair repulsion corrections to predicted bond angles.',
  'medium'
);

-- Q86: Molecular Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'Which of the following molecules has a linear molecular geometry despite having a central atom with lone pairs?',
  '[{"label": "A", "text": "H2O"}, {"label": "B", "text": "SO2"}, {"label": "C", "text": "XeF2"}, {"label": "D", "text": "NH3"}]',
  'C',
  'The answer is C because XeF2 has 2 bonding pairs and 3 lone pairs on Xe = 5 electron domains (trigonal bipyramidal electronic geometry). All three lone pairs occupy the equatorial positions to minimize 90° repulsions, leaving the two F atoms in axial positions, 180° apart — a linear molecular geometry. H2O and SO2 are bent, and NH3 is trigonal pyramidal. Students often assume ''lone pairs always make a molecule bent,'' which fails for this hypervalent case. This is a Scientific Reasoning and Problem Solving question because you must apply the VSEPR equatorial-preference rule to recognize when lone pairs do NOT bend the molecule.',
  'medium'
);

-- Q87: Effect of Lone Pairs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'VSEPR Theory',
  'The bond angle in H2S (92°) is significantly smaller than the bond angle in H2O (104.5°), even though both have 2 bonding pairs and 2 lone pairs. Which statement best accounts for this difference?',
  '[{"label": "A", "text": "Sulfur uses nearly pure p orbitals for bonding (minimal s–p mixing), while oxygen uses sp3-like hybrids, so the H–S–H angle approaches the 90° p-orbital angle."}, {"label": "B", "text": "Sulfur is more electronegative than oxygen, pulling the bonding pairs closer."}, {"label": "C", "text": "H2S has more lone pairs on sulfur than H2O has on oxygen."}, {"label": "D", "text": "H2S has an expanded octet that forces smaller angles."}]',
  'A',
  'The answer is A because for heavier main-group elements the energy cost of s–p promotion is higher, so bonding becomes more p-like and bond angles drop toward the 90° angle between pure p orbitals. Oxygen, being smaller, mixes s and p more strongly, giving an angle closer to the ideal sp3 value of 109.5° (compressed to 104.5° by lone pairs). Distractor B is wrong; oxygen is more electronegative than sulfur. This is a Scientific Reasoning and Problem Solving question because you must apply hybridization/Bent''s-rule reasoning to a trend in bond angles down a group.',
  'hard'
);


-- ----------------------------------------------------------
-- Hybridization
-- ----------------------------------------------------------
-- Q88: sp2 Hybridization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'In benzene (C6H6), each carbon atom is sp2-hybridized. How many σ bonds and how many π bonds are present in the entire molecule?',
  '[{"label": "A", "text": "6 σ and 3 π"}, {"label": "B", "text": "9 σ and 3 π"}, {"label": "C", "text": "12 σ and 3 π"}, {"label": "D", "text": "12 σ and 6 π"}]',
  'C',
  'The answer is C because benzene has 6 C–C σ bonds (around the ring) plus 6 C–H σ bonds = 12 σ bonds total, and 3 π bonds delocalized over the ring (the conventional Kekulé count). Students who forget to count C–H σ bonds will answer 6 σ / 3 π. The π system is often drawn as a delocalized cloud, but the σ/π count is still 12/3. This is a Knowledge of Scientific Concepts and Principles question because you must recall that each sp2 carbon contributes 3 σ bonds and shares 1 π bond with a neighbor.',
  'medium'
);

-- Q89: sp Hybridization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'In propyne (CH3–C≡CH), how many sp-hybridized carbons are present, and what is the geometry around each sp-hybridized carbon?',
  '[{"label": "A", "text": "One sp carbon; linear"}, {"label": "B", "text": "Two sp carbons; linear"}, {"label": "C", "text": "Two sp carbons; trigonal planar"}, {"label": "D", "text": "Three sp carbons; linear"}]',
  'B',
  'The answer is B because both carbons of the C≡C triple bond are sp-hybridized and linear (180° at each sp carbon). The methyl carbon (CH3) is sp3. Each sp carbon forms 2 σ bonds (1 to its triple-bonded neighbor and 1 to the other substituent) plus contributes to 2 π bonds. Students may count only the terminal alkyne carbon and miss the internal one. This is a Scientific Reasoning and Problem Solving question because you must apply hybridization assignments to each carbon in a simple organic molecule.',
  'medium'
);

-- Q90: sp3 Hybridization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'Ammonia (NH3) is sp3-hybridized at nitrogen, yet the H–N–H bond angle is approximately 107° rather than the ideal 109.5°. Which statement best reconciles these observations?',
  '[{"label": "A", "text": "Hybridization is a model, not a law; the bond angle must match hybridization exactly."}, {"label": "B", "text": "The lone pair on nitrogen occupies an sp3 orbital and exerts greater repulsion than the bonding pairs, slightly compressing the H–N–H angle below 109.5°."}, {"label": "C", "text": "Nitrogen in NH3 is actually sp2-hybridized, not sp3."}, {"label": "D", "text": "The N–H bonds have partial double-bond character due to resonance."}]',
  'B',
  'The answer is B because the lone pair in an sp3 orbital is closer to nitrogen''s nucleus (more s-character concentration near the nucleus than bond pairs, roughly speaking) and repels the bonding pairs more strongly than they repel one another, compressing the H–N–H angles slightly. Some advanced treatments argue NH3''s lone pair has a bit more s character than the bonding orbitals (slight rehybridization), but at the MCAT level the sp3 assignment is retained with VSEPR repulsion explaining the compression. Distractor C is wrong because NH3 is sp3. This is a Scientific Reasoning and Problem Solving question because you must reconcile idealized hybridization with measured bond angles.',
  'medium'
);

-- Q91: Hybridization and Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'A central atom has an electronic geometry that is trigonal bipyramidal. Within the standard (s/p/d) hybridization model, which hybridization describes this atom?',
  '[{"label": "A", "text": "sp3"}, {"label": "B", "text": "sp3d"}, {"label": "C", "text": "sp3d2"}, {"label": "D", "text": "sp2 combined with an unhybridized d orbital"}]',
  'B',
  'The answer is B because a trigonal bipyramidal electronic geometry has 5 electron domains, which in the standard main-group hybridization model is built from one s, three p, and one d orbital -> sp3d. Choice A (sp3) gives only 4 hybrids -> tetrahedral. Choice C (sp3d2) gives 6 hybrids -> octahedral. Choice D is the trap for students who picture TBP as a trigonal plane with an added axial pair and try to build it from sp2 + one d orbital: that gives 4 hybrids, not 5, so it cannot describe a 5-coordinate center. This is a Knowledge of Scientific Concepts and Principles question because you must map electron-domain count onto the correct s/p/d hybridization set.',
  'medium'
);

-- Q92: sp3 Hybridization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'Which molecule contains at least one sp3-hybridized oxygen atom?',
  '[{"label": "A", "text": "CO2"}, {"label": "B", "text": "CH3–O–CH3 (dimethyl ether)"}, {"label": "C", "text": "Formaldehyde (HCHO)"}, {"label": "D", "text": "Carbon monoxide (CO)"}]',
  'B',
  'The answer is B because the ether oxygen in dimethyl ether has 2 bonds and 2 lone pairs = 4 electron domains, so it is sp3. The oxygens in CO2 are sp (two bonding domains), the oxygen in formaldehyde is sp2 (one double bond, two lone pairs = 3 domains), and CO has an sp oxygen. Students who forget to count lone pairs may misassign the ether oxygen. This is a Scientific Reasoning and Problem Solving question because you must apply electron-domain counting to oxygen in multiple environments.',
  'easy'
);

-- Q93: sp2 Hybridization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'In formaldehyde (H2C=O), the carbon is sp2-hybridized. Which statement about the bonding in formaldehyde is correct?',
  '[{"label": "A", "text": "Both the σ and π bonds of the C=O are formed from sp2 hybrid orbitals on carbon."}, {"label": "B", "text": "The σ bond uses an sp2 orbital on carbon, and the π bond uses the unhybridized 2p orbital on carbon."}, {"label": "C", "text": "The σ bond uses a pure 2p orbital on carbon, and the π bond uses an sp2 hybrid."}, {"label": "D", "text": "Both the σ and π bonds use sp-hybridized orbitals on carbon."}]',
  'B',
  'The answer is B because in an sp2-hybridized carbon, three of the four valence orbitals (s, px, py) mix to form three sp2 hybrids that form σ bonds, while the remaining unhybridized pz orbital forms the π bond by sideways overlap. Students who think ''all bonds use hybrid orbitals'' (choice A) miss that π bonds always use unhybridized p orbitals. This is a Knowledge of Scientific Concepts and Principles question because you must recall which orbitals participate in σ vs. π bonding at an sp2 carbon.',
  'medium'
);

-- Q94: Hybridization and Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'Which of the following molecules has a central atom with sp3d2 hybridization?',
  '[{"label": "A", "text": "PF5"}, {"label": "B", "text": "SF6"}, {"label": "C", "text": "BF3"}, {"label": "D", "text": "CH4"}]',
  'B',
  'The answer is B because sp3d2 corresponds to 6 electron domains (octahedral electronic geometry). SF6 has 6 bonding pairs around sulfur with no lone pairs, matching octahedral/sp3d2. PF5 is sp3d (trigonal bipyramidal, 5 domains), BF3 is sp2 (3 domains), and CH4 is sp3 (4 domains). This is a Knowledge of Scientific Concepts and Principles question because you must recall the hybridization–geometry mapping.',
  'easy'
);

-- Q95: sp Hybridization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'Carbon dioxide (O=C=O) has a central carbon that is sp-hybridized. How many π bonds does the molecule contain, and which orbitals form them?',
  '[{"label": "A", "text": "1 π bond, formed by an sp orbital on C overlapping with a 2p orbital on O."}, {"label": "B", "text": "2 π bonds, each formed by an unhybridized 2p orbital on C overlapping with a 2p orbital on O."}, {"label": "C", "text": "2 π bonds, formed by the two sp orbitals on C overlapping with 2p orbitals on the two oxygens."}, {"label": "D", "text": "0 π bonds; CO2 contains only σ bonds."}]',
  'B',
  'The answer is B because sp hybridization uses only one s and one p orbital, leaving two unhybridized p orbitals (py and pz) on the central carbon. Each of these p orbitals forms a π bond to one of the two oxygens, giving two π bonds total (one to each O). Each C=O is a double bond, so 2 double bonds × 1 π each = 2 π bonds. Students who treat each double bond as having 2 π bonds (confusing with triple bonds) may answer 4. This is a Knowledge of Scientific Concepts and Principles question because you must recall which orbitals participate in π bonding at an sp center.',
  'medium'
);

-- Q96: sp3 Hybridization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'In the sulfate ion SO4^2−, using the conventional formal-charge-minimized Lewis structure with two S=O and two S–O bonds, what is the hybridization of sulfur in the MCAT-level VSEPR treatment?',
  '[{"label": "A", "text": "sp"}, {"label": "B", "text": "sp2"}, {"label": "C", "text": "sp3"}, {"label": "D", "text": "sp3d"}]',
  'C',
  'The answer is C because sulfur in SO4^2− has 4 electron domains (4 bonds to O, 0 lone pairs) regardless of whether the bonds are drawn as single or double; VSEPR counts all bonds between two atoms as one domain. Four domains → sp3, tetrahedral geometry. Students who count each double bond as two domains may incorrectly choose sp3d (6 domains), but that is not how electron-domain counting works. This is a Knowledge of Scientific Concepts and Principles question because you must recall that multiple bonds count as a single electron domain for hybridization purposes.',
  'hard'
);

-- Q97: Hybridization and Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'Which pairing of hybridization and ideal bond angle is INCORRECT?',
  '[{"label": "A", "text": "sp — 180°"}, {"label": "B", "text": "sp2 — 120°"}, {"label": "C", "text": "sp3 — 109.5°"}, {"label": "D", "text": "sp3d2 — 120°"}]',
  'D',
  'The answer is D because sp3d2 corresponds to octahedral geometry with bond angles of 90° (between adjacent positions) and 180° (trans), not 120°. 120° is the equatorial angle in trigonal bipyramidal (sp3d) geometry. Students who confuse sp3d with sp3d2 may miss this. This is a Knowledge of Scientific Concepts and Principles question because you must recall the ideal angle for each hybridization scheme.',
  'medium'
);

-- Q98: sp2 Hybridization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'In an amide functional group (R–C(=O)–NR2), the nitrogen is experimentally observed to be nearly planar rather than pyramidal. What is the hybridization of the amide nitrogen, and what is the structural reason for this geometry?',
  '[{"label": "A", "text": "sp3; the nitrogen remains pyramidal but rapid inversion averages it to appear planar."}, {"label": "B", "text": "sp2; the nitrogen lone pair is delocalized into the carbonyl π system via resonance, which is maximized when the N lone pair is in a p orbital parallel to the C=O π bond."}, {"label": "C", "text": "sp; the triple-bond-like character of the C–N bond requires linear geometry."}, {"label": "D", "text": "sp3d; nitrogen uses d orbitals for extended conjugation."}]',
  'B',
  'The answer is B because amide nitrogen adopts sp2 hybridization so that its lone pair occupies an unhybridized p orbital aligned with the π* of the carbonyl, enabling resonance delocalization (C=O ↔ C–O− with C=N+). This resonance stabilization is what restricts rotation around the C–N bond in peptides (~20 kcal/mol barrier). Distractor A describes simple amines. Nitrogen is a second-row atom and does not have accessible d orbitals, ruling out D. This is a Scientific Reasoning and Problem Solving question because you must apply resonance theory to rationalize the hybridization of an amide nitrogen.',
  'hard'
);

-- Q99: sp Hybridization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'In the cyanide ion CN−, the carbon and nitrogen are triple-bonded. What is the hybridization of each atom?',
  '[{"label": "A", "text": "C: sp3; N: sp3"}, {"label": "B", "text": "C: sp2; N: sp2"}, {"label": "C", "text": "C: sp; N: sp"}, {"label": "D", "text": "C: sp; N: sp2"}]',
  'C',
  'The answer is C because both C and N in CN− are sp-hybridized: each atom has one σ bond and one lone pair (on C it''s the formal-charge-bearing pair; on N it''s the standard lone pair), giving 2 electron domains around each, i.e., sp hybridization. The remaining two unhybridized p orbitals on each atom form the two π bonds of the triple bond. Students may pick sp2 incorrectly if they include one of the π bonds in domain counting. This is a Knowledge of Scientific Concepts and Principles question because you must recall that sp hybridization accompanies 2 electron domains and triple-bonded atoms.',
  'easy'
);

-- Q100: Hybridization and Geometry
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'A central atom X has a seesaw (disphenoidal) molecular geometry, as in SF4. What is the hybridization of X in the standard VSEPR treatment?',
  '[{"label": "A", "text": "sp3"}, {"label": "B", "text": "sp3d"}, {"label": "C", "text": "sp3d2"}, {"label": "D", "text": "sp2"}]',
  'B',
  'The answer is B because a seesaw geometry arises from 5 electron domains (4 bonds + 1 lone pair), which is trigonal bipyramidal electronic geometry and sp3d hybridization. Students who focus only on the 4 atoms bonded (giving tetrahedral-like shape) may pick sp3, but this neglects the lone pair. This is a Scientific Reasoning and Problem Solving question because you must apply domain counting to go from molecular geometry back to hybridization.',
  'easy'
);

-- Q101: sp3 Hybridization
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Hybridization',
  'A chemist treats SF4 with one equivalent of F- to generate an adduct. Which change in sulfur''s hybridization best describes the reaction, assuming sulfur uses a d-orbital to accommodate the new electron domain?',
  '[{"label": "A", "text": "sp3 to sp3d"}, {"label": "B", "text": "sp3d to sp3d2"}, {"label": "C", "text": "sp3 to sp3d2"}, {"label": "D", "text": "sp3d to sp3d"}]',
  'B',
  'The answer is B because SF4 already has 5 electron domains (4 bonds + 1 lone pair = sp3d, seesaw), and adding F- brings it to 6 domains (sp3d2, octahedral SF5-). Students who forget that SF4 starts with a lone pair often misassign it as sp3, leading to choice A. Choice C skips the lone pair entirely. Choice D ignores the new bond. This is a Knowledge of Scientific Concepts and Principles question because you must recall that hybridization reflects the total number of electron domains, including lone pairs on hypervalent centers.',
  'hard'
);


-- ----------------------------------------------------------
-- Molecular Orbitals
-- ----------------------------------------------------------
-- Q102: Bonding and Antibonding Orbitals
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'Two 2p orbitals combine head-on to form a sigma bonding MO and its antibonding partner. If the bonding MO lies 180 kJ/mol below the atomic orbital energy, which statement best describes the antibonding MO in a real (not idealized) diatomic?',
  '[{"label": "A", "text": "It lies exactly 180 kJ/mol above the atomic orbital energy"}, {"label": "B", "text": "It lies more than 180 kJ/mol above the atomic orbital energy"}, {"label": "C", "text": "It lies less than 180 kJ/mol above the atomic orbital energy"}, {"label": "D", "text": "It lies at the same energy as the atomic orbital because the node cancels stabilization"}]',
  'B',
  'The answer is B because the antibonding orbital is destabilized more than the bonding orbital is stabilized due to increased nuclear-nuclear repulsion and the wavefunction node pushing electron density out of the internuclear region. Choice A is the common textbook ''symmetric'' idealization that ignores overlap integral corrections. Choice C reverses the asymmetry. Choice D confuses a nonbonding MO with an antibonding MO. This is a Knowledge of Scientific Concepts and Principles question because you must recall the asymmetric stabilization/destabilization inherent to MO theory.',
  'hard'
);

-- Q103: MO Diagrams
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'For the homonuclear diatomic B2 (Z=5), which ground-state MO configuration most likely accounts for its observed paramagnetism, given that s-p mixing is significant for second-row diatomics with Z less than 8?',
  '[{"label": "A", "text": "(sigma2s)2 (sigma*2s)2 (sigma2p)2"}, {"label": "B", "text": "(sigma2s)2 (sigma*2s)2 (pi2p)2 with one electron in each degenerate pi"}, {"label": "C", "text": "(sigma2s)2 (sigma*2s)2 (sigma2p)2 (pi2p)0"}, {"label": "D", "text": "(sigma2s)2 (sigma*2s)2 (pi2p)2 (sigma2p)0 fully paired"}]',
  'B',
  'The answer is B because s-p mixing raises the sigma2p above the pi2p set in B2, so the last two electrons fill the degenerate pi MOs singly per Hund''s rule, producing two unpaired electrons. Choice A uses the ''no-mixing'' ordering (correct for O2/F2 but wrong for B2), which would predict diamagnetism. Choice C pairs the electrons incorrectly. Choice D violates Hund''s rule. This is a Scientific Reasoning and Problem Solving question because you must apply s-p mixing rules to the specific case of B2 and connect orbital occupation to magnetic behavior.',
  'hard'
);

-- Q104: Bond Order from MO Theory
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'The superoxide ion O2- is generated during oxidative stress in mitochondria. Compared with neutral O2, what is the bond order of O2-?',
  '[{"label": "A", "text": "2.5, because an electron is removed from an antibonding orbital"}, {"label": "B", "text": "1.5, because an electron is added to an antibonding orbital"}, {"label": "C", "text": "2.0, unchanged because the new electron goes into a bonding orbital"}, {"label": "D", "text": "1.0, because the added electron fully cancels a pi bond"}]',
  'B',
  'The answer is B because the extra electron in O2- enters a pi*2p antibonding MO, dropping bond order from 2 (in O2) to 1.5. Choice A reverses the direction (that describes O2+). Choice C incorrectly places the electron in a bonding orbital. Choice D overcorrects, forgetting that only half a bond is canceled per additional antibonding electron. This is a Scientific Reasoning and Problem Solving question because you must apply the bond order formula after correctly identifying where an added electron is placed.',
  'medium'
);

-- Q105: Paramagnetism and Diamagnetism
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'Which of the following ground-state species is most likely to be diamagnetic?',
  '[{"label": "A", "text": "C2"}, {"label": "B", "text": "NO"}, {"label": "C", "text": "O2"}, {"label": "D", "text": "B2"}]',
  'A',
  'The answer is A because C2 has 8 valence electrons that fully pair in (sigma2s)2(sigma*2s)2(pi2p)4, giving zero unpaired electrons. NO has 11 valence electrons (odd-electron radical, paramagnetic). O2 has two unpaired pi* electrons. B2 has two unpaired pi electrons. A common trap is to assume C2 has a conventional sigma-only double bond; in MO theory C2 actually has a double pi bond with no net sigma bond, yet still diamagnetic. This is a Knowledge of Scientific Concepts and Principles question because you must recall which second-row diatomics have paired versus unpaired electrons.',
  'medium'
);

-- Q106: Bond Order from MO Theory
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'A student claims that removing one electron from N2 to form N2+ weakens the bond. Based on MO theory, which statement best evaluates this claim?',
  '[{"label": "A", "text": "Correct; bond order drops from 3 to 2.5 because an electron is removed from a bonding MO"}, {"label": "B", "text": "Correct; bond order drops from 3 to 2 because the removed electron was in a sigma bonding MO"}, {"label": "C", "text": "Incorrect; bond order rises because the electron comes from an antibonding MO"}, {"label": "D", "text": "Incorrect; bond order is unchanged because the electron comes from a nonbonding lone pair"}]',
  'A',
  'The answer is A because the HOMO of N2 (with s-p mixing) is the sigma2p bonding orbital, so its removal drops bond order from 3 to 2.5 and the bond lengthens slightly. Choice B double-counts the electron removal. Choice C confuses N2 with O2, where the HOMO is antibonding. Choice D ignores that the relevant electron is in a bonding MO, not a nonbonding lone pair. This is a Scientific Reasoning and Problem Solving question because you must apply s-p mixing to identify the HOMO before computing the new bond order.',
  'medium'
);

-- Q107: Paramagnetism and Diamagnetism
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'A researcher cools O2 gas in a magnetic field and finds it is pulled toward the stronger field region. Which MO feature most directly explains this result?',
  '[{"label": "A", "text": "A single electron in sigma2p"}, {"label": "B", "text": "Two unpaired electrons in the degenerate pi*2p set"}, {"label": "C", "text": "A filled sigma*2s orbital"}, {"label": "D", "text": "An empty sigma*2p orbital"}]',
  'B',
  'The answer is B because O2 has 12 valence electrons and, after filling through pi2p, the last two electrons enter the degenerate pi*2p MOs singly per Hund''s rule, producing two unpaired spins and net paramagnetism. Choice A misidentifies the HOMO. Choice C describes a feature shared with diamagnetic species. Choice D mentions an empty orbital, which cannot cause paramagnetism. This is a Scientific Reasoning and Problem Solving question because you must connect an observed magnetic behavior to specific MO occupancies.',
  'hard'
);

-- Q108: MO Diagrams
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'Which best explains why the sigma2p MO is placed BELOW the pi2p MOs in N2 but ABOVE them in O2?',
  '[{"label": "A", "text": "Electron-electron repulsion is smaller in O2 due to its larger atoms"}, {"label": "B", "text": "2s-2p energy gap is small in lighter second-row atoms, permitting s-p mixing"}, {"label": "C", "text": "Pi orbitals are always lower than sigma orbitals for p-block diatomics"}, {"label": "D", "text": "Inversion is caused by the paramagnetism of O2"}]',
  'B',
  'The answer is B because in lighter second-row diatomics (Li2 through N2) the 2s and 2p orbitals are close enough in energy that s-p mixing raises the sigma2p above the pi2p; for O2 and F2, the gap widens and mixing becomes negligible. Choice A invokes an unrelated factor. Choice C is false. Choice D reverses cause and effect. This is a Knowledge of Scientific Concepts and Principles question because you must recall why MO ordering changes across the second-row diatomics.',
  'medium'
);

-- Q109: Bonding and Antibonding Orbitals
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'A node between the two nuclei in a molecular orbital is most likely associated with which feature of that orbital?',
  '[{"label": "A", "text": "Lower energy than the constituent atomic orbitals"}, {"label": "B", "text": "Higher energy than the constituent atomic orbitals"}, {"label": "C", "text": "Energy equal to a nonbonding lone pair"}, {"label": "D", "text": "A bond order contribution of +1"}]',
  'B',
  'The answer is B because an internuclear node indicates destructive interference between atomic orbitals, characteristic of an antibonding MO that is destabilized relative to the parent atomic orbitals. Choice A describes a bonding MO. Choice C describes nonbonding orbitals, which usually have no internuclear node because they are localized. Choice D describes a bonding contribution. This is a Knowledge of Scientific Concepts and Principles question because you must recall how orbital nodes relate to bonding, nonbonding, and antibonding character.',
  'easy'
);

-- Q110: Bond Order from MO Theory
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'Rank the bond orders of O2, O2+, and O2- from highest to lowest.',
  '[{"label": "A", "text": "O2 > O2+ > O2-"}, {"label": "B", "text": "O2+ > O2 > O2-"}, {"label": "C", "text": "O2- > O2 > O2+"}, {"label": "D", "text": "O2 > O2- > O2+"}]',
  'B',
  'The answer is B because all three species have electrons in the pi*2p antibonding MO. Removing an antibonding electron (O2+) raises bond order to 2.5, neutral O2 is 2.0, and adding another antibonding electron (O2-) drops it to 1.5. Choice A swaps the cation and anion. Choice C reverses the trend. Choice D mis-ranks the anion. This is a Scientific Reasoning and Problem Solving question because you must apply the bond order formula to three related species and rank them based on antibonding occupancy.',
  'easy'
);

-- Q111: Paramagnetism and Diamagnetism
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'Nitric oxide (NO) is a signaling molecule in vascular endothelium. Which MO description best explains its paramagnetic and mildly reactive character?',
  '[{"label": "A", "text": "One unpaired electron in a pi*2p MO localized largely on nitrogen"}, {"label": "B", "text": "Two unpaired electrons in degenerate pi*2p MOs"}, {"label": "C", "text": "One unpaired electron in sigma2p"}, {"label": "D", "text": "All electrons paired with paramagnetism from orbital angular momentum only"}]',
  'A',
  'The answer is A because NO has 11 valence electrons, leaving one unpaired electron in the pi*2p; asymmetric bonding character places more of the SOMO density on the less electronegative nitrogen, which accounts for N-centered reactivity. Choice B describes O2. Choice C misassigns the SOMO. Choice D invokes a mechanism irrelevant to a simple diatomic radical. This is a Scientific Reasoning and Problem Solving question because you must connect an odd electron count to a specific MO and predict its physical location.',
  'medium'
);

-- Q112: Bonding and Antibonding Orbitals
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'Which pair of atomic orbitals, combined in a diatomic, forms a NONBONDING rather than a bonding or antibonding MO by symmetry?',
  '[{"label": "A", "text": "Two 2s orbitals"}, {"label": "B", "text": "A 2s on one atom and a 2pz on the other, aligned along the bond axis"}, {"label": "C", "text": "A 2s on one atom and a 2px perpendicular to the bond axis on the other"}, {"label": "D", "text": "Two 2pz orbitals aligned head-on"}]',
  'C',
  'The answer is C because a 2s is symmetric about the bond axis but a perpendicular 2px has a node along it, so their overlap integral is zero and the MO is nonbonding by symmetry. Choices A, B, and D all preserve symmetry along the bond axis and produce net overlap (sigma bonding/antibonding). This is a Knowledge of Scientific Concepts and Principles question because you must recall that MO formation requires nonzero overlap dictated by orbital symmetry.',
  'easy'
);

-- Q113: MO Diagrams
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Molecular Orbitals',
  'In the MO diagram of HF, the bonding sigma MO lies closer in energy to the F 2p than to the H 1s. What does this most directly imply?',
  '[{"label": "A", "text": "The bonding pair spends more time near fluorine, consistent with a polar covalent bond"}, {"label": "B", "text": "The bonding pair spends more time near hydrogen"}, {"label": "C", "text": "The bond has zero ionic character"}, {"label": "D", "text": "The MO is nonbonding"}]',
  'A',
  'The answer is A because an MO''s energy proximity to one atomic orbital indicates the larger AO coefficient on that atom; here, more fluorine character in the bonding MO localizes electron density on F. Choice B reverses the polarity. Choice C contradicts the asymmetric MO. Choice D misuses the term ''nonbonding.'' This is a Scientific Reasoning and Problem Solving question because you must interpret MO energy asymmetry to infer electron density distribution.',
  'easy'
);


-- ----------------------------------------------------------
-- Sigma and Pi Bonds
-- ----------------------------------------------------------
-- Q114: Counting Sigma and Pi Bonds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Sigma and Pi Bonds',
  'How many sigma and pi bonds are present in one molecule of acrylonitrile, CH2=CH-C#N (where # denotes a triple bond)?',
  '[{"label": "A", "text": "6 sigma, 3 pi"}, {"label": "B", "text": "7 sigma, 2 pi"}, {"label": "C", "text": "6 sigma, 2 pi"}, {"label": "D", "text": "7 sigma, 3 pi"}]',
  'D',
  'The answer is D because acrylonitrile has 3 C-H + 1 C-C + 1 C-C (double, counts 1 sigma) + 1 C-C (triple to N, counts 1 sigma) = 6 C/H sigma bonds, plus correctly counting: 3 C-H, 1 C=C (1 sigma + 1 pi), 1 C-C single, 1 C#N (1 sigma + 2 pi) gives 7 sigma and 3 pi. Choice A undercounts sigma. Choice B misses one pi. Choice C misses one pi and one sigma. This is a Scientific Reasoning and Problem Solving question because you must apply the rule ''every bond = 1 sigma; each additional multiplicity = 1 pi'' to every bond in the structure.',
  'medium'
);

-- Q115: Bond Rotation
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Sigma and Pi Bonds',
  'A student rotates one end of a substituted alkene about the C=C double bond. What is the most likely consequence of this rotation?',
  '[{"label": "A", "text": "Free rotation occurs because pi overlap is unaffected by orientation"}, {"label": "B", "text": "Rotation disrupts pi overlap, converting cis and trans isomers only above a high energy barrier"}, {"label": "C", "text": "Rotation breaks the sigma bond first"}, {"label": "D", "text": "Rotation converts sp2 carbons to sp3 carbons"}]',
  'B',
  'The answer is B because pi bonds require parallel p-orbital overlap, so rotating around a C=C requires twisting the p orbitals out of alignment, costing roughly 60-70 kcal/mol and explaining geometric isomerism. Choice A confuses pi rotation with sigma rotation. Choice C reverses which bond breaks first (sigma is stronger but oriented cylindrically). Choice D conflates hybridization with rotation. This is a Knowledge of Scientific Concepts and Principles question because you must recall how pi overlap depends on orientation.',
  'easy'
);

-- Q116: Sigma Bond Formation
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Sigma and Pi Bonds',
  'Which overlap combination most likely produces a strong sigma bond between carbon and oxygen in a carbonyl group?',
  '[{"label": "A", "text": "sp2(C) with sp2(O), head-on along the C-O axis"}, {"label": "B", "text": "sp2(C) with unhybridized 2p(O), side-on"}, {"label": "C", "text": "2p(C) with 2p(O), side-on"}, {"label": "D", "text": "sp3(C) with sp3(O)"}]',
  'A',
  'The answer is A because in a carbonyl both C and O are sp2 hybridized, with one sp2 orbital from each overlapping head-on to form the sigma C-O bond; the remaining unhybridized p orbitals form the pi bond. Choice B describes pi, not sigma. Choice C also describes pi overlap. Choice D misassigns hybridization. This is a Knowledge of Scientific Concepts and Principles question because you must recall the specific hybrid orbitals involved in sigma formation at a sp2 carbonyl.',
  'medium'
);

-- Q117: Pi Bond Formation
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Sigma and Pi Bonds',
  'In allene, H2C=C=CH2, the two C=C pi bonds are oriented perpendicular to each other. Which feature of the central carbon best explains this geometry?',
  '[{"label": "A", "text": "The central carbon is sp hybridized with two perpendicular unhybridized p orbitals"}, {"label": "B", "text": "The central carbon is sp2 hybridized with one unhybridized p orbital"}, {"label": "C", "text": "The central carbon is sp3 hybridized"}, {"label": "D", "text": "The terminal CH2 groups rotate freely about sigma bonds"}]',
  'A',
  'The answer is A because the central C in allene has two sigma bonds (one to each adjacent carbon) with two remaining p orbitals 90 degrees apart; each forms a pi bond with the corresponding terminal carbon, forcing the two CH2 planes to be perpendicular. Choice B would give only one pi bond. Choice C cannot form pi bonds. Choice D ignores the rigid pi framework. This is a Scientific Reasoning and Problem Solving question because you must apply sp hybridization geometry to derive a 3D molecular feature.',
  'medium'
);

-- Q118: Counting Sigma and Pi Bonds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Sigma and Pi Bonds',
  'Benzene has a delocalized pi system. Counting both Kekule resonance structures and the delocalized description, how many sigma bonds and how many electrons in the pi system does benzene contain?',
  '[{"label": "A", "text": "12 sigma bonds and 6 pi electrons"}, {"label": "B", "text": "6 sigma bonds and 6 pi electrons"}, {"label": "C", "text": "12 sigma bonds and 3 pi electrons"}, {"label": "D", "text": "12 sigma bonds and 12 pi electrons"}]',
  'A',
  'The answer is A because benzene has 6 C-H sigma + 6 C-C sigma = 12 sigma bonds, and 6 pi electrons delocalized over the ring (one per carbon, satisfying Huckel''s 4n+2 rule for n=1). Choice B forgets the C-H bonds. Choice C halves the electron count. Choice D double-counts electrons as bonds. This is a Scientific Reasoning and Problem Solving question because you must apply counting rules while distinguishing localized sigma framework from delocalized pi electrons.',
  'medium'
);

-- Q119: Bond Rotation
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Sigma and Pi Bonds',
  'Which molecule has the HIGHEST energy barrier to rotation about the bolded bond?',
  '[{"label": "A", "text": "Ethane, H3C-CH3"}, {"label": "B", "text": "Ethylene, H2C=CH2"}, {"label": "C", "text": "Butane, CH3-CH2-CH2-CH3 about the central C-C"}, {"label": "D", "text": "Dimethyl ether, CH3-O-CH3 about a C-O"}]',
  'B',
  'The answer is B because rotation about a C=C requires breaking the pi bond (~65 kcal/mol), vastly higher than any sigma rotation barrier, which is typically 3-5 kcal/mol for staggered/eclipsed conformations. Choices A, C, and D are all sigma-only rotations with small barriers from steric strain. This is a Scientific Reasoning and Problem Solving question because you must compare rotational barriers and connect them to the underlying bond type.',
  'easy'
);

-- Q120: Sigma Bond Formation
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Sigma and Pi Bonds',
  'A sigma bond between two sp3 carbons is usually longer and weaker than a sigma bond between two sp carbons. Which factor best explains this difference?',
  '[{"label": "A", "text": "sp orbitals have more s character, which shortens the bond and places electrons closer to the nuclei"}, {"label": "B", "text": "sp3 orbitals have more s character, causing stronger overlap"}, {"label": "C", "text": "Pi bonding contributes to sigma bond length"}, {"label": "D", "text": "sp3 carbons always have lone pairs that weaken adjacent sigma bonds"}]',
  'A',
  'The answer is A because s character increases from 25% in sp3 to 50% in sp, pulling electrons closer to nuclei, increasing effective nuclear attraction on the bonding pair, and shortening/strengthening the bond. Choice B reverses the s-character ordering. Choice C confuses sigma with pi effects. Choice D misattributes electronics to lone pairs. This is a Knowledge of Scientific Concepts and Principles question because you must recall how s character affects bond length and strength.',
  'medium'
);

-- Q121: Counting Sigma and Pi Bonds
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Sigma and Pi Bonds',
  'Pyridine (C5H5N) has the formula of benzene with one CH replaced by N. How many sigma bonds does pyridine have, and how many nitrogen lone pairs lie in the pi system?',
  '[{"label": "A", "text": "11 sigma bonds; 0 N lone pairs in the pi system"}, {"label": "B", "text": "11 sigma bonds; 1 N lone pair in the pi system"}, {"label": "C", "text": "12 sigma bonds; 1 N lone pair in the pi system"}, {"label": "D", "text": "11 sigma bonds; 2 N lone pairs in the pi system"}]',
  'A',
  'The answer is A because pyridine has 5 C-H + 5 C-C(/C-N) ring sigma bonds + 1 N-ring-sigma replaced; carefully: 5 C-H sigma + 6 ring sigma (3 C-C and 2 C-N and the closure) = 11 sigma. The N lone pair lies in an sp2 hybrid IN the ring plane, NOT in the pi system, preserving aromaticity with 6 pi electrons from the 5 C and 1 N contributing one p electron each. Choice B confuses pyridine with pyrrole (where N''s lone pair is in pi). Choice C over-counts sigma. Choice D doubles lone pairs. This is a Scientific Reasoning and Problem Solving question because you must distinguish in-plane lone pairs from pi-system lone pairs.',
  'hard'
);

-- Q122: Pi Bond Formation
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Sigma and Pi Bonds',
  'Which pair of orbitals best forms a pi bond between two atoms bonded along the z-axis?',
  '[{"label": "A", "text": "sp2 with sp2, head-on"}, {"label": "B", "text": "2px with 2px, side-on"}, {"label": "C", "text": "2pz with 2pz, head-on"}, {"label": "D", "text": "2s with 2pz"}]',
  'B',
  'The answer is B because pi bonds form from side-on overlap of parallel p orbitals perpendicular to the bond axis (2px or 2py with the bond along z). Choice A forms sigma. Choice C forms a sigma (head-on pz overlap). Choice D forms a sigma. A common trap is to pick any p-p combination; orientation is what distinguishes sigma from pi. This is a Knowledge of Scientific Concepts and Principles question because you must recall the orbital-orientation requirement for pi versus sigma overlap.',
  'easy'
);


-- ----------------------------------------------------------
-- Intermolecular Forces
-- ----------------------------------------------------------
-- Q123: Hydrogen Bonding
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Ethanol (bp 78 degrees C) and dimethyl ether (bp -24 degrees C) have identical molecular formulas (C2H6O) and similar molar masses. Which feature best explains the large difference in boiling point?',
  '[{"label": "A", "text": "Ethanol has an O-H donor that forms hydrogen bonds, while dimethyl ether lacks an N-H, O-H, or F-H donor"}, {"label": "B", "text": "Ethanol has stronger London dispersion forces due to its chain geometry"}, {"label": "C", "text": "Dimethyl ether is more polar than ethanol overall"}, {"label": "D", "text": "Dimethyl ether has a larger surface area for dipole-dipole contacts"}]',
  'A',
  'The answer is A because hydrogen bonding requires H covalently bonded to N, O, or F; ethanol''s -OH supplies this donor, but dimethyl ether only has O acceptors and no H on O/N/F. Choices B and D misattribute the effect to dispersion or surface area, which are similar for the two isomers. Choice C is false; dimethyl ether is slightly less polar. This is a Knowledge of Scientific Concepts and Principles question because you must recall the donor criterion for hydrogen bonding.',
  'hard'
);

-- Q124: London Dispersion Forces
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Which of the following best accounts for the higher boiling point of n-pentane (36 degrees C) compared with neopentane (9 degrees C), despite identical molecular formulas?',
  '[{"label": "A", "text": "n-Pentane has a larger dipole moment"}, {"label": "B", "text": "n-Pentane has more surface contact area, enhancing London dispersion forces"}, {"label": "C", "text": "Neopentane has intramolecular hydrogen bonds"}, {"label": "D", "text": "Neopentane has stronger induced dipoles due to branching"}]',
  'B',
  'The answer is B because linear molecules lay alongside each other with greater surface contact, producing more instantaneous-induced-dipole interactions; spherical neopentane minimizes contact area. Choice A is false because both are essentially nonpolar. Choice C is impossible; there is no H on N/O/F. Choice D reverses the trend. This is a Scientific Reasoning and Problem Solving question because you must apply shape-dependent dispersion reasoning to predict relative boiling points.',
  'medium'
);

-- Q125: Physical Properties and IMFs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Which liquid most likely has the HIGHEST surface tension at 25 degrees C?',
  '[{"label": "A", "text": "Hexane"}, {"label": "B", "text": "Diethyl ether"}, {"label": "C", "text": "Water"}, {"label": "D", "text": "Acetone"}]',
  'C',
  'The answer is C because water''s extensive hydrogen-bonding network produces uniquely strong cohesive forces, yielding the highest surface tension of the four. Hexane has only dispersion forces. Diethyl ether has moderate dipole-dipole interactions but no H donor. Acetone has dipole-dipole from its carbonyl but no H-bonding donors. This is a Scientific Reasoning and Problem Solving question because you must rank the IMF strengths of four liquids and connect them to a bulk property.',
  'medium'
);

-- Q126: Relative Strength of IMFs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Four compounds are listed below with their molar masses in g/mol. Which most likely has the HIGHEST boiling point?',
  '[{"label": "A", "text": "CH3CH2CH2CH3 (butane, 58)"}, {"label": "B", "text": "CH3CH2CHO (propanal, 58)"}, {"label": "C", "text": "CH3CH2CH2OH (1-propanol, 60)"}, {"label": "D", "text": "CH3OCH2CH3 (methyl ethyl ether, 60)"}]',
  'C',
  'The answer is C because 1-propanol has an O-H that allows hydrogen bonding, dominating over dipole-dipole (propanal, ether) and dispersion (butane) at comparable molar mass. Choice A has only dispersion forces. Choice B has dipole-dipole but no H-bond donor. Choice D likewise lacks an H donor. This is a Scientific Reasoning and Problem Solving question because you must rank IMFs across isomers/near-isomers with similar molar masses.',
  'easy'
);

-- Q127: Dipole-Dipole Interactions
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'CH3F has a larger dipole moment than CH3Cl, yet CH3Cl has a higher boiling point. Which factor best resolves this apparent paradox?',
  '[{"label": "A", "text": "CH3Cl has stronger dispersion forces due to the larger, more polarizable Cl atom"}, {"label": "B", "text": "CH3F forms hydrogen bonds that CH3Cl cannot"}, {"label": "C", "text": "CH3Cl has a lone pair in a higher energy orbital"}, {"label": "D", "text": "Dipole moment is not a measure of polarity"}]',
  'A',
  'The answer is A because London dispersion scales with polarizability, and the larger electron cloud of Cl contributes more to total IMF than the modest dipole-dipole advantage of CH3F. Choice B wrongly invokes H-bonding (C-H-F is generally too weak to count as an H-bond). Choice C is physically unrelated. Choice D is false. This is a Scientific Reasoning and Problem Solving question because you must weigh multiple IMF types simultaneously to explain a macroscopic property.',
  'easy'
);

-- Q128: Hydrogen Bonding
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'The boiling point of HF (19.5 degrees C) is much higher than that of HCl (-85 degrees C), but the boiling point of H2O is even higher (100 degrees C). Which best explains why H2O exceeds HF?',
  '[{"label": "A", "text": "H2O has two H donors AND two lone-pair acceptors per molecule, enabling a 3D H-bonding network"}, {"label": "B", "text": "H2O has stronger covalent bonds than HF"}, {"label": "C", "text": "HF has weaker dispersion forces than H2O"}, {"label": "D", "text": "Fluorine''s higher electronegativity weakens the H-F bond"}]',
  'A',
  'The answer is A because each water molecule can participate in up to four H-bonds (two as donor, two as acceptor), while HF has only one donor and (effectively) one acceptor per molecule, limiting it to chain-like networks. Choice B conflates covalent strength with IMF. Choice C is a minor effect. Choice D is backwards. This is a Scientific Reasoning and Problem Solving question because you must compare H-bond network topology, not just bond strength.',
  'medium'
);

-- Q129: London Dispersion Forces
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Rank the noble gases He, Ne, Ar, and Kr from LOWEST to HIGHEST boiling point.',
  '[{"label": "A", "text": "He < Ne < Ar < Kr"}, {"label": "B", "text": "Kr < Ar < Ne < He"}, {"label": "C", "text": "He < Ar < Ne < Kr"}, {"label": "D", "text": "Ne < He < Ar < Kr"}]',
  'A',
  'The answer is A because noble gases have only dispersion forces, whose strength scales with electron count/polarizability. Going down the group (He to Kr), polarizability rises and so does boiling point. Choices B, C, and D all break the monotonic relationship between atomic size and dispersion strength. This is a Knowledge of Scientific Concepts and Principles question because you must recall how London dispersion scales with polarizability.',
  'easy'
);

-- Q130: Physical Properties and IMFs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'A substance has high vapor pressure at room temperature. Which combination of IMFs is most likely present?',
  '[{"label": "A", "text": "Extensive hydrogen bonding and strong dipole-dipole interactions"}, {"label": "B", "text": "Only weak London dispersion forces"}, {"label": "C", "text": "Ionic interactions in a molecular solid"}, {"label": "D", "text": "Hydrogen bonding with a 3D network"}]',
  'B',
  'The answer is B because high vapor pressure indicates weak intermolecular attractions that allow molecules to easily escape the liquid phase; only dispersion forces is the weakest profile. Choices A and D describe strong IMFs that would lower vapor pressure. Choice C describes a solid-state interaction not typical of volatile liquids. This is a Scientific Reasoning and Problem Solving question because you must link IMF strength to a bulk property (vapor pressure).',
  'easy'
);

-- Q131: Relative Strength of IMFs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Which of the following IMFs, per molecular contact, is typically STRONGEST in magnitude?',
  '[{"label": "A", "text": "Hydrogen bonding"}, {"label": "B", "text": "Dipole-dipole interaction"}, {"label": "C", "text": "London dispersion"}, {"label": "D", "text": "Ion-dipole interaction"}]',
  'D',
  'The answer is D because ion-dipole interactions (e.g., Na+ with water) typically carry 40-600 kJ/mol of stabilization, exceeding hydrogen bonds (~20 kJ/mol), dipole-dipole (a few kJ/mol), and dispersion (< 10 kJ/mol). A common trap is to pick hydrogen bonding because it is the strongest neutral IMF, but the question includes a charged case. This is a Knowledge of Scientific Concepts and Principles question because you must recall the relative magnitudes of all IMF types including those involving ions.',
  'easy'
);

-- Q132: Physical Properties and IMFs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Which property of ice directly reflects the directional nature of hydrogen bonds in H2O?',
  '[{"label": "A", "text": "Ice is less dense than liquid water because H-bonds enforce an open tetrahedral lattice"}, {"label": "B", "text": "Ice has a high heat of sublimation"}, {"label": "C", "text": "Ice conducts electricity poorly"}, {"label": "D", "text": "Ice is colorless and transparent"}]',
  'A',
  'The answer is A because each water molecule in ice H-bonds to four neighbors in a tetrahedral arrangement dictated by the O''s two lone pairs and two O-H donors, forming a lattice less densely packed than liquid water. Choice B reflects total IMF strength, not directionality. Choices C and D are unrelated to directional H-bonding. This is a Scientific Reasoning and Problem Solving question because you must connect a macroscopic anomaly to the geometric requirements of H-bonding.',
  'easy'
);

-- Q133: Hydrogen Bonding
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Which solute, dissolved in water at 25 degrees C, can act as BOTH a hydrogen bond donor and a hydrogen bond acceptor?',
  '[{"label": "A", "text": "Acetone, (CH3)2C=O"}, {"label": "B", "text": "Methanol, CH3OH"}, {"label": "C", "text": "Diethyl ether, (C2H5)2O"}, {"label": "D", "text": "Trimethylamine, (CH3)3N"}]',
  'B',
  'The answer is B because methanol''s -OH provides both a donor (the O-H) and an acceptor (the oxygen lone pairs). Acetone, diethyl ether, and trimethylamine all have lone pairs (acceptors) but lack an H bonded to N, O, or F and cannot donate. This is a Knowledge of Scientific Concepts and Principles question because you must recall the donor/acceptor criteria for hydrogen bonding.',
  'medium'
);

-- Q134: London Dispersion Forces
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Which compound most likely has the HIGHEST polarizability and thus the strongest London dispersion contribution?',
  '[{"label": "A", "text": "F2"}, {"label": "B", "text": "Cl2"}, {"label": "C", "text": "Br2"}, {"label": "D", "text": "I2"}]',
  'D',
  'The answer is D because polarizability increases with the number of electrons and atom size; I2 has the largest, most diffuse electron cloud and correspondingly the strongest dispersion forces, explaining why it is a solid at room temperature while F2 is a gas. This is a Knowledge of Scientific Concepts and Principles question because you must recall how polarizability varies down a group.',
  'easy'
);

-- Q135: Physical Properties and IMFs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Acetic acid in the gas phase exists partly as a cyclic dimer. Which IMF feature is most directly responsible for this dimerization?',
  '[{"label": "A", "text": "Double hydrogen bonding between two -COOH groups"}, {"label": "B", "text": "Van der Waals attractions between methyl groups"}, {"label": "C", "text": "Pi stacking of the C=O groups"}, {"label": "D", "text": "Ion-dipole forces from dissociated protons"}]',
  'A',
  'The answer is A because two carboxylic acids can form a cyclic 8-membered dimer stabilized by two complementary O-H to O=C hydrogen bonds, strong enough to persist in the gas phase. Choices B and C describe weaker forces insufficient to explain dimerization. Choice D incorrectly invokes ionic dissociation, which does not occur in the gas phase. This is a Scientific Reasoning and Problem Solving question because you must map a specific structural motif (the -COOH pair) to the H-bonding pattern that enables dimerization.',
  'medium'
);

-- Q136: Dipole-Dipole Interactions
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Among the four molecules below, which has the highest boiling point primarily due to dipole-dipole interactions (not hydrogen bonding or dispersion)?',
  '[{"label": "A", "text": "CH3CN (acetonitrile)"}, {"label": "B", "text": "CH3CH2CH2CH3 (n-butane)"}, {"label": "C", "text": "CH3OH (methanol)"}, {"label": "D", "text": "CH4"}]',
  'A',
  'The answer is A because acetonitrile has a large C#N dipole but no H on N/O/F, so its dominant IMF is dipole-dipole. Choice B has only dispersion. Choice C''s dominant IMF is hydrogen bonding. Choice D is nonpolar. This is a Scientific Reasoning and Problem Solving question because you must identify the dominant IMF type for each compound and filter by the specific category named in the stem.',
  'easy'
);

-- Q137: Physical Properties and IMFs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Two liquids A and B are fully miscible. A has strong H-bonding and B is nonpolar. When mixed, the enthalpy of mixing is positive and the solution boils lower than either pure liquid. Which statement best explains the deviation from Raoult''s law?',
  '[{"label": "A", "text": "A-B interactions are weaker than A-A H-bonds, so escaping molecules face fewer cohesive forces"}, {"label": "B", "text": "A-B interactions are stronger than A-A and B-B, increasing cohesive forces"}, {"label": "C", "text": "Raoult''s law predicts all mixtures boil lower than either pure liquid"}, {"label": "D", "text": "B forms a complex with A that lowers vapor pressure"}]',
  'A',
  'The answer is A because positive deviation from Raoult''s law arises when A-B interactions (here weak dispersion) are weaker than the H-bonding in pure A, so more molecules escape to the gas phase and vapor pressure rises. Choice B describes negative deviation. Choice C is false. Choice D describes a stabilizing interaction that would lower vapor pressure. This is a Scientific Reasoning and Problem Solving question because you must apply molecular IMF reasoning to a macroscopic thermodynamic observation.',
  'medium'
);

-- Q138: Relative Strength of IMFs
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'A protein in a hydrophobic pocket binds a ligand with complementary shape. The binding is driven largely by release of ordered water. Which best describes the dominant IMF between the ligand and the pocket itself once bound?',
  '[{"label": "A", "text": "Hydrogen bonds between the ligand and the protein backbone"}, {"label": "B", "text": "London dispersion (van der Waals) contacts across the surface"}, {"label": "C", "text": "Ionic salt bridges"}, {"label": "D", "text": "Covalent bonds between ligand and side chains"}]',
  'B',
  'The answer is B because a hydrophobic pocket by definition contains nonpolar side chains that interact via induced-dipole (dispersion) forces with the bound ligand. Choice A describes an interaction absent in a strictly hydrophobic environment. Choice C requires ionic groups. Choice D describes a covalent bond, not an IMF. Note the stem distinguishes the driving force (entropy of water release) from the residual IMF. This is a Scientific Reasoning and Problem Solving question because you must apply IMF categories to a biological binding event.',
  'medium'
);

-- Q139: Hydrogen Bonding
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Intermolecular Forces',
  'Intramolecular hydrogen bonding lowers the boiling point of a compound relative to a structurally similar isomer with intermolecular hydrogen bonding. Which pair of isomers most clearly demonstrates this effect?',
  '[{"label": "A", "text": "o-Nitrophenol vs. p-nitrophenol, where o-nitrophenol has the lower bp"}, {"label": "B", "text": "Cis-2-butene vs. trans-2-butene"}, {"label": "C", "text": "n-Pentane vs. neopentane"}, {"label": "D", "text": "Methanol vs. ethanol"}]',
  'A',
  'The answer is A because o-nitrophenol forms an intramolecular H-bond between the -OH and the adjacent -NO2, satisfying its donor/acceptor internally and leaving fewer H-bonds available for intermolecular network formation; p-nitrophenol must form intermolecular H-bonds and boils much higher. Choice B is a cis/trans alkene pair with no H-bond donor. Choice C is a dispersion-shape comparison. Choice D is not an isomer pair. This is a Scientific Reasoning and Problem Solving question because you must distinguish intramolecular vs. intermolecular H-bonding and connect the distinction to boiling point.',
  'easy'
);


-- ----------------------------------------------------------
-- Periodic Trends
-- ----------------------------------------------------------
-- Q140: Ionization Energy
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'The first ionization energy of oxygen (1314 kJ/mol) is slightly lower than that of nitrogen (1402 kJ/mol), breaking the general left-to-right trend. Which factor best explains this anomaly?',
  '[{"label": "A", "text": "Removing the fourth 2p electron from oxygen relieves electron-electron repulsion in a doubly occupied orbital"}, {"label": "B", "text": "Oxygen has a larger atomic radius than nitrogen"}, {"label": "C", "text": "Nitrogen has a higher effective nuclear charge than oxygen"}, {"label": "D", "text": "Oxygen''s half-filled p subshell is more stable than nitrogen''s"}]',
  'A',
  'The answer is A because the 4th p electron in O occupies an already-occupied 2p orbital, creating pairing repulsion that destabilizes it and makes it easier to remove than N''s singly-occupied 2p. Choice B contradicts the trend. Choice C is true numerically but does not override the repulsion effect. Choice D reverses the half-filled stability (N, not O, has the half-filled p3). This is a Knowledge of Scientific Concepts and Principles question because you must recall the pairing-energy anomaly at the p4 configuration.',
  'medium'
);

-- Q141: Electronegativity Trends
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'A chemist wants the smallest possible dipole moment in a diatomic molecule formed from a pair of main-group atoms. Which pair best fits this requirement?',
  '[{"label": "A", "text": "C and S"}, {"label": "B", "text": "H and Cl"}, {"label": "C", "text": "Na and F"}, {"label": "D", "text": "C and O"}]',
  'A',
  'The answer is A because C (EN 2.55) and S (EN 2.58) have essentially identical electronegativities, producing minimal charge separation. H-Cl has a difference of ~1.0, Na-F ~3.0 (ionic), and C-O ~0.9. Students often pick C-O thinking it is ''nonpolar enough'' but S-C is closer to zero. This is a Scientific Reasoning and Problem Solving question because you must apply electronegativity differences to predict relative dipole magnitudes.',
  'easy'
);

-- Q142: Atomic and Ionic Radius
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'Rank the following isoelectronic species (all with 10 electrons) from SMALLEST to LARGEST radius: N3-, O2-, F-, Na+, Mg2+.',
  '[{"label": "A", "text": "Mg2+ < Na+ < F- < O2- < N3-"}, {"label": "B", "text": "N3- < O2- < F- < Na+ < Mg2+"}, {"label": "C", "text": "F- < O2- < N3- < Na+ < Mg2+"}, {"label": "D", "text": "Na+ < Mg2+ < F- < O2- < N3-"}]',
  'A',
  'The answer is A because in an isoelectronic series, the species with the largest nuclear charge (Mg2+ with Z=12) pulls the 10 electrons in tightest, while N3- with Z=7 has the loosest hold and the largest radius. Choice B reverses the correct order. Choices C and D misplace the cations relative to anions. This is a Scientific Reasoning and Problem Solving question because you must apply effective nuclear charge reasoning to a constant-electron series.',
  'easy'
);

-- Q143: Electron Affinity
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'Which element most likely has the MOST negative (most exothermic) first electron affinity?',
  '[{"label": "A", "text": "F"}, {"label": "B", "text": "Cl"}, {"label": "C", "text": "O"}, {"label": "D", "text": "N"}]',
  'B',
  'The answer is B because Cl has the most negative EA (-349 kJ/mol) due to its larger atomic volume accommodating the added electron without the severe electron-electron repulsion that plagues the compact 2p shell of F (-328 kJ/mol). Choice A is the trap for students who expect fluorine to always ''win'' electronegativity trends. Choice C suffers the same compact-shell repulsion. Choice D has a nearly zero (slightly positive) EA due to filled half-shell pairing. This is a Knowledge of Scientific Concepts and Principles question because you must recall the second-row anomaly in electron affinity.',
  'easy'
);

-- Q144: Ionization Energy
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'Which successive ionization energy shows the LARGEST jump for a sodium atom?',
  '[{"label": "A", "text": "Between IE1 and IE2"}, {"label": "B", "text": "Between IE2 and IE3"}, {"label": "C", "text": "Between IE8 and IE9"}, {"label": "D", "text": "Between IE10 and IE11"}]',
  'A',
  'The answer is A because Na has configuration [Ne]3s1; removing the single 3s electron is easy, but the next electron must come from the filled 2p core shell, producing a massive jump (IE1 ~ 496 kJ/mol vs. IE2 ~ 4562 kJ/mol). Choice B, C, and D are core-to-core jumps that are large but smaller in proportional terms than the valence-to-core transition. This is a Scientific Reasoning and Problem Solving question because you must apply electron configuration to anticipate where a core shell is breached.',
  'easy'
);

-- Q145: Atomic and Ionic Radius
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'Which cation is most likely SMALLER than its neutral parent atom by the greatest absolute amount?',
  '[{"label": "A", "text": "Na forming Na+"}, {"label": "B", "text": "Mg forming Mg+"}, {"label": "C", "text": "Mg forming Mg2+"}, {"label": "D", "text": "Al forming Al+"}]',
  'C',
  'The answer is C because removing both valence 3s electrons from Mg eliminates an entire shell, collapsing the radius from ~160 pm to ~72 pm. Choice A removes only one electron but also eliminates a shell (~186 pm to ~102 pm), close but smaller absolute change. Choices B and D remove one electron without eliminating a shell. This is a Scientific Reasoning and Problem Solving question because you must apply the ''shell removal'' reasoning to compare absolute radius contractions.',
  'easy'
);

-- Q146: Electronegativity Trends
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'Which sequence correctly orders the elements from LOWEST to HIGHEST Pauling electronegativity?',
  '[{"label": "A", "text": "Cs < Na < Si < P < O < F"}, {"label": "B", "text": "F < O < P < Si < Na < Cs"}, {"label": "C", "text": "Na < Cs < Si < P < O < F"}, {"label": "D", "text": "Cs < Na < P < Si < O < F"}]',
  'A',
  'The answer is A because electronegativity increases left-to-right and bottom-to-top; Cs (0.79) < Na (0.93) < Si (1.90) < P (2.19) < O (3.44) < F (3.98). Choice B is the full reverse order. Choice C swaps Na and Cs. Choice D swaps P and Si. This is a Knowledge of Scientific Concepts and Principles question because you must recall both the general trend AND the fine-grained ordering of neighboring elements.',
  'easy'
);

-- Q147: Electron Affinity
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'Group 2 elements (Be, Mg, Ca...) have near-zero or slightly positive electron affinities. Which feature best explains this pattern?',
  '[{"label": "A", "text": "The added electron must enter a higher-energy p orbital because the ns subshell is already full"}, {"label": "B", "text": "Group 2 atoms have exceptionally high effective nuclear charge"}, {"label": "C", "text": "Group 2 elements are already anions in their ground state"}, {"label": "D", "text": "The added electron would break the noble gas configuration"}]',
  'A',
  'The answer is A because an alkaline earth atom has a filled ns2 configuration; adding an electron forces it into a higher-energy np orbital that is poorly stabilized, making EA near zero or slightly positive (endothermic). Choice B is false (group 2 Zeff is modest). Choice C is incorrect. Choice D misapplies the noble gas concept. This is a Knowledge of Scientific Concepts and Principles question because you must recall how filled subshells affect electron affinity.',
  'easy'
);

-- Q148: Atomic and Ionic Radius
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'Across the lanthanide series, the atomic radii contract less dramatically than a simple Zeff argument would predict. Which phenomenon most directly accounts for this ''lanthanide contraction''?',
  '[{"label": "A", "text": "Poor shielding by 4f electrons allows the increasing nuclear charge to still contract the radius steadily"}, {"label": "B", "text": "4f electrons completely shield the outer valence electrons"}, {"label": "C", "text": "Relativistic expansion of s orbitals"}, {"label": "D", "text": "The increase in coordination number across the series"}]',
  'A',
  'The answer is A because 4f orbitals are poor shielders of nuclear charge, so across the series the valence electrons feel a steadily increasing Zeff and the radius contracts more than across a d-block row of similar width; this ''lanthanide contraction'' is what makes post-lanthanide elements (Hf, Ta...) unexpectedly small. Choice B overstates f-shielding. Choice C reverses the relativistic effect. Choice D is unrelated. This is a Knowledge of Scientific Concepts and Principles question because you must recall how f-orbital shielding affects periodic trends.',
  'medium'
);

-- Q149: Electronegativity Trends
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'A student must choose between two diatomics, AB and CD, to maximize bond polarity. AB has delta(EN) = 1.3; CD has delta(EN) = 1.8 but forms a mostly ionic solid rather than a discrete molecule. Which choice best represents the ''most polar COVALENT bond''?',
  '[{"label": "A", "text": "AB, because delta(EN) between ~0.5 and ~1.7 remains in the polar covalent regime"}, {"label": "B", "text": "CD, because higher delta(EN) always means more polar covalent"}, {"label": "C", "text": "Neither, both are fully ionic"}, {"label": "D", "text": "Both equally polar because delta(EN) > 0.4"}]',
  'A',
  'The answer is A because by convention, delta(EN) ~ 1.7 is the approximate boundary where bonds transition from polar covalent to predominantly ionic; CD (1.8) is described as forming an ionic solid, so within the covalent regime AB is the most polar. Choice B ignores the covalent/ionic boundary. Choices C and D misapply the rubric. This is a Scientific Reasoning and Problem Solving question because you must apply a quantitative cutoff to categorize bond character.',
  'medium'
);

-- Q150: Atomic and Ionic Radius
INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty) VALUES (
  'chem_phys',
  'Bonding & Chemical Interactions',
  'Periodic Trends',
  'Which ion is likely LARGER than the neutral atom from which it formed?',
  '[{"label": "A", "text": "Cl from Cl-, where Cl- is larger"}, {"label": "B", "text": "Na from Na+, where Na+ is larger"}, {"label": "C", "text": "Mg from Mg2+, where Mg2+ is larger"}, {"label": "D", "text": "Al from Al3+, where Al3+ is larger"}]',
  'A',
  'The answer is A because anions are always larger than their parent atoms; adding an electron to Cl increases electron-electron repulsion without changing the nuclear charge, expanding the electron cloud. Choices B, C, and D are all cations, which are smaller than their parents (often by losing an entire shell). This is a Knowledge of Scientific Concepts and Principles question because you must recall how radius changes upon gaining or losing electrons.',
  'easy'
);
