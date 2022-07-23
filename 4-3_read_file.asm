
section .data
	;data here
	file_open db 'readme.txt', 0h    ; the filename to open

section .bss
	;data here
	file_content resd 255

section .text
	global _start

_start:
	;code here
	mov eax,5			;;syscall open
	mov ebx,file_open	;;name file to open
	mov ecx, 2      	;;file acces mode to read, write, execute, 1 to write only, 0 to read only
	mov edx,07770		;;set all permissions to read, write, execute	
	int 0x80			;;call kernel

	mov ebx,eax			;;file descriptor value from return value when open existing file or if open is success
	mov eax,3			;; for sys_read eax move to ebx before overwrite
	mov ecx,file_content
	mov edx,4
	int 0x80

	;; now file_content have value from file byte that read from sys_read
	;; then print value from file_content that already have byte

	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,file_content
	mov edx,4
	int 0x80


	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80