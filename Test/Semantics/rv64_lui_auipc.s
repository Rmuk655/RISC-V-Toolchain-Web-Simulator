# RV64 lui/auipc: the 32-bit result is sign-extended into the 64-bit register.
# Expected registers are in rv64_lui_auipc.expect, derived by hand from the RV64I spec.

lui x1, 0x80000          # pc 0:  0xFFFFFFFF80000000
lui x2, 0x12345          # pc 4:  0x0000000012345000
lui x3, 0xFFFFF          # pc 8:  0xFFFFFFFFFFFFF000
auipc x4, 0              # pc 12: pc + 0 = 0xc
auipc x5, 0x80000        # pc 16: 0x10 + 0xFFFFFFFF80000000 = 0xFFFFFFFF80000010
addi x6, x1, -1          # pc 20: 0xFFFFFFFF7FFFFFFF
