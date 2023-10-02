I initially tried to use the GNU Assembler (GAS) to assemble the code, but for some reason it didn't work. (At some point, the executable would cause segmentation fault).
So, I decided to use the NASM assembler to assemble the code, and surprisingly, it worked perfectly.

To build the executable:

run nasm assembler to assemble main file "nasm main.asm -f (format) -o main.o" (format -> "elf32" (32 bits) or "elf64" (64 bits))
then run linker to create final executable "ld main.o -o run.elf"
OR
just run the build.sh file I left in the sources, which does the same thing.
