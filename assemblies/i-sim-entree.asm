# params
# ------
# 1 | entree
# 2 | naof-entree-secs

back-move-to f4200 rax rsp
back-move-to f41d0 rsp rsp
store-state
sub-constant f4240 rsp
move-to 0 r8 rsp
move-to 8 r9 rsp
move-to 10 r10 rsp
move-to 18 r11 rsp
move-to 20 r12 rsp
move-to 28 r13 rsp
move-to 30 r14 rsp
move-to 38 r15 rsp
move-to 80 rax rsp
move-to 48 rbx rsp
move-to 50 rcx rsp
move-to 58 rdx rsp
move-to 60 rdi rsp
move-to 68 rsi rsp
move-to 78 rbp rsp
add-to-rack-site 88

entree i-sim | $1
set 1 rdi
leeve-entree i-sim rsi
set $2 rdx
set 1 rax
syscall

move 0 rsp r8
move 8 rsp r9
move 10 rsp r10
move 18 rsp r11
move 20 rsp r12
move 28 rsp r13
move 30 rsp r14
move 38 rsp r15
move 80 rsp rax
move 48 rsp rbx
move 50 rsp rcx
move 58 rsp rdx
move 60 rsp rdi
move 68 rsp rsi
move 78 rsp rbp
add-constant f4240 rsp
restore-state
back-move f4200 rsp rax
