import pytest

from .conftest import template


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "flag", "mcpu", "disasm"),
    [
        ("different_flags", "flag_auto_decompilation", None, "amd_gcn", "clrxdisasm"),
        ("different_flags", "flag_only_clrx", "ONLY_CLRX", "amd_gcn", "clrxdisasm"),
        ("different_flags", "flag_only_opencl", "ONLY_OPENCL", "amd_gcn", "clrxdisasm"),
    ],
)
def test(path_to_dir, dir_name, flag, mcpu, disasm):
    template(
        path_to_dir=path_to_dir,
        dir_name=dir_name,
        flag=flag,
        mcpu=mcpu,
        disasm=disasm,
    )
