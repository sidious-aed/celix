##########################################################################################################
# naof-grid-secs
##########################################################################################################
# rdi | grid (3 quads)
#       0 | stack-site
#       1 | at-site
#       2 | breadth
# rsi | naof-secs
##########################################################################################################
# init
##########################################################################################################
sub 1000 rsp

aqs grid
mq rdi grid
aqs naof-secs
mq rsi naof-secs
aqs expansion-facter
mov 2 r13
mq r13 expansion-facter
aqs naof-mmap-secs
nao r8
mq r8 naof-mmap-secs
ent init-entree initialising grid.\n
aqs naof-init-entree-secs
mov 13 r8
mq r8 naof-init-entree-secs
ent expansion-entree expanding grid.\n
aqs naof-expansion-entree-secs
mov 10 r8
mq r8 naof-expansion-entree-secs
aqs grid-at
mq r8 grid-at
aqs grid-breadth
mq r8 grid-breadth

##########################################################################################################
# grid-init
##########################################################################################################
mq grid r8
mov 0 r8 r8
mq r8 grid-at
cmp 0 r8
st jne init-grid-com
s init-grid-init
cmp f4240 rsi
st jb custom-init-naof-secs-com
add 1 rsi
factq expansion-facter rsi
st jmp init-naof-secs-com
s custom-init-naof-secs-com
	mov f4240 rsi
	s init-naof-secs-com
	mq rsi grid-breadth

	mov 1 rdi
	lent init-entree rsi
	mq naof-init-entree-secs rdx
	mov 1 rax
	sys

	mq grid-breadth rsi
	mq rsi naof-mmap-secs
	mq grid r11
	mov rsi 10 r11
	# anonomous-mmap
	nao rdi
	mov rdi 8 r11
	mov 7 rdx
	mov 22 r10
	nao r9
	nao r8
	mov 9 rax
	sys
	mq grid r11
	mov rax 0 r11
s init-grid-com

##########################################################################################################
# grid-expansion
##########################################################################################################
mq grid r11
mov 8 r11 r8
mq naof-secs r9
add r8 r9
#mq r9 grid-at
mov 10 r11 r10
mq r10 grid-breadth
cmp r10 r9
st jb expansion-com

s expansion-init
	mov 1 rdi
	lent expansion-entree rsi
	mq naof-expansion-entree-secs rdx
	mov 1 rax
	sys

	mq grid r11
	mov 10 r11 r10
	# anonomous-mmap
	nao rdi
	mov r10 rsi
	mq naof-secs r8
	add r8 rsi
	factq expansion-facter rsi
	mov rsi 10 r11
	mq rsi naof-mmap-secs
	mov 7 rdx
	mov 22 r10
	nao r9
	nao r8
	mov 9 rax
	sys
	mq grid r11
	mov rax 0 r11
	nao r8
	mov r8 8 r11
s expansion-com

mq grid r11
mov 0 r11 rax
mov 8 r11 r8
mq naof-secs r9
add r9 r8
mov r8 8 r11
add r9 rax
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
lq naof-secs rsi
mov 1 rax
#sys
# write
mq file rdi
mov 8 rdx
lq naof-mmap-secs rsi
mov 1 rax
#sys
# write
mq file rdi
mov 8 rdx
lq grid-at rsi
mov 1 rax
sys
# write
mq file rdi
mov 8 rdx
lq grid-breadth rsi
mov 1 rax
#sys
# close
mq file rdi
mov 3 rax
sys
#com
