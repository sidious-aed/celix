##########################################################################################################
# get-naof-secs
# rdi | entree
# rdx | naof-entree-secs
# rsi | seek
# rcx | naof-seek-secs
##########################################################################################################
# com-init
##########################################################################################################
push rbp
mov rsp rbp
sub 1000 rsp
aqs entree
mqb rdi entree
aqs naof-entree-secs
mqb rdx naof-entree-secs
aqs seek
mqb rsi seek
aqs naof-seek-secs
mqb rcx naof-seek-secs

#init
mov 1 rdi
mqb entree rsi
mqb naof-entree-secs rdx
mov 1 rax
sys
mov 1 rdi
mqb seek rsi
mqb naof-seek-secs rdx
mov 1 rax
sys
#com

##########################################################################################################
# calc-naof-seeks
##########################################################################################################
aqs naof-seeks
mqb naof-seek-secs r8
mqb naof-entree-secs r9
sub r8 r9
add 1 r9
mqb r9 naof-seeks

#init
entb i-sim i sim.\n
mov 1 rdi
lentb i-sim rsi
mov 7 rdx
mov 1 rax
sys
#com

##########################################################################################################
# seek-space
##########################################################################################################
aqs seek-site
nao r8
mqb r8 seek-site
mqb naof-seeks r9
s seek-space-init
	mqb entree rsi
	add r8 rsi
	mqb seek rdi
	mqb naof-seek-secs rcx
	rcmp

	st je seek-space-com
	mqb seek-site r8
	mqb naof-seeks r9
	add 1 r8
	mqb r8 seek-site
	cmp r9 r8
	st je set-non-init

	st jmp seek-space-init
	s seek-space-com

	st jmp set-non-com
	s set-non-init
	mov ffffffffffffffff r8
	mqb r8 seek-site
s set-non-com

##########################################################################################################
# com-com
##########################################################################################################
mq naof-seeks r10
mqb seek-site rax
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
