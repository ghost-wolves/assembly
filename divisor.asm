; Takes two numbers and finds all positive divisors
; Auther: Sawyer Beaton
; Date: 03/02/2014
; I certify that this is my own work.

.586
.MODEL FLAT

INCLUDE io.h
.STACK 4096


.DATA

	array DWORD 1000 DUP(?)
	remainder DWORD 0
	var1 DWORD ?
	var2 DWORD ?
	prompt1 BYTE    "Enter first number", 0
	prompt2 BYTE    "Enter second number", 0
	string  BYTE    40 DUP (?)
	resultLbl BYTE "The common divisors are", 0
	answer BYTE 100 DUP(?)

.CODE
_MainProc Proc

Start:
		input   prompt1, string, 40      ; read ASCII characters
        atod    string					 ; convert to integer
        mov     var1, eax				 ; store in memory

        input   prompt2, string, 40      ; repeat for second number
        atod    string
        mov     var2, eax

		cmp var1, 1000		; check first number for above 1000 or less than 0
		jg Start
		cmp var1, 0
		jl Start

		cmp var2, 1000		; check second number, if check fails, ask for input again
		jg Start
		cmp var2, 0
		jl Start

		lea esi, array		; store memory location of array
		lea edi, answer		; store memory location of string for display

		mov ecx, 1000		; loop counter
Divide:
		mov eax, var1		; divide by first number by loop counter and check for remainder
		cdq
		idiv ecx
		mov remainder, edx
		cmp remainder, 0
		jne CountLP

		mov eax, var2		; divide second number
		cdq
		idiv ecx
		mov remainder, edx
		cmp remainder, 0
		jne CountLP

		mov [esi], ecx		; if loop counter is common divisor, add it to array
		add esi, 4			; move array memory location

CountLP:
		loop Divide

		lea esi, array		; reset array memory location to the front
		mov ecx, 100		; set counter for display loop
Display:
		mov eax, [esi]
		dtoa [edi], eax
		add edi, 12
		add esi, 4
		loop Display

		output resultLbl, answer

		mov eax, 0
		ret

_MainProc ENDP
End
