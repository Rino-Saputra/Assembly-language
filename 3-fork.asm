;;create new process that its copy from curren process

SECTION .data
    childMsg        db      'This is the child process', 0h     ; a message string
    parentMsg       db      'This is the parent process', 0h    ; a message string

    len_1 equ $ -childMsg
    len_2 equ $ -parentMsg
 
SECTION .text
    global  _start
 
_start:
 
    mov     eax, 2              ; invoke SYS_FORK (kernel opcode 2)
    int     80h
 
    cmp     eax, 0              ; if eax is zero we are in the child process
    jz      child               ; jump if eax is zero to child label
 
parent:
    mov eax,4                ;sys_write
    mov ebx,1                ;file descriptor std_out
    mov ecx,parentMsg
    mov edx,len_2
    int 0x80
 
    jmp    quit                ; quit the parent process
 
child:
    mov eax,4                ;sys_write
    mov ebx,1                ;file descriptor std_out
    mov ecx,childMsg
    mov edx,len_1
    int 0x80

quit:
    mov eax,1
    mov ebx,0
    int 0x80