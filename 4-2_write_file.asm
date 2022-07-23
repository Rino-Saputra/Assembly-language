
section .data
	;data here
	file_open db 'readme.txt', 0h    ; the filename to open
	msg db 'test',0h
	len_msg equ $ -msg

section .bss
	;data here

section .text
	global _start

_start:
	;code here
	mov eax,5			;;syscall open
	mov ebx,file_open	;;name file to open
	mov ecx, 2      	;;file acces mode to read, write, execute,write, execute, 1 to write only, 0 to read only
	mov edx,07770		;;set all permissions to read, write, execute	
	int 0x80			;;call kernel


	mov ebx,eax			;;file descriptor value from return value when open existing file or if open is success
	mov eax,4			;;for sys_write mov to ebx before overwrite with new syscall
	mov ecx,msg 		;;pointer to msg address
	mov edx,len_msg-1	;;len msg -1 because to ignore null string
	int 0x80			;;call kernel

	;;	---------------------------------------------------------------------
	;; | first open file if success eax will get bigger than 0 mine 3,		 |
	;; | then first mov fd in eax after open file to ebx before eax overwrite|
	;; | then sys read 														 |
	;; | then leng msg is -1 to ignore null terminate when write to file     |
	;;	---------------------------------------------------------------------
	;;nb: sys_write not write to stdout terminal but to stdout which get from open file in eax line 23


	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80