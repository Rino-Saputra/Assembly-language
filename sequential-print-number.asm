
section .data
	;data here

section .bss
	;data here

section .text
	global _start

_start:
	;push to esp with 0 number/init
	push byte 0

print:
	;convert to ascii with pop it from esp to eax
	pop eax
	add eax,'0'
	push eax

	;print ascii
	mov eax,4
	mov ebx,1
	mov ecx,esp
	mov edx,1
	int 0x80

	;print new line with push oxa to esp+2
	push 0xa
	mov eax,4
	mov ebx,1
	mov ecx,esp
	mov edx,1
	int 0x80

	;after print new line pop back this new line number
	pop ecx

	;convert back to number
	pop eax
	sub eax,'0'

	;add number +1
	inc eax

	;push to stack again with new value
	push eax

	;compare current value with 9
	cmp eax,9

	;jump to print label if current value in eax less or equal 9
	jle print
	

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80