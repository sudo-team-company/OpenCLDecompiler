import argparse
import sys

from parsers.asm_parser.amdgpu_dis_format import AmdGpuDisParser
from src.decompiler import process_src
from src.decompiler_data import DecompilerData
from src.flag_type import FlagType
from src.kernel_parser import parse_kernel
from src.utils import ConfigData


def main(input_par, output_par, flag_for_decompilation, is_new_parser: bool):
    with open(output_par, 'w', encoding="utf-8") as output_file:

        with open(input_par, 'r', encoding="utf-8") as file:
            body_of_file = file.read()

        decompiler_data = DecompilerData()
        decompiler_data.output_file = output_file
        decompiler_data.flag_for_decompilation = FlagType(flag_for_decompilation)

        if is_new_parser:
            parser = AmdGpuDisParser()
            parse_result = parser.parse(body_of_file)[0].obj

            functions_data = [
                (
                    data[0],
                    ConfigData(
                        dimensions="xyz"[:list(
                            filter(
                                lambda x: x[1] != '0x1',
                                enumerate(data[2][".reqd_workgroup_size"])
                            )
                        )[-1][0] + 1],
                        usesetup=False,
                        size_of_work_groups=[
                            int(wg_item_size, 16)
                            for wg_item_size
                            in data[2][".reqd_workgroup_size"]
                        ],
                        local_size=None,
                        params=[
                            (
                                arg['.type_name'].strip("\'").strip("*"),
                                ('*' if arg['.type_name'].strip("\'").endswith('*') else '') + f"arg{idx}"
                            )
                            for idx, arg
                            in enumerate(list(filter(lambda arg: ".type_name" in arg, data[2][".args"])))
                        ],
                        setup_params_offsets=[
                            str(hex(int(arg[".offset"], 16)))
                            for arg
                            in list(filter(lambda arg: ".type_name" not in arg, data[2][".args"]))
                        ],
                    ),
                    [instr.obj.split("//")[0].strip() for instr in data[1]],
                    [],
                    [],
                )
                for data in parse_result
            ]
        else:
            decompiler_data.driver_format, functions_data = parse_kernel(body_of_file.splitlines())

        flag_newline = False
        for function_data in functions_data:
            if flag_newline:
                output_file.write("\n")
            flag_newline = True
            process_src(*function_data, is_rdna3=is_new_parser)


def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', help='path to .asm input file')
    parser.add_argument('-o', '--output', help='path to .cl output file')
    parser.add_argument('-f', '--flag', help='approach to parse', nargs='?',
                        choices=['AUTO_DECOMPILATION', 'ONLY_OPENCL', 'ONLY_CLRX'],
                        default='AUTO_DECOMPILATION')
    parser.add_argument('--new-parser', action="store_true")

    return parser


def start_point():
    namespace = create_parser().parse_args(sys.argv[1:])
    if not (namespace.input or namespace.output):
        print("""
            Missing some parameters 
            Usage: 
              'python parser_for_instructions.py --input <input_file.asm> --output <output_file.cl>'
              'python parser_for_instructions.py -i <input_file.asm> -o <output_file.cl>'
            """)
    else:
        main(namespace.input, namespace.output, namespace.flag, namespace.new_parser)


if __name__ == "__main__":
    start_point()
