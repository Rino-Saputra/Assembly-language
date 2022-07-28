
section .data
	;data here
	msg1 db "input: ",0x0
	len_msg1 equ $ -msg1

	msg2 db "input2: ",0x0
	len_msg2 equ $ -msg2

	; inp1 db "input1",0xa
	; len_inp1 equ $ -inp1

	inp2 db "input1",0xa
	len_inp2 equ $ -inp2

section .bss
	;data here
	inp1 resb 255

section .text
	global _start

_start:
	;code here
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg1
	mov edx,len_msg1
	int 0x80

	; xor eax,eax
	; mov ecx,len_inp1
	; mov edi,inp1
	; rep stosb

	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,inp1
	mov edx,255
	int 0x80

	; mov eax,4				;sys_write
	; mov ebx,1				;file descriptor std_out
	; mov ecx,inp1
	; mov edx,len_inp1
	; int 0x80

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg2
	mov edx,len_msg2
	int 0x80

	xor eax,eax
	mov ecx,len_inp2
	mov edi,inp2
	rep stosb

	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,inp2
	mov edx,len_inp2
	int 0x80
	
	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80