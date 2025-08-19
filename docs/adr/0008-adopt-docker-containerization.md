# ADR 0008: Containerize the app with Docker (multi-stage)

- Status: Accepted
- Date: 2025-08-19

## Context
We want reproducible builds and a minimal production runtime image. Prior builds required copying license files and manual steps that risk drift across environments.

## Decision
- Use a **multi-stage Dockerfile**:
  - **builder stage**: Python slim base, install **uv**, copy `pyproject.toml` and lockfile, perform `uv sync --frozen`, run tests and type checks optionally.
  - **runtime stage**: Python slim/distroless base; copy only app, dependencies, and required metadata (including `LICENSE` to satisfy dependencies). Run as non-root user.
- Entrypoint: `uvicorn app.main:app --host 0.0.0.0 --port 8000` (production flags in ADR 0009).
- Add a `HEALTHCHECK` hitting `/health` endpoint.
- Provide `docker-compose.yml` (optional) for local dev with env files and volume mounts.

## Consequences
- Reproducible, cache-friendly builds; smaller attack surface.
- Slight complexity in Dockerfile; local dev still prefers `uv run` for speed.
- Need to keep health endpoint stable for orchestrators.
