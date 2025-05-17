import pytest

from .conftest import template


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "mcpu", "disasm"),
    [
        pytest.param("real_kernels", "mask_kernel", "amd_gcn", "clrxdisasm"),
        pytest.param("real_kernels", "weighted_sum_kernel", "amd_gcn", "clrxdisasm"),
        pytest.param("real_kernels", "bellmanFordInit_ver1", "amd_gcn", "clrxdisasm"),
    ],
)
def test(path_to_dir, dir_name, mcpu, disasm):
    template(
        path_to_dir=path_to_dir,
        dir_name=dir_name,
        mcpu=mcpu,
        disasm=disasm,
    )
