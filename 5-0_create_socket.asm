
section .data
	;data here

section .bss
	;data here

section .text
	global _start

_start:
	;code here
	;;clear register that use for socket
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edi,edi
	xor esi,esi

	;;create socket
_socket:
    push    byte 6              ; push 6 onto the stack (IPPROTO_TCP)
    push    byte 1              ; push 1 onto the stack (SOCK_STREAM)
    push    byte 2              ; push 2 onto the stack (PF_INET)

    mov     ecx, esp            ; move address of arguments into ecx
    mov     ebx, 1              ; invoke subroutine SOCKET (1)
    mov     eax, 102            ; invoke SYS_SOCKETCALL (kernel opcode 102)
    int     80h                 ; call the kernel


	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80