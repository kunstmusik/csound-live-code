;; Author: Steven Yi
;; Date: 2021.09.30
;; Description: Synth Lines 

start("ReverbMixer")

instr Synnn
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 2) 
  
  asig = zdf_ladder(asig, xoscim(8, array(4000, 16000)), 0.5)
  
  asig *= linen:a(.5, 0,p3, .01)
  
  pan_verb_mix(asig, 0.5, 0.2)
endin

instr P1
  
  hexplay("2a0a02a0000",
      "Synnn", p3 * xoscim(4, array(0.5, 1)),
      in_scale(1, 0),
      fade_in(8, 128) * ampdbfs(-20))
  
  hexplay("f",
      "Synnn", p3,
      in_scale(0, cycle(p4 % 64 % xoscm(7, array(37, 19)) % 11, array(0,4,7,11))),
      fade_in(9, 128) * ampdbfs(-24))
  
  hexplay("c0e0",
      "Bass", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("2",
      "Bass", p3,
      in_scale(1, 3),
      fade_in(6, 128) * ampdbfs(-12))
  
  hexplay("92",
      "Bass", p3,
      in_scale(-2, xoscb(2, array(0,4,7))),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("f",
      "Bass", p3,
      in_scale(-1, xsin(phsb(4), 0, 11)),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("aa22",
      "Bass", p3,
      in_scale(2, xoscm(2, array(2,2,2,3))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("06280000",
      "Bass", p3,
      in_scale(0, 4),
      fade_in(7, 128) * ampdbfs(-12))

  
endin
