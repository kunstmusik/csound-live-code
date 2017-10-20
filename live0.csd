;; Live Coding Practice
;; Steven Yi
;; 2017.10.20

<CsoundSynthesizer>
<CsInstruments>

sr	= 44100	
ksmps	=	64
nchnls	=	2
0dbfs	=	1

gktempo init 120 

gkscale[] = fillarray(0, 2, 3, 5, 7, 8, 10)

opcode inScale, i, ii
  ibase, idegree xin
  idegrees = lenarray:i(gkscale)
  ioct = int(idegree / idegrees)
  xout cpsmidinn(ibase + (ioct * 12) + i(gkscale, idegree % idegrees)) 
endop

opcode hexbeat, i, Si
  Spat, ibeat xin

  ibeatPat = strtol(strcat("0x", Spat)) 
  ipatlen = strlen(Spat) * 4
  indx = (ibeat % ipatlen)

  xout (ibeatPat >> (ipatlen - indx - 1)) & 1 

endop

instr Synth1
  asig = vco2(ampdbfs(-12), p4) 
  asig = zdf_ladder(asig, expon(10000, p3, 400), 5)
  outc(asig, asig)
endin

instr P1 
  ibeat = p4

  schedule("Synth1", 0, p3, inScale(67, ibeat % 8) )
  schedule("Synth1", 0, p3, inScale(60, ibeat % 4) )
  schedule("Synth1", 0, p3, inScale(48, ibeat % 32) )

  if(ibeat % 16 == 0) then
    schedule("Synth1", 0, p3 * 8, inScale(72, 0) )
  endif
  if(ibeat % 32 == 0) then
    schedule("Synth1", 0, p3, inScale(55, 0) )
  endif
  

  if(hexbeat("f0d0d0f0", ibeat % 64) == 1) then
    schedule("Synth1", 0, p3, inScale(48, 0) )
  endif
  if(hexbeat("cadffdac", ibeat % 64) == 1) then
    schedule("Synth1", 0, p3, inScale(72, 0) )
  endif
  if(hexbeat("a000a000", ibeat % 64) == 1) then
    schedule("Synth1", 0, p3, inScale(96, 0) )
  endif
endin

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

schedule("Clock", 0, -1)

</CsInstruments>
</CsoundSynthesizer>

