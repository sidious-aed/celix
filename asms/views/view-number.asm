##########################################################################################################
# view-number
##########################################################################################################
# rsi | relay
# rdi | number
# rbx | base
# rdx | equations
% equations
##########################################################################################################
# view-number-init
##########################################################################################################
sub 10000 rsp

aqs relay
mq rsi relay
aqs number
mq rdi number
aqs base
mq rbx base
aqs equations
mq rdx equations
ent jedao-sectioner  | 
aqs view-number-space
isr 1000
aqs view-number-space-site

mq relay rdi
mq equations r11
addc equations get-naof-secs r11 # get-naof-secs
dct r11

mq rax view-number-space-site
mq relay rsi
lq view-number-space rdi
mq view-number-space-site rcx
mq equations r11
addc equations com r11 # com
dct r11

lent jedao-sectioner rsi
lq view-number-space rdi
mq view-number-space-site r8
add r8 rdi
mov 3 rcx
add rcx r8
mq r8 view-number-space-site
mq equations r11
addc equations com r11 # com
dct r11

mq number rdi
lq view-number-space rsi
mq view-number-space-site r8
add r8 rsi
mq base rbx
mq equations r11
addc equations number-to-entree r11 # number-to-entree
dct r11
mq view-number-space-site r8
add rax r8
mq r8 view-number-space-site
lq view-number-space rsi
add r8 rsi
mov a r9
movs r9 0 rsi
add 1 r8
mq r8 view-number-space-site

mov 1 rdi
lq view-number-space rsi
mq view-number-space-site rdx
mov 1 rax
sys
#init
#com

##########################################################################################################
# view-number-com
##########################################################################################################
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
mq naof-secs rdx
mq entree rsi
mov 1 rax
sys
# close
mq file rdi
mov 3 rax
sys
#com
