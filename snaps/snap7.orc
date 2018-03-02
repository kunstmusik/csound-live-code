;; reset_clock()
set_tempo(122)
set_scale("min")

instr P1 

  hexplay("a000a000b6deb6de", 
      "Claves", p3, 0,
      fade_in(5, 128) * ampdbfs(xosc(phs(4), array(-12, -18, -3, -12))))
  
  hexplay("ab6aab6aa000d000",
      "Rimshot", p3,
      in_scale(-1, 0),
      fade_in(13, 128) * ampdbfs(-12))

  hexplay("deaf", 
      "HiConga", p3,
      in_scale(-1, 0),
      fade_in(16, 128) * ampdbfs(-12))
  
  hexplay("babe", 
      "LowConga", p3,
      in_scale(-1, 0),
      fade_in(17, 128) * ampdbfs(-12))
  
  hexplay("2", 
      "Cymbal", p3,
      in_scale(-1, 0),
      fade_in(20, 128) * ampdbfs(-12))
  
  hexplay("080808080808080c",
      "SD", p3,
      in_scale(-1, 0),
      ampdbfs(-6))
  
  hexplay("0008000d", 
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(21, 128) * ampdbfs(-12))

  hexplay("8888888a",
      "BD", p3,
      in_scale(-1, 0),
      ampdbfs(-3))

endin
