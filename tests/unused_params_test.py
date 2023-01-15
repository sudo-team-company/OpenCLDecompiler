from .conftest import template


class TestUnusedParams:
    def test_one_unused_param(self):
        template('unused_params', 'one_unused_param')

    def test_two_unused_params(self):
        template('unused_params', 'two_unused_params')

    def test_three_unused_params(self):
        template('unused_params', 'three_unused_params')

    def test_four_unused_params(self):
        template('unused_params', 'four_unused_params')
