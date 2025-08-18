# Multi-stage: builder (deps) + runtime
FROM python:3.11-slim AS builder
WORKDIR /app
ENV PIP_NO_CACHE_DIR=1
COPY pyproject.toml ./
RUN pip install --upgrade pip && pip install hatchling

COPY src ./src
COPY README.md ./

RUN python -m hatchling build -t wheel

FROM python:3.11-slim AS runtime
WORKDIR /app
ENV PYTHONUNBUFFERED=1

COPY --from=builder /app/dist/*.whl /tmp/
RUN pip install /tmp/*.whl && rm -rf /tmp/*.whl

COPY . .

CMD ["python", "-c", "print('Container ready. Add your app entrypoint.')"]
