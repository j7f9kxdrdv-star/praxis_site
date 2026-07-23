-- Praxis Prep — Psych/Soc Chapter 12: Social Stratification
-- v6-compliant flashcard deck (41 cards)
-- Subtopics: 12.1 Social Stratification (30) — high-yield, 12.2 Epidemiology and Disparities (11).
-- Source-laundered against OpenStax Sociology 3e (Ch. 9 Social Stratification,
-- Ch. 10 Global Inequality, Ch. 11 Race and Ethnicity, Ch. 19 Health and Medicine,
-- Ch. 20 Population and Urbanization) and seminal theorists (Durkheim, Merton, Marx,
-- Granovetter, Bourdieu, Wallerstein, Crenshaw, Parsons).
-- Idempotent: deletes any prior version of this deck before inserting.

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcards
    WHERE deck_id IN (
        SELECT id FROM flashcard_decks
        WHERE title IN (
            'Social Stratification',
            'Psych/Soc Chapter 12: Social Stratification',
            'Behavioral Sciences Chapter 12: Social Stratification'
        )
    );

    DELETE FROM flashcard_decks
    WHERE title IN (
        'Social Stratification',
        'Psych/Soc Chapter 12: Social Stratification',
        'Behavioral Sciences Chapter 12: Social Stratification'
    );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'psych_soc',
        'Psych/Soc',
        'social stratification',
        'Social Stratification',
        'Social class foundations (stratification, social cohesion, SES, ascribed vs achieved status, educational attainment, socioeconomic gradient in health); class power (prestige, power, class consciousness, false consciousness); anomie (Durkheim) and strain theory (Merton); social capital, cultural capital (Bourdieu), strong vs weak ties (Granovetter), network inequality; privilege, racialization, intersectionality; social mobility (intergenerational vs intragenerational, meritocracy vs plutocracy, vertical vs horizontal); poverty (absolute vs relative, structural, poverty line, social reproduction); spatial inequality (residential segregation, suburbanization and urban decay, urban renewal, gentrification, environmental justice); World-Systems Theory; social exclusion; and epidemiology and disparities (social epidemiology, sick role and illness experience, incidence vs prevalence, morbidity vs mortality, welfare state, second sickness, Medicare vs Medicaid, ACA, and health disparities by race, gender, sexual orientation, and income).',
        12
    )
    RETURNING id INTO deck;

    -- ============================================================
    -- 12.1 Social Stratification (cards 1–30) ★ high-yield
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
        '{{c1::Social stratification}} is the hierarchical organization of individuals based on SES, wealth, education, and occupation; {{c2::social cohesion (social integration)}} is the degree to which people feel connected and unified within society.',
        2),
    (deck, 1, 'cloze',
        '{{c1::Socioeconomic status (SES)}} is determined by factors such as {{c2::income, education, and occupation}}, and gives rise to {{c3::status hierarchies}} in society.',
        3),
    (deck, 2, 'cloze',
        '{{c1::Ascribed status}} is involuntary and based on identifiable characteristics like {{c2::age, gender, or race}}; {{c1::achieved status}} is voluntary and earned through {{c2::individual effort or merit}}.',
        2),
    (deck, 3, 'cloze',
        '{{c1::Educational attainment}} is the {{c2::highest degree obtained}} or number of years of education completed, and correlates strongly with social and economic outcomes.',
        2),
    (deck, 4, 'cloze',
        'The {{c1::socioeconomic gradient in health}} — individuals with {{c2::lower SES}} systematically experience {{c3::worse health outcomes and shorter lifespans}} than those with higher SES.',
        3),
    (deck, 5, 'cloze',
        '{{c1::Prestige}} is the {{c2::positive regard society holds}} for a given person, occupation, or association.',
        2),
    (deck, 6, 'cloze',
        '{{c1::Power}} is the ability to {{c2::influence others'' behavior}} through real or perceived {{c3::rewards and punishments}}; it derives from the unequal distribution of valued resources.',
        3),
    (deck, 7, 'cloze',
        '{{c1::Class consciousness (Marx)}} — the working class''s organization around {{c2::shared goals}} and its recognition of the need for {{c3::collective political action}}.',
        3),
    (deck, 8, 'cloze',
        '{{c1::False consciousness}} (Ch 11 callback) — workers'' {{c2::misperception of their actual position}} within society''s class structure, often adopting the {{c3::ideology of the ruling class}} instead of recognizing their own oppression.',
        3),
    (deck, 9, 'cloze',
        '{{c1::Anomie (Durkheim)}} is a state of {{c2::normlessness}} and breakdown of social bonds; {{c3::Strain Theory (Merton)}} extends this — when anomic conditions block legitimate paths to success, individuals turn to {{c4::deviance}}.',
        4),
    (deck, 10, 'cloze',
        '{{c1::Social capital}} is the investment people make in society in return for {{c2::economic or collective rewards}}; greater investment leads to higher {{c3::social integration}} — the incorporation of new groups while they maintain their identities.',
        3),
    (deck, 11, 'cloze',
        '{{c1::Cultural capital (Bourdieu)}} refers to {{c2::knowledge, skills, education, and tastes}} that are used to make {{c3::social distinctions}} and that correlate with social status.',
        3),
    (deck, 12, 'cloze',
        '{{c1::Strong ties}} are {{c2::close, kin- and peer-level}} relationships (small in number, qualitatively powerful); {{c1::weak ties}} are {{c2::superficial acquaintances}} (large in number, providing connections to a wider range of people).',
        2),
    (deck, 13, 'cloze',
        'Social networking creates two forms of inequality: {{c1::situational}} (based on {{c2::socioeconomic advantage at the individual level}}) and {{c1::positional}} (based on {{c2::one''s centrality within the network}}).',
        2),
    (deck, 14, 'cloze',
        '{{c1::Privilege}} is {{c2::inequality in opportunity}} — unearned advantages held by members of dominant social groups.',
        2),
    (deck, 15, 'cloze',
        '{{c1::Racialization}} is the process by which {{c2::one group designates another}} with a racial identity, often based on {{c3::shared physical attributes or behaviors}}.',
        3),
    (deck, 16, 'cloze',
        '{{c1::Intersectionality (Crenshaw)}} examines how individuals hold {{c2::multiple, interconnected social identities}} (race, gender, class, sexuality) that combine to create {{c3::unique experiences of disadvantage or privilege}}.',
        3),
    (deck, 17, 'cloze',
        '{{c1::Intergenerational mobility}} compares social status {{c2::across generations (parents → children)}}; {{c1::intragenerational mobility}} describes status changes {{c2::within a single lifetime}}.',
        2),
    (deck, 18, 'cloze',
        '{{c1::Meritocracy}} is a system where advancement is based on {{c2::talent and achievement}}; {{c1::plutocracy}} is rule by {{c2::the wealthy upper class}}.',
        2),
    (deck, 19, 'cloze',
        '{{c1::Vertical mobility}} is movement between {{c2::social classes (upward or downward)}}; {{c1::horizontal mobility}} is a change in occupation or lifestyle that {{c3::keeps the individual within the same class}}.',
        3),
    (deck, 20, 'cloze',
        '{{c1::Poverty}} is a lack of financial resources to meet a society''s minimum standard of living; {{c2::social reproduction}} is how this inequality {{c3::passes from one generation to the next}}.',
        3),
    (deck, 21, 'cloze',
        '{{c1::Structural poverty}} attributes poverty primarily to {{c2::flaws in the structure of society}} rather than to the actions or failings of any individual.',
        2),
    (deck, 22, 'cloze',
        '{{c1::Absolute poverty}} — lacking basic life necessities (food, shelter, water); {{c1::relative poverty}} — having {{c2::less income and wealth}} than the surrounding population, even if basic needs are met.',
        2),
    (deck, 23, 'cloze',
        'The {{c1::poverty line}} is the {{c2::government''s calculation}} of the minimum income required for a family to acquire basic life necessities.',
        2),
    (deck, 24, 'cloze',
        '{{c1::Spatial inequality}} is the {{c2::unequal distribution of resources across territories}} (neighborhoods, regions); {{c3::residential segregation}} is the voluntary or forced separation of cultural, ethnic, or racial groups into different residential areas.',
        3),
    (deck, 25, 'cloze',
        '{{c1::Suburbanization}} — middle-class migration from city centers to suburban communities — can leave behind {{c2::urban decay}}, the {{c3::deterioration of previously functional city districts}}.',
        3),
    (deck, 26, 'cloze',
        '{{c1::Urban renewal}} reclaims and renovates city land for public or private use; {{c2::gentrification}} occurs when upper-middle-class residents move into deteriorated neighborhoods, renovating them and {{c3::displacing low-SES populations}}.',
        3),
    (deck, 27, 'cloze',
        '{{c1::Environmental justice}} is the {{c2::fair treatment and meaningful involvement}} of all people in environmental decision-making, regardless of {{c3::race, color, national origin, or income}}.',
        3),
    (deck, 28, 'cloze',
        '{{c1::World-Systems Theory (Wallerstein)}} divides the world into {{c2::core}} nations (economically dominant), {{c2::peripheral}} nations (exploited for cheap resources and labor), and {{c2::semi-peripheral}} nations (intermediate, often moving toward core status).',
        2),
    (deck, 29, 'cloze',
        '{{c1::Social exclusion}} is the sense of {{c2::powerlessness, segregation, and isolation}} experienced by individuals who are poor or otherwise disadvantaged from mainstream society.',
        2);

    -- ============================================================
    -- 12.2 Epidemiology and Disparities (cards 31–41)
    -- ============================================================

    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 30, 'cloze',
        '{{c1::Social epidemiology}} (Ch 11 callback) studies how {{c2::social structures, institutions, and relationships}} shape health and disease distribution — for example, how SES inequality drives mortality differences.',
        2),
    (deck, 31, 'cloze',
        '(Ch 11 callback) The {{c1::sick role (Parsons)}} legitimizes illness as socially acceptable deviance, exempting the ill from normal roles; the {{c2::illness experience}} (symbolic interactionist) is how people {{c3::incorporate illness into their self-identity}}.',
        3),
    (deck, 32, 'cloze',
        '{{c1::Incidence}} is the number of {{c2::new cases}} of a disease per population at risk per unit time; {{c1::prevalence}} is the {{c2::total number of cases (new + existing)}} per population per unit time.',
        2),
    (deck, 33, 'cloze',
        '{{c1::Morbidity}} is the {{c2::burden or severity of illness}} associated with a disease; {{c1::mortality}} is the {{c2::number of deaths}} caused by it.',
        2),
    (deck, 34, 'cloze',
        'A {{c1::modern welfare state}} is a system of government that {{c2::protects the health and well-being of its citizens}} through social safety-net programs.',
        2),
    (deck, 35, 'cloze',
        '{{c1::Second sickness}} is the {{c2::worsening of health outcomes}} layered on top of an underlying disease, caused by {{c3::social injustice and inequality}}.',
        3),
    (deck, 36, 'cloze',
        '{{c1::Medicare}} covers patients {{c2::over age 65}}; {{c1::Medicaid}} covers patients with {{c2::significant financial need}}, regardless of age.',
        2),
    (deck, 37, 'cloze',
        'The {{c1::Affordable Care Act (ACA)}} expanded {{c2::healthcare access}} in the U.S., particularly for {{c3::low-income and previously uninsured populations}}.',
        3),
    (deck, 38, 'cloze',
        'Racial health disparities in the U.S.: {{c1::African Americans}} tend to have the {{c2::worst health profiles}}; {{c1::Asian Americans and Pacific Islanders}} tend to have the {{c2::best}}; racial and ethnic minorities overall experience worse outcomes than white populations.',
        2),
    (deck, 39, 'cloze',
        'Women''s health paradox: women have {{c1::longer life expectancy}} than men but also {{c2::higher morbidity rates}}, and are {{c3::more likely to seek healthcare and use health services}}.',
        3),
    (deck, 40, 'cloze',
        '{{c1::LGBTQ individuals}} face healthcare barriers due to {{c2::prejudice and discrimination}}; {{c3::low-income Americans}} are less likely to be insured and experience late or reduced access to care.',
        3);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 41, 'cloze',
     '{{c1::Spatial inequality}} concentrates exposure to {{c2::crime and violence}} in disadvantaged neighborhoods, worsening residents'' health and long-term outcomes.',
     2);

    RAISE NOTICE 'Seeded deck % with 42 cards.', deck;
END $$;
