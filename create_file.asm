
 SECTION .data
filename db 'make_afile.txt', 0h    ; the filename to create
 
SECTION .text
global  _start
 
_start:
 
    mov ecx, 544         ; set all permissions to read, write, execute
    mov ebx, filename       ; filename we will create
    mov eax, 8              ; invoke SYS_CREAT 
    int 0x80

    mov eax,1
    mov ebx,0
    int 0x80
































; section .data
; 	;data here
; 	;;-------example 1---------
; 	; test_num db 5,9
; 	; test_num db 1,2
; 	;-------------------------

; 	;;-------example 2---------
; 	; test_num2 dw 259
; 	;-------------------------


; section .bss
; 	;data here

; section .text
; 	global _start

; _start:
; 	;code here
; 	;;-------example 1---------
; 	; mov ax,word [test_num]	; ah=9, al=5
; 	; mov bl,ah		
; 	; push ebx
; 	;-------------------------

; 	;;-------example 2---------
; 	; mov al,byte [test_num2]	
; 	; mov bx,word [test_num2]	;;the number 259 is convert to hexa first then 0103h, which bl is 03h and bh is 01h 
; 	; mov bl,al
; 	; push ebx
; 	;-------------------------


; 	;sys_exit kernel
; 	mov eax,1
; 	mov ebx,0
; 	int 0x80
































; section .data
; 	;data here
; 	num db 9
; 	num1 db 5
; 	num2 db 2
; 	num3 db 6
; 	offset db 1

; section .bss
; 	;data here

; section .text
; 	global _start

; _start:
; 	;code here

; 	movsx eax,byte [num]
; 	mov [offset],ah

; 	;sys_exit kernel
; 	mov eax,1
; 	mov ebx,[offset]
; 	int 0x80