from .conftest import template


class TestVectorTypeParams:
    def test_uint2_uint(self):
        template('vector_type_params', 'uint2_uint')
