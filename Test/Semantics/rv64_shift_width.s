# RV64 register width and shift semantics. Expected final registers are in rv64_shift_width.expect
# and were derived by hand from the RV64I spec, not recorded from simulator output.
# Avoids lui so the test only depends on the register file and the shifts.

addi x1, x0, 1
slli x2, x1, 32          # 0x0000000100000000: bit 32 must survive (register is 64-bit)
slli x3, x1, 31          # 0x0000000080000000: not sign-extended for a 64-bit shift
slli x4, x1, 63          # 0x8000000000000000
addi x5, x0, -1          # 0xFFFFFFFFFFFFFFFF
srli x6, x5, 32          # 0x00000000FFFFFFFF
srli x7, x5, 63          # 1
srai x8, x4, 63          # all ones (arithmetic)
srai x9, x4, 32          # 0xFFFFFFFF80000000

# register shifts use the low 6 bits of rs2
addi x10, x0, 33
sll x11, x1, x10         # 1 << 33
srl x12, x4, x10         # 0x8000000000000000 >> 33 (logical)
sra x13, x4, x10         # arithmetic
addi x14, x0, 63
srl x15, x5, x14         # 1
addi x16, x0, 64         # 64 & 63 == 0
sll x17, x1, x16         # 1 << 0
addi x18, x0, 65         # 65 & 63 == 1
sll x19, x1, x18         # 1 << 1

# word operations use 32-bit semantics and sign-extend the result
add x20, x2, x1          # 0x0000000100000001
sllw x21, x20, x1        # low word 1 << 1 = 2
slliw x22, x1, 31        # 0x80000000 sign-extended
srliw x23, x22, 1        # low word 0x80000000 >> 1 logical
sraiw x24, x22, 1        # low word arithmetic, sign-extended
srlw x25, x22, x1        # same as srliw via register
sraw x26, x22, x1        # same as sraiw via register
addi x27, x0, 31
slli x28, x20, 0         # unchanged by a zero shift
