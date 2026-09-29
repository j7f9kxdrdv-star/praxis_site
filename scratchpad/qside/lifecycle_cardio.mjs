// Per-label lifecycle for the 99 cardiovascular labels.
//
// B, C and D merge into their durable concept. The 12 class-A and 3 class-E
// labels are judged one at a time against one test: does the label name the
// durable concept's WHOLE subject, or a part of it? A whole-subject match is a
// synonym and merges. A part is a genuine facet, is RETAINED, and keeps its
// evidence as a SECONDARY mapping on the same question.
//
// The instruction not to create secondary mappings merely to preserve old labels
// cost two of the three class-E labels their retention. Re-reading them, only
// one names a separate objective.
export const DECISIONS = {
 // ── class A: merge, because the durable concept's own definition covers it ──
 "Pacemaker Hierarchy":
  {action:"MERGE_TO", why:"The durable concept is literally called Cardiac Conduction and Pacemaker Hierarchy. A synonym cannot also be a sub-objective."},
 "Cardiac Output Calculation":
  {action:"MERGE_TO", why:"Cardiac Output and Stroke Volume is the calculation. Naming the arithmetic separately splits one idea across two ids."},
 "Capillary Types and Permeability":
  {action:"MERGE_TO", why:"Capillary wall types are named in the durable concept's definition, so this is the same content under a narrower title."},
 "Mean Arterial Pressure":
  {action:"MERGE_TO", why:"Mean arterial pressure is named in Blood Pressure and Its Measurement. The derived quantity is the concept, not a part of it."},
 "Site Of Greatest Vascular Resistance":
  {action:"MERGE_TO", why:"Arterioles as the dominant resistance site is in the Hemodynamics definition."},
 "Total Cross-Sectional Area and Flow Velocity":
  {action:"MERGE_TO", why:"Velocity being lowest where total cross-sectional area is greatest is in the Hemodynamics definition."},
 "Poiseuille Determinants of Vascular Resistance":
  {action:"MERGE_TO", why:"The fourth-power radius dependence is in the Hemodynamics definition."},
 // ── class A: retain, genuinely narrower than the concept above them ──
 "Isovolumic Contraction":
  {action:"RETAIN_AS_SUBOBJECTIVE", why:"A named phase within the cardiac cycle, with its own defining condition of both valve sets shut and no volume change. Narrower than the cycle, not a synonym for it."},
 "Hepatic Portal Route":
  {action:"RETAIN_AS_SUBOBJECTIVE", why:"One of the three portal systems Portal Circulations covers. A student can know what a portal system is and still not know the gut to liver route."},
 "Sphygmomanometry Technique":
  {action:"RETAIN_AS_SUBOBJECTIVE", why:"Deflation rate and arm position are a measurement skill with their own error modes, separate from what systolic and diastolic pressure mean."},
 "Plasma Versus Serum":
  {action:"RETAIN_AS_SUBOBJECTIVE", why:"Serum is plasma minus the clotting factors consumed in the tube. A distinct fact that Blood Composition does not state."},
 "Extramedullary Hemopoiesis":
  {action:"RETAIN_AS_SUBOBJECTIVE", why:"Blood formation restarting in liver and spleen when marrow fails is a pathophysiological objective, not part of the normal erythrocyte lifecycle."},
 // ── class E, reconsidered ──
 "Lacteal Routing Of Absorbed Lipid":
  {action:"RETAIN_AS_SUBOBJECTIVE", why:"Why dietary fat leaves by lacteal rather than capillary is separately examinable, and it is also a digestion objective, so it is not wholly owned by The Lymphatic System."},
 "Daily Lymph Return Volume":
  {action:"MERGE_TO", why:"RECLASSIFIED from E. Return of excess interstitial fluid as lymph is the durable concept's opening clause. The daily volume is a figure inside that idea, not an objective beside it."},
 "Interstitial Protein Retention After Lymphatic Loss":
  {action:"MERGE_TO", why:"RECLASSIFIED from E. The consequence of blocked drainage is named in the durable definition. Retaining this would be preserving a label, which is what the instruction warned against."},
};
