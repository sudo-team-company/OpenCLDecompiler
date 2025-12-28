
class PreloadedRegs:
    def __init__(self):
        self.sgpr_private_segment_buffer = None
        self.sgpr_dispatch_ptr = None
        self.sgpr_queue_ptr = None
        self.sgpr_kernarg_segment_ptr = None
        self.sgpr_dispatch_id = None
        self.sgpr_flat_scratch_init = None
        
        self.sgpr_workgroup_id_x = None
        self.sgpr_workgroup_id_y = None
        self.sgpr_workgroup_id_z = None

        self.vgpr_workitem_id_x = None
        self.vgpr_workitem_id_y = None
        self.vgpr_workitem_id_z = None

    def print_layout(self):
        if self.sgpr_private_segment_buffer: print(f"sgpr_private_segment_buffer: s{self.sgpr_private_segment_buffer}")
        if self.sgpr_dispatch_ptr:           print(f"sgpr_dispatch_ptr:           s{self.sgpr_dispatch_ptr}")
        if self.sgpr_queue_ptr:              print(f"sgpr_queue_ptr:              s{self.sgpr_queue_ptr}")
        if self.sgpr_kernarg_segment_ptr:    print(f"sgpr_kernarg_segment_ptr:    s{self.sgpr_kernarg_segment_ptr}")
        if self.sgpr_dispatch_id:            print(f"sgpr_dispatch_id:            s{self.sgpr_dispatch_id}")
        if self.sgpr_flat_scratch_init:      print(f"sgpr_flat_scratch_init:      s{self.sgpr_flat_scratch_init}")
        if self.sgpr_workgroup_id_x is not None: print(f"sgpr_workgroup_id_x:     s{self.sgpr_workgroup_id_x}")
        if self.sgpr_workgroup_id_y is not None: print(f"sgpr_workgroup_id_y:     s{self.sgpr_workgroup_id_y}")
        if self.sgpr_workgroup_id_z is not None: print(f"sgpr_workgroup_id_z:     s{self.sgpr_workgroup_id_z}")
        if self.vgpr_workitem_id_x is not None:  print(f"vgpr_workitem_id_x:      v{self.vgpr_workitem_id_x}")
        if self.vgpr_workitem_id_y is not None:  print(f"vgpr_workitem_id_y:      v{self.vgpr_workitem_id_y}")
        if self.vgpr_workitem_id_z is not None:  print(f"vgpr_workitem_id_z:      v{self.vgpr_workitem_id_z}")
        
