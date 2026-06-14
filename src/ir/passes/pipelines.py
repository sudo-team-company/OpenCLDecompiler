from src.ir.passes.base import PassPipeline
from src.ir.passes.decompilation import (
    BuildDecompilerCfgPass,
    BuildRegionGraphPass,
    EmitOpenCLPass,
    FinalizeDecompilerValuesPass,
    KernelToDecompilerPipelineAdaptor,
    NormalizeDecompilerStatePass,
    ProcessUnrolledLoopsPass,
    RenderControlFlowGraphPass,
)
from src.ir.passes.kernel import (
    EmitTextIRPass,
    MaterializeArgumentStoresPass,
    MaterializeMemoryPass,
    MaterializePredicatePass,
)
from src.ir.passes.ptx import (
    BuildRegisterFlowPass,
    InferPTXArgumentTypesPass,
    InferPTXPointerTypesPass,
    PTXPredicatesPass,
)

PTX_PRE_DECOMPILATION_PIPELINE = PassPipeline.named(
    "ptx-pre-decompilation",
    [
        BuildRegisterFlowPass(),
        InferPTXArgumentTypesPass(),
        InferPTXPointerTypesPass(),
        PTXPredicatesPass(),
    ],
)

COMMON_KERNEL_LOWERING_PIPELINE = PassPipeline.named(
    "common-kernel-lowering",
    [
        MaterializeArgumentStoresPass(),
        MaterializeMemoryPass(),
        MaterializePredicatePass(),
    ],
)

CORE_DECOMPILATION_PIPELINE = PassPipeline.named(
    "core-decompilation",
    [
        BuildDecompilerCfgPass(),
        NormalizeDecompilerStatePass(),
        BuildRegionGraphPass(),
    ],
)

DIAGNOSTIC_OUTPUT_PIPELINE = PassPipeline.named(
    "diagnostic-output",
    [
        RenderControlFlowGraphPass(),
    ],
)

POST_DECOMPILATION_PIPELINE = PassPipeline.named(
    "post-decompilation",
    [
        FinalizeDecompilerValuesPass(),
        ProcessUnrolledLoopsPass(),
    ],
)

EMIT_OPENCL_PIPELINE = PassPipeline.named(
    "emit-opencl",
    [
        EmitOpenCLPass(),
    ],
)

DECOMPILATION_PIPELINE = PassPipeline.named(
    "decompilation",
    [
        CORE_DECOMPILATION_PIPELINE,
        DIAGNOSTIC_OUTPUT_PIPELINE,
        POST_DECOMPILATION_PIPELINE,
        EMIT_OPENCL_PIPELINE,
    ],
)

KERNEL_DECOMPILATION_PIPELINE = PassPipeline.named(
    "kernel-decompilation",
    [
        KernelToDecompilerPipelineAdaptor(DECOMPILATION_PIPELINE),
    ],
)

TEXT_IR_PIPELINE = PassPipeline.named(
    "text-ir",
    [
        EmitTextIRPass(),
    ],
)

PTX_PIPELINE = PassPipeline.named(
    "ptx",
    [
        PTX_PRE_DECOMPILATION_PIPELINE,
        COMMON_KERNEL_LOWERING_PIPELINE,
        KERNEL_DECOMPILATION_PIPELINE,
    ],
)

PTX_TEXT_IR_PIPELINE = PassPipeline.named(
    "ptx-text-ir",
    [
        PTX_PRE_DECOMPILATION_PIPELINE,
        COMMON_KERNEL_LOWERING_PIPELINE,
        TEXT_IR_PIPELINE,
    ],
)

AMD_PIPELINE = PassPipeline.named(
    "amd",
    [
        COMMON_KERNEL_LOWERING_PIPELINE,
        KERNEL_DECOMPILATION_PIPELINE,
    ],
)

AMD_TEXT_IR_PIPELINE = PassPipeline.named(
    "amd-text-ir",
    [
        COMMON_KERNEL_LOWERING_PIPELINE,
        TEXT_IR_PIPELINE,
    ],
)
