##########################################################################################################
# view-number
##########################################################################################################
# rsi | relay
# rdi | number
# rbx | base
# rdx | equations
% equations
##########################################################################################################
# view-number-init
##########################################################################################################
push rbp
mov rsp rbp
sub 1000 rsp
aqs relay
mqb rsi relay
aqs number
mqb rdi number
aqs base
mqb rbx base
aqs equations
mqb rdx equations
aqs vn-entree
isr 500
aqs vn-entree-site
nao r8
mqb r8 vn-entree-site

aqs naof-relay-secs
mqb relay rdi
mqb equations r15
addc equations get-naof-secs r15
dct r15
mqb rax naof-relay-secs
mqb rax vn-entree-site

mqb relay rsi
lqb vn-entree rdi
mqb naof-relay-secs rcx
mqb equations r11
addc equations com r11
dct r11

entb jedao-sectioner  | 
aqs naof-jedao-sectioner-secs
mov 3 r8
mqb r8 naof-jedao-sectioner-secs

lentb jedao-sectioner rsi
lqb vn-entree rdi
mqb vn-entree-site r8
add r8 rdi
mqb naof-jedao-sectioner-secs rcx
add rcx r8
mqb r8 vn-entree-site
mqb equations r11
addc equations com r11
dct r11

mqb number rdi
lqb vn-entree rsi
mqb vn-entree-site r8
add r8 rsi
mqb base rbx
mqb equations r8
addc equations number-to-entree r8
dct r8
mqb vn-entree-site r8
add rax r8
mqb r8 vn-entree-site
lqb vn-entree rsi
add r8 rsi
mov a r9
movs r9 0 rsi
add 1 r8
mqb r8 vn-entree-site

mov 1 rdi
lqb vn-entree rsi
mqb vn-entree-site rdx
mov 1 rax
sys
#init
#com

##########################################################################################################
# view-number-com
##########################################################################################################
add 1000 rsp
pop rbp
ret
#init
#com
