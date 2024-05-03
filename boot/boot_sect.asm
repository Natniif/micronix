; read some sectors from the boot disk using disk_read function 

[org 0x7c00]

	mov[BOOT_DRIVE], dl ; BIOS stores boot drive in DL

	mov bp, 0x8000   	; set stack safely far away
	mov sp, bp

	mov bx, 0x9000		; load 5 sectors to 0x0000(ES):0x9000(BX)
	mov dh, 5
	mov dl ,[BOOT_DRIVE]
	call disk_load

	mov dx, [0x9000] 	; print out the first loaded word, which we expect to be 0xdada, stored at addres 0x9000
	call print_hex

	mov dx, [0x9000 + 512] ; Also, print the first word from the 2nd loaded sector
	call print_hex

	jmp $

%include "boot/print.asm"
%include "boot/disk_load.asm"

BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface
