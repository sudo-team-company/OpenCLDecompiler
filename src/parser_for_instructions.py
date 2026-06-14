import argparse
import sys
from pathlib import Path

from src.decompiler_data import DecompilerData
from src.flag_type import FlagType
from src.graph import GraphType
from src.graph.control_flow_graph import CONTROL_FLOW_GRAPH_ENABLED_CONTEXT_KEY, ControlFlowGraph
from src.ir.asm_to_ir.amd.asm_to_ir import text_to_ir as text_to_ir_amd
from src.ir.asm_to_ir.ptx.asm_to_ir import text_to_ir as text_to_ir_ptx
from src.ir.passes.base import PassContext
from src.ir.passes.pipelines import AMD_PIPELINE, AMD_TEXT_IR_PIPELINE, PTX_PIPELINE, PTX_TEXT_IR_PIPELINE
from src.kernel_parser import parse_kernel as parse_kernel_amd
from src.kernel_parser.ptx_parser import parse_kernel as parse_kernel_ptx
from src.utils import get_context

CONTEXT = get_context()


def main(input_par, output_par, flag_for_decompilation, cfg_path, unrolling_limit=16, emit="opencl"):  # noqa: PLR0913
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
        context = PassContext(metadata={"output_file": output_file})

        flag_newline = False
        if Path(input_par).suffix == ".ptx":
            pipeline = PTX_TEXT_IR_PIPELINE if emit == "ir" else PTX_PIPELINE
            ptx_kernel = parse_kernel_ptx(body_of_file.splitlines())
            for func in ptx_kernel:
                kernel = text_to_ir_ptx(func)
                if flag_newline:
                    output_file.write("\n")
                flag_newline = True
                pipeline.run(kernel, context)
        else:
            pipeline = AMD_TEXT_IR_PIPELINE if emit == "ir" else AMD_PIPELINE
            functions_data, decompiler_data.gpu = parse_kernel_amd(body_of_file.splitlines())
            for function_data in functions_data:
                function_data[1].kernel_name = function_data[0]
                kernel = text_to_ir_amd(function_data[2], function_data[1], function_data[3], function_data[4])
                if flag_newline:
                    output_file.write("\n")
                flag_newline = True
                pipeline.run(kernel, context)


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
    parser.add_argument(
        "--emit",
        choices=["opencl", "ir"],
        default="opencl",
        help="output format",
    )
    return parser


def start_point():
    namespace = create_parser().parse_args(sys.argv[1:])
    if not (namespace.input or namespace.output):
        print("""
            Missing some parameters
            Usage:
              'python parser_for_instructions.py --input <input_file.asm> --output <output_file.cl>'
              'python parser_for_instructions.py -i <input_file.asm> -o <output_file.cl>'
            """)  # noqa: T201
    else:
        main(
            namespace.input, namespace.output, namespace.flag, namespace.cfg, namespace.unrolling_limit, namespace.emit
        )


if __name__ == "__main__":
    start_point()
