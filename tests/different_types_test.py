from .conftest import template


class TestDifferentTypes:
    def test_uint8_type_test(self):
        template('different_types', 'uint8_type_test')

    def test_big_type_test(self):
        template('different_types', 'big_type_test')

    def test_char_short_test(self):
        template('different_types', 'char_short_test')

    def test_short_char_test(self):
        template('different_types', 'short_char_test')

    def test_char_char_short_test(self):
        template('different_types', 'char_char_short_test')
