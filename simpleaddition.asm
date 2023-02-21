segment .data

   msg1 db "Enter a digit ", 0xA,0xD
   len1 equ $- msg1 ;length of the string

   msg2 db "Please enter a second digit", 0xA,0xD
   len2 equ $- msg2 ;length of the string

   msg3 db "The sum is: "
   len3 equ $- msg3 ;length of the string
   ;data byte: allocate some space, and fill it with a string

segment .bss
   num1 resb 2	    ;(reverse byte)
   num2 resb 2	    ;(reverse byte)
   res resb 1	    ;(reverse byte) declare uninitialised storage space

section	.text
   global _start    ;must be declared for using gcc

_start:             ;tell linker entry point
   mov eax, 4	    ;system call number (sys_write)
   mov ebx, 1	    ;file descriptor (stdout)
   mov ecx, msg1    ;message to write
   mov edx, len1    ;message length
   int 0x80	    ;call kernel

   mov eax, 3	    ;sys_read
   mov ebx, 0	    ;stdin
   mov ecx, num1    ;write num1
   mov edx, 2	    ;message length
   int 0x80	    ;call kernel

   mov eax, 4	    ;sys_write
   mov ebx, 1	    ;stdout
   mov ecx, msg2    ;message to write
   mov edx, len2    ;message length
   int 0x80	    ;call kernel

   mov eax, 3	    ;sys_read
   mov ebx, 0	    ;stdin
   mov ecx, num2    ;write num2
   mov edx, 2	    ;message length
   int 0x80	    ;call kernel

   mov eax, 4	    ;sys_write
   mov ebx, 1	    ;stdout
   mov ecx, msg3    ;message to write
   mov edx, len3    ;message length
   int 0x80	    ;call kernel

   mov eax, [num1]
   sub eax, '0' ;eax=eax-48

   mov ebx, [num2]
   sub ebx, '0'

   ; moving the first number to eax register and second number to ebx
   ; and subtracting ascii '0' to convert it into a decimal number

   add eax, ebx	     ;add eax and ebx

   add eax, '0'	     ;add '0' to to convert the sum from decimal to ASCII

   mov [res], eax    ;storing the sum in memory location res

   mov eax, 4	     ;sys_write
   mov ebx, 1	     ;stdout
   mov ecx, res	     ;write res
   mov edx, 1	     ;message length
   int 0x80	     ;call kernel
   ; print the sum

exit:
   mov eax, 1	     ;sys_exit
   xor ebx, ebx	     ;clear register
   int 0x80	     ;call kernel
