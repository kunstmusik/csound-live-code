reset_clock()
set_tempo(118)

instr P1 
  ibeat = p4
  
  hexplay("e0e0e0ff", ibeat,
      "FM1", p3,
      in_scale(-2, 0),
      fade_in(9, 128) * ampdbfs(-12))
  
  hexplay(strcat(strrep("a888", 3), "ab6d"), ibeat,
      "Claves", p3, 0,
      fade_in(5, 128) * ampdbfs(xosc(bphs(ibeat, 4), array(-12, -18, -3, -12))))
  
  hexplay(strcat("ffff", strrep("b6de", 3)), ibeat,
      "Rimshot", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay(strcat(strrep("0808", 3), "080d"), ibeat,
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("08", ibeat,
      "SD", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))
  
  hexplay("8020", ibeat, 
      "BD", p3, 0,
      fade_in(4, 128) * ampdbfs(-3))

endin


