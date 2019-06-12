; Author: Steven Yi
; Description: Minimal
; Date: 2019-06-11

start("ReverbMixer")

chnset(0.55, "Organ2.pan")
chnset(0.6, "VoxHumana.rvb")

instr P1
  hexplay("a",
      "Organ2", p3 * 2,
      in_scale(-1, xoscb(2, array(7,6,3,4))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("8008",
      "Organ2", p3 * 4,
      in_scale(0, xoscb(4, array(7,6,3,4))),
      fade_in(6, 128) * ampdbfs(-9))

  hexplay("f",
      "Organ2", p3,
      in_scale(-2, xoscb(2, array(7,6,3,4))),
      fade_in(7, 128) * ampdbfs(-14))
  
  hexplay("f",
      "Organ2", p3,
      in_scale(0, xoscb(2, array(7,6,3,4)) + xoscb(3.7, array(0,4,7,4))),
      fade_in(8, 128) * ampdbfs(-12) * choose(0.7))

  chnset(random:i(0.2, 0.8), "Mode1.pan")
  
  hexplay("f",
      "Mode1", p3,
      in_scale(0, 4 + xoscb(2, array(7,6,3,4)) + xoscb(3.7, array(0,4,7,4))),
      fade_in(9, 128) * ampdbfs(-14) * choose(0.5))
  
  hexplay("f",
      "Mode1", p3,
      in_scale(0, 6 + xoscb(2, array(7,6,3,4)) + xoscb(3.7, array(0,4,7,4))),
      fade_in(14, 128) * ampdbfs(-12) * choose(0.5))
 
  hexplay("8000c000",
      "Organ2", p3,
      in_scale(-2, 0),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("8000c000",
      "Sub6", p3,
      in_scale(-1, 0),
      fade_in(12, 128) * ampdbfs(-14))

  hexplay("a",
      "Sine", p3 * 3,
      in_scale(2, 0),
      fade_in(13, 128) * ampdbfs(-12))

  hexplay("f800",
      "Sub5", p3,
      in_scale(0, xoscb(2, array(0,4,7,11,14,11,7,4))),
      fade_in(15, 128) * ampdbfs(-12))

  hexplay("f80",
      "Sub5", p3,
      in_scale(1, xoscb(1.7, array(0,4,7,11,14,11,7,4))),
      fade_in(15, 128) * ampdbfs(-12))
 
  hexplay("f8",
      "Sub5", p3,
      in_scale(2, xoscb(1.6, array(0,4,7,11,14,11,7,4))),
      fade_in(15, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Sub5", p3,
      in_scale(1, xoscb(2, array(0,4,7,11,14,11,7,4))),
      fade_in(15, 128) * ampdbfs(-12))
  
  if(p4 % 16 == 0 && choose(0.7) == 1) then
    ibase = rand(array(0,2,4,6))
    schedule("VoxHumana", 0, measures(2), in_scale(1, ibase), ampdbfs(-9)) 
    schedule("VoxHumana", 0, measures(2), in_scale(1, ibase + 4), ampdbfs(-11))     
  endif

endin
