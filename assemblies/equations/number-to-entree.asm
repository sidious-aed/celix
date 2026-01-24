##########################################################################################################
# number-to-entree | 1
##########################################################################################################
# rsi | entree
# rdi | number
# rbx | base
# rdx | domain-back
##########################################################################################################
# initialise
##########################################################################################################
secs 90
sub-constant 1000 rsp
auto-quad-source entree
move-quad rsi entree
auto-quad-source number
move-quad rdi number
auto-quad-source base
move-quad rbx base
auto-quad-source focus
auto-quad-source prime-focus
move-quad-to base r8
move-quad r8 prime-focus
auto-quad-source back-site
move-quad rdx back-site
auto-quad-source sec
auto-quad-source print-sec
auto-quad-source naof-number-entree-secs
auto-quad-source base-secs-breadth
auto-quad-source site
auto-quad-source mode
naoify r8
move-quad r8 naof-number-entree-secs
move-quad r8 base-secs-breadth
move-quad r8 site
move-quad r8 mode
set 1 r8
move-quad r8 focus
auto-quad-source current

##########################################################################################################
# seek-breadth
##########################################################################################################
marker seek-breadth-et
move-quad-to base rax
multiply-by-quad focus
move-quad rax focus
move-quad-to prime-focus r8
compair r8 rax
stay-to seek-breadth-completion below
move-quad-to base-secs-breadth r8
add-constant 1 r8
move-quad r8 base-secs-breadth
move-quad-to focus rax
move-quad rax prime-focus
stay-to seek-breadth-et always
marker seek-breadth-completion

set 1 r8
move-quad r8 focus
marker gain-focus-et
move-quad-to focus rax
multiply-by-quad base
move-quad rax focus
move-quad-to site r8
add-constant 1 r8
move-quad r8 site
move-quad-to base-secs-breadth r9
compair r8 r9
stay-to gain-focus-et not-equal

##########################################################################################################
# number-to-entree
##########################################################################################################
marker number-to-entree-et
move-quad-to number rax
naoify rdx
divide-by-quad focus
move-quad rax sec

move-quad-to mode r8
compair-constant 0 r8
stay-to mode-1 not-equal

move-quad-to sec rax
compair-constant 0 rax
stay-to modes-completion equal

marker mode-1
set 1 r8
move-quad r8 mode
move-quad-to sec rax
compair-constant a rax
stay-to in-26-scope equal-above
add-constant 30 rax
stay-to base-scopes-copletion always
marker in-26-scope
add-constant 57 rax
marker base-scopes-copletion
move-quad-to entree r10
move-sec-to 0 rax r10
add-constant 1 r10
move-quad r10 entree
move-quad-to naof-number-entree-secs r8
add-constant 1 r8
move-quad r8 naof-number-entree-secs
move-quad-to sec rax
multiply-by-quad focus
move-quad-to number r11
sub rax r11
move-quad r11 number

marker modes-completion
move-quad-to focus rax
naoify rdx
divide-by-quad base
move-quad rax focus
compair-constant 0 rax
stay-to number-to-entree-et not-equal

move-quad-to mode r8
compair-constant 0 r8
stay-to write-zero equal
stay-to write-zero-completion always
marker write-zero
move-quad-to entree r10
set 30 rax
move-sec-to 0 rax r10
set 1 rax
move-quad rax naof-number-entree-secs
marker write-zero-completion

move-quad-to naof-number-entree-secs rax
move-quad-to back-site rdx
add-constant 1000 rsp
domain-back
secs 90
