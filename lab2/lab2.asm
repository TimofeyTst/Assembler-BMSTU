%include "../lib64.asm"
   section .data; сегмент инициализированных переменных
      Hello1Msg dq "Input r: "
      lenHello1 equ $-Hello1Msg
      Hello2Msg dq "Input a: "
      lenHello2 equ $-Hello2Msg
      Hello3Msg dq "Input q: "
      lenHello3 equ $-Hello3Msg

      ResMsg dq "Result: "
      lenRes equ $-ResMsg

   section .bss
      InBuf resq 10
      lenIn equ $-InBuf
      OutBuf resq 10
      lenOut equ $-OutBuf
      r resq 1
      a resq 1
      q resq 1
      S resq 1

   section .text ; сегмент кода
      global _start


_start:
; input
   ; Output r
      mov rax, 1; системная функция 1 (write)
      mov rdi, 1; дескриптор файла stdout=1
      mov rsi, Hello1Msg ; адрес выводимой строки
      mov rdx, lenHello1 ; длина строки
      syscall; вызов системной функции
   ;end

   ; read data to InBuf
      mov rax, 0; системная функция 0 (read)
      mov rdi, 0 ; дескриптор файла stdout=0
      lea rsi, InBuf ; передаем указатель на буфер
      mov rdx, lenIn ; длина строки
      syscall
   ; end

   ; InBuf To string
      mov RSI, InBuf
      call StrToInt64; Вход: ESI Выход: EAX, EBX содержит 0 if errors = 0
      cmp EBX, 0
      mov [r], RAX
   ; end

   ; Output a
      mov rax, 1; системная функция 1 (write)
      mov rdi, 1; дескриптор файла stdout=1
      mov rsi, Hello2Msg ; адрес выводимой строки
      mov rdx, lenHello2 ; длина строки
      syscall; вызов системной функции
   ;end

   ; read data to InBuf
      mov rax, 0; системная функция 0 (read)
      mov rdi, 0 ; дескриптор файла stdout=0
      lea rsi, InBuf ; передаем указатель на буфер
      mov rdx, lenIn ; длина строки
      syscall
   ; end

   ; InBuf To string
      mov RSI, InBuf
      call StrToInt64; Вход: ESI Выход: EAX, EBX содержит 0 if errors = 0
      cmp EBX, 0
      mov [a], RAX
   ; end

   ; Output q
      mov rax, 1; системная функция 1 (write)
      mov rdi, 1; дескриптор файла stdout=1
      mov rsi, Hello3Msg ; адрес выводимой строки
      mov rdx, lenHello3 ; длина строки
      syscall; вызов системной функции
   ;end

   ; read data to InBuf
      mov rax, 0; системная функция 0 (read)
      mov rdi, 0 ; дескриптор файла stdout=0
      lea rsi, InBuf ; передаем указатель на буфер
      mov rdx, lenIn ; длина строки
      syscall
   ; end

   ; InBuf To string
      mov RSI, InBuf
      call StrToInt64; Вход: ESI Выход: EAX, EBX содержит 0 if errors = 0
      cmp EBX, 0
      mov [q], RAX
   ; end
; end


; Count result
   mov RAX, [a]
   imul rax
   mov RBX, [a]
   imul rbx
   cwde
   mov RBX, [q]
   idiv RBX
   cwde
   mov RBX, RAX; Сохранили третий рез-т в BX
   mov RAX, [a]
   mov RDX, [q]
   imul RDX
   mov RDX, 2
   imul RDX
   sub RBX, RAX
   mov RAX, [r]
   imul RAX
   add RAX, RBX
   mov [S], RAX; Success!
; end

; Result to string
   mov rsi, OutBuf
   mov rax, [S]
   cwde
   call IntToStr64
; end

; Output
   mov rax, 1; системная функция 1 (write)
   mov rdi, 1; дескриптор файла stdout=1
   mov rsi, ResMsg ; адрес выводимой строки
   mov rdx, lenRes ; длина строки
   syscall; вызов системной функции

   mov rax, 1; системная функция 1 (write)
   mov rdi, 1; дескриптор файла stdout=1
   mov rsi, OutBuf ; адрес выводимой строки
   mov rdx, lenOut ; длина строки
   syscall; вызов системной функции
;end

; close program
   mov rax, 60; системная функция 60 (exit)
   xor rdi, rdi; return code 0
   syscall; вызов системной функции
; end

