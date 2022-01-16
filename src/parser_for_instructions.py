import argparse
import sys

from src.decompiler import process_src
from src.decompiler_data import DecompilerData
from src.driver_format import DriverFormat
from src.flag_type import FlagType
from src.kernel_parser import parse_kernel


def main(input_par, output_par, flag_for_decompilation):
    with open(output_par, 'w', encoding="utf-8") as output_file:

        with open(input_par, 'r', encoding="utf-8") as file:
            body_of_file = file.read().splitlines()

        decompiler_data = DecompilerData()
        decompiler_data.driver_format = DriverFormat(body_of_file)
        decompiler_data.output_file = output_file
        decompiler_data.flag_for_decompilation = FlagType(flag_for_decompilation)

        flag_newline = False
        for name_of_program, set_of_config, set_of_instructions, \
            set_of_global_data_bytes, set_of_global_data_instruction \
                in parse_kernel(body_of_file):
            if flag_newline:
                output_file.write("\n")
            flag_newline = True
            decompiler_data.reset()
            process_src(name_of_program, set_of_config, set_of_instructions,
                        set_of_global_data_bytes,
                        set_of_global_data_instruction)


def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', help='path to .asm input file')
    parser.add_argument('-o', '--output', help='path to .cl output file')
    parser.add_argument('-f', '--flag', help='approach to parse', nargs='?',
                        choices=['AUTO_DECOMPILATION', 'ONLY_OPENCL', 'ONLY_CLRX'],
                        default='AUTO_DECOMPILATION')
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
        main(namespace.input, namespace.output, namespace.flag)


if __name__ == "__main__":
    start_point()
