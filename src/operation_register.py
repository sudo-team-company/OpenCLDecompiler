# from typing import Union, Iterable
#
# from src.register import Register
# from src.register_content import RegisterContent
#
#
# class OperationRegisterContent:
#     def __init__(
#             self,
#             operation: str,
#             register_contents: list[Union[RegisterContent, "OperationRegisterContent"]]
#     ):
#         self.operation: str = operation
#         self.register_contents: list[Union[RegisterContent, "OperationRegisterContent"]] = register_contents
#
#     def __str__(self) -> str:
#         operation = f" {self.operation} "
#         return f"({operation.join([register_content.content.__str__() for register_content in self.register_contents])})"
#
#
# class OperationRegister(Register):
#     def __init__(
#             self,
#             operand: str,
#             registers: Iterable[Register],
#     ):
#         super().__init__(
#             val=[register.val for register in registers],
#             type_of_elem=[register.type for register in registers],
#             integrity=Integrity.ENTIRE,
#             sign=[register.sign for register in registers]
#         )
