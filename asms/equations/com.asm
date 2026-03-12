##########################################################################################################
# com
##########################################################################################################
# rsi | entree
# rdi | destination
# rcx | naof-secs
##########################################################################################################
# init
##########################################################################################################
push rbp
mov rsp rbp
sub 1000 rsp
aqs entree
mqb rsi entree
aqs destination
mqb rdi destination
aqs naof-entree-secs
mqb rcx naof-entree-secs

##########################################################################################################
# calc-naofs
##########################################################################################################
aqs naof-secs-in-quad
mov 8 r8
mqb r8 naof-secs-in-quad
mqb naof-entree-secs rcx
mov rcx rax
nao rdx
divqb naof-secs-in-quad rcx
aqs naof-quads
mqb rax naof-quads
factqb naof-secs-in-quad rax
aqs naof-quad-secs
mqb rax naof-quad-secs
mqb naof-entree-secs r9
sub rax r9
aqs naof-secs
mqb r9 naof-secs

##########################################################################################################
# coms
##########################################################################################################
mqb naof-quads rcx
cmp 0 rcx
st je com-quads-com
mqb entree rsi
mqb destination rdi
mqb naof-quads rcx
mzq
s com-quads-com

mqb naof-secs rcx
cmp 0 rcx
st je com-secs-com
mqb entree rsi
mqb naof-quad-secs r8
add r8 rsi
mqb destination rdi
add r8 rdi
mzs
s com-secs-com
#init
#com

#init
nao r9
s com-secs-init
movs 0 rsi r10
movs r10 0 rdi
add 1 rsi
add 1 rdi
cmp r8 r9
st je com-secs-com
add 1 r9
st jmp com-secs-init
s com-secs-com
#com

##########################################################################################################
# com
##########################################################################################################
mqb naof-entree-secs rax
add 1000 rsp
pop rbp
ret
#init
entb fn droid/clerk-com.secs
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
lqb naof-entree-secs rsi
mov 1 rax
sys
# close
mqb file rdi
mov 3 rax
sys
#com
