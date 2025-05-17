import pytest

from .conftest import template


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "mcpu", "disasm"),
    [
        pytest.param("loops_kernels", "simple_loop_kernels", "amd_gcn", "clrxdisasm"),
        pytest.param("loops_kernels", "simple_loop_kernels", "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "simple_loop_kernels", "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_with_break_kernels", "amd_gcn", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_general", "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_general", "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_general_dec", "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_general_dec", "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_with_unrolling_breaker", "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_with_unrolling_breaker", "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_block", "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_block", "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_unrolled", "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_unrolled", "gfx1030", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_unrolled_2", "gfx1010", "clrxdisasm"),
        pytest.param("loops_kernels", "loop_unrolled_2", "gfx1030", "clrxdisasm"),
    ],
)
def test_simple_loop_kernels(path_to_dir, dir_name, mcpu, disasm):
    template(
        path_to_dir=path_to_dir,
        dir_name=dir_name,
        mcpu=mcpu,
        disasm=disasm,
    )
