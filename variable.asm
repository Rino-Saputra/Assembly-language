;some kind of variable

section .data
	;data here
	char db 65 				;variable that have one byte or as same as char in c, 65 presentation A character [define byte]
	short_var dw 30000 		;variable have 2 byte as same as short in c [define word]
	integer_var dd 100000	;variable have 4 byte as same as int int c [define double word]
	long_var dq 2000000

	msg_input db 'input number: ',0x0
	msg_output db 'output is: ',0x0


section .bss
	;data here
	var_char resb 1 	;size same as db can use x nomerous after resb
	var_short resw 1	;size same as dw can use x nomerous after resw program read per 1word/2byte
	var_integr resd 1	;read per one double word/4byte/2word
	var_log resq 1

section .text
	global _start

_start:
	;print message input
	mov eax,4
	mov ebx,1
	mov ecx,msg_input
	mov edx,14
	int 0x80

	;input number 
	mov eax,3
	mov ebx,0
	mov ecx,var_integr
	mov edx,4
	int 0x80

	;print ouput msg
	mov eax,4
	mov ebx,1
	mov ecx,msg_output
	mov edx,11
	int 0x80

	;print output
	mov eax,4
	mov ebx,1
	mov ecx,var_integr
	mov edx,4
	int 0x80

	;print newline
	mov eax,4
	mov ebx,1
	mov ecx,0xa
	mov edx,1
	int 0x80

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80