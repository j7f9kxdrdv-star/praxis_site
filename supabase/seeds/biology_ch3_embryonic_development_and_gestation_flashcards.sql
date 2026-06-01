-- ════════════════════════════════════════════════════════════════════
-- Biology Chapter 3 — Embryonic Development & Gestation
-- ════════════════════════════════════════════════════════════════════
-- Section: biology
-- Topic:   Molecular and Cellular Biology
-- Subtopic slug: embryonic_development_and_gestation
-- Sort order: 3
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--   1.  Fertilization
--   2.  Twin Types
--   3.  Cleavage
--   4.  Blastulation
--   5.  Implantation and Extraembryonic Membranes
--   6.  Gastrulation
--   7.  Germ Layer Derivatives
--   8.  Neurulation
--   9.  Specification, Determination, Differentiation
--   10. Stem Cell Potency
--   11. Cell-Cell Communication
--   12. Induction and Morphogens
--   13. Apoptosis vs Necrosis
--   14. Regeneration and Senescence
--   15. Fetal Circulation
--   16. Gestation and Birth
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Biology 2e (Ch 24, 43), OpenStax Anatomy & Physiology 2e (Ch 28),
-- and the AAMC Foundation 2C content outline. See companion .verification.md
-- for per-card citations.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    -- Idempotent cleanup: remove any prior version of this deck
    DELETE FROM flashcard_decks
    WHERE section = 'biology'
      AND topic = 'Molecular and Cellular Biology'
      AND title IN (
          'Embryonic Development & Gestation',
          'Embryogenesis and Development',
          'Embryogenesis & Development',
          'Embryonic Development and Gestation'
      );

    -- Insert deck
    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biology',
        'Molecular and Cellular Biology',
        'embryonic_development_and_gestation',
        'Embryonic Development & Gestation',
        'Fertilization, cleavage, gastrulation, germ-layer derivatives, stem cell potency, induction, apoptosis, fetal circulation, and the three trimesters of human gestation.',
        3
    )
    RETURNING id INTO deck;

    -- ── Fertilization ─────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'In humans, fertilization typically occurs in the {{c1::ampulla}} of the fallopian tube, and the secondary oocyte remains viable for roughly {{c2::24 hours}} after ovulation.',
     2),
    (deck, 1, 'cloze',
     'Acrosomal enzymes released by the sperm head digest a path through the {{c1::corona radiata}} and the {{c2::zona pellucida}} surrounding the secondary oocyte.',
     2),
    (deck, 2, 'cloze',
     'Once the sperm contacts the oocyte membrane, it forms a tubular {{c1::acrosomal apparatus}} that fuses the two cell membranes and delivers the sperm nucleus into the cytoplasm.',
     1),
    (deck, 3, 'cloze',
     'On sperm entry, a wave of {{c1::calcium ions}} sweeps across the oocyte and triggers the {{c2::cortical reaction}}, which depolarizes the egg membrane to block additional sperm.',
     2),
    (deck, 4, 'cloze',
     'The cortical reaction generates the {{c1::fertilization membrane}}, an electrochemically modified outer layer that prevents {{c2::polyspermy}} (fertilization by more than one sperm).',
     2),
    (deck, 5, 'cloze',
     'Once the sperm and oocyte nuclei fuse, the resulting {{c1::zygote}} carries the diploid complement of {{c2::46}} chromosomes and is now a single-celled embryo.',
     2);

    -- ── Twin Types ────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 6, 'cloze',
     '{{c1::Dizygotic (fraternal)}} twins arise when two ova are released and each is fertilized by a different sperm; they are no more genetically similar than ordinary siblings.',
     1),
    (deck, 7, 'cloze',
     '{{c1::Monozygotic (identical)}} twins arise when a single zygote splits into two embryos that share the same genome; an incomplete split produces {{c2::conjoined}} twins.',
     2),
    (deck, 8, 'cloze',
     'Whether monozygotic twins share a placenta depends on WHEN the zygote splits. An early split produces {{c1::dichorionic, diamniotic}} twins (two placentas, two sacs); a later split produces {{c2::monochorionic}} twins that share one placenta.',
     2),
    (deck, 9, 'cloze',
     'If a monozygotic split occurs after the amnion has formed, the twins share a single amniotic sac and are called {{c1::monoamniotic}}; this configuration carries the highest risk of cord entanglement.',
     1);

    -- ── Cleavage ──────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
     'After fertilization the zygote undergoes {{c1::cleavage}}, a rapid series of mitotic divisions with no overall growth. The first cleavage marks the official start of the {{c2::embryo}}.',
     2),
    (deck, 11, 'cloze',
     'Because cleavage divides without growing, each daughter cell has a higher nucleus-to-{{c1::cytoplasm}} ratio and a higher {{c2::surface area-to-volume}} ratio than the parent cell.',
     2),
    (deck, 12, 'cloze',
     'In {{c1::indeterminate}} cleavage, each daughter cell can still form a complete organism — the basis of monozygotic twins. In {{c2::determinate}} cleavage, each daughter is already committed to a specific lineage.',
     2);

    -- ── Blastulation ──────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 13, 'cloze',
     'After several cleavages the embryo is a solid ball of cells called the {{c1::morula}}; further division produces a hollow sphere — the {{c2::blastula}} — surrounding a fluid-filled cavity called the {{c3::blastocoel}}.',
     3),
    (deck, 14, 'cloze',
     'The outer cell layer of the blastula, the {{c1::trophoblast}}, does not contribute to the embryo itself; instead it gives rise to the {{c2::chorion}} and the embryonic side of the placenta.',
     2),
    (deck, 15, 'cloze',
     'The {{c1::inner cell mass}} of the blastula is the cluster of cells that becomes the embryo proper, while the surrounding trophoblast becomes extraembryonic tissue.',
     1);

    -- ── Implantation and Extraembryonic Membranes ────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 16, 'cloze',
     'Roughly {{c1::5-8 days}} after fertilization, the blastocyst burrows into the {{c2::endometrium}} of the uterine wall in a process called {{c3::implantation}}.',
     3),
    (deck, 17, 'cloze',
     'The trophoblast develops into the {{c1::chorion}}, whose finger-like {{c2::chorionic villi}} extend into the endometrium and form the embryonic half of the placenta where maternal and fetal blood exchange materials.',
     2),
    (deck, 18, 'cloze',
     'The umbilical cord contains {{c1::two}} arteries carrying deoxygenated blood from the fetus to the placenta, and {{c2::one}} vein returning oxygenated blood from the placenta to the fetus.',
     2),
    (deck, 19, 'cloze',
     'The vessels of the umbilical cord are embedded in a connective tissue called {{c1::Wharton''s jelly}}, which cushions them against compression as the fetus moves.',
     1),
    (deck, 20, 'cloze',
     'In humans the {{c1::yolk sac}} contributes very little nutrition; instead it produces the embryo''s earliest {{c2::blood cells}} until the liver takes over hematopoiesis.',
     2),
    (deck, 21, 'cloze',
     'The {{c1::allantois}} is a small extraembryonic pouch that handles early gas exchange and waste storage; in humans it largely degenerates as the placenta takes over those functions.',
     1),
    (deck, 22, 'cloze',
     'The {{c1::amnion}} is a thin membrane that surrounds the embryo with {{c2::amniotic fluid}}, a shock absorber that buffers mechanical stress and helps maintain a stable temperature.',
     2);

    -- ── Gastrulation ──────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 23, 'cloze',
     'During {{c1::gastrulation}}, cells of the blastula migrate inward and reorganize into three primary {{c2::germ layers}}: ectoderm, mesoderm, and endoderm.',
     2),
    (deck, 24, 'cloze',
     'The invagination during gastrulation forms a primitive gut called the {{c1::archenteron}}, whose opening to the outside is the {{c2::blastopore}}.',
     2),
    (deck, 25, 'cloze',
     'In {{c1::deuterostomes}} like humans, the blastopore becomes the {{c2::anus}}. In {{c3::protostomes}}, the blastopore becomes the {{c4::mouth}}.',
     4);

    -- ── Germ Layer Derivatives ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
     'The {{c1::ectoderm}} gives rise to the outer integument (epidermis, hair, nails) and to the entire {{c2::nervous system}}, including brain, spinal cord, and sensory receptors.',
     2),
    (deck, 27, 'cloze',
     'The {{c1::mesoderm}} gives rise to the musculoskeletal system, circulatory and excretory systems, gonads, and most of the {{c2::adrenal cortex}}.',
     2),
    (deck, 28, 'cloze',
     'The {{c1::endoderm}} gives rise to the epithelial linings of the {{c2::digestive and respiratory}} tracts and to glandular organs including the liver, pancreas, and thyroid.',
     2),
    (deck, 29, 'cloze',
     'Two MCAT-favorite ectoderm derivatives: the {{c1::lens of the eye}} and the {{c2::inner ear}}, both of which originate from surface ectodermal placodes near the developing head.',
     2),
    (deck, 30, 'cloze',
     'A classic dissociation: the adrenal {{c1::cortex}} is derived from {{c2::mesoderm}}, but the adrenal {{c3::medulla}} is derived from {{c4::neural crest}} (ectoderm).',
     4);

    -- ── Neurulation ───────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 31, 'cloze',
     'The {{c1::notochord}}, a rod of mesoderm running along the embryo''s midline, induces the overlying ectoderm to fold and form the {{c2::neural tube}}.',
     2),
    (deck, 32, 'cloze',
     'The {{c1::neural tube}} develops into the central nervous system: the anterior end becomes the {{c2::brain}} and the posterior end becomes the {{c2::spinal cord}}.',
     2),
    (deck, 33, 'cloze',
     'The {{c1::neural crest}} cells that pinch off during neural tube closure migrate widely and give rise to the peripheral nervous system, {{c2::melanocytes}}, the adrenal medulla, and facial cartilage.',
     2);

    -- ── Specification, Determination, Differentiation ────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     'A cell is {{c1::specified}} when its future fate has been provisionally assigned but the assignment is still {{c2::reversible}} if the cell is moved to a new environment.',
     2),
    (deck, 35, 'cloze',
     'A cell is {{c1::determined}} when its future fate is irreversibly committed: even if relocated, it can no longer change which cell type it will become.',
     1),
    (deck, 36, 'cloze',
     '{{c1::Differentiation}} is the process in which a determined cell actually develops the specialized {{c2::structure and function}} of its committed cell type.',
     2),
    (deck, 37, 'cloze',
     'Every cell in the body shares the same {{c1::genome}}; differentiation is driven not by losing genes but by {{c2::selective transcription}} — turning specific genes on or off in each cell type.',
     2),
    (deck, 38, 'cloze',
     'A {{c1::teratogen}} is any agent (drug, infection, radiation) that crosses the placenta and disrupts development; effects are most severe during {{c2::organogenesis}} in the first trimester.',
     2);

    -- ── Stem Cell Potency ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 39, 'cloze',
     'A {{c1::stem cell}} can both divide to renew itself and give rise to {{c2::differentiated}} daughter cells; potency describes the range of cell types it can produce.',
     2),
    (deck, 40, 'cloze',
     '{{c1::Totipotent}} cells can give rise to any cell type in the embryo and to the {{c2::extraembryonic}} tissues (placenta). Only the zygote and the earliest cleavage cells are truly totipotent.',
     2),
    (deck, 41, 'cloze',
     '{{c1::Pluripotent}} cells can give rise to any cell of the three {{c2::germ layers}} but cannot form extraembryonic tissue. The inner cell mass of the blastocyst is pluripotent.',
     2),
    (deck, 42, 'cloze',
     '{{c1::Multipotent}} cells are restricted to a single tissue lineage. Hematopoietic stem cells, for example, can produce every blood cell type but cannot become {{c2::muscle or nerve}}.',
     2);

    -- ── Cell-Cell Communication ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     'Cells coordinate through four classes of chemical signaling — autocrine, paracrine, juxtacrine, and endocrine — distinguished by {{c1::how far}} the signal travels and {{c2::how it reaches}} its target.',
     2),
    (deck, 44, 'cloze',
     'In {{c1::autocrine}} signaling, a cell releases a signal that binds receptors on the {{c2::same cell}} that secreted it — common in immune and developmental feedback loops.',
     2),
    (deck, 45, 'cloze',
     'In {{c1::paracrine}} signaling, the released molecule diffuses to and acts on {{c2::nearby cells}}; many developmental signals (e.g., growth factors) are paracrine.',
     2),
    (deck, 46, 'cloze',
     'In {{c1::juxtacrine}} signaling, the signaling and target cells must be in {{c2::direct contact}}; the signal molecule remains anchored to the membrane of the sending cell.',
     2),
    (deck, 47, 'cloze',
     'In {{c1::endocrine}} signaling, hormones released into the {{c2::bloodstream}} travel long distances to act on distant target cells that express the matching receptor.',
     2);

    -- ── Induction and Morphogens ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 48, 'cloze',
     'In {{c1::induction}}, a signaling cell (the inducer) releases a molecule that directs the fate of a neighboring {{c2::responder}} cell — but only if the responder has the appropriate {{c3::competence}} to receive the signal.',
     3),
    (deck, 49, 'cloze',
     'Many inducers in development are {{c1::growth factors}} — peptide signaling molecules that bind cell-surface receptors and trigger proliferation or differentiation.',
     1),
    (deck, 50, 'cloze',
     'A {{c1::morphogen}} is a signaling molecule that forms a concentration {{c2::gradient}} across a tissue, and different concentrations specify different cell fates along the gradient.',
     2),
    (deck, 51, 'cloze',
     'Development often relies on {{c1::reciprocal induction}}, in which two tissues take turns signaling to each other; each round of inducer-and-response refines the developing structure.',
     1);

    -- ── Apoptosis vs Necrosis ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 52, 'cloze',
     '{{c1::Apoptosis}} is programmed cell death in which the cell breaks into membrane-bound {{c2::apoptotic bodies}} that are cleanly removed by phagocytes — no inflammation, no leakage of cell contents.',
     2),
    (deck, 53, 'cloze',
     '{{c1::Necrosis}} is unplanned cell death from acute injury; the cell ruptures and releases its contents, which {{c2::trigger an immune response}} and inflammation in surrounding tissue.',
     2),
    (deck, 54, 'cloze',
     'Apoptosis is essential to normal development: the spaces between fingers and toes are carved by programmed death of the {{c1::interdigital}} cells, sculpting the {{c2::limb}} from a flat plate.',
     2);

    -- ── Regeneration and Senescence ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 55, 'cloze',
     '{{c1::Regeneration}} is the ability to regrow lost tissue and is largely driven by undifferentiated {{c2::stem cells}}. Regenerative capacity differs widely between species and between tissues.',
     2),
    (deck, 56, 'cloze',
     '{{c1::Complete regeneration}} restores the original tissue (e.g., the liver after partial hepatectomy). {{c2::Incomplete regeneration}} replaces the lost tissue with scar tissue rather than a perfect functional copy.',
     2),
    (deck, 57, 'cloze',
     'Telomeres are repetitive caps on chromosome ends that shorten each replication because DNA polymerase cannot copy the {{c1::3'' end}}. When too short, the cell stops dividing — {{c2::senescence}}.',
     2),
    (deck, 58, 'cloze',
     '{{c1::Telomerase}} is a reverse transcriptase that lengthens telomeres in {{c2::germline and stem}} cells. Its reactivation in most {{c3::cancer}} cells allows them to divide indefinitely.',
     3);

    -- ── Fetal Circulation ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 59, 'cloze',
     '{{c1::Fetal hemoglobin (HbF)}} has higher oxygen affinity than adult hemoglobin (HbA), enabling efficient {{c2::oxygen transfer}} from maternal to fetal blood across the placenta.',
     2),
    (deck, 60, 'cloze',
     'In addition to gas and nutrient exchange, the placenta is an {{c1::endocrine}} organ: it secretes {{c2::hCG}}, progesterone, and estrogen to maintain pregnancy.',
     2),
    (deck, 61, 'cloze',
     'The fetal liver is immature, so the {{c1::maternal liver}} detoxifies most metabolic waste; nitrogenous wastes diffuse from fetal blood into maternal blood at the placenta.',
     1),
    (deck, 62, 'cloze',
     'Counter to the adult pattern, the umbilical {{c1::vein}} carries oxygenated blood from the placenta to the fetus, while the umbilical {{c2::arteries}} carry deoxygenated blood back to the placenta.',
     2),
    (deck, 63, 'cloze',
     'The fetus uses three {{c1::shunts}} to bypass the non-functional fetal {{c2::lungs}} and {{c3::liver}}.',
     3),
    (deck, 64, 'cloze',
     'The {{c1::foramen ovale}} is an opening between the right and left atria that lets blood bypass the fetal {{c2::lungs}} by flowing directly from the right atrium into the left atrium.',
     2),
    (deck, 65, 'cloze',
     'The {{c1::ductus arteriosus}} connects the pulmonary artery to the {{c2::aorta}}, shunting blood away from the fetal lungs and into the systemic circulation.',
     2),
    (deck, 66, 'cloze',
     'The {{c1::ductus venosus}} shunts oxygenated blood from the umbilical vein directly into the {{c2::inferior vena cava}}, bypassing the immature fetal {{c3::liver}}.',
     3);

    -- ── Gestation and Birth ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 67, 'cloze',
     '{{c1::Gestation}} is the period from fertilization to birth, lasting about {{c2::9 months}} in humans and divided into three {{c3::trimesters}}.',
     3),
    (deck, 68, 'cloze',
     'The first trimester is dominated by {{c1::organogenesis}}: the heart, brain, eyes, gonads, limbs, and liver all begin to form. The embryo is most vulnerable to teratogens during this window.',
     1),
    (deck, 69, 'cloze',
     'By the end of week {{c1::8}}, all major organ systems have begun to form and the developing organism is no longer called an embryo — it is now a {{c2::fetus}}.',
     2),
    (deck, 70, 'cloze',
     'During the second trimester, the fetus grows rapidly, begins to move detectably, and develops recognizable {{c1::facial features}} and {{c2::digits}}.',
     2),
    (deck, 71, 'cloze',
     'In the third trimester, growth and {{c1::brain development}} accelerate, fat is deposited under the skin, and maternal {{c2::antibodies}} cross the placenta to give the newborn passive immunity.',
     2),
    (deck, 72, 'cloze',
     'Birth proceeds in three phases: cervical {{c1::thinning and dilation}} (often with rupture of the amniotic sac), strong uterine {{c2::contractions}} that deliver the fetus, and finally expulsion of the {{c3::placenta}} as the afterbirth.',
     3),
    (deck, 73, 'cloze',
     'Uterine contractions during labor are driven by {{c1::oxytocin}} (released from the posterior pituitary) and {{c2::prostaglandins}}; positive feedback ramps both up until delivery.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 74;
END $$;
