; Load DH sectors to ES:BX from drive DL
; Store DX on stack so later we can recall how many sectors were requested to be read

disk_load:
    push dx               ; Push DX onto the stack to save the sector count

    mov ah, 0x02          ; AH = 0x02 for BIOS Read Sector(s) function
    mov al, dh            ; AL = Number of sectors to read
    mov ch, 0x00          ; Cylinder = 0
    mov dh, 0x00          ; Head = 0
    mov cl, 0x02          ; Sector = 2 (start reading from second sector)

    int 0x13              ; BIOS interrupt for disk I/O

    jc disk_error         ; Jump if carry flag is set, indicating an error
    pop dx                ; Restore DX from the stack
    cmp dh, al            ; Compare sectors read with sectors expected
    jne disk_error        ; Jump to disk_error if not equal
    ret                   ; Return if successful

disk_error:
    mov bx, DISK_ERROR_MSG  ; Load address of the error message into BX
    call print_string       ; Call print_string to display the error message
    jmp $                   ; Infinite loop to halt execution upon error

; Variables
DISK_ERROR_MSG db "Disk read error!", 0  ; Define the error message string with null terminator
