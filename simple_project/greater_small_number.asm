;find gretest small number from init variable/memory

section .data
	num1 db 5
	num2 db 9
	great_number db 0
	small_number db 0

	greates_msg db 'greatest number is:',0x00
	len1 equ $ -greates_msg

	small_msg db 'smallest number is:',0x00
	len2 equ $ -small_msg

	new_line db 0xa,0xd

section .bss
	;data here

section .text
	global _start

_start:
	;code here
	mov al,[num1]
	mov bl,[num2]

	cmp al,bl ; 9,5

	jl small_num

	mov [great_number],al
	mov [small_number],bl
	jmp end

small_num:
	mov [great_number],bl
	mov [small_number],al

end:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,greates_msg
	mov edx,len1
	int 0x80
	
	mov al,[great_number]
	mov bl,[small_number]
	add bl,byte '0'
	add al,byte '0'
	mov [great_number],al
	mov [small_number],bl

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,great_number
	mov edx,1
	int 0x80

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,new_line
	mov edx,1
	int 0x80

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,small_msg
	mov edx,len2
	int 0x80

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,small_number
	mov edx,1
	int 0x80

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80
























; 	;code here
; 	mov al,[num1]
; 	mov bl,[num2]
; 	cmp al,bl ;100,90
; 	jl label

; 	mov eax,4				;sys_write
; 	mov ebx,1				;file descriptor std_out
; 	mov ecx,msg2
; 	mov edx,len2
; 	int 0x80
; 	jmp end

; label:
; 	mov eax,4				;sys_write
; 	mov ebx,1				;file descriptor std_out
; 	mov ecx,msg1
; 	mov edx,len1
; 	int 0x80


	;here-> eax is point or dest is point
	; mov eax,100
	; mov ebx,90		;go to label
	; cmp eax,ebx
	; jg label

	;same eax is point or dest is point
	; mov eax,90
	; mov ebx,100		;go to label
	; cmp eax,ebx
	; jl label
