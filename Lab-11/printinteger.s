section .data
hex: .asciz  "0123456789abcdef"

.section .text
.global printx
.global printd

printx:
    mov     r7, lr
    mov     r5, #1


printx_start:
    mov     r1, r0
    and     r4, r1, #15
    push    {r4}
    lsr     r0, r0, #4
    cmp     r0, #0
    beq     printx_print
    add     r5, r5, #1
    b       printx_start


printx_print:
    ldr     r2, =hex
    cmp     r5, #0
    beq     exit
    sub     r5, r5, #1
    pop     {r4}
    ldrb    r0, [r2, r4]
    bl      putchar
    b       printx_print


printd:
    mov     r7, lr
    cmp     r0, #-2147483648
    beq     printd_min
    mov     r5, #0
    cmp     r0, #0
    mov     r1, r0
    beq     printd_zero
    blt     printd_conv


printd_start:
    cmp     r1, #0
    beq     printd_print
    mov     r2, #0
    sub     r2, r1, #10
    sub     r1, r1, r1, lsr #2
    add     r1, r1, r1, lsr #4
    add     r1, r1, r1, lsr #8
    add     r1, r1, r1, lsr #16
    mov     r1, r1, lsr #3
    add     r3, r1, r1, asl #2
    subs    r2, r2, r3, asl #1
    addpl   r1, r1, #1 //add if N flag                                                                                                                                                                                                                                                                                                                                      
    addmi   r2, r2, #10 //add minus if N flag                                                                                                                                                                                                                                                                                                                               
    push    {r2}
    add     r5, r5, #1
    b       printd_start

printd_print:
    cmp     r5, #0
    beq     exit
    sub     r5, r5, #1
    pop     {r0}
    add     r0, r0, #48
    bl      putchar
    b       printd_print


printd_conv:
    mov     r4, r0
    mov     r0, #45
    bl      putchar
    mov     r0, r4
    mov     r2, #-1
    neg     r0, r0
    cmp     r0, #10
    blt     printd_less
    mov     r1, r0
    b       printd_start


printd_less:
    add     r0, r0, #48
    bl      putchar
    b       exit

printd_min:
    mov     r0, #45
    bl      putchar
    mov     r0, #50
    bl      putchar
    mov     r0, #49
    bl      putchar
    mov     r0, #52
    bl      putchar
    mov     r0, #55
    bl      putchar
    mov     r0, #52
    bl      putchar
    mov     r0, #56
    bl      putchar
    mov     r0, #51
    bl      putchar
    mov     r0, #54
    bl      putchar
    mov     r0, #52
    bl      putchar
    mov     r0, #56
    bl      putchar
    b       exit


printd_zero:
    add     r0, r0, #48
    bl      putchar //print                                                                                                                                                                                                                                                                                                                                                 


exit:
    bx      r7
