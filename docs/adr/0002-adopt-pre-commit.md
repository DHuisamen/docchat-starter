# ADR 0002: Adopt pre-commit for local and CI checks

- Status: Accepted
- Date: 2025-08-19

## Context
We want fast, repeatable code-quality checks that run before changes enter the repository. Relying on contributors to remember linting, formatting, and security scans is error-prone and leads to regressions.

## Decision
Use **pre-commit** to manage and run hooks locally and in CI.
- Install via `uv tool install pre-commit` and include `.pre-commit-config.yaml` in the repo.
- Enable hooks:
  - `ruff` (lint + `ruff format`), `pyproject-fmt` for config normalization.
  - Base hygiene: `trailing-whitespace`, `end-of-file-fixer`, `check-merge-conflict`, `check-yaml`, `check-toml`.
  - Optional: `detect-private-key`, `check-added-large-files`.
- Run `pre-commit install` and `pre-commit install --hook-type commit-msg` (for Commitizen check, see ADR 0007).
- In CI, run `pre-commit run --all-files` to enforce parity with local results.

## Consequences
- Fewer style & formatting diffs; faster feedback near the developer.
- Slight friction at commit time (hooks run), but overall saves time by catching issues early.
- CI remains consistent with local checks.
