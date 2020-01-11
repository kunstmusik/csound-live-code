;; Author: Steven Yi
;; Description: Impulse Machine
;; Date: 2020.01.11

instr S1
  ipch = p4
  asrc = mpulse(1, 1/ipch * 16)
  ;asrc += random:a(-.2, .2) * expseg:a(1, .1, 0.001, p3, 0.001)
  
  asig = mode(asrc, ipch, 12)
  asig += mode(asrc, ipch * 1.17, 12)  
  asig += mode(asrc, ipch * 1.7, 12)  
  asig += mode(asrc, ipch * 2.47, 15)  
  asig += mode(asrc, ipch * 4.47, 20)    
  asig += mode(asrc, ipch * 12.47, 3) * 0.1
  
  asig *= 0.25 * p5
  
  ;asig = limit(asig, -1, 1)
  asig = zdf_2pole(asig, ipch * 0.5, 2, 1)
  
  ;asig *= expon:a(1, p3, 0.001)
  asig *= linen:a(1, 0, p3, 0.01)  
  
  out(asig, asig)
  
endin

instr P1
  hexplay("f",
      "S1", p3,
      in_scale(0, (p4 << (p4 & 0x9)) % 11),
      fade_in(5, 128) * ampdbfs(-12))
  
;  hexplay("8", "BD", p3, 0, ampdbfs(-6))

endin
