import argparse
import re
import sys

from src.decompiler import process_src
from src.decompiler_data import DecompilerData


def main(input_par, output_par, flag_for_decompilation):
    with open(output_par, 'w') as output_file:

        with open(input_par, 'r') as file:
            body_of_file = file.read().splitlines()
        status_of_parse = "start"
        set_of_instructions = []
        set_of_global_data_instruction = []
        set_of_config = []
        set_of_global_data_bytes = []
        name_of_program = ""
        decompiler_data = DecompilerData()
        for row in body_of_file:
            row = re.sub(r"/\*(.*?)\*/", '', row)
            row = row.strip()
            if ".kernel " in row:
                if status_of_parse == "instruction":
                    status_of_parse = "kernel"
                    decompiler_data.reset(output_file, flag_for_decompilation)
                    process_src(name_of_program, set_of_config, set_of_instructions, set_of_global_data_bytes,
                                set_of_global_data_instruction)
                    output_file.write("\n")
                    set_of_instructions = []
                    set_of_config = []
                name_of_program = row.split()[1]
            if row == ".config":
                status_of_parse = "config"
            elif row == ".text":
                status_of_parse = "instruction"
            elif row == ".gdata:":
                status_of_parse = "global_data"
            elif status_of_parse == "instruction":
                if ".gdata" in row:
                    set_of_global_data_instruction.append(row)
                set_of_instructions.append(row)
            elif status_of_parse == "config":
                set_of_config.append(row)
            elif status_of_parse == "global_data":
                line_of_bytes = row.split()
                if line_of_bytes.pop(0) == ".fill":
                    amount = line_of_bytes[0][:-1]
                    value = line_of_bytes[2]
                    expand_list = [value for _ in range(int(amount))]
                    set_of_global_data_bytes += expand_list
                else:
                    for i, elem in enumerate(line_of_bytes):
                        line_of_bytes[i] = re.sub(',', '', elem)
                    set_of_global_data_bytes += line_of_bytes

            else:
                continue
        decompiler_data.reset(output_file, flag_for_decompilation)
        process_src(name_of_program, set_of_config, set_of_instructions, set_of_global_data_bytes,
                    set_of_global_data_instruction)


def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', help='path to .asm input file')
    parser.add_argument('-o', '--output', help='path to .cl output file')
    parser.add_argument('-f', '--flag', help='approach to parse', nargs='?',
                        choices=['auto_decompilation', 'only_opencl', 'only_clrx'], default='auto_decompilation')
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
