##########################################################################################################
# com
##########################################################################################################
# rsi | entree
# rdi | destination
# rcx | naof-secs
##########################################################################################################
# init
##########################################################################################################
sub 1000 rsp
aqs entree
mq rsi entree
aqs destination
mq rdi destination
aqs naof-entree-secs
mq rcx naof-entree-secs

##########################################################################################################
# calc-naofs
##########################################################################################################
aqs naof-secs-in-quad
mov 8 r8
mq r8 naof-secs-in-quad
mq naof-entree-secs rcx
mov rcx rax
nao rdx
divq naof-secs-in-quad rcx
aqs naof-quads
mq rax naof-quads
factq naof-secs-in-quad rax
aqs naof-quad-secs
mq rax naof-quad-secs
mq naof-entree-secs r9
sub rax r9
aqs naof-secs
mq r9 naof-secs

##########################################################################################################
# coms
##########################################################################################################
mq naof-quads rcx
cmp 0 rcx
st je com-quads-com
	mq entree rsi
	mq destination rdi
	mq naof-quads rcx
	mzq
s com-quads-com

mq naof-secs rcx
cmp 0 rcx
st je com-secs-com
	mq entree rsi
	mq naof-quad-secs r8
	add r8 rsi
	mq destination rdi
	add r8 rdi
	mzs
s com-secs-com
#init
#com

##########################################################################################################
# com
##########################################################################################################
add 1000 rsp
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
