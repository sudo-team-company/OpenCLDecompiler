import struct

class gfx10_ROData:
    type_to_fmt = {'.long': 'i', '.short': 'h', '.byte': 'b'}
    
    def __init__(self):
        self.text: list[str] = []
    
    @classmethod
    def parse_lines(cls, text: list[str]) -> tuple[bytearray, int]:
        buffer = bytearray()


        first_line = text[0]
        start_addr: int
        if '//' in first_line:
            comment_part = first_line.split('//', 1)[1].strip()
            if ':' in comment_part:
                addr_str = comment_part.split(':', 1)[0].strip()
                start_addr = int(addr_str, 16)


        for line in text:
            clean_line = line.split('//')[0].strip()
            if not clean_line:
                continue
            
            parts = clean_line.split(maxsplit=1)
            directive = parts[0]

            if directive == '.ascii':
                directive = '.byte'

            value_str = parts[1]
            if value_str.startswith('0'):
                value = int(value_str, 16)
            else:
                value = ord(value_str.strip('"')[0])

            buffer.extend(struct.pack(cls.type_to_fmt[directive], value))
                    
        return buffer, start_addr