/**
 * Reset the signed-in account's study progress.
 *
 * GET  returns what a reset would destroy, counted live for the caller.
 * POST performs it, and returns what is left afterwards.
 *
 * THE ACCOUNT BEING RESET IS NEVER TAKEN FROM THE REQUEST. It comes from
 * auth.getUser() against the caller's own bearer token, and there is no code
 * path here that reads an id from a body, a query string or a header. A caller
 * cannot ask this endpoint to reset somebody else, because there is nowhere to
 * say who.
 *
 * WHY THE SERVICE ROLE, given the identity is already verified. Row-level
 * security carries DELETE policies on only three of the twelve tables involved,
 * so running these deletes as the user would clear study_plan_tasks,
 * review_schedule and flashcard_user_state and silently leave the other nine
 * behind. A reset that reports success while thousands of reviews survive is
 * the worst outcome available: the student is told the deck is new, and it then
 * serves reviews from a history they were told was gone. So the deletes run
 * privileged and every single one is scoped with .eq("user_id", userId).
 *
 * AND THE ANSWER IS CHECKED. After deleting, the same counts are taken again
 * and returned. If anything survived, the response says so and reports
 * ok: false rather than letting the UI claim a clean reset. A silent partial
 * reset cannot happen without the caller being told.
 */
import { NextRequest, NextResponse } from "next/server";
import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import {
  USER_DATA_TABLES,
  profilePatchFor,
  isResetScope,
  type ResetScope,
} from "@/lib/account/resetScope";

/** Typed exactly so a mis-typed confirmation cannot be coerced into a match. */
const CONFIRM_PHRASE = "RESET";

type Counts = Record<string, number>;

async function countAll(db: SupabaseClient, userId: string): Promise<Counts> {
  const out: Counts = {};
  await Promise.all(
    USER_DATA_TABLES.map(async (table) => {
      const { count, error } = await db
        .from(table)
        .select("*", { count: "exact", head: true })
        .eq("user_id", userId);
      // A table that cannot be counted is reported as unknown rather than zero;
      // zero would read as "nothing to delete here" and hide a real problem.
      out[table] = error ? -1 : (count ?? 0);
    }),
  );
  return out;
}

/** Identity from the caller's own token, or a 401. */
async function requireUser(req: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !anonKey) {
    return { error: NextResponse.json({ error: "Server is not configured." }, { status: 500 }) };
  }
  const authHeader = req.headers.get("authorization") ?? "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : "";
  if (!token) {
    return { error: NextResponse.json({ error: "Not signed in." }, { status: 401 }) };
  }
  const asUser = createClient(url, anonKey, {
    global: { headers: { Authorization: `Bearer ${token}` } },
    auth: { persistSession: false, autoRefreshToken: false },
  });
  const { data, error } = await asUser.auth.getUser();
  if (error || !data?.user) {
    return { error: NextResponse.json({ error: "Not signed in." }, { status: 401 }) };
  }
  return { userId: data.user.id, asUser };
}

function serviceClient() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !serviceRoleKey) return null;
  return createClient(url, serviceRoleKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}

export async function GET(req: NextRequest) {
  const auth = await requireUser(req);
  if ("error" in auth) return auth.error;

  const db = serviceClient();
  if (!db) {
    return NextResponse.json({ error: "Server is not configured." }, { status: 500 });
  }

  const counts = await countAll(db, auth.userId);
  const total = Object.values(counts).reduce((a, b) => a + Math.max(0, b), 0);
  return NextResponse.json({ counts, total });
}

export async function POST(req: NextRequest) {
  const auth = await requireUser(req);
  if ("error" in auth) return auth.error;

  let body: { scope?: unknown; confirm?: unknown };
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "Expected a JSON body." }, { status: 400 });
  }

  if (!isResetScope(body.scope)) {
    return NextResponse.json(
      { error: "Unknown reset scope." },
      { status: 400 },
    );
  }
  const scope: ResetScope = body.scope;

  // Typed confirmation, checked server-side. A client that skipped its own
  // dialog still cannot reset an account by accident.
  if (body.confirm !== CONFIRM_PHRASE) {
    return NextResponse.json(
      { error: `Type ${CONFIRM_PHRASE} to confirm.` },
      { status: 400 },
    );
  }

  const db = serviceClient();
  if (!db) {
    return NextResponse.json({ error: "Server is not configured." }, { status: 500 });
  }

  const before = await countAll(db, auth.userId);

  // Sequential and in the declared order: history, then the state derived from
  // it, then what analytics inferred. Failing loudly on the first error beats
  // continuing and reporting a reset that half happened.
  for (const table of USER_DATA_TABLES) {
    const { error } = await db.from(table).delete().eq("user_id", auth.userId);
    if (error) {
      const after = await countAll(db, auth.userId);
      return NextResponse.json(
        { ok: false, failedTable: table, error: error.message, before, after },
        { status: 500 },
      );
    }
  }

  const patch = profilePatchFor(scope);
  if (patch) {
    const { error } = await db
      .from("profiles")
      .update({ ...patch, updated_at: new Date().toISOString() })
      .eq("id", auth.userId);
    if (error) {
      return NextResponse.json(
        { ok: false, failedTable: "profiles", error: error.message, before },
        { status: 500 },
      );
    }
  }

  // Prove it rather than assume it.
  const after = await countAll(db, auth.userId);
  const survivors = Object.entries(after).filter(([, n]) => n !== 0);
  if (survivors.length > 0) {
    return NextResponse.json(
      {
        ok: false,
        error: "Some data could not be cleared.",
        survivors: Object.fromEntries(survivors),
        before,
        after,
      },
      { status: 500 },
    );
  }

  const deleted = Object.values(before).reduce((a, b) => a + Math.max(0, b), 0);
  return NextResponse.json({ ok: true, scope, deleted, before, after });
}
