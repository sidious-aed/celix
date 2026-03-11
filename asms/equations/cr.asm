##########################################################################################################
# com
##########################################################################################################
# rdi | naof-secs
# rbx | is-init
##########################################################################################################
# com
##########################################################################################################
push rbp
mov rsp rbp
sub 1000 rsp
aqs naof-secs
mqb rdi naof-secs
aqs rule
nao r8
mqb r8 rule
entb i-sim i sim.\n

test 1 rbx
st jne init-com

s init-init
	# anonomous-mmap
	nao rdi
	mov 3d0910 rsi
	mov 7 rdx
	mov 22 r10
	nao r9
	nao r8
	mov 9 rax
	sys
	mqb rax rule

	mqb rule r8
	nao r9
	mqb r9 0 r8
	mov 3d0910 r9
	mov r9 8 r8
	st jmp cr-com
s init-com

s cr-com
##########################################################################################################
# com
##########################################################################################################
mqb rule rax
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
