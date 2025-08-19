# ADR 0006: Standardize on pytest for testing

- Status: Accepted
- Date: 2025-08-19

## Context
We need reliable, readable tests for both sync and async code (FastAPI endpoints, service layers).

## Decision
- Use **pytest** with:
  - `pytest-asyncio` for async tests.
  - `pytest-cov` for coverage reporting; minimum threshold (e.g., 85%) enforced in CI.
  - Optional: `pytest-xdist` for parallelization on CI.
- Conventions:
  - Tests live in `tests/` mirroring `src/` structure; file pattern `test_*.py`.
  - Use `@pytest.mark.asyncio` for async tests.
  - FastAPI: use `httpx.AsyncClient` with the ASGI app for integration tests.
  - Keep fixtures small, composable; prefer `autouse` only for cross-cutting concerns.
- CI: `pytest --maxfail=1 --disable-warnings -q` and a separate coverage job for reporting.

## Consequences
- Consistent testing story across layers.
- Slight CI time increase with coverage; mitigated via xdist and targeted integration tests.
