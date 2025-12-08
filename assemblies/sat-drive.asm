#####################################################
# params
# ------
# 1 | is-naof-aux
# 2 | aux-rack-site
# 3 | aux-naof-rack-site
# 4 | naof-per-aux
# 5 | aux-is-cast
#####################################################

##########################################################################################################
# initialise
##########################################################################################################
sub-constant 10000 rsp
auto-quad-source conditional-code
move-quad r11 conditional-code
auto-quad-source zero-stay
move-quad r12 zero-stay
auto-quad-source rack-site
move-quad r13 rack-site
auto-quad-source droid-com-site
move-quad rdx droid-com-site

auto-quad-source droid-site
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
auto-quad-source naof-sample-secs
auto-quad-source meta-name
add-to-rack-site 200
auto-quad-source naof-meta-name-secs
auto-quad-source naof-meta-name-init-secs
auto-quad-source try-name
add-to-rack-site 200
auto-quad-source naof-try-name-secs
auto-quad-source files-name
add-to-rack-site 200
auto-quad-source naof-files-name-secs
auto-quad-source proc-maps-name
add-to-rack-site 200
auto-quad-source naof-proc-maps-name-secs
auto-quad-source maps-name
add-to-rack-site 200
auto-quad-source naof-maps-name-secs
auto-quad-source site-map-name
add-to-rack-site 200
auto-quad-source files-node
add-to-rack-site 200
auto-quad-source naof-files-node-secs
auto-quad-source manafest-space
add-to-rack-site 500
auto-quad-source naof-manafest-space-secs
auto-quad-source naof-manafest-record-secs
auto-quad-source source-site
auto-quad-source type-code
auto-quad-source source-name
add-to-rack-site 200
auto-quad-source naof-manafest-source-secs
auto-quad-source link-name
add-to-rack-site 500
auto-quad-source naof-link-name-secs
auto-quad-source droid-space
add-to-rack-site 200
auto-quad-source droid-space-2
add-to-rack-site 200
auto-quad-source naof-droid-space-secs
auto-quad-source naof-write-secs
auto-quad-source is-space
auto-quad-source droid-is-from-quad
auto-quad-source droid-arith-mode-quad
auto-quad-source droid-site-quad
auto-quad-source droid-cast-mode-quad
auto-quad-source droid-naof-secs-quad
auto-quad-source droid-rack-site
auto-quad-source droid-is-new-mode
auto-quad-source droid-is-castable
entree map-secs-com-name | droid/map-secs.com
auto-quad-source ms-segment-site
auto-quad-source ms-naof-secs
auto-quad-source map-secs-site
auto-quad-source map-secs-stack-site

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
# request droid section
##########################################################################################################

# anonomous-mmap
naoify rdi
set f4240 rsi
set 7 rdx
set 22 r10
naoify r9
naoify r8
set 9 rax
syscall
move-quad rax droid-site

entree i-sim | i sim. ka tic boo tic but.\n
set 1 rdi
leeve-entree i-sim rsi
set 1b rdx
set 1 rax
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
#init
#com

move-quad-to equations-site r15
leeve-quad meta-name rsi
leeve-quad try-name rdi
move-quad-to naof-meta-name-secs rcx
add-constant 271 r15
leeve 3 rip rdx
to-domain

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant d0 rsi
leeve-quad try-name rdi
move-quad-to naof-meta-name-secs r8
add r8 rdi
set 9 rcx
add rcx r8
move-quad r8 naof-try-name-secs
add-constant 271 r15
leeve 3 rip rdx
to-domain

leeve-quad try-name rsi
move-quad-to naof-try-name-secs r8
add r8 rsi
naoify r8
move-sec-to 0 r8 rsi

set 1 rdi
leeve-quad try-name rsi
move-quad-to naof-try-name-secs rdx
set 1 rax
syscall

set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall

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

move-quad-to equations-site r15
leeve-quad meta-name rsi
leeve-quad site-map-name rdi
move-quad-to naof-meta-name-secs rcx
add-constant 271 r15
leeve 3 rip rdx
to-domain

move-quad-to equations-site r15
leeve-quad meta-name rsi
leeve-quad files-name rdi
move-quad-to naof-meta-name-secs rcx
add-constant 271 r15
leeve 3 rip rdx
to-domain

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant e5 rsi
leeve-quad files-name rdi
move-quad-to naof-meta-name-secs r8
add r8 rdi
set b rcx
add rcx r8
move-quad r8 naof-files-name-secs
add-constant 271 r15
leeve 3 rip rdx
to-domain

leeve-quad files-name rsi
move-quad-to naof-files-name-secs r8
add r8 rsi
naoify r8
move-sec-to 0 r8 rsi

set 1 rdi
leeve-quad files-name rsi
move-quad-to naof-files-name-secs rdx
set 1 rax
syscall

set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant b2 rsi
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
naoify r8
move-sec-to 0 r8 rsi

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

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant bd rsi
leeve-quad files-node rdi
set 6 rcx
add-constant 271 r15
leeve 3 rip rdx
to-domain

move-quad-to equations-site r15
add-constant 1 r15
leeve-quad files-node rsi
add-constant 6 rsi
set a rbx
move-quad-to pid rdi
leeve 3 rip rdx
to-domain
add-constant 6 rax
move-quad rax naof-files-node-secs

move-quad-to equations-site r15
move-quad-to entrees-site rsi
add-constant ca rsi
leeve-quad files-node rdi
move-quad-to naof-files-node-secs r8
add r8 rdi
set 3 rcx
add rcx r8
move-quad r8 naof-files-node-secs
add-constant 271 r15
leeve 3 rip rdx
to-domain

set 1 rdi
leeve-quad files-node rsi
move-quad-to naof-files-node-secs rdx
set 1 rax
syscall

set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall

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
# parse files-node
##########################################################################################################

leeve-quad files-node rdi
move-quad-to naof-files-node-secs r8
add r8 rdi
naoify r9
move-sec-to 0 r9 rdi
# open-read
naoify rsi
leeve-quad files-node rdi
set 2 rax
syscall
move-quad rax file

# open-write
set 1f8 rdx
set 41 rsi
leeve-quad files-name rdi
set 2 rax
syscall
move-quad rax file2

marker parse-manafest-et

naoify r8
naoify r9
leeve-quad manafest-space rsi
marker naoify-manafest-space-et
move-to 0 r9 rsi
add-constant 8 rsi
add-constant 1 r8
compair-constant a0 r8
stay-to naoify-manafest-space-et not-equal

# getdents
move-quad-to file rdi
leeve-quad manafest-space rsi
set 500 rdx
set 4e rax
syscall
move-quad rax naof-manafest-space-secs

#init
move-quad-to equations-site r15
add-constant 1 r15
leeve-quad droid-space rsi
set 10 rbx
move-quad-to naof-manafest-space-secs rdi
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

move-quad-to naof-manafest-space-secs rax
compair-constant 0 rax
stay-to parse-manafeset-com equal
compair-constant ffffffffffffffff rax
stay-to parse-manafeset-com equal

naoify r8
move-quad r8 site
marker parse-segment-init

move-quad-to site r8
move-quad-to naof-manafest-space-secs r9
compair r9 r8
stay-to parse-segment-com equal-above

leeve-quad manafest-space r9
move-quad-to site r8
add-constant 10 r8
add r8 r9
move 0 r9 r10
set ffff r11
and r11 r10
move-quad r10 naof-manafest-record-secs

secs 90
leeve-quad manafest-space r9
move-quad-to site r12
add-constant 12 r12
move-quad r12 source-site
add r12 r9
naoify r11
move-quad r11 naof-manafest-source-secs
marker seek-naof-source-secs-et
move-sec 0 r9 r10

compair-constant 0 r10
stay-to seek-naof-source-secs-com equal
add-constant 1 r9
add-constant 1 r11
stay-to seek-naof-source-secs-et always
marker seek-naof-source-secs-com
move-quad r11 naof-manafest-source-secs
secs 90
#init
#com

leeve-quad manafest-space rsi
move-quad-to site r8
add r8 rsi
move-quad-to naof-manafest-record-secs r8
add r8 rsi
sub-constant 1 rsi
naoify r8
move-sec 0 rsi r8
move-quad r8 type-code

move-quad-to type-code r8
compair-constant a r8
stay-to not-a-link-type not-equal

move-quad-to equations-site r15
leeve-quad manafest-space rsi
move-quad-to source-site r12
add r12 rsi
leeve-quad source-name rdi
move-quad-to naof-manafest-source-secs rcx
add-constant 271 r15
leeve 3 rip rdx
to-domain

set 1 rdi
leeve-quad source-name rsi
move-quad-to naof-manafest-source-secs rdx
set 1 rax
#syscall

set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
#syscall

# linkname-at
move-quad-to file rdi
leeve-quad source-name rsi
leeve-quad link-name rdx
set 500 r10
set 10b rax
syscall
move-quad rax naof-link-name-secs

set 1 rdi
leeve-quad link-name rsi
move-quad-to naof-link-name-secs rdx
set 1 rax
#syscall

set 1 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
#syscall

# write
move-quad-to file2 rdi
leeve-quad manafest-space rsi
move-quad-to source-site r8
add r8 rsi
move-quad-to naof-manafest-source-secs rdx
set 1 rax
syscall

# write
move-quad-to file2 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall

# write
move-quad-to file2 rdi
leeve-quad link-name rsi
move-quad-to naof-link-name-secs rdx
set 1 rax
syscall

# write
move-quad-to file2 rdi
move-quad-to entrees-site rsi
add-constant ce rsi
set 1 rdx
set 1 rax
syscall
#init
#com
marker not-a-link-type

move-quad-to site r8
move-quad-to naof-manafest-record-secs r9
add r9 r8
move-quad r8 site
stay-to parse-segment-init always
marker parse-segment-com

stay-to parse-manafest-et always
marker parse-manafeset-com
#init
#com

# close
move-quad-to file rdi
set 3 rax
syscall

# close
move-quad-to file2 rdi
set 3 rax
syscall

# chmod
leeve-quad files-name rdi
set 1f8 rsi
set 5a rax
syscall

##########################################################################################################
# sample registers
##########################################################################################################

entree i-sim | i sim. ka tic boo tic but.\n
set 1 rdi
leeve-entree i-sim rsi
set 1b rdx
set 1 rax
#syscall

#init
secs 90 90 90
move-quad-to equations-site r15
add-constant 1 r15
leeve-quad droid-space rsi
set 10 rbx
move-quad-to droid-site rdi
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
secs 90 90 90
#com

move-quad-to equations-site r15
add-constant 271 r15
move-quad-to rack-site rsi
move-quad-to droid-site rdi
#add-constant 8 rdi
set 80 rcx
move-quad rcx naof-sample-secs
leeve 3 rip rdx
to-domain
set 80 r8
move-quad r8 naof-sample-secs

##########################################################################################################
# zero-stay and is-conditional
##########################################################################################################

move-quad-to droid-site rdi
move-quad-to naof-sample-secs r8
add r8 rdi
move-quad-to zero-stay rax
move-to 0 rax rdi
add-constant 8 r8
move-quad r8 naof-sample-secs

move-quad-to droid-site rdi
move-quad-to naof-sample-secs r8
add r8 rdi
move-quad-to conditional-code r9
move-to 0 r9 rdi
add-constant 8 r8
move-quad r8 naof-sample-secs

##########################################################################################################
# sample register spaces
##########################################################################################################

# unlink
leeve-quad try-name rdi
set 57 rax
syscall

# open-write
set 1f8 rdx
set 41 rsi
leeve-quad try-name rdi
set 2 rax
syscall
move-quad rax file2

naoify r8
move-quad r8 site
marker register-spaces-et

# write
move-quad-to file2 rdi
move-quad-to rack-site rsi
move-quad-to site r8
add r8 rsi
move 0 rsi rsi
set 40 rdx
set 1 rax
syscall
move-quad rax naof-write-secs

move-quad-to naof-write-secs rax
set ffffffffffffffff r8
compair-constant 40 rax
stay-to is-space-sign-com not-equal
marker is-space-sign-init
set 40 r8
marker is-space-sign-com
move-quad r8 naof-write-secs

move-quad-to droid-site rdi
move-quad-to naof-sample-secs r8
add r8 rdi
move-quad-to naof-write-secs rax
move-to 0 rax rdi
add-constant 8 r8
move-quad r8 naof-sample-secs

move-quad-to naof-write-secs rax
compair-constant 40 rax
stay-to seems-not-space not-equal
secs 90

move-quad-to equations-site r15
move-quad-to rack-site rsi
move-quad-to site r8
add r8 rsi
move 0 rsi rsi
move-quad-to droid-site rdi
move-quad-to naof-sample-secs r8
add r8 rdi
set 40 rcx
add rcx r8
move-quad r8 naof-sample-secs
add-constant 271 r15
leeve 3 rip rdx
to-domain
marker seems-not-space

move-quad-to site r8
add-constant 8 r8
move-quad r8 site
compair-constant 80 r8
stay-to register-spaces-et not-equal
marker register-spacces-lai

##########################################################################################################
# sample auxillery spaces
##########################################################################################################

entree aux-spaces-request-name | droid/aux-spaces.request
auto-quad-source register-rack-site
auto-quad-source naof-moves
auto-quad-source move-site
auto-quad-source is-cast
auto-quad-source naof-aux-space-secs
auto-quad-source droid-scan-site
# open-read
naoify rsi
leeve-entree aux-spaces-request-name rdi
set 2 rax
syscall
compair-constant 0 rax
stay-to sample-aux-spaces-com signed-equal-below
move-quad rax file

marker aux-spaces-requests-init
# read
move-quad-to file rdi
set 10 rdx
leeve-quad register-rack-site rsi
set 0 rax
syscall
compair-constant 10 rax
stay-to aux-spaces-requests-com not-equal

move-quad-to register-rack-site r8
compair-constant aed r8
stay-to move-is-zero-stay-based-com not-equal
move-quad-to zero-stay r8
move-quad r8 droid-scan-site
stay-to move-is-not-zero-stay-based-com always
marker move-is-zero-stay-based-com
move-quad-to rack-site r9
add r9 r8
move 0 r8 r8
move-quad r8 droid-scan-site
marker move-is-not-zero-stay-based-com

naoify r8
move-quad r8 site
marker aux-spaces-moves-init
move-quad-to site r8
move-quad-to naof-moves r9
compair r8 r9
stay-to aux-spaces-moves-drive equal
add-constant 1 r8
move-quad r8 site

# read
move-quad-to file rdi
set 10 rdx
leeve-quad move-site rsi
set 0 rax
syscall

move-quad-to droid-scan-site r8
move-quad-to move-site r9
add r9 r8
move-quad r8 droid-scan-site
move-quad-to is-cast r10
compair-constant 1 r10
stay-to aux-spaces-move-cast-com not-equal

# write
move-quad-to file2 rdi
move-quad-to droid-scan-site rsi
set 8 rdx
set 1 rax
syscall
compair-constant 8 rax
stay-to aux-spaces-not-naof-secs-requested-init not-equal

move-quad-to droid-scan-site r8
move 0 r8 r8
move-quad r8 droid-scan-site

marker aux-spaces-move-cast-com
stay-to aux-spaces-moves-init always

marker aux-spaces-moves-drive
# read
move-quad-to file rdi
set 8 rdx
leeve-quad naof-aux-space-secs rsi
set 0 rax
syscall

# write
move-quad-to file2 rdi
move-quad-to droid-scan-site rsi
move-quad-to naof-aux-space-secs rdx
set 1 rax
syscall
move-quad rax site
move-quad-to naof-aux-space-secs rdx

move-quad-to site rax
move-quad-to naof-aux-space-secs rdx
compair rdx rax
stay-to aux-spaces-not-naof-secs-requested-init not-equal

move-quad-to droid-site rdi
move-quad-to naof-sample-secs r8
add r8 rdi
move-quad-to naof-aux-space-secs r9
move-to 0 r9 rdi
add-constant 8 r8
move-quad r8 naof-sample-secs

move-quad-to droid-site rdi
move-quad-to naof-sample-secs r8
add r8 rdi
move-quad-to droid-scan-site r9
move-to 0 r9 rdi
add-constant 8 r8
move-quad r8 naof-sample-secs

move-quad-to equations-site r15
add-constant 271 r15
move-quad-to droid-scan-site rsi
move-quad-to droid-site rdi
move-quad-to naof-sample-secs r8
add r8 rdi
move-quad-to naof-aux-space-secs rcx
add rcx r8
move-quad r8 naof-sample-secs
leeve 3 rip rdx
to-domain
stay-to aux-spaces-not-naof-secs-requested-com always

marker aux-spaces-not-naof-secs-requested-init
move-quad-to droid-site rdi
move-quad-to naof-sample-secs r8
add r8 rdi
set ffffffffffffffff r9
move-to 0 r9 rdi
add-constant 8 r8
move-quad r8 naof-sample-secs
marker aux-spaces-not-naof-secs-requested-com

marker aux-spaces-moves-com
stay-to aux-spaces-requests-init always
marker aux-spaces-requests-com

# close
move-quad-to file rdi
set 3 rax
syscall
marker sample-aux-spaces-com

##########################################################################################################
# sample naof-register
##########################################################################################################

auto-quad-source aux-space-site
auto-quad-source aux-space-leeve-site
marker sample-naof-register-init
set $1 r8
compair-constant 1 r8
stay-to sample-naof-register-com not-equal

move-quad-to rack-site r8
set $2 r10
compair-constant aed r10
stay-to not-leave-without-from not-equal
naoify r8
stay-to from-register-com always
marker not-leave-without-from
add r10 r8
move 0 r8 r8
marker from-register-com
move-quad-to rack-site rax
set $3 r10
add r10 rax
move 0 rax rax

auto-quad-source naof-per-aux
set $4 r10
move-quad r10 naof-per-aux
multiply-by-quad naof-per-aux
add rax r8
move-quad r8 aux-space-leeve-site

set $5 r9
compair-constant 1 r9
stay-to aux-space-cast-com not-equal
move 0 r8 r8
move-quad r8 aux-space-site
marker aux-space-cast-com
move-quad r8 aux-space-site

# write
move-quad-to file2 rdi
move-quad-to aux-space-leeve-site rsi
set 40 rdx
set 1 rax
syscall
compair-constant 40 rax
stay-to sample-naof-register-com not-equal

move-quad-to droid-site rdi
move-quad-to naof-sample-secs r10
add r10 rdi
move-quad-to aux-space-site r8
move-to 0 r8 rdi
add-constant 8 r10
move-quad r10 naof-sample-secs

move-quad-to equations-site r15
add-constant 271 r15
move-quad-to aux-space-leeve-site rsi
move-quad-to droid-site rdi
move-quad-to naof-sample-secs r8
add r8 rdi
set 40 rcx
add rcx r8
move-quad r8 naof-sample-secs
leeve 3 rip rdx
to-domain

marker sample-naof-register-com

# close
move-quad-to file2 rdi
set 3 rax
syscall

##########################################################################################################
# write samplage to com
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
move-quad-to naof-sample-secs rdx
move-quad-to droid-site rsi
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

# munmap
move-quad-to droid-site rdi
set f4240 rsi
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
