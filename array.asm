;note to print sum more one digit must have use call printf c or make own print

section .data
	;data here
	num db 1,2,2,1
	sum db 0

section .bss
	;data here

section .text
	global _start

_start:
	;code here
	mov ecx,4
	mov eax,num
	; mov ebx,4

count_num:
	add edx,[eax]
	add eax,1
	sub ecx,1
	jnz count_num

	add edx,'0'
	mov [sum],edx

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,sum
	mov edx,1
	int 0x80

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80