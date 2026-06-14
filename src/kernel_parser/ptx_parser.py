import re

from src.ir.asm_to_ir.ptx.ptx_kernel import PTXArgument, PTXInstruction, PTXKernel, PTXRegister

SPECIAL_REG_PATTERN = re.compile(r"%(?:envreg\d+|(?:ntid|ctaid|tid|nctaid)\.[xyz])")
PREDICATE_PATTERN = re.compile(r"^@(!?)(%[\w.$]+)\s+(.+)$")


def _parse_params(func: PTXKernel, text: str):  # noqa: PLR0912
    text = text.replace(")", "")
    text = text.split("(")[1]
    for raw_entry in text.split(".param"):
        entry = raw_entry.strip()
        if not entry:
            continue

        arg = PTXArgument()
        tokens = entry.split()

        i = 0
        while i < len(tokens):
            tok = tokens[i]

            if tok.startswith("."):
                d = tok[1:]
                if re.match(r"^[usbf](8|16|32|64)$", d):
                    arg.type_name = d
                    m = re.search(r"(\d+)$", d)
                    if m:
                        arg.size = int(m.group(1))
                elif d == "ptr":
                    arg.is_pointer = True
                elif d == "constant":
                    arg.is_const = True
                    arg.address_space = d
                elif d in ("global", "local", "shared", "param"):
                    arg.address_space = d
                elif d == "align" and i + 1 < len(tokens):
                    try:
                        arg.alignment = int(tokens[i + 1])
                        i += 1
                    except ValueError:
                        pass
            else:
                arg.name = tok.rstrip(",")
            i += 1

        if arg.name:
            func.arguments.append(arg)


def _parse_reg(func: PTXKernel, line: str):
    m = re.match(r"\.reg\s+\.(\w+)\s+%(\w+)<(\d+)>", line)
    if m:
        rtype, prefix, count = m.groups()
        for n in range(1, int(count) + 1):
            func.registers.append(PTXRegister(name=f"%{prefix}{n}", reg_type=rtype))
        return


def _parse_locals(func: PTXKernel, line: str):
    m = re.match(r"\.shared\s+(?:\.align\s+\d+\s+)?\.(\w+)\s+([^\s\[]+)\[(\d+)\]", line)
    if m:
        rtype, name, count = m.groups()

        type_size = {
            "b8": 1,
            "b16": 2,
            "b32": 4,
            "b64": 8,
            "u8": 1,
            "s8": 1,
            "u16": 2,
            "s16": 2,
            "u32": 4,
            "s32": 4,
            "u64": 8,
            "s64": 8,
            "f16": 2,
            "f32": 4,
            "f64": 8,
        }

        element_size = type_size.get(rtype)

        total_size = element_size * int(count)
        func.locals[name] = total_size


def _parse_instruction(line: str) -> PTXInstruction:
    text = " ".join(line.rstrip(";").split())
    predicate_match = PREDICATE_PATTERN.match(text)
    if predicate_match is None:
        return PTXInstruction(text=text)

    negation, predicate, body = predicate_match.groups()
    return PTXInstruction(
        text=body.strip(),
        predicate=predicate,
        predicate_negated=bool(negation),
    )


def parse_kernel(lines: list[str]):  # noqa: PLR0912
    func = None
    state = "start"
    param_buffer = ""

    for raw_line in lines:
        line = re.sub(r"//.*$", "", raw_line).strip()
        if not line:
            continue

        if state == "start" and line.startswith(".entry"):
            kernel_name = re.search(r"\.entry\s+(\w+)", line).group(1)
            func = PTXKernel(name=kernel_name)
            state = "params"
            param_buffer = line
            continue

        if state == "params":
            param_buffer += " " + line
            if ")" in line:
                _parse_params(func, param_buffer)
                state = "body"
            continue

        if state == "body":
            if line.startswith(".reqntid"):
                m = re.search(r"\.reqntid\s+(\d+)\s*,\s*(\d+)\s*,\s*(\d+)", line)
                if m:
                    func.work_group_size = [int(m.group(i)) for i in range(1, 4)]

            elif line.startswith(".reg"):
                _parse_reg(func, line)
            elif line.startswith(".shared"):
                _parse_locals(func, line)
            elif line == "{":
                continue

            elif line == "}":
                yield func
                func = None
                state = "start"

            elif line and not line.startswith("."):
                instr = _parse_instruction(line)
                func.instructions.append(instr)
                func.special_registers.extend(SPECIAL_REG_PATTERN.findall(instr.text))
