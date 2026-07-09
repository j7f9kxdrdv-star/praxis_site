-- ════════════════════════════════════════════════════════════════════
-- Biology Chapter 6 — The Respiratory System
-- ════════════════════════════════════════════════════════════════════
-- Section: biology  |  Topic: Body Systems  |  Subtopic slug: the_respiratory_system  |  Sort order: 6
--
-- Coverage (AAMC-aligned order, NOT mirroring the source chapter outline):
--    1. Upper Airway Anatomy
--    2. Lower Airway & Conducting Zone
--    3. Alveoli & the Respiratory Membrane
--    4. Pleurae & the Thoracic Cavity
--    5. Inhalation Mechanics
--    6. Exhalation & Elastic Recoil
--    7. Lung Volumes & Capacities
--    8. Neural Control of Breathing
--    9. Chemoreceptor Regulation
--   10. Gas Exchange & Pulmonary Circulation
--   11. Thermoregulation
--   12. Immune Defense
--   13. pH Control & the Bicarbonate Buffer
--
-- Idempotent: re-running wipes any prior version of this deck (matching historical
-- titles) and reseeds from scratch.
--
-- All cards are original Praxist Prep prose. Facts cross-verified against
-- OpenStax Anatomy & Physiology 2e (Ch 22 The Respiratory System) with OpenStax Biology 2e (Ch 39) as secondary.
-- See companion .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biology'
      AND title IN (
          'The Respiratory System',
          'Respiratory System',
          'Biology Review Chapter Six: The Respiratory System',
          'Biology Review Chapter 6: The Respiratory System'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biology',
        'Body Systems',
        'the_respiratory_system',
        'The Respiratory System',
        'Airway anatomy from nose to alveoli, the mechanics of breathing (Boyle''s law, negative-pressure inhalation, elastic recoil), lung volumes and capacities, neural and chemoreceptor control of ventilation, alveolar gas exchange and pulmonary circulation, and the system''s secondary roles in thermoregulation, immune defense, and pH/bicarbonate buffering.',
        6
    )
    RETURNING id INTO deck;

    -- ── Upper Airway Anatomy ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'Inhaled air first enters through the {{c1::external nares (nostrils)}}, sweeps through the {{c2::nasal cavity}} where conchae warm and filter it, then passes via the internal nares into the {{c3::pharynx}} before reaching the {{c4::larynx}}, which caps the upper airway and channels air onward to the trachea.',
     4),
    (deck, 1, 'cloze',
     'Before air ever reaches the lungs, the nasal cavity conditions it by {{c1::filtering, warming, and humidifying}} the incoming stream; coarse debris is caught by nasal hairs ({{c2::vibrissae}}), while finer particulates stick to the {{c3::mucus (mucous membrane)}} coating the respiratory epithelium.',
     3),
    (deck, 2, 'cloze',
     'The pharynx serves double duty: inhaled air and swallowed food travel this shared corridor together until the laryngopharynx, where the two streams split — air passes anteriorly into the {{c1::larynx}} while food is routed posteriorly into the {{c2::esophagus}}.',
     2),
    (deck, 3, 'cloze',
     'The vocal cords sit inside the {{c1::larynx}}, and its opening — the {{c2::glottis}} — is sealed during swallowing when the {{c3::epiglottis}} swings inferiorly across it, routing the bolus toward the esophagus and away from the trachea.',
     3),
    (deck, 4, 'cloze',
     'During swallowing, the larynx rises and the {{c1::epiglottis}}—a leaf-shaped flap of {{c2::elastic cartilage}}—folds down over the glottis, sealing the trachea so the bolus is diverted into the {{c3::esophagus}} instead of the airway.',
     3);

    -- ── Lower Airway & Conducting Zone ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 5, 'cloze',
     'Below the larynx, inhaled air travels the trachea to the {{c1::carina}}, the ridge where it splits into the {{c2::right and left mainstem (primary) bronchi}}; each bronchus then divides repeatedly through the bronchial tree into ever-narrower bronchioles, ending at the {{c3::terminal bronchioles}} that hand air off to the gas-exchange (respiratory) zone.',
     3),
    (deck, 6, 'cloze',
     'Because the esophagus runs directly behind the trachea, the airway can''t be a rigid tube — instead, 16 to 20 stacked rings of {{c1::hyaline}} cartilage, each shaped like a {{c2::C}} (open on the posterior side), brace the trachea against collapse; the gap is bridged by the {{c3::trachealis muscle}}, letting the esophagus bulge forward during swallowing.',
     3),
    (deck, 7, 'cloze',
     'Whatever debris slips past the nose and mouth meets the trachea and bronchi, whose {{c1::pseudostratified ciliated columnar}} epithelium (studded with mucus-secreting goblet cells) forms a {{c2::mucociliary escalator}} — its cilia beat in unison to drive trapped particles upward toward the throat to be swallowed.',
     2),
    (deck, 8, 'cloze',
     'Air travels but never crosses into blood along the {{c1::conducting}} zone (trachea down through the terminal bronchioles); actual O2/CO2 diffusion is confined to the {{c2::respiratory}} zone, which begins at the respiratory bronchioles and terminates in the {{c3::alveoli}}.',
     3);

    -- ── Alveoli & the Respiratory Membrane ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
     'Gas exchange happens in the {{c1::alveoli}} — clusters of tiny, grape-like sacs budding off the alveolar ducts at the tips of the bronchiole tree; because so many crowd the lungs, their walls together present a respiratory surface of roughly {{c2::70}} square meters.',
     2),
    (deck, 10, 'cloze',
     'Scattered among the thin type I cells of the alveolar wall, the cuboidal {{c1::type II alveolar cells}} release {{c2::pulmonary surfactant}}, a phospholipid-protein film that {{c3::lowers the surface tension}} of the watery alveolar lining and stops the alveoli from collapsing at the end of exhalation.',
     3),
    (deck, 11, 'cloze',
     'Because flat {{c1::type I alveolar cells}} tile the alveolar wall as a layer just {{c2::one cell}} thick, an O2 or CO2 molecule crosses the respiratory membrane by traversing a barrier only ~{{c3::0.5 μm}} deep — the short {{c4::diffusion distance}} that lets simple diffusion keep pace with gas exchange.',
     4),
    (deck, 12, 'cloze',
     'A {{c1::pulmonary capillary network}} sheathes every alveolus, so venous blood ends up a fraction of a micron from the alveolar air; the two thin walls fuse into the {{c2::respiratory membrane}} — only about {{c3::0.5 μm}} thick — across which O2 and CO2 diffuse.',
     3),
    (deck, 13, 'cloze',
     'The lung''s gas-exchange efficiency traces to its enormous {{c1::surface area}}: the airway tree branches down into roughly {{c2::300 million}} alveoli per lung, spreading the diffusion barrier across about {{c3::75 m²}} of respiratory membrane.',
     3),
    (deck, 14, 'cloze',
     'Strip the alveoli of surfactant and the water lining them exerts {{c1::high surface tension}}, which {{c2::collapses the alveoli and makes reinflation difficult}} — the failure mode seen in respiratory distress syndrome.',
     2);

    -- ── Pleurae & the Thoracic Cavity ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'Two layers of serous membrane wrap each lung: the {{c1::visceral}} pleura hugs the lung surface (dipping into its fissures), while the {{c2::parietal}} pleura anchors to the thoracic wall, mediastinum, and diaphragm.',
     2),
    (deck, 16, 'cloze',
     'Two layers of serous membrane sandwich each lung: the {{c1::visceral}} pleura clings to the lung surface while the {{c2::parietal}} pleura lines the thoracic wall, and between them sits the sealed, fluid-filled {{c3::pleural cavity}} whose fluid lets the lung expand tight against the chest wall as the thorax enlarges.',
     3),
    (deck, 17, 'cloze',
     'Separating the thorax from the abdomen sits the {{c1::diaphragm}}, a {{c2::dome-shaped}} sheet of skeletal muscle that drives inhalation: as it contracts it flattens and drops {{c3::inferiorly (toward the abdomen)}}, enlarging the thoracic cavity and drawing air in.',
     3),
    (deck, 18, 'cloze',
     'Although its resting rhythm is set involuntarily by the {{c1::medulla oblongata}} (an autonomic-style brainstem drive), the diaphragm is histologically {{c2::skeletal muscle}}, so it also answers to {{c3::somatic (voluntary)}} commands from the cerebral cortex — which is exactly how you can consciously hold your breath.',
     3),
    (deck, 19, 'cloze',
     'A lung has no muscle of its own, so inspiration depends on {{c1::skeletal muscles (the diaphragm and external intercostals)}} contracting to enlarge the thoracic cavity; the {{c2::adhesive force of the pleural fluid}} drags the lungs open along with the expanding chest wall, and this added volume drops intra-alveolar pressure {{c3::below atmospheric pressure}}, so air flows down the resulting gradient into the airways.',
     3);

    -- ── Inhalation Mechanics ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 20, 'cloze',
     'Quiet inhalation demands muscular work, making it an {{c1::active}} process: the {{c2::diaphragm}} drops inferiorly while the {{c3::external intercostal}} muscles pull the ribs up and out, together enlarging the thoracic cavity and dropping intra-alveolar pressure below atmospheric. (Ordinary exhalation, by contrast, is {{c1::passive}}, driven only by elastic recoil.)',
     3),
    (deck, 21, 'cloze',
     'Under {{c1::Boyle''s law}}, a gas held at constant temperature keeps pressure and volume {{c2::inversely}} proportional (P ∝ 1/V), so when inhalation expands the thoracic cavity the enlarged lung volume drops intra-alveolar pressure {{c3::below}} atmospheric pressure and air flows inward.',
     3),
    (deck, 22, 'cloze',
     'During inspiration, the diaphragm {{c1::contracts}} and drops toward the abdomen, so thoracic volume {{c2::rises}}; per {{c3::Boyle''s}} law this expansion drives intra-alveolar pressure {{c4::below atmospheric pressure}}, and air moves down the resulting gradient into the lungs.',
     4),
    (deck, 23, 'cloze',
     'When the diaphragm and external intercostals contract, thoracic volume rises and intra-alveolar pressure {{c1::falls below}} atmospheric pressure, so air flows {{c2::down the pressure gradient into the lungs}}; because inflow is driven by sub-atmospheric alveolar pressure rather than air being pushed in, this mechanism is called {{c3::negative-pressure breathing}}.',
     3),
    (deck, 24, 'cloze',
     'Because the resting diaphragm sits as a {{c1::dome}}, its contraction pulls the muscle {{c2::downward (inferiorly), flattening it}} — enlarging the thoracic cavity to draw air in — while relaxation lets it recoil back up into that {{c1::dome}} shape during quiet expiration.',
     2);

    -- ── Exhalation & Elastic Recoil ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 25, 'cloze',
     'During quiet breathing, inhalation is {{c1::active}} — the diaphragm and external intercostals contract — while quiet exhalation is {{c2::passive}}: those inspiratory muscles simply {{c3::relax}}, and the {{c4::elastic recoil}} of the lung tissue expels the air without any energy expenditure.',
     4),
    (deck, 26, 'cloze',
     'Quiet exhalation costs no energy: the inspiratory muscles simply relax, and the lung''s {{c1::elastic recoil}} (aided by alveolar {{c2::surface tension}}) pulls the tissue inward. As lung volume {{c3::drops}}, intra-alveolar pressure {{c4::rises above}} atmospheric, so air flows outward down that gradient.',
     4),
    (deck, 27, 'cloze',
     'Quiet exhalation rides on elastic recoil, but when you force air out fast, the {{c1::internal intercostals}} and {{c1::abdominal muscles (obliques)}} fire to pull the rib cage {{c2::downward}} and shove the diaphragm upward, collapsing thoracic volume more quickly.',
     2),
    (deck, 28, 'cloze',
     'During quiet exhalation, no muscle work is needed: {{c1::elastic recoil}} of the lung shrinks thoracic and lung volume, which by Boyle''s law drives intra-alveolar (intrapulmonary) pressure {{c2::above}} atmospheric, so air flows {{c3::out of the lungs}} down the resulting gradient.',
     3);

    -- ── Lung Volumes & Capacities ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     'During quiet, resting breathing, each ordinary breath shuttles roughly {{c2::500 mL}} of air in or out of the lungs — a quantity termed the {{c1::tidal volume (TV)}}.',
     2),
    (deck, 30, 'cloze',
     'The one lung volume no voluntary effort can empty is the {{c1::residual volume (RV)}} — the air still trapped in the lungs {{c2::after a maximal forced exhalation}}. Retaining it keeps the {{c3::alveoli}} from collapsing between breaths.',
     3),
    (deck, 31, 'cloze',
     '{{c1::Vital capacity (VC)}} measures the largest volume a person can shift into or out of the lungs, adding up every lung volume except {{c2::residual volume}} — that is, {{c3::TV + ERV + IRV}}.',
     3),
    (deck, 32, 'cloze',
     'After a maximal inhale, the lungs top out at their {{c1::total lung capacity (TLC)}} — roughly {{c2::6 L}} in a typical adult — which you can reconstruct by adding the volume a full exhale expels, {{c3::vital capacity}}, to the air stranded behind it, the {{c4::residual volume}}.',
     4),
    (deck, 33, 'cloze',
     'During a forced, deep breath, the additional air pulled in beyond what a normal quiet inhalation delivers is the {{c1::inspiratory reserve volume}} ({{c1::IRV}}); the reference point it builds on top of is a {{c2::tidal inspiration}}.',
     2),
    (deck, 34, 'cloze',
     'Once a normal quiet breath is out, the volume you can still squeeze out with a forced effort is the {{c1::expiratory reserve volume (ERV)}}, roughly {{c2::1200 mL}} in males; pair it with residual volume and you have the {{c3::functional residual capacity (FRC)}} — the air remaining after a normal tidal exhalation.',
     3),
    (deck, 35, 'cloze',
     'Even after a maximal exhalation, the lungs never fully empty: the air that stubbornly remains is the {{c1::residual volume}}, and its physiological payoff is that it keeps the {{c2::alveoli}} from {{c2::collapsing}} between breaths, so reinflation on the next inhalation stays easy.',
     2);

    -- ── Neural Control of Breathing ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 36, 'cloze',
     'Automatic breathing originates in the {{c1::medulla oblongata}}, whose respiratory-center neurons discharge in a repeating pattern that {{c2::drives the respiratory muscles to contract}}, setting the basic rhythm of ventilation.',
     2),
    (deck, 37, 'cloze',
     'Automatic breathing needs no conscious effort because respiratory centers in the {{c1::medulla oblongata}} set its basic rhythm: the {{c2::ventral respiratory group (VRG)}} generates the pace by driving the diaphragm and external intercostals to contract, while the {{c3::dorsal respiratory group (DRG)}} integrates lung stretch-receptor and peripheral chemoreceptor input to fine-tune that rhythm.',
     3),
    (deck, 38, 'cloze',
     'Breathing runs by default under {{c1::autonomic (involuntary)}} control from the medullary respiratory center, but cortical areas grant {{c2::voluntary (somatic)}} override — letting you hold your breath or speak — until rising CO2 forces the {{c1::autonomic (involuntary)}} system to seize control again.',
     2);

    -- ── Chemoreceptor Regulation ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 39, 'cloze',
     'Under normal conditions, the drive to breathe tracks blood {{c1::CO2}}, not {{c2::O2}} — because CO2 crossing the blood-brain barrier raises {{c3::H+}} (lowering pH), and that acidity is what the {{c4::central}} chemoreceptors of the brainstem actually sense. Peripheral chemoreceptors only ramp up ventilation for O2 once arterial oxygen falls to roughly {{c5::60 mm Hg}} or lower.',
     5),
    (deck, 40, 'cloze',
     'When PaCO2 climbs, dissolved CO2 crosses the blood-brain barrier and lowers CSF pH; {{c1::central chemoreceptors}} in the medulla actually track this {{c2::H+ (falling pH)}} rather than CO2 itself, and drive the respiratory center to {{c3::increase}} rate and depth — venting CO2 until blood levels fall back to baseline (negative feedback).',
     3),
    (deck, 41, 'cloze',
     'Under normal conditions the brain paces breathing off {{c1::CO2}} (via the H+/pH it generates), so oxygen only becomes a significant ventilatory drive once arterial O2 falls to roughly {{c2::60 mm Hg}} or lower — a threshold this low because the {{c3::peripheral}} chemoreceptors sense only dissolved O2, and hemoglobin buffers the drop until levels are quite low.',
     3),
    (deck, 42, 'cloze',
     'Chemoreceptors register rising blood CO2 only {{c1::indirectly}}: the CO2 reacts with water to yield {{c2::carbonic acid (H2CO3)}}, whose dissociation frees {{c3::H+}} ions, and it is that drop in pH — not the CO2 molecule itself — that the receptors actually detect.',
     3),
    (deck, 43, 'cloze',
     'Sitting in the {{c1::carotid and aortic bodies}}, the peripheral chemoreceptors sample arterial {{c2::O2, CO2, and H+}} and relay that status to the brainstem respiratory centers. Because they read dissolved gas rather than hemoglobin-bound stores, a steep O2 drop to roughly {{c3::60 mm Hg}} or lower is needed before they drive ventilation up.',
     3);

    -- ── Gas Exchange & Pulmonary Circulation ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 44, 'cloze',
     'At the alveolar membrane, each gas diffuses passively from {{c1::higher}} to {{c1::lower}} partial pressure, so O₂ crosses {{c2::from the alveolus into the capillary blood}} (~104 → ~40 mm Hg) while CO₂ crosses in the {{c3::opposite}} direction (~45 → ~40 mm Hg); because O₂''s gradient (~64 mm Hg) dwarfs CO₂''s (~5 mm Hg), CO₂ still keeps pace thanks to its much {{c4::greater solubility}}.',
     4),
    (deck, 45, 'cloze',
     'Deoxygenated blood reaching the pulmonary capillaries carries a {{c1::low}} PO₂ (~40 mm Hg) against the alveolus''s ~104 mm Hg, so O₂ diffuses {{c2::into the blood}}; the blood''s higher PCO₂ (~45 vs ~40 mm Hg) drives CO₂ {{c3::out into the alveolus}}, and this partial-pressure-driven exchange at the respiratory membrane is called {{c4::external respiration}}.',
     4),
    (deck, 46, 'cloze',
     'Arteries usually carry oxygenated blood, but the {{c1::pulmonary}} arteries are the exception: they carry {{c2::deoxygenated}} blood along the pulmonary circuit from the {{c3::right ventricle}} toward the lungs, where alveolar capillaries load it with oxygen.',
     3),
    (deck, 47, 'cloze',
     'Breaking the usual vein rule, the {{c1::pulmonary veins}} are the only post-natal veins carrying highly oxygenated blood, delivering it from the lungs to the {{c2::left atrium}}.',
     2),
    (deck, 48, 'cloze',
     'Where alveolar and capillary walls fuse, they build the {{c1::respiratory membrane}}, a barrier only about {{c2::0.5 μm}} thick — thin enough that O2 and CO2 slip across by {{c3::simple diffusion}} rather than active transport.',
     3),
    (deck, 49, 'cloze',
     'At the alveolus during external respiration, O2 travels {{c1::from air into the blood}} while CO2 travels {{c2::from the blood into the air}} — the two gases cross the respiratory membrane in opposite directions because each follows its own {{c3::partial-pressure gradient}} (alveolar PO2 ~104 vs. capillary ~40 mm Hg; capillary PCO2 ~45 vs. alveolar ~40 mm Hg).',
     3),
    (deck, 50, 'cloze',
     'Deoxygenated blood leaves the {{c1::right ventricle}} through the {{c2::pulmonary arteries}} (the only post-natal arteries carrying oxygen-poor blood), reaches the {{c3::pulmonary (lung) capillaries}} to load O₂ at the alveoli, then drains via the {{c4::pulmonary veins}} into the {{c5::left atrium}}, completing the pulmonary circuit.',
     5);

    -- ── Thermoregulation ────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     'Beyond conditioning inhaled air, the respiratory tract''s mucosal blood supply tunes heat balance: {{c1::dilating}} the nasal and tracheal capillaries offloads core heat to the passing airstream, whereas {{c2::constricting}} them keeps that heat in the body. This is why switching to open-mouth breathing, which bypasses the nasal passages, {{c3::increases}} heat loss from the lungs.',
     3),
    (deck, 52, 'cloze',
     'Because its linings stay wet, the airway sheds body heat as water {{c1::evaporates}} from those surfaces and leaves in exhaled breath; in humans, though, the leading route for evaporative cooling is instead {{c2::the skin (sweating)}}.',
     2);

    -- ── Immune Defense ──────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 53, 'cloze',
     'Before inhaled air ever reaches the mucociliary escalator, the coarse hairs lining the nares and nasal vestibule — the {{c1::vibrissae (nasal hairs)}} — act as a mechanical sieve, snagging {{c2::large particulates and debris (e.g., dust, dirt)}} that could otherwise carry pathogens deeper into the airway.',
     2),
    (deck, 54, 'cloze',
     'Nasal secretions carry {{c1::lysozyme}}, an innate-defense enzyme that cleaves the {{c2::peptidoglycan}} of bacterial cell walls; because this thick layer makes up ~90% of the wall and sits exposed in {{c3::Gram-positive}} bacteria (rather than shielded beneath an outer membrane), these organisms are especially vulnerable to its lytic action.',
     3),
    (deck, 55, 'cloze',
     'In the airway, goblet cells secrete a mucus layer that captures inhaled dust and pathogens, while the beating cilia beneath it drive that debris-laden sheet upward toward the pharynx — a clearance mechanism termed the {{c1::mucociliary escalator}}, whose trapped load is ultimately {{c2::swallowed}} into the acidic stomach.',
     2),
    (deck, 56, 'cloze',
     'Of the three cell types lining the alveolar wall, the one drafted from the immune system is the {{c1::alveolar macrophage}}, which roams the alveolar surface and {{c2::phagocytoses}} the debris and pathogens that slip past the airways, then flags the intruder to mobilize a wider immune response.',
     2),
    (deck, 57, 'cloze',
     'In the respiratory tract, plasma cells release {{c1::IgA}} into the mucus film lining the airway; there it binds inhaled microbes and {{c2::neutralizes}} them — coating the pathogen so it can no longer attach to host cell receptors.',
     2),
    (deck, 58, 'cloze',
     'Pulmonary mast cells arm themselves with surface-bound {{c1::IgE}}, which docks via its Fc region to an IgE-specific Fc receptor; an inhaled allergen crosslinks these antibodies, driving {{c2::degranulation}} that discharges {{c3::histamine}} and other inflammatory mediators — the immediate (Type I) hypersensitivity that underlies allergic asthma.',
     3),
    (deck, 59, 'cloze',
     'The respiratory tract stacks its defenses from outermost to innermost: {{c1::physical}} barriers (nasal hairs plus the mucociliary escalator that sweeps trapped particles toward the throat), then {{c2::chemical}} attack via the bacteria-lysing enzyme {{c3::lysozyme}}, then {{c4::cellular}} patrol by {{c5::macrophages}} deep to the epithelium, and finally {{c6::antibody-mediated}} protection led by dimeric {{c7::IgA}}, the only antibody that crosses out to guard mucosal surfaces.',
     7);

    -- ── pH Control & the Bicarbonate Buffer ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 60, 'cloze',
     'In the bicarbonate buffer, {{c1::carbonic anhydrase}} accelerates the hydration of CO2 to carbonic acid (H2CO3), which then dissociates into {{c2::H+ and HCO3-}}; because every step is reversible, exhaling CO2 pulls the whole chain leftward and raises blood pH.',
     2),
    (deck, 61, 'cloze',
     'Arterial blood is held to a narrow pH window: dropping below {{c1::7.35}} defines {{c3::acidosis}}, while climbing above {{c2::7.45}} defines {{c4::alkalosis}}.',
     4),
    (deck, 62, 'cloze',
     'In the reaction CO2 + H2O ⇌ H2CO3 ⇌ HCO3⁻ + H⁺, hyperventilation strips CO2 from the blood, so the equilibrium slides {{c1::left (toward CO2)}}; with fewer H⁺ ions left over, blood pH {{c2::rises}}, tipping the patient toward respiratory {{c3::alkalosis}}.',
     3),
    (deck, 63, 'cloze',
     'In the equilibrium CO2 + H2O ⇌ H2CO3 ⇌ H+ + HCO3−, {{c1::hypoventilation}} lets CO2 accumulate in the blood, which drives the reaction {{c2::rightward}} toward more carbonic acid; the extra H+ liberated {{c3::lowers}} blood pH — the hallmark of respiratory {{c4::acidosis}}.',
     4),
    (deck, 64, 'cloze',
     'When arterial H+ climbs and pH falls, {{c1::peripheral chemoreceptors}} in the aortic arch and carotid arteries fire, driving the medulla to {{c2::raise the respiratory rate}} so that more {{c3::CO2}} is blown off — pulling H+ back down and restoring pH via negative feedback.',
     3),
    (deck, 65, 'cloze',
     'When acid-base balance is disturbed, the {{c1::lungs}} act within {{c2::minutes}} by exhaling {{c3::CO2}} to raise pH, while the {{c4::kidneys}} deliver slower, long-term correction over {{c5::hours to days}} by secreting {{c6::H+}} and conserving {{c7::HCO3- (bicarbonate)}}.',
     7);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 66;
END $$;
