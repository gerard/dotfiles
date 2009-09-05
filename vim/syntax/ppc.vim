" Vim syntax file for PPC Assembler
" Language: PPC Assembler
" Version : 0.2
" Last Change: 2004 May 19
"   added MSSCR0, HID0 and HID1 to keywords
"   use \<, \> expression (begining, end of word) to match register
"                    
" Currently not supported : AltiVec, others: automatically shift left labels
" upon entering ':'
" BUGS:
"   registers are highlighted if part of string
"   	mfspr   r3, MSSCR0      /* Errata No. 1: clear bits 18-25 of MSSCR0 */
"   will highlight R0
" Only tested with vim version 6.0
" Author: Michael Brandt <Michael.Brandt@emsyso.de>


" Quit if syntax file already loaded and vim > 6.00
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Read the C syntax for pre-processor statements
if version < 600
  so <sfile>:p:h/c.vim
else
  runtime! syntax/c.vim
  unlet b:current_syntax
endif

" Case insensitive
syntax case ignore

" # conflicts with cpp statements and #if 0 highlighting as comment will be
" broken.
" exclude cpp statements from being assembler comments:
" syntax match ppcComment /.+\#.*/ contains=cCppOut
" or only recognize comments which a preceded by at least 1 whitespace:
syntax match ppcComment /\s\+\#.*/

syntax match ppcLabel /[A-Z0-9_\-]\+:/
syntax match ppcRegister /\<r[0-3]*[0-9]\>/
" segment register
syntax match ppcRegister /\<r[0-1]*[0-9]\>/
" sp is often used as synonym for r1
syntax keyword ppcRegister sp

syntax keyword ppcSPR CSRR0 CSRR1 CTR DAC1 DAC2 DBCR0 DBCR1 DBCR2 DBSR DEAR DEC DECAR DVC1 DVC2 ESR EVPR HID0 HID1 IAC1 IAC2 IAC3 IAC4 IVOR0 IVOR1 IVOR2 IVOR3 IVOR4 IVOR5 IVOR6 IVOR7 IVOR8 IVOR9 IVOR10 IVOR11 IVOR12 IVOR13 IVOR14 IVOR15 LR MSSCR0 PID PIR PVR SPRG0 SPRG1 SPRG2 SPRG3 SPRG4 SPRG5 SPRG6 SPRG7 SRR0 SRR1 TBL TBU TCR TSR USPRG0 XER

" syntax region ppcString start=/"/ skip=/\\"/ end=/"/
" syntax match ppcNumber /[0-9]\+/

" Book E Mnemoics
syntax keyword ppcMnemonic add add\. addc addc\. addco addco\. adde adde\. adde64 adde64o addeo addeo\. addi addic addic\. addis addme addme\. addme64 addme64o addmeo addmeo\. addo addo\. addze addze\. addze64 addze64o addzeo addzeo\. and and\. andc andc\. andi\. andis\. b ba bc bca bcctr bcctre

syntax keyword ppcMnemonic bcctrel bcctrl bce bcea bcel bcela bcl bcla bclr bclre bclrel bclrl be bea bel bela bl bla cmp cmpi cmpl cmpli cntlzd cntlzw cntlzw\. crand crandc creqv crnand crnor cror crorc crxor dcba dcbae dcbf dcbfe dcbi dcbie dcbst dcbste dcbt dcbte dcbtst dcbtste dcbz dcbze

syntax keyword ppcMnemonic divd divdo divdu divduo divw divw\. divwo divwo\. divwu divwu\. divwuo divwuo\. eqv eqv\. extsb extsb\. extsh extsh\. extsw fabs fabs\. fadd fadd\. fadds fadds\. fcfid fcmpo fcmpu fctid fctidz fctiw fctiw\. fctiwz fctiwz\. fdiv fdiv\. fdivs fdivs\. fmadd fmadd\. fmadds fmadds\. fmr fmr\. fmsub fmsub\. fmsubs

syntax keyword ppcMnemonic fmsubs\. fmul fmul\. fmuls fmuls\. fnabs fnabs\. fneg fneg\. fnmadd fnmadd\. fnmadds fnmadds\. fnmsub fnmsub\. fnmsubs fnmsubs\. fres fres\. frsp frsp\. frsqrte frsqrte\. fsel fsel\. fsqrt fsqrt\. fsqrts fsqrts\. fsub fsub\. fsubs fsubs\. icbi icbie icbt icbte isync lbz lbze lbzu lbzue lbzux lbzuxe lbzx lbzxe ldarxe

syntax keyword ppcMnemonic lde ldue lduxe ldxe lfd lfde lfdu lfdue lfdux lfduxe lfdx lfdxe lfs lfse lfsu lfsue lfsux lfsuxe lfsx lfsxe lha lhae lhau lhaue lhaux lhauxe lhax lhaxe lhbrx lhbrxe lhz lhze lhzu lhzue lhzux lhzuxe lhzx lhzxe lmw lswi lswx lwarx lwarxe lwbrx lwbrxe lwz lwze

syntax keyword ppcMnemonic lwzu lwzue lwzux lwzuxe lwzx lwzxe mbar mcrf mcrfs mcrxr mcrxr64 mfapidi mfcr mfdcr mffs mffs\. mfmsr mfspr mfsr mftb msync mtcrf mtdcr mtfsb0 mtfsb0\. mtfsb1 mtfsb1\. mtfsf mtfsf\. mtfsfi mtfsfi\. mtmsr mtspr mtsr mtsrin mulhd mulhdu mulhw mulhw\. mulhwu mulhwu\. mulld mulldo mulli mullw mullw\. mullwo mullwo\. nand nand\. neg

syntax keyword ppcMnemonic neg\. nego nego\. nor nor\. or or\. orc orc\. ori oris rfci rfi rldcl rldcr rldic rldicl rldicr rldimi rlwimi rlwimi\. rlwinm rlwinm\. rlwnm rlwnm\. sc sld slw slw\. srad sradi sraw sraw\. srawi srawi\. srd srw srw\. stb stbe stbue stbu stbux stbuxe stbx stbxe stdcxe\.

syntax keyword ppcMnemonic stde stdue stduxe stdxe stfd stfde stfdu stfdue stfdux stfduxe stfdx stfdxe stfiwx stfiwxe stfs stfse stfsu stfsue stfsux stfsuxe stfsx stfsxe sth sthbrx sthbrxe sthe sthu sthue sthux sthuxe sthx sthxe stmw stswi stswx stw stwbrx stwbrxe stwcx\. stwcxe\. stwe stwu stwue stwux stwuxe stwx stwxe

syntax keyword ppcMnemonic subf subf\. subfc subfc\. subfco subfco\. subfe subfe\. subfe64 subfe64o subfeo subfeo\. subfic subfme subfme\. subfme64 subfme64o subfmeo subfmeo\. subfo subfo\. subfze subfze\. subfze64 subfze64o subfzeo subfzeo\. td tdi tlbivax tlbivaxe tlbre tlbsx tlbsxe tlbwe tw twi wrtee wrteei xor xor\. xori xoris


syntax match ppcAsmDirective		"\.[a-z][a-z]\+"
" syntax keyword ppcAsmDirective alias align ascii asciz byte common double empty file globl global half ident local noalias nonvolatile nword optim popsection proc pushsection quad reserve section seg single size skip stabn stabs type uahalf uaword version volatile weak word xword xstabs

"syntax keyword ppcSimplified
syntax keyword ppcSimplified extlwi extlwi\.  extrwi extrwi\.  inslwi inslwi\.  insrwi insrwi\.  la mr mtcr nop not rotrwi rotrwi\.  slwi sli slwi\.  sli\.  srwi sri srwi\.  sri\.  clrrwi clrrwi\.  clrlslwi clrlslwi\.

" Simplified Mnemonics for Subtract Instructions
syntax keyword ppcSimplified subi subis subic subic.
syntax keyword ppcSimplified sub subc

" Simplified Mnemonics for Word Compare Instructions
syntax keyword ppcSimplified cmpwi cmpw cmplwi cmplw

" simplified branch mnemonics
syntax keyword ppcSimplified blr bctr blrl bctrl
syntax keyword ppcSimplified bt bta btlr btctr btl btla btlrl btctrl
syntax keyword ppcSimplified bf bfa bflr bfctr bfl bfla bflrl bfctrl
syntax keyword ppcSimplified bdnz bdnza bdnzlr bdnzl bdnzla bdnzlrl 
syntax keyword ppcSimplified bdnzt bdnzta bdnztlr bdnztl bdnztla bdnztlrl 
syntax keyword ppcSimplified bdnzf bdnzfa bdnzflr bdnzfl bdnzfla bdnzflrl
syntax keyword ppcSimplified bdz bdza bdzlr bdzl bdzla bdzlrl
syntax keyword ppcSimplified bdzt bdzta bdztlr bdztl bdztla bdztlrl
syntax keyword ppcSimplified bdzf bdzfa bdzflr bdzfl bdzfla bdzflrl

syntax keyword ppcSimplified blt blta bltlr bltctr bltl bltla bltlrl bltctrl
syntax keyword ppcSimplified ble blea blelr blectr blel blela blelrl blectrl
syntax keyword ppcSimplified beq beqa beqlr beqctr beql beqla beqlrl beqctrl
syntax keyword ppcSimplified bge bgea bgelr bgectr bgel bgela bgelrl bgectrl
syntax keyword ppcSimplified bgt bgta bgtlr bgtctr bgtl bgtla bgtlrl bgtctrl
syntax keyword ppcSimplified bnl bnla bnllr bnlctr bnll bnlla bnllrl bnlctrl
syntax keyword ppcSimplified bne bnea bnelr bnectr bnel bnela bnelrl bnectrl
syntax keyword ppcSimplified bng bnga bnglr bngctr bngl bngla bnglrl bngctrl
syntax keyword ppcSimplified bso bsoa bsolr bsoctr bsol bsola bsolrl bsoctrl
syntax keyword ppcSimplified bns bnsa bnslr bnsctr bnsl bnsla bnslrl bnsctrl
syntax keyword ppcSimplified bun buna bunlr bunctr bunl bunla bunlrl bunctrl
syntax keyword ppcSimplified bnu bnua bnulr bnuctr bnul bnula bnulrl bnuctrl

" simplified mnemonics for traps
syntax keyword ppcSimplified trap twlti twlt twlei twle tweqi tweq twgei twge twgti twgt twnli twnl twnei twne twngi twng twllti twllt twllei twlle twlgei twlge twlgti twlgt twlnli twlnl twlngi twlng

" simplified mnemonics for SPRs
syntax keyword ppcSimplified mtxer mtlr mtctr mtdsisr mtdar mtdec mtsdr1 mtsrr0 mtsrr1 mtsprg mtear
syntax keyword ppcSimplified mttbl mttbu mtibatu mtibatl mtdbatu mtdbatl
syntax keyword ppcSimplified mfxer mflr mfctr mfdsisr mfdar mfdec mfsdr1 mfsrr0 mfsrr1 mfsprg mfear
syntax keyword ppcSimplified mftb mftbu mfpvr mfibatu mfibatl mfdbatu mfdbatl

syntax keyword ppcSimplified li lis rotlwi

" arch specific ?
syntax keyword ppcMnemonic eieio sync 

" optional instructions
syntax keyword ppcMnemonic tlbia tlbie tlbsync

if !exists("did_ppc_syntax_inits")
   	let did_ppc_syntax_inits=1
	highlight link ppcComment Comment
	highlight link ppcLabel Label
	" highlight link ppcString String
	" highlight link ppcNumber Number

	highlight link ppcAsmDirective Statement

	highlight link ppcMnemonic Keyword

    " seems logical to use Preproc, but since in usual PPC assembler many
    " simplified mnemonics are used it gets to colorful
	" highlight link ppcSimplified Preproc
	highlight link ppcSimplified Conditional
	highlight link ppcMnemonicSyn Conditional

	highlight link ppcRegister Preproc
	highlight link ppcSpr Preproc
endif
let b:current_syntax="ppc"

" . is normally not part of the iskeyword string. Add it for mnemonics ending
" in ., like "andi."
set iskeyword+=.
" does not belong into syntax file, put it into your filetype plugin
" ~/.vim/ftplugin/ppc.vim
" set ts=8 sw=8 ai smartindent

" put following line into your .vimrc if PPC assembler instead of GNU asm
" should be choosen for .S or .s files
" let g:asmsyntax = "ppc"
