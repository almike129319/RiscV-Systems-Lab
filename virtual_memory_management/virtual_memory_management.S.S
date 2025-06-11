.section .text
.global main


main:

    li t0,0x800
    csrs mstatus,t0

    la t0,supervisor
    csrw mepc,t0

    # Jump to supervisor mode
    mret

supervisor:

################ Initialize your page tables here ################

####################################################################

    #level 2
    #index 0
    
    li t0,0x81000000
    li t1,0x82001

    slli t1,t1,10
    ori t1,t1,0x1
    sd t1,0(t0)

    #index 2

    li t0,0x81000010
    li t1,0x82000

    slli t1,t1,10
    ori t1,t1,0x1
    sd t1,0(t0)

    #level 1
    #table 1 index 0
    li t0,0x82001000
    li t1,0x83001

    slli t1,t1,10
    ori t1,t1,0x1
    sd t1,0(t0)

    #table 2 index 0
    li t0,0x82000000
    li t1,0x83000

    slli t1,t1,10
    ori t1,t1,0x1
    sd t1,0(t0)

    #level 0
    #1
    li t0,0x83001000
    li t1,0x80001

    slli t1,t1,10
    ori t1,t1,0x59
    sd t1,0(t0)

    #2
    li t0,0x83001008
    li t1,0x80002

    slli t1,t1,10
    ori t1,t1,0x53
    sd t1,0(t0)

    #3
    li t0,0x83000000
    li t1,0x80000

    slli t1,t1,10
    ori t1,t1,0x49
    sd t1,0(t0)

    # Prepare jump to user mode

    li t0,0x100
    csrc sstatus,t1

    la t0,user_code
    csrw sepc,t0


################ DO NOT MODIFY THESE INSTRUCTIONS ################
    la t1, satp_config # load satp val
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero

    li t4, 0
    csrrw zero, sepc, t4 
    sret
####################################################################


.align 12
user_code:
    la t1,var1
    la t2,var2
    la t3,var3
    la t4,var4
    j user_code


.data
.align 12
var1:  .word  1
var2:  .word  2
var3:  .word  3
var4:  .word  4

.align 12
satp_config: .dword  0x8000000000081000 # Value to set in satp