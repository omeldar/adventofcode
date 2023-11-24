section	.text
   global _start     ;must be declared for linker (ld)
	
_start:	            ;tells linker entry pointc
    ;open the file for reading
    mov eax, 5              ; put the system call sys_open() number 5, in the EAX register
    mov ebx, file_name      ; put the filename into the ebx register
    mov ecx, 0              ; put the file access mode (0: read only) into the ecx register
    mov edx, 0777           ; put the file permissions into the edx register
    int  0x80

    mov  [fd_in], eax

    ;read from file
    mov eax, 3
    mov ebx, [fd_in]
    mov ecx, info
    mov edx, 26
    int 0x80

    ; close the file
    mov eax, 6
    mov ebx, [fd_in]
    int  0x80  

    ; print the file input 
    mov eax, 4
    mov ebx, 1
    mov ecx, info
    mov edx, 26
    int 0x80

    ; end program
    mov	eax,1             ;system call number (sys_exit)
    int	0x80              ;call kernel

section	.data
file_name db 'input.txt'

section .bss
fd_in  resb 1
info resb  26