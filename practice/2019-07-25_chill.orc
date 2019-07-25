; Author: Steven Yi
; Description: Chill
; Date: 2019-07-25

start("ReverbMixer")

set_tempo(76)

chnset(0.7, "Sub6.rvb")
chnset(0.8, "Sub7.rvb")


instr P1
  hexplay("9000",
      "Organ2", p3 * xoscb(1, array(3,1)),
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("a",
      "Sub5", p3 * 2,
      in_scale(0, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("1234",
      "Organ1", p3,
      in_scale(0, 2),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("7239",
      "Organ2", p3,
      from_root(0, 4),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("f8000000",
      "Sub6", p3,
      in_scale(0, xoscb(2, array(0,4,7,11,14,14,14,14))),
      fade_in(9, 128) * ampdbfs(-15))
  
  hexplay("f",
      "Sub7", p3,
      in_scale(0, xoscib(4, array(0,xoscm(8, array(12,13,14,13))))),
      fade_in(10, 128) * ampdbfs(-15))

  hexplay("a",
      "Mode1", p3,
      in_scale(1, 4),
      fade_in(11, 128) * ampdbfs(-12) * choose(0.4))

  hexplay("8",
      "Mode1", p3,
      in_scale(2, 2),
      fade_in(12, 128) * ampdbfs(-12) * choose(0.4))

  hexplay("f",
      "Sub2", p3 * 0.5,
      in_scale(0, 2 + (p4 >> (p4 & 5)) % 4),
      fade_in(13, 128) * ampdbfs(-11))
  
endin
