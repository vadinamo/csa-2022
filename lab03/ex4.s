.globl main

.data
n: .word 8

.text
main:
	la t0, n
    lw a0, 0(t0)	#a0 = n
    
    jal iterative
    mv s1, a1
    
   	jal recursive
    
    mv a0, s1
    jal tester
    
    li a0, 1
    ecall
    
    li a0, 10
    ecall

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

not_equal:
	li a1, -1
    
tester_return:
	lw ra, 0(sp)    # ra = sp (получаем return адрес из стека)
    addi sp, sp, 8  # освобождаем стек
    jr ra           # возвращаем полученный результат