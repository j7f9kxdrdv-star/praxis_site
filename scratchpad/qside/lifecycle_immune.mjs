// Lifecycle decision per old immune label.
//
// B, C and D all MERGE_TO their durable concept: repoint the question, deprecate
// the label with deprecated_by pointing at the successor. Nothing is deleted.
//
// The ten class A labels are decided one at a time, because "legitimate
// sub-objective" and "synonym of the durable concept" look alike from a name.
// A synonym MERGES. A genuine narrower facet is RETAINED, keeps its evidence as
// a SECONDARY mapping on the same question, and is flagged for the hierarchy
// review the ontology cannot express yet (parent_concept_id is null on all
// 1,127 objects, though the database guard already supports SUBCONCEPT).
export const A_DECISIONS = {
 "Skin as a Physical Barrier":
  {action:"RETAIN_AS_SUBOBJECTIVE_NEEDS_HIERARCHY_REVIEW", why:"A named barrier with its own testable properties (keratinised, dry, acidic surface). Narrower than Surface Barriers to Infection, not a synonym of it."},
 "Gastric Acid as a Chemical Barrier":
  {action:"RETAIN_AS_SUBOBJECTIVE_NEEDS_HIERARCHY_REVIEW", why:"Same shape as the skin label: one specific barrier with its own mechanism and its own failure mode when pH rises."},
 "Colonization Resistance by Resident Flora":
  {action:"RETAIN_AS_SUBOBJECTIVE_NEEDS_HIERARCHY_REVIEW", why:"A real and separately named phenomenon. A student can know the physical and chemical barriers and still not know that resident flora compete with invaders."},
 "Chemotaxis and Gradient Sensing":
  {action:"RETAIN_AS_SUBOBJECTIVE_NEEDS_HIERARCHY_REVIEW", why:"Standard terminology for a mechanism that is narrower than Phagocytes and Granulocytes and is examined on its own."},
 "Epitope Size and Response Diversity":
  {action:"RETAIN_AS_SUBOBJECTIVE_NEEDS_HIERARCHY_REVIEW", why:"Epitope multiplicity on one large antigen, and the polyclonal response that follows, is a distinct inference from what an epitope is."},
 "Population Value of MHC Allele Diversity":
  {action:"RETAIN_AS_SUBOBJECTIVE_NEEDS_HIERARCHY_REVIEW", why:"MHC polymorphism at the population level is a separate objective from how MHC presents peptide to T cells."},
 "Origin of B Lineage Binding Diversity":
  {action:"MERGE_TO", why:"Not a sub-objective. Generating B-cell receptor diversity IS what B Cell Activation and Antibody Diversity names. Retaining it would be two objects for one idea."},
 "Selection Versus Instruction by Antigen":
  {action:"MERGE_TO", why:"This is the clonal selection theory itself, which is the durable concept's whole subject. A synonym, not a facet."},
 "Two Screens During Lymphocyte Maturation":
  {action:"MERGE_TO", why:"The two screens ARE positive and negative selection, which is precisely Thymic Selection and Self-Tolerance."},
 "Two Site Design of Lymphocyte Production":
  {action:"MERGE_TO", why:"Marrow and thymus as the two production sites is the primary-lymphoid-organ content already named by Leukocyte Lineages and Lymphoid Organs."},
};

// Aliases. mergeConcepts() adds the loser's name as an alias by default, which
// is right for a real term and wrong for question prose. "Gastric Acid as a
// Chemical Barrier" is worth finding by search; "Why A Coated Organism Is The
// One That Overwhelms" is a question stem, and 79 of those would turn the alias
// table into a scenario index. deprecated_by already preserves the lineage, so
// nothing is lost by declining the alias.
export const ALIAS_WORTHY = new Set([
 "Origin of B Lineage Binding Diversity",
 "Selection Versus Instruction by Antigen",
 "Two Screens During Lymphocyte Maturation",
 "Two Site Design of Lymphocyte Production",
]);
