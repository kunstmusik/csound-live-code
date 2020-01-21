;; Author: Steven Yi
;; Description: Groove
;; Date: 2020.01.21

instr P1
  hexplay("aa00aa22",
      "Sub5", p3,
      in_scale(-1, (xcos(phs(p4 / 2 , 16), 8, 8) + xcos(phsb(2), 4, 4)) % 12),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("00f80000",
      "Sub5", p3,
      in_scale(0, 2 + (xcos(phs(p4, 16), 8, 8) + xcos(phsb(2), 4, 4)) % 12),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("000f8000",
      "Sub6", p3,
      in_scale(1, 2 + (xcos(phs(p4, 16), 8, 8) + xcos(phsb(2), 4, 4)) % 12),
      fade_in(5, 128) * ampdbfs(-18))
  
  hexplay("92",
      "Sub1", p3,
      in_scale(1, 2 + (xcos(phs(p4, 16), 8, 8) + xcos(phsb(2), 4, 4)) % 12),
      fade_in(5, 128) * ampdbfs(-18))
  
  hexplay("002f00",
      "Mode1", p3,
      in_scale(1, 0),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("00003fe0",
      "Bass", p3,
      in_scale(-1, 2 + (xcos(phs(p4, 16), 8, 8) + xcos(phsb(2), 4, 4)) % 12),
      fade_in(6, 128) * ampdbfs(-15))
  
  hexplay("0f0f0fff",
      "Squine1", p3,
      in_scale(1, 2 + (xcos(phs(p4, 16), 8, 8) + xcos(phsb(2), 4, 4)) % 12),
      fade_in(6, 128) * ampdbfs(-18))

  hexplay("aaaaffff",
      "Form1", p3 * 0.7,
      in_scale(1, 0),
      fade_in(8, 128) * ampdbfs(xlin(phsm(4), -12, -30)))
  
  hexplay("ffffaaaa",
      "SynBrass", p3 * 0.7,
      in_scale(1, 0),
      fade_in(9, 128) * ampdbfs(xlin(phsm(8), -12, -30)))

  hexplay("22a2",
      "Claves", p3,
      in_scale(-1, 0),
      fade_in(10, 128) * ampdbfs(-12))
  
  hexplay("92549268",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-12))

endin
