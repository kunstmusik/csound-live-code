; Author: Steven Yi
; Description: Leftshift Joy
; Date: 2019-07-29

start("ReverbMixer")

chnset(0.7, "Sub6.rvb")
chnset(0.9, "Sub7.rvb")

instr P1
  
  hexplay("a",
      "Mode1", p3,
      in_scale(1, 1),
      fade_out(13, 128) * ampdbfs(-9))
  
  hexplay("f",
      "Sub2", p3,
      in_scale(1, (p4 << (p4 & 0x27)) % 6),
      fade_in(5, 128) * ampdbfs(-15))
  
  hexplay("f",
      "Sub5", p3,
      in_scale(-1, 2 + (p4 << (p4 & 0x3)) % 9),
      fade_out(6, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Sub7", p3,
      in_scale(0, 0 + (p4 << (p4 & 0xc)) % 9),
      fade_in(8, 128) * ampdbfs(-16))

  hexplay("f",
      "Sub7", p3,
      in_scale(0, 2 + (p4 << (p4 & 0xc)) % 9),
      fade_in(9, 128) * ampdbfs(-12))

  hexplay("f",
      "Organ2", p3,
      in_scale(-2, 2 + (p4 << (p4 & 0xe3)) % 5),
      fade_in(14, 128) * ampdbfs(-9))
  
  hexplay("f",
      "Organ2", p3,
      in_scale(-2, 6 + (p4 << (p4 & 0xe3)) % 7),
      fade_in(14, 128) * ampdbfs(-9))

endin
