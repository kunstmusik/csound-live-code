;; Live Coding Practice
;; Steven Yi
;; 2017.10.20

<CsoundSynthesizer>
<CsInstruments>

sr	= 44100	
ksmps	=	64
nchnls	=	2
0dbfs	=	1

#include "livecode.orc"

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

</CsInstruments>
</CsoundSynthesizer>

