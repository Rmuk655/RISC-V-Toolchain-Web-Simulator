# Doubles x6 five times (x6 = 1 * 2^5 = 32) and copies the result to x10.
addi x5, x0, 5
addi x6, x0, 1
loop:
beq x5, x0, done
add x6, x6, x6
addi x5, x5, -1
jal x0, loop
done:
addi x10, x6, 0
