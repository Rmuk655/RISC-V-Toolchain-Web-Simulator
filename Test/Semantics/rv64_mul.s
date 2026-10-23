# RV64 mul: low 64 bits of the product. Expected registers are in rv64_mul.expect and were
# derived by hand (arithmetic modulo 2^64), not recorded from simulator output.

addi x1, x0, 1
slli x1, x1, 32
addi x1, x1, 3           # 0x0000000100000003
addi x2, x0, 2
mul x3, x1, x2           # 0x0000000200000006
slli x4, x1, 31          # 0x8000000180000000
mul x5, x4, x2           # 2 * 0x8000000180000000 mod 2^64 = 0x0000000300000000
addi x6, x0, -3
mul x7, x1, x6           # -3 * 0x100000003 = 0xFFFFFFFCFFFFFFF7
mul x8, x6, x6           # 9
