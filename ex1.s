.data			# read-only section containing executable code
source:			# int source[7] = {3,1,4,1,5,9,0}; 
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:			# int dest[11] = {};
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
main:
    addi t0, x0, 0	# int k = 0
    addi s0, x0, 0	# int sum = 0
    la s1, source	# int* s1 = source
    la s2, dest		# int* s2 = dest
loop:
    slli s3, t0, 2	# int s3 = t0*2*2	(=4*k)
    add t1, s1, s3	# int* t1 = s1+s3	(=&source[k])
    lw t2, 0(t1)	# int t2 = t1[0]	(=source[k])
    beq t2, x0, exit	# if(t2 == 0) goto exit
    add a0, x0, t2	# a0 = t2;

    addi sp, sp, -8	# sp -= 8		//no idea
    sw t0, 0(sp)	# sp[0] = t0		// sp[0] = k
    sw t2, 4(sp)	# sp[1] = t2		// sp[1] = source[k]

    jal square		# goto sqaure		// t0, t1, t2 has been changed

    lw t0, 0(sp)	# t0 = sp[0]		// t0 = k
    lw t2, 4(sp)	# t1 = sp[1]		// t2 = source[k]

    addi sp, sp, 8	# sp += 8		//no idea
    add t2, x0, a0	# t2 = a0
    add t3, s2, s3	# int* t3 = s2 + s3	(=dest+k)
    sw t2, 0(t3)	# t3[0] = t2		(dest[k] = t2)
    add s0, s0, t2	# s0 += t2		(sum += dest[k])
    addi t0, t0, 1	# t0++			(=k++)
    jal x0, loop	# goto loop		(=j loop)
square:			# fun(int n)
    add t0, a0, x0	# t0 = a0		(t0 = a0 = t2 = source[k] = n)
    add t1, a0, x0	# t1 = a0;		(t1 = source[k] = n
    addi t0, t0, 1	# t0++			(t0 = n+1)
    addi t2, x0, -1	# t2 = -1		
    mul t1, t1, t2	# t1 = t1*t2		(t1 = -t1 = -n)
    mul a0, t0, t1	# a0 = t0 + t1		(a0 = -n*(n+1))
    jr ra		# goto ra
exit:			#
    add a0, x0, s0	# a0 = s0
    add a1, x0, x0	# a1 = 0		//don't know about functions
    ecall # Terminate ecall			//due to values of a0
