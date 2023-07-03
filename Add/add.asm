section .data:
    text db 'Hello World', 10

section .text
    global _start

_start:
    mov rax, 0x1
    mov rbx, 42
    add rbx, 19
    int 0x80