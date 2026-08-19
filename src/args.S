.section .text
.global _start
# -- MAIN -- #
_start:
	# Checking for file arg
	cmpl $2, (%esp)
	jl no_arg_err
	jmp open_file	
	

	jmp exit

open_file:
	# Open syscall of the first parameter
	mov $5, %eax
	mov 8(%esp), %ebx
	mov $0, %ecx
	mov $0, %edx
	int $0x80
	cmp $0, %eax
	jl file_not_found_err
	
	mov %eax, %esi
	jmp read_loop

read_loop:
	# read syscall
	mov $3, %eax
	mov %esi, %ebx		# FD saved in %esi
	lea file_buf, %ecx
	mov $512, %edx
	int $0x80

	cmp $0, %eax
	jle close_and_exit

	# write syscall
	mov %eax, %edx		# eax = n real bytes 
	mov $4, %eax
	mov $1, %ebx
	lea file_buf, %ecx
	int $0x80

	jmp read_loop
close_and_exit:
	# syscall close
	mov $6, %eax
	mov %esi, %ebx
	int $0x80
	jmp exit

exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80

# -- ERRORS AND USAGE -- #

no_arg_err:
	# prints erorr message
	mov $4, %eax	
	mov $1, %ebx
	lea no_arg_err_msg, %ecx
	mov $no_arg_err_msg_len, %edx	
	int $0x80
	jmp print_usage

print_usage:
	# prints the usage
	mov $4, %eax	
	mov $1, %ebx
	lea usage, %ecx
	mov $usage_len, %edx
	int $0x80
	jmp exit

file_not_found_err:
	# prints error message
	mov $4, %eax
	mov $1, %ebx
	lea file_not_found_err_msg, %ecx
	mov $file_not_found_err_msg_len, %edx
	int $0x80
	jmp exit

# -- ERR MSGS & LENGHTS -- #
.section .data
no_arg_err_msg:
	.asciz "No filename specified\n"
no_arg_err_msg_len = . - no_arg_err_msg

usage:
	.asciz "act <filename>\n"
usage_len = . - usage

file_not_found_err_msg:
	.asciz "File not found\n"
file_not_found_err_msg_len = . - file_not_found_err_msg

# -- FILE BUFFER -- #
.section .bss
file_buf:
	.skip 512
