.section .data
num1: .dword 0x1234567887654321,0x1234567887654321
num2: .dword 0x8765432112345678,0x8765432112345678

res: .dword 0,0,0,0
.section .text
.global main


main:

 la t0,num1
 la t1,num2

 ld t2,0(t0)
 ld t3,8(t0)

 ld t4,0(t1)
 ld t5,8(t1)

 la t6,res
 
 mul a0,t3,t5
 sd a0,24(t6)

 mulhu a1,t3,t5
 mul a2,t2,t5
 mul a3,t3,t4
 
 li a6,0

 add a1,a1,a2;
 sltu a7,a1,a2
 add a6,a6,a7
 add a1,a1,a3
 sltu a7,a1,a3
 add a6,a6,a7

 sd a1,16(t6)

 mulhu a1,t3,t4
 mulhu a2,t2,t5
 mul a3,t2,t4

 add a1,a1,a6

 li a6,0
 add a1,a1,a2
 
 sltu a7,a1,a2
 add a6,a6,a7

 add a1,a1,a3
 sltu a7,a1,a3
 add a6,a6,a7

 sd a1,8(t6)

 mulhu a1,t2,t4
 add a1,a1,a6

 sd a1,0(t6)



