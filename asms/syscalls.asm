auto-quad-source stead-seconds
auto-quad-source stead-micro-seconds
auto-quad-source naof-seconds
auto-quad-source naof-micro-seconds
auto-quad-source pid
auto-quad-source dso-site
auto-quad-source file
auto-quad-source source-file
auto-quad-source site
auto-quad-source proc-site
auto-quad-source naof-source-secs
auto-quad-source destination-file
auto-quad-source zones-1
auto-quad-source zones-2
auto-quad-source proc-files-node
add-to-rack-site 200
auto-quad-source link-name
add-to-rack-site 200
auto-quad-source naof-link-secs
entree file-name | charts/aeoliaon.chart
entree i-sim | i sim. ka tic boo tic but.\n
auto-quad-source clerk-space
add-to-rack-site 200
auto-quad-source pts-meta-space
auto-quad-source meta

# nanosleep
leeve-quad stead-seconds rdi
set 23 rax
syscall

# open-read
naoify rsi
leeve-entree file-name rdi
set 2 rax
syscall
move-quad rax file

# read
move-quad-to file rdi
set 8 rdx
leeve-quad clerk-space rsi
set 0 rax
syscall

# close
move-quad-to file rdi
set 3 rax
syscall

# fork
marker init-chirp-clerk
set 39 rax
syscall
auto-quad-source pid
move-quad rax pid

# wait4
naoify rdx
naoify rsi
set ffffffffffffffff rdi
set 3d rax
syscall

# wait4
naoify rdi
set 3d rax
syscall

# exit
naoify rdi
set 3c rax
syscall

# print
leeve-entree i-sim rsi
set 1b rdx
set 1 rdi
set 1 rax
syscall

# open-append
set 1ff rdx
set 441 rsi
leeve-entree file-name rdi
set 2 rax
syscall
move-quad rax file

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
leeve-quad clerk-space rsi
set 1 rax
syscall

# close
move-quad-to file rdi
set 3 rax
syscall

# arch_prctl
set 9e rax
# 1002 | set fs
# 1003 | get fs
# 1001 | set gc
# 1004 | get gs
set 1003 rdi
leeve-quad dso-site rsi
syscall

# brk
set 0 rdi
set c rax
syscall
add-constant 20000 rax
leeve 0 rax rdi
set c rax
syscall

# mprotect
# rdi | stack-site
# rsi | distance
# rdx | permsions-code
move-from-rack 40 rdi
set 20000 rsi
set 7 rdx
set a rax
syscall

# unlink
leeve-entree file-name rdi
set 57 rax
syscall

# lseek
move-quad-to file rdi
move-quad-to site rsi
# 0 | seek-origin
# 2 | seek-completion
set 2 rdx
set 8 rax
syscall

# anonomous-mmap
naoify rdi
set 100000 rsi
set 7 rdx
set 22 r10
naoify r9
naoify r8
set 9 rax
syscall
move-quad rax proc-site

# file-mmap
naoify rdi
set 100000 rsi
set 7 rdx
set 2 r10
move-quad-to file r8
naoify r9
set 9 rax
syscall
move-quad rax proc-site

# munmap
move-quad-to meta rdi
set f4240 rsi
set b rax
syscall

# sendfile
move-quad-to source-file rsi
move-quad-to naof-source-secs rdx
move-quad-to destination-file rdi
set 28 rax
syscall

# getpid
set 27 rax
syscall
move-quad rax pid

# getcwd
leeve-quad clerk-space rdi
set 50 rsi
sef 4f rax
syscall

# gettimeofday
leeve-quad naof-seconds rdi
leeve-quad zones-1 rsi
set 60 rax
syscall

# clone
#naoify rdi
set 100011 rdi
leeve-quad pid rdx
naoify rsi
set 38 rax
syscall
#move-quad rax pid
compair-constant 0 rax
# stead-stay-init-droid and stay-stead (on not-zero) droids
stay-to stay-stead-init equal

# clerical note | readlink does not seem to work good for /proc and maybe more; so, stat instead
# readlink
leeve-quad proc-files-node rdi
leeve-quad link-name rsi
set 200 rdx
set 3b rax
syscall
move-quad rax naof-link-secs

# ioctl | naof-rows, and naof-cols
naoify rdi
set 5413 rsi
leeve-quad pts-meta-space rdx
set 10 rax
syscall
marker stay-stead-init
