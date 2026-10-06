# OpsPilot

**Division:** RallTheory Products
**Chapters:** 10
**Stack:** Node.js

## Description

OpsPilot is an internal DevOps dashboard by RallTheory Products. It demonstrates infrastructure as code, pipeline maintenance, caching, retention, and classic-to-YAML migration.

## Lab starting state

This directory is a scaffold, not an installed Node application. Follow [Lab 10](../../../../ch10/ch10_Lab_Guide.md) to create the Node.js 22 source, Jest test, package manifest/lock, Bicep definition, and pipeline files.

After completing the source-creation steps:

```bash
cd RallTheoryGroup/src/products/opspilot/src
npm ci
npm run check
npm test
npm start
```

The commands above assume the book repository root as their starting directory. The syntax check is not a full linter. The lab test uses an ephemeral port and closes its own server; stop the interactive `npm start` with Ctrl+C.

The Bicep exercise creates an App Service environment only when deliberately run with authorized Azure access. A B1 plan incurs charges until deleted; it is not needed for local tests. Workflows belong at the Git repository root. See the guide for evidence, permissions, expected results, cleanup, and **VALIDATION REQUIRED** procedures.
