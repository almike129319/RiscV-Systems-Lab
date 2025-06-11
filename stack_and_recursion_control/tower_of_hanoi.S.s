.section .data
n: .word  10
str : .asciz "Move from rod X to rod Y\n" #define the string in data section
x : .word 14 # idx of x in str
y : .word 23 # idx of y in str

.section .text

.global main

main:
la t1,n
lw a0,0(t1)

li a1,1
li a2,3
li a3,2

jal ra,towerofhanoi

li a7,93
ecall

towerofhanoi:

addi sp,sp,-24
sw ra,4(sp)
sw a1,8(sp)
sw a2,12(sp)
sw a3,16(sp)
sw a0,20(sp)

li t1,1
beq a0,t1,case1
lw a2,16(sp)
lw a3,12(sp)
lw a0,20(sp)
addi a0,a0,-1
jal ra,towerofhanoi

lw a1,8(sp)
lw a2,12(sp)
la t0, str 
addi t1,a1,48
sb t1, 14(t0) 
addi t1, a2, 48
sb t1,23(t0)

li a0, 1 #pass the file descriptor: 1 is stdout
la a1, str #pass the address of the string
li a2, 25 #pass the length of the string
li a7, 64 #pass the syscall number for write
ecall #make syscall 

lw a0,20(sp)
addi a0,a0,-1
lw a1,16(sp)
lw a2,12(sp)
lw a3,8(sp)
jal ra ,towerofhanoi

lw ra,4(sp)
addi sp,sp,24
ret

case1:

la t0, str 
addi t1,a1,48
sb t1, 14(t0) 
addi t1, a2, 48
sb t1,23(t0)

li a0, 1 #pass the file descriptor: 1 is stdout
la a1, str #pass the address of the string
li a2, 25 #pass the length of the string
li a7, 64 #pass the syscall number for write
ecall #make syscall
lw ra,4(sp)
addi sp,sp,24
ret
