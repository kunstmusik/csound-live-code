start("ReverbMixer")
xchnset("Reverb.fb", 0.85)

xchnset("Organ3.rvb", 0.5)
xchnset("Bass.rvb", 0.4)
xchnset("Sub5.rvb", 0.3)

instr P1
  
  io = cycle(p4 % 127 % 13, array(-1,0,1))
  ih = cycle((p4 / 4) % 64 % 37 % 17, array(0,4,2,3))
  
  iv = (p4 & p4 >> (p4 >> 2) % 5) % 11
  hexplay("C8F729B4AFCbf8Cb1f2F969511c684925Bc1034B",
      "Organ3", p3,
      in_scale(-1 + io, iv + ih),
      fade_in(5, 128) * ampdbfs(-18))
  
  iv = iv % 5
  
  hexplay("BC8F729B4AFCbf8Cb1f2F969511c684925Bc1034",
      "Organ3", p3,
      in_scale(io, iv + ih),
      fade_in(6, 128) * ampdbfs(-18))
  
  hexplay("8020",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("08",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("9200",
      "Bass", p3,
      in_scale(-2, ih),
      fade_in(9, 128) * ampdbfs(-6))

  hexplay("92",
      "Sub5", p3,
      in_scale(2, hexbeat("f3e") * 2 + hexbeat("f1c0") * 2),
      fade_in(10, 128) * ampdbfs(xlin(phsm(8), -24, -18)))

endin