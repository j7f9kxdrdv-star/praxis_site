// A small in-memory stand-in for the Supabase query builder, for tests only.
//
// It supports exactly the calls the flashcard pages make: from().select()
// .eq() .in() .order() .range() .limit(), awaited directly. Rows are returned
// as stored (column lists are not projected). A test can make any request fail
// or wait, to exercise error handling and requests that finish out of order.

export type Row = Record<string, unknown>;

export interface FakeQuery {
  table: string;
  eqs: [string, unknown][];
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
    const q: FakeQuery = { table, eqs: [], ins: [], orders: [], range: null, limit: null };
    async function run() {
      calls.push(q);
      if (opts.delay) await opts.delay(q);
      if (opts.fail?.(q)) return { data: null, error: { message: `simulated failure reading ${table}` } };
      let rows = (tables[table] ?? []).filter(
        (r) => q.eqs.every(([c, v]) => r[c] === v) && q.ins.every(([c, vs]) => vs.includes(r[c])),
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
      if (q.range) rows = rows.slice(q.range[0], q.range[1] + 1);
      if (q.limit !== null) rows = rows.slice(0, q.limit);
      return { data: rows.map((r) => ({ ...r })), error: null };
    }
    const builder = {
      select: () => builder,
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
