from . import amdcl2_parser, rocm_parser, amdgpu_dis_parser, unknown_parser


def _choose_parser(text: list[str]):
    if ".amdcl2" in text:
        return amdcl2_parser
    if ".rocm" in text:
        return rocm_parser
    if "\t.amdgpu_pal_metadata" in text:
        return amdgpu_dis_parser
    return unknown_parser


def parse_gpu(text: list[str]) -> str | None:
    for row in text:
        if row.startswith(".gpu "):
            return row.removeprefix(".gpu ").strip().lower()
    return None


def parse_kernel(text: list[str]):
    gpu = parse_gpu(text)
    return _choose_parser(text).parse_kernel(text), gpu
