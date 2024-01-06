# import copy
# import itertools
# from typing import Optional, Union
#
# from src.integrity import Integrity
# from src.register import Register
# from src.register_content import RegisterSignType
# from src.register_type import RegisterType
#
# _SIMPLIFY_COMBINATIONS = [
#     *[
#         (
#             frozenset({
#                 RegisterType.__getattr__(f"GLOBAL_OFFSET_{dim}"),
#                 RegisterType.__getattr__(f"WORK_ITEM_ID_{dim}"),
#                 RegisterType.__getattr__(f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"),
#             }),
#             (
#                 f"get_global_id({i})",
#                 RegisterType.__getattr__(f"GLOBAL_ID_{dim}"),
#                 RegisterSignType.POSITIVE,
#             )
#         )
#         for i, dim in enumerate("XYZ")
#     ],
#     *[
#         (
#             frozenset({
#                 RegisterType.__getattr__(f"GLOBAL_OFFSET_{dim}"),
#                 RegisterType.__getattr__(f"WORK_GROUP_ID_{dim}_WORK_ITEM_ID"),
#             }),
#             (
#                 f"get_global_id({i})",
#                 RegisterType.__getattr__(f"GLOBAL_ID_{dim}"),
#                 RegisterSignType.POSITIVE,
#             )
#         )
#         for i, dim in enumerate("XYZ")
#     ],
#     *[
#         (
#             frozenset({
#                 RegisterType.__getattr__(f"WORK_ITEM_ID_{dim}"),
#                 RegisterType.__getattr__(f"WORK_GROUP_ID_{dim}_LOCAL_SIZE_OFFSET"),
#             }),
#             (
#                 f"get_global_id({i})",
#                 RegisterType.__getattr__(f"GLOBAL_ID_{dim}"),
#                 RegisterSignType.POSITIVE,
#             )
#         )
#         for i, dim in enumerate("XYZ")
#     ],
#     *[
#         (
#             frozenset({
#                 RegisterType.__getattr__(f"NUM_GROUPS_{dim}"),
#                 RegisterType.__getattr__(f"WORK_GROUP_ID_{dim}_LOCAL_SIZE"),
#             }),
#             (
#                 f"get_global_size({i})",
#                 RegisterType.__getattr__(f"GLOBAL_SIZE_{dim}"),
#                 RegisterSignType.POSITIVE,
#             )
#         )
#         for i, dim in enumerate("XYZ")
#     ],
# ]
#
#
# class SumRegister(Register):
#     def __init__(self, registers: list[Register]):
#         super().__init__(
#             val=[register.val for register in registers],
#             type_of_elem=[register.type for register in registers],
#             integrity=Integrity.ENTIRE,
#             sign=[register.sign for register in registers]
#         )
#
#     def get_value(self) -> str:
#         positive_values = []
#         negative_values = []
#
#         for value, sign in zip(self.val, self.sign):
#             if sign == RegisterSignType.POSITIVE:
#                 positive_values.append(value)
#
#             if sign == RegisterSignType.NEGATIVE:
#                 negative_values.append(value)
#
#         positive_value = " + ".join(positive_values)
#         negative_values = " - ".join(negative_values)
#
#         if positive_value != "" and negative_values != "":
#             if positive_value == "":
#                 return f"-{negative_values}"
#             else:
#                 return f"{positive_value} - {negative_values}"
#         else:
#             if positive_value != "":
#                 return positive_value
#             if negative_values != "":
#                 return f"-{negative_values}"
#
#     def __add__(self, other) -> Union["SumRegister", Register]:
#         if not isinstance(other, Register):
#             raise Exception(f"Cannot proceed add operation with type {type(other)}")
#
#         new_reg: SumRegister = SumRegister([])
#         new_reg.val = copy.copy(self.val)
#         new_reg.type = copy.copy(self.type)
#         new_reg.sign = copy.copy(self.sign)
#
#         reg = other
#         reg.try_unwrap_value()
#         self.try_unwrap_value()
#
#         if isinstance(reg.val, list) and isinstance(reg.type, list):
#             if len(reg.val) != len(reg.type):
#                 raise Exception("Length of val and type must be equals")
#             new_reg.val.extend(copy.copy(reg.val))
#             new_reg.type.extend(copy.copy(reg.type))
#             new_reg.sign.extend(copy.copy(reg.sign))
#         else:
#             if isinstance(reg.val, RegisterContentCombiner):
#                 new_reg.val.append(reg.val.maybe_get_by_idx(0).content)
#                 new_reg.type.append(reg.val.maybe_get_by_idx(0).type)
#                 new_reg.sign.append(reg.sign)
#             else:
#                 new_reg.val.append(reg.val)
#                 new_reg.type.append(reg.type)
#                 new_reg.sign.append(reg.sign)
#
#         # self.inc_version()
#         while new_reg._try_simplify():
#             pass
#
#         if len(new_reg.val) == 1 and len(new_reg.type) == 1:
#             return Register(
#                 val=new_reg.val[0],
#                 type_of_elem=new_reg.type[0],
#                 integrity=Integrity.ENTIRE,
#                 sign=new_reg.sign[0],
#             )
#
#         return new_reg
#
#     def _try_simplify(self) -> bool:
#         def maybe_find_opposite_pos() -> Optional[tuple[int, int]]:
#             for i in range(len(self.type)):
#                 for j in range(len(self.type)):
#                     if i >= j:
#                         continue
#
#                     if self.type[i] == self.type[j] and self.val[i] == self.val[j] and self.sign[i] != self.sign[j]:
#                         return i, j
#             return None
#
#         def maybe_find_types_pos(types: tuple[RegisterType]) -> Optional[list[int]]:
#             if len(types) == 0:
#                 return []
#
#             type_to_find = types[0]
#             for i, type_ in enumerate(self.type):
#                 if type_ == type_to_find:
#                     rest_pos = maybe_find_types_pos(types[1:])
#
#                     if rest_pos is None:
#                         return None
#
#                     result: list[int] = [i]
#                     result.extend(rest_pos)
#
#                     return result
#
#             return None
#
#         def delete_elements_by_pos_list(pos_list: list[int]):
#             new_val = []
#             new_type = []
#             new_sign = []
#
#             for i, val_elem in enumerate(self.val):
#                 if i in pos_list:
#                     continue
#
#                 new_val.append(val_elem)
#
#             for i, type_elem in enumerate(self.type):
#                 if i in pos_list:
#                     continue
#
#                 new_type.append(type_elem)
#
#             for i, sign in enumerate(self.sign):
#                 if i in pos_list:
#                     continue
#
#                 new_sign.append(sign)
#
#             self.val = new_val
#             self.type = new_type
#             self.sign = new_sign
#
#         while True:
#             maybe_pos = maybe_find_opposite_pos()
#
#             if maybe_pos is None:
#                 break
#
#             i, j = maybe_pos
#             delete_elements_by_pos_list([i, j])
#
#             return True
#
#
#         for simplify_combination in _SIMPLIFY_COMBINATIONS:
#             types_to_find, simplification = simplify_combination
#             types_to_find_permutations = list(itertools.permutations(types_to_find))
#
#             for permutation in types_to_find_permutations:
#                 maybe_pos_list = maybe_find_types_pos(permutation)
#
#                 if maybe_pos_list is not None:
#                     delete_elements_by_pos_list(maybe_pos_list)
#
#                     simplified_value, simplified_type, simplified_sign = simplification
#                     self.val.append(simplified_value)
#                     self.type.append(simplified_type)
#                     self.sign.append(simplified_sign)
#
#                     return True
#
#         return False
#
