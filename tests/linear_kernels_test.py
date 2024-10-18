import pytest

from .conftest import template


class TestLinearKernels:
    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_addition(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels',
            dir_name='addition',
            mcpu=mcpu,
            disasm=disasm,
            )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_subtraction(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels',
            dir_name='subtraction',
            mcpu=mcpu,
            disasm=disasm,
            )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_multiplication(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels',
            dir_name='multiplication',
            mcpu=mcpu,
            disasm=disasm,
            )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_many_linears(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels',
            dir_name='many_linears',
            mcpu=mcpu,
            disasm=disasm,
            )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_copy_x(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels/work_item_built_in_functions',
            dir_name='copy_x',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_copy_get_global_offset(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels/work_item_built_in_functions',
            dir_name='copy_get_global_offset',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_copy_get_local_id(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels/work_item_built_in_functions',
            dir_name='copy_get_local_id',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_copy_get_group_id(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels/work_item_built_in_functions',
            dir_name='copy_get_group_id',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_copy_get_local_size(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels/work_item_built_in_functions',
            dir_name='copy_get_local_size',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_copy_get_global_id(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels/work_item_built_in_functions',
            dir_name='copy_get_global_id',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_copy_get_global_size(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels/work_item_built_in_functions',
            dir_name='copy_get_global_size',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_copy_get_num_groups(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels/work_item_built_in_functions',
            dir_name='copy_get_num_groups',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("", "clrxdisasm"),
            ("gfx1010", "clrxdisasm"),
            ("gfx1030", "clrxdisasm"),
            ("gfx1103", "amdgpu-dis"),
        ]
    )
    def test_copy_get_work_dim(self, mcpu, disasm):
        template(
            path_to_dir='linear_kernels/work_item_built_in_functions',
            dir_name='copy_get_work_dim',
            mcpu=mcpu,
            disasm=disasm,
        )
