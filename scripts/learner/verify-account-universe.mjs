/*
 * Verify the account universe.
 *
 *   node scripts/learner/verify-account-universe.mjs
 *
 * THE INVARIANT: auth.users is the canonical account universe, and every auth
 * user has exactly one profile carrying the metadata runtime systems need.
 * After the legacy repair, an auth user without a profile is an INTEGRITY
 * FAILURE, not a kind of account.
 *
 * WHY THIS IS A SCRIPT AND NOT A UNIT TEST. It needs the GoTrue admin API,
 * which needs the service-role key, which CI does not have. This is a trusted
 * live operational check, run by hand or by an operator job, and that
 * limitation is deliberate rather than an oversight: a unit test that counted
 * only profiles would pass forever while the thing it claims to check — that
 * profiles and auth agree — was false. It was false for six months.
 *
 * READ-ONLY. It writes nothing.
 */
import { createClient } from "@supabase/supabase-js";
import fs from "node:fs";

const env = fs.readFileSync(".env.local", "utf8");
const g = (k) => (env.match(new RegExp("^" + k + "=(.*)$", "m")) || [])[1]?.trim();
const db = createClient(g("NEXT_PUBLIC_SUPABASE_URL"), g("SUPABASE_SERVICE_ROLE_KEY"),
  { auth: { persistSession: false, autoRefreshToken: false } });

const KINDS = ["STUDENT", "DEMO", "INTERNAL"];
const PAGE = 200;
let pass = 0, fail = 0;
const ok = (label, good, detail = "") => {
  good ? pass++ : fail++;
  console.log(`  ${good ? "ok  " : "FAIL"}  ${label}${detail ? "   " + detail : ""}`);
};

// ── The universe, paged ────────────────────────────────────────────────────
const seen = new Map();
let pages = 0;
for (let page = 1; ; page++) {
  const { data, error } = await db.auth.admin.listUsers({ page, perPage: PAGE });
  if (error) { console.error(`FATAL: listing auth users: ${error.message}`); process.exit(1); }
  pages++;
  for (const u of data.users) if (!seen.has(u.id)) seen.set(u.id, u);
  if (data.users.length < PAGE) break;
  if (page >= 500) { console.error("FATAL: the admin API never returned a short page"); process.exit(1); }
}
const users = [...seen.values()];

const profiles = [];
for (let from = 0; ; from += 1000) {
  const { data, error } = await db.from("profiles")
    .select("id, email, account_kind, day_start_hour").order("id").range(from, from + 999);
  if (error) { console.error(`FATAL: loading profiles: ${error.message}`); process.exit(1); }
  if (!data.length) break;
  profiles.push(...data);
  if (data.length < 1000) break;
}
const byId = new Map(profiles.map((p) => [p.id, p]));

console.log(`ACCOUNT UNIVERSE   ${users.length} auth user(s) over ${pages} page(s), ${profiles.length} profile(s)\n`);

// ── The reconciliation ─────────────────────────────────────────────────────
const noProfile = users.filter((u) => !byId.has(u.id));
ok("every auth user has a profile", noProfile.length === 0,
  noProfile.length ? noProfile.map((u) => `${u.id} (${u.email})`).join(", ") : `${users.length} of ${users.length}`);

const authIds = new Set(users.map((u) => u.id));
const orphans = profiles.filter((p) => !authIds.has(p.id));
ok("every profile has an auth user", orphans.length === 0,
  orphans.length ? orphans.map((p) => p.id).join(", ") : `${profiles.length} of ${profiles.length}`);

ok("exactly one profile per auth user", profiles.length === new Set(profiles.map((p) => p.id)).size);
ok("the two counts agree", users.length === profiles.length, `${users.length} auth, ${profiles.length} profiles`);

// ── The metadata runtime needs ─────────────────────────────────────────────
const noKind = profiles.filter((p) => p.account_kind == null);
ok("every profile has an account_kind", noKind.length === 0, noKind.map((p) => p.id).join(", "));

const badKind = profiles.filter((p) => p.account_kind != null && !KINDS.includes(p.account_kind));
ok("every account_kind is a known kind", badKind.length === 0,
  badKind.map((p) => `${p.id}=${p.account_kind}`).join(", "));

// `== null` on purpose: day_start_hour 0 is midnight, a real value, and a
// falsy check would hold that account back for having a valid setting.
const noHour = profiles.filter((p) => p.day_start_hour == null);
ok("every profile has a day_start_hour", noHour.length === 0, noHour.map((p) => p.id).join(", "));

const badHour = profiles.filter((p) => p.day_start_hour != null && (p.day_start_hour < 0 || p.day_start_hour > 23));
ok("every day_start_hour is a real hour", badHour.length === 0,
  badHour.map((p) => `${p.id}=${p.day_start_hour}`).join(", "));

// ── What the universe looks like ───────────────────────────────────────────
const kinds = profiles.reduce((a, p) => ((a[p.account_kind] = (a[p.account_kind] || 0) + 1), a), {});
console.log(`\n  account kinds: ${Object.entries(kinds).map(([k, v]) => `${k} ${v}`).join(", ")}`);

const { count: states } = await db.from("learner_concept_states")
  .select("user_id", { count: "exact", head: true });
const rows = [];
for (let from = 0; ; from += 1000) {
  const { data } = await db.from("learner_concept_states").select("user_id, model_version")
    .order("concept_id").range(from, from + 999);
  if (!data?.length) break;
  rows.push(...data);
  if (data.length < 1000) break;
}
const perUser = rows.reduce((a, r) => ((a[r.user_id] = (a[r.user_id] || 0) + 1), a), {});
console.log(`  learner_concept_states: ${states} row(s) across ${Object.keys(perUser).length} account(s)`);
const versions = [...new Set(rows.map((r) => r.model_version))];
ok("concept states carry at most one model version", versions.length <= 1, versions.join(", ") || "none");

const stray = Object.keys(perUser).filter((u) => !authIds.has(u));
ok("no concept state belongs to a non-existent account", stray.length === 0, stray.join(", "));

console.log("\n" + (fail
  ? `${fail} INTEGRITY FAILURE(S), ${pass} passed`
  : `all ${pass} checks pass — every auth user is an account`));
process.exit(fail ? 1 : 0);
