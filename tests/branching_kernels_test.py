import pytest

from .conftest import template


class TestBranchingKernels:
    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_first(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_1",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_second(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_2",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_and_if(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_and_if",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_else_0_labels(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_0_labels",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_else_1_labels(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_1_label",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_else_2_labels(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_2_labels",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_in_if(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_in_if",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_else_in_if(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_in_if",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_if_else_and_if_else(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_and_if_else",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_else_and_if_else_gfx(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_and_if_else_gfx",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_else_and_if_else_0_labels(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_and_if_else_0_labels",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_if_else_in_if_of_if_else(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_in_if_of_if_else",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_else_in_if_of_if_else_gfx(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_in_if_of_if_else_gfx",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_if_else_in_else_of_if_else(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_in_else_of_if_else",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_else_in_else_of_if_else_gfx(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_in_else_of_if_else_gfx",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_if_else_in_if_and_else_of_if_else(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_in_if_and_else_of_if_else",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_else_in_if_and_else_of_if_else_gfx(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_else_in_if_and_else_of_if_else_gfx",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_in_if_in_if(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_in_if_in_if",
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ("mcpu", "disasm"),
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_if_with_long_expr(self, mcpu, disasm):
        template(
            path_to_dir="branching_kernels",
            dir_name="if_with_long_expr",
            mcpu=mcpu,
            disasm=disasm,
        )
