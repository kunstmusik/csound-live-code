;; Author: Steven Yi
;; Description: Improvisatory feel
;; Date: 2020.01.07

start("ReverbMixer")

set_tempo(125)
xchnset("rvb.default", 0.2)
xchnset("drums.rvb.default", 0.2)
xchnset("Organ1.rvb", 0.7)
xchnset("Organ2.rvb", 0.2)

instr P1
  
  if(hexbeat("f") == 1) then
    ibase = cycle(p4 % 17 % 11, array(0,2,1,3,4))
    schedule("Mode1", 0, p3, in_scale(0, ibase), ampdbfs(-17))
    schedule("Mode1", 0, p3, in_scale(0, ibase + 4), ampdbfs(-17))    
    schedule("Mode1", 0, p3, in_scale(0, ibase + 6), ampdbfs(-17))        
  endif
  
  hexplay("f",
      "Sub6", p3,
      in_scale(-1, 4 + cycle(p4 % 17 % 11, array(0,2,1,3,4))),
      fade_in(12, 128) * ampdbfs(-20))

  hexplay("f",
      "Sub7", p3,
      in_scale(0, 6 + cycle(p4 % 19 % 11, array(0,2,1,3,4))),
      fade_in(13, 128) * ampdbfs(-17))
  
  hexplay("f",
      "Organ2", p3,
      in_scale(-2, cycle(p4 % 23 % 17, array(0,2,1,3,4))),
      fade_in(16, 128) * ampdbfs(-12))
  
  hexplay("ff00000",
      "Organ2", p3,
      in_scale(-2, 4 + cycle(p4 % 23 % 17, array(0,2,1,3,4))),
      fade_in(16, 128) * ampdbfs(-15))
  
  hexplay("ff000",
      "Organ2", p3,
      in_scale(rand(array(-2, -1)), 8 + cycle(p4 % 23 % 17, array(0,2,1,3,4))),
      fade_in(16, 128) * ampdbfs(-15))

  hexplay("9000d000",
      "Sub2", p3,
      in_scale(-1, 0),
      fade_out(5, 128) * ampdbfs(-12))
  
  hexplay("2a2aa",
      "Sub2", p3,
      in_scale(-1, (p4 << (p4 & 0x5)) & 0x17),
      fade_out(7, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Square", p3,
      in_scale(-1, 1 + (p4 << (p4 & 0x2)) & 0x15),
      fade_out(11, 128) * ampdbfs(-18))

  hexplay("fe00000",
      "Organ1", p3,
      in_scale(rand(array(-1, 0)), 8 + cycle(p4 % 23 % 17, array(0,2,1,3,4))),
      fade_in(15, 128) * ampdbfs(-12))

  hexplay("fe000",
      "Organ1", p3,
      in_scale(rand(array(-1, 0)), 6 + cycle(p4 % 23 % 17, array(0,2,1,3,4))),
      fade_in(15, 128) * ampdbfs(-12))
  
  hexplay("3fe000",
      "Organ1", p3,
      in_scale(rand(array(0, 1)), 4 + cycle(p4 % 31 % 23 % 17, array(0,2,1,3,4))),
      fade_in(15, 128) * ampdbfs(-12))

endin
