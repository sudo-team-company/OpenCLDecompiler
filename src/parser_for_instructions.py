import argparse
import sys
from pathlib import Path

from src.decompiler import process_src
from src.decompiler_data import DecompilerData
from src.flag_type import FlagType
from src.graph import GraphType
from src.graph.control_flow_graph import CONTROL_FLOW_GRAPH_ENABLED_CONTEXT_KEY, ControlFlowGraph
from src.kernel_parser import parse_kernel
from src.utils import get_context

CONTEXT = get_context()


def main(input_par, output_par, flag_for_decompilation, cfg_path, unrolling_limit=16):
    CONTEXT.update(
        **{
            f"{CONTROL_FLOW_GRAPH_ENABLED_CONTEXT_KEY}": cfg_path is not None,
        }
    )

    if CONTEXT.get(CONTROL_FLOW_GRAPH_ENABLED_CONTEXT_KEY):
        ControlFlowGraph(
            graph_type=GraphType.DIRECTED,
            render_path=cfg_path,
            kwargs={
                "strict": True,
            },
        )

    with Path(output_par).open("w", encoding="utf-8") as output_file:
        body_of_file = Path(input_par).read_text(encoding="utf-8")

        decompiler_data = DecompilerData()
        decompiler_data.output_file = output_file
        decompiler_data.flag_for_decompilation = FlagType(flag_for_decompilation)
        decompiler_data.unrolling_limit = unrolling_limit

        functions_data, decompiler_data.gpu = parse_kernel(body_of_file.splitlines())

        flag_newline = False
        for function_data in functions_data:
            if flag_newline:
                output_file.write("\n")
            flag_newline = True
            process_src(*function_data)


def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input", help="path to .asm input file")
    parser.add_argument("-o", "--output", help="path to .cl output file")
    parser.add_argument(
        "-f",
        "--flag",
        help="approach to parse",
        nargs="?",
        choices=["AUTO_DECOMPILATION", "ONLY_OPENCL", "ONLY_CLRX"],
        default="AUTO_DECOMPILATION",
    )
    parser.add_argument("--cfg", help="path to output control flow graph")
    parser.add_argument("--unrolling_limit", help="number of repeations to recognize unrolled loop", default=16)
    return parser


def start_point():
    #todo caused by loop_unrolled example, can we fix it in any other way?
    sys.setrecursionlimit(10000)
    namespace = create_parser().parse_args(sys.argv[1:])
    if not (namespace.input or namespace.output):
        print("""
            Missing some parameters
            Usage:
              'python parser_for_instructions.py --input <input_file.asm> --output <output_file.cl>'
              'python parser_for_instructions.py -i <input_file.asm> -o <output_file.cl>'
            """)  # noqa: T201
    else:
        main(namespace.input, namespace.output, namespace.flag, namespace.cfg, namespace.unrolling_limit)


if __name__ == "__main__":
    start_point()
