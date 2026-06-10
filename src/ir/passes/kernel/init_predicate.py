from src.ir.instructions.special.init_predicate import InitPredicate
from src.ir.passes.base import PassContext


class MaterializePredicatePass:
    name = "materialize-predicate"

    def run(self, kernel, _context: PassContext) -> None:
        if kernel.predicates.is_materialized():
            return

        init_predicates = [InitPredicate(predicate=reg) for reg in kernel.predicates.all()]

        kernel.instructions.prepend_list(init_predicates)
        kernel.predicates.mark_materialized()
