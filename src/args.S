.section .text
.global _start
_start:
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
	push %eax # FD
	jmp read_file

read_file:
	pop %ebx # FD
	mov $3, %eax
	lea file_buf, %ecx 
	mov $512, %edx
	int $0x80
	push %eax
	jmp write_buf

write_buf:	
	pop %ebx # BYTE read
	mov $4, %eax
	lea file_buf, %ecx
	mov $512, %edx
	int $0x80
	push %eax
	cmpl $0, %eax
	jne not_equal

	jmp print_buf
	jmp exit

not_equal:
	jmp print_buf
	jmp read_file	

print_buf:
	pop %edx
	mov $4, %eax
	mov $1, %ebx
	lea file_buf, %ecx
	int $0x80	
exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80


no_arg_err:
	mov $4, %eax	
	mov $1, %ebx
	lea no_arg_err_msg, %ecx
	mov $no_arg_err_msg_len, %edx	
	int $0x80
	jmp exit

.section .data
no_arg_err_msg:
	.asciz "No filename specified\n"
no_arg_err_msg_len = . - no_arg_err_msg

.section .bss
file_buf:
	.skip 512
