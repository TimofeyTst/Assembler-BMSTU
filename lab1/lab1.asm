   section .data; сегмент инициализированных переменных
; vall db 255
; chart dw 256
; lue3 dw -128
; v5 db 10h
;    db 100101b
; beta db 23, 23h, 0ch
; sdk db "Hello", 10
; min dw -32767
; ar dd 12345678h
; valar times 5 db 8

; val1 dw -25
; val2 dd -35
; name db "Тимофей Timofey"

; shest1 dw 2500h
; shest2 dw 0025h

; des1 dw 37
; des2 dw 9472

; dv1 dw 00100101b
; dv2 dw 0010010100000000b
val1 dw -8

F1 dw 65535
F2 dd 65535

A DW -30
B DW 21
ExitMsg db "Press Enter to Exit",10 ; выводимое сообщение9
lenExit equ $-ExitMsg; сегмент неинициализированных переменных

   section .bss
; alu resw 10
; f1 resb 5
X resd 1
InBuf resb 10 ; буфер для вводимой строки
lenIn equ $-InBuf

   section .text ; сегмент кода
   global _start
_start:
   mov AX, [val1]
   add word[F1],1
   add dword[F2],1
   mov EAX,[A] ; загрузить число A в регистр EAX
   add EAX,5
   sub EAX,[B] ; вычесть число B, результат в EAX
   mov [X],EAX ; сохранить результат в памяти
   ; write
   mov rax, 1; системная функция 1 (write)
   mov rdi, 1; дескриптор файла stdout=1
   mov rsi, ExitMsg ; адрес выводимой строки
   mov rdx, lenExit ; длина строки
   syscall; вызов системной функции
   ; read
   mov rax, 0; системная функция 0 (read)
   mov rdi, 0; дескриптор файла stdin=0
   mov rsi, InBuf; адрес вводимой строки
   mov rdx, lenIn; длина строки
   syscall; вызов системной функции
   ; exit
   mov rax, 60; системная функция 60 (exit)
   xor rdi, rdi; return code 0
   syscall; вызов системной функции