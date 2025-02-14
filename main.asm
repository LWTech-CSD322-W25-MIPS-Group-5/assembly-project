# Main program that converts between 2 bases (milestone 3).
#
# TODO: implement the following.
#   1. Read the next source base and source number from in_bases and in_numbers respectively.
#   2. Print them.
#   3. Invoke ToBase10 to convert the source number to an intermediate base 10 number
#   4. Invoke FromBase10 to convert the intermediate base 10 number to the target base
#   5. Print the target number and target base.
#   6. Repeat until the source base is < 0.

.data

# TODO: Add as many additional cases as you see fit.
in_bases: .word 2 16 8 10 -1
in_numbers: .asciiz "101011" "2b" "2471" "42" ""
out_bases: .word 16 2 10 36 -1

.text

# TODO: implement.

li $s0, 0  # 4 * index of  test case
li $s1, 0  # offset into in_numbers asciiz for test case

# while we still have test cases
loop:

# Read source base from in_bases
lw $t0, in_bases
bltz $t0, break
move $a0, $t0
li $v0, 1
syscall

# probably add line breaks

# Read source number from in_numbers
la $t2, in_numbers($s1)  # a1: address of source number string in test case
add $t1, $t2, $zero 
li $v0, 4
move $a0, $t1
syscall

# la $t2, in_numbers($s1)  # a1: address of source number string in test case
# syscall

jal ToBase10

move $a1, $a2

jal FromBase10

j loop
break:

# Terminate
li $v0, 10
syscall
