section .data
	;data here
	num db 9
	num1 db 5
	num2 db 2
	num3 db 6
	offset db 1

section .bss
	;data here

section .text
	global _start

_start:
	;code here

	movsx eax,byte [num]
	mov [offset],ah

	;sys_exit kernel
	mov eax,1
	mov ebx,[offset]
	int 0x80