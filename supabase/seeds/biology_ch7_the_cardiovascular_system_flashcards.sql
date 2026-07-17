-- ════════════════════════════════════════════════════════════════════
-- Biology Chapter 7 — The Cardiovascular System
-- ════════════════════════════════════════════════════════════════════
-- Section: biology
-- Topic:   Body Systems
-- Subtopic slug: the_cardiovascular_system
-- Sort order: 7
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--    1. Heart — Chambers & Valves
--    2. Cardiac Conduction & the Cardiac Cycle
--    3. Cardiac Output & Autonomic Control
--    4. Pulmonary & Systemic Circulation
--    5. Vasculature & Endothelium
--    6. Capillary Exchange & Starling Forces
--    7. Blood Pressure & Its Regulation
--    8. Composition of Blood
--    9. Blood Groups (ABO, Rh)
--   10. Oxygen & CO₂ Transport
--   11. Coagulation
--   12. Portal Systems
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Anatomy & Physiology 2e (Ch 18 Blood, Ch 19 Cardiac System,
-- Ch 20 Cardiovascular System: Blood Vessels & Circulation) and OpenStax
-- Biology 2e (Ch 40 The Circulatory System). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biology'
      AND title IN (
          'The Cardiovascular System',
          'Cardiovascular System',
          'Biology Review Chapter Seven: The Cardiovascular System'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biology',
        'Body Systems',
        'the_cardiovascular_system',
        'The Cardiovascular System',
        'The four-chambered heart, cardiac conduction and output, pulmonary and systemic circulation, vessels and capillary exchange, blood pressure regulation, blood composition and typing, oxygen and CO₂ transport, coagulation, and portal systems.',
        7
    )
    RETURNING id INTO deck;

    -- ── Heart — Chambers & Valves ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'Blood delivers {{c1::oxygen, nutrients, and hormones}} to cells throughout the body.',
     1),
    (deck, 1, 'cloze',
     'The heart has four chambers: two upper {{c1::atria}} and two lower {{c2::ventricles}}.',
     2),
    (deck, 2, 'cloze',
     'The atria are the heart''s {{c1::receiving}} chambers; the ventricles are its {{c1::pumping}} chambers.',
     1),
    (deck, 3, 'cloze',
     'The {{c1::interventricular septum}} keeps oxygenated blood in the left ventricle separate from deoxygenated blood in the right.',
     1),
    (deck, 4, 'cloze',
     'The atrioventricular valves are the {{c1::tricuspid}} valve on the right and the {{c1::bicuspid (mitral)}} valve on the left.',
     1),
    (deck, 5, 'cloze',
     'The semilunar valves are the {{c1::pulmonary}} valve on the right and the {{c1::aortic}} valve on the left.',
     1),
    (deck, 6, 'cloze',
     'The right atrioventricular valve has {{c1::three}} cusps, whereas the left atrioventricular valve has {{c1::two}} cusps.',
     1);

    -- ── Cardiac Conduction & the Cardiac Cycle ──────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
     'Cardiac impulse conduction runs SA node → {{c1::AV node}} → {{c1::bundle of His}} → {{c1::Purkinje fibers}}.',
     1),
    (deck, 8, 'cloze',
     'The heart''s {{c1::pacemaker}}, which sets the sinus rhythm, is the {{c1::sinoatrial (SA) node}} in the right atrium.',
     1),
    (deck, 9, 'cloze',
     'Because the SA node is myogenic, it depolarizes on its own — with no nervous input — about {{c1::80–100}} times per minute.',
     1),
    (deck, 10, 'cloze',
     'The {{c1::AV node}} delays the impulse about 100 ms, letting the atria finish contracting so the ventricles fill before ventricular systole.',
     1),
    (deck, 11, 'cloze',
     '{{c1::Systole}} is the phase of muscle contraction that ejects blood, while {{c1::diastole}} is the phase of relaxation during which the chambers refill.',
     1),
    (deck, 12, 'cloze',
     'The first heart sound, S1 (''lub''), is produced by closure of the {{c1::atrioventricular (AV) valves}} at the onset of ventricular systole.',
     1),
    (deck, 13, 'cloze',
     'The second heart sound, S2 (''dub''), is produced by closure of the {{c1::semilunar valves}} at the onset of ventricular diastole.',
     1);

    -- ── Cardiac Output & Autonomic Control ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 14, 'cloze',
     'Cardiac output, the volume of blood each ventricle pumps per minute, equals {{c1::heart rate}} × {{c1::stroke volume}}.',
     1),
    (deck, 15, 'cloze',
     'Stroke volume is the amount of blood a single ventricle ejects per {{c1::beat}}.',
     1),
    (deck, 16, 'cloze',
     'At rest, the cardiac output of each ventricle is roughly {{c1::5}} liters per minute.',
     1),
    (deck, 17, 'cloze',
     'Sympathetic cardiac nerves release the neurotransmitter {{c1::norepinephrine}}, speeding SA-node depolarization to raise heart rate and contractility.',
     1),
    (deck, 18, 'cloze',
     'The {{c1::vagus}} nerve carries parasympathetic signals that slow the heart, releasing {{c2::acetylcholine}} onto the SA node.',
     2),
    (deck, 19, 'cloze',
     'As an endocrine signal, the adrenal medulla secretes {{c1::epinephrine}} into the blood, raising heart rate during the fight-or-flight response.',
     1);

    -- ── Pulmonary & Systemic Circulation ────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
     'The {{c1::pulmonary}} circuit carries blood between the heart and the lungs, while the {{c2::systemic}} circuit carries blood between the heart and the rest of the body''s tissues.',
     2),
    (deck, 21, 'cloze',
     'The pulmonary arteries are the only arteries that carry {{c1::deoxygenated}} blood, transporting it from the right ventricle to the lungs for gas exchange.',
     1),
    (deck, 22, 'cloze',
     'The pulmonary veins are the exception among veins in the body: they carry {{c1::oxygenated}} blood.',
     1),
    (deck, 23, 'cloze',
     'In the pulmonary circuit, the {{c1::right ventricle}} pumps blood to the lungs, which return it through the pulmonary veins to the {{c2::left atrium}}.',
     2),
    (deck, 24, 'cloze',
     'In the systemic circuit, the {{c1::left ventricle}} pumps oxygenated blood into the aorta, and the {{c2::venae cavae}} return blood to the right atrium.',
     2),
    (deck, 25, 'cloze',
     'The left ventricle''s wall is far thicker than the right''s because the systemic circuit forces it to generate much higher {{c1::pressure}} against greater {{c1::resistance}}.',
     1),
    (deck, 26, 'cloze',
     'Even though the left ventricle''s wall is much thicker, both ventricles eject the {{c1::same}} volume of blood per contraction.',
     1);

    -- ── Vasculature & Endothelium ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 27, 'cloze',
     'Arteries carry blood {{c1::away from}} the heart, while veins carry blood {{c1::toward}} the heart.',
     1),
    (deck, 28, 'cloze',
     'The inner surface of every blood vessel is lined by the {{c1::endothelium}}, which is composed of {{c2::simple squamous}} epithelial cells.',
     2),
    (deck, 29, 'cloze',
     'The endothelium is continuous throughout the entire vascular system and also lines the {{c1::chambers of the heart}}.',
     1),
    (deck, 30, 'cloze',
     'A vessel''s {{c1::middle}} layer, the {{c1::tunica media}}, is composed mainly of {{c2::smooth muscle}} and is the thickest wall layer in arteries.',
     2),
    (deck, 31, 'cloze',
     'Arterioles, the smallest arteries, regulate blood flow into capillary beds and are the body''s main {{c1::resistance}} vessels.',
     1),
    (deck, 32, 'cloze',
     'Because they carry blood at {{c1::low}} pressure, veins have {{c2::valves}} — absent in arteries — that stop blood from flowing backward.',
     2),
    (deck, 33, 'cloze',
     'Veins are called {{c1::capacitance}} vessels because they store about {{c2::64%}} of the total blood volume at any moment.',
     2),
    (deck, 34, 'cloze',
     'A capillary wall consists of just a single layer of {{c1::endothelial}} cells resting on a {{c2::basement membrane}}.',
     2);

    -- ── Capillary Exchange & Starling Forces ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
     'Because their walls are only {{c1::one endothelial cell}} thick, capillaries are where gases and solutes are exchanged with the tissues.',
     1),
    (deck, 36, 'cloze',
     'Gases and small solutes cross the capillary wall individually by {{c1::diffusion}}, whereas whole volumes of fluid move by bulk flow.',
     1),
    (deck, 37, 'cloze',
     'The two Starling forces that govern fluid movement across a capillary are {{c1::hydrostatic pressure}} and {{c1::oncotic (colloid osmotic) pressure}}.',
     1),
    (deck, 38, 'cloze',
     'Fluid is filtered out at a capillary''s arterial end, where {{c1::hydrostatic}} pressure dominates, and reabsorbed at the venule end, where {{c1::oncotic}} pressure dominates.',
     1),
    (deck, 39, 'cloze',
     'The oncotic pressure that pulls fluid back into capillaries is generated by plasma {{c1::proteins}}, chiefly {{c1::albumin}}, which are too large to leave the blood.',
     1),
    (deck, 40, 'cloze',
     'Blood flows {{c1::slowest}} through the capillaries because their combined cross-sectional area is the largest of any vessel type.',
     1),
    (deck, 41, 'cloze',
     'For thermoregulation, dermal arterioles {{c1::dilate}} to route warm blood to the skin and shed heat, or {{c1::constrict}} to hold blood in the core and conserve heat.',
     1);

    -- ── Blood Pressure & Its Regulation ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'Blood pressure is defined as the force per unit area exerted by circulating blood on the {{c1::vessel walls}}.',
     1),
    (deck, 43, 'cloze',
     'Systolic pressure is the arterial pressure during ventricular {{c1::contraction}}, while diastolic pressure is the pressure during ventricular {{c1::relaxation}}.',
     1),
    (deck, 44, 'cloze',
     'A typical normal adult blood pressure is about {{c1::120}}/{{c2::80}} mmHg, expressed as systolic over diastolic.',
     2),
    (deck, 45, 'cloze',
     'The {{c1::arterioles}} are the site of greatest resistance in the circulation, so their vasoconstriction and vasodilation are the main regulators of systemic blood pressure.',
     1),
    (deck, 46, 'cloze',
     'The arterial baroreceptors that monitor blood pressure are located in the {{c1::carotid sinus}} and the {{c1::aortic arch}}.',
     1),
    (deck, 47, 'cloze',
     'Circulation follows an Ohm''s-law analogy: mean arterial pressure = cardiac output × {{c1::total peripheral resistance}}, i.e. ΔP = CO × {{c1::TPR}}.',
     1),
    (deck, 48, 'cloze',
     'A drop in blood pressure stimulates secretion of {{c1::aldosterone}} and {{c1::ADH (antidiuretic hormone)}}, hormones that restore blood volume and pressure.',
     1),
    (deck, 49, 'cloze',
     'In response to high blood pressure, the heart secretes {{c1::atrial natriuretic peptide (ANP)}}, which lowers blood volume and pressure.',
     1),
    (deck, 50, 'cloze',
     'Increased blood {{c1::osmolarity}} triggers release of antidiuretic hormone (ADH), which drives water reabsorption by the kidneys.',
     1);

    -- ── Composition of Blood ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     'By volume, human blood is roughly {{c1::55}}% plasma and {{c1::45}}% formed elements (blood cells and platelets).',
     1),
    (deck, 52, 'cloze',
     'Plasma, the liquid matrix of blood, is about {{c1::92}}% water, with dissolved proteins, ions, nutrients, gases, hormones, and wastes.',
     1),
    (deck, 53, 'cloze',
     'Mature erythrocytes are {{c1::biconcave}} discs, a shape that maximizes surface area for exchanging the O₂ they carry on hemoglobin.',
     1),
    (deck, 54, 'cloze',
     '{{c1::Hematocrit}} is the percentage of blood volume occupied by erythrocytes, normally about {{c2::45}}%.',
     2),
    (deck, 55, 'cloze',
     'Erythrocytes are produced in the {{c1::bone marrow}} and circulate for roughly {{c2::120}} days before being removed.',
     2),
    (deck, 56, 'cloze',
     'Worn-out erythrocytes are engulfed by {{c1::macrophages}} in the {{c2::spleen and liver}}, which recycle their iron and amino acids.',
     2),
    (deck, 57, 'cloze',
     'Leukocytes (white blood cells) originate in the {{c1::bone marrow}} and are the formed elements that carry out the {{c2::immune}} response.',
     2),
    (deck, 58, 'cloze',
     'Among the formed elements, only {{c1::leukocytes}} keep a nucleus; {{c1::erythrocytes and platelets}} are anucleate.',
     1),
    (deck, 59, 'cloze',
     'Platelets are cell fragments shed from {{c1::megakaryocytes}} in the bone marrow, and they function in blood {{c2::clotting}}.',
     2);

    -- ── Blood Groups (ABO, Rh) ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 60, 'cloze',
     'For ABO blood type, alleles A and B show {{c1::codominance}}, while allele i (type O) is {{c1::recessive}}.',
     1),
    (deck, 61, 'cloze',
     'In the ABO system, a person''s plasma naturally holds antibodies against {{c1::whichever A or B antigens their own red cells lack}}.',
     1),
    (deck, 62, 'cloze',
     'Unlike preformed ABO antibodies, anti-Rh antibodies form in an Rh-negative person only after {{c1::exposure to Rh-positive blood}}.',
     1),
    (deck, 63, 'cloze',
     'When a patient needs a transfusion but can''t be cross-matched, the safest red cells come from a type {{c1::O⁻}} donor.',
     1),
    (deck, 64, 'cloze',
     'A recipient who can safely accept red blood cells of any ABO or Rh type has blood type {{c1::AB⁺}}.',
     1);

    -- ── Oxygen & CO₂ Transport ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 65, 'cloze',
     'Each O₂ that binds hemoglobin {{c1::increases}} the O₂ affinity of its remaining subunits, and each O₂ released {{c1::decreases}} it.',
     1),
    (deck, 66, 'cloze',
     'Because hemoglobin binds O₂ cooperatively, its oxygen dissociation curve is {{c1::sigmoidal (S-shaped)}} rather than hyperbolic.',
     1),
    (deck, 67, 'cloze',
     'High PO₂ in the {{c1::lungs}} loads O₂ onto hemoglobin, while low PO₂ in the {{c1::tissues}} unloads it.',
     1),
    (deck, 68, 'cloze',
     'Four factors shift the oxygen–hemoglobin dissociation curve right (decreasing O₂ affinity): high {{c1::CO₂}}, high {{c1::H⁺/low pH}}, high {{c1::temperature}}, and high {{c1::2,3-BPG}}.',
     1),
    (deck, 69, 'cloze',
     'The {{c1::Bohr}} effect: rising CO₂ and H⁺ (falling pH) lower hemoglobin''s O₂ affinity, promoting O₂ unloading in active tissues.',
     1),
    (deck, 70, 'cloze',
     'Fetal hemoglobin has {{c1::higher}} O₂ affinity than adult hemoglobin, so its dissociation curve sits to the {{c1::left}}.',
     1),
    (deck, 71, 'cloze',
     'CO₂ is carried in blood three ways: ~70% as {{c1::bicarbonate (HCO₃⁻)}}, ~23% as {{c2::carbaminohemoglobin}}, and ~7% {{c3::dissolved in plasma}}.',
     3),
    (deck, 72, 'cloze',
     'In red blood cells, {{c1::carbonic anhydrase}} catalyzes CO₂ + H₂O ⇌ H₂CO₃ ⇌ H⁺ + HCO₃⁻.',
     1);

    -- ── Coagulation ─────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 73, 'cloze',
     'When a blood vessel is injured, the newly exposed {{c1::collagen}} and {{c1::tissue factor}} set hemostasis and the coagulation cascade in motion.',
     1),
    (deck, 74, 'cloze',
     '{{c1::Primary}} hemostasis forms the platelet plug, whereas {{c1::secondary}} hemostasis is the coagulation cascade that reinforces it with fibrin.',
     1),
    (deck, 75, 'cloze',
     'In the common pathway, inactive {{c1::prothrombin}} is converted into the active enzyme {{c1::thrombin}}, which drives clot formation.',
     1),
    (deck, 76, 'cloze',
     'Thrombin catalyzes the final step, converting soluble {{c1::fibrinogen}} into insoluble {{c1::fibrin}} strands that form the clot''s mesh.',
     1),
    (deck, 77, 'cloze',
     'During fibrinolysis, the active enzyme {{c1::plasmin}} breaks down the fibrin mesh, dissolving the clot to restore blood flow.',
     1);

    -- ── Portal Systems ──────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 78, 'cloze',
     'In a portal system, a vessel connects {{c1::two}} capillary beds in {{c1::series}}, so blood drains one bed into the next rather than returning directly to the heart.',
     1),
    (deck, 79, 'cloze',
     'The hepatic portal system carries blood from the {{c1::intestinal (gut)}} capillary beds, through the hepatic portal vein, to the liver.',
     1),
    (deck, 80, 'cloze',
     'The hypophyseal portal system carries blood from a primary capillary plexus in the {{c1::hypothalamus}} to a secondary plexus in the {{c2::anterior pituitary}}.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 81;
END $$;
