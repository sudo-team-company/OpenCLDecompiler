import struct

from src.model.preloaded_registers import PreloadedRegs

class gfx10_KDescriptor(PreloadedRegs):
    def __init__(self):
        super().__init__()

        self.group_segment_fixed_size = 0
        self.private_segment_fixed_size = 0
        self.kernarg_size = 0
        self.kernel_code_entry_byte_offset = 0
        
        #RSRC
        self.compute_pgm_rsrc1 = 0
        self.compute_pgm_rsrc2 = 0
        self.compute_pgm_rsrc3 = 0 
        self.kernel_code_properties = 0

        #RSRC1
        self.granulated_workitem_vgpr_count = 0
        self.granulated_wavefront_sgpr_count = 0
        self.priority = 0
        self.float_mode_round_32 = 0
        self.float_mode_round_16_64 = 0
        self.float_mode_denorm_32 = 0
        self.float_mode_denorm_16_64 = 0
        self.priv = 0
        self.enable_dx10_clamp = 0
        self.debug_mode = 0
        self.enable_ieee_mode = 0
        self.bulky = 0
        self.cdbg_user = 0
        self.wgp_mode = 0
        self.mem_ordered = 0
        self.fwd_progress = 0

        #RSRC2
        self.enable_private_segment = 0
        self.user_sgpr_count = 0
        self.enable_trap_handler = 0
        self.enable_sgpr_workgroup_id_x = 0
        self.enable_sgpr_workgroup_id_y = 0
        self.enable_sgpr_workgroup_id_z = 0
        self.enable_sgpr_workgroup_info = 0
        self.enable_vgpr_workitem_id = 0
        self.enable_exception_address_warch = 0
        self.enable_exception_memory = 0
        self.granulated_lds_size = 0
        self.enable_exception = 0

        #RSRC3
        self.shared_vgpr_count = 0

        #Kernel properties
        self.enable_sgpr_private_segment_buffer = 0
        self.enable_sgpr_dispatch_ptr = 0
        self.enable_sgpr_queue_ptr = 0
        self.enable_sgpr_kernarg_segment_ptr = 0
        self.enable_sgpr_dispatch_id = 0
        self.enable_sgpr_flat_scratch_init = 0
        self.enable_sgpr_private_segment_size = 0
        self.enable_wavefront_size32 = 0

    def __init__(self, raw_data: bytearray):
        super().__init__()

        self.group_segment_fixed_size = struct.unpack_from('<i', raw_data, 0)[0]
        self.private_segment_fixed_size = struct.unpack_from('<i', raw_data, 4)[0]
        self.kernarg_size = struct.unpack_from('<i', raw_data, 8)[0]
        self.kernel_code_entry_byte_offset = struct.unpack_from('<q', raw_data, 16)[0]
        self.compute_pgm_rsrc3 = struct.unpack_from('<i', raw_data, 44)[0]
        self.compute_pgm_rsrc1 = struct.unpack_from('<i', raw_data, 48)[0]
        self.compute_pgm_rsrc2 = struct.unpack_from('<i', raw_data, 52)[0]
        self.kernel_code_properties = struct.unpack_from('<q', raw_data, 56)[0]


        self.granulated_workitem_vgpr_count = self.compute_pgm_rsrc1 & 0x3F
        self.granulated_wavefront_sgpr_count = (self.compute_pgm_rsrc1 >> 6) & 0xF
        self.priority = (self.compute_pgm_rsrc1 >> 10) & 0x3
        self.float_mode_round_32 = (self.compute_pgm_rsrc1 >> 12) & 0x3 
        self.float_mode_round_16_64 = (self.compute_pgm_rsrc1 >> 14) & 0x3
        self.float_mode_denorm_32 = (self.compute_pgm_rsrc1 >> 16) & 0x3
        self.float_mode_denorm_16_64 = (self.compute_pgm_rsrc1 >> 18) & 0x3
        self.priv = (self.compute_pgm_rsrc1 >> 20) & 0x1
        self.enable_dx10_clamp = (self.compute_pgm_rsrc1 >> 21) & 0x1
        self.debug_mode = (self.compute_pgm_rsrc1 >> 22) & 0x1
        self.enable_ieee_mode = (self.compute_pgm_rsrc1 >> 23) & 0x1
        self.bulky = (self.compute_pgm_rsrc1 >> 25) & 0x1
        self.cdbg_user = (self.compute_pgm_rsrc1 >> 26) & 0x1
        self.wgp_mode = (self.compute_pgm_rsrc1 >> 29) & 0x1
        self.mem_ordered = (self.compute_pgm_rsrc1 >> 30) & 0x1
        self.fwd_progress = (self.compute_pgm_rsrc1 >> 31) & 0x1


        self.enable_private_segment = self.compute_pgm_rsrc2 & 0x1
        self.user_sgpr_count = (self.compute_pgm_rsrc2 >> 1) & 0x1F
        self.enable_trap_handler = (self.compute_pgm_rsrc2 >> 6) & 0x1
        self.enable_sgpr_workgroup_id_x = (self.compute_pgm_rsrc2 >> 7) & 0x1
        self.enable_sgpr_workgroup_id_y = (self.compute_pgm_rsrc2 >> 8) & 0x1
        self.enable_sgpr_workgroup_id_z = (self.compute_pgm_rsrc2 >> 9) & 0x1
        self.enable_sgpr_workgroup_info = (self.compute_pgm_rsrc2 >> 10) & 0x1
        self.enable_vgpr_workitem_id = (self.compute_pgm_rsrc2 >> 11) & 0x3
        self.enable_exception_address_warch = (self.compute_pgm_rsrc2 >> 13) & 0x1
        self.enable_exception_memory = (self.compute_pgm_rsrc2 >> 14) & 0x1
        self.granulated_lds_size = (self.compute_pgm_rsrc2 >> 15) & 0x1FF
        self.enable_exception = (self.compute_pgm_rsrc2 >> 24) & 0x7F

        self.shared_vgpr_count = self.compute_pgm_rsrc3 & 0x7

        self.enable_sgpr_private_segment_buffer = (self.kernel_code_properties >> 0) & 0x1
        self.enable_sgpr_dispatch_ptr = (self.kernel_code_properties >> 1) & 0x1
        self.enable_sgpr_queue_ptr = (self.kernel_code_properties >> 2) & 0x1
        self.enable_sgpr_kernarg_segment_ptr = (self.kernel_code_properties >> 3) & 0x1
        self.enable_sgpr_dispatch_id = (self.kernel_code_properties >> 4) & 0x1
        self.enable_sgpr_flat_scratch_init = (self.kernel_code_properties >> 5) & 0x1
        self.enable_sgpr_private_segment_size = (self.kernel_code_properties >> 6) & 0x1
        self.enable_wavefront_size32 = (self.kernel_code_properties >> 7) & 0x1

        self._calculate_sgpr_layout()
        self._calculate_vgpr_layout()
    
    def _calculate_sgpr_layout(self):
        current_sgpr = 0

        if self.enable_sgpr_private_segment_buffer:
            self.sgpr_private_segment_buffer = (current_sgpr, current_sgpr + 3)
            current_sgpr += 4


        if self.enable_sgpr_dispatch_ptr:
            self.sgpr_dispatch_ptr = (current_sgpr, current_sgpr + 1)
            current_sgpr += 2

        if self.enable_sgpr_queue_ptr:
            self.sgpr_queue_ptr = (current_sgpr, current_sgpr + 1)
            current_sgpr += 2

        if self.enable_sgpr_kernarg_segment_ptr:
            self.sgpr_kernarg_segment_ptr = (current_sgpr, current_sgpr + 1)
            current_sgpr += 2

        if self.enable_sgpr_dispatch_id:
            self.sgpr_dispatch_id = (current_sgpr, current_sgpr + 1)
            current_sgpr += 2

        if self.enable_sgpr_flat_scratch_init:
            self.sgpr_flat_scratch_init = (current_sgpr, current_sgpr + 1)
            current_sgpr += 2

        if self.enable_sgpr_workgroup_id_x:
            self.sgpr_workgroup_id_x = current_sgpr
            current_sgpr += 1
            
        if self.enable_sgpr_workgroup_id_y:
            self.sgpr_workgroup_id_y = current_sgpr
            current_sgpr += 1
            
        if self.enable_sgpr_workgroup_id_z:
            self.sgpr_workgroup_id_z = current_sgpr
            current_sgpr += 1

    def _calculate_vgpr_layout(self):
        current_vgpr = 0

        if self.enable_vgpr_workitem_id > 0:
            self.vgpr_workitem_id_x = current_vgpr
            current_vgpr += 1

        if self.enable_vgpr_workitem_id > 1:
            self.vgpr_workitem_id_y = current_vgpr
            current_vgpr += 1

        if self.enable_vgpr_workitem_id > 2:
            self.vgpr_workitem_id_z = current_vgpr


    def __repr__(self):
        return (f"KDescriptor(\n"
                f"  group_segment_fixed_size={self.group_segment_fixed_size}\n"
                f"  private_segment_fixed_size={self.private_segment_fixed_size}\n"
                f"  kernarg_size={self.kernarg_size}\n"
                f"  kernel_code_entry_byte_offset=0x{self.kernel_code_entry_byte_offset:08X}\n"
                f"  compute_pgm_rsrc1=0x{self.compute_pgm_rsrc1:08X}\n"
                f"    vgpr_count={self.granulated_workitem_vgpr_count}\n"
                f"    sgpr_count={self.granulated_wavefront_sgpr_count}\n"
                f"    priority={self.priority}\n"
                f"    float_mode_round_32={self.float_mode_round_32}\n"
                f"    float_mode_round_16_64={self.float_mode_round_16_64}\n"
                f"    float_mode_denorm_32={self.float_mode_denorm_32}\n"
                f"    float_mode_denorm_16_64={self.float_mode_denorm_16_64}\n"
                f"    priv={self.priv}\n"
                f"    enable_dx10_clamp={self.enable_dx10_clamp}\n"
                f"    debug_mode={self.debug_mode}\n"
                f"    enable_ieee_mode={self.enable_ieee_mode}\n"
                f"    bulky={self.bulky}\n"
                f"    cdbg_user={self.cdbg_user}\n"
                f"    wgp_mode={self.wgp_mode}\n"
                f"    mem_ordered={self.mem_ordered}\n"
                f"    fwd_progress={self.fwd_progress}\n"
                f"  compute_pgm_rsrc2=0x{self.compute_pgm_rsrc2:08X}\n"
                f"    enable_private_segment={self.enable_private_segment}\n"
                f"    user_sgpr_count={self.user_sgpr_count}\n"
                f"    enable_trap_handler={self.enable_trap_handler}\n"
                f"    enable_sgpr_workgroup_id_x={self.enable_sgpr_workgroup_id_x}\n"
                f"    enable_sgpr_workgroup_id_y={self.enable_sgpr_workgroup_id_y}\n"
                f"    penable_sgpr_workgroup_id_zriv={self.enable_sgpr_workgroup_id_z}\n"
                f"    enable_sgpr_workgroup_info={self.enable_sgpr_workgroup_info}\n"
                f"    enable_vgpr_workitem_id={self.enable_vgpr_workitem_id}\n"
                f"    enable_exception_address_warch={self.enable_exception_address_warch}\n"
                f"    enable_exception_memory={self.enable_exception_memory}\n"
                f"    granulated_lds_size={self.granulated_lds_size}\n"
                f"    enable_exception={self.enable_exception}\n"
                f"  compute_pgm_rsrc3=0x{self.compute_pgm_rsrc3:08X}\n"
                f"    shared_vgpr_count={self.shared_vgpr_count}\n"
                f"  code_props=0x{self.kernel_code_properties:08X}\n"
                f"    sgpr_private_segment_buffer={self.enable_sgpr_private_segment_buffer}\n"
                f"    sgpr_dispatch_ptr={self.enable_sgpr_dispatch_ptr}\n"
                f"    sgpr_queue_ptr={self.enable_sgpr_queue_ptr}\n"
                f"    sgpr_kernarg_segment_ptr={self.enable_sgpr_kernarg_segment_ptr}\n"
                f"    sgpr_dispatch_id={self.enable_sgpr_dispatch_id}\n"
                f"    sgpr_flat_scratch_init={self.enable_sgpr_flat_scratch_init}\n"
                f"    sgpr_private_segment_size={self.enable_sgpr_private_segment_size}\n"
                f"    wavefront_size32={self.enable_wavefront_size32}\n"
                f")") 
            