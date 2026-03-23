from src.base_instruction import BaseInstruction
from src.register_type import RegisterType

import re

class InitReg(BaseInstruction):
    def to_fill_node(self):
        dest  = self.node.instruction[1]
        value = self.node.instruction[2]

        if value.isdigit():
            reg_type = RegisterType.INT32
            self.decompiler_data.init_entry_reg(self.node.state, dest, value, reg_type)
            return self.node

        if value == "get_work_dim()":
            reg_type = RegisterType.WORK_DIM
            self.decompiler_data.init_entry_reg(self.node.state, dest, value, reg_type)
            return self.node

        match = re.match(r'(get_group_id|get_local_id|get_global_offset|get_num_groups|get_local_size)\((\d)\)', value)

        
        if match:
            func, idx_str = match.groups()
            idx = int(idx_str)
            
            # Маппинг функций на типы регистров
            reg_type_map = {
                'get_group_id': [
                    RegisterType.WORK_GROUP_ID_X,
                    RegisterType.WORK_GROUP_ID_Y,
                    RegisterType.WORK_GROUP_ID_Z
                ],
                'get_local_id': [
                    RegisterType.WORK_ITEM_ID_X,
                    RegisterType.WORK_ITEM_ID_Y,
                    RegisterType.WORK_ITEM_ID_Z
                ],
                'get_global_offset': [
                    RegisterType.GLOBAL_OFFSET_X,
                    RegisterType.GLOBAL_OFFSET_Y,
                    RegisterType.GLOBAL_OFFSET_Z
                ],
                'get_num_groups': [
                    RegisterType.NUM_GROUPS_X,
                    RegisterType.NUM_GROUPS_Y,
                    RegisterType.NUM_GROUPS_Z
                ],
                'get_local_size': [
                    RegisterType.LOCAL_SIZE_X,
                    RegisterType.LOCAL_SIZE_Y,
                    RegisterType.LOCAL_SIZE_Z
                ],
            }
            
            reg_type = reg_type_map[func][idx]
            self.decompiler_data.init_entry_reg(self.node.state, dest, value, reg_type)
            return self.node
        
        return None