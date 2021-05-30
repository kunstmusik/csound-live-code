;; Author: Steven Yi
;; Date: 2021-05-30
;; Description: Synth Groove 

start("ReverbMixer")

xchnset("SynBrass.rvb", 0.4)

instr Syn1
  asig = vco2(p5, p4)
  asig += vco2(p5 * 0.25, p4 * 2)
  
  asig = zdf_ladder(asig, cpsoct(linseg(13.5, .05, 10, p3, 9)), 2)
  
  asig *= linen:a(.7, 0, p3, .01)
  pan_verb_mix(asig, 0.5, 0.2)
endin

instr Syn2
  asig = vco2(p5, p4, 10)
  asig += vco2(p5 * 0.25, p4 * 2, 12)
  
  asig = zdf_ladder(asig, cpsoct(linseg(14, .05, 10, p3, 9)), 1)
  
  asig *= linen:a(.7, 0, p3, .01)
  pan_verb_mix(asig, 0.5, 0.2)
endin

instr R1
  iv = cycle(p4, array(0,2,4,7,9))
  idiv = cycle(p4 % 64 % 17, array(.25,.25,.5))
  idur = beats(idiv)
  schedule("Syn1", 0, idur * 0.95, in_scale(1, iv), ampdbfs(-15))
  if(hexbeat("f374d") == 1) then
    schedule("Syn1", 0, idur * 0.95, in_scale(1, iv + 4), ampdbfs(-15))  
  endif
  schedule(p1, next_beat(idiv), 0, p4 + 1)
endin
schedule("R1", next_beat(), 0)

instr P1  
  
  if(hexbeat("8000c000") == 1) then
    ibase = 0
    iamp = -30
    schedule("Organ3", 0, p3, in_scale(0, ibase), ampdbfs(iamp))
    schedule("Organ3", 0, p3, in_scale(0, ibase + 2), ampdbfs(iamp))    
    schedule("Organ3", 0, p3, in_scale(0, ibase + 4), ampdbfs(iamp))        
    schedule("Organ3", 0, p3, in_scale(0, ibase + 6), ampdbfs(iamp))            
  endif

  hexplay("f",
      "Syn2", p3,
      in_scale(2, cycle(p4 % 64 % 37 % 11, array(0,2,4,7,4))),
      fade_in(9, 128) * ampdbfs(xoscim(8, array(-30, -18))))
  
  hexplay("02222222",
      "Syn1", p3,
      in_scale(0, 2),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("a",
      "SynBrass", p3,
      in_scale(2, 4),
      fade_in(11, 128) * ampdbfs(xlin(phsm(8), -10, -48)))

  hexplay("92c00000",
      "Sub2", p3,
      in_scale(1, 4),
      fade_in(10, 128) * ampdbfs(-6))
  
  hexplay("d2",
      "Syn1", p3,
      in_scale(-2, xoscib(2, array(0,11,3))),
      fade_in(6, 128) * ampdbfs(-12))

endin
