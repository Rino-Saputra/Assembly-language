

section .data
	msg db "hello world",0x0a,0x00
	len equ $ -msg
section .text
	global _start

_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,len
	int 0x80

	mov eax,1
	mov ebx,0
	int 0x80