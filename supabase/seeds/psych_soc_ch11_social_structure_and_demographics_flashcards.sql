-- Praxis Prep — Psych/Soc Chapter 11: Social Structure and Demographics
-- v6-compliant flashcard deck (48 cards)
-- Subtopics: 11.1 Sociology, Theories, and Institutions (24) — high-yield,
-- 11.2 Culture (8), 11.3 Demographics (16).
-- Source-laundered against OpenStax Sociology 3e (Ch. 1 paradigms; Ch. 3 culture;
-- Ch. 9 race/ethnicity; Ch. 11–15 institutions; Ch. 19 social movements;
-- Ch. 20 population/demographics), OpenStax Psychology 2e Ch. 12, and seminal
-- works (Mead, Durkheim, Marx, Weber, Parsons, Conrad, Ritzer, Crenshaw).
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Social Structure and Demographics',
            'Psych/Soc Chapter 11: Social Structure and Demographics',
            'Behavioral Sciences Chapter 11: Social Structure and Demographics'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Social Structure and Demographics',
        'Psych/Soc Chapter 11: Social Structure and Demographics',
        'Behavioral Sciences Chapter 11: Social Structure and Demographics'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'psych_soc',
        'Psych/Soc',
        'social structure and demographics',
        'Social Structure and Demographics',
        'Three levels of sociological analysis (micro, meso, macro); six theoretical approaches (symbolic interactionism, social constructionism, rational choice / exchange theory, conflict theory, structural functionalism with manifest/latent/dysfunctions, feminist theory with glass ceiling vs glass escalator); social institutions (family with abuse types and mandated reporter, education with formal vs hidden curriculum, religion with denominations/sects/cults and secularization vs fundamentalism, government types, capitalism vs socialism, healthcare with sick role and medicalization and social epidemiology); culture (material vs symbolic, language, values, beliefs, norms, rituals, cultural transmission); and demographics (age cohorts, dependency ratio, gender, race, ethnicity, sexual orientation with Kinsey scale, immigration, intersectionality, population dynamics, four stages of Demographic Transition Theory, social movements, globalization, urbanization).',
        11
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 11.1 Sociology, Theories, and Institutions (cards 1–24) ★ high-yield
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        'Three levels of sociological analysis: {{c1::micro}} (family groups, local communities), {{c1::meso}} (organizations, institutions, ethnic subcultures), and {{c1::macro}} (national and international systems).',
        1),
    (deck, 1, 'cloze',
        '{{c1::Symbolic interactionism (Mead)}} studies how individuals assign and share {{c2::meaning through symbols}} (words, gestures, body language); it operates at the {{c3::micro-to-meso level}}.',
        3),
    (deck, 2, 'cloze',
        '{{c1::Social constructionism}} examines how individuals and groups {{c2::create shared social realities}}; it works at micro/meso levels but cannot account for macro-level structures.',
        2),
    (deck, 3, 'cloze',
        '{{c1::Rational choice theory}} assumes people decide by weighing {{c2::costs against benefits}} to maximize self-interest; {{c1::social exchange theory}} applies that logic specifically to {{c3::social interactions}}.',
        3),
    (deck, 4, 'cloze',
        '{{c1::Conflict theory (Marx)}} is a macro-level perspective that examines society through the {{c2::unequal distribution of power and resources}}, especially between the bourgeoisie and the working class.',
        2),
    (deck, 5, 'cloze',
        '{{c1::Structural functionalism (Durkheim)}} views society as interconnected parts working together; consequences may be {{c2::manifest}} (intended, beneficial), {{c2::latent}} (unintended, beneficial), or {{c2::dysfunctions}} (negative).',
        2),
    (deck, 6, 'cloze',
        '{{c1::Feminist theory}} critiques the institutional power structures that disadvantage women, describing society as inherently {{c2::patriarchal}} and maintained through societal privilege and institutional discrimination.',
        2),
    (deck, 7, 'cloze',
        'The {{c1::glass ceiling}} is an invisible barrier that {{c2::prevents women from rising}} to top positions; the related {{c1::glass escalator}} describes how {{c3::men in female-dominated fields rise faster}} than women.',
        3),
    (deck, 8, 'cloze',
        '{{c1::False consciousness}} (Marxist) — when the working class fails to {{c2::recognize its own oppression}} and instead adopts the ideology of the ruling class, which prevents collective action.',
        2),
    (deck, 9, 'cloze',
        'A {{c1::bureaucracy}} is a formal organization designed to perform complex tasks efficiently, characterized by {{c2::hierarchical structure, division of labor, and standardized rules and procedures}}.',
        2),
    (deck, 10, 'cloze',
        '{{c1::McDonaldization (Ritzer)}} describes how the principles of fast-food management spread to other sectors of society: {{c2::efficiency}}, {{c2::calculability}}, {{c2::predictability}}, and {{c2::control}}.',
        2),
    (deck, 11, 'cloze',
        'Family is considered the most basic social institution; abuse within it takes the forms of {{c1::spousal (domestic) abuse}}, {{c1::elder abuse}} (often neglect), and {{c1::child abuse}} (most commonly neglect).',
        1),
    (deck, 12, 'cloze',
        'A {{c1::mandated reporter}} is a person who is {{c2::legally required}} to report suspected cases of {{c3::child or elder abuse}} to authorities.',
        3),
    (deck, 13, 'cloze',
        'The {{c1::formal curriculum}} teaches skills, facts, and mental processes; the {{c1::hidden curriculum}} transmits unwritten lessons such as {{c2::conformity, obedience, and social hierarchies}}.',
        2),
    (deck, 14, 'cloze',
        '{{c1::Teacher expectancy}} — teachers tend to {{c2::get the performance they expect}} from students, which can become a self-fulfilling prophecy that reinforces social stratification.',
        2),
    (deck, 15, 'cloze',
        '{{c1::Religion}} as an institution organizes beliefs and practices around the meaning of existence; {{c2::religiosity}} measures how religious a person considers themselves to be (strength of beliefs, engagement, practices).',
        2),
    (deck, 16, 'cloze',
        'Three religious subdivisions: a {{c1::denomination}} is a recognized branch of a religion, a {{c1::sect}} is a group that has {{c2::broken off from a parent religion}}, and a {{c1::cult}} is a sect that has taken on {{c3::extreme or unconventional beliefs}}.',
        3),
    (deck, 17, 'cloze',
        '{{c1::Secularization}} is the shift from a religion-dominated society toward {{c2::rationality and scientific thinking}}; {{c1::fundamentalism}} is the opposite — {{c3::strict adherence to religious code}}.',
        3),
    (deck, 18, 'cloze',
        'Four government types: {{c1::democracy}} (citizens vote, usually through representatives), {{c1::monarchy}} (royal ruler), {{c1::dictatorship}} (one person holds power), and {{c1::theocracy}} (religious leaders hold power).',
        1),
    (deck, 19, 'cloze',
        '{{c1::Charismatic authority (Weber)}} is power that derives from a leader''s {{c2::compelling personality}} rather than from law or tradition.',
        2),
    (deck, 20, 'cloze',
        '{{c1::Capitalist}} economies rely on {{c2::free-market exchange and private ownership}} of the means of production; {{c1::socialist}} economies treat industries as {{c3::collectively owned}}, with profit distributed across the workforce.',
        3),
    (deck, 21, 'cloze',
        'The {{c1::sick role (Parsons)}} — an ill person is {{c2::exempt from normal social roles}} but is obligated to seek help; {{c3::medicalization}} occurs when behaviors are reframed as medical conditions, while the illness experience is how the patient (rather than the doctor) defines and adjusts to changes in their health.',
        3),
    (deck, 22, 'cloze',
        '{{c1::Social epidemiology}} studies how {{c2::social structures, institutions, and relationships}} affect health and access to healthcare (for example, the impact of racial and economic inequality or government safety-net policy).',
        2),
    (deck, 23, 'cloze',
        'The four principles of medical ethics (covered in detail in Scientific Reasoning Ch 11): {{c1::beneficence}}, {{c1::nonmaleficence}}, {{c1::autonomy}}, and {{c1::justice}}.',
        1);

    -- ============================================================
    -- 11.2 Culture (cards 25–32)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 24, 'cloze',
        '{{c1::Culture}} encompasses the {{c2::entire lifestyle of a given group}} — both the physical things they make and the ideas they share.',
        2),
    (deck, 25, 'cloze',
        '{{c1::Material culture}} consists of {{c2::physical artifacts}} (clothing, food, buildings, tools); {{c1::symbolic (non-material) culture}} consists of {{c3::ideas, values, beliefs, and norms}}.',
        3),
    (deck, 26, 'cloze',
        '{{c1::Cultural lag}} is the phenomenon in which {{c2::symbolic culture lags behind material culture}} — society''s ideas about technology change more slowly than the technology itself.',
        2),
    (deck, 27, 'cloze',
        '{{c1::Language}} is the most highly developed cultural symbol system — spoken, written, or signed symbols regulated by {{c2::grammar and syntax}} — and it expands communication across both space and time.',
        2),
    (deck, 28, 'cloze',
        '{{c1::Values}} are what a person deems important in life and dictate ethical principles and standards of behavior; {{c1::beliefs}} are things an individual {{c2::accepts as true}}.',
        2),
    (deck, 29, 'cloze',
        '{{c1::Norms}} are societal rules defining acceptable behavior; they are {{c2::not laws}} but still {{c3::provide social control}} by guiding what we should and should not do.',
        3),
    (deck, 30, 'cloze',
        'A {{c1::ritual}} is a formalized ceremony involving specific {{c2::material objects, symbolism, and a set order of events}}.',
        2),
    (deck, 31, 'cloze',
        '{{c1::Cultural transmission}} is how values, beliefs, and behaviors {{c2::pass from one generation to the next}} (typically through socialization); {{c3::cultural barriers}} are differences that impede communication or understanding across cultures.',
        3);

    -- ============================================================
    -- 11.3 Demographics (cards 33–48)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 32, 'cloze',
        'The {{c1::life course perspective}} considers an individual''s age and {{c2::cumulative life experiences}} when analyzing personality, social status, or health; {{c3::ageism}} is discrimination based on age.',
        3),
    (deck, 33, 'cloze',
        '{{c1::Age cohorts}} group individuals by {{c2::age or birth year}} to analyze generational differences in attitudes, opportunities, and experiences.',
        2),
    (deck, 34, 'cloze',
        'The {{c1::dependency ratio}} measures the {{c2::economic burden on the working-age population}} and combines the {{c3::youth ratio (under 15) plus the age-dependency ratio (over 65)}} relative to those aged 15–65.',
        3),
    (deck, 35, 'cloze',
        '{{c1::Sex}} is a {{c2::biological}} category; {{c1::gender}} is a {{c3::socially constructed}} set of ideas about what it means to be male, female, or otherwise in a given culture.',
        3),
    (deck, 36, 'cloze',
        '{{c1::Gender roles}} are a culture''s expected behavioral traits associated with a given sex; {{c2::gender identity}} is the gender an individual personally adopts and projects.',
        2),
    (deck, 37, 'cloze',
        'Three related concepts: {{c1::gender inequality}} (intentional or unintentional empowerment of one gender over another), {{c1::gender stratification}} (any inequality in access to resources based on gender), and {{c1::gender segregation}} (separation of individuals by perceived gender).',
        1),
    (deck, 38, 'cloze',
        '{{c1::Race}} is a social construct based on {{c2::inherited phenotypic characteristics}}; {{c1::ethnicity}} is a social construct based on {{c3::shared language, religion, culture, or national origin}}.',
        3),
    (deck, 39, 'cloze',
        'Three common sexual-orientation categories: {{c1::heterosexual}} (attraction to a different sex), {{c1::bisexual}} (attraction to multiple sexes), and {{c1::homosexual}} (attraction to the same sex).',
        1),
    (deck, 40, 'cloze',
        'The {{c1::Kinsey scale}} rates sexual orientation from {{c2::0 (exclusively heterosexual) to 6 (exclusively homosexual)}}; sexual and gender minorities are often grouped under the umbrella {{c3::LGBTQ}}.',
        3),
    (deck, 41, 'cloze',
        '{{c1::Immigration}} is movement into a new location; {{c1::emigration}} is movement out; migration is driven by {{c2::push factors}} (negatives at origin) and {{c2::pull factors}} (positives at destination).',
        2),
    (deck, 42, 'cloze',
        '{{c1::Intersectionality (Crenshaw)}} is the analytical framework that examines how multiple social identities (race, gender, class, sexuality) {{c2::intersect to create unique experiences}} of discrimination and privilege.',
        2),
    (deck, 43, 'cloze',
        'Key population rates: {{c1::fertility rate}} (average children per woman over a lifetime), {{c1::birth rate}} (births per 1,000 per year), {{c1::mortality rate}} (deaths per 1,000 per year), and the {{c1::crude rate}} (adjusted to a standard population size for cross-comparison).',
        1),
    (deck, 44, 'cloze',
        'A {{c1::population pyramid}} is a histogram showing population size by {{c2::age cohort}}; {{c3::population density}} measures the number of people per square kilometer of land.',
        3),
    (deck, 45, 'cloze',
        'Demographic Transition Theory — four stages: Stage 1: {{c1::pre-industrial, high birth + high death = stable}}; Stage 2: {{c2::death rate drops (healthcare, sanitation, nutrition)}}; Stage 3: {{c3::birth rate drops (contraception, women''s rights, industrialization)}}; Stage 4: {{c4::industrialized, low birth + low death = stable again}}.',
        4),
    (deck, 46, 'cloze',
        'Social movements are {{c1::proactive}} when they promote social change and {{c1::reactive}} when they resist it; {{c2::relative deprivation}} — feeling worse off relative to others or to one''s own past — often drives them.',
        2),
    (deck, 47, 'cloze',
        '{{c1::Globalization}} merges separate nations into a single sociocultural entity, driven by communication technology and economic interdependence; {{c1::urbanization}} is the {{c2::growth of dense urban populations}} fueled by rural-to-city migration.',
        2);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 48, 'cloze',
     'Beyond the {{c1::nuclear}} family (two parents and their children), other family forms include {{c2::extended, single-parent, blended, cohabiting, and same-sex-parent}} families.',
     2),
    (deck, 49, 'cloze',
     'Culture shock is the {{c1::disorientation and anxiety}} felt when immersed in an unfamiliar culture; the same feeling on returning to one''s own culture is {{c2::reverse}} culture shock.',
     2),
    (deck, 50, 'cloze',
     'Michels''s {{c1::iron law of oligarchy}} holds that every large bureaucratic organization inevitably comes to be run by a small ruling {{c2::elite}}, as power concentrates at the top.',
     2),
    (deck, 51, 'cloze',
     'Kinship arises through {{c1::consanguinity (shared blood/descent) or affinity (marriage)}}; descent may be {{c2::patrilineal, matrilineal, or bilateral}}.',
     2),
    (deck, 52, 'cloze',
     'Marriage within one''s own social group is {{c1::endogamy}}, whereas marriage outside one''s group is {{c1::exogamy}}.',
     1),
    (deck, 53, 'cloze',
     'Widely shared culture spread through media to a mainstream audience is {{c1::popular (mass)}} culture, contrasted with {{c1::high}} culture, associated with social elites.',
     1),
    (deck, 54, 'cloze',
     'In {{c1::Malthusian}} theory, population grows {{c2::exponentially}} while food supply grows only {{c2::linearly}}, so positive checks (famine, disease, war) eventually cap it.',
     2),
    (deck, 55, 'cloze',
     'Because immigrant status frequently combines with racial and ethnic minority status, holding both compounds disadvantage — an instance of {{c1::intersectionality}}.',
     1),
    (deck, 56, 'cloze',
     'Sustained social movements succeed less through shared grievances than through {{c1::resource mobilization}} — organizing money, people, leadership, and networks.',
     1),
    (deck, 57, 'cloze',
     'Social movements pursue their goals through tactics such as {{c1::boycotts, strikes, and civil disobedience}}.',
     1),
    (deck, 58, 'cloze',
     'Globalization''s rapid economic and cultural integration can provoke backlash and social change, including {{c1::civil unrest and transnational terrorism}}.',
     1);

    RAISE NOTICE 'Seeded deck % with 59 cards.', deck;
END $$;
