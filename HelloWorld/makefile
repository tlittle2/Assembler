all:
	nasm -f elf64 -o HelloWorld.o HelloWorld.asm
	ld -m elf_x86_64 HelloWorld.o -o HelloWorld


clean:
	rm -f *.o HelloWorld
