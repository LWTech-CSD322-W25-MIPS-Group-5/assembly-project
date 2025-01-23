# Test cases for FromBase10 function (milestone 2).

# How to run:
#   1. In Mars > Settings enable "Assemble all files in directory" 
#   2. Implement FromBase10 in "from_base10.asm" in the same folder/directory
#   3. Use .globl directive for the ForBase10 symbol defined in "from_base10.asm" to export the symbol
#   4. Assemble and run "from_base10_test.asm" (*not* "from_base10.asm")

.data
# Test cases:
# 166 should be a6 in base 16
# 10 should be 1010 in base 2
# 46655 should be zzz in base 36
#
# The end of the test cases is denoted by sentinel values (e.g. -1 for in_numbers).
#
# TODO: feel free to add more test cases as you see fit.
in_numbers: .word 166, 10, 46655, -1
out_bases: .word 16, 2, 36, -1
out_numbers: .asciiz "a6", "1010", "zzz"

# Reserve 33 bytes for the target number asciiz from FromBase10.
# The longest target number string will be 32 long (for base 2).
# And need 1 bytes for null termination. 
result: .space 33  

# Messages.
fail: .asciiz "A test failed\n"
success: .asciiz "All tests passed\n"

.text
# Excute each test case.

li $s0, 0  # 4 * index of test case
li $s1, 0  # offset into out_numbers asciiz for test case

TestCase:
lw $a0, in_numbers($s0)  # a0: source base 10 whole number
bltz $a0, Success  # no more test cases, so terminate with success
lw $a1, out_bases($s0)  # a1: target base
la $a2, result  # a2: address where to store the asciiz target number result

# Call FromBase10
jal FromBase10

# Check result against test case expectation.
li $t0, 0  # t0: offset into result
CheckDigit:
lbu $s2, out_numbers($s1)
lbu $s3, result($t0)
bne $s2, $s3, Error  # test case failed
add $s1, $s1, 1
add $t0, $t0, 1
bnez $s2, CheckDigit

add $s0, $s0, 4
j TestCase  # loop to execute next test case

Error:
li $v0, 4
la $a0, fail
syscall
j Terminate

Success:
li $v0, 4
la $a0, success
syscall
j Terminate

Terminate:
li $v0, 10
syscall
