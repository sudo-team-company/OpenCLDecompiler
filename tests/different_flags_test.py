from .conftest import template


class TestDifferentFlags:
    def test_flag_auto_decompilation(self):
        template('different_flags', 'flag_auto_decompilation')

    def test_flag_only_clrx(self):
        template('different_flags', 'flag_only_clrx', 'ONLY_CLRX')

    def test_flag_only_opencl(self):
        template('different_flags', 'flag_only_opencl', 'ONLY_OPENCL')
