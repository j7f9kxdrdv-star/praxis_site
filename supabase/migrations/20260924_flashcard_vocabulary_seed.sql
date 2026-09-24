-- ============================================================
-- Seed the flashcard-derived vocabulary, and map 314 cards
--
-- 61 new objects: 31 General Chemistry CONTENT, 11 REASONING, 16 QUANTITATIVE,
-- 3 bioethics CONTENT under PSYCH_SOC. Then 314 card mappings.
--
-- THE pH DECISION, recorded because it changed the count from 32 to 31. The
-- card "salts of basic anions become more soluble as pH drops, because acid
-- consumes the anion" teaches Le Chatelier applied to a dissolution
-- equilibrium, which is the SAME learning objective as the common ion effect
-- running the other way. It was merged into that concept, now renamed Common
-- Ion and pH Effects on Solubility, and NOT because it had only one card.
-- Salt Hydrolysis & pH of Salt Solutions was considered and rejected: that
-- concept asks what pH a salt GIVES, which is the opposite question.
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- 1. question_concepts stays CONTENT-only
--
-- The concepts table now holds three kinds of object, and this join must keep
-- the meaning it was built with: which CONTENT concept a question tests.
-- Reasoning skill is already recorded separately on questions as
-- cognitive_skill, so letting a REASONING object in here would create a second,
-- conflicting home for the same idea and quietly turn a content join into a
-- generic one. If question-to-reasoning links are wanted later they should be
-- designed, not smuggled in through this table.
-- ────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.question_concepts_content_only()
RETURNS TRIGGER AS $$
DECLARE t TEXT;
BEGIN
  SELECT object_type INTO t FROM public.concepts WHERE id = NEW.concept_id;
  IF t IS DISTINCT FROM 'CONTENT' THEN
    RAISE EXCEPTION
      'question_concepts answers "which CONTENT concept does this question test". Concept % is %. Reasoning skill already lives on questions.cognitive_skill; a question-to-% link needs its own design.',
      NEW.concept_id, t, t;
  END IF;
  RETURN NEW;
END; $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS question_concepts_content_only ON public.question_concepts;
CREATE TRIGGER question_concepts_content_only
  BEFORE INSERT OR UPDATE ON public.question_concepts
  FOR EACH ROW EXECUTE FUNCTION public.question_concepts_content_only();

-- 31 General Chemistry CONTENT concepts.
INSERT INTO public.concepts (slug, canonical_name, description, object_type, concept_level, status, version, split_candidate) VALUES
  ($x$GAS_PRESSURE_AND_MEASUREMENT$x$, $x$Gas Pressure and Its Measurement$x$, $x$Pressure as force per area, its units and conversions, and how barometers and manometers read it.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$GAS_STATE_AND_STANDARD_CONDITIONS$x$, $x$Gas State and Standard Conditions$x$, $x$Absolute zero and the Kelvin requirement, STP, standard molar volume, and what makes a gas ideal.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$IDEAL_GAS_LAW$x$, $x$The Ideal Gas Law$x$, $x$PV = nRT, the gas constant in both unit systems, and the density and molar-mass rearrangements.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$SIMPLE_AND_COMBINED_GAS_LAWS$x$, $x$The Simple and Combined Gas Laws$x$, $x$Boyle, Charles, Gay-Lussac and Avogadro as the ideal gas law with variables held constant, and the combined law.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$PARTIAL_PRESSURE_AND_MOLE_FRACTION$x$, $x$Partial Pressure and Mole Fraction$x$, $x$Dalton's law, the independence of each component, and partial pressure from mole fraction.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$HENRYS_LAW$x$, $x$Henry's Law$x$, $x$Dissolved gas concentration as proportional to the partial pressure above the liquid.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$KINETIC_MOLECULAR_THEORY$x$, $x$Kinetic Molecular Theory$x$, $x$The assumptions behind ideal behaviour, average kinetic energy set by temperature, and root-mean-square speed.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$DIFFUSION_AND_EFFUSION$x$, $x$Diffusion and Effusion$x$, $x$Graham's law and the distinction between spreading through a medium and escaping through an aperture.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$REAL_GAS_DEVIATIONS$x$, $x$Real Gas Deviations$x$, $x$Where and why real gases depart from ideality, and what each van der Waals constant corrects for.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$HEAT_TEMPERATURE_THERMAL_EQUILIBRIUM$x$, $x$Heat, Temperature and Thermal Equilibrium$x$, $x$Heat as energy in transit, temperature as average kinetic energy, and the zeroth law.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$ENTHALPY_AND_REACTION_ENTHALPY$x$, $x$Enthalpy and Reaction Enthalpy$x$, $x$Exothermic and endothermic signs, enthalpy at constant pressure, standard states, and enthalpy of formation.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$CALORIMETRY_AND_HEAT_CAPACITY$x$, $x$Calorimetry and Heat Capacity$x$, $x$q = mcDeltaT, specific versus molar heat capacity, and what constant-pressure and constant-volume calorimeters each measure.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$PHASE_CHANGES_AND_LATENT_HEAT$x$, $x$Phase Changes and Latent Heat$x$, $x$Why temperature holds constant during a phase change, and the heats of fusion and vaporisation.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$HESSS_LAW$x$, $x$Hess's Law$x$, $x$Adding step enthalpies, and the consequences of reversing or scaling a reaction.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$BOND_ENERGIES_AND_REACTION_ENTHALPY$x$, $x$Bond Energies and Reaction Enthalpy$x$, $x$Estimating reaction enthalpy from bonds broken and formed, and why breaking costs and forming releases.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$ENTROPY$x$, $x$Entropy$x$, $x$Entropy as dispersal and microstate count, the second and third laws, and what raises it.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$, $x$Gibbs Free Energy and Spontaneity$x$, $x$DeltaG = DeltaH - TDeltaS, the sign of DeltaG, and the four enthalpy/entropy combinations with their temperature dependence.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$PHASE_DIAGRAMS$x$, $x$Phase Diagrams$x$, $x$Reading a pressure-temperature diagram, the triple point and the critical point.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$SOLUTION_FORMATION_AND_SOLVATION$x$, $x$Solution Formation and Solvation$x$, $x$Solvent and solute, hydration, the energetic steps of dissolving, and why like dissolves like.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$SOLUBILITY_AND_SATURATION$x$, $x$Solubility and Saturation$x$, $x$Saturated, unsaturated and supersaturated states, and how temperature moves solid and gas solubility in opposite directions.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$SOLUBILITY_RULES$x$, $x$Solubility Rules$x$, $x$Which salts dissolve, and the standard exceptions worth memorising.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$CONCENTRATION_UNITS_AND_DILUTION$x$, $x$Concentration Units and Dilution$x$, $x$Molarity, molality, mole fraction, percent and normality, which each is used for, and the dilution equation.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, $x$Solubility Product and Precipitation$x$, $x$Ksp, the ion product, and predicting dissolution or precipitation by comparing them.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$COMMON_ION_AND_PH_EFFECTS$x$, $x$Common Ion and pH Effects on Solubility$x$, $x$Le Chatelier applied to a dissolution equilibrium: a shared ion suppresses solubility, removing an ion by acid or complexation raises it, and selective precipitation exploits the difference.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$COMPLEX_IONS_AND_FORMATION_CONSTANTS$x$, $x$Complex Ions and Formation Constants$x$, $x$Ligands as Lewis bases, coordinate covalent bonding, coordination number, and Kf raising solubility.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$COLLIGATIVE_PROPERTIES$x$, $x$Colligative Properties$x$, $x$Vapour-pressure lowering, boiling elevation, freezing depression, osmotic pressure, and the van't Hoff factor.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$DYNAMIC_EQUILIBRIUM$x$, $x$Dynamic Equilibrium$x$, $x$Reversibility, equal forward and reverse rates, and equilibrium as a free-energy minimum rather than a stop.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$THE_EQUILIBRIUM_CONSTANT$x$, $x$The Equilibrium Constant$x$, $x$The law of mass action, Kc against Kp, what is omitted from the expression, what K depends on, and what its magnitude does and does not tell you.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$REACTION_QUOTIENT$x$, $x$The Reaction Quotient$x$, $x$Q against K as the predictor of which direction a system will move.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$LE_CHATELIERS_PRINCIPLE$x$, $x$Le Chatelier's Principle$x$, $x$Predicting the shift from concentration, pressure, volume and temperature stresses, and why a catalyst shifts nothing.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$KINETIC_VERSUS_THERMODYNAMIC_PRODUCT$x$, $x$Kinetic versus Thermodynamic Product$x$, $x$Which product dominates at low and at high temperature, and why reversibility decides it.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false)
ON CONFLICT (slug) DO NOTHING;

-- Their content taxonomy. All four decks are general chemistry under CHEM_PHYS.
INSERT INTO public.concept_sections (concept_id, section_code, is_primary) VALUES
  ((SELECT id FROM public.concepts WHERE slug=$x$GAS_PRESSURE_AND_MEASUREMENT$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$GAS_STATE_AND_STANDARD_CONDITIONS$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$IDEAL_GAS_LAW$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$SIMPLE_AND_COMBINED_GAS_LAWS$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$PARTIAL_PRESSURE_AND_MOLE_FRACTION$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$HENRYS_LAW$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$KINETIC_MOLECULAR_THEORY$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$DIFFUSION_AND_EFFUSION$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$REAL_GAS_DEVIATIONS$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$HEAT_TEMPERATURE_THERMAL_EQUILIBRIUM$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$ENTHALPY_AND_REACTION_ENTHALPY$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$CALORIMETRY_AND_HEAT_CAPACITY$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$PHASE_CHANGES_AND_LATENT_HEAT$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$HESSS_LAW$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$BOND_ENERGIES_AND_REACTION_ENTHALPY$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$ENTROPY$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$PHASE_DIAGRAMS$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$SOLUTION_FORMATION_AND_SOLVATION$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$SOLUBILITY_AND_SATURATION$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$SOLUBILITY_RULES$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$CONCENTRATION_UNITS_AND_DILUTION$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$COMMON_ION_AND_PH_EFFECTS$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$COMPLEX_IONS_AND_FORMATION_CONSTANTS$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$COLLIGATIVE_PROPERTIES$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$DYNAMIC_EQUILIBRIUM$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$THE_EQUILIBRIUM_CONSTANT$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$REACTION_QUOTIENT$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$LE_CHATELIERS_PRINCIPLE$x$), 'CHEM_PHYS', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$KINETIC_VERSUS_THERMODYNAMIC_PRODUCT$x$), 'CHEM_PHYS', true)
ON CONFLICT DO NOTHING;
INSERT INTO public.concept_disciplines (concept_id, discipline_code, role) VALUES
  ((SELECT id FROM public.concepts WHERE slug=$x$GAS_PRESSURE_AND_MEASUREMENT$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$GAS_STATE_AND_STANDARD_CONDITIONS$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$IDEAL_GAS_LAW$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$SIMPLE_AND_COMBINED_GAS_LAWS$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$PARTIAL_PRESSURE_AND_MOLE_FRACTION$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$HENRYS_LAW$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$KINETIC_MOLECULAR_THEORY$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$DIFFUSION_AND_EFFUSION$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$REAL_GAS_DEVIATIONS$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$HEAT_TEMPERATURE_THERMAL_EQUILIBRIUM$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$ENTHALPY_AND_REACTION_ENTHALPY$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$CALORIMETRY_AND_HEAT_CAPACITY$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$PHASE_CHANGES_AND_LATENT_HEAT$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$HESSS_LAW$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$BOND_ENERGIES_AND_REACTION_ENTHALPY$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$ENTROPY$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$PHASE_DIAGRAMS$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$SOLUTION_FORMATION_AND_SOLVATION$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$SOLUBILITY_AND_SATURATION$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$SOLUBILITY_RULES$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$CONCENTRATION_UNITS_AND_DILUTION$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$COMMON_ION_AND_PH_EFFECTS$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$COMPLEX_IONS_AND_FORMATION_CONSTANTS$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$COLLIGATIVE_PROPERTIES$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$DYNAMIC_EQUILIBRIUM$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$THE_EQUILIBRIUM_CONSTANT$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$REACTION_QUOTIENT$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$LE_CHATELIERS_PRINCIPLE$x$), 'GENERAL_CHEMISTRY', 'PRIMARY'),
  ((SELECT id FROM public.concepts WHERE slug=$x$KINETIC_VERSUS_THERMODYNAMIC_PRODUCT$x$), 'GENERAL_CHEMISTRY', 'PRIMARY')
ON CONFLICT DO NOTHING;

-- 11 REASONING + 16 QUANTITATIVE objects. NO section, discipline or AAMC
-- category: those axes describe disciplinary content, and a trigger refuses them here.
INSERT INTO public.concepts (slug, canonical_name, description, object_type, concept_level, status, version, split_candidate) VALUES
  ($x$RO_STUDY_DESIGN_TYPES$x$, $x$Study Design Types$x$, $x$Distinguishing cohort, case-control, cross-sectional, descriptive and experimental designs, and what each can and cannot establish.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$RO_VARIABLES_AND_CONTROLS$x$, $x$Variables and Controls$x$, $x$Identifying independent and dependent variables, and the role of positive and negative controls.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$RO_RANDOMIZATION_AND_SAMPLING$x$, $x$Randomization and Sampling$x$, $x$Random assignment, random sampling, and the population/sample and parameter/statistic distinctions.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$RO_BLINDING_AND_PLACEBO$x$, $x$Blinding and the Placebo Effect$x$, $x$Single and double blinding, why blinding matters, and the placebo response.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$RO_BIAS$x$, $x$Bias in Research$x$, $x$Systematic error introduced during data collection: selection, detection and observation bias, and how bias differs from random error.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$RO_CONFOUNDING$x$, $x$Confounding$x$, $x$A third variable influencing both exposure and outcome, and how confounding differs from bias.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$RO_CAUSAL_INFERENCE$x$, $x$Causal Inference$x$, $x$Arguing from correlation to causation, and Hill's criteria including temporality and dose-response.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$RO_VALIDITY_AND_RELIABILITY$x$, $x$Validity and Reliability$x$, $x$Internal versus external validity, and accuracy versus precision.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$RO_HYPOTHESIS_FORMATION$x$, $x$Hypothesis Formation$x$, $x$Where a hypothesis comes from, how it is phrased, FINER, and the scientific method.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$RO_SIGNIFICANCE_INTERPRETATION$x$, $x$Statistical versus Clinical Significance$x$, $x$Separating a result unlikely by chance from a change large enough to matter.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$RO_RESEARCH_SETTINGS$x$, $x$Research Settings$x$, $x$Basic science versus applied and clinical settings, and the control each affords.$x$, 'REASONING', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_SIGNIFICANT_FIGURES$x$, $x$Significant Figures$x$, $x$Counting significant digits and carrying them through arithmetic.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_EXPONENT_RULES$x$, $x$Exponent Rules$x$, $x$Zero, negative, fractional exponents and the rules for combining powers.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_LOGARITHM_RULES$x$, $x$Logarithm Rules$x$, $x$Log identities, products, quotients, powers, and common versus natural logs.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_TRIGONOMETRIC_VALUES$x$, $x$Trigonometric Ratios and Values$x$, $x$SOH CAH TOA, inverse functions, and the standard and boundary angles.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_SIMULTANEOUS_EQUATIONS$x$, $x$Solving Simultaneous Equations$x$, $x$Substitution, elimination, and setting equations equal.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_ESTIMATION_AND_NOTATION$x$, $x$Estimation and Scientific Notation$x$, $x$Calculator-free estimation, root shortcuts, and scientific notation.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_UNITS_AND_SI_PREFIXES$x$, $x$Units, SI Prefixes and Scale Conversion$x$, $x$Powers-of-ten prefixes and temperature scale conversion.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_PROPORTIONAL_RELATIONSHIPS$x$, $x$Direct and Inverse Proportion$x$, $x$Recognising which way one quantity moves when another changes.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_CENTRAL_TENDENCY$x$, $x$Measures of Central Tendency$x$, $x$Mean, median and mode, and which summarises a data set best.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_MEASURES_OF_SPREAD$x$, $x$Measures of Spread$x$, $x$Range, standard deviation, interquartile range and Bessel's correction.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_DISTRIBUTION_SHAPES$x$, $x$Distribution Shapes$x$, $x$Normal, standard normal, skewed and bimodal distributions, and the empirical rule.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_OUTLIER_IDENTIFICATION$x$, $x$Outlier Identification$x$, $x$Standard-deviation and IQR rules for flagging outliers, and where outliers come from.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_PROBABILITY_RULES$x$, $x$Probability Rules$x$, $x$Independence, mutual exclusivity, exhaustiveness, and the AND, OR and at-least-one rules.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_DATA_DISPLAY_FORMATS$x$, $x$Data Display Formats$x$, $x$Pie, bar, histogram, line, box plot, and log transformations of axes.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_CORRELATION_COEFFICIENT$x$, $x$Correlation Coefficient$x$, $x$Direction and strength of association, and the range of r.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$QK_HYPOTHESIS_TESTING_TERMS$x$, $x$Hypothesis Testing Terminology$x$, $x$Null and alternative hypotheses, p-value, alpha, decision rule, Type I and II errors, confidence intervals.$x$, 'QUANTITATIVE', 'CONCEPT', 'ACTIVE_SEED', 1, false)
ON CONFLICT (slug) DO NOTHING;

-- 3 bioethics CONTENT concepts. These DO get PSYCH_SOC taxonomy: they are
-- examinable content and must be able to enter memory-versus-application.
INSERT INTO public.concepts (slug, canonical_name, description, object_type, concept_level, status, version, split_candidate) VALUES
  ($x$BIOMEDICAL_ETHICS_PRINCIPLES$x$, $x$Principles of Biomedical Ethics$x$, $x$Beneficence, nonmaleficence, autonomy and justice as the four governing principles of medical and research ethics.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$INFORMED_CONSENT_RESPECT_PERSONS$x$, $x$Informed Consent and Respect for Persons$x$, $x$Honesty, consent, confidentiality, and extra protection for vulnerable participants.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false),
  ($x$CLINICAL_EQUIPOISE$x$, $x$Clinical Equipoise$x$, $x$The genuine uncertainty between arms that makes a head-to-head trial ethical.$x$, 'CONTENT', 'CONCEPT', 'ACTIVE_SEED', 1, false)
ON CONFLICT (slug) DO NOTHING;
INSERT INTO public.concept_sections (concept_id, section_code, is_primary) VALUES
  ((SELECT id FROM public.concepts WHERE slug=$x$BIOMEDICAL_ETHICS_PRINCIPLES$x$), 'PSYCH_SOC', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$INFORMED_CONSENT_RESPECT_PERSONS$x$), 'PSYCH_SOC', true),
  ((SELECT id FROM public.concepts WHERE slug=$x$CLINICAL_EQUIPOISE$x$), 'PSYCH_SOC', true)
ON CONFLICT DO NOTHING;

-- Cross-chapter widening. Both concepts are demonstrated by General Chemistry
-- cards to have scope beyond Bioenergetics, so their relationships are extended
-- rather than the concepts duplicated.
INSERT INTO public.concept_disciplines (concept_id, discipline_code, role) VALUES
 ((SELECT id FROM public.concepts WHERE canonical_name='Thermodynamics: Systems & Free Energy'), 'GENERAL_CHEMISTRY', 'SECONDARY'),
 ((SELECT id FROM public.concepts WHERE canonical_name='Free Energy & Equilibrium'), 'GENERAL_CHEMISTRY', 'SECONDARY')
ON CONFLICT DO NOTHING;
INSERT INTO public.concept_sections (concept_id, section_code, is_primary) VALUES
 ((SELECT id FROM public.concepts WHERE canonical_name='Thermodynamics: Systems & Free Energy'), 'CHEM_PHYS', false),
 ((SELECT id FROM public.concepts WHERE canonical_name='Free Energy & Equilibrium'), 'CHEM_PHYS', false)
ON CONFLICT DO NOTHING;

-- 314 card mappings. Provenance AI_PROPOSED: these came from reading the cards
-- and clustering them, which is interpretation, not a deterministic rule. The
-- vocabulary was approved; 314 individual rows were not reviewed one by one, and
-- the status must not claim they were.
INSERT INTO public.flashcard_concepts (flashcard_id, concept_id, role, confidence, mapping_status, source)
SELECT m.card::uuid, c.id, 'PRIMARY', 0.90, 'AI_PROPOSED', 'AI_PROPOSED'
FROM (VALUES
  ($x$95a22f39-9aab-4676-aca4-180eace9fd1a$x$, $x$GAS_PRESSURE_AND_MEASUREMENT$x$, false),
  ($x$a2ceb75e-e280-48bd-9214-7e60dafd77e2$x$, $x$GAS_PRESSURE_AND_MEASUREMENT$x$, false),
  ($x$c0d30549-2321-42d9-9aeb-cb865bfec9da$x$, $x$GAS_PRESSURE_AND_MEASUREMENT$x$, false),
  ($x$46b96c60-f669-4b46-89f3-658fc45f17ef$x$, $x$GAS_PRESSURE_AND_MEASUREMENT$x$, false),
  ($x$3c1a4bba-cafc-421d-9329-696cbcc7ae68$x$, $x$GAS_PRESSURE_AND_MEASUREMENT$x$, false),
  ($x$f7a309bf-3cb4-4cd6-9622-ba30cfac0439$x$, $x$GAS_PRESSURE_AND_MEASUREMENT$x$, false),
  ($x$8a149335-049c-4533-a3b3-3b882a3a3a82$x$, $x$GAS_STATE_AND_STANDARD_CONDITIONS$x$, false),
  ($x$c21e18e2-8691-480b-81e4-39e6a029e10b$x$, $x$GAS_STATE_AND_STANDARD_CONDITIONS$x$, false),
  ($x$c98d7e55-c4e9-4242-92de-e5bb0af8b31e$x$, $x$GAS_STATE_AND_STANDARD_CONDITIONS$x$, false),
  ($x$4e919daa-0068-4e2a-877a-1e88ed10d1e3$x$, $x$GAS_STATE_AND_STANDARD_CONDITIONS$x$, false),
  ($x$43b0c064-726e-4679-b8d2-e9fdf4e5b569$x$, $x$GAS_STATE_AND_STANDARD_CONDITIONS$x$, false),
  ($x$4eff0dc5-42e0-4b33-8d27-b8467dab2779$x$, $x$GAS_STATE_AND_STANDARD_CONDITIONS$x$, false),
  ($x$c35fdef7-1166-4fbf-afca-9cbbd884e577$x$, $x$IDEAL_GAS_LAW$x$, false),
  ($x$9b8a51fa-b07f-44c6-b98c-eedb5d196e3f$x$, $x$IDEAL_GAS_LAW$x$, false),
  ($x$03f05300-50ea-424e-aabc-ad715225f578$x$, $x$IDEAL_GAS_LAW$x$, false),
  ($x$07f72386-9b9a-46e6-b641-dd36c31b1db1$x$, $x$IDEAL_GAS_LAW$x$, false),
  ($x$6c4bf0e0-f10a-4e6a-840b-e3ed04c683c5$x$, $x$IDEAL_GAS_LAW$x$, false),
  ($x$daad8452-d806-4d06-bc17-73e5dcf303a3$x$, $x$IDEAL_GAS_LAW$x$, false),
  ($x$b3839a21-4da8-423d-a179-85f64386042e$x$, $x$IDEAL_GAS_LAW$x$, false),
  ($x$de8936a0-f5ba-4bb8-9ed9-a5c5c354d4ad$x$, $x$SIMPLE_AND_COMBINED_GAS_LAWS$x$, false),
  ($x$b5391286-4118-4d19-aaab-9f5cd6ccf86f$x$, $x$SIMPLE_AND_COMBINED_GAS_LAWS$x$, false),
  ($x$7b4eee74-90dd-4b95-b51a-6ed1f99feefd$x$, $x$SIMPLE_AND_COMBINED_GAS_LAWS$x$, false),
  ($x$30c83d26-a5f4-49a7-843a-109977e5851f$x$, $x$SIMPLE_AND_COMBINED_GAS_LAWS$x$, false),
  ($x$591ddd59-9f50-474e-8bf0-307dd0a04868$x$, $x$SIMPLE_AND_COMBINED_GAS_LAWS$x$, false),
  ($x$66f1e036-d9c6-4999-a5f5-0f1f79ea0a5f$x$, $x$SIMPLE_AND_COMBINED_GAS_LAWS$x$, false),
  ($x$994c3519-9a96-47c3-b72f-bb96d8e9b87c$x$, $x$SIMPLE_AND_COMBINED_GAS_LAWS$x$, false),
  ($x$c41aea57-b86d-4668-8378-941b1ad42112$x$, $x$PARTIAL_PRESSURE_AND_MOLE_FRACTION$x$, false),
  ($x$c50e33f7-1532-4969-81b4-7bad14de7e1b$x$, $x$PARTIAL_PRESSURE_AND_MOLE_FRACTION$x$, false),
  ($x$3234e3e4-68dd-489c-9e85-03c1d71188ec$x$, $x$PARTIAL_PRESSURE_AND_MOLE_FRACTION$x$, false),
  ($x$5e91be3a-05a6-41f4-828c-c3c1bc221ad4$x$, $x$PARTIAL_PRESSURE_AND_MOLE_FRACTION$x$, false),
  ($x$31d8f65e-5bbc-484d-91bf-f944cccf43fc$x$, $x$PARTIAL_PRESSURE_AND_MOLE_FRACTION$x$, false),
  ($x$efaab12b-07e2-4221-8653-f4e3ee3d1f85$x$, $x$HENRYS_LAW$x$, false),
  ($x$05185319-a347-4ae3-a1da-9c8603e2b6e0$x$, $x$HENRYS_LAW$x$, false),
  ($x$e8b63a11-f2d4-4ccc-887c-d45e44bf6ab4$x$, $x$KINETIC_MOLECULAR_THEORY$x$, false),
  ($x$22c4e4bf-d915-4a08-8215-2e432f827b5e$x$, $x$KINETIC_MOLECULAR_THEORY$x$, false),
  ($x$9c225509-6f23-442a-9ff6-f1302d07cade$x$, $x$KINETIC_MOLECULAR_THEORY$x$, false),
  ($x$c6bba159-b5df-43bd-9a68-e47f800a869b$x$, $x$KINETIC_MOLECULAR_THEORY$x$, false),
  ($x$53c13bae-c081-4067-ac1f-affdb1864515$x$, $x$KINETIC_MOLECULAR_THEORY$x$, false),
  ($x$2f9e2ea1-f859-42fd-9105-de864cb4d15d$x$, $x$KINETIC_MOLECULAR_THEORY$x$, false),
  ($x$c08f549b-ea2f-4d62-a453-e7b57fed4534$x$, $x$KINETIC_MOLECULAR_THEORY$x$, false),
  ($x$348844b6-3b8d-452a-91f3-53ca5b2dc360$x$, $x$KINETIC_MOLECULAR_THEORY$x$, false),
  ($x$e9afc861-b70e-4484-89c7-15b7857aec98$x$, $x$KINETIC_MOLECULAR_THEORY$x$, false),
  ($x$96f34677-89d7-49b7-a457-06eb80f6be5b$x$, $x$DIFFUSION_AND_EFFUSION$x$, false),
  ($x$b6fc8f87-d996-430b-9b25-5470b97ad913$x$, $x$DIFFUSION_AND_EFFUSION$x$, false),
  ($x$2a49a7b2-88ee-4d00-afcd-a8be55954d4a$x$, $x$REAL_GAS_DEVIATIONS$x$, false),
  ($x$423acc9b-2bc8-49af-a59f-38459ceca5fc$x$, $x$REAL_GAS_DEVIATIONS$x$, false),
  ($x$d7e729d0-c32b-4dba-89fb-e13cde50e100$x$, $x$REAL_GAS_DEVIATIONS$x$, false),
  ($x$9c7f1e4c-b5ae-450e-bce3-37386388af00$x$, $x$REAL_GAS_DEVIATIONS$x$, false),
  ($x$5a7cc538-0bc4-4472-a46f-bc6d1224d4f7$x$, $x$REAL_GAS_DEVIATIONS$x$, false),
  ($x$1e944908-0cd5-4cbd-a47e-d954def3a9db$x$, $x$REAL_GAS_DEVIATIONS$x$, false),
  ($x$f3a309c6-742a-473f-855d-1d49ed90b31e$x$, $x$Thermodynamics: Systems & Free Energy$x$, true),
  ($x$1ad927c7-efd0-441b-92a6-a81514388f0a$x$, $x$Thermodynamics: Systems & Free Energy$x$, true),
  ($x$d892a322-0bf5-47fa-a028-54106939f696$x$, $x$Thermodynamics: Systems & Free Energy$x$, true),
  ($x$1489bf68-ea92-4d11-bc36-0ada9ab74621$x$, $x$Thermodynamics: Systems & Free Energy$x$, true),
  ($x$cfe2df02-52c8-42b3-8c73-ee34064ab2b7$x$, $x$Thermodynamics: Systems & Free Energy$x$, true),
  ($x$29e29d91-2810-4806-98c7-66d2e9ef070d$x$, $x$Thermodynamics: Systems & Free Energy$x$, true),
  ($x$cbd50107-30e1-4ac2-80a9-e86ad61e1715$x$, $x$Thermodynamics: Systems & Free Energy$x$, true),
  ($x$62de6dd3-2f28-4a60-b603-225a5b091c8f$x$, $x$Thermodynamics: Systems & Free Energy$x$, true),
  ($x$1c0a8d1f-729a-41f1-b6ce-0494f86c1bc2$x$, $x$HEAT_TEMPERATURE_THERMAL_EQUILIBRIUM$x$, false),
  ($x$b3d11d3f-8eee-48f7-b0d2-d9f8ad2b44b9$x$, $x$HEAT_TEMPERATURE_THERMAL_EQUILIBRIUM$x$, false),
  ($x$50513ed9-ee8b-401c-bf33-3ea86a5397b0$x$, $x$HEAT_TEMPERATURE_THERMAL_EQUILIBRIUM$x$, false),
  ($x$3d436cce-7099-4947-b896-d0e03e5e9a72$x$, $x$ENTHALPY_AND_REACTION_ENTHALPY$x$, false),
  ($x$2fcdeb91-cbc0-4557-88f7-0e21d96ec219$x$, $x$ENTHALPY_AND_REACTION_ENTHALPY$x$, false),
  ($x$fa9a76a5-9744-4bf9-8f0f-91c05c8795e0$x$, $x$ENTHALPY_AND_REACTION_ENTHALPY$x$, false),
  ($x$c768dbd2-411a-46d9-91f1-40dedc81c9f0$x$, $x$ENTHALPY_AND_REACTION_ENTHALPY$x$, false),
  ($x$4c974e86-72bd-4584-930d-ed2544871cb1$x$, $x$ENTHALPY_AND_REACTION_ENTHALPY$x$, false),
  ($x$13ce5cfe-bbb7-42da-82cc-cf21e65ddb0f$x$, $x$ENTHALPY_AND_REACTION_ENTHALPY$x$, false),
  ($x$8f41dcf6-01bb-46ec-a833-91ca5d834510$x$, $x$ENTHALPY_AND_REACTION_ENTHALPY$x$, false),
  ($x$f699dc45-9d4b-4f96-9f43-c23478e4b426$x$, $x$CALORIMETRY_AND_HEAT_CAPACITY$x$, false),
  ($x$d8171b84-dd36-43bb-9ccc-95f9d3d6e47d$x$, $x$CALORIMETRY_AND_HEAT_CAPACITY$x$, false),
  ($x$661fe65e-7978-4158-90a7-abc686651246$x$, $x$CALORIMETRY_AND_HEAT_CAPACITY$x$, false),
  ($x$5757cbd1-4823-441b-bbfa-2caf6d33c711$x$, $x$CALORIMETRY_AND_HEAT_CAPACITY$x$, false),
  ($x$f230f6cd-7680-451c-bfd4-352170490d7f$x$, $x$CALORIMETRY_AND_HEAT_CAPACITY$x$, false),
  ($x$7bcd39b1-a76b-4a7b-86ec-0eb2540fc60a$x$, $x$CALORIMETRY_AND_HEAT_CAPACITY$x$, false),
  ($x$e988b54e-b9df-401e-8e91-f04030b9c310$x$, $x$PHASE_CHANGES_AND_LATENT_HEAT$x$, false),
  ($x$f547be51-2737-4cf6-89b9-ed08ba920e13$x$, $x$PHASE_CHANGES_AND_LATENT_HEAT$x$, false),
  ($x$9f9c2095-83e8-439a-8f1e-bf2b94d76791$x$, $x$PHASE_CHANGES_AND_LATENT_HEAT$x$, false),
  ($x$62c1701c-5e16-41d5-b5d9-7532ab140725$x$, $x$HESSS_LAW$x$, false),
  ($x$8221c766-e4e2-4cba-ac7f-aaeca85af647$x$, $x$HESSS_LAW$x$, false),
  ($x$b22deb70-9490-45b0-80c3-7beee8206883$x$, $x$HESSS_LAW$x$, false),
  ($x$890f78cf-3700-4ee8-a543-487a355154b8$x$, $x$HESSS_LAW$x$, false),
  ($x$19923b65-76ac-456b-9119-36338cb8217e$x$, $x$BOND_ENERGIES_AND_REACTION_ENTHALPY$x$, false),
  ($x$305b9063-7a18-4d97-a409-ef0e09cd36c9$x$, $x$BOND_ENERGIES_AND_REACTION_ENTHALPY$x$, false),
  ($x$6b2650e5-c213-4e15-9955-5fe65d7afc1f$x$, $x$BOND_ENERGIES_AND_REACTION_ENTHALPY$x$, false),
  ($x$d18eb5c6-6802-4361-818e-5c6a47bbc6f2$x$, $x$BOND_ENERGIES_AND_REACTION_ENTHALPY$x$, false),
  ($x$5452c541-c875-4ecf-b4bf-a759b50eb798$x$, $x$ENTROPY$x$, false),
  ($x$b55f1ec0-a7a8-4cc7-81c4-df9ae3d188d8$x$, $x$ENTROPY$x$, false),
  ($x$12914fc1-f9e8-4d66-8b27-d5c8130cae5c$x$, $x$ENTROPY$x$, false),
  ($x$9573afa4-d37d-4667-b80a-ca81fa111423$x$, $x$ENTROPY$x$, false),
  ($x$2be73e15-5fd4-40bc-8730-8dfa15af2552$x$, $x$ENTROPY$x$, false),
  ($x$fccf0780-9a72-42e9-9a7f-1cfcc9bdd902$x$, $x$ENTROPY$x$, false),
  ($x$b8e69198-9d21-4a36-a1d6-e15c4a8b3a13$x$, $x$ENTROPY$x$, false),
  ($x$1a48c29a-7cf5-42df-8ff8-c74655ef43f0$x$, $x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$, false),
  ($x$407c48f0-78d5-4ad6-afb3-8590350d8602$x$, $x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$, false),
  ($x$19e07aab-4d68-4d4e-869f-bcdf29a156c5$x$, $x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$, false),
  ($x$59711ad4-84bf-4fe2-9842-88113b99f54c$x$, $x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$, false),
  ($x$d23997d3-60b7-49e2-b0b8-52fa7bccaa17$x$, $x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$, false),
  ($x$aa41529e-9365-42b0-82a2-77ccce3473a8$x$, $x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$, false),
  ($x$3c2022b0-126b-4634-973a-5761cdb3607e$x$, $x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$, false),
  ($x$faeac545-7ba8-4fee-8421-6cbb4b6a849f$x$, $x$GIBBS_FREE_ENERGY_AND_SPONTANEITY$x$, false),
  ($x$955e577c-08ac-4aa2-a6c3-1e3b65f4eae8$x$, $x$PHASE_DIAGRAMS$x$, false),
  ($x$284800cf-f147-446c-95f0-222f3d35af3f$x$, $x$PHASE_DIAGRAMS$x$, false),
  ($x$29df86dd-c8fa-4285-8e24-d085ccbe1f75$x$, $x$SOLUTION_FORMATION_AND_SOLVATION$x$, false),
  ($x$ef90ea77-85c3-4085-a49a-276dbd3f68b2$x$, $x$SOLUTION_FORMATION_AND_SOLVATION$x$, false),
  ($x$0eb0aa52-4d64-4d25-92c9-596fbe82d2cb$x$, $x$SOLUTION_FORMATION_AND_SOLVATION$x$, false),
  ($x$1df3fd71-3d86-4f23-a8fb-c41ef9111ec8$x$, $x$SOLUTION_FORMATION_AND_SOLVATION$x$, false),
  ($x$f6236a6c-e2b3-4214-8055-8446d5a49861$x$, $x$SOLUTION_FORMATION_AND_SOLVATION$x$, false),
  ($x$fb781708-2b60-4021-a842-2b69925f43fb$x$, $x$SOLUTION_FORMATION_AND_SOLVATION$x$, false),
  ($x$5b12f6aa-35c7-48f9-a5ea-5fa40c5a3df2$x$, $x$SOLUTION_FORMATION_AND_SOLVATION$x$, false),
  ($x$afe1be12-946f-463c-824d-a5890bceed32$x$, $x$SOLUTION_FORMATION_AND_SOLVATION$x$, false),
  ($x$d340be7a-1b74-4b12-ae2c-b6f2683aea76$x$, $x$SOLUBILITY_AND_SATURATION$x$, false),
  ($x$d1a8e894-2d04-4e74-b513-94945db83d24$x$, $x$SOLUBILITY_AND_SATURATION$x$, false),
  ($x$f78dd14f-c83d-4b49-9d23-f8dee24953ff$x$, $x$SOLUBILITY_AND_SATURATION$x$, false),
  ($x$43b0fffd-bf82-4549-85df-dd40895e8e08$x$, $x$SOLUBILITY_AND_SATURATION$x$, false),
  ($x$d3305f73-5236-42d3-8ae4-5a4da6b280ab$x$, $x$SOLUBILITY_AND_SATURATION$x$, false),
  ($x$ca35e23a-c3cc-42c8-90e2-88da7a6d3440$x$, $x$SOLUBILITY_AND_SATURATION$x$, false),
  ($x$a42eecc2-be85-4230-976e-f124cc0ac1ea$x$, $x$SOLUBILITY_AND_SATURATION$x$, false),
  ($x$2867e4d9-f686-4a29-b9d4-9fbb67aac85c$x$, $x$SOLUBILITY_RULES$x$, false),
  ($x$db7222b2-996f-4a3d-b66c-27b44e394c3f$x$, $x$SOLUBILITY_RULES$x$, false),
  ($x$50334b54-8e73-4d85-ac75-7512aece4591$x$, $x$SOLUBILITY_RULES$x$, false),
  ($x$28895e40-556f-46e7-a378-df0f5b1ae01d$x$, $x$SOLUBILITY_RULES$x$, false),
  ($x$04f3265d-0b8c-43d9-910e-d153ebc6d827$x$, $x$SOLUBILITY_RULES$x$, false),
  ($x$8a4ef173-be13-4012-91d8-760a2be87a9a$x$, $x$SOLUBILITY_RULES$x$, false),
  ($x$26cc0887-8f36-4a94-8a13-7240e89c122c$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$a175bdfa-e34f-48b4-b8a3-337de12a4e84$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$47f4f12b-e4fa-4c8c-9578-82eda675585c$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$a4254631-f2af-4347-97ca-13ba3f0fcf13$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$f7a5b9b3-a87c-4b08-8778-1e3cc2b687d0$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$cae523c9-d85d-4191-be09-353a73f668ce$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$22bf5b39-d4ca-42c9-8349-0c7875b3b526$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$2c27065e-2d34-48ab-92d9-90b95bb07248$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$a42cea69-8970-4e88-a1ce-3268de0018d4$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$632800d9-fea7-41d4-84ef-95b3baa7e093$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$3980df93-3165-4b1f-aae1-2b580a0fba8d$x$, $x$CONCENTRATION_UNITS_AND_DILUTION$x$, false),
  ($x$8170bd0d-1a14-444f-a424-f7d5c703edb7$x$, $x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, false),
  ($x$69f3aa92-991d-4994-9f4e-3d2f9cdbba1d$x$, $x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, false),
  ($x$bbd360e7-3184-4973-9dcd-a0552226e9ef$x$, $x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, false),
  ($x$06eeca27-9251-45ec-9a75-0d0a0e006558$x$, $x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, false),
  ($x$c5707c55-9d00-4dc5-98bc-fd58ae6e4e45$x$, $x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, false),
  ($x$d99ced19-83e7-422c-bcf8-e814e4edd813$x$, $x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, false),
  ($x$e4f3c0b7-05ae-4a14-a269-523f9a026204$x$, $x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, false),
  ($x$02596a50-d92e-4b1f-8a4c-4eb7add024af$x$, $x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, false),
  ($x$f3729e32-b88d-4ee0-a418-07a030f73b1e$x$, $x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, false),
  ($x$10168503-d77e-45d0-bfab-6e3725384613$x$, $x$SOLUBILITY_PRODUCT_AND_PRECIPITATION$x$, false),
  ($x$58257cd6-9d82-40d2-9afe-16eeac0b340d$x$, $x$COMMON_ION_AND_PH_EFFECTS$x$, false),
  ($x$f446a8e0-d4c6-424b-b198-ac09ed16bc15$x$, $x$COMMON_ION_AND_PH_EFFECTS$x$, false),
  ($x$2a197852-a9a7-4750-9f20-0369da262012$x$, $x$COMMON_ION_AND_PH_EFFECTS$x$, false),
  ($x$aa3a01e2-c75e-4270-9b69-d9914204782b$x$, $x$COMMON_ION_AND_PH_EFFECTS$x$, false),
  ($x$c044cb9b-4e65-494b-bd99-6664161fb735$x$, $x$COMMON_ION_AND_PH_EFFECTS$x$, false),
  ($x$293008c1-df45-428c-becb-60b4da900bae$x$, $x$COMPLEX_IONS_AND_FORMATION_CONSTANTS$x$, false),
  ($x$697e7f56-82bb-4cea-9ab7-5f99e18cac9c$x$, $x$COMPLEX_IONS_AND_FORMATION_CONSTANTS$x$, false),
  ($x$039e3d7b-0f4c-4e59-a0e4-258592fb64f5$x$, $x$COMPLEX_IONS_AND_FORMATION_CONSTANTS$x$, false),
  ($x$730db145-de6d-4ac8-a749-d47790d98d7d$x$, $x$COMPLEX_IONS_AND_FORMATION_CONSTANTS$x$, false),
  ($x$b7964636-0c2d-4e9f-967b-da83508617d9$x$, $x$COMPLEX_IONS_AND_FORMATION_CONSTANTS$x$, false),
  ($x$480dfac0-ec75-4ea5-ad60-2f3dbc5c3e01$x$, $x$COMPLEX_IONS_AND_FORMATION_CONSTANTS$x$, false),
  ($x$32fc5761-3716-41b5-b047-a06bbe60ab88$x$, $x$COMPLEX_IONS_AND_FORMATION_CONSTANTS$x$, false),
  ($x$200b7ea1-fee1-4b27-ba01-412072b1e802$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$bb25af02-ac5f-4dd3-9e9b-9db24c897dfc$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$3b8215ab-3df9-4867-9652-41dd5bd61291$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$c5e3c037-785e-4368-a4b5-e637a9808908$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$5a07dafc-2c92-46c3-9f4a-f5b8620c99a8$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$8144cda1-9cf7-4145-a771-bffedc675b63$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$c3162e2a-38ca-4a7c-a321-a214ea612e63$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$bbcf22e5-402d-4e5e-998b-098af728f291$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$7b6b1611-b72e-43ec-9a2b-d6ddeae23d15$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$04837e13-ab33-41c4-a8f3-4cb245a970be$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$b35a5520-3b23-461c-8002-d7038657292c$x$, $x$COLLIGATIVE_PROPERTIES$x$, false),
  ($x$76fa89f4-8e2f-40c5-836c-ca816257202d$x$, $x$DYNAMIC_EQUILIBRIUM$x$, false),
  ($x$c0956405-7775-414c-b4b8-ffc377a537ad$x$, $x$DYNAMIC_EQUILIBRIUM$x$, false),
  ($x$d9c39aeb-61f3-4114-82a7-daf0de162449$x$, $x$DYNAMIC_EQUILIBRIUM$x$, false),
  ($x$91a0dbb1-3cb2-4fe8-9c4d-da224e2fe6b5$x$, $x$DYNAMIC_EQUILIBRIUM$x$, false),
  ($x$95e81b45-3ad3-46ba-a97c-d45f70d5ad62$x$, $x$THE_EQUILIBRIUM_CONSTANT$x$, false),
  ($x$ef054ebc-0238-414b-a34e-ed33d1fad255$x$, $x$THE_EQUILIBRIUM_CONSTANT$x$, false),
  ($x$94c521d8-a631-4bb9-afb5-723aad260a8d$x$, $x$THE_EQUILIBRIUM_CONSTANT$x$, false),
  ($x$3e29a66c-12e3-489b-90a9-0318bc14bc06$x$, $x$THE_EQUILIBRIUM_CONSTANT$x$, false),
  ($x$96390955-448d-4a4b-b300-d8405d836498$x$, $x$THE_EQUILIBRIUM_CONSTANT$x$, false),
  ($x$b5e743ab-ee81-4c20-aeda-fffa9cc0a4fa$x$, $x$THE_EQUILIBRIUM_CONSTANT$x$, false),
  ($x$16bcfdfd-2e4f-46cf-a189-87eee625e05e$x$, $x$THE_EQUILIBRIUM_CONSTANT$x$, false),
  ($x$8855771a-e92a-4147-a602-f9f91d1bd1ed$x$, $x$THE_EQUILIBRIUM_CONSTANT$x$, false),
  ($x$44fe8095-6e2a-4d2f-a3e6-ddc2b164f55f$x$, $x$THE_EQUILIBRIUM_CONSTANT$x$, false),
  ($x$eb071e3c-ecff-4e9e-8f61-d7c2cb0fe3b6$x$, $x$Free Energy & Equilibrium$x$, true),
  ($x$e4fb87f3-844d-41af-a056-cd0da50c5d2a$x$, $x$REACTION_QUOTIENT$x$, false),
  ($x$a3f9b700-9a06-4244-a469-a161faa9b4f5$x$, $x$REACTION_QUOTIENT$x$, false),
  ($x$a860060a-f4bf-4a7d-a1e6-5cd9cb89b970$x$, $x$REACTION_QUOTIENT$x$, false),
  ($x$e8d2bf30-5ee4-444a-8795-a7bd23f2978e$x$, $x$REACTION_QUOTIENT$x$, false),
  ($x$bdb826bb-9955-489e-b3c3-8febb6b3b77e$x$, $x$LE_CHATELIERS_PRINCIPLE$x$, false),
  ($x$a40381d0-252e-46e4-90b4-6fcf50f273fd$x$, $x$LE_CHATELIERS_PRINCIPLE$x$, false),
  ($x$75467289-565f-476e-bc2a-eca04f3119d9$x$, $x$LE_CHATELIERS_PRINCIPLE$x$, false),
  ($x$1113770c-e17e-49df-8e63-15519fef4723$x$, $x$LE_CHATELIERS_PRINCIPLE$x$, false),
  ($x$4eb7e4ec-f2ed-4ea8-8d46-4f43e3dc4208$x$, $x$LE_CHATELIERS_PRINCIPLE$x$, false),
  ($x$5a2839a3-141a-47a7-8081-23327eb2ce7a$x$, $x$LE_CHATELIERS_PRINCIPLE$x$, false),
  ($x$e3737ae7-b0da-4b65-8079-b7ab5f2b18c6$x$, $x$LE_CHATELIERS_PRINCIPLE$x$, false),
  ($x$082a6ab9-b3c2-4a5d-bcde-2348274b9344$x$, $x$KINETIC_VERSUS_THERMODYNAMIC_PRODUCT$x$, false),
  ($x$33251fc5-fc58-4ba6-be73-1698fc4c895a$x$, $x$KINETIC_VERSUS_THERMODYNAMIC_PRODUCT$x$, false),
  ($x$fdff2df5-194f-48db-938d-3d8828aa5274$x$, $x$KINETIC_VERSUS_THERMODYNAMIC_PRODUCT$x$, false),
  ($x$a8949dfa-6bcf-4136-8ef2-8cf2698140ce$x$, $x$RO_HYPOTHESIS_FORMATION$x$, false),
  ($x$706e255d-2de0-426a-81c9-8c4520b00ac2$x$, $x$RO_HYPOTHESIS_FORMATION$x$, false),
  ($x$ffd317c8-9c47-46e5-b613-52141b52fe0c$x$, $x$RO_STUDY_DESIGN_TYPES$x$, false),
  ($x$34e6ce45-95bf-40e3-93b9-6d608e3101f2$x$, $x$RO_HYPOTHESIS_FORMATION$x$, false),
  ($x$ef3e2e63-820d-47e4-bb1f-c0002f1a3ab8$x$, $x$RO_RESEARCH_SETTINGS$x$, false),
  ($x$8c7ae210-7053-43fe-ba14-50284ceabeaa$x$, $x$RO_VARIABLES_AND_CONTROLS$x$, false),
  ($x$3c79921f-63d0-456c-998f-69c703a7340f$x$, $x$RO_VARIABLES_AND_CONTROLS$x$, false),
  ($x$e8058a06-6b05-4367-ba4e-f91616d35ac4$x$, $x$RO_BLINDING_AND_PLACEBO$x$, false),
  ($x$7fe2909f-a955-44c6-ba24-395373fd3004$x$, $x$RO_VALIDITY_AND_RELIABILITY$x$, false),
  ($x$5157ceb1-d2c9-4d57-a5fd-60ea10a9658a$x$, $x$RO_BIAS$x$, false),
  ($x$1470bca1-6740-41f6-9631-76182e00cacc$x$, $x$RO_STUDY_DESIGN_TYPES$x$, false),
  ($x$7c65003a-51cd-4cc2-b9cd-8a116c815389$x$, $x$RO_RANDOMIZATION_AND_SAMPLING$x$, false),
  ($x$158b3211-fc85-4bc1-82a8-68478a8a7465$x$, $x$RO_STUDY_DESIGN_TYPES$x$, false),
  ($x$a3930176-a450-4196-b433-5e9a4a451356$x$, $x$RO_BLINDING_AND_PLACEBO$x$, false),
  ($x$285b9d91-a5c0-42b5-98b6-096b7afcaaaf$x$, $x$RO_STUDY_DESIGN_TYPES$x$, false),
  ($x$f4bb2b24-8a1e-4298-88ca-7735c7e6e1db$x$, $x$RO_STUDY_DESIGN_TYPES$x$, false),
  ($x$aa9e00fb-1155-4dac-a456-cb4977ea143c$x$, $x$RO_STUDY_DESIGN_TYPES$x$, false),
  ($x$d7620242-1923-4dae-b242-1a032debaa76$x$, $x$RO_CAUSAL_INFERENCE$x$, false),
  ($x$ad88f37c-5eca-4ee0-844e-7521cab8f445$x$, $x$RO_CAUSAL_INFERENCE$x$, false),
  ($x$80d64a04-c63c-4520-a0ea-0282e86e412e$x$, $x$RO_CAUSAL_INFERENCE$x$, false),
  ($x$baf750e9-1d14-47ab-a812-4e86109adec0$x$, $x$RO_BIAS$x$, false),
  ($x$fcb502d7-4848-4170-8d00-9fb8bed47209$x$, $x$RO_CONFOUNDING$x$, false),
  ($x$dc04d19d-bd54-4aee-b6c0-6ccb68b7168d$x$, $x$RO_BIAS$x$, false),
  ($x$45e24d03-e409-42e9-bbac-22963798f226$x$, $x$RO_BIAS$x$, false),
  ($x$49ccbf97-44ce-444e-8282-b22a0d282c2b$x$, $x$RO_BIAS$x$, false),
  ($x$acb14c87-c46f-4460-a672-624cf85db5c5$x$, $x$RO_CONFOUNDING$x$, false),
  ($x$6b995905-481e-47ba-bed9-c091576bb069$x$, $x$BIOMEDICAL_ETHICS_PRINCIPLES$x$, false),
  ($x$5ca05b8d-554f-4ad6-adde-83ec26b5553e$x$, $x$BIOMEDICAL_ETHICS_PRINCIPLES$x$, false),
  ($x$e2838acc-6f9d-418b-9288-aaefecd6a71f$x$, $x$BIOMEDICAL_ETHICS_PRINCIPLES$x$, false),
  ($x$3fc5c06b-4954-4f00-99f2-036c61482d1d$x$, $x$BIOMEDICAL_ETHICS_PRINCIPLES$x$, false),
  ($x$97906082-bead-4b8a-8143-7db614303e0f$x$, $x$BIOMEDICAL_ETHICS_PRINCIPLES$x$, false),
  ($x$cdb42d22-a997-4910-8c51-681e8f40028f$x$, $x$INFORMED_CONSENT_RESPECT_PERSONS$x$, false),
  ($x$8e31f6c4-edb1-4e73-94b7-181be514b89c$x$, $x$CLINICAL_EQUIPOISE$x$, false),
  ($x$ff460f88-4793-4e67-a78a-db492fccce92$x$, $x$RO_RANDOMIZATION_AND_SAMPLING$x$, false),
  ($x$9d85c941-a924-441b-b1bd-0348fb0cd248$x$, $x$RO_RANDOMIZATION_AND_SAMPLING$x$, false),
  ($x$2d93a833-96cb-4002-a69a-dc05fe9df9a4$x$, $x$RO_RANDOMIZATION_AND_SAMPLING$x$, false),
  ($x$da105e06-c7b8-4c36-a852-79ac1bc945f5$x$, $x$RO_VALIDITY_AND_RELIABILITY$x$, false),
  ($x$a6b21984-7193-4778-ba73-b2380b2257f6$x$, $x$RO_SIGNIFICANCE_INTERPRETATION$x$, false),
  ($x$b7eb67c4-8d20-4782-a57b-845d276aad84$x$, $x$RO_HYPOTHESIS_FORMATION$x$, false),
  ($x$51e55050-06de-44c3-bcf0-0b4659013d5c$x$, $x$RO_STUDY_DESIGN_TYPES$x$, false),
  ($x$76459915-278a-422a-b22f-22cafd46ae3d$x$, $x$QK_CENTRAL_TENDENCY$x$, false),
  ($x$ec832784-d917-469e-8730-30a2a12bc2d9$x$, $x$QK_CENTRAL_TENDENCY$x$, false),
  ($x$1f4d6c90-89a5-4e71-a637-88f0652c4c49$x$, $x$QK_CENTRAL_TENDENCY$x$, false),
  ($x$36f98d9d-a2bf-488b-ad77-836158190ac2$x$, $x$QK_CENTRAL_TENDENCY$x$, false),
  ($x$e31fb8cc-d3e3-4496-8b2e-3dd2c24987f1$x$, $x$QK_CENTRAL_TENDENCY$x$, false),
  ($x$2c2ccff2-ca8c-4aa1-93dd-ac13332981d4$x$, $x$QK_DISTRIBUTION_SHAPES$x$, false),
  ($x$3cd67fb7-2515-49d3-8fe3-d2d84e4ae751$x$, $x$QK_DISTRIBUTION_SHAPES$x$, false),
  ($x$e3128b81-4b9f-4c0f-8216-7e9dfe832bc7$x$, $x$QK_DISTRIBUTION_SHAPES$x$, false),
  ($x$d2c5a96b-286c-43a7-8b82-d912bd30ae00$x$, $x$QK_DISTRIBUTION_SHAPES$x$, false),
  ($x$75f7a84c-5d28-493b-b221-3088fef23866$x$, $x$QK_DISTRIBUTION_SHAPES$x$, false),
  ($x$98d7a7d5-5374-43b3-b5eb-72ca2e3d190d$x$, $x$QK_DISTRIBUTION_SHAPES$x$, false),
  ($x$58dc057e-2404-4e45-99b2-c31a422c1f91$x$, $x$QK_MEASURES_OF_SPREAD$x$, false),
  ($x$4eb5c028-f99b-46fc-81d3-35b622f861d9$x$, $x$QK_MEASURES_OF_SPREAD$x$, false),
  ($x$86d5e636-dd68-4d82-885d-7a69f84863f9$x$, $x$QK_MEASURES_OF_SPREAD$x$, false),
  ($x$c3870753-c028-457b-a681-92562815ab6a$x$, $x$QK_MEASURES_OF_SPREAD$x$, false),
  ($x$df11fb65-4c21-4e8d-8902-4abac82186c1$x$, $x$QK_MEASURES_OF_SPREAD$x$, false),
  ($x$8bd518be-08fc-4a78-a507-a575eb487d1f$x$, $x$QK_OUTLIER_IDENTIFICATION$x$, false),
  ($x$46f179f5-9f2f-4ba3-b1cf-da2e651dedf0$x$, $x$QK_OUTLIER_IDENTIFICATION$x$, false),
  ($x$f8d1b6fa-731e-4053-b82d-9f624a197044$x$, $x$QK_OUTLIER_IDENTIFICATION$x$, false),
  ($x$7b15e325-c715-47f2-9d65-30f8f8742b9d$x$, $x$QK_PROBABILITY_RULES$x$, false),
  ($x$306c885d-80dc-4930-905c-ce3f7d162289$x$, $x$QK_PROBABILITY_RULES$x$, false),
  ($x$d2726960-fa6a-43a7-8a1e-ed73d286f389$x$, $x$QK_PROBABILITY_RULES$x$, false),
  ($x$bf2beb24-15cc-40aa-be76-41a8fa766390$x$, $x$QK_PROBABILITY_RULES$x$, false),
  ($x$841506f5-786c-40a1-8425-2b70cde17eb6$x$, $x$QK_PROBABILITY_RULES$x$, false),
  ($x$c6c22e34-7c6f-4ee7-8703-317f98c4b1c1$x$, $x$QK_HYPOTHESIS_TESTING_TERMS$x$, false),
  ($x$2732c319-b26a-457b-bc3a-c7b35cf41371$x$, $x$QK_HYPOTHESIS_TESTING_TERMS$x$, false),
  ($x$b3e61421-7425-4f17-a3cd-9cf4e2a5a5e6$x$, $x$QK_HYPOTHESIS_TESTING_TERMS$x$, false),
  ($x$327c7310-15ba-4a5d-afef-116dc0e95a36$x$, $x$QK_HYPOTHESIS_TESTING_TERMS$x$, false),
  ($x$c390b156-1a06-4465-b043-146618ebd02c$x$, $x$QK_HYPOTHESIS_TESTING_TERMS$x$, false),
  ($x$6e6b2183-d526-47f0-b2ec-f81857b81fdb$x$, $x$QK_HYPOTHESIS_TESTING_TERMS$x$, false),
  ($x$939f3b9d-247a-49f6-9ec9-3789a924e869$x$, $x$QK_HYPOTHESIS_TESTING_TERMS$x$, false),
  ($x$b3716a40-d921-4f89-868f-0a00f187f291$x$, $x$QK_HYPOTHESIS_TESTING_TERMS$x$, false),
  ($x$b64059b6-ad83-4364-bce3-95a9b2c22942$x$, $x$QK_DATA_DISPLAY_FORMATS$x$, false),
  ($x$18cd0ddb-f43a-437d-920b-599482958a4b$x$, $x$QK_DATA_DISPLAY_FORMATS$x$, false),
  ($x$379b5969-06ef-4e2c-965f-6ff375128565$x$, $x$QK_DATA_DISPLAY_FORMATS$x$, false),
  ($x$ad71898b-65c9-4c2f-a3e3-2b390affb36b$x$, $x$QK_DATA_DISPLAY_FORMATS$x$, false),
  ($x$c617866f-d533-4aae-9a4a-0265aa994404$x$, $x$QK_DATA_DISPLAY_FORMATS$x$, false),
  ($x$85fc2e41-1117-4d69-9155-a70cac15532f$x$, $x$QK_DATA_DISPLAY_FORMATS$x$, false),
  ($x$320ce8dd-f114-48e5-a315-2eebc04e560b$x$, $x$QK_DATA_DISPLAY_FORMATS$x$, false),
  ($x$b48fe24a-6c53-400e-97db-6c08cb8782e4$x$, $x$QK_CORRELATION_COEFFICIENT$x$, false),
  ($x$3b254238-c8c5-4e01-a569-37744bedbac8$x$, $x$QK_CORRELATION_COEFFICIENT$x$, false),
  ($x$0bda2cb7-7ce9-4ca6-9165-6aafe4d6de60$x$, $x$RO_CAUSAL_INFERENCE$x$, false),
  ($x$07f960e5-2b0b-4db6-a3c9-0a8bce4601fb$x$, $x$RO_BIAS$x$, false),
  ($x$3a73b8b2-38bc-48ed-826e-479c1f6474b5$x$, $x$QK_DISTRIBUTION_SHAPES$x$, false),
  ($x$564ec47f-6b71-4f8a-9d68-a2728073a0e6$x$, $x$QK_PROBABILITY_RULES$x$, false),
  ($x$9af59a8b-a013-4c9e-bb45-cd43cdaebf49$x$, $x$QK_ESTIMATION_AND_NOTATION$x$, false),
  ($x$0eec0201-55be-467b-8246-9ac8e276cd8b$x$, $x$QK_SIGNIFICANT_FIGURES$x$, false),
  ($x$2ee104f8-db09-48f7-8d04-88f59ed61468$x$, $x$QK_SIGNIFICANT_FIGURES$x$, false),
  ($x$30bbc9e1-d19f-47a1-9f40-562df1719485$x$, $x$QK_SIGNIFICANT_FIGURES$x$, false),
  ($x$79ef1e18-84f6-42e2-8978-acab519c07b3$x$, $x$QK_SIGNIFICANT_FIGURES$x$, false),
  ($x$5c5f4f7c-0511-4d74-baf0-4a8640f1b194$x$, $x$QK_SIGNIFICANT_FIGURES$x$, false),
  ($x$920fcff8-65d3-418d-b9a3-5239ca126de6$x$, $x$QK_ESTIMATION_AND_NOTATION$x$, false),
  ($x$c2a051e5-1a03-4170-ae90-c1b590412f3e$x$, $x$QK_EXPONENT_RULES$x$, false),
  ($x$1e19f518-e54a-4c6a-beba-c4cb4b36c330$x$, $x$QK_EXPONENT_RULES$x$, false),
  ($x$beea28c9-2cb5-4ee4-80d5-b82e3925c743$x$, $x$QK_EXPONENT_RULES$x$, false),
  ($x$c712adff-d733-49e7-9bce-77b7c6c016d8$x$, $x$QK_EXPONENT_RULES$x$, false),
  ($x$fda7c907-c990-42ae-bbe7-7d380c8813ba$x$, $x$QK_EXPONENT_RULES$x$, false),
  ($x$84f961ad-9470-46b4-a3d6-291963c74242$x$, $x$QK_EXPONENT_RULES$x$, false),
  ($x$28a5e381-16d9-416d-85ec-774f2cc567b8$x$, $x$QK_EXPONENT_RULES$x$, false),
  ($x$c647c887-c507-492e-a5b5-19c3a1bc774a$x$, $x$QK_ESTIMATION_AND_NOTATION$x$, false),
  ($x$107cb71d-4d38-4e2c-bd23-72ed39104a6a$x$, $x$QK_LOGARITHM_RULES$x$, false),
  ($x$3c73a4b9-5edf-457c-be1b-a78388ba9508$x$, $x$QK_LOGARITHM_RULES$x$, false),
  ($x$9f8cbc47-d9ce-47f1-a25c-5aae99c1d5eb$x$, $x$QK_LOGARITHM_RULES$x$, false),
  ($x$8285a604-590d-4c63-afdf-6e42a4dc1ffb$x$, $x$QK_LOGARITHM_RULES$x$, false),
  ($x$f48de5ec-ee4f-45c2-ab68-c01916fd6519$x$, $x$QK_TRIGONOMETRIC_VALUES$x$, false),
  ($x$1310e719-afce-4783-b2fe-3b112799dc03$x$, $x$QK_TRIGONOMETRIC_VALUES$x$, false),
  ($x$a6608b40-0130-4c71-a554-30e080a51048$x$, $x$QK_TRIGONOMETRIC_VALUES$x$, false),
  ($x$2703b74d-ade8-4435-94ed-184ebba2915a$x$, $x$QK_TRIGONOMETRIC_VALUES$x$, false),
  ($x$4816c313-2102-46dd-b17b-be141c41b112$x$, $x$QK_TRIGONOMETRIC_VALUES$x$, false),
  ($x$c97bf7f8-4766-4d85-bb88-d6eadf8d3199$x$, $x$QK_TRIGONOMETRIC_VALUES$x$, false),
  ($x$3be015b7-c69a-4854-826a-a629340d6022$x$, $x$QK_TRIGONOMETRIC_VALUES$x$, false),
  ($x$04f1ac8d-ef23-4026-a87e-b08f6afe4167$x$, $x$QK_PROPORTIONAL_RELATIONSHIPS$x$, false),
  ($x$25baf7c2-a166-4e4f-9195-0ba316617711$x$, $x$QK_UNITS_AND_SI_PREFIXES$x$, false),
  ($x$7a25a4b0-0a5e-400f-a9cb-80df4a0dc004$x$, $x$QK_UNITS_AND_SI_PREFIXES$x$, false),
  ($x$19595e2c-3698-473b-81b4-f1abc166d26e$x$, $x$QK_UNITS_AND_SI_PREFIXES$x$, false),
  ($x$afd52f0d-7109-42e7-800a-0894253523b8$x$, $x$QK_UNITS_AND_SI_PREFIXES$x$, false),
  ($x$de126799-baa7-41ea-b431-746e53b2e911$x$, $x$QK_SIMULTANEOUS_EQUATIONS$x$, false),
  ($x$60fc3d31-4693-4cff-ade6-3d4f33c11f80$x$, $x$QK_SIMULTANEOUS_EQUATIONS$x$, false),
  ($x$115efdb6-bc99-4323-8bf0-e19fcb9b6771$x$, $x$QK_SIMULTANEOUS_EQUATIONS$x$, false)
) AS m(card, key, by_name)
JOIN public.concepts c ON (CASE WHEN m.by_name THEN c.canonical_name ELSE c.slug END) = m.key
WHERE c.status <> 'DEPRECATED'
ON CONFLICT (flashcard_id, concept_id) DO NOTHING;
-- ────────────────────────────────────────────────────────────
-- Verification
-- ────────────────────────────────────────────────────────────
SELECT
  (SELECT count(*) FROM public.concepts)                                        AS objects,        -- 637
  (SELECT count(*) FROM public.content_concepts)                                AS content,        -- 610
  (SELECT count(*) FROM public.reasoning_objects)                               AS reasoning,      -- 11
  (SELECT count(*) FROM public.quantitative_objects)                            AS quantitative,   -- 16
  (SELECT count(*) FROM public.flashcard_concepts)                              AS card_mappings,  -- 314
  (SELECT count(*) FROM public.question_concepts)                               AS question_maps;  -- 2659

-- Card mappings by object type. Expect CONTENT 202, REASONING 35, QUANTITATIVE 77.
SELECT c.object_type, count(*) AS cards
FROM public.flashcard_concepts fc JOIN public.concepts c ON c.id = fc.concept_id
GROUP BY c.object_type ORDER BY c.object_type;

-- No cross-cutting object may carry content taxonomy. Expect zero rows.
SELECT 'cross-cutting carries taxonomy' AS problem, c.slug, c.object_type
FROM public.concepts c
WHERE c.object_type <> 'CONTENT'
  AND (EXISTS (SELECT 1 FROM public.concept_sections s WHERE s.concept_id = c.id)
    OR EXISTS (SELECT 1 FROM public.concept_disciplines d WHERE d.concept_id = c.id)
    OR EXISTS (SELECT 1 FROM public.concept_content_categories k WHERE k.concept_id = c.id));

-- Every question mapping still points at CONTENT. Expect zero rows.
SELECT 'question mapped to non-content' AS problem, count(*) AS n
FROM public.question_concepts qc JOIN public.concepts c ON c.id = qc.concept_id
WHERE c.object_type <> 'CONTENT';

-- The two widened concepts now show their true scope.
SELECT c.canonical_name, string_agg(DISTINCT d.discipline_code, ', ') AS disciplines,
       string_agg(DISTINCT s.section_code, ', ') AS sections
FROM public.concepts c
LEFT JOIN public.concept_disciplines d ON d.concept_id = c.id
LEFT JOIN public.concept_sections s ON s.concept_id = c.id
WHERE c.canonical_name IN ('Thermodynamics: Systems & Free Energy','Free Energy & Equilibrium')
GROUP BY c.canonical_name;

-- All 314 mappings are AI_PROPOSED. Expect one row.
SELECT mapping_status, source, count(*) FROM public.flashcard_concepts GROUP BY 1,2;

-- Nothing else moved.
SELECT (SELECT count(*) FROM public.flashcards) AS cards,        -- 4117
       (SELECT count(*) FROM public.questions)  AS questions;    -- 2681

-- ── ROLLBACK ────────────────────────────────────────────────────────────
-- DELETE FROM public.flashcard_concepts WHERE source = 'AI_PROPOSED';
-- DELETE FROM public.concept_sections WHERE section_code = 'CHEM_PHYS' AND is_primary = false
--   AND concept_id IN (SELECT id FROM public.concepts WHERE canonical_name IN
--     ('Thermodynamics: Systems & Free Energy','Free Energy & Equilibrium'));
-- DELETE FROM public.concept_disciplines WHERE discipline_code = 'GENERAL_CHEMISTRY' AND role = 'SECONDARY';
-- DELETE FROM public.concepts WHERE status = 'ACTIVE_SEED' AND created_at > now() - interval '1 hour';
-- DROP TRIGGER IF EXISTS question_concepts_content_only ON public.question_concepts;
-- DROP FUNCTION IF EXISTS public.question_concepts_content_only();
