.data
	input_message:		.asciiz		"Tell me the Nth fibonachi number you want bb ;)\n"
	answer_message:		.asciiz		"ok , here is your number: "
.text
main:
	la	$a0	input_message
	li	$v0	4
	syscall

	li	$v0	5
	syscall

	move	$t0	$v0
	jal 	fibonachi_function

	la	$a0	answer_message
	li	$v0	4
	syscall

	move	$a0	$v1
	li	$v0	1
	syscall

exit:
li	$v0	10
syscall

fibonachi_function:
#t0 is input (n) and v1 is return value
#base_case
	beqz	$t0	base_zero
	beq	$t0	1	base_one

#saving t0 and return address
	addi	$sp	$sp	-8
	sw	$t0	0($sp)
	sw	$ra	4($sp)

#for fibonachi(n-1)
	addi	$t0	$t0	-1
	jal	fibonachi_function

#took n from stack and saved return of fibonachi(n-1)
	lw	$t0	0($sp)
	sw	$v1	0($sp)

#for fibonachi(n-2)
	addi	$t0	$t0	-2
	jal	fibonachi_function

#returning fibo(n-1) and fibo(n-2)
	lw	$t2	0($sp)
	add	$v1	$v1	$t2
	addi	$sp	$sp	+4

#loading address to return to and returning
	lw	$ra	0($sp)
	addi	$sp	$sp	+4
	jr	$ra


#base_case_return_values:
base_zero:
	li	$v1	0
	jr 	$ra

base_one:
	li	$v1	1
	jr 	$ra
