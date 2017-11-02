/**
  Live Coding Functions
  Author: Steven Yi
*/ 

instr S1
  ifreq = p4
  iamp = p5
endin

instr P1
  ibeat = p4
endin

;; TIME

gktempo init 120 

opcode set_tempo,0,i
  itempo xin
  gktempo init itempo
endop

opcode go_tempo, 0, ii
  inewtempo, incr xin

  icurtempo = i(gktempo)
  itemp init icurtempo 

  if(inewtempo > icurtempo) ithen
    itemp = min:i(inewtempo, icurtempo + abs(incr))
    gktempo init itemp 
  elseif (inewtempo < icurtempo) ithen
    itemp = max:i(inewtempo, icurtempo - abs(incr))
    gktempo init itemp 
  endif
endop

instr Perform
  ibeat = p4

  schedule("P1", 0, p3, ibeat) 
endin

instr Clock ;; our clock	
  kbeat init 0
  kfreq = gktempo / 60 * 4
  kdur = 1 / kfreq
  ktrig = metro(kfreq)

  schedkwhen(ktrig, 0, 0, "Perform", 0, kdur, kbeat)

  if (ktrig == 1) then
    kbeat += 1
  endif

endin


;; Beats

opcode hexbeat, i, Si
  Spat, ibeat xin

  ;; 4 bits/beats per hex value
  ipatlen = strlen(Spat) * 4
  ;; get beat within pattern length
  ibeat = ibeat % ipatlen
  ;; figure which hex value to use from string
  ipatidx = int(ibeat / 4)
  ;; figure out which bit from hex to use
  ibitidx = ibeat % 4 
  
  ;; convert individual hex from string to decimal/binary
  ibeatPat = strtol(strcat("0x", strsub(Spat, ipatidx, ipatidx + 1))) 

  ;; bit shift/mask to check onset from hex's bits
  xout (ibeatPat >> (3 - ibitidx)) & 1 

endop


opcode hexplay, 0, SiSiip
	Spat, ibeat, Sinstr, idur, ifreq, iamp xin

  if(hexbeat(Spat, ibeat) == 1) then
    schedule(Sinstr, 0, idur, ifreq, iamp )
  endif
endop

;; Beat Phase
opcode bphs, i, ii
	ibeat, imax xin
	xout (ibeat % imax) / imax
endop


;; Iterative Euclidean Beat Generator
;; Returns string of 1 and 0's
opcode euclidStr, S, ii
  ihits, isteps xin

  Sleft = "1"
  Sright = "0"

  ileft = ihits
  iright = isteps - ileft

  while iright > 1 do
    if (iright > ileft) then
      iright = iright - ileft 
      Sleft = strcat(Sleft, Sright)
    else
      itemp = iright
      iright = ileft - iright
      ileft = itemp 
      Stemp = Sleft
      Sleft = strcat(Sleft, Sright)
      Sright = Stemp
    endif
  od

  Sout = ""
  indx = 0 
  while (indx < ileft) do
    Sout = strcat(Sout, Sleft)
    indx += 1
  od
  indx = 0 
  while (indx < iright) do
    Sout = strcat(Sout, Sright)
    indx += 1
  od

  xout Sout
endop

opcode euclid, i, iii
  ibeat, ihits, isteps xin
  Sval = euclidStr(ihits, isteps)
  indx = ibeat % strlen(Sval)
  xout strtol(strsub(Sval, indx, indx + 1))
endop

opcode euclidplay, 0, iiiSiip
	ihits, isteps, ibeat, Sinstr, idur, ifreq, iamp xin

  if(euclid(ibeat, ihits, isteps) == 1) then
    schedule(Sinstr, 0, idur, ifreq, iamp)
  endif
endop

;; Phase-based Oscillators 

opcode xcos, i,i
	iphase  xin
	xout cos(2 * $M_PI * iphase)
endop

opcode xsin, i,i
	iphase  xin
	xout cos(2 * $M_PI * iphase)
endop

opcode xosc, i, ik[]
  iphase, kvals[]  xin
  indx = int(lenarray:i(kvals) * (iphase % 1))  
  xout i(kvals, indx)
endop

opcode xosci, i, ik[]
  iphase, kvals[]  xin
  ilen = lenarray:i(kvals)
  indx = ilen * (iphase % 1)
  ibase = int(indx)  
  ifrac = indx - ibase 

  iv0 = i(kvals, ibase)  
  iv1 = i(kvals, (ibase + 1) % ilen) 
  xout iv0 + (iv1 - iv0) * ifrac
endop

opcode xlin, i, iii
  iphase, istart, iend xin
  xout istart + (iend - istart) * iphase
endop

;; Channel Helper

/** xchan 
  Initializes a channel with initial value if channel has default value of 0 and
  then returns the current value from the channel. Useful in live coding to define
  a dynamic point that will be automated or set outside of the instrument that is
  using the channel. 

  Opcode is overloaded to return i- or k- value. Be sure to use xchan:i or xchan:k
  to specify which value to use. 
*/
opcode xchan, i,Si
  SchanName, initVal xin
   
  Sinit = sprintf("%s_initialized", SchanName)
  if(chnget:i(Sinit) == 0) then
    chnset(1, Sinit)
    chnset(initVal, SchanName)
  endif
  xout chnget:i(SchanName)
endop

opcode xchan, k,Si
  SchanName, initVal xin
    
  Sinit = sprintf("%s_initialized", SchanName)
  if(chnget:i(SchanName) == 0) then
    chnset(1, Sinit)
    chnset(initVal, SchanName)
  endif
  xout chnget:k(SchanName)
endop

;; SCALE/HARMONY (experimental)

gkscale[] = fillarray(0, 2, 3, 5, 7, 8, 10)

opcode inScale, i, ii
  ibase, idegree xin

  idegrees = lenarray:i(gkscale)

  if (idegree < 0) then
    ioct = (1 + int(abs:i(idegree) / idegrees))
    indx = idegree + (ioct * idegrees)
    ioct *= -1
  else 
    ioct = int(idegree / idegrees)
    indx = idegree % idegrees
  endif

  xout cpsmidinn(ibase + (ioct * 12) + i(gkscale, indx)) 
endop

;; AUDIO

opcode declick, a, a
	ain xin
	aenv = linseg:a(0, 0.01, 1, p3 - 0.02, 1, 0.01, 0, 0.01, 0)
 	xout ain * aenv
endop

;; KILLING INSTANCES

instr KillImpl
  Sinstr = p4 
  ktrig init 0

  if(ktrig == 0) then
    turnoff2(Sinstr, 0, 0)
    ktrig += 1
  endif
endin

opcode kill, 0,S
  Sinstr xin
  schedule("KillImpl", 0, 0.01, Sinstr)
endop


;; Fades (Experimental)

opcode fadeIn, i, ii
  ident, inumbeats xin
  Schan = sprintf("fade_chan_%d", ident)
  ival = limit:i(chnget:i(Schan) + 1, 0, inumbeats) 
  chnset(ival, Schan)

  xout ival / inumbeats 
endop

opcode fadeOut, i, ii
  ident, inumbeats xin
  Schan = sprintf("fade_chan_%d", ident)
  ival = limit:i(chnget:i(Schan) - 1, 0, inumbeats) 
  chnset(ival, Schan)

  xout ival / inumbeats 
endop


;; DRUMS

instr Clap
  ifreq = p4 ;; ignore
  iamp = p5

  ;; Modified clap instrument by Istvan Varga (clap1.orc)
  ibpfrq	=  1046.5				/* bandpass filter frequency */
  kbpbwd =	port:k(ibpfrq*0.25, 0.03, ibpfrq*4.0)   /* bandpass filter bandwidth */
  idec	=  0.5					/* decay time		     */

  a1	=  1.0
  a1_	delay1 a1
  a1	=  a1 - a1_
  a2	delay a1, 0.011
  a3	delay a1, 0.023
  a4	delay a1, 0.031

  a1	tone a1, 60.0
  a2	tone a2, 60.0
  a3	tone a3, 60.0
  a4	tone a4, 1.0 / idec

  aenv1	=  a1 + a2 + a3 + a4*60.0*idec

  a_	unirand 2.0
  a_	=  aenv1 * (a_ - 1.0)
  a_	butterbp a_, ibpfrq, kbpbwd

  aout = a_	* 80 * iamp ;; 
  al, ar pan2 aout, 0.7
  outc(al, ar)

endin


;; Bass Drum - From Iain's TR-808.csd

gi_bd_sine  ftgen 0,0,1024,10,1   ;A SINE WAVE
gi_bd_cos ftgen 0,0,65536,9,1,1,90  ;A COSINE WAVE 

instr	BD	;BASS DRUM
	p3	=	2 * xchan("bd_decay", 0.5)							;NOTE DURATION. SCALED USING GUI 'Decay' KNOB

  ilevel = xchan("bd_level", 1) * 2
  itune = xchan("bd_tune", 0)
  ipan = xchan("bd_pan", 0.5)

	;SUSTAIN AND BODY OF THE SOUND
	kmul	transeg	0.2,p3*0.5,-15,0.01, p3*0.5,0,0					;PARTIAL STRENGTHS MULTIPLIER USED BY GBUZZ. DECAYS FROM A SOUND WITH OVERTONES TO A SINE TONE.
	kbend	transeg	0.5,1.2,-4, 0,1,0,0						;SLIGHT PITCH BEND AT THE START OF THE NOTE 
	asig	gbuzz	0.5,50*octave(itune)*semitone(kbend),20,1,kmul,gi_bd_cos		;GBUZZ TONE
	aenv	transeg	1,p3-0.004,-6,0							;AMPLITUDE ENVELOPE FOR SUSTAIN OF THE SOUND
	aatt	linseg	0,0.004,1, .01, 1							;SOFT ATTACK
	asig	=	asig*aenv*aatt

	;HARD, SHORT ATTACK OF THE SOUND
	aenv	linseg	1,0.07,0, .01, 0							;AMPLITUDE ENVELOPE (FAST DECAY)						
	acps	expsega	400,0.07,0.001,1,0.001						;FREQUENCY OF THE ATTACK SOUND. QUICKLY GLISSES FROM 400 Hz TO SUB-AUDIO
	aimp	oscili	aenv,acps*octave(itune*0.25),gi_bd_sine				;CREATE ATTACK SOUND
	
	amix	=	((asig*0.5)+(aimp*0.35))*ilevel*p5			;MIX SUSTAIN AND ATTACK SOUND ELEMENTS AND SCALE USING GUI 'Level' KNOB
	
	aL,aR	pan2	amix,ipan							;PAN THE MONOPHONIC SOUND
	outc(aL,aR)							;SEND AUDIO TO OUTPUTS
endin



;; INITIALIZATION OF SYSTEM

schedule("Clock", 0, -1)
