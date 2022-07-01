;https://stackoverflow.com/questions/17206683/nasm-interrupt-calls-getting-skipped-and-outputting-multiple-lines
;https://stackoverflow.com/questions/22651039/input-incorrect-assembly-x86-nasm
;https://stackoverflow.com/questions/18780927/how-do-i-ignore-line-breaks-in-input-using-nasm-assembly
section .data
	;data here
	ClearTerm: db   27,"[H",27,"[2J"    ; <ESC> [H <ESC> [2J
	CLEARLEN   equ  $-ClearTerm         ; Length of term clear string

	msg_welcome db 'press a: to add',0xa,0xd,'press s: to sub',0xa,0xd,'press m: to mul',0xa,0xd,'press d: to div',0xa,0xd
	len_msg_welcome equ $ -msg_welcome

	input_msg db 'your input: '
	len_input_msg equ $ -input_msg

	input_num1 db 'input first number: '
	len_input_num1 equ $ -input_num1

	input_num2 db 'input second number: '
	len_input_num2 equ $ -input_num2

	int_num1 dd 0
	int_num2 dd 0

	error_msg db 'operator is not valid',0xa,0xd
	len_error_msg equ $ -error_msg

	msg db 'operator is vaid',0xa,0xd
	len_msg equ $ -msg

	msg_add db 'in add',0xa
	len_msg_add equ $ -msg_add

	msg_sub db 'in sub',0xa
	len_msg_sub equ $ -msg_sub

	msg_div db 'in div',0xa
	len_msg_div equ $ -msg_div

	msg_mul db 'in mul',0xa
	len_msg_mul equ $ -msg_mul

section .bss
	;data here
	operator resb 1
	trash resb 1
	str_num1 resb 4
	str_num2 resb 4

section .text
	global _start

_start:
	;print message
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_welcome
	mov edx,len_msg_welcome
	int 0x80

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,input_msg
	mov edx,len_input_msg
	int 0x80

	;input operator to decide which operator to execute
	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,operator
	mov edx,1
	int 0x80


	;validation for input
	cmp byte[operator],0x61	; char a
	jne next1_operator
	jmp valid
next1_operator:
	cmp byte[operator],0x73 ;char s
	jne next2_operator
	jmp valid

next2_operator:
	cmp byte[operator],0x6d ;char m
	jne next3_operator
	jmp valid

next3_operator:
	cmp byte[operator],0x64 ;char d
	jne invalid_operator
	jmp valid

invalid_operator:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,error_msg
	mov edx,len_error_msg
	int 0x80
	jmp end

valid:

	call clear_buffer

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,input_num1
	mov edx,len_input_num1
	int 0x80

	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,str_num1
	mov edx,4
	int 0x80

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,input_num2
	mov edx,len_input_num2
	int 0x80

	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,str_num2
	mov edx,4
	int 0x80

	;convert string to number
	mov al


	cmp byte[operator],0x61	; char a
	jne _sub

_add:
	call add_number
	jmp end

_sub:
	cmp byte[operator],0x73 ;char s
	jne _mul
	call sub_number
	jmp end
_mul:
	cmp byte[operator],0x6d ;char m
	jne _div
	call mul_number
	jmp end
_div:
	call div_number



end:
	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80

clear_buffer:
	mov eax,3				;sys_read
	mov ebx,0
	mov ecx,trash
	mov edx,1
	int 0x80
	ret

add_number:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_add
	mov edx,len_msg_add
	int 0x80
	ret

sub_number:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_sub
	mov edx,len_msg_sub
	int 0x80
	ret

div_number:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_div
	mov edx,len_msg_div
	int 0x80
	ret	

mul_number:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_mul
	mov edx,len_msg_mul
	int 0x80
	ret	
