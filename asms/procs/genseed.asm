##########################################################################################################
# genseed
##########################################################################################################
% equations
% views
% clerk
##########################################################################################################
# init
##########################################################################################################
sub 1000 rsp
aqs equations
mq r11 equations
aqs views
mq r12 views
aqs clerk
mq r13 clerk
aqs naof-secs
mq r14 naof-secs
aqs file-name
mq r15 file-name
aqs sret
mq rbx sret
aqs grid
#init
mq r9 grid
mq grid rdi
#com
aqs genseed
isr 10
lq grid rdi
nao r8
mov r8 0 rdi

#init
ent relay0 naof-secs
lent relay0 rsi
mq naof-secs rdi
mov 10 rbx
mq equations rdx
#com
mq views r11
addc views view-number r11
#init
lea 3 rip r13
dst r11
secs 90 90
#com

##########################################################################################################
# obtain-genseed
##########################################################################################################
lq grid rdi
mq naof-secs rcx
mq equations rdx
mq clerk r11
addc clerk genseed
lea 3 rip r13
dst r11
mq rax genseed

#init
ent relay1 genseed
lent relay1 rsi
mq genseed rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
lea 3 rip r13
dst r11
#com

#init
ent relay2 grid
lent relay2 rsi
lq grid rdi
mov 0 rdi rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
lea 3 rip r13
dst r11
#com

ent genseed-relay exch-key
lent genseed-relay rsi
mq genseed rdi
mq naof-secs rcx
mov a rbx
mq equations rdx
mq views r11
addc views view-space r11
lea 3 rip r13
dst r11
#init
#com

##########################################################################################################
# stage-genseed
##########################################################################################################
# unlink
mq file-name rdi
mov 57 rax
sys

##########################################################################################################
# write-genseed
##########################################################################################################
aqs file
# open-write
mov 1f8 rdx
mov 41 rsi
mq file-name rdi
mov 2 rax
sys
mq rax file

# write
mq file rdi
mq naof-secs rdx
mq genseed rsi
mov 1 rax
sys

# close
mq file rdi
mov 3 rax
sys
#init
#com

##########################################################################################################
# com
##########################################################################################################
mq sret r13
add 1000 rsp
dst r13

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
