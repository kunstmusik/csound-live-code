; Author: Steven Yi
; Description: End state from live code practice (see recording on Youtube)
; Date: 2019-07-22

start("ReverbMixer")

set_tempo(92)

chnset(0.7, "Sub6.rvb")
chnset(0.7, "Sub7.rvb")

chnset(0.3, "Sub2.pan")
chnset(0.7, "Organ1.pan")

instr P1

  if( (p4 >> (p4 & 0x16)) & 1 == 1) then
    ibase = (p4 >> (p4 & 0x17)) % 4
    schedule("Organ2", 0, p3, in_scale(-1, ibase), ampdbfs(-12))
  endif

  if( (p4 >> (p4 & 0x16)) & 2 == 2) then
    ibase = 4 + (p4 >> (p4 & 0x17)) % 4
    schedule("Organ2", 0, p3, in_scale(-1, ibase), ampdbfs(-12))
  endif


  hexplay("f", 
      "Sub5", p3,
      in_scale(0, (p4 >> (p4 & 0x27)) % 8),
      fade_in(7, 128) * ampdbfs(-12) * choose(0.6))


  if( (p4 >> (p4 & 0x47)) & 1 == 1) then
    ibase = (p4 >> (p4 & 0x38)) % 8
    schedule("Mode1", 0, p3, in_scale(0, ibase), ampdbfs(-12))
    schedule("Mode1", 0, p3, in_scale(0, 2 + ibase), ampdbfs(-12))
  endif

  if( (p4 >> (p4 & 0x56)) & 1 == 1) then
    ibase = (p4 >> (p4 & 0x38)) % 8
    schedule("Mode1", 0, p3, in_scale(1, ibase), ampdbfs(-14))
    schedule("Mode1", 0, p3, in_scale(1, 2 + ibase), ampdbfs(-14))
  endif

  if( (p4 >> (p4 & 0x56)) & 2 == 2) then
    ibase = (p4 >> (p4 & 0x38)) % 8
    schedule("Sub6", 0, p3, in_scale(0, ibase), ampdbfs(-18))
    schedule("Sub6", 0, p3, in_scale(0, 2 + ibase), ampdbfs(-18))
  endif

  if( (p4 >> (p4 & 0x47)) & 2 == 2) then
    ibase = (p4 >> (p4 & 0x38)) % 8
    schedule("Sub7", 0, p3, in_scale(1, 4 + ibase), ampdbfs(-19))
    schedule("Sub7", 0, p3, in_scale(1, 6 + ibase), ampdbfs(-19))
  endif

  hexplay("f", 
      "Mode1", p3,
      in_scale(1, 4),
      fade_in(9, 128) * ampdbfs(xoscim(8, array(-24, -18))))

  hexplay("8000", 
      "Mode1", p3 * 8,
      in_scale(0, 4),
      fade_out(9, 128) * ampdbfs(-12))

  hexplay("f", 
      "Organ2", p3,
      in_scale(-2, xoscm(32, array(0,2,3,4))),
      fade_out(10, 128) * ampdbfs(xoscim(8, array(-24, -18))))

endin

;fade_out_mix()
