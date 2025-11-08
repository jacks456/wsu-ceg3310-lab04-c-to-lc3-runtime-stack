.ORIG x3000

; #~#~#~#~#~#~#~#~#
; =-=-=-=-=-=-=-=-=
; INITIALIZER CODE
; # DO NOT TOUCH #
; - - - - - - - - -
LD R6, STACK_PTR ; load stack pointer
LEA R4, STATIC_STORAGE ; load global vars pointer
ADD R5, R6, #0 ; set frame pointer
; current stack pointer is sitting on main's return slot
; there are no arguments to our main function
JSR MAIN
HALT
; SETUP VARS
STACK_PTR .FILL x6000
STATIC_STORAGE
.FILL #5 ; array_size global variable
; - - - - - - - - -
; INITIALIZER OVER
; =-=-=-=-=-=-=-=-=
; #~#~#~#~#~#~#~#~#


; #~#~#~#~#~#~#~#~#
; =-=-=-=-=-=-=-=-=
MAIN;(void)

; push return address
ADD R6, R6, #-1
STR R7, R6, #0

; push previous frame pointer
ADD R6, R6, #-1
STR R5, R6, #0

; set current frame pointer
ADD R5, R6, #0

; allocate local variables
; - - - - - - - - -
; #-1: total
; #-2: array[4]
; #-3: array[3]
; #-4: array[2]
; #-5: array[1]
; #-6: array[0]
; - - - - - - - - -
ADD R6, R6, #-6 ; create 6 spaces on the stack (uninitialized)
; =-=-=-=-=-=-=-=-=

; CODE GOES HERE
LD R0, ARRAY_0
STR R0, R5, #-6
LD R0, ARRAY_1
STR R0, R5, #-5
LD R0, ARRAY_2
STR R0, R5, #-4
LD R0, ARRAY_3
STR R0, R5, #-3
LD R0, ARRAY_4
STR R0, R5, #-2

ADD R0, R5, #-6
ADD R6, R6, #-1
STR R0, R6, #0

LDR R0, R4, #0
ADD R6, R6, #-1
STR R0, R6, #0

JSR SUMOFSQUARES

ADD R6, R6, #2

STR R0, R5, #-1

; =-=-=-=-=-=-=-=-=
; deallocate local variables
ADD R6, R6, #6

; restore and pop previous frame pointer
LDR R5, R6, #0
ADD R6, R6, #1

; restore and pop return address
LDR R7, R6, #0
ADD R6, R6, #1

; return to caller
RET
; =-=-=-=-=-=-=-=-=
ARRAY_0 .FILL #2
ARRAY_1 .FILL #3
ARRAY_2 .FILL #5
ARRAY_3 .FILL #0
ARRAY_4 .FILL #1
; #~#~#~#~#~#~#~#~#



; #~#~#~#~#~#~#~#~#
; =-=-=-=-=-=-=-=-=
SUMOFSQUARES;(int* array, int size)

; push return address
ADD R6, R6, #-1
STR R7, R6, #0

; push previous frame pointer
ADD R6, R6, #-1
STR R5, R6, #0

; set current frame pointer
ADD R5, R6, #0

; allocate local variables
; - - - - - - - - -
; #-1: counter
; #-2: sum
; - - - - - - - - -
ADD R6, R6, #-2 ; create 2 spaces on the stack (uninitialized)
; =-=-=-=-=-=-=-=-=

; CODE GOES HERE

AND R0, R0, #0
STR R0, R5, #-1
STR R0, R5, #-2

SUM_LOOP
; counter < size
LDR R0, R5, #-1
LDR R1, R5, #2
NOT R1, R1
ADD R1, R1, #1
ADD R0, R0, R1
BRzp SUM_END

LDR R0, R5, #3
LDR R1, R5, #-1
ADD R0, R0, R1
LDR R0, R0, #0

ADD R6, R6, #-1
STR R0, R6, #0
JSR SQUARE
ADD R6, R6, #1

LDR R1, R5, #-2
ADD R0, R0, R1
STR R0, R5, #-2

LDR R0, R5, #-1
ADD R0, R0, #1
STR R0, R5, #-1
 
BR SUM_LOOP
SUM_END

LDR R0, R5, #-2

; =-=-=-=-=-=-=-=-=
; deallocate local variables
ADD R6, R6, #2

; restore and pop previous frame pointer
LDR R5, R6, #0
ADD R6, R6, #1

; restore and pop return address
LDR R7, R6, #0
ADD R6, R6, #1

; return to caller
RET
; =-=-=-=-=-=-=-=-=
; #~#~#~#~#~#~#~#~#



; #~#~#~#~#~#~#~#~#
; =-=-=-=-=-=-=-=-=
SQUARE;(int num)

; push return address
ADD R6, R6, #-1
STR R7, R6, #0

; push previous frame pointer
ADD R6, R6, #-1
STR R5, R6, #0

; set current frame pointer
ADD R5, R6, #0

; allocate local variables
; - - - - - - - - -
; #-1: product
; - - - - - - - - -
ADD R6, R6, #-1 ; create 1 space on the stack (uninitialized)
; =-=-=-=-=-=-=-=-=

AND R0, R0, #0
LDR R1, R5, #2

ADD R2, R1, #0

MULT_LOOP
ADD R2, R2, #0
BRz MULT_END
ADD R0, R0, R1
ADD R2, R2, #-1
BR MULT_LOOP

MULT_END

; =-=-=-=-=-=-=-=-=
; deallocate local variables
ADD R6, R6, #1

; restore and pop previous frame pointer
LDR R5, R6, #0
ADD R6, R6, #1

; restore and pop return address
LDR R7, R6, #0
ADD R6, R6, #1

; return to caller
RET
; =-=-=-=-=-=-=-=-=
; #~#~#~#~#~#~#~#~#

.END