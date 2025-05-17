import pytest

from .conftest import template


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "mcpu", "disasm"),
    [
        pytest.param("vector_type_params", "char2_second_third_element_char4", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "char2_reverse_char2", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "char2_first_and_first_char4", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_uint", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_uint2", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_reverse_uint2", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_reverse_first_half_uint4", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_second_third_element_uint4", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_third_fourth_element_uint4", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_third_second_element_uint4", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_first_fourth_element_uint4", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint2_first_and_first_uint4", "amd_gcn", "clrxdisasm"),
        pytest.param("vector_type_params", "uint4_float4", "amd_gcn", "clrxdisasm"),
    ],
)
def test(path_to_dir, dir_name, mcpu, disasm):
    template(
        path_to_dir=path_to_dir,
        dir_name=dir_name,
        mcpu=mcpu,
        disasm=disasm,
    )
