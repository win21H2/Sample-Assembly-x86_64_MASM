; x86_64 with WASM compiler

.386 ; sets the processor to anything newer than a 386 processor
.model flat,stdcall
.stack 4096 ; allocates 4096 bytes to the program stack
ExitProcess PROTO, dwExitCode:DWORD

.data

sum DWORD ?

.code 
main proc
	mov eax, 7 ; sets address eax to '7'
	add eax, 4 ; adds '4' to the address in eax
	mov sum, eax ; moves the contents of the address eax into the address 'sum'

	invoke ExitProcess, 0 ; invokes the end of the program

main endp
end main