.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#       d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:i
#       a0 is the pointer to the start of m0
#       a1 is the # of rows (height) of m0
#       a2 is the # of columns (width) of m0
#       a3 is the pointer to the start of m1
#       a4 is the # of rows (height) of m1
#       a5 is the # of columns (width) of m1
#       a6 is the pointer to the the start of d
# Returns:
#       None, sets d = matmul(m0, m1)
# =======================================================
matmul:
    addi sp sp -28
    sw ra 0(sp)			# keep data of s-registers 
    sw s0 4(sp)			# to save arguments
    sw s1 8(sp)			# in s-registers
    sw s2 16(sp)
    sw s3 20(sp)
    sw s4 24(sp)

    # Error if mismatched dimensions
    bne  a2 a4 mismatched_dimensions
    # Prologue
    mv   s0 a0	         	# save a0 : pointer of m0
    mv   s1 a1			# save a1 : rows of m0
    mv   s2 a2			# save a2 : cols of m0
    mv   s3 a3  	        # save a3 : pointer of m1
    mv   s4 a4			# save a4 : rows of m1

    addi t6 x0 0       		#[!] i : (while i < rows of m0)

outer_loop_start:
    addi t5 x0 0		#[!] j : (while j < cols of m1)

inner_loop_start:
    
    # set arguments(a0~a4)
    slli t0 t6 2		# set 't0' to 'i' : Currnet row of m0 
    mul  t0 t0 s2		# t0 = i * cols_of_m0 (Stride)	
    add  a0 s0 t0		# a0 -> m0+(i*s2) : start point of row vector		
   
    slli t0 t5 2		# set 't0' to 'j' : Current col of m1
    add  a1 s3 t0		# s3 = m1 + j	  : start point of colum vector
   
    mv   a2 s2			# length = cols of m0 or row of m1
    li   a3 1			# stride1 = 1
    mv   a4 a5			# stride2 = cols of m1
    
    # DOT-PRODUCT
    jal ra dot			#[!] use t0~t3, change a0
    
    # put value in d		# index of matrix d : k
    mul  t0 t6 a5		# k = (i)*(a5)
    add  t0 t0 t5		# k = (i)*(a5)+(j)
    slli t0 t0 2		# k = (current_row_of_m0)*(#of_cols_of_m1)+(current_col_of_m1)
    add  t0 a6 t0		# set 't0' to &d[k]
    sw   a0 0(t0)		# 
    
    # turn the arguments back
    mv   a0 s0          	# load pointer of m0
    mv   a1 s1         		# load # of rows of m0
    mv   a2 s2			# load # of cols of m0
    mv   a3 s3			# load pointer of m1
    mv   a4 s4			# load # of rows of m1
    
    addi t5 t5 1     		# j++
    beq  t5 a5 inner_loop_end	# until j==cols of m1
    jal  x0 inner_loop_start	#

inner_loop_end:
    addi t6 t6 1		# i++
    beq  t6 s1 outer_loop_end	# until i==rows of m0
    jal  x0 outer_loop_start	#

outer_loop_end:
    lw ra 0(sp)			# load ra and data of s-register
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 16(sp)
    lw s3 20(sp)
    lw s4 24(sp)
    addi sp sp 28
    ret
mismatched_dimensions:
    li a1 2
    jal exit2
