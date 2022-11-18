.globl factorial

.data
n: .word 8

.text
main:
    la   t0, n
    lw   a0, 0(t0)
    mv   t1, a0
    jal  ra, factorial
exit:
    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    mv   t0, t1
    addi t0, t0, -1
    mv   t1, t0
    beq  to, xo, exit
    mul a0, a0, t0
    jal factorial
