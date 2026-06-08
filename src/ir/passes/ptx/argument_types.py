from __future__ import annotations

from src.ir.instructions.common.typed_memory import MemoryAccessType, TypedMemoryLoad
from src.ir.passes.base import PassContext
from src.opencl_types import evaluate_size, make_asm_type


class InferPTXArgumentTypesPass:
    name = "infer-ptx-argument-types"

    def run(self, kernel, context: PassContext) -> None:
        inferred_types = context.metadata.setdefault("ptx_inferred_argument_types", {})
        inferred_count = 0

        for instruction in kernel.instructions.get():
            if not isinstance(instruction, TypedMemoryLoad):
                continue

            if instruction.address.name != "argptr":
                continue

            if instruction.access_type.vector_width <= 1:
                continue

            offset = self._parse_int_value(instruction.offset.value)
            if offset is None:
                continue

            argument = kernel.arguments.get_by_offset(offset)
            if argument is None or argument.name.startswith("*"):
                continue

            type_name = self._infer_type_name(instruction.access_type, argument)
            inferred_type = inferred_types.get(offset)
            if inferred_type is not None:
                continue

            if not kernel.arguments.update_type_by_offset(offset, type_name):
                continue

            inferred_types[offset] = type_name
            inferred_count += 1

        context.metadata["ptx_argument_types_inferred"] = inferred_count

    @staticmethod
    def _infer_type_name(access_type: MemoryAccessType, argument) -> str:
        type_name = access_type.to_value_type()
        declared_size = argument.declared_size if argument.declared_size else argument.size
        element_size = access_type.element_bits // 8

        if declared_size <= 0 or element_size <= 0:
            return type_name

        if declared_size % element_size != 0:
            return type_name

        declared_vector_width = declared_size // element_size
        if declared_vector_width <= access_type.vector_width:
            return type_name

        declared_type = MemoryAccessType(
            access_type.address_space,
            access_type.base_type,
            declared_vector_width,
        ).to_value_type()
        declared_type_size, _ = evaluate_size(make_asm_type(declared_type))
        if declared_type_size != declared_size:
            return type_name

        return declared_type

    @staticmethod
    def _parse_int_value(value: str) -> int | None:
        try:
            return int(value, 0)
        except ValueError:
            return None
