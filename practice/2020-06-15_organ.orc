;; Author: Steven Yi
;; Date: 2020.06.15
;; Description: Organ patterns

start("ReverbMixer")

set_tempo(127)

xchnset("Organ3.rvb", 0.5)

instr P1
  
  hexplay("a",
      "Organ3", p3 * 1.8,
      in_scale(1, xoscb(7, array(0,1,4,3,2,3,1,2))),
      fade_in(20, 128) * ampdbfs(-15))
  
  hexplay("80880000",
      "Organ3", p3 * 3.9,
      in_scale(2, 0),
      fade_in(19, 128) * ampdbfs(-20))

  hexplay("f8000000",
      "Organ3", p3,
      in_scale(-1, 2 + xlin(phsb(2), 0, 21)),
      fade_in(18, 128) * ampdbfs(-12))

  hexplay("f80000000",
      "Organ3", p3,
      in_scale(-1, xlin(phsb(2), 0, 21)),
      fade_in(17, 128) * ampdbfs(-12))
  
  hexplay("aaa8",
      "Organ3", p3 * 1.9,
      in_scale(1, cycle(p4 / 2 % 31 % 17, array(2,1,-1,0,-4,-3,1,0))),
      fade_in(14, 128) * ampdbfs(-15))
  
  hexplay("8880",
      "Organ3", p3 * 3.9,
      in_scale(0, cycle(p4 / 4 % 33 % 17, array(2,1,-1,0,-4,-3,1,0))),
      fade_in(15, 128) * ampdbfs(-15))
  
  hexplay("80808000",
      "Organ3", p3 * 7.9,
      in_scale(-1, cycle(p4 / 8 % 33 % 17, array(2,1,-1,0,-4,-3,1,0))),
      fade_in(16, 128) * ampdbfs(-11))

endin
