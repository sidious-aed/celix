##########################################################################################################
# get-naof-secs
# rdi | entree
# rdx | naof-entree-secs
# rsi | seek
# rcx | naof-seek-secs
##########################################################################################################
# com-init
##########################################################################################################6push rbp
push rbp
mov rsp rbp
sub 1000 rsp
aqs entree
mqb rdi entree
aqs naof-entree-secs
mqb rdx naof-entree-secs
aqs seek
mqb rsi seek
aqs naof-seek-secs
mqb rcx naof-seek-secs
aqs is-equal
nao r8
mqb r8 is-equal
#st jmp compair-spaces-com

##########################################################################################################
# not-if-not-equal-naof-secs
##########################################################################################################
mqb naof-entree-secs r8
mqb naof-seek-secs r9
cmp r8 r9
st jne compair-spaces-com

##########################################################################################################
# seek-space
##########################################################################################################
mqb entree rsi
mqb seek rdi
mqb naof-entree-secs rcx
nao rdx
rcmp
st jne compair-spaces-com
mov 1 r8
mqb r8 is-equal
s compair-spaces-com
##########################################################################################################
# com
##########################################################################################################
mqb is-equal rax
add 1000 rsp
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
mq file rdi
mov 8 rdx
lq seek-site rsi
mov 1 rax
sys
# close
mq file rdi
mov 3 rax
sys
#com
