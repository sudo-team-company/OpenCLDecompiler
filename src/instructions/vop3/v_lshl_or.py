from src.types.opencl_types import OpenCLTypes
from src.base_instruction import BaseInstruction
from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import set_reg, set_reg_value
from src.expression_manager.expression_node import ExpressionOperationType
from src.integrity import Integrity
from src.operation_register_content import OperationRegisterContent, OperationType
from src.register import RegisterSignType, is_reg
from src.register_content import CONSTANT_VALUES
from src.register_type import RegisterType


class VLshlOr(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst, self.src0, self.src1, self.src2 = self.instruction[1:5]
        size_of_work_groups = self.decompiler_data.config_data.size_of_work_groups
        self._instruction_internal_mapping_by_types = {
            (
                RegisterType[f"WORK_GROUP_ID_{dim}"],
                size_of_work_groups[i],
                RegisterType[f"WORK_ITEM_ID_{dim}"],
            ): (
                f"get_global_id({i}) - get_global_offset({i})"
                if not self.decompiler_data.is_rdna3
                else [f"get_global_id({i})", f"get_global_offset({i})"],
                RegisterType[f"WORK_GROUP_ID_{dim}_WORK_ITEM_ID"]
                if not self.decompiler_data.is_rdna3
                else [RegisterType[f"GLOBAL_ID_{dim}"], RegisterType[f"GLOBAL_OFFSET_{dim}"]],
                RegisterSignType.POSITIVE
                if not self.decompiler_data.is_rdna3
                else [RegisterSignType.POSITIVE, RegisterSignType.NEGATIVE],
            )
            for i, dim in enumerate("XYZ")
            if i < len(size_of_work_groups)
        }

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(f"{self.vdst} = ({self.src0} << {self.src1}) | {self.src2} // {self.name}\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32" and is_reg(self.src0) and self.src1.isdigit() and is_reg(self.src2):
            src0_type = self.node.state[self.src0].type
            src1_type = self.node.state[self.src2].type
            if isinstance(src0_type, list):
                src0_type = src0_type[0]
            if isinstance(self.node.state[self.src2].register_content, CombinedRegisterContent):
                src1_type = self.node.state[self.src2].get_type()
            src_types = (
                src0_type,
                pow(2, int(self.src1)),
                src1_type,
            )
            if src_types in self._instruction_internal_mapping_by_types:
                new_value, reg_type, reg_sign = self._instruction_internal_mapping_by_types[src_types]
                
                # #todo - rewrite this
                reg_values = new_value.split(" - ") if self.decompiler_data.is_rdna3 == False else new_value
                reg_types = []
                for v in reg_values:
                    for t in CONSTANT_VALUES:
                        if v == CONSTANT_VALUES[t][0]:
                            reg_types.append(t)
                            break
                
                assert(len(reg_values) == len(reg_types))

                left_node, right_node = map(lambda t: self.expression_manager.add_register_node(t, str(CONSTANT_VALUES[t][0])), reg_types)
                expr_node = self.expression_manager.add_operation(left_node, right_node, ExpressionOperationType.MINUS, OpenCLTypes.UINT)

                if self.decompiler_data.is_rdna3:
                    return set_reg_value(
                        self.node,
                        new_value,
                        self.vdst,
                        [self.src0, self.src1, self.src2],
                        self.suffix,
                        reg_type=reg_type,
                        register_content_type=OperationRegisterContent,
                        sign=reg_sign,
                        operation=OperationType.PLUS,
                    )

                return set_reg_value(
                    node=self.node,
                    new_value=new_value,
                    to_reg=self.vdst,
                    from_regs=[self.src0, self.src1, self.src2],
                    data_type=self.suffix,
                    reg_type=reg_type,
                    integrity=Integrity.ENTIRE,
                    expression_node=expr_node
                )

        new_reg = self.node.state[self.src0] << int(self.src1)
        new_reg = new_reg | self.node.state[self.src2]
        return set_reg(
            node=self.node,
            to_reg=self.vdst,
            from_regs=[self.src0, self.src1, self.src2],
            reg=new_reg,
        )
