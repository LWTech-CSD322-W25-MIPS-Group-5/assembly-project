# Implementation of ToBase10 function (milestone 1).

# Make the function visible to all assembled files.
.globl ToBase10

.text

# Returns the base 10 integer value for a source number in a base between 2 and 36 (inclusive).
# Args:
#   $a0: source number base (1 < base < 37)
#   $a1: address of the first letter in the null-terminated ascii string of the source whole number
#        (with possible digits '0', '1', ..., '9', 'a', 'b', ..., 'z', depending on the source base).
# Return value:
#   $v0: base 10 whole number (or -1 on invalid args)
ToBase10:
# TODO: replace the following lines with an implementation of the function
# Test by running to_base10_test.asm
li $v0, -1
jr $ra
