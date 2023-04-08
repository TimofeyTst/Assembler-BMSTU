%include "../lib64.asm"

%define STDIN 0
%define READ 0
%define STDOUT 1
%define WRITE 1
%define EXIT 60

section .bss
    result resb 256

section .text
    extern print_result
    global remove_duplicates

remove_duplicates:
    push rcx;
    push rdx;
    push rbx;

; rax = char* str удалим
; rsi = char* str 
; rdi = strlen(str) удалим 
    mov rbx, rdi; rbx = strlen(str) 
    xor rcx, rcx; Обнуляем rcx, в качестве i
    xor rax, rax; Обнуляем rax, в качестве j
; rdx временный
    lea rdi, result; Результат помеащаем в rdi

while_i_lower_len:
    cmp rcx, rbx
    jge end_while; если i >= len то заканчиваем цикл
    push rcx

    mov dl, byte[rsi + 1]
    cmp [rsi], dl
    mov rcx, 0
    je check_posled
    mov rcx, 1
    movsb
    jmp next

check_posled:
    mov dl, byte[rsi + rcx + 1]
    cmp [rsi + rcx], dl
    jne check_hash
    inc rcx
    jmp check_posled
check_hash:
    cmp byte[rsi + rcx + 1], '#'
    je skip_posled; если последовательность завершилась #, то скипаем ее
    movsb; иначе копируем всю предыдущую последовательность
    jmp next

skip_posled:
    add rsi, rcx
    add rsi, 2  
    jmp next

next:
    pop rcx
    inc rcx
    jmp while_i_lower_len


end_while:
    pop rcx;
    pop rdx;
    pop rbx;
    ; lea rax, result
    lea rdi, result
    call print_result
    ret
