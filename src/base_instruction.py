class BaseInstruction(object):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        raise NotImplementedError()
