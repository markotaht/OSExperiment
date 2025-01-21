imdisk -D -m A:

set stage1Folder=BootloaderStage1
set stage2Folder=BootloaderStage2
set kernelFolder=Kernel

set stage1Src=bootloader.asm
set stage1Res=bootloader.bin

set stage2Src=Stage2.asm
set stage2Res=Stage2.sys

set kernelSrc=kernel.asm
set kernelRes=kernel.sys

set floppyName=bootloader.flp

nasm -f bin -o %stage1Folder%\%stage1Res% %stage1Folder%\%stage1Src%
cd %stage2folder%
nasm -f bin -o %stage2Res% %stage2Src%
cd..
cd %kernelFolder%
nasm -f bin -o %kernelRes% %kernelSrc%
cd..


dd if=%stage1Folder%\%stage1Res% of=%stage1Folder%\%floppyName%

imdisk -a -m A: -f %stage1Folder%\%floppyName% -s 1440K

copy %stage2Folder%\%stage2Res% A:\%stage2Res%
copy %kernelFolder%\%kernelRes% A:\%kernelRes%