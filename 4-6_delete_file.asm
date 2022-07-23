section .data
	;data here
	file_open db 'file_to_delete.txt', 0h    ; the filename to open

section .bss
	;data here
	file_content resd 255

section .text
	global _start

_start:
	;code here
	mov eax,10			;;sys_unlink
	mov ebx,file_open	;;name file to delete
	int 0x80	

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80