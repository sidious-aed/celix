##########################################################################################################
# equations-main
##########################################################################################################
% equations
% views
##########################################################################################################
# init
##########################################################################################################
sub 1e8480 rsp
aqs equations
mq r9 equations
aqs views
mq r10 views
aqs cf
mq r11 cf
aqs sp
isr 16e368

##########################################################################################################
# snap
##########################################################################################################
aqs file
aqs naof-fsecs
s snap-ini
	ent snap-fn standard.h
	# open-read
	nao rsi
	lent snap-fn rdi
	mov 2 rax
	sys
	mq rax file
	# lseek
	mq file rdi
	nao rsi
	mov 2 rdx
	mov 8 rax
	sys
	mq rax naof-fsecs
	# lseek
	mq file rdi
	nao rdx
	nao rsi
	mov 8 rax
	sys
	# read
	mq file rdi
	lq sp rsi
	mq naof-fsecs rdx
	mov 0 rax
	sys
	# close
	mq file rdi
	mov 3 rax
	sys
s snop-com

entb rstandard standard.h
lentb rstartndard rsi
lq sp rdi
mq equations rdx
mq naof-fsecs rcx
mov 10 rcx
mq views r11
addc views view-space r11
dct r11

##########################################################################################################
# com
##########################################################################################################
add 1e8480 rsp
ret

#init
ent fn droid/clerk-com.secs
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
lq b16-number rsi
mov 1 rax
sys
# close
mqb file rdi
mov 3 rax
sys
#com

#init
aqs time-secs
nao r8
mqb r8 time-secs
aqs time-micro-secs
mov aed r8
mqb r8 time-micro-secs
s task0-init
# nanosleep
lqb time-seconds rdi
mov 23 rax
sys
st jmp task0-init
s task0-com
#com
