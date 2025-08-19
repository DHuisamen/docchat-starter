# ADR 0005: Adopt mypy (strict-ish), Pydantic models, and types-requests

- Status: Accepted
- Date: 2025-08-19

## Context
Static typing reduces runtime bugs and clarifies interfaces. The codebase uses FastAPI and external HTTP calls; we want strong typing for request/response models and I/O layers.

## Decision
- Use **mypy** with a strict-leaning config in `pyproject.toml`:
  - `python_version = 3.12`, `strict = True` (or equivalently enable: `warn-unused-ignores`, `disallow-any-generics`, `no_implicit_optional`, `warn-redundant-casts`, `warn-return-any`, `warn-unused-configs`).
  - Allow gradual typing via `[[tool.mypy.overrides]]` for legacy modules; require TODOs with sunset dates.
  - Enable Pydantic plugin: `plugins = ["pydantic.mypy"]`.
- Model all external IO with **Pydantic v2** `BaseModel` classes for validation/serialization.
- Add **types-requests** to supply stubs for the `requests` library used in integrations.
- Encourage `from __future__ import annotations` and `typing_extensions` as needed.
- Enforce in CI: `mypy .` and coverage gates on typed code paths.

## Consequences
- Clear contracts at boundaries; earlier detection of type regressions.
- Some upfront effort annotating functions and fixtures.
- Pydantic validation adds small runtime overhead but improves robustness and error messages.
