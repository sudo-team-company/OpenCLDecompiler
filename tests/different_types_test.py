from .conftest import template


class TestDifferentTypes:
    def test_uint8_type_test(self):
        template('different_types', 'uint8_type_test')

    def test_big_type_test(self):
        template('different_types', 'big_type_test')
