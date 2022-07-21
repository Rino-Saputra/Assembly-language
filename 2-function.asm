_print_char:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,esi
	mov edx,4
	int 0x80
	ret