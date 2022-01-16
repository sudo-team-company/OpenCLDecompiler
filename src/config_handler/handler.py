from src.decompiler_data import DecompilerData
from src.driver_format import DriverFormat
from . import amdcl2_handler, rocm_handler, unknown_handler

handlers = {
    DriverFormat.AMDCL2: amdcl2_handler,
    DriverFormat.ROCM: rocm_handler,
    DriverFormat.UNKNOWN: unknown_handler,
}


def process_config(set_of_config):
    decompiler_data = DecompilerData()
    dimensions, use_setup, size_of_work_groups, local_size, params = \
        handlers[decompiler_data.driver_format].process_config(set_of_config)
    decompiler_data.init_work_group(dimensions, use_setup)
    decompiler_data.process_size_of_work_groups(size_of_work_groups)
    decompiler_data.process_local_size(local_size)
    decompiler_data.process_initial_state()
    decompiler_data.configuration_output += "void " + decompiler_data.name_of_program + "("
    for num_of_param, (type_param, name_param) in enumerate(params):
        decompiler_data.make_params(num_of_param, name_param, type_param)
    decompiler_data.configuration_output += ", ".join(map(lambda p: p[0] + " " + p[1], params))
    decompiler_data.configuration_output += ")\n"
