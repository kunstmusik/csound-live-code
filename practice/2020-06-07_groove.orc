;; Author: Steven Yi
;; Date: 2020.06.07
;; Description: A nice funky groove... :) 

start("ReverbMixer")

instr P1
  
  iv = (p4 << 3) # p4
  iv = iv % 5
  Svals2[] fillarray "MidConga", "HiConga", "HiConga", "Claves", ""
  hexplay("f",
      Svals2[iv], p3,
      in_scale(1, 0),
      fade_in(8, 128) * ampdbfs(-9))
  
  iv = (p4 << 2) # p4
  iv = iv % 64 % 5
  Svals[] fillarray "Square", "SSaw", "Sub4", "Saw", "Squine1"
  hexplay("f",
      Svals[iv], p3,
      in_scale(rand(array(-1,1,2)), cycle(p4 % 64 % 33 % 17, array(0,4,7,11,7,5,6,2,3))),
      fade_in(9, 128) * ampdbfs(-12))
  
  hexplay("08",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(xsin(phsm(8), -20, 10)))

  hexplay("c0",
      "Bass", p3,
      in_scale(-2, xoscm(2, array(0,2,4,7))),
      fade_in(5, 128) * ampdbfs(-12))

  
  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-3))

  hexplay("2",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(xlin(phsm(4), -12, -18)))

  
  
endin
