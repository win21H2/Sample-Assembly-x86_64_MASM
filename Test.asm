.386
.MODEL flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib

.data
		Sum sdword 0

.code
startTest:
		mov ecx, 10
		xor eax, eax
_label: add eax, ecx
		dec ecx
		jnz _label
		mov edx, 7
		mul edx
		push eax
		pop Sum
		cmp Sum, 147
		jz _good

_bad:	invoke ExitProcess, 400
_good:	invoke ExitProcess, 200

end startTest