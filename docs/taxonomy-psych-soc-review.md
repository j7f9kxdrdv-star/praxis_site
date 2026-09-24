# Psych/Soc decks awaiting a discipline decision

12 decks, 778 cards. Generated from the live database on 2026-09-23.

## Status

These decks resolve to **`mcatSection: PSYCH_SOC`**, which is certain and is enough for
section-level work today. Their **discipline is `UNRESOLVED`**: recognised value, deliberately
undecided, as distinct from `UNKNOWN`, which means a value nobody mapped.

The decision is deferred on purpose. Some of these decks are plainly psychology, some plainly
sociology, and several genuinely span both, which makes the split a pedagogical judgement rather
than a lookup. It belongs to the canonical vocabulary phase, where the same judgement is being
made anyway at concept level.

**This does not block concept mapping.** Concepts attach to a card, not to its discipline, so
every deck below can be mapped to canonical concepts while its discipline stays unresolved.

## The decks

| Deck | Slug | Cards | First read |
|---|---|---:|---|
| Brain, Behavior & Development | `brain_behavior_and_development` | 87 | leans psychology |
| Sensory Systems & Perception | `sensory_systems_and_perception` | 86 | leans psychology |
| Learning and Memory | `learning_and_memory` | 72 | leans psychology |
| Cognition, Consciousness, and Language | `cognition_consciousness_and_language` | 77 | leans psychology |
| Motivation, Emotion, and Stress | `motivation_emotion_and_stress` | 57 | leans psychology |
| Identity and Personality | `identity_and_personality` | 79 | leans psychology |
| Psychological Disorders | `psychological_disorders` | 68 | leans psychology |
| Social Processes, Attitudes, and Behavior | `social_processes_attitudes_and_behavior` | 60 | leans sociology |
| Social Interaction | `social_interaction` | 42 | leans sociology |
| Social Thinking | `social thinking` | 49 | leans sociology |
| Social Structure and Demographics | `social structure and demographics` | 59 | leans sociology |
| Social Stratification | `social stratification` | 42 | leans sociology |

The "first read" column is an impression to speed up review, not a proposal and not data. Nothing
in the codebase consumes it. The authoritative statement is that all 12 are
`UNRESOLVED` until a human decides otherwise.

## What would change this

A row in `legacy_taxonomy_map` for `flashcard_decks.section = 'psych_soc'` currently carries a
null `discipline_code`. Resolving the split means either setting that one row (if every deck
turns out to share a discipline, which is unlikely) or moving the decision down to the concept
level, which is the expected outcome.
