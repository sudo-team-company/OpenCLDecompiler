import argparse
from pathlib import Path

import pytest


def pytest_addoption(parser: pytest.Parser):
    parser.addoption(
        "--disasm", action=argparse.BooleanOptionalAction, default=True, help="Enable/disable disassembly step of test."
    )


@pytest.fixture(scope="session")
def use_disasm(pytestconfig: pytest.Config) -> bool:
    return pytestconfig.getoption("--disasm")


@pytest.fixture(scope="session")
def root_path(pytestconfig: pytest.Config) -> Path:
    return pytestconfig.rootpath


@pytest.fixture(scope="session")
def tests_path(root_path: Path) -> Path:
    return root_path / "tests"
