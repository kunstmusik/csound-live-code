;; Author: Steven Yi
;; Description: Light 
;; Date: 2020.04.06

start("ReverbMixer")
xchnset("SynHarp.rvb", 0.5)

instr P1
    
  io = xoscm(4, array(0,4,3,1,2,3,2,4))
  
  iv = xlin(phsb(2), 0, 14)
  hexplay("ff0000",
      "SynHarp", p3,
      in_scale(0, iv + io),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("3fc00",
      "SynHarp", p3,
      in_scale(0, iv + 2 + io),
      fade_in(8, 128) * ampdbfs(-12))
  
  iv = cycle(p4 % 17 % 11, array(0,2,3,5,4,3,1,2))
  hexplay("f",
      "SynHarp", p3,
      in_scale(1, iv + io),
      fade_in(6, 128) * ampdbfs(-13))
  
  iv = xlin(phsb(7), 0, 4)
  hexplay("f3942bde",
      "Squine1", p3,
      in_scale(1, 2 + io + iv),
      fade_in(9, 128) * ampdbfs(-15))
  
  iv = cycle(p4 % 61 % 47 % 13, array(0,4,7,4,2,3))
  hexplay("f",
      "Bass", p3,
      in_scale(-2, iv + io),
      fade_in(10, 128) * ampdbfs(-9))

  iv = cycle(p4 % 23 % 17, array(0,2,3,5,4,3,1,2))
  hexplay("f",
      "Organ3", p3,
      in_scale(0, iv + 2 + io),
      fade_in(7, 128) * ampdbfs(-15))

endin
