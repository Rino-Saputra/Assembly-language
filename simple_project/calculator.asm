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

	int_sum dd 0
	int_num1 dd 0
	int_num2 dd 0

	error_msg db 'operator is not valid',0xa,0xd
	len_error_msg equ $ -error_msg

	msg_result db 'result: '
	len_result equ $ -msg_result

section .bss
	;data here
	operator resb 1
	temp_str_num resb 12
	counter resb 1
	trash resb 1
	str_num1 resb 9
	str_num2 resb 9

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
	mov edx,9
	int 0x80

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,input_num2
	mov edx,len_input_num2
	int 0x80

	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,str_num2
	mov edx,9
	int 0x80

	;convert string to number
	mov esi, str_num1
	mov edi, str_num2
	
get_num1:
	movzx ebx, byte[esi]

	cmp bl,0x30			;if less than '0'
	jl get_num2

	cmp bl,0x39			;if greter than '9'
	jg get_num2

	sub bl,0x30

	mov eax,10
	mov ecx,[int_num1]	;mul current sum with 10
	mul ecx

	add eax,ebx			; add current sum with new num byte from input

	mov [int_num1],eax

	inc esi
	jmp get_num1

get_num2:
	xor eax,eax
	xor ecx,ecx
	xor ebx,ebx

	movzx ebx, byte[edi]

	cmp bl,0x30			;if less than '0'
	jl make_sum

	cmp bl,0x39			;if greter than '9'
	jg make_sum

	sub bl,0x30

	mov eax,10
	mov ecx,[int_num2]	;mul current sum with 10
	mul ecx

	add eax,ebx			; add current sum with new num byte from input

	mov [int_num2],eax

	inc edi
	jmp get_num2


;make sum is it add,mul,div,or sub between two operand
make_sum:
	cmp byte[operator],0x61	; char a
	jne _sub

_add:
	call add_number
	jmp _result

_sub:
	cmp byte[operator],0x73 ;char s
	jne _mul
	call sub_number
	jmp _result
_mul:
	cmp byte[operator],0x6d ;char m
	jne _div
	call mul_number
	jmp _result
_div:
	call div_number

_result:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_result
	mov edx,len_result
	int 0x80

	
	mov ebx,0
	mov eax,[int_sum]	;for result
	mov ecx,10			;for divisor

get_digit:
	;ax for result,
	;bx for counter,
	;cx for divisor,
	;dx for remain
	
	mov edx,0			;for remind

	div ecx

	add dl,byte '0'
	mov [temp_str_num+ebx],dl
	inc ebx

	mov [int_sum],eax

	cmp eax,10
	jg get_digit

	add eax,byte '0'
	mov [temp_str_num+ebx],al

	mov [counter],bl


;print reverse
; 	; dec byte[counter]
	mov esi,temp_str_num
	mov cl,[counter]
get_last:
	inc esi
	dec cl
	cmp cl,0
	jg get_last

_print:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,esi
	mov edx,1
	int 0x80

	dec esi
	dec byte[counter]
	mov cl,[counter]
	cmp cl,0
	jge _print


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
	mov eax,[int_num1]
	mov ebx,[int_num2]
	add eax,ebx
	mov [int_sum],eax
	ret

sub_number:
	mov eax,[int_num1]
	mov ebx,[int_num2]
	sub eax,ebx
	mov [int_sum],eax
	ret

div_number:
	mov eax,[int_num1]
	mov ecx,[int_num2]
	div ecx
	mov [int_sum],eax
	ret	

mul_number:
	mov eax,[int_num1]
	mov ecx,[int_num2]
	mul ecx
	mov [int_sum],eax
	int 0x80
	ret	