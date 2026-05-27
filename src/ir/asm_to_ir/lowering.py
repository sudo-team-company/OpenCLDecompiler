from collections.abc import Callable, Iterable
from dataclasses import dataclass, field
from typing import Any

from src.ir.kernel import OP_TYPE_UNSET, Kernel, OperationTypeArg
from src.ir.registers.reg import PredReg, Reg32, Reg64, Reg_ty, RegOrVal_ty, Val
from src.ir.temporary_variable_allocator import TemporaryVariableAllocator


class LoweringArg:
    def resolve(self, ctx: "InstructionContext") -> Any:
        raise NotImplementedError


@dataclass(frozen=True)
class OperandRef(LoweringArg):
    index: int

    def resolve(self, ctx: "InstructionContext") -> RegOrVal_ty:
        return ctx.operand(self.index)


@dataclass(frozen=True)
class TmpRegRef(LoweringArg):
    name: str
    kind: str

    def resolve(self, ctx: "InstructionContext") -> Reg_ty:
        return ctx.tmp(self.name, self.kind)


@dataclass(frozen=True)
class NamedRegRef(LoweringArg):
    name: str
    kind: str

    def resolve(self, _ctx: "InstructionContext") -> Reg_ty:
        return create_register(self.name, self.kind)


@dataclass(frozen=True)
class ValueRef(LoweringArg):
    value: str

    def resolve(self, _ctx: "InstructionContext") -> Val:
        return Val(self.value)


@dataclass(frozen=True)
class ArgOffsetRef(LoweringArg):
    operand_index: int
    extra_name: str = "args_offset"

    def resolve(self, ctx: "InstructionContext") -> Val:
        offsets = ctx.extras.get(self.extra_name)
        if offsets is None:
            raise MissingLoweringExtraError(self.extra_name)

        operand = ctx.operand(self.operand_index)
        try:
            return offsets[operand.name]
        except KeyError as exc:
            raise MissingArgumentOffsetError(operand.name) from exc


@dataclass
class InstructionContext:
    kernel: Kernel
    operands: list[RegOrVal_ty]
    predicate: str | PredReg | None = None
    predicate_negated: bool = False
    extras: dict[str, Any] = field(default_factory=dict)
    _temps: dict[str, Reg_ty] = field(default_factory=dict, init=False)

    def operand(self, index: int) -> RegOrVal_ty:
        try:
            return self.operands[index]
        except IndexError as exc:
            raise MissingLoweringOperandError(index) from exc

    def tmp(self, name: str, kind: str | int) -> Reg_ty:
        normalized_kind = normalize_register_kind(kind)
        existing = self._temps.get(name)
        if existing is not None:
            expected_class = register_class(normalized_kind)
            if not isinstance(existing, expected_class):
                raise TemporaryRegisterTypeConflictError(name, existing, expected_class)
            return existing

        tmp_name = TemporaryVariableAllocator.generate(f"tmp_{name}")
        new_reg = create_register(tmp_name, normalized_kind)
        self._temps[name] = new_reg
        return new_reg

    def emit(
        self,
        instruction_class: type,
        *args: Any,
        predicate: str | PredReg | None = None,
        predicate_negated: bool | None = None,
        op_type: OperationTypeArg = OP_TYPE_UNSET,
    ) -> None:
        instruction_args = tuple(resolve_arg(arg, self) for arg in args)
        if predicate is None:
            actual_predicate = self.predicate
            actual_predicate_negated = self.predicate_negated
        else:
            actual_predicate = predicate
            actual_predicate_negated = False

        if predicate_negated is not None:
            actual_predicate_negated = predicate_negated

        if actual_predicate is None:
            actual_predicate_negated = False

        if op_type is OP_TYPE_UNSET:
            self.kernel.create_instruction(
                instruction_class,
                *instruction_args,
                predicate=actual_predicate,
                predicate_negated=actual_predicate_negated,
            )
            return

        self.kernel.create_instruction(
            instruction_class,
            *instruction_args,
            predicate=actual_predicate,
            predicate_negated=actual_predicate_negated,
            op_type=op_type,
        )


@dataclass(frozen=True)
class Emit:
    instruction_class: type
    args: tuple[Any, ...]
    predicate: str | PredReg | None = None
    predicate_negated: bool | None = None
    op_type: OperationTypeArg = OP_TYPE_UNSET

    def __init__(
        self,
        instruction_class: type,
        *args: Any,
        predicate: str | PredReg | None = None,
        predicate_negated: bool | None = None,
        op_type: OperationTypeArg = OP_TYPE_UNSET,
    ):
        object.__setattr__(self, "instruction_class", instruction_class)
        object.__setattr__(self, "args", tuple(args))
        object.__setattr__(self, "predicate", predicate)
        object.__setattr__(self, "predicate_negated", predicate_negated)
        object.__setattr__(self, "op_type", op_type)

    def emit(self, ctx: InstructionContext) -> None:
        ctx.emit(
            self.instruction_class,
            *self.args,
            predicate=self.predicate,
            predicate_negated=self.predicate_negated,
            op_type=self.op_type,
        )


RuleCallback = Callable[[InstructionContext], None]


class Rule:
    def __init__(
        self,
        emits: Iterable[Emit] = (),
        callback: RuleCallback | None = None,
    ):
        self._emits = tuple(emits)
        self._callback = callback

    @classmethod
    def dynamic(cls, callback: RuleCallback) -> "Rule":
        return cls(callback=callback)

    def emit(self, ctx: InstructionContext) -> None:
        if self._callback is not None:
            self._callback(ctx)
            return

        for item in self._emits:
            item.emit(ctx)


def same(instruction_class: type, op_type: OperationTypeArg = OP_TYPE_UNSET) -> Rule:
    def emit_same(ctx: InstructionContext) -> None:
        if op_type is OP_TYPE_UNSET:
            ctx.emit(instruction_class, *list(ctx.operands))
            return
        ctx.emit(instruction_class, *list(ctx.operands), op_type=op_type)

    return Rule.dynamic(emit_same)


def op(index: int) -> OperandRef:
    return OperandRef(index)


def tmp32(name: str) -> TmpRegRef:
    return TmpRegRef(name, "32")


def tmp64(name: str) -> TmpRegRef:
    return TmpRegRef(name, "64")


def tmppred(name: str) -> TmpRegRef:
    return TmpRegRef(name, "pred")


def named32(name: str) -> NamedRegRef:
    return NamedRegRef(name, "32")


def named64(name: str) -> NamedRegRef:
    return NamedRegRef(name, "64")


def namedpred(name: str) -> NamedRegRef:
    return NamedRegRef(name, "pred")


def val(value: str | int) -> ValueRef:
    return ValueRef(str(value))


def arg_offset(operand_index: int) -> ArgOffsetRef:
    return ArgOffsetRef(operand_index)


def resolve_arg(arg: Any, ctx: InstructionContext) -> Any:
    if isinstance(arg, LoweringArg):
        return arg.resolve(ctx)
    return arg


def create_register(name: str, kind: str | int) -> Reg_ty:
    normalized_kind = normalize_register_kind(kind)
    if normalized_kind == "32":
        return Reg32(name)
    if normalized_kind == "64":
        return Reg64(name)
    if normalized_kind == "pred":
        return PredReg(name)
    raise UnknownRegisterKindError(kind)


def register_class(kind: str | int) -> type:
    normalized_kind = normalize_register_kind(kind)
    if normalized_kind == "32":
        return Reg32
    if normalized_kind == "64":
        return Reg64
    if normalized_kind == "pred":
        return PredReg
    raise UnknownRegisterKindError(kind)


def normalize_register_kind(kind: str | int) -> str:
    if kind in (32, "32", "b32"):
        return "32"
    if kind in (64, "64", "b64"):
        return "64"
    if kind in ("pred", "predicate"):
        return "pred"
    raise UnknownRegisterKindError(kind)


class MissingLoweringExtraError(KeyError):
    def __init__(self, name: str) -> None:
        super().__init__(f"Lowering extra '{name}' is required")


class MissingArgumentOffsetError(KeyError):
    def __init__(self, operand_name: str) -> None:
        super().__init__(f"No argument offset for operand '{operand_name}'")


class MissingLoweringOperandError(IndexError):
    def __init__(self, index: int) -> None:
        super().__init__(f"Lowering operand %{index} is not available")


class TemporaryRegisterTypeConflictError(TypeError):
    def __init__(self, name: str, existing: Reg_ty, expected_class: type) -> None:
        super().__init__(
            f"Temporary '#{name}' was already created as {existing.__class__.__name__}, not {expected_class.__name__}"
        )


class UnknownRegisterKindError(ValueError):
    def __init__(self, kind: str | int) -> None:
        super().__init__(f"Unknown register kind: {kind}")
