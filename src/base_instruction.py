class BaseInstruction:
    def execute(self, node, instruction, flag_of_status, suffix):
        raise NotImplementedError()
