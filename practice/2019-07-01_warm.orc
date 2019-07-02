; Author: Steven Yi
; Description: Warm
; Date: 2019-07-01

start("ReverbMixer")

chnset(0.6, "Sub6.rvb")
chnset(0.6, "Sub7.rvb")

instr P1

  if((p4 >> (p4 & 0xbc)) & 1 == 1) then
      schedule("Organ2", 0, p3 * 4, in_scale(0, (p4 >> (p4 & 0x71)) % 5), ampdbfs(-8))
      schedule("Organ2", 0, p3 * 4, in_scale(0, 2 + (p4 >> (p4 & 0x71)) % 5), ampdbfs(-8))
  endif

  if((p4 >> (p4 & 0xcb)) & 1 == 1) then
      schedule("Mode1", 0, p3 * 4, in_scale(2, (p4 >> (p4 & 0x71)) % 5), ampdbfs(-15))
      schedule("Mode1", 0, p3 * 4, in_scale(2, 2 + (p4 >> (p4 & 0x71)) % 5), ampdbfs(-15))
  endif

  if((p4 >> (p4 & 0xcbc)) & 1 == 1) then
      schedule("Mode1", 0, p3 * 4, in_scale(1, (p4 >> (p4 & 0x71)) % 5), ampdbfs(-15))
      schedule("Mode1", 0, p3 * 4, in_scale(1, 2 + (p4 >> (p4 & 0x71)) % 5), ampdbfs(-15))
  endif

  if((p4 >> (p4 & 0x1f)) & 1 == 1) then
      schedule("Mode1", 0, p3 * 4, in_scale(1, 4 + (p4 >> (p4 & 0x71)) % 5), ampdbfs(-15))
      schedule("Mode1", 0, p3 * 4, in_scale(1, 6 + (p4 >> (p4 & 0x71)) % 5), ampdbfs(-15))
  endif

  idur = dur_seq(array(7,-2,6,3,-1,9))
  if(idur > 0) then
      schedule("Organ2", 0, ticks(idur), in_scale(1, 2 + (p4 >> (p4 & 0xba)) % 4), ampdbfs(-8))
  endif
 
  idur = dur_seq(array(6,3,-1,9, 7, -2))
  if(idur > 0) then
      schedule("Organ2", 0, ticks(idur), in_scale(1, 4 + (p4 >> (p4 & 0xab)) % 4), ampdbfs(-8))
  endif

  hexplay("b8ca3993ac8b", 
      "Sub5", p3,
      in_scale(0, 2),
      fade_in(13, 128) * ampdbfs(-12))

  hexplay("a3993ac8bb8c", 
      "Sub5", p3,
      in_scale(0, 4),
      fade_in(13, 128) * ampdbfs(-12))

  hexplay("93ac8bb8ca39", 
      "Sub5", p3,
      in_scale(0, 6),
      fade_in(13, 128) * ampdbfs(-12))

  hexplay("f", 
      "Sub5", p3,
      in_scale(1, xoscb(1, array(2,6,9,13))),
      fade_in(14, 128) * ampdbfs(-12))

  hexplay("f", 
      "Sub6", p3,
      in_scale(2, (p4 >> (p4 & 0x23)) % 4),
      fade_in(15, 128) * ampdbfs(-12) * choose(0.5))

  hexplay("f", 
      "Sub7", p3,
      in_scale(2, 4 + (p4 >> (p4 & 0x32)) % 4),
      fade_in(15, 128) * ampdbfs(-12) * choose(0.2))

endin

