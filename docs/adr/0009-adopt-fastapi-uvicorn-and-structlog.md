# ADR 0009: FastAPI + Uvicorn + structlog for API and logging

- Status: Accepted
- Date: 2025-08-19

## Context
We need a fast Python web framework with first-class typing and pydantic model integration, an efficient ASGI server, and structured logs that play well in containers and observability stacks.

## Decision
- Framework: **FastAPI** (async-first, pydantic v2 models, OpenAPI auto-docs).
- Server: **Uvicorn** as the ASGI server.
  - Dev: `uvicorn app.main:app --reload`.
  - Prod: `uvicorn app.main:app --workers $UVICORN_WORKERS --host 0.0.0.0 --port 8000`.
  - Surface readiness via `/health` and optional `/ready` endpoints.
- Logging: **structlog** configured for JSON output.
  - Configure processors for timestamp, log level, event, exception info, and request context (method, path, status, latency, request_id).
  - Bridge `uvicorn`, `uvicorn.access`, and `fastapi` loggers to structlog to avoid duplicate formatting.
  - Include correlation-id middleware (e.g., read `X-Request-ID` or generate one).
- Error handling: map validation errors to structured responses; include error codes and `detail` fields.

## Consequences
- High performance API with self-documentation and strong typing.
- Simple, container-friendly logging suitable for ELK/Datadog/Grafana.
- Requires initial logging/middleware wiring; minor overhead for JSON encoding at high QPS.
