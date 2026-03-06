##########################################################################################################
# view-number
##########################################################################################################
# rsi | relay
# rdi | space
# rcx | naof-secs
# rbx | base
# rdx | equations
% equations
##########################################################################################################
# view-number-init
##########################################################################################################
push rbp
mov rsp rbp
sub 40000 rsp
aqs relay
mqb rsi relay
aqs space
mqb rdi space
aqs naof-secs
mqb rcx naof-secs
aqs et
sub 1 rcx
mqb rcx et
aqs base
mqb rbx base
aqs equations
mqb rdx equations
entb jedao-sectioner  | 
aqs vs-space
isr 10000
aqs vs-space-site
aqs base-space
isr 100

mqb relay rdi
mqb equations r11
addc equations get-naof-secs r11 # get-naof-secs
dct r11

mqb rax vs-space-site
mqb relay rsi
lqb vs-space rdi
mqb vs-space-site rcx
mqb equations r11
addc equations com r11 # com
dct r11

lentb jedao-sectioner rsi
lqb vs-space rdi
mqb vs-space-site r8
add r8 rdi
mov 3 rcx
add rcx r8
mqb r8 vs-space-site
mqb equations r11
addc equations com r11 # com
dct r11

lqb vs-space rsi
mqb vs-space-site r8
add r8 rsi
mov 5b r9
movs r9 0 rsi
add 1 r8
mqb r8 vs-space-site

aqs naof-base-secs
aqs space-site
nao r8
mqb r8 space-site
s write-space-init
	mqb space-site r8
	mqb naof-secs r14
	cmp r8 r14
	st je write-space-com

	mqb space rdi
	add r8 rdi
	nao r10
	movs 0 rdi r10
	mov r10 rdi
	lqb base-space rsi
	mqb base rbx
	mqb equations r11
	addc equations number-to-entree r11 # number-to-entree
	dct r11
	mqb rax naof-base-secs

	s add-zero-for-b16-init
		mqb base r9
		cmp 10 r9
		st jne add-zero-for-b16-com
		cmp 1 rax
		st jne add-zero-for-b16-com
		lqb vs-space rsi
		mqb vs-space-site r8
		add r8 rsi
		mov 30 r10
		movs r10 0 rsi
		add 1 r8
		mqb r8 vs-space-site
	s add-zero-for-b16-com

	lqb base-space rsi
	lqb vs-space rdi
	mqb vs-space-site r8
	add r8 rdi
	mov rax rcx
	add rax r8
	mqb r8 vs-space-site
	mqb equations r11
	addc equations com r11
	dct r11
	#init
	#com

	mqb space-site r8
	mqb et r9
	cmp r8 r9
	st je inner-segment-com
	s inner-segment-init
	mqb vs-space-site r8
	lqb vs-space rsi
	add r8 rsi
	mov 2c r9
	movs r9 0 rsi
	add 1 r8
	mov 20 r9
	add 1 rsi
	movs r9 0 rsi
	add 1 r8
	mqb r8 vs-space-site
s inner-segment-com

mqb space-site r8
add 1 r8
mqb r8 space-site
st jmp write-space-init
s write-space-com
#init
#com

lqb vs-space rsi
mqb vs-space-site r8
add r8 rsi
mov 5d r9
movs r9 0 rsi
add 1 r8
mqb r8 vs-space-site

lqb vs-space rsi
mqb vs-space-site r8
add r8 rsi
mov a r9
movs r9 0 rsi
add 1 r8
mqb r8 vs-space-site

mov 1 rdi
lqb vs-space rsi
mqb vs-space-site rdx
mov 1 rax
sys

##########################################################################################################
# view-number-com
##########################################################################################################
add 40000 rsp
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
