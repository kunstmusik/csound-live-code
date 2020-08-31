;; Author: Steven Yi
;; Date: 2020.08.30
;; Description: Randomized additive + ring modulation synthesis timbre

start("ReverbMixer")

instr S1
  
  asig = oscili(1, p4)
  asig += oscili(ampdbfs(rand(array(-6,-12,-18))), p4 * 2)  
  asig += oscili(ampdbfs(rand(array(-6,-12,-18))), p4 * 3)      
  asig += oscili(ampdbfs(rand(array(-6,-12,-18))), p4 * 4)    
  asig += oscili(ampdbfs(rand(array(-6,-12,-18))), p4 * 5)        
  asig += oscili(ampdbfs(rand(array(-6,-12,-18))), p4 * 6)  
  asig += oscili(ampdbfs(rand(array(-6,-12,-18))), p4 * 7)    
  asig += oscili(ampdbfs(rand(array(-6,-12,-18))), p4 * 8)        
  
  asig *= oscili(1, p4 * int(random:i(1,8)))
  
  asig *= expseg:a(p5, p3, 0.001)
  
  pan_verb_mix(asig, 0.5, 0.7)
endin

instr P1
  hexplay("f000",
      "S1", p3,
      in_scale(0, cycle(p4, array(0,4,2,7))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("7c00",
      "S1", p3,
      in_scale(1, 0),
      fade_in(6, 128) * ampdbfs(-12))
  
  hexplay("fd0",
      "S1", p3,
      in_scale(1, 1),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("a22",
      "S1", p3,
      in_scale(1, 2),
      fade_in(8, 128) * ampdbfs(-12))

endin
