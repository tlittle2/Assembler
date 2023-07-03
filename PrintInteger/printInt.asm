;Approach

;Say our value is 123

; 123 / 10 = 12 R 3 -> store the 3
; 12 / 10 = 1 R 2 -> store the 2
; 1 / 10 = 0 R 1 -> AN ANSWER OF VALUE 0 IS OUR EXIT CONDITION


section .bss ; use .bss for variables that you know will stay constant and not change it value
    digitSpace resb 100 ; reserve 100 bytes of space. This is where we will store the string
    digitSpacePos resb 8 ; reserve 8 bytes (64 bits) so that we are able to print the entire of value of 1 register

section .text:
    global _start:
    _start:
        mov rax, 69420
        call _printRAX

        mov rax, 60
        mov rdi, 0
        syscall

    ; we want to break down the integer backward, and have a new line character at the end
        ; the end will then become the beginning
    _printRAX:
        mov rcx, digitSpace ; start at the actual beginning of the integer
        mov rbx, 10 ; create a new line character and put it into rbx
        mov [rcx], rbx ; move a new line character to the end of the integer
        inc rcx ; increment the position of digitSpace
        mov [digitSpacePos], rcx ; put the position of digit space into the memory pointer associated with digitSpacePos
    

    ; This will get each digit place backwards, stopping at the actual beginning (if the value is 123, it will start at 3 and end at 1)
    _printRAXLoop:
        mov rdx, 0
        mov rbx, 10
        div rbx ; divide the character that is currently in rax by the value currently in rbx (10)
        push rax ; push the new value that is in rax onto the stack (123 / 10 = *12*)
        add rdx, 48 ; add any remainders to 48 (which is the ascii code for 0) in order to convert it into a character
        
        mov rcx, [digitSpacePos] ; increment our digitSpacePos
        mov [rcx], dl ; load into the rcx the value associated with the lower half of rdx (which contains the character
                        ; equivalent of the remainder)

        inc rcx
        mov [digitSpacePos], rcx

        pop rax ; pop rax off the stack so that we can compare it against something in the next step
        cmp rax, 0; check if the value in rax = 0
        jne _printRAXLoop ; if the value in rax is not equal to 0, we will start the _printLoop subroutine again



    _printRAXLoop2:
        mov rcx, [digitSpacePos] ; use this as a way of checking how many digits are in the integer 
        
        mov rax, 0x1 ; call the write syscall
            mov rdi, 1 ; use stdout as the file descriptor
            mov rsi, rcx ; use the value of rcx as the buffer
            mov rdx, 1 ; supply the message length? 
            syscall

        mov rcx, [digitSpacePos] ; move which digits place we are currently at into the rcx register
        dec rcx ; decrement how many value we have left to print out
        mov [digitSpacePos], rcx ; move the 

        cmp rcx, digitSpace ; compare if the value at rcx is equal to 
        jge _printRAXLoop2 ; if the value in rcx is greater than our digitSpace, call the subroutine again because we haven't reached the end

        ret 