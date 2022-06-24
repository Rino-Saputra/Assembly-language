
section .data
	;data here
	num db 0

section .bss
	;data here

section .text
	global _start

_start:
	;code here
	mov eax,3				;sys_read
	mov ebx,0				;file desceiptor stdin
	mov ecx,num
	mov edx,3
	int 0x80

	mov edi,num

	mov al, byte 0	;sum of operation

get_char:

	movzx edx, byte[edi] ;mov one byte edi to edx / dl 

	cmp dl,48
	jl end

	cmp dl,57
	jg end

	mov bl,byte [edi]
	sub bl, byte '0'
	mov dl, byte 10

	mul dl
	add al,bl

	inc edi
	jmp get_char


	
end:
	push eax
	;sys_exit kernel
	mov eax,1
	mov ebx,[esp]
	int 0x80