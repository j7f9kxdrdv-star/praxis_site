// The immune curriculum reconciliation design. Validated against live data by
// validate.mjs before any of it is reported or seeded. Card positions are
// 1-based within The Immune System deck's 76 UNMAPPED cards.

// 19 proposed CONTENT concepts. `q` lists the existing immune labels whose
// question tests the SAME learning objective; `exact` says whether that
// question's objective is the concept itself (true) or merely related (false).
export const PROPOSED = [
 {name:"Innate versus Adaptive Immunity", cards:[1,2,3], conf:"HIGH",
  def:"The two arms of the immune response contrasted by speed, specificity and the formation of lasting memory.",
  q:[["Defence Timeline After a Breach",true],["Constitutive Plasma Defenses Versus Induced Specificity",true],["Prebuilt Repertoire and First Response Lag",true],["Assigning Deficiency Patterns to Immune Arms",true],["Infection Pattern Pointing to One Arm",true],["Localising a Block Upstream of Lymphocytes",false]]},

 {name:"Leukocyte Lineages and Lymphoid Organs", cards:[4,5,6,7,8,9,10,11], conf:"HIGH",
  def:"Haematopoietic origin of all leukocytes, the primary lymphoid organs where lymphocytes mature, and the secondary lymphoid organs where they meet antigen.",
  q:[["Two Site Design of Lymphocyte Production",true],["Lineage That Never Leaves Its Birthplace",true],["Antigen Transport to a Lymphoid Organ",true],["Draining Versus Remote Node Time Course",true],["Screening Antigen That Never Leaves Vessels",true],["Why Rare Clones Must Be Concentrated",true],["Why Rare Clones Must Keep Moving",true],["Reading a Labelled Lymphocyte Distribution Time Course",false],["Localising a Block Upstream of Lymphocytes",false]]},

 {name:"Surface Barriers to Infection", cards:[12,13,15,16], conf:"HIGH",
  def:"Physical and chemical barriers at body surfaces: keratinised skin, lysozyme, mucus, gastric acid, defensins and competition from resident flora.",
  q:[["Skin as a Physical Barrier",true],["Gastric Acid as a Chemical Barrier",true],["Colonization Resistance by Resident Flora",true],["Layered Surface Defences and Response Timing",true]]},

 {name:"Phagocytes and Granulocytes", cards:[17,18,19,20,21,22,23], conf:"HIGH",
  def:"The innate cellular effectors: phagocytosis and lysosomal killing, macrophages, neutrophils, dendritic cells, eosinophils, mast cells and basophils, and the granulocyte/agranulocyte division.",
  q:[["Chemotaxis and Gradient Sensing",true],["Phagocyte Size Limits and External Attack",true],["Resident Macrophages as the Source of Recruitment Signals",true],["Resident Versus Recruited Populations Over Time",true],["Distinguishing Resident from Recruited Phagocytes",false],["Interpreting a Phagocyte Migration Assay",false]]},

 {name:"The Complement System", cards:[24], conf:"HIGH",
  def:"Plasma protein cascade that opsonises, recruits phagocytes and assembles the membrane attack complex causing osmotic lysis, with host regulatory protection.",
  q:[["Directing a Plasma Protein Cascade to One Surface",true],["Rigid Cell Walls and Pore-Mediated Lysis",true],["Self Versus Nonself Discrimination in Plasma",true],["Why A Coated Organism Is The One That Overwhelms",true],["Testing Whether a Plasma Defense Is Tailored to Its Target",false],["Constitutive Plasma Defenses Versus Induced Specificity",false]]},

 {name:"Cytokines and Interferons", cards:[25,26], conf:"HIGH",
  def:"Secreted signalling proteins that coordinate immune responses, and the interferon response by which virally altered cells induce resistance in neighbours.",
  q:[["Basis of the Induced Resistant State",true],["Direction of an Innate Antiviral Signal",true],["Properties of a Broad Antiviral Signal",true]]},

 {name:"Natural Killer Cells", cards:[27,28], conf:"MEDIUM",
  def:"Innate lymphocytes that induce apoptosis in virus-infected and tumour cells detected by loss of MHC class I, the missing-self mechanism.",
  q:[["Consequences of Suppressed Surface Display",true],["Pairing Display Type to Effector Function",false]]},

 {name:"Pattern Recognition and Acute Inflammation", cards:[29,30], conf:"MEDIUM",
  def:"Pattern recognition receptors detecting conserved pathogen and damage signals, and the vascular changes producing the cardinal signs of inflammation.",
  q:[["Innate Triggering by Damage Versus Non-Self",true],["Vascular Change and Delivery of Plasma Components",true]]},

 {name:"Antigens and Epitopes", cards:[31,32], conf:"HIGH",
  def:"What makes a molecule antigenic, the epitope as the bound subregion, and how epitope size and accessibility set response diversity and cross-reactivity.",
  q:[["Epitope Size and Response Diversity",true],["Binding Strength Versus Discrimination",true],["Accessible Targets in a Prior Exposure",true],["Shared Surface Patches and Test Specificity",true],["Targets a Naive B Receptor Can Reach",false]]},

 {name:"MHC and Antigen Presentation", cards:[33,34,35,36], conf:"HIGH",
  def:"Professional antigen-presenting cells, and MHC class I and II differing in peptide source, restriction to CD8 or CD4 T cells, and tissue distribution.",
  q:[["Baseline Self Fragment Display in Healthy Cells",true],["Two Fragment Sources, Two Carriers",true],["Universal Distribution of the Display Molecule",true],["Restricting the Ingested-Material Display",true],["Display Requirement for T Lymphocyte Recognition",true],["Population Value of MHC Allele Diversity",true],["Nonself Recognition of Grafted Tissue",true],["Pairing Display Type to Effector Function",true],["Reading Fragment Origin from an Assay",false],["Reading a Native Versus Fragment Binding Table",false],["Control Arm for a Display-Blocking Reagent",false],["Designing a Donor Compatibility Culture",false]]},

 {name:"B Cell Activation and Antibody Diversity", cards:[37,42,43], conf:"HIGH",
  def:"Activation of a naive B cell into plasma and memory cells, and the generation and refinement of antibody diversity by recombination, class switching and somatic hypermutation.",
  q:[["Commitment of a Selected B Lymphocyte to Export",true],["Origin of B Lineage Binding Diversity",true],["Why Surface and Output Specificity Must Match",true],["Protein Versus Polysaccharide Antigen Dependence",true],["Targets a Naive B Receptor Can Reach",true],["Culture Arm Testing Matched Versus Generic Help",false]]},

 {name:"T Cell Subsets and Effector Function", cards:[49,50,51,52,53,54], conf:"HIGH",
  def:"Helper, cytotoxic, regulatory and memory T cells distinguished by co-receptor, MHC restriction and effector output.",
  q:[["Collapse of Both Adaptive Arms Together",true],["Loss of the Signal Releasing T Lymphocyte Population",true],["Detecting an Entirely Intracellular Infection",true],["Subset Depletion and Arm Specific Readout",true],["Interpreting a Matched Display Killing Assay",false],["Dose Response With Licensing Withheld",false],["Testing Necessity of a Licensing Contact",false],["Culture Arm Testing Matched Versus Generic Help",false]]},

 {name:"Thymic Selection and Self-Tolerance", cards:[55,56,61], conf:"HIGH",
  def:"Positive and negative selection in the thymus, and how escape of self-reactive lymphocytes breaks self-tolerance.",
  q:[["Two Screens During Lymphocyte Maturation",true],["Nonself Present During the Screening Window",true],["Neonatal Versus Adult Loss of Screening Organ",true],["Tolerance to Self Peptides in MHC",true],["Injury Exposing a Sequestered Body Constituent",true]]},

 {name:"Clonal Selection and Immunologic Memory", cards:[57,58,59,60], conf:"HIGH",
  def:"Antigen selecting a preexisting matching lymphocyte, clonal expansion, and the faster stronger secondary response carried by memory cells.",
  q:[["Selection Versus Instruction by Antigen",true],["Enlarged Responsive Population After Clearance",true],["Separate Causes for Speed and Size",true],["Why Re-encounter Shortens the Delay",true],["Lowered Triggering Requirement of Surviving Lymphocytes",true],["Prebuilt Repertoire and First Response Lag",false],["Reading Expansion of a Rare Clone",false],["Specificity Control in a Two Exposure Time Course",false],["Adoptive Transfer and Causal Necessity",false]]},

 {name:"Autoimmune Disease", cards:[62], conf:"MEDIUM",
  def:"Disease produced when an intact immune response is directed at a self antigen, illustrated by demyelination in multiple sclerosis.",
  q:[["Autoimmunity as Correct Machinery Wrong Target",true],["Tolerance to Self Peptides in MHC",false],["Injury Exposing a Sequestered Body Constituent",false]]},

 {name:"Hypersensitivity and Allergy", cards:[63,64], conf:"HIGH",
  def:"Type I immediate hypersensitivity through IgE-coated mast cells and degranulation, and delayed cell-mediated hypersensitivity.",
  q:[["Locating the Source of Tissue Damage",true],["Localising Transferable Reactivity to a Blood Fraction",true],["Reading a Prior Contact Patch Panel",false],["Separating Irritant Injury from Host Response",false]]},

 {name:"Active and Passive Immunity", cards:[65,66,67], conf:"HIGH",
  def:"Immunity from the host's own adaptive response versus transferred ready-made antibody, and the consequences for memory and duration.",
  q:[["Cell-Free Control in a Protection Transfer",true],["Control Arms for a Specificity Claim",false],["Graded Protection Against a Mutated Coat",false],["Adoptive Transfer and Causal Necessity",false]]},

 {name:"Vaccination", cards:[68,69], conf:"HIGH",
  def:"Live-attenuated, inactivated and subunit vaccines generating memory without disease, and conjugation to recruit T-dependent help.",
  q:[["Adding a Protein Partner to a Capsule Sugar",true],["Graded Protection Against a Mutated Coat",true],["Control Arms for a Specificity Claim",false]]},

 {name:"The Lymphatic System", cards:[70,71,72,73,74,75,76], conf:"HIGH",
  def:"Return of excess interstitial fluid as lymph, lacteal absorption of dietary fat, drainage through nodes and the thoracic duct, and the consequence of blocked drainage.",
  q:[["Purpose of the Obligate Drainage Detour",true],["What Node Enlargement Actually Consists Of",true],["Draining Versus Remote Node Time Course",false]]},
];

// Cards that stay on EXISTING concepts (no new object needed).
export const KEEP_EXISTING = [
 {concept:"Respiratory Immune Defense", cards:[14], why:"Curriculum-grade already (9 questions) and owned by the respiratory chapter. Mucociliary clearance is its subject."},
 {concept:"Immunoglobulins", cards:[38,39,40,41,44,45,46,47,48], why:"Curriculum-grade already (4 questions). Antibody structure, the five classes and their functions are exactly its subject. Creating an immune-chapter antibody concept would be a flashcard-only twin."},
];

// Classification of all 89 existing immune labels, with the eventual question-side action.
// A legitimate reusable curriculum concept | B scenario expression of a broader concept
// C reasoning/experimental construct, not a content identity | D duplicate/near-duplicate
// E should remain separate
export const LABELS = {
 A:["Chemotaxis and Gradient Sensing","Colonization Resistance by Resident Flora","Epitope Size and Response Diversity","Gastric Acid as a Chemical Barrier","Origin of B Lineage Binding Diversity","Population Value of MHC Allele Diversity","Selection Versus Instruction by Antigen","Skin as a Physical Barrier","Two Screens During Lymphocyte Maturation","Two Site Design of Lymphocyte Production"],
 C:["Adoptive Transfer and Causal Necessity","Cell-Free Control in a Protection Transfer","Control Arm for a Display-Blocking Reagent","Control Arms for a Specificity Claim","Culture Arm Testing Matched Versus Generic Help","Designing a Donor Compatibility Culture","Distinguishing Resident from Recruited Phagocytes","Dose Response With Licensing Withheld","Interpreting a Matched Display Killing Assay","Interpreting a Phagocyte Migration Assay","Localising Transferable Reactivity to a Blood Fraction","Localising a Block Upstream of Lymphocytes","Locating the Source of Tissue Damage","Reading Expansion of a Rare Clone","Reading Fragment Origin from an Assay","Reading a Labelled Lymphocyte Distribution Time Course","Reading a Native Versus Fragment Binding Table","Reading a Prior Contact Patch Panel","Separating Irritant Injury from Host Response","Specificity Control in a Two Exposure Time Course","Subset Depletion and Arm Specific Readout","Testing Necessity of a Licensing Contact","Testing Whether a Plasma Defense Is Tailored to Its Target"],
 D:["Basis of the Induced Resistant State","Direction of an Innate Antiviral Signal","Properties of a Broad Antiviral Signal","Infection Pattern Pointing to One Arm","Loss of the Signal Releasing T Lymphocyte Population","Resident Versus Recruited Populations Over Time","Why Rare Clones Must Keep Moving"],
 E:[],
};
