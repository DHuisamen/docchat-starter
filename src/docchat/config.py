from __future__ import annotations

from typing import Literal

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application settings loaded from environment (.env by default)."""

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    env: Literal["dev", "staging", "prod"] = "dev"
    debug: bool = True

    # Example provider keys (fill as needed)
    openai_api_key: str | None = None

    # Example tunables
    default_top_k: int = 5
    chunk_size: int = 800
    chunk_overlap: int = 160


settings = Settings()
