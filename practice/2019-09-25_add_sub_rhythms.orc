;; Author: Steven Yi
;; Description: Additive/Subtractive Rhythms
;; Date: 2019-09-25

start("ReverbMixer")

xchnset("rvb.default", 0.4)

instr P1
  hexplay("f",
      "Sub7", p3,
      in_scale(-1, cycle(p4 % xosc(phs(25), array(3,3,3,4,3,3,4,2)), array(0,2,1,3))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Sub7", p3,
      in_scale(-1, 2 + cycle(p4 % xosc(phs(27), array(3,2,3,3,4,3,3,4,2)), array(0,1,2,1))),
      fade_in(6, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Sub7", p3,
      in_scale(1, 4 + cycle(p4 % xosc(phs(29), array(3,2,3,4,3,4,3,3,4,2)), array(0,1,2,3))),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Squine1", p3,
      in_scale(1, 1 + cycle(p4 % xosc(phs(26), array(3,2,3,4,3,4,3,4,2)), array(0,1,2,3))),
      fade_in(8, 128) * ampdbfs(-12))


endin
