; Author: Steven Yi
; Description: Patterns
; Date: 2019-06-25 

start("ReverbMixer")

set_tempo(94)

instr P1
  hexplay("aa22062a",
      "Organ2", p3 * 2,
      in_scale(-1, (p4 >> (p4 & 0x34)) % 4),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("2a8cae",
      "Organ2", p3 * 2,
      in_scale(-1, 4 + (p4 >> (p4 & 0x34)) % 4),
      fade_in(6, 128) * ampdbfs(-12))
  
  hexplay("a28a280a",
      "Organ2", p3 * 2,
      in_scale(0, (p4 >> (p4 & 0x34)) % 4),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("fba7abf",
      "Organ2", p3 * 2,
      in_scale(0, 4 + (p4 >> (p4 & 0x34)) % 4),
      fade_in(8, 128) * ampdbfs(-12))
  
endin
