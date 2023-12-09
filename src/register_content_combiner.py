from typing import Optional

from src.register_content import RegisterContent, EmptyRegisterContent


class RegisterContentCombiner:
    def __init__(self):
        self._content_list: list[RegisterContent] = []

        self._begin = 0
        self._end = -1

    def clear(self):
        self._content_list = []

        self._begin = 0
        self._end = -1

    def append_content(self, content: RegisterContent):
        self._content_list.append(content)
        self._end += content.size

    def inset_content(self, content: RegisterContent, begin: int, end: int) -> bool:
        if content.size != end - begin + 1:
            raise Exception("Content size must be equals to difference between begin and end")

        curr_pos = 0
        for idx, list_content in enumerate(self._content_list):
            if curr_pos == begin and curr_pos + list_content.size - 1 == end:
                self._content_list[idx] = content

                return True

        return False

    def delete_content(self, begin: int, end: int) -> bool:
        return self.inset_content(EmptyRegisterContent(end - begin + 1), begin, end)

    def maybe_acquire_content(self, begin: int, end: int) -> Optional[RegisterContent]:
        curr_pos = 0
        for content in self._content_list:
            if curr_pos == begin and curr_pos + content.size - 1 == end:
                return content

        return None

    def maybe_get_by_idx(self, idx: int) -> Optional[RegisterContent]:
        try:
            return self._content_list[idx]
        except Exception:
            return None

    def get_size(self) -> int:
        return self._end - self._begin + 1

    def get_count(self) -> int:
        return len(self._content_list)

    def __and__(self, other) -> Optional[RegisterContent]:
        if not isinstance(other, str):
            raise Exception(f"Unable to logical and with type {type(other)}")

        hex_str = other
        hex_int = int(hex_str, 16)
        bit_str = "{:b}".format(hex_int)

        if hex_int == 0:
            return None

        begin = None
        end = None

        for i in range(len(bit_str)):
            reversed_i = len(bit_str) - i - 1

            if begin is None:
                if bit_str[reversed_i] == '0':
                    continue
                if bit_str[reversed_i] == '1':
                    begin = i
                    end = begin

                continue

            if bit_str[reversed_i] == '1':
                end = i

                continue
            if bit_str[reversed_i] == '0':
                break

        for i in range(len(bit_str)):
            reversed_i = len(bit_str) - i - 1

            if i <= end:
                continue

            if bit_str[reversed_i] == '1':
                return None

        return self.maybe_acquire_content(begin, end)

    def __rshift__(self, other) -> Optional["RegisterContentCombiner"]:
        if not isinstance(other, int):
            raise Exception(f"Unable to logical shift right with type {type(other)}")

        bits = other

        cur_pos = -1
        for content in self._content_list:
            cur_pos += content.size

            if bits == cur_pos + 1:
                break

            if bits < cur_pos + 1:
                return None

        if bits != cur_pos + 1:
            return None

        new_register_content_combiner = RegisterContentCombiner()

        cur_pos = -1
        for content in self._content_list:
            cur_pos += content.size

            if bits >= cur_pos + 1:
                continue

            if bits < cur_pos + 1:
                new_register_content_combiner.append_content(content)

        return new_register_content_combiner
