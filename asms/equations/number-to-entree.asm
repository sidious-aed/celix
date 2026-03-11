##########################################################################################################
# number-to-entree
##########################################################################################################
# rdi | number
# rsi | entree
# rbx | base
# r13 | sret
##########################################################################################################
# com-init
##########################################################################################################
push rbp
mov rsp rbp
sub 1000 rsp
aqs number
mqb rdi number
aqs entree
mqb rsi entree
aqs base
mqb rbx base
aqs et
aqs bbreadth
mov 1 rax
mqb rax bbreadth

aqs file
entb fn droid/inv.secs
# unlink
lentb fn rdi
mov 57 rax
sys
# open-write
mov 1f8 rdx
mov 41 rsi
lent fn rdi
mov 2 rax
sys
mqb rax file

aqs esite
mqb number r8
cmp 0 r8
st jne is-zero-com
s is-zero-init
	mov 30 r8
	mqb entree rsi
	movs r8 0 rsi
	mov 1 rax
	mqb rax esite
	st jmp write-number-com
s is-zero-com

nao r8
s seek-base-breadth-init
	mqb bbreadth rax
	factqb base rax
	mqb rax bbreadth
	st jo seek-base-breadth-com
	mqb rax et
	add 1 r8
	cmp 10 r8
	st je seek-base-breadth-com
	st jmp seek-base-breadth-init
s seek-base-breadth-com

# write
mqb file rdi
mov 8 rdx
lqb bbreadth rsi
mov 1 rax
sys
# write
mqb file rdi
mov 8 rdx
lqb base rsi
mov 1 rax
sys

aqs focus
mqb et r8
mqb r8 focus
s seek-to-et-init
mqb number rax
nao rdx
divqb focus
cmp 0 rax
st jne seek-to-et-com
mqb focus rax
nao rdx
divqb base
mqb rax focus
st jmp seek-to-et-init
s seek-to-et-com
	aqs sum
	nao r8
	mqb r8 esite
	s write-number-init

	mqb number rax
	nao rdx
	divqb focus
	mqb rax sum

	mqb sum rax
	cmp 9 rax
	st ja a-scope-com
	add 30 rax
	st jmp scopes-com
	s a-scope-com
	add 57 rax
	s scopes-com

	mqb esite r8
	mqb entree rsi
	add r8 rsi
	movs rax 0 rsi
	add 1 r8
	mqb r8 esite

	mqb number r9
	mqb sum r10
	factqb focus r10
	sub r10 r9
	mqb r9 number

	mqb focus rax
	nao rdx
	divqb base
	mqb rax focus
	cmp 0 rax
	st je write-number-com
	st jmp write-number-init
s write-number-com
#init
#com
# close
mqb file rdi
mov 3 rax
sys

##########################################################################################################
# com-com
##########################################################################################################
mqb esite rax
add 1000 rsp
pop rbp
ret

#init
#com
