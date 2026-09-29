// Reasoning-layer design. Every one of the 36 candidates was read: stem, options,
// correct answer and explanation. The keyword ledgers that produced them were
// wrong often enough that they are best treated as a list of questions to read,
// not as a proposal.
//
// THE TEST APPLIED: does solving this question require a reusable inferential
// operation, and is that operation part of what separates the right answer from
// the wrong ones? A question is not a reasoning item because it contains a
// table, an experiment or a control group.

export const CLASSIFICATION = {
 // ── EXISTING_REASONING_OBJECT: Variables and Controls ──────────────────────
 // "What comparison must exist before this conclusion is safe?" The answer
 // choices are candidate arms, and the wrong ones fail because they do not
 // isolate the variable in question.
 "Testing Whether a Plasma Defense Is Tailored to Its Target":{v:"Variables and Controls",c:"HIGH"},
 "Distinguishing Resident from Recruited Phagocytes":{v:"Variables and Controls",c:"HIGH"},
 "Control Arm for a Display-Blocking Reagent":{v:"Variables and Controls",c:"HIGH"},
 "Designing a Donor Compatibility Culture":{v:"Variables and Controls",c:"HIGH"},
 "Testing Necessity of a Licensing Contact":{v:"Variables and Controls",c:"HIGH"},
 "Culture Arm Testing Matched Versus Generic Help":{v:"Variables and Controls",c:"HIGH"},
 "Specificity Control in a Two Exposure Time Course":{v:"Variables and Controls",c:"HIGH"},
 "Cell-Free Control in a Protection Transfer":{v:"Variables and Controls",c:"HIGH"},
 "Control Arms for a Specificity Claim":{v:"Variables and Controls",c:"HIGH"},
 "Separating Irritant Injury from Host Response":{v:"Variables and Controls",c:"HIGH"},
 "Localising Transferable Reactivity to a Blood Fraction":{v:"Variables and Controls",c:"HIGH"},
 "Localising a Block Upstream of Lymphocytes":{v:"Variables and Controls",c:"HIGH"},
 "Cannulated Lymph Sampling As A Permeability Assay":{v:"Variables and Controls",c:"MEDIUM",
   n:"Chooses a discriminating MEASUREMENT rather than a control arm. Same family, slightly outside the object's current wording."},
 "Locating The Break In The Loop":{v:"Variables and Controls",c:"MEDIUM",
   n:"Same shape as above: which bedside observation separates two live explanations."},

 // ── NEW_REASONING_OBJECT_NEEDED: Data Interpretation ───────────────────────
 // A dataset is presented and the question is what it establishes. The wrong
 // answers are readings the data does not support, not facts the learner lacks.
 "Interpreting a Phagocyte Migration Assay":{v:"NEW:Data Interpretation",c:"HIGH"},
 "Reading Fragment Origin from an Assay":{v:"NEW:Data Interpretation",c:"HIGH"},
 "Interpreting a Matched Display Killing Assay":{v:"NEW:Data Interpretation",c:"HIGH"},
 "Dose Response With Licensing Withheld":{v:"NEW:Data Interpretation",c:"HIGH"},
 "Reading a Native Versus Fragment Binding Table":{v:"NEW:Data Interpretation",c:"HIGH"},
 "Reading Expansion of a Rare Clone":{v:"NEW:Data Interpretation",c:"HIGH"},
 "Reading a Labelled Lymphocyte Distribution Time Course":{v:"NEW:Data Interpretation",c:"HIGH"},
 "Reading a Prior Contact Patch Panel":{v:"NEW:Data Interpretation",c:"HIGH"},
 "Testing Endothelial Function in Isolated Vessels":{v:"NEW:Data Interpretation",c:"MEDIUM",
   n:"Three arms are given as results rather than as a design choice, so the work is reading them."},

 // ── EXISTING_REASONING_OBJECT: Causal Inference ────────────────────────────
 "Adoptive Transfer and Causal Necessity":{v:"Causal Inference",c:"HIGH",
   n:"The question is explicitly what an intervention establishes that a correlation could not. This is the object's subject."},

 // ── NO_REASONING_MAPPING: content application, whatever the label suggests ──
 "Subset Depletion and Arm Specific Readout":{v:"NONE",c:"HIGH",n:"Which property of the removed lineage explains the split. MHC class I restriction, pure content."},
 "Locating the Source of Tissue Damage":{v:"NONE",c:"HIGH",n:"Where hypersensitivity damage originates. Content."},
 "Sampling A Portal Circuit":{v:"NONE",c:"HIGH",n:"Where to place a sampling catheter in a portal system. Anatomy, not sampling methodology."},
 "Comparing Starling Forces Across Capillary Beds":{v:"NONE",c:"MEDIUM",n:"A table, but the work is applying the Starling equation to each row. Arithmetic on content, not interpretation of evidence."},
 "Manipulating the Filtration Balance Experimentally":{v:"NONE",c:"HIGH",n:"Predicting the direction each intervention moves filtration. Content."},
 "Two Mechanisms of Interstitial Fluid Accumulation":{v:"NONE",c:"HIGH",n:"Which Starling force each cause moves. Content."},
 "Protein Content of Accumulated Interstitial Fluid":{v:"NONE",c:"HIGH",n:"What lymphatic removal does to interstitial protein. Content."},
 "Starling Forces And Lymph Formation Rate":{v:"NONE",c:"HIGH",n:"Direction of three interventions on filtration. Content."},
 "Interpreting an Elevated Hematocrit":{v:"NONE",c:"MEDIUM",n:"No dataset is presented. Reasoning about haemoconcentration versus overproduction is content."},
 "Reticulocyte Count And Marrow Response":{v:"NONE",c:"MEDIUM",n:"Two values against a reference. Knowing what a reticulocyte count means is content."},
 "Screening Donor Units Against A Recipient Antibody Profile":{v:"NONE",c:"HIGH",n:"A lookup table, but the work is applying ABO and Rh rules. Content."},
 "Cutting The Afferent Limb":{v:"NONE",c:"HIGH",n:"What removing baroreceptor afferents does. Content physiology."},
};

// Objects the keyword ledgers proposed that are WRONG, kept so the mistake is
// recorded rather than quietly dropped.
export const REJECTED_PRIORS = [
 {object:"Study Design Types", count:5,
  why:"Its definition is cohort, case-control and cross-sectional designs, which is epidemiology. Every question the matcher sent there is a bench experiment. Matching on the word designing was the error."},
 {object:"Randomization and Sampling", count:2,
  why:"The object is random assignment and population sampling. Sampling A Portal Circuit is about where to put a catheter, and Screening Donor Units is a compatibility lookup. Matching on the word sampling was the error."},
 {object:"Confounding", count:3,
  why:"Two of the three are content questions about hypersensitivity. The third is a control-arm design. None involves a third variable influencing both exposure and outcome."},
 {object:"Hypothesis Formation", count:1,
  why:"The question designs a comparison, it does not form or phrase a hypothesis."},
 {object:"Data Display Formats", count:9,
  why:"Correctly identified the questions, wrong object. That object is QUANTITATIVE and is about knowing what a histogram or box plot IS. These questions require reading evidence, which is a different axis."},
];
