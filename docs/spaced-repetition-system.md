# Praxist Prep — Spaced Repetition System

A reference for anyone designing a replacement scheduling pattern.
Everything here is measured against the live database on 2026-08-20, not estimated.

---

## 1. The unit being scheduled

Not a card. A **card-blank**.

Cards are admin-authored and come in two shapes:

- `basic` — `front_text` / `back_text`, `cloze_count = 0`
- `cloze` — `cloze_text` using `{{cN::answer::hint}}` syntax, `cloze_count` = number of distinct `cN` groups

A cloze card with 3 groups expands into **3 independent review items**. Item *k* masks
`cN=k` and reveals everything else. Each is scheduled separately.

The scheduling key is therefore `(user_id, flashcard_id, cloze_index)`, where
`cloze_index` is `0` for basic cards and `1..cloze_count` for cloze cards.

Current library: **4,116 cards → 7,253 card-blanks.**

---

## 2. Data model

### `flashcard_user_state` — current state, one row per card-blank
```
PRIMARY KEY (user_id, flashcard_id, cloze_index)   -- NOTE: no `id` column
interval_days   NUMERIC(8,3) DEFAULT 0    -- earned strength, NOT time-to-show
ease_factor     NUMERIC(4,2) DEFAULT 2.5  -- per-card difficulty memory
reps            INTEGER DEFAULT 0         -- lifetime successful reviews
lapses          INTEGER DEFAULT 0
last_rating     TEXT  CHECK IN (again, hard, medium, easy)
last_reviewed_at TIMESTAMPTZ
next_review_at  TIMESTAMPTZ DEFAULT NOW() -- when the card is actually shown
starred         BOOLEAN
suspended       BOOLEAN                   -- pulled from rotation by the user
```

### `flashcard_reviews` — append-only log, one row per review EVENT
```
id, user_id, flashcard_id, cloze_index
rating              TEXT CHECK IN (again, hard, medium, easy)
prev_interval_days  NUMERIC(8,3)
new_interval_days   NUMERIC(8,3)
reviewed_at         TIMESTAMPTZ
```
29,912 rows for the primary user. This is the permanent history and the only
record from which past behaviour can be reconstructed.

Ratings are a **4-button scale**: Again / Hard / Medium / Easy.

---

## 3. The current algorithm (v2, deployed 2026-08-07)

v2's central idea is a **strength/schedule split**:

- `interval_days` = earned strength. Never drops below 1 day once learned. A lapse
  HALVES it rather than zeroing it.
- `next_review_at` = when the card is shown. "Again" re-shows in 10 minutes
  regardless of strength.
- `ease_factor` = per-card memory. Again −0.20 · Hard −0.15 · Medium ±0 · Easy +0.15,
  clamped to [1.30, 2.80], default 2.50.

**Ladder for a learned card (strength `i` ≥ 1, updated ease `e`):**

| Grade | New strength | Shown again in |
|---|---|---|
| Again | `max(1, i × 0.5)` | 10 minutes |
| Hard | `max(i + 1, i × 1.2)`, cap 60d | new strength |
| Medium | `max(i + 1, i × e)`, cap 60d | new strength |
| Easy | `max(i + 1, i × e × 1.3)`, cap 90d | new strength |

First-ever pass seeds **Hard 1d / Medium 3d / Easy 5d**.

**Post-lapse confirmation.** If a learned card's stored `last_rating` is `again`, the
next pass is an echo answered from short-term memory. It keeps its (already halved)
strength and is shown **tomorrow** (Easy: 2 days) rather than resuming full spacing.
Growth resumes at the next-day review.

**Two constants are load-bearing:**
- `HARD_FACTOR = 1.2` must stay strictly **below** `EASE_MIN = 1.3`, or Hard can
  schedule further out than Medium for any card whose ease has drifted low.
- The additive `+1 day` floor guarantees visible progress at small intervals where a
  multiplier alone would round to the same day.

**Caps never claw back strength:** `min(strength, max(CAP, interval_days))`, so a 90d
card graded Medium stays 90d instead of being cut to Medium's 60d cap.

---

## 4. What v1 was, and why it was replaced

In v1, `interval_days` did double duty as both earned strength AND time-to-next-show.
"Again" had to set it to ~10 minutes to schedule the re-show, which **erased the card's
entire history** — the next grade re-seeded from 1/3/5d as if the card were brand new.
At a ~40% Again rate, the odds of the 6–9 consecutive passes needed to reach three
weeks were a few percent, so intervals pinned at the seeds forever.

v2 fixed the mechanism. **The outcome barely moved.** See below.

---

## 5. Measured behaviour (this is the case for a new pattern)

7,253 card-blanks, 29,912 lifetime reviews, one committed daily user.

**Interval distribution — cards are not maturing:**

| Earned strength | Card-blanks | Share |
|---|---|---|
| 10-min sentinel | 165 | 2.3% |
| **exactly 1 day** | **4,124** | **56.9%** |
| 2–3 days | 1,231 | 17.0% |
| 4–7 days | 829 | 11.4% |
| 1–2 weeks | 477 | 6.6% |
| 2–4 weeks | 373 | 5.1% |
| 1–2 months | 54 | 0.7% |
| over 2 months | 0 | 0.0% |

Median interval **1.00 day**. Mean 3.48d. Max 60d. Median `reps` = **1**.

**Rating distribution — the input driving it:**

| Grade | Count | Share |
|---|---|---|
| Again | 11,583 | 38.7% |
| Hard | 12,578 | 42.1% |
| Medium | 5,081 | 17.0% |
| Easy | 670 | 2.2% |

**81% of all grades are Again or Hard.** Mean ease has drifted 2.50 → 2.296.
25% of card-blanks have lapsed at least once.

**The consequence:** 5,522 of 7,253 card-blanks are due right now — a **76% backlog**.
Because the median card returns in one day, the due queue regenerates almost entirely
every day and cannot be cleared. Daily limits (currently 300 new / 600 review) are the
only thing holding it back, and they cap effort, not backlog growth.

**The core design problem for any replacement: cards must be able to mature, given a
real user who grades Again or Hard 81% of the time.** Either the ladder must tolerate
that grading profile, or the grading UX must be changed so the distribution shifts, or
both. A pattern that only works at a 10% lapse rate will fail here exactly as v1 and
v2 did.

---

## 6. Hard invariants any replacement MUST preserve

1. **`prev_interval_days === 0` marks a card's first-ever exposure.** Daily quota
   counting depends on it to split "new" from "review". An unlearned card graded Again
   stores the 10-minute sentinel (~0.007d), never 0, precisely to protect this.
   *Note: 455 log rows already violate this (legacy pre-v2). A migration must decide
   what to do with them.*
2. **`cloze_index` must stay within `1..cloze_count`** (or `0` for basic). Rows outside
   that range are orphans that no session can serve; 16 were found and deleted on
   2026-08-14. Lowering a card's `cloze_count` without deleting the matching state row
   recreates them.
3. **`flashcard_user_state` has no `id` column.** Any paginated read must order by
   `(flashcard_id, cloze_index)` or it will silently drop and double-count rows.
4. **Never re-seed a live deck.** Re-seeding replaces card ids and wipes every user's
   progress. Live card edits are `UPDATE`-by-id only, preserving ids and cloze groups.
5. **The review log is append-only and irreplaceable.** 29,912 rows of real history.
6. **Day boundaries are LOCAL midnight**, not UTC. Deriving a day key from an ISO
   string uses UTC and silently misfiles evening reviews onto the next day.
7. **Migration scale:** 7,253 live state rows must be transformed, not reset. A user
   who has earned a 60-day interval should not be sent back to 1 day.

---

## 7. Known defects in the surrounding system

These are scheduling-adjacent and worth fixing regardless of which pattern is chosen.
Marked by how strongly they are established.

**Verified by direct code reading:**
- **Cram and Starred modes apply no daily cap at all.** `session/page.tsx:259` slices
  to the quota only when `mode === "due"`; the else branch takes the entire pool. Cram
  grades still write identical review and state rows, so they consume the budget on the
  way out while ignoring it on the way in. This produced a 746-review day against a
  600 cap.
- **The limit-reached screen funnels users into that bypass.** It reads "You've hit
  today's limits… nothing's stopping you. Cram mode ignores the daily caps" and offers
  a primary **"Keep going"** button pointing at `?mode=cram`.
- **"Again" costs a tap but not a card.** A card graded Again is re-inserted into the
  queue and graded again, but the daily budget counts unique card-blanks. Real tap
  count runs ~1.3–1.6× the counter, so a user who taps 600 times sees ~330 counted and
  concludes the counter is broken.
- **Per-deck study page has the same hole**: limits apply only when `filter === "due"`;
  "Study all" and "Starred" bypass them.

**Reported by an automated pass but NOT independently verified** (the verification stage
failed on a usage limit, so treat these as leads):
- The remaining allowance is read once at queue construction and never re-checked, so
  two surfaces open at once could each spend the full budget.
- A cram session crossing local midnight pre-charges the next day's allowance.
- Both paging loops treat a query error as end-of-data and truncate silently.
- The analytics page headlines "Total reviews" as raw event count while the daily
  budget counts unique cards — the same word meaning two different quantities.

---

## 8. Where the numbers are shown to the user

Four surfaces report counts, and they do not all mean the same thing:

- **Dashboard hero** — "cards due" = due now + unseen.
- **Flashcards hub** — splits unseen / due / soon (within 3 days) / later, and renders
  the "N left today" button, which is `(newLimit − newToday) + (reviewLimit − reviewsToday)`
  bounded by what actually exists.
- **In-session progress pill** — numerator is unique card-blanks that reached a passing
  grade; denominator is the initial queue length.
- **End-of-session summary** — unique card-blanks passed, which excludes cards graded
  Again and never gotten right. It never mentions the daily budget.

Any new pattern should decide deliberately which quantity the user is shown, and use
the same one everywhere.
