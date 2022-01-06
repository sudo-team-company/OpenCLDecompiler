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

    def test_copy_x(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_x')

    def test_copy_get_global_offset(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_global_offset')

    def test_copy_get_local_id(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_local_id')

    def test_copy_get_group_id(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_group_id')

    def test_copy_get_local_size(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_local_size')

    def test_copy_get_global_id(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_global_id')

    def test_copy_get_global_size(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_global_size')

    def test_copy_get_num_groups(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_num_groups')

    def test_copy_get_work_dim(self):
        template('linear_kernels/work_item_built_in_functions', 'copy_get_work_dim')
