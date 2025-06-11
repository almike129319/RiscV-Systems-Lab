.section .data
    set_11 : .word 0x00008000
    set_12 : .word 0x00010000
    set_8  : .word 0x00000100
    set_all_1 : .word 0xffffffff
.section .text
.global main

main:

    li t1,0x00000800
    li t2, 1
    slli t2, t2, 12
    not t2, t2
    li t3,0x00000100

    csrr t0,mstatus
    or t0,t0,t1
    and t0,t0,t2
    csrw mstatus,t0
    csrc mstatus,t3

    li t1,0x100
    csrr t0,medeleg
    or t0,t0,t1
    csrw medeleg,t0

    la t0,mtrap_handler
    csrw mtvec,t0

    la t0,scode
    csrw mepc,t0
    mret
.align 4
mtrap_handler:

    csrr t0,mepc
    addi t0,t0,4
    csrw mepc,t0
    mret

scode: 

    la t0,strap_handler
    csrw stvec,t0

    la t0,ucode
    csrw sepc,t0
    sret
.align 4
strap_handler:

    csrr t0,sepc
    csrr t1,scause
    ecall

    la t2,ucode
    csrw sepc,t2
    sret

ucode:
    
    ecall
