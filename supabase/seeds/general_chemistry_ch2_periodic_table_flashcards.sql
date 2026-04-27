-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Reading the Periodic Table — Trends, Families, and Reactivity
-- Section: chemistry · Topic: General Chemistry
--
-- Coverage: periodic table organization (periodic law, periods,
-- groups, valence shell vs valence electrons, representative vs
-- non-representative elements, lanthanides and actinides);
-- types of elements (metals, nonmetals, metalloids); periodic
-- properties (effective nuclear charge, atomic and ionic radii,
-- ionization energy, electron affinity, electronegativity, the
-- Pauling scale); the chemistry of the named groups (alkali,
-- alkaline earth, chalcogens, halogens, noble gases, transition
-- metals).
--
-- All cards are CLOZE-format. Cards are original Praxist Prep
-- content (reworded from source material).
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
  -- (also matches older Kaplan-styled names in case any were previously seeded)
  DELETE FROM flashcard_decks
   WHERE section = 'chemistry'
     AND topic   = 'General Chemistry'
     AND title   IN (
       'Reading the Periodic Table — Trends, Families, and Reactivity',
       'The Periodic Table',
       'Chapter 2 — The Periodic Table'
     );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'chemistry',
    'General Chemistry',
    'periodic_trends_and_groups',
    'Reading the Periodic Table — Trends, Families, and Reactivity',
    'Periodic table organization, types of elements, periodic properties (Z_eff, atomic and ionic radii, ionization energy, electron affinity, electronegativity), and the chemistry of the named groups.',
    2
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── The Periodic Table ────────────────────────────────────
  (deck,  0, 'cloze',
   'The {{c1::periodic law}} states that when elements are arranged by atomic number, their chemical and physical properties recur at {{c2::regular intervals}}.', 2),

  (deck,  1, 'cloze',
   'The modern periodic table arranges elements in order of increasing {{c1::atomic number}}, surfacing the recurring patterns in their {{c2::chemical and physical properties}}.', 2),

  (deck,  2, 'cloze',
   'The horizontal {{c1::rows}} of the periodic table are called {{c2::periods}}, and elements in the same period share the same {{c3::principal energy level (n)}} for their valence electrons.', 3),

  (deck,  3, 'cloze',
   'The vertical {{c1::columns}} of the periodic table are called {{c2::groups (or families)}}, and elements within a group share the same {{c3::valence-shell electron configuration}}, which drives their similar reactivity.', 3),

  (deck,  4, 'cloze',
   'The {{c1::valence shell}} is an atom''s outermost occupied energy level, and the electrons within it — the {{c2::valence electrons}} — are the ones that participate in bonding and chemical reactions.', 2),

  (deck,  5, 'cloze',
   'Elements in the s- and p-block columns are called {{c1::representative (A) elements}}, while elements in the d- and f-blocks (the transition metals, lanthanides, and actinides) are the {{c2::non-representative (B) elements}}.', 2),

  (deck,  6, 'cloze',
   'The two rows separated below the main table are the {{c1::lanthanides}} (period 6, atomic numbers 57–71) and the {{c2::actinides}} (period 7, atomic numbers 89–103) — both are inner transition elements that fill the {{c3::f-orbitals}}.', 3),

  -- ── Types of Elements ─────────────────────────────────────
  (deck,  7, 'cloze',
   '{{c1::Metals}} occupy the left and center of the periodic table, are {{c2::lustrous, malleable, and ductile}}, and conduct heat and electricity well.', 2),

  (deck,  8, 'cloze',
   'Because metals readily lose their valence electrons, they are highly {{c1::electropositive}} and frequently appear in compounds with positive {{c2::oxidation states}}, sometimes in more than one common state.', 2),

  (deck,  9, 'cloze',
   '{{c1::Nonmetals}} sit on the right side of the table, are {{c2::dull and brittle}} as solids, conduct poorly, and carry the highest values of {{c3::ionization energy, electron affinity, and electronegativity}}.', 3),

  (deck, 10, 'cloze',
   '{{c1::Metalloids}} run along a {{c2::stair-step}} boundary between metals and nonmetals on the periodic table and exhibit properties intermediate between the two — most are useful as {{c3::semiconductors}}.', 3),

  -- ── Periodic Properties of the Elements ───────────────────
  (deck, 11, 'cloze',
   'The {{c1::effective nuclear charge (Z_eff)}} is the net positive pull a valence electron actually feels from the nucleus after accounting for inner-shell shielding, and it {{c2::increases}} from left to right across a period.', 2),

  (deck, 12, 'cloze',
   'Atomic radius {{c1::decreases}} from left to right across a period (Z_eff rises and pulls valence electrons inward) and {{c2::increases}} from top to bottom down a group (additional shells are added).', 2),

  (deck, 13, 'cloze',
   'A {{c1::cation}} is always smaller than its parent atom (electrons lost, less repulsion), whereas an {{c2::anion}} is always larger than its parent atom (electrons gained, more repulsion).', 2),

  (deck, 14, 'cloze',
   'Among isoelectronic ions, ionic radius {{c1::decreases}} as nuclear charge {{c2::increases}}, so a more positively charged cation is smaller than a less positively charged ion with the same electron count.', 2),

  (deck, 15, 'cloze',
   'The {{c1::ionization energy (IE)}} is the energy required to remove an electron from a gaseous atom or ion''s valence shell, making it always positive — that is, an {{c2::endothermic}} process.', 2),

  (deck, 16, 'cloze',
   'Ionization energy {{c1::increases}} from left to right across a period (electrons are held more tightly as Z_eff rises) and {{c2::decreases}} from top to bottom down a group (valence electrons sit farther from the nucleus and are shielded by more inner shells).', 2),

  (deck, 17, 'cloze',
   'The first ionization energy ({{c1::IE₁}}) removes the most loosely bound electron, while the second ionization energy ({{c2::IE₂}}) removes the next one — IE₂ is always {{c3::larger}} than IE₁ because the cation already left behind holds its remaining electrons more tightly.', 3),

  (deck, 18, 'cloze',
   'The {{c1::electron affinity (EA)}} is the energy released when a gaseous atom or ion gains an electron into its valence shell, generally an {{c2::exothermic}} process reported with a negative sign.', 2),

  (deck, 19, 'cloze',
   'Electron affinity becomes more negative (releases more energy) moving {{c1::left to right}} across a period and less negative moving {{c2::top to bottom}} down a group, with halogens having the most exothermic values.', 2),

  (deck, 20, 'cloze',
   '{{c1::Electronegativity}} measures an atom''s pull on the shared electrons of a covalent bond and is most commonly reported on the dimensionless {{c2::Pauling scale}}, where fluorine sits at the top at ~4.0.', 2),

  (deck, 21, 'cloze',
   'Electronegativity {{c1::increases}} from left to right across a period and {{c2::decreases}} from top to bottom down a group, mirroring ionization energy and electron affinity trends.', 2),

  -- ── The Chemistry of Groups ───────────────────────────────
  (deck, 22, 'cloze',
   '{{c1::Alkali metals}} (Group {{c2::1A / 1}}) readily lose their single valence electron to form {{c3::+1}} cations, achieving the electron configuration of the preceding noble gas.', 3),

  (deck, 23, 'cloze',
   'Because alkali metals have only one loosely held valence electron, they show very low effective nuclear charge, the largest atomic radii in their periods, and the lowest {{c1::ionization energies, electron affinities, and electronegativities}} in their rows.', 1),

  (deck, 24, 'cloze',
   '{{c1::Alkaline earth metals}} (Group {{c2::2A / 2}}) lose two valence electrons to form {{c3::+2}} cations, again reaching noble gas configuration.', 3),

  (deck, 25, 'cloze',
   'Compared with alkali metals in the same period, alkaline earth metals have {{c1::slightly higher}} effective nuclear charges and {{c2::slightly smaller}} atomic radii because of the additional proton.', 2),

  (deck, 26, 'cloze',
   '{{c1::Chalcogens}} (Group {{c2::6A / 16}}) most commonly carry a {{c3::−2}} oxidation state — gaining two electrons to complete their octet — but can also reach a positive {{c4::+6}} state when bonded to more electronegative atoms, as sulfur does in SO₃ and SO₄²⁻.', 4),

  (deck, 27, 'cloze',
   '{{c1::Halogens}} (Group {{c2::7A / 17}}) are highly reactive nonmetals with seven valence electrons; they typically gain one to form {{c3::−1}} anions and possess the {{c4::highest electronegativities}} in the periodic table.', 4),

  (deck, 28, 'cloze',
   '{{c1::Noble gases}} (Group {{c2::8A / 18}}) have completely filled valence shells, giving them very high {{c3::ionization energies}} and almost no measurable {{c4::electronegativity or electron affinity}} — making them chemically inert under most conditions.', 4),

  (deck, 29, 'cloze',
   'All noble gases exist as {{c1::monatomic gases}} at room temperature and have characteristically {{c2::low boiling points}}, reflecting the weak London dispersion forces between their atoms.', 2),

  (deck, 30, 'cloze',
   '{{c1::Transition metals}} occupy Groups {{c2::1B–8B / 3–12}} and are unusual among metals because they can adopt several different {{c3::oxidation states}} and form colorful coordination {{c4::complexes}} with bound ligands.', 4),

  (deck, 31, 'cloze',
   'Transition metals also share characteristically {{c1::high melting and boiling points}} as well as {{c2::low ionization energies, electron affinities, and electronegativities}} compared with the representative metals.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
