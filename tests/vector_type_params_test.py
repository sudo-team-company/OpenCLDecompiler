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

    def test_uint2_second_third_element_uint4(self):
        template('vector_type_params', 'uint2_second_third_element_uint4')

    def test_uint2_third_fourth_element_uint4(self):
        template('vector_type_params', 'uint2_third_fourth_element_uint4')

    def test_uint2_third_second_element_uint4(self):
        template('vector_type_params', 'uint2_third_second_element_uint4')

    def test_uint2_first_fourth_element_uint4(self):
        template('vector_type_params', 'uint2_first_fourth_element_uint4')

    def test_uint2_first_and_first_uint4(self):
        template('vector_type_params', 'uint2_first_and_first_uint4')
