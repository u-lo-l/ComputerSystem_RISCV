.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0 -> (St0)###
#   a4 is the stride of v1 -> (St1)###
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:
    # Prologue
   addi t0 x0 0		# index
   addi t3 x0 0		# sum
loop_start:
   slli t1 t0 2		
   slli t2 t0 2
   mul  t1 t1 a3	# (index of v0) * stride
   mul  t2 t2 a4	# (index of v1) * stride

   add  t1 a0 t1	# int* t1 = v0+i
   add  t2 a1 t2	# int* t2 = v1+j

   lw   t1 0(t1)	# t1 = v0[St0*i]
   lw   t2 0(t2)	# t2 = v1[St1*i]
   mul  t1 t1 t2	# t1 = v0[St0*i]*v1[St1*i]
   add  t3 t3 t1  	# sum += v0[St0*i]*v1[St1*i] 
 
   addi t0 t0 1		# int i++ (0,4,8..)
   beq  t0 a2 loop_end	# if(i == length) break;
   j    loop_start	# loop
loop_end:
   #Epliogue
   mv   a0 t3		#return sum
   ret
