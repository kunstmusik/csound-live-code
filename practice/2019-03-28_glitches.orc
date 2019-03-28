;; Author: Steven Yi
;; Title: Glitches 
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

  
  out(asig, asig)
endin
start("S2")

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
