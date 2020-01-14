;; Author: Steven Yi
;; Description: Organ Study
;; Date: 2020.01.13

start("ReverbMixer")
xchnset("Reverb.fb", 0.8)
xchnset("Organ1.rvb", 0.7)

instr P1
 
  hexplay("fff8",
      "Organ1", p3,
      in_scale(-1, (p4 & (p4 >> 0x3)) % 0xcb % 11),
      fade_in(8, 128) * ampdbfs(-3))
  
  hexplay("a2220000",
      "Organ1", p3,
      in_scale(0, 2 + (p4 & (p4 >> 0x3)) % 0xcb % 11),
      fade_in(8, 128) * ampdbfs(-3))
  
  hexplay("fe00000",
      "Organ1", p3,
      in_scale(1, 4 + (p4 & (p4 >> 0x3)) % 0x1e % 11),
      fade_in(8, 128) * ampdbfs(-15))

   hexplay("ff0000",
      "Organ1", p3,
      in_scale(-1, 2 + (p4 & (p4 << 0x5)) % 0xdb % 17),
      fade_in(8, 128) * ampdbfs(xlin(phsb(2), -18, -6)))

endin
