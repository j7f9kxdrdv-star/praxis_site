import { defineConfig } from "vitest/config";
import path from "path";

// The app's "@/" alias, so tests import modules the same way the app does.
export default defineConfig({
  resolve: { alias: { "@": path.resolve(__dirname, ".") } },
  test: { include: ["lib/**/*.test.ts"], environment: "node" },
});
