;; Author: Steven Yi
;; Description: Groove
;; Date: 2020-02-19

start("ReverbMixer")

xchnset("rvb.default", 0.2)

instr P1
  hexdirt("8",
      "bd:0", 
      fade_in(5, 128) * ampdbfs(-12))

  hexdirt("2",
      "808:1", 
      fade_in(6, 128) * ampdbfs(-12))
  
  hexdirt("08",
      "808:3", 
      fade_in(7, 128) * ampdbfs(-12))

  hexdirt("80808220",
      "jvbass", 
      fade_in(8, 128) * ampdbfs(-12))
  
  hexplay("a222", 
      "Bass", p3,
      from_root(1, 0) * xlin(phsm(1), 1.05, 1),
      fade_in(9, 128) * ampdbfs(-12))

  hexdirt("9222922c",
      "808mt", 
      fade_in(13, 128) * ampdbfs(-12))

  SVals[] fillarray "gabba:2", "gabba:1", "psr:4"
  hexdirt("823fdfd832348",
      SVals[p4 % lenarray(SVals)], 
      fade_in(11, 128) * ampdbfs(-12))


endin

