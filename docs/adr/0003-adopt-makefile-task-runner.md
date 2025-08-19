# ADR 0003: Standardize developer tasks via Makefile

- Status: Accepted
- Date: 2025-08-19

## Context
Common tasks (install, lint, format, test, type-check, run, build) are scattered across tools. A simple, cross-platform entrypoint reduces onboarding time and mistakes.

## Decision
Provide a **Makefile** as a thin task runner:
- `.DEFAULT_GOAL := help`; self-documented `help` target using annotated comments.
- Key targets (invoke via `make <target>`):
  - `setup` — create/refresh the uv environment and pre-commit hooks.
  - `lint` — `ruff check .` and configuration validation.
  - `format` — `ruff format .` and `pyproject-fmt --unsafe`.
  - `typecheck` — `mypy .` (with Pydantic plugin).
  - `test` — `pytest -q --maxfail=1` (see ADR 0006).
  - `cov` — `pytest --cov=src --cov-report=term-missing`.
  - `run` — `uv run uvicorn app.main:app --reload` (dev) or `ENV=prod` (see ADR 0009).
  - `build` — `uv build` (Hatchling backend; see ADR 0001).
  - `docker-build` / `docker-run` — convenience wrappers (see ADR 0008).
  - `clean` — remove build caches and `.pytest_cache`.
- Prefer running tools through `uv run` to ensure the pinned environment.

## Consequences
- Single, memorable interface for contributors.
- Make is ubiquitous; Windows users may need `make` from Git Bash or similar.
- Centralized targets reduce duplicated CI config.
