##########################################################################################################
# naof-grid-secs
##########################################################################################################
# rdi | grid (3 quads)
#       0 | stack-site
#       1 | at-site
#       2 | breadth
# rsi | naof-secs
##########################################################################################################
# com-init
##########################################################################################################
sub 1000 rsp

aqs grid
mq rdi grid
aqs naof-secs
mq rsi naof-secs

mq grid r8
mov 0 r8 r8
cmp 0 r8
st jne init-grid-com
s init-grid-init
mq grid r11
# anonomous-mmap
nao rdi
mov rdi 8 r11
mov f4240 rsi
mq rsi 10 r11
mov 7 rdx
mov 22 r10
nao r9
nao r8
mov 9 rax
sys
mq grid r11
mov rax 0 r11
s init-grid-com

mq grid r11
mov 8 r11 r8
mq naof-secs r9
add r8 r9
mov 10 r11 r10
cmp r9 r10
st jb expansion-com
s expansion-init
aqs expansion-facter
mov 2 r13
mq r13 expansion-facter
# anonomous-mmap
nao rdi
mov r9 rsi
factq expansion-facter rsi
mov rsi 8 r11
mov 7 rdx
mov 22 r10
nao r9
nao r8
mov 9 rax
sys
mq grid r11
mov rax 0 r11
s expansion-com

mq grid r11
mov 10 r11 r9
mq naof-secs r10
add r10 r9
mov r9 10 r11
mov 0 r11 rax
mov 8 r11 r8
add r8 rax
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
