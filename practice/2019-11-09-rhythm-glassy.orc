;; Author: Steven Yi
;; Description: Rhythmic patterns, glassy sounds using FM+Osc
;; Data: 2019-11-09

start("ReverbMixer")

xchnset("rvb.default", 0.3)

instr S1
  amod = vco2(p4 * expon(8, p3, 1), p4)
  asig = oscili(p5, p4 + amod)
  asig += vco2(p5, p4 * 2, 10)
  
  asig = zdf_ladder(asig, expseg:a(16000, 0.2, 500, p3, 500), 14)
  
  asig = declick(asig)
  
  pan_verb_mix(asig, 0.5, 0.6)
endin

instr S2
  amod = vco2(p4 * expon(5, p3, 1), p4, 10)
  asig = oscili(p5, p4 + amod)
  asig += vco2(p5 * 0.125, p4 * 2, 12)
  
  asig = zdf_ladder(asig, expseg:a(16000, 0.2, 300, p3, 300), 8)
  
  asig = declick(asig)
  
  pan_verb_mix(asig, 0.5, 0.6)
endin


instr P1
 
  hexplay("f",
      "S1", p3,
      in_scale(0, cycle(p4 % 29 % 17 % 5, array(0,4,7,2,6,3, 2))),
      fade_in(9, 512) * ampdbfs(-15))
  
  hexplay("f",
      "S2", p3,
      in_scale(1, 4 + cycle(p4 %  31 % 17 % 5, array(0,4,7,2,6,3, 2))),
      fade_in(9, 512) * ampdbfs(-15))
 
  hexplay("f",
      "S1", p3,
      in_scale(1, cycle(p4 %  33 % 17 % 5, array(0,4,7,2,6,3, 2))),
      fade_in(9, 512) * ampdbfs(-15))

  hexplay("f",
      "S2", p3,
      in_scale(0, cycle(p4 % 17 % 5, array(0,4,7,2,6,3, 2))),
      fade_in(9, 512) * ampdbfs(-15))
 

endin
