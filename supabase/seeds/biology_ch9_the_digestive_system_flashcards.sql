-- ════════════════════════════════════════════════════════════════════
-- Biology Chapter 9 — The Digestive System
-- ════════════════════════════════════════════════════════════════════
-- Section: biology
-- Topic:   Body Systems
-- Subtopic slug: the_digestive_system
-- Sort order: 9
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--    1. Digestive Overview & Control
--    2. Oral Cavity & Esophagus (Ingestion)
--    3. The Stomach
--    4. Small Intestine — Digestion
--    5. Accessory Organs — Pancreas, Liver & Gallbladder
--    6. GI Hormones (Endocrine Control)
--    7. Small Intestine — Absorption
--    8. Large Intestine, Rectum & Gut Flora
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against
-- OpenStax Anatomy & Physiology 2e (Ch 23, The Digestive System) and OpenStax
-- Biology 2e (Ch 34, Animal Nutrition and the Digestive System). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'biology'
      AND title IN (
          'The Digestive System',
          'Digestive System',
          'Biology Review Chapter Nine: The Digestive System'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biology',
        'Body Systems',
        'the_digestive_system',
        'The Digestive System',
        'The GI tract and its neural control, ingestion, the stomach and gastric cells, small-intestinal digestion and brush-border enzymes, the accessory organs (pancreas, liver, gallbladder), GI hormones, nutrient absorption at the villi, and the large intestine and gut flora.',
        9
    )
    RETURNING id INTO deck;

    -- ── Digestive Overview & Control ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'Food''s path through the GI tract: mouth → {{c1::pharynx → esophagus → stomach → small intestine → large intestine}} → anus.',
     1),
    (deck, 1, 'cloze',
     'Accessory digestive organs connect to the gut by ducts but food never passes through them: the {{c1::salivary glands, pancreas, liver, and gallbladder}}.',
     1),
    (deck, 2, 'cloze',
     'Chewing and the churning of food in the stomach are examples of {{c1::mechanical}} digestion.',
     1),
    (deck, 3, 'cloze',
     'Enzymes hydrolyzing bonds — for example, splitting a protein into its amino acids — accomplish {{c1::chemical}} digestion.',
     1),
    (deck, 4, 'cloze',
     '{{c1::Peristalsis}} moves food forward through the GI tract using sequential waves of smooth-muscle contraction and relaxation.',
     1),
    (deck, 5, 'cloze',
     '{{c1::Segmentation}} — localized back-and-forth contractions, mainly in the small intestine — mixes chyme with digestive juices instead of propelling it.',
     1),
    (deck, 6, 'cloze',
     'The {{c1::enteric}} nervous system, embedded in the alimentary-canal wall from esophagus to anus, controls GI motility and secretion.',
     1),
    (deck, 7, 'cloze',
     'Parasympathetic input {{c1::stimulates}} GI secretion and motility (digestion), while sympathetic input {{c1::inhibits}} them.',
     1),
    (deck, 8, 'cloze',
     'Human digestion occurs inside the alimentary canal''s lumen, making it {{c1::extracellular}} rather than {{c1::intracellular}}.',
     1),
    (deck, 9, 'cloze',
     'From the lumen outward, the alimentary-canal wall has four layers: the {{c1::mucosa, submucosa, muscularis, and serosa}}.',
     1);

    -- ── Oral Cavity & Esophagus (Ingestion) ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
     '{{c1::Salivary amylase}} begins digesting {{c2::starch}} while food is still in the mouth.',
     2),
    (deck, 11, 'cloze',
     'Lingual lipase is secreted in the mouth but stays inactive until the acidic {{c1::stomach}} activates it to break down {{c2::triglycerides}}.',
     2),
    (deck, 12, 'cloze',
     'Saliva''s {{c1::mucus}} lubricates food so the tongue can shape it into a {{c2::bolus}} for swallowing.',
     2),
    (deck, 13, 'cloze',
     'The esophagus transports the swallowed bolus to the stomach by {{c1::peristalsis}}.',
     1),
    (deck, 14, 'cloze',
     'The bolus passes from the esophagus into the stomach at the {{c1::lower esophageal}} sphincter, which relaxes to admit it and contracts to block acid reflux.',
     1);

    -- ── The Stomach ─────────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'The stomach has five regions, listed from the esophageal end toward the intestine: the {{c1::cardia}}, {{c1::fundus}}, {{c1::body}}, {{c1::antrum}}, and {{c1::pylorus}}.',
     1),
    (deck, 16, 'cloze',
     'When the stomach is empty, its mucosa collapses into large internal folds called {{c1::rugae}}, which flatten out as the stomach fills.',
     1),
    (deck, 17, 'cloze',
     '{{c1::Parietal}} cells secrete hydrochloric acid, giving the stomach lumen a strongly acidic pH of roughly {{c2::1.5–3.5}}.',
     2),
    (deck, 18, 'cloze',
     'Parietal cells also secrete {{c1::intrinsic factor}}, a glycoprotein required for absorbing vitamin {{c1::B₁₂}} in the small intestine.',
     1),
    (deck, 19, 'cloze',
     'The low pH generated by gastric HCl both {{c1::denatures}} dietary proteins and activates the enzyme {{c2::pepsin}} from its inactive precursor.',
     2),
    (deck, 20, 'cloze',
     '{{c1::Chief}} cells of the gastric glands secrete {{c2::pepsinogen}}, an inactive proenzyme.',
     2),
    (deck, 21, 'cloze',
     'Digestive enzymes such as pepsin are secreted as inactive precursors called {{c1::zymogens}}, protecting the secreting cells from self-digestion.',
     1),
    (deck, 22, 'cloze',
     'The stomach''s surface mucous cells secrete a thick mucus rich in {{c1::bicarbonate (HCO₃⁻)}} ions, which neutralize acid and protect the lining from self-digestion.',
     1),
    (deck, 23, 'cloze',
     'Enteroendocrine {{c1::G}} cells of the gastric glands secrete the hormone {{c1::gastrin}}.',
     1),
    (deck, 24, 'cloze',
     'Churned gastric contents form a semifluid paste called {{c1::chyme}}, which passes through the {{c2::pyloric sphincter}} into the duodenum.',
     2);

    -- ── Small Intestine — Digestion ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 25, 'cloze',
     'In order from proximal to distal, the three regions of the small intestine are the {{c1::duodenum, jejunum, and ileum}}.',
     1),
    (deck, 26, 'cloze',
     'Most chemical digestion in the small intestine occurs in its first and shortest segment, the {{c1::duodenum}}.',
     1),
    (deck, 27, 'cloze',
     'As acidic chyme enters the duodenum, alkaline {{c1::bicarbonate}} in pancreatic juice neutralizes it, raising the pH so intestinal enzymes can work.',
     1),
    (deck, 28, 'cloze',
     'The brush-border disaccharidase sucrase hydrolyzes sucrose into {{c1::glucose and fructose}}.',
     1),
    (deck, 29, 'cloze',
     'The brush-border disaccharidase lactase breaks lactose down into {{c1::glucose and galactose}}.',
     1),
    (deck, 30, 'cloze',
     'The brush-border disaccharidase maltase splits maltose into {{c1::two glucose molecules}}.',
     1),
    (deck, 31, 'cloze',
     'Two brush-border peptidases, {{c1::aminopeptidase and dipeptidase}}, complete protein digestion by cleaving short peptides into free amino acids.',
     1),
    (deck, 32, 'cloze',
     'The intestinal brush-border enzyme {{c1::enteropeptidase (enterokinase)}} activates the pancreatic zymogen trypsinogen, converting it into active trypsin.',
     1),
    (deck, 33, 'cloze',
     'Once formed, {{c1::trypsin}} activates other pancreatic zymogens such as chymotrypsinogen and procarboxypeptidase, amplifying the digestive-enzyme cascade.',
     1);

    -- ── Accessory Organs — Pancreas, Liver & Gallbladder ────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     'The exocrine {{c1::acinar}} cells of the pancreas produce pancreatic juice and deliver it through the pancreatic duct into the {{c2::duodenum}}.',
     2),
    (deck, 35, 'cloze',
     'To prevent self-digestion, the pancreas secretes its proteases as inactive {{c1::zymogens}}, such as {{c2::trypsinogen}} and {{c2::chymotrypsinogen}}.',
     2),
    (deck, 36, 'cloze',
     'Pancreatic {{c1::amylase}} carries out most starch digestion in the small intestine, breaking polysaccharides into disaccharides like maltose.',
     1),
    (deck, 37, 'cloze',
     'Pancreatic {{c1::lipase}} hydrolyzes each emulsified triglyceride into two {{c2::fatty acids}} and one {{c2::monoglyceride}}.',
     2),
    (deck, 38, 'cloze',
     'Bile is made by the {{c1::liver}}, stored and concentrated in the {{c2::gallbladder}}, and released into the {{c3::duodenum}} to help digest fats.',
     3),
    (deck, 39, 'cloze',
     'Bile emulsifies fat physically, breaking large globules into tiny droplets that increase the {{c1::surface area}} for lipase; bile itself contains no {{c2::digestive enzymes}}.',
     2),
    (deck, 40, 'cloze',
     'Bile''s main components are bile {{c1::salts}}, {{c2::cholesterol}}, and the pigment {{c3::bilirubin}}, which comes from the breakdown of old red blood cells.',
     3),
    (deck, 41, 'cloze',
     'The liver stabilizes blood glucose by storing surplus glucose as {{c1::glycogen}} and, during fasting, making new glucose from amino acids via {{c2::gluconeogenesis}}.',
     2),
    (deck, 42, 'cloze',
     'The liver detoxifies {{c1::ammonia}} from amino-acid breakdown by converting it into {{c2::urea}}, which the kidneys excrete.',
     2),
    (deck, 43, 'cloze',
     'The liver synthesizes major blood proteins, including {{c1::albumin}}, which maintains plasma osmotic pressure, and the {{c2::clotting factors}} that stop bleeding after vessel injury.',
     2),
    (deck, 44, 'cloze',
     'Nutrient-rich blood leaving the intestines is delivered first to the liver for processing by the {{c1::hepatic portal vein}}, before it reaches general circulation.',
     1);

    -- ── GI Hormones (Endocrine Control) ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 45, 'cloze',
     'Gastrin stimulates gastric {{c1::HCl (acid)}} secretion and increases stomach {{c2::motility}}.',
     2),
    (deck, 46, 'cloze',
     'As acidic chyme enters the duodenum, secretin stimulates the pancreas to secrete {{c1::bicarbonate (HCO₃⁻)}}-rich fluid.',
     1),
    (deck, 47, 'cloze',
     'Secretin acts on the stomach to {{c1::decrease}} its secretion of gastric acid.',
     1),
    (deck, 48, 'cloze',
     'When fatty, protein-rich chyme reaches the small intestine, {{c1::CCK}} triggers the gallbladder to release bile and the pancreas to secrete digestive enzymes.',
     1),
    (deck, 49, 'cloze',
     'Beyond its digestive actions, CCK also travels to the brain, where it promotes {{c1::satiety}}.',
     1),
    (deck, 50, 'cloze',
     'Ghrelin, secreted by the stomach and rising just before meals, drives {{c1::hunger}}.',
     1),
    (deck, 51, 'cloze',
     'Leptin, released by adipose tissue in proportion to fat stores, signals {{c1::satiety}} to appetite centers in the brain.',
     1);

    -- ── Small Intestine — Absorption ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 52, 'cloze',
     'The main absorptive regions of the small intestine are the {{c1::jejunum}} and {{c1::ileum}}.',
     1),
    (deck, 53, 'cloze',
     'Fingerlike {{c1::villi}} projecting from the small intestine''s mucosa massively expand its surface area for absorption.',
     1),
    (deck, 54, 'cloze',
     'Collectively, the microvilli blanketing each intestinal absorptive cell form a fuzzy layer called the {{c1::brush border}}.',
     1),
    (deck, 55, 'cloze',
     'Inside each villus, the {{c1::capillary bed}} absorbs water-soluble nutrients — monosaccharides, amino acids, and water-soluble vitamins — into the blood.',
     1),
    (deck, 56, 'cloze',
     'Inside each villus, a {{c1::lacteal}} absorbs fat-soluble products of digestion: cholesterol, dietary fats, and fat-soluble vitamins.',
     1),
    (deck, 57, 'cloze',
     'Within enterocytes, absorbed lipids are reassembled into {{c1::chylomicrons}}, lipoprotein particles too big for blood capillaries that instead enter the lacteals.',
     1),
    (deck, 58, 'cloze',
     'Glucose is drawn into intestinal absorptive cells against its concentration gradient by {{c1::secondary active transport}}, powered by sodium ions flowing down their gradient.',
     1),
    (deck, 59, 'cloze',
     'The four fat-soluble vitamins, absorbed together with dietary fat, are {{c1::A}}, {{c1::D}}, {{c1::E}}, and {{c1::K}}.',
     1),
    (deck, 60, 'cloze',
     'Most water is absorbed in the small intestine passively by {{c1::osmosis}}, following the absorbed solutes down the resulting concentration gradient.',
     1);

    -- ── Large Intestine, Rectum & Gut Flora ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 61, 'cloze',
     'In order from the small intestine to the anus, the large intestine''s three main regions are the {{c1::cecum}}, the {{c1::colon}}, and the {{c1::rectum}}.',
     1),
    (deck, 62, 'cloze',
     'Movement of chyme from the small intestine into the large intestine is controlled by the {{c1::ileocecal}} valve (sphincter).',
     1),
    (deck, 63, 'cloze',
     'A narrow, worm-shaped tube called the {{c1::appendix}} projects from the cecum.',
     1),
    (deck, 64, 'cloze',
     'The colon has four sequential segments: the {{c1::ascending}}, {{c1::transverse}}, {{c1::descending}}, and {{c1::sigmoid}} colon.',
     1),
    (deck, 65, 'cloze',
     'The large intestine''s main absorptive job is to reclaim {{c1::water}} and {{c2::salts}} from the residue passing through it.',
     2),
    (deck, 66, 'cloze',
     'The large intestine compacts the undigested residue into the semisolid waste known as {{c1::feces}}.',
     1),
    (deck, 67, 'cloze',
     'The {{c1::rectum}} stores feces until they are expelled from the body through the {{c2::anus}}.',
     2),
    (deck, 68, 'cloze',
     'The bacterial flora of the large intestine synthesize vitamin {{c1::K}} and {{c2::biotin}} (vitamin {{c2::B₇}}), which humans cannot make on their own.',
     2);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 69;
END $$;
