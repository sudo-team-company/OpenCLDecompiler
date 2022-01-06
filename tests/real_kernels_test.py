from .conftest import template


class TestRealKernels:
    def test_mask_kernel(self):
        template('real_kernels', 'mask_kernel')

    def test_weighted_sum_kernel(self):
        template('real_kernels', 'weighted_sum_kernel')
