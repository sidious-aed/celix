# params
# ------
# 1 | ocurance-site
# 2 | mm-site

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

entree ocurance-file-name | ocurance.meta
auto-quad-source ocurance-file
auto-quad-source ocurance-site
auto-quad-source zero-stay
leeve-from 0 rip r8
move-quad r8 zero-stay

set 0 rsi
leeve-entree ocurance-file-name rdi
set 2 rax
syscall
move-quad rax ocurance-file

move-quad-to ocurance-file rdi
set 8 rdx
leeve-quad ocurance-site rsi
set 0 rax
syscall

move-quad-to ocurance-file rdi
set 3 rax
syscall
move-quad-to ocurance-site r8
compair-constant $1 r8
stay-to out-of-single-task not-equal

entree i-sim | i sim. ka tic boo tic but.\n
set 1 rdi
leeve-entree i-sim rsi
set 1b rdx
set 1 rax
syscall

set 1000 rdi
mm-to-rack $2
#add-consatn 8 rdi
#mm-to-rack 1

entree file-name | droid/micro.secs
auto-quad-source file

# unlink
leeve-entree file-name rdi
set 57 rax
syscall

# open-write
set 1f8 rdx
set 41 rsi
leeve-entree file-name rdi
set 2 rax
syscall
move-quad rax file

# write
move-quad-to file rdi
set 8 rdx
leeve-quad zero-stay rsi
set 1 rax
syscall

# write
move-quad-to file rdi
set 20 rdx
leeve 1000 rsp rsi
set 1 rax
syscall

# close
move-quad-to file rdi
set 3 rax
syscall

marker out-of-single-task
leeve-entree ocurance-file-name rdi
set 57 rax
syscall

move-quad-to ocurance-site r8
add-constant 1 r8
move-quad r8 ocurance-site

set 1ff rdx
set 41 rsi
leeve-entree ocurance-file-name rdi
set 2 rax
syscall
move-quad rax ocurance-file

move-quad-to ocurance-file rdi
set 8 rdx
leeve-quad ocurance-site rsi
set 1 rax
syscall

move-quad-to ocurance-file rdi
set 3 rax
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
