module=add
all:
	nasm -f elf64 -o ${module}.o ${module}.asm
	ld -m elf_x86_64 ${module}.o -o ${module}


clean:
	rm -f *.o ${module}
