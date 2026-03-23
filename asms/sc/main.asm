##########################################################################################################
# equations-main
##########################################################################################################
% equations
% views
% cf
% sc
##########################################################################################################
# init
##########################################################################################################
sub 4c4b40 rsp
aqs equations
mq r9 equations
aqs views
mq r10 views
aqs cf
mq r11 cf
aqs sc
mq r12 sc
aqs strstr
mq r14 strstr
ent i-sim i sim.\n
ent jsect \n

mov 1 rdi
lent i-sim rsi
mov 7 rdx
mov 1 rax
sys

ent rstrstr strstr
lent rstrstr rsi
mq strstr rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

##########################################################################################################
# strstr
##########################################################################################################
ent vts talkei talkei. airgo vah nah goo trim brader.\n
ent sfvts  trim 

aqs strstr-result
lent sfvts rsi
lent vts rdi
#lent vts rax
mq strstr r11
dct r11
mq rax strstr-result

ent rstrstr-result strstr-result
lent rstrstr-result rsi
mq strstr-result rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

mov 1 rdi
mq strstr-result rsi
mov e rdx
mov 1 rax
sys

##########################################################################################################
# index-chart
##########################################################################################################
ent chart-name charts/shianeckareckeis.chart

lent chart-name rdi
mq equations rdx
mq cf rbx
mq views r12
mq sc r11
addc sc ic r11
dct r11

##########################################################################################################
# seek-chart and get-next
##########################################################################################################
ent skey bs
aqs skey-site
mov 2 r8
mq r8 skey-site
ent svalue 19c5eb
aqs svalue-site
mov 6 r8
mq r8 svalue-site
ent svalue0 21100
aqs svalue-site0
mov 5 r8
mq r8 svalue-site0
ent svalue1 21100ac32
aqs svalue-site1
mov 9 r8
mq r8 svalue-site1
ent ctsn bin/libc.so.6.bc
aqs record
isr 400
aqs record-site
aqs fsite
aqs bmsqs
isr 38
ent srsc sc
ent rrecord-site record-site
ent rfsite fsite
ent hsc-svalue1 sc-svalue1.\n
ent hsname snap.\n
ent hfsc fsc.\n
ent hsc-svalue sc-svalue.\n
ent hgn gn.\n

mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

mov 1 rdi
lent hsc-svalue rsi
mov b rdx
mov 1 rax
sys

lq bmsqs rdi
nao rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

lent ctsn rdi
lent skey rcx
#lent svalue0 rsi
lent svalue rsi
nao r14
#mov 36dd419 r14
lq record r15
mq equations rdx
mq cf rbx
mq views r12
mq sc r11
addc sc sc r11
dct r11
mq rax record-site
mq rbx fsite

lq bmsqs rdi
mov 1 rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

mov 1 rdi
lq record rsi
mq record-site rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

lent rrecord-site rsi
mq record-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

lent rfsite rsi
mq fsite rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

mov 1 rdi
lent hgn rsi
mov 4 rdx
mov 1 rax
sys

lq bmsqs rdi
nao rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

lent ctsn rdi
mq fsite r14
lq record r15
mq equations rdx
mq cf rbx
mq views r12
mq sc r11
addc sc gn r11
dct r11
mq rax record-site
mq rbx fsite

lq bmsqs rdi
mov 1 rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

mov 1 rdi
lq record rsi
mq record-site rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

lent rrecord-site rsi
mq record-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

lent rfsite rsi
mq fsite rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

mov 1 rdi
lent hsc-svalue1 rsi
mov c rdx
mov 1 rax
sys

lq bmsqs rdi
nao rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

lent ctsn rdi
lent skey rcx
lent svalue1 rsi
nao r14
lq record r15
mq equations rdx
mq cf rbx
mq views r12
mq sc r11
addc sc sc r11
dct r11
mq rax record-site
mq rbx fsite

lq bmsqs rdi
mov 1 rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

lent rrecord-site rsi
mq record-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

lent rfsite rsi
mq fsite rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys
#init
#com

##########################################################################################################
# snap, fsc, and fgn
##########################################################################################################
aqs snapci
isr 18
aqs codeaed
mov aed r8
mq r8 codeaed

mov 1 rdi
lent hsname rsi
mov 6 rdx
mov 1 rax
sys

lq bmsqs rdi
nao rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

lent ctsn rdi
lq snapci rsi
mq equations rdx
mq sc r11
addc sc snap r11
dct r11

lq bmsqs rdi
mov 1 rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

ent rsnapci snapci
lent rsnapci rsi
lq snapci rdi
mov 28 rcx
mov 10 rbx
nao r10
mq equations rdx
mq views r11
addc views view-space r11
dct r11

ent rchart-index chart-index
lent rchart-index rsi
lq snapci rdi
mov 10 rdi rdi
mov 28 rcx
mov 10 rbx
nao r10
mq equations rdx
mq views r11
addc views view-space r11
dct r11

mov 1 rdi
mq snapci rsi
lq snapci rdx
mov 10 rdx rdx
mov 0 rdx rdx
#mov d6 rdx
mov 1 rax
sys

mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

mq equations r11
addc equations task r11
#dct r11

mov 1 rdi
lent hfsc rsi
mov 5 rdx
mov 1 rax
sys

lq bmsqs rdi
nao rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

lq snapci rdi
lent skey rcx
#lent svalue0 rsi
lent svalue rsi
#lent svalue1 rsi
nao r14
#mov 36dd419 r14
lq record r15
mq equations rdx
mq cf rbx
mq views r12
mq sc r11
addc sc fsc r11
dct r11
mq rax record-site
mq rbx fsite

lq bmsqs rdi
mov 1 rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

mov 1 rdi
lq record rsi
mq record-site rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

lent rrecord-site rsi
mq record-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

lent rfsite rsi
mq fsite rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

ent hfgn fgn.\n
mov 1 rdi
lent hfgn rsi
mov 5 rdx
mov 1 rax
sys

lq bmsqs rdi
nao rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

lq snapci rdi
mq fsite r14
lq record r15
mq equations rdx
mq cf rbx
mq views r12
mq sc r11
addc sc fgn r11
dct r11
mq rax record-site
mq rbx fsite

lq bmsqs rdi
mov 1 rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

mov 1 rdi
lq record rsi
mq record-site rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

lent rrecord-site rsi
mq record-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

lent rfsite rsi
mq fsite rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys
#init
#com

##########################################################################################################
# ssc
##########################################################################################################

lq bmsqs rdi
nao rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

lq snapci rdi
lent skey rcx
lent svalue rsi
mq strstr r14
lq record r15
mq equations rdx
mq cf rbx
mq views r12
mq sc r11
addc sc ssc r11
dct r11
mq rax record-site

lq bmsqs rdi
mov 1 rsi
lent srsc rbx
mq equations rdx
mq views rcx
mq cf r11
addc cf stat r11
dct r11

mov 1 rdi
lq record rsi
mq record-site rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

lent rrecord-site rsi
mq record-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys
#init
#com

##########################################################################################################
# com
##########################################################################################################
add 4c4b40 rsp
ret

#init
ent fn droid/clerk-com.secs
aqs file
# unlink
lentb fn rdi
mov 57 rax
sys
# open-write
mov 1f8 rdx
mov 41 rsi
lentb fn rdi
mov 2 rax
sys
mqb rax file
# write
mqb file rdi
mov 8 rdx
lq b16-number rsi
mov 1 rax
sys
# close
mqb file rdi
mov 3 rax
sys
#com

#init
aqs time-secs
nao r8
mqb r8 time-secs
aqs time-micro-secs
mov aed r8
mqb r8 time-micro-secs
s task0-init
# nanosleep
lqb time-seconds rdi
mov 23 rax
sys
st jmp task0-init
s task0-com
#com
