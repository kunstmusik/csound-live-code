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
  ifreq = p4
  iphs = p5

  if(choose(0.25) == 1) then 
    schedule("Sub1", 0, 
      beats(rand(array(3,7,11))), 
      ifreq * xosc(iphs / 16, array(0.5, 1, 1.5)), 
      ampdbfs(rand(array(-18, -21, -24))))
  endif

  schedule(p1, beats(rand(array(2.5, 1, 1.5))), p3, ifreq,  (iphs + 1) % 16)

endin

instr Start
  set_scale("maj")
  set_tempo(84)
  schedule("TRe", next_measure(), 1, 420, 0)
  schedule("TRe", next_measure() + measures(8), 1, 120, 0)
  schedule("TRe", next_measure() + measures(14), 1, 360, 0)
  schedule("TRe", next_measure() + measures(20), 1, 800, 0)
endin

schedule("Start", 0, 1)

/*clear_instr("TRe")*/

</CsInstruments>
; ==============================================
<CsScore>



</CsScore>
</CsoundSynthesizer>

