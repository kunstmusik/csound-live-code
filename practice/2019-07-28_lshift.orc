; Author: Steven Yi
; Description: Practicing with left bitshifts
; Date: 2019-07-28


start("ReverbMixer")

set_tempo(94)

chnset(0.8, "Sub6.rvb")
chnset(0.8, "Sub7.rvb")

instr P1
  hexplay("f",
      "Sub6", p3,
      in_scale(0, (p4 << (p4 & 0x2)) % 13),
      fade_in(5, 128) * ampdbfs(-14))

  if( (p4 << (p4 & 0x2)) & 8 == 8) then
    schedule("Mode1", 0, p3, in_scale(1,2), ampdbfs(-18))
    schedule("Mode1", 0, p3, in_scale(1,4), ampdbfs(-18))
  endif
  
   if( (p4 >> (p4 & 0x7)) & 2 == 2) then
    schedule("Mode1", 0, p3, in_scale(1,6), ampdbfs(-18))
    schedule("Mode1", 0, p3, in_scale(1,8), ampdbfs(-18))
  endif

  hexplay("f",
      "Sub5", p3,
      in_scale(-2, (p4 << (p4 & 0x1c)) % 7),
      fade_in(8, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Sub5", p3,
      in_scale(1, 2 + (p4 << (p4 & 0x1c)) % 7),
      fade_in(12, 128) * ampdbfs(-12))

endin




