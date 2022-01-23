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
    config_data = handlers[decompiler_data.driver_format].process_config(set_of_config)
    decompiler_data.init_work_group(config_data.dimensions, config_data.usesetup)
    decompiler_data.process_size_of_work_groups(config_data.size_of_work_groups)
    decompiler_data.process_local_size(config_data.local_size)
    decompiler_data.process_initial_state()
    decompiler_data.configuration_output += "void " + decompiler_data.name_of_program + "("
    for num_of_param, (type_param, name_param) in enumerate(config_data.params):
        decompiler_data.make_params(num_of_param, name_param, type_param)
    decompiler_data.configuration_output += ", ".join(map(lambda p: p[0] + " " + p[1], config_data.params))
    decompiler_data.configuration_output += ")\n"
