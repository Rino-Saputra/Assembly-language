
section .data
	;data here
	draw_table 	db ' _____ _____ _____ ',0x0a,
				db '|     |     |     |',0x0a,
				db '|  1  |  2  |  3  |',0x0a, ;1->43
				db '|_____|_____|_____|',0x0a,
				db '|     |     |     |',0x0a,
				db '|  4  |  5  |  6  |',0x0a,
				db '|_____|_____|_____|',0x0a,
				db '|     |     |     |',0x0a,
				db '|  7  |  8  |  9  |',0x0a, ;8->169
				db '|_____|_____|_____|',0x0a,
	len_draw_table equ $ -draw_table

	msg_inp_player1 db 0xa,'player 1 input: '
	len_msg_inp_player1 equ $ -msg_inp_player1

	msg_inp_player2 db 0xa,'player 2 input: '
	len_msg_inp_player2 equ $ -msg_inp_player2

	msg_err db 0xa,'input is invalid allowed input [1-9]'
	len_msg_err equ $ -msg_err

	msg_same_cell db 0xa,'column had fill',0xa
	len_msg_same_cell equ $ -msg_same_cell

	pointer_position db 0,0,0,0,0,0,0,0,0


section .bss
	;data here
	input resb 2
	trash resb 1
	player1_table resb 5
	player2_table resb 5

section .text
	global _start

_start:
	;code here
	;;get offset adress which content ascii number adn assign to array
	;;offset 43,49,etc
	mov esi,draw_table
	mov edi,pointer_position
	xor ecx,ecx
	xor edx,edx
	; mov eax,len_draw_table

while:

	inc cl 		;counter for count index position in drwa_table
	inc esi

	;if char greater than '0'
	cmp byte[esi],0x30
	jg .less_nine
	jmp .compare

	.less_nine: ;if char less than '9'
		cmp byte[esi],0x39
		jle .push_value
		jmp .compare

	.push_value:
		mov byte[edi],cl 		;mov counter index into pointer_position
		inc edi
		inc dl

	.compare:
		cmp cl,byte len_draw_table
		je _start_game
		jmp while

_start_game:
	;example for offset
	; sub esi,ecx
	; mov ecx,43
	; mov [draw_table+ecx],byte 0x61

	call _dipslay_table

	;x->player 1, 0->player 2

_update_game:
	;;input from user 1
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_inp_player1
	mov edx,len_msg_inp_player1
	int 0x80

	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,input
	mov edx,2
	int 0x80

	;chek validate with esi as input value and edi as refrence to player 1 or player 2
	call _input_validation

	;;update table value
	;get pointer position[index]
	sub [input],byte '0'
	dec byte[input]
	mov al,byte[input]
	mov bl,byte[pointer_position+eax]
	;update value table
	; inc byte[input]
	; add [input],byte'0'
	mov [input],byte 'x'
	mov dl,byte[input]
	mov byte [draw_table+ebx],dl
	call _dipslay_table

	;clear terminal and buffer
	; call clear_buffer

	;input from user 2
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg_inp_player2
	mov edx,len_msg_inp_player2
	int 0x80

	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,input
	mov edx,2
	int 0x80

	;check validate
	call _input_validation

	;clear terminal
	;update table value
	sub [input],byte '0'
	dec byte[input]
	mov al,byte[input]
	mov bl,byte[pointer_position+eax]

	mov [input],byte '0'
	mov dl,byte[input]
	mov byte [draw_table+ebx],dl
	call _dipslay_table

	;check is one of player complete diagram if complete end game
	;clear esi not point to anywhere this register is user to another operation
	xor esi,esi
	xor edi,edi
	call _get_winner1

	;repat till complete

	; jmp _update_game


	;add score to winner player
	;show result is draw or not
	;play again?

end:
	;sys_exit kernel
	mov eax,1
	mov ebx,[esp]
	int 0x80


_input_validation:

	cmp byte[input],0x30
	jl .invalid_msg

	cmp byte[input],0x39
	jg .invalid_msg

	jmp .valid

	;loop again till player 1 input correct input
	.invalid_msg:
		mov eax,4				;sys_write
		mov ebx,1				;file descriptor std_out
		mov ecx,msg_err
		mov edx,len_msg_err
		int 0x80
		jmp end

	.valid:
	ret


_get_winner1:
	xor ecx,ecx
	;for firsr row player 1->'x', check first cell if same go second cell if same again check for all
	;'1' is firs row
	;'4' is second row
	;'7' is third row

	.row1_player1:
		mov ecx,0
		cmp byte[pointer_position+ecx],0x78 ;'x'
		jne .row2_player1

	.row2_player1:
		mov ecx,3
		cmp byte[pointer_position+ecx],0x78 ;'x'
		jne .row3_player1

	.row3_player1:
		

	ret


_dipslay_table:
	;diplay table
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,draw_table
	mov edx,len_draw_table
	int 0x80
	ret

clear_buffer:
	mov eax,3				;sys_read
	mov ebx,0
	mov ecx,trash
	mov edx,1
	int 0x80
	ret
