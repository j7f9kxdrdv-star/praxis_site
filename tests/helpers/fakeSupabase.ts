// A small in-memory stand-in for the Supabase query builder, for tests only.
//
// It supports the calls the flashcard pages and the dashboard make: from()
// .select() .eq() .in() .gte() .lte() .gt() .lt() .neq() .is() .order()
// .range() .limit() .single() .maybeSingle(), awaited directly. Rows are returned
// as stored (column lists are not projected). A test can make any request fail
// or wait, to exercise error handling and requests that finish out of order.

export type Row = Record<string, unknown>;

export interface FakeQuery {
  table: string;
  eqs: [string, unknown][];
  /** Comparisons other than equality: [column, operator, value]. */
  cmps: [string, "gte" | "lte" | "gt" | "lt" | "neq" | "is", unknown][];
  /** select(..., { count: "exact", head: true }) asks for a count only. */
  countOnly: boolean;
  single: "single" | "maybeSingle" | null;
  ins: [string, unknown[]][];
  orders: [string, boolean][];
  range: [number, number] | null;
  limit: number | null;
}

export interface FakeOptions {
  /** Return true to make this request fail with an error. */
  fail?: (q: FakeQuery) => boolean;
  /** Await this before answering, to control timing. */
  delay?: (q: FakeQuery) => Promise<void> | void;
}

export function fakeSupabase(tables: Record<string, Row[]>, opts: FakeOptions = {}) {
  const calls: FakeQuery[] = [];

  function from(table: string) {
    const q: FakeQuery = { table, eqs: [], cmps: [], countOnly: false, single: null, ins: [], orders: [], range: null, limit: null };
    async function run() {
      calls.push(q);
      if (opts.delay) await opts.delay(q);
      if (opts.fail?.(q)) return { data: null, error: { message: `simulated failure reading ${table}` } };
      const cmp = (x: unknown, op: string, v: unknown) => {
        const a = x as string | number, b = v as string | number;
        if (op === "is") return (x ?? null) === v;
        if (op === "neq") return x !== v;
        if (x === null || x === undefined) return false;
        return op === "gte" ? a >= b : op === "lte" ? a <= b : op === "gt" ? a > b : a < b;
      };
      let rows = (tables[table] ?? []).filter(
        (r) =>
          q.eqs.every(([c, v]) => r[c] === v) &&
          q.ins.every(([c, vs]) => vs.includes(r[c])) &&
          q.cmps.every(([c, op, v]) => cmp(r[c], op, v)),
      );
      if (q.orders.length > 0) {
        rows = [...rows].sort((a, b) => {
          for (const [c, asc] of q.orders) {
            const x = a[c] as string | number;
            const y = b[c] as string | number;
            if (x < y) return asc ? -1 : 1;
            if (x > y) return asc ? 1 : -1;
          }
          return 0;
        });
      }
      if (q.countOnly) return { data: null, count: rows.length, error: null };
      if (q.range) rows = rows.slice(q.range[0], q.range[1] + 1);
      if (q.limit !== null) rows = rows.slice(0, q.limit);
      if (q.single) {
        if (rows.length === 0 && q.single === "maybeSingle") return { data: null, error: null };
        if (rows.length !== 1) return { data: null, error: { message: `expected one row from ${table}, got ${rows.length}` } };
        return { data: { ...rows[0] }, error: null };
      }
      return { data: rows.map((r) => ({ ...r })), count: rows.length, error: null };
    }
    const builder = {
      select: (_cols?: string, o?: { count?: string; head?: boolean }) => ((q.countOnly = !!o?.head), builder),
      gte: (c: string, v: unknown) => (q.cmps.push([c, "gte", v]), builder),
      lte: (c: string, v: unknown) => (q.cmps.push([c, "lte", v]), builder),
      gt: (c: string, v: unknown) => (q.cmps.push([c, "gt", v]), builder),
      lt: (c: string, v: unknown) => (q.cmps.push([c, "lt", v]), builder),
      neq: (c: string, v: unknown) => (q.cmps.push([c, "neq", v]), builder),
      is: (c: string, v: unknown) => (q.cmps.push([c, "is", v]), builder),
      single: () => ((q.single = "single"), builder),
      maybeSingle: () => ((q.single = "maybeSingle"), builder),
      eq: (c: string, v: unknown) => (q.eqs.push([c, v]), builder),
      in: (c: string, vs: unknown[]) => (q.ins.push([c, vs]), builder),
      order: (c: string, o?: { ascending?: boolean }) => (q.orders.push([c, o?.ascending !== false]), builder),
      range: (a: number, b: number) => ((q.range = [a, b]), builder),
      limit: (n: number) => ((q.limit = n), builder),
      then: <T>(resolve: (v: Awaited<ReturnType<typeof run>>) => T, reject?: (e: unknown) => T) =>
        run().then(resolve, reject),
    };
    return builder;
  }

  return { from, calls };
}

/** A deferred promise, for holding a request open until the test releases it. */
export function deferred() {
  let release!: () => void;
  const promise = new Promise<void>((r) => (release = r));
  return { promise, release };
}
