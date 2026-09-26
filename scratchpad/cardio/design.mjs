// Cardiovascular curriculum reconciliation. Same shape as the immune design.
// `cards` are [deck, position] pairs because this chapter's cards are spread
// across five decks: consolidating the portal circulations pulls cards out of
// Endocrine, Digestive and Homeostasis as well.
const CV = "The Cardiovascular System";

export const PROPOSED = [
 {name:"Cardiac Conduction and Pacemaker Hierarchy", conf:"HIGH",
  def:"The impulse pathway from SA node through AV node, bundle of His and Purkinje fibres, the AV delay, and the inherent rates that make lower sites escape pacemakers.",
  cards:[[CV,8],[CV,9],[CV,10],[CV,11]],
  q:[["Pacemaker Hierarchy",true],["Conduction Timing and the ECG",true],["Accessory Atrioventricular Conduction",true],["Conduction Block and Escape Rhythms",true],["Purkinje Activation Sequence",true]]},

 {name:"The Cardiac Cycle and Heart Sounds", conf:"HIGH",
  def:"Systole and diastole, the pressure relationships that open and close each valve, and the heart sounds those closures produce.",
  cards:[[CV,12],[CV,13],[CV,14]],
  q:[["Heart Sounds and Valve Closure",true],["Isovolumic Contraction",true],["Diastolic Filling Time",true],["Atrial Systole and Ventricular Filling",true],["Pressure Gradients Across Valves",true],["Backward Transmission Of Pressure",false],["Murmur Timing And Valve Lesions",false]]},

 {name:"Cardiac Output and Stroke Volume", conf:"HIGH",
  def:"Cardiac output as heart rate times stroke volume, ejection fraction, contractility, and the requirement that the two ventricles eject equal volumes.",
  cards:[[CV,15],[CV,16],[CV,17],[CV,27]],
  q:[["Cardiac Output Calculation",true],["Heart Rate and Cardiac Output",true],["Ejection Fraction and Cardiac Output",true],["Contractility and Ejection Fraction",true],["Matched Ventricular Outputs",true],["Equal Flow Through Two Circuits",false]]},

 {name:"Baroreflex and Autonomic Cardiovascular Control", conf:"HIGH",
  def:"Arterial baroreceptors in the carotid sinus and aortic arch, and the sympathetic, parasympathetic and adrenal limbs that adjust rate, contractility and resistance.",
  cards:[[CV,18],[CV,19],[CV,20],[CV,47]],
  q:[["Carotid Sinus Compression",true],["Bidirectional Reflex Gain",true],["Cutting The Afferent Limb",true],["Head-Up Tilt And Resistance Adjustment",true],["Locating The Break In The Loop",false]]},

 {name:"Pulmonary and Systemic Circuits", conf:"HIGH",
  def:"The two circuits in series, the pulmonary vessels that invert the usual oxygenation rule, and why the left ventricle is the thicker pump.",
  cards:[[CV,21],[CV,22],[CV,23],[CV,24],[CV,25],[CV,26]],
  q:[["Pulmonary And Systemic Circuits In Series",true],["Equal Flow Through Two Circuits",true],["Afterload and Ventricular Wall Thickness",true],["Pressure Overload And Chamber Remodeling",true]]},

 {name:"Capillary Structure and Exchange", conf:"HIGH",
  def:"The single endothelial layer on its basement membrane, capillary wall types, and exchange by diffusion of solutes versus bulk flow of fluid.",
  cards:[[CV,35],[CV,36],[CV,37]],
  q:[["Capillary Wall Architecture and Exchange",true],["Capillary Types and Permeability",true],["Leukocyte Exit From The Microcirculation",false]]},

 {name:"Starling Forces and Capillary Fluid Balance", conf:"HIGH",
  def:"Hydrostatic and colloid osmotic pressure across the capillary wall, filtration at the arteriolar end and reabsorption at the venular end, and the plasma proteins that set oncotic pressure.",
  cards:[[CV,38],[CV,39],[CV,40]],
  q:[["Comparing Starling Forces Across Capillary Beds",true],["Net Filtration Pressure at the Venular End",true],["Position of the Filtration Reabsorption Crossover",true],["Plasma Proteins and Capillary Fluid Balance",true],["Colloid Versus Crystalloid Osmotic Effects",true],["Manipulating the Filtration Balance Experimentally",false],["Two Mechanisms of Interstitial Fluid Accumulation",false],["Protein Content of Accumulated Interstitial Fluid",false],["Peritubular Capillary Conditions",false]]},

 {name:"Hemodynamics: Resistance, Flow and Velocity", conf:"HIGH",
  def:"Pressure equals flow times resistance, the fourth-power dependence on radius, arterioles as the dominant resistance site, and why velocity is lowest where total cross-sectional area is greatest.",
  cards:[[CV,41],[CV,46],[CV,48]],
  q:[["Total Cross-Sectional Area and Flow Velocity",true],["Site Of Greatest Vascular Resistance",true],["Poiseuille Determinants of Vascular Resistance",true],["Vessel Radius and Blood Flow",true],["Blood Viscosity and Vascular Resistance",true],["Mean Arterial Pressure And Total Peripheral Resistance",true],["Flow Redistribution And Vascular Resistance",false],["Turbulence and Vascular Sound",false]]},

 {name:"Blood Pressure and Its Measurement", conf:"HIGH",
  def:"Systolic and diastolic pressure, typical adult values, mean arterial pressure and pulse pressure, and how cuff measurement obtains them.",
  cards:[[CV,43],[CV,44],[CV,45]],
  q:[["Mean Arterial Pressure",true],["Sphygmomanometry Technique",true],["Arterial Compliance And Pulse Pressure",true],["Pulse Pressure And Stroke Volume",true],["Elastic Arteries and Diastolic Flow",false]]},

 {name:"Blood Composition: Plasma and Formed Elements", conf:"HIGH",
  def:"Blood as a transport medium, the plasma and formed-element fractions, plasma water and its dissolved proteins, and the liver as their source.",
  cards:[[CV,1],[CV,52],[CV,53],["The Digestive System",44]],
  q:[["Plasma Fraction and Plasma Protein Content",true],["Plasma Versus Serum",true]]},

 {name:"Erythrocytes: Structure, Lifecycle and Turnover", conf:"HIGH",
  def:"The biconcave anucleate erythrocyte, hematocrit, marrow production and the roughly 120-day lifespan ending in splenic and hepatic macrophage recycling of iron.",
  cards:[[CV,54],[CV,55],[CV,56],[CV,57],[CV,59]],
  q:[["Anucleate Erythrocyte Lifespan",true],["Erythrocyte Turnover And Survival Time",true],["Iron Recycling And Heme Breakdown",true],["Interpreting an Elevated Hematocrit",true],["Reticulocyte Count And Marrow Response",true],["Erythrocyte Deformability and Capillary Transit",false],["Erythrocyte ATP Production",false],["Extramedullary Hemopoiesis",false]]},

 {name:"Leukocytes and Platelets in Blood", conf:"MEDIUM",
  def:"Marrow origin of leukocytes and their immune role, the differential count, and platelets as megakaryocyte fragments.",
  cards:[[CV,58],[CV,60]],
  q:[["Granulocyte Fraction Of A Differential Count",true],["Platelet Origin From Megakaryocytes",true],["Leukocyte Exit From The Microcirculation",false]]},

 {name:"Hemostasis, Coagulation and Fibrinolysis", conf:"HIGH",
  def:"Exposure of collagen and tissue factor, the platelet plug of primary hemostasis, the cascade converting prothrombin to thrombin and fibrinogen to fibrin, and plasmin-mediated clot breakdown.",
  cards:[[CV,74],[CV,75],[CV,76],[CV,77],[CV,78]],
  q:[["Platelet Plug Versus Fibrin Reinforcement",true],["Cascade Amplification by Feedback Activation",true],["Enzymatic Clot Dissolution",true],["Platelet Granule Release and Plug Growth",true],["Clot Retraction by Platelet Contraction",true],["Immediate Vessel Narrowing After Injury",false],["Vasomotor Changes Across the Clot Lifecycle",false]]},

 {name:"Portal Circulations", conf:"HIGH",
  def:"A portal system as two capillary beds in series, and the hepatic, hypophyseal and renal examples with what each one accomplishes.",
  cards:[[CV,79],[CV,80],[CV,81],["The Endocrine System",32],["The Endocrine System",34],["The Digestive System",45],["Homeostasis",7],["Homeostasis",8],["Homeostasis",9],["Homeostasis",10]],
  q:[["Hepatic Portal Route",true],["Hypophyseal Portal Architecture",true],["Renal Portal Hemodynamics",true],["Sampling A Portal Circuit",true],["Dual Blood Supply Of The Liver",false],["Peritubular Capillary Conditions",false]]},
];

// Cards moving onto a concept approved earlier rather than a new one.
export const REUSE = [
 {concept:"Thermoregulatory Mechanisms", cards:[["The Cardiovascular System",42]], approvedNew:false,
  why:"Caught on a reuse check against curriculum-grade concepts. Thermoregulatory Mechanisms already has 6 questions (sweat gland populations, heat exchange direction, hypodermal fat, piloerection, fever set point) and 5 cards. Cutaneous vasomotion for heat loss or conservation belongs to that family, so a new Local Control of Blood Flow and Thermoregulation concept would have been a duplicate. Dropped it."},
 {concept:"Blood Vessel Structure and Types", cards:[["The Musculoskeletal System",76]], approvedNew:true,
  why:"The skeletal-muscle pump acts through the venous valves and capacitance this concept already covers (its cards 33 and 34). Reusing an approved concept rather than minting a venous-return one."},
];

// The 99 cardio labels, classified. Unlisted names are class B.
export const LABELS = {
 A:["Mean Arterial Pressure","Cardiac Output Calculation","Pacemaker Hierarchy","Total Cross-Sectional Area and Flow Velocity","Site Of Greatest Vascular Resistance","Poiseuille Determinants of Vascular Resistance","Plasma Versus Serum","Capillary Types and Permeability","Hepatic Portal Route","Sphygmomanometry Technique","Isovolumic Contraction","Extramedullary Hemopoiesis"],
 C:["Comparing Starling Forces Across Capillary Beds","Manipulating the Filtration Balance Experimentally","Interpreting an Elevated Hematocrit","Testing Endothelial Function in Isolated Vessels","Cutting The Afferent Limb","Locating The Break In The Loop","Cannulated Lymph Sampling As A Permeability Assay","Sampling A Portal Circuit","Starling Forces And Lymph Formation Rate","Screening Donor Units Against A Recipient Antibody Profile","Two Mechanisms of Interstitial Fluid Accumulation","Protein Content of Accumulated Interstitial Fluid","Reticulocyte Count And Marrow Response"],
 D:["Mean Arterial Pressure And Total Peripheral Resistance","Ejection Fraction and Cardiac Output","Heart Rate and Cardiac Output","Vessel Radius and Blood Flow","Net Filtration Pressure at the Venular End","Position of the Filtration Reabsorption Crossover","Widening Extraction At Peak Exercise","Oxygen Delivery As Flow Times Content","Dissolved Oxygen As A Fraction Of Content"],
 E:["Daily Lymph Return Volume","Interstitial Protein Retention After Lymphatic Loss","Lacteal Routing Of Absorbed Lipid"],
};

// Cardio labels whose objective belongs to a concept approved EARLIER (the five
// physiology concepts, or The Lymphatic System from the immune pass) rather than
// to one of the 15 above. Recorded so the ledger covers all 99 and so the
// both-modalities projection is honest about which concepts gain question
// evidence from this chapter.
export const ALIGN_APPROVED = [
 {concept:"Heart Chambers and Valves", q:[["Atrioventricular Valve Anchoring",true],["Semilunar Valve Competence",true],["Murmur Timing And Valve Lesions",false]]},
 {concept:"Blood Vessel Structure and Types", q:[["Venous Return and the Skeletal Muscle Pump",true],["Venoconstriction and Venous Resistance",true],["Elastic Arteries and Diastolic Flow",true],["Consequences of Endothelial Denudation",false]]},
 {concept:"ABO and Rh Blood Types", q:[["Screening Donor Units Against A Recipient Antibody Profile",true],["Sensitization Timing After Rh Exposure",true],["Vessel Obstruction During A Mismatched Transfusion",true],["Donor Plasma Antibody Load In Whole Blood",true]]},
 {concept:"Thermoregulatory Mechanisms", q:[["Role In Thermoregulation",true],["Countercurrent Vascular Heat Exchange In A Limb",true]]},
 {concept:"The Lymphatic System", q:[["Daily Lymph Return Volume",true],["Interstitial Protein Retention After Lymphatic Loss",true],["Lacteal Routing Of Absorbed Lipid",true],["Starling Forces And Lymph Formation Rate",false],["Cannulated Lymph Sampling As A Permeability Assay",false]]},
];

// An objective the QUESTION side tests but the flashcard deck never covers.
// Reported, not created: a concept with questions and no cards is a content
// authoring gap, and minting an object for it here would be premature.
export const CARD_GAPS = [
 {objective:"Oxygen delivery and extraction", questions:["Oxygen Content Versus Percent Saturation","Dissolved Oxygen As A Fraction Of Content","Oxygen Delivery As Flow Times Content","Regional Extraction Reserve","Widening Extraction At Peak Exercise","Circulatory Hypoxia With Normal Arterial Content"],
  why:"Six questions test oxygen content versus saturation, delivery as flow times content, and extraction reserve. No flashcard in the Cardiovascular deck teaches any of it. The deck's oxygen cards (66 to 73) cover hemoglobin binding and CO2 carriage, which already live on the biochemistry concepts Oxygen-Binding Proteins, Cooperativity and Bicarbonate Buffer. This is a deck gap to fill with new cards, not an ontology gap."},
];

CARD_GAPS.push({objective:"Endothelial control of vascular tone", questions:["Endothelial Control of Tissue Perfusion","Testing Endothelial Function in Isolated Vessels","Consequences of Endothelial Denudation","Flow Redistribution And Vascular Resistance"],
 why:"Four questions test endothelium-derived vasodilation matching perfusion to demand. The deck's endothelium cards (29, 30) are structural and sit on Blood Vessel Structure and Types. No card teaches local flow control, so there is nothing to anchor a concept to yet. Report, do not mint."});

// ─── Pre-SQL forensic check on the skeletal-muscle-pump card ──────────────────
// The card: "Contracting skeletal muscles compress the blood vessels running
// through them; their one-way valves block backflow, so this pump raises
// {{c1::venous return}}."
//
// The cloze is on VENOUS RETURN. The valves appear in the stem as given
// information, not as the tested content, so performance on this card is
// evidence about the physiological mechanism raising venous return, not about
// venous wall architecture. A learner could answer it correctly knowing nothing
// about the tunica media, the artery/vein classification or capacitance, which
// is what Blood Vessel Structure and Types is for (its cards 28 to 34).
//
// Searched the whole ontology for venous return, preload, filling, capacitance
// and Frank-Starling. The only matches are the two one-question cardio labels
// this pass is retiring. No durable home exists.
//
// So the mapping is NOT defensible and this card is held rather than forced.
export const PENDING_CANDIDATE = {
 name:"Venous Return and Preload",
 def:"The peripheral determinants of the volume returning to the heart: the skeletal-muscle pump acting through one-way valves, venoconstriction mobilising the venous reservoir, and the effect on ventricular filling.",
 cards:[["The Musculoskeletal System",76]],
 conf:"MEDIUM",
 q:[["Venous Return and the Skeletal Muscle Pump",true],["Venoconstriction and Venous Resistance",true],
    ["Head-Up Tilt And Resistance Adjustment",false],["Atrial Systole and Ventricular Filling",false],["Matched Ventricular Outputs",false]],
 why:"One card and two exact questions. Narrow, but a distinct objective: a learner can know cardiac output as HR times SV perfectly and still not know that the muscle pump or venoconstriction raises return. Folding it into Cardiac Output and Stroke Volume would make a peripheral-circulation weakness read as a cardiac-output weakness, which is the same argument used to keep Types of Reactions separate from Reaction Types & Classification.",
 alsoChanges:"If approved, the two exact questions move off Blood Vessel Structure and Types in ALIGN_APPROVED and onto this concept. That is a note for the later question migration, not a change to the backfill.",
};
