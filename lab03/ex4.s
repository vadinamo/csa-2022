.globl main

.data
n: .word 8
recursive_output:	.asciiz "Recursive output:"
iterative_output:	.asciiz "Iterative output:"
answers_equals: 	.asciiz "Answers are equal"
answers_not_equals:	.asciiz "Answers are not equal"

.text
main:
	la a0, iterative_output
    jal print_str
    la t0, n
    lw a0, 0(t0)	#a0 = n
    
    jal iterative
    mv s1, a1
    jal print_int
    jal print_newline
    
    la a0, recursive_output
    jal print_str
	la t0, n
    lw a0, 0(t0)	#a0 = n
    
   	jal recursive
    mv s2, a1
    jal print_int
    jal print_newline
    
    mv a0, s1
    mv a1, s2
    jal tester
    
    addi a1, a1, 1
    beqz a1, not_equal
    
equal:
	la a0, answers_equals
    jal print_str
	j exit

not_equal:
	la a0, answers_not_equals
    jal print_str
	j exit

iterative:
	addi  sp, sp, -8    # reserve our stack area
    sw ra, 0(sp)	#sp - адрес возврата
    
	addi a1, x0, 1	#a1(res) = 1
    addi a2, x0, 1	#a2(i) = 1
    j loop
    
loop:
	sw a0, 4(sp)    # sp = a0(n)
	lw t0, 4(sp)    # t0 = n
    
	bgtu a2, a0, iterative_return
    mul a1, a1, a2
    addi a2, a2, 1
    
    j loop
    
iterative_return:
    lw ra, 0(sp)    # ra = sp (получаем return адрес из стека)
    addi sp, sp, 8  # освобождаем стек
    jr ra           # возвращаем полученный результат
    
recursive:
	addi  sp, sp, -8    # reserve our stack area
    sw ra, 0(sp)	#sp - адрес возврата
    
    li t0, 2	#t0 = 2
    blt a0, t0, one	# if a0 < t0(2) goto ret_one
    
    sw a0, 4(sp)    # sp = a0(n)
    addi a0, a0, -1	# a0--
    jal recursive	# вызываем recursive(n-1)
                    # a1 = fact(n-1)
    lw t0, 4(sp)    # t0 = n
    mul a1, t0, a1  # a1 = n * (n-1)!
    j recursive_return
    
one:
    li a1, 1
    
recursive_return:
    lw ra, 0(sp)    # ra = sp (получаем return адрес из стека)
    addi sp, sp, 8  # освобождаем стек
    jr ra           # возвращаем полученный результат
    
tester:
	addi  sp, sp, -8    # reserve our stack area
    sw ra, 0(sp)	#sp - адрес возврата
	beq a0, a1, tester_return

minus_one_return:
	li a1, -1
    
tester_return:
	lw ra, 0(sp)    # ra = sp (получаем return адрес из стека)
    addi sp, sp, 8  # освобождаем стек
    jr ra           # возвращаем полученный результат
    
print_int:
	# to print an integer, we need to make an ecall with a0 set to 1
    # the thing that will be printed is stored in register a1
    # this line copies the integer to be printed into a1
    # set register a0 to 1 so that the ecall will print
    li a0, 1
    # print the integer
    ecall
    # return to the calling function
    jr    ra
    
print_newline:
    li a1, '\n'
    li a0, 11 # tells ecall to print the character in a1
    ecall
    jr    ra
    
print_str:
    mv a1, a0
    li a0, 4 # tells ecall to print the string that a1 points to
    ecall
    jr    ra

exit:
	li a0, 10
    ecall