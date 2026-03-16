##########################################################################################################
# equations-main
##########################################################################################################
% equations
% views
% cf
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
aqs binary-name
mq r12 binary-name
aqs naof-binary-name-secs
mq r13 naof-binary-name-secs
aqs objdfn
mq r14 objdfn
aqs system-cs
mq r14 system-cs
ent i-sim i sim. ka tic boo tic but.\n
ent jsect \n
ent source-init-code <
ent source-com-code >:
ent b16-com-code :
ent ssect  
ent robjdf objdf
ent rsect-site sect-site
ent rfsite fsite
ent rcmpv cmpv
ent rnrs nrs
ent rcom com.\n\n
ent rseek-site seek-site
ent rsegment-name-site segment-name-site
ent segment-code Disassembly of section
ent ris-asm is asm.\n
aqs segment-code-site
mov 16 r8
mq r8 segment-code-site
aqs segment-name-site
nao r8
mq r8 segment-name-site
aqs segment-name
isr 400
aqs section-name-site
aqs section-name
isr 400
aqs cs
isr 500
ent cname-com .bc
aqs cname
isr 200
aqs cname-site

mov 1 rdi
lent i-sim rsi
mov 1b rdx
mov 1 rax
sys

mov 1 rdi
mq binary-name rsi
mq naof-binary-name-secs rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

aqs cfcs
isr 3d0908
lq cfcs rdi
nao r8
mov r8 0 rdi
mov 3d0900 r8
mov r8 8 rdi

mq binary-name rsi
lq cname rdi
mq naof-binary-name-secs rcx
mq equations r11
addc equations com r11
dct r11
mq binary-name rsi
lent cname-com rsi
lq cname rdi
mq naof-binary-name-secs r8
add r8 rdi
add 3 r8
mq r8 cname-site
mov 3 rcx
mq equations r11
addc equations com r11
dct r11

mov 1 rdi
lq cname rsi
mq cname-site rdx
mov 1 rax
sys

mq equations r11
addc equations task r11
#dct r11

##########################################################################################################
# rack-record-keys <--> * maybe meant warm even.
##########################################################################################################

ent kbin-site bin-site
aqs kbin-site-site
mov 8 r8
mq r8 kbin-site-site

ent kbin-secs bin-ssecs
aqs kbin-secs-site
mov 9 r8
mq r8 kbin-secs-site

##########################################################################################################
# chartify-objd
##########################################################################################################
aqs objdf
# open-read
nao rsi
mq objdfn rdi
mov 2 rax
sys
mq rax objdf

lent robjdf rsi
mq objdf rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

aqs binc
mov 1 rdi
mov 10000 rsi
lq cfcs rbx
mq equations rdx
mq cf r11
addc cf cvec r11
dct r11
mq rax binc
aqs binc0
aqs binc1
mov 1 rdi
mov 10000 rsi
lq cfcs rbx
mq equations rdx
mq cf r11
addc cf cvec r11
dct r11
mq rax binc1
aqs combbinc
mov 1 rdi
mov 10000 rsi
lq cfcs rbx
mq equations rdx
mq cf r11
addc cf cvec r11
dct r11
mq rax combbinc

aqs key-space-site
aqs value-space-site
aqs key-space
isr 400
aqs value-space
isr 400
	# <--> in more their prime of proclimai. instead to see.
aqs secs-secs-space
isr 400
aqs secs-secs-space-site

mq binc rdi
lq cname rsi
mq cf r11
addc cf sc r11
dct r11

aqs cmpv
aqs fsite
nao r8
mq r8 fsite
aqs nrs
aqs sect-site
aqs seek-site0
aqs seek-site1
aqs seek-site2
ent ris-comb is-comb
aqs is-comb
nao r8
mq r8 is-comb
aqs at-asm-site
nao r8
mq r8 at-asm-site
ent rat-asm-site at-asm-site
aqs plsecs-com-site
aqs lsecs-com-site
aqs lsecs-com-key-com-site
aqs lsecs-com-site-site
aqs at-secs
aqs at-secs-site
s sections-init
	# lseek
	mq objdf rdi
	mq fsite rsi
	nao rdx
	mov 8 rax
	sys

	# read
	mq objdf rdi
	mov 500 rdx
	lq cs rsi
	mov 0 rax
	sys
	mq rax nrs
	cmp 0 rax
	st je sections-com

	lq cs rdi
	mq nrs rdx
	lent jsect rsi
	mov 1 rcx
	mq equations r11
	addc equations seek-space r11
	dct r11
	mq rax sect-site

	mov 1 rdi
	lq segment-name rsi
	mq segment-name-site rdx
	mov 1 rax
	sys
	mov 1 rdi
	lent jsect rsi
	mov 1 rdx
	mov 1 rax
	sys
	mov 1 rdi
	lq section-name rsi
	mq section-name-site rdx
	mov 1 rax
	sys
	mov 1 rdi
	lent jsect rsi
	mov 1 rdx
	mov 1 rax
	sys
	mov 1 rdi
	lq cs rsi
	mq sect-site rdx
	add 1 rdx
	mov 1 rax
	sys

lent rat-asm-site rsi
mq at-asm-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

	s calc-in-regards-to-section-init
		lq cs rdi
		mq segment-code-site rdx
		lent segment-code rsi
		mq segment-code-site rcx
		mq equations r11
		addc equations compair-spaces r11
		dct r11
		mq rax cmpv

		mq cmpv rax
		cmp 1 rax
		st jne set-segment-name-com

		s set-segment-name-init
			mq sect-site r8
			sub 18 r8
			mq r8 segment-name-site

			lq cs rsi
			add 17 rsi
			lq segment-name rdi
			mq segment-name-site rcx
			mq equations r11
			addc equations com r11
			dct r11
			st jmp calc-in-regards-to-section-com
		s set-segment-name-com

		lq cs rdi
		mq sect-site rdx
		mq binary-name rsi
		mq naof-binary-name-secs rcx
		mq equations r11
		addc equations seek-space r11
		dct r11
		cmp 0 rax
		st je set-section-name-com

		lq cs rdi
		mq sect-site rdx
		lent source-com-code rsi
		mov 2 rcx
		mq equations r11
		addc equations seek-space r11
		dct r11
		mq rax cmpv

		mq cmpv rax
		mov ffffffffffffffff r8
		cmp r8 rax
		st je set-section-name-com
		s set-section-name-init
			lq cs rdi
			mq nrs rdx
			lent source-init-code rsi
			mov 1 rcx
			mq equations r11
			addc equations seek-space r11
			dct r11
			add 1 rax
			mq rax seek-site0

			mq sect-site r8
			sub 2 r8
			mq seek-site0 r9
			sub r9 r8
			mq r8 section-name-site

			lq cs rsi
			mq seek-site0 r8
			add r8 rsi
			lq section-name rdi
			mq section-name-site rcx
			mq equations r11
			addc equations com r11
			dct r11
			st jmp calc-in-regards-to-section-com
		s set-section-name-com

		lq cs rdi
		mq sect-site rdx
		lent b16-com-code rsi
		mq 1 rcx
		mq equations r11
		addc equations seek-space r11
		dct r11
		mq rax cmpv
		mov ffffffffffffffff r8
		cmp rax r8
		st je is-asm-com

		s is-asm-init
			mq at-asm-site r8
			cmp 1 r8
			st je set-binc1-init
				mq binc r8
				mq r8 binc0
				st jmp set-binc1-com
			s set-binc1-init
				mq binc1 r8
				mq r8 binc0
			s set-binc1-com

			mov 1 rdi
			lent ris-asm rsi
			mov 8 rdx
			mov 1 rax
			sys

			lent kbin-site rsi
			lq key-space rdi
			mq kbin-site-site rcx
			mq equations r11
			addc equations com r11
			dct r11
			mq kbin-site-site rbx
			mq rbx key-space-site

			mov 1 rdi
			lq key-space rsi
			mq key-space-site rdx
			mov 1 rax
			sys
			mov 1 rdi
			lent jsect rsi
			mov 1 rdx
			mov 1 rax
			sys

			aqs at-bin-site
			aqs at-bin-site-site
			lq cs rsi
			mq rsi at-bin-site
			nao r9
			s scn-to-at-bin-site-init
				movs 0 rsi r9
				cmp 9 r9
				st je scn-to-at-bin-site-init-init
				cmp 20 r9
				st je scn-to-at-bin-site-init-init

				st jmp scn-to-at-bin-site-init-com
				s scn-to-at-bin-site-init-init
					add 1 rsi
					st jmp scn-to-at-bin-site-init
				s scn-to-at-bin-site-init-com
			s scn-to-at-bin-site-com
			mq at-bin-site rdi
			mq rsi at-bin-site
			aqs naof-secs-to-bin-site
			sub rdi rsi
			mq rsi naof-secs-to-bin-site
			mq cmpv r10
			mq naof-secs-to-bin-site r11
			sub r11 r10
			mq r10 at-bin-site-site
			
			mov 1 rdi
			mq at-bin-site rsi
			mq at-bin-site-site rdx
			mov 1 rax
			sys
			mov 1 rdi
			lent jsect rsi
			mov 1 rdx
			mov 1 rax
			sys

			mq binc0 rdi
			lent kbin-site rcx
			mq kbin-site-site r10
			mq at-bin-site rsi
			mq at-bin-site-site r11
			nao r12
			lq cs rbx
			mq equations rdx
			mq cf r13
			mq cf r14
			addc cf atc r14
			dct r14
			mq rax binc0

			mq binc0 rsi
			mov 0 rsi r8
			mq r8 plsecs-com-site

lent rsect-site rsi
mq sect-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

			aqs sect-et
			lq cs r8
			mq sect-site rdi
			add r8 rdi
			mq rdi sect-et
			mq at-bin-site rsi
			mq at-bin-site-site r8
			add r8 rsi
			add 2 rsi
			mq rsi at-secs
			nao r9
			nao r10
			nao r11
			s seek-at-secs-site-init
				movs 0 rsi r9
				cmp 0 r10
				st je seek-at-secs-site-mode-0-init
				cmp 1 r10
				st je seek-at-secs-site-mode-1-init
				s seek-at-secs-site-mode-0-init
					cmp 20 r9
					st je set-to-mod-1-init
					cmp 9 r9
					st je set-to-mod-1-init
					st jmp set-to-mod-1-com
					s set-to-mod-1-init
						mov 1 r10
					s set-to-mod-1-com
					st jmp seek-at-secs-site-mode-1-com
				s seek-at-secs-site-mode-0-com
				s seek-at-secs-site-mode-1-init
					cmp 9 r9
					st je seek-at-secs-site-com
					cmp 20 r9
					st je seek-at-secs-site-com
					nao r10
				s seek-at-secs-site-mode-1-com
				cmp rdi rsi
				st je seek-at-secs-site-with-comb-init
				add 1 rsi
				st jmp seek-at-secs-site-init
			s seek-at-secs-site-com
			st jmp seek-at-secs-site-with-comb-com
			s seek-at-secs-site-with-comb-init
				mov 1 r11
				mq r11 is-comb
				st jmp seek-at-secs-site-with-comb-com
			s seek-at-secs-site-with-comb-com
			mq at-secs rdi
			sub rdi rsi
			sub 1 rsi
			mq rsi at-secs-site
			cmp 1 r11
			st je comb-mdshft-or-wrt-bth-init

			mq binc0 rdi
			lent kbin-secs rcx
			mq kbin-secs-site r10
			mq at-secs rsi
			mq at-secs-site r11
			nao r12
			mov 1 r12
			lq cs rbx
			mq equations rdx
			mq cf r13
			mq cf r14
			addc cf atc r14
			dct r14
			mq rax binc0
			#mq r10 lsecs-com-key-com-site
			mq rbx lsecs-com-key-com-site

			mq plsecs-com-site r8
			mq r8 lsecs-com-site
			mq binc0 rsi
			mov 0 rsi r8
			mq r8 lsecs-com-site-site

			mov 1 rdi
			mq at-secs rsi
			mq at-secs-site rdx
			#mq at-secs r10
			#lq cs r11
			#sub r11 r10
			#mq sect-site rdx
			#sub r10 rdx
			#mov 10 rdx
			mov 1 rax
			sys
			mov 1 rdi
			lent jsect rsi
			mov 1 rdx
			mov 1 rax
			sys

			mov 1 rdi
			mq binc0 rsi
			mov 0 rsi rdx
			add 18 rsi
			mov 1 rax
			sys
#init
#com
			s comb-mdshft-or-wrt-bth-init

lent ris-comb rsi
mq is-comb rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

			mq at-asm-site r8
			cmp 0 r8
			st je is-asm-s0-init
			cmp 1 r8
			st je is-asm-s1-init
			s is-asm-s0-init
				add 1 r8
				mq r8 at-asm-site
				st jmp is-asm-s1-com
			s is-asm-s0-com
			s is-asm-s1-init
				mq is-comb r8
				cmp 1 r8
				st je apend-binc-init
				s write0-init
					mq binc rdi
					lq cname rsi
					mq cf r11
					addc cf ac r11
					dct r11
					mq binc rdi
					nao r9
					mov r9 0 rdi

					mq binc rdi
					mq binc1 rsi
					mov 0 rsi rcx
					add 18 rsi
					lq cs rbx
					mq equations rdx
					mq cf r11
					addc cf astr r11
					dct r11
					mq rax binc

					mq binc1 rdi
					nao r9
					mov r9 0 rdi
					mov 1 r8
					mq r8 at-asm-site
					st jmp apend-binc-com
				s write0-com
				s apend-binc-init
					nao r8
					mq r8 is-comb
					mq combbinc rsi
					nao r9
					mov r9 0 rsi

mov 1 rdi
mq binc0 rsi
mov 0 rsi rdx
add 18 rsi
mov 1 rax
#sys

mov 1 rdi
mq at-secs rsi
mq at-secs-site rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

					mq combbinc rdi
					mq binc rsi
					add 18 rsi
					mq lsecs-com-site rcx
					lq cs rbx
					mq equations rdx
					mq cf r11
					addc cf astr r11
					dct r11
					mq rax combbinc

aqs osecs-site
mq lsecs-com-key-com-site r8
mq lsecs-com-site-site rdi
sub r8 rdi
sub 1 rdi
mq rdi osecs-site

lent rat-asm-site rsi
mq osecs-site rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11

mov 1 rdx
mq binc rsi
add 18 rsi
mq lsecs-com-key-com-site r8
add r8 rsi
mq osecs-site rdx
mov 1 rax
sys
mov 1 rdi
lent jsect rsi
mov 1 rdx
mov 1 rax
sys

					mq osecs-site r8
					mq r8 secs-secs-space-site
					lq secs-secs-space rdi
					mq binc rsi
					add 18 rsi
					mq lsecs-com-key-com-site r8
					add r8 rsi
					mq osecs-site rcx
					mq equations r11
					addc equations com r11
					dct r11

					lq secs-secs-space rdi
					mq secs-secs-space-site r8
					add r8 rdi
					add 1 r8
					mq r8 secs-secs-space-site
					lent ssect rsi
					mov 1 rcx
					mq equations r11
					addc equations com r11
					dct r11

					lq secs-secs-space rdi
					mq secs-secs-space-site r8
					add r8 rdi
					mq at-secs rsi
					mq at-secs-site rcx
					add rcx r8
					mq r8 secs-secs-space-site
					mq equations r11
					addc equations com r11
					dct r11

					mq combbinc rdi
					lent kbin-secs rcx
					mq kbin-secs-site r10
					lq secs-secs-space rsi
					mq secs-secs-space-site r11
					mov 1 r12
					lq cs rbx
					mq equations rdx
					mq cf r13
					mq cf r14
					addc cf atc r14
					dct r14
					mq rax combbinc

					mov 1 rdi
					mq combbinc rsi
					mov 0 rsi rdx
					add 18 rsi
					mov 1 rax
					sys
					mov 1 rdi
					lent jsect rsi
					mov 1 rdx
					mov 1 rax
					sys

					mq combbinc rdi
					lq cname rsi
					mq cf r11
					addc cf ac r11
					dct r11
					mq combbinc rdi
					nao r9
					mov r9 0 rdi
					mq binc rdi
					nao r9
					mov r9 0 rdi
					mq binc1 rdi
					nao r9
					mov r9 0 rdi

					nao r8
					mq r8 at-asm-site
					#st jmp sections-com
				s apend-binc-com
				nao r8
			s is-asm-s1-com
		s is-asm-com
	s calc-in-regards-to-section-com

	mov 1 rdi
	lent rcom rsi
	mov 6 rdx
	mov 1 rax
	sys

	mq fsite r8
	mq sect-site r9
	add r9 r8
	add 1 r8
	mq r8 fsite
	st jmp sections-init
s sections-com
mq at-asm-site r8
cmp 1 r8
st jne append-mode-et-com
	mq binc rdi
	lq cname rsi
	mq cf r11
	addc cf ac r11
	dct r11
	mq binc rdi
	nao r9
	mov r9 0 rdi
s append-mode-et-com

# close
mq objdf rdi
mov 3 rax
sys

mq equations r11
addc equations task r11
#dct r11

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
lent rcmpv rsi
mq cmpv rdi
mov 10 rbx
mq equations rdx
mq views r11
addc views view-number r11
dct r11
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
