section .text
	global _start	;must be declared for linker (ld)

_start: 
        mov ecx, msg	;message to write
        call toUpper	;call program toUpper
        call print	;call program print

        ; exit(0);
        mov eax,1	;system call number (sys_exit)
        mov ebx,0	;file error (stederr)
        int 0x80	;call kernel
        
toUpper:
        mov al,[ecx]      ; ecx is the pointer, so [ecx] the current char
        cmp al,0x0        ; compile 
        je done

        cmp al,'a'
        jb next_please          ; jmp below
        cmp al,'z'
        ja next_please

        ; uppercase
        sub al,0x20       ; move AL upper case and
        mov [ecx],al      ; write it back to string

next_please:
        inc ecx

        jmp toUpper
done:  
        ret		   ; return

print:  
        ; write(stdout, msg, len)
        mov ecx, msg	   ; message to write
        mov edx, len       ; message length
        mov ebx, 1	   ; file descriptor (stdout)
        mov eax, 4	   ; system call number (sys_write)
        int 0x80	   ; call kernel
        ret		   ; return

section .data
msg db "uppercase",0xa     ;message to be printed
len:    equ $-msg	   ;length of the string

; stdout = 1
; stdin = 0
