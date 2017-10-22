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
  asig = declick(asig) * p5
  outc(asig, asig)
endin

instr P1 
  ibeat = p4

	hexplay("ff0d", ibeat,
					"Synth1", p3, inScale(60,0), 0.25)

	hexplay("8", ibeat,
					"Synth1", p3 * 3, inScale(36,0), ampdbfs(-20))

	hexplay("f0d0d0f0", ibeat, 
					"Synth1", p3, inScale(48,0))

  /*if(hexbeat("8000", ibeat) == 1) then*/
  /*  schedule("Synth1", 0, p3 * 8, inScale(72, 0) )*/
  /*endif*/
  /*if(hexbeat("80000000", ibeat) == 1) then*/
  /*  schedule("Synth1", 0, p3, inScale(55, 0) )*/
  /*endif*/

  /*if(hexbeat("cadffdac", ibeat) == 1) then*/
  /*  schedule("Synth1", 0, p3, inScale(72, 0) )*/
  /*endif*/
  /*if(hexbeat("a000a000", ibeat) == 1) then*/
  /*  schedule("Synth1", 0, p3, inScale(96, 0) )*/
  /*endif*/

	hexplay("fa", ibeat, 
					"Synth1", p3, 
					inScale(60, 
									int(cosr(beatphase(ibeat, 64), 16, 0))),
					ampdbfs(cosr(beatphase(ibeat, 64), 10, -10)))

endin

</CsInstruments>
</CsoundSynthesizer>

