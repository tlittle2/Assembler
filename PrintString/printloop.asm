section .data:
    msg db "This is a longer string than I have ever tried",10,0


section .text:
    global _start
    _start:
        mov rax, msg ; move the message into rax (which is often used for returning values)
        call _print  ; call the _print subroutine
        
        mov rax, 60 
        mov rdi, 0
        syscall ; execute our syscall

; input = rax as a memory pointer to a string
; output = print string currently in rax
    _print:
        push rax ; push rax onto the stack (so that we can use it later)
        mov rbx, 0 ; put the value of 0 into rbx (which is often used as the base pointer for the data section )

    _printLoop:
        inc rax ; increment to the next letter in the msg
        inc rbx ; increment the length of the string by 1
        mov cl, [rax] ; move the letter we are currently at into cl (8 bit equivalent of the rcx register)
        cmp cl, 0 ; see if the current value = 0. In this case, we are using 0 as our return string
        jne _printLoop ; if the value at this character in the string is not 0, go back to the start of the loop function

        ; Once we have gotten to our exit condition, we will execute the following code
        mov rax, 0x1 ; code to print our strings part 1
            mov rdi, 1 ; code to print our strings part 2
            pop rsi ; pop whatever value our text is off the stack
            mov rdx, rbx ; move our counter value into the rdx register
            syscall ; execute our syscall
        ret


