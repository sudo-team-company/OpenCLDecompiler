import pytest

from .conftest import template


class TestLoopsKernels:
    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_simple_loop_kernels(self, mcpu, disasm):
        template(
            path_to_dir='loops_kernels',
            dir_name='simple_loop_kernels',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
        ],
    )
    def test_loop_with_break_kernels(self, mcpu, disasm):
        template(
            path_to_dir='loops_kernels',
            dir_name='loop_with_break_kernels',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_loop_general(self, mcpu, disasm):
        template(
            path_to_dir='loops_kernels',
            dir_name='loop_general',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_loop_general_dec(self, mcpu, disasm):
        template(
            path_to_dir='loops_kernels',
            dir_name='loop_general_dec',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_loop_with_unrolling_breaker(self, mcpu, disasm):
        template(
            path_to_dir='loops_kernels',
            dir_name='loop_with_unrolling_breaker',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_loop_block(self, mcpu, disasm):
        template(
            path_to_dir='loops_kernels',
            dir_name='loop_block',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_loop_unrolled(self, mcpu, disasm):
        template(
            path_to_dir='loops_kernels',
            dir_name='loop_unrolled',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
        ],
    )
    def test_loop_unrolled_2(self, mcpu, disasm):
        template(
            path_to_dir='loops_kernels',
            dir_name='loop_unrolled_2',
            mcpu=mcpu,
            disasm=disasm,
        )
