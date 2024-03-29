module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    // "google",
    "plugin:@typescript-eslint/recommended",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: ["tsconfig.json", "tsconfig.dev.json"],
    sourceType: "module",
  },
  ignorePatterns: [
    "/lib/**/*", // Ignore built files.
  ],
  plugins: [
    "@typescript-eslint",
    "import",
  ],
  "overrides": [
    {
      "files": ["**/*"],
      "rules": {
        "@typescript-eslint/no-unused-vars": "off"
      }
    }
  ],
  rules: {
    "quotes": ["error", "double"],
    "require-jsdoc": "off",
    "import/no-unresolved": 0,
  },
};
