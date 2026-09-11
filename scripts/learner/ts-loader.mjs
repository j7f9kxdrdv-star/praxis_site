// Lets the backfill runner import the app's TypeScript learner model: resolves
// the "@/" alias and adds the extension TypeScript allows you to omit.
// Type stripping itself comes from node's --experimental-strip-types.
import { pathToFileURL, fileURLToPath } from "url";
import fs from "fs";
import path from "path";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../..") + "/";

const withExt = (p) => {
  if (fs.existsSync(p) && fs.statSync(p).isFile()) return p;
  for (const ext of [".ts", ".tsx", "/index.ts"]) if (fs.existsSync(p + ext)) return p + ext;
  return p;
};

export function resolve(specifier, context, next) {
  if (specifier.startsWith("@/")) {
    return next(pathToFileURL(withExt(ROOT + specifier.slice(2))).href, context);
  }
  if (specifier.startsWith("./") || specifier.startsWith("../")) {
    try {
      const base = fileURLToPath(new URL(".", context.parentURL));
      const resolved = withExt(path.resolve(base, specifier));
      if (fs.existsSync(resolved)) return next(pathToFileURL(resolved).href, context);
    } catch { /* fall through to the default resolver */ }
  }
  return next(specifier, context);
}
