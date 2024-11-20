import pytest

from .conftest import template


class TestUnusedParams:
    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_one_unused_param(self, mcpu, disasm):
        template(
            path_to_dir="unused_params",
            dir_name="one_unused_param",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_two_unused_params(self, mcpu, disasm):
        template(
            path_to_dir="unused_params",
            dir_name="two_unused_params",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_three_unused_params(self, mcpu, disasm):
        template(
            path_to_dir="unused_params",
            dir_name="three_unused_params",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_four_unused_params(self, mcpu, disasm):
        template(
            path_to_dir="unused_params",
            dir_name="four_unused_params",
            mcpu=mcpu,
            disasm=disasm,
        )
