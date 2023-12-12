These are some test routines used to test some features
To run a test routine, use the include directive to include a "test.s" file into "main.s" file, and add the instruction "b _teststart" after the "_main" label.
It's also recommended to add an ".align 4" directive right before including the test file.
Only one test file may be included at a time. Including multiple test files will result in assembler errors or unexpected behavior.

