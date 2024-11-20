import pytest

from .conftest import template


class TestVectorTypeParams:
    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_char2_second_third_element_char4(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="char2_second_third_element_char4",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_char2_reverse_char2(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="char2_reverse_char2",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_char2_first_and_first_char4(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="char2_first_and_first_char4",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint2_uint(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="uint2_uint",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint2_uint2(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="uint2_uint2",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint2_reverse_uint2(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="uint2_reverse_uint2",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint2_reverse_first_half_uint4(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="uint2_reverse_first_half_uint4",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint2_second_third_element_uint4(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="uint2_second_third_element_uint4",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint2_third_fourth_element_uint4(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="uint2_third_fourth_element_uint4",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint2_third_second_element_uint4(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="uint2_third_second_element_uint4",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint2_first_fourth_element_uint4(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="uint2_first_fourth_element_uint4",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint2_first_and_first_uint4(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="uint2_first_and_first_uint4",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_uint4_float4(self, mcpu, disasm):
        template(
            path_to_dir="vector_type_params",
            dir_name="uint4_float4",
            mcpu=mcpu,
            disasm=disasm,
        )
