secs 90
back-stay-to mm-section
naof-secs 10 90
motion-stay 123 always
stay-to completion equal
add-to-rack-site 400
quad-source site 10
auto-quad-source page-site
move-quad-to site r8
move-quad-to page-site r9
move-quad r8 site
move-quad r9 page-site
store-state
restore-state
set aedaed r8
set ff00ff r9
and r8 r9
move 0 r8 rsi
set aed r13
leeve aed rip r14
move 234fe0 rip r14
move-to 234fe0 r14 rip
leeve 100 rsp rbx
move 40 rsp rcx
move-to 40 rcx rsp
set aed rdx
add-constant aed rdx
sub-constant aed rdx
sub-constant 1000 rsp
add-constant 1000 rsp
naoify r10
add r11 r12
sub r13 r14
compair r8 r15
compair-constant aed r13
set 1000 rax
set a rbx
move-to 10 rbx rsp
divide 10
multiply 10
entree i-sim | i sim. ka tic boo tic but.\n
entree i-sim-short | i sim.\n
naoify r8
move-to 20 r8 rsp
marker i-sim-unix
move 20 rsp r8
compair-constant a r8
stay-to completion equal
add-constant 1 r8
move-to 20 r8 rsp
leeve-entree i-sim-short rsi
set 7 rdx
set 1 rdi
set 1 rax
syscall
stay-to i-sim-unix always
marker completion
move-to 200 rax rsp
stay-from-rack 200
naoify r8
naoify r9
quad-source site 10
quad-source naof-leads 18
move-quad r8 site
move-quad r9 naof-leads
move-quad-to site r8
move-quad-to naof-leads r9
add-to-rack-site 8
auto-quad-source naof-pages
move-quad-to naof-pages r10
move-quad r10 naof-pages
leeve-quad naof-pages r11
leeve-from 234fe0 rip r15
move-sec 0 rsi r8
move-sec-to 0 rsi r8
naof-secs 10 90
register-to-rack r8
register-to-rack rbx
register-to-rack rbp
rack-to-register rsp
rack-to-register rbp
rack-to-register rsi
set-conditional jbe 200
naof-thread-sequences
marker mm-section
rack-to-mm 0
rack-to-mm 1
mm-to-rack 0
mm-to-rack 1
add-to-stack 4 1
auto-quad-source facter
set aed r8
move-quad r8 facter
set aed rax
multiply-by-quad facter
