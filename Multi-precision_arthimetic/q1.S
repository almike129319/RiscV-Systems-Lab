.section .data
num1: .dword 0x1234567887654321
num2: .dword 0x8765432112345678
res: .dword 0

.section .text
.global main

main:
 
  la t0, num1
  la t1, num2
  la t4, res
  
  ld t2,0(t0)
  ld t3,0(t1)

  mul t5,t2,t3
  sd t5,8(t4)

  mulhu t5,t2,t3
  sd t5,0(t4)




