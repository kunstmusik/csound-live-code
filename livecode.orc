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


opcode octalbeat, i, Si
  Spat, ibeat xin

  ;; 3 bits/beats per octal value
  ipatlen = strlen(Spat) * 4
  ;; get beat within pattern length
  ibeat = ibeat % ipatlen
  ;; figure which octal value to use from string
  ipatidx = int(ibeat / 3)
  ;; figure out which bit from octal to use
  ibitidx = ibeat % 3 
  
  ;; convert individual octal from string to decimal/binary
  ibeatPat = strtol(strcat("0", strsub(Spat, ipatidx, ipatidx + 1))) 

  ;; bit shift/mask to check onset from hex's bits
  xout (ibeatPat >> (2 - ibitidx)) & 1 

endop

opcode octalplay, 0, SiSiip
	Spat, ibeat, Sinstr, idur, ifreq, iamp xin

  if(octalbeat(Spat, ibeat) == 1) then
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
opcode euclid_str, S, ii
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
  Sval = euclid_str(ihits, isteps)
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

gi_scale_major[] = array(0, 2, 4, 5, 7, 9, 11) 
gi_scale_minor[] = array(0, 2, 3, 5, 7, 8, 10)

gi_cur_scale[] = gi_scale_minor
gi_scale_base = 60
gi_chord_offset = 0

opcode set_scale, 0,S
  Scale xin
  if(strcmp("maj", Scale) == 0) then
    gi_cur_scale = gi_scale_major
  else
    gi_cur_scale = gi_scale_minor
  endif
endop

opcode in_scale, i, ii
  ioct, idegree xin

  ibase = gi_scale_base + (ioct * 12)

  idegrees = lenarray(gi_cur_scale)

  if (idegree < 0) then
    ioct = (1 + int(abs:i(idegree) / idegrees))
    indx = idegree + (ioct * idegrees)
    ioct *= -1
  else 
    ioct = int(idegree / idegrees)
    indx = idegree % idegrees
  endif

  xout cpsmidinn(ibase + (ioct * 12) + gi_cur_scale[indx]) 
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

opcode fade_in, i, ii
  ident, inumbeats xin
  Schan = sprintf("fade_chan_%d", ident)
  ival = limit:i(chnget:i(Schan) + 1, 0, inumbeats) 
  chnset(ival, Schan)

  xout ival / inumbeats 
endop

opcode fade_out, i, ii
  ident, inumbeats xin
  Schan = sprintf("fade_chan_%d", ident)
  ival = limit:i(chnget:i(Schan) - 1, 0, inumbeats) 
  chnset(ival, Schan)

  xout ival / inumbeats 
endop

;; SYNTHS

/* Substractive Synth, 3osc */
instr Sub1
  asig = vco2(ampdbfs(-12), p4)
  asig += vco2(ampdbfs(-12), p4 * 1.01, 10)
  asig += vco2(ampdbfs(-12), p4 * 2, 10)
  asig = zdf_ladder(asig, expon(10000, p3, 400), 5)
  asig = declick(asig) * p5
  outc(asig, asig)
endin


/* Subtractive Synth, two saws, fifth freq apart */
instr Sub2
  icut = xchan("Sub2.cut", sr / 3)
  asig = vco2(ampdbfs(-12), p4) 
  asig += vco2(ampdbfs(-12), p4 * 1.5) 
  asig = zdf_ladder(asig, expon(icut, p3, 400), 5)
  asig = declick(asig) * p5
	outc(asig, asig)
endin

/* FM 3:1 C:M ratio, 2->0.025 index, nice for bass */
instr FM1 
  icar = xchan("FM1.car", 1)
  imod = xchan("FM1.mod", 3)
  asig = foscili(p5, p4, icar, imod, expon(2, 0.2, 0.025))
  asig = declick(asig) * 0.5
	outc(asig, asig)
endin


;; DRUMS


;; Modified clap instrument by Istvan Varga (clap1.orc)
instr Clap
  ifreq = p4 ;; ignore
  iamp = p5

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


;; Bass Drum - From Iain McCurdy's TR-808.csd

gi_808_sine  ftgen 0,0,1024,10,1   ;A SINE WAVE
gi_808_cos ftgen 0,0,65536,9,1,1,90  ;A COSINE WAVE 

instr	BD	;BASS DRUM
	p3	=	2 * xchan("BD.decay", 0.5)							;NOTE DURATION. SCALED USING GUI 'Decay' KNOB

  ilevel = xchan("BD.level", 1) * 2
  itune = xchan("BD.tune", 0)
  ipan = xchan("BD.pan", 0.5)

	;SUSTAIN AND BODY OF THE SOUND
	kmul = transeg(0.2,p3*0.5,-15,0.01, p3*0.5,0,0)					;PARTIAL STRENGTHS MULTIPLIER USED BY GBUZZ. DECAYS FROM A SOUND WITH OVERTONES TO A SINE TONE.
	kbend = transeg(0.5,1.2,-4, 0,1,0,0)						;SLIGHT PITCH BEND AT THE START OF THE NOTE 
	asig = gbuzz(0.5,50*octave(itune)*semitone(kbend),20,1,kmul,gi_808_cos)		;GBUZZ TONE
	aenv = transeg:a(1,p3-0.004,-6,0)							;AMPLITUDE ENVELOPE FOR SUSTAIN OF THE SOUND
	aatt = linseg:a(0,0.004,1, .01, 1)							;SOFT ATTACK
	asig=	asig*aenv*aatt

	;HARD, SHORT ATTACK OF THE SOUND
	aenv	= linseg:a(1,0.07,0, .01, 0)							;AMPLITUDE ENVELOPE (FAST DECAY)						
	acps = expsega(400,0.07,0.001,1,0.001)						;FREQUENCY OF THE ATTACK SOUND. QUICKLY GLISSES FROM 400 Hz TO SUB-AUDIO
	aimp = oscili(aenv,acps*octave(itune*0.25),gi_808_sine)				;CREATE ATTACK SOUND
	
	amix	=	((asig*0.5)+(aimp*0.35))*ilevel*p5			;MIX SUSTAIN AND ATTACK SOUND ELEMENTS AND SCALE USING GUI 'Level' KNOB
	
	aL,aR	pan2	amix,ipan							;PAN THE MONOPHONIC SOUND
	outc(aL,aR)							;SEND AUDIO TO OUTPUTS
endin


;; Snare Drum - From Iain McCurdy's TR-808.csd
instr	SD	;SNARE DRUM
	
	;SOUND CONSISTS OF TWO SINE TONES, AN OCTAVE APART AND A NOISE SIGNAL
  idur = xchan("SD.decay", 1.0)	
  ilevel = xchan("SD.level", 1) 
  itune = xchan("SD.tune", 0)
  ipan = xchan("SD.pan", 0.5)

	ifrq  	=	342		;FREQUENCY OF THE TONES
  iNseDur	=	0.3 * idur  ;DURATION OF THE NOISE COMPONENT
	iPchDur	=	0.1 * idur	;DURATION OF THE SINE TONES COMPONENT
	p3	=	iNseDur 	;p3 DURATION TAKEN FROM NOISE COMPONENT DURATION (ALWATS THE LONGEST COMPONENT)
	
	;SINE TONES COMPONENT
	aenv1	= expseg(1, iPchDur, 0.0001, p3-iPchDur, 0.0001)		;AMPLITUDE ENVELOPE
	apitch1	= oscili(1, ifrq * octave(itune), gi_808_sine)			;SINE TONE 1
	apitch2	= oscili(0.25, ifrq * 0.5 * octave(itune), gi_808_sine)		;SINE TONE 2 (AN OCTAVE LOWER)
	apitch	=	(apitch1+apitch2)*0.75				;MIX THE TWO SINE TONES

	;NOISE COMPONENT
	aenv2	= expon(1,p3,0.0005)					;AMPLITUDE ENVELOPE
	anoise = noise(0.75, 0)						;CREATE SOME NOISE
	anoise = butbp(anoise, 10000*octave(itune), 10000)		;BANDPASS FILTER THE NOISE SIGNAL
	anoise = buthp(anoise, 1000)					;HIGHPASS FILTER THE NOISE SIGNAL
	kcf = expseg(5000, 0.1, 3000, p3-0.2, 3000)			;CUTOFF FREQUENCY FOR A LOWPASS FILTER
	anoise = butlp(anoise,kcf)            					;LOWPASS FILTER THE NOISE SIGNAL
	amix	=	((apitch*aenv1)+(anoise*aenv2))*ilevel*p5	;MIX AUDIO SIGNALS AND SCALE ACCORDING TO GUI 'Level' CONTROL

  aL,aR	pan2	amix,ipan					;PAN THE MONOPHONIC AUDIO SIGNAL
  outs	aL,aR						;SEND AUDIO TO OUTPUTS
endin


;; Open High Hat - From Iain McCurdy's TR-808.csd
instr	OHH	;OPEN HIGH HAT

  idur = xchan("OHH.decay", 1.0)	
  ilevel = xchan("OHH.level", 1) 
  itune = xchan("OHH.tune", 0)
  ipan = xchan("OHH.pan", 0.5)
  ioct = octave:i(itune)


	kFrq1	=	296*ioct 	;FREQUENCIES OF THE 6 OSCILLATORS
	kFrq2	=	285*ioct 	
	kFrq3	=	365*ioct 	
	kFrq4	=	348*ioct	
	kFrq5	=	420*ioct 	
	kFrq6	=	835*ioct 	
	p3	=	0.5*idur		;DURATION OF THE NOTE
	
	;SOUND CONSISTS OF 6 PULSE OSCILLATORS MIXED WITH A NOISE COMPONENT
	;PITCHED ELEMENT
	aenv	linseg	1,p3-0.05,0.1,0.05,0		;AMPLITUDE ENVELOPE FOR THE PULSE OSCILLATORS
	ipw	=	0.25				;PULSE WIDTH
	a1	vco2	0.5,kFrq1,2,ipw			;PULSE OSCILLATORS...
	a2	vco2	0.5,kFrq2,2,ipw
	a3	vco2	0.5,kFrq3,2,ipw
	a4	vco2	0.5,kFrq4,2,ipw
	a5	vco2	0.5,kFrq5,2,ipw
	a6	vco2	0.5,kFrq6,2,ipw
	amix	sum	a1,a2,a3,a4,a5,a6		;MIX THE PULSE OSCILLATORS
	amix	reson	amix,5000*ioct,5000,1	;BANDPASS FILTER THE MIXTURE
	amix	buthp	amix,5000			;HIGHPASS FILTER THE SOUND...
	amix	buthp	amix,5000			;...AND AGAIN
	amix	=	amix*aenv			;APPLY THE AMPLITUDE ENVELOPE
	
	;NOISE ELEMENT
	anoise	noise	0.8,0				;GENERATE SOME WHITE NOISE
	aenv	linseg	1,p3-0.05,0.1,0.05,0		;CREATE AN AMPLITUDE ENVELOPE
	kcf	expseg	20000,0.7,9000,p3-0.1,9000	;CREATE A CUTOFF FREQ. ENVELOPE
	anoise	butlp	anoise,kcf			;LOWPASS FILTER THE NOISE SIGNAL
	anoise	buthp	anoise,8000			;HIGHPASS FILTER THE NOISE SIGNAL
	anoise	=	anoise*aenv			;APPLY THE AMPLITUDE ENVELOPE
	
	;MIX PULSE OSCILLATOR AND NOISE COMPONENTS
	amix	=	(amix+anoise)*ilevel*p5*0.55
	aL,aR	pan2	amix,ipan			;PAN MONOPHONIC SIGNAL
  outs	aL,aR				;SEND TO OUTPUTS
endin


;; Closed High Hat - From Iain McCurdy's TR-808.csd
instr	CHH	;CLOSED HIGH HAT
  idur = xchan("CHH.decay", 1.0)	
  ilevel = xchan("CHH.level", 1) 
  itune = xchan("CHH.tune", 0)
  ipan = xchan("CHH.pan", 0.5)
  ioct = octave:i(itune)

	kFrq1	=	296*ioct 	;FREQUENCIES OF THE 6 OSCILLATORS
	kFrq2	=	285*ioct 	
	kFrq3	=	365*ioct 	
	kFrq4	=	348*ioct 	
	kFrq5	=	420*ioct 	
	kFrq6	=	835*ioct 	
	idur	=	0.088*idur		;DURATION OF THE NOTE
	p3	limit	idur,0.1,10		;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)

  iohh = nstrnum("OHH")
	iactive	= active(iohh)			;SENSE ACTIVITY OF PREVIOUS INSTRUMENT (OPEN HIGH HAT) 
	if iactive>0 then			;IF 'OPEN HIGH HAT' IS ACTIVE...
	 turnoff2	iohh,0,0		;TURN IT OFF (CLOSED HIGH HAT TAKES PRESIDENCE)
	endif

	;PITCHED ELEMENT
	aenv	expsega	1,idur,0.001,1,0.001		;AMPLITUDE ENVELOPE FOR THE PULSE OSCILLATORS
	ipw	=	0.25				;PULSE WIDTH
	a1	vco2	0.5,kFrq1,2,ipw			;PULSE OSCILLATORS...			
	a2	vco2	0.5,kFrq2,2,ipw
	a3	vco2	0.5,kFrq3,2,ipw
	a4	vco2	0.5,kFrq4,2,ipw
	a5	vco2	0.5,kFrq5,2,ipw
	a6	vco2	0.5,kFrq6,2,ipw
	amix	sum	a1,a2,a3,a4,a5,a6		;MIX THE PULSE OSCILLATORS
	amix	reson	amix,5000*ioct,5000,1	;BANDPASS FILTER THE MIXTURE
	amix	buthp	amix,5000			;HIGHPASS FILTER THE SOUND...
	amix	buthp	amix,5000			;...AND AGAIN
	amix	=	amix*aenv			;APPLY THE AMPLITUDE ENVELOPE
	
	;NOISE ELEMENT
	anoise	noise	0.8,0				;GENERATE SOME WHITE NOISE
	aenv	expsega	1,idur,0.001,1,0.001		;CREATE AN AMPLITUDE ENVELOPE
	kcf	expseg	20000,0.7,9000,idur-0.1,9000	;CREATE A CUTOFF FREQ. ENVELOPE
	anoise	butlp	anoise,kcf			;LOWPASS FILTER THE NOISE SIGNAL
	anoise	buthp	anoise,8000			;HIGHPASS FILTER THE NOISE SIGNAL
	anoise	=	anoise*aenv			;APPLY THE AMPLITUDE ENVELOPE
	
	;MIX PULSE OSCILLATOR AND NOISE COMPONENTS
	amix	=	(amix+anoise)*ilevel*p5*0.55
	aL,aR	pan2	amix,ipan			;PAN MONOPHONIC SIGNAL
  outs	aL,aR				;SEND TO OUTPUTS
endin

;; INITIALIZATION OF SYSTEM

schedule("Clock", 0, -1)
