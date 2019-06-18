; Author: Steven Yi
; Description: Meditation
; Date: 2019-06-08

start("ReverbMixer")

instr P1
  hexplay("a",
      "Organ2", p3 * 2,
      in_scale(-1, hexbeat("74") * 7 + hexbeat("3fab3") * 2 + hexbeat("3423435") * 2),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("8000",
      "Organ2", p3 * 16,
      in_scale(-2, xoscm(4, array(4, 2, -1, 0))),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("f",
      "Organ2", p3 * 2,
      in_scale(-1, 4 + hexbeat("74") * 7 + hexbeat("3fab3") * 2 + hexbeat("3423435") * 2),
      fade_in(6, 128) * ampdbfs(-12) * choose(0.4))

  hexplay("f",
      "Organ2", p3 * 2,
      in_scale(0, 0 + hexbeat("74") * 7 + hexbeat("ab33f") * 2 + hexbeat("3534234") * 2),
      fade_in(7, 128) * ampdbfs(-12) * choose(0.2))

  hexplay("a28",
      "Organ2", p3,
      in_scale(1, 0),
      fade_in(9, 128) * ampdbfs(-12))
  
  hexplay("a",
      "Mode1", p3,
      in_scale(1, 4),
      fade_in(12, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Sub5", p3,
      in_scale(0, 4 + hexbeat("74") * 7 + hexbeat("ab33f") * 2 + hexbeat("3534234") * 2),
      fade_in(10, 128) * ampdbfs(-18) * choose(0.7))
  
  hexplay("f",
      "Sub2", p3,
      in_scale(1, (p4 >> (p4 & 7)) % 4),
      fade_in(13, 128) * ampdbfs(-12))

  hexplay("80000000",
      "VoxHumana", measures(3.5),
      in_scale(2, rand(array(0,2,4,6))),
      fade_in(11, 128) * ampdbfs(-16))
  
endin
