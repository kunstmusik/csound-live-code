; Author: Steven Yi
; Description: Dance
; Date: 2019-06-27

chnset(0.7, "Sub6.rvb")
chnset(0.7, "Sub7.rvb")
chnset(0.5, "ms20_bass.rvb")


start("ReverbMixer")
instr P1
  
  hexplay("9280000000000000",
      "Sub6", p3,
      in_scale(0, xoscm(1, array(-1,-1,0,0))),
      fade_in(16, 128) * ampdbfs(-12))
 
  hexplay("0092800000000000",
      "Sub7", p3,
      in_scale(1, xoscm(1, array(0,0,-1,-1))),
      fade_in(17, 128) * ampdbfs(-12))
  
  hexplay("f",
      "FM1", p3,
      in_scale(-2, xoscb(1.7, array(0,7,2,4))),
      fade_in(13, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Organ2", p3,
      in_scale(1, xoscb(1, array(0,4,7,4))),
      fade_in(15, 128) * ampdbfs(-12))
  
  hexplay("f000",
      "Sub1", p3,
      in_scale(2, 0),
      fade_in(21, 128) * ampdbfs(-12))
  
  hexplay("92",
      "ms20_bass", p3 * 3,
      in_scale(1, xlin(phsm(2), 14, 0)),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-6))

  euclidplay(13, 32,
      "Claves", p3,
      in_scale(-1, 0),
      fade_in(20, 128) * ampdbfs(-12))
  
  hexplay("0000a800a800a800",
      "SSaw", p3,
      in_scale(0, 0),
      fade_in(23, 128) * ampdbfs(-12))

endin
