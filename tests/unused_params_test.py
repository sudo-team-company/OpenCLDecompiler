import pytest

from .conftest import template


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "mcpu", "disasm"),
    [
        pytest.param("unused_params", "one_unused_param", "amd_gcn", "clrxdisasm"),
        pytest.param("unused_params", "two_unused_params", "amd_gcn", "clrxdisasm"),
        pytest.param("unused_params", "three_unused_params", "amd_gcn", "clrxdisasm"),
        pytest.param("unused_params", "four_unused_params", "amd_gcn", "clrxdisasm"),
    ],
)
def test(path_to_dir, dir_name, mcpu, disasm):
    template(
        path_to_dir=path_to_dir,
        dir_name=dir_name,
        mcpu=mcpu,
        disasm=disasm,
    )
