import pytest

from .conftest import template


class TestLocalMemoryKernels:
    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_barrier_1(self, mcpu, disasm):
        template(
            path_to_dir="local_memory_kernels",
            dir_name="barrier_1",
            mcpu=mcpu,
            disasm=disasm,
        )
