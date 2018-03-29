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

gk_tempo init 120 

opcode set_tempo,0,i
  itempo xin
  gk_tempo init itempo
endop

opcode get_tempo,i,0
  xout i(gk_tempo)
endop

opcode go_tempo, 0, ii
  inewtempo, incr xin

  icurtempo = i(gk_tempo)
  itemp init icurtempo 

  if(inewtempo > icurtempo) ithen
    itemp = min:i(inewtempo, icurtempo + abs(incr))
    gk_tempo init itemp 
  elseif (inewtempo < icurtempo) ithen
    itemp = max:i(inewtempo, icurtempo - abs(incr))
    gk_tempo init itemp 
  endif
endop

instr Perform
  ibeat = p4

  schedule("P1", 0, p3, ibeat) 
endin

gk_clock_tick init 0
gk_now init 0

/** Returns value of now beat time
   (Code used from Thorin Kerr's LivecodeLib.csd) */
opcode now, i, 0
  xout i(gk_now)
endop

/** Returns current clock tick at init time */
opcode now_tick, i, 0
  xout i(gk_clock_tick)
endop

/** Returns duration of time in given number of beats (quarter notes) */
opcode beats, i, i
  inumbeats xin
  ibeatdur = divz(60, i(gk_tempo), -1)
  xout ibeatdur * inumbeats
endop

/** Returns duration of time in given number of ticks (16th notes) */
opcode ticks, i, i
  inumbeats xin
  ibeatdur = divz(60, i(gk_tempo), -1)
  ibeatdur = ibeatdur / 4
  xout ibeatdur * inumbeats
endop

/** Returns time from now for next beat, rounding to align
    on beat boundary. 
   (Code used from Thorin Kerr's LivecodeLib.csd) */
opcode next_beat, i, p
  ibeatcount xin
  inow = now()
  ibc = frac(ibeatcount)
  inudge = int(ibeatcount)
  iresult = inudge + ibc + (round(divz(inow, ibc, inow)) * (ibc == 0 ? 1 : ibc)) - inow
  xout beats(iresult)
endop

opcode reset_clock, 0, 0
  gk_clock_tick init 0
  gk_now init 0
endop

instr Clock ;; our clock  
  ;; tick at 1/16th note
  kfreq = gk_tempo / 60 * 4
  gk_now += (gk_tempo / 60) / kr
  kdur = 1 / kfreq
  ktrig = metro(kfreq)
  gk_clock_tick += ktrig

  schedkwhen(ktrig, 0, 0, "Perform", 0, kdur, gk_clock_tick)
endin

;; Randomization

/** Given a random chance value between 0 and 1, calculates a random value and
returns 1 if value is less than chance value. For example, giving a value of 0.7,
it can read as "70 percent of time, return 1; else 0" */
opcode choose, i, i
  iamount xin
  ival = 0

  if(random(0,1) < limit:i(iamount, 0, 1)) then
    ival = 1 
  endif
  xout ival
endop

;; Array Functions

/** Cycles through karray using index. */
opcode cycle, i, ik[]
  indx, kvals[] xin
  ival = i(kvals, indx % lenarray(kvals))
  xout ival
endop

/** Returns random item from karray. */
opcode rand, i, k[]
  kvals[] xin
  indx = int(random(0, lenarray(kvals)))
  ival = i(kvals, indx)
  xout ival
endop


;; Beats

opcode hexbeat, i, Si
  Spat, itick xin

  istrlen = strlen(Spat)

  iout = 0

  if (istrlen > 0) then
    ;; 4 bits/beats per hex value
    ipatlen = strlen(Spat) * 4
    ;; get beat within pattern length
    itick = itick % ipatlen
    ;; figure which hex value to use from string
    ipatidx = int(itick / 4)
    ;; figure out which bit from hex to use
    ibitidx = itick % 4 
    
    ;; convert individual hex from string to decimal/binary
    ibeatPat = strtol(strcat("0x", strsub(Spat, ipatidx, ipatidx + 1))) 

    ;; bit shift/mask to check onset from hex's bits
    iout = (ibeatPat >> (3 - ibitidx)) & 1 
  endif

  xout iout

endop


/** Given hex beat pattern, use given itick to fire 
  events for given instrument, duration, frequency, and
  amplitude */
opcode hexplay, 0, SiSiip
  Spat, itick, Sinstr, idur, ifreq, iamp xin

  if(iamp > 0 && hexbeat(Spat, itick) == 1) then
    schedule(Sinstr, 0, idur, ifreq, iamp )
  endif
endop

/** Given hex beat pattern, use global clock to fire 
  events for given instrument, duration, frequency, and
  amplitude */
opcode hexplay, 0, SSiip
  Spat, Sinstr, idur, ifreq, iamp xin

  itick = i(gk_clock_tick)

  if(iamp > 0 && hexbeat(Spat, itick) == 1) then
    schedule(Sinstr, 0, idur, ifreq, iamp )
  endif
endop


opcode octalbeat, i, Si
  Spat, itick xin

  ;; 3 bits/beats per octal value
  ipatlen = strlen(Spat) * 4
  ;; get beat within pattern length
  itick = itick % ipatlen
  ;; figure which octal value to use from string
  ipatidx = int(itick / 3)
  ;; figure out which bit from octal to use
  ibitidx = itick % 3 
  
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

opcode octalplay, 0, SSiip
  Spat, Sinstr, idur, ifreq, iamp xin

  itick = i(gk_clock_tick)

  if(octalbeat(Spat, itick) == 1) then
    schedule(Sinstr, 0, idur, ifreq, iamp )
  endif
endop

;; Phase Functions

/** Given period in ticks, return current phase of global
  clock in range [0-1) */
opcode phs, i, i
  iticks xin
  xout (i(gk_clock_tick) % iticks) / iticks
endop

/** Given period in beats, return current phase of global
  clock in range [0-1) */
opcode phsb, i, i
  ibeats xin
  iticks = ibeats * 4
  xout (i(gk_clock_tick) % iticks) / iticks
endop

/** Given period in measures, return current phase of global
  clock in range [0-1) */
opcode phsm, i, i
  imeasures xin
  iticks = imeasures * 4 * 4
  xout (i(gk_clock_tick) % iticks) / iticks
endop

/** Given count and period, return phase value in range [0-1) */
opcode phs, i, ii
  icount, iperiod xin
  xout (icount % iperiod) / iperiod 
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
  itick, ihits, isteps xin
  Sval = euclid_str(ihits, isteps)
  indx = itick % strlen(Sval)
  xout strtol(strsub(Sval, indx, indx + 1))
endop

opcode euclidplay, 0, iiiSiip
  ihits, isteps, itick, Sinstr, idur, ifreq, iamp xin

  if(euclid(itick, ihits, isteps) == 1) then
    schedule(Sinstr, 0, idur, ifreq, iamp)
  endif
endop


opcode euclidplay, 0, iiSiip
  ihits, isteps, Sinstr, idur, ifreq, iamp xin

  itick = i(gk_clock_tick)

  if(euclid(itick, ihits, isteps) == 1) then
    schedule(Sinstr, 0, idur, ifreq, iamp)
  endif
endop

;; Phase-based Oscillators 

/** Returns cosine of given phase (0-1.0) */
opcode xcos, i,i
  iphase  xin
  xout cos(2 * $M_PI * iphase)
endop

/** Range version of xcos, similar to Impromptu's cosr 
  xcos(iphase, ioffset, irange)
  */
opcode xcos, i,iii
  iphase, ioffset, irange  xin
  xout ioffset + (cos(2 * $M_PI * iphase) * irange)
endop

/** Returns sine of given phase (0-1.0) */
opcode xsin, i,i
  iphase  xin
  xout sin(2 * $M_PI * iphase)
endop

/** Range version of xcos, similar to Impromptu's cosr 
  xcos(iphase, ioffset, irange)
  */
opcode xsin, i,iii
  iphase, ioffset, irange  xin
  xout ioffset + (sin(2 * $M_PI * iphase) * irange)
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

;; String functions

/** 
  rotate - Rotates string by irot number of values. 
  
  Inspired by rotate from Charlie Roberts' Gibber.
*/
opcode rotate, S, Si
  Sval, irot xin

  ilen = strlen(Sval)
  irot = irot % ilen
  Sout = strcat(strsub(Sval, irot, ilen), strsub(Sval, 0, irot))
  xout Sout
endop


/** Repeats a given String x number of times. For example:

  Sval = strrep("ab6a", 2)

  will produce the value of "ab6aab6a"

  Useful in working with Hex beat strings  
*/
opcode strrep, S, Si
  Sval, inum xin
    
  Sout = Sval
  indx = 1
  while (indx < inum) do
    Sout = strcat(Sout, Sval) 
    indx += 1
  od

  xout Sout
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

  ioct = int(idegree / idegrees)
  indx = idegree % idegrees

  if(indx < 0) then
    ioct -= 1
    indx += idegrees
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

/** Redefines instr to empty body. Useful for killing
  temporal recursion or clock callback functions */
opcode clear_instr, 0,S
  Sinstr xin
  Sinstr_body = sprintf("instr %s\nendin\n", Sinstr)
  ires = compilestr(Sinstr_body)
  prints(sprintf("Cleared instrument definition: %s\n", 
          Sinstr))
endop


;; Fades (Experimental)

opcode fade_in, i, ii
  ident, inumticks xin
  Schan = sprintf("fade_chan_%d", ident)
  ival = limit:i(chnget:i(Schan) + 1, 0, inumticks) 
  chnset(ival, Schan)

  xout ival / inumticks 
endop

opcode fade_out, i, ii
  ident, inumticks xin
  Schan = sprintf("fade_chan_%d", ident)
  ival = limit:i(chnget:i(Schan) - 1, 0, inumticks) 
  chnset(ival, Schan)

  xout ival / inumticks 
endop

/*opcode set_fade, 0,ii*/
/*  ident, ival xin*/
/*  Schan = sprintf("fade_chan_%d", ident)*/
/*  ival = limit:i(chnget:i(Schan) - 1, 0, inumticks) */
/*  chnset(ival, Schan)*/
/*endop*/

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


/* Subtractive Synth, three detuned saws, swells in */
instr Sub3 
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 1.01)
  asig += vco2(p5, p4 * 0.995)
  asig *= 0.33 
  asig = zdf_ladder(asig, expon(100, p3, 22000), 12) 
  asig = declick(asig)
  outc(asig, asig)
endin

/* Subtractive Synth, detuned square/saw, stabby. 
   Nice as a lead in octave 2, nicely grungy in octave -2, -1
*/
instr Sub4 
  asig = vco2(0.5, p4 * 2)
  asig += vco2(0.5, p4 * 2.01, 10)
  asig += vco2(1, p4, 10)
  asig += vco2(1, p4 * 0.99)
  itarget = p4 * 2
  asig = zdf_ladder(asig, expseg(20000, 0.15, itarget, 0.1, itarget), 5)
  asig = declick(asig) * p5 * 0.15
  outc(asig, asig)
endin


/* Subtractive Synth, detuned square/triangle */
instr Sub5
  asig = vco2(0.5, p4, 10)
  asig += vco2(0.25, p4 * 2.0001, 12)
  asig = zdf_ladder(asig, expseg(10000, 0.1, 500, 0.1, 500), 2)
  asig = declick(asig) * p5 * 0.75
  outc(asig, asig)
endin


/** Plucky sound */
instr Plk 
  asig = rand:a(1.0) * expon(0.25, 0.1, 0.001)
  asig = zdf_ladder(asig, 2500, 15)
  asig = comb(asig, 2, 1 / p4) 
  asig += vco2(0.25, p4) * expon(0.5, 0.2, 0.001)
  asig = zdf_ladder(asig, expon(8000, 0.12, p4 * 2), 1)
  asig = declick(asig) * p5 * 5

  outc(asig, asig)
endin

/** 303-style Bass sound */

instr Bass

  acut = 200 + expon(1, p3, 0.001) * 16000
  asig = vco2(1, p4)
  asig = diode_ladder(asig, acut, 10, 1, 4) 
  asig = tanh(asig * 4) * p5 * 0.5
  asig = declick(asig) 


  outc(asig, asig)

endin


/* VoxHumana Patch */

instr VoxHumana 
  ipch = p4 
  iamp = p5 
  aenv = transegr:a(0, 0.453, 1, 1.0, 2.242, -1, 0)

  klfo_pulse_width = lfo(0.125, 5.72, 1)
  klfo_saw = lfo(0.021, 5.04, 1)
  klfo_pulse = lfo(0.013, 3.5, 1)

  asaw = vco2(iamp, ipch * (1 + klfo_saw))
  apulse = vco2(iamp, ipch * (1.00004 + klfo_pulse), 2, 0.625 + klfo_pulse_width)

  aout = sum(asaw, apulse) * 0.0625 * aenv

  ikeyfollow = 1 + exp( (ipch - 50) / 10000)

  aout = butterlp(aout, 1986 * ikeyfollow)

  outc(aout, aout)
endin

/* FM 3:1 C:M ratio, 2->0.025 index, nice for bass */
instr FM1 
  icar = xchan("FM1.car", 1)
  imod = xchan("FM1.mod", 3)
  asig = foscili(p5, p4, icar, imod, expon(2, 0.2, 0.025))
  asig = declick(asig) * 0.5
  outc(asig, asig)
endin

/* Filtered noise, exponential envelope */
instr Noi 
  p3 = max:i(p3, 0.4) 
  asig = pinker() * p5 * expon(1, p3, 0.001) * 0.1

  a1 = mode(asig, p4, 80)
  a2 = mode(asig, p4 * 2, 40)
  a3 = mode(asig, p4 * 3, 30)
  a4 = mode(asig, p4 * 4, 20)

  asig sum a1, a2, a3, a4

  asig = declick(asig) * 0.25

  outc(asig, asig)
endin


/* Based on Jacob Joaquin's "Tempo-Synced Wobble Bass" */
instr Wobble
  /*p3 = max:i(p3, 0.4) */

  itri = chnget:i("Wobble.triangle")
  if(itri == 0) then
    ;; unipolar triangle
    itri = ftgen(0, 0, 8192, -7, 0, 4096, 1, 4096, 0)
    chnset(itri, "Wobble.triangle")
  endif

  ;; dur in ticks (16ths) for wobble lfo 
  iticks = xchan("Wobble.ticks", 2)
  ;; modulation max
  imod = p4 * 8 

  klfo = oscili:k(1, 1 / ticks(iticks), itri)

  asig = vco2(p5, p4 * 2.018)
  asig += vco2(p5, p4, 10)
  asig = zdf_ladder(asig, min:k(p4 + (imod * klfo), 22000), 12) 
  asig *= expon(1, beats(16), 0.001)
  asig = declick(asig)
  outc(asig, asig)

endin


;; DRUMS


;; Modified clap instrument by Istvan Varga (clap1.orc)
instr Clap
  ifreq = p4 ;; ignore
  iamp = p5

  ibpfrq  =  1046.5       /* bandpass filter frequency */
  kbpbwd =  port:k(ibpfrq*0.25, 0.03, ibpfrq*4.0)   /* bandpass filter bandwidth */
  idec  =  0.5          /* decay time        */

  a1  =  1.0
  a1_ delay1 a1
  a1  =  a1 - a1_
  a2  delay a1, 0.011
  a3  delay a1, 0.023
  a4  delay a1, 0.031

  a1  tone a1, 60.0
  a2  tone a2, 60.0
  a3  tone a3, 60.0
  a4  tone a4, 1.0 / idec

  aenv1 =  a1 + a2 + a3 + a4*60.0*idec

  a_  unirand 2.0
  a_  =  aenv1 * (a_ - 1.0)
  a_  butterbp a_, ibpfrq, kbpbwd

  aout = a_ * 80 * iamp ;; 
  al, ar pan2 aout, 0.7
  outc(al, ar)

endin


;; Bass Drum - From Iain McCurdy's TR-808.csd

gi_808_sine  ftgen 0,0,1024,10,1   ;A SINE WAVE
gi_808_cos ftgen 0,0,65536,9,1,1,90  ;A COSINE WAVE 

instr BD  ;BASS DRUM
  p3  = 2 * xchan("BD.decay", 0.5)              ;NOTE DURATION. SCALED USING GUI 'Decay' KNOB

  ilevel = xchan("BD.level", 1) * 2
  itune = xchan("BD.tune", 0)
  ipan = xchan("BD.pan", 0.5)

  ;SUSTAIN AND BODY OF THE SOUND
  kmul = transeg(0.2,p3*0.5,-15,0.01, p3*0.5,0,0)         ;PARTIAL STRENGTHS MULTIPLIER USED BY GBUZZ. DECAYS FROM A SOUND WITH OVERTONES TO A SINE TONE.
  kbend = transeg(0.5,1.2,-4, 0,1,0,0)            ;SLIGHT PITCH BEND AT THE START OF THE NOTE 
  asig = gbuzz(0.5,50*octave(itune)*semitone(kbend),20,1,kmul,gi_808_cos)   ;GBUZZ TONE
  aenv = transeg:a(1,p3-0.004,-6,0)             ;AMPLITUDE ENVELOPE FOR SUSTAIN OF THE SOUND
  aatt = linseg:a(0,0.004,1, .01, 1)              ;SOFT ATTACK
  asig= asig*aenv*aatt

  ;HARD, SHORT ATTACK OF THE SOUND
  aenv  = linseg:a(1,0.07,0, .01, 0)              ;AMPLITUDE ENVELOPE (FAST DECAY)            
  acps = expsega(400,0.07,0.001,1,0.001)            ;FREQUENCY OF THE ATTACK SOUND. QUICKLY GLISSES FROM 400 Hz TO SUB-AUDIO
  aimp = oscili(aenv,acps*octave(itune*0.25),gi_808_sine)       ;CREATE ATTACK SOUND
  
  amix  = ((asig*0.5)+(aimp*0.35))*ilevel*p5      ;MIX SUSTAIN AND ATTACK SOUND ELEMENTS AND SCALE USING GUI 'Level' KNOB
  
  aL,aR pan2  amix,ipan             ;PAN THE MONOPHONIC SOUND
  outc(aL,aR)             ;SEND AUDIO TO OUTPUTS
endin


;; Snare Drum - From Iain McCurdy's TR-808.csd
instr SD  ;SNARE DRUM
  
  ;SOUND CONSISTS OF TWO SINE TONES, AN OCTAVE APART AND A NOISE SIGNAL
  idur = xchan("SD.decay", 1.0) 
  ilevel = xchan("SD.level", 1) 
  itune = xchan("SD.tune", 0)
  ipan = xchan("SD.pan", 0.5)

  ifrq    = 342   ;FREQUENCY OF THE TONES
  iNseDur = 0.3 * idur  ;DURATION OF THE NOISE COMPONENT
  iPchDur = 0.1 * idur  ;DURATION OF THE SINE TONES COMPONENT
  p3  = iNseDur   ;p3 DURATION TAKEN FROM NOISE COMPONENT DURATION (ALWATS THE LONGEST COMPONENT)
  
  ;SINE TONES COMPONENT
  aenv1 = expseg(1, iPchDur, 0.0001, p3-iPchDur, 0.0001)    ;AMPLITUDE ENVELOPE
  apitch1 = oscili(1, ifrq * octave(itune), gi_808_sine)      ;SINE TONE 1
  apitch2 = oscili(0.25, ifrq * 0.5 * octave(itune), gi_808_sine)   ;SINE TONE 2 (AN OCTAVE LOWER)
  apitch  = (apitch1+apitch2)*0.75        ;MIX THE TWO SINE TONES

  ;NOISE COMPONENT
  aenv2 = expon(1,p3,0.0005)          ;AMPLITUDE ENVELOPE
  anoise = noise(0.75, 0)           ;CREATE SOME NOISE
  anoise = butbp(anoise, 10000*octave(itune), 10000)    ;BANDPASS FILTER THE NOISE SIGNAL
  anoise = buthp(anoise, 1000)          ;HIGHPASS FILTER THE NOISE SIGNAL
  kcf = expseg(5000, 0.1, 3000, p3-0.2, 3000)     ;CUTOFF FREQUENCY FOR A LOWPASS FILTER
  anoise = butlp(anoise,kcf)                      ;LOWPASS FILTER THE NOISE SIGNAL
  amix  = ((apitch*aenv1)+(anoise*aenv2))*ilevel*p5 ;MIX AUDIO SIGNALS AND SCALE ACCORDING TO GUI 'Level' CONTROL

  aL,aR pan2  amix,ipan         ;PAN THE MONOPHONIC AUDIO SIGNAL
  outs  aL,aR           ;SEND AUDIO TO OUTPUTS
endin


;; Open High Hat - From Iain McCurdy's TR-808.csd
instr OHH ;OPEN HIGH HAT

  idur = xchan("OHH.decay", 1.0)  
  ilevel = xchan("OHH.level", 1) 
  itune = xchan("OHH.tune", 0)
  ipan = xchan("OHH.pan", 0.5)
  ioct = octave:i(itune)


  kFrq1 = 296*ioct  ;FREQUENCIES OF THE 6 OSCILLATORS
  kFrq2 = 285*ioct  
  kFrq3 = 365*ioct  
  kFrq4 = 348*ioct  
  kFrq5 = 420*ioct  
  kFrq6 = 835*ioct  
  p3  = 0.5*idur    ;DURATION OF THE NOTE
  
  ;SOUND CONSISTS OF 6 PULSE OSCILLATORS MIXED WITH A NOISE COMPONENT
  ;PITCHED ELEMENT
  aenv  linseg  1,p3-0.05,0.1,0.05,0    ;AMPLITUDE ENVELOPE FOR THE PULSE OSCILLATORS
  ipw = 0.25        ;PULSE WIDTH
  a1  vco2  0.5,kFrq1,2,ipw     ;PULSE OSCILLATORS...
  a2  vco2  0.5,kFrq2,2,ipw
  a3  vco2  0.5,kFrq3,2,ipw
  a4  vco2  0.5,kFrq4,2,ipw
  a5  vco2  0.5,kFrq5,2,ipw
  a6  vco2  0.5,kFrq6,2,ipw
  amix  sum a1,a2,a3,a4,a5,a6   ;MIX THE PULSE OSCILLATORS
  amix  reson amix,5000*ioct,5000,1 ;BANDPASS FILTER THE MIXTURE
  amix  buthp amix,5000     ;HIGHPASS FILTER THE SOUND...
  amix  buthp amix,5000     ;...AND AGAIN
  amix  = amix*aenv     ;APPLY THE AMPLITUDE ENVELOPE
  
  ;NOISE ELEMENT
  anoise  noise 0.8,0       ;GENERATE SOME WHITE NOISE
  aenv  linseg  1,p3-0.05,0.1,0.05,0    ;CREATE AN AMPLITUDE ENVELOPE
  kcf expseg  20000,0.7,9000,p3-0.1,9000  ;CREATE A CUTOFF FREQ. ENVELOPE
  anoise  butlp anoise,kcf      ;LOWPASS FILTER THE NOISE SIGNAL
  anoise  buthp anoise,8000     ;HIGHPASS FILTER THE NOISE SIGNAL
  anoise  = anoise*aenv     ;APPLY THE AMPLITUDE ENVELOPE
  
  ;MIX PULSE OSCILLATOR AND NOISE COMPONENTS
  amix  = (amix+anoise)*ilevel*p5*0.55
  aL,aR pan2  amix,ipan     ;PAN MONOPHONIC SIGNAL
  outs  aL,aR       ;SEND TO OUTPUTS
endin


;; Closed High Hat - From Iain McCurdy's TR-808.csd
instr CHH ;CLOSED HIGH HAT
  idur = xchan("CHH.decay", 1.0)  
  ilevel = xchan("CHH.level", 1) 
  itune = xchan("CHH.tune", 0)
  ipan = xchan("CHH.pan", 0.5)
  ioct = octave:i(itune)

  kFrq1 = 296*ioct  ;FREQUENCIES OF THE 6 OSCILLATORS
  kFrq2 = 285*ioct  
  kFrq3 = 365*ioct  
  kFrq4 = 348*ioct  
  kFrq5 = 420*ioct  
  kFrq6 = 835*ioct  
  idur  = 0.088*idur    ;DURATION OF THE NOTE
  p3  limit idur,0.1,10   ;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)

  iohh = nstrnum("OHH")
  iactive = active(iohh)      ;SENSE ACTIVITY OF PREVIOUS INSTRUMENT (OPEN HIGH HAT) 
  if iactive>0 then     ;IF 'OPEN HIGH HAT' IS ACTIVE...
   turnoff2 iohh,0,0    ;TURN IT OFF (CLOSED HIGH HAT TAKES PRESIDENCE)
  endif

  ;PITCHED ELEMENT
  aenv  expsega 1,idur,0.001,1,0.001    ;AMPLITUDE ENVELOPE FOR THE PULSE OSCILLATORS
  ipw = 0.25        ;PULSE WIDTH
  a1  vco2  0.5,kFrq1,2,ipw     ;PULSE OSCILLATORS...     
  a2  vco2  0.5,kFrq2,2,ipw
  a3  vco2  0.5,kFrq3,2,ipw
  a4  vco2  0.5,kFrq4,2,ipw
  a5  vco2  0.5,kFrq5,2,ipw
  a6  vco2  0.5,kFrq6,2,ipw
  amix  sum a1,a2,a3,a4,a5,a6   ;MIX THE PULSE OSCILLATORS
  amix  reson amix,5000*ioct,5000,1 ;BANDPASS FILTER THE MIXTURE
  amix  buthp amix,5000     ;HIGHPASS FILTER THE SOUND...
  amix  buthp amix,5000     ;...AND AGAIN
  amix  = amix*aenv     ;APPLY THE AMPLITUDE ENVELOPE
  
  ;NOISE ELEMENT
  anoise  noise 0.8,0       ;GENERATE SOME WHITE NOISE
  aenv  expsega 1,idur,0.001,1,0.001    ;CREATE AN AMPLITUDE ENVELOPE
  kcf expseg  20000,0.7,9000,idur-0.1,9000  ;CREATE A CUTOFF FREQ. ENVELOPE
  anoise  butlp anoise,kcf      ;LOWPASS FILTER THE NOISE SIGNAL
  anoise  buthp anoise,8000     ;HIGHPASS FILTER THE NOISE SIGNAL
  anoise  = anoise*aenv     ;APPLY THE AMPLITUDE ENVELOPE
  
  ;MIX PULSE OSCILLATOR AND NOISE COMPONENTS
  amix  = (amix+anoise)*ilevel*p5*0.55
  aL,aR pan2  amix,ipan     ;PAN MONOPHONIC SIGNAL
  outs  aL,aR       ;SEND TO OUTPUTS
endin


instr HiTom ;HIGH TOM
  idur = xchan("HiTom.decay", 1.0)  
  ilevel = xchan("HiTom.level", 1) 
  itune = xchan("HiTom.tune", 0)
  ipan = xchan("HiTom.pan", 0.5)
  ioct = octave:i(itune)

  ifrq      = 200 * ioct  ;FREQUENCY
  p3      = 0.5 * idur      ;DURATION OF THIS NOTE

  ;SINE TONE SIGNAL
  aAmpEnv transeg 1,p3,-10,0.001        ;AMPLITUDE ENVELOPE FOR SINE TONE SIGNAL
  afmod expsega 5,0.125/ifrq,1,1,1      ;FREQUENCY MODULATION ENVELOPE. GIVES THE TONE MORE OF AN ATTACK.
  asig  oscili  -aAmpEnv*0.6,ifrq*afmod,gi_808_sine   ;SINE TONE SIGNAL

  ;NOISE SIGNAL
  aEnvNse transeg 1,p3,-6,0.001       ;AMPLITUDE ENVELOPE FOR NOISE SIGNAL
  anoise  dust2 0.4, 8000       ;GENERATE NOISE SIGNAL
  anoise  reson anoise,400*ioct,800,1 ;BANDPASS FILTER THE NOISE SIGNAL
  anoise  buthp anoise,100*ioct   ;HIGHPASS FILTER THE NOSIE SIGNAL
  anoise  butlp anoise,1000*ioct    ;LOWPASS FILTER THE NOISE SIGNAL
  anoise  = anoise * aEnvNse      ;SCALE NOISE SIGNAL WITH AMPLITUDE ENVELOPE
  
  ;MIX THE TWO SOUND COMPONENTS
  amix  = (asig + anoise)*ilevel*p5
  aL,aR pan2  amix,ipan       ;PAN MONOPHONIC SIGNAL
  outs  aL,aR         ;SEND AUDIO TO OUTPUTS
endin

instr MidTom ;MID TOM
  idur = xchan("MidTom.decay", 1.0) 
  ilevel = xchan("MidTom.level", 1) 
  itune = xchan("MidTom.tune", 0)
  ipan = xchan("MidTom.pan", 0.5)
  ioct = octave:i(itune)

  ifrq      = 133*ioct    ;FREQUENCY
  p3      = 0.6 * idur      ;DURATION OF THIS NOTE

  ;SINE TONE SIGNAL
  aAmpEnv transeg 1,p3,-10,0.001        ;AMPLITUDE ENVELOPE FOR SINE TONE SIGNAL
  afmod expsega 5,0.125/ifrq,1,1,1      ;FREQUENCY MODULATION ENVELOPE. GIVES THE TONE MORE OF AN ATTACK.
  asig  oscili  -aAmpEnv*0.6,ifrq*afmod,gi_808_sine   ;SINE TONE SIGNAL

  ;NOISE SIGNAL
  aEnvNse transeg 1,p3,-6,0.001       ;AMPLITUDE ENVELOPE FOR NOISE SIGNAL
  anoise  dust2 0.4, 8000       ;GENERATE NOISE SIGNAL
  anoise  reson anoise, 400*ioct,800,1  ;BANDPASS FILTER THE NOISE SIGNAL
  anoise  buthp anoise,100*ioct   ;HIGHPASS FILTER THE NOSIE SIGNAL
  anoise  butlp anoise,600*ioct   ;LOWPASS FILTER THE NOISE SIGNAL
  anoise  = anoise * aEnvNse      ;SCALE NOISE SIGNAL WITH AMPLITUDE ENVELOPE
  
  ;MIX THE TWO SOUND COMPONENTS
  amix  = (asig + anoise)*ilevel*p5
  aL,aR pan2  amix,ipan     ;PAN MONOPHONIC SIGNAL
  outs  aL,aR         ;SEND AUDIO TO OUTPUTS
endin

instr LowTom  ;LOW TOM
  idur = xchan("LowTom.decay", 1.0) 
  ilevel = xchan("LowTom.level", 1) 
  itune = xchan("LowTom.tune", 0)
  ipan = xchan("LowTom.pan", 0.5)
  ioct = octave:i(itune)

  ifrq      = 90 * ioct ;FREQUENCY
  p3    = 0.7*idur    ;DURATION OF THIS NOTE

  ;SINE TONE SIGNAL
  aAmpEnv transeg 1,p3,-10,0.001        ;AMPLITUDE ENVELOPE FOR SINE TONE SIGNAL
  afmod expsega 5,0.125/ifrq,1,1,1      ;FREQUENCY MODULATION ENVELOPE. GIVES THE TONE MORE OF AN ATTACK.
  asig  oscili  -aAmpEnv*0.6,ifrq*afmod,gi_808_sine   ;SINE TONE SIGNAL

  ;NOISE SIGNAL
  aEnvNse transeg 1,p3,-6,0.001       ;AMPLITUDE ENVELOPE FOR NOISE SIGNAL
  anoise  dust2 0.4, 8000       ;GENERATE NOISE SIGNAL
  anoise  reson anoise,40*ioct,800,1    ;BANDPASS FILTER THE NOISE SIGNAL
  anoise  buthp anoise,100*ioct   ;HIGHPASS FILTER THE NOSIE SIGNAL
  anoise  butlp anoise,600*ioct   ;LOWPASS FILTER THE NOISE SIGNAL
  anoise  = anoise * aEnvNse      ;SCALE NOISE SIGNAL WITH AMPLITUDE ENVELOPE
  
  ;MIX THE TWO SOUND COMPONENTS
  amix  = (asig + anoise)*ilevel*p5
  aL,aR pan2  amix,ipan       ;PAN MONOPHONIC SIGNAL
  outs  aL,aR         ;SEND AUDIO TO OUTPUTS
endin



;; Cymbal - From Iain McCurdy's TR-808.csd
instr Cymbal  ;CYMBAL
  idur = xchan("Cymbal.decay", 1.0) 
  ilevel = xchan("Cymbal.level", 1) 
  itune = xchan("Cymbal.tune", 0)
  ipan = xchan("Cymbal.pan", 0.5)
  ioct = octave:i(itune)

  iFrq1 = 296*ioct  ;FREQUENCIES OF THE 6 OSCILLATORS
  iFrq2 = 285*ioct
  iFrq3 = 365*ioct
  iFrq4 = 348*ioct     
  iFrq5 = 420*ioct
  iFrq6 = 835*ioct
  p3  = 2*idur  ;DURATION OF THE NOTE

  ;SOUND CONSISTS OF 6 PULSE OSCILLATORS MIXED WITH A NOISE COMPONENT
  ;PITCHED ELEMENT
  aenv  expon 1,p3,0.0001   ;AMPLITUDE ENVELOPE FOR THE PULSE OSCILLATORS 
  ipw = 0.25      ;PULSE WIDTH      
  a1  vco2  0.5,iFrq1,2,ipw   ;PULSE OSCILLATORS...  
  a2  vco2  0.5,iFrq2,2,ipw
  a3  vco2  0.5,iFrq3,2,ipw
  a4  vco2  0.5,iFrq4,2,ipw
  a5  vco2  0.5,iFrq5,2,ipw 
  a6  vco2  0.5,iFrq6,2,ipw

  amix  sum a1,a2,a3,a4,a5,a6   ;MIX THE PULSE OSCILLATORS
  amix  reson amix,5000 * ioct,5000,1 ;BANDPASS FILTER THE MIXTURE
  amix  buthp amix,10000      ;HIGHPASS FILTER THE SOUND
  amix  butlp amix,12000      ;LOWPASS FILTER THE SOUND...
  amix  butlp amix,12000      ;AND AGAIN...
  amix  = amix*aenv     ;APPLY THE AMPLITUDE ENVELOPE
  
  ;NOISE ELEMENT
  anoise  noise 0.8,0       ;GENERATE SOME WHITE NOISE
  aenv  expsega 1,0.3,0.07,p3-0.1,0.00001 ;CREATE AN AMPLITUDE ENVELOPE
  kcf expseg  14000,0.7,7000,p3-0.1,5000  ;CREATE A CUTOFF FREQ. ENVELOPE
  anoise  butlp anoise,kcf      ;LOWPASS FILTER THE NOISE SIGNAL
  anoise  buthp anoise,8000     ;HIGHPASS FILTER THE NOISE SIGNAL
  anoise  = anoise*aenv     ;APPLY THE AMPLITUDE ENVELOPE            

  ;MIX PULSE OSCILLATOR AND NOISE COMPONENTS
  amix  = (amix+anoise)*ilevel*p5*0.85
  aL,aR pan2  amix,ipan   ;PAN MONOPHONIC SIGNAL
  outs  aL,aR       ;SEND TO OUTPUTS
endin


;; Rimshot - From Iain McCurdy's TR-808.csd
giTR808RimShot  ftgen 0,0,1024,10, 0.971,0.269,0.041,0.054,0.011,0.013,0.08,0.0065,0.005,0.004,0.003,0.003,0.002,0.002,0.002,0.002,0.002,0.001,0.001,0.001,0.001,0.001,0.002,0.001,0.001  ;WAVEFORM FOR TR808 RIMSHOT

instr Rimshot ;RIM SHOT

  idur = xchan("Rimshot.decay", 1.0)  
  ilevel = xchan("Rimshot.level", 1) 
  itune = xchan("Rimshot.tune", 0)
  ipan = xchan("Rimshot.pan", 0.5)

  idur  = 0.027*idur    ;NOTE DURATION
  p3  limit idur,0.1,10     ;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)

  ;RING
  aenv1 expsega 1,idur,0.001,1,0.001    ;AMPLITUDE ENVELOPE FOR SUSTAIN ELEMENT OF SOUND
  ifrq1 = 1700*octave(itune)    ;FREQUENCY OF SUSTAIN ELEMENT OF SOUND
  aring oscili  1,ifrq1,giTR808RimShot,0    ;CREATE SUSTAIN ELEMENT OF SOUND  
  aring butbp aring,ifrq1,ifrq1*8 
  aring = aring*(aenv1-0.001)*0.5     ;APPLY AMPLITUDE ENVELOPE

  ;NOISE
  anoise  noise 1,0         ;CREATE A NOISE SIGNAL
  aenv2 expsega 1, 0.002, 0.8, 0.005, 0.5, idur-0.002-0.005, 0.0001, 1, 0.0001  ;CREATE AMPLITUDE ENVELOPE
  anoise  buthp anoise,800      ;HIGHPASS FILTER THE NOISE SOUND
  kcf expseg  4000,idur,20        ;CUTOFF FREQUENCY FUNCTION FOR LOWPASS FILTER
  anoise  butlp anoise,kcf      ;LOWPASS FILTER THE SOUND
  anoise  = anoise*(aenv2-0.001)  ;APPLY ENVELOPE TO NOISE SIGNAL

  ;MIX
  amix  = (aring+anoise)*ilevel*p5*0.8
  aL,aR pan2  amix,ipan     ;PAN MONOPHONIC SIGNAL  
  outs  aL,aR       ;SEND TO OUTPUTS
endin


;; Claves - From Iain McCurdy's TR-808.csd
instr Claves  
  idur = xchan("Claves.decay", 1.0) 
  ilevel = xchan("Claves.level", 1) 
  itune = xchan("Claves.tune", 0)
  ipan = xchan("Claves.pan", 0.5)

  ifrq  = 2500*octave(itune)  ;FREQUENCY OF OSCILLATOR
  idur  = 0.045   * idur    ;DURATION OF THE NOTE
  p3  limit idur,0.1,10     ;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)      
  aenv  expsega 1,idur,0.001,1,0.001    ;AMPLITUDE ENVELOPE
  afmod expsega 3,0.00005,1,1,1     ;FREQUENCY MODULATION ENVELOPE. GIVES THE SOUND A LITTLE MORE ATTACK.
  asig  oscili  -(aenv-0.001),ifrq*afmod,gi_808_sine,0  ;AUDIO OSCILLATOR
  asig  = asig * 0.4 * ilevel * p5    ;RESCALE AMPLITUDE
  aL,aR pan2  asig,ipan     ;PAN MONOPHONIC AUDIO SIGNAL
  outs  aL,aR       ;SEND AUDIO TO OUTPUTS
endin


;; Cowbell - From Iain McCurdy's TR-808.csd
instr Cowbell 
  idur = xchan("Cowbell.decay", 1.0)  
  ilevel = xchan("Cowbell.level", 1) 
  itune = xchan("Cowbell.tune", 0)
  ipan = xchan("Cowbell.pan", 0.5)

  ifrq1 = 562 * octave(itune) ;FREQUENCIES OF THE TWO OSCILLATORS
  ifrq2 = 845 * octave(itune) ;
  ipw   = 0.5         ;PULSE WIDTH OF THE OSCILLATOR  
  ishp  = -30   
  idur  = 0.7         ;NOTE DURATION
  p3  = 0.7*idur      ;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)
  ishape  = -30       ;SHAPE OF THE CURVES IN THE AMPLITUDE ENVELOPE
  kenv1 transeg 1,p3*0.3,ishape,0.2, p3*0.7,ishape,0.2  ;FIRST AMPLITUDE ENVELOPE - PRINCIPALLY THE ATTACK OF THE NOTE
  kenv2 expon 1,p3,0.0005       ;SECOND AMPLITUDE ENVELOPE - THE SUSTAIN PORTION OF THE NOTE
  kenv  = kenv1*kenv2     ;COMBINE THE TWO ENVELOPES
  itype = 2       ;WAVEFORM FOR VCO2 (2=PULSE)
  a1  vco2  0.65,ifrq1,itype,ipw    ;CREATE THE TWO OSCILLATORS
  a2  vco2  0.65,ifrq2,itype,ipw
  amix  = a1+a2       ;MIX THE TWO OSCILLATORS 
  iLPF2 = 10000       ;LOWPASS FILTER RESTING FREQUENCY
  kcf expseg  12000,0.07,iLPF2,1,iLPF2  ;LOWPASS FILTER CUTOFF FREQUENCY ENVELOPE
  alpf  butlp amix,kcf      ;LOWPASS FILTER THE MIX OF THE TWO OSCILLATORS (CREATE A NEW SIGNAL)
  abpf  reson amix, ifrq2, 25     ;BANDPASS FILTER THE MIX OF THE TWO OSCILLATORS (CREATE A NEW SIGNAL)
  amix  dcblock2  (abpf*0.06*kenv1)+(alpf*0.5)+(amix*0.9) ;MIX ALL SIGNALS AND BLOCK DC OFFSET
  amix  buthp amix,700      ;HIGHPASS FILTER THE MIX OF ALL SIGNALS
  amix  = amix * 0.07 * kenv * p5 * ilevel  ;RESCALE AMPLITUDE
  aL,aR pan2  amix,ipan     ;PAN THE MONOPHONIC AUDIO SIGNAL

  outs  aL,aR       ;SEND AUDIO TO OUTPUTS
endin


instr Maraca  ;MARACA
  idur = xchan("Maraca.decay", 1.0) 
  ilevel = xchan("Maraca.level", 1) 
  itune = xchan("Maraca.tune", 0)
  ipan = xchan("Maraca.pan", 0.5)
  ioct = octave:i(itune)

  idur  = 0.07*idur       ;DURATION 3
  p3  limit idur,0.1,10       ;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)
  iHPF  limit 6000*ioct,20,sr/2 ;HIGHPASS FILTER FREQUENCY  
  iLPF  limit 12000*ioct,20,sr/3  ;LOWPASS FILTER FREQUENCY. (LIMIT MAXIMUM TO PREVENT OUT OF RANGE VALUES)
  ;AMPLITUDE ENVELOPE
  iBP1  = 0.4         ;BREAK-POINT 1
  iDur1 = 0.014*idur      ;DURATION 1
  iBP2  = 1         ;BREAKPOINT 2
  iDur2 = 0.01 *idur      ;DURATION 2
  iBP3  = 0.05          ;BREAKPOINT 3
  p3  limit idur,0.1,10       ;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)
  aenv  expsega iBP1,iDur1,iBP2,iDur2,iBP3    ;CREATE AMPLITUDE ENVELOPE
  anoise  noise 0.75,0          ;CREATE A NOISE SIGNAL
  anoise  buthp anoise,iHPF       ;HIGHPASS FILTER THE SOUND
  anoise  butlp anoise,iLPF       ;LOWPASS FILTER THE SOUND
  anoise  = anoise*aenv*p5*ilevel ;SCALE THE AMPLITUDE
  aL,aR pan2  anoise,ipan     ;PAN THE MONOPONIC SIGNAL
  outs  aL,aR         ;SEND AUDIO TO OUTPUTS
endin

instr HiConga ;HIGH CONGA
  idur = xchan("HiConga.decay", 1.0)  
  ilevel = xchan("HiConga.level", 1) 
  itune = xchan("HiConga.tune", 0)
  ipan = xchan("HiConga.pan", 0.5)
  ioct = octave:i(itune)

  ifrq    = 420*ioct    ;FREQUENCY OF NOTE
  p3    = 0.22*idur     ;DURATION OF NOTE
  aenv  transeg 0.7,1/ifrq,1,1,p3,-6,0.001  ;AMPLITUDE ENVELOPE
  afrq  expsega ifrq*3,0.25/ifrq,ifrq,1,ifrq  ;FREQUENCY ENVELOPE (CREATE A SHARPER ATTACK)
  asig  oscili  -aenv*0.25,afrq,gi_808_sine   ;CREATE THE AUDIO OSCILLATOR
  asig  = asig*p5*ilevel  ;SCALE THE AMPLITUDE
  aL,aR pan2  asig,ipan     ;PAN THE MONOPHONIC AUDIO SIGNAL
  outs  aL,aR       ;SEND AUDIO TO THE OUTPUTS
endin

instr MidConga  ;MID CONGA
  idur = xchan("MidConga.decay", 1.0) 
  ilevel = xchan("MidConga.level", 1) 
  itune = xchan("MidConga.tune", 0)
  ipan = xchan("MidConga.pan", 0.5)
  ioct = octave:i(itune)

  ifrq    = 310*ioct    ;FREQUENCY OF NOTE
  p3    = 0.33*idur     ;DURATION OF NOTE
  aenv  transeg 0.7,1/ifrq,1,1,p3,-6,0.001  ;AMPLITUDE ENVELOPE 
  afrq  expsega ifrq*3,0.25/ifrq,ifrq,1,ifrq  ;FREQUENCY ENVELOPE (CREATE A SHARPER ATTACK)
  asig  oscili  -aenv*0.25,afrq,gi_808_sine   ;CREATE THE AUDIO OSCILLATOR
  asig  = asig*p5*ilevel    ;SCALE THE AMPLITUDE
  aL,aR pan2  asig,ipan     ;PAN THE MONOPHONIC AUDIO SIGNAL
  outs  aL,aR       ;SEND AUDIO TO THE OUTPUTS
endin

instr LowConga  ;LOW CONGA
  idur = xchan("MidConga.decay", 1.0) 
  ilevel = xchan("MidConga.level", 1) 
  itune = xchan("MidConga.tune", 0)
  ipan = xchan("MidConga.pan", 0.5)
  ioct = octave:i(itune)

  ifrq    = 227*ioct    ;FREQUENCY OF NOTE
  p3    = 0.41*idur     ;DURATION OF NOTE   
  aenv  transeg 0.7,1/ifrq,1,1,p3,-6,0.001  ;AMPLITUDE ENVELOPE 
  afrq  expsega ifrq*3,0.25/ifrq,ifrq,1,ifrq  ;FREQUENCY ENVELOPE (CREATE A SHARPER ATTACK)
  asig  oscili  -aenv*0.25,afrq,gi_808_sine   ;CREATE THE AUDIO OSCILLATOR
  asig  = asig*p5*ilevel  ;SCALE THE AMPLITUDE
  aL,aR pan2  asig,ipan     ;PAN THE MONOPHONIC AUDIO SIGNAL
  outs  aL,aR       ;SEND AUDIO TO THE OUTPUTS
endin

;; INITIALIZATION OF SYSTEM

schedule("Clock", 0, -1)
