##########################################################################################################
# ssc | scream-seek-chart
##########################################################################################################
# rdi | ci
# rcx | seek-name
# rsi | seek-value
# r15 | wrecord
% equations
% cf
% views
##########################################################################################################
# init
##########################################################################################################
sub 10000 rsp
aqs ci
mq rdi ci
aqs chart
mov 0 rdi r8
mq r8 chart
aqs naof-chart-secs
mov 8 rdi r8
mq r8 naof-chart-secs
aqs chart-index
mov 10 rdi r8
mq r8 chart-index
aqs naof-chart-index-secs
mov 18 rdi r8
mq r8 naof-chart-index-secs
aqs strstr
mq r14 strstr
aqs seek-name
mq rcx seek-name
aqs seek-value
mq rsi seek-value
aqs wrecord
mq r15 wrecord
aqs equations
mq rdx equations
aqs cf
mq rbx cf
aqs views
mq r12 views
ent jsect \n
aqs chartf
aqs indexf
ent rsite site
aqs tseek
isr 400
aqs tseek-site
aqs record
aqs record-site
nao r8
mq r8 record-site

ent i-sim i sim.\n
mov 1 rdi
lent i-sim rsi
mov 7 rdx
mov 1 rax
sys

mq seek-name rsi
mq seek-value rdi
lq tseek rbx
mq equations r14
mq views r15
mq cf r11
addc cf tsdsl r11
dct r11
mq rax tseek-site

mov 1 rdi
lq tseek rsi
mq tseek-site rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

aqs seek-site
lq tseek rsi
mq chart rdi
mq strstr r11
dct r11
mq rax seek-site
cmp 0 rax
st je ssc-com

#init
mov 1 rdi
mov rax rsi
mov aa rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys
#com

aqs rcs
aqs rcs-site
mov rax rdi
mq chart rsi
sub rsi rdi
mq chart-index rsi
nao r10
s seek-record-from-orecle-site-init
	mov 0 rsi r11
	cmp r11 rdi
	st jbe seek-record-from-orecle-site-com
	mov r11 r10
	add 8 rsi
	st jmp seek-record-from-orecle-site-init
s seek-record-from-orecle-site-com
mq r10 rcs
sub r10 r11
mq r11 rcs-site

ent rrcs rcs
lent rrcs rsi
mq rcs rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

ent rrcs-site rcs-site
lent rrcs-site rsi
mq rcs-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

mq chart rsi
mq rcs r8
add r8 rsi
mq wrecord rdi
mq rcs-site rcx
sub 1 rcx
mq rcx record-site
mq equations r11
addc equations com r11
dct r11

s ssc-com
##########################################################################################################
# com
##########################################################################################################
mq record-site rax
add 10000 rsp
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
lq naof-key-secs rsi
mov 1 rax
sys
# close
mq file rdi
mov 3 rax
sys
#com
#init
mov 1 rdi
lq cs rsi
mov 10 rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys
lent rchart-site rsi
mq chart-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11
#com
