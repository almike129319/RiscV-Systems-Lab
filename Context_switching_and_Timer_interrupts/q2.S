.section .text
.global main

main:
		# Enable interrupts
        # configure timer interrupt
		# set the value of mtimecmp register

    li t0,0x2004000
    li t1,10000
    sw t1,0(t0)

    li t0,0x8
    csrs mstatus,t0

    li t0,0x1800
    csrc mstatus,t0

    li t0,0x80
    csrs mie,t0

    la t0,context_switch
    csrw mtvec,t0

    li a0,0
    li a1, 0x0fffffff

    la t0,Task_A
    csrw mepc,t0
    mret

.align 4
context_switch:

		# save the context of the interrupted task by looking at the task id (jump to relavent label)
    la t0,current
    lw t4,0(t0)
    li t1,1
    li t2,2
    li t3,3

    beq t4,t1,one
    beq t4,t2,two
    beq t4,t3,three

    one:
    li t4,3
    sw t4,0(t0)
    jal ra,save_context_A
    j initial_switch_to_B

    two:
    li t4,3
    sw t4,0(t0)
    jal ra,save_context_A
    j switch_to_B
    
    three:
    li t4,2
    sw t4,0(t0)
    jal ra,save_context_B
    j switch_to_A


save_context_A:
		# save all the registers and PC value in stack_a
		# mepc stores the value of PC at the time of interrupt
    li t0,0xf0000000    #load the stack_a
    addi t0,t0,-24
    sw a0,0(t0)
    sw a1,8(t0)

    ret
save_context_B:
		# save all the registers and PC value in stack_b
        li t0,0xf0000100    #load the stack_a
        addi t0,t0,-24
        sw a0,0(t0)
        sw a1,8(t0)

        ret
switch_to_A:
		# restore the values of registers and PC from stack_a
    la t0,Task_A
    csrw mepc,t0

    li t0,0xf0000000    #load stack_a
    addi t0,t0,-24
    lw a0,0(t0)
    lw a1,8(t0)

    j switch

switch_to_B:
		# restore the values of registers and PC from stack_b
    la t0,Task_B
    csrw mepc,t0

    li t0,0xf0000100    #load stack_b
    addi t0,t0,-24
    lw a0,0(t0)
    lw a1,8(t0)

    j switch

initial_switch_to_B:
		# switching to Task B for the first time

    la t0,Task_B
    csrw mepc,t0

    li a0,0x03fffff
    li a1,0

    j switch

switch:
		# set the value of mtimecmp and switch to your preferred task
    li t0,0x2004000
    lw t1,0(t0)
    li t2,10000
    add t1,t1,t2
    sw t1,0(t0)

    mret

Task_A:
		# increment your reg value
    
    loopa:
        addi a0,a0,1
        bge a0,a1,end
        j loopa
    
    end:
    j finish_a

finish_a:
    j finish_a

Task_B:
		# decrement the reg value

    loopb:
        addi a0,a0,-1
        beqz a0,endloop
        j loopb
    endloop:
        j finish_b
    
finish_b:
    j finish_b

.data
.align
stack_a:  .word 0xf0000000 # initialize stack for task A (You can choose a random address) 
stack_b:  .word 0xf0000100 # initialize stack for task B
current:  .word 0x1 # variable to identify the task 