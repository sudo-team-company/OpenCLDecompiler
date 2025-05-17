import pytest

from .conftest import template


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "mcpu", "disasm"),
    [
        pytest.param(
            "branching_kernels", "if_1", "amd_gcn", "clrxdisasm", id="branching_kernels-if_first-amd_gcn-clrxdisasm"
        ),
        pytest.param(
            "branching_kernels", "if_1", "gfx1010", "clrxdisasm", id="branching_kernels-if_first-gfx1010-clrxdisasm"
        ),
        pytest.param(
            "branching_kernels", "if_1", "gfx1030", "clrxdisasm", id="branching_kernels-if_first-gfx1030-clrxdisasm"
        ),
        pytest.param(
            "branching_kernels", "if_2", "amd_gcn", "clrxdisasm", id="branching_kernels-if_second-amd_gcn-clrxdisasm"
        ),
        pytest.param(
            "branching_kernels", "if_2", "gfx1010", "clrxdisasm", id="branching_kernels-if_second-gfx1010-clrxdisasm"
        ),
        pytest.param(
            "branching_kernels", "if_2", "gfx1030", "clrxdisasm", id="branching_kernels-if_second-gfx1030-clrxdisasm"
        ),
        pytest.param("branching_kernels", "if_and_if", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_and_if", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_and_if", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_0_labels", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_0_labels", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_0_labels", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_1_label", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_1_label", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_1_label", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_2_labels", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_2_labels", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_2_labels", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else_gfx", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else_gfx", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else_0_labels", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else_0_labels", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_and_if_else_0_labels", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_of_if_else", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_of_if_else_gfx", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_of_if_else_gfx", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_else_of_if_else", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_else_of_if_else_gfx", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_else_of_if_else_gfx", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_and_else_of_if_else", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_and_else_of_if_else_gfx", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_else_in_if_and_else_of_if_else_gfx", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if_in_if", "amd_gcn", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if_in_if", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_in_if_in_if", "gfx1030", "clrxdisasm"),
        pytest.param("branching_kernels", "if_with_long_expr", "gfx1010", "clrxdisasm"),
        pytest.param("branching_kernels", "if_with_long_expr", "gfx1030", "clrxdisasm"),
    ],
)
def test(path_to_dir, dir_name, mcpu, disasm):
    template(
        path_to_dir=path_to_dir,
        dir_name=dir_name,
        mcpu=mcpu,
        disasm=disasm,
    )
