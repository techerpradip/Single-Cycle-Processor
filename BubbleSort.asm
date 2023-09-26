.data
smallTable: .word 7,8,1,9,2,6,3,10,4,5
.text
	 la $a0, smallTable
	 addi $a1, $a1, 10 
	 jal sort
	 j finalexit
sort:
	addi $t0, $t0, 0 # i
outerloop:
	slt $t3, $t0, $a1 # i < size
	beq $t3, $zero, exit # false exit
	sll $t4, $t0, 2 # t4 = i * 4
	addi $t1, $t0, 1 # j = i + 1
innerloop:
	slt $t3, $t1, $a1 # j < size
	beq $t3, $zero, exit1 # false exit1
	sll $t5, $t1, 2 # t5 = j * 4
	lw $s1, ($t4) # s1 = array[i]
	lw $s2, ($t5) # s2 = array [j]
	slt $t6, $s2, $s1 # array[j] < array[i]
	beq $t6, $zero, exit2 # false exit2
	swap $s1, $s2 # swap registers s1 and s2
	sw $s1, ($t4) # array[i] = s1
	sw $s2, ($t5) # array [j] = s2
exit2:
	addi $t1, $t1, 1 # j = j + 1
	j innerloop
exit1:
	addi $t0, $t0, 1 # i = i + 1
	j outerloop
exit:
	jr $ra
finalexit: