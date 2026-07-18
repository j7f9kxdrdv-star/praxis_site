-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Chapter 8 — Biological Membranes
-- ════════════════════════════════════════════════════════════════════
-- Section: biochemistry
-- Topic:   Biochemistry
-- Subtopic slug: biological_membranes
-- Sort order: 8
--
-- Coverage (AAMC-aligned order, NOT mirroring the chapter outline):
--    1. Fluid Mosaic Model & Membrane Dynamics
--    2. Membrane Lipids
--    3. Membrane Proteins & Carbohydrates
--    4. Intercellular Junctions
--    5. Passive Transport & Osmosis
--    6. Active & Bulk Transport
--    7. Membrane Potential & Specialized Membranes
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Biology 2e (Ch 5 Structure and Function of Plasma Membranes) and LibreTexts
-- Biochemistry. Scope: membrane structure/transport only — the electron transport
-- chain and oxidative phosphorylation are the metabolism chapters. See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'biochemistry'
      AND title IN (
          'Biological Membranes',
          'Biochemistry Review Chapter Eight: Biological Membranes'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'biochemistry',
        'Biochemistry',
        'biological_membranes',
        'Biological Membranes',
        'The fluid mosaic model and membrane dynamics, membrane lipids (bilayer, cholesterol) and proteins/carbohydrates, intercellular junctions, passive transport and osmosis, active and bulk transport (the Na⁺/K⁺ pump, endo/exocytosis), and membrane potential and specialized mitochondrial membranes.',
        8
    )
    RETURNING id INTO deck;

    -- ── Fluid Mosaic Model & Membrane Dynamics ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'The {{c1::fluid mosaic model}} portrays the plasma membrane as a phospholipid bilayer studded with proteins and coated with surface carbohydrates, all able to move laterally within it.',
     1),
    (deck, 1, 'cloze',
     'The membrane''s hydrophobic core blocks most ions and polar molecules, making it {{c1::selectively permeable}}.',
     1),
    (deck, 2, 'cloze',
     'Movement of a lipid within its own leaflet, called {{c1::lateral diffusion}}, is rapid, whereas {{c2::flip-flop}} to the opposite leaflet happens only rarely on its own.',
     2),
    (deck, 3, 'cloze',
     'Membrane proteins undergo lateral diffusion far more slowly than {{c1::lipids}}, because their large size resists sliding through the bilayer.',
     1),
    (deck, 4, 'cloze',
     '{{c1::Flippases}} hydrolyze {{c2::ATP}} to move phospholipids between the two leaflets, keeping the membrane''s lipid distribution asymmetric.',
     2),
    (deck, 5, 'cloze',
     'Cholesterol- and sphingolipid-rich microdomains called {{c1::lipid rafts}} gather {{c2::signaling}} proteins together within the otherwise fluid membrane.',
     2),
    (deck, 6, 'cloze',
     'Counted as individual molecules, {{c1::lipids}} are by far the most numerous component of a plasma membrane.',
     1);

    -- ── Membrane Lipids ───────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
     'Having both a hydrophilic region and a hydrophobic region makes a molecule {{c1::amphipathic}}; phospholipids are the classic membrane example.',
     1),
    (deck, 8, 'cloze',
     'In a phospholipid, the phosphate head group is {{c1::hydrophilic}} while the two fatty-acid tails are {{c1::hydrophobic}}.',
     1),
    (deck, 9, 'cloze',
     'Burying the hydrophobic tails away from water (the hydrophobic effect) drives phospholipids to self-assemble into a {{c1::bilayer}}, heads facing the aqueous surfaces.',
     1),
    (deck, 10, 'cloze',
     'The most abundant structural phospholipids in cell membranes are the {{c1::glycerophospholipids}}.',
     1),
    (deck, 11, 'cloze',
     'Most membrane phospholipids are built on a three-carbon {{c1::glycerol}} backbone esterified to two fatty acids and a phosphate-linked head.',
     1),
    (deck, 12, 'cloze',
     'Cholesterol buffers the membrane against temperature swings: when cold it prevents {{c1::solidifying}}, and when hot it curbs {{c1::excess fluidity and permeability}}.',
     1),
    (deck, 13, 'cloze',
     'Cholesterol is a steroid, its structure built from {{c1::four}} fused hydrocarbon rings, a hydroxyl group, and a short tail.',
     1),
    (deck, 14, 'cloze',
     'Membrane fluidity increases with fatty-acid tail {{c1::unsaturation}} and with higher {{c2::temperature}}.',
     2),
    (deck, 15, 'cloze',
     'A cis double bond puts a rigid {{c1::kink}} in a fatty-acid tail, so unsaturated tails cannot pack together as tightly as straight saturated ones.',
     1),
    (deck, 16, 'cloze',
     'Waxes are only a {{c1::minor}} membrane component; their main biological role is {{c2::waterproofing}} surfaces such as plant leaves and bird feathers.',
     2);

    -- ── Membrane Proteins & Carbohydrates ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 17, 'cloze',
     '{{c1::Integral}} membrane proteins are anchored in the bilayer by {{c2::hydrophobic}} regions that span the membrane.',
     2),
    (deck, 18, 'cloze',
     '{{c1::Peripheral}} membrane proteins are not embedded; they bind the surface through weak {{c2::electrostatic (noncovalent)}} interactions with lipid heads or integral proteins.',
     2),
    (deck, 19, 'cloze',
     'Beyond simple structure, membrane proteins collectively function in {{c1::transport}}, {{c1::enzymatic catalysis}}, cell {{c1::signaling (as receptors)}}, and cell {{c1::adhesion}}.',
     1),
    (deck, 20, 'cloze',
     'Because they alone span the entire bilayer, integral proteins — not peripheral ones — form the membrane''s {{c1::channels and transporters}}.',
     1),
    (deck, 21, 'cloze',
     'On the membrane''s inner (cytoplasmic) surface, peripheral proteins commonly tether the {{c1::cytoskeleton}}, giving the cell mechanical support.',
     1),
    (deck, 22, 'cloze',
     'A cell''s outer sugar coat — carbohydrate chains attached to surface proteins and lipids — is the {{c1::glycocalyx}}.',
     1),
    (deck, 23, 'cloze',
     'The glycocalyx''s unique carbohydrate patterns mediate cell {{c1::recognition}}, so the immune system can tell {{c1::self from non-self}}.',
     1),
    (deck, 24, 'cloze',
     'An extracellular {{c1::ligand}} binding a membrane {{c1::receptor}} triggers an intracellular {{c2::second-messenger}} cascade that relays the signal inward.',
     2);

    -- ── Intercellular Junctions ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 25, 'cloze',
     'In animal tissues, {{c1::gap junctions}} are direct channels that let ions and small molecules move straight from one cell''s cytoplasm into its neighbor''s.',
     1),
    (deck, 26, 'cloze',
     'Each cell contributes half of a gap-junction channel: a ring of six {{c1::connexin}} proteins called a {{c1::connexon}}.',
     1),
    (deck, 27, 'cloze',
     '{{c1::Tight junctions}} form a leak-proof seal between adjacent cells, blocking paracellular movement — fluid and solutes slipping through the gaps between them.',
     1),
    (deck, 28, 'cloze',
     'Beyond forming a seal, tight junctions act as a fence: by blocking membrane proteins from diffusing across the junction, they maintain cell {{c1::polarity}}.',
     1),
    (deck, 29, 'cloze',
     '{{c1::Desmosomes}} act like spot welds, using {{c2::cadherins}} linked to intermediate filaments to give stretch-prone tissues such as skin and heart mechanical strength.',
     2),
    (deck, 30, 'cloze',
     '{{c1::Hemidesmosomes}} anchor an epithelial cell to the underlying {{c2::basement membrane}}, rather than binding it to a neighboring cell.',
     2);

    -- ── Passive Transport & Osmosis ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 31, 'cloze',
     'Passive transport moves a solute {{c1::down}} its concentration gradient, so the cell spends {{c1::no}} energy.',
     1),
    (deck, 32, 'cloze',
     'Passive transport is spontaneous (ΔG < 0) mainly because a solute spreading down its gradient raises the system''s {{c1::entropy}}.',
     1),
    (deck, 33, 'cloze',
     'In {{c1::simple diffusion}}, small nonpolar molecules such as O₂ and CO₂ cross the bilayer directly, without a transport protein.',
     1),
    (deck, 34, 'cloze',
     'Facilitated diffusion uses {{c1::channel or carrier}} proteins to move {{c2::polar or charged}} solutes down their concentration gradient — no energy needed.',
     2),
    (deck, 35, 'cloze',
     '{{c1::Osmosis}} is water diffusing through a selectively permeable membrane toward the region of {{c2::higher solute}} concentration.',
     2),
    (deck, 36, 'cloze',
     '{{c1::Aquaporins}} are channel proteins that let water cross the membrane rapidly during osmosis.',
     1),
    (deck, 37, 'cloze',
     'A cell placed in a {{c1::hypertonic}} solution loses water and shrinks.',
     1),
    (deck, 38, 'cloze',
     'In a hypotonic solution, a cell {{c1::gains water, swells, and may lyse}}.',
     1),
    (deck, 39, 'cloze',
     'In an {{c1::isotonic}} solution there is no net water movement, so the cell''s volume stays the same.',
     1),
    (deck, 40, 'cloze',
     'Osmotic pressure is a {{c1::colligative}} property, given by π = {{c2::iMRT}}.',
     2),
    (deck, 41, 'cloze',
     'Colligative properties such as osmotic pressure depend on the {{c1::number}} of dissolved solute particles, not their {{c1::chemical identity}}.',
     1);

    -- ── Active & Bulk Transport ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'Active transport moves a solute {{c1::against}} its concentration gradient, requiring the cell to spend {{c1::energy}}.',
     1),
    (deck, 43, 'cloze',
     'Primary active transport draws energy directly from {{c1::ATP}}, while secondary active transport is driven by an existing {{c1::ion}} gradient.',
     1),
    (deck, 44, 'cloze',
     'The Na⁺/K⁺ pump is the classic example of {{c1::primary}} active transport.',
     1),
    (deck, 45, 'cloze',
     'A symporter moves its two solutes in the {{c1::same}} direction, while an antiporter moves them in {{c1::opposite}} directions.',
     1),
    (deck, 46, 'cloze',
     'For every ATP it hydrolyzes, the Na⁺/K⁺-ATPase pumps {{c1::3}} Na⁺ out of the cell and {{c1::2}} K⁺ in.',
     1),
    (deck, 47, 'cloze',
     'Because it ejects 3 Na⁺ for every 2 K⁺ it takes in, the Na⁺/K⁺ pump is {{c1::electrogenic}}.',
     1),
    (deck, 48, 'cloze',
     'In {{c1::endocytosis}}, the plasma membrane folds inward and pinches off a vesicle that brings material into the cell.',
     1),
    (deck, 49, 'cloze',
     'Both are types of endocytosis: {{c1::pinocytosis}} takes in extracellular fluid, whereas {{c1::phagocytosis}} engulfs large solid particles.',
     1),
    (deck, 50, 'cloze',
     'In {{c1::exocytosis}}, a vesicle fuses with the plasma membrane to release its contents outside the cell.',
     1);

    -- ── Membrane Potential & Specialized Membranes ────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 51, 'cloze',
     'The resting membrane potential is established and maintained by the {{c1::Na⁺/K⁺ pump}} and {{c1::K⁺ leak channels}}.',
     1),
    (deck, 52, 'cloze',
     'Because K⁺ leaks out of a resting cell faster than Na⁺ leaks in, the inside is left electrically {{c1::negative}} relative to the outside.',
     1),
    (deck, 53, 'cloze',
     'A typical neuron''s resting membrane potential is about {{c1::−70 mV}}.',
     1),
    (deck, 54, 'cloze',
     'The {{c1::Nernst}} equation converts a single ion''s concentration gradient into that ion''s {{c2::equilibrium}} potential.',
     2),
    (deck, 55, 'cloze',
     'The {{c1::Goldman-Hodgkin-Katz}} equation estimates the resting potential from several ions at once, each weighted by its relative {{c2::permeability}}.',
     2),
    (deck, 56, 'cloze',
     '{{c2::Porins}} riddle the {{c1::outer}} mitochondrial membrane, letting ions and small metabolites pass freely.',
     2),
    (deck, 57, 'cloze',
     'Ions and small molecules cannot freely cross the highly impermeable {{c1::inner}} mitochondrial membrane.',
     1),
    (deck, 58, 'cloze',
     'The inner mitochondrial membrane is folded into {{c1::cristae}}, which expand its surface area.',
     1),
    (deck, 59, 'cloze',
     'Among cell membranes, the inner mitochondrial membrane is unusual in containing essentially no {{c1::cholesterol}}.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 60;
END $$;
