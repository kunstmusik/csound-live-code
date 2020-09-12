;; Author: Steven Yi
;; Date: 2020.09.12
;; Description: Snapshot from practice session live coding S1 instrument for various 
;; glassy bell sounds primarily exploring PWM duty cycle, additional sine, cutoff for filter, 
;; tempo, and rhythm offset parameters.

start("ReverbMixer")

set_tempo(88)

instr S1
  ifreq = p4
  iamp = p5
  
  asig = vco2(1, ifreq, 2, 0.4)
  asig += vco2(.5, ifreq * 1.5,2, expon(0.3, p3, 0.5))  
  asig += oscili(1, ifreq * 2)
  
  asig = zdf_ladder(asig, cpsoct(expon:a(12, p3, 5)), 0.5)
  
  asig *= linen:a(iamp * 0.3,.01, p3, .01)
  
  pan_verb_mix(asig, 0.5, 0.3)
endin

schedule("S1", 0 , 4, in_scale(1, 0), ampdbfs(-12))

instr R1
   ipch = cycle(p4, array(0,4,2,3,1))
   schedule("S1", 0 , 4, in_scale(1, ipch), ampdbfs(-12))
  
   schedule(p1, beats(rand(array(2, 1,1,0.5))), 0, p4 + 1)
endin
schedule("R1", 0, 0)

instr R2
   ipch = cycle(p4, array(0,4,2,3,1))
   schedule("S1", 0 , 4, in_scale(2, ipch), ampdbfs(-12))
  
   schedule(p1, beats(rand(array(1,.5))), 0, p4 + 1)  
endin
schedule("R2", 0, 0)
