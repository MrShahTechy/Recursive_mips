.data
	result_msg:	.asciiz		"Your integer factorial is \n"
	prompt_msg:	.asciiz		"Give me the integer?"
.text
	main:

		li	$v0	4
		la	$a0	prompt_msg
		syscall

		li	$v0	5
		syscall
		move	$t0	$v0

		jal	factorial

		li	$v0	4
		la	$a0	result_msg
		syscall

		li	$v0	1
		move	$a0	$v1
		syscall


	exit:
	li	$v0	10
	syscall


factorial:
	beqz 	$t0	return_one

	addi	$sp	$sp	-8
	sw	$t0	0($sp)
	sw	$ra	4($sp)


	addi	$t0	$t0	-1
	jal	factorial


	lw	$t0	0($sp)
	lw	$ra	4($sp)
	addi	$sp	$sp	+8

	mul	$v1	$t0	$v1
	jr	$ra


return_one:
	addi	$v1	$v1	1
jr $ra
