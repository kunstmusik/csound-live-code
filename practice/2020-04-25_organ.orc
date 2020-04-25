;; Author: Steven Yi
;; Description: Organ 
;; Date: 2020.04.25

start("ReverbMixer")

set_tempo(105)

xchnset("Reverb.fb", 0.75)
xchnset("Organ3.rvb", 0.5)

instr P1

  iv = p4  % 67 % 17 % 11 
  iv = cycle(iv, array(0,4,7,11,7,4))
  hexplay("f", 
      "Organ3", p3,
      in_scale(-1, iv),
      fade_in(5, 128) * ampdbfs(-12))

  iv = p4  % 43 % 17 % 11 
  iv = cycle(iv, array(0,2,4,7,8,7,6,7))
  hexplay("f", 
      "Organ3", p3,
      in_scale(0, iv),
      fade_in(7, 128) * ampdbfs(-21))

  iv = p4 % 41 % 17 % 13 
  iv = cycle(iv, array(0,2,4,7,9,7,4,2))
  hexplay("f", 
      "Organ3", p3,
      in_scale(1, iv) * random:i(0.999, 1.001),
      fade_in(8, 128) * ampdbfs(-21))

  iv = p4 % 43 % 17 % 13 
  iv = cycle(iv, array(0,2,4,7,9,7,4,2))
  hexplay("f", 
      "Organ3", p3,
      in_scale(1, iv + 2) * random:i(0.999, 1.001),
      fade_in(8, 128) * ampdbfs(-21))

  iv = p4 % 47 % 19 % 13
  iv = cycle(iv, array(0,2,4,7,9,7,4,2))
  hexplay("f", 
      "Organ3", p3,
      in_scale(0, iv),
      fade_in(10, 128) * ampdbfs(-21))


endin
