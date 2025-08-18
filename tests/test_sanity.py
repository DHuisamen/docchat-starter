from docchat import __version__
from docchat.config import settings


def test_version_semver_like():
    parts = __version__.split(".")
    assert len(parts) == 3
    assert all(p.isdigit() for p in parts), "version must be numeric semver"


def test_settings_load_defaults():
    assert settings.env in ("dev", "staging", "prod")
    assert settings.default_top_k > 0
