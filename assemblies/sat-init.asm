#####################################################
# sat | a lived till more to breadth-ist
# sample assembly tech
#####################################################
# params
# ------
# 1 | conditional-mod
#####################################################

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

entree i-sim | i sim. ka tic boo tic but.\n
set 1 rdi
leeve-entree i-sim rsi
set 1b rdx
set 1 rax
syscall

##########################################################################################################
# encode if conditional at inject
##########################################################################################################

auto-quad-source conditional-code
move 80 rsp rax
restore-state
stay-to is-conditional-et $1
set aedaed r9
stay-to is-conditional-lai always
marker is-conditional-et
set aed r9
marker is-conditional-lai
move-quad r9 conditional-code

##########################################################################################################
# zero-stay
##########################################################################################################

auto-quad-source zero-stay
leeve-from 0 rip r8
move-quad r8 zero-stay

##########################################################################################################
# begin load, init, and stay sat-drive.
##########################################################################################################

entree drive-name | secs/sat-drive.secs
auto-quad-source file
auto-quad-source proc-site
auto-quad-source naof-file-secs
# open-read
naoify rsi
leeve-entree drive-name rdi
set 2 rax
syscall
move-quad rax file

# lseek
move-quad-to file rdi
naoify rsi
set 2 rdx
set 8 rax
syscall
move-quad rax naof-file-secs

# file-mmap
naoify rdi
move-quad-to naof-file-secs rsi
set 7 rdx
set 2 r10
move-quad-to file r8
naoify r9
set 9 rax
syscall
move-quad rax proc-site

# close
move-quad-to file rdi
set 3 rax
syscall

move-quad-to conditional-code r11
leeve 0 rsp r13
move-quad-to zero-stay r12
move-quad-to proc-site r15
leeve 3 rip rdx
to-domain

##########################################################################################################
# restore
##########################################################################################################

# munmap
move-quad-to proc-site rdi
move-quad-to naof-file-secs rsi
set b rax
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
