-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Naming Organic Molecules
-- Section: organic_chemistry · Topic: Organic Chemistry
--
-- Coverage: IUPAC nomenclature framework (4-step procedure;
-- prefix–parent–suffix structure; uniqueness of names);
-- parent chain identification (longest-chain rule, most-
-- substituted tiebreak); functional group priority order
-- (carboxylic acid > ester > amide > aldehyde > ketone >
-- alcohol > amine > alkene > alkyne > halide > alkane;
-- oxidation-state logic); chain numbering rules (lowest-locant
-- principle, double-over-triple bond tiebreak, cyclic ring
-- numbering); substituent naming (alkyl -yl, halogen prefixes,
-- di-/tri-/tetra-, iso-/neo-/cyclo-/n-, alphabetization
-- excluding multiplying prefixes); alkane series (CₙH₂ₙ₊₂;
-- meth- through dec-); alkene and alkyne suffixes (-ene, -yne);
-- alcohols (-ol; hydroxy- as substituent; alcohol takes
-- priority over multiple bonds); diols (geminal vs vicinal;
-- geminal diols dehydrate spontaneously to carbonyls);
-- aldehydes (-al, terminal carbonyl) and ketones (-one,
-- internal carbonyl) with aldehyde > ketone priority and
-- common names (formaldehyde, acetaldehyde, propionaldehyde,
-- acetone); carbonyl-as-substituent (oxo-/keto-);
-- carboxylic acids (-oic acid; common names formic/acetic/
-- propionic); and the four major derivatives — esters (-oate,
-- alkoxy group), amides (-amide, N-prefix for nitrogen
-- substituents), and anhydrides (symmetric vs asymmetric
-- naming).
--
-- All cards are CLOZE-format. Cards are ORIGINAL Praxist Prep
-- content — written from the underlying organic chemistry and
-- re-sourced from the reference textbooks listed in the
-- companion verification.md file; no prose is lifted from any
-- third-party source.
--
-- Subtopic ordering follows the AAMC content outline (Foundation
-- 4D / 5D: organic functional groups + nomenclature), NOT the
-- source .docx's chapter ordering. The ordering walks students
-- from the general IUPAC framework outward to specific
-- functional-group classes in increasing structural complexity.
--
-- This deck is the cadence reference for subsequent Organic
-- Chemistry chapters under v6 (per the prompt's style-anchor
-- rule for new subjects).
--
-- Idempotent: re-running deletes the prior version of this
-- deck and re-seeds. User review history attached to those
-- cards (flashcard_user_state, flashcard_reviews) cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  -- Wipe any prior copy of this deck (across any historical titles + the
  -- pre-migration 'chemistry' section value, since this deck moved to its
  -- own 'organic_chemistry' section in migration 20260511).
  DELETE FROM flashcard_decks
   WHERE section IN ('organic_chemistry', 'chemistry')
     AND title   IN (
           'Naming Organic Molecules',
           'Organic Nomenclature',
           'IUPAC Naming Conventions',
           'Chapter 1 — Naming Organic Molecules',
           'Chapter 1 — Nomenclature'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'organic_chemistry',
    'Organic Chemistry',
    'naming_organic_molecules',
    'Naming Organic Molecules',
    'The IUPAC system for naming organic compounds: the four-step naming procedure, functional group priority hierarchy, parent chain identification, chain numbering rules, and substituent naming conventions. Names and common names across the major functional group classes — alkanes, alkenes, alkynes, alkyl halides, alcohols, diols, aldehydes, ketones, carboxylic acids, esters, amides, and anhydrides.',
    1
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. IUPAC Framework ───────────────────────────────────
  (deck,  0, 'cloze',
   '{{c1::IUPAC nomenclature}} is the systematic naming convention used in organic chemistry; a properly assigned IUPAC name maps uniquely to one molecular structure, so the name itself encodes the molecule''s {{c2::connectivity, functional groups, and substituent positions}}.', 2),

  (deck,  1, 'cloze',
   'Every IUPAC name follows the pattern {{c1::prefix}} – {{c2::parent chain}} – {{c3::suffix}}: the prefix lists the substituents (in alphabetical order with locants), the parent chain names the longest carbon chain, and the suffix encodes the highest-priority functional group.', 3),

  (deck,  2, 'cloze',
   'To assign an IUPAC name, work in four steps: {{c1::(1) identify the longest carbon chain containing the highest-priority functional group; (2) determine the suffix from that functional group; (3) number the chain to give the highest-priority group the lowest locant; (4) name, number, and alphabetize the substituents}}, then assemble the full name.', 1),

  -- ── 2. Parent Chain Identification ───────────────────────
  (deck,  3, 'cloze',
   'The {{c1::parent chain}} is the longest continuous carbon chain that contains the {{c2::highest-priority functional group}} — even if that means choosing a chain shorter than the absolute longest run of carbons in the molecule.', 2),

  (deck,  4, 'cloze',
   'When two or more carbon chains have equal length and both contain the highest-priority functional group, the parent chain is the one with the {{c1::greater number of substituents}}.', 1),

  -- ── 3. Suffix Determination ──────────────────────────────
  (deck,  5, 'cloze',
   'The molecule''s {{c1::highest-priority functional group}} always determines the {{c2::suffix}} of the IUPAC name; any other functional groups present become {{c3::prefixes}} attached to substituent names.', 3),

  -- ── 4. Functional Group Priority ─────────────────────────
  (deck,  6, 'cloze',
   'When a molecule contains multiple functional groups, the suffix is determined by the highest-priority group. The priority order from high to low is: {{c1::carboxylic acid > ester > amide > aldehyde > ketone > alcohol > amine > alkene > alkyne > halide > alkane}}.', 1),

  (deck,  7, 'cloze',
   'The underlying logic of functional group priority is {{c1::oxidation state}}: the more bonds a carbon has to heteroatoms (O, N, halogens), the {{c2::higher}} its oxidation state and the higher its IUPAC priority; bonds to hydrogen lower the oxidation state.', 2),

  (deck,  8, 'cloze',
   'Functional group suffix summary: alcohols use {{c1::-ol}}, aldehydes use {{c1::-al}}, ketones use {{c1::-one}}, carboxylic acids use {{c1::-oic acid}}, esters use {{c1::-oate}}, and amides use {{c1::-amide}}.', 1),

  -- ── 5. Chain Numbering ───────────────────────────────────
  (deck,  9, 'cloze',
   'Carbon atoms in the parent chain are numbered so that the {{c1::highest-priority functional group}} receives the {{c2::lowest possible locant}}; when priority is uniform, the numbering minimizes the locants of the substituents.', 2),

  (deck, 10, 'cloze',
   'When a chain contains both a double and a triple bond and they would receive the same set of locants from either direction, numbering gives the {{c1::double bond}} the lower locant — the convention is "double over triple" when their priorities tie.', 1),

  (deck, 11, 'cloze',
   'In a ring, numbering starts at the carbon of {{c1::greatest substitution}} (typically the highest-priority functional group), then proceeds around the ring in the direction that gives the {{c2::lowest set of locants}} to the remaining substituents.', 2),

  -- ── 6. Substituent Naming ────────────────────────────────
  (deck, 12, 'cloze',
   'A carbon-chain substituent — a branch off the parent chain — is named like the corresponding alkane but with its {{c1::-ane}} ending replaced by {{c2::-yl}} (e.g., methane → methyl, ethane → ethyl, propane → propyl).', 2),

  (deck, 13, 'cloze',
   'Halogen substituents on a carbon chain take the prefixes {{c1::fluoro-}}, {{c1::chloro-}}, {{c1::bromo-}}, and {{c1::iodo-}}; the parent chain is otherwise named as the appropriate alkane, alkene, or alkyne.', 1),

  (deck, 14, 'cloze',
   'When the same substituent appears multiple times on a chain, its name is prefixed with {{c1::di-}} (×2), {{c1::tri-}} (×3), or {{c1::tetra-}} (×4) — and each occurrence still receives its own locant in the name.', 1),

  (deck, 15, 'cloze',
   'Several substituent or chain prefixes are written {{c1::without a hyphen}} as part of the chain name: {{c2::iso-}}, {{c2::neo-}}, and {{c2::cyclo-}}. By contrast, {{c3::n-}} ("normal") is hyphenated and indicates a straight-chain alkane.', 3),

  (deck, 16, 'cloze',
   'In the final IUPAC name, substituents are listed in {{c1::alphabetical}} order — but the multiplying prefixes ({{c2::di-, tri-, tetra-}}) are NOT counted when alphabetizing, so "diethyl" is alphabetized under "e" for ethyl, not "d" for di.', 2),

  -- ── 7. Alkane Series ─────────────────────────────────────
  (deck, 17, 'cloze',
   'The general molecular formula for a saturated, acyclic alkane is {{c1::CₙH₂ₙ₊₂}} — every additional carbon adds two hydrogens, reflecting the tetravalence of sp³ carbon.', 1),

  (deck, 18, 'cloze',
   'Carbon-chain names C1–C5: 1 carbon = {{c1::methane}}, 2 = {{c1::ethane}}, 3 = {{c1::propane}}, 4 = {{c1::butane}}, 5 = {{c1::pentane}}.', 1),

  (deck, 19, 'cloze',
   'Carbon-chain names C6–C10: 6 carbons = {{c1::hexane}}, 7 = {{c1::heptane}}, 8 = {{c1::octane}}, 9 = {{c1::nonane}}, 10 = {{c1::decane}}.', 1),

  -- ── 8. Alkenes & Alkynes ─────────────────────────────────
  (deck, 20, 'cloze',
   'Double bonds in the parent chain are indicated by the suffix {{c1::-ene}} (replacing -ane); triple bonds use {{c2::-yne}}. The locant placed immediately before the suffix gives the position of the lower-numbered carbon of the bond.', 2),

  -- ── 9. Alcohols ──────────────────────────────────────────
  (deck, 21, 'cloze',
   'Alcohols are named by replacing the {{c1::-e}} at the end of the parent alkane name with {{c2::-ol}}; the chain is then numbered so that the carbon bearing the hydroxyl group receives the {{c3::lowest possible locant}}.', 3),

  (deck, 22, 'cloze',
   'When an alcohol is NOT the highest-priority functional group in the molecule, the hydroxyl group is named as a substituent prefix: {{c1::hydroxy-}}, written like any other substituent with its own locant.', 1),

  (deck, 23, 'cloze',
   'In a molecule with both an alcohol and a multiple bond (alkene or alkyne), the {{c1::alcohol takes priority}} for naming — because the hydroxyl-bearing carbon is more highly oxidized than the doubly- or triply-bonded carbons.', 1),

  -- ── 10. Diols ────────────────────────────────────────────
  (deck, 24, 'cloze',
   'Compounds with two hydroxyl groups are called {{c1::diols}} (or {{c1::glycols}}) and are named with the suffix {{c2::-diol}}; each hydroxyl receives its own locant in the name.', 2),

  (deck, 25, 'cloze',
   'Diols with both hydroxyl groups on the {{c1::same carbon}} are called {{c2::geminal diols}}; diols with hydroxyl groups on {{c3::adjacent carbons}} are called {{c4::vicinal diols}}. Geminal diols are unstable and spontaneously {{c5::dehydrate}} to form a carbonyl compound (C=O).', 5),

  -- ── 11. Aldehydes & Ketones ──────────────────────────────
  (deck, 26, 'cloze',
   '{{c1::Aldehydes}} have a carbonyl (C=O) group at the {{c2::end of the carbon chain}} and are named by replacing the parent alkane''s -e with {{c3::-al}}. Because aldehydes are terminal, the carbonyl carbon is always {{c4::carbon number 1}}.', 4),

  (deck, 27, 'cloze',
   '{{c1::Ketones}} have a carbonyl (C=O) group somewhere {{c2::in the middle of the carbon chain}} and are named by replacing the parent alkane''s -e with {{c3::-one}}. The chain is numbered so that the carbonyl carbon gets the {{c4::lowest possible locant}}.', 4),

  (deck, 28, 'cloze',
   'When a molecule contains both an aldehyde and a ketone, the {{c1::aldehyde}} takes priority for the suffix (because it is terminal and more oxidized at its carbon); the ketone is then named as an {{c2::oxo-}} substituent on the same parent chain.', 2),

  (deck, 29, 'cloze',
   'Three common aldehyde names worth memorizing: {{c1::methanal}} is commonly called {{c2::formaldehyde}}, {{c1::ethanal}} is {{c2::acetaldehyde}}, and {{c1::propanal}} is {{c2::propionaldehyde}}.', 2),

  (deck, 30, 'cloze',
   'The simplest ketone, {{c1::propanone}} (CH₃COCH₃), is universally known by its common name {{c2::acetone}} — the same colorless solvent used in nail-polish remover.', 2),

  (deck, 31, 'cloze',
   'When a carbonyl is not the highest-priority functional group, it is named as a substituent: an aldehyde or ketone carbonyl becomes an {{c1::oxo-}} prefix, with the locant of the carbonyl carbon; some sources alternatively use {{c2::keto-}} for the same substituent role.', 2),

  -- ── 12. Carboxylic Acids ─────────────────────────────────
  (deck, 32, 'cloze',
   '{{c1::Carboxylic acids}} contain both a carbonyl AND a hydroxyl group on the same {{c2::terminal carbon}} (–COOH); they are named by replacing the parent alkane''s -e with {{c3::-oic acid}}, with the carboxyl carbon always assigned to {{c4::position 1}}.', 4),

  (deck, 33, 'cloze',
   'Three common carboxylic acid names worth memorizing: {{c1::methanoic acid}} is commonly called {{c2::formic acid}}, {{c1::ethanoic acid}} is {{c2::acetic acid}}, and {{c1::propanoic acid}} is {{c2::propionic acid}}.', 2),

  -- ── 13. Carboxylic Acid Derivatives ──────────────────────
  (deck, 34, 'cloze',
   'In an {{c1::ester}}, the hydroxyl (-OH) of a carboxylic acid is replaced by an alkoxy group (-OR). Esters are named in two parts: the {{c2::alkyl group}} from the alcohol comes first, and the acid name has its {{c3::-oic acid}} suffix replaced by {{c3::-oate}} (e.g., ethyl ethanoate, common name ethyl acetate).', 3),

  (deck, 35, 'cloze',
   'The {{c1::alkoxy group}} (–OR, where R is an alkyl chain) is the substituent that replaces the hydroxyl of a carboxylic acid when forming an ester; it is also the structural feature that defines an ether.', 1),

  (deck, 36, 'cloze',
   'In an {{c1::amide}}, the hydroxyl (-OH) of a carboxylic acid is replaced by an {{c2::amino group}} (-NH₂, -NHR, or -NR₂). Amides are named by replacing the parent acid''s {{c3::-oic acid}} suffix with {{c3::-amide}}.', 3),

  (deck, 37, 'cloze',
   'When a substituent is attached to the nitrogen of an amide rather than to a carbon of the parent chain, its locant is given as {{c1::N-}} (capital N) instead of a number — for example, N-methylpropanamide has a methyl group on the amide nitrogen.', 1),

  (deck, 38, 'cloze',
   'An {{c1::anhydride}} forms when two carboxylic acid molecules condense and a water molecule is removed; if both acids are the same, the anhydride is named by replacing "acid" with {{c2::"anhydride"}} in the parent name (e.g., acetic anhydride from two acetic acids).', 2),

  (deck, 39, 'cloze',
   'If an {{c1::asymmetric anhydride}} is formed from two different carboxylic acids, both acids are named in alphabetical order before the word "anhydride" — e.g., ethanoic propanoic anhydride for the mixed anhydride of acetic and propionic acids.', 1);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
