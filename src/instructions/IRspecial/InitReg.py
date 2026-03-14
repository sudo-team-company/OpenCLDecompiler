from src.base_instruction import BaseInstruction
from src.register_type import RegisterType

import re

class InitReg(BaseInstruction):
    def to_fill_node(self):
        dest  = self.node.instruction[1]
        value = self.node.instruction[2]
        match = re.match(r'(get_group_id|get_local_id)\((\d)\)', value)
        
        func, idx_str = match.groups()
        idx = int(idx_str)
        if func == 'get_group_id':
            reg_type = [RegisterType.WORK_GROUP_ID_X,
                        RegisterType.WORK_GROUP_ID_Y,
                        RegisterType.WORK_GROUP_ID_Z][idx]
        elif func == 'get_local_id':
            reg_type = [RegisterType.WORK_ITEM_ID_X,
                        RegisterType.WORK_ITEM_ID_Y,
                        RegisterType.WORK_ITEM_ID_Z][idx]
            
        self.decompiler_data.init_entry_reg(self.node.state, dest, value, reg_type)
        return self.node