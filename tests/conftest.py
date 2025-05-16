import platform
import subprocess
from pathlib import Path

from src.parser_for_instructions import main


def get_disasm_path(name: str) -> str:
    ext = ".exe" if platform.system() == "Windows" else ""
    path = Path() / "bin" / f"{name}" / f"{name}{ext}"
    return str(path.absolute())


def invoke_clrxdisasm(path_to_bin: str, path_to_asm: str):
    with Path(path_to_asm).open("w", encoding="utf-8") as file:
        subprocess.run([get_disasm_path("clrxdisasm"), path_to_bin, "-dCfs"], stdout=file, check=True)  # noqa: S603
    with Path(path_to_asm).open(encoding="utf-8") as file:
        text: list[str] = file.readlines()
    parts = text[0].split("'")
    parts[1] = parts[1].replace("/", "\\")
    text[0] = "'".join(parts)
    with Path(path_to_asm).open("w", encoding="utf-8") as file:
        file.writelines(text)


def invoke_amdgpu_dis(path_to_bin: str, path_to_asm: str):
    subprocess.run([get_disasm_path("amdgpu-dis"), path_to_bin, "-o", path_to_asm], check=True)  # noqa: S603


DISASMS = {
    "clrxdisasm": invoke_clrxdisasm,
    "amdgpu-dis": invoke_amdgpu_dis,
}


def template(
    path_to_dir: str,
    dir_name: str,
    flag: str | None = None,
    mcpu: str = "",
    disasm: str = "clrxdisasm",
):
    if mcpu == "amd_gcn":
        mcpu = ""
    if mcpu:
        mcpu = f"-{mcpu}"
    test_root = Path() / path_to_dir / dir_name
    path_to_bin = str(test_root / f"{dir_name}{mcpu}.bin")
    path_to_asm = str(test_root / f"{dir_name}{mcpu}.asm")
    path_to_cl = str(test_root / f"{dir_name}_dcmpl{mcpu}.cl")

    DISASMS.get(disasm)(path_to_bin=path_to_bin, path_to_asm=path_to_asm)

    main(path_to_asm, path_to_cl, flag or "AUTO_DECOMPILATION", None)

    hands = test_root / f"{dir_name}_hands.cl"
    if "gfx" in mcpu and (test_root / f"{dir_name}_hands{mcpu}.cl").exists():
        hands = test_root / f"{dir_name}_hands{mcpu}.cl"
    elif "gfx" in mcpu and (test_root / f"{dir_name}_hands-gfx.cl").exists():
        hands = test_root / f"{dir_name}_hands-gfx.cl"
    assert Path(path_to_cl).read_text(encoding="utf-8") == Path(hands).read_text(encoding="utf-8")
