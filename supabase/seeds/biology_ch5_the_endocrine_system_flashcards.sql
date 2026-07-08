-- ════════════════════════════════════════════════════════════════════
-- Biology Chapter 5 — The Endocrine System
-- ════════════════════════════════════════════════════════════════════
-- Section: biology  |  Topic: Body Systems  |  Subtopic slug: the_endocrine_system  |  Sort order: 5
--
-- Coverage (AAMC-aligned order, NOT mirroring the source chapter outline):
--    1. Hormone Classes & Solubility
--    2. Receptor Location
--    3. Second Messengers & Signal Amplification
--    4. Hormone Speed, Duration & Transport
--    5. Direct vs Tropic Hormones & Feedback
--    6. Hypothalamus & the Pituitary Portal System
--    7. Anterior Pituitary
--    8. Posterior Pituitary
--    9. Thyroid
--   10. Parathyroid
--   11. Adrenal Cortex
--   12. Adrenal Medulla
--   13. Pancreas
--   14. Gonads
--   15. Pineal Gland
--   16. Other Endocrine Organs
--
-- Idempotent: re-running wipes any prior version of this deck (matching historical
-- titles) and reseeds from scratch.
--
-- All cards are original Praxist Prep prose. Facts cross-verified against OpenStax
-- Anatomy & Physiology 2e (Ch 17 The Endocrine System) with OpenStax Biology 2e
-- (Ch 37) as secondary. See companion .verification.md for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biology'
      AND title IN (
          'The Endocrine System',
          'Endocrine System',
          'Biology Review Chapter Five: The Endocrine System',
          'Biology Review Chapter 5: The Endocrine System'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biology',
        'Body Systems',
        'the_endocrine_system',
        'The Endocrine System',
        'Hormone chemistry and signaling — peptide, steroid, and amine classes, receptor location, second messengers and amplification, speed/duration, and feedback — then the endocrine glands one by one: hypothalamus and pituitary, thyroid and parathyroid, adrenal cortex and medulla, pancreatic islets, gonads, pineal, and minor endocrine organs.',
        5
    )
    RETURNING id INTO deck;

    -- ── Hormone Classes & Solubility ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'Grouping hormones by chemical structure yields three classes: {{c1::peptide/protein}}, {{c1::steroid}}, and {{c1::amine (amino-acid-derived)}} hormones. Only the {{c2::steroid}} class is built from {{c3::cholesterol}}, making its members hydrophobic and therefore dependent on {{c4::carrier (transport) proteins}} to move through the water-based blood.',
     4),
    (deck, 1, 'cloze',
     'A cell destined to secrete a peptide hormone first builds an oversized, inactive chain called a {{c1::prohormone}} (itself trimmed from a preprohormone); enzymatic {{c2::cleavage}} liberates the active hormone, which is loaded into vesicles and expelled from the cell by {{c3::exocytosis}}.',
     3),
    (deck, 2, 'cloze',
     'Every steroid hormone traces back to a single lipid precursor, {{c1::cholesterol}}, and the tissues that build them are concentrated in two places: the {{c2::adrenal cortex}} and the {{c2::gonads}}.',
     2),
    (deck, 3, 'cloze',
     'Strip the carboxyl off a single {{c1::amino acid}} — usually {{c2::tyrosine}} — and you get an amine hormone; this small class covers the catecholamines {{c3::epinephrine and norepinephrine}} plus the thyroid hormones {{c4::T3 and thyroxine (T4)}}.',
     4),
    (deck, 4, 'cloze',
     'Because blood is water-based, a hormone''s solubility dictates its logistics: peptide and most amine hormones are {{c1::hydrophilic}}, so they dissolve freely in plasma and must dock at {{c3::cell-surface (membrane)}} receptors, whereas steroid and thyroid hormones are {{c2::lipophilic}}, riding through blood on {{c4::transport (carrier) proteins}} and diffusing across the membrane to reach intracellular receptors.',
     4);

    -- ── Receptor Location ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 5, 'cloze',
     'Because they are lipid-soluble, {{c1::steroid}} hormones slip straight through the plasma membrane and dock at {{c2::intracellular (cytosolic/nuclear)}} receptors, while {{c3::peptide (water-soluble)}} hormones—stopped by the lipid bilayer—must signal through receptors on the {{c4::cell surface}} instead.',
     4),
    (deck, 6, 'cloze',
     'Once a steroid hormone reaches its intracellular receptor, the resulting complex behaves as a {{c1::transcription factor}}: docking onto a specific DNA sequence, it {{c2::up- or down-regulates (increases or decreases)}} transcription of the target gene.',
     2),
    (deck, 7, 'cloze',
     'Because a peptide hormone can''t slip through the plasma membrane, it docks on a surface receptor and acts as the {{c1::first messenger}}; the receptor then answers by generating an intracellular {{c2::second messenger}} (such as cAMP) that relays the signal deeper into the cell.',
     2);

    -- ── Second Messengers & Signal Amplification ────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     'Water-soluble hormones relay their signal through intracellular second messengers, three of which recur across endocrine pathways: {{c1::cAMP}}, {{c1::IP3}}, and {{c1::Ca2+}}. G-protein activation of {{c2::adenylyl cyclase}} converts ATP to cAMP, whereas G-protein activation of {{c3::phospholipase C (PLC)}} yields IP3, which in turn triggers {{c4::Ca2+}} release from the smooth endoplasmic reticulum.',
     4),
    (deck, 9, 'cloze',
     'When a peptide hormone (the first messenger) docks on a G-protein-coupled receptor, the freed G protein switches on {{c1::adenylyl cyclase (adenylate cyclase)}}, which converts ATP into the second messenger {{c2::cAMP}}; cAMP then unleashes {{c3::protein kinase A (PKA)}}, whose job is to {{c4::phosphorylate}} downstream target proteins and launch the response.',
     4),
    (deck, 10, 'cloze',
     'A hormone occupies only a handful of surface receptors, yet each tier of the {{c1::phosphorylation cascade}} activates many copies of the next enzyme, so a {{c2::very low}} concentration of hormone launches thousands of intracellular signaling events at once — the hallmark of signal {{c3::amplification}}.',
     3);

    -- ── Hormone Speed, Duration & Transport ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 11, 'cloze',
     'A peptide hormone''s second-messenger cascade fires within seconds, so its effect is {{c1::rapid}} in onset but {{c2::brief::lasting how long?}} in duration — once {{c3::phosphodiesterase (PDE)}} degrades the {{c4::cAMP}} second messenger, the target cell''s response ceases unless fresh hormone keeps binding the surface receptor.',
     4),
    (deck, 12, 'cloze',
     'A steroid hormone diffuses through the membrane, binds an intracellular receptor, and the complex docks on DNA to drive {{c1::transcription}} — so its effects are {{c2::slow to appear}} yet {{c3::long-lasting}}, because reshaping the cell''s pools of {{c4::mRNA and protein}} outlasts any brief membrane signal.',
     4),
    (deck, 13, 'cloze',
     'Steroid hormones are built from cholesterol, so they dissolve poorly in the {{c1::water-based}} plasma and must be ferried to their targets bound to {{c2::transport (carrier) proteins}}. Riding along a carrier rather than floating free also stretches their {{c3::half-life}}, which is why cortisol persists for roughly 60–90 minutes while a free amino acid–derived hormone like epinephrine clears in about a minute.',
     3),
    (deck, 14, 'cloze',
     'Carrier proteins keep most of a lipid-soluble hormone in a {{c1::bound}}, biologically {{c2::inactive}} reservoir; only the {{c3::free (unbound)}} fraction can cross the target cell membrane and engage its receptor, so the hormone must {{c4::dissociate}} from its carrier before it can act.',
     4);

    -- ── Direct vs Tropic Hormones & Feedback ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'Classifying a hormone by where it lands: a {{c1::direct}} hormone binds receptors on its ultimate target tissue and triggers the response itself, while a {{c2::tropic}} hormone instead switches another endocrine gland on or off, prompting that gland to secrete a {{c3::second (downstream)}} hormone — as when ACTH drives the adrenal cortex to release cortisol.',
     3),
    (deck, 16, 'cloze',
     'Once a hormone reaches adequate blood concentrations, {{c1::negative feedback}} kicks in: the hormone (or a downstream product) {{c2::inhibits}} the earlier, upstream steps that drove its own secretion, clamping its levels within a {{c3::narrow range}} and heading off overproduction. In the classic thyroid loop, rising T3 and T4 {{c2::inhibit}} the release of TRH and TSH from the hypothalamus and anterior pituitary.',
     3),
    (deck, 17, 'cloze',
     'Nearly all endocrine axes run on negative feedback, so {{c1::positive}} feedback is the exception—the textbook example being {{c2::oxytocin}} in labor: it triggers uterine contractions that {{c3::stretch the cervix}}, and the dilating cervix signals the hypothalamus and pituitary to release still more of the hormone, escalating contractions until birth.',
     3);

    -- ── Hypothalamus & the Pituitary Portal System ──────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     'Because a nervous-system stimulus must pass through it to be translated into a hormonal signal, the {{c1::hypothalamus}} serves as the functional junction between the {{c2::nervous and endocrine}} systems, issuing the releasing and inhibiting commands that govern the {{c3::pituitary}} gland.',
     3),
    (deck, 19, 'cloze',
     'Because releasing and inhibiting hormones from the {{c1::hypothalamus}} travel through the {{c2::hypophyseal portal}} vessels straight to the {{c3::anterior}} pituitary rather than looping through the general bloodstream first, they act at concentrations far too low to register in {{c4::systemic circulation}}.',
     4),
    (deck, 20, 'cloze',
     'Traveling down the hypophyseal portal veins, four hypothalamic releasing hormones each switch on a specific anterior-pituitary output: {{c1::GnRH}} drives release of the gonadotropins FSH and LH, {{c2::GHRH}} triggers GH, {{c3::TRH}} triggers TSH, and {{c4::CRH (CRF)}} triggers ACTH.',
     4),
    (deck, 21, 'cloze',
     'The hypothalamus reaches its two pituitary lobes by opposite routes: it commands the anterior lobe {{c1::hormonally}}, dispatching releasing and inhibiting factors through the {{c2::hypophyseal portal system}}, whereas it wires the posterior lobe {{c3::neurally}} — the {{c4::axons}} of its paraventricular and supraoptic neurons descend into the posterior pituitary and release their hormones there directly.',
     4),
    (deck, 22, 'cloze',
     'Because the posterior pituitary holds only axon terminals, it {{c1::synthesizes no hormones of its own}} — instead, {{c2::hypothalamic}} neurons build ADH and oxytocin, then ferry them down their {{c3::axons}} to be stored and released from those terminals.',
     3);

    -- ── Anterior Pituitary ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 23, 'cloze',
     'Four anterior-pituitary hormones qualify as tropic (gland-turning): the gonadotropins {{c1::FSH and LH}} act on the {{c2::gonads}}, while {{c3::ACTH}} drives the {{c4::adrenal cortex}} and {{c5::TSH}} drives the {{c6::thyroid}}.',
     6),
    (deck, 24, 'cloze',
     'The anterior pituitary''s two gonadotropins, {{c1::FSH}} and {{c1::LH}}, target the gonads and are secreted only when the hypothalamus signals upstream by releasing {{c2::GnRH}}.',
     2),
    (deck, 25, 'cloze',
     'Traced upstream, glucocorticoid output from the adrenal cortex depends on {{c1::ACTH}} from the anterior pituitary, whose own release is switched on by {{c2::CRH (corticotropin-releasing hormone)}} descending from the hypothalamus. The cortex target reflects ACTH''s name: {{c3::adrenocorticotropic}} hormone.',
     3),
    (deck, 26, 'cloze',
     'Unlike the anterior pituitary''s tropic hormones, three of its secretions bypass other glands and act straight on non-endocrine tissue: {{c1::growth hormone}} drives protein synthesis in bone and skeletal muscle, {{c2::prolactin}} stimulates the mammary glands to make milk, and {{c3::endorphins}}, as brain opioid peptides, blunt pain perception.',
     3),
    (deck, 27, 'cloze',
     'Unlike other anterior pituitary hormones, {{c1::prolactin}} is held under tonic inhibitory control: the hypothalamus continuously releases {{c2::dopamine}} (prolactin-inhibiting hormone), which suppresses prolactin secretion until that brake is lifted.',
     2),
    (deck, 28, 'cloze',
     'In a child whose growth plates have not yet fused, oversecretion of growth hormone from the anterior pituitary drives the excessive skeletal growth of {{c1::gigantism}}, while too little GH during those same years stunts growth as {{c2::pituitary dwarfism}} (growth hormone deficiency).',
     2);

    -- ── Posterior Pituitary ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     'The {{c1::hypothalamus}} manufactures {{c2::ADH (antidiuretic hormone)}} and {{c2::oxytocin}}, but neither is synthesized in the posterior pituitary — that lobe only {{c3::stores and releases}} them into the blood.',
     3),
    (deck, 30, 'cloze',
     'When blood osmolarity climbs, the posterior pituitary secretes {{c1::ADH (vasopressin)}}, which drives {{c2::aquaporin}} water channels into the apical membrane of the {{c3::collecting duct}} principal cells; the resulting jump in water permeability pulls filtrate water back into the blood, yielding more concentrated urine and a restored blood volume.',
     3),
    (deck, 31, 'cloze',
     'The posterior pituitary releases ADH (vasopressin) when hypothalamic osmoreceptors detect a rise in {{c1::plasma osmolarity (overly concentrated blood)}} or when {{c2::a drop in blood volume or pressure}} signals the need to conserve water; the hormone then drives renal water reabsorption to dilute the blood and restore volume.',
     2),
    (deck, 32, 'cloze',
     'Released from the posterior pituitary, {{c1::oxytocin}} acts on two smooth-muscle targets: it triggers {{c2::uterine contractions}} that expel the fetus during childbirth and drives {{c3::milk ejection (let-down)}} when suckling signals reach the hypothalamus during lactation.',
     3),
    (deck, 33, 'cloze',
     'During labor, oxytocin from the posterior pituitary runs a {{c1::positive}} feedback loop: {{c2::cervical stretch}} triggers more oxytocin release, and the added oxytocin {{c3::intensifies uterine contractions}} that stretch the cervix still further — the cycle breaking only at birth.',
     3);

    -- ── Thyroid ─────────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     'Under the control of {{c1::TSH}} from the anterior pituitary, the thyroid runs two separate programs: {{c2::T3 and T4}} drive up the basal metabolic rate, while {{c3::calcitonin}} pushes blood calcium down by throttling osteoclasts.',
     3),
    (deck, 35, 'cloze',
     'To build thyroid hormone, follicular cells stud residues of the amino acid {{c1::tyrosine}} (held on thyroglobulin) with iodine: linking {{c2::three}} iodines yields T3, while {{c3::four}} iodines yields T4 (thyroxine).',
     3),
    (deck, 36, 'cloze',
     'Because {{c1::T3 and T4}} drive mitochondria to burn more oxygen for ATP and accelerate the turnover — both {{c3::synthesis and breakdown}} — of proteins and fats, they push the {{c2::basal metabolic rate}} upward.',
     3),
    (deck, 37, 'cloze',
     'A patient whose diet lacks iodine can''t build enough T3 and T4, so basal metabolic rate falls — the classic picture of {{c1::hypothyroidism}}, which presents with {{c2::lethargy, cold intolerance, weight gain, and a slowed heart and respiratory rate}} (the sluggish metabolism reflecting reduced tissue sensitivity to catecholamines).',
     2),
    (deck, 38, 'cloze',
     'Because thyroid hormone sets basal metabolic rate, a patient running hot instead of cold points you toward {{c1::hyperthyroidism}} rather than hypothyroidism: the elevated hormone level drives {{c2::heat intolerance and sweating}}, {{c2::weight loss}} despite normal intake, and a {{c2::faster heart and breathing rate}} with restless, heightened activity.',
     2),
    (deck, 39, 'cloze',
     'When blood calcium climbs, the thyroid''s {{c1::C (parafollicular) cells}} release calcitonin, which {{c2::lowers}} serum Ca²⁺ by driving three parallel shifts: {{c3::depositing calcium into bone (inhibiting osteoclasts), curbing intestinal calcium absorption, and increasing urinary calcium excretion}}.',
     3);

    -- ── Parathyroid ─────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 40, 'cloze',
     'When blood calcium falls, the parathyroid glands release {{c1::parathyroid hormone (PTH)}}, which {{c2::raises}} circulating calcium — directly opposing the thyroid hormone {{c3::calcitonin}}, its physiological antagonist that lowers calcium.',
     3),
    (deck, 41, 'cloze',
     'When plasma calcium dips, the parathyroid glands release PTH, which pushes it back up along three fronts: it drives {{c1::osteoclasts to resorb bone}}, curbs {{c1::calcium loss in the urine (renal reabsorption)}}, and — indirectly — boosts {{c1::intestinal calcium absorption}} by triggering the kidney''s synthesis of {{c2::calcitriol (active vitamin D3 / 1,25-dihydroxyvitamin D)}}.',
     2),
    (deck, 42, 'cloze',
     'In the gut, intestinal epithelial cells can only absorb dietary {{c3::calcium and phosphate}} once vitamin D has been converted to its active form, {{c2::calcitriol}} — a conversion driven by {{c1::PTH}}, which is why this hormone raises blood calcium not just by pulling it from bone and urine but also by boosting uptake from digested food.',
     3),
    (deck, 43, 'cloze',
     'Blood calcium homeostasis rests on an opposing pair: when levels fall too low, {{c1::parathyroid hormone (PTH)}} drives them back up, whereas a rise too high triggers {{c2::calcitonin}} from the thyroid to pull them back down.',
     2);

    -- ── Adrenal Cortex ──────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 44, 'cloze',
     'Steroid hormones from the adrenal cortex fall into three classes: {{c1::mineralocorticoids::from the zona glomerulosa; e.g. aldosterone}}, {{c2::glucocorticoids::from the zona fasciculata; e.g. cortisol}}, and {{c3::cortical sex hormones (androgens/estrogens)::from the zona reticularis}}.',
     3),
    (deck, 45, 'cloze',
     'Secreted by the zona fasciculata under ACTH drive, {{c1::glucocorticoids}} (chiefly {{c2::cortisol}}) defend fuel supply during prolonged stress: they push {{c3::gluconeogenesis}} to raise blood glucose, tear down rather than build tissue by favoring protein {{c4::catabolism}} over synthesis, and blunt the {{c5::immune}} response and inflammation.',
     5),
    (deck, 46, 'cloze',
     'When the HPA axis signals long-term physical or emotional stress, the zona fasciculata of the adrenal cortex secretes the glucocorticoid {{c1::cortisol}}, whose net effect is to {{c2::raise blood glucose}} — it drives catabolism of {{c3::glycogen, stored triglycerides, and muscle proteins}} to supply the raw material for making fuel.',
     3),
    (deck, 47, 'cloze',
     'Along the HPA axis, the hypothalamus releases {{c1::CRH (corticotropin-releasing hormone)}}, which drives the anterior pituitary to secrete {{c2::ACTH (adrenocorticotropic hormone)}}; ACTH then signals the adrenal cortex''s zona fasciculata to release the glucocorticoid {{c3::cortisol}}.',
     3),
    (deck, 48, 'cloze',
     'In the distal nephron, the mineralocorticoid {{c1::aldosterone}} defends blood pressure by driving reabsorption of {{c2::Na+}} (water follows), while the negative luminal electrochemical gradient this creates favors secretion of {{c3::K+ and H+}} into the forming urine.',
     3),
    (deck, 49, 'cloze',
     'When blood pressure drops, {{c1::juxtaglomerular}} cells of the kidney release {{c2::renin}}, which cleaves liver-made angiotensinogen into angiotensin I; the {{c3::lungs}} then supply {{c4::ACE (angiotensin-converting enzyme)}} to yield angiotensin II, the signal that drives the {{c5::adrenal cortex}} to release {{c6::aldosterone}}.',
     6);

    -- ── Adrenal Medulla ─────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 50, 'cloze',
     'The {{c1::adrenal medulla}} pours the catecholamines {{c2::epinephrine and norepinephrine}} straight into the bloodstream; because both are built from a single amino acid (tyrosine), they belong to the {{c3::amino-acid–derivative (amine)}} class of hormones rather than the steroid or peptide classes.',
     3),
    (deck, 51, 'cloze',
     'Under acute stress, chromaffin cells of the adrenal medulla flood the circulation with {{c1::catecholamines}} (epinephrine and norepinephrine), which quicken the heartbeat while {{c2::dilating the airways (bronchodilation)}} to raise blood oxygen and redirecting flow toward skeletal muscle by {{c3::dilating muscle vessels but constricting those to the gut, kidneys, and skin}}.',
     3),
    (deck, 52, 'cloze',
     'During acute stress, epinephrine from the adrenal medulla drives {{c1::glycogenolysis}} in both {{c2::the liver and skeletal muscle}}, dumping glucose into the blood while also pushing up the {{c3::basal metabolic rate}}.',
     3),
    (deck, 53, 'cloze',
     'When a threat hits, the adrenal medulla''s catecholamines (epinephrine and norepinephrine) drive the {{c1::short-term}} stress response, while glucocorticoids like {{c2::cortisol}} from the adrenal {{c3::cortex}} sustain the {{c4::long-term}} response.',
     4);

    -- ── Pancreas ────────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 54, 'cloze',
     'Within the pancreatic islets, three endocrine cell types partition the work of glucose control: {{c1::alpha}} cells release {{c2::glucagon}}, {{c1::beta}} cells release {{c3::insulin}}, and {{c1::delta}} cells release {{c4::somatostatin}}, which itself brakes the secretion of the other two.',
     4),
    (deck, 55, 'cloze',
     'When fasting drops blood glucose, the pancreatic {{c1::alpha}} cells release {{c2::glucagon}}, which pushes glucose back into circulation by driving the liver to break down glycogen ({{c3::glycogenolysis}}) and to synthesize new glucose from amino acids and glycerol ({{c4::gluconeogenesis}}).',
     4),
    (deck, 56, 'cloze',
     'When blood glucose climbs, the pancreatic {{c1::beta cells}} release {{c2::insulin}}, the antagonist of {{c3::glucagon}}: it drives glucose out of the blood into skeletal muscle and fat, prompts the liver to lock away the surplus as {{c4::glycogen}}, and promotes anabolic synthesis of triglycerides and protein.',
     4),
    (deck, 57, 'cloze',
     'Within the pancreatic islets, the {{c1::delta cells}} release {{c2::somatostatin}}, a hormone that dampens secretion of {{c3::both insulin and glucagon}}.',
     3),
    (deck, 58, 'cloze',
     'Both forms of diabetes mellitus run blood glucose high, but the lesion differs: in {{c1::type 1}}, an {{c2::autoimmune}} attack wipes out the pancreatic {{c3::beta cells}} so almost no insulin is made, whereas in {{c4::type 2}} the beta cells still secrete insulin but target cells have grown {{c5::resistant}} to it.',
     5),
    (deck, 59, 'cloze',
     'When blood glucose overwhelms the proximal tubule''s glucose symporters, filtered sugar exceeds the {{c1::transport maximum}} and spills into the urine as {{c2::glucosuria}}; because this unrecovered glucose acts as an {{c3::osmotic diuretic}}, it holds water in the filtrate and drives the {{c4::polyuria}} and {{c4::polydipsia}} that classically flag diabetes mellitus.',
     4),
    (deck, 60, 'cloze',
     'Too much circulating insulin drives blood glucose dangerously {{c1::low}} — a state called {{c1::hypoglycemia}} — starving cells of glucose and producing {{c2::muscle weakness}} and, if uncorrected, unconsciousness or death.',
     2);

    -- ── Gonads ──────────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 61, 'cloze',
     'Prompted by pituitary {{c1::luteinizing hormone (LH)}}, the Leydig cells of the testes release {{c2::testosterone}}; a fetal surge steers {{c3::anatomical differentiation of the male sexual organs}} in utero, while the pubertal rise triggers {{c4::secondary sex characteristics}} such as a deepened voice and increased muscle mass.',
     4),
    (deck, 62, 'cloze',
     'Prompted by pituitary {{c1::gonadotropins}} (LH and FSH), the ovaries release {{c2::estrogens}} and {{c2::progesterone}} — the hormones that steer female reproductive development and the {{c3::secondary sex characteristics}}.',
     3),
    (deck, 63, 'cloze',
     'Two glycoprotein gonadotropins released by the {{c1::anterior pituitary}} — {{c2::FSH and LH}} — act on the testes and ovaries, driving the gonads to synthesize their {{c3::sex-steroid hormones}} (testosterone, estrogens, and progesterone).',
     3);

    -- ── Pineal Gland ────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 64, 'cloze',
     'Sitting inferior and posterior to the thalamus, the {{c1::pineal}} gland secretes {{c2::melatonin}}, an amine hormone whose blood levels climb as light fades — entraining the body''s {{c3::circadian rhythm}} and ushering in drowsiness.',
     3),
    (deck, 65, 'cloze',
     'Because {{c1::light}} suppresses its release while {{c2::darkness}} ramps it up, {{c3::melatonin}} from the {{c4::pineal gland}} serves as the hormonal timekeeper that synchronizes the body''s {{c5::circadian}} (sleep–wake) rhythm to the day–night cycle.',
     5);

    -- ── Other Endocrine Organs ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 66, 'cloze',
     'When low blood oxygen (hypoxia) is sensed, the kidneys release {{c1::erythropoietin (EPO)}}, which drives the {{c2::bone marrow}} to raise red blood cell production and boost oxygen-carrying capacity. As oxygen levels recover, EPO secretion falls, closing the loop through {{c3::negative feedback}}.',
     3),
    (deck, 67, 'cloze',
     'When high blood volume overstretches the heart''s {{c1::atria}}, they secrete {{c2::atrial natriuretic peptide (ANP)}}, which drives renal excretion of {{c3::sodium and water}} and thereby opposes the salt-and-fluid retention of {{c4::aldosterone}}.',
     4),
    (deck, 68, 'cloze',
     'Perched above the heart, the thymus releases {{c1::thymosins}}, the hormones that guide maturation of {{c2::T lymphocytes (T cells)}}; because the gland {{c3::atrophies (shrinks / involutes)}} through adulthood, its output of these hormones tapers off with age.',
     3);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 69;
END $$;
