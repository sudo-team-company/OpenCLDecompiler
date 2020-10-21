from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class SBranch(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        reladdr = instruction[1]
        if decompiler_data.to_node.get(reladdr) is not None:
            node.add_child(decompiler_data.to_node[reladdr])
            decompiler_data.to_node[reladdr].add_parent(node)
        else:
            if decompiler_data.from_node.get(reladdr) is None:
                decompiler_data.from_node[reladdr] = [node]
            else:
                decompiler_data.from_node[reladdr].append(node)
        node.instruction = "branch"
        return node
