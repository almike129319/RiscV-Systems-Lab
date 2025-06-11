.section .data
n: .word 7
highest_sp: .word 0
lowest_sp: .word 0
.section .text

.global main

main:

la t0,n
lw a3,0(t0) # a3 contains n

la t1,highest_sp
lw t2,0(sp)
sw t2,0(t1)
la t1,lowest_sp
sw t2,0(t1)

sw t2,0(t1)
li a0,1
li a1,1
li a2,0

jal ra,fib_sum

check:
# label for checking values of a0,a1
la t1,highest_sp
la t2,lowest_sp
lw t1,0(t1)
lw t2,0(t2)
sub a1,t1,t2 # a1 contians lowest -highest



li a7, 93
ecall 

fib_sum:

addi sp,sp,-8

la t4,lowest_sp
lw t5,0(t4)
addi t5,t5,-8
sw t5,0(t4)

sw ra,4(sp);    
li t1,2
beq a3,t1,base

addi a3,a3,-1

jal ra,fib_sum

mv t2,a1

add a1,a1,a2

mv a2,t2

add a0,a0,a1

lw ra,4(sp)
addi sp,sp,8

ret

base:
li a0,1
li a1,1
li a2,0

lw ra,4(sp)
addi sp,sp,8
ret

