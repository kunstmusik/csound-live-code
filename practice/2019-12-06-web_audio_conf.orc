;; Author: Steven Yi
;; Description: End of performance code from Web Audio Conference 2019 
;; jam session
;; Date: 2019-12-06
;; Location: Cinemateket Trondheim

start("ReverbMixer")

xchnset("rvb.default", 0.3)
xchnset("drums.rvb.default", 0.3)

instr S1
  asig = vco2(p5, p4, 10)

  asig *= expon(1, p3, 0.001)
  
  pan_verb_mix(asig, 0.25, 0.7)

endin

instr S2
  asig = vco2(p5, p4, 10)

  asig *= expon(1, p3, 0.001)
  
  pan_verb_mix(asig, 0.75, 0.7)

endin

instr S3
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 0.999234234234)
  asig += vco2(p5, p4 * 1.00234204823048)  
  
  asig *= 0.3

  asig = zdf_ladder(asig, expseg:a(200, p3/2, 5000, p3/2, 200), 10)
  
;   asig *= expon(1, p3, 0.001)
  
  pan_verb_mix(asig, 0.5, 0.7)
  
endin

  schedule("S3", 0, 10, in_scale(rand(array(1, 2)), rand(array(0,1,3,4,6))), ampdbfs(-21))

instr Run
  schedule("S3", 0, 11, in_scale(rand(array(-1, 0, 1, 2)), rand(array(0,1,2,4))), ampdbfs(-36))
  schedule(p1, rand(array(1,1,2,5,8)) * 1.3, 0)
endin
schedule("Run", 0, 0)

instr P1
  hexplay("f00000000000000",
      "Sub5", p3,
      in_scale(1, 0),
      fade_in(5, 256) * ampdbfs(-31))

  hexplay("c00000000000",
      "S1", p3,
      in_scale(1, 1),
      fade_in(5, 512) * ampdbfs(-27))
  
  hexplay("3800000000",
      "S2", p3,
      in_scale(0, 0),
      fade_in(5, 512) * ampdbfs(-33))
  
  xchnset("CHH.pan", random:i(0.2, 0.8))
  
  hexplay("ff0000",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(xlin(phsb(2), -22, -16)))

  hexplay("3fc000000",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(xlin(phsb(2), -24, -18)))

  hexplay("8",
      "Organ2", p3 * 3.7,
      in_scale(-2, cycle(p4 / 4 % 17 % 7, array(0,1,2,3,4,3,4,3))),
      fade_in(7, 512) * ampdbfs(xoscim(8, array(-42, -38))))


endin

