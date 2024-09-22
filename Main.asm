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

; ExitProcess code [1]: regular solve method
; ExitProcess code [2]: solve function method

.386
.MODEL flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.DATA
    INPUT_MSG db "Input: [s]um, [d]ifference, [p]roduct, [q]uotient, or s[o]lve: ", 0
    INVALID_MSG db "Invalid!", 0Ah, 0
    INPUT_BUFFER db 2 dup(0)

.CODE
start:
    INVOKE StdOut, addr INPUT_MSG
    INVOKE StdIn, addr INPUT_BUFFER, sizeof INPUT_BUFFER

    MOV al, [INPUT_BUFFER]
    
    CMP al, 'o'
    JE solve
    CMP al, 's'
    JE valid
    CMP al, 'd'
    JE valid
    CMP al, 'p'
    JE valid
    CMP al, 'q'
    JE valid

invalid:
    INVOKE StdOut, addr INVALID_MSG
    JMP start

valid:
    INVOKE ExitProcess, 1

solve:
    INVOKE ExitProcess, 2

end start