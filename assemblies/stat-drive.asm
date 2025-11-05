##########################################################################################################
# initialise
##########################################################################################################
sub-constant 10000 rsp
auto-quad-source droid-com-site
move-quad rdx droid-com-site

entree stat-name | droid/root.stat-meta
auto-quad-source entrees-site
auto-quad-source naof-entrees-secs
auto-quad-source equations-site
auto-quad-source naof-equations-secs
auto-quad-source pid
auto-quad-source file
auto-quad-source file2

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

# getpid
naoify rdi
set 27 rax
syscall
move-quad rax pid

##########################################################################################################
# send proc-stat
##########################################################################################################

auto-quad-source stat-proc-name
add-to-rack-site 200
auto-quad-source naof-stat-proc-name-secs

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant bd rsi
leeve-quad stat-proc-name rdi
set 6 rcx
add-constant 271 r15
leeve 3 rip rdx
to-domain

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad stat-proc-name rsi
add-constant 6 rsi
set a rbx
move-quad-to pid rdi
leeve 3 rip rdx
to-domain
set 6 r8
add rax r8
move-quad r8 naof-stat-proc-name-secs

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant 17c rsi
leeve-quad stat-proc-name rdi
move-quad-to naof-stat-proc-name-secs r8
add r8 rdi
set 5 rcx
add rcx r8
move-quad r8 naof-stat-proc-name-secs
add-constant 271 r15
leeve 3 rip rdx
to-domain

leeve-quad stat-proc-name rsi
move-quad-to naof-stat-proc-name-secs r8
add r8 rsi
naoify r9
move-sec-to 0 r9 rsi

set 1 rdi
leeve-quad stat-proc-name rsi
move-quad-to naof-stat-proc-name-secs rdx
set 1 rax
syscall

set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall

# open-read
naoify rsi
leeve-quad stat-proc-name rdi
set 2 rax
syscall
move-quad rax file

# open-write
set 1f8 rdx
set 41 rsi
leeve-entree stat-name rdi
set 2 rax
syscall
move-quad rax file2

marker write-stat-init
# sendfile
move-quad-to file2 rdi
move-quad-to file rsi
naoify rdx
set 1000 r10
set 28 rax
syscall
compair-constant 0 rax
stay-to write-stat-init signed-equal-below
marker write-stat-com

# close
move-quad-to file rdi
set 3 rax
syscall

# close
move-quad-to file2 rdi
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
