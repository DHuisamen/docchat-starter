# DocChat Starter — Pre-coding Setup

Turnkey scaffolding for a robust Python project using **src/** layout, **uv** for dependency management, **Hatchling** build backend, single-source-of-truth versioning, strict linters, CI, and release hygiene.

This repo is the *setup* foundation for the DocChat Starter Kit (FastAPI + LangChain). It contains no app code yet — only everything that prevents regressions later.

## Quickstart

```bash
# 1) Install uv (https://docs.astral.sh/uv/)
# macOS/Linux:
curl -LsSf https://astral.sh/uv/install.sh | sh
# Windows (PowerShell):
iwr https://astral.sh/uv/install.ps1 -UseBasicParsing | iex

# 2) Create and activate a local venv
uv venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate

# 3) Sync dependencies (prod + dev)
uv sync --all-groups

# 4) Install pre-commit hooks
uv run pre-commit install

# 5) Run the quality gates
uv run ruff check .
uv run ruff format --check .
uv run mypy .
uv run pytest
```

## What’s included

- **src/** layout for import hygiene
- **uv** for fast, reproducible dependency management
- **Hatchling** build backend
- **Single source of truth** for version in `src/docchat/__about__.py`
- **Ruff** (lint + format) — Black not required
- **Mypy** strict-ish typing
- **Pytest** with `pytest.ini` config
- **Pre-commit** hooks (ruff, mypy, pyproject-fmt, commitizen, whitespace)
- **Conventional Commits** (commitizen) + changelog discipline
- **GitHub Actions** CI: lint, type-check, test, build
- **Dockerfile** + `docker-compose.yml` (dev bootstrap)
- **.editorconfig**, `.gitignore`, `.env.example`
- **Docs**: CONTRIBUTING, SECURITY, CHANGELOG, ADR template
- **Devcontainer** for consistent editor environment

## Next steps

- Rename the package (if desired) by changing `docchat` occurrences.
- Start coding in `src/docchat/`.
- Replace placeholders in `CODEOWNERS` and `CONTRIBUTING.md`.
