
section .data
	;data here
	; num db 3
section .bss
	;data here
	num resb 1

section .text
	global _start

_start:
	;code here
	mov [num],byte 9
	mov eax,[num]
	add eax,'0'
	mov [num],eax

	mov eax,4
	mov ebx,1
	mov ecx,num
	mov edx,1
	int 0x80

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80