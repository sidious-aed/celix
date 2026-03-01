% equations
##########################################################################################################
# view-number
##########################################################################################################
# rsi | relay
# rdi | space
# rcx | naof-secs
# rbx | base
# rdx | equations
##########################################################################################################
# view-number-init
##########################################################################################################
sub 10000 rsp

aqs relay
mq rsi relay
aqs space
mq rdi space
aqs naof-secs
mq rcx naof-secs
aqs et
sub 1 rcx
mq rcx et
aqs base
mq rbx base
aqs equations
mq rdx equations
ent jedao-sectioner  | 
aqs vs-space
isr 10000
aqs vs-space-site
aqs base-space
isr 100

mq relay rdi
mq equations r11
addc equations get-naof-secs r11 # get-naof-secs
dct r11

mq rax vs-space-site
mq relay rsi
lq vs-space rdi
mq vs-space-site rcx
mq equations r11
addc equations com r11 # com
dct r11

lent jedao-sectioner rsi
lq vs-space rdi
mq vs-space-site r8
add r8 rdi
mov 3 rcx
add rcx r8
mq r8 vs-space-site
mq equations r11
addc equations com r11 # com
dct r11

lq vs-space rsi
mq vs-space-site r8
add r8 rsi
mov 5b r9
movs r9 0 rsi
add 1 r8
mq r8 vs-space-site

aqs naof-base-secs
aqs space-site
nao r8
mq r8 space-site
s write-space-init
	mq space-site r8
	mq naof-secs r14
	cmp r8 r14
	st je write-space-com

	mq space rdi
	add r8 rdi
	nao r10
	movs 0 rdi r10
	mov r10 rdi
	lq base-space rsi
	mq base rbx
	mq equations r11
	addc equations number-to-entree r11 # number-to-entree
	dct r11
	mq rax naof-base-secs

	s add-zero-for-b16-init
		mq base r9
		cmp 10 r9
		st jne add-zero-for-b16-com
		cmp 1 rax
		st jne add-zero-for-b16-com
		lq vs-space rsi
		mq vs-space-site r8
		add r8 rsi
		mov 30 r10
		movs r10 0 rsi
		add 1 r8
		mq r8 vs-space-site
	s add-zero-for-b16-com

	lq base-space rsi
	lq vs-space rdi
	mq vs-space-site r8
	add r8 rdi
	mov rax rcx
	add rax r8
	mq r8 vs-space-site
	mq equations r11
	addc equations com r11
	dct r11
	#init
	#com

	mq space-site r8
	mq et r9
	cmp r8 r9
	st je inner-segment-com
	s inner-segment-init
	mq vs-space-site r8
	lq vs-space rsi
	add r8 rsi
	mov 2c r9
	movs r9 0 rsi
	add 1 r8
	mov 20 r9
	add 1 rsi
	movs r9 0 rsi
	add 1 r8
	mq r8 vs-space-site
s inner-segment-com

mq space-site r8
add 1 r8
mq r8 space-site
st jmp write-space-init
s write-space-com
#init
#com

lq vs-space rsi
mq vs-space-site r8
add r8 rsi
mov 5d r9
movs r9 0 rsi
add 1 r8
mq r8 vs-space-site

lq vs-space rsi
mq vs-space-site r8
add r8 rsi
mov a r9
movs r9 0 rsi
add 1 r8
mq r8 vs-space-site

mov 1 rdi
lq vs-space rsi
mq vs-space-site rdx
mov 1 rax
sys

##########################################################################################################
# view-number-com
##########################################################################################################
add 10000 rsp
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
