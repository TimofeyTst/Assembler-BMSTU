%include "../lib64.asm"
   section .data; сегмент инициализированных переменных
r dq 5
a dq 3
q dq 9
tsrt dq "5"
   section .bss
InBuf resq 10
OutBuf resq 10
lenIn equ $-InBuf
A resq 1
S resq 1
   section .text ; сегмент кода
   global _start
_start:

   ; mov RSI, InBuf
   mov RSI, tsrt
   call StrToInt64; Вход: ESI Выход: EAX, EBX содержит 0 if errors = 0
   cmp EBX, 0
   mov [S], RAX

   ; cwde
   ; mov RBX, [q]
   ; idiv RBX
   ; cwde
   ; mov RBX, RAX; Сохранили третий рез-т в BX
   ; mov RAX, [a]
   ; mov RDX, [q]
   ; imul RDX
   ; mov RDX, 2
   ; imul RDX
   ; sub RBX, RAX
   ; mov RAX, [r]
   ; imul RAX
   ; add RAX, RBX
   ; mov [S], RAX; Success!

   mov RSI, OutBuf
   mov RAX, [S]
   cwde
   call IntToStr64

   mov rax, 60; системная функция 60 (exit)
   xor rdi, rdi; return code 0
   syscall; вызов системной функции
