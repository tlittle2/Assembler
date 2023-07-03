; FIRST ASM PROGRAM 6/30/22
; to find the instructions used on this system, look at /usr/include/unistd.h

;this specifies where we are starting from
global _start

;  .text is where the actual code logic starts
section .text:
    

    _start:
        ; specify a register that you want to perform something on
        ; the sys call that will do a "write" functionality (using hexadecimal)
            ; on this machine, the write syscall/instruction is 64 (0x40 in hex)
            ; with any instruction you give, you also need to specify the parameters associated with that syscall/instruction
        mov rax, 0x4        ; write syscall 64 into register rax (write command)
            mov rbx, 1           ; 1 = stdout. use stdout as the first operand for the write command and put into ebx 
            mov rcx, message     ; use our message as the buffer
            mov rdx, message_len ; supply the length
        int 0x80             ; invoke the syscall


        mov rax, 0x1
            mov rbx, 0
        int 0x80


; .data is where all of the variables will be stored (changing data) 
section .data:
    ;db = define bytes 
    ;0xa = \n
    message: db "Hello World" , 0xa
    message_len: equ $-message
