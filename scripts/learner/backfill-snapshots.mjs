/*
 * Rebuild every historical learner snapshot, and the events between them.
 *
 *   node scripts/learner/backfill-snapshots.mjs            # every student
 *   node scripts/learner/backfill-snapshots.mjs --email x  # one student
 *   node scripts/learner/backfill-snapshots.mjs --dry-run  # report, write nothing
 *
 * SAFE TO RERUN. Snapshots are keyed on (user_id, study_day) and events on
 * (user_id, dedupe_key), so a second run overwrites the same rows rather than
 * appending. That is also what makes it resumable: a run that dies halfway can
 * simply be started again.
 *
 * THE CUTOFF IS THE WHOLE POINT. Each day is rebuilt from the attempts made on
 * or before that study day's end and from nothing later. Leaking a future
 * attempt into an earlier snapshot would not just make that day wrong, it would
 * erase the transition, because the diff to the next day would show nothing
 * happening. lib/learner/backfill.ts owns that rule and is tested on it.
 *
 * Runs with the service role, so it writes past row-level security. Nothing
 * here reads or writes raw behavioural data: question_attempts, flashcard
 * reviews and the rest are only ever SELECTed.
 */
import { createClient } from "@supabase/supabase-js";
import fs from "fs";
import path from "path";
import { pathToFileURL } from "url";
import { register } from "node:module";

// The learner model is TypeScript; register the loader that resolves "@/" and
// adds the extensions TypeScript lets you omit.
const HERE = path.dirname(new URL(import.meta.url).pathname);
const ROOT = path.resolve(HERE, "../..");
register(pathToFileURL(path.join(HERE, "ts-loader.mjs")).href, pathToFileURL(HERE + "/"));

const { backfill, studyDaysFrom } = await import(`${ROOT}/lib/learner/backfill.ts`);

const args = process.argv.slice(2);
const arg = (n) => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : null; };
const DRY = args.includes("--dry-run");
const onlyEmail = arg("--email");

const env = Object.fromEntries(
  fs.readFileSync(path.join(ROOT, ".env.local"), "utf8").split("\n")
    .filter((l) => l.includes("=") && !l.trim().startsWith("#"))
    .map((l) => [l.slice(0, l.indexOf("=")).trim(), l.slice(l.indexOf("=") + 1).trim()]),
);
const db = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);

/** Page a table fully; a .range() loop without a stable .order() skips rows. */
async function pageAll(table, select, order, filter) {
  const out = [];
  for (let from = 0; ; from += 1000) {
    let q = db.from(table).select(select);
    if (filter) q = filter(q);
    for (const col of order) q = q.order(col, { ascending: true });
    const { data, error } = await q.range(from, from + 999);
    if (error) throw new Error(`${table}: ${error.message}`);
    if (!data.length) break;
    out.push(...data);
    if (data.length < 1000) break;
  }
  return out;
}

const questions = await pageAll("questions", "id, section, topic", ["id"]);
const byId = new Map(questions.map((q) => [q.id, q]));
console.log(`question bank: ${questions.length}\n`);

const { data: profiles } = await db
  .from("profiles")
  .select("id, first_name, email, day_start_hour");

let totalSnapshots = 0, totalEvents = 0, skipped = 0;

for (const p of profiles) {
  if (onlyEmail && p.email !== onlyEmail) continue;

  const raw = await pageAll(
    "question_attempts",
    "question_id, is_correct, created_at, is_first_attempt",
    ["created_at", "id"],
    (q) => q.eq("user_id", p.id),
  );
  if (raw.length === 0) { skipped++; continue; }

  const attempts = raw
    .map((a) => ({
      questionId: a.question_id,
      topic: byId.get(a.question_id)?.topic ?? null,
      section: byId.get(a.question_id)?.section ?? "unknown",
      isCorrect: a.is_correct,
      createdAt: a.created_at,
      isFirstAttempt: a.is_first_attempt,
    }))
    .filter((a) => byId.has(a.questionId));

  const dayStartHour = p.day_start_hour ?? 4;
  const studyDays = studyDaysFrom(attempts, dayStartHour);
  const { snapshots, events } = backfill({
    attempts,
    studyDays,
    totalQuestions: questions.length,
    dayStartHour,
  });

  const name = (p.first_name ?? p.email ?? "?").padEnd(10);
  console.log(
    `${name} ${String(attempts.length).padStart(5)} attempts  ` +
    `${String(studyDays.length).padStart(3)} study days  ` +
    `${String(snapshots.length).padStart(3)} snapshots  ` +
    `${String(events.length).padStart(3)} events` +
    (DRY ? "   (dry run)" : ""),
  );

  if (DRY) { totalSnapshots += snapshots.length; totalEvents += events.length; continue; }

  // ── Clear this student's derived events first ─────────────────────────
  //
  // Upserting alone is not enough after a calibration change. The new
  // thresholds produce a DIFFERENT set of events, and any event the old model
  // emitted that the new one does not would simply survive, because nothing
  // collides with it. The counts would then be a mixture of two models.
  //
  // Deleting derived rows is safe in a way that deleting raw rows never is:
  // events are a pure function of the snapshots, which are a pure function of
  // question_attempts. Nothing here reads or writes behavioural data, and this
  // run rebuilds every day the student has, so the delete is always followed by
  // a complete rewrite.
  const { error: clearErr } = await db
    .from("learner_events")
    .delete()
    .eq("user_id", p.id);
  if (clearErr) { console.error(`  could not clear old events: ${clearErr.message}`); continue; }

  // Upsert in batches. On conflict the row is replaced, which is what makes a
  // rerun a no-op rather than a duplicate.
  for (let i = 0; i < snapshots.length; i += 100) {
    const batch = snapshots.slice(i, i + 100).map((s) => ({
      user_id: p.id,
      study_day: s.studyDay,
      state: s,
      calculation_version: s.version,
    }));
    const { error } = await db
      .from("learner_state_snapshots")
      .upsert(batch, { onConflict: "user_id,study_day" });
    if (error) { console.error(`  snapshot upsert failed: ${error.message}`); break; }
  }

  for (let i = 0; i < events.length; i += 100) {
    const batch = events.slice(i, i + 100).map((e) => ({
      user_id: p.id,
      type: e.type,
      occurred_on: e.occurredOn,
      subject_kind: e.subjectKind,
      subject_id: e.subjectId,
      previous_value: e.previousValue,
      new_value: e.newValue,
      metadata: e.metadata,
      calculation_version: e.calculationVersion,
      dedupe_key: e.dedupeKey,
    }));
    const { error } = await db
      .from("learner_events")
      .upsert(batch, { onConflict: "user_id,dedupe_key" });
    if (error) { console.error(`  event upsert failed: ${error.message}`); break; }
  }

  totalSnapshots += snapshots.length;
  totalEvents += events.length;
}

console.log(
  `\n${DRY ? "would write" : "wrote"} ${totalSnapshots} snapshots and ${totalEvents} events` +
  `${skipped ? `; ${skipped} student(s) had no attempts and were skipped` : ""}`,
);
