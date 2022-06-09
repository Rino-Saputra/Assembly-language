
section .data
	;data here
	msg_input db 'input your number max 5 length: ',0x00
	len_1 equ $ -msg_input

	msg_output db 'output is: ',0x00
	len_2 equ $ -msg_output

section .bss
	;data here
	num resb 5

section .text
	global _start

_start:
	;code here
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_input
	mov edx,len_1
	int 0x80

	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,num
	mov edx,5
	int 0x80	

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_output
	mov edx,len_2
	int 0x80

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,num
	mov edx,5
	int 0x80

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80