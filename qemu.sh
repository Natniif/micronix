nasm boot/boot_sect.asm -f bin -o boot_sect.bin
dd if=boot_sect.bin of=disk_image.qcow2 bs=512 seek=1 conv=notrunc
qemu-system-x86_64 -hda disk_image.qcow2

