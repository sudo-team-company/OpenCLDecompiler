from .conftest import template


class TestVectorTypeParams:
    def test_uint2_uint(self):
        template('vector_type_params', 'uint2_uint')

    def test_uint2_uint2(self):
        template('vector_type_params', 'uint2_uint2')

    def test_uint2_reverse_uint2(self):
        template('vector_type_params', 'uint2_reverse_uint2')

    def test_uint2_reverse_first_half_uint4(self):
        template('vector_type_params', 'uint2_reverse_first_half_uint4')
