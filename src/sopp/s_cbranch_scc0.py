from base_instruction import BaseInstruction
from decompiler_data import DecompilerData


class SCbranchScc0(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        decompiler_data = DecompilerData.Instance()
        reladdr = instruction[1]
        if flag_of_status:
            if decompiler_data.to_node.get(reladdr) is not None:
                node.add_child(decompiler_data.to_node[reladdr])
                decompiler_data.to_node[reladdr].add_parent(node)
            else:
                if decompiler_data.from_node.get(reladdr) is None:
                    decompiler_data.from_node[reladdr] = [node]
                else:
                    decompiler_data.from_node[reladdr].append(node)
            return node
        output_string = node.state.registers["scc"].val
        return output_string
