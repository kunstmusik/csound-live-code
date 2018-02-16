reset_clock()
set_tempo(118)
set_scale("min")

instr P1 
  hexplay("e0e0e0ff",
      "FM1", p3,
      in_scale(-2, 0),
      fade_in(9, 128) * ampdbfs(-12))
  
  hexplay(strcat(strrep("a888", 3), "ab6d"),
      "Claves", p3, 0,
      fade_in(5, 128) * ampdbfs(xosc(phs(4), array(-12, -18, -3, -12))))
  
  hexplay(strcat("ffff", strrep("b6de", 3)),
      "Rimshot", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay(strcat(strrep("0808", 3), "080d"),
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("08",
      "SD", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))
  
  hexplay("8020", 
      "BD", p3, 0,
      fade_in(4, 128) * ampdbfs(-3))

endin


