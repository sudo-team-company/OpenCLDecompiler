import argparse
import re
import sys
from decompiler import Decompiler


def main(input_par, output_par):
    output_file = open(output_par, 'w')

    with open(input_par, 'r') as file:
        body_of_file = file.read().splitlines()
    status_of_parse = "start"
    set_of_instructions = []
    set_of_config = []
    name_of_program = ""
    for row in body_of_file:
        row = re.sub("/\*(.*?)\*/", '', row)
        row = row.strip()
        if row.find(".kernel ") != -1:
            if status_of_parse == "instruction":
                status_of_parse = "kernel"
                decompiler = Decompiler(output_file)
                decompiler.process_src(name_of_program, set_of_config, set_of_instructions)
                output_file.write("\n")
                set_of_instructions = []
                set_of_config = []
                name_of_program = ""
            name_of_program = row.split()[1]
        if row == ".config":
            status_of_parse = "config"
        elif row == ".text":
            status_of_parse = "instruction"
        elif status_of_parse == "instruction":
            set_of_instructions.append(row)
        elif status_of_parse == "config":
            set_of_config.append(row)
        else:
            continue
    decompiler = Decompiler(output_file)
    decompiler.process_src(name_of_program, set_of_config, set_of_instructions)
    output_file.close()


def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', help='path to .asm input file')
    parser.add_argument('-o', '--output', help='path to .cl output file')

    return parser


if __name__ == "__main__":
    namespace = create_parser().parse_args(sys.argv[1:])

    if not (namespace.input or namespace.output):
        print("""
            Missing some parameters 
            Usage: 
              'python parser_for_instructions.py --input <input_file.asm> --output <output_file.cl>'
              'python parser_for_instructions.py -i <input_file.asm> -o <output_file.cl>'
            """)
    else:
        main(namespace.input, namespace.output)
