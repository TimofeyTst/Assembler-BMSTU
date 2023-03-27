%include "../lib64.asm"

%define STDIN 0
%define READ 0
%define STDOUT 1
%define WRITE 1
%define EXIT 60
%define WORD_COUNT 7
%define WORD_LENGTH 5

section .data
    WRONG_CHAR db "O"

    StartMsg db "Enter 7 words: "
    StartLen equ $-StartMsg
    NewLine db 0xA

    ResultMsg db "Result: "
    ResultLen equ $-ResultMsg

section .bss
    char resb 1

    OutBuf resb 41
    lenOut equ $-OutBuf

    InBuf resb 41
    lenIn equ $-InBuf


section .text
global _start

_start:
    mov rax, WRITE
    mov rdi, STDOUT
    mov rsi, StartMsg
    mov rdx, StartLen
    syscall

; OOOOO aOOOa bOOOs OadOO OOOOO asdcd asdac
read_line:
    mov rax, READ
    mov rdi, STDIN
    mov rsi, InBuf
    mov rdx, lenIn
    syscall
; logic
    lea rdi, OutBuf; Сохранять будем в буфер
    mov rcx, WORD_COUNT
check_word:
    push rcx
    xor rax, rax; Обнуляем счетчик ошибок
    mov rcx, WORD_LENGTH
    check_char:
        cmp byte[rsi], 'O'
        jne next_char
        inc rax
    next_char:
        inc rsi
        loop check_char

    inc rsi; Скипаем пробел
    cmp rax, 3; Если ошибок больше трех
    jg next_word; То скипаем слово, иначе копирование
    sub rsi, 6; Возвращаемся на 6 символов назад
    mov rcx, 6; Считаем 6 раз
    rep movsb; Скопируем слово в буфер
    add rdx, 6; Увеличиваем сдвиг текущего буфера
next_word:
    pop rcx
    loop check_word
; end logic

output:
    mov rax, WRITE; системная функция 1 (write)
    mov rdi, STDOUT; дескриптор файла stdout=1
    mov rsi, ResultMsg
    mov rdx, ResultLen ; длина строки
    syscall; вызов системной функции

    mov rax, WRITE; системная функция 1 (write)
    mov rdi, STDOUT; дескриптор файла stdout=1
    mov rsi, OutBuf ; адрес выводимой строки
    mov rdx, lenOut ; длина строки
    syscall; вызов системной функции


    mov rax, WRITE; системная функция 1 (write)
    mov rdi, STDOUT; дескриптор файла stdout=1
    mov rsi, NewLine ; адрес выводимой строки
    mov rdx, 1 ; длина строки
    syscall; вызов системной функции

exit:
    xor rdi, rdi
    mov rax, EXIT
    syscall

