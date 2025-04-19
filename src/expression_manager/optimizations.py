from src.decompiler_data import DecompilerData

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
                f"get_local_id({i})",
                f"get_group_id({i}) * get_local_size({i})",
            }
        ): (
            f"get_global_id({i}) - get_global_offset({i})",
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