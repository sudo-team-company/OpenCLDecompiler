import pytest

from .conftest import template


class TestRealKernels:
    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_mask_kernel(self, mcpu, disasm):
        template(
            path_to_dir="real_kernels",
            dir_name="mask_kernel",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_weighted_sum_kernel(self, mcpu, disasm):
        template(
            path_to_dir="real_kernels",
            dir_name="weighted_sum_kernel",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_bellman_ford_init_ver1(self, mcpu, disasm):
        template(
            path_to_dir="real_kernels",
            dir_name="bellmanFordInit_ver1",
            mcpu=mcpu,
            disasm=disasm,
        )
