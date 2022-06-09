;print integer more than one digit 

section .data
	;data here
	num dd 79000

section .bss
	;data here
	counter resb 1

section .text
	global _start

_start:
	;code here

get_digit:
	;set count digit of number to counter when print number
	mov eax,[counter]
	inc eax
	mov [counter],eax

	; inc byte counter
	mov edx, 0
	mov eax, [num]
	mov ecx, 10

	;div current number
	div ecx ; equal to eax=eax/ecx, quotient in eax and remainder in edx

	add edx, byte '0'
	push edx
	;link https://pvk.ca/Blog/2017/12/22/appnexus-common-framework-its-out-also-how-to-print-integers-faster/

	;get quitioen and assign to variable
	mov [num],eax

	;check if less tahn 10, if greater than div again
	mov eax,[num]
	cmp eax,10
	jg get_digit

	;get last num and last number in quitioen from div then push it
	add [num], byte '0'
	mov eax, [num]
	push eax

	;print all number that get reverse from div operation/print order by default qeue number
print_number:
	mov eax,4				;sys_write
	mov ebx,1				;file descriptor std_out
	mov ecx,esp
	mov edx,1
	int 0x80

	;same as pop make esp move next 4 byte memory /32bit 
	add esp,4

	;dec counter count of digit number that got it before
	mov ecx,[counter]
	dec ecx
	mov [counter],ecx

	;compare counter to zero if same as zero mean counter at last digit
	cmp ecx,0
	jge print_number

	;sys_exit kernel
	mov eax,1
	mov ebx,0
	int 0x80