; x86_64 INTEL | WASM (x86 runtime)
; Signed, 9662e103-129a

; http://www.c-jump.com/CIS77/ASM/Instructions/lecture.html

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
.MODEL flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib

.DATA
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

.CODE
start:
    INVOKE StdOut, addr INPUT_TYPE_MSG
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER

    MOV esi, offset INPUT_BUFFER
    MOV al, [esi]
    
    CMP al, 'o'
    JE INPUT_TYPE_SOL
    CMP al, 's'
    JE INPUT_TYPE_SUM
    CMP al, 'd'
    JE INPUT_TYPE_DIFF
    CMP al, 'p'
    JE INPUT_TYPE_PROD
    CMP al, 'q'
    JE INPUT_TYPE_QUOT
    JMP INPUT_INVAL

INPUT_INVAL:
    INVOKE StdOut, addr INVALID_INPUT_MSG
    JMP start

INPUT_TYPE_SOL:
    INVOKE StdOut, addr I_SOL_1
    INVOKE StdIn, addr EXPRESSION_BUFFER, sizeof EXPRESSION_BUFFER

    INVOKE StdOut, addr I_SOL_2
    INVOKE StdIn, addr SOLVE_FOR_BUFFER, sizeof SOLVE_FOR_BUFFER
    INVOKE ExitProcess, 100

INPUT_TYPE_SUM:
    INVOKE StdOut, addr I_SUM_1
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER

    INVOKE StdOut, addr I_SUM_2
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER
    INVOKE ExitProcess, 201

INPUT_TYPE_DIFF:
    INVOKE StdOut, addr I_DIFF_1
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER

    INVOKE StdOut, addr I_DIFF_2
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER
    INVOKE ExitProcess, 202

INPUT_TYPE_PROD:
    INVOKE StdOut, addr I_PROD_1
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER

    INVOKE StdOut, addr I_PROD_2
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER
    INVOKE ExitProcess, 203

INPUT_TYPE_QUOT:
    INVOKE StdOut, addr I_QUOT_1
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER

    INVOKE StdOut, addr I_QUOT_2
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER
    INVOKE ExitProcess, 204

end start