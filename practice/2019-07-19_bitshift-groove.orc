; Author: Steven Yi
; Description: Bitshift Groove 
; Date: 2019-07-19

start("ReverbMixer")

set_tempo(88)

chnset(0.7, "Plk.rvb")
chnset(0.7, "Sub6.rvb")
chnset(0.7, "Sub7.rvb")
chnset(0.2, "Sub5.rvb")

instr Plucker
  chnset(random:i(0.3, 0.7), "Plk.pan")

  schedule("Plk", 0, p3 * 2, in_scale(0, p4), ampdbfs(-12))
  schedule("Plk", 0, p3 * 2, in_scale(0, p4 + 2), ampdbfs(-12))
  schedule("Plk", 0, p3 * 2, in_scale(0, p4 + 4), ampdbfs(-12))

  if(p4 < 14) then
    schedule(p1, p3, p3, p4 + 2)
  endif
endin

instr P1

  hexplay("aaa8", 
      "Organ2", p3 * 2,
      in_scale(-2, xoscb(2, array(0,4,7,11))),
      fade_in(9, 128) * ampdbfs(-12))

  hexplay("f", 
      "Sub5", p3,
      in_scale(0, (p4 >> (p4 & 0x37)) % 8),
      fade_in(12, 128) * ampdbfs(-12))

  hexplay("f", 
      "Organ1", p3,
      in_scale(-1, 4 + (p4 >> (p4 & 0x101)) % 8),
      fade_in(6, 128) * ampdbfs(-12) * choose(0.4))

  hexplay("f", 
      "Organ1", p3,
      in_scale(-1, 6 + (p4 >> (p4 & 0x6)) % 6),
      fade_in(7, 128) * ampdbfs(-12) * choose(0.4))

   if((p4 >> (p4 & 0xa3)) & 1 == 1) then
      schedule("Mode1", 0, p3, in_scale(1, 0), ampdbfs(-15))
      schedule("Mode1", 0, p3, in_scale(1, 2), ampdbfs(-15))
   endif

   if((p4 >> (p4 & 0xb7)) & 1 == 1) then
      schedule("Mode1", 0, p3, in_scale(2, 2), ampdbfs(-15))
      schedule("Mode1", 0, p3, in_scale(2, 4), ampdbfs(-15))
   endif

   if((p4 >> (p4 & 0xb7)) & 1 == 1) then
      ibase = (p4 >> (p4 & 0x47)) % 8
      schedule("Sub6", 0, p3, in_scale(1, ibase), ampdbfs(-15))
      schedule("Sub6", 0, p3, in_scale(1, ibase + 2), ampdbfs(-15))
   endif

   if((p4 >> (p4 & 0xc6)) & 1 == 1) then
      ibase = (p4 >> (p4 & 0x47)) % 8
      schedule("Sub7", 0, p3, in_scale(1, ibase), ampdbfs(-15))
      schedule("Sub7", 0, p3, in_scale(1, ibase + 2), ampdbfs(-15))
   endif

   if(p4 % 64 == 0) then
      schedule("Plucker", 0, p3 * 0.5, 0)
   endif

  hexplay("f", 
      "SynBrass", p3,
      in_scale(1, 2),
      fade_in(11, 128) * ampdbfs(xlin(phsm(8), -14, -24)))

endin

