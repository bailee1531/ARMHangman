@ This program will utilize arrays in ARM Assembly to create a two player hangman game
.text
.global scanf
.global printf
.global main

main:
ldr r0, =p1Prompt
bl printf                   @ Outputs prompt message asking player 1 to type in a 4 letter word

ldr r0, =strInputPattern    @ Prepares to read a string
ldr r1, =strInput
bl scanf
ldr r1, =strInput           @ Loads string input by player 1 into r1

mov r9, r1                  @ Moves string into r9 to not get overwritten

ldr r5, =char1              @ Loads address of char1 into r5
ldr r6, =char2              @ Loads address of char2 into r6
ldr r7, =char3              @ Loads address of char3 into r7
ldr r8, =char4              @ Loads address of char4 into r8

ldrb r5, [r1]               @ Loads the first char into r5
ldrb r6, [r1, #1]           @ Shifts to char 2, loads it into r6
ldrb r7, [r1, #2]           @ Shifts to char 3, loads it into r7
ldrb r8, [r1, #3]           @ Shifts to char 4, loads it into r8

mov r4, #0                  @ Loop counter
loop:
cmp r4, #4                  @ Compares loop counter with 4 correct char guesses to decide if it should continue or not
beq completed               @ If 4 iterations have been done, goto completed section

ldr r0, =p2Prompt           
bl printf                   @ Prompts player 2 to guess a letter

ldr r0, =charInputPattern   @ Prepares to load the char guess into the register
ldr r1, =charInput
bl scanf
ldr r1, =charInput          @ Loads char input into r1
ldr r1, [r1]                @ Loads address of r1 into r1

cmp r1, r5                  @ Compares player 2's guess with first letter of player 1's word
beq correct                 @ If the chars match, goto correct section

cmp r1, r6                  @ Compares player 2's guess with second letter of player 1's word
beq correct                 @ If the chars match, goto correct section

cmp r1, r7                  @ Compares player 2's guess with third letter of player 1's word
beq correct                 @ If the chars match, goto correct section

cmp r1, r8                  @ Compares player 2's guess with fourth letter of player 1's word
beq correct                 @ If the chars match, goto correct section

ldr r0, =incorrectStr        
bl printf                   @ If none of the chars match, print a string telling player 2 to try again

b loop                      @ Start back at the top of the loop


@@@@@@@@
correct:
@@@@@@@@
add r4, r4, #1              @ Add 1 to counter in r4 for a correct guess
ldr r0, =correctStr
bl printf                   @ Output string telling player 2 their guess is correct

b loop                      @ Return to loop to determine if they still have more letters to guess

@@@@@@@@@@
completed:
@@@@@@@@@@
ldr r0, =completedStr
bl printf                   @ Once player 2 has guessed the word correctly, output a string saying they have completed the word

ldr r0, =strOut
mov r1, r9
bl printf                   @ Print full word

b exit                      @ Goto exit section

@@@@@
exit:
@@@@@
mov r7, #0x01
svc 0                       @ System call to exit the program


.data

.balign 4
p1Prompt: .asciz "Player 1: Enter a 4 letter word\n"

.balign 4
p2Prompt: .asciz "Player 2: Enter your guess\n"

.balign 4
correctStr: .asciz "Correct!\n"

.balign 4
incorrectStr: .asciz "Incorrect\n"

.balign 4
completedStr: .asciz "Word completed!\n"

.balign 4
strOut: .asciz "%s\n"

.balign 4
strInputPattern: .asciz "%s"

.balign 4
charInputPattern: .asciz " %c"

.balign 4
strInput: .asciz "    "

.balign 4
charInput: .word 0

.balign 4
char1: .byte 1

.balign 4
char2: .byte 1

.balign 4
char3: .byte 1

.balign 4
char4: .byte 1
