This code uses a custom calling convention:

RETURN_MARGIN_CALLEE and RETURN_MARGIN_CALLER: These values are used by the callee and caller functions respectivelly.
They are used as a "landing area" for when returning from callee subroutine/function to the caller routine/function.
They are used to prevent repeating/skipping instructions in the caller routine when returning from the callee subroutine.

_stacklist and _stacklist_index: _stacklist is a memory buffer used as a "parallel stack". _stacklist_index holds the current index value of the _stacklist buffer.
_stacklist_index always points to the next available space in the _stacklist buffer, therefore it must be updated whenever pushing/popping a value from _stacklist.

Assembler instructions:
I used the NASM assembler to assemble the code.
Run "nasm main.asm -f elf32 -o main.o" to generate object file.
Run "ld main.o -o run.elf" to generate executable file.

Author: Rafael Sabe
Email: rafaelmsabe@gmail.com

