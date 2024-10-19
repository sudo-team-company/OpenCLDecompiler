import pytest

from .conftest import template


class TestGlobalData:
    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_int_array(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='int_kernels',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_long_array(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='long_kernels',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_mixed_array(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='mixed_kernels',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_float_array(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='float_kernels',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_double_array(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='double_kernels',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_cvt_i32_f32(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='cvt_i32_f32',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_cvt_f32_i32(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='cvt_f32_i32',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_cvt_i32_f64(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='cvt_i32_f64',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_cvt_f64_i32(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='cvt_f64_i32',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_cvt_f64_i64(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='cvt_f64_i64',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_int4(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='int4',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_int8(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='int8',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_mix_vectors(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='mix_vectors',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_int_matrix(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='int_matrix',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_long_matrix(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='long_matrix',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_int2_array(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='int2_array',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_int2_to_int2(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='int2_to_int2',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_int4_to_int4(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='int4_to_int4',
            mcpu=mcpu,
            disasm=disasm,
        )

    @pytest.mark.parametrize(
        ["mcpu", "disasm"],
        [
            ("amd_gcn", "clrxdisasm"),
            ("gfx1010", "amdgpu-dis"),
            ("gfx1030", "amdgpu-dis"),
        ],
    )
    def test_int8_to_int8(self, mcpu, disasm):
        template(
            path_to_dir='global_data_usage',
            dir_name='int8_to_int8',
            mcpu=mcpu,
            disasm=disasm,
        )
