import pytest

from .conftest import template


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "mcpu", "disasm"),
    [
        pytest.param(
            "global_data_usage",
            "int_kernels",
            "amd_gcn",
            "clrxdisasm",
            id="global_data_usage-int_array-amd_gcn-clrxdisasm",
        ),
        pytest.param(
            "global_data_usage",
            "long_kernels",
            "amd_gcn",
            "clrxdisasm",
            id="global_data_usage-long_array-amd_gcn-clrxdisasm",
        ),
        pytest.param(
            "global_data_usage",
            "mixed_kernels",
            "amd_gcn",
            "clrxdisasm",
            id="global_data_usage-mixed_array-amd_gcn-clrxdisasm",
        ),
        pytest.param(
            "global_data_usage",
            "float_kernels",
            "amd_gcn",
            "clrxdisasm",
            id="global_data_usage-float_array-amd_gcn-clrxdisasm",
        ),
        pytest.param(
            "global_data_usage",
            "double_kernels",
            "amd_gcn",
            "clrxdisasm",
            id="global_data_usage-double_array-amd_gcn-clrxdisasm",
        ),
        pytest.param("global_data_usage", "cvt_i32_f32", "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "cvt_f32_i32", "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "cvt_i32_f64", "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "cvt_f64_i32", "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "int4", "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "int8", "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "mix_vectors", "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "int_matrix", "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "long_matrix", "amd_gcn", "clrxdisasm"),
        pytest.param("global_data_usage", "int2_array", "amd_gcn", "clrxdisasm"),
    ],
)
def test(path_to_dir, dir_name, mcpu, disasm):
    template(
        path_to_dir=path_to_dir,
        dir_name=dir_name,
        mcpu=mcpu,
        disasm=disasm,
    )
