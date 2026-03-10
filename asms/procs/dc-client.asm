##########################################################################################################
# clerk-main <--> | (es) always mean(t).
##########################################################################################################
% equations
% views
% clerk
% vecters
% libc
dslr 1e8480
##########################################################################################################
# init
##########################################################################################################
push rbp
mov rsp rbp
aqs equations
mqb r9 equations
aqs views
mqb r10 views
aqs vecters
mqb r11 vecters
aqs clerk
mqb r12 clerk
entb jsect \n
entb i-sim i sim.\n

entb rfile file
mov 1 rdi
lentb i-sim rsi
mov 7 rdx
mov 1 rax
sys

##########################################################################################################
# calc-nonce
##########################################################################################################
aqs time-seconds
aqs time-microseconds
aqs time-z0
aqs time-z1
lqb time-seconds rdi
lqb time-z0 rsi
mov 60 rax
sys

entb req-init droid/
entb req-com .req
aqs rn
isr 400
aqs rn-site

lentb req-init rsi
lqb rn rdi
mov 6 rcx
mqb equations r11
addc equations com r11
dct r11

mqb time-seconds rdi
lqb rn rsi
add 6 rsi
mov 24 rbx
mqb equations r8
addc equations number-to-entree r8
dct r8
add 6 rax
lqb rn rsi
add rax rsi
mov 2e r9
movs r9 0 rsi
add 1 rax
mqb rax rn-site

mqb time-microseconds rdi
lqb rn rsi
mqb rn-site r8
add r8 rsi
mov 24 rbx
mqb equations r8
addc equations number-to-entree r8
dct r8
mqb rn-site r8
add rax r8
mqb r8 rn-site

lentb req-com rsi
lqb rn rdi
mqb rn-site r8
add r8 rdi
add 4 r8
mqb r8 rn-site
mov 4 rcx
mqb equations r11
addc equations com r11
dct r11
lqb rn rsi
mqb rn-site r8
add r8 rsi
nao r9
movs r9 0 rsi

mov 1 rdi
lqb rn rsi
mqb rn-site rdx
mov 1 rax
sys

mov 1 rdi
lentb jsect rsi
mov 1 rdx
mov 1 rax
sys

entb rrns rn-space
lentb rrns rsi
lqb rn rdi
mqb rn-site rcx
add 1 rcx
mov 10 rbx
mqb equations rdx
mqb views r11
addc views view-space r11
dct r11

##########################################################################################################
# write-request
##########################################################################################################
# unlink
lqb rn rdi
mov 57 rax
sys

aqs file
# open-write
mov 1f8 rdx
mov 41 rsi
lqb rn rdi
mov 2 rax
sys
mqb rax file

lentb rfile rsi
mqb file rdi
mov a rbx
mqb equations rdx
mqb views r11
addc views view-number r11
dct r11

#init
mqb equations r11
addc equations task r11
#dct r11
#com

# close
mqb file rdi
mov 3 rax
sys
#init
#com

##########################################################################################################
# com
##########################################################################################################
pop rbp
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
