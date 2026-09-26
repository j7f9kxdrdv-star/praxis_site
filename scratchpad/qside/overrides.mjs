// Five questions the design could not resolve mechanically, decided by reading
// the question and its correct answer. Two of these CHANGE the earlier design,
// which is the reason the instruction said to verify from the question itself.
export const OVERRIDES = {
 "Adoptive Transfer and Causal Necessity": {
  target:"B Cell Activation and Antibody Diversity", conf:"MEDIUM",
  why:"Group 1 (antibody-producing lineage alone) yields nothing, group 3 (plus the permission-issuing subset) yields a full amount. The measured outcome is antibody output and the objective is that B cells require T help to produce it. Alternative reading is T Cell Subsets and Effector Function, since the manipulated cell is the helper; flagged MEDIUM so a reviewer can flip it."},
 "Culture Arm Testing Matched Versus Generic Help": {
  target:"T Cell Subsets and Effector Function", conf:"MEDIUM",
  why:"The control arm adds partner cells reactive to an unrelated target, so the variable under test is the SPECIFICITY of the helper population's output, not whether help is needed. That is a property of the helper subset. Paired with the row above, which varies presence rather than specificity."},
 "Control Arms for a Specificity Claim": {
  target:"Vaccination", conf:"HIGH",
  why:"A harmless material made from bacterium P, given four weeks before challenge, is a vaccine. The objective is that vaccine-induced protection is specific to the organism. Design offered Active and Passive Immunity as an alternative, but the item is about what a vaccine installs."},
 "Localising a Block Upstream of Lymphocytes": {
  target:"MHC and Antigen Presentation", conf:"HIGH",
  why:"CORRECTS THE DESIGN. It offered Innate versus Adaptive Immunity and Leukocyte Lineages, and both are wrong. The child's lymphocytes are normal in number and receptor diversity; the correct answer crosses the child's lymphocytes with a healthy donor's ingesting and displaying cells. The block is in antigen presentation."},
 "Random Repertoire and the Need for Tolerance": {
  target:"Thymic Selection and Self-Tolerance", conf:"HIGH",
  why:"CORRECTS THE DESIGN, which named B Cell Activation and Antibody Diversity for this previously unmapped question. The stem describes random gene-segment joining, but the tested inference is why a dedicated screen is NEEDED: blind recombination inevitably yields self-fitting sites, so those cells must be eliminated. The correct answer is about deleting self-reactive cells, which is negative selection, not diversity generation."},
};
