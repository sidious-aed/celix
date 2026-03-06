##########################################################################################################
# com
##########################################################################################################
# rsi | entree
# rcx | naof-secs
# rbx | base
##########################################################################################################
# com-init
##########################################################################################################
push rbp
mov rsp rbp
sub 1000 rsp
aqs entree
mqb rsi entree
aqs naof-secs
mqb rcx naof-secs
aqs base
mqb rbx base
aqs esite
sub 1 rcx
mqb rcx esite
aqs number
nao r8
mqb r8 number

#init
entb jsec \n
mov 1 rdi
mqb entree rsi
mqb naof-secs rdx
mov 1 rax
sys
mov 1 rdi
lentb jsec rsi
mov 1 rdx
mov 1 rax
sys
#com

aqs sec0
aqs focus
mov 1 r8
mqb r8 focus
s clerical-entree-to-number-init
	nao r9
	mqb entree rsi
	mqb esite r8
	add r8 rsi
	movs 0 rsi r9
	mqb r9 sec0


	mqb sec0 r9
	cmp 39 r9
	st ja scope-a-com
	sub 30 r9
	st jmp scopes-com
	s scope-a-com
	sub 57 r9
	s scopes-com
	mqb r9 sec0

	mqb sec0 r9
	factqb focus r9
	mqb number r10
	add r9 r10
	mqb r10 number

	mqb focus r11
	factqb base r11
	mqb r11 focus

	mqb esite r12
	cmp 0 r12
	st je clerical-entree-to-number-com
	sub 1 r12
	mqb r12 esite
	st jmp clerical-entree-to-number-init
s clerical-entree-to-number-com
#init
#com

##########################################################################################################
# com-com
##########################################################################################################
mqb number rax
add 1000 rsp
pop rbp
ret

#init
aqs file
entb fn droid/clerk-com.secs
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
mq rax file
# write
mqb file rdi
mov 8 rdx
lqb sec0 rsi
mov 1 rax
sys
# close
mqb file rdi
mov 3 rax
sys
#com
