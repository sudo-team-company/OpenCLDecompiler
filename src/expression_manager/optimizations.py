from src.decompiler_data import DecompilerData
from src.register_type import RegisterType

#todo also move here simplifactions for different operations?? like + and so on, so we can remove all if checks

simplify_mappings = {
    **{
        frozenset(
            {
                f"get_global_offset({i})",
                f"get_local_id({i})",
                f"get_group_id({i}) * get_local_size({i})",
            }
        ): (
            f"get_global_id({i})",
        )
        for i, _ in enumerate("XYZ")
    },
    **{
        frozenset(
            {
                f"get_global_offset({i})",
                f"get_group_id({i}) * get_local_id({i})",
            }
        ): (
            f"get_global_id({i})",
        )
        for i, _ in enumerate("XYZ")
    },
    **{
        frozenset(
            {
                f"get_local_id({i})",
                RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE_OFFSET"],
            }
        ): (
            f"get_global_id({i})",
        )
        for i, _ in enumerate("XYZ")
    },
    **{
        frozenset(
            {
                f"get_global_offset({i})",
                f"get_local_id({i})",
                f"get_group_id({i}) * get_local_size({i})",
            }
        ): (
            f"get_global_id({i})",
        )
        for i, _ in enumerate("XYZ")
    },
    **{
        frozenset(
            {
                f"get_global_offset({i})",
                f"get_group_id({i}) * get_local_id({i})",
            }
        ): (
            f"get_global_id({i})"
        )
        for i, _ in enumerate("XYZ")
    },
    **{
        frozenset(
            {
                f"get_local_id({i})",
                RegisterType[f"WORK_GROUP_ID_{dim}_LOCAL_SIZE_OFFSET"],
            }
        ): (
            f"get_global_id({i})"
        )
        for i, _ in enumerate("XYZ")
    },
    **{
        frozenset(
            {
                f"get_num_groups({i})",
                f"get_group_id({i}) * get_local_size({i})",
            }
        ): (
            f"get_global_size({i})",
        )
        for i, _ in enumerate("XYZ")
    },
    **{
        frozenset(
            {
                f"get_group_id({i})",
                DecompilerData().config_data.size_of_work_groups[i],
            }
        ): (
            f"get_group_id({i}) * get_local_size({i})",
        )
        for i, _ in enumerate("XYZ")
    }
}

self._instruction_internal_mapping_by_types = {
    (
        f"get_group_id({i})",
        size_of_work_groups[i],
        f"get_local_id({i})"
    ): (
        f"get_global_id({i}) - get_global_offset({i})"
        if not self.decompiler_data.is_rdna3
        else [f"get_global_id({i})", f"get_global_offset({i})"],
        RegisterType[f"WORK_GROUP_ID_{dim}_WORK_ITEM_ID"]
        if not self.decompiler_data.is_rdna3
        else [f"get_global_id({i})", RegisterType[f"GLOBAL_OFFSET_{dim}"]],
        RegisterSignType.POSITIVE
        if not self.decompiler_data.is_rdna3
        else [RegisterSignType.POSITIVE, RegisterSignType.NEGATIVE],
        [f"get_global_id({i})", RegisterType[f"GLOBAL_OFFSET_{dim}"]],
    )
    for i, _ in enumerate("XYZ")
    if i < len(size_of_work_groups)
}

_mul_simplify_combinations = [
                *[
                    (
                        frozenset(
                            {
                                f"get_group_id({i})",
                                DecompilerData().config_data.size_of_work_groups[i],
                            }
                        ),
                        (
                            f"get_group_id({i}) * get_local_size({i})",
                        ),
                    )
                    for i, _ in enumerate("XYZ")
                ]
            ]