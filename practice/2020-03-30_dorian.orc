;; Author: Steven Yi
;; Description: Dorian Mode
;; Date: 2020.03.30

start("ReverbMixer")

set_scale("maj")
set_tempo(96)

instr P1
  hexplay("80",
      "Organ3", p3 * 7.9,
      in_scale(-1, xlin(phsm(4), 1, 9)),
      fade_in(5, 128) * ampdbfs(-18))
  
  hexplay("08",
      "Organ3", p3 * 7.9,
      in_scale(-1, 2 + xlin(phsm(4), 1, 9)),
      fade_in(11, 128) * ampdbfs(-20))
  
  hexplay("a800",
      "Organ3", p3 * 1.8,
      in_scale(0, xoscb(2, array(1,3,2,5))),
      fade_in(7, 128) * ampdbfs(-16))

  hexplay("ff0000",
      "Organ3", p3,
      in_scale(0, xlin(phsb(2), 1, 15)),
      fade_in(8, 128) * ampdbfs(xlin(phsb(2), -16, -23)))

  hexplay("f39bde3",
      "Organ3", p3,
      in_scale(1, cycle(p4 % 101 % 47 % 17, array(1,2,3,2,3,4,5,4,3,2))),
      fade_in(9, 128) * ampdbfs(-16))

  hexplay("cf39bde3",
      "Organ3", p3,
      in_scale(1, 2 + cycle(p4 % 101 % 47 % 17, array(1,2,3,2,3,4,5,4,3,2))),
      fade_in(10, 128) * ampdbfs(-16))

endin
