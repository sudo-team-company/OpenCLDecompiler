from src.integrity import Integrity
from src.register_type import RegisterType


class Register:
    def __init__(self, val, type_of_elem, integrity):
        self.val = val
        self.type: RegisterType = type_of_elem
        self.integrity: Integrity = integrity
        self.version = None
        self.prev_version = []
        self.data_type = None

    def add_version(self, name_version, num_version):
        self.version = name_version + "_" + str(num_version + 1)

    def make_prev(self):
        name_version = self.version[:self.version.find("_")]
        num_version = self.version[self.version.find("_") + 1:]
        self.prev_version = [name_version + "_" + str(int(num_version) - 1)]

    def add_prev(self, prev_version):
        self.prev_version.append(prev_version)
