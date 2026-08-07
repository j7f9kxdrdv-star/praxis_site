-- Praxis Prep — Organic Chemistry Chapter 9: Carboxylic Acid Derivatives
-- v6-compliant flashcard deck (28 cards)
-- Subtopics: 9.1 Amides, Esters, and Anhydrides (10), 9.2 Reactivity Principles (8),
-- 9.3 Nucleophilic Acyl Substitution Reactions (10) — high-yield.
-- Source-laundered against LibreTexts Organic Chemistry (Carboxylic Acid Derivatives
-- chapters), OpenStax Chemistry: Atoms First 2e, and AAMC content outline (CP 4D
-- reactivity, BB 1B macromolecules for amide bonds in proteins, BB 2C lipid metabolism
-- for ester hydrolysis and saponification).
-- Per user direction, all crossover cards with OrgChem Ch 4 (Analyzing Organic Reactions)
-- and Ch 8 (Carboxylic Acids) retained for spaced-repetition reinforcement with derivative-
-- specific framing.
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Carboxylic Acid Derivatives',
            'Organic Chemistry Chapter 9: Carboxylic Acid Derivatives',
            'Orgo Chapter 9: Carboxylic Acid Derivatives'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Carboxylic Acid Derivatives',
        'Organic Chemistry Chapter 9: Carboxylic Acid Derivatives',
        'Orgo Chapter 9: Carboxylic Acid Derivatives'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'organic_chemistry',
        'Organic Chemistry',
        'carboxylic acid derivatives',
        'Carboxylic Acid Derivatives',
        'Condensation reactions joining two molecules with loss of water; amide, ester, and anhydride formation, naming, and structural details; lactams as cyclic amides with the Greek-letter ring-size convention (β-lactam = 4-membered, γ = 5, δ = 6); amide hydrogen-bonding nuances tied to N-H availability; ester formation via Fischer esterification, naming with the alcohol-derived alkyl prefix and -oate suffix, and lactones as cyclic esters; triglycerides as glycerol-plus-three-fatty-acid esters and the body''s storage form of fat; saponification of triglycerides by NaOH/KOH yielding glycerol plus fatty-acid carboxylate salts (soap); anhydride formation as condensation dimers of two carboxylic acids with symmetric vs asymmetric naming conventions; relative reactivity of derivatives (anhydride > ester > amide) and the electronic reasoning (three EWG oxygens and carboxylate leaving group for anhydrides; nitrogen lone-pair donation into the carbonyl giving partial C-N double-bond character for amides); steric hindrance, induction across sigma bonds, and conjugation as the three major reactivity-modulating principles; β-lactam ring strain (angle plus torsional) underlying penicillin antibiotic mechanism via covalent transpeptidase inhibition; nucleophilic acyl substitution as the unifying mechanism (carbonyl attack → tetrahedral intermediate → leaving group expulsion); anhydride cleavage by amines (yielding amide + carboxylic acid), alcohols (yielding ester + carboxylic acid), or water (yielding two carboxylic acids); transesterification (alcohol nucleophile swaps the alkoxy group of an ester); why amides resist hydrolysis without harsh conditions; acidic amide hydrolysis (carbonyl protonation, water attacks, products: carboxylic acid + ammonium) vs basic amide hydrolysis (hydroxide attacks, products: carboxylate + amine); and cyclic anhydride formation by heating dicarboxylic acids when 5- or 6-membered rings are accessible.',
        9
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 9.1 Amides, Esters, and Anhydrides (cards 1–10)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'A {{c1::condensation reaction}} joins two molecules with the loss of a {{c2::small molecule}}, typically {{c3::water}}; all three carboxylic acid derivatives form this way.',
        3),
    (deck, 1, 'cloze',
        '{{c1::Amides}} (RCONR₂) form by nucleophilic acyl substitution of a carboxylic acid with {{c2::ammonia or an amine}}; the nitrogen loses an H during the reaction.',
        2),
    (deck, 2, 'cloze',
        'Amides use the suffix {{c1::-amide}} (replacing -oic acid); alkyl groups on the nitrogen appear as prefixes with the italic letter {{c2::N-}} marking nitrogen substitution.',
        2),
    (deck, 3, 'cloze',
        'Cyclic amides are called {{c1::lactams}}; the Greek letter names the {{c2::ring size}} — {{c3::β-lactam (4-membered), γ-lactam (5-membered), δ-lactam (6-membered)}}.',
        3),
    (deck, 4, 'cloze',
        'Amide H-bonding depends on N–H availability — {{c1::primary and secondary amides}} can H-bond (N–H donors), while {{c2::tertiary amides}} cannot, which affects whether their boiling points approach the parent carboxylic acid.',
        2),
    (deck, 5, 'cloze',
        '{{c1::Esters}} form by reacting a carboxylic acid with an {{c2::alcohol}} under acidic conditions — the {{c3::Fischer esterification}}, a condensation with loss of water.',
        3),
    (deck, 6, 'cloze',
        'Esters use the suffix {{c1::-oate}} replacing -oic acid; the {{c2::alkyl group from the alcohol}} is listed first. Cyclic esters are called {{c3::lactones}}.',
        3),
    (deck, 7, 'cloze',
        '{{c1::Triglycerides (triacylglycerols)}} are the body''s storage form of fat — esters formed from {{c2::glycerol}} bonded to {{c3::three fatty acid chains}}.',
        3),
    (deck, 8, 'cloze',
        '{{c1::Saponification}} is the base-catalyzed hydrolysis of {{c2::triglycerides}} by NaOH or KOH, producing {{c3::glycerol plus fatty-acid carboxylate salts (soap)}}.',
        3),
    (deck, 9, 'cloze',
        'Two carboxylic acids condense with loss of {{c1::water}} to form an {{c2::anhydride}}; if the two halves differ, the parent names are listed {{c3::alphabetically}}.',
        3);

    -- ============================================================
    -- 9.2 Reactivity Principles (cards 11–18)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 10, 'cloze',
        'Relative reactivity of carboxylic acid derivatives toward nucleophiles: {{c1::anhydrides > esters > amides}}.',
        1),
    (deck, 11, 'cloze',
        'Anhydrides are the most reactive derivatives because they have {{c1::three electron-withdrawing oxygens}} stabilizing the developing negative charge in the tetrahedral intermediate, plus the leaving group is a {{c2::carboxylate}}.',
        2),
    (deck, 12, 'cloze',
        'Amides are the least reactive derivatives because the {{c1::nitrogen lone pair}} donates into the carbonyl, making the {{c2::carbonyl carbon less electrophilic}} and giving partial {{c3::C–N double-bond character}}.',
        3),
    (deck, 13, 'cloze',
        '{{c1::Steric hindrance}} blocks reactions by crowding the reactive site; bulky substituents on the carbonyl carbon or the nucleophile {{c2::raise the activation energy}} for nucleophilic attack.',
        2),
    (deck, 14, 'cloze',
        '{{c1::Induction}} is the uneven distribution of charge across {{c2::sigma bonds}} due to electronegativity differences; more electronegative neighboring atoms pull electron density away, {{c3::increasing the electrophilicity}} of a carbonyl carbon.',
        3),
    (deck, 15, 'cloze',
        '{{c1::Conjugation}} (alternating single and multiple bonds with delocalized π electrons) provides resonance stabilization of {{c2::transition states and intermediates}}, often {{c3::increasing reactivity}} toward nucleophiles.',
        3),
    (deck, 16, 'cloze',
        '{{c1::β-lactams}} are highly reactive because their {{c2::4-membered ring}} suffers both {{c3::angle strain}} (compressed from the ideal 109.5° sp³ angle) and torsional strain from eclipsing interactions.',
        3),
    (deck, 17, 'cloze',
        'β-lactam reactivity is the basis for penicillin antibiotics — the strained ring is easily opened by {{c1::bacterial transpeptidase}}, which then becomes {{c2::covalently inhibited}}, blocking cell wall synthesis.',
        2);

    -- ============================================================
    -- 9.3 Nucleophilic Acyl Substitution Reactions (cards 19–28) ★ high-yield
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
        'All carboxylic acid derivatives undergo {{c1::nucleophilic acyl substitution}}: a nucleophile attacks the carbonyl carbon, forms a {{c2::tetrahedral intermediate}}, then the carbonyl reforms by {{c3::expelling the leaving group}}.',
        3),
    (deck, 19, 'cloze',
        'Anhydrides undergo NAS by being {{c1::cleaved}} into two halves — the nucleophile attacks one carbonyl, and the other half departs as a {{c2::carboxylate leaving group}}.',
        2),
    (deck, 20, 'cloze',
        'Anhydride + {{c1::ammonia or an amine}} → {{c2::amide + carboxylic acid}}.',
        2),
    (deck, 21, 'cloze',
        'Anhydride + {{c1::alcohol}} → {{c2::ester + carboxylic acid}}.',
        2),
    (deck, 22, 'cloze',
        'Anhydride + {{c1::water}} → {{c2::two carboxylic acids}} (hydrolysis).',
        2),
    (deck, 23, 'cloze',
        '{{c1::Transesterification}} exchanges the alkoxy (–OR) group of one ester for another, driven by attack of a {{c2::new alcohol nucleophile}} on the ester carbonyl — proceeds under either acidic or basic conditions.',
        2),
    (deck, 24, 'cloze',
        'Amides resist nucleophilic attack because the {{c1::nitrogen lone pair}} stabilizes the carbonyl by resonance, so hydrolysis requires {{c2::strongly acidic or strongly basic conditions plus heat}}.',
        2),
    (deck, 25, 'cloze',
        'Under strongly acidic conditions, amide hydrolysis proceeds by {{c1::protonation of the carbonyl oxygen}} (boosting electrophilicity), then attack by {{c2::water}}; the products are a carboxylic acid + an {{c3::ammonium ion}}.',
        3),
    (deck, 26, 'cloze',
        'Under strongly basic conditions, amide hydrolysis proceeds by direct attack of {{c1::hydroxide ion}} on the carbonyl; the products are a {{c2::carboxylate anion + ammonia (or amine)}}.',
        2),
    (deck, 27, 'cloze',
        'Heating a {{c1::dicarboxylic acid}} can form a cyclic anhydride — driven forward by ring stability, so only {{c2::5- or 6-membered}} cyclic anhydrides form easily.',
        2);

    RAISE NOTICE 'Seeded deck % with 28 cards.', deck;
END $$;
