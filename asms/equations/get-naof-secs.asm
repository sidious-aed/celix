##########################################################################################################
# get-naof-secs
# rdi | entree
##########################################################################################################
# com-init
##########################################################################################################
push rbp
mov rsp rbp
sub 1000 rsp
mov rdi r14
s get-naof-secs-init
movs 0 rdi r8
cmp 0 r8
st je get-naof-secs-com
add 1 rdi
st jmp get-naof-secs-init
s get-naof-secs-com
sub r14 rdi
mov rdi rax
#init
#com
##########################################################################################################
# com-com
##########################################################################################################
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
mqb rax file
# write
mqb file rdi
mov 8 rdx
mqb naof-secs rdx
mqb entree rsi
mov 1 rax
sys
# close
mqb file rdi
mov 3 rax
sys
#com
