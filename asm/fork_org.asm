section .text
global  _start
_start:
	mov eax, 2 ; SYS_FORK Op Code
	int 0x80
	cmp eax, 0 ;If the return value is 0, we are in the child process
	jz child

parent:
	mov edx, len ;Move msg length to edx
	mov ecx, msg ;Move msg to ecx
	call print ;Print
	call exit ;Exit

child:
	mov edx,cLen ;Same...
	mov ecx,cMsg
	call print
	call exit

print:
	mov     ebx,1               ;first argument: file handle (stdout)
	mov     eax,4               ;system call number (SYS_WRITE)
	int     0x80
	ret

exit:
	mov     ebx,0 ; Exit code
	mov     eax,1 ; SYS_EXIT
	int     0x80

section .data
	msg db      "I AM YOUR FATHER",0xa ;String to be printed by father process
	len equ     $ - msg             ; And it's length
	cMsg db      "Im the good child",0xa ;String to be printed by child process
	cLen equ     $ - cMsg             ;And it's length...
