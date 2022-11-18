.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    # Prologue:
   addi t0 x0 0		# int t0 = k
loop_start:
   slli t1 t0 2		# t1= 4k
   add  t2 a0 t1 	# int* t2 = a0+k	
   lw   t3 0(t2)	# int t3 = a0[k]
   bltz t3 set_zero	# if (t3 < 0) goto set_zero

loop_continue:
   addi t0 t0 1		# k++
   beq  t0 a1 loop_end	# if (t0==a1) goto set_zero
   j    loop_start		# goto loop_start

loop_end:

   ret		#return from subroutine

set_zero:		
 sw   x0 0(t2)		# a[k] = 0
 j  loop_continue	# go back to loop
