import pytest

from .conftest import template


class TestLinearKernels:
    def test_addition(self):
        template('linear_kernels', 'addition')

    def test_subtraction(self):
        template('linear_kernels', 'subtraction')

    def test_multiplication(self):
        template('linear_kernels', 'multiplication')

    def test_many_linears(self):
        template('linear_kernels', 'many_linears')

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_copy_x(self, mcpu):
        template('linear_kernels/work_item_built_in_functions', 'copy_x', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_copy_get_global_offset(self, mcpu):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_global_offset', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_copy_get_local_id(self, mcpu):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_local_id', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_copy_get_group_id(self, mcpu):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_group_id', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_copy_get_local_size(self, mcpu):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_local_size', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_copy_get_global_id(self, mcpu):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_global_id', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_copy_get_global_size(self, mcpu):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_global_size', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_copy_get_num_groups(self, mcpu):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_num_groups', mcpu=mcpu)

    @pytest.mark.parametrize("mcpu", ["", "gfx1010", "gfx1030"])
    def test_copy_get_work_dim(self, mcpu):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_work_dim', mcpu=mcpu)
