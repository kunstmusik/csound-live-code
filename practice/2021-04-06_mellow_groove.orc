;; Author: Steven Yi
;; Date: 2021-04-06
;; Description: Mellow groove, subtractive synths

start("ReverbMixer")
xchnset("Reverb.fb", 0.65)

instr B1
  asig = vco2(p5, p4)
  
  kenv = adsr(0.01, 0.3, 0.25, 0.1) * 5
  
  asig = zdf_ladder(asig, cpsoct(min(14.4, 5 + kenv)), 10)
  
  asig *= linen:a(1, .01, p3, .01)
  
  pan_verb_mix(asig, 0.5, 0.1)
  
endin

instr B2
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 2.0234234, 12)  
  
  kenv = adsr(0.02, 0.3, 0.25, 0.1) * 5
  
  asig = zdf_ladder(asig, cpsoct(min(14, 7 + kenv)), 5)
  
  asig *= linen:a(1, .01, p3, .01)
  
  pan_verb_mix(asig, 0.5, 0.15)
  
endin

instr B3
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * semitone(random:i(.1, .1)))  
  asig += vco2(p5, p4 * 2 * semitone(random:i(.1, .1)))    
  asig += vco2(p5, p4 * 2 * semitone(random:i(.1, .1)))      
  asig += vco2(p5, p4 * 3 * semitone(random:i(.1, .1)))        
  
  kenv = adsr(0.03, 0.1, 0.25, 0.1) * 6
  
  asig = zdf_ladder(asig, cpsoct(min(14, 7 + kenv)), 1)
  
  asig *= linen:a(.5, .01, p3, .01)
  
  pan_verb_mix(asig, 0.5, 0.25)
  
endin

instr P1
  hexplay("9200",
      "B1", p3 * 2,
      in_scale(-2, xlin(phsb(2), 0, xoscm(4, array(7, 11)))),
      fade_in(5, 128) * ampdbfs(-6))
  
  hexplay("02aa",
      "B1", p3,
      in_scale(-1, 2 + xlin(phsb(2), 0, xoscm(4, array(7, 9)))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("a22",
      "B2", p3,
      in_scale(0, 2 + xlin(phsb(2), 0, xoscm(4, array(7, 9)))),
      fade_in(7, 128) * ampdbfs(-9))

  hexplay("88808088",
      "B3", p3,
      in_scale(1, 0),
      fade_in(8, 128) * ampdbfs(-15))

endin
