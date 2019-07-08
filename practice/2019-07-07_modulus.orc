; Author: Steven Yi
; Description: Modulus limits range, bit-and masks to possible values, the two
; together interact to form patterns 
; Date: 2019-07-07

start("ReverbMixer")

instr P1
  hexplay("a",
      "Organ1", p3 * 2,
      in_scale(-1, (p4 % 9) & 7),
      fade_in(5, 128) * ampdbfs(-15))
  
  hexplay("a",
      "Organ1", p3 * 2,
      in_scale(0, (p4 % 9) & 5),
      fade_in(5, 128) * ampdbfs(-15))
  
  hexplay("a",
      "Mode1", p3 * 2,
      in_scale(1, (int(p4 / 2) % 12) & 0xfb),
      fade_in(5, 128) * ampdbfs(-15))

  hexplay("f",
      "Sub5", p3,
      in_scale(1, (p4 >> (p4 & 0x3)) % 4),
      fade_in(8, 128) * ampdbfs(-18))
  
  hexplay("a",
      "Organ2", p3 * 2,
      in_scale(1, int(p4 / 2) % 4),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("a",
      "Organ2", p3 * 2,
      in_scale(1, 2 + (int(p4 / 2) % 4) & xoscm(7, array(0xe, 0x7, 0xc))),
      fade_in(6, 128) * ampdbfs(-12))
   
endin
