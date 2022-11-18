.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:
    # Prologue
    addi t0 x0 0		# int i = 0
    addi t1 x0 1		# int j = 1
loop_start:
    slli t2 t0 2
    slli t3 t1 2
    add  t2 a0 t2 		# t2 = v0+i
    add  t3 a0 t3		# t3 = v0+j
    lw   t2 0(t2)		# t2 = v0[i]
    lw   t3 0(t3)		# t3 = v0[j]
    ble  t3 t2 loop_continue	# if  (v0[i] >= v0[j]) goto loop_countinue(do nothing)
    mv   t0 t1			# else(v0[i] <  v0[j]) i = j    
loop_continue:
    addi t1 t1 1		# j++
    beq t1 a1 loop_end
    j loop_start
loop_end:
    # Epilogue
   
    # return index : a single integer
     mv a0 t0
   
    # return adress
    # slli t0 t0 2
    # add  a0 a0 t0
    ret
