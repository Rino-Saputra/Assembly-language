
section .data
	;data here
	file_open db 'readme.txt', 0h    ; the filename to open
	len db 3

section .bss
	;data here

section .text
	global _start

_start:
	;code here
	mov eax,5			;;syscall open
	mov ebx,file_open	;;name file to open
	mov ecx, 2      	;;file acces mode to read, write, execute, 1 to write only, 0 to read only
	mov edx,07770		;;set all permissions to read, write, execute	
	int 0x80			;;call kernel
	
	; ----------------------------------------------------------------------------
	;| if file exist/not error. value return to eax is bigger than 0 in mine is 3 |
	;| if file dosnt exist/error, value rturn to eax is less than 0 in mine is -2 | 
	; ----------------------------------------------------------------------------

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80