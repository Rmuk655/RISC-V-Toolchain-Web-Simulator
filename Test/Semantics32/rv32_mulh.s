# RV32 mulh/mulhsu/mulhu: the high 32 bits of the 64-bit product.
addi x1, x0, -1          # 0xffffffff: -1 signed, 4294967295 unsigned
lui x2, 0x80000          # 0x80000000: INT32_MIN signed, 2^31 unsigned
mulh x3, x1, x1          # (-1)*(-1) = 1, high word 0
mulhu x4, x1, x1         # 0xffffffff^2 = 0xfffffffe00000001, high word 0xfffffffe
mulhsu x5, x1, x1        # -1 * 4294967295 = -4294967295, high word -1
mulh x6, x2, x2          # 2^62, high word 0x40000000
mulhu x7, x2, x2         # 2^62, high word 0x40000000
mulhsu x8, x2, x2        # -2^31 * 2^31 = -2^62, high word 0xc0000000
