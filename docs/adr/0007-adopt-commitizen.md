# ADR 0007: Adopt Commitizen for Conventional Commits and automated versioning

- Status: Accepted
- Date: 2025-08-19

## Context
Consistent commit messages improve history readability and enable automated semantic versioning and changelog generation. We already store the package version in a single source of truth.

## Decision
- Use **Commitizen** (`cz`) with the **conventional commits** preset.
- Configure in `pyproject.toml`:
  - `version` source: bump `src/docchat/__about__.py` to stay aligned with our build system (see ADR 0001).
  - `changelog` generation enabled; tag format `v<version>`.
- Hook integration:
  - Add `commit-msg` hook via pre-commit: `cz check --commit-msg-file`.
  - Prefer `cz commit` locally to guide messages; `cz bump` in release workflow.
- Enforce in CI: `cz check --rev-range origin/main..HEAD` for PRs.

## Consequences
- Clean history and automated releases.
- Requires contributors to follow the guided flow; slight learning curve for first-time users.
