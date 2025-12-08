#####################################################
# params
# ------
#####################################################

##########################################################################################################
# initialise
##########################################################################################################
sub-constant 10000 rsp
auto-quad-source rack-site
move-quad r13 rack-site
auto-quad-source droid-com-site
move-quad rdx droid-com-site

auto-quad-source entrees-site
auto-quad-source naof-entrees-secs
auto-quad-source equations-site
auto-quad-source naof-equations-secs
auto-quad-source file
auto-quad-source pid
auto-quad-source naof-sequences-wide
auto-quad-source naof-sequences-precise
auto-quad-source naof-seconds
auto-quad-source naof-micro-seconds
auto-quad-source zones-1
auto-quad-source zones-2
auto-quad-source site
auto-quad-source meta-name
add-to-rack-site 200
auto-quad-source naof-meta-name-secs
auto-quad-source droid-space
add-to-rack-site 200
auto-quad-source naof-droid-space-secs

##########################################################################################################
# request entrees section
##########################################################################################################

entree entrees-file-name | charts/entrees/core.rack
# open-read
naoify rsi
leeve-entree entrees-file-name rdi
set 2 rax
syscall
move-quad rax file

# lseek
move-quad-to file rdi
naoify rsi
set 2 rdx
set 8 rax
syscall
move-quad rax naof-entrees-secs

# file-mmap
naoify rdi
move-quad-to naof-entrees-secs rsi
set 7 rdx
set 2 r10
move-quad-to file r8
naoify r9
set 9 rax
syscall
move-quad rax entrees-site

# close
move-quad-to file rdi
set 3 rax
syscall

##########################################################################################################
# request equations section
##########################################################################################################

entree equations-file-name | secs/equations.secs
# open-read
naoify rsi
leeve-entree equations-file-name rdi
set 2 rax
syscall
move-quad rax file

# lseek
move-quad-to file rdi
naoify rsi
set 2 rdx
set 8 rax
syscall
move-quad rax naof-equations-secs

# file-mmap
naoify rdi
move-quad-to naof-equations-secs rsi
set 7 rdx
set 2 r10
move-quad-to file r8
naoify r9
set 9 rax
syscall
move-quad rax equations-site

# close
move-quad-to file rdi
set 3 rax
syscall

##########################################################################################################
# init file (sources|names)
##########################################################################################################

# gettimeofday
leeve-quad naof-seconds rdi
leeve-quad zones-1 rsi
set 60 rax
syscall

# getpid
naoify rdi
set 27 rax
syscall
move-quad rax pid

naof-thread-sequences
move-quad rdx naof-sequences-wide
move-quad rax naof-sequences-precise

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant ab rsi
leeve-quad meta-name rdi
set 6 rcx
add-constant 271 r15
leeve 3 rip rdx
to-domain

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad meta-name rsi
add-constant 6 rsi
set 10 rbx
move-quad-to pid rdi
leeve 3 rip rdx
to-domain
add-constant 6 rax
leeve-quad meta-name rsi
add rax rsi
set 2e r8
move-sec-to 0 r8 rsi
add-constant 1 rax
move-quad rax naof-meta-name-secs

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad meta-name rsi
move-quad-to naof-meta-name-secs r8
add r8 rsi
set 10 rbx
move-quad-to naof-seconds rdi
leeve 3 rip rdx
to-domain
move-quad-to naof-meta-name-secs r8
add r8 rax
leeve-quad meta-name rsi
add rax rsi
set 2e r8
move-sec-to 0 r8 rsi
add-constant 1 rax
move-quad rax naof-meta-name-secs

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad meta-name rsi
move-quad-to naof-meta-name-secs r8
add r8 rsi
set 10 rbx
move-quad-to naof-micro-seconds rdi
leeve 3 rip rdx
to-domain
move-quad-to naof-meta-name-secs r8
add r8 rax
leeve-quad meta-name rsi
add rax rsi
set 2e r8
move-sec-to 0 r8 rsi
add-constant 1 rax
move-quad rax naof-meta-name-secs

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad meta-name rsi
move-quad-to naof-meta-name-secs r8
add r8 rsi
set 10 rbx
move-quad-to naof-sequences-wide rdi
leeve 3 rip rdx
to-domain
move-quad-to naof-meta-name-secs r8
add r8 rax
leeve-quad meta-name rsi
add rax rsi
set 2e r8
move-sec-to 0 r8 rsi
add-constant 1 rax
move-quad rax naof-meta-name-secs

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad meta-name rsi
move-quad-to naof-meta-name-secs r8
add r8 rsi
set 10 rbx
move-quad-to naof-sequences-precise rdi
leeve 3 rip rdx
to-domain
move-quad-to naof-meta-name-secs r8
add r8 rax
move-quad rax naof-meta-name-secs

entree rack-init-com | .rack-init
move-quad-to equations-site r15
leeve-entree rack-init-com rsi
leeve-quad meta-name rdi
move-quad-to naof-meta-name-secs r8
add r8 rdi
set a rcx
add rcx r8
move-quad r8 naof-meta-name-secs
add-constant 271 r15
leeve 3 rip rdx
to-domain

leeve-quad meta-name rsi
move-quad-to naof-meta-name-secs r8
add r8 rsi
naoify r9
move-sec-to 0 r9 rsi

set 1 rdi
leeve-quad meta-name rsi
move-quad-to naof-meta-name-secs rdx
set 1 rax
syscall

set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall

##########################################################################################################
# write rack-init
##########################################################################################################

# open-write
set 1f8 rdx
set 41 rsi
leeve-quad meta-name rdi
set 2 rax
syscall
move-quad rax file

# write
move-quad-to file rdi
set 8 rdx
move-quad-to rack-site rsi
add-constant 70 rsi
set 1 rax
syscall

# close
move-quad-to file rdi
set 3 rax
syscall

##########################################################################################################
# restore
##########################################################################################################

# munmap
move-quad-to entrees-site rdi
move-quad-to naof-entrees-secs rsi
set b rax
syscall

# munmap
move-quad-to equations-site rdi
move-quad-to naof-equations-secs rsi
set b rax
syscall

##########################################################################################################
# back to domain
##########################################################################################################

move-quad-to droid-com-site rdx
add-constant 10000 rsp
domain-back

#init
move-quad-to equations-site r15
add-constant 1 r15
leeve-quad droid-space rsi
set a rbx
move-quad-to file2 rdi
leeve 3 rip rdx
to-domain
set 1 rdi
leeve-quad droid-space rsi
leeve 0 rax rdx
set 1 rax
syscall
set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall
#com
