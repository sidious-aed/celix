##########################################################################################################
# equations-main
##########################################################################################################
% equations
% views
% cf
##########################################################################################################
# init
##########################################################################################################
sub 4c4b40 rsp
aqs equations
mq r9 equations
aqs views
mq r10 views
aqs cf
mq r11 cf
aqs binary-name
mq r12 binary-name
aqs naof-binary-name-secs
mq r13 naof-binary-name-secs
aqs elffn
mq r14 elffn
aqs elffn-site
mq r15 elffn-site
ent i-sim i sim. ka tic boo tic but.\n
ent jsect \n

mov 1 rdi
mq elffn rsi
mq elffn-site rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

mov 1 rdi
lent i-sim rsi
mov 1b rdx
mov 1 rax
sys

mq equations r11
addc equations task r11
#dct r11

aqs elff
# open-read
mq elffn rdi
nao rsi
mov 2 rax
sys
mq rax elff

ent relff elff
lent relff rsi
mq elff rdi
mov 24 rbx
#mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

aqs elff-site
aqs wd-elf-site
# lseek
mq elff rdi
nao rsi
mov 2 rdx
mov 8 rax
sys
mq rax elff-site
mq rax wd-elf-site

ent rwd-elf-site wd-elf-site
lent rwd-elf-site rsi
mq wd-elf-site rdi
mov 24 rbx
#mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

aqs wd-elf
# anonomous-mmap
nao rdi
mq wd-elf-site rsi
mov 7 rdx
mov 2 r10
nao r9
mq elff r8
mov 9 rax
sys
mq rax wd-elf

mov 1 rdi
mq wd-elf rsi
mq wd-elf-site rdx
mov 1 rax
sys

ent rwd-elf wd-elf
lent rwd-elf rsi
mq wd-elf rdi
mov 24 rbx
#mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

##########################################################################################################
# com
##########################################################################################################
add 4c4b40 rsp
ret

#init
ent fn droid/clerk-com.secs
aqs file
# unlink
lentb fn rdi
mov 57 rax
sys
# open-write
mov 1f8 rdx
mov 41 rsi
lentb fn rdi
mov 2 rax
sys
mqb rax file
# write
mqb file rdi
mov 8 rdx
lq b16-number rsi
mov 1 rax
sys
# close
mqb file rdi
mov 3 rax
sys
#com

#init
lent rcmpv rsi
mq cmpv rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11
#com

#init
aqs time-secs
nao r8
mqb r8 time-secs
aqs time-micro-secs
mov aed r8
mqb r8 time-micro-secs
s task0-init
# nanosleep
lqb time-seconds rdi
mov 23 rax
sys
st jmp task0-init
s task0-com
#com
