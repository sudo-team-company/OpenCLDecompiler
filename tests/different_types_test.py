import pytest

from .conftest import template


class TestDifferentTypes:
    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint8_type_test(self, mcpu, disasm):
        template(
            path_to_dir="different_types",
            dir_name="uint8_type_test",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_big_type_test(self, mcpu, disasm):
        template(
            path_to_dir="different_types",
            dir_name="big_type_test",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_char_short_test(self, mcpu, disasm):
        template(
            path_to_dir="different_types",
            dir_name="char_short_test",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_short_char_test(self, mcpu, disasm):
        template(
            path_to_dir="different_types",
            dir_name="short_char_test",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_char_char_short_test(self, mcpu, disasm):
        template(
            path_to_dir="different_types",
            dir_name="char_char_short_test",
            mcpu=mcpu,
            disasm=disasm,
        )
