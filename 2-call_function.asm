
%include 'function.asm'

section .data
	;data here
	msg db 'test',0xa

section .bss
	;data here

section .text
	global _start

_start:
	;code here
	mov esi,msg
	; sub esp,4
	; mov[esp],byte'h'
	; mov[esp+1],byte'e'
	; mov[esp+2],byte'l'
	; mov[esp+3],byte'o'

	call _print_char


	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80