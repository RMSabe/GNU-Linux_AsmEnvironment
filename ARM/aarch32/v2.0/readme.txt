This code is a slight update of v1.0.
Instead of using the custom calling convention, it uses the "link register (lr)" and "branch link (bl)" instruction.
Instruction "bl" should be used whenever jumping to a subroutine/function.

_stacklist and _stacklist_index are still present, and can be used to store the lr register value if needed.

<description>
_stacklist and _stacklist_index: _stacklist is a memory buffer used as a "parallel stack". _stacklist_index holds the current index value of _stacklist buffer.
_stacklist_index always points to the next available space in _stacklist buffer, and therefore must be updated whenever a value is pushed in/popped out of the _stacklist buffer.

Assembler:
I used the GNU ARM Assembler to assemble the code.
I tested the code on a Raspberry Pi 3B. It might not work on other ARM architectures.

Author: Rafael Sabe
Email: rafaelmsabe@gmail.com

