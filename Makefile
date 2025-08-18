.PHONY: help setup sync hooks lint format type test cov precommit run docker-up docker-down bump release

help:
	@echo "Common targets:"
	@echo "  make setup         # install uv & create venv"
	@echo "  make sync          # sync deps (all groups)"
	@echo "  make hooks         # install pre-commit hooks"
	@echo "  make lint          # ruff lint"
	@echo "  make format        # ruff format"
	@echo "  make type          # mypy type-check"
	@echo "  make test          # pytest"
	@echo "  make cov           # pytest with coverage"
	@echo "  make bump          # bump version with commitizen (e.g., 'make bump PART=minor')"
	@echo "  make release       # tag & push release"
	@echo "  make docker-up     # docker compose up"
	@echo "  make docker-down   # docker compose down"

setup:
	curl -LsSf https://astral.sh/uv/install.sh | sh || true
	uv venv

sync:
	uv sync --all-groups

hooks:
	uv run pre-commit install

lint:
	uv run ruff check .

format:
	uv run ruff format .

type:
	uv run mypy .

test:
	uv run pytest

cov:
	uv run pytest --cov=docchat --cov-report=term-missing

bump:
	uv run cz bump --yes --increment $(PART)

release:
	git push origin main && git push --tags

docker-up:
	docker compose up --build -d

docker-down:
	docker compose down -v
