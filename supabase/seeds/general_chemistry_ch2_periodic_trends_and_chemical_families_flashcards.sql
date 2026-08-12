-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Periodic Trends & Chemical Families
-- Section: chemistry · Topic: General Chemistry
--
-- Coverage: history of the periodic table (Mendeleev → Moseley
-- → periodic law); table structure (periods vs groups,
-- representative A vs non-representative B elements, Roman-
-- numeral = valence count rule); metals, nonmetals, metalloids
-- (locations and characteristic properties; metallic
-- conductivity from delocalized valence electrons); effective
-- nuclear charge (Z_eff = Z − S; trends across periods and
-- down groups); atomic radius (definition + trends);
-- ionic radius (cation < parent < anion; isoelectronic series
-- behavior); ionization energy (definition + trends;
-- successive IEs and noble-gas-core jumps); electron affinity
-- (definition, sign conventions, trends); electronegativity
-- (definition, trends, Pauling scale Cs ≈ 0.7 to F = 4.0,
-- noble-gas exceptions); the chemical families — alkali metals
-- (1A, +1 cation, "active metals" with alkaline earths,
-- never elemental, hydrogen exception); alkaline earth metals
-- (2A, +2 cation); chalcogens (6A, −2 typical, higher states
-- for sulfur); halogens (7A, 7 valence electrons, fluorine
-- most electronegative, phase range, halides and X₂);
-- noble gases (8A, full valence shell, helium exception,
-- heavier noble gas compounds like XeF₂); transition metals
-- (d-block, multiple oxidation states, conductivity and high
-- mp/bp, colored complexes via d-orbital splitting and
-- complementary-color reflection); and the lanthanide and
-- actinide f-block.
--
-- All cards are CLOZE-format. Cards are ORIGINAL Praxist Prep
-- content — written from the underlying chemistry and
-- re-sourced from the reference textbooks listed in the
-- companion verification.md file; no prose is lifted from any
-- third-party source.
--
-- Subtopic ordering follows the AAMC content outline
-- (Foundation 4E: periodic table subsection), NOT the source
-- .docx's chapter ordering. Style follows the Ch1 cadence
-- reference (general_chemistry_ch1_inside_the_atom_flashcards.sql).
--
-- Idempotent: re-running deletes the prior version of this
-- deck and re-seeds. User review history attached to those
-- cards (flashcard_user_state, flashcard_reviews) cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  -- Wipe any prior copy of this deck (across any historical titles)
  DELETE FROM flashcard_decks
   WHERE section = 'chemistry'
     AND title   IN (
           'Periodic Trends & Chemical Families',
           'Reading the Periodic Table — Trends, Families, and Reactivity',
           'The Periodic Table',
           'Chapter 2 — Periodic Trends & Chemical Families',
           'Chapter 2 — The Periodic Table'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'chemistry',
    'General Chemistry',
    'periodic_trends_and_chemical_families',
    'Periodic Trends & Chemical Families',
    'History of the periodic table, table structure (periods, groups, A vs B elements); metals, nonmetals, metalloids; the six core periodic trends (effective nuclear charge, atomic and ionic radii, ionization energy, electron affinity, electronegativity) with their mechanisms; and the chemistry of the major chemical families — alkali metals, alkaline earths, chalcogens, halogens, noble gases, transition metals, and lanthanide/actinide series.',
    2
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. Historical Foundation ─────────────────────────────
  (deck,  0, 'cloze',
   'In 1869, {{c1::Dmitri Mendeleev}} published the first periodic table by arranging the known elements in order of {{c2::increasing atomic weight}} and noticing that chemical and physical properties recurred at regular intervals.', 2),

  (deck,  1, 'cloze',
   'After the discovery of the proton, {{c1::Henry Moseley}} re-ordered the elements by {{c2::increasing atomic number}} rather than atomic weight, resolving several out-of-order anomalies in the original arrangement.', 2),

  (deck,  2, 'cloze',
   'The {{c1::periodic law}} states that the chemical and physical properties of the elements are a periodic function of their {{c2::atomic numbers}} — as Z increases, certain properties recur at regular intervals corresponding to the underlying electronic structure.', 2),

  -- ── 2. Table Structure ───────────────────────────────────
  (deck,  3, 'cloze',
   'Horizontal rows of the periodic table are called {{c1::periods}}; every element to the right has one more proton (and one more electron) than the element to its left. Vertical columns are called {{c2::groups}} (or families); elements within a group share the same {{c3::valence electron configuration}} and therefore similar chemistry.', 3),

  (deck,  4, 'cloze',
   'The {{c1::A elements}} (groups 1A–8A) are called {{c2::representative elements}}; the {{c3::B elements}} include the transition metals plus the lanthanide and actinide series and are called {{c4::non-representative elements}}.', 4),

  (deck,  5, 'cloze',
   'For the representative ({{c1::A}}) elements, valence electrons sit in the {{c2::highest s and p subshells}} only — which is why the Roman-numeral group label maps directly onto valence electron count.', 2),

  (deck,  6, 'cloze',
   'For the {{c1::transition metals}}, valence electrons occupy the highest {{c2::s and d subshells}}; for the {{c1::lanthanide and actinide series}}, valence electrons occupy the highest {{c2::s and f subshells}}.', 2),

  (deck,  7, 'cloze',
   'For any A-group representative element, the Roman numeral above the group equals the {{c1::number of valence electrons}} — e.g., Group 5A elements have 5 valence electrons, Group 7A have 7.', 1),

  -- ── 3. Metals, Nonmetals, Metalloids ─────────────────────
  (deck,  8, 'cloze',
   '{{c1::Metals}} occupy the left and middle of the periodic table and share a distinctive cluster of properties: they are {{c2::lustrous}} (shiny), {{c2::malleable}} (hammerable), {{c2::ductile}} (drawable into wires), and good {{c2::conductors of heat and electricity}}.', 2),

  (deck,  9, 'cloze',
   'A metal is characterized by {{c1::low}} effective nuclear charge, {{c1::low}} electronegativity, {{c1::low}} ionization energy, {{c1::low}} electron affinity, a {{c2::large}} atomic radius, and a {{c2::small}} ionic radius — all consequences of valence electrons that are weakly held by the nucleus.', 2),

  (deck, 10, 'cloze',
   '{{c1::Nonmetals}} sit in the upper right of the periodic table and are essentially the opposite of metals: {{c2::brittle}} as solids with no metallic luster, with {{c3::high}} electronegativity, ionization energy, and electron affinity, and a {{c4::small}} atomic radius but a {{c4::large}} ionic radius.', 4),

  (deck, 11, 'cloze',
   'The {{c1::metalloids}} occupy a {{c2::stair-step}} pattern separating metals from nonmetals (B, Si, Ge, As, Sb, Te); their electronegativities and ionization energies fall between the two extremes, and their physical properties mix metallic and nonmetallic character.', 2),

  (deck, 12, 'cloze',
   'Metals conduct heat and electricity well because their valence electrons are {{c1::loosely held and delocalized}} — free to move through the metallic lattice. The same delocalized electron "sea" is responsible for the metallic {{c2::luster}}, since loose electrons readily absorb and re-emit visible light.', 2),

  -- ── 4. Effective Nuclear Charge ──────────────────────────
  (deck, 13, 'cloze',
   '{{c1::Effective nuclear charge (Zeff)}} is the net positive charge actually experienced by an atom''s outermost electrons after accounting for {{c2::shielding}} by the inner-shell electrons — formally Zeff ≈ {{c3::Z − S}}, where S is the shielding constant.', 3),

  (deck, 14, 'cloze',
   'Zeff {{c1::increases}} from left to right across a period (more protons added with negligible new shielding) but stays roughly {{c2::constant}} down a group (each added shell provides new shielding that cancels the added nuclear charge).', 2),

  -- ── 5. Atomic Radius ─────────────────────────────────────
  (deck, 15, 'cloze',
   'The {{c1::atomic radius}} of an element is defined as {{c2::half the distance}} between the nuclei of two like atoms in contact — typically measured from bond lengths in a diatomic molecule or a metallic / ionic crystal.', 2),

  (deck, 16, 'cloze',
   'Atomic radius {{c1::decreases}} from left to right across a period (rising Zeff pulls the same outer shell tighter) and {{c2::increases}} from top to bottom in a group (each new period adds an electron shell at a larger principal quantum number).', 2),

  -- ── 6. Ionic Radius ──────────────────────────────────────
  (deck, 17, 'cloze',
   '{{c1::Cations}} are always smaller than their parent neutral atoms — electron loss reduces electron-electron repulsion and may eliminate the outermost shell entirely. {{c2::Anions}} are always larger than their parents because added electrons increase repulsion within the outer shell.', 2),

  (deck, 18, 'cloze',
   'Ionic radius {{c1::increases}} down a group as new shells are added. Across a period, cation radii {{c2::decrease}} left to right and anion radii {{c2::decrease}} left to right — but the radius {{c3::jumps up}} at the cation→anion transition, where the added electrons no longer have proportionally stronger nuclear binding.', 3),

  -- ── 7. Ionization Energy ─────────────────────────────────
  (deck, 19, 'cloze',
   '{{c1::Ionization energy}} is the energy required to remove one electron from a gaseous atom or ion in its ground state; because pulling a negative electron away from a positive nucleus always requires input of energy, ionization is an {{c2::endothermic}} process.', 2),

  (deck, 20, 'cloze',
   'Ionization energy {{c1::increases}} from left to right across a period (rising Zeff binds the valence electron more tightly) and {{c2::decreases}} from top to bottom in a group (valence electron is farther from the nucleus and more shielded).', 2),

  (deck, 21, 'cloze',
   'Successive ionization energies follow the pattern {{c1::IE₁ < IE₂ < IE₃}}, because each subsequent electron is being removed from a progressively more positive cation. A particularly large jump between consecutive values signals that the (n+1)ᵗʰ electron is being pulled from a {{c2::noble-gas core}} — a useful diagnostic for counting the element''s valence electrons.', 2),

  -- ── 8. Electron Affinity ─────────────────────────────────
  (deck, 22, 'cloze',
   '{{c1::Electron affinity}} is the energy change when a gaseous atom gains an electron; for most atoms this releases energy (ΔH negative), making EA an {{c2::exothermic}} process. By convention, EA is often reported as a {{c3::positive number}} reflecting the magnitude of energy released.', 3),

  (deck, 23, 'cloze',
   'Electron affinity {{c1::increases}} (becomes more exothermic) from left to right across a period and {{c2::decreases}} from top to bottom in a group. {{c3::Group 1A and 2A}} elements have very low EAs (they prefer to lose electrons), while {{c4::halogens (Group 7A)}} have the highest EAs.', 4),

  -- ── 9. Electronegativity ─────────────────────────────────
  (deck, 24, 'cloze',
   '{{c1::Electronegativity}} is the relative ability of an atom to attract the {{c2::shared electrons}} in a chemical bond — a derived property that correlates closely with ionization energy: low IE → low EN, and vice versa.', 2),

  (deck, 25, 'cloze',
   'Electronegativity {{c1::increases}} from left to right across a period and {{c2::decreases}} from top to bottom in a group — the same direction pattern as ionization energy.', 2),

  (deck, 26, 'cloze',
   'The Pauling electronegativity scale runs from about {{c1::0.7}} for {{c2::cesium}} (the least electronegative common element) to {{c3::4.0}} for {{c4::fluorine}} (the most electronegative element of all). The first three noble gases (He, Ne, Ar) have {{c5::no assigned EN}} because they do not form bonds under ordinary conditions.', 5),

  -- ── 10. Alkali Metals (Group 1A) ─────────────────────────
  (deck, 27, 'cloze',
   'The {{c1::alkali metals}} (Group 1A) possess most classic metallic properties but with notably {{c2::lower densities}} than other metals; they have the {{c3::largest atomic radii}} in their period and correspondingly the {{c4::lowest ionization energy, electron affinity, and electronegativity}} of any element in their period.', 4),

  (deck, 28, 'cloze',
   'Each alkali metal has a single, loosely bound valence electron; losing it produces a {{c1::+1 cation}} with the electron configuration of the {{c2::previous noble gas}} — the energetic payoff that makes alkali metals so reactive.', 2),

  (deck, 29, 'cloze',
   'Groups {{c1::1A and 2A}} together are called the {{c2::active metals}} because their ionization energies are so low that they are never found in {{c3::elemental (neutral) form}} in nature — only as ions in compounds, minerals, or ores.', 3),

  (deck, 30, 'cloze',
   '{{c1::Hydrogen}} sits above lithium in Group 1A because it has a single valence electron, but it does NOT share most alkali-metal properties: it is a {{c2::nonmetal}}, has a much higher ionization energy, and commonly forms covalent bonds rather than ionic ones.', 2),

  -- ── 11. Alkaline Earth Metals (Group 2A) ─────────────────
  (deck, 31, 'cloze',
   'The {{c1::alkaline earth metals}} (Group 2A) share most metallic properties with the alkalis but have a {{c2::higher effective nuclear charge}} and {{c3::smaller atomic radius}} in any given period, plus correspondingly higher ionization energies and densities.', 3),

  (deck, 32, 'cloze',
   'Each alkaline earth element has two valence electrons in an s subshell; losing both produces a {{c1::+2 cation}} with the configuration of the previous noble gas.', 1),

  -- ── 12. Chalcogens (Group 6A) ────────────────────────────
  (deck, 33, 'cloze',
   'The {{c1::chalcogens}} (Group 6A) — oxygen, sulfur, selenium, tellurium, polonium — carry {{c2::six valence electrons}} and typically adopt a {{c3::−2}} oxidation state by gaining two electrons. Sulfur and the heavier members can also reach higher oxidation states (+4 in SO₂, +6 in SO₃ / SO₄²⁻) when bonded to more electronegative atoms.', 3),

  -- ── 13. Halogens (Group 7A) ──────────────────────────────
  (deck, 34, 'cloze',
   'The {{c1::halogens}} (Group 7A) carry {{c2::seven valence electrons}} and need to gain just one more to complete an octet — which is why they have the {{c3::highest electron affinities}} of any group and are the most reactive nonmetals.', 3),

  (deck, 35, 'cloze',
   'Of all elements, {{c1::fluorine}} has the highest electronegativity (Pauling value {{c2::4.0}}), making it the strongest atomic attractor of bonding electrons known.', 2),

  (deck, 36, 'cloze',
   'At room temperature, the halogens span all three condensed phases: {{c1::F₂ and Cl₂ are gases}}, {{c2::Br₂ is a liquid}}, and {{c3::I₂ is a solid}} — the trend reflects rising molecular weight (and London dispersion forces) down the group.', 3),

  (deck, 37, 'cloze',
   'Halogens are so reactive that they essentially never occur in elemental form in nature — instead they exist as {{c1::halide ions (X⁻)}} in salts or as {{c2::diatomic molecules (X₂)}} in laboratory and industrial settings.', 2),

  -- ── 14. Noble Gases (Group 8A) ───────────────────────────
  (deck, 38, 'cloze',
   'The {{c1::noble gases}} (Group 8A) have completely filled valence shells, so they exhibit {{c2::very high ionization energies}}, {{c2::negligible electron affinities}}, and {{c2::no measurable electronegativity}} for the lighter members — they are chemically inert under ordinary conditions.', 2),

  (deck, 39, 'cloze',
   '{{c1::Helium}} is grouped with the noble gases because of its chemical behavior, but it has only {{c2::two}} valence electrons rather than eight — a complete 1s² shell is enough to make it stable, since the n=1 shell holds at most 2 electrons.', 2),

  (deck, 40, 'cloze',
   'Despite the "inert gas" label, the heavier noble gases — particularly {{c1::xenon and krypton}} — can form compounds with strongly electronegative atoms; classic examples include {{c2::XeF₂, XeF₄, and KrF₂}}.', 2),

  -- ── 15. Transition Metals (B Elements) ───────────────────
  (deck, 41, 'cloze',
   'The {{c1::transition metals}} occupy the {{c2::d-block}} of the periodic table; their valence electrons sit in the highest s and d subshells, and they share the classic metallic profile of low electronegativity, low ionization energy, and low electron affinity.', 2),

  (deck, 42, 'cloze',
   'Many transition metals adopt {{c1::multiple oxidation states}} because they can lose differing numbers of electrons from their valence {{c2::s and d}} orbitals — e.g., iron appears as Fe²⁺ or Fe³⁺, and manganese ranges from Mn²⁺ to Mn⁷⁺. This versatility is why they form a wide variety of ionic and complex compounds.', 2),

  (deck, 43, 'cloze',
   'Compared with the active metals, transition metals are notably {{c1::harder, denser, and have higher melting and boiling points}}, yet they remain malleable and excellent electrical conductors thanks to their delocalized d-electrons.', 1),

  (deck, 44, 'cloze',
   'Transition metals form characteristically {{c1::colored complexes}} because their partially filled d orbitals split into closely spaced energy levels (in the presence of ligands) and absorb specific wavelengths of visible light; the color we perceive is the {{c2::complementary color}} — the wavelengths transmitted or reflected rather than absorbed.', 2),

  -- ── 16. Lanthanide / Actinide Series ─────────────────────
  (deck, 45, 'cloze',
   'The {{c1::lanthanide and actinide series}} make up the two rows usually shown beneath the main periodic table; they constitute the {{c2::f-block}}, with valence electrons occupying the highest {{c3::s and f subshells}}. The actinides include all of the synthetic transuranium elements (Z > 92).', 3);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
