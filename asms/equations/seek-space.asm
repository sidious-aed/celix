##########################################################################################################
# get-naof-secs
# rdi | entree
# rdx | naof-entree-secs
# rsi | seek
# rcx | naof-seek-secs
##########################################################################################################
# com-init
##########################################################################################################
sub 1000 rsp
aqs entree
mq rdi entree
aqs naof-entree-secs
mq rdx naof-entree-secs
aqs seek
mq rsi seek
aqs naof-seek-secs
mq rcx naof-seek-secs

##########################################################################################################
# calc-naof-seeks
##########################################################################################################
aqs naof-seeks
mq naof-seek-secs r8
mq naof-entree-secs r9
sub r8 r9
add 1 r9
mq r9 naof-seeks

##########################################################################################################
# seek-space
##########################################################################################################
aqs seek-site
nao r8
mq r8 seek-site
mq naof-seeks r9
s seek-space-init
	mq entree rsi
	add r8 rsi
	mq seek rdi
	mq naof-seek-secs rcx
	rcmp

	st je seek-space-com
	mq seek-site r8
	mq naof-seeks r9
	add 1 r8
	mq r8 seek-site
	cmp r9 r8
	st je set-non-init

	st jmp seek-space-init
	s seek-space-com

	st jmp set-non-com
	s set-non-init
	mov ffffffffffffffff r8
	mq r8 seek-site
s set-non-com

##########################################################################################################
# com-com
##########################################################################################################
#mq naof-seeks r10
mq seek-site rax
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

#init
ent i-sim i sim.\n
mov 1 rdi
lent i-sim rsi
mov 7 rdx
mov 1 rax
sys
#com

#init
mov 1 rdi
mq entree rsi
mq naof-entree-secs rdx
mov 1 rax
sys
mov 1 rdi
mq seek rsi
mq naof-seek-secs rdx
mov 1 rax
sys
#com
