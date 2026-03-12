##########################################################################################################
# equations-main
##########################################################################################################
% equations
% views
% vects
##########################################################################################################
# init
##########################################################################################################
push rbp
mov rsp rbp
sub 1e8480 rsp
dslr 1e8480
aqs equations
mqb r9 equations
aqs views
mqb r10 views
aqs vects
mqb r11 vects

entb rmr mr
entb d-sim dwerbp dwerbp. in housa mie toe mar.\n
mov 1 rdi
lentb d-sim rsi
mov 25 rdx
mov 1 rax
sys

aqs mr
mov 1 rbx
mqb equations r11
addc equations cr r11
dct r11
mqb rax mr

lentb rmr rsi
mqb mr rdi
mov 10 rbx
mqb equations rdx
mqb views r11
addc views view-number r11
dct r11

##########################################################################################################
# cvect
##########################################################################################################
entb rvect vect
aqs vect

nao rax
mov 10 rdi
mov a rsi
mqb equations rdx
mqb vects r11
addc vects cvect r11
dct r11
mqb rax vect

lentb rvect rsi
mqb vect rdi
mov 10 rbx
mqb equations rdx
mqb views r11
addc views view-number r11
dct r11

lentb rvect rsi
mqb vect rdi
mov 30 rcx
mov a rbx
mqb equations rdx
mqb views r11
addc views view-space r11
dct r11
#init
#com

##########################################################################################################
# atv (if m were short for memo) <--> * maybe meant warm even.
##########################################################################################################
aqs naof-csecs
entb rnaof-csecs naof-csecs
entb dsim09 bdrectiquida bdrectiquide. i-m in np-id-imanaquidom duqiuid.\n
aqs me
lentb dsim09 rsi
mqb rsi me
aqs mn
mov 3d r11
mqb r11 mn

mqb vect rdi
lqb me rsi
mqb equations rdx
mqb vects r11
addc vects atv r11
dct r11
mqb rax vect

mqb vect rdi
lqb me rsi
mqb equations rdx
mqb vects r11
addc vects atv r11
dct r11
mqb rax vect

lentb rvect rsi
mqb vect rdi
mov 30 rcx
mov a rbx
mqb equations rdx
mqb views r11
addc views view-space r11
dct r11

lentb rnaof-csecs rsi
mqb naof-csecs rdi
mov 10 rbx
mqb equations rdx
mqb views r11
addc views view-number r11
dct r11

aqs elem
mqb vect rdi
mov 1 rsi
mqb vects r11
addc vects gvs r11
dct r11
mqb rax elem

lentb rvect rsi
mqb elem rdi
mov 10 rcx
mov a rbx
mqb equations rdx
mqb views r11
addc views view-space r11
dct r11

mqb elem r8
mov 1 rdi
mov 0 r8 rsi
mov 8 r8 rdx
mov 1 rax
sys

##########################################################################################################
# com
##########################################################################################################
add 1e8480 rsp
pop rbp
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
