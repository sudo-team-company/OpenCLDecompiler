from .conftest import template


class TestLoopsKernels:
    def test_simple_loop_kernels(self):
        template('loops_kernels', 'simple_loop_kernels')

    def test_loop_with_break_kernels(self):
        template('loops_kernels', 'loop_with_break_kernels')
