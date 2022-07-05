
section .data
	;data here
	seeder dd 59

	msg db 'input number: '
	len_msg equ $ -msg

	msg_again db 0xa,'continue? y/n : '
	len_again equ $ -msg_again

	msg_correct db 0xa,'your number is correct: ',
	len_msg_correct equ $ -msg_correct

	greater db 'number is greater',0xa
	len_greater equ $ -greater

	less db 'number is less',0xa
	len_less equ $ -less

	clear_console: db   27,"[H",27,"[2J"    ; <ESC> [H <ESC> [2J
	clear_len   equ  $-clear_console        ; Length of term clear string

section .bss
	;data here
	time resd 1
	time_str resb 10
	rand_num resd 1
	play resb 2
	input_num resb 10
	int_input_num resd 1

section .text
	global _start

_start:
	;clear when play again
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,clear_console
	mov edx,clear_len
	int 0x80

	xor esi,esi
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx

	mov eax,0x0d		;sys time
	xor ebx,ebx
	int 0x80

	mov [time],eax

;;make rand number
	mov ebx,[seeder]
make_rand:
	mov ecx,[seeder]
	xor edx,edx
	div ecx
	add edx,byte 81

	mov eax,edx
	xor edx,edx
	mov ecx,2
	mul ecx

	mov [rand_num],eax
	dec bx
	cmp bx,0
	jnz make_rand

;;end 

;;loop till user get correct number
while:
	; xor esi,esi
	mov [int_input_num],dword 0
	;input number
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg
	mov edx,len_msg
	int 0x80

	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,input_num
	mov edx,10
	int 0x80

	;convert to number
	mov esi,input_num ;input->22

	mov ebx,0
	mov eax,ebx		;result
	.get_num:
		cmp byte[esi],0x30
		jl .end

		cmp byte[esi],0x39
		jg .end

		mov ecx,10		;result * 10
		mul ecx

		mov dl,byte[esi];dl=*esi
		sub dl,byte '0'	;ascii->number
		add eax,edx		;result+=edx
		mov ebx,eax		;ebx =result+esi
		
		xor edx,edx		;edx=0
		inc esi
		jmp .get_num
	.end:
		mov [int_input_num],ebx	;int_input=result
		;compare input with random number
		mov eax,[rand_num]

		cmp ebx,eax	;
		jl ._less

		cmp ebx,eax ;
		jg ._greater

		jmp correct

	._greater:
		mov eax,4				;sys_write
		mov ebx,1				;file descriptor std_out
		mov ecx,greater
		mov edx,len_greater
		int 0x80
		jmp while

	._less:
		mov eax,4				;sys_write
		mov ebx,1				;file descriptor std_out
		mov ecx,less
		mov edx,len_less
		int 0x80
		jmp while


correct:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_correct
	mov edx,len_msg_correct
	int 0x80

;print correct number
	xor esi,esi
	mov esi,time_str
	mov bl,0
get_digit:
	mov dl,byte 0
	mov eax,[rand_num]
	mov ecx,10
	div ecx

	add dl,byte'0'
	mov [esi],dl

	mov [rand_num],eax

	inc bl
	inc esi
	cmp eax,10
	jg get_digit

	inc bl
	add al,byte '0'
	mov [esi],al

	push ebx	;for counter
get_ascii:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,esi
	mov edx,1
	int 0x80

	pop ebx
	dec bl
	dec esi
	push ebx
	cmp bl,0
	jg get_ascii

	;get nw seede for rand number
	mov eax,[rand_num]
	mov [seeder],eax

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_again
	mov edx,len_again
	int 0x80

	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,play
	mov edx,2
	int 0x80

	cmp byte[play],0x79
	je _start

	;sys_exit kernel
	mov eax,1
	mov ebx,[esp]
	int 0x80
