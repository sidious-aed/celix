##########################################################################################################
# snap
##########################################################################################################
# rdi | file-name
##########################################################################################################
# init
##########################################################################################################
push rbp
mov rsp rbp
sub 1000 rsp
aqs file-name
mqb rdi file-name
aqs file
aqs naof-file-secs
aqs snaped-space

##########################################################################################################
# obtain-file-meta
##########################################################################################################
aqs file
# open-read
nao rsi
mqb file-name rdi
mov 2 rax
sys
mqb rax file

# lseek
mqb file rdi
nao rsi
mov 2 rdx
mov 8 rax
sys
mqb rax naof-file-secs

##########################################################################################################
# snap-file
##########################################################################################################
# file-mmap
nao rdi
mqb naof-file-secs rsi
mov 7 rdx
mov 2 r10
mqb file r8
nao r9
mov 9 rax
sys
mqb rax snaped-space

# close
mqb file rdi
mov 3 rax
sys
#init
#com

##########################################################################################################
# com-com
##########################################################################################################
mqb snaped-space rax
mqb naof-file-secs rcx
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
