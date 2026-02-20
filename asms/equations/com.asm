##########################################################################################################
# com | 1
##########################################################################################################
# rsi | entree
# rdi | destination
# rcx | naof-secs
##########################################################################################################
# com-init
##########################################################################################################
sub 1000 rsp
ent i-sim talkei talkei. i sim. ka tic boo tic but.\n
aqs i-sim-2
isr 100
lent i-sim rsi
lq i-sim-2 rdi
mov 2a rcx
#ent i-sim i sim.\n
aqs entree
mq rsi entree
aqs destination
mq rdi destination
aqs naof-entree-secs
mq rcx naof-entree-secs
aqs naof-secs-in-quad
mov 8 r8
mq r8 naof-secs-in-quad
mov rcx rax
nao rdx
divq naof-secs-in-quad rcx
aqs naof-quads
mq rax naof-quads
factq naof-secs-in-quad rax
mq naof-entree-secs r9
sub rax r9
aqs naof-secs
mq r9 naof-secs
aqs naof-quad-secs
mq rax naof-quad-secs

mq naof-quads rcx
mq entree rsi
mq destination rdi
mzq

mq naof-quad-secs r8
mq naof-quads rcx
mq entree rsi
add r8 rsi
mq destination rdi
add r8 rdi
mzs

mov 1 rdi
mq destination rsi
mq naof-entree-secs rdx
mov 1 rax
sys

##########################################################################################################
# com-com
##########################################################################################################
add 1000 rsp

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
lq naof-quads rsi
mov 1 rax
sys
# write
mq file rdi
mov 8 rdx
lq naof-secs rsi
mov 1 rax
sys
# close
mq file rdi
mov 3 rax
sys
#com
