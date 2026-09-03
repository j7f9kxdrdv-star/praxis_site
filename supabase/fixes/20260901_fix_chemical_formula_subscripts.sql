-- ============================================================
-- Chemical formulas: use the subscript digits that exist
--
-- Spotted by Mikko while studying: "CH2OH" should read CH₂OH.
--
-- Unlike the letter subscripts, this class is entirely fixable in plain text.
-- Unicode has no subscript f, q or b, and no multi-character form at all, which
-- is why V_max and k_cat need a renderer change. It DOES have all ten subscript
-- digits, so every chemical formula in the bank can be written correctly today.
-- The bank was already 226 cards into this convention; these are the stragglers.
--
-- WHAT IS DELIBERATELY LEFT FLAT, AND WHY IT MATTERS. A scan for "letters
-- followed by a digit" returns 41 cards, and most are not formulas:
--
--   GLUT4, GLUT2   glucose transporter NAMES, written flat everywhere
--   CD4, CD8       cell surface marker names, flat
--   H2A, H2B       histone names, flat
--   SN2, SN1       here the N subscripts and the digit does NOT, so a
--                  digit rule makes these worse rather than better
--
-- The first version of the generator did subscript SN2, because "N2" matched
-- inside it. Formulas are now matched only as standalone tokens, and the
-- generator refuses to emit anything containing SN₂, GLUT₄, CD₈ or H₂A.
-- ============================================================

-- Amino Acids, Peptides, and Proteins
UPDATE public.flashcards SET cloze_text = 'At physiological pH (~7.4), an amino acid exists predominantly as a {{c1::zwitterion}}: the α-amino group is {{c2::protonated}} (-NH₃+) and the α-carboxyl group is {{c3::deprotonated}} (-COO-).' WHERE id = '114d4bfc-e110-404f-962e-b0a169ccaf03';

-- Amino Acids, Peptides, and Proteins
UPDATE public.flashcards SET cloze_text = 'At very low pH (e.g., pH 1), an amino acid carries a {{c1::positive}} net charge: the amino group is protonated (-NH₃+) and the carboxyl group is also protonated (-COOH).' WHERE id = '1e3b21e9-d8d0-426e-9799-491d52b4f3db';

-- Carbohydrate Structure and Function
UPDATE public.flashcards SET cloze_text = 'In the {{c1::β-anomer}} of a D-sugar, the hydroxyl on the anomeric carbon points {{c2::cis}} to the CH₂OH group (up in Haworth, equatorial in chair).' WHERE id = '2857fe4e-16aa-4470-8f8a-6acb33086a1b';

-- Amino Acids, Peptides, and Proteins
UPDATE public.flashcards SET cloze_text = 'At very high pH (e.g., pH 11), an amino acid carries a {{c1::negative}} net charge: the carboxyl group remains deprotonated and the amino group is now deprotonated to -NH₂.' WHERE id = '2ecfa995-89e2-49d1-9e51-b59b250b0562';

-- The Respiratory System
UPDATE public.flashcards SET cloze_text = 'Breathing runs by default under {{c1::autonomic (involuntary)}} control from the medullary respiratory center, but cortical areas grant {{c2::voluntary (somatic)}} override (letting you hold your breath or speak) until rising CO₂ forces the {{c1::autonomic (involuntary)}} system to seize control again.' WHERE id = '3a90b10c-e4e0-4f0c-8f36-a0d0009cac17';

-- Amino Acids, Peptides, and Proteins
UPDATE public.flashcards SET cloze_text = 'For an amino acid with a basic side chain (Lys, Arg, His), the pI is the average of the {{c1::two highest}} pKa values: pI = (pKa,R + pKa,NH₃+)/2; this gives a {{c2::high}} pI.' WHERE id = '48a8f3bc-488c-46bc-93aa-25dea703cd7f';

-- Amino Acids, Peptides, and Proteins
UPDATE public.flashcards SET cloze_text = 'For an amino acid with a non-ionizable side chain, the pI is the {{c1::average}} of the α-amino and α-carboxyl pKa values: pI = ({{c2::pKa,COOH + pKa,NH₃+}})/2.' WHERE id = '50d45996-f358-4f1d-8b28-5fa63b4250a3';

-- Bonding & Chemical Interactions
UPDATE public.flashcards SET cloze_text = '{{c1::6}} regions of electron density give an {{c2::octahedral}} geometry with {{c3::90° and 180°}} bond angles (e.g., SF₆).' WHERE id = '6b9324b8-d6bf-4644-8031-b03367fff076';

-- Bonding & Chemical Interactions
UPDATE public.flashcards SET cloze_text = 'Molecules with an {{c1::odd number}} of valence electrons (e.g., NO, NO₂) cannot give every atom a full octet; one atom always carries an unpaired electron.' WHERE id = '745311ac-80ba-4b7e-ade7-9a5c13627c34';

-- Bonding & Chemical Interactions
UPDATE public.flashcards SET cloze_text = 'A molecule with polar bonds may be polar or nonpolar overall: if molecular geometry is {{c1::symmetric}}, the bond dipoles cancel and the molecule is nonpolar (e.g., CO₂).' WHERE id = '979810fa-4aac-4f38-bd27-0f2f8223647f';

-- Amino Acids, Peptides, and Proteins
UPDATE public.flashcards SET cloze_text = 'An {{c1::amino acid}} contains an amino group (-NH₂), a carboxyl group (-COOH), a hydrogen atom, and a unique {{c2::side chain (R group)}}, all bonded to the central α-carbon.' WHERE id = 'dce54e5d-dc43-48d6-8348-da1704f935cb';

-- Bonding & Chemical Interactions
UPDATE public.flashcards SET cloze_text = '{{c1::2}} regions of electron density around the central atom give a {{c2::linear}} geometry with a {{c3::180°}} bond angle (e.g., CO₂, BeCl2).' WHERE id = 'e961b4f2-00bc-4ea1-bb55-5fd1fc1f4155';

-- Carbohydrate Structure and Function
UPDATE public.flashcards SET cloze_text = 'In the {{c1::α-anomer}} of a D-sugar, the hydroxyl on the anomeric carbon points {{c2::trans}} to the CH₂OH group (down in Haworth, axial in chair).' WHERE id = 'f81c34ae-02b8-4e17-b5cd-618dafe09ce8';

-- Carbohydrate Structure and Function
UPDATE public.flashcards SET cloze_text = '{{c1::Carbohydrates}} are biomolecules made of carbon, hydrogen, and oxygen in a {{c2::1:2:1}} ratio, effectively (CH₂O)n. They serve as energy sources, energy storage, and structural components.' WHERE id = 'f9f54316-503b-4d8c-bd39-7f97319565a2';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect zero: no flat formula left on the cards we touched.
SELECT COUNT(*) AS still_flat FROM public.flashcards
WHERE id IN ('114d4bfc-e110-404f-962e-b0a169ccaf03', '1e3b21e9-d8d0-426e-9799-491d52b4f3db', '2857fe4e-16aa-4470-8f8a-6acb33086a1b', '2ecfa995-89e2-49d1-9e51-b59b250b0562', '3a90b10c-e4e0-4f0c-8f36-a0d0009cac17', '48a8f3bc-488c-46bc-93aa-25dea703cd7f', '50d45996-f358-4f1d-8b28-5fa63b4250a3', '6b9324b8-d6bf-4644-8031-b03367fff076', '745311ac-80ba-4b7e-ade7-9a5c13627c34', '979810fa-4aac-4f38-bd27-0f2f8223647f', 'dce54e5d-dc43-48d6-8348-da1704f935cb', 'e961b4f2-00bc-4ea1-bb55-5fd1fc1f4155', 'f81c34ae-02b8-4e17-b5cd-618dafe09ce8', 'f9f54316-503b-4d8c-bd39-7f97319565a2')
  AND cloze_text ~ '(CH2OH|NH3|NH2|CO2|SF6|NO2|H2O|H2SO4|HNO3|CH4)';

-- Expect zero: no NAME wrongly subscripted, anywhere in the bank.
SELECT COUNT(*) AS names_broken FROM public.flashcards
WHERE cloze_text ~ '(SN₂|SN₁|GLUT₄|GLUT₂|CD₄|CD₈|H₂A|H₂B)';

-- Expect 14.
SELECT COUNT(*) AS cards_updated FROM public.flashcards
WHERE id IN ('114d4bfc-e110-404f-962e-b0a169ccaf03', '1e3b21e9-d8d0-426e-9799-491d52b4f3db', '2857fe4e-16aa-4470-8f8a-6acb33086a1b', '2ecfa995-89e2-49d1-9e51-b59b250b0562', '3a90b10c-e4e0-4f0c-8f36-a0d0009cac17', '48a8f3bc-488c-46bc-93aa-25dea703cd7f', '50d45996-f358-4f1d-8b28-5fa63b4250a3', '6b9324b8-d6bf-4644-8031-b03367fff076', '745311ac-80ba-4b7e-ade7-9a5c13627c34', '979810fa-4aac-4f38-bd27-0f2f8223647f', 'dce54e5d-dc43-48d6-8348-da1704f935cb', 'e961b4f2-00bc-4ea1-bb55-5fd1fc1f4155', 'f81c34ae-02b8-4e17-b5cd-618dafe09ce8', 'f9f54316-503b-4d8c-bd39-7f97319565a2');
