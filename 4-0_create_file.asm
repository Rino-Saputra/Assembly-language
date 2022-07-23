
section .data
	;data here
	filename db 'file_to_delete.txt', 0h    ; the filename to create

section .bss
	;data here

section .text
	global _start

_start:
	;code here
	mov ecx, 0777o          ; set all permissions to read, write, execute
    mov ebx, filename       ; filename we will create
    mov eax, 8              ; invoke SYS_CREAT (kernel opcode 8)
    int 80h    

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80