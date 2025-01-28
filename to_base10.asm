# Implementation of ToBase10 function (milestone 1).
# Test by running to_base10_test.asm

.globl ToBase10 # Make the function visible to all assembled files.

.text

# Returns the base 10 integer value for a source number in a base between 2 and 36 (inclusive).
# Args:
#   $a0: source number base (1 < base < 37)
#   $a1: address of the first letter in the null-terminated ascii string of the source whole number
#        (with possible digits '0', '1', ..., '9', 'a', 'b', ..., 'z', depending on the source base).
# Return value:
#   $v0: base 10 whole number (or -1 on invalid args)
ToBase10:

# Validate source base.
li      $t0, 1
ble     $a0, $t0, invalid_args
li      $t0, 37
bge     $a0, $t0, invalid_args

# Initialize character ranges, ends exclusive, as if source is base 36.
li      $t0, '0'
li      $t1, ':' # One past '9'
li      $t2, 'a'
li      $t3, '{' # One past 'z'

li      $t4, 10 # Target base.
move    $t5, $a1 # Address of current character.
li      $v0, 0 # Accumulator for converted number.

# Adjust the ends of the ranges to match the given source base.
sub     $t6, $t1, $t0 # Length of first character range.
bgeu    $a0, $t6, source_base_ten_or_higher
add     $t1, $a0, $t0
move    $t3, $t2 # Don't need the second range at all, so make its end = start
j       loop
source_base_ten_or_higher:
# $t3 = $a0 + 'a' - 10
sub     $t7, $t2, $t6 # Value to add to turn a number above 10 into a letter
add     $t3, $a0, $t7

loop:
lb      $t8, ($t5) # Load current character.
add     $t5, $t5, 1 # Increment character pointer.
beqz    $t8, return # Exit if at end of string.

# Multiply $v0 by the target base.
mult    $v0, $a0
mflo    $v0

# Subtract from $v0 the difference between the character and its numeric value.
bltu    $t8, $t0, digit_outside_decimal_character_range
bgeu    $t8, $t1, digit_outside_decimal_character_range
sub     $v0, $v0, $t0
j       valid_digit
digit_outside_decimal_character_range:
bltu    $t8, $t2, invalid_args
bgeu    $t8, $t3, invalid_args
sub     $v0, $v0, $t7

valid_digit:
add $v0, $v0, $t8 # Add the full ASCII value of the character.
j       loop

invalid_args:
li      $v0, -1
return:
jr      $ra
