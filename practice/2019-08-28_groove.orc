;; Author: Steven Yi
;; Description: Groove
;; Date: 2019-08-28

start("ReverbMixer")

set_tempo(102)

xchnset("rvb.default", 0.5)
xchnset("drums.rvb.default", 0.3)

instr P1
  
  hexplay("f",
      "Mode1", p3,
      in_scale(0, cycle(p4 % 17 % 4, array(0,2,4,5,7))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Mode1", p3,
      in_scale(0, 2 + cycle(p4 % 17 % 4, array(0,2,4,5,7))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("0ff0",
      "Mode1", p3,
      in_scale(0, 4 + cycle(p4 % 23 % 4, array(0,2,4,5,7))),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("03ffe0",
      "Mode1", p3,
      in_scale(0, 6 + cycle(p4 % 23 % 3, array(0,2,4,5,7))),
      fade_in(8, 128) * ampdbfs(-12))
  
  hexplay("fc03",
      "Sub5", p3,
      in_scale(-1, cycle(p4 % 31 % 7, array(2,4,6,8))),
      fade_in(11, 128) * ampdbfs(-15))

  hexplay("f",
      "Sub5", p3,
      in_scale(-2, cycle(p4, array(0,4,7,4))),
      fade_in(12, 128) * ampdbfs(xlin(phsm(8), -12, -30)))
  
  hexplay("f",
      "Sub5", p3,
      in_scale(-1, 4 + (p4 << (p4 & 0x17)) % 63 % 13),
      fade_in(13, 128) * ampdbfs(-12))

  hexplay("f",
      "Sub1", p3,
      in_scale(1, 2),
      fade_in(9, 128) * ampdbfs(xoscim(8, array(-30, -18))))
  
  hexplay("f",
      "Sub1", p3,
      in_scale(1, 4),
      fade_in(10, 128) * ampdbfs(xoscim(7.7, array(-30, -18))))

  hexplay("a",
      "Organ2", p3 * 2,
      in_scale(-1, 2 + (p4 << (p4 & 0x13)) % 47 % 11),
      fade_in(14, 128) * ampdbfs(-9) * choose(0.5))

endin
