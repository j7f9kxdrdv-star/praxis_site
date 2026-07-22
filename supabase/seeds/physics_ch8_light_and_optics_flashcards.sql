-- ════════════════════════════════════════════════════════════════════
-- Physics Chapter 8 — Light and Optics
-- ════════════════════════════════════════════════════════════════════
-- Section: physics
-- Topic:   Physics
-- Subtopic slug: light_and_optics
-- Sort order: 8
--
-- Coverage (AAMC-aligned order):
--    1. The EM Wave & Spectrum
--    2. Reflection & Mirrors
--    3. Refraction, Snell's Law & Total Internal Reflection
--    4. Lenses & the Thin-Lens Equation
--    5. Image Formation (Converging vs Diverging)
--    6. Sign Conventions
--    7. Diffraction & Interference
--    8. Polarization
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose, cross-verified against OpenStax College
-- Physics 2e. Scope: AAMC Geometrical Optics (PHY) + Light/EM Radiation (PHY) — the EM
-- wave & spectrum, reflection & mirrors, refraction/Snell/TIR, lenses & the thin-lens
-- equation, image formation, sign conventions, diffraction & interference, and
-- polarization. Out of scope: the QUANTUM/PHOTON side of light — E = hf, the photo-
-- electric effect, atomic spectra, blackbody (Physics Ch 9 Atomic & Nuclear); general
-- mechanical-wave definitions (Physics Ch 7 Waves and Sound); and eye anatomy / colour-
-- vision physiology (Sensory/Biology).
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'physics'
      AND title IN (
          'Light and Optics',
          'Light & Optics',
          'Physics Review Chapter Eight: Light and Optics'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'physics',
        'Physics',
        'light_and_optics',
        'Light and Optics',
        'The electromagnetic wave and spectrum with c = fλ; reflection and spherical mirrors; refraction, the refractive index, Snell''s law, dispersion, and total internal reflection; converging and diverging lenses with the thin-lens equation, magnification, and diopters; image formation in converging and diverging systems; the optics sign conventions; diffraction and interference with Young''s double-slit; and linear and circular polarization.',
        8
    )
    RETURNING id INTO deck;

    -- ── The EM Wave & Spectrum ────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'Light is a {{c1::transverse}} wave built from two oscillating fields: an {{c2::electric}} field and a {{c2::magnetic}} field.',
     2),
    (deck, 1, 'cloze',
     'In a light wave, the electric and magnetic fields are oriented {{c1::perpendicular}} to each other and to the {{c2::direction of propagation}}.',
     2),
    (deck, 2, 'cloze',
     'In a vacuum, all electromagnetic waves travel at the same speed — the speed of light, c = {{c1::3×10⁸ m/s}}.',
     1),
    (deck, 3, 'cloze',
     'In a vacuum, every electromagnetic wave satisfies c = {{c1::fλ}} (f = frequency, λ = wavelength).',
     1),
    (deck, 4, 'cloze',
     'Ordered from lowest to highest energy, the electromagnetic spectrum is {{c1::radio, microwave, infrared, visible, ultraviolet, X-ray, gamma}}.',
     1),
    (deck, 5, 'cloze',
     'Across the electromagnetic spectrum, energy increases with {{c1::frequency}} and decreases with {{c1::wavelength}}.',
     1),
    (deck, 6, 'cloze',
     'The visible spectrum spans roughly {{c1::400}} nm (violet) to {{c2::700}} nm (red).',
     2),
    (deck, 7, 'cloze',
     'Within visible light, {{c1::violet}} has the highest energy and shortest wavelength, while {{c1::red}} has the lowest energy and longest wavelength.',
     1),
    (deck, 8, 'cloze',
     'An object appears a particular color because it {{c1::reflects}} that wavelength of visible light and {{c1::absorbs}} the others.',
     1);

    -- ── Reflection & Mirrors ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
     '{{c1::Reflection}} occurs when light bounces off a surface instead of passing into the medium.',
     1),
    (deck, 10, 'cloze',
     'Under the law of reflection, the angle of incidence and the angle of reflection are {{c1::equal}}, each measured from the {{c2::normal}} to the surface.',
     2),
    (deck, 11, 'cloze',
     'For a spherical mirror, the focal length f = {{c1::R/2}}, where R is the radius of curvature.',
     1),
    (deck, 12, 'cloze',
     'A concave mirror is a {{c1::converging}} system, while a convex mirror is a {{c1::diverging}} system.',
     1),
    (deck, 13, 'cloze',
     'A plane (flat) mirror forms a {{c1::virtual}}, {{c1::upright}} image that is the {{c2::same size}} as the object.',
     2),
    (deck, 14, 'cloze',
     'A concave (converging) mirror forms a {{c1::real, inverted}} image, or a {{c1::virtual, upright}} image when the object is inside the {{c2::focal point}}.',
     2),
    (deck, 15, 'cloze',
     'A spherical mirror''s {{c1::center of curvature}} lies at distance R and its {{c1::focal point}} at distance R/2.',
     1);

    -- ── Refraction, Snell's Law & Total Internal Reflection ───────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 16, 'cloze',
     '{{c1::Refraction}} is the change in direction of a light ray as it passes from one transparent medium into another.',
     1),
    (deck, 17, 'cloze',
     'A material''s index of refraction is {{c1::n = c/v}}, where c is the speed of light in vacuum and v is its speed in that material.',
     1),
    (deck, 18, 'cloze',
     'The larger a medium''s index of refraction, the {{c1::slower}} light travels through it.',
     1),
    (deck, 19, 'cloze',
     'Light bends {{c1::toward}} the normal when entering a higher-index medium and {{c1::away from}} the normal when entering a lower-index medium.',
     1),
    (deck, 20, 'cloze',
     'Snell''s law is {{c1::n₁ sin θ₁ = n₂ sin θ₂}}, where n is refractive index and θ is the angle measured from the normal.',
     1),
    (deck, 21, 'cloze',
     '{{c1::Dispersion}} separates white light into its component colors because a medium''s index of refraction varies with {{c2::wavelength}}.',
     2),
    (deck, 22, 'cloze',
     'Sent through a prism, {{c1::violet}} light refracts (bends) more than {{c1::red}} light.',
     1),
    (deck, 23, 'cloze',
     'Total internal reflection occurs only when light travels from a {{c1::higher}}-index medium toward a {{c1::lower}}-index medium and strikes the boundary beyond the {{c2::critical angle}}.',
     2),
    (deck, 24, 'cloze',
     'For light going from a higher-index medium (n₁) toward a lower-index one (n₂), the critical angle obeys {{c1::sin θ_c = n₂/n₁}}.',
     1);

    -- ── Lenses & the Thin-Lens Equation ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 25, 'cloze',
     'A convex lens is a {{c1::converging}} system, whereas a concave lens is a {{c1::diverging}} system.',
     1),
    (deck, 26, 'cloze',
     'A concave (diverging) lens forms only {{c1::virtual, upright, reduced}} images at every object distance.',
     1),
    (deck, 27, 'cloze',
     'A convex (converging) lens forms a {{c1::real, inverted}} image, or a {{c1::virtual, upright}} image when the object lies inside the focal point.',
     1),
    (deck, 28, 'cloze',
     'The thin-lens (and mirror) equation links focal length f, object distance o, and image distance i: {{c1::1/f = 1/o + 1/i}}.',
     1),
    (deck, 29, 'cloze',
     'Magnification from image distance i and object distance o is m = {{c1::−i/o}}.',
     1),
    (deck, 30, 'cloze',
     'A lens''s power P = {{c1::1/f}} (f in meters) is measured in units called {{c2::diopters (D)}}.',
     2),
    (deck, 31, 'cloze',
     'For thin lenses placed close together, their powers (in diopters) combine as P_total = {{c1::P₁ + P₂ + …}}.',
     1),
    (deck, 32, 'cloze',
     'For lenses in combination, total magnification is found by {{c1::multiplying}} the individual magnifications: m_total = {{c1::m₁ × m₂ × …}}.',
     1),
    (deck, 33, 'cloze',
     'A lens too thick to be treated as "thin" requires the {{c1::lensmaker''s equation}} to find its focal length.',
     1),
    (deck, 34, 'cloze',
     '{{c1::Aberration}} is the distortion of an image caused by an imperfect lens or mirror shape.',
     1);

    -- ── Image Formation (Converging vs Diverging) ─────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
     'In a converging system (convex lens or concave mirror), an object placed beyond twice the focal length (o > 2f) forms a {{c1::real, inverted}}, {{c2::reduced}} image.',
     2),
    (deck, 36, 'cloze',
     'In a converging system, an object at exactly twice the focal length (o = 2f) forms a {{c1::real, inverted}} image that is the {{c2::same size}} as the object.',
     2),
    (deck, 37, 'cloze',
     'In a converging system, an object between the focal point and 2f (f < o < 2f) forms a {{c1::real, inverted}}, {{c2::enlarged}} image.',
     2),
    (deck, 38, 'cloze',
     'In a converging system, an object placed exactly at the focal point (o = f) produces {{c1::no image}}, because the emerging rays are {{c1::parallel}}.',
     1),
    (deck, 39, 'cloze',
     'In a converging system, an object inside the focal point (o < f) forms a {{c1::virtual, upright}}, {{c2::enlarged}} image — the {{c2::magnifying-glass}} case.',
     2),
    (deck, 40, 'cloze',
     'A diverging system (concave lens or convex mirror) forms a {{c1::virtual, upright, reduced}} image at {{c2::every}} object distance.',
     2),
    (deck, 41, 'cloze',
     'A {{c1::real}} image, formed where light rays actually cross, can be projected on a screen; a {{c1::virtual}} image cannot (its rays only appear to cross).',
     1),
    (deck, 42, 'cloze',
     'Relative to the object, a real image forms on the {{c1::opposite}} side of a lens but the {{c1::same}} side of a mirror.',
     1);

    -- ── Sign Conventions ──────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     'A real image has a {{c1::positive}} image distance i, whereas a virtual image has a {{c1::negative}} image distance i.',
     1),
    (deck, 44, 'cloze',
     'Because m = −i/o, the magnification is {{c1::negative}} for a real, inverted image and {{c1::positive}} for a virtual, upright image.',
     1),
    (deck, 45, 'cloze',
     'Focal length f and lens power P are {{c1::positive}} for a converging element and {{c1::negative}} for a diverging element.',
     1),
    (deck, 46, 'cloze',
     'A {{c1::convex}} lens and a {{c1::concave}} mirror both converge light, so each has a positive focal length f.',
     1),
    (deck, 47, 'cloze',
     'The magnitude of the magnification sets image size: |m| > 1 means the image is {{c1::enlarged}}, while |m| < 1 means it is {{c1::reduced}}.',
     1),
    (deck, 48, 'cloze',
     'By sign convention, the object distance o is {{c1::positive}} for a real object placed in front of the lens or mirror.',
     1);

    -- ── Diffraction & Interference ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 49, 'cloze',
     '{{c1::Diffraction}} is the bending and spreading of light as it passes through a narrow slit or around the edge of an obstacle.',
     1),
    (deck, 50, 'cloze',
     'Where light waves overlap, {{c1::constructive}} interference gives bright fringes while {{c1::destructive}} interference gives dark fringes.',
     1),
    (deck, 51, 'cloze',
     'That light produces interference and diffraction patterns is evidence that light behaves as a {{c1::wave}}.',
     1),
    (deck, 52, 'cloze',
     'Young''s double-slit experiment sends light through two closely spaced slits, acting as two {{c1::coherent}} sources, producing alternating {{c2::bright and dark}} fringes.',
     2),
    (deck, 53, 'cloze',
     'A single slit''s diffraction pattern has a central maximum much {{c1::wider and brighter}} than the fringes flanking it.',
     1),
    (deck, 54, 'cloze',
     'A diffraction grating has {{c1::many}} evenly spaced parallel slits and produces {{c2::narrower, sharper}} bright fringes than a double slit does.',
     2),
    (deck, 55, 'cloze',
     'For a double slit, bright fringes (maxima) occur when {{c1::d sin θ = mλ}}, where d = slit spacing, m = order, and λ = wavelength.',
     1),
    (deck, 56, 'cloze',
     'For a single slit, dark fringes (minima) occur when {{c1::a sin θ = nλ}}, where a = slit width, n = order of the minimum, and λ = wavelength.',
     1);

    -- ── Polarization ──────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 57, 'cloze',
     'In plane-polarized (linearly polarized) light, all the waves'' electric-field vectors are oriented {{c1::parallel to one another}}.',
     1),
    (deck, 58, 'cloze',
     'For an electromagnetic wave, its polarization direction lies along the orientation of the {{c1::electric}} field.',
     1),
    (deck, 59, 'cloze',
     'Passing {{c1::unpolarized}} light through a {{c1::polarizer}} aligns all the electric-field vectors into a single plane.',
     1),
    (deck, 60, 'cloze',
     'In circularly polarized light, the electric-field vector rotates steadily while its magnitude stays {{c1::constant}}.',
     1),
    (deck, 61, 'cloze',
     'Sending light through a polarizing filter lowers its {{c1::intensity}} but leaves its {{c1::wavelength}} unchanged.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 62;
END $$;
