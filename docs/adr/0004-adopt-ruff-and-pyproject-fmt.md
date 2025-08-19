# ADR 0004: Use Ruff for linting/formatting and pyproject-fmt for config hygiene

- Status: Accepted
- Date: 2025-08-19

## Context
We need a fast, consistent style/lint toolchain that works well in hooks and CI without heavy dependencies.

## Decision
- Adopt **Ruff** for both linting (`ruff check`) and code formatting (`ruff format`).
- Configure in `pyproject.toml`:
  - `target-version = "py312"`; enable rulesets: `E`, `F`, `I`, `UP`, `B`, and `RUF` selectively.
  - Exclude build artifacts and virtualenvs; set `line-length = 100`.
  - Use `extend-ignore` only when justified and documented.
- Adopt **pyproject-fmt** to normalize `pyproject.toml` (key ordering, compact arrays, PEP 621 fields).
- Wire both into pre-commit (see ADR 0002).

## Consequences
- Extremely fast feedback loop; fewer tool conflicts (no separate Black + isort needed).
- Some auto-fixes may differ from prior style; minor one-time churn when enabling.
- pyproject becomes canonical and consistently formatted, easing reviews.
