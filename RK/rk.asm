%include "../lib64.asm"

%define STDIN 0
%define READ 0
%define STDOUT 1
%define WRITE 1
%define EXIT 60

%define ROWS 5
%define COLUMNS 5
%define ELEMENT_SIZE 4

section .data
    NewLine db 0xA
    ResultMsg db "Result:", 10
    ResultLen equ $-ResultMsg

    Space db "  "
    matrix dd 1,1,1,1,-1, 2,-2,2,-2,2, 3,3,-3,3,3, 4,4,4,4,4, 5,5,5,5,5

section .bss

    OutBuf resw 1
    lenOut equ $-OutBuf

section .text
global _start

_start:
    mov rdx, 1
    mov rax, 20
    mov rcx, ROWS
check_el:
    mov rbx, [matrix + ELEMENT_SIZE*rax]
    cmp ebx, 0
    jge next
    imul rdx, rbx
next:
    sub rax, 4
    loop check_el

    mov rax, 11
    mov [matrix + ELEMENT_SIZE * rax], edx
; end of logic

output:
    mov rax, WRITE
    mov rdi, STDOUT
    mov rsi, ResultMsg
    mov rdx, ResultLen
    syscall

    mov rcx, ROWS
    xor rbx, rbx; Обнуляем регистр
output_row:
    push rcx
    mov rcx, COLUMNS
output_column:
    push rcx
    mov rsi, OutBuf
    mov rax, [matrix + ELEMENT_SIZE * rbx]
    inc rbx
    call IntToStr64

    mov rax, WRITE; системная функция 1 (write)
    mov rdi, STDOUT; дескриптор файла stdout=1
    mov rsi, OutBuf ; адрес выводимой строки
    mov rdx, lenOut ; длина строки
    syscall; вызов системной функции

    call PrintSpace

    pop rcx
    loop output_column

    mov rax, WRITE; системная функция 1 (write)
    mov rdi, STDOUT; дескриптор файла stdout=1
    mov rsi, NewLine ; адрес выводимой строки
    mov rdx, 1 ; длина строки
    syscall; вызов системной функции

    pop rcx
    loop output_row

exit:
    xor rdi, rdi
    mov rax, EXIT
    syscall

PrintSpace:    
    mov rax, 1
    mov rdi, 1
    mov rsi, Space
    mov rdx, 1
    syscall
    ret