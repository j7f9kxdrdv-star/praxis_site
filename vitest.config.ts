import { defineConfig } from "vitest/config";
import path from "path";

// The app's "@/" alias, so tests import modules the same way the app does.
export default defineConfig({
  resolve: { alias: { "@": path.resolve(__dirname, ".") } },
  // Page-level tests live in tests/ and opt into a browser-like DOM per file
  // with `// @vitest-environment jsdom`; everything else stays in node.
  test: { include: ["lib/**/*.test.ts", "tests/**/*.test.ts", "tests/**/*.test.tsx"], environment: "node" },
});
