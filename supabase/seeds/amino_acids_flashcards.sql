-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Amino Acids
-- Section: amino_acids · Topic: Amino Acids
--
-- Coverage: the generic α-carbon amino acid backbone with its
-- four substituents; L-stereochemistry of proteinogenic AAs
-- with glycine as the achiral exception; structure-based
-- identification of all 20 standard amino acids (each card
-- shows the side-chain structure plus the full name,
-- three-letter abbreviation, and one-letter code grouped as
-- a single retrieval event); side-chain classification across
-- the five MCAT-relevant categories (nonpolar nonaromatic,
-- aromatic, polar uncharged, acidic, basic) plus tyrosine's
-- dual aromatic+polar membership; special structural features
-- (glycine achirality, proline ring-induced kinks, cysteine
-- disulfide bond formation, methionine as the translation
-- start residue, histidine's near-physiological-pH pKa,
-- the two sulfur-containing AAs, tryptophan as largest and
-- the basis for 280 nm UV absorption); side-chain pKa values
-- for the seven ionizable amino acids plus the standard
-- backbone α-COOH (~2.0) and α-NH₃⁺ (~9–10) values; the
-- zwitterion at physiological pH; and the hydrophobic-interior
-- / hydrophilic-surface principle of protein folding.
--
-- All cards are CLOZE-format. Card content is ORIGINAL Praxist
-- Prep prose written from the underlying biochemistry. Per-AA
-- identification cards reference structure images stored at
-- /public/flashcards/amino-acids/structures/<name>.png and the
-- side-chain classification cards reference category overview
-- images at /public/flashcards/amino-acids/categories/<name>.png;
-- the cloze renderer (lib/flashcards/cloze.ts) parses the
-- inline <img src="..." alt="..."> tags into image segments
-- that mount as real <img> elements in the study UI.
--
-- Idempotent: re-running deletes the prior version of this
-- deck and re-seeds. User review history attached to those
-- cards (flashcard_user_state, flashcard_reviews) cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  -- Wipe any prior copy of this deck
  DELETE FROM flashcard_decks
   WHERE section = 'amino_acids'
     AND title   IN (
           'Amino Acids',
           'The 20 Amino Acids',
           'Amino Acids — Identification & Properties'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'amino_acids',
    'Amino Acids',
    'amino_acids_reference',
    'Amino Acids',
    'A focused reference deck for the 20 standard amino acids — structure-based identification (name + three-letter + one-letter code), side-chain classification (nonpolar, aromatic, polar uncharged, acidic, basic), pKa values of the ionizable side chains, and the high-yield structural quirks (glycine, proline, cysteine, methionine, histidine).',
    1
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. Amino Acid Backbone ───────────────────────────────
  (deck,  0, 'cloze',
   'Every standard amino acid is built around a central {{c1::α-carbon}} bonded to four groups: an {{c1::amino group (-NH₂)}}, a {{c1::carboxyl group (-COOH)}}, a {{c1::hydrogen atom}}, and a unique {{c1::side chain (R group)}} that distinguishes one amino acid from another.', 1),

  (deck,  1, 'cloze',
   'All proteinogenic amino acids are chiral at the α-carbon and exist almost exclusively in the {{c1::L}} (S) configuration in human proteins — with one exception: {{c2::glycine}}, whose side chain is just a hydrogen atom, leaving the α-carbon with two identical substituents and making it achiral.', 2),

  -- ── 2. Identification: Nonpolar Nonaromatic ──────────────
  (deck,  2, 'cloze',
   '{{c1::Glycine}}, {{c1::Gly}}, {{c1::G}}<img src="/flashcards/amino-acids/structures/glycine.png" alt="Glycine structure">', 1),

  (deck,  3, 'cloze',
   '{{c1::Alanine}}, {{c1::Ala}}, {{c1::A}}<img src="/flashcards/amino-acids/structures/alanine.png" alt="Alanine structure">', 1),

  (deck,  4, 'cloze',
   '{{c1::Valine}}, {{c1::Val}}, {{c1::V}}<img src="/flashcards/amino-acids/structures/valine.png" alt="Valine structure">', 1),

  (deck,  5, 'cloze',
   '{{c1::Leucine}}, {{c1::Leu}}, {{c1::L}}<img src="/flashcards/amino-acids/structures/leucine.png" alt="Leucine structure">', 1),

  (deck,  6, 'cloze',
   '{{c1::Isoleucine}}, {{c1::Ile}}, {{c1::I}}<img src="/flashcards/amino-acids/structures/isoleucine.png" alt="Isoleucine structure">', 1),

  (deck,  7, 'cloze',
   '{{c1::Methionine}}, {{c1::Met}}, {{c1::M}}<img src="/flashcards/amino-acids/structures/methionine.png" alt="Methionine structure">', 1),

  (deck,  8, 'cloze',
   '{{c1::Proline}}, {{c1::Pro}}, {{c1::P}}<img src="/flashcards/amino-acids/structures/proline.png" alt="Proline structure">', 1),

  -- ── 3. Identification: Aromatic ──────────────────────────
  (deck,  9, 'cloze',
   '{{c1::Phenylalanine}}, {{c1::Phe}}, {{c1::F}}<img src="/flashcards/amino-acids/structures/phenylalanine.png" alt="Phenylalanine structure">', 1),

  (deck, 10, 'cloze',
   '{{c1::Tryptophan}}, {{c1::Trp}}, {{c1::W}}<img src="/flashcards/amino-acids/structures/tryptophan.png" alt="Tryptophan structure">', 1),

  (deck, 11, 'cloze',
   '{{c1::Tyrosine}}, {{c1::Tyr}}, {{c1::Y}}<img src="/flashcards/amino-acids/structures/tyrosine.png" alt="Tyrosine structure">', 1),

  -- ── 4. Identification: Polar Uncharged ───────────────────
  (deck, 12, 'cloze',
   '{{c1::Serine}}, {{c1::Ser}}, {{c1::S}}<img src="/flashcards/amino-acids/structures/serine.png" alt="Serine structure">', 1),

  (deck, 13, 'cloze',
   '{{c1::Threonine}}, {{c1::Thr}}, {{c1::T}}<img src="/flashcards/amino-acids/structures/threonine.png" alt="Threonine structure">', 1),

  (deck, 14, 'cloze',
   '{{c1::Cysteine}}, {{c1::Cys}}, {{c1::C}}<img src="/flashcards/amino-acids/structures/cysteine.png" alt="Cysteine structure">', 1),

  (deck, 15, 'cloze',
   '{{c1::Asparagine}}, {{c1::Asn}}, {{c1::N}}<img src="/flashcards/amino-acids/structures/asparagine.png" alt="Asparagine structure">', 1),

  (deck, 16, 'cloze',
   '{{c1::Glutamine}}, {{c1::Gln}}, {{c1::Q}}<img src="/flashcards/amino-acids/structures/glutamine.png" alt="Glutamine structure">', 1),

  -- ── 5. Identification: Acidic ────────────────────────────
  (deck, 17, 'cloze',
   '{{c1::Aspartate (Aspartic Acid)}}, {{c1::Asp}}, {{c1::D}}<img src="/flashcards/amino-acids/structures/aspartate.png" alt="Aspartate structure">', 1),

  (deck, 18, 'cloze',
   '{{c1::Glutamate (Glutamic Acid)}}, {{c1::Glu}}, {{c1::E}}<img src="/flashcards/amino-acids/structures/glutamate.png" alt="Glutamate structure">', 1),

  -- ── 6. Identification: Basic ─────────────────────────────
  (deck, 19, 'cloze',
   '{{c1::Lysine}}, {{c1::Lys}}, {{c1::K}}<img src="/flashcards/amino-acids/structures/lysine.png" alt="Lysine structure">', 1),

  (deck, 20, 'cloze',
   '{{c1::Arginine}}, {{c1::Arg}}, {{c1::R}}<img src="/flashcards/amino-acids/structures/arginine.png" alt="Arginine structure">', 1),

  (deck, 21, 'cloze',
   '{{c1::Histidine}}, {{c1::His}}, {{c1::H}}<img src="/flashcards/amino-acids/structures/histidine.png" alt="Histidine structure">', 1),

  -- ── 7. Side-Chain Classification ─────────────────────────
  (deck, 22, 'cloze',
   'The {{c1::nonpolar, nonaromatic}} amino acids are: {{c2::glycine, alanine, valine, leucine, isoleucine, methionine, proline}}.<img src="/flashcards/amino-acids/categories/nonpolar-nonaromatic.png" alt="Nonpolar nonaromatic amino acids reference table">', 2),

  (deck, 23, 'cloze',
   'The three {{c1::aromatic}} amino acids — distinguished by their ring side chains that absorb UV light near 280 nm — are {{c2::phenylalanine, tyrosine, tryptophan}}.<img src="/flashcards/amino-acids/categories/aromatic.png" alt="Aromatic amino acids reference table">', 2),

  (deck, 24, 'cloze',
   'The {{c1::polar uncharged}} amino acids are {{c2::serine, threonine, asparagine, glutamine, cysteine}}; their side chains carry hydrogen-bonding groups (hydroxyls, amides, or thiol) but do not ionize at physiological pH.<img src="/flashcards/amino-acids/categories/polar-uncharged.png" alt="Polar uncharged amino acids reference table">', 2),

  (deck, 25, 'cloze',
   'The two {{c1::acidic (negatively charged at physiological pH)}} amino acids are {{c2::aspartate (Asp/D)}} and {{c2::glutamate (Glu/E)}} — each carries a side-chain carboxylate that is fully deprotonated at pH 7.4.<img src="/flashcards/amino-acids/categories/acidic.png" alt="Acidic amino acids reference table">', 2),

  (deck, 26, 'cloze',
   'The three {{c1::basic (positively charged at physiological pH)}} amino acids are {{c2::lysine (Lys/K)}}, {{c2::arginine (Arg/R)}}, and {{c2::histidine (His/H)}}.<img src="/flashcards/amino-acids/categories/basic.png" alt="Basic amino acids reference table">', 2),

  (deck, 27, 'cloze',
   '{{c1::Tyrosine}} is unique in being classified as BOTH {{c2::aromatic}} (due to its phenol ring) AND {{c2::polar uncharged}} (due to the hydroxyl group on that ring) — which is why it appears under both categories in side-chain charts.', 2),

  -- ── 8. Special Structural Features ───────────────────────
  (deck, 28, 'cloze',
   '{{c1::Glycine}} is the only amino acid that is {{c2::achiral}} at the α-carbon, because its side chain is just a {{c3::single hydrogen atom}} — leaving the α-carbon with two identical H substituents and therefore no stereocenter.', 3),

  (deck, 29, 'cloze',
   '{{c1::Proline}} is structurally unique: its side chain {{c2::loops back to bond with the α-amino nitrogen}}, forming a five-membered ring. This rigidity introduces {{c3::kinks}} in polypeptide chains and disrupts both α-helices and β-pleated sheets.', 3),

  (deck, 30, 'cloze',
   '{{c1::Cysteine}} is the only amino acid that can form covalent {{c2::disulfide bonds (-S-S-)}} between two side chains; these bonds covalently lock distant parts of a protein together and are critical to the structure of many secreted proteins — most famously {{c3::insulin and antibodies}}.', 3),

  (deck, 31, 'cloze',
   '{{c1::Methionine}} (Met, M) is the universal {{c2::translation start codon AUG}} amino acid — every nascent eukaryotic polypeptide begins with methionine on its {{c3::N-terminus}} (sometimes cleaved post-translationally).', 3),

  (deck, 32, 'cloze',
   '{{c1::Histidine}} stands out among the basic amino acids for having a side-chain pKa near physiological pH (~6); this lets it act as a {{c2::proton acceptor or donor}} in enzyme active sites and as the buffering residue in {{c3::hemoglobin and other proteins}}.', 3),

  (deck, 33, 'cloze',
   'The two sulfur-containing amino acids are {{c1::methionine}} and {{c1::cysteine}}. Methionine contains a {{c2::thioether (-S-CH₃)}}, while cysteine contains a reactive {{c2::thiol (-SH)}} — only cysteine''s thiol is reactive enough to form disulfide bonds.', 2),

  (deck, 34, 'cloze',
   '{{c1::Tryptophan}} is the largest of the 20 standard amino acids; its bulky indole ring absorbs UV light most strongly, which is why protein concentration in solution is conventionally measured at {{c2::280 nm}} via absorbance.', 2),

  -- ── 9. pKa Values of Ionizable Side Chains ───────────────
  (deck, 35, 'cloze',
   'Seven amino acids have ionizable side chains: the three {{c1::basic}} ({{c2::Lys, Arg, His}}), the two {{c3::acidic}} ({{c4::Asp, Glu}}), and two with weakly acidic groups that ionize only at higher pH ({{c5::Tyr, Cys}}).', 5),

  (deck, 36, 'cloze',
   'Side-chain pKa values of the acidic amino acids: {{c1::aspartate ≈ 3.65}} and {{c2::glutamate ≈ 4.25}}. Both side chains are fully deprotonated (negatively charged) at physiological pH (~7.4).', 2),

  (deck, 37, 'cloze',
   'Side-chain pKa values of the basic amino acids: {{c1::lysine ≈ 10.5}}, {{c2::arginine ≈ 12.5}}, and {{c3::histidine ≈ 6.0}}. Lysine and arginine are essentially always protonated at physiological pH; histidine straddles 7.4 and can be either form.', 3),

  (deck, 38, 'cloze',
   'The two side chains that ionize only at high pH and remain protonated at physiological pH: {{c1::cysteine ≈ 8.3}} (thiol) and {{c2::tyrosine ≈ 10.1}} (phenol).', 2),

  (deck, 39, 'cloze',
   'Standard backbone pKa values shared by all amino acids: the {{c1::α-carboxyl group ≈ 2.0}} and the {{c2::α-amino group ≈ 9–10}}. At physiological pH both are ionized, producing the zwitterionic form.', 2),

  (deck, 40, 'cloze',
   'At physiological pH (~7.4), a free amino acid in solution exists as a {{c1::zwitterion}}: the α-carboxyl group is {{c2::deprotonated (-COO⁻)}} and the α-amino group is {{c2::protonated (-NH₃⁺)}}, giving a net charge of zero (for amino acids with no ionizable side chain).', 2),

  -- ── 10. Hydrophobicity in Folded Proteins ────────────────
  (deck, 41, 'cloze',
   '{{c1::Nonpolar (hydrophobic)}} amino acid side chains tend to be buried in the {{c2::interior}} of a folded protein, away from water — the hydrophobic effect is the dominant thermodynamic force driving protein folding.', 2),

  (deck, 42, 'cloze',
   '{{c1::Polar and charged (hydrophilic)}} amino acid side chains tend to sit on the {{c2::surface}} of a folded protein, where they hydrogen-bond with water and with ionic groups in the surrounding aqueous environment.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
