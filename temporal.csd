;; test file for working with livecode.orc and
;; temporal recursion
<CsoundSynthesizer>
<CsOptions>
-o dac -d --port=10000
</CsOptions>
; ==============================================
<CsInstruments>

sr	=	48000
ksmps	= 16	
nchnls	=	2
0dbfs	=	1

#include "livecode.orc"

instr TRe
  indx = p4

  ;ioff = cycle(indx, array(3.5, 0.5))
  ;idur = rand(array(0.5, 0.25, 1/3))
  /*idur = cycle(indx, array(1/2, 1/4, 1/4))*/
  /*idur = beats(idur)*/

  idur = cycle(indx, array(8,1,1))
  idur = ticks(idur)

  inn = rand(array(0, 2, 4, 6, 8, 10))
  iamp = cycle(indx, array(0.125, 0.0625))

  schedule("Sub2", 0, idur * 0.8, in_scale(0, inn), iamp)

  schedule(p1, idur, idur, indx + 1 )

endin
set_scale("maj")
set_tempo(138)
schedule("TRe", 0, 1, 0)

</CsInstruments>
; ==============================================
<CsScore>



</CsScore>
</CsoundSynthesizer>

