This code uses a custom calling convention.

RETURN_MARGIN_CALLER and RETURN_MARGIN_CALLEE: These values are used by caller and callee functions respectivelly.
They are used as a "landing area" when returning from a callee subroutine/function to a caller routine/function.
They are used to prevent repeating/skipping instructions when returning from the callee subroutine to the caller routine.

_stacklist and _stacklist_index: _stacklist is a memory buffer used as a "parallel stack". _stacklist_index holds the current index value of _stacklist.
_stacklist_index always points to the next available space in _stacklist buffer, therefore, the value in _stacklist_index should always be updated whenever pushing/popping a value from _stacklist.

Assembler:
I used the GNU ARM Assembler to assemble this code
I tested this code on Raspberry Pi 3B. It might not work in other ARM architectures.

Author: Rafael Sabe
Email: rafaelmsabe@gmail.com

