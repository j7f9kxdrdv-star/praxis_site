-- ============================================================
-- Organic Chemistry: vocabulary extension and card mapping
--
-- APPROVED. 67 new CONTENT concepts, 1 new REASONING object, and a PRIMARY
-- mapping for all 425 organic chemistry flashcards.
--
-- ONE CONFLICT, RESOLVED BY REUSE. The design pass proposed 68 new CONTENT
-- concepts. Validation found that one of them, KETO_ENOL_TAUTOMERISM, already
-- exists: it was seeded as a biochemistry concept for carbohydrate enediol
-- isomerization and carries 4 DETERMINISTIC question mappings. The four organic
-- chemistry cards teach the same phenomenon from the enol side. Creating a
-- second object would split one concept across two ids, which is precisely what
-- this layer exists to prevent, so those cards reuse the existing object and it
-- is widened below. That is why the ontology reaches 705 and not 706.
--
-- PROVENANCE. Every card mapping is AI_PROPOSED. The vocabulary and the
-- clustering were approved; 425 individual rows were not reviewed one by one,
-- and nothing here may claim they were.
--
-- WRITE SCOPE. Concepts, their taxonomy, and flashcard_concepts. No learner
-- table is read or written. No flashcard text, cloze numbering, FSRS state,
-- review history or question mapping is touched.
-- ============================================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- 1. The 67 new CONTENT concepts
-- ────────────────────────────────────────────────────────────
INSERT INTO public.concepts (slug, canonical_name, object_type, status) VALUES
  ('ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER', 'Absolute Configuration: CIP, R/S and Fischer Projections', 'CONTENT', 'ACTIVE_SEED'),
  ('ACETAL_AND_KETAL_PROTECTION', 'Acetal and Ketal Protection', 'CONTENT', 'ACTIVE_SEED'),
  ('ACIDITY_OF_ALCOHOLS_AND_PHENOLS', 'Acidity of Alcohols and Phenols', 'CONTENT', 'ACTIVE_SEED'),
  ('ACIDITY_OF_ORGANIC_FUNCTIONAL_GROUPS', 'Acidity of Organic Functional Groups', 'CONTENT', 'ACTIVE_SEED'),
  ('ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE', 'Alcohols and Phenols: Structure and Nomenclature', 'CONTENT', 'ACTIVE_SEED'),
  ('ALCOHOL_ACTIVATION_AND_PROTECTION', 'Alcohol Activation and Protection', 'CONTENT', 'ACTIVE_SEED'),
  ('ALCOHOL_OXIDATION', 'Alcohol Oxidation', 'CONTENT', 'ACTIVE_SEED'),
  ('ALCOHOL_PHYSICAL_PROPERTIES', 'Alcohol Physical Properties', 'CONTENT', 'ACTIVE_SEED'),
  ('ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE', 'Aldehyde and Ketone Structure and Nomenclature', 'CONTENT', 'ACTIVE_SEED'),
  ('ALDOL_ADDITION_AND_CONDENSATION', 'Aldol Addition and Condensation', 'CONTENT', 'ACTIVE_SEED'),
  ('ALKANE_ALKENE_ALKYNE_NOMENCLATURE', 'Alkane, Alkene and Alkyne Nomenclature', 'CONTENT', 'ACTIVE_SEED'),
  ('ALPHA_CARBON_ACIDITY_AND_ENOLATES', 'Alpha Carbon Acidity and Enolates', 'CONTENT', 'ACTIVE_SEED'),
  ('AMIDES_AND_LACTAMS', 'Amides and Lactams', 'CONTENT', 'ACTIVE_SEED'),
  ('ANHYDRIDES', 'Anhydrides', 'CONTENT', 'ACTIVE_SEED'),
  ('BETA_LACTAMS_AND_RING_STRAIN', 'Beta-Lactams and Ring Strain', 'CONTENT', 'ACTIVE_SEED'),
  ('CARBONYL_OXIDATION', 'Carbonyl Oxidation', 'CONTENT', 'ACTIVE_SEED'),
  ('CARBONYL_REACTIVITY', 'Carbonyl Reactivity', 'CONTENT', 'ACTIVE_SEED'),
  ('CARBONYL_REDUCTION', 'Carbonyl Reduction', 'CONTENT', 'ACTIVE_SEED'),
  ('CARBON_OXIDATION_STATES', 'Carbon Oxidation States', 'CONTENT', 'ACTIVE_SEED'),
  ('CARBOXYLIC_ACID_ACIDITY', 'Carboxylic Acid Acidity', 'CONTENT', 'ACTIVE_SEED'),
  ('CARBOXYLIC_ACID_DERIVATIVE_REACTIVITY', 'Carboxylic Acid Derivative Reactivity', 'CONTENT', 'ACTIVE_SEED'),
  ('CARBOXYLIC_ACID_PHYSICAL_PROPERTIES', 'Carboxylic Acid Physical Properties', 'CONTENT', 'ACTIVE_SEED'),
  ('CARBOXYLIC_ACID_STRUCTURE_NOMENCLATURE', 'Carboxylic Acid Structure and Nomenclature', 'CONTENT', 'ACTIVE_SEED'),
  ('CHEMOSELECTIVITY_AND_PROTECTING_GROUPS', 'Chemoselectivity and Protecting Groups', 'CONTENT', 'ACTIVE_SEED'),
  ('CHIRALITY_AND_STEREOCENTERS', 'Chirality and Stereocenters', 'CONTENT', 'ACTIVE_SEED'),
  ('CONDENSATION_REACTIONS', 'Condensation Reactions', 'CONTENT', 'ACTIVE_SEED'),
  ('CONFORMATIONAL_ANALYSIS_NEWMAN_PROJECTIONS', 'Conformational Analysis: Newman Projections', 'CONTENT', 'ACTIVE_SEED'),
  ('CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN', 'Cyclohexane Conformations and Ring Strain', 'CONTENT', 'ACTIVE_SEED'),
  ('DECARBOXYLATION', 'Decarboxylation', 'CONTENT', 'ACTIVE_SEED'),
  ('DIASTEREOMERS_AND_MESO_COMPOUNDS', 'Diastereomers and Meso Compounds', 'CONTENT', 'ACTIVE_SEED'),
  ('DISTILLATION', 'Distillation', 'CONTENT', 'ACTIVE_SEED'),
  ('ENANTIOMERS_AND_OPTICAL_ACTIVITY', 'Enantiomers and Optical Activity', 'CONTENT', 'ACTIVE_SEED'),
  ('ESTERS_AND_LACTONES', 'Esters and Lactones', 'CONTENT', 'ACTIVE_SEED'),
  ('EXTRACTION', 'Extraction', 'CONTENT', 'ACTIVE_SEED'),
  ('FILTRATION_AND_SOLVENT_REMOVAL', 'Filtration and Solvent Removal', 'CONTENT', 'ACTIVE_SEED'),
  ('FUNCTIONAL_GROUP_PRIORITY', 'Functional Group Priority', 'CONTENT', 'ACTIVE_SEED'),
  ('GABRIEL_SYNTHESIS', 'Gabriel Synthesis', 'CONTENT', 'ACTIVE_SEED'),
  ('GAS_CHROMATOGRAPHY', 'Gas Chromatography', 'CONTENT', 'ACTIVE_SEED'),
  ('HELL_VOLHARD_ZELINSKII_REACTION', 'Hell-Volhard-Zelinskii Reaction', 'CONTENT', 'ACTIVE_SEED'),
  ('HIGH_PERFORMANCE_LIQUID_CHROMATOGRAPHY', 'High-Performance Liquid Chromatography', 'CONTENT', 'ACTIVE_SEED'),
  ('IMINE_AND_ENAMINE_FORMATION', 'Imine and Enamine Formation', 'CONTENT', 'ACTIVE_SEED'),
  ('INFRARED_SPECTROSCOPY', 'Infrared Spectroscopy', 'CONTENT', 'ACTIVE_SEED'),
  ('ISOMER_CLASSIFICATION', 'Isomer Classification', 'CONTENT', 'ACTIVE_SEED'),
  ('IUPAC_NAMING_SYSTEM', 'IUPAC Naming System', 'CONTENT', 'ACTIVE_SEED'),
  ('KINETIC_VERSUS_THERMODYNAMIC_ENOLATES', 'Kinetic versus Thermodynamic Enolates', 'CONTENT', 'ACTIVE_SEED'),
  ('LEAVING_GROUPS', 'Leaving Groups', 'CONTENT', 'ACTIVE_SEED'),
  ('LOCANT_NUMBERING_RULES', 'Locant Numbering Rules', 'CONTENT', 'ACTIVE_SEED'),
  ('MICHAEL_ADDITION', 'Michael Addition', 'CONTENT', 'ACTIVE_SEED'),
  ('MOLECULAR_ORBITAL_THEORY', 'Molecular Orbital Theory', 'CONTENT', 'ACTIVE_SEED'),
  ('NMR_CHEMICAL_SHIFT_AND_INTEGRATION', 'NMR Chemical Shift and Integration', 'CONTENT', 'ACTIVE_SEED'),
  ('NMR_PRINCIPLES', 'NMR Principles', 'CONTENT', 'ACTIVE_SEED'),
  ('NMR_SPIN_SPIN_COUPLING', 'NMR Spin-Spin Coupling', 'CONTENT', 'ACTIVE_SEED'),
  ('NUCLEOPHILICITY_AND_ELECTROPHILICITY', 'Nucleophilicity and Electrophilicity', 'CONTENT', 'ACTIVE_SEED'),
  ('NUCLEOPHILIC_ACYL_SUBSTITUTION', 'Nucleophilic Acyl Substitution', 'CONTENT', 'ACTIVE_SEED'),
  ('NUCLEOPHILIC_ADDITION_TO_CARBONYLS', 'Nucleophilic Addition to Carbonyls', 'CONTENT', 'ACTIVE_SEED'),
  ('NUCLEOPHILIC_SUBSTITUTION_SN1_SN2', 'Nucleophilic Substitution: SN1 and SN2', 'CONTENT', 'ACTIVE_SEED'),
  ('PARENT_CHAIN_SELECTION', 'Parent Chain Selection', 'CONTENT', 'ACTIVE_SEED'),
  ('PHOSPHATE_ESTERS_AND_ANHYDRIDE_BONDS', 'Phosphate Esters and Anhydride Bonds', 'CONTENT', 'ACTIVE_SEED'),
  ('PHOSPHORIC_ACID_AND_PHOSPHATE_BUFFERS', 'Phosphoric Acid and Phosphate Buffers', 'CONTENT', 'ACTIVE_SEED'),
  ('QUINONES', 'Quinones', 'CONTENT', 'ACTIVE_SEED'),
  ('RECRYSTALLIZATION', 'Recrystallization', 'CONTENT', 'ACTIVE_SEED'),
  ('STEREOSPECIFICITY_AND_STEREOSELECTIVITY', 'Stereospecificity and Stereoselectivity', 'CONTENT', 'ACTIVE_SEED'),
  ('STERIC_AND_ELECTRONIC_EFFECTS_ON_REACTIVITY', 'Steric and Electronic Effects on Reactivity', 'CONTENT', 'ACTIVE_SEED'),
  ('STRECKER_SYNTHESIS', 'Strecker Synthesis', 'CONTENT', 'ACTIVE_SEED'),
  ('SUBSTITUENT_NAMING', 'Substituent Naming', 'CONTENT', 'ACTIVE_SEED'),
  ('THIN_LAYER_AND_REVERSE_PHASE_CHROMATOGRAPHY', 'Thin-Layer and Reverse-Phase Chromatography', 'CONTENT', 'ACTIVE_SEED'),
  ('ULTRAVIOLET_VISIBLE_SPECTROSCOPY', 'Ultraviolet-Visible Spectroscopy', 'CONTENT', 'ACTIVE_SEED');

-- Section and discipline: all 67 are organic chemistry, examined in Chem/Phys.
INSERT INTO public.concept_sections (concept_id, section_code)
SELECT id, 'CHEM_PHYS' FROM public.concepts WHERE slug IN ('ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER', 'ACETAL_AND_KETAL_PROTECTION', 'ACIDITY_OF_ALCOHOLS_AND_PHENOLS', 'ACIDITY_OF_ORGANIC_FUNCTIONAL_GROUPS', 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE', 'ALCOHOL_ACTIVATION_AND_PROTECTION', 'ALCOHOL_OXIDATION', 'ALCOHOL_PHYSICAL_PROPERTIES', 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE', 'ALDOL_ADDITION_AND_CONDENSATION', 'ALKANE_ALKENE_ALKYNE_NOMENCLATURE', 'ALPHA_CARBON_ACIDITY_AND_ENOLATES', 'AMIDES_AND_LACTAMS', 'ANHYDRIDES', 'BETA_LACTAMS_AND_RING_STRAIN', 'CARBONYL_OXIDATION', 'CARBONYL_REACTIVITY', 'CARBONYL_REDUCTION', 'CARBON_OXIDATION_STATES', 'CARBOXYLIC_ACID_ACIDITY', 'CARBOXYLIC_ACID_DERIVATIVE_REACTIVITY', 'CARBOXYLIC_ACID_PHYSICAL_PROPERTIES', 'CARBOXYLIC_ACID_STRUCTURE_NOMENCLATURE', 'CHEMOSELECTIVITY_AND_PROTECTING_GROUPS', 'CHIRALITY_AND_STEREOCENTERS', 'CONDENSATION_REACTIONS', 'CONFORMATIONAL_ANALYSIS_NEWMAN_PROJECTIONS', 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN', 'DECARBOXYLATION', 'DIASTEREOMERS_AND_MESO_COMPOUNDS', 'DISTILLATION', 'ENANTIOMERS_AND_OPTICAL_ACTIVITY', 'ESTERS_AND_LACTONES', 'EXTRACTION', 'FILTRATION_AND_SOLVENT_REMOVAL', 'FUNCTIONAL_GROUP_PRIORITY', 'GABRIEL_SYNTHESIS', 'GAS_CHROMATOGRAPHY', 'HELL_VOLHARD_ZELINSKII_REACTION', 'HIGH_PERFORMANCE_LIQUID_CHROMATOGRAPHY', 'IMINE_AND_ENAMINE_FORMATION', 'INFRARED_SPECTROSCOPY', 'ISOMER_CLASSIFICATION', 'IUPAC_NAMING_SYSTEM', 'KINETIC_VERSUS_THERMODYNAMIC_ENOLATES', 'LEAVING_GROUPS', 'LOCANT_NUMBERING_RULES', 'MICHAEL_ADDITION', 'MOLECULAR_ORBITAL_THEORY', 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION', 'NMR_PRINCIPLES', 'NMR_SPIN_SPIN_COUPLING', 'NUCLEOPHILICITY_AND_ELECTROPHILICITY', 'NUCLEOPHILIC_ACYL_SUBSTITUTION', 'NUCLEOPHILIC_ADDITION_TO_CARBONYLS', 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2', 'PARENT_CHAIN_SELECTION', 'PHOSPHATE_ESTERS_AND_ANHYDRIDE_BONDS', 'PHOSPHORIC_ACID_AND_PHOSPHATE_BUFFERS', 'QUINONES', 'RECRYSTALLIZATION', 'STEREOSPECIFICITY_AND_STEREOSELECTIVITY', 'STERIC_AND_ELECTRONIC_EFFECTS_ON_REACTIVITY', 'STRECKER_SYNTHESIS', 'SUBSTITUENT_NAMING', 'THIN_LAYER_AND_REVERSE_PHASE_CHROMATOGRAPHY', 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY');

INSERT INTO public.concept_disciplines (concept_id, discipline_code, role)
SELECT id, 'ORGANIC_CHEMISTRY', 'PRIMARY' FROM public.concepts WHERE slug IN ('ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER', 'ACETAL_AND_KETAL_PROTECTION', 'ACIDITY_OF_ALCOHOLS_AND_PHENOLS', 'ACIDITY_OF_ORGANIC_FUNCTIONAL_GROUPS', 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE', 'ALCOHOL_ACTIVATION_AND_PROTECTION', 'ALCOHOL_OXIDATION', 'ALCOHOL_PHYSICAL_PROPERTIES', 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE', 'ALDOL_ADDITION_AND_CONDENSATION', 'ALKANE_ALKENE_ALKYNE_NOMENCLATURE', 'ALPHA_CARBON_ACIDITY_AND_ENOLATES', 'AMIDES_AND_LACTAMS', 'ANHYDRIDES', 'BETA_LACTAMS_AND_RING_STRAIN', 'CARBONYL_OXIDATION', 'CARBONYL_REACTIVITY', 'CARBONYL_REDUCTION', 'CARBON_OXIDATION_STATES', 'CARBOXYLIC_ACID_ACIDITY', 'CARBOXYLIC_ACID_DERIVATIVE_REACTIVITY', 'CARBOXYLIC_ACID_PHYSICAL_PROPERTIES', 'CARBOXYLIC_ACID_STRUCTURE_NOMENCLATURE', 'CHEMOSELECTIVITY_AND_PROTECTING_GROUPS', 'CHIRALITY_AND_STEREOCENTERS', 'CONDENSATION_REACTIONS', 'CONFORMATIONAL_ANALYSIS_NEWMAN_PROJECTIONS', 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN', 'DECARBOXYLATION', 'DIASTEREOMERS_AND_MESO_COMPOUNDS', 'DISTILLATION', 'ENANTIOMERS_AND_OPTICAL_ACTIVITY', 'ESTERS_AND_LACTONES', 'EXTRACTION', 'FILTRATION_AND_SOLVENT_REMOVAL', 'FUNCTIONAL_GROUP_PRIORITY', 'GABRIEL_SYNTHESIS', 'GAS_CHROMATOGRAPHY', 'HELL_VOLHARD_ZELINSKII_REACTION', 'HIGH_PERFORMANCE_LIQUID_CHROMATOGRAPHY', 'IMINE_AND_ENAMINE_FORMATION', 'INFRARED_SPECTROSCOPY', 'ISOMER_CLASSIFICATION', 'IUPAC_NAMING_SYSTEM', 'KINETIC_VERSUS_THERMODYNAMIC_ENOLATES', 'LEAVING_GROUPS', 'LOCANT_NUMBERING_RULES', 'MICHAEL_ADDITION', 'MOLECULAR_ORBITAL_THEORY', 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION', 'NMR_PRINCIPLES', 'NMR_SPIN_SPIN_COUPLING', 'NUCLEOPHILICITY_AND_ELECTROPHILICITY', 'NUCLEOPHILIC_ACYL_SUBSTITUTION', 'NUCLEOPHILIC_ADDITION_TO_CARBONYLS', 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2', 'PARENT_CHAIN_SELECTION', 'PHOSPHATE_ESTERS_AND_ANHYDRIDE_BONDS', 'PHOSPHORIC_ACID_AND_PHOSPHATE_BUFFERS', 'QUINONES', 'RECRYSTALLIZATION', 'STEREOSPECIFICITY_AND_STEREOSELECTIVITY', 'STERIC_AND_ELECTRONIC_EFFECTS_ON_REACTIVITY', 'STRECKER_SYNTHESIS', 'SUBSTITUENT_NAMING', 'THIN_LAYER_AND_REVERSE_PHASE_CHROMATOGRAPHY', 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY');

-- AAMC content category, using only category names already in the vocabulary.
INSERT INTO public.concept_content_categories (concept_id, content_category)
SELECT id, 'Structure, function, and reactivity of biologically relevant molecules' FROM public.concepts
WHERE slug IN ('ACETAL_AND_KETAL_PROTECTION', 'ACIDITY_OF_ALCOHOLS_AND_PHENOLS', 'ACIDITY_OF_ORGANIC_FUNCTIONAL_GROUPS', 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE', 'ALCOHOL_ACTIVATION_AND_PROTECTION', 'ALCOHOL_OXIDATION', 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE', 'ALDOL_ADDITION_AND_CONDENSATION', 'ALKANE_ALKENE_ALKYNE_NOMENCLATURE', 'ALPHA_CARBON_ACIDITY_AND_ENOLATES', 'AMIDES_AND_LACTAMS', 'ANHYDRIDES', 'BETA_LACTAMS_AND_RING_STRAIN', 'CARBONYL_OXIDATION', 'CARBONYL_REACTIVITY', 'CARBONYL_REDUCTION', 'CARBON_OXIDATION_STATES', 'CARBOXYLIC_ACID_ACIDITY', 'CARBOXYLIC_ACID_DERIVATIVE_REACTIVITY', 'CARBOXYLIC_ACID_STRUCTURE_NOMENCLATURE', 'CHEMOSELECTIVITY_AND_PROTECTING_GROUPS', 'CONDENSATION_REACTIONS', 'DECARBOXYLATION', 'ESTERS_AND_LACTONES', 'FUNCTIONAL_GROUP_PRIORITY', 'GABRIEL_SYNTHESIS', 'HELL_VOLHARD_ZELINSKII_REACTION', 'IMINE_AND_ENAMINE_FORMATION', 'INFRARED_SPECTROSCOPY', 'IUPAC_NAMING_SYSTEM', 'KINETIC_VERSUS_THERMODYNAMIC_ENOLATES', 'LEAVING_GROUPS', 'LOCANT_NUMBERING_RULES', 'MICHAEL_ADDITION', 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION', 'NMR_PRINCIPLES', 'NMR_SPIN_SPIN_COUPLING', 'NUCLEOPHILICITY_AND_ELECTROPHILICITY', 'NUCLEOPHILIC_ACYL_SUBSTITUTION', 'NUCLEOPHILIC_ADDITION_TO_CARBONYLS', 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2', 'PARENT_CHAIN_SELECTION', 'PHOSPHATE_ESTERS_AND_ANHYDRIDE_BONDS', 'PHOSPHORIC_ACID_AND_PHOSPHATE_BUFFERS', 'QUINONES', 'STERIC_AND_ELECTRONIC_EFFECTS_ON_REACTIVITY', 'STRECKER_SYNTHESIS', 'SUBSTITUENT_NAMING', 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY');

INSERT INTO public.concept_content_categories (concept_id, content_category)
SELECT id, 'Nature of molecules and intermolecular interactions' FROM public.concepts
WHERE slug IN ('ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER', 'ALCOHOL_PHYSICAL_PROPERTIES', 'CARBOXYLIC_ACID_PHYSICAL_PROPERTIES', 'CHIRALITY_AND_STEREOCENTERS', 'CONFORMATIONAL_ANALYSIS_NEWMAN_PROJECTIONS', 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN', 'DIASTEREOMERS_AND_MESO_COMPOUNDS', 'ENANTIOMERS_AND_OPTICAL_ACTIVITY', 'ISOMER_CLASSIFICATION', 'MOLECULAR_ORBITAL_THEORY', 'STEREOSPECIFICITY_AND_STEREOSELECTIVITY');

INSERT INTO public.concept_content_categories (concept_id, content_category)
SELECT id, 'Separations and Purifications' FROM public.concepts
WHERE slug IN ('DISTILLATION', 'EXTRACTION', 'FILTRATION_AND_SOLVENT_REMOVAL', 'GAS_CHROMATOGRAPHY', 'HIGH_PERFORMANCE_LIQUID_CHROMATOGRAPHY', 'RECRYSTALLIZATION', 'THIN_LAYER_AND_REVERSE_PHASE_CHROMATOGRAPHY');

-- ────────────────────────────────────────────────────────────
-- 2. The one new REASONING object
--
-- It carries NO section, discipline or category, and the triggers from
-- 20260924_object_type.sql would reject them if it tried. Working out which
-- mechanism a reaction follows is an analytical operation, not a fact about
-- carbonyls, and it must stay invisible to content analytics.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.concepts (slug, canonical_name, object_type, status) VALUES
  ('RO_REACTION_MECHANISM_ANALYSIS', 'Reaction Mechanism Analysis', 'REASONING', 'ACTIVE_SEED');

-- ────────────────────────────────────────────────────────────
-- 3. Widening existing concepts, decided one at a time
--
-- Reuse is only honest if the reused concept admits it lives here too. Each
-- widening below is backed by organic chemistry card evidence. Deliberately NOT
-- widened: the general chemistry concepts an organic chemistry chapter merely
-- revises. Quantum numbers and oxidation-state bookkeeping are examined in
-- Chem/Phys already, so their section is right; calling them organic chemistry
-- would be a claim the cards do not support.
-- ────────────────────────────────────────────────────────────
-- These rows are SECONDARY on purpose. Both concept_sections and
-- concept_content_categories carry a partial unique index allowing one primary
-- per concept, and is_primary defaults to TRUE. A widening row inserted as
-- primary would collide with the concept's existing home; with ON CONFLICT DO
-- NOTHING it would be silently dropped and the widening would quietly not
-- happen. Secondary is also the honest reading: keto-enol tautomerism is still
-- primarily a Bio/Biochem carbohydrate concept that is also examined here.
INSERT INTO public.concept_sections (concept_id, section_code, is_primary)
SELECT id, 'CHEM_PHYS', FALSE FROM public.concepts WHERE canonical_name IN ('ATP & High-Energy Carriers', 'Affinity Chromatography', 'Amino Acid Structure & Stereochemistry', 'Amphipathicity and Micelle Formation', 'Chromatography', 'Ion-Exchange Chromatography', 'Keto-Enol Tautomerism', 'Peptide Bond Formation & Hydrolysis', 'Saponification and Soaps', 'Side-Chain Classification', 'Size-Exclusion Chromatography', 'Zwitterions & Titration Curves')
ON CONFLICT DO NOTHING;

INSERT INTO public.concept_disciplines (concept_id, discipline_code, role)
SELECT id, 'ORGANIC_CHEMISTRY', 'SECONDARY' FROM public.concepts WHERE canonical_name IN ('Amino Acid Structure & Stereochemistry', 'Amphipathicity and Micelle Formation', 'Chromatography', 'Keto-Enol Tautomerism', 'Peptide Bond Formation & Hydrolysis', 'Saponification and Soaps', 'Side-Chain Classification', 'Zwitterions & Titration Curves', 'Sigma/Pi Bonds & Hybridization', 'Resonance & Delocalization')
ON CONFLICT DO NOTHING;

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary)
SELECT id, 'Structure, function, and reactivity of biologically relevant molecules', FALSE FROM public.concepts WHERE canonical_name IN ('ATP & High-Energy Carriers', 'Amino Acid Structure & Stereochemistry', 'Amphipathicity and Micelle Formation', 'Keto-Enol Tautomerism', 'Peptide Bond Formation & Hydrolysis', 'Saponification and Soaps', 'Side-Chain Classification', 'Zwitterions & Titration Curves')
ON CONFLICT DO NOTHING;

-- ────────────────────────────────────────────────────────────
-- 4. The 425 card mappings, one PRIMARY each
-- ────────────────────────────────────────────────────────────
INSERT INTO public.flashcard_concepts (flashcard_id, concept_id, role, mapping_status, source) VALUES
  ('f5eb0db2-80be-4adb-a5cd-81b56eaa793d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5631405b-9c81-47c0-8678-6243bbab4455'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cc1663f1-4dee-4e08-ac89-e6d25ebbd1a5'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('883ff907-7ab7-435f-93b2-d194dd1f4d63'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4384ea5d-5199-4132-aa60-a470c08cd1b4'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_PHYSICAL_PROPERTIES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2ff05947-20e6-4ad8-9cf9-c399a21dc218'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_PHYSICAL_PROPERTIES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8df321cd-2a57-4810-a09f-10745c077483'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_PHYSICAL_PROPERTIES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a3b8921e-dd43-423b-b97b-041707b2872b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACIDITY_OF_ALCOHOLS_AND_PHENOLS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c2d58fbf-f6f0-42c8-8dd4-9b7c25edc727'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACIDITY_OF_ALCOHOLS_AND_PHENOLS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('865c4ae6-a8b8-485f-b07e-d2f4f718a7fb'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACIDITY_OF_ALCOHOLS_AND_PHENOLS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8ff52e8d-0476-4df2-b50f-3b3a64d57381'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_OXIDATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5e65ebc2-7f33-4020-a52d-f070989266a6'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_OXIDATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('58abb959-31b4-4da7-a77e-16d2bb704b13'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_OXIDATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('703c0f9e-5d3c-40a7-bb57-375ca678d7ba'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_OXIDATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('91e6cca6-9df2-4f64-9d70-adf68ea54ade'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_OXIDATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('844c3aff-85e8-477f-affc-a5b6b1ac15cb'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_OXIDATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('de5d9ace-63a7-4038-91c6-2551ddb7e1e2'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_ACTIVATION_AND_PROTECTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e06336ad-5d17-4094-abf6-ba86c9e9cb68'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_ACTIVATION_AND_PROTECTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d32ee191-06a6-4e8d-9267-e748c81ed2b2'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACETAL_AND_KETAL_PROTECTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2a11aecc-632d-49a0-93c0-cccd52cb6e0c'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACETAL_AND_KETAL_PROTECTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('94b84b50-cfa7-4452-a008-f3df9268b669'::uuid, (SELECT id FROM public.concepts WHERE slug = 'QUINONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8bc28742-9d23-4e58-bb20-4c72aa2c11ca'::uuid, (SELECT id FROM public.concepts WHERE slug = 'QUINONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c360019c-e1ab-46e0-9852-1cd030a1284a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'QUINONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('952f967c-839f-4e68-bdb1-27cf6a5781e5'::uuid, (SELECT id FROM public.concepts WHERE slug = 'QUINONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9b0ab7c7-62c5-42d2-a388-6cd7cab0136b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'QUINONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('24efb7c9-93d4-4a41-8c2b-bcf466320f24'::uuid, (SELECT id FROM public.concepts WHERE slug = 'QUINONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6a0fafce-945b-4e13-8856-77acc5d747b7'::uuid, (SELECT id FROM public.concepts WHERE slug = 'QUINONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9b69f72b-4d58-47a3-aaf5-b54fe6961eaf'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('aacadc33-a458-4636-873b-46b81620dcfc'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('77eadfc0-6c0f-4a09-9bc1-7a9cec252f0b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('61adfd3d-7552-47b0-86fd-bcd0303f220c'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9c3d378f-a1c1-4f1b-bde9-4053115b9a9d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0310c7b1-1936-41d3-b855-2d292e2a6ea5'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cf81c548-d941-4b3b-87a0-a74d97bffc76'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3eecdc0c-2bfc-49aa-ae78-87273fad54f4'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOL_OXIDATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c5fd0e99-38da-4c0d-9344-af4fc4e06afc'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_ADDITION_TO_CARBONYLS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b1752612-7725-48de-8e18-490afe468838'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_ADDITION_TO_CARBONYLS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9ed942d5-8daf-4076-af3a-2a845728f749'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_ADDITION_TO_CARBONYLS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0e4f69c6-b855-4f00-a2c2-4360fb07843e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_ADDITION_TO_CARBONYLS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1acdb3dd-e097-4cb1-b132-3f5b27b580d3'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_ADDITION_TO_CARBONYLS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('527393cb-8c94-44f5-a285-6f61f8ae207e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACETAL_AND_KETAL_PROTECTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9d850347-9549-415a-873e-14a8826861ee'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACETAL_AND_KETAL_PROTECTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d572f5ec-4de9-4f1b-9a5e-b5bb09d068cf'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACETAL_AND_KETAL_PROTECTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3010f2bf-1792-43fe-9d7a-662fe2277022'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACETAL_AND_KETAL_PROTECTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('97410c0f-107d-4955-86ea-3955d0747ef9'::uuid, (SELECT id FROM public.concepts WHERE slug = 'IMINE_AND_ENAMINE_FORMATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d0b70bd2-dc10-4fd5-96f6-cbf247ae6a3e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'IMINE_AND_ENAMINE_FORMATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('13494601-0a1b-424b-a9b4-8a3fd9984699'::uuid, (SELECT id FROM public.concepts WHERE slug = 'IMINE_AND_ENAMINE_FORMATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ce448335-3ffb-457a-bc6f-1b718de65856'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_OXIDATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('39c7ecfc-50b5-4ac2-bff5-f768eac0b785'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_OXIDATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a1563b03-c323-4be3-af59-8e5ac4a53568'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_REDUCTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('dd95cf7b-09e6-401b-bb59-4758b2e9e6cd'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_REDUCTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('05a4ca1a-5ad6-412f-ad0d-fd86f308bf62'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_REDUCTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8ed3ee2d-dbe7-449b-a7e8-3dfaedf8cefe'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALPHA_CARBON_ACIDITY_AND_ENOLATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('69bb460e-463d-49ae-9571-bbcb225a8825'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALPHA_CARBON_ACIDITY_AND_ENOLATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('86972e49-27cb-442d-88a3-4eadf621b998'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALPHA_CARBON_ACIDITY_AND_ENOLATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('76036677-5275-4b45-8a1b-a28217d5cc90'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALPHA_CARBON_ACIDITY_AND_ENOLATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('34aaa006-33be-4852-a74d-d01931750111'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALPHA_CARBON_ACIDITY_AND_ENOLATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9bd4cb9b-4314-4564-9c23-c99b722c476d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALPHA_CARBON_ACIDITY_AND_ENOLATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2d86ee9a-243e-41cc-9990-2df537f982aa'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALPHA_CARBON_ACIDITY_AND_ENOLATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6d4481e5-8ab4-43cf-bc64-c49409b305a3'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Keto-Enol Tautomerism'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e293d402-5d81-4506-8e29-cb365a1e3f79'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Keto-Enol Tautomerism'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('60bab71c-6e4c-46c8-8d25-3c3b64cb34cb'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Keto-Enol Tautomerism'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d8bfa8fc-ac30-4731-bcbb-54a00645cd43'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Keto-Enol Tautomerism'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cea432fe-ad55-4474-a9b7-3b9818cccb40'::uuid, (SELECT id FROM public.concepts WHERE slug = 'MICHAEL_ADDITION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9e93c424-854e-4c0f-9d87-72e3f1097033'::uuid, (SELECT id FROM public.concepts WHERE slug = 'KINETIC_VERSUS_THERMODYNAMIC_ENOLATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('78b4c017-6ff8-4c12-b405-a94bc780f762'::uuid, (SELECT id FROM public.concepts WHERE slug = 'KINETIC_VERSUS_THERMODYNAMIC_ENOLATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('acb69ae8-7f1e-490e-9359-6ea078916137'::uuid, (SELECT id FROM public.concepts WHERE slug = 'IMINE_AND_ENAMINE_FORMATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6a5685dd-9a44-441a-a31c-a9945ef5c9f4'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDOL_ADDITION_AND_CONDENSATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('53a02d5f-d0e7-42e8-9cde-33b169b267b0'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDOL_ADDITION_AND_CONDENSATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('93d42f3a-919a-4e50-adc4-66ec21afdfb9'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDOL_ADDITION_AND_CONDENSATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('53204377-c9c2-4a65-a23c-710d45d8f9dc'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDOL_ADDITION_AND_CONDENSATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('88340369-c995-4f4f-9afa-22afcc297eb2'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDOL_ADDITION_AND_CONDENSATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ab18f0fe-25fb-4240-a35a-886dc1b45aad'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDOL_ADDITION_AND_CONDENSATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c1417bda-afec-4dd0-9f03-6e6a99412861'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Lewis Acids & Bases'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9607337d-5d2a-4e29-99fe-fdc12c8910c1'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Lewis Acids & Bases'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('86e7f7e9-9938-4513-98e6-abfcb1ff9235'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Definitions & Conjugate Acid-Base Pairs'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('329c1d59-b9ca-4981-bd42-643f2838ac7c'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Definitions & Conjugate Acid-Base Pairs'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('aacc1d5a-c25b-4612-8cc4-a97ebce3523c'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Strong vs Weak Acids/Bases; Ka and Kb'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('52ea443d-8daf-40bf-89e2-ea89abe377d7'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Strong vs Weak Acids/Bases; Ka and Kb'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ee8e5c2b-afc1-42b1-a5ea-34d892be2434'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACIDITY_OF_ORGANIC_FUNCTIONAL_GROUPS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('114b4d7e-3bf1-471c-965c-9b553d981789'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACIDITY_OF_ORGANIC_FUNCTIONAL_GROUPS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('200a37a9-ae28-4234-b2a8-a60f172b1fd9'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ACIDITY_OF_ORGANIC_FUNCTIONAL_GROUPS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6a3ff37a-0387-4d9d-954e-aec90b82d1ea'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILICITY_AND_ELECTROPHILICITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ab46cf94-0793-4dac-bfe4-6a8b298bd4d8'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILICITY_AND_ELECTROPHILICITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d86fe6a1-d583-4f75-b0f4-cde1ba4b7274'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILICITY_AND_ELECTROPHILICITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3d6f492a-6180-4e85-8395-ec1891d853db'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILICITY_AND_ELECTROPHILICITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('7b60a211-0dac-4d01-9eb1-a4ca35dbe010'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILICITY_AND_ELECTROPHILICITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0ff33270-2225-4444-9436-11c303f863a5'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILICITY_AND_ELECTROPHILICITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('84dcf344-9050-4c95-b5a5-2e65b30a38e1'::uuid, (SELECT id FROM public.concepts WHERE slug = 'LEAVING_GROUPS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1cadbfad-ef97-4aae-91c6-5defc0564000'::uuid, (SELECT id FROM public.concepts WHERE slug = 'LEAVING_GROUPS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('13dd27d1-8095-43ad-8aac-0031f7e81439'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('04f35908-3ac4-4ffc-aa13-c3a2db722fb8'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('02c87afe-7521-475c-8b37-44219930e81e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e170e6e7-ff2d-4259-8560-5b49096b5454'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('97dd0a5c-c1a5-4a01-a0e7-c84f37849268'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2ec209b0-9e6b-4ac1-838c-9ee2ee14ae34'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5a8b5dbf-3c4c-4717-bc1d-fc07a874060d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a94a8403-5573-4eb8-aec4-2a3ccbf6d410'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_SUBSTITUTION_SN1_SN2'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('371c35f1-b554-4eea-b80e-f43cb35085fb'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Oxidation/Reduction & Identifying Agents'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('f82a836e-05ef-4a75-89ce-5e2a27b25fed'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Oxidation/Reduction & Identifying Agents'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('66aaa666-3345-4d1b-bab5-d6c0711f4ee0'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBON_OXIDATION_STATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('96f30001-d916-4e29-bbb0-5484e2cf741b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBON_OXIDATION_STATES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('891c336f-7d2e-4886-a3d1-c1a92946483e'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Common Oxidizing & Reducing Agents'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('963044e1-ed89-4dc3-913c-3b0af7ed97a2'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Common Oxidizing & Reducing Agents'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cfa9036b-d0d8-4706-9c5d-bd106cc623ba'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CHEMOSELECTIVITY_AND_PROTECTING_GROUPS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c271a1d9-7ba7-46f8-8a73-34516ebefac8'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CHEMOSELECTIVITY_AND_PROTECTING_GROUPS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('acabc779-1e51-4116-a318-3c3662c94456'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a93a6f48-914f-4268-a7f2-5dfc7b32ee45'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5bce76fd-d144-467d-896b-813081f30776'::uuid, (SELECT id FROM public.concepts WHERE slug = 'RO_REACTION_MECHANISM_ANALYSIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('62b0f069-1a77-42d7-a99b-1c7bac0650dc'::uuid, (SELECT id FROM public.concepts WHERE slug = 'STEREOSPECIFICITY_AND_STEREOSELECTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('670951c1-8bc6-4ea4-8b7f-27ab82cbe21d'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Quantum Model & Quantum Numbers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cd50f9bf-9d76-457a-9c42-4fdb8bb510b8'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Quantum Model & Quantum Numbers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a00ca793-5d60-4c65-9530-76f609779ec5'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Quantum Model & Quantum Numbers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('19ee4ae5-6ac2-4ef6-a24c-3542a50646d1'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Quantum Model & Quantum Numbers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0d1fdc7a-7ad3-4d8a-a61c-b0f8ab19280e'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Quantum Model & Quantum Numbers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cb788a21-60b5-4b0c-a773-1aacee6f2241'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Quantum Model & Quantum Numbers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4f15a994-d219-4875-a8dd-b9698f34882c'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Quantum Model & Quantum Numbers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('7d900619-40f1-4f32-ad7a-37878c1c959e'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Quantum Model & Quantum Numbers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5de2167a-d515-40fd-96df-99cac150d1c4'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Quantum Model & Quantum Numbers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('fb19cd72-b63b-4b5a-bc85-af2698482e60'::uuid, (SELECT id FROM public.concepts WHERE slug = 'MOLECULAR_ORBITAL_THEORY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('47860604-3e8a-4be3-9109-d4cdba97c26a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'MOLECULAR_ORBITAL_THEORY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ac092d22-0677-46e9-b668-73d58cd033d2'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5bf0560b-c037-4f25-a5cf-189fd161149d'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('f2e8db61-60dc-485c-a1c4-e01bed785df9'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('573787c6-008e-443f-b88c-1019722072da'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1cf531c4-cafa-4bcc-8dfa-4779961d8755'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d97a41b8-de09-4078-95db-4c07616aa242'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e5a77192-0f7a-4875-8825-a53a73a6b10f'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3229b66f-a904-484a-a104-ddff36ab3ca8'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e8d1c714-de34-441e-96d2-7542a8d156bc'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('59197799-11a7-41ac-bf1c-501ae13bb63c'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1485496c-7c85-4aa5-891e-ba3bc054ef73'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ae73e798-6e28-4932-bd7e-fb7dda6e1992'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Sigma/Pi Bonds & Hybridization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('f452fb0b-fffc-4f17-a8c4-d2b874825811'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Bond Length & Bond Energy'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('66062cbf-3a8e-459c-87f1-c02b5eab9157'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Bond Length & Bond Energy'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ddd8a213-1559-4953-92f6-305be384227a'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Resonance & Delocalization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cfe689cc-45af-41f5-834c-961d749ee54f'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Resonance & Delocalization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ec1a2288-afb4-4710-b688-7b63f7ad947c'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Resonance & Delocalization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('601c7ea8-6589-46db-a40d-18ac3ccfac2d'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Resonance & Delocalization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('7553f776-650b-41cd-bbf0-0b752106590f'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Resonance & Delocalization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('f7b15bca-4020-4638-a34a-5fe7d42fecd1'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Resonance & Delocalization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ff6e71c1-8fc3-4a06-bfc7-fabe0d950334'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Resonance & Delocalization'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('976b10b9-5b06-4714-ba50-9b96d699e738'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CONDENSATION_REACTIONS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('de93b31b-a201-420f-962a-7a1750061729'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('25ed79cf-7807-40d1-b368-c54102a53eb4'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d0c62f8b-dbb8-47ce-8ddc-73eb7e22d051'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8e412754-4b1f-402a-8581-862ed583dbd8'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('79b8993d-dbc3-440a-88c4-7742383e6c41'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3bd91e59-e378-43b4-82df-b7b8be9a9338'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3c108b32-15db-483d-b7af-8f0e4310ad2e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('636aae18-1dbe-44e8-be92-2fdf8039adec'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ESTERS_AND_LACTONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('aa2f1e55-3912-4dae-b57d-34bdd02f9ecb'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ESTERS_AND_LACTONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b5a52fcf-24b6-47b8-9773-095201c07d05'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ESTERS_AND_LACTONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cfc3ab8d-2d60-4599-924d-01b319957751'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ESTERS_AND_LACTONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('963e5256-f74d-4be3-b35c-491aea76beca'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ANHYDRIDES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3ab70a5e-cfbd-4c41-8ef2-a5207d798dde'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ANHYDRIDES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('164ff97c-4d2e-46f1-8530-2c85dadb2bea'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ANHYDRIDES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('eab4e8eb-c341-465b-8d75-a786b5e6e3fd'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ANHYDRIDES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c06a6e79-9236-45a8-9643-a9209a6494af'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ANHYDRIDES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('397e5110-ced2-4bbb-82b0-9cbcd0aa50ae'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ANHYDRIDES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2c069c73-592d-4291-a9b2-07a19546e73e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_DERIVATIVE_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0eff7805-d8be-44e9-8f4a-7cd0f44334b6'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_DERIVATIVE_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ce4ac798-c5bb-4ee0-bbba-4069d34981a6'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_DERIVATIVE_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ecc99b76-fd55-44ed-95d5-40c20868a775'::uuid, (SELECT id FROM public.concepts WHERE slug = 'STERIC_AND_ELECTRONIC_EFFECTS_ON_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2c57a539-df93-439c-9c9a-9db554b7c3ab'::uuid, (SELECT id FROM public.concepts WHERE slug = 'STERIC_AND_ELECTRONIC_EFFECTS_ON_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1f35235e-5c6a-4959-a1c0-c0fbd4553648'::uuid, (SELECT id FROM public.concepts WHERE slug = 'STERIC_AND_ELECTRONIC_EFFECTS_ON_REACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0e25f3d5-5145-42d3-955f-e5a09ee26626'::uuid, (SELECT id FROM public.concepts WHERE slug = 'BETA_LACTAMS_AND_RING_STRAIN'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d8471d14-34d4-4019-a3f8-a159cff26f4f'::uuid, (SELECT id FROM public.concepts WHERE slug = 'BETA_LACTAMS_AND_RING_STRAIN'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3d297969-6986-43d7-87ad-76fae062c5f8'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_ACYL_SUBSTITUTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8195cfc5-89cd-4628-a55b-7f50ba6bd5a7'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_ACYL_SUBSTITUTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('32c3b369-a813-4f52-aa1a-5688b3ef82e9'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('806bffaa-e2f3-41a4-bb89-d673864eaf02'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('efd354ee-8aaa-41be-825f-6cf48fbbbd11'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('bdeff1a8-3cf4-45ef-a491-64843c902c43'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_PHYSICAL_PROPERTIES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6ee3e7c8-9b92-4574-8b39-4a96f691d795'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_PHYSICAL_PROPERTIES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('79e3262f-7352-4f3a-869c-d3d71db655d0'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_ACIDITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('43aa1974-cd81-4120-a34e-75ef9313de63'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_ACIDITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9ffffcee-7100-4690-954a-d6472d540829'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_ACIDITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5aebd562-e989-4b3f-8033-e8aec3606d07'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_ACIDITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2fc9bd14-16e8-45e0-865b-9e92459a376e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_ACIDITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cbb39cd3-e25f-4a6d-8e4c-1c201f4d9a2f'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_OXIDATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ac396e7e-ca30-445c-b7eb-85e91cb4b18c'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_ACYL_SUBSTITUTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('096c1bd7-fb3f-441e-a9df-6081a883dd1b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NUCLEOPHILIC_ACYL_SUBSTITUTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0581930d-8ee4-47c5-980a-0e52ade46ff3'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ed3a2750-e58a-426d-9af2-f5534ace0993'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4f4d310a-48b2-4e80-acc2-c420d7853425'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('25ec80c1-90a6-4d5c-bb67-ac7d852e7bd1'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ESTERS_AND_LACTONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3287f03f-a59b-4af0-87c1-c52d32575713'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ESTERS_AND_LACTONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3224245f-1114-4521-9e7a-00aa5a185ffe'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ESTERS_AND_LACTONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('70a23512-6844-49f7-b2cf-9e728750dd41'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ANHYDRIDES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('49963028-3de4-4e27-aa2b-38b6b57fd5d5'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBONYL_REDUCTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9a71bf91-644a-40c6-88b4-940b19988b06'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DECARBOXYLATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a54412c2-dfed-46de-ba10-0b9f5c00fb66'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DECARBOXYLATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('fba3c092-fe80-421d-b8b5-54e2cb6e8874'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Saponification and Soaps'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4f3acfeb-9e17-4eb1-b909-70bc58ae8ee0'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Saponification and Soaps'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d6976b3c-82a0-4ca5-a647-8b74d6c7f1ec'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Amphipathicity and Micelle Formation'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ec2b7793-8e03-45f5-9b49-67088bca20fa'::uuid, (SELECT id FROM public.concepts WHERE slug = 'HELL_VOLHARD_ZELINSKII_REACTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1d656e25-e5ca-42a3-afec-f56a604ddd9e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ISOMER_CLASSIFICATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8218e45f-abd5-4e5e-9348-4b72916dc9f3'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ISOMER_CLASSIFICATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5e2bcae1-341c-4e61-baba-f93afad3f918'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ISOMER_CLASSIFICATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ca5ce960-5ed3-444f-b5c3-7f7c78e0ae83'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ISOMER_CLASSIFICATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6b639a6e-dd33-4503-a839-cb604ef9d3d7'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ISOMER_CLASSIFICATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cae193a3-6be2-4cae-9b89-d0a7be00a3f9'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CONFORMATIONAL_ANALYSIS_NEWMAN_PROJECTIONS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('fbf70061-78c0-4c04-80bf-37ab5e77b1c8'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CONFORMATIONAL_ANALYSIS_NEWMAN_PROJECTIONS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('98b12b73-0c09-4e1b-afec-3074a78f7aea'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CONFORMATIONAL_ANALYSIS_NEWMAN_PROJECTIONS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ada6ff9d-3730-43ea-b711-f99f6a759601'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CONFORMATIONAL_ANALYSIS_NEWMAN_PROJECTIONS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c92b0de0-db9f-440f-869f-e7eeb5a5e8a7'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CONFORMATIONAL_ANALYSIS_NEWMAN_PROJECTIONS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6be178c0-f513-4c7a-83cf-597458fa6d9c'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('63385a49-8ba1-43b6-ba15-4b7b4d9b2597'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('bc3806d4-4622-4238-abe5-f76e47943a95'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0feb3450-1a52-4015-813e-38bf440dd8df'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('863c12b3-c2fe-430a-9f4a-79fd02b014c3'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('895cd87b-5c0f-4520-a452-8d2c3282aff3'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('aa1a6498-1aaf-4c97-9412-8e6c8fe797f9'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ec7aceb7-3ebf-41cd-b217-833db56f00d4'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CYCLOHEXANE_CONFORMATIONS_AND_RING_STRAIN'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('89965f67-ea31-41e1-8fc4-6f13d6fa31c9'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CHIRALITY_AND_STEREOCENTERS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('7ef715f8-c8d7-4906-b479-c691d88f46e2'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CHIRALITY_AND_STEREOCENTERS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9c84024a-2c04-4e6a-9145-2e63ad7a8fef'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CHIRALITY_AND_STEREOCENTERS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('46f27f0b-769e-4ebd-8ff1-25942c3f0a27'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CHIRALITY_AND_STEREOCENTERS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('f212547b-3d4f-4f5f-bf36-be4510a87908'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ENANTIOMERS_AND_OPTICAL_ACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8172070f-f864-4e24-a555-147d1c77dea2'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ENANTIOMERS_AND_OPTICAL_ACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d9904cf0-02ff-42cd-abe3-4548a5b0c1e9'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ENANTIOMERS_AND_OPTICAL_ACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('85097aa7-be30-4d62-8b3e-1a394a6e0610'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ENANTIOMERS_AND_OPTICAL_ACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6b06bf6a-6c37-435c-bff7-1d37b57d987a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ENANTIOMERS_AND_OPTICAL_ACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a3843655-c5a6-463b-96b3-7e175f49a7fc'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ENANTIOMERS_AND_OPTICAL_ACTIVITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('97c06b5d-cf2f-4059-a42b-3f92910fd845'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DIASTEREOMERS_AND_MESO_COMPOUNDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ccbf8770-7f63-4811-accb-04fc65d20c7a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DIASTEREOMERS_AND_MESO_COMPOUNDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('87b7b62a-568c-4ad9-bb0c-294697910f68'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DIASTEREOMERS_AND_MESO_COMPOUNDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4c1514a8-3d80-4ce2-a026-dc14a7db805a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DIASTEREOMERS_AND_MESO_COMPOUNDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4619304e-28e7-4cba-a371-f64ca9e25a66'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DIASTEREOMERS_AND_MESO_COMPOUNDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e1d1344f-e820-44e2-8c3c-4980308d2640'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DIASTEREOMERS_AND_MESO_COMPOUNDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0d9f62d7-1c06-44f4-b00d-33cc2abe171b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DIASTEREOMERS_AND_MESO_COMPOUNDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d22a030e-73b8-4444-9db3-f9d449abddb3'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a4044556-1a0f-46cc-9619-b25a6ce04b29'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('883d2267-b5ba-4ae5-a5a6-87ac7ce7eff3'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b8f1fb73-2b10-40f0-b90e-6182d49732be'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('df91098a-d445-4e01-b429-6f0b22cadf78'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('320cf115-6388-4101-ad38-ae94a7315982'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('75903915-cf7b-4f6b-a323-d31cf7cc681c'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('068e33cf-bc4d-44e2-a72f-55d956db8275'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('13cee5eb-1991-464a-a352-4973603c99ee'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ABSOLUTE_CONFIGURATION_CIP_RS_FISCHER'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('f704d736-def2-4677-abd4-bb289bfb25c2'::uuid, (SELECT id FROM public.concepts WHERE slug = 'IUPAC_NAMING_SYSTEM'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('f5dc5e93-95c6-43a7-a935-1a886b51a3f0'::uuid, (SELECT id FROM public.concepts WHERE slug = 'IUPAC_NAMING_SYSTEM'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e1696031-6013-47e7-9cd3-99efdf72e2c7'::uuid, (SELECT id FROM public.concepts WHERE slug = 'IUPAC_NAMING_SYSTEM'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5d60b453-de61-4101-898a-6f1701994128'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PARENT_CHAIN_SELECTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('fc388bc5-981c-48a9-891d-cfa52b704499'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PARENT_CHAIN_SELECTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('abb8dd0e-d331-46f9-8934-2db299fd14de'::uuid, (SELECT id FROM public.concepts WHERE slug = 'FUNCTIONAL_GROUP_PRIORITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('7dd508f8-be6c-4a46-b12f-df7ba05f0a2a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'FUNCTIONAL_GROUP_PRIORITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0fbc876a-0b35-44eb-a9f5-180c6ab9cd43'::uuid, (SELECT id FROM public.concepts WHERE slug = 'FUNCTIONAL_GROUP_PRIORITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8b8bb29b-abe1-4ac1-8041-187493fcc27f'::uuid, (SELECT id FROM public.concepts WHERE slug = 'FUNCTIONAL_GROUP_PRIORITY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4eec8157-d9af-49bd-8dd4-d0d54ca14f85'::uuid, (SELECT id FROM public.concepts WHERE slug = 'LOCANT_NUMBERING_RULES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c9d05eb1-2961-4872-81ea-d96b1725940c'::uuid, (SELECT id FROM public.concepts WHERE slug = 'LOCANT_NUMBERING_RULES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1f93a306-f335-422b-933f-80f2aaf08919'::uuid, (SELECT id FROM public.concepts WHERE slug = 'LOCANT_NUMBERING_RULES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d2e76daa-909f-46d1-bd52-1fa1c2983b1a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'SUBSTITUENT_NAMING'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('7f0ea9d7-79ad-416f-a161-d19205bf6fb1'::uuid, (SELECT id FROM public.concepts WHERE slug = 'SUBSTITUENT_NAMING'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('7644fbb6-a177-47e6-be44-129a96c7f97f'::uuid, (SELECT id FROM public.concepts WHERE slug = 'SUBSTITUENT_NAMING'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3ceae1ce-3720-4a35-a891-d44184544878'::uuid, (SELECT id FROM public.concepts WHERE slug = 'SUBSTITUENT_NAMING'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1a86a5f6-a155-4e53-82a5-ae2673e9a8fd'::uuid, (SELECT id FROM public.concepts WHERE slug = 'SUBSTITUENT_NAMING'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8b4a36cd-90cb-491c-9e1c-a448ab256f56'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALKANE_ALKENE_ALKYNE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cf26a4b7-1420-423f-851e-a92e23571de9'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALKANE_ALKENE_ALKYNE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ee464815-5707-4637-b637-8d9f48208992'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALKANE_ALKENE_ALKYNE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1c8762d3-798d-4fd5-a9ba-5b0c924d97a8'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALKANE_ALKENE_ALKYNE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4486d2fd-06bd-4eca-8f2f-f00ca2f2a9fe'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9d759a44-18ee-434c-8b04-f54b3f01cf9b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('25706b6d-25ef-4736-9b54-53bbab0c7c6b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ca7c35cf-cd8d-45bf-9e3b-0dc679f180e0'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e1388a68-3e7a-45c2-9ea5-8eab42b29d19'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALCOHOLS_AND_PHENOLS_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cce4d0d2-626b-41c4-b465-3e45fd35319a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('131d03af-a487-4e8b-8aff-8d3b06607c23'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('921f8706-6893-433e-9e39-8998b4ed4adb'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a967465c-5ac4-4352-b839-7a9dbd4fb4aa'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ALDEHYDE_AND_KETONE_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3791cb24-a546-4955-9250-2f44ff941e2b'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Common Names & Carbonyl Structure'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('f27195a6-86ef-4fb8-856a-15a67db25605'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Common Names & Carbonyl Structure'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b41e0ca5-3d2f-46bc-9d4f-e0593a6edacc'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Common Names & Carbonyl Structure'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c2eb6f37-2174-414e-8530-9b15782dd5cf'::uuid, (SELECT id FROM public.concepts WHERE slug = 'CARBOXYLIC_ACID_STRUCTURE_NOMENCLATURE'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('01cbd85e-daf4-422c-9f76-0b9f08cdf15f'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ESTERS_AND_LACTONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('de76adc8-03ae-4a4d-ae7f-b51e06cf9d14'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ESTERS_AND_LACTONES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('78bfe7f4-a88e-4562-8e3d-f286e285a178'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3bee7acd-fe18-4cc9-92c2-986e560162f7'::uuid, (SELECT id FROM public.concepts WHERE slug = 'AMIDES_AND_LACTAMS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4c469b8b-783b-48ae-8f82-e0f0721c283d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ANHYDRIDES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('dc55baad-92c5-48b6-954e-871823f14a69'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ANHYDRIDES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('14518f8e-64d7-465b-9a60-965af7759c43'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Amino Acid Structure & Stereochemistry'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('bb776d6c-91db-4eab-8679-acd9e56fee54'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Amino Acid Structure & Stereochemistry'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e2be38a5-d60f-4779-9b2c-b7209804cf07'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Amino Acid Structure & Stereochemistry'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('995b9a00-f394-4d93-8aff-16feb6298107'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Amino Acid Structure & Stereochemistry'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4e51e5d1-3738-4181-9472-6f5a386ad7b1'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Zwitterions & Titration Curves'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2fae8b13-b25e-46e2-ae5d-c84d9cf2a2eb'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Zwitterions & Titration Curves'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('48188be8-8b6f-43c7-9f4e-cb36452b4d86'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Zwitterions & Titration Curves'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2766eaa9-1b52-4a44-92bf-c5cc364c7b27'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Zwitterions & Titration Curves'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2b2f52eb-92c8-4e7c-a94b-1b81eedcb92b'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Side-Chain Classification'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d3b2730a-43ff-4886-90fb-368420a754ca'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Side-Chain Classification'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('7d7203b0-e5c4-44bd-a70c-2447d48071e3'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Side-Chain Classification'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('957e5de6-4cfd-4f2f-89d6-69fb161d5516'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Side-Chain Classification'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('f9e2d2ab-6bbf-41ad-b462-270f3ead6ece'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Side-Chain Classification'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4e3a3419-d862-4bab-8e3f-a2ef169d91b4'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Side-Chain Classification'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3e23a2e6-b642-4734-8e4a-bfebf0cec887'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Side-Chain Classification'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('596d441d-8e76-4e1a-8192-1026055e3fd4'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Peptide Bond Formation & Hydrolysis'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a7295199-867c-4d2e-a82b-5da9c4f8de11'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Peptide Bond Formation & Hydrolysis'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('44091036-13a6-4c00-bfd7-cfe207ee47cc'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Peptide Bond Formation & Hydrolysis'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b932ab26-bd07-4d16-b691-f39d0804cd28'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Peptide Bond Formation & Hydrolysis'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e7e93648-c6df-44c8-9cf1-04b37699b91c'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Peptide Bond Formation & Hydrolysis'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1cb06b5d-84bf-45a8-b3b6-ce85e28a2e4d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'STRECKER_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9519966f-4e6c-4d47-a62a-4248e4414152'::uuid, (SELECT id FROM public.concepts WHERE slug = 'STRECKER_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('171aad42-9ea2-44f0-9dda-c6fe1e74c148'::uuid, (SELECT id FROM public.concepts WHERE slug = 'STRECKER_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('dcf656aa-1489-4c7d-b28c-1cbc53638c50'::uuid, (SELECT id FROM public.concepts WHERE slug = 'STRECKER_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6d2ebfb7-1834-40da-a3c3-9d902a35cdcd'::uuid, (SELECT id FROM public.concepts WHERE slug = 'STRECKER_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3722b162-1aaf-46c7-b7f3-8796368e083d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'STRECKER_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('26ae89a1-55c3-4ce0-ab84-378dc1fd36c4'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d824c1c8-296e-48bc-b2c9-23f6aeadb420'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('bfeabae2-c4f5-417a-a318-170b09622557'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('02c0c5e9-3373-4038-a161-50cd56261711'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d91ece54-8d67-405e-b350-6446442cc609'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('088d11e1-3175-4f34-8e7b-b1704fe68754'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('39f4f76d-f447-41b0-8eb2-49f21aff1f78'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('87861521-cb60-44ac-a88a-7baac0c503f5'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ff87c8d0-f032-49f8-94a3-98450074f117'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b795914a-5b0f-4329-97f4-05b6498255a1'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a26d50c9-47fe-4de3-8b9f-d0b316e3221b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GABRIEL_SYNTHESIS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('7db4366e-d42b-4228-90a0-b2f0df980cc0'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PHOSPHORIC_ACID_AND_PHOSPHATE_BUFFERS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c077bd1c-2045-4176-adf3-738734e6a503'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PHOSPHORIC_ACID_AND_PHOSPHATE_BUFFERS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('261a6b65-2c3f-4120-814b-5e1df6a01650'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PHOSPHORIC_ACID_AND_PHOSPHATE_BUFFERS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b08b6ebd-6005-4fce-8dd3-cbf0f9eed0bc'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PHOSPHORIC_ACID_AND_PHOSPHATE_BUFFERS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2c0a10b3-70de-4bb7-b314-55b1d20cb4bf'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PHOSPHORIC_ACID_AND_PHOSPHATE_BUFFERS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cccdca5f-7ef2-46c4-8f45-cbe18741c4df'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PHOSPHORIC_ACID_AND_PHOSPHATE_BUFFERS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8593fb95-a02f-4365-9351-687222212f16'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PHOSPHATE_ESTERS_AND_ANHYDRIDE_BONDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8e821bd2-cc4a-4f73-9e35-8d9cd8f2cc47'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PHOSPHATE_ESTERS_AND_ANHYDRIDE_BONDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5eb640fc-1d90-4d49-928c-b796b2a38baa'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PHOSPHATE_ESTERS_AND_ANHYDRIDE_BONDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('315e57c3-5ec4-4ad9-8536-633e6f4af40e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'PHOSPHATE_ESTERS_AND_ANHYDRIDE_BONDS'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('12fc75b8-91b4-411e-9e5d-9fc86404bc55'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'ATP & High-Energy Carriers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b6c51c24-aa2c-489d-89c9-c8dbef2ded21'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'ATP & High-Energy Carriers'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0b45e857-ff34-4d08-97ec-7a0cd51f8c9d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'EXTRACTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d78692c0-7122-4634-992d-15f194e852dc'::uuid, (SELECT id FROM public.concepts WHERE slug = 'EXTRACTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6cff16af-42de-4b68-8a75-357775f255c5'::uuid, (SELECT id FROM public.concepts WHERE slug = 'EXTRACTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('068597f1-f642-4892-9925-9a2ced63aefc'::uuid, (SELECT id FROM public.concepts WHERE slug = 'EXTRACTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2589968d-8876-4785-9b29-c42eff4df37b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'EXTRACTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4bda0236-75fe-4fb9-aaf9-d883248446fa'::uuid, (SELECT id FROM public.concepts WHERE slug = 'EXTRACTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('66b4beb9-fe56-4edd-bf62-563a7023bf06'::uuid, (SELECT id FROM public.concepts WHERE slug = 'EXTRACTION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('50489799-7905-4d91-a5ba-4246e3b40fdb'::uuid, (SELECT id FROM public.concepts WHERE slug = 'FILTRATION_AND_SOLVENT_REMOVAL'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('dbe319a4-6052-475a-947b-431e709d93f5'::uuid, (SELECT id FROM public.concepts WHERE slug = 'FILTRATION_AND_SOLVENT_REMOVAL'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e15b1c7c-2880-4057-9e50-1429d554f38d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'FILTRATION_AND_SOLVENT_REMOVAL'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('881adfb4-add3-4479-940f-9399146820dd'::uuid, (SELECT id FROM public.concepts WHERE slug = 'FILTRATION_AND_SOLVENT_REMOVAL'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a959a4ae-114b-4e30-8e49-13bdfee62c38'::uuid, (SELECT id FROM public.concepts WHERE slug = 'RECRYSTALLIZATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d7ecc137-f5de-41a5-86b0-68b91820e53a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DISTILLATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b4513fd2-3d87-485d-82f8-d41af7be3921'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DISTILLATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1158badb-8e5b-4382-9495-aa44d67b7534'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DISTILLATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a2c2c416-a0f5-4a67-b74c-4b23c83730ec'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DISTILLATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('29a5be20-7c5a-42ed-be12-04a7beef491e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DISTILLATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b4bdb54f-7cc7-496d-a56a-0e445aabec92'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DISTILLATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e11980ef-741e-4be1-8561-508e9e0c0380'::uuid, (SELECT id FROM public.concepts WHERE slug = 'DISTILLATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9fe3ee39-b5ed-46e8-bb5d-1cfdd0257bac'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4be06216-3ebc-4d8b-9b4f-a99a6d004cca'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('56e5345e-f02c-4d55-9b75-39826070ce32'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0c026c28-bbad-47b5-8d49-15054fee7d90'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('38d5d49d-c378-491f-8bc8-fd47052b0711'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('00386356-7a41-46a8-9b4c-bd9ee863de59'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1e3f7a9d-769e-4f26-8843-85df85e6069f'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c082503b-4c24-44f6-80ea-e956aa577c9f'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e91ce893-753d-47e5-bcdc-4832290fb21a'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d61643e9-9c14-49a9-b677-52c9f6aa0f96'::uuid, (SELECT id FROM public.concepts WHERE slug = 'THIN_LAYER_AND_REVERSE_PHASE_CHROMATOGRAPHY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('50b23738-2af2-466e-a629-74f3f54f475d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'THIN_LAYER_AND_REVERSE_PHASE_CHROMATOGRAPHY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1df36460-2f5b-451a-b1e4-53eec96df726'::uuid, (SELECT id FROM public.concepts WHERE slug = 'THIN_LAYER_AND_REVERSE_PHASE_CHROMATOGRAPHY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d6c4c435-df5e-417d-ae06-8857708cb27b'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Ion-Exchange Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('af5c1f9a-d43f-4273-983b-eec2a732e642'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Size-Exclusion Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('128dd37f-25c8-4140-b00c-99878e25f4d3'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Affinity Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('465ac938-23ef-4c6f-a498-a0ac40c694bd'::uuid, (SELECT id FROM public.concepts WHERE canonical_name = 'Affinity Chromatography'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e0f191d0-4168-43ae-8118-810078ca4d8d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GAS_CHROMATOGRAPHY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6a334839-330b-4f31-b052-ffd195a6faec'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GAS_CHROMATOGRAPHY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9c92ecd2-fb3e-4ee1-9b32-f33f4bf7ab47'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GAS_CHROMATOGRAPHY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d0be6e13-a983-4cb8-bce1-385583c85623'::uuid, (SELECT id FROM public.concepts WHERE slug = 'GAS_CHROMATOGRAPHY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b2e1f296-03fc-4fb3-b940-4842c79e04fe'::uuid, (SELECT id FROM public.concepts WHERE slug = 'HIGH_PERFORMANCE_LIQUID_CHROMATOGRAPHY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6ab8850f-3173-45d3-aa74-31700ce2f983'::uuid, (SELECT id FROM public.concepts WHERE slug = 'HIGH_PERFORMANCE_LIQUID_CHROMATOGRAPHY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a363aef1-db6f-4fb4-9953-f836227e2398'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('77442c3b-cbc4-4ae2-bcbb-8aaf1896cc04'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('3c165994-6719-4c5e-92a1-168ad9510a20'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d10199cb-9f85-4b78-bd6f-6c23b856738e'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9e54c9af-4385-4ee5-bc99-91ecc60783cd'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2e5ab9a1-b85d-4c0d-804d-68824cfb259a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d18e4a34-0630-43a1-95cb-cdd99c8220ae'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b39d3249-855e-4cd6-8e09-f456c09472e7'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6d7eba41-10e3-4dc4-929b-78e714cabdd8'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4bdaeeed-2f6a-46f1-92ec-be7f6290fd56'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('63826247-0b29-456f-881c-306c6f334a59'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e985bba3-90a2-4c1d-84b7-dec3265e92ea'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b683f0e7-aeb2-409f-ad4f-779173368eab'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ab13a7d0-38f9-4c93-9b59-1e89ef378de5'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b1c6f99c-29fd-486f-be4a-7cc2388edc4d'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8feb9043-f9ea-4bcf-9a77-5f299e329930'::uuid, (SELECT id FROM public.concepts WHERE slug = 'INFRARED_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('dfa240b0-c56d-4b72-83a0-2722a66f4b3b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('c5f487be-699c-4bb4-a065-efd79f5bd7ca'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('055dd44c-4616-4b45-9795-6ca550af4bf1'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('9f95cb93-c988-48b5-85ed-6ad6c29fe5d3'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d70fa8f8-451f-4d9b-b534-2e918ae6ddfa'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('04bf2cc4-55e0-499f-baf9-b976614ebafe'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('5e951a3b-ba6e-47ad-8e09-597dbc5e49a6'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0a0cd2b9-581f-493e-aa1d-401e0073b45a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('cf564d47-c93e-4eec-8b9c-5c48ba0ef59b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2326f96a-9bbc-4d85-9be4-d44f2ce773ed'::uuid, (SELECT id FROM public.concepts WHERE slug = 'ULTRAVIOLET_VISIBLE_SPECTROSCOPY'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('00a2d466-9190-4153-a654-bbeafd307c39'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_PRINCIPLES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('801579e5-5163-4aff-8202-f0580a788fb6'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_PRINCIPLES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('dd434e22-c9a8-42e2-a95b-3aafef478b6a'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_PRINCIPLES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('dcf03a81-8832-4014-bf38-d14645aa7f10'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_PRINCIPLES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('a441468a-6516-408d-aa40-3aaa22f29204'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_PRINCIPLES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('745826c4-cce3-495c-baa8-32cef182d800'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_PRINCIPLES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('072ec098-2070-408d-bab0-b96e76d821a2'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_PRINCIPLES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ae363b48-b795-44c6-8ed9-48e9dc5aac49'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_PRINCIPLES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('4e062394-5d45-4535-8b57-ece5ef1acdfb'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_PRINCIPLES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('14368eb6-a103-42b4-af71-21ad9f9fc3cd'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_PRINCIPLES'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6f90b83a-d4c0-4ee7-b5e7-b718f1850ad3'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_SPIN_SPIN_COUPLING'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('e0838d1c-0973-4a37-a7bf-57136339be2c'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_SPIN_SPIN_COUPLING'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('8b8a1537-4778-4994-88af-8582fdaa3202'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_SPIN_SPIN_COUPLING'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d1cdabc0-8b33-42a5-b090-0369f5b19501'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_SPIN_SPIN_COUPLING'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('62eb6e41-44f5-41dc-b4f3-6355872031ad'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d410492d-95a9-4ce0-a822-f97540e74f4b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0cda3ac9-bc3c-4195-8b07-93a01fac07a3'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1ca33dc5-1b41-4b20-b565-d0f7ed5d05e2'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('de1fbffb-37d2-4b56-91e9-c9abac16aade'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('1deafcc9-29f7-4e3b-8ac7-db7a7128abd8'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('2d18cfa6-4226-45b0-ac69-271918e5131f'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b0bf63de-36d9-4a91-b39a-b5c11d537fbf'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('b64d859c-4380-4609-85e8-610560c2760b'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('ee19eecc-9605-4bc7-b019-d58d5e742509'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('6de46e32-d036-428d-a68e-7f9eb58a71af'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('d6e8c6a8-2f88-4e1e-ba4e-52b699f6cf1f'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('777868e2-abd3-4a9c-adb4-6a03b85588c2'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'),
  ('0c4a7ab6-74ee-4d91-b3e0-5ad3a4224869'::uuid, (SELECT id FROM public.concepts WHERE slug = 'NMR_CHEMICAL_SHIFT_AND_INTEGRATION'), 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED');

-- ────────────────────────────────────────────────────────────
-- 5. Verification, inside the transaction. Anything unexpected here should be
--    a reason to ROLLBACK rather than COMMIT.
-- ────────────────────────────────────────────────────────────
SELECT
  (SELECT count(*) FROM public.concepts)                                      AS objects,        -- 705
  (SELECT count(*) FROM public.concepts WHERE object_type = 'CONTENT')        AS content,        -- 677
  (SELECT count(*) FROM public.concepts WHERE object_type = 'REASONING')      AS reasoning,      -- 12
  (SELECT count(*) FROM public.concepts WHERE object_type = 'QUANTITATIVE')   AS quantitative,   -- 16
  (SELECT count(*) FROM public.flashcard_concepts)                            AS card_mappings,  -- 739
  (SELECT count(*) FROM public.question_concepts)                             AS question_mappings; -- 2659 unchanged

-- Every organic chemistry card mapped exactly once. Expect 425 and 0.
SELECT count(*) AS ochem_cards_mapped, count(*) FILTER (WHERE n <> 1) AS not_exactly_one
FROM (
  SELECT f.id, count(fc.concept_id) AS n
  FROM public.flashcards f
  JOIN public.flashcard_decks d ON d.id = f.deck_id AND d.section = 'organic_chemistry'
  LEFT JOIN public.flashcard_concepts fc ON fc.flashcard_id = f.id
  GROUP BY f.id
) t;

-- No mapping overstates its provenance. Expect zero rows.
SELECT 'provenance overstated' AS problem, count(*)
FROM public.flashcard_concepts
WHERE mapping_status = 'HUMAN_VALIDATED' OR source IN ('DETERMINISTIC','DETERMINISTIC_EXACT','LEGACY_EXACT');

-- The reasoning object carries no content taxonomy. Expect zero rows.
SELECT 'reasoning object carries taxonomy' AS problem, c.slug
FROM public.concepts c
WHERE c.object_type <> 'CONTENT' AND (
  EXISTS (SELECT 1 FROM public.concept_sections s WHERE s.concept_id = c.id) OR
  EXISTS (SELECT 1 FROM public.concept_disciplines d WHERE d.concept_id = c.id) OR
  EXISTS (SELECT 1 FROM public.concept_content_categories k WHERE k.concept_id = c.id));

-- The widening in section 3 actually landed. ON CONFLICT DO NOTHING is there to
-- make the migration re-runnable, but it can also hide a row that was rejected,
-- so the counts are asserted rather than assumed. Expect 12, 10, 8.
SELECT
  (SELECT count(*) FROM public.concept_sections cs JOIN public.concepts c ON c.id = cs.concept_id
     WHERE cs.section_code = 'CHEM_PHYS' AND cs.is_primary = FALSE)                       AS widened_sections,
  (SELECT count(*) FROM public.concept_disciplines cd
     WHERE cd.discipline_code = 'ORGANIC_CHEMISTRY' AND cd.role = 'SECONDARY')            AS widened_disciplines,
  (SELECT count(*) FROM public.concept_content_categories cc
     WHERE cc.content_category = 'Structure, function, and reactivity of biologically relevant molecules'
       AND cc.is_primary = FALSE)                                                          AS widened_categories;

-- Nothing resolved to NULL. Expect zero rows.
SELECT 'unresolved concept' AS problem, count(*) FROM public.flashcard_concepts WHERE concept_id IS NULL;

COMMIT;

-- ── ROLLBACK ────────────────────────────────────────────────────────────
-- DELETE FROM public.flashcard_concepts fc USING public.flashcards f, public.flashcard_decks d
--   WHERE fc.flashcard_id = f.id AND f.deck_id = d.id AND d.section = 'organic_chemistry';
-- DELETE FROM public.concepts WHERE slug IN (the 68 slugs above);  -- taxonomy rows cascade
-- The widening in section 3 is additive and safe to leave, or delete the
-- CHEM_PHYS / ORGANIC_CHEMISTRY / 5D rows added to the named concepts.
