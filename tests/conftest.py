from pathlib import Path

import pytest


@pytest.fixture(scope="session")
def root_path(pytestconfig: pytest.Config) -> Path:
    return pytestconfig.rootpath


@pytest.fixture(scope="session")
def tests_path(root_path: Path) -> Path:
    return root_path / "tests"
