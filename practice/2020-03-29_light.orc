;; Author: Steven Yi
;; Description: Light
;; Date: 2020.03.29

start("ReverbMixer")
set_tempo(98)

xchnset("Organ3.rvb", 0.5)

instr P1
  
  hexplay("f",
      "Mode1", p3,
      in_scale(2, cycle(p4 % 73 % 31 % 7, array(5,3,4,2,1))),
      fade_in(11, 128) * ampdbfs(-9))
  
  hexplay("fb34de",
      "Mode1", p3,
      in_scale(2, 2 + cycle(p4 % 73 % 31 % 7, array(5,3,4,2,1))),
      fade_in(12, 128) * ampdbfs(-12))
  
  hexplay("a",
      "Organ3", p3 * 1.7,
      in_scale(0, int(xlin(phsm(1), 1, 9))),
      fade_in(5, 512) * ampdbfs(-16))
  
  hexplay("a",
     "Organ3", p3 * 1.7,
      in_scale(0, 2 + int(xlin(phsm(1), 1, 9))),
      fade_in(10, 512) * ampdbfs(-16))

  hexplay("f",
      "Organ3", p3,
      in_scale(0, 2 + xlin(phsb(2), 1, 13)),
      fade_in(7, 128) * ampdbfs(-15))
  
  hexplay("f",
      "Organ3", p3,
      in_scale(1, cycle(p4 % 57 % 29 % 13, array(1,3,4,5,3,4,2,3))),
      fade_in(8, 128) * ampdbfs(-15))

  hexplay("f",
      "Bass", p3,
      in_scale(-1, 4 + cycle(p4 % 23 % 11, array(1,5,8,9,8))),
      fade_in(9, 128) * ampdbfs(-9))
  
endin
