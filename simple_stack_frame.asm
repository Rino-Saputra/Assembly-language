
section .data
	;data here

section .bss
	;data here

section .text
	global _start

_start:
	;code here
						;esp->0xbffff110			;ebp->0x000000
	push dword 9		;esp->0xbffff10c->0x000009	;ebp->0x000000
	push ebp			;esp->0xbffff108			;ebp->0x000000
	mov ebp,esp 		;esp->0xbffff108			;ebp->0xbffff108  ;that mean ebp store esp adress point to
	push dword 256		;esp->0xbffff104			;ebp->0xbffff108
	push dword 10900	;esp->0xbffff100			;ebp->0xbffff108
	mov esp,ebp 		;esp->0xbffff108			;ebp->0xbffff108 ;that mean esp back to first adress to ebp
													;or to address where before push 256 and 1090 /mov ebp,esp
	pop ebp 			;esp->0xbffff10c->0x000009	;ebp->0x000000 	;that mean ebp back to origin address and esp-
																	;add 4 byte which containt valu 9


	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80