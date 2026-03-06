##########################################################################################################
# vecterss-main
##########################################################################################################
% equations
% views
% vecters
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

##########################################################################################################
# add-to-entree
##########################################################################################################
entb sim0 squarelee else where does not meen vactant.\n
aqs naof-sim0-secs
mov 2c r9
mqb r9 naof-sim0-secs
aqs entrea01
isr 200
aqs entrea01-site
nao r8
mqb r8 entrea01-site

mov 1 rdi
lentb sim0 rsi
mqb naof-sim0-secs rdx
mov 1 rax
sys

lentb sim0 rsi
lqb entrea01 rdi
mqb naof-sim0-secs rcx
mqb equations rdx
mqb equations r11
addc equations com r11
dct r11
mqb entrea01-site r8
add rax r8
mqb r8 entrea01-site

entb sim1 \t<--> you might find knowstead or flux.\n
aqs naof-sim1-secs
mov 28 r8
mqb r8 naof-sim1-secs

lentb sim1 rsi
lqb entrea01 rdi
mqb naof-sim1-secs rcx
mqb equations rdx
mqb equations r11
addc equations com r11
dct r11
mqb entrea01-site r8
add rax r8
mqb r8 entrea01-site

entb sim2 \t\t<--> regardsages in conciderages. * meant even.\n
aqs naof-sim2-secs
mov 32 r8
mqb r8 naof-sim2-secs

lentb sim2 rsi
lqb entrea01 rdi
mqb naof-sim2-secs rcx
mqb equations rdx
mqb equations r11
addc equations com r11
dct r11
mqb entrea01-site r8
add rax r8
mqb r8 entrea01-site

mov 1 rdi
lqb entrea01 rsi
mqb entrea01-site rdx
mov 1 rax
sys

entb relay0 entrea01-site
lentb relay0 rsi
mqb entrea01-site rdi
mov 10 rbx
mqb equations rdx
mqb views r11
addc views view-number r11
dct r11
#init
#com

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
