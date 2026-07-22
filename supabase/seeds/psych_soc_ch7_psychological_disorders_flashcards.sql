-- ════════════════════════════════════════════════════════════════════
-- Psych/Soc Chapter 7 — Psychological Disorders
-- ════════════════════════════════════════════════════════════════════
-- Section: psych_soc
-- Topic:   Psych/Soc
-- Subtopic slug: psychological_disorders
-- Sort order: 7
--
-- Coverage (AAMC-aligned order):
--    1. Understanding Psychological Disorders
--    2. Schizophrenia
--    3. Depressive & Bipolar Disorders
--    4. Anxiety Disorders
--    5. OCD-Related & Trauma Disorders
--    6. Dissociative & Somatic Disorders
--    7. Personality Disorders
--    8. Biological Bases of Disorders
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Psychology 2e. Scope: AAMC Psychological Disorders (7A) — biomedical vs biopsychosocial,
-- the DSM, and the disorder types (schizophrenia, depressive, bipolar, anxiety, OCD-related,
-- trauma/PTSD, dissociative, somatic, personality) + the biological bases of nervous-system
-- disorders. Out of scope: general neurotransmitter FUNCTION & brain anatomy incl. the
-- Parkinson's dopamine mechanism (Ch 1); the stress response/GAS (Ch 5); personality theory
-- & traits (Ch 6). See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'psych_soc'
      AND title IN (
          'Psychological Disorders',
          'Psychological Disorders and Their Biological Bases'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'psych_soc',
        'Psych/Soc',
        'psychological_disorders',
        'Psychological Disorders',
        'The biomedical and biopsychosocial approaches and the DSM; schizophrenia and its positive and negative symptoms; the depressive and bipolar disorders; the anxiety disorders; obsessive-compulsive-related and trauma disorders including PTSD; the dissociative and somatic symptom disorders; the personality disorders across clusters A, B, and C; and the biological bases of schizophrenia, depression, Alzheimer''s, and Parkinson''s disease.',
        7
    )
    RETURNING id INTO deck;

    -- ── Understanding Psychological Disorders ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'The {{c1::biomedical}} approach explains a psychological disorder through physical causes alone and addresses it with physical treatments such as drug therapy.',
     1),
    (deck, 1, 'cloze',
     'The {{c1::biopsychosocial}} approach treats a disorder as the joint product of bodily, mental, and interpersonal factors, addressing all three in treatment.',
     1),
    (deck, 2, 'cloze',
     'The current standard manual for classifying mental disorders in the United States is the {{c1::DSM-5}}, published in {{c2::2013}}.',
     2),
    (deck, 3, 'cloze',
     'The DSM-5 classifies mental disorders by their {{c1::symptom patterns}}, not by their underlying causes.',
     1),
    (deck, 4, 'cloze',
     'Among the most common psychological disorders in the population are {{c1::anxiety, depressive, and substance-use}} disorders.',
     1),
    (deck, 5, 'cloze',
     'The most common class of mental illness in the U.S. is {{c1::anxiety}} disorders, affecting roughly a quarter to a third of adults over a lifetime.',
     1);

    -- ── Schizophrenia ─────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 6, 'cloze',
     '{{c1::Schizophrenia}} is the prototypical psychotic disorder, marked by a loss of contact with reality.',
     1),
    (deck, 7, 'cloze',
     'The {{c1::positive}} symptoms of schizophrenia are pathological {{c1::excesses}}: hallucinations, delusions, and disorganized speech or behavior.',
     1),
    (deck, 8, 'cloze',
     'The {{c1::negative}} symptoms of schizophrenia are pathological {{c1::deficits}}: a flat or blunted affect, avolition, and anhedonia.',
     1),
    (deck, 9, 'cloze',
     'A {{c1::delusion}} is a false, fixed belief held despite contrary evidence, whereas a {{c1::hallucination}} is a false sensory perception with no external stimulus.',
     1),
    (deck, 10, 'cloze',
     '{{c1::Avolition}}, a negative symptom of schizophrenia, is a lack of motivation to begin or sustain goal-directed activity.',
     1);

    -- ── Depressive & Bipolar Disorders ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 11, 'cloze',
     'A {{c1::major depressive episode}} is a period of at least {{c2::two weeks}} of persistent low mood or loss of interest and pleasure that impairs daily functioning.',
     2),
    (deck, 12, 'cloze',
     'A mood disorder of one or more discrete low-mood episodes that lift in between, with no lifetime episode of mania, is {{c1::major depressive disorder}}.',
     1),
    (deck, 13, 'cloze',
     'The loss of the ability to feel pleasure or interest in activities once enjoyed, one of the two core features of a major depressive episode, is {{c1::anhedonia}}.',
     1),
    (deck, 14, 'cloze',
     'A sad, low mood present most of the day, more days than not, for at least {{c2::two years}} defines {{c1::persistent depressive disorder}} (formerly called {{c1::dysthymia}}).',
     2),
    (deck, 15, 'cloze',
     'Depression whose episodes reliably recur at the same time of year, most often in winter, is called {{c1::seasonal affective disorder}}.',
     1),
    (deck, 16, 'cloze',
     'A distinct period of abnormally elevated or irritable mood with increased energy, lasting a week or more and severe enough to markedly impair functioning, is a {{c1::manic}} episode.',
     1),
    (deck, 17, 'cloze',
     'An episode of genuinely elevated, energetic mood that is too mild to seriously impair functioning or cause psychosis is a {{c1::hypomanic}} episode.',
     1),
    (deck, 18, 'cloze',
     'Bipolar {{c1::I}} is the diagnosis after even one lifetime {{c1::manic}} episode, whether or not a major depressive episode has ever occurred.',
     1),
    (deck, 19, 'cloze',
     'The bipolar diagnosis marked by a major depressive episode plus a hypomanic episode, but never a full manic episode, is bipolar {{c1::II}}.',
     1),
    (deck, 20, 'cloze',
     '{{c1::Cyclothymic disorder}} is at least {{c2::two years}} of hypomanic and depressive symptoms that stay too mild to qualify as a full episode.',
     2);

    -- ── Anxiety Disorders ─────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 21, 'cloze',
     'Although every anxiety disorder involves excessive fear or anxiety, the DSM-5 distinguishes them mainly by {{c1::what triggers the fear — the feared object or situation}}.',
     1),
    (deck, 22, 'cloze',
     'An intense, irrational, persistent fear focused on a single object or situation — such as flying, snakes, or enclosed spaces — is {{c1::specific phobia}}.',
     1),
    (deck, 23, 'cloze',
     'Separation anxiety disorder is excessive, developmentally inappropriate fear or distress over being away from one''s {{c1::attachment figures (e.g., a parent or caregiver)}}.',
     1),
    (deck, 24, 'cloze',
     'Persistent fear and avoidance of situations where one might be scrutinized or negatively judged by others — like public speaking or meeting strangers — defines {{c1::social anxiety disorder}}.',
     1),
    (deck, 25, 'cloze',
     'A child with {{c1::selective mutism}} can speak but reliably stays silent in specific situations where it is expected (e.g., at school), unlike a speech or language disorder.',
     1),
    (deck, 26, 'cloze',
     'Recurrent, {{c1::unexpected}} attacks of intense fear with a sympathetic surge (racing heart, sweating) peaking within about 10 minutes, plus lasting dread of more attacks, define {{c2::panic disorder}}.',
     2),
    (deck, 27, 'cloze',
     'Intense fear and avoidance of situations where escape might be difficult or help unavailable if panic-like symptoms occur — such as crowds or public transportation — defines {{c1::agoraphobia}}.',
     1),
    (deck, 28, 'cloze',
     '{{c1::Generalized anxiety disorder}} involves excessive, uncontrollable worry occurring more days than not for at least {{c2::6 months}}.',
     2);

    -- ── OCD-Related & Trauma Disorders ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 29, 'cloze',
     'The disorder marked by recurrent intrusive, unwanted thoughts paired with repetitive ritual acts performed to relieve the anxiety those thoughts cause is {{c1::obsessive-compulsive disorder}}.',
     1),
    (deck, 30, 'cloze',
     'In OCD, {{c1::obsessions}} are recurrent, intrusive, unwanted thoughts, whereas {{c1::compulsions}} are repetitive acts performed to reduce the distress those thoughts create.',
     1),
    (deck, 31, 'cloze',
     '{{c1::Body dysmorphic disorder}} is preoccupation with a perceived appearance flaw that is nonexistent or looks trivial to others.',
     1),
    (deck, 32, 'cloze',
     '{{c1::Hoarding disorder}} is a persistent difficulty discarding possessions regardless of their actual value, producing clutter that fills living spaces.',
     1),
    (deck, 33, 'cloze',
     '{{c1::Posttraumatic stress disorder}} is the only DSM-5 diagnosis that explicitly names its cause: exposure to an event involving actual or threatened death, serious injury, or sexual violence.',
     1),
    (deck, 34, 'cloze',
     'For posttraumatic stress disorder to be diagnosed, its characteristic symptoms must persist for at least {{c1::one month}}.',
     1),
    (deck, 35, 'cloze',
     'The four symptom clusters of PTSD are {{c1::intrusion, avoidance, negative changes in cognition and mood, and arousal}}.',
     1),
    (deck, 36, 'cloze',
     'In PTSD, the {{c1::intrusion}} symptoms involve involuntarily re-experiencing the trauma through flashbacks and nightmares.',
     1);

    -- ── Dissociative & Somatic Disorders ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 37, 'cloze',
     '{{c1::Dissociative amnesia}} is a psychologically caused loss of important personal information, typically triggered by trauma and not explained by any medical condition.',
     1),
    (deck, 38, 'cloze',
     '{{c1::Dissociative fugue}}, the severe form of dissociative amnesia, adds sudden unexpected travel away from home together with confusion about one''s identity.',
     1),
    (deck, 39, 'cloze',
     '{{c1::Dissociative identity disorder}} is defined by two or more distinct personality states that alternately take control of behavior, accompanied by gaps in memory.',
     1),
    (deck, 40, 'cloze',
     '{{c1::Depersonalization}} is a sense of detachment from one''s own self, whereas {{c1::derealization}} is a sense of detachment from one''s surroundings.',
     1),
    (deck, 41, 'cloze',
     'In depersonalization/derealization disorder, {{c1::reality testing}} remains intact, distinguishing it from psychotic disorders.',
     1),
    (deck, 42, 'cloze',
     '{{c1::Somatic symptom disorder}} features one or more genuinely distressing bodily complaints paired with excessive thoughts, anxiety, or behaviors focused on them.',
     1),
    (deck, 43, 'cloze',
     '{{c1::Illness anxiety disorder}} is marked by preoccupation with contracting or having a serious medical condition despite minimal or absent bodily symptoms.',
     1),
    (deck, 44, 'cloze',
     '{{c1::Conversion disorder}} produces unexplained neurological symptoms, such as motor or sensory deficits, that have no medical cause and often follow psychological stress.',
     1),
    (deck, 45, 'cloze',
     'The disturbances of self, memory, and identity seen in dissociative disorders arise from a {{c1::psychological}} rather than a {{c1::physical}} cause.',
     1);

    -- ── Personality Disorders ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 46, 'cloze',
     'A {{c1::personality disorder}} is a pervasive, inflexible, maladaptive pattern of experience and behavior that deviates from cultural norms and produces distress or functional impairment.',
     1),
    (deck, 47, 'cloze',
     'The DSM-5 sorts personality disorders into three clusters by shared theme: Cluster A ({{c1::odd or eccentric}}), Cluster B ({{c1::dramatic, emotional, and erratic}}), and Cluster C ({{c1::anxious and fearful}}).',
     1),
    (deck, 48, 'cloze',
     'The odd/eccentric cluster (Cluster A) of personality disorders comprises {{c1::paranoid, schizotypal, and schizoid}} personality disorders.',
     1),
    (deck, 49, 'cloze',
     'The dramatic/emotional/erratic cluster (Cluster B) includes {{c1::antisocial, borderline, histrionic, and narcissistic}} personality disorders.',
     1),
    (deck, 50, 'cloze',
     'The anxious/fearful cluster (Cluster C) includes {{c1::avoidant, dependent, and obsessive-compulsive}} personality disorder.',
     1),
    (deck, 51, 'cloze',
     '{{c1::Paranoid}} personality disorder (Cluster A) interprets benign remarks as veiled attacks and assumes, without justification, that others intend to harm or exploit them.',
     1),
    (deck, 52, 'cloze',
     '{{c1::Schizotypal}} personality disorder (Cluster A) features ideas of reference, magical thinking, unusual perceptual experiences, and eccentric appearance or speech.',
     1),
    (deck, 53, 'cloze',
     '{{c1::Schizoid}} personality disorder (Cluster A) is defined by aloof social detachment, emotional coldness, and no genuine desire for close relationships.',
     1),
    (deck, 54, 'cloze',
     '{{c1::Antisocial}} personality disorder (Cluster B) is a pervasive disregard for and violation of others'' rights, marked by deceit, impulsivity, and a lack of remorse.',
     1),
    (deck, 55, 'cloze',
     '{{c1::Borderline}} personality disorder (Cluster B) is marked by instability in mood, relationships, and self-image, plus impulsivity and splitting (all-or-nothing views of others).',
     1),
    (deck, 56, 'cloze',
     '{{c1::Histrionic}} personality disorder (Cluster B) is a pattern of excessive emotionality and attention-seeking, with discomfort when not the center of attention.',
     1),
    (deck, 57, 'cloze',
     '{{c1::Narcissistic}} personality disorder (Cluster B) involves grandiosity, a need for admiration, and a lack of empathy.',
     1),
    (deck, 58, 'cloze',
     '{{c1::Avoidant}} personality disorder (Cluster C) involves social inhibition and feelings of inadequacy, with hypersensitivity to criticism and fear of rejection despite wanting relationships.',
     1),
    (deck, 59, 'cloze',
     '{{c1::Dependent}} personality disorder (Cluster C) is an excessive need to be taken care of, shown through submissive, clinging behavior and fear of being alone.',
     1),
    (deck, 60, 'cloze',
     'Obsessive-compulsive personality disorder (Cluster C), unlike obsessive-compulsive disorder, has no true obsessions or compulsions; its hallmark is {{c1::perfectionism, rigidity, and preoccupation with orderliness and control}}.',
     1);

    -- ── Biological Bases of Disorders ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 61, 'cloze',
     'Senile plaques of beta-amyloid protein and neurofibrillary tangles of tau protein are the microscopic hallmarks of {{c1::Alzheimer''s disease}}.',
     1),
    (deck, 62, 'cloze',
     'In Alzheimer''s disease, the brain undergoes widespread atrophy and shows depleted levels of the neurotransmitter {{c1::acetylcholine}}.',
     1),
    (deck, 63, 'cloze',
     'Among the biological correlates of major depressive disorder is an abnormally elevated level of the hormone {{c1::cortisol}}.',
     1),
    (deck, 64, 'cloze',
     'Depression involves low levels of the monoamine neurotransmitters {{c1::norepinephrine, serotonin, and dopamine}}.',
     1),
    (deck, 65, 'cloze',
     'Bipolar disorder is highly {{c1::heritable}}, and its manic episodes involve elevated {{c2::norepinephrine and serotonin}}.',
     2),
    (deck, 66, 'cloze',
     '{{c1::Schizophrenia}} is associated with excessive dopamine transmission, with risk factors that include genetics, family history, and adolescent cannabis use.',
     1),
    (deck, 67, 'cloze',
     'Parkinson''s disease results from the death of dopamine-producing neurons in a midbrain structure called the {{c1::substantia nigra}}.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 68;
END $$;
