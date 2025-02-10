# Implementation of FromBase10 function (milestone 2).

# Make the function visible to all assembled files.
.globl FromBase10

.text

# Returns the representation of a base 10 source number in a specified base between 2 and 36 (inclusive).
# Args:
#   $a0: base 10 whole number
#   $a1: target number base (1 < $a1 < 37)
#   $a2: address where the target number asciiz should be stored.
# Return value:
#   $v0: 0 on success, -1 on invalid args
FromBase10:
# TODO: replace the following lines with an implementation of the function

# Validate target base.
li      $t0, 1
ble     $a1, $t0, invalid_args
li      $t0, 37
bge     $a1, $t0, invalid_args

doWhileLoop:
#Divide
div $a0, $a1
mfhi $t0 # remainder
mflo $a0 # quotient

bgeu $t0, 10, remainder_at_least_ten
addi $t0, $t0, '0'
j got_character
remainder_at_least_ten:
subi $t0, $t0, 10
addi $t0, $t0, 'a'
got_character:
sb $t0, 0($a2) # store the remainder in the address
add $a2, $a2, 1
beqz $a0, end_loop # repeat this process until the quotient is zero
j doWhileLoop
end_loop:

sb $zero, 0($a2)

li $v0, 0
jr $ra

invalid_args:
# Test by running from_base10_test.asm
li $v0, -1
jr $ra
