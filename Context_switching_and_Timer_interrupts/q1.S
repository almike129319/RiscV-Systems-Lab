.section .text
.global .main
main :
#set the csrs and initialize mtimecmp
    
    li t0,0x2004000
    li t1,10000
    sw t1,0(t0)

    li t0,0x8
    csrs mstatus,t0

    li t0,0x1800
    csrc mstatus,t0

    li t0,0x80
    csrs mie,t0

    la t1,mtrap
    csrw mtvec,t1

    la t1,user
    csrw mepc,t1
    mret
.align 4
mtrap :
#handle the timer interrupt and returnto user−space

    li t0,0x2004000
    lw t1,0(t0)
    li t2,10000
    add t1,t1,t2
    sw t1,0(t0)

    la t1,user
    csrw mepc,t1
    mret

user :
#implement a continuous loop
    li t2,0
    loop:
        addi t2,t2,1
        j loop
    