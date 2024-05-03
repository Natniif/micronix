; my_print_function: 
; 	pusha 
; 	mov bx, 10
; 	moc bx, 20
; 	mov ah, 0x0e
; 	int 0x10	
; 	popa
; 	ret

print_string:
    xor bx, bx              ; Clear BX register
next_char:
    lodsb                   ; Load the next byte from the memory location pointed to by SI into AL, and increment SI
    test al, al             ; Check if AL (current character) is zero (end of string)
    jz done                ; If zero, we're done
    mov ah, 0x0E            ; Function code for teletype output in BIOS
    int 0x10                ; Call BIOS interrupt to print the character in AL
    jmp next_char          ; Repeat for the next character
done:
    ret                     ; Return from the function

print_hex: 
	pusha                   ; Push all registers onto the stack to preserve their values
	mov si, HEX_OUT         ; Load the address of HEX_OUT into SI
	call print_string      ; Call the print_string function to print the hexadecimal value
	popa                    ; Restore the values of all registers from the stack
	ret                     ; Return from the function

HEX_OUT: db '0x0000', 0    ; Define the HEX_OUT string with space for a 16-bit hexadecimal value and null terminator