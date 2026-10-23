# Misaligned accesses that cross a 16-byte cache block boundary (the semantics runner uses 16-byte blocks).
# Results must be identical with no cache, write-back and write-through. Expected values are derived by hand.

lui x2, 0x10000          # data address 0x10000000
lui x1, 0x1020
addi x1, x1, 0x304       # 0x01020304
slli x1, x1, 32
lui x3, 0x5060
addi x3, x3, 0x708       # 0x05060708
add x1, x1, x3           # 0x0102030405060708
sd x1, 12(x2)            # bytes 12..19: crosses the boundary at 16
ld x4, 12(x2)            # round-trips
lw x5, 14(x2)            # bytes 14..17 = 06 05 04 03
lbu x6, 15(x2)           # 05
lhu x7, 15(x2)           # bytes 15..16 = 05 04, crosses
addi x8, x0, -1
sw x8, 30(x2)            # bytes 30..33: crosses the boundary at 32
lwu x9, 30(x2)           # 0xFFFFFFFF
lb x10, 32(x2)           # 0xFF sign-extended
lbu x11, 29(x2)          # untouched byte = 0
