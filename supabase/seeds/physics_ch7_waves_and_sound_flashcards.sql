-- ════════════════════════════════════════════════════════════════════
-- Physics Chapter 7 — Waves and Sound
-- ════════════════════════════════════════════════════════════════════
-- Section: physics
-- Topic:   Physics
-- Subtopic slug: waves_and_sound
-- Sort order: 7
--
-- Coverage (AAMC-aligned order):
--    1. Wave Types & Anatomy
--    2. Frequency, Period & Wave Speed
--    3. Interference & Superposition
--    4. Standing Waves & Resonance
--    5. Sound: Production, Propagation & Perception
--    6. Sound Intensity & Decibels
--    7. The Doppler Effect & Shock Waves
--    8. Standing Waves in Strings & Pipes
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose, cross-verified against OpenStax College
-- Physics 2e. Scope: AAMC Periodic Motion wave characteristics (PHY) + Sound (PHY) —
-- wave types/anatomy, frequency/period/wave speed, interference, standing waves &
-- resonance, sound production/propagation/perception, intensity & decibels, the Doppler
-- effect & shock waves, and standing waves in strings & pipes (+ beats, ultrasound).
-- Out of scope: SIMPLE HARMONIC MOTION (Hooke's law, springs, pendulums → Physics Ch 2);
-- LIGHT / EM-WAVE OPTICS (double-slit, diffraction, thin films, polarization, lenses →
-- Physics Ch 8); and EAR / auditory-transduction physiology (→ Psych/Soc Sensory).
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'physics'
      AND title IN (
          'Waves and Sound',
          'Waves & Sound',
          'Physics Review Chapter Seven: Waves and Sound'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'physics',
        'Physics',
        'waves_and_sound',
        'Waves and Sound',
        'Transverse and longitudinal waves and their anatomy; frequency, period, angular frequency, and wave speed v = fλ; interference and superposition; standing waves, nodes and antinodes, resonance, and damping; the production, propagation, and perception of sound; sound intensity and the decibel scale; the Doppler effect and shock waves; and standing waves in strings and pipes with beats and ultrasound.',
        7
    )
    RETURNING id INTO deck;

    -- ── Wave Types & Anatomy ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'In a transverse wave, the particles oscillate {{c1::perpendicular}} to the direction of wave propagation.',
     1),
    (deck, 1, 'cloze',
     'In a longitudinal wave, particles oscillate {{c1::parallel}} to the wave''s direction of travel.',
     1),
    (deck, 2, 'cloze',
     'Electromagnetic (light) waves and a stadium “wave” are {{c1::transverse}} waves, whereas sound is a {{c1::longitudinal}} wave.',
     1),
    (deck, 3, 'cloze',
     'Displacement x, how far a wave point lies from its equilibrium position, is a {{c1::vector}} quantity.',
     1),
    (deck, 4, 'cloze',
     'A wave''s amplitude (A) is the {{c1::magnitude of the maximum displacement}} from equilibrium.',
     1),
    (deck, 5, 'cloze',
     'On a wave, a {{c1::crest}} is the point of most positive displacement and a {{c1::trough}} the point of most negative displacement.',
     1),
    (deck, 6, 'cloze',
     'A wave''s crest-to-crest (or trough-to-trough) distance is its {{c1::wavelength}}, symbol {{c1::λ}}.',
     1);

    -- ── Frequency, Period & Wave Speed ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
     'A wave''s {{c1::frequency}} ({{c1::f}}) is the number of complete cycles passing a fixed point each second.',
     1),
    (deck, 8, 'cloze',
     'Frequency is measured in {{c1::hertz (Hz)}}, the SI unit defined as one cycle per second.',
     1),
    (deck, 9, 'cloze',
     'Angular frequency ω = {{c1::2πf}} (f = frequency), measured in {{c2::radians per second (rad/s)}}.',
     2),
    (deck, 10, 'cloze',
     'The {{c1::period}} ({{c1::T}}) of a wave is the time in seconds needed to complete one full cycle.',
     1),
    (deck, 11, 'cloze',
     'For any wave, period T = {{c1::1/f}} and frequency f = {{c1::1/T}}.',
     1),
    (deck, 12, 'cloze',
     'A wave moves through its medium at speed v = {{c1::fλ}}, where f is frequency and λ is wavelength.',
     1);

    -- ── Interference & Superposition ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 13, 'cloze',
     'By the principle of {{c1::superposition}}, overlapping waves add their displacements to form a single {{c2::resultant}} wave — the basis of interference.',
     2),
    (deck, 14, 'cloze',
     'Constructive interference occurs when two waves are exactly {{c1::in phase}}, so the resultant amplitude equals the {{c1::sum}} of the two amplitudes.',
     1),
    (deck, 15, 'cloze',
     'Destructive interference occurs when two waves are exactly {{c1::out of phase (180°)}}, so the resultant amplitude equals the {{c2::difference}} of the two amplitudes.',
     2),
    (deck, 16, 'cloze',
     'For two identical waves, pure constructive interference produces {{c1::double}} the amplitude, while pure destructive interference produces {{c2::zero}} amplitude.',
     2),
    (deck, 17, 'cloze',
     'Interference between waves that are not perfectly in phase, nor perfectly out of phase, is {{c1::partially constructive and partially destructive}}.',
     1);

    -- ── Standing Waves & Resonance ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     'A {{c1::traveling}} wave moves through the medium and transfers energy, whereas a {{c1::standing}} wave stays in place and only vibrates up and down.',
     1),
    (deck, 19, 'cloze',
     'A standing wave forms when two waves of {{c1::the same frequency}} travel in {{c2::opposite directions}} through the same space and overlap.',
     2),
    (deck, 20, 'cloze',
     'In a standing wave, {{c1::nodes}} are points of zero oscillation while {{c1::antinodes}} are points of maximum oscillation.',
     1),
    (deck, 21, 'cloze',
     '{{c1::Resonance}} is the large amplitude increase that occurs when a periodic driving force is applied at a system''s {{c1::natural}} frequency.',
     1),
    (deck, 22, 'cloze',
     'A system''s {{c1::natural}} frequency is how fast it would oscillate with {{c2::no driving or damping force}}.',
     2),
    (deck, 23, 'cloze',
     '{{c1::Damping}} is the gradual decrease in a system''s amplitude, caused by a {{c2::nonconservative (frictional)}} force.',
     2);

    -- ── Sound: Production, Propagation & Perception ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 24, 'cloze',
     'A vibrating source generates sound by driving a {{c1::mechanical}} disturbance that forms regions of {{c2::compression}} and {{c2::rarefaction}} in the medium''s molecules.',
     2),
    (deck, 25, 'cloze',
     'In a sound wave, a {{c1::compression}} is a region of high pressure while a {{c1::rarefaction}} is a region of low pressure.',
     1),
    (deck, 26, 'cloze',
     'Sound is a {{c1::mechanical}} wave, so it travels through solids, liquids, and gases but never through a {{c1::vacuum}}.',
     1),
    (deck, 27, 'cloze',
     'The speed of sound is fastest in {{c1::solids}}, slower in {{c1::liquids}}, and slowest in {{c1::gases}}.',
     1),
    (deck, 28, 'cloze',
     'Sound moves {{c1::faster}} through a medium that is more rigid and less compressible.',
     1),
    (deck, 29, 'cloze',
     'For media of similar rigidity, sound travels more slowly through the one with the {{c1::higher}} density.',
     1),
    (deck, 30, 'cloze',
     'The perceived {{c1::pitch}} of a sound is set by its frequency.',
     1),
    (deck, 31, 'cloze',
     'A sound''s {{c1::loudness}} tracks its intensity, which in turn tracks the wave''s {{c2::amplitude}}.',
     2);

    -- ── Sound Intensity & Decibels ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
     'A wave''s intensity is I = {{c1::P/A}} (P = power, A = area), in SI units of {{c1::W/m²}}.',
     1),
    (deck, 33, 'cloze',
     'Sound level in decibels is β = {{c1::10 log(I/I₀)}} (I = intensity, I₀ = reference intensity), so it is a {{c1::logarithmic}} scale.',
     1),
    (deck, 34, 'cloze',
     'The reference intensity in the decibel formula is I₀ = {{c1::1×10⁻¹² W/m²}}, the threshold of hearing, which sits at {{c2::0}} dB.',
     2),
    (deck, 35, 'cloze',
     'On the logarithmic decibel scale, multiplying a sound''s intensity by {{c1::10}} raises its level by {{c1::10}} dB.',
     1),
    (deck, 36, 'cloze',
     'Sound intensity falls as it travels because the wave {{c1::spreads over a larger area}}, and because {{c2::attenuation (damping)}} dissipates energy through friction in the medium.',
     2);

    -- ── The Doppler Effect & Shock Waves ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 37, 'cloze',
     'The {{c1::Doppler effect}} is the change in the frequency a detector perceives, relative to the frequency the source emits, when the two move relative to one another.',
     1),
    (deck, 38, 'cloze',
     'When a source and detector approach each other, the perceived frequency is {{c1::higher}}; when they recede, it is {{c1::lower}}.',
     1),
    (deck, 39, 'cloze',
     'The Doppler shift depends on {{c1::relative velocity}}, so source and detector moving the same direction can perceive a shift that is higher, lower, or zero.',
     1),
    (deck, 40, 'cloze',
     'In the Doppler equation f′ = {{c1::f(v ± vₒ)/(v ∓ vₛ)}}, v is the speed of sound, vₒ the observer''s speed, and vₛ the source''s speed.',
     1),
    (deck, 41, 'cloze',
     'In f′ = f(v ± vₒ)/(v ∓ vₛ), an approaching observer takes the {{c1::+ sign (numerator)}} and an approaching source the {{c1::− sign (denominator)}}.',
     1),
    (deck, 42, 'cloze',
     'A source moving {{c1::at or above the speed of sound}} piles up its sound waves by constructive interference into a {{c1::shock wave (sonic boom)}}.',
     1);

    -- ── Standing Waves in Strings & Pipes ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 43, 'cloze',
     'For a string fixed at both ends or a pipe open at both ends, standing-wave wavelengths follow {{c1::λ = 2L/n}}, where L = length and n = {{c2::1, 2, 3, …}}.',
     2),
    (deck, 44, 'cloze',
     'For a string fixed at both ends or an open pipe, the harmonic frequencies are {{c1::f = nv/(2L)}}, where v is the wave speed and L is the length.',
     1),
    (deck, 45, 'cloze',
     'A pipe closed at one end supports standing waves with {{c1::λ = 4L/n}}, but n takes only {{c2::odd values: 1, 3, 5, …}}.',
     2),
    (deck, 46, 'cloze',
     'An object''s fundamental frequency — its lowest resonant frequency — occurs in standing-wave mode {{c1::n = 1}}.',
     1),
    (deck, 47, 'cloze',
     'The beat frequency heard when two waves of slightly different frequency f₁ and f₂ interfere is {{c1::fbeat = |f₁ − f₂|}}.',
     1),
    (deck, 48, 'cloze',
     '{{c1::Ultrasound}} is sound whose frequency lies above the upper limit of human hearing, roughly above {{c2::20,000 Hz (20 kHz)}}.',
     2),
    (deck, 49, 'cloze',
     'In medicine, ultrasound is used for both {{c1::diagnostic imaging}} and {{c1::therapeutic treatment}}.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 50;
END $$;
