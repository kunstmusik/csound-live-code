; Author: Steven Yi
; Description: Modulus Modulus
; Date: 2019-08-05

start("ReverbMixer")

set_tempo(96)

chnset(0.6, "Sub6.rvb")
chnset(0.6, "Sub7.rvb")
chnset(0.6, "Organ1.rvb")
chnset(0.9, "Plk.rvb")


instr P1
  
  hexplay("a",
      "Sub2", p3,
      in_scale(2, (p4 / 2) % 13 % 3),
      fade_in(14, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Organ1", p3,
      in_scale(0, 8 - ((p4 << (p4 & 0x3)) % 17 % 5)),
      fade_in(5, 128) * ampdbfs(-10))
  
  hexplay("a",
      "Organ2", p3 * 2,
      in_scale(-2, 12 - ((p4 << (p4 & 0x3)) % 17 % 5)),
      fade_in(9, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Organ1", p3,
      in_scale(-1, ((p4 << (p4 & 0x3)) % 17 % 5)),
      fade_in(6, 128) * ampdbfs(-12) * choose(0.5))
  
  hexplay("f",
      "Mode1", p3,
      in_scale(1, (p4 << (p4 & 0x15)) % 29 % 5),
      fade_in(7, 128) * ampdbfs(-9))
  
  hexplay("f",
      "Mode1", p3,
      in_scale(1, 2 + (p4 << (p4 & 0x15)) % 29 % 5),
      fade_in(8, 128) * ampdbfs(-9) * choose(0.4))

  hexplay("f",
      "Sub5", p3,
      in_scale(0, 4 + (p4 << (p4 & 0x73)) % 7),
      fade_in(10, 128) * ampdbfs(-15))
  
  hexplay("f000",
      "Sub7", p3,
      in_scale(0, 2),
      fade_in(11, 128) * ampdbfs(xoscim(8, array(-14, -9))))
  
  hexplay("f",
      "Sub6", p3,
      in_scale(0, 5 + (p4 << (p4 % 0x27)) % 33 % 7),
      fade_in(12, 128) * ampdbfs(-14))

  hexplay("f",
      "Sub6", p3,
      in_scale(1, 0 + (p4 << (p4 % 0x27)) % 33 % 7),
      fade_in(13, 128) * ampdbfs(-15))

  hexplay("f",
      "SynBrass", p3,
      in_scale(2, xoscm(16, array(0,3,1,2))),
      fade_in(15, 128) * ampdbfs(xoscim(4, array(-20, -12))))

  hexplay("f",
      "Plk", p3,
      in_scale(2, 4),
      fade_in(16, 128) * ampdbfs(xoscim(7.7, array(-6, -9))))
  
  hexplay("f",
      "Plk", p3,
      in_scale(2, 6),
      fade_in(17, 128) * ampdbfs(xoscim(7.4, array(-6, -9))))

endin
