import pytest

from .conftest import template


class TestDifferentFlags:
    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_flag_auto_decompilation(self, mcpu, disasm):
        template(
            path_to_dir="different_flags",
            dir_name="flag_auto_decompilation",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_flag_only_clrx(self, mcpu, disasm):
        template(
            path_to_dir="different_flags",
            dir_name="flag_only_clrx",
            flag="ONLY_CLRX",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_flag_only_opencl(self, mcpu, disasm):
        template(
            path_to_dir="different_flags",
            dir_name="flag_only_opencl",
            flag="ONLY_OPENCL",
            mcpu=mcpu,
            disasm=disasm,
        )
