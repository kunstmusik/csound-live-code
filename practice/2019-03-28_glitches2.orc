;; Author: Steven Yi
;; Title: Glitches 2
;; 2019-03-28

instr S1
  asig = vco2(0.1, 48)
  
  asig = zdf_ladder(asig, lfo:a(4000, 0.05, 1) + 5200, 7)
  asig += zdf_ladder(vco2(0.1, 48 * 2), lfo:a(4000, 0.1, 1) + 5200, 7)
  asig += zdf_ladder(vco2(0.1, 48 * 3), lfo:a(4000, 0.15, 1) + 5200, 7)
  asig += zdf_ladder(vco2(0.1, 48 * 4), lfo:a(4000, 0.5, 1) + 5200, 7)

  asig *= vco2(0.5, 0.4, 10) + 0.5
  asig *= vco2(0.5, 2.734, 10) + 0.5
  asig *= vco2(0.5, 8.734, 10) + 0.5

  asig *= 0.2
  
  out(asig, asig)
endin
start("S1")

instr S2
  asig = vco2(0.1, 88)
  
  asig = zdf_ladder(asig, lfo:a(4000, 0.05, 1) + 5200, 7)
  asig += zdf_ladder(vco2(0.1, 88 * 2), lfo:a(4000, 0.1, 1) + 5200, 7)
  asig += zdf_ladder(vco2(0.1, 88 * 3), lfo:a(4000, 0.15, 1) + 5200, 7)
  asig += zdf_ladder(vco2(0.1, 88 * 4), lfo:a(4000, 0.5, 1) + 5200, 7)

  asig *= vco2(0.5, 0.7, 10) + 0.5
  asig *= vco2(0.5, 3.734, 10) + 0.5
  asig *= vco2(0.5, 9.734, 10) + 0.5

  asig *= 0.2
  
  out(asig, asig)
endin
start("S2")
stop("S2")

instr S3
  asig = vco2(0.1, 122)
  
  asig = zdf_ladder(asig, lfo:a(4000, 0.05, 1) + 5200, 7)
  asig += zdf_ladder(vco2(0.1, 122 * 2), lfo:a(4000, 0.1, 1) + 5200, 7)
  asig += zdf_ladder(vco2(0.1, 122 * 3), lfo:a(4000, 0.15, 1) + 5200, 7)
  asig += zdf_ladder(vco2(0.1, 122 * 4), lfo:a(4000, 0.5, 1) + 5200, 7)

  asig *= vco2(0.5, 0.55, 10) + 0.5
  asig *= vco2(0.5, 4.734, 10) + 0.5
  asig *= vco2(0.5, 13.734, 10) + 0.5

  asig *= 0.2
  
  out(asig, asig)
endin
start("S3")
stop("S1")

instr S5
  kfreq = oscil:k(2000, 0.3) + 2050
  kfreq = samphold:k(kfreq, metro:k(9))
  asig = vco2(0.1,  kfreq)
  
  asig = zdf_ladder(asig, 2000, 7)
 
  asig *= lfo(0.5, 0.03, 1) + 0.5
  
  out(asig, asig)
endin
start("S5")

instr S6
  kfreq = oscil:k(1000, 0.3) + 1050
  kfreq = samphold:k(kfreq, metro:k(3.443))
  asig = vco2(0.1,  kfreq)
  
  asig = zdf_ladder(asig, 2000, 7)
 
  asig *= lfo(0.5, 0.03, 1) + 0.5
  
  asig *= 0.3
  
  out(asig, asig)
endin
start("S6")


instr S7
  kfreq = oscil:k(2000, 0.3) + 2050
  kfreq = samphold:k(kfreq, metro:k(9.443))
  asig = vco2(0.1,  kfreq)
  asig += vco2(0.1,  kfreq * 1.01324)

  
  asig = zdf_ladder(asig, 3000, 12)
 
  asig *= lfo(0.5, 0.03, 1) + 0.5
  
  asig *= 0.3
  
  out(asig, asig)
endin
start("S7")
; stop("S1")

instr Tone1
  kfreq = p4
  iamp = p5
  asig = vco2(0.1,  kfreq)
  asig += vco2(0.1,  kfreq * 1.01324, 10)
  
  asig = zdf_ladder(asig, 3000, 12)
  
  asig *= iamp * expon(1, p3, 0.001)
  
  out(asig, asig)
endin

schedule("Tone1", 0, 10, in_scale(2,rand(array(0,2,3,5))), ampdbfs(-9))

instr Run
  schedule("Tone1", 0, 10, in_scale(p4, rand(array(0,2,3,5,8))), ampdbfs(-9))

  schedule(p1, p3, p3 * rand(array(1,2,4,8)), p4)
endin

schedule("Run", 0, 3.7, -2)
