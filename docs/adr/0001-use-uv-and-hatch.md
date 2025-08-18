# ADR 0001: Use uv for dependency management and Hatchling for builds

- Status: Accepted
- Date: 2025-08-18

## Context
We need fast, reproducible dependency management and a standards-compliant build backend.

## Decision
Adopt **uv** for dependency and environment management and **Hatchling** for building packages.
Use a `src/` layout and keep version in `src/docchat/__about__.py`.

## Consequences
- Faster installs and CI.
- Single source of truth for versioning.
- Developers need to install uv locally.
