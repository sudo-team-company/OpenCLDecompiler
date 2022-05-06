from .conftest import template


class TestLocalMemoryKernels:
    def test_barrier_1(self):
        template('local_memory_kernels', 'barrier_1')
