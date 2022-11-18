.data					# read-write section containing global or static variables
.word 2, 4, 6, 8			# .word : 32-bits, comma seperated words
n: .word 9				# n[1] {9};

.text					# read only section containing executable variables
main:   add     t0, x0, x0		# t0 = 0
        addi    t1, x0, 1		# t1 = 1	// 1st Fibinacci number
        la      t3, n			# t3 = n 
        lw      t3, 0(t3)		# t3 = 9
fib:    beq     t3, x0, finish		# if(t3 == 0) break;
        add     t2, t1, t0		# t2 = t0 + t1	// Fibinacci number
        mv      t0, t1			# t0 = t1	// n-th Fibonacci number
        mv      t1, t2			# t1 = t2	
        addi    t3, t3, -1		# t3 = t3 -1
        j       fib			# itertate until t3 == 0
finish: addi    a0, x0, 1		# a0 == 1	// Don't know why a0 set to 1
        addi    a1, t0, 0		# a1 == t0	// (=34)
        ecall # print integer ecall	 
        addi    a0, x0, 10		# a0 = 10	// Don't know why a0 set to 10
        ecall # terminate ecall		 

// if (:n: .word 13) : final t0 will be 233
