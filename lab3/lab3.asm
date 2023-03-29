%include "../lib64.asm"
   section .data; сегмент инициализированных переменных
      Hello1Msg dq "Input a: "
      lenHello1 equ $-Hello1Msg
      Hello2Msg dq "Input x: "
      lenHello2 equ $-Hello2Msg
      Hello3Msg dq "Input b: "
      lenHello3 equ $-Hello3Msg
      Hello4Msg dq "Input j: "
      lenHello4 equ $-Hello4Msg
      ErrorSTIMsg dq "Error while transform str to int", 10
      lenErrorSTI equ $-ErrorSTIMsg
      ZeroDivMsg dq "Zero Division Error", 10
      lenZeroDiv equ $-ZeroDivMsg

      ResMsg dq "Result: "
      lenRes equ $-ResMsg

   section .bss
      InBuf resq 10
      lenIn equ $-InBuf
      OutBuf resq 10
      lenOut equ $-OutBuf
      a resq 1
      x resq 1
      b resq 1
      j resq 1
      F resq 1

   section .text ; сегмент кода
      global _start

_start:
; input
   ; Input a
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
      jne .STIError
      mov [a], RAX
   ; end

   ; Input x
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
      jne .STIError
      mov [x], RAX
   ; end

   ; Input b
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
      jne .STIError
      mov [b], RAX
   ; end

   ; Input j
      mov rax, 1; системная функция 1 (write)
      mov rdi, 1; дескриптор файла stdout=1
      mov rsi, Hello4Msg ; адрес выводимой строки
      mov rdx, lenHello4 ; длина строки
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
      jne .STIError
      mov [j], RAX
   ; end
      jmp .countResult
; end

.countResult:
   mov rax, [j]
   cmp rax, 5
   jge .jtrue
   mov rax, [b]
   cmp rax, 5
   je .ZeroDivError
   mov rax, [x]
   mov rbx, [a]
   imul rbx
   mov rbx, 3
   imul rbx
   mov rbx, [b]
   sub rbx, 5
   idiv rbx
   mov [F], rax
   jmp .output

.jtrue:
   mov rax, -12
   mov [F], rax
   jmp .output

; end

.STIError:
      mov rax, 1; системная функция 1 (write)
      mov rdi, 1; дескриптор файла stdout=1
      mov rsi, ErrorSTIMsg ; адрес выводимой строки
      mov rdx, lenErrorSTI ; длина строки
      syscall; вызов системной функции
      jmp .end
   ;end

.ZeroDivError:
      mov rax, 1; системная функция 1 (write)
      mov rdi, 1; дескриптор файла stdout=1
      mov rsi, ZeroDivMsg ; адрес выводимой строки
      mov rdx, lenZeroDiv ; длина строки
      syscall; вызов системной функции
      jmp .end
   ;end

.output:
; Output
   ; Result to string
      mov rsi, OutBuf
      mov rax, [F]
      cwde
      call IntToStr64
   ; end
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
   jmp .end
;end

.end:
; close program
   mov rax, 60; системная функция 60 (exit)
   xor rdi, rdi; return code 0
   syscall; вызов системной функции
; end

