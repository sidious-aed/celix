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
auto-quad-source file2
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
auto-quad-source naof-meta-name-init-secs
auto-quad-source proc-maps-name
add-to-rack-site 200
auto-quad-source naof-proc-maps-name-secs
auto-quad-source maps-name
add-to-rack-site 200
auto-quad-source naof-maps-name-secs
auto-quad-source droid-space
add-to-rack-site 200
auto-quad-source naof-droid-space-secs
auto-quad-source naof-write-secs

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

move-quad-to equations-site r15
leeve-quad meta-name rsi
leeve-quad maps-name rdi
move-quad-to naof-meta-name-secs rcx
add-constant 271 r15
leeve 3 rip rdx
to-domain

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant da rsi
leeve-quad maps-name rdi
move-quad-to naof-meta-name-secs r8
add r8 rdi
set a rcx
add rcx r8
move-quad r8 naof-maps-name-secs
add-constant 271 r15
leeve 3 rip rdx
to-domain

leeve-quad maps-name rsi
move-quad-to naof-maps-name-secs r8
add r8 rsi
naoify r8
move-sec-to 0 r8 rsi

set 1 rdi
leeve-quad maps-name rsi
move-quad-to naof-maps-name-secs rdx
set 1 rax
syscall

set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall

move-quad-to naof-meta-name-secs r8
move-quad r8 naof-meta-name-init-secs

##########################################################################################################
# send maps
##########################################################################################################

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant bd rsi
leeve-quad proc-maps-name rdi
set 6 rcx
add-constant 271 r15
leeve 3 rip rdx
to-domain

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad proc-maps-name rsi
add-constant 6 rsi
set a rbx
move-quad-to pid rdi
leeve 3 rip rdx
to-domain
add-constant 6 rax
move-quad rax naof-proc-maps-name-secs

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant c4 rsi
leeve-quad proc-maps-name rdi
move-quad-to naof-proc-maps-name-secs r8
add r8 rdi
set 5 rcx
add rcx r8
move-quad r8 naof-proc-maps-name-secs
add-constant 271 r15
leeve 3 rip rdx
to-domain
leeve-quad proc-maps-name rsi
move-quad-to naof-proc-maps-name-secs r8
add r8 rsi
naoify r9
move-sec-to 0 r9 rsi

set 1 rdi
leeve-quad proc-maps-name rsi
move-quad-to naof-proc-maps-name-secs rdx
set 1 rax
syscall

set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall

#marker open-maps-read-init
# open-read
naoify rsi
leeve-quad proc-maps-name rdi
set 2 rax
syscall
move-quad rax file
#compair-constant 0 rax
#stay-to open-maps-read-init signed-equal-below
#marker open-maps-read-com

# open-write
set 1f8 rdx
set 41 rsi
leeve-quad maps-name rdi
set 2 rax
syscall
move-quad rax file2

marker send-maps-et
# sendfile
move-quad-to file2 rdi
move-quad-to file rsi
naoify rdx
set 1000 r10
set 28 rax
syscall
compair-constant 0 rax
stay-to send-maps-com equal
compair-constant ffffffffffffffff rax
stay-to send-maps-com equal

stay-to send-maps-et always
marker send-maps-com

# close
move-quad-to file rdi
set 3 rax
syscall

# close
move-quad-to file2 rdi
set 3 rax
syscall

# chmod
# clerical/droid note | seems open might not let group write but we can with chmod after
leeve-quad maps-name rdi
set 1f8 rsi
set 5a rax
syscall

##########################################################################################################
# load-maps
##########################################################################################################

auto-quad-source maps-site
auto-quad-source naof-maps-secs
# open-read
naoify rsi
leeve-quad maps-name rdi
set 2 rax
syscall
move-quad rax file

# lseek
move-quad-to file rdi
naoify rsi
set 2 rdx
set 8 rax
syscall
move-quad rax naof-maps-secs

# file-mmap
naoify rdi
move-quad-to naof-maps-secs rsi
set 7 rdx
set 2 r10
move-quad-to file r8
naoify r9
set 9 rax
syscall
move-quad rax maps-site

# close
move-quad-to file rdi
set 3 rax
syscall

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad droid-space rsi
set 10 rbx
move-quad-to naof-maps-secs rdi
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

##########################################################################################################
# get stack-maps
##########################################################################################################

entree droid-stay-name | droid/stay.meta
entree stack-segment-name-com | .stack-segment
auto-quad-source stack-segment-name
add-to-rack-site 200
auto-quad-source naof-stack-segment-name-secs

move-quad-to equations-site r15
leeve-quad meta-name rsi
leeve-quad stack-segment-name rdi
move-quad-to naof-meta-name-secs rcx
add-constant 271 r15
leeve 3 rip rdx
to-domain

auto-quad-source map-site
auto-quad-source site-2
auto-quad-source site-3
auto-quad-source site-4
auto-quad-source origin
auto-quad-source completion
auto-quad-source naof-stack-secs
naoify r8
move-quad r8 map-site
move-quad r8 site
marker stack-maps-init

move-quad-to maps-site r8
move-quad-to site r9
add r9 r8
naoify r10
naoify r11
marker seek-naof-secs-in-map-segment-init
move-sec 0 r8 r10
compair-constant a r10
stay-to seek-naof-secs-in-map-segment-com equal
add-constant 1 r8
add-constant 1 r11
stay-to seek-naof-secs-in-map-segment-init always
marker seek-naof-secs-in-map-segment-com
move-quad r11 site-2

set 1 rdi
move-quad-to maps-site rsi
add r9 rsi
set 1 rdx
add r11 rdx
set 1 rax
syscall

move-quad-to maps-site r8
move-quad-to site r9
add r9 r8
naoify r10
naoify r11
marker seek-naof-secs-in-map-section-init
move-sec 0 r8 r10
compair-constant 2d r10
stay-to seek-naof-secs-in-map-section-com equal
add-constant 1 r8
add-constant 1 r11
stay-to seek-naof-secs-in-map-section-init always
marker seek-naof-secs-in-map-section-com
move-quad r11 site-3

move-quad-to equations-site r15
add-constant 388 r15
move-quad-to maps-site rsi
move-quad-to site r9
add r9 rsi
leeve 0 r11 rcx
set 10 rbx
leeve 3 rip rdx
to-domain
move-quad rax origin

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad droid-space rsi
set 10 rbx
move-quad-to origin rdi
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

move-quad-to maps-site r8
move-quad-to site r9
add r9 r8
move-quad-to site-3 r9
add-constant 1 r9
move-quad r9 site-3
add r9 r8
naoify r10
naoify r11
marker seek-naof-secs-in-map-section-2-init
move-sec 0 r8 r10
compair-constant 20 r10
stay-to seek-naof-secs-in-map-section-2-com equal
add-constant 1 r8
add-constant 1 r11
stay-to seek-naof-secs-in-map-section-2-init always
marker seek-naof-secs-in-map-section-2-com
move-quad r11 site-4

move-quad-to equations-site r15
add-constant 388 r15
move-quad-to maps-site rsi
move-quad-to site r9
add r9 rsi
move-quad-to site-3 r9
add r9 rsi
leeve 0 r11 rcx
set 10 rbx
leeve 3 rip rdx
to-domain
move-quad rax completion

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad droid-space rsi
set 10 rbx
move-quad-to completion rdi
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

move-quad-to origin r8
move-quad-to completion r9
sub r8 r9
move-quad r9 naof-stack-secs

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad droid-space rsi
set 10 rbx
move-quad-to naof-stack-secs rdi
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

move-quad-to site r9
move-quad-to site-2 r10
add r10 r9
add-constant 1 r9
move-quad r9 site

move-quad-to site r9
move-quad-to naof-maps-secs r12
compair r12 r9
stay-to stack-maps-com equal-above

leeve-quad stack-segment-name rsi
move-quad-to naof-meta-name-secs r8
add r8 rsi
set 2e r9
move-sec-to 0 r9 rsi
add-constant 1 r8
move-quad r8 naof-stack-segment-name-secs

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad stack-segment-name rsi
move-quad-to naof-stack-segment-name-secs r8
add r8 rsi
set 10 rbx
move-quad-to map-site rdi
leeve 3 rip rdx
to-domain
move-quad-to naof-stack-segment-name-secs r8
add rax r8
move-quad r8 naof-stack-segment-name-secs

move-quad-to equations-site r15
leeve-entree stack-segment-name-com rsi
leeve-quad stack-segment-name rdi
move-quad-to naof-stack-segment-name-secs r8
add r8 rdi
set e rcx
add rcx r8
move-quad r8 naof-stack-segment-name-secs
add-constant 271 r15
leeve 3 rip rdx
to-domain

leeve-quad stack-segment-name rsi
move-quad-to naof-stack-segment-name-secs r8
add r8 rsi
naoify r8
move-sec-to 0 r8 rsi

set 1 rdi
leeve-quad stack-segment-name rsi
move-quad-to naof-stack-segment-name-secs rdx
set 1 rax
syscall

set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall

# open-write
set 1f8 rdx
set 41 rsi
leeve-entree droid-stay-name rdi
set 2 rax
syscall
move-quad rax file

# write
move-quad-to file rdi
leeve-quad stack-segment-name rsi
move-quad-to naof-stack-segment-name-secs rdx
set 1 rax
syscall

# close
move-quad-to file rdi
set 3 rax
syscall

# open-write
set 1f8 rdx
set 41 rsi
leeve-quad stack-segment-name rdi
set 2 rax
syscall
move-quad rax file

# write
move-quad-to file rdi
move-quad-to origin rsi
move-quad-to naof-stack-secs rdx
set 1 rax
syscall

# close
move-quad-to file rdi
set 3 rax
syscall
#init
#com

move-quad-to map-site r8
add-constant 1 r8
move-quad r8 map-site

stay-to stack-maps-init always
marker stack-maps-com

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

# munmap
move-quad-to maps-site rdi
move-quad-to naof-maps-secs rsi
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
