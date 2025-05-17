import pytest

from .conftest import template


@pytest.mark.parametrize(
    ("path_to_dir", "dir_name", "mcpu", "disasm"),
    [
        pytest.param("different_types", "uint8_type_test", "amd_gcn", "clrxdisasm"),
        pytest.param("different_types", "big_type_test", "amd_gcn", "clrxdisasm"),
        pytest.param("different_types", "char_short_test", "amd_gcn", "clrxdisasm"),
        pytest.param("different_types", "short_char_test", "amd_gcn", "clrxdisasm"),
        pytest.param("different_types", "char_char_short_test", "amd_gcn", "clrxdisasm"),
    ],
)
def test(path_to_dir, dir_name, mcpu, disasm):
    template(
        path_to_dir=path_to_dir,
        dir_name=dir_name,
        mcpu=mcpu,
        disasm=disasm,
    )
