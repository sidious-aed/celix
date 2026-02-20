##########################################################################################################
# number-to-entree | 1
##########################################################################################################
# rsi | entree
# rdi | number
# rbx | base
# rdx | domain-site
##########################################################################################################
# initialise
##########################################################################################################
sub-constant 1000 rsp
auto-quad-source entree
move-quad rsi entree
auto-quad-source number
move-quad rdi number
auto-quad-source base
move-quad rbx base
auto-quad-source domain-site
move-quad rdx domain-site

auto-quad-source focus
auto-quad-source prime-focus
move-quad-to base r8
move-quad r8 prime-focus
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
marker seek-breadth-init
marker seek-breadth-com

##########################################################################################################
# number-to-entree
##########################################################################################################
marker number-to-entree-init
marker number-to-entree-com

move-quad-to naof-number-entree-secs rax
move-quad-to domain-site rdx
add-constant 1000 rsp
domain-back
