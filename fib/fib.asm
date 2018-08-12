# Name : Nehal Patel

#Values:
	# n = $t0
	# return = $v0
	# fib(n) = $s0
##########################
.data
userInputPrompt: .asciiz "\n\nPlease enter an integer between 1-46: "
outputPrompt: .asciiz "\nfibonacci(n) is: "
endMessage: .asciiz "\nHave a wonderful day :)"


.text

main:
	li $v0, 4 #code to print string
	la $a0, userInputPrompt # userInputPrompt --> $a0
	syscall #print userInputPrompt
	
	li $v0, 5 #code for input integer
	syscall #user enters integer
	
	la $t0, ($v0) # Move the user's int to $t0
	
	#Conditionals
	ble $t0, 0, end #If user entered integer is <= 0
	bgt $t0, 46, end #If user entered integer is greather than 46
	
	#fib()
	jal baseCase
	
	move $s0, $v0 #Save the calculated fib(n)
	
	# Print output prompt
	li   $v0, 4, #code to print string
	la   $a0, outputPrompt #load outputPrompt
	syscall # output outputPrompt
	
	#print fib value
	li   $v0, 1 #code to print int
	move $a0, $s0 #load fib(n) into $a0
	syscall #print fib(n)
	
	b main #Rerun the program

baseCase:
	#if( n <= 1) => return
	sle $t7, $t0, 1 #if TRUE
	beq $t7, 1, return #return

	#else => fib
	b  fibonacci 
	
fibonacci:
	addi $sp, $sp, -16 #Allocates a stack frame of 16 bytes
	
	############# The stack ###################
	sw  $ra, 0($sp) # Save the return address
	sw  $t0, 4($sp) # Save (n)
	#The return value of fibonacci(n-1) in 8($sp)
	#The return value of fibonacci(n-2) in 12($sp)
	###########################################
	
	#Fib(n - 1)
	addi $t0, $t0, -1 # (n-1)
	jal baseCase # **The recursive call** now performed with (n-1) value
	sw $v0, 8($sp) # Save the return value of fibonacci(n-1)
	lw $t0, 4($sp) # Restore n for next recursive call
	
	#Fib(n - 2)
	addi $t0, $t0, -2 #  (n-2)
	jal baseCase # **The recursive call** now performed with (n-2) value
	sw $v0, 12($sp) # Save the return value of fibonacci(n-2)
	
	#Return fib(n-1) + fib(n-2)
	lw $t1, 8($sp) # $t1 = fib(n-1)
	lw $t2, 12($sp)# $t2 = fib(n-2)
	add $v0, $t1, $t2 # Return value = $t1 + $t2
	
	#Restore stack
	lw $ra, 0($sp) #load the return address to go back to main
	addi $sp, $sp, 16 #Deallocate the stack
	
	jr $ra # Return back to the main
	
return:
	move $v0, $t0 # When n <= 1, move it into $v0
	jr $ra # 'Pop' the stack (returns back to caller)

end:
	li $v0, 4 #code to print string
	la $a0, endMessage # endMessage --> $a0
	syscall #print endMessage
		
	li $v0, 10 #code to terminate
	syscall # end program
