# Test cases for ToBase10 function (milestone 1).

# How to run:
#   1. In Mars > Settings enable "Assemble all files in directory"
#   2. Implement ToBase10 in "to_base10.asm" in the same folder/directory
#   3. Use .globl directive for the ToBase10 symbol defined in "to_base10.asm" to export the symbol
#   4. Assemble and run "to_base10_test.asm" (*not* "to_base10.asm")

.data
# Test cases:
# "a6" in base 16 should be 166
# "1010" in base 2 should be 10
# "zzz" in base 36 should be 46655
# "0" in base 1 should be -1
# "aa" in base 10 should be -1
# "aa" in base 11 should be 120
# "" in base 2 should be 0
# ":" in base 10 should be -1
# ":" in base 11 should be -1
# "z" in base 37 should be -1
# "{" in base 36 should be -1
# "9" in base 0x7FFFFFFE should be -1
#
# The end of the test cases is denoted by a sentinel value (i.e. -1 for in_bases).
#
# Feel free to add more test cases as you see fit.

in_bases: .word 16, 2, 36, 1, 10, 11, 2, 10, 11, 37, 36, 0x7FFFFFFF, -1
in_numbers: .asciiz "a6", "1010", "zzz", "0", "aa", "aa", "", ":", ":", "z", "{", "9"
.align 2  # align the out_numbers on a word boundary (after the asciiz data)
out_numbers: .word 166, 10, 46655, -1, -1, 120, 0, -1, -1, -1, -1, -1
fail: .asciiz "A test failed\n"
success: .asciiz "All tests passed\n"

.text
# Execute each test case.

li $s0, 0  # 4 * index of test case
li $s1, 0  # offset into in_numbers asciiz for test case

TestCase:
lw $a0, in_bases($s0)  # a0: base of source number in test case
beq $a0, -1, Success  # no more test cases, so terminate with success
la $a1, in_numbers($s1)  # a1: address of source number string in test case

# Call ToBase10
jal ToBase10

# Check result against test case expectation.
lw $s2, out_numbers($s0)
bne $v0, $s2, Error  # test case failed

# Increment $s1 to point to next test case's source number.
NextNumber:
lbu $t0, in_numbers($s1)
add $s1, $s1, 1
bnez $t0, NextNumber

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
