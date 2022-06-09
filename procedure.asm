
section .data
	;data here
	globl_msg db 'out of function',0xa
	msg1 equ $ -globl_msg
	fun_msg db 'in function',0xa
	msg2 equ $ -fun_msg

section .bss
	;data here
	ret_value resb 1

section .text
	global _start

_start:
	
	call function

	;get return value by procedure
	add eax, byte '0'
	mov [ret_value],eax

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,ret_value
	mov edx,1
	int 0x80

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80

function:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,fun_msg
	mov edx,msg2
	int 0x80
	mov eax,9
	ret