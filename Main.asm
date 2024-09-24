; x86_64 INTEL | WASM (x86 runtime)
; Signed, 9662e103-129a

; http://www.c-jump.com/CIS77/ASM/Instructions/lecture.html
; https://identity.pub/2018/11/01/asm-blank-window.html
; https://www.plantation-productions.com/Webster/

; NASM with VS 2022 https://github.com/ShiftMediaProject/VSNASM

; +----------+--------------------------------------------------------+
; | Register | Function                                               |
; +----------+--------------------------------------------------------+
; | eax      | Accumulator for operands and results                   |
; +----------+--------------------------------------------------------+
; | ebx      | Base pointer to data in the data segment               |
; +----------+--------------------------------------------------------+
; | ecx      | Counter for loop operations                            |
; +----------+--------------------------------------------------------+
; | edx      | I/O pointers                                           |
; +----------+--------------------------------------------------------+
; | ebp      | Frame pointer - useful for stack frames                |
; +----------+--------------------------------------------------------+
; | esp      | Stack pointer - hardcoded into PUSH and POP operations |
; +----------+--------------------------------------------------------+
; | esi      | Source index - required for some array operations      |
; +----------+--------------------------------------------------------+
; | edi      | Destination index - required for some array operations |
; +----------+--------------------------------------------------------+
; | eip      | Instruction pointer                                    |
; +----------+--------------------------------------------------------+
; | eflags   | Result flags - hardcoded into conditional operations   |
; +----------+--------------------------------------------------------+

; ExitProcess code [1]: arithmetic solve

.386
.model flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib

.data
    INPUT_TYPE_MSG db "Input calculation method: [s]um, [d]ifference, [p]roduct, [q]uotient, or s[o]lve: ", 0
    INVALID_INPUT_MSG db "Invalid input!", 0Ah, 0

    I_SOL_1 db "Expression: ", 0
    I_SOL_2 db "Solve for: ", 0

    I_SUM_1 db "#1: ", 0
    I_SUM_2 db "#2: ", 0

    I_DIFF_1 db "#1: ", 0
    I_DIFF_2 db "#2: ", 0

    I_PROD_1 db "#1: ", 0
    I_PROD_2 db "#2: ", 0

    I_QUOT_1 db "#1: ", 0
    I_QUOT_2 db "#2: ", 0

    INPUT_BUFFER db 50 dup(0)
    EXPRESSION_BUFFER db 50 dup(0)
    SOLVE_FOR_BUFFER db 10 dup(0)
    CRLF db 0Dh, 0Ah, 0

.code
start:
    INVOKE StdOut, addr INPUT_TYPE_MSG
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER

    mov esi, offset INPUT_BUFFER
    mov al, [esi]
    
    cmp al, 'o'
    je EXIT_PROC
    cmp al, 's'
    je INPUT_TYPE_SUM
    cmp al, 'd'
    je EXIT_PROC
    cmp al, 'p'
    je EXIT_PROC
    cmp al, 'q'
    je EXIT_PROC
    jmp INPUT_INVAL

INPUT_INVAL:
    invoke StdOut, addr INVALID_INPUT_MSG
    jmp start

INPUT_TYPE_SUM:
    invoke StdOut, addr I_SUM_1
    invoke StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER

    mov esi, offset INPUT_BUFFER
    mov eax, [esi]
    mov DWORD PTR [input1], eax

    invoke StdOut, addr I_SUM_2
    invoke StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER

    mov esi, offset INPUT_BUFFER
    mov eax, [esi]
    mov DWORD PTR [input2], eax

    mov eax, DWORD PTR [input1]
    add eax, DWORD PTR [input2]

    ; TRY TO PRINT OUT THE OUTPUT, FROM HERE

    push 3000
    call Sleep

    ; INVOKE StdOut, addr I_SUM_1
    ; INVOKE StdOut, eax
    ; INVOKE ExitProcess, 200

EXIT_PROC:
    invoke ExitProcess, 1

.data
    input1 DWORD ?
    input2 DWORD ?

end start