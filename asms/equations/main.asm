% equations
% views
sub 1000 rsp
aqs equations
mq r11 equations
aqs views
mq r12 views
ent segment \n
ent i-sim talkei talkei. i sim. ka tic boo tic but.\n
aqs naof-i-sim-secs
mov 2a r8
mq r8 naof-i-sim-secs
aqs i-sim-2
isr 100

lent i-sim rsi
lq i-sim-2 rdi
mq naof-i-sim-secs rcx
mq equations r11
addc equations com r11
dct r11

mov 1 rdi
lq i-sim-2 rsi
mov 2a rdx
mov 1 rax
sys

aqs naof-secs
aqs b16-entree
isr 100
mov aedaed rdi
lq b16-entree rsi
mov 10 rbx
mq equations r8
addc equations number-to-entree r8
dct r8
mq rax naof-secs

mov 1 rdi
lq b16-entree rsi
mq naof-secs rdx
mov 1 rax
sys

mov 1 rdi
lent segment rsi
mov 1 rdx
mov 1 rax
sys

aqs b16-number
ent b16-nentree aed27
lent b16-nentree rsi
mov 5 rcx
mov 10 rbx
mq equations r12
addc equations entree-to-number r12
dct r12
mq rax b16-number

aqs b16-number-entree
isr 100
mq b16-number rdi
lq b16-number-entree rsi
mov 24 rbx
mq equations r8
addc equations number-to-entree r8
dct r8
mq rax naof-secs

aqs clerical-space
isr 200
aqs clerical-space-site
mq rax clerical-space-site

lq b16-number-entree rsi
lq clerical-space rdi
mq naof-secs rcx
mq equations r11
addc equations com r11
dct r11
lq clerical-space rsi
mq clerical-space-site r8
add r8 rsi
mov a r9
mov r9 0 rsi
add 1 rsi
nao r9
mov r9 0 rsi
add 1 r8
mq r8 clerical-space-site

mov 1 rdi
lq clerical-space rsi
mq clerical-space-site rdx
mov 1 rax
sys

ent russian-breadth talkei talkei. airgo vah nah goo trim bradder.\n
aqs naof-russian-breadth-secs
lent russian-breadth rdi
mq equations r15
addc equations get-naof-secs r15
dct r15
mq rax naof-russian-breadth-secs

mov rax rdi
lq clerical-space rsi
mov 10 rbx
mq equations r11
addc equations number-to-entree r11
dct r11
mq rax clerical-space-site
lq clerical-space rsi
add rax rsi
mov a r8
movs r8 0 rsi
nao r8
add 1 rsi
movs r8 0 rsi
add 1 rax

mov 1 rdi
lq clerical-space rsi
mov rax rdx
mov 1 rax
sys

aqs grid
isr 10
lq grid rdi
nao r9
mov r9 0 rdi
mov 100 rsi
mq equations r11
addc equations naof-grid-secs r11
dct r11

ent nao-relay number
lent nao-relay rsi
mq grid rdi
#mov aedaed rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

aqs space0
isr 18
lq space0 r9
mov aedaed r8
mov r8 0 r9
mov aed r8
mov r8 8 r9
mov aedaedaed r8
mov r8 10 r9
lent nao-relay rsi
lq space0 rdi
mov 18 rcx
mov 10 rbx
mq equations rdx
mq views r11
addc views view-space r11
dct r11
#init
#com

add 1000 rsp
ret

#init
ent fn droid/clerk-com.secs
aqs file
# unlink
lent fn rdi
mov 57 rax
sys
# open-write
mov 1f8 rdx
mov 41 rsi
lent fn rdi
mov 2 rax
sys
mq rax file
# write
mq file rdi
mov 8 rdx
lq b16-number rsi
mov 1 rax
sys
# close
mq file rdi
mov 3 rax
sys
#com
