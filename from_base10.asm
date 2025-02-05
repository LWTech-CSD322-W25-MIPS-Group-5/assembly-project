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
div $s0, $a0, $a1 
#Divide
div $s0, $a0, $a1 
mflo $s1 # remainder
mfhi $s3 # quotient
move $s3, $s0 # update the number
sb $s1, $a2 # store the remainder in the address
beqz $s0, doWhileLoop # repeat this process until the quotient is zero



invalid_args:
li      $v0, -1
return:
jr      $v0, 0

# Test by running from_base10_test.asm
li $v0, -1
jr $ra
