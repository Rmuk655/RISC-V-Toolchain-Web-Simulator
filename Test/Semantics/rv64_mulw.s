# mulw: low 32 bits of the product, sign-extended. Operands whose 64-bit product overflows must still work.
addi x1, x0, 1
slli x1, x1, 31
addi x1, x1, -1          # 0x7fffffff
mulw x2, x1, x1          # (2^31-1)^2 low word = 1
addi x3, x0, 1
slli x3, x3, 62          # 0x4000000000000000
mulw x4, x3, x3          # product overflows 64 bits; low word = 0
slli x5, x3, 1
addi x5, x5, 1           # 0x8000000000000001
mulw x6, x5, x5          # signed 64-bit overflow; low word = 1
lui x7, 0x40             # 0x40000
addi x8, x0, 1
slli x8, x8, 13          # 0x2000
mulw x9, x7, x8          # 2^31: sign-extends to 0xffffffff80000000
