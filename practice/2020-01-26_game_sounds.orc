;; Author: Steven Yi
;; Description: Game Sounds 
;; Date: 2020.01.26

start("ReverbMixer")

instr S1
  asig = random:a(-1, 1) * 0.4
  asig *= expseg:a(1, p3 * 0.5, 0.0001, p3, 0.001)
  asig = zdf_2pole(asig, oscili:a(2000, 15) + 2200, 2, 2)
  
  a1 = foscili(0.5, 800, 1, 1.73, expon(5, p3, 1)) * expon(1, p3, 0.001)
  a1 += foscili(0.5, 1100, 1, 2.73, expon(5, p3, 1)) * expon(1, p3, 0.001)  
  a1 += vco2(0.4, 60, 10)
  asig += zdf_ladder(a1, cpsoct(expseg:a(13, 0.2, 5, p3, 4)), 0.5)
  
  pan_verb_mix(asig, 0.5, 0.1)
endin

instr S2
  asig = vco2(0.25, cpsoct(line(9, p3, 10)), 10)
  asig += vco2(0.25, 2 * cpsoct(line(9, p3, 10)), 12)  
  asig *= oscili(0.5, 100)
  pan_verb_mix(asig, 0.5, 0.1)
endin

instr S3
  asig = random:a(-1, 1) * expon(0.4, p3, 0.001)
  a1 = reson(asig, 177, 400) * 0.5
  a1 += reson(asig, 300, 200) * 0.25
  a1 += reson(asig, 60, 600)  * 0.5
  
  asig += a1 
  
  ival = random:i(400, 800)
  
  asig = zdf_ladder(asig, cpsoct(linseg(8, p3, 4)), 0.5) * 0.3
  asig += oscili(0.75, 880) * oscili(1, 30) * expon(1, p3, 0.001) ;* oscili(1, 0.5/ p3)
  asig += oscili(2, randh(ival * 0.5, 16) + ival) * expon(1, p3, 0.001) ;* oscili(1, 0.5/ p3)  

  asig *= 0.4

  pan_verb_mix(asig, 0.5, 0.1)
endin

schedule("S1", 0, 1)
schedule("S2", 0, 1)
schedule("S3", 0, 3)
