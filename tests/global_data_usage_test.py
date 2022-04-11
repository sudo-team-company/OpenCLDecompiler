from .conftest import template


class TestGlobalData:
    def test_int_array(self):
        template('global_data_usage', 'int_kernels')

    def test_long_array(self):
        template('global_data_usage', 'long_kernels')

    def test_mixed_array(self):
        template('global_data_usage', 'mixed_kernels')

    def test_float_array(self):
        template('global_data_usage', 'float_kernels')

    def test_double_array(self):
        template('global_data_usage', 'double_kernels')

    def test_cvt_i32_f32(self):
        template('global_data_usage', 'cvt_i32_f32')

    def test_cvt_f32_i32(self):
        template('global_data_usage', 'cvt_f32_i32')

    def test_cvt_i32_f64(self):
        template('global_data_usage', 'cvt_i32_f64')

    def test_cvt_f64_i32(self):
        template('global_data_usage', 'cvt_f64_i32')

    def test_cvt_f64_i64(self):
        template('global_data_usage', 'cvt_f64_i64')

    def test_int4(self):
        template('global_data_usage', 'int4')

    def test_int8(self):
        template('global_data_usage', 'int8')

    def test_mix_vectors(self):
        template('global_data_usage', 'mix_vectors')

    def test_int_matrix(self):
        template('global_data_usage', 'int_matrix')

    def test_long_matrix(self):
        template('global_data_usage', 'long_matrix')

    def test_int2_array(self):
        template('global_data_usage', 'int2_array')

    # def test_int2_to_int2(self):
    #     template('global_data_usage', 'int2_to_int2')
    #
    # def test_int4_to_int4(self):
    #     template('global_data_usage', 'int4_to_int4')

    # def test_int8_to_int8(self):
    #     template('global_data_usage', 'int8_to_int8')
