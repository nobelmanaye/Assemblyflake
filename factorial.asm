;; Author: Nobel Manaye


.ORIG x3000

;; Main program register usage:
; R1 = NUMBER
; R6 = stack pointer
; R2 = temporary working register
; R0 = displaying register

;; Main program pseudocode:

; number = factorial(number)
; quotient = number // 5
; remainder = number % 5


; ======================================================================================================

; Main program

LD R6, STACKBOTTOM ; Initialize the stack pointer


LEA R0, PROMPT     ; display the prompt
PUTS


JSR GETS                ; jump to the get function

LEA R0, FACTOF         ; display the messages and number
PUTS
LEA R0, INPUTARRAY
PUTS
LEA R0, IS
PUTS


LEA R1, INPUTARRAY          ; load the inputed number into R1 so that it could be used by INT



JSR INT                     ; Convert the number in R1 to integer in R2
ST R2, NUMBER               ; store the value in R2 to number so that it could be used in ffactorial funciton 

; Run this after we've got the number input from NUMBER
LD R1, NUMBER               ; jump to the factorial function



JSR FACTORIAL               ;jump to factorial, which puts the factorial into R1, but will change it to R2 so that string could access it


LD R2,NUMBER                ; Load the number into R2 for to string


LEA R1, NUMBER
JSR TOSTRING

; Now the string is in the location in R1, load it to R0 then display
LDR R0, R1, #0
PUTS

RET

; Main program data variables
NUMBER .BLKW #1
QUOTIENT .BLKW #1
DIVISOR .FILL #5
REMAINDER .BLKW #1
STACKBOTTOM .FILL xFDFF ; Address of the bottom of the stack
PROMPT .STRINGZ "Enter a number: "
FACTOF .STRINGZ "The factorial of "
IS .STRINGZ " is  "

; ======================================================================================================

;; Subroutine FACTORIAL
;  Returns the factorial of R1 in R1
;  Input parameter: R1 (the number)
;  Output parameter: R1 (the number)
;  Working storage: R2 and R3

; Pseudocode:

; product = 1
; while n > 0
;    product *= n
;    n -= 1


FACTORIAL ADD R0, R7, #0 ; Save registers
JSR PUSH
            ADD R0, R3, #0
JSR PUSH
            ADD R0, R2, #0
JSR PUSH
LD R2, FACTONE ; Initialize the product to 1
FACTLOOP JSR MUL ; R3 = R1 * R2
ADD R2, R3, #0 ; Shift the product back to R2
ADD R1, R1, #-1 ; Decrement the number
BRp FACTLOOP
ADD R1, R2, #0 ; Shift product for return
JSR POP ; Restore registers
ADD R2, R0, #0
JSR POP ; Restore registers
ADD R3, R0, #0
JSR POP
ADD R7, R0, #0
RET

; Data for subroutine FACTORIAL
FACTONE .FILL #1

; ======================================================================================================


;; Subroutine MUL
;  Multiplies R1 by R2 and stores result in R3
;  R3 = R1 * R2
;  Input parameters: R1 and R2, both non-negative
;  Output parameter: R3

;; Pseudocode design:

; sum = 0
; while first > 0
; sum += second
; first -= 1
; return sum

MUL ADD R0, R7, #0 ; Save registers
JSR PUSH
ADD R0, R1, #0        
JSR PUSH
AND R3, R3, #0 ; Initialize sum for accumulation
        ADD R1, R1, #0  ; if first or second is 0, quit
        BRz ENDMUL
        ADD R2, R2, #0
        BRz ENDMUL
MULLOOP ADD R3, R3, R2 ; sum += second
ADD R1, R1, #-1 ; first -= 1
BRp MULLOOP ; Exit when first == 0
ENDMUL JSR POP ; Restore registers
ADD R1, R0, #0
JSR POP
ADD R7, R0, #0

RET

; ======================================================================================================


;; Subroutine DIV
;  Divides R1 by R2 and stores quotient in R3 and remainder in R4
;  R3 = R1 // R2, R4 = R1 % R2
;  Input parameters: R1 (dividend) and R2 (divisor), both positive integers
;  Output parameters: R3 (quotient) and R4 (remainder)

; Pseudocode:

; quotient = 0
; while (dividend - divisor) >= 0
;     dividend -= divisor
;     quotient += 1
; remainder = dividend

DIV ADD R0, R7, #0 ; Save registers
JSR PUSH
ADD R0, R2, #0        
JSR PUSH
ADD R0, R1, #0
        JSR PUSH
NOT R2, R2 ; Negate the divisor
ADD R2, R2, #1  
AND R3, R3, #0 ; Initialize the quotient (a counter)
DIVLOOP ADD R4, R1, R2 ; Entry test for the division loop (dividend - divisor >= 0)
BRn ENDDIV
ADD R1, R1, R2 ; dividend -= divisor
ADD R3, R3, #1 ; quotient += 1
BR DIVLOOP ; Return to the top of the loop
ENDDIV ADD R4, R1, #0 ; Set the remainder to dividend for return
JSR POP ; Restore registers
ADD R1, R0, #0
JSR POP
ADD R2, R0, #0
JSR POP
ADD R7, R0, #0
RET

; ======================================================================================================


; Subroutine GETS: inputs a string and store it in the variable INPUT

GETS 



ADD R0, R7, #0 ; Save R7
JSR PUSH
ADD R0, R1, #0 ; Save R1
JSR PUSH
ADD R0, R2, #0 ; Save R2
JSR PUSH
ADD R0, R3, #0 ; Save R3
JSR PUSH

LD R1, RT ; Initialize return character
LEA R2, INPUTARRAY  ; Get the base address of the array

WHILE GETC ; Read and echo a character (stoed in R0)
OUT
ADD R3, R0, R1 ; Quit if character = return
Brz ENDGETS
STR R0, R2, #0 ; Store that character in the array
ADD R2, R2, #1 ; Increment the address of the array cell
BR  WHILE ; Return to read another character
ENDGETS STR R3, R2, #0  ; Store the null character after the last input

JSR POP ; Restore R3
ADD R3, R0, #0
  JSR POP ; Restore R2
ADD R2, R0, #0  
JSR POP ; Restore R1
ADD R1, R0, #0
JSR POP ; Restore R7
ADD R7, R0, #0

RET

RT .FILL X-000A ; The return character (negated)
INPUTARRAY .BLKW #25


; ======================================================================================================

; Subroutine INT: Converts string to integer equivalent
;
; Input Parameter: R1 - the address of the string buffer
; Ouput Parameter: R2 - the integer represented by the string

; Register usage:
; R3 = temporary working storage
; R4 = the pointer into the string buffer

INT ADD R0, R7, #0 ; Save R7
JSR PUSH
ADD R0, R1, #0 ; Save R1
JSR PUSH
ADD R0, R3, #0 ; Save R3
JSR PUSH
ADD R0, R4, #0 ; Save R4
JSR PUSH

AND R3, R3, #0 ; Clear the sum
ST R3, INTSUM
ADD R4, R1, #0 ; Set the pointer into the buffer


INTLOOP LDR R1, R4, #0 ; Get the next digit from the buffer
BRz ENDINT ; Quit when it's null
LD R2, ORDZERO ; Convert the digit to an int
ADD R1, R1, R2
ST R1, INTDIGIT
LD R1, INTSUM ; Multiply the sum by 10
LD R2, INT10
JSR MUL
LD R1, INTDIGIT ; Add int value of digit to the sum
ADD R3, R3, R1
ST R3, INTSUM
ADD R4, R4, #1 ; Advance to the next character in the buffer
BR INTLOOP
ENDINT LD R2, INTSUM ; Set the output parameter


  JSR POP ; Restore R4
ADD R4, R0, #0  
JSR POP ; Restore R3
ADD R3, R0, #0
JSR POP ; Restore R1
ADD R1, R0, #0
JSR POP ; Restore R7
ADD R7, R0, #0



RET

; Subroutine INT data variables
INTDIGIT   .BLKW #1 ; Holds the integer value of each digit
ORDZERO .FILL  #-48     ; ASCII for the digit '0' (negated)
INT10 .FILL  #10 ; Base of 10
INTSUM .FILL  #0 ; Holds the running total for the sum





; ======================================================================================================

;; Subroutine TOSTRING


;  Converts the integer in R2 to a string with base address R1
;  Input parameters: R1 = base address of string buffer
;                    R2 = an integer
;  Output parameter: R1 = base address of the string buffer

TOSTRING  

ADD R0,R7,#0   ; save all registers
JSR PUSH
ADD R0,R4,#0
JSR PUSH
ADD R0,R3,#0
JSR PUSH
ADD R0,R2,#0
JSR PUSH

    AND R0,R0,#0
    JSR PUSH
    ADD R1,R2,#0



    ADD R1, R2, #0 ; Set the initial dividend
STRLOOP LD R2, INT10 ; Divide the number by 10
JSR DIV
LD R2, CHRZERO ; Convert the remainder and push it
ADD R0, R4, R2 ; onto the stack
          JSR PUSH
ADD R1, R3, #0 ; Set the dividend to the quotient
BRp STRLOOP ; While quotient > 0

LD R1, STRBASE ; Move characters from the stack to the
POPLOOP JSR POP ; string buffer, stopping after the null
STR R0, R1, #0 ; character is moved
ADD R0, R0, #0
BRz ENDPOP
ADD R1, R1, #1
           BR POPLOOP

ENDPOP LD R1, STRBASE ; Restore all registers

JSR POP ; Restore R4
ADD R4, R0, #0
  JSR POP ; Restore R3
ADD R3, R0, #0  
JSR POP ; Restore R2
ADD R2, R0, #0
JSR POP ; Restore R0
ADD R0, R0, #0

RET
; Subroutine TOSTRING data variables (also uses INT10 from INT)
CHRZERO .FILL  #48 ; ASCII for the digit '0'
STRBASE .BLKW  #1 ; Base address of string buffer for the sum


; ======================================================================================================


;; Runtime stack management

;; Subroutine PUSH
;  Copies R0 to the top of the stack and decrements the stack pointer
;  Input parameters: R0 (the datum) and R6 (the stack pointer)
;  Output parameter: R6 (the stack pointer)
PUSH ADD R6, R6, #-1
STR R0, R6, #0
RET

;; Subroutine POP
;  Copies the top of the stack to R0 and increments the stack pointer
;  Input parameter: R6 (the stack pointer)
;  Output parameters: R0 (the datum) R6 (the stack pointer)
POP LDR R0, R6, #0
ADD R6, R6, #1
RET

.END