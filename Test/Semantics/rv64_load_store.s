# RV64 loads and stores: 64-bit sd/ld, sign extension of lw/lh/lb, zero extension of lwu/lhu/lbu.
# Expected registers are in rv64_load_store.expect, derived by hand from the RV64I spec.

lui x2, 0x10000          # data address 0x10000000
addi x1, x0, 1
slli x1, x1, 40
addi x1, x1, 5           # 0x0000010000000005
sd x1, 0(x2)
ld x3, 0(x2)             # the full 64-bit value must round-trip
lw x4, 0(x2)             # low word = 5
lw x5, 4(x2)             # high word = 0x100
addi x6, x0, -1
sw x6, 16(x2)
lw x7, 16(x2)            # sign-extended: all ones
lwu x8, 16(x2)           # zero-extended: 0xFFFFFFFF
sd x6, 24(x2)
ld x9, 24(x2)            # all ones
lb x10, 24(x2)           # sign-extended byte: all ones
lbu x11, 24(x2)          # 0xFF
lh x12, 24(x2)           # sign-extended halfword: all ones
lhu x13, 24(x2)          # 0xFFFF
