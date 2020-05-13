class Node:
    def __init__(self, instruction):
        self.instruction = instruction
        self.children = []
        self.state = None

    def add_child(self, child):
        self.children.append(child)


class Decompiler:
    def __init__(self):
        self.cfg = None
        # self.last_node = None
        self.number_of_temp = 0
        self.number_of_shift = 0
        self.number_of_length = 0
        self.number_of_mask = 0
        self.number_of_cc = 0
        self.number_of_sf0 = 0
        self.number_of_sf1 = 0
        self.number_of_sf2 = 0
        self.number_of_tmp = 0
        self.number_of_v0 = 0
        self.number_of_v1 = 0
        self.number_of_v = 0
        self.number_of_vm = 0
        self.number_of_p = 0

    def process_src(self, f):
        with open('program.txt', 'r') as file:
            set_of_instructions = file.read().splitlines()
        last_node = Node("")  # root
        self.cfg = last_node
        for row in set_of_instructions:
            # instruction = row.strip().replace(',', ' ').split()
            curr_node = self.make_cfg_node(row)
            last_node.add_child(curr_node)
            last_node = curr_node
        curr_node = self.cfg
        while curr_node.children:
            self.to_openCL(curr_node.children[0], f)
            curr_node = curr_node.children[0]

    def make_cfg_node(self, instruction):
        return Node(instruction)

    def to_openCL(self, node, f):
        tab = "    "
        instruction = node.instruction.strip().replace(',', ' ').split()
        operation = instruction[0]
        parts_of_operation = operation.split('_')
        prefix = parts_of_operation[0]
        suffix = parts_of_operation[-1]
        root = parts_of_operation[1]
        if prefix == "ds":
            if root == "bpermute":
                if suffix == "b32":
                    tmp = "tmp" + str(self.number_of_tmp)
                    dst = instruction[1]
                    addr = instruction[2]
                    src = instruction[3]
                    offset = instruction[4][7:]
                    f.write("uint64 " + tmp + "\n")  # именно массив
                    f.write("for (short i = 0; i < 64; i++)\n")
                    f.write("{\n")
                    f.write(tab + "uint lane_id = " + addr + "[(i + (" + offset + " >> 2)) & 63]\n")
                    f.write(tab + tmp + "[i] = exec & (1ULL << lane_id) != 0) ? " + src + "[lane_id] : 0\n")
                    f.write("}\n")
                    f.write("for (short i = 0; i < 64; i++)\n")
                    f.write(tab + "if (exec & (1ULL << i) != 0)\n")
                    f.write(tab + tab + dst + "[i] = " + tmp + "[i]\n")
                    self.number_of_tmp += 1

            elif root == "read":
                if suffix == "b32":
                    vdst = instruction[1]
                    addr = instruction[2]
                    offset = instruction[3][7:]
                    f.write(vdst + " = *(uint)(ds + ((" + addr + " + " + offset + ") & ~3)\n")

                elif suffix == "b64":
                    vdst = instruction[1]
                    addr = instruction[2]
                    offset = instruction[3][7:]
                    f.write(vdst + " = *(ulong)(ds + ((" + addr + " + " + offset + ") & ~7)\n")

            elif root == "read2":
                if suffix == "b64":
                    v0 = "v0" + str(self.number_of_v0)
                    v1 = "v1" + str(self.number_of_v1)
                    vdst = instruction[1]
                    addr = instruction[2]
                    offset0 = instruction[3][8:]
                    offset1 = instruction[4][8:]
                    f.write("ulong* " + v0 + " = (ulong*)(ds + (" + addr + " + " + offset0 + " * 8) & ~7)\n")
                    f.write("ulong* " + v1 + " = (ulong*)(ds + (" + addr + " + " + offset1 + " * 8) & ~7)\n")
                    f.write(vdst + " = *" + v0 + " | (ulonglong(*" + v1 + ") << 64)\n")  # uint128????
                    self.number_of_v0 += 1
                    self.number_of_v1 += 1

            elif root == "write":
                if suffix == "b32":
                    v = "v" + str(self.number_of_v)
                    addr = instruction[1]
                    vdata0 = instruction[2]
                    offset = instruction[3][7:]
                    f.write("uint* " + v + "\n")
                    f.write(v + " = (uint*)(ds + ((" + addr + " + " + offset + ") & ~3))\n")
                    f.write("*" + v + " = " + vdata0 + "\n")
                    self.number_of_v += 1

                elif suffix == "b64":
                    v = "v" + str(self.number_of_v)
                    addr = instruction[1]
                    vdata0 = instruction[2]
                    offset = instruction[3][7:]
                    f.write("ulong* " + v + "\n")
                    f.write(v + " = (ulong*)(ds + ((" + addr + " + " + offset + ") & ~3))\n")
                    f.write("*" + v + " = " + vdata0 + "\n")
                    self.number_of_v += 1

            elif root == "write2":
                if suffix == "b64":
                    v0 = "v0" + str(self.number_of_v0)
                    v1 = "v1" + str(self.number_of_v1)
                    addr = instruction[1]
                    vdata0 = instruction[2]
                    vdata1 = instruction[3]
                    offset0 = instruction[4][8:]
                    offset1 = instruction[5][8:]
                    f.write("ulong* " + v0 + " = (ulong*)(ds + (" + addr + " + " + offset0 + " * 8) & ~7)\n")
                    f.write("ulong* " + v1 + " = (ulong*)(ds + (" + addr + " + " + offset1 + " * 8) & ~7)\n")
                    f.write("*" + v0 + " = " + vdata0 + "\n")
                    f.write("*" + v1 + " = " + vdata1 + "\n")
                    self.number_of_v0 += 1
                    self.number_of_v1 += 1


        elif prefix == "flat":  # не очень понятное описание, особенно про inst_offset
            if root == "atomic_add":
                vdst = instruction[1]
                vaddr = instruction[2]
                vdata = instruction[3]
                vm = "vm" + str(self.number_of_vm)
                p = "p" + str(self.number_of_p)
                inst_offset = instruction[4]  # не очень понятно, должно ли это быть в виде INST_OFFSET:OFFSET
                f.write("uint* " + vm + " = (uint*)(" + vaddr + " + " + inst_offset + ")\n")
                f.write("uint " + p + " = *" + vm + "; *" + vm + " = *" + vm + " + " + vdata + "; "
                        + vdst + " = (glc) ? " + p + " : " + vdst + '\n')
                self.number_of_vm += 1
                self.number_of_p += 1

            elif root == "load":
                if suffix == "dword":
                    vdst = instruction[1]
                    vaddr = instruction[2]
                    inst_offset = instruction[3]
                    f.write(vdst + " = *(uint)(" + vaddr + " + " + inst_offset + "\n")

                elif suffix == "dwordx4":
                    vdst = instruction[1]
                    vaddr = instruction[2]
                    inst_offset = instruction[3]
                    vm = "vm" + str(self.number_of_vm)
                    f.write("short* " + vm + " = (" + vaddr + " + " + inst_offset + ")\n")
                    f.write(vdst + "[0] = *(uint*)" + vm + "\n")
                    f.write(vdst + "[1] = *(uint*)(" + vm + " + 4)\n")
                    f.write(vdst + "[2] = *(uint*)(" + vm + " + 8)\n")
                    f.write(vdst + "[3] = *(uint*)(" + vm + " + 12)\n")
                    self.number_of_vm += 1

            elif root == "store":
                if suffix == "dword":
                    vaddr = instruction[1]
                    vdata = instruction[2]
                    inst_offset = "0" if len(instruction) < 4 else instruction[3]
                    f.write("*(uint*)(" + vaddr + " + " + inst_offset + ") = " + vdata + "\n")  # нужен ли номер...

                elif suffix == "dwordx4":
                    vaddr = instruction[1]
                    vdata = instruction[2]
                    inst_offset = instruction[3]
                    vm = "vm" + str(self.number_of_vm)
                    f.write("short* " + vm + " = (" + vaddr + " + " + inst_offset + ")\n")
                    f.write("*(uint*)(" + vm + ") = " + vdata + "[0]\n")
                    f.write("*(uint*)(" + vm + " + 4) = " + vdata + "[1]\n")
                    f.write("*(uint*)(" + vm + " + 8) = " + vdata + "[2]\n")
                    f.write("*(uint*)(" + vm + " + 12) = " + vdata + "[3]\n")
                    self.number_of_vm += 1

        elif prefix == 'global':  # offset - опциональная часть?
            if root == "load":
                if suffix == "dword":
                    vdst = instruction[1]
                    vaddr = instruction[2]
                    saddr = "0" if instruction[3] == "off" else instruction[3]
                    inst_offset = "0" if len(instruction) == 4 else instruction[4]
                    f.write(vdst + " = *(uint*)(" + vaddr + " + " + saddr + " + " + inst_offset + ")\n")

                elif suffix == "dwordx2":
                    vdst = instruction[1]
                    vaddr = instruction[2]
                    saddr = "0" if instruction[3] == "off" else instruction[3]
                    inst_offset = "0" if len(instruction) == 4 else instruction[4]
                    f.write(vdst + " = *(ulong*)(" + vaddr + " + " + saddr + " + " + inst_offset + ")\n")

            elif root == "store":
                if suffix == "dword":
                    vaddr = instruction[1]
                    vdata = instruction[2]
                    saddr = 0 if instruction[3] == "off" else instruction[3]
                    inst_offset = 0 if len(instruction) == 4 else instruction[4]
                    f.write("*(uint*)(" + vaddr + " + " + saddr + " + " + inst_offset + ") = " + vdata + "\n")

                elif suffix == "dwordx2":
                    vaddr = instruction[1]
                    vdata = instruction[2]
                    saddr = 0 if instruction[3] == "off" else instruction[3]
                    inst_offset = 0 if len(instruction) == 4 else instruction[4]
                    f.write("*(ulong*)(" + vaddr + " + " + saddr + " + " + inst_offset + ") = " + vdata + "\n")

        elif prefix == 's':
            if root == 'add':
                if suffix == 'u32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    temp = "temp" + str(self.number_of_temp)
                    f.write("ulong " + temp + " = (ulong)" + ssrc0 + " + (ulong)" + ssrc1 + "\n")
                    f.write(sdst + " = " + temp + "\n")
                    f.write("scc = " + temp + " >> 32\n")
                    self.number_of_temp += 1

            elif root == 'addc':
                if suffix == 'u32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    temp = " temp" + str(self.number_of_temp)
                    f.write("ulong " + temp + " = (ulong)" + ssrc0 + " + (ulong)" + ssrc1 + " scc\n")
                    f.write(sdst + " = " + temp + "\n")
                    f.write("scc = " + temp + " >> 32\n")
                    self.number_of_temp += 1

            elif root == 'and':
                if suffix == 'b32' or suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = " + ssrc0 + " & " + ssrc1 + "\n")
                    f.write("scc = " + sdst + " != 0\n")

            elif root == 'and_saveexec':
                if suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    f.write(sdst + " = " + "exec\n")
                    f.write("exec = ~" + ssrc0 + " & exec\n")
                    f.write("scc = exec != 0\n")

            elif root == 'andn2':
                if suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = " + ssrc0 + " & ~" + ssrc1 + "\n")
                    f.write("scc = " + sdst + " != 0\n")

            elif root == 'ashr':
                if suffix == 'i32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = (int)" + ssrc0 + " >> (" + ssrc1 + " & 31)\n")
                    f.write("scc = " + sdst + " != 0\n")

            elif root == 'barrier':
                f.write("barrier(CLK_LOCAL_MEM_FENCE);\n")

            elif root == 'bfe':
                if suffix == 'u32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    shift = "shift" + str(self.number_of_shift)
                    length = "length" + str(self.number_of_length)
                    f.write("uchar " + shift + " = " + ssrc1 + " & 31\n")
                    f.write("uchar " + length + " = (" + ssrc0 + " >> 16) & 0x7f\n")
                    f.write("if (" + length + " == 0)\n")
                    f.write(tab + sdst + " = 0\n")
                    f.write("if (" + shift + " + " + length + " < 32)\n")
                    f.write(tab + sdst + " = " + ssrc0 + " << (32 - " + shift + " - " + length + ") >> (32 - "
                            + length + "\n")
                    f.write("else\n")
                    f.write(tab + sdst + " = " + instruction[2] + " >> " + shift + "\n")
                    f.write("scc = " + ssrc0 + " != 0\n")
                    self.number_of_length += 1
                    self.number_of_shift += 1

            elif root == 'branch':
                reladdr = instruction[1]
                f.write("pc = " + reladdr + "\n")

            elif root == 'cbranch_execz':
                reladdr = instruction[1]
                f.write("pc = exec == 0 ? " + reladdr + " : pc + 4\n")

            elif root == 'cbranch_scc0':
                reladdr = instruction[1]
                f.write("pc = scc0 == 0 ? " + reladdr + " : pc + 4\n")

            elif root == 'cbranch_scc1':
                reladdr = instruction[1]
                f.write("pc = scc1 == 0 ? " + reladdr + " : pc + 4\n")

            elif root == 'cbranch_vccnz':
                reladdr = instruction[1]
                f.write("pc = vcc != 0 ? " + reladdr + " : pc + 4")

            elif root == 'cmp_eq':
                if suffix == 'i32' or suffix == 'u32':
                    ssrc0 = instruction[1]
                    ssrc1 = instruction[2]
                    f.write("scc = " + ssrc0 + " == " + ssrc1 + "\n")

            elif root == 'cmp_ge':
                if suffix == 'i32':
                    ssrc0 = instruction[1]
                    ssrc1 = instruction[2]
                    f.write("scc = (int)" + ssrc0 + " >= (int)" + ssrc1 + "\n")

                elif suffix == 'u32':
                    ssrc0 = instruction[1]
                    ssrc1 = instruction[2]
                    f.write("scc = " + ssrc0 + " >= " + ssrc1 + "\n")

            elif root == 'cmp_lt':
                if suffix == 'i32':
                    ssrc0 = instruction[1]
                    ssrc1 = instruction[2]
                    f.write("scc = (int)" + ssrc0 + " < (int)" + ssrc1 + "\n")

            elif root == 'cselect':
                if suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = scc ? " + ssrc0 + " : " + ssrc1 + "\n")

            elif root == 'endpgm':
                f.write("END Programm\n")
            # здесь должна будет быть закрывающаяся скобка
            elif root == 'getpc':
                if suffix == 'b64':
                    sdst = instruction[1]
                    f.write(sdst + " = pc + 4\n")

            elif root == 'load':
                if suffix == 'dword':
                    sdata = instruction[1]
                    sbase = instruction[2]
                    offset = instruction[3]
                    f.write(sdata + " = *(uint*)(smem + (" + offset + " & ~3))\n")

                elif suffix == 'dwordx2':
                    sdata = instruction[1]
                    sbase = instruction[2]
                    offset = instruction[3]
                    f.write(sdata + " = *(ulong*)(smem + (" + offset + " & ~3))\n")  # smem??? как и dc..

                elif suffix == 'dwordx4' or suffix == 'dwordx8':
                    sdata = instruction[1]
                    sbase = instruction[2]
                    offset = instruction[3]
                    f.write("for (short i = 0; i < " + suffix[-1] + "; i++)\n")
                    f.write(tab + sdata + " = *(uint*)(smem + i * 4 + (" + offset + " & ~3))\n")

            elif root == 'lshl':
                if suffix == 'b32' or suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = " + ssrc0 + " << (" + ssrc1 + " & " + str(int(suffix[1:]) - 1) + ")\n")
                    f.write("scc = " + sdst + " != 0\n")

            elif root == 'mov':
                if suffix == 'b32' or suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    f.write(sdst + " = " + ssrc0 + "\n")

            elif root == 'movk':
                if suffix == 'i32':
                    sdst = instruction[1]
                    simm16 = instruction[2]
                    f.write(sdst + " = " + simm16 + "\n")

            elif root == 'mul':
                if suffix == 'i32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    f.write(sdst + " = " + ssrc0 + " * " + ssrc1 + "\n")

            elif root == 'mulk':
                if suffix == 'i32':
                    sdst = instruction[1]
                    simm16 = instruction[2]
                    f.write(sdst + " = " + sdst + " * " + simm16 + "\n")

            elif root == 'not':
                if suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    f.write(sdst + " = ~" + ssrc0 + "\n")
                    f.write("scc = " + sdst + " != 0\n")

            elif root == 'set_gpr_idx_on':
                ssrc0 = instruction[1]
                imm8 = instruction[2]
                f.write("mode = (mode & ~(1U << 27)) | (1U << 27)\n")
                f.write("m0 = (m0 & 0xffff0f00) | ((" + imm8 + " & 15) << 12) | (" + ssrc0 + " & 0xff)\n")

            elif root == 'set_gpr_idx_off':
                f.write("mode = (mode & ~(1U << 27))\n")

            elif root == 'setpc':
                if suffix == 'b64':
                    ssrc0 = instruction[1]
                    f.write("pc = " + ssrc0 + "\n")

            elif root == 'setreg':  # возможно это неправда
                if suffix == 'b32':
                    hwreg = instruction[1]
                    hwregname = instruction[2]
                    bitoffset = instruction[3]
                    bitsize = instruction[4]
                    sdst = instruction[5]
                    mask = "mask" + str(self.number_of_mask)
                    f.write("uint " + mask + " = (1U << " + bitsize + ") - 1U) << " + bitoffset + "\n")
                    f.write(hwreg + " = (" + hwreg + "& ~" + mask + ") | ((" + sdst + " << " + bitoffset + ") & " + mask
                            + ")\n")
                    self.number_of_mask += 1

            elif root == 'sub':
                if suffix == 'i32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    temp = "temp" + str(self.number_of_temp)
                    f.write(sdst + " = " + ssrc0 + " - " + ssrc1 + "\n")
                    f.write("long " + temp + " = (long)" + ssrc0 + " - (long)" + ssrc1 + "\n")  # SEXT64 - long?
                    f.write("scc = " + temp + " > ((1LL << 31) - 1) || " + temp + " < (-1LL << 31)\n")
                    self.number_of_temp += 1

                elif suffix == 'u32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    temp = "temp" + str(self.number_of_temp)
                    f.write("ulong " + temp + " = (ulong)" + ssrc0 + " - (ulong)" + ssrc1 + "\n")
                    f.write(sdst + " = " + temp + "\n")
                    f.write("scc = (" + temp + " >> 32) != 0\n")
                    self.number_of_temp += 1

            elif root == 'subb':
                if suffix == 'u32':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    ssrc1 = instruction[3]
                    temp = "temp" + str(self.number_of_temp)
                    f.write("ulong " + temp + " = (ulong)" + ssrc0 + " - (ulong)" + ssrc1 + " - scc\n")
                    f.write(sdst + " = " + temp + "\n")
                    f.write("scc = (" + temp + " >> 32) & 1\n")
                    self.number_of_temp += 1

            elif root == 'swappc':
                if suffix == 'b64':
                    sdst = instruction[1]
                    ssrc0 = instruction[2]
                    f.write(sdst + " = pc + 4\n")
                    f.write("pc = " + ssrc0 + "\n")

            elif root == 'waitcnt':
                f.write("Not resolve yet. Maybe you lose.\n")

        elif prefix == 'v':
            # if root == "add_co":
            #     if suffix == "u32":
            # не 1.2
            if root == "add":
                if suffix == "u32":
                    vdst = instruction[1]
                    sdst = instruction[2]
                    src0 = instruction[3]
                    src1 = instruction[4]
                    temp = "temp" + str(self.number_of_temp)
                    mask = "mask" + str(self.number_of_mask)
                    f.write("ulong " + temp + " = (ulong)" + src0 + " + (ulong)" + src1 + "\n")
                    f.write(vdst + " = clamp ? min(" + temp + ", 0xffffffff) : " + temp + "\n")
                    f.write(sdst + " = 0\n")
                    f.write("ulong " + mask + " = (1ULL << laneid)\n")
                    f.write(sdst + " = (" + sdst + " & ~" + mask + ") | ((" + temp + " >> 32) ? " + mask + " : 0\n")
                    self.number_of_temp += 1
                    self.number_of_mask += 1

            # elif root == "add3":
            #     if suffix == "u32":
            #
            # elif root == "addc_co":
            #     if suffix == "u32":
            # не 1.2

            elif root == "addc":
                if suffix == "u32":
                    vdst = instruction[1]
                    sdst = instruction[2]
                    src0 = instruction[3]
                    src1 = instruction[4]
                    ssrc2 = instruction[5]
                    temp = "temp" + str(self.number_of_temp)
                    mask = "mask" + str(self.number_of_mask)
                    cc = "cc" + str(self.number_of_cc)
                    f.write("ulong " + mask + " = (1ULL << laneid)\n")
                    f.write("uchar " + cc + "((" + ssrc2 + " & " + mask + ") ? 1 : 0)\n")
                    f.write("ulong " + temp + " = (ulong)" + src0 + " + (ulong)" + src1 + " + " + cc + "\n")
                    f.write(sdst + " = 0\n")
                    f.write(vdst + " = clamp ? min(" + temp + ", 0xffffffff) : " + temp + "\n")
                    f.write(sdst + " = (" + sdst + " & ~" + mask + ") | ((" + temp + " >> 32) ? " + mask + " : 0)\n")
                    self.number_of_temp += 1
                    self.number_of_mask += 1
                    self.number_of_mask += 1

            elif root == "alignbit":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    f.write(vdst + " = (((ulong)" + src0 + ") << 32) | " + src1 + ") >> (" + src2 + " & 31)\n")

            elif root == "alignbyte":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    f.write(vdst + " = (((ulong)" + src0 + ") << 32) | " + src1 + ") >> ((" + src2 + " & 3) * 8)\n")

            elif root == "and":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = " + src0 + " & " + src1 + "\n")

            elif root == "and_or":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    f.write(vdst + " = (" + src0 + " & " + src1 + ") | " + src2 + "\n")

            elif root == "bfi":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    f.write(vdst + " = (" + src0 + " & " + src1 + ") | (~" + src0 + " & " + src2 + ")\n")

            elif root == "cmp_eq":
                if suffix == "u32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (uint)" + src0 + " == (uint)" + src1 + "\n")

            elif root == "cmp_ge":
                if suffix == "u32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (uint)" + src0 + " >= (uint)" + src1 + "\n")

            elif root == "cmp_gt":
                if suffix == "u64":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (ulong)" + src0 + " > (uint)" + src1 + "\n")

            elif root == "cmp_lg":
                if suffix == "i32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (int)" + src0 + " != (int)" + src1 + "\n")

                elif suffix == "u32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (uint)" + src0 + " != (uint)" + src1 + "\n")

            elif root == "cmp_lt":
                if suffix == "u32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (uint)" + src0 + " < (uint)" + src1 + "\n")

            elif root == "cmpx_class":  # постоянно пишут про sdst(lane) зачем...
                if suffix == "f64":
                    f.write("Not resolve yet. Maybe you lose.\n")

            elif root == "cmpx_eq":
                if suffix == "f64":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = as_double(" + src0 + ") == as_double(" + src1 + ")\n")
                    f.write("exec = " + sdst + "\n")

            elif root == "cmpx_le":
                if suffix == "u32":
                    sdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(sdst + " = (uint)" + src0 + " <= (uint)" + src1 + "\n")
                    f.write("exec = " + " = " + sdst + "\n")

            elif root == "cndmask":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    ssrc2 = instruction[4]
                    f.write(vdst + " = " + ssrc2 + " & (1ULL << laneid) ? " + src1 + " : " + src0 + "\n")

            elif root == "cvt":
                if suffix == "f32_u32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    f.write(vdst + " = (float)" + src0 + "\n")

                elif suffix == "f64_i32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    f.write(vdst + " = (double)(int)" + src0 + "\n")

                elif suffix == "u32_f32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    f.write(instruction[1] + " = 0\n")
                    f.write("if (!isnan(as_float(" + src0 + ")))\n")
                    f.write(tab + vdst + " = (int)min(convert_int_rtz(as_float(" + src0 + ")), 4294967295.0)\n")

            elif root == "div_fixup":
                if suffix == "f64":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    sf0 = "sf0" + str(self.number_of_sf0)
                    sf1 = "sf1" + str(self.number_of_sf1)
                    sf2 = "sf2" + str(self.number_of_sf2)
                    f.write("double " + sf0 + " = as_double(" + src0 + ")\n")
                    f.write("double " + sf1 + " = as_double(" + src1 + ")\n")
                    f.write("double " + sf2 + " = as_double(" + src2 + ")\n")
                    f.write("if (isnan(" + sf1 + ") && !isnan(" + sf2 + "))\n")
                    f.write(tab + vdst + " = nan(" + sf1 + ")\n")
                    f.write("else if (abs(" + sf2 + "))\n")
                    f.write(tab + vdst + " = nan(" + sf2 + ")\n")  # nan не может принимать что-то нецелое
                    f.write("else if (" + sf1 + " == 0.0 && " + sf2 + " == 0.0)\n")
                    f.write(tab + vdst + " = NAN\n")
                    f.write("else if (abs(" + sf1 + ") == INFINITY)\n")
                    f.write(tab + vdst + " = -NAN\n")
                    f.write("else if (" + sf1 + " == 0.0)\n")
                    f.write(tab + vdst + " = INFINITY * sign(" + sf1 + ") * sign(" + sf2 + ")\n")
                    f.write("else if (abs(" + sf1 + ") == INFINITY)\n")
                    f.write(tab + vdst + " = sign(" + sf1 + ") * sign(" + sf2 + ") >= 0 ? 0.0 : -0.0\n")
                    f.write("else if (isnan(" + sf0 + "))\n")
                    f.write(tab + vdst + " = sign(" + sf1 + ") * sign(" + sf2 + ") * INFINITY\n")
                    f.write("else\n")
                    f.write(tab + vdst + " = " + sf0 + "\n")

            elif root == "fma":
                if suffix == "f64":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    src2 = instruction[4]
                    f.write(
                        vdst + " = " + "as_double(" + src0 + ") * as_double(" + src1 + ") + as_double(" + src2 + ")\n")

            elif root == "lshlrev":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = " + src1 + " << (" + src0 + " & 31)\n")

                elif suffix == "b64":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = " + src1 + " << (" + src0 + " & 63)\n")

            elif root == "lshrrev":
                if suffix == "b64":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = " + src1 + " >> (" + src0 + " & 63)\n")

            elif root == "min":
                if suffix == "u32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = min(" + src0 + ", " + src1 + ")\n")

            elif root == "mul":
                if suffix == "f64":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    src1 = instruction[3]
                    f.write(vdst + " = as_double(" + src0 + ") * as_double(" + src1 + ")\n")

            elif root == "mov":
                if suffix == "b32":
                    vdst = instruction[1]
                    src0 = instruction[2]
                    f.write(vdst + " = " + src0 + "\n")
        else:
            f.write("Not resolve yet. Maybe you lose.\n")
    # нет таких инструкций


def main():
    f = open('OpenCL.txt', 'w')
    decompiler = Decompiler()
    decompiler.process_src(f)
    f.close()

if __name__ == "__main__":
    main()
