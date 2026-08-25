# Retention simulation (V3 PR7)

Chooses the two numbers FSRS needs before the scheduler can be swapped:
`request_retention` and `maximum_interval`. Run before PR6, kept so the
decision can be revisited once there is more than two users' worth of data.

## Requires

`ts-fsrs@5.4.1`, which PR6 adds as a real dependency. Until then:

    npm install ts-fsrs@5.4.1

Also needs `reviews.json` in the working directory: every row of
`flashcard_reviews`, paginated with a stable `.order()`.

## The scripts, in the order they matter

**`calibrate.mjs`** — replays every real review sequence through FSRS with its
published parameters and compares what it predicted against what actually
happened. This is the only step that tests FSRS against reality rather than
against itself. Result: 75.9% predicted vs 73.0% observed on 18,372 spaced
reviews, log loss 0.471 against a 0.583 constant-rate baseline. Good enough to
schedule with, and the reason no parameters were fitted.

**`calcurve.mjs`** — turns that comparison into a monotonic correction curve
from "what FSRS believes" to "what students of this deck actually achieved".
FSRS is accurate between 65% and 90% and markedly optimistic below it: where
it predicts 40.6%, students recalled 26.8%. Writes `curve.json`.

**`final.mjs`** — the decision. Simulates a student on a fixed daily time
budget at each candidate target, drawing outcomes through the correction curve
rather than from FSRS's own optimism, and scores the expected number of
card-blanks recalled on exam morning.

**`threshold.mjs`** — the negative result, kept deliberately. An earlier
version scored "cards above 85% recall" and found 0.85 optimal everywhere.
That was circular: FSRS schedules cards to sit at the target, so counting
cards above a threshold is maximised by setting the target to that threshold.
This script demonstrates it — the winning target tracks the scoring threshold
exactly, in every row. Any future metric should be run through this check
before its answer is believed.

## Inputs measured from the log, not assumed

  . 13.6 s per card (mean gap between consecutive in-session reviews, n=38,516)
  . 68% of first exposures rated Again
  . when a card is recalled: Hard 52%, Good 32%, Easy 15%

`final.mjs` conclusions survive moving any of these a long way in either
direction; `sensitivity.mjs` in the scratch workspace covered that.
