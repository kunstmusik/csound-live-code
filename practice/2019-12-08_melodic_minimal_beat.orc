;; Author: Steven Yi
;; Description: Minimal beat with melodic bit patterns
;; Date: 2019-12-08

start("ReverbMixer")
xchnset("rvb.default", 0.05)
xchnset("drums.rvb.default", 0.05)
xchnset("Sub5.rvb", 0.5)

instr S1
  asig = mpulse(1, 0)
  asig = zdf_2pole(asig, p4, 2, 3)
  asig *= p5 * 1.2
  pan_verb_mix(asig, 0.5, 0.7)
endin

instr S2
  asig = vco2(p5, p4)
  asig *= expseg:a(1, .1, 0.001, p3, 0.0001)
  pan_verb_mix(asig, 0.5, 0.5)
endin

instr P1
  
  hexplay("924cde",
      "Sub5", p3 * 0.7,
      in_scale(-1 + (p4 >> (p4 & 0x5)) % 2, 2 + (p4 << (p4 & 0x5)) % 17 % 9),
      fade_in(15, 128) * ampdbfs(-15))
  
  hexplay("924c",
      "Sub5", p3 * 0.7,
      in_scale(-2 + (p4 >> (p4 & 0x7)) % 2, + (p4 << (p4 & 0x7)) % 17 % 7),
      fade_in(15, 128) * ampdbfs(-15))
  
  hexplay("f",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(10, 128) * ampdbfs(xlin(phsm(4), -15, -24)))
  
  hexplay("0008000c0008000f",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(14, 128) * ampdbfs(-12))
   
  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("b0000c000",
      "S2", p3,
      in_scale(-1, 0),
      fade_in(12, 128) * ampdbfs(-15))
  
  hexplay("e738400",
      "S2", p3,
      in_scale(0, 0),
      fade_in(13, 128) * ampdbfs(-18))
  
  hexplay("f00c000",
      "S1", p3,
      2000,
      fade_in(6, 128) * ampdbfs(-12))
  
  hexplay("342308be9808000",
      "S1", p3,
      1777,
      fade_in(7, 128) * ampdbfs(-12))


endin
