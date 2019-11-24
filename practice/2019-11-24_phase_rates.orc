;; Author: Steven Yi
;; Description: Experimenting with phase rates (p4) and bitshifts
;; Date: 2019.11.24

start("ReverbMixer")

xchnset("rvb.default", 0.3)

instr P1
 
    hexplay("ff00",
      "Sub5", p3,
      in_scale(0, xoscm(8, array(2,4,6,7)) + (p4 / 2 << (p4 / 3 & 0x3)) % 11),
      fade_in(6, 128) * ampdbfs(-12))
  
   hexplay("ff000",
      "Sub5", p3,
      in_scale(0, 2 + xoscm(8, array(2,4,6,7)) + (p4 << (p4 / 6 & 0x3)) % 11),
      fade_in(6, 128) * ampdbfs(-12))
  
   hexplay("3fc000",
      "Sub5", p3,
      in_scale(0, 4 + xoscm(8, array(2,4,6,7)) + (p4 / 3 << (p4 / 2 & 0x3)) % 11),
      fade_in(6, 128) * ampdbfs(-12))
  
endin
