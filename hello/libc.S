#    SPDX-FileCopyrightText: 2025 Brunelli <gubrunelli@hotmail.com>
#   
#    SPDX-License-Identifier: GPL-3.0-or-later
#
#  This file is a derivative of SYSeg (https://gitlab.com/monaco/syseg)
#  and includes modifications made by the following author(s):
#  Brunelli <gubrunelli@hotmail.com>

	/* Suppose we receive the argument in %cx. */

	.code16gcc
	.global printf
	.global get_memory_size
	.global int_to_str

	.section .text
	
printf:	

	mov   %cx, %bx
	
        mov   $0x0e,%ah               
        mov   $0x0, %si               
loop:                                 
        mov   (%bx, %si), %al           
        cmp   $0x0, %al               
        je    end                    
        int   $0x10                   
        add   $0x1, %si               
        jmp   loop                    
end:
        mov %si, %ax
        ret

get_memory_size:
	int $0x12		# BIOS interrupt to get memory size
	ret			# Return value is in AX (in KiB)

int_to_str:
	# Parameters are in %cx (number) and %dx (buffer)
	mov %cx, %ax    # Get the number to convert
	mov %dx, %bx    # Get the buffer address
	
	# Initialize
	push %cx        # Save number for later
	mov $0, %cx     # Counter for digits
	
	# Handle zero case
	test %ax, %ax
	jnz convert_loop
	movb $'0', (%bx)
	movb $0, 1(%bx)
	jmp done
	
convert_loop:
	# Divide by 10
	mov $0, %dx     # Clear dx for division
	mov $10, %di
	div %di         # Divide ax by 10, remainder in dx
	
	# Convert remainder to ASCII and store
	add $'0', %dl   # Convert to ASCII
	push %dx        # Save digit on stack
	inc %cx         # Increment digit counter
	
	# Continue if quotient is not zero
	test %ax, %ax
	jnz convert_loop
	
	# Now pop digits and store in buffer
store_loop:
	pop %dx
	movb %dl, (%bx)
	inc %bx
	dec %cx
	jnz store_loop
	
	# Add null terminator
	movb $0, (%bx)
	
done:
	pop %cx        # Restore original number
	ret
