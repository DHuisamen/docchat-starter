# Contributing

Thank you for considering a contribution!

## Dev environment

- Install [uv](https://docs.astral.sh/uv/)
- `uv venv && source .venv/bin/activate`
- `uv sync --all-groups`
- `uv run pre-commit install`

## Coding standards

- **src/** layout
- **Type hints** required on public APIs
- **Ruff** for lint & format: `uv run ruff check .` and `uv run ruff format .`
- **Mypy** strict-ish: `uv run mypy .`
- **Tests** with pytest
- **Conventional Commits** via `commitizen` (`feat:`, `fix:`, etc.)

## Running tests

```
uv run pytest
```

## Releasing

- Bump version with commitizen, e.g. `uv run cz bump`
- Push tags; CI will build artifacts
