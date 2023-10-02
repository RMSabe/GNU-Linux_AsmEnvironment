# GNU-Linux_AsmEnvironment

A basic assembly environment for GNU-Linux systems. This project is meant for didactic purpose, it's not intended for any professional applications.
It was based on my other project "PCx86_baremetal".

A few important things to know about the code:

1. Constant definitions "RETURN_MARGIN_CALLEE" and "RETURN_MARGIN_CALLER": These definitions are used by the callee and caller routines respectively, and they behave as a "landing area" for when returning from the callee routine to the caller routine. Its main purpose is to avoid either repeating previous instructions or skipping following instructions when jumping back from callee to caller.
  
2. Variables "_stacklist" and "_stacklist_index": "_stacklist" is a memory buffer that is used as a parallel stack. "_stacklist_index" is a numeric value that points to the next available space (index) in the "_stacklist" buffer. Every time a value is pushed in/popped out of the "_stacklist" buffer, "_stacklist_index" value must be updated, otherwise the executable will probably crash.

3. Variable "_textbuf": is a memory buffer used as text buffer. It's very useful when converting numbers to strings or capturing user input.

I'm not a professional developer. I made this code just for fun. Don't expect professional performance from it.

Author: Rafael Sabe
Email: rafaelmsabe@gmail.com
