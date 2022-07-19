
section .data
	;data here
	msg db'test sith address'
	num db 2
	arr dd 0x30,0x31,0x32,0x33

section .bss
	;data here

section .text
	global _start

_start:
	;code here
	; mov eax, dword 259
	; ; call func
	; mov  eip, 0x0804809d
	; jmp eax

	; mov eax,msg
	; add bl,byte[num]
	; lea esi,[msg+1+ebx*2]
	mov ecx,2
	lea eax,[arr+ecx*4] ;content value not address with mov, and content adress with lea
	mov esi,eax		;copy adress in eax to esi

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,esi
	mov edx,1
	int 0x80

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80

func:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,msg
	mov edx,4
	int 0x80
	pop eax
	jmp eax