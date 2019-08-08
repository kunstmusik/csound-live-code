; Author: Steven Yi
; Description: Groove
; Date: 2019-08-07

start("ReverbMixer")

set_tempo(92)

chnset(0.5, "Organ1.rvb")

instr P1
  
  hexplay("f",
      "Mode1", p3,
      in_scale(1, 2),
      fade_in(10, 128) * ampdbfs(-9 - 3 * hexbeat("f3bed3bd")))

  
  hexplay("f",
      "Organ1", p3,
      in_scale(0, xoscm(1, array(0,2,3,4)) + xosc(phs(2), array(0,7))),
      fade_in(5, 128) * ampdbfs(-13))
  
  hexplay("f",
      "Organ1", p3,
      in_scale(0, 4 + xoscm(1, array(0,2,3,4)) + xosc(phs(2), array(0,7))),
      fade_in(11, 128) * ampdbfs(-12))

  
  hexplay("f",
      "Organ2", p3,
      in_scale(-2, (p4 << (p4 & 0x32)) % 5),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Organ2", p3,
      in_scale(-1, 2 + (p4 << (p4 & 0x32)) % 19 % 4),
      fade_in(7, 128) * ampdbfs(-12))
  
  chnset(random:i(0.3, 0.7), "Sub5.pan")
  hexplay("f",
      "Sub5", p3,
      in_scale(0, (p4 << (p4 & 0x29)) % 7),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("f",
      "Sub5", p3,
      in_scale(0, 2 + (p4 << (p4 & 0x29)) % 7 % 4),
      fade_in(9, 128) * ampdbfs(-12))



  
endin
