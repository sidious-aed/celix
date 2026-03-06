##########################################################################################################
# equations-main
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

entb i-sim i sim.\n
mov 1 rdi
lentb i-sim rsi
mov 7 rdx
mov 1 rax
sys

##########################################################################################################
# view-number
##########################################################################################################
entb relay0 general-code
lentb relay0 rsi
mov aedaed rdi
mov 10 rbx
mqb equations rdx
mqb views r11
addc views view-number r11
dct r11

##########################################################################################################
# com
##########################################################################################################
entb i-sim i sim.\n
aqs naof-i-sim-secs
mov 7 r8
mqb r8 naof-i-sim-secs
aqs entrea0
isr 200
aqs entrea0-site
nao r8
mqb r8 entrea0-site

lentb i-sim rsi
lqb entrea0 rdi
mqb naof-i-sim-secs rcx
mqb rcx entrea0-site
mqb equations r11
addc equations com r11
dct r11

mov 1 rdi
lqb entrea0 rsi
mqb entrea0-site rdx
mov 1 rax
sys

##########################################################################################################
# snap
##########################################################################################################

aqs key
aqs naof-key-secs
entb file-name clerk/exch.key
lentb file-name rdi
mqb clerk r11
addc clerk snap r11
dct r11
mqb rax key
mqb rcx naof-key-secs

entb exch-key-relay exch-key
lentb exch-key-relay rsi
mqb key rdi
mqb naof-key-secs rcx
mov a rbx
mqb equations rdx
mqb views r11
addc views view-space r11
dct r11

##########################################################################################################
# get-libc-site
##########################################################################################################
aqs stack-site
aqs libc-site
mqb equations rdx
mqb vecters rbx
mqb views r12
mqb clerk r11
addc clerk get-libc-site r11
dct r11
mqb rax stack-site
mqb rax libc-site

entb rstack-site stack-site
lentb rstack-site rsi
mqb libc-site rdi
mov 10 rbx
mqb equations rdx
mqb views r11
addc views view-number r11
dct r11

mqb equations r11
addc equations task r11
#dct r11

##########################################################################################################
# malloc
##########################################################################################################
aqs malloc-site
mov 1000 rdi
mqb libc-site r11
addc libc __libc_malloc r11
dct r11
mqb rax malloc-site

entb rmalloc-site malloc-site
lentb rmalloc-site rsi
mqb malloc-site rdi
mov 10 rbx
mqb equations rdx
mqb views r11
addc views view-number r11
dct r11

lentb i-sim rsi
mqb malloc-site rdi
mqb naof-i-sim-secs rcx
mqb rcx entrea0-site
mqb equations r11
addc equations com r11
dct r11

mov 1 rdi
mqb malloc-site rsi
mqb naof-i-sim-secs rdx
mov 1 rax
sys

aqs m0
mov 1000 rdi
mqb libc-site rdx
mqb clerk r11
addc clerk malloc r11
dct r11
mqb rax m0

entb rm0 m0
lentb rm0 rsi
mqb m0 rdi
mov 10 rbx
mqb equations rdx
mqb views r11
addc views view-number r11
dct r11

entb i-sim-b8 talkei talkei. airgo vah nah goo trim brader.\n
lentb i-sim-b8 rsi
mqb m0 rdi
mov 2e rcx
mqb equations r11
addc equations com r11
dct r11

mov 1 rdi
mqb m0 rsi
mov 2e rdx
mov 1 rax
sys

##########################################################################################################
# 81cyph
##########################################################################################################
entb i-sim27 Talkei talkei. Airgo vah nah goo trim brader.\n
aqs naof-i-sim27-secs
mov 2e r8
mqb r8 naof-i-sim27-secs
aqs cstring
aqs salt-sum
aqs grid
isr 10
nao r8
mqb r8 grid
aqs naof-c0quads
aqs naof-c0secs
aqs naof-c1quads
aqs naof-c1secs
aqs csite

entb ostring-relay ostring
lentb ostring-relay rsi
lentb i-sim27 rdi
mqb naof-i-sim27-secs rcx
mov a rbx
mqb equations rdx
mqb views r11
addc views view-space r11
dct r11

entb rkey key
lentb rkey rsi
mqb key rdi
mqb naof-key-secs rcx
mov a rbx
mqb equations rdx
mqb views r11
addc views view-space r11
#dct r11

aqs cyphered
lentb i-sim27 rsi
mqb naof-i-sim27-secs rcx
mqb key rdi
mqb naof-key-secs rdx
mqb libc-site r13
mqb equations r14
mqb views r15
mqb clerk r11
addc clerk 81cyph r11
dct r11
mqb rax cyphered

entb rcyphered cyphered
lentb rcyphered rsi
mqb cyphered rdi
mov 2e rcx
mov a rbx
mqb equations rdx
mqb views r11
addc views view-space r11
dct r11

##########################################################################################################
# 81decyph
##########################################################################################################
aqs decyphered
mqb cyphered rsi
mqb naof-i-sim27-secs rcx
mqb key rdi
mqb naof-key-secs rdx
mqb libc-site r13
mqb equations r14
mqb views r15
mqb clerk r11
addc clerk 81decyph r11
dct r11
mqb rax decyphered

entb rdecyphered decyphered
lentb rdecyphered rsi
mqb decyphered rdi
mov 2e rcx
mov a rbx
mqb equations rdx
mqb views r11
addc views view-space r11
dct r11

mov 1 rdi
mqb decyphered rsi
mqb naof-i-sim27-secs rdx
mov 1 rax
sys

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
