##########################################################################################################
# com
##########################################################################################################
##########################################################################################################
# com-init
##########################################################################################################
sub 1000 rsp

aqs time-0
nao r8
mq r8 time-0
aqs time-1
mov aed r8
mq r8 time-1
s task-init
lq time-0 rdi
lq time-0 rsi
mov 23 rax
sys
st jmp task-init
s task-com

##########################################################################################################
# com-com
##########################################################################################################
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
mq naof-secs rdx
mq entree rsi
mov 1 rax
sys
# close
mq file rdi
mov 3 rax
sys
#com
