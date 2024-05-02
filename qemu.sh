dd if=$1 of=disk_image.qcow2 bs=512 seek=1 conv=notrunc
qemu-system-x86_64 -hda disk_image.qcow2

