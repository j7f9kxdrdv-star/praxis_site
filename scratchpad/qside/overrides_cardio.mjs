// Four cardiovascular questions the design could not resolve mechanically,
// decided by reading the stem, the options and the correct answer.
export const OVERRIDES = {
 "Murmur Timing And Valve Lesions": {
  target:"The Cardiac Cycle and Heart Sounds", conf:"HIGH",
  why:"The murmur runs from S1 to S2, and echo rules out stenosis by showing every orifice opens to normal area. The work is knowing what is happening between those two sounds: ventricles contracting, AV valves shut, semilunars open, so a systolic murmur with patent orifices means a leaking AV valve. That inference is cycle timing. Heart Chambers and Valves was the alternative, but which valve sits where is given, not tested."},
 "Peritubular Capillary Conditions": {
  target:"Starling Forces and Capillary Fluid Balance", conf:"HIGH",
  why:"Plasma protein climbs 7.0 to 8.7 g/dL across the glomerulus because filtration removes fluid and leaves protein behind, so the next capillary bed starts with a high colloid osmotic pressure and takes fluid up. That is a Starling force argument end to end. Portal Circulations is the setting, two beds in series, not the tested inference."},
 "Leukocyte Exit From The Microcirculation": {
  target:"Capillary Structure and Exchange", conf:"MEDIUM",
  why:"Cross-linking the junctions BETWEEN endothelial cells blocks exit while leaving the cells themselves intact, so leukocytes bank up in the lumen. What a student needs is that leukocytes leave by passing between endothelial cells, which is a fact about how the vessel wall is built and what can cross it. Leukocytes and Platelets in Blood is the defensible alternative, since diapedesis is a leukocyte behaviour; flagged MEDIUM so a reviewer can flip it."},
 "Confinement of Clotting to the Injury Site": {
  target:"Hemostasis, Coagulation and Fibrinolysis", conf:"HIGH",
  why:"Previously unmapped. The answer is that plasma anticoagulants inactivate enzymes swept downstream and that intact endothelium keeps subendothelial collagen covered, while factor consumption does not confine anything. Both correct mechanisms are controls on the coagulation cascade, which is what this concept covers."},
};
