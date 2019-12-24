;; Author: Steven Yi
;; Description: Groove
;; Date: 2019-12-24

start("ReverbMixer")

instr S1
  asig = vco2(p5, p4, 10)
  asig *= expseg:a(0.01, 0.015, 1, 0.1, 0.001, p3, 0.001)
  
  pan_verb_mix(asig, 0.5, 0.3)
  
endin

instr P1
  hexplay("f",
      "Sub5", p3,
      in_scale(-1, 2 + cycle(p4 % 33 % 17, array(0,2,3,5,2,4,3))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Sub5", p3,
      in_scale(0, hexbeat("3434ffe") * 4 + cycle(p4 % 23 % 11, array(0,2,3,5,2,4,3))),
      fade_in(8, 128) * ampdbfs(-9))

  hexplay("f",
      "Sub5", p3,
      in_scale(1, (p4 << (p4 & 0x5)) % 11),
      fade_in(6, 128) * ampdbfs(xlin(phsm(4), -6, -18)))
  
  hexplay("f",
      "S1", p3,
      in_scale(0, hexbeat("34ffe34") * 4 + cycle(p4 % 23 % 13, array(0,2,3,5,2,4,3))),
      fade_in(7, 128) * ampdbfs(-15))
  
  hexplay("e322",
      "S1", p3,
      in_scale(1, hexbeat("4ffe343") * 4 + cycle(p4 % 23 % 13, array(0,2,3,5,2,4,3))),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("f",
      "S1", p3,
      in_scale(0, hexbeat("fe3434f") *2 + cycle(p4 % 23 % 13, array(0,2,3,5,2,4,3))),
      fade_in(7, 128) * ampdbfs(-18))
  
  hexplay("f",
      "Sub6", p3 * 0.8,
      in_scale(-2, 2 + (p4 >> (p4 & 0x3)) % 5),
      fade_in(9, 128) * ampdbfs(-9))

endin
