# V3 Adaptive Spaced Repetition — Concerns and Open Decisions

Companion to `Praxist Adaptive Spaced Repetition V3 — New-User-First Design`.
Every number here is measured against the live database on 2026-08-20.

The V3 spec is sound and FSRS is the right call. This document covers what the spec
does not yet decide, what it assumes about the current system that is not true, and
what needs fixing alongside it.

---

## Decisions already made

**D0 — Schedules are persisted, not recomputed at read time.**
Each review writes the next due date and FSRS state onto the row. That value is the
source of truth. Rationale: replaying history at read time makes every card's due date
a function of the installed library version, so an `npm update` would silently reshuffle
7,253 schedules with no code change and no review step.

**D0a — Improvements reschedule existing cards, via an explicit batch migration.**
Not automatically at read time. Required guardrails:
- dry run that reports how many cards move, in which direction, and how many land in
  "due now" before anything is written;
- an abort threshold if the run would flood the queue;
- a before/after snapshot so it is reversible;
- the ts-fsrs version pinned exactly (`"5.2.1"`, not `"^5.2.1"`), so upgrades are chosen;
- `scheduler_version` **and the actual FSRS parameter set** stamped on each row, so any
  schedule can be explained later.

### D0b — OPEN: do per-user parameter refits also reschedule?

Once FSRS has enough of a student's history it refits that student's personal constants,
and will want to repeat that every few hundred reviews. That is far too frequent for a
human-reviewed migration.

- **Option A — refits apply going forward only.** Predictable, no surprise queue shifts;
  the student carries slightly stale scheduling until each card is next reviewed.
- **Option B — refits reschedule automatically**, with the D0a guardrails enforced in
  code rather than by a person.

Recommendation: **A** for the first release, B later once refit behaviour is observed.
Getting personalization slightly late is cheaper than a student's queue moving under them
every fortnight.

---

## 1. The backlog, and the fact that you cannot test V3 on yourself

**Concern.** 5,522 of 7,253 card-blanks are due right now — a 76% backlog. FSRS fixes
the *rate* at which backlog forms, but does nothing about the pile that already exists.
Separately, §36 defers existing-user migration until after new-user behaviour is
validated — but you are the existing user, so under the spec as written you cannot run
V3 on your own library at any point in Phases 1 to 4.

Why the backlog exists: steady-state daily review load is roughly
`library size ÷ mean interval`. At today's median interval of 1.00 day that load is
effectively the whole library, every day. Whatever mean interval V3 produces is the
number that decides whether the backlog ever clears. That is exactly what the §22
retention simulation should output, and it should be treated as the headline result.

**Options for testing on real data:**
- **A — fresh test account.** Validates the new-user path only, which is the spec's
  stated priority. You never feel V3 on your own 7,253 cards.
- **B — pull a minimal migration into Phase 1** behind a feature flag so your account can
  run V3 early. Fastest feedback, but migration is the riskiest part of the project and
  this front-loads it.
- **C — shadow mode.** Keep studying under v2. On every review, also compute what V3
  *would* have scheduled and log it without acting on it. After a few weeks you have a
  real side-by-side on real behaviour, with zero risk to your schedule.

Recommendation: **C, plus A.** Shadow mode answers "what would V3 do to my library"
without betting the library on it, and it produces the migration dry-run data for free.

**Decision needed:** which of A / B / C, and does the backlog get a one-time
reset/rebalance at migration or is it worked down through daily limits?

---

## 2. Sibling burial is the main path, not an edge case

**Concern.** §20 is correct that showing two blanks from one sentence leaks answers. But
the cost is much larger than the spec implies.

| Blanks per card | Cards | Share |
|---|---|---|
| 1 | 1,841 | 44.7% |
| 2 | 1,564 | 38.0% |
| 3 | 589 | 14.3% |
| 4 or more | 122 | 3.0% |

**2,275 cards have siblings, holding 5,412 blanks — 74.6% of the entire library.**

Burying to "the next appropriate study day" means a 3-blank card needs three separate
days minimum. Against a 76% backlog, that is a throughput constraint on three quarters
of the collection, not a rare special case.

**Options:**
- **A — bury to next day** (spec default). Strongest leak protection, largest throughput cost.
- **B — bury within session only.** Siblings may appear the same day but separated by
  other cards. Cheaper, weaker protection.
- **C — bury to next day in Daily Review, allow siblings in Extra Study.** The spec hints
  at this in §20's last line.
- **D — make the burial window configurable** and set it from simulation.

Recommendation: **C**, with A vs B simulated for throughput cost before the window is
fixed. §32 should test the *cost* of burial, not only its correctness.

**Decision needed:** which burial policy, and is throughput an explicit simulation output?

---

## 3. Per-user parameter optimization is missing from the spec

**Concern.** §2 promises that scheduling "progressively personalizes" to each student.
The spec describes only per-card difficulty and stability updates. That is real, but it
is not where FSRS's personalization actually lives — the deeper mechanism is refitting
the student's own parameter set from their review log, which typically needs a few
hundred reviews before it beats the defaults.

The spec never says when to first fit, how often to refit, or what happens to existing
cards when parameters change. That last one is D0b above.

**Decision needed:** at what review count does a student get their own parameters, how
often are they refit, and (D0b) do refits reschedule.

---

## 4. `prev_interval_days === 0` is load-bearing and about to change meaning

**Concern.** Every "new vs review" number in the product — the daily counters, the
hub's split, the "N left today" button — depends on a review row with
`prev_interval_days === 0` meaning "this card's first-ever exposure." Under FSRS,
`interval_days` stops being the primary state; stability replaces it. If what gets
logged in that column changes meaning, the daily counters break silently.

**455 rows already violate the invariant** (legacy, pre-v2): they carry
`prev_interval_days === 0` on cards that already had an earlier review, so each one is
miscounted against the *new-card* budget rather than the review budget.

**Options:** keep writing the column with its current semantics purely for counting; or
introduce an explicit `is_first_exposure` boolean and stop inferring it from a number
whose meaning is changing.

Recommendation: **explicit boolean.** Inferring a fact from a field that is being
redefined is how this breaks six months from now. Backfill it for the 455 bad rows.

**Decision needed:** confirm the explicit-flag approach and what to do with the 455 rows.

---

## 5. Schema work the spec does not name

FSRS needs persisted per card-blank, none of which exist today:
`difficulty`, `stability`, `state` (New / Learning / Review / Relearning), `last_review`.

The spec also asks for two columns that do not exist:
- `review_source` (§15, daily_review vs extra_study) — **no such column**
- response latency (§24, "if already available") — **not stored; no time column at all**

Current `flashcard_user_state` carries `interval_days`, `ease_factor`, `reps`, `lapses`,
`last_rating`, `last_reviewed_at`, `next_review_at`. Under FSRS, `interval_days` and
`ease_factor` become legacy — keep them written for a transition period so a rollback is
possible, then retire them.

This is a migration against 7,253 live rows and 29,912 log rows. It is routine, but it
is Phase 1 work and should be scheduled as such rather than discovered.

---

## 6. Queue priority is under-specified

§17 lists candidate inputs (retrievability, lateness, relearning status, stability, MCAT
relevance) and says "start with an interpretable policy," but does not choose one.
Left open, it will be invented differently in three places.

Recommendation: **sort by retrievability ascending — most-forgotten first.** It is
interpretable, it is what the memory model is for, and it maximises value per review
when capacity is the binding constraint. Everything else is a tiebreak.

---

## 7. Extra Study and the daily counter: the spec's assumption is not true today

§14 says Extra Study "should not have the same daily cap," and §33 says it should not
consume Daily Review capacity "unless the existing product deliberately defines a
counter that way."

**It currently does.** Every review counts toward the day regardless of mode. Combined
with cram applying no cap on the way in, that is how 2026-08-19 reached 746 reviews
against a 600 cap.

So this is a live decision, not a hypothetical: **do Extra Study reviews spend Daily
Review capacity, or not?** If not, a student can do 600 daily reviews plus unlimited
Extra Study and the counter must stop conflating them.

---

## 8. Desired retention and the MCAT date are the same decision

§22 says choose desired retention by simulation. §23 says defer MCAT-date optimization.
But for a student with a fixed exam date, the exam date is precisely what should set
retention — a student four weeks out and one six months out should not carry the same
target. Deferring §23 while fixing a default in §22 risks setting the number twice.

Recommendation: pick a single default from simulation now, but treat it as configurable
per student from day one so the §23 layer can set it later without a schema change.

---

## 9. Bugs that should be fixed alongside, not after

**Confirmed by direct code reading:**

- **Extra Study / cram applies no daily cap at all.** `session/page.tsx:259` slices to
  the quota only when `mode === "due"`; the else branch takes the whole pool. Cram grades
  still write identical review and state rows.
- **The limit-reached screen funnels users straight into that bypass.** It reads "You've
  hit today's limits… nothing's stopping you. Cram mode ignores the daily caps" and
  offers a primary **"Keep going"** button pointing at `?mode=cram`.
- **"Again" costs a tap but not a card.** A card graded Again is re-inserted into the
  queue and graded again, while the daily budget counts unique card-blanks. Real tap
  count runs roughly 1.3–1.6× the counter. This is what produces "I did 600 reviews and
  it says I have 300 left" — both numbers were right, measuring different things.
  §11 and §12 fix the first two incidentally. **This third one survives V3 unless the
  product decides what a "review" means to the student and uses one definition everywhere.**
- **Per-deck study page has the same cap hole**: limits apply only when `filter === "due"`.

**Reported by an automated pass but not independently verified** (the verification stage
died on a usage limit):
- remaining allowance is read once at queue construction, so two surfaces open at once
  could each spend the full budget;
- a cram session crossing local midnight pre-charges the next day's allowance;
- both paging loops treat a query error as end-of-data and truncate silently;
- the analytics page headlines "Total reviews" as raw event count while the daily budget
  counts unique cards — same word, two quantities.

---

## 10. The assumption the whole spec rests on

The spec's implicit theory is that part of the current **Again 38.7% / Hard 42.1%**
distribution is *misrating* caused by unclear buttons, and that §5 and §6 will shift it.

That is plausible and worth testing. But if that 39% Again rate is genuine forgetting,
FSRS will correctly schedule short intervals and the backlog will not move much. The
algorithm cannot make a card durable that the student keeps failing.

§27's split between `scheduler_version` and `rating_semantics_version` is exactly the
right instrument to find out which it is. What is missing is a **success metric set
before rollout** rather than after.

Suggested: after the rating-semantics change ships, on new reviews only, the share of
Again should fall below some agreed threshold within N reviews. If it does not, the
problem is card difficulty or deck size, not scheduling, and that is a content decision
rather than an algorithm one.

---

## Suggested order

1. Settle D0b, §1 (test strategy), §2 (burial policy), §7 (Extra Study counter).
2. Phase 1 schema migration (§5) plus the explicit first-exposure flag (§4).
3. Shadow mode (§1 option C) running against real reviews.
4. Simulation for retention (§8) with **mean interval and steady-state daily load** as
   headline outputs, since those decide whether the backlog clears.
5. Bug fixes from §9 alongside Phase 2, since §11/§12 touch the same code.
6. Migration last, informed by the shadow-mode data.
