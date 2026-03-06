##########################################################################################################
# com
##########################################################################################################
# rsi | entree
# rdi | destination
# rcx | naof-secs
##########################################################################################################
# com-init
##########################################################################################################
sub 1000 rsp
aqs entree
mqb rsi entree
aqs destination
mqb rdi destination
aqs naof-entree-secs
mqb rcx naof-entree-secs
aqs naof-secs-in-quad
mov 8 r8
mqb r8 naof-secs-in-quad
mov rcx rax
nao rdx
divq naof-secs-in-quad rcx
aqs naof-quads
mqb rax naof-quads
factq naof-secs-in-quad rax
mqb naof-entree-secs r9
sub rax r9
aqs naof-secs
mqb r9 naof-secs
aqs naof-quad-secs
mqb rax naof-quad-secs

mqb naof-quads rcx
mqb entree rsi
mqb destination rdi
mzq

mqb entree rsi
mqb naof-quad-secs r8
add r8 rsi
mqb destination rdi
add r8 rdi
mqb naof-secs rcx
mzs

##########################################################################################################
# com-com
##########################################################################################################
add 1000 rsp
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
