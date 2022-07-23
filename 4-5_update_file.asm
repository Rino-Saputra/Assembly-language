;;----------------------------------------------------------
;; 1.open file
;; 2.seek pointer is it to beginning,current or end of file
;; 3.write to file with fd which its get from valu eax when sys_open return value to eax
;; 4.close file
;;-----------------------------------------------------------

section .data
	;data here
	file_open db 'readme.txt', 0h    ; the filename to open
	str_write db ' add',0h
	len_str equ $ -str_write

section .bss
	;data here

section .text
	global _start

_start:
	;code here
	mov eax,5			;;syscall open
	mov ebx,file_open	;;name file to open
	mov ecx, 1      	;;file acces mode to read, write, execute, 1 to write only, 0 to read only
	mov edx,07770		;;set all permissions to read, write, execute	
	int 0x80	

	;;seek pointer to end file/current file/beginning file
	mov ebx,eax			;;file descriptor that get from return valu to eax when open file
	mov eax,19			;;invoke SYS_LSEEK (kernel opcode 19)
	mov ecx,0			;;offset byte from end of file/EOF
	mov edx,2			;;whence argument (SEEK_END), 2(SEEK_END), 1(SEEK_CURrent), 0(SEEK_SET) or beginning file
	int 0x80

	;;write to file from offset address and pointer position from SYS_LSEEK
	mov eax,4			;;sys_write
	mov ebx,ebx			;;same as before its fd 
	mov ecx,str_write	;;memory addres to write into file 
	mov edx,len_str-1	;;-1 for ignore null string
	int 0x80

	;;close file
	mov eax,6		;;sys_close
	mov ebx,ebx		;;already required before
	int 0x80		;;call kernel

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80