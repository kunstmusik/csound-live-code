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

;; Select this code and press ctrl-e to evaluate  

instr S1
  asig = vco2(ampdbfs(-12), p4) 
  asig = zdf_ladder(asig, expon(10000, p3, 400), 5)
  asig = declick(asig) * p5
outc(asig, asig)
  endin


instr P1 
  ibeat = p4

  hexplay("a8ad", ibeat, 
      "S1", p3, 
      inScale(48, 
        xosc(beatphase(ibeat, 16), fillarray(0,0,-3,-1))),
      ampdbfs(-10))

  hexplay("8", ibeat, 
      "S1", p3, 
      inScale(48, 
        xosc(beatphase(ibeat, 8), fillarray(0,7))),
      ampdbfs(-10))

endin


</CsInstruments>
</CsoundSynthesizer>

