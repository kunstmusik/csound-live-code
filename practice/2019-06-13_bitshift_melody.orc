; Author: Steven Yi
; Description: Bitshift melody
; Date: 2019-06-13

start("ReverbMixer")

chnset(0.5, "Mode1.pan")

instr P1
  
  hexplay("a",
      "Mode1", p3 * 4,
      in_scale(0, (p4 >> (p4 & 3)) % 6),
      fade_in(24, 128) * ampdbfs(-12) * choose(0.4))
  
  hexplay("a",
      "Mode1", p3 * 2,
      in_scale(-1, (p4 >> (p4 & 7)) % 7),
      fade_in(34, 128) * ampdbfs(-12) * choose(0.2))

  
endin
