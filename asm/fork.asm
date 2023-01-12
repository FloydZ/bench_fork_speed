section .text
global  _fork
_fork:
	mov rax, 2 ; SYS_FORK Op Code
	int 0x80
	cmp rax, 0 ;If the return value is 0, we are in the child process
	jz child

parent:
	ret

child:
    call rdi    ;call first param gicen to _fork

    ;Debugging Stuff
	;mov edx,cLen ;Same...
	;mov ecx,cMsg
	;call print
	;call exit

print:
	mov     rbx,1               ;first argument: file handle (stdout)
	mov     rax,4               ;system call number (SYS_WRITE)
	int     0x80
	ret

exit:
	mov     rbx,0 ; Exit code
	mov     rax,1 ; SYS_EXIT
	int     0x80


;section .data
;	cMsg db      "Im the good child",0xa ;String to be printed by child process
;	cLen equ     $ - cMsg             ;And it's length...
