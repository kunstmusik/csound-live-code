;; Author: Steven Yi
;; Description: Rhythm
;; Date: 2020.01.10

start("ReverbMixer")

xchnset("rvb.default", 0.2)
xchnset("Organ1.rvb", 0.5)
xchnset("Organ2.rvb", 0.5)
xchnset("Sub7.rvb", 0.5)


instr P1

  if(hexbeat("f") == 1) then
    ibase = p4 / 2 % 17 % 11 % 4
    ioct = 0 + (p4 / 2 << (p4 / 2 & 0x7)) % 2 
    schedule("Sub6", 0, p3, in_scale(ioct, ibase), ampdbfs(-18))
    schedule("Sub6", 0, p3, in_scale(ioct, ibase + 4), ampdbfs(-18))
    schedule("Sub6", 0, p3, in_scale(ioct, ibase + 8), ampdbfs(-18))
  endif
  
  hexplay("f",
      "Sub5", p3,
      in_scale(1, hexbeat("043fd3") * 4 + cycle(p4 % 19 % 7, array(0,7,4,7,2,4))),
      fade_in(15, 128) * ampdbfs(-12))
  
  hexplay("a222",
      "Sub5", p3,
      in_scale(2, xoscb(4, array(0,4,2,3))),
      fade_in(14, 128) * ampdbfs(-9))
  
  hexplay("f",
      "Organ2", p3,
      in_scale(-2, hexbeat("02848a934") * 2 + cycle(p4 % 41 % 17 % 7, array(4,2,3,1,0))),
      fade_in(16, 128) * ampdbfs(-8))
  
  hexplay("f",
      "Organ1", p3 * 0.9,
      in_scale(0, hexbeat("02848a934") * 2 + cycle(p4 % 43 % 17 % 7, array(4,2,3,1,0))),
      fade_in(7, 128) * ampdbfs(-9))
  
  hexplay("f",
      "Organ1", p3 * 0.9,
      in_scale(0, 2 + hexbeat("34003407") * 4 + cycle(p4 % 43 % 17 % 7, array(4,2,3,1,0))),
      fade_in(7, 128) * ampdbfs(-9))
  
  hexplay("f",
      "Organ1", p3 * 0.9,
      in_scale(0, 4 + hexbeat("003420") * 2 + cycle(p4 % 43 % 17 % 7, array(4,2,3,1,0))),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Organ2", p3,
      in_scale(-1 + hexbeat("03430") + 2, (p4 << (p4 & 0x5)) % 9),
      fade_in(10, 128) * ampdbfs(-9))
  
  hexplay("f",
      "Organ2", p3,
      in_scale(-1 + hexbeat("0174003"), 2 + (p4 << (p4 & 0xb)) % 11),
      fade_in(11, 128) * ampdbfs(-8))

endin

;; fade_out_mix()
