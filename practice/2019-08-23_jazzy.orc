;; Author: Steven Yi
;; Description: Jazzy Beat
;; Date: 2019.08.23

set_scale("maj")
set_tempo(106)
xchnset("rvb.default", 0.5)

instr P1

  hexplay("ff800000",
      "Sub7", p3,
      from_root(-1, (p4 << (p4 & 0x13)) % 31 % 12),
      fade_in(29, 128) * ampdbfs(-12))
  
  hexplay("0ff8000",
      "Sub7", p3,
      from_root(-1, 4 + (p4 << (p4 & 0x13)) % 31 % 12),
      fade_in(30, 128) * ampdbfs(-12))

  hexplay("0ff80",
      "Sub7", p3,
      from_root(-1, 6 + (p4 << (p4 & 0x13)) % 31 % 12),
      fade_in(33, 128) * ampdbfs(-12))
  
  hexplay("0808080c0808080f",
      "SD", p3,
      in_scale(-1, 0),
      fade_in(32, 128) * ampdbfs(-12))
  
  hexplay("80",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(31, 128) * ampdbfs(-12))

  hexplay("db6",
      "Squine1", p3,
      in_scale(1, 1),
      fade_in(28, 128) * ampdbfs(-12))

  hexplay("92000000",
      "Sub2", p3,
      from_root(0, xoscb(2, array(0,1,2))),
      fade_in(27, 128) * ampdbfs(-9))

  
endin
