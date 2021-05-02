;; Author: Steven Yi
;; Date: 2021-05-02
;; Description: Chill Rhythm 

set_tempo(92)
set_scale("maj")
start("ReverbMixer")

instr Syn1
  asig = oscili(p5, p4)
  asig += oscili(p5 * .25, p4 * 2)   
  
  asig *= expseg(.001, .02, 1, .5, .0001)
  
  asig *= linen:a(1, 0, p3, .01)
  
  pan_verb_mix(asig, 0.5, 0.3)
endin

instr Syn2
  asig = vco2(p5, p4, 4, .37)
  asig += vco2(p5, p4 * semitone(lfo:k(random:i(-.1, .1), 4.7)), 4, .37)
  asig += vco2(p5, p4 * 2 * semitone(lfo:k(random:i(-.1, .1), 2.7)), .37)  
  
  kenv = expseg(1, .3, .0001)
  asig = zdf_2pole(asig, cpsoct(9.5 + kenv * 2.5), 1)
  
  a1 = reson(asig, 2000, 200) * ampdbfs(-48)
  a1 += reson(asig, 1330, 100) * ampdbfs(-47)  
  a1 += reson(asig, 1577, 120) * ampdbfs(-45)    
  
  asig += a1
  
  asig *= linen:a(.15, 0, p3, .01)
  
  pan_verb_mix(asig, 0.5, 0.2)
endin


instr P1
  hexplay("a",
      "Syn1", p3,
      in_scale(1, xosc(phsb(4), array(7,6,4,2,0,2,4,6))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("342434", p4 % 17,
      "Syn2", p3,
      in_scale(-2, xosc(phsm(2) + phsb(1.7), array(0, 24))),
      fade_in(6, 128) * ampdbfs(-15))
  
  hexplay("f",
      "Syn2", p3,
      in_scale(1, cycle(p4 % 64 % 37 % 11, array(0,4,2,7,9,6,7,4,2,3,1,2))),
      fade_in(9, 128) * ampdbfs(-15))

  hexplay("f", 
      "Syn1", p3,
      in_scale(0, 4 + xosc(phsb(4), array(0,2,4,7))),
      fade_in(8, 128) * ampdbfs(xoscim(8, array(-20, -12))))
  
  hexplay("9268",
      "Syn1", p3,
      in_scale(1, 0),
      fade_in(10, 128) * ampdbfs(-12))


endin
